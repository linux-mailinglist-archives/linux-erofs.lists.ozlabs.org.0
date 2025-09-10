Return-Path: <linux-erofs+bounces-999-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF14B50A6A
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Sep 2025 03:45:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cM3RQ3plWz2xC3;
	Wed, 10 Sep 2025 11:45:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757468722;
	cv=none; b=llqKFDlepZIb+Ct4skm8EMV8n0TeBUHD5LxmH1H4SYwa9snyzoUTDwMLESxDFQMza4y8+oP3yc2V5YhZxp0Zsc3mkT6SBc80h7iFgj6FJ9DroIZ/MqwHBTU07V2rUyHKnnFfRTOuIPy4vfW/aSJVlMHam2EnAqQSmctkuuoIHfZTvP/9MBTjctW6vGuNaJCzeyhTNps3e348DvFAaj3b8r9gtUBelEltJyut4YX9oyZJdBMR3zTYFGv6pN+5OJyytRogALn48twR9QIYKAx+qDaAIXjjK+y7OyFev5UG3VWdjhgT2zx8OrF4WPxR/kxOTeFdu2om5tCMIL0OTT8CKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757468722; c=relaxed/relaxed;
	bh=ieCf+cUxF6w6cyJK94OsvY93JBquigBLg7eLe6JEU1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=edLJNLpJGvMT+85V/3/qVa52ush/CITstM2AtR2nbyY3Tp83il25dr8RXf7YrQymzzCvdmB0XacwBkeMhYVUELBMy0gfKg83dGX1Q0LGbhqUgfzQkeHrMMYoerfy+Yc5QMQIlATNjomcR+bBw7ukHrrjGnz+hLAANBFjInF02AcpwCkXGI+/6aJOeC4qBsD2NRhZurEvuVYLMEXYmBCpiVMsY9Q3lI9M17T1/SinaPawbPkGruPR+PIqJK6hjodWO5w1BT1ysqXW6Autur/q6fU2DLvQDT+cmbSEAK4AhaAYeH0Y4bFUm//5Q2Q9Fyj2KefwQrJK8YLS3uXHCbv4gg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ba45F2iv; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ba45F2iv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cM3RM23zLz3cYy
	for <linux-erofs@lists.ozlabs.org>; Wed, 10 Sep 2025 11:45:17 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757468712; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ieCf+cUxF6w6cyJK94OsvY93JBquigBLg7eLe6JEU1A=;
	b=ba45F2ivDjaPgFVJzlR4uwiSCiuq2CmaDR3RyBRkG6s5KhPTNxzjThtNjAmpRLsVl+BdTVGAo1vh0p8KsuuVOGjPzf6WXJIcwm1BwElPt5Emhj71IooFyQ8u2u9RSseI2RFnJyBhqgOEdHOidF2HwxdY02/ZXcpqKzOEiuuyLF4=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wng68UZ_1757468708 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 10 Sep 2025 09:45:11 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH] erofs-utils: lib: fix base64 for tarerofs
Date: Wed, 10 Sep 2025 09:45:07 +0800
Message-ID: <20250910014507.2116595-1-hsiangkao@linux.alibaba.com>
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

