Return-Path: <linux-erofs+bounces-331-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BC638AB983B
	for <lists+linux-erofs@lfdr.de>; Fri, 16 May 2025 11:01:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZzLfK3J1kz2yFJ;
	Fri, 16 May 2025 19:01:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747386073;
	cv=none; b=CL8SGR+NeD1guoy4seDLu3Qrv4GVwjhDrFwO6LTt0nHZuRfioYHlUFlVjHBPdyjr6fOAzTAaxIzZHeYv/HMlEupmj7O99rcbhCpDF6OtcvR0ERKmttrvNcGqeMwic7hRz8i77iJFQQ6exPYCHg8Iv4yiJh1rp7zIyaOocH8E9/8NEGv3mrz2ICyDKF/WVbtzNnYAGEHkeY+xMvxNOb/rKhm0GHWho2X3iusGf2ZkY/YRviP51O48q4Rl5S5z0InHT/5KA4N+JpD31ISuTY5QQva5nHsrOdGPUKUIxz+VC7HSBx1ZkvwdWLhIiqkmQZPO4j8g+STurzCbA0ZURqBvBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747386073; c=relaxed/relaxed;
	bh=XkthQPsz64TyOCZT4K9/BOr4xyvnTi+7/s58T/M8D44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nb3MBqR328hwaJj4G691zUUHhR7yaipTTgWplYucqYevG0Cf29oYUVKIcjOC7b7I9RncCwCOpTzz+Bh9MF5dGfJmFY0dck+2NgiP9R7Yt5d8m/O0BI5AadbiihIPWEPq07T2xw10ZISvA993Jsfam0OeBvMPn7WNoKMV6C5PbinF5VUR5HZDThaJi61DdmMLjPx6hbklKPPVR1wjTRnzz23R84HW0b+zdfpNhoesi+8OkPs422aWsePI0NXBOBsUx9HMWct5JLhEqSaj+zT94WOuMlvQ+ItEmxbFwSu07wgtJ0wS7gtXUi+NrgfdD70rgBt+Y6opDJ+5TG3e7XRxtQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=mBB5dFgy; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=mBB5dFgy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZzLfG5jHLz2xCd
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 May 2025 19:01:09 +1000 (AEST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-742596d8b95so2504793b3a.1
        for <linux-erofs@lists.ozlabs.org>; Fri, 16 May 2025 02:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747386067; x=1747990867; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XkthQPsz64TyOCZT4K9/BOr4xyvnTi+7/s58T/M8D44=;
        b=mBB5dFgybVaxMPm065viFA25477XiVWApEKeiYtjyF3+rVDuKN7lI/X12cegNnrtEU
         D8Z8Ppl1y8EfSikkHGWvjUfyN2a8CyKNVJp2NhBGY2hmqfMIipYjDa1R09Hl8o8BNG1c
         N9ELo9AzAflQBTrmW7JB+1G65vD5RmQ1SgLDxr+3hELkyGBTLwpXmd9aQ13JQUreijKJ
         AItmsEaO+30naoGS57ZZaVkGek57ib1pi/U6Y8O5uRyvMsM4BsbPqOes8taclFt6Fqox
         t4oih6wB3NI86yG3pb8NIa5FaZ0q9jCxesmLrSVrY1pBx/0XrfzM8nlhTiIS63yulM+d
         L23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747386067; x=1747990867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XkthQPsz64TyOCZT4K9/BOr4xyvnTi+7/s58T/M8D44=;
        b=nULTUyaWwAwCwVxGfqGT/UZ3lEzy4/XU4TIjXB3Ff+fv5DYPZ+wMhAJxdPCQKZY8UB
         KVPirV5O9FSXD9gPtQzX99v6PthdgH5C+yXs4kVJTXbpi0CbrpWfUOs8Fd9mlnQLe1eF
         S2Hl2/FM7dotBtPBbGdo2jxfyZdkAfXGf02EjjKa6Lo8qORVMJBl3R/4vy4or07HbbWx
         UrY52GsiXs7bCrdyyS5Sq4FqGucwnX2V+EItEi7mm0YU5huCMt6uKEpH0ozvQQtlaZB9
         7ovNhs6AVPD4ueLGJLKcOgerVi1e+65s41XAfoTmopeOgWKuj+g8FkORUiGP/OwdB7jo
         xUnA==
X-Gm-Message-State: AOJu0Yw7ruQ8NbyXiOKUimDyASIXR0n8l9UJnBFqg7zyHvE3qkFfd25L
	QgQtfEin3iJVMdmo0cfVg26x/u0rWuHgPpcJzZoqzlf6q16hJh3Frak7
X-Gm-Gg: ASbGncv36DeFVxLt4Ju83Dm7P5/Fdo0+341MtW6Hl2RWL/5UO6KhrVb0W16LgxviCpM
	033nvh9YLnehRaZumt0VBrT2OKh8Z7qJ9BmYjcZamzjFHY6AbgnqTuwUgWR6D+JpmKYyGTrqeAi
	3wDhJ5T/Af87DBNWv4bO+PafjRE9r/tARMGEUFze9cCWnAze+Vu5KGaIk3h+LZIOwEyjtpc2bNa
	C9eAU48BhMSg01LQ8atWWOVXIE5hTHzVKyV0EeNXTdyFyqybdQgCBu2+fUM7Kzz4s2ubgwcab5y
	Hpgx6qtR4DK1IwZfcgEuK0sKof0AZVsgzNNIs+fS018qhizUsB803ZZkXrIqs0YQlkve
X-Google-Smtp-Source: AGHT+IGajjN7pnf+hHSGHrxpstiUL1UW4ewfRZKOSQkXmuUgiVPDQ3ZQIP4+oKjUfkNL2UV5TS1YLw==
X-Received: by 2002:a05:6a20:3d11:b0:1f5:7d57:830f with SMTP id adf61e73a8af0-216219c83a3mr3041893637.33.1747386067028;
        Fri, 16 May 2025 02:01:07 -0700 (PDT)
Received: from PC.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb084428sm1133402a12.57.2025.05.16.02.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 02:01:06 -0700 (PDT)
From: Sheng Yong <shengyong2021@gmail.com>
X-Google-Original-From: Sheng Yong <shengyong1@xiaomi.com>
To: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	zbestahu@gmail.com,
	jefflexu@linux.alibaba.com,
	dhavale@google.com,
	lihongbo22@huawei.com
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Sheng Yong <shengyong1@xiaomi.com>,
	Wang Shuai <wangshuai12@xiaomi.com>
Subject: [PATCH v6] erofs: add 'fsoffset' mount option for file-backed & bdev-based mounts
Date: Fri, 16 May 2025 17:00:55 +0800
Message-ID: <20250516090055.3343777-1-shengyong1@xiaomi.com>
X-Mailer: git-send-email 2.43.0
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
 fs/erofs/fileio.c                   |  3 ++-
 fs/erofs/internal.h                 |  2 ++
 fs/erofs/super.c                    | 12 +++++++++++-
 fs/erofs/zdata.c                    |  3 ++-
 6 files changed, 24 insertions(+), 5 deletions(-)
---
v6: * fix fsoffset value type in documentation
    * change `off' type to u64

v5: * fix fsoffset on multiple device by adding off when creating io
      request, erofs_map_device selects the target device an only
      primary device has an off
    * remove unnecessary checks of fsoffset value
    * try to combine off and dax_part_off, but it is not easy to do
      that, because dax_part_off is not needed when reading metadata
    https://lore.kernel.org/linux-erofs/f62b0d18-f5af-4063-b644-f6b8069ca200@gmail.com

v4: * change mount option `offset=x' to `fsoffset=x'
    https://lore.kernel.org/linux-erofs/c5110e03-90ea-40be-b05f-bc920332a1e1@linux.alibaba.com

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
index c293f8e37468..b24cb0d5d4d6 100644
--- a/Documentation/filesystems/erofs.rst
+++ b/Documentation/filesystems/erofs.rst
@@ -128,6 +128,7 @@ device=%s              Specify a path to an extra device to be used together.
 fsid=%s                Specify a filesystem image ID for Fscache back-end.
 domain_id=%s           Specify a domain ID in fscache mode so that different images
                        with the same blobs under a given domain ID can share storage.
+fsoffset=%lu           Specify image offset for file-backed or bdev-based mounts.
 ===================    =========================================================
 
 Sysfs Entries
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 2409d2ab0c28..599a44d5d782 100644
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
+		iomap->addr = mdev.m_dif->off + mdev.m_pa;
 		if (flags & IOMAP_DAX)
 			iomap->addr += mdev.m_dif->dax_part_off;
 	}
diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index 60c7cc4c105c..a2c7001ff789 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -147,7 +147,8 @@ static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
 				if (err)
 					break;
 				io->rq = erofs_fileio_rq_alloc(&io->dev);
-				io->rq->bio.bi_iter.bi_sector = io->dev.m_pa >> 9;
+				io->rq->bio.bi_iter.bi_sector =
+					(io->dev.m_dif->off + io->dev.m_pa) >> 9;
 				attached = 0;
 			}
 			if (!bio_add_folio(&io->rq->bio, folio, len, cur))
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4ac188d5d894..cd8c738f5eb8 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -43,6 +43,7 @@ struct erofs_device_info {
 	char *path;
 	struct erofs_fscache *fscache;
 	struct file *file;
+	u64 off;
 	struct dax_device *dax_dev;
 	u64 dax_part_off;
 
@@ -199,6 +200,7 @@ enum {
 struct erofs_buf {
 	struct address_space *mapping;
 	struct file *file;
+	u64 off;
 	struct page *page;
 	void *base;
 };
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index da6ee7c39290..512877d7d855 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -356,7 +356,7 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
 
 enum {
 	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
-	Opt_device, Opt_fsid, Opt_domain_id, Opt_directio,
+	Opt_device, Opt_fsid, Opt_domain_id, Opt_directio, Opt_fsoffset,
 };
 
 static const struct constant_table erofs_param_cache_strategy[] = {
@@ -383,6 +383,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
 	fsparam_string("fsid",		Opt_fsid),
 	fsparam_string("domain_id",	Opt_domain_id),
 	fsparam_flag_no("directio",	Opt_directio),
+	fsparam_u64("fsoffset",		Opt_fsoffset),
 	{}
 };
 
@@ -506,6 +507,9 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		errorfc(fc, "%s option not supported", erofs_fs_parameters[opt].name);
 #endif
 		break;
+	case Opt_fsoffset:
+		sbi->dif0.off = result.uint_64;
+		break;
 	}
 	return 0;
 }
