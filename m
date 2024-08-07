Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E5E94B023
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Aug 2024 20:57:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1723057064;
	bh=inVH6cGCG9leAcUfpg+fe4bxN3p/3js3P8aX+p8JOok=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=cjaoPKffHB5lhVRDl2xjh+JKLBW4GWZFbfOY/dVj2oipLYxH3LccLhlkyXEXBd++Y
	 y3fl6SEHrnYCKZTYm4C54VrcwUQPKIdjO3hjDNsn2cndKrCr+1aPo+/bLvJco4m/Gq
	 HfGQdKWno5OGPeP+gABRXwtVXEPdzGnwKg7hg5WAj6j6aGTXiE/mHRq9vaBVl4knb7
	 zEB5jwBvD4ufTW21CCaI4hbmUaeFuhVOR11FIIvqqJXSCU9T5BjaTrcML1ZioLuL8P
	 6F62lJEt08ZIAspMw1cXLnFR37cOWYA/jcqfCCqxTvB3k1n/oV+OciwtcU1KRxme3B
	 Ag8Jhhx3srt1Q==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WfKDm07M5z3d8M
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Aug 2024 04:57:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=gkpdG4ZA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WfKDV3DVrz3bhD
	for <linux-erofs@lists.ozlabs.org>; Thu,  8 Aug 2024 04:57:30 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E87A868E59;
	Wed,  7 Aug 2024 14:47:36 -0400 (EDT)
To: hsiangkao@linux.alibaba.com
Subject: [RFC PATCH 3/3] erofs: add rust options
Date: Thu,  8 Aug 2024 02:47:03 +0800
Message-ID: <20240807184703.722206-4-toolmanp@tlmp.cc>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807184703.722206-1-toolmanp@tlmp.cc>
References: <20240807184703.722206-1-toolmanp@tlmp.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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
From: Yiyang Wu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Yiyang Wu <toolmanp@tlmp.cc>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This commit adds rust option in Kconfig. Note that currently when enabling
rust support, all extended features are disabled only basic operations
are supported.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/Kconfig    |  11 +++
 fs/erofs/Makefile   |   1 +
 fs/erofs/data.c     |  83 +++++++++++++----
 fs/erofs/dir.c      |  20 +++-
 fs/erofs/inode.c    |  51 ++++++----
 fs/erofs/internal.h |   3 +
 fs/erofs/namei.c    |  30 ++++--
 fs/erofs/super.c    | 223 ++++++++++++++++++++++++++++++++------------
 8 files changed, 312 insertions(+), 110 deletions(-)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 7dcdce660cac..46702df0b3d8 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -158,3 +158,14 @@ config EROFS_FS_PCPU_KTHREAD_HIPRI
 	  at higher priority.
 
 	  If unsure, say N.
+
+config EROFS_FS_RUST
+	bool "EROFS use RUST Replacement (EXPERIMENTAL)"
+	depends on EROFS_FS && RUST && !EROFS_FS_ZIP && !EROFS_FS_ONDEMAND && !EROFS_FS_XATTR
+	default n
+	help
+	  This permits EROFS to use EXPERIMENTAL rust implementation for
+	  EROFS. This is highly unstable and buggy and should be considered
+	  as an experimental feature only.
+
+	  IF SURE, say Y.
diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index 097d672e6b14..a6e4f7f4d570 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -8,3 +8,4 @@ erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
 erofs-$(CONFIG_EROFS_FS_ZIP_DEFLATE) += decompressor_deflate.o
 erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
 erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
+erofs-$(CONFIG_EROFS_FS_RUST) += erofs_rust_helper.o erofs_rust.o
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 1b7eba38ba1e..b45660112fd9 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -4,6 +4,10 @@
  *             https://www.huawei.com/
  * Copyright (C) 2021, Alibaba Cloud
  */
+
+#ifdef CONFIG_EROFS_FS_RUST
+#include "erofs_rust_bindings.h"
+#endif
 #include "internal.h"
 #include <linux/sched/mm.h>
 #include <trace/events/erofs.h>
@@ -189,6 +193,8 @@ int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
 	return err;
 }
 
+#ifndef CONFIG_EROFS_FS_RUST
+
 int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 {
 	struct erofs_dev_context *devs = EROFS_SB(sb)->devs;
@@ -230,8 +236,10 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 			if (map->m_pa >= startoff &&
 			    map->m_pa < startoff + length) {
 				map->m_pa -= startoff;
-				map->m_bdev = dif->bdev_file ?
-					      file_bdev(dif->bdev_file) : NULL;
+				map->m_bdev =
+					dif->bdev_file ?
+						file_bdev(dif->bdev_file) :
+						NULL;
 				map->m_daxdev = dif->dax_dev;
 				map->m_dax_part_off = dif->dax_part_off;
 				map->m_fscache = dif->fscache;
@@ -244,7 +252,8 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 }
 
 static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
-		unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
+			     unsigned int flags, struct iomap *iomap,
+			     struct iomap *srcmap)
 {
 	int ret;
 	struct super_block *sb = inode->i_sb;
@@ -258,7 +267,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	if (ret < 0)
 		return ret;
 
-	mdev = (struct erofs_map_dev) {
+	mdev = (struct erofs_map_dev){
 		.m_deviceid = map.m_deviceid,
 		.m_pa = map.m_pa,
 	};
@@ -303,7 +312,8 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 }
 
 static int erofs_iomap_end(struct inode *inode, loff_t pos, loff_t length,
-		ssize_t written, unsigned int flags, struct iomap *iomap)
+			   ssize_t written, unsigned int flags,
+			   struct iomap *iomap)
 {
 	void *ptr = iomap->private;
 
@@ -322,6 +332,45 @@ static int erofs_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	return written;
 }
 
