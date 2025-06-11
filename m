Return-Path: <linux-erofs+bounces-392-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDB8AD494A
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Jun 2025 05:25:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bH9yq2VLrz307V;
	Wed, 11 Jun 2025 13:25:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749612323;
	cv=none; b=MFvfT7qWzDxOaifDvcCriUEHQc+EwIk2eCuNcPhLkiPbx2SV0juNESS9Z6XZ7yLbkMH7MsG6cyAul5aZ40YDmPt4ng0j3SuykKnVyEPijGePwdlWI28PEUrKXEUqk4ruEJ03AxqFMqYXGdiVs4ObyJkrwolUlnbt3PgGg+ES2ALWe6p898guRmO++uJu8U2+MMnac6ROJdxnpWiN3HyDSrDRnLlU8u5b+9YvnE0EFEUVgCqajQIZbmFdvRU1WEQ5Q9uekD0OYG9Z8fvch/cBz0+P/cCRgzaIrW8pkSAw7zWcRl0zJuVMgRzkcdR/xqOLmpjJPHdx4Xqi2o2eKeuwNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749612323; c=relaxed/relaxed;
	bh=HrgSRTact9Iu+iCYMQpltkYJ6mHiejcdWw1aZhnRqf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CE6NesPh+trmIFEjrgajbps2FTu5a90QBK/dtLTaWFUlZEORGYsTEbNDa5Lee937xDHsfOIKj1Cagd3n7oxJc+s36maMELNCVZONY5enejp2fbHDcwQAl8EciCiP1GZmyEe7Kk+Nl9TIAXk91JeGRqlcaLMMoVk90y5CmJbDQTcd5GxTwJjZ/FTunpOJah8uyezoEi7JlNNinN9NAxFrZKR8y3YxZJGzv5ou4LTQLo21MImwtekyhvgsnTmXAU615E6IidbI3MzkrA+yveUZPtt9fbu4whB2nlVZsBCt3IJjqbttzETAPjlJeahoM3Rmh6An6mo+NcpEBybcT8WkbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Y1sQ1o1v; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Y1sQ1o1v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bH9ym6sQ3z2xHY
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Jun 2025 13:25:19 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1749612315; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=HrgSRTact9Iu+iCYMQpltkYJ6mHiejcdWw1aZhnRqf4=;
	b=Y1sQ1o1vs+XbVjrappDj1du5Mc/08DFW3pvAApYtN7W5WT4jPMgdEPsa+SkCdRJMX/Zpw3E2MR0n+VTvC4PuNnapNU8DFfYrDBlNc79NWHsPPymHsTXI93q94amQgX1YIzx+LAulIGwa/dOFj3Uv4qG82rtM+2C9DUtGql8hEmU=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WdbREmS_1749612310 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Jun 2025 11:25:14 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: mkfs: avoid partial writes in erofs_write_tail_end()
Date: Wed, 11 Jun 2025 11:25:09 +0800
Message-ID: <20250611032509.318348-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Partial writes to a physical block device (rather than to some hole in
a regular file) can cause unnecessary read-modify-write cycles.  In
particular, redundant reads can take noticeable overhead on cloud disks.

Write full blocks with pwritev(2) instead.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 configure.ac       |  2 ++
 include/erofs/io.h |  5 +++++
 lib/inode.c        | 33 +++++++++++++++------------------
 lib/io.c           | 33 +++++++++++++++++++++++++++++++++
 4 files changed, 55 insertions(+), 18 deletions(-)

diff --git a/configure.ac b/configure.ac
index 88f1cbe..a73a9ba 100644
--- a/configure.ac
+++ b/configure.ac
@@ -216,6 +216,7 @@ AC_CHECK_HEADERS(m4_flatten([
 	sys/statfs.h
 	sys/sysmacros.h
 	sys/time.h
+	sys/uio.h
 	unistd.h
 ]))
 
