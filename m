Return-Path: <linux-erofs+bounces-1138-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 21675BABACA
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Sep 2025 08:39:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cbT141J84z3cZM;
	Tue, 30 Sep 2025 16:39:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759214344;
	cv=none; b=eXLp9x7cQBzSTi7aKgfCGlG5hfmGv4Hbq38eiebP3fg1i3MzwhdOgGcC7Oia9VG/AqR5QzXE219lE3Of242CEO0aGj+c9os0esEh2AS8V6x3mazjXst3xLZTH9lVRIuJXIQFnOfoZp92M8x9ZSzituvjBl7dTZfJJhEN1IeXeHR7hNw1arTxONN1zqehCWO++A9+p1S0IEsmjtmGLpF2bbo/ZdtfVdLTo5m+4zFrSwxVpzuji2MT4kGjxdleF/o8GxbAMU2olvVbuzyn91erzewdUQCOeIubtZigC8pGmfPE5HfQIWg4VAaosvfzFDcq+JO55Siqu82CZrZ4vL60sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759214344; c=relaxed/relaxed;
	bh=Fd2iqs5Wg9RgINNC7HSLAP247gLKtIO3mvmsiMHDplM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ES+dcgZGO01Li/q99KtSCc5XfWV/bccyWD7zYqFWdAUzAnuv9ewKmIviVtCTHZIBleh0MUKJwisF7cESoeVgFDPEw29aMRIaPTK/6KR6h1lPobn6QKbdXlHiHZlWSRzaGyGWYgVMDyoAyO0j7GODfRFPnKz/ZI9u8hlN5f+rjGhZYr4Qm1IJZB0SkK4eMocF6o7+9Cz8/XxVEqB7jHal08fw4CEGtJ+zIQMTcybuJYiamP17QMKKiy79WVe7Nn9Qvdol1Bf37BgpECygrnF3G+x86fnS+YuizyrkT91u+YpBfmGBzOsaDLHSD7oyf+zBFnimvjqjIl49vzGy9C/LRw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=akjItYH4; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=akjItYH4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cbT102ldQz3cZR
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Sep 2025 16:38:59 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1759214336; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Fd2iqs5Wg9RgINNC7HSLAP247gLKtIO3mvmsiMHDplM=;
	b=akjItYH4yEKSTNdNcy0H3hA3DUQgosaPExskOlx1ANYJZoaHLWgh7E3KgcIkfT+k93jAipjJd9YsoDh7gq0sR3z09dTJcYiF6Ezq9vkzSo9RA3h+08EocV0aNKleZCw6VJr2xCBkrel+K1IyohtiUt8a0huHcudw/Pj2vZBZMiQ=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WpARblD_1759214334 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Sep 2025 14:38:55 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 4/5] erofs-utils: lib: migrate `c_inline_xattr_tolerance`
Date: Tue, 30 Sep 2025 14:38:46 +0800
Message-ID: <20250930063847.2143732-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250930063847.2143732-1-hsiangkao@linux.alibaba.com>
References: <20250930063847.2143732-1-hsiangkao@linux.alibaba.com>
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

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/config.h   |  2 -
 include/erofs/importer.h |  1 +
 include/erofs/xattr.h    |  4 +-
 lib/config.c             |  1 -
 lib/inode.c              |  2 +-
 lib/xattr.c              | 82 +++++++++++++++-------------------------
 mkfs/main.c              | 23 ++++++++---
 7 files changed, 51 insertions(+), 64 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 153315b..1685adf 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -56,8 +56,6 @@ struct erofs_configure {
 	struct erofs_compr_opts c_compr_opts[EROFS_MAX_COMPR_CFGS];
 	char c_force_chunkformat;
 	u8 c_mkfs_metabox_algid;
-	/* < 0, xattr disabled and INT_MAX, always use inline xattrs */
-	int c_inline_xattr_tolerance;
 	u32 c_max_decompressed_extent_bytes;
 	u64 c_unix_timestamp;
 	const char *mount_point;
diff --git a/include/erofs/importer.h b/include/erofs/importer.h
index dbb87be..48fe47e 100644
--- a/include/erofs/importer.h
+++ b/include/erofs/importer.h
@@ -41,6 +41,7 @@ struct erofs_importer_params {
 	bool hard_dereference;
 	bool ovlfs_strip;
 	bool dot_omitted;
+	bool no_xattrs;			/* don't store extended attributes */
 	bool no_zcompact;
 	bool no_lz4_0padding;
 	bool ztailpacking;
diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index 67f6199..ef80123 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -49,8 +49,8 @@ int erofs_xattr_init(struct erofs_sb_info *sbi);
 int erofs_scan_file_xattrs(struct erofs_inode *inode);
 int erofs_prepare_xattr_ibody(struct erofs_inode *inode, bool noroom);
 char *erofs_export_xattr_ibody(struct erofs_inode *inode);
-int erofs_build_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *path);
-
+int erofs_load_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *path,
+				       long inlinexattr_tolerance);
 int erofs_xattr_insert_name_prefix(const char *prefix);
 void erofs_xattr_cleanup_name_prefixes(void);
 int erofs_xattr_flush_name_prefixes(struct erofs_importer *im, bool plain);
