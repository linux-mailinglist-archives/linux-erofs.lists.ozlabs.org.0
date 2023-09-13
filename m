Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D165379E78B
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Sep 2023 14:03:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rlzd553CNz3cNY
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Sep 2023 22:03:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RlzcS4jSGz3c9K
	for <linux-erofs@lists.ozlabs.org>; Wed, 13 Sep 2023 22:03:20 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vs-dzlt_1694606595;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vs-dzlt_1694606595)
          by smtp.aliyun-inc.com;
          Wed, 13 Sep 2023 20:03:15 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v3] erofs-utils: lib: refactor extended attribute name prefixes
Date: Wed, 13 Sep 2023 20:03:04 +0800
Message-Id: <20230913120304.15741-10-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230913120304.15741-1-jefflexu@linux.alibaba.com>
References: <20230913120304.15741-1-jefflexu@linux.alibaba.com>
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

Previously, the extended attribute name in xattr_item was actually the
part with the matched prefix stripped, which makes it clumsy to strip
or delete a specific attribute from one file.

To fix this, make the complete attribute name stored in xattr_item.
One thing worth noting is that the attribute name in xattr_item has a
trailing '\0' for ease of name comparison, while the trailing '\0' will
get stripped when writing to on-disk erofs_xattr_entry.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
v3:
- introduce EROFS_XATTR_KSIZE() and EROFS_XATTR_KVSIZE() macro
- make the full long name prefix (instead of the infix in v2) stored in
  ea_type_node; and thus compare with the full long name prefix in
  get_xattritem() directly
- convert the data type of in-memory prefix index and prefix_len from
  u8/u16 to unsigned int
---
 lib/xattr.c | 379 ++++++++++++++++++++++------------------------------
 1 file changed, 161 insertions(+), 218 deletions(-)

diff --git a/lib/xattr.c b/lib/xattr.c
index 54a6ae2..8119013 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -51,6 +51,12 @@
 #ifndef XATTR_NAME_POSIX_ACL_DEFAULT
 #define XATTR_NAME_POSIX_ACL_DEFAULT "system.posix_acl_default"
 #endif
+#ifndef XATTR_NAME_SECURITY_SELINUX
+#define XATTR_NAME_SECURITY_SELINUX "security.selinux"
+#endif
+#ifndef XATTR_NAME_SECURITY_CAPABILITY
+#define XATTR_NAME_SECURITY_CAPABILITY "security.capability"
+#endif
 #ifndef OVL_XATTR_NAMESPACE
 #define OVL_XATTR_NAMESPACE "overlay."
 #endif
@@ -72,12 +78,23 @@
 
 #define EA_HASHTABLE_BITS 16
 
+/* extra one byte for the trailing `\0` of attribute name */
+#define EROFS_XATTR_KSIZE(kvlen)	(kvlen[0] + 1)
+#define EROFS_XATTR_KVSIZE(kvlen)	(EROFS_XATTR_KSIZE(kvlen) + kvlen[1])
+
+/*
+ * @base_index:	the index of matched predefined short prefix
+ * @prefix:	the index of matched long prefix if any;
+ *		same as base_index otherwise
+ * @prefix_len:	the length of matched long prefix if any;
+ *		the length of matched predefined short prefix otherwise
+ */
 struct xattr_item {
 	struct xattr_item *next_shared_xattr;
 	const char *kvbuf;
 	unsigned int hash[2], len[2], count;
 	int shared_xattr_id;
-	u8 prefix;
+	unsigned int prefix, base_index, prefix_len;
 	struct hlist_node node;
 };
 
