Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67960FA7C0
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Nov 2019 04:59:00 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47CW7j2vBBzF4PH
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Nov 2019 14:58:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1573617537;
	bh=jqL3l7lMI/OlMkhD8VVRnAkVHXXGQYtgpjxwhnUb2EE=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=bFinWpt4tlfr6MiB3xKNb/Ow5mEdDnS3uyVL6zheNFpPVC5mD61APZugJcmgTFEx4
	 E32KSz/tuSy+7o/lN9cMT/G6oZuh6JxPRuLdx65NOZVgLh58LlsJERSYK8Bgya1h8F
	 fjDkK2Tso5esNQEZhOHQDAT9qDn9WI4C3tnv7WecNIbTc/nlPD2ZoepPZNkiLHPpJc
	 RIYgQX2jlsehQXUb7tkYwjUazge3nG7ysetccU6wTU3v+k4UPqgfDVSfEOKbwth6S/
	 acxNSSaPzIJ/E1jjdnkZ2/inYqjMoLX6JGNJDs0yny5XMMZJvVeLZ0ULgxWX/vobOZ
	 SnP7sKZEkWUdQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.84; helo=sonic313-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="jHPQBFmW"; 
 dkim-atps=neutral
Received: from sonic313-21.consmr.mail.gq1.yahoo.com
 (sonic313-21.consmr.mail.gq1.yahoo.com [98.137.65.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47CW0g3RQ6zF6lB
 for <linux-erofs@lists.ozlabs.org>; Wed, 13 Nov 2019 14:52:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1573617164; bh=Z+RVYL0Q0vxGfQYo5PWDf+Wb4W4K4TREVszT2BQG33I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=jHPQBFmWB+aF47MsKU5j8snoQaaGp0SMdHDBonYFmQB+nK4dnqCVMq4CN5VFgdE2IVnUVjuEgouL6wUn5yd54rMzSZU9V2NIjjZKttEAfYOjn4Lw4e4zs9Is70eyOYm81k8JdbhHoQ+MC4Zvgfeg0vAfGorO53DKNUnWLWGfEEKGz1QaiHZniiQBmu3NxwPO1FGn06qM0a5QKvEGt8Ow0pW5h1ZILOGCI4luSTzc+vSvu/u0i+9lXYjN3m82s5hnAS6EwKu7lJBgPLTAObYSZY9gdZ1ac3KPywJ7kGKiwkHAevewHVDWUh0MkVG3XhD67Z+XrpwWGPU6NHWVgI+ycg==
X-YMail-OSG: 923HQs8VM1kx8ITB7IvgfY92ILFehmEIQfJ7deRPYWD194ituXmTo_kWbxwjjdh
 YZqsZ7JpldbfGyXIbbj13n7UKdf.0T3G7jQ7mLWLK5w20t4..3BHZcqKn2VZVsFAM5JtPYGngVBM
 Tr741X7h5BAp578AeTQxglD3CAf.ITVE1goF8oOGyfqlTaGL3MnCYK2c_z3rp3nYziklhZST1XjV
 _Pdr0FCxK6gkSq9G4BTWz4q.N8l3yQfHefD1KnxuqJIXAaeZmxZK4G5ZP5yi77yBkomuWagJc0rw
 tZ.0OQ85ZDvOBqrQliJGRzNj0BpvRF1KiI6hAUscaq0UmRXv72UN3brQL54VgMGNItDtwJpj1p0O
 3Hoz_djpXW5w_5o.8oB0_OF0RRX9zicRkEGSmuFPCEAUfKHpGQZiw.J8w4TJFR7NU6WfbkK4G.C.
 Be3LIT7wYP3fgAv0ujGfXVFxm2yuhCkgnei0xSKyaq96u5vgxwOS3SM6pR2AsSNhtr_CX5TOwEIp
 3fDauhnFmCFJU9Keon9rO7CEoTvqhsffBiEo8m5N1xaUPEn8SznAiv6dG69siWOabds.9b_9BVLo
 jGeXs2aoSqWvzqbKfwCdIHo8EliqbOkndR3aEQGXUGRpdfRU3_rFeZXilNXiD8x8J9TxpDIpNEoQ
 6OG5AICYpfHYcycquq8xo82pSVraDA7ykm3PNgRlr6YGME3nYmosWQckLNsMVL3oAb5II36vzbvf
 1N5rsSnvf9aZVY.d_GRpYr9SaDLf23lnqv9IePGm1ZCn8G4AtIpXaCtTjwZ7R_8etfdfa.Zk22_P
 UJBQ5Qyr7XDcqoc26LB7Z92Lr99p05kd_Lx2oK3gFml_9TZRxdGsdnVjYHCq33hNOgTIS0RhzKHr
 ThjzlDDgqf81rF1frZnFIhindKSn_vEvNhiEi9pEvVWTVHteIcLm.Wr41fHtjjb.EYZ8F6BOlpts
 o2ejtS2I5panWD8LWlYApiWrAbHpTihwc4cqnkz_J.syg6AzMnuLUh6JI_on9B__N3uxgoCG2RDX
 r2qVnzgJOzQ5TXI1wSNZbpurK42InpcptYfaJF1VEvBMiWi_fXgBaVgWC5HLkxEDA8WFCUu_5wH2
 aFlJegdUutaCOWdPSFG_qdqbSlvnVn9RfFpeEkx85YWsOwu8eb.Sd7EkfCYAm3w5BSKpKPIXCtMr
 Blv2XOSrbv8umDzUkaMGh7D7FcYqJC7Ho45.3HMp0Ma5A21p5IjfDE._cLIzkaph2Q_WLyoIPNsT
 1LuN3cUzIh0HSDeADXGY8S3LMxuw8nkNJLobgnuMSaNk3VcpVwJFWcpGPfgHzJ48idAU9OUf.Sjl
 3GbkjjaM6su0zRY.fbMpKGGSF6P_ysz5L2AJBLgx5Dnjovu_VTSCsJZYgJ8KXRutHhTaeh0L_ky4
 xF50ONE9gbQk1zw--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic313.consmr.mail.gq1.yahoo.com with HTTP; Wed, 13 Nov 2019 03:52:44 +0000
Received: by smtp417.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 0a574cf05c647185f8e365effd4cfc24; 
 Wed, 13 Nov 2019 03:52:43 +0000 (UTC)
To: Li Guifu <bluce.liguifu@huawei.com>, Chao Yu <yuchao0@huawei.com>,
 linux-erofs@lists.ozlabs.org
Subject: [PATCH v3] erofs-utils: support 128-bit filesystem UUID
Date: Wed, 13 Nov 2019 11:52:21 +0800
Message-Id: <20191113035221.30265-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191108080130.150123-1-gaoxiang25@huawei.com>
References: <20191108080130.150123-1-gaoxiang25@huawei.com>
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
changes since v2:
 - fix multilib false positive reported by erofs-utils-ci #83
   https://travis-ci.org/erofs/erofs-utils-ci/builds/609603134
 - test presence of pkg-config in advance. 

 configure.ac             | 33 +++++++++++++++++++++++++++++++++
 include/erofs/internal.h |  1 +
 mkfs/Makefile.am         |  3 ++-
 mkfs/main.c              | 20 ++++++++++++++++++++
 4 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index a93767f..9238d3e 100644
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
@@ -123,6 +136,19 @@ AC_CHECK_DECL(lseek64,[AC_DEFINE(HAVE_LSEEK64_PROTOTYPE, 1,
 # Checks for library functions.
 AC_CHECK_FUNCS([fallocate gettimeofday memset realpath strdup strerror strrchr strtoull])
 
+# Configure libuuid
+AS_IF([test "x$with_uuid" != "xno"], [
+  PKG_CHECK_MODULES([libuuid], [uuid])
+  # Paranoia: don't trust the result reported by pkgconfig before trying out
+  saved_LIBS="$LIBS"
+  LIBS="${libuuid_LIBS} $LIBS"
+  AC_TRY_LINK([
+#include <uuid.h>
+], [
+return uuid_generate();
+], [have_uuid=yes], [have_uuid=no])
+  LIBS="${saved_LIBS}"], [have_uuid=no])
+
 # Configure lz4
 test -z $LZ4_LIBS && LZ4_LIBS='-llz4'
 
@@ -169,6 +195,13 @@ if test "x$enable_lz4" = "xyes"; then
   CFLAGS=${saved_CPPFLAGS}
 fi
 
+AS_IF([test "x$have_uuid" = "xyes"],
+   [AC_DEFINE([HAVE_LIBUUID], 1, [Define to 1 if libuuid is found])],
+   [AS_IF([test "x$with_uuid" = "xyes"],
+      [AC_MSG_ERROR([uuid support requested but libuuid not found])]
+   )]
+)
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

