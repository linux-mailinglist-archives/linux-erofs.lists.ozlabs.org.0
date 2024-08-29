Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 504DB964047
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Aug 2024 11:36:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wvbl91LWvz30TQ
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Aug 2024 19:36:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724924193;
	cv=none; b=iKDO1qmZyEJp4oY+7yVbWChE0/nqUt3Iye6jqxt4oOuG5toSL3gQRMNdQZrgve8a31sGGryZ1mkNpJrftDbV7uxLOZiDM1imAxvTO8CDFEYOyJLke6kBgovsmN080h6L5G+bbHRz5qi5WAnIN3DNNwOKI6rioYMPuETb7/d3Hc4gm8lnrfTB8ce0gkQLLEyVpPJFqGZ0DpINi10UGbfnt/vL4MBd9frl/tLNFc23lzhLuyoqNmf8aOSdOO1celUr7o8Lt+3UpNrz9ok2QzorW/ToWgEA2TnmSr99GHsfzk7HpgThYSCn3Zb8yQsEhIVJcGXERwZjS6CSTWl2/Rbl5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724924193; c=relaxed/relaxed;
	bh=WFALRtmc27/bRzAmppskIsqzQWQtld5IICtjifhlIPM=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=K6sezKMhn/xLT2DCFDvV0MtRT4HG+GjZsvYlSHPETFn3EGYGb7Mdgvgw7s2/+Gk5MzIajBsMPB1cCBfwaiD+91CHd+6wY2d0v5rJTDOGBSBwm2Kt+gOtIKvOvhnwP/AlKvku8t4nT5y+IkOL9UlARlYs3hlJBA5CM9Paw9qUH9cDDYlsQNWMluSGiWSLZCqQvNr83UHXxVBsX1sJnXMao3td6CG1c/RyJUSK/ZEh1c58hMlUjXRbcdc7WX2AuUk8eC3ZGu1vbeuq+TVMm0SyYtqcikaB0d+gzlT57p+ewnE2i8Ie6aZHSKJ24TpcAki+p17OPPaPw4XzpTaRJBFngg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Gpw5Ch0n; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Gpw5Ch0n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wvbl44KSnz2ynr
	for <linux-erofs@lists.ozlabs.org>; Thu, 29 Aug 2024 19:36:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724924188; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=WFALRtmc27/bRzAmppskIsqzQWQtld5IICtjifhlIPM=;
	b=Gpw5Ch0nkgsUe2jE7ioAE1giPRDYc6XQ12WKfHERGPzmeE+XyoNO+30Rs+nmV2x3As7/2OqdcroXBQgeMXHXVG5/lzsvOjDzwNqAwR2iqPfLPS7gQ9zM0GLCDRfc11JPU8PiQtNe1/VTGKgzjEwYq1fH3LniVmdUOJ5M/RDTH+w=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WDsbb.e_1724924186)
          by smtp.aliyun-inc.com;
          Thu, 29 Aug 2024 17:36:27 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH RESEND 2/4] erofs: support unencoded inodes for fileio
Date: Thu, 29 Aug 2024 17:36:15 +0800
Message-ID: <20240829093617.2396538-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240829093617.2396538-1-hsiangkao@linux.alibaba.com>
References: <20240829092614.2382457-1-hsiangkao@linux.alibaba.com>
 <20240829093617.2396538-1-hsiangkao@linux.alibaba.com>
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
 fs/erofs/data.c     |  50 ++++++++++++-
 fs/erofs/fileio.c   | 179 ++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/inode.c    |  17 +++--
 fs/erofs/internal.h |   7 +-
 fs/erofs/zdata.c    |  46 ++----------
 6 files changed, 249 insertions(+), 51 deletions(-)
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
index 0fb31c588ae0..b4c07ce7a294 100644
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
@@ -250,6 +256,42 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 	return 0;
 }
 
+/*
+ * bit 30: I/O error occurred on this folio
+ * bit 0 - 29: remaining parts to complete this folio
+ */
+#define EROFS_ONLINEFOLIO_EIO			(1 << 30)
+
+void erofs_onlinefolio_init(struct folio *folio)
+{
+	union {
+		atomic_t o;
+		void *v;
+	} u = { .o = ATOMIC_INIT(1) };
+
+	folio->private = u.v;	/* valid only if file-backed folio is locked */
+}
+
+void erofs_onlinefolio_split(struct folio *folio)
+{
+	atomic_inc((atomic_t *)&folio->private);
+}
+
+void erofs_onlinefolio_end(struct folio *folio, int err)
+{
+	int orig, v;
+
+	do {
+		orig = atomic_read((atomic_t *)&folio->private);
+		v = (orig - 1) | (err ? EROFS_ONLINEFOLIO_EIO : 0);
+	} while (atomic_cmpxchg((atomic_t *)&folio->private, orig, v) != orig);
+
+	if (v & ~EROFS_ONLINEFOLIO_EIO)
+		return;
+	folio->private = 0;
+	folio_end_read(folio, !(v & EROFS_ONLINEFOLIO_EIO));
+}
+
 static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
 {
@@ -399,7 +441,7 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
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
index 9bf4fb1cfa09..9bc4dcfd06d7 100644
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
 
@@ -411,6 +413,9 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *dev);
 int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		 u64 start, u64 len);
 int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map);
