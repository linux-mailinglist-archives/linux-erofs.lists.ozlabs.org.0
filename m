Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 419F374653E
	for <lists+linux-erofs@lfdr.de>; Mon,  3 Jul 2023 23:59:22 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=pyD/ZQNn;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qw0FM6Gv8z30ht
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Jul 2023 07:59:19 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=pyD/ZQNn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com; envelope-from=nolange79@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qw0FD6VG3z30fV
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Jul 2023 07:59:11 +1000 (AEST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-992ca792065so505777766b.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 03 Jul 2023 14:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688421542; x=1691013542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NwT4ykH2V05v2M+Ye4qRNdfQXjfQ5dmmXYkSdOVTdgM=;
        b=pyD/ZQNnfImFBAxzgeupEDQFdwGVAvGDdjUxiNsTJkgcHMvrL1HHf08d6dJokVGna4
         ZgTNyGeSqA8zGrzUKr0W6jXDxcoSL4QE/clJegJl3KWT0iqoIIgI5goHGP3PSArBomrR
         tmCnapJqdyrUel7lskCFXjJzVTm8dda8BUrned7q2COFI580vUqOU2Gofwq2Ph/CBsl7
         t7j3X8m7/K2pmrz8zKoUC6hLH6WTjXaGC9MWsOSRdowt15Tcc3vor+NxX/RGFDHcu0+3
         nCEnTnNs27cxBKykFl37JJB6br5tKPtkIf9Hgu3sC+sC64ZfuhEkGcGz/g6YKgNyapEV
         5uvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688421542; x=1691013542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NwT4ykH2V05v2M+Ye4qRNdfQXjfQ5dmmXYkSdOVTdgM=;
        b=NKW1MwLK7nGgn5wd7P6dZCFdVzcSMlpO226qk33056jjb93PbkXiKaO5AMyWpUJU6G
         qzranax1PY6A2RUgdb4fqdP4cj07cqxjnJ3g/evdsEzGnb7q1z1jtU8fhUfvB8nqj3Dt
         SgnhF2al3ro2zWPXEYKzx1BC6zhU0LewPCaNQrzAgTLTY4OyEpTQdXcBxDn5pArNH3Wj
         SW2f5u+ISLe8ClxHXDNinY1kNRbnqZfBF2o4M0djJxx3PGGqxE9R7uVnO3na49RWgr13
         Q0IufoKWbM3LtXobZ6/aKj0v+2yBf2kw3EX2ttwYkIzsPz8EX9KBPNN6uYBRcpqgLta5
         f3dw==
X-Gm-Message-State: ABy/qLZVIjuCH3VTKpU0+15u30LYMkBLKY7pkDF/IspL0feMesC5iB3x
	/WfDkYrzkLcGTW0OSC2JWrgtNjQfE1k=
X-Google-Smtp-Source: APBJJlGr4EkOiIsMmgXD11bqmvLYy+GyZd7Jj41kjIuz5lRpHKUdJiTGcKHpKr3yJaSx9NE7R7BDZQ==
X-Received: by 2002:a17:906:29ce:b0:987:6372:c31f with SMTP id y14-20020a17090629ce00b009876372c31fmr8473519eje.37.1688421541499;
        Mon, 03 Jul 2023 14:59:01 -0700 (PDT)
Received: from debian-noppl.. (84-113-221-34.cable.dynamic.surfer.at. [84.113.221.34])
        by smtp.gmail.com with ESMTPSA id h22-20020a170906829600b009931a3adf64sm4123908ejx.17.2023.07.03.14.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 14:59:01 -0700 (PDT)
From: Norbert Lange <nolange79@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: Provide identical functionality without libuuid
Date: Mon,  3 Jul 2023 23:58:03 +0200
Message-Id: <20230703215803.4476-1-nolange79@gmail.com>
X-Mailer: git-send-email 2.39.2
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
Cc: Norbert Lange <nolange79@gmail.com>, Huang Jianan <huangjianan@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The motivation is to have standalone (statically linked) erofs binaries
for simple initrd images, that are nevertheless able to (re)create
erofs images with a given UUID.

For this reason a few of libuuid functions have implementations added
directly in erofs-utils.
A header liberofs_uuid.h provides the new functions, which are
always available. A further sideeffect is that code can be simplified
which calls into this functionality.

The uuid_unparse function replacement is always a private
implementation and split into its own file, this further restricts
the (optional) dependency on libuuid only to the erofs-mkfs tool.

Signed-off-by: Norbert Lange <nolange79@gmail.com>
---
/* v2 */
- Norbert Lange <nolange79@gmail.com>
  - Change to useing unsigned int
  - Some small formatting fixes
  - Remove some now useless "not available" inititalisations of
    uuid strings
---
---
 dump/Makefile.am    |   2 +-
 dump/main.c         |  10 ++--
 fsck/Makefile.am    |   2 +-
 lib/Makefile.am     |   4 +-
 lib/liberofs_uuid.h |   9 ++++
 lib/uuid.c          | 108 ++++++++++++++++++++++++++++++++++++++++++++
 lib/uuid_unparse.c  |  21 +++++++++
 mkfs/Makefile.am    |   6 +--
 mkfs/main.c         |  23 ++--------
 9 files changed, 153 insertions(+), 32 deletions(-)
 create mode 100644 lib/liberofs_uuid.h
 create mode 100644 lib/uuid.c
 create mode 100644 lib/uuid_unparse.c

diff --git a/dump/Makefile.am b/dump/Makefile.am
index c2bef6d..90227a5 100644
--- a/dump/Makefile.am
+++ b/dump/Makefile.am
@@ -7,4 +7,4 @@ AM_CPPFLAGS = ${libuuid_CFLAGS}
 dump_erofs_SOURCES = main.c
 dump_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
 dump_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
-	${libuuid_LIBS} ${liblz4_LIBS} ${liblzma_LIBS}
+	${liblz4_LIBS} ${liblzma_LIBS}
diff --git a/dump/main.c b/dump/main.c
index bc4e028..6ba658c 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -17,10 +17,8 @@
 #include "erofs/compress.h"
 #include "erofs/fragments.h"
 #include "../lib/liberofs_private.h"
+#include "../lib/liberofs_uuid.h"
 
-#ifdef HAVE_LIBUUID
-#include <uuid.h>
-#endif
 
 struct erofsdump_cfg {
 	unsigned int totalshow;
@@ -592,7 +590,7 @@ static void erofsdump_print_statistic(void)
 static void erofsdump_show_superblock(void)
 {
 	time_t time = sbi.build_time;
-	char uuid_str[37] = "not available";
+	char uuid_str[37];
 	int i = 0;
 
 	fprintf(stdout, "Filesystem magic number:                      0x%04X\n",
@@ -620,9 +618,7 @@ static void erofsdump_show_superblock(void)
 		if (feat & feature_lists[i].flag)
 			fprintf(stdout, "%s ", feature_lists[i].name);
 	}
-#ifdef HAVE_LIBUUID
-	uuid_unparse_lower(sbi.uuid, uuid_str);
-#endif
+	erofs_uuid_unparse_lower(sbi.uuid, uuid_str);
 	fprintf(stdout, "\nFilesystem UUID:                              %s\n",
 			uuid_str);
 }
diff --git a/fsck/Makefile.am b/fsck/Makefile.am
index e6a1fb6..4176d86 100644
--- a/fsck/Makefile.am
+++ b/fsck/Makefile.am
@@ -7,4 +7,4 @@ AM_CPPFLAGS = ${libuuid_CFLAGS}
 fsck_erofs_SOURCES = main.c
 fsck_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
 fsck_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
-	${libuuid_LIBS} ${liblz4_LIBS} ${liblzma_LIBS}
+	${liblz4_LIBS} ${liblzma_LIBS}
diff --git a/lib/Makefile.am b/lib/Makefile.am
index faa7311..e243c1c 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -29,9 +29,9 @@ noinst_HEADERS += compressor.h
 liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
 		      namei.c data.c compress.c compressor.c zmap.c decompress.c \
 		      compress_hints.c hashmap.c sha256.c blobchunk.c dir.c \
-		      fragments.c rb_tree.c dedupe.c
+		      fragments.c rb_tree.c dedupe.c uuid_unparse.c uuid.c
 
-liberofs_la_CFLAGS = -Wall -I$(top_srcdir)/include
+liberofs_la_CFLAGS = -Wall ${libuuid_CFLAGS} -I$(top_srcdir)/include
 if ENABLE_LZ4
 liberofs_la_CFLAGS += ${LZ4_CFLAGS}
 liberofs_la_SOURCES += compressor_lz4.c
diff --git a/lib/liberofs_uuid.h b/lib/liberofs_uuid.h
new file mode 100644
index 0000000..d156699
--- /dev/null
+++ b/lib/liberofs_uuid.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
+#ifndef __EROFS_LIB_UUID_H
+#define __EROFS_LIB_UUID_H
+
+void erofs_uuid_generate(unsigned char *out);
+void erofs_uuid_unparse_lower(const unsigned char *buf, char *out);
+int erofs_uuid_parse(const char *in, unsigned char *uu);
+
+#endif
\ No newline at end of file
diff --git a/lib/uuid.c b/lib/uuid.c
new file mode 100644
index 0000000..1d2409c
--- /dev/null
+++ b/lib/uuid.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
+/*
+ * Copyright (C) 2023 Norbert Lange <nolange79@gmail.com>
+ */
+
+#include <string.h>
+#include <errno.h>
+
+#include "erofs/config.h"
+#include "erofs/defs.h"
+#include "liberofs_uuid.h"
+
+#ifdef HAVE_LIBUUID
+#include <uuid.h>
+#else
+
+#include <stdlib.h>
+#include <sys/random.h>
+
+/* Flags to be used, will be modified if kernel does not support them */
+static unsigned int erofs_grnd_flag = 
+#ifdef GRND_INSECURE
+	GRND_INSECURE;
+#else
+	0x0004;
+#endif
+
+static int s_getrandom(void *out, unsigned size, bool insecure)
+{
+	unsigned int kflags = erofs_grnd_flag;
+	unsigned int flags = insecure ? kflags : 0;
+
+	for (;;)
+	{
+		ssize_t r = getrandom(out, size, flags);
+		int err;
+
+		if (r == size)
+			break;
+		err = errno;
+		if (err != EINTR) {
+			if (err == EINVAL && kflags) {
+				// Kernel likely does not support GRND_INSECURE
+				erofs_grnd_flag = 0;
+				kflags = 0;
+				continue;
+			}
+			return -err;
+		}
+	}
+	return 0;
+}
+#endif
+
+void erofs_uuid_generate(unsigned char *out)
+{
+#ifdef HAVE_LIBUUID
+	uuid_t new_uuid;
+
+	do {
+		uuid_generate(new_uuid);
+	} while (uuid_is_null(new_uuid));
+#else
+	unsigned char new_uuid[16];
+	int res __maybe_unused;
+
+	res = s_getrandom(new_uuid, sizeof(new_uuid), true);
+	BUG_ON(res != 0);
+
+	// UID type + version bits
+	new_uuid[0] = (new_uuid[4 + 2] & 0x0f) | 0x40;
+	new_uuid[1] = (new_uuid[4 + 2 + 2] & 0x3f) | 0x80;
+#endif
+	memcpy(out, new_uuid, sizeof(new_uuid));
+}
+
+int erofs_uuid_parse(const char *in, unsigned char *uu) {
+#ifdef HAVE_LIBUUID
+	return uuid_parse((char *)in, uu);
+#else
+	unsigned char new_uuid[16];
+	unsigned int hypens = ((1U << 3) | (1U << 5) | (1U << 7) | (1U << 9));
+	int i;
+
+	for (i = 0; i < sizeof(new_uuid); hypens >>= 1, i++)
+	{
+		char c[] = { in[0], in[1], '\0' };
+		char* endptr = c;
+		unsigned long val = strtoul(c, &endptr, 16);
+
+		if (endptr - c != 2)
+			return -EINVAL;
+
+		in += 2;
+
+		if ((hypens & 1U) != 0) {
+			if (*in++ != '-')
+				return -EINVAL;
+		}
+		new_uuid[i] = (unsigned char)val;
+	}
+
+	if (*in != '\0')
+		return -EINVAL;
+	memcpy(uu, new_uuid, sizeof(new_uuid));
+	return 0;
+#endif
+}
\ No newline at end of file
diff --git a/lib/uuid_unparse.c b/lib/uuid_unparse.c
new file mode 100644
index 0000000..3255c4b
--- /dev/null
+++ b/lib/uuid_unparse.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
+/*
+ * Copyright (C) 2023 Norbert Lange <nolange79@gmail.com>
+ */
+
+#include <stdio.h>
+
+#include "erofs/config.h"
+#include "liberofs_uuid.h"
+
+void erofs_uuid_unparse_lower(const unsigned char *buf, char *out) {
+	sprintf(out, "%04x%04x-%04x-%04x-%04x-%04x%04x%04x",
+			(buf[0] << 8) | buf[1],
+			(buf[2] << 8) | buf[3],
+			(buf[4] << 8) | buf[5],
+			(buf[6] << 8) | buf[7],
+			(buf[8] << 8) | buf[9],
+			(buf[10] << 8) | buf[11],
+			(buf[12] << 8) | buf[13],
+			(buf[14] << 8) | buf[15]);
+}
diff --git a/mkfs/Makefile.am b/mkfs/Makefile.am
index 709d9bf..a08dc53 100644
--- a/mkfs/Makefile.am
+++ b/mkfs/Makefile.am
@@ -2,8 +2,8 @@
 
 AUTOMAKE_OPTIONS = foreign
 bin_PROGRAMS     = mkfs.erofs
-AM_CPPFLAGS = ${libuuid_CFLAGS} ${libselinux_CFLAGS}
+AM_CPPFLAGS = ${libselinux_CFLAGS}
 mkfs_erofs_SOURCES = main.c
 mkfs_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
-mkfs_erofs_LDADD = ${libuuid_LIBS} $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
-	${liblz4_LIBS} ${liblzma_LIBS}
+mkfs_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
+	${libuuid_LIBS} ${liblz4_LIBS} ${liblzma_LIBS}
diff --git a/mkfs/main.c b/mkfs/main.c
index 94f51df..18aed50 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -26,10 +26,7 @@
 #include "erofs/blobchunk.h"
 #include "erofs/fragments.h"
 #include "../lib/liberofs_private.h"
-
-#ifdef HAVE_LIBUUID
-#include <uuid.h>
-#endif
+#include "../lib/liberofs_uuid.h"
 
 #define EROFS_SUPER_END (EROFS_SUPER_OFFSET + sizeof(struct erofs_super_block))
 
@@ -90,9 +87,7 @@ static void usage(void)
 	      " -EX[,...]             X=extended options\n"
 	      " -L volume-label       set the volume label (maximum 16)\n"
 	      " -T#                   set a fixed UNIX timestamp # to all files\n"
-#ifdef HAVE_LIBUUID
 	      " -UX                   use a given filesystem UUID\n"
-#endif
 	      " --all-root            make all files owned by root\n"
 	      " --blobdev=X           specify an extra device X to store chunked data\n"
 	      " --chunksize=#         generate chunk-based files with #-byte chunks\n"
@@ -328,14 +323,12 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			}
 			cfg.c_timeinherit = TIMESTAMP_FIXED;
 			break;
-#ifdef HAVE_LIBUUID
 		case 'U':
-			if (uuid_parse(optarg, sbi.uuid)) {
+			if (erofs_uuid_parse(optarg, sbi.uuid)) {
 				erofs_err("invalid UUID %s", optarg);
 				return -EINVAL;
 			}
 			break;
-#endif
 		case 2:
 			opt = erofs_parse_exclude_path(optarg, false);
 			if (opt) {
@@ -626,11 +619,7 @@ static void erofs_mkfs_default_options(void)
 			     EROFS_FEATURE_COMPAT_MTIME;
 
 	/* generate a default uuid first */
-#ifdef HAVE_LIBUUID
-	do {
-		uuid_generate(sbi.uuid);
-	} while (uuid_is_null(sbi.uuid));
-#endif
+	erofs_uuid_generate(sbi.uuid);
 }
 
 /* https://reproducible-builds.org/specs/source-date-epoch/ for more details */
@@ -675,7 +664,7 @@ int main(int argc, char **argv)
 	struct stat st;
 	erofs_blk_t nblocks;
 	struct timeval t;
-	char uuid_str[37] = "not available";
+	char uuid_str[37];
 
 	erofs_init_configure();
 	erofs_mkfs_default_options();
@@ -803,9 +792,7 @@ int main(int argc, char **argv)
 			  erofs_strerror(err));
 		goto exit;
 	}
-#ifdef HAVE_LIBUUID
-	uuid_unparse_lower(sbi.uuid, uuid_str);
-#endif
+	erofs_uuid_unparse_lower(sbi.uuid, uuid_str);
 	erofs_info("filesystem UUID: %s", uuid_str);
 
 	erofs_inode_manager_init();
-- 
2.39.2

