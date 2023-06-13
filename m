Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BD472DB33
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Jun 2023 09:41:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QgL8n6pZSz30Nf
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Jun 2023 17:41:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QgL8d72qpz2yTN
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Jun 2023 17:41:20 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vl18NbP_1686642075;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vl18NbP_1686642075)
          by smtp.aliyun-inc.com;
          Tue, 13 Jun 2023 15:41:16 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v8 1/5] erofs: use absolute position in xattr iterator
Date: Tue, 13 Jun 2023 15:41:10 +0800
Message-Id: <20230613074114.120115-2-jefflexu@linux.alibaba.com>
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

Replace blkaddr/ofs with pos in 'struct erofs_xattr_iter'.

After erofs_bread() is introduced to replace raw page cache APIs for
metadata I/Os handling, xattr_iter_fixup() is no longer needed anymore.

In addition, it is also unnecessary to check if the iterated position is
span over the block boundary as absolute offset is used instead of
blkaddr + offset pairs.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/xattr.c | 162 +++++++++++++++++++----------------------------
 1 file changed, 65 insertions(+), 97 deletions(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index d9e041d27a35..4c11d4f4cf07 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -7,26 +7,11 @@
 #include <linux/security.h>
 #include "xattr.h"
 
-static inline erofs_blk_t erofs_xattr_blkaddr(struct super_block *sb,
-					      unsigned int xattr_id)
-{
-	return EROFS_SB(sb)->xattr_blkaddr +
-	       erofs_blknr(sb, xattr_id * sizeof(__u32));
-}
-
-static inline unsigned int erofs_xattr_blkoff(struct super_block *sb,
-					      unsigned int xattr_id)
-{
-	return erofs_blkoff(sb, xattr_id * sizeof(__u32));
-}
-
 struct xattr_iter {
 	struct super_block *sb;
 	struct erofs_buf buf;
+	erofs_off_t pos;
 	void *kaddr;
-
-	erofs_blk_t blkaddr;
-	unsigned int ofs;
 };
 
 static int erofs_init_inode_xattrs(struct inode *inode)
@@ -82,17 +67,16 @@ static int erofs_init_inode_xattrs(struct inode *inode)
 
 	it.buf = __EROFS_BUF_INITIALIZER;
 	erofs_init_metabuf(&it.buf, sb);
-	it.blkaddr = erofs_blknr(sb, erofs_iloc(inode) + vi->inode_isize);
-	it.ofs = erofs_blkoff(sb, erofs_iloc(inode) + vi->inode_isize);
+	it.pos = erofs_iloc(inode) + vi->inode_isize;
 
 	/* read in shared xattr array (non-atomic, see kmalloc below) */
-	it.kaddr = erofs_bread(&it.buf, it.blkaddr, EROFS_KMAP);
+	it.kaddr = erofs_bread(&it.buf, erofs_blknr(sb, it.pos), EROFS_KMAP);
 	if (IS_ERR(it.kaddr)) {
 		ret = PTR_ERR(it.kaddr);
 		goto out_unlock;
 	}
 
-	ih = (struct erofs_xattr_ibody_header *)(it.kaddr + it.ofs);
+	ih = it.kaddr + erofs_blkoff(sb, it.pos);
 	vi->xattr_shared_count = ih->h_shared_count;
 	vi->xattr_shared_xattrs = kmalloc_array(vi->xattr_shared_count,
 						sizeof(uint), GFP_KERNEL);
@@ -103,25 +87,20 @@ static int erofs_init_inode_xattrs(struct inode *inode)
 	}
 
 	/* let's skip ibody header */
-	it.ofs += sizeof(struct erofs_xattr_ibody_header);
+	it.pos += sizeof(struct erofs_xattr_ibody_header);
 
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
-		if (it.ofs >= sb->s_blocksize) {
-			/* cannot be unaligned */
-			DBG_BUGON(it.ofs != sb->s_blocksize);
-
-			it.kaddr = erofs_bread(&it.buf, ++it.blkaddr, EROFS_KMAP);
-			if (IS_ERR(it.kaddr)) {
-				kfree(vi->xattr_shared_xattrs);
-				vi->xattr_shared_xattrs = NULL;
-				ret = PTR_ERR(it.kaddr);
-				goto out_unlock;
-			}
-			it.ofs = 0;
+		it.kaddr = erofs_bread(&it.buf, erofs_blknr(sb, it.pos),
+				       EROFS_KMAP);
+		if (IS_ERR(it.kaddr)) {
+			kfree(vi->xattr_shared_xattrs);
+			vi->xattr_shared_xattrs = NULL;
+			ret = PTR_ERR(it.kaddr);
+			goto out_unlock;
 		}
-		vi->xattr_shared_xattrs[i] =
-			le32_to_cpu(*(__le32 *)(it.kaddr + it.ofs));
-		it.ofs += sizeof(__le32);
+		vi->xattr_shared_xattrs[i] = le32_to_cpu(*(__le32 *)
+				(it.kaddr + erofs_blkoff(sb, it.pos)));
+		it.pos += sizeof(__le32);
 	}
 	erofs_put_metabuf(&it.buf);
 