+#else
+
+static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
+			     unsigned int flags, struct iomap *iomap,
+			     struct iomap *srcmap)
+{
+	struct erofs_rust_map m;
+	m.m_la = offset;
+	erofs_iomap_begin_rust(inode, &m);
+
+	iomap->bdev = inode->i_sb->s_bdev;
+	iomap->flags = 0;
+	iomap->offset = m.m_la;
+	iomap->length = m.m_llen;
+
+	if (m.inline_data != NULL) {
+		iomap->type = IOMAP_INLINE;
+		iomap->inline_data = m.inline_data;
+		iomap->private = m.private;
+	} else {
+		iomap->type = IOMAP_MAPPED;
+		iomap->addr = m.m_pa;
+		iomap->private = NULL;
+	}
+	return 0;
+}
+
+static int erofs_iomap_end(struct inode *inode, loff_t pos, loff_t length,
+			   ssize_t written, unsigned int flags,
+			   struct iomap *iomap)
+{
+	struct erofs_rust_map m = {
+		.private = iomap->private,
+	};
+	erofs_iomap_end_rust(&m);
+	return written;
+}
+#endif
+
 static const struct iomap_ops erofs_iomap_ops = {
 	.iomap_begin = erofs_iomap_begin,
 	.iomap_end = erofs_iomap_end,
@@ -382,11 +431,12 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			blksize_mask = i_blocksize(inode) - 1;
 
 		if ((iocb->ki_pos | iov_iter_count(to) |
-		     iov_iter_alignment(to)) & blksize_mask)
+		     iov_iter_alignment(to)) &
+		    blksize_mask)
 			return -EINVAL;
 
-		return iomap_dio_rw(iocb, to, &erofs_iomap_ops,
-				    NULL, 0, NULL, 0);
+		return iomap_dio_rw(iocb, to, &erofs_iomap_ops, NULL, 0, NULL,
+				    0);
 	}
 	return filemap_read(iocb, to, 0);
 }
@@ -402,8 +452,7 @@ const struct address_space_operations erofs_raw_access_aops = {
 };
 
 #ifdef CONFIG_FS_DAX
-static vm_fault_t erofs_dax_huge_fault(struct vm_fault *vmf,
-		unsigned int order)
+static vm_fault_t erofs_dax_huge_fault(struct vm_fault *vmf, unsigned int order)
 {
 	return dax_iomap_fault(vmf, order, NULL, NULL, &erofs_iomap_ops);
 }
@@ -414,8 +463,8 @@ static vm_fault_t erofs_dax_fault(struct vm_fault *vmf)
 }
 
 static const struct vm_operations_struct erofs_dax_vm_ops = {
-	.fault		= erofs_dax_fault,
-	.huge_fault	= erofs_dax_huge_fault,
+	.fault = erofs_dax_fault,
+	.huge_fault = erofs_dax_huge_fault,
 };
 
 static int erofs_file_mmap(struct file *file, struct vm_area_struct *vma)
@@ -431,13 +480,13 @@ static int erofs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	return 0;
 }
 #else
-#define erofs_file_mmap	generic_file_readonly_mmap
+#define erofs_file_mmap generic_file_readonly_mmap
 #endif
 
 const struct file_operations erofs_file_fops = {
-	.llseek		= generic_file_llseek,
-	.read_iter	= erofs_file_read_iter,
-	.mmap		= erofs_file_mmap,
+	.llseek = generic_file_llseek,
+	.read_iter = erofs_file_read_iter,
+	.mmap = erofs_file_mmap,
 	.get_unmapped_area = thp_get_unmapped_area,
-	.splice_read	= filemap_splice_read,
+	.splice_read = filemap_splice_read,
 };
diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index c3b90abdee37..b91e26181f5b 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -4,8 +4,15 @@
  *             https://www.huawei.com/
  * Copyright (C) 2022, Alibaba Cloud
  */
+
+#ifdef CONFIG_EROFS_FS_RUST
+#include "erofs_rust_bindings.h"
+#endif
+
 #include "internal.h"
 
+#ifndef CONFIG_EROFS_FS_RUST
+
 static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
 			       void *dentry_blk, struct erofs_dirent *de,
 			       unsigned int nameoff0, unsigned int maxsize)
@@ -93,8 +100,15 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 	return err < 0 ? err : 0;
 }
 
+#endif
+
 const struct file_operations erofs_dir_fops = {
-	.llseek		= generic_file_llseek,
-	.read		= generic_read_dir,
-	.iterate_shared	= erofs_readdir,
+	.llseek = generic_file_llseek,
+	.read = generic_read_dir,
+#ifdef CONFIG_EROFS_FS_RUST
+	.iterate_shared = erofs_readdir_rust,
+#else
+
+	.iterate_shared = erofs_readdir,
+#endif
 };
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 43c09aae2afc..22a9b5b24c31 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -8,8 +8,8 @@
 
 #include <trace/events/erofs.h>
 
