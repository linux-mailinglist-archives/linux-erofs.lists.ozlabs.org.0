Return-Path: <linux-erofs+bounces-1137-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2017CBABAC5
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Sep 2025 08:39:07 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cbT132Z85z2yPd;
	Tue, 30 Sep 2025 16:39:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759214343;
	cv=none; b=I7rZLH4cKu1+ME506If8qjpDM9sIM+SLdHuYAWtaNeZ4AJKVeMkg9elFf3nnkM1/MykSvg4+wW3B6KrQAnYUL8F34ChDee2jZYMiXz1EyDmBrUDfkwHld+OWbBMpy0itSYDYLyvhliUmZBUBXy3dzkGlaG1XjjcpwUM4XWPLB6UTs6E66NKjWTyZ8wKx4Cj7ATvZoPkSpcKO51cK7bHx0JIUfkyhmBzndbK6j+piFTmKxiyG+aLmszZWiEu7CN/HCf0quEiGXvLcuAs/bRaNlLOE8NeaTSnm32qHIxWHoU3N57lj3M/V3sVIH68W74V2AgDjW95tu+XH5kmz3YVlrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759214343; c=relaxed/relaxed;
	bh=drv09hJv+Q1wejruWHUxsx+lndxlhBIpaYYq5NoJQmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SRlpx/XkAYJfHdqBYqaWz1srEx+27lpsn/S2ux58xpThT9vhlPj5DDAsvynlI4rxe0gd/JSFIMpdSTEfv3bl7mXZbO5oDm9CtwB52IugetpXRybs2UYdS+u7g0oVkYVua6miX/deXItAvLvSNY5sLDnHAoT9TCBMAVVXR1p+HKj9H5JGK9j1hqwuZoQuk+VP1bNzwuY/dlD70f8FfsGjJTb0J5ZKO5nRLMSzBL5ir0VqV4hGiacjYFFFjJ+o9wYNdTyG1nOH2BQYj2aHYvFIfoU5v2q+N15jvePxg1l9n4ftoOCy8CWfUb9YZ44wPAz9Vi00H7KQGaeVDA2TsY5lxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=XkR2QPe/; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=XkR2QPe/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cbT102D8lz3cZM
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Sep 2025 16:38:58 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1759214335; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=drv09hJv+Q1wejruWHUxsx+lndxlhBIpaYYq5NoJQmQ=;
	b=XkR2QPe/xsN4sLM4N8H5QeWpK+tsKc2EXcUFMXfLbc8HJOOkz9gQWMlgPg8D3TbQ4hO8g+tPJY312mJlABzsOVBW1/QSHc7FBXQEd9sTrt/dNpx3iCCcpKkcvN9+WLhFno451E8aQwZwnXgAD9lbXzFVNR4UI/csz6ChDhLTtWg=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WpARbkX_1759214332 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Sep 2025 14:38:53 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/5] erofs-utils: lib: introduce `struct erofs_xattrmgr`
Date: Tue, 30 Sep 2025 14:38:44 +0800
Message-ID: <20250930063847.2143732-2-hsiangkao@linux.alibaba.com>
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

Leave it as global `g_xattrmgr` for now in this patch.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/xattr.h |   1 +
 lib/importer.c        |   4 +
 lib/xattr.c           | 170 +++++++++++++++++++++---------------------
 3 files changed, 91 insertions(+), 84 deletions(-)

diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index 3a82ad7..dc1e3ed 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -45,6 +45,7 @@ static inline unsigned int xattrblock_offset(struct erofs_inode *vi,
 
 struct erofs_importer;
 
+void erofs_xattr_init(struct erofs_sb_info *sbi);
 int erofs_scan_file_xattrs(struct erofs_inode *inode);
 int erofs_prepare_xattr_ibody(struct erofs_inode *inode, bool noroom);
 char *erofs_export_xattr_ibody(struct erofs_inode *inode);
diff --git a/lib/importer.c b/lib/importer.c
index c855d34..48d6640 100644
--- a/lib/importer.c
+++ b/lib/importer.c
@@ -9,6 +9,7 @@
 #include "erofs/inode.h"
 #include "erofs/print.h"
 #include "erofs/lock.h"
+#include "erofs/xattr.h"
 #include "liberofs_cache.h"
 #include "liberofs_compress.h"
 #include "liberofs_metabox.h"
@@ -46,6 +47,9 @@ int erofs_importer_init(struct erofs_importer *im)
 
 	erofs_importer_global_init();
 
+	subsys = "xattr";
+	erofs_xattr_init(sbi);
+
 	subsys = "compression";
 	err = z_erofs_compress_init(im);
 	if (err)
diff --git a/lib/xattr.c b/lib/xattr.c
index 2e109dc..ec3eb5e 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 /*
- * Originally contributed by an anonymous person,
- * heavily changed by Li Guifu <blucerlee@gmail.com>
- *                and Gao Xiang <hsiangkao@aol.com>
+ * Copyright (C) 2019 Li Guifu <blucerlee@gmail.com>
+ *                    Gao Xiang <xiang@kernel.org>
+ * Copyright (C) 2025 Alibaba Cloud
  */
 #define _GNU_SOURCE
 #include <stdlib.h>
@@ -13,7 +13,7 @@
 #include <sys/stat.h>
 #include <dirent.h>
 #include "erofs/print.h"
-#include "erofs/hashtable.h"
+#include "erofs/list.h"
 #include "erofs/xattr.h"
 #include "erofs/fragments.h"
 #include "erofs/importer.h"
@@ -99,8 +99,6 @@ static ssize_t erofs_sys_lgetxattr(const char *path, const char *name,
 	return -1;
 }
 
-#define EA_HASHTABLE_BITS 16
-
 /* one extra byte for the trailing `\0` of attribute name */
 #define EROFS_XATTR_KSIZE(kvlen)	(kvlen[0] + 1)
 #define EROFS_XATTR_KVSIZE(kvlen)	(EROFS_XATTR_KSIZE(kvlen) + kvlen[1])
@@ -112,26 +110,37 @@ static ssize_t erofs_sys_lgetxattr(const char *path, const char *name,
  * @prefix_len:	the length of the matched long prefix if any;
  *		the length of the matched predefined short prefix otherwise
  */
-struct xattr_item {
-	struct xattr_item *next_shared_xattr;
+struct erofs_xattritem {
+	struct list_head node;
+	struct erofs_xattritem *next_shared_xattr;
 	const char *kvbuf;
 	unsigned int hash[2], len[2], count;
 	int shared_xattr_id;
 	unsigned int prefix, base_index, prefix_len;
-	struct hlist_node node;
 };
 
-struct inode_xattr_node {
+struct erofs_inode_xattr_node {
 	struct list_head list;
-	struct xattr_item *item;
+	struct erofs_xattritem *item;
 };
 
-static DECLARE_HASHTABLE(ea_hashtable, EA_HASHTABLE_BITS);
+static struct erofs_xattrmgr {
+	struct list_head hash[1 << 14];
+	struct erofs_xattritem *shared_xattrs;
+	unsigned int sharedxattr_count;
+} g_xattrmgr;
 
-static struct xattr_item *shared_xattrs_list;
-static unsigned int shared_xattrs_count;
+void erofs_xattr_init(struct erofs_sb_info *sbi)
+{
+	unsigned int i;
 
-static struct xattr_prefix {
+	if (g_xattrmgr.hash[0].next)
+		return;
+	for (i = 0; i < ARRAY_SIZE(g_xattrmgr.hash); ++i)
+		init_list_head(&g_xattrmgr.hash[i]);
+}
+
+static struct erofs_xattr_prefix {
 	const char *prefix;
 	unsigned int prefix_len;
 } xattr_types[] = {
@@ -155,7 +164,7 @@ static struct xattr_prefix {
 
 struct ea_type_node {
 	struct list_head list;
-	struct xattr_prefix type;
+	struct erofs_xattr_prefix type;
 	unsigned int index, base_index, base_len;
 };
 
@@ -165,7 +174,7 @@ static unsigned int ea_prefix_count;
 bool erofs_xattr_prefix_matches(const char *key, unsigned int *index,
 				unsigned int *len)
 {
-	struct xattr_prefix *p;
+	struct erofs_xattr_prefix *p;
 
 	*index = 0;
 	*len = 0;
@@ -191,26 +200,28 @@ static unsigned int BKDRHash(char *str, unsigned int len)
 	return hash;
 }
 
-static unsigned int put_xattritem(struct xattr_item *item)
+static unsigned int put_xattritem(struct erofs_xattritem *item)
 {
 	if (item->count > 1)
 		return --item->count;
-	hash_del(&item->node);
+	list_del(&item->node);
 	free((void *)item->kvbuf);
 	free(item);
 	return 0;
 }
 
-static struct xattr_item *get_xattritem(char *kvbuf, unsigned int len[2])
+static struct erofs_xattritem *get_xattritem(char *kvbuf, unsigned int len[2])
 {
-	struct xattr_item *item;
+	struct erofs_xattritem *item;
 	struct ea_type_node *tnode;
+	struct list_head *head;
 	unsigned int hash[2], hkey;
 
 	hash[0] = BKDRHash(kvbuf, len[0]);
 	hash[1] = BKDRHash(kvbuf + EROFS_XATTR_KSIZE(len), len[1]);
-	hkey = hash[0] ^ hash[1];
-	hash_for_each_possible(ea_hashtable, item, node, hkey) {
+	hkey = (hash[0] ^ hash[1]) & (ARRAY_SIZE(g_xattrmgr.hash) - 1);
+	head = g_xattrmgr.hash + hkey;
+	list_for_each_entry(item, head, node) {
 		if (item->len[0] == len[0] && item->len[1] == len[1] &&
 		    item->hash[0] == hash[0] && item->hash[1] == hash[1] &&
 		    !memcmp(kvbuf, item->kvbuf, EROFS_XATTR_KVSIZE(len))) {
@@ -227,7 +238,7 @@ static struct xattr_item *get_xattritem(char *kvbuf, unsigned int len[2])
 	(void)erofs_xattr_prefix_matches(kvbuf, &item->base_index,
 					 &item->prefix_len);
 	DBG_BUGON(len[0] < item->prefix_len);
-	INIT_HLIST_NODE(&item->node);
+	init_list_head(&item->node);
 	item->count = 1;
 	item->kvbuf = kvbuf;
 	item->len[0] = len[0];
@@ -246,15 +257,15 @@ static struct xattr_item *get_xattritem(char *kvbuf, unsigned int len[2])
 			break;
 		}
 	}
-	hash_add(ea_hashtable, &item->node, hkey);
+	list_add(&item->node, head);
 	return item;
 }
 
-static struct xattr_item *parse_one_xattr(const char *path, const char *key,
-					  unsigned int keylen)
+static struct erofs_xattritem *parse_one_xattr(const char *path, const char *key,
+					       unsigned int keylen)
 {
 	ssize_t ret;
-	struct xattr_item *item;
+	struct erofs_xattritem *item;
 	unsigned int len[2];
 	char *kvbuf;
 
@@ -299,8 +310,8 @@ out:
 	return ERR_PTR(ret);
 }
 
-static struct xattr_item *erofs_get_selabel_xattr(const char *srcpath,
-						  mode_t mode)
+static struct erofs_xattritem *erofs_get_selabel_xattr(const char *srcpath,
+						       mode_t mode)
 {
 #ifdef HAVE_LIBSELINUX
 	if (cfg.sehnd) {
@@ -308,7 +319,7 @@ static struct xattr_item *erofs_get_selabel_xattr(const char *srcpath,
 		int ret;
 		unsigned int len[2];
 		char *kvbuf, *fspath;
-		struct xattr_item *item;
+		struct erofs_xattritem *item;
 
 		if (cfg.mount_point)
 			ret = asprintf(&fspath, "/%s/%s", cfg.mount_point,
@@ -351,9 +362,9 @@ static struct xattr_item *erofs_get_selabel_xattr(const char *srcpath,
 	return NULL;
 }
 
-static int inode_xattr_add(struct list_head *hlist, struct xattr_item *item)
+static int inode_xattr_add(struct list_head *hlist, struct erofs_xattritem *item)
 {
-	struct inode_xattr_node *node = malloc(sizeof(*node));
+	struct erofs_inode_xattr_node *node = malloc(sizeof(*node));
 
 	if (!node)
 		return -ENOMEM;
@@ -363,23 +374,15 @@ static int inode_xattr_add(struct list_head *hlist, struct xattr_item *item)
 	return 0;
 }
 
-static int shared_xattr_add(struct xattr_item *item)
-{
-	item->next_shared_xattr = shared_xattrs_list;
-	shared_xattrs_list = item;
-	return ++shared_xattrs_count;
-}
-
-static int erofs_xattr_add(struct list_head *ixattrs, struct xattr_item *item)
+static int erofs_xattr_add(struct list_head *ixattrs, struct erofs_xattritem *item)
 {
 	if (ixattrs)
 		return inode_xattr_add(ixattrs, item);
 
 	if (item->count == cfg.c_inline_xattr_tolerance + 1) {
-		int ret = shared_xattr_add(item);
-
-		if (ret < 0)
-			return ret;
+		item->next_shared_xattr = g_xattrmgr.shared_xattrs;
+		g_xattrmgr.shared_xattrs = item;
+		++g_xattrmgr.sharedxattr_count;
 	}
 	return 0;
 }
@@ -400,7 +403,7 @@ static int read_xattrs_from_file(const char *path, mode_t mode,
 	ssize_t kllen = erofs_sys_llistxattr(path, NULL, 0);
 	char *keylst, *key, *klend;
 	unsigned int keylen;
-	struct xattr_item *item;
+	struct erofs_xattritem *item;
 	int ret;
 
 	if (kllen < 0 && errno != ENODATA && errno != EOPNOTSUPP) {
@@ -475,7 +478,7 @@ int erofs_setxattr(struct erofs_inode *inode, char *key,
 {
 	char *kvbuf;
 	unsigned int len[2];
-	struct xattr_item *item;
+	struct erofs_xattritem *item;
 
 	len[0] = strlen(key);
 	len[1] = size;
@@ -499,7 +502,7 @@ int erofs_setxattr(struct erofs_inode *inode, char *key,
 
 static void erofs_removexattr(struct erofs_inode *inode, const char *key)
 {
-	struct inode_xattr_node *node, *n;
+	struct erofs_inode_xattr_node *node, *n;
 
 	list_for_each_entry_safe(node, n, &inode->i_xattrs, list) {
 		if (!strcmp(node->item->kvbuf, key)) {
@@ -532,7 +535,7 @@ static int erofs_droid_xattr_set_caps(struct erofs_inode *inode)
 	char *kvbuf;
 	unsigned int len[2];
 	struct vfs_cap_data caps;
-	struct xattr_item *item;
+	struct erofs_xattritem *item;
 
 	if (!capabilities)
 		return 0;
@@ -654,7 +657,7 @@ out:
 }
 
 static inline unsigned int erofs_next_xattr_align(unsigned int pos,
-						  struct xattr_item *item)
+						  struct erofs_xattritem *item)
 {
 	return EROFS_XATTR_ALIGN(pos + sizeof(struct erofs_xattr_entry) +
 			item->len[0] + item->len[1] - item->prefix_len);
@@ -664,7 +667,7 @@ int erofs_prepare_xattr_ibody(struct erofs_inode *inode, bool noroom)
 {
 	unsigned int target_xattr_isize = inode->xattr_isize;
 	struct list_head *ixattrs = &inode->i_xattrs;
-	struct inode_xattr_node *node;
+	struct erofs_inode_xattr_node *node;
 	unsigned int h_shared_count;
 	int ret;
 
@@ -677,7 +680,7 @@ int erofs_prepare_xattr_ibody(struct erofs_inode *inode, bool noroom)
 	h_shared_count = 0;
 	ret = sizeof(struct erofs_xattr_ibody_header);
 	list_for_each_entry(node, ixattrs, list) {
-		struct xattr_item *item = node->item;
+		struct erofs_xattritem *item = node->item;
 
 		if (item->shared_xattr_id >= 0 && h_shared_count < UCHAR_MAX) {
 			++h_shared_count;
@@ -769,33 +772,32 @@ fail:
 
 static void erofs_cleanxattrs(bool sharedxattrs)
 {
+	struct erofs_xattritem *item, *n;
 	unsigned int i;
-	struct xattr_item *item;
-	struct hlist_node *tmp;
 
-	hash_for_each_safe(ea_hashtable, i, tmp, item, node) {
-		if (sharedxattrs && item->shared_xattr_id >= 0)
-			continue;
-
-		hash_del(&item->node);
-		free((void *)item->kvbuf);
-		free(item);
+	for (i = 0; i < ARRAY_SIZE(g_xattrmgr.hash); ++i) {
+		list_for_each_entry_safe(item, n, g_xattrmgr.hash + i, node) {
+			if (sharedxattrs && item->shared_xattr_id >= 0)
+				continue;
+			list_del(&item->node);
+			free((void *)item->kvbuf);
+			free(item);
+		}
 	}
 
 	if (sharedxattrs)
 		return;
-
-	shared_xattrs_count = 0;
+	g_xattrmgr.sharedxattr_count = 0;
 }
 
-static int comp_shared_xattr_item(const void *a, const void *b)
+static int comp_shared_xattritem(const void *a, const void *b)
 {
-	const struct xattr_item *ia, *ib;
+	const struct erofs_xattritem *ia, *ib;
 	unsigned int la, lb;
 	int ret;
 
-	ia = *((const struct xattr_item **)a);
-	ib = *((const struct xattr_item **)b);
+	ia = *((const struct erofs_xattritem **)a);
+	ib = *((const struct erofs_xattritem **)b);
 	la = EROFS_XATTR_KVSIZE(ia->len);
 	lb = EROFS_XATTR_KVSIZE(ib->len);
 
@@ -898,7 +900,7 @@ int erofs_xattr_flush_name_prefixes(struct erofs_importer *im, bool plain)
 	return 0;
 }
 
-static void erofs_write_xattr_entry(char *buf, struct xattr_item *item)
+static void erofs_write_xattr_entry(char *buf, struct erofs_xattritem *item)
 {
 	struct erofs_xattr_entry entry = {
 		.e_name_index = item->prefix,
@@ -919,11 +921,11 @@ static void erofs_write_xattr_entry(char *buf, struct xattr_item *item)
 
 int erofs_build_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *path)
 {
-	int ret;
+	struct erofs_xattritem *item, *n, **sorted_n;
+	unsigned int sharedxattr_count, p, i;
 	struct erofs_buffer_head *bh;
-	struct xattr_item *item, *n, **sorted_n;
 	char *buf;
-	unsigned int p, i;
+	int ret;
 	erofs_off_t off;
 	erofs_off_t shared_xattrs_size = 0;
 
@@ -932,7 +934,7 @@ int erofs_build_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *p
 	    cfg.c_inline_xattr_tolerance == INT_MAX)
 		return 0;
 
-	if (shared_xattrs_count) {
+	if (g_xattrmgr.sharedxattr_count) {
 		DBG_BUGON(1);
 		return -EINVAL;
 	}
@@ -940,25 +942,25 @@ int erofs_build_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *p
 	ret = erofs_count_all_xattrs_from_path(path);
 	if (ret)
 		return ret;
-
-	if (!shared_xattrs_count)
+	sharedxattr_count = g_xattrmgr.sharedxattr_count;
+	if (!sharedxattr_count)
 		goto out;
 
-	sorted_n = malloc((shared_xattrs_count + 1) * sizeof(n));
+	sorted_n = malloc((sharedxattr_count + 1) * sizeof(n));
 	if (!sorted_n)
 		return -ENOMEM;
 
 	i = 0;
-	while (shared_xattrs_list) {
-		item = shared_xattrs_list;
+	while (g_xattrmgr.shared_xattrs) {
+		item = g_xattrmgr.shared_xattrs;
 		sorted_n[i++] = item;
-		shared_xattrs_list = item->next_shared_xattr;
+		g_xattrmgr.shared_xattrs = item->next_shared_xattr;
 		shared_xattrs_size = erofs_next_xattr_align(shared_xattrs_size,
 							    item);
 	}
-	DBG_BUGON(i != shared_xattrs_count);
+	DBG_BUGON(i != sharedxattr_count);
 	sorted_n[i] = NULL;
-	qsort(sorted_n, shared_xattrs_count, sizeof(n), comp_shared_xattr_item);
+	qsort(sorted_n, sharedxattr_count, sizeof(n), comp_shared_xattritem);
 
 	buf = calloc(1, shared_xattrs_size);
 	if (!buf) {
@@ -980,14 +982,14 @@ int erofs_build_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *p
 	sbi->xattr_blkaddr = off / erofs_blksiz(sbi);
 	off %= erofs_blksiz(sbi);
 	p = 0;
-	for (i = 0; i < shared_xattrs_count; i++) {
+	for (i = 0; i < sharedxattr_count; i++) {
 		item = sorted_n[i];
 		erofs_write_xattr_entry(buf + p, item);
 		item->next_shared_xattr = sorted_n[i + 1];
 		item->shared_xattr_id = (off + p) / sizeof(__le32);
 		p = erofs_next_xattr_align(p, item);
 	}
-	shared_xattrs_list = sorted_n[0];
+	g_xattrmgr.shared_xattrs = sorted_n[0];
 	free(sorted_n);
 	bh->op = &erofs_drop_directly_bhops;
 	ret = erofs_dev_write(sbi, buf, erofs_btell(bh, false), shared_xattrs_size);
@@ -1002,8 +1004,8 @@ char *erofs_export_xattr_ibody(struct erofs_inode *inode)
 {
 	struct list_head *ixattrs = &inode->i_xattrs;
 	unsigned int size = inode->xattr_isize;
-	struct inode_xattr_node *node, *n;
-	struct xattr_item *item;
+	struct erofs_inode_xattr_node *node, *n;
+	struct erofs_xattritem *item;
 	struct erofs_xattr_ibody_header *header;
 	LIST_HEAD(ilst);
 	unsigned int p;
-- 
2.43.5


