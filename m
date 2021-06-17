Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3D93AAF85
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Jun 2021 11:16:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G5Gd76yl3z3bsC
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Jun 2021 19:16:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=H0VMPR8A;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102c;
 helo=mail-pj1-x102c.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=H0VMPR8A; dkim-atps=neutral
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G5Gd11m0Mz2yXW
 for <linux-erofs@lists.ozlabs.org>; Thu, 17 Jun 2021 19:16:04 +1000 (AEST)
Received: by mail-pj1-x102c.google.com with SMTP id g4so3445156pjk.0
 for <linux-erofs@lists.ozlabs.org>; Thu, 17 Jun 2021 02:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=M8GwCEGA0/Ww+tDDZvMgjm9vpibXGJi1wPuI0smjKE4=;
 b=H0VMPR8AGlL8TIIaKZ59pkVTDJVp/gA5rK3ooNVzc9BD48gDjsb5yVdTZs/fuXBzzn
 u1BTB9HVIUM/tQd+S5BOdaC3vvcRdwT9sWLkU/3EBc5BHN5++f0oi3qHB8gdfcPXcGli
 xiv7FVn3lgZ84nvlwPUN2dyScDK60NwABS3p6ChZ9UWP5yvNhnl3rEyNbbyC+2NJv5/+
 zFBmpJriF9TB3Y9WZVLv89powpAGLK2Ghfu/i6PRKupMLL4l+NrsaendFV8p5/Vt9NWE
 qpC1lhIi4ZvN+GHuuvSSRQxU8BqCzcgKNOOeykjcx1v4fZsmLrq+hGDIl8JrnKzChzdX
 op8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=M8GwCEGA0/Ww+tDDZvMgjm9vpibXGJi1wPuI0smjKE4=;
 b=GDS+1Wd4dhkpWUHbRQcNfpVkp2ZM0DOZv+1W3aMmm4YKjuCyWSKe76x2rbgK4UOi5u
 q8YPMXji59Yn6eTwSk11HKXu5hOQITGJduUcx+ziUfnP02BEU5S6VL6TUtuQw+k3PzIi
 K4afFlIUpnAolZOLuN+7fTE2OU5VKOKqPNOQvOvbhkSZ3XZZHEM5eFSWT6QrLggnWL8H
 TMH8aC8WMApYwmRzmtdIGU09jhkAwjQdPhvHVVrGrhSzJiD6253nJrCxa71iVchhiYKG
 eO8P70al8zCpIXBxmzwCF+bffCaCw3Qm0Le5iGJyjumBGxL6DJCyHa4rmKa5O2SbzA7P
 fyeg==
X-Gm-Message-State: AOAM532DAz3crY/Av2s4iVhnJxY3me+kx6n2ZMNM+6St1Y4qodoS6EBk
 fxn0HzyNg79KwujpE3rQjxo=
X-Google-Smtp-Source: ABdhPJxSUsN7zxotQSjPfjCXtSB0hTz4WhFngbh/F/AtypZfRoAfr/lQvFgWUpBwB98/0kBj8z8UXQ==
X-Received: by 2002:a17:90a:d516:: with SMTP id
 t22mr4687236pju.144.1623921361464; 
 Thu, 17 Jun 2021 02:16:01 -0700 (PDT)
Received: from localhost ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id k25sm4370912pfa.213.2021.06.17.02.15.59
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 17 Jun 2021 02:16:01 -0700 (PDT)
Date: Thu, 17 Jun 2021 17:15:55 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs-utils: do not check ->idata_size for compressed
 files in erofs_prepare_inode_buffer()
Message-ID: <20210617171555.0000673e.zbestahu@gmail.com>
In-Reply-To: <YMsQHU+iSKE+FRO5@bogon>
References: <20210617082954.1001-1-zbestahu@gmail.com> <YMsQHU+iSKE+FRO5@bogon>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: zbestahu@163.com, huyue2@yulong.com, xiang@kernel.org,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 17 Jun 2021 17:04:29 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Hi Yue,
> 
> On Thu, Jun 17, 2021 at 04:29:54PM +0800, Yue Hu wrote:
> > From: Yue Hu <huyue2@yulong.com>
> > 
> > erofs_write_compressed_file() will always set inode->idata_size = 0
> > if succeed, that means no tail-end data for compressed files. So, no
> > need to call erofs_prepare_tail_block() which is used to handle
> > tail-end data for that case. Just skip it.  
> 
> Thanks for the patch, due to somewhat long time so I don't quite
> remember the exact logic here now...
> 
> Yet from the description before, it's not strictly correct
> since my original intention would be to support tail-packing
> inline compressed data which is similar to uncompressed case
> to decrease tail extent I/O and save more space.

nice.

> 
> BTW, if you have some interest, would you like to implement it? :)

I don't know if i can finish it. But i would like to have a try :)

Thanks.

> 
> Thanks,
> Gao Xiang
> 
> > 
> > Also, correct 'a inode' -> 'an inode'.
> > 
> > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > ---
> >  lib/inode.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/lib/inode.c b/lib/inode.c
> > index b6108db..b5f66de 100644
> > --- a/lib/inode.c
> > +++ b/lib/inode.c
> > @@ -111,7 +111,7 @@ struct erofs_dentry *erofs_d_alloc(struct erofs_inode *parent,
> >  	return d;
> >  }
> >  
> > -/* allocate main data for a inode */
> > +/* allocate main data for an inode */
> >  static int __allocate_inode_bh_data(struct erofs_inode *inode,
> >  				    unsigned long nblocks)
> >  {
> > @@ -572,11 +572,11 @@ static int erofs_prepare_inode_buffer(struct erofs_inode *inode)
> >  		int ret;
> >  
> >  		inode->datalayout = EROFS_INODE_FLAT_PLAIN;
> > -noinline:
> >  		/* expend an extra block for tail-end data */
> >  		ret = erofs_prepare_tail_block(inode);
> >  		if (ret)
> >  			return ret;
> > +noinline:
> >  		bh = erofs_balloc(INODE, inodesize, 0, 0);
> >  		if (IS_ERR(bh))
> >  			return PTR_ERR(bh);
> > -- 
> > 1.9.1  

