Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8CC79C91F
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Sep 2023 10:00:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RlGGq0ht8z3cDg
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Sep 2023 18:00:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RlGGg0TL5z3c9d
	for <linux-erofs@lists.ozlabs.org>; Tue, 12 Sep 2023 18:00:25 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vrw-8HL_1694505617;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vrw-8HL_1694505617)
          by smtp.aliyun-inc.com;
          Tue, 12 Sep 2023 16:00:17 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs-utils: lib: refactor extended attribute name prefixes
Date: Tue, 12 Sep 2023 16:00:15 +0800
Message-Id: <20230912080015.111464-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230912080015.111464-1-jefflexu@linux.alibaba.com>
References: <20230912080015.111464-1-jefflexu@linux.alibaba.com>
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

Previously, when an extended attribute (xattr) name matches a long name
prefix, the attribute name after stripping the long name prefix is
cached in xattr_item.  This is somewhat different with those that don't
match any long name prefix or when long name prefixes feature is not
enabled, in which case the attribute name after stripping the predefined
short name prefix is cached in xattr_item.

The implementation described above makes it clumsy when stripping or
deleting specific attribute from one file, if the attribute name is in
the long name prefix format.

To fix this, for those attribute names that match the long name prefix,
make the attribute name with the predefined short name prefix stripped
cached in xattr_item just like normal attribute names.

To achieve this, add two new members `index` and `infix_len` to
xattr_item.  The semantics of the original `prefix` member is unchanged,
i.e. representing the index of the matched predefined short name prefix,
while `index` member represents the index of the long name prefix if
any, or it's the same as `prefix` otherwise.  The `infix_len` member
represents the length of the infix of the long name preifx if any, or 0
otherwise.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 lib/xattr.c | 253 +++++++++++++++++++---------------------------------
 1 file changed, 94 insertions(+), 159 deletions(-)

diff --git a/lib/xattr.c b/lib/xattr.c
index 54a6ae2..cac8db8 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -75,9 +75,9 @@
 struct xattr_item {
 	struct xattr_item *next_shared_xattr;
 	const char *kvbuf;
-	unsigned int hash[2], len[2], count;
+	unsigned int hash[2], len[2], count, infix_len;
 	int shared_xattr_id;
-	u8 prefix;
+	u8 prefix, index;
 	struct hlist_node node;
 };
 
@@ -115,9 +115,11 @@ static struct xattr_prefix {
 
 struct ea_type_node {
 	struct list_head list;
-	struct xattr_prefix type;
-	u8 index;
+	u8 index, base_index;
+	const char *infix;
+	u8 infix_len;
 };
+
 static LIST_HEAD(ea_name_prefixes);
 static unsigned int ea_prefix_count;
 
@@ -154,7 +156,8 @@ static struct xattr_item *get_xattritem(u8 prefix, char *kvbuf,
 					unsigned int len[2])
 {
 	struct xattr_item *item;
-	unsigned int hash[2], hkey;
+	unsigned int hash[2], hkey, infix_len = 0;
+	u8 index = prefix;
 
 	hkey = xattr_item_hash(prefix, kvbuf, len, hash);
 
@@ -169,6 +172,19 @@ static struct xattr_item *get_xattritem(u8 prefix, char *kvbuf,
 		}
 	}
 
+	if (cfg.c_extra_ea_name_prefixes) {
+		struct ea_type_node *tnode;
+
+		list_for_each_entry(tnode, &ea_name_prefixes, list) {
+			if (prefix == tnode->base_index &&
+			    !strncmp(tnode->infix, kvbuf, tnode->infix_len)) {
+				index = tnode->index;
+				infix_len = tnode->infix_len;
+				break;
+			}
+		}
+	}
+
 	item = malloc(sizeof(*item));
 	if (!item) {
 		free(kvbuf);
@@ -183,11 +199,13 @@ static struct xattr_item *get_xattritem(u8 prefix, char *kvbuf,
 	item->hash[1] = hash[1];
 	item->shared_xattr_id = -1;
 	item->prefix = prefix;
+	item->index = index;
+	item->infix_len = infix_len;
 	hash_add(ea_hashtable, &item->node, hkey);
 	return item;
 }
 
-static bool match_base_prefix(const char *key, u8 *index, u16 *len)
+static bool match_prefix(const char *key, u8 *index, u16 *len)
 {
 	struct xattr_prefix *p;
 
@@ -201,22 +219,6 @@ static bool match_base_prefix(const char *key, u8 *index, u16 *len)
 	return false;
 }
 
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
-}
-
 static struct xattr_item *parse_one_xattr(const char *path, const char *key,
 					  unsigned int keylen)
 {
@@ -558,6 +560,13 @@ int erofs_scan_file_xattrs(struct erofs_inode *inode)
 	return erofs_droid_xattr_set_caps(inode);
 }
 
+static inline unsigned int erofs_next_xattr_align(unsigned int pos,
+						  struct xattr_item *item)
+{
+	return EROFS_XATTR_ALIGN(pos + sizeof(struct erofs_xattr_entry) +
+			item->len[0] + item->len[1] - item->infix_len);
+}
+
 int erofs_prepare_xattr_ibody(struct erofs_inode *inode)
 {
 	int ret;
@@ -572,14 +581,13 @@ int erofs_prepare_xattr_ibody(struct erofs_inode *inode)
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
@@ -688,25 +696,9 @@ static int comp_shared_xattr_item(const void *a, const void *b)
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
@@ -732,16 +724,11 @@ int erofs_xattr_write_name_prefixes(struct erofs_sb_info *sbi, FILE *f)
 			u8 data[EROFS_NAME_LEN + 2 +
 				sizeof(struct erofs_xattr_long_prefix)];
 		} u;
-		int ret, len;
+		int len;
 
-		p = &tnode->type;
-		ret = erofs_xattr_index_by_prefix(p->prefix, &len);
-		if (ret < 0)
-			return ret;
-		u.s.prefix.base_index = ret;
-		memcpy(u.s.prefix.infix, p->prefix + len, p->prefix_len - len);
-		len = sizeof(struct erofs_xattr_long_prefix) +
-			p->prefix_len - len;
+		u.s.prefix.base_index = tnode->base_index;
+		memcpy(u.s.prefix.infix, tnode->infix, tnode->infix_len);
+		len = sizeof(struct erofs_xattr_long_prefix) + tnode->infix_len;
 		u.s.size = cpu_to_le16(len);
 		if (fwrite(&u.s, sizeof(__le16) + len, 1, f) != 1)
 			return -EIO;
@@ -754,6 +741,26 @@ int erofs_xattr_write_name_prefixes(struct erofs_sb_info *sbi, FILE *f)
 	return 0;
 }
 
