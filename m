Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F4990E1B6
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Jun 2024 04:50:47 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dJVUylr+;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W3p5c1rVxz3cTh
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Jun 2024 12:50:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dJVUylr+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W3p5W1K5Nz30WW
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Jun 2024 12:50:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718765432; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=GD2JLawpK+PoUEwBuY//57HO8KkdvNztw51Awurq11s=;
	b=dJVUylr+CQAmNwXrwIj+eQMqsMilssSM7LDHqaoRZD7kT97kHLxMTlDFnpja0vzH1diziHffXTPQPEPnEktn/y8bg9nkfKm1NDrhHoqPzcwh2DP66/EXNsIF0Si5XmGn4SGry8a9z7zHkKbDBFN327JZjFm01LpxxRKj2JoVuUw=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W8lgdzx_1718765425;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W8lgdzx_1718765425)
          by smtp.aliyun-inc.com;
          Wed, 19 Jun 2024 10:50:30 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v4] erofs-utils: fix erofs_io_p{read,write} and erofs_dev_close
Date: Wed, 19 Jun 2024 10:50:24 +0800
Message-Id: <20240619025024.1109782-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Hongzhen Luo <hongzhen@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Hongzhen Luo <hongzhen@linux.alibaba.com>

erofs_io_p{read,write} should return the number of bytes
successfully {read,wrrite}.

This also fixes `erofs_dev_close` which could close random
fds if `vf->ops` is NULL.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v3: https://lore.kernel.org/r/20240618114707.1030180-1-hongzhen@linux.alibaba.com
v4:
 - minor cleanups for applying.

 include/erofs/internal.h |  4 ++-
 lib/io.c                 | 62 +++++++++++++++++++++++++---------------
 2 files changed, 42 insertions(+), 24 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 1d6496a..f61a453 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -465,7 +465,9 @@ ssize_t erofs_dev_read(struct erofs_sb_info *sbi, int device_id,
 static inline int erofs_dev_write(struct erofs_sb_info *sbi, const void *buf,
 				  u64 offset, size_t len)
 {
-	return erofs_io_pwrite(&sbi->bdev, buf, offset, len);
+	if (erofs_io_pwrite(&sbi->bdev, buf, offset, len) != (ssize_t)len)
+		return -EIO;
+	return 0;
 }
 
 static inline int erofs_dev_fillzero(struct erofs_sb_info *sbi, u64 offset,
diff --git a/lib/io.c b/lib/io.c
index 83c145c..cd2f034 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -42,7 +42,7 @@ int erofs_io_fstat(struct erofs_vfile *vf, struct stat *buf)
 ssize_t erofs_io_pwrite(struct erofs_vfile *vf, const void *buf,
 			u64 pos, size_t len)
 {
-	ssize_t ret;
+	ssize_t ret, written = 0;
 
 	if (unlikely(cfg.c_dry_run))
 		return 0;
@@ -58,15 +58,20 @@ ssize_t erofs_io_pwrite(struct erofs_vfile *vf, const void *buf,
 		ret = pwrite(vf->fd, buf, len, (off_t)pos);
 #endif
 		if (ret <= 0) {
-			erofs_err("failed to write: %s", strerror(errno));
-			return -errno;
+			if (!ret)
+				break;
+			if (errno != EINTR) {
+				erofs_err("failed to write: %s", strerror(errno));
+				return -errno;
+			}
+			ret = 0;
 		}
-		len -= ret;
 		buf += ret;
 		pos += ret;
-	} while (len);
+		written += ret;
+	} while (written < len);
 
-	return 0;
+	return written;
 }
 
 int erofs_io_fsync(struct erofs_vfile *vf)
@@ -106,12 +111,12 @@ ssize_t erofs_io_fallocate(struct erofs_vfile *vf, u64 offset,
 #endif
 	while (len > EROFS_MAX_BLOCK_SIZE) {
 		ret = erofs_io_pwrite(vf, zero, offset, EROFS_MAX_BLOCK_SIZE);
-		if (ret)
+		if (ret < 0)
 			return ret;
-		len -= EROFS_MAX_BLOCK_SIZE;
-		offset += EROFS_MAX_BLOCK_SIZE;
+		len -= ret;
+		offset += ret;
 	}
-	return erofs_io_pwrite(vf, zero, offset, len);
+	return erofs_io_pwrite(vf, zero, offset, len) == len ? 0 : -EIO;
 }
 
 int erofs_io_ftruncate(struct erofs_vfile *vf, u64 length)
@@ -138,7 +143,7 @@ int erofs_io_ftruncate(struct erofs_vfile *vf, u64 length)
 
 ssize_t erofs_io_pread(struct erofs_vfile *vf, void *buf, u64 pos, size_t len)
 {
-	ssize_t ret;
+	ssize_t ret, read = 0;
 
 	if (unlikely(cfg.c_dry_run))
 		return 0;
@@ -154,11 +159,8 @@ ssize_t erofs_io_pread(struct erofs_vfile *vf, void *buf, u64 pos, size_t len)
 		ret = pread(vf->fd, buf, len, (off_t)pos);
 #endif
 		if (ret <= 0) {
-			if (!ret) {
-				erofs_info("reach EOF of device");
-				memset(buf, 0, len);
-				return 0;
-			}
+			if (!ret)
+				break;
 			if (errno != EINTR) {
 				erofs_err("failed to read: %s", strerror(errno));
 				return -errno;
@@ -166,10 +168,11 @@ ssize_t erofs_io_pread(struct erofs_vfile *vf, void *buf, u64 pos, size_t len)
 			ret = 0;
 		}
 		pos += ret;
-		len -= ret;
 		buf += ret;
-	} while (len);
-	return 0;
+		read += ret;
+	} while (read < len);
+
+	return read;
 }
 
 static int erofs_get_bdev_size(int fd, u64 *bytes)
@@ -300,7 +303,8 @@ out:
 
 void erofs_dev_close(struct erofs_sb_info *sbi)
 {
-	close(sbi->bdev.fd);
+	if (!sbi->bdev.ops)
+		close(sbi->bdev.fd);
 	free(sbi->devname);
 	sbi->devname = NULL;
 	sbi->bdev.fd = -1;
@@ -333,11 +337,23 @@ int erofs_blob_open_ro(struct erofs_sb_info *sbi, const char *dev)
 ssize_t erofs_dev_read(struct erofs_sb_info *sbi, int device_id,
 		       void *buf, u64 offset, size_t len)
 {
-	if (device_id)
-		return erofs_io_pread(&((struct erofs_vfile) {
+	ssize_t read;
+
+	if (device_id) {
+		read = erofs_io_pread(&((struct erofs_vfile) {
 				.fd = sbi->blobfd[device_id - 1],
 			}), buf, offset, len);
-	return erofs_io_pread(&sbi->bdev, buf, offset, len);
+	} else {
+		read = erofs_io_pread(&sbi->bdev, buf, offset, len);
+	}
+
+	if (read < 0)
+		return read;
+	if (read < len) {
+		erofs_info("reach EOF of device, pading with zeroes");
+		memset(buf + read, 0, len - read);
+	}
+	return 0;
 }
 
 static ssize_t __erofs_copy_file_range(int fd_in, u64 *off_in,
-- 
2.39.3

