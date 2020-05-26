Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 954341E1F1E
	for <lists+linux-erofs@lfdr.de>; Tue, 26 May 2020 11:50:09 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49WTht6vWtzDqPM
	for <lists+linux-erofs@lfdr.de>; Tue, 26 May 2020 19:50:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=207.211.31.120;
 helo=us-smtp-1.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=bZrXAD7h; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bZrXAD7h; 
 dkim-atps=neutral
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49WThq05SyzDqL0
 for <linux-erofs@lists.ozlabs.org>; Tue, 26 May 2020 19:49:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590486595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9GuE/LPL+2xEUMOXwJWvANJ55nLEiYEGWJm2d0nKaFE=;
 b=bZrXAD7hnAf23Tl28vcfdTKsl+ZrcSA+SaA0jlW0PW72+RFALh+NCl1bZYOIErRxwQcO2j
 Jss+poZGayi9vM0qL/H6V9LoA+p1mrAFVOLfTdmcpf3hdRISoyNqjw8yk1+yyH6srr+VYq
 4/prRMPTZHUZddmwGmHXR7g/vtLO5aI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590486595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9GuE/LPL+2xEUMOXwJWvANJ55nLEiYEGWJm2d0nKaFE=;
 b=bZrXAD7hnAf23Tl28vcfdTKsl+ZrcSA+SaA0jlW0PW72+RFALh+NCl1bZYOIErRxwQcO2j
 Jss+poZGayi9vM0qL/H6V9LoA+p1mrAFVOLfTdmcpf3hdRISoyNqjw8yk1+yyH6srr+VYq
 4/prRMPTZHUZddmwGmHXR7g/vtLO5aI=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-PFs4mcc1P0613e4JvRvidQ-1; Tue, 26 May 2020 05:49:53 -0400
X-MC-Unique: PFs4mcc1P0613e4JvRvidQ-1
Received: by mail-pl1-f200.google.com with SMTP id w11so15243216pll.15
 for <linux-erofs@lists.ozlabs.org>; Tue, 26 May 2020 02:49:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=9GuE/LPL+2xEUMOXwJWvANJ55nLEiYEGWJm2d0nKaFE=;
 b=HXH0AVHR50GTTucFlwxtMEpsbKkQ85I8BHVGbZJM8ZPawQttVoNh6KFKc3a7JQObxN
 QotNBQlH4FuI6YZ3aTEOdXijAT4KBLdj1IWvRcKkS4TyG7OsZpnXJgXIXqyDONOxlIav
 c6mSHXUvOdr4Ygg/pJPQTbAtnwvbuqvklSMtHjvZsBrinsKGLUzNCmDi3xU+UhVKDfQ5
 BEGpqefVt4TGOZNRnEtj2diXgJMicE7dGAPh/pAE5Sq4FtTA73Jtkh1iMLIyt/QYJ+Sp
 QQnFzQ3LJuH5t35NTw8/ie6jzwFlRGGuzEefy9n4tj26qF4ujAKJgyDZKtZVxt2yK8dd
 YkRg==
X-Gm-Message-State: AOAM532cncSj2FVsbGPU7XI4tvupqygqd7uUOhlDjxjMSR3xm2B8mwpx
 A9s01nzpUVhwJLjyo+qTuIea/YN/Q2UYr0HKFVGjTzU0+F6iLjBaF4ntert8jDpsslgswJH4q+C
 SkHC67nRnYsTgupbu2LcsD6Hu
X-Received: by 2002:a63:3e0e:: with SMTP id l14mr242307pga.187.1590486592200; 
 Tue, 26 May 2020 02:49:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtR7Z0Umh09ImZDuCJ6GrDN/ksfnpX3vtKtJkwitDk6FOI4+s+pVgoGa8sEu7dkW+vM0i8Sw==
X-Received: by 2002:a63:3e0e:: with SMTP id l14mr242285pga.187.1590486591804; 
 Tue, 26 May 2020 02:49:51 -0700 (PDT)
Received: from hsiangkao-HP-ZHAN-66-Pro-G1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id b4sm11731679pfo.140.2020.05.26.02.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 02:49:51 -0700 (PDT)
Date: Tue, 26 May 2020 17:49:41 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Chengguang Xu <cgxu519@mykernel.net>
Subject: Re: [PATCH] erofs: code cleanup by removing ifdef macro surrounding
Message-ID: <20200526094939.GB8107@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200526090343.22794-1-cgxu519@mykernel.net>
MIME-Version: 1.0
In-Reply-To: <20200526090343.22794-1-cgxu519@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: xiang@kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Chengguang,

