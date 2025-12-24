Return-Path: <linux-erofs+bounces-1593-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C8BCDCFF9
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Dec 2025 19:31:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dc0pG4N8Kz2yPq;
	Thu, 25 Dec 2025 05:31:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766601110;
	cv=none; b=RHNvOupPnn5dpWJvUvDFIFLljdAPpo3p+JQv3j8eR2g3G2umOqCh4H2ToG8eABmMJ4HSyKX3C3/0QN/YPPjAwh3hNdg9Z7cu/I+eEnt7o1TAiTTBMHJWexwTltUHsEEFmePCTV4Dmq+PXhkSrhdmmnhL5d87tNQyfUOMewQ1cnqyn3e0OOTtOptsUNmC9aoW1CeWg+VxelmP63vHZLoP9kaUWxYMU6GZeEVdQEuFMJ7WFsbjYc/9JxclKd4F5R2IjqA9hnNiAZj/ZL1YbNIcOBoVcdSOf3X8wELCx86/xnsfGaIUQpxGtVHBi3RH+3o5NAXd3n+/Q+nQreTNGGstsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766601110; c=relaxed/relaxed;
	bh=N9ZBHWDJKXl3LNF3lnI1g91PUoMOJLx1tsqmYlM/c2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8r+evyXWu0EkGuWCiEBl8wlm6tiDau40S+KW5xEytK1N9yJbbti21Itjom69x3DfnkHtHa6gPNe1WBm4hELdBUvWy4pNXZ4G2IKTYB1SsaYpMhpMw+ugT+KAOuq+vDY0UNPOWLTiCsJlAbPsOVY6xNGSaQ4bFeTe0gfcnLWYBgibTj/vycdsnjHNXzz1gwHeBU7h5ozc6Ixxdea/HL/8Jm11QD14+R7YwN3KLcyCUX5UnXkg1RHIrhfbbNfaePSwDGdt//dGGhkxglG5Ktz68YKn+K+LI8dig6h6RcLEedWBqNCLiTDscchrSGLdgAFpGLlUcq8Pkt0XeVNXKpj3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RzKXQXm9; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RzKXQXm9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dc0pC5KzKz2yQH
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Dec 2025 05:31:47 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766601103; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=N9ZBHWDJKXl3LNF3lnI1g91PUoMOJLx1tsqmYlM/c2E=;
	b=RzKXQXm9x8hA3KXcW2+anVn8HLl04SvEXQ9o6gHF3MAYcp//XtON/wRjkeotoZB4IEq6iQWLsfHUPPgy3VBDpdVF3Le4ZoNVYcOn6vgM9nN1QQUzrCTCvomjyx4tpq2p9Z+rqJ61Kql/ebsgMdK0evZLaHfiZJh64JCvjKCb6Qk=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wvc813L_1766601102 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 25 Dec 2025 02:31:43 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 4/9] erofs-utils: lib: unify xattr_iter structures
Date: Thu, 25 Dec 2025 02:31:26 +0800
Message-ID: <20251224183131.2302377-4-hsiangkao@linux.alibaba.com>
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

Source kernel commit: 8e823961de5a3b502f47a5461954024cc1433147

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/xattr.c | 146 +++++++++++++++++++++++-----------------------------
 1 file changed, 65 insertions(+), 81 deletions(-)

diff --git a/lib/xattr.c b/lib/xattr.c
index b5582bb0ca95..4981944ff965 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -1090,18 +1090,29 @@ char *erofs_export_xattr_ibody(struct erofs_inode *inode)
 	return buf;
 }
 
