Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BBC2BB1A2
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Nov 2020 18:44:55 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cd3pX02kczDr6T
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Nov 2020 04:44:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1605894292;
	bh=eci5snhPCu7ThdrYieEVoll2RLxtJAj0DeXkOPUJtUU=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=hqxJuj9e03uH59mJf+uBCUEeS0j6MZ6b+5DB8nBSgsESuAVgU3QQdFgSCRU+++7ri
	 bvrVnz5eCzJ1UrnGdyiTuJ4Us63PjLGsbIAAJnMoTA/deG0TheSfyk0unGOdbqV7uJ
	 Q1o+svNd5x471ceXOfcJbkNL3d+9mEdh0VaGJ9HwXjSdOVlAMRrJEJ8ZhQuXD4RS8S
	 RrNGD1hxtIA+VTnXS8pxJYkwNDJHSzF9z7JMyqMNqI1hy/ot/KDeBhRLe8qWfPhFcq
	 VwJYHJ3ZKdzya/n/6g2FV3/mt3vpvhNsCnvph3mQvbWGowJtfi0aIDl5i1hwPfKfbB
	 SWnlwqm8ul7uQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.30; helo=sonic315-54.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=tH0Z73NM; dkim-atps=neutral
Received: from sonic315-54.consmr.mail.gq1.yahoo.com
 (sonic315-54.consmr.mail.gq1.yahoo.com [98.137.65.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cd3lj6w7kzDr2c
 for <linux-erofs@lists.ozlabs.org>; Sat, 21 Nov 2020 04:42:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1605894138; bh=XaGU9ArfkngMCFi2/QXjGxRdiPDJfBZTUn0bHHufcHw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=tH0Z73NM663BMcbIX+vW/u6j+vfDJBHN32Ht2JnVwCBr2Nnydb46rGe2ODqNlRAmxSqAZb73ipssf8TpCpYU/9Av7Itll0gSpJhkeGRHOuTTxwejclE9qoWAGhwVHAkznSojLeV07PJi1nSIJbd5a1HvdqVZpaBlGpWDcmspJ0prvIRHxHqg/a/clu9ysO7r3SgInuSwzmU53jJ7R5IXD/m4BjZakVjVFQ8LzjdeOl9JXhpjrv1MmcStmrJeRRcLe9lYsEMWV6EavJza7eLTexcjwZPJ2ZgaFNYr3eOSCEBwv2nFCHQKY7C8x63AtPe7K10++1DYe2ImRw4AwqBO7w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1605894138; bh=l/42Uwa5ipwplaII8jL98/3qMiWWzipa34llaTaHvsr=;
 h=From:To:Subject:Date:From:Subject;
 b=ewka6Jktl4PMMJecO9F1fUk01LOVBy5CqkkPcC/ro7wJdAp+1ejG+Ks1oCGXRDNoku3g5fkRxYvs/UutrXCjcueUXXhxTxbYZDoS2fCRlI5YeAmzTAJ0GPSE1LfJnY3Gzd9PhRQD8wqY/6Ulo9h3Okda2a+Psq+9Sc6XcxPZBKr2LyS6hYt2W2w5cbbJkkFQFvNQS+ClsxKhj4tnnND05AfyIOoH8N7XqWSJoWh53wj298IrQoh7+sm+6b3a1uidsmPgXQBGu4hPQXvR+8GAgh+UzkKeKHSNCwRT6R4zt8YaUHhlfYCuokJxKWVFL3lki5EOmWsfrR2iPG+irbXBZg==
X-YMail-OSG: XpxBGksVM1ljAUfwJOaWumznuJwaonnED6q_AzvqXdvphQAyZ74wXCan.MiH01G
 5e_C1btx23eKDakbzUblT5B7XbecdpXIlmwnNpSwECm2KoS0PZ9MnM_DGcYJHGmEDhbdXgkURfRV
 dAQl52ryzez3XO4sXGw_efS7866scEeK0A2Fu38opR2dfErIbt3dvsSOfiA9f2EArnGO8hXYL0Pi
 v4jX.NIqT_7Kbfzsg1jS1JMiSRD8hkyr8Wy0W7lFMLCT466ZhhTaZa4JR0PpMGCpA4oVl5mQ.KHy
 0VoFYDCVWjcL4s1IV1DuRSMUBRXW5RqyCtTdgz.YjiwivsIk.cgtjWoQ18oXQAKsPwdVD5_CI7Wl
 eDttGerSmuONNHcaG79RtcicK34fRnWnIWCMxf2lCRcMBEhD94jWveZhypINjHAKeuaWyWLfr_.E
 tDODExvf7HI9jLSlfzGh1UR65P.0SUzmdb.Cf_qkrOJB16BqsuSjqyNF3jdBF4hHDP_rx__KCUJr
 4MSaW5PCjvhcZ0OAGrpRtKqpCuLZ8iB8XCqkkz9AjsFwLnLkWZa7ttmEcpM5w_2vwo3hoMns6D8x
 0DkAeSq_OaAbCW8uBpI1N4YU3KsqiDVT57N2KQVEi9b8wZT_QMRtt6uiJwtjs9cTcfkQdTWWCgJi
 zM4a_oLGl9IF_V1Ri6LUPoU3qKNi2ErUOnXB57K3OxXPYiKpbMSgss885voFs.Wpbh1zOpro3C3U
 1JMhoV1d4TxUlP5Yp.Di_ltYVjznHWXVDozL93kbHI0kZRVo.iNpt4SgSljVdPkeDfFPArxqkjjH
 bqOFofUEzO7MqVTigPoBgDeeMvSbvdrK2aKYy51rw7FlfpLymeBm0SYYo74OD.cL5FkF_z7hEt2M
 MijvVYzT0rAt0GmE7qAxVlOUbB70.b1sNidRxmbSF6hcoK1IdaYev.Qn_84.CdVshCSmyQCFmPvh
 60dDykROeT0lzxfEWydfY.iSgToERvGj.FQlZFQZhc.hR9.jEhOL3tCg9DRoJdjfeGBhOp5Awt7X
 jn_jrRj6bX9SXchbU.7pvBrEYen7xv0g8T5MyhgUMrBWn9lLXVi0KjNYNYufm4vj08fMG8UlPxw9
 1rA.LuH2868On83bQM8gZJATKy6KwZrmtP0zzuEW6kaDEyk9dZos1LfEWfb64aygGAJRpFxg7xC3
 sAwvGf2wqJWctGSuzCcLPfcj3yOvkqjMVdn.yuawqHiHBwYiYIdci7Q2BhQk8uaIOGcSBBM.wysy
 mFLYMMrHb2iqn3YEsbUA_8kAPBC205uHFQpd9uxk0bNGEkhPhsIYCKX00doNsUuhUB48dYdhG9Gy
 fn8Z_6J0WIPDxG03_cyNQ28DrqamDjTyop9771D8C4XT8UvmGgzPQE9ZMW99BBJbVnRA42AlT7Wb
 LZkDi_7tDGTKuDF72Xf_oMCwsDqkdWOecU65uljgtoilXPapFzMiGEjrOxDsZWrRtnxP4nN4TRdM
 NyUUoe1wqj4YTpYHLpwXLPY_Oh6YXxU.2DUdtdbhR22RqyqTfHgiH_l.lyX4usc3mKPqD9EH9OCu
 SF_72Lah6EWmdvm0zYPsTR6mXc_JD96qg9gJzGL5l2U__TDto61TmMkkPCZxaotUbZUe1Lxy2It6
 FtjrsFz14I3tRlzvh2jIqNW3f.qNcHtQ1AWG9e7151ANJS8lu_fmyIHBWq7MCiRi5256Ir4C5dUf
 5GZSE1a8iVTLkqU8DKp2qZG15sL3XU_EjDJ32ymSbSDlfYdinojFDZEOSsiHTubDfou8426eTswp
 jNpS4olGYDmHNhI4xARp5os1.N.FNBh8wcZ4F_m1KWGy.aS905gbIPP4U.Cui5NqguJTxEN4iS6U
 KMlsaiL6KZVKgxZzCakUgJJc24WJ1s1VvSEJ7.MeXDdeb5UArag2mSoH0SwWC2ApierM2fcnQ3ZG
 q_tqer1IvqISSliFGhxDKLNNjPH6NCjW1qoYSDafJnrqGytgvyjc.mdBySboQfXGNhdRagsPMSMC
 QnDBPX6vP1oGAHc3RlHoutSa6CeXlTSM2pZokq_13FFJ_xY2.dHlsasQC_JbK1PG6K0EBX5k4l9r
 1MWu8GtQqNfgOCyVOSnV_Nu3wEi80gFVKtNLp4K5UCmtcexmMkdP4Y.tGvjx2pxZuwXYsOzptTyT
 cNYbxiK7ytbMCf_EahYq8GU5m7JFFqrWEL36LJpwIN4UzCakibonOCuh8K4sTtcsDU_R29GtCmYX
 tI8M5BcAhJ9pLWc66KVMubdzs6Ay4HEG5L6Tvn3Th0HzuoG_rue33zS.z9GcN9CATIlK7qLCmCbf
 pfDjetpfAKyN6OsqE4YUDaRsJApH.6tdd2LGctkMzDQnRdveoTRKX5HWDFyVxTaZwjU.py1PhIYt
 N15X5MrsA79orjRJ5PbMzkE01SweGjONGCqigkAfzeNem5f_GmAmOIimfN4S9d9.1nLLhdSpQUmy
 jkuHDYff6ZCXIIQYLoPHdG5jU5tMu2ZAmK9lLppBqtaGank4XS1DcJxkeAGeY9oG9awtLqJ.Bg2D
 ieaCjrcfyISdfUunAM_bN97VH7s8fsMj7tvFp8l6H7E5H3XPvurE7FB8KhqM9nfNv55CBuWsWr1t
 44Z2rghEudVlUZb1pJJPdBgZcaKYWSPibrO.Yl2.XbZNtxxjDO6bnXk5aTp7TVdtaDc70S_8vMOn
 YGizSRb74o5A2dJ63tNE29MqIXHu3jXZhGYgrRNcegq8u1Ou2JaAHVtL79q_aKcP53V906rnLenY
 ueCEnR599Wy60c6aiwlnpcO3ad.e5PF9jw7ESJ7sU6_2Qp2EejV92wH1RrNx5guAbCvyTAvdePnR
 Tk2yNJG7JL2wnQzP7Q8XY3iQsiAKVyfFELdrkl18oPRTwWGBb_5zlhjE-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic315.consmr.mail.gq1.yahoo.com with HTTP; Fri, 20 Nov 2020 17:42:18 +0000
Received: by smtp423.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 2f08c2150b87ae58ff1849141a8a4a3f; 
 Fri, 20 Nov 2020 17:42:13 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/3] erofs-utils: introduce fuse implementation
Date: Sat, 21 Nov 2020 01:41:44 +0800
Message-Id: <20201120174146.18662-2-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201120174146.18662-1-hsiangkao@aol.com>
References: <20201120174146.18662-1-hsiangkao@aol.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: Guo Weichao <guoweichao@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Li Guifu <blucerlee@gmail.com>

Let's add a simple erofsfuse approach, and benefits are:

 - images can be supported on various platforms;
 - new unpack tool can be developed based on this;
 - new on-disk features can be iterated, verified effectively.

This commit only addresses reading uncompressed regular files.
Other file (e.g. compressed file) support is out of scope here.

Note that erofsfuse is an unstable feature for now (also notice
LZ4_decompress_safe_partial() was broken in lz4-1.9.2, which
just fixed in lz4-1.9.3), let's disable it by default for a while.

Signed-off-by: Li Guifu <blucerlee@gmail.com>
Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 Makefile.am              |   4 +
 configure.ac             |  22 +++-
 fuse/Makefile.am         |  10 ++
 fuse/dir.c               | 103 ++++++++++++++++
 fuse/main.c              | 230 ++++++++++++++++++++++++++++++++++++
 include/erofs/internal.h |  86 +++++++++++++-
 include/erofs/io.h       |   1 +
 include/erofs/trace.h    |  14 +++
 include/erofs_fs.h       |   4 +
 lib/Makefile.am          |   4 +-
 lib/data.c               | 134 +++++++++++++++++++++
 lib/io.c                 |  16 +++
 lib/namei.c              | 246 +++++++++++++++++++++++++++++++++++++++
 lib/super.c              |  79 +++++++++++++
 14 files changed, 949 insertions(+), 4 deletions(-)
 create mode 100644 fuse/Makefile.am
 create mode 100644 fuse/dir.c
 create mode 100644 fuse/main.c
 create mode 100644 include/erofs/trace.h
 create mode 100644 lib/data.c
 create mode 100644 lib/namei.c
 create mode 100644 lib/super.c

diff --git a/Makefile.am b/Makefile.am
index 1d20577068c5..b804aa90efa9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -4,3 +4,7 @@
 ACLOCAL_AMFLAGS = -I m4
 
 SUBDIRS = man lib mkfs
+if ENABLE_FUSE
+SUBDIRS += fuse
+endif
+
diff --git a/configure.ac b/configure.ac
index bff1e293789a..d5fdfb8a3d17 100644
--- a/configure.ac
+++ b/configure.ac
@@ -63,6 +63,10 @@ AC_ARG_ENABLE(lz4,
    [AS_HELP_STRING([--disable-lz4], [disable LZ4 compression support @<:@default=enabled@:>@])],
    [enable_lz4="$enableval"], [enable_lz4="yes"])
 
+AC_ARG_ENABLE(fuse,
+   [AS_HELP_STRING([--enable-fuse], [enable erofsfuse @<:@default=no@:>@])],
+   [enable_fuse="$enableval"], [enable_fuse="no"])
+
 AC_ARG_WITH(uuid,
    [AS_HELP_STRING([--without-uuid],
       [Ignore presence of libuuid and disable uuid support @<:@default=enabled@:>@])])
@@ -183,6 +187,20 @@ AS_IF([test "x$with_selinux" != "xno"], [
   LIBS="${saved_LIBS}"
   CPPFLAGS="${saved_CPPFLAGS}"], [have_selinux="no"])
 
+# Configure fuse
+AS_IF([test "x$enable_fuse" != "xno"], [
+  PKG_CHECK_MODULES([libfuse], [fuse >= 2.6])
+  # Paranoia: don't trust the result reported by pkgconfig before trying out
+  saved_LIBS="$LIBS"
+  saved_CPPFLAGS=${CPPFLAGS}
+  CPPFLAGS="${libfuse_CFLAGS} ${CPPFLAGS}"
+  LIBS="${libfuse_LIBS} $LIBS"
+  AC_CHECK_LIB(fuse, fuse_main, [
+    have_fuse="yes" ], [
+    AC_MSG_ERROR([libfuse (>= 2.6) doesn't work properly])])
+  LIBS="${saved_LIBS}"
+  CPPFLAGS="${saved_CPPFLAGS}"], [have_fuse="no"])
+
 # Configure lz4
 test -z $LZ4_LIBS && LZ4_LIBS='-llz4'
 
@@ -218,6 +236,7 @@ fi
 # Set up needed symbols, conditionals and compiler/linker flags
 AM_CONDITIONAL([ENABLE_LZ4], [test "x${have_lz4}" = "xyes"])
 AM_CONDITIONAL([ENABLE_LZ4HC], [test "x${have_lz4hc}" = "xyes"])
+AM_CONDITIONAL([ENABLE_FUSE], [test "x${have_fuse}" = "xyes"])
 
 if test "x$have_uuid" = "xyes"; then
   AC_DEFINE([HAVE_LIBUUID], 1, [Define to 1 if libuuid is found])
@@ -247,6 +266,7 @@ AC_SUBST([liblz4_LIBS])
 AC_CONFIG_FILES([Makefile
 		 man/Makefile
 		 lib/Makefile
-		 mkfs/Makefile])
+		 mkfs/Makefile
+		 fuse/Makefile])
 AC_OUTPUT
 
diff --git a/fuse/Makefile.am b/fuse/Makefile.am
new file mode 100644
index 000000000000..6636ee1aec69
--- /dev/null
+++ b/fuse/Makefile.am
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Makefile.am
+
+AUTOMAKE_OPTIONS = foreign
+bin_PROGRAMS     = erofsfuse
+erofsfuse_SOURCES = dir.c main.c
+erofsfuse_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
+erofsfuse_CFLAGS += -DFUSE_USE_VERSION=26 ${libfuse_CFLAGS}
+erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la ${libfuse_LIBS} ${LZ4_LIBS}
+
diff --git a/fuse/dir.c b/fuse/dir.c
new file mode 100644
index 000000000000..3091b5f3da8c
--- /dev/null
+++ b/fuse/dir.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/fuse/dir.c
+ *
+ * Created by Li Guifu <blucerlee@gmail.com>
+ */
+#include <fuse.h>
+#include <fuse_opt.h>
+
+#include "erofs/internal.h"
+#include "erofs/print.h"
+
+static int erofs_fill_dentries(struct erofs_inode *dir,
+			       fuse_fill_dir_t filler, void *buf,
+			       void *dblk, unsigned int nameoff,
+			       unsigned int maxsize)
+{
+	struct erofs_dirent *de = dblk;
+	const struct erofs_dirent *end = dblk + nameoff;
+	char namebuf[EROFS_NAME_LEN];
+
+	while (de < end) {
+		const char *de_name;
+		unsigned int de_namelen;
+
+		nameoff = le16_to_cpu(de->nameoff);
+		de_name = (char *)dblk + nameoff;
+
+		/* the last dirent in the block? */
+		if (de + 1 >= end)
+			de_namelen = strnlen(de_name, maxsize - nameoff);
+		else
+			de_namelen = le16_to_cpu(de[1].nameoff) - nameoff;
+
+		/* a corrupted entry is found */
+		if (nameoff + de_namelen > maxsize ||
+		    de_namelen > EROFS_NAME_LEN) {
+			erofs_err("bogus dirent @ nid %llu", dir->nid | 0ULL);
+			DBG_BUGON(1);
+			return -EFSCORRUPTED;
+		}
+
+		memcpy(namebuf, de_name, de_namelen);
+		namebuf[de_namelen] = '\0';
+
+		filler(buf, namebuf, NULL, 0);
+		++de;
+	}
+	return 0;
+}
+
+int erofsfuse_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
+		      off_t offset, struct fuse_file_info *fi)
+{
+	int ret;
+	struct erofs_inode dir;
+	char dblk[EROFS_BLKSIZ];
+	erofs_off_t pos;
+
+	erofs_dbg("readdir:%s offset=%llu", path, (long long)offset);
+
+	ret = erofs_ilookup(path, &dir);
+	if (ret)
+		return ret;
+
+	erofs_dbg("path=%s nid = %llu", path, dir.nid | 0ULL);
+
+	if (!S_ISDIR(dir.i_mode))
+		return -ENOTDIR;
+
+	if (!dir.i_size)
+		return 0;
+
+	pos = 0;
+	while (pos < dir.i_size) {
+		unsigned int nameoff, maxsize;
+		struct erofs_dirent *de;
+
+		maxsize = min_t(unsigned int, EROFS_BLKSIZ,
+				dir.i_size - pos);
+		ret = erofs_pread(&dir, dblk, maxsize, pos);
+		if (ret)
+			return ret;
+
+		de = (struct erofs_dirent *)dblk;
+		nameoff = le16_to_cpu(de->nameoff);
+		if (nameoff < sizeof(struct erofs_dirent) ||
+		    nameoff >= PAGE_SIZE) {
+			erofs_err("invalid de[0].nameoff %u @ nid %llu",
+				  nameoff, dir.nid | 0ULL);
+			ret = -EFSCORRUPTED;
+			break;
+		}
+
+		ret = erofs_fill_dentries(&dir, filler, buf,
+					  dblk, nameoff, maxsize);
+		if (ret)
+			break;
+		pos += maxsize;
+	}
+	return 0;
+}
+
diff --git a/fuse/main.c b/fuse/main.c
new file mode 100644
index 000000000000..c8e9aa37082b
--- /dev/null
+++ b/fuse/main.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/fuse/main.c
+ *
+ * Created by Li Guifu <blucerlee@gmail.com>
+ */
+#include <stdlib.h>
+#include <string.h>
+#include <execinfo.h>
+#include <signal.h>
+#include <libgen.h>
+#include <fuse.h>
+#include <fuse_opt.h>
+
+#include "erofs/config.h"
+#include "erofs/print.h"
+#include "erofs/io.h"
+
+int erofsfuse_readdir(const char *path, void *buffer, fuse_fill_dir_t filler,
+		      off_t offset, struct fuse_file_info *fi);
+
+static void *erofsfuse_init(struct fuse_conn_info *info)
+{
+	erofs_info("Using FUSE protocol %d.%d", info->proto_major, info->proto_minor);
+	return NULL;
+}
+
+static int erofsfuse_open(const char *path, struct fuse_file_info *fi)
+{
+	erofs_dbg("open path=%s", path);
+
+	if ((fi->flags & O_ACCMODE) != O_RDONLY)
+		return -EACCES;
+
+	return 0;
+}
+
+static int erofsfuse_getattr(const char *path, struct stat *stbuf)
+{
+	struct erofs_inode vi = { 0 };
+	int ret;
+
+	erofs_dbg("getattr(%s)", path);
+	ret = erofs_ilookup(path, &vi);
+	if (ret)
+		return -ENOENT;
+
+	stbuf->st_mode  = vi.i_mode;
+	stbuf->st_nlink = vi.i_nlink;
+	stbuf->st_size  = vi.i_size;
+	stbuf->st_blocks = roundup(vi.i_size, EROFS_BLKSIZ) >> 9;
+	stbuf->st_uid = vi.i_uid;
+	stbuf->st_gid = vi.i_gid;
+	if (S_ISBLK(vi.i_mode) || S_ISCHR(vi.i_mode))
+		stbuf->st_rdev = vi.u.i_rdev;
+	stbuf->st_ctime = vi.i_ctime;
+	stbuf->st_mtime = stbuf->st_ctime;
+	stbuf->st_atime = stbuf->st_ctime;
+	return 0;
+}
+
+static int erofsfuse_read(const char *path, char *buffer,
+			  size_t size, off_t offset,
+			  struct fuse_file_info *fi)
+{
+	int ret;
+	struct erofs_inode vi;
+
+	erofs_dbg("path:%s size=%zd offset=%llu", path, size, (long long)offset);
+
+	ret = erofs_ilookup(path, &vi);
+	if (ret)
+		return ret;
+
+	ret = erofs_pread(&vi, buffer, size, offset);
+	if (ret)
+		return ret;
+	return size;
+}
+
+static struct fuse_operations erofs_ops = {
+	.getattr = erofsfuse_getattr,
+	.readdir = erofsfuse_readdir,
+	.open = erofsfuse_open,
+	.read = erofsfuse_read,
+	.init = erofsfuse_init,
+};
+
+static struct options {
+	const char *disk;
+	const char *mountpoint;
+	unsigned int debug_lvl;
+	bool show_help;
+	bool odebug;
+} fusecfg;
+
+#define OPTION(t, p)                           \
+    { t, offsetof(struct options, p), 1 }
+static const struct fuse_opt option_spec[] = {
+	OPTION("--dbglevel=%u", debug_lvl),
+	OPTION("--help", show_help),
+	FUSE_OPT_END
+};
+
+#define OPTION(t, p)    { t, offsetof(struct options, p), 1 }
+
+static void usage(void)
+{
+	struct fuse_args args = FUSE_ARGS_INIT(0, NULL);
+
+	fputs("usage: [options] IMAGE MOUNTPOINT\n\n"
+	      "Options:\n"
+	      "    --dbglevel=#           set output message level to # (maximum 9)\n"
+#if FUSE_MAJOR_VERSION < 3
+	      "    --help                 display this help and exit\n"
+#endif
+	      "\n", stderr);
+
+#if FUSE_MAJOR_VERSION >= 3
+	fuse_cmdline_help();
+#else
+	fuse_opt_add_arg(&args, ""); /* progname */
+	fuse_opt_add_arg(&args, "-ho"); /* progname */
+	fuse_parse_cmdline(&args, NULL, NULL, NULL);
+#endif
+	exit(EXIT_FAILURE);
+}
+
+static void erofsfuse_dumpcfg(void)
+{
+	erofs_dump("disk: %s\n", fusecfg.disk);
+	erofs_dump("mountpoint: %s\n", fusecfg.mountpoint);
+	erofs_dump("dbglevel: %u\n", cfg.c_dbg_lvl);
+}
+
+static int optional_opt_func(void *data, const char *arg, int key,
+			     struct fuse_args *outargs)
+{
+	switch (key) {
+	case FUSE_OPT_KEY_NONOPT:
+		if (fusecfg.mountpoint)
+			return -1; /* Too many args */
+
+		if (!fusecfg.disk) {
+			fusecfg.disk = strdup(arg);
+			return 0;
+		}
+		if (!fusecfg.mountpoint)
+			fusecfg.mountpoint = strdup(arg);
+	case FUSE_OPT_KEY_OPT:
+		if (!strcmp(arg, "-d"))
+			fusecfg.odebug = true;
+		break;
+	default:
+		DBG_BUGON(1);
+		break;
+	}
+	return 1;
+}
+
+static void signal_handle_sigsegv(int signal)
+{
+	void *array[10];
+	size_t nptrs;
+	char **strings;
+	size_t i;
+
+	erofs_dump("========================================\n");
+	erofs_dump("Segmentation Fault.  Starting backtrace:\n");
+	nptrs = backtrace(array, 10);
+	strings = backtrace_symbols(array, nptrs);
+	if (strings) {
+		for (i = 0; i < nptrs; i++)
+			erofs_dbg("%s", strings[i]);
+		free(strings);
+	}
+	erofs_dump("========================================\n");
+	abort();
+}
+
+
+int main(int argc, char *argv[])
+{
+	int ret;
+	struct fuse_args args = FUSE_ARGS_INIT(argc, argv);
+
+	erofs_init_configure();
+	fprintf(stderr, "%s %s\n", basename(argv[0]), cfg.c_version);
+
+	if (signal(SIGSEGV, signal_handle_sigsegv) == SIG_ERR) {
+		fprintf(stderr, "failed to initialize signals\n");
+		ret = -errno;
+		goto err;
+	}
+
+	/* parse options */
+	ret = fuse_opt_parse(&args, &fusecfg, option_spec, optional_opt_func);
+	if (ret)
+		goto err;
+
+	if (fusecfg.show_help || !fusecfg.mountpoint)
+		usage();
+	cfg.c_dbg_lvl = fusecfg.debug_lvl;
+
+	if (fusecfg.odebug && cfg.c_dbg_lvl < EROFS_DBG)
+		cfg.c_dbg_lvl = EROFS_DBG;
+
+	erofsfuse_dumpcfg();
+	ret = dev_open_ro(fusecfg.disk);
+	if (ret) {
+		fprintf(stderr, "failed to open: %s\n", fusecfg.disk);
+		goto err_fuse_free_args;
+	}
+
+	ret = erofs_read_superblock();
+	if (ret) {
+		fprintf(stderr, "failed to read erofs super block\n");
+		goto err_dev_close;
+	}
+
+	ret = fuse_main(args.argc, args.argv, &erofs_ops, NULL);
+err_dev_close:
+	dev_close();
+err_fuse_free_args:
+	fuse_opt_free_args(&args);
+err:
+	erofs_exit_configure();
+	return ret ? EXIT_FAILURE : EXIT_SUCCESS;
+}
+
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index cabb2faa0072..38eaf0d094d3 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -36,6 +36,8 @@ typedef unsigned short umode_t;
 #error incompatible PAGE_SIZE is already defined
 #endif
 
+#define PAGE_MASK		(~(PAGE_SIZE-1))
+
 #define LOG_BLOCK_SIZE          (12)
 #define EROFS_BLKSIZ            (1U << LOG_BLOCK_SIZE)
 
@@ -59,6 +61,8 @@ typedef u32 erofs_blk_t;
 struct erofs_buffer_head;
 
 struct erofs_sb_info {
+	u64 blocks;
+
 	erofs_blk_t meta_blkaddr;
 	erofs_blk_t xattr_blkaddr;
 
@@ -66,12 +70,25 @@ struct erofs_sb_info {
 	u32 feature_incompat;
 	u64 build_time;
 	u32 build_time_nsec;
+
+	unsigned char islotbits;
+
+	/* what we really care is nid, rather than ino.. */
+	erofs_nid_t root_nid;
+	/* used for statfs, f_files - f_favail */
+	u64 inos;
+
 	u8 uuid[16];
 };
 
 /* global sbi */
 extern struct erofs_sb_info sbi;
 
+static inline erofs_off_t iloc(erofs_nid_t nid)
+{
+	return blknr_to_addr(sbi.meta_blkaddr) + (nid << sbi.islotbits);
+}
+
 #define EROFS_FEATURE_FUNCS(name, compat, feature) \
 static inline bool erofs_sb_has_##name(void) \
 { \
@@ -126,7 +143,16 @@ struct erofs_inode {
 	struct erofs_buffer_head *bh_inline, *bh_data;
 
 	void *idata;
-	void *compressmeta;
+
+	union {
+		void *compressmeta;
+		struct {
+			uint16_t z_advise;
+			uint8_t  z_algorithmtype[2];
+			uint8_t  z_logical_clusterbits;
+			uint8_t  z_physical_clusterbits[2];
+		};
+	};
 #ifdef WITH_ANDROID
 	uint64_t capabilities;
 #endif
@@ -137,6 +163,26 @@ static inline bool is_inode_layout_compression(struct erofs_inode *inode)
 	return erofs_inode_is_data_compressed(inode->datalayout);
 }
 
+static inline unsigned int erofs_bitrange(unsigned int value, unsigned int bit,
+					  unsigned int bits)
+{
+
+	return (value >> bit) & ((1 << bits) - 1);
+}
+
+
+static inline unsigned int erofs_inode_version(unsigned int value)
+{
+	return erofs_bitrange(value, EROFS_I_VERSION_BIT,
+			      EROFS_I_VERSION_BITS);
+}
+
+static inline unsigned int erofs_inode_datalayout(unsigned int value)
+{
+	return erofs_bitrange(value, EROFS_I_DATALAYOUT_BIT,
+			      EROFS_I_DATALAYOUT_BITS);
+}
+
 #define IS_ROOT(x)	((x) == (x)->i_parent)
 
 struct erofs_dentry {
@@ -169,5 +215,43 @@ static inline const char *erofs_strerror(int err)
 	return msg;
 }
 
+enum {
+	BH_Meta,
+	BH_Mapped,
+	BH_Zipped,
+	BH_FullMapped,
+};
+
+/* Has a disk mapping */
+#define EROFS_MAP_MAPPED	(1 << BH_Mapped)
+/* Located in metadata (could be copied from bd_inode) */
+#define EROFS_MAP_META		(1 << BH_Meta)
+/* The extent has been compressed */
+#define EROFS_MAP_ZIPPED	(1 << BH_Zipped)
+/* The length of extent is full */
+#define EROFS_MAP_FULL_MAPPED	(1 << BH_FullMapped)
+
+struct erofs_map_blocks {
+	char mpage[EROFS_BLKSIZ];
+
+	erofs_off_t m_pa, m_la;
+	u64 m_plen, m_llen;
+
+	unsigned int m_flags;
+	erofs_blk_t index;
+};
+
+/* super.c */
+int erofs_read_superblock(void);
+
+/* namei.c */
+int erofs_ilookup(const char *path, struct erofs_inode *vi);
+
+/* data.c */
+int erofs_pread(struct erofs_inode *inode, char *buf,
+		erofs_off_t count, erofs_off_t offset);
+
+#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
+
 #endif
 
diff --git a/include/erofs/io.h b/include/erofs/io.h
index a23de64541c6..557424578ece 100644
--- a/include/erofs/io.h
+++ b/include/erofs/io.h
@@ -17,6 +17,7 @@
 #endif
 
 int dev_open(const char *devname);
+int dev_open_ro(const char *dev);
 void dev_close(void);
 int dev_write(const void *buf, u64 offset, size_t len);
 int dev_read(void *buf, u64 offset, size_t len);
diff --git a/include/erofs/trace.h b/include/erofs/trace.h
new file mode 100644
index 000000000000..5a12da753d70
--- /dev/null
+++ b/include/erofs/trace.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * erofs-utils/include/erofs/trace.h
+ *
+ * Copyright (C) 2020 Gao Xiang <hsiangkao@aol.com>
+ */
+#ifndef __EROFS_TRACE_H
+#define __EROFS_TRACE_H
+
+#define trace_erofs_map_blocks_flatmode_enter(inode, map, flags) ((void)0)
+#define trace_erofs_map_blocks_flatmode_exit(inode, map, flags, ret) ((void)0)
+
+#endif
+
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 4cd79f01d820..a69f179a51a5 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -279,6 +279,10 @@ struct z_erofs_vle_decompressed_index {
 	} di_u;
 };
 
+#define Z_EROFS_VLE_LEGACY_INDEX_ALIGN(size) \
+	(round_up(size, sizeof(struct z_erofs_vle_decompressed_index)) + \
+	 sizeof(struct z_erofs_map_header) + Z_EROFS_VLE_LEGACY_HEADER_PADDING)
+
 #define Z_EROFS_VLE_EXTENT_ALIGN(size) round_up(size, \
 	sizeof(struct z_erofs_vle_decompressed_index))
 
diff --git a/lib/Makefile.am b/lib/Makefile.am
index e4b51e65f053..e1c43fa89009 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -2,8 +2,8 @@
 # Makefile.am
 
 noinst_LTLIBRARIES = liberofs.la
-liberofs_la_SOURCES = config.c io.c cache.c inode.c xattr.c \
-		      compress.c compressor.c exclude.c
+liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
+		      namei.c data.c compress.c compressor.c
 liberofs_la_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
 if ENABLE_LZ4
 liberofs_la_CFLAGS += ${LZ4_CFLAGS}
diff --git a/lib/data.c b/lib/data.c
new file mode 100644
index 000000000000..0337521f560e
--- /dev/null
+++ b/lib/data.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/lib/data.c
+ *
+ * Copyright (C) 2020 Gao Xiang <hsiangkao@aol.com>
+ * Compression support by Huang Jianan <huangjianan@oppo.com>
+ */
+#include "erofs/print.h"
+#include "erofs/internal.h"
+#include "erofs/io.h"
+#include "erofs/trace.h"
+
+static int erofs_map_blocks_flatmode(struct erofs_inode *inode,
+				     struct erofs_map_blocks *map,
+				     int flags)
+{
+	int err = 0;
+	erofs_blk_t nblocks, lastblk;
+	u64 offset = map->m_la;
+	struct erofs_inode *vi = inode;
+	bool tailendpacking = (vi->datalayout == EROFS_INODE_FLAT_INLINE);
+
+	trace_erofs_map_blocks_flatmode_enter(inode, map, flags);
+
+	nblocks = DIV_ROUND_UP(inode->i_size, PAGE_SIZE);
+	lastblk = nblocks - tailendpacking;
+
+	if (offset >= inode->i_size) {
+		/* leave out-of-bound access unmapped */
+		map->m_flags = 0;
+		goto out;
+	}
+
+	/* there is no hole in flatmode */
+	map->m_flags = EROFS_MAP_MAPPED;
+
+	if (offset < blknr_to_addr(lastblk)) {
+		map->m_pa = blknr_to_addr(vi->u.i_blkaddr) + map->m_la;
+		map->m_plen = blknr_to_addr(lastblk) - offset;
+	} else if (tailendpacking) {
+		/* 2 - inode inline B: inode, [xattrs], inline last blk... */
+		map->m_pa = iloc(vi->nid) + vi->inode_isize +
+			vi->xattr_isize + erofs_blkoff(map->m_la);
+		map->m_plen = inode->i_size - offset;
+
+		/* inline data should be located in one meta block */
+		if (erofs_blkoff(map->m_pa) + map->m_plen > PAGE_SIZE) {
+			erofs_err("inline data cross block boundary @ nid %" PRIu64,
+				  vi->nid);
+			DBG_BUGON(1);
+			err = -EFSCORRUPTED;
+			goto err_out;
+		}
+
+		map->m_flags |= EROFS_MAP_META;
+	} else {
+		erofs_err("internal error @ nid: %" PRIu64 " (size %llu), m_la 0x%" PRIx64,
+			  vi->nid, (unsigned long long)inode->i_size, map->m_la);
+		DBG_BUGON(1);
+		err = -EIO;
+		goto err_out;
+	}
+
+out:
+	map->m_llen = map->m_plen;
+
+err_out:
+	trace_erofs_map_blocks_flatmode_exit(inode, map, flags, 0);
+	return err;
+}
+
+static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
+			       erofs_off_t size, erofs_off_t offset)
+{
+	struct erofs_map_blocks map = {
+		.index = UINT_MAX,
+	};
+	int ret;
+	erofs_off_t ptr = offset;
+
+	while (ptr < offset + size) {
+		erofs_off_t eend;
+
+		map.m_la = ptr;
+		ret = erofs_map_blocks_flatmode(inode, &map, 0);
+		if (ret)
+			return ret;
+
+		DBG_BUGON(map.m_plen != map.m_llen);
+
+		if (!(map.m_flags & EROFS_MAP_MAPPED)) {
+			if (!map.m_llen) {
+				ptr = offset + size;
+				continue;
+			}
+			ptr = map.m_la + map.m_llen;
+			continue;
+		}
+
+		/* trim extent */
+		eend = min(offset + size, map.m_la + map.m_llen);
+		DBG_BUGON(ptr < map.m_la);
+
+		if (ptr > map.m_la) {
+			map.m_pa += ptr - map.m_la;
+			map.m_la = ptr;
+		}
+
+		ret = dev_read(buffer + ptr - offset,
+			       map.m_pa, eend - map.m_la);
+		if (ret < 0)
+			return -EIO;
+
+		ptr = eend;
+	}
+	return 0;
+}
+
+int erofs_pread(struct erofs_inode *inode, char *buf,
+		erofs_off_t count, erofs_off_t offset)
+{
+	switch (inode->datalayout) {
+	case EROFS_INODE_FLAT_PLAIN:
+	case EROFS_INODE_FLAT_INLINE:
+		return erofs_read_raw_data(inode, buf, count, offset);
+	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
+	case EROFS_INODE_FLAT_COMPRESSION:
+		return -EOPNOTSUPP;
+	default:
+		break;
+	}
+	return -EINVAL;
+}
+
diff --git a/lib/io.c b/lib/io.c
index 4f5d9a6edaa4..d835f34da50f 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -108,6 +108,22 @@ int dev_open(const char *dev)
 	return 0;
 }
 
