Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AA9509288
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Apr 2022 00:12:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KkFKJ6kLpz2xF8
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Apr 2022 08:12:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Tk7VYz30;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::334;
 helo=mail-wm1-x334.google.com; envelope-from=fontaine.fabrice@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=Tk7VYz30; dkim-atps=neutral
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KkFK94hgrz2xF8
 for <linux-erofs@lists.ozlabs.org>; Thu, 21 Apr 2022 08:12:27 +1000 (AEST)
Received: by mail-wm1-x334.google.com with SMTP id
 u17-20020a05600c211100b0038eaf4cdaaeso4645671wml.1
 for <linux-erofs@lists.ozlabs.org>; Wed, 20 Apr 2022 15:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Rk5+P98aWONLUZM2MdE3mu/zQulq2jOxpLxYcuDb9QY=;
 b=Tk7VYz30NZ0t22qy/j9DMGeX6yo6AUHj9/YhzJHlWWrnQhzxE9W2VCktcmWua/AwzA
 UpDJdYoalngcgWAXzmQJ2nxDdzBmD1adj0x8sK8Ba47WWFS3ewpqqbvwQllGVf+eAPH5
 cIx7t19BYYq9gWbiQ7zYOMupMuL/K9TtfpEFKBphYPqR9VVTwDctwGMF7X1mNOitq+b4
 ZDNYRT/M8D7OI0K5kUsk0CIqNOS+heNbGufc40nwOMqwmMv8UZ7M8gKGBrVS7m+SdJJE
 Em/rn7lsDClCzDTZCyef3IfpFemQEKRpEaQ0aRg8K0s5Fdobaux0AL5ffLfBgCN9CV5J
 /EsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Rk5+P98aWONLUZM2MdE3mu/zQulq2jOxpLxYcuDb9QY=;
 b=Let8SKTYT4s07wvavnmNyoeKStnvHBmRJwFGvC+BR/we/rf0TT3qi9/LC84BefjG9W
 dUUYqCu4BtGxDUR+gKl4erEa9AaMub945MuaNMXtGBj4BEGJb1Lz3+ispha0u5FnnQcL
 TZBX7pwqrODjsZ7MtQ81p7oOKQflswmvoXE4cIQjXKjzGyrQI1+YOzzg2mY33eEhlrsg
 v7tLEv/7rwqAWkaEqD0nFKQKW9qBUJW88AQFunmTZg0XQqVvJ/ahQdjOfoDMSZ8dwIUE
 u/ViCh0tm1CbgoloX7vvvyfHRzAHeC9H8RnPHGLCUv6/J/jeSi6OQV8Cce6ApkgBSAF7
 zAKQ==
X-Gm-Message-State: AOAM531csySUtZrIDA0/5UsIYUKVzESKT3RRaQmj2ErIiNttYpt7I/x3
 HNT1VVpcBJLu/KwYQO30Lb4ytVhb2rs=
X-Google-Smtp-Source: ABdhPJz+HMNavfYM+EmHTjbXYtOD5llj34tlkwqqKfdmFl/2wlrJsRNIWDK8213jKPxyFeW2Z1vFVw==
X-Received: by 2002:a7b:c0d0:0:b0:392:a02c:28ab with SMTP id
 s16-20020a7bc0d0000000b00392a02c28abmr5600036wmh.2.1650492740494; 
 Wed, 20 Apr 2022 15:12:20 -0700 (PDT)
Received: from kali.home (2a01cb088e0b5b002be75de2a1caa253.ipv6.abo.wanadoo.fr.
 [2a01:cb08:8e0b:5b00:2be7:5de2:a1ca:a253])
 by smtp.gmail.com with ESMTPSA id
 l3-20020a05600002a300b0020aad7fd63bsm957715wry.61.2022.04.20.15.12.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Apr 2022 15:12:20 -0700 (PDT)
From: Fabrice Fontaine <fontaine.fabrice@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] Add --disable-werror
Date: Thu, 21 Apr 2022 00:10:18 +0200
Message-Id: <20220420221018.1396105-1-fontaine.fabrice@gmail.com>
X-Mailer: git-send-email 2.35.1
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
Cc: Fabrice Fontaine <fontaine.fabrice@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add an option to disable -Werror to fix the following build failure with
gcc 4.8 raised since version 1.4 and
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/commit/?id=cf8be8a4352a5df3b3acf545af289cb47faa6de0:

In file included from /home/buildroot/autobuild/instance-0/output-1/host/arm-buildroot-linux-gnueabi/sysroot/usr/include/string.h:636:0,
                 from ../include/erofs/internal.h:242,
                 from ../include/erofs/inode.h:11,
                 from main.c:12:
In function 'memset',
    inlined from 'erofsdump_filetype_distribution.constprop.2' at main.c:583:9:
/home/buildroot/autobuild/instance-0/output-1/host/arm-buildroot-linux-gnueabi/sysroot/usr/include/bits/string3.h:81:30: error: call to '__warn_memset_zero_len' declared with attribute warning: memset used with constant zero length parameter; this could be due to transposed parameters [-Werror]
       __warn_memset_zero_len ();
                              ^

