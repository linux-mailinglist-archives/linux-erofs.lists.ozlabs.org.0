Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E87904966
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Jun 2024 05:11:45 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OlT4xfy1;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VzVv248Wgz3fnC
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Jun 2024 13:11:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OlT4xfy1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VzVtv1MM9z3bVG
	for <linux-erofs@lists.ozlabs.org>; Wed, 12 Jun 2024 13:11:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718161889; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=1crOecJgtQy1KAnfQZ9hMq+/czeTpr7AzuSi6RjMPqQ=;
	b=OlT4xfy13z7Zn2ThXtPEugkk2V7dloD9dgGprrmQ8jeEjpAF3Rgn6X1q3FRiMMA4ra54bEsCA070NNwwouk814pBcwbyXG5ASODAmxu5SJxU5P2j3zl41yn8HRCxRL6zjcmVc5zN7xtRkCdrHCDGdosdsIh945L3GjKP+bmftq4=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W8IJZCB_1718161887;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0W8IJZCB_1718161887)
          by smtp.aliyun-inc.com;
          Wed, 12 Jun 2024 11:11:28 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v4] erofs-utils: add I/O control for tarerofs stream via `erofs_vfile`
Date: Wed, 12 Jun 2024 11:11:24 +0800
Message-Id: <20240612031124.1227558-1-hongzhen@linux.alibaba.com>
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
Cc: Hongzhen Luo <hongzhen@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This adds I/O control for tarerofs stream.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
v4: Modify the function definition to prevent overflow.
v3: https://lore.kernel.org/all/20240611111937.378214-1-hongzhen@linux.alibaba.com/
v2: https://lore.kernel.org/all/20240611095359.294925-1-hongzhen@linux.alibaba.com/
v1: https://lore.kernel.org/all/20240611075445.178659-1-hongzhen@linux.alibaba.com/
---
 include/erofs/internal.h |  2 +-
 include/erofs/io.h       | 14 ++++++++-----
 include/erofs/tar.h      |  2 +-
 lib/io.c                 | 45 +++++++++++++++++++++++++++++++++++-----
 lib/tar.c                | 34 +++++-------------------------
 5 files changed, 56 insertions(+), 41 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index f1d85be..2ab0958 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -453,7 +453,7 @@ void erofs_dev_close(struct erofs_sb_info *sbi);
 void erofs_blob_closeall(struct erofs_sb_info *sbi);
 int erofs_blob_open_ro(struct erofs_sb_info *sbi, const char *dev);
 
