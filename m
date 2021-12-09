Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A55E546E092
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Dec 2021 02:58:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J8cdb4FMmz2yp0
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Dec 2021 12:58:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=JGAbRkaY;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632;
 helo=mail-pl1-x632.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=JGAbRkaY; dkim-atps=neutral
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J8cdW66J0z2x9b
 for <linux-erofs@lists.ozlabs.org>; Thu,  9 Dec 2021 12:58:37 +1100 (AEDT)
Received: by mail-pl1-x632.google.com with SMTP id b11so2776090pld.12
 for <linux-erofs@lists.ozlabs.org>; Wed, 08 Dec 2021 17:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=avQ6zouIiN9yCAxnJyjc2BEAENz7yIsL27blUDqPD6s=;
 b=JGAbRkaYN5fsHQKueBsFMUoELiDEq3dqyTc+SLnHD7g2GuC5TE/6on2JWfRiBJReEo
 UjRZKMgpBnX7qf7hnfKqjQgnnopjXi3EzIUR0a9pFmVNGWTJaYTk3AlXMJuq5T/xAQmr
 mixde3nA+yhgweK0TmDp37CUBbTGCI4nHQecucj77SHxUmLBnJR7b1J1zefHdZ05hZee
 S3lyxSip9BVgqrskDzzCQD1jVGYE3RwMMwHv+hAxBl3Fl6toYaI1aidOdB+Z4naClln6
 Y1KZShl1SH6lkVp1dyog6MiKvt1T0e5ycFTs4Y1lCT7pCdKQCax6IbrVoOlE1UWzoI/1
 WU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=avQ6zouIiN9yCAxnJyjc2BEAENz7yIsL27blUDqPD6s=;
 b=7Nej7Z3+Z1FeGXr6F5EljQsvQCIfkauqLYTXFO68LFUmk7lCNvO8mloJimZV/DPBY4
 Ne/wKSHPPQnt1nxmRbK3BqplsffUiKRIKRtIwGfSNVrh+a2H2ESR039zTQDVj6irNAEY
 iZVIMbwx8CoxDb6izUjVWHQRXgHRxH8AH5tr6DQss5SZ03rHqNsP6vmYymmVzeQpj/99
 nn0mpBRlWfRhIz/8T43GApoC3sSDNFKKYuwTdTE5HX7TXLxPBb3+oR0eq1XeaW30pWPI
 r86cxQWI0oI87HKUUBHav5WnpDhJlwM09hkv3poKr1l6+li8HVEN0IyQi8HUx+r9qJ+C
 tYfA==
X-Gm-Message-State: AOAM53259kNUCmoKBoLE2rMcR+CJqLdwLIAlz5oaRczHIZV/UNBBJbD6
 qWzK8DyYvylU4tp9bizLms4=
X-Google-Smtp-Source: ABdhPJwlIE1PXQQI/w1u/lQW1i2uiXM5GSlwruVROb0fFETmzi7avVQ3qMGxbFKCo02w2ckhDbTTWA==
X-Received: by 2002:a17:90b:4b01:: with SMTP id
 lx1mr12007824pjb.38.1639015114562; 
 Wed, 08 Dec 2021 17:58:34 -0800 (PST)
