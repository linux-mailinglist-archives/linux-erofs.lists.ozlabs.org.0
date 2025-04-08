Return-Path: <linux-erofs+bounces-163-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E7FA80626
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Apr 2025 14:24:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZX4yk6hwWz309v;
	Tue,  8 Apr 2025 22:24:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744115086;
	cv=none; b=aVgkgVxd8hrqYa37DA7NzbWhblTfSaUr4YPVWxCbtP5cfqjl/oVPmbDiYDYSLDSci6sNAIXFy+N7nC9Xw9eZ+BI2eyyk16WEQqkbb7xpj+2UvoH1bGFdU+nE147ntRLoPN76KUeQ5cst4rXuOxqcnGtaLaRJwKBX1HT6c7AH730GAo14uSBwcGuoxZon5JS9J+adBYx1Ym0puqfkUEMhVWTxuDuk7yutRqFaa8qJVlDK5PDEdhZ6S8l1WBibv544/qQRFVTDibSY+SKRlJvNNjj/wmULy4nEcEiRA0wKAGeWEgfT/uJHP7aLB/QqYOuzosSjk18Tr09Oj2LsJ6Xh+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744115086; c=relaxed/relaxed;
	bh=qDcvnf/R/8p/WVVaXthuNUTwYOcSMSGVYqzw0QYVnco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2AfRtbhP8z5iQ7Bn6NhRo9sH3XJ2BPTPJW2KZ7yv9enQB2FrhOcSSxzpa6ZVmlLTCEwsMtjJlX27/USlF06KHru/Fsv0VJkv+DmET1MQrrJBI8PbA3olGU3yRetVK52pZwseoBCl06rdAFatHkYqmkzYeBtQyN4DszTv2tfdC355iW99H/dhmORSUJHxTZmna7i3MOP5oQ2JyAEWLD3M24Q5xM2A4FW7In7wxl3IJiRoyrNpWw/V5Z7ZaqdObW2J40IQVAWz0I7+uGK/TEhhhppGF99VEwBUtSv3kp08X4DvcYw/ftXDYwBuizIEvTZk8m05fOGdNsBRbjQ6wlyDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=g9O25nEV; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=g9O25nEV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZX4yj4xtrz301v
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Apr 2025 22:24:45 +1000 (AEST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-736b34a71a1so6376059b3a.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 08 Apr 2025 05:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744115084; x=1744719884; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDcvnf/R/8p/WVVaXthuNUTwYOcSMSGVYqzw0QYVnco=;
        b=g9O25nEV1uRskN4XkhhmmXGqjTE/r9/azl/zzGKHKOVjOqM70/wni9A/EdrOyfQ45T
         69B7SoetMEA8KFkPoLEwBX98X7D6V+ZPUvltnOrtA9bxKjPH7HAIGb7nxEEETOUh6HCX
         vRltlNFao1RXiw04iW1OOMYve0Eno5utjQ9sZUw2oyAQoZixW6TZr72kEAjUCmz+mIxb
         vI/HgyHD5vd+5wyybKKADVBm9Mc+GAiVy82ikd7Nhi88uHXHS+L5y1i6Riluy2dsF5F0
         3wqodlQ9gPoVmfNfJG6l9efx3fUryqrnRWcVgpzwS7OhMUK271vZYq8FGzebHrPh+EmS
         /u6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744115084; x=1744719884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qDcvnf/R/8p/WVVaXthuNUTwYOcSMSGVYqzw0QYVnco=;
        b=oy+mo4wYGPuI84ybFAR+74mm0XmyBH+nNbl031/ngn7B/KLWzozblzTwxL0DZiNTDQ
         LV+2NdAHway5ZyNCyNrN41BVnpCFNwOE/wi/X99YHVnB396mljj8S0kjIwt20X5kSGi9
         psZJ1qPTNm+gB2XX8F0c3QFUqJ74Lp5KfdDtsKIpy7VHW56JaCfm9zAKmQkrGCrjHb6b
         1Nl+cBvQ27OTxHCGoZYV6de2hRTWe8wzJ0Br+IIKN/+WPPqAxQEP2TNpJ7PbYn0T6p0N
         v7CCwdq6j8RMlo3F7PvinQpJjICwHblKsC3qU5qClBg7/AHneDc+B80PBKYQC5pMFlj0
         Y+Ag==
X-Gm-Message-State: AOJu0Ywz/5k/bE7D9r9ZvDZ/O+muDKkVhP0frvocrZua59dF9NKsCAGy
	QcC7il4kDYLr4pssfDwl2RP/dGb9n/vAQ/erTM4SDtxKDGue8nyQ
X-Gm-Gg: ASbGncvGFP4UmsNEffSTmRBGfp/nGX9sbgWzdoGcJ17ygRqTDh79JMZOqFTKjjJLbJp
	h+FEPyGGa0kr7UevxLi+VQ55yDXGoFNjco7nGIkaqkYwSR+in8qs5xHxH+YhC8/Qbic5nQARk1c
	0dVYASCbCfOOV9ACxRMZCgT2hUMaRVt3/JEpPhUvx+KTgm/1lNdc+QOvFB9A0MV1yGgicUBGjOL
	udrjqlRmEd90y9BfTlp4JTY3dTR+zpFRCUoynKgbqbp4xVKrnDOD4SdZe2bN5UkorPZtnalMBKu
	FUKxPfsoQDrFKZD/wqKjoqqhvMAsbEGLrxhZ6Xt6KpAYF4otHu2UMIF9RBY/eQ==
X-Google-Smtp-Source: AGHT+IHbT+Pd5RaaUQs/QlvLUvQotScOY8UBEAi+At11OkGSO/sBZDntuVn8hefoBki8tAF1eVu8aQ==
X-Received: by 2002:a05:6a00:3a09:b0:736:31cf:2590 with SMTP id d2e1a72fcca58-739e4f3a106mr19954823b3a.16.1744115083584;
        Tue, 08 Apr 2025 05:24:43 -0700 (PDT)
Received: from PC.mioffice.cn ([43.224.245.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0b41d4sm10638709b3a.132.2025.04.08.05.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 05:24:43 -0700 (PDT)
From: Sheng Yong <shengyong2021@gmail.com>
X-Google-Original-From: Sheng Yong <shengyong1@xiaomi.com>
To: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	zbestahu@gmail.com,
	jefflexu@linux.alibaba.com,
	dhavale@google.com,
	kzak@redhat.com
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	wangshuai12@xiaomi.com,
	Sheng Yong <shengyong1@xiaomi.com>
Subject: [PATCH v4 2/2] erofs: add 'fsoffset' mount option for file-backed & bdev-based mounts
Date: Tue,  8 Apr 2025 20:23:51 +0800
Message-ID: <20250408122351.2104507-2-shengyong1@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250408122351.2104507-1-shengyong1@xiaomi.com>
References: <20250408122351.2104507-1-shengyong1@xiaomi.com>
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Sheng Yong <shengyong1@xiaomi.com>

When attempting to use an archive file, such as APEX on android,
as a file-backed mount source, it fails because EROFS image within
the archive file does not start at offset 0. As a result, a loop
device is still needed to attach the image file at an appropriate
offset first. Similarly, if an EROFS image within a block device
does not start at offset 0, it cannot be mounted directly either.

To address this issue, this patch adds a new mount option `fsoffset=x'
to accept a start offset for both file-backed and bdev-based mounts.
The offset should be aligned to block size. EROFS will add this offset
before performing read requests.

Signed-off-by: Sheng Yong <shengyong1@xiaomi.com>
Signed-off-by: Wang Shuai <wangshuai12@xiaomi.com>
---
 Documentation/filesystems/erofs.rst |  1 +
 fs/erofs/data.c                     |  8 ++++++--
 fs/erofs/fileio.c                   |  4 +++-
 fs/erofs/internal.h                 |  2 ++
 fs/erofs/super.c                    | 24 +++++++++++++++++++++++-
 fs/erofs/zdata.c                    | 22 ++++++++++++++--------
 6 files changed, 49 insertions(+), 12 deletions(-)
---
v4: * change mount option `offset=x' to `fsoffset=x'

v3: * rename `offs' to `off'
    * parse offset using fsparam_u64 and validate it in fill_super
    * update bi_sector inline
    https://lore.kernel.org/linux-erofs/98585dd8-d0b6-4000-b46d-a08c64eae44d@linux.alibaba.com

v2: * add a new mount option `offset=X' for start offset, and offset
       should be aligned to PAGE_SIZE
    * add start offset for both file-backed and bdev-based mounts
    https://lore.kernel.org/linux-erofs/0725c2ec-528c-42a8-9557-4713e7e35153@linux.alibaba.com

v1: https://lore.kernel.org/all/20250324022849.2715578-1-shengyong1@xiaomi.com/

diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
index c293f8e37468..0fa4c7826203 100644
--- a/Documentation/filesystems/erofs.rst
+++ b/Documentation/filesystems/erofs.rst
@@ -128,6 +128,7 @@ device=%s              Specify a path to an extra device to be used together.
 fsid=%s                Specify a filesystem image ID for Fscache back-end.
 domain_id=%s           Specify a domain ID in fscache mode so that different images
                        with the same blobs under a given domain ID can share storage.
+fsoffset=%s            Specify image offset for file-backed or bdev-based mounts.
 ===================    =========================================================
 
 Sysfs Entries
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 2409d2ab0c28..7da503480f4d 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -27,9 +27,12 @@ void erofs_put_metabuf(struct erofs_buf *buf)
 
 void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset, bool need_kmap)
 {
-	pgoff_t index = offset >> PAGE_SHIFT;
+	pgoff_t index;
 	struct folio *folio = NULL;
 
+	offset += buf->off;
+	index = offset >> PAGE_SHIFT;
+
 	if (buf->page) {
 		folio = page_folio(buf->page);
 		if (folio_file_page(folio, index) != buf->page)
@@ -54,6 +57,7 @@ void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
 	buf->file = NULL;
+	buf->off = sbi->dif0.off;
 	if (erofs_is_fileio_mode(sbi)) {
 		buf->file = sbi->dif0.file;	/* some fs like FUSE needs it */
 		buf->mapping = buf->file->f_mapping;
@@ -299,7 +303,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		iomap->private = buf.base;
 	} else {
 		iomap->type = IOMAP_MAPPED;
-		iomap->addr = mdev.m_pa;
+		iomap->addr = EROFS_SB(sb)->dif0.off + mdev.m_pa;
 		if (flags & IOMAP_DAX)
 			iomap->addr += mdev.m_dif->dax_part_off;
 	}
diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index 4fa0a0121288..2c003cbb0fbb 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -52,7 +52,9 @@ static void erofs_fileio_rq_submit(struct erofs_fileio_rq *rq)
 
 	if (!rq)
 		return;
-	rq->iocb.ki_pos = rq->bio.bi_iter.bi_sector << SECTOR_SHIFT;
+
+	rq->iocb.ki_pos = EROFS_SB(rq->sb)->dif0.off +
+				(rq->bio.bi_iter.bi_sector << SECTOR_SHIFT);
 	rq->iocb.ki_ioprio = get_current_ioprio();
 	rq->iocb.ki_complete = erofs_fileio_ki_complete;
 	if (test_opt(&EROFS_SB(rq->sb)->opt, DIRECT_IO) &&
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4ac188d5d894..10656bd986bd 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -43,6 +43,7 @@ struct erofs_device_info {
 	char *path;
 	struct erofs_fscache *fscache;
 	struct file *file;
+	loff_t off;
 	struct dax_device *dax_dev;
 	u64 dax_part_off;
 
@@ -199,6 +200,7 @@ enum {
 struct erofs_buf {
 	struct address_space *mapping;
 	struct file *file;
+	loff_t off;
 	struct page *page;
 	void *base;
 };
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index cadec6b1b554..e96fea9f2d18 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -356,7 +356,7 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
 
 enum {
 	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
-	Opt_device, Opt_fsid, Opt_domain_id, Opt_directio,
+	Opt_device, Opt_fsid, Opt_domain_id, Opt_directio, Opt_fsoffset,
 	Opt_err
 };
 
@@ -384,6 +384,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
 	fsparam_string("fsid",		Opt_fsid),
 	fsparam_string("domain_id",	Opt_domain_id),
 	fsparam_flag_no("directio",	Opt_directio),
+	fsparam_u64("fsoffset",		Opt_fsoffset),
 	{}
 };
 
@@ -507,6 +508,9 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		errorfc(fc, "%s option not supported", erofs_fs_parameters[opt].name);
 #endif
 		break;
+	case Opt_fsoffset:
+		sbi->dif0.off = result.uint_64;
+		break;
 	}
 	return 0;
 }
@@ -600,6 +604,22 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 				&sbi->dif0.dax_part_off, NULL, NULL);
 	}
 
+	if (sbi->dif0.off) {
+		loff_t devsz;
+
+		if (sbi->dif0.off & ((1 << sbi->blkszbits) - 1))
+			return invalfc(fc, "fsoffset %lld not aligned to block size",
+				       sbi->dif0.off);
+		if (sb->s_bdev)
+			devsz = bdev_nr_bytes(sb->s_bdev);
+		else if (erofs_is_fileio_mode(sbi))
+			devsz = i_size_read(file_inode(sbi->dif0.file));
+		else
+			return invalfc(fc, "fsoffset only supports file or bdev backing");
+		if (sbi->dif0.off + (1 << sbi->blkszbits) > devsz)
+			return invalfc(fc, "fsoffset exceeds device size");
+	}
+
 	err = erofs_read_superblock(sb);
 	if (err)
 		return err;
@@ -948,6 +968,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
 	if (sbi->domain_id)
 		seq_printf(seq, ",domain_id=%s", sbi->domain_id);
 #endif
+	if (sbi->dif0.off)
+		seq_printf(seq, ",fsoffset=%lld", sbi->dif0.off);
 	return 0;
 }
 
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 0671184d9cf1..671527b63c6d 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1624,7 +1624,8 @@ static void z_erofs_submit_queue(struct z_erofs_frontend *f,
 				 bool *force_fg, bool readahead)
 {
 	struct super_block *sb = f->inode->i_sb;
-	struct address_space *mc = MNGD_MAPPING(EROFS_SB(sb));
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	struct address_space *mc = MNGD_MAPPING(sbi);
 	struct z_erofs_pcluster **qtail[NR_JOBQUEUES];
 	struct z_erofs_decompressqueue *q[NR_JOBQUEUES];
 	struct z_erofs_pcluster *pcl, *next;
@@ -1673,12 +1674,15 @@ static void z_erofs_submit_queue(struct z_erofs_frontend *f,
 			if (bio && (cur != last_pa ||
 				    bio->bi_bdev != mdev.m_bdev)) {
 drain_io:
-				if (erofs_is_fileio_mode(EROFS_SB(sb)))
+				if (erofs_is_fileio_mode(sbi)) {
 					erofs_fileio_submit_bio(bio);
-				else if (erofs_is_fscache_mode(sb))
+				} else if (erofs_is_fscache_mode(sb)) {
 					erofs_fscache_submit_bio(bio);
-				else
+				} else {
+					bio->bi_iter.bi_sector +=
+						sbi->dif0.off >> SECTOR_SHIFT;
 					submit_bio(bio);
+				}
 
 				if (memstall) {
 					psi_memstall_leave(&pflags);
@@ -1703,7 +1707,7 @@ static void z_erofs_submit_queue(struct z_erofs_frontend *f,
 			}
 
 			if (!bio) {
-				if (erofs_is_fileio_mode(EROFS_SB(sb)))
+				if (erofs_is_fileio_mode(sbi))
 					bio = erofs_fileio_bio_alloc(&mdev);
 				else if (erofs_is_fscache_mode(sb))
 					bio = erofs_fscache_bio_alloc(&mdev);
@@ -1732,12 +1736,14 @@ static void z_erofs_submit_queue(struct z_erofs_frontend *f,
 	} while (next != Z_EROFS_PCLUSTER_TAIL);
 
 	if (bio) {
-		if (erofs_is_fileio_mode(EROFS_SB(sb)))
+		if (erofs_is_fileio_mode(sbi)) {
 			erofs_fileio_submit_bio(bio);
-		else if (erofs_is_fscache_mode(sb))
+		} else if (erofs_is_fscache_mode(sb)) {
 			erofs_fscache_submit_bio(bio);
-		else
+		} else {
+			bio->bi_iter.bi_sector += sbi->dif0.off >> SECTOR_SHIFT;
 			submit_bio(bio);
+		}
 	}
 	if (memstall)
 		psi_memstall_leave(&pflags);
-- 
2.43.0


