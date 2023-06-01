Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCA27190A1
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Jun 2023 04:44:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QWr7F0Prxz3dwC
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Jun 2023 12:44:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QWr716TjYz3bxL
	for <linux-erofs@lists.ozlabs.org>; Thu,  1 Jun 2023 12:43:57 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vk-8yVs_1685587431;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vk-8yVs_1685587431)
          by smtp.aliyun-inc.com;
          Thu, 01 Jun 2023 10:43:51 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v5 3/6] erofs: unify xattr_iter structures
Date: Thu,  1 Jun 2023 10:43:44 +0800
Message-Id: <20230601024347.108469-4-jefflexu@linux.alibaba.com>
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

Unify xattr_iter/listxattr_iter/getxattr_iter structures into
erofs_xattr_iter structure.

This is in preparation for the following further cleanup.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/xattr.c | 149 ++++++++++++++++++++---------------------------
 1 file changed, 63 insertions(+), 86 deletions(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 0fd574e94c8b..a691d539ae4f 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -20,16 +20,25 @@ static inline unsigned int erofs_xattr_blkoff(struct super_block *sb,
 	return erofs_blkoff(sb, xattr_id * sizeof(__u32));
 }
 
-struct xattr_iter {
+struct erofs_xattr_iter {
 	struct super_block *sb;
 	struct erofs_buf buf;
 	void *kaddr;
-
 	erofs_blk_t blkaddr;
 	unsigned int ofs;
+
+	char *buffer;
+	int buffer_size, buffer_ofs;
+
+	/* getxattr */
+	int index, infix_len;
+	struct qstr name;
+
+	/* listxattr */
+	struct dentry *dentry;
 };
 
-static inline int erofs_xattr_iter_fixup(struct xattr_iter *it, bool nospan)
+static inline int erofs_xattr_iter_fixup(struct erofs_xattr_iter *it, bool nospan)
 {
 	if (it->ofs < it->sb->s_blocksize)
 		return 0;
@@ -50,7 +59,7 @@ static inline int erofs_xattr_iter_fixup(struct xattr_iter *it, bool nospan)
 static int erofs_init_inode_xattrs(struct inode *inode)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
-	struct xattr_iter it;
+	struct erofs_xattr_iter it;
 	unsigned int i;
 	struct erofs_xattr_ibody_header *ih;
 	struct super_block *sb = inode->i_sb;
@@ -154,15 +163,15 @@ static int erofs_init_inode_xattrs(struct inode *inode)
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
 				   struct inode *inode)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
@@ -189,7 +198,7 @@ static int inline_xattr_iter_begin(struct xattr_iter *it,
  * Regardless of success or failure, `xattr_foreach' will end up with
  * `ofs' pointing to the next xattr item rather than an arbitrary position.
  */
-static int xattr_foreach(struct xattr_iter *it,
+static int xattr_foreach(struct erofs_xattr_iter *it,
 			 const struct xattr_iter_handlers *op,
 			 unsigned int *tlimit)
 {
@@ -280,18 +289,10 @@ static int xattr_foreach(struct xattr_iter *it,
 	return err < 0 ? err : 0;
 }
 
-struct getxattr_iter {
-	struct xattr_iter it;
-
-	char *buffer;
-	int buffer_size, index, infix_len;
-	struct qstr name;
-};
-
-static int erofs_xattr_long_entrymatch(struct getxattr_iter *it,
+static int erofs_xattr_long_entrymatch(struct erofs_xattr_iter *it,
 				       struct erofs_xattr_entry *entry)
 {
-	struct erofs_sb_info *sbi = EROFS_SB(it->it.sb);
+	struct erofs_sb_info *sbi = EROFS_SB(it->sb);
 	struct erofs_xattr_prefix_item *pf = sbi->xattr_prefixes +
 		(entry->e_name_index & EROFS_XATTR_LONG_PREFIX_MASK);
 
@@ -309,11 +310,9 @@ static int erofs_xattr_long_entrymatch(struct getxattr_iter *it,
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
@@ -325,32 +324,27 @@ static int xattr_entrymatch(struct xattr_iter *_it,
 	return 0;
 }
 
-static int xattr_namematch(struct xattr_iter *_it,
+static int xattr_namematch(struct erofs_xattr_iter *it,
 			   unsigned int processed, char *buf, unsigned int len)
 {
-	struct getxattr_iter *it = container_of(_it, struct getxattr_iter, it);
-
 	if (memcmp(buf, it->name.name + it->infix_len + processed, len))
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
 
@@ -361,40 +355,40 @@ static const struct xattr_iter_handlers find_xattr_handlers = {
 	.value = xattr_copyvalue
 };
 
-static int inline_getxattr(struct inode *inode, struct getxattr_iter *it)
+static int inline_getxattr(struct inode *inode, struct erofs_xattr_iter *it)
 {
 	int ret;
 	unsigned int remaining;
 
-	ret = inline_xattr_iter_begin(&it->it, inode);
+	ret = inline_xattr_iter_begin(it, inode);
 	if (ret < 0)
 		return ret;
 
 	remaining = ret;
 	while (remaining) {
-		ret = xattr_foreach(&it->it, &find_xattr_handlers, &remaining);
+		ret = xattr_foreach(it, &find_xattr_handlers, &remaining);
 		if (ret != -ENOATTR)
 			break;
 	}
 	return ret ? ret : it->buffer_size;
 }
 
-static int shared_getxattr(struct inode *inode, struct getxattr_iter *it)
+static int shared_getxattr(struct inode *inode, struct erofs_xattr_iter *it)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
-	struct super_block *const sb = it->it.sb;
+	struct super_block *const sb = it->sb;
 	unsigned int i, xsid;
 	int ret = -ENOATTR;
 
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
 		xsid = vi->xattr_shared_xattrs[i];
-		it->it.blkaddr = erofs_xattr_blkaddr(sb, xsid);
-		it->it.ofs = erofs_xattr_blkoff(sb, xsid);
-		it->it.kaddr = erofs_bread(&it->it.buf, it->it.blkaddr, EROFS_KMAP);
-		if (IS_ERR(it->it.kaddr))
-			return PTR_ERR(it->it.kaddr);
+		it->blkaddr = erofs_xattr_blkaddr(sb, xsid);
+		it->ofs = erofs_xattr_blkoff(sb, xsid);
+		it->kaddr = erofs_bread(&it->buf, it->blkaddr, EROFS_KMAP);
+		if (IS_ERR(it->kaddr))
+			return PTR_ERR(it->kaddr);
 
-		ret = xattr_foreach(&it->it, &find_xattr_handlers, NULL);
+		ret = xattr_foreach(it, &find_xattr_handlers, NULL);
 		if (ret != -ENOATTR)
 			break;
 	}
@@ -416,7 +410,7 @@ int erofs_getxattr(struct inode *inode, int index,
 		   void *buffer, size_t buffer_size)
 {
 	int ret;
-	struct getxattr_iter it;
+	struct erofs_xattr_iter it;
 
 	if (!name)
 		return -EINVAL;
@@ -426,22 +420,21 @@ int erofs_getxattr(struct inode *inode, int index,
 		return ret;
 
 	it.index = index;
-	it.name.len = strlen(name);
+	it.name = (struct qstr)QSTR_INIT(name, strlen(name));
 	if (it.name.len > EROFS_NAME_LEN)
 		return -ERANGE;
 
-	it.it.sb = inode->i_sb;
-	it.it.buf = __EROFS_BUF_INITIALIZER;
-	erofs_init_metabuf(&it.it.buf, it.it.sb);
-	it.name.name = name;
-
+	it.sb = inode->i_sb;
+	it.buf = __EROFS_BUF_INITIALIZER;
+	erofs_init_metabuf(&it.buf, it.sb);
 	it.buffer = buffer;
 	it.buffer_size = buffer_size;
+	it.buffer_ofs = 0;
 
 	ret = inline_getxattr(inode, &it);
 	if (ret == -ENOATTR)
 		ret = shared_getxattr(inode, &it);
-	erofs_put_metabuf(&it.it.buf);
+	erofs_put_metabuf(&it.buf);
 	return ret;
 }
 
@@ -487,25 +480,15 @@ const struct xattr_handler *erofs_xattr_handlers[] = {
 	NULL,
 };
 
-struct listxattr_iter {
-	struct xattr_iter it;
-
-	struct dentry *dentry;
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
-		struct erofs_sb_info *sbi = EROFS_SB(_it->sb);
+		struct erofs_sb_info *sbi = EROFS_SB(it->sb);
 		struct erofs_xattr_prefix_item *pf = sbi->xattr_prefixes +
 			(entry->e_name_index & EROFS_XATTR_LONG_PREFIX_MASK);
 
@@ -537,23 +520,17 @@ static int xattr_entrylist(struct xattr_iter *_it,
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
@@ -565,41 +542,41 @@ static const struct xattr_iter_handlers list_xattr_handlers = {
 	.value = NULL
 };
 
-static int inline_listxattr(struct listxattr_iter *it)
+static int inline_listxattr(struct erofs_xattr_iter *it)
 {
 	int ret;
 	unsigned int remaining;
 
-	ret = inline_xattr_iter_begin(&it->it, d_inode(it->dentry));
+	ret = inline_xattr_iter_begin(it, d_inode(it->dentry));
 	if (ret < 0)
 		return ret;
 
 	remaining = ret;
 	while (remaining) {
-		ret = xattr_foreach(&it->it, &list_xattr_handlers, &remaining);
+		ret = xattr_foreach(it, &list_xattr_handlers, &remaining);
 		if (ret)
 			break;
 	}
 	return ret ? ret : it->buffer_ofs;
 }
 
-static int shared_listxattr(struct listxattr_iter *it)
+static int shared_listxattr(struct erofs_xattr_iter *it)
 {
 	struct inode *const inode = d_inode(it->dentry);
 	struct erofs_inode *const vi = EROFS_I(inode);
-	struct super_block *const sb = it->it.sb;
+	struct super_block *const sb = it->sb;
 	unsigned int i, xsid;
 	int ret = 0;
 
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
 		xsid = vi->xattr_shared_xattrs[i];
-		it->it.blkaddr = erofs_xattr_blkaddr(sb, xsid);
-		it->it.ofs = erofs_xattr_blkoff(sb, xsid);
-		it->it.kaddr = erofs_bread(&it->it.buf, it->it.blkaddr, EROFS_KMAP);
-		if (IS_ERR(it->it.kaddr))
-			return PTR_ERR(it->it.kaddr);
+		it->blkaddr = erofs_xattr_blkaddr(sb, xsid);
+		it->ofs = erofs_xattr_blkoff(sb, xsid);
+		it->kaddr = erofs_bread(&it->buf, it->blkaddr, EROFS_KMAP);
+		if (IS_ERR(it->kaddr))
+			return PTR_ERR(it->kaddr);
 
-		ret = xattr_foreach(&it->it, &list_xattr_handlers, NULL);
+		ret = xattr_foreach(it, &list_xattr_handlers, NULL);
 		if (ret)
 			break;
 	}
@@ -610,7 +587,7 @@ ssize_t erofs_listxattr(struct dentry *dentry,
 			char *buffer, size_t buffer_size)
 {
 	int ret;
-	struct listxattr_iter it;
+	struct erofs_xattr_iter it;
 
 	ret = erofs_init_inode_xattrs(d_inode(dentry));
 	if (ret == -ENOATTR)
@@ -618,9 +595,9 @@ ssize_t erofs_listxattr(struct dentry *dentry,
 	if (ret)
 		return ret;
 
-	it.it.sb = dentry->d_sb;
-	it.it.buf = __EROFS_BUF_INITIALIZER;
-	erofs_init_metabuf(&it.it.buf, it.it.sb);
+	it.sb = dentry->d_sb;
+	it.buf = __EROFS_BUF_INITIALIZER;
+	erofs_init_metabuf(&it.buf, it.sb);
 	it.dentry = dentry;
 	it.buffer = buffer;
 	it.buffer_size = buffer_size;
@@ -629,7 +606,7 @@ ssize_t erofs_listxattr(struct dentry *dentry,
 	ret = inline_listxattr(&it);
 	if (ret >= 0 || ret == -ENOATTR)
 		ret = shared_listxattr(&it);
-	erofs_put_metabuf(&it.it.buf);
+	erofs_put_metabuf(&it.buf);
 	return ret;
 }
 
-- 
2.19.1.6.gb485710b

