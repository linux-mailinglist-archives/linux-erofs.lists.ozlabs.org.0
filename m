Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DBF3EAFA6
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Aug 2021 07:29:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GmBvk1FrPz3bTV
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Aug 2021 15:29:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54;
 helo=out30-54.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GmBvZ6VLWz302N
 for <linux-erofs@lists.ozlabs.org>; Fri, 13 Aug 2021 15:29:45 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R321e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=7; SR=0; TI=SMTPD_---0UiqodgM_1628832571; 
Received: from
 e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UiqodgM_1628832571) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 13 Aug 2021 13:29:39 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs: add fiemap support with iomap
Date: Fri, 13 Aug 2021 13:29:31 +0800
Message-Id: <20210813052931.203280-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20210813052931.203280-1-hsiangkao@linux.alibaba.com>
References: <20210813052931.203280-1-hsiangkao@linux.alibaba.com>
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
Cc: nl6720 <nl6720@gmail.com>, Lasse Collin <lasse.collin@tukaani.org>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This adds fiemap support for both uncompressed files and compressed
files by using iomap infrastructure.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/data.c     | 15 ++++++++++++++-
 fs/erofs/inode.c    |  1 +
 fs/erofs/internal.h |  5 +++++
 fs/erofs/namei.c    |  1 +
 fs/erofs/zmap.c     | 38 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index b2a22aabc9bc..09c46fbdb9b2 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -5,7 +5,6 @@
  */
 #include "internal.h"
 #include <linux/prefetch.h>
-#include <linux/iomap.h>
 #include <linux/dax.h>
 #include <trace/events/erofs.h>
 
@@ -152,6 +151,20 @@ static const struct iomap_ops erofs_iomap_ops = {
 	.iomap_end = erofs_iomap_end,
 };
 
+int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
+		 u64 start, u64 len)
+{
+	if (erofs_inode_is_data_compressed(EROFS_I(inode)->datalayout)) {
+#ifdef CONFIG_EROFS_FS_ZIP
+		return iomap_fiemap(inode, fieinfo, start, len,
+				    &z_erofs_iomap_report_ops);
+#else
+		return -EOPNOTSUPP;
+#endif
+	}
+	return iomap_fiemap(inode, fieinfo, start, len, &erofs_iomap_ops);
+}
+
 /*
  * since we dont have write or truncate flows, so no inode
  * locking needs to be held at the moment.
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 92728da1d206..d13e0709599c 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -365,6 +365,7 @@ const struct inode_operations erofs_generic_iops = {
 	.getattr = erofs_getattr,
 	.listxattr = erofs_listxattr,
 	.get_acl = erofs_get_acl,
+	.fiemap = erofs_fiemap,
 };
 
 const struct inode_operations erofs_symlink_iops = {
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 2a05b09e1c06..ae33a28c8669 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -15,6 +15,7 @@
 #include <linux/magic.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include <linux/iomap.h>
 #include "erofs_fs.h"
 
 /* redefine pr_fmt "erofs: " */
@@ -363,6 +364,8 @@ struct erofs_map_blocks {
 #define EROFS_GET_BLOCKS_FIEMAP	0x0002
 
 /* zmap.c */
+extern const struct iomap_ops z_erofs_iomap_report_ops;
+
 #ifdef CONFIG_EROFS_FS_ZIP
 int z_erofs_fill_inode(struct inode *inode);
 int z_erofs_map_blocks_iter(struct inode *inode,
@@ -381,6 +384,8 @@ static inline int z_erofs_map_blocks_iter(struct inode *inode,
 /* data.c */
 extern const struct file_operations erofs_file_fops;
 struct page *erofs_get_meta_page(struct super_block *sb, erofs_blk_t blkaddr);
+int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
+		 u64 start, u64 len);
 
 /* inode.c */
 static inline unsigned long erofs_inode_hash(erofs_nid_t nid)
diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
index a8271ce5e13f..8629e616028c 100644
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -245,4 +245,5 @@ const struct inode_operations erofs_dir_iops = {
 	.getattr = erofs_getattr,
 	.listxattr = erofs_listxattr,
 	.get_acl = erofs_get_acl,
+	.fiemap = erofs_fiemap,
 };
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 12256ef12819..6af31ef6f13f 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -673,3 +673,41 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 	DBG_BUGON(err < 0 && err != -ENOMEM);
 	return err;
 }
+
+static int z_erofs_iomap_begin_report(struct inode *inode, loff_t offset,
+				loff_t length, unsigned int flags,
+				struct iomap *iomap, struct iomap *srcmap)
+{
+	int ret;
+	struct erofs_map_blocks map = { .m_la = offset };
+
+	ret = z_erofs_map_blocks_iter(inode, &map, EROFS_GET_BLOCKS_FIEMAP);
+	if (map.mpage)
+		put_page(map.mpage);
+	if (ret < 0)
+		return ret;
+
+	iomap->bdev = inode->i_sb->s_bdev;
+	iomap->offset = map.m_la;
+	iomap->length = map.m_llen;
+	if (map.m_flags & EROFS_MAP_MAPPED) {
+		iomap->type = IOMAP_MAPPED;
+		iomap->addr = map.m_pa;
+	} else {
+		iomap->type = IOMAP_HOLE;
+		iomap->addr = IOMAP_NULL_ADDR;
+		/*
+		 * No strict rule how to describe extents for post EOF, yet
+		 * we need do like below. Otherwise, iomap itself will get
+		 * into an endless loop on post EOF.
+		 */
+		if (iomap->offset >= inode->i_size)
+			iomap->length = length + map.m_la - offset;
+	}
+	iomap->flags = 0;
+	return 0;
+}
+
+const struct iomap_ops z_erofs_iomap_report_ops = {
+	.iomap_begin = z_erofs_iomap_begin_report,
+};
-- 
2.24.4