On Tue, May 26, 2020 at 05:03:43PM +0800, Chengguang Xu wrote:
> Define erofs_listxattr and erofs_xattr_handlers to NULL when
> CONFIG_EROFS_FS_XATTR is not enabled, then we can remove many
> ugly ifdef macros in the code.
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
> ---
> Only compile tested.
> 
>  fs/erofs/inode.c | 6 ------
>  fs/erofs/namei.c | 2 --
>  fs/erofs/super.c | 4 +---
>  fs/erofs/xattr.h | 7 ++-----
>  4 files changed, 3 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index 3350ab65d892..7dd4bbe9674f 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -311,27 +311,21 @@ int erofs_getattr(const struct path *path, struct kstat *stat,
>  
>  const struct inode_operations erofs_generic_iops = {
>  	.getattr = erofs_getattr,
> -#ifdef CONFIG_EROFS_FS_XATTR
>  	.listxattr = erofs_listxattr,
> -#endif

It seems equivalent. And it seems ext2 and f2fs behave in the same way...
But I'm not sure whether we'd return 0 (if I didn't see fs/xattr.c by mistake)
or -EOPNOTSUPP here... Some thoughts about this?

Anyway, I'm fine with that if return 0 is okay here, but I'd like to know your
and Chao's thoughts about this... I will play with it later as well.

Reviewed-by: Gao Xiang <hsiangkao@redhat.com>

Thanks,
Gao Xiang

>  	.get_acl = erofs_get_acl,
>  };
>  
>  const struct inode_operations erofs_symlink_iops = {
>  	.get_link = page_get_link,
>  	.getattr = erofs_getattr,
> -#ifdef CONFIG_EROFS_FS_XATTR
>  	.listxattr = erofs_listxattr,
> -#endif
>  	.get_acl = erofs_get_acl,
>  };
>  
>  const struct inode_operations erofs_fast_symlink_iops = {
>  	.get_link = simple_get_link,
>  	.getattr = erofs_getattr,
> -#ifdef CONFIG_EROFS_FS_XATTR
>  	.listxattr = erofs_listxattr,
> -#endif
>  	.get_acl = erofs_get_acl,
>  };
>  
> diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
> index 3abbecbf73de..52f201e03c62 100644
> --- a/fs/erofs/namei.c
> +++ b/fs/erofs/namei.c
> @@ -244,9 +244,7 @@ static struct dentry *erofs_lookup(struct inode *dir,
>  const struct inode_operations erofs_dir_iops = {
>  	.lookup = erofs_lookup,
>  	.getattr = erofs_getattr,
> -#ifdef CONFIG_EROFS_FS_XATTR
>  	.listxattr = erofs_listxattr,
> -#endif
>  	.get_acl = erofs_get_acl,
>  };
>  
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index b514c67e5fc2..8e46d204a0c2 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -408,10 +408,8 @@ static int erofs_fill_super(struct super_block *sb, void *data, int silent)
>  	sb->s_time_gran = 1;
>  
>  	sb->s_op = &erofs_sops;
> -
> -#ifdef CONFIG_EROFS_FS_XATTR
>  	sb->s_xattr = erofs_xattr_handlers;
> -#endif
> +
>  	/* set erofs default mount options */
>  	erofs_default_options(sbi);
>  
> diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
> index 50966f1c676e..e4e5093f012c 100644
> --- a/fs/erofs/xattr.h
> +++ b/fs/erofs/xattr.h
> @@ -76,11 +76,8 @@ static inline int erofs_getxattr(struct inode *inode, int index,
>  	return -EOPNOTSUPP;
>  }
>  
> -static inline ssize_t erofs_listxattr(struct dentry *dentry,
> -				      char *buffer, size_t buffer_size)
> -{
> -	return -EOPNOTSUPP;
> -}
> +#define erofs_listxattr (NULL)
> +#define erofs_xattr_handlers (NULL)
>  #endif	/* !CONFIG_EROFS_FS_XATTR */
>  
>  #ifdef CONFIG_EROFS_FS_POSIX_ACL
> -- 
> 2.20.1
> 
> 

