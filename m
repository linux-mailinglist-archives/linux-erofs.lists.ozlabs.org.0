Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B314A3BAD30
	for <lists+linux-erofs@lfdr.de>; Sun,  4 Jul 2021 15:51:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GHqwv4PpHz306n
	for <lists+linux-erofs@lfdr.de>; Sun,  4 Jul 2021 23:51:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.42;
 helo=out30-42.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GHqwq5pc1z2yPB
 for <linux-erofs@lists.ozlabs.org>; Sun,  4 Jul 2021 23:51:23 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=9; SR=0; TI=SMTPD_---0UeeMavo_1625406659; 
Received: from
 e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UeeMavo_1625406659) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 04 Jul 2021 21:51:08 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH 2/2] erofs: dax support for non-tailpacking regular file
Date: Sun,  4 Jul 2021 21:50:56 +0800
Message-Id: <20210704135056.42723-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20210704135056.42723-1-hsiangkao@linux.alibaba.com>
References: <20210704135056.42723-1-hsiangkao@linux.alibaba.com>
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
Cc: nvdimm@lists.linux.dev, "Darrick J. Wong" <djwong@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Liu Bo <bo.liu@linux.alibaba.com>, linux-fsdevel@vger.kernel.org,
 Gao Xiang <hsiangkao@linux.alibaba.com>, Liu Jiang <gerry@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

DAX is quite useful for some VM use cases in order to save guest
memory extremely with minimal lightweight EROFS.

In order to prepare for such use cases, add preliminary dax support
for non-tailpacking regular files for now.

Tested with the DRAM-emulated PMEM and the EROFS image generated by
"mkfs.erofs -Enoinline_data enwik9.fsdax.img enwik9"

Cc: nvdimm@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/data.c     | 41 ++++++++++++++++++++++++++++++++++++++++-
 fs/erofs/inode.c    |  5 +++++
 fs/erofs/internal.h |  2 ++
 fs/erofs/super.c    | 20 ++++++++++++++++++--
 4 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 38e9439c2510..edeee8ccb22a 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -6,7 +6,7 @@
 #include "internal.h"
 #include <linux/prefetch.h>
 #include <linux/iomap.h>
-
+#include <linux/dax.h>
 #include <trace/events/erofs.h>
 
 static void erofs_readendio(struct bio *bio)
@@ -323,6 +323,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		return ret;
 
 	iomap->bdev = inode->i_sb->s_bdev;
+	iomap->dax_dev = EROFS_I_SB(inode)->dax_dev;
 	iomap->offset = map.m_la;
 	iomap->length = map.m_llen;
 
@@ -382,6 +383,11 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	if (!iov_iter_count(to))
 		return 0;
 
+#ifdef CONFIG_FS_DAX
+	if (IS_DAX(iocb->ki_filp->f_mapping->host))
+		return dax_iomap_rw(iocb, to, &erofs_iomap_ops);
+#endif
+
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		int err = erofs_prepare_dio(iocb, to);
 
@@ -410,6 +416,39 @@ const struct address_space_operations erofs_raw_access_aops = {
 	.direct_IO = noop_direct_IO,
 };
 
