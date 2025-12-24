Return-Path: <linux-erofs+bounces-1596-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 050E3CDD002
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Dec 2025 19:32:03 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dc0pJ5GPSz2yS0;
	Thu, 25 Dec 2025 05:31:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766601112;
	cv=none; b=Ia5iF7G05uoN2NEd4PQCCySMxh5rfB+a2OiBvMYwDtPLK16XRhTeq5h22F5Bwi8ju3T/02aO6uMNoT8/a9hAVOOSzeBBghV7FRiqoVrr1RzsZ4fnZhk1sAA6KSPTU2qfZdhRceVYNXniiPh75X/O9wsQrE+E/5Cecdq+qf5rXiyyjD6Px9HCP79F7+W2hF6orDpUz+mHJhdMpHdasMhq9XBMWZfvYi6VVwziSoH1fUHsHLwvO7tcAbsUo1QpI1ABmPTVe9nPqnLV1L6NRTCnu26AiySXXdIQH1u3NSovdxJToXPbn/Tb9m9q0m5Ojj5Q4doszU1fTCM350V0kor2NA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766601112; c=relaxed/relaxed;
	bh=68go5dEF0yFDBrMimDeSzNoc5zcCrTwErlAD+NAwi4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQbhB190oYvM6KEVCEZsdbW0R5ksCSrrJTGtnLjg73arD9dtjcjKbmA2zYqbZwSgsmrzKAagTB7hhNzp9Yeu2hv+CvrgWFL7Ok4OQFnmLbs2gTOu9YRjW+HW6aPfVKM7RbXeNE8jj0IEjjT6c48yo2x4RZT/P4eTqlwTJYSVrNs0wT+m/6Q0qWQ7PEgOKxrlhgwcD1H6wjPX+/fIveeez9cUlBhNTN0zmzdr4H/yc7GZgzWRxYzxQApXq8iIIebhzcXwatfcclH0EPxK8YPYmy/AmQ/uhS2qXWLpbbDcQL6fds+HZwl+k7zq4J0v266pDc+X9CzD1hXfuqCwSbniaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=EG3yb30U; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=EG3yb30U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dc0pD3Qjkz2yRC
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Dec 2025 05:31:47 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766601103; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=68go5dEF0yFDBrMimDeSzNoc5zcCrTwErlAD+NAwi4o=;
	b=EG3yb30UBNhEb3StVUQLZ7JZ2jLOvgFH9CAmAjmob+XpwmZ5o39PPdhr3J6Y/AcnIsLdj2sQtdnzxVVglNhLCCCmS4Qkf/Y7uwN+gmR0T6cxezGLj4Ue4adTNxZKV1Bd83nuxt7PcEbhVs0WPWaqUC/M09PqtD3wvaV5y4NkS3w=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wvc813-_1766601101 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 25 Dec 2025 02:31:42 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 3/9] erofs-utils: lib: use absolute position in xattr iterator
Date: Thu, 25 Dec 2025 02:31:25 +0800
Message-ID: <20251224183131.2302377-3-hsiangkao@linux.alibaba.com>
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

Source kernel commit: eba67eb6de441909a22090bc77206c91134cd58c

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/xattr.h |  18 ------
 lib/xattr.c           | 146 +++++++++++++++++-------------------------
 2 files changed, 57 insertions(+), 107 deletions(-)

diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index 4e74cc523dae..3ec51bad5175 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -1,9 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
-/*
- * Originally contributed by an anonymous person,
- * heavily changed by Li Guifu <blucerlee@gmail.com>
- *                and Gao Xiang <xiang@kernel.org>
- */
 #ifndef __EROFS_XATTR_H
 #define __EROFS_XATTR_H
 
@@ -24,19 +19,6 @@ static inline unsigned int inlinexattr_header_size(struct erofs_inode *vi)
 		sizeof(u32) * vi->xattr_shared_count;
 }
 
-static inline erofs_blk_t xattrblock_addr(struct erofs_inode *vi,
-					  unsigned int xattr_id)
-{
-	return vi->sbi->xattr_blkaddr +
-		erofs_blknr(vi->sbi, xattr_id * sizeof(__u32));
-}
-
-static inline unsigned int xattrblock_offset(struct erofs_inode *vi,
-					     unsigned int xattr_id)
-{
-	return erofs_blkoff(vi->sbi, xattr_id * sizeof(__u32));
-}
-
 #define EROFS_INODE_XATTR_ICOUNT(_size)	({\
 	u32 __size = le16_to_cpu(_size); \
 	((__size) == 0) ? 0 : \
