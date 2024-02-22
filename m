Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B6A85F3C9
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Feb 2024 10:02:08 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=P3ZQ9o3C;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TgRwZ4zKLz3dRs
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Feb 2024 20:02:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=P3ZQ9o3C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TgRwT2Xdpz3bWn
	for <linux-erofs@lists.ozlabs.org>; Thu, 22 Feb 2024 20:02:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708592516; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=+Kp/ppKdKHawq1pjCTtQyzibd9Z+NTy2DuJTpZAOcIM=;
	b=P3ZQ9o3Cc3gpaKYQk6JHT30oikNXAfTcxcmH0rkFL2y3yu6VPCLUg5VjiRwFs8xwhDlAv7jJlsdlEt+KCbfnpGJJmrTJMdgWX68DpTSeNo0F4cBGgww5HswUV8WDvdD/299hjQKyA5kYYFvvHvC5kW0f+aFQCdFGDEDKPkx+SnI=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W10Xego_1708592506;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W10Xego_1708592506)
          by smtp.aliyun-inc.com;
          Thu, 22 Feb 2024 17:01:54 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: support dumping raw tar streams together
Date: Thu, 22 Feb 2024 17:01:45 +0800
Message-Id: <20240222090145.709808-1-hsiangkao@linux.alibaba.com>
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

Since commit e3dfe4b8db26 ("erofs-utils: mkfs: support tgz streams for
tarerofs"), tgz streams can be converted to EROFS directly.

However, many use cases also require raw tar streams.  Let's add
support for dumping raw streams with `--ungzip=FILE` option.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/tar.h |  4 ++--
 lib/tar.c           |  7 ++++++-
 man/mkfs.erofs.1    |  5 +++--
 mkfs/main.c         | 20 ++++++++++++++++++--
 4 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/include/erofs/tar.h b/include/erofs/tar.h
index a76f740..be03d1b 100644
--- a/include/erofs/tar.h
+++ b/include/erofs/tar.h
@@ -35,14 +35,14 @@ struct erofs_iostream {
 	u64 sz;
 	char *buffer;
 	unsigned int head, tail, bufsize;
-	int decoder;
+	int decoder, dumpfd;
 	bool feof;
 };
 
 struct erofs_tarfile {
 	struct erofs_pax_header global;
 	struct erofs_iostream ios;
-	char *mapfile;
+	char *mapfile, *dumpfile;
 
 	int fd;
 	u64 offset;
diff --git a/lib/tar.c b/lib/tar.c
index ead74ba..1d764b2 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -82,6 +82,7 @@ int erofs_iostream_open(struct erofs_iostream *ios, int fd, int decoder)
 
 	ios->tail = ios->head = 0;
 	ios->decoder = decoder;
+	ios->dumpfd = -1;
 	if (decoder == EROFS_IOS_DECODER_GZIP) {
 #if defined(HAVE_ZLIB)
 		ios->handler = gzdopen(fd, "r");
@@ -170,6 +171,10 @@ int erofs_iostream_read(struct erofs_iostream *ios, void **buf, u64 bytes)
 			if (ret < ios->bufsize - rabytes)
 				ios->feof = true;
 		}
+		if (unlikely(ios->dumpfd >= 0))
+			if (write(ios->dumpfd, ios->buffer + rabytes, ret) < ret)
+				erofs_err("failed to dump %d bytes of the raw stream: %s",
+					  ret, erofs_strerror(-errno));
 	}
 	*buf = ios->buffer;
 	ret = min_t(int, ios->tail, bytes);
@@ -210,7 +215,7 @@ int erofs_iostream_lskip(struct erofs_iostream *ios, u64 sz)
 	if (ios->feof)
 		return sz;
 
-	if (ios->sz) {
+	if (ios->sz && likely(ios->dumpfd < 0)) {
 		s64 cur = lseek(ios->fd, sz, SEEK_CUR);
 
 		if (cur > ios->sz)
diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index 45be11a..f32dc26 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -162,8 +162,9 @@ When this option is used together with
 the final file gids are
 set to \fIGID\fR + \fIGID-OFFSET\fR.
 .TP
-.B \-\-gzip
-Filter tarball streams through gzip.
+.BI \-\-ungzip\fR[\fP= file \fR]\fP
+Filter tarball streams through gzip. Optionally, raw streams can be dumped
+together.
 .TP
 \fB\-V\fR, \fB\-\-version\fR
 Print the version number and exit.
diff --git a/mkfs/main.c b/mkfs/main.c
index 7aea64a..75b80ab 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -71,6 +71,7 @@ static struct option long_options[] = {
 	{"ovlfs-strip", optional_argument, NULL, 516},
 #ifdef HAVE_ZLIB
 	{"gzip", no_argument, NULL, 517},
+	{"ungzip", optional_argument, NULL, 517},
 #endif
 	{"offset", required_argument, NULL, 518},
 	{0, 0, 0, 0},
@@ -153,7 +154,8 @@ static void usage(int argc, char **argv)
 		" --uid-offset=#        add offset # to all file uids (# = id offset)\n"
 		" --gid-offset=#        add offset # to all file gids (# = id offset)\n"
 #ifdef HAVE_ZLIB
-		" --gzip                try to filter the tarball stream through gzip\n"
+		" --ungzip[=X]          try to filter the tarball stream through gzip\n"
+		"                       (and optionally dump the raw stream to X together)\n"
 #endif
 		" --ignore-mtime        use build time instead of strict per-file modification time\n"
 		" --max-extent-bytes=#  set maximum decompressed extent size # in bytes\n"
@@ -633,6 +635,8 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				cfg.c_ovlfs_strip = false;
 			break;
 		case 517:
+			if (optarg)
+				erofstar.dumpfile = strdup(optarg);
 			gzip_supported = true;
 			break;
 		case 518:
@@ -712,6 +716,15 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			err = erofs_iostream_open(&erofstar.ios, fd, gzip_supported);
 			if (err)
 				return err;
+
+			fd = open(erofstar.dumpfile,
+				  O_WRONLY | O_CREAT | O_TRUNC, 0644);
+			if (fd < 0) {
+				erofs_err("failed to open dumpfile: %s",
+					  erofstar.dumpfile);
+				return -errno;
+			}
+			erofstar.ios.dumpfd = fd;
 		} else {
 			err = lstat(cfg.c_src_path, &st);
 			if (err)
@@ -1315,8 +1328,11 @@ exit:
 	erofs_rebuild_cleanup();
 	erofs_diskbuf_exit();
 	erofs_exit_configure();
-	if (tar_mode)
+	if (tar_mode) {
 		erofs_iostream_close(&erofstar.ios);
+		if (erofstar.ios.dumpfd >= 0)
+			close(erofstar.ios.dumpfd);
+	}
 
 	if (err) {
 		erofs_err("\tCould not format the device : %s\n",
-- 
2.39.3

