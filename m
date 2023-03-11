Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C806B5824
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Mar 2023 05:13:06 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PYTzf6zR1z3cdH
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Mar 2023 15:13:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PYTzZ4kc5z3c6Y
	for <linux-erofs@lists.ozlabs.org>; Sat, 11 Mar 2023 15:12:57 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VdZEHmR_1678507966;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VdZEHmR_1678507966)
          by smtp.aliyun-inc.com;
          Sat, 11 Mar 2023 12:12:51 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: add missing help for multiple algorithms
Date: Sat, 11 Mar 2023 12:12:45 +0800
Message-Id: <20230311041245.27006-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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

Users can try this with the detailed instructions.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 docs/compress-hints.example |  7 +++++++
 man/mkfs.erofs.1            | 13 ++++++++-----
 mkfs/main.c                 |  3 ++-
 3 files changed, 17 insertions(+), 6 deletions(-)
 create mode 100644 docs/compress-hints.example

diff --git a/docs/compress-hints.example b/docs/compress-hints.example
new file mode 100644
index 0000000..4f481ff
--- /dev/null
+++ b/docs/compress-hints.example
@@ -0,0 +1,7 @@
+# https://github.com/debuerreotype/docker-debian-artifacts/blob/dist-amd64/bullseye/rootfs.tar.xz?raw=true
+# -zlzma:lz4hc,12:lzma,109 -C131072 --compress-hints=compress-hints.example  image size: 66M
+# -zlz4hc,12                                                                 image size: 76M
+4096     1 .*\.so.*$
+4096     1 bin/
+4096     1 sbin/
+131072   2 etc/
diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index e237877..82ef138 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -20,10 +20,11 @@ mkfs.erofs is used to create such EROFS filesystem \fIDESTINATION\fR image file
 from \fISOURCE\fR directory.
 .SH OPTIONS
 .TP
-.BI "\-z " compression-algorithm " [" ",#" "]"
-Set an algorithm for file compression, which can be set with an optional
+.BI "\-z " compression-algorithm " [" ",#" "]" " [:" " ... " "]"
+Set a primary algorithm for data compression, which can be set with an optional
 compression level (1 to 12 for LZ4HC, 0 to 9 for LZMA and 100 to 109 for LZMA
-extreme compression) separated by a comma.
+extreme compression) separated by a comma.  Alternative algorithms could be
+specified and separated by colons.
 .TP
 .BI "\-C " max-pcluster-size
 Specify the maximum size of compress physical cluster in bytes. It may enable
@@ -112,9 +113,11 @@ If the optional
 argument is given,
 .B mkfs.erofs
 uses it to apply the per-file compression strategy. Each line is defined by
-tokens separated by spaces in the following form:
+tokens separated by spaces in the following form.  Optionally, instead of
+the given primary algorithm, alternative algorithms could be specified with
+\fIalgorithm-index\fR by hand:
 .RS 1.2i
-<pcluster-in-bytes> <match-pattern>
+<pcluster-in-bytes> [algorithm-index] <match-pattern>
 .RE
 .TP
 .BI "\-\-exclude-path=" path
diff --git a/mkfs/main.c b/mkfs/main.c
index a3b0c34..94f51df 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -84,7 +84,8 @@ static void usage(void)
 	      "Generate erofs image from DIRECTORY to FILE, and [options] are:\n"
 	      " -d#                   set output message level to # (maximum 9)\n"
 	      " -x#                   set xattr tolerance to # (< 0, disable xattrs; default 2)\n"
-	      " -zX[,Y]               X=compressor (Y=compression level, optional)\n"
+	      " -zX[,Y][:..]          X=compressor (Y=compression level, optional)\n"
+	      "                       alternative algorithms can be separated by colons(:)\n"
 	      " -C#                   specify the size of compress physical cluster in bytes\n"
 	      " -EX[,...]             X=extended options\n"
 	      " -L volume-label       set the volume label (maximum 16)\n"
-- 
2.36.1

