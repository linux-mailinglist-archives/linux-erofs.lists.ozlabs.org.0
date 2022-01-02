Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB36482A8F
	for <lists+linux-erofs@lfdr.de>; Sun,  2 Jan 2022 09:16:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JRWtg21Kbz2ynk
	for <lists+linux-erofs@lfdr.de>; Sun,  2 Jan 2022 19:16:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=47.88.44.36;
 helo=out4436.biz.mail.alibaba.com; envelope-from=bo.liu@linux.alibaba.com;
 receiver=<UNKNOWN>)
Received: from out4436.biz.mail.alibaba.com (out4436.biz.mail.alibaba.com
 [47.88.44.36])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JRWtc15Qyz2xMF
 for <linux-erofs@lists.ozlabs.org>; Sun,  2 Jan 2022 19:16:39 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=bo.liu@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0V0YVqdJ_1641111349; 
Received: from rsjd01523.et2sqa(mailfrom:bo.liu@linux.alibaba.com
 fp:SMTPD_---0V0YVqdJ_1641111349) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 02 Jan 2022 16:15:53 +0800
Date: Sun, 2 Jan 2022 16:15:49 +0800
From: Liu Bo <bo.liu@linux.alibaba.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v3 3/5] erofs: use meta buffers for super operations
Message-ID: <20220102081548.GA19871@rsjd01523.et2sqa>
References: <20220102040017.51352-4-hsiangkao@linux.alibaba.com>
 <20220102081317.109797-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220102081317.109797-1-hsiangkao@linux.alibaba.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
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
Reply-To: bo.liu@linux.alibaba.com
Cc: Yue Hu <huyue2@yulong.com>, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, Jan 02, 2022 at 04:13:17PM +0800, Gao Xiang wrote:
> Get rid of old erofs_get_meta_page() within super operations by
> using on-stack meta buffers in order to prepare subpage and folio
> features.
>

Reviewed-by: Liu Bo <bo.liu@linux.alibaba.com>


