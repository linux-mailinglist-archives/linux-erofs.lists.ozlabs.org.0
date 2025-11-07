Return-Path: <linux-erofs+bounces-1354-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B97C3F509
	for <lists+linux-erofs@lfdr.de>; Fri, 07 Nov 2025 11:06:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d2vpm1cbgz3bs7;
	Fri,  7 Nov 2025 21:06:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762509984;
	cv=none; b=mOO71ET/H5IaHU5WymwhEsGzsn/JY6gs63N2MpmfwiLM9RDVtoAX+tXjibt1iGOWyPU/HJYTmfaY2piHW43mW1Tk31XVDmOROGVUN0OpiJJkMdLmI5WFHDVKgJF/fU4HzKHU2LMEVyDZas0uD3iXIIpVZy0HZUldJr9C3LHsTJCStvg60q9Bq6F0eI9HKS3/JjqkwuJ1HAKuWxdIa/ExnqyBgcZnXuIrTNuSk+Vjgf5BMULD0Ieu/JTBVLoqbmo1HBCyk+pq2Q9ShR/7FHkaJZAjgmghMvWn94kbjfeOISf8JOq4P322iD029hGwylHUkmbmEdly6BT+gnRvy4Qpgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762509984; c=relaxed/relaxed;
	bh=SaJQy+736qNgEkzv9V0UXVRVawGUIluwqy/4//0esPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ev20WA+Odsurp91d+Tcd0JSYqlpistxT4MtnPfCGXICC5Ha21uREdyhtpwmX+oEKPamNLX5h5hiKCezPyKnVSVcm4G0LR7CrBum14OdC8FyE5TxiPRqSf4oJzsa0h1sW06CbtMC/xapTDBmfaFkQjySEQyW9hGktKu6uKuUaNgvTvlirCsRascUKyAY/jz8IePYIUXIkYGtPNKzAHTf5h5jdz8i1x1PaUHHpwpybDu4tZEWU9+LN2Ma2zAEuNYFoDKvHmy409Cb1Xqf8yLH0fsbWym/jsOZDQHE9z8tffr6Rfy+bsLCpZRtzfQAFZyr+BXl003Bs5NLS3DMPVJI7OQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pkeFyRZO; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pkeFyRZO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d2vpj5kCVz2yrF
	for <linux-erofs@lists.ozlabs.org>; Fri,  7 Nov 2025 21:06:21 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762509977; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=SaJQy+736qNgEkzv9V0UXVRVawGUIluwqy/4//0esPE=;
	b=pkeFyRZOVWukZoRqnLpY7OaMJZ92DEaOGQvmv7hA6RS39I8xY1WgjA6qkgKrgQhSynqhmXkkTxrmy67qCnGHdI0yX4MM/fmaCvjo3G9cVoHQYpzn1XHoOeatX6jOyLD62yFbPRUs8+L5eqoniOVXN1ZESLs384weNsGvy6l1T5I=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WrsiSWy_1762509975 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 07 Nov 2025 18:06:16 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Hongbo Li <lihongbo22@huawei.com>
Subject: [PATCH 3/3] erofs-utils: mkfs: add optional support for inode meta zone
Date: Fri,  7 Nov 2025 18:06:09 +0800
Message-ID: <20251107100609.2917122-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251107100609.2917122-1-hsiangkao@linux.alibaba.com>
References: <20251107100609.2917122-1-hsiangkao@linux.alibaba.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Many use cases benefit from concentrating inode metadata, such as
image filesystems primarily accessed over a network (e.g., EROFS
native full container images).  Otherwise, scattered on-disk inodes
increase network access overhead and make metadata prefetching (so
that systems won't be stuck by metadata I/Os due to network failures,
for example) difficult to implement.

Usage:
 `--ZI` or `--ZI=1`	Enable inode meta zone;
 `--ZI=0`               Disable inode meta zone (default).

