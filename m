Return-Path: <linux-erofs+bounces-1527-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E931BCD4E29
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Dec 2025 08:43:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dZVWK3gQSz2xpm;
	Mon, 22 Dec 2025 18:43:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.220
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766389421;
	cv=none; b=OeTXyptLjA4IT8KGfYsvjj7oYzaGClHY9Z7sFfYppaBb1U32p1yxlwQkE59UnoBzSH7W6K9tKaOyEYRpLuWdlj8QX6teObfIQgh75g41Y02Q1sUqBnXjC2KWHSa3Po+PdsIlpNVVCj/VK0Iq+XypZVbrCmg1qM5v4Qu6nkUfTG9dA7gvaPL/V8f2EKB8cxuGVcaeQ6ZfvvQnOSs1tJU72463sQovkrP40qqaJBWRYaTbIHsOoChj6GDP1T48B8NjyK8azEOqhohedGO/QbZfxS7Fad+aESAGnDzB6pvfXqbtBlBYEURhNZDnL/+8/MZb6lRSCVWDuurXREX5xEwUDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766389421; c=relaxed/relaxed;
	bh=l4A5kB1z3nVFlqsGioE2Z7W3gy7G2+7qOr/mgNCVvCU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bWW+0U6oJR8poIJLeAMrI26Iorr+W+TpTPSTADxuHrkcweHS5tZ0UcUYHIJIxZsRFrK/LKD0qDbRO+Ppxel4XA3KSgaGHRFDzg370jEe3FyVl2ck92fBJg11EyiC0lZbyQHoT4JWgE62ggk39FstV+o7564m3APtIjl9ZlInBeVdtqACdEYGNdoFWDYnd3ERkBLOgvuqRK4IBnbdGxFv6Kjmxw9DFR/RT+jzwPdG14aXCeqZ9cLW8d9zzIHz1woGq8NihMC6d+66SU/HBzpZ3WXR+Pukn6xrQ0/001rUycmLxqYfCBVopWUCbDgiSByOVMcvHe1gdPac74yrSfFaow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=n8wwU79E; dkim-atps=neutral; spf=pass (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=n8wwU79E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dZVWG6b7Bz2xFn
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Dec 2025 18:43:38 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=l4A5kB1z3nVFlqsGioE2Z7W3gy7G2+7qOr/mgNCVvCU=;
	b=n8wwU79EWPqDt6cH5reaP6DCQxqbI5qz4dQ22NW6PFaDAh2bwwxc6rp9bqqpH0CbaBJD7LKUA
	LleHI9uT8rW4sVrY/WednNykt2i13nIO+m7g6l3BIUWUXCDY/GLojMN87rGsPbx/qhASRIHhHn8
	6yameOy8wwgbqjG6PqYfx0U=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dZVSg2f4Rz12LF3;
	Mon, 22 Dec 2025 15:41:23 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 44EB04056E;
	Mon, 22 Dec 2025 15:43:34 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 22 Dec
 2025 15:43:33 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <hsiangkao@linux.alibaba.com>, <hudson@cyzhu.com>, <jingrui@huawei.com>,
	<wayne.ma@huawei.com>, <zhaoyifan28@huawei.com>
Subject: [PATCH v5] erofs-utils: mount: add manpage and usage information
Date: Mon, 22 Dec 2025 15:42:37 +0800
Message-ID: <20251222074237.170615-1-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251130033516.86065-1-hudson@cyzhu.com>
References: <20251130033516.86065-1-hudson@cyzhu.com>
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
Content-Type: text/plain
X-Originating-IP: [10.50.159.234]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Chengyu Zhu <hudsonzhu@tencent.com>

Add manpage, command-line usage help, and README for
mount.erofs tool.

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
Link: https://lore.kernel.org/r/20251202110315.14656-1-hudson@cyzhu.com
[ Gao Xiang: change the section number of the manpage to 8. ]
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
Sorry, there is also an indent error need to be fixed.

Thanks,
Yifan Zhao

Interdiff against experimental:
  diff --git a/man/mount.erofs.8 b/man/mount.erofs.8
  index 6b3a32b..856e07f 100644
  --- a/man/mount.erofs.8
  +++ b/man/mount.erofs.8
  @@ -117,6 +117,9 @@ Path to a tarball index file for hybrid tar+OCI mode.
   .TP
   .BI "oci.zinfo=" path
   Path to a gzip zinfo file for random access to gzip-compressed tar layers.
  +.TP
  +.BI "oci.insecure"
  +Use HTTP instead of HTTPS to access the image registry.
   .SH NOTES
   .IP \(bu 2
   EROFS filesystems are read-only by nature. The \fBrw\fR option will be ignored.
  diff --git a/mount/main.c b/mount/main.c
  index ed6bcdc..1463dee 100644
  --- a/mount/main.c
  +++ b/mount/main.c
  @@ -94,7 +94,7 @@ static void usage(int argc, char **argv)
   		" -t type[.subtype]	filesystem type (and optional subtype)\n"
   		" 			subtypes: fuse, local, nbd\n"
   		" -u 			unmount the filesystem\n"
  -		"    --reattach		reattach to an existing NBD device\n"
  +		" --reattach		reattach to an existing NBD device\n"
   #ifdef OCIEROFS_ENABLED
   		"\n"
   		"OCI-specific options (with -o):\n"
  @@ -105,6 +105,7 @@ static void usage(int argc, char **argv)
   		"   oci.password=<pass> password for authentication (optional)\n"
   		"   oci.tarindex=<path> path to tarball index file (optional)\n"
   		"   oci.zinfo=<path>    path to gzip zinfo file (optional)\n"
  +		"   oci.insecure        use HTTP instead of HTTPS (optional)\n"
   #endif
   		, argv[0]);
   }

 README            |  26 +++++++++
 man/Makefile.am   |   2 +-
 man/mount.erofs.8 | 145 ++++++++++++++++++++++++++++++++++++++++++++++
 mount/main.c      |  42 +++++++++++++-
 4 files changed, 213 insertions(+), 2 deletions(-)
 create mode 100644 man/mount.erofs.8

