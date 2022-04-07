Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA934F8164
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Apr 2022 16:16:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KZ3Mj3l3tz3bdg
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Apr 2022 00:16:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dWM0OU/2;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1;
 helo=ams.source.kernel.org; envelope-from=xiang@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=dWM0OU/2; 
 dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KZ3MB0xDvz3bZX
 for <linux-erofs@lists.ozlabs.org>; Fri,  8 Apr 2022 00:15:49 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 36592B82772;
 Thu,  7 Apr 2022 14:15:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984C2C385A0;
 Thu,  7 Apr 2022 14:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649340945;
 bh=GOzsGxLSkBQqhIXrfCngzZGevBYoeZtJmUwSO2v+asA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dWM0OU/2Eup7bAXKcIadgArZ3JejnCml0I3OwlKXzMbr+/R0fMI7JBjE0pxNiy0UV
 Mbh5zU1FOxlrtJnx4lYUWlHWv6TPvdzYFoeWBXgfdOdk5zlCQxrIpGxsF7/DCJRkdJ
 +jkK+3UerSHxYp/9xLF/itnP94a0Vf1q449k8ruToThDqjVvGRDq+FtwlDPDIIK1Ry
 pcHpvMXAf/l1nCkS+JBqNQlDBaPfGPyAudheytXPENJIkyajbjSpQc9yP8aLt69Ndu
 Zhg6shjlUBmDh3J5Zf4k5JXaFUyTZxomEjsG8KjSUC22fJJOeuRxsPJjD4Bl29yh+Z
 JouYtEfQ2hA7Q==
Date: Thu, 7 Apr 2022 22:15:38 +0800
From: Gao Xiang <xiang@kernel.org>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v8 15/20] erofs: register fscache context for extra data
 blobs
Message-ID: <Yk7yCp2fwnbXeyuI@debian>
Mail-Followup-To: Jeffle Xu <jefflexu@linux.alibaba.com>,
 dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org,
 torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
 willy@infradead.org, linux-fsdevel@vger.kernel.org,
 joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
 tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
 eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
 luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
 fannaihao@baidu.com
References: <20220406075612.60298-1-jefflexu@linux.alibaba.com>
 <20220406075612.60298-16-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220406075612.60298-16-jefflexu@linux.alibaba.com>
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
 joseph.qi@linux.alibaba.com, linux-cachefs@redhat.com,
 gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
 luodaowen.backend@bytedance.com, gerry@linux.alibaba.com,
 torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Apr 06, 2022 at 03:56:07PM +0800, Jeffle Xu wrote:
> Similar to the multi device mode, erofs could be mounted from one
> primary data blob (mandatory) and multiple extra data blobs (optional).
> 
> Register fscache context for each extra data blob.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/erofs/data.c     |  3 +++
>  fs/erofs/internal.h |  2 ++
>  fs/erofs/super.c    | 25 +++++++++++++++++--------
>  3 files changed, 22 insertions(+), 8 deletions(-)
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
> index eb37b33bce37..90f7d6286a4f 100644
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
> index 9498b899b73b..8c7181cd37e6 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -259,15 +259,23 @@ static int erofs_init_devices(struct super_block *sb,
>  		}
>  		dis = ptr + erofs_blkoff(pos);
>  
> -		bdev = blkdev_get_by_path(dif->path,
> -					  FMODE_READ | FMODE_EXCL,
> -					  sb->s_type);
> -		if (IS_ERR(bdev)) {
> -			err = PTR_ERR(bdev);
> -			break;
> +		if (erofs_is_fscache_mode(sb)) {
> +			err = erofs_fscache_register_cookie(sb, &dif->fscache,
> +							    dif->path, false);
> +			if (err)
> +				break;
> +		} else {
> +			bdev = blkdev_get_by_path(dif->path,
> +						  FMODE_READ | FMODE_EXCL,
> +						  sb->s_type);
> +			if (IS_ERR(bdev)) {
> +				err = PTR_ERR(bdev);
> +				break;
> +			}
> +			dif->bdev = bdev;
> +			dif->dax_dev = fs_dax_get_by_bdev(bdev, &dif->dax_part_off);

Overly long line, please help split into 2 lines if possible.

Otherwise looks good,
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

>  		}
> -		dif->bdev = bdev;
> -		dif->dax_dev = fs_dax_get_by_bdev(bdev, &dif->dax_part_off);
> +
>  		dif->blocks = le32_to_cpu(dis->blocks);
>  		dif->mapped_blkaddr = le32_to_cpu(dis->mapped_blkaddr);
>  		sbi->total_blocks += dif->blocks;
> @@ -701,6 +709,7 @@ static int erofs_release_device_info(int id, void *ptr, void *data)
>  	fs_put_dax(dif->dax_dev);
>  	if (dif->bdev)
>  		blkdev_put(dif->bdev, FMODE_READ | FMODE_EXCL);
> +	erofs_fscache_unregister_cookie(&dif->fscache);
>  	kfree(dif->path);
>  	kfree(dif);
>  	return 0;
> -- 
> 2.27.0
> 
