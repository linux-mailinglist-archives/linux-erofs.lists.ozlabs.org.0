Return-Path: <linux-erofs+bounces-2316-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLMFBmGzj2lvSwEAu9opvQ
	(envelope-from <linux-erofs+bounces-2316-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Feb 2026 00:27:29 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 19086139FAD
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Feb 2026 00:27:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fCSxm1r62z2xlx;
	Sat, 14 Feb 2026 10:27:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771025244;
	cv=none; b=fILcUguduSkO9xdfyUw4nKUqoQF4M/7ZFrLGKXSy+P/0Uei/aFqvYD5J/CsZ/K0kfYPr+2f7VL8S2GyyRBI3fIWWkjtlwHuHaORTUyJek2t0TByygMj++02HccfSIPXh2QSohL9p+unz4Cj6XUiTYbRe8E461pFdAGOTGObf+9Gpw4wPo1M3zjLHLBo8fZ0+UpvkDUPjN4K/ZUpLPSa7SzADrc1FeyPXNkNtnBAHPoRzJIhJZF2dvQVTRqKr6XA4yBAx0Opcas6QT9Xm9eE8tpBRwyUqtKo1STo5Q27C6iGe7z4bGhFXm0ydWU/ED3hPhpkEBowzp6eWm1HjMS1GnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771025244; c=relaxed/relaxed;
	bh=tY5gxUmvSQ8PU9MKO5otdohITocGbiS+FSN52Wds9sU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ga16G5VkwmmeP3/WwOfS5lqlcg2BF68RJeMt9zaZsiaU0DAj+BoPfFiBh+n+ErZnxikn31dzVcUeAA59hR1rXUFfIdHYM+VXB8rpQvt5YmQ/444Dzx6zsPmS8j+1113dIXZQXnCnP183opu2WJtmQeXA3iYuqJjD6h+m1YAKuZvy/JDdXC6ecad2T8ibQuJGK9bfof3cUbe5k3haUADK21hTIa5GjICU7s5hkVqmnLaT13v7yVVU+xWHQKabQMQCte7UoBFid3nudleaQEAx89Pzx0QD5K3jMWWV3NIIGxkfIFsKgNpnQQ9RjFkFZKQ5LFLUvrVh9Ucq1yA4Bc/gUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=f/U5ekwU; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=f/U5ekwU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fCSxl122Pz2xln
	for <linux-erofs@lists.ozlabs.org>; Sat, 14 Feb 2026 10:27:23 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7A348438CE;
	Fri, 13 Feb 2026 23:27:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44C1C116C6;
	Fri, 13 Feb 2026 23:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771025240;
	bh=rrPE5oyNED8nIqHeHO8t/nEmXPjdnhH+v75FkQE2/iQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f/U5ekwUAOnDgdrMdE54JHUEr43zXgMGpnnmbyHlTp9I7hi47gkR7+hujfpjXcHYL
	 0SMFiyoQ41vRNwTxj+5piqdjpUdHb6TuGSn3CoCNVjIknFvaeflsLzGFDEvKII2Byh
	 imHAXU0pEnG4C21bjQ9vBa8cfZwr1SAt1ywUs39Rv7YpJhDIC7yM+GSaYgVzQPZI1J
	 JCTsBgSX6sWH/ACrHYFomVJ7xNdETtkm+DMKD57Tdcie6hsn70py1P28OdW68enPpz
	 YBRgVHydtufJLyB1s9mo5DYIxPxbdZYOob+96MYJbBLqPt3zN+2O99CWP1nWmVzL8i
	 SxDD/nmqs7BpA==
Date: Sat, 14 Feb 2026 07:27:15 +0800
From: Gao Xiang <xiang@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: hsiangkao@linux.alibaba.com, chao@kernel.org, xiang@kernel.org,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] erofs: allow sharing page cache with the same aops only
Message-ID: <aY-zU-R52VrbhGpL@debian>
Mail-Followup-To: Hongbo Li <lihongbo22@huawei.com>,
	hsiangkao@linux.alibaba.com, chao@kernel.org, xiang@kernel.org,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260213073345.768320-1-lihongbo22@huawei.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260213073345.768320-1-lihongbo22@huawei.com>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[xiang@kernel.org,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lihongbo22@huawei.com,m:hsiangkao@linux.alibaba.com,m:chao@kernel.org,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-2316-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiang@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email]
