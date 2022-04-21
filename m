Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DFE509E21
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Apr 2022 12:59:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KkZKg33WLz2ywF
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Apr 2022 20:59:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132;
 helo=out30-132.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KkZKZ6wRxz2xrc
 for <linux-erofs@lists.ozlabs.org>; Thu, 21 Apr 2022 20:58:55 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R341e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=20; SR=0; TI=SMTPD_---0VAejRZ._1650538721; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0VAejRZ._1650538721) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 21 Apr 2022 18:58:43 +0800
Date: Thu, 21 Apr 2022 18:58:41 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v9 16/21] erofs: register fscache context for extra data
 blobs
Message-ID: <YmE44WjWAYOkdnQ4@B-P7TQMD6M-0146.local>
Mail-Followup-To: Jeffle Xu <jefflexu@linux.alibaba.com>,
 dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org,
 torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
 willy@infradead.org, linux-fsdevel@vger.kernel.org,
 joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
 tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
 eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
 luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
 fannaihao@baidu.com, zhangjiachen.jaycee@bytedance.com
References: <20220415123614.54024-1-jefflexu@linux.alibaba.com>
 <20220415123614.54024-17-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220415123614.54024-17-jefflexu@linux.alibaba.com>
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
Cc: tianzichen@kuaishou.com, linux-erofs@lists.ozlabs.org, fannaihao@baidu.com,
 willy@infradead.org, linux-kernel@vger.kernel.org, dhowells@redhat.com,
 joseph.qi@linux.alibaba.com, zhangjiachen.jaycee@bytedance.com,
 linux-cachefs@redhat.com, gregkh@linuxfoundation.org,
 linux-fsdevel@vger.kernel.org, luodaowen.backend@bytedance.com,
 gerry@linux.alibaba.com, torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Apr 15, 2022 at 08:36:09PM +0800, Jeffle Xu wrote:
> Similar to the multi device mode, erofs could be mounted from one
> primary data blob (mandatory) and multiple extra data blobs (optional).
> 
> Register fscache context for each extra data blob.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>  fs/erofs/data.c     | 3 +++
>  fs/erofs/internal.h | 2 ++
>  fs/erofs/super.c    | 8 +++++++-
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index bc22642358ec..14b64d960541 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -199,6 +199,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
>  	map->m_bdev = sb->s_bdev;
>  	map->m_daxdev = EROFS_SB(sb)->dax_dev;
>  	map->m_dax_part_off = EROFS_SB(sb)->dax_part_off;
> +	map->m_fscache = EROFS_SB(sb)->s_fscache;
>  
>  	if (map->m_deviceid) {
>  		down_read(&devs->rwsem);
> @@ -210,6 +211,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
>  		map->m_bdev = dif->bdev;
>  		map->m_daxdev = dif->dax_dev;
>  		map->m_dax_part_off = dif->dax_part_off;
> +		map->m_fscache = dif->fscache;
>  		up_read(&devs->rwsem);
>  	} else if (devs->extra_devices) {
>  		down_read(&devs->rwsem);
> @@ -227,6 +229,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
>  				map->m_bdev = dif->bdev;
>  				map->m_daxdev = dif->dax_dev;
>  				map->m_dax_part_off = dif->dax_part_off;
> +				map->m_fscache = dif->fscache;
>  				break;
>  			}
>  		}
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 386658416159..fa488af8dfcf 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -49,6 +49,7 @@ typedef u32 erofs_blk_t;
>  
>  struct erofs_device_info {
>  	char *path;
> +	struct erofs_fscache *fscache;
>  	struct block_device *bdev;
>  	struct dax_device *dax_dev;
>  	u64 dax_part_off;
> @@ -482,6 +483,7 @@ static inline int z_erofs_map_blocks_iter(struct inode *inode,
>  #endif	/* !CONFIG_EROFS_FS_ZIP */
>  
>  struct erofs_map_dev {
> +	struct erofs_fscache *m_fscache;
>  	struct block_device *m_bdev;
>  	struct dax_device *m_daxdev;
>  	u64 m_dax_part_off;
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 61dc900295f9..c6755bcae4a6 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -259,7 +259,12 @@ static int erofs_init_devices(struct super_block *sb,
>  		}
>  		dis = ptr + erofs_blkoff(pos);
>  
> -		if (!erofs_is_fscache_mode(sb)) {
> +		if (erofs_is_fscache_mode(sb)) {
> +			err = erofs_fscache_register_cookie(sb, &dif->fscache,
> +							    dif->path, false);
> +			if (err)
> +				break;
> +		} else {
>  			bdev = blkdev_get_by_path(dif->path,
>  						  FMODE_READ | FMODE_EXCL,
>  						  sb->s_type);
> @@ -710,6 +715,7 @@ static int erofs_release_device_info(int id, void *ptr, void *data)
>  	fs_put_dax(dif->dax_dev);
>  	if (dif->bdev)
>  		blkdev_put(dif->bdev, FMODE_READ | FMODE_EXCL);
> +	erofs_fscache_unregister_cookie(&dif->fscache);
>  	kfree(dif->path);
>  	kfree(dif);
>  	return 0;
> -- 
> 2.27.0
