Return-Path: <linux-erofs+bounces-827-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFC7B2AB6A
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Aug 2025 16:48:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c5Fv21GWZz3cYR;
	Tue, 19 Aug 2025 00:47:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755528478;
	cv=none; b=WC30OPatOmXLO3P+b9YAbOBL7XSe7dX95OAIs2QBQQ3EtFu2033dzBVM7ky2jobEK17gAvcAdCc0oS0xogc+hhmWsI+C1oS6GzNh930rfzk/f4h/NNqy+gMEAZ+EOTO1c9f8CrZsHbQCGfhhvoUHUFuHMLIPIBneZ6RM6YDwkiyNC7+8kKuJ+Cpg8xbY3wHLTgkVk3Z8zbe+gW0AFM9/dsWaiM/UYm09ewWFf8vQ4O6W/4U/B1ytmFfkKLwEd5KAtXoHZw1YdnFR5zYFI93tMeNsJujf282rzW5JMOnATmWU10gPoEqe3KEEzh1CdKp66gUiK1QVGPG8fBSr2Dnu6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755528478; c=relaxed/relaxed;
	bh=F/IZZfRvR08nlR8M4buBxvMEMyhjTfIGDUE4frA1+lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gLRP3Wpf73weXeXqGji1o757iTObRD6l/U/eazJl/O8O2lOB1zTGte7O37AWXysW9t5wK6KBQY/WDb1faYp9MYF5Xj2253SX+sIPL3pQqSKvAdTB4NJy1KsS6UaRRFC5JwBCDiA4edpNfEMq6SATt3KYjmOKKMClTpQm4vExFlA3UqglAST3VTYzYtIlbZ22b5XBACKTS1rIkE+72b/hcDm83EwJHidUgTApHfLN4hYEPkI7Hds/h74hpxq+sNMJighjUbDndLeaRqFSPv1JeNb8cQnG7lybYx8EnUMOFtcu7rhc/i/7y3msZAuB00VeOKlqf6EXqs7Zqbnv/gKnqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wVPI8sgI; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wVPI8sgI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c5Ftz1T0Lz3cZs
	for <linux-erofs@lists.ozlabs.org>; Tue, 19 Aug 2025 00:47:54 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755528471; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=F/IZZfRvR08nlR8M4buBxvMEMyhjTfIGDUE4frA1+lI=;
	b=wVPI8sgIz/Y85wnv+vp36ihWNedbRGSTSoU4zBgVc/7hOG1dmW/spzPgl4jkRhVcy1KFN4eR52n6ErczYsp22dgJJywDTyjtDNj5y6okHJHw0euowZNob/8qFN463kNoH6Uz4H238dFY9DGmSIWqsHSYGxK34xCDJYSlbfiHtuE=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wm0YYdr_1755528469 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 Aug 2025 22:47:50 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 4/7] erofs-utils: lib: make `c_inline_data` an importer parameter
Date: Mon, 18 Aug 2025 22:47:38 +0800
Message-ID: <20250818144741.2586329-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250818144741.2586329-1-hsiangkao@linux.alibaba.com>
References: <20250818144741.2586329-1-hsiangkao@linux.alibaba.com>
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

Move `c_inline_data` from the global configuration structure to
an importer-specific parameter.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/config.h    |  1 -
 include/erofs/fragments.h |  4 +-
 include/erofs/importer.h  |  1 +
 include/erofs/inode.h     |  2 +-
 include/erofs/tar.h       |  4 +-
 lib/fragments.c           |  6 ++-
 lib/inode.c               | 88 +++++++++++++++++++++------------------
 lib/liberofs_metabox.h    |  4 +-
 lib/liberofs_s3.h         |  2 +-
 lib/metabox.c             |  6 ++-
 lib/remotes/s3.c          | 13 +++---
 lib/tar.c                 | 11 +++--
 mkfs/main.c               | 17 ++++----
 13 files changed, 92 insertions(+), 67 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 8c40fd1..418e9b6 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -54,7 +54,6 @@ struct erofs_configure {
 	bool c_legacy_compress;
 	char c_timeinherit;
 	char c_chunkbits;
-	bool c_inline_data;
 	bool c_ztailpacking;
 	bool c_fragments;
 	bool c_all_fragments;
diff --git a/include/erofs/fragments.h b/include/erofs/fragments.h
index 7c7acf4..00e1e46 100644
--- a/include/erofs/fragments.h
+++ b/include/erofs/fragments.h
@@ -20,6 +20,8 @@ static inline bool erofs_is_packed_inode(struct erofs_inode *inode)
 	return inode->i_srcpath == EROFS_PACKED_INODE;
 }
 
