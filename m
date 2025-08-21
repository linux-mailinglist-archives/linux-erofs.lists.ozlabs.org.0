Return-Path: <linux-erofs+bounces-854-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A65CB2EDF7
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Aug 2025 08:13:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c6tKW4ZTtz2yCL;
	Thu, 21 Aug 2025 16:13:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755756783;
	cv=none; b=A5nimUGYUHDTp6giy9DmJ8Sgcb4PqJ/d4R/SeH25fuT2YHP7Fj0IDIhUxzbSC5vyw4Qk7bmyaWQk7GWd4koJBpUY1GrlRQAFMkZ4c3beuBtHaaGlyszAcDlrmitMfSOdLKKkO/N0lPOQBIrNOIc8tj5pmdiaXGTl5ENiydTAVFBlltrIwi9/GbsqleLE27hNx5b8zP58GMUJnIY5UMQrcgih2GkzKIoewJLQqdTOfd0fLSmRFHFDRcNFt2VFKbx5Qn92jGnzkgluuRf8Gm2k6vzihLYjRx7h/Bx0YD/Ex+m0uIvB6Eih8I1mo8OSzIcdQp5pHOVTCjYtLzVSpdICXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755756783; c=relaxed/relaxed;
	bh=STwuMqZYKC1pusPXpt9x7GX8MQkWsBbnt9VA2sNbTp4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YVZo61jacxtk29UDwhOkAw9+ylKE4YUcNrUabyAUXjcMIstlr9wQ/jtT7IAK1AvDda9fBJZPgt59oxgqBLtyGW78faKlIb3KWZ9sNdBMCk4pbnPutA4lkshI6p5XfpgtDwQELheuX15++V8iozogukJ3hZgJvF8+50tt1mwt8mSHt4voGZopd7HeIKBs70y8Rt6PNwI3PP4mWgTg9eCTiK+FeCa+pOE192VKR1QXqlXMF5zY4MY63Ktzy1OuEIYfB4yvCJpysSJgqPJTHsQrnvaIUpjiEBWzrkWJNO1LXJagOWLzi+4lZ9tPnBEZh7ar/TjaATl3e6xCY5Jvl7W8AA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MOFaX5+8; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MOFaX5+8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c6tKT27HNz2xpn
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 Aug 2025 16:13:00 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755756776; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=STwuMqZYKC1pusPXpt9x7GX8MQkWsBbnt9VA2sNbTp4=;
	b=MOFaX5+8w1Qqakhy7psGVPF5D7ERu0iBvRaahb9tqrlqxy0yctBR0C7+kjazWOIh0K1UbSyQNfS2agwC1ERtDVs7bwiKyGjFjgVD/QGB9TVIOev14uIDbnAqkUEwms6bw/xoJQlkdp+AtyrO3vNi5fiUtjmNjGBzxYHv1R35KW8=
