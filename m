Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2335670782B
	for <lists+linux-erofs@lfdr.de>; Thu, 18 May 2023 04:46:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QMDr10g9gz3fD9
	for <lists+linux-erofs@lfdr.de>; Thu, 18 May 2023 12:46:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QMDqp6yS5z3f6B
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 May 2023 12:45:58 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0ViutgWP_1684377952;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0ViutgWP_1684377952)
          by smtp.aliyun-inc.com;
          Thu, 18 May 2023 10:45:53 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 1/5] erofs: introduce erofs_xattr_iter_fixup_aligned() helper
Date: Thu, 18 May 2023 10:45:47 +0800
Message-Id: <20230518024551.123990-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230518024551.123990-1-jefflexu@linux.alibaba.com>
References: <20230518024551.123990-1-jefflexu@linux.alibaba.com>
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

Introduce erofs_xattr_iter_fixup_aligned() helper where
it.ofs <= EROFS_BLKSIZ is mandatory.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/xattr.c | 79 +++++++++++++++++++++---------------------------
 1 file changed, 35 insertions(+), 44 deletions(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index bbfe7ce170d2..b79be2a556ba 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -29,6 +29,28 @@ struct xattr_iter {
 	unsigned int ofs;
 };
 
+static inline int erofs_xattr_iter_fixup(struct xattr_iter *it)
+{
+	if (it->ofs < it->sb->s_blocksize)
+		return 0;
+
+	it->blkaddr += erofs_blknr(it->sb, it->ofs);
+	it->kaddr = erofs_read_metabuf(&it->buf, it->sb, it->blkaddr, EROFS_KMAP);
+	if (IS_ERR(it->kaddr))
+		return PTR_ERR(it->kaddr);
+	it->ofs = erofs_blkoff(it->sb, it->ofs);
+	return 0;
+}
+
+static inline int erofs_xattr_iter_fixup_aligned(struct xattr_iter *it)
+{
+	if (it->ofs > it->sb->s_blocksize) {
+		DBG_BUGON(1);
+		return -EFSCORRUPTED;
+	}
+	return erofs_xattr_iter_fixup(it);
+}
+
 static int erofs_init_inode_xattrs(struct inode *inode)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
@@ -80,6 +102,7 @@ static int erofs_init_inode_xattrs(struct inode *inode)
 		goto out_unlock;
 	}
 
+	it.sb = sb;
 	it.buf = __EROFS_BUF_INITIALIZER;
 	it.blkaddr = erofs_blknr(sb, erofs_iloc(inode) + vi->inode_isize);
 	it.ofs = erofs_blkoff(sb, erofs_iloc(inode) + vi->inode_isize);
@@ -105,19 +128,11 @@ static int erofs_init_inode_xattrs(struct inode *inode)
 	it.ofs += sizeof(struct erofs_xattr_ibody_header);
 
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
-		if (it.ofs >= sb->s_blocksize) {
-			/* cannot be unaligned */
-			DBG_BUGON(it.ofs != sb->s_blocksize);
-
-			it.kaddr = erofs_read_metabuf(&it.buf, sb, ++it.blkaddr,
-						      EROFS_KMAP);
-			if (IS_ERR(it.kaddr)) {
-				kfree(vi->xattr_shared_xattrs);
-				vi->xattr_shared_xattrs = NULL;
-				ret = PTR_ERR(it.kaddr);
-				goto out_unlock;
-			}
-			it.ofs = 0;
+		ret = erofs_xattr_iter_fixup_aligned(&it);
+		if (ret) {
+			kfree(vi->xattr_shared_xattrs);
+			vi->xattr_shared_xattrs = NULL;
+			goto out_unlock;
 		}
 		vi->xattr_shared_xattrs[i] =
 			le32_to_cpu(*(__le32 *)(it.kaddr + it.ofs));
@@ -150,20 +165,6 @@ struct xattr_iter_handlers {
 		      unsigned int len);
 };
 
-static inline int xattr_iter_fixup(struct xattr_iter *it)
-{
-	if (it->ofs < it->sb->s_blocksize)
-		return 0;
-
-	it->blkaddr += erofs_blknr(it->sb, it->ofs);
-	it->kaddr = erofs_read_metabuf(&it->buf, it->sb, it->blkaddr,
-				       EROFS_KMAP);
-	if (IS_ERR(it->kaddr))
-		return PTR_ERR(it->kaddr);
-	it->ofs = erofs_blkoff(it->sb, it->ofs);
-	return 0;
-}
-
 static int inline_xattr_iter_begin(struct xattr_iter *it,
 				   struct inode *inode)
 {
@@ -201,7 +202,7 @@ static int xattr_foreach(struct xattr_iter *it,
 	int err;
 
 	/* 0. fixup blkaddr, ofs, ipage */
-	err = xattr_iter_fixup(it);
+	err = erofs_xattr_iter_fixup(it);
 	if (err)
 		return err;
 
@@ -236,14 +237,9 @@ static int xattr_foreach(struct xattr_iter *it,
 	processed = 0;
 
 	while (processed < entry.e_name_len) {
-		if (it->ofs >= it->sb->s_blocksize) {
-			DBG_BUGON(it->ofs > it->sb->s_blocksize);
-
-			err = xattr_iter_fixup(it);
-			if (err)
-				goto out;
-			it->ofs = 0;
-		}
+		err = erofs_xattr_iter_fixup_aligned(it);
+		if (err)
+			goto out;
 
 		slice = min_t(unsigned int, it->sb->s_blocksize - it->ofs,
 			      entry.e_name_len - processed);
@@ -271,14 +267,9 @@ static int xattr_foreach(struct xattr_iter *it,
 	}
 
 	while (processed < value_sz) {
-		if (it->ofs >= it->sb->s_blocksize) {
-			DBG_BUGON(it->ofs > it->sb->s_blocksize);
-
-			err = xattr_iter_fixup(it);
-			if (err)
-				goto out;
-			it->ofs = 0;
-		}
+		err = erofs_xattr_iter_fixup_aligned(it);
+		if (err)
+			goto out;
 
 		slice = min_t(unsigned int, it->sb->s_blocksize - it->ofs,
 			      value_sz - processed);
-- 
2.19.1.6.gb485710b

