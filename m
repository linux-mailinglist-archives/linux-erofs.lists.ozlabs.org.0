Return-Path: <linux-erofs+bounces-673-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CD0B09BC6
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Jul 2025 08:54:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bk0s85L7Sz3bmC;
	Fri, 18 Jul 2025 16:54:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752821676;
	cv=none; b=arMrupU4ph0k89bHVqJP2wT/6qdSH7BSuXRj3IuNvDMdwnaa1uNh8rSz5D47+ZOU6vzomInGiClg4kQkyfEA/KvrX0xgYJAA3S5DS4Qyt/lZxWELZsIa0r5cuJKKQIzcmC3mUQbmkWyFSDtG6NRfrhtMwjyqzQmqNDEYM6BdTxBm+fUTqA2fkD9XBYHcIrUYk28USp5ty5WaA0r8RSdUmasXXr99sWViGXC4WN4fmjKGLs/9b1Lw2UqhCbUry250t5o8IFXjrgih2EMlBiurxfUNeVascX/f89i/TfRIkWiYJWHck4319z30ub9u/lp5Q6FMdyFsGeWU6sCdCCPJJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752821676; c=relaxed/relaxed;
	bh=MBkNCGoFYlKdgksfP2ixfpbYuDEHWs9GW9R6Zsw1Q0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kd43ipIz12HZYlx2DXm/+qfqaUDvH6KazEb5TzhZnbqVUQGBXXTtR7t2tyrzunInLfYeLLjAwOj9YWHchUzewA751VuSyWnbnqKEkXJUsqYw580wf6zlb6MLp21+eWc6NlD4FMnSbtcS0Zbx1WVCy9fEFvWvzWcSvKBouLppb3VePYXW6cgmghJiEVCuU+MeLtm1cTF8gLZ8ChTgwgnd1PAmX8XjxpyM4wyEiPENPaP6kvbpB/ht27s1kv/kEvrOO7qpVCwRbIhaN32/sptZEvY4YuJYZbDxlfGFbQC8tzlTWnV8Q44vIx/KylbdliKyGRfWqtkluph2AQukPyfXTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=k941mdih; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=k941mdih;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bk0s74ljVz30WT
	for <linux-erofs@lists.ozlabs.org>; Fri, 18 Jul 2025 16:54:35 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752821671; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=MBkNCGoFYlKdgksfP2ixfpbYuDEHWs9GW9R6Zsw1Q0o=;
	b=k941mdihk9oWP9z/vbbu+4yjd8RwuPe8EfBn0muWYwcWz2OVQxNju0W35iy9i95Ipdvz9ivRbhKAdeukktf2mt8w3hcqaJYrLzknV987d5P739dI+X4Zx2AfmO3xuV9NYphmf0P9ok29VuHweSUy/WI2dsQmpEYmoLXjp9WD79M=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WjBMlSv_1752821670 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 18 Jul 2025 14:54:30 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 08/11] erofs-utils: lib: use meta buffers for xattr operations
Date: Fri, 18 Jul 2025 14:54:16 +0800
Message-ID: <20250718065419.3338307-8-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250718065419.3338307-1-hsiangkao@linux.alibaba.com>
References: <20250718065419.3338307-1-hsiangkao@linux.alibaba.com>
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

Source kernel commit: bb88e8da00253bea0e7f0f4cdfd7910572d7799f

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/xattr.c | 92 +++++++++++++++++++++++++----------------------------
 1 file changed, 44 insertions(+), 48 deletions(-)

diff --git a/lib/xattr.c b/lib/xattr.c
index 6711dcc1..a2ef8d20 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -1033,13 +1033,12 @@ char *erofs_export_xattr_ibody(struct erofs_inode *inode)
 }
 
 struct xattr_iter {
-	char page[EROFS_MAX_BLOCK_SIZE];
-
+	struct erofs_sb_info *sbi;
+	struct erofs_buf buf;
 	void *kaddr;
 
 	erofs_blk_t blkaddr;
 	unsigned int ofs;
-	struct erofs_sb_info *sbi;
 };
 
 static int init_inode_xattrs(struct erofs_inode *vi)
@@ -1075,20 +1074,23 @@ static int init_inode_xattrs(struct erofs_inode *vi)
 		return -ENOATTR;
 	}
 
+	it.buf = __EROFS_BUF_INITIALIZER;
 	it.blkaddr = erofs_blknr(sbi, erofs_iloc(vi) + vi->inode_isize);
 	it.ofs = erofs_blkoff(sbi, erofs_iloc(vi) + vi->inode_isize);
 
