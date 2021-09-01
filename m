Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 718C63FD138
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Sep 2021 04:21:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GznqF2ZBDz2yJQ
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Sep 2021 12:21:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Y2cPBefI;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=163.com
 (client-ip=220.181.12.16; helo=m12-16.163.com; envelope-from=zbestahu@163.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=Y2cPBefI; dkim-atps=neutral
Received: from m12-16.163.com (m12-16.163.com [220.181.12.16])
 by lists.ozlabs.org (Postfix) with ESMTP id 4Gznq03Whmz2xXf
 for <linux-erofs@lists.ozlabs.org>; Wed,  1 Sep 2021 12:20:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=Zq/Nf
 feO0GxKd86BWg0HxM9h3YuWeQTl6DWm7n/4HsA=; b=Y2cPBefIhksB68TgED35g
 6/gk4qDLOmn8tFiFL9WCJOI6G9JveedgAbRmOuIAfgbL9NIkufgzd350vueAaZhD
 gwxuTU/+Cn7jzJjZ0GuPqPqg28enaSKbp/+c3R22uF25Rwsl8FuFVb+b5uTc9EgX
 NCEvsmxJymttB+snfMK/k8=
Received: from localhost (unknown [218.94.48.178])
 by smtp12 (Coremail) with SMTP id EMCowADnzShu4y5h_9IwAQ--.45S2;
 Wed, 01 Sep 2021 10:20:39 +0800 (CST)
Date: Wed, 1 Sep 2021 10:20:38 +0800
From: Yue Hu <zbestahu@163.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs-utils: do not check ->idata_size for compressed
 files in erofs_prepare_inode_buffer()
Message-ID: <20210901102038.00004934.zbestahu@163.com>
In-Reply-To: <YS4ee67530HlDjPp@B-P7TQMD6M-0146.local>
References: <20210617082954.1001-1-zbestahu@gmail.com> <YMsQHU+iSKE+FRO5@bogon>
 <20210617171555.0000673e.zbestahu@gmail.com>
 <YMsVhf2JgQOm1fDE@bogon> <YMsWMhNg6yC+osEK@bogon>
 <20210617181350.000005e6.zbestahu@gmail.com>
 <20210831170029.000015a2.zbestahu@163.com>
 <YS4PZvVbdHGqurAD@B-P7TQMD6M-0146.local>
 <20210831195614.000036e6.zbestahu@163.com>
 <YS4ee67530HlDjPp@B-P7TQMD6M-0146.local>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: EMCowADnzShu4y5h_9IwAQ--.45S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3GFyDGF1UZF4rJryUKFWkXrb_yoW7WF1fpF
 W5Gay8Kr4UJr1UAa1Iyw42gFyIq395Jr13Xa4DKry8Wan0vr97XrW8tr98uF9rWr40q3yq
 vr4qvrnxuas0yrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbHUDUUUUU=
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: p2eh23xdkxqiywtou0bp/1tbiTxgBEVsGaALcTQAAsh
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

On Tue, 31 Aug 2021 20:20:11 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On Tue, Aug 31, 2021 at 07:56:14PM +0800, Yue Hu wrote:
> > On Tue, 31 Aug 2021 19:15:50 +0800
> > Gao Xiang <hsiangkao@linux.alibaba.com> wrote:  
> 
> ...
> 
> > > > > > > >         
> > > > > > > > > 
> > > > > > > > > BTW, if you have some interest, would you like to implement it? :)        
> > > > > > > > 
> > > > > > > > I don't know if i can finish it. But i would like to have a try :)        
> > > > > > > 
> > > > > > > My rough thought is to try to inline the last tail compresseed
> > > > > > > extent after the on-disk compressed extents, maybe we could let
> > > > > > > it work for non-compact (legacy) compress index format cases...        
> > > > > > 
> > > > > > I mean try to implement non-compact (legacy) compress index format cases
> > > > > > first.    
> > > > 
> > > > I'm trying to do it under 4.19 code (since i have no 5.x environment temporarily).
> > > > 
> > > > Now, i think mkfs should be done. But, kernel side seems not working fine(no crash,
> > > > no decompression warning/bug). Only some files are working, others not. I'm sure i
> > > > can catch the inline data correctly via file dump. And I'm trying debug the issue.
> > > > Maybe i need more time to read/understand more decompression code related.
> > > > 
> > > > BTW, now i understand no need to go z_erofs_vle_work_xxx for inline part(cur-end)
> > > > , just go next_part after mapping as below, am i right? 
> > > >     
> > > 
> > > You are right. For the common cases (except for fiemap or cases to get the exact
> > > decompressed length), we only need to calculate the start of the compression extent,
> > > so it's transversal in the reverse order.
> > > 
> > > But really... Again, I don't suggest using 4.19 staging code for real production
> > > or further development. The uncompressed part is considered as stable, but
> > > compression side may not (also it was disabled by default). Please also see,
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/staging/erofs/Kconfig?h=v4.19#n86
> > > 
> > > " config EROFS_FS_ZIP
> > >   bool "EROFS Data Compresssion Support"
> > >   depends on EROFS_FS
> > >   help
> > >     Currently we support VLE Compression only.
> > >     Play at your own risk.
> > > 
> > >     If you don't want to use compression feature, say N. "
> > > 
> > > Our original first real production codebase was between 5.2~5.3. Therefore,
> > > I suggest using >= 5.4 LTS codebase for production. You could also find
> > > some backport codebase on github, e.g.:
> > > https://github.com/nolange/erofs_kernel_4_19
> > > , which backports 5.6 erofs codebase to 4.19.
> > > 
> > > As for tail-packing inline extent feature, how about focusing on on-disk
> > > design and mkfs/erofsfuse implementation first as PoC?
> > > 
> > > I'm afraid that if you only focus on 4.19 codebase, the format of compact
> > > indexes will be ignored, but "compact indexes" is the default option for
> > > erofs now since it has less metadata overhead than non-compact indexes,
> > > so both the sequential / random read are better.  
> > 
> > OK, let me develop it under 5.4. I need taking time to find it:)  
> 
> As the first step of kernel development, I think using x86 qemu should
> be better since it's easier to debug than on the embedded device.

