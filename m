Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 786EF722C6B
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Jun 2023 18:23:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QZf6n1z3Tz3f0s
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Jun 2023 02:23:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QZf6j4Nllz3dxD
	for <linux-erofs@lists.ozlabs.org>; Tue,  6 Jun 2023 02:23:23 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VkShKw2_1685982191;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VkShKw2_1685982191)
          by smtp.aliyun-inc.com;
          Tue, 06 Jun 2023 00:23:16 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fsck: add a preliminary fuzzer
Date: Tue,  6 Jun 2023 00:23:11 +0800
Message-Id: <20230605162311.70522-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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

Let's introduce a fuzzer for fsck.erofs by using libFuzzer:
 - Clang 6.0+ installed;
 - Build with "CC=clang ./configure --enable-fuzzing";
 - fsck/fuzz_erofsfsck -timeout=20 -max_total_time=300 CORPUS_DIR.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 configure.ac     | 51 ++++++++++++++++++++++++++++++++++++++++++++++++
 fsck/Makefile.am |  9 +++++++++
 fsck/main.c      | 37 ++++++++++++++++++++++++++++++++++-
 3 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 2ade490..cd6be4a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -29,6 +29,41 @@ else
   AC_MSG_ERROR([pkg-config is required. See pkg-config.freedesktop.org])
 fi
 
+dnl Check if the flag is supported by compiler
+dnl CC_CHECK_CFLAGS_SILENT([FLAG], [ACTION-IF-FOUND],[ACTION-IF-NOT-FOUND])
+AC_DEFUN([CC_CHECK_CFLAGS_SILENT], [
+  AC_CACHE_VAL(AS_TR_SH([cc_cv_cflags_$1]),
+    [ac_save_CFLAGS="$CFLAGS"
+     CFLAGS="$CFLAGS $1"
+     AC_LINK_IFELSE([AC_LANG_SOURCE([int main() { return 0; }])],
+       [eval "AS_TR_SH([cc_cv_cflags_$1])='yes'"],
+       [eval "AS_TR_SH([cc_cv_cflags_$1])='no'"])
+     CFLAGS="$ac_save_CFLAGS"
+    ])
+
+  AS_IF([eval test x$]AS_TR_SH([cc_cv_cflags_$1])[ = xyes],
+    [$2], [$3])
+])
+
+dnl Check if the flag is supported by compiler (cacheable)
+dnl CC_CHECK_CFLAG([FLAG], [ACTION-IF-FOUND],[ACTION-IF-NOT-FOUND])
+AC_DEFUN([CC_CHECK_CFLAG], [
+  AC_CACHE_CHECK([if $CC supports $1 flag],
+    AS_TR_SH([cc_cv_cflags_$1]),
+    CC_CHECK_CFLAGS_SILENT([$1]) dnl Don't execute actions here!
+  )
+
+  AS_IF([eval test x$]AS_TR_SH([cc_cv_cflags_$1])[ = xyes],
+    [$2], [$3])
+])
+
+dnl CC_CHECK_CFLAGS([FLAG1 FLAG2], [action-if-found], [action-if-not])
+AC_DEFUN([CC_CHECK_CFLAGS], [
+  for flag in $1; do
+    CC_CHECK_CFLAG($flag, [$2], [$3])
+  done
+])
+
 dnl EROFS_UTILS_PARSE_DIRECTORY
 dnl Input:  $1 = a string to a relative or absolute directory
 dnl Output: $2 = the variable to set with the absolute directory
@@ -73,6 +108,12 @@ AC_ARG_ENABLE([werror],
     [enable_werror="$enableval"],
     [enable_werror="no"])
 
+AC_ARG_ENABLE([fuzzing],
+    [AS_HELP_STRING([--enable-fuzzing],
+                    [set up fuzzing mode @<:@default=no@:>@])],
+    [enable_fuzzing="$enableval"],
+    [enable_fuzzing="no"])
+
 AC_ARG_ENABLE(lz4,
    [AS_HELP_STRING([--disable-lz4], [disable LZ4 compression support @<:@default=enabled@:>@])],
    [enable_lz4="$enableval"], [enable_lz4="yes"])
