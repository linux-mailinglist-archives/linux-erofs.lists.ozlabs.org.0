Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FB443C3FD
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Oct 2021 09:35:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HfL8034lfz2xXc
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Oct 2021 18:35:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54;
 helo=out30-54.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HfL7t2LHVz2xXb
 for <linux-erofs@lists.ozlabs.org>; Wed, 27 Oct 2021 18:35:17 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=6; SR=0; TI=SMTPD_---0Uts4Xub_1635320099; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0Uts4Xub_1635320099) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 27 Oct 2021 15:35:00 +0800
Date: Wed, 27 Oct 2021 15:34:58 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [RFC PATCH 1/2] erofs-utils: support tail-packing inline
 compressed data
Message-ID: <YXkBIpcCG12Y8qMN@B-P7TQMD6M-0146.local>
References: <cover.1635162978.git.huyue2@yulong.com>
 <9adbee63d0bfb18ec3f8de66d196f8ffee483226.1635162978.git.huyue2@yulong.com>
 <YXft5YhayWvt3DPM@B-P7TQMD6M-0146.local>
 <20211027095452.00006c1e.zbestahu@gmail.com>
 <20211027152137.000043e5.zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211027152137.000043e5.zbestahu@gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org, Yue Hu <huyue2@yulong.com>,
 geshifei@yulong.com, zhangwen@yulong.com, shaojunjun@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yue,

On Wed, Oct 27, 2021 at 03:21:37PM +0800, Yue Hu wrote:

...

> > > > -		if (len <= pclustersize) {
> > > > +		if (!tail_pcluster && len <= pclustersize) {
> > > >  			if (final) {
> > > > -				if (len <= EROFS_BLKSIZ)
> > > > +				if (erofs_sb_has_tailpacking()) {
> > > > +					tail_pcluster = true;
> > > > +					pclustersize = EROFS_BLKSIZ;  
> > > 
> > > Not quite sure if such condition can be trigged for many times...
> > > 
> > > Think about it. If the original pclustersize == 16 * EROFS_BLKSIZ, so we
> > > could have at least 16 new pclustersize == EROFS_BLKSIZ then?
> > > 
> > > But only the last pclustersize == EROFS_BLKSIZ can be inlined...
> > 
> > Let me think about it more.
> 
> I understand we need to compress the tail pcluster(len <= pclustersize) by destsize
> of fixed 4KB to get better inline result. rt?

I think this is the tricky part of tail-packing inline support for
compressed data.

As you may know, EROFS supports variable-sized blocks for each pcluster
so you could change pclustersize accordingly for the last pclusters.

For example, originally if the size of the last one pcluster is
16 * EROFS_BLKSIZ (therefore it cannot be tail-packing directly), there
are 2 policies in practice can be achieved:
 1) compress with 2 pclusters ---
      X pcluster size + Y (Y <= 4KiB) pcluster size (so the last one can
   be tail-packing);
 2) compress with 4KiB pclusters ---
      4KiB pcluster + 4KiB pcluster + ... + Z (Z <= 4KiB) pcluster

I'm not sure which one is easier to implement, maybe 2) is easier, so we
could implement it first.

Thanks,
Gao Xiang

