Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FEE60556C
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Oct 2022 04:18:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MtB9X4JGhz3c6D
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Oct 2022 13:18:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.5; helo=out199-5.us.a.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out199-5.us.a.mail.aliyun.com (out199-5.us.a.mail.aliyun.com [47.90.199.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MtB9P3Fhfz3bZY
	for <linux-erofs@lists.ozlabs.org>; Thu, 20 Oct 2022 13:18:47 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VScrTTV_1666232317;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VScrTTV_1666232317)
          by smtp.aliyun-inc.com;
          Thu, 20 Oct 2022 10:18:39 +0800
Date: Thu, 20 Oct 2022 10:18:36 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH v2] erofs: use kmap_local_page() only for erofs_bread()
Message-ID: <Y1Cv/LuiGpVdO5im@B-P7TQMD6M-0146.local>
References: <20221018105313.4940-1-hsiangkao@linux.alibaba.com>
 <2019477.yKVeVyVuyW@mypc>
 <Y084l0m88JGOqGRN@B-P7TQMD6M-0146.lan>
 <12077010.O9o76ZdvQC@mypc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <12077010.O9o76ZdvQC@mypc>
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

On Wed, Oct 19, 2022 at 08:17:05PM +0200, Fabio M. De Francesco wrote:
> On Wednesday, October 19, 2022 1:36:55 AM CEST Gao Xiang wrote:
> > On Wed, Oct 19, 2022 at 01:21:27AM +0200, Fabio M. De Francesco wrote:
> > > On Tuesday, October 18, 2022 11:29:21 PM CEST Gao Xiang wrote:
> > 
> > ...
> > 
> > > 
> > > > One of what I need to care is nested kmap() usage,
> > > > some unmap/remap order cannot be simply converted to kmap_local()
> > > 
> > > Correct about nesting. If we map A and then B, we must unmap B and then A.
> > > 
> > > However, as you seem to convey, not always unmappings in right order 
> (stack 
> > > based) is possible, sometimes because very long functions have many loop's 
> > > breaks and many goto exit labels.
> > > 
> > > > but I think
> > > > it's not the case for erofs_bread().  Actually EROFS has one of such 
> nested
> > > > kmap() usage, but I don't really care its performance on HIGHMEM 
> platforms,
> > > > so I think kmap() is still somewhat useful compared to kmap_local() from 
> > > this
> > > > point of view],
> > > 
> 
> fs/erofs conversions are in our (Ira's and my) list. So I'm am happy to see 
> that we can delete some entries because of your changes. :-)
> 
> > > In Btrfs I solved (thanks to David S.' advice) by mapping only one of two 
> > > pages, only the one coming from the page cache. 
> > > 
> > > The other page didn't need the use of kmap_local_page() because it was 
> > > allocated in the filesystem with "alloc_page(GFP_NOFS)". GFP_NOFS won't 
> ever 
> > > allocate from ZONE_HIGHMEM, therefore a direct page_address() could avoid 
> the 
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
> > fs/erofs/decompressor_lzma.c.  
> 
> I haven't yet read that code, however I may attempt to propose a pattern for 
> solving this kinds of issue, I mean where you don't know which page got mapped 
> last...
> 
> It's not elegant but it may work. You have compressed and decompressed pages 
> and you can't know in advance what page should be unmapped first because you 
> can't know in which order they where mapped, right?
> 

Not really.

> I'd use a variable to save two different values, each representing the last 
> page mapped. When the code gets to the unmapping block (perhaps in an "out" 
> label), just check what that variable contains. Depending on that value, say 
> 'c' or 'd', you will be able to know what must be unmapped for first. An "if / 
> else" can do the work.

That is not the simple nested unmapped case as you said above, I could take
a very brief example:

1. map a decompresed page
2. map a compressed page
3. working
4. decompressed page is all consumed, unmap the current decompressed page
5. map the next decompressed page
6. working
7. decompressed page is all consumed, unmap the current decompressed page
8. map the next decompressed page
9. working
10. compressed page is all consumed, unmap the current compressed page
11. map the next compressed page
12. working
13. ... (anyway, unmap and remap a compressed page or a decompressed page
         in any order.)

until all process is finished.  by using kmap(), it's much simple to
implement this, but kmap_local(), it only complexes the code.

Thanks,
Gao Xiang

> 
> What do you think of this?
> 
