Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F712E36BF
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Dec 2020 12:47:11 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D4G4D1zv2zDqC5
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Dec 2020 22:47:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::433;
 helo=mail-pf1-x433.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=VE221IZY; dkim-atps=neutral
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D4G471rJ6zDq9d
 for <linux-erofs@lists.ozlabs.org>; Mon, 28 Dec 2020 22:47:00 +1100 (AEDT)
Received: by mail-pf1-x433.google.com with SMTP id t22so6178417pfl.3
 for <linux-erofs@lists.ozlabs.org>; Mon, 28 Dec 2020 03:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=G/CxAUQMBB/950W7ILF3H1Z+TUvEYtltBR44JZrmK9M=;
 b=VE221IZYlcSXTl95w7uni52pEv4X7hoX9RmNVYxm6lGyX6lSt2dDjegCgQB10MFtBj
 ywLihMJj2tdhffraCo6gnNr+RN+dyd8P/u+0IUGZ6av2HH8oxGWgQy1TcvS1nhm+cEaW
 WHshLWhjLZtNxzSvvHHcgNWmEWpOKIGz7xOlSFmTllwfhIQf9pqBQIuLbtIykyxPKidp
 BKzvaxN/G4e/EceVGAcxjuIFyQ6AZ8UPu+je+L59JHcSCYzfdbRO97JohEJOukW1sdhw
 /GahCYpBmia7sE7wdVFi/fTlg1q49EQxelC1HW3decLkqVM4migvi9CoUTf6QhWBpfJT
 jsbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=G/CxAUQMBB/950W7ILF3H1Z+TUvEYtltBR44JZrmK9M=;
 b=ICXdIU1tamsgf+XZPdXfZiCYNUX5toThCgPZs5f8Tr+XFPit9K0ufJnu6+GQ8TH5V5
 w8GunGmTPSoVeWqcaHMmRjlBrB0zprChZUT6KYAQohNWa0ps6kCjusWZuQVUp52+t5b/
 YEWZTtOXbNsUW4rcCUncfkp1hffG+Mt/nG2+X117ttcqT/qBfMOVNSAoFRoM1V6b6eJq
 EfupAu3hsoHC60ewkQ0fvE0r+2xWVLHdsmbte8EOpmw1mKb4g6p3ZEZ4rgwBiFop2YBf
 /v40BoNFId+vJ/r+wcPOEtOliYujNZEFD3FPgRO+8LjKeKU3U112cgaB9fsoeiCeLBu4
 0jNA==
X-Gm-Message-State: AOAM531L7CuPkrQzE54sMVwup/saPApBwp6eMxL0NaSvEapi+0kcYyFt
 D6PpsYjPWlxyeczI64yblRY=
X-Google-Smtp-Source: ABdhPJxMOsHzv2A6GUj0yFsDL3GKTK4Eixcd73ZSuMQDaSOsbwFGaCAWLUWHGRDorpWTGqcrQFz0Ow==
X-Received: by 2002:a63:c64c:: with SMTP id x12mr37295217pgg.293.1609156016920; 
 Mon, 28 Dec 2020 03:46:56 -0800 (PST)
Received: from localhost ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id k125sm35451759pga.57.2020.12.28.03.46.54
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Dec 2020 03:46:56 -0800 (PST)
Date: Mon, 28 Dec 2020 19:46:56 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@redhat.com>
Subject: Re: [PATCH v2] AOSP: erofs-utils: fix sub-directory prefix for
 canned fs_config
Message-ID: <20201228194656.000059dc.zbestahu@gmail.com>
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

Hi Xiang,

Works fine to me for canned/non-canned fs_config.

Tested-by: Yue Hu <huyue2@yulong.com>

Thx.

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

