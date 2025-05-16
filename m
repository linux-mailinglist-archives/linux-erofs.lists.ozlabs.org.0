Return-Path: <linux-erofs+bounces-332-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 32312AB986B
	for <lists+linux-erofs@lfdr.de>; Fri, 16 May 2025 11:15:22 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZzLyZ1RSLz2yFJ;
	Fri, 16 May 2025 19:15:18 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747386918;
	cv=none; b=oYu3u3/Q4TT46mRZPIhvclKb6HFK+hXAUFFGnlTNfxlOdUt7bPS920dI6YNJAVIP+cCYUWUsqE9ExbRkeeNGMa3GSMrY50u9GBT+r6bdqCJaZ08TBN3ONmCcuYYkzmrwMJpExJjJ6B43nUOxby2Egi/wSp0KLCQLYgUR7n0rVXocaXdlCnfc5ru1/93i1cF5cpY08dZT172ao1Ebfkg7KNQQueP7VWssEA0AXUL8voF+RUgrrhqWTFCJ+TlZbP5xgQryKkSgyCOiR7NEE8jeHJQTOdLaPDbkWAVv2Auql0HaJGm3o2+O0f6Ud3PzfmEHQNd0SFocENfI5wkYZ4Zj8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747386918; c=relaxed/relaxed;
	bh=MSlR1/0liu2wj9sEFyfqDA7bnCsQRY0Sg2XiNIBGBhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=avlFV2tcIGjr0mb6jcldqcpHhuICLj5MnHehxpskXyZEvugphM8JB1GloRP8KqwnJ0SCNFEQGj5kqDf6oCM59im7+psG3Zfe3njFnyALCy7+7QtIAajpx3cx/i/LC4L+09vQBkz/5OdROYYiNmLf+/Rr7wr8j8XUmSMU96XPwIta7VEBuw6W/s2ZcpDlfg/yxvwsKZX56V8pLrfyGKIB6ZePmzQkwmQ4m+dhRUz+wMH8Ont7O3ZafeqitLSs/ymM9DmmRU1mjzIkLmw6fmX96D8GRI63DErYA2xNNWTbdouykbGEuJBMJUdXLNhM5dJz0DtEZzuyvHJEYAo1QR8Q5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fiSIO7jS; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fiSIO7jS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZzLyW6lbnz2xfB
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 May 2025 19:15:14 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747386910; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=MSlR1/0liu2wj9sEFyfqDA7bnCsQRY0Sg2XiNIBGBhc=;
	b=fiSIO7jSHR+XewJBpHvKvnm95cKTf/5BAWA7Hu/1XKoKsCNsbCdDXRmHCWGgsTKzlR3u16sXTk/Djatbx5PjN6GX838iDy1TS+1laKv17iDRQld6/3r7nSuakgd5MvphMK4HQtIFkRqwwwq0kCKkNT6m0d69MRiTc8Qukc3Gxv4=
Received: from 30.221.131.45(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WavMJZO_1747386907 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 16 May 2025 17:15:08 +0800
Message-ID: <b91b9f2c-3a07-4726-95d9-75d36bb59871@linux.alibaba.com>
Date: Fri, 16 May 2025 17:15:07 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] erofs: add 'fsoffset' mount option for file-backed &
 bdev-based mounts
To: Sheng Yong <shengyong2021@gmail.com>, xiang@kernel.org, chao@kernel.org,
 zbestahu@gmail.com, jefflexu@linux.alibaba.com, dhavale@google.com,
 lihongbo22@huawei.com
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Sheng Yong <shengyong1@xiaomi.com>, Wang Shuai <wangshuai12@xiaomi.com>
References: <20250516090055.3343777-1-shengyong1@xiaomi.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250516090055.3343777-1-shengyong1@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Yong,

On 2025/5/16 17:00, Sheng Yong wrote:

...

> diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
> index c293f8e37468..b24cb0d5d4d6 100644
> --- a/Documentation/filesystems/erofs.rst
> +++ b/Documentation/filesystems/erofs.rst
> @@ -128,6 +128,7 @@ device=%s              Specify a path to an extra device to be used together.
>   fsid=%s                Specify a filesystem image ID for Fscache back-end.
>   domain_id=%s           Specify a domain ID in fscache mode so that different images
>                          with the same blobs under a given domain ID can share storage.
> +fsoffset=%lu           Specify image offset for file-backed or bdev-based mounts.

Maybe document it as:
fsoffset=%lu              Specify filesystem offset for the primary device.

Since I'm not sure if we need later
fsoffset=%lu,[%lu,...]    Specify filesystem offset for all devices.