Closes: https://lore.kernel.org/r/20250422123612.261764-1-lihongbo22@huawei.com
Cc: Hongbo Li <lihongbo22@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/internal.h |  12 ++--
 lib/importer.c           |  10 ++-
 lib/inode.c              |  46 ++++++++------
 lib/liberofs_metabox.h   |  14 ++++-
 lib/metabox.c            | 127 ++++++++++++++++++++++++++++++---------
 lib/super.c              |  10 ++-
 lib/xattr.c              |   2 +-
 mkfs/main.c              |  12 +++-
 8 files changed, 168 insertions(+), 65 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 610650138bee..62594b877151 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -97,7 +97,7 @@ struct erofs_sb_info {
 	u64 total_blocks;
 	u64 primarydevice_blocks;
 
-	u32 meta_blkaddr;
+	s32 meta_blkaddr;
 	u32 xattr_blkaddr;
 
 	u32 feature_compat;
@@ -150,7 +150,7 @@ struct erofs_sb_info {
 	struct erofs_bufmgr *bmgr;
 	struct erofs_xattrmgr *xamgr;
 	struct z_erofs_mgr *zmgr;
-	struct erofs_metaboxmgr *m2gr;
+	struct erofs_metamgr *m2gr, *mxgr;
 	struct erofs_packed_inode *packedinode;
 	struct erofs_buffer_head *bh_sb;
 	struct erofs_buffer_head *bh_devt;
@@ -309,8 +309,8 @@ static inline bool erofs_inode_in_metabox(struct erofs_inode *inode)
 static inline erofs_off_t erofs_iloc(struct erofs_inode *inode)
 {
 	struct erofs_sb_info *sbi = inode->sbi;
-	erofs_off_t base = erofs_inode_in_metabox(inode) ? 0 :
-			erofs_pos(sbi, sbi->meta_blkaddr);
+	s64 base = erofs_inode_in_metabox(inode) ? 0 :
+		(s64)erofs_pos(sbi, sbi->meta_blkaddr);
 
 	return base + ((inode->nid & EROFS_DIRENT_NID_MASK) << EROFS_ISLOTBITS);
 }
@@ -434,8 +434,8 @@ int erofs_mkfs_init_devices(struct erofs_sb_info *sbi, unsigned int devices);
 int erofs_write_device_table(struct erofs_sb_info *sbi);
 int erofs_enable_sb_chksum(struct erofs_sb_info *sbi, u32 *crc);
 int erofs_superblock_csum_verify(struct erofs_sb_info *sbi);
-int erofs_mkfs_format_fs(struct erofs_sb_info *sbi,
-			 unsigned int blkszbits, unsigned int dsunit);
+int erofs_mkfs_format_fs(struct erofs_sb_info *sbi, unsigned int blkszbits,
+			 unsigned int dsunit, bool metazone);
 int erofs_mkfs_load_fs(struct erofs_sb_info *sbi, unsigned int dsunit);
 
 /* namei.c */
diff --git a/lib/importer.c b/lib/importer.c
index c73dde2529b7..958a433b9eaa 100644
--- a/lib/importer.c
+++ b/lib/importer.c
@@ -69,8 +69,8 @@ int erofs_importer_init(struct erofs_importer *im)
 			goto out_err;
 	}
 
-	subsys = "metabox";
-	err = erofs_metabox_init(sbi);
+	subsys = "metadata";
+	err = erofs_metadata_init(sbi);
 	if (err)
 		goto out_err;
 
@@ -107,6 +107,10 @@ int erofs_importer_flush_all(struct erofs_importer *im)
 	if (err)
 		return err;
 
+	err = erofs_metazone_flush(sbi);
+	if (err)
+		return err;
+
 	fsalignblks = im->params->fsalignblks ?
 		roundup_pow_of_two(im->params->fsalignblks) : 1;
 	sbi->primarydevice_blocks = roundup(erofs_mapbh(sbi->bmgr, NULL),
@@ -128,6 +132,6 @@ void erofs_importer_exit(struct erofs_importer *im)
 	struct erofs_sb_info *sbi = im->sbi;
 
 	z_erofs_dedupe_ext_exit();
-	erofs_metabox_exit(sbi);
+	erofs_metadata_exit(sbi);
 	erofs_packedfile_exit(sbi);
 }
diff --git a/lib/inode.c b/lib/inode.c
index 09b2e507c609..64f6bc34610f 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -376,18 +376,19 @@ erofs_nid_t erofs_lookupnid(struct erofs_inode *inode)
 {
 	struct erofs_buffer_head *const bh = inode->bh;
 	struct erofs_sb_info *sbi = inode->sbi;
-	erofs_off_t off, meta_offset;
+	erofs_off_t off;
+	s64 meta_offset;
 	erofs_nid_t nid;
 
 	if (bh && inode->nid == EROFS_NID_UNALLOCATED) {
 		erofs_mapbh(NULL, bh->block);
 		off = erofs_btell(bh, false);
 
-		if (!inode->in_metabox) {
-			meta_offset = erofs_pos(sbi, sbi->meta_blkaddr);
-			DBG_BUGON(off < meta_offset);
-		} else {
+		if (inode->in_metabox) {
 			meta_offset = 0;
+		} else {
+			meta_offset = (s64)erofs_pos(sbi, sbi->meta_blkaddr);
+			DBG_BUGON(off < meta_offset && !sbi->m2gr);
 		}
 
 		nid = (off - meta_offset) >> EROFS_ISLOTBITS;
@@ -718,8 +719,8 @@ int erofs_iflush(struct erofs_inode *inode)
 	struct erofs_sb_info *sbi = inode->sbi;
 	struct erofs_buffer_head *bh = inode->bh;
 	erofs_off_t off = erofs_iloc(inode);
-	struct erofs_bufmgr *ibmgr = inode->in_metabox ?
-				erofs_metabox_bmgr(sbi) : sbi->bmgr;
+	struct erofs_bufmgr *ibmgr =
+		erofs_metadata_bmgr(sbi, inode->in_metabox) ?: sbi->bmgr;
 	union {
 		struct erofs_inode_compact dic;
 		struct erofs_inode_extended die;
@@ -921,12 +922,9 @@ static int erofs_prepare_inode_buffer(struct erofs_importer *im,
 	if (inode->extent_isize)
 		inodesize = roundup(inodesize, 8) + inode->extent_isize;
 
-	if (!erofs_is_special_identifier(inode->i_srcpath) &&
-	    erofs_metabox_bmgr(sbi))
+	if (!erofs_is_special_identifier(inode->i_srcpath) && sbi->mxgr)
 		inode->in_metabox = true;
-
-	if (inode->in_metabox)
-		ibmgr = erofs_metabox_bmgr(sbi) ?: sbi->bmgr;
+	ibmgr = erofs_metadata_bmgr(sbi, inode->in_metabox) ?: sbi->bmgr;
 
 	if (inode->datalayout == EROFS_INODE_FLAT_PLAIN)
 		goto noinline;
@@ -1000,8 +998,8 @@ static int erofs_bh_flush_write_inline(struct erofs_buffer_head *bh)
 {
 	struct erofs_inode *const inode = bh->fsprivate;
 	struct erofs_sb_info *sbi = inode->sbi;
-	struct erofs_bufmgr *ibmgr = inode->in_metabox ?
-				erofs_metabox_bmgr(sbi) : sbi->bmgr;
+	struct erofs_bufmgr *ibmgr =
+		erofs_metadata_bmgr(sbi, inode->in_metabox) ?: sbi->bmgr;
 	const erofs_off_t off = erofs_btell(bh, false);
 	int ret;
 
@@ -1360,21 +1358,29 @@ static void erofs_fixup_meta_blkaddr(struct erofs_inode *root)
 	const erofs_off_t rootnid_maxoffset = 0xffff << EROFS_ISLOTBITS;
 	struct erofs_buffer_head *const bh = root->bh;
 	struct erofs_sb_info *sbi = root->sbi;
-	erofs_off_t meta_offset = 0;
+	int bsz = erofs_blksiz(sbi);
+	int meta_offset;
 	erofs_off_t off;
 
 	erofs_mapbh(NULL, bh->block);
 	off = erofs_btell(bh, false);
-	if (!root->in_metabox && off > rootnid_maxoffset)
-		meta_offset = round_up(off - rootnid_maxoffset,
-				       erofs_blksiz(sbi));
-	else if (root->in_metabox && !erofs_sb_has_48bit(sbi)) {
+	if (!root->in_metabox) {
+		if (!off) {
+			DBG_BUGON(!sbi->m2gr);
+			DBG_BUGON(sbi->meta_blkaddr != -1);
+			meta_offset = -bsz;	/* avoid NID 0 */
+		} else if (off > rootnid_maxoffset) {
+			meta_offset = round_up(off - rootnid_maxoffset, bsz);
+			sbi->meta_blkaddr = erofs_blknr(sbi, meta_offset);
+		} else {
+			meta_offset = 0;
+		}
+	} else if (!erofs_sb_has_48bit(sbi)) {
 		sbi->build_time = sbi->epoch;
 		sbi->epoch = max_t(s64, 0, (s64)sbi->build_time - UINT32_MAX);
 		sbi->build_time -= sbi->epoch;
 		erofs_sb_set_48bit(sbi);
 	}
-	sbi->meta_blkaddr = erofs_blknr(sbi, meta_offset);
 	root->nid = ((off - meta_offset) >> EROFS_ISLOTBITS) |
 		((u64)root->in_metabox << EROFS_DIRENT_NID_METABOX_BIT);
 }
diff --git a/lib/liberofs_metabox.h b/lib/liberofs_metabox.h
index d8896c01c298..bf4051cf18e2 100644
--- a/lib/liberofs_metabox.h
+++ b/lib/liberofs_metabox.h
@@ -4,6 +4,8 @@
 
 #include "erofs/internal.h"
 
+#define EROFS_META_NEW_ADDR	((u32)-1ULL)
+
 extern const char *erofs_metabox_identifier;
 #define EROFS_METABOX_INODE	erofs_metabox_identifier
 
@@ -12,11 +14,17 @@ static inline bool erofs_is_metabox_inode(struct erofs_inode *inode)
 	return inode->i_srcpath == EROFS_METABOX_INODE;
 }
 
+static inline bool erofs_has_meta_zone(struct erofs_sb_info *sbi)
+{
+	return sbi->m2gr || sbi->meta_blkaddr == EROFS_META_NEW_ADDR;
+}
+
 struct erofs_importer;
 
-void erofs_metabox_exit(struct erofs_sb_info *sbi);
-int erofs_metabox_init(struct erofs_sb_info *sbi);
-struct erofs_bufmgr *erofs_metabox_bmgr(struct erofs_sb_info *sbi);
+void erofs_metadata_exit(struct erofs_sb_info *sbi);
+int erofs_metadata_init(struct erofs_sb_info *sbi);
+struct erofs_bufmgr *erofs_metadata_bmgr(struct erofs_sb_info *sbi, bool mbox);
 int erofs_metabox_iflush(struct erofs_importer *im);
+int erofs_metazone_flush(struct erofs_sb_info *sbi);
 
 #endif
diff --git a/lib/metabox.c b/lib/metabox.c
index bf188f6db0f5..37267ddb73cf 100644
--- a/lib/metabox.c
+++ b/lib/metabox.c
@@ -2,81 +2,152 @@
 #include <stdlib.h>
 #include "erofs/inode.h"
 #include "erofs/importer.h"
+#include "erofs/print.h"
 #include "liberofs_cache.h"
 #include "liberofs_private.h"
 #include "liberofs_metabox.h"
 
 const char *erofs_metabox_identifier = "metabox";
 
-struct erofs_metaboxmgr {
+struct erofs_metamgr {
 	struct erofs_vfile vf;
 	struct erofs_bufmgr *bmgr;
 };
 
-void erofs_metabox_exit(struct erofs_sb_info *sbi)
+static void erofs_metamgr_exit(struct erofs_metamgr *m2gr)
 {
-	struct erofs_metaboxmgr *m2gr = sbi->m2gr;
-
-	if (!m2gr)
-		return;
 	DBG_BUGON(!m2gr->bmgr);
 	erofs_buffer_exit(m2gr->bmgr);
 	erofs_io_close(&m2gr->vf);
 	free(m2gr);
 }
-
-int erofs_metabox_init(struct erofs_sb_info *sbi)
+static int erofs_metamgr_init(struct erofs_sb_info *sbi,
+			      struct erofs_metamgr *m2gr)
 {
-	struct erofs_metaboxmgr *m2gr;
 	int ret;
 
-	if (!erofs_sb_has_metabox(sbi))
-		return 0;
-
-	m2gr = malloc(sizeof(*m2gr));
-	if (!m2gr)
-		return -ENOMEM;
-
 	ret = erofs_tmpfile();
 	if (ret < 0)
-		goto out_err;
+		return ret;
 
 	m2gr->vf = (struct erofs_vfile){ .fd = ret };
 	m2gr->bmgr = erofs_buffer_init(sbi, 0, &m2gr->vf);
-	if (m2gr->bmgr) {
+	if (!m2gr->bmgr)
+		return -ENOMEM;
+	return 0;
+}
+
+void erofs_metadata_exit(struct erofs_sb_info *sbi)
+{
+	if (sbi->m2gr) {
+		erofs_metamgr_exit(sbi->m2gr);
+		sbi->m2gr = NULL;
+	}
+	if (sbi->mxgr) {
+		erofs_metamgr_exit(sbi->mxgr);
+		sbi->mxgr = NULL;
+	}
+}
+
+int erofs_metadata_init(struct erofs_sb_info *sbi)
+{
+	struct erofs_metamgr *m2gr;
+	int ret;
+
+	if (!sbi->m2gr && sbi->meta_blkaddr == EROFS_META_NEW_ADDR) {
+		m2gr = malloc(sizeof(*m2gr));
+		if (!m2gr)
+			return -ENOMEM;
+		ret = erofs_metamgr_init(sbi, m2gr);
+		if (ret)
+			goto err_free;
 		sbi->m2gr = m2gr;
-		return 0;
 	}
-	ret = -ENOMEM;
-out_err:
+
+	if (!sbi->mxgr && erofs_sb_has_metabox(sbi)) {
+		m2gr = malloc(sizeof(*m2gr));
+		if (!m2gr)
+			return -ENOMEM;
+		ret = erofs_metamgr_init(sbi, m2gr);
+		if (ret)
+			goto err_free;
+		sbi->mxgr = m2gr;
+	}
+	return 0;
+err_free:
 	free(m2gr);
 	return ret;
 }
 
-struct erofs_bufmgr *erofs_metabox_bmgr(struct erofs_sb_info *sbi)
+struct erofs_bufmgr *erofs_metadata_bmgr(struct erofs_sb_info *sbi, bool mbox)
 {
-	return sbi->m2gr ? sbi->m2gr->bmgr : NULL;
+	if (mbox) {
+		if (sbi->mxgr)
+			return sbi->mxgr->bmgr;
+	} else if (sbi->m2gr) {
+		return sbi->m2gr->bmgr;
+	}
+	return NULL;
 }
 
 int erofs_metabox_iflush(struct erofs_importer *im)
 {
 	struct erofs_sb_info *sbi = im->sbi;
-	struct erofs_metaboxmgr *m2gr = sbi->m2gr;
+	struct erofs_metamgr *mxgr = sbi->mxgr;
 	struct erofs_inode *inode;
 	int err;
 
-	if (!m2gr || !erofs_sb_has_metabox(sbi))
+	if (!mxgr || !erofs_sb_has_metabox(sbi))
 		return -EINVAL;
 
-	err = erofs_bflush(m2gr->bmgr, NULL);
+	err = erofs_bflush(mxgr->bmgr, NULL);
 	if (err)
 		return err;
 
-	if (erofs_io_lseek(&m2gr->vf, 0, SEEK_END) <= 0)
+	if (erofs_io_lseek(&mxgr->vf, 0, SEEK_END) <= 0)
 		return 0;
-	inode = erofs_mkfs_build_special_from_fd(im, m2gr->vf.fd,
+	inode = erofs_mkfs_build_special_from_fd(im, mxgr->vf.fd,
 						 EROFS_METABOX_INODE);
 	sbi->metabox_nid = erofs_lookupnid(inode);
 	erofs_iput(inode);
 	return 0;
 }
+
+int erofs_metazone_flush(struct erofs_sb_info *sbi)
+{
+	struct erofs_metamgr *m2gr = sbi->m2gr;
+	struct erofs_buffer_head *bh;
+	struct erofs_bufmgr *m2bgr;
+	erofs_blk_t meta_blkaddr;
+	u64 length, pos_out;
+	int ret, count;
+
+	if (!m2gr)
+		return 0;
+	m2bgr = m2gr->bmgr;
+
+	ret = erofs_bflush(m2bgr, NULL);
+	if (ret)
+		return ret;
+
+	length = erofs_mapbh(m2bgr, NULL) << sbi->blkszbits;
+	bh = erofs_balloc(sbi->bmgr, DATA, length, 0);
+	if (!bh)
+		return PTR_ERR(bh);
+
+	erofs_mapbh(NULL, bh->block);
+	pos_out = erofs_btell(bh, false);
+	meta_blkaddr = pos_out >> sbi->blkszbits;
+	do {
+		count = min_t(erofs_off_t, length, INT_MAX);
+		ret = erofs_io_xcopy(sbi->bmgr->vf, pos_out,
+				     &m2gr->vf, count, false);
+		if (ret < 0)
+			break;
+		pos_out += count;
+	} while (length -= count);
+	bh->op = &erofs_drop_directly_bhops;
+	erofs_bdrop(bh, false);
+	sbi->meta_blkaddr += meta_blkaddr;
+	return 0;
+}
diff --git a/lib/super.c b/lib/super.c
index 9760265aa754..d626c7cdc76f 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -8,6 +8,7 @@
 #include "erofs/xattr.h"
 #include "liberofs_cache.h"
 #include "liberofs_compress.h"
+#include "liberofs_metabox.h"
 
 static bool check_layout_compatibility(struct erofs_sb_info *sbi,
 				       struct erofs_super_block *dsb)
@@ -418,8 +419,8 @@ out:
 	return 0;
 }
 
-int erofs_mkfs_format_fs(struct erofs_sb_info *sbi,
-			 unsigned int blkszbits, unsigned int dsunit)
+int erofs_mkfs_format_fs(struct erofs_sb_info *sbi, unsigned int blkszbits,
+			 unsigned int dsunit, bool metazone)
 {
 	struct erofs_buffer_head *bh;
 	struct erofs_bufmgr *bmgr;
@@ -430,7 +431,10 @@ int erofs_mkfs_format_fs(struct erofs_sb_info *sbi,
 		return -ENOMEM;
 	sbi->bmgr = bmgr;
 	bmgr->dsunit = dsunit;
-
+	if (metazone)
+		sbi->meta_blkaddr = EROFS_META_NEW_ADDR;
+	else
+		sbi->meta_blkaddr = 0;
 	bh = erofs_reserve_sb(bmgr);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
diff --git a/lib/xattr.c b/lib/xattr.c
index fc22c817f136..8f0332b44a02 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -828,7 +828,7 @@ int erofs_xattr_flush_name_prefixes(struct erofs_importer *im, bool plain)
 
 	if (!plain) {
 		if (erofs_sb_has_metabox(sbi)) {
-			bmgr = erofs_metabox_bmgr(sbi);
+			bmgr = erofs_metadata_bmgr(sbi, true);
 			vf = bmgr->vf;
 		} else if (may_fragments) {
 			erofs_sb_set_fragments(sbi);
diff --git a/mkfs/main.c b/mkfs/main.c
index 4de298b6dedd..76bf84348364 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -101,6 +101,7 @@ static struct option long_options[] = {
 	{"oci", optional_argument, NULL, 534},
 #endif
 	{"zD", optional_argument, NULL, 536},
+	{"ZI", optional_argument, NULL, 537},
 	{0, 0, 0, 0},
 };
 
@@ -176,6 +177,7 @@ static void usage(int argc, char **argv)
 		"    --mkfs-time        the timestamp is applied as build time only\n"
 		" -UX                   use a given filesystem UUID\n"
 		" --zD[=<0|1>]          specify directory compression: 0=disable [default], 1=enable\n"
+		" --ZI[=<0|1>]          specify the separate inode metadata zone availability: 0=disable [default], 1=enable\n"
 		" --all-root            make all files owned by root\n"
 #ifdef EROFS_MT_ENABLED
 		" --async-queue-limit=# specify the maximum number of entries in the multi-threaded job queue\n"
@@ -269,6 +271,7 @@ static void version(void)
 static struct erofsmkfs_cfg {
 	/* < 0, xattr disabled and >= INT_MAX, always use inline xattrs */
 	long inlinexattr_tolerance;
+	bool inode_metazone;
 } mkfscfg = {
 	.inlinexattr_tolerance = 2,
 };
@@ -1412,6 +1415,12 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 			else
 				params->compress_dir = false;
 			break;
+		case 537:
+			if (!optarg || strcmp(optarg, "1"))
+				mkfscfg.inode_metazone = true;
+			else
+				mkfscfg.inode_metazone = false;
+			break;
 		case 'V':
 			version();
 			exit(0);
@@ -1787,7 +1796,8 @@ int main(int argc, char **argv)
 	}
 
 	if (!incremental_mode)
-		err = erofs_mkfs_format_fs(&g_sbi, mkfs_blkszbits, dsunit);
+		err = erofs_mkfs_format_fs(&g_sbi, mkfs_blkszbits, dsunit,
+					   mkfscfg.inode_metazone);
 	else
 		err = erofs_mkfs_load_fs(&g_sbi, dsunit);
 	if (err)
-- 
2.43.5


