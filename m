Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C418B3EEE2A
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Aug 2021 16:10:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GptH547x3z30DC
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Aug 2021 00:10:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=thr+S3rl;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b;
 helo=mail-pj1-x102b.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=thr+S3rl; dkim-atps=neutral
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GptH03Clqz2xtx
 for <linux-erofs@lists.ozlabs.org>; Wed, 18 Aug 2021 00:10:52 +1000 (AEST)
Received: by mail-pj1-x102b.google.com with SMTP id
 om1-20020a17090b3a8100b0017941c44ce4so5382684pjb.3
 for <linux-erofs@lists.ozlabs.org>; Tue, 17 Aug 2021 07:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SKlO2yOpS+Mg6FwrES27yKyE+uVnIX5ojSpeJuQYp4A=;
 b=thr+S3rlrmE5wyx2W/pbVxYp6P8Kl4pOzEBpFkVz6T+aQWibJemUaAkzCC2EK14U5l
 eGcHINPJgUPa9uvbH/byMYfaySB2DgWcP+vBmpcvofwa8w5kI2yqfH6v52VMFh52ICFu
 uscV98my3JAthLP/SGzYmTRszoRxpuXKxtMCUjuby+iuSbgq789iW1fiodcPQ0aoi4wR
 QfWmvdr590J1jK+y0OAf0Lfili+64hCeJDbhAW8z29+mKvEr/A+/daQpAGdVC/f7I7Ok
 Eo2APXsnhQuZM/jFfz9wot1ORXn5SJmE4ig9VxVSaRnuScJSTwW5SzeNOQRA50cpCeU/
 0L1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SKlO2yOpS+Mg6FwrES27yKyE+uVnIX5ojSpeJuQYp4A=;
 b=uhM9VWpuK2bMarrVpTIFQVsmxZc6fchX5eNINsZCCk8hh5awzH+tvGQWOzgUWztiym
 uL0LwSwYmNrLMWbrFvy+1iIM42qa3Hu8igCjkmQpD3FzzNt91CIqxxPg9A5WXDPJ2SOs
 mlFlS19MMEKD7BXflEGoBx4xJAQnLqGLclma7ieDav8JQVPhyVqT3ggH2RK/Lh/5IoN3
 k9ecf1CBTb9+xXjezx4/wzwqrd/dpJdMNczKPtVtS2KaAgpza5LT5/cSlhGiUZei3coS
 LYb70yvK797n1roW6+nMw+0X+cx0lcus1fjiNYBJD5abzf//xtHJxC20ttHUElov1L4k
 SVCQ==
X-Gm-Message-State: AOAM532krEroV16pm0139subIj9PLUf2rpAZq5+QhL0OURD+CLRsYJvl
 C3GXGx1koTtL6yvT2vrqQYc=
X-Google-Smtp-Source: ABdhPJzzg7YBPoruHUYBT5o11/St9yUKcXnmPEcwsDq63xkShNEBqXvMzcPoE1LOmsxrO2WDCU40Ug==
X-Received: by 2002:a05:6a00:d5c:b0:3e2:78ce:8d31 with SMTP id
 n28-20020a056a000d5c00b003e278ce8d31mr3934012pfv.39.1629209448900; 
 Tue, 17 Aug 2021 07:10:48 -0700 (PDT)
Received: from localhost ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id c9sm3454779pgq.58.2021.08.17.07.10.45
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 17 Aug 2021 07:10:48 -0700 (PDT)
Date: Tue, 17 Aug 2021 22:10:46 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs-utils: add clusterofs zero check to
 write_uncompressed_extent()
Message-ID: <20210817221046.000037aa.zbestahu@gmail.com>
In-Reply-To: <YRu16nuqv+5YkW4H@B-P7TQMD6M-0146.local>
References: <20210817040605.732-1-zbestahu@gmail.com>
 <YRu16nuqv+5YkW4H@B-P7TQMD6M-0146.local>
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

On Tue, 17 Aug 2021 21:13:14 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Hi Yue,
> 
> On Tue, Aug 17, 2021 at 12:06:04PM +0800, Yue Hu wrote:
> > From: Yue Hu <huyue2@yulong.com>
> > 
> > No need to reset clusterofs to 0 if it's already 0. Acturally, we also
> > observed that case frequently. Let's avoid it.
> > 
> > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > ---
> >  lib/compress.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/lib/compress.c b/lib/compress.c
> > index 40723a1..a8ebbc1 100644
> > --- a/lib/compress.c
> > +++ b/lib/compress.c
> > @@ -130,7 +130,7 @@ static int write_uncompressed_extent(struct z_erofs_vle_compress_ctx *ctx,
> >  	unsigned int count;
> >  
> >  	/* reset clusterofs to 0 if permitted */
> > -	if (!erofs_sb_has_lz4_0padding() &&
> > +	if (!erofs_sb_has_lz4_0padding() && ctx->clusterofs &&  
> 
> Also out of curiosity, which means erofs is used without lz4 0padding?

Yes. We are using legacy compression layout now.

> That way is not recommended now anyway, since it forbids erofs in-place
> decompression (only inplace I/O works instead.)

Thanks for the reminding.

> 
> Actually we could make clusterofs aligned with 0 for 0padding cases as
> well, but in that cases, we need to recompress the previous pcluster
> with new trimmed size rather than just like this.

Got it. 
BTW, I think the information should be useful for me to understand the code further.

Thanks.

> 
> Thanks,
> Gao Xiang
> 
> >  	    ctx->head >= ctx->clusterofs) {
> >  		ctx->head -= ctx->clusterofs;
> >  		*len += ctx->clusterofs;
> > -- 
> > 1.9.1  

