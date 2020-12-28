Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 819272E365A
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Dec 2020 12:21:03 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D4FV43Pf0zDqB4
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Dec 2020 22:21:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102f;
 helo=mail-pj1-x102f.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=P37F5Er7; dkim-atps=neutral
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D4FTx4ZClzDq9L
 for <linux-erofs@lists.ozlabs.org>; Mon, 28 Dec 2020 22:20:49 +1100 (AEDT)
Received: by mail-pj1-x102f.google.com with SMTP id v1so5783256pjr.2
 for <linux-erofs@lists.ozlabs.org>; Mon, 28 Dec 2020 03:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kuGD+aRlt7e7AFg0PAxn8am9IOrDXm6d7NEdCXeB74Q=;
 b=P37F5Er7/kW9awyDkahIf2y9dCKshFkhxJgFEetXNUb+aJdmUTjAJ9EaUJzXnDuq2S
 odpH2L2MGzlFcHbFKUUQPTHRPeKJjK/rFpIvx9KSErKhpQEwCHYwV4AF84hzwvUQaB6I
 DiX4erZflvxG4LshVt6cN+7acZ+9rPG2oOOi1xC/P7ccYD7mnfgu8cabIfPUOd36zZ3M
 LvxATMHFZ7BJ8hRyDMJkAFu+BqY7ToIY4QkeTeONonem3gSokdLRFkxcvvunLrDxfZ2h
 cc9gbKcrdvUMOUepYTiq/EorGuN/8+9czs/2hMKk4n9XkykLPzIc5rU00GGPY8SRhxQk
 1rbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kuGD+aRlt7e7AFg0PAxn8am9IOrDXm6d7NEdCXeB74Q=;
 b=lPIaEiNxSWmynHK6LNlScpCAXLOyie4xkevOKvTUxO2sPRaaC4gfb3L3uFeG4aDQUA
 g93LOanwIyur7mHNUQHSIMKNVw9K+RZCKVsEb1w+AV6SfX0uqXZ22N5et1B2w9lc8NSl
 ePONfxiDCGY/5yiNwzsIAif8ga1NPitrOOqtRNfBv15Ez0KzumDQs5ZPn2qc5zSYEyQn
 g9ascOptpmKcKTuXT9QbGfIBnBnl49MCGjGaUVY/K4yj8ZkuySXqS61MQ9hBK/Unl7e1
 EimVg2nPJOhSbgNZPC7zh8ObErQfy1LcRoz+Qmv4Q6K8He8iOIJRj5vgWKr1boT4KPRU
 /zCg==
X-Gm-Message-State: AOAM5334V2KT7cBvawc0bUehC4OPh6Hscilz12N6WGphOLTiZKX6EGQW
 OP+JmhOXYPi/ygBXKuG4ZKU=
X-Google-Smtp-Source: ABdhPJwiABP/UfuHWPhRY5YXLOyarZVmhROKwA12ipBl/QxcFCmLrySvTc+D/7BT1rD3ptpDZY7kmA==
X-Received: by 2002:a17:90a:6587:: with SMTP id
 k7mr20814083pjj.154.1609154446392; 
 Mon, 28 Dec 2020 03:20:46 -0800 (PST)
Received: from localhost ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id d4sm13553148pjz.28.2020.12.28.03.20.44
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Dec 2020 03:20:46 -0800 (PST)
Date: Mon, 28 Dec 2020 19:20:48 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@redhat.com>
Subject: Re: [PATCH v2] AOSP: erofs-utils: fix sub-directory prefix for
 canned fs_config
Message-ID: <20201228192048.00006a93.zbestahu@gmail.com>
In-Reply-To: <20201228105146.2939914-1-hsiangkao@redhat.com>
References: <20201226062736.29920-1-hsiangkao@aol.com>
 <20201228105146.2939914-1-hsiangkao@redhat.com>
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
Cc: Yue Hu <huyue2@yulong.com>, zhangwen@yulong.com,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, 28 Dec 2020 18:51:46 +0800
Gao Xiang <hsiangkao@redhat.com> wrote:

