Return-Path: <linux-erofs+bounces-1628-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D07EBCE62A7
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Dec 2025 08:50:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dfpKg6cX5z2xpg;
	Mon, 29 Dec 2025 18:50:15 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766994615;
	cv=none; b=lv80WXSaeDDIf7VggtblT3TMKxZPtwtDJkqsbTYmdPcD+EYS3QtkNcaGDufdu8qczSo05XLPKulN+P0pzIvnvDzQUlshVFnIHrbud6QgRA+PekY3TyzCwmfp4aKdJfY6u7hP3BQRbqIZbAE0EYRFSMeBFSSJWAe+hAcK8I8BMo+bKuT4UPTDIxpjBlfeMvqKZAlS/d6+brwR2ytxWzA5GGcfX03agYokBhtRjYEY+1DNRnEPdLv66AVoYIbYs+CNHTkJPK0kWXi01KNFCMDEKE4W2ZRy6KkUEHwY6bfXAYbq1k+BeCGZOqoisUVN2LXcd4wK07LBD3tDkvfnrjj3Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766994615; c=relaxed/relaxed;
	bh=I4nJlqu1iU+Puek83C71ZvDpV7msxBAcUGo1ErbcTds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OzvJgDvA8G19sJn1d2kI2+devSWzAZD1NDeipj0NhDWk1V0ZBJS+UHIwaFawFqU5fAmlXtri8S1SLk469EPjE4Lsan4Ohyd5aPbfgT1YfzIcXU5MUzrx0DMoa7NxsxhaYeir9/o5MzElI+Oiwicr3uhyxhP7eLzBrgmcWyhzdhEAKfggGvN0gkGD5vu9Q3/K7aFfXCTg7cbO123K3kHpKCN/QZQucAmyhT2RPWesj48KQZrkMQfLLi7eR7S5vsrMe0qZWHy7ZkOebR5HOcjpaAvnQ+AwpaNZA3uDcHewwflgCIknCTlde3HojFoYFPqEPIRZKXyCgJzs2Qq3DXpJjA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pKcgX/wA; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pKcgX/wA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dfpKd0JVSz2x9M
	for <linux-erofs@lists.ozlabs.org>; Mon, 29 Dec 2025 18:50:11 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766994605; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=I4nJlqu1iU+Puek83C71ZvDpV7msxBAcUGo1ErbcTds=;
	b=pKcgX/wAXyuRRCE0OhLWb0OgnYTFzViTPS1dTdkFhHXq76tA78nxDeymPvaG7g5wX/XD9K4TCm+C8neBo68HG3Z8Z36NVcDAZhbm/w5ETl8dlaCi20OM4HCpC/1XGGnSsxwV9vu1q/ZmUqo7nU/kHH8p2XHK7GYRmkU6h+lu87g=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wvpylpz_1766994600 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 29 Dec 2025 15:50:04 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Hongbo Li <lihongbo22@huawei.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/2] erofs-utils: lib: introduce prefix-aware erofs_setxattr()
Date: Mon, 29 Dec 2025 15:49:58 +0800
Message-ID: <20251229074959.2147985-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Allows users to specify a predefined prefix for xattr names.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/xattr.h |  5 +++--
 lib/tar.c             |  2 +-
 lib/xattr.c           | 45 +++++++++++++++++++++++++++++++++----------
 3 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index 83aca44f8e44..941bed778956 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -36,9 +36,10 @@ int erofs_xattr_insert_name_prefix(const char *prefix);
 void erofs_xattr_cleanup_name_prefixes(void);
 int erofs_xattr_flush_name_prefixes(struct erofs_importer *im, bool plain);
 int erofs_xattr_prefixes_init(struct erofs_sb_info *sbi);
