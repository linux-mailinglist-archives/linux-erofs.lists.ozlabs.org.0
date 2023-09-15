Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7007A18B4
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Sep 2023 10:26:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rn6jW18ryz3cG0
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Sep 2023 18:26:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rn6jM3sQ6z3c1C
	for <linux-erofs@lists.ozlabs.org>; Fri, 15 Sep 2023 18:26:30 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vs6ZaH1_1694766380;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vs6ZaH1_1694766380)
          by smtp.aliyun-inc.com;
          Fri, 15 Sep 2023 16:26:24 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: mkfs: pop up most recently used dentries for tarerofs
Date: Fri, 15 Sep 2023 16:26:19 +0800
Message-Id: <20230915082619.3533530-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Each tar header keeps the full file path.  It's useful to move most
recently used intermediate dirs to list heads.

User time of tarerofs index mode can be reduced by 19%.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/rebuild.h | 2 +-
 lib/rebuild.c           | 9 +++++++--
 lib/tar.c               | 5 +++--
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/erofs/rebuild.h b/include/erofs/rebuild.h
index 3ac074c..e99ce74 100644
--- a/include/erofs/rebuild.h
+++ b/include/erofs/rebuild.h
@@ -10,7 +10,7 @@ extern "C"
 #include "internal.h"
 
 struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_inode *pwd,
-		char *path, bool aufs, bool *whout, bool *opq);
+		char *path, bool aufs, bool *whout, bool *opq, bool to_head);
 
 int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_sb_info *sbi);
 
diff --git a/lib/rebuild.c b/lib/rebuild.c
index 27a1df4..9751f0e 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -52,7 +52,7 @@ static struct erofs_dentry *erofs_rebuild_mkdir(struct erofs_inode *dir,
 }
 
 struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_inode *pwd,
-		char *path, bool aufs, bool *whout, bool *opq)
+		char *path, bool aufs, bool *whout, bool *opq, bool to_head)
 {
 	struct erofs_dentry *d = NULL;
 	unsigned int len = strlen(path);
@@ -100,6 +100,10 @@ struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_inode *pwd,
 			}
 
 			if (inode) {
+				if (to_head) {
+					list_del(&d->d_child);
+					list_add(&d->d_child, &pwd->i_subdirs);
+				}
 				pwd = inode;
 			} else if (!slash) {
 				d = erofs_d_alloc(pwd, s);
@@ -262,7 +266,8 @@ static int erofs_rebuild_dirent_iter(struct erofs_dir_context *ctx)
 	erofs_dbg("parsing %s", path);
 	dname = path + strlen(parent->i_srcpath) + 1;
 
-	d = erofs_rebuild_get_dentry(parent, dname, false, &dumb, &dumb);
+	d = erofs_rebuild_get_dentry(parent, dname, false,
+				     &dumb, &dumb, false);
 	if (IS_ERR(d)) {
 		ret = PTR_ERR(d);
 		goto out;
diff --git a/lib/tar.c b/lib/tar.c
index 0f0e7c5..9685fe5 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -662,7 +662,7 @@ restart:
 
 	erofs_dbg("parsing %s (mode %05o)", eh.path, st.st_mode);
 
-	d = erofs_rebuild_get_dentry(root, eh.path, tar->aufs, &whout, &opq);
+	d = erofs_rebuild_get_dentry(root, eh.path, tar->aufs, &whout, &opq, true);
 	if (IS_ERR(d)) {
 		ret = PTR_ERR(d);
 		goto out;
@@ -695,7 +695,8 @@ restart:
 		}
 		d->inode = NULL;
 
-		d2 = erofs_rebuild_get_dentry(root, eh.link, tar->aufs, &dumb, &dumb);
+		d2 = erofs_rebuild_get_dentry(root, eh.link, tar->aufs,
+					      &dumb, &dumb, false);
 		if (IS_ERR(d2)) {
 			ret = PTR_ERR(d2);
 			goto out;
-- 
2.39.3

