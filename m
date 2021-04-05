Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 753B935417E
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Apr 2021 13:24:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FDSxC3Pkvz30C8
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Apr 2021 21:24:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=abwx7cK9;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FmCgxAfR;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=abwx7cK9; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FmCgxAfR; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FDSx84tlqz30B4
 for <linux-erofs@lists.ozlabs.org>; Mon,  5 Apr 2021 21:24:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617621876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/KhmCR7S05P3uyh5ScEQqQYlpiQJ9FJHtiTVfxeJbx8=;
 b=abwx7cK9n8EaPu7a/Jt8oSwh3UCNrS7PSJ8XMuSf9KgIFHsHtpBWRTHfG8DtVD3G6MxRSj
 /JCRJEipLdroALuLIfOoBkjElL0gkrA02nkGHPxLNVn/vdtTJ9wuzkPlkZTGf335V3N4Gg
 0Ept55cvBXnL1w9qY4dzKDxx7eE4LLA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617621877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/KhmCR7S05P3uyh5ScEQqQYlpiQJ9FJHtiTVfxeJbx8=;
 b=FmCgxAfR2ksWSGezZWTbji7ODdsn7O//ENOQ3uvNgEn8rqpZ4dyBFm2NeIKquXat9hL5uY
 ukFqdKSbg9R7B4pVm4dxNbTNfEu7N11MLNMt7FsJTdni8oBChapHaqJiTeOA/5Ml1fqUxV
 4G6gAbwXozHkX/a2ujo8Y5D622CG/bw=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-OHnIF-u8PzOJn4fieBAHQg-1; Mon, 05 Apr 2021 07:24:35 -0400
X-MC-Unique: OHnIF-u8PzOJn4fieBAHQg-1
Received: by mail-pg1-f199.google.com with SMTP id o1so9005537pgl.0
 for <linux-erofs@lists.ozlabs.org>; Mon, 05 Apr 2021 04:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=/KhmCR7S05P3uyh5ScEQqQYlpiQJ9FJHtiTVfxeJbx8=;
 b=B3qC1Eg5zsgsixpo+nBxnfywxlPrPID7mxhiLjI69EFbxUy0plTv7aWetsdhNKdAf0
 Y8K86JQKtL98D1fFgTD7jV/e1SgjCRE7JajSSduIyEd1lkp8zfcgp61r9jdabAzbXUCk
 uOeclEMXfXAfpKgQH4tQVr8RNvbsptTHvkBwnF/zSjKJk+uR4PpNin/NmlQuN7GUoOBl
 TeMQFsSDcG9cA1oCYwXdFUwjjGEwPBFqQ7nQ2sMtXZRaJxDmklVDq7ki/hQDUx8fhZPr
 8YTUiYwnye67ns2GCSccl8b0Lr+82GAGbFsihdfj3vyLlZE9HUBsrsQxQWavpF2MnCl8
 aeRA==
X-Gm-Message-State: AOAM532Uv5QUVwLedzkuRjSs+HakT+DHLU0MGtALFHBp0N3uotHBI8jc
 5sNIJ5g+Ict7LPaQa8v7DDc6ZGPfvWq3SRurXe7qrBb5VZOXLuHO/das31wHUuOXkvU0PssWT5o
 E4yIiaFvp+8UoT0t5BD0QrgbS
X-Received: by 2002:a62:1581:0:b029:202:7800:442 with SMTP id
 123-20020a6215810000b029020278000442mr23265227pfv.3.1617621873928; 
 Mon, 05 Apr 2021 04:24:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJlU4MjSgzn+b5M48TSTlBxDY4/NfHQE6JdRPkheVtkMeTrgPsmLnaR9NVNS4/AbEAIpEHgA==
X-Received: by 2002:a62:1581:0:b029:202:7800:442 with SMTP id
 123-20020a6215810000b029020278000442mr23265206pfv.3.1617621873512; 
 Mon, 05 Apr 2021 04:24:33 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id q8sm15261911pgn.22.2021.04.05.04.24.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Apr 2021 04:24:33 -0700 (PDT)
Date: Mon, 5 Apr 2021 19:24:24 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Hu Weiwen <sehuww@mail.scut.edu.cn>
Subject: Re: [PATCH v2] erofs-utils: use qsort() to sort dir->i_subdirs
Message-ID: <20210405112424.GA378859@xiangao.remote.csb>
References: <20210402021741.GB4011659@xiangao.remote.csb>
 <20210405093816.149621-1-sehuww@mail.scut.edu.cn>
MIME-Version: 1.0
In-Reply-To: <20210405093816.149621-1-sehuww@mail.scut.edu.cn>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Apr 05, 2021 at 05:38:16PM +0800, Hu Weiwen wrote:
> Original implementation use insertion sort, and its time complexity is
> O(n^2). This patch use qsort instead. When I create a directory with
> 100k entries, this reduces the user space time from around 3 mins to
> 0.5s.
> 
> Create such a large directory for benchmark with:
> mkdir large; cd large; touch $(seq 100000);
> 
> Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>

