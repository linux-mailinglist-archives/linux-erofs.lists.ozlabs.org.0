Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A4F8B3B2
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Aug 2019 11:15:35 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4676WR6XRszDqYh
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Aug 2019 19:15:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.190; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4676V241jdzDqXg
 for <linux-erofs@lists.ozlabs.org>; Tue, 13 Aug 2019 19:14:18 +1000 (AEST)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id F065B52E0A7DD96E5467;
 Tue, 13 Aug 2019 17:14:14 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 13 Aug
 2019 17:14:05 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v7 05/24] erofs: add inode operations
Date: Tue, 13 Aug 2019 17:13:07 +0800
Message-ID: <20190813091326.84652-6-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190813091326.84652-1-gaoxiang25@huawei.com>
References: <20190813091326.84652-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
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
Cc: devel@driverdev.osuosl.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-erofs@lists.ozlabs.org, Theodore Ts'o <tytso@mit.edu>,
 "Darrick J . Wong" <darrick.wong@oracle.com>, Pavel Machek <pavel@denx.de>,
 Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, Dave
 Chinner <david@fromorbit.com>, David Sterba <dsterba@suse.cz>,
 Christoph Hellwig <hch@infradead.org>, Richard Weinberger <richard@nod.at>,
 Miao Xie <miaoxie@huawei.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This adds core functions to get, read an inode.
