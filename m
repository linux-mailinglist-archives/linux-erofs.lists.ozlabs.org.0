Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4024722D49
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Jun 2023 19:06:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QZg474fCJz3f0h
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Jun 2023 03:06:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bx3AvdNW;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bx3AvdNW;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QZg412QF9z3dxd
	for <linux-erofs@lists.ozlabs.org>; Tue,  6 Jun 2023 03:06:09 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 874C5619E0;
	Mon,  5 Jun 2023 17:06:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD19C433D2;
	Mon,  5 Jun 2023 17:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685984765;
	bh=tH9AmnTBfoxNJ2wdb07t/MPiK7BvwLY76o1H628aLnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bx3AvdNWZxKaEeewmXRJFxrOv4/Wv6iv3MHKSVbqG2TCo3R0AyUfL8n4IrslEswYi
	 rEWfCSTvAbA9YyUxz4B3oga/hz5HouIzBl1T9rXxyEVQ613JmSmxrGOCCdwBfaFFbq
	 E2sgwlTJ7zAy7ZKuYWXnoKA2zCQZhkwECRfV6i0ObrUpRRr3pPwk5Z6cCfg+IoBl//
	 fghT/80VrvYXqUpInucgCskvO7EN6Oe+yB3bsKa1Ev8E0zg5JA23Y2VZeII/6ftjLG
	 lKDiM1sCvgQ4AH4bEJkPKayROCmyK5SFV7HZ2fO2GogC7/kqe68sZIZ6VZ99obezQB
	 M1DfVTfmoMUvA==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: fsck: add a preliminary fuzzer
Date: Tue,  6 Jun 2023 01:05:51 +0800
Message-Id: <20230605170551.273399-1-xiang@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230605162311.70522-1-hsiangkao@linux.alibaba.com>
References: <20230605162311.70522-1-hsiangkao@linux.alibaba.com>
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

From: Gao Xiang <hsiangkao@linux.alibaba.com>

Let's introduce a fuzzer for fsck.erofs by using libFuzzer:
 - Clang 6.0+ installed;
 - Build with "CC=clang ./configure --enable-fuzzing";
 - Set stack size by using `ulimit -s` properly;
 - fsck/fuzz_erofsfsck -timeout=20 -max_total_time=300 CORPUS_DIR.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
changes since v1:
 - fix compile warning;
 - refine commit message.

 configure.ac     | 51 ++++++++++++++++++++++++++++++++++++++++++++++++
 fsck/Makefile.am |  9 +++++++++
 fsck/main.c      | 39 ++++++++++++++++++++++++++++++++++--
 3 files changed, 97 insertions(+), 2 deletions(-)

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
index 47c01d8..85df8a6 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -263,10 +263,11 @@ static void erofsfsck_set_attributes(struct erofs_inode *inode, char *path)
 
 static int erofs_check_sb_chksum(void)
 {
-	int ret;
+#ifndef FUZZING
 	u8 buf[EROFS_MAX_BLOCK_SIZE];
 	u32 crc;
 	struct erofs_super_block *sb;
+	int ret;
 
 	ret = blk_read(0, buf, 0, 1);
 	if (ret) {
@@ -285,6 +286,7 @@ static int erofs_check_sb_chksum(void)
 		fsckcfg.corrupted = true;
 		return -1;
 	}
+#endif
 	return 0;
 }
 
@@ -792,7 +794,11 @@ out:
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
 
@@ -819,6 +825,10 @@ int main(int argc, char **argv)
 		goto exit;
 	}
 
+#ifdef FUZZING
+	cfg.c_dbg_lvl = -1;
+#endif
+
 	err = dev_open_ro(cfg.c_img_path);
 	if (err) {
 		erofs_err("failed to open image file");
@@ -875,3 +885,28 @@ exit:
 	erofs_exit_configure();
 	return err ? 1 : 0;
 }
+
+#ifdef FUZZING
+int LLVMFuzzerTestOneInput(const uint8_t *Data, size_t Size)
+{
+	int fd, ret;
+	char filename[] = "/tmp/erofsfsck_libfuzzer_XXXXXX";
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
2.30.2