+struct erofs_importer;
+
 u32 z_erofs_fragments_tofh(struct erofs_inode *inode, int fd, erofs_off_t fpos);
 int erofs_fragment_findmatch(struct erofs_inode *inode, int fd, u32 tofh);
 
@@ -27,7 +29,7 @@ int erofs_pack_file_from_fd(struct erofs_inode *inode, int fd, u32 tofcrc);
 int erofs_fragment_pack(struct erofs_inode *inode, void *data,
 			erofs_off_t pos, erofs_off_t len, u32 tofh, bool tail);
 int erofs_fragment_commit(struct erofs_inode *inode, u32 tofh);
-int erofs_flush_packed_inode(struct erofs_sb_info *sbi);
+int erofs_flush_packed_inode(struct erofs_importer *im);
 int erofs_packedfile(struct erofs_sb_info *sbi);
 
 int erofs_packedfile_init(struct erofs_sb_info *sbi, bool fragments_mkfs);
diff --git a/include/erofs/importer.h b/include/erofs/importer.h
index 541a86d..9aa032b 100644
--- a/include/erofs/importer.h
+++ b/include/erofs/importer.h
@@ -14,6 +14,7 @@ extern "C"
 
 struct erofs_importer_params {
 	char *source;
+	bool no_datainline;
 };
 
 struct erofs_importer {
diff --git a/include/erofs/inode.h b/include/erofs/inode.h
index 9d05aaa..c3155ba 100644
--- a/include/erofs/inode.h
+++ b/include/erofs/inode.h
@@ -45,7 +45,7 @@ int __erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
 struct erofs_inode *erofs_new_inode(struct erofs_sb_info *sbi);
 int erofs_importer_load_tree(struct erofs_importer *im, bool rebuild,
 			     bool incremental);
-struct erofs_inode *erofs_mkfs_build_special_from_fd(struct erofs_sb_info *sbi,
+struct erofs_inode *erofs_mkfs_build_special_from_fd(struct erofs_importer *im,
 						     int fd, const char *name);
 int erofs_fixup_root_inode(struct erofs_inode *root);
 struct erofs_inode *erofs_rebuild_make_root(struct erofs_sb_info *sbi);
diff --git a/include/erofs/tar.h b/include/erofs/tar.h
index 6981f9e..3bd4b15 100644
--- a/include/erofs/tar.h
+++ b/include/erofs/tar.h
@@ -55,9 +55,11 @@ struct erofs_tarfile {
 	bool try_no_reorder;
 };
 
+struct erofs_importer;
+
 void erofs_iostream_close(struct erofs_iostream *ios);
 int erofs_iostream_open(struct erofs_iostream *ios, int fd, int decoder);
-int tarerofs_parse_tar(struct erofs_inode *root, struct erofs_tarfile *tar);
+int tarerofs_parse_tar(struct erofs_importer *im, struct erofs_tarfile *tar);
 
 #ifdef __cplusplus
 }
diff --git a/lib/fragments.c b/lib/fragments.c
index 0221a53..5e93f48 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -20,6 +20,7 @@
 #include "erofs/fragments.h"
 #include "erofs/bitops.h"
 #include "erofs/lock.h"
+#include "erofs/importer.h"
 #include "liberofs_private.h"
 #ifdef HAVE_SYS_SENDFILE_H
 #include <sys/sendfile.h>
@@ -370,8 +371,9 @@ int erofs_fragment_commit(struct erofs_inode *inode, u32 tofh)
 	return 0;
 }
 
