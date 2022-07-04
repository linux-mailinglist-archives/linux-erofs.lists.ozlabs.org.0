Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 487D3564B95
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Jul 2022 04:18:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LbqGp34cRz3bqF
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Jul 2022 12:18:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=oTAfdf9Z;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=oTAfdf9Z;
	dkim-atps=neutral
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LbqGj4GK4z3bPX
	for <linux-erofs@lists.ozlabs.org>; Mon,  4 Jul 2022 12:18:20 +1000 (AEST)
Received: by mail-pf1-x42a.google.com with SMTP id r6so3376996pfq.6
        for <linux-erofs@lists.ozlabs.org>; Sun, 03 Jul 2022 19:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GAH0ByD3qQnJfhYDB9Gika0Z8joolySg5TVKCrAgjGY=;
        b=oTAfdf9ZuEnTfz8hduwDq1UMqGeOUVgbJ0xtTQ81TquX5hI7/2ChnqaxTv+5Ad+yuw
         z1BsNTATEwhbl4irmBs9y4nQ0ykSJeCsWtEl5NjJZG1QjEZNH8AHzg6xb7JR3d7AEiM2
         tnJTnLZj0R7e6wZAr3Et+oK5ia2ntIyxLu7WohbZALXiBfo0WGNF5eNxDGBu+gF6XVaa
         MT6PxG7LkwdY1wfL1uwcuDRrdMudE+pKqa2Nn9cBGitwKlerL3U77sNAf1xmwv7QGF1g
         331IPkwDdJ9utdp6nYf5NjAsl/+s6JdD8ZzoZae4rl4NQc5yTei/pEFRqOKJa7Z9/gXv
         dxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GAH0ByD3qQnJfhYDB9Gika0Z8joolySg5TVKCrAgjGY=;
        b=J9dK3OfJbXsizlI1CfOskkp9TLy3kwQoiirYx+jNTOcPMa/ri/Xh2szCFd7OVSgy8M
         VMIICt4Ay4Hip3o1IBSsL6dvS54QW5SunaP8VnDteMFU1p0Ht5TDEKVRlUVMHVNoufjk
         YCwWYr5PriTTuCtsbe1vAeWtyih4aff/NJiw/QK5htH4PpVQowffe/y1E9Nrb9YQLDQH
         9qoyQakVTC78BwJdOT2Ea9JOu+eDAIxnachocAQU15xkOyL38b7aIcMCO59Yp2V1ZMhn
         4xCBryitqn/sFlywyK0N22N3wKVRHqgbTRBYbvqDzhZ8vY4xl9FV5c3qFGexDjxX2RcM
         Uwpw==
X-Gm-Message-State: AJIora/ruXuoVdyr+0ZZ8KCxUeexKDBDBoWPbI2zouzABYDpRIXYXBAV
	c45mTTqZiV5VA8vzqZAUk4IZVypF8jo=
X-Google-Smtp-Source: AGRyM1t5V9w9u1jg2IV15wR1mZqeLSQ9xIIIoTP9J/vhGXJ0MB9Ht7NQtl6dms28nah0H/alVyK1CQ==
X-Received: by 2002:a63:9516:0:b0:40c:c3b9:f984 with SMTP id p22-20020a639516000000b0040cc3b9f984mr23442001pgd.116.1656901096303;
        Sun, 03 Jul 2022 19:18:16 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id bg2-20020a056a001f8200b00524e2f81727sm19485404pfb.74.2022.07.03.19.18.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Jul 2022 19:18:16 -0700 (PDT)
Date: Mon, 4 Jul 2022 10:19:26 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Kelvin Zhang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Subject: Re: [PATCH v2] Make --mount-point option generally available
Message-ID: <20220704101926.0000504d.zbestahu@gmail.com>
In-Reply-To: <20220701230030.2633151-1-zhangkelvin@google.com>
References: <Yr52GGOwNfl6StH6@B-P7TQMD6M-0146.local>
	<20220701230030.2633151-1-zhangkelvin@google.com>
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
Cc: Kelvin Zhang <zhangkelvin@google.com>, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Kelvin,