@@ -93,7 +110,7 @@ static unsigned int shared_xattrs_count;
 
 static struct xattr_prefix {
 	const char *prefix;
-	u8 prefix_len;
+	unsigned int prefix_len;
 } xattr_types[] = {
 	[EROFS_XATTR_INDEX_USER] = {
 		XATTR_USER_PREFIX,
@@ -116,11 +133,27 @@ static struct xattr_prefix {
 struct ea_type_node {
 	struct list_head list;
 	struct xattr_prefix type;
-	u8 index;
+	unsigned int index, base_index, base_len;
 };
+
 static LIST_HEAD(ea_name_prefixes);
 static unsigned int ea_prefix_count;
 
+static bool match_prefix(const char *key, unsigned int *index,
+			 unsigned int *len)
+{
+	struct xattr_prefix *p;
+
+	for (p = xattr_types; p < xattr_types + ARRAY_SIZE(xattr_types); ++p) {
+		if (p->prefix && !strncmp(p->prefix, key, p->prefix_len)) {
+			*len = p->prefix_len;
+			*index = p - xattr_types;
+			return true;
+		}
+	}
+	return false;
+}
+
 static unsigned int BKDRHash(char *str, unsigned int len)
 {
 	const unsigned int seed = 131313;
@@ -133,13 +166,12 @@ static unsigned int BKDRHash(char *str, unsigned int len)
 	return hash;
 }
 
-static unsigned int xattr_item_hash(u8 prefix, char *buf,
-				    unsigned int len[2], unsigned int hash[2])
+static unsigned int xattr_item_hash(char *buf, unsigned int len[2],
+				    unsigned int hash[2])
 {
 	hash[0] = BKDRHash(buf, len[0]);	/* key */
 	hash[1] = BKDRHash(buf + len[0], len[1]);	/* value */
-
-	return prefix ^ hash[0] ^ hash[1];
+	return hash[0] ^ hash[1];
 }
 
 static unsigned int put_xattritem(struct xattr_item *item)
@@ -150,17 +182,14 @@ static unsigned int put_xattritem(struct xattr_item *item)
 	return 0;
 }
 
-static struct xattr_item *get_xattritem(u8 prefix, char *kvbuf,
-					unsigned int len[2])
+static struct xattr_item *get_xattritem(char *kvbuf, unsigned int len[2])
 {
 	struct xattr_item *item;
 	unsigned int hash[2], hkey;
 
-	hkey = xattr_item_hash(prefix, kvbuf, len, hash);
-
+	hkey = xattr_item_hash(kvbuf, len, hash);
 	hash_for_each_possible(ea_hashtable, item, node, hkey) {
-		if (prefix == item->prefix &&
-		    item->len[0] == len[0] && item->len[1] == len[1] &&
+		if (item->len[0] == len[0] && item->len[1] == len[1] &&
 		    item->hash[0] == hash[0] && item->hash[1] == hash[1] &&
 		    !memcmp(kvbuf, item->kvbuf, len[0] + len[1])) {
 			free(kvbuf);
@@ -174,6 +203,14 @@ static struct xattr_item *get_xattritem(u8 prefix, char *kvbuf,
 		free(kvbuf);
 		return ERR_PTR(-ENOMEM);
 	}
+
+	if (!match_prefix(kvbuf, &item->base_index, &item->prefix_len)) {
+		free(item);
+		free(kvbuf);
+		return ERR_PTR(-ENODATA);
+	}
+	DBG_BUGON(len[0] < item->prefix_len);
+
 	INIT_HLIST_NODE(&item->node);
 	item->count = 1;
 	item->kvbuf = kvbuf;
@@ -182,56 +219,37 @@ static struct xattr_item *get_xattritem(u8 prefix, char *kvbuf,
 	item->hash[0] = hash[0];
 	item->hash[1] = hash[1];
 	item->shared_xattr_id = -1;
-	item->prefix = prefix;
-	hash_add(ea_hashtable, &item->node, hkey);
-	return item;
-}
+	item->prefix = item->base_index;
 
-static bool match_base_prefix(const char *key, u8 *index, u16 *len)
-{
-	struct xattr_prefix *p;
+	if (cfg.c_extra_ea_name_prefixes) {
+		struct ea_type_node *tnode;
 
-	for (p = xattr_types; p < xattr_types + ARRAY_SIZE(xattr_types); ++p) {
-		if (p->prefix && !strncmp(p->prefix, key, p->prefix_len)) {
-			*len = p->prefix_len;
-			*index = p - xattr_types;
-			return true;
+		list_for_each_entry(tnode, &ea_name_prefixes, list) {
+			if (item->base_index == tnode->base_index &&
+			    !strncmp(tnode->type.prefix, kvbuf,
+				     tnode->type.prefix_len)) {
+				item->prefix = tnode->index;
+				item->prefix_len = tnode->type.prefix_len;
+				break;
+			}
 		}
 	}
-	return false;
-}
 
-static bool match_prefix(const char *key, u8 *index, u16 *len)
-{
-	struct xattr_prefix *p;
-	struct ea_type_node *tnode;
-
-	list_for_each_entry(tnode, &ea_name_prefixes, list) {
-		p = &tnode->type;
-		if (p->prefix && !strncmp(p->prefix, key, p->prefix_len)) {
-			*len = p->prefix_len;
-			*index = tnode->index;
-			return true;
-		}
-	}
-	return match_base_prefix(key, index, len);
+	hash_add(ea_hashtable, &item->node, hkey);
+	return item;
 }
 
 static struct xattr_item *parse_one_xattr(const char *path, const char *key,
 					  unsigned int keylen)
 {
 	ssize_t ret;
-	u8 prefix;
-	u16 prefixlen;
 	unsigned int len[2];
 	char *kvbuf;
 
 	erofs_dbg("parse xattr [%s] of %s", path, key);
 
-	if (!match_prefix(key, &prefix, &prefixlen))
-		return ERR_PTR(-ENODATA);
-
-	DBG_BUGON(keylen < prefixlen);
+	/* length of the key */
+	len[0] = keylen;
 
 	/* determine length of the value */
 #ifdef HAVE_LGETXATTR
@@ -246,19 +264,18 @@ static struct xattr_item *parse_one_xattr(const char *path, const char *key,
 	len[1] = ret;
 
 	/* allocate key-value buffer */
-	len[0] = keylen - prefixlen;
-
-	kvbuf = malloc(len[0] + len[1]);
+	kvbuf = malloc(EROFS_XATTR_KVSIZE(len));
 	if (!kvbuf)
 		return ERR_PTR(-ENOMEM);
-	memcpy(kvbuf, key + prefixlen, len[0]);
+	sprintf(kvbuf, "%s", key);
 	if (len[1]) {
 		/* copy value to buffer */
 #ifdef HAVE_LGETXATTR
-		ret = lgetxattr(path, key, kvbuf + len[0], len[1]);
+		ret = lgetxattr(path, key, kvbuf + EROFS_XATTR_KSIZE(len),
+				len[1]);
 #elif defined(__APPLE__)
-		ret = getxattr(path, key, kvbuf + len[0], len[1], 0,
-			       XATTR_NOFOLLOW);
+		ret = getxattr(path, key, kvbuf + EROFS_XATTR_KSIZE(len),
+			       len[1], 0, XATTR_NOFOLLOW);
 #else
 		free(kvbuf);
 		return ERR_PTR(-EOPNOTSUPP);
@@ -273,7 +290,7 @@ static struct xattr_item *parse_one_xattr(const char *path, const char *key,
 			len[1] = ret;
 		}
 	}
-	return get_xattritem(prefix, kvbuf, len);
+	return get_xattritem(kvbuf, len);
 }
 
 static struct xattr_item *erofs_get_selabel_xattr(const char *srcpath,
@@ -308,16 +325,17 @@ static struct xattr_item *erofs_get_selabel_xattr(const char *srcpath,
 			return NULL;
 		}
 
-		len[0] = sizeof("selinux") - 1;
+		len[0] = sizeof(XATTR_NAME_SECURITY_SELINUX) - 1;
 		len[1] = strlen(secontext);
-		kvbuf = malloc(len[0] + len[1] + 1);
+		kvbuf = malloc(EROFS_XATTR_KVSIZE(len));
 		if (!kvbuf) {
 			freecon(secontext);
 			return ERR_PTR(-ENOMEM);
 		}
-		sprintf(kvbuf, "selinux%s", secontext);
+		sprintf(kvbuf, "%s", XATTR_NAME_SECURITY_SELINUX);
+		memcpy(kvbuf + EROFS_XATTR_KSIZE(len), secontext, len[1]);
 		freecon(secontext);
-		return get_xattritem(EROFS_XATTR_INDEX_SECURITY, kvbuf, len);
+		return get_xattritem(kvbuf, len);
 	}
 #endif
 	return NULL;
@@ -466,24 +484,18 @@ int erofs_setxattr(struct erofs_inode *inode, char *key,
 	char *kvbuf;
 	unsigned int len[2];
 	struct xattr_item *item;
-	u8 prefix;
-	u16 prefixlen;
-
-	if (!match_prefix(key, &prefix, &prefixlen))
-		return -ENODATA;
 
+	len[0] = strlen(key);
 	len[1] = size;
-	/* allocate key-value buffer */
-	len[0] = strlen(key) - prefixlen;
 
-	kvbuf = malloc(len[0] + len[1]);
+	kvbuf = malloc(EROFS_XATTR_KVSIZE(len));
 	if (!kvbuf)
 		return -ENOMEM;
 
-	memcpy(kvbuf, key + prefixlen, len[0]);
-	memcpy(kvbuf + len[0], value, size);
+	sprintf(kvbuf, "%s", key);
+	memcpy(kvbuf + EROFS_XATTR_KSIZE(len), value, size);
 
-	item = get_xattritem(prefix, kvbuf, len);
+	item = get_xattritem(kvbuf, len);
 	if (IS_ERR(item))
 		return PTR_ERR(item);
 	DBG_BUGON(!item);
@@ -513,22 +525,22 @@ static int erofs_droid_xattr_set_caps(struct erofs_inode *inode)
 	if (!capabilities)
 		return 0;
 
-	len[0] = sizeof("capability") - 1;
+	len[0] = sizeof(XATTR_NAME_SECURITY_CAPABILITY) - 1;
 	len[1] = sizeof(caps);
 
-	kvbuf = malloc(len[0] + len[1]);
+	kvbuf = malloc(EROFS_XATTR_KVSIZE(len));
 	if (!kvbuf)
 		return -ENOMEM;
 
-	memcpy(kvbuf, "capability", len[0]);
+	sprintf(kvbuf, "%s", XATTR_NAME_SECURITY_CAPABILITY);
 	caps.magic_etc = VFS_CAP_REVISION_2 | VFS_CAP_FLAGS_EFFECTIVE;
 	caps.data[0].permitted = (u32) capabilities;
 	caps.data[0].inheritable = 0;
 	caps.data[1].permitted = (u32) (capabilities >> 32);
 	caps.data[1].inheritable = 0;
-	memcpy(kvbuf + len[0], &caps, len[1]);
+	memcpy(kvbuf + EROFS_XATTR_KSIZE(len), &caps, len[1]);
 
-	item = get_xattritem(EROFS_XATTR_INDEX_SECURITY, kvbuf, len);
+	item = get_xattritem(kvbuf, len);
 	if (IS_ERR(item))
 		return PTR_ERR(item);
 	DBG_BUGON(!item);
@@ -558,6 +570,13 @@ int erofs_scan_file_xattrs(struct erofs_inode *inode)
 	return erofs_droid_xattr_set_caps(inode);
 }
 
+static inline unsigned int erofs_next_xattr_align(unsigned int pos,
+						  struct xattr_item *item)
+{
+	return EROFS_XATTR_ALIGN(pos + sizeof(struct erofs_xattr_entry) +
+			item->len[0] + item->len[1] - item->prefix_len);
+}
+
 int erofs_prepare_xattr_ibody(struct erofs_inode *inode)
 {
 	int ret;
@@ -572,14 +591,13 @@ int erofs_prepare_xattr_ibody(struct erofs_inode *inode)
 	/* get xattr ibody size */
 	ret = sizeof(struct erofs_xattr_ibody_header);
 	list_for_each_entry(node, ixattrs, list) {
-		const struct xattr_item *item = node->item;
+		struct xattr_item *item = node->item;
 
 		if (item->shared_xattr_id >= 0) {
 			ret += sizeof(__le32);
 			continue;
 		}
-		ret += sizeof(struct erofs_xattr_entry);
-		ret = EROFS_XATTR_ALIGN(ret + item->len[0] + item->len[1]);
+		ret = erofs_next_xattr_align(ret, item);
 	}
 	inode->xattr_isize = ret;
 	return ret;
@@ -688,25 +706,9 @@ static int comp_shared_xattr_item(const void *a, const void *b)
 	return la > lb;
 }
 
-static inline int erofs_xattr_index_by_prefix(const char *prefix, int *len)
-{
-	if (!strncmp(prefix, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN)){
-		*len = XATTR_USER_PREFIX_LEN;
-		return EROFS_XATTR_INDEX_USER;
-	} else if (!strncmp(prefix, XATTR_TRUSTED_PREFIX, XATTR_TRUSTED_PREFIX_LEN)) {
-		*len = XATTR_TRUSTED_PREFIX_LEN;
-		return EROFS_XATTR_INDEX_TRUSTED;
-	} else if (!strncmp(prefix, XATTR_SECURITY_PREFIX, XATTR_SECURITY_PREFIX_LEN)) {
-		*len = XATTR_SECURITY_PREFIX_LEN;
-		return EROFS_XATTR_INDEX_SECURITY;
-	}
-	return -ENODATA;
-}
-
 int erofs_xattr_write_name_prefixes(struct erofs_sb_info *sbi, FILE *f)
 {
 	struct ea_type_node *tnode;
-	struct xattr_prefix *p;
 	off_t offset;
 
 	if (!ea_prefix_count)
@@ -732,16 +734,13 @@ int erofs_xattr_write_name_prefixes(struct erofs_sb_info *sbi, FILE *f)
 			u8 data[EROFS_NAME_LEN + 2 +
 				sizeof(struct erofs_xattr_long_prefix)];
 		} u;
-		int ret, len;
+		int len, infix_len;
 
-		p = &tnode->type;
-		ret = erofs_xattr_index_by_prefix(p->prefix, &len);
-		if (ret < 0)
-			return ret;
-		u.s.prefix.base_index = ret;
-		memcpy(u.s.prefix.infix, p->prefix + len, p->prefix_len - len);
-		len = sizeof(struct erofs_xattr_long_prefix) +
-			p->prefix_len - len;
+		u.s.prefix.base_index = tnode->base_index;
+		infix_len = tnode->type.prefix_len - tnode->base_len;
+		memcpy(u.s.prefix.infix, tnode->type.prefix + tnode->base_len,
+		       infix_len);
+		len = sizeof(struct erofs_xattr_long_prefix) + infix_len;
 		u.s.size = cpu_to_le16(len);
 		if (fwrite(&u.s, sizeof(__le16) + len, 1, f) != 1)
 			return -EIO;
@@ -754,11 +753,30 @@ int erofs_xattr_write_name_prefixes(struct erofs_sb_info *sbi, FILE *f)
 	return 0;
 }
 
+static void erofs_write_xattr_entry(char *buf, struct xattr_item *item)
+{
+	struct erofs_xattr_entry entry = {
+		.e_name_index = item->prefix,
+		.e_name_len = item->len[0] - item->prefix_len,
+		.e_value_size = cpu_to_le16(item->len[1]),
+	};
+
+	memcpy(buf, &entry, sizeof(entry));
+	buf += sizeof(struct erofs_xattr_entry);
+	memcpy(buf, item->kvbuf + item->prefix_len,
+	       item->len[0] - item->prefix_len);
+	buf += item->len[0] - item->prefix_len;
+	memcpy(buf, item->kvbuf + item->len[0] + 1, item->len[1]);
+
+	erofs_dbg("writing xattr %d %s (%d %s)", item->base_index, item->kvbuf,
+			item->prefix, item->kvbuf + item->prefix_len);
+}
+
 int erofs_build_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *path)
 {
 	int ret;
 	struct erofs_buffer_head *bh;
-	struct xattr_item *n, **sorted_n;
+	struct xattr_item *item, *n, **sorted_n;
 	char *buf;
 	unsigned int p, i;
 	erofs_off_t off;
@@ -787,13 +805,11 @@ int erofs_build_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *p
 
 	i = 0;
 	while (shared_xattrs_list) {
-		struct xattr_item *item = shared_xattrs_list;
-
+		item = shared_xattrs_list;
 		sorted_n[i++] = item;
 		shared_xattrs_list = item->next_shared_xattr;
-		shared_xattrs_size += sizeof(struct erofs_xattr_entry);
-		shared_xattrs_size = EROFS_XATTR_ALIGN(shared_xattrs_size +
-				item->len[0] + item->len[1]);
+		shared_xattrs_size = erofs_next_xattr_align(shared_xattrs_size,
+							    item);
 	}
 	DBG_BUGON(i != shared_xattrs_count);
 	sorted_n[i] = NULL;
@@ -820,20 +836,11 @@ int erofs_build_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *p
 	off %= erofs_blksiz(sbi);
 	p = 0;
 	for (i = 0; i < shared_xattrs_count; i++) {
-		struct xattr_item *item = sorted_n[i];
-		const struct erofs_xattr_entry entry = {
-			.e_name_index = item->prefix,
-			.e_name_len = item->len[0],
-			.e_value_size = cpu_to_le16(item->len[1])
-		};
-
+		item = sorted_n[i];
+		erofs_write_xattr_entry(buf + p, item);
 		item->next_shared_xattr = sorted_n[i + 1];
 		item->shared_xattr_id = (off + p) / sizeof(__le32);
-
-		memcpy(buf + p, &entry, sizeof(entry));
-		p += sizeof(struct erofs_xattr_entry);
-		memcpy(buf + p, item->kvbuf, item->len[0] + item->len[1]);
-		p = EROFS_XATTR_ALIGN(p + item->len[0] + item->len[1]);
+		p = erofs_next_xattr_align(p, item);
 	}
 	shared_xattrs_list = sorted_n[0];
 	free(sorted_n);
@@ -846,70 +853,12 @@ out:
 	return ret;
 }
 
-static int erofs_xattr_filter_hashbit(struct xattr_item *item)
-{
-	u8 prefix = item->prefix;
-	const char *key = item->kvbuf;
-	unsigned int len = item->len[0];
-	char *name = NULL;
-	uint32_t hashbit;
-
-	if (prefix & EROFS_XATTR_LONG_PREFIX) {
-		struct ea_type_node *tnode;
-		u16 prefix_len;
-		int ret;
-
-		list_for_each_entry(tnode, &ea_name_prefixes, list) {
-			if (tnode->index == item->prefix) {
-				ret = asprintf(&name, "%s%.*s",
-					       tnode->type.prefix, len, key);
-				if (ret < 0)
-					return -ENOMEM;
-				break;
-			}
-		}
-		if (!name)
-			return -ENOENT;
-
-		if (!match_base_prefix(name, &prefix, &prefix_len)) {
-			free(name);
-			return -ENOENT;
-		}
-		key = name + prefix_len;
-		len = strlen(key);
-	}
-
-	hashbit = xxh32(key, len, EROFS_XATTR_FILTER_SEED + prefix) &
-		  (EROFS_XATTR_FILTER_BITS - 1);
-	if (name)
-		free(name);
-	return hashbit;
-}
-
-static u32 erofs_xattr_filter_map(struct list_head *ixattrs)
-{
-	struct inode_xattr_node *node, *n;
-	u32 name_filter;
-	int hashbit;
-
-	name_filter = 0;
-	list_for_each_entry_safe(node, n, ixattrs, list) {
-		hashbit = erofs_xattr_filter_hashbit(node->item);
-		if (hashbit < 0) {
-			erofs_warn("failed to generate xattr name filter: %s",
-				   strerror(-hashbit));
-			return 0;
-		}
-		name_filter |= (1UL << hashbit);
-	}
-	return EROFS_XATTR_FILTER_DEFAULT & ~name_filter;
-}
-
 char *erofs_export_xattr_ibody(struct erofs_inode *inode)
 {
 	struct list_head *ixattrs = &inode->i_xattrs;
 	unsigned int size = inode->xattr_isize;
 	struct inode_xattr_node *node, *n;
+	struct xattr_item *item;
 	struct erofs_xattr_ibody_header *header;
 	LIST_HEAD(ilst);
 	unsigned int p;
@@ -922,16 +871,29 @@ char *erofs_export_xattr_ibody(struct erofs_inode *inode)
 	header->h_shared_count = 0;
 
 	if (cfg.c_xattr_name_filter) {
-		header->h_name_filter =
-			cpu_to_le32(erofs_xattr_filter_map(ixattrs));
+		u32 name_filter = 0;
+		int hashbit;
+		unsigned int base_len;
+
+		list_for_each_entry(node, ixattrs, list) {
+			item = node->item;
+			base_len = xattr_types[item->base_index].prefix_len;
+			hashbit = xxh32(item->kvbuf + base_len,
+					item->len[0] - base_len,
+					EROFS_XATTR_FILTER_SEED + item->base_index) &
+				  (EROFS_XATTR_FILTER_BITS - 1);
+			name_filter |= (1UL << hashbit);
+		}
+		name_filter = EROFS_XATTR_FILTER_DEFAULT & ~name_filter;
+
+		header->h_name_filter = cpu_to_le32(name_filter);
 		if (header->h_name_filter)
 			erofs_sb_set_xattr_filter(inode->sbi);
 	}
 
 	p = sizeof(struct erofs_xattr_ibody_header);
 	list_for_each_entry_safe(node, n, ixattrs, list) {
-		struct xattr_item *const item = node->item;
-
+		item = node->item;
 		list_del(&node->list);
 
 		/* move inline xattrs to the onstack list */
@@ -948,18 +910,9 @@ char *erofs_export_xattr_ibody(struct erofs_inode *inode)
 	}
 
 	list_for_each_entry_safe(node, n, &ilst, list) {
-		struct xattr_item *const item = node->item;
-		const struct erofs_xattr_entry entry = {
-			.e_name_index = item->prefix,
-			.e_name_len = item->len[0],
-			.e_value_size = cpu_to_le16(item->len[1])
-		};
-
-		memcpy(buf + p, &entry, sizeof(entry));
-		p += sizeof(struct erofs_xattr_entry);
-		memcpy(buf + p, item->kvbuf, item->len[0] + item->len[1]);
-		p = EROFS_XATTR_ALIGN(p + item->len[0] + item->len[1]);
-
+		item = node->item;
+		erofs_write_xattr_entry(buf + p, item);
+		p = erofs_next_xattr_align(p, item);
 		list_del(&node->list);
 		free(node);
 		put_xattritem(item);
@@ -1354,8 +1307,7 @@ int erofs_getxattr(struct erofs_inode *vi, const char *name, char *buffer,
 		   size_t buffer_size)
 {
 	int ret;
-	u8 prefix;
-	u16 prefixlen;
+	unsigned int prefix, prefixlen;
 	struct getxattr_iter it;
 
 	if (!name)
@@ -1365,7 +1317,7 @@ int erofs_getxattr(struct erofs_inode *vi, const char *name, char *buffer,
 	if (ret)
 		return ret;
 
-	if (!match_base_prefix(name, &prefix, &prefixlen))
+	if (!match_prefix(name, &prefix, &prefixlen))
 		return -ENODATA;
 
 	it.it.sbi = vi->sbi;
@@ -1532,34 +1484,25 @@ int erofs_listxattr(struct erofs_inode *vi, char *buffer, size_t buffer_size)
 int erofs_xattr_insert_name_prefix(const char *prefix)
 {
 	struct ea_type_node *tnode;
-	struct xattr_prefix *p;
-	bool matched = false;
-	char *s;
 
 	if (ea_prefix_count >= 0x80 || strlen(prefix) > UINT8_MAX)
 		return -EOVERFLOW;
 
-	for (p = xattr_types; p < xattr_types + ARRAY_SIZE(xattr_types); ++p) {
-		if (!strncmp(p->prefix, prefix, p->prefix_len)) {
-			matched = true;
-			break;
-		}
-	}
-	if (!matched)
-		return -ENODATA;
-
-	s = strdup(prefix);
-	if (!s)
+	tnode = calloc(1, sizeof(*tnode));
+	if (!tnode)
 		return -ENOMEM;
 
-	tnode = malloc(sizeof(*tnode));
-	if (!tnode) {
-		free(s);
-		return -ENOMEM;
+	if (!match_prefix(prefix, &tnode->base_index, &tnode->base_len)) {
+		free(tnode);
+		return -ENODATA;
 	}
 
-	tnode->type.prefix = s;
 	tnode->type.prefix_len = strlen(prefix);
+	tnode->type.prefix = strdup(prefix);
+	if (!tnode->type.prefix) {
+		free(tnode);
+		return -ENOMEM;
+	}
 
 	tnode->index = EROFS_XATTR_LONG_PREFIX | ea_prefix_count;
 	ea_prefix_count++;
-- 
2.19.1.6.gb485710b

