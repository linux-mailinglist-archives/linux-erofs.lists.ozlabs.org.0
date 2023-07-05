Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 370C9747DFA
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jul 2023 09:10:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QwrR30vHmz3bXk
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jul 2023 17:10:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QwrQp6lzPz2x9L
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Jul 2023 17:10:26 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vmfk07t_1688541020;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vmfk07t_1688541020)
          by smtp.aliyun-inc.com;
          Wed, 05 Jul 2023 15:10:21 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 3/3] erofs-utils: mkfs: enable xattr name filter
Date: Wed,  5 Jul 2023 15:10:17 +0800
Message-Id: <20230705071017.104130-4-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230705071017.104130-1-jefflexu@linux.alibaba.com>
References: <20230705071017.104130-1-jefflexu@linux.alibaba.com>
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

Introduce "--xattr-filter" option to enable the xattr name bloom filter
feature.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/erofs/config.h   |  1 +
 include/erofs/internal.h |  1 +
 lib/xattr.c              | 74 +++++++++++++++++++++++++++++++---------
 mkfs/main.c              |  6 ++++
 4 files changed, 66 insertions(+), 16 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 8f52d2c..2803f37 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -53,6 +53,7 @@ struct erofs_configure {
 	bool c_ignore_mtime;
 	bool c_showprogress;
 	bool c_extra_ea_name_prefixes;
+	bool c_xattr_filter;
 
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
index 7d7dc54..c9126c6 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -18,6 +18,7 @@
 #include "erofs/cache.h"
 #include "erofs/io.h"
 #include "erofs/fragments.h"
+#include "erofs/xxhash.h"
 #include "liberofs_private.h"
 
 #define EA_HASHTABLE_BITS 16
@@ -26,6 +27,7 @@ struct xattr_item {
 	struct xattr_item *next_shared_xattr;
 	const char *kvbuf;
 	unsigned int hash[2], len[2], count;
+	unsigned int name_filter_bit;
 	int shared_xattr_id;
 	u8 prefix;
 	struct hlist_node node;
@@ -101,7 +103,8 @@ static unsigned int put_xattritem(struct xattr_item *item)
 }
 
 static struct xattr_item *get_xattritem(u8 prefix, char *kvbuf,
-					unsigned int len[2])
+					unsigned int len[2],
+					unsigned int name_filter_bit)
 {
 	struct xattr_item *item;
 	unsigned int hash[2], hkey;
@@ -133,40 +136,59 @@ static struct xattr_item *get_xattritem(u8 prefix, char *kvbuf,
 	item->hash[1] = hash[1];
 	item->shared_xattr_id = -1;
 	item->prefix = prefix;
+	item->name_filter_bit = name_filter_bit;
 	hash_add(ea_hashtable, &item->node, hkey);
 	return item;
 }
 
-static bool match_prefix(const char *key, u8 *index, u16 *len)
+static unsigned int erofs_xattr_calc_name_filter_bit(u8 prefix, const char *key,
+						     unsigned int len)
+{
+	if (!cfg.c_xattr_filter)
+		return 0;
+	return xxh32(key, len, EROFS_XATTR_FILTER_SEED + prefix) &
+			EROFS_XATTR_FILTER_MASK;
+}
+
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
 					  unsigned int keylen)
 {
 	ssize_t ret;
-	u8 prefix;
-	u16 prefixlen;
+	u8 prefix, o_prefix;
+	u16 prefixlen, o_prefixlen;
 	unsigned int len[2];
+	unsigned int bit = 0;
 	char *kvbuf;
 
 	erofs_dbg("parse xattr [%s] of %s", path, key);
@@ -176,6 +198,13 @@ static struct xattr_item *parse_one_xattr(const char *path, const char *key,
 
 	DBG_BUGON(keylen < prefixlen);
 
+	if (cfg.c_xattr_filter) {
+		if (!match_short_prefix(key, &o_prefix, &o_prefixlen))
+			return ERR_PTR(-ENODATA);
+		bit = erofs_xattr_calc_name_filter_bit(o_prefix,
+				key + o_prefixlen, keylen - o_prefixlen);
+	}
+
 	/* determine length of the value */
 #ifdef HAVE_LGETXATTR
 	ret = lgetxattr(path, key, NULL, 0);
@@ -216,7 +245,7 @@ static struct xattr_item *parse_one_xattr(const char *path, const char *key,
 			len[1] = ret;
 		}
 	}
-	return get_xattritem(prefix, kvbuf, len);
+	return get_xattritem(prefix, kvbuf, len, bit);
 }
 
 static struct xattr_item *erofs_get_selabel_xattr(const char *srcpath,
@@ -226,7 +255,7 @@ static struct xattr_item *erofs_get_selabel_xattr(const char *srcpath,
 	if (cfg.sehnd) {
 		char *secontext;
 		int ret;
-		unsigned int len[2];
+		unsigned int bit, len[2];
 		char *kvbuf, *fspath;
 
 		if (cfg.mount_point)
@@ -260,7 +289,8 @@ static struct xattr_item *erofs_get_selabel_xattr(const char *srcpath,
 		}
 		sprintf(kvbuf, "selinux%s", secontext);
 		freecon(secontext);
-		return get_xattritem(EROFS_XATTR_INDEX_SECURITY, kvbuf, len);
+		bit = erofs_xattr_calc_name_filter_bit(EROFS_XATTR_INDEX_SECURITY, "selinux", len[0]);
+		return get_xattritem(EROFS_XATTR_INDEX_SECURITY, kvbuf, len, bit);
 	}
 #endif
 	return NULL;
@@ -408,7 +438,7 @@ static int erofs_droid_xattr_set_caps(struct erofs_inode *inode)
 {
 	const u64 capabilities = inode->capabilities;
 	char *kvbuf;
-	unsigned int len[2];
+	unsigned int bit, len[2];
 	struct vfs_cap_data caps;
 	struct xattr_item *item;
 
@@ -430,7 +460,8 @@ static int erofs_droid_xattr_set_caps(struct erofs_inode *inode)
 	caps.data[1].inheritable = 0;
 	memcpy(kvbuf + len[0], &caps, len[1]);
 
-	item = get_xattritem(EROFS_XATTR_INDEX_SECURITY, kvbuf, len);
+	bit = erofs_xattr_calc_name_filter_bit(EROFS_XATTR_INDEX_SECURITY, "capability", len[0]);
+	item = get_xattritem(EROFS_XATTR_INDEX_SECURITY, kvbuf, len, bit);
 	if (IS_ERR(item))
 		return PTR_ERR(item);
 	if (!item)
@@ -754,6 +785,17 @@ char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned int size)
 	header = (struct erofs_xattr_ibody_header *)buf;
 	header->h_shared_count = 0;
 
+	if (cfg.c_xattr_filter) {
+		u32 name_filter = 0;
+
+		list_for_each_entry_safe(node, n, ixattrs, list) {
+			struct xattr_item *const item = node->item;
+			name_filter |= 1UL << item->name_filter_bit;
+		}
+		name_filter = EROFS_XATTR_FILTER_DEFAULT & ~name_filter;
+		header->h_name_filter = cpu_to_le32(name_filter);
+	}
+
 	p = sizeof(struct erofs_xattr_ibody_header);
 	list_for_each_entry_safe(node, n, ixattrs, list) {
 		struct xattr_item *const item = node->item;
diff --git a/mkfs/main.c b/mkfs/main.c
index ac208e5..84d4414 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -58,6 +58,7 @@ static struct option long_options[] = {
 	{"gid-offset", required_argument, NULL, 17},
 	{"mount-point", required_argument, NULL, 512},
 	{"xattr-prefix", required_argument, NULL, 19},
+	{"xattr-filter", no_argument, NULL, 20},
 #ifdef WITH_ANDROID
 	{"product-out", required_argument, NULL, 513},
 	{"fs-config-file", required_argument, NULL, 514},
@@ -118,6 +119,7 @@ static void usage(void)
 	      " --random-algorithms   randomize per-file algorithms (debugging only)\n"
 #endif
 	      " --xattr-prefix=X      X=extra xattr name prefix\n"
+	      " --xattr-filter	      enable xattr name bloom filter\n"
 	      " --mount-point=X       X=prefix of target fs path (default: /)\n"
 #ifdef WITH_ANDROID
 	      "\nwith following android-specific options:\n"
@@ -482,6 +484,10 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			}
 			cfg.c_extra_ea_name_prefixes = true;
 			break;
+		case 20:
+			cfg.c_xattr_filter = true;
+			erofs_sb_set_xattr_filter();
+			break;
 		case 1:
 			usage();
 			exit(0);
-- 
2.19.1.6.gb485710b

