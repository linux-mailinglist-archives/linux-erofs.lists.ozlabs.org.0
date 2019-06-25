Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0860D5243D
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jun 2019 09:20:04 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45XyGn149pzDqNt
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jun 2019 17:20:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZoVNsD6p"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45XyGf1dvCzDqBy
 for <linux-erofs@lists.ozlabs.org>; Tue, 25 Jun 2019 17:19:52 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id k13so2312442pgq.9
 for <linux-erofs@lists.ozlabs.org>; Tue, 25 Jun 2019 00:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jX8bCP7awxiv2Sar0mLdMVSumamjlboJqSTSNDGZ/Mw=;
 b=ZoVNsD6phpHFP4bA1Bwn6XgMFhqIa/CURQbd2XJb6uCyvxFfx7fcFysPU6mPb+iORP
 VQ4UJfw1X00t0Oyx9acZk6VVKqxx1pVbxkU06sy27lhseHwUCytokwP9LzCoSBTnmICJ
 KcmlMd++m7/pquppbrwSSzwiu/zboi8XgRNWVWe3NYzKV42ZJzyiToUyicTgfrSKeEXT
 BSBSlm6DGaXvJRGfBr69Uy3bu5bZPAPILZIZ2+1v4KqlebWX+NgBSZSHFYWQech1YfvR
 2q2XTu2D4RepatlS7CeF+SFgPxQHO8eWs3/pturJOicoUur14vEdmmSPySscQertL1/N
 7YFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jX8bCP7awxiv2Sar0mLdMVSumamjlboJqSTSNDGZ/Mw=;
 b=Ew+xdwLEI4ycyTCUAdeFD4EVWWASwjKlMiLVZYB/jRvvOFRez3xWLl9W2qOfRUCzw+
 /+XxCFit+NNHKHgTr7ba13Ltc2aQLv3SRtc8DddowKEW9h7p7166N44uUlseX3/FiF6X
 S1ptmBVq+ir6m7YAuBUwMLbihcaPjRfvxG9k6vhwJhbio0d8RCfkKjl2VGhkPY3kzxd2
 xHmHdGzWaodOZEob9MzUds4/Sjt7TYkARDxVhcAsfIhJc/hKjn80YVvANEakiT3/vMyy
 Rhqb6Du8TVdz35qRtfsANW1NmcJqKEPsnFTgkJOdO0HZXCsO1KRj66k1LmJfGgC49o0r
 A1RQ==
X-Gm-Message-State: APjAAAWKo3xafaT4l1VUPTwZdiQ5mhgm3xwMfjDroAJ1GvIEThh4/7RJ
 KHcCwBxpVrOR1VkoX37aVas=
X-Google-Smtp-Source: APXvYqylsWVkyaOA1CvLLg0A2xseHv9BhZgewuPb9qjQ2V1yRqOLnMy9kukfoSHM1Cakna12KlWIxQ==
X-Received: by 2002:a63:7009:: with SMTP id l9mr36888186pgc.162.1561447188910; 
 Tue, 25 Jun 2019 00:19:48 -0700 (PDT)
Received: from localhost ([218.189.10.173])
 by smtp.gmail.com with ESMTPSA id j16sm1299318pjz.31.2019.06.25.00.19.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 25 Jun 2019 00:19:48 -0700 (PDT)
Date: Tue, 25 Jun 2019 15:19:36 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@aol.com>
Subject: Re: [PATCH] staging: erofs: remove unsupported ->datamode check in
 fill_inline_data()
Message-ID: <20190625151936.00005a26.zbestahu@gmail.com>
In-Reply-To: <afd234f8-4cb3-4481-695b-1726ea7ad71e@aol.com>
References: <20190625061431.3964-1-zbestahu@gmail.com>
 <afd234f8-4cb3-4481-695b-1726ea7ad71e@aol.com>
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
Cc: linux-erofs@lists.ozlabs.org, gregkh@linuxfoundation.org, huyue2@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, 25 Jun 2019 15:13:49 +0800
Gao Xiang <hsiangkao@aol.com> wrote:

> Hi Yue,
> 
> On 2019/6/25 ????2:14, Yue Hu Wrote:
> > From: Yue Hu <huyue2@yulong.com>
> > 
> > Already check if ->datamode is supported in read_inode(), no need to check
> > again in the next fill_inline_data() only called by fill_inode().
> > 
> > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > ---  
> 
> Is there any difference between two patches?

No. Sorry to send twice due to unstable network enviroment in my side.

Thx. 

> 
> Thanks,
> Gao Xiang
> 
> >  drivers/staging/erofs/inode.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
> > index e51348f..d6e1e16 100644
> > --- a/drivers/staging/erofs/inode.c
> > +++ b/drivers/staging/erofs/inode.c
> > @@ -129,8 +129,6 @@ static int fill_inline_data(struct inode *inode, void *data,
> >  	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
> >  	const int mode = vi->datamode;
> >  
> > -	DBG_BUGON(mode >= EROFS_INODE_LAYOUT_MAX);
> > -
> >  	/* should be inode inline C */
> >  	if (mode != EROFS_INODE_LAYOUT_INLINE)
> >  		return 0;
> >   

