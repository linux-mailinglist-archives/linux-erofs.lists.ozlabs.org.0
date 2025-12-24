Return-Path: <linux-erofs+bounces-1598-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C86CDD008
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Dec 2025 19:32:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dc0pK5ZMxz2yQH;
	Thu, 25 Dec 2025 05:31:53 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766601113;
	cv=none; b=SRfbozwVH6ZHfbaS3L0PRRrqJBMgAczyVHCCc7MnjGqiQNr0ZDnG7q4Z1U2GsZsp68WxZhmA0fmrI7cq9RuVsb3lbBVOEOsY5HhxQ2DWz/RW0mxn9T5DH9VEyxxWHaiBZX+sH9wWnZI/rka1AlW66ATgapWXp2jWsJkEwnJsYZw1ANYCCmXboxUIluLIg8OK0j95+jLRQ1uya+sAYjB3PvHPSfDq2bHucZuyko+AuetjqtzRyZBk6mqt6pXshJIGXPWmctOk2/51Zv1/f0o6TZfNGAPjvydckyIxglM+TnTcZAM5ihNYalSM/Fa29l0zWumoR7+ukgKf1dh+zr2lZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766601113; c=relaxed/relaxed;
	bh=hF3vK1up24p8jo0VHpC5g4Xv8xK0YdX8/Vn2CcZ0uuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCox7Vg0oMr+ZtokuN1okLWiY+422/z4HGZy1V8CsE81tuVQUJC45s7UVfLE6/AI2xIeWmSd0G7gWNA5ZOoT96bScYkKipEnu9Rnui3iHhQd4LZZhbR3KwQJe7ahKtM9t9J/L/SaykrBa1fVab1oZqM8JtPRDvWP2P41HKqITeUZkG5RaRChYyA35SNjMdx6ibuQG4u+swSBSUPAMKaft6H/Ql2pcdfMY0n6iY3iCcbzbQKpKLV5i+TdY6kECFs/UtIql13kvIJ0xW1HfvPN38fi+1VrXXh7neC6XzcLh1G2ktknximOScHnv+5Ul5QEVvb4NehDVz1VLnI0F2YeXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=u+gEKjyz; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=u+gEKjyz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dc0pJ4QyFz2yMv
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Dec 2025 05:31:52 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766601108; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=hF3vK1up24p8jo0VHpC5g4Xv8xK0YdX8/Vn2CcZ0uuM=;
	b=u+gEKjyzo2QxSnEVnD9EK7sainMeu38v+J/avoOdmxz7nwkNQWQzSbxfDKrMzeKdPD0CrU85dYb+92qh+1x9m0qpZbPEu5erTNlTFgdt//RWaaOv7rJazXijndLFszhh2eFqQ+HLqUXuwnqhAusB6CS3dlzE4yxqNB+7+2x1z9Y=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wvc814g_1766601106 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 25 Dec 2025 02:31:47 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 8/9] erofs-utils: lib: switch erofs_bread() to passing offset instead of block number
Date: Thu, 25 Dec 2025 02:31:30 +0800
Message-ID: <20251224183131.2302377-8-hsiangkao@linux.alibaba.com>
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

