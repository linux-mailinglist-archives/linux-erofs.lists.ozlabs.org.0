Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 836787806B4
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Aug 2023 09:52:43 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=WHE5axGT;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RRvHF0NhHz3cFX
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Aug 2023 17:52:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=WHE5axGT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RRvH860Ffz2yxg
	for <linux-erofs@lists.ozlabs.org>; Fri, 18 Aug 2023 17:52:35 +1000 (AEST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bc63ef9959so5214625ad.2
        for <linux-erofs@lists.ozlabs.org>; Fri, 18 Aug 2023 00:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692345153; x=1692949953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8duZBb7/Vz58MaN/PoDCFguJ69017evWqg3k7byHQ8=;
        b=WHE5axGTJJDn72IbHvrVDFL9Shc7pKsphrM41sfga6yldUjEDjTrCFcJpIdEQ6X/d/
         ZedG5dJD3PhFdQ9nGeuXOgLXGHq3fAciJO7f6RaEugjCwKsFCvQrd/SyJTHEyGjHNqnt
         kdvi50NXP2xMIZV7BXu8Nv1k2M6gCW43BKxesg3PUBILx4YdjsnWvo96DTvW7e+OX7qA
         xac2cntYz9c1WDQd8W4Pf2Rtot8p+5L/6ySeBHINEuKOeVBD5HMKCDHJ4HFrdOMcHaMj
         kx8+6O2T2aH/YZH95d64zof7KJn1cgA1wdTs6MEWpNMgHketAxKgi+9HnCHMp2HafGTR
         J+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692345153; x=1692949953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8duZBb7/Vz58MaN/PoDCFguJ69017evWqg3k7byHQ8=;
        b=dd6LBE1b/8Jg9G/NNUh2Z44FjXyLYWzVojHFr1w5RRDPmwjngFCtHZ1CTNvaTPVt3g
         IvovRWNiEFEM3Nc7TrDAYHKRqIMrzVw7Q1mmB/lax8/gqO/Xip7sg+X1sZ8UuG76YcJd
         XvpZFKK+32kZQIdhdexgakQk5R7d5psoVMwxpl4Yv62tGoNhybdOcttTkxUyY4blsFGs
         BoUJ+0KQT2Tqkz5oCaUD9KtlVw9VabxGqxjvbfF33Ju00fX/2tQUQDnYCAW5G6csphY5
         Bd84WgTDXkED7+LsfN16NRuCiHM30AnWDjSYYbqXqAUukdPwHrR5hyCVjoimYBbz9Jt5
         wqrA==
X-Gm-Message-State: AOJu0YzSUkRay8agL6Srfm/y0XW4rV7pwJNBcV0my+mO5eF9OQd6dfds
	0JW07Qh4g1ItEwzmfs3TQlw=
X-Google-Smtp-Source: AGHT+IFVeicJUnhXS4O2X3WbCbT5hTFJs9hWM5MC641m0k5xentlHDNDAabEJjdJmUnrggei0ff3jQ==
X-Received: by 2002:a17:902:c94d:b0:1b8:88c5:2d2f with SMTP id i13-20020a170902c94d00b001b888c52d2fmr2095248pla.64.1692345153286;
        Fri, 18 Aug 2023 00:52:33 -0700 (PDT)
Received: from localhost ([156.236.96.163])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902b78900b001b5656b0bf9sm1038102pls.286.2023.08.18.00.52.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Aug 2023 00:52:33 -0700 (PDT)
Date: Fri, 18 Aug 2023 16:02:16 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 6/8] erofs: get rid of fe->backmost for cache
 decompression
Message-ID: <20230818160216.00002bfd.zbestahu@gmail.com>
In-Reply-To: <671a514f-8597-7693-1323-929e39c56dda@linux.alibaba.com>
References: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
	<20230817082813.81180-6-hsiangkao@linux.alibaba.com>
	<20230818135156.00005a05.zbestahu@gmail.com>
	<671a514f-8597-7693-1323-929e39c56dda@linux.alibaba.com>
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, 18 Aug 2023 15:48:08 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On 2023/8/18 13:51, Yue Hu wrote:
> > On Thu, 17 Aug 2023 16:28:11 +0800
> > Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> >   
> >> EROFS_MAP_FULL_MAPPED is more accurate to decide if caching the last
> >> incomplete pcluster for later read or not.
> >>
> >> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> >> ---
> >>   fs/erofs/zdata.c | 7 ++-----
> >>   1 file changed, 2 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> >> index 4009283944ca..c28945532a02 100644
> >> --- a/fs/erofs/zdata.c
> >> +++ b/fs/erofs/zdata.c
> >> @@ -528,8 +528,6 @@ struct z_erofs_decompress_frontend {
> >>   	z_erofs_next_pcluster_t owned_head;
> >>   	enum z_erofs_pclustermode mode;
> >>   
> >> -	/* used for applying cache strategy on the fly */
> >> -	bool backmost;
> >>   	erofs_off_t headoffset;
> >>   
> >>   	/* a pointer used to pick up inplace I/O pages */
> >> @@ -538,7 +536,7 @@ struct z_erofs_decompress_frontend {
> >>   
> >>   #define DECOMPRESS_FRONTEND_INIT(__i) { \
> >>   	.inode = __i, .owned_head = Z_EROFS_PCLUSTER_TAIL, \
> >> -	.mode = Z_EROFS_PCLUSTER_FOLLOWED, .backmost = true }
> >> +	.mode = Z_EROFS_PCLUSTER_FOLLOWED }
> >>   
> >>   static bool z_erofs_should_alloc_cache(struct z_erofs_decompress_frontend *fe)
> >>   {
> >> @@ -547,7 +545,7 @@ static bool z_erofs_should_alloc_cache(struct z_erofs_decompress_frontend *fe)
> >>   	if (cachestrategy <= EROFS_ZIP_CACHE_DISABLED)
> >>   		return false;
> >>   
> >> -	if (fe->backmost)
> >> +	if (!(fe->map.m_flags & EROFS_MAP_FULL_MAPPED))  
> > 
> > So, i understand (map.m_flags & EROFS_MAP_FULL_MAPPED) should be false if allocate cache is needed
> > (fe->backmost is true)?  
> 
> fe->backmost is inaccurate compared with !EROFS_MAP_FULL_MAPPED,
> if !EROFS_MAP_FULL_MAPPED, it should be cached instead.

Okay.

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> 
> Thanks,
> Gao Xiang

