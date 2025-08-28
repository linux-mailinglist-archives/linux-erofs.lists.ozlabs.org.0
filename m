Return-Path: <linux-erofs+bounces-933-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7989DB3974B
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Aug 2025 10:43:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cCFKW0TdRz2xjP;
	Thu, 28 Aug 2025 18:43:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756370590;
	cv=none; b=d3VRtRZLaKls1HojQbtSducE5pSUM6M/rnmLzWsHtVXWb1GM4/SAHqpkNTocOX0MU1GxHBnpbuKflIXY6GD2HNZmS1bzx7cntNUlNgOa+Q0AOew+eFLDidNqlSXJZ/8RwkTyQQeMRmAQodskAVaDDr3qKyr0CX4y1lv4WvE7Td+9iXAMebk1oVqshAhz9b5HeCVb096FFjffrY1+G40Vu0HgZrz6q/YabjCF0N32pKSr18X2FoC69k8AaxbnJa586Sq70OjsgVsmSDydxAtA1+3bwujpGoNHf1/wgFgOYJ0W+32zeOAd4BkX7ygjYKhdkhkULGDfnBu1T6cdVoLeHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756370590; c=relaxed/relaxed;
	bh=I8PVasy+rD3w7MqzmgOZdPJZlngRgz0nAbnfes6N/Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SGC7XcaBzitJ3zvgci4P71HePKohPhKWDH8ZOg3kFCFIzeNL/OJyUxNXjTbdNpFnh5cNFVHl0envoNraVBdnCwQV8n+FZnA937hGDyr6t4wtwcwlj3I1bZUVsunu59BPa9JhAs5yj5Aoo8yvG+ny/Lt4/9xDp3T5L9shk8SWF4EvGGzktXXFPWsUf9c+hKgeD7Pl2Jf5gpL1v1f9Wcaj5PJ+nym459nN6wljD0b5ftWwZr7LpPVpi5DDyQIKNNJmPk9Ug85P/xT5d//t9r8q5IS9s84HzyR4Vs0Nc19O37Xxxcl5Y6qqFQwNgMndY5WIOyiyOidv8Sp4mLlaGHdBpg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YNpHQg6X; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YNpHQg6X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cCFKT0QVpz2xMY
	for <linux-erofs@lists.ozlabs.org>; Thu, 28 Aug 2025 18:43:07 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756370583; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=I8PVasy+rD3w7MqzmgOZdPJZlngRgz0nAbnfes6N/Ow=;
	b=YNpHQg6XPKB9AyNKbGxR3GM5Lkd9r0SsCCx6zvVVwhFzOKHz525MGrHBEYjpdKDCCVcxRVhfTMVjWbZuA7czfPc0qev0N9LOopsVti46poIvBWulOVxwJVXkj6LZWwIEm+WeSF1ff74hXe7aLTvDsm6YXhs+s/IDP7WCmNLxgcA=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WmmQTV6_1756370575 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 28 Aug 2025 16:43:01 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: mount: add unmount support
Date: Thu, 28 Aug 2025 16:42:50 +0800
Message-ID: <20250828084250.3870313-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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

umount(8) may only unmount the filesystem without disconnecting
the NBD device.

Add `mount.erofs -u <DIR|BDEV>` to manually disconnect devices for
maintenance.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/backends/nbd.c |  10 ++++
 lib/liberofs_nbd.h |   3 +
 mount/main.c       | 134 ++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 138 insertions(+), 9 deletions(-)

diff --git a/lib/backends/nbd.c b/lib/backends/nbd.c
index 398a1e9..43630f0 100644
--- a/lib/backends/nbd.c
+++ b/lib/backends/nbd.c
@@ -24,6 +24,7 @@
 #define NBD_DO_IT		_IO( 0xab, 3 )
 #define NBD_CLEAR_SOCK		_IO( 0xab, 4 )
 #define NBD_SET_SIZE_BLOCKS     _IO( 0xab, 7 )
+#define NBD_DISCONNECT		_IO( 0xab, 8 )
 #define NBD_SET_TIMEOUT		_IO( 0xab, 9 )
 #define NBD_SET_FLAGS		_IO( 0xab, 10)
 
@@ -221,3 +222,12 @@ int erofs_nbd_send_reply_header(int skfd, __le64 cookie, int err)
 		return 0;
 	return ret < 0 ? -errno : -EIO;
 }
+
+int erofs_nbd_disconnect(int nbdfd)
+{
+	int err, err2;
+
+	err = ioctl(nbdfd, NBD_DISCONNECT);
+	err2 = ioctl(nbdfd, NBD_CLEAR_SOCK);
+	return err ?: err2;
+}
diff --git a/lib/liberofs_nbd.h b/lib/liberofs_nbd.h
index 6660df1..a68b7b1 100644
--- a/lib/liberofs_nbd.h
+++ b/lib/liberofs_nbd.h
@@ -7,6 +7,8 @@
 
 #include "erofs/defs.h"
 
