Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EC87171909E
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Jun 2023 04:44:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QWr774b5pz3cfJ
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Jun 2023 12:44:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QWr7032tjz3c34
	for <linux-erofs@lists.ozlabs.org>; Thu,  1 Jun 2023 12:43:55 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vk-8yUv_1685587428;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vk-8yUv_1685587428)
          by smtp.aliyun-inc.com;
          Thu, 01 Jun 2023 10:43:49 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v5 1/6] erofs: convert erofs_read_metabuf() to erofs_bread() for xattr
Date: Thu,  1 Jun 2023 10:43:42 +0800
Message-Id: <20230601024347.108469-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230601024347.108469-1-jefflexu@linux.alibaba.com>
References: <20230601024347.108469-1-jefflexu@linux.alibaba.com>
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

buf->inode is constant once initialized during erofs_buf's lifetime.
Thus call erofs_init_metabuf() and erofs_bread() separately to avoid
the repetition of assigning buf->inode when iterating xattrs.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/xattr.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index bbfe7ce170d2..d9e041d27a35 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -81,11 +81,12 @@ static int erofs_init_inode_xattrs(struct inode *inode)
 	}
 
 	it.buf = __EROFS_BUF_INITIALIZER;
+	erofs_init_metabuf(&it.buf, sb);
 	it.blkaddr = erofs_blknr(sb, erofs_iloc(inode) + vi->inode_isize);
 	it.ofs = erofs_blkoff(sb, erofs_iloc(inode) + vi->inode_isize);
 
 	/* read in shared xattr array (non-atomic, see kmalloc below) */
-	it.kaddr = erofs_read_metabuf(&it.buf, sb, it.blkaddr, EROFS_KMAP);
+	it.kaddr = erofs_bread(&it.buf, it.blkaddr, EROFS_KMAP);
 	if (IS_ERR(it.kaddr)) {
 		ret = PTR_ERR(it.kaddr);
 		goto out_unlock;
@@ -109,8 +110,7 @@ static int erofs_init_inode_xattrs(struct inode *inode)
 			/* cannot be unaligned */
 			DBG_BUGON(it.ofs != sb->s_blocksize);
 
-			it.kaddr = erofs_read_metabuf(&it.buf, sb, ++it.blkaddr,
-						      EROFS_KMAP);
+			it.kaddr = erofs_bread(&it.buf, ++it.blkaddr, EROFS_KMAP);
 			if (IS_ERR(it.kaddr)) {
 				kfree(vi->xattr_shared_xattrs);
 				vi->xattr_shared_xattrs = NULL;
@@ -156,8 +156,7 @@ static inline int xattr_iter_fixup(struct xattr_iter *it)
 		return 0;
 
 	it->blkaddr += erofs_blknr(it->sb, it->ofs);
-	it->kaddr = erofs_read_metabuf(&it->buf, it->sb, it->blkaddr,
-				       EROFS_KMAP);
+	it->kaddr = erofs_bread(&it->buf, it->blkaddr, EROFS_KMAP);
 	if (IS_ERR(it->kaddr))
 		return PTR_ERR(it->kaddr);
 	it->ofs = erofs_blkoff(it->sb, it->ofs);
@@ -181,8 +180,7 @@ static int inline_xattr_iter_begin(struct xattr_iter *it,
 
 	it->blkaddr = erofs_blknr(it->sb, erofs_iloc(inode) + inline_xattr_ofs);
 	it->ofs = erofs_blkoff(it->sb, erofs_iloc(inode) + inline_xattr_ofs);
-	it->kaddr = erofs_read_metabuf(&it->buf, inode->i_sb, it->blkaddr,
-				       EROFS_KMAP);
+	it->kaddr = erofs_bread(&it->buf, it->blkaddr, EROFS_KMAP);
 	if (IS_ERR(it->kaddr))
 		return PTR_ERR(it->kaddr);
 	return vi->xattr_isize - xattr_header_sz;
@@ -403,8 +401,7 @@ static int shared_getxattr(struct inode *inode, struct getxattr_iter *it)
 		xsid = vi->xattr_shared_xattrs[i];
 		it->it.blkaddr = erofs_xattr_blkaddr(sb, xsid);
 		it->it.ofs = erofs_xattr_blkoff(sb, xsid);
-		it->it.kaddr = erofs_read_metabuf(&it->it.buf, sb,
-						  it->it.blkaddr, EROFS_KMAP);
+		it->it.kaddr = erofs_bread(&it->it.buf, it->it.blkaddr, EROFS_KMAP);
 		if (IS_ERR(it->it.kaddr))
 			return PTR_ERR(it->it.kaddr);
 
@@ -444,13 +441,14 @@ int erofs_getxattr(struct inode *inode, int index,
 	if (it.name.len > EROFS_NAME_LEN)
 		return -ERANGE;
 
+	it.it.sb = inode->i_sb;
 	it.it.buf = __EROFS_BUF_INITIALIZER;
+	erofs_init_metabuf(&it.it.buf, it.it.sb);
 	it.name.name = name;
 
 	it.buffer = buffer;
 	it.buffer_size = buffer_size;
 
-	it.it.sb = inode->i_sb;
 	ret = inline_getxattr(inode, &it);
 	if (ret == -ENOATTR)
 		ret = shared_getxattr(inode, &it);
@@ -608,8 +606,7 @@ static int shared_listxattr(struct listxattr_iter *it)
 		xsid = vi->xattr_shared_xattrs[i];
 		it->it.blkaddr = erofs_xattr_blkaddr(sb, xsid);
 		it->it.ofs = erofs_xattr_blkoff(sb, xsid);
-		it->it.kaddr = erofs_read_metabuf(&it->it.buf, sb,
-						  it->it.blkaddr, EROFS_KMAP);
+		it->it.kaddr = erofs_bread(&it->it.buf, it->it.blkaddr, EROFS_KMAP);
 		if (IS_ERR(it->it.kaddr))
 			return PTR_ERR(it->it.kaddr);
 
@@ -632,14 +629,14 @@ ssize_t erofs_listxattr(struct dentry *dentry,
 	if (ret)
 		return ret;
 
+	it.it.sb = dentry->d_sb;
 	it.it.buf = __EROFS_BUF_INITIALIZER;
+	erofs_init_metabuf(&it.it.buf, it.it.sb);
 	it.dentry = dentry;
 	it.buffer = buffer;
 	it.buffer_size = buffer_size;
 	it.buffer_ofs = 0;
 
-	it.it.sb = dentry->d_sb;
-
 	ret = inline_listxattr(&it);
 	if (ret >= 0 || ret == -ENOATTR)
 		ret = shared_listxattr(&it);
-- 
2.19.1.6.gb485710b

