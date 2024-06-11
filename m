Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6F4903462
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Jun 2024 09:55:05 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=JRay+f+o;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Vz1DQ0vxTz3cM2
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Jun 2024 17:55:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=JRay+f+o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vz1DK0pGXz2yvp
	for <linux-erofs@lists.ozlabs.org>; Tue, 11 Jun 2024 17:54:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718092490; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=XyhZOrj5AUdmykDYJyT+N7plHLVq8cuK7ic87FYE5Ug=;
	b=JRay+f+oEnpOQY3Ri1ze/4X5Ljb1yAE8ejZ0ztUL3KdBAx0lk/m4gLksuJriyg5qqcU8KA32pPdIhF83cM7MGF0BWQbfhL4rgObkHecTwgeBGRn1wl2d0SWpADyPvi/+nK52vUW8hku7JX2h6dCzU8ucHk2sbkvyzdxdInq/xrI=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W8FaI9Q_1718092487;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0W8FaI9Q_1718092487)
          by smtp.aliyun-inc.com;
          Tue, 11 Jun 2024 15:54:48 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: add I/O control for tarerofs stream via `erofs_vfile`
Date: Tue, 11 Jun 2024 15:54:45 +0800
Message-Id: <20240611075445.178659-1-hongzhen@linux.alibaba.com>
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
 include/erofs/io.h  |  1 +
 include/erofs/tar.h |  2 +-
 lib/tar.c           | 16 ++++++++++------
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/erofs/io.h b/include/erofs/io.h
index c82dfdf..a501685 100644
--- a/include/erofs/io.h
+++ b/include/erofs/io.h
@@ -26,6 +26,7 @@ struct erofs_vfile;
 
 struct erofs_vfops {
 	int (*pread)(struct erofs_vfile *vf, void *buf, u64 offset, size_t len);
+	int (*read)(struct erofs_vfile *vf, void *buf, size_t len);
 	int (*pwrite)(struct erofs_vfile *vf, const void *buf, u64 offset, size_t len);
 	int (*fsync)(struct erofs_vfile *vf);
 	int (*fallocate)(struct erofs_vfile *vf, u64 offset, size_t len, bool pad);
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
diff --git a/lib/tar.c b/lib/tar.c
index 3514381..77e09ae 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -79,7 +79,7 @@ void erofs_iostream_close(struct erofs_iostream *ios)
 #endif
 		return;
 	}
-	close(ios->fd);
+	close(ios->vf.fd);
 }
 
 int erofs_iostream_open(struct erofs_iostream *ios, int fd, int decoder)
@@ -119,7 +119,7 @@ int erofs_iostream_open(struct erofs_iostream *ios, int fd, int decoder)
 		return -EOPNOTSUPP;
 #endif
 	} else {
-		ios->fd = fd;
+		ios->vf.fd = fd;
 		fsz = lseek(fd, 0, SEEK_END);
 		if (fsz <= 0) {
 			ios->feof = !fsz;
@@ -218,8 +218,12 @@ int erofs_iostream_read(struct erofs_iostream *ios, void **buf, u64 bytes)
 			return -EOPNOTSUPP;
 #endif
 		} else {
-			ret = erofs_read_from_fd(ios->fd, ios->buffer + rabytes,
-						 ios->bufsize - rabytes);
+			if (ios->vf.ops)
+				ret = ios->vf.ops->read(&ios->vf, ios->buffer + rabytes,
+							 ios->bufsize - rabytes);
+			else
+				ret = erofs_read_from_fd(ios->vf.fd, ios->buffer + rabytes,
+							 ios->bufsize - rabytes);
 			if (ret < 0)
 				return ret;
 			ios->tail += ret;
@@ -270,8 +274,8 @@ int erofs_iostream_lskip(struct erofs_iostream *ios, u64 sz)
 	if (ios->feof)
 		return sz;
 
-	if (ios->sz && likely(ios->dumpfd < 0)) {
-		s64 cur = lseek(ios->fd, sz, SEEK_CUR);
+	if (ios->sz && likely(ios->dumpfd < 0) && !ios->vf.ops) {
+		s64 cur = lseek(ios->vf.fd, sz, SEEK_CUR);
 
 		if (cur > ios->sz)
 			return cur - ios->sz;
-- 
2.39.3

