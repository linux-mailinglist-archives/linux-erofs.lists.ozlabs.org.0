Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 817646036B1
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Oct 2022 01:37:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MsVdM2XZ1z3bY8
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Oct 2022 10:37:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MsVdC6fl4z2xG8
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Oct 2022 10:37:02 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VSXenhN_1666136216;
Received: from B-P7TQMD6M-0146.lan(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VSXenhN_1666136216)
          by smtp.aliyun-inc.com;
          Wed, 19 Oct 2022 07:36:58 +0800
Date: Wed, 19 Oct 2022 07:36:55 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH v2] erofs: use kmap_local_page() only for erofs_bread()
Message-ID: <Y084l0m88JGOqGRN@B-P7TQMD6M-0146.lan>
References: <20221018105313.4940-1-hsiangkao@linux.alibaba.com>
 <9108233.CDJkKcVGEf@mypc>
 <Y08asdeoz5yOAefN@B-P7TQMD6M-0146.lan>
 <2019477.yKVeVyVuyW@mypc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2019477.yKVeVyVuyW@mypc>
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
Cc: ira.weiny@intel.com, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Oct 19, 2022 at 01:21:27AM +0200, Fabio M. De Francesco wrote:
> On Tuesday, October 18, 2022 11:29:21 PM CEST Gao Xiang wrote:

...

> 
> > One of what I need to care is nested kmap() usage,
> > some unmap/remap order cannot be simply converted to kmap_local()
> 
> Correct about nesting. If we map A and then B, we must unmap B and then A.
> 
> However, as you seem to convey, not always unmappings in right order (stack 
> based) is possible, sometimes because very long functions have many loop's 
> breaks and many goto exit labels.
> 
> > but I think
> > it's not the case for erofs_bread().  Actually EROFS has one of such nested
> > kmap() usage, but I don't really care its performance on HIGHMEM platforms,
> > so I think kmap() is still somewhat useful compared to kmap_local() from 
> this
> > point of view],
> 
> In Btrfs I solved (thanks to David S.' advice) by mapping only one of two 
> pages, only the one coming from the page cache. 
> 
> The other page didn't need the use of kmap_local_page() because it was 
> allocated in the filesystem with "alloc_page(GFP_NOFS)". GFP_NOFS won't ever 
> allocate from ZONE_HIGHMEM, therefore a direct page_address() could avoid the 
> mapping and the nesting issues.
> 
> Did you check if you may solve the same way? 

That is not simple.  Currently we have compressed pages and decompressed
pages (page cache or others), and they can be unmapped when either data
is all consumed, so compressed pages can be unmapped first, or
decompressed pages can be unmapped first.  That quite depends on which
pages goes first.

I think such usage is a quite common pattern for decoder or encoder,
you could take a look at z_erofs_lzma_decompress() in
fs/erofs/decompressor_lzma.c.  So kmap() is still useful for such cases
since I don't really care the HIGHMEM performance but correctness, but
other alternative could churn/complex the map/unmap/remap pattern.

Thanks,
Gao Xiang

> 
> A little group of people are working to remove all kmap() and kmap_atomic() we 
> meet across the whole kernel. I have not yet encountered conversions which 
> cannot be made. Sometimes we may refactor, if what I said above cannot apply.
> 
> > but in order to make it all work properly, I will try to do
> > stress test with 32-bit platform later. 
> 
> I use QEMU/KVM x86_32 VM, 6GB RAM, and a kernel with HIGHMEM64 enabled and an 
> openSUSE Tumbleweed 32 distro. I've heard that Debian too provides an x86_32 
> distribution. 
> 
> > Since it targets for the next cycle
> > 6.2, I will do a full stress test in the next following weeks.
> > 
> > Thanks,
> > Gao Xiang
> > 
> 
> Thanks,
> 
> Fabio
> 
