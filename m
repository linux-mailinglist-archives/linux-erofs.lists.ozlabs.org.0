Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 471155EBACB
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Sep 2022 08:36:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Mc8zD1rjYz3bxt
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Sep 2022 16:36:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43; helo=out30-43.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mc8z856MWz2xh0
	for <linux-erofs@lists.ozlabs.org>; Tue, 27 Sep 2022 16:36:19 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VQqcSak_1664260573;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VQqcSak_1664260573)
          by smtp.aliyun-inc.com;
          Tue, 27 Sep 2022 14:36:14 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs: clean up erofs_iget()
Date: Tue, 27 Sep 2022 14:36:07 +0800
Message-Id: <20220927063607.54832-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20220927063607.54832-1-hsiangkao@linux.alibaba.com>
References: <20220927063607.54832-1-hsiangkao@linux.alibaba.com>
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

isdir indicated REQ_META|REQ_PRIO which no longer works now.
Get rid of isdir entirely.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/inode.c             | 24 ++++++++----------------
 fs/erofs/internal.h          |  2 +-
 fs/erofs/namei.c             |  2 +-
 fs/erofs/super.c             |  8 ++++----
 include/trace/events/erofs.h | 11 ++++-------
 5 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 16cf9a283557..ad2a82f2eb4c 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -241,7 +241,7 @@ static int erofs_fill_symlink(struct inode *inode, void *kaddr,
 	return 0;
 }
 
-static int erofs_fill_inode(struct inode *inode, int isdir)
+static int erofs_fill_inode(struct inode *inode)
 {
 	struct erofs_inode *vi = EROFS_I(inode);
 	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
@@ -249,7 +249,7 @@ static int erofs_fill_inode(struct inode *inode, int isdir)
 	unsigned int ofs;
 	int err = 0;
 
-	trace_erofs_fill_inode(inode, isdir);
+	trace_erofs_fill_inode(inode);
 
 	/* read inode base data from disk */
 	kaddr = erofs_read_inode(&buf, inode, &ofs);
@@ -324,21 +324,13 @@ static int erofs_iget_set_actor(struct inode *inode, void *opaque)
 	return 0;
 }
 
-static inline struct inode *erofs_iget_locked(struct super_block *sb,
-					      erofs_nid_t nid)
+struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid)
 {
 	const unsigned long hashval = erofs_inode_hash(nid);
+	struct inode *inode;
 
-	return iget5_locked(sb, hashval, erofs_ilookup_test_actor,
+	inode = iget5_locked(sb, hashval, erofs_ilookup_test_actor,
 		erofs_iget_set_actor, &nid);
-}
-
-struct inode *erofs_iget(struct super_block *sb,
-			 erofs_nid_t nid,
-			 bool isdir)
-{
-	struct inode *inode = erofs_iget_locked(sb, nid);
-
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
@@ -348,10 +340,10 @@ struct inode *erofs_iget(struct super_block *sb,
 
 		vi->nid = nid;
 
-		err = erofs_fill_inode(inode, isdir);
-		if (!err)
+		err = erofs_fill_inode(inode);
+		if (!err) {
 			unlock_new_inode(inode);
-		else {
+		} else {
 			iget_failed(inode);
 			inode = ERR_PTR(err);
 		}
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 0318530bc78a..1701df48c446 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -492,7 +492,7 @@ extern const struct inode_operations erofs_generic_iops;
 extern const struct inode_operations erofs_symlink_iops;
 extern const struct inode_operations erofs_fast_symlink_iops;
 
-struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid, bool dir);
+struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid);
 int erofs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		  struct kstat *stat, u32 request_mask,
 		  unsigned int query_flags);
diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
index afbb80d4e2f1..0dc34721080c 100644
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -219,7 +219,7 @@ static struct dentry *erofs_lookup(struct inode *dir, struct dentry *dentry,
 	} else {
 		erofs_dbg("%s, %pd (nid %llu) found, d_type %u", __func__,
 			  dentry, nid, d_type);
-		inode = erofs_iget(dir->i_sb, nid, d_type == FT_DIR);
+		inode = erofs_iget(dir->i_sb, nid);
 	}
 	return d_splice_alias(inode, dentry);
 }
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 8040534ae5c0..2cf96ce1c32e 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -385,7 +385,7 @@ static int erofs_read_superblock(struct super_block *sb)
 	sbi->packed_inode = NULL;
 	if (erofs_sb_has_fragments(sbi) && dsb->packed_nid) {
 		sbi->packed_inode =
-			erofs_iget(sb, le64_to_cpu(dsb->packed_nid), false);
+			erofs_iget(sb, le64_to_cpu(dsb->packed_nid));
 		if (IS_ERR(sbi->packed_inode)) {
 			ret = PTR_ERR(sbi->packed_inode);
 			goto out;
@@ -668,7 +668,7 @@ static int erofs_init_managed_cache(struct super_block *sb) { return 0; }
 static struct inode *erofs_nfs_get_inode(struct super_block *sb,
 					 u64 ino, u32 generation)
 {
-	return erofs_iget(sb, ino, false);
+	return erofs_iget(sb, ino);
 }
 
 static struct dentry *erofs_fh_to_dentry(struct super_block *sb,
@@ -694,7 +694,7 @@ static struct dentry *erofs_get_parent(struct dentry *child)
 	err = erofs_namei(d_inode(child), &dotdot_name, &nid, &d_type);
 	if (err)
 		return ERR_PTR(err);
-	return d_obtain_alias(erofs_iget(child->d_sb, nid, d_type == FT_DIR));
+	return d_obtain_alias(erofs_iget(child->d_sb, nid));
 }
 
 static const struct export_operations erofs_export_ops = {
@@ -782,7 +782,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 #endif
 
 	/* get the root inode */
-	inode = erofs_iget(sb, ROOT_NID(sbi), true);
+	inode = erofs_iget(sb, ROOT_NID(sbi));
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
index 57de057bd503..4f4c44ea3a65 100644
--- a/include/trace/events/erofs.h
+++ b/include/trace/events/erofs.h
@@ -53,15 +53,14 @@ TRACE_EVENT(erofs_lookup,
 );
 
 TRACE_EVENT(erofs_fill_inode,
-	TP_PROTO(struct inode *inode, int isdir),
-	TP_ARGS(inode, isdir),
+	TP_PROTO(struct inode *inode),
+	TP_ARGS(inode),
 
 	TP_STRUCT__entry(
 		__field(dev_t,		dev	)
 		__field(erofs_nid_t,	nid	)
 		__field(erofs_blk_t,	blkaddr )
 		__field(unsigned int,	ofs	)
-		__field(int,		isdir	)
 	),
 
 	TP_fast_assign(
@@ -69,13 +68,11 @@ TRACE_EVENT(erofs_fill_inode,
 		__entry->nid		= EROFS_I(inode)->nid;
 		__entry->blkaddr	= erofs_blknr(iloc(EROFS_I_SB(inode), __entry->nid));
 		__entry->ofs		= erofs_blkoff(iloc(EROFS_I_SB(inode), __entry->nid));
-		__entry->isdir		= isdir;
 	),
 
-	TP_printk("dev = (%d,%d), nid = %llu, blkaddr %u ofs %u, isdir %d",
+	TP_printk("dev = (%d,%d), nid = %llu, blkaddr %u ofs %u",
 		  show_dev_nid(__entry),
-		  __entry->blkaddr, __entry->ofs,
-		  __entry->isdir)
+		  __entry->blkaddr, __entry->ofs)
 );
 
 TRACE_EVENT(erofs_readpage,
-- 
2.24.4

