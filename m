Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B3528348B8B
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Mar 2021 09:30:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F5dZr5Hyxz30B6
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Mar 2021 19:30:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U9SQKXMp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U9SQKXMp;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=U9SQKXMp; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=U9SQKXMp; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F5dZp0Sn5z2yhf
 for <linux-erofs@lists.ozlabs.org>; Thu, 25 Mar 2021 19:30:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616661005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JrbqR+KCYM9fUkVXLQUPLeopQrWCwHqx2Ocld+rjPzw=;
 b=U9SQKXMpXoxRxpw8OU/CrjP7qWy86iW0HFRwUQZ19ipLE30wdrPMgy2oxtPSM49R8iYi2O
 1HBcSJTabsPztPjxHdfvgVy0RXDczds8dnAAxoVgYqNXkyH8ihP+Qkl0UYcCUfx8DJqJaY
 JcVjWvPGnh3dJXheCceeI9q0ukD3atg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616661005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JrbqR+KCYM9fUkVXLQUPLeopQrWCwHqx2Ocld+rjPzw=;
 b=U9SQKXMpXoxRxpw8OU/CrjP7qWy86iW0HFRwUQZ19ipLE30wdrPMgy2oxtPSM49R8iYi2O
 1HBcSJTabsPztPjxHdfvgVy0RXDczds8dnAAxoVgYqNXkyH8ihP+Qkl0UYcCUfx8DJqJaY
 JcVjWvPGnh3dJXheCceeI9q0ukD3atg=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-Za3qq6pINoCqBHiVkWoR-g-1; Thu, 25 Mar 2021 04:30:01 -0400
X-MC-Unique: Za3qq6pINoCqBHiVkWoR-g-1
Received: by mail-pg1-f199.google.com with SMTP id 83so3385639pgh.4
 for <linux-erofs@lists.ozlabs.org>; Thu, 25 Mar 2021 01:30:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=JrbqR+KCYM9fUkVXLQUPLeopQrWCwHqx2Ocld+rjPzw=;
 b=DNJmS4Zz0I83ULA2TMjt+bSEWAv9eKOaIfWl4zyuOfieoBKAKx/gwizJI17a81LdKC
 wwLMgZMGSl7a2R94noVBboHbthp51npx/TeiaIPGSD5JPtCgXRyRoDYZ8Z9A6WSgLU3w
 BLGwBtuytioRr8XH73N/bxy6MXHLrB4w19gmbsDDcu7A30YDYWpAtgg0YGdmbkGDvqRq
 ogeC2mQId0kyRTyPNaMj+nm32WN/kf5C//08CYtR5v0vlqmoUB/VVfAVCpSYg8mNo9/Z
 4rv+TGN8hqC7CeCQHLu2PBBWfrQZhnQgwvGT3GSmxeLX9cnt2irk/4wmM7YQX8dhkXOp
 8jHg==
X-Gm-Message-State: AOAM532057JAOAZ3L2szEMsrv1j3Q2yB+Y0mq8aC+P7V+su8zXsSiDRp
 /W7xu6IBtZMuIr1VDMplqu97ZrUBj2zttRETxcUofCfj4IHJHCy7/ANgk72vOmq95bL5OQ2akjF
 aR2XYIHP7r3nKvpSGIVN6eR4K
X-Received: by 2002:a17:90a:d301:: with SMTP id
 p1mr7650587pju.233.1616660999879; 
 Thu, 25 Mar 2021 01:29:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJjJYRfvs0kL0gQ+WJQWIUMxPki1N/RaxEjue/iX6ws8tWoUPzzicX7jJfgO/4gkmXYU5sKw==
X-Received: by 2002:a17:90a:d301:: with SMTP id
 p1mr7650559pju.233.1616660999411; 
 Thu, 25 Mar 2021 01:29:59 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id t10sm5062967pjf.30.2021.03.25.01.29.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Mar 2021 01:29:59 -0700 (PDT)
