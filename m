Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD0978FB5E
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Sep 2023 11:47:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RcY9F2C2Qz3c33
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Sep 2023 19:47:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RcY8z6KYyz3bTt
	for <linux-erofs@lists.ozlabs.org>; Fri,  1 Sep 2023 19:47:15 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vr4h6AG_1693561630;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vr4h6AG_1693561630)
          by smtp.aliyun-inc.com;
          Fri, 01 Sep 2023 17:47:10 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v5 3/8] erofs-utils: lib: add erofs_read_xattrs_from_disk() helper
Date: Fri,  1 Sep 2023 17:47:01 +0800
Message-Id: <20230901094706.27539-4-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230901094706.27539-1-jefflexu@linux.alibaba.com>
References: <20230901094706.27539-1-jefflexu@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add erofs_read_xattrs_from_disk() helper reading extended attributes
from disk, add checking if it's an opaque directory.

Move all xattr name related macros to xattr.c and introduce
erofs_set_opaque_xattr() helper to hide all these details.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/erofs/internal.h |   1 +
 include/erofs/xattr.h    |  33 +-----------
 lib/tar.c                |   7 +--
 lib/xattr.c              | 112 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 116 insertions(+), 37 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 382024a..6020553 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -191,6 +191,7 @@ struct erofs_inode {
 	bool compressed_idata;
 	bool lazy_tailblock;
 	bool with_tmpfile;
+	bool opaque;
 
 	unsigned int xattr_isize;
 	unsigned int extent_isize;
diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index cf02257..9fa1ad1 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -43,37 +43,6 @@ static inline unsigned int xattrblock_offset(struct erofs_inode *vi,
 	(_size - sizeof(struct erofs_xattr_ibody_header)) / \
 	sizeof(struct erofs_xattr_entry) + 1; })
 
-#ifndef XATTR_SYSTEM_PREFIX
-#define XATTR_SYSTEM_PREFIX	"system."
-#endif
-#ifndef XATTR_SYSTEM_PREFIX_LEN
-#define XATTR_SYSTEM_PREFIX_LEN (sizeof(XATTR_SYSTEM_PREFIX) - 1)
-#endif
-#ifndef XATTR_USER_PREFIX
-#define XATTR_USER_PREFIX	"user."
-#endif
-#ifndef XATTR_USER_PREFIX_LEN
-#define XATTR_USER_PREFIX_LEN (sizeof(XATTR_USER_PREFIX) - 1)
-#endif
-#ifndef XATTR_SECURITY_PREFIX
-#define XATTR_SECURITY_PREFIX	"security."
-#endif
-#ifndef XATTR_SECURITY_PREFIX_LEN
-#define XATTR_SECURITY_PREFIX_LEN (sizeof(XATTR_SECURITY_PREFIX) - 1)
-#endif
-#ifndef XATTR_TRUSTED_PREFIX
-#define XATTR_TRUSTED_PREFIX	"trusted."
-#endif
-#ifndef XATTR_TRUSTED_PREFIX_LEN
-#define XATTR_TRUSTED_PREFIX_LEN (sizeof(XATTR_TRUSTED_PREFIX) - 1)
-#endif
-#ifndef XATTR_NAME_POSIX_ACL_ACCESS
-#define XATTR_NAME_POSIX_ACL_ACCESS "system.posix_acl_access"
-#endif
-#ifndef XATTR_NAME_POSIX_ACL_DEFAULT
-#define XATTR_NAME_POSIX_ACL_DEFAULT "system.posix_acl_default"
-#endif
-
 int erofs_scan_file_xattrs(struct erofs_inode *inode);
 int erofs_prepare_xattr_ibody(struct erofs_inode *inode);
 char *erofs_export_xattr_ibody(struct erofs_inode *inode);
@@ -87,6 +56,8 @@ int erofs_xattr_prefixes_init(struct erofs_sb_info *sbi);
 
 int erofs_setxattr(struct erofs_inode *inode, char *key,
 		   const void *value, size_t size);
+int erofs_set_opaque_xattr(struct erofs_inode *inode);
+int erofs_read_xattrs_from_disk(struct erofs_inode *inode);
 
 #ifdef __cplusplus
 }
diff --git a/lib/tar.c b/lib/tar.c
index 53196c1..5b63cf5 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -19,11 +19,6 @@
 #include "erofs/xattr.h"
 #include "erofs/blobchunk.h"
 
-#define OVL_XATTR_NAMESPACE "overlay."
-#define OVL_XATTR_TRUSTED_PREFIX XATTR_TRUSTED_PREFIX OVL_XATTR_NAMESPACE
-#define OVL_XATTR_OPAQUE_POSTFIX "opaque"
-#define OVL_XATTR_OPAQUE OVL_XATTR_TRUSTED_PREFIX OVL_XATTR_OPAQUE_POSTFIX
-
 #define EROFS_WHITEOUT_DEV	0
 
 static char erofs_libbuf[16384];