diff --git a/lib/xattr.c b/lib/xattr.c
index 9e329ff77bf8..b5582bb0ca95 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -1093,15 +1093,14 @@ char *erofs_export_xattr_ibody(struct erofs_inode *inode)
 struct xattr_iter {
 	struct erofs_sb_info *sbi;
 	struct erofs_buf buf;
+	erofs_off_t pos;
 	void *kaddr;
-
-	erofs_blk_t blkaddr;
-	unsigned int ofs;
 };
 
 static int erofs_init_inode_xattrs(struct erofs_inode *vi)
 {
 	struct erofs_sb_info *sbi = vi->sbi;
+	int blkmask = erofs_blksiz(sbi) - 1;
 	struct xattr_iter it;
 	unsigned int i;
 	struct erofs_xattr_ibody_header *ih;
@@ -1134,15 +1133,14 @@ static int erofs_init_inode_xattrs(struct erofs_inode *vi)
 
 	it.buf = __EROFS_BUF_INITIALIZER;
 	erofs_init_metabuf(&it.buf, sbi, false);
-	it.blkaddr = erofs_blknr(sbi, erofs_iloc(vi) + vi->inode_isize);
-	it.ofs = erofs_blkoff(sbi, erofs_iloc(vi) + vi->inode_isize);
+	it.pos = erofs_iloc(vi) + vi->inode_isize;
 
 	/* read in shared xattr array (non-atomic, see kmalloc below) */
-	it.kaddr = erofs_bread(&it.buf, erofs_pos(sbi, it.blkaddr), true);
+	it.kaddr = erofs_bread(&it.buf, it.pos & ~blkmask, true);
 	if (IS_ERR(it.kaddr))
 		return PTR_ERR(it.kaddr);
 
-	ih = (struct erofs_xattr_ibody_header *)(it.kaddr + it.ofs);
+	ih = it.kaddr + erofs_blkoff(sbi, it.pos);
 
 	vi->xattr_shared_count = ih->h_shared_count;
 	vi->xattr_shared_xattrs = malloc(vi->xattr_shared_count * sizeof(uint));
@@ -1152,25 +1150,18 @@ static int erofs_init_inode_xattrs(struct erofs_inode *vi)
 	}
 
 	/* let's skip ibody header */
-	it.ofs += sizeof(struct erofs_xattr_ibody_header);
+	it.pos += sizeof(struct erofs_xattr_ibody_header);
 
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
-		if (it.ofs >= erofs_blksiz(sbi)) {
-			/* cannot be unaligned */
-			DBG_BUGON(it.ofs != erofs_blksiz(sbi));
-
-			it.kaddr = erofs_bread(&it.buf,
-					erofs_pos(sbi, ++it.blkaddr), true);
-			if (IS_ERR(it.kaddr)) {
-				free(vi->xattr_shared_xattrs);
-				vi->xattr_shared_xattrs = NULL;
-				return PTR_ERR(it.kaddr);
-			}
-			it.ofs = 0;
+		it.kaddr = erofs_bread(&it.buf, it.pos & ~blkmask, true);
+		if (IS_ERR(it.kaddr)) {
+			free(vi->xattr_shared_xattrs);
+			vi->xattr_shared_xattrs = NULL;
+			return PTR_ERR(it.kaddr);
 		}
-		vi->xattr_shared_xattrs[i] =
-			le32_to_cpu(*(__le32 *)(it.kaddr + it.ofs));
-		it.ofs += sizeof(__le32);
+		vi->xattr_shared_xattrs[i] = le32_to_cpu(*(__le32 *)
+			(it.kaddr + erofs_blkoff(sbi, it.pos)));
+		it.pos += sizeof(__le32);
 	}
 	erofs_put_metabuf(&it.buf);
 	erofs_atomic_set_bit(EROFS_I_EA_INITED_BIT, &vi->flags);
@@ -1193,26 +1184,11 @@ struct xattr_iter_handlers {
 		      unsigned int len);
 };
 