> From: Gao Xiang <hsiangkao@aol.com>
> 
> "failed to find [%s] in canned fs_config" was observed by using
> "--fs-config-file" option as reported by Yue Hu [1].
> 
> The root cause was that the mountpoint prefix to subdirectories is
> also needed if "--mount-point" presents. However, such prefix cannot
> be added by just using erofs_fspath().
> 
> One exception is that the root directory itself needs to be handled
> specially for canned fs_config. For such case, the prefix of the root
> directory has to be dropped instead.
> 
> [1]
> https://lkml.kernel.org/r/20201222020430.12512-1-zbestahu@gmail.com
> 
> Link:
> https://lore.kernel.org/r/20201226062736.29920-1-hsiangkao@aol.com
> Fixes: 8a9e8046f170 ("AOSP: erofs-utils: add fs_config support")
> Reported-by: Yue Hu <huyue2@yulong.com> Signed-off-by: Gao Xiang
> <hsiangkao@aol.com> ---
> changes since v2:
>  - fix IS_ROOT misuse reported by Jianan, very sorry about this since
>    I know little about canned fs_config.
> 
> (please kindly test again...)
> 
>  lib/inode.c | 39 +++++++++++++++++++++++++--------------
>  1 file changed, 25 insertions(+), 14 deletions(-)
> 
> diff --git a/lib/inode.c b/lib/inode.c
> index 0c4839d..e6159c9 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -696,32 +696,43 @@ int erofs_droid_inode_fsconfig(struct
> erofs_inode *inode, /* filesystem_config does not preserve file type
> bits */ mode_t stat_file_type_mask = st->st_mode & S_IFMT;
>  	unsigned int uid = 0, gid = 0, mode = 0;
> -	char *fspath;
> +	const char *fspath;
> +	char *decorated = NULL;
>  
>  	inode->capabilities = 0;
> +	if (!cfg.fs_config_file && !cfg.mount_point)
> +		return 0;
> +
> +	if (!cfg.mount_point ||
> +	/* have to drop the mountpoint for rootdir of canned
> fsconfig */
> +	    (cfg.fs_config_file && erofs_fspath(path)[0] == '\0')) {
> +		fspath = erofs_fspath(path);
> +	} else {
> +		if (asprintf(&decorated, "%s/%s", cfg.mount_point,
> +			     erofs_fspath(path)) <= 0)
> +			return -ENOMEM;
> +		fspath = decorated;
> +	}
> +
>  	if (cfg.fs_config_file)

Whether we can use the first "cfg.fs_config_file" when loading canned
fs-config to reduce/simplify these duplicated calling?

> -		canned_fs_config(erofs_fspath(path),
> +		canned_fs_config(fspath,
>  				 S_ISDIR(st->st_mode),
>  				 cfg.target_out_path,
>  				 &uid, &gid, &mode,
> &inode->capabilities);
> -	else if (cfg.mount_point) {
> -		if (asprintf(&fspath, "%s/%s", cfg.mount_point,
> -			     erofs_fspath(path)) <= 0)
> -			return -ENOMEM;
> -
> +	else
>  		fs_config(fspath, S_ISDIR(st->st_mode),
>  			  cfg.target_out_path,
>  			  &uid, &gid, &mode, &inode->capabilities);
> -		free(fspath);
> -	}
> -	st->st_uid = uid;
> -	st->st_gid = gid;
> -	st->st_mode = mode | stat_file_type_mask;
>  
>  	erofs_dbg("/%s -> mode = 0x%x, uid = 0x%x, gid = 0x%x, "
>  		  "capabilities = 0x%" PRIx64 "\n",
> -		  erofs_fspath(path),
> -		  mode, uid, gid, inode->capabilities);
> +		  fspath, mode, uid, gid, inode->capabilities);
> +
> +	if (decorated)
> +		free(decorated);
> +	st->st_uid = uid;
> +	st->st_gid = gid;
> +	st->st_mode = mode | stat_file_type_mask;
>  	return 0;
>  }
>  #else