-
-int erofs_setxattr(struct erofs_inode *inode, char *key,
+int erofs_setxattr(struct erofs_inode *inode, int index, const char *name,
 		   const void *value, size_t size);
+int erofs_vfs_setxattr(struct erofs_inode *inode, const char *name,
+		       const void *value, size_t size);
 int erofs_set_opaque_xattr(struct erofs_inode *inode);
 void erofs_clear_opaque_xattr(struct erofs_inode *inode);
 int erofs_set_origin_xattr(struct erofs_inode *inode);
diff --git a/lib/tar.c b/lib/tar.c
index 16da593c3df1..8aa90c7dc0d4 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -411,7 +411,7 @@ int tarerofs_apply_xattrs(struct erofs_inode *inode, struct list_head *xattrs)
 		item->kv[item->namelen] = '\0';
 		erofs_dbg("Recording xattr(%s)=\"%s\" (of %u bytes) to file %s",
 			  item->kv, v, vsz, inode->i_srcpath);
-		ret = erofs_setxattr(inode, item->kv, v, vsz);
+		ret = erofs_vfs_setxattr(inode, item->kv, v, vsz);
 		if (ret == -ENODATA)
 			erofs_err("Failed to set xattr(%s)=%s to file %s",
 				  item->kv, v, inode->i_srcpath);
diff --git a/lib/xattr.c b/lib/xattr.c
index 96be0b1bede5..b6b1a5e600fb 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -179,7 +179,7 @@ static struct erofs_xattr_prefix {
 	const char *prefix;
 	unsigned int prefix_len;
 } xattr_types[] = {
-	[EROFS_XATTR_INDEX_USER] = {
+	[0] = {""}, [EROFS_XATTR_INDEX_USER] = {
 		XATTR_USER_PREFIX,
 		XATTR_USER_PREFIX_LEN
 	}, [EROFS_XATTR_INDEX_POSIX_ACL_ACCESS] = {
@@ -501,22 +501,41 @@ err:
 	return ret;
 }
 
-int erofs_setxattr(struct erofs_inode *inode, char *key,
-		   const void *value, size_t size)
+int erofs_setxattr(struct erofs_inode *inode, int index,
+		   const char *name, const void *value, size_t size)
 {
 	struct erofs_sb_info *sbi = inode->sbi;
-	char *kvbuf;
-	unsigned int len[2];
 	struct erofs_xattritem *item;
+	struct erofs_xattr_prefix *prefix = NULL;
+	struct ea_type_node *tnode;
+	unsigned int len[2];
+	int prefix_len;
+	char *kvbuf;
 
-	len[0] = strlen(key);
+	if (index & EROFS_XATTR_LONG_PREFIX) {
+		list_for_each_entry(tnode, &ea_name_prefixes, list) {
+			if (index == tnode->index) {
+				prefix = &tnode->type;
+				break;
+			}
+		}
+	} else if (index < ARRAY_SIZE(xattr_types)) {
+		prefix = &xattr_types[index];
+	}
+
+	if (!prefix)
+		return -EINVAL;
+
+	prefix_len = prefix->prefix_len;
+	len[0] = prefix_len + strlen(name);
 	len[1] = size;
 
 	kvbuf = malloc(EROFS_XATTR_KVSIZE(len));
 	if (!kvbuf)
 		return -ENOMEM;
 
-	memcpy(kvbuf, key, EROFS_XATTR_KSIZE(len));
+	memcpy(kvbuf, prefix->prefix, prefix_len);
+	memcpy(kvbuf + prefix_len, name, EROFS_XATTR_KSIZE(len) - prefix_len);
 	memcpy(kvbuf + EROFS_XATTR_KSIZE(len), value, size);
 
 	item = get_xattritem(sbi, kvbuf, len);
@@ -528,6 +547,12 @@ int erofs_setxattr(struct erofs_inode *inode, char *key,
 	return erofs_inode_xattr_add(&inode->i_xattrs, item);
 }
 
+int erofs_vfs_setxattr(struct erofs_inode *inode, const char *name,
+		       const void *value, size_t size)
+{
+	return erofs_setxattr(inode, 0, name, value, size);
+}
+
 static void erofs_removexattr(struct erofs_inode *inode, const char *key)
 {
 	struct erofs_inode_xattr_node *node, *n;
@@ -543,7 +568,7 @@ static void erofs_removexattr(struct erofs_inode *inode, const char *key)
 
 int erofs_set_opaque_xattr(struct erofs_inode *inode)
 {
-	return erofs_setxattr(inode, OVL_XATTR_OPAQUE, "y", 1);
+	return erofs_vfs_setxattr(inode, OVL_XATTR_OPAQUE, "y", 1);
 }
 
 void erofs_clear_opaque_xattr(struct erofs_inode *inode)
@@ -553,7 +578,7 @@ void erofs_clear_opaque_xattr(struct erofs_inode *inode)
 
 int erofs_set_origin_xattr(struct erofs_inode *inode)
 {
-	return erofs_setxattr(inode, OVL_XATTR_ORIGIN, NULL, 0);
+	return erofs_vfs_setxattr(inode, OVL_XATTR_ORIGIN, NULL, 0);
 }
 
 #ifdef WITH_ANDROID
@@ -671,7 +696,7 @@ int erofs_read_xattrs_from_disk(struct erofs_inode *inode)
 			continue;
 		}
 
-		ret = erofs_setxattr(inode, key, value, size);
+		ret = erofs_vfs_setxattr(inode, key, value, size);
 		free(value);
 		if (ret)
 			break;
-- 
2.43.5