diff --git a/lib/config.c b/lib/config.c
index 1da5354..16b34fa 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -29,7 +29,6 @@ void erofs_init_configure(void)
 	cfg.c_dbg_lvl  = EROFS_WARN;
 	cfg.c_version  = PACKAGE_VERSION;
 	cfg.c_dry_run  = false;
-	cfg.c_inline_xattr_tolerance = 2;
 	cfg.c_unix_timestamp = -1;
 	cfg.c_max_decompressed_extent_bytes = -1;
 	erofs_stdout_tty = isatty(STDOUT_FILENO);
diff --git a/lib/inode.c b/lib/inode.c
index 237ba31..4a834b4 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1848,7 +1848,7 @@ static int erofs_mkfs_handle_inode(struct erofs_importer *im,
 			return ret;
 	}
 
-	if (!rebuild) {
+	if (!rebuild && !params->no_xattrs) {
 		ret = erofs_scan_file_xattrs(inode);
 		if (ret < 0)
 			return ret;
diff --git a/lib/xattr.c b/lib/xattr.c
index 6e1958b..e02e8cb 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -127,7 +127,6 @@ struct erofs_inode_xattr_node {
 struct erofs_xattrmgr {
 	struct list_head hash[1 << 14];
 	struct erofs_xattritem *shared_xattrs;
-	unsigned int sharedxattr_count;
 };
 
 int erofs_xattr_init(struct erofs_sb_info *sbi)
@@ -374,10 +373,12 @@ static struct erofs_xattritem *erofs_get_selabel_xattr(struct erofs_sb_info *sbi
 	return NULL;
 }
 
-static int inode_xattr_add(struct list_head *hlist, struct erofs_xattritem *item)
+static int erofs_inode_xattr_add(struct list_head *hlist,
+				 struct erofs_xattritem *item)
 {
-	struct erofs_inode_xattr_node *node = malloc(sizeof(*node));
+	struct erofs_inode_xattr_node *node;
 
+	node = malloc(sizeof(*node));
 	if (!node)
 		return -ENOMEM;
 	init_list_head(&node->list);
@@ -386,22 +387,6 @@ static int inode_xattr_add(struct list_head *hlist, struct erofs_xattritem *item
 	return 0;
 }
 
-static int erofs_xattr_add(struct erofs_sb_info *sbi, struct list_head *ixattrs,
-			   struct erofs_xattritem *item)
-{
-	struct erofs_xattrmgr *xamgr = sbi->xamgr;
-
-	if (ixattrs)
-		return inode_xattr_add(ixattrs, item);
-
-	if (item->count == cfg.c_inline_xattr_tolerance + 1) {
-		item->next_shared_xattr = xamgr->shared_xattrs;
-		xamgr->shared_xattrs = item;
-		++xamgr->sharedxattr_count;
-	}
-	return 0;
-}
-
 static bool erofs_is_skipped_xattr(const char *key)
 {
 #ifdef HAVE_LIBSELINUX
@@ -468,9 +453,11 @@ static int read_xattrs_from_file(struct erofs_sb_info *sbi, const char *path,
 			goto err;
 		}
 
-		ret = erofs_xattr_add(sbi, ixattrs, item);
-		if (ret < 0)
-			goto err;
+		if (ixattrs) {
+			ret = erofs_inode_xattr_add(ixattrs, item);
+			if (ret < 0)
+				goto err;
+		}
 	}
 	free(keylst);
 
@@ -479,8 +466,8 @@ out:
 	item = erofs_get_selabel_xattr(sbi, path, mode);
 	if (IS_ERR(item))
 		return PTR_ERR(item);
-	if (item)
-		ret = erofs_xattr_add(sbi, ixattrs, item);
+	if (item && ixattrs)
+		ret = erofs_inode_xattr_add(ixattrs, item);
 	return ret;
 
 err:
@@ -512,8 +499,7 @@ int erofs_setxattr(struct erofs_inode *inode, char *key,
 		return PTR_ERR(item);
 	}
 	DBG_BUGON(!item);
-
-	return erofs_xattr_add(sbi, &inode->i_xattrs, item);
+	return erofs_inode_xattr_add(&inode->i_xattrs, item);
 }
 
 static void erofs_removexattr(struct erofs_inode *inode, const char *key)
@@ -578,8 +564,7 @@ static int erofs_droid_xattr_set_caps(struct erofs_inode *inode)
 		return PTR_ERR(item);
 	}
 	DBG_BUGON(!item);
-
-	return erofs_xattr_add(sbi, &inode->i_xattrs, item);
+	return erofs_inode_xattr_add(&inode->i_xattrs, item);
 }
 #else
 static int erofs_droid_xattr_set_caps(struct erofs_inode *inode)
@@ -593,10 +578,6 @@ int erofs_scan_file_xattrs(struct erofs_inode *inode)
 	int ret;
 	struct list_head *ixattrs = &inode->i_xattrs;
 
-	/* check if xattr is disabled */
-	if (cfg.c_inline_xattr_tolerance < 0)
-		return 0;
-
 	ret = read_xattrs_from_file(inode->sbi, inode->i_srcpath,
 				    inode->i_mode, ixattrs);
 	if (ret < 0)
@@ -788,24 +769,27 @@ fail:
 	return ret;
 }
 
