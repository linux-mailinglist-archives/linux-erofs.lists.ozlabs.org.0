Return-Path: <linux-erofs+bounces-480-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6FEAE2925
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Jun 2025 15:29:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bPZtd3FwQz2xsW;
	Sat, 21 Jun 2025 23:28:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750512537;
	cv=none; b=GPz2zTmnf7CIaf2HsjWmlAPLl7WoTSx/cl5JtU1MvzSkHpXt7tFpIkfeaDcEsCmZFTn5bEPGQ32Nvuyydf3IEbzvssIHAlKdHwNh3fyU0wD23L9M2E2cIXb6e/mAF8ZUl8A4oYw+fJWqZOHJitnuzqqshQqnQ2vy4i4QwI+yxD6ADbD8OtnPTJ75ySSCvA5zfB8ch9OuShcUFOqlzoHN2p5KIZt0UqG8APmxUqffKGaxfJRg9Q9ObP5drlaG6gAzQ7ks4JaVTjAQoGkbsRNiyALA1eZx4PaAwrbATUvk9a8BvAATh2dKRo8MOh1g4j2QWH8t33NWFUjVU6MC2kivig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750512537; c=relaxed/relaxed;
	bh=VA3frBWfRnboEErP00VshKz9auplTTqEUSJLGwKAWKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RY7XkyENZ6c81NJxUpGX8euGV96YBlsbqZWbzCmiL/KeZGFmMZawJRWc6W3BOKLzncEJi8g2pVXrhdcGfS7FO1AAqqvSpJ13kQfsM3JlIiiZIlg52Bia1Nk9TvA9jbPFMNZL0NC/xJOlvYgKIjY+0Gufn2PEfZv/GAI+eC3mpDkYafteZt4hJIMUiCD5rRP+OOTljHL2FK4/O+AYn+edYc0n3Z1C1X3zTocItdKMR1oisHYhAZCTqMtfoUtFvvyubRGsS8jWfRAPqVAZX/FSqJmx4RPUopXtK3hNN8jg08SYSUuF15MwhO60rhKE0WAwOR5ux1cQZL/S/tRslD/0Qg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=UjhyO3Pt; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=UjhyO3Pt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bPZtX0pqyz2xS2
	for <linux-erofs@lists.ozlabs.org>; Sat, 21 Jun 2025 23:28:50 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1750512526; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=VA3frBWfRnboEErP00VshKz9auplTTqEUSJLGwKAWKE=;
	b=UjhyO3Ptr1f4/HRK6FhwMcC1dj7m223Rb59Tvea8aO6+U80reITMW6VOc/qRI14BKC5YFk45la42uciHXK9vpNAV+TED8j8YI0f7cUNduKbwL6qXW4nKIuzoYjNfPP8Evpl5i64EuJeoEWCK36hgR9ewD1zInuqdJMs9mmlIRKw=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WeO-ZOQ_1750512520 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 21 Jun 2025 21:28:45 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/2] erofs-utils: lib: add erofs_sys_l{list,get}xattr wrappers
Date: Sat, 21 Jun 2025 21:28:39 +0800
Message-ID: <20250621132840.3036887-1-hsiangkao@linux.alibaba.com>
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

It avoids macro messiness.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/xattr.c | 67 +++++++++++++++++++++++++----------------------------
 1 file changed, 32 insertions(+), 35 deletions(-)

diff --git a/lib/xattr.c b/lib/xattr.c
index 68a96cc..b382ee4 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -75,6 +75,28 @@
 #define OVL_XATTR_ORIGIN OVL_XATTR_TRUSTED_PREFIX OVL_XATTR_ORIGIN_POSTFIX
 #endif
 