@@ -788,7 +783,7 @@ restart:
 	} else if (opq) {
 		DBG_BUGON(d->type == EROFS_FT_UNKNOWN);
 		DBG_BUGON(!d->inode);
-		ret = erofs_setxattr(d->inode, OVL_XATTR_OPAQUE, "y", 1);
+		ret = erofs_set_opaque_xattr(d->inode);
 		goto out;
 	} else if (th.typeflag == '1') {	/* hard link cases */
 		struct erofs_dentry *d2;
diff --git a/lib/xattr.c b/lib/xattr.c
index 0cab29f..d7fca46 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -21,6 +21,49 @@
 #include "erofs/xxhash.h"
 #include "liberofs_private.h"
 
+#ifndef XATTR_SYSTEM_PREFIX
+#define XATTR_SYSTEM_PREFIX	"system."
+#endif
+#ifndef XATTR_SYSTEM_PREFIX_LEN
+#define XATTR_SYSTEM_PREFIX_LEN (sizeof(XATTR_SYSTEM_PREFIX) - 1)
+#endif
+#ifndef XATTR_USER_PREFIX
+#define XATTR_USER_PREFIX	"user."
+#endif
+#ifndef XATTR_USER_PREFIX_LEN
+#define XATTR_USER_PREFIX_LEN (sizeof(XATTR_USER_PREFIX) - 1)
+#endif
+#ifndef XATTR_SECURITY_PREFIX
+#define XATTR_SECURITY_PREFIX	"security."
+#endif
+#ifndef XATTR_SECURITY_PREFIX_LEN
+#define XATTR_SECURITY_PREFIX_LEN (sizeof(XATTR_SECURITY_PREFIX) - 1)
+#endif
+#ifndef XATTR_TRUSTED_PREFIX
+#define XATTR_TRUSTED_PREFIX	"trusted."
+#endif
+#ifndef XATTR_TRUSTED_PREFIX_LEN
+#define XATTR_TRUSTED_PREFIX_LEN (sizeof(XATTR_TRUSTED_PREFIX) - 1)
+#endif
+#ifndef XATTR_NAME_POSIX_ACL_ACCESS
+#define XATTR_NAME_POSIX_ACL_ACCESS "system.posix_acl_access"
+#endif
+#ifndef XATTR_NAME_POSIX_ACL_DEFAULT
+#define XATTR_NAME_POSIX_ACL_DEFAULT "system.posix_acl_default"
+#endif
+#ifndef OVL_XATTR_NAMESPACE
+#define OVL_XATTR_NAMESPACE "overlay."
+#endif
+#ifndef OVL_XATTR_OPAQUE_POSTFIX
+#define OVL_XATTR_OPAQUE_POSTFIX "opaque"
+#endif
+#ifndef OVL_XATTR_TRUSTED_PREFIX
+#define OVL_XATTR_TRUSTED_PREFIX XATTR_TRUSTED_PREFIX OVL_XATTR_NAMESPACE
+#endif
+#ifndef OVL_XATTR_OPAQUE
+#define OVL_XATTR_OPAQUE OVL_XATTR_TRUSTED_PREFIX OVL_XATTR_OPAQUE_POSTFIX
+#endif
+
 #define EA_HASHTABLE_BITS 16
 
 struct xattr_item {
@@ -443,6 +486,11 @@ int erofs_setxattr(struct erofs_inode *inode, char *key,
 	return erofs_xattr_add(&inode->i_xattrs, item);
 }
 
+int erofs_set_opaque_xattr(struct erofs_inode *inode)
+{
+	return erofs_setxattr(inode, OVL_XATTR_OPAQUE, "y", 1);
+}
+
 #ifdef WITH_ANDROID
 static int erofs_droid_xattr_set_caps(struct erofs_inode *inode)
 {
@@ -501,6 +549,70 @@ int erofs_scan_file_xattrs(struct erofs_inode *inode)
 	return erofs_droid_xattr_set_caps(inode);
 }
 
+int erofs_read_xattrs_from_disk(struct erofs_inode *inode)
+{
+	ssize_t kllen;
+	char *keylst, *key;
+	int ret;
+
+	init_list_head(&inode->i_xattrs);
+	kllen = erofs_listxattr(inode, NULL, 0);
+	if (kllen < 0)
+		return kllen;
+	if (kllen <= 1)
+		return 0;
+
+	keylst = malloc(kllen);
+	if (!keylst)
+		return -ENOMEM;
+
+	ret = erofs_listxattr(inode, keylst, kllen);
+	if (ret < 0)
+		goto out;
+
+	for (key = keylst; key < keylst + kllen; key += strlen(key) + 1) {
+		void *value = NULL;
+		size_t size = 0;
+
+		if (!strcmp(key, OVL_XATTR_OPAQUE)) {
+			if (!S_ISDIR(inode->i_mode)) {
+				erofs_dbg("file %s: opaque xattr on non-dir",
+					  inode->i_srcpath);
+				ret = -EINVAL;
+				goto out;
+			}
+			inode->opaque = true;
+		}
+
+		ret = erofs_getxattr(inode, key, NULL, 0);
+		if (ret < 0)
+			goto out;
+		if (ret) {
+			size = ret;
+			value = malloc(size);
+			if (!value) {
+				ret = -ENOMEM;
+				goto out;
+			}
+
+			ret = erofs_getxattr(inode, key, value, size);
+			if (ret < 0) {
+				free(value);
+				goto out;
+			}
+			DBG_BUGON(ret != size);
+		}
+
+		ret = erofs_setxattr(inode, key, value, size);
+		free(value);
+		if (ret)
+			break;
+	}
+out:
+	free(keylst);
+	return ret;
+}
+
 int erofs_prepare_xattr_ibody(struct erofs_inode *inode)
 {
 	int ret;
-- 
2.19.1.6.gb485710b