@@ -599,6 +603,10 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 				&sbi->dif0.dax_part_off, NULL, NULL);
 	}
 
+	if (sbi->dif0.off & ((1 << sbi->blkszbits) - 1))
+		return invalfc(fc, "fsoffset %lld not aligned to block size",
+			       sbi->dif0.off);
+
 	err = erofs_read_superblock(sb);
 	if (err)
 		return err;
@@ -947,6 +955,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
 	if (sbi->domain_id)
 		seq_printf(seq, ",domain_id=%s", sbi->domain_id);
 #endif
+	if (sbi->dif0.off)
+		seq_printf(seq, ",fsoffset=%lld", sbi->dif0.off);
 	return 0;
 }
 
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index b8e6b76c23d5..4f910d7ffb2f 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1707,7 +1707,8 @@ static void z_erofs_submit_queue(struct z_erofs_frontend *f,
 					bio = bio_alloc(mdev.m_bdev, BIO_MAX_VECS,
 							REQ_OP_READ, GFP_NOIO);
 				bio->bi_end_io = z_erofs_endio;
-				bio->bi_iter.bi_sector = cur >> 9;
+				bio->bi_iter.bi_sector =
+						(mdev.m_dif->off + cur) >> 9;
 				bio->bi_private = q[JQ_SUBMIT];
 				if (readahead)
 					bio->bi_opf |= REQ_RAHEAD;
-- 
2.43.0


