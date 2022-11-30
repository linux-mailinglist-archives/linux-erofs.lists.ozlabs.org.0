Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CCF63D170
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Nov 2022 10:12:42 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NMYPv0VdKz3bVq
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Nov 2022 20:12:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=ZRsvYKFW;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=ZRsvYKFW;
	dkim-atps=neutral
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NMYPq2XLLz2xH8
	for <linux-erofs@lists.ozlabs.org>; Wed, 30 Nov 2022 20:12:29 +1100 (AEDT)
Received: by mail-pf1-x430.google.com with SMTP id h28so2667192pfq.9
        for <linux-erofs@lists.ozlabs.org>; Wed, 30 Nov 2022 01:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZ776n4uq3XGRGaIvXsHEv+80liXFr6A34xt553AwMY=;
        b=ZRsvYKFWOjt8aTLiXaehpNbXqMT0BHCdeS9Ap6A8uYIyUokAagvUGcnboHF2U14Slm
         5p8uuRhUA+XYTb57/j6Tdss8YNX6loMUL42SxGD/0+RYfKk1z/NQ1Wfj/S+UsOocc36P
         iGwaVZaK75r61RqPOkwNl/Yyo1tmraYwYmJJLE8LenRo1UoP9+lr16XJCuoeNZuvPRiT
         rbeoBFrywivgoStly0NvQZiPN+jAg+TgTEkJAdn/13nWd76X1bzXCKYQbLIDQD6Nz38E
         IM5h4NX2SvQohFTLWPUGXVUiW+0+M1ItwbBYeeuADF95yyX1UCvc+Vom8eQYbC9/ev0c
         L1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yZ776n4uq3XGRGaIvXsHEv+80liXFr6A34xt553AwMY=;
        b=TDYHbxUVjQvuEQ0eH5BlV0ldSZ5uRAYZkb1VQu/BL+wrhkgfQpmjCZu6+ZkUEPr51d
         PRU2XNwDGBDIAOX54KPuu5zNFbXhpS5Uicj7b8SNzQDiJIdKkDgbLdDmnEoGq+4U4wF+
         BGuuzPNnzxevsAI0Z3jJSmugJXe4aW14TJqFFaw/9IFU4LfcNTQzbxzj3KHSONJY/IF6
         AkYeSGlM1iZ+u0rNCEm1g8TP/1+p9wCpgl7/Oo4Tl2fmLKMte81UbAdOX9Wa0DRFTBJH
         b2ZrFX4Iw018hFG4iGy8667FBKCIN8k8XopD5JhQYNg66IFpk+7NKX+p8+xpVLvtwby0
         q/Ew==
X-Gm-Message-State: ANoB5pnTkXdMZvt90fb9Qeu5BMnT0LP8e0/eZn4GAWFP/gfGl+Mfq6UG
	8w5MagZi2dl7oCSsT94RB9w=
X-Google-Smtp-Source: AA0mqf4dRIwfX2IaT1EH4+9290J+3GYYRH8bBnPB0ZxTcWsiZetaVtTOdJbTzJLzma8agn5K5GIHWQ==
X-Received: by 2002:a63:f966:0:b0:476:f0df:3f48 with SMTP id q38-20020a63f966000000b00476f0df3f48mr40006943pgk.278.1669799546189;
        Wed, 30 Nov 2022 01:12:26 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902780700b001899007a721sm859370pll.193.2022.11.30.01.12.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Nov 2022 01:12:26 -0800 (PST)
Date: Wed, 30 Nov 2022 17:16:36 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v3] erofs-utils: mkfs: support fragment deduplication
Message-ID: <20221130171636.0000573a.zbestahu@gmail.com>
In-Reply-To: <Y4ccIxv5HfVWTQAe@B-P7TQMD6M-0146.local>
References: <20221129100053.10665-1-zbestahu@gmail.com>
	<Y4cTKeWowrg9FySM@B-P7TQMD6M-0146.local>
	<20221130165534.00004006.zbestahu@gmail.com>
	<Y4ccIxv5HfVWTQAe@B-P7TQMD6M-0146.local>
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, zbestahu@163.com, shaojunjun@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, 30 Nov 2022 17:02:27 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On Wed, Nov 30, 2022 at 04:55:34PM +0800, Yue Hu wrote:
> 
> ...
> 
> > > > @@ -782,22 +846,25 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
> > > >  	ctx.head = ctx.tail = 0;
> > > >  	ctx.clusterofs = 0;
> > > >  	ctx.e.length = 0;
> > > > -	remaining = inode->i_size;
> > > > +	ctx.e.compressedblks = 0;
> > > > +	ctx.pclustersize = z_erofs_get_max_pclusterblks(inode) * EROFS_BLKSIZ;
> > > > +	ctx.remaining = inode->i_size - inode->fragment_size;
> > > >  
> > > > -	while (remaining) {
> > > > -		const u64 readcount = min_t(u64, remaining,
> > > > +	while (ctx.remaining) {
> > > > +		const u64 readcount = min_t(u64, ctx.remaining,
> > > >  					    sizeof(ctx.queue) - ctx.tail);
> > > > +		bool fixup = ret < 0;    
> > > 
> > > 	drop this one;
> > >   
> > > >  
> > > >  		ret = read(fd, ctx.queue + ctx.tail, readcount);
> > > >  		if (ret != readcount) {
> > > >  			ret = -errno;
> > > >  			goto err_bdrop;
> > > >  		}
> > > > -		remaining -= readcount;
> > > > +		ctx.remaining -= readcount;
> > > >  		ctx.tail += readcount;
> > > >  
> > > > -		ret = vle_compress_one(&ctx, !remaining);    
> > > 
> > > 					     ret == -EAGAIN  
> > 
> > Just move 'fixup' in 'ctx'?  
> 
> Yes.
> 
> >   
> > >   
> > > > -		if (ret)
> > > > +		ret = vle_compress_one(&ctx, fixup);
> > > > +		if (ret && ret != -EAGAIN)
> > > >  			goto err_free_idata;
> > > >  	}
> > > >  	DBG_BUGON(ctx.head != ctx.tail);
> > > > @@ -807,6 +874,16 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
> > > >  	DBG_BUGON(compressed_blocks < !!inode->idata_size);
> > > >  	compressed_blocks -= !!inode->idata_size;
> > > >  
> > > > +	if (inode->fragment_size && ctx.e.compressedblks) {    
> > > 
> > > why not moving into z_erofs_fragments_dedupe_update()?  
> > 
> > I consider this before, it's a bit awkward for me due to non updating case.
> > 
> > Let me reconsider.  
> 
> What does that mean? "non updating case", could you please write down
> some formal words to describe this case?

"update" means we will update the fragment (size and offset), so "non updating" means
duplicate fragment found in dedupe will not be updated.

Anyway, i will think more about it.

Thanks.

> 
> Thanks,
> Gao Xiang

