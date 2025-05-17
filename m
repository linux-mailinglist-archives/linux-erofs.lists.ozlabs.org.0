Return-Path: <linux-erofs+bounces-339-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F15ABA90D
	for <lists+linux-erofs@lfdr.de>; Sat, 17 May 2025 11:06:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zzyjt1Ggkz2yD5;
	Sat, 17 May 2025 19:06:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::430"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747472786;
	cv=none; b=oDbgSrBhdElvqjOY7WUnVYVrH1tC9nhFxT1VDXdwiskZ7IGXM3EmgQMbW74BavPgA8jsPX9pT5jEnUkkf5VD54y3egIT6oCOR5XJSUIN8ZuOFxhnLENrZTmu6aG+k/xVtZjkVSKfl0EKhGrL6h+HhLSHHiHZ1YM2NEzOsCHZLxXKC2mY7NiS4mEB7MuGP1CKGlX5XpYfuZzRtHkBUNBjG7PvQdr1ZR6l0KAmwv3ziwCfAy9zKzs6gHElqDMa1Q1eV4yUMr6beKDw9RaN7CJaF2+0+0D3Yhymx2aYi9r81/MddvDuKNDBTanMayITLIH6NR6fLZAWqY1qDALV5Aedbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747472786; c=relaxed/relaxed;
	bh=yVp51yXafG+7fe/QPMMIq7tCbx1VLjBBBUO0ljfEjpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SUGyD4ZGGprzQOkXqo4wMHVo6gFjR7+x5pZ2KBnor5GbrIFrI65IoERYu2LxYF3V5Dkuk4ny/1Zc2K2JouccgWdSnRAXU7JgGN4ird3sWAX8cNeDw4b8hyjmDqdHre9QMZAuF6FX5H6Qf+4+/nqLtOnWqFXzkVWsql2PTu+B99lLhUOciBtbyRmeLPegdqpkLsJfnBzu+vpolzx0YfynT1ZLarAUUk5dpg06q0BxeIBX1T9XDrQ2wOwpx9EnX81V1t/MrJBZmLir3eoaO48wxefmRbS7BI6H5zo4dLaz8SUtY64UJoThMqS0rAbfECwVYjBU//72yCI2hcIpwPOZlg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=CihQY7vL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=CihQY7vL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zzyjq23nPz2y92
	for <linux-erofs@lists.ozlabs.org>; Sat, 17 May 2025 19:06:21 +1000 (AEST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso3059142b3a.2
        for <linux-erofs@lists.ozlabs.org>; Sat, 17 May 2025 02:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747472779; x=1748077579; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yVp51yXafG+7fe/QPMMIq7tCbx1VLjBBBUO0ljfEjpI=;
        b=CihQY7vLLen1AaU0ElWWrq3PgqVYba1/UfLPWwJHl/o9PXu1koHhQPTXlg7pnj1wTb
         hjnev/Jd4666S3PEkGZ5FzQl/nuZXlqtfw3o38KEPg0huyMnULFVY8/hI3zX+e4pldLt
         JOqqG7xsjIJHoHEOMEuVKtR/zgtsiquN8KIGvuTur2VZ3GvCqyPS9JX9uN8/bZI5Tvzp
         /y3dI6AyOhb8g2TkNxrYafBTVL54i6EzLHufwCkmpVNShNhzA9WSFV0AJfk6IKzzMX66
         62NuRs5Un3FbBVEE+rFwQv4Tbwn+5u2RU0nhbcRJn7dKWeHXhK47/+n1/4zznTIMlaKa
         Ckcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747472779; x=1748077579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yVp51yXafG+7fe/QPMMIq7tCbx1VLjBBBUO0ljfEjpI=;
        b=dcLRPcYxuMclA5Ue+Ox+TCK2S2l7E4M9pMrmB/bp2DzNuewrS8HbmBz2lCbbrCNujc
         zBjvyQYFXRf8xkescX9vBDoVM0E6iI2Dy1h7Wqkt2k3ePlMy7ykUXB0p1028AutpZSUL
         R23Gk9516jUVY/Xz5/R00a/7Dr0+q4/6V2cTVWQtbX2TTdoPUnXxE2a3Zc9d5LzS3ha9
         f5V9RDeCTpVSDDqJ76OdQ5dZwUzMBW9OBoyB6WKmZLK/hFKhIiS8e83iZIJ7vTDmE26V
         q3PW69NrD9I72b9wTRNTQ7LwR3Weze5jv1/oydXCLTIejQmBev+Y+U7ccH/9IbS+qZJ7
         wcHg==
X-Gm-Message-State: AOJu0YxT0xZya/sSnrGrOocC4P5N0vgmQUCFgKMewX+0abd8743ppKnb
	la/sK2urEVfLBHgVwDEj7u6HGhs5O6Umwabciz5ym5T8rh8Ixp1r6DGH
X-Gm-Gg: ASbGnctfhMEjzkL3vgJeQ1IWXuDN6L20YaDMNg+TbAxm/9O15WJ2nLqXebdgJ3S4v97
	HpNWmwcEytdvqgpAG3CyZ0zdmlt5O56YfWhbJic6nj7VTbZD5JjtSvIY3PGhen/eqx9vAi+hUY3
	n+2twkHfqRPXfANCAyrpprP6prNOe4mg/pltOFCV8mXYPcmapr08cFcrUabvAJrXsybzOoIHNRb
	jBVcHxiUcZpz6Cm+y+4xW9HcjYnWOAtfllTAyyyh5eoMN8GYYfLHhsSNWjiom24fBi1REJZppJ5
	1vucKQsrHl+ePPMyEYqgiBtHTJmRW1+phMaaVGNzzfLFzKQAXNx+RKbwcg==
X-Google-Smtp-Source: AGHT+IEGm9Ou7Njj34BQFaZU42QOdBG6+5MtDk9k+e468axCOUto579Gbzympt7eZB66Y/44TUGKcQ==
X-Received: by 2002:a05:6a00:9464:b0:740:b5f9:90b4 with SMTP id d2e1a72fcca58-742a988b38amr7388205b3a.17.1747472778492;
        Sat, 17 May 2025 02:06:18 -0700 (PDT)
Received: from PC.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a97398f8sm2784020b3a.78.2025.05.17.02.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 02:06:18 -0700 (PDT)
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
Subject: [PATCH v7] erofs: add 'fsoffset' mount option to specify filesystem offset
Date: Sat, 17 May 2025 17:05:43 +0800
Message-ID: <20250517090544.2687651-1-shengyong1@xiaomi.com>
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
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Sheng Yong <shengyong1@xiaomi.com>

When attempting to use an archive file, such as APEX on android,
as a file-backed mount source, it fails because EROFS image within
the archive file does not start at offset 0. As a result, a loop
or a dm device is still needed to attach the image file at an
appropriate offset first. Similarly, if an EROFS image within a
block device does not start at offset 0, it cannot be mounted
directly either.

To address this issue, this patch adds a new mount option `fsoffset=x'
to accept a start offset for the primary device. The offset should be
aligned to the block size. EROFS will add this offset before performing
read requests.

Signed-off-by: Sheng Yong <shengyong1@xiaomi.com>
Signed-off-by: Wang Shuai <wangshuai12@xiaomi.com>
---
 Documentation/filesystems/erofs.rst |  1 +
 fs/erofs/data.c                     |  5 +++--
 fs/erofs/fileio.c                   |  3 ++-
 fs/erofs/internal.h                 |  3 ++-
 fs/erofs/super.c                    | 16 +++++++++++++++-
 fs/erofs/zdata.c                    |  3 ++-
 6 files changed, 25 insertions(+), 6 deletions(-)
---
v7: * fix documentation and some codin style
    * check alignment after erofs_read_superblock and return error in
      fscache mode
    * update commit message

v6: * fix fsoffset value type in documentation
    * change `off' type to u64
    https://lore.kernel.org/linux-erofs/6b456e0d-04cf-4ecd-a23a-e91c7d58b592@linux.alibaba.com

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
index c293f8e37468..11b0f8635f04 100644
--- a/Documentation/filesystems/erofs.rst
+++ b/Documentation/filesystems/erofs.rst
@@ -128,6 +128,7 @@ device=%s              Specify a path to an extra device to be used together.
 fsid=%s                Specify a filesystem image ID for Fscache back-end.
 domain_id=%s           Specify a domain ID in fscache mode so that different images
                        with the same blobs under a given domain ID can share storage.
+fsoffset=%lu           Specify image offset for the primary device.
 ===================    =========================================================
 
 Sysfs Entries
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 2409d2ab0c28..6a329c329f43 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -27,7 +27,7 @@ void erofs_put_metabuf(struct erofs_buf *buf)
 
 void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset, bool need_kmap)
 {
-	pgoff_t index = offset >> PAGE_SHIFT;
+	pgoff_t index = (buf->off + offset) >> PAGE_SHIFT;
 	struct folio *folio = NULL;
 
 	if (buf->page) {
@@ -54,6 +54,7 @@ void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
 	buf->file = NULL;
+	buf->off = sbi->dif0.fsoff;
 	if (erofs_is_fileio_mode(sbi)) {
 		buf->file = sbi->dif0.file;	/* some fs like FUSE needs it */
 		buf->mapping = buf->file->f_mapping;
@@ -299,7 +300,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		iomap->private = buf.base;
 	} else {
 		iomap->type = IOMAP_MAPPED;
-		iomap->addr = mdev.m_pa;
+		iomap->addr = mdev.m_dif->fsoff + mdev.m_pa;
 		if (flags & IOMAP_DAX)
 			iomap->addr += mdev.m_dif->dax_part_off;
 	}
diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index 60c7cc4c105c..fb1a01198fde 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -147,7 +147,8 @@ static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
 				if (err)
 					break;
 				io->rq = erofs_fileio_rq_alloc(&io->dev);
-				io->rq->bio.bi_iter.bi_sector = io->dev.m_pa >> 9;
+				io->rq->bio.bi_iter.bi_sector =
+					(io->dev.m_dif->fsoff + io->dev.m_pa) >> 9;
 				attached = 0;
 			}
 			if (!bio_add_folio(&io->rq->bio, folio, len, cur))
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4ac188d5d894..a32c03a80c70 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -44,7 +44,7 @@ struct erofs_device_info {
 	struct erofs_fscache *fscache;
 	struct file *file;
 	struct dax_device *dax_dev;
-	u64 dax_part_off;
+	u64 fsoff, dax_part_off;
 
 	erofs_blk_t blocks;
 	erofs_blk_t uniaddr;
@@ -199,6 +199,7 @@ enum {
 struct erofs_buf {
 	struct address_space *mapping;
 	struct file *file;
+	u64 off;
 	struct page *page;
 	void *base;
 };
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 79ab268fa57a..8dd57c272014 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -359,7 +359,7 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
 
 enum {
 	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
-	Opt_device, Opt_fsid, Opt_domain_id, Opt_directio,
+	Opt_device, Opt_fsid, Opt_domain_id, Opt_directio, Opt_fsoffset,
 };
 
 static const struct constant_table erofs_param_cache_strategy[] = {
@@ -386,6 +386,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
 	fsparam_string("fsid",		Opt_fsid),
 	fsparam_string("domain_id",	Opt_domain_id),
 	fsparam_flag_no("directio",	Opt_directio),
+	fsparam_u64("fsoffset",		Opt_fsoffset),
 	{}
 };
 
@@ -509,6 +510,9 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		errorfc(fc, "%s option not supported", erofs_fs_parameters[opt].name);
 #endif
 		break;
+	case Opt_fsoffset:
+		sbi->dif0.fsoff = result.uint_64;
+		break;
 	}
 	return 0;
 }
@@ -621,6 +625,14 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 		}
 	}
 
