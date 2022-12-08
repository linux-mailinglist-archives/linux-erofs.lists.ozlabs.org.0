Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE5F646B18
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Dec 2022 09:54:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NSSd84wlXz3cBX
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Dec 2022 19:54:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=ieb7HuFz;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=raj.khem@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=ieb7HuFz;
	dkim-atps=neutral
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NSScQ0CFWz3bjc
	for <linux-erofs@lists.ozlabs.org>; Thu,  8 Dec 2022 19:53:41 +1100 (AEDT)
Received: by mail-pl1-x62b.google.com with SMTP id a9so902242pld.7
        for <linux-erofs@lists.ozlabs.org>; Thu, 08 Dec 2022 00:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/WFTQfXY3OCWmLAHf7UjDeqcbYOhDX3l3rEvTo2NQQ=;
        b=ieb7HuFz/TzEFv42+aQh1MpZFXbYPY5maSx6hUuzHpbL7sx4Hm5YgQdVVL3+JfRVCr
         cCSavDmPf/5j6FwMEEO7zdtPdaEZcL8bMqqj6uPCg0dYlYkbPwb5Ef/ppmf0AyaKYY41
         fsXCzgr7Ag5ElkbVXzQHVSpsgyoUcQd2bTEwG6yFHZ3Wj1eu8hVg3JCagtIlaY8o+EZg
         1OWNR1EY6KRYS6GtFWkX17nbpRUvkKXEsYgMhjfese9/oxVNbv4g6Fmxkkl1UHvYyU1O
         ETFAHidHoiI9TmusmZAn+lR4zORsuGeh2xUDDqpR9iqVYDRPuY3lJZAECdoUksIiR8jy
         ZiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J/WFTQfXY3OCWmLAHf7UjDeqcbYOhDX3l3rEvTo2NQQ=;
        b=Xp8iB5uR7OFDDo8SZSsfqlGGMYtkUyPi92xCUuiwJKh70y9Rn2BVbe0Dg7sEEVQ3y4
         WgPtLuag5x+NWtt4Rl1vwNaOKFjRiTIbJSLf8+dYIEf1f19x9CvijjS5SruzB8ltwWd0
         n4bkzj2VdvvujrLBt6ta6YCma2QxGKwJ0gY0Pq7BPlGPLs9Mx70q5mFFWq6TaMy7RdXg
         9mtwNHgahyFk2sjTZ0D0vGXQ5xnScXZTRuk0Z4IRQU6VqNlKwVCTAbjQU9P6UiN4ikJi
         FJkad8HXpUWu0mQ/wqXTqZZoLlTl6AXY8RxHeZX9KTEeGE0eFjtZYcIIWlFugnU0VnS0
         F27w==
X-Gm-Message-State: ANoB5plsTfrJhIW3GMsy6vuhlLE0pzLumh+Y6PqjHjE17QrzCpAVolj4
	d672mzpj+pTLPk7NuASosj6SYdabANM=
X-Google-Smtp-Source: AA0mqf6gKViCdyIbqEoEocbUZaP4auTM3CpvKmyA4EQgbfo0GZ6UTWMakEsRA6XT9SSJFPLS4P08Eg==
X-Received: by 2002:a17:90a:5d8d:b0:212:f7f2:3522 with SMTP id t13-20020a17090a5d8d00b00212f7f23522mr1939144pji.38.1670489619359;
        Thu, 08 Dec 2022 00:53:39 -0800 (PST)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9181:1cf0::7d9c])
        by smtp.gmail.com with ESMTPSA id k1-20020a17090a7f0100b00205db4ff6dfsm2398392pjl.46.2022.12.08.00.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 00:53:38 -0800 (PST)
From: Khem Raj <raj.khem@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/3] erofs_fs.h: Make LFS mandatory for all usecases
Date: Thu,  8 Dec 2022 00:53:34 -0800
Message-Id: <20221208085335.2884608-2-raj.khem@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221208085335.2884608-1-raj.khem@gmail.com>
References: <20221208085335.2884608-1-raj.khem@gmail.com>
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
Cc: Khem Raj <raj.khem@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

erosfs depend on the consistent use of a 64bit offset
type, force downstreams to use transparent LFS (_FILE_OFFSET_BITS=64),
so that it becomes impossible for them to use 32bit interfaces.

include autoconf'ed config.h to get definition of _FILE_OFFSET_BITS
which was detected by configure. This header needs to be included
before any system headers are included to ensure they see the correct
definition of _FILE_OFFSET_BITS for the platform

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 dump/main.c              | 1 +
 fsck/main.c              | 1 +
 include/erofs/internal.h | 1 +
 include/erofs_fs.h       | 6 ++++++
 lib/Makefile.am          | 2 +-
 mkfs/main.c              | 1 +
 6 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/dump/main.c b/dump/main.c
index 49ff2b7..1b40f2a 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -6,6 +6,7 @@
  *            Guo Xuenan <guoxuenan@huawei.com>
  */
 #define _GNU_SOURCE
+#include "config.h"
 #include <stdlib.h>
 #include <getopt.h>
 #include <time.h>
diff --git a/fsck/main.c b/fsck/main.c
index 5a2f659..82eef93 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -3,6 +3,7 @@
  * Copyright 2021 Google LLC
  * Author: Daeho Jeong <daehojeong@google.com>
  */
+#include "config.h"
 #include <stdlib.h>
 #include <getopt.h>
 #include <time.h>
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 6a70f11..9cc20a8 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -12,6 +12,7 @@ extern "C"
 {
 #endif
 
+#include <config.h>
 #include "list.h"
 #include "err.h"
 
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 08f9761..a3bd93c 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -9,6 +9,8 @@
 #ifndef __EROFS_FS_H
 #define __EROFS_FS_H
 
+#include <sys/types.h>
+
 #define EROFS_SUPER_MAGIC_V1    0xE0F5E1E2
 #define EROFS_SUPER_OFFSET      1024
 
@@ -410,6 +412,10 @@ enum {
 
 #define EROFS_NAME_LEN      255
 
+
+/* make sure that any user of the erofs headers has atleast 64bit off_t type */
+extern int eros_assert_largefile[sizeof(off_t)-8];
+
 /* check the EROFS on-disk layout strictly at compile time */
 static inline void erofs_check_ondisk_layout_definitions(void)
 {
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 3fad357..88400ed 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -28,7 +28,7 @@ noinst_HEADERS += compressor.h
 liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
 		      namei.c data.c compress.c compressor.c zmap.c decompress.c \
 		      compress_hints.c hashmap.c sha256.c blobchunk.c dir.c
-liberofs_la_CFLAGS = -Wall -I$(top_srcdir)/include
+liberofs_la_CFLAGS = -Wall -I$(top_builddir) -I$(top_srcdir)/include -include config.h
 if ENABLE_LZ4
 liberofs_la_CFLAGS += ${LZ4_CFLAGS}
 liberofs_la_SOURCES += compressor_lz4.c
diff --git a/mkfs/main.c b/mkfs/main.c
index d2c9830..0e601d9 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -5,6 +5,7 @@
  * Created by Li Guifu <bluce.liguifu@huawei.com>
  */
 #define _GNU_SOURCE
+#include "config.h"
 #include <time.h>
 #include <sys/time.h>
 #include <stdlib.h>
-- 
2.38.1

