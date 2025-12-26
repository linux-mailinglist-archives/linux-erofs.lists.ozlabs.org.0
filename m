Return-Path: <linux-erofs+bounces-1606-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9752ECDE435
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Dec 2025 04:05:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dcr855BjVz2xSX;
	Fri, 26 Dec 2025 14:05:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766718309;
	cv=none; b=l3Qm25b9ho738xPvK4R7CMPuetqol9FdqUk/f6REjd3/XaaKdn5t+8HkFGY2CAWUvpJ1AOY/OoJJpZFOzV+bss1AQtsEl7GropHU7zQSDBWpD5CNxtnBMTycd50//HcZggDpNTZSPgTLjn4Xc6GLQLoqRK3MF5mqqicQwXgG+97QwA23g4lIfK/mZlIoJkgTlXxq6NFguS3yb6rVkSzxuYfEP9icNeG7eA0SoU0OfHydVq9CUBCZc0qhiVlb868lOCy787kKRmoApm4NP/XSpWSFfhrOQ9IRZ2IKj4mLeX5pdGhWOBQOeSmNpcLIQSY4VwXhZhgpSm26ssxl0IB2Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766718309; c=relaxed/relaxed;
	bh=TYZRmWvyoN7JqLlrTmZDomdzUrTerKQksQZeJ6Yuf0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SM9kipRYJWKGxH1qTAyiojyN2Z1hfbNQXlEbRKjwvSBgx7Dg9mPF/tpdunBRsKAMyjUIndj+roOXCwML9o8OfuhYXZEsNO2+qikHoHcEOoz/GDTDNc1WxBD1PyytJRKbH1DvWOTfPKIlTM/ANygLtc1QHVJE7gaIHC5t2sTPZ73WVEv7YCevgRgPFYhsmoqW2NfFuY3lFkpM8KPwfvdjtysjGKPWFp9VmFAGgRLbg1YS9CctQGxJ9xEVupyu/IWYMohx2eD89UYnztLYDLae56FKoFHWomqw+FxbA0RyMY4bABPkPhHGuiinWUPJzLhguYsoTi+Ow8Ul3cD+GqqZ+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=aCmKp+3h; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=aCmKp+3h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dcr7x05QWz2x99
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Dec 2025 14:04:58 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766718293; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=TYZRmWvyoN7JqLlrTmZDomdzUrTerKQksQZeJ6Yuf0o=;
	b=aCmKp+3hf9oW82Cc7LzaGO3UnVZsAXplSl08jcUoF+lpH5k8rx42jX0TfcMngI43zPEWk0o+O/VEVKC0TP5w+DjQcyO0Ex0A3xxvwTGnlypS7e7/j3GI2nGPCd3tFdLQWv1xaG5aceVr0mKH/K6A1tZJNU3l/7SQcALBopx/VZE=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvgC3Fm_1766718286 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 26 Dec 2025 11:04:51 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: fix OS portability for extended attributes
Date: Fri, 26 Dec 2025 11:04:45 +0800
Message-ID: <20251226030445.538717-1-hsiangkao@linux.alibaba.com>
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

For example, macOS has ENODATA, but getxattr() returns ENOATTR.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 configure.ac        |  1 +
 include/erofs/err.h |  4 ++++
 lib/xattr.c         | 34 +++++++++++++++++++++-------------
 3 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/configure.ac b/configure.ac
index 0c03a1d27496..8ad8af2c61c2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -248,6 +248,7 @@ AC_CHECK_HEADERS(m4_flatten([
 	sys/sysmacros.h
 	sys/time.h
 	sys/uio.h
+	sys/xattr.h
 	unistd.h
 ]))
 
diff --git a/include/erofs/err.h b/include/erofs/err.h
index ff488dd391f9..59c8c9cc9ae3 100644
--- a/include/erofs/err.h
+++ b/include/erofs/err.h
@@ -16,6 +16,10 @@ extern "C"
 #include <string.h>
 #include <stdio.h>
 
+#ifndef ENODATA
+#define ENODATA ENOATTR
+#endif
+
 static inline const char *erofs_strerror(int err)
 {
 	static char msg[256];
diff --git a/lib/xattr.c b/lib/xattr.c
index e991c56e384d..96be0b1bede5 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -6,10 +6,6 @@
  */
 #define _GNU_SOURCE
 #include <stdlib.h>
-#include <sys/xattr.h>
-#ifdef HAVE_LINUX_XATTR_H
-#include <linux/xattr.h>
-#endif
 #include <sys/stat.h>
 #include <dirent.h>
 #include "erofs/print.h"
@@ -21,6 +17,12 @@
 #include "liberofs_metabox.h"
 #include "liberofs_xxhash.h"
 #include "liberofs_private.h"
+#ifdef HAVE_SYS_XATTR_H
+#include <sys/xattr.h>
+#endif
+#ifdef HAVE_LINUX_XATTR_H
+#include <linux/xattr.h>
+#endif
 
 #ifndef XATTR_SYSTEM_PREFIX
 #define XATTR_SYSTEM_PREFIX	"system."
@@ -90,13 +92,21 @@ static ssize_t erofs_sys_llistxattr(const char *path, char *list, size_t size)
 static ssize_t erofs_sys_lgetxattr(const char *path, const char *name,
 				   void *value, size_t size)
 {
+	int ret = -ENODATA;
+
 #ifdef HAVE_LGETXATTR
-	return lgetxattr(path, name, value, size);
+	ret = lgetxattr(path, name, value, size);
+	if (ret < 0)
+		ret = -errno;
 #elif defined(__APPLE__)
-	return getxattr(path, name, value, size, 0, XATTR_NOFOLLOW);
+	ret = getxattr(path, name, value, size, 0, XATTR_NOFOLLOW);
+	if (ret < 0) {
+		ret = -errno;
+		if (ret == -ENOATTR)
+			ret = -ENODATA;
+	}
 #endif
-	errno = ENODATA;
-	return -1;
+	return ret;
 }
 
 ssize_t erofs_sys_lsetxattr(const char *path, const char *name,
@@ -305,7 +315,7 @@ static struct erofs_xattritem *parse_one_xattr(struct erofs_sb_info *sbi,
 	/* determine length of the value */
 	ret = erofs_sys_lgetxattr(path, key, NULL, 0);
 	if (ret < 0)
-		return ERR_PTR(-errno);
+		return ERR_PTR(ret);
 	len[1] = ret;
 
 	/* allocate key-value buffer */
@@ -318,10 +328,8 @@ static struct erofs_xattritem *parse_one_xattr(struct erofs_sb_info *sbi,
 		ret = erofs_sys_lgetxattr(path, key,
 					  kvbuf + EROFS_XATTR_KSIZE(len),
 					  len[1]);
-		if (ret < 0) {
-			ret = -errno;
+		if (ret < 0)
 			goto out;
-		}
 		if (len[1] != ret) {
 			erofs_warn("size of xattr value got changed just now (%u-> %ld)",
 				  len[1], (long)ret);
@@ -424,7 +432,7 @@ static int read_xattrs_from_file(struct erofs_sb_info *sbi, const char *path,
 	struct erofs_xattritem *item;
 	int ret;
 
-	if (kllen < 0 && errno != ENODATA && errno != EOPNOTSUPP) {
+	if (kllen < 0 && errno != ENODATA && errno != ENOTSUP) {
 		erofs_err("failed to get the size of the xattr list for %s: %s",
 			  path, strerror(errno));
 		return -errno;
-- 
2.43.5