Received: from localhost ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id t12sm7189747pjo.44.2021.12.08.17.58.30
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 08 Dec 2021 17:58:34 -0800 (PST)
Date: Thu, 9 Dec 2021 09:56:35 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v2] erofs: clean up erofs_map_blocks tracepoints
Message-ID: <20211209095635.000012e8.zbestahu@gmail.com>
In-Reply-To: <20211209012918.30337-1-hsiangkao@linux.alibaba.com>
References: <20211209012918.30337-1-hsiangkao@linux.alibaba.com>
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
Cc: huyue2@yulong.com, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu,  9 Dec 2021 09:29:18 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Since the new type of chunk-based files is introduced, there is no
> need to leave flatmode tracepoints.
> 
> Rename to erofs_map_blocks instead.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> v1: https://lore.kernel.org/r/20210921143531.81356-2-hsiangkao@linux.alibaba.com
> change since v1:
>  - fix m_llen assignment issue pointed out by Chao;
> 
>  fs/erofs/data.c              | 39 ++++++++++++++++--------------------
>  include/trace/events/erofs.h |  4 ++--
>  2 files changed, 19 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 0e35ef3f9f3d..4f98c76ec043 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -26,20 +26,16 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
>  				     struct erofs_map_blocks *map,
>  				     int flags)
>  {
> -	int err = 0;
>  	erofs_blk_t nblocks, lastblk;
>  	u64 offset = map->m_la;
>  	struct erofs_inode *vi = EROFS_I(inode);
>  	bool tailendpacking = (vi->datalayout == EROFS_INODE_FLAT_INLINE);
>  
> -	trace_erofs_map_blocks_flatmode_enter(inode, map, flags);
> -
>  	nblocks = DIV_ROUND_UP(inode->i_size, PAGE_SIZE);
>  	lastblk = nblocks - tailendpacking;
>  
>  	/* there is no hole in flatmode */
>  	map->m_flags = EROFS_MAP_MAPPED;
> -
>  	if (offset < blknr_to_addr(lastblk)) {
>  		map->m_pa = blknr_to_addr(vi->raw_blkaddr) + map->m_la;
>  		map->m_plen = blknr_to_addr(lastblk) - offset;
> @@ -51,30 +47,23 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
>  			vi->xattr_isize + erofs_blkoff(map->m_la);
>  		map->m_plen = inode->i_size - offset;
>  
> -		/* inline data should be located in one meta block */
> -		if (erofs_blkoff(map->m_pa) + map->m_plen > PAGE_SIZE) {
> +		/* inline data should be located in the same meta block */
> +		if (erofs_blkoff(map->m_pa) + map->m_plen > EROFS_BLKSIZ) {
>  			erofs_err(inode->i_sb,
>  				  "inline data cross block boundary @ nid %llu",
>  				  vi->nid);
>  			DBG_BUGON(1);
> -			err = -EFSCORRUPTED;
> -			goto err_out;
> +			return -EFSCORRUPTED;
>  		}
> -
>  		map->m_flags |= EROFS_MAP_META;
>  	} else {
>  		erofs_err(inode->i_sb,
>  			  "internal error @ nid: %llu (size %llu), m_la 0x%llx",
>  			  vi->nid, inode->i_size, map->m_la);
>  		DBG_BUGON(1);
> -		err = -EIO;
> -		goto err_out;
> +		return -EIO;
>  	}
> -
> -	map->m_llen = map->m_plen;
> -err_out:
> -	trace_erofs_map_blocks_flatmode_exit(inode, map, flags, 0);
> -	return err;
> +	return 0;
>  }
>  
>  static int erofs_map_blocks(struct inode *inode,
> @@ -89,6 +78,7 @@ static int erofs_map_blocks(struct inode *inode,
>  	erofs_off_t pos;
>  	int err = 0;
>  
> +	trace_erofs_map_blocks_enter(inode, map, flags);
>  	map->m_deviceid = 0;
>  	if (map->m_la >= inode->i_size) {
>  		/* leave out-of-bound access unmapped */
> @@ -97,8 +87,10 @@ static int erofs_map_blocks(struct inode *inode,
>  		goto out;
>  	}
>  
> -	if (vi->datalayout != EROFS_INODE_CHUNK_BASED)
> -		return erofs_map_blocks_flatmode(inode, map, flags);
> +	if (vi->datalayout != EROFS_INODE_CHUNK_BASED) {
> +		err = erofs_map_blocks_flatmode(inode, map, flags);
> +		goto out;
> +	}
>  
>  	if (vi->chunkformat & EROFS_CHUNK_FORMAT_INDEXES)
>  		unit = sizeof(*idx);			/* chunk index */
> @@ -110,9 +102,10 @@ static int erofs_map_blocks(struct inode *inode,
>  		    vi->xattr_isize, unit) + unit * chunknr;
>  
>  	page = erofs_get_meta_page(inode->i_sb, erofs_blknr(pos));
> -	if (IS_ERR(page))
> -		return PTR_ERR(page);
> -
> +	if (IS_ERR(page)) {
> +		err = PTR_ERR(page);
> +		goto out;
> +	}
>  	map->m_la = chunknr << vi->chunkbits;
>  	map->m_plen = min_t(erofs_off_t, 1UL << vi->chunkbits,
>  			    roundup(inode->i_size - map->m_la, EROFS_BLKSIZ));
> @@ -146,7 +139,9 @@ static int erofs_map_blocks(struct inode *inode,
>  	unlock_page(page);
>  	put_page(page);
>  out:
> -	map->m_llen = map->m_plen;
> +	if (!err)
> +		map->m_llen = map->m_plen;
> +	trace_erofs_map_blocks_exit(inode, map, flags, 0);
>  	return err;
>  }
>  
> diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
> index 16ae7b666810..57de057bd503 100644
> --- a/include/trace/events/erofs.h
> +++ b/include/trace/events/erofs.h
> @@ -169,7 +169,7 @@ DECLARE_EVENT_CLASS(erofs__map_blocks_enter,
>  		  __entry->flags ? show_map_flags(__entry->flags) : "NULL")
>  );
>  
> -DEFINE_EVENT(erofs__map_blocks_enter, erofs_map_blocks_flatmode_enter,
> +DEFINE_EVENT(erofs__map_blocks_enter, erofs_map_blocks_enter,
>  	TP_PROTO(struct inode *inode, struct erofs_map_blocks *map,
>  		 unsigned flags),
>  
> @@ -221,7 +221,7 @@ DECLARE_EVENT_CLASS(erofs__map_blocks_exit,
>  		  show_mflags(__entry->mflags), __entry->ret)
>  );
>  
> -DEFINE_EVENT(erofs__map_blocks_exit, erofs_map_blocks_flatmode_exit,
> +DEFINE_EVENT(erofs__map_blocks_exit, erofs_map_blocks_exit,
>  	TP_PROTO(struct inode *inode, struct erofs_map_blocks *map,
>  		 unsigned flags, int ret),
>  

Reviewed-by: Yue Hu <huyue2@yulong.com>


