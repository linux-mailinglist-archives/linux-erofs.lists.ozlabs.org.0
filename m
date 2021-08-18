Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2078C3EF807
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Aug 2021 04:21:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GqBTy4b5Zz2yss
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Aug 2021 12:21:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=EQuFwNRV;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::529;
 helo=mail-pg1-x529.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=EQuFwNRV; dkim-atps=neutral
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GqBTv3kcdz2yss
 for <linux-erofs@lists.ozlabs.org>; Wed, 18 Aug 2021 12:21:21 +1000 (AEST)
Received: by mail-pg1-x529.google.com with SMTP id e7so674682pgk.2
 for <linux-erofs@lists.ozlabs.org>; Tue, 17 Aug 2021 19:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lSuQmVVb+3lKJfRhOx8ywFAbkaiMR4UG4DvDdu1hKPc=;
 b=EQuFwNRVKHsqGPiLdcuYxqvrR7Ep+qNGKsLYCpr3yGFL/2v5EVVXZ9GrsZLJ5ouSEI
 aZPGZa+LPdcXr2OLptVgP4dTmY2BUHtjrdA0McyWeZ+GdDa/qaUD0prw/nYxm5HdIWo/
 i455z8lVxYkL4VScaaPkJ9yBq01HG33f2bfGe0DG9lE8TxVUzrZAY67Krl34AIBUkB7u
 aZos8y+yGHgFW1mCqDvaojlpzyHMl/tmirZqq3c63J/xSpvnKUk44ixIKOw3W+VroGDu
 uXL8TGB3B35gSOGQ+F4yarJZsyd1DRqKvP3kTFcIKwm+MiPRkYc272sqT6xBn5/qOzV/
 wcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lSuQmVVb+3lKJfRhOx8ywFAbkaiMR4UG4DvDdu1hKPc=;
 b=VdVnD+jJrpHPP09S8jhaipd8qeXiukBI7ZCfv/J2PK2e28zmL19Tom5tgP9Ld/w5Bd
 SmOCUhMOhZNFcVSK1xqWw2aUZMFrVMXAWYsezRPT0NnoTOBmjAzTCmUQW/V2Os03sTQp
 5tjT2kCVOGLw5410xJ86q5Btu9GsBVQhZJZdi+IlrISViERPSoSKwr+eiW1gY7PQXqBJ
 uOCj0OH3cuFeFtZ7PqIK9M/3GnA+4dA8aPIa4kSNJ/YOMMKG3ELdL6ytHhSSKXTJwKMU
 HiuZDR6vyraKc8k6knI+bd9pgILhRJQAoXteq3CysyLg2Wi5gLz4EqOYull3t1VA0IYx
 yZdQ==
X-Gm-Message-State: AOAM530X2me35FGwD3akddbKK8pnK2PTuRFmp4rWK10WUavHV7swfOpi
 xKg7spQuGJydKruSwHVMFgU=
X-Google-Smtp-Source: ABdhPJydWieEqm3pIq/NaPqty6nGeRVOM82N1llI25p2Jdzzw7Xm4JeUdoMQU/DbBhCp7y5pWkwiQQ==
X-Received: by 2002:a63:494:: with SMTP id 142mr6424455pge.242.1629253279230; 
 Tue, 17 Aug 2021 19:21:19 -0700 (PDT)
Received: from localhost ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id pj14sm2926609pjb.35.2021.08.17.19.21.17
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 17 Aug 2021 19:21:19 -0700 (PDT)
Date: Wed, 18 Aug 2021 10:21:21 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs-utils: add clusterofs zero check to
 write_uncompressed_extent()
Message-ID: <20210818102121.00004d36.zbestahu@gmail.com>
In-Reply-To: <YRvJzLoDgvh11zVt@B-P7TQMD6M-0146.local>
References: <20210817040605.732-1-zbestahu@gmail.com>
 <YRu16nuqv+5YkW4H@B-P7TQMD6M-0146.local>
 <20210817221046.000037aa.zbestahu@gmail.com>
 <YRvJzLoDgvh11zVt@B-P7TQMD6M-0146.local>
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
Cc: xiang@kernel.org, linux-erofs@lists.ozlabs.org, huyue2@yulong.com,
 zbestahu@163.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Xiang,

On Tue, 17 Aug 2021 22:38:04 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On Tue, Aug 17, 2021 at 10:10:46PM +0800, Yue Hu wrote:
> > Hi Xiang,
> > 
> > On Tue, 17 Aug 2021 21:13:14 +0800
> > Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> >   
> > > Hi Yue,
> > > 
> > > On Tue, Aug 17, 2021 at 12:06:04PM +0800, Yue Hu wrote:  
> > > > From: Yue Hu <huyue2@yulong.com>
> > > > 
> > > > No need to reset clusterofs to 0 if it's already 0. Acturally, we also
> > > > observed that case frequently. Let's avoid it.
> > > > 
> > > > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > > > ---
> > > >  lib/compress.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/lib/compress.c b/lib/compress.c
> > > > index 40723a1..a8ebbc1 100644
> > > > --- a/lib/compress.c
> > > > +++ b/lib/compress.c
> > > > @@ -130,7 +130,7 @@ static int write_uncompressed_extent(struct z_erofs_vle_compress_ctx *ctx,
> > > >  	unsigned int count;
> > > >  
> > > >  	/* reset clusterofs to 0 if permitted */
> > > > -	if (!erofs_sb_has_lz4_0padding() &&
> > > > +	if (!erofs_sb_has_lz4_0padding() && ctx->clusterofs &&    
> > > 
> > > Also out of curiosity, which means erofs is used without lz4 0padding?  

Moreover, seems 'ctx->head' will always >= 'ctx->clusterofs' here since there
are only 2 sites to increase it. One is 'ctx->head += count' after compression,
another is 'ctx->head = qh_after' ( which should be same as ->clusterofs, rt?).

I understand there are part of duplication data when writing uncompressed data
to disk due to 'ctx->head' decreased?

Thanks.

> > 
> > Yes. We are using legacy compression layout now.  
> 
> Ok, I think sometime I will seperate it into (non)compact compress
> indexes, and (non)0padding. It was once named as legacy just before
> Linux < 5.3 didn't support them.
> 
> By default, the preferred option now I think is compact and 0padding.
> 
> 0padding will enable in-place decompression (and LZMA will always
> enable it.)
> compact will reduce metadata even further as long as the compressed
> data is consecutive (e.g. 2 bytes each lcluster for compact indexes
> rather than 8 bytes each lcluster for noncompact indexes, but anyway,
> either (non)compact metadata can support effective data random access.)
> 
> Ok, if it's somewhat kernel 4.19 based code, I'd suggest to upgrade
> the codebase at least to 5.4, not because 4.19 doesn't work, but
> really for some performance concern....
> 
> Thanks,
> Gao Xiang

