Return-Path: <linux-erofs+bounces-103-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FF7A6C6DD
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Mar 2025 02:13:02 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZKLsK34ZWz30Vl;
	Sat, 22 Mar 2025 12:12:53 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742605973;
	cv=none; b=J/wjB111XMDANo+0nwbuZ3+5u1O1QQeyp1n9Xf79obgDft+2SSXsRipGB+qUwZgqaie7G5oUVIjqezZdClA8U4lGcct42JHMR4ru3Q6XUBXwaxx9c3b4O6/cMrteamq/sz1BW3qrPoAyP6ADyMOi4eVqjwd9ii4vd9wdaezIRg+dFqLizHJMOFmDS3E1Fr3AUp9zf6Oa0wlvU52JqIusugGG7G0JgPJllD5QWyTH4kwvs1xQMJJHYFFuVJco3cm7ToiwOzlUIQu+WZQ+TefR6PodHcsukUER3gfCJj2+9oEyctZXq/JJ5RwxD9EvNfv/uXBkckEqLKrMMb+LNvCoAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742605973; c=relaxed/relaxed;
	bh=NBZ8DGs+ggacYrBlaL6eD1DtFTZOHPuwtLpiMSB8BJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q3XERV/A2ay68PIenz4EktC5/MENsbRQ8vYrnePbNnDbltbfaUkzQ+ciG57w8s4Rjl+iJXaDnhexKImwP9wbLq+rt6m/Rv+rWtJUROONK7t2Q8nLqJ0P4XkRDT+7ClgzKf+IzPhg9+Htbn1pyX7fy/6GNw+NCRDQtEcDamVaqMkiUJPcSSDnTn4jfUuax4c97gdEoZYxaV67rJ3iuKDlzDQ1YcFN7c4sRSlQUaI2f9+/5GsKwhYzQJzLDozfYp3gTZDO7ufM1fC9OpfzpZceZDjhi6CMjvG9h8LoMnhe4N0WCdwsYP6gXIB4fs27AyRvsYsJYMc0EoF/1T4L2Qws2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZKLsH6m3bz2ySh
	for <linux-erofs@lists.ozlabs.org>; Sat, 22 Mar 2025 12:12:51 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZKLrt0C03z13L3J
	for <linux-erofs@lists.ozlabs.org>; Sat, 22 Mar 2025 09:12:30 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 19BB01800B2
	for <linux-erofs@lists.ozlabs.org>; Sat, 22 Mar 2025 09:12:47 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 22 Mar 2025 09:12:46 +0800
Message-ID: <780bacba-deba-4df0-8bf2-574bead3fbba@huawei.com>
Date: Sat, 22 Mar 2025 09:12:45 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 2/7] erofs: support user-defined fingerprint name
Content-Language: en-US
To: <linux-erofs@lists.ozlabs.org>
References: <20250301145002.2420830-1-hongzhen@linux.alibaba.com>
 <20250301145002.2420830-3-hongzhen@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20250301145002.2420830-3-hongzhen@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/3/1 22:49, Hongzhen Luo wrote:
