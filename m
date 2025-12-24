Return-Path: <linux-erofs+bounces-1600-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72456CDD00E
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Dec 2025 19:32:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dc0pM1hhvz2yWy;
	Thu, 25 Dec 2025 05:31:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766601115;
	cv=none; b=mCQ8Vb1Sv3XC6UfmbH0++F5Lz6g9pZhjgvVZSVNT8y/K9nSLGQc9iKDk+MAit6jT7iDlmRdlsB2quloQRljEimG/8N+0mYfcLqp7FQLN+MQnUteiDanXEUBQDTtX22K8OQROO1zPa95jbIfw3f6g1Y6Husiet5DIqWjM4X9SL1F2fWBOBt/nwwBU44GUcaVuOIt/goRVT8SQ8EBSRW5u6jjmbW0LjeMlBkyBAEse8uFFW+bxo/9Ix+pZTWoJE/tzbSIKWqH8hsGTMBJNFzbs0b4ouH5Pc1esMIr2VBlYfW7urwaTcIssLO4FQcviFOfW0dRXo7TuuuiGN4kzgRJ7CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766601115; c=relaxed/relaxed;
	bh=XlH0bQYb/CJYqUpLTP7tWlVEi1EHuXbkuR73m6ld97E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/yY+WICPKpH7m1kvZAgREZEHZBCNpcJmoyJy60+lJcOSArOvBDX1LuN2zkBlYHSgD9w49syYHKzQrc80vJiOteA+QoF6JW5aTjyU/EmczmK48cJaWWWBZPbfJwejo5y5SoN1pKE5qFZQW7TcQBkIJP7jO0xc2azjwOswwirlBBG2PpkVXQdk9U3dHRW+90n3LU58rI4h8CHNGU+MyUX/pBUoe1Cq8vdgk6ebKpmzWP/2mj6ed1lKlPn/JkHo1C+mQDmsIWkKLj9QMeZQCFArGTIzTVK/MQOjIEW0OTfL9th/EGCr3B0aMvQIOs7cu3tLFKa6B0XoiOtjbeQFb/H6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nQ865J7a; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nQ865J7a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dc0pK6MNSz2yMv
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Dec 2025 05:31:53 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766601109; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=XlH0bQYb/CJYqUpLTP7tWlVEi1EHuXbkuR73m6ld97E=;
	b=nQ865J7adYnycMfj6JpaQ8ywSdyGAsA2DfCgEg8ezsOmV41EziqrvgXRwwXiNWotNPekLgcI9/6E7QA6mL7E+QPJjFkt5y4vGimlDYcm2eUGOJvMWtWfThM1QMuktoCGHnv2f1NioQCPU/SkRGvuFxSBV4wCU8BB/WRBZ+Cs770=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wvc814J_1766601105 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 25 Dec 2025 02:31:46 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 7/9] erofs-utils: lib: use separate xattr parsers for listxattr/getxattr
Date: Thu, 25 Dec 2025 02:31:29 +0800
Message-ID: <20251224183131.2302377-7-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251224183131.2302377-1-hsiangkao@linux.alibaba.com>
References: <20251224183131.2302377-1-hsiangkao@linux.alibaba.com>
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

Source kernel commit: f02615eb6f5a1e732230784bf0e3b6543540e853

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/xattr.c | 346 +++++++++++++++++++---------------------------------
 1 file changed, 125 insertions(+), 221 deletions(-)

