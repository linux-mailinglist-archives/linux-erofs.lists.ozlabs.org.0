Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CFF8FFC75
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Jun 2024 08:50:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VwWzb33WYz3bsj
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Jun 2024 16:50:19 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=deepin.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=deepin.org (client-ip=54.204.34.129; helo=smtpbguseast1.qq.com; envelope-from=heyuming@deepin.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 83375 seconds by postgrey-1.37 at boromir; Fri, 07 Jun 2024 16:50:13 AEST
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VwWzT2F9wz30W5
	for <linux-erofs@lists.ozlabs.org>; Fri,  7 Jun 2024 16:50:07 +1000 (AEST)
X-QQ-mid: bizesmtp89t1717742990tfz81q4c
X-QQ-Originating-IP: iPqcyBk6heXqvoK8WBIVNdu601pjT4bq/60TlXg9wug=
Received: from ComixHe.tail207ab.ts.net ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 07 Jun 2024 14:49:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18026770742019947120
From: ComixHe <heyuming@deepin.org>
To: hsiangkao@linux.alibaba.com
Subject: [PATCH] build: export liberofs
Date: Fri,  7 Jun 2024 14:49:40 +0800
Message-ID: <1FBEA94A7D00D713+20240607064940.139007-1-heyuming@deepin.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:deepin.org:qybglogicsvrsz:qybglogicsvrsz3a-1
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
Cc: ComixHe <heyuming@deepin.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

export liberofs.a for linking to liberofsfuse in the project
and provide pc files for developer's convenience.

Signed-off-by: ComixHe <heyuming@deepin.org>
---
 .gitignore              |  2 ++
 Makefile.am             |  3 +++
 autogen.sh              |  6 ++++++
 configure.ac            |  8 +++++++-
 dump/Makefile.am        |  2 +-
 fsck/Makefile.am        |  4 ++--
 fuse/Makefile.am        | 12 +++++++-----
 fuse/liberofsfuse.pc.in | 11 +++++++++++
 lib/Makefile.am         | 26 +++++++++++++-------------
 liberofs.pc.in          | 11 +++++++++++
 mkfs/Makefile.am        |  2 +-
 11 files changed, 64 insertions(+), 23 deletions(-)
 create mode 100644 fuse/liberofsfuse.pc.in
 create mode 100644 liberofs.pc.in

diff --git a/.gitignore b/.gitignore
index 33e5d30..ccc6b60 100644
--- a/.gitignore
+++ b/.gitignore
@@ -31,3 +31,5 @@ stamp-h1
 /fuse/erofsfuse
 /dump/dump.erofs
 /fsck/fsck.erofs
+liberofs.pc
+/fuse/liberofsfuse.pc
diff --git a/Makefile.am b/Makefile.am
index fc464e8..8e687ac 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -2,6 +2,9 @@
 
 ACLOCAL_AMFLAGS = -I m4
 
+pkgconfigdir = @pkgconfigdir@
+pkgconfig_DATA = liberofs.pc
+
 SUBDIRS = man lib mkfs dump fsck
 if ENABLE_FUSE
 SUBDIRS += fuse
diff --git a/autogen.sh b/autogen.sh
index fd81db4..289bf73 100755
--- a/autogen.sh
+++ b/autogen.sh
@@ -4,6 +4,12 @@
 aclocal && \
 autoheader && \
 autoconf && \
+
+if pkg-config --version > /dev/null 2>&1; then : ; else
+  echo "Missing pkg-config"
+  exit 1
+fi
+
 case `uname` in Darwin*) glibtoolize --copy ;; \
   *) libtoolize --copy ;; esac && \
 automake -a -c
diff --git a/configure.ac b/configure.ac
index dc5f787..db4df69 100644
--- a/configure.ac
+++ b/configure.ac
@@ -20,6 +20,9 @@ AC_PROG_INSTALL
 
 LT_INIT
 
+PKG_PROG_PKG_CONFIG
+PKG_INSTALLDIR
+
 # Test presence of pkg-config
 AC_MSG_CHECKING([pkg-config m4 macros])
 if test m4_ifdef([PKG_CHECK_MODULES], [yes], [no]) = "yes"; then
