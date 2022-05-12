Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D73C052451B
	for <lists+linux-erofs@lfdr.de>; Thu, 12 May 2022 07:41:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KzLJ14lC7z3bdY
	for <lists+linux-erofs@lfdr.de>; Thu, 12 May 2022 15:41:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.9;
 helo=out199-9.us.a.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com;
 receiver=<UNKNOWN>)
Received: from out199-9.us.a.mail.aliyun.com (out199-9.us.a.mail.aliyun.com
 [47.90.199.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KzLHr6pCPz3bZt
 for <linux-erofs@lists.ozlabs.org>; Thu, 12 May 2022 15:41:41 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R701e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=alimailimapcm10staff010182156082;
 MF=hsiangkao@linux.alibaba.com; NM=1; PH=DS; RN=5; SR=0;
 TI=SMTPD_---0VCzPcW9_1652334062; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0VCzPcW9_1652334062) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 12 May 2022 13:41:04 +0800
Date: Thu, 12 May 2022 13:41:02 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH] erofs: scan devices from device table
Message-ID: <Ynyd7iTbE+NhnTmh@B-P7TQMD6M-0146.local>
References: <20220510093511.77473-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220510093511.77473-1-jefflexu@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, May 10, 2022 at 05:35:11PM +0800, Jeffle Xu wrote:
> When "-o device" mount option is not specified, scan the device table
> and instantiate the devices if there's any in the device table. In this
> case, the tag field of each device slot uniquely specifies a device.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/erofs/erofs_fs.h |   9 ++--
>  fs/erofs/super.c    | 102 ++++++++++++++++++++++++++++++--------------
>  2 files changed, 72 insertions(+), 39 deletions(-)
> 
> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> index 1238ca104f09..1adde3a813b4 100644
> --- a/fs/erofs/erofs_fs.h
> +++ b/fs/erofs/erofs_fs.h
> @@ -37,12 +37,9 @@
>  #define EROFS_SB_EXTSLOT_SIZE	16
>  
>  struct erofs_deviceslot {
> -	union {
> -		u8 uuid[16];		/* used for device manager later */
> -		u8 userdata[64];	/* digest(sha256), etc. */
> -	} u;
> -	__le32 blocks;			/* total fs blocks of this device */
> -	__le32 mapped_blkaddr;		/* map starting at mapped_blkaddr */
> +	u8 tag[64];		/* digest(sha256), etc. */
> +	__le32 blocks;		/* total fs blocks of this device */
> +	__le32 mapped_blkaddr;	/* map starting at mapped_blkaddr */
>  	u8 reserved[56];
>  };
>  #define EROFS_DEVT_SLOT_SIZE	sizeof(struct erofs_deviceslot)
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 4a623630e1c4..3f19c2031e69 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -219,7 +219,52 @@ static int erofs_load_compr_cfgs(struct super_block *sb,
>  }
>  #endif
>  
> -static int erofs_init_devices(struct super_block *sb,
> +static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
> +			     struct erofs_device_info *dif, erofs_off_t *pos)
> +{
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
> +	struct erofs_deviceslot *dis;
> +	struct block_device *bdev;
> +	void *ptr;
> +	int ret;
> +
> +	ptr = erofs_read_metabuf(buf, sb, erofs_blknr(*pos), EROFS_KMAP);
> +	if (IS_ERR(ptr))
> +		return PTR_ERR(ptr);
> +	dis = ptr + erofs_blkoff(*pos);
> +
> +	if (!dif->path) {
> +		if (!dis->tag[0]) {
> +			erofs_err(sb, "Empty digest data (pos %llu)", *pos);

			erofs_err(sb, "empty tag @ pos %llu", *pos);
?

Otherwise it looks good to me,
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
