Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DA323868AF9
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Feb 2024 09:42:42 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VgL8rYEk;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TkWFr2zXdz3d3W
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Feb 2024 19:42:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VgL8rYEk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TkWFl1Nz8z30h8
	for <linux-erofs@lists.ozlabs.org>; Tue, 27 Feb 2024 19:42:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709023349; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=035NIOoiUNeYyHYvFRTUEdSkYo5AVa/T+t0yEy6j3Wc=;
	b=VgL8rYEkD/HUpqoMBZfF3X5RomV5/WYIqZQW6UsPg3ZcMlrtznje15cmQWGZm1d586QIbj8WciLEIGMh7oSUgp+emglh/Ss586SAvqOZSLihBtlABqFpFAluslaqB+vzcWj+0IduyVssQ8CudTpa6UtlLyxR1yaxejVd4ma7P6Q=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W1MCR1g_1709023343;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W1MCR1g_1709023343)
          by smtp.aliyun-inc.com;
          Tue, 27 Feb 2024 16:42:27 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Mike Baynton <mike@mbaynton.com>
Subject: [PATCH v2] erofs-utils: mkfs: Support tar source without data
Date: Tue, 27 Feb 2024 16:42:21 +0800
Message-Id: <20240227084221.342635-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20359e03-f7aa-4531-b0d1-b76e9950f233@linux.alibaba.com>
References: <20359e03-f7aa-4531-b0d1-b76e9950f233@linux.alibaba.com>
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

From: Mike Baynton <mike@mbaynton.com>

This improves performance of meta-only image creation in cases where the
source is a tarball stream that is not seekable. The writer may now use
`--tar=headerball` and omit the file data. Previously, the stream writer
was forced to send the file's size worth of null bytes or any data after
each tar header which was simply discarded by mkfs.erofs.

Signed-off-by: Mike Baynton <mike@mbaynton.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---

Hi Mike,
  Just some minor changes for applying to -dev development codebase.
Does it look good to you?
  (I will apply this version to -experimental for testing.)

 include/erofs/tar.h |  2 +-
 lib/tar.c           |  2 +-
 man/mkfs.erofs.1    | 23 +++++++++++++++++------
 mkfs/main.c         |  9 +++++++--
 4 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/include/erofs/tar.h b/include/erofs/tar.h
index be03d1b..e45b895 100644
--- a/include/erofs/tar.h
+++ b/include/erofs/tar.h
@@ -46,7 +46,7 @@ struct erofs_tarfile {
 
 	int fd;
 	u64 offset;
-	bool index_mode, aufs;
+	bool index_mode, headeronly_mode, aufs;
 };
 
 void erofs_iostream_close(struct erofs_iostream *ios);
diff --git a/lib/tar.c b/lib/tar.c
index 1d764b2..7c14c06 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -589,7 +589,7 @@ static int tarerofs_write_file_index(struct erofs_inode *inode,
 	ret = tarerofs_write_chunkes(inode, data_offset);
 	if (ret)
 		return ret;
-	if (erofs_iostream_lskip(&tar->ios, inode->i_size))
+	if (!tar->headeronly_mode && erofs_iostream_lskip(&tar->ios, inode->i_size))
 		return -EIO;
 	return 0;
 }
diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index f32dc26..41eb5fb 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -17,7 +17,7 @@ achieve high performance for embedded devices with limited memory since it has
 unnoticable memory overhead and page cache thrashing.
 .PP
 mkfs.erofs is used to create such EROFS filesystem \fIDESTINATION\fR image file
-from \fISOURCE\fR directory.
+from \fISOURCE\fR directory or tarball.
 .SH OPTIONS
 .TP
 .BI "\-z " compression-algorithm \fR[\fP, # \fR][\fP: ... \fR]\fP
@@ -186,11 +186,22 @@ Use extended inodes instead of compact inodes if the file modification time
 would overflow compact inodes. This is the default. Overrides
 .BR --ignore-mtime .
 .TP
-.B "\-\-tar=f"
-Generate a full EROFS image from a tarball.
-.TP
-.B "\-\-tar=i"
-Generate an meta-only EROFS image from a tarball.
+.BI "\-\-tar, \-\-tar="MODE
+Treat \fISOURCE\fR as a tarball or tarball-like "headerball" rather than as a
+directory.
+
+\fIMODE\fR may be one of \fBf\fR, \fBi\fR, or \fBheaderball\fR.
+
+\fBf\fR: Generate a full EROFS image from a regular tarball. (default)
+
+\fBi\fR: Generate a meta-only EROFS image from a regular tarball. Only
+metadata such as dentries, inodes, and xattrs will be added to the image,
+without file data. Uses for such images include as a layer in an overlay
+filesystem with other data-only layers.
+
+\fBheaderball\fR: Generate a meta-only EROFS image from a stream identical
+to a tarball except that file data is not present after each file header.
+It can improve performance especially when \fISOURCE\fR is not seekable.
 .TP
 .BI "\-\-uid-offset=" UIDOFFSET
 Add \fIUIDOFFSET\fR to all file UIDs.
diff --git a/mkfs/main.c b/mkfs/main.c
index 3191b89..c62d202 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -162,6 +162,9 @@ static void usage(int argc, char **argv)
 		" --preserve-mtime      keep per-file modification time strictly\n"
 		" --offset=#            skip # bytes at the beginning of IMAGE.\n"
 		" --aufs                replace aufs special files with overlayfs metadata\n"
+		" --tar=X               generate a full or index-only image from a tarball(-ish) source\n"
+		"                       (X = f|i|headerball; f=full mode, i=index mode,\n"
+		"                                            headerball=file data is omited in the source stream)\n"
 		" --tar=[fi]            generate an image from tarball(s)\n"
 		" --ovlfs-strip=<0,1>   strip overlayfs metadata in the target image (e.g. whiteouts)\n"
 		" --quiet               quiet execution (do not write anything to standard output.)\n"
@@ -617,11 +620,13 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			cfg.c_extra_ea_name_prefixes = true;
 			break;
 		case 20:
-			if (optarg && (!strcmp(optarg, "i") ||
-				!strcmp(optarg, "0") || !memcmp(optarg, "0,", 2))) {
+			if (optarg && (!strcmp(optarg, "i") || (!strcmp(optarg, "headerball") ||
+				!strcmp(optarg, "0") || !memcmp(optarg, "0,", 2)))) {
 				erofstar.index_mode = true;
 				if (!memcmp(optarg, "0,", 2))
 					erofstar.mapfile = strdup(optarg + 2);
+				if (!strcmp(optarg, "headerball"))
+					erofstar.headeronly_mode = true;
 			}
 			tar_mode = true;
 			break;
-- 
2.39.3