@@ -631,5 +634,8 @@ AC_CONFIG_FILES([Makefile
 		 mkfs/Makefile
 		 dump/Makefile
 		 fuse/Makefile
-		 fsck/Makefile])
+     fuse/liberofsfuse.pc
+		 fsck/Makefile
+     liberofs.pc
+     ])
 AC_OUTPUT
diff --git a/dump/Makefile.am b/dump/Makefile.am
index 2a4f67a..850e6a4 100644
--- a/dump/Makefile.am
+++ b/dump/Makefile.am
@@ -6,6 +6,6 @@ bin_PROGRAMS     = dump.erofs
 AM_CPPFLAGS = ${libuuid_CFLAGS}
 dump_erofs_SOURCES = main.c
 dump_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
-dump_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
+dump_erofs_LDADD = $(top_builddir)/lib/liberofs.a ${libselinux_LIBS} \
 	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} \
 	${libzstd_LIBS} ${libqpl_LIBS}
diff --git a/fsck/Makefile.am b/fsck/Makefile.am
index 5bdee4d..2680f4b 100644
--- a/fsck/Makefile.am
+++ b/fsck/Makefile.am
@@ -6,7 +6,7 @@ bin_PROGRAMS     = fsck.erofs
 AM_CPPFLAGS = ${libuuid_CFLAGS}
 fsck_erofs_SOURCES = main.c
 fsck_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
-fsck_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
+fsck_erofs_LDADD = $(top_builddir)/lib/liberofs.a ${libselinux_LIBS} \
 	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} \
 	${libzstd_LIBS} ${libqpl_LIBS}
 
@@ -15,7 +15,7 @@ noinst_PROGRAMS   = fuzz_erofsfsck
 fuzz_erofsfsck_SOURCES = main.c
 fuzz_erofsfsck_CFLAGS = -Wall -I$(top_srcdir)/include -DFUZZING
 fuzz_erofsfsck_LDFLAGS = -fsanitize=address,fuzzer
-fuzz_erofsfsck_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
+fuzz_erofsfsck_LDADD = $(top_builddir)/lib/liberofs.a ${libselinux_LIBS} \
 	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} \
 	${libzstd_LIBS} ${libqpl_LIBS}
 endif
diff --git a/fuse/Makefile.am b/fuse/Makefile.am
index 265b98f..f427247 100644
--- a/fuse/Makefile.am
+++ b/fuse/Makefile.am
@@ -1,20 +1,22 @@
 # SPDX-License-Identifier: GPL-2.0+
 
+pkgconfigdir = @pkgconfigdir@
+pkgconfig_DATA = liberofsfuse.pc
+
 AUTOMAKE_OPTIONS = foreign
 noinst_HEADERS = $(top_srcdir)/fuse/macosx.h
 bin_PROGRAMS     = erofsfuse
 erofsfuse_SOURCES = main.c
 erofsfuse_CFLAGS = -Wall -I$(top_srcdir)/include
 erofsfuse_CFLAGS += ${libfuse2_CFLAGS} ${libfuse3_CFLAGS} ${libselinux_CFLAGS}
-erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la ${libfuse2_LIBS} ${libfuse3_LIBS} ${liblz4_LIBS} \
-	${libselinux_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} ${libzstd_LIBS} \
-	${libqpl_LIBS}
+erofsfuse_LDADD = $(top_builddir)/lib/liberofs.a ${libfuse2_LIBS} ${libfuse3_LIBS} ${liblz4_LIBS} \
+	${libselinux_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} ${libzstd_LIBS}
 
 if ENABLE_STATIC_FUSE
 lib_LIBRARIES = liberofsfuse.a
 liberofsfuse_a_SOURCES = main.c
 liberofsfuse_a_CFLAGS  = -Wall -I$(top_srcdir)/include
 liberofsfuse_a_CFLAGS += -Dmain=erofsfuse_main ${libfuse2_CFLAGS} ${libfuse3_CFLAGS} ${libselinux_CFLAGS}
-liberofsfuse_la_LIBADD  = $(top_builddir)/lib/liberofs.la ${libfuse2_LIBS} ${libfuse3_LIBS} ${liblz4_LIBS} \
-	${libselinux_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} ${libzstd_LIBS} ${libqpl_LIBS}
+noinst_liberofsfuse_la_LIBADD = $(top_builddir)/lib/liberofs.a ${libfuse2_LIBS} ${libfuse3_LIBS} ${liblz4_LIBS} \
+	${libselinux_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} ${libzstd_LIBS}
 endif