@@ -150,24 +129,11 @@ struct xattr_iter_handlers {
 		      unsigned int len);
 };
 
-static inline int xattr_iter_fixup(struct xattr_iter *it)
-{
-	if (it->ofs < it->sb->s_blocksize)
-		return 0;
-
-	it->blkaddr += erofs_blknr(it->sb, it->ofs);
-	it->kaddr = erofs_bread(&it->buf, it->blkaddr, EROFS_KMAP);
-	if (IS_ERR(it->kaddr))
-		return PTR_ERR(it->kaddr);
-	it->ofs = erofs_blkoff(it->sb, it->ofs);
-	return 0;
-}
-
 static int inline_xattr_iter_begin(struct xattr_iter *it,
 				   struct inode *inode)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
-	unsigned int xattr_header_sz, inline_xattr_ofs;
+	unsigned int xattr_header_sz;
 
 	xattr_header_sz = sizeof(struct erofs_xattr_ibody_header) +
 			  sizeof(u32) * vi->xattr_shared_count;
@@ -176,11 +142,9 @@ static int inline_xattr_iter_begin(struct xattr_iter *it,
 		return -ENOATTR;
 	}
 
-	inline_xattr_ofs = vi->inode_isize + xattr_header_sz;
-
-	it->blkaddr = erofs_blknr(it->sb, erofs_iloc(inode) + inline_xattr_ofs);
-	it->ofs = erofs_blkoff(it->sb, erofs_iloc(inode) + inline_xattr_ofs);
-	it->kaddr = erofs_bread(&it->buf, it->blkaddr, EROFS_KMAP);
+	it->pos = erofs_iloc(inode) + vi->inode_isize + xattr_header_sz;
+	it->kaddr = erofs_bread(&it->buf, erofs_blknr(it->sb, it->pos),
+				EROFS_KMAP);
 	if (IS_ERR(it->kaddr))
 		return PTR_ERR(it->kaddr);
 	return vi->xattr_isize - xattr_header_sz;