>   ===================    =========================================================
>   
>   Sysfs Entries
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 2409d2ab0c28..599a44d5d782 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -27,9 +27,12 @@ void erofs_put_metabuf(struct erofs_buf *buf)
>   
>   void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset, bool need_kmap)
>   {
> -	pgoff_t index = offset >> PAGE_SHIFT;
> +	pgoff_t index;

How about just
	pgoff_t index = (offset + buf->off) >> PAGE_SHIFT;

since it's not complex to break it into two statements..

>   	struct folio *folio = NULL;
>   
> +	offset += buf->off;
> +	index = offset >> PAGE_SHIFT;
> +
>   	if (buf->page) {
>   		folio = page_folio(buf->page);
>   		if (folio_file_page(folio, index) != buf->page)
> @@ -54,6 +57,7 @@ void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
>   	struct erofs_sb_info *sbi = EROFS_SB(sb);
>   
>   	buf->file = NULL;
> +	buf->off = sbi->dif0.off;
>   	if (erofs_is_fileio_mode(sbi)) {
>   		buf->file = sbi->dif0.file;	/* some fs like FUSE needs it */
>   		buf->mapping = buf->file->f_mapping;
> @@ -299,7 +303,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   		iomap->private = buf.base;
>   	} else {
>   		iomap->type = IOMAP_MAPPED;
> -		iomap->addr = mdev.m_pa;
> +		iomap->addr = mdev.m_dif->off + mdev.m_pa;

I mean, could we update erofs_init_device() and then
`mdev.pa` is already an number added by `mdev.m_dif->off`...

Is it possible? since mdev.pa is already a device-based
offset.

>   		if (flags & IOMAP_DAX)
>   			iomap->addr += mdev.m_dif->dax_part_off;
>   	}
> diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
> index 60c7cc4c105c..a2c7001ff789 100644
> --- a/fs/erofs/fileio.c
> +++ b/fs/erofs/fileio.c
> @@ -147,7 +147,8 @@ static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
>   				if (err)
>   					break;
>   				io->rq = erofs_fileio_rq_alloc(&io->dev);
> -				io->rq->bio.bi_iter.bi_sector = io->dev.m_pa >> 9;
> +				io->rq->bio.bi_iter.bi_sector =
> +					(io->dev.m_dif->off + io->dev.m_pa) >> 9;

So we don't need here.

>   				attached = 0;
>   			}
>   			if (!bio_add_folio(&io->rq->bio, folio, len, cur))
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 4ac188d5d894..cd8c738f5eb8 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -43,6 +43,7 @@ struct erofs_device_info {
>   	char *path;
>   	struct erofs_fscache *fscache;
>   	struct file *file;
> +	u64 off;
>   	struct dax_device *dax_dev;
>   	u64 dax_part_off;

Maybe `u64 off, dax_part_off;` here?

Also I'm still not quite sure `off` is unambiguous...
Maybe `dataoff`? not quite sure.

>   
> @@ -199,6 +200,7 @@ enum {
>   struct erofs_buf {
>   	struct address_space *mapping;
>   	struct file *file;
> +	u64 off;
>   	struct page *page;
>   	void *base;
>   };
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index da6ee7c39290..512877d7d855 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -356,7 +356,7 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
>   
>   enum {
>   	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
> -	Opt_device, Opt_fsid, Opt_domain_id, Opt_directio,
> +	Opt_device, Opt_fsid, Opt_domain_id, Opt_directio, Opt_fsoffset,
>   };
>   
>   static const struct constant_table erofs_param_cache_strategy[] = {
> @@ -383,6 +383,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
>   	fsparam_string("fsid",		Opt_fsid),
>   	fsparam_string("domain_id",	Opt_domain_id),
>   	fsparam_flag_no("directio",	Opt_directio),
> +	fsparam_u64("fsoffset",		Opt_fsoffset),
>   	{}
>   };
>   
> @@ -506,6 +507,9 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>   		errorfc(fc, "%s option not supported", erofs_fs_parameters[opt].name);
>   #endif
>   		break;
> +	case Opt_fsoffset:
> +		sbi->dif0.off = result.uint_64;
> +		break;
>   	}
>   	return 0;
>   }
> @@ -599,6 +603,10 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>   				&sbi->dif0.dax_part_off, NULL, NULL);
>   	}
>   
> +	if (sbi->dif0.off & ((1 << sbi->blkszbits) - 1))
> +		return invalfc(fc, "fsoffset %lld not aligned to block size",

is `sbi->blkszbits` valid here? I think it should be moved down
to "erofs_read_superblock(sb)".

			"fsoffset %llu is not aligned to block size %u",
			sbi->dif0.off, (1 << sbi->blkszbits)

> +			       sbi->dif0.off);

If fscache doesn't work, we might need to fail out here too.



> +
>   	err = erofs_read_superblock(sb);
>   	if (err)
>   		return err;
> @@ -947,6 +955,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
>   	if (sbi->domain_id)
>   		seq_printf(seq, ",domain_id=%s", sbi->domain_id);
>   #endif
> +	if (sbi->dif0.off)
> +		seq_printf(seq, ",fsoffset=%lld", sbi->dif0.off);
>   	return 0;
>   }
>   
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index b8e6b76c23d5..4f910d7ffb2f 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -1707,7 +1707,8 @@ static void z_erofs_submit_queue(struct z_erofs_frontend *f,
>   					bio = bio_alloc(mdev.m_bdev, BIO_MAX_VECS,
>   							REQ_OP_READ, GFP_NOIO);
>   				bio->bi_end_io = z_erofs_endio;
> -				bio->bi_iter.bi_sector = cur >> 9;
> +				bio->bi_iter.bi_sector =
> +						(mdev.m_dif->off + cur) >> 9;

So we don't need here as well.

Thanks,
Gao Xiang

