Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 287B63FC4AB
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Aug 2021 11:16:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GzM4T087Tz2yK1
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Aug 2021 19:16:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Id9yC98s;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=163.com
 (client-ip=220.181.12.12; helo=m12-12.163.com; envelope-from=zbestahu@163.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=Id9yC98s; dkim-atps=neutral
X-Greylist: delayed 915 seconds by postgrey-1.36 at boromir;
 Tue, 31 Aug 2021 19:15:56 AEST
Received: from m12-12.163.com (m12-12.163.com [220.181.12.12])
 by lists.ozlabs.org (Postfix) with ESMTP id 4GzM4D3zp2z2xWd
 for <linux-erofs@lists.ozlabs.org>; Tue, 31 Aug 2021 19:15:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=52YdD
 5ZhaJBIiIzc2bK7F+1Tmj0HFiS9umJ2iRdG/Hs=; b=Id9yC98s7zztNUJU7/B2e
 kP7hkmSlEHmZFLbnxZmT3IZT8iESqgojh6w9lkpZraZko9MIqm6Yo0x+9AUoxwl2
 LabAZxhDYBP7SiwLrWxLMIOWIldXFGyilHfL7y/WYHg19smvVoas1CSehnlTveFc
 hk+YpHXaTa3mgU8MRjV808=
Received: from localhost (unknown [218.94.48.178])
 by smtp8 (Coremail) with SMTP id DMCowAC337ul7y1hTFlkWg--.1S2;
 Tue, 31 Aug 2021 17:00:25 +0800 (CST)
Date: Tue, 31 Aug 2021 17:00:29 +0800
From: Yue Hu <zbestahu@163.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs-utils: do not check ->idata_size for compressed
 files in erofs_prepare_inode_buffer()
Message-ID: <20210831170029.000015a2.zbestahu@163.com>
In-Reply-To: <20210617181350.000005e6.zbestahu@gmail.com>
References: <20210617082954.1001-1-zbestahu@gmail.com> <YMsQHU+iSKE+FRO5@bogon>
 <20210617171555.0000673e.zbestahu@gmail.com>
 <YMsVhf2JgQOm1fDE@bogon> <YMsWMhNg6yC+osEK@bogon>
 <20210617181350.000005e6.zbestahu@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: DMCowAC337ul7y1hTFlkWg--.1S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWF4kAryDXw1UJFWUWr1xXwb_yoWrJr1Dpr
 W5K3W0yF48XryUCr1Ivr1jqry8ta48tr4UX3ZYqa48XFn0qr1ftF18tr45uFWxWr1kGFs0
 vr4jvasxuay5AFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbHUDUUUUU=
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: p2eh23xdkxqiywtou0bp/xtbBZgkAEVaD9GsiFwAAsB
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

On Thu, 17 Jun 2021 18:14:17 +0800
Yue Hu <zbestahu@gmail.com> wrote:

> On Thu, 17 Jun 2021 17:30:26 +0800
> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> 
> > On Thu, Jun 17, 2021 at 05:27:33PM +0800, Gao Xiang wrote:  
> > > On Thu, Jun 17, 2021 at 05:15:55PM +0800, Yue Hu wrote:    
> > > > On Thu, 17 Jun 2021 17:04:29 +0800
> > > > Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> > > >     
> > > > > Hi Yue,
> > > > > 
> > > > > On Thu, Jun 17, 2021 at 04:29:54PM +0800, Yue Hu wrote:    
> > > > > > From: Yue Hu <huyue2@yulong.com>
> > > > > > 
> > > > > > erofs_write_compressed_file() will always set inode->idata_size = 0
> > > > > > if succeed, that means no tail-end data for compressed files. So, no
> > > > > > need to call erofs_prepare_tail_block() which is used to handle
> > > > > > tail-end data for that case. Just skip it.      
> > > > > 
> > > > > Thanks for the patch, due to somewhat long time so I don't quite
> > > > > remember the exact logic here now...
> > > > > 
> > > > > Yet from the description before, it's not strictly correct
> > > > > since my original intention would be to support tail-packing
> > > > > inline compressed data which is similar to uncompressed case
> > > > > to decrease tail extent I/O and save more space.    
> > > > 
> > > > nice.
> > > >     
> > > > > 
> > > > > BTW, if you have some interest, would you like to implement it? :)    
> > > > 
> > > > I don't know if i can finish it. But i would like to have a try :)    
> > > 
> > > My rough thought is to try to inline the last tail compresseed
> > > extent after the on-disk compressed extents, maybe we could let
> > > it work for non-compact (legacy) compress index format cases...    
> > 
> > I mean try to implement non-compact (legacy) compress index format cases
> > first.

I'm trying to do it under 4.19 code (since i have no 5.x environment temporarily).

Now, i think mkfs should be done. But, kernel side seems not working fine(no crash,
no decompression warning/bug). Only some files are working, others not. I'm sure i
can catch the inline data correctly via file dump. And I'm trying debug the issue.
Maybe i need more time to read/understand more decompression code related.

BTW, now i understand no need to go z_erofs_vle_work_xxx for inline part(cur-end)
, just go next_part after mapping as below, am i right? 

Thanks.
  
> 
> Ok, let me try to implement it.
> 
> Thanks.
> 
> >   
> > > 
> > > Yeah, if you have extra time and interest, more ideas / thoughts /
> > > discussions are always welcomed ;)
> > > 
> > > Thanks,
> > > Gao Xiang
> > > 
> > >     
> > > > 
> > > > Thanks.
> > > >     
> > > > > 
> > > > > Thanks,
> > > > > Gao Xiang
> > > > >     
> > > > > > 
> > > > > > Also, correct 'a inode' -> 'an inode'.
> > > > > > 
> > > > > > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > > > > > ---
> > > > > >  lib/inode.c | 4 ++--
> > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/lib/inode.c b/lib/inode.c
> > > > > > index b6108db..b5f66de 100644
> > > > > > --- a/lib/inode.c
> > > > > > +++ b/lib/inode.c
> > > > > > @@ -111,7 +111,7 @@ struct erofs_dentry *erofs_d_alloc(struct erofs_inode *parent,
> > > > > >  	return d;
> > > > > >  }
> > > > > >  
> > > > > > -/* allocate main data for a inode */
> > > > > > +/* allocate main data for an inode */
> > > > > >  static int __allocate_inode_bh_data(struct erofs_inode *inode,
> > > > > >  				    unsigned long nblocks)
> > > > > >  {
> > > > > > @@ -572,11 +572,11 @@ static int erofs_prepare_inode_buffer(struct erofs_inode *inode)
> > > > > >  		int ret;
> > > > > >  
> > > > > >  		inode->datalayout = EROFS_INODE_FLAT_PLAIN;
> > > > > > -noinline:
> > > > > >  		/* expend an extra block for tail-end data */
> > > > > >  		ret = erofs_prepare_tail_block(inode);
> > > > > >  		if (ret)
> > > > > >  			return ret;
> > > > > > +noinline:
> > > > > >  		bh = erofs_balloc(INODE, inodesize, 0, 0);
> > > > > >  		if (IS_ERR(bh))
> > > > > >  			return PTR_ERR(bh);
> > > > > > -- 
> > > > > > 1.9.1      


