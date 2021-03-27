Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D13C34B5B7
	for <lists+linux-erofs@lfdr.de>; Sat, 27 Mar 2021 10:47:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F6vBV32Xbz30Cb
	for <lists+linux-erofs@lfdr.de>; Sat, 27 Mar 2021 20:46:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.190; helo=szxga04-in.huawei.com;
 envelope-from=yuchao0@huawei.com; receiver=<UNKNOWN>)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F6vBR25PWz2yy3
 for <linux-erofs@lists.ozlabs.org>; Sat, 27 Mar 2021 20:46:53 +1100 (AEDT)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F6v7L3VQmzndZq;
 Sat, 27 Mar 2021 17:44:14 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.498.0; Sat, 27 Mar
 2021 17:46:44 +0800
Subject: Re: [PATCH 4/4] erofs: add on-disk compression configurations
To: Gao Xiang <hsiangkao@aol.com>, <linux-erofs@lists.ozlabs.org>, Chao Yu
 <chao@kernel.org>
References: <20210327034936.12537-1-hsiangkao@aol.com>
 <20210327034936.12537-5-hsiangkao@aol.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <7a2b76ff-f86f-79ce-d6e9-f8c359f90ae4@huawei.com>
Date: Sat, 27 Mar 2021 17:46:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210327034936.12537-5-hsiangkao@aol.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2021/3/27 11:49, Gao Xiang wrote:
> From: Gao Xiang <hsiangkao@redhat.com>
> 
> Add a bitmap for available compression algorithms and a variable-sized
> on-disk table for compression options in preparation for upcoming big
> pcluster and LZMA algorithm, which follows the end of super block.
> 
> To parse the compression options, the bitmap is scanned one by one.
> For each available algorithm, there is data followed by 2-byte `length'
> correspondingly (it's enough for most cases, or entire fs blocks should
> be used.)
> 
> With such available algorithm bitmap, kernel itself can also refuse to
> mount such filesystem if any unsupported compression algorithm exists.
> 
> Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
> ---
>   fs/erofs/decompressor.c |   2 +-
>   fs/erofs/erofs_fs.h     |  16 +++--
>   fs/erofs/internal.h     |   5 +-
>   fs/erofs/super.c        | 145 +++++++++++++++++++++++++++++++++++++++-
>   4 files changed, 161 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index 97538ff24a19..27aa6a99b371 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -41,7 +41,7 @@ int z_erofs_load_lz4_config(struct super_block *sb,
>   		}
>   		distance = le16_to_cpu(lz4->max_distance);
>   	} else {
> -		distance = le16_to_cpu(dsb->lz4_max_distance);
> +		distance = le16_to_cpu(dsb->u1.lz4_max_distance);
>   	}
>   
>   	EROFS_SB(sb)->lz4.max_distance_pages = distance ?
> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> index 1322ae63944b..ef3f8a99aa5f 100644
> --- a/fs/erofs/erofs_fs.h
> +++ b/fs/erofs/erofs_fs.h
> @@ -18,15 +18,18 @@
>    * be incompatible with this kernel version.
>    */
>   #define EROFS_FEATURE_INCOMPAT_LZ4_0PADDING	0x00000001
> -#define EROFS_ALL_FEATURE_INCOMPAT		EROFS_FEATURE_INCOMPAT_LZ4_0PADDING
> +#define EROFS_FEATURE_INCOMPAT_COMPR_CFGS	0x00000002
> +#define EROFS_ALL_FEATURE_INCOMPAT		\
> +	(EROFS_FEATURE_INCOMPAT_LZ4_0PADDING | \
> +	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS)
>   
> -/* 128-byte erofs on-disk super block */
> +/* erofs on-disk super block (currently 128 bytes) */
>   struct erofs_super_block {
>   	__le32 magic;           /* file system magic number */
>   	__le32 checksum;        /* crc32c(super_block) */
>   	__le32 feature_compat;
>   	__u8 blkszbits;         /* support block_size == PAGE_SIZE only */
> -	__u8 reserved;
> +	__u8 sb_extslots;	/* superblock size = 128 + sb_extslots * 16 */
>   
>   	__le16 root_nid;	/* nid of root directory */
>   	__le64 inos;            /* total valid ino # (== f_files - f_favail) */
> @@ -39,7 +42,11 @@ struct erofs_super_block {
>   	__u8 uuid[16];          /* 128-bit uuid for volume */
>   	__u8 volume_name[16];   /* volume name */
>   	__le32 feature_incompat;
> -	__le16 lz4_max_distance;
> +	union {
> +		/* bitmap for available compression algorithms */
> +		__le16 available_compr_algs;
> +		__le16 lz4_max_distance;
> +	} __packed u1;
>   	__u8 reserved2[42];
>   };
>   
> @@ -195,6 +202,7 @@ enum {
>   	Z_EROFS_COMPRESSION_LZ4	= 0,
>   	Z_EROFS_COMPRESSION_MAX
>   };
> +#define Z_EROFS_ALL_COMPR_ALGS		(1 << (Z_EROFS_COMPRESSION_MAX - 1))
>   
>   /* 14 bytes (+ length field = 16 bytes) */
>   struct z_erofs_lz4_cfgs {
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 46b977f348eb..f3fa895d809f 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -75,6 +75,7 @@ struct erofs_sb_info {
>   	struct xarray managed_pslots;
>   
>   	unsigned int shrinker_run_no;
> +	u16 available_compr_algs;
>   
>   	/* pseudo inode to manage cached pages */
>   	struct inode *managed_cache;
> @@ -90,6 +91,7 @@ struct erofs_sb_info {
>   	/* inode slot unit size in bit shift */
>   	unsigned char islotbits;
>   
> +	u32 sb_size;			/* total superblock size */
>   	u32 build_time_nsec;
>   	u64 build_time;
>   
> @@ -233,6 +235,7 @@ static inline bool erofs_sb_has_##name(struct erofs_sb_info *sbi) \
>   }
>   
>   EROFS_FEATURE_FUNCS(lz4_0padding, incompat, INCOMPAT_LZ4_0PADDING)
> +EROFS_FEATURE_FUNCS(compr_cfgs, incompat, INCOMPAT_COMPR_CFGS)
>   EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
>   
>   /* atomic flag definitions */
> @@ -454,7 +457,7 @@ static inline int z_erofs_load_lz4_config(struct super_block *sb,
>   				  struct erofs_super_block *dsb,
>   				  struct z_erofs_lz4_cfgs *lz4, int len)
>   {
> -	if (lz4 || dsb->lz4_max_distance) {
> +	if (lz4 || dsb->u1.lz4_max_distance) {
>   		erofs_err(sb, "lz4 algorithm isn't enabled");
>   		return -EINVAL;
>   	}
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 1ca8da3f2125..c5e3039f51bf 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -122,6 +122,138 @@ static bool check_layout_compatibility(struct super_block *sb,
>   	return true;
>   }
>   
> +#ifdef CONFIG_EROFS_FS_ZIP
> +/* read variable-sized metadata, offset will be aligned by 4-byte */
> +static void *erofs_read_metadata(struct super_block *sb, struct page **pagep,
> +				 erofs_off_t *offset, int *lengthp)
> +{
> +	struct page *page = *pagep;
> +	u8 *buffer, *ptr;
> +	int len, i, cnt;
> +	erofs_blk_t blk;
> +
> +	*offset = round_up(*offset, 4);
> +	blk = erofs_blknr(*offset);
> +
> +	if (!page || page->index != blk) {
> +		if (page) {
> +			unlock_page(page);
> +			put_page(page);
> +		}
> +		page = erofs_get_meta_page(sb, blk);
> +		if (IS_ERR(page))
> +			goto err_nullpage;
> +	}
> +
> +	ptr = kmap(page);
> +	len = le16_to_cpu(*(__le16 *)&ptr[erofs_blkoff(*offset)]);
> +	if (!len)
> +		len = U16_MAX + 1;
> +	buffer = kmalloc(len, GFP_KERNEL);
> +	if (!buffer) {
> +		buffer = ERR_PTR(-ENOMEM);

Caller expects valid page w/o kmapped or a NULL page, right? it needs
to call kunmap() here? or out label can be relocated above kunmap()?

Thanks,

> +		goto out;
> +	}
> +	*offset += sizeof(__le16);
> +	*lengthp = len;
> +
> +	for (i = 0; i < len; i += cnt) {
> +		cnt = min(EROFS_BLKSIZ - (int)erofs_blkoff(*offset), len - i);
> +		blk = erofs_blknr(*offset);
> +
> +		if (!page || page->index != blk) {
> +			if (page) {
> +				kunmap(page);
> +				unlock_page(page);
> +				put_page(page);
> +			}
> +			page = erofs_get_meta_page(sb, blk);
> +			if (IS_ERR(page)) {
> +				kfree(buffer);
> +				goto err_nullpage;
> +			}
> +			ptr = kmap(page);
> +		}
> +		memcpy(buffer + i, ptr + erofs_blkoff(*offset), cnt);
> +		*offset += cnt;
> +	}
> +	kunmap(page);
> +out:
> +	*pagep = page;
> +	return buffer;
> +err_nullpage:
> +	*pagep = NULL;
> +	return page;
> +}
> +
> +static int erofs_load_compr_cfgs(struct super_block *sb,
> +				 struct erofs_super_block *dsb)
> +{
> +	struct erofs_sb_info *sbi;
> +	struct page *page;
> +	unsigned int algs, alg;
> +	erofs_off_t offset;
> +	int size, ret;
> +
> +	sbi = EROFS_SB(sb);
> +	sbi->available_compr_algs = le16_to_cpu(dsb->u1.available_compr_algs);
> +
> +	if (sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS) {
> +		erofs_err(sb,
> +"try to load compressed image with unsupported algorithms %x",
> +			  sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS);
> +		return -EINVAL;
> +	}
> +
> +	offset = EROFS_SUPER_OFFSET + sbi->sb_size;
> +	page = NULL;
> +	alg = 0;
> +	ret = 0;
> +
> +	for (algs = sbi->available_compr_algs; algs; algs >>= 1, ++alg) {
> +		void *data;
> +
> +		if (!(algs & 1))
> +			continue;
> +
> +		data = erofs_read_metadata(sb, &page, &offset, &size);
> +		if (IS_ERR(data)) {
> +			ret = PTR_ERR(data);
> +			goto err;
> +		}
> +
> +		switch (alg) {
> +		case Z_EROFS_COMPRESSION_LZ4:
> +			ret = z_erofs_load_lz4_config(sb, dsb, data, size);
> +			break;
> +		default:
> +			DBG_BUGON(1);
> +			ret = -EFAULT;
> +		}
> +		kfree(data);
> +		if (ret)
> +			goto err;
> +	}
> +err:
> +	if (page) {
> +		unlock_page(page);
> +		put_page(page);
> +	}
> +	return ret;
> +}
> +#else
> +static int erofs_load_compr_cfgs(struct super_block *sb,
> +				 struct erofs_super_block *dsb)
> +{
> +	if (dsb->u1.available_compr_algs) {
> +		erofs_err(sb,
> +"try to load compressed image when compression is disabled");
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +#endif
> +
>   static int erofs_read_superblock(struct super_block *sb)
>   {
>   	struct erofs_sb_info *sbi;
> @@ -166,6 +298,13 @@ static int erofs_read_superblock(struct super_block *sb)
>   	if (!check_layout_compatibility(sb, dsb))
>   		goto out;
>   
> +	sbi->sb_size = 128 + dsb->sb_extslots * 16;
> +	if (sbi->sb_size > EROFS_BLKSIZ) {
> +		erofs_err(sb, "invalid sb_extslots %u (more than a fs block)",
> +			  sbi->sb_size);
> +		goto out;
> +	}
> +
>   	sbi->blocks = le32_to_cpu(dsb->blocks);
>   	sbi->meta_blkaddr = le32_to_cpu(dsb->meta_blkaddr);
>   #ifdef CONFIG_EROFS_FS_XATTR
> @@ -189,7 +328,11 @@ static int erofs_read_superblock(struct super_block *sb)
>   	}
>   
>   	/* parse on-disk compression configurations */
> -	ret = z_erofs_load_lz4_config(sb, dsb, NULL, 0);
> +	if (erofs_sb_has_compr_cfgs(sbi))
> +		ret = erofs_load_compr_cfgs(sb, dsb);
> +	else
> +		ret = z_erofs_load_lz4_config(sb, dsb, NULL, 0);
> +
>   out:
>   	kunmap(page);
>   	put_page(page);
> 