Received: from localhost.localdomain(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WmEwvOz_1755756770 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 21 Aug 2025 14:12:54 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Oliver Yang <oliver.yang@linux.alibaba.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: add a dedicated mount helper
Date: Thu, 21 Aug 2025 14:12:05 +0800
Message-ID: <20250821061205.1695371-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Currently, kernel and FUSE mounts are supported for local images.
Support for remote images will be added later.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 Makefile.am              |   2 +-
 configure.ac             |   2 +
 include/erofs/err.h      |  10 ++
 include/erofs/internal.h |  11 --
 mount/Makefile.am        |  11 ++
 mount/main.c             | 287 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 311 insertions(+), 12 deletions(-)
 create mode 100644 mount/Makefile.am
 create mode 100644 mount/main.c

diff --git a/Makefile.am b/Makefile.am
index f8a967f..7cb93a6 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -6,4 +6,4 @@ SUBDIRS = man lib mkfs dump fsck
 if ENABLE_FUSE
 SUBDIRS += fuse
 endif
-SUBDIRS += contrib
+SUBDIRS += mount contrib
diff --git a/configure.ac b/configure.ac
index 1efb57a..c0174ce 100644
--- a/configure.ac
+++ b/configure.ac
@@ -217,6 +217,7 @@ AC_CHECK_HEADERS(m4_flatten([
 	linux/aufs_type.h
 	linux/falloc.h
 	linux/fs.h
+	linux/loop.h
 	linux/types.h
 	linux/xattr.h
 	limits.h
@@ -799,5 +800,6 @@ AC_CONFIG_FILES([Makefile
 		 dump/Makefile
 		 fuse/Makefile
 		 fsck/Makefile
+		 mount/Makefile
 		 contrib/Makefile])
 AC_OUTPUT
diff --git a/include/erofs/err.h b/include/erofs/err.h
index 2ae9e21..ff488dd 100644
--- a/include/erofs/err.h
+++ b/include/erofs/err.h
@@ -13,6 +13,16 @@ extern "C"
 #endif
 
 #include <errno.h>
+#include <string.h>
+#include <stdio.h>
+
+static inline const char *erofs_strerror(int err)
+{
+	static char msg[256];
+
+	sprintf(msg, "[Error %d] %s", -err, strerror(-err));
+	return msg;
+}
 
 #define MAX_ERRNO (4095)
 #define IS_ERR_VALUE(x)                                                        \
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index ea58584..9a82e06 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -362,17 +362,6 @@ static inline bool is_dot_dotdot(const char *name)
 	return name[1] == '\0' || (name[1] == '.' && name[2] == '\0');
 }
 
-#include <stdio.h>
-#include <string.h>
-
-static inline const char *erofs_strerror(int err)
-{
-	static char msg[256];
-
-	sprintf(msg, "[Error %d] %s", -err, strerror(-err));
-	return msg;
-}
-
 enum {
 	BH_Meta,
 	BH_Mapped,
diff --git a/mount/Makefile.am b/mount/Makefile.am
new file mode 100644
index 0000000..d901c20
--- /dev/null
+++ b/mount/Makefile.am
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Makefile.am
+
+AUTOMAKE_OPTIONS = foreign
+sbin_PROGRAMS    = mount.erofs
+AM_CPPFLAGS = ${libuuid_CFLAGS}
+mount_erofs_SOURCES = main.c
+mount_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
+mount_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
+	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} \
+	${libzstd_LIBS} ${libqpl_LIBS} ${libxxhash_LIBS}
diff --git a/mount/main.c b/mount/main.c
new file mode 100644
index 0000000..096602a
--- /dev/null
+++ b/mount/main.c
@@ -0,0 +1,287 @@
+// SPDX-License-Identifier: GPL-2.0+
+#define _GNU_SOURCE
+#include <getopt.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mount.h>
+#include <unistd.h>
+#include "erofs/config.h"
+#include "erofs/print.h"
+#include "erofs/err.h"
+#ifdef HAVE_LINUX_LOOP_H
+#include <linux/loop.h>
+#else
+#define LOOP_CTL_GET_FREE	0x4C82
+#define LOOP_SET_FD		0x4C00
+#define LOOP_SET_STATUS		0x4C02
+enum {
+	LO_FLAGS_AUTOCLEAR = 4,
+};
+struct loop_info {
+	char	pad[44];
+        int	lo_flags;
+	char    pad1[120];
+};
+#endif
+
+enum erofs_backend_drv {
+	EROFSAUTO,
+	EROFSLOCAL,
+	EROFSFUSE,
+};
+
+static struct erofsmount_cfg {
+	char *device;
+	char *mountpoint;
+	char *options;
+	char *full_options;		/* used for erofsfuse */
+	char *fstype;
+	long flags;
+	enum erofs_backend_drv backend;
+} mountcfg = {
+	.full_options = "ro",
+	.flags = MS_RDONLY,		/* default mountflags */
+	.fstype = "erofs",
+};
+
+static long erofsmount_parse_flagopts(char *s, long flags, char **more)
+{
+	static const struct {
+		char *name;
+		long flags;
+	} opts[] = {
+		{"defaults", 0}, {"quiet", 0}, // NOPs
+		{"user", 0}, {"nouser", 0}, // checked in fstab, ignored in -o
+		{"ro", MS_RDONLY}, {"rw", ~MS_RDONLY},
+		{"nosuid", MS_NOSUID}, {"suid", ~MS_NOSUID},
+		{"nodev", MS_NODEV}, {"dev", ~MS_NODEV},
+		{"noexec", MS_NOEXEC}, {"exec", ~MS_NOEXEC},
+		{"sync", MS_SYNCHRONOUS}, {"async", ~MS_SYNCHRONOUS},
+		{"noatime", MS_NOATIME}, {"atime", ~MS_NOATIME},
+		{"norelatime", ~MS_RELATIME}, {"relatime", MS_RELATIME},
+		{"nodiratime", MS_NODIRATIME}, {"diratime", ~MS_NODIRATIME},
+		{"loud", ~MS_SILENT},
+		{"remount", MS_REMOUNT}, {"move", MS_MOVE},
+		// mand dirsync rec iversion strictatime
+	};
+
+	for (;;) {
+		char *comma;
+		int i;
+
+		comma = strchr(s, ',');
+		if (comma)
+			*comma = '\0';
+		for (i = 0; i < ARRAY_SIZE(opts); ++i) {
+			if (!strcasecmp(s, opts[i].name)) {
+				if (opts[i].flags < 0)
+					flags &= opts[i].flags;
+				else
+					flags |= opts[i].flags;
+				break;
+			}
+		}
+
+		if (more && i >= ARRAY_SIZE(opts)) {
+			int sl = strlen(s);
+			char *new = *more;
+
+			i = new ? strlen(new) : 0;
+			new = realloc(new, i + strlen(s) + 2);
+			if (!new)
+				return -ENOMEM;
+			if (i) new[i++] = ',';
+			memcpy(new + i, s, sl);
+			new[i + sl] = '\0';
+			*more = new;
+		}
+
+		if (!comma)
+			break;
+		*comma = ',';
+		s = comma + 1;
+	}
+	return flags;
+}
+
+static int erofsmount_parse_options(int argc, char **argv)
+{
+	static const struct option long_options[] = {
+		{"help", no_argument, 0, 'h'},
+		{0, 0, 0, 0},
+	};
+	char *dot;
+	int opt;
+
+	while ((opt = getopt_long(argc, argv, "Nfno:st:v",
+				  long_options, NULL)) != -1) {
+		switch (opt) {
+		case 'o':
+			mountcfg.full_options = optarg;
+			mountcfg.flags =
+				erofsmount_parse_flagopts(optarg, mountcfg.flags,
+							  &mountcfg.options);
+			break;
+		case 't':
+			dot = strchr(optarg, '.');
+			if (dot) {
+				if (!strcmp(dot + 1, "fuse")) {
+					mountcfg.backend = EROFSFUSE;
+				} else if (!strcmp(dot + 1, "local")) {
+					mountcfg.backend = EROFSLOCAL;
+				} else {
+					erofs_err("invalid filesystem subtype `%s`", dot + 1);
+					return -EINVAL;
+				}
+				*dot = '\0';
+			}
+			mountcfg.fstype = optarg;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	if (optind >= argc) {
+		erofs_err("missing argument: DEVICE");
+		return -EINVAL;
+	}
+
+	mountcfg.device = strdup(argv[optind++]);
+	if (!mountcfg.device)
+		return -ENOMEM;
+
+	if (optind >= argc) {
+		erofs_err("missing argument: MOUNTPOINT");
+		return -EINVAL;
+	}
+
+	mountcfg.mountpoint = strdup(argv[optind++]);
+	if (!mountcfg.mountpoint)
+		return -ENOMEM;
+
+	if (optind < argc) {
+		erofs_err("unexpected argument: %s\n", argv[optind]);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int erofsmount_fuse(const char *source, const char *mountpoint,
+			   const char *fstype, const char *options)
+{
+	char *command;
+	int err;
+
+	if (strcmp(fstype, "erofs")) {
+		fprintf(stderr, "unsupported filesystem type `%s`\n",
+			mountcfg.fstype);
+		return -ENODEV;
+	}
+
+	err = asprintf(&command, "erofsfuse -o%s %s %s", options,
+		       source, mountpoint);
+	if (err < 0)
+		return -ENOMEM;
+
+	/* execvp() doesn't work for external mount helpers here */
+	err = execl("/bin/sh", "/bin/sh", "-c", command, NULL);
+	if (err < 0) {
+		perror("failed to execute /bin/sh");
+		return -errno;
+	}
+	return 0;
+}
+
+#define EROFSMOUNT_LOOPDEV_RETRIES	3
+
+int erofsmount_loopmount(const char *source, const char *mountpoint,
+			 const char *fstype, int flags,
+			 const char *options)
+{
+	int fd, dfd, num;
+	struct loop_info li = {};
+	bool ro = flags & MS_RDONLY;
+	char device[32];
+
+	fd = open("/dev/loop-control", O_RDWR | O_CLOEXEC);
+	if (fd < 0)
+		return -errno;
+
+	num = ioctl(fd, LOOP_CTL_GET_FREE);
+	if (num < 0)
+		return -errno;
+	close(fd);
+
+	snprintf(device, sizeof(device), "/dev/loop%d", num);
+	for (num = 0; num < EROFSMOUNT_LOOPDEV_RETRIES; ++num) {
+		fd = open(device, (ro ? O_RDONLY : O_RDWR) | O_CLOEXEC);
+		if (fd >= 0)
+			break;
+		usleep(50000);
+	}
+	if (fd < 0)
+		return -errno;
+
+	dfd = open(source, (ro ? O_RDONLY : O_RDWR));
+	if (dfd < 0)
+		goto out_err;
+
+	num = ioctl(fd, LOOP_SET_FD, dfd);
+	if (num < 0) {
+		close(dfd);
+		goto out_err;
+	}
+	close(dfd);
+
+	li.lo_flags = LO_FLAGS_AUTOCLEAR;
+	num = ioctl(fd, LOOP_SET_STATUS, &li);
+	if (num < 0)
+		goto out_err;
+	num = mount(device, mountpoint, fstype, flags, options);
+	if (num < 0)
+		goto out_err;
+	close(fd);
+	return 0;
+out_err:
+	close(fd);
+	return -errno;
+}
+
+int main(int argc, char *argv[])
+{
+	int err;
+
+	erofs_init_configure();
+	err = erofsmount_parse_options(argc, argv);
+	if (err) {
+		if (err == -EINVAL)
+			fprintf(stderr, "Try '%s --help' for more information.\n", argv[0]);
+		return EXIT_FAILURE;
+	}
+
+	if (mountcfg.backend == EROFSFUSE) {
+		err = erofsmount_fuse(mountcfg.device, mountcfg.mountpoint,
+				      mountcfg.fstype, mountcfg.full_options);
+		goto exit;
+	}
+
+	err = mount(mountcfg.device, mountcfg.mountpoint, mountcfg.fstype,
+		    mountcfg.flags, mountcfg.options);
+	if (err < 0)
+		err = -errno;
+
+	if ((err == -ENODEV || err == -EPERM) && mountcfg.backend == EROFSAUTO)
+		err = erofsmount_fuse(mountcfg.device, mountcfg.mountpoint,
+				      mountcfg.fstype, mountcfg.full_options);
+	else if (err == -ENOTBLK)
+		err = erofsmount_loopmount(mountcfg.device, mountcfg.mountpoint,
+					   mountcfg.fstype, mountcfg.flags,
+					   mountcfg.options);
+exit:
+	if (err < 0)
+		fprintf(stderr, "Failed to mount %s: %s\n",
+			mountcfg.fstype, erofs_strerror(err));
+	return err ? EXIT_FAILURE : EXIT_SUCCESS;
+}
-- 
2.43.0


