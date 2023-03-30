Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5406CFE44
	for <lists+linux-erofs@lfdr.de>; Thu, 30 Mar 2023 10:29:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PnGn71nSNz2xjw
	for <lists+linux-erofs@lfdr.de>; Thu, 30 Mar 2023 19:29:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PnGmg3XLwz3c9L
	for <linux-erofs@lists.ozlabs.org>; Thu, 30 Mar 2023 19:29:23 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vezms5K_1680164958;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vezms5K_1680164958)
          by smtp.aliyun-inc.com;
          Thu, 30 Mar 2023 16:29:18 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 8/8] erofs: use separate xattr parsers for listxattr/getxattr
Date: Thu, 30 Mar 2023 16:29:10 +0800
Message-Id: <20230330082910.125374-9-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230330082910.125374-1-jefflexu@linux.alibaba.com>
References: <20230330082910.125374-1-jefflexu@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

There's a callback styled xattr parser, i.e. xattr_foreach(), which is
shared among listxattr and getxattr.  Convert it to two separate xattr
parsers for listxattr and getxattr.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/xattr.c | 347 ++++++++++++++++++++++-------------------------
 1 file changed, 159 insertions(+), 188 deletions(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 541d508e7758..8851c38e8ca7 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -21,6 +21,7 @@ struct erofs_xattr_iter {
 	struct qstr name;
 	struct dentry *dentry;
 	struct inode *inode;
+	unsigned int remaining; /* size of inline xattrs to be iterated */
 	bool getxattr;
 };
 
@@ -141,153 +142,6 @@ static int erofs_init_inode_xattrs(struct inode *inode)
 	return ret;
 }
 