-static void *erofs_read_inode(struct erofs_buf *buf,
-			      struct inode *inode, unsigned int *ofs)
+static void *erofs_read_inode(struct erofs_buf *buf, struct inode *inode,
+			      unsigned int *ofs)
 {
 	struct super_block *sb = inode->i_sb;
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
@@ -36,8 +36,8 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 	dic = kaddr + *ofs;
 	ifmt = le16_to_cpu(dic->i_format);
 	if (ifmt & ~EROFS_I_ALL) {
-		erofs_err(sb, "unsupported i_format %u of nid %llu",
-			  ifmt, vi->nid);
+		erofs_err(sb, "unsupported i_format %u of nid %llu", ifmt,
+			  vi->nid);
 		err = -EOPNOTSUPP;
 		goto err_out;
 	}
@@ -66,11 +66,14 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 				goto err_out;
 			}
 			memcpy(copied, dic, gotten);
-			kaddr = erofs_read_metabuf(buf, sb, erofs_pos(sb, blkaddr + 1),
+			kaddr = erofs_read_metabuf(buf, sb,
+						   erofs_pos(sb, blkaddr + 1),
 						   EROFS_KMAP);
 			if (IS_ERR(kaddr)) {
-				erofs_err(sb, "failed to get inode payload block (nid: %llu), err %ld",
-					  vi->nid, PTR_ERR(kaddr));
+				erofs_err(
+					sb,
+					"failed to get inode payload block (nid: %llu), err %ld",
+					vi->nid, PTR_ERR(kaddr));
 				kfree(copied);
 				return kaddr;
 			}
@@ -105,11 +108,11 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 		set_nlink(inode, le16_to_cpu(dic->i_nlink));
 		/* use build time for compact inodes */
 		inode_set_ctime(inode, sbi->build_time, sbi->build_time_nsec);
-
 		inode->i_size = le32_to_cpu(dic->i_size);
 		break;
 	default:
-		erofs_err(sb, "unsupported on-disk inode version %u of nid %llu",
+		erofs_err(sb,
+			  "unsupported on-disk inode version %u of nid %llu",
 			  erofs_inode_version(ifmt), vi->nid);
 		err = -EOPNOTSUPP;
 		goto err_out;
@@ -148,11 +151,12 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 			err = -EOPNOTSUPP;
 			goto err_out;
 		}
-		vi->chunkbits = sb->s_blocksize_bits +
+		vi->chunkbits =
+			sb->s_blocksize_bits +
 			(vi->chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
 	}
-	inode_set_mtime_to_ts(inode,
-			      inode_set_atime_to_ts(inode, inode_get_ctime(inode)));
+	inode_set_mtime_to_ts(
+		inode, inode_set_atime_to_ts(inode, inode_get_ctime(inode)));
 
 	inode->i_flags &= ~S_DAX;
 	if (test_opt(&sbi->opt, DAX_ALWAYS) && S_ISREG(inode->i_mode) &&
@@ -182,8 +186,8 @@ static int erofs_fill_symlink(struct inode *inode, void *kaddr,
 	char *lnk;
 
 	/* if it cannot be handled with fast symlink scheme */
-	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
-	    inode->i_size >= bsz || inode->i_size < 0) {
+	if (vi->datalayout != EROFS_INODE_FLAT_INLINE || inode->i_size >= bsz ||
+	    inode->i_size < 0) {
 		inode->i_op = &erofs_symlink_iops;
 		return 0;
 	}
@@ -226,6 +230,7 @@ static int erofs_fill_inode(struct inode *inode)
 		return PTR_ERR(kaddr);
 
 	/* setup the new inode */
+
 	switch (inode->i_mode & S_IFMT) {
 	case S_IFREG:
 		inode->i_op = &erofs_generic_iops;
@@ -259,9 +264,9 @@ static int erofs_fill_inode(struct inode *inode)
 
 	if (erofs_inode_is_data_compressed(vi->datalayout)) {
 #ifdef CONFIG_EROFS_FS_ZIP
-		DO_ONCE_LITE_IF(inode->i_blkbits != PAGE_SHIFT,
-			  erofs_info, inode->i_sb,
-			  "EXPERIMENTAL EROFS subpage compressed block support in use. Use at your own risk!");
+		DO_ONCE_LITE_IF(
+			inode->i_blkbits != PAGE_SHIFT, erofs_info, inode->i_sb,
+			"EXPERIMENTAL EROFS subpage compressed block support in use. Use at your own risk!");
 		inode->i_mapping->a_ops = &z_erofs_aops;
 		err = 0;
 		goto out_unlock;
@@ -334,14 +339,14 @@ int erofs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		  unsigned int query_flags)
 {
 	struct inode *const inode = d_inode(path->dentry);
+#ifndef CONFIG_EROFS_FS_RUST
 	bool compressed =
 		erofs_inode_is_data_compressed(EROFS_I(inode)->datalayout);
 
 	if (compressed)
 		stat->attributes |= STATX_ATTR_COMPRESSED;
 	stat->attributes |= STATX_ATTR_IMMUTABLE;
-	stat->attributes_mask |= (STATX_ATTR_COMPRESSED |
-				  STATX_ATTR_IMMUTABLE);
+	stat->attributes_mask |= (STATX_ATTR_COMPRESSED | STATX_ATTR_IMMUTABLE);
 
 	/*
 	 * Return the DIO alignment restrictions if requested.
@@ -357,27 +362,35 @@ int erofs_getattr(struct mnt_idmap *idmap, const struct path *path,
 			stat->dio_offset_align = stat->dio_mem_align;
 		}
 	}
+
+#endif
 	generic_fillattr(idmap, request_mask, inode, stat);
 	return 0;
 }
 
 const struct inode_operations erofs_generic_iops = {
 	.getattr = erofs_getattr,
+#ifndef CONFIG_EROFS_FS_RUST
 	.listxattr = erofs_listxattr,
 	.get_inode_acl = erofs_get_acl,
+#endif
 	.fiemap = erofs_fiemap,
 };
 
 const struct inode_operations erofs_symlink_iops = {
 	.get_link = page_get_link,
 	.getattr = erofs_getattr,
+#ifndef CONFIG_EROFS_FS_RUST
 	.listxattr = erofs_listxattr,
 	.get_inode_acl = erofs_get_acl,
+#endif
 };
 
 const struct inode_operations erofs_fast_symlink_iops = {
 	.get_link = simple_get_link,
 	.getattr = erofs_getattr,
+#ifndef CONFIG_EROFS_FS_RUST
 	.listxattr = erofs_listxattr,
 	.get_inode_acl = erofs_get_acl,
+#endif
 };
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 45dc15ebd870..aa48f8abc724 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -19,6 +19,9 @@
 #include <linux/vmalloc.h>
 #include <linux/iomap.h>
 #include "erofs_fs.h"
+#ifdef CONFIG_EROFS_FS_RUST
+#include "erofs_rust_bindings.h"
+#endif
 
 /* redefine pr_fmt "erofs: " */
 #undef pr_fmt
diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
index c94d0c1608a8..12fd429adad4 100644
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -4,6 +4,7 @@
  *             https://www.huawei.com/
  * Copyright (C) 2022, Alibaba Cloud
  */
+
 #include "xattr.h"
 #include <trace/events/erofs.h>
 
@@ -40,7 +41,7 @@ static inline int erofs_dirnamecmp(const struct erofs_qstr *qn,
 	return qn->name[i] == '\0' ? 0 : 1;
 }
 
-#define nameoff_from_disk(off, sz)	(le16_to_cpu(off) & ((sz) - 1))
+#define nameoff_from_disk(off, sz) (le16_to_cpu(off) & ((sz) - 1))
 
 static struct erofs_dirent *find_target_dirent(struct erofs_qstr *name,
 					       u8 *data,
@@ -58,15 +59,16 @@ static struct erofs_dirent *find_target_dirent(struct erofs_qstr *name,
 
 	while (head <= back) {
 		const int mid = head + (back - head) / 2;
-		const int nameoff = nameoff_from_disk(de[mid].nameoff,
-						      dirblksize);
+		const int nameoff =
+			nameoff_from_disk(de[mid].nameoff, dirblksize);
 		unsigned int matched = min(startprfx, endprfx);
 		struct erofs_qstr dname = {
 			.name = data + nameoff,
 			.end = mid >= ndirents - 1 ?
-				data + dirblksize :
-				data + nameoff_from_disk(de[mid + 1].nameoff,
-							 dirblksize)
+				       data + dirblksize :
+				       data + nameoff_from_disk(
+						      de[mid + 1].nameoff,
+						      dirblksize)
 		};
 
 		/* string comparison without already matched prefix */
@@ -87,7 +89,8 @@ static struct erofs_dirent *find_target_dirent(struct erofs_qstr *name,
 }
 
 static void *erofs_find_target_block(struct erofs_buf *target,
-		struct inode *dir, struct erofs_qstr *name, int *_ndirents)
+				     struct inode *dir, struct erofs_qstr *name,
+				     int *_ndirents)
 {
 	unsigned int bsz = i_blocksize(dir);
 	int head = 0, back = erofs_iblks(dir) - 1;
@@ -124,7 +127,8 @@ static void *erofs_find_target_block(struct erofs_buf *target,
 			if (ndirents == 1)
 				dname.end = (u8 *)de + bsz;
 			else
-				dname.end = (u8 *)de +
+				dname.end =
+					(u8 *)de +
 					nameoff_from_disk(de[1].nameoff, bsz);
 
 			/* string comparison without already matched prefix */
@@ -150,7 +154,7 @@ static void *erofs_find_target_block(struct erofs_buf *target,
 			*_ndirents = ndirents;
 			continue;
 		}
-out:		/* free if the candidate is valid */
+out: /* free if the candidate is valid */
 		if (!IS_ERR(candidate))
 			erofs_put_metabuf(target);
 		return de;
@@ -190,6 +194,7 @@ int erofs_namei(struct inode *dir, const struct qstr *name, erofs_nid_t *nid,
 	return PTR_ERR_OR_ZERO(de);
 }
 
+#ifndef CONFIG_EROFS_FS_RUST
 static struct dentry *erofs_lookup(struct inode *dir, struct dentry *dentry,
 				   unsigned int flags)
 {
@@ -214,11 +219,16 @@ static struct dentry *erofs_lookup(struct inode *dir, struct dentry *dentry,
 		inode = erofs_iget(dir->i_sb, nid);
 	return d_splice_alias(inode, dentry);
 }
+#endif
 
 const struct inode_operations erofs_dir_iops = {
-	.lookup = erofs_lookup,
 	.getattr = erofs_getattr,
+#ifdef CONFIG_EROFS_FS_RUST
+	.lookup = erofs_lookup_rust,
+#else
 	.listxattr = erofs_listxattr,
 	.get_inode_acl = erofs_get_acl,
+	.lookup = erofs_lookup,
+#endif
 	.fiemap = erofs_fiemap,
 };
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 6cb5c8916174..f6963e31d516 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -4,6 +4,7 @@
  *             https://www.huawei.com/
  * Copyright (C) 2021, Alibaba Cloud
  */
+#include "erofs_rust_bindings.h"
 #include <linux/statfs.h>
 #include <linux/seq_file.h>
 #include <linux/crc32c.h>
@@ -51,6 +52,7 @@ void _erofs_info(struct super_block *sb, const char *func, const char *fmt, ...)
 	va_end(args);
 }
 
+#ifndef CONFIG_EROFS_FS_RUST
 static int erofs_superblock_csum_verify(struct super_block *sb, void *sbdata)
 {
 	size_t len = 1 << EROFS_SB(sb)->blkszbits;
@@ -71,8 +73,8 @@ static int erofs_superblock_csum_verify(struct super_block *sb, void *sbdata)
 	kfree(dsb);
 
 	if (crc != expected_crc) {
-		erofs_err(sb, "invalid checksum 0x%08x, 0x%08x expected",
-			  crc, expected_crc);
+		erofs_err(sb, "invalid checksum 0x%08x, 0x%08x expected", crc,
+			  expected_crc);
 		return -EBADMSG;
 	}
 	return 0;
@@ -85,27 +87,35 @@ static void erofs_inode_init_once(void *ptr)
 	inode_init_once(&vi->vfs_inode);
 }
 
+#endif
+
 static struct inode *erofs_alloc_inode(struct super_block *sb)
 {
-	struct erofs_inode *vi =
-		alloc_inode_sb(sb, erofs_inode_cachep, GFP_KERNEL);
+	void *vi = alloc_inode_sb(sb, erofs_inode_cachep, GFP_KERNEL);
 
 	if (!vi)
 		return NULL;
 
-	/* zero out everything except vfs_inode */
+		/* zero out everything except vfs_inode */
+#ifdef CONFIG_EROFS_FS_RUST
+	return (struct inode *)(vi + EROFS_INODE_OFFSET);
+#else
 	memset(vi, 0, offsetof(struct erofs_inode, vfs_inode));
-	return &vi->vfs_inode;
+	return &((struct erofs_inode *)vi)->vfs_inode;
+#endif
 }
 
 static void erofs_free_inode(struct inode *inode)
 {
-	struct erofs_inode *vi = EROFS_I(inode);
-
 	if (inode->i_op == &erofs_fast_symlink_iops)
 		kfree(inode->i_link);
+#ifndef CONFIG_EROFS_FS_RUST
+	struct erofs_inode *vi = EROFS_I(inode);
 	kfree(vi->xattr_shared_xattrs);
 	kmem_cache_free(erofs_inode_cachep, vi);
+#else
+	kmem_cache_free(erofs_inode_cachep, (void *)inode - EROFS_INODE_OFFSET);
+#endif
 }
 
 /* read variable-sized metadata, offset will be aligned by 4-byte */
@@ -143,6 +153,8 @@ void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
 	return buffer;
 }
 
+#ifndef CONFIG_EROFS_FS_RUST
+
 #ifndef CONFIG_EROFS_FS_ZIP
 static int z_erofs_parse_cfgs(struct super_block *sb,
 			      struct erofs_super_block *dsb)
@@ -184,12 +196,12 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 		dif->fscache = fscache;
 	} else if (!sbi->devs->flatdev) {
 		bdev_file = bdev_file_open_by_path(dif->path, BLK_OPEN_READ,
-						sb->s_type, NULL);
+						   sb->s_type, NULL);
 		if (IS_ERR(bdev_file))
 			return PTR_ERR(bdev_file);
 		dif->bdev_file = bdev_file;
-		dif->dax_dev = fs_dax_get_by_bdev(file_bdev(bdev_file),
-				&dif->dax_part_off, NULL, NULL);
+		dif->dax_dev = fs_dax_get_by_bdev(
+			file_bdev(bdev_file), &dif->dax_part_off, NULL, NULL);
 	}
 
 	dif->blocks = le32_to_cpu(dis->blocks);
@@ -244,7 +256,8 @@ static int erofs_scan_devices(struct super_block *sb,
 				break;
 			}
 
-			err = idr_alloc(&sbi->devs->tree, dif, 0, 0, GFP_KERNEL);
+			err = idr_alloc(&sbi->devs->tree, dif, 0, 0,
+					GFP_KERNEL);
 			if (err < 0) {
 				kfree(dif);
 				break;
@@ -282,7 +295,7 @@ static int erofs_read_superblock(struct super_block *sb)
 		goto out;
 	}
 
-	sbi->blkszbits  = dsb->blkszbits;
+	sbi->blkszbits = dsb->blkszbits;
 	if (sbi->blkszbits < 9 || sbi->blkszbits > PAGE_SHIFT) {
 		erofs_err(sb, "blkszbits %u isn't supported", sbi->blkszbits);
 		goto out;
@@ -333,7 +346,7 @@ static int erofs_read_superblock(struct super_block *sb)
 
 	ret = strscpy(sbi->volume_name, dsb->volume_name,
 		      sizeof(dsb->volume_name));
-	if (ret < 0) {	/* -E2BIG */
+	if (ret < 0) { /* -E2BIG */
 		erofs_err(sb, "bad volume name without NIL terminator");
 		ret = -EFSCORRUPTED;
 		goto out;
@@ -348,7 +361,9 @@ static int erofs_read_superblock(struct super_block *sb)
 	ret = erofs_scan_devices(sb, dsb);
 
 	if (erofs_is_fscache_mode(sb))
-		erofs_info(sb, "EXPERIMENTAL fscache-based on-demand read feature in use. Use at your own risk!");
+		erofs_info(
+			sb,
+			"EXPERIMENTAL fscache-based on-demand read feature in use. Use at your own risk!");
 out:
 	erofs_put_metabuf(&buf);
 	return ret;
@@ -369,6 +384,8 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
 #endif
 }
 
+#endif
+
 enum {
 	Opt_user_xattr,
 	Opt_acl,
@@ -382,31 +399,32 @@ enum {
 };
 
 static const struct constant_table erofs_param_cache_strategy[] = {
-	{"disabled",	EROFS_ZIP_CACHE_DISABLED},
-	{"readahead",	EROFS_ZIP_CACHE_READAHEAD},
-	{"readaround",	EROFS_ZIP_CACHE_READAROUND},
+	{ "disabled", EROFS_ZIP_CACHE_DISABLED },
+	{ "readahead", EROFS_ZIP_CACHE_READAHEAD },
+	{ "readaround", EROFS_ZIP_CACHE_READAROUND },
 	{}
 };
 
 static const struct constant_table erofs_dax_param_enums[] = {
-	{"always",	EROFS_MOUNT_DAX_ALWAYS},
-	{"never",	EROFS_MOUNT_DAX_NEVER},
+	{ "always", EROFS_MOUNT_DAX_ALWAYS },
+	{ "never", EROFS_MOUNT_DAX_NEVER },
 	{}
 };
 
 static const struct fs_parameter_spec erofs_fs_parameters[] = {
-	fsparam_flag_no("user_xattr",	Opt_user_xattr),
-	fsparam_flag_no("acl",		Opt_acl),
-	fsparam_enum("cache_strategy",	Opt_cache_strategy,
+	fsparam_flag_no("user_xattr", Opt_user_xattr),
+	fsparam_flag_no("acl", Opt_acl),
+	fsparam_enum("cache_strategy", Opt_cache_strategy,
 		     erofs_param_cache_strategy),
-	fsparam_flag("dax",             Opt_dax),
-	fsparam_enum("dax",		Opt_dax_enum, erofs_dax_param_enums),
-	fsparam_string("device",	Opt_device),
-	fsparam_string("fsid",		Opt_fsid),
-	fsparam_string("domain_id",	Opt_domain_id),
+	fsparam_flag("dax", Opt_dax),
+	fsparam_enum("dax", Opt_dax_enum, erofs_dax_param_enums),
+	fsparam_string("device", Opt_device),
+	fsparam_string("fsid", Opt_fsid),
+	fsparam_string("domain_id", Opt_domain_id),
 	{}
 };
 
+#ifndef CONFIG_EROFS_FS_RUST
 static bool erofs_fc_set_dax_mode(struct fs_context *fc, unsigned int mode)
 {
 #ifdef CONFIG_FS_DAX
@@ -431,19 +449,25 @@ static bool erofs_fc_set_dax_mode(struct fs_context *fc, unsigned int mode)
 #endif
 }
 
+#endif
+
 static int erofs_fc_parse_param(struct fs_context *fc,
 				struct fs_parameter *param)
 {
+#ifndef CONFIG_EROFS_FS_RUST
+
 	struct erofs_sb_info *sbi = fc->s_fs_info;
-	struct fs_parse_result result;
 	struct erofs_device_info *dif;
-	int opt, ret;
+#endif
 
+	struct fs_parse_result result;
+	int opt, ret;
 	opt = fs_parse(fc, erofs_fs_parameters, param, &result);
 	if (opt < 0)
 		return opt;
-
 	switch (opt) {
+#ifndef CONFIG_EROFS_FS_RUST
+
 	case Opt_user_xattr:
 #ifdef CONFIG_EROFS_FS_XATTR
 		if (result.boolean)
@@ -468,7 +492,8 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 #ifdef CONFIG_EROFS_FS_ZIP
 		sbi->opt.cache_strategy = result.uint_32;
 #else
-		errorfc(fc, "compression not supported, cache_strategy ignored");
+		errorfc(fc,
+			"compression not supported, cache_strategy ignored");
 #endif
 		break;
 	case Opt_dax:
@@ -514,35 +539,51 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 #else
 	case Opt_fsid:
 	case Opt_domain_id:
-		errorfc(fc, "%s option not supported", erofs_fs_parameters[opt].name);
+		errorfc(fc, "%s option not supported",
+			erofs_fs_parameters[opt].name);
 		break;
+
+	default:
+
 #endif
+#else
 	default:
+		(void)ret;
+#endif
 		return -ENOPARAM;
 	}
 	return 0;
 }
 
-static struct inode *erofs_nfs_get_inode(struct super_block *sb,
-					 u64 ino, u32 generation)
+static struct inode *erofs_nfs_get_inode(struct super_block *sb, u64 ino,
+					 u32 generation)
 {
+#ifdef CONFIG_EROFS_FS_RUST
+	return erofs_iget_rust(sb, ino);
+#else
 	return erofs_iget(sb, ino);
+#endif
 }
 
 static struct dentry *erofs_fh_to_dentry(struct super_block *sb,
-		struct fid *fid, int fh_len, int fh_type)
+					 struct fid *fid, int fh_len,
+					 int fh_type)
 {
 	return generic_fh_to_dentry(sb, fid, fh_len, fh_type,
 				    erofs_nfs_get_inode);
 }
 
 static struct dentry *erofs_fh_to_parent(struct super_block *sb,
-		struct fid *fid, int fh_len, int fh_type)
+					 struct fid *fid, int fh_len,
+					 int fh_type)
 {
 	return generic_fh_to_parent(sb, fid, fh_len, fh_type,
 				    erofs_nfs_get_inode);
 }
 
+#ifdef CONFIG_EROFS_FS_RUST
+
+#else
 static struct dentry *erofs_get_parent(struct dentry *child)
 {
 	erofs_nid_t nid;
@@ -555,21 +596,29 @@ static struct dentry *erofs_get_parent(struct dentry *child)
 	return d_obtain_alias(erofs_iget(child->d_sb, nid));
 }
 
+#endif
+
 static const struct export_operations erofs_export_ops = {
 	.encode_fh = generic_encode_ino32_fh,
 	.fh_to_dentry = erofs_fh_to_dentry,
 	.fh_to_parent = erofs_fh_to_parent,
+#ifdef CONFIG_EROFS_FS_RUST
+	.get_parent = erofs_get_parent_rust,
+#else
 	.get_parent = erofs_get_parent,
+#endif
 };
 
+#ifndef CONFIG_EROFS_FS_RUST
+
 static void erofs_set_sysfs_name(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
 	if (erofs_is_fscache_mode(sb)) {
 		if (sbi->domain_id)
-			super_set_sysfs_name_generic(sb, "%s,%s",sbi->domain_id,
-						     sbi->fsid);
+			super_set_sysfs_name_generic(sb, "%s,%s",
+						     sbi->domain_id, sbi->fsid);
 		else
 			super_set_sysfs_name_generic(sb, "%s", sbi->fsid);
 		return;
@@ -606,9 +655,8 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 			return -EINVAL;
 		}
 
-		sbi->dax_dev = fs_dax_get_by_bdev(sb->s_bdev,
-						  &sbi->dax_part_off,
-						  NULL, NULL);
+		sbi->dax_dev = fs_dax_get_by_bdev(
+			sb->s_bdev, &sbi->dax_part_off, NULL, NULL);
 	}
 
 	err = erofs_read_superblock(sb);
@@ -628,7 +676,8 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	if (test_opt(&sbi->opt, DAX_ALWAYS)) {
 		if (!sbi->dax_dev) {
-			errorfc(fc, "DAX unsupported by block device. Turning off DAX.");
+			errorfc(fc,
+				"DAX unsupported by block device. Turning off DAX.");
 			clear_opt(&sbi->opt, DAX_ALWAYS);
 		} else if (sbi->blkszbits != PAGE_SHIFT) {
 			errorfc(fc, "unsupported blocksize for DAX");
@@ -679,6 +728,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 		return err;
 
 	err = erofs_xattr_prefixes_init(sb);
+
 	if (err)
 		return err;
 
@@ -690,18 +740,38 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	return 0;
 }
 
+#else
+static int erofs_fc_fill_super_rust(struct super_block *sb,
+				    struct fs_context *fc)
+{
+	sb->s_magic = EROFS_SUPER_MAGIC;
+	sb->s_flags |= SB_RDONLY | SB_NOATIME;
+	sb->s_maxbytes = MAX_LFS_FILESIZE;
+	sb->s_op = &erofs_sops;
+	sb->s_time_gran = 1;
+	sb->s_xattr = NULL;
+	sb->s_export_op = &erofs_export_ops;
+	sb->s_fs_info = erofs_alloc_sbi_rust(sb, sb->s_bdev->bd_mapping);
+	sb->s_root = erofs_make_root_rust(sb);
+	return 0;
+}
+#define erofs_fc_fill_super erofs_fc_fill_super_rust
+#endif
+
 static int erofs_fc_get_tree(struct fs_context *fc)
 {
+#ifndef CONFIG_EROFS_FS_RUST
 	struct erofs_sb_info *sbi = fc->s_fs_info;
-
 	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
 		return get_tree_nodev(fc, erofs_fc_fill_super);
+#endif
 
 	return get_tree_bdev(fc, erofs_fc_fill_super);
 }
 
 static int erofs_fc_reconfigure(struct fs_context *fc)
 {
+#ifndef CONFIG_EROFS_FS_RUST
 	struct super_block *sb = fc->root->d_sb;
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	struct erofs_sb_info *new_sbi = fc->s_fs_info;
@@ -718,10 +788,12 @@ static int erofs_fc_reconfigure(struct fs_context *fc)
 
 	sbi->opt = new_sbi->opt;
 
+#endif
 	fc->sb_flags |= SB_RDONLY;
 	return 0;
 }
 
+#ifndef CONFIG_EROFS_FS_RUST
 static int erofs_release_device_info(int id, void *ptr, void *data)
 {
 	struct erofs_device_info *dif = ptr;
@@ -758,15 +830,23 @@ static void erofs_fc_free(struct fs_context *fc)
 	kfree(sbi);
 }
 
+#else
+
+static void erofs_fc_free(struct fs_context *fc)
+{
+}
+
+#endif
 static const struct fs_context_operations erofs_context_ops = {
-	.parse_param	= erofs_fc_parse_param,
-	.get_tree       = erofs_fc_get_tree,
-	.reconfigure    = erofs_fc_reconfigure,
-	.free		= erofs_fc_free,
+	.parse_param = erofs_fc_parse_param,
+	.get_tree = erofs_fc_get_tree,
+	.reconfigure = erofs_fc_reconfigure,
+	.free = erofs_fc_free,
 };
 
 static int erofs_init_fs_context(struct fs_context *fc)
 {
+#ifndef CONFIG_EROFS_FS_RUST
 	struct erofs_sb_info *sbi;
 
 	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
@@ -783,12 +863,14 @@ static int erofs_init_fs_context(struct fs_context *fc)
 	idr_init(&sbi->devs->tree);
 	init_rwsem(&sbi->devs->rwsem);
 	erofs_default_options(sbi);
+#endif
 	fc->ops = &erofs_context_ops;
 	return 0;
 }
 
 static void erofs_kill_sb(struct super_block *sb)
 {
+#ifndef CONFIG_EROFS_FS_RUST
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
 	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
@@ -802,11 +884,15 @@ static void erofs_kill_sb(struct super_block *sb)
 	kfree(sbi->fsid);
 	kfree(sbi->domain_id);
 	kfree(sbi);
+#else
+	erofs_free_sbi_rust(sb);
 	sb->s_fs_info = NULL;
+#endif
 }
 
 static void erofs_put_super(struct super_block *sb)
 {
+#ifndef CONFIG_EROFS_FS_RUST
 	struct erofs_sb_info *const sbi = EROFS_SB(sb);
 
 	DBG_BUGON(!sbi);
@@ -823,14 +909,15 @@ static void erofs_put_super(struct super_block *sb)
 	erofs_free_dev_context(sbi->devs);
 	sbi->devs = NULL;
 	erofs_fscache_unregister_fs(sb);
+#endif
 }
 
 static struct file_system_type erofs_fs_type = {
-	.owner          = THIS_MODULE,
-	.name           = "erofs",
+	.owner = THIS_MODULE,
+	.name = "erofs",
 	.init_fs_context = erofs_init_fs_context,
-	.kill_sb        = erofs_kill_sb,
-	.fs_flags       = FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
+	.kill_sb = erofs_kill_sb,
+	.fs_flags = FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
 };
 MODULE_ALIAS_FS("erofs");
 
@@ -840,10 +927,17 @@ static int __init erofs_module_init(void)
 
 	erofs_check_ondisk_layout_definitions();
 
-	erofs_inode_cachep = kmem_cache_create("erofs_inode",
-			sizeof(struct erofs_inode), 0,
-			SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT,
-			erofs_inode_init_once);
+#ifdef CONFIG_EROFS_FS_RUST
+	erofs_inode_cachep =
+		kmem_cache_create("erofs_inode", EROFS_INODE_SIZE, 0,
+				  SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT,
+				  erofs_inode_init_once_rust);
+#else
+	erofs_inode_cachep = kmem_cache_create(
+		"erofs_inode", sizeof(struct erofs_inode), 0,
+		SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT, erofs_inode_init_once);
+#endif
+
 	if (!erofs_inode_cachep)
 		return -ENOMEM;
 
@@ -891,6 +985,7 @@ static void __exit erofs_module_exit(void)
 
 static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
+#ifndef CONFIG_EROFS_FS_RUST
 	struct super_block *sb = dentry->d_sb;
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
@@ -903,26 +998,31 @@ static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_namelen = EROFS_NAME_LEN;
 
 	if (uuid_is_null(&sb->s_uuid))
-		buf->f_fsid = u64_to_fsid(erofs_is_fscache_mode(sb) ? 0 :
+		buf->f_fsid = u64_to_fsid(
+			erofs_is_fscache_mode(sb) ?
+				0 :
 				huge_encode_dev(sb->s_bdev->bd_dev));
 	else
 		buf->f_fsid = uuid_to_fsid(sb->s_uuid.b);
+#endif
 	return 0;
 }
 
 static int erofs_show_options(struct seq_file *seq, struct dentry *root)
 {
+#ifndef CONFIG_EROFS_FS_RUST
 	struct erofs_sb_info *sbi = EROFS_SB(root->d_sb);
 	struct erofs_mount_opts *opt = &sbi->opt;
 
 	if (IS_ENABLED(CONFIG_EROFS_FS_XATTR))
-		seq_puts(seq, test_opt(opt, XATTR_USER) ?
-				",user_xattr" : ",nouser_xattr");
+		seq_puts(seq, test_opt(opt, XATTR_USER) ? ",user_xattr" :
+							  ",nouser_xattr");
 	if (IS_ENABLED(CONFIG_EROFS_FS_POSIX_ACL))
 		seq_puts(seq, test_opt(opt, POSIX_ACL) ? ",acl" : ",noacl");
 	if (IS_ENABLED(CONFIG_EROFS_FS_ZIP))
-		seq_printf(seq, ",cache_strategy=%s",
-			  erofs_param_cache_strategy[opt->cache_strategy].name);
+		seq_printf(
+			seq, ",cache_strategy=%s",
+			erofs_param_cache_strategy[opt->cache_strategy].name);
 	if (test_opt(opt, DAX_ALWAYS))
 		seq_puts(seq, ",dax=always");
 	if (test_opt(opt, DAX_NEVER))
@@ -932,6 +1032,7 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_printf(seq, ",fsid=%s", sbi->fsid);
 	if (sbi->domain_id)
 		seq_printf(seq, ",domain_id=%s", sbi->domain_id);
+#endif
 #endif
 	return 0;
 }
-- 
2.45.2

