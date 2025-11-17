Return-Path: <linux-erofs+bounces-1380-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4CDC6229E
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Nov 2025 03:55:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d8smY38GSz2yx7;
	Mon, 17 Nov 2025 13:55:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763348109;
	cv=none; b=SilzKV0221fZ4oVHhbQxHUG0YIHcQGd02AxLTOGEGfy0xirOdBAntSnB6LgxkZ5pNYr9Tv29hbouIezbzkaZJeHTrLLITUeC5kaymeHCl+D6QHmD2O3Ivlhqr6MaeKsffUZFKuK4oyGxfl+TuiqIZiQTYpyE7VHaNCpQyKMdqn/qxPuT6mTj2x/MH9aAt6QDFqMGJcqArmbW+qQNuNu//PySxYFdELZk/QgD4vFN4VmdOgxBmzV1gZNT6ZasHGwkOECEFYa2gTk96zisSCjnkMclObQ3dhBmabF7s41hlm2Sa7WJoR8V7/wNf2QhWZw+cEVILqGHmeS92MNC8AW+XA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763348109; c=relaxed/relaxed;
	bh=bM0pzBOedq7loaoI6fMCzbNwCpdPGiGv5NHJEFsZE28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m18YuJiqcsTEx1sQrW9DNluBjftk8jzCVgkYDikhruWPiON75voytyTjGHKsMOgOTiG4PSX1CDhqMm56d/rgCxpqrqgrhdvuP1+FSxQV3Lm1ti5FrM6uWUesE218AC1uxTwd2XNXJN+tz8y+6D9WspprKY+PKBdlI7cBodQDwPdr8/G/ETFdApyyBI6jrknhC5qdkVnS0fjadstcqre3INXoXa4R8978bg/LzYOHnbslJx6A213V+PPk6eWI3uVOYafSpk2Ur7+PJl7QUqU1HiyeJXSri4wcMSzpxWXyd4hWiwfO8y/d7xfSWd1EeJBBBhFTz3VJgq3ujfeFYA+YiQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RFngd7OB; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RFngd7OB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d8smV3d2zz2yw7
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Nov 2025 13:55:05 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763348100; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=bM0pzBOedq7loaoI6fMCzbNwCpdPGiGv5NHJEFsZE28=;
	b=RFngd7OBcyrQPlBHJqdhNK/Oa7N/WLjRdTuEgEdItcwEgPLD8eL5MTgUG95znHowWLZu8K0hSEYczK6MAzGsgXnMGI37QcB2osqMi2D9jasBRRaU77Z2MxXowJ9hhW34ElVeq/rvSY3yiZCYxt4DmpvWKCB5WiieTQD6dNVbuvI=
