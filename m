Return-Path: <linux-erofs+bounces-465-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 50275ADE787
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Jun 2025 11:58:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bMfMN06hwz2xS0;
	Wed, 18 Jun 2025 19:58:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750240719;
	cv=none; b=GHKkk9VWaOO98PSytXNdvqjPTvSfutQ/hKsvXFadF0GJKQbu8DD+t6a2eNnNV2a2FjXlMTIoPcwPFG0dnp8PT1YrngEtBcidmSuuY80FCyWaA4O35Z7hLwwX5K4bmNfyewPUpl8rX/T9kIw15BCdg4Mr6gvQAwpbHREUEBNh44hcHWMKT1B10KdQyOBvTt7AOaU3z/5e4fVQMOn1AGV5pa0XbutxjjsFaKAUC5Mkq4OuE7UT/e7NOjT4zezqCUz6QLzaEU/lcZNOl+Gk89+oqeFLt9QQxW81DtfsTeJEORbZMPl2pepTNdJyFvpKDCPkU9p5ppyAW0dLsW0kUZzFIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750240719; c=relaxed/relaxed;
	bh=0AdCLfbT8fM4JFpIVrrTiVg3e3Dzmj4Hy6X2MoxGMoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FrwkPFHoTyJ4H7i1YLRCwhoBpJIoOMRF7CGywtsuSF5l+HnOL7/XvZmRRuKLv10giLfdF8cFMtMMSo3THFH5u7L8KKFaKhsOztBScaRbSZWj2COZa4EDW07hLSfUPaKj1tDUnIVOPRiuag8ntTambMbw40XThOv+uvdpP0Z76Re2rprauyMqAAGAFcA7BYZJhFk/gf6fIrAu/orkLw27Z2JefkR/vZ5Xpj24X+4HpYQtwLtSWc/ChNvrB0WglVmnrySmLk8UDcPg3UMx/dTPzM1JA8o4QATAToFzrQx/QrJYrmqiZxpdNXCt0Z86Hc/WaCj+02U2Dp2PKU6emiJ5QA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YRwc3nHj; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YRwc3nHj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bMfML1CfYz2xRt
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Jun 2025 19:58:37 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1750240714; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=0AdCLfbT8fM4JFpIVrrTiVg3e3Dzmj4Hy6X2MoxGMoU=;
	b=YRwc3nHjwFuNyT3pz59adotwKf2lXPOAaDt7Ia/27c7I7T7umXLDa3Gf454zj/ldxncZalJEwvEyHrOzHveFpTnBpjunQ0VMUDeASG+ppxHdJlv2PzVSGWao8I46YxV2XrrOtMeZHrCZSKT+EB2rttS4mJhFpy1AJhmju2lFKls=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WeDAHZN_1750240711 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 18 Jun 2025 17:58:32 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/2] erofs-utils: lib: refine the inode hash table
Date: Wed, 18 Jun 2025 17:58:26 +0800
Message-ID: <20250618095826.1291494-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250618095826.1291494-1-hsiangkao@linux.alibaba.com>
References: <20250618095826.1291494-1-hsiangkao@linux.alibaba.com>
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

 - Increase the hash table entries to 65536;
 - Protect the hash table with `erofs_rwsem`.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/inode.h |  2 +-
 lib/inode.c           | 65 +++++++++++++++++++++++--------------------
 lib/rebuild.c         |  2 +-
 3 files changed, 37 insertions(+), 32 deletions(-)

diff --git a/include/erofs/inode.h b/include/erofs/inode.h
index eb8f45b..fe86101 100644
--- a/include/erofs/inode.h
+++ b/include/erofs/inode.h
@@ -27,8 +27,8 @@ umode_t erofs_ftype_to_mode(unsigned int ftype, unsigned int perm);
 unsigned char erofs_ftype_to_dtype(unsigned int filetype);
 void erofs_inode_manager_init(void);
 void erofs_insert_ihash(struct erofs_inode *inode);
+void erofs_remove_ihash(struct erofs_inode *inode);
 struct erofs_inode *erofs_iget(dev_t dev, ino_t ino);
-struct erofs_inode *erofs_iget_by_nid(erofs_nid_t nid);
 unsigned int erofs_iput(struct erofs_inode *inode);
 erofs_nid_t erofs_lookupnid(struct erofs_inode *inode);
 int erofs_iflush(struct erofs_inode *inode);
diff --git a/lib/inode.c b/lib/inode.c
index 6b42fc9..a2ee522 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -6,9 +6,6 @@
  * with heavy changes by Gao Xiang <xiang@kernel.org>
  */
 #define _GNU_SOURCE
-#ifdef EROFS_MT_ENABLED
-#include <pthread.h>
-#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
@@ -19,6 +16,7 @@
 #endif
 #include <dirent.h>
 #include "erofs/print.h"
+#include "erofs/lock.h"
 #include "erofs/diskbuf.h"
 #include "erofs/inode.h"
 #include "erofs/cache.h"
@@ -85,48 +83,50 @@ unsigned char erofs_ftype_to_dtype(unsigned int filetype)
 	return erofs_dtype_by_ftype[filetype];
 }
 