diff --git a/lib/xattr.c b/lib/xattr.c
index 273da2cec91b..5624311fdbba 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -1176,262 +1176,152 @@ static int erofs_init_inode_xattrs(struct erofs_inode *vi)
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
+static int erofs_xattr_copy_to_buffer(struct erofs_xattr_iter *it,
+				      unsigned int len)
 {
+	unsigned int slice, processed;
 	struct erofs_sb_info *sbi = it->sbi;
 	int blkmask = erofs_blksiz(sbi) - 1;
-	struct erofs_xattr_entry entry;
-	unsigned int value_sz, processed, slice;
-	int err;
-
-	/* 0. fixup blkaddr, pos */
-	it->kaddr = erofs_bread(&it->buf, it->pos & ~blkmask, true);
-	if (IS_ERR(it->kaddr))
-		return PTR_ERR(it->kaddr);
-
-	/*
-	 * 1. read xattr entry to the memory,
-	 *    since we do EROFS_XATTR_ALIGN
-	 *    therefore entry should be in the page
-	 */
-	entry = *(struct erofs_xattr_entry *)
-		(it->kaddr + erofs_blkoff(sbi, it->pos));
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
-		it->kaddr = erofs_bread(&it->buf, it->pos & ~blkmask, true);
-		if (IS_ERR(it->kaddr)) {
-			err = PTR_ERR(it->kaddr);
-			goto out;
-		}
-
-		slice = min_t(unsigned int,
-			      erofs_blksiz(sbi) - erofs_blkoff(sbi, it->pos),
-			      entry.e_name_len - processed);
-
-		/* handle name */
-		err = op->name(it, processed,
-			       it->kaddr + erofs_blkoff(sbi, it->pos), slice);
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
+	void *src;
 
-	while (processed < value_sz) {
+	for (processed = 0; processed < len; processed += slice) {
 		it->kaddr = erofs_bread(&it->buf, it->pos & ~blkmask, true);
-		if (IS_ERR(it->kaddr)) {
-			err = PTR_ERR(it->kaddr);
-			goto out;
-		}
+		if (IS_ERR(it->kaddr))
+			return PTR_ERR(it->kaddr);
 
-		slice = min_t(unsigned int,
-			      erofs_blksiz(sbi) - erofs_blkoff(sbi, it->pos),
-			      value_sz - processed);
-		op->value(it, processed, it->kaddr + erofs_blkoff(sbi, it->pos),
-			  slice);
+		src = it->kaddr + erofs_blkoff(sbi, it->pos);
+		slice = min_t(unsigned int, erofs_blksiz(sbi) -
+				erofs_blkoff(sbi, it->pos), len - processed);
+		memcpy(it->buffer + it->buffer_ofs, src, slice);
+		it->buffer_ofs += slice;
 		it->pos += slice;
-		processed += slice;
 	}
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
-	struct erofs_sb_info *sbi = it->sbi;
-	struct erofs_xattr_prefix_item *pf = sbi->xattr_prefixes +
-		(entry->e_name_index & EROFS_XATTR_LONG_PREFIX_MASK);
-
-	if (pf >= sbi->xattr_prefixes + sbi->xattr_prefix_count)
-		return -ENOATTR;
-
-	if (it->index != pf->prefix->base_index ||
-	    it->len != entry->e_name_len + pf->infix_len)
-		return -ENOATTR;
-
-	if (memcmp(it->name, pf->prefix->infix, pf->infix_len))
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
-	    it->len != entry->e_name_len)
-		return -ENOATTR;
-	it->infix_len = 0;
-	return 0;
-}
-
-static int xattr_namematch(struct erofs_xattr_iter *it,
-			   unsigned int processed, char *buf, unsigned int len)
-{
-	if (memcmp(buf, it->name + it->infix_len + processed, len))
-		return -ENOATTR;
 	return 0;
 }
 
