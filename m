Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D3F480F8A
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Dec 2021 05:14:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JNyjQ6M88z3bmS
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Dec 2021 15:14:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130;
 helo=out30-130.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JNyjG0Y0Hz2yxP
 for <linux-erofs@lists.ozlabs.org>; Wed, 29 Dec 2021 15:14:41 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R851e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0V0Bi34J_1640751246; 
Received: from
 e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V0Bi34J_1640751246) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 29 Dec 2021 12:14:17 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
 Liu Bo <bo.liu@linux.alibaba.com>
Subject: [PATCH 2/5] erofs: use meta buffers for inode operations
Date: Wed, 29 Dec 2021 12:14:02 +0800
Message-Id: <20211229041405.45921-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20211229041405.45921-1-hsiangkao@linux.alibaba.com>
References: <20211229041405.45921-1-hsiangkao@linux.alibaba.com>
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

Get rid of old erofs_get_meta_page() within inode operations by
using on-stack meta buffers in order to prepare subpage and folio
features.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/inode.c    | 68 +++++++++++++++++++++------------------------
 fs/erofs/internal.h |  3 ++
 2 files changed, 35 insertions(+), 36 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 2345f1de438e..ff62f84f47d3 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -13,8 +13,8 @@
  * the inode payload page if it's an extended inode) in order to fill
  * inline data if possible.
  */
