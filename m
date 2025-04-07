Return-Path: <linux-erofs+bounces-152-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBEFA7DBDD
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Apr 2025 13:07:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZWRHQ10W0z2y92;
	Mon,  7 Apr 2025 21:06:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::534"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744024018;
	cv=none; b=RJd1f+9t0vHuO4PezQ00LiKjvJ2Hyyflps2DvjZycsj+mSClo56cs+23AIQNyNgKjBMJHPw3jED8KAUBsNGCmkzcKKOATMK3j5v3SBBlB7gMNZZgRq1CIP0rcWWGPfeiyD8N+HvevwGKpRRLWJXG+pjV/JPL6EGp3sSYHVpUd5Or5MF9ELBvqF9Ur8OHwAgoH+kq3fI0ZLQwxDEl/01MOjZrmhC+fMpH8zJ7C893AJfnTjrl0Z0QAtp83Pk2rsZeR0O/AQrRwdLl3Rru5kamJKBnaCx5MtDY5Td74CRmIXm2xROPgOI9hJQxa2b0AVzvxgPzumbCEMyOXxeQZo6kuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744024018; c=relaxed/relaxed;
	bh=TzKmZuYPn0pUxFB9FJAdoZX8qB0+HOaGeZ4/x0ViQnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TKwstQ6jJGbDlx06nRUdrv/SS5z/y3NcqtJojl+1Hhz0UW3y7UHKQYqmIA556q0Xe4frF2N56WTvN9/yjnGgXlfTGXA855pDYz+YE07aNcTwR8F8NGrIG8Cc9PWQh8YZeo0QE2+F+Q9btA9vwUsIjMbJBjhWZ3LSSt3LX2guoxfna5aTaYfkL1x0SJmVInXdmrR3oOS34vOLma1FMJ9bdBoC1JVD5QkxZGaStzn3ahvmu7EMR1Ms8xk+ady42+XEb9xRnHhH69evBtyCBfkqPWWB/yST3+b1soGi1EliXvf6l0oflUssUcx43IOYzkh4Qq8wBZlBwTE3lYon8syDSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=eHN7WjCd; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=eHN7WjCd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZWRHN6b11z2yfv
	for <linux-erofs@lists.ozlabs.org>; Mon,  7 Apr 2025 21:06:56 +1000 (AEST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-af5cdf4a2f8so2978338a12.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 07 Apr 2025 04:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744024015; x=1744628815; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzKmZuYPn0pUxFB9FJAdoZX8qB0+HOaGeZ4/x0ViQnM=;
        b=eHN7WjCdgO/201QtIt+eFxw4esU2hvbSq50+wdcN0MkiPxIXasxE8UQQxBQkg72Qwm
         R00t0jXyUwP/4dxdLEbjOrp+u440qNRF5SNj+4F78y6TnZrDtN8G/1q3PF70mM4tYvW9
         5rlxTuGBsttLET4zWHfwxNzOOd6apxN0hStxfUdWc0JyIjDTNnahaTYa1UGCCOJk0GfJ
         3cYannOD1Zs7x50jmZXg/flGQVXL4wg50ZO5EpIfjH19zryjnoAGWTWwi6a1j0pFUK9c
         GQRjXFqTeUTSHPx8jqBnUuAsBajEcdnZjCJfNDI2/Z2S2YruWMCebU6Sui2aOOhkDBbv
         ZSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744024015; x=1744628815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TzKmZuYPn0pUxFB9FJAdoZX8qB0+HOaGeZ4/x0ViQnM=;
        b=aZ4ADguahpRx8u/mcCE1qcyYz4EFt+gpDfq0jx6dxugo0mMtRP5EJ2d2L/5G3KU8Fg
         UxJVWjplNszBEdQwOCsqWEdgeVjrm6KXPxiIIJxA+tCJxombRvxfJOJewqXeJV5PycfM
         HUj7nLOWBNECKPpupiKfU0w8LOIZGB0n9eIuAofOEmOd7QU3pV5M9UI5LvkKwMX6kTdS
         Az/5EfnqIwhYDmk9PBfz0sxKMPIUS4IbNxwjG4b/i9aCdBFEyGlZtaoxRnuDTsuGjwJ/
         hzm7+bgQ2qtCIrUGvc8Pe9vQE5CSXP/h2Q9XYXDxAd5wnuc6uXVRhqA3QKoFn/qTQ+vr
         QaWw==
X-Gm-Message-State: AOJu0Yxe91Qbet+rgx//Z9Y4EDGz7T6JRjpm7+QiI2ahJMwJcMxUlgu3
	oBQOBQRe8hpV6L8UPOj+AL3JImlyAGzqzlwXz/jcVI8Bza5uvN8t
X-Gm-Gg: ASbGnctQXlbv9PeoXAO4cN15tah4Nsfi4Kw7RPZ2EVrf3dTcOAtG2BhjQxYV+/QNdMU
	bR1zggfefdh0t/YKc6raA7tsRKJtJJAoHj+NNIAdoPpR/E8u00iaDYOvxC9zLBY/wOfHo+Mzvqz
	RnE3+w09wVxlDAlAHy16bGvlOYZRTNdXmhbGh6qw+PxDQaSXMOkrrQ75m7BWlecobxfjoKTClS7
	kNPZuw9d3EmslIDmnjs9IfJ8xDrWOhmIduWW6Z5bHaU+/vDS4fe2J4nnF31VB4fwZMrMYq51eGY
	SSAmh0ZlGfzlIKE9HFTSeKQJUHpQLulReKq4N9M6fMLgwZwJVeg=
X-Google-Smtp-Source: AGHT+IEFUT2afZfFzltBDlWTMxjermADofrbcz2LpbaWF7nQH4GJjL2VuVjpVpe1ZFmIbvBgXYtxuA==
X-Received: by 2002:a17:90a:e18f:b0:2ee:bc7b:9237 with SMTP id 98e67ed59e1d1-306a4b7101fmr15875558a91.27.1744024014859;
        Mon, 07 Apr 2025 04:06:54 -0700 (PDT)
Received: from PC.mioffice.cn ([43.224.245.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3057cb5d672sm8783946a91.31.2025.04.07.04.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 04:06:54 -0700 (PDT)
From: Sheng Yong <shengyong2021@gmail.com>
X-Google-Original-From: Sheng Yong <shengyong1@xiaomi.com>
To: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	zbestahu@gmail.com,
	jefflexu@linux.alibaba.com,
	dhavale@google.com
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Sheng Yong <shengyong1@xiaomi.com>,
	Wang Shuai <wangshuai12@xiaomi.com>
Subject: [PATCH v3 2/2] erofs: add 'offset' mount option for file-backed & bdev-based mounts
Date: Mon,  7 Apr 2025 19:05:51 +0800
Message-ID: <20250407110551.1538457-2-shengyong1@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250407110551.1538457-1-shengyong1@xiaomi.com>
References: <20250407110551.1538457-1-shengyong1@xiaomi.com>
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

To address this issue, this patch adds a new mount option `offset=x'
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
v3: * rename `offs' to `off'
    * parse offset using fsparam_u64 and validate it in fill_super
    * update bi_sector inline

v2: * add a new mount option `offset=X' for start offset, and offset
       should be aligned to PAGE_SIZE
    * add start offset for both file-backed and bdev-based mounts
    https://lore.kernel.org/linux-erofs/0725c2ec-528c-42a8-9557-4713e7e35153@linux.alibaba.com

v1: https://lore.kernel.org/all/20250324022849.2715578-1-shengyong1@xiaomi.com/

diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
index c293f8e37468..44dbfa6cffb1 100644
--- a/Documentation/filesystems/erofs.rst
+++ b/Documentation/filesystems/erofs.rst
@@ -128,6 +128,7 @@ device=%s              Specify a path to an extra device to be used together.
 fsid=%s                Specify a filesystem image ID for Fscache back-end.
 domain_id=%s           Specify a domain ID in fscache mode so that different images
                        with the same blobs under a given domain ID can share storage.
+offset=%s              Specify image offset for file-backed or bdev-based mounts.
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
index cadec6b1b554..bd2a2c634f1d 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -356,7 +356,7 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
 
 enum {
 	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
-	Opt_device, Opt_fsid, Opt_domain_id, Opt_directio,
+	Opt_device, Opt_fsid, Opt_domain_id, Opt_directio, Opt_offset,
 	Opt_err
 };
 
@@ -384,6 +384,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
 	fsparam_string("fsid",		Opt_fsid),
 	fsparam_string("domain_id",	Opt_domain_id),
 	fsparam_flag_no("directio",	Opt_directio),
+	fsparam_u64("offset",		Opt_offset),
 	{}
 };
 
@@ -507,6 +508,9 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		errorfc(fc, "%s option not supported", erofs_fs_parameters[opt].name);
 #endif
 		break;
+	case Opt_offset:
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
+			return invalfc(fc, "offset %lld not aligned to block size",
+				       sbi->dif0.off);
+		if (sb->s_bdev)
+			devsz = bdev_nr_bytes(sb->s_bdev);
+		else if (erofs_is_fileio_mode(sbi))
+			devsz = i_size_read(file_inode(sbi->dif0.file));
+		else
+			return invalfc(fc, "offset only supports file or bdev backing");
+		if (sbi->dif0.off + (1 << sbi->blkszbits) > devsz)
+			return invalfc(fc, "offset exceeds device size");
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
+		seq_printf(seq, ",offset=%lld", sbi->dif0.off);
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


