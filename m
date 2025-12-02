Return-Path: <linux-erofs+bounces-1482-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DC062C9B42C
	for <lists+linux-erofs@lfdr.de>; Tue, 02 Dec 2025 12:03:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dLHv25Ynqz3bnL;
	Tue, 02 Dec 2025 22:03:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.86
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764673406;
	cv=none; b=R6q6GPFofmGeoZmbwOjRyWcixAiD2ppdWt6/fXAXEjxQvH0SD6ODl6tWHKhUmcmGoMItW0LdH3uP2wR2bNw/zhnh/NJWnwe1RyDwCmuiXiDHqj9XRqpmwtInpupQllQ692mEh6ytr4510SYEvtJyWuaaMcdZgAPHC/siS5FaN/wkzlprgcbTGYKB/2zLH3kQtCiOerp77b1w9o7Fpj39MjMh7T1wH8PW+Gd48kYiuBK6k78sVlsRi/0r6VSJ7NX4KPMoIFOYllV+NbYfxDukgffaHf92VipFtcDcH62t42rGFIPTJuaoJ/UwXy2k1XKp9VRK63HqQov9RQ40P1NzdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764673406; c=relaxed/relaxed;
	bh=hlYBsG/abXwK+sb5+45vADJ7yDnOA+a57kNTumAgfp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kc3UTiJggTqLh/uyVy9f5XE2J5wgdpxJ+tTAbiBGkGr6JOMPtQ5qUbL5ow6qwAYZhmw26mdw8rnrgzjIFx41fxn9WXQdWpbSdrLY3KdIEwZfQWSNFOPKDeXOU6kzYekEo0gMqjouTutrDXcgypH0qOroPcQ6AQ4iWnTSk74IKX4CbulDJjXftex/IFSMSoYyGZvv4iO7TgjCPhta967HKcmCoQtqeaZ4eQ438Uxx9bXTWx+3upIv/h8kIAVYkeBuIlZsa2iCVGw5F1AN4bKwBNKI+93GWPeQWkEMVxkCDw9kkKRlr+0jeqSFS2E3bTtUmiebCinFcA8lTXtYdEIg2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.86; helo=out28-86.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.86; helo=out28-86.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-86.mail.aliyun.com (out28-86.mail.aliyun.com [115.124.28.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dLHv05mlXz3blk
	for <linux-erofs@lists.ozlabs.org>; Tue, 02 Dec 2025 22:03:22 +1100 (AEDT)
Received: from HUDSONZHU-MC1.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.fbD70I8_1764673396 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 02 Dec 2025 19:03:17 +0800
From: ChengyuZhu6 <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH v3] mount.erofs: add manpage and usage information
Date: Tue,  2 Dec 2025 19:03:15 +0800
Message-ID: <20251202110315.14656-1-hudson@cyzhu.com>
X-Mailer: git-send-email 2.51.0
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
X-Spam-Status: No, score=0.0 required=3.0 tests=RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Chengyu Zhu <hudsonzhu@tencent.com>

Add manpage, command-line usage help, and README for
mount.erofs tool.

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
---
 README            |  26 +++++++++
 man/Makefile.am   |   2 +-
 man/mount.erofs.1 | 142 ++++++++++++++++++++++++++++++++++++++++++++++
 mount/main.c      |  41 ++++++++++++-
 4 files changed, 209 insertions(+), 2 deletions(-)
 create mode 100644 man/mount.erofs.1

diff --git a/README b/README
index b885fa8..77ccef7 100644
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
+For more details, see mount.erofs(1) manpage.
+
+
 erofsfuse
 ---------
 
diff --git a/man/Makefile.am b/man/Makefile.am
index 4628b85..2990e77 100644
--- a/man/Makefile.am
+++ b/man/Makefile.am
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-dist_man_MANS = mkfs.erofs.1 dump.erofs.1 fsck.erofs.1
+dist_man_MANS = mkfs.erofs.1 dump.erofs.1 fsck.erofs.1 mount.erofs.1
 
 EXTRA_DIST = erofsfuse.1
 if ENABLE_FUSE
diff --git a/man/mount.erofs.1 b/man/mount.erofs.1
new file mode 100644
index 0000000..146c01e
--- /dev/null
+++ b/man/mount.erofs.1
@@ -0,0 +1,142 @@
+.\" Copyright (c) 2025 Chengyu Zhu <hudsonzhu@tencent.com>
+.\"
+.TH MOUNT.EROFS 1
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
index e25134c..b0eba79 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -81,6 +81,38 @@ static struct erofs_nbd_source {
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
+		"    --reattach		reattach to an existing NBD device\n"
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
@@ -253,6 +285,7 @@ static int erofsmount_parse_options(int argc, char **argv)
 {
 	static const struct option long_options[] = {
 		{"help", no_argument, 0, 'h'},
+		{"version", no_argument, 0, 'V'},
 		{"reattach", no_argument, 0, 512},
 		{0, 0, 0, 0},
 	};
@@ -261,9 +294,15 @@ static int erofsmount_parse_options(int argc, char **argv)
 
 	nbdsrc.ocicfg.layer_index = -1;
 
-	while ((opt = getopt_long(argc, argv, "Nfno:st:uv",
+	while ((opt = getopt_long(argc, argv, "hVNfno:st:uv",
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
2.51.0