Received: from 30.221.131.30(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WsTm8Wr_1763348098 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Nov 2025 10:54:58 +0800
Message-ID: <a3b0bac9-d08f-44dc-8adb-7cc85cae7b13@linux.alibaba.com>
Date: Mon, 17 Nov 2025 10:54:57 +0800
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
Subject: Re: [PATCH v8 4/9] erofs: support user-defined fingerprint name
To: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, brauner@kernel.org,
 djwong@kernel.org, amir73il@gmail.com, joannelkoong@gmail.com
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20251114095516.207555-1-lihongbo22@huawei.com>
 <20251114095516.207555-5-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251114095516.207555-5-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/11/14 17:55, Hongbo Li wrote:
> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
> 
> When creating the EROFS image, users can specify the fingerprint name.
> This is to prepare for the upcoming inode page cache share.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   fs/erofs/Kconfig    |  9 +++++++++
>   fs/erofs/erofs_fs.h |  6 ++++--
>   fs/erofs/internal.h |  6 ++++++
>   fs/erofs/super.c    |  5 ++++-
>   fs/erofs/xattr.c    | 26 ++++++++++++++++++++++++++
>   fs/erofs/xattr.h    |  6 ++++++
>   6 files changed, 55 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> index d81f3318417d..1b5c0cd99203 100644
> --- a/fs/erofs/Kconfig
> +++ b/fs/erofs/Kconfig
> @@ -194,3 +194,12 @@ config EROFS_FS_PCPU_KTHREAD_HIPRI
>   	  at higher priority.
>   
>   	  If unsure, say N.
> +
> +config EROFS_FS_INODE_SHARE
> +	bool "EROFS inode page cache share support (experimental)"
> +	depends on EROFS_FS && EROFS_FS_XATTR && !EROFS_FS_ONDEMAND
> +	help
> +	  This permits EROFS to share page cache for files with same
> +	  fingerprints.

I tend to use "EROFS_FS_PAGE_CACHE_SHARE" since it's closer to
user impact definition (inode sharing is ambiguious), but we
could leave "ishare.c" since it's closer to the implementation
details.

And how about:

config EROFS_FS_PAGE_CACHE_SHARE
	bool "EROFS page cache share support (experimental)"
	depends on EROFS_FS && EROFS_FS_XATTR && !EROFS_FS_ONDEMAND
	help
	  This enables page cache sharing among inodes with identical
	  content fingerprints on the same device.

	  If unsure, say N.

> +
> +	  If unsure, say N.
> \ No newline at end of file

"\ No newline at end of file" should be fixed.

> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> index 3d5738f80072..104518cd161d 100644
> --- a/fs/erofs/erofs_fs.h
> +++ b/fs/erofs/erofs_fs.h
> @@ -35,8 +35,9 @@
>   #define EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES	0x00000040
>   #define EROFS_FEATURE_INCOMPAT_48BIT		0x00000080
>   #define EROFS_FEATURE_INCOMPAT_METABOX		0x00000100
> +#define EROFS_FEATURE_INCOMPAT_ISHARE_KEY	0x00000200

I do think it should be a compatible feature since images can be
mounted in the old kernels without any issue, and it should be
renamed as

EROFS_FEATURE_COMPAT_ISHARE_XATTRS

>   #define EROFS_ALL_FEATURE_INCOMPAT		\
> -	((EROFS_FEATURE_INCOMPAT_METABOX << 1) - 1)
> +	((EROFS_FEATURE_INCOMPAT_ISHARE_KEY << 1) - 1)
>   
>   #define EROFS_SB_EXTSLOT_SIZE	16
>   
> @@ -83,7 +84,8 @@ struct erofs_super_block {
>   	__le32 xattr_prefix_start;	/* start of long xattr prefixes */
>   	__le64 packed_nid;	/* nid of the special packed inode */
>   	__u8 xattr_filter_reserved; /* reserved for xattr name filter */
> -	__u8 reserved[3];
> +	__u8 ishare_key_start;	/* start of ishare key */

ishare_xattr_prefix_id; ?

> +	__u8 reserved[2];
>   	__le32 build_time;	/* seconds added to epoch for mkfs time */
>   	__le64 rootnid_8b;	/* (48BIT on) nid of root directory */
>   	__le64 reserved2;
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index e80b35db18e4..3ebbb7c5d085 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -167,6 +167,11 @@ struct erofs_sb_info {
>   	struct erofs_domain *domain;
>   	char *fsid;
>   	char *domain_id;
> +
> +	/* inode page cache share support */
> +	u8 ishare_key_start;

	u8 ishare_xattr_pfx;

> +	u8 ishare_key_idx;

why need this, considering we could just use

sbi->xattr_prefixes[sbi->ishare_xattr_pfx]

to get this.

> +	char *ishare_key;
>   };
>   
>   #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
> @@ -236,6 +241,7 @@ EROFS_FEATURE_FUNCS(dedupe, incompat, INCOMPAT_DEDUPE)
>   EROFS_FEATURE_FUNCS(xattr_prefixes, incompat, INCOMPAT_XATTR_PREFIXES)
>   EROFS_FEATURE_FUNCS(48bit, incompat, INCOMPAT_48BIT)
>   EROFS_FEATURE_FUNCS(metabox, incompat, INCOMPAT_METABOX)
> +EROFS_FEATURE_FUNCS(ishare_key, incompat, INCOMPAT_ISHARE_KEY)
>   EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
>   EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
>   EROFS_FEATURE_FUNCS(shared_ea_in_metabox, compat, COMPAT_SHARED_EA_IN_METABOX)
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 0d88c04684b9..3561473cb789 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -339,7 +339,7 @@ static int erofs_read_superblock(struct super_block *sb)
>   			return -EFSCORRUPTED;	/* self-loop detection */
>   	}
>   	sbi->inos = le64_to_cpu(dsb->inos);
> -
> +	sbi->ishare_key_start = dsb->ishare_key_start;
>   	sbi->epoch = (s64)le64_to_cpu(dsb->epoch);
>   	sbi->fixed_nsec = le32_to_cpu(dsb->fixed_nsec);
>   	super_set_uuid(sb, (void *)dsb->uuid, sizeof(dsb->uuid));
> @@ -738,6 +738,9 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>   	if (err)
>   		return err;
>   
> +	err = erofs_xattr_set_ishare_key(sb);

I don't think it's necessary to duplicate the copy, just use
"sbi->xattr_prefixes[sbi->ishare_xattr_pfx]" directly.

Thanks,
Gao Xiang

> +	if (err)
> +		return err;
>   	erofs_set_sysfs_name(sb);
>   	err = erofs_register_sysfs(sb);
>   	if (err)
> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
> index 396536d9a862..3c99091f39a5 100644
> --- a/fs/erofs/xattr.c
> +++ b/fs/erofs/xattr.c
> @@ -564,3 +564,29 @@ struct posix_acl *erofs_get_acl(struct inode *inode, int type, bool rcu)
>   	return acl;
>   }
>   #endif
> +
> +#ifdef CONFIG_EROFS_FS_INODE_SHARE
> +int erofs_xattr_set_ishare_key(struct super_block *sb)
> +{
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
> +	struct erofs_xattr_prefix_item *pf;
> +	char *ishare_key;
> +
> +	if (!sbi->xattr_prefixes ||
> +	    !(sbi->ishare_key_start & EROFS_XATTR_LONG_PREFIX))
> +		return 0;
> +
> +	pf = sbi->xattr_prefixes +
> +		(sbi->ishare_key_start & EROFS_XATTR_LONG_PREFIX_MASK);
> +	if (!pf || pf >= sbi->xattr_prefixes + sbi->xattr_prefix_count)
> +		return 0;
> +	ishare_key = kmalloc(pf->infix_len + 1, GFP_KERNEL);
> +	if (!ishare_key)
> +		return -ENOMEM;
> +	memcpy(ishare_key, pf->prefix->infix, pf->infix_len);
> +	ishare_key[pf->infix_len] = '\0';
> +	sbi->ishare_key = ishare_key;
> +	sbi->ishare_key_idx = pf->prefix->base_index;
> +	return 0;
> +}
> +#endif
> diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
> index 6317caa8413e..21684359662c 100644
> --- a/fs/erofs/xattr.h
> +++ b/fs/erofs/xattr.h
> @@ -67,4 +67,10 @@ struct posix_acl *erofs_get_acl(struct inode *inode, int type, bool rcu);
>   #define erofs_get_acl	(NULL)
>   #endif
>   
> +#ifdef CONFIG_EROFS_FS_INODE_SHARE
> +int erofs_xattr_set_ishare_key(struct super_block *sb);
> +#else
> +static inline int erofs_xattr_set_ishare_key(struct super_block *sb) { return 0; }
> +#endif
> +
>   #endif