-static struct page *erofs_read_inode(struct inode *inode,
-				     unsigned int *ofs)
+static void *erofs_read_inode(struct erofs_buf *buf,
+			      struct inode *inode, unsigned int *ofs)
 {
 	struct super_block *sb = inode->i_sb;
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
@@ -22,7 +22,7 @@ static struct page *erofs_read_inode(struct inode *inode,
 	const erofs_off_t inode_loc = iloc(sbi, vi->nid);
 
 	erofs_blk_t blkaddr, nblks = 0;
-	struct page *page;
+	void *kaddr;
 	struct erofs_inode_compact *dic;
 	struct erofs_inode_extended *die, *copied = NULL;
 	unsigned int ifmt;
@@ -34,14 +34,14 @@ static struct page *erofs_read_inode(struct inode *inode,
 	erofs_dbg("%s, reading inode nid %llu at %u of blkaddr %u",
 		  __func__, vi->nid, *ofs, blkaddr);
 
-	page = erofs_get_meta_page(sb, blkaddr);
-	if (IS_ERR(page)) {
+	kaddr = erofs_read_metabuf(buf, sb, blkaddr, EROFS_KMAP);
+	if (IS_ERR(kaddr)) {
 		erofs_err(sb, "failed to get inode (nid: %llu) page, err %ld",
-			  vi->nid, PTR_ERR(page));
-		return page;
+			  vi->nid, PTR_ERR(kaddr));
+		return kaddr;
 	}
 
-	dic = page_address(page) + *ofs;
+	dic = kaddr + *ofs;
 	ifmt = le16_to_cpu(dic->i_format);
 
 	if (ifmt & ~EROFS_I_ALL) {
@@ -62,12 +62,12 @@ static struct page *erofs_read_inode(struct inode *inode,
 	switch (erofs_inode_version(ifmt)) {
 	case EROFS_INODE_LAYOUT_EXTENDED:
 		vi->inode_isize = sizeof(struct erofs_inode_extended);
-		/* check if the inode acrosses page boundary */
-		if (*ofs + vi->inode_isize <= PAGE_SIZE) {
+		/* check if the extended inode acrosses block boundary */
+		if (*ofs + vi->inode_isize <= EROFS_BLKSIZ) {
 			*ofs += vi->inode_isize;
 			die = (struct erofs_inode_extended *)dic;
 		} else {
-			const unsigned int gotten = PAGE_SIZE - *ofs;
+			const unsigned int gotten = EROFS_BLKSIZ - *ofs;
 
 			copied = kmalloc(vi->inode_isize, GFP_NOFS);
 			if (!copied) {
@@ -75,18 +75,16 @@ static struct page *erofs_read_inode(struct inode *inode,
 				goto err_out;
 			}
 			memcpy(copied, dic, gotten);
-			unlock_page(page);
-			put_page(page);
-
-			page = erofs_get_meta_page(sb, blkaddr + 1);
-			if (IS_ERR(page)) {
-				erofs_err(sb, "failed to get inode payload page (nid: %llu), err %ld",
-					  vi->nid, PTR_ERR(page));
+			kaddr = erofs_read_metabuf(buf, sb, blkaddr + 1,
+						   EROFS_KMAP);
+			if (IS_ERR(kaddr)) {
+				erofs_err(sb, "failed to get inode payload block (nid: %llu), err %ld",
+					  vi->nid, PTR_ERR(kaddr));
 				kfree(copied);
-				return page;
+				return kaddr;
 			}
 			*ofs = vi->inode_isize - gotten;
-			memcpy((u8 *)copied + gotten, page_address(page), *ofs);
+			memcpy((u8 *)copied + gotten, kaddr, *ofs);
 			die = copied;
 		}
 		vi->xattr_isize = erofs_xattr_ibody_size(die->i_xattr_icount);
@@ -200,7 +198,7 @@ static struct page *erofs_read_inode(struct inode *inode,
 		inode->i_blocks = roundup(inode->i_size, EROFS_BLKSIZ) >> 9;
 	else
 		inode->i_blocks = nblks << LOG_SECTORS_PER_BLOCK;
-	return page;
+	return kaddr;
 
 bogusimode:
 	erofs_err(inode->i_sb, "bogus i_mode (%o) @ nid %llu",
@@ -209,12 +207,11 @@ static struct page *erofs_read_inode(struct inode *inode,
 err_out:
 	DBG_BUGON(1);
 	kfree(copied);
-	unlock_page(page);
-	put_page(page);
+	erofs_put_metabuf(buf);
 	return ERR_PTR(err);
 }
 
-static int erofs_fill_symlink(struct inode *inode, void *data,
+static int erofs_fill_symlink(struct inode *inode, void *kaddr,
 			      unsigned int m_pofs)
 {
 	struct erofs_inode *vi = EROFS_I(inode);
@@ -222,7 +219,7 @@ static int erofs_fill_symlink(struct inode *inode, void *data,
 
 	/* if it cannot be handled with fast symlink scheme */
 	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
-	    inode->i_size >= PAGE_SIZE) {
+	    inode->i_size >= EROFS_BLKSIZ) {
 		inode->i_op = &erofs_symlink_iops;
 		return 0;
 	}
@@ -232,8 +229,8 @@ static int erofs_fill_symlink(struct inode *inode, void *data,
 		return -ENOMEM;
 
 	m_pofs += vi->xattr_isize;
-	/* inline symlink data shouldn't cross page boundary as well */
-	if (m_pofs + inode->i_size > PAGE_SIZE) {
+	/* inline symlink data shouldn't cross block boundary */
+	if (m_pofs + inode->i_size > EROFS_BLKSIZ) {
 		kfree(lnk);
 		erofs_err(inode->i_sb,
 			  "inline data cross block boundary @ nid %llu",
@@ -241,8 +238,7 @@ static int erofs_fill_symlink(struct inode *inode, void *data,
 		DBG_BUGON(1);
 		return -EFSCORRUPTED;
 	}
-
-	memcpy(lnk, data + m_pofs, inode->i_size);
+	memcpy(lnk, kaddr + m_pofs, inode->i_size);
 	lnk[inode->i_size] = '\0';
 
 	inode->i_link = lnk;
@@ -253,16 +249,17 @@ static int erofs_fill_symlink(struct inode *inode, void *data,
 static int erofs_fill_inode(struct inode *inode, int isdir)
 {
 	struct erofs_inode *vi = EROFS_I(inode);
-	struct page *page;
+	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
+	void *kaddr;
 	unsigned int ofs;
 	int err = 0;
 
 	trace_erofs_fill_inode(inode, isdir);
 
 	/* read inode base data from disk */
-	page = erofs_read_inode(inode, &ofs);
-	if (IS_ERR(page))
-		return PTR_ERR(page);
+	kaddr = erofs_read_inode(&buf, inode, &ofs);
+	if (IS_ERR(kaddr))
+		return PTR_ERR(kaddr);
 
 	/* setup the new inode */
 	switch (inode->i_mode & S_IFMT) {
@@ -278,7 +275,7 @@ static int erofs_fill_inode(struct inode *inode, int isdir)
 		inode->i_fop = &erofs_dir_fops;
 		break;
 	case S_IFLNK:
-		err = erofs_fill_symlink(inode, page_address(page), ofs);
+		err = erofs_fill_symlink(inode, kaddr, ofs);
 		if (err)
 			goto out_unlock;
 		inode_nohighmem(inode);
@@ -302,8 +299,7 @@ static int erofs_fill_inode(struct inode *inode, int isdir)
 	inode->i_mapping->a_ops = &erofs_raw_access_aops;
 
 out_unlock:
-	unlock_page(page);
-	put_page(page);
+	erofs_put_metabuf(&buf);
 	return err;
 }
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 7053f1c4171d..f1e4eb3025f6 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -475,6 +475,9 @@ struct erofs_map_dev {
 /* data.c */
 extern const struct file_operations erofs_file_fops;
 struct page *erofs_get_meta_page(struct super_block *sb, erofs_blk_t blkaddr);
+void erofs_put_metabuf(struct erofs_buf *buf);
+void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
+			 erofs_blk_t blkaddr, enum erofs_kmap_type type);
 int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *dev);
 int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		 u64 start, u64 len);
-- 
2.24.4

