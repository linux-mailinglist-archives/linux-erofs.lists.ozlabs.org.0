Return-Path: <linux-erofs+bounces-137-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 450C8A75E9C
	for <lists+linux-erofs@lfdr.de>; Mon, 31 Mar 2025 07:45:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZR0TN44VHz2xtt;
	Mon, 31 Mar 2025 16:45:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1743399912;
	cv=none; b=fcFz8MCl6rdTtl0PWZMF/LPn57wMCNwonrY8ABSQB+DsLSAbe1WllO0T/PohJ2YPYfXMPHAj4DvWV0S9Co5i+KVTOfIwDKYV7j5ZG5DTSdmkWCMqFnSobISyaDW36+Mh4JkKFJKXQ8fxJb5buEp0rHIKKTPfKOmZPl2ii/iWOFVitxFzLi2JX+lqQL//Y2fOrlHvYXCmeLiUw2ToJMFqxUGRrnaa4hPpuwVZ1QtwJB+w23G3RpbCWd7lxQEi19oq4GDvOB5+VwVxLBpYcqmGq4mpS8YMQ3pj71U5yahPZBV4BOX/sETY2dd2F3s9Syv90Hk39Au05RGfxkbT5BsnCw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1743399912; c=relaxed/relaxed;
	bh=jYiHigV/9QVCUX/RST2nWsvZk5MllFtjrbF7BcIgPaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sr/Nnb5BKqZlZ01yG5AUr3aE1p8eZdR5v32J8mQomOUsyGOCBNlvzYuzGWFF2O3eAyp0dI9fhdBkrHsTC8amkn+jOnlIYCsBa53JyFlFqOqTrTfF37/RVpT7MNX1i1hmW111QW3AzJQis3yMk4N9veAL95TU3nFbAa4nzYzRIRpBm+MWTVQgV4mgiryio7Z1FQCbDqbWnalZLaQoheRD+WdPKoVMOPX+RVPy86C4tTGlyZ3FkY64T6TrgaziULpFhaH2Yjwhsyvb5XGSvZtzRLI6AyFlRHZ5NaENveNgCTPd9fr2EfUy2bY9km7JaaYqutAd0x4dmhBdygo7DeF18w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vwLf6nEQ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vwLf6nEQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZR0TL244nz2xCd
	for <linux-erofs@lists.ozlabs.org>; Mon, 31 Mar 2025 16:45:08 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1743399904; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=jYiHigV/9QVCUX/RST2nWsvZk5MllFtjrbF7BcIgPaE=;
	b=vwLf6nEQhmsc2iO0CM6RJEPVvsGcovZmlH4pgocaQivJ1QiRmWqc1oXuAR/L8BuOKPqerl87T7tZMnixKoA4vhOMXDD81TfpndFCx0RPxb0/SRADNiWxebgzqdlzOEIJbvBlnL327etGbypGjjx42ldeXxxe/ZehKYho3CKVHHA=
Received: from 30.221.130.198(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WTQwMDe_1743399902 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 31 Mar 2025 13:45:02 +0800
Message-ID: <0725c2ec-528c-42a8-9557-4713e7e35153@linux.alibaba.com>
Date: Mon, 31 Mar 2025 13:45:02 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] erofs: add 'offset' mount option for file-backed &
 bdev-based mounts
To: Sheng Yong <shengyong2021@gmail.com>, xiang@kernel.org, chao@kernel.org,
 zbestahu@gmail.com, jefflexu@linux.alibaba.com, dhavale@google.com,
 linux-erofs@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, wangshuai12@xiaomi.com,
 Sheng Yong <shengyong1@xiaomi.com>
References: <20250331022938.4090283-1-shengyong1@xiaomi.com>
 <20250331022938.4090283-2-shengyong1@xiaomi.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250331022938.4090283-2-shengyong1@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/3/31 10:29, Sheng Yong wrote:
