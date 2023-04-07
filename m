Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 727676DADB0
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Apr 2023 15:38:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PtKFX5G0xz3fWV
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Apr 2023 23:38:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PtKFQ4qsMz3fSl
	for <linux-erofs@lists.ozlabs.org>; Fri,  7 Apr 2023 23:38:17 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VfWxv0M_1680874690;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VfWxv0M_1680874690)
          by smtp.aliyun-inc.com;
          Fri, 07 Apr 2023 21:38:11 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/3] erofs-utils: xattr: avoid global variable shared_xattrs_size
Date: Fri,  7 Apr 2023 21:38:04 +0800
Message-Id: <20230407133805.60975-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230407133805.60975-1-hsiangkao@linux.alibaba.com>
References: <20230407133805.60975-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Let's calculate shared_xattrs_size lazily instead.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/xattr.c | 65 ++++++++++++++++++++++-------------------------------
 1 file changed, 27 insertions(+), 38 deletions(-)

diff --git a/lib/xattr.c b/lib/xattr.c
index a292f2c..5f11cbe 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -37,7 +37,7 @@ struct inode_xattr_node {
 static DECLARE_HASHTABLE(ea_hashtable, EA_HASHTABLE_BITS);
 
 static LIST_HEAD(shared_xattrs_list);
-static unsigned int shared_xattrs_count, shared_xattrs_size;
+static unsigned int shared_xattrs_count;
 
 static struct xattr_prefix {
 	const char *prefix;
@@ -269,10 +269,6 @@ static int shared_xattr_add(struct xattr_item *item)
 	init_list_head(&node->list);
 	node->item = item;
 	list_add(&node->list, &shared_xattrs_list);
-
-	shared_xattrs_size += sizeof(struct erofs_xattr_entry);
-	shared_xattrs_size = EROFS_XATTR_ALIGN(shared_xattrs_size +
-					       item->len[0] + item->len[1]);
 	return ++shared_xattrs_count;
 }
 
@@ -543,24 +539,9 @@ static void erofs_cleanxattrs(bool sharedxattrs)
 	if (sharedxattrs)
 		return;
 
-	shared_xattrs_size = shared_xattrs_count = 0;
-}
-
-static bool erofs_bh_flush_write_shared_xattrs(struct erofs_buffer_head *bh)
-{
-	void *buf = bh->fsprivate;
-	int err = dev_write(buf, erofs_btell(bh, false), shared_xattrs_size);
-
-	if (err)
-		return false;
-	free(buf);
-	return erofs_bh_flush_generic_end(bh);
+	shared_xattrs_count = 0;
 }
 
-static struct erofs_bhops erofs_write_shared_xattrs_bhops = {
-	.flush = erofs_bh_flush_write_shared_xattrs,
-};
-
 static int comp_xattr_item(const void *a, const void *b)
 {
 	const struct xattr_item *ia, *ib;
@@ -587,13 +568,14 @@ int erofs_build_shared_xattrs_from_path(const char *path)
 	char *buf;
 	unsigned int p, i;
 	erofs_off_t off;
+	erofs_off_t shared_xattrs_size = 0;
 
 	/* check if xattr or shared xattr is disabled */
 	if (cfg.c_inline_xattr_tolerance < 0 ||
 	    cfg.c_inline_xattr_tolerance == INT_MAX)
 		return 0;
 
-	if (shared_xattrs_size || shared_xattrs_count) {
+	if (shared_xattrs_count) {
 		DBG_BUGON(1);
 		return -EINVAL;
 	}
@@ -602,9 +584,26 @@ int erofs_build_shared_xattrs_from_path(const char *path)
 	if (ret)
 		return ret;
 
-	if (!shared_xattrs_size)
+	if (!shared_xattrs_count)
 		goto out;
 
+	sorted_n = malloc(shared_xattrs_count * sizeof(n));
+	if (!sorted_n)
+		return -ENOMEM;
+
+	i = 0;
+	list_for_each_entry_safe(node, n, &shared_xattrs_list, list) {
+		list_del(&node->list);
+		sorted_n[i++] = node;
+
+		shared_xattrs_size += sizeof(struct erofs_xattr_entry);
+		shared_xattrs_size = EROFS_XATTR_ALIGN(shared_xattrs_size +
+				node->item->len[0] + node->item->len[1]);
+
+	}
+	DBG_BUGON(i != shared_xattrs_count);
+	qsort(sorted_n, shared_xattrs_count, sizeof(n), comp_xattr_item);
+
 	buf = calloc(1, shared_xattrs_size);
 	if (!buf)
 		return -ENOMEM;
@@ -622,18 +621,6 @@ int erofs_build_shared_xattrs_from_path(const char *path)
 	sbi.xattr_blkaddr = off / erofs_blksiz();
 	off %= erofs_blksiz();
 	p = 0;
-
-	sorted_n = malloc(shared_xattrs_count * sizeof(n));
-	if (!sorted_n)
-		return -ENOMEM;
-	i = 0;
-	list_for_each_entry_safe(node, n, &shared_xattrs_list, list) {
-		list_del(&node->list);
-		sorted_n[i++] = node;
-	}
-	DBG_BUGON(i != shared_xattrs_count);
-	qsort(sorted_n, shared_xattrs_count, sizeof(n), comp_xattr_item);
-
 	for (i = 0; i < shared_xattrs_count; i++) {
 		struct inode_xattr_node *const tnode = sorted_n[i];
 		struct xattr_item *const item = tnode->item;
@@ -654,11 +641,13 @@ int erofs_build_shared_xattrs_from_path(const char *path)
 	}
 
 	free(sorted_n);
-	bh->fsprivate = buf;
-	bh->op = &erofs_write_shared_xattrs_bhops;
+	bh->op = &erofs_drop_directly_bhops;
+	ret = dev_write(buf, erofs_btell(bh, false), shared_xattrs_size);
+	free(buf);
+	erofs_bdrop(bh, false);
 out:
 	erofs_cleanxattrs(true);
-	return 0;
+	return ret;
 }
 
 char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned int size)
-- 
2.24.4

