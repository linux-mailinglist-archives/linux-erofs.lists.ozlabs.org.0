Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4B179E781
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Sep 2023 14:03:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RlzcY6Rsxz3c5c
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Sep 2023 22:03:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RlzcL65Bjz2yhL
	for <linux-erofs@lists.ozlabs.org>; Wed, 13 Sep 2023 22:03:14 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vs-bQFe_1694606588;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vs-bQFe_1694606588)
          by smtp.aliyun-inc.com;
          Wed, 13 Sep 2023 20:03:09 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v8 3/8] erofs-utils: lib: add erofs_read_xattrs_from_disk() helper
Date: Wed, 13 Sep 2023 20:02:58 +0800
Message-Id: <20230913120304.15741-4-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230913120304.15741-1-jefflexu@linux.alibaba.com>
References: <20230913120304.15741-1-jefflexu@linux.alibaba.com>
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

Add erofs_read_xattrs_from_disk() helper to reading extended
attributes from disk.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/internal.h |  1 +
 include/erofs/xattr.h    |  1 +
 lib/xattr.c              | 69 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index c36bb24..3b866c9 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -196,6 +196,7 @@ struct erofs_inode {
 	bool compressed_idata;
 	bool lazy_tailblock;
 	bool with_tmpfile;
+	bool opaque;
 	/* OVL: non-merge dir that may contain whiteout entries */
 	bool whiteouts;
 
diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index 2ecb18e..0364f24 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -58,6 +58,7 @@ int erofs_setxattr(struct erofs_inode *inode, char *key,
 		   const void *value, size_t size);
 int erofs_set_opaque_xattr(struct erofs_inode *inode);
 int erofs_set_origin_xattr(struct erofs_inode *inode);
+int erofs_read_xattrs_from_disk(struct erofs_inode *inode);
 
 #ifdef __cplusplus
 }
diff --git a/lib/xattr.c b/lib/xattr.c
index bf63a81..e3a1b44 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -566,6 +566,75 @@ int erofs_scan_file_xattrs(struct erofs_inode *inode)
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
+		} else if (S_ISDIR(inode->i_mode) &&
+			   !strcmp(key, OVL_XATTR_ORIGIN)) {
+			ret = 0;
+			inode->whiteouts = true;
+			continue;
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
 static inline unsigned int erofs_next_xattr_align(unsigned int pos,
 						  struct xattr_item *item)
 {
-- 
2.19.1.6.gb485710b

