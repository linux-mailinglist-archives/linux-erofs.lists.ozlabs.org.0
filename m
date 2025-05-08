Return-Path: <linux-erofs+bounces-301-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DCAAAF1FB
	for <lists+linux-erofs@lfdr.de>; Thu,  8 May 2025 06:09:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZtJYY72Pvz2ygm;
	Thu,  8 May 2025 14:09:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1746677377;
	cv=none; b=Xs3o0GYRWAm/IMpsecg5fweorvc15RiiaEa+SgH0rpTcW396o40bGXGpyySFkCFDt0X22M3gjZnLK5jYhJZQL/nzoVlIPjYNlbiqzmZkteeMcxppea9XGWwMz03FPHNY9IGqTOJCEKnLpu8ZrnzLRe2VzRR0WtAZ6kW9d5ZFS11tSbic8CnOqWrc1iXOCBIq2EUJw4e90o3O17NdChtKWIE3CT85ZAyL3jRCV/cY81ZLss7W59DtP1K22Y20vMW21+jac89on0jd+Th75rth2ADhLeYtBn2191p7SUX57YRGfsadXp8zrk6bMEBj1LGeVue4YIHb5rZf/oBGGr3S/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1746677377; c=relaxed/relaxed;
	bh=zpJjMdyrn0Lrw7ogNgO0OeCfHHU60ug9slK4AUYcYk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QrvBxtgy85s7InFIwHnxyrbJ6kaTrrHeb0uBeybQmJplF8lPgtuL6wxD1aMv0CHOBo/pOHTYYOZOYGUFBOpdp7usJzCZz2ZtAoiLEru2OzJhkwWkwDVVDFIJFz7CgjseyuURMKhPY8qPfgdxWQrUhHKMLTSbPTvXGhOSKJ667Ruh9MuYn76d1rOlWerPcWffbwtsKhBbWfyuRKgToQFuqSpMknMBfWs9dpZ7LzFZPta4FriS7qKgdgi489ecuJ5Krz/4f/yzVYLk/MHcXSnDReL0fYsuChfy/r1MMOHJT8FsQLvp508VO2D2cseEDfOuqj5ghLtd1f2nX3Lmh6NHBQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fJjZgvfL; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fJjZgvfL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZtJYW6wzrz2yZZ
	for <linux-erofs@lists.ozlabs.org>; Thu,  8 May 2025 14:09:34 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1746677370; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zpJjMdyrn0Lrw7ogNgO0OeCfHHU60ug9slK4AUYcYk0=;
	b=fJjZgvfLuRIGWeW0AyOCkIvB+JxRHGYEu0Nih/C7as13i0xgpCopGD+A7khOcpCXTCij842RN5gHxwRAjBpkUEJDp7GvBKmls8R2WTxb0xet2ZRpb85zHem5IR6vJMvKXfiZ7PN8VS1mgrPXXmla4FWg21MxwK4I2SaQoaRwzsg=
