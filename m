Return-Path: <linux-erofs+bounces-130-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB24A75DD8
	for <lists+linux-erofs@lfdr.de>; Mon, 31 Mar 2025 04:30:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZQw8f71vsz2yFP;
	Mon, 31 Mar 2025 13:30:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1743388226;
	cv=none; b=IA5WcKwFOB81I1bwFz8ptC4yBGiKZREP4L/7NnK/vgYtoU6uvIyTN8g5lgX8V9FtkS4yGyaCbTyiCZh16M6PVpUg3H31TDm9ir5J5vrBsD1te7uSfJZyqYffoL2Cb9L7NsW3bkJBEhzNLbmo6JL9ieJcpZSgMX2MCNXXBvkFN6S1CiX5xxrs85Bggd1Z+YGwHEbutF+Iq3p53E1fch2s4D4h2dmjYwvuHVswIh8kY8kBGhKFZ7z6cHPhfycoM6GiaSG0omDvVEo7mU396mC8vjwZcYnYUEpZbEHBMaR1LzCfmmkG7EjrQV1M877o059mARzvzFVAX/tiHvLpkJYL9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1743388226; c=relaxed/relaxed;
	bh=RTyyxUYhwq66mIAa/IvJoiVtxddqgIA29vA5Ht3bWBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZQhPkXG/bWaiVnNCLQNBKfhF3bBN9bCZmxO8fzeUSLBsQFXBVCQMoLYXdaQsYWWgwt9GRiA3ZILZLkU2Wh28N+WDw6Mxwz2bLreNb9gJx+1vISDDSpCSG4jqycvpg9zkmsqZF3NEreoGYzD80peZxRGZNykd/tKFY/K/F4AepeNWiTtNiEnyUQsegX67by+nr1D9HOpagxJsz0qX0YYe2B9OnPryk7+qdVFMLchbeRh9K02z4uftDtS2wUrKb274BONSpB0Je4pYAGXLewkzoGRHth+tNWPwn3uwKkcG3BJs9iCWSfLhnW90BykJPvOHGJxD3HW9ukSoIj+CmREFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=df2BtQZe; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=df2BtQZe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZQw8f1RsBz2xlP
	for <linux-erofs@lists.ozlabs.org>; Mon, 31 Mar 2025 13:30:25 +1100 (AEDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2243803b776so56427575ad.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 30 Mar 2025 19:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743388224; x=1743993024; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTyyxUYhwq66mIAa/IvJoiVtxddqgIA29vA5Ht3bWBs=;
        b=df2BtQZeGJqcfiPEobn142kiOVTBwsKtKb4XrwMOp1wofmXn6XuUogVZgLCo3s6ov/
         B6eLG17zoJLdnjsVd1ID/cxCvRq4aUBCKb1t4y2XGEShhJRv6FDAeaBhvQ4uLWYaf7Kl
         Ooc89tOUHHF2B8J2M35VxQFnIHZa2w0jHkCvADIRDCcpjPs+yfllNcIOLqFnV8J4QSPa
         ORawfZjQuEp1R1vcouJcHiEJlxRpoEjulPNKVfIvT6ds/msV69bFtpVPSv/KRg5O5LxT
         qW/l+dNzjNyAY+f4g2r8gwj4N+97ymYuYT1UvxB8BNRhw/ib+aAW6wBDdPmgV+bBEYZC
         CAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743388224; x=1743993024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RTyyxUYhwq66mIAa/IvJoiVtxddqgIA29vA5Ht3bWBs=;
        b=rm05fYVI6oMH8sNnyUr2BFdj7jZ8yukCnjlBVXoiccZQSjcQB4qDDqcXdQiqe6Rlbp
         z3X52eIMeGQCnh3kksIyc9HJOLGt1aWYL/C0TXccq/Yu6F7gJ4JTw8SlRJGXYO2lu4I4
         IWCpuW65KwmpJkS1Efm8sIhnSSiaDNPJfO/NtfHW+/53IkQmPr4hB1m885M9r/7UHbgs
         zoCsF4jCLbPeXjJ5iV+D/nQCfnb6RLGvUQNgW4e2sQLI8aMBNtTvzaIJr1zw3oiG9aBR
         UEpNolPZrH+breTDJPeNslQWIYxlkxWaInXjAR23/bCuj2RNYMc7SIsAjAn8ve9avSQ6
         YYig==
X-Forwarded-Encrypted: i=1; AJvYcCWyN8X0GHojOrCRxT/UMd+HW0OgnHNUiPvHXFqh3okcC5kDIKYiyurAaBCzSx9x7AdU2DRGqA9cLjaE/w==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxianwZ3YUKRCyRotGssJu/HPEOWWdWNSFcYXRP02jTysMdEK0Y
	Q53+agwkjlc7G+Qe8dJSjNo6rBbkK7v07PiARjKRFO7d4Mq90COv
X-Gm-Gg: ASbGncsJ/I8448Yh6TJkO2mfUVvKZMwsJJ2VeDq4YuWHAGtPRxzR+aWjePf7OX+RNbk
	cNf2hNXzKmE60QHFxJq1EZNJV7w/Y20WUOst9FpWmn30n1OvnAKSW/JXlRad1nGkGLdRLKzOW5g
	wGnZpvzcqDgh2NJGyBPNRZcLL6KQl6K9jE/KNnmmJ8wrUPpff4YxtGQ+ZyDYxxNJaL83xVzVoSp
	5l5U56gVMo26pJvNVeU5FugEfwkFUCWbWncRBCZuba3JylQri+kSsGKjNuRsxDyByMaMsQQ8BB/
	FacxRReuPXBb1kN1zeVIRuntnEIE34DrBqtFkoNv1G6hr1SPvPQ=
X-Google-Smtp-Source: AGHT+IFdVAOcjpPWTnV2jnq2FgWj09+eoRXi3nsOYDw3M7f9um2NA4qJCbc4nLo5pBc3+wO+IwMz7A==
X-Received: by 2002:a17:902:e946:b0:21f:52e:939e with SMTP id d9443c01a7336-2292f974bbbmr153092155ad.28.1743388223967;
        Sun, 30 Mar 2025 19:30:23 -0700 (PDT)
Received: from PC.mioffice.cn ([43.224.245.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eec71cfsm59455955ad.45.2025.03.30.19.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 19:30:23 -0700 (PDT)
From: Sheng Yong <shengyong2021@gmail.com>
X-Google-Original-From: Sheng Yong <shengyong1@xiaomi.com>
To: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	zbestahu@gmail.com,
	jefflexu@linux.alibaba.com,
	dhavale@google.com,
	linux-erofs@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
	wangshuai12@xiaomi.com,
	Sheng Yong <shengyong1@xiaomi.com>
Subject: [PATCH v2 2/2] erofs: add 'offset' mount option for file-backed & bdev-based mounts
Date: Mon, 31 Mar 2025 10:29:38 +0800
Message-ID: <20250331022938.4090283-2-shengyong1@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331022938.4090283-1-shengyong1@xiaomi.com>
References: <20250331022938.4090283-1-shengyong1@xiaomi.com>
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
The offset should be aligned to PAGE_SIZE. EROFS will add this offset
before performing read requests.

Signed-off-by: Sheng Yong <shengyong1@xiaomi.com>
Signed-off-by: Wang Shuai <wangshuai12@xiaomi.com>
---
 Documentation/filesystems/erofs.rst |  1 +
 fs/erofs/data.c                     |  8 ++++++--
 fs/erofs/fileio.c                   |  8 ++++++--
 fs/erofs/internal.h                 |  2 ++
 fs/erofs/super.c                    | 29 ++++++++++++++++++++++++++++-
 fs/erofs/zdata.c                    | 13 +++++++++++--
 6 files changed, 54 insertions(+), 7 deletions(-)
---
Hi, all

Sorry for late :-(

v2: * add a new mount option `offset=X' for start offset, and offset
      should be aligned to PAGE_SIZE
    * add start offset for both file-backed and bdev-based mounts
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
index 2409d2ab0c28..8dfdd0352c79 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -27,9 +27,12 @@ void erofs_put_metabuf(struct erofs_buf *buf)
 
 void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset, bool need_kmap)
 {
-	pgoff_t index = offset >> PAGE_SHIFT;
+	pgoff_t index;
 	struct folio *folio = NULL;
 
+	offset += buf->offs;
+	index = offset >> PAGE_SHIFT;
+
 	if (buf->page) {
 		folio = page_folio(buf->page);
 		if (folio_file_page(folio, index) != buf->page)
@@ -54,6 +57,7 @@ void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
 	buf->file = NULL;
+	buf->offs = sbi->dif0.offs;
 	if (erofs_is_fileio_mode(sbi)) {
 		buf->file = sbi->dif0.file;	/* some fs like FUSE needs it */
 		buf->mapping = buf->file->f_mapping;
@@ -299,7 +303,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		iomap->private = buf.base;
 	} else {
 		iomap->type = IOMAP_MAPPED;
-		iomap->addr = mdev.m_pa;
+		iomap->addr = EROFS_SB(sb)->dif0.offs + mdev.m_pa;
 		if (flags & IOMAP_DAX)
 			iomap->addr += mdev.m_dif->dax_part_off;
 	}
diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index 4fa0a0121288..d213bcb8c6c2 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -47,15 +47,19 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
 
 static void erofs_fileio_rq_submit(struct erofs_fileio_rq *rq)
 {
+	struct erofs_sb_info *sbi;
 	struct iov_iter iter;
 	int ret;
 
 	if (!rq)
 		return;
-	rq->iocb.ki_pos = rq->bio.bi_iter.bi_sector << SECTOR_SHIFT;
+
+	sbi = EROFS_SB(rq->sb);
+	rq->iocb.ki_pos = sbi->dif0.offs +
+				(rq->bio.bi_iter.bi_sector << SECTOR_SHIFT);
 	rq->iocb.ki_ioprio = get_current_ioprio();
 	rq->iocb.ki_complete = erofs_fileio_ki_complete;
-	if (test_opt(&EROFS_SB(rq->sb)->opt, DIRECT_IO) &&
+	if (test_opt(&sbi->opt, DIRECT_IO) &&
 	    rq->iocb.ki_filp->f_mode & FMODE_CAN_ODIRECT)
 		rq->iocb.ki_flags = IOCB_DIRECT;
 	iov_iter_bvec(&iter, ITER_DEST, rq->bvecs, rq->bio.bi_vcnt,
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4ac188d5d894..93fc111fa675 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -43,6 +43,7 @@ struct erofs_device_info {
 	char *path;
 	struct erofs_fscache *fscache;
 	struct file *file;
+	loff_t offs;
 	struct dax_device *dax_dev;
 	u64 dax_part_off;
 
@@ -199,6 +200,7 @@ enum {
 struct erofs_buf {
 	struct address_space *mapping;
 	struct file *file;
+	loff_t offs;
 	struct page *page;
 	void *base;
 };
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index cadec6b1b554..0569f62a76a8 100644
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
+	fsparam_string("offset",	Opt_offset),
 	{}
 };
 
@@ -411,6 +412,22 @@ static bool erofs_fc_set_dax_mode(struct fs_context *fc, unsigned int mode)
 #endif
 }
 
+static bool erofs_fc_set_offset(struct fs_context *fc,
+				struct fs_parameter *param)
+{
+	struct erofs_sb_info *sbi = fc->s_fs_info;
+	loff_t offs;
+
+	if (kstrtoll(param->string, 0, &offs) < 0 ||
+	    offs < 0 || offs & ~PAGE_MASK) {
+		errorfc(fc, "Invalid offset %s", param->string);
+		return false;
+	}
+	sbi->dif0.offs = offs;
+
+	return true;
+}
+
 static int erofs_fc_parse_param(struct fs_context *fc,
 				struct fs_parameter *param)
 {
@@ -507,6 +524,10 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		errorfc(fc, "%s option not supported", erofs_fs_parameters[opt].name);
 #endif
 		break;
+	case Opt_offset:
+		if (!erofs_fc_set_offset(fc, param))
+			return -EINVAL;
+		break;
 	}
 	return 0;
 }
@@ -697,6 +718,10 @@ static int erofs_fc_get_tree(struct fs_context *fc)
 		file = filp_open(fc->source, O_RDONLY | O_LARGEFILE, 0);
 		if (IS_ERR(file))
 			return PTR_ERR(file);
+		if (sbi->dif0.offs + PAGE_SIZE >= i_size_read(file_inode(file))) {
+			fput(file);
+			return invalf(fc, "Start offset too large");
+		}
 		sbi->dif0.file = file;
 
 		if (S_ISREG(file_inode(sbi->dif0.file)->i_mode) &&
@@ -948,6 +973,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
 	if (sbi->domain_id)
 		seq_printf(seq, ",domain_id=%s", sbi->domain_id);
 #endif
+	if (sbi->dif0.offs)
+		seq_printf(seq, ",offset=%lld", sbi->dif0.offs);
 	return 0;
 }
 
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 0671184d9cf1..dc2aa3418094 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1619,6 +1619,15 @@ static void z_erofs_endio(struct bio *bio)
 		bio_put(bio);
 }
 
+static void z_erofs_submit_bio(struct bio *bio)
+{
+	struct z_erofs_decompressqueue *q = bio->bi_private;
+	struct erofs_sb_info *sbi = EROFS_SB(q->sb);
+
+	bio->bi_iter.bi_sector += sbi->dif0.offs >> SECTOR_SHIFT;
+	submit_bio(bio);
+}
+
 static void z_erofs_submit_queue(struct z_erofs_frontend *f,
 				 struct z_erofs_decompressqueue *fgq,
 				 bool *force_fg, bool readahead)
@@ -1678,7 +1687,7 @@ static void z_erofs_submit_queue(struct z_erofs_frontend *f,
 				else if (erofs_is_fscache_mode(sb))
 					erofs_fscache_submit_bio(bio);
 				else
-					submit_bio(bio);
+					z_erofs_submit_bio(bio);
 
 				if (memstall) {
 					psi_memstall_leave(&pflags);
@@ -1737,7 +1746,7 @@ static void z_erofs_submit_queue(struct z_erofs_frontend *f,
 		else if (erofs_is_fscache_mode(sb))
 			erofs_fscache_submit_bio(bio);
 		else
-			submit_bio(bio);
+			z_erofs_submit_bio(bio);
 	}
 	if (memstall)
 		psi_memstall_leave(&pflags);
-- 
2.43.0


