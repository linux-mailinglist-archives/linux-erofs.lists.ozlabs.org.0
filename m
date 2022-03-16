Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EBE4DA756
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Mar 2022 02:23:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KJCG020c3z2yhD
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Mar 2022 12:23:20 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KJCFt0l4qz2xt0
 for <linux-erofs@lists.ozlabs.org>; Wed, 16 Mar 2022 12:23:09 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0V7JXUqC_1647393769; 
Received: from
 e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V7JXUqC_1647393769) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 16 Mar 2022 09:22:59 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 1/2] erofs: support read directory inodes with metabuf
Date: Wed, 16 Mar 2022 09:22:45 +0800
Message-Id: <20220316012246.95131-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Previously, directory inodes are directly handled with page cache
interfaces.

In order to support sub-page directory blocks and folios, let's
convert them into the latest metabuf infrastructure as well and
this patch addresses the readdir case first.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/data.c     | 12 +++++++++---
 fs/erofs/dir.c      | 21 ++++++---------------
 fs/erofs/internal.h |  2 ++
 3 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 226a57c57ee6..780db1e5f4b7 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -28,10 +28,10 @@ void erofs_put_metabuf(struct erofs_buf *buf)
 	buf->page = NULL;
 }
 
-void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
-			erofs_blk_t blkaddr, enum erofs_kmap_type type)
+void *erofs_bread(struct erofs_buf *buf, struct inode *inode,
+		  erofs_blk_t blkaddr, enum erofs_kmap_type type)
 {
-	struct address_space *const mapping = sb->s_bdev->bd_inode->i_mapping;
+	struct address_space *const mapping = inode->i_mapping;
 	erofs_off_t offset = blknr_to_addr(blkaddr);
 	pgoff_t index = offset >> PAGE_SHIFT;
 	struct page *page = buf->page;
@@ -60,6 +60,12 @@ void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
 	return buf->base + (offset & ~PAGE_MASK);
 }
 
+void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
+			 erofs_blk_t blkaddr, enum erofs_kmap_type type)
+{
+	return erofs_bread(buf, sb->s_bdev->bd_inode, blkaddr, type);
+}
+
 static int erofs_map_blocks_flatmode(struct inode *inode,
 				     struct erofs_map_blocks *map,
 				     int flags)
diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index eee9b0b31b63..66b971ff7d9d 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2017-2018 HUAWEI, Inc.
  *             https://www.huawei.com/
+ * Copyright (C) 2021-2022, Alibaba Cloud
  */
 #include "internal.h"
 
@@ -67,7 +68,7 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
 static int erofs_readdir(struct file *f, struct dir_context *ctx)
 {
 	struct inode *dir = file_inode(f);
-	struct address_space *mapping = dir->i_mapping;
+	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 	const size_t dirsize = i_size_read(dir);
 	unsigned int i = ctx->pos / EROFS_BLKSIZ;
 	unsigned int ofs = ctx->pos % EROFS_BLKSIZ;
@@ -75,26 +76,19 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 	bool initial = true;
 
 	while (ctx->pos < dirsize) {
-		struct page *dentry_page;
 		struct erofs_dirent *de;
 		unsigned int nameoff, maxsize;
 
-		dentry_page = read_mapping_page(mapping, i, NULL);
-		if (dentry_page == ERR_PTR(-ENOMEM)) {
-			err = -ENOMEM;
-			break;
-		} else if (IS_ERR(dentry_page)) {
+		de = erofs_bread(&buf, dir, i, EROFS_KMAP);
+		if (IS_ERR(de)) {
 			erofs_err(dir->i_sb,
 				  "fail to readdir of logical block %u of nid %llu",
 				  i, EROFS_I(dir)->nid);
-			err = -EFSCORRUPTED;
+			err = PTR_ERR(de);
 			break;
 		}
 
-		de = (struct erofs_dirent *)kmap(dentry_page);
-
 		nameoff = le16_to_cpu(de->nameoff);
-
 		if (nameoff < sizeof(struct erofs_dirent) ||
 		    nameoff >= PAGE_SIZE) {
 			erofs_err(dir->i_sb,
@@ -119,10 +113,6 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 		err = erofs_fill_dentries(dir, ctx, de, &ofs,
 					  nameoff, maxsize);
 skip_this:
-		kunmap(dentry_page);
-
-		put_page(dentry_page);
-
 		ctx->pos = blknr_to_addr(i) + ofs;
 
 		if (err)
@@ -130,6 +120,7 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 		++i;
 		ofs = 0;
 	}
+	erofs_put_metabuf(&buf);
 	return err < 0 ? err : 0;
 }
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 5aa2cf2c2f80..5298c4ee277d 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -479,6 +479,8 @@ struct erofs_map_dev {
 extern const struct file_operations erofs_file_fops;
 void erofs_unmap_metabuf(struct erofs_buf *buf);
 void erofs_put_metabuf(struct erofs_buf *buf);
+void *erofs_bread(struct erofs_buf *buf, struct inode *inode,
+		  erofs_blk_t blkaddr, enum erofs_kmap_type type);
 void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
 			 erofs_blk_t blkaddr, enum erofs_kmap_type type);
 int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *dev);
-- 
2.24.4