-static void erofs_cleanxattrs(struct erofs_xattrmgr *xamgr, bool sharedxattrs)
+static unsigned int erofs_cleanxattrs(struct erofs_xattrmgr *xamgr,
+				      unsigned int inlinexattr_tolerance)
 {
 	struct erofs_xattritem *item, *n;
-	unsigned int i;
+	unsigned int i, count;
 
+	count = 0;
 	for (i = 0; i < ARRAY_SIZE(xamgr->hash); ++i) {
 		list_for_each_entry_safe(item, n, xamgr->hash + i, node) {
-			if (sharedxattrs && item->shared_xattr_id >= 0)
+			if (item->count > inlinexattr_tolerance) {
+				item->next_shared_xattr = xamgr->shared_xattrs;
+				xamgr->shared_xattrs = item;
+				++count;
 				continue;
+			}
 			list_del(&item->node);
 			free((void *)item->kvbuf);
 			free(item);
 		}
 	}
-
-	if (sharedxattrs)
-		return;
-	xamgr->sharedxattr_count = 0;
+	return count;
 }
 
 static int comp_shared_xattritem(const void *a, const void *b)
@@ -937,7 +921,8 @@ static void erofs_write_xattr_entry(char *buf, struct erofs_xattritem *item)
 			item->prefix, item->kvbuf + item->prefix_len);
 }
 
