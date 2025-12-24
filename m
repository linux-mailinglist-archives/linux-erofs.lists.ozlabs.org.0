Return-Path: <linux-erofs+bounces-1597-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DFBCDD003
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Dec 2025 19:32:03 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dc0pK1PxKz2yRC;
	Thu, 25 Dec 2025 05:31:53 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766601113;
	cv=none; b=TdP7NnbhASMlrLh2T95aLw3TuNvwyvag4Sby0fmLMxoulN4o6KgGTI7RCpxyvIotgHLhalYLfuu2Ma+S4wOX7uTpn0EZ/HZwkMS3kEo0Bi3QPAfaEZ7o7fDKiuniwJQkhAf72pil0wOAJZBQ8MfHatBPSD0pBAtwk2dy6IFth6SKssyTqBclyOpGq8yKZ5GMo9SXOrWyxrJ8Sz15okd48UJxkmTgRvEZmzqwjlE67bLcTnEzay2d0WBEG6v8oJyc6snqdckPQHh4a2MbZEvzyft6q5ub2BC/lBlU/HGwzTQ43K8ATUmWVVOEogntxkcdCBEKa98QaKJk7r5XckHfPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766601113; c=relaxed/relaxed;
	bh=1Hibq9aFkUlJMW/Rz3tcHxyDppRVWn3KwyyvGuobQSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WK+T7gF/at49hmk976NXRi0nOlnKVmSOIppUikmAXeLu5eUp1SO2AGiXRk7shomMkH0a7wWvZDuEkXSA/EEk0+xNZ/6oJ5zfGfjSJqzKlQUndpGaeI4z8z3IfX0BetPfBO6v9q2ScO4LAun+QPUnLNmr73bf6/0mPjt6ELvkrLjCiuQnnxMRuXm+FP1ZPG0OcwKgyKHq+1k9R9RmcfBefoU9Pf/2wVAZhcvO7khJnVt5L4y4ntkfoOGmWjqvZfuhmy3NCRXFWWAN4I/NO5e9iG7Y3BR2mRmBJeN81zMNlM04rfwWqKoXu8E+aYv2EV7p1FUrcgMnMcGzFvr/Zs/byg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YtOF85fD; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YtOF85fD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dc0pH4ch4z2yQH
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Dec 2025 05:31:50 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766601106; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=1Hibq9aFkUlJMW/Rz3tcHxyDppRVWn3KwyyvGuobQSg=;
	b=YtOF85fDFyZLzbzUaQT5QTZY0JOxNJBBh2Sx5Z886d1gPLZC5DCUSnBROSzlqrTCekwk2IM+uKEisrFvWDczRqOCujbE+2c8xKSLJ/v5qEqJxuYGtEdo3RxgN1NFQQ3ZnOwVRLnUkwBBHSQ/CWM0az9SBPI081M3xeCh4auIt6k=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wvc813u_1766601104 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 25 Dec 2025 02:31:45 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 6/9] erofs-utils: lib: unify inline/shared xattr iterators for listxattr/getxattr
Date: Thu, 25 Dec 2025 02:31:28 +0800
Message-ID: <20251224183131.2302377-6-hsiangkao@linux.alibaba.com>
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

Source kernel commit: 4b077b501266c6c6784656cd8721db37c090c5df

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/xattr.c | 194 +++++++++++++++++++---------------------------------
 1 file changed, 71 insertions(+), 123 deletions(-)

diff --git a/lib/xattr.c b/lib/xattr.c
index 585908f61623..273da2cec91b 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -1103,9 +1103,6 @@ struct erofs_xattr_iter {
 	int index, infix_len;
 	const char *name;
 	size_t len;
-
-	/* listxattr */
-	struct erofs_inode *inode;
 };
 
 static int erofs_init_inode_xattrs(struct erofs_inode *vi)
@@ -1195,26 +1192,6 @@ struct xattr_iter_handlers {
 		      unsigned int len);
 };
 