@@ -356,6 +397,16 @@ fi
 # Enable 64-bit off_t
 CFLAGS+=" -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64"
 
+# Configure fuzzing mode
+AS_IF([test "x$enable_fuzzing" != "xyes"], [], [
+  CC_CHECK_CFLAGS(["-fsanitize=address,fuzzer-no-link"], [
+    CFLAGS="$CFLAGS -g -O1 -fsanitize=address,fuzzer-no-link"
+  ], [
+    AC_MSG_ERROR([Compiler doesn't support `-fsanitize=address,fuzzer-no-link`])
+  ])
+])
+AM_CONDITIONAL([ENABLE_FUZZING], [test "x${enable_fuzzing}" = "xyes"])
+
 # Set up needed symbols, conditionals and compiler/linker flags
 AM_CONDITIONAL([ENABLE_LZ4], [test "x${have_lz4}" = "xyes"])
 AM_CONDITIONAL([ENABLE_LZ4HC], [test "x${have_lz4hc}" = "xyes"])
diff --git a/fsck/Makefile.am b/fsck/Makefile.am
index e6a1fb6..9366a9d 100644
--- a/fsck/Makefile.am
+++ b/fsck/Makefile.am
@@ -8,3 +8,12 @@ fsck_erofs_SOURCES = main.c
 fsck_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
 fsck_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
 	${libuuid_LIBS} ${liblz4_LIBS} ${liblzma_LIBS}
+
+if ENABLE_FUZZING
+noinst_PROGRAMS   = fuzz_erofsfsck
+fuzz_erofsfsck_SOURCES = main.c
+fuzz_erofsfsck_CFLAGS = -Wall -I$(top_srcdir)/include -DFUZZING
+fuzz_erofsfsck_LDFLAGS = -fsanitize=address,fuzzer
+fuzz_erofsfsck_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
+	${libuuid_LIBS} ${liblz4_LIBS} ${liblzma_LIBS}
+endif
diff --git a/fsck/main.c b/fsck/main.c
index a0377a7..56a7d69 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -787,7 +787,11 @@ out:
 	return ret;
 }
 
-int main(int argc, char **argv)
+#ifdef FUZZING
+int erofsfsck_fuzz_one(int argc, char *argv[])
+#else
+int main(int argc, char *argv[])
+#endif
 {
 	int err;
 
@@ -814,6 +818,10 @@ int main(int argc, char **argv)
 		goto exit;
 	}
 
+#ifdef FUZZING
+	cfg.c_dbg_lvl = -1;
+#endif
+
 	err = dev_open_ro(cfg.c_img_path);
 	if (err) {
 		erofs_err("failed to open image file");
@@ -826,10 +834,12 @@ int main(int argc, char **argv)
 		goto exit_dev_close;
 	}
 
+#ifndef FUZZING
 	if (erofs_sb_has_sb_chksum() && erofs_check_sb_chksum()) {
 		erofs_err("failed to verify superblock checksum");
 		goto exit_put_super;
 	}
+#endif
 
 	if (erofs_sb_has_fragments() && sbi.packed_nid > 0) {
 		err = erofsfsck_check_inode(sbi.packed_nid, sbi.packed_nid);
@@ -870,3 +880,28 @@ exit:
 	erofs_exit_configure();
 	return err ? 1 : 0;
 }
+
+#ifdef FUZZING
+int LLVMFuzzerTestOneInput(const uint8_t *Data, size_t Size)
+{
+	int fd, ret;
+	char filename[] = "erofsfsck_libfuzzer_XXXXXX";
+	char *argv[] = {
+		"fsck.erofs",
+		"--extract",
+		filename,
+	};
+
+	fd = mkstemp(filename);
+	if (fd < 0)
+		return -errno;
+	if (write(fd, Data, Size) != Size) {
+		close(fd);
+		return -EIO;
+	}
+	close(fd);
+	ret = erofsfsck_fuzz_one(ARRAY_SIZE(argv), argv);
+	unlink(filename);
+	return ret ? -1 : 0;
+}
+#endif
-- 
2.24.4

