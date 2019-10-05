Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F291ACCA6E
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Oct 2019 16:21:39 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46lpp60sbKzDqYn
	for <lists+linux-erofs@lfdr.de>; Sun,  6 Oct 2019 00:21:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1570285294;
	bh=ZIMg0YrAlfnotoBfgXyRLRhbG80kqRpS/0qDvKSphlw=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=ef1SxO905K+WOiAM/8s0iPc6pPxHplpQkTNVVLrEOs10ch0AAPxu3uyaximD+6noA
	 AyM5JW6vaEOUoiGkm9mIsx8aYRYEcGjRIUth03fa+wvAMWTZywJHBZAuNSgK64rBfu
	 JqcNVuQWaU3vbuLVNhWxrGQsU8VaGUzRkIvnnSlLnk3ZQnljBSaJDEx6V/UrOVaPxm
	 N3ZUgMB1uoGlVe5WpR0/k8jjkgcTLfsI93mux0ki6Z5tA5Wds9t3NRVtE2gXXqFLQ5
	 EC4LLmT0KE5v3yA3W5NCI63/HTjpYVBiI3aKFqomyBaHZ+RFSNEXP7G1NemTzeJciq
	 sLIPKIdASrleg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.68.147; helo=sonic302-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="siL4XsF/"; 
 dkim-atps=neutral
Received: from sonic302-21.consmr.mail.gq1.yahoo.com
 (sonic302-21.consmr.mail.gq1.yahoo.com [98.137.68.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46lpnz50jMzDqXs
 for <linux-erofs@lists.ozlabs.org>; Sun,  6 Oct 2019 00:21:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1570285285; bh=tBdPlJu+h/DYLhwdUAuqsP0/g4x7S0xvaBolffc1cqc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=siL4XsF/7ylnHD+a7X+E8kLrXNNm/l2gqIz815m24mdJIQZCUegCCY7wawiBHSEOO9OS2logTEWoo5UP4fEpFTePerWNPylfkMjIng2nc6MlP7c96lw249RhYGFJYgqVvnvEmEMsvniumY/jNP70Mmdn2BI2VLWW4h4g0/sUr+syeQlmODlAmQ+OBsoTt7uCmv5VX9zxrTqpSVCw/b41pXj4CrId4fuQrrYu0qopUWcWWoEnciW/oBoeXbBiKQoappRMFMik31gBc1iFFUXrXt+IUjhy94uWwaM9kv638kxQeC5opuDZyGQ9V/B58V2nrto766Ckb0qMjTB+6kydAA==
X-YMail-OSG: csshU0QVM1mUFGWJx5sAidvtfQgzaHh49dqupNi.8iNfUb85EgFXM.6wfK4WqUa
 DWcdEpssy3PtqjB1AGszknoyv6_bO6f1czRf2OQupjakat_2TOU653sNRPaJMt3ic9_1mq_8zDXe
 pKSpV6klj3zXwLqYD3J6mIstzVdQY4ZeKGCzZi.jZtHk0.4Q553Symb1fHY4IHioPHNlSsx3325N
 DqhFSUW5QOvGLsVFyvB2y1q9kXgtlYhTHlE.yyD1o40s8T90ciFPQYs.ZjGsSNZ.BHW.pZKuimPt
 QQ2Q9hD6j12yi4lNG.PatYdm_Oc7pw9n78KzsMf3tTNZQ0eoYH3xBTo9EBmhh3Nbg_bT2OYIhbcq
 V4fZe.C8CAU1PMAKIWLdhF7cZv1n7L78fd8eDAX6RE3v0DHOTZ7pfy4iCsrjZ3pqyx2BJlMnEfqb
 6pH1bZYnimTttNtjDvZhs3TNXiBfKyNBm23L7b3JAMnSIldJFCQcfnJuAcas08xWY.s7papS5rfL
 J5gIQxokxDgtexQNH5BDDXIS4N5bpnmCD0uiAYsXLqaLeT5cLMdS8t5ShHXFWlFIGd_h51WvVjgN
 gyyRGxLia7UoysDGbWIR9TmX0d.pT.N3rhD37VbL5iPK7JxA867Bpff4L_JFLSN3QJGqmCpsTRof
 a5HSL1lLlVfxRstRuUX0el5RSK_9NT8HSkMbKCNGrMrc9xUDd2ljIMts14r1T86bPUfdd_RW3gBk
 TfybiTSkNWO_H7jjn3lEhkVbAkWp0k2FY1piebcaf88MEqWKiBuK5qFeZB9xj43mqSMxeIpeZt9f
 1Qk7no_Aov5tC_4zhLoxgXOlTBVuLQyFSC2xRUR9PMjkaLPsR2pgobhNqgYUNB6jRH6LyfiOlxm.
 iLEPOiVnp5WtUyW2wMg74LQ597nMye81Bf1HcJlYZoaD53vIc2c209.y0ZtBLH0dcbZzeweUF0bx
 txdN4vjX.6rrarPd7NrocKGKamRG.rjeqiQh0cVLRtfJPbCs1_UlJIKkSFpiJ8NP2z8thXrPM3zP
 kPrzVEawwJSUI1Hla41yfF9aGgFlITVNY_IrDFP91VvJSIthxe9iIvXv49JKAbOWMtaS6QOLvGp2
 SYW4KQml4VZSrdTVAg410_SIN0hYdi5uQZQW5fWcpPg1_4UoDXNTeNf1NWoqYH46NHjw8otuGQOM
 AR4r7dLmBLilut19lvyjMDKc8nC91_4cTwrLOWcn.BfJwbihWUXi0Gz2Qo7pc0hfhj7lAc2VuaYF
 DDelw.RAyGExgxBdcWphuSRS1CF6liBeVuxovfR23gqmoYgSJ8ZixiE.DmPPSx54kOegUutYiTXl
 62tp5xauGCQVKW00-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic302.consmr.mail.gq1.yahoo.com with HTTP; Sat, 5 Oct 2019 14:21:25 +0000
Received: by smtp411.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 0e01244be27731c2d9909e82eb44bd90; 
 Sat, 05 Oct 2019 14:21:21 +0000 (UTC)
To: Li Guifu <bluce.liguifu@huawei.com>, Chao Yu <yuchao0@huawei.com>,
 linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs-utils: introduce shared xattr support
Date: Sat,  5 Oct 2019 22:20:50 +0800
Message-Id: <20191005142050.8827-2-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191005142050.8827-1-hsiangkao@aol.com>
References: <20190811171049.26111-1-hsiangkao@aol.com>
 <20191005142050.8827-1-hsiangkao@aol.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Li Guifu <blucerlee@gmail.com>

Large xattrs or xattrs shared by a lot of files
can be stored in shared xattrs rather than
inlined right after inode.

Signed-off-by: Li Guifu <blucerlee@gmail.com>
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 include/erofs/config.h |   2 +
 include/erofs/xattr.h  |   1 +
 lib/config.c           |   1 +
 lib/xattr.c            | 193 ++++++++++++++++++++++++++++++++++++++++-
 mkfs/main.c            |  10 ++-
 5 files changed, 205 insertions(+), 2 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 8b09430..fde936c 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -28,6 +28,8 @@ struct erofs_configure {
 	char *c_compr_alg_master;
 	int c_compr_level_master;
 	int c_force_inodeversion;
+	/* < 0, xattr disabled and INT_MAX, always use inline xattrs */
+	int c_inline_xattr_tolerance;
 };
 
 extern struct erofs_configure cfg;
diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index 29df025..3dff1ea 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -44,5 +44,6 @@
 
 int erofs_prepare_xattr_ibody(const char *path, struct list_head *ixattrs);
 char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned int size);
+int erofs_build_shared_xattrs_from_path(const char *path);
 
 #endif
diff --git a/lib/config.c b/lib/config.c
index 110c8b6..dc10754 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -23,6 +23,7 @@ void erofs_init_configure(void)
 	cfg.c_compr_level_master = -1;
 	sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_LZ4_0PADDING;
 	cfg.c_force_inodeversion = 0;
+	cfg.c_inline_xattr_tolerance = 2;
 }
 
 void erofs_show_config(void)
