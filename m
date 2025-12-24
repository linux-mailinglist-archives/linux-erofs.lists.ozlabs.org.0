Return-Path: <linux-erofs+bounces-1594-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5301BCDCFFC
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Dec 2025 19:31:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dc0pJ1Rcvz2ySb;
	Thu, 25 Dec 2025 05:31:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766601112;
	cv=none; b=kmRbB+vC2WWYDjr8o/vYsnxwnGUSCbKrj8/GGXTZRqNkiW2bk+i9dkxezwa/HVf5nUxthYJyeRM+KAilgAbO5FudEOuaw4d/JE2/NRbUruFG5hxRaJKJ/SDQquiJzcYvrgc08lS08XsT3wRvbbpnBic6v0r9TuPEz3perh939/BYn6C+/qdoeiwL0oSdE5WRa9M8r9Lzu7tQg13eOEDez7DejsZzg8zBC54Vl+tEkPvv9/yFB/RU7jMNaEFrKx2l2stBmstnmdjZ1wE5H1hB4MjlC1KLSM4tOeyQb29F3V7kGU+PfO9fMZCsT+nJcVlmvjODBddoOL6JK78/XyR11g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766601112; c=relaxed/relaxed;
	bh=KzVDE9qUN0vV+Akr+VSgk90Xg7Vcx7CcgavdaDO84Gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ky/TNChI1FSV2Y8jm24Q35EUmyQn+UbB/7HQE/z4XvMr4mLpD/G0j9BQ/PxR1LjjyJmHpuvwWfMjSHCu7ODVIsCmDs9hPw6ggLlPb/wdzT8w2/zGHPNIuxqOwSkbbOGmH1wLUx1ef2ncl7obhF8zVazaiHR2+dl00h0j5F5iv0LhfqKwFWPbLKUKHeBWEErMiWLUjntAMI9qtrLIo4tfC7X+5y+/aSpNf0VuXaoFpxK9W8+5iciTv+JAHujJT/PKdWnk81TCL/zSU7DM9+42+/LqyLk1nGXTnGM/6uiPxQEABhmstoM8XCiy+xI6xQKPAE2ph8/URQgEdS1ESHD56A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MXV0dTtV; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MXV0dTtV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dc0pC2VWXz2yMv
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Dec 2025 05:31:46 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766601102; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=KzVDE9qUN0vV+Akr+VSgk90Xg7Vcx7CcgavdaDO84Gg=;
	b=MXV0dTtVCTUN6S12tTLpRJvmzmACEDNNHVBxGl8UonXVWEtkWu1dEEF/cpjIrANnhknMgYh4zEIUNOXAGq+y9Tgvm3YT9OtkLZFLgA11tzNVvArE0Nl4Yv3OPJH3NWshKyv6FuQawAPo9amh4K7V4TjCqU/ZQkypdJzljryiMP4=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wvc812k_1766601099 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 25 Dec 2025 02:31:40 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/9] erofs-utils: lib: convert erofs_read_metabuf() to erofs_bread() for xattr
Date: Thu, 25 Dec 2025 02:31:24 +0800
Message-ID: <20251224183131.2302377-2-hsiangkao@linux.alibaba.com>
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

Source kernel commit: 9c39ec0cff4e9373ab238120ca45a50c703dbb4e

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/xattr.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/lib/xattr.c b/lib/xattr.c
index 4ef27d446bb8..9e329ff77bf8 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -1099,7 +1099,7 @@ struct xattr_iter {
 	unsigned int ofs;
 };
 
-static int init_inode_xattrs(struct erofs_inode *vi)
+static int erofs_init_inode_xattrs(struct erofs_inode *vi)
 {
 	struct erofs_sb_info *sbi = vi->sbi;
 	struct xattr_iter it;
@@ -1133,11 +1133,12 @@ static int init_inode_xattrs(struct erofs_inode *vi)
 	}
 
 	it.buf = __EROFS_BUF_INITIALIZER;
+	erofs_init_metabuf(&it.buf, sbi, false);
 	it.blkaddr = erofs_blknr(sbi, erofs_iloc(vi) + vi->inode_isize);
 	it.ofs = erofs_blkoff(sbi, erofs_iloc(vi) + vi->inode_isize);
 
 	/* read in shared xattr array (non-atomic, see kmalloc below) */
-	it.kaddr = erofs_read_metabuf(&it.buf, sbi, erofs_pos(sbi, it.blkaddr), false);
+	it.kaddr = erofs_bread(&it.buf, erofs_pos(sbi, it.blkaddr), true);
 	if (IS_ERR(it.kaddr))
 		return PTR_ERR(it.kaddr);
 
@@ -1158,8 +1159,8 @@ static int init_inode_xattrs(struct erofs_inode *vi)
 			/* cannot be unaligned */
 			DBG_BUGON(it.ofs != erofs_blksiz(sbi));
 
