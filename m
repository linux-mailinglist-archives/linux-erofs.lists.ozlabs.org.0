Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCB935B599
	for <lists+linux-erofs@lfdr.de>; Sun, 11 Apr 2021 16:10:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FJDKd0w1Hz30Bw
	for <lists+linux-erofs@lfdr.de>; Mon, 12 Apr 2021 00:10:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1618150229;
	bh=tHJotmASZV0xMnQM5B0RRRQlFT7+KwporZDxvmadBVs=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=c0VrTyZiPO3yv1LSFBMgXoFpVLF6hzepAyjteSOK4RwWbjVzJe64tWL7eEMiYny7n
	 LqWQ0zLmdSj30XgPi6ARnsZVw42cVrNI1AtisraBZ90aKvaxtz3fCC3gMS8bEuGR1j
	 HNutYRzBQB7Ph6h13Syu2Mjoa5HyXxCGhYHnXbu8dZ2x9FNhtWbicrgFBllGx83URq
	 N8RxSrNJnv3Mq6IlLQjMC8SpLkE03FObXrJJ7OKqW3IvJ2cutSARaX96/NAF/abTRt
	 kmk/N9d6dCVKl5eaq5mXaeGUyd3QakXex7INGe44IjEzn881MDsQKA1hjBGbFWjrRt
	 2iggqhqR38/vA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.41;
 helo=out30-41.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=YhcVpY7E; dkim-atps=neutral
Received: from out30-41.freemail.mail.aliyun.com
 (out30-41.freemail.mail.aliyun.com [115.124.30.41])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FJDKb0mdWz2xfd
 for <linux-erofs@lists.ozlabs.org>; Mon, 12 Apr 2021 00:10:24 +1000 (AEST)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.073578|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_alarm|0.533414-0.00434692-0.462239; FP=0|0|0|0|0|-1|-1|-1;
 HT=e01e04420; MF=bluce.lee@aliyun.com; NM=1; PH=DS; RN=3; RT=3; SR=0;
 TI=SMTPD_---0UV9h2pH_1618150209; 
Received: from 192.168.3.32(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0UV9h2pH_1618150209) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 11 Apr 2021 22:10:09 +0800
Subject: Re: [PATCH v2] erofs-utils: use qsort() to sort dir->i_subdirs
To: Hu Weiwen <sehuww@mail.scut.edu.cn>, hsiangkao@redhat.com,
 linux-erofs@lists.ozlabs.org
References: <20210402021741.GB4011659@xiangao.remote.csb>
 <20210405093816.149621-1-sehuww@mail.scut.edu.cn>
Message-ID: <8f0140a5-c738-7890-eff7-eb877a40035d@aliyun.com>
Date: Sun, 11 Apr 2021 22:10:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210405093816.149621-1-sehuww@mail.scut.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
From: Li GuiFu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Li GuiFu <bluce.lee@aliyun.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hu Weiwen
  It really do a high sort performance increase,
  I have a idea that keeping the erofs_prepare_dir_file() function
paramter stable, Using a independent function to do dirs sort.

On 2021/4/5 17:38, Hu Weiwen wrote:
> Original implementation use insertion sort, and its time complexity is
> O(n^2). This patch use qsort instead. When I create a directory with
> 100k entries, this reduces the user space time from around 3 mins to
> 0.5s.
> 
> Create such a large directory for benchmark with:
> mkdir large; cd large; touch $(seq 100000);
> 
> Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
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
Todo 1: keep these function parameter stable

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
Todo 2: make these codes refact to a independent function


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
Todo 3 : nr_subdirs may not be needed, it can be get from one
for-loop-count fixly.
If it may cause perfermance decrease, try to add a dir count in the
erofs_inode struct


>  	if (ret)
>  		goto err;
> 
> --
> 2.25.1
> 
