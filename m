Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4805575EE8
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Jul 2022 12:00:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lkn0C5zYzz3c5D
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Jul 2022 19:59:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.56; helo=out30-56.freemail.mail.aliyun.com; envelope-from=jnhuang@linux.alibaba.com; receiver=<UNKNOWN>)
X-Greylist: delayed 327 seconds by postgrey-1.36 at boromir; Fri, 15 Jul 2022 19:59:45 AEST
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Lkn014L5Kz3c1Q
	for <linux-erofs@lists.ozlabs.org>; Fri, 15 Jul 2022 19:59:44 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jnhuang@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VJOylbC_1657878841;
Received: from localhost.localdomain(mailfrom:jnhuang@linux.alibaba.com fp:SMTPD_---0VJOylbC_1657878841)
          by smtp.aliyun-inc.com;
          Fri, 15 Jul 2022 17:54:02 +0800
From: Huang Jianan <jnhuang@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fuse: introduce xattr support
Date: Fri, 15 Jul 2022 17:53:59 +0800
Message-Id: <20220715095359.37534-1-jnhuang@linux.alibaba.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This implements xattr functionalities for erofsfuse. A large amount
of code was adapted from Linux kernel.

Signed-off-by: Huang Jianan <jnhuang@linux.alibaba.com>
---
 fuse/main.c              |  32 +++
 include/erofs/internal.h |   8 +
 include/erofs/xattr.h    |  21 ++
 lib/xattr.c              | 508 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 569 insertions(+)

diff --git a/fuse/main.c b/fuse/main.c
index f4c2476..30a0bed 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -139,7 +139,39 @@ static int erofsfuse_readlink(const char *path, char *buffer, size_t size)
 	return 0;
 }
 