X-Rspamd-Queue-Id: 19086139FAD
X-Rspamd-Action: no action

Hi Hongbo,

On Fri, Feb 13, 2026 at 07:33:45AM +0000, Hongbo Li wrote:
> Inode with identical data but different @aops cannot be mixed
> because the page cache is managed by different subsystems (e.g.,
> @aops for compressed on-disk inodes cannot handle plain on-disk
> inodes).
> 
> In this patch, we never allow inodes to share the page cache
> among plain, compressed, and fileio cases. When a shared inode
> is created, we initialize @aops that is the same as the initial
> real inode, and subsequent inodes cannot share the page cache
> if the inferred @aops differ from the corresponding shared inode.
> 
> This is reasonable as a first step because, in typical use cases,
> if an inode is compressible, it will fall into compressed
> inodes across different filesystem images unless users use plain
> filesystems. However, in that cases, users will use plain
> filesystems all the time.
> 
> Fixes: 5ef3208e3be5 ("erofs: introduce the page cache share feature")
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>  fs/erofs/inode.c    |  3 ++-
>  fs/erofs/internal.h | 20 +++++++++-----------
>  fs/erofs/ishare.c   | 14 +++++++++-----
>  3 files changed, 20 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index 4f86169c23f1..5b05272fd9c4 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -254,7 +254,8 @@ static int erofs_fill_inode(struct inode *inode)
>  	}
>  
>  	mapping_set_large_folios(inode->i_mapping);
> -	return erofs_inode_set_aops(inode, inode, false);
> +	inode->i_mapping->a_ops = erofs_get_aops(inode, false);
> +	return IS_ERR(inode->i_mapping->a_ops) ? PTR_ERR(inode->i_mapping->a_ops) : 0;

I hope there is an aops variable instead of assigning
inode->i_mapping->a_ops directly.

>  }
>  
>  /*
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index d1634455e389..764e81b3bc08 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -471,26 +471,24 @@ static inline void *erofs_vm_map_ram(struct page **pages, unsigned int count)
>  	return NULL;
>  }
>  
> -static inline int erofs_inode_set_aops(struct inode *inode,
> -				       struct inode *realinode, bool no_fscache)
> +static inline const struct address_space_operations *
> +erofs_get_aops(struct inode *realinode, bool no_fscache)
>  {
>  	if (erofs_inode_is_data_compressed(EROFS_I(realinode)->datalayout)) {
>  		if (!IS_ENABLED(CONFIG_EROFS_FS_ZIP))
> -			return -EOPNOTSUPP;
> +			return ERR_PTR(-EOPNOTSUPP);
>  		DO_ONCE_LITE_IF(realinode->i_blkbits != PAGE_SHIFT,
>  			  erofs_info, realinode->i_sb,
>  			  "EXPERIMENTAL EROFS subpage compressed block support in use. Use at your own risk!");
> -		inode->i_mapping->a_ops = &z_erofs_aops;
> -		return 0;
> +		return &z_erofs_aops;
>  	}
> -	inode->i_mapping->a_ops = &erofs_aops;
> -	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && !no_fscache &&
> -	    erofs_is_fscache_mode(realinode->i_sb))
> -		inode->i_mapping->a_ops = &erofs_fscache_access_aops;
>  	if (IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) &&
>  	    erofs_is_fileio_mode(EROFS_SB(realinode->i_sb)))
> -		inode->i_mapping->a_ops = &erofs_fileio_aops;
> -	return 0;
> +		return &erofs_fileio_aops;
> +	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && !no_fscache &&
> +	    erofs_is_fscache_mode(realinode->i_sb))
> +		return &erofs_fscache_access_aops;

Can you rearrange it as
	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && !no_fscache &&
	    erofs_is_fscache_mode(realinode->i_sb))
		return &erofs_fscache_access_aops;
	if (IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) &&
	    erofs_is_fileio_mode(EROFS_SB(realinode->i_sb)))
		inode->i_mapping->a_ops = &erofs_fileio_aops;
	return &erofs_aops;

?

Thanks,
Gao Xiang

