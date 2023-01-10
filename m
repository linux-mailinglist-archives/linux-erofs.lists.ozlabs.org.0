Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D54E663C0C
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Jan 2023 10:00:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NrlCM31Ctz3cBF
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Jan 2023 20:00:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43; helo=out30-43.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NrlCF1dT7z3bTK
	for <linux-erofs@lists.ozlabs.org>; Tue, 10 Jan 2023 20:00:40 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VZIZFJP_1673341234;
Received: from 30.97.49.37(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VZIZFJP_1673341234)
          by smtp.aliyun-inc.com;
          Tue, 10 Jan 2023 17:00:35 +0800
Message-ID: <24d6bb29-d81e-14b7-141d-c13477819143@linux.alibaba.com>
Date: Tue, 10 Jan 2023 17:00:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/3] erofs-utils: lib: export parts of erofs_pread()
To: Yue Hu <zbestahu@gmail.com>, linux-erofs@lists.ozlabs.org
References: <20230110084959.1955-1-zbestahu@gmail.com>
From: Xiang Gao <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230110084959.1955-1-zbestahu@gmail.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yue,

The patch itself generally looks good to me:

On 2023/1/10 16:49, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> Export parts of erofs_pread() to avoid duplicated code in
> erofs_verify_inode_data(). Let's make two helpers for this.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> ---
> v2: use parameter trimmed instead of partial
> 
>   include/erofs/internal.h |   5 ++
>   lib/data.c               | 154 ++++++++++++++++++++++-----------------
>   2 files changed, 92 insertions(+), 67 deletions(-)
> 
> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> index 206913c..47240f5 100644
> --- a/include/erofs/internal.h
> +++ b/include/erofs/internal.h
> @@ -355,6 +355,11 @@ int erofs_pread(struct erofs_inode *inode, char *buf,
>   int erofs_map_blocks(struct erofs_inode *inode,
>   		struct erofs_map_blocks *map, int flags);
>   int erofs_map_dev(struct erofs_sb_info *sbi, struct erofs_map_dev *map);
> +int erofs_read_raw_data_mapped(struct erofs_map_blocks *map, char *buffer,
> +			       u64 offset, size_t len);
> +int z_erofs_read_data_mapped(struct erofs_inode *inode,
> +			struct erofs_map_blocks *map, char *raw, char *buffer,
> +			erofs_off_t skip, erofs_off_t length, bool trimmed);
>   
>   static inline int erofs_get_occupied_size(const struct erofs_inode *inode,
>   					  erofs_off_t *size)
> diff --git a/lib/data.c b/lib/data.c
> index 76a6677..d8c6076 100644
> --- a/lib/data.c
> +++ b/lib/data.c
> @@ -158,19 +158,38 @@ int erofs_map_dev(struct erofs_sb_info *sbi, struct erofs_map_dev *map)
>   	return 0;
>   }
>   
> +int erofs_read_raw_data_mapped(struct erofs_map_blocks *map, char *buffer,

erofs_read_one_data?

> +				u64 offset, size_t len)
> +{
> +	struct erofs_map_dev mdev;
> +	int ret;
> +
> +	mdev = (struct erofs_map_dev) {
> +		.m_deviceid = map->m_deviceid,
> +		.m_pa = map->m_pa,
> +	};
> +	ret = erofs_map_dev(&sbi, &mdev);
> +	if (ret)
> +		return ret;
> +
> +	ret = dev_read(mdev.m_deviceid, buffer, mdev.m_pa + offset, len);
> +	if (ret < 0)
> +		return -EIO;
> +	return 0;
> +}
> +
>   static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
>   			       erofs_off_t size, erofs_off_t offset)
>   {
>   	struct erofs_map_blocks map = {
>   		.index = UINT_MAX,
>   	};
> -	struct erofs_map_dev mdev;
>   	int ret;
>   	erofs_off_t ptr = offset;
>   
>   	while (ptr < offset + size) {
>   		char *const estart = buffer + ptr - offset;
> -		erofs_off_t eend;
> +		erofs_off_t eend, moff = 0;
>   
>   		map.m_la = ptr;
>   		ret = erofs_map_blocks(inode, &map, 0);
> @@ -179,14 +198,6 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
>   
>   		DBG_BUGON(map.m_plen != map.m_llen);
>   
> -		mdev = (struct erofs_map_dev) {
> -			.m_deviceid = map.m_deviceid,
> -			.m_pa = map.m_pa,
> -		};
> -		ret = erofs_map_dev(&sbi, &mdev);
> -		if (ret)
> -			return ret;
> -
>   		/* trim extent */
>   		eend = min(offset + size, map.m_la + map.m_llen);
>   		DBG_BUGON(ptr < map.m_la);
> @@ -204,19 +215,74 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
>   		}
>   
>   		if (ptr > map.m_la) {
> -			mdev.m_pa += ptr - map.m_la;
> +			moff = ptr - map.m_la;
>   			map.m_la = ptr;
>   		}
>   
> -		ret = dev_read(mdev.m_deviceid, estart, mdev.m_pa,
> -			       eend - map.m_la);
> -		if (ret < 0)
> -			return -EIO;
> +		ret = erofs_read_raw_data_mapped(&map, estart, moff,
> +						 eend - map.m_la);
> +		if (ret)
> +			return ret;
>   		ptr = eend;
>   	}
>   	return 0;
>   }
>   
> +int z_erofs_read_data_mapped(struct erofs_inode *inode,

z_erofs_read_one_data?

Thanks,
Gao Xiang