-			it.kaddr = erofs_read_metabuf(&it.buf, sbi,
-					erofs_pos(sbi, ++it.blkaddr), false);
+			it.kaddr = erofs_bread(&it.buf,
+					erofs_pos(sbi, ++it.blkaddr), true);
 			if (IS_ERR(it.kaddr)) {
 				free(vi->xattr_shared_xattrs);
 				vi->xattr_shared_xattrs = NULL;
@@ -1200,8 +1201,7 @@ static inline int xattr_iter_fixup(struct xattr_iter *it)
 		return 0;
 
 	it->blkaddr += erofs_blknr(sbi, it->ofs);
-	it->kaddr = erofs_read_metabuf(&it->buf, sbi,
-				       erofs_pos(sbi, it->blkaddr), false);
+	it->kaddr = erofs_bread(&it->buf, erofs_pos(sbi, it->blkaddr), true);
 	if (IS_ERR(it->kaddr))
 		return PTR_ERR(it->kaddr);
 	it->ofs = erofs_blkoff(sbi, it->ofs);
@@ -1225,8 +1225,7 @@ static int inline_xattr_iter_begin(struct xattr_iter *it,
 	it->blkaddr = erofs_blknr(sbi, erofs_iloc(vi) + inline_xattr_ofs);
 	it->ofs = erofs_blkoff(sbi, erofs_iloc(vi) + inline_xattr_ofs);
 
-	it->kaddr = erofs_read_metabuf(&it->buf, sbi,
-				       erofs_pos(sbi, it->blkaddr), false);
+	it->kaddr = erofs_bread(&it->buf, erofs_pos(sbi, it->blkaddr), true);
 	if (IS_ERR(it->kaddr))
 		return PTR_ERR(it->kaddr);
 	return vi->xattr_isize - xattr_header_sz;
@@ -1450,8 +1449,8 @@ static int shared_getxattr(struct erofs_inode *vi, struct getxattr_iter *it)
 			xattrblock_addr(vi, vi->xattr_shared_xattrs[i]);
 
 		it->it.ofs = xattrblock_offset(vi, vi->xattr_shared_xattrs[i]);
-		it->it.kaddr = erofs_read_metabuf(&it->it.buf, sbi,
-						  erofs_pos(sbi, blkaddr), false);
+		it->it.kaddr = erofs_bread(&it->it.buf,
+					   erofs_pos(sbi, blkaddr), true);
 		if (IS_ERR(it->it.kaddr))
 			return PTR_ERR(it->it.kaddr);
 		it->it.blkaddr = blkaddr;
@@ -1474,20 +1473,21 @@ int erofs_getxattr(struct erofs_inode *vi, const char *name, char *buffer,
 	if (!name)
 		return -EINVAL;
 
-	ret = init_inode_xattrs(vi);
+	ret = erofs_init_inode_xattrs(vi);
 	if (ret)
 		return ret;
 
 	if (!erofs_xattr_prefix_matches(name, &prefix, &prefixlen))
 		return -ENODATA;
-	it.it.sbi = vi->sbi;
 	it.index = prefix;
 	it.name = name + prefixlen;
 	it.len = strlen(it.name);
 	if (it.len > EROFS_NAME_LEN)
 		return -ERANGE;
 
+	it.it.sbi = vi->sbi;
 	it.it.buf = __EROFS_BUF_INITIALIZER;
+	erofs_init_metabuf(&it.it.buf, it.it.sbi, false);
 	it.buffer = buffer;
 	it.buffer_size = buffer_size;
 
@@ -1605,8 +1605,8 @@ static int shared_listxattr(struct erofs_inode *vi, struct listxattr_iter *it)
 			xattrblock_addr(vi, vi->xattr_shared_xattrs[i]);
 
 		it->it.ofs = xattrblock_offset(vi, vi->xattr_shared_xattrs[i]);
-		it->it.kaddr = erofs_read_metabuf(&it->it.buf, sbi,
-						  erofs_pos(sbi, blkaddr), false);
+		it->it.kaddr = erofs_bread(&it->it.buf,
+					   erofs_pos(sbi, blkaddr), true);
 		if (IS_ERR(it->it.kaddr))
 			return PTR_ERR(it->it.kaddr);
 		it->it.blkaddr = blkaddr;
@@ -1624,7 +1624,7 @@ int erofs_listxattr(struct erofs_inode *vi, char *buffer, size_t buffer_size)
 	int ret;
 	struct listxattr_iter it;
 
-	ret = init_inode_xattrs(vi);
+	ret = erofs_init_inode_xattrs(vi);
 	if (ret == -ENOATTR)
 		return 0;
 	if (ret)
@@ -1632,6 +1632,7 @@ int erofs_listxattr(struct erofs_inode *vi, char *buffer, size_t buffer_size)
 
 	it.it.sbi = vi->sbi;
 	it.it.buf = __EROFS_BUF_INITIALIZER;
+	erofs_init_metabuf(&it.it.buf, it.it.sbi, false);
 	it.buffer = buffer;
 	it.buffer_size = buffer_size;
 	it.buffer_ofs = 0;
-- 
2.43.5


