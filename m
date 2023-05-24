Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F7A70F4D2
	for <lists+linux-erofs@lfdr.de>; Wed, 24 May 2023 13:08:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QR7hG2Gjbz3f5w
	for <lists+linux-erofs@lfdr.de>; Wed, 24 May 2023 21:07:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=rJZD6KdG;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=rJZD6KdG;
	dkim-atps=neutral
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QR7hB3YFqz2xdt
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 May 2023 21:07:53 +1000 (AEST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-51b33c72686so105611a12.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 24 May 2023 04:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684926471; x=1687518471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kwUoFw1i63AKV85YeOpM79iAnzRIac8pe/CUur9ToI=;
        b=rJZD6KdGxtxMGfMZ65tuF/XHKRwmqFYXEdAU9SzIfkvD4hvAR7Eq/aezT5WYq1LQKd
         0GmAU+PxpEssPxphag5NHcsUvbLpqvVpHgI9qoNlgQNefbTFHuTIlEy7d414wxGhb3KL
         dTTU2TBiTjhjRLmzgDUuWJ9YFP+YaseUAe9f8fNKlOC2v9AhuDtjDO1ggB7CDvwWiK7i
         94dWLSt7rRxbL24rzkad0oWpL3vbr9wfnU+7obqX39AvNVeMWh7ZG4+63os7zkmMES/D
         7BdLblh8y9WgbUn+XWvrvx5vAtrZrTjDVa7MsZz7yzW1KYGRGWHNFSGVaIQ3Uw6mGPLC
         TlZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684926471; x=1687518471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kwUoFw1i63AKV85YeOpM79iAnzRIac8pe/CUur9ToI=;
        b=XLh0VLKC0GnH4wCdcFFbDU2K1N+A1RU4OcCQyyXVqkL0qMD0328AcjK/Bn2+gYuPkN
         J9FdPAF+s7UP5GMKkV1SMBP7KexbCpZrlFzqooGCO1NICpeW7CoOSGlqmrkM41tqm8en
         7bBzPmdRNbyLMhxqGCq5CnxaoseYuAOLwKwqGyPPpAJhA8FVUxzT4nyKrTlspXsVjQ5Q
         FwOlxWC8PEue9MFLp3gUbzJfZshBN6jNGoyntSBVWWz1+mOD28MTwP1BFU+QiD7Kn9Yz
         sMpRbwKIwHFgMOTJmPcJP5pLCvVXKPtbYY6YfdM/oktFuydge2UeI04DJBKYJhwBGNdm
         aeHA==
X-Gm-Message-State: AC+VfDxx6nCtbJZ0sS7Vylz4kfoZ+7wxPg8zKVa8IERomHd5hV/AJSlX
	6HQDmcUGCNx4F5mdz7TfU7E=
X-Google-Smtp-Source: ACHHUZ5b8yTYf2SfFtwVp6myUaHhmww9y384rCnWI3pX3y4OW8Ohd+vPCKGtSHjAdu2MMDLr9Lg6vw==
X-Received: by 2002:a17:90b:4d91:b0:255:7d50:c1aa with SMTP id oj17-20020a17090b4d9100b002557d50c1aamr8356264pjb.44.1684926470481;
        Wed, 24 May 2023 04:07:50 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id q89-20020a17090a756200b002508f0ac3edsm1163040pjk.53.2023.05.24.04.07.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 May 2023 04:07:50 -0700 (PDT)
Date: Wed, 24 May 2023 19:15:49 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs: remove end parameter from
 z_erofs_pcluster_readmore()
Message-ID: <20230524191549.000037d6.zbestahu@gmail.com>
In-Reply-To: <4056d17c-6cdf-0248-b36f-1fbb7a3685e8@linux.alibaba.com>
References: <20230524101305.22105-1-zbestahu@gmail.com>
	<4056d17c-6cdf-0248-b36f-1fbb7a3685e8@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org, zhangwen@coolpad.com, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, 24 May 2023 18:45:48 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On 2023/5/24 03:13, Yue Hu wrote:
> > From: Yue Hu <huyue2@coolpad.com>
> > 
> > The `end` argument is pointless if it's not backmost.  And we already
> > have `headoffset` in struct `*f`, so let's use this offset to get the
> > `end` for backmost only instead in this function.
> > 
> > Also, remove linux/prefetch.h since it's not used anymore after commit
> > 386292919c25 ("erofs: introduce readmore decompression strategy").
> > 
> > Signed-off-by: Yue Hu <huyue2@coolpad.com>  
> > --->   fs/erofs/zdata.c | 19 ++++++++-----------  
> >   1 file changed, 8 insertions(+), 11 deletions(-)
> > 
> > diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> > index 5cd971bcf95e..b7ebdc8f2135 100644
> > --- a/fs/erofs/zdata.c
> > +++ b/fs/erofs/zdata.c
> > @@ -5,7 +5,6 @@
> >    * Copyright (C) 2022 Alibaba Cloud
> >    */
> >   #include "compress.h"
> > -#include <linux/prefetch.h>
> >   #include <linux/psi.h>
> >   #include <linux/cpuhotplug.h>
> >   #include <trace/events/erofs.h>
> > @@ -1825,16 +1824,16 @@ static void z_erofs_runqueue(struct z_erofs_decompress_frontend *f,
> >    */
> >   static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
> >   				      struct readahead_control *rac,
> > -				      erofs_off_t end,
> > -				      struct page **pagepool,
> > -				      bool backmost)
> > +				      struct page **pagepool, bool backmost)
> >   {
> >   	struct inode *inode = f->inode;
> >   	struct erofs_map_blocks *map = &f->map;
> > -	erofs_off_t cur;
> > +	erofs_off_t cur, end;
> >   	int err;
> >   
> >   	if (backmost) {
> > +		end = f->headoffset +
> > +		      rac ? readahead_length(rac) : PAGE_SIZE - 1;  
> 
> 		could we avoid "?:" here for readability?

Ok, let me change to use if-else branch.
And seems 'newstart' should be just `f->headoffset`.
I will send v2 later.

> 
> Thanks,
> Gao Xiang

