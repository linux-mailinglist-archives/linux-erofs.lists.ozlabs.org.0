Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8108E50D78C
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Apr 2022 05:29:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Kmr8n3F4wz3bYl
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Apr 2022 13:29:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54;
 helo=out30-54.freemail.mail.aliyun.com;
 envelope-from=hongnan.li@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Kmr8j2cS8z2yLg
 for <linux-erofs@lists.ozlabs.org>; Mon, 25 Apr 2022 13:29:04 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R901e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=hongnan.li@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0VB61z1y_1650857334; 
Received: from localhost(mailfrom:hongnan.li@linux.alibaba.com
 fp:SMTPD_---0VB61z1y_1650857334) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 25 Apr 2022 11:28:54 +0800
From: Hongnan Li <hongnan.li@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH v2] erofs: make filesystem exportable
Date: Mon, 25 Apr 2022 11:28:54 +0800
Message-Id: <20220425032854.43497-1-hongnan.li@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220424130104.102365-1-hongnan.li@linux.alibaba.com>
References: <20220424130104.102365-1-hongnan.li@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Implement export operations in order to make EROFS support accessing
inodes with filehandles so that it can be exported via NFS and used
by overlayfs.

Without this patch, 'exportfs -rv' will report:
exportfs: /root/erofs_mp does not support NFS export

Also tested with unionmount-testsuite and the testcase below passes now:
./run --ov --erofs --verify hard-link

For more details about the testcase, see:
https://github.com/amir73il/unionmount-testsuite/pull/6

Signed-off-by: Hongnan Li <hongnan.li@linux.alibaba.com>
---
 fs/erofs/internal.h |  2 +-
 fs/erofs/namei.c    |  5 ++---
 fs/erofs/super.c    | 40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 5298c4ee277d..12c65f647324 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -509,7 +509,7 @@ int erofs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 /* namei.c */
 extern const struct inode_operations erofs_dir_iops;
 
-int erofs_namei(struct inode *dir, struct qstr *name,
+int erofs_namei(struct inode *dir, const struct qstr *name,
 		erofs_nid_t *nid, unsigned int *d_type);
 
 /* dir.c */
diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
index 554efa363317..fd75506799c4 100644
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -165,9 +165,8 @@ static void *find_target_block_classic(struct erofs_buf *target,
 	return candidate;
 }
 
-int erofs_namei(struct inode *dir,
-		struct qstr *name,
-		erofs_nid_t *nid, unsigned int *d_type)
+int erofs_namei(struct inode *dir, const struct qstr *name, erofs_nid_t *nid,
+		unsigned int *d_type)
 {
 	int ndirents;
 	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 0c4b41130c2f..1c77b7acabd0 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -13,6 +13,7 @@
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
 #include <linux/dax.h>
+#include <linux/exportfs.h>
 #include "xattr.h"
 
 #define CREATE_TRACE_POINTS
@@ -577,6 +578,44 @@ static int erofs_init_managed_cache(struct super_block *sb)
 static int erofs_init_managed_cache(struct super_block *sb) { return 0; }
 #endif
 
+static struct inode *erofs_nfs_get_inode(struct super_block *sb,
+		u64 ino, u32 generation)
+{
+	return erofs_iget(sb, ino, false);
+}
+
+static struct dentry *erofs_fh_to_dentry(struct super_block *sb, struct fid *fid,
+		int fh_len, int fh_type)
+{
+	return generic_fh_to_dentry(sb, fid, fh_len, fh_type,
+				    erofs_nfs_get_inode);
+}
+
+static struct dentry *erofs_fh_to_parent(struct super_block *sb, struct fid *fid,
+		int fh_len, int fh_type)
+{
+	return generic_fh_to_parent(sb, fid, fh_len, fh_type,
+				    erofs_nfs_get_inode);
+}
+
+static struct dentry *erofs_get_parent(struct dentry *child)
+{
+	erofs_nid_t nid;
+	unsigned int d_type;
+	int err;
+
+	err = erofs_namei(d_inode(child), &dotdot_name, &nid, &d_type);
+	if (err)
+		return ERR_PTR(err);
+	return d_obtain_alias(erofs_iget(child->d_sb, nid, d_type == FT_DIR));
+}
+
+static const struct export_operations erofs_export_ops = {
+	.fh_to_dentry = erofs_fh_to_dentry,
+	.fh_to_parent = erofs_fh_to_parent,
+	.get_parent = erofs_get_parent,
+};
+
 static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct inode *inode;
@@ -618,6 +657,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_time_gran = 1;
 
 	sb->s_op = &erofs_sops;
+	sb->s_export_op = &erofs_export_ops;
 	sb->s_xattr = erofs_xattr_handlers;
 
 	if (test_opt(&sbi->opt, POSIX_ACL))
-- 
2.19.1.6.gb485710b