diff --git a/lib/xattr.c b/lib/xattr.c
index 8156f3e..781d210 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -6,20 +6,26 @@
  * heavily changed by Li Guifu <blucerlee@gmail.com>
  *                and Gao Xiang <hsiangkao@aol.com>
  */
+#define _GNU_SOURCE
+#include <limits.h>
 #include <stdlib.h>
 #include <sys/xattr.h>
 #ifdef HAVE_LINUX_XATTR_H
 #include <linux/xattr.h>
 #endif
+#include <sys/stat.h>
+#include <dirent.h>
 #include "erofs/print.h"
 #include "erofs/hashtable.h"
 #include "erofs/xattr.h"
+#include "erofs/cache.h"
 
 #define EA_HASHTABLE_BITS 16
 
 struct xattr_item {
 	const char *kvbuf;
 	unsigned int hash[2], len[2], count;
+	int shared_xattr_id;
 	u8 prefix;
 	struct hlist_node node;
 };
@@ -31,6 +37,9 @@ struct inode_xattr_node {
 
 static DECLARE_HASHTABLE(ea_hashtable, EA_HASHTABLE_BITS);
 
+static LIST_HEAD(shared_xattrs_list);
+static unsigned int shared_xattrs_count, shared_xattrs_size;
+
 static struct xattr_prefix {
 	const char *prefix;
 	u16 prefix_len;
@@ -105,6 +114,7 @@ static struct xattr_item *xattr_item_get(u8 prefix, char *kvbuf,
 	item->len[1] = len[1];
 	item->hash[0] = hash[0];
 	item->hash[1] = hash[1];
+	item->shared_xattr_id = -1;
 	item->prefix = prefix;
 	hash_add(ea_hashtable, &item->node, hkey);
 	return item;
@@ -152,7 +162,6 @@ static struct xattr_item *parse_one_xattr(const char *path, const char *key,
 	kvbuf = malloc(len[0] + len[1]);
 	if (!kvbuf)
 		return ERR_PTR(-ENOMEM);
-
 	memcpy(kvbuf, key + prefixlen, len[0]);
 	if (len[1]) {
 		/* copy value to buffer */
@@ -182,6 +191,23 @@ static int inode_xattr_add(struct list_head *hlist, struct xattr_item *item)
 	return 0;
 }
 
+static int shared_xattr_add(struct xattr_item *item)
+{
+	struct inode_xattr_node *node = malloc(sizeof(*node));
+
+	if (!node)
+		return -ENOMEM;
+
+	init_list_head(&node->list);
+	node->item = item;
+	list_add(&node->list, &shared_xattrs_list);
+
+	shared_xattrs_size += sizeof(struct erofs_xattr_entry);
+	shared_xattrs_size = EROFS_XATTR_ALIGN(shared_xattrs_size +
+					       item->len[0] + item->len[1]);
+	return ++shared_xattrs_count;
+}
+
 static int read_xattrs_from_file(const char *path, struct list_head *ixattrs)
 {
 	int ret = 0;
@@ -227,6 +253,11 @@ static int read_xattrs_from_file(const char *path, struct list_head *ixattrs)
 			ret = inode_xattr_add(ixattrs, item);
 			if (ret < 0)
 				goto err;
+		} else if (item->count == cfg.c_inline_xattr_tolerance + 1) {
+			ret = shared_xattr_add(item);
+			if (ret < 0)
+				goto err;
+			ret = 0;
 		}
 		kllen -= keylen + 1;
 		key += keylen + 1;
@@ -242,6 +273,10 @@ int erofs_prepare_xattr_ibody(const char *path, struct list_head *ixattrs)
 	int ret;
 	struct inode_xattr_node *node;
 
+	/* check if xattr is disabled */
+	if (cfg.c_inline_xattr_tolerance < 0)
+		return 0;
+
 	ret = read_xattrs_from_file(path, ixattrs);
 	if (ret < 0)
 		return ret;
@@ -254,16 +289,155 @@ int erofs_prepare_xattr_ibody(const char *path, struct list_head *ixattrs)
 	list_for_each_entry(node, ixattrs, list) {
 		const struct xattr_item *item = node->item;
 
+		if (item->shared_xattr_id >= 0) {
+			ret += sizeof(__le32);
+			continue;
+		}
 		ret += sizeof(struct erofs_xattr_entry);
 		ret = EROFS_XATTR_ALIGN(ret + item->len[0] + item->len[1]);
 	}
 	return ret;
 }
 
+static int erofs_count_all_xattrs_from_path(const char *path)
+{
+	int ret;
+	DIR *_dir;
+	struct stat64 st;
+
+	_dir = opendir(path);
+	if (!_dir) {
+		erofs_err("%s, failed to opendir at %s: %s",
+			  __func__, path, erofs_strerror(errno));
+		return -errno;
+	}
+
+	ret = 0;
+	while (1) {
+		struct dirent *dp;
+		char buf[PATH_MAX];
+
+		/*
+		 * set errno to 0 before calling readdir() in order to
+		 * distinguish end of stream and from an error.
+		 */
+		errno = 0;
+		dp = readdir(_dir);
+		if (!dp)
+			break;
+
+		if (is_dot_dotdot(dp->d_name) ||
+		    !strncmp(dp->d_name, "lost+found", strlen("lost+found")))
+			continue;
+
+		ret = snprintf(buf, PATH_MAX, "%s/%s", path, dp->d_name);
+
+		if (ret < 0 || ret >= PATH_MAX) {
+			/* ignore the too long path */
+			ret = -ENOMEM;
+			goto fail;
+		}
+
+		ret = read_xattrs_from_file(buf, NULL);
+		if (ret)
+			goto fail;
+
+		ret = lstat64(buf, &st);
+		if (ret) {
+			ret = -errno;
+			goto fail;
+		}
+
+		if (!S_ISDIR(st.st_mode))
+			continue;
+
+		ret = erofs_count_all_xattrs_from_path(buf);
+		if (ret)
+			goto fail;
+	}
+
+	if (errno)
+		ret = -errno;
+
+fail:
+	closedir(_dir);
+	return ret;
+}
+
+int erofs_build_shared_xattrs_from_path(const char *path)
+{
+	int ret;
+	struct erofs_buffer_head *bh;
+	struct inode_xattr_node *node, *n;
+	char *buf;
+	unsigned int p;
+	erofs_off_t off;
+
+	/* check if xattr or shared xattr is disabled */
+	if (cfg.c_inline_xattr_tolerance < 0 ||
+	    cfg.c_inline_xattr_tolerance == INT_MAX)
+		return 0;
+
+	if (shared_xattrs_size || shared_xattrs_count) {
+		DBG_BUGON(1);
+		return -EINVAL;
+	}
+
+	ret = erofs_count_all_xattrs_from_path(path);
+	if (ret)
+		return ret;
+
+	if (!shared_xattrs_size)
+		return 0;
+
+	buf = malloc(shared_xattrs_size);
+	if (!buf)
+		return -ENOMEM;
+
+	bh = erofs_balloc(XATTR, shared_xattrs_size, 0, 0);
+	if (IS_ERR(bh)) {
+		free(buf);
+		return PTR_ERR(bh);
+	}
+	bh->op = &erofs_skip_write_bhops;
+
+	erofs_mapbh(bh->block, true);
+	off = erofs_btell(bh, false);
+
+	sbi.xattr_blkaddr = off / EROFS_BLKSIZ;
+	off %= EROFS_BLKSIZ;
+	p = 0;
+
+	list_for_each_entry_safe(node, n, &shared_xattrs_list, list) {
+		struct xattr_item *const item = node->item;
+		const struct erofs_xattr_entry entry = {
+			.e_name_index = item->prefix,
+			.e_name_len = item->len[0],
+			.e_value_size = cpu_to_le16(item->len[1])
+		};
+
+		list_del(&node->list);
+
+		item->shared_xattr_id = (off + p) /
+			sizeof(struct erofs_xattr_entry);
+
+		memcpy(buf + p, &entry, sizeof(entry));
+		p += sizeof(struct erofs_xattr_entry);
+		memcpy(buf + p, item->kvbuf, item->len[0] + item->len[1]);
+		p = EROFS_XATTR_ALIGN(p + item->len[0] + item->len[1]);
+		free(node);
+	}
+
+	bh->fsprivate = buf;
+	bh->op = &erofs_buf_write_bhops;
+	return 0;
+}
+
 char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned int size)
 {
 	struct inode_xattr_node *node, *n;
 	struct erofs_xattr_ibody_header *header;
+	LIST_HEAD(ilst);
 	unsigned int p;
 	char *buf = calloc(1, size);
 
@@ -276,6 +450,23 @@ char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned int size)
 	p = sizeof(struct erofs_xattr_ibody_header);
 	list_for_each_entry_safe(node, n, ixattrs, list) {
 		struct xattr_item *const item = node->item;
+
+		list_del(&node->list);
+
+		/* move inline xattrs to the onstack list */
+		if (item->shared_xattr_id < 0) {
+			list_add(&node->list, &ilst);
+			continue;
+		}
+
+		*(__le32 *)(buf + p) = cpu_to_le32(item->shared_xattr_id);
+		p += sizeof(__le32);
+		++header->h_shared_count;
+		free(node);
+	}
+
+	list_for_each_entry_safe(node, n, &ilst, list) {
+		struct xattr_item *const item = node->item;
 		const struct erofs_xattr_entry entry = {
 			.e_name_index = item->prefix,
 			.e_name_len = item->len[0],
diff --git a/mkfs/main.c b/mkfs/main.c
index 4b279c0..978c5b4 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -19,6 +19,7 @@
 #include "erofs/inode.h"
 #include "erofs/io.h"
 #include "erofs/compress.h"
+#include "erofs/xattr.h"
 
 #define EROFS_SUPER_END (EROFS_SUPER_OFFSET + sizeof(struct erofs_super_block))
 
@@ -169,7 +170,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 		.build_time_nsec = cpu_to_le32(sbi.build_time_nsec),
 		.blocks = 0,
 		.meta_blkaddr  = sbi.meta_blkaddr,
-		.xattr_blkaddr = 0,
+		.xattr_blkaddr = sbi.xattr_blkaddr,
 		.feature_incompat = cpu_to_le32(sbi.feature_incompat),
 	};
 	const unsigned int sb_blksize =
@@ -259,6 +260,13 @@ int main(int argc, char **argv)
 
 	erofs_inode_manager_init();
 
+	err = erofs_build_shared_xattrs_from_path(cfg.c_src_path);
+	if (err) {
+		erofs_err("Failed to build shared xattrs: %s",
+			  erofs_strerror(err));
+		goto exit;
+	}
+
 	root_inode = erofs_mkfs_build_tree_from_path(NULL, cfg.c_src_path);
 	if (IS_ERR(root_inode)) {
 		err = PTR_ERR(root_inode);
-- 
2.17.1

