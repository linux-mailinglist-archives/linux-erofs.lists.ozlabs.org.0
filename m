Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F0A963FEE
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Aug 2024 11:26:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WvbWy3Y3fz2yyb
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Aug 2024 19:26:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724923612;
	cv=none; b=bKhZXrGj77cPKycuUTRHltt97m/gCiwRznRwN61JJRvagWa1y29zQv8eOKVnXPb0pz23tu43tp5W+bceqGO+aEUvub/orE/v8iOGE4ohLuJwu3Z4+X7t4rMRXz68zoEnRdjX7DWkFioFrt9hD9HgnnpmPjdgM0B7QO6t8kP7ITKxBBDHag53jUssmYlUUboJRNJk+Y7/NsA8NRuWva2UfSyYoq6nf2pdNeQSJbZhSqghI3TfxJ9KhPrcD3U57M/iwlJrYrb7TSgAsZGRqsS3GlbwLvQQCVga8z/vdXl5fsVBLpjzjddXoClAUyHE0AqBOuMNcYkWCV9UubbB21VZQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724923612; c=relaxed/relaxed;
	bh=QdXSVlGKxGxLO84ELPgVOz0iC5ufr6VpdS7SL+U2mCo=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=aI+C81nifU5dCAoD/OwjTprNwYP689uQuQRNLWVGkgZpqzjNj+fZnO48XVD/mfTiLQ7BBnBHeml9qV3zAXY3s8+90bzxNWBVkU7xo7n/yaj9bt0oV9/cdYnUUSy3IcTNiZNjq+r6Q6vUtEzD5+RJlG6IeHq3DFXJIivAEsLIvite7QXsPGKtuVOr0jW9TJCJH5tD1dNGE7VhPVc4emuIcpGkwVMhPMS2JS1dk3phF3kfbAkk82fgd59IoUv2ztenlqgEj/EPGxf3OSX6VevoUY9adP1bto8GzRv0tGsB1uHPySebyA4/DW/exFcryHUANvbyks2qbdaKL3ACj3w9eA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=oCOoki0l; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=oCOoki0l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WvbWt4bGkz2ytQ
	for <linux-erofs@lists.ozlabs.org>; Thu, 29 Aug 2024 19:26:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724923604; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=QdXSVlGKxGxLO84ELPgVOz0iC5ufr6VpdS7SL+U2mCo=;
	b=oCOoki0lilHuyU+rSMrx4J2mhR6EVYgnWunppUBtY3uOezLdDXw8Y2D/NSjYrjbeqKH6CSkCY3Cjyay3hJiixOfH6mueZLEjaBTHBuXkFlx2gi1YAfyNvq/0Afb+V1qc798A8L1c/s2uo2h4IZa4uKTSIX0zf6y3DuxzCuT5FBA=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WDsbXRF_1724923601)
          by smtp.aliyun-inc.com;
          Thu, 29 Aug 2024 17:26:42 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/4] erofs: support unencoded inodes for fileio
Date: Thu, 29 Aug 2024 17:26:12 +0800
Message-ID: <20240829092614.2382457-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240829092614.2382457-1-hsiangkao@linux.alibaba.com>
References: <20240829092614.2382457-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Since EROFS only needs to handle read requests in simple contexts,
Just directly use vfs_iocb_iter_read() for data I/Os.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/Makefile   |   1 +
 fs/erofs/data.c     |  14 +++-
 fs/erofs/fileio.c   | 179 ++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/inode.c    |  17 +++--
 fs/erofs/internal.h |   4 +-
 5 files changed, 205 insertions(+), 10 deletions(-)
 create mode 100644 fs/erofs/fileio.c

diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index 097d672e6b14..4331d53c7109 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -7,4 +7,5 @@ erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o zutil.o
 erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
 erofs-$(CONFIG_EROFS_FS_ZIP_DEFLATE) += decompressor_deflate.o
 erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
+erofs-$(CONFIG_EROFS_FS_BACKED_BY_FILE) += fileio.o
 erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 0fb31c588ae0..ee00128fd83d 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -132,7 +132,7 @@ int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
 	if (map->m_la >= inode->i_size) {
 		/* leave out-of-bound access unmapped */
 		map->m_flags = 0;
-		map->m_plen = 0;
+		map->m_plen = map->m_llen;
 		goto out;
 	}
 