> From: Sheng Yong <shengyong1@xiaomi.com>
> 
> When attempting to use an archive file, such as APEX on android,
> as a file-backed mount source, it fails because EROFS image within
> the archive file does not start at offset 0. As a result, a loop
> device is still needed to attach the image file at an appropriate
> offset first. Similarly, if an EROFS image within a block device
> does not start at offset 0, it cannot be mounted directly either.
> 
> To address this issue, this patch adds a new mount option `offset=x'
> to accept a start offset for both file-backed and bdev-based mounts.
> The offset should be aligned to PAGE_SIZE. EROFS will add this offset
> before performing read requests.
> 
> Signed-off-by: Sheng Yong <shengyong1@xiaomi.com>
> Signed-off-by: Wang Shuai <wangshuai12@xiaomi.com>
> ---
>   Documentation/filesystems/erofs.rst |  1 +
>   fs/erofs/data.c                     |  8 ++++++--
>   fs/erofs/fileio.c                   |  8 ++++++--
>   fs/erofs/internal.h                 |  2 ++
>   fs/erofs/super.c                    | 29 ++++++++++++++++++++++++++++-
>   fs/erofs/zdata.c                    | 13 +++++++++++--
>   6 files changed, 54 insertions(+), 7 deletions(-)
> ---
> Hi, all
> 
> Sorry for late :-(
> 
> v2: * add a new mount option `offset=X' for start offset, and offset
>        should be aligned to PAGE_SIZE
>      * add start offset for both file-backed and bdev-based mounts
> v1: https://lore.kernel.org/all/20250324022849.2715578-1-shengyong1@xiaomi.com/
> 
> diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
> index c293f8e37468..44dbfa6cffb1 100644
> --- a/Documentation/filesystems/erofs.rst
> +++ b/Documentation/filesystems/erofs.rst
> @@ -128,6 +128,7 @@ device=%s              Specify a path to an extra device to be used together.
>   fsid=%s                Specify a filesystem image ID for Fscache back-end.
>   domain_id=%s           Specify a domain ID in fscache mode so that different images
>                          with the same blobs under a given domain ID can share storage.
> +offset=%s              Specify image offset for file-backed or bdev-based mounts.
>   ===================    =========================================================
>   
>   Sysfs Entries
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 2409d2ab0c28..8dfdd0352c79 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -27,9 +27,12 @@ void erofs_put_metabuf(struct erofs_buf *buf)
>   
>   void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset, bool need_kmap)
>   {
> -	pgoff_t index = offset >> PAGE_SHIFT;
> +	pgoff_t index;
>   	struct folio *folio = NULL;
>   
> +	offset += buf->offs;
> +	index = offset >> PAGE_SHIFT;
> +
>   	if (buf->page) {
>   		folio = page_folio(buf->page);
>   		if (folio_file_page(folio, index) != buf->page)
> @@ -54,6 +57,7 @@ void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
>   	struct erofs_sb_info *sbi = EROFS_SB(sb);
>   
>   	buf->file = NULL;
> +	buf->offs = sbi->dif0.offs;
>   	if (erofs_is_fileio_mode(sbi)) {
>   		buf->file = sbi->dif0.file;	/* some fs like FUSE needs it */
>   		buf->mapping = buf->file->f_mapping;
> @@ -299,7 +303,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   		iomap->private = buf.base;
>   	} else {
>   		iomap->type = IOMAP_MAPPED;
> -		iomap->addr = mdev.m_pa;
> +		iomap->addr = EROFS_SB(sb)->dif0.offs + mdev.m_pa;
>   		if (flags & IOMAP_DAX)
>   			iomap->addr += mdev.m_dif->dax_part_off;
>   	}
> diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
> index 4fa0a0121288..d213bcb8c6c2 100644
> --- a/fs/erofs/fileio.c
> +++ b/fs/erofs/fileio.c
> @@ -47,15 +47,19 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
>   
>   static void erofs_fileio_rq_submit(struct erofs_fileio_rq *rq)
>   {
> +	struct erofs_sb_info *sbi;

	struct erofs_sb_info *sbi = EROFS_SB(rq->sb);

>   	struct iov_iter iter;
>   	int ret;
>   
>   	if (!rq)
>   		return;
> -	rq->iocb.ki_pos = rq->bio.bi_iter.bi_sector << SECTOR_SHIFT;
> +
> +	sbi = EROFS_SB(rq->sb);
> +	rq->iocb.ki_pos = sbi->dif0.offs +
> +				(rq->bio.bi_iter.bi_sector << SECTOR_SHIFT);
>   	rq->iocb.ki_ioprio = get_current_ioprio();
>   	rq->iocb.ki_complete = erofs_fileio_ki_complete;
> -	if (test_opt(&EROFS_SB(rq->sb)->opt, DIRECT_IO) &&
> +	if (test_opt(&sbi->opt, DIRECT_IO) &&
>   	    rq->iocb.ki_filp->f_mode & FMODE_CAN_ODIRECT)
>   		rq->iocb.ki_flags = IOCB_DIRECT;
>   	iov_iter_bvec(&iter, ITER_DEST, rq->bvecs, rq->bio.bi_vcnt,
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 4ac188d5d894..93fc111fa675 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -43,6 +43,7 @@ struct erofs_device_info {
>   	char *path;
>   	struct erofs_fscache *fscache;
>   	struct file *file;
> +	loff_t offs;

I think `off` is enough..

>   	struct dax_device *dax_dev;
>   	u64 dax_part_off;
>   
> @@ -199,6 +200,7 @@ enum {
>   struct erofs_buf {
>   	struct address_space *mapping;
>   	struct file *file;
> +	loff_t offs;

same here...

>   	struct page *page;>   	void *base;
>   };
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index cadec6b1b554..0569f62a76a8 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -356,7 +356,7 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
>   
>   enum {
>   	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
> -	Opt_device, Opt_fsid, Opt_domain_id, Opt_directio,
> +	Opt_device, Opt_fsid, Opt_domain_id, Opt_directio, Opt_offset,
>   	Opt_err
>   };
>   
> @@ -384,6 +384,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
>   	fsparam_string("fsid",		Opt_fsid),
>   	fsparam_string("domain_id",	Opt_domain_id),
>   	fsparam_flag_no("directio",	Opt_directio),
> +	fsparam_string("offset",	Opt_offset),
>   	{}
>   };
>   
> @@ -411,6 +412,22 @@ static bool erofs_fc_set_dax_mode(struct fs_context *fc, unsigned int mode)
>   #endif
>   }
>   
> +static bool erofs_fc_set_offset(struct fs_context *fc,
> +				struct fs_parameter *param)
> +{
> +	struct erofs_sb_info *sbi = fc->s_fs_info;
> +	loff_t offs;
> +
> +	if (kstrtoll(param->string, 0, &offs) < 0 ||
> +	    offs < 0 || offs & ~PAGE_MASK) {
> +		errorfc(fc, "Invalid offset %s", param->string);
> +		return false;
> +	}


Can we validate this offset in blocks rather than
PAGE_SIZE, I mean, we could validate it in fill_super().

> +	sbi->dif0.offs = offs;
> +
> +	return true;
> +}
> +
>   static int erofs_fc_parse_param(struct fs_context *fc,
>   				struct fs_parameter *param)
>   {
> @@ -507,6 +524,10 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>   		errorfc(fc, "%s option not supported", erofs_fs_parameters[opt].name);
>   #endif
>   		break;
> +	case Opt_offset:
> +		if (!erofs_fc_set_offset(fc, param))
> +			return -EINVAL;
> +		break;
>   	}
>   	return 0;
>   }
> @@ -697,6 +718,10 @@ static int erofs_fc_get_tree(struct fs_context *fc)
>   		file = filp_open(fc->source, O_RDONLY | O_LARGEFILE, 0);
>   		if (IS_ERR(file))
>   			return PTR_ERR(file);
> +		if (sbi->dif0.offs + PAGE_SIZE >= i_size_read(file_inode(file))) {
> +			fput(file);
> +			return invalf(fc, "Start offset too large");
> +		}

same here.

>   		sbi->dif0.file = file;
>   
>   		if (S_ISREG(file_inode(sbi->dif0.file)->i_mode) &&
> @@ -948,6 +973,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
>   	if (sbi->domain_id)
>   		seq_printf(seq, ",domain_id=%s", sbi->domain_id);
>   #endif
> +	if (sbi->dif0.offs)
> +		seq_printf(seq, ",offset=%lld", sbi->dif0.offs);
>   	return 0;
>   }
>   
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 0671184d9cf1..dc2aa3418094 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -1619,6 +1619,15 @@ static void z_erofs_endio(struct bio *bio)
>   		bio_put(bio);
>   }
>   
> +static void z_erofs_submit_bio(struct bio *bio)
> +{
> +	struct z_erofs_decompressqueue *q = bio->bi_private;
> +	struct erofs_sb_info *sbi = EROFS_SB(q->sb);
> +
> +	bio->bi_iter.bi_sector += sbi->dif0.offs >> SECTOR_SHIFT;

just update bi_sector inline?

Thanks,
Gao Xiang