+static ssize_t erofs_sys_llistxattr(const char *path, char *list, size_t size)
+{
+#ifdef HAVE_LLISTXATTR
+	return llistxattr(path, list, size);
+#elif defined(__APPLE__)
+	return listxattr(path, list, size, XATTR_NOFOLLOW);
+#endif
+	return 0;
+}
+
+static ssize_t erofs_sys_lgetxattr(const char *path, const char *name,
+				   void *value, size_t size)
+{
+#ifdef HAVE_LGETXATTR
+	return lgetxattr(path, name, value, size);
+#elif defined(__APPLE__)
+	return getxattr(path, name, value, size, 0, XATTR_NOFOLLOW);
+#endif
+	errno = ENODATA;
+	return -1;
+}
+
 #define EA_HASHTABLE_BITS 16
 
 /* one extra byte for the trailing `\0` of attribute name */
@@ -241,13 +263,7 @@ static struct xattr_item *parse_one_xattr(const char *path, const char *key,
 	len[0] = keylen;
 
 	/* determine length of the value */
-#ifdef HAVE_LGETXATTR
-	ret = lgetxattr(path, key, NULL, 0);
-#elif defined(__APPLE__)
-	ret = getxattr(path, key, NULL, 0, 0, XATTR_NOFOLLOW);
-#else
-	return ERR_PTR(-EOPNOTSUPP);
-#endif
+	ret = erofs_sys_lgetxattr(path, key, NULL, 0);
 	if (ret < 0)
 		return ERR_PTR(-errno);
 	len[1] = ret;
@@ -259,16 +275,9 @@ static struct xattr_item *parse_one_xattr(const char *path, const char *key,
 	memcpy(kvbuf, key, EROFS_XATTR_KSIZE(len));
 	if (len[1]) {
 		/* copy value to buffer */
-#ifdef HAVE_LGETXATTR
-		ret = lgetxattr(path, key, kvbuf + EROFS_XATTR_KSIZE(len),
-				len[1]);
-#elif defined(__APPLE__)
-		ret = getxattr(path, key, kvbuf + EROFS_XATTR_KSIZE(len),
-			       len[1], 0, XATTR_NOFOLLOW);
-#else
-		ret = -EOPNOTSUPP;
-		goto out;
-#endif
+		ret = erofs_sys_lgetxattr(path, key,
+					  kvbuf + EROFS_XATTR_KSIZE(len),
+					  len[1]);
 		if (ret < 0) {
 			ret = -errno;
 			goto out;
@@ -392,21 +401,15 @@ static bool erofs_is_skipped_xattr(const char *key)
 static int read_xattrs_from_file(const char *path, mode_t mode,
 				 struct list_head *ixattrs)
 {
-#ifdef HAVE_LLISTXATTR
-	ssize_t kllen = llistxattr(path, NULL, 0);
-#elif defined(__APPLE__)
-	ssize_t kllen = listxattr(path, NULL, 0, XATTR_NOFOLLOW);
-#else
-	ssize_t kllen = 0;
-#endif
-	int ret;
+	ssize_t kllen = erofs_sys_llistxattr(path, NULL, 0);
 	char *keylst, *key, *klend;
 	unsigned int keylen;
 	struct xattr_item *item;
+	int ret;
 
 	if (kllen < 0 && errno != ENODATA && errno != EOPNOTSUPP) {
-		erofs_err("llistxattr to get the size of names for %s failed",
-			  path);
+		erofs_err("failed to get the size of the xattr list for %s: %s",
+			  path, strerror(errno));
 		return -errno;
 	}
 
@@ -419,19 +422,13 @@ static int read_xattrs_from_file(const char *path, mode_t mode,
 		return -ENOMEM;
 
 	/* copy the list of attribute keys to the buffer.*/
-#ifdef HAVE_LLISTXATTR
-	kllen = llistxattr(path, keylst, kllen);
-#elif defined(__APPLE__)
-	kllen = listxattr(path, keylst, kllen, XATTR_NOFOLLOW);
+	kllen = erofs_sys_llistxattr(path, keylst, kllen);
 	if (kllen < 0) {
 		erofs_err("llistxattr to get names for %s failed", path);
 		ret = -errno;
 		goto err;
 	}
-#else
-	ret = -EOPNOTSUPP;
-	goto err;
-#endif
+
 	/*
 	 * loop over the list of zero terminated strings with the
 	 * attribute keys. Use the remaining buffer length to determine
-- 
2.43.5


