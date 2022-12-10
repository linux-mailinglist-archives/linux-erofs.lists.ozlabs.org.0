Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 615A3648C82
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Dec 2022 03:22:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NTWqs73SLz3bfD
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Dec 2022 13:22:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=COr8AaVE;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=raj.khem@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=COr8AaVE;
	dkim-atps=neutral
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NTWqn4QD7z3bNs
	for <linux-erofs@lists.ozlabs.org>; Sat, 10 Dec 2022 13:22:13 +1100 (AEDT)
Received: by mail-pf1-x42e.google.com with SMTP id c7so4937030pfc.12
        for <linux-erofs@lists.ozlabs.org>; Fri, 09 Dec 2022 18:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvNFb2/1/tBrVMZNF/oM0wDGdkCuTQN2d5RsP45W6aY=;
        b=COr8AaVEkPvnpe2gRlEVMYoDfMRRjpr01bpVm1AI978xqYaBOjaENEUuOeubGEE40p
         QBrtNf8IhtNglBWqLnCsiVsoajt48FQ8/VRV3qSj6JCH38NMzGpBNGxjFtTgdEvNarqT
         MaeXChx94svG2MzXIaP1KctLwe/WFFPKBlEj/9t7DHV3wMlyVyBBjCMojPjb1aYCvBLD
         /Ofb0AS+ZgJfdzWgOvSrgJf/rC/WPSa4NyDsnf4cW6HbQ08q9f4t3Fm8HnCbBSSJwUNw
         10YMiCExaJ4cUD484S7+G2HuvKwI/B2QOZjtE5o3hnQZvlBsdO6l5YumeIIy0hioTysg
         1hzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PvNFb2/1/tBrVMZNF/oM0wDGdkCuTQN2d5RsP45W6aY=;
        b=m9hOO7Sn2lHA+BFPIYMcpqjagIiEwTPAArhyYWhVuWyUmHkB1n1WcJQRpfId5bnZ0Q
         WYHmhXT3tZRm9ZmyuKpNTmN3IMjBlXWVRi33OcT0np7cTsnVGSCyfbh82Wdx1FBfFDzL
         Plu2YsJfjXkumvyjxrNE0czPQrfZaNcYI0zNSn9qtyamrs3ijyOD5z7sujvtO6J7NWBI
         I+DmoKb4NGd8VvZSWzbavgin3oRhrArto45Kr9XHYa17b2xcjO+1mSExJ7HjUlmDjuoo
         rGEs3mNqRCIsE+ai5EibXcAEH/PUDmeo1XQ9rtB2qYcJEj6emFUfGFoWbum2/Z8lyNo+
         pahg==
X-Gm-Message-State: ANoB5pm2Xih17aodUGJQ6OAVQmoAuqeqzu8GC+E5Kwu/Rt1Pbr6ZnnRq
	UbEfifk/JM9juffjAVRDQPiM1FfFK8I=
X-Google-Smtp-Source: AA0mqf4xoLplgKQaUZrmcmMAu+4G+xan7jG5moj9Vh62G0TWI4VKwfoXBhnI2FQ7tqKTyJMbHFGJ3w==
X-Received: by 2002:aa7:9a1c:0:b0:574:3e1d:72dd with SMTP id w28-20020aa79a1c000000b005743e1d72ddmr7289860pfj.19.1670638931099;
        Fri, 09 Dec 2022 18:22:11 -0800 (PST)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9181:1cf0::7d9c])
        by smtp.gmail.com with ESMTPSA id b64-20020a621b43000000b0056c3a0dc65fsm1814475pfb.71.2022.12.09.18.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 18:22:10 -0800 (PST)
From: Khem Raj <raj.khem@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [[PATCH v2 2/3] includes: Make LFS mandatory for all usecases
Date: Fri,  9 Dec 2022 18:22:06 -0800
Message-Id: <20221210022207.757975-2-raj.khem@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221210022207.757975-1-raj.khem@gmail.com>
References: <20221210022207.757975-1-raj.khem@gmail.com>
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
 include/erofs/internal.h | 6 ++++++
 lib/Makefile.am          | 2 +-
 mkfs/main.c              | 1 +
 5 files changed, 10 insertions(+), 1 deletion(-)

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
index 6a70f11..81fc07b 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -12,6 +12,7 @@ extern "C"
 {
 #endif
 
+#include <config.h>
 #include "list.h"
 #include "err.h"
 
@@ -21,6 +22,7 @@ typedef unsigned short umode_t;
 
 #include "erofs_fs.h"
 #include <fcntl.h>
+#include <sys/types.h> /* for off_t definition */
 
 #ifndef PATH_MAX
 #define PATH_MAX        4096    /* # chars in a path name including nul */
@@ -104,6 +106,10 @@ struct erofs_sb_info {
 	};
 };
 
+
+/* make sure that any user of the erofs headers has atleast 64bit off_t type */
+extern int erofs_assert_largefile[sizeof(off_t)-8];
+
 /* global sbi */
 extern struct erofs_sb_info sbi;
 
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