-	ret = erofs_blk_read(sbi, 0, it.page, it.blkaddr, 1);
-	if (ret < 0)
-		return -EIO;
+	/* read in shared xattr array (non-atomic, see kmalloc below) */
+	it.kaddr = erofs_read_metabuf(&it.buf, sbi, erofs_pos(sbi, it.blkaddr));
+	if (IS_ERR(it.kaddr))
+		return PTR_ERR(it.kaddr);
 
-	it.kaddr = it.page;
 	ih = (struct erofs_xattr_ibody_header *)(it.kaddr + it.ofs);
 
 	vi->xattr_shared_count = ih->h_shared_count;
 	vi->xattr_shared_xattrs = malloc(vi->xattr_shared_count * sizeof(uint));
-	if (!vi->xattr_shared_xattrs)
+	if (!vi->xattr_shared_xattrs) {
+		erofs_put_metabuf(&it.buf);
 		return -ENOMEM;
+	}
 
 	/* let's skip ibody header */
 	it.ofs += sizeof(struct erofs_xattr_ibody_header);
@@ -1098,20 +1100,20 @@ static int init_inode_xattrs(struct erofs_inode *vi)
 			/* cannot be unaligned */
 			DBG_BUGON(it.ofs != erofs_blksiz(sbi));
 
-			ret = erofs_blk_read(sbi, 0, it.page, ++it.blkaddr, 1);
-			if (ret < 0) {
+			it.kaddr = erofs_read_metabuf(&it.buf, sbi,
+					erofs_pos(sbi, ++it.blkaddr));
+			if (IS_ERR(it.kaddr)) {
 				free(vi->xattr_shared_xattrs);
 				vi->xattr_shared_xattrs = NULL;
-				return -EIO;
+				return PTR_ERR(it.kaddr);
 			}
-
-			it.kaddr = it.page;
 			it.ofs = 0;
 		}
 		vi->xattr_shared_xattrs[i] =
 			le32_to_cpu(*(__le32 *)(it.kaddr + it.ofs));
 		it.ofs += sizeof(__le32);
 	}
+	erofs_put_metabuf(&it.buf);
 	erofs_atomic_set_bit(EROFS_I_EA_INITED_BIT, &vi->flags);
 	return ret;
 }
