Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A08F3D441B
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Jul 2021 02:54:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GWnlH0K3pz30JP
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Jul 2021 10:54:35 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GWnlC0Cnhz30Dq
 for <linux-erofs@lists.ozlabs.org>; Sat, 24 Jul 2021 10:54:27 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=8; SR=0; TI=SMTPD_---0UgkuJRR_1627088050; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UgkuJRR_1627088050) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 24 Jul 2021 08:54:12 +0800
Date: Sat, 24 Jul 2021 08:54:10 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v7] iomap: make inline data support more flexible
Message-ID: <YPtksjmvVbcsKwlK@B-P7TQMD6M-0146.local>
Mail-Followup-To: Matthew Wilcox <willy@infradead.org>,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 "Darrick J . Wong" <djwong@kernel.org>,
 Andreas Gruenbacher <andreas.gruenbacher@gmail.com>,
 Huang Jianan <huangjianan@oppo.com>
References: <20210723174131.180813-1-hsiangkao@linux.alibaba.com>
 <YPsbQzcNz+r4V7P2@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPsbQzcNz+r4V7P2@casper.infradead.org>
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
Cc: "Darrick J . Wong" <djwong@kernel.org>,
 Andreas Gruenbacher <andreas.gruenbacher@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Matthew,

On Fri, Jul 23, 2021 at 08:40:51PM +0100, Matthew Wilcox wrote:
> On Sat, Jul 24, 2021 at 01:41:31AM +0800, Gao Xiang wrote:
> > Add support for reading inline data content into the page cache from
> > nonzero page-aligned file offsets.  This enables the EROFS tailpacking
> > mode where the last few bytes of the file are stored right after the
> > inode.
> > 
> > The buffered write path remains untouched since EROFS cannot be used
> > for testing. It'd be better to be implemented if upcoming real users
> > care and provide a real pattern rather than leave untested dead code
> > around.
> 
> My one complaint with this version is the subject line.  It's a bit vague.
> I went with:
> 
> iomap: Support file tail packing
> 
> I also wrote a changelog entry that reads:
>     The existing inline data support only works for cases where the entire
>     file is stored as inline data.  For larger files, EROFS stores the
>     initial blocks separately and then can pack a small tail adjacent to
>     the inode.  Generalise inline data to allow for tail packing.  Tails
>     may not cross a page boundary in memory.
>

Yeah, we could complete the commit message like this.

Actually EROFS inode base is only 32-byte or 64-byte (so the maximum could
not be exactly small), compared to using another tail block or storing other
(maybe) irrelevant inodes. According to cache locality principle, a strategy
can be selected by mkfs to load tail block with the inode base itself to the
page cache by the tail-packing inline and so reduce I/O and fragmentation.

> ... but I'm not sure that's necessarily better than what you've written
> here.
> 
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Darrick J. Wong <djwong@kernel.org>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
> > Tested-by: Huang Jianan <huangjianan@oppo.com> # erofs
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Many thanks for the review!

Thanks,
Gao Xiang

