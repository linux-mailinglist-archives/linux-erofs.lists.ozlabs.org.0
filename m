Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A55C3FC5D4
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Aug 2021 13:16:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GzPl143mGz2yK1
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Aug 2021 21:16:13 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GzPks0G4Fz2yHw
 for <linux-erofs@lists.ozlabs.org>; Tue, 31 Aug 2021 21:15:59 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R401e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=alimailimapcm10staff010182156082;
 MF=hsiangkao@linux.alibaba.com; NM=1; PH=DS; RN=6; SR=0;
 TI=SMTPD_---0Uml4rfi_1630408550; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0Uml4rfi_1630408550) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 31 Aug 2021 19:15:51 +0800
Date: Tue, 31 Aug 2021 19:15:50 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <zbestahu@163.com>
Subject: Re: [PATCH] erofs-utils: do not check ->idata_size for compressed
 files in erofs_prepare_inode_buffer()
Message-ID: <YS4PZvVbdHGqurAD@B-P7TQMD6M-0146.local>
References: <20210617082954.1001-1-zbestahu@gmail.com> <YMsQHU+iSKE+FRO5@bogon>
 <20210617171555.0000673e.zbestahu@gmail.com>
 <YMsVhf2JgQOm1fDE@bogon> <YMsWMhNg6yC+osEK@bogon>
 <20210617181350.000005e6.zbestahu@gmail.com>
 <20210831170029.000015a2.zbestahu@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210831170029.000015a2.zbestahu@163.com>
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
Cc: xiang@kernel.org, yuchao0@huawei.com, linux-erofs@lists.ozlabs.org,
 huyue2@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yue,

On Tue, Aug 31, 2021 at 05:00:29PM +0800, Yue Hu wrote:
> On Thu, 17 Jun 2021 18:14:17 +0800
> Yue Hu <zbestahu@gmail.com> wrote:
> 
> > On Thu, 17 Jun 2021 17:30:26 +0800
> > Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> > 
> > > On Thu, Jun 17, 2021 at 05:27:33PM +0800, Gao Xiang wrote:  
> > > > On Thu, Jun 17, 2021 at 05:15:55PM +0800, Yue Hu wrote:    
> > > > > On Thu, 17 Jun 2021 17:04:29 +0800
> > > > > Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> > > > >     
> > > > > > Hi Yue,
> > > > > > 
> > > > > > On Thu, Jun 17, 2021 at 04:29:54PM +0800, Yue Hu wrote:    
> > > > > > > From: Yue Hu <huyue2@yulong.com>
> > > > > > > 
> > > > > > > erofs_write_compressed_file() will always set inode->idata_size = 0
> > > > > > > if succeed, that means no tail-end data for compressed files. So, no
> > > > > > > need to call erofs_prepare_tail_block() which is used to handle
> > > > > > > tail-end data for that case. Just skip it.      
> > > > > > 
> > > > > > Thanks for the patch, due to somewhat long time so I don't quite
> > > > > > remember the exact logic here now...
> > > > > > 
> > > > > > Yet from the description before, it's not strictly correct
> > > > > > since my original intention would be to support tail-packing
> > > > > > inline compressed data which is similar to uncompressed case
> > > > > > to decrease tail extent I/O and save more space.    
> > > > > 
> > > > > nice.
> > > > >     
> > > > > > 
> > > > > > BTW, if you have some interest, would you like to implement it? :)    
> > > > > 
> > > > > I don't know if i can finish it. But i would like to have a try :)    
> > > > 
> > > > My rough thought is to try to inline the last tail compresseed
> > > > extent after the on-disk compressed extents, maybe we could let
> > > > it work for non-compact (legacy) compress index format cases...    
> > > 
> > > I mean try to implement non-compact (legacy) compress index format cases
> > > first.
> 
> I'm trying to do it under 4.19 code (since i have no 5.x environment temporarily).
> 
> Now, i think mkfs should be done. But, kernel side seems not working fine(no crash,
> no decompression warning/bug). Only some files are working, others not. I'm sure i
> can catch the inline data correctly via file dump. And I'm trying debug the issue.
> Maybe i need more time to read/understand more decompression code related.
> 
> BTW, now i understand no need to go z_erofs_vle_work_xxx for inline part(cur-end)
> , just go next_part after mapping as below, am i right? 
> 

You are right. For the common cases (except for fiemap or cases to get the exact
decompressed length), we only need to calculate the start of the compression extent,
so it's transversal in the reverse order.

But really... Again, I don't suggest using 4.19 staging code for real production
or further development. The uncompressed part is considered as stable, but
compression side may not (also it was disabled by default). Please also see,
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/staging/erofs/Kconfig?h=v4.19#n86

" config EROFS_FS_ZIP
  bool "EROFS Data Compresssion Support"
  depends on EROFS_FS
  help
    Currently we support VLE Compression only.
    Play at your own risk.

    If you don't want to use compression feature, say N. "

Our original first real production codebase was between 5.2~5.3. Therefore,
I suggest using >= 5.4 LTS codebase for production. You could also find
some backport codebase on github, e.g.:
https://github.com/nolange/erofs_kernel_4_19
, which backports 5.6 erofs codebase to 4.19.

As for tail-packing inline extent feature, how about focusing on on-disk
design and mkfs/erofsfuse implementation first as PoC?

I'm afraid that if you only focus on 4.19 codebase, the format of compact
indexes will be ignored, but "compact indexes" is the default option for
erofs now since it has less metadata overhead than non-compact indexes,
so both the sequential / random read are better.

Thanks,
Gao Xiang

> Thanks.
>   
> > 
> > Ok, let me try to implement it.
> > 
> > Thanks.
