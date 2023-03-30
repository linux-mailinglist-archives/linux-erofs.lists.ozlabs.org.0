Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 608E76CFE3A
	for <lists+linux-erofs@lfdr.de>; Thu, 30 Mar 2023 10:29:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PnGmj29GYz3cjK
	for <lists+linux-erofs@lfdr.de>; Thu, 30 Mar 2023 19:29:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PnGmY4zcRz3c7X
	for <linux-erofs@lists.ozlabs.org>; Thu, 30 Mar 2023 19:29:16 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VezocA0_1680164951;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VezocA0_1680164951)
          by smtp.aliyun-inc.com;
          Thu, 30 Mar 2023 16:29:12 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 1/8] erofs: move several xattr helpers into xattr.c
Date: Thu, 30 Mar 2023 16:29:03 +0800
Message-Id: <20230330082910.125374-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230330082910.125374-1-jefflexu@linux.alibaba.com>
References: <20230330082910.125374-1-jefflexu@linux.alibaba.com>
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

Move xattrblock_addr() and xattrblock_offset() helpers into xattr.c,
as they are not used outside of xattr.c.

inlinexattr_header_size() has only one caller, and thus make it inlined
into the caller directly.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/xattr.c | 48 +++++++++++++++++++++++++++++-------------------
 fs/erofs/xattr.h | 23 -----------------------
 2 files changed, 29 insertions(+), 42 deletions(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 459caa3cd65d..9ccd57581bc7 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -7,6 +7,19 @@
 #include <linux/security.h>
 #include "xattr.h"
 
+static inline erofs_blk_t erofs_xattr_blkaddr(struct super_block *sb,
+					      unsigned int xattr_id)
+{
+	return EROFS_SB(sb)->xattr_blkaddr +
+	       erofs_blknr(sb, xattr_id * sizeof(__u32));
+}
+
+static inline unsigned int erofs_xattr_blkoff(struct super_block *sb,
+					      unsigned int xattr_id)
+{
+	return erofs_blkoff(sb, xattr_id * sizeof(__u32));
+}
+
 struct xattr_iter {
 	struct super_block *sb;
 	struct erofs_buf buf;
@@ -157,7 +170,8 @@ static int inline_xattr_iter_begin(struct xattr_iter *it,
 	struct erofs_inode *const vi = EROFS_I(inode);
 	unsigned int xattr_header_sz, inline_xattr_ofs;
 
-	xattr_header_sz = inlinexattr_header_size(inode);
+	xattr_header_sz = sizeof(struct erofs_xattr_ibody_header) +
+			  sizeof(u32) * vi->xattr_shared_count;
 	if (xattr_header_sz >= vi->xattr_isize) {
 		DBG_BUGON(xattr_header_sz > vi->xattr_isize);
 		return -ENOATTR;
@@ -351,20 +365,18 @@ static int inline_getxattr(struct inode *inode, struct getxattr_iter *it)
 static int shared_getxattr(struct inode *inode, struct getxattr_iter *it)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
-	struct super_block *const sb = inode->i_sb;
-	unsigned int i;
+	struct super_block *const sb = it->it.sb;
+	unsigned int i, xsid;
 	int ret = -ENOATTR;
 
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
-		erofs_blk_t blkaddr =
-			xattrblock_addr(sb, vi->xattr_shared_xattrs[i]);
-
-		it->it.ofs = xattrblock_offset(sb, vi->xattr_shared_xattrs[i]);
-		it->it.kaddr = erofs_read_metabuf(&it->it.buf, sb, blkaddr,
-						  EROFS_KMAP);
+		xsid = vi->xattr_shared_xattrs[i];
+		it->it.blkaddr = erofs_xattr_blkaddr(sb, xsid);
+		it->it.ofs = erofs_xattr_blkoff(sb, xsid);
+		it->it.kaddr = erofs_read_metabuf(&it->it.buf, sb,
+						  it->it.blkaddr, EROFS_KMAP);
 		if (IS_ERR(it->it.kaddr))
 			return PTR_ERR(it->it.kaddr);
-		it->it.blkaddr = blkaddr;
 
 		ret = xattr_foreach(&it->it, &find_xattr_handlers, NULL);
 		if (ret != -ENOATTR)
@@ -562,20 +574,18 @@ static int shared_listxattr(struct listxattr_iter *it)
 {
 	struct inode *const inode = d_inode(it->dentry);
 	struct erofs_inode *const vi = EROFS_I(inode);
-	struct super_block *const sb = inode->i_sb;
-	unsigned int i;
+	struct super_block *const sb = it->it.sb;
+	unsigned int i, xsid;
 	int ret = 0;
 
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
-		erofs_blk_t blkaddr =
-			xattrblock_addr(sb, vi->xattr_shared_xattrs[i]);
-
-		it->it.ofs = xattrblock_offset(sb, vi->xattr_shared_xattrs[i]);
-		it->it.kaddr = erofs_read_metabuf(&it->it.buf, sb, blkaddr,
-						  EROFS_KMAP);
+		xsid = vi->xattr_shared_xattrs[i];
+		it->it.blkaddr = erofs_xattr_blkaddr(sb, xsid);
+		it->it.ofs = erofs_xattr_blkoff(sb, xsid);
+		it->it.kaddr = erofs_read_metabuf(&it->it.buf, sb,
+						  it->it.blkaddr, EROFS_KMAP);
 		if (IS_ERR(it->it.kaddr))
 			return PTR_ERR(it->it.kaddr);
-		it->it.blkaddr = blkaddr;
 
 		ret = xattr_foreach(&it->it, &list_xattr_handlers, NULL);
 		if (ret)
diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
index f7a21aaa9755..a65158cba14f 100644
--- a/fs/erofs/xattr.h
+++ b/fs/erofs/xattr.h
@@ -13,29 +13,6 @@
 /* Attribute not found */
 #define ENOATTR         ENODATA
 
-static inline unsigned int inlinexattr_header_size(struct inode *inode)
-{
-	return sizeof(struct erofs_xattr_ibody_header) +
-		sizeof(u32) * EROFS_I(inode)->xattr_shared_count;
-}
-
-static inline erofs_blk_t xattrblock_addr(struct super_block *sb,
-					  unsigned int xattr_id)
-{
-#ifdef CONFIG_EROFS_FS_XATTR
-	return EROFS_SB(sb)->xattr_blkaddr +
-		xattr_id * sizeof(__u32) / sb->s_blocksize;
-#else
-	return 0;
-#endif
-}
-
-static inline unsigned int xattrblock_offset(struct super_block *sb,
-					     unsigned int xattr_id)
-{
-	return (xattr_id * sizeof(__u32)) % sb->s_blocksize;
-}
-
 #ifdef CONFIG_EROFS_FS_XATTR
 extern const struct xattr_handler erofs_xattr_user_handler;
 extern const struct xattr_handler erofs_xattr_trusted_handler;
-- 
2.19.1.6.gb485710b

