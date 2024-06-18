Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E5490C8DC
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jun 2024 13:17:22 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=D/FcyLWs;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W3PNb334pz3cLk
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jun 2024 21:17:19 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=D/FcyLWs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W3PNT0ZN7z3bqB
	for <linux-erofs@lists.ozlabs.org>; Tue, 18 Jun 2024 21:17:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718709426; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=h/basfQJL8uu+B0Q+zf3i/Oj3AizNLBmNXuigzNbwqQ=;
	b=D/FcyLWsYtrOxcp3894LIRGShRJHludZisf5GN8B0851KiqrFj6tN9oqjVbaYVQ19Se6iq6CbWqSuBRaWN2cJ5yXwm98f+1aqI3vQ3fFURnck2WGysUcWTxXGLY18s1SHVGFibW04hUtqs9Vd0QGwiUD2i3q7YmuDvfIqSyWTuE=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W8k-BPS_1718709421;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W8k-BPS_1718709421)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 19:17:05 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: skip all unidentified xattrs from local paths
Date: Tue, 18 Jun 2024 19:17:00 +0800
Message-Id: <20240618111700.267702-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Gael Donval <gael.donval@manchester.ac.uk>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Just warn out but continue.  Don't over-complicate for now.

Reported-by: Gael Donval <gael.donval@manchester.ac.uk>
Closes: https://lore.kernel.org/r/4abed942399fb29933f0fa85cc55d3d795ae8bcd.camel@manchester.ac.uk
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/xattr.c | 56 +++++++++++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 25 deletions(-)

diff --git a/lib/xattr.c b/lib/xattr.c
index 7b263cd..b0f80e9 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -193,14 +193,11 @@ static struct xattr_item *get_xattritem(char *kvbuf, unsigned int len[2])
 	}
 
 	item = malloc(sizeof(*item));
-	if (!item) {
-		free(kvbuf);
+	if (!item)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	if (!match_prefix(kvbuf, &item->base_index, &item->prefix_len)) {
 		free(item);
-		free(kvbuf);
 		return ERR_PTR(-ENODATA);
 	}
 	DBG_BUGON(len[0] < item->prefix_len);
@@ -232,6 +229,7 @@ static struct xattr_item *parse_one_xattr(const char *path, const char *key,
 					  unsigned int keylen)
 {
 	ssize_t ret;
+	struct xattr_item *item;
 	unsigned int len[2];
 	char *kvbuf;
 
@@ -266,20 +264,32 @@ static struct xattr_item *parse_one_xattr(const char *path, const char *key,
 		ret = getxattr(path, key, kvbuf + EROFS_XATTR_KSIZE(len),
 			       len[1], 0, XATTR_NOFOLLOW);
 #else
-		free(kvbuf);
-		return ERR_PTR(-EOPNOTSUPP);
+		ret = -EOPNOTSUPP;
+		goto out;
 #endif
 		if (ret < 0) {
-			free(kvbuf);
-			return ERR_PTR(-errno);
+			ret = -errno;
+			goto out;
 		}
 		if (len[1] != ret) {
-			erofs_err("size of xattr value got changed just now (%u-> %ld)",
+			erofs_warn("size of xattr value got changed just now (%u-> %ld)",
 				  len[1], (long)ret);
 			len[1] = ret;
 		}
 	}
-	return get_xattritem(kvbuf, len);
+
+	item = get_xattritem(kvbuf, len);
+	if (!IS_ERR(item))
+		return item;
+	if (item == ERR_PTR(-ENODATA)) {
+		erofs_warn("skipped unidentified xattr: %s", key);
+		ret = 0;
+	} else {
+		ret = PTR_ERR(item);
+	}
+out:
+	free(kvbuf);
+	return ERR_PTR(ret);
 }
 
 static struct xattr_item *erofs_get_selabel_xattr(const char *srcpath,
@@ -291,6 +301,7 @@ static struct xattr_item *erofs_get_selabel_xattr(const char *srcpath,
 		int ret;
 		unsigned int len[2];
 		char *kvbuf, *fspath;
+		struct xattr_item *item;
 
 		if (cfg.mount_point)
 			ret = asprintf(&fspath, "/%s/%s", cfg.mount_point,
@@ -324,7 +335,10 @@ static struct xattr_item *erofs_get_selabel_xattr(const char *srcpath,
 		sprintf(kvbuf, "%s", XATTR_NAME_SECURITY_SELINUX);
 		memcpy(kvbuf + EROFS_XATTR_KSIZE(len), secontext, len[1]);
 		freecon(secontext);
-		return get_xattritem(kvbuf, len);
+		item = get_xattritem(kvbuf, len);
+		if (IS_ERR(item))
+			free(kvbuf);
+		return item;
 	}
 #endif
 	return NULL;
@@ -370,18 +384,6 @@ static bool erofs_is_skipped_xattr(const char *key)
 	if (cfg.sehnd && !strcmp(key, XATTR_SECURITY_PREFIX "selinux"))
 		return true;
 #endif
-
-	/* skip xattrs with unidentified "system." prefix */
-	if (!strncmp(key, XATTR_SYSTEM_PREFIX, XATTR_SYSTEM_PREFIX_LEN)) {
-		if (!strcmp(key, XATTR_NAME_POSIX_ACL_ACCESS) ||
-		    !strcmp(key, XATTR_NAME_POSIX_ACL_DEFAULT)) {
-			return false;
-		} else {
-			erofs_warn("skip unidentified xattr: %s", key);
-			return true;
-		}
-	}
-
 	return false;
 }
 
@@ -485,8 +487,10 @@ int erofs_setxattr(struct erofs_inode *inode, char *key,
 	memcpy(kvbuf + EROFS_XATTR_KSIZE(len), value, size);
 
 	item = get_xattritem(kvbuf, len);
-	if (IS_ERR(item))
+	if (IS_ERR(item)) {
+		free(kvbuf);
 		return PTR_ERR(item);
+	}
 	DBG_BUGON(!item);
 
 	return erofs_xattr_add(&inode->i_xattrs, item);
@@ -548,8 +552,10 @@ static int erofs_droid_xattr_set_caps(struct erofs_inode *inode)
 	memcpy(kvbuf + EROFS_XATTR_KSIZE(len), &caps, len[1]);
 
 	item = get_xattritem(kvbuf, len);
-	if (IS_ERR(item))
+	if (IS_ERR(item)) {
+		free(kvbuf);
 		return PTR_ERR(item);
+	}
 	DBG_BUGON(!item);
 
 	return erofs_xattr_add(&inode->i_xattrs, item);
-- 
2.39.3

