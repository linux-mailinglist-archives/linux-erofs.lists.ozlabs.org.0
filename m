Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A86AC69A379
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Feb 2023 02:36:19 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PHvXx43wjz3cjW
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Feb 2023 12:36:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=TuVEX+qG;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=TuVEX+qG;
	dkim-atps=neutral
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PHvXl6MTJz3f70
	for <linux-erofs@lists.ozlabs.org>; Fri, 17 Feb 2023 12:36:06 +1100 (AEDT)
Received: by mail-pj1-x1031.google.com with SMTP id bt4-20020a17090af00400b002341621377cso7824211pjb.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 16 Feb 2023 17:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJ7SflY2meS6XlN65Pv9owj6VZSWx0v9fxvbNqNRU2A=;
        b=TuVEX+qGEOUHn8Q85BMZaJTFL4PfnJ6dyTgJSh855/3O5hoR7zSrXx4Mb9hMyTUns/
         mv9/jupshxEfehziAzsTyQPENBDr/qVKOPL1s/DmqQ2IXrmmJPeKfcNRiubnhki5ZLAT
         tpfIw+kE4wV8D3CWzH21tpEICoFPC1uB2JH9NCz6CmTjc/2Pm3st+ODgRFFgGUG229nK
         cowrXO+7/RXG6tedXHb2Yub7xn7Z12DQ+GwN0hNwTfJG1wwmBKl5za5FOBDu6As+00U5
         0UrMmcngdbjvHtxn8h/W3uX2wlo7jGEcDk5sEvEqEffcvdR3L0sbVN+4xXlnzmyxH2MQ
         /seg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJ7SflY2meS6XlN65Pv9owj6VZSWx0v9fxvbNqNRU2A=;
        b=jZKLm3lMqLdxFc5WbQaRGOKKBjXwruJ70ULn7I+EsdCIkcUVeNeksPQGKLAtgnghiy
         l/0dqF2WOXyRjpL0S3tvTfBvLuGESpjT3by9uLjw95I3zVSup3Vt3chvqZfYaIl7GeDu
         Pd8HE44bWV3LtS3lBVbSJRpg/4I7sQRliL0JJK+pow5bSjdbTxNRZVPMRcPyO16UMjNE
         22B7PlSFbJe9++UXgWEUZB5LLrYKcYDZoiADj5epJldFjVvrYiQc3poDUOSSf6s8HszR
         NAzCz5yH3iXt4yzctHfVHlGl4IplKUmOpS0dM7GpzkvRLMzMnqOxFd5WvEtnDuML08HA
         wMjw==
X-Gm-Message-State: AO0yUKXSuzMTNSjL+GJJIYSSB4tnkWw52nnelNGr5kVfOYZXzaVXZuYR
	i7oNHabR4RAZpln9k5blUTE=
X-Google-Smtp-Source: AK7set8idwkFvKNHstL6OpY0YXsSIDJQZgqTyU2bM7b8VMyOpIk93NwxYMKGZUWBwAglESfMAk7a+g==
X-Received: by 2002:a17:90b:4f44:b0:234:1a60:a6b0 with SMTP id pj4-20020a17090b4f4400b002341a60a6b0mr9129403pjb.34.1676597763315;
        Thu, 16 Feb 2023 17:36:03 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id js8-20020a17090b148800b00234afca2498sm1054461pjb.28.2023.02.16.17.36.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Feb 2023 17:36:03 -0800 (PST)
Date: Fri, 17 Feb 2023 09:41:57 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] erofs: fix an error code in
 z_erofs_init_zip_subsystem()
Message-ID: <20230217094157.00005eb4.zbestahu@gmail.com>
In-Reply-To: <Y+4d0FRsUq8jPoOu@kili>
References: <Y+4d0FRsUq8jPoOu@kili>
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
Cc: linux-erofs@lists.ozlabs.org, zhangwen@coolpad.com, huyue2@coolpad.com, kernel-janitors@vger.kernel.org, Sandeep Dhavale <dhavale@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 16 Feb 2023 15:13:04 +0300
Dan Carpenter <error27@gmail.com> wrote:

> Return -ENOMEM if alloc_workqueue() fails.  Don't return success.
> 
> Fixes: d8a650adf429 ("erofs: add per-cpu threads for decompression as an option")
> Signed-off-by: Dan Carpenter <error27@gmail.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> ---
>  fs/erofs/zdata.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 8ea3f5fe985e..3247d2422bea 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -475,8 +475,10 @@ int __init z_erofs_init_zip_subsystem(void)
>  
>  	z_erofs_workqueue = alloc_workqueue("erofs_worker",
>  			WQ_UNBOUND | WQ_HIGHPRI, num_possible_cpus());
> -	if (!z_erofs_workqueue)
> +	if (!z_erofs_workqueue) {
> +		err = -ENOMEM;
>  		goto out_error_workqueue_init;
> +	}
>  
>  	err = erofs_init_percpu_workers();
>  	if (err)

