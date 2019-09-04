Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F019CA7893
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Sep 2019 04:11:48 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46NS4K5YLpzDqlS
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Sep 2019 12:11:45 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 46NS2s2FdTzDqlB
 for <linux-erofs@lists.ozlabs.org>; Wed,  4 Sep 2019 12:10:28 +1000 (AEST)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 8478ED1D934AB763232E;
 Wed,  4 Sep 2019 10:10:25 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 4 Sep 2019
 10:10:18 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@lst.de>,
 <devel@driverdev.osuosl.org>
Subject: [PATCH v2 12/25] erofs: better erofs symlink stuffs
Date: Wed, 4 Sep 2019 10:08:59 +0800
Message-ID: <20190904020912.63925-13-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904020912.63925-1-gaoxiang25@huawei.com>
References: <20190901055130.30572-1-hsiangkao@aol.com>
 <20190904020912.63925-1-gaoxiang25@huawei.com>
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
Cc: linux-fsdevel@vger.kernel.org, Miao Xie <miaoxie@huawei.com>,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Fix as Christoph suggested [1] [2], "remove is_inode_fast_symlink
and just opencode it in the few places using it"

and
"Please just set the ops directly instead of obsfucating that in
a single caller, single line inline function.  And please set it
instead of the normal symlink iops in the same place where you
also set those."

[1] https://lore.kernel.org/r/20190830163910.GB29603@infradead.org/
[2] https://lore.kernel.org/r/20190829102426.GE20598@infradead.org/
Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/inode.c    | 68 ++++++++++++++++++---------------------------
 fs/erofs/internal.h | 10 -------
 fs/erofs/super.c    |  5 ++--
 3 files changed, 29 insertions(+), 54 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index a42f5fc14df9..770f3259c862 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -127,50 +127,39 @@ static int read_inode(struct inode *inode, void *data)
 	return -EFSCORRUPTED;
 }
 
-/*
- * try_lock can be required since locking order is:
- *   file data(fs_inode)
- *        meta(bd_inode)
- * but the majority of the callers is "iget",
- * in that case we are pretty sure no deadlock since
- * no data operations exist. However I tend to
- * try_lock since it takes no much overhead and
- * will success immediately.
- */
-static int fill_inline_data(struct inode *inode, void *data,
-			    unsigned int m_pofs)
+static int erofs_fill_symlink(struct inode *inode, void *data,
+			      unsigned int m_pofs)
 {
 	struct erofs_inode *vi = EROFS_I(inode);
 	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
+	char *lnk;
 
-	/* should be tail-packing data inline */
-	if (vi->datalayout != EROFS_INODE_FLAT_INLINE)
+	/* if it cannot be handled with fast symlink scheme */
+	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
+	    inode->i_size >= PAGE_SIZE) {
+		inode->i_op = &erofs_symlink_iops;
 		return 0;
+	}
 
-	/* fast symlink */
-	if (S_ISLNK(inode->i_mode) && inode->i_size < PAGE_SIZE) {
-		char *lnk = erofs_kmalloc(sbi, inode->i_size + 1, GFP_KERNEL);
-
-		if (!lnk)
-			return -ENOMEM;
-
-		m_pofs += vi->inode_isize + vi->xattr_isize;
+	lnk = erofs_kmalloc(sbi, inode->i_size + 1, GFP_KERNEL);
+	if (!lnk)
+		return -ENOMEM;
 
-		/* inline symlink data shouldn't cross page boundary as well */
-		if (m_pofs + inode->i_size > PAGE_SIZE) {
-			kfree(lnk);
-			errln("inline data cross block boundary @ nid %llu",
-			      vi->nid);
-			DBG_BUGON(1);
-			return -EFSCORRUPTED;
-		}
+	m_pofs += vi->inode_isize + vi->xattr_isize;
+	/* inline symlink data shouldn't cross page boundary as well */
+	if (m_pofs + inode->i_size > PAGE_SIZE) {
+		kfree(lnk);
+		errln("inline data cross block boundary @ nid %llu",
+		      vi->nid);
+		DBG_BUGON(1);
+		return -EFSCORRUPTED;
+	}
 
-		memcpy(lnk, data + m_pofs, inode->i_size);
-		lnk[inode->i_size] = '\0';
+	memcpy(lnk, data + m_pofs, inode->i_size);
+	lnk[inode->i_size] = '\0';
 
-		inode->i_link = lnk;
-		set_inode_fast_symlink(inode);
-	}
+	inode->i_link = lnk;
+	inode->i_op = &erofs_fast_symlink_iops;
 	return 0;
 }
 
@@ -217,8 +206,9 @@ static int fill_inode(struct inode *inode, int isdir)
 			inode->i_fop = &erofs_dir_fops;
 			break;
 		case S_IFLNK:
-			/* by default, page_get_link is used for symlink */
-			inode->i_op = &erofs_symlink_iops;
+			err = erofs_fill_symlink(inode, data, ofs);
+			if (err)
+				goto out_unlock;
 			inode_nohighmem(inode);
 			break;
 		case S_IFCHR:
@@ -237,11 +227,7 @@ static int fill_inode(struct inode *inode, int isdir)
 			err = z_erofs_fill_inode(inode);
 			goto out_unlock;
 		}
-
 		inode->i_mapping->a_ops = &erofs_raw_access_aops;
-
-		/* fill last page if inline data is available */
-		err = fill_inline_data(inode, data, ofs);
 	}
 
 out_unlock:
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 10497ee07cae..cc1ea98c5c89 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -479,16 +479,6 @@ extern const struct inode_operations erofs_generic_iops;
 extern const struct inode_operations erofs_symlink_iops;
 extern const struct inode_operations erofs_fast_symlink_iops;
 
-static inline void set_inode_fast_symlink(struct inode *inode)
-{
-	inode->i_op = &erofs_fast_symlink_iops;
-}
-
-static inline bool is_inode_fast_symlink(struct inode *inode)
-{
-	return inode->i_op == &erofs_fast_symlink_iops;
-}
-
 struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid, bool dir);
 int erofs_getattr(const struct path *path, struct kstat *stat,
 		  u32 request_mask, unsigned int query_flags);
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 3986be582dbb..b8b0e35f6621 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -40,10 +40,9 @@ static void free_inode(struct inode *inode)
 {
 	struct erofs_inode *vi = EROFS_I(inode);
 
-	/* be careful RCU symlink path (see ext4_inode_info->i_data)! */
-	if (is_inode_fast_symlink(inode))
+	/* be careful of RCU symlink path */
+	if (inode->i_op == &erofs_fast_symlink_iops)
 		kfree(inode->i_link);
-
 	kfree(vi->xattr_shared_xattrs);
 
 	kmem_cache_free(erofs_inode_cachep, vi);
-- 
2.17.1