Date: Thu, 25 Mar 2021 16:29:48 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH] erofs: don't use erofs_map_blocks() any more
Message-ID: <20210325082948.GA2474089@xiangao.remote.csb>
References: <20210325071008.573-1-zbestahu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20210325071008.573-1-zbestahu@gmail.com>
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
Cc: xiang@kernel.org, linux-erofs@lists.ozlabs.org, huyue2@yulong.com,
 zbestahu@163.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yue,

On Thu, Mar 25, 2021 at 03:10:08PM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> Currently, erofs_map_blocks() will be called only from
> erofs_{bmap, read_raw_page} which are all for uncompressed files.
> So, the compression branch in erofs_map_blocks() is pointless. Let's
> remove it and use erofs_map_blocks_flatmode() directly. Also update
> related comments.
> 

You are right, since for compressed files, map_blocks_iter would be more
effective than erofs_map_blocks. Originally, such unique interface was
designed for fiemap (just for example), but I'm fine to get rid of it
until related interfaces are finally implemented.

Also, I'd like to hear opinions from Chao as well.

Thanks,
Gao Xiang

> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  fs/erofs/data.c     | 19 ++-----------------
>  fs/erofs/internal.h |  6 ++----
>  2 files changed, 4 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 1249e74..ebac756 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -109,21 +109,6 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
>  	return err;
>  }
>  
> -int erofs_map_blocks(struct inode *inode,
> -		     struct erofs_map_blocks *map, int flags)
> -{
> -	if (erofs_inode_is_data_compressed(EROFS_I(inode)->datalayout)) {
> -		int err = z_erofs_map_blocks_iter(inode, map, flags);
> -
> -		if (map->mpage) {
> -			put_page(map->mpage);
> -			map->mpage = NULL;
> -		}
> -		return err;
> -	}
> -	return erofs_map_blocks_flatmode(inode, map, flags);
> -}
> -
>  static inline struct bio *erofs_read_raw_page(struct bio *bio,
>  					      struct address_space *mapping,
>  					      struct page *page,
> @@ -159,7 +144,7 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
>  		erofs_blk_t blknr;
>  		unsigned int blkoff;
>  
> -		err = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
> +		err = erofs_map_blocks_flatmode(inode, &map, EROFS_GET_BLOCKS_RAW);
>  		if (err)
>  			goto err_out;
>  
> @@ -318,7 +303,7 @@ static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
>  			return 0;
>  	}
>  
> -	if (!erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW))
> +	if (!erofs_map_blocks_flatmode(inode, &map, EROFS_GET_BLOCKS_RAW))
>  		return erofs_blknr(map.m_pa);
>  
>  	return 0;
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 30e63b7..db8c847 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -289,7 +289,7 @@ static inline unsigned int erofs_inode_datalayout(unsigned int value)
>  extern const struct address_space_operations z_erofs_aops;
>  
>  /*
> - * Logical to physical block mapping, used by erofs_map_blocks()
> + * Logical to physical block mapping
>   *
>   * Different with other file systems, it is used for 2 access modes:
>   *
> @@ -336,7 +336,7 @@ struct erofs_map_blocks {
>  	struct page *mpage;
>  };
>  
> -/* Flags used by erofs_map_blocks() */
> +/* Flags used by erofs_map_blocks_flatmode() */
>  #define EROFS_GET_BLOCKS_RAW    0x0001
>  
>  /* zmap.c */
> @@ -358,8 +358,6 @@ static inline int z_erofs_map_blocks_iter(struct inode *inode,
>  /* data.c */
>  struct page *erofs_get_meta_page(struct super_block *sb, erofs_blk_t blkaddr);
>  
> -int erofs_map_blocks(struct inode *, struct erofs_map_blocks *, int);
> -
>  /* inode.c */
>  static inline unsigned long erofs_inode_hash(erofs_nid_t nid)
>  {
> -- 
> 1.9.1
> 

