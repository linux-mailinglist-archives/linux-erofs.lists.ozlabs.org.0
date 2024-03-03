Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5E386F58B
	for <lists+linux-erofs@lfdr.de>; Sun,  3 Mar 2024 15:36:03 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=s/+tSpfj;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TnksC0l56z3ckj
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Mar 2024 01:35:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=s/+tSpfj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tnks064bCz3cGW
	for <linux-erofs@lists.ozlabs.org>; Mon,  4 Mar 2024 01:35:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709476541; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=blQrToBNviqI0stU/ufd4E6rD3BqBW0rIRx5JByz6E4=;
	b=s/+tSpfjXT5tVvFkyp/wRodz/LnMueKlrbhGlEhaYNKlg5bco0MUqKf2KAgtG9HIwLHDuKCPjwYearvzrfDyzzLUD6m3Jn3rDUkQgsVGHt7GPmTajRHmyZDhKVf3nooesqQSsH8fblIMK3S7ZkT5MaOFUQpEKnDyGfWpsB+rHSk=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W1gr.kn_1709476531;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W1gr.kn_1709476531)
          by smtp.aliyun-inc.com;
          Sun, 03 Mar 2024 22:35:39 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: support xz/lzma/lzip streams for tarerofs
Date: Sun,  3 Mar 2024 22:35:30 +0800
Message-Id: <20240303143530.4077607-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Similar to commit e3dfe4b8db26 ("erofs-utils: mkfs: support tgz streams
for tarerofs"), let's add xz/lzma/lzip support by using liblzma.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/tar.h | 13 ++++++++++
 lib/tar.c           | 58 ++++++++++++++++++++++++++++++++++++++++++++-
 man/mkfs.erofs.1    | 12 ++++++----
 mkfs/main.c         | 42 ++++++++++++++++++++------------
 4 files changed, 105 insertions(+), 20 deletions(-)

diff --git a/include/erofs/tar.h b/include/erofs/tar.h
index e45b895..b5c966b 100644
--- a/include/erofs/tar.h
+++ b/include/erofs/tar.h
@@ -26,11 +26,24 @@ struct erofs_pax_header {
 
 #define EROFS_IOS_DECODER_NONE		0
 #define EROFS_IOS_DECODER_GZIP		1
+#define EROFS_IOS_DECODER_LIBLZMA	2
+
+#ifdef HAVE_LIBLZMA
+#include <lzma.h>
+struct erofs_iostream_liblzma {
+	u8 inbuf[32768];
+	lzma_stream strm;
+	int fd;
+};
+#endif
 
 struct erofs_iostream {
 	union {
 		int fd;			/* original fd */
 		void *handler;
+#ifdef HAVE_LIBLZMA
+		struct erofs_iostream_liblzma *lzma;
+#endif
 	};
 	u64 sz;
 	char *buffer;
diff --git a/lib/tar.c b/lib/tar.c
index 7c14c06..fcccd1f 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -70,6 +70,13 @@ void erofs_iostream_close(struct erofs_iostream *ios)
 	if (ios->decoder == EROFS_IOS_DECODER_GZIP) {
 #if defined(HAVE_ZLIB)
 		gzclose(ios->handler);
+#endif
+		return;
+	} else if (ios->decoder == EROFS_IOS_DECODER_LIBLZMA) {
+#if defined(HAVE_LIBLZMA)
+		lzma_end(&ios->lzma->strm);
+		close(ios->lzma->fd);
+		free(ios->lzma);
 #endif
 		return;
 	}
@@ -80,6 +87,7 @@ int erofs_iostream_open(struct erofs_iostream *ios, int fd, int decoder)
 {
 	s64 fsz;
 
+	ios->feof = false;
 	ios->tail = ios->head = 0;
 	ios->decoder = decoder;
 	ios->dumpfd = -1;
@@ -92,6 +100,24 @@ int erofs_iostream_open(struct erofs_iostream *ios, int fd, int decoder)
 		ios->bufsize = 32768;
 #else
 		return -EOPNOTSUPP;
+#endif
+	} else if (decoder == EROFS_IOS_DECODER_LIBLZMA) {
+#ifdef HAVE_LIBLZMA
+		lzma_ret ret;
+
+		ios->lzma = malloc(sizeof(*ios->lzma));
+		if (!ios->lzma)
+			return -ENOMEM;
+		ios->lzma->fd = fd;
+		ios->lzma->strm = (lzma_stream)LZMA_STREAM_INIT;
+		ret = lzma_auto_decoder(&ios->lzma->strm,
+					UINT64_MAX, LZMA_CONCATENATED);
+		if (ret != LZMA_OK)
+			return -EFAULT;
+		ios->sz = fsz = 0;
+		ios->bufsize = 32768;
+#else
+		return -EOPNOTSUPP;
 #endif
 	} else {
 		ios->fd = fd;
@@ -100,7 +126,6 @@ int erofs_iostream_open(struct erofs_iostream *ios, int fd, int decoder)
 			ios->feof = !fsz;
 			ios->sz = 0;
 		} else {
-			ios->feof = false;
 			ios->sz = fsz;
 			if (lseek(fd, 0, SEEK_SET))
 				return -EIO;
@@ -161,6 +186,37 @@ int erofs_iostream_read(struct erofs_iostream *ios, void **buf, u64 bytes)
 			ios->tail += ret;
 #else
 			return -EOPNOTSUPP;
+#endif
+		} else if (ios->decoder == EROFS_IOS_DECODER_LIBLZMA) {
+#ifdef HAVE_LIBLZMA
+			struct erofs_iostream_liblzma *lzma = ios->lzma;
+			lzma_action action = LZMA_RUN;
+			lzma_ret ret2;
+
+			if (!lzma->strm.avail_in) {
+				lzma->strm.next_in = lzma->inbuf;
+				ret = read(lzma->fd, lzma->inbuf,
+					   sizeof(lzma->inbuf));
+				if (ret < 0)
+					return -errno;
+				lzma->strm.avail_in = ret;
+				if (ret < sizeof(lzma->inbuf))
+					action = LZMA_FINISH;
+			}
+			lzma->strm.next_out = (u8 *)ios->buffer + rabytes;
+			lzma->strm.avail_out = ios->bufsize - rabytes;
+
+			ret2 = lzma_code(&lzma->strm, action);
+			if (ret2 != LZMA_OK) {
+				if (ret2 == LZMA_STREAM_END)
+					ios->feof = true;
+				else
+					return -EIO;
+			}
+			ios->tail += ios->bufsize - rabytes -
+					lzma->strm.avail_out;
+#else
+			return -EOPNOTSUPP;
 #endif
 		} else {
 			ret = erofs_read_from_fd(ios->fd, ios->buffer + rabytes,
diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index 41eb5fb..3bff41d 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -162,10 +162,6 @@ When this option is used together with
 the final file gids are
 set to \fIGID\fR + \fIGID-OFFSET\fR.
 .TP
-.BI \-\-ungzip\fR[\fP= file \fR]\fP
-Filter tarball streams through gzip. Optionally, raw streams can be dumped
-together.
-.TP
 \fB\-V\fR, \fB\-\-version\fR
 Print the version number and exit.
 .TP
@@ -210,6 +206,14 @@ When this option is used together with
 the final file uids are
 set to \fIUID\fR + \fIUIDOFFSET\fR.
 .TP
+.BI \-\-ungzip\fR[\fP= file \fR]\fP
+Filter tarball streams through gzip. Optionally, raw streams can be dumped
+together.
+.TP
+.BI \-\-unxz\fR[\fP= file \fR]\fP
+Filter tarball streams through xz, lzma, or lzip. Optionally, raw streams can
+be dumped together.
+.TP
 .BI "\-\-xattr-prefix=" PREFIX
 Specify a customized extended attribute namespace prefix for space saving,
 e.g. "trusted.overlay.".  You may give multiple
diff --git a/mkfs/main.c b/mkfs/main.c
index 258c1ce..8a68a72 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -69,11 +69,15 @@ static struct option long_options[] = {
 	{"block-list-file", required_argument, NULL, 515},
 #endif
 	{"ovlfs-strip", optional_argument, NULL, 516},
+	{"offset", required_argument, NULL, 517},
 #ifdef HAVE_ZLIB
-	{"gzip", no_argument, NULL, 517},
-	{"ungzip", optional_argument, NULL, 517},
+	{"gzip", no_argument, NULL, 518},
+	{"ungzip", optional_argument, NULL, 518},
+#endif
+#ifdef HAVE_LIBLZMA
+	{"unlzma", optional_argument, NULL, 519},
+	{"unxz", optional_argument, NULL, 519},
 #endif
-	{"offset", required_argument, NULL, 518},
 	{0, 0, 0, 0},
 };
 
@@ -153,10 +157,6 @@ static void usage(int argc, char **argv)
 		" --force-gid=#         set all file gids to # (# = GID)\n"
 		" --uid-offset=#        add offset # to all file uids (# = id offset)\n"
 		" --gid-offset=#        add offset # to all file gids (# = id offset)\n"
-#ifdef HAVE_ZLIB
-		" --ungzip[=X]          try to filter the tarball stream through gzip\n"
-		"                       (and optionally dump the raw stream to X together)\n"
-#endif
 		" --ignore-mtime        use build time instead of strict per-file modification time\n"
 		" --max-extent-bytes=#  set maximum decompressed extent size # in bytes\n"
 		" --preserve-mtime      keep per-file modification time strictly\n"
@@ -170,6 +170,14 @@ static void usage(int argc, char **argv)
 #ifndef NDEBUG
 		" --random-pclusterblks randomize pclusterblks for big pcluster (debugging only)\n"
 		" --random-algorithms   randomize per-file algorithms (debugging only)\n"
+#endif
+#ifdef HAVE_ZLIB
+		" --ungzip[=X]          try to filter the tarball stream through gzip\n"
+		"                       (and optionally dump the raw stream to X together)\n"
+#endif
+#ifdef HAVE_LIBLZMA
+		" --unxz[=X]            try to filter the tarball stream through xz/lzma/lzip\n"
+		"                       (and optionally dump the raw stream to X together)\n"
 #endif
 		" --xattr-prefix=X      X=extra xattr name prefix\n"
 		" --mount-point=X       X=prefix of target fs path (default: /)\n"
@@ -194,7 +202,7 @@ static unsigned int pclustersize_packed, pclustersize_max;
 static struct erofs_tarfile erofstar = {
 	.global.xattrs = LIST_HEAD_INIT(erofstar.global.xattrs)
 };
-static bool tar_mode, rebuild_mode, gzip_supported;
+static bool tar_mode, rebuild_mode;
 
 static unsigned int rebuild_src_count;
 static LIST_HEAD(rebuild_src_list);
@@ -413,6 +421,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 	char *endptr;
 	int opt, i, err;
 	bool quiet = false;
+	int tarerofs_decoder = 0;
 
 	while ((opt = getopt_long(argc, argv, "C:E:L:T:U:b:d:x:z:Vh",
 				  long_options, NULL)) != -1) {
@@ -639,17 +648,18 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				cfg.c_ovlfs_strip = false;
 			break;
 		case 517:
-			if (optarg)
-				erofstar.dumpfile = strdup(optarg);
-			gzip_supported = true;
-			break;
-		case 518:
 			sbi.diskoffset = strtoull(optarg, &endptr, 0);
 			if (*endptr != '\0') {
 				erofs_err("invalid disk offset %s", optarg);
 				return -EINVAL;
 			}
 			break;
+		case 518:
+		case 519:
+			if (optarg)
+				erofstar.dumpfile = strdup(optarg);
+			tarerofs_decoder = EROFS_IOS_DECODER_GZIP + (opt - 518);
+			break;
 		case 'V':
 			version();
 			exit(0);
@@ -696,7 +706,8 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 					  strerror(errno));
 				return -errno;
 			}
-			err = erofs_iostream_open(&erofstar.ios, dupfd, gzip_supported);
+			err = erofs_iostream_open(&erofstar.ios, dupfd,
+						  tarerofs_decoder);
 			if (err)
 				return err;
 		}
@@ -717,7 +728,8 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				erofs_err("failed to open file: %s", cfg.c_src_path);
 				return -errno;
 			}
-			err = erofs_iostream_open(&erofstar.ios, fd, gzip_supported);
+			err = erofs_iostream_open(&erofstar.ios, fd,
+						  tarerofs_decoder);
 			if (err)
 				return err;
 
-- 
2.39.3

