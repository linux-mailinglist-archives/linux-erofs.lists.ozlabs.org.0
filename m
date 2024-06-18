Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 707FA90CA27
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jun 2024 13:47:24 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lJLQD8NX;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W3Q3F1MXkz3cLk
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jun 2024 21:47:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lJLQD8NX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W3Q380G7gz3bjK
	for <linux-erofs@lists.ozlabs.org>; Tue, 18 Jun 2024 21:47:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718711230; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=t09JWg4FgFc8WJTZdPiXXelZ13MLb83zlZ98n8HRFZk=;
	b=lJLQD8NXkDGMZjBh2Hl+0qBiZD5xM1pZxamFfR7tK69khU0rsStVTxE1MCbsvcQhroDEBx4WMON6tRtm/SVa8DMwDJMxmd9FW67+rDQBjy8U5nTtb8uh5BS7fxj5ofjY9C3offHGKjammDbxR9OF6AxcYKgbRekGJZcrPAw6yqc=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W8k.q8R_1718711228;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0W8k.q8R_1718711228)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 19:47:09 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3] erofs-utils: fix the erofs_io_pread and erofs_io_pwrite
Date: Tue, 18 Jun 2024 19:47:07 +0800
Message-Id: <20240618114707.1030180-1-hongzhen@linux.alibaba.com>
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

When `vf->ops` is not null, `vf->ops->pread` returns the
number of bytes successfully read, which is inconsistent
with the semantics of `erofs_io_pread`. Similar situation
occurs in `erofs_io_pwrite`. This fixes this issue.

This also fixes `erofs_dev_close`.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
v2: https://lore.kernel.org/all/20240618093843.912278-1-hongzhen@linux.alibaba.com/
v1: https://lore.kernel.org/all/20240617023433.3446706-1-hongzhen@linux.alibaba.com/
---
 include/erofs/internal.h |  5 ++++-
 lib/io.c                 | 47 ++++++++++++++++++++++++++++++----------
 2 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index f8a01ce..dfbd958 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -460,7 +460,10 @@ ssize_t erofs_dev_read(struct erofs_sb_info *sbi, int device_id,
 static inline int erofs_dev_write(struct erofs_sb_info *sbi, const void *buf,
 				  u64 offset, size_t len)
 {
-	return erofs_io_pwrite(&sbi->bdev, buf, offset, len);
+	ssize_t ret;
+
+	ret = erofs_io_pwrite(&sbi->bdev, buf, offset, len);
+	return (size_t)ret == len ? 0 : -EIO;
 }
 
 static inline int erofs_dev_fillzero(struct erofs_sb_info *sbi, u64 offset,
diff --git a/lib/io.c b/lib/io.c
index c523f00..3417b46 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -30,6 +30,7 @@ ssize_t erofs_io_pwrite(struct erofs_vfile *vf, const void *buf,
 			u64 pos, size_t len)
 {
 	ssize_t ret;
+	size_t write = 0;
 
 	if (unlikely(cfg.c_dry_run))
 		return 0;
@@ -51,9 +52,10 @@ ssize_t erofs_io_pwrite(struct erofs_vfile *vf, const void *buf,
 		len -= ret;
 		buf += ret;
 		pos += ret;
+		write += ret;
 	} while (len);
 
-	return 0;
+	return write;
 }
 
 int erofs_io_fsync(struct erofs_vfile *vf)
@@ -92,13 +94,15 @@ ssize_t erofs_io_fallocate(struct erofs_vfile *vf, u64 offset,
 		return 0;
 #endif
 	while (len > EROFS_MAX_BLOCK_SIZE) {
-		ret = erofs_io_pwrite(vf, zero, offset, EROFS_MAX_BLOCK_SIZE);
+		ret = erofs_io_pwrite(vf, zero, offset,
+			EROFS_MAX_BLOCK_SIZE) == EROFS_MAX_BLOCK_SIZE ?
+			0 : -EIO;
 		if (ret)
 			return ret;
 		len -= EROFS_MAX_BLOCK_SIZE;
 		offset += EROFS_MAX_BLOCK_SIZE;
 	}
-	return erofs_io_pwrite(vf, zero, offset, len);
+	return erofs_io_pwrite(vf, zero, offset, len) == len ? 0 : -EIO;
 }
 
 int erofs_io_ftruncate(struct erofs_vfile *vf, u64 length)
@@ -126,6 +130,7 @@ int erofs_io_ftruncate(struct erofs_vfile *vf, u64 length)
 ssize_t erofs_io_pread(struct erofs_vfile *vf, void *buf, u64 pos, size_t len)
 {
 	ssize_t ret;
+	ssize_t read = 0;
 
 	if (unlikely(cfg.c_dry_run))
 		return 0;
@@ -142,9 +147,7 @@ ssize_t erofs_io_pread(struct erofs_vfile *vf, void *buf, u64 pos, size_t len)
 #endif
 		if (ret <= 0) {
 			if (!ret) {
-				erofs_info("reach EOF of device");
-				memset(buf, 0, len);
-				return 0;
+				return read;
 			}
 			if (errno != EINTR) {
 				erofs_err("failed to read: %s", strerror(errno));
@@ -155,8 +158,11 @@ ssize_t erofs_io_pread(struct erofs_vfile *vf, void *buf, u64 pos, size_t len)
 		pos += ret;
 		len -= ret;
 		buf += ret;
+		read += ret;
+
 	} while (len);
-	return 0;
+
+	return read;
 }
 
 static int erofs_get_bdev_size(int fd, u64 *bytes)
@@ -287,7 +293,8 @@ out:
 
 void erofs_dev_close(struct erofs_sb_info *sbi)
 {
-	close(sbi->bdev.fd);
+	if (!sbi->bdev.ops)
+		close(sbi->bdev.fd);
 	free(sbi->devname);
 	sbi->devname = NULL;
 	sbi->bdev.fd = -1;
@@ -320,11 +327,29 @@ int erofs_blob_open_ro(struct erofs_sb_info *sbi, const char *dev)
 ssize_t erofs_dev_read(struct erofs_sb_info *sbi, int device_id,
 		       void *buf, u64 offset, size_t len)
 {
-	if (device_id)
-		return erofs_io_pread(&((struct erofs_vfile) {
+	ssize_t ret;
+
+	if (device_id) {
+		ret = erofs_io_pread(&((struct erofs_vfile) {
 				.fd = sbi->blobfd[device_id - 1],
 			}), buf, offset, len);
-	return erofs_io_pread(&sbi->bdev, buf, offset, len);
+		if (ret < 0)
+			return ret;
+		if (ret < len) {
+			erofs_info("reach EOF of device");
+			memset(buf + ret, 0, len - ret);
+		}
+		return 0;
+	}
+
+	ret = erofs_io_pread(&sbi->bdev, buf, offset, len);
+	if (ret < 0)
+		return ret;
+	if (ret < len) {
+		erofs_info("reach EOF of device");
+		memset(buf + ret, 0, len - ret);
+	}
+	return 0;
 }
 
 static ssize_t __erofs_copy_file_range(int fd_in, u64 *off_in,
-- 
2.39.3