-static int xattr_checkbuffer(struct erofs_xattr_iter *it,
-			     unsigned int value_sz)
+static int erofs_listxattr_foreach(struct erofs_xattr_iter *it)
 {
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
-static int xattr_entrylist(struct erofs_xattr_iter *it,
-			   struct erofs_xattr_entry *entry)
-{
-	unsigned int base_index = entry->e_name_index;
-	unsigned int prefix_len, infix_len = 0;
+	struct erofs_xattr_entry entry;
+	unsigned int base_index, name_total, prefix_len, infix_len = 0;
 	const char *prefix, *infix = NULL;
+	int err;
 
-	if (entry->e_name_index & EROFS_XATTR_LONG_PREFIX) {
+	/* 1. handle xattr entry */
+	entry = *(struct erofs_xattr_entry *)
+		(it->kaddr + erofs_blkoff(it->sbi, it->pos));
+	it->pos += sizeof(struct erofs_xattr_entry);
+
+	base_index = entry.e_name_index;
+	if (entry.e_name_index & EROFS_XATTR_LONG_PREFIX) {
 		struct erofs_sb_info *sbi = it->sbi;
 		struct erofs_xattr_prefix_item *pf = sbi->xattr_prefixes +
-			(entry->e_name_index & EROFS_XATTR_LONG_PREFIX_MASK);
+			(entry.e_name_index & EROFS_XATTR_LONG_PREFIX_MASK);
 
 		if (pf >= sbi->xattr_prefixes + sbi->xattr_prefix_count)
-			return 1;
+			return 0;
 		infix = pf->prefix->infix;
 		infix_len = pf->infix_len;
 		base_index = pf->prefix->base_index;
 	}
 
 	if (!base_index || base_index >= ARRAY_SIZE(xattr_types))
-		return 1;
+		return 0;
 	prefix = xattr_types[base_index].prefix;
 	prefix_len = xattr_types[base_index].prefix_len;
+	name_total = prefix_len + infix_len + entry.e_name_len + 1;
 
 	if (!it->buffer) {
-		it->buffer_ofs += prefix_len + infix_len +
-					entry->e_name_len + 1;
-		return 1;
+		it->buffer_ofs += name_total;
+		return 0;
 	}
 
-	if (it->buffer_ofs + prefix_len + infix_len
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
+	struct erofs_sb_info *sbi = it->sbi;
+	int blkmask = erofs_blksiz(sbi) - 1;
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
+		(it->kaddr + erofs_blkoff(sbi, it->pos));
+	it->pos += sizeof(struct erofs_xattr_entry);
+	value_sz = le16_to_cpu(entry.e_value_size);
+
+	/* should also match the infix for long name prefixes */
+	if (entry.e_name_index & EROFS_XATTR_LONG_PREFIX) {
+		struct erofs_xattr_prefix_item *pf = sbi->xattr_prefixes +
+			(entry.e_name_index & EROFS_XATTR_LONG_PREFIX_MASK);
+
+		if (pf >= sbi->xattr_prefixes + sbi->xattr_prefix_count)
+			return -ENOATTR;
+
+		if (it->index != pf->prefix->base_index ||
+		    it->len != entry.e_name_len + pf->infix_len)
+			return -ENOATTR;
+
+		if (memcmp(it->name, pf->prefix->infix, pf->infix_len))
+			return -ENOATTR;
+
+		it->infix_len = pf->infix_len;
+	} else {
+		if (it->index != entry.e_name_index ||
+		    it->len != entry.e_name_len)
+			return -ENOATTR;
+
+		it->infix_len = 0;
+	}
+
+	/* 2. handle xattr name */
+	for (processed = 0; processed < entry.e_name_len; processed += slice) {
+		it->kaddr = erofs_bread(&it->buf, it->pos & ~blkmask, true);
+		if (IS_ERR(it->kaddr))
+			return PTR_ERR(it->kaddr);
+
+		slice = min_t(unsigned int,
+			      erofs_blksiz(sbi) - erofs_blkoff(sbi, it->pos),
+			      entry.e_name_len - processed);
+		if (memcmp(it->name + it->infix_len + processed,
+			   it->kaddr + erofs_blkoff(sbi, it->pos), slice))
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
 				   struct erofs_inode *vi, bool getxattr)
 {
 	struct erofs_sb_info *sbi = vi->sbi;
-	const struct xattr_iter_handlers *op;
-	unsigned int xattr_header_sz, remaining;
+	int blkmask = erofs_blksiz(sbi) - 1;
+	unsigned int xattr_header_sz, remaining, entry_sz;
+	erofs_off_t next_pos;
 	int ret;
 
 	xattr_header_sz = sizeof(struct erofs_xattr_ibody_header) +
@@ -1441,18 +1331,31 @@ static int erofs_xattr_iter_inline(struct erofs_xattr_iter *it,
 		return -ENOATTR;
 	}
 
-	it->pos = erofs_iloc(vi) + vi->inode_isize + xattr_header_sz;
-	it->kaddr = erofs_bread(&it->buf, it->pos & ~(erofs_blksiz(sbi) - 1),
-				true);
-	if (IS_ERR(it->kaddr))
-		return PTR_ERR(it->kaddr);
-
 	remaining = vi->xattr_isize - xattr_header_sz;
-	op = getxattr ? &find_xattr_handlers : &list_xattr_handlers;
+	it->pos = erofs_iloc(vi) + vi->inode_isize + xattr_header_sz;
 	while (remaining) {
-		ret = xattr_foreach(it, op, &remaining);
+		it->kaddr = erofs_bread(&it->buf, it->pos & ~blkmask, true);
+		if (IS_ERR(it->kaddr))
+			return PTR_ERR(it->kaddr);
+
+		entry_sz = erofs_xattr_entry_size(it->kaddr +
+				erofs_blkoff(it->sbi, it->pos));
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
@@ -1462,10 +1365,8 @@ static int erofs_xattr_iter_shared(struct erofs_xattr_iter *it,
 {
 	struct erofs_sb_info *sbi = vi->sbi;
 	unsigned int i;
-	const struct xattr_iter_handlers *op;
 	int ret = -ENOATTR;
 
-	op = getxattr ? &find_xattr_handlers : &list_xattr_handlers;
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
 		it->pos = erofs_pos(sbi, sbi->xattr_blkaddr) +
 				vi->xattr_shared_xattrs[i] * sizeof(__le32);
@@ -1474,7 +1375,10 @@ static int erofs_xattr_iter_shared(struct erofs_xattr_iter *it,
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
2.43.5


