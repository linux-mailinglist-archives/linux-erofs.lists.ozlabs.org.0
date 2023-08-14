Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F3277B03F
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Aug 2023 05:43:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RPKxH4c91z30f9
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Aug 2023 13:43:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RPKwt1GN3z300q
	for <linux-erofs@lists.ozlabs.org>; Mon, 14 Aug 2023 13:42:53 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VpemM0C_1691984567;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VpemM0C_1691984567)
          by smtp.aliyun-inc.com;
          Mon, 14 Aug 2023 11:42:48 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 07/13] erofs-utils: lib: add erofs_read_xattrs_from_disk() helper
Date: Mon, 14 Aug 2023 11:42:33 +0800
Message-Id: <20230814034239.54660-8-jefflexu@linux.alibaba.com>
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

Add erofs_read_xattrs_from_disk() helper to read extended attributes
from disk.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/erofs/xattr.h |  1 +
 lib/xattr.c           | 76 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index dc27cf6..634daf9 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -85,6 +85,7 @@ int erofs_xattr_write_name_prefixes(struct erofs_sb_info *sbi, FILE *f);
 
 int erofs_setxattr(struct erofs_inode *inode, char *key,
 		   const void *value, size_t size);
+int erofs_read_xattrs_from_disk(struct erofs_inode *inode);
 
 #ifdef __cplusplus
 }
diff --git a/lib/xattr.c b/lib/xattr.c
index 12f580e..8d8f9f0 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -493,6 +493,82 @@ int erofs_scan_file_xattrs(struct erofs_inode *inode)
 	return erofs_droid_xattr_set_caps(inode);
 }
 
+static struct xattr_item *erofs_read_xattr_from_disk(struct erofs_inode *inode,
+						     char *key)
+{
+	ssize_t ret;
+	u8 prefix;
+	u16 prefixlen;
+	unsigned int len[2];
+	char *kvbuf;
+
+	if (!match_prefix(key, &prefix, &prefixlen))
+		return ERR_PTR(-ENODATA);
+
+	ret = erofs_getxattr(inode, key, NULL, 0);
+	if (ret < 0)
+		return ERR_PTR(-errno);
+
+	/* allocate key-value buffer */
+	len[0] = strlen(key) - prefixlen;
+	len[1] = ret;
+	kvbuf = malloc(len[0] + len[1]);
+	if (!kvbuf)
+		return ERR_PTR(-ENOMEM);
+	memcpy(kvbuf, key + prefixlen, len[0]);
+	if (len[1]) {
+		ret = erofs_getxattr(inode, key, kvbuf + len[0], len[1]);
+		if (ret < 0) {
+			free(kvbuf);
+			return ERR_PTR(-errno);
+		}
+		if (ret != len[1]) {
+			erofs_err("size of xattr value got changed just now (%u-> %ld)",
+				  len[1], (long)ret);
+			len[1] = ret;
+		}
+	}
+	return get_xattritem(prefix, kvbuf, len);
+}
+
+int erofs_read_xattrs_from_disk(struct erofs_inode *inode)
+{
+	ssize_t kllen;
+	char *keylst, *key;
+	struct xattr_item *item;
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
+		goto err;
+
+	for (key = keylst; key < keylst + kllen; key += strlen(key) + 1) {
+		item = erofs_read_xattr_from_disk(inode, key);
+		if (IS_ERR(item)) {
+			ret = PTR_ERR(item);
+			goto err;
+		}
+
+		ret = erofs_xattr_add(&inode->i_xattrs, item);
+		if (ret < 0)
+			goto err;
+	}
+err:
+	free(keylst);
+	return ret;
+}
+
 int erofs_prepare_xattr_ibody(struct erofs_inode *inode)
 {
 	int ret;
-- 
2.19.1.6.gb485710b