+static int erofsfuse_getxattr(const char *path, const char *name, char *value,
+			size_t size)
+{
+	int ret;
+	struct erofs_inode vi;
+
+	erofs_dbg("getxattr(%s): name=%s size=%llu", path, name, size);
+
+	ret = erofs_ilookup(path, &vi);
+	if (ret)
+		return ret;
+
+	return erofs_getxattr(&vi, name, value, size);
+}
+
+static int erofsfuse_listxattr(const char *path, char *list, size_t size)
+{
+	int ret;
+	struct erofs_inode vi;
+	int i;
+
+	erofs_dbg("listxattr(%s): size=%llu", path, size);
+
+	ret = erofs_ilookup(path, &vi);
+	if (ret)
+		return ret;
+
+	return erofs_listxattr(&vi, list, size);
+}
+
 static struct fuse_operations erofs_ops = {
+	.getxattr = erofsfuse_getxattr,
+	.listxattr = erofsfuse_listxattr,
 	.readlink = erofsfuse_readlink,
 	.getattr = erofsfuse_getattr,
 	.readdir = erofsfuse_readdir,
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 6a70f11..991635f 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -180,6 +180,9 @@ struct erofs_inode {
 	unsigned int xattr_isize;
 	unsigned int extent_isize;
 
+	unsigned int xattr_shared_count;
+	unsigned int *xattr_shared_xattrs;
+
 	erofs_nid_t nid;
 	struct erofs_buffer_head *bh;
 	struct erofs_buffer_head *bh_inline, *bh_data;
@@ -351,6 +354,11 @@ static inline int erofs_get_occupied_size(const struct erofs_inode *inode,
 	return 0;
 }
 
+/* data.c */
+int erofs_getxattr(struct erofs_inode *vi, const char *name, char *buffer,
+		   size_t buffer_size);
+int erofs_listxattr(struct erofs_inode *vi, char *buffer, size_t buffer_size);
+
 /* zmap.c */
 int z_erofs_fill_inode(struct erofs_inode *vi);
 int z_erofs_map_blocks_iter(struct erofs_inode *vi,
diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index 226e984..a0528c0 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -14,6 +14,27 @@ extern "C"
 
 #include "internal.h"
 
+#ifndef ENOATTR
+#define ENOATTR	ENODATA
+#endif
+
+static inline unsigned int inlinexattr_header_size(struct erofs_inode *vi)
+{
+	return sizeof(struct erofs_xattr_ibody_header) +
+		sizeof(u32) * vi->xattr_shared_count;
+}
+
+static inline erofs_blk_t xattrblock_addr(unsigned int xattr_id)
+{
+	return sbi.xattr_blkaddr +
+		xattr_id * sizeof(__u32) / EROFS_BLKSIZ;
+}
+
+static inline unsigned int xattrblock_offset(unsigned int xattr_id)
+{
+	return (xattr_id * sizeof(__u32)) % EROFS_BLKSIZ;
+}
+
 #define EROFS_INODE_XATTR_ICOUNT(_size)	({\
 	u32 __size = le16_to_cpu(_size); \
 	((__size) == 0) ? 0 : \
diff --git a/lib/xattr.c b/lib/xattr.c
index 71ffe3e..aa35ca1 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -716,3 +716,511 @@ char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned int size)
 	DBG_BUGON(p > size);
 	return buf;
 }
+
+struct xattr_iter {
+	char page[EROFS_BLKSIZ];
+
+	void *kaddr;
+
+	erofs_blk_t blkaddr;
+	unsigned int ofs;
+};
+
+static int init_inode_xattrs(struct erofs_inode *vi)
+{
+	struct xattr_iter it;
+	unsigned int i;
+	struct erofs_xattr_ibody_header *ih;
+	int ret = 0;
+
+	/* the most case is that xattrs of this inode are initialized. */
+	if (vi->flags & EROFS_I_EA_INITED)
+		return ret;
+
+	/*
+	 * bypass all xattr operations if ->xattr_isize is not greater than
+	 * sizeof(struct erofs_xattr_ibody_header), in detail:
+	 * 1) it is not enough to contain erofs_xattr_ibody_header then
+	 *    ->xattr_isize should be 0 (it means no xattr);
+	 * 2) it is just to contain erofs_xattr_ibody_header, which is on-disk
+	 *    undefined right now (maybe use later with some new sb feature).
+	 */
+	if (vi->xattr_isize == sizeof(struct erofs_xattr_ibody_header)) {
+		erofs_err("xattr_isize %d of nid %llu is not supported yet",
+			  vi->xattr_isize, vi->nid);
+		return -EOPNOTSUPP;
+	} else if (vi->xattr_isize < sizeof(struct erofs_xattr_ibody_header)) {
+		if (vi->xattr_isize) {
+			erofs_err("bogus xattr ibody @ nid %llu", vi->nid);
+			DBG_BUGON(1);
+			return -EFSCORRUPTED;	/* xattr ondisk layout error */
+		}
+		return -ENOATTR;
+	}
+
+	it.blkaddr = erofs_blknr(iloc(vi->nid) + vi->inode_isize);
+	it.ofs = erofs_blkoff(iloc(vi->nid) + vi->inode_isize);
+
+	ret = blk_read(0, it.page, it.blkaddr, 1);
+	if (ret < 0)
+		return -EIO;
+
+	it.kaddr = it.page;
+	ih = (struct erofs_xattr_ibody_header *)(it.kaddr + it.ofs);
+
+	vi->xattr_shared_count = ih->h_shared_count;
+	vi->xattr_shared_xattrs = malloc(vi->xattr_shared_count * sizeof(uint));
+	if (!vi->xattr_shared_xattrs)
+		return -ENOMEM;
+
+	/* let's skip ibody header */
+	it.ofs += sizeof(struct erofs_xattr_ibody_header);
+
+	for (i = 0; i < vi->xattr_shared_count; ++i) {
+		if (it.ofs >= EROFS_BLKSIZ) {
+			/* cannot be unaligned */
+			DBG_BUGON(it.ofs != EROFS_BLKSIZ);
+
+			ret = blk_read(0, it.page, ++it.blkaddr, 1);
+			if (ret < 0) {
+				free(vi->xattr_shared_xattrs);
+				vi->xattr_shared_xattrs = NULL;
+				return -EIO;
+			}
+
+			it.kaddr = it.page;
+			it.ofs = 0;
+		}
+		vi->xattr_shared_xattrs[i] =
+			le32_to_cpu(*(__le32 *)(it.kaddr + it.ofs));
+		it.ofs += sizeof(__le32);
+	}
+
+	vi->flags |= EROFS_I_EA_INITED;
+
+	return ret;
+}
+
+/*
+ * the general idea for these return values is
+ * if    0 is returned, go on processing the current xattr;
+ *       1 (> 0) is returned, skip this round to process the next xattr;
+ *    -err (< 0) is returned, an error (maybe ENOXATTR) occurred
+ *                            and need to be handled
+ */
+struct xattr_iter_handlers {
+	int (*entry)(struct xattr_iter *_it, struct erofs_xattr_entry *entry);
+	int (*name)(struct xattr_iter *_it, unsigned int processed, char *buf,
+		    unsigned int len);
+	int (*alloc_buffer)(struct xattr_iter *_it, unsigned int value_sz);
+	void (*value)(struct xattr_iter *_it, unsigned int processed, char *buf,
+		      unsigned int len);
+};
+
+static inline int xattr_iter_fixup(struct xattr_iter *it)
+{
+	int ret;
+
+	if (it->ofs < EROFS_BLKSIZ)
+		return 0;
+
+	it->blkaddr += erofs_blknr(it->ofs);
+
+	ret = blk_read(0, it->page, it->blkaddr, 1);
+	if (ret < 0)
+		return -EIO;
+
+	it->kaddr = it->page;
+	it->ofs = erofs_blkoff(it->ofs);
+	return 0;
+}
+
+static int inline_xattr_iter_pre(struct xattr_iter *it,
+				   struct erofs_inode *vi)
+{
+	unsigned int xattr_header_sz, inline_xattr_ofs;
+	int ret;
+
+	xattr_header_sz = inlinexattr_header_size(vi);
+	if (xattr_header_sz >= vi->xattr_isize) {
+		DBG_BUGON(xattr_header_sz > vi->xattr_isize);
+		return -ENOATTR;
+	}
+
+	inline_xattr_ofs = vi->inode_isize + xattr_header_sz;
+
+	it->blkaddr = erofs_blknr(iloc(vi->nid) + inline_xattr_ofs);
+	it->ofs = erofs_blkoff(iloc(vi->nid) + inline_xattr_ofs);
+
+	ret = blk_read(0, it->page, it->blkaddr, 1);
+	if (ret < 0)
+		return -EIO;
+
+	it->kaddr = it->page;
+	return vi->xattr_isize - xattr_header_sz;
+}
+
+/*
+ * Regardless of success or failure, `xattr_foreach' will end up with
+ * `ofs' pointing to the next xattr item rather than an arbitrary position.
+ */
+static int xattr_foreach(struct xattr_iter *it,
+			 const struct xattr_iter_handlers *op,
+			 unsigned int *tlimit)
+{
+	struct erofs_xattr_entry entry;
+	unsigned int value_sz, processed, slice;
+	int err;
+
+	/* 0. fixup blkaddr, ofs, ipage */
+	err = xattr_iter_fixup(it);
+	if (err)
+		return err;
+
+	/*
+	 * 1. read xattr entry to the memory,
+	 *    since we do EROFS_XATTR_ALIGN
+	 *    therefore entry should be in the page
+	 */
+	entry = *(struct erofs_xattr_entry *)(it->kaddr + it->ofs);
+	if (tlimit) {
+		unsigned int entry_sz = erofs_xattr_entry_size(&entry);
+
+		/* xattr on-disk corruption: xattr entry beyond xattr_isize */
+		if (*tlimit < entry_sz) {
+			DBG_BUGON(1);
+			return -EFSCORRUPTED;
+		}
+		*tlimit -= entry_sz;
+	}
+
+	it->ofs += sizeof(struct erofs_xattr_entry);
+	value_sz = le16_to_cpu(entry.e_value_size);
+
+	/* handle entry */
+	err = op->entry(it, &entry);
+	if (err) {
+		it->ofs += entry.e_name_len + value_sz;
+		goto out;
+	}
+
+	/* 2. handle xattr name (ofs will finally be at the end of name) */
+	processed = 0;
+
+	while (processed < entry.e_name_len) {
+		if (it->ofs >= EROFS_BLKSIZ) {
+			DBG_BUGON(it->ofs > EROFS_BLKSIZ);
+
+			err = xattr_iter_fixup(it);
+			if (err)
+				goto out;
+			it->ofs = 0;
+		}
+
+		slice = min_t(unsigned int, PAGE_SIZE - it->ofs,
+			      entry.e_name_len - processed);
+
+		/* handle name */
+		err = op->name(it, processed, it->kaddr + it->ofs, slice);
+		if (err) {
+			it->ofs += entry.e_name_len - processed + value_sz;
+			goto out;
+		}
+
+		it->ofs += slice;
+		processed += slice;
+	}
+
+	/* 3. handle xattr value */
+	processed = 0;
+
+	if (op->alloc_buffer) {
+		err = op->alloc_buffer(it, value_sz);
+		if (err) {
+			it->ofs += value_sz;
+			goto out;
+		}
+	}
+
+	while (processed < value_sz) {
+		if (it->ofs >= EROFS_BLKSIZ) {
+			DBG_BUGON(it->ofs > EROFS_BLKSIZ);
+
+			err = xattr_iter_fixup(it);
+			if (err)
+				goto out;
+			it->ofs = 0;
+		}
+
+		slice = min_t(unsigned int, PAGE_SIZE - it->ofs,
+			      value_sz - processed);
+		op->value(it, processed, it->kaddr + it->ofs, slice);
+		it->ofs += slice;
+		processed += slice;
+	}
+
+out:
+	/* xattrs should be 4-byte aligned (on-disk constraint) */
+	it->ofs = EROFS_XATTR_ALIGN(it->ofs);
+	return err < 0 ? err : 0;
+}
+
+struct getxattr_iter {
+	struct xattr_iter it;
+
+	int buffer_size, index;
+	char *buffer;
+	const char *name;
+	size_t len;
+};
+
+static int xattr_entrymatch(struct xattr_iter *_it,
+			    struct erofs_xattr_entry *entry)
+{
+	struct getxattr_iter *it = container_of(_it, struct getxattr_iter, it);
+
+	return (it->index != entry->e_name_index ||
+		it->len != entry->e_name_len) ? -ENOATTR : 0;
+}
+
+static int xattr_namematch(struct xattr_iter *_it,
+			   unsigned int processed, char *buf, unsigned int len)
+{
+	struct getxattr_iter *it = container_of(_it, struct getxattr_iter, it);
+
+
+	return memcmp(buf, it->name + processed, len) ? -ENOATTR : 0;
+}
+
+static int xattr_checkbuffer(struct xattr_iter *_it,
+			     unsigned int value_sz)
+{
+	struct getxattr_iter *it = container_of(_it, struct getxattr_iter, it);
+	int err = it->buffer_size < value_sz ? -ERANGE : 0;
+
+	it->buffer_size = value_sz;
+	return !it->buffer ? 1 : err;
+}
+
+static void xattr_copyvalue(struct xattr_iter *_it,
+			    unsigned int processed,
+			    char *buf, unsigned int len)
+{
+	struct getxattr_iter *it = container_of(_it, struct getxattr_iter, it);
+
+	memcpy(it->buffer + processed, buf, len);
+}
+
+static const struct xattr_iter_handlers find_xattr_handlers = {
+	.entry = xattr_entrymatch,
+	.name = xattr_namematch,
+	.alloc_buffer = xattr_checkbuffer,
+	.value = xattr_copyvalue
+};
+
+static int inline_getxattr(struct erofs_inode *vi, struct getxattr_iter *it)
+{
+	int ret;
+	unsigned int remaining;
+
+	ret = inline_xattr_iter_pre(&it->it, vi);
+	if (ret < 0)
+		return ret;
+
+	remaining = ret;
+	while (remaining) {
+		ret = xattr_foreach(&it->it, &find_xattr_handlers, &remaining);
+		if (ret != -ENOATTR)
+			break;
+	}
+
+	return ret ? ret : it->buffer_size;
+}
+
+static int shared_getxattr(struct erofs_inode *vi, struct getxattr_iter *it)
+{
+	unsigned int i;
+	int ret = -ENOATTR;
+
+	for (i = 0; i < vi->xattr_shared_count; ++i) {
+		erofs_blk_t blkaddr =
+			xattrblock_addr(vi->xattr_shared_xattrs[i]);
+
+		it->it.ofs = xattrblock_offset(vi->xattr_shared_xattrs[i]);
+
+		if (!i || blkaddr != it->it.blkaddr) {
+			ret = blk_read(0, it->it.page, blkaddr, 1);
+			if (ret < 0)
+				return -EIO;
+
+			it->it.kaddr = it->it.page;
+			it->it.blkaddr = blkaddr;
+		}
+
+		ret = xattr_foreach(&it->it, &find_xattr_handlers, NULL);
+		if (ret != -ENOATTR)
+			break;
+	}
+
+	return ret ? ret : it->buffer_size;
+}
+
+int erofs_getxattr(struct erofs_inode *vi, const char *name, char *buffer,
+		   size_t buffer_size)
+{
+	int ret;
+	u8 prefix;
+	u16 prefixlen;
+	struct getxattr_iter it;
+
+	if (!name)
+		return -EINVAL;
+
+	ret = init_inode_xattrs(vi);
+	if (ret)
+		return ret;
+
+	if (!match_prefix(name, &prefix, &prefixlen))
+		return -ENODATA;
+
+	it.index = prefix;
+	it.name = name + prefixlen;
+	it.len = strlen(it.name);
+	if (it.len > EROFS_NAME_LEN)
+		return -ERANGE;
+
+	it.buffer = buffer;
+	it.buffer_size = buffer_size;
+
+	ret = inline_getxattr(vi, &it);
+	if (ret == -ENOATTR)
+		ret = shared_getxattr(vi, &it);
+	return ret;
+}
+
+struct listxattr_iter {
+	struct xattr_iter it;
+
+	char *buffer;
+	int buffer_size, buffer_ofs;
+};
+
+static int xattr_entrylist(struct xattr_iter *_it,
+			   struct erofs_xattr_entry *entry)
+{
+	struct listxattr_iter *it =
+		container_of(_it, struct listxattr_iter, it);
+	unsigned int prefix_len;
+	const char *prefix;
+
+	prefix = xattr_types[entry->e_name_index].prefix;
+	prefix_len = xattr_types[entry->e_name_index].prefix_len;
+
+	if (!it->buffer) {
+		it->buffer_ofs += prefix_len + entry->e_name_len + 1;
+		return 1;
+	}
+
+	if (it->buffer_ofs + prefix_len
+		+ entry->e_name_len + 1 > it->buffer_size)
+		return -ERANGE;
+
+	memcpy(it->buffer + it->buffer_ofs, prefix, prefix_len);
+	it->buffer_ofs += prefix_len;
+	return 0;
+}
+
+static int xattr_namelist(struct xattr_iter *_it,
+			  unsigned int processed, char *buf, unsigned int len)
+{
+	struct listxattr_iter *it =
+		container_of(_it, struct listxattr_iter, it);
+
+	memcpy(it->buffer + it->buffer_ofs, buf, len);
+	it->buffer_ofs += len;
+	return 0;
+}
+
+static int xattr_skipvalue(struct xattr_iter *_it,
+			   unsigned int value_sz)
+{
+	struct listxattr_iter *it =
+		container_of(_it, struct listxattr_iter, it);
+
+	it->buffer[it->buffer_ofs++] = '\0';
+	return 1;
+}
+
+static const struct xattr_iter_handlers list_xattr_handlers = {
+	.entry = xattr_entrylist,
+	.name = xattr_namelist,
+	.alloc_buffer = xattr_skipvalue,
+	.value = NULL
+};
+
+static int inline_listxattr(struct erofs_inode *vi, struct listxattr_iter *it)
+{
+	int ret;
+	unsigned int remaining;
+
+	ret = inline_xattr_iter_pre(&it->it, vi);
+	if (ret < 0)
+		return ret;
+
+	remaining = ret;
+	while (remaining) {
+		ret = xattr_foreach(&it->it, &list_xattr_handlers, &remaining);
+		if (ret)
+			break;
+	}
+
+	return ret ? ret : it->buffer_ofs;
+}
+
+static int shared_listxattr(struct erofs_inode *vi, struct listxattr_iter *it)
+{
+	unsigned int i;
+	int ret = 0;
+
+	for (i = 0; i < vi->xattr_shared_count; ++i) {
+		erofs_blk_t blkaddr =
+			xattrblock_addr(vi->xattr_shared_xattrs[i]);
+
+		it->it.ofs = xattrblock_offset(vi->xattr_shared_xattrs[i]);
+		if (!i || blkaddr != it->it.blkaddr) {
+			ret = blk_read(0, it->it.page, blkaddr, 1);
+			if (ret < 0)
+				return -EIO;
+
+			it->it.kaddr = it->it.page;
+			it->it.blkaddr = blkaddr;
+		}
+
+		ret = xattr_foreach(&it->it, &list_xattr_handlers, NULL);
+		if (ret)
+			break;
+	}
+
+	return ret ? ret : it->buffer_ofs;
+}
+
+int erofs_listxattr(struct erofs_inode *vi, char *buffer, size_t buffer_size)
+{
+	int ret;
+	struct listxattr_iter it;
+
+	ret = init_inode_xattrs(vi);
+	if (ret == -ENOATTR)
+		return 0;
+	if (ret)
+		return ret;
+
+	it.buffer = buffer;
+	it.buffer_size = buffer_size;
+	it.buffer_ofs = 0;
+
+	ret = inline_listxattr(vi, &it);
+	if (ret < 0 && ret != -ENOATTR)
+		return ret;
+	return shared_listxattr(vi, &it);
+}
-- 
2.34.0

