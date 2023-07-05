Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B03747B6E
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jul 2023 04:10:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QwjnB5z2rz3072
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jul 2023 12:10:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qwjn40jStz3072
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Jul 2023 12:10:46 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VmepWMe_1688523040;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VmepWMe_1688523040)
          by smtp.aliyun-inc.com;
          Wed, 05 Jul 2023 10:10:41 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: mkfs: don't clean cached xattr items prematurely
Date: Wed,  5 Jul 2023 10:10:40 +0800
Message-Id: <20230705021040.76265-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Extended attributes read from file are cached in a hash table when
building shared extended attributes.  However the cached xattr items
for inline xattrs are cleaned up from the hash table when the processing
for shared extended attributes has finished, while later the hash table
is reconstructed from scratch when building the inode tree (see
erofs_mkfs_build_tree_from_path()).

Don't clean up the xattr hash table halfway until mkfs exits.  Also move
the logic of cleaning long xattr name prefixes into erofs_cleanxattrs().

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/erofs/xattr.h |  2 +-
 lib/xattr.c           | 30 ++++++++----------------------
 mkfs/main.c           |  2 +-
 3 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index 14fc081..b202f78 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -75,9 +75,9 @@ static inline unsigned int xattrblock_offset(unsigned int xattr_id)
 int erofs_prepare_xattr_ibody(struct erofs_inode *inode);
 char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned int size);
 int erofs_build_shared_xattrs_from_path(const char *path);
+void erofs_cleanxattrs(void);
 
 int erofs_xattr_insert_name_prefix(const char *prefix);
-void erofs_xattr_cleanup_name_prefixes(void);
 int erofs_xattr_write_name_prefixes(FILE *f);
 
 #ifdef __cplusplus
diff --git a/lib/xattr.c b/lib/xattr.c
index 7d7dc54..8d0079f 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -547,24 +547,23 @@ fail:
 	return ret;
 }
 
-static void erofs_cleanxattrs(bool sharedxattrs)
+void erofs_cleanxattrs(void)
 {
 	unsigned int i;
 	struct xattr_item *item;
 	struct hlist_node *tmp;
+	struct ea_type_node *tnode, *n;
 
 	hash_for_each_safe(ea_hashtable, i, tmp, item, node) {
-		if (sharedxattrs && item->shared_xattr_id >= 0)
-			continue;
-
 		hash_del(&item->node);
 		free(item);
 	}
 
-	if (sharedxattrs)
-		return;
-
-	shared_xattrs_count = 0;
+	list_for_each_entry_safe(tnode, n, &ea_name_prefixes, list) {
+		list_del(&tnode->list);
+		free((void *)tnode->type.prefix);
+		free(tnode);
+	}
 }
 
 static int comp_shared_xattr_item(const void *a, const void *b)
@@ -676,7 +675,7 @@ int erofs_build_shared_xattrs_from_path(const char *path)
 		return ret;
 
 	if (!shared_xattrs_count)
-		goto out;
+		return 0;
 
 	sorted_n = malloc((shared_xattrs_count + 1) * sizeof(n));
 	if (!sorted_n)
@@ -735,8 +734,6 @@ int erofs_build_shared_xattrs_from_path(const char *path)
 	ret = dev_write(buf, erofs_btell(bh, false), shared_xattrs_size);
 	free(buf);
 	erofs_bdrop(bh, false);
-out:
-	erofs_cleanxattrs(true);
 	return ret;
 }
 
@@ -1340,14 +1337,3 @@ int erofs_xattr_insert_name_prefix(const char *prefix)
 	list_add_tail(&tnode->list, &ea_name_prefixes);
 	return 0;
 }
-
-void erofs_xattr_cleanup_name_prefixes(void)
-{
-	struct ea_type_node *tnode, *n;
-
-	list_for_each_entry_safe(tnode, n, &ea_name_prefixes, list) {
-		list_del(&tnode->list);
-		free((void *)tnode->type.prefix);
-		free(tnode);
-	}
-}
diff --git a/mkfs/main.c b/mkfs/main.c
index ac208e5..390ef17 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -942,7 +942,7 @@ exit:
 	if (cfg.c_fragments)
 		z_erofs_fragments_exit();
 	erofs_packedfile_exit();
-	erofs_xattr_cleanup_name_prefixes();
+	erofs_cleanxattrs();
 	erofs_exit_configure();
 
 	if (err) {
-- 
2.19.1.6.gb485710b