diff --git a/README b/README
index b885fa8..1ca376f 100644
--- a/README
+++ b/README
@@ -4,6 +4,7 @@ erofs-utils
 Userspace tools for EROFS filesystem, currently including:
 
   mkfs.erofs    filesystem formatter
+  mount.erofs   mount helper for EROFS
   erofsfuse     FUSE daemon alternative
   dump.erofs    filesystem analyzer
   fsck.erofs    filesystem compatibility & consistency checker as well
@@ -206,6 +207,31 @@ git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git -b obsoleted
 PLEASE NOTE: This version is highly _NOT recommended_ now.
 
 
+mount.erofs
+-----------
+
+mount.erofs is a mount helper for EROFS filesystem, which can be used
+to mount EROFS images with various backends including direct kernel
+mount, FUSE-based mount, and NBD for remote sources like OCI images.
+
+How to mount an EROFS image
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+To mount an EROFS image directly:
+ $ mount.erofs foo.erofs /mnt
+
+To mount with FUSE backend:
+ $ mount.erofs -t erofs.fuse foo.erofs /mnt
+
+To mount from OCI image with NBD backend:
+ $ mount.erofs -t erofs.nbd -o oci.blob=sha256:... <IMAGE>:<TAG> mnt
+
+To unmount an EROFS filesystem:
+ $ mount.erofs -u mnt
+
+For more details, see mount.erofs(8) manpage.
+
+
 erofsfuse
 ---------
 
diff --git a/man/Makefile.am b/man/Makefile.am
index 4628b85..b76b457 100644
--- a/man/Makefile.am
+++ b/man/Makefile.am
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-dist_man_MANS = mkfs.erofs.1 dump.erofs.1 fsck.erofs.1
+dist_man_MANS = mkfs.erofs.1 dump.erofs.1 fsck.erofs.1 mount.erofs.8
 
 EXTRA_DIST = erofsfuse.1
 if ENABLE_FUSE
