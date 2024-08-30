Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF88A9657DC
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2024 08:56:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ww87M0R2Zz309k
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2024 16:55:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725000956;
	cv=none; b=Iohd9qQEmqHDHRBUgxk5Iaha0f9jU9igIAtJI+VuqshRl/fYay0xBjVAY/W4KoLdupxgTOWYCUlr105qwVXhBeUmAprlNGUHV3qSvG3mxHD5nLdDLigDzKodhGzOocdZ2Yjzkj3Lyc3AEbjeTs8PmwP6sr40t9wUpDK6cv7qNPeCPQ0F9tr+lZBHVzOvK2/9G2c4ro6JzGPuxCAW2eYLqzmPn6fzggcjaQD/977p0E2yrI01Y9t9eoGmEqL5K+ktyRTG6vAtLboTLJ9RlHWob3hfCxmpvnzg1fGXC78RbOdktckeXU6in6SqOit38OhJqtLoAkZGxpuKSa5kFnAE5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725000956; c=relaxed/relaxed;
	bh=BGF7wHny2+dUCKUkXdbBs1BNywcjrjxFyEtP4h5cr1w=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=hHjiELbjjWXx7iXM3yIt5ykYfT+4w5cjS6Fc/rlOVL18VisPm1MeF7igZv5icno677DQ4BleZOKz4a0jePwwSS2QvOCRNj0MC/sF8G16Z/lBpBGLYm+Cd3mMz6gXBAyfUGp+aT4NOyka0Hqw7T7NU2GAW4A7maUgfx0VXgM+6BbWRYaRamFk9JJUBLD8upmro7C5PqzQFuM9Da+ZAcb4J50k40aRBQovrFFBCxufqC4NQKo3872+fl+AmB4wnY13jeY7q/kb96tevdfVBJYHJsir/Pfmt0jAkre6x8mKmywA6/oHTRXqlV8nyYT+o1Y4o6KmhhwMasv1b/v5YIg5Vg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Dk9KT9SE; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Dk9KT9SE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ww87H3C1Qz2xHt
	for <linux-erofs@lists.ozlabs.org>; Fri, 30 Aug 2024 16:55:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725000948; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=BGF7wHny2+dUCKUkXdbBs1BNywcjrjxFyEtP4h5cr1w=;
	b=Dk9KT9SEM0qmxAguDGb9gEKWHb29wAGYe8RC+GgHwbjGT0AlK8chopH+bUWZVeYxwdUFPKqoGLMyHfjTyLiMqVFl26aZd1pIz7GqMWuIW6fRHwUjnZeqUEeamPkeTSSkh7zrCoIWc9hYQWrHhyyJdb7STY8gMezpCxPUmFLVz/I=
Received: from localhost.localdomain(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WDvp6G4_1725000943)
          by smtp.aliyun-inc.com;
          Fri, 30 Aug 2024 14:55:47 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: lib: don't include <lzma.h> and <zlib.h> in external headers
Date: Fri, 30 Aug 2024 14:55:42 +0800
Message-Id: <20240830065542.94908-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Applications don't need internal header dependencies.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/tar.h | 12 +-----------
 lib/tar.c           | 15 ++++++++++++---
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/include/erofs/tar.h b/include/erofs/tar.h
index 6fa72eb..42fbb00 100644
--- a/include/erofs/tar.h
+++ b/include/erofs/tar.h
@@ -7,9 +7,6 @@ extern "C"
 {
 #endif
 
-#if defined(HAVE_ZLIB)
-#include <zlib.h>
-#endif
 #include <sys/stat.h>
 
 #include "internal.h"
@@ -28,14 +25,7 @@ struct erofs_pax_header {
 #define EROFS_IOS_DECODER_GZIP		1
 #define EROFS_IOS_DECODER_LIBLZMA	2
 
-#ifdef HAVE_LIBLZMA
-#include <lzma.h>
-struct erofs_iostream_liblzma {
-	u8 inbuf[32768];
-	lzma_stream strm;
-	int fd;
-};
-#endif
+struct erofs_iostream_liblzma;
 
 struct erofs_iostream {
 	union {
diff --git a/lib/tar.c b/lib/tar.c
index a9b425e..7e89b92 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -3,9 +3,6 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sys/stat.h>
-#if defined(HAVE_ZLIB)
-#include <zlib.h>
-#endif
 #include "erofs/print.h"
 #include "erofs/cache.h"
 #include "erofs/diskbuf.h"
@@ -15,6 +12,9 @@
 #include "erofs/xattr.h"
 #include "erofs/blobchunk.h"
 #include "erofs/rebuild.h"
+#if defined(HAVE_ZLIB)
+#include <zlib.h>
+#endif
 
 /* This file is a tape/volume header.  Ignore it on extraction.  */
 #define GNUTYPE_VOLHDR 'V'
@@ -39,6 +39,15 @@ struct tar_header {
 	char padding[12];	/* 500-512 (pad to exactly the 512 byte) */
 };
 
+#ifdef HAVE_LIBLZMA
+#include <lzma.h>
+struct erofs_iostream_liblzma {
+	u8 inbuf[32768];
+	lzma_stream strm;
+	int fd;
+};
+#endif
+
 void erofs_iostream_close(struct erofs_iostream *ios)
 {
 	free(ios->buffer);
-- 
2.39.3 (Apple Git-146)

