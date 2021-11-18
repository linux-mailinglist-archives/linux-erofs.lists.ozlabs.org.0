Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8383D4553A0
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Nov 2021 05:02:03 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HvmMY2kF1z2ynQ
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Nov 2021 15:02:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Y7hqEDFb;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1032;
 helo=mail-pj1-x1032.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=Y7hqEDFb; dkim-atps=neutral
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HvmMQ0lJkz2yKF
 for <linux-erofs@lists.ozlabs.org>; Thu, 18 Nov 2021 15:01:51 +1100 (AEDT)
Received: by mail-pj1-x1032.google.com with SMTP id
 y14-20020a17090a2b4e00b001a5824f4918so7049406pjc.4
 for <linux-erofs@lists.ozlabs.org>; Wed, 17 Nov 2021 20:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UxMbby/NVWZFt2XXr12pC+bZhXoF6i02LW0x3PPfYa8=;
 b=Y7hqEDFbTsL8hZGvSLLN0GP0Q7Va+ztEQXZqWHEWDtV0tNSUaoIgO9dUGkhhIWjZAf
 aGN/jitA+3d5mDfvztXLxW1UIfCZS/12QwlwEXkf+Huvpq54q2kM46KF4yxA8+7pBHmb
 JftOGrAH7Teypu5e8pLW3cHc43pC+1OvltS0DoJkBH89qIbauAgB4Ore3US1dQxzruXH
 bMHVVgBvCevLYQAR9CvJDns/wEe4P6+MS+Y4D4YrqNpk2g5Bsi2Jcqb3RMfR2wi9AINk
 tAXN6joU3pQUaxMeDv8oQKDOSVoCaKCSdg9azYe7SBbMqc/ux/7ysw1cGXNWv13k8H0P
 NS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UxMbby/NVWZFt2XXr12pC+bZhXoF6i02LW0x3PPfYa8=;
 b=ZP30E9S6jC++AYfTxbnY1PLNRWxJ8Saoq0pPKCXgAlusIeybo5ypK9GBHlL8Wu74vK
 YsUswChRH7RMf/qnrv14zmqpVmupYoCoTCwCd6jLNmWQyK5V6Pl1aQhK8D4QvTWQfY6K
 iQzm42T18JA6IVHhlIyeD5udMErlZuPoKGKrHR5b9MHDgUp1yXj+60kASbpGYlI5zG3B
 8LG9NNZb5MbqNecB5eT7/LS6+OCVfNOWE7kmaalxi8nBQKBTss6lGjvQoJqjbHBbMGlj
 rb+MwkwUyuDaBJUFoPGL9MuxukUa/PbncqqNIWxqY/PQxzRjRbLZq+Ta3txsvOmGyUeS
 Pb9g==
X-Gm-Message-State: AOAM531Dj4itjvJu71yn73/oKcrVA18wpHwHA3qez4AXV/D52dOQUrUE
 fK0CrKKqdR5KQLllgzCaB70=
X-Google-Smtp-Source: ABdhPJz7lmQYo3LunGNGd9aujRAL57UazthT4WJxZbFeKg7ta0cdDWx6WjbQvM9j51Z9MxN8waqUSg==
X-Received: by 2002:a17:90b:4f85:: with SMTP id
 qe5mr6565707pjb.167.1637208108747; 
 Wed, 17 Nov 2021 20:01:48 -0800 (PST)
Received: from localhost ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id h64sm1111412pfe.128.2021.11.17.20.01.47
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 17 Nov 2021 20:01:48 -0800 (PST)
Date: Thu, 18 Nov 2021 11:59:26 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <xiang@kernel.org>
Subject: Re: [PATCH 2/2] erofs-utils: manpage: document `noinline_data'
 extended option
Message-ID: <20211118115926.000004a6.zbestahu@gmail.com>
In-Reply-To: <20211117015757.3323-2-xiang@kernel.org>
References: <20211117015757.3323-1-xiang@kernel.org>
 <20211117015757.3323-2-xiang@kernel.org>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, 17 Nov 2021 09:57:57 +0800
Gao Xiang <xiang@kernel.org> wrote:

> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Add documentation for `noinline_data' as well.
> 
> Fixes: 60549d52c3b6 ("erofs-utils: add "noinline_data" extended option")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  man/mkfs.erofs.1 | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
> index f2e7d690c215..9c7788efbfec 100644
> --- a/man/mkfs.erofs.1
> +++ b/man/mkfs.erofs.1
> @@ -52,6 +52,9 @@ Forcely generate compact inodes (32-byte inodes) to output.
>  .BI force-inode-extended
>  Forcely generate extended inodes (64-byte inodes) to output.
>  .TP
> +.BI noinline_data
> +Don't inline regular files for FSDAX support (Linux v5.15+).
> +.TP

Reviewed-by: Yue Hu <huyue2@yulong.com>

Thanks.

>  .BI force-inode-blockmap
>  Forcely generate inode chunk format in 4-byte block address array.
>  .TP