Source kernel commit: 469ad583c1293f5d9f45183050b3beeb4a8c3475

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/xattr.c | 37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/lib/xattr.c b/lib/xattr.c
index 5624311fdbba..6598845ed46d 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -1108,7 +1108,6 @@ struct erofs_xattr_iter {
 static int erofs_init_inode_xattrs(struct erofs_inode *vi)
 {
 	struct erofs_sb_info *sbi = vi->sbi;
-	int blkmask = erofs_blksiz(sbi) - 1;
 	struct erofs_xattr_iter it;
 	unsigned int i;
 	struct erofs_xattr_ibody_header *ih;
@@ -1144,12 +1143,11 @@ static int erofs_init_inode_xattrs(struct erofs_inode *vi)
 	it.pos = erofs_iloc(vi) + vi->inode_isize;
 
 	/* read in shared xattr array (non-atomic, see kmalloc below) */
-	it.kaddr = erofs_bread(&it.buf, it.pos & ~blkmask, true);
+	it.kaddr = erofs_bread(&it.buf, it.pos, true);
 	if (IS_ERR(it.kaddr))
 		return PTR_ERR(it.kaddr);
 
-	ih = it.kaddr + erofs_blkoff(sbi, it.pos);
-
+	ih = it.kaddr;
 	vi->xattr_shared_count = ih->h_shared_count;
 	vi->xattr_shared_xattrs = malloc(vi->xattr_shared_count * sizeof(uint));
 	if (!vi->xattr_shared_xattrs) {
@@ -1161,14 +1159,13 @@ static int erofs_init_inode_xattrs(struct erofs_inode *vi)
 	it.pos += sizeof(struct erofs_xattr_ibody_header);
 
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
-		it.kaddr = erofs_bread(&it.buf, it.pos & ~blkmask, true);
+		it.kaddr = erofs_bread(&it.buf, it.pos, true);
 		if (IS_ERR(it.kaddr)) {
 			free(vi->xattr_shared_xattrs);
 			vi->xattr_shared_xattrs = NULL;
 			return PTR_ERR(it.kaddr);
 		}
-		vi->xattr_shared_xattrs[i] = le32_to_cpu(*(__le32 *)
-			(it.kaddr + erofs_blkoff(sbi, it.pos)));
+		vi->xattr_shared_xattrs[i] = le32_to_cpu(*(__le32 *)it.kaddr);
 		it.pos += sizeof(__le32);
 	}
 	erofs_put_metabuf(&it.buf);
@@ -1181,15 +1178,14 @@ static int erofs_xattr_copy_to_buffer(struct erofs_xattr_iter *it,
 {
 	unsigned int slice, processed;
 	struct erofs_sb_info *sbi = it->sbi;
-	int blkmask = erofs_blksiz(sbi) - 1;
 	void *src;
 
 	for (processed = 0; processed < len; processed += slice) {
-		it->kaddr = erofs_bread(&it->buf, it->pos & ~blkmask, true);
+		it->kaddr = erofs_bread(&it->buf, it->pos, true);
 		if (IS_ERR(it->kaddr))
 			return PTR_ERR(it->kaddr);
 
-		src = it->kaddr + erofs_blkoff(sbi, it->pos);
+		src = it->kaddr;
 		slice = min_t(unsigned int, erofs_blksiz(sbi) -
 				erofs_blkoff(sbi, it->pos), len - processed);
 		memcpy(it->buffer + it->buffer_ofs, src, slice);
@@ -1207,8 +1203,7 @@ static int erofs_listxattr_foreach(struct erofs_xattr_iter *it)
 	int err;
 
 	/* 1. handle xattr entry */
-	entry = *(struct erofs_xattr_entry *)
-		(it->kaddr + erofs_blkoff(it->sbi, it->pos));
+	entry = *(struct erofs_xattr_entry *)it->kaddr;
 	it->pos += sizeof(struct erofs_xattr_entry);
 
 	base_index = entry.e_name_index;
@@ -1254,13 +1249,11 @@ static int erofs_listxattr_foreach(struct erofs_xattr_iter *it)
 static int erofs_getxattr_foreach(struct erofs_xattr_iter *it)
 {
 	struct erofs_sb_info *sbi = it->sbi;
-	int blkmask = erofs_blksiz(sbi) - 1;
 	struct erofs_xattr_entry entry;
 	unsigned int slice, processed, value_sz;
 
 	/* 1. handle xattr entry */
-	entry = *(struct erofs_xattr_entry *)
-		(it->kaddr + erofs_blkoff(sbi, it->pos));
+	entry = *(struct erofs_xattr_entry *)it->kaddr;
 	it->pos += sizeof(struct erofs_xattr_entry);
 	value_sz = le16_to_cpu(entry.e_value_size);
 
@@ -1290,7 +1283,7 @@ static int erofs_getxattr_foreach(struct erofs_xattr_iter *it)
 
 	/* 2. handle xattr name */
 	for (processed = 0; processed < entry.e_name_len; processed += slice) {
-		it->kaddr = erofs_bread(&it->buf, it->pos & ~blkmask, true);
+		it->kaddr = erofs_bread(&it->buf, it->pos, true);
 		if (IS_ERR(it->kaddr))
 			return PTR_ERR(it->kaddr);
 
@@ -1298,7 +1291,7 @@ static int erofs_getxattr_foreach(struct erofs_xattr_iter *it)
 			      erofs_blksiz(sbi) - erofs_blkoff(sbi, it->pos),
 			      entry.e_name_len - processed);
 		if (memcmp(it->name + it->infix_len + processed,
-			   it->kaddr + erofs_blkoff(sbi, it->pos), slice))
+			   it->kaddr, slice))
 			return -ENOATTR;
 		it->pos += slice;
 	}
@@ -1318,8 +1311,6 @@ static int erofs_getxattr_foreach(struct erofs_xattr_iter *it)
 static int erofs_xattr_iter_inline(struct erofs_xattr_iter *it,
 				   struct erofs_inode *vi, bool getxattr)
 {
-	struct erofs_sb_info *sbi = vi->sbi;
-	int blkmask = erofs_blksiz(sbi) - 1;
 	unsigned int xattr_header_sz, remaining, entry_sz;
 	erofs_off_t next_pos;
 	int ret;
@@ -1334,12 +1325,11 @@ static int erofs_xattr_iter_inline(struct erofs_xattr_iter *it,
 	remaining = vi->xattr_isize - xattr_header_sz;
 	it->pos = erofs_iloc(vi) + vi->inode_isize + xattr_header_sz;
 	while (remaining) {
-		it->kaddr = erofs_bread(&it->buf, it->pos & ~blkmask, true);
+		it->kaddr = erofs_bread(&it->buf, it->pos, true);
 		if (IS_ERR(it->kaddr))
 			return PTR_ERR(it->kaddr);
 
-		entry_sz = erofs_xattr_entry_size(it->kaddr +
-				erofs_blkoff(it->sbi, it->pos));
+		entry_sz = erofs_xattr_entry_size(it->kaddr);
 		/* xattr on-disk corruption: xattr entry beyond xattr_isize */
 		if (remaining < entry_sz) {
 			DBG_BUGON(1);
@@ -1370,8 +1360,7 @@ static int erofs_xattr_iter_shared(struct erofs_xattr_iter *it,
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
 		it->pos = erofs_pos(sbi, sbi->xattr_blkaddr) +
 				vi->xattr_shared_xattrs[i] * sizeof(__le32);
-		it->kaddr = erofs_bread(&it->buf,
-				it->pos & ~(erofs_blksiz(sbi) - 1), true);
+		it->kaddr = erofs_bread(&it->buf, it->pos, true);
 		if (IS_ERR(it->kaddr))
 			return PTR_ERR(it->kaddr);
 
-- 
2.43.5