This patch looks good to me, will test it later.

> ---
>  lib/inode.c | 53 +++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 33 insertions(+), 20 deletions(-)
> 
> diff --git a/lib/inode.c b/lib/inode.c
> index d52facf..ef55e88 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -96,21 +96,6 @@ unsigned int erofs_iput(struct erofs_inode *inode)
>  	return 0;
>  }
> 
> -static int dentry_add_sorted(struct erofs_dentry *d, struct list_head *head)
> -{
> -	struct list_head *pos;
> -
> -	list_for_each(pos, head) {
> -		struct erofs_dentry *d2 =
> -			container_of(pos, struct erofs_dentry, d_child);
> -
> -		if (strcmp(d->name, d2->name) < 0)
> -			break;
> -	}
> -	list_add_tail(&d->d_child, pos);
> -	return 0;
> -}
> -
>  struct erofs_dentry *erofs_d_alloc(struct erofs_inode *parent,
>  				   const char *name)
>  {
> @@ -122,7 +107,7 @@ struct erofs_dentry *erofs_d_alloc(struct erofs_inode *parent,
>  	strncpy(d->name, name, EROFS_NAME_LEN - 1);
>  	d->name[EROFS_NAME_LEN - 1] = '\0';
> 
> -	dentry_add_sorted(d, &parent->i_subdirs);
> +	list_add_tail(&d->d_child, &parent->i_subdirs);
>  	return d;
>  }
> 
> @@ -156,10 +141,19 @@ static int __allocate_inode_bh_data(struct erofs_inode *inode,
>  	return 0;
>  }
> 
> +static int comp_subdir(const void *a, const void *b)
> +{
> +	const struct erofs_dentry *da, *db;
> +
> +	da = *((const struct erofs_dentry **)a);
> +	db = *((const struct erofs_dentry **)b);
> +	return strcmp(da->name, db->name);
> +}
> +
> -int erofs_prepare_dir_file(struct erofs_inode *dir)
> +int erofs_prepare_dir_file(struct erofs_inode *dir, unsigned int nr_subdirs)
>  {
> -	struct erofs_dentry *d;
> -	unsigned int d_size, i_nlink;
> +	struct erofs_dentry *d, *n, **sorted_d;
> +	unsigned int d_size, i_nlink, i;
>  	int ret;
> 
>  	/* dot is pointed to the current dir inode */
> @@ -172,6 +166,22 @@ int erofs_prepare_dir_file(struct erofs_inode *dir)
>  	d->inode = erofs_igrab(dir->i_parent);
>  	d->type = EROFS_FT_DIR;
> 
> +	/* sort subdirs */
> +	nr_subdirs += 2;
> +	sorted_d = malloc(nr_subdirs * sizeof(d));
> +	if (!sorted_d)
> +		return -ENOMEM;
> +	i = 0;
> +	list_for_each_entry_safe(d, n, &dir->i_subdirs, d_child) {
> +		list_del(&d->d_child);
> +		sorted_d[i++] = d;
> +	}
> +	DBG_BUGON(i != nr_subdirs);
> +	qsort(sorted_d, nr_subdirs, sizeof(d), comp_subdir);
> +	for (i = 0; i < nr_subdirs; i++)
> +		list_add_tail(&sorted_d[i]->d_child, &dir->i_subdirs);
> +	free(sorted_d);
> +
>  	/* let's calculate dir size and update i_nlink */
>  	d_size = 0;
>  	i_nlink = 0;
> @@ -922,6 +932,7 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
>  	DIR *_dir;
>  	struct dirent *dp;
>  	struct erofs_dentry *d;
> +	unsigned int nr_subdirs;
> 
>  	ret = erofs_prepare_xattr_ibody(dir);
>  	if (ret < 0)
> @@ -961,6 +972,7 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
>  		return ERR_PTR(-errno);
>  	}
> 
> +	nr_subdirs = 0;
>  	while (1) {
>  		/*
>  		 * set errno to 0 before calling readdir() in order to
> @@ -984,6 +996,7 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
>  			ret = PTR_ERR(d);
>  			goto err_closedir;
>  		}
> +		nr_subdirs++;
> 
>  		/* to count i_nlink for directories */
>  		d->type = (dp->d_type == DT_DIR ?
> @@ -996,7 +1009,7 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
>  	}
>  	closedir(_dir);
> 
> -	ret = erofs_prepare_dir_file(dir);
> +	ret = erofs_prepare_dir_file(dir, nr_subdirs);
>  	if (ret)
>  		goto err;
> 
> --
> 2.25.1
> 