-int erofs_build_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *path)
+int erofs_load_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *path,
+				       long inlinexattr_tolerance)
 {
 	struct erofs_xattrmgr *xamgr = sbi->xamgr;
 	struct erofs_xattritem *item, *n, **sorted_n;
@@ -949,21 +934,16 @@ int erofs_build_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *p
 	erofs_off_t shared_xattrs_size = 0;
 
 	/* check if xattr or shared xattr is disabled */
-	if (cfg.c_inline_xattr_tolerance < 0 ||
-	    cfg.c_inline_xattr_tolerance == INT_MAX)
+	if (inlinexattr_tolerance < 0 || inlinexattr_tolerance >= INT_MAX)
 		return 0;
 
-	if (xamgr->sharedxattr_count) {
-		DBG_BUGON(1);
-		return -EINVAL;
-	}
-
 	ret = erofs_count_all_xattrs_from_path(sbi, path);
 	if (ret)
 		return ret;
-	sharedxattr_count = xamgr->sharedxattr_count;
+
+	sharedxattr_count = erofs_cleanxattrs(xamgr, inlinexattr_tolerance);
 	if (!sharedxattr_count)
-		goto out;
+		return 0;
 
 	sorted_n = malloc((sharedxattr_count + 1) * sizeof(n));
 	if (!sorted_n)
@@ -1014,8 +994,6 @@ int erofs_build_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *p
 	ret = erofs_dev_write(sbi, buf, erofs_btell(bh, false), shared_xattrs_size);
 	free(buf);
 	erofs_bdrop(bh, false);
-out:
-	erofs_cleanxattrs(xamgr, true);
 	return ret;
 }
 
@@ -1753,7 +1731,7 @@ void erofs_xattr_exit(struct erofs_sb_info *sbi)
 	erofs_xattr_prefixes_cleanup(sbi);
 	if (!xamgr)
 		return;
-	erofs_cleanxattrs(xamgr, false);
+	(void)erofs_cleanxattrs(xamgr, UINT_MAX);
 	sbi->xamgr = NULL;
 	free(xamgr);
 }
diff --git a/mkfs/main.c b/mkfs/main.c
index 25f28ee..1c37576 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -264,6 +264,13 @@ static void version(void)
 	print_available_compressors(stdout, ", ");
 }
 
+static struct erofsmkfs_cfg {
+	/* < 0, xattr disabled and >= INT_MAX, always use inline xattrs */
+	long inlinexattr_tolerance;
+} mkfscfg = {
+	.inlinexattr_tolerance = 2,
+};
+
 static unsigned int pclustersize_packed, pclustersize_max;
 static int pclustersize_metabox = -1;
 static struct erofs_tarfile erofstar = {
@@ -1011,10 +1018,11 @@ static int mkfs_parse_sources(int argc, char *argv[], int optind)
 static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 				  int argc, char *argv[])
 {
-	char *endptr;
-	int opt, i, err;
-	bool quiet = false;
 	bool has_timestamp = false;
+	bool quiet = false;
+	char *endptr;
+	int opt, err;
+	long i;
 
 	while ((opt = getopt_long(argc, argv, "C:E:L:T:U:b:d:m:x:z:Vh",
 				  long_options, NULL)) != -1) {
@@ -1049,7 +1057,7 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 				erofs_err("invalid xattr tolerance %s", optarg);
 				return -EINVAL;
 			}
-			cfg.c_inline_xattr_tolerance = i;
+			mkfscfg.inlinexattr_tolerance = i;
 			break;
 
 		case 'E':
@@ -1782,6 +1790,8 @@ int main(int argc, char **argv)
 		goto exit;
 	}
 
+	if (mkfscfg.inlinexattr_tolerance < 0)
+		importer_params.no_xattrs = true;
 	importer_params.source = cfg.c_src_path;
 	importer_params.no_datainline = mkfs_no_datainline;
 	importer_params.dot_omitted = mkfs_dot_omitted;
@@ -1819,9 +1829,10 @@ int main(int argc, char **argv)
 	}
 
 	if (source_mode == EROFS_MKFS_SOURCE_LOCALDIR) {
-		err = erofs_build_shared_xattrs_from_path(&g_sbi, cfg.c_src_path);
+		err = erofs_load_shared_xattrs_from_path(&g_sbi, cfg.c_src_path,
+						mkfscfg.inlinexattr_tolerance);
 		if (err) {
-			erofs_err("failed to build shared xattrs: %s",
+			erofs_err("failed to load shared xattrs: %s",
 				  erofs_strerror(err));
 			goto exit;
 		}
-- 
2.43.5


