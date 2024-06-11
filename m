Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FF69039CD
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Jun 2024 13:19:53 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=kgnoV26d;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Vz5mk6WYZz3ckq
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Jun 2024 21:19:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=kgnoV26d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vz5md6w8bz30Wb
	for <linux-erofs@lists.ozlabs.org>; Tue, 11 Jun 2024 21:19:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718104780; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=4p3YH2iVafrvluyUMQGTQV5Jwv+ya4RdGDL8D4OFC1s=;
	b=kgnoV26d3AJ0L/8L+tp5nYOqE0aACO501u35WhWQUO+zcKC8+oMjDsgXbUaJ3WtpwiTQh+1BjfZLw0+IKceJ2Ws0f85/yf+dSV6b3xDubBdtmWvX1LTUY1ZHsa+Eg1HESDYuisgXWhpu+IOg06T1+eAbaa3OLCosGEsGZhtGZqw=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W8GFIIh_1718104778;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0W8GFIIh_1718104778)
          by smtp.aliyun-inc.com;
          Tue, 11 Jun 2024 19:19:39 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: add I/O control for tarerofs stream via `erofs_vfile`
Date: Tue, 11 Jun 2024 19:19:37 +0800
Message-Id: <20240611111937.378214-1-hongzhen@linux.alibaba.com>
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
v3: Make the code cleaner.
v2: https://lore.kernel.org/all/20240611095359.294925-1-hongzhen@linux.alibaba.com/
v1: https://lore.kernel.org/all/20240611075445.178659-1-hongzhen@linux.alibaba.com/
---
 include/erofs/io.h  |  4 ++++
 include/erofs/tar.h |  2 +-
 lib/io.c            | 35 +++++++++++++++++++++++++++++++++++
 lib/tar.c           | 34 +++++-----------------------------
 4 files changed, 45 insertions(+), 30 deletions(-)

diff --git a/include/erofs/io.h b/include/erofs/io.h
index c82dfdf..2c91314 100644
--- a/include/erofs/io.h
+++ b/include/erofs/io.h
@@ -30,6 +30,8 @@ struct erofs_vfops {
 	int (*fsync)(struct erofs_vfile *vf);
 	int (*fallocate)(struct erofs_vfile *vf, u64 offset, size_t len, bool pad);
 	int (*ftruncate)(struct erofs_vfile *vf, u64 length);
+	int (*read)(struct erofs_vfile *vf, void *buf, size_t len);
+	off_t (*lseek)(struct erofs_vfile *vf, u64 offset, int whence);
 };
 
 struct erofs_vfile {
@@ -43,6 +45,8 @@ int erofs_io_fsync(struct erofs_vfile *vf);
 int erofs_io_fallocate(struct erofs_vfile *vf, u64 offset, size_t len, bool pad);
 int erofs_io_ftruncate(struct erofs_vfile *vf, u64 length);
 int erofs_io_pread(struct erofs_vfile *vf, void *buf, u64 offset, size_t len);
+int erofs_io_read(struct erofs_vfile *vf, void *buf, size_t len);
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
index 2db384c..8e01948 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -420,3 +420,38 @@ out:
 #endif
 	return __erofs_copy_file_range(fd_in, off_in, fd_out, off_out, length);
 }
+
+int erofs_io_read(struct erofs_vfile *vf, void *buf, size_t bytes)
+{
+	s64 i = 0;
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
+				erofs_err("failed to read : %s\n",
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