The old kernel fscrypt variant (fs/crypto/fname.c) was not real
RFC 4648 base64, see kernel commit ba47b515f594 ("fscrypt: align
Base64 encoding with RFC 4648 base64url").

Fixes: c0063a73b01b ("erofs-utils: lib: support importing xattrs from tarerofs")
Reported-by: Chengyu Zhu <hudsonzhu@tencent.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/Makefile.am       |  3 +-
 lib/base64.c          | 69 +++++++++++++++++++++++++++++++++++++++++++
 lib/liberofs_base64.h |  9 ++++++
 lib/tar.c             | 45 ++--------------------------
 4 files changed, 83 insertions(+), 43 deletions(-)
 create mode 100644 lib/base64.c
 create mode 100644 lib/liberofs_base64.h

diff --git a/lib/Makefile.am b/lib/Makefile.am
index 87454e3..daf937c 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -27,6 +27,7 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
       $(top_srcdir)/include/erofs/fragments.h \
       $(top_srcdir)/include/erofs/rebuild.h \
       $(top_srcdir)/include/erofs/importer.h \
+      $(top_srcdir)/lib/liberofs_base64.h \
       $(top_srcdir)/lib/liberofs_cache.h \
       $(top_srcdir)/lib/liberofs_private.h \
       $(top_srcdir)/lib/liberofs_xxhash.h \
@@ -40,7 +41,7 @@ liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
 		      compress_hints.c hashmap.c sha256.c blobchunk.c dir.c \
 		      fragments.c dedupe.c uuid_unparse.c uuid.c tar.c \
 		      block_list.c rebuild.c diskbuf.c bitops.c dedupe_ext.c \
-		      vmdk.c metabox.c global.c importer.c
+		      vmdk.c metabox.c global.c importer.c base64.c
 
 liberofs_la_CFLAGS = -Wall ${libuuid_CFLAGS} -I$(top_srcdir)/include
 liberofs_la_LDFLAGS =
diff --git a/lib/base64.c b/lib/base64.c
new file mode 100644
index 0000000..c5f4ad8
--- /dev/null
+++ b/lib/base64.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
+#include "liberofs_base64.h"
+#include <string.h>
+
+static const char lookup_table[65] =
+	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
+
+int erofs_base64_encode(const u8 *src, int srclen, char *dst)
+{
+        u32 ac = 0;
+        int bits = 0;
+        int i;
+        char *cp = dst;
+
+        for (i = 0; i < srclen; i++) {
+                ac = (ac << 8) | src[i];
+                bits += 8;
+                do {
+                        bits -= 6;
+                        *cp++ = lookup_table[(ac >> bits) & 0x3f];
+                } while (bits >= 6);
+        }
+        if (bits) {
+                *cp++ = lookup_table[(ac << (6 - bits)) & 0x3f];
+                bits -= 6;
+        }
+        while (bits < 0) {
+                *cp++ = '=';
+                bits += 2;
+        }
+        return cp - dst;
+}
+
+int erofs_base64_decode(const char *src, int len, u8 *dst)
+{
+	int i, bits = 0, ac = 0;
+	const char *p;
+	u8 *cp = dst;
+	bool padding = false;
+
+	if(len && !(len % 4)) {
+		/* Check for and ignore any end padding */
+		if (src[len - 2] == '=' && src[len - 1] == '=')
+			len -= 2;
+		else if (src[len - 1] == '=')
+			--len;
+		padding = true;
+	}
+
+	for (i = 0; i < len; i++) {
+		p = strchr(lookup_table, src[i]);
+		if (!p || !src[i])
+			return -2;
+		ac = (ac << 6 | (p - lookup_table));
+		bits += 6;
+		if (bits >= 8) {
+			bits -= 8;
+			*cp++ = ac >> bits;
+		}
+	}
+	ac &= BIT(bits) - 1;
+	if (ac) {
+		if (padding || ac > 0xff)
+			return -1;
+		else
+			*cp++ = ac;
+	}
+	return cp - dst;
+}
diff --git a/lib/liberofs_base64.h b/lib/liberofs_base64.h
new file mode 100644
index 0000000..bcadb5f
--- /dev/null
+++ b/lib/liberofs_base64.h
@@ -0,0 +1,9 @@
+#ifndef __EROFS_LIB_LIBEROFS_BASE64_H
+#define __EROFS_LIB_LIBEROFS_BASE64_H
+
+#include "erofs/defs.h"
+
+int erofs_base64_encode(const u8 *src, int srclen, char *dst);
+int erofs_base64_decode(const char *src, int len, u8 *dst);
+
+#endif
diff --git a/lib/tar.c b/lib/tar.c
index c8fd48e..9dd1253 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -15,6 +15,7 @@
 #if defined(HAVE_ZLIB)
 #include <zlib.h>
 #endif
+#include "liberofs_base64.h"
 #include "liberofs_cache.h"
 
 /* This file is a tape/volume header.  Ignore it on extraction.  */
@@ -400,46 +401,6 @@ int tarerofs_apply_xattrs(struct erofs_inode *inode, struct list_head *xattrs)
 	return 0;
 }
 
-static const char lookup_table[65] =
-	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
-
-static int base64_decode(const char *src, int len, u8 *dst)
-{
-	int i, bits = 0, ac = 0;
-	const char *p;
-	u8 *cp = dst;
-	bool padding = false;
-
-	if(len && !(len % 4)) {
-		/* Check for and ignore any end padding */
-		if (src[len - 2] == '=' && src[len - 1] == '=')
-			len -= 2;
-		else if (src[len - 1] == '=')
-			--len;
-		padding = true;
-	}
-
-	for (i = 0; i < len; i++) {
-		p = strchr(lookup_table, src[i]);
-		if (!p || !src[i])
-			return -2;
-		ac += (p - lookup_table) << bits;
-		bits += 6;
-		if (bits >= 8) {
-			*cp++ = ac & 0xff;
-			ac >>= 8;
-			bits -= 8;
-		}
-	}
-	if (ac) {
-		if (padding || ac > 0xff)
-			return -1;
-		else
-			*cp++ = ac & 0xff;
-	}
-	return cp - dst;
-}
-
 static int tohex(int c)
 {
 	if (c >= '0' && c <= '9')
@@ -594,8 +555,8 @@ int tarerofs_parse_pax_header(struct erofs_iostream *ios,
 				key = kv + sizeof("LIBARCHIVE.xattr.") - 1;
 				namelen = url_decode(key, value - key - 1);
 				--len; /* p[-1] == '\0' */
-				ret = base64_decode(value, len - (value - kv),
-						    (u8 *)value);
+				ret = erofs_base64_decode(value, len - (value - kv),
+							  (u8 *)value);
 				if (ret < 0) {
 					ret = -EFSCORRUPTED;
 					goto out;
-- 
2.43.5


