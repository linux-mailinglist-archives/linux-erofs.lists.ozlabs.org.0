Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC03C77B040
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Aug 2023 05:43:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RPKxL4L2nz30XM
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Aug 2023 13:43:18 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RPKwv0fgfz300q
	for <linux-erofs@lists.ozlabs.org>; Mon, 14 Aug 2023 13:42:54 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vpelyrr_1691984569;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vpelyrr_1691984569)
          by smtp.aliyun-inc.com;
          Mon, 14 Aug 2023 11:42:49 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 08/13] erofs-utils: lib: add erofs_inode_tag_opaque() helper
Date: Mon, 14 Aug 2023 11:42:34 +0800
Message-Id: <20230814034239.54660-9-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230814034239.54660-1-jefflexu@linux.alibaba.com>
References: <20230814034239.54660-1-jefflexu@linux.alibaba.com>
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

Add erofs_inode_tag_opaque() helper checking if it's an opaque directory.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/erofs/internal.h |  2 ++
 include/erofs/xattr.h    | 22 ++++++++++++++++++++
 lib/tar.c                |  5 -----
 lib/xattr.c              | 44 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 68 insertions(+), 5 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 892dc96..3631cc1 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -219,6 +219,8 @@ struct erofs_inode {
 #endif
 	erofs_off_t fragmentoff;
 	unsigned int fragment_size;
+
+	bool opaque;
 };
 
 static inline erofs_off_t erofs_iloc(struct erofs_inode *inode)
diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index 634daf9..21d669b 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -73,6 +73,27 @@ static inline unsigned int xattrblock_offset(struct erofs_inode *vi,
 #ifndef XATTR_NAME_POSIX_ACL_DEFAULT
 #define XATTR_NAME_POSIX_ACL_DEFAULT "system.posix_acl_default"
 #endif
+#ifndef OVL_XATTR_NAMESPACE
+#define OVL_XATTR_NAMESPACE "overlay."
+#endif
+#ifndef OVL_XATTR_OPAQUE_POSTFIX
+#define OVL_XATTR_OPAQUE_POSTFIX "opaque"
+#endif
+#ifndef OVL_XATTR_TRUSTED_PREFIX
+#define OVL_XATTR_TRUSTED_PREFIX XATTR_TRUSTED_PREFIX OVL_XATTR_NAMESPACE
+#endif
+#ifndef OVL_XATTR_OPAQUE_SUFFIX
+#define OVL_XATTR_OPAQUE_SUFFIX OVL_XATTR_NAMESPACE OVL_XATTR_OPAQUE_POSTFIX
+#endif
+#ifndef OVL_XATTR_OPAQUE_SUFFIX_LEN
+#define OVL_XATTR_OPAQUE_SUFFIX_LEN (sizeof(OVL_XATTR_OPAQUE_SUFFIX) - 1)
+#endif
+#ifndef OVL_XATTR_OPAQUE
+#define OVL_XATTR_OPAQUE OVL_XATTR_TRUSTED_PREFIX OVL_XATTR_OPAQUE_POSTFIX
+#endif
+#ifndef OVL_XATTR_OPAQUE_LEN
+#define OVL_XATTR_OPAQUE_LEN (sizeof(OVL_XATTR_OPAQUE) - 1)
+#endif
 
 int erofs_scan_file_xattrs(struct erofs_inode *inode);
 int erofs_prepare_xattr_ibody(struct erofs_inode *inode);
@@ -86,6 +107,7 @@ int erofs_xattr_write_name_prefixes(struct erofs_sb_info *sbi, FILE *f);
 int erofs_setxattr(struct erofs_inode *inode, char *key,
 		   const void *value, size_t size);
 int erofs_read_xattrs_from_disk(struct erofs_inode *inode);
+void erofs_inode_tag_opaque(struct erofs_inode *inode);
 
 #ifdef __cplusplus
 }
diff --git a/lib/tar.c b/lib/tar.c
index 42590d2..d7a58d2 100644
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
diff --git a/lib/xattr.c b/lib/xattr.c
index 8d8f9f0..e9aff53 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -1421,6 +1421,50 @@ int erofs_listxattr(struct erofs_inode *vi, char *buffer, size_t buffer_size)
 	return shared_listxattr(vi, &it);
 }
 
+static bool erofs_xattr_is_opaque(struct xattr_item *item)
+{
+	struct ea_type_node *tnode;
+	unsigned int plen;
+	const char *prefix;
+
+	if (item->prefix == EROFS_XATTR_INDEX_TRUSTED &&
+	    !strncmp(item->kvbuf, OVL_XATTR_OPAQUE_SUFFIX,
+		     OVL_XATTR_OPAQUE_SUFFIX_LEN))
+		return true;
+
+	if (item->prefix & EROFS_XATTR_LONG_PREFIX) {
+		list_for_each_entry(tnode, &ea_name_prefixes, list) {
+			prefix = tnode->type.prefix;
+			plen = tnode->type.prefix_len;
+			if (tnode->index == item->prefix &&
+			    plen + item->len[0] == OVL_XATTR_OPAQUE_LEN &&
+			    !strncmp(prefix, OVL_XATTR_OPAQUE, plen) &&
+			    !strncmp(item->kvbuf, OVL_XATTR_OPAQUE + plen,
+				     item->len[0]))
+				return true;
+		}
+	}
+	return false;
+}
+
+void erofs_inode_tag_opaque(struct erofs_inode *inode)
+{
+	struct inode_xattr_node *node, *n;
+
+	list_for_each_entry_safe(node, n, &inode->i_xattrs, list) {
+		if (erofs_xattr_is_opaque(node->item)) {
+			if (S_ISDIR(inode->i_mode))
+				inode->opaque = true;
+			else
+				erofs_dbg("file %s: opaque xattr on non-dir",
+					  inode->i_srcpath);
+			/* strip overlayfs xattrs */
+			list_del(&node->list);
+			free(node);
+		}
+	}
+}
+
 int erofs_xattr_insert_name_prefix(const char *prefix)
 {
 	struct ea_type_node *tnode;
-- 
2.19.1.6.gb485710b