> When creating the EROFS image, users can specify the fingerprint name.
> This is to prepare for the upcoming inode page cache share.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> ---
>   fs/erofs/Kconfig    | 10 +++++++++
>   fs/erofs/erofs_fs.h |  9 ++++++---
>   fs/erofs/internal.h |  6 ++++++
>   fs/erofs/super.c    |  4 ++++
>   fs/erofs/xattr.c    | 49 +++++++++++++++++++++++++++++++++++++++++++++
>   fs/erofs/xattr.h    |  6 ++++++
>   6 files changed, 81 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> index 6ea60661fa55..d2416d35035a 100644
> --- a/fs/erofs/Kconfig
> +++ b/fs/erofs/Kconfig
> @@ -178,3 +178,13 @@ config EROFS_FS_PCPU_KTHREAD_HIPRI
>   	  at higher priority.
>   
>   	  If unsure, say N.
> +
> +config EROFS_FS_INODE_SHARE
> +	bool "EROFS inode page cache share support"
> +	depends on EROFS_FS && EROFS_FS_XATTR
> +	default n
> +	help
> +	  This permits EROFS to share page cache for files with same
> +	  fingerprints.
> +
> +	  If unsure, say N.
> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> index 199395ed1c1f..261bd9bd47c4 100644
> --- a/fs/erofs/erofs_fs.h
> +++ b/fs/erofs/erofs_fs.h
> @@ -30,6 +30,7 @@
>   #define EROFS_FEATURE_INCOMPAT_FRAGMENTS	0x00000020
>   #define EROFS_FEATURE_INCOMPAT_DEDUPE		0x00000020
>   #define EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES	0x00000040
> +#define EROFS_FEATURE_INCOMPAT_ISHARE_KEY	0x00000080
>   #define EROFS_ALL_FEATURE_INCOMPAT		\
>   	(EROFS_FEATURE_INCOMPAT_ZERO_PADDING | \
>   	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
> @@ -40,7 +41,8 @@
>   	 EROFS_FEATURE_INCOMPAT_ZTAILPACKING | \
>   	 EROFS_FEATURE_INCOMPAT_FRAGMENTS | \
>   	 EROFS_FEATURE_INCOMPAT_DEDUPE | \
> -	 EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES)
> +	 EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES | \
> +	 EROFS_FEATURE_INCOMPAT_ISHARE_KEY)
>   
>   #define EROFS_SB_EXTSLOT_SIZE	16
>   
> @@ -84,8 +86,9 @@ struct erofs_super_block {
>   	__le32 xattr_prefix_start;	/* start of long xattr prefixes */
>   	__le64 packed_nid;	/* nid of the special packed inode */
>   	__u8 xattr_filter_reserved; /* reserved for xattr name filter */
> -	__u8 reserved2[23];
> -};
> +	__le32 ishare_key_start; /* start of ishare key */
> +	__u8 reserved2[19];
> +} __packed;
>   
>   /*
>    * EROFS inode datalayout (i_format in on-disk inode):
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 47004eb89838..21bf9b694048 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -166,6 +166,11 @@ struct erofs_sb_info {
>   	struct erofs_domain *domain;
>   	char *fsid;
>   	char *domain_id;
> +
> +	/* inode page cache share support */
> +	u32 ishare_key_start;
> +	int ishare_key_idx;
> +	char *ishare_key;
>   };
>   
>   #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
> @@ -233,6 +238,7 @@ EROFS_FEATURE_FUNCS(ztailpacking, incompat, INCOMPAT_ZTAILPACKING)
>   EROFS_FEATURE_FUNCS(fragments, incompat, INCOMPAT_FRAGMENTS)
>   EROFS_FEATURE_FUNCS(dedupe, incompat, INCOMPAT_DEDUPE)
>   EROFS_FEATURE_FUNCS(xattr_prefixes, incompat, INCOMPAT_XATTR_PREFIXES)
> +EROFS_FEATURE_FUNCS(ishare_key, incompat, INCOMPAT_ISHARE_KEY)
>   EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
>   EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
>   
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index eb052a770088..6af02cc8b8c6 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -313,6 +313,8 @@ static int erofs_read_superblock(struct super_block *sb)
>   	sbi->packed_nid = le64_to_cpu(dsb->packed_nid);
>   	sbi->inos = le64_to_cpu(dsb->inos);
>   
> +	sbi->ishare_key_start = le32_to_cpu(dsb->ishare_key_start);
> +
>   	sbi->build_time = le64_to_cpu(dsb->build_time);
>   	sbi->build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
>   
> @@ -676,6 +678,8 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>   	if (err)
>   		return err;
>   
> +	erofs_xattr_set_ishare_key(sb);
> +
>   	erofs_set_sysfs_name(sb);
>   	err = erofs_register_sysfs(sb);
>   	if (err)
> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
> index 7940241d9355..30a64ac3239a 100644
> --- a/fs/erofs/xattr.c
> +++ b/fs/erofs/xattr.c
> @@ -549,3 +549,52 @@ struct posix_acl *erofs_get_acl(struct inode *inode, int type, bool rcu)
>   	return acl;
>   }
>   #endif
> +
> +#ifdef CONFIG_EROFS_FS_INODE_SHARE
> +void erofs_xattr_set_ishare_key(struct super_block *sb)
> +{
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
> +	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
> +	struct xattr_handler const *handler;
> +	erofs_off_t pos;
> +	char *key;
> +	int len, i;
> +	void *ptr;
> +
> +	if (!erofs_sb_has_fragments(sbi) || !erofs_sb_has_ishare_key(sbi) ||
> +	    !sbi->packed_inode)
> +		return;
> +
> +	buf.mapping = sbi->packed_inode->i_mapping;
> +	pos = sbi->ishare_key_start << 2;
> +	ptr = erofs_read_metadata(sb, &buf, &pos, &len);
> +
> +	if (IS_ERR(ptr)) {
> +		erofs_put_metabuf(&buf);
> +		return;
> +	}
> +
> +	for (i = 0; ARRAY_SIZE(erofs_xattr_handlers); i++) {
ARRAY_SIZE will get the length of array erofs_xattr_handlers, here you 
must forget it. So here it should be i < 
ARRAY_SIZE(erofs_xattr_handlers) - 1. :)
> +		handler = erofs_xattr_handlers[i];
> +		if (!handler)
> +			break;
> +		if (!memcmp(handler->prefix, ptr, strlen(handler->prefix)))
> +			break;
> +	}
> +
> +	if (!handler)
> +		return;
This exception branch lacks a call to erofs_put_metabuf(&buf).

> +
> +	len -= strlen(handler->prefix);
> +	key = kzalloc(len + 1, GFP_KERNEL);
> +	if (!key) {
> +		erofs_put_metabuf(&buf);
> +		return;
> +	}
> +
> +	memcpy(key, ptr + strlen(handler->prefix), len);
> +	sbi->ishare_key = key;
> +	sbi->ishare_key_idx = handler->flags;
> +	erofs_put_metabuf(&buf);
> +}
> +#endif
> diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
> index b246cd0e135e..24a243165417 100644
> --- a/fs/erofs/xattr.h
> +++ b/fs/erofs/xattr.h
> @@ -70,4 +70,10 @@ struct posix_acl *erofs_get_acl(struct inode *inode, int type, bool rcu);
>   #define erofs_get_acl	(NULL)
>   #endif
>   
> +#ifdef CONFIG_EROFS_FS_INODE_SHARE
> +void erofs_xattr_set_ishare_key(struct super_block *sb);
> +#else
> +static inline void erofs_xattr_set_ishare_key(struct super_block *sb) {}
> +#endif
> +
>   #endif

