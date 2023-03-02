Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B81A6A7B6D
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Mar 2023 07:40:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PS1gM100sz3cMN
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Mar 2023 17:39:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PS1gF40t2z3bh9
	for <linux-erofs@lists.ozlabs.org>; Thu,  2 Mar 2023 17:39:52 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VcwEyyf_1677739186;
Received: from 30.221.130.171(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VcwEyyf_1677739186)
          by smtp.aliyun-inc.com;
          Thu, 02 Mar 2023 14:39:47 +0800
Message-ID: <8be37b4c-5a87-1c10-b0e6-99284e6fd4ca@linux.alibaba.com>
Date: Thu, 2 Mar 2023 14:39:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH V2] erofs: support flattened block device for multi-blob
 images
Content-Language: en-US
To: Jia Zhu <zhujia.zj@bytedance.com>, xiang@kernel.org, chao@kernel.org,
 gerry@linux.alibaba.com, linux-erofs@lists.ozlabs.org
References: <20230301125908.30879-1-zhujia.zj@bytedance.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20230301125908.30879-1-zhujia.zj@bytedance.com>
Content-Type: text/plain; charset=UTF-8
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
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 3/1/23 8:59 PM, Jia Zhu wrote:
> In order to support mounting multi-blobs container image as a single
> block device, add flattened block device feature for EROFS.
> 
> In this mode, all meta/data contents will be mapped into one block
> address. User could compose a block device(by nbd/ublk/virtio-blk/
> vhost-user-blk) from multiple sources and mount the block device by
> EROFS directly. It can reduce the number of block devices used, and
> it's also benefits in both VM file passthrough and distributed storage
> scenarios.
> 
> You can test this using the method mentioned by:
> https://github.com/dragonflyoss/image-service/pull/1111
> 1. Compose a (nbd)block device from multi-blobs.
> 2. Mount EROFS on mntdir/.
> 3. Compare the md5sum between source dir and mntdir/.
> 
> Later, we could also use it to refer original tar blobs.
> 
> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
> Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> ---
> v2:
> 1. Supplement commit message.
> 2. Add a bool field in erofs_dev_context to indicate flattened block
>    device mode.
> ---
>  fs/erofs/data.c     | 8 ++++++--
>  fs/erofs/internal.h | 1 +
>  fs/erofs/super.c    | 6 +++++-
>  3 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index e16545849ea7..818f78ce648c 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -197,7 +197,6 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
>  	struct erofs_device_info *dif;
>  	int id;
>  
> -	/* primary device by default */
>  	map->m_bdev = sb->s_bdev;
>  	map->m_daxdev = EROFS_SB(sb)->dax_dev;
>  	map->m_dax_part_off = EROFS_SB(sb)->dax_part_off;
> @@ -210,12 +209,17 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
>  			up_read(&devs->rwsem);
>  			return -ENODEV;
>  		}
> +		if (devs->flatdev) {
> +			map->m_pa += blknr_to_addr(dif->mapped_blkaddr);
> +			up_read(&devs->rwsem);
> +			return 0;
> +		}
>  		map->m_bdev = dif->bdev;
>  		map->m_daxdev = dif->dax_dev;
>  		map->m_dax_part_off = dif->dax_part_off;
>  		map->m_fscache = dif->fscache;
>  		up_read(&devs->rwsem);
> -	} else if (devs->extra_devices) {
> +	} else if (devs->extra_devices && !devs->flatdev) {
>  		down_read(&devs->rwsem);
>  		idr_for_each_entry(&devs->tree, dif, id) {
>  			erofs_off_t startoff, length;
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 3f3561d37d1b..4fee380a98d9 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -81,6 +81,7 @@ struct erofs_dev_context {
>  	struct rw_semaphore rwsem;
>  
>  	unsigned int extra_devices;
> +	bool flatdev;
>  };
>  
>  struct erofs_fs_context {
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 19b1ae79cec4..307b3d2392cf 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -248,7 +248,7 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
>  		if (IS_ERR(fscache))
>  			return PTR_ERR(fscache);
>  		dif->fscache = fscache;
> -	} else {
> +	} else if (!sbi->devs->flatdev) {
>  		bdev = blkdev_get_by_path(dif->path, FMODE_READ | FMODE_EXCL,
>  					  sb->s_type);
>  		if (IS_ERR(bdev))
> @@ -281,6 +281,10 @@ static int erofs_scan_devices(struct super_block *sb,
>  	else
>  		ondisk_extradevs = le16_to_cpu(dsb->extra_devices);
>  
> +	if (!sbi->devs->extra_devices && ondisk_extradevs &&
> +		!erofs_is_fscache_mode(sb))
> +		sbi->devs->flatdev = true;
> +

I would move this check down after all sanity checks, e.g.

	if (!ondisk_extradevs)
		return 0;

+	if (!sbi->devs->extra_devices && !erofs_is_fscache_mode(sb))
+		sbi->devs->flatdev = true;



Otherwise LGTM.


-- 
Thanks,
Jingbo