Received: from 30.221.130.212(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WZzOI65_1746677367 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 08 May 2025 12:09:28 +0800
Message-ID: <6389156c-c6df-4e02-ab46-3aaf6230ef76@linux.alibaba.com>
Date: Thu, 8 May 2025 12:09:27 +0800
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
Subject: Re: [PATCH v4 2/2] erofs: add 'fsoffset' mount option for file-backed
 & bdev-based mounts
To: Sheng Yong <shengyong2021@gmail.com>, xiang@kernel.org, chao@kernel.org,
 zbestahu@gmail.com, jefflexu@linux.alibaba.com, dhavale@google.com,
 kzak@redhat.com
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 wangshuai12@xiaomi.com, Sheng Yong <shengyong1@xiaomi.com>
References: <20250408122351.2104507-1-shengyong1@xiaomi.com>
 <20250408122351.2104507-2-shengyong1@xiaomi.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250408122351.2104507-2-shengyong1@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Yong,

On 2025/4/8 20:23, Sheng Yong wrote:
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

Sorry for late reply.  I was busying in other stuffs, but
since it's for the next cycle I guess it's not too late..

> ---
>   Documentation/filesystems/erofs.rst |  1 +
>   fs/erofs/data.c                     |  8 ++++++--
>   fs/erofs/fileio.c                   |  4 +++-
>   fs/erofs/internal.h                 |  2 ++
>   fs/erofs/super.c                    | 24 +++++++++++++++++++++++-
>   fs/erofs/zdata.c                    | 22 ++++++++++++++--------
>   6 files changed, 49 insertions(+), 12 deletions(-)
> ---
> v4: * change mount option `offset=x' to `fsoffset=x'
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
> index 2409d2ab0c28..7da503480f4d 100644
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
> +		iomap->addr = EROFS_SB(sb)->dif0.off + mdev.m_pa;
>   		if (flags & IOMAP_DAX)
>   			iomap->addr += mdev.m_dif->dax_part_off;
>   	}
> diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
> index 4fa0a0121288..2c003cbb0fbb 100644
> --- a/fs/erofs/fileio.c
> +++ b/fs/erofs/fileio.c
> @@ -52,7 +52,9 @@ static void erofs_fileio_rq_submit(struct erofs_fileio_rq *rq)
>   
>   	if (!rq)
>   		return;
> -	rq->iocb.ki_pos = rq->bio.bi_iter.bi_sector << SECTOR_SHIFT;
> +
> +	rq->iocb.ki_pos = EROFS_SB(rq->sb)->dif0.off +
> +				(rq->bio.bi_iter.bi_sector << SECTOR_SHIFT);
>   	rq->iocb.ki_ioprio = get_current_ioprio();
>   	rq->iocb.ki_complete = erofs_fileio_ki_complete;
>   	if (test_opt(&EROFS_SB(rq->sb)->opt, DIRECT_IO) &&
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 4ac188d5d894..10656bd986bd 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -43,6 +43,7 @@ struct erofs_device_info {
>   	char *path;
>   	struct erofs_fscache *fscache;
>   	struct file *file;
> +	loff_t off;
>   	struct dax_device *dax_dev;
>   	u64 dax_part_off;

I wonder if it's possible to combine off as dax_part_off since
they are the same functionality...

>   
> @@ -199,6 +200,7 @@ enum {
>   struct erofs_buf {
>   	struct address_space *mapping;
>   	struct file *file;
> +	loff_t off;

I wonder if there is some other way to check
if it's a metabuf, so that we could just use sbi->dif0.off..

But not sure.

>   	struct page *page;
>   	void *base;
>   };

..

> +		if (sb->s_bdev)
> +			devsz = bdev_nr_bytes(sb->s_bdev);
> +		else if (erofs_is_fileio_mode(sbi))
> +			devsz = i_size_read(file_inode(sbi->dif0.file));
> +		else
> +			return invalfc(fc, "fsoffset only supports file or bdev backing");
> +		if (sbi->dif0.off + (1 << sbi->blkszbits) > devsz)
> +			return invalfc(fc, "fsoffset exceeds device size");

I wonder if those checks are really necessary? even it exceeds
the device size, it won't find the valid on-disk superblock then.

> +	}
> +
>   	err = erofs_read_superblock(sb);
>   	if (err)
>   		return err;
> @@ -948,6 +968,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
>   	if (sbi->domain_id)
>   		seq_printf(seq, ",domain_id=%s", sbi->domain_id);
>   #endif
> +	if (sbi->dif0.off)
> +		seq_printf(seq, ",fsoffset=%lld", sbi->dif0.off);
>   	return 0;
>   }
>   
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 0671184d9cf1..671527b63c6d 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -1624,7 +1624,8 @@ static void z_erofs_submit_queue(struct z_erofs_frontend *f,
>   				 bool *force_fg, bool readahead)
>   {
>   	struct super_block *sb = f->inode->i_sb;
> -	struct address_space *mc = MNGD_MAPPING(EROFS_SB(sb));
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
> +	struct address_space *mc = MNGD_MAPPING(sbi);
>   	struct z_erofs_pcluster **qtail[NR_JOBQUEUES];
>   	struct z_erofs_decompressqueue *q[NR_JOBQUEUES];
>   	struct z_erofs_pcluster *pcl, *next;
> @@ -1673,12 +1674,15 @@ static void z_erofs_submit_queue(struct z_erofs_frontend *f,
>   			if (bio && (cur != last_pa ||
>   				    bio->bi_bdev != mdev.m_bdev)) {
>   drain_io:
> -				if (erofs_is_fileio_mode(EROFS_SB(sb)))
> +				if (erofs_is_fileio_mode(sbi)) {
>   					erofs_fileio_submit_bio(bio);
> -				else if (erofs_is_fscache_mode(sb))
> +				} else if (erofs_is_fscache_mode(sb)) {
>   					erofs_fscache_submit_bio(bio);
> -				else
> +				} else {
> +					bio->bi_iter.bi_sector +=
> +						sbi->dif0.off >> SECTOR_SHIFT;

How about multi-device? I guess we should modify
erofs_map_dev() directly rather than callers.

Thanks,
Gao Xiang