-#define NR_INODE_HASHTABLE	16384
-
-struct list_head inode_hashtable[NR_INODE_HASHTABLE];
+static struct list_head erofs_ihash[65536];
+static erofs_rwsem_t erofs_ihashlock;
 
 void erofs_inode_manager_init(void)
 {
 	unsigned int i;
 
-	for (i = 0; i < NR_INODE_HASHTABLE; ++i)
-		init_list_head(&inode_hashtable[i]);
+	for (i = 0; i < ARRAY_SIZE(erofs_ihash); ++i)
+		init_list_head(&erofs_ihash[i]);
+	erofs_init_rwsem(&erofs_ihashlock);
 }
 
 void erofs_insert_ihash(struct erofs_inode *inode)
 {
-	unsigned int nr = (inode->i_ino[1] ^ inode->dev) % NR_INODE_HASHTABLE;
+	u32 nr = (inode->i_ino[1] ^ inode->dev) % ARRAY_SIZE(erofs_ihash);
 
-	list_add(&inode->i_hash, &inode_hashtable[nr]);
+	erofs_down_write(&erofs_ihashlock);
+	list_add(&inode->i_hash, &erofs_ihash[nr]);
+	erofs_up_write(&erofs_ihashlock);
 }
 
-/* get the inode from the (source) inode # */
-struct erofs_inode *erofs_iget(dev_t dev, ino_t ino)
+void erofs_remove_ihash(struct erofs_inode *inode)
 {
-	struct list_head *head =
-		&inode_hashtable[(ino ^ dev) % NR_INODE_HASHTABLE];
-	struct erofs_inode *inode;
-
-	list_for_each_entry(inode, head, i_hash)
-		if (inode->i_ino[1] == ino && inode->dev == dev)
-			return erofs_igrab(inode);
-	return NULL;
+	erofs_down_write(&erofs_ihashlock);
+	list_del(&inode->i_hash);
+	erofs_up_write(&erofs_ihashlock);
 }
 
-struct erofs_inode *erofs_iget_by_nid(erofs_nid_t nid)
+/* get the inode from the (source) inode # */
+struct erofs_inode *erofs_iget(dev_t dev, ino_t ino)
 {
-	struct list_head *head =
-		&inode_hashtable[nid % NR_INODE_HASHTABLE];
-	struct erofs_inode *inode;
+	u32 nr = (ino ^ dev) % ARRAY_SIZE(erofs_ihash);
+	struct list_head *head = &erofs_ihash[nr];
+	struct erofs_inode *ret = NULL, *inode;
 
-	list_for_each_entry(inode, head, i_hash)
-		if (inode->nid == nid)
-			return erofs_igrab(inode);
-	return NULL;
+	erofs_down_read(&erofs_ihashlock);
+	list_for_each_entry(inode, head, i_hash) {
+		if (inode->i_ino[1] == ino && inode->dev == dev) {
+			ret = erofs_igrab(inode);
+			break;
+		}
+	}
+	erofs_up_read(&erofs_ihashlock);
+	return ret;
 }
 
 unsigned int erofs_iput(struct erofs_inode *inode)
@@ -142,7 +142,7 @@ unsigned int erofs_iput(struct erofs_inode *inode)
 
 	free(inode->compressmeta);
 	free(inode->eof_tailraw);
-	list_del(&inode->i_hash);
+	erofs_remove_ihash(inode);
 	free(inode->i_srcpath);
 
 	if (inode->datasource == EROFS_INODE_DATA_SOURCE_DISKBUF) {
@@ -1094,6 +1094,11 @@ struct erofs_inode *erofs_new_inode(struct erofs_sb_info *sbi)
 		return ERR_PTR(-ENOMEM);
 
 	inode->sbi = sbi;
+	/*
+	 * By default, newly allocated in-memory inodes are associated with
+	 * the target filesystem rather than any other foreign sources.
+	 */
+	inode->dev = sbi->dev;
 	inode->i_count = 1;
 	inode->datalayout = EROFS_INODE_FLAT_PLAIN;
 
@@ -1707,7 +1712,7 @@ static int erofs_mkfs_dump_tree(struct erofs_inode *root, bool rebuild,
 	if (incremental) {
 		root->dev = root->sbi->dev;
 		root->i_ino[1] = sbi->root_nid;
-		list_del(&root->i_hash);
+		erofs_remove_ihash(root);
 		erofs_insert_ihash(root);
 	} else if (cfg.c_root_xattr_isize) {
 		if (cfg.c_root_xattr_isize > EROFS_XATTR_ALIGN(
diff --git a/lib/rebuild.c b/lib/rebuild.c
index 5787bb3..b61af15 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -481,7 +481,7 @@ static int erofs_rebuild_basedir_dirent_iter(struct erofs_dir_context *ctx)
 		if (S_ISDIR(inode->i_mode) &&
 		    (ctx->de_ftype == EROFS_FT_DIR ||
 		     ctx->de_ftype == EROFS_FT_UNKNOWN)) {
-			list_del(&inode->i_hash);
+			erofs_remove_ihash(inode);
 			inode->dev = dir->sbi->dev;
 			inode->i_ino[1] = ctx->de_nid;
 			erofs_insert_ihash(inode);
-- 
2.43.5


