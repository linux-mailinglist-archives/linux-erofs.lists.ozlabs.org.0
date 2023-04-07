Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 556DB6DADAF
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Apr 2023 15:38:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PtKFc1vRkz3fXN
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Apr 2023 23:38:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PtKFQ4ghWz3fSj
	for <linux-erofs@lists.ozlabs.org>; Fri,  7 Apr 2023 23:38:17 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VfWxv18_1680874692;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VfWxv18_1680874692)
          by smtp.aliyun-inc.com;
          Fri, 07 Apr 2023 21:38:12 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 3/3] erofs-utils: xattr: avoid using inode_xattr_node for shared xattrs
Date: Fri,  7 Apr 2023 21:38:05 +0800
Message-Id: <20230407133805.60975-3-hsiangkao@linux.alibaba.com>
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

Let's introduce next_shared_xattr instead to chain shared xattrs,
and it will also be used for ranged shared xattrs.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/xattr.c | 43 +++++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/lib/xattr.c b/lib/xattr.c
index 5f11cbe..6034e7b 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -22,6 +22,7 @@
 #define EA_HASHTABLE_BITS 16
 
 struct xattr_item {
+	struct xattr_item *next_shared_xattr;
 	const char *kvbuf;
 	unsigned int hash[2], len[2], count;
 	int shared_xattr_id;
@@ -36,7 +37,7 @@ struct inode_xattr_node {
 
 static DECLARE_HASHTABLE(ea_hashtable, EA_HASHTABLE_BITS);
 
-static LIST_HEAD(shared_xattrs_list);
+static struct xattr_item *shared_xattrs_list;
 static unsigned int shared_xattrs_count;
 
 static struct xattr_prefix {
@@ -261,14 +262,8 @@ static int inode_xattr_add(struct list_head *hlist, struct xattr_item *item)
 
 static int shared_xattr_add(struct xattr_item *item)
 {
-	struct inode_xattr_node *node = malloc(sizeof(*node));
-
-	if (!node)
-		return -ENOMEM;
-
-	init_list_head(&node->list);
-	node->item = item;
-	list_add(&node->list, &shared_xattrs_list);
+	item->next_shared_xattr = shared_xattrs_list;
+	shared_xattrs_list = item;
 	return ++shared_xattrs_count;
 }
 
@@ -542,14 +537,14 @@ static void erofs_cleanxattrs(bool sharedxattrs)
 	shared_xattrs_count = 0;
 }
 
-static int comp_xattr_item(const void *a, const void *b)
+static int comp_shared_xattr_item(const void *a, const void *b)
 {
 	const struct xattr_item *ia, *ib;
 	unsigned int la, lb;
 	int ret;
 
-	ia = (*((const struct inode_xattr_node **)a))->item;
-	ib = (*((const struct inode_xattr_node **)b))->item;
+	ia = *((const struct xattr_item **)a);
+	ib = *((const struct xattr_item **)b);
 	la = ia->len[0] + ia->len[1];
 	lb = ib->len[0] + ib->len[1];
 
@@ -564,7 +559,7 @@ int erofs_build_shared_xattrs_from_path(const char *path)
 {
 	int ret;
 	struct erofs_buffer_head *bh;
-	struct inode_xattr_node *node, *n, **sorted_n;
+	struct xattr_item *n, **sorted_n;
 	char *buf;
 	unsigned int p, i;
 	erofs_off_t off;
@@ -587,22 +582,23 @@ int erofs_build_shared_xattrs_from_path(const char *path)
 	if (!shared_xattrs_count)
 		goto out;
 
-	sorted_n = malloc(shared_xattrs_count * sizeof(n));
+	sorted_n = malloc((shared_xattrs_count + 1) * sizeof(n));
 	if (!sorted_n)
 		return -ENOMEM;
 
 	i = 0;
-	list_for_each_entry_safe(node, n, &shared_xattrs_list, list) {
-		list_del(&node->list);
-		sorted_n[i++] = node;
+	while (shared_xattrs_list) {
+		struct xattr_item *item = shared_xattrs_list;
 
+		sorted_n[i++] = item;
+		shared_xattrs_list = item->next_shared_xattr;
 		shared_xattrs_size += sizeof(struct erofs_xattr_entry);
 		shared_xattrs_size = EROFS_XATTR_ALIGN(shared_xattrs_size +
-				node->item->len[0] + node->item->len[1]);
-
+				item->len[0] + item->len[1]);
 	}
 	DBG_BUGON(i != shared_xattrs_count);
-	qsort(sorted_n, shared_xattrs_count, sizeof(n), comp_xattr_item);
+	sorted_n[i] = NULL;
+	qsort(sorted_n, shared_xattrs_count, sizeof(n), comp_shared_xattr_item);
 
 	buf = calloc(1, shared_xattrs_size);
 	if (!buf)
@@ -622,14 +618,14 @@ int erofs_build_shared_xattrs_from_path(const char *path)
 	off %= erofs_blksiz();
 	p = 0;
 	for (i = 0; i < shared_xattrs_count; i++) {
-		struct inode_xattr_node *const tnode = sorted_n[i];
-		struct xattr_item *const item = tnode->item;
+		struct xattr_item *item = sorted_n[i];
 		const struct erofs_xattr_entry entry = {
 			.e_name_index = item->prefix,
 			.e_name_len = item->len[0],
 			.e_value_size = cpu_to_le16(item->len[1])
 		};
 
+		item->next_shared_xattr = sorted_n[i + 1];
 		item->shared_xattr_id = (off + p) /
 			sizeof(struct erofs_xattr_entry);
 
@@ -637,9 +633,8 @@ int erofs_build_shared_xattrs_from_path(const char *path)
 		p += sizeof(struct erofs_xattr_entry);
 		memcpy(buf + p, item->kvbuf, item->len[0] + item->len[1]);
 		p = EROFS_XATTR_ALIGN(p + item->len[0] + item->len[1]);
-		free(tnode);
 	}
-
+	shared_xattrs_list = sorted_n[0];
 	free(sorted_n);
 	bh->op = &erofs_drop_directly_bhops;
 	ret = dev_write(buf, erofs_btell(bh, false), shared_xattrs_size);
-- 
2.24.4

