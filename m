Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC47603863
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Oct 2022 05:07:18 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MsbHl68Vtz3c29
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Oct 2022 14:07:15 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.56; helo=out30-56.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MsbHc0VDmz2xjr
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Oct 2022 14:07:06 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VSYayHV_1666148819;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VSYayHV_1666148819)
          by smtp.aliyun-inc.com;
          Wed, 19 Oct 2022 11:07:01 +0800
Date: Wed, 19 Oct 2022 11:06:58 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v2] erofs: use kmap_local_page() only for erofs_bread()
Message-ID: <Y09p0hTSxeUPgLsJ@B-P7TQMD6M-0146.local>
References: <20221018105313.4940-1-hsiangkao@linux.alibaba.com>
 <9108233.CDJkKcVGEf@mypc>
 <Y08asdeoz5yOAefN@B-P7TQMD6M-0146.lan>
 <2019477.yKVeVyVuyW@mypc>
 <Y084l0m88JGOqGRN@B-P7TQMD6M-0146.lan>
 <Y09mS6LrHCGmi+AJ@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y09mS6LrHCGmi+AJ@iweiny-desk3>
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
Cc: linux-erofs@lists.ozlabs.org, "Fabio M. De Francesco" <fmdefrancesco@gmail.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Ira,

On Tue, Oct 18, 2022 at 07:51:55PM -0700, Ira Weiny wrote:
> On Wed, Oct 19, 2022 at 07:36:55AM +0800, Gao Xiang wrote:
> > On Wed, Oct 19, 2022 at 01:21:27AM +0200, Fabio M. De Francesco wrote:
> > > On Tuesday, October 18, 2022 11:29:21 PM CEST Gao Xiang wrote:
> > 
> > ...
> 
> [snip]
> 
> > > 
> > > In Btrfs I solved (thanks to David S.' advice) by mapping only one of two 
> > > pages, only the one coming from the page cache. 
> > > 
> > > The other page didn't need the use of kmap_local_page() because it was 
> > > allocated in the filesystem with "alloc_page(GFP_NOFS)". GFP_NOFS won't ever 
> > > allocate from ZONE_HIGHMEM, therefore a direct page_address() could avoid the 
> > > mapping and the nesting issues.
> > > 
> > > Did you check if you may solve the same way? 
> > 
> > That is not simple.  Currently we have compressed pages and decompressed
> > pages (page cache or others), and they can be unmapped when either data
> > is all consumed, so compressed pages can be unmapped first, or
> > decompressed pages can be unmapped first.  That quite depends on which
> > pages goes first.
> > 
> > I think such usage is a quite common pattern for decoder or encoder,
> > you could take a look at z_erofs_lzma_decompress() in
> > fs/erofs/decompressor_lzma.c.  So kmap() is still useful for such cases
> > since I don't really care the HIGHMEM performance but correctness, but
> > other alternative could churn/complex the map/unmap/remap pattern.
> > 
> 
> When you say kmap() is still useful is this because of the map/unmap ordering
> restrictions or because the address is required in different threads?

... mainly due to map/unmap ordering restriction. I think
the decompressor here could still be a simple dependency.  I'm not
sure if there are more complicated cases (like multiple
decoding/encoding sources into target pages) though..

Thanks,
Gao Xiang

> 
> Ira
