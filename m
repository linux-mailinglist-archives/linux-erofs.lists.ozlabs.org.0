Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A53CC7DFB0F
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Nov 2023 20:41:54 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SLvQS4KqPz3d8p
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Nov 2023 06:41:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lukeshu.com (client-ip=2001:19f0:5c00:8069:5400:ff:fe26:6a86; helo=mav.lukeshu.com; envelope-from=lukeshu@lukeshu.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 592 seconds by postgrey-1.37 at boromir; Fri, 03 Nov 2023 06:41:41 AEDT
Received: from mav.lukeshu.com (mav.lukeshu.com [IPv6:2001:19f0:5c00:8069:5400:ff:fe26:6a86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SLvQF2NT5z2yq4
	for <linux-erofs@lists.ozlabs.org>; Fri,  3 Nov 2023 06:41:41 +1100 (AEDT)
Received: from lukeshu-thinkpad-e15 (unknown [IPv6:2601:281:8200:4f:aee0:10ff:fe55:8023])
	by mav.lukeshu.com (Postfix) with ESMTPSA id 109BA80625;
	Thu,  2 Nov 2023 15:31:44 -0400 (EDT)
From: "Luke T. Shumaker" <lukeshu@lukeshu.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/3] erofs-utils: improve the usage and version text of non-fuse commands
Date: Thu,  2 Nov 2023 13:31:21 -0600
Message-ID: <20231102193122.140921-3-lukeshu@lukeshu.com>
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

For each command:

 - Change the format of --help to be closer to the usual GNU format
 - Have the --version text mention that it is part of erofs-utils
 - Include compile-time feature flags in -V
 - Have --help and --version print on stdout not stderr
 - Exit with 0 from --help and --version
 - Have flag errors print a message saying to use --help instead of
   printing the full help text

For fsck.erofs:

 - Consolidate the descriptions of --[no-]preserve[-<owner|perms>
 - Clarify the range that -d accepts

For mkfs.erofs:

 - Print supported algorithms and their level ranges+defaults
 - Clarify the range that -d accepts

For mkfs.erofs to have access to the algorithms' level ranges and
defaults, it is necessary to modify
z_erofs_list_available_compressors() to return the full `struct
erofs_algorithm` instead of just the `->name`.

Signed-off-by: Luke T. Shumaker <lukeshu@umorpha.io>
---
 dump/main.c              |  40 +++++++-----
 fsck/main.c              |  68 ++++++++++++--------
 include/erofs/compress.h |   2 +-
 lib/compressor.c         |  13 +---
 lib/compressor.h         |   9 ++-
 man/mkfs.erofs.1         |  10 +--
 mkfs/main.c              | 132 ++++++++++++++++++++++++---------------
 7 files changed, 163 insertions(+), 111 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index a952f32..293093d 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -106,25 +106,31 @@ static struct erofsdump_feature feature_lists[] = {
 
 static int erofsdump_readdir(struct erofs_dir_context *ctx);
 
-static void usage(void)
+static void usage(int argc, char **argv)
 {
-	fputs("usage: [options] IMAGE\n\n"
-	      "Dump erofs layout from IMAGE, and [options] are:\n"
-	      " -S              show statistic information of the image\n"
-	      " -V, --version   print the version number of dump.erofs and exit.\n"
-	      " -e              show extent info (INODE required)\n"
-	      " -s              show information about superblock\n"
-	      " --device=X      specify an extra device to be used together\n"
-	      " --ls            show directory contents (INODE required)\n"
-	      " --nid=#         show the target inode info of nid #\n"
-	      " --path=X        show the target inode info of path X\n"
-	      " -h, --help      display this help and exit.\n",
-	      stderr);
+	//	"         1         2         3         4         5         6         7         8  "
+	//	"12345678901234567890123456789012345678901234567890123456789012345678901234567890\n"
+	printf(
+		"Usage: %s [OPTIONS] IMAGE\n"
+		"Dump erofs layout from IMAGE.\n"
+		"\n"
+		"General options:\n"
+		" -V, --version   print the version number of dump.erofs and exit\n"
+		" -h, --help      display this help and exit\n"
+		"\n"
+		" -S              show statistic information of the image\n"
+		" -e              show extent info (INODE required)\n"
+		" -s              show information about superblock\n"
+		" --device=X      specify an extra device to be used together\n"
+		" --ls            show directory contents (INODE required)\n"
+		" --nid=#         show the target inode info of nid #\n"
+		" --path=X        show the target inode info of path X\n",
+		argv[0]);
 }
 
 static void erofsdump_print_version(void)
 {
-	printf("dump.erofs %s\n", cfg.c_version);
+	printf("dump.erofs (erofs-utils) %s\n", cfg.c_version);
 }
 
 static int erofsdump_parse_options_cfg(int argc, char **argv)
@@ -155,7 +161,7 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
 			++dumpcfg.totalshow;
 			break;
 		case 'h':
-			usage();
+			usage(argc, argv);
 			exit(0);
 		case 3:
 			err = blob_open_ro(&sbi, optarg);
@@ -663,7 +669,7 @@ int main(int argc, char **argv)
 	err = erofsdump_parse_options_cfg(argc, argv);
 	if (err) {
 		if (err == -EINVAL)
-			usage();
+			fprintf(stderr, "Try '%s --help' for more information.\n", argv[0]);
 		goto exit;
 	}
 
@@ -690,7 +696,7 @@ int main(int argc, char **argv)
 		erofsdump_print_statistic();
 
 	if (dumpcfg.show_extent && !dumpcfg.show_inode) {
-		usage();
+		fprintf(stderr, "Try '%s --help' for more information.\n", argv[0]);
 		goto exit_put_super;
 	}
 
diff --git a/fsck/main.c b/fsck/main.c
index 2ac3547..aeea892 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -14,6 +14,7 @@
 #include "erofs/compress.h"
 #include "erofs/decompress.h"
 #include "erofs/dir.h"
+#include "../lib/compressor.h"
 
 static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid);
 
@@ -64,45 +65,58 @@ static void print_available_decompressors(FILE *f, const char *delim)
 {
 	int i = 0;
 	bool comma = false;
-	const char *s;
+	const struct erofs_algorithm *s;
 
 	while ((s = z_erofs_list_available_compressors(&i)) != NULL) {
 		if (comma)
 			fputs(delim, f);
-		fputs(s, f);
+		fputs(s->name, f);
 		comma = true;
 	}
 	fputc('\n', f);
 }
 
-static void usage(void)
+static void usage(int argc, char **argv)
 {
-	fputs("usage: [options] IMAGE\n\n"
-	      "Check erofs filesystem compatibility and integrity of IMAGE, and [options] are:\n"
-	      " -V, --version          print the version number of fsck.erofs and exit\n"
-	      " -d#                    set output message level to # (maximum 9)\n"
-	      " -p                     print total compression ratio of all files\n"
-	      " --device=X             specify an extra device to be used together\n"
-	      " --extract[=X]          check if all files are well encoded, optionally extract to X\n"
-	      " -h, --help             display this help and exit\n"
-	      "\nExtraction options (--extract=X is required):\n"
-	      " --force                allow extracting to root\n"
-	      " --overwrite            overwrite files that already exist\n"
-	      " --preserve             extract with the same ownership and permissions as on the filesystem\n"
-	      "                        (default for superuser)\n"
-	      " --preserve-owner       extract with the same ownership as on the filesystem\n"
-	      " --preserve-perms       extract with the same permissions as on the filesystem\n"
-	      " --no-preserve          extract as yourself and apply user's umask on permissions\n"
-	      "                        (default for ordinary users)\n"
-	      " --no-preserve-owner    extract as yourself\n"
-	      " --no-preserve-perms    apply user's umask when extracting permissions\n"
-	      "\nSupported algorithms are: ", stderr);
-	print_available_decompressors(stderr, ", ");
+	//	"         1         2         3         4         5         6         7         8  "
+	//	"12345678901234567890123456789012345678901234567890123456789012345678901234567890\n"
+	printf(
+		"Usage: %s [OPTIONS] IMAGE\n"
+		"Check erofs filesystem compatibility and integrity of IMAGE.\n"
+		"\n"
+		"This version of fsck.erofs is capable of checking images that use any of the\n"
+		"following algorithms: ", argv[0]);
+	print_available_decompressors(stdout, ", ");
+	printf("\n"
+		"General options:\n"
+		" -V, --version          print the version number of fsck.erofs and exit\n"
+		" -h, --help             display this help and exit\n"
+		"\n"
+		" -d<0-9>                set output verbosity; 0=quiet, 9=verbose (default=%i)\n"
+		" -p                     print total compression ratio of all files\n"
+		" --device=X             specify an extra device to be used together\n"
+		" --extract[=X]          check if all files are well encoded, optionally\n"
+		"                        extract to X\n"
+		"\n"
+		"Extraction options (--extract=X is required):\n"
+		" --force                allow extracting to root\n"
+		" --overwrite            overwrite files that already exist\n"
+		" --[no-]preserve        same as --[no-]preserve-owner --[no-]preserve-perms\n"
+		" --[no-]preserve-owner  whether to preserve the ownership from the\n"
+		"                        filesystem (default for superuser), or to extract as\n"
+		"                        yourself (default for ordinary users)\n"
+		" --[no-]preserve-perms  whether to preserve the exact permissions from the\n"
+		"                        filesystem without applying umask (default for\n"
+		"                        superuser), or to modify the permissions by applying\n"
+		"                        umask (default for ordinary users)\n",
+		EROFS_WARN);
 }
 
 static void erofsfsck_print_version(void)
 {
-	printf("fsck.erofs %s\n", cfg.c_version);
+	printf("fsck.erofs (erofs-utils) %s\navailable decompressors: ",
+	       cfg.c_version);
+	print_available_decompressors(stdout, ", ");
 }
 
 static int erofsfsck_parse_options_cfg(int argc, char **argv)
@@ -128,7 +142,7 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 			fsckcfg.print_comp_ratio = true;
 			break;
 		case 'h':
-			usage();
+			usage(argc, argv);
 			exit(0);
 		case 2:
 			fsckcfg.check_decomp = true;
@@ -919,7 +933,7 @@ int main(int argc, char *argv[])
 	err = erofsfsck_parse_options_cfg(argc, argv);
 	if (err) {
 		if (err == -EINVAL)
-			usage();
+			fprintf(stderr, "Try '%s --help' for more information.\n", argv[0]);
 		goto exit;
 	}
 
diff --git a/include/erofs/compress.h b/include/erofs/compress.h
index 46cff03..046640b 100644
--- a/include/erofs/compress.h
+++ b/include/erofs/compress.h
@@ -24,7 +24,7 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi,
 int z_erofs_compress_exit(void);
 
 const char *z_erofs_list_supported_algorithms(int i, unsigned int *mask);
-const char *z_erofs_list_available_compressors(int *i);
+const struct erofs_algorithm *z_erofs_list_available_compressors(int *i);
 
 static inline bool erofs_is_packed_inode(struct erofs_inode *inode)
 {
diff --git a/lib/compressor.c b/lib/compressor.c
index 93f5617..47079d4 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -10,14 +10,7 @@
 
 #define EROFS_CONFIG_COMPR_DEF_BOUNDARY		(128)
 
-static const struct erofs_algorithm {
-	char *name;
-	const struct erofs_compressor *c;
-	unsigned int id;
-
-	/* its name won't be shown as a supported algorithm */
-	bool optimisor;
-} erofs_algs[] = {
+static const struct erofs_algorithm erofs_algs[] = {
 	{ "lz4",
 #if LZ4_ENABLED
 		&erofs_compressor_lz4,
@@ -65,12 +58,12 @@ const char *z_erofs_list_supported_algorithms(int i, unsigned int *mask)
 	return "";
 }
 
-const char *z_erofs_list_available_compressors(int *i)
+const struct erofs_algorithm *z_erofs_list_available_compressors(int *i)
 {
 	for (;*i < ARRAY_SIZE(erofs_algs); ++*i) {
 		if (!erofs_algs[*i].c)
 			continue;
-		return erofs_algs[(*i)++].name;
+		return &erofs_algs[(*i)++];
 	}
 	return NULL;
 }
diff --git a/lib/compressor.h b/lib/compressor.h
index 9fa01d1..db848f1 100644
--- a/lib/compressor.h
+++ b/lib/compressor.h
@@ -24,7 +24,14 @@ struct erofs_compressor {
 				 void *dst, unsigned int dstsize);
 };
 
-struct erofs_algorithm;
+struct erofs_algorithm {
+	char *name;
+	const struct erofs_compressor *c;
+	unsigned int id;
+
+	/* its name won't be shown as a supported algorithm */
+	bool optimisor;
+};
 
 struct erofs_compress {
 	struct erofs_sb_info *sbi;
diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index 970ff28..45be11a 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -21,10 +21,12 @@ from \fISOURCE\fR directory.
 .SH OPTIONS
 .TP
 .BI "\-z " compression-algorithm \fR[\fP, # \fR][\fP: ... \fR]\fP
-Set a primary algorithm for data compression, which can be set with an optional
-compression level (1 to 12 for LZ4HC, 0 to 9 for LZMA and 100 to 109 for LZMA
-extreme compression) separated by a comma.  Alternative algorithms could be
-specified and separated by colons.
+Set a primary algorithm for data compression, which can be set with an
+optional compression level. Alternative algorithms could be specified
+and separated by colons.  See the output of
+.B mkfs.erofs \-\-help
+for a listing of the algorithms that \fBmkfs.erofs\fR is compiled with
+and what their respective level ranges are.
 .TP
 .BI "\-b " block-size
 Set the fundamental block size of the filesystem in bytes.  In other words,
diff --git a/mkfs/main.c b/mkfs/main.c
index d86a548..f024026 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -30,6 +30,7 @@
 #include "erofs/rebuild.h"
 #include "../lib/liberofs_private.h"
 #include "../lib/liberofs_uuid.h"
+#include "../lib/compressor.h"
 
 #define EROFS_SUPER_END (EROFS_SUPER_OFFSET + sizeof(struct erofs_super_block))
 
@@ -77,75 +78,104 @@ static void print_available_compressors(FILE *f, const char *delim)
 {
 	int i = 0;
 	bool comma = false;
-	const char *s;
+	const struct erofs_algorithm *s;
 
 	while ((s = z_erofs_list_available_compressors(&i)) != NULL) {
 		if (comma)
 			fputs(delim, f);
-		fputs(s, f);
+		fputs(s->name, f);
 		comma = true;
 	}
 	fputc('\n', f);
 }
 
-static void usage(void)
+static void usage(int argc, char **argv)
 {
-	fputs("usage: [options] FILE SOURCE(s)\n"
-	      "Generate EROFS image (FILE) from DIRECTORY, TARBALL and/or EROFS images.  And [options] are:\n"
-	      " -V, --version         print the version number of mkfs.erofs and exit\n"
-	      " -b#                   set block size to # (# = page size by default)\n"
-	      " -d#                   set output message level to # (maximum 9)\n"
-	      " -x#                   set xattr tolerance to # (< 0, disable xattrs; default 2)\n"
-	      " -zX[,Y][:..]          X=compressor (Y=compression level, optional)\n"
-	      "                       alternative algorithms can be separated by colons(:)\n"
-	      " -C#                   specify the size of compress physical cluster in bytes\n"
-	      " -EX[,...]             X=extended options\n"
-	      " -L volume-label       set the volume label (maximum 16)\n"
-	      " -T#                   set a fixed UNIX timestamp # to all files\n"
-	      " -UX                   use a given filesystem UUID\n"
-	      " --all-root            make all files owned by root\n"
-	      " --blobdev=X           specify an extra device X to store chunked data\n"
-	      " --chunksize=#         generate chunk-based files with #-byte chunks\n"
-	      " --compress-hints=X    specify a file to configure per-file compression strategy\n"
-	      " --exclude-path=X      avoid including file X (X = exact literal path)\n"
-	      " --exclude-regex=X     avoid including files that match X (X = regular expression)\n"
+	int i = 0;
+	const struct erofs_algorithm *s;
+
+	//	"         1         2         3         4         5         6         7         8  "
+	//	"12345678901234567890123456789012345678901234567890123456789012345678901234567890\n"
+	printf(
+		"Usage: %s [OPTIONS] FILE SOURCE(s)\n"
+		"Generate EROFS image (FILE) from SOURCE(s).\n"
+		"\n"
+		"General options:\n"
+		" -V, --version         print the version number of mkfs.erofs and exit\n"
+		" -h, --help            display this help and exit\n"
+		"\n"
+		" -b#                   set block size to # (# = page size by default)\n"
+		" -d<0-9>               set output verbosity; 0=quiet, 9=verbose (default=%i)\n"
+		" -x#                   set xattr tolerance to # (< 0, disable xattrs; default 2)\n"
+		" -zX[,Y][:...]         X=compressor (Y=compression level, optional)\n"
+		"                       alternative compressors can be separated by colons(:)\n"
+		"                       supported compressors and their level ranges are:\n",
+		argv[0], EROFS_WARN);
+	while ((s = z_erofs_list_available_compressors(&i)) != NULL) {
+		printf("                           %s", s->name);
+		if (s->c->setlevel) {
+			if (!strcmp(s->name, "lzma"))
+				/* A little kludge to show the range as disjointed
+				 * "0-9,100-109" instead of a continuous "0-109", and to
+				 * state what those two subranges respectively mean.  */
+				printf("[<0-9,100-109>]\t0-9=normal, 100-109=extreme (default=%i)",
+				       s->c->default_level);
+			else
+				printf("[,<0-%i>]\t(default=%i)",
+				       s->c->best_level, s->c->default_level);
+		}
+		putchar('\n');
+	}
+	printf(
+		" -C#                   specify the size of compress physical cluster in bytes\n"
+		" -EX[,...]             X=extended options\n"
+		" -L volume-label       set the volume label (maximum 16)\n"
+		" -T#                   set a fixed UNIX timestamp # to all files\n"
+		" -UX                   use a given filesystem UUID\n"
+		" --all-root            make all files owned by root\n"
+		" --blobdev=X           specify an extra device X to store chunked data\n"
+		" --chunksize=#         generate chunk-based files with #-byte chunks\n"
+		" --compress-hints=X    specify a file to configure per-file compression strategy\n"
+		" --exclude-path=X      avoid including file X (X = exact literal path)\n"
+		" --exclude-regex=X     avoid including files that match X (X = regular expression)\n"
 #ifdef HAVE_LIBSELINUX
-	      " --file-contexts=X     specify a file contexts file to setup selinux labels\n"
+		" --file-contexts=X     specify a file contexts file to setup selinux labels\n"
 #endif
-	      " --force-uid=#         set all file uids to # (# = UID)\n"
-	      " --force-gid=#         set all file gids to # (# = GID)\n"
-	      " --uid-offset=#        add offset # to all file uids (# = id offset)\n"
-	      " --gid-offset=#        add offset # to all file gids (# = id offset)\n"
+		" --force-uid=#         set all file uids to # (# = UID)\n"
+		" --force-gid=#         set all file gids to # (# = GID)\n"
+		" --uid-offset=#        add offset # to all file uids (# = id offset)\n"
+		" --gid-offset=#        add offset # to all file gids (# = id offset)\n"
 #ifdef HAVE_ZLIB
-	      " --gzip                try to filter the tarball stream through gzip\n"
+		" --gzip                try to filter the tarball stream through gzip\n"
 #endif
-	      " -h, --help            display this help and exit\n"
-	      " --ignore-mtime        use build time instead of strict per-file modification time\n"
-	      " --max-extent-bytes=#  set maximum decompressed extent size # in bytes\n"
-	      " --preserve-mtime      keep per-file modification time strictly\n"
-	      " --aufs                replace aufs special files with overlayfs metadata\n"
-	      " --tar=[fi]            generate an image from tarball(s)\n"
-	      " --ovlfs-strip=[01]    strip overlayfs metadata in the target image (e.g. whiteouts)\n"
-	      " --quiet               quiet execution (do not write anything to standard output.)\n"
+		" --ignore-mtime        use build time instead of strict per-file modification time\n"
+		" --max-extent-bytes=#  set maximum decompressed extent size # in bytes\n"
+		" --preserve-mtime      keep per-file modification time strictly\n"
+		" --aufs                replace aufs special files with overlayfs metadata\n"
+		" --tar=[fi]            generate an image from tarball(s)\n"
+		" --ovlfs-strip=<0,1>   strip overlayfs metadata in the target image (e.g. whiteouts)\n"
+		" --quiet               quiet execution (do not write anything to standard output.)\n"
 #ifndef NDEBUG
-	      " --random-pclusterblks randomize pclusterblks for big pcluster (debugging only)\n"
-	      " --random-algorithms   randomize per-file algorithms (debugging only)\n"
+		" --random-pclusterblks randomize pclusterblks for big pcluster (debugging only)\n"
+		" --random-algorithms   randomize per-file algorithms (debugging only)\n"
 #endif
-	      " --xattr-prefix=X      X=extra xattr name prefix\n"
-	      " --mount-point=X       X=prefix of target fs path (default: /)\n"
+		" --xattr-prefix=X      X=extra xattr name prefix\n"
+		" --mount-point=X       X=prefix of target fs path (default: /)\n"
 #ifdef WITH_ANDROID
-	      "\nwith following android-specific options:\n"
-	      " --product-out=X       X=product_out directory\n"
-	      " --fs-config-file=X    X=fs_config file\n"
-	      " --block-list-file=X   X=block_list file\n"
+		"\n"
+		"Android-specific options:\n"
+		" --product-out=X       X=product_out directory\n"
+		" --fs-config-file=X    X=fs_config file\n"
+		" --block-list-file=X   X=block_list file\n"
 #endif
-	      "\nAvailable compressors are: ", stderr);
-	print_available_compressors(stderr, ", ");
+		);
 }
 
 static void version(void)
 {
-	printf("mkfs.erofs %s\n", cfg.c_version);
+	printf("mkfs.erofs (eorfs-utils) %s\navailable compressors: ",
+	       cfg.c_version);
+	print_available_compressors(stdout, ", ");
 }
 
 static unsigned int pclustersize_packed, pclustersize_max;
@@ -545,7 +575,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			version();
 			exit(0);
 		case 'h':
-			usage();
+			usage(argc, argv);
 			exit(0);
 
 		default: /* '?' */
@@ -947,13 +977,13 @@ int main(int argc, char **argv)
 	erofs_show_progs(argc, argv);
 	if (err) {
 		if (err == -EINVAL)
-			usage();
+			fprintf(stderr, "Try '%s --help' for more information.\n", argv[0]);
 		return 1;
 	}
 
 	err = parse_source_date_epoch();
 	if (err) {
-		usage();
+		fprintf(stderr, "Try '%s --help' for more information.\n", argv[0]);
 		return 1;
 	}
 
@@ -967,7 +997,7 @@ int main(int argc, char **argv)
 
 	err = dev_open(&sbi, cfg.c_img_path);
 	if (err) {
-		usage();
+		fprintf(stderr, "Try '%s --help' for more information.\n", argv[0]);
 		return 1;
 	}
 
-- 
2.42.0

