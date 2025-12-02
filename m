Return-Path: <linux-erofs+bounces-1474-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF8BC99F12
	for <lists+linux-erofs@lfdr.de>; Tue, 02 Dec 2025 04:08:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dL5Lp52k1z3bl7;
	Tue, 02 Dec 2025 14:08:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.88
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764644898;
	cv=none; b=eY1mooJWQDBqAc+/C3Hxr4dQWhj7oqLDldsysmo9iFbjPfaiKvC9TtYH8PGRXshGUH40r08Iva/Dsm+1z6qwIRgOq+9mQpoOH+kDySHBy2s7RIWK6A8oIy5UavQ4iXNijRfdeNwiQqEXI7P26t6KjTbHt2T4BW3U0GwuSIDbmCJ8baIcdrDsZ3EdFVwDze/R4xxx09emMjBBqbN/QCRigcJJDzE8/ie6j81x1bztbutToNpn0uUJ4uFXhAvjZpm9aJOfxR96X4L+VVtOQO6gLH17xpjH/kJDP5NpEIC+SzUtPXhVeUp3wuJtAQScDtDBXpmNEdjCiYM8viUUAAUMEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764644898; c=relaxed/relaxed;
	bh=Nu1WzC/Lc7Y5JKs8Lpjbm0Yt6QroOCmwlSzJNT4JwHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lIBvdTOqAFh+2pPnOAncVk4d6fo90P3WELbO6Jm09NdK3jgPRKjPZFXZ0wO+TzuJjlEnPBPdBkCUGqA6qt2tKv5Tie6zzMfFMUAvC1TdZg6U8bWRokaJTEYqgVpT+t72boOcCLsn/5bOcPmd4uj5gV5kuWhAiC3FxjLi/0p/TYzvpqJrhOvCfQ6ByyUg0ongHzzGbAeiTsDb7S4K9/nH6LVUhcxyacm0DXMhzThTA8NUVf+dNcwJV0oMA66WioCI/4856fiG/uBfPQL31w1FvcA7gtvy+nCvJmRJnpLTn/bWsXHcGPb1S/fDZi6MRF49hlJIblZUux8zee2sP51OWQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.88; helo=out28-88.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.88; helo=out28-88.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-88.mail.aliyun.com (out28-88.mail.aliyun.com [115.124.28.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dL5Lm4r0zz3bfR
	for <linux-erofs@lists.ozlabs.org>; Tue, 02 Dec 2025 14:08:14 +1100 (AEDT)
Received: from HUDSONZHU-MC1.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.fapHI42_1764644889 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 02 Dec 2025 11:08:09 +0800
From: ChengyuZhu6 <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH v2] mount.erofs: add manpage and usage information
Date: Tue,  2 Dec 2025 11:08:07 +0800
Message-ID: <20251202030807.55673-1-hudson@cyzhu.com>
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
 README            |  26 ++++++
 man/Makefile.am   |   2 +-
 man/mount.erofs.1 | 202 ++++++++++++++++++++++++++++++++++++++++++++++
 mount/main.c      |  41 +++++++++-
 4 files changed, 269 insertions(+), 2 deletions(-)
 create mode 100644 man/mount.erofs.1

diff --git a/README b/README
index b885fa8..784bd50 100644
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
+ $ mount.erofs foo.erofs.img /mnt
+
+To mount with FUSE backend:
+ $ mount.erofs -t erofs.fuse foo.erofs.img /mnt
+
+To mount from OCI image with NBD backend:
+ $ mount.erofs -t erofs.nbd -o oci.blob=sha256:... image:tag /mnt
+
+To unmount:
+ $ mount.erofs -u /mnt
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
index 0000000..6eeb48c
--- /dev/null
+++ b/man/mount.erofs.1
@@ -0,0 +1,202 @@
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
+.SH EXAMPLES
+Mount a local EROFS image:
+.PP
+.nf
+.RS
+mount.erofs image.erofs /mnt
+.RE
+.fi
+.PP
+Mount using FUSE backend:
+.PP
+.nf
+.RS
+mount.erofs \-t erofs.fuse image.erofs /mnt
+.RE
+.fi
+.PP
+Mount an OCI blob via NBD:
+.PP
+.nf
+.RS
+mount.erofs \-t erofs.nbd \\
+    \-o oci.blob=sha256:abc123...,oci.username=user,oci.password=pass \\
+    docker.io/library/image:tag /mnt
+.RE
+.fi
+.PP
+Mount an OCI layer by index:
+.PP
+.nf
+.RS
+mount.erofs \-t erofs.nbd \-o oci.layer=0 \\
+    docker.io/library/image:tag /mnt
+.RE
+.fi
+.PP
+Mount with tarball index and gzip support:
+.PP
+.nf
+.RS
+mount.erofs \-t erofs.nbd \\
+    \-o oci.blob=sha256:abc...,oci.tarindex=/path/to/index,oci.zinfo=/path/to/zinfo \\
+    docker.io/library/image:tag /mnt
+.RE
+.fi
+.PP
+Unmount a filesystem:
+.PP
+.nf
+.RS
+mount.erofs \-u /mnt
+.RE
+.fi
+.PP
+Reattach to an NBD device:
+.PP
+.nf
+.RS
+mount.erofs \-\-reattach /dev/nbd0
+.RE
+.fi
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
+Loop device mounting is automatically used when mounting a regular file
+without specifying a backend type.
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
index e25134c..4dfa1d1 100644
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
+		"   oci.layer=<index>   specify OCI layer index (0-based)\n"
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