-int erofs_flush_packed_inode(struct erofs_sb_info *sbi)
+int erofs_flush_packed_inode(struct erofs_importer *im)
 {
+	struct erofs_sb_info *sbi = im->sbi;
 	struct erofs_packed_inode *epi = sbi->packedinode;
 	struct erofs_inode *inode;
 
@@ -380,7 +382,7 @@ int erofs_flush_packed_inode(struct erofs_sb_info *sbi)
 
 	if (lseek(epi->fd, 0, SEEK_CUR) <= 0)
 		return 0;
-	inode = erofs_mkfs_build_special_from_fd(sbi, epi->fd,
+	inode = erofs_mkfs_build_special_from_fd(im, epi->fd,
 						 EROFS_PACKED_INODE);
 	sbi->packed_nid = erofs_lookupnid(inode);
 	erofs_iput(inode);
diff --git a/lib/inode.c b/lib/inode.c
index 2599772..ae1c39c 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -868,9 +868,11 @@ static bool erofs_inode_need_48bit(struct erofs_inode *inode)
 	return false;
 }
 
-static int erofs_prepare_inode_buffer(struct erofs_inode *inode)
+static int erofs_prepare_inode_buffer(struct erofs_importer *im,
+				      struct erofs_inode *inode)
 {
-	struct erofs_sb_info *sbi = inode->sbi;
+	struct erofs_importer_params *params = im->params;
+	struct erofs_sb_info *sbi = im->sbi;
 	struct erofs_bufmgr *bmgr = sbi->bmgr;
 	struct erofs_bufmgr *ibmgr = bmgr;
 	unsigned int inodesize;
@@ -898,7 +900,7 @@ static int erofs_prepare_inode_buffer(struct erofs_inode *inode)
 		goto noinline;
 
 	if (!is_inode_layout_compression(inode)) {
-		if (!cfg.c_inline_data && S_ISREG(inode->i_mode)) {
+		if (params->no_datainline && S_ISREG(inode->i_mode)) {
 			inode->datalayout = EROFS_INODE_FLAT_PLAIN;
 			goto noinline;
 		}
@@ -1402,7 +1404,8 @@ out:
 	return ret;
 }
 
-static int erofs_mkfs_handle_nondirectory(struct erofs_mkfs_job_ndir_ctx *ctx)
+static int erofs_mkfs_handle_nondirectory(struct erofs_importer *im,
+					  struct erofs_mkfs_job_ndir_ctx *ctx)
 {
 	struct erofs_inode *inode = ctx->inode;
 	int ret = 0;
@@ -1431,7 +1434,7 @@ static int erofs_mkfs_handle_nondirectory(struct erofs_mkfs_job_ndir_ctx *ctx)
 	}
 	if (ret)
 		return ret;
-	erofs_prepare_inode_buffer(inode);
+	erofs_prepare_inode_buffer(im, inode);
 	erofs_write_tail_end(inode);
 	return 0;
 }
@@ -1451,7 +1454,8 @@ struct erofs_mkfs_jobitem {
 	} u;
 };
 
-static int erofs_mkfs_jobfn(struct erofs_mkfs_jobitem *item)
+static int erofs_mkfs_jobfn(struct erofs_importer *im,
+			    struct erofs_mkfs_jobitem *item)
 {
 	struct erofs_inode *inode = item->u.inode;
 	int ret;
@@ -1460,10 +1464,10 @@ static int erofs_mkfs_jobfn(struct erofs_mkfs_jobitem *item)
 		return 1;
 
 	if (item->type == EROFS_MKFS_JOB_NDIR)
-		return erofs_mkfs_handle_nondirectory(&item->u.ndir);
+		return erofs_mkfs_handle_nondirectory(im, &item->u.ndir);
 
 	if (item->type == EROFS_MKFS_JOB_DIR) {
-		ret = erofs_prepare_inode_buffer(inode);
+		ret = erofs_prepare_inode_buffer(im, inode);
 		if (ret)
 			return ret;
 		inode->bh->op = &erofs_skip_write_bhops;
@@ -1531,7 +1535,8 @@ static void erofs_mkfs_pop_jobitem(struct erofs_mkfs_dfops *q)
 
 static void *z_erofs_mt_dfops_worker(void *arg)
 {
-	struct erofs_sb_info *sbi = arg;
+	struct erofs_importer *im = arg;
+	struct erofs_sb_info *sbi = im->sbi;
 	struct erofs_mkfs_dfops *dfops = sbi->mkfs_dfops;
 	int ret;
 
@@ -1539,7 +1544,7 @@ static void *z_erofs_mt_dfops_worker(void *arg)
 		struct erofs_mkfs_jobitem *item;
 
 		item = erofs_mkfs_top_jobitem(dfops);
-		ret = erofs_mkfs_jobfn(item);
+		ret = erofs_mkfs_jobfn(im, item);
 		erofs_mkfs_pop_jobitem(dfops);
 	} while (!ret);
 
@@ -1549,11 +1554,11 @@ static void *z_erofs_mt_dfops_worker(void *arg)
 	pthread_exit((void *)(uintptr_t)(ret < 0 ? ret : 0));
 }
 
-static int erofs_mkfs_go(struct erofs_sb_info *sbi,
+static int erofs_mkfs_go(struct erofs_importer *im,
 			 enum erofs_mkfs_jobtype type, void *elem, int size)
 {
+	struct erofs_mkfs_dfops *q = im->sbi->mkfs_dfops;
 	struct erofs_mkfs_jobitem *item;
-	struct erofs_mkfs_dfops *q = sbi->mkfs_dfops;
 
 	pthread_mutex_lock(&q->lock);
 
@@ -1576,23 +1581,23 @@ static int erofs_mkfs_go(struct erofs_sb_info *sbi,
 	return 0;
 }
 #else
-static int erofs_mkfs_go(struct erofs_sb_info *sbi,
+static int erofs_mkfs_go(struct erofs_importer *im,
 			 enum erofs_mkfs_jobtype type, void *elem, int size)
 {
 	struct erofs_mkfs_jobitem item;
 
 	item.type = type;
 	memcpy(&item.u, elem, size);
-	return erofs_mkfs_jobfn(&item);
+	return erofs_mkfs_jobfn(im, &item);
 }
 static void erofs_mkfs_flushjobs(struct erofs_sb_info *sbi)
 {
 }
 #endif
 
-static int erofs_mkfs_handle_directory(struct erofs_inode *dir)
+static int erofs_mkfs_handle_directory(struct erofs_importer *im, struct erofs_inode *dir)
 {
-	struct erofs_sb_info *sbi = dir->sbi;
+	struct erofs_sb_info *sbi = im->sbi;
 	DIR *_dir;
 	struct dirent *dp;
 	struct erofs_dentry *d;
@@ -1675,7 +1680,7 @@ static int erofs_mkfs_handle_directory(struct erofs_inode *dir)
 		dir->i_nlink = i_nlink;
 	}
 
-	return erofs_mkfs_go(sbi, EROFS_MKFS_JOB_DIR, &dir, sizeof(dir));
+	return erofs_mkfs_go(im, EROFS_MKFS_JOB_DIR, &dir, sizeof(dir));
 
 err_closedir:
 	closedir(_dir);
@@ -1711,10 +1716,11 @@ static void erofs_dentry_kill(struct erofs_dentry *d)
 	free(d);
 }
 
-static int erofs_rebuild_handle_directory(struct erofs_inode *dir,
+static int erofs_rebuild_handle_directory(struct erofs_importer *im,
+					  struct erofs_inode *dir,
 					  bool incremental)
 {
-	struct erofs_sb_info *sbi = dir->sbi;
+	struct erofs_sb_info *sbi = im->sbi;
 	struct erofs_dentry *d, *n;
 	unsigned int nr_subdirs, i_nlink;
 	bool delwht = cfg.c_ovlfs_strip && dir->whiteouts;
@@ -1755,10 +1761,11 @@ static int erofs_rebuild_handle_directory(struct erofs_inode *dir,
 	else
 		dir->i_nlink = i_nlink;
 
-	return erofs_mkfs_go(sbi, EROFS_MKFS_JOB_DIR, &dir, sizeof(dir));
+	return erofs_mkfs_go(im, EROFS_MKFS_JOB_DIR, &dir, sizeof(dir));
 }
 
-static int erofs_mkfs_handle_inode(struct erofs_inode *inode)
+static int erofs_mkfs_handle_inode(struct erofs_importer *im,
+				   struct erofs_inode *inode)
 {
 	const char *relpath = erofs_fspath(inode->i_srcpath);
 	char *trimmed;
@@ -1793,17 +1800,16 @@ static int erofs_mkfs_handle_inode(struct erofs_inode *inode)
 					return PTR_ERR(ctx.ictx);
 			}
 		}
-		ret = erofs_mkfs_go(inode->sbi, EROFS_MKFS_JOB_NDIR,
-				    &ctx, sizeof(ctx));
+		ret = erofs_mkfs_go(im, EROFS_MKFS_JOB_NDIR, &ctx, sizeof(ctx));
 	} else {
-		ret = erofs_mkfs_handle_directory(inode);
+		ret = erofs_mkfs_handle_directory(im, inode);
 	}
 	erofs_info("file /%s dumped (mode %05o)", relpath, inode->i_mode);
 	return ret;
 }
 
-static int erofs_rebuild_handle_inode(struct erofs_inode *inode,
-				      bool incremental)
+static int erofs_rebuild_handle_inode(struct erofs_importer *im,
+				    struct erofs_inode *inode, bool incremental)
 {
 	char *trimmed;
 	int ret;
@@ -1859,10 +1865,9 @@ static int erofs_rebuild_handle_inode(struct erofs_inode *inode,
 					return PTR_ERR(ctx.ictx);
 			}
 		}
-		ret = erofs_mkfs_go(inode->sbi, EROFS_MKFS_JOB_NDIR,
-				    &ctx, sizeof(ctx));
+		ret = erofs_mkfs_go(im, EROFS_MKFS_JOB_NDIR, &ctx, sizeof(ctx));
 	} else {
-		ret = erofs_rebuild_handle_directory(inode, incremental);
+		ret = erofs_rebuild_handle_directory(im, inode, incremental);
 	}
 	erofs_info("file %s dumped (mode %05o)", erofs_fspath(inode->i_srcpath),
 		   inode->i_mode);
@@ -1906,8 +1911,8 @@ static int erofs_mkfs_dump_tree(struct erofs_importer *im, bool rebuild,
 		root->xattr_isize = cfg.c_root_xattr_isize;
 	}
 
-	err = !rebuild ? erofs_mkfs_handle_inode(root) :
-			erofs_rebuild_handle_inode(root, incremental);
+	err = !rebuild ? erofs_mkfs_handle_inode(im, root) :
+			erofs_rebuild_handle_inode(im, root, incremental);
 	if (err)
 		return err;
 
@@ -1938,10 +1943,10 @@ static int erofs_mkfs_dump_tree(struct erofs_importer *im, bool rebuild,
 				erofs_mark_parent_inode(inode, dir);
 
 				if (!rebuild)
-					err = erofs_mkfs_handle_inode(inode);
+					err = erofs_mkfs_handle_inode(im, inode);
 				else
-					err = erofs_rebuild_handle_inode(inode,
-								incremental);
+					err = erofs_rebuild_handle_inode(im,
+							inode, incremental);
 				if (err)
 					break;
 				if (S_ISDIR(inode->i_mode)) {
@@ -1955,8 +1960,8 @@ static int erofs_mkfs_dump_tree(struct erofs_importer *im, bool rebuild,
 		}
 		*last = dumpdir;	/* fixup the last (or the only) one */
 		dumpdir = head;
-		err2 = erofs_mkfs_go(sbi, EROFS_MKFS_JOB_DIR_BH,
-				    &dir, sizeof(dir));
+		err2 = erofs_mkfs_go(im, EROFS_MKFS_JOB_DIR_BH,
+				     &dir, sizeof(dir));
 		if (err || err2)
 			return err ? err : err2;
 	} while (dumpdir);
@@ -2047,12 +2052,12 @@ static int erofs_mkfs_build_tree(struct erofs_mkfs_buildtree_ctx *ctx)
 
 	sbi->mkfs_dfops = q;
 	err = pthread_create(&sbi->dfops_worker, NULL,
-			     z_erofs_mt_dfops_worker, sbi);
+			     z_erofs_mt_dfops_worker, im);
 	if (err)
 		goto fail;
 
 	err = __erofs_mkfs_build_tree(ctx);
-	erofs_mkfs_go(sbi, ~0, NULL, 0);
+	erofs_mkfs_go(im, ~0, NULL, 0);
 	err2 = pthread_join(sbi->dfops_worker, &retval);
 	DBG_BUGON(!q->exited);
 	if (!err || err == -ECHILD) {
@@ -2082,11 +2087,12 @@ int erofs_importer_load_tree(struct erofs_importer *im, bool rebuild,
 	}));
 }
 
