Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 348CB77CAB7
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Aug 2023 11:49:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RQ61N5wzDz3cGL
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Aug 2023 19:49:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=mengferry@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RQ61J1qtsz30gB
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Aug 2023 19:49:22 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=mengferry@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VprTDmM_1692092931;
Received: from j66c13357.sqa.eu95.tbsite.net(mailfrom:mengferry@linux.alibaba.com fp:SMTPD_---0VprTDmM_1692092931)
          by smtp.aliyun-inc.com;
          Tue, 15 Aug 2023 17:49:16 +0800
From: Ferry Meng <mengferry@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/3] erofs: clean up redundant comment and adjust code alignment
Date: Tue, 15 Aug 2023 17:48:47 +0800
Message-Id: <20230815094849.53249-1-mengferry@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
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
Cc: Ferry Meng <mengferry@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Remove some redundant comments in erofs/super.c, and avoid unncessary
line breaks for cleanup.

Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>
---
 fs/erofs/super.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 566f68ddfa36..ae5caf605ffc 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -21,8 +21,7 @@
 static struct kmem_cache *erofs_inode_cachep __read_mostly;
 struct file_system_type erofs_fs_type;
 
-void _erofs_err(struct super_block *sb, const char *function,
-		const char *fmt, ...)
+void _erofs_err(struct super_block *sb, const char *func, const char *fmt, ...)
 {
 	struct va_format vaf;
 	va_list args;
@@ -32,12 +31,11 @@ void _erofs_err(struct super_block *sb, const char *function,
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	pr_err("(device %s): %s: %pV", sb->s_id, function, &vaf);
+	pr_err("(device %s): %s: %pV", sb->s_id, func, &vaf);
 	va_end(args);
 }
 
-void _erofs_info(struct super_block *sb, const char *function,
-		 const char *fmt, ...)
+void _erofs_info(struct super_block *sb, const char *func, const char *fmt, ...)
 {
 	struct va_format vaf;
 	va_list args;
@@ -102,11 +100,9 @@ static void erofs_free_inode(struct inode *inode)
 {
 	struct erofs_inode *vi = EROFS_I(inode);
 
-	/* be careful of RCU symlink path */
 	if (inode->i_op == &erofs_fast_symlink_iops)
 		kfree(inode->i_link);
 	kfree(vi->xattr_shared_xattrs);
-
 	kmem_cache_free(erofs_inode_cachep, vi);
 }
 
@@ -119,8 +115,7 @@ static bool check_layout_compatibility(struct super_block *sb,
 
 	/* check if current kernel meets all mandatory requirements */
 	if (feature & (~EROFS_ALL_FEATURE_INCOMPAT)) {
-		erofs_err(sb,
-			  "unidentified incompatible feature %x, please upgrade kernel version",
+		erofs_err(sb, "unidentified incompatible feature %x, please upgrade kernel",
 			   feature & ~EROFS_ALL_FEATURE_INCOMPAT);
 		return false;
 	}
@@ -429,7 +424,6 @@ static int erofs_read_superblock(struct super_block *sb)
 	return ret;
 }
 
-/* set up default EROFS parameters */
 static void erofs_default_options(struct erofs_fs_context *ctx)
 {
 #ifdef CONFIG_EROFS_FS_ZIP
@@ -731,7 +725,6 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	xa_init(&sbi->managed_pslots);
 #endif
 
-	/* get the root inode */
 	inode = erofs_iget(sb, ROOT_NID(sbi));
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
@@ -748,7 +741,6 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 		return -ENOMEM;
 
 	erofs_shrinker_register(sb);
-	/* sb->s_umount is already locked, SB_ACTIVE and SB_BORN are not set */
 	if (erofs_sb_has_fragments(sbi) && sbi->packed_nid) {
 		sbi->packed_inode = erofs_iget(sb, sbi->packed_nid);
 		if (IS_ERR(sbi->packed_inode)) {
@@ -881,10 +873,6 @@ static int erofs_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
-/*
- * could be triggered after deactivate_locked_super()
- * is called, thus including umount and failed to initialize.
- */
 static void erofs_kill_sb(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi;
@@ -913,7 +901,6 @@ static void erofs_kill_sb(struct super_block *sb)
 	sb->s_fs_info = NULL;
 }
 
-/* called when ->s_root is non-NULL */
 static void erofs_put_super(struct super_block *sb)
 {
 	struct erofs_sb_info *const sbi = EROFS_SB(sb);
@@ -1007,7 +994,6 @@ static void __exit erofs_module_exit(void)
 	erofs_pcpubuf_exit();
 }
 
-/* get filesystem statistics */
 static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	struct super_block *sb = dentry->d_sb;
-- 
2.19.1.6.gb485710b

