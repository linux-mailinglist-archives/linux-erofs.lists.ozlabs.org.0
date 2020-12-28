Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 554862E349C
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Dec 2020 08:06:04 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D47qs37XPzDqC3
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Dec 2020 18:06:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b;
 helo=mail-pl1-x62b.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=fbdzEjA4; dkim-atps=neutral
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D47qm2q5HzDq6B
 for <linux-erofs@lists.ozlabs.org>; Mon, 28 Dec 2020 18:05:52 +1100 (AEDT)
Received: by mail-pl1-x62b.google.com with SMTP id be12so5229890plb.4
 for <linux-erofs@lists.ozlabs.org>; Sun, 27 Dec 2020 23:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:date:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VnQ82fWQV9FVqOmIDpaIwIjNvzXNgUfNqFuI91hYYSc=;
 b=fbdzEjA4GpnOIrigykZOFmEnjwsBw1sOpphPSEBNkWTUXMXAtEVyEOiO7F+vPpwnlO
 sWCi/QvSxPEFD3Ti09fofd3AqujitCtpfGV3qrBQZcVZq+PpTI0uf9Ld/vxN2eOZibka
 2TwBtcQgWo/PwiqD2WE9HhJqoFWTcOlM9ZNjrBT2/zvMcFm9te/ui/rKYSklkN0CtGmZ
 eSb+nEatYWEjqMUuy7HxLOAOdiC3p7pESBClnfTwf4sTelx/JsVNAbPXEx0d30uyGxxh
 R0u1u4cT+vUmPQ6FJ2zRFWjeCr/XISlraZqYMmQ8sP/Ia108AvtYBjAqPCbavFhm0H4U
 xz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VnQ82fWQV9FVqOmIDpaIwIjNvzXNgUfNqFuI91hYYSc=;
 b=ospGZn6y2krHWFTOfn96X+qLXCRSs2K0l38BnXZmB1v1BIA5CI+dGmNM3XQajiCFmt
 NVqJ325ZatWatM/4iyZNHeGrvxx+xN59vXx3gXT8PKHedhWclQ/+qYbi8UqEIB/ld/iq
 V013ZYNL3ZwO3+ieWmWYYH+nYit/dRA3QzB4cyGtNct6MglvYWlf2vkzxMsgq5c2dfmG
 R3wBa4of2JHnV7xUoAFrQLI05+C+HQBtIOlxHJRd0xIrkWsMGozRo8w8U1xCphcGkj/C
 vHVkemmKOdxXF04cxYi3qUxxUmmxUERIm32fS3BBbAQ5TQFrP7ODG254codNS4WtAjFX
 2y+A==
X-Gm-Message-State: AOAM530s14PyqLoYOcWOeRJTVCVtwED8VCozHhe3bQZJWcbc0Y2zOR7y
 /MueHJU/DHEpirDB8kdDOW0=
X-Google-Smtp-Source: ABdhPJzFpzokL6UztAkv6gHSYP9ss2PqXBI9swdh7kM5oslTszurW3DIxgKploCYS0TjI1jcncAeOQ==
X-Received: by 2002:a17:90a:5513:: with SMTP id
 b19mr20013317pji.99.1609139148820; 
 Sun, 27 Dec 2020 23:05:48 -0800 (PST)
Received: from localhost ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id 17sm34354840pfj.91.2020.12.27.23.05.46
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 27 Dec 2020 23:05:48 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
X-Google-Original-From: Yue Hu <zbestahu@gmai.com>
Date: Mon, 28 Dec 2020 15:05:52 +0800
To: Gao Xiang <hsiangkao@aol.com>
Subject: Re: [PATCH] AOSP: erofs-utils: fix sub-directory prefix for canned
 fs_config
Message-ID: <20201228150552.00002270.zbestahu@gmail.com>
In-Reply-To: <20201226062736.29920-1-hsiangkao@aol.com>
References: <20201226062736.29920-1-hsiangkao.ref@aol.com>
 <20201226062736.29920-1-hsiangkao@aol.com>
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
Cc: Yue Hu <zbestahu@gmail.com>, Yue Hu <huyue2@yulong.com>,
 zhangwen@yulong.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, 26 Dec 2020 14:27:36 +0800
Gao Xiang <hsiangkao@aol.com> wrote:

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
> Fixes: 8a9e8046f170 ("AOSP: erofs-utils: add fs_config support")
> Reported-by: Yue Hu <huyue2@yulong.com>
> Signed-off-by: Gao Xiang <hsiangkao@aol.com>
> ---
> Hi Yue, Jianan,
> 
> I've verified cuttlefish booting with success, It'd be better to
> verify this patchset on your sides. Please kingly leave "Tested-by:"
> if possible.

Hi Xiang,

I'm testing now. I will inform once finished.

Thx.

> 
> Hi Guifu,
> Could you also review this patch ? This needs to be included in
> the upcoming v1.2.1 as well...
> 
> Thanks,
> Gao Xiang
> 
>  lib/inode.c | 39 +++++++++++++++++++++++++--------------
>  1 file changed, 25 insertions(+), 14 deletions(-)
> 
> diff --git a/lib/inode.c b/lib/inode.c
> index 0c4839dc7152..f88966d26fce 100644
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
> +	    (cfg.fs_config_file && IS_ROOT(inode))) {
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

