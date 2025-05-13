Return-Path: <linux-erofs+bounces-312-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFDEAB5697
	for <lists+linux-erofs@lfdr.de>; Tue, 13 May 2025 15:56:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZxdLT0Txjz2yb9;
	Tue, 13 May 2025 23:56:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.255
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747144592;
	cv=none; b=o2w03UEKCvPRSS9f+Cu9bWlUshQuK2ZYferXZnY93Y2+JgpfI5R/dJqSEm1QOC8GC0Xv7H7HD3bIhAzHbEhsrHcrUBRnNNig512TLW1d/TYsbgSYs6oeAstUTY6pwTUpqhBlOM6jzTILTG75+GEKBT4z0hRpZrkk/iOf9uRlSDnghKoVlU/iKkNohXXkiKbZUQRyBRWYDQi8HQoc/ZVT22z8kAetMxNbikyNH0BxuXaI8KpelMeo1uzp5SS5NUaqbtEojaN3n+HL21ceFJhyKbiQGl2Ql90MFhplh2MzJTaTmzUjLV8eAhf4vME2bRt/g8LqMu9CZRFc5Wazjy3hUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747144592; c=relaxed/relaxed;
	bh=BhaqCxUKikaEOQx5Hs9ESNQ+yKeeiutRd5Dj96ebX2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=K0eIivgaJibJx7VZdqDASSYjVVQuv9YItXNFujc1JTL/p1fhTMKKctlHTqPhoMfC0a2+nzVxeEV3AqmLrK6x+2SH7S3MRCmQBDRCGmCoxMs7p0dFANdmbFJTv/dPx/2JcooqmiOCIQowUxdTkoyAFnlfJV/nqJsMXryyyOmy1tuVB+ImORN8gXMdGZV6f9Zi39DBHUgCrLwIvEMf63JAQ+AtiVM9scKrShShqaXkHc1tHB3LWbNSkK3hw6MawHfMrMdoqTGIjlxG1446cvwr6A5qDJdscn02ofQv3YB0DxUHLykt880e46xdKK5AX5wnHdo2JBbbz+ofgZ9ND8o5Zg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.255; helo=szxga08-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.255; helo=szxga08-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZxdLQ6L9Jz2xVq
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 May 2025 23:56:29 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZxdJg08F0z1DFkH;
	Tue, 13 May 2025 21:54:59 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 05CAA1800B2;
	Tue, 13 May 2025 21:56:24 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 13 May 2025 21:56:23 +0800
Message-ID: <a20ac409-f8a5-48d6-9e8b-3c40f829bea9@huawei.com>
Date: Tue, 13 May 2025 21:56:22 +0800
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
Subject: Re: [PATCH v5 1/2] erofs: add 'fsoffset' mount option for file-backed
 & bdev-based mounts
Content-Language: en-US
To: Sheng Yong <shengyong2021@gmail.com>, <xiang@kernel.org>,
	<chao@kernel.org>, <zbestahu@gmail.com>, <jefflexu@linux.alibaba.com>,
	<dhavale@google.com>
CC: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Sheng Yong
	<shengyong1@xiaomi.com>, Wang Shuai <wangshuai12@xiaomi.com>
References: <20250513113418.249798-1-shengyong1@xiaomi.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20250513113418.249798-1-shengyong1@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/5/13 19:34, Sheng Yong wrote:
> From: Sheng Yong <shengyong1@xiaomi.com>
> 
> When attempting to use an archive file, such as APEX on android,
> as a file-backed mount source, it fails because EROFS image within
> the archive file does not start at offset 0. As a result, a loop
> device is still needed to attach the image file at an appropriate
> offset first. Similarly, if an EROFS image within a block device
> does not start at offset 0, it cannot be mounted directly either.
> 
> To address this issue, this patch adds a new mount option `fsoffset=x'
> to accept a start offset for both file-backed and bdev-based mounts.
> The offset should be aligned to block size. EROFS will add this offset
> before performing read requests.
> 
> Signed-off-by: Sheng Yong <shengyong1@xiaomi.com>
> Signed-off-by: Wang Shuai <wangshuai12@xiaomi.com>
> ---
>   Documentation/filesystems/erofs.rst |  1 +
>   fs/erofs/data.c                     |  8 ++++++--
>   fs/erofs/fileio.c                   |  3 ++-
>   fs/erofs/internal.h                 |  2 ++
>   fs/erofs/super.c                    | 12 +++++++++++-
>   fs/erofs/zdata.c                    |  3 ++-
>   6 files changed, 24 insertions(+), 5 deletions(-)
> ---
> v5: * fix fsoffset on multiple device by adding off when creating io
>        request, erofs_map_device selects the target device an only
>        primary device has an off
>      * remove unnecessary checks of fsoffset value
>      * try to combine off and dax_part_off, but it is not easy to do
>        that, because dax_part_off is not needed when reading metadata
> 
> v4: * change mount option `offset=x' to `fsoffset=x'
> https://lore.kernel.org/linux-erofs/c5110e03-90ea-40be-b05f-bc920332a1e1@linux.alibaba.com
> 
> v3: * rename `offs' to `off'
>      * parse offset using fsparam_u64 and validate it in fill_super
>      * update bi_sector inline
>      https://lore.kernel.org/linux-erofs/98585dd8-d0b6-4000-b46d-a08c64eae44d@linux.alibaba.com
> 
> v2: * add a new mount option `offset=X' for start offset, and offset
>         should be aligned to PAGE_SIZE
>      * add start offset for both file-backed and bdev-based mounts
>      https://lore.kernel.org/linux-erofs/0725c2ec-528c-42a8-9557-4713e7e35153@linux.alibaba.com
> 
> v1: https://lore.kernel.org/all/20250324022849.2715578-1-shengyong1@xiaomi.com/
> 
> diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
> index c293f8e37468..0fa4c7826203 100644
> --- a/Documentation/filesystems/erofs.rst
> +++ b/Documentation/filesystems/erofs.rst
> @@ -128,6 +128,7 @@ device=%s              Specify a path to an extra device to be used together.
>   fsid=%s                Specify a filesystem image ID for Fscache back-end.
>   domain_id=%s           Specify a domain ID in fscache mode so that different images
>                          with the same blobs under a given domain ID can share storage.
> +fsoffset=%s            Specify image offset for file-backed or bdev-based mounts.
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
>   				attached = 0;
>   			}
>   			if (!bio_add_folio(&io->rq->bio, folio, len, cur))
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 4ac188d5d894..10656bd986bd 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -43,6 +43,7 @@ struct erofs_device_info {
>   	char *path;
>   	struct erofs_fscache *fscache;
>   	struct file *file;
> +	loff_t off;

Use u64 is better?

>   	struct dax_device *dax_dev;
>   	u64 dax_part_off;
>   
> @@ -199,6 +200,7 @@ enum {
>   struct erofs_buf {
>   	struct address_space *mapping;
>   	struct file *file;
> +	loff_t off;

Same here.

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
> +			       sbi->dif0.off);
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
>   				bio->bi_private = q[JQ_SUBMIT];
>   				if (readahead)
>   					bio->bi_opf |= REQ_RAHEAD;

