Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 734A32E04D2
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Dec 2020 04:45:21 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D0Mg24PzkzDqN8
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Dec 2020 14:45:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=63.128.21.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=GGEqoLRv; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GGEqoLRv; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D0Mfz19h0zDqK1
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Dec 2020 14:45:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608608709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YxpiRzfSZp0G72+5RxVV7x1D6qhC339OgzFwHLOic6Q=;
 b=GGEqoLRvti+Epq44vk51ns/AQYPdjCJT3tA+5qURy8t4qdHq0b8cHQDqRBR9kl0NMF8LcZ
 rrj6Ow8VYuIaoOFLQvy0SbwWVhLRC5RVeBo1AjyzMB/wfWTlZ6EPJwRjP03Si5+IlP8K+T
 35yIQZS1lCvlwEzIzCqlXbHN/7MK9fw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608608709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YxpiRzfSZp0G72+5RxVV7x1D6qhC339OgzFwHLOic6Q=;
 b=GGEqoLRvti+Epq44vk51ns/AQYPdjCJT3tA+5qURy8t4qdHq0b8cHQDqRBR9kl0NMF8LcZ
 rrj6Ow8VYuIaoOFLQvy0SbwWVhLRC5RVeBo1AjyzMB/wfWTlZ6EPJwRjP03Si5+IlP8K+T
 35yIQZS1lCvlwEzIzCqlXbHN/7MK9fw=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-dK2KK2QGOB2B1qqxSROfKQ-1; Mon, 21 Dec 2020 22:45:07 -0500
X-MC-Unique: dK2KK2QGOB2B1qqxSROfKQ-1
Received: by mail-pg1-f199.google.com with SMTP id g24so7731584pgh.14
 for <linux-erofs@lists.ozlabs.org>; Mon, 21 Dec 2020 19:45:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=YxpiRzfSZp0G72+5RxVV7x1D6qhC339OgzFwHLOic6Q=;
 b=eLkxj7i6on4vvbMh6GP0qx+ICM3NxztOG5mSx6jcK0kmIcuP1zYV/3MSFr2K3i/6zF
 PZY4HUaFmjcKa0r13lOB1i8suzP/6ra2+TxZzOvXDbBMiywvl9BS+DJtDyNaZrSxjqHA
 9OGlsf5s4RZyYhPs0UC5CccU1zPBeXpPrOGqWYl0FA9ER/n18Q3uRad4gPdoVvTpRYwT
 Xb8/7Rc+cUyPvEZ85V/tBoy7v6Tv5tRuwdu7MnjlY63v1MOiYE4t+NUrTEY/2buJ83jW
 DfamXGKAMtAdCMShP+TuaAskqwbIfGj4JUsTxap/0U4S7AM9bBX7Kb2zCRC3jX8BKxj7
 +q+Q==
X-Gm-Message-State: AOAM532Ia990Y42ax6Cjg+pIny9gIwijatodtmfTOZ2EwKot0hZ5GRrM
 u1cDuErFC8vWT4D35DCDI1wScZP8poqdk7hTyNH7h6n9UzzKQ/GIhgYYOLDTy2yKG32PMt86UTk
 hxkdWZWEGxcnf1qKbsCfzCR1E
X-Received: by 2002:a17:902:b904:b029:dc:18f2:9419 with SMTP id
 bf4-20020a170902b904b02900dc18f29419mr19339907plb.66.1608608706250; 
 Mon, 21 Dec 2020 19:45:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxJesCZzDkgximNtZQkkYlTRymU8srmAX7hQRvS1Kq30zC7cMUhlUWXOxK1dPEbv0XnuSYHFg==
X-Received: by 2002:a17:902:b904:b029:dc:18f2:9419 with SMTP id
 bf4-20020a170902b904b02900dc18f29419mr19339894plb.66.1608608706022; 
 Mon, 21 Dec 2020 19:45:06 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 145sm17573118pfu.8.2020.12.21.19.45.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Dec 2020 19:45:05 -0800 (PST)
Date: Tue, 22 Dec 2020 11:44:55 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH] AOSP: erofs-utils: fix sub directory prefix path in
 canned fs_config
Message-ID: <20201222034455.GA1775594@xiangao.remote.csb>
References: <20201222020430.12512-1-zbestahu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20201222020430.12512-1-zbestahu@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
Cc: xiang@kernel.org, linux-erofs@lists.ozlabs.org, huyue2@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yue,

