Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D65352555
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Apr 2021 04:13:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FBNrF5kc2z3btC
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Apr 2021 13:13:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FlLNZM0z;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FlLNZM0z;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=63.128.21.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=FlLNZM0z; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FlLNZM0z; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FBNrB70BBz2xgH
 for <linux-erofs@lists.ozlabs.org>; Fri,  2 Apr 2021 13:13:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617329584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pTA7niuWKtzcFs/DrmHozOky1Dv+iXipOKutH5Y2YY8=;
 b=FlLNZM0zVyILO/Rvq8V1B06A2mM/RRf47S1H492mYuSj5YE7lJIHiEN7LCsclyS1Bb1AVl
 tvHACgCj7EAfDEzpQfQ2H6iqe2iBknlY2OFRaRbtVY/z6p3CGcUcgtoMnkKOOqAq5DijV1
 A9B8h+lxIk5uH5nuYfqw7h7XSdx5s2o=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617329584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pTA7niuWKtzcFs/DrmHozOky1Dv+iXipOKutH5Y2YY8=;
 b=FlLNZM0zVyILO/Rvq8V1B06A2mM/RRf47S1H492mYuSj5YE7lJIHiEN7LCsclyS1Bb1AVl
 tvHACgCj7EAfDEzpQfQ2H6iqe2iBknlY2OFRaRbtVY/z6p3CGcUcgtoMnkKOOqAq5DijV1
 A9B8h+lxIk5uH5nuYfqw7h7XSdx5s2o=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-0dDzT1sfNbWkRS5GKwRPbQ-1; Thu, 01 Apr 2021 22:13:02 -0400
X-MC-Unique: 0dDzT1sfNbWkRS5GKwRPbQ-1
Received: by mail-pj1-f69.google.com with SMTP id h17so694586pjz.3
 for <linux-erofs@lists.ozlabs.org>; Thu, 01 Apr 2021 19:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=pTA7niuWKtzcFs/DrmHozOky1Dv+iXipOKutH5Y2YY8=;
 b=jpRZdbKO5QEBxW7VtkWcJMmVxd2Jp+SJLZ9cA/r/dhYXVwkcLvEc1x5RtOLK8kn71F
 KrPpkgn/rGN/b34HXl0vk0PEaJuc4Tc3AbBdr4QUK1gidYgkTO9m+qOjQz09DdgjSTV5
 KeLqicPNoMI/v3bwhMqv0jUKIF+ga7JeVpsG4xjOIRM3KipPhIf0gKlTMbkt8mVGlPFk
 UouWNqPjHXK7v3q6Bo64uOhTfr/oTwL0IJxoeb+MNx3gOMLlaLTvCoBhoinuyYjFwUdM
 DjWLJ0HZBKJKV4cGo0jA+gjho5Gy95KBeTBMiLBAricD6rF9+rEgnETe1M2zEEFz3wq7
 UazQ==
X-Gm-Message-State: AOAM531KA6FY/qqZ64QLhckPlAQ3mr2LLtnr+5ct/u9qQ5qzRgn9ga44
 OBmozKM120GuNEZIPDz7VCIEZPCCfvc4jVDLJK8ltadY6cPoTGItywJT7Rgkk5Pr3+a9B3bHlSC
 S9u+Eg3eG/2NV2B04sstcGawT
X-Received: by 2002:a62:2585:0:b029:1fb:bd86:2008 with SMTP id
 l127-20020a6225850000b02901fbbd862008mr9815912pfl.77.1617329581013; 
 Thu, 01 Apr 2021 19:13:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpRC2e3A8CcxbAA6sGVp3JalVXKC6qxc77/vi2u5Wxe+HlD44HCADLlHZFa8JrxTO6Vq5jkQ==
X-Received: by 2002:a62:2585:0:b029:1fb:bd86:2008 with SMTP id
 l127-20020a6225850000b02901fbbd862008mr9815885pfl.77.1617329580575; 
 Thu, 01 Apr 2021 19:13:00 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id v1sm6614663pjt.1.2021.04.01.19.12.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Apr 2021 19:13:00 -0700 (PDT)
Date: Fri, 2 Apr 2021 10:12:50 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Hu Weiwen <sehuww@mail.scut.edu.cn>
Subject: Re: [PATCH] erofs-utils: use qsort() to sort dir->i_subdirs
Message-ID: <20210402021250.GA4011659@xiangao.remote.csb>
References: <20210401135251.59785-1-sehuww@mail.scut.edu.cn>
MIME-Version: 1.0
In-Reply-To: <20210401135251.59785-1-sehuww@mail.scut.edu.cn>
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

Hi Weiwen,

On Thu, Apr 01, 2021 at 09:52:51PM +0800, Hu Weiwen wrote:
> Original implementation use insertion sort, and its time complexity is
> O(n^2). This patch use qsort instead. When I create a directory with
> 100k entries, this reduces the user space time from around 3 mins to
> 0.5s.
> 
> Create such a large directory for benchmark with:
> mkdir large; cd large; touch $(seq 100000);
> 
> Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>

Thanks for your work. Yeah, it's another path that needs to be
optimized for huge dirs.

The overall looks good to me, some nits below...

> ---
>  lib/inode.c | 53 +++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 33 insertions(+), 20 deletions(-)
> 
> diff --git a/lib/inode.c b/lib/inode.c
> index d52facf..9217127 100644
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
> +	const struct erofs_dentry *d_a, *d_b;
> +
> +	d_a = *((const struct erofs_dentry **)a);
> +	d_b = *((const struct erofs_dentry **)b);
> +	return strcmp(d_a->name, d_b->name);
> +}

How about just use `da' and `db' for size?

> +
> -int erofs_prepare_dir_file(struct erofs_inode *dir)
> +int erofs_prepare_dir_file(struct erofs_inode *dir, unsigned int nr_subdirs)
>  {
> -	struct erofs_dentry *d;
> -	unsigned int d_size, i_nlink;
> +	struct erofs_dentry *d, **all_d;
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
> +	all_d = malloc(nr_subdirs * sizeof(d));

maybe just use `sorted' name here?

> +	if (!all_d)
> +		return -ENOMEM;
> +	i = 0;
> +	list_for_each_entry(d, &dir->i_subdirs, d_child)

I think we could list_del here, and use list_for_each_entry

> +		all_d[i++] = d;
> +	DBG_BUGON(i != nr_subdirs);
> +	qsort(all_d, nr_subdirs, sizeof(d), comp_subdir);
> +	init_list_head(&dir->i_subdirs);

After list_del, no need to init_list_head again.
The another reason is that some list_add_tail implementation
could check elements isn't in a list first.

> +	for (i = 0; i < nr_subdirs; i++)
> +		list_add_tail(&all_d[i]->d_child, &dir->i_subdirs);
> +	free(all_d);
> +	all_d = NULL;

no need to NULLify it..

Thanks,
Gao Xiang

