Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DF0FA9FB
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Nov 2019 07:02:14 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47CYst6ZPYzF76J
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Nov 2019 17:02:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1573624930;
	bh=XD22ERSiGCRDfA2q0rOyr5k3Vz4Z1UgUjo5KE0cIQY8=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=hS7P5443UmHHYJ5gVOJjrugrbjSCDhLOHF1Rtp1oBGyjhNXI3MJ9DRICFWAcRoo4V
	 nxGO2MBY/IoRlgI8nzQHi/26nLps9ilEAtRJGSnpjSwpCszkvYnIs1V72k0rRWo4VM
	 as3l5hN8XG24GE/iBL01iIprWpnnt1DbplW2ZkivZGwgdyeASQD5B0pHFtJOKnwxMU
	 OLh1I35Aa+uaLlC3e086AlRVxvC0uS1W3bV2cMOoTMaWSiHEGU9jmsysf7DnQeAbRI
	 kAHE16+R2F5H2I9u7Acwrm3SKJ4XBdvsbZw5bDIy7jDTG2Z4qG9aIZPCjlPAbUFSvt
	 3W1/gDBAvLMJg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.206; helo=sonic311-25.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="jSznvBw4"; 
 dkim-atps=neutral
Received: from sonic311-25.consmr.mail.gq1.yahoo.com
 (sonic311-25.consmr.mail.gq1.yahoo.com [98.137.65.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47CYsj6vp4zF760
 for <linux-erofs@lists.ozlabs.org>; Wed, 13 Nov 2019 17:01:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1573624916; bh=N/N4atbVXhW1Fe9A3cf7uq0Vx50hSsRxCdI7adUCkOQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=jSznvBw4JukwiSlWotrEKH6kS9c+470KNpd0fNMEqbxOja5lhqvuya6NlwrH/fhU+nWQVYtEmlXNZEPa0Imgb0HmMiXS+aXJ2cb9Mh74FSxsps/fhgc+/HjZqzxfHYw1S59IlNz0Ee4fpB3JGnK3iZeYifeiIEwFgJh0zqsDcHLrSThgfyKRPm2YJ+rw0YrXCXusQ8PO++KJs4f3f2smZa7ntHJRkw6UvANP5Whr/Ua1wN6mjCx7RdrCInAY3UeDEfqknid5t1H2CcdTGK+iedZp+0xg8sCUHIVpQYKL/VufphWsWKiGTfLMvhmBpy37oXNZeH9TaUOWPFJJnkUXjA==
X-YMail-OSG: FuYsQLYVM1nsVaTnW1EJ16MIJryQtmkzUX7xwUendKfECivRksTA_jvpX21Ze8p
 kvSEh.XpSp6gxfV4MTjQ9_a.S7lCcYcISn2AjtQD54rM_CX0xuew.Oe2n6sGfrica7ySI7mhWav7
 cuUjZx4mw01xUdqKkC7bKaBURmbgJY9hdRpswz48ayKhnJr9azXNBDrZ2fjN6J6FvlYh3FAlEVoT
 WQutAtscAX4_PsegXC9w0gwCHLKotprCaz7UgaunzV6JLYaaKoauukACfWwm4Hqp6htw0ma_8Uyv
 0keI1ZNX6ylmyQAGBBiwzh2x16rYloB.uQRlgsRoW83y5X4BljrHGSHerYSe_NLryWvk4uAxShOG
 PoqbPpT47rKZziCklG12zmHlhT6Y3Mh4EoayEYLJTDFoCjvu6urVzbHgqTmY_qaaCweOhcHwwFlF
 IHfg_bR..b6HhlNReXGrK2v6ztkt06XzPpRDgh1dAMY0hVMlsNCmY6thP5xq68TMmCfO0_Qfbwmb
 HeW5PHrboG1CBZzcODUITPpvNhSEjtLraz4s3cOT9jaMTWUotmmpHX9_.AaVITUoeXOoGpMuh7y2
 YG_9uAoFdHaPieI7bdaUMFb3tX0p8XN6HQ6SwX1B5cj.plkAJ9BXv68pe0bWpPVu9hlB4iaB5GaJ
 _3vo1l6L1w0EMJntkWXBwcwSHCgnecDUf7_TzRWr3oNGxa_2UriQcvkT7HhyYsiSE8nm4eFMXexn
 9EwDNdDfWwcpXMRby2tNedqsrtSfTh9ZufD.18lczN.2l7QzVoPtsCUdI3UbTvLudVoIHc6m3ovK
 kYENi_mbMPcSnosBYmZYF14tj81efzUjEbgRqbwGhhz415ZHEz8p7nMTespwn7LRUuzg_lB32Cyj
 9W_cSSvS7gniG6J.tDIvkMq7xHVXb8aRr4SnmMzwdk18tsoJg016D0gBUHOqJvLE06BXvoK7ZZsj
 2nGngylBFmxaARWF5i6KDBnahZS_.YYgGulSkJEiMiwMj6OysoJP_P2wHNPEPK2oEQoDOZh.rYZP
 bV2aZHpYUdw4Khza81AuKG3gjAvg349QEf2_PHpiG58F9JIz0nlQK1RnJXKyWiP.yDCYVeZmpe_6
 bnh8QzKjF3zqlNVdYJ4KExXBjthA4WyKl1XPgZ8iltvNHPEyD2EnHcHaGzoelgbdR.PuY6UkhPzZ
 vnGr.ootSmvtHv_R5ULJj8FqsmfpM9dND.piFuvfMRo7SAXFKc.ixlEcWN8uCMgp2T5WWw555aNp
 E583Ue2SARoDnm4FkVEuu8xkOYrfvQTnVkRqgHPAwEfOcsKRWNiHN3WM7xaAjoHKO9U4Xti8S03Z
 jTWQUlZgq3y2TMX9.mar9D_CuTO4QnRrmZRJ9Abm9Tl5ckp3BSBHB1Ux7lup7M2uR_Ee7zKhnvMG
 HMWOFKsq48lpxqPk-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic311.consmr.mail.gq1.yahoo.com with HTTP; Wed, 13 Nov 2019 06:01:56 +0000
Received: by smtp417.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 419ee3d756c724f02396d02693011f1a; 
 Wed, 13 Nov 2019 06:01:53 +0000 (UTC)
To: Li Guifu <bluce.liguifu@huawei.com>, Chao Yu <yuchao0@huawei.com>,
 linux-erofs@lists.ozlabs.org
Subject: [PATCH v4] erofs-utils: support 128-bit filesystem UUID
Date: Wed, 13 Nov 2019 14:01:41 +0800
Message-Id: <20191113060141.9502-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191113035221.30265-1-hsiangkao@aol.com>
References: <20191113035221.30265-1-hsiangkao@aol.com>
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
Cc: Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Complete filesystem UUID feature on userspace side.

Cc: Chao Yu <yuchao0@huawei.com>
Cc: Li Guifu <bluce.liguifu@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
changes since v3:
 - fix configure.ac script and fully passed travis CI
   https://travis-ci.org/erofs/erofs-utils-ci/builds/611213382

 configure.ac             | 41 ++++++++++++++++++++++++++++++++++++++++
 include/erofs/internal.h |  1 +
 mkfs/Makefile.am         |  3 ++-
 mkfs/main.c              | 20 ++++++++++++++++++++
 4 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index a93767f..c7dbe0e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -20,6 +20,15 @@ AC_PROG_INSTALL
 
 LT_INIT
 
+# Test presence of pkg-config
+AC_MSG_CHECKING([pkg-config m4 macros])
+if test m4_ifdef([PKG_CHECK_MODULES], [yes], [no]) = "yes"; then
+  AC_MSG_RESULT([yes]);
+else
+  AC_MSG_RESULT([no]);
+  AC_MSG_ERROR([pkg-config is required. See pkg-config.freedesktop.org])
+fi
+
 dnl EROFS_UTILS_PARSE_DIRECTORY
 dnl Input:  $1 = a string to a relative or absolute directory
 dnl Output: $2 = the variable to set with the absolute directory
@@ -54,6 +63,10 @@ AC_ARG_ENABLE(lz4,
    [AS_HELP_STRING([--disable-lz4], [disable LZ4 compression support @<:@default=enabled@:>@])],
    [enable_lz4="$enableval"], [enable_lz4="yes"])
 
+AC_ARG_WITH(uuid,
+   [AS_HELP_STRING([--without-uuid],
+      [Ignore presence of libuuid and disable uuid support @<:@default=enabled@:>@])])
+
 # Checks for libraries.
 # Use customized LZ4 library path when specified.
 AC_ARG_WITH(lz4-incdir,
@@ -123,6 +136,30 @@ AC_CHECK_DECL(lseek64,[AC_DEFINE(HAVE_LSEEK64_PROTOTYPE, 1,
 # Checks for library functions.
 AC_CHECK_FUNCS([fallocate gettimeofday memset realpath strdup strerror strrchr strtoull])
 
+# Configure libuuid
+AS_IF([test "x$with_uuid" != "xno"], [
+  PKG_CHECK_MODULES([libuuid], [uuid])
+  # Paranoia: don't trust the result reported by pkgconfig before trying out
+  saved_LIBS="$LIBS"
+  saved_CPPFLAGS=${CPPFLAGS}
+  CPPFLAGS="${libuuid_CFLAGS} ${CPPFLAGS}"
+  LIBS="${libuuid_LIBS} $LIBS"
+  AC_MSG_CHECKING([libuuid usability])
+  AC_TRY_LINK([
+#include <uuid.h>
+], [
+uuid_t tmp;
+
+uuid_generate(tmp);
+return 0;
+], [have_uuid="yes"
+    AC_MSG_RESULT([yes])], [
+    have_uuid="no"
+    AC_MSG_RESULT([no])
+    AC_MSG_ERROR([libuuid doesn't work properly])])
+  LIBS="${saved_LIBS}"
+  CPPFLAGS="${saved_CPPFLAGS}"], [have_uuid="no"])
+
 # Configure lz4
 test -z $LZ4_LIBS && LZ4_LIBS='-llz4'
 
@@ -169,6 +206,10 @@ if test "x$enable_lz4" = "xyes"; then
   CFLAGS=${saved_CPPFLAGS}
 fi
 
+if test "x$have_uuid" = "xyes"; then
+  AC_DEFINE([HAVE_LIBUUID], 1, [Define to 1 if libuuid is found])
+fi
+
 AM_CONDITIONAL([ENABLE_LZ4], [test "x${have_lz4}" = "xyes"])
 AM_CONDITIONAL([ENABLE_LZ4HC], [test "x${have_lz4hc}" = "xyes"])
 
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 9e2bb9c..e13adda 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -56,6 +56,7 @@ struct erofs_sb_info {
 	u32 feature_incompat;
 	u64 build_time;
 	u32 build_time_nsec;
+	u8 uuid[16];
 };
 
 /* global sbi */
diff --git a/mkfs/Makefile.am b/mkfs/Makefile.am
index 257f864..9ce06d6 100644
--- a/mkfs/Makefile.am
+++ b/mkfs/Makefile.am
@@ -3,7 +3,8 @@
 
 AUTOMAKE_OPTIONS = foreign
 bin_PROGRAMS     = mkfs.erofs
+AM_CPPFLAGS = ${libuuid_CFLAGS}
 mkfs_erofs_SOURCES = main.c
 mkfs_erofs_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
-mkfs_erofs_LDADD = $(top_builddir)/lib/liberofs.la
+mkfs_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libuuid_LIBS}
 
diff --git a/mkfs/main.c b/mkfs/main.c
index 9187c43..7493a48 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -22,6 +22,10 @@
 #include "erofs/compress.h"
 #include "erofs/xattr.h"
 
+#ifdef HAVE_LIBUUID
+#include <uuid/uuid.h>
+#endif
+
 #define EROFS_SUPER_END (EROFS_SUPER_OFFSET + sizeof(struct erofs_super_block))
 
 static struct option long_options[] = {
@@ -234,6 +238,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 	*blocks         = erofs_mapbh(NULL, true);
 	sb.blocks       = cpu_to_le32(*blocks);
 	sb.root_nid     = cpu_to_le16(root_nid);
+	memcpy(sb.uuid, sbi.uuid, sizeof(sb.uuid));
 
 	buf = calloc(sb_blksize, 1);
 	if (!buf) {
@@ -305,6 +310,20 @@ static int erofs_mkfs_superblock_csum_set(void)
 	return 0;
 }
 
+static void erofs_mkfs_generate_uuid(void)
+{
+	char uuid_str[37] = "not available";
+
+#ifdef HAVE_LIBUUID
+	do {
+		uuid_generate(sbi.uuid);
+	} while (uuid_is_null(sbi.uuid));
+
+	uuid_unparse_lower(sbi.uuid, uuid_str);
+#endif
+	erofs_info("filesystem UUID: %s", uuid_str);
+}
+
 int main(int argc, char **argv)
 {
 	int err = 0;
@@ -376,6 +395,7 @@ int main(int argc, char **argv)
 		goto exit;
 	}
 
+	erofs_mkfs_generate_uuid();
 	erofs_inode_manager_init();
 
 	err = erofs_build_shared_xattrs_from_path(cfg.c_src_path);
-- 
2.17.1

