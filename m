Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9077921CA
	for <lists+linux-erofs@lfdr.de>; Tue,  5 Sep 2023 12:03:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rg1KX27tVz301V
	for <lists+linux-erofs@lfdr.de>; Tue,  5 Sep 2023 20:03:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rg1Jz29ZZz3bv2
	for <linux-erofs@lists.ozlabs.org>; Tue,  5 Sep 2023 20:02:42 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VrPV9f7_1693908157;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VrPV9f7_1693908157)
          by smtp.aliyun-inc.com;
          Tue, 05 Sep 2023 18:02:38 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v6 10/11] erofs-utils: lib: set origin xattr on parent directory of whiteout
Date: Tue,  5 Sep 2023 18:02:26 +0800
Message-Id: <20230905100227.1072-11-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230905100227.1072-1-jefflexu@linux.alibaba.com>
References: <20230905100227.1072-1-jefflexu@linux.alibaba.com>
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

Whiteouts will be exposed in the overlayfs mount if the whiteouts are
from non-merged directory without origin xattr set on the directory.

To fix this, set origin xattr (with empty value) on parent directory of
whiteouts, marking the parent directory as copied-up to avoid exposing
whiteouts in the overlayfs mount.

To avoid setting multiple origin xattrs on the same directory when
there are multiple whiteouts under the directory, enhance
erofs_setxattr() so that it could skip duplicate xattrs.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/erofs/xattr.h |  3 ++-
 lib/rebuild.c         |  6 ++++++
 lib/tar.c             |  9 ++++++++-
 lib/xattr.c           | 27 ++++++++++++++++++++++++---
 4 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index 9fa1ad1..62d0b8b 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -55,8 +55,9 @@ void erofs_xattr_prefixes_cleanup(struct erofs_sb_info *sbi);
 int erofs_xattr_prefixes_init(struct erofs_sb_info *sbi);
 
 int erofs_setxattr(struct erofs_inode *inode, char *key,
-		   const void *value, size_t size);
+		   const void *value, size_t size, bool nodup);
 int erofs_set_opaque_xattr(struct erofs_inode *inode);
+int erofs_set_origin_xattr(struct erofs_inode *inode);
 int erofs_read_xattrs_from_disk(struct erofs_inode *inode);
 
 #ifdef __cplusplus
diff --git a/lib/rebuild.c b/lib/rebuild.c
index 477d68d..b254dea 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -200,6 +200,12 @@ static int erofs_rebuild_fill_inode(struct erofs_inode *inode)
 
 	switch (inode->i_mode & S_IFMT) {
 	case S_IFCHR:
+		if (erofs_inode_is_whiteout(inode)) {
+			ret = erofs_set_origin_xattr(inode->i_parent);
+			if (ret)
+				break;
+		}
+		/* fallthrough */
 	case S_IFBLK:
 	case S_IFIFO:
 	case S_IFSOCK:
diff --git a/lib/tar.c b/lib/tar.c
index 8cb392c..b75b723 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -206,7 +206,7 @@ int tarerofs_apply_xattrs(struct erofs_inode *inode, struct list_head *xattrs)
 		item->kv[item->namelen] = '\0';
 		erofs_dbg("Recording xattr(%s)=\"%s\" (of %u bytes) to file %s",
 			  item->kv, v, vsz, inode->i_srcpath);
-		ret = erofs_setxattr(inode, item->kv, v, vsz);
+		ret = erofs_setxattr(inode, item->kv, v, vsz, false);
 		if (ret == -ENODATA)
 			erofs_err("Failed to set xattr(%s)=%s to file %s",
 				  item->kv, v, inode->i_srcpath);
@@ -740,6 +740,13 @@ new_inode:
 		inode->i_mode = (inode->i_mode & ~S_IFMT) | S_IFCHR;
 		inode->u.i_rdev = EROFS_WHITEOUT_DEV;
 		d->type = EROFS_FT_CHRDEV;
+		/*
+		 * Mark parent directory as copied-up to avoid exposing
+		 * whiteouts in the overlayfs mount.
+		 */
+		ret = erofs_set_origin_xattr(inode->i_parent);
+		if (ret)
+			goto out;
 	} else {
 		inode->i_mode = st.st_mode;
 		if (S_ISBLK(st.st_mode) || S_ISCHR(st.st_mode))
diff --git a/lib/xattr.c b/lib/xattr.c
index cc6a393..feafe96 100644
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
 
@@ -455,11 +461,12 @@ err:
 }
 
 int erofs_setxattr(struct erofs_inode *inode, char *key,
-		   const void *value, size_t size)
+		   const void *value, size_t size, bool nodup)
 {
 	char *kvbuf;
 	unsigned int len[2];
 	struct xattr_item *item;
+	struct inode_xattr_node *node;
 	u8 prefix;
 	u16 prefixlen;
 
@@ -481,12 +488,26 @@ int erofs_setxattr(struct erofs_inode *inode, char *key,
 	if (IS_ERR(item))
 		return PTR_ERR(item);
 
+	if (nodup) {
+		list_for_each_entry(node, &inode->i_xattrs, list) {
+			if (node->item == item) {
+				put_xattritem(item);
+				return 0;
+			}
+		}
+	}
+
 	return erofs_xattr_add(&inode->i_xattrs, item);
 }
 
 int erofs_set_opaque_xattr(struct erofs_inode *inode)
 {
-	return erofs_setxattr(inode, OVL_XATTR_OPAQUE, "y", 1);
+	return erofs_setxattr(inode, OVL_XATTR_OPAQUE, "y", 1, false);
+}
+
+int erofs_set_origin_xattr(struct erofs_inode *inode)
+{
+	return erofs_setxattr(inode, OVL_XATTR_ORIGIN, NULL, 0, true);
 }
 
 #ifdef WITH_ANDROID
@@ -599,7 +620,7 @@ int erofs_read_xattrs_from_disk(struct erofs_inode *inode)
 			DBG_BUGON(ret != size);
 		}
 
-		ret = erofs_setxattr(inode, key, value, size);
+		ret = erofs_setxattr(inode, key, value, size, false);
 		free(value);
 		if (ret)
 			break;
-- 
2.19.1.6.gb485710b