@@ -274,6 +275,7 @@ AC_CHECK_FUNCS(m4_flatten([
 	ftello64
 	pread64
 	pwrite64
+	pwritev
 	posix_fadvise
 	fstatfs
 	sendfile
diff --git a/include/erofs/io.h b/include/erofs/io.h
index 3179ea1..101a5ba 100644
--- a/include/erofs/io.h
+++ b/include/erofs/io.h
@@ -16,6 +16,7 @@ extern "C"
 #define _GNU_SOURCE
 #endif
 #include <unistd.h>
+#include <sys/uio.h>
 #include "defs.h"
 
 #ifndef O_BINARY
@@ -27,6 +28,8 @@ struct erofs_vfile;
 struct erofs_vfops {
 	ssize_t (*pread)(struct erofs_vfile *vf, void *buf, u64 offset, size_t len);
 	ssize_t (*pwrite)(struct erofs_vfile *vf, const void *buf, u64 offset, size_t len);
+	ssize_t (*pwritev)(struct erofs_vfile *vf, const struct iovec *iov,
+			   int iovcnt, u64 pos);
 	int (*fsync)(struct erofs_vfile *vf);
 	int (*fallocate)(struct erofs_vfile *vf, u64 offset, size_t len, bool pad);
 	int (*ftruncate)(struct erofs_vfile *vf, u64 length);
@@ -53,6 +56,8 @@ ssize_t __erofs_io_write(int fd, const void *buf, size_t len);
 
 int erofs_io_fstat(struct erofs_vfile *vf, struct stat *buf);
 ssize_t erofs_io_pwrite(struct erofs_vfile *vf, const void *buf, u64 pos, size_t len);
+ssize_t erofs_io_pwritev(struct erofs_vfile *vf, const struct iovec *iov,
+			 int iovcnt, u64 pos);
 int erofs_io_fsync(struct erofs_vfile *vf);
 ssize_t erofs_io_fallocate(struct erofs_vfile *vf, u64 offset, size_t len, bool pad);
 int erofs_io_ftruncate(struct erofs_vfile *vf, u64 length);
diff --git a/lib/inode.c b/lib/inode.c
index a36ade2..09f519b 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -827,6 +827,7 @@ static struct erofs_bhops erofs_write_inline_bhops = {
 
 static int erofs_write_tail_end(struct erofs_inode *inode)
 {
+	static const u8 zeroed[EROFS_MAX_BLOCK_SIZE];
 	struct erofs_sb_info *sbi = inode->sbi;
 	struct erofs_buffer_head *bh, *ibh;
 
@@ -843,8 +844,10 @@ static int erofs_write_tail_end(struct erofs_inode *inode)
 		ibh->fsprivate = erofs_igrab(inode);
 		ibh->op = &erofs_write_inline_bhops;
 	} else {
+		struct iovec iov[2];
+		erofs_off_t pos;
 		int ret;
-		erofs_off_t pos, zero_pos;
+		bool h0;
 
 		if (!bh) {
 			bh = erofs_balloc(sbi->bmgr,
@@ -874,25 +877,19 @@ static int erofs_write_tail_end(struct erofs_inode *inode)
 		pos = erofs_btell(bh, true) - erofs_blksiz(sbi);
 
 		/* 0'ed data should be padded at head for 0padding conversion */
-		if (erofs_sb_has_lz4_0padding(sbi) && inode->compressed_idata) {
-			zero_pos = pos;
-			pos += erofs_blksiz(sbi) - inode->idata_size;
-		} else {
-			/* pad 0'ed data for the other cases */
-			zero_pos = pos + inode->idata_size;
-		}
-		ret = erofs_dev_write(sbi, inode->idata, pos, inode->idata_size);
-		if (ret)
+		h0 = erofs_sb_has_lz4_0padding(sbi) && inode->compressed_idata;
+		DBG_BUGON(inode->idata_size > erofs_blksiz(sbi));
+
+		iov[h0] = (struct iovec) { .iov_base = inode->idata,
+					   .iov_len = inode->idata_size };
+		iov[!h0] = (struct iovec) { .iov_base = (u8 *)zeroed,
+				erofs_blksiz(sbi) - inode->idata_size };
+		ret = erofs_io_pwritev(&sbi->bdev, iov, 2, pos);
+		if (ret < 0)
 			return ret;
+		else if (ret < erofs_blksiz(sbi))
+			return -EIO;
 
-		DBG_BUGON(inode->idata_size > erofs_blksiz(sbi));
-		if (inode->idata_size < erofs_blksiz(sbi)) {
-			ret = erofs_dev_fillzero(sbi, zero_pos,
-					   erofs_blksiz(sbi) - inode->idata_size,
-					   false);
-			if (ret)
-				return ret;
-		}
 		inode->idata_size = 0;
 		free(inode->idata);
 		inode->idata = NULL;
diff --git a/lib/io.c b/lib/io.c
index 5c3d263..aa043ca 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -96,6 +96,39 @@ ssize_t erofs_io_pwrite(struct erofs_vfile *vf, const void *buf,
 	return written;
 }
 
+ssize_t erofs_io_pwritev(struct erofs_vfile *vf, const struct iovec *iov,
+			 int iovcnt, u64 pos)
+{
+	ssize_t ret, written;
+	int i;
+
+	if (__erofs_unlikely(cfg.c_dry_run))
+		return 0;
+
+#ifdef HAVE_PWRITEV
+	if (!vf->ops) {
+		ret = pwritev(vf->fd, iov, iovcnt, pos + vf->offset);
+		if (ret < 0)
+			return -errno;
+		return ret;
+	}
+#endif
+	if (vf->ops && vf->ops->pwritev)
+		return vf->ops->pwritev(vf, iov, iovcnt, pos);
+	written = 0;
+	for (i = 0; i < iovcnt; ++i) {
+		ret = erofs_io_pwrite(vf, iov[i].iov_base, pos, iov[i].iov_len);
+		if (ret < iov[i].iov_len) {
+			if (ret < 0)
+				return ret;
+			return written + ret;
+		}
+		written += iov[i].iov_len;
+		pos += iov[i].iov_len;
+	}
+	return written;
+}
+
 int erofs_io_fsync(struct erofs_vfile *vf)
 {
 	int ret;
-- 
2.43.5