> Reviewed-by: Yue Hu <huyue2@yulong.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> changes since v2:
>  - add a missing kfree(buffer);
>  - forget to put_metabuf in erofs_load_compr_cfgs;
>  - fotget to put_metabuf in erofs_init_devices.
> 
>  fs/erofs/super.c | 104 ++++++++++++-----------------------------------
>  1 file changed, 27 insertions(+), 77 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 0724ad5fd6cf..5c137647fa8a 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -2,6 +2,7 @@
>  /*
>   * Copyright (C) 2017-2018 HUAWEI, Inc.
>   *             https://www.huawei.com/
> + * Copyright (C) 2021, Alibaba Cloud
>   */
>  #include <linux/module.h>
>  #include <linux/buffer_head.h>
> @@ -124,80 +125,50 @@ static bool check_layout_compatibility(struct super_block *sb,
>  
>  #ifdef CONFIG_EROFS_FS_ZIP
>  /* read variable-sized metadata, offset will be aligned by 4-byte */
> -static void *erofs_read_metadata(struct super_block *sb, struct page **pagep,
> +static void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
>  				 erofs_off_t *offset, int *lengthp)
>  {
> -	struct page *page = *pagep;
>  	u8 *buffer, *ptr;
>  	int len, i, cnt;
> -	erofs_blk_t blk;
>  
>  	*offset = round_up(*offset, 4);
> -	blk = erofs_blknr(*offset);
> +	ptr = erofs_read_metabuf(buf, sb, erofs_blknr(*offset), EROFS_KMAP);
> +	if (IS_ERR(ptr))
> +		return ptr;
>  
> -	if (!page || page->index != blk) {
> -		if (page) {
> -			unlock_page(page);
> -			put_page(page);
> -		}
> -		page = erofs_get_meta_page(sb, blk);
> -		if (IS_ERR(page))
> -			goto err_nullpage;
> -	}
> -
> -	ptr = kmap(page);
>  	len = le16_to_cpu(*(__le16 *)&ptr[erofs_blkoff(*offset)]);
>  	if (!len)
>  		len = U16_MAX + 1;
>  	buffer = kmalloc(len, GFP_KERNEL);
> -	if (!buffer) {
> -		buffer = ERR_PTR(-ENOMEM);
> -		goto out;
> -	}
> +	if (!buffer)
> +		return ERR_PTR(-ENOMEM);
>  	*offset += sizeof(__le16);
>  	*lengthp = len;
>  
>  	for (i = 0; i < len; i += cnt) {
>  		cnt = min(EROFS_BLKSIZ - (int)erofs_blkoff(*offset), len - i);
> -		blk = erofs_blknr(*offset);
> -
> -		if (!page || page->index != blk) {
> -			if (page) {
> -				kunmap(page);
> -				unlock_page(page);
> -				put_page(page);
> -			}
> -			page = erofs_get_meta_page(sb, blk);
> -			if (IS_ERR(page)) {
> -				kfree(buffer);
> -				goto err_nullpage;
> -			}
> -			ptr = kmap(page);
> +		ptr = erofs_read_metabuf(buf, sb, erofs_blknr(*offset),
> +					 EROFS_KMAP);
> +		if (IS_ERR(ptr)) {
> +			kfree(buffer);
> +			return ptr;
>  		}
>  		memcpy(buffer + i, ptr + erofs_blkoff(*offset), cnt);
>  		*offset += cnt;
>  	}
> -out:
> -	kunmap(page);
> -	*pagep = page;
>  	return buffer;
> -err_nullpage:
> -	*pagep = NULL;
> -	return page;
>  }
>  
>  static int erofs_load_compr_cfgs(struct super_block *sb,
>  				 struct erofs_super_block *dsb)
>  {
> -	struct erofs_sb_info *sbi;
> -	struct page *page;
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
> +	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>  	unsigned int algs, alg;
>  	erofs_off_t offset;
> -	int size, ret;
> +	int size, ret = 0;
>  
> -	sbi = EROFS_SB(sb);
>  	sbi->available_compr_algs = le16_to_cpu(dsb->u1.available_compr_algs);
> -
>  	if (sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS) {
>  		erofs_err(sb, "try to load compressed fs with unsupported algorithms %x",
>  			  sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS);
> @@ -205,20 +176,17 @@ static int erofs_load_compr_cfgs(struct super_block *sb,
>  	}
>  
>  	offset = EROFS_SUPER_OFFSET + sbi->sb_size;
> -	page = NULL;
>  	alg = 0;
> -	ret = 0;
> -
>  	for (algs = sbi->available_compr_algs; algs; algs >>= 1, ++alg) {
>  		void *data;
>  
>  		if (!(algs & 1))
>  			continue;
>  
> -		data = erofs_read_metadata(sb, &page, &offset, &size);
> +		data = erofs_read_metadata(sb, &buf, &offset, &size);
>  		if (IS_ERR(data)) {
>  			ret = PTR_ERR(data);
> -			goto err;
> +			break;
>  		}
>  
>  		switch (alg) {
> @@ -234,13 +202,9 @@ static int erofs_load_compr_cfgs(struct super_block *sb,
>  		}
>  		kfree(data);
>  		if (ret)
> -			goto err;
> -	}
> -err:
> -	if (page) {
> -		unlock_page(page);
> -		put_page(page);
> +			break;
>  	}
> +	erofs_put_metabuf(&buf);
>  	return ret;
>  }
>  #else
> @@ -261,7 +225,7 @@ static int erofs_init_devices(struct super_block *sb,
>  	struct erofs_sb_info *sbi = EROFS_SB(sb);
>  	unsigned int ondisk_extradevs;
>  	erofs_off_t pos;
> -	struct page *page = NULL;
> +	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>  	struct erofs_device_info *dif;
>  	struct erofs_deviceslot *dis;
>  	void *ptr;
> @@ -285,22 +249,13 @@ static int erofs_init_devices(struct super_block *sb,
>  	pos = le16_to_cpu(dsb->devt_slotoff) * EROFS_DEVT_SLOT_SIZE;
>  	down_read(&sbi->devs->rwsem);
>  	idr_for_each_entry(&sbi->devs->tree, dif, id) {
> -		erofs_blk_t blk = erofs_blknr(pos);
>  		struct block_device *bdev;
>  
> -		if (!page || page->index != blk) {
> -			if (page) {
> -				kunmap(page);
> -				unlock_page(page);
> -				put_page(page);
> -			}
> -
> -			page = erofs_get_meta_page(sb, blk);
> -			if (IS_ERR(page)) {
> -				up_read(&sbi->devs->rwsem);
> -				return PTR_ERR(page);
> -			}
> -			ptr = kmap(page);
> +		ptr = erofs_read_metabuf(&buf, sb, erofs_blknr(pos),
> +					 EROFS_KMAP);
> +		if (IS_ERR(ptr)) {
> +			err = PTR_ERR(ptr);
> +			break;
>  		}
>  		dis = ptr + erofs_blkoff(pos);
>  
> @@ -309,7 +264,7 @@ static int erofs_init_devices(struct super_block *sb,
>  					  sb->s_type);
>  		if (IS_ERR(bdev)) {
>  			err = PTR_ERR(bdev);
> -			goto err_out;
> +			break;
>  		}
>  		dif->bdev = bdev;
>  		dif->dax_dev = fs_dax_get_by_bdev(bdev);
> @@ -318,13 +273,8 @@ static int erofs_init_devices(struct super_block *sb,
>  		sbi->total_blocks += dif->blocks;
>  		pos += EROFS_DEVT_SLOT_SIZE;
>  	}
> -err_out:
>  	up_read(&sbi->devs->rwsem);
> -	if (page) {
> -		kunmap(page);
> -		unlock_page(page);
> -		put_page(page);
> -	}
> +	erofs_put_metabuf(&buf);
>  	return err;
>  }
>  
> -- 
> 2.24.4
