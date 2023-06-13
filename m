Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C12AD72DB3D
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Jun 2023 09:41:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QgL9656hsz30PZ
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Jun 2023 17:41:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QgL8h58m7z2yyc
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Jun 2023 17:41:24 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vl1EOLv_1686642079;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vl1EOLv_1686642079)
          by smtp.aliyun-inc.com;
          Tue, 13 Jun 2023 15:41:20 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v8 5/5] erofs: use separate xattr parsers for listxattr/getxattr
Date: Tue, 13 Jun 2023 15:41:14 +0800
Message-Id: <20230613074114.120115-6-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230613074114.120115-1-jefflexu@linux.alibaba.com>
References: <20230613074114.120115-1-jefflexu@linux.alibaba.com>
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
shared among listxattr and getxattr.

Convert it to two separate xattr parsers to serve listxattr and getxattr
for better readability.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/xattr.c | 371 +++++++++++++++++------------------------------
 1 file changed, 137 insertions(+), 234 deletions(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index c3cb01a8b446..4376f654474d 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -123,195 +123,6 @@ static int erofs_init_inode_xattrs(struct inode *inode)
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
- * `pos' pointing to the next xattr item rather than an arbitrary position.
- */
-static int xattr_foreach(struct erofs_xattr_iter *it,
-			 const struct xattr_iter_handlers *op,
-			 unsigned int *tlimit)
-{
-	struct erofs_xattr_entry entry;
-	struct super_block *sb = it->sb;
-	unsigned int value_sz, processed, slice;
-	int err;
-
-	/* 0. fixup blkaddr, pos */
-	it->kaddr = erofs_bread(&it->buf, erofs_blknr(sb, it->pos), EROFS_KMAP);
-	if (IS_ERR(it->kaddr))
-		return PTR_ERR(it->kaddr);
-
-	/*
-	 * 1. read xattr entry to the memory,
-	 *    since we do EROFS_XATTR_ALIGN
-	 *    therefore entry should be in the page
-	 */
-	entry = *(struct erofs_xattr_entry *)
-		(it->kaddr + erofs_blkoff(sb, it->pos));
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
-	it->pos += sizeof(struct erofs_xattr_entry);
-	value_sz = le16_to_cpu(entry.e_value_size);
-
-	/* handle entry */
-	err = op->entry(it, &entry);
-	if (err) {
-		it->pos += entry.e_name_len + value_sz;
-		goto out;
-	}
-
-	/* 2. handle xattr name (pos will finally be at the end of name) */
-	processed = 0;
-
-	while (processed < entry.e_name_len) {
-		it->kaddr = erofs_bread(&it->buf, erofs_blknr(sb, it->pos),
-					EROFS_KMAP);
-		if (IS_ERR(it->kaddr)) {
-			err = PTR_ERR(it->kaddr);
-			goto out;
-		}
-
-		slice = min_t(unsigned int,
-			      sb->s_blocksize - erofs_blkoff(sb, it->pos),
-			      entry.e_name_len - processed);
-
-		/* handle name */
-		err = op->name(it, processed,
-			       it->kaddr + erofs_blkoff(sb, it->pos), slice);
-		if (err) {
-			it->pos += entry.e_name_len - processed + value_sz;
-			goto out;
-		}
-
-		it->pos += slice;
-		processed += slice;
-	}
-
-	/* 3. handle xattr value */
-	processed = 0;
-
-	if (op->alloc_buffer) {
-		err = op->alloc_buffer(it, value_sz);
-		if (err) {
-			it->pos += value_sz;
-			goto out;
-		}
-	}
-
-	while (processed < value_sz) {
-		it->kaddr = erofs_bread(&it->buf, erofs_blknr(sb, it->pos),
-					EROFS_KMAP);
-		if (IS_ERR(it->kaddr)) {
-			err = PTR_ERR(it->kaddr);
-			goto out;
-		}
-
-		slice = min_t(unsigned int,
-			      sb->s_blocksize - erofs_blkoff(sb, it->pos),
-			      value_sz - processed);
-		op->value(it, processed, it->kaddr + erofs_blkoff(sb, it->pos),
-			  slice);
-		it->pos += slice;
-		processed += slice;
-	}
-
-out:
-	/* xattrs should be 4-byte aligned (on-disk constraint) */
-	it->pos = EROFS_XATTR_ALIGN(it->pos);
-	return err < 0 ? err : 0;
-}
-
-static int erofs_xattr_long_entrymatch(struct erofs_xattr_iter *it,
-				       struct erofs_xattr_entry *entry)
-{
-	struct erofs_sb_info *sbi = EROFS_SB(it->sb);
-	struct erofs_xattr_prefix_item *pf = sbi->xattr_prefixes +
-		(entry->e_name_index & EROFS_XATTR_LONG_PREFIX_MASK);
-
-	if (pf >= sbi->xattr_prefixes + sbi->xattr_prefix_count)
-		return -ENOATTR;
-
-	if (it->index != pf->prefix->base_index ||
-	    it->name.len != entry->e_name_len + pf->infix_len)
-		return -ENOATTR;
-
-	if (memcmp(it->name.name, pf->prefix->infix, pf->infix_len))
-		return -ENOATTR;
-
-	it->infix_len = pf->infix_len;
-	return 0;
-}
-
-static int xattr_entrymatch(struct erofs_xattr_iter *it,
-			    struct erofs_xattr_entry *entry)
-{
-	/* should also match the infix for long name prefixes */
-	if (entry->e_name_index & EROFS_XATTR_LONG_PREFIX)
-		return erofs_xattr_long_entrymatch(it, entry);
-
-	if (it->index != entry->e_name_index ||
-	    it->name.len != entry->e_name_len)
-		return -ENOATTR;
-	it->infix_len = 0;
-	return 0;
-}
-
-static int xattr_namematch(struct erofs_xattr_iter *it,
-			   unsigned int processed, char *buf, unsigned int len)
-{
-	if (memcmp(buf, it->name.name + it->infix_len + processed, len))
-		return -ENOATTR;
-	return 0;
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
@@ -364,20 +175,49 @@ const struct xattr_handler *erofs_xattr_handlers[] = {
 	NULL,
 };
 
-static int xattr_entrylist(struct erofs_xattr_iter *it,
-			   struct erofs_xattr_entry *entry)
+static int erofs_xattr_copy_to_buffer(struct erofs_xattr_iter *it,
+				      unsigned int len)
+{
+	unsigned int slice, processed;
+	struct super_block *sb = it->sb;
+	void *src;
+
+	for (processed = 0; processed < len; processed += slice) {
+		it->kaddr = erofs_bread(&it->buf, erofs_blknr(sb, it->pos),
+					EROFS_KMAP);
+		if (IS_ERR(it->kaddr))
+			return PTR_ERR(it->kaddr);
+
+		src = it->kaddr + erofs_blkoff(sb, it->pos);
+		slice = min_t(unsigned int, sb->s_blocksize -
+				erofs_blkoff(sb, it->pos), len - processed);
+		memcpy(it->buffer + it->buffer_ofs, src, slice);
+		it->buffer_ofs += slice;
+		it->pos += slice;
+	}
+	return 0;
+}
+
+static int erofs_listxattr_foreach(struct erofs_xattr_iter *it)
 {
-	unsigned int base_index = entry->e_name_index;
-	unsigned int prefix_len, infix_len = 0;
+	struct erofs_xattr_entry entry;
+	unsigned int base_index, name_total, prefix_len, infix_len = 0;
 	const char *prefix, *infix = NULL;
+	int err;
 
-	if (entry->e_name_index & EROFS_XATTR_LONG_PREFIX) {
+	/* 1. handle xattr entry */
+	entry = *(struct erofs_xattr_entry *)
+			(it->kaddr + erofs_blkoff(it->sb, it->pos));
+	it->pos += sizeof(struct erofs_xattr_entry);
+
+	base_index = entry.e_name_index;
+	if (entry.e_name_index & EROFS_XATTR_LONG_PREFIX) {
 		struct erofs_sb_info *sbi = EROFS_SB(it->sb);
 		struct erofs_xattr_prefix_item *pf = sbi->xattr_prefixes +
-			(entry->e_name_index & EROFS_XATTR_LONG_PREFIX_MASK);
+			(entry.e_name_index & EROFS_XATTR_LONG_PREFIX_MASK);
 
 		if (pf >= sbi->xattr_prefixes + sbi->xattr_prefix_count)
-			return 1;
+			return 0;
 		infix = pf->prefix->infix;
 		infix_len = pf->infix_len;
 		base_index = pf->prefix->base_index;
@@ -385,53 +225,102 @@ static int xattr_entrylist(struct erofs_xattr_iter *it,
 
 	prefix = erofs_xattr_prefix(base_index, it->dentry);
 	if (!prefix)
-		return 1;
+		return 0;
 	prefix_len = strlen(prefix);
+	name_total = prefix_len + infix_len + entry.e_name_len + 1;
 
 	if (!it->buffer) {
-		it->buffer_ofs += prefix_len + infix_len +
-					entry->e_name_len + 1;
-		return 1;
+		it->buffer_ofs += name_total;
+		return 0;
 	}
 
-	if (it->buffer_ofs + prefix_len + infix_len +
-		+ entry->e_name_len + 1 > it->buffer_size)
+	if (it->buffer_ofs + name_total > it->buffer_size)
 		return -ERANGE;
 
 	memcpy(it->buffer + it->buffer_ofs, prefix, prefix_len);
 	memcpy(it->buffer + it->buffer_ofs + prefix_len, infix, infix_len);
 	it->buffer_ofs += prefix_len + infix_len;
-	return 0;
-}
 
-static int xattr_namelist(struct erofs_xattr_iter *it,
-			  unsigned int processed, char *buf, unsigned int len)
-{
-	memcpy(it->buffer + it->buffer_ofs, buf, len);
-	it->buffer_ofs += len;
+	/* 2. handle xattr name */
+	err = erofs_xattr_copy_to_buffer(it, entry.e_name_len);
+	if (err)
+		return err;
+
+	it->buffer[it->buffer_ofs++] = '\0';
 	return 0;
 }
 
-static int xattr_skipvalue(struct erofs_xattr_iter *it,
-			   unsigned int value_sz)
+static int erofs_getxattr_foreach(struct erofs_xattr_iter *it)
 {
-	it->buffer[it->buffer_ofs++] = '\0';
-	return 1;
-}
+	struct super_block *sb = it->sb;
+	struct erofs_xattr_entry entry;
+	unsigned int slice, processed, value_sz;
 
-static const struct xattr_iter_handlers list_xattr_handlers = {
-	.entry = xattr_entrylist,
-	.name = xattr_namelist,
-	.alloc_buffer = xattr_skipvalue,
-	.value = NULL
-};
+	/* 1. handle xattr entry */
+	entry = *(struct erofs_xattr_entry *)
+			(it->kaddr + erofs_blkoff(sb, it->pos));
+	it->pos += sizeof(struct erofs_xattr_entry);
+	value_sz = le16_to_cpu(entry.e_value_size);
+
+	/* should also match the infix for long name prefixes */
+	if (entry.e_name_index & EROFS_XATTR_LONG_PREFIX) {
+		struct erofs_sb_info *sbi = EROFS_SB(sb);
+		struct erofs_xattr_prefix_item *pf = sbi->xattr_prefixes +
+			(entry.e_name_index & EROFS_XATTR_LONG_PREFIX_MASK);
+
+		if (pf >= sbi->xattr_prefixes + sbi->xattr_prefix_count)
+			return -ENOATTR;
+
+		if (it->index != pf->prefix->base_index ||
+		    it->name.len != entry.e_name_len + pf->infix_len)
+			return -ENOATTR;
+
+		if (memcmp(it->name.name, pf->prefix->infix, pf->infix_len))
+			return -ENOATTR;
+
+		it->infix_len = pf->infix_len;
+	} else {
+		if (it->index != entry.e_name_index ||
+		    it->name.len != entry.e_name_len)
+			return -ENOATTR;
+
+		it->infix_len = 0;
+	}
+
+	/* 2. handle xattr name */
+	for (processed = 0; processed < entry.e_name_len; processed += slice) {
+		it->kaddr = erofs_bread(&it->buf, erofs_blknr(sb, it->pos),
+					EROFS_KMAP);
+		if (IS_ERR(it->kaddr))
+			return PTR_ERR(it->kaddr);
+
+		slice = min_t(unsigned int,
+				sb->s_blocksize - erofs_blkoff(sb, it->pos),
+				entry.e_name_len - processed);
+		if (memcmp(it->name.name + it->infix_len + processed,
+			   it->kaddr + erofs_blkoff(sb, it->pos), slice))
+			return -ENOATTR;
+		it->pos += slice;
+	}
+
+	/* 3. handle xattr value */
+	if (!it->buffer) {
+		it->buffer_ofs = value_sz;
+		return 0;
+	}
+
+	if (it->buffer_size < value_sz)
+		return -ERANGE;
+
+	return erofs_xattr_copy_to_buffer(it, value_sz);
+}
 
 static int erofs_xattr_iter_inline(struct erofs_xattr_iter *it,
 				   struct inode *inode, bool getxattr)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
-	const struct xattr_iter_handlers *op;
-	unsigned int xattr_header_sz, remaining;
+	unsigned int xattr_header_sz, remaining, entry_sz;
+	erofs_off_t next_pos;
 	int ret;
 
 	xattr_header_sz = sizeof(struct erofs_xattr_ibody_header) +
@@ -441,19 +330,33 @@ static int erofs_xattr_iter_inline(struct erofs_xattr_iter *it,
 		return -ENOATTR;
 	}
 
-	it->pos = erofs_iloc(inode) + vi->inode_isize + xattr_header_sz;
-	it->kaddr = erofs_bread(&it->buf, erofs_blknr(it->sb, it->pos),
-				EROFS_KMAP);
-	if (IS_ERR(it->kaddr))
-		return PTR_ERR(it->kaddr);
-
 	remaining = vi->xattr_isize - xattr_header_sz;
-	op = getxattr ? &find_xattr_handlers : &list_xattr_handlers;
+	it->pos = erofs_iloc(inode) + vi->inode_isize + xattr_header_sz;
 
 	while (remaining) {
-		ret = xattr_foreach(it, op, &remaining);
+		it->kaddr = erofs_bread(&it->buf, erofs_blknr(it->sb, it->pos),
+					EROFS_KMAP);
+		if (IS_ERR(it->kaddr))
+			return PTR_ERR(it->kaddr);
+
+		entry_sz = erofs_xattr_entry_size(it->kaddr +
+				erofs_blkoff(it->sb, it->pos));
+		/* xattr on-disk corruption: xattr entry beyond xattr_isize */
+		if (remaining < entry_sz) {
+			DBG_BUGON(1);
+			return -EFSCORRUPTED;
+		}
+		remaining -= entry_sz;
+		next_pos = it->pos + entry_sz;
+
+		if (getxattr)
+			ret = erofs_getxattr_foreach(it);
+		else
+			ret = erofs_listxattr_foreach(it);
 		if ((getxattr && ret != -ENOATTR) || (!getxattr && ret))
 			break;
+
+		it->pos = next_pos;
 	}
 	return ret;
 }
@@ -465,11 +368,8 @@ static int erofs_xattr_iter_shared(struct erofs_xattr_iter *it,
 	struct super_block *const sb = it->sb;
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	unsigned int i;
-	const struct xattr_iter_handlers *op;
 	int ret = -ENOATTR;
 
-	op = getxattr ? &find_xattr_handlers : &list_xattr_handlers;
-
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
 		it->pos = erofs_pos(sb, sbi->xattr_blkaddr) +
 				vi->xattr_shared_xattrs[i] * sizeof(__le32);
@@ -478,7 +378,10 @@ static int erofs_xattr_iter_shared(struct erofs_xattr_iter *it,
 		if (IS_ERR(it->kaddr))
 			return PTR_ERR(it->kaddr);
 
-		ret = xattr_foreach(it, op, NULL);
+		if (getxattr)
+			ret = erofs_getxattr_foreach(it);
+		else
+			ret = erofs_listxattr_foreach(it);
 		if ((getxattr && ret != -ENOATTR) || (!getxattr && ret))
 			break;
 	}
-- 
2.19.1.6.gb485710b

