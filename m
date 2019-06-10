Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id B34DE3B251
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Jun 2019 11:37:49 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45Mp2g1xYCzDqSC
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Jun 2019 19:37:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.32; helo=huawei.com; envelope-from=gaoxiang25@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45Mp2V1wHZzDqRF
 for <linux-erofs@lists.ozlabs.org>; Mon, 10 Jun 2019 19:37:37 +1000 (AEST)
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id DB295FBDEE9AA47707F5;
 Mon, 10 Jun 2019 17:37:32 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 10 Jun
 2019 17:37:23 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, <devel@driverdev.osuosl.org>
Subject: [PATCH 2/2] staging: erofs: rename data_mapping_mode to datamode
Date: Mon, 10 Jun 2019 17:36:40 +0800
Message-ID: <20190610093640.96705-2-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610093640.96705-1-gaoxiang25@huawei.com>
References: <20190610093640.96705-1-gaoxiang25@huawei.com>
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 weidu.du@huawei.com, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

data_mapping_mode is too long as a member name of erofs_vnode,
datamode is straight-forward enough.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/inode.c    | 17 ++++++++---------
 drivers/staging/erofs/internal.h | 10 ++++------
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
index 9520419f746c..e51348f7e838 100644
--- a/drivers/staging/erofs/inode.c
+++ b/drivers/staging/erofs/inode.c
@@ -22,11 +22,11 @@ static int read_inode(struct inode *inode, void *data)
 	const unsigned int advise = le16_to_cpu(v1->i_advise);
 	erofs_blk_t nblks = 0;
 
-	vi->data_mapping_mode = __inode_data_mapping(advise);
+	vi->datamode = __inode_data_mapping(advise);
 
-	if (unlikely(vi->data_mapping_mode >= EROFS_INODE_LAYOUT_MAX)) {
-		errln("unknown data mapping mode %u of nid %llu",
-		      vi->data_mapping_mode, vi->nid);
+	if (unlikely(vi->datamode >= EROFS_INODE_LAYOUT_MAX)) {
+		errln("unsupported data mapping %u of nid %llu",
+		      vi->datamode, vi->nid);
 		DBG_BUGON(1);
 		return -EIO;
 	}
@@ -63,7 +63,7 @@ static int read_inode(struct inode *inode, void *data)
 		inode->i_size = le64_to_cpu(v2->i_size);
 
 		/* total blocks for compressed files */
-		if (vi->data_mapping_mode == EROFS_INODE_LAYOUT_COMPRESSION)
+		if (is_inode_layout_compression(inode))
 			nblks = le32_to_cpu(v2->i_u.compressed_blocks);
 	} else if (__inode_version(advise) == EROFS_INODE_LAYOUT_V1) {
 		struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
@@ -95,7 +95,7 @@ static int read_inode(struct inode *inode, void *data)
 			sbi->build_time_nsec;
 
 		inode->i_size = le32_to_cpu(v1->i_size);
-		if (vi->data_mapping_mode == EROFS_INODE_LAYOUT_COMPRESSION)
+		if (is_inode_layout_compression(inode))
 			nblks = le32_to_cpu(v1->i_u.compressed_blocks);
 	} else {
 		errln("unsupported on-disk inode version %u of nid %llu",
@@ -127,7 +127,7 @@ static int fill_inline_data(struct inode *inode, void *data,
 {
 	struct erofs_vnode *vi = EROFS_V(inode);
 	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
-	int mode = vi->data_mapping_mode;
+	const int mode = vi->datamode;
 
 	DBG_BUGON(mode >= EROFS_INODE_LAYOUT_MAX);
 
@@ -299,9 +299,8 @@ int erofs_getattr(const struct path *path, struct kstat *stat,
 		  u32 request_mask, unsigned int query_flags)
 {
 	struct inode *const inode = d_inode(path->dentry);
-	struct erofs_vnode *const vi = EROFS_V(inode);
 
-	if (vi->data_mapping_mode == EROFS_INODE_LAYOUT_COMPRESSION)
+	if (is_inode_layout_compression(inode))
 		stat->attributes |= STATX_ATTR_COMPRESSED;
 
 	stat->attributes |= STATX_ATTR_IMMUTABLE;
diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index 911333cdeef4..6a7eb04d29b4 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -347,8 +347,7 @@ struct erofs_vnode {
 	/* atomic flags (including bitlocks) */
 	unsigned long flags;
 
-	unsigned char data_mapping_mode;
-	/* inline size in bytes */
+	unsigned char datamode;
 	unsigned char inode_isize;
 	unsigned short xattr_isize;
 
@@ -383,18 +382,17 @@ static inline unsigned long inode_datablocks(struct inode *inode)
 
 static inline bool is_inode_layout_plain(struct inode *inode)
 {
-	return EROFS_V(inode)->data_mapping_mode == EROFS_INODE_LAYOUT_PLAIN;
+	return EROFS_V(inode)->datamode == EROFS_INODE_LAYOUT_PLAIN;
 }
 
 static inline bool is_inode_layout_compression(struct inode *inode)
 {
-	return EROFS_V(inode)->data_mapping_mode ==
-					EROFS_INODE_LAYOUT_COMPRESSION;
+	return EROFS_V(inode)->datamode == EROFS_INODE_LAYOUT_COMPRESSION;
 }
 
 static inline bool is_inode_layout_inline(struct inode *inode)
 {
-	return EROFS_V(inode)->data_mapping_mode == EROFS_INODE_LAYOUT_INLINE;
+	return EROFS_V(inode)->datamode == EROFS_INODE_LAYOUT_INLINE;
 }
 
 extern const struct super_operations erofs_sops;
-- 
2.17.1