Fixes:
 - http://autobuild.buildroot.org/results/4c776ec935bbb016231b6701471887a7c9ea79e9

Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
---
 configure.ac     | 13 ++++++++++++-
 dump/Makefile.am |  2 +-
 fsck/Makefile.am |  2 +-
 fuse/Makefile.am |  2 +-
 lib/Makefile.am  |  2 +-
 mkfs/Makefile.am |  2 +-
 6 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/configure.ac b/configure.ac
index 6fdb0e4..989e4dc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -11,7 +11,7 @@ AC_CONFIG_SRCDIR([config.h.in])
 AC_CONFIG_HEADERS([config.h])
 AC_CONFIG_MACRO_DIR([m4])
 AC_CONFIG_AUX_DIR(config)
-AM_INIT_AUTOMAKE([foreign -Wall -Werror])
+AM_INIT_AUTOMAKE([foreign -Wall])
 
 # Checks for programs.
 AM_PROG_AR
@@ -65,6 +65,12 @@ AC_ARG_ENABLE([debug],
     [enable_debug="$enableval"],
     [enable_debug="no"])
 
+AC_ARG_ENABLE([werror],
+    [AS_HELP_STRING([--disable-werror],
+                    [disable -Werror @<:@default=yes@:>@])],
+    [enable_werror="$enableval"],
+    [enable_werror="yes"])
+
 AC_ARG_ENABLE(lz4,
    [AS_HELP_STRING([--disable-lz4], [disable LZ4 compression support @<:@default=enabled@:>@])],
    [enable_lz4="$enableval"], [enable_lz4="yes"])
@@ -191,6 +197,11 @@ AS_IF([test "x$enable_debug" != "xno"], [], [
   CPPFLAGS="$CPPFLAGS -DNDEBUG"
 ])
 
+# Configure -Werror
+AS_IF([test "x$enable_werror" != "xyes"], [], [
+  CPPFLAGS="$CPPFLAGS -Werror"
+])
+
 # Configure libuuid
 AS_IF([test "x$with_uuid" != "xno"], [
   PKG_CHECK_MODULES([libuuid], [uuid])
diff --git a/dump/Makefile.am b/dump/Makefile.am
index 9f0cd3f..c2bef6d 100644
--- a/dump/Makefile.am
+++ b/dump/Makefile.am
@@ -5,6 +5,6 @@ AUTOMAKE_OPTIONS = foreign
 bin_PROGRAMS     = dump.erofs
 AM_CPPFLAGS = ${libuuid_CFLAGS}
 dump_erofs_SOURCES = main.c
-dump_erofs_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
+dump_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
 dump_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
 	${libuuid_LIBS} ${liblz4_LIBS} ${liblzma_LIBS}
diff --git a/fsck/Makefile.am b/fsck/Makefile.am
index 55b31ea..e6a1fb6 100644
--- a/fsck/Makefile.am
+++ b/fsck/Makefile.am
@@ -5,6 +5,6 @@ AUTOMAKE_OPTIONS = foreign
 bin_PROGRAMS     = fsck.erofs
 AM_CPPFLAGS = ${libuuid_CFLAGS}
 fsck_erofs_SOURCES = main.c
-fsck_erofs_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
+fsck_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
 fsck_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
 	${libuuid_LIBS} ${liblz4_LIBS} ${liblzma_LIBS}
diff --git a/fuse/Makefile.am b/fuse/Makefile.am
index 7b007f3..a22cc70 100644
--- a/fuse/Makefile.am
+++ b/fuse/Makefile.am
@@ -3,7 +3,7 @@
 AUTOMAKE_OPTIONS = foreign
 bin_PROGRAMS     = erofsfuse
 erofsfuse_SOURCES = dir.c main.c
-erofsfuse_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
+erofsfuse_CFLAGS = -Wall -I$(top_srcdir)/include
 erofsfuse_CFLAGS += -DFUSE_USE_VERSION=26 ${libfuse_CFLAGS} ${libselinux_CFLAGS}
 erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la ${libfuse_LIBS} ${liblz4_LIBS} \
 	${libselinux_LIBS} ${liblzma_LIBS}
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 395c712..89a90e7 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -27,7 +27,7 @@ noinst_HEADERS += compressor.h
 liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
 		      namei.c data.c compress.c compressor.c zmap.c decompress.c \
 		      compress_hints.c hashmap.c sha256.c blobchunk.c
-liberofs_la_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
+liberofs_la_CFLAGS = -Wall -I$(top_srcdir)/include
 if ENABLE_LZ4
 liberofs_la_CFLAGS += ${LZ4_CFLAGS}
 liberofs_la_SOURCES += compressor_lz4.c
diff --git a/mkfs/Makefile.am b/mkfs/Makefile.am
index 2a4bc1d..709d9bf 100644
--- a/mkfs/Makefile.am
+++ b/mkfs/Makefile.am
@@ -4,6 +4,6 @@ AUTOMAKE_OPTIONS = foreign
 bin_PROGRAMS     = mkfs.erofs
 AM_CPPFLAGS = ${libuuid_CFLAGS} ${libselinux_CFLAGS}
 mkfs_erofs_SOURCES = main.c
-mkfs_erofs_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
+mkfs_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
 mkfs_erofs_LDADD = ${libuuid_LIBS} $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
 	${liblz4_LIBS} ${liblzma_LIBS}
-- 
2.35.1