@@ -197,8 +197,13 @@ static void erofs_fill_from_devinfo(struct erofs_map_dev *map,
 				    struct erofs_device_info *dif)
 {
 	map->m_bdev = NULL;
-	if (dif->file && S_ISBLK(file_inode(dif->file)->i_mode))
-		map->m_bdev = file_bdev(dif->file);
+	map->m_fp = NULL;
+	if (dif->file) {
+		if (S_ISBLK(file_inode(dif->file)->i_mode))
+			map->m_bdev = file_bdev(dif->file);
+		else
+			map->m_fp = dif->file;
+	}
 	map->m_daxdev = dif->dax_dev;
 	map->m_dax_part_off = dif->dax_part_off;
 	map->m_fscache = dif->fscache;
@@ -215,6 +220,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 	map->m_daxdev = EROFS_SB(sb)->dax_dev;
 	map->m_dax_part_off = EROFS_SB(sb)->dax_part_off;
 	map->m_fscache = EROFS_SB(sb)->s_fscache;
+	map->m_fp = EROFS_SB(sb)->fdev;
 
 	if (map->m_deviceid) {
 		down_read(&devs->rwsem);
@@ -399,7 +405,7 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 }
 
 /* for uncompressed (aligned) files and raw access for other files */
-const struct address_space_operations erofs_raw_access_aops = {
+const struct address_space_operations erofs_aops = {
 	.read_folio = erofs_read_folio,
 	.readahead = erofs_readahead,
 	.bmap = erofs_bmap,
diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
new file mode 100644
index 000000000000..6191336b42b6
--- /dev/null
+++ b/fs/erofs/fileio.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024, Alibaba Cloud
+ */
+#include "internal.h"
+#include <trace/events/erofs.h>
+
+struct erofs_fileio_rq {
+	struct bio_vec bvecs[BIO_MAX_VECS];
+	struct bio bio;
+	struct kiocb iocb;
+};
+
+struct erofs_fileio {
+	struct erofs_map_blocks map;
+	struct erofs_map_dev dev;
+	struct erofs_fileio_rq *rq;
+};
+
+static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
+{
+	struct erofs_fileio_rq *rq =
+			container_of(iocb, struct erofs_fileio_rq, iocb);
+	struct folio_iter fi;
+
+	DBG_BUGON(rq->bio.bi_end_io);
+	if (ret > 0) {
+		if (ret != rq->bio.bi_iter.bi_size) {
+			bio_advance(&rq->bio, ret);
+			zero_fill_bio(&rq->bio);
+		}
+		ret = 0;
+	}
+	bio_for_each_folio_all(fi, &rq->bio) {
+		DBG_BUGON(folio_test_uptodate(fi.folio));
+		erofs_onlinefolio_end(fi.folio, ret);
+	}
+	kfree(rq);
+}
+
+static void erofs_fileio_rq_submit(struct erofs_fileio_rq *rq)
+{
+	struct iov_iter iter;
+	int ret;
+
+	if (!rq)
+		return;
+	rq->iocb.ki_pos = rq->bio.bi_iter.bi_sector << 9;
+	rq->iocb.ki_ioprio = get_current_ioprio();
+	rq->iocb.ki_complete = erofs_fileio_ki_complete;
+	rq->iocb.ki_flags = (rq->iocb.ki_filp->f_mode & FMODE_CAN_ODIRECT) ?
+				IOCB_DIRECT : 0;
+	iov_iter_bvec(&iter, ITER_DEST, rq->bvecs, rq->bio.bi_vcnt,
+		      rq->bio.bi_iter.bi_size);
+	ret = vfs_iocb_iter_read(rq->iocb.ki_filp, &rq->iocb, &iter);
+	if (ret != -EIOCBQUEUED)
+		erofs_fileio_ki_complete(&rq->iocb, ret);
+}
+
+static struct erofs_fileio_rq *erofs_fileio_rq_alloc(struct erofs_map_dev *mdev)
+{
+	struct erofs_fileio_rq *rq = kzalloc(sizeof(*rq), GFP_KERNEL);
+
+	if (!rq)
+		return NULL;
+	bio_init(&rq->bio, NULL, rq->bvecs, BIO_MAX_VECS, REQ_OP_READ);
+	rq->iocb.ki_filp = mdev->m_fp;
+	return rq;
+}
+
+static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
+{
+	struct inode *inode = folio_inode(folio);
+	struct erofs_map_blocks *map = &io->map;
+	unsigned int cur = 0, end = folio_size(folio), len;
+	loff_t pos = folio_pos(folio), ofs;
+	struct iov_iter iter;
+	struct bio_vec bv;
+	int err = 0;
+
+	erofs_onlinefolio_init(folio);
+	while (cur < end) {
+		if (!in_range(pos + cur, map->m_la, map->m_llen)) {
+			map->m_la = pos + cur;
+			map->m_llen = end - cur;
+			err = erofs_map_blocks(inode, map);
+			if (err)
+				break;
+		}
+
+		ofs = folio_pos(folio) + cur - map->m_la;
+		len = min_t(loff_t, map->m_llen - ofs, end - cur);
+		if (map->m_flags & EROFS_MAP_META) {
+			struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
+			void *src;
+
+			src = erofs_read_metabuf(&buf, inode->i_sb,
+						 map->m_pa + ofs, EROFS_KMAP);
+			if (IS_ERR(src)) {
+				err = PTR_ERR(src);
+				break;
+			}
+			bvec_set_folio(&bv, folio, len, cur);
+			iov_iter_bvec(&iter, ITER_DEST, &bv, 1, len);
+			if (copy_to_iter(src, len, &iter) != len) {
+				erofs_put_metabuf(&buf);
+				err = -EIO;
+				break;
+			}
+			erofs_put_metabuf(&buf);
+		} else if (!(map->m_flags & EROFS_MAP_MAPPED)) {
+			folio_zero_segment(folio, cur, cur + len);
+		} else {
+			erofs_onlinefolio_split(folio);
+			if (io->rq && (map->m_pa + ofs != io->dev.m_pa ||
+				       map->m_deviceid != io->dev.m_deviceid)) {
+io_retry:
+				erofs_fileio_rq_submit(io->rq);
+				io->rq = NULL;
+			}
+
+			if (!io->rq) {
+				io->dev = (struct erofs_map_dev) {
+					.m_pa = io->map.m_pa + ofs,
+					.m_deviceid = io->map.m_deviceid,
+				};
+				err = erofs_map_dev(inode->i_sb, &io->dev);
+				if (err)
+					break;
+				io->rq = erofs_fileio_rq_alloc(&io->dev);
+				if (!io->rq) {
+					err = -ENOMEM;
+					break;
+				}
+				io->rq->bio.bi_iter.bi_sector = io->dev.m_pa >> 9;
+			}
+			if (!bio_add_folio(&io->rq->bio, folio, len, cur))
+				goto io_retry;
+			io->dev.m_pa += len;
+		}
+		cur += len;
+	}
+	erofs_onlinefolio_end(folio, err);
+	return err;
+}
+
+static int erofs_fileio_read_folio(struct file *file, struct folio *folio)
+{
+	struct erofs_fileio io = {};
+	int err;
+
+	trace_erofs_read_folio(folio, false);
+	err = erofs_fileio_scan_folio(&io, folio);
+	erofs_fileio_rq_submit(io.rq);
+	return err;
+}
+
+static void erofs_fileio_readahead(struct readahead_control *rac)
+{
+	struct inode *inode = rac->mapping->host;
+	struct erofs_fileio io = {};
+	struct folio *folio;
+	int err;
+
+	trace_erofs_readpages(inode, readahead_index(rac),
+			      readahead_count(rac), false);
+	while ((folio = readahead_folio(rac))) {
+		err = erofs_fileio_scan_folio(&io, folio);
+		if (err && err != -EINTR)
+			erofs_err(inode->i_sb, "readahead error at folio %lu @ nid %llu",
+				  folio->index, EROFS_I(inode)->nid);
+	}
+	erofs_fileio_rq_submit(io.rq);
+}
+
+const struct address_space_operations erofs_fileio_aops = {
+	.read_folio = erofs_fileio_read_folio,
+	.readahead = erofs_fileio_readahead,
+};
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index d05b9e59f122..4a902e6e69a5 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -258,11 +258,14 @@ static int erofs_fill_inode(struct inode *inode)
 	}
 
 	mapping_set_large_folios(inode->i_mapping);
-	if (erofs_is_fileio_mode(EROFS_SB(inode->i_sb))) {
-		/* XXX: data I/Os will be implemented in the following patches */
-		err = -EOPNOTSUPP;
-	} else if (erofs_inode_is_data_compressed(vi->datalayout)) {
+	if (erofs_inode_is_data_compressed(vi->datalayout)) {
 #ifdef CONFIG_EROFS_FS_ZIP
+#ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
+		if (erofs_is_fileio_mode(EROFS_SB(inode->i_sb))) {
+			err = -EOPNOTSUPP;
+			goto out_unlock;
+		}
+#endif
 		DO_ONCE_LITE_IF(inode->i_blkbits != PAGE_SHIFT,
 			  erofs_info, inode->i_sb,
 			  "EXPERIMENTAL EROFS subpage compressed block support in use. Use at your own risk!");
@@ -271,10 +274,14 @@ static int erofs_fill_inode(struct inode *inode)
 		err = -EOPNOTSUPP;
 #endif
 	} else {
-		inode->i_mapping->a_ops = &erofs_raw_access_aops;
+		inode->i_mapping->a_ops = &erofs_aops;
 #ifdef CONFIG_EROFS_FS_ONDEMAND
 		if (erofs_is_fscache_mode(inode->i_sb))
 			inode->i_mapping->a_ops = &erofs_fscache_access_aops;
+#endif
+#ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
+		if (erofs_is_fileio_mode(EROFS_SB(inode->i_sb)))
+			inode->i_mapping->a_ops = &erofs_fileio_aops;
 #endif
 	}
 out_unlock:
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 9bf4fb1cfa09..302cbb57f79a 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -372,6 +372,7 @@ struct erofs_map_dev {
 	struct erofs_fscache *m_fscache;
 	struct block_device *m_bdev;
 	struct dax_device *m_daxdev;
+	struct file *m_fp;
 	u64 m_dax_part_off;
 
 	erofs_off_t m_pa;
@@ -380,7 +381,8 @@ struct erofs_map_dev {
 
 extern const struct super_operations erofs_sops;
 
-extern const struct address_space_operations erofs_raw_access_aops;
+extern const struct address_space_operations erofs_aops;
+extern const struct address_space_operations erofs_fileio_aops;
 extern const struct address_space_operations z_erofs_aops;
 extern const struct address_space_operations erofs_fscache_access_aops;
 
-- 
2.43.5

