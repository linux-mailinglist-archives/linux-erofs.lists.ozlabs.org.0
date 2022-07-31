Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1DC585F2B
	for <lists+linux-erofs@lfdr.de>; Sun, 31 Jul 2022 15:49:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LwjKx254zz2yZc
	for <lists+linux-erofs@lfdr.de>; Sun, 31 Jul 2022 23:49:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=iZ5FboBY;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=jnhuang95@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=iZ5FboBY;
	dkim-atps=neutral
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LwjKs2079z2xGS
	for <linux-erofs@lists.ozlabs.org>; Sun, 31 Jul 2022 23:49:35 +1000 (AEST)
Received: by mail-pg1-x532.google.com with SMTP id f11so7521015pgj.7
        for <linux-erofs@lists.ozlabs.org>; Sun, 31 Jul 2022 06:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=F+l4hvJ9JiwOK+PwuWtFhsnU9S49WCdGirG4fXRRky8=;
        b=iZ5FboBYMY+Iz3Kyh9TQRHM1LEGCzHepxGL0DKu1SgW88pQwe3hlrr64/+3MVaQDJ6
         vJ0d57e1cYzAlQRjO/Bfx38VZ8dUPg7ZiAti2OGJxhO8l6LWmZcGjJOSY9iIxrTGURpJ
         hlRlzQvkZ2IbiO+VMGZCS44X+CLPzaHntnhQ8NfXYDnkHKJBCAUme/xebgr+r5WIa/Xi
         MyuM3GqDLn9mS6V/29cZHbTQIAPP/TFT8akoSeOhnOY1UI9qL4Iftm3Ev126sbuvF4zP
         WtKjEj0t0t2Q4r191AvxQiwOXkN3cWom0CNQXLdtB1VgzpU/30CoVk+SE+4/w3tPzMnu
         +ZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=F+l4hvJ9JiwOK+PwuWtFhsnU9S49WCdGirG4fXRRky8=;
        b=AtrHeHXmo5+uarR1JkG51uJsKC07aE8waa570P/xFUBdoP0WrmHngjc/2WrLyx69Qo
         ZxD8cy6XhGwqXK2Q9HFV0/l7NNo1uPJyqWbF4idb2ff71RY/CXX1oLbQQi/srlpAJkwP
         YMWOzmKrYy6ghirLHxDM6kiy0Rz0LLxr00BKTC0T1O/gxgzlPElBjOTJy0ZAqjmbD5c6
         QqyG9XzzUyf3IvUAMJdoLj4b+sRMuwq1Ns6X+RBftlTfRgIm53jX/ynBCgTlRh+6nRkl
         Cv6o/+NRt74xvLtiY9b4k/bIwIOaGJXMfaZY/5bKm4xlDQnlop6ofPN/sTJyhGsKjIgW
         mlCw==
X-Gm-Message-State: ACgBeo1ZtDnGR7QHHV3Sh0/WPxsfhomPV24W9gxV9RTvbplgTDPSPPZC
	lYDeeohrioYc5HZ5sBOQRexwaseku3SD5D7t
X-Google-Smtp-Source: AA6agR660VlBayIyQMk8wZaNK0XSwW71axAhvALMLlOAzND7hGlsC78Gt6cC3iYccctj/iz9l7v6uA==
X-Received: by 2002:a65:6d9a:0:b0:41c:c77:7b6 with SMTP id bc26-20020a656d9a000000b0041c0c7707b6mr975713pgb.139.1659275371041;
        Sun, 31 Jul 2022 06:49:31 -0700 (PDT)
Received: from [192.168.50.25] (n219077110185.netvigator.com. [219.77.110.185])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c24d00b0016db7f49cc2sm7410687plg.115.2022.07.31.06.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jul 2022 06:49:30 -0700 (PDT)
Message-ID: <32a4a652-47ec-cee9-a7ed-f0cc15ab5872@gmail.com>
Date: Sun, 31 Jul 2022 21:49:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
From: Huang Jianan <jnhuang95@gmail.com>
Subject: Re: [PATCH 1/1] fs/erofs: silence erofs_probe()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
References: <20220731091006.50073-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20220731091006.50073-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: u-boot@lists.denx.de, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



在 2022/7/31 17:10, Heinrich Schuchardt 写道:
> fs_set_blk_dev() probes all file-systems until it finds one that matches
> the volume. We do not expect any console output for non-matching
> file-systems.
> 
> Convert error messages in erofs_read_superblock() to debug output.
> 
> Fixes: 830613f8f5bb ("fs/erofs: add erofs filesystem support")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>   fs/erofs/super.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 4cca322b9e..095754dc28 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -65,14 +65,14 @@ int erofs_read_superblock(void)
>   
>   	ret = erofs_blk_read(data, 0, 1);
>   	if (ret < 0) {
> -		erofs_err("cannot read erofs superblock: %d", ret);
> +		erofs_dbg("cannot read erofs superblock: %d", ret);
>   		return -EIO;
>   	}
>   	dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
>   
>   	ret = -EINVAL;
>   	if (le32_to_cpu(dsb->magic) != EROFS_SUPER_MAGIC_V1) {
> -		erofs_err("cannot find valid erofs superblock");
> +		erofs_dbg("cannot find valid erofs superblock");
>   		return ret;
>   	}
>   
> @@ -81,7 +81,7 @@ int erofs_read_superblock(void)
>   	blkszbits = dsb->blkszbits;
>   	/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
>   	if (blkszbits != LOG_BLOCK_SIZE) {
> -		erofs_err("blksize %u isn't supported on this platform",
> +		erofs_dbg("blksize %u isn't supported on this platform",
>   			  1 << blkszbits);
>   		return ret;
>   	}
Reviewed-by: Huang Jianan <jnhuang95@gmail.com>

Thanks,
Jianan