+#ifdef CONFIG_FS_DAX
+static vm_fault_t erofs_dax_huge_fault(struct vm_fault *vmf,
+		enum page_entry_size pe_size)
+{
+	return dax_iomap_fault(vmf, pe_size, NULL, NULL, &erofs_iomap_ops);
+}
+
+static vm_fault_t erofs_dax_fault(struct vm_fault *vmf)
+{
+	return erofs_dax_huge_fault(vmf, PE_SIZE_PTE);
+}
+
+static const struct vm_operations_struct erofs_dax_vm_ops = {
+	.fault		= erofs_dax_fault,
+	.huge_fault	= erofs_dax_huge_fault,
+};
+
+int erofs_file_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	if (!IS_DAX(file_inode(file)))
+		return generic_file_readonly_mmap(file, vma);
+
+	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))
+		return -EINVAL;
+
+	vma->vm_ops = &erofs_dax_vm_ops;
+	vma->vm_flags |= VM_HUGEPAGE;
+	return 0;
+}
+#else
+#define erofs_file_mmap	generic_file_readonly_mmap
+#endif
+
 const struct file_operations erofs_file_fops = {
 	.llseek		= generic_file_llseek,
 	.read_iter	= erofs_file_read_iter,
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 00edb7562fea..695b97acb9a6 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -174,6 +174,11 @@ static struct page *erofs_read_inode(struct inode *inode,
 	inode->i_mtime.tv_nsec = inode->i_ctime.tv_nsec;
 	inode->i_atime.tv_nsec = inode->i_ctime.tv_nsec;
 
+	inode->i_flags &= ~S_DAX;
+	if (test_opt(&sbi->ctx, DAX) && S_ISREG(inode->i_mode) &&
+	    vi->datalayout == EROFS_INODE_FLAT_PLAIN)
+		inode->i_flags |= S_DAX;
+
 	if (!nblks)
 		/* measure inode.i_blocks as generic filesystems */
 		inode->i_blocks = roundup(inode->i_size, EROFS_BLKSIZ) >> 9;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 2669c785d548..8b0542d35148 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -83,6 +83,7 @@ struct erofs_sb_info {
 
 	struct erofs_sb_lz4_info lz4;
 #endif	/* CONFIG_EROFS_FS_ZIP */
+	struct dax_device *dax_dev;
 	u32 blocks;
 	u32 meta_blkaddr;
 #ifdef CONFIG_EROFS_FS_XATTR
@@ -115,6 +116,7 @@ struct erofs_sb_info {
 /* Mount flags set via mount options or defaults */
 #define EROFS_MOUNT_XATTR_USER		0x00000010
 #define EROFS_MOUNT_POSIX_ACL		0x00000020
+#define EROFS_MOUNT_DAX			0x00000040
 
 #define clear_opt(ctx, option)	((ctx)->mount_opt &= ~EROFS_MOUNT_##option)
 #define set_opt(ctx, option)	((ctx)->mount_opt |= EROFS_MOUNT_##option)
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 8fc6c04b54f4..9aa385e22e1a 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -11,6 +11,7 @@
 #include <linux/crc32c.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/dax.h>
 #include "xattr.h"
 
 #define CREATE_TRACE_POINTS
@@ -355,6 +356,7 @@ enum {
 	Opt_user_xattr,
 	Opt_acl,
 	Opt_cache_strategy,
+	Opt_dax,
 	Opt_err
 };
 
@@ -370,6 +372,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
 	fsparam_flag_no("acl",		Opt_acl),
 	fsparam_enum("cache_strategy",	Opt_cache_strategy,
 		     erofs_param_cache_strategy),
+	fsparam_flag("dax",             Opt_dax),
 	{}
 };
 
@@ -410,6 +413,14 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		ctx->cache_strategy = result.uint_32;
 #else
 		errorfc(fc, "compression not supported, cache_strategy ignored");
+#endif
+		break;
+	case Opt_dax:
+#ifdef CONFIG_FS_DAX
+		warnfc(fc, "DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
+		set_opt(ctx, DAX);
+#else
+		errorfc(fc, "dax options not supported");
 #endif
 		break;
 	default:
@@ -496,6 +507,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 		return -ENOMEM;
 
 	sb->s_fs_info = sbi;
+	sbi->dax_dev = fs_dax_get_by_bdev(sb->s_bdev);
 	err = erofs_read_superblock(sb);
 	if (err)
 		return err;
@@ -609,6 +621,8 @@ static void erofs_kill_sb(struct super_block *sb)
 	sbi = EROFS_SB(sb);
 	if (!sbi)
 		return;
+	if (sbi->dax_dev)
+		fs_put_dax(sbi->dax_dev);
 	kfree(sbi);
 	sb->s_fs_info = NULL;
 }
@@ -711,8 +725,8 @@ static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 static int erofs_show_options(struct seq_file *seq, struct dentry *root)
 {
-	struct erofs_sb_info *sbi __maybe_unused = EROFS_SB(root->d_sb);
-	struct erofs_fs_context *ctx __maybe_unused = &sbi->ctx;
+	struct erofs_sb_info *sbi = EROFS_SB(root->d_sb);
+	struct erofs_fs_context *ctx = &sbi->ctx;
 
 #ifdef CONFIG_EROFS_FS_XATTR
 	if (test_opt(ctx, XATTR_USER))
@@ -734,6 +748,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
 	else if (ctx->cache_strategy == EROFS_ZIP_CACHE_READAROUND)
 		seq_puts(seq, ",cache_strategy=readaround");
 #endif
+	if (test_opt(ctx, DAX))
+		seq_puts(seq, ",dax");
 	return 0;
 }
 
-- 
2.24.4

