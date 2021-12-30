Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1864E48193E
	for <lists+linux-erofs@lfdr.de>; Thu, 30 Dec 2021 05:14:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JPZf26sWsz304x
	for <lists+linux-erofs@lfdr.de>; Thu, 30 Dec 2021 15:14:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=WN3p17Oj;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b;
 helo=mail-pj1-x102b.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=WN3p17Oj; dkim-atps=neutral
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JPZdx66Wlz2xrs
 for <linux-erofs@lists.ozlabs.org>; Thu, 30 Dec 2021 15:13:55 +1100 (AEDT)
Received: by mail-pj1-x102b.google.com with SMTP id
 o63-20020a17090a0a4500b001b1c2db8145so26787843pjo.5
 for <linux-erofs@lists.ozlabs.org>; Wed, 29 Dec 2021 20:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YiqhfVRIwQ4gWbIHN8vMHwMrf7y2KmZNSv9vrM9T++g=;
 b=WN3p17OjbM2NfyZU9v4AjWOyMn1FMzCuMQaMgzQ6P1Igwqg3i7uQJxtxs5e7fjutKY
 wN9avueCZXWmuuiA1tZdfXq4D2dkVdBHhbOgr6rGpCrdVRFc81obMdjS0IN7t646Cpag
 OSZOu+yxMSMyS08VWsVpGtzRlSMY/zpJy86l4y/JDOIAYLE8J7ty6e7sTGoc81SnxO5u
 8aH9NZlklTaEYgZY1zWEBhXu0NL9rYezJmTZjY7ObVkydzu3DW9/hG6ih9FRvHNCNO/+
 IooJZigWq0kEVCb3AHymQNb0FJtQ4imBZ/Bt99vK7Q7w/jFG9MtMGb+UqpwK53felOVY
 74GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YiqhfVRIwQ4gWbIHN8vMHwMrf7y2KmZNSv9vrM9T++g=;
 b=aSH1Dwtufay1OxwYalOhF3DD7qqrWzvL71lLACv/2Ju9HLsllxJNo97iAym3Pxq4t3
 ZkL4T+sxOAkTNrRu4hq7yq7fUak5HjKiYMRWgOKo/lloYhfjzU7LGDuXms9Z/hznlrJt
 ygo3ojzk7o8eWucwCPUwDNZnnpDgcb/DCcfVCl7DWJcYGfXNvOSpnOdr49PslnEeEHeJ
 SODkTVRgL3S7R7vrNQ3/oAsP4Ddby9cqTzLprZjWMQrsDwEOIlBLuFG1BbWYn0eY1V2/
 c4iHJ/9aMhqX45YdRcCKJCUdVYmrdyhwzfwUWhxfvpKwFvvgfyoyLwoVofDhUBvxi2Pc
 fOtw==
X-Gm-Message-State: AOAM531ZUberrL5RN02s+u0TMrH2R7ZD2YNn0+IcKx3vMY/5vMcXVsS+
 dmp145dZ1KUvqPFe237+NS0=
X-Google-Smtp-Source: ABdhPJx4K3Hx7QB9muUJ0ZknYj5jRJv7wUGwX+gWy6bsRmsxu/+hEfH0wOhBmHJw4oy7F0ETGXEPbg==
X-Received: by 2002:a17:902:7442:b0:149:6a62:f7b3 with SMTP id
 e2-20020a170902744200b001496a62f7b3mr22631732plt.88.1640837633157; 
 Wed, 29 Dec 2021 20:13:53 -0800 (PST)
Received: from localhost ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id g5sm27062425pfj.143.2021.12.29.20.13.50
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 29 Dec 2021 20:13:53 -0800 (PST)
Date: Thu, 30 Dec 2021 12:11:09 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 3/5] erofs: use meta buffers for super operations
Message-ID: <20211230121109.00000328.zbestahu@gmail.com>
In-Reply-To: <20211229041405.45921-4-hsiangkao@linux.alibaba.com>
References: <20211229041405.45921-1-hsiangkao@linux.alibaba.com>
 <20211229041405.45921-4-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: geshifei@coolpad.com, LKML <linux-kernel@vger.kernel.org>,
 huyue@coolpad.com, zhangwen@coolpad.com, Liu Bo <bo.liu@linux.alibaba.com>,
 linux-erofs@lists.ozlabs.org, shaojunjun@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, 29 Dec 2021 12:14:03 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Get rid of old erofs_get_meta_page() within super operations by
> using on-stack meta buffers in order to prepare subpage and folio
> features.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/super.c | 105 ++++++++++++-----------------------------------
>  1 file changed, 26 insertions(+), 79 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 0724ad5fd6cf..38305fa2969b 100644
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
> @@ -124,80 +125,48 @@ static bool check_layout_compatibility(struct super_block *sb,
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
> -		}
> +		ptr = erofs_read_metabuf(buf, sb, erofs_blknr(*offset),
> +					 EROFS_KMAP);
> +		if (IS_ERR(ptr))
> +			return ptr;
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
> @@ -205,21 +174,16 @@ static int erofs_load_compr_cfgs(struct super_block *sb,
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
> -		if (IS_ERR(data)) {
> -			ret = PTR_ERR(data);
> -			goto err;
> -		}
> +		data = erofs_read_metadata(sb, &buf, &offset, &size);
> +		if (IS_ERR(data))
> +			return PTR_ERR(data);
>  
>  		switch (alg) {
>  		case Z_EROFS_COMPRESSION_LZ4:
> @@ -234,13 +198,9 @@ static int erofs_load_compr_cfgs(struct super_block *sb,
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
> @@ -261,7 +221,7 @@ static int erofs_init_devices(struct super_block *sb,
>  	struct erofs_sb_info *sbi = EROFS_SB(sb);
>  	unsigned int ondisk_extradevs;
>  	erofs_off_t pos;
> -	struct page *page = NULL;
> +	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>  	struct erofs_device_info *dif;
>  	struct erofs_deviceslot *dis;
>  	void *ptr;
> @@ -285,22 +245,13 @@ static int erofs_init_devices(struct super_block *sb,
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
> +			up_read(&sbi->devs->rwsem);
> +			return PTR_ERR(ptr);
>  		}
>  		dis = ptr + erofs_blkoff(pos);
>  
> @@ -320,11 +271,7 @@ static int erofs_init_devices(struct super_block *sb,
>  	}
>  err_out:
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

Reviewed-by: Yue Hu <huyue2@yulong.com>