@@ -188,27 +152,29 @@ static int inline_xattr_iter_begin(struct xattr_iter *it,
 
 /*
  * Regardless of success or failure, `xattr_foreach' will end up with
- * `ofs' pointing to the next xattr item rather than an arbitrary position.
+ * `pos' pointing to the next xattr item rather than an arbitrary position.
  */
 static int xattr_foreach(struct xattr_iter *it,
 			 const struct xattr_iter_handlers *op,
 			 unsigned int *tlimit)
 {
 	struct erofs_xattr_entry entry;
+	struct super_block *sb = it->sb;
 	unsigned int value_sz, processed, slice;
 	int err;
 
-	/* 0. fixup blkaddr, ofs, ipage */
-	err = xattr_iter_fixup(it);
-	if (err)
-		return err;
+	/* 0. fixup blkaddr, pos */
+	it->kaddr = erofs_bread(&it->buf, erofs_blknr(sb, it->pos), EROFS_KMAP);
+	if (IS_ERR(it->kaddr))
+		return PTR_ERR(it->kaddr);
 
 	/*
 	 * 1. read xattr entry to the memory,
 	 *    since we do EROFS_XATTR_ALIGN
 	 *    therefore entry should be in the page
 	 */
-	entry = *(struct erofs_xattr_entry *)(it->kaddr + it->ofs);
+	entry = *(struct erofs_xattr_entry *)
+		(it->kaddr + erofs_blkoff(sb, it->pos));
 	if (tlimit) {
 		unsigned int entry_sz = erofs_xattr_entry_size(&entry);
 
@@ -220,40 +186,40 @@ static int xattr_foreach(struct xattr_iter *it,
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
-		if (it->ofs >= it->sb->s_blocksize) {
-			DBG_BUGON(it->ofs > it->sb->s_blocksize);
-
-			err = xattr_iter_fixup(it);
-			if (err)
-				goto out;
-			it->ofs = 0;
+		it->kaddr = erofs_bread(&it->buf, erofs_blknr(sb, it->pos),
+					EROFS_KMAP);
+		if (IS_ERR(it->kaddr)) {
+			err = PTR_ERR(it->kaddr);
+			goto out;
 		}
 
-		slice = min_t(unsigned int, it->sb->s_blocksize - it->ofs,
+		slice = min_t(unsigned int,
+			      sb->s_blocksize - erofs_blkoff(sb, it->pos),
 			      entry.e_name_len - processed);
 
 		/* handle name */
-		err = op->name(it, processed, it->kaddr + it->ofs, slice);
+		err = op->name(it, processed,
+			       it->kaddr + erofs_blkoff(sb, it->pos), slice);
 		if (err) {
-			it->ofs += entry.e_name_len - processed + value_sz;
+			it->pos += entry.e_name_len - processed + value_sz;
 			goto out;
 		}
 
-		it->ofs += slice;
+		it->pos += slice;
 		processed += slice;
 	}
 
@@ -263,31 +229,31 @@ static int xattr_foreach(struct xattr_iter *it,
 	if (op->alloc_buffer) {
 		err = op->alloc_buffer(it, value_sz);
 		if (err) {
-			it->ofs += value_sz;
+			it->pos += value_sz;
 			goto out;
 		}
 	}
 
 	while (processed < value_sz) {
-		if (it->ofs >= it->sb->s_blocksize) {
-			DBG_BUGON(it->ofs > it->sb->s_blocksize);
-
-			err = xattr_iter_fixup(it);
-			if (err)
-				goto out;
-			it->ofs = 0;
+		it->kaddr = erofs_bread(&it->buf, erofs_blknr(sb, it->pos),
+					EROFS_KMAP);
+		if (IS_ERR(it->kaddr)) {
+			err = PTR_ERR(it->kaddr);
+			goto out;
 		}
 
-		slice = min_t(unsigned int, it->sb->s_blocksize - it->ofs,
+		slice = min_t(unsigned int,
+			      sb->s_blocksize - erofs_blkoff(sb, it->pos),
 			      value_sz - processed);
-		op->value(it, processed, it->kaddr + it->ofs, slice);
-		it->ofs += slice;
+		op->value(it, processed, it->kaddr + erofs_blkoff(sb, it->pos),
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
 
@@ -394,14 +360,15 @@ static int shared_getxattr(struct inode *inode, struct getxattr_iter *it)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
 	struct super_block *const sb = it->it.sb;
-	unsigned int i, xsid;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	unsigned int i;
 	int ret = -ENOATTR;
 
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
-		xsid = vi->xattr_shared_xattrs[i];
-		it->it.blkaddr = erofs_xattr_blkaddr(sb, xsid);
-		it->it.ofs = erofs_xattr_blkoff(sb, xsid);
-		it->it.kaddr = erofs_bread(&it->it.buf, it->it.blkaddr, EROFS_KMAP);
+		it->it.pos = erofs_pos(sb, sbi->xattr_blkaddr) +
+				vi->xattr_shared_xattrs[i] * sizeof(__le32);
+		it->it.kaddr = erofs_bread(&it->it.buf,
+				erofs_blknr(sb, it->it.pos), EROFS_KMAP);
 		if (IS_ERR(it->it.kaddr))
 			return PTR_ERR(it->it.kaddr);
 
@@ -599,14 +566,15 @@ static int shared_listxattr(struct listxattr_iter *it)
 	struct inode *const inode = d_inode(it->dentry);
 	struct erofs_inode *const vi = EROFS_I(inode);
 	struct super_block *const sb = it->it.sb;
-	unsigned int i, xsid;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	unsigned int i;
 	int ret = 0;
 
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
-		xsid = vi->xattr_shared_xattrs[i];
-		it->it.blkaddr = erofs_xattr_blkaddr(sb, xsid);
-		it->it.ofs = erofs_xattr_blkoff(sb, xsid);
-		it->it.kaddr = erofs_bread(&it->it.buf, it->it.blkaddr, EROFS_KMAP);
+		it->it.pos = erofs_pos(sb, sbi->xattr_blkaddr) +
+				vi->xattr_shared_xattrs[i] * sizeof(__le32);
+		it->it.kaddr = erofs_bread(&it->it.buf,
+				erofs_blknr(sb, it->it.pos), EROFS_KMAP);
 		if (IS_ERR(it->it.kaddr))
 			return PTR_ERR(it->it.kaddr);
 
-- 
2.19.1.6.gb485710b

