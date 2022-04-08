Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 878A34F8BE8
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Apr 2022 04:12:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KZMFt46Y1z2yw9
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Apr 2022 12:12:18 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54;
 helo=out30-54.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KZMFj6VnQz2xgX
 for <linux-erofs@lists.ozlabs.org>; Fri,  8 Apr 2022 12:12:04 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R211e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=18; SR=0; TI=SMTPD_---0V9TMXhB_1649383908; 
Received: from 30.225.24.70(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V9TMXhB_1649383908) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 08 Apr 2022 10:11:49 +0800
Message-ID: <ac8571b8-0935-1f4f-e9f1-e424f059b5ed@linux.alibaba.com>
Date: Fri, 8 Apr 2022 10:11:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v8 15/20] erofs: register fscache context for extra data
 blobs
Content-Language: en-US
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org,
 torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
 willy@infradead.org, linux-fsdevel@vger.kernel.org,
 joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
 tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
 eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
 luodaowen.backend@bytedance.com, tianzichen@kuaishou.com, fannaihao@baidu.com
References: <20220406075612.60298-1-jefflexu@linux.alibaba.com>
 <20220406075612.60298-16-jefflexu@linux.alibaba.com>
 <Yk7yCp2fwnbXeyuI@debian>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <Yk7yCp2fwnbXeyuI@debian>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 4/7/22 10:15 PM, Gao Xiang wrote:
> On Wed, Apr 06, 2022 at 03:56:07PM +0800, Jeffle Xu wrote:
>> Similar to the multi device mode, erofs could be mounted from one
>> primary data blob (mandatory) and multiple extra data blobs (optional).
>>
>> Register fscache context for each extra data blob.
>>
>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>> ---
>>  fs/erofs/data.c     |  3 +++
>>  fs/erofs/internal.h |  2 ++
>>  fs/erofs/super.c    | 25 +++++++++++++++++--------
>>  3 files changed, 22 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
>> index bc22642358ec..14b64d960541 100644
>> --- a/fs/erofs/data.c
>> +++ b/fs/erofs/data.c
>> @@ -199,6 +199,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
>>  	map->m_bdev = sb->s_bdev;
>>  	map->m_daxdev = EROFS_SB(sb)->dax_dev;
>>  	map->m_dax_part_off = EROFS_SB(sb)->dax_part_off;
>> +	map->m_fscache = EROFS_SB(sb)->s_fscache;
>>  
>>  	if (map->m_deviceid) {
>>  		down_read(&devs->rwsem);
>> @@ -210,6 +211,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
>>  		map->m_bdev = dif->bdev;
>>  		map->m_daxdev = dif->dax_dev;
>>  		map->m_dax_part_off = dif->dax_part_off;
>> +		map->m_fscache = dif->fscache;
>>  		up_read(&devs->rwsem);
>>  	} else if (devs->extra_devices) {
>>  		down_read(&devs->rwsem);
>> @@ -227,6 +229,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
>>  				map->m_bdev = dif->bdev;
>>  				map->m_daxdev = dif->dax_dev;
>>  				map->m_dax_part_off = dif->dax_part_off;
>> +				map->m_fscache = dif->fscache;
>>  				break;
>>  			}
>>  		}
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index eb37b33bce37..90f7d6286a4f 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -49,6 +49,7 @@ typedef u32 erofs_blk_t;
>>  
>>  struct erofs_device_info {
>>  	char *path;
>> +	struct erofs_fscache *fscache;
>>  	struct block_device *bdev;
>>  	struct dax_device *dax_dev;
>>  	u64 dax_part_off;
>> @@ -482,6 +483,7 @@ static inline int z_erofs_map_blocks_iter(struct inode *inode,
>>  #endif	/* !CONFIG_EROFS_FS_ZIP */
>>  
>>  struct erofs_map_dev {
>> +	struct erofs_fscache *m_fscache;
>>  	struct block_device *m_bdev;
>>  	struct dax_device *m_daxdev;
>>  	u64 m_dax_part_off;
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index 9498b899b73b..8c7181cd37e6 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -259,15 +259,23 @@ static int erofs_init_devices(struct super_block *sb,
>>  		}
>>  		dis = ptr + erofs_blkoff(pos);
>>  
>> -		bdev = blkdev_get_by_path(dif->path,
>> -					  FMODE_READ | FMODE_EXCL,
>> -					  sb->s_type);
>> -		if (IS_ERR(bdev)) {
>> -			err = PTR_ERR(bdev);
>> -			break;
>> +		if (erofs_is_fscache_mode(sb)) {
>> +			err = erofs_fscache_register_cookie(sb, &dif->fscache,
>> +							    dif->path, false);
>> +			if (err)
>> +				break;
>> +		} else {
>> +			bdev = blkdev_get_by_path(dif->path,
>> +						  FMODE_READ | FMODE_EXCL,
>> +						  sb->s_type);
>> +			if (IS_ERR(bdev)) {
>> +				err = PTR_ERR(bdev);
>> +				break;
>> +			}
>> +			dif->bdev = bdev;
>> +			dif->dax_dev = fs_dax_get_by_bdev(bdev, &dif->dax_part_off);
> 
> Overly long line, please help split into 2 lines if possible.
> 

Will be fixed in the next version.


-- 
Thanks,
Jeffle
