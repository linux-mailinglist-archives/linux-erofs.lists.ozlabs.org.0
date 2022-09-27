Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C54F5EBACC
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Sep 2022 08:36:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Mc8zF5PQ6z3c4c
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Sep 2022 16:36:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mc8z85Hzgz3bbm
	for <linux-erofs@lists.ozlabs.org>; Tue, 27 Sep 2022 16:36:19 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VQqcSYY_1664260568;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VQqcSYY_1664260568)
          by smtp.aliyun-inc.com;
          Tue, 27 Sep 2022 14:36:13 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs: clean up unnecessary code and comments
Date: Tue, 27 Sep 2022 14:36:06 +0800
Message-Id: <20220927063607.54832-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Some conditional macros and comments are useless.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/internal.h |  2 --
 fs/erofs/namei.c    | 11 +----------
 fs/erofs/xattr.h    |  2 --
 fs/erofs/zmap.c     |  3 +--
 4 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index a6333c283e3d..0318530bc78a 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -196,7 +196,6 @@ enum {
 	EROFS_ZIP_CACHE_READAROUND
 };
 
-#ifdef CONFIG_EROFS_FS_ZIP
 #define EROFS_LOCKED_MAGIC     (INT_MIN | 0xE0F510CCL)
 
 /* basic unit of the workstation of a super_block */
@@ -236,7 +235,6 @@ static inline int erofs_wait_on_workgroup_freezed(struct erofs_workgroup *grp)
 	return atomic_cond_read_relaxed(&grp->refcount,
 					VAL != EROFS_LOCKED_MAGIC);
 }
-#endif	/* !CONFIG_EROFS_FS_ZIP */
 
 /* we strictly follow PAGE_SIZE and no buffer head yet */
 #define LOG_BLOCK_SIZE		PAGE_SHIFT
diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
index fd75506799c4..afbb80d4e2f1 100644
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -185,7 +185,6 @@ int erofs_namei(struct inode *dir, const struct qstr *name, erofs_nid_t *nid,
 	if (IS_ERR(de))
 		return PTR_ERR(de);
 
-	/* the target page has been mapped */
 	if (ndirents)
 		de = find_target_dirent(&qn, (u8 *)de, EROFS_BLKSIZ, ndirents);
 
@@ -197,9 +196,7 @@ int erofs_namei(struct inode *dir, const struct qstr *name, erofs_nid_t *nid,
 	return PTR_ERR_OR_ZERO(de);
 }
 
-/* NOTE: i_mutex is already held by vfs */
-static struct dentry *erofs_lookup(struct inode *dir,
-				   struct dentry *dentry,
+static struct dentry *erofs_lookup(struct inode *dir, struct dentry *dentry,
 				   unsigned int flags)
 {
 	int err;
@@ -207,17 +204,11 @@ static struct dentry *erofs_lookup(struct inode *dir,
 	unsigned int d_type;
 	struct inode *inode;
 
-	DBG_BUGON(!d_really_is_negative(dentry));
-	/* dentry must be unhashed in lookup, no need to worry about */
-	DBG_BUGON(!d_unhashed(dentry));
-
 	trace_erofs_lookup(dir, dentry, flags);
 
-	/* file name exceeds fs limit */
 	if (dentry->d_name.len > EROFS_NAME_LEN)
 		return ERR_PTR(-ENAMETOOLONG);
 
-	/* false uninitialized warnings on gcc 4.8.x */
 	err = erofs_namei(dir, &dentry->d_name, &nid, &d_type);
 
 	if (err == -ENOENT) {
diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
index 332462c59f11..0a43c9ee9f8f 100644
--- a/fs/erofs/xattr.h
+++ b/fs/erofs/xattr.h
@@ -39,9 +39,7 @@ static inline unsigned int xattrblock_offset(struct erofs_sb_info *sbi,
 #ifdef CONFIG_EROFS_FS_XATTR
 extern const struct xattr_handler erofs_xattr_user_handler;
 extern const struct xattr_handler erofs_xattr_trusted_handler;
-#ifdef CONFIG_EROFS_FS_SECURITY
 extern const struct xattr_handler erofs_xattr_security_handler;
-#endif
 
 static inline const struct xattr_handler *erofs_xattr_handler(unsigned int idx)
 {
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index ccdddb755be8..0a2e41adc78a 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -743,8 +743,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 	return err;
 }
 
-int z_erofs_map_blocks_iter(struct inode *inode,
-			    struct erofs_map_blocks *map,
+int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
 			    int flags)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
-- 
2.24.4