-struct xattr_iter {
+struct erofs_xattr_iter {
 	struct erofs_sb_info *sbi;
 	struct erofs_buf buf;
 	erofs_off_t pos;
 	void *kaddr;
+
+	char *buffer;
+	int buffer_size, buffer_ofs;
+
+	/* getxattr */
+	int index, infix_len;
+	const char *name;
+	size_t len;
+
+	/* listxattr */
+	struct erofs_inode *inode;
 };
 
 static int erofs_init_inode_xattrs(struct erofs_inode *vi)
 {
 	struct erofs_sb_info *sbi = vi->sbi;
 	int blkmask = erofs_blksiz(sbi) - 1;
-	struct xattr_iter it;
+	struct erofs_xattr_iter it;
 	unsigned int i;
 	struct erofs_xattr_ibody_header *ih;
 	int ret = 0;
@@ -1176,15 +1187,15 @@ static int erofs_init_inode_xattrs(struct erofs_inode *vi)
  *                            and need to be handled
  */
 struct xattr_iter_handlers {
-	int (*entry)(struct xattr_iter *_it, struct erofs_xattr_entry *entry);
-	int (*name)(struct xattr_iter *_it, unsigned int processed, char *buf,
+	int (*entry)(struct erofs_xattr_iter *it, struct erofs_xattr_entry *entry);
+	int (*name)(struct erofs_xattr_iter *it, unsigned int processed, char *buf,
 		    unsigned int len);
-	int (*alloc_buffer)(struct xattr_iter *_it, unsigned int value_sz);
-	void (*value)(struct xattr_iter *_it, unsigned int processed, char *buf,
+	int (*alloc_buffer)(struct erofs_xattr_iter *it, unsigned int value_sz);
+	void (*value)(struct erofs_xattr_iter *it, unsigned int processed, char *buf,
 		      unsigned int len);
 };
 
-static int inline_xattr_iter_begin(struct xattr_iter *it,
+static int inline_xattr_iter_begin(struct erofs_xattr_iter *it,
 				   struct erofs_inode *vi)
 {
 	struct erofs_sb_info *sbi = vi->sbi;
@@ -1208,7 +1219,7 @@ static int inline_xattr_iter_begin(struct xattr_iter *it,
  * Regardless of success or failure, `xattr_foreach' will end up with
  * `pos' pointing to the next xattr item rather than an arbitrary position.
  */
-static int xattr_foreach(struct xattr_iter *it,
+static int xattr_foreach(struct erofs_xattr_iter *it,
 			 const struct xattr_iter_handlers *op,
 			 unsigned int *tlimit)
 {
@@ -1310,19 +1321,10 @@ out:
 	return err < 0 ? err : 0;
 }
 
-struct getxattr_iter {
-	struct xattr_iter it;
-
-	int buffer_size, index, infix_len;
-	char *buffer;
-	const char *name;
-	size_t len;
-};
-
-static int erofs_xattr_long_entrymatch(struct getxattr_iter *it,
+static int erofs_xattr_long_entrymatch(struct erofs_xattr_iter *it,
 				       struct erofs_xattr_entry *entry)
 {
-	struct erofs_sb_info *sbi = it->it.sbi;
+	struct erofs_sb_info *sbi = it->sbi;
 	struct erofs_xattr_prefix_item *pf = sbi->xattr_prefixes +
 		(entry->e_name_index & EROFS_XATTR_LONG_PREFIX_MASK);
 
@@ -1340,11 +1342,9 @@ static int erofs_xattr_long_entrymatch(struct getxattr_iter *it,
 	return 0;
 }
 
-static int xattr_entrymatch(struct xattr_iter *_it,
+static int xattr_entrymatch(struct erofs_xattr_iter *it,
 			    struct erofs_xattr_entry *entry)
 {
-	struct getxattr_iter *it = container_of(_it, struct getxattr_iter, it);
-
 	/* should also match the infix for long name prefixes */
 	if (entry->e_name_index & EROFS_XATTR_LONG_PREFIX)
 		return erofs_xattr_long_entrymatch(it, entry);
@@ -1356,32 +1356,27 @@ static int xattr_entrymatch(struct xattr_iter *_it,
 	return 0;
 }
 
-static int xattr_namematch(struct xattr_iter *_it,
+static int xattr_namematch(struct erofs_xattr_iter *it,
 			   unsigned int processed, char *buf, unsigned int len)
 {
-	struct getxattr_iter *it = container_of(_it, struct getxattr_iter, it);
-
 	if (memcmp(buf, it->name + it->infix_len + processed, len))
 		return -ENOATTR;
 	return 0;
 }
 
-static int xattr_checkbuffer(struct xattr_iter *_it,
+static int xattr_checkbuffer(struct erofs_xattr_iter *it,
 			     unsigned int value_sz)
 {
-	struct getxattr_iter *it = container_of(_it, struct getxattr_iter, it);
 	int err = it->buffer_size < value_sz ? -ERANGE : 0;
 
 	it->buffer_size = value_sz;
 	return !it->buffer ? 1 : err;
 }
 
-static void xattr_copyvalue(struct xattr_iter *_it,
+static void xattr_copyvalue(struct erofs_xattr_iter *it,
 			    unsigned int processed,
 			    char *buf, unsigned int len)
 {
-	struct getxattr_iter *it = container_of(_it, struct getxattr_iter, it);
-
 	memcpy(it->buffer + processed, buf, len);
 }
 
@@ -1392,18 +1387,18 @@ static const struct xattr_iter_handlers find_xattr_handlers = {
 	.value = xattr_copyvalue
 };
 
-static int inline_getxattr(struct erofs_inode *vi, struct getxattr_iter *it)
+static int inline_getxattr(struct erofs_inode *vi, struct erofs_xattr_iter *it)
 {
 	int ret;
 	unsigned int remaining;
 
-	ret = inline_xattr_iter_begin(&it->it, vi);
+	ret = inline_xattr_iter_begin(it, vi);
 	if (ret < 0)
 		return ret;
 
 	remaining = ret;
 	while (remaining) {
-		ret = xattr_foreach(&it->it, &find_xattr_handlers, &remaining);
+		ret = xattr_foreach(it, &find_xattr_handlers, &remaining);
 		if (ret != -ENOATTR)
 			break;
 	}
@@ -1411,7 +1406,7 @@ static int inline_getxattr(struct erofs_inode *vi, struct getxattr_iter *it)
 	return ret ? ret : it->buffer_size;
 }
 
-static int shared_getxattr(struct erofs_inode *vi, struct getxattr_iter *it)
+static int shared_getxattr(struct erofs_inode *vi, struct erofs_xattr_iter *it)
 {
 	struct erofs_sb_info *sbi = vi->sbi;
 	int blkmask = erofs_blksiz(sbi) - 1;
@@ -1419,14 +1414,14 @@ static int shared_getxattr(struct erofs_inode *vi, struct getxattr_iter *it)
 	int ret = -ENOATTR;
 
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
-		it->it.pos = erofs_pos(sbi, sbi->xattr_blkaddr) +
+		it->pos = erofs_pos(sbi, sbi->xattr_blkaddr) +
 				vi->xattr_shared_xattrs[i] * sizeof(__le32);
-		it->it.kaddr = erofs_bread(&it->it.buf,
-				it->it.pos & ~blkmask, true);
-		if (IS_ERR(it->it.kaddr))
-			return PTR_ERR(it->it.kaddr);
+		it->kaddr = erofs_bread(&it->buf,
+				it->pos & ~blkmask, true);
+		if (IS_ERR(it->kaddr))
+			return PTR_ERR(it->kaddr);
 
-		ret = xattr_foreach(&it->it, &find_xattr_handlers, NULL);
+		ret = xattr_foreach(it, &find_xattr_handlers, NULL);
 		if (ret != -ENOATTR)
 			break;
 	}
@@ -1439,7 +1434,7 @@ int erofs_getxattr(struct erofs_inode *vi, const char *name, char *buffer,
 {
 	int ret;
 	unsigned int prefix, prefixlen;
-	struct getxattr_iter it;
+	struct erofs_xattr_iter it;
 
 	if (!name)
 		return -EINVAL;
@@ -1456,37 +1451,29 @@ int erofs_getxattr(struct erofs_inode *vi, const char *name, char *buffer,
 	if (it.len > EROFS_NAME_LEN)
 		return -ERANGE;
 
-	it.it.sbi = vi->sbi;
-	it.it.buf = __EROFS_BUF_INITIALIZER;
-	erofs_init_metabuf(&it.it.buf, it.it.sbi, false);
+	it.sbi = vi->sbi;
+	it.buf = __EROFS_BUF_INITIALIZER;
+	erofs_init_metabuf(&it.buf, it.sbi, false);
 	it.buffer = buffer;
 	it.buffer_size = buffer_size;
+	it.buffer_ofs = 0;
 
 	ret = inline_getxattr(vi, &it);
 	if (ret == -ENOATTR)
 		ret = shared_getxattr(vi, &it);
-	erofs_put_metabuf(&it.it.buf);
+	erofs_put_metabuf(&it.buf);
 	return ret;
 }
 
-struct listxattr_iter {
-	struct xattr_iter it;
-
-	char *buffer;
-	int buffer_size, buffer_ofs;
-};
-
-static int xattr_entrylist(struct xattr_iter *_it,
+static int xattr_entrylist(struct erofs_xattr_iter *it,
 			   struct erofs_xattr_entry *entry)
 {
-	struct listxattr_iter *it =
-		container_of(_it, struct listxattr_iter, it);
 	unsigned int base_index = entry->e_name_index;
 	unsigned int prefix_len, infix_len = 0;
 	const char *prefix, *infix = NULL;
 
 	if (entry->e_name_index & EROFS_XATTR_LONG_PREFIX) {
-		struct erofs_sb_info *sbi = _it->sbi;
+		struct erofs_sb_info *sbi = it->sbi;
 		struct erofs_xattr_prefix_item *pf = sbi->xattr_prefixes +
 			(entry->e_name_index & EROFS_XATTR_LONG_PREFIX_MASK);
 
@@ -1518,23 +1505,17 @@ static int xattr_entrylist(struct xattr_iter *_it,
 	return 0;
 }
 
-static int xattr_namelist(struct xattr_iter *_it,
+static int xattr_namelist(struct erofs_xattr_iter *it,
 			  unsigned int processed, char *buf, unsigned int len)
 {
-	struct listxattr_iter *it =
-		container_of(_it, struct listxattr_iter, it);
-
 	memcpy(it->buffer + it->buffer_ofs, buf, len);
 	it->buffer_ofs += len;
 	return 0;
 }
 
-static int xattr_skipvalue(struct xattr_iter *_it,
+static int xattr_skipvalue(struct erofs_xattr_iter *it,
 			   unsigned int value_sz)
 {
-	struct listxattr_iter *it =
-		container_of(_it, struct listxattr_iter, it);
-
 	it->buffer[it->buffer_ofs++] = '\0';
 	return 1;
 }
@@ -1546,18 +1527,19 @@ static const struct xattr_iter_handlers list_xattr_handlers = {
 	.value = NULL
 };
 
-static int inline_listxattr(struct erofs_inode *vi, struct listxattr_iter *it)
+static int inline_listxattr(struct erofs_xattr_iter *it)
 {
+	struct erofs_inode *vi = it->inode;
 	int ret;
 	unsigned int remaining;
 
-	ret = inline_xattr_iter_begin(&it->it, vi);
+	ret = inline_xattr_iter_begin(it, vi);
 	if (ret < 0)
 		return ret;
 
 	remaining = ret;
 	while (remaining) {
-		ret = xattr_foreach(&it->it, &list_xattr_handlers, &remaining);
+		ret = xattr_foreach(it, &list_xattr_handlers, &remaining);
 		if (ret)
 			break;
 	}
@@ -1565,21 +1547,22 @@ static int inline_listxattr(struct erofs_inode *vi, struct listxattr_iter *it)
 	return ret ? ret : it->buffer_ofs;
 }
 
-static int shared_listxattr(struct erofs_inode *vi, struct listxattr_iter *it)
+static int shared_listxattr(struct erofs_xattr_iter *it)
 {
+	struct erofs_inode *vi = it->inode;
 	struct erofs_sb_info *sbi = vi->sbi;
 	unsigned int i;
 	int ret = 0;
 
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
-		it->it.pos = erofs_pos(sbi, sbi->xattr_blkaddr) +
+		it->pos = erofs_pos(sbi, sbi->xattr_blkaddr) +
 				vi->xattr_shared_xattrs[i] * sizeof(__le32);
-		it->it.kaddr = erofs_bread(&it->it.buf,
-				it->it.pos & ~(erofs_blksiz(sbi) - 1), true);
-		if (IS_ERR(it->it.kaddr))
-			return PTR_ERR(it->it.kaddr);
+		it->kaddr = erofs_bread(&it->buf,
+				it->pos & ~(erofs_blksiz(sbi) - 1), true);
+		if (IS_ERR(it->kaddr))
+			return PTR_ERR(it->kaddr);
 
-		ret = xattr_foreach(&it->it, &list_xattr_handlers, NULL);
+		ret = xattr_foreach(it, &list_xattr_handlers, NULL);
 		if (ret)
 			break;
 	}
@@ -1590,7 +1573,7 @@ static int shared_listxattr(struct erofs_inode *vi, struct listxattr_iter *it)
 int erofs_listxattr(struct erofs_inode *vi, char *buffer, size_t buffer_size)
 {
 	int ret;
-	struct listxattr_iter it;
+	struct erofs_xattr_iter it;
 
 	ret = erofs_init_inode_xattrs(vi);
 	if (ret == -ENOATTR)
@@ -1598,17 +1581,18 @@ int erofs_listxattr(struct erofs_inode *vi, char *buffer, size_t buffer_size)
 	if (ret)
 		return ret;
 
-	it.it.sbi = vi->sbi;
-	it.it.buf = __EROFS_BUF_INITIALIZER;
-	erofs_init_metabuf(&it.it.buf, it.it.sbi, false);
+	it.sbi = vi->sbi;
+	it.buf = __EROFS_BUF_INITIALIZER;
+	erofs_init_metabuf(&it.buf, it.sbi, false);
+	it.inode = vi;
 	it.buffer = buffer;
 	it.buffer_size = buffer_size;
 	it.buffer_ofs = 0;
 
-	ret = inline_listxattr(vi, &it);
+	ret = inline_listxattr(&it);
 	if (ret >= 0 || ret == -ENOATTR)
-		ret = shared_listxattr(vi, &it);
-	erofs_put_metabuf(&it.it.buf);
+		ret = shared_listxattr(&it);
+	erofs_put_metabuf(&it.buf);
 	return ret;
 }
 
-- 
2.43.5


