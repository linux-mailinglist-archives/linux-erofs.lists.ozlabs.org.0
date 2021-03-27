Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2737934B5AE
	for <lists+linux-erofs@lfdr.de>; Sat, 27 Mar 2021 10:34:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F6twM1VJMz30CJ
	for <lists+linux-erofs@lfdr.de>; Sat, 27 Mar 2021 20:34:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.35; helo=szxga07-in.huawei.com;
 envelope-from=yuchao0@huawei.com; receiver=<UNKNOWN>)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F6twK1vlPz2xfR
 for <linux-erofs@lists.ozlabs.org>; Sat, 27 Mar 2021 20:34:41 +1100 (AEDT)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F6tss0nTyz8vRN;
 Sat, 27 Mar 2021 17:32:33 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.498.0; Sat, 27 Mar
 2021 17:34:34 +0800
Subject: Re: [PATCH 2/4] erofs: support adjust lz4 history window size
To: Gao Xiang <hsiangkao@aol.com>, <linux-erofs@lists.ozlabs.org>, Chao Yu
 <chao@kernel.org>
References: <20210327034936.12537-1-hsiangkao@aol.com>
 <20210327034936.12537-3-hsiangkao@aol.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <8169edfd-de1d-e2de-4805-c7e3ce8d7502@huawei.com>