+/* XXX: temporary soluation. Disk I/O implementation needs to be refactored. */
+int dev_open_ro(const char *dev)
+{
+	int fd = open(dev, O_RDONLY | O_BINARY);
+
+	if (fd < 0) {
+		erofs_err("failed to open(%s).", dev);
+		return -errno;
+	}
+
+	erofs_devfd = fd;
+	erofs_devname = dev;
+	erofs_devsz = INT64_MAX;
+	return 0;
+}
+
 u64 dev_length(void)
 {
 	return erofs_devsz;
diff --git a/lib/namei.c b/lib/namei.c
new file mode 100644
index 000000000000..b05f5c421d54
--- /dev/null
+++ b/lib/namei.c
@@ -0,0 +1,246 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/lib/namei.c
+ *
+ * Created by Li Guifu <blucerlee@gmail.com>
+ */
+#include <linux/kdev_t.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <errno.h>
+#include <sys/stat.h>
+#include <sys/sysmacros.h>
+
+#include "erofs/print.h"
+#include "erofs/io.h"
+
+static int erofs_read_inode_from_disk(struct erofs_inode *vi)
+{
+	int ret, ifmt;
+	char buf[sizeof(struct erofs_inode_extended)];
+	struct erofs_inode_compact *dic;
+	struct erofs_inode_extended *die;
+	const erofs_off_t inode_loc = iloc(vi->nid);
+
+	ret = dev_read(buf, inode_loc, sizeof(*dic));
+	if (ret < 0)
+		return -EIO;
+
+	dic = (struct erofs_inode_compact *)buf;
+	ifmt = le16_to_cpu(dic->i_format);
+
+	vi->datalayout = erofs_inode_datalayout(ifmt);
+	if (vi->datalayout >= EROFS_INODE_DATALAYOUT_MAX) {
+		erofs_err("unsupported datalayout %u of nid %llu",
+			  vi->datalayout, vi->nid | 0ULL);
+		return -EOPNOTSUPP;
+	}
+	switch (erofs_inode_version(ifmt)) {
+	case EROFS_INODE_LAYOUT_EXTENDED:
+		vi->inode_isize = sizeof(struct erofs_inode_extended);
+
+		ret = dev_read(buf + sizeof(*dic), inode_loc + sizeof(*dic),
+			       sizeof(*die) - sizeof(*dic));
+		if (ret < 0)
+			return -EIO;
+
+		die = (struct erofs_inode_extended *)buf;
+		vi->xattr_isize = erofs_xattr_ibody_size(die->i_xattr_icount);
+		vi->i_mode = le16_to_cpu(die->i_mode);
+
+		switch (vi->i_mode & S_IFMT) {
+		case S_IFREG:
+		case S_IFDIR:
+		case S_IFLNK:
+			vi->u.i_blkaddr = le32_to_cpu(die->i_u.raw_blkaddr);
+			break;
+		case S_IFCHR:
+		case S_IFBLK:
+			return -EOPNOTSUPP;
+		case S_IFIFO:
+		case S_IFSOCK:
+			return -EOPNOTSUPP;
+		default:
+			goto bogusimode;
+		}
+
+		vi->i_uid = le32_to_cpu(die->i_uid);
+		vi->i_gid = le32_to_cpu(die->i_gid);
+		vi->i_nlink = le32_to_cpu(die->i_nlink);
+
+		vi->i_ctime = le64_to_cpu(die->i_ctime);
+		vi->i_ctime_nsec = le64_to_cpu(die->i_ctime_nsec);
+		vi->i_size = le64_to_cpu(die->i_size);
+		break;
+	case EROFS_INODE_LAYOUT_COMPACT:
+		vi->inode_isize = sizeof(struct erofs_inode_compact);
+		vi->xattr_isize = erofs_xattr_ibody_size(dic->i_xattr_icount);
+		vi->i_mode = le16_to_cpu(dic->i_mode);
+
+		switch (vi->i_mode & S_IFMT) {
+		case S_IFREG:
+		case S_IFDIR:
+		case S_IFLNK:
+			vi->u.i_blkaddr = le32_to_cpu(dic->i_u.raw_blkaddr);
+			break;
+		case S_IFCHR:
+		case S_IFBLK:
+			return -EOPNOTSUPP;
+		case S_IFIFO:
+		case S_IFSOCK:
+			return -EOPNOTSUPP;
+		default:
+			goto bogusimode;
+		}
+
+		vi->i_uid = le16_to_cpu(dic->i_uid);
+		vi->i_gid = le16_to_cpu(dic->i_gid);
+		vi->i_nlink = le16_to_cpu(dic->i_nlink);
+
+		vi->i_ctime = sbi.build_time;
+		vi->i_ctime_nsec = sbi.build_time_nsec;
+
+		vi->i_size = le32_to_cpu(dic->i_size);
+		break;
+	default:
+		erofs_err("unsupported on-disk inode version %u of nid %llu",
+			  erofs_inode_version(ifmt), vi->nid | 0ULL);
+		return -EOPNOTSUPP;
+	}
+	return 0;
+bogusimode:
+	erofs_err("bogus i_mode (%o) @ nid %llu", vi->i_mode, vi->nid | 0ULL);
+	return -EFSCORRUPTED;
+}
+
+
+struct erofs_dirent *find_target_dirent(erofs_nid_t pnid,
+					void *dentry_blk,
+					const char *name, unsigned int len,
+					unsigned int nameoff,
+					unsigned int maxsize)
+{
+	struct erofs_dirent *de = dentry_blk;
+	const struct erofs_dirent *end = dentry_blk + nameoff;
+
+	while (de < end) {
+		const char *de_name;
+		unsigned int de_namelen;
+
+		nameoff = le16_to_cpu(de->nameoff);
+		de_name = (char *)dentry_blk + nameoff;
+
+		/* the last dirent in the block? */
+		if (de + 1 >= end)
+			de_namelen = strnlen(de_name, maxsize - nameoff);
+		else
+			de_namelen = le16_to_cpu(de[1].nameoff) - nameoff;
+
+		/* a corrupted entry is found */
+		if (nameoff + de_namelen > maxsize ||
+		    de_namelen > EROFS_NAME_LEN) {
+			erofs_err("bogus dirent @ nid %llu", pnid | 0ULL);
+			DBG_BUGON(1);
+			return ERR_PTR(-EFSCORRUPTED);
+		}
+
+		if (len == de_namelen && !memcmp(de_name, name, de_namelen))
+			return de;
+		++de;
+	}
+	return NULL;
+}
+
+struct nameidata {
+	erofs_nid_t	nid;
+	unsigned int	ftype;
+};
+
+int erofs_namei(struct nameidata *nd,
+		const char *name, unsigned int len)
+{
+	erofs_nid_t nid = nd->nid;
+	int ret;
+	char buf[EROFS_BLKSIZ];
+	struct erofs_inode vi = { .nid = nid };
+	erofs_off_t offset;
+
+	ret = erofs_read_inode_from_disk(&vi);
+	if (ret)
+		return ret;
+
+	offset = 0;
+	while (offset < vi.i_size) {
+		erofs_off_t maxsize = min_t(erofs_off_t,
+					    vi.i_size - offset, EROFS_BLKSIZ);
+		struct erofs_dirent *de = (void *)buf;
+		unsigned int nameoff;
+
+		ret = erofs_pread(&vi, buf, maxsize, offset);
+		if (ret)
+			return ret;
+
+		nameoff = le16_to_cpu(de->nameoff);
+		if (nameoff < sizeof(struct erofs_dirent) ||
+		    nameoff >= PAGE_SIZE) {
+			erofs_err("invalid de[0].nameoff %u @ nid %llu",
+				  nameoff, nid | 0ULL);
+			return -EFSCORRUPTED;
+		}
+
+		de = find_target_dirent(nid, buf, name, len,
+					nameoff, maxsize);
+		if (IS_ERR(de))
+			return PTR_ERR(de);
+
+		if (de) {
+			nd->nid = le64_to_cpu(de->nid);
+			return 0;
+		}
+		offset += maxsize;
+	}
+	return -ENOENT;
+}
+
+static int link_path_walk(const char *name, struct nameidata *nd)
+{
+	nd->nid = sbi.root_nid;
+
+	while (*name == '/')
+		name++;
+
+	/* At this point we know we have a real path component. */
+	while (*name != '\0') {
+		const char *p = name;
+		int ret;
+
+		do {
+			++p;
+		} while (*p != '\0' && *p != '/');
+
+		DBG_BUGON(p <= name);
+		ret = erofs_namei(nd, name, p - name);
+		if (ret)
+			return ret;
+
+		name = p;
+		/* Skip until no more slashes. */
+		for (name = p; *name == '/'; ++name);
+	}
+	return 0;
+}
+
+int erofs_ilookup(const char *path, struct erofs_inode *vi)
+{
+	int ret;
+	struct nameidata nd;
+
+	ret = link_path_walk(path, &nd);
+	if (ret)
+		return ret;
+
+	vi->nid = nd.nid;
+	return erofs_read_inode_from_disk(vi);
+}
+
diff --git a/lib/super.c b/lib/super.c
new file mode 100644
index 000000000000..6213585c085d
--- /dev/null
+++ b/lib/super.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/lib/super.c
+ *
+ * Created by Li Guifu <blucerlee@gmail.com>
+ */
+#include <string.h>
+#include <stdlib.h>
+#include <asm-generic/errno-base.h>
+
+#include "erofs/io.h"
+#include "erofs/print.h"
+
+struct erofs_super_block super;
+struct erofs_sb_info sbi;
+
+static bool check_layout_compatibility(struct erofs_sb_info *sbi,
+				       struct erofs_super_block *dsb)
+{
+	const unsigned int feature = le32_to_cpu(dsb->feature_incompat);
+
+	sbi->feature_incompat = feature;
+
+	/* check if current kernel meets all mandatory requirements */
+	if (feature & (~EROFS_ALL_FEATURE_INCOMPAT)) {
+		erofs_err("unidentified incompatible feature %x, please upgrade kernel version",
+			  feature & ~EROFS_ALL_FEATURE_INCOMPAT);
+		return false;
+	}
+	return true;
+}
+
+int erofs_read_superblock(void)
+{
+	char data[EROFS_BLKSIZ];
+	struct erofs_super_block *dsb;
+	unsigned int blkszbits;
+	int ret;
+
+	ret = blk_read(data, 0, 1);
+	if (ret < 0) {
+		erofs_err("cannot read erofs superblock: %d", ret);
+		return -EIO;
+	}
+	dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
+
+	ret = -EINVAL;
+	if (le32_to_cpu(dsb->magic) != EROFS_SUPER_MAGIC_V1) {
+		erofs_err("cannot find valid erofs superblock");
+		return ret;
+	}
+
+	sbi.feature_compat = le32_to_cpu(dsb->feature_compat);
+
+	blkszbits = dsb->blkszbits;
+	/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
+	if (blkszbits != LOG_BLOCK_SIZE) {
+		erofs_err("blksize %u isn't supported on this platform",
+			  1 << blkszbits);
+		return ret;
+	}
+
+	if (!check_layout_compatibility(&sbi, dsb))
+		return ret;
+
+	sbi.blocks = le32_to_cpu(dsb->blocks);
+	sbi.meta_blkaddr = le32_to_cpu(dsb->meta_blkaddr);
+	sbi.xattr_blkaddr = le32_to_cpu(dsb->xattr_blkaddr);
+	sbi.islotbits = EROFS_ISLOTBITS;
+	sbi.root_nid = le16_to_cpu(dsb->root_nid);
+	sbi.inos = le64_to_cpu(dsb->inos);
+
+	sbi.build_time = le64_to_cpu(dsb->build_time);
+	sbi.build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
+
+	memcpy(&sbi.uuid, dsb->uuid, sizeof(dsb->uuid));
+	return 0;
+}
+
-- 
2.24.0

