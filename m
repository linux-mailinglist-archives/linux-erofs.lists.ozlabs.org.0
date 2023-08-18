Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0677805BF
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Aug 2023 07:42:29 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=EEYomjMC;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RRrNz2K3lz3cBb
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Aug 2023 15:42:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=EEYomjMC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RRrNr30RHz2ytc
	for <linux-erofs@lists.ozlabs.org>; Fri, 18 Aug 2023 15:42:18 +1000 (AEST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-689e8115f8dso499983b3a.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 17 Aug 2023 22:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692337333; x=1692942133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vbsontTSe91e+7xkegR3LXuXKl/OSAKaLmQPXVzW/Y=;
        b=EEYomjMCvwvK4W68km7HvqhGMG7uMp9aMRL2By/T6Vmw0UpPDXVzkeESzUEcJZhrnz
         ZcC5PQ68aPsSce1fvL4aGR/YzMCki7QL/c6pTftL5rdDyi2Q4OLzuPHU4kdmIu2sqgmw
         d94SiL8OeBV8zTIr0smNhUpFK0xR8IsOu2+3ZV0mwjV+sf6weeWOj7Xgpdnb3tm8+ys3
         PtsUu+d0oQFovM2yIENNP8YDhZFd3vrX0oto9HYIXV+//093St1mYGxwMBYnbTVXqLvr
         lMg+gREVHMrKI2onsYHXK4aKr9V2OufZsYl7xgnpVL4Kox/1+2MmPYj6tzUb1O04bVTk
         hRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692337333; x=1692942133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vbsontTSe91e+7xkegR3LXuXKl/OSAKaLmQPXVzW/Y=;
        b=h6rU8RGy2oF69aNhS0Jq/BjhzueCm+8ODNh7HRc1qG6wx9SvsO/tLu6MQRTBc4KU81
         ElRq5G5CRqGbxmPuMnyfVUwaQcjbfaMyXsNRoipTUKXvVTosRynIDmgJta3f1YIxNZqq
         xRDwKRzIesm8/lsiKiwfCjGR0POYQgAYYgqCAbtmTRsB3/uyocsY77fL2Pp1F07nmlwZ
         8XkM2hL0WJUBZL3rOMfJgkfBPfWfNLSbJZjqMgF6S8vrwzQMk002eDO9nMZFzke8fBt2
         EunXufmaxLEvX2k93qr5+8mW8deNls1RlOMcOBWqpDtFpWkGbfMo0njn9zbvupC1vDIs
         i8CA==
X-Gm-Message-State: AOJu0Yw88f4PajBoK0iyJ6JMScZTWeyedAWCrX9t4zHPJDUJzOEumaZL
	6TcjjM/pEu5iK/8YBwld+jk=
X-Google-Smtp-Source: AGHT+IGUtWffSgvMQmRtj5Av3UCmUmKImM8BO8FzcM/titcddiHq1b7c9c+/A/73gLWrjU0DljOJlA==
X-Received: by 2002:a05:6a00:22c4:b0:687:596e:fa6a with SMTP id f4-20020a056a0022c400b00687596efa6amr2069845pfj.16.1692337333341;
        Thu, 17 Aug 2023 22:42:13 -0700 (PDT)
Received: from localhost ([156.236.96.163])
        by smtp.gmail.com with ESMTPSA id r13-20020a62e40d000000b00686f0133b49sm694048pfh.63.2023.08.17.22.42.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Aug 2023 22:42:13 -0700 (PDT)
Date: Fri, 18 Aug 2023 13:51:56 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 6/8] erofs: get rid of fe->backmost for cache
 decompression
Message-ID: <20230818135156.00005a05.zbestahu@gmail.com>
In-Reply-To: <20230817082813.81180-6-hsiangkao@linux.alibaba.com>
References: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
	<20230817082813.81180-6-hsiangkao@linux.alibaba.com>
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

On Thu, 17 Aug 2023 16:28:11 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> EROFS_MAP_FULL_MAPPED is more accurate to decide if caching the last
> incomplete pcluster for later read or not.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/zdata.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 4009283944ca..c28945532a02 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -528,8 +528,6 @@ struct z_erofs_decompress_frontend {
>  	z_erofs_next_pcluster_t owned_head;
>  	enum z_erofs_pclustermode mode;
>  
> -	/* used for applying cache strategy on the fly */
> -	bool backmost;
>  	erofs_off_t headoffset;
>  
>  	/* a pointer used to pick up inplace I/O pages */
> @@ -538,7 +536,7 @@ struct z_erofs_decompress_frontend {
>  
>  #define DECOMPRESS_FRONTEND_INIT(__i) { \
>  	.inode = __i, .owned_head = Z_EROFS_PCLUSTER_TAIL, \
> -	.mode = Z_EROFS_PCLUSTER_FOLLOWED, .backmost = true }
> +	.mode = Z_EROFS_PCLUSTER_FOLLOWED }
>  
>  static bool z_erofs_should_alloc_cache(struct z_erofs_decompress_frontend *fe)
>  {
> @@ -547,7 +545,7 @@ static bool z_erofs_should_alloc_cache(struct z_erofs_decompress_frontend *fe)
>  	if (cachestrategy <= EROFS_ZIP_CACHE_DISABLED)
>  		return false;
>  
> -	if (fe->backmost)
> +	if (!(fe->map.m_flags & EROFS_MAP_FULL_MAPPED))

So, i understand (map.m_flags & EROFS_MAP_FULL_MAPPED) should be false if allocate cache is needed
(fe->backmost is true)?

>  		return true;
>  
>  	if (cachestrategy >= EROFS_ZIP_CACHE_READAROUND &&
> @@ -939,7 +937,6 @@ static void z_erofs_pcluster_end(struct z_erofs_decompress_frontend *fe)
>  		erofs_workgroup_put(&pcl->obj);
>  
>  	fe->pcl = NULL;
> -	fe->backmost = false;
>  }
>  
>  static int z_erofs_read_fragment(struct super_block *sb, struct page *page,