Date: Sat, 27 Mar 2021 17:34:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210327034936.12537-3-hsiangkao@aol.com>
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
Cc: Guo Weichao <guoweichao@oppo.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2021/3/27 11:49, Gao Xiang wrote:
> From: Huang Jianan <huangjianan@oppo.com>
> 
> lz4 uses LZ4_DISTANCE_MAX to record history preservation. When
> using rolling decompression, a block with a higher compression
> ratio will cause a larger memory allocation (up to 64k). It may
> cause a large resource burden in extreme cases on devices with
> small memory and a large number of concurrent IOs. So appropriately
> reducing this value can improve performance.
> 
> Decreasing this value will reduce the compression ratio (except
> when input_size <LZ4_DISTANCE_MAX). But considering that erofs
> currently only supports 4k output, reducing this value will not
> significantly reduce the compression benefits.
> 
> The maximum value of LZ4_DISTANCE_MAX defined by lz4 is 64k, and
> we can only reduce this value. For the old kernel, it just can't
> reduce the memory allocation during rolling decompression without
> affecting the decompression result.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> [ Gao Xiang: introduce struct erofs_sb_lz4_info for configurations. ]
> Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
> ---
>   fs/erofs/decompressor.c | 21 +++++++++++++++++----
>   fs/erofs/erofs_fs.h     |  3 ++-
>   fs/erofs/internal.h     | 19 +++++++++++++++++++
>   fs/erofs/super.c        |  4 +++-
>   4 files changed, 41 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index 80e8871aef71..93411e9df9b6 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -28,6 +28,17 @@ struct z_erofs_decompressor {
>   	char *name;
>   };
>   
> +int z_erofs_load_lz4_config(struct super_block *sb,
> +			    struct erofs_super_block *dsb)
> +{
> +	u16 distance = le16_to_cpu(dsb->lz4_max_distance);
> +
> +	EROFS_SB(sb)->lz4.max_distance_pages = distance ?
> +					DIV_ROUND_UP(distance, PAGE_SIZE) + 1 :
> +					LZ4_MAX_DISTANCE_PAGES;
> +	return 0;
> +}
> +
>   static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
>   					 struct list_head *pagepool)
>   {
> @@ -36,6 +47,8 @@ static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
>   	struct page *availables[LZ4_MAX_DISTANCE_PAGES] = { NULL };
>   	unsigned long bounced[DIV_ROUND_UP(LZ4_MAX_DISTANCE_PAGES,
>   					   BITS_PER_LONG)] = { 0 };
> +	unsigned int lz4_max_distance_pages =
> +				EROFS_SB(rq->sb)->lz4.max_distance_pages;
>   	void *kaddr = NULL;
>   	unsigned int i, j, top;
>   
> @@ -44,14 +57,14 @@ static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
>   		struct page *const page = rq->out[i];
>   		struct page *victim;
>   
> -		if (j >= LZ4_MAX_DISTANCE_PAGES)
> +		if (j >= lz4_max_distance_pages)
>   			j = 0;
>   
>   		/* 'valid' bounced can only be tested after a complete round */
>   		if (test_bit(j, bounced)) {
> -			DBG_BUGON(i < LZ4_MAX_DISTANCE_PAGES);
> -			DBG_BUGON(top >= LZ4_MAX_DISTANCE_PAGES);
> -			availables[top++] = rq->out[i - LZ4_MAX_DISTANCE_PAGES];
> +			DBG_BUGON(i < lz4_max_distance_pages);
> +			DBG_BUGON(top >= lz4_max_distance_pages);
> +			availables[top++] = rq->out[i - lz4_max_distance_pages];
>   		}
>   
>   		if (page) {
> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> index 9ad1615f4474..b27d0e4e4ab5 100644
> --- a/fs/erofs/erofs_fs.h
> +++ b/fs/erofs/erofs_fs.h
> @@ -39,7 +39,8 @@ struct erofs_super_block {
>   	__u8 uuid[16];          /* 128-bit uuid for volume */
>   	__u8 volume_name[16];   /* volume name */
>   	__le32 feature_incompat;
> -	__u8 reserved2[44];
> +	__le16 lz4_max_distance;

It missed to add comments, otherwise it looks good to me.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> +	__u8 reserved2[42];
>   };
>   
>   /*
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index d29fc0c56032..1de60992c3dd 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -59,6 +59,12 @@ struct erofs_fs_context {
>   	unsigned int mount_opt;
>   };
>   
> +/* all filesystem-wide lz4 configurations */
> +struct erofs_sb_lz4_info {
> +	/* # of pages needed for EROFS lz4 rolling decompression */
> +	u16 max_distance_pages;
> +};
> +
>   struct erofs_sb_info {
>   #ifdef CONFIG_EROFS_FS_ZIP
>   	/* list for all registered superblocks, mainly for shrinker */
> @@ -72,6 +78,8 @@ struct erofs_sb_info {
>   
>   	/* pseudo inode to manage cached pages */
>   	struct inode *managed_cache;
> +
> +	struct erofs_sb_lz4_info lz4;
>   #endif	/* CONFIG_EROFS_FS_ZIP */
>   	u32 blocks;
>   	u32 meta_blkaddr;
> @@ -432,6 +440,8 @@ int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
>   				       struct erofs_workgroup *egrp);
>   int erofs_try_to_free_cached_page(struct address_space *mapping,
>   				  struct page *page);
> +int z_erofs_load_lz4_config(struct super_block *sb,
> +			    struct erofs_super_block *dsb);
>   #else
>   static inline void erofs_shrinker_register(struct super_block *sb) {}
>   static inline void erofs_shrinker_unregister(struct super_block *sb) {}
> @@ -439,6 +449,15 @@ static inline int erofs_init_shrinker(void) { return 0; }
>   static inline void erofs_exit_shrinker(void) {}
>   static inline int z_erofs_init_zip_subsystem(void) { return 0; }
>   static inline void z_erofs_exit_zip_subsystem(void) {}
> +static inline int z_erofs_load_lz4_config(struct super_block *sb,
> +				struct erofs_super_block *dsb)
> +{
> +	if (dsb->lz4_max_distance) {
> +		erofs_err(sb, "lz4 algorithm isn't enabled");
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
>   #endif	/* !CONFIG_EROFS_FS_ZIP */
>   
>   #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 991b99eaf22a..3212e4f73f85 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -187,7 +187,9 @@ static int erofs_read_superblock(struct super_block *sb)
>   		ret = -EFSCORRUPTED;
>   		goto out;
>   	}
> -	ret = 0;
> +
> +	/* parse on-disk compression configurations */
> +	ret = z_erofs_load_lz4_config(sb, dsb);
>   out:
>   	kunmap(page);
>   	put_page(page);
> 