Agree.

> 
> For this feature, I'm very glad to discuss some on-disk format first.
> Since it's not trivial for compact indexes since it's impossible to mark
> tailing-packing extent with some special blkaddr like non-compact
> indexes.

Yes, blkaddr should be an issue for inline case. I can feel that faintly.

> 
> My rough thought about this is "to add some new feature flag to "struct
> z_erofs_map_header" and trigger z_erofs_map_blocks(i_size - 1); at a
> proper time to get all information about the last tail-packing
> compression extent", and when submitting io, we erofs_get_meta_page()
> instead and fill the compressed pages.

Firstly, I need to add code about inline part to verify my understanding. I
think i did it almost about what i want to know including z_erofs_map_blocks()
since i can catch the inline data which is key point for me although kernel side
does not work fine totally.

Then i can re-factor/re-write it based on that. Yes, i will switch it on >=5.4
to continue developing later.

I also think we need a new flag for inline case. I'm just not focus on the flag
due to my working step above.

Now, i think i can check it about where to add the new flag more proper. Let me
check it also for your thought mentioned above.

> 
> But anyway, I still think focusing on mkfs.erofs and erofsfuse is a good
> start for this.

Yes, we should check the compression firstly.

One more question:

There's a piece of code (as below) to handle small output size(< PAGE_SIZE) which looks
like for inline part in z_erofs_decompress_generic()? If so, we also need to go vle 
decompression flow for inline data just like other data case?

```code
	if (rq->outputsize <= PAGE_SIZE * 7 / 8) {
		dst = erofs_get_pcpubuf(0);
		if (IS_ERR(dst))
			return PTR_ERR(dst);

		rq->inplace_io = false;
		ret = alg->decompress(rq, dst);
		if (!ret)
			copy_from_pcpubuf(rq->out, dst, rq->pageofs_out,
					  rq->outputsize);

		erofs_put_pcpubuf(dst);
		return ret;
	}
```

Thanks.

> 
> Thanks,
> Gao Xiang
> 
> > 
> > Thanks.
> >   
> > > 
> > > Thanks,
> > > Gao Xiang
> > >   
> > > > Thanks.
> > > >       
> > > > > 
> > > > > Ok, let me try to implement it.
> > > > > 
> > > > > Thanks.    