+static void erofs_write_xattr_entry(char *buf, struct xattr_item *item)
+{
+	struct erofs_xattr_entry entry = {
+		.e_name_index = item->index,
+		.e_name_len = item->len[0] - item->infix_len,
+		.e_value_size = cpu_to_le16(item->len[1]),
+	};
+
+	memcpy(buf, &entry, sizeof(entry));
+	buf += sizeof(struct erofs_xattr_entry);
+	memcpy(buf, item->kvbuf + item->infix_len,
+	       item->len[0] + item->len[1] - item->infix_len);
+
+	erofs_dbg("writing xattr %d %.*s (%d %.*s) = %.*s",
+			item->prefix, item->len[0], item->kvbuf,
+			item->index, item->len[0] - item->infix_len,
+			item->kvbuf + item->infix_len,
+			item->len[1], item->kvbuf + item->len[0]);
+}
+
 int erofs_build_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *path)
 {
 	int ret;
@@ -791,9 +798,8 @@ int erofs_build_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *p
 
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
@@ -821,19 +827,11 @@ int erofs_build_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *p
 	p = 0;
 	for (i = 0; i < shared_xattrs_count; i++) {
 		struct xattr_item *item = sorted_n[i];
-		const struct erofs_xattr_entry entry = {
-			.e_name_index = item->prefix,
-			.e_name_len = item->len[0],
-			.e_value_size = cpu_to_le16(item->len[1])
-		};
 
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
@@ -846,70 +844,12 @@ out:
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
@@ -922,16 +862,26 @@ char *erofs_export_xattr_ibody(struct erofs_inode *inode)
 	header->h_shared_count = 0;
 
 	if (cfg.c_xattr_name_filter) {
-		header->h_name_filter =
-			cpu_to_le32(erofs_xattr_filter_map(ixattrs));
+		u32 name_filter = 0;
+		int hashbit;
+
+		list_for_each_entry(node, ixattrs, list) {
+			item = node->item;
+			hashbit = xxh32(item->kvbuf, item->len[0],
+					EROFS_XATTR_FILTER_SEED + item->prefix) &
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
@@ -948,18 +898,9 @@ char *erofs_export_xattr_ibody(struct erofs_inode *inode)
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
@@ -1365,7 +1306,7 @@ int erofs_getxattr(struct erofs_inode *vi, const char *name, char *buffer,
 	if (ret)
 		return ret;
 
-	if (!match_base_prefix(name, &prefix, &prefixlen))
+	if (!match_prefix(name, &prefix, &prefixlen))
 		return -ENODATA;
 
 	it.it.sbi = vi->sbi;
@@ -1532,35 +1473,29 @@ int erofs_listxattr(struct erofs_inode *vi, char *buffer, size_t buffer_size)
 int erofs_xattr_insert_name_prefix(const char *prefix)
 {
 	struct ea_type_node *tnode;
-	struct xattr_prefix *p;
-	bool matched = false;
-	char *s;
+	u8 base_index;
+	u16 base_len;
 
 	if (ea_prefix_count >= 0x80 || strlen(prefix) > UINT8_MAX)
 		return -EOVERFLOW;
 
-	for (p = xattr_types; p < xattr_types + ARRAY_SIZE(xattr_types); ++p) {
-		if (!strncmp(p->prefix, prefix, p->prefix_len)) {
-			matched = true;
-			break;
-		}
-	}
-	if (!matched)
+	if (!match_prefix(prefix, &base_index, &base_len))
 		return -ENODATA;
 
-	s = strdup(prefix);
-	if (!s)
+	tnode = calloc(1, sizeof(*tnode));
+	if (!tnode)
 		return -ENOMEM;
 
-	tnode = malloc(sizeof(*tnode));
-	if (!tnode) {
-		free(s);
-		return -ENOMEM;
+	tnode->base_index = base_index;
+	tnode->infix_len = strlen(prefix) - base_len;
+	if (tnode->infix_len) {
+		tnode->infix = strdup(prefix + base_len);
+		if (!tnode->infix) {
+			free(tnode);
+			return -ENOMEM;
+		}
 	}
 
-	tnode->type.prefix = s;
-	tnode->type.prefix_len = strlen(prefix);
-
 	tnode->index = EROFS_XATTR_LONG_PREFIX | ea_prefix_count;
 	ea_prefix_count++;
 	init_list_head(&tnode->list);
@@ -1574,7 +1509,7 @@ void erofs_xattr_cleanup_name_prefixes(void)
 
 	list_for_each_entry_safe(tnode, n, &ea_name_prefixes, list) {
 		list_del(&tnode->list);
-		free((void *)tnode->type.prefix);
+		free((void *)tnode->infix);
 		free(tnode);
 	}
 }
-- 
2.19.1.6.gb485710b