-static int inline_xattr_iter_begin(struct erofs_xattr_iter *it,
-				   struct erofs_inode *vi)
-{
-	struct erofs_sb_info *sbi = vi->sbi;
-	unsigned int xattr_header_sz;
-
-	xattr_header_sz = inlinexattr_header_size(vi);
-	if (xattr_header_sz >= vi->xattr_isize) {
-		DBG_BUGON(xattr_header_sz > vi->xattr_isize);
-		return -ENOATTR;
-	}
-
-	it->pos = erofs_iloc(vi) + vi->inode_isize + xattr_header_sz;
-	it->kaddr = erofs_bread(&it->buf, it->pos & ~(erofs_blksiz(sbi) - 1),
-				true);
-	if (IS_ERR(it->kaddr))
-		return PTR_ERR(it->kaddr);
-	return vi->xattr_isize - xattr_header_sz;
-}
-
 /*
  * Regardless of success or failure, `xattr_foreach' will end up with
  * `pos' pointing to the next xattr item rather than an arbitrary position.
@@ -1387,84 +1364,6 @@ static const struct xattr_iter_handlers find_xattr_handlers = {
 	.value = xattr_copyvalue
 };
 
-static int inline_getxattr(struct erofs_inode *vi, struct erofs_xattr_iter *it)
-{
-	int ret;
-	unsigned int remaining;
-
-	ret = inline_xattr_iter_begin(it, vi);
-	if (ret < 0)
-		return ret;
-
-	remaining = ret;
-	while (remaining) {
-		ret = xattr_foreach(it, &find_xattr_handlers, &remaining);
-		if (ret != -ENOATTR)
-			break;
-	}
-
-	return ret ? ret : it->buffer_ofs;
-}
-
-static int shared_getxattr(struct erofs_inode *vi, struct erofs_xattr_iter *it)
-{
-	struct erofs_sb_info *sbi = vi->sbi;
-	int blkmask = erofs_blksiz(sbi) - 1;
-	unsigned int i;
-	int ret = -ENOATTR;
-
-	for (i = 0; i < vi->xattr_shared_count; ++i) {
-		it->pos = erofs_pos(sbi, sbi->xattr_blkaddr) +
-				vi->xattr_shared_xattrs[i] * sizeof(__le32);
-		it->kaddr = erofs_bread(&it->buf,
-				it->pos & ~blkmask, true);
-		if (IS_ERR(it->kaddr))
-			return PTR_ERR(it->kaddr);
-
-		ret = xattr_foreach(it, &find_xattr_handlers, NULL);
-		if (ret != -ENOATTR)
-			break;
-	}
-
-	return ret ? ret : it->buffer_ofs;
-}
-
-int erofs_getxattr(struct erofs_inode *vi, const char *name, char *buffer,
-		   size_t buffer_size)
-{
-	int ret;
-	unsigned int prefix, prefixlen;
-	struct erofs_xattr_iter it;
-
-	if (!name)
-		return -EINVAL;
-
-	ret = erofs_init_inode_xattrs(vi);
-	if (ret)
-		return ret;
-
-	if (!erofs_xattr_prefix_matches(name, &prefix, &prefixlen))
-		return -ENODATA;
-	it.index = prefix;
-	it.name = name + prefixlen;
-	it.len = strlen(it.name);
-	if (it.len > EROFS_NAME_LEN)
-		return -ERANGE;
-
-	it.sbi = vi->sbi;
-	it.buf = __EROFS_BUF_INITIALIZER;
-	erofs_init_metabuf(&it.buf, it.sbi, false);
-	it.buffer = buffer;
-	it.buffer_size = buffer_size;
-	it.buffer_ofs = 0;
-
-	ret = inline_getxattr(vi, &it);
-	if (ret == -ENOATTR)
-		ret = shared_getxattr(vi, &it);
-	erofs_put_metabuf(&it.buf);
-	return ret;
-}
-
 static int xattr_entrylist(struct erofs_xattr_iter *it,
 			   struct erofs_xattr_entry *entry)
 {
@@ -1527,33 +1426,46 @@ static const struct xattr_iter_handlers list_xattr_handlers = {
 	.value = NULL
 };
 
-static int inline_listxattr(struct erofs_xattr_iter *it)
+static int erofs_xattr_iter_inline(struct erofs_xattr_iter *it,
+				   struct erofs_inode *vi, bool getxattr)
 {
-	struct erofs_inode *vi = it->inode;
+	struct erofs_sb_info *sbi = vi->sbi;
+	const struct xattr_iter_handlers *op;
+	unsigned int xattr_header_sz, remaining;
 	int ret;
-	unsigned int remaining;
 
-	ret = inline_xattr_iter_begin(it, vi);
-	if (ret < 0)
-		return ret;
+	xattr_header_sz = sizeof(struct erofs_xattr_ibody_header) +
+			sizeof(u32) * vi->xattr_shared_count;
+	if (xattr_header_sz >= vi->xattr_isize) {
+		DBG_BUGON(xattr_header_sz > vi->xattr_isize);
+		return -ENOATTR;
+	}
 
-	remaining = ret;
+	it->pos = erofs_iloc(vi) + vi->inode_isize + xattr_header_sz;
+	it->kaddr = erofs_bread(&it->buf, it->pos & ~(erofs_blksiz(sbi) - 1),
+				true);
+	if (IS_ERR(it->kaddr))
+		return PTR_ERR(it->kaddr);
+
+	remaining = vi->xattr_isize - xattr_header_sz;
+	op = getxattr ? &find_xattr_handlers : &list_xattr_handlers;
 	while (remaining) {
-		ret = xattr_foreach(it, &list_xattr_handlers, &remaining);
-		if (ret)
+		ret = xattr_foreach(it, op, &remaining);
+		if ((getxattr && ret != -ENOATTR) || (!getxattr && ret))
 			break;
 	}
-
-	return ret ? ret : it->buffer_ofs;
+	return ret;
 }
 
-static int shared_listxattr(struct erofs_xattr_iter *it)
+static int erofs_xattr_iter_shared(struct erofs_xattr_iter *it,
+				   struct erofs_inode *vi, bool getxattr)
 {
-	struct erofs_inode *vi = it->inode;
 	struct erofs_sb_info *sbi = vi->sbi;
 	unsigned int i;
-	int ret = 0;
+	const struct xattr_iter_handlers *op;
+	int ret = -ENOATTR;
 
+	op = getxattr ? &find_xattr_handlers : &list_xattr_handlers;
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
 		it->pos = erofs_pos(sbi, sbi->xattr_blkaddr) +
 				vi->xattr_shared_xattrs[i] * sizeof(__le32);
@@ -1562,12 +1474,47 @@ static int shared_listxattr(struct erofs_xattr_iter *it)
 		if (IS_ERR(it->kaddr))
 			return PTR_ERR(it->kaddr);
 
-		ret = xattr_foreach(it, &list_xattr_handlers, NULL);
-		if (ret)
+		ret = xattr_foreach(it, op, NULL);
+		if ((getxattr && ret != -ENOATTR) || (!getxattr && ret))
 			break;
 	}
+	return ret;
+}
 
-	return ret ? ret : it->buffer_ofs;
+int erofs_getxattr(struct erofs_inode *vi, const char *name, char *buffer,
+		   size_t buffer_size)
+{
+	int ret;
+	unsigned int prefix, prefixlen;
+	struct erofs_xattr_iter it;
+
+	if (!name)
+		return -EINVAL;
+
+	ret = erofs_init_inode_xattrs(vi);
+	if (ret)
+		return ret;
+
+	if (!erofs_xattr_prefix_matches(name, &prefix, &prefixlen))
+		return -ENODATA;
+	it.index = prefix;
+	it.name = name + prefixlen;
+	it.len = strlen(it.name);
+	if (it.len > EROFS_NAME_LEN)
+		return -ERANGE;
+
+	it.sbi = vi->sbi;
+	it.buf = __EROFS_BUF_INITIALIZER;
+	erofs_init_metabuf(&it.buf, it.sbi, false);
+	it.buffer = buffer;
+	it.buffer_size = buffer_size;
+	it.buffer_ofs = 0;
+
+	ret = erofs_xattr_iter_inline(&it, vi, true);
+	if (ret == -ENOATTR)
+		ret = erofs_xattr_iter_shared(&it, vi, true);
+	erofs_put_metabuf(&it.buf);
+	return ret ? ret : it.buffer_ofs;
 }
 
 int erofs_listxattr(struct erofs_inode *vi, char *buffer, size_t buffer_size)
@@ -1584,16 +1531,17 @@ int erofs_listxattr(struct erofs_inode *vi, char *buffer, size_t buffer_size)
 	it.sbi = vi->sbi;
 	it.buf = __EROFS_BUF_INITIALIZER;
 	erofs_init_metabuf(&it.buf, it.sbi, false);
-	it.inode = vi;
 	it.buffer = buffer;
 	it.buffer_size = buffer_size;
 	it.buffer_ofs = 0;
 
-	ret = inline_listxattr(&it);
-	if (ret >= 0 || ret == -ENOATTR)
-		ret = shared_listxattr(&it);
+	ret = erofs_xattr_iter_inline(&it, vi, false);
+	if (!ret || ret == -ENOATTR)
+		ret = erofs_xattr_iter_shared(&it, vi, false);
+	if (ret == -ENOATTR)
+		ret = 0;
 	erofs_put_metabuf(&it.buf);
-	return ret;
+	return ret ? ret : it.buffer_ofs;
 }
 
 int erofs_xattr_insert_name_prefix(const char *prefix)
-- 
2.43.5


