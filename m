Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3800F364011
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Apr 2021 13:01:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FP3m01TSKz2xZR
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Apr 2021 21:01:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=rhoUKwuq;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1032;
 helo=mail-pj1-x1032.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=rhoUKwuq; dkim-atps=neutral
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FP3ly0k1nz2xYd
 for <linux-erofs@lists.ozlabs.org>; Mon, 19 Apr 2021 21:01:31 +1000 (AEST)
Received: by mail-pj1-x1032.google.com with SMTP id
 y22-20020a17090a8b16b0290150ae1a6d2bso1384221pjn.0
 for <linux-erofs@lists.ozlabs.org>; Mon, 19 Apr 2021 04:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Qp34lBgCVgiGrHkJi8lw+qaaa+z8eJ44/HRur7CLqss=;
 b=rhoUKwuqtXv+IhJHmJRksAwLIcPBiKwNr1rgdzUmPv9GcIc/cCSJRwEtmObwmz8ofJ
 BR3ogdYxwkH90zUf3fSepTiii+4k4vPj67lx85ZOgdSV1GvGF8Pn123nXcSjZKDR/n/J
 L6z3j4dAV6zo0DKnqYe86kNcHPvd/ENUxuiZz3s7MHKiOFS+x60wiM12F3WtfQHAmdo9
 9q1vpxTUrN2emPESx82EbPRKki4HdWfEc98RwxVF1mw5bwtKLZA9qT2PohoYim3zc9lF
 LBRQMwLqjjxXA1hp1zOI3EIlx+KPf1UQukUmsoOomN4MNRNzn+9L5zREAF0auleW5M5d
 epWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Qp34lBgCVgiGrHkJi8lw+qaaa+z8eJ44/HRur7CLqss=;
 b=X1UlVxh+UXUbl3ckXIni8D/Uau3DRx9KryczJ7nj4ntnVtkEpy9k/dAtK2qHac4Tsd
 rSh1jkZevl7YJVYqhs3STC/S83YFpSiGeKLd5dsMSe60d35FvjOSGNHvSD8jjMxdW8bo
 5Ki65nSmjnqVTCl+/IR4iruRZc3aNUttJ3Z9yzc253RoNlb7qB8Iio+yvZKGryYCNnrn
 sqUVzqCryACnTxot61KjstU8cLaD7jH5+AOyEjWwAcSNNhF1/obHT5HhcReA8+jgJuY4
 3IYOBsC6zAVrObUPwvnksjJRhv3FYcZTPC+02aAhhgBOGdKIQkEL/vG0Qv2AbkOTD6xT
 RWLg==
X-Gm-Message-State: AOAM5337iPcpE2IPRLAbWjsz9IPaJMpke/Ee9TzqL7NcVl6rpEw/XGXF
 2d8eta6ivIOb73a7S7+3peAcDwaifE4=
X-Google-Smtp-Source: ABdhPJz6sfFuV8cPY94ORpz78Wct1vzUAg+z7NQb5ONTYmQEbwe9SLEj9VFuDFIb8oQQWeG5eRec3w==
X-Received: by 2002:a17:90a:e2d7:: with SMTP id
 fr23mr23423279pjb.29.1618830088646; 
 Mon, 19 Apr 2021 04:01:28 -0700 (PDT)
Received: from localhost ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id h22sm12286506pfn.55.2021.04.19.04.01.26
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 19 Apr 2021 04:01:28 -0700 (PDT)
Date: Mon, 19 Apr 2021 19:01:34 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@redhat.com>
Subject: Re: [PATCH] erofs: remove the occupied parameter from
 z_erofs_pagevec_enqueue()
Message-ID: <20210419190134.0000614e.zbestahu@gmail.com>
In-Reply-To: <20210419105655.GA2677107@xiangao.remote.csb>
References: <20210419102623.2015-1-zbestahu@gmail.com>
 <20210419105655.GA2677107@xiangao.remote.csb>
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

On Mon, 19 Apr 2021 18:56:55 +0800
Gao Xiang <hsiangkao@redhat.com> wrote:

> Hi Yue,
> 
> On Mon, Apr 19, 2021 at 06:26:23PM +0800, Yue Hu wrote:
> > From: Yue Hu <huyue2@yulong.com>
> > 
> > No any behavior to variable occupied in z_erofs_attach_page() which
> > is only caller to z_erofs_pagevec_enqueue().
> > 
> > Signed-off-by: Yue Hu <huyue2@yulong.com>  
> 
> Thanks for your patch :) the variable `occupied' also has its usage
> from pagevec implementation itself. But I agree with you on this
> since it's actually unused now.
> 
> As we're in final-rc of 5.12 now, I've freezed the patches for 5.13.
> I'll put off this cleanup to the next merge queue...
> 
> (btw, for erofs kernel patches, could you kindly Cc: linux-kernel
>  mailing list next time as well... since it's part of linux kernel
>  as well.)

ok, keep in mind.

Thanks.

> 
> Thanks,
> Gao Xiang
> 
> > ---
> >  fs/erofs/zdata.c | 4 +---
> >  fs/erofs/zpvec.h | 5 +----
> >  2 files changed, 2 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> > index 3851e1a..e9231da 100644
> > --- a/fs/erofs/zdata.c
> > +++ b/fs/erofs/zdata.c
> > @@ -298,7 +298,6 @@ static int z_erofs_attach_page(struct z_erofs_collector *clt,
> >  			       enum z_erofs_page_type type)
> >  {
> >  	int ret;
> > -	bool occupied;
> >  
> >  	/* give priority for inplaceio */
> >  	if (clt->mode >= COLLECT_PRIMARY &&
> > @@ -306,8 +305,7 @@ static int z_erofs_attach_page(struct z_erofs_collector *clt,
> >  	    z_erofs_try_inplace_io(clt, page))
> >  		return 0;
> >  
> > -	ret = z_erofs_pagevec_enqueue(&clt->vector,
> > -				      page, type, &occupied);
> > +	ret = z_erofs_pagevec_enqueue(&clt->vector, page, type);
> >  	clt->cl->vcnt += (unsigned int)ret;
> >  
> >  	return ret ? 0 : -EAGAIN;
> > diff --git a/fs/erofs/zpvec.h b/fs/erofs/zpvec.h
> > index 1d67cbd..95a6207 100644
> > --- a/fs/erofs/zpvec.h
> > +++ b/fs/erofs/zpvec.h
> > @@ -107,10 +107,8 @@ static inline void z_erofs_pagevec_ctor_init(struct z_erofs_pagevec_ctor *ctor,
> >  
> >  static inline bool z_erofs_pagevec_enqueue(struct z_erofs_pagevec_ctor *ctor,
> >  					   struct page *page,
> > -					   enum z_erofs_page_type type,
> > -					   bool *occupied)
> > +					   enum z_erofs_page_type type)
> >  {
> > -	*occupied = false;
> >  	if (!ctor->next && type)
> >  		if (ctor->index + 1 == ctor->nr)
> >  			return false;
> > @@ -125,7 +123,6 @@ static inline bool z_erofs_pagevec_enqueue(struct z_erofs_pagevec_ctor *ctor,
> >  	/* should remind that collector->next never equal to 1, 2 */
> >  	if (type == (uintptr_t)ctor->next) {
> >  		ctor->next = page;
> > -		*occupied = true;
> >  	}
> >  	ctor->pages[ctor->index++] = tagptr_fold(erofs_vtptr_t, page, type);
> >  	return true;
> > -- 
> > 1.9.1
> >   
> 

