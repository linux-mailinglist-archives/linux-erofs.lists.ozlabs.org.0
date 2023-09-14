Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5D07A007C
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Sep 2023 11:39:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RmXMx3RKJz3bxY
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Sep 2023 19:39:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RmXMr3PmZz3bT8
	for <linux-erofs@lists.ozlabs.org>; Thu, 14 Sep 2023 19:39:18 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vs2OG4p_1694684346;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vs2OG4p_1694684346)
          by smtp.aliyun-inc.com;
          Thu, 14 Sep 2023 17:39:11 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: avoid flushing the image file on closing
Date: Thu, 14 Sep 2023 17:39:05 +0800
Message-Id: <20230914093905.1600316-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230914053211.1225452-1-hsiangkao@linux.alibaba.com>
References: <20230914053211.1225452-1-hsiangkao@linux.alibaba.com>
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

Traditionally, truncating to small sizes will trigger some
flush-on-close semantics to avoid the notorious NULL files.

I'm not sure if it's our use case since:
  1) we're creating new image files instead of reusing old ones;
  2) it kills end-to-end performance in practice;
  3) other programs like GNU TAR doesn't work as this too for
     such meaningless comparsion;

Let's work around it now.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
change since v1:
 - fix macOS build error:

 configure.ac |  2 ++
 lib/io.c     | 41 +++++++++++++++++++++++++++++++++++------
 2 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/configure.ac b/configure.ac
index a8cecd0..51ace67 100644
--- a/configure.ac
+++ b/configure.ac
@@ -190,6 +190,7 @@ AC_CHECK_HEADERS(m4_flatten([
 	sys/mman.h
 	sys/random.h
 	sys/stat.h
+	sys/statfs.h
 	sys/sysmacros.h
 	sys/time.h
 	unistd.h
@@ -249,6 +250,7 @@ AC_CHECK_FUNCS(m4_flatten([
 	ftello64
 	pread64
 	pwrite64
+	fstatfs
 	strdup
 	strerror
 	strrchr
diff --git a/lib/io.c b/lib/io.c
index 1545436..602ac68 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -20,7 +20,9 @@
 #ifdef HAVE_LINUX_FALLOC_H
 #include <linux/falloc.h>
 #endif
-
+#ifdef HAVE_SYS_STATFS_H
+#include <sys/statfs.h>
+#endif
 #define EROFS_MODNAME	"erofs_io"
 #include "erofs/print.h"
 
@@ -58,6 +60,11 @@ int dev_open(struct erofs_sb_info *sbi, const char *dev)
 	struct stat st;
 	int fd, ret;
 
+#if defined(HAVE_SYS_STATFS_H) && defined(HAVE_FSTATFS)
+	bool again = false;
+
+repeat:
+#endif
 	fd = open(dev, O_RDWR | O_CREAT | O_BINARY, 0644);
 	if (fd < 0) {
 		erofs_err("failed to open(%s).", dev);
@@ -82,11 +89,33 @@ int dev_open(struct erofs_sb_info *sbi, const char *dev)
 		sbi->devsz = round_down(sbi->devsz, erofs_blksiz(sbi));
 		break;
 	case S_IFREG:
-		ret = ftruncate(fd, 0);
-		if (ret) {
-			erofs_err("failed to ftruncate(%s).", dev);
-			close(fd);
-			return -errno;
+		if (st.st_size) {
+#if defined(HAVE_SYS_STATFS_H) && defined(HAVE_FSTATFS)
+			struct statfs stfs;
+
+			if (again)
+				return -ENOTEMPTY;
+
+			/*
+			 * fses like EXT4 and BTRFS will flush dirty blocks
+			 * after truncate(0) even after the writeback happens
+			 * (see kernel commit 7d8f9f7d150d and ccd2506bd431),
+			 * which is NOT our intention.  Let's work around this.
+			 */
+			if (!fstatfs(fd, &stfs) && (stfs.f_type == 0xEF53 ||
+					stfs.f_type == 0x9123683E)) {
+				close(fd);
+				unlink(dev);
+				again = true;
+				goto repeat;
+			}
+#endif
+			ret = ftruncate(fd, 0);
+			if (ret) {
+				erofs_err("failed to ftruncate(%s).", dev);
+				close(fd);
+				return -errno;
+			}
 		}
 		/* INT64_MAX is the limit of kernel vfs */
 		sbi->devsz = INT64_MAX;
-- 
2.39.3

