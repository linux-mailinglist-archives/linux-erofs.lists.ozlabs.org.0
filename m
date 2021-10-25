Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AEA438CC2
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Oct 2021 02:13:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HcwR2208fz2xtF
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Oct 2021 11:13:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131;
 helo=out30-131.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HcwQr3GDxz2xYJ
 for <linux-erofs@lists.ozlabs.org>; Mon, 25 Oct 2021 11:13:21 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0UtUYDQq_1635120782; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UtUYDQq_1635120782) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 25 Oct 2021 08:13:03 +0800
Date: Mon, 25 Oct 2021 08:12:55 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [PATCH] erofs: get rid of ->lru usage
Message-ID: <YXX2h26Fm/hztdaZ@B-P7TQMD6M-0146.local>
References: <20211022090120.14675-1-hsiangkao@linux.alibaba.com>
 <YXWQ6p4Hlx6tGpPN@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YXWQ6p4Hlx6tGpPN@moria.home.lan>
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Matthew Wilcox <willy@infradead.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, Oct 24, 2021 at 12:59:22PM -0400, Kent Overstreet wrote:
> On Fri, Oct 22, 2021 at 05:01:20PM +0800, Gao Xiang wrote:
> > Currently, ->lru is a way to arrange non-LRU pages and has some
> > in-kernel users. In order to minimize noticable issues of page
> > reclaim and cache thrashing under high memory presure, limited
> > temporary pages were all chained with ->lru and can be reused
> > during the request. However, it seems that ->lru could be removed
> > when folio is landing.
> > 
> > Let's use page->private to chain temporary pages for now instead
> > and transform EROFS formally after the topic of the folio / file
> > page design is finalized.
> > 
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Kent Overstreet <kent.overstreet@gmail.com>
> > Cc: Chao Yu <chao@kernel.org>
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Would it not be an option to use an array of pointers to pages, instead of a
> linked list? Arrays are faster than lists, and page->private is another thing we
> prefer not to use if we don't have to.

Our requirement is to maintain variable-sized temporary pages, that
may be short or maybe long during decompression process (according to
different algorithms and whether it's inplace I/O or not) rather than
before I/O submission:

 For LZ4, that maybe 16 pages for lz4 sliding window and other
temporary pages;
 For LZMA, since it has a internal dictionary (sliding window) so we
don't have to allocate any temporary pages for cached decompression
(outplace I/O), but we still need allocating temporary pages to
handle overlapped decompression due to inplace I/O (think about it,
if each compressed pcluster is 4pages -- 16KiB, we have to allocate
for example another 128KiB compressed pages due to read request for
outplace I/O, but instead 0 pages for inplace I/O during I/O process,
and only 4 pages for decompression process. It saves much memory in
the low memory scenarios by using inplace I/O and important to the
performance).

Currently we only add some page to the head or pick some page from
head, so a singly-linked list is also fine to us for now.

> 
> That said - this is definitely preferable to using page->lru - thank you.
> 
> Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>

Thank you!

Thanks,
Gao Xiang