-int erofs_dev_read(struct erofs_sb_info *sbi, int device_id,
+ssize_t erofs_dev_read(struct erofs_sb_info *sbi, int device_id,
 		   void *buf, u64 offset, size_t len);
 
 static inline int erofs_dev_write(struct erofs_sb_info *sbi, const void *buf,
diff --git a/include/erofs/io.h b/include/erofs/io.h
index c82dfdf..f24a563 100644
--- a/include/erofs/io.h
+++ b/include/erofs/io.h
@@ -25,11 +25,13 @@ extern "C"
 struct erofs_vfile;
 
 struct erofs_vfops {
-	int (*pread)(struct erofs_vfile *vf, void *buf, u64 offset, size_t len);
-	int (*pwrite)(struct erofs_vfile *vf, const void *buf, u64 offset, size_t len);
+	ssize_t (*pread)(struct erofs_vfile *vf, void *buf, u64 offset, size_t len);
+	ssize_t (*pwrite)(struct erofs_vfile *vf, const void *buf, u64 offset, size_t len);
 	int (*fsync)(struct erofs_vfile *vf);
 	int (*fallocate)(struct erofs_vfile *vf, u64 offset, size_t len, bool pad);
 	int (*ftruncate)(struct erofs_vfile *vf, u64 length);
+	ssize_t (*read)(struct erofs_vfile *vf, void *buf, size_t len);
+	off_t (*lseek)(struct erofs_vfile *vf, u64 offset, int whence);
 };
 
 struct erofs_vfile {
@@ -38,11 +40,13 @@ struct erofs_vfile {
 	int fd;
 };
 
-int erofs_io_pwrite(struct erofs_vfile *vf, const void *buf, u64 pos, size_t len);
+ssize_t erofs_io_pwrite(struct erofs_vfile *vf, const void *buf, u64 pos, size_t len);
 int erofs_io_fsync(struct erofs_vfile *vf);
-int erofs_io_fallocate(struct erofs_vfile *vf, u64 offset, size_t len, bool pad);
+ssize_t erofs_io_fallocate(struct erofs_vfile *vf, u64 offset, size_t len, bool pad);
 int erofs_io_ftruncate(struct erofs_vfile *vf, u64 length);
-int erofs_io_pread(struct erofs_vfile *vf, void *buf, u64 offset, size_t len);
+ssize_t erofs_io_pread(struct erofs_vfile *vf, void *buf, u64 offset, size_t len);
+ssize_t erofs_io_read(struct erofs_vfile *vf, void *buf, size_t len);
+off_t erofs_io_lseek(struct erofs_vfile *vf, u64 offset, int whence);
 
 ssize_t erofs_copy_file_range(int fd_in, u64 *off_in, int fd_out, u64 *off_out,
 			      size_t length);
diff --git a/include/erofs/tar.h b/include/erofs/tar.h
index b5c966b..e1de0df 100644
--- a/include/erofs/tar.h
+++ b/include/erofs/tar.h
@@ -39,7 +39,7 @@ struct erofs_iostream_liblzma {
 
 struct erofs_iostream {
 	union {
-		int fd;			/* original fd */
+		struct erofs_vfile vf;
 		void *handler;
 #ifdef HAVE_LIBLZMA
 		struct erofs_iostream_liblzma *lzma;
diff --git a/lib/io.c b/lib/io.c
index 2db384c..4cf88b2 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -26,7 +26,7 @@
 #define EROFS_MODNAME	"erofs_io"
 #include "erofs/print.h"
 
-int erofs_io_pwrite(struct erofs_vfile *vf, const void *buf,
+ssize_t erofs_io_pwrite(struct erofs_vfile *vf, const void *buf,
 		    u64 pos, size_t len)
 {
 	ssize_t ret;
@@ -74,11 +74,11 @@ int erofs_io_fsync(struct erofs_vfile *vf)
 	return 0;
 }
 
-int erofs_io_fallocate(struct erofs_vfile *vf, u64 offset,
+ssize_t erofs_io_fallocate(struct erofs_vfile *vf, u64 offset,
 		       size_t len, bool zeroout)
 {
 	static const char zero[EROFS_MAX_BLOCK_SIZE] = {0};
-	int ret;
+	ssize_t ret;
 
 	if (unlikely(cfg.c_dry_run))
 		return 0;
@@ -123,7 +123,7 @@ int erofs_io_ftruncate(struct erofs_vfile *vf, u64 length)
 	return ftruncate(vf->fd, length);
 }
 
-int erofs_io_pread(struct erofs_vfile *vf, void *buf, u64 pos, size_t len)
+ssize_t erofs_io_pread(struct erofs_vfile *vf, void *buf, u64 pos, size_t len)
 {
 	ssize_t ret;
 
@@ -317,7 +317,7 @@ int erofs_blob_open_ro(struct erofs_sb_info *sbi, const char *dev)
 	return 0;
 }
 
-int erofs_dev_read(struct erofs_sb_info *sbi, int device_id,
+ssize_t erofs_dev_read(struct erofs_sb_info *sbi, int device_id,
 		   void *buf, u64 offset, size_t len)
 {
 	if (device_id)
@@ -420,3 +420,38 @@ out:
 #endif
 	return __erofs_copy_file_range(fd_in, off_in, fd_out, off_out, length);
 }
+
+ssize_t erofs_io_read(struct erofs_vfile *vf, void *buf, size_t bytes)
+{
+	ssize_t i = 0;
+
+	if (vf->ops)
+		return vf->ops->read(vf, buf, bytes);
+
+	while (bytes) {
+		int len = bytes > INT_MAX ? INT_MAX : bytes;
+		int ret;
+
+		ret = read(vf->fd, buf + i, len);
+		if (ret < 1) {
+			if (ret == 0) {
+				break;
+			} else if (errno != EINTR) {
+				erofs_err("failed to read : %s",
+					  strerror(errno));
+				return -errno;
+			}
+		}
+		bytes -= ret;
+		i += ret;
+        }
+        return i;
+}
+
+off_t erofs_io_lseek(struct erofs_vfile *vf, u64 offset, int whence)
+{
+	if (vf->ops)
+		return vf->ops->lseek(vf, offset, whence);
+
+	return lseek(vf->fd, offset, whence);
+}
diff --git a/lib/tar.c b/lib/tar.c
index 3514381..6202d35 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -39,30 +39,6 @@ struct tar_header {
 	char padding[12];	/* 500-512 (pad to exactly the 512 byte) */
 };
 
-s64 erofs_read_from_fd(int fd, void *buf, u64 bytes)
-{
-	s64 i = 0;
-
-	while (bytes) {
-		int len = bytes > INT_MAX ? INT_MAX : bytes;
-		int ret;
-
-		ret = read(fd, buf + i, len);
-		if (ret < 1) {
-			if (ret == 0) {
-				break;
-			} else if (errno != EINTR) {
-				erofs_err("failed to read : %s\n",
-					  strerror(errno));
-				return -errno;
-			}
-		}
-		bytes -= ret;
-		i += ret;
-        }
-        return i;
-}
-
 void erofs_iostream_close(struct erofs_iostream *ios)
 {
 	free(ios->buffer);
@@ -79,7 +55,7 @@ void erofs_iostream_close(struct erofs_iostream *ios)
 #endif
 		return;
 	}
-	close(ios->fd);
+	close(ios->vf.fd);
 }
 
 int erofs_iostream_open(struct erofs_iostream *ios, int fd, int decoder)
@@ -119,7 +95,7 @@ int erofs_iostream_open(struct erofs_iostream *ios, int fd, int decoder)
 		return -EOPNOTSUPP;
 #endif
 	} else {
-		ios->fd = fd;
+		ios->vf.fd = fd;
 		fsz = lseek(fd, 0, SEEK_END);
 		if (fsz <= 0) {
 			ios->feof = !fsz;
@@ -218,8 +194,8 @@ int erofs_iostream_read(struct erofs_iostream *ios, void **buf, u64 bytes)
 			return -EOPNOTSUPP;
 #endif
 		} else {
-			ret = erofs_read_from_fd(ios->fd, ios->buffer + rabytes,
-						 ios->bufsize - rabytes);
+			ret = erofs_io_read(&ios->vf, ios->buffer + rabytes,
+					    ios->bufsize - rabytes);
 			if (ret < 0)
 				return ret;
 			ios->tail += ret;
@@ -271,7 +247,7 @@ int erofs_iostream_lskip(struct erofs_iostream *ios, u64 sz)
 		return sz;
 
 	if (ios->sz && likely(ios->dumpfd < 0)) {
-		s64 cur = lseek(ios->fd, sz, SEEK_CUR);
+		s64 cur = erofs_io_lseek(&ios->vf, sz, SEEK_CUR);
 
 		if (cur > ios->sz)
 			return cur - ios->sz;
-- 
2.39.3

