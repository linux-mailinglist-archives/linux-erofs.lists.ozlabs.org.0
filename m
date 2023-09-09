Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3C17999FC
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Sep 2023 18:33:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rjdnk4nPgz3cCw
	for <lists+linux-erofs@lfdr.de>; Sun, 10 Sep 2023 02:33:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RjdnT2ddnz3bw8
	for <linux-erofs@lists.ozlabs.org>; Sun, 10 Sep 2023 02:33:00 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VrfyqRi_1694277172;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VrfyqRi_1694277172)
          by smtp.aliyun-inc.com;
          Sun, 10 Sep 2023 00:32:55 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v7 04/13] erofs-utils: lib: set OVL_XATTR_ORIGIN for directories with whiteouts
Date: Sun, 10 Sep 2023 00:32:31 +0800
Message-Id: <20230909163240.42057-5-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230909163240.42057-1-hsiangkao@linux.alibaba.com>
References: <20230909163240.42057-1-hsiangkao@linux.alibaba.com>
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

From: Jingbo Xu <jefflexu@linux.alibaba.com>

Whiteouts are exposed in the overlayfs mount if these are from some
non-merged directory without OVL_XATTR_ORIGIN set on the directory.

To fix this, tag OVL_XATTR_ORIGIN (with empty value) on the parent
directory of whiteouts.

Fixes: 95d315fd7958 ("erofs-utils: introduce tarerofs")
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/internal.h |  2 ++
 include/erofs/xattr.h    |  1 +
 lib/inode.c              |  3 +++
 lib/tar.c                |  7 +++++++
 lib/xattr.c              | 11 +++++++++++
 5 files changed, 24 insertions(+)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index ac82336..ba4d6c6 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -192,6 +192,8 @@ struct erofs_inode {
 	bool compressed_idata;
 	bool lazy_tailblock;
 	bool with_tmpfile;
+	/* OVL: non-merge dir that may contain whiteout entries */
+	bool whiteouts;
 
 	unsigned int xattr_isize;
 	unsigned int extent_isize;
diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index 59515d7..2ecb18e 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -57,6 +57,7 @@ int erofs_xattr_prefixes_init(struct erofs_sb_info *sbi);
 int erofs_setxattr(struct erofs_inode *inode, char *key,
 		   const void *value, size_t size);
 int erofs_set_opaque_xattr(struct erofs_inode *inode);
+int erofs_set_origin_xattr(struct erofs_inode *inode);
 
 #ifdef __cplusplus
 }
diff --git a/lib/inode.c b/lib/inode.c
index a3a643f..c976be3 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1337,6 +1337,9 @@ int tarerofs_dump_tree(struct erofs_inode *dir)
 		dir->inode_isize = sizeof(struct erofs_inode_compact);
 	}
 
+	if (dir->whiteouts)
+		erofs_set_origin_xattr(dir);
+
 	ret = erofs_prepare_xattr_ibody(dir);
 	if (ret < 0)
 		return ret;
diff --git a/lib/tar.c b/lib/tar.c
index c5dbef0..b58bfd5 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -843,6 +843,13 @@ new_inode:
 		inode->i_mode = (inode->i_mode & ~S_IFMT) | S_IFCHR;
 		inode->u.i_rdev = EROFS_WHITEOUT_DEV;
 		d->type = EROFS_FT_CHRDEV;
+
+		/*
+		 * Mark the parent directory as copied-up to avoid exposing
+		 * whiteouts if mounted.  See kernel commit b79e05aaa166
+		 * ("ovl: no direct iteration for dir with origin xattr")
+		 */
+		inode->i_parent->whiteouts = true;
 	} else {
 		inode->i_mode = st.st_mode;
 		if (S_ISBLK(st.st_mode) || S_ISCHR(st.st_mode))
diff --git a/lib/xattr.c b/lib/xattr.c
index bd03831..671ae05 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -57,12 +57,18 @@
 #ifndef OVL_XATTR_OPAQUE_POSTFIX
 #define OVL_XATTR_OPAQUE_POSTFIX "opaque"
 #endif
+#ifndef OVL_XATTR_ORIGIN_POSTFIX
+#define OVL_XATTR_ORIGIN_POSTFIX "origin"
+#endif
 #ifndef OVL_XATTR_TRUSTED_PREFIX
 #define OVL_XATTR_TRUSTED_PREFIX XATTR_TRUSTED_PREFIX OVL_XATTR_NAMESPACE
 #endif
 #ifndef OVL_XATTR_OPAQUE
 #define OVL_XATTR_OPAQUE OVL_XATTR_TRUSTED_PREFIX OVL_XATTR_OPAQUE_POSTFIX
 #endif
+#ifndef OVL_XATTR_ORIGIN
+#define OVL_XATTR_ORIGIN OVL_XATTR_TRUSTED_PREFIX OVL_XATTR_ORIGIN_POSTFIX
+#endif
 
 #define EA_HASHTABLE_BITS 16
 
@@ -490,6 +496,11 @@ int erofs_set_opaque_xattr(struct erofs_inode *inode)
 	return erofs_setxattr(inode, OVL_XATTR_OPAQUE, "y", 1);
 }
 
+int erofs_set_origin_xattr(struct erofs_inode *inode)
+{
+	return erofs_setxattr(inode, OVL_XATTR_ORIGIN, NULL, 0);
+}
+
 #ifdef WITH_ANDROID
 static int erofs_droid_xattr_set_caps(struct erofs_inode *inode)
 {
-- 
2.24.4

