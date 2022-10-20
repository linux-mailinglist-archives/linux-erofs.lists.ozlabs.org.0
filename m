Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD9860561A
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Oct 2022 05:50:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MtDCR3TTjz3cdy
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Oct 2022 14:50:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.45; helo=out30-45.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MtDCM2cxjz2xJ8
	for <linux-erofs@lists.ozlabs.org>; Thu, 20 Oct 2022 14:50:37 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VSdLuJ5_1666237829;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VSdLuJ5_1666237829)
          by smtp.aliyun-inc.com;
          Thu, 20 Oct 2022 11:50:31 +0800
Date: Thu, 20 Oct 2022 11:50:28 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v2] erofs: use kmap_local_page() only for erofs_bread()
Message-ID: <Y1DFhKvOWvJacTIk@B-P7TQMD6M-0146.local>
References: <20221018105313.4940-1-hsiangkao@linux.alibaba.com>
 <2019477.yKVeVyVuyW@mypc>
 <Y084l0m88JGOqGRN@B-P7TQMD6M-0146.lan>
 <12077010.O9o76ZdvQC@mypc>
 <Y1Cv/LuiGpVdO5im@B-P7TQMD6M-0146.local>
 <Y1C9y2y/87tIgfia@iweiny-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1C9y2y/87tIgfia@iweiny-mobl>
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

On Wed, Oct 19, 2022 at 08:17:31PM -0700, Ira Weiny wrote:
> On Thu, Oct 20, 2022 at 10:18:36AM +0800, Gao Xiang wrote:
> > On Wed, Oct 19, 2022 at 08:17:05PM +0200, Fabio M. De Francesco wrote:
> > > On Wednesday, October 19, 2022 1:36:55 AM CEST Gao Xiang wrote:
> > > > On Wed, Oct 19, 2022 at 01:21:27AM +0200, Fabio M. De Francesco wrote:
> > > > > On Tuesday, October 18, 2022 11:29:21 PM CEST Gao Xiang wrote:
> 
> [snip]
> 
> > 
> > That is not the simple nested unmapped case as you said above, I could take
> > a very brief example:
> 
> Building on this.  The uncompressed pages always outnumber the compressed
> pages, right?

Yes, it's always true for EROFS case.

I think if the locking order is reversed I could unmap and remap the
pages in the correct order.  But as you said below, it just could work
but complex the code (I think if you have extra time you could check
the code first.)

So as I said before, I don't really care HIGHMEM performance so here
kmap_local() cannot benefit such case.  Anyway, it'd be much better
if kmap() is kept on my side anyway.

Thanks,
Gao Xiang

> 
> > 
> > 1. map a decompresed page
> > 2. map a compressed page
> 
> First reverse these because you are going to need to map a new decompressed
> page before another compressed page.  So:
> 
> 1. map compressed
> 2. map decompressed
> 
> Then 4/5 and 7/8 become unmap/map new without issue.
> 
> > 3. working
> > 4. decompressed page is all consumed, unmap the current decompressed page
> > 5. map the next decompressed page
> > 6. working
> > 7. decompressed page is all consumed, unmap the current decompressed page
> > 8. map the next decompressed page
> > 9. working
> 
> This is more complicated but not overly so.
> 
> Simply
> 
> 9.1 unmap decompressed
> 
> > 10. compressed page is all consumed, unmap the current compressed page
> > 11. map the next compressed page
> 
> 11.1 remap decompressed
> 
> > 12. working
> > 13. ... (anyway, unmap and remap a compressed page or a decompressed page
> >          in any order.)
> > 
> > until all process is finished.  by using kmap(), it's much simple to
> > implement this, but kmap_local(), it only complexes the code.
> 
> Agreed kmap() is easier but I think this could work.
> 
> Basically you keep the compressed mapped first.
> 
> I also assume there is also a reverse of this so reverse the pages in that
> case.
> 
> Thoughts?
> Ira
