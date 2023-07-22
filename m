Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B34DA75D9AB
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Jul 2023 06:24:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R7Cxc4g1zz3cP8
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Jul 2023 14:24:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R7CxN1wMrz3bt5
	for <linux-erofs@lists.ozlabs.org>; Sat, 22 Jul 2023 14:24:23 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VnwWuHw_1689999858;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VnwWuHw_1689999858)
          by smtp.aliyun-inc.com;
          Sat, 22 Jul 2023 12:24:19 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v5 3/3] erofs-utils: mkfs: enable xattr name filter
Date: Sat, 22 Jul 2023 12:24:14 +0800
Message-Id: <20230722042414.126630-4-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230722042414.126630-1-jefflexu@linux.alibaba.com>
References: <20230722042414.126630-1-jefflexu@linux.alibaba.com>
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
Cc: alexl@redhat.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Introduce "-Exattr-name-filter" option to enable the xattr name bloom
filter feature.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/erofs/config.h   |  1 +
 include/erofs/internal.h |  1 +
 lib/xattr.c              | 88 ++++++++++++++++++++++++++++++++++++----
 mkfs/main.c              |  7 ++++
 4 files changed, 89 insertions(+), 8 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 8f52d2c..c51f0cd 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -53,6 +53,7 @@ struct erofs_configure {
 	bool c_ignore_mtime;
 	bool c_showprogress;
 	bool c_extra_ea_name_prefixes;
+	bool c_xattr_name_filter;
 
 #ifdef HAVE_LIBSELINUX
 	struct selabel_handle *sehnd;
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index ab964d4..1d7ef73 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -133,6 +133,7 @@ EROFS_FEATURE_FUNCS(fragments, incompat, INCOMPAT_FRAGMENTS)
 EROFS_FEATURE_FUNCS(dedupe, incompat, INCOMPAT_DEDUPE)
 EROFS_FEATURE_FUNCS(xattr_prefixes, incompat, INCOMPAT_XATTR_PREFIXES)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
+EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
 
 #define EROFS_I_EA_INITED	(1 << 0)
 #define EROFS_I_Z_INITED	(1 << 1)
diff --git a/lib/xattr.c b/lib/xattr.c
index 7d7dc54..5870601 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -18,6 +18,7 @@
 #include "erofs/cache.h"
 #include "erofs/io.h"
 #include "erofs/fragments.h"
+#include "erofs/xxhash.h"
 #include "liberofs_private.h"
 
 #define EA_HASHTABLE_BITS 16
@@ -137,27 +138,35 @@ static struct xattr_item *get_xattritem(u8 prefix, char *kvbuf,
 	return item;
 }
 
-static bool match_prefix(const char *key, u8 *index, u16 *len)
+static bool match_short_prefix(const char *key, u8 *index, u16 *len)
 {
 	struct xattr_prefix *p;
-	struct ea_type_node *tnode;
 
-	list_for_each_entry(tnode, &ea_name_prefixes, list) {
-		p = &tnode->type;
+	for (p = xattr_types; p < xattr_types + ARRAY_SIZE(xattr_types); ++p) {
 		if (p->prefix && !strncmp(p->prefix, key, p->prefix_len)) {
 			*len = p->prefix_len;
-			*index = tnode->index;
+			*index = p - xattr_types;
 			return true;
 		}
 	}
-	for (p = xattr_types; p < xattr_types + ARRAY_SIZE(xattr_types); ++p) {
+	return false;
+}
+
+static bool match_prefix(const char *key, u8 *index, u16 *len)
+{
+	struct xattr_prefix *p;
+	struct ea_type_node *tnode;
+
+	list_for_each_entry(tnode, &ea_name_prefixes, list) {
+		p = &tnode->type;
 		if (p->prefix && !strncmp(p->prefix, key, p->prefix_len)) {
 			*len = p->prefix_len;
-			*index = p - xattr_types;
+			*index = tnode->index;
 			return true;
 		}
 	}
-	return false;
+
+	return match_short_prefix(key, index, len);
 }
 
 static struct xattr_item *parse_one_xattr(const char *path, const char *key,
@@ -740,6 +749,64 @@ out:
 	return ret;
 }
 
+
+static int erofs_xattr_filter_hashbit(struct xattr_item *item)
+{
+	u8 prefix = item->prefix;
+	const char *key = item->kvbuf;
+	unsigned int len = item->len[0];
+	char *name = NULL;
+	uint32_t hashbit;
+
+	if (prefix & EROFS_XATTR_LONG_PREFIX) {
+		struct ea_type_node *tnode;
+		u16 prefix_len;
+		int ret;
+
+		list_for_each_entry(tnode, &ea_name_prefixes, list) {
+			if (tnode->index == item->prefix) {
+				ret = asprintf(&name, "%s%.*s",
+					       tnode->type.prefix, len, key);
+				if (ret < 0)
+					return -ENOMEM;
+				break;
+			}
+		}
+		if (!name)
+			return -ENOENT;
+
+		if (!match_short_prefix(name, &prefix, &prefix_len)) {
+			free(name);
+			return -ENOENT;
+		}
+		key = name + prefix_len;
+		len = strlen(name) - prefix_len;
+	}
+
+	hashbit = xxh32(key, len, EROFS_XATTR_FILTER_SEED + prefix);
+	hashbit &= (EROFS_XATTR_FILTER_BITS - 1);
+
+	if (name)
+		free(name);
+	return hashbit;
+}
+
+static u32 erofs_xattr_filter_map(struct list_head *ixattrs)
+{
+	struct inode_xattr_node *node, *n;
+	u32 name_filter;
+	int hashbit;
+
+	name_filter = 0;
+	list_for_each_entry_safe(node, n, ixattrs, list) {
+		hashbit = erofs_xattr_filter_hashbit(node->item);
+		if (hashbit < 0)
+			return 0;
+		name_filter |= (1UL << hashbit);
+	}
+	return EROFS_XATTR_FILTER_DEFAULT & ~name_filter;
+}
+
 char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned int size)
 {
 	struct inode_xattr_node *node, *n;
@@ -754,6 +821,11 @@ char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned int size)
 	header = (struct erofs_xattr_ibody_header *)buf;
 	header->h_shared_count = 0;
 
+	if (cfg.c_xattr_name_filter) {
+		u32 name_filter = erofs_xattr_filter_map(ixattrs);
+		header->h_name_filter = cpu_to_le32(name_filter);
+	}
+
 	p = sizeof(struct erofs_xattr_ibody_header);
 	list_for_each_entry_safe(node, n, ixattrs, list) {
 		struct xattr_item *const item = node->item;
diff --git a/mkfs/main.c b/mkfs/main.c
index ac208e5..7db7847 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -241,6 +241,13 @@ handle_fragment:
 				return -EINVAL;
 			cfg.c_dedupe = true;
 		}
+
+		if (MATCH_EXTENTED_OPT("xattr-name-filter", token, keylen)) {
+			if (vallen)
+				return -EINVAL;
+			cfg.c_xattr_name_filter = true;
+			erofs_sb_set_xattr_filter();
+		}
 	}
 	return 0;
 }
-- 
2.19.1.6.gb485710b