+#define NBD_MAJOR			43	/* Network block device */
+
 /* Supported request types */
 enum {
 	EROFS_NBD_CMD_READ		= 0,
@@ -35,5 +37,6 @@ int erofs_nbd_connect(int nbdfd, int blkbits, u64 blocks);
 int erofs_nbd_do_it(int nbdfd);
 int erofs_nbd_get_request(int skfd, struct erofs_nbd_request *rq);
 int erofs_nbd_send_reply_header(int skfd, __le64 cookie, int err);
+int erofs_nbd_disconnect(int nbdfd);
 
 #endif
diff --git a/mount/main.c b/mount/main.c
index 9cb203f..55181bc 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -6,6 +6,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sys/mount.h>
+#include <sys/types.h>
 #include <pthread.h>
 #include <unistd.h>
 #include "erofs/config.h"
@@ -28,6 +29,9 @@ struct loop_info {
 	char    pad1[120];
 };
 #endif
+#ifdef HAVE_SYS_SYSMACROS_H
+#include <sys/sysmacros.h>
+#endif
 
 enum erofs_backend_drv {
 	EROFSAUTO,
@@ -44,6 +48,7 @@ static struct erofsmount_cfg {
 	char *fstype;
 	long flags;
 	enum erofs_backend_drv backend;
+	bool umount;
 } mountcfg = {
 	.full_options = "ro",
 	.flags = MS_RDONLY,		/* default mountflags */
@@ -120,7 +125,7 @@ static int erofsmount_parse_options(int argc, char **argv)
 	char *dot;
 	int opt;
 
-	while ((opt = getopt_long(argc, argv, "Nfno:st:v",
+	while ((opt = getopt_long(argc, argv, "Nfno:st:uv",
 				  long_options, NULL)) != -1) {
 		switch (opt) {
 		case 'o':
@@ -146,20 +151,23 @@ static int erofsmount_parse_options(int argc, char **argv)
 			}
 			mountcfg.fstype = optarg;
 			break;
+		case 'u':
+			mountcfg.umount = true;
+			break;
 		default:
 			return -EINVAL;
 		}
 	}
+	if (!mountcfg.umount) {
+		if (optind >= argc) {
+			erofs_err("missing argument: DEVICE");
+			return -EINVAL;
+		}
 
-	if (optind >= argc) {
-		erofs_err("missing argument: DEVICE");
-		return -EINVAL;
+		mountcfg.device = strdup(argv[optind++]);
+		if (!mountcfg.device)
+			return -ENOMEM;
 	}
-
-	mountcfg.device = strdup(argv[optind++]);
-	if (!mountcfg.device)
-		return -ENOMEM;
-
 	if (optind >= argc) {
 		erofs_err("missing argument: MOUNTPOINT");
 		return -EINVAL;
@@ -394,6 +402,106 @@ out_err:
 	return -errno;
 }
 
+int erofsmount_umount(char *target)
+{
+	char *device = NULL, *mountpoint = NULL;
+	struct stat st;
+	FILE *mounts;
+	int err, fd;
+	size_t n;
+	char *s;
+	bool isblk;
+
+	target = realpath(target, NULL);
+	if (!target)
+		return -errno;
+
+	err = lstat(target, &st);
+	if (err < 0) {
+		err = -errno;
+		goto err_out;
+	}
+
+	if (S_ISBLK(st.st_mode)) {
+		isblk = true;
+	} else if (S_ISDIR(st.st_mode)) {
+		isblk = false;
+	} else {
+		err = -EINVAL;
+		goto err_out;
+	}
+
+	mounts = fopen("/proc/mounts", "r");
+	if (!mounts) {
+		err = -ENOENT;
+		goto err_out;
+	}
+
+	for (s = NULL; (getline(&s, &n, mounts)) > 0;) {
+		bool hit = false;
+		char *f1, *f2, *end;
+
+		f1 = s;
+		end = strchr(f1, ' ');
+		if (end)
+			*end = '\0';
+		if (isblk && !strcmp(f1, target))
+			hit = true;
+		if (end) {
+			f2 = end + 1;
+			end = strchr(f2, ' ');
+			if (end)
+				*end = '\0';
+			if (!isblk && !strcmp(f2, target))
+				hit = true;
+		}
+		if (hit) {
+			if (isblk) {
+				err = -EBUSY;
+				free(s);
+				fclose(mounts);
+				goto err_out;
+			}
+			free(device);
+			device = strdup(f1);
+			if (!mountpoint)
+				mountpoint = strdup(f2);
+		}
+	}
+	free(s);
+	fclose(mounts);
+	if (!isblk && !device) {
+		err = -ENOENT;
+		goto err_out;
+	}
+
+	/* Avoid TOCTOU issue with NBD_CFLAG_DISCONNECT_ON_CLOSE */
+	fd = open(isblk ? target : device, O_RDWR);
+	if (fd < 0) {
+		err = -errno;
+		goto err_out;
+	}
+	if (mountpoint) {
+		err = umount(mountpoint);
+		if (err) {
+			err = -errno;
+			close(fd);
+			goto err_out;
+		}
+	}
+	err = fstat(fd, &st);
+	if (err < 0)
+		err = -errno;
+	else if (S_ISBLK(st.st_mode) && major(st.st_rdev) == NBD_MAJOR)
+		err = erofs_nbd_disconnect(fd);
+	close(fd);
+err_out:
+	free(device);
+	free(mountpoint);
+	free(target);
+	return err < 0 ? err : 0;
+}
+
 int main(int argc, char *argv[])
 {
 	int err;
@@ -406,6 +514,14 @@ int main(int argc, char *argv[])
 		return EXIT_FAILURE;
 	}
 
+	if (mountcfg.umount) {
+		err = erofsmount_umount(mountcfg.mountpoint);
+		if (err < 0)
+			fprintf(stderr, "Failed to unmount %s: %s\n",
+				mountcfg.mountpoint, erofs_strerror(err));
+		return err ? EXIT_FAILURE : EXIT_SUCCESS;
+	}
+
 	if (mountcfg.backend == EROFSFUSE) {
 		err = erofsmount_fuse(mountcfg.device, mountcfg.mountpoint,
 				      mountcfg.fstype, mountcfg.full_options);
-- 
2.43.5


