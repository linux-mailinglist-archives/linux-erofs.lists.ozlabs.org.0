Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4259F6A90A7
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Mar 2023 06:58:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PSchZ5cq2z3cdJ
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Mar 2023 16:58:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=MeRKq2f7;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=MeRKq2f7;
	dkim-atps=neutral
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PSchR5kwFz3cJY
	for <linux-erofs@lists.ozlabs.org>; Fri,  3 Mar 2023 16:57:57 +1100 (AEDT)
Received: by mail-pl1-x62c.google.com with SMTP id y11so1684436plg.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 02 Mar 2023 21:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677823073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUTfS2+3FPzIzEJDDkoc98vj3x8t5RG7C1KzgJzPKKw=;
        b=MeRKq2f7POvdWPnz4p9BFZj3a0y1Y0kOVy/b7vaUsaZhLVWSWYLKtvndL6Ifp4bjTq
         MKslva0R3P7hXssGD8CBf2N9cap1JB8p5GKZ14eOhVAUz4BZOpVVy1gEA+/c1vuLB4k/
         8mRhtTMc9HRxTuu6aYi8ZPEBAA/eMIIRy8kdNo4i151Zu/fAxHHMgDZAyJdxQ6l2yHP4
         +Fl9i4ffBwinRN4KjYTQAH4JkxeCyVlaXHzII4SCPVueyTC9dZdDLSooxoZKxWAh/awV
         rWuCe/YJS2HdGTKpBBRD6LP0jDeWuW/dFDO8xxK3nOPKarNstu0AphhmvTp6QiM+tOog
         5+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677823073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUTfS2+3FPzIzEJDDkoc98vj3x8t5RG7C1KzgJzPKKw=;
        b=iTJhD2V7FdZjRtyGmQj0HcU3nC36NfY+8OZ/PVuwr+WEHJu/ne5lk/CMVmVNDsfKON
         UftO4GJrFokBBlwa4AmwFIXPouZziFXnrWuSPBlzjemHyK+2HTrZN6YlbCFPlvBlSlSi
         rLy56SGWTVaCUu1zVNbQv19oRbk/Ft8xyswfcBFfGGQRasYf7jLo0H81vMoxla/XxLdR
         Fg2OhK4LdqCwQD7XquKVgTZTMo0hiQKIDgq/plq4MRmq7RXIn2/5COCphrqobmtS+9t5
         jdp/GhRJKZ5I/vG2CLZ1xuUcuD5wGMZKApNsvpezv94ZvcXhiaJ0BdFj/FkxcfIptGcu
         QumA==
X-Gm-Message-State: AO0yUKUFyad94RZsh3iaQw3J8yeNtQbjhs2Elh8JRRaOgMr4+sFEhhZx
	4GdoYEWukkC2gNg5tXTj71c=
X-Google-Smtp-Source: AK7set+eR3bLDGqvYUGZfUNSTKUCHn5whGal/ExY95sZvlgVuGNAa5zOZuvBWTQDKY+qB7w+1B5tug==
X-Received: by 2002:a05:6a20:8408:b0:cd:47dc:829e with SMTP id c8-20020a056a20840800b000cd47dc829emr659752pzd.12.1677823073280;
        Thu, 02 Mar 2023 21:57:53 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id k13-20020aa790cd000000b005d6999eec90sm671274pfk.120.2023.03.02.21.57.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Mar 2023 21:57:52 -0800 (PST)
Date: Fri, 3 Mar 2023 14:04:05 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Yangtao Li <frank.li@vivo.com>
Subject: Re: [PATCH] erofs: mark z_erofs_lzma_init/erofs_pcpubuf_init w/
 __init
Message-ID: <20230303140405.000035a6.zbestahu@gmail.com>
In-Reply-To: <20230303031418.64553-1-frank.li@vivo.com>
References: <20230303031418.64553-1-frank.li@vivo.com>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri,  3 Mar 2023 11:14:18 +0800
Yangtao Li <frank.li@vivo.com> wrote:

> They are used during the erofs module init phase. Let's mark it as
> __init like any other function.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/erofs/decompressor_lzma.c | 2 +-
>  fs/erofs/pcpubuf.c           | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
> index 091fd5adf818..307b37f0b9f5 100644
> --- a/fs/erofs/decompressor_lzma.c
> +++ b/fs/erofs/decompressor_lzma.c
> @@ -47,7 +47,7 @@ void z_erofs_lzma_exit(void)
>  	}
>  }
>  
> -int z_erofs_lzma_init(void)
> +int __init z_erofs_lzma_init(void)
>  {
>  	unsigned int i;
>  
> diff --git a/fs/erofs/pcpubuf.c b/fs/erofs/pcpubuf.c
> index a2efd833d1b6..c7a4b1d77069 100644
> --- a/fs/erofs/pcpubuf.c
> +++ b/fs/erofs/pcpubuf.c
> @@ -114,7 +114,7 @@ int erofs_pcpubuf_growsize(unsigned int nrpages)
>  	return ret;
>  }
>  
> -void erofs_pcpubuf_init(void)
> +void __init erofs_pcpubuf_init(void)
>  {
>  	int cpu;
>  

Update them in internal.h as well?