It adds statx support as well.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/inode.c | 291 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 291 insertions(+)
 create mode 100644 fs/erofs/inode.c

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
new file mode 100644
index 000000000000..b6ea997bc4ae
--- /dev/null
+++ b/fs/erofs/inode.c
@@ -0,0 +1,291 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * linux/fs/erofs/inode.c
+ *
+ * Copyright (C) 2017-2018 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Gao Xiang <gaoxiang25@huawei.com>
+ */
+#include "internal.h"
+
+#include <trace/events/erofs.h>
+
+/* no locking */
+static int read_inode(struct inode *inode, void *data)
+{
+	struct erofs_vnode *vi = EROFS_V(inode);
+	struct erofs_inode_v1 *v1 = data;
+	const unsigned int advise = le16_to_cpu(v1->i_advise);
+	erofs_blk_t nblks = 0;
+
+	vi->datamode = __inode_data_mapping(advise);
+
+	if (unlikely(vi->datamode >= EROFS_INODE_LAYOUT_MAX)) {
+		errln("unsupported data mapping %u of nid %llu",
+		      vi->datamode, vi->nid);
+		DBG_BUGON(1);
+		return -EIO;
+	}
+
+	if (__inode_version(advise) == EROFS_INODE_LAYOUT_V2) {
+		struct erofs_inode_v2 *v2 = data;
+
+		vi->inode_isize = sizeof(struct erofs_inode_v2);
+		vi->xattr_isize = ondisk_xattr_ibody_size(v2->i_xattr_icount);
+
+		inode->i_mode = le16_to_cpu(v2->i_mode);
+		vi->raw_blkaddr = le32_to_cpu(v2->i_u.raw_blkaddr);
+
+		i_uid_write(inode, le32_to_cpu(v2->i_uid));
+		i_gid_write(inode, le32_to_cpu(v2->i_gid));
+		set_nlink(inode, le32_to_cpu(v2->i_nlink));
+
+		/* ns timestamp */
+		inode->i_mtime.tv_sec = inode->i_ctime.tv_sec =
+			le64_to_cpu(v2->i_ctime);
+		inode->i_mtime.tv_nsec = inode->i_ctime.tv_nsec =
+			le32_to_cpu(v2->i_ctime_nsec);
+
+		inode->i_size = le64_to_cpu(v2->i_size);
+
+		/* total blocks for compressed files */
+		if (is_inode_layout_compression(inode))
+			nblks = le32_to_cpu(v2->i_u.compressed_blocks);
+	} else if (__inode_version(advise) == EROFS_INODE_LAYOUT_V1) {
+		struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
+
+		vi->inode_isize = sizeof(struct erofs_inode_v1);
+		vi->xattr_isize = ondisk_xattr_ibody_size(v1->i_xattr_icount);
+
+		inode->i_mode = le16_to_cpu(v1->i_mode);
+		vi->raw_blkaddr = le32_to_cpu(v1->i_u.raw_blkaddr);
+
+		i_uid_write(inode, le16_to_cpu(v1->i_uid));
+		i_gid_write(inode, le16_to_cpu(v1->i_gid));
+		set_nlink(inode, le16_to_cpu(v1->i_nlink));
+
+		/* use build time to derive all file time */
+		inode->i_mtime.tv_sec = inode->i_ctime.tv_sec =
+			sbi->build_time;
+		inode->i_mtime.tv_nsec = inode->i_ctime.tv_nsec =
+			sbi->build_time_nsec;
+
+		inode->i_size = le32_to_cpu(v1->i_size);
+		if (is_inode_layout_compression(inode))
+			nblks = le32_to_cpu(v1->i_u.compressed_blocks);
+	} else {
+		errln("unsupported on-disk inode version %u of nid %llu",
+		      __inode_version(advise), vi->nid);
+		DBG_BUGON(1);
+		return -EIO;
+	}
+
+	if (!nblks)
+		/* measure inode.i_blocks as generic filesystems */
+		inode->i_blocks = roundup(inode->i_size, EROFS_BLKSIZ) >> 9;
+	else
+		inode->i_blocks = nblks << LOG_SECTORS_PER_BLOCK;
+	return 0;
+}
+
+/*
+ * try_lock can be required since locking order is:
+ *   file data(fs_inode)
+ *        meta(bd_inode)
+ * but the majority of the callers is "iget",
+ * in that case we are pretty sure no deadlock since
+ * no data operations exist. However I tend to
+ * try_lock since it takes no much overhead and
+ * will success immediately.
+ */
+static int fill_inline_data(struct inode *inode, void *data,
+			    unsigned int m_pofs)
+{
+	struct erofs_vnode *vi = EROFS_V(inode);
+	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
+
+	/* should be inode inline C */
+	if (!is_inode_flat_inline(inode))
+		return 0;
+
+	/* fast symlink (following ext4) */
+	if (S_ISLNK(inode->i_mode) && inode->i_size < PAGE_SIZE) {
+		char *lnk = erofs_kmalloc(sbi, inode->i_size + 1, GFP_KERNEL);
+
+		if (unlikely(!lnk))
+			return -ENOMEM;
+
+		m_pofs += vi->inode_isize + vi->xattr_isize;
+
+		/* inline symlink data shouldn't across page boundary as well */
+		if (unlikely(m_pofs + inode->i_size > PAGE_SIZE)) {
+			DBG_BUGON(1);
+			kfree(lnk);
+			return -EIO;
+		}
+
+		/* get in-page inline data */
+		memcpy(lnk, data + m_pofs, inode->i_size);
+		lnk[inode->i_size] = '\0';
+
+		inode->i_link = lnk;
+		set_inode_fast_symlink(inode);
+	}
+	return 0;
+}
+
+static int fill_inode(struct inode *inode, int isdir)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
+	struct erofs_vnode *vi = EROFS_V(inode);
+	struct page *page;
+	void *data;
+	int err;
+	erofs_blk_t blkaddr;
+	unsigned int ofs;
+
+	trace_erofs_fill_inode(inode, isdir);
+
+	blkaddr = erofs_blknr(iloc(sbi, vi->nid));
+	ofs = erofs_blkoff(iloc(sbi, vi->nid));
+
+	debugln("%s, reading inode nid %llu at %u of blkaddr %u",
+		__func__, vi->nid, ofs, blkaddr);
+
+	page = erofs_get_meta_page(inode->i_sb, blkaddr, isdir);
+
+	if (IS_ERR(page)) {
+		errln("failed to get inode (nid: %llu) page, err %ld",
+		      vi->nid, PTR_ERR(page));
+		return PTR_ERR(page);
+	}
+
+	DBG_BUGON(!PageUptodate(page));
+	data = page_address(page);
+
+	err = read_inode(inode, data + ofs);
+	if (!err) {
+		/* setup the new inode */
+		if (S_ISREG(inode->i_mode)) {
+			inode->i_op = &erofs_generic_iops;
+			inode->i_fop = &generic_ro_fops;
+		} else if (S_ISDIR(inode->i_mode)) {
+			inode->i_op = &erofs_dir_iops;
+			inode->i_fop = &erofs_dir_fops;
+		} else if (S_ISLNK(inode->i_mode)) {
+			/* by default, page_get_link is used for symlink */
+			inode->i_op = &erofs_symlink_iops;
+			inode_nohighmem(inode);
+		} else {
+			err = -EIO;
+			goto out_unlock;
+		}
+
+		if (is_inode_layout_compression(inode)) {
+			err = -ENOTSUPP;
+			goto out_unlock;
+		}
+
+		inode->i_mapping->a_ops = &erofs_raw_access_aops;
+
+		/* fill last page if inline data is available */
+		err = fill_inline_data(inode, data, ofs);
+	}
+
+out_unlock:
+	unlock_page(page);
+	put_page(page);
+	return err;
+}
+
+/*
+ * erofs nid is 64bits, but i_ino is 'unsigned long', therefore
+ * we should do more for 32-bit platform to find the right inode.
+ */
+#if BITS_PER_LONG == 32
+static int erofs_ilookup_test_actor(struct inode *inode, void *opaque)
+{
+	const erofs_nid_t nid = *(erofs_nid_t *)opaque;
+
+	return EROFS_V(inode)->nid == nid;
+}
+
+static int erofs_iget_set_actor(struct inode *inode, void *opaque)
+{
+	const erofs_nid_t nid = *(erofs_nid_t *)opaque;
+
+	inode->i_ino = erofs_inode_hash(nid);
+	return 0;
+}
+#endif
+
+static inline struct inode *erofs_iget_locked(struct super_block *sb,
+					      erofs_nid_t nid)
+{
+	const unsigned long hashval = erofs_inode_hash(nid);
+
+#if BITS_PER_LONG >= 64
+	/* it is safe to use iget_locked for >= 64-bit platform */
+	return iget_locked(sb, hashval);
+#else
+	return iget5_locked(sb, hashval, erofs_ilookup_test_actor,
+		erofs_iget_set_actor, &nid);
+#endif
+}
+
+struct inode *erofs_iget(struct super_block *sb,
+			 erofs_nid_t nid,
+			 bool isdir)
+{
+	struct inode *inode = erofs_iget_locked(sb, nid);
+
+	if (unlikely(!inode))
+		return ERR_PTR(-ENOMEM);
+
+	if (inode->i_state & I_NEW) {
+		int err;
+		struct erofs_vnode *vi = EROFS_V(inode);
+
+		vi->nid = nid;
+
+		err = fill_inode(inode, isdir);
+		if (likely(!err))
+			unlock_new_inode(inode);
+		else {
+			iget_failed(inode);
+			inode = ERR_PTR(err);
+		}
+	}
+	return inode;
+}
+
+int erofs_getattr(const struct path *path, struct kstat *stat,
+		  u32 request_mask, unsigned int query_flags)
+{
+	struct inode *const inode = d_inode(path->dentry);
+
+	if (is_inode_layout_compression(inode))
+		stat->attributes |= STATX_ATTR_COMPRESSED;
+
+	stat->attributes |= STATX_ATTR_IMMUTABLE;
+	stat->attributes_mask |= (STATX_ATTR_COMPRESSED |
+				  STATX_ATTR_IMMUTABLE);
+
+	generic_fillattr(inode, stat);
+	return 0;
+}
+
+const struct inode_operations erofs_generic_iops = {
+	.getattr = erofs_getattr,
+};
+
+const struct inode_operations erofs_symlink_iops = {
+	.get_link = page_get_link,
+	.getattr = erofs_getattr,
+};
+
+const struct inode_operations erofs_fast_symlink_iops = {
+	.get_link = simple_get_link,
+	.getattr = erofs_getattr,
+};
+
-- 
2.17.1