+void erofs_onlinefolio_init(struct folio *folio);
+void erofs_onlinefolio_split(struct folio *folio);
+void erofs_onlinefolio_end(struct folio *folio, int err);
 struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid);
 int erofs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		  struct kstat *stat, u32 request_mask,
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 424f656cd765..350612f32ac6 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -122,42 +122,6 @@ static bool erofs_folio_is_managed(struct erofs_sb_info *sbi, struct folio *fo)
 	return fo->mapping == MNGD_MAPPING(sbi);
 }
 
-/*
- * bit 30: I/O error occurred on this folio
- * bit 0 - 29: remaining parts to complete this folio
- */
-#define Z_EROFS_FOLIO_EIO			(1 << 30)
-
-static void z_erofs_onlinefolio_init(struct folio *folio)
-{
-	union {
-		atomic_t o;
-		void *v;
-	} u = { .o = ATOMIC_INIT(1) };
-
-	folio->private = u.v;	/* valid only if file-backed folio is locked */
-}
-
-static void z_erofs_onlinefolio_split(struct folio *folio)
-{
-	atomic_inc((atomic_t *)&folio->private);
-}
-
-static void z_erofs_onlinefolio_end(struct folio *folio, int err)
-{
-	int orig, v;
-
-	do {
-		orig = atomic_read((atomic_t *)&folio->private);
-		v = (orig - 1) | (err ? Z_EROFS_FOLIO_EIO : 0);
-	} while (atomic_cmpxchg((atomic_t *)&folio->private, orig, v) != orig);
-
-	if (v & ~Z_EROFS_FOLIO_EIO)
-		return;
-	folio->private = 0;
-	folio_end_read(folio, !(v & Z_EROFS_FOLIO_EIO));
-}
-
 #define Z_EROFS_ONSTACK_PAGES		32
 
 /*
@@ -965,7 +929,7 @@ static int z_erofs_scan_folio(struct z_erofs_decompress_frontend *f,
 	int err = 0;
 
 	tight = (bs == PAGE_SIZE);
-	z_erofs_onlinefolio_init(folio);
+	erofs_onlinefolio_init(folio);
 	do {
 		if (offset + end - 1 < map->m_la ||
 		    offset + end - 1 >= map->m_la + map->m_llen) {
@@ -1024,7 +988,7 @@ static int z_erofs_scan_folio(struct z_erofs_decompress_frontend *f,
 			if (err)
 				break;
 
-			z_erofs_onlinefolio_split(folio);
+			erofs_onlinefolio_split(folio);
 			if (f->pcl->pageofs_out != (map->m_la & ~PAGE_MASK))
 				f->pcl->multibases = true;
 			if (f->pcl->length < offset + end - map->m_la) {
@@ -1044,7 +1008,7 @@ static int z_erofs_scan_folio(struct z_erofs_decompress_frontend *f,
 			tight = (bs == PAGE_SIZE);
 		}
 	} while ((end = cur) > 0);
-	z_erofs_onlinefolio_end(folio, err);
+	erofs_onlinefolio_end(folio, err);
 	return err;
 }
 
@@ -1147,7 +1111,7 @@ static void z_erofs_fill_other_copies(struct z_erofs_decompress_backend *be,
 			cur += len;
 		}
 		kunmap_local(dst);
-		z_erofs_onlinefolio_end(page_folio(bvi->bvec.page), err);
+		erofs_onlinefolio_end(page_folio(bvi->bvec.page), err);
 		list_del(p);
 		kfree(bvi);
 	}
@@ -1302,7 +1266,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 
 		DBG_BUGON(z_erofs_page_is_invalidated(page));
 		if (!z_erofs_is_shortlived_page(page)) {
-			z_erofs_onlinefolio_end(page_folio(page), err);
+			erofs_onlinefolio_end(page_folio(page), err);
 			continue;
 		}
 		if (pcl->algorithmformat != Z_EROFS_COMPRESSION_LZ4) {
-- 
2.43.5