-/*
- * the general idea for these return values is
- * if    0 is returned, go on processing the current xattr;
- *       1 (> 0) is returned, skip this round to process the next xattr;
- *    -err (< 0) is returned, an error (maybe ENOXATTR) occurred
- *                            and need to be handled
- */
-struct xattr_iter_handlers {
-	int (*entry)(struct erofs_xattr_iter *it, struct erofs_xattr_entry *entry);
-	int (*name)(struct erofs_xattr_iter *it, unsigned int processed, char *buf,
-		    unsigned int len);
-	int (*alloc_buffer)(struct erofs_xattr_iter *it, unsigned int value_sz);
-	void (*value)(struct erofs_xattr_iter *it, unsigned int processed, char *buf,
-		      unsigned int len);
-};
-
-/*
- * Regardless of success or failure, `xattr_foreach' will end up with
- * `ofs' pointing to the next xattr item rather than an arbitrary position.
- */
-static int xattr_foreach(struct erofs_xattr_iter *it,
-			 const struct xattr_iter_handlers *op,
-			 unsigned int *tlimit)
-{
-	struct erofs_xattr_entry entry;
-	unsigned int value_sz, processed, slice;
-	int err;
-
-	/* 0. fixup blkaddr, ofs, ipage */
-	err = erofs_xattr_iter_fixup(it);
-	if (err)
-		return err;
-
-	/*
-	 * 1. read xattr entry to the memory,
-	 *    since we do EROFS_XATTR_ALIGN
-	 *    therefore entry should be in the page
-	 */
-	entry = *(struct erofs_xattr_entry *)(it->kaddr + it->ofs);
-	if (tlimit) {
-		unsigned int entry_sz = erofs_xattr_entry_size(&entry);
-
-		/* xattr on-disk corruption: xattr entry beyond xattr_isize */
-		if (*tlimit < entry_sz) {
-			DBG_BUGON(1);
-			return -EFSCORRUPTED;
-		}
-		*tlimit -= entry_sz;
-	}
-
-	it->ofs += sizeof(struct erofs_xattr_entry);
-	value_sz = le16_to_cpu(entry.e_value_size);
-
-	/* handle entry */
-	err = op->entry(it, &entry);
-	if (err) {
-		it->ofs += entry.e_name_len + value_sz;
-		goto out;
-	}
-
-	/* 2. handle xattr name (ofs will finally be at the end of name) */
-	processed = 0;
-
-	while (processed < entry.e_name_len) {
-		err = erofs_xattr_iter_fixup_aligned(it);
-		if (err)
-			goto out;
-
-		slice = min_t(unsigned int, it->sb->s_blocksize - it->ofs,
-			      entry.e_name_len - processed);
-
-		/* handle name */
-		err = op->name(it, processed, it->kaddr + it->ofs, slice);
-		if (err) {
-			it->ofs += entry.e_name_len - processed + value_sz;
-			goto out;
-		}
-
-		it->ofs += slice;
-		processed += slice;
-	}
-
-	/* 3. handle xattr value */
-	processed = 0;
-
-	if (op->alloc_buffer) {
-		err = op->alloc_buffer(it, value_sz);
-		if (err) {
-			it->ofs += value_sz;
-			goto out;
-		}
-	}
-
-	while (processed < value_sz) {
-		err = erofs_xattr_iter_fixup_aligned(it);
-		if (err)
-			goto out;
-
-		slice = min_t(unsigned int, it->sb->s_blocksize - it->ofs,
-			      value_sz - processed);
-		op->value(it, processed, it->kaddr + it->ofs, slice);
-		it->ofs += slice;
-		processed += slice;
-	}
-
-out:
-	/* xattrs should be 4-byte aligned (on-disk constraint) */
-	it->ofs = EROFS_XATTR_ALIGN(it->ofs);
-	return err < 0 ? err : 0;
-}
-
-static int xattr_entrymatch(struct erofs_xattr_iter *it,
-			    struct erofs_xattr_entry *entry)
-{
-	return (it->index != entry->e_name_index ||
-		it->name.len != entry->e_name_len) ? -ENOATTR : 0;
-}
-
-static int xattr_namematch(struct erofs_xattr_iter *it,
-			   unsigned int processed, char *buf, unsigned int len)
-{
-	return memcmp(buf, it->name.name + processed, len) ? -ENOATTR : 0;
-}
-
-static int xattr_checkbuffer(struct erofs_xattr_iter *it,
-			     unsigned int value_sz)
-{
-	int err = it->buffer_size < value_sz ? -ERANGE : 0;
-
-	it->buffer_ofs = value_sz;
-	return !it->buffer ? 1 : err;
-}
-
-static void xattr_copyvalue(struct erofs_xattr_iter *it,
-			    unsigned int processed,
-			    char *buf, unsigned int len)
-{
-	memcpy(it->buffer + processed, buf, len);
-}
-
-static const struct xattr_iter_handlers find_xattr_handlers = {
-	.entry = xattr_entrymatch,
-	.name = xattr_namematch,
-	.alloc_buffer = xattr_checkbuffer,
-	.value = xattr_copyvalue
-};
-
 static bool erofs_xattr_user_list(struct dentry *dentry)
 {
 	return test_opt(&EROFS_SB(dentry->d_sb)->opt, XATTR_USER);
@@ -344,62 +198,178 @@ const struct xattr_handler *erofs_xattr_handlers[] = {
 	NULL,
 };
 
-static int xattr_entrylist(struct erofs_xattr_iter *it,
-			   struct erofs_xattr_entry *entry)
+/*
+ * the general idea for these return values is
+ * if    0 is returned, go on processing the current xattr;
+ *       1 (> 0) is returned, skip this round to process the next xattr;
+ *    -err (< 0) is returned, an error (maybe ENOXATTR) occurred
+ *                            and need to be handled
+ */
+typedef int (*erofs_xattr_body_handler)(struct erofs_xattr_iter *it,
+					unsigned int processed,
+					char *buf, unsigned int len);
+
+static int erofs_xattr_namematch(struct erofs_xattr_iter *it,
+		unsigned int processed, char *buf, unsigned int len)
+{
+	return memcmp(buf, it->name.name + processed, len) ? -ENOATTR : 0;
+}
+
+static int erofs_xattr_copy(struct erofs_xattr_iter *it,
+		unsigned int unused, char *buf, unsigned int len)
+{
+	memcpy(it->buffer + it->buffer_ofs, buf, len);
+	it->buffer_ofs += len;
+	return 0;
+}
+
+static int erofs_xattr_body(struct erofs_xattr_iter *it, unsigned int len,
+			    erofs_xattr_body_handler handler)
+{
+	unsigned int slice, processed = 0;
+
+	while (processed < len) {
+		int err = erofs_xattr_iter_fixup_aligned(it);
+		if (err)
+			return err;
+
+		slice = min_t(unsigned int, it->sb->s_blocksize - it->ofs,
+			      len - processed);
+		err = handler(it, processed, it->kaddr + it->ofs, slice);
+		if (err) {
+			it->ofs += len - processed;
+			return err;
+		}
+
+		it->ofs += slice;
+		processed += slice;
+	}
+	return 0;
+}
+
+static int erofs_xattr_check_entry(struct erofs_xattr_iter *it)
 {
-	unsigned int prefix_len;
+	int err;
+
+	err = erofs_xattr_iter_fixup(it);
+	if (err)
+		return err;
+
+	if (it->remaining) {
+		struct erofs_xattr_entry *entry = it->kaddr + it->ofs;
+		unsigned int entry_sz = erofs_xattr_entry_size(entry);
+		/* xattr on-disk corruption: xattr entry beyond xattr_isize */
+		if (it->remaining < entry_sz) {
+			DBG_BUGON(1);
+			return -EFSCORRUPTED;
+		}
+		it->remaining -= entry_sz;
+	}
+	return 0;
+}
+
+/*
+ * Wen returning 0 or ENOATTR, erofs_[get|list]xattr_foreach() will end up
+ * with `ofs' pointing to the next xattr item rather than an arbitrary position.
+ */
+static int erofs_listxattr_foreach(struct erofs_xattr_iter *it)
+{
+	struct erofs_xattr_entry entry;
+	const struct xattr_handler *h;
 	const char *prefix;
+	unsigned int value_sz, prefix_len, name_sz;
+	int err;
 
-	const struct xattr_handler *h =
-		erofs_xattr_handler(entry->e_name_index);
+	err = erofs_xattr_check_entry(it);
+	if (err)
+		return err;
 
-	if (!h || (h->list && !h->list(it->dentry)))
-		return 1;
+	/* 1. handle xattr entry */
+	entry = *(struct erofs_xattr_entry *)(it->kaddr + it->ofs);
+	it->ofs += sizeof(struct erofs_xattr_entry);
+	value_sz = le16_to_cpu(entry.e_value_size);
+
+	h = erofs_xattr_handler(entry.e_name_index);
+	if (!h || (h->list && !h->list(it->dentry))) {
+		it->ofs += entry.e_name_len + value_sz;
+		goto out;
+	}
 
 	prefix = xattr_prefix(h);
 	prefix_len = strlen(prefix);
+	name_sz = prefix_len + entry.e_name_len + 1;
 
 	if (!it->buffer) {
-		it->buffer_ofs += prefix_len + entry->e_name_len + 1;
-		return 1;
+		it->buffer_ofs += name_sz;
+		it->ofs += entry.e_name_len + value_sz;
+		goto out;
 	}
-
-	if (it->buffer_ofs + prefix_len
-		+ entry->e_name_len + 1 > it->buffer_size)
+	if (it->buffer_ofs + name_sz > it->buffer_size)
 		return -ERANGE;
 
 	memcpy(it->buffer + it->buffer_ofs, prefix, prefix_len);
 	it->buffer_ofs += prefix_len;
-	return 0;
-}
 
-static int xattr_namelist(struct erofs_xattr_iter *it,
-			  unsigned int processed, char *buf, unsigned int len)
-{
-	memcpy(it->buffer + it->buffer_ofs, buf, len);
-	it->buffer_ofs += len;
+	/* 2. handle xattr name (err can't be ENOATTR) */
+	err = erofs_xattr_body(it, entry.e_name_len, erofs_xattr_copy);
+	if (err)
+		return err;
+
+	it->buffer[it->buffer_ofs++] = '\0';
+	it->ofs += value_sz;
+out:
+	it->ofs = EROFS_XATTR_ALIGN(it->ofs);
 	return 0;
 }
 
-static int xattr_skipvalue(struct erofs_xattr_iter *it,
-			   unsigned int value_sz)
+static int erofs_getxattr_foreach(struct erofs_xattr_iter *it)
 {
-	it->buffer[it->buffer_ofs++] = '\0';
-	return 1;
-}
+	struct erofs_xattr_entry entry;
+	unsigned int value_sz;
+	int err;
 
-static const struct xattr_iter_handlers list_xattr_handlers = {
-	.entry = xattr_entrylist,
-	.name = xattr_namelist,
-	.alloc_buffer = xattr_skipvalue,
-	.value = NULL
-};
+	err = erofs_xattr_check_entry(it);
+	if (err)
+		return err;
+
+	/* 1. handle xattr entry */
+	entry = *(struct erofs_xattr_entry *)(it->kaddr + it->ofs);
+	it->ofs += sizeof(struct erofs_xattr_entry);
+	value_sz = le16_to_cpu(entry.e_value_size);
+
+	if (it->index != entry.e_name_index || it->name.len != entry.e_name_len) {
+		it->ofs += entry.e_name_len + value_sz;
+		err = -ENOATTR;
+		goto out;
+	}
+
+	/* 2. handle xattr name */
+	err = erofs_xattr_body(it, entry.e_name_len, erofs_xattr_namematch);
+	if (err) {
+		it->ofs += value_sz;
+		goto out;
+	}
+
+	/* 3. handle xattr value */
+	if (!it->buffer) {
+		it->buffer_ofs = value_sz;
+		it->ofs += value_sz;
+		goto out; /* err == 0 */
+	}
+	if (it->buffer_size < value_sz)
+		return -ERANGE;
+
+	/* no need updating ofs on error (err can't be ENOATTR) */
+	err = erofs_xattr_body(it, value_sz, erofs_xattr_copy);
+out:
+	it->ofs = EROFS_XATTR_ALIGN(it->ofs);
+	return err;
+}
 
 static int erofs_iter_inline_xattr(struct erofs_xattr_iter *it)
 {
 	struct erofs_inode *const vi = EROFS_I(it->inode);
-	const struct xattr_iter_handlers *op;
-	unsigned int xattr_header_sz, remaining;
+	unsigned int xattr_header_sz;
 	erofs_off_t pos;
 	int ret;
 
@@ -417,11 +387,12 @@ static int erofs_iter_inline_xattr(struct erofs_xattr_iter *it)
 	if (IS_ERR(it->kaddr))
 		return PTR_ERR(it->kaddr);
 
-	remaining = vi->xattr_isize - xattr_header_sz;
-	op = it->getxattr ? &find_xattr_handlers : &list_xattr_handlers;
-
-	while (remaining) {
-		ret = xattr_foreach(it, op, &remaining);
+	it->remaining = vi->xattr_isize - xattr_header_sz;
+	while (it->remaining) {
+		if (it->getxattr)
+			ret = erofs_getxattr_foreach(it);
+		else
+			ret = erofs_listxattr_foreach(it);
 		if ((it->getxattr && ret != -ENOATTR) || (!it->getxattr && ret))
 			break;
 	}
@@ -432,12 +403,9 @@ static int erofs_iter_shared_xattr(struct erofs_xattr_iter *it)
 {
 	struct erofs_inode *const vi = EROFS_I(it->inode);
 	struct super_block *const sb = it->sb;
-	const struct xattr_iter_handlers *op;
 	unsigned int i, xsid;
 	int ret = -ENOATTR;
 
-	op = it->getxattr ? &find_xattr_handlers : &list_xattr_handlers;
-
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
 		xsid = vi->xattr_shared_xattrs[i];
 		it->blkaddr = EROFS_SB(sb)->xattr_blkaddr +
@@ -447,7 +415,10 @@ static int erofs_iter_shared_xattr(struct erofs_xattr_iter *it)
 		if (IS_ERR(it->kaddr))
 			return PTR_ERR(it->kaddr);
 
-		ret = xattr_foreach(it, op, NULL);
+		if (it->getxattr)
+			ret = erofs_getxattr_foreach(it);
+		else
+			ret = erofs_listxattr_foreach(it);
 		if ((it->getxattr && ret != -ENOATTR) || (!it->getxattr && ret))
 			break;
 	}
-- 
2.19.1.6.gb485710b

