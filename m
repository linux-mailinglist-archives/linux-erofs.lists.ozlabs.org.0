Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 954F76A29E
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2019 09:05:26 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45nryC3xnYzDqXM
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2019 17:05:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.191; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45nrxY30JpzDqWh
 for <linux-erofs@lists.ozlabs.org>; Tue, 16 Jul 2019 17:04:49 +1000 (AEST)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 842BA64216A023A4014F;
 Tue, 16 Jul 2019 15:04:45 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 16 Jul
 2019 15:04:38 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Li Guifu <bluce.liguifu@huawei.com>, Fang Wei <fangwei1@huawei.com>
Subject: [PATCH v2 13/17] erofs-utils: introduce dev_fillzero
Date: Tue, 16 Jul 2019 15:04:15 +0800
Message-ID: <20190716070419.30203-14-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190716070419.30203-1-gaoxiang25@huawei.com>
References: <20190716070419.30203-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
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
Cc: Miao Xie <miaoxie@huawei.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

add dev_fillzero() to fill zero within a range.
FALLOC_FL_PUNCH_HOLE is perferred if supported.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 configure.ac       |  3 ++-
 include/erofs/io.h |  1 +
 lib/cache.c        |  5 ++---
 lib/io.c           | 27 +++++++++++++++++++++++++++
 4 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index 6cc0c60..6f4eacc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -72,6 +72,7 @@ AC_CHECK_HEADERS(m4_flatten([
 	dirent.h
 	fcntl.h
 	inttypes.h
+	linux/falloc.h
 	linux/types.h
 	limits.h
 	stddef.h
@@ -115,7 +116,7 @@ AC_CHECK_DECL(lseek64,[AC_DEFINE(HAVE_LSEEK64_PROTOTYPE, 1,
    #include <unistd.h>])
 
 # Checks for library functions.
-AC_CHECK_FUNCS([gettimeofday memset realpath strdup strerror strrchr strtoull])
+AC_CHECK_FUNCS([fallocate gettimeofday memset realpath strdup strerror strrchr strtoull])
 
 # Configure lz4
 test -z $LZ4_LIBS && LZ4_LIBS='-llz4'
diff --git a/include/erofs/io.h b/include/erofs/io.h
index 9471388..aafb1e7 100644
--- a/include/erofs/io.h
+++ b/include/erofs/io.h
@@ -19,6 +19,7 @@
 int dev_open(const char *devname);
 void dev_close(void);
 int dev_write(const void *buf, u64 offset, size_t len);
+int dev_fillzero(u64 offset, size_t len);
 int dev_fsync(void);
 u64 dev_length(void);
 
diff --git a/lib/cache.c b/lib/cache.c
index 967b543..76e6d78 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -274,7 +274,6 @@ erofs_blk_t erofs_mapbh(struct erofs_buffer_block *bb, bool end)
 
 bool erofs_bflush(struct erofs_buffer_block *bb)
 {
-	static const char zero[EROFS_BLKSIZ] = {0};
 	struct erofs_buffer_block *p, *n;
 	erofs_blk_t blkaddr;
 
@@ -304,8 +303,8 @@ bool erofs_bflush(struct erofs_buffer_block *bb)
 
 		padding = EROFS_BLKSIZ - p->buffers.off % EROFS_BLKSIZ;
 		if (padding != EROFS_BLKSIZ)
-			dev_write(zero, blknr_to_addr(blkaddr) - padding,
-				  padding);
+			dev_fillzero(blknr_to_addr(blkaddr) - padding,
+				     padding);
 
 		DBG_BUGON(!list_empty(&p->buffers.list));
 
diff --git a/lib/io.c b/lib/io.c
index f624535..d39661c 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -7,8 +7,12 @@
  * Created by Li Guifu <bluce.liguifu@huawei.com>
  */
 #define _LARGEFILE64_SOURCE
+#define _GNU_SOURCE
 #include <sys/stat.h>
 #include "erofs/io.h"
+#ifdef HAVE_LINUX_FALLOC_H
+#include <linux/falloc.h>
+#endif
 
 #define pr_fmt(fmt) "EROFS IO: " FUNC_LINE_FMT fmt "\n"
 #include "erofs/print.h"
@@ -110,6 +114,29 @@ int dev_write(const void *buf, u64 offset, size_t len)
 	return 0;
 }
 
+int dev_fillzero(u64 offset, size_t len)
+{
+	static const char zero[EROFS_BLKSIZ] = {0};
+	int ret;
+
+	if (cfg.c_dry_run)
+		return 0;
+
+#if defined(HAVE_FALLOCATE) && defined(FALLOC_FL_PUNCH_HOLE)
+	if (fallocate(erofs_devfd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+		      offset, len) >= 0)
+		return 0;
+#endif
+	while (len > EROFS_BLKSIZ) {
+		ret = dev_write(zero, offset, EROFS_BLKSIZ);
+		if (ret)
+			return ret;
+		len -= EROFS_BLKSIZ;
+		offset += EROFS_BLKSIZ;
+	}
+	return dev_write(zero, offset, len);
+}
+
 int dev_fsync(void)
 {
 	int ret;
-- 
2.17.1

