Return-Path: <linux-erofs+bounces-1584-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EABCDB994
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Dec 2025 08:35:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dbkDQ3fJVz2xqG;
	Wed, 24 Dec 2025 18:35:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766561702;
	cv=none; b=Q8fEuvAPkX5zwLGQ3eaN1+K9zxK+JG5oditRzI0OpwjDrnLLfgzaiqh09sUVIOToFTcmhOMmHwaGYH4XobGbLd4wxfYjVSq7p+7ahAPOMUOkQXS4Up9dI7nvilC2doxg6ndOiV+LUdFmwCV4W2lC90334gTd1exRWC694J+v0vkt+Vl6L+hjxMeQhXuza37WWWVYDuND5IWNeK7WyfghLpEhf2IIchlHITStscJQn1uIhHMbzxjYQ/XXdaUdhCXoL/0DMHQxMKPYHgfyVgpuZSx9skETXJpNZqr840LEno+REL6I7wvD8GgCIMYv/FMpzoN+leLpLyQ9KiKcb+ZAjg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766561702; c=relaxed/relaxed;
	bh=F5En1or9sJZCLiiS2c1gxlAhK5aCdTtMNXiKVSbxbSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o3y2e6yEiryUJudcbNBdYr4hZHdsc8tYVgEvG8ewvJqfPA11jT/ykBryCdNop7toXxv1U6Sb9egrwij22PQhzdVTgxG9SLHH2QmvXCazJJmbrfkNw+HEBPVlPD8KJ5MzuIOWuw7cLzxh7Sv310nb0sOJuP31cOBt40aYmOKZcC05jI8ykeqOkHCJkea9YsR83oDHhQBXd0pYVpy9sBGORPhQ15WiLURKKbBq49PIWtlIV9iddfJ2jYbOLaK/obfsVku/4WsYpLhS6GbPcTa7fihJLFTlTHVZkuaKLzwSuKbSqBKoGsv3Vm4saDngnMxrWMcouUK9OUxMMOWHoUoMoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yB3X/f7u; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yB3X/f7u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dbkDL3Y3Tz2xlM
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Dec 2025 18:34:56 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766561691; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=F5En1or9sJZCLiiS2c1gxlAhK5aCdTtMNXiKVSbxbSk=;
	b=yB3X/f7u+NLguB/ZDVXoe1bN4ODxTtDQaNHas/akoniYCZZeB93NO8la4GysQkHN0f2Kb1hfrKO5cNhd/htmEMiocf8wzWkoakD9//mxLA0aisu2laAEGJ58ZL52utRpSHNonuYoiQt76V2bca+DHXHyWNX2D4gD9YO1G/uIVjU=
Received: from 30.221.133.159(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvaMIYr_1766561687 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 24 Dec 2025 15:34:48 +0800
Message-ID: <0d07544d-68ea-4c39-8333-dc262f3c3103@linux.alibaba.com>
Date: Wed, 24 Dec 2025 15:34:46 +0800
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 05/10] erofs: support user-defined fingerprint name
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Christian Brauner <brauner@kernel.org>, "Darrick J. Wong"
 <djwong@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
 Christoph Hellwig <hch@lst.de>
References: <20251224040932.496478-1-lihongbo22@huawei.com>
 <20251224040932.496478-6-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251224040932.496478-6-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/24 12:09, Hongbo Li wrote:
> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
> 
> When creating the EROFS image, users can specify the fingerprint name.
> This is to prepare for the upcoming inode page cache share.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   fs/erofs/Kconfig    |  9 +++++++++
>   fs/erofs/erofs_fs.h |  5 +++--
>   fs/erofs/internal.h |  2 ++
>   fs/erofs/super.c    |  3 +++
>   fs/erofs/xattr.c    | 13 +++++++++++++
>   5 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> index d81f3318417d..b71f2a8074fe 100644
> --- a/fs/erofs/Kconfig
> +++ b/fs/erofs/Kconfig
> @@ -194,3 +194,12 @@ config EROFS_FS_PCPU_KTHREAD_HIPRI
>   	  at higher priority.
>   
>   	  If unsure, say N.
> +
> +config EROFS_FS_PAGE_CACHE_SHARE
> +	bool "EROFS page cache share support (experimental)"
> +	depends on EROFS_FS && EROFS_FS_XATTR && !EROFS_FS_ONDEMAND
> +	help
> +	  This enables page cache sharing among inodes with identical
> +	  content fingerprints on the same machine.
> +
> +	  If unsure, say N.
> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> index e24268acdd62..20515d2462af 100644
> --- a/fs/erofs/erofs_fs.h
> +++ b/fs/erofs/erofs_fs.h
> @@ -17,7 +17,7 @@
>   #define EROFS_FEATURE_COMPAT_XATTR_FILTER		0x00000004
>   #define EROFS_FEATURE_COMPAT_SHARED_EA_IN_METABOX	0x00000008
>   #define EROFS_FEATURE_COMPAT_PLAIN_XATTR_PFX		0x00000010
> -
> +#define EROFS_FEATURE_COMPAT_ISHARE_XATTRS		0x00000020
>   
>   /*
>    * Any bits that aren't in EROFS_ALL_FEATURE_INCOMPAT should
> @@ -83,7 +83,8 @@ struct erofs_super_block {
>   	__le32 xattr_prefix_start;	/* start of long xattr prefixes */
>   	__le64 packed_nid;	/* nid of the special packed inode */
>   	__u8 xattr_filter_reserved; /* reserved for xattr name filter */
> -	__u8 reserved[3];
> +	__u8 ishare_xattr_prefix_id;	/* indexes the ishare key in prefix xattres */
> +	__u8 reserved[2];
>   	__le32 build_time;	/* seconds added to epoch for mkfs time */
>   	__le64 rootnid_8b;	/* (48BIT on) nid of root directory */
>   	__le64 reserved2;
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 98fe652aea33..99e2857173c3 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -134,6 +134,7 @@ struct erofs_sb_info {
>   	u32 xattr_blkaddr;
>   	u32 xattr_prefix_start;
>   	u8 xattr_prefix_count;
> +	u8 ishare_xattr_pfx;

Could we use the same naming as `ishare_xattr_prefix_id`?

>   	struct erofs_xattr_prefix_item *xattr_prefixes;
>   	unsigned int xattr_filter_reserved;
>   #endif
> @@ -238,6 +239,7 @@ EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
>   EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
>   EROFS_FEATURE_FUNCS(shared_ea_in_metabox, compat, COMPAT_SHARED_EA_IN_METABOX)
>   EROFS_FEATURE_FUNCS(plain_xattr_pfx, compat, COMPAT_PLAIN_XATTR_PFX)
> +EROFS_FEATURE_FUNCS(ishare_xattrs, compat, COMPAT_ISHARE_XATTRS)
>   
>   static inline u64 erofs_nid_to_ino64(struct erofs_sb_info *sbi, erofs_nid_t nid)
>   {
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 2a44c4e5af4f..68480f10e69d 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -298,6 +298,9 @@ static int erofs_read_superblock(struct super_block *sb)
>   		if (ret)
>   			goto out;
>   	}
> +	if (erofs_sb_has_ishare_xattrs(sbi))
> +		sbi->ishare_xattr_pfx =
> +			dsb->ishare_xattr_prefix_id & EROFS_XATTR_LONG_PREFIX_MASK;

It seems this part is still unmodified.

But after checking the code just now, I agree it may need more work
in order to pass dsb to erofs_xattr_prefixes_init(), so I can live
with the current status.

Thanks,
Gao Xiang

>   
>   	ret = -EINVAL;
>   	sbi->feature_incompat = le32_to_cpu(dsb->feature_incompat);
> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
> index 396536d9a862..969e77efd038 100644
> --- a/fs/erofs/xattr.c
> +++ b/fs/erofs/xattr.c
> @@ -519,6 +519,19 @@ int erofs_xattr_prefixes_init(struct super_block *sb)
>   	}
>   
>   	erofs_put_metabuf(&buf);
> +	if (!ret && erofs_sb_has_ishare_xattrs(sbi)) {
> +		struct erofs_xattr_prefix_item *pf = pfs + sbi->ishare_xattr_pfx;
> +		struct erofs_xattr_long_prefix *newpfx;
> +
> +		newpfx = krealloc(pf->prefix,
> +			sizeof(*newpfx) + pf->infix_len + 1, GFP_KERNEL);
> +		if (newpfx) {
> +			newpfx->infix[pf->infix_len] = '\0';
> +			pf->prefix = newpfx;
> +		} else {
> +			ret = -ENOMEM;
> +		}
> +	}
>   	sbi->xattr_prefixes = pfs;
>   	if (ret)
>   		erofs_xattr_prefixes_cleanup(sb);


