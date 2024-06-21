Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DD4911B18
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jun 2024 08:13:28 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=x4pCUMcG;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W56VY2mY9z3cXk
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jun 2024 16:13:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=x4pCUMcG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W56V50BPsz3cYm
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Jun 2024 16:12:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718950374; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=iB/A/Qq6amO1V5BhXGisSPR8Aku38FckxhkwxheVDK4=;
	b=x4pCUMcGjEIvnj2qRe4jllW0tTI+lvTVuD2RLJ3m06a41Ysb0n8FWafWstP+f2EGAV2q0KH6kum5gCbv8RoxL3oKHL7eXOL53qOGv2hnLJcqfWpf7eAFf/YKJ+rKxiSEorHlvNpfdofCUCj3HerTj+XmmKg7hagRv1PIkJyDrfY=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W8vDhzr_1718950368;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W8vDhzr_1718950368)
          by smtp.aliyun-inc.com;
          Fri, 21 Jun 2024 14:12:53 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: optimize write_uncompressed_file_from_fd()
Date: Fri, 21 Jun 2024 14:12:46 +0800
Message-Id: <20240621061246.3973096-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240620081329.2753803-1-hsiangkao@linux.alibaba.com>
References: <20240620081329.2753803-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Daan De Meyer <daan.j.demeyer@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Utilize copy offloading to speed up copying data from the source
filesystem to the target EROFS filesystem.

This method improves build speed by approximately 9% (tested with
Linux 5.4.140 source code dataset).

Reported-by: Daan De Meyer <daan.j.demeyer@gmail.com>
Closes: https://lore.kernel.org/r/CAO8sHcmZZORnrJXA=QzmGkYNkNWn7M+amAK_DZ19-WL4kLUvpw@mail.gmail.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
changes since v1:
 - Fix macos build error:
    https://github.com/erofs/erofsnightly/actions/runs/9607090927
 - Fix unexpected lseek related to diskbuf:
    https://github.com/erofs/erofsnightly/actions/runs/9607047368

 configure.ac       |  2 ++
 include/erofs/io.h |  4 ++++
 lib/inode.c        | 23 +++++++----------------
 lib/io.c           | 45 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 58 insertions(+), 16 deletions(-)

diff --git a/configure.ac b/configure.ac
index dc5f787..945e254 100644
--- a/configure.ac
+++ b/configure.ac
@@ -204,6 +204,7 @@ AC_CHECK_HEADERS(m4_flatten([
 	sys/ioctl.h
 	sys/mman.h
 	sys/random.h
+	sys/sendfile.h
 	sys/stat.h
 	sys/statfs.h
 	sys/sysmacros.h
@@ -267,6 +268,7 @@ AC_CHECK_FUNCS(m4_flatten([
 	pwrite64
 	posix_fadvise
 	fstatfs
+	sendfile
 	strdup
 	strerror
 	strrchr
diff --git a/include/erofs/io.h b/include/erofs/io.h
index d3a487f..84e4bc6 100644
--- a/include/erofs/io.h
+++ b/include/erofs/io.h
@@ -33,6 +33,8 @@ struct erofs_vfops {
 	ssize_t (*read)(struct erofs_vfile *vf, void *buf, size_t len);
 	off_t (*lseek)(struct erofs_vfile *vf, u64 offset, int whence);
 	int (*fstat)(struct erofs_vfile *vf, struct stat *buf);
+	int (*xcopy)(struct erofs_vfile *vout, off_t pos,
+		     struct erofs_vfile *vin, int len);
 };
 
 struct erofs_vfile {
@@ -52,6 +54,8 @@ off_t erofs_io_lseek(struct erofs_vfile *vf, u64 offset, int whence);
 
 ssize_t erofs_copy_file_range(int fd_in, u64 *off_in, int fd_out, u64 *off_out,
 			      size_t length);
+int erofs_io_xcopy(struct erofs_vfile *vout, off_t pos,
+		   struct erofs_vfile *vin, int len);
 
 #ifdef __cplusplus
 }
diff --git a/lib/inode.c b/lib/inode.c
index 60a076a..866c2ee 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -514,30 +514,21 @@ static bool erofs_file_is_compressible(struct erofs_inode *inode)
 static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
 {
 	int ret;
-	unsigned int nblocks, i;
+	unsigned int nblocks;
 	struct erofs_sb_info *sbi = inode->sbi;
 
 	inode->datalayout = EROFS_INODE_FLAT_INLINE;
-	nblocks = inode->i_size / erofs_blksiz(sbi);
+	nblocks = inode->i_size >> sbi->blkszbits;
 
 	ret = __allocate_inode_bh_data(inode, nblocks, DATA);
 	if (ret)
 		return ret;
 
-	for (i = 0; i < nblocks; ++i) {
-		char buf[EROFS_MAX_BLOCK_SIZE];
-
-		ret = read(fd, buf, erofs_blksiz(sbi));
-		if (ret != erofs_blksiz(sbi)) {
-			if (ret < 0)
-				return -errno;
-			return -EAGAIN;
-		}
-
-		ret = erofs_blk_write(sbi, buf, inode->u.i_blkaddr + i, 1);
-		if (ret)
-			return ret;
-	}
+	ret = erofs_io_xcopy(&sbi->bdev, erofs_pos(sbi, inode->u.i_blkaddr),
+			     &((struct erofs_vfile){ .fd = fd }),
+			     erofs_pos(sbi, nblocks));
+	if (ret)
+		return ret;
 
 	/* read the tail-end data */
 	inode->idata_size = inode->i_size % erofs_blksiz(sbi);
diff --git a/lib/io.c b/lib/io.c
index a2ef344..c2f8fe7 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -477,6 +477,10 @@ ssize_t erofs_io_read(struct erofs_vfile *vf, void *buf, size_t bytes)
         return i;
 }
 
+#ifdef HAVE_SYS_SENDFILE_H
+#include <sys/sendfile.h>
+#endif
+
 off_t erofs_io_lseek(struct erofs_vfile *vf, u64 offset, int whence)
 {
 	if (vf->ops)
@@ -484,3 +488,44 @@ off_t erofs_io_lseek(struct erofs_vfile *vf, u64 offset, int whence)
 
 	return lseek(vf->fd, offset, whence);
 }
+
+int erofs_io_xcopy(struct erofs_vfile *vout, off_t pos,
+		   struct erofs_vfile *vin, int len)
+{
+	if (vout->ops)
+		return vout->ops->xcopy(vout, pos, vin, len);
+
+#if defined(HAVE_SYS_SENDFILE_H) && defined(HAVE_SENDFILE)
+	if (len && !vin->ops) {		/* try to use sendfile() */
+		off_t ret;
+
+		ret = lseek(vout->fd, pos, SEEK_SET);
+		if (ret == pos) {
+			ret = sendfile(vout->fd, vin->fd, NULL, len);
+			if (ret > 0) {
+				pos += ret;
+				len -= ret;
+				if (!len)
+					return 0;
+			}
+		}
+	}
+#endif
+
+	do {
+		char buf[32768];
+		int ret = min_t(int, len, sizeof(buf));
+
+		ret = erofs_io_read(vin, buf, ret);
+		if (ret < 0)
+			return ret;
+		if (ret > 0) {
+			ret = erofs_io_pwrite(vout, buf, pos, ret);
+			if (ret < 0)
+				return ret;
+			pos += ret;
+		}
+		len -= ret;
+	} while (len);
+	return 0;
+}
-- 
2.39.3