On Fri,  1 Jul 2022 16:00:30 -0700
Kelvin Zhang via Linux-erofs <linux-erofs@lists.ozlabs.org> wrote:

> This option does not have any android specific dependencies. It is also
> useful for all selinux enabled fs images, so move it out of android
> specific feature sets.
> 
> e.g. mkfs.erofs --file-contexts=selinux_context_file
> --mount_point=/product product.img your_product_out_dir
> 
> Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
> ---
>  include/erofs/config.h | 2 +-
>  lib/xattr.c            | 2 --
>  mkfs/main.c            | 6 +++---
>  3 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/include/erofs/config.h b/include/erofs/config.h
> index 0a1b18b..030054b 100644
> --- a/include/erofs/config.h
> +++ b/include/erofs/config.h
> @@ -65,8 +65,8 @@ struct erofs_configure {
>  	u32 c_dict_size;
>  	u64 c_unix_timestamp;
>  	u32 c_uid, c_gid;
> +	const char *mount_point;
>  #ifdef WITH_ANDROID
> -	char *mount_point;
>  	char *target_out_path;
>  	char *fs_config_file;
>  	char *block_list_file;
> diff --git a/lib/xattr.c b/lib/xattr.c
> index 00fb963..cf5c447 100644
> --- a/lib/xattr.c
> +++ b/lib/xattr.c
> @@ -210,12 +210,10 @@ static struct xattr_item *erofs_get_selabel_xattr(const char *srcpath,
>  		unsigned int len[2];
>  		char *kvbuf, *fspath;
>  
> -#ifdef WITH_ANDROID
>  		if (cfg.mount_point)
>  			ret = asprintf(&fspath, "/%s/%s", cfg.mount_point,
>  				       erofs_fspath(srcpath));
>  		else
> -#endif
>  			ret = asprintf(&fspath, "/%s", erofs_fspath(srcpath));
>  		if (ret <= 0)
>  			return ERR_PTR(-ENOMEM);
> diff --git a/mkfs/main.c b/mkfs/main.c
> index b62a8aa..879c2f2 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -50,8 +50,8 @@ static struct option long_options[] = {
>  	{"quiet", no_argument, 0, 12},
>  	{"blobdev", required_argument, NULL, 13},
>  	{"ignore-mtime", no_argument, NULL, 14},
> -#ifdef WITH_ANDROID
>  	{"mount-point", required_argument, NULL, 512},
> +#ifdef WITH_ANDROID
>  	{"product-out", required_argument, NULL, 513},
>  	{"fs-config-file", required_argument, NULL, 514},
>  	{"block-list-file", required_argument, NULL, 515},
> @@ -103,9 +103,9 @@ static void usage(void)
>  #ifndef NDEBUG
>  	      " --random-pclusterblks randomize pclusterblks for big pcluster (debugging only)\n"
>  #endif
> +	      " --mount-point=X       X=prefix of target fs path (default: /)\n"
>  #ifdef WITH_ANDROID
>  	      "\nwith following android-specific options:\n"
> -	      " --mount-point=X       X=prefix of target fs path (default: /)\n"
>  	      " --product-out=X       X=product_out directory\n"
>  	      " --fs-config-file=X    X=fs_config file\n"
>  	      " --block-list-file=X   X=block_list file\n"
> @@ -314,7 +314,6 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>  		case 10:
>  			cfg.c_compress_hints_file = optarg;
>  			break;
> -#ifdef WITH_ANDROID
>  		case 512:
>  			cfg.mount_point = optarg;
>  			/* all trailing '/' should be deleted */
> @@ -322,6 +321,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>  			if (opt && optarg[opt - 1] == '/')
>  				optarg[opt - 1] = '\0';
>  			break;
> +#ifdef WITH_ANDROID
>  		case 513:
>  			cfg.target_out_path = optarg;
>  			break;

As Xiang pointed out, it is common convention to prefix the subject line to let us
distinguish from others more easily.
