Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC2BF2856
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Nov 2019 08:48:11 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 477wVt2c64zDqfK
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Nov 2019 18:48:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 477wVW57H5zDqLL
 for <linux-erofs@lists.ozlabs.org>; Thu,  7 Nov 2019 18:47:44 +1100 (AEDT)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id CDB32B4C1805BE8FED31
 for <linux-erofs@lists.ozlabs.org>; Thu,  7 Nov 2019 12:01:04 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 7 Nov 2019
 12:00:55 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Li Guifu <bluce.liguifu@huawei.com>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] erofs-utils: support 128-bit filesystem UUID
Date: Thu, 7 Nov 2019 12:03:27 +0800
Message-ID: <20191107040327.93369-2-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191107040327.93369-1-gaoxiang25@huawei.com>
References: <20191107040327.93369-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
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
Cc: Miao Xie <miaoxie@huawei.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Introduce filesystem UUID and a new feature_compat
flag to indicate uuid field is available.

Cc: Chao Yu <yuchao0@huawei.com>
Cc: Li Guifu <bluce.liguifu@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 configure.ac             | 18 ++++++++++++++++++
 include/erofs/internal.h |  1 +
 include/erofs_fs.h       |  1 +
 mkfs/Makefile.am         |  3 ++-
 mkfs/main.c              | 18 ++++++++++++++++++
 5 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index a93767f61578..c4d3af6a3a43 100644
--- a/configure.ac
+++ b/configure.ac
@@ -54,6 +54,10 @@ AC_ARG_ENABLE(lz4,
    [AS_HELP_STRING([--disable-lz4], [disable LZ4 compression support @<:@default=enabled@:>@])],
    [enable_lz4="$enableval"], [enable_lz4="yes"])
 
+AC_ARG_WITH(uuid,
+   [AS_HELP_STRING([--without-uuid],
+      [Ignore presence of libuuid and disable uuid support @<:@default=enabled@:>@])])
+
 # Checks for libraries.
 # Use customized LZ4 library path when specified.
 AC_ARG_WITH(lz4-incdir,
@@ -172,6 +176,20 @@ fi
 AM_CONDITIONAL([ENABLE_LZ4], [test "x${have_lz4}" = "xyes"])
 AM_CONDITIONAL([ENABLE_LZ4HC], [test "x${have_lz4hc}" = "xyes"])
 
+# Configure libuuid
+AS_IF([test "x$with_uuid" != "xno"],
+   [PKG_CHECK_MODULES([libuuid], [uuid],
+      [have_uuid=yes], [have_uuid=no])],
+   [have_uuid=no]
+)
+
+AS_IF([test "x$have_uuid" = "xyes"],
+   [AC_DEFINE([HAVE_LIBUUID], 1, [Define to 1 if libuuid is found])],
+   [AS_IF([test "x$with_uuid" = "xyes"],
+      [AC_MSG_ERROR([uuid support requested but libuuid not found])]
+   )]
+)
+
 AC_CONFIG_FILES([Makefile
 		 man/Makefile
 		 lib/Makefile
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 9e2bb9ce33b6..e13adda12257 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -56,6 +56,7 @@ struct erofs_sb_info {
 	u32 feature_incompat;
 	u64 build_time;
 	u32 build_time_nsec;
+	u8 uuid[16];
 };
 
 /* global sbi */
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index bcc4f0c630ad..66844dc627f5 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -14,6 +14,7 @@
 #define EROFS_SUPER_OFFSET      1024
 
 #define EROFS_FEATURE_COMPAT_SB_CHKSUM		0x00000001
+#define EROFS_FEATURE_COMPAT_SB_UUID		0x00000002
 
 /*
  * Any bits that aren't in EROFS_ALL_FEATURE_INCOMPAT should
diff --git a/mkfs/Makefile.am b/mkfs/Makefile.am
index 257f86422bae..9ce06d654d3d 100644
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
index 9187c43ed671..e42b10f754b6 100644
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
@@ -305,6 +310,18 @@ static int erofs_mkfs_superblock_csum_set(void)
 	return 0;
 }
 
+static void erofs_mkfs_generate_uuid(void)
+{
+	char uuid_str[37] = "not available";
+
+#ifdef HAVE_LIBUUID
+	uuid_generate(sbi.uuid);
+	uuid_unparse_lower(sbi.uuid, uuid_str);
+	sbi.feature_compat |= EROFS_FEATURE_COMPAT_SB_UUID;
+#endif
+	erofs_info("filesystem UUID: %s", uuid_str);
+}
+
 int main(int argc, char **argv)
 {
 	int err = 0;
@@ -376,6 +393,7 @@ int main(int argc, char **argv)
 		goto exit;
 	}
 
+	erofs_mkfs_generate_uuid();
 	erofs_inode_manager_init();
 
 	err = erofs_build_shared_xattrs_from_path(cfg.c_src_path);
-- 
2.17.1