-static inline int xattr_iter_fixup(struct xattr_iter *it)
-{
-	struct erofs_sb_info *sbi = it->sbi;
-
-	if (it->ofs < erofs_blksiz(sbi))
-		return 0;
-
-	it->blkaddr += erofs_blknr(sbi, it->ofs);
-	it->kaddr = erofs_bread(&it->buf, erofs_pos(sbi, it->blkaddr), true);
-	if (IS_ERR(it->kaddr))
-		return PTR_ERR(it->kaddr);
-	it->ofs = erofs_blkoff(sbi, it->ofs);
-	return 0;
-}
-
 static int inline_xattr_iter_begin(struct xattr_iter *it,
 				   struct erofs_inode *vi)
 {
 	struct erofs_sb_info *sbi = vi->sbi;
-	unsigned int xattr_header_sz, inline_xattr_ofs;
+	unsigned int xattr_header_sz;
 
 	xattr_header_sz = inlinexattr_header_size(vi);
 	if (xattr_header_sz >= vi->xattr_isize) {
@@ -1220,12 +1196,9 @@ static int inline_xattr_iter_begin(struct xattr_iter *it,
 		return -ENOATTR;
 	}
 
-	inline_xattr_ofs = vi->inode_isize + xattr_header_sz;
-
-	it->blkaddr = erofs_blknr(sbi, erofs_iloc(vi) + inline_xattr_ofs);
-	it->ofs = erofs_blkoff(sbi, erofs_iloc(vi) + inline_xattr_ofs);
-
-	it->kaddr = erofs_bread(&it->buf, erofs_pos(sbi, it->blkaddr), true);
+	it->pos = erofs_iloc(vi) + vi->inode_isize + xattr_header_sz;
+	it->kaddr = erofs_bread(&it->buf, it->pos & ~(erofs_blksiz(sbi) - 1),
+				true);
 	if (IS_ERR(it->kaddr))
 		return PTR_ERR(it->kaddr);
 	return vi->xattr_isize - xattr_header_sz;
@@ -1233,28 +1206,30 @@ static int inline_xattr_iter_begin(struct xattr_iter *it,
 
 /*
  * Regardless of success or failure, `xattr_foreach' will end up with
- * `ofs' pointing to the next xattr item rather than an arbitrary position.
+ * `pos' pointing to the next xattr item rather than an arbitrary position.
  */
 static int xattr_foreach(struct xattr_iter *it,
 			 const struct xattr_iter_handlers *op,
 			 unsigned int *tlimit)
 {
 	struct erofs_sb_info *sbi = it->sbi;
+	int blkmask = erofs_blksiz(sbi) - 1;
 	struct erofs_xattr_entry entry;
 	unsigned int value_sz, processed, slice;
 	int err;
 
-	/* 0. fixup blkaddr, ofs, ipage */
-	err = xattr_iter_fixup(it);
-	if (err)
-		return err;
+	/* 0. fixup blkaddr, pos */
+	it->kaddr = erofs_bread(&it->buf, it->pos & ~blkmask, true);
+	if (IS_ERR(it->kaddr))
+		return PTR_ERR(it->kaddr);
 
 	/*
 	 * 1. read xattr entry to the memory,
 	 *    since we do EROFS_XATTR_ALIGN
 	 *    therefore entry should be in the page
 	 */
-	entry = *(struct erofs_xattr_entry *)(it->kaddr + it->ofs);
+	entry = *(struct erofs_xattr_entry *)
+		(it->kaddr + erofs_blkoff(sbi, it->pos));
 	if (tlimit) {
 		unsigned int entry_sz = erofs_xattr_entry_size(&entry);
 
@@ -1266,40 +1241,39 @@ static int xattr_foreach(struct xattr_iter *it,
 		*tlimit -= entry_sz;
 	}
 
-	it->ofs += sizeof(struct erofs_xattr_entry);
+	it->pos += sizeof(struct erofs_xattr_entry);
 	value_sz = le16_to_cpu(entry.e_value_size);
 
 	/* handle entry */
 	err = op->entry(it, &entry);
 	if (err) {
-		it->ofs += entry.e_name_len + value_sz;
+		it->pos += entry.e_name_len + value_sz;
 		goto out;
 	}
 
-	/* 2. handle xattr name (ofs will finally be at the end of name) */
+	/* 2. handle xattr name (pos will finally be at the end of name) */
 	processed = 0;
 
 	while (processed < entry.e_name_len) {
-		if (it->ofs >= erofs_blksiz(sbi)) {
-			DBG_BUGON(it->ofs > erofs_blksiz(sbi));
-
-			err = xattr_iter_fixup(it);
-			if (err)
-				goto out;
-			it->ofs = 0;
+		it->kaddr = erofs_bread(&it->buf, it->pos & ~blkmask, true);
+		if (IS_ERR(it->kaddr)) {
+			err = PTR_ERR(it->kaddr);
+			goto out;
 		}
 
-		slice = min_t(unsigned int, erofs_blksiz(sbi) - it->ofs,
+		slice = min_t(unsigned int,
+			      erofs_blksiz(sbi) - erofs_blkoff(sbi, it->pos),
 			      entry.e_name_len - processed);
 
 		/* handle name */
-		err = op->name(it, processed, it->kaddr + it->ofs, slice);
+		err = op->name(it, processed,
+			       it->kaddr + erofs_blkoff(sbi, it->pos), slice);
 		if (err) {
-			it->ofs += entry.e_name_len - processed + value_sz;
+			it->pos += entry.e_name_len - processed + value_sz;
 			goto out;
 		}
 
-		it->ofs += slice;
+		it->pos += slice;
 		processed += slice;
 	}
 
@@ -1309,31 +1283,30 @@ static int xattr_foreach(struct xattr_iter *it,
 	if (op->alloc_buffer) {
 		err = op->alloc_buffer(it, value_sz);
 		if (err) {
-			it->ofs += value_sz;
+			it->pos += value_sz;
 			goto out;
 		}
 	}
 
 	while (processed < value_sz) {
-		if (it->ofs >= erofs_blksiz(sbi)) {
-			DBG_BUGON(it->ofs > erofs_blksiz(sbi));
-
-			err = xattr_iter_fixup(it);
-			if (err)
-				goto out;
-			it->ofs = 0;
+		it->kaddr = erofs_bread(&it->buf, it->pos & ~blkmask, true);
+		if (IS_ERR(it->kaddr)) {
+			err = PTR_ERR(it->kaddr);
+			goto out;
 		}
 
-		slice = min_t(unsigned int, erofs_blksiz(sbi) - it->ofs,
+		slice = min_t(unsigned int,
+			      erofs_blksiz(sbi) - erofs_blkoff(sbi, it->pos),
 			      value_sz - processed);
-		op->value(it, processed, it->kaddr + it->ofs, slice);
-		it->ofs += slice;
+		op->value(it, processed, it->kaddr + erofs_blkoff(sbi, it->pos),
+			  slice);
+		it->pos += slice;
 		processed += slice;
 	}
 
 out:
 	/* xattrs should be 4-byte aligned (on-disk constraint) */
-	it->ofs = EROFS_XATTR_ALIGN(it->ofs);
+	it->pos = EROFS_XATTR_ALIGN(it->pos);
 	return err < 0 ? err : 0;
 }
 
@@ -1441,19 +1414,17 @@ static int inline_getxattr(struct erofs_inode *vi, struct getxattr_iter *it)
 static int shared_getxattr(struct erofs_inode *vi, struct getxattr_iter *it)
 {
 	struct erofs_sb_info *sbi = vi->sbi;
+	int blkmask = erofs_blksiz(sbi) - 1;
 	unsigned int i;
 	int ret = -ENOATTR;
 
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
-		erofs_blk_t blkaddr =
-			xattrblock_addr(vi, vi->xattr_shared_xattrs[i]);
-
-		it->it.ofs = xattrblock_offset(vi, vi->xattr_shared_xattrs[i]);
+		it->it.pos = erofs_pos(sbi, sbi->xattr_blkaddr) +
+				vi->xattr_shared_xattrs[i] * sizeof(__le32);
 		it->it.kaddr = erofs_bread(&it->it.buf,
-					   erofs_pos(sbi, blkaddr), true);
+				it->it.pos & ~blkmask, true);
 		if (IS_ERR(it->it.kaddr))
 			return PTR_ERR(it->it.kaddr);
-		it->it.blkaddr = blkaddr;
 
 		ret = xattr_foreach(&it->it, &find_xattr_handlers, NULL);
 		if (ret != -ENOATTR)
@@ -1601,15 +1572,12 @@ static int shared_listxattr(struct erofs_inode *vi, struct listxattr_iter *it)
 	int ret = 0;
 
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
-		erofs_blk_t blkaddr =
-			xattrblock_addr(vi, vi->xattr_shared_xattrs[i]);
-
-		it->it.ofs = xattrblock_offset(vi, vi->xattr_shared_xattrs[i]);
+		it->it.pos = erofs_pos(sbi, sbi->xattr_blkaddr) +
+				vi->xattr_shared_xattrs[i] * sizeof(__le32);
 		it->it.kaddr = erofs_bread(&it->it.buf,
-					   erofs_pos(sbi, blkaddr), true);
+				it->it.pos & ~(erofs_blksiz(sbi) - 1), true);
 		if (IS_ERR(it->it.kaddr))
 			return PTR_ERR(it->it.kaddr);
-		it->it.blkaddr = blkaddr;
 
 		ret = xattr_foreach(&it->it, &list_xattr_handlers, NULL);
 		if (ret)
-- 
2.43.5


