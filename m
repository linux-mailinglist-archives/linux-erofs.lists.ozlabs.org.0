Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD2090C56E
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jun 2024 11:39:02 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=IwrG6oFW;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W3MC741Dpz3cQD
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jun 2024 19:38:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=IwrG6oFW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W3MC22jRgz2yvp
	for <linux-erofs@lists.ozlabs.org>; Tue, 18 Jun 2024 19:38:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718703528; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=uVlpIu5CStpJcl2dEPly1d4GTMcwYC+INIv6B4fGR1w=;
	b=IwrG6oFWqLeAzvYxsG/oz2AMaJ+XmzxWUHVHy+iWE3MGqel+VuSSZE/sSInvIaj2kJBqoMglSOgLe1q4vXyhTc6E1cocWDlukIWdtzMrBxrOM1w+Zy0IOgDMdeP+PLJjpCvzxasZxOAUg9H4QH4GbMqz/dMk2MZ16voulZre320=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W8jp1MS_1718703526;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0W8jp1MS_1718703526)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 17:38:47 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: fix the erofs_io_pread and erofs_io_pwrite
Date: Tue, 18 Jun 2024 17:38:43 +0800
Message-Id: <20240618093843.912278-1-hongzhen@linux.alibaba.com>
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
v1: https://lore.kernel.org/all/20240617023433.3446706-1-hongzhen@linux.alibaba.com/
---
 include/erofs/internal.h |  5 ++++-
 lib/io.c                 | 31 +++++++++++++++++++++++--------
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index f8a01ce..ed1fc92 100644
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
+	return (size_t)ret == len ? 0 : (int)ret;
 }
 
 static inline int erofs_dev_fillzero(struct erofs_sb_info *sbi, u64 offset,
diff --git a/lib/io.c b/lib/io.c
index c523f00..0149d3b 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -30,6 +30,7 @@ ssize_t erofs_io_pwrite(struct erofs_vfile *vf, const void *buf,
 			u64 pos, size_t len)
 {
 	ssize_t ret;
+	size_t saved_len = len;
 
 	if (unlikely(cfg.c_dry_run))
 		return 0;
@@ -53,7 +54,7 @@ ssize_t erofs_io_pwrite(struct erofs_vfile *vf, const void *buf,
 		pos += ret;
 	} while (len);
 
-	return 0;
+	return saved_len;
 }
 
 int erofs_io_fsync(struct erofs_vfile *vf)
@@ -79,6 +80,7 @@ ssize_t erofs_io_fallocate(struct erofs_vfile *vf, u64 offset,
 {
 	static const char zero[EROFS_MAX_BLOCK_SIZE] = {0};
 	ssize_t ret;
+	ssize_t wret;
 
 	if (unlikely(cfg.c_dry_run))
 		return 0;
@@ -92,13 +94,16 @@ ssize_t erofs_io_fallocate(struct erofs_vfile *vf, u64 offset,
 		return 0;
 #endif
 	while (len > EROFS_MAX_BLOCK_SIZE) {
-		ret = erofs_io_pwrite(vf, zero, offset, EROFS_MAX_BLOCK_SIZE);
+		wret = erofs_io_pwrite(vf, zero, offset, EROFS_MAX_BLOCK_SIZE);
+		ret = wret == EROFS_MAX_BLOCK_SIZE ? 0 : wret;
 		if (ret)
 			return ret;
 		len -= EROFS_MAX_BLOCK_SIZE;
 		offset += EROFS_MAX_BLOCK_SIZE;
 	}
-	return erofs_io_pwrite(vf, zero, offset, len);
+	wret = erofs_io_pwrite(vf, zero, offset, len);
+	ret = wret == len ? 0 : wret;
+	return ret;
 }
 
 int erofs_io_ftruncate(struct erofs_vfile *vf, u64 length)
@@ -126,6 +131,7 @@ int erofs_io_ftruncate(struct erofs_vfile *vf, u64 length)
 ssize_t erofs_io_pread(struct erofs_vfile *vf, void *buf, u64 pos, size_t len)
 {
 	ssize_t ret;
+	size_t saved_len = len;
 
 	if (unlikely(cfg.c_dry_run))
 		return 0;
@@ -156,7 +162,8 @@ ssize_t erofs_io_pread(struct erofs_vfile *vf, void *buf, u64 pos, size_t len)
 		len -= ret;
 		buf += ret;
 	} while (len);
-	return 0;
+
+	return saved_len;
 }
 
 static int erofs_get_bdev_size(int fd, u64 *bytes)
@@ -287,7 +294,8 @@ out:
 
 void erofs_dev_close(struct erofs_sb_info *sbi)
 {
-	close(sbi->bdev.fd);
+	if (!sbi->bdev.ops)
+		close(sbi->bdev.fd);
 	free(sbi->devname);
 	sbi->devname = NULL;
 	sbi->bdev.fd = -1;
@@ -320,11 +328,18 @@ int erofs_blob_open_ro(struct erofs_sb_info *sbi, const char *dev)
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
+		return ret == len ? 0 : ret;
+
+	}
+
+	ret =  erofs_io_pread(&sbi->bdev, buf, offset, len);
+	return ret == len ? 0 : ret;
 }
 
 static ssize_t __erofs_copy_file_range(int fd_in, u64 *off_in,
-- 
2.39.3