On Tue, Dec 22, 2020 at 10:04:30AM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> We observe that creating image failed to find [%s] in canned fs_config
> using --fs-config-file option under Android 10.
> 
> Notice that canned fs_config has a prefix to sub directory if mount_point
> presents. However, erofs_fspath() does not contain the prefix.
> 

Thanks for your patch. Let me play with it a bit this weekend (I'm not
quite familiar with canned fs_config, it would be of great help to add
some hints/steps for me to confirm this issue.... since some other vendors
already use it without report (maybe they don't use canned fs_config.)

> Moreover, we should not add the mount point to fspath on root inode for
> fs_config() branch.

Is there some descriptive words or reference for this? To be honest,
I'm quite unsure about this kind of Android-specific things... :(

Thanks,
Gao Xiang

> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  include/erofs/config.h |  4 ++++
>  lib/inode.c            | 29 +++++++++++++++++++----------
>  mkfs/main.c            | 14 ++++++++++----
>  3 files changed, 33 insertions(+), 14 deletions(-)
> 
> diff --git a/include/erofs/config.h b/include/erofs/config.h
> index 02ddf59..1277eda 100644
> --- a/include/erofs/config.h
> +++ b/include/erofs/config.h
> @@ -58,6 +58,10 @@ struct erofs_configure {
>  	char *mount_point;
>  	char *target_out_path;
>  	char *fs_config_file;
> +	void (*fs_config_func)(const char *path, int dir,
> +			       const char *target_out_path,
> +			       unsigned *uid, unsigned *gid,
> +			       unsigned *mode, uint64_t *capabilities);
>  #endif
>  };
>  
> diff --git a/lib/inode.c b/lib/inode.c
> index eb2e0f2..d0805cd 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -684,20 +684,29 @@ int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
>  	char *fspath;
>  
>  	inode->capabilities = 0;
> -	if (cfg.fs_config_file)
> -		canned_fs_config(erofs_fspath(path),
> -				 S_ISDIR(st->st_mode),
> -				 cfg.target_out_path,
> -				 &uid, &gid, &mode, &inode->capabilities);
> -	else if (cfg.mount_point) {
> +
> +	if (erofs_fspath(path)[0] == '\0')
> +		goto e_fspath;
> +
> +	if (cfg.mount_point) {
>  		if (asprintf(&fspath, "%s/%s", cfg.mount_point,
>  			     erofs_fspath(path)) <= 0)
>  			return -ENOMEM;
> -
> -		fs_config(fspath, S_ISDIR(st->st_mode),
> -			  cfg.target_out_path,
> -			  &uid, &gid, &mode, &inode->capabilities);
> +		if (cfg.fs_config_func)
> +			cfg.fs_config_func(fspath,
> +					   S_ISDIR(st->st_mode),
> +					   cfg.target_out_path,
> +					   &uid, &gid, &mode,
> +					   &inode->capabilities);
>  		free(fspath);
> +	} else {
> +e_fspath:
> +		if (cfg.fs_config_func)
> +			cfg.fs_config_func(erofs_fspath(path),
> +					   S_ISDIR(st->st_mode),
> +					   cfg.target_out_path,
> +					   &uid, &gid, &mode,
> +					   &inode->capabilities);
>  	}
>  	st->st_uid = uid;
>  	st->st_gid = gid;
> diff --git a/mkfs/main.c b/mkfs/main.c
> index c63b274..684767c 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -474,10 +474,16 @@ int main(int argc, char **argv)
>  	}
>  
>  #ifdef WITH_ANDROID
> -	if (cfg.fs_config_file &&
> -	    load_canned_fs_config(cfg.fs_config_file) < 0) {
> -		erofs_err("failed to load fs config %s", cfg.fs_config_file);
> -		return 1;
> +	cfg.fs_config_func = NULL;
> +	if (cfg.fs_config_file) {
> +		if (load_canned_fs_config(cfg.fs_config_file) < 0) {
> +			erofs_err("failed to load fs config %s",
> +					cfg.fs_config_file);
> +			return 1;
> +		}
> +		cfg.fs_config_func = canned_fs_config;
> +	} else if (cfg.mount_point) {
> +		cfg.fs_config_func = fs_config;
>  	}
>  #endif
>  
> -- 
> 1.9.1
> 