@@ -1135,28 +1137,24 @@ struct xattr_iter_handlers {
 static inline int xattr_iter_fixup(struct xattr_iter *it)
 {
 	struct erofs_sb_info *sbi = it->sbi;
-	int ret;
 
 	if (it->ofs < erofs_blksiz(sbi))
 		return 0;
 
 	it->blkaddr += erofs_blknr(sbi, it->ofs);
-
-	ret = erofs_blk_read(sbi, 0, it->page, it->blkaddr, 1);
-	if (ret < 0)
-		return -EIO;
-
-	it->kaddr = it->page;
+	it->kaddr = erofs_read_metabuf(&it->buf, sbi,
+				       erofs_pos(sbi, it->blkaddr));
+	if (IS_ERR(it->kaddr))
+		return PTR_ERR(it->kaddr);
 	it->ofs = erofs_blkoff(sbi, it->ofs);
 	return 0;
 }
 
-static int inline_xattr_iter_pre(struct xattr_iter *it,
+static int inline_xattr_iter_begin(struct xattr_iter *it,
 				   struct erofs_inode *vi)
 {
 	struct erofs_sb_info *sbi = vi->sbi;
 	unsigned int xattr_header_sz, inline_xattr_ofs;
-	int ret;
 
 	xattr_header_sz = inlinexattr_header_size(vi);
 	if (xattr_header_sz >= vi->xattr_isize) {
@@ -1169,11 +1167,10 @@ static int inline_xattr_iter_pre(struct xattr_iter *it,
 	it->blkaddr = erofs_blknr(sbi, erofs_iloc(vi) + inline_xattr_ofs);
 	it->ofs = erofs_blkoff(sbi, erofs_iloc(vi) + inline_xattr_ofs);
 
-	ret = erofs_blk_read(sbi, 0, it->page, it->blkaddr, 1);
-	if (ret < 0)
-		return -EIO;
-
-	it->kaddr = it->page;
+	it->kaddr = erofs_read_metabuf(&it->buf, sbi,
+				       erofs_pos(sbi, it->blkaddr));
+	if (IS_ERR(it->kaddr))
+		return PTR_ERR(it->kaddr);
 	return vi->xattr_isize - xattr_header_sz;
 }
 
@@ -1370,7 +1367,7 @@ static int inline_getxattr(struct erofs_inode *vi, struct getxattr_iter *it)
 	int ret;
 	unsigned int remaining;
 
-	ret = inline_xattr_iter_pre(&it->it, vi);
+	ret = inline_xattr_iter_begin(&it->it, vi);
 	if (ret < 0)
 		return ret;
 
@@ -1386,6 +1383,7 @@ static int inline_getxattr(struct erofs_inode *vi, struct getxattr_iter *it)
 
 static int shared_getxattr(struct erofs_inode *vi, struct getxattr_iter *it)
 {
+	struct erofs_sb_info *sbi = vi->sbi;
 	unsigned int i;
 	int ret = -ENOATTR;
 
@@ -1394,15 +1392,11 @@ static int shared_getxattr(struct erofs_inode *vi, struct getxattr_iter *it)
 			xattrblock_addr(vi, vi->xattr_shared_xattrs[i]);
 
 		it->it.ofs = xattrblock_offset(vi, vi->xattr_shared_xattrs[i]);
-
-		if (!i || blkaddr != it->it.blkaddr) {
-			ret = erofs_blk_read(vi->sbi, 0, it->it.page, blkaddr, 1);
-			if (ret < 0)
-				return -EIO;
-
-			it->it.kaddr = it->it.page;
-			it->it.blkaddr = blkaddr;
-		}
+		it->it.kaddr = erofs_read_metabuf(&it->it.buf, sbi,
+						  erofs_pos(sbi, blkaddr));
+		if (IS_ERR(it->it.kaddr))
+			return PTR_ERR(it->it.kaddr);
+		it->it.blkaddr = blkaddr;
 
 		ret = xattr_foreach(&it->it, &find_xattr_handlers, NULL);
 		if (ret != -ENOATTR)
@@ -1435,12 +1429,14 @@ int erofs_getxattr(struct erofs_inode *vi, const char *name, char *buffer,
 	if (it.len > EROFS_NAME_LEN)
 		return -ERANGE;
 
+	it.it.buf = __EROFS_BUF_INITIALIZER;
 	it.buffer = buffer;
 	it.buffer_size = buffer_size;
 
 	ret = inline_getxattr(vi, &it);
 	if (ret == -ENOATTR)
 		ret = shared_getxattr(vi, &it);
+	erofs_put_metabuf(&it.it.buf);
 	return ret;
 }
 
@@ -1526,7 +1522,7 @@ static int inline_listxattr(struct erofs_inode *vi, struct listxattr_iter *it)
 	int ret;
 	unsigned int remaining;
 
-	ret = inline_xattr_iter_pre(&it->it, vi);
+	ret = inline_xattr_iter_begin(&it->it, vi);
 	if (ret < 0)
 		return ret;
 
@@ -1542,6 +1538,7 @@ static int inline_listxattr(struct erofs_inode *vi, struct listxattr_iter *it)
 
 static int shared_listxattr(struct erofs_inode *vi, struct listxattr_iter *it)
 {
+	struct erofs_sb_info *sbi = vi->sbi;
 	unsigned int i;
 	int ret = 0;
 
@@ -1550,14 +1547,11 @@ static int shared_listxattr(struct erofs_inode *vi, struct listxattr_iter *it)
 			xattrblock_addr(vi, vi->xattr_shared_xattrs[i]);
 
 		it->it.ofs = xattrblock_offset(vi, vi->xattr_shared_xattrs[i]);
-		if (!i || blkaddr != it->it.blkaddr) {
-			ret = erofs_blk_read(vi->sbi, 0, it->it.page, blkaddr, 1);
-			if (ret < 0)
-				return -EIO;
-
-			it->it.kaddr = it->it.page;
-			it->it.blkaddr = blkaddr;
-		}
+		it->it.kaddr = erofs_read_metabuf(&it->it.buf, sbi,
+						  erofs_pos(sbi, blkaddr));
+		if (IS_ERR(it->it.kaddr))
+			return PTR_ERR(it->it.kaddr);
+		it->it.blkaddr = blkaddr;
 
 		ret = xattr_foreach(&it->it, &list_xattr_handlers, NULL);
 		if (ret)
@@ -1579,14 +1573,16 @@ int erofs_listxattr(struct erofs_inode *vi, char *buffer, size_t buffer_size)
 		return ret;
 
 	it.it.sbi = vi->sbi;
+	it.it.buf = __EROFS_BUF_INITIALIZER;
 	it.buffer = buffer;
 	it.buffer_size = buffer_size;
 	it.buffer_ofs = 0;
 
 	ret = inline_listxattr(vi, &it);
 	if (ret < 0 && ret != -ENOATTR)
-		return ret;
-	return shared_listxattr(vi, &it);
+		ret = shared_listxattr(vi, &it);
+	erofs_put_metabuf(&it.it.buf);
+	return ret;
 }
 
 int erofs_xattr_insert_name_prefix(const char *prefix)
-- 
2.43.5