-struct erofs_inode *erofs_mkfs_build_special_from_fd(struct erofs_sb_info *sbi,
+struct erofs_inode *erofs_mkfs_build_special_from_fd(struct erofs_importer *im,
 						     int fd, const char *name)
 {
-	struct stat st;
+	struct erofs_sb_info *sbi = im->sbi;
 	struct erofs_inode *inode;
+	struct stat st;
 	void *ictx;
 	int ret;
 
@@ -2134,7 +2140,7 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(struct erofs_sb_info *sbi,
 	if (ret)
 		return ERR_PTR(ret);
 out:
-	erofs_prepare_inode_buffer(inode);
+	erofs_prepare_inode_buffer(im, inode);
 	erofs_write_tail_end(inode);
 	return inode;
 }
diff --git a/lib/liberofs_metabox.h b/lib/liberofs_metabox.h
index a783678..d8896c0 100644
--- a/lib/liberofs_metabox.h
+++ b/lib/liberofs_metabox.h
@@ -12,9 +12,11 @@ static inline bool erofs_is_metabox_inode(struct erofs_inode *inode)
 	return inode->i_srcpath == EROFS_METABOX_INODE;
 }
 
+struct erofs_importer;
+
 void erofs_metabox_exit(struct erofs_sb_info *sbi);
 int erofs_metabox_init(struct erofs_sb_info *sbi);
 struct erofs_bufmgr *erofs_metabox_bmgr(struct erofs_sb_info *sbi);
-int erofs_metabox_iflush(struct erofs_sb_info *sbi);
+int erofs_metabox_iflush(struct erofs_importer *im);
 
 #endif
diff --git a/lib/liberofs_s3.h b/lib/liberofs_s3.h
index a178c64..f2ec822 100644
--- a/lib/liberofs_s3.h
+++ b/lib/liberofs_s3.h
@@ -34,7 +34,7 @@ struct erofs_s3 {
 	enum s3erofs_signature_version sig;
 };
 
-int s3erofs_build_trees(struct erofs_inode *root, struct erofs_s3 *s3,
+int s3erofs_build_trees(struct erofs_importer *im, struct erofs_s3 *s3,
 			const char *path, bool fillzero);
 
 #ifdef __cplusplus
diff --git a/lib/metabox.c b/lib/metabox.c
index a4c0822..c9db9ac 100644
--- a/lib/metabox.c
+++ b/lib/metabox.c
@@ -2,6 +2,7 @@
 #include <stdlib.h>
 #include "erofs/cache.h"
 #include "erofs/inode.h"
+#include "erofs/importer.h"
 #include "liberofs_private.h"
 #include "liberofs_metabox.h"
 
@@ -55,8 +56,9 @@ struct erofs_bufmgr *erofs_metabox_bmgr(struct erofs_sb_info *sbi)
 	return sbi->m2gr ? sbi->m2gr->bmgr : NULL;
 }
 
-int erofs_metabox_iflush(struct erofs_sb_info *sbi)
+int erofs_metabox_iflush(struct erofs_importer *im)
 {
+	struct erofs_sb_info *sbi = im->sbi;
 	struct erofs_metaboxmgr *m2gr = sbi->m2gr;
 	struct erofs_inode *inode;
 	int err;
@@ -70,7 +72,7 @@ int erofs_metabox_iflush(struct erofs_sb_info *sbi)
 
 	if (erofs_io_lseek(&m2gr->vf, 0, SEEK_END) <= 0)
 		return 0;
-	inode = erofs_mkfs_build_special_from_fd(sbi, m2gr->vf.fd,
+	inode = erofs_mkfs_build_special_from_fd(im, m2gr->vf.fd,
 						 EROFS_METABOX_INODE);
 	sbi->metabox_nid = erofs_lookupnid(inode);
 	erofs_iput(inode);
diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
index f4a364d..8f4638f 100644
--- a/lib/remotes/s3.c
+++ b/lib/remotes/s3.c
@@ -17,6 +17,7 @@
 #include "erofs/blobchunk.h"
 #include "erofs/diskbuf.h"
 #include "erofs/rebuild.h"
+#include "erofs/importer.h"
 #include "liberofs_s3.h"
 
 #define S3EROFS_PATH_MAX		1024
@@ -598,7 +599,8 @@ static size_t s3erofs_remote_getobject_cb(void *contents, size_t size,
 	return realsize;
 }
 
-static int s3erofs_remote_getobject(struct erofs_s3 *s3,
+static int s3erofs_remote_getobject(struct erofs_importer *im,
+				    struct erofs_s3 *s3,
 				    struct erofs_inode *inode,
 				    const char *bucket, const char *key)
 {
@@ -621,7 +623,7 @@ static int s3erofs_remote_getobject(struct erofs_s3 *s3,
 		return -EIO;
 
 	resp.pos = 0;
-	if (!cfg.c_compr_opts[0].alg && !cfg.c_inline_data) {
+	if (!cfg.c_compr_opts[0].alg && im->params->no_datainline) {
 		inode->datalayout = EROFS_INODE_FLAT_PLAIN;
 		inode->idata_size = 0;
 		ret = erofs_allocate_inode_bh_data(inode,
@@ -666,10 +668,11 @@ static int s3erofs_remote_getobject(struct erofs_s3 *s3,
 	return resp.pos != resp.end ? -EIO : 0;
 }
 
-int s3erofs_build_trees(struct erofs_inode *root, struct erofs_s3 *s3,
+int s3erofs_build_trees(struct erofs_importer *im, struct erofs_s3 *s3,
 			const char *path, bool fillzero)
 {
-	struct erofs_sb_info *sbi = root->sbi;
+	struct erofs_sb_info *sbi = im->sbi;
+	struct erofs_inode *root = im->root;
 	struct s3erofs_object_iterator *iter;
 	struct s3erofs_object_info *obj;
 	struct erofs_dentry *d;
@@ -747,7 +750,7 @@ int s3erofs_build_trees(struct erofs_inode *root, struct erofs_s3 *s3,
 			if (fillzero)
 				ret = erofs_write_zero_inode(inode);
 			else
-				ret = s3erofs_remote_getobject(s3, inode,
+				ret = s3erofs_remote_getobject(im, s3, inode,
 						iter->bucket, obj->key);
 		}
 		if (ret)
diff --git a/lib/tar.c b/lib/tar.c
index 3146fc9..4b1c101 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -12,6 +12,7 @@
 #include "erofs/xattr.h"
 #include "erofs/blobchunk.h"
 #include "erofs/rebuild.h"
+#include "erofs/importer.h"
 #if defined(HAVE_ZLIB)
 #include <zlib.h>
 #endif
@@ -704,12 +705,14 @@ static int tarerofs_write_file_data(struct erofs_inode *inode,
 	return 0;
 }
 
-int tarerofs_parse_tar(struct erofs_inode *root, struct erofs_tarfile *tar)
+int tarerofs_parse_tar(struct erofs_importer *im, struct erofs_tarfile *tar)
 {
-	char path[PATH_MAX];
 	struct erofs_pax_header eh = tar->global;
-	struct erofs_sb_info *sbi = root->sbi;
+	struct erofs_importer_params *params = im->params;
+	struct erofs_sb_info *sbi = im->sbi;
+	struct erofs_inode *root = im->root;
 	bool whout, opq, e = false;
+	char path[PATH_MAX];
 	struct stat st;
 	mode_t mode;
 	erofs_off_t tar_offset, dataoff;
@@ -1112,7 +1115,7 @@ new_inode:
 					ret = -EIO;
 			} else if (tar->try_no_reorder &&
 				   !cfg.c_compr_opts[0].alg &&
-				   !cfg.c_inline_data) {
+				   params->no_datainline) {
 				ret = tarerofs_write_uncompressed_file(inode, tar);
 			} else {
 				ret = tarerofs_write_file_data(inode, tar);
diff --git a/mkfs/main.c b/mkfs/main.c
index 9039710..2040b62 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -397,6 +397,8 @@ static struct {
 	{NULL, NULL},
 };
 
+static bool mkfs_no_datainline;
+
 static int parse_extended_opts(const char *opts)
 {
 #define MATCH_EXTENTED_OPT(opt, token, keylen) \
@@ -455,11 +457,11 @@ static int parse_extended_opts(const char *opts)
 		} else if (MATCH_EXTENTED_OPT("noinline_data", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
-			cfg.c_inline_data = false;
+			mkfs_no_datainline = true;
 		} else if (MATCH_EXTENTED_OPT("inline_data", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
-			cfg.c_inline_data = !clear;
+			mkfs_no_datainline = !!clear;
 		} else if (MATCH_EXTENTED_OPT("force-inode-blockmap", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
@@ -1328,7 +1330,6 @@ static void erofs_mkfs_default_options(void)
 {
 	cfg.c_showprogress = true;
 	cfg.c_legacy_compress = false;
-	cfg.c_inline_data = true;
 	cfg.c_xattr_name_filter = true;
 #ifdef EROFS_MT_ENABLED
 	cfg.c_mt_workers = erofs_get_available_processors();
@@ -1543,6 +1544,8 @@ int main(int argc, char **argv)
 	erofs_show_config();
 
 	importer_params.source = cfg.c_src_path;
+	importer_params.no_datainline = mkfs_no_datainline;
+
 	err = erofs_importer_init(&importer);
 	if (err)
 		goto exit;
@@ -1709,7 +1712,7 @@ int main(int argc, char **argv)
 		}
 
 		if (source_mode == EROFS_MKFS_SOURCE_TAR) {
-			while (!(err = tarerofs_parse_tar(root, &erofstar)))
+			while (!(err = tarerofs_parse_tar(&importer, &erofstar)))
 				;
 			if (err < 0)
 				goto exit;
@@ -1734,7 +1737,7 @@ int main(int argc, char **argv)
 			    dataimport_mode == EROFS_MKFS_DATA_IMPORT_RVSP)
 				err = -EOPNOTSUPP;
 			else
-				err = s3erofs_build_trees(root, &s3cfg,
+				err = s3erofs_build_trees(&importer, &s3cfg,
 							  cfg.c_src_path,
 					dataimport_mode == EROFS_MKFS_DATA_IMPORT_ZEROFILL);
 			if (err)
@@ -1763,7 +1766,7 @@ int main(int argc, char **argv)
 
 	if (erofs_sb_has_metabox(&g_sbi)) {
 		erofs_update_progressinfo("Handling metabox ...");
-		erofs_metabox_iflush(&g_sbi);
+		erofs_metabox_iflush(&importer);
 		if (err)
 			goto exit;
 	}
@@ -1771,7 +1774,7 @@ int main(int argc, char **argv)
 	if ((cfg.c_fragments || cfg.c_extra_ea_name_prefixes) &&
 	    erofs_sb_has_fragments(&g_sbi)) {
 		erofs_update_progressinfo("Handling packed data ...");
-		err = erofs_flush_packed_inode(&g_sbi);
+		err = erofs_flush_packed_inode(&importer);
 		if (err)
 			goto exit;
 	}
-- 
2.43.5