+	if (sbi->dif0.fsoff) {
+		if (sbi->dif0.fsoff & ((1 << sbi->blkszbits) - 1))
+			return invalfc(fc, "fsoffset %llu not aligned to block size",
+				       sbi->dif0.fsoff);
+		if (erofs_is_fscache_mode(sb))
+			return invalfc(fc, "cannot use fsoffset in fscache mode");
+	}
+
 	if (test_opt(&sbi->opt, DAX_ALWAYS)) {
 		if (!sbi->dif0.dax_dev) {
 			errorfc(fc, "DAX unsupported by block device. Turning off DAX.");
@@ -950,6 +962,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
 	if (sbi->domain_id)
 		seq_printf(seq, ",domain_id=%s", sbi->domain_id);
 #endif
+	if (sbi->dif0.fsoff)
+		seq_printf(seq, ",fsoffset=%llu", sbi->dif0.fsoff);
 	return 0;
 }
 
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index b8e6b76c23d5..4f34b63d026e 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1707,7 +1707,8 @@ static void z_erofs_submit_queue(struct z_erofs_frontend *f,
 					bio = bio_alloc(mdev.m_bdev, BIO_MAX_VECS,
 							REQ_OP_READ, GFP_NOIO);
 				bio->bi_end_io = z_erofs_endio;
-				bio->bi_iter.bi_sector = cur >> 9;
+				bio->bi_iter.bi_sector =
+						(mdev.m_dif->fsoff + cur) >> 9;
 				bio->bi_private = q[JQ_SUBMIT];
 				if (readahead)
 					bio->bi_opf |= REQ_RAHEAD;
-- 
2.43.0


