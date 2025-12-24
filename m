Return-Path: <linux-erofs+bounces-1570-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6299CDB4A2
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Dec 2025 05:00:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dbdSb0yrcz2xnl;
	Wed, 24 Dec 2025 15:00:15 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766548815;
	cv=none; b=KJUT+dMnGlMzHlsS0S49zU7B4Bc2N1DnKxVwKCv6K1CLTR4Sy8bQcUmZTG4PJXmukJhW5Fq+Adwzh4+jeVj5y4ciZKVZ80gBIDYyGcpx6GbvbyPqwlnTQt+++zsDyDzudq3Kyep3rSaiI+p7BQ2xh6G2m99hAkp5On2gmJ5Z1l0W1JeF+48YNr3sNrX/NGdJx0cgZGIh5QC52cE0Tu+VBzMWTHGyqKcICUXxN5mjECUOjf/VA4yABekLNwlOcH7oSTLnTzmDOseUikGG75hoie9V0oCsVtDdfO9iMPToxVg9I1/KQBgHsNbqe8naEIxvgGo+qG5/+yQmMC+Pr4Lu7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766548815; c=relaxed/relaxed;
	bh=8jak7Gj9K4NB3R86iZ/fS4v6vR8Kqxv5lMrgATWjK1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JEfhTe4zvCo8nNhz61twgpmYNh6va2T8ytvemv/OmizbF8RL+Q9tjsRJiEz3EZyj87zVWY87m5jlWdIa2F113SAHnpgZ4hgrgog86eSZyhnF4J/hoBcXuHvMjitzYDwGvM2/6iH9VIEeE4J1sPAVQgyPazoVZjOaMuI65iiDqMXZ8WpgyF8BQVthCEVVotRtxjJmzvU8brdoBVTMVN9+O3zVeiV7iSouMySv7iiD2z33UltJoH3ZBRenSUrWz7b6PiMZzvjCZFZHjZNfTdoIVZcbyfF9CgzR5/9zw1+miF0oCG9xaOAQgp6vgPwZ91mes5H++nSDKzWkEAgzcrnldA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=W9COODF4; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=W9COODF4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dbdSX2WFCz2xlM
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Dec 2025 15:00:10 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766548805; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=8jak7Gj9K4NB3R86iZ/fS4v6vR8Kqxv5lMrgATWjK1o=;
	b=W9COODF4Kd3+SlX+tXsvvAPV33MHyvWCCzLiXdXNDnu/VbHV/Ui/fraOWFe4Qyd0Zk4Eb7ejQ6iTP46RIQSOF3nRg+y1Q3umn935mihjI4INEdjE//LPoGc8koepqqbbNlGe5ABLoXSVcGiHmyco9M/0qFkI+h/ccjjVTDw+dWA=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvZiqG-_1766548800 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 24 Dec 2025 12:00:04 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: lib: introduce erofs_sys_lsetxattr()
Date: Wed, 24 Dec 2025 11:59:59 +0800
Message-ID: <20251224035959.1142350-1-hsiangkao@linux.alibaba.com>
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

To wrap raw function calls for better portability.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fsck/main.c           | 12 ++----------
 include/erofs/xattr.h |  3 +++
 lib/xattr.c           | 18 ++++++++++++++++++
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 8aba964ceff1..ab697bed20c6 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -9,7 +9,6 @@
 #include <utime.h>
 #include <unistd.h>
 #include <sys/stat.h>
-#include <sys/xattr.h>
 #include "erofs/print.h"
 #include "erofs/decompress.h"
 #include "erofs/dir.h"
@@ -457,15 +456,8 @@ static int erofsfsck_dump_xattrs(struct erofs_inode *inode)
 			break;
 		}
 		if (fsckcfg.extract_path)
-#ifdef HAVE_LSETXATTR
-			ret = lsetxattr(fsckcfg.extract_path, key, value, size,
-					0);
-#elif defined(__APPLE__)
-			ret = setxattr(fsckcfg.extract_path, key, value, size,
-				       0, XATTR_NOFOLLOW);
-#else
-			ret = -EOPNOTSUPP;
-#endif
+			ret = erofs_sys_lsetxattr(fsckcfg.extract_path, key,
+						  value, size);
 		else
 			ret = 0;
 		free(value);
diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index ef80123fd9c8..4e74cc523dae 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -45,6 +45,9 @@ static inline unsigned int xattrblock_offset(struct erofs_inode *vi,
 
 struct erofs_importer;
 
+ssize_t erofs_sys_lsetxattr(const char *path, const char *name,
+			    void *value, size_t size);
+
 int erofs_xattr_init(struct erofs_sb_info *sbi);
 int erofs_scan_file_xattrs(struct erofs_inode *inode);
 int erofs_prepare_xattr_ibody(struct erofs_inode *inode, bool noroom);
diff --git a/lib/xattr.c b/lib/xattr.c
index 8f0332b44a02..68236690d5b3 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -99,6 +99,24 @@ static ssize_t erofs_sys_lgetxattr(const char *path, const char *name,
 	return -1;
 }
 
+ssize_t erofs_sys_lsetxattr(const char *path, const char *name,
+			    void *value, size_t size)
+{
+	int ret;
+
+#ifdef HAVE_LSETXATTR
+	ret = lsetxattr(path, name, value, size, 0);
+#elif defined(__APPLE__)
+	ret = setxattr(path, name, value, size, 0, XATTR_NOFOLLOW);
+#else
+	ret = -1;
+	errno = ENODATA;
+#endif
+	if (ret < 0)
+		return errno;
+	return ret;
+}
+
 /* one extra byte for the trailing `\0` of attribute name */
 #define EROFS_XATTR_KSIZE(kvlen)	(kvlen[0] + 1)
 #define EROFS_XATTR_KVSIZE(kvlen)	(EROFS_XATTR_KSIZE(kvlen) + kvlen[1])
-- 
2.43.5


