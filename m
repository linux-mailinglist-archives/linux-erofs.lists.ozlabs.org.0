Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 568C37DFB10
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Nov 2023 20:41:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SLvQX23xCz3dD2
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Nov 2023 06:41:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lukeshu.com (client-ip=104.207.138.63; helo=mav.lukeshu.com; envelope-from=lukeshu@lukeshu.com; receiver=lists.ozlabs.org)
Received: from mav.lukeshu.com (mav.lukeshu.com [104.207.138.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SLvQF3y3Mz3cYP
	for <linux-erofs@lists.ozlabs.org>; Fri,  3 Nov 2023 06:41:41 +1100 (AEDT)
Received: from lukeshu-thinkpad-e15 (unknown [IPv6:2601:281:8200:4f:aee0:10ff:fe55:8023])
	by mav.lukeshu.com (Postfix) with ESMTPSA id DBC5280624;
	Thu,  2 Nov 2023 15:31:42 -0400 (EDT)
From: "Luke T. Shumaker" <lukeshu@lukeshu.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/3] erofs-utils: have each non-fuse command take -h, --help, -V, and --version
Date: Thu,  2 Nov 2023 13:31:20 -0600
Message-ID: <20231102193122.140921-2-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231102193122.140921-1-lukeshu@lukeshu.com>
References: <20231102193122.140921-1-lukeshu@lukeshu.com>
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
Cc: "Luke T. Shumaker" <lukeshu@umorpha.io>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: "Luke T. Shumaker" <lukeshu@umorpha.io>

Consistency is nice.

erofsfuse isn't included here because adjusting its flag handling is
more involved because of the interaction with libfuse; I anticipate
similar changes to erofsfuse in a future patchset.

Signed-off-by: Luke T. Shumaker <lukeshu@umorpha.io>
---
 dump/main.c      | 11 ++++++-----
 fsck/main.c      | 11 ++++++-----
 man/dump.erofs.1 |  5 ++++-
 man/fsck.erofs.1 |  4 ++--
 man/mkfs.erofs.1 |  5 ++++-
 mkfs/main.c      | 18 ++++++++++++++----
 6 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index 5425b7b..a952f32 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -74,7 +74,8 @@ struct erofs_statistics {
 static struct erofs_statistics stats;
 
 static struct option long_options[] = {
-	{"help", no_argument, NULL, 1},
+	{"version", no_argument, NULL, 'V'},
+	{"help", no_argument, NULL, 'h'},
 	{"nid", required_argument, NULL, 2},
 	{"device", required_argument, NULL, 3},
 	{"path", required_argument, NULL, 4},
@@ -110,14 +111,14 @@ static void usage(void)
 	fputs("usage: [options] IMAGE\n\n"
 	      "Dump erofs layout from IMAGE, and [options] are:\n"
 	      " -S              show statistic information of the image\n"
-	      " -V              print the version number of dump.erofs and exit.\n"
+	      " -V, --version   print the version number of dump.erofs and exit.\n"
 	      " -e              show extent info (INODE required)\n"
 	      " -s              show information about superblock\n"
 	      " --device=X      specify an extra device to be used together\n"
 	      " --ls            show directory contents (INODE required)\n"
 	      " --nid=#         show the target inode info of nid #\n"
 	      " --path=X        show the target inode info of path X\n"
-	      " --help          display this help and exit.\n",
+	      " -h, --help      display this help and exit.\n",
 	      stderr);
 }
 
@@ -130,7 +131,7 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
 {
 	int opt, err;
 
-	while ((opt = getopt_long(argc, argv, "SVes",
+	while ((opt = getopt_long(argc, argv, "SVesh",
 				  long_options, NULL)) != -1) {
 		switch (opt) {
 		case 'e':
@@ -153,7 +154,7 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
 			dumpcfg.nid = (erofs_nid_t)atoll(optarg);
 			++dumpcfg.totalshow;
 			break;
-		case 1:
+		case 'h':
 			usage();
 			exit(0);
 		case 3:
diff --git a/fsck/main.c b/fsck/main.c
index 3f86da4..2ac3547 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -35,7 +35,8 @@ struct erofsfsck_cfg {
 static struct erofsfsck_cfg fsckcfg;
 
 static struct option long_options[] = {
-	{"help", no_argument, 0, 1},
+	{"version", no_argument, 0, 'V'},
+	{"help", no_argument, 0, 'h'},
 	{"extract", optional_argument, 0, 2},
 	{"device", required_argument, 0, 3},
 	{"force", no_argument, 0, 4},
@@ -78,12 +79,12 @@ static void usage(void)
 {
 	fputs("usage: [options] IMAGE\n\n"
 	      "Check erofs filesystem compatibility and integrity of IMAGE, and [options] are:\n"
-	      " -V                     print the version number of fsck.erofs and exit\n"
+	      " -V, --version          print the version number of fsck.erofs and exit\n"
 	      " -d#                    set output message level to # (maximum 9)\n"
 	      " -p                     print total compression ratio of all files\n"
 	      " --device=X             specify an extra device to be used together\n"
 	      " --extract[=X]          check if all files are well encoded, optionally extract to X\n"
-	      " --help                 display this help and exit\n"
+	      " -h, --help             display this help and exit\n"
 	      "\nExtraction options (--extract=X is required):\n"
 	      " --force                allow extracting to root\n"
 	      " --overwrite            overwrite files that already exist\n"
@@ -109,7 +110,7 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 	int opt, ret;
 	bool has_opt_preserve = false;
 
-	while ((opt = getopt_long(argc, argv, "Vd:p",
+	while ((opt = getopt_long(argc, argv, "Vd:ph",
 				  long_options, NULL)) != -1) {
 		switch (opt) {
 		case 'V':
@@ -126,7 +127,7 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 		case 'p':
 			fsckcfg.print_comp_ratio = true;
 			break;
-		case 1:
+		case 'h':
 			usage();
 			exit(0);
 		case 2:
diff --git a/man/dump.erofs.1 b/man/dump.erofs.1
index 7316f4b..6237ead 100644
--- a/man/dump.erofs.1
+++ b/man/dump.erofs.1
@@ -45,9 +45,12 @@ or
 .I path
 required.
 .TP
-.BI \-V
+\fB\-V\fR, \fB\-\-version\fR
 Print the version number and exit.
 .TP
+\fB\-h\fR, \fB\-\-help\fR
+Display help string and exit.
+.TP
 .BI \-s
 Show superblock information.
 This is the default if no options are specified.
diff --git a/man/fsck.erofs.1 b/man/fsck.erofs.1
index 364219a..a226995 100644
--- a/man/fsck.erofs.1
+++ b/man/fsck.erofs.1
@@ -10,7 +10,7 @@ fsck.erofs is used to scan an EROFS filesystem \fIIMAGE\fR and check the
 integrity of it.
 .SH OPTIONS
 .TP
-.B \-V
+\fB\-V\fR, \fB\-\-version\fR
 Print the version number of fsck.erofs and exit.
 .TP
 .BI "\-d " #
@@ -32,7 +32,7 @@ Check if all files are well encoded. This read all compressed files,
 and hence create more I/O load,
 so it might take too much time depending on the image.
 .TP
-.B \-\-help
+\fB\-h\fR, \fB\-\-help\fR
 Display help string and exit.
 .SH AUTHOR
 This version of \fBfsck.erofs\fR is written by
diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index 00ac2ac..970ff28 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -163,7 +163,10 @@ set to \fIGID\fR + \fIGID-OFFSET\fR.
 .B \-\-gzip
 Filter tarball streams through gzip.
 .TP
-.B \-\-help
+\fB\-V\fR, \fB\-\-version\fR
+Print the version number and exit.
+.TP
+\fB\-h\fR, \fB\-\-help\fR
 Display help string and exit.
 .TP
 .B "\-\-ignore-mtime"
diff --git a/mkfs/main.c b/mkfs/main.c
index 637d1b9..d86a548 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -34,7 +34,8 @@
 #define EROFS_SUPER_END (EROFS_SUPER_OFFSET + sizeof(struct erofs_super_block))
 
 static struct option long_options[] = {
-	{"help", no_argument, 0, 1},
+	{"version", no_argument, 0, 'V'},
+	{"help", no_argument, 0, 'h'},
 	{"exclude-path", required_argument, NULL, 2},
 	{"exclude-regex", required_argument, NULL, 3},
 #ifdef HAVE_LIBSELINUX
@@ -91,6 +92,7 @@ static void usage(void)
 {
 	fputs("usage: [options] FILE SOURCE(s)\n"
 	      "Generate EROFS image (FILE) from DIRECTORY, TARBALL and/or EROFS images.  And [options] are:\n"
+	      " -V, --version         print the version number of mkfs.erofs and exit\n"
 	      " -b#                   set block size to # (# = page size by default)\n"
 	      " -d#                   set output message level to # (maximum 9)\n"
 	      " -x#                   set xattr tolerance to # (< 0, disable xattrs; default 2)\n"
@@ -117,7 +119,7 @@ static void usage(void)
 #ifdef HAVE_ZLIB
 	      " --gzip                try to filter the tarball stream through gzip\n"
 #endif
-	      " --help                display this help and exit\n"
+	      " -h, --help            display this help and exit\n"
 	      " --ignore-mtime        use build time instead of strict per-file modification time\n"
 	      " --max-extent-bytes=#  set maximum decompressed extent size # in bytes\n"
 	      " --preserve-mtime      keep per-file modification time strictly\n"
@@ -141,6 +143,11 @@ static void usage(void)
 	print_available_compressors(stderr, ", ");
 }
 
+static void version(void)
+{
+	printf("mkfs.erofs %s\n", cfg.c_version);
+}
+
 static unsigned int pclustersize_packed, pclustersize_max;
 static struct erofs_tarfile erofstar = {
 	.global.xattrs = LIST_HEAD_INIT(erofstar.global.xattrs)
@@ -309,7 +316,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 	int opt, i, err;
 	bool quiet = false;
 
-	while ((opt = getopt_long(argc, argv, "C:E:L:T:U:b:d:x:z:",
+	while ((opt = getopt_long(argc, argv, "C:E:L:T:U:b:d:x:z:Vh",
 				  long_options, NULL)) != -1) {
 		switch (opt) {
 		case 'z':
@@ -534,7 +541,10 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		case 517:
 			gzip_supported = true;
 			break;
-		case 1:
+		case 'V':
+			version();
+			exit(0);
+		case 'h':
 			usage();
 			exit(0);
 
-- 
2.42.0