diff --git a/fuse/liberofsfuse.pc.in b/fuse/liberofsfuse.pc.in
new file mode 100644
index 0000000..8fb6b7f
--- /dev/null
+++ b/fuse/liberofsfuse.pc.in
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+prefix=@prefix@
+libdir=@libdir@
+
+Name: liberofsfuse
+Description: static library of erofsfuse
+Version: @VERSION@
+
+Requires:
+Libs: -L${libdir} -lerofsfuse
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 2cb4cab..0441c06 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 
-noinst_LTLIBRARIES = liberofs.la
+lib_LIBRARIES = liberofs.a
 noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
       $(top_srcdir)/include/erofs/blobchunk.h \
       $(top_srcdir)/include/erofs/block_list.h \
@@ -30,33 +30,33 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
       $(top_srcdir)/lib/xxhash.h
 
 noinst_HEADERS += compressor.h
-liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
+liberofs_a_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
 		      namei.c data.c compress.c compressor.c zmap.c decompress.c \
 		      compress_hints.c hashmap.c sha256.c blobchunk.c dir.c \
 		      fragments.c dedupe.c uuid_unparse.c uuid.c tar.c \
 		      block_list.c xxhash.c rebuild.c diskbuf.c
 
-liberofs_la_CFLAGS = -Wall ${libuuid_CFLAGS} -I$(top_srcdir)/include
+liberofs_a_CFLAGS = -Wall ${libuuid_CFLAGS} -I$(top_srcdir)/include
 if ENABLE_LZ4
-liberofs_la_CFLAGS += ${LZ4_CFLAGS}
-liberofs_la_SOURCES += compressor_lz4.c
+liberofs_a_CFLAGS += ${LZ4_CFLAGS}
+liberofs_a_SOURCES += compressor_lz4.c
 if ENABLE_LZ4HC
-liberofs_la_SOURCES += compressor_lz4hc.c
+liberofs_a_SOURCES += compressor_lz4hc.c
 endif
 endif
 if ENABLE_LIBLZMA
-liberofs_la_CFLAGS += ${liblzma_CFLAGS}
-liberofs_la_SOURCES += compressor_liblzma.c
+liberofs_a_CFLAGS += ${liblzma_CFLAGS}
+liberofs_a_SOURCES += compressor_liblzma.c
 endif
 
-liberofs_la_SOURCES += kite_deflate.c compressor_deflate.c
+liberofs_a_SOURCES += kite_deflate.c compressor_deflate.c
 if ENABLE_LIBDEFLATE
-liberofs_la_SOURCES += compressor_libdeflate.c
+liberofs_a_SOURCES += compressor_libdeflate.c
 endif
 if ENABLE_LIBZSTD
-liberofs_la_SOURCES += compressor_libzstd.c
+liberofs_a_SOURCES += compressor_libzstd.c
 endif
 if ENABLE_EROFS_MT
-liberofs_la_LDFLAGS = -lpthread
-liberofs_la_SOURCES += workqueue.c
+liberofs_a_LDFLAGS = -lpthread
+liberofs_a_SOURCES += workqueue.c
 endif
diff --git a/liberofs.pc.in b/liberofs.pc.in
new file mode 100644
index 0000000..fa681a2
--- /dev/null
+++ b/liberofs.pc.in
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+prefix=@prefix@
+libdir=@libdir@
+
+Name: liberofs
+Description: erofs library for utils
+Version: @VERSION@
+
+Requires:
+Libs: -L${libdir} -lerofs
diff --git a/mkfs/Makefile.am b/mkfs/Makefile.am
index 6354712..eea01b2 100644
--- a/mkfs/Makefile.am
+++ b/mkfs/Makefile.am
@@ -5,6 +5,6 @@ bin_PROGRAMS     = mkfs.erofs
 AM_CPPFLAGS = ${libselinux_CFLAGS}
 mkfs_erofs_SOURCES = main.c
 mkfs_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
-mkfs_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
+mkfs_erofs_LDADD = $(top_builddir)/lib/liberofs.a ${libselinux_LIBS} \
 	${libuuid_LIBS} ${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} \
 	${libdeflate_LIBS} ${libzstd_LIBS} ${libqpl_LIBS}
-- 
2.45.2