diff --git a/man/mount.erofs.8 b/man/mount.erofs.8
new file mode 100644
index 0000000..856e07f
--- /dev/null
+++ b/man/mount.erofs.8
@@ -0,0 +1,145 @@
+.\" Copyright (c) 2025 Chengyu Zhu <hudsonzhu@tencent.com>
+.\"
+.TH MOUNT.EROFS 8
+.SH NAME
+mount.erofs \- manage EROFS filesystem
+.SH SYNOPSIS
+\fBmount.erofs\fR [\fIOPTIONS\fR] \fISOURCE\fR \fIMOUNTPOINT\fR
+.br
+\fBmount.erofs\fR \fB\-u\fR \fITARGET\fR
+.br
+\fBmount.erofs\fR \fB\-\-reattach\fR \fITARGET\fR
+.SH DESCRIPTION
+EROFS is an enhanced lightweight read-only filesystem with modern designs
+for scenarios which need high-performance read-only requirements.
+.PP
+\fBmount.erofs\fR is used to mount an EROFS filesystem from \fISOURCE\fR
+(which can be an image file or block device) to a \fIMOUNTPOINT\fR. It supports multiple backends including
+direct kernel mount, FUSE-based mount, and NBD (Network Block Device) for
+remote sources like OCI images.
+.SH OPTIONS
+.TP
+.B \-h, \-\-help
+Display help message and exit.
+.TP
+.B \-V, \-\-version
+Display version information and exit.
+.TP
+.BI "\-o " options
+Comma-separated list of mount options. See \fBMOUNT OPTIONS\fR below.
+.TP
+.BI "\-t " type[.subtype]
+Specify the filesystem type and optional subtype. The type should be
+\fBerofs\fR. Available subtypes are:
+.RS
+.TP
+.B fuse
+Use FUSE-based mount via \fBerofsfuse\fR.
+.TP
+.B local
+Force direct kernel mount (default if available).
+.TP
+.B nbd
+Use NBD backend for remote sources (e.g., OCI images).
+.RE
+.TP
+.B \-u
+Unmount the filesystem at the specified target.
+.TP
+.B \-\-reattach
+Reattach to an existing NBD device and restart the NBD service.
+.SH MOUNT OPTIONS
+Standard mount options:
+.TP
+.B ro
+Mount the filesystem read-only (default).
+.TP
+.B rw
+Mount the filesystem read-write (not supported for EROFS).
+.TP
+.B nosuid
+Do not honor set-user-ID and set-group-ID bits.
+.TP
+.B suid
+Honor set-user-ID and set-group-ID bits (default).
+.TP
+.B nodev
+Do not interpret character or block special devices.
+.TP
+.B dev
+Interpret character or block special devices (default).
+.TP
+.B noexec
+Do not allow direct execution of any binaries.
+.TP
+.B exec
+Allow execution of binaries (default).
+.TP
+.B noatime
+Do not update inode access times.
+.TP
+.B atime
+Update inode access times (default).
+.TP
+.B nodiratime
+Do not update directory inode access times.
+.TP
+.B diratime
+Update directory inode access times (default).
+.TP
+.B relatime
+Update inode access times relative to modify or change time.
+.TP
+.B norelatime
+Do not use relative atime updates.
+.SH OCI-SPECIFIC OPTIONS
+The following OCI-specific options are available:
+.TP
+.BI "oci.blob=" digest
+Specify the OCI blob digest to mount. The digest should be in the format
+\fBsha256:...\fR. Cannot be used together with \fBoci.layer\fR.
+.TP
+.BI "oci.layer=" index
+Specify the OCI layer index to mount (0-based). Cannot be used together
+with \fBoci.blob\fR.
+.TP
+.BI "oci.platform=" platform
+Specify the target platform (default: \fBlinux/amd64\fR).
+.TP
+.BI "oci.username=" username
+Username for OCI registry authentication.
+.TP
+.BI "oci.password=" password
+Password for OCI registry authentication.
+.TP
+.BI "oci.tarindex=" path
+Path to a tarball index file for hybrid tar+OCI mode.
+.TP
+.BI "oci.zinfo=" path
+Path to a gzip zinfo file for random access to gzip-compressed tar layers.
+.TP
+.BI "oci.insecure"
+Use HTTP instead of HTTPS to access the image registry.
+.SH NOTES
+.IP \(bu 2
+EROFS filesystems are read-only by nature. The \fBrw\fR option will be ignored.
+.IP \(bu 2
+When mounting OCI images via NBD, the mount process creates a background
+daemon to serve the NBD device. The daemon will automatically clean up when
+the filesystem is unmounted.
+.IP \(bu 2
+The \fB\-\-reattach\fR option is useful for recovering NBD mounts after a
+system crash or when the NBD daemon was terminated unexpectedly.
+.IP \(bu 2
+Kernel direct mount is used when mounting a regular file without
+specifying a backend type. If file-based mounts is unsupported,
+loop devices will be set up automatically.
+.SH SEE ALSO
+.BR mkfs.erofs (1),
+.BR erofsfuse (1),
+.BR dump.erofs (1),
+.BR fsck.erofs (1),
+.BR mount (8),
+.BR umount (8)
+.SH AVAILABILITY
+\fBmount.erofs\fR is part of erofs-utils.
diff --git a/mount/main.c b/mount/main.c
index 893daf9..1463dee 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -82,6 +82,39 @@ static struct erofs_nbd_source {
 	};
 } nbdsrc;
 
+static void usage(int argc, char **argv)
+{
+	printf("Usage: %s [OPTIONS] SOURCE [MOUNTPOINT]\n"
+		"Manage EROFS filesystem.\n"
+		"\n"
+		"General options:\n"
+		" -V, --version		print the version number of mount.erofs and exit\n"
+		" -h, --help		display this help and exit\n"
+		" -o options		comma-separated list of mount options\n"
+		" -t type[.subtype]	filesystem type (and optional subtype)\n"
+		" 			subtypes: fuse, local, nbd\n"
+		" -u 			unmount the filesystem\n"
+		" --reattach		reattach to an existing NBD device\n"
+#ifdef OCIEROFS_ENABLED
+		"\n"
+		"OCI-specific options (with -o):\n"
+		"   oci.blob=<digest>   specify OCI blob digest (sha256:...)\n"
+		"   oci.layer=<index>   specify OCI layer index\n"
+		"   oci.platform=<name> specify platform (default: linux/amd64)\n"
+		"   oci.username=<user> username for authentication (optional)\n"
+		"   oci.password=<pass> password for authentication (optional)\n"
+		"   oci.tarindex=<path> path to tarball index file (optional)\n"
+		"   oci.zinfo=<path>    path to gzip zinfo file (optional)\n"
+		"   oci.insecure        use HTTP instead of HTTPS (optional)\n"
+#endif
+		, argv[0]);
+}
+
+static void version(void)
+{
+	printf("mount.erofs (erofs-utils) %s\n", cfg.c_version);
+}
+
 #ifdef OCIEROFS_ENABLED
 static int erofsmount_parse_oci_option(const char *option)
 {
@@ -237,6 +270,7 @@ static int erofsmount_parse_options(int argc, char **argv)
 {
 	static const struct option long_options[] = {
 		{"help", no_argument, 0, 'h'},
+		{"version", no_argument, 0, 'V'},
 		{"reattach", no_argument, 0, 512},
 		{0, 0, 0, 0},
 	};
@@ -245,9 +279,15 @@ static int erofsmount_parse_options(int argc, char **argv)
 
 	nbdsrc.ocicfg.layer_index = -1;
 
-	while ((opt = getopt_long(argc, argv, "Nfno:st:uv",
+	while ((opt = getopt_long(argc, argv, "VNfhno:st:uv",
 				  long_options, NULL)) != -1) {
 		switch (opt) {
+		case 'h':
+			usage(argc, argv);
+			exit(0);
+		case 'V':
+			version();
+			exit(0);
 		case 'o':
 			mountcfg.full_options = optarg;
 			mountcfg.flags =
-- 
2.43.0


