Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 607377A1A63
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Sep 2023 11:22:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rn7xY2R3hz3cSn
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Sep 2023 19:22:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rn7wV4cRlz3cDR
	for <linux-erofs@lists.ozlabs.org>; Fri, 15 Sep 2023 19:21:12 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vs6hgN4_1694769665;
Received: from 30.97.48.166(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vs6hgN4_1694769665)
          by smtp.aliyun-inc.com;
          Fri, 15 Sep 2023 17:21:06 +0800
Message-ID: <38c2d83f-1f08-bd54-7e97-c4fc3a496e94@linux.alibaba.com>
Date: Fri, 15 Sep 2023 17:21:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2] erofs-utils: mkfs: support flatdev for multi-blob
 images
To: Jingbo Xu <jefflexu@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20230915081654.33112-1-jefflexu@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230915081654.33112-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/9/15 16:16, Jingbo Xu wrote:
> Since kernel commit 8b465fecc35a ("erofs: support flattened block device
> for multi-blob images"), the flatdev feature has been introduced to
> support mounting multi-blobs container image as a single block device.
> 
> To enable this feature, the mapped_blkaddr of each device slot needs to
> be set properly to the offset of the device in the flat address space.
> 
> The kernel side requires a non-empty device tag to mount an image in
> flatdev mode.  The uuid of the source image is used as the corresponding
> device tag in rebuild mode.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
> v2: drop "-Eflatdev" option; always set mapped_blkaddr in device slot
> ---
>   include/erofs/internal.h |  1 +
>   lib/blobchunk.c          |  8 ++++++--
>   lib/super.c              |  1 +
>   mkfs/main.c              | 17 +++++++++++++----
>   4 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> index 19b912b..616cd3a 100644
> --- a/include/erofs/internal.h
> +++ b/include/erofs/internal.h
> @@ -54,6 +54,7 @@ extern struct erofs_sb_info sbi;
>   struct erofs_buffer_head;
>   
>   struct erofs_device_info {
> +	u8 tag[64];
>   	u32 blocks;
>   	u32 mapped_blkaddr;
>   };
> diff --git a/lib/blobchunk.c b/lib/blobchunk.c
> index aca616e..a599f3a 100644
> --- a/lib/blobchunk.c
> +++ b/lib/blobchunk.c
> @@ -410,20 +410,24 @@ int erofs_mkfs_dump_blobs(struct erofs_sb_info *sbi)
>   	}
>   
>   	if (sbi->extra_devices) {
> -		unsigned int i;
> +		unsigned int i, ret;
> +		erofs_blk_t nblocks;
>   
> +		nblocks = erofs_mapbh(NULL);
>   		pos_out = erofs_btell(bh_devt, false);
>   		i = 0;
>   		do {
>   			struct erofs_deviceslot dis = {
> +				.mapped_blkaddr = cpu_to_le32(nblocks),
>   				.blocks = cpu_to_le32(sbi->devs[i].blocks),
>   			};
> -			int ret;
>   
> +			memcpy(dis.tag, sbi->devs[i].tag, sizeof(dis.tag));
>   			ret = dev_write(sbi, &dis, pos_out, sizeof(dis));
>   			if (ret)
>   				return ret;
>   			pos_out += sizeof(dis);
> +			nblocks += sbi->devs[i].blocks;
>   		} while (++i < sbi->extra_devices);
>   		bh_devt->op = &erofs_drop_directly_bhops;
>   		erofs_bdrop(bh_devt, false);
> diff --git a/lib/super.c b/lib/super.c
> index ce97278..f952f7e 100644
> --- a/lib/super.c
> +++ b/lib/super.c
> @@ -65,6 +65,7 @@ static int erofs_init_devices(struct erofs_sb_info *sbi,
>   
>   		sbi->devs[i].mapped_blkaddr = le32_to_cpu(dis.mapped_blkaddr);
>   		sbi->devs[i].blocks = le32_to_cpu(dis.blocks);
> +		memcpy(sbi->devs[i].tag, dis.tag, sizeof(dis.tag));
>   		sbi->total_blocks += sbi->devs[i].blocks;
>   		pos += EROFS_DEVT_SLOT_SIZE;
>   	}
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 4fa2d92..9327b6f 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -765,8 +765,15 @@ static void erofs_mkfs_default_options(void)
>   	sbi.feature_compat = EROFS_FEATURE_COMPAT_SB_CHKSUM |
>   			     EROFS_FEATURE_COMPAT_MTIME;
>   
> -	/* generate a default uuid first */
> -	erofs_uuid_generate(sbi.uuid);
> +	/*
> +	 * Generate a default uuid first.  In rebuild mode the uuid of the
> +	 * source image is used as the device slot's tag.  The kernel will
> +	 * identify the tag as empty and fail the mount if its first byte is
> +	 * zero.  Apply this constraint to uuid to work around it.
> +	 */
> +	do {
> +		erofs_uuid_generate(sbi.uuid);
> +	} while (!sbi.uuid[0]);

I don't think we need this, since uuid need to be parsed to string.

>   }
>   
>   /* https://reproducible-builds.org/specs/source-date-epoch/ for more details */
> @@ -822,7 +829,7 @@ static int erofs_rebuild_load_trees(struct erofs_inode *root)
>   	struct erofs_sb_info *src;
>   	unsigned int extra_devices = 0;
>   	erofs_blk_t nblocks;
> -	int ret;
> +	int ret, idx;
>   
>   	list_for_each_entry(src, &rebuild_src_list, list) {
>   		ret = erofs_rebuild_load_tree(root, src);
> @@ -854,7 +861,9 @@ static int erofs_rebuild_load_trees(struct erofs_inode *root)
>   		else
>   			nblocks = src->primarydevice_blocks;
>   		DBG_BUGON(src->dev < 1);
> -		sbi.devs[src->dev - 1].blocks = nblocks;
> +		idx = src->dev - 1;
> +		sbi.devs[idx].blocks = nblocks;
> +		memcpy(sbi.devs[idx].tag, src->uuid, sizeof(src->uuid));

Should we use string conversion instead? Should we use uuid only
if sbi.devs[idx].tag is empty?

Thanks,
Gao Xiang

