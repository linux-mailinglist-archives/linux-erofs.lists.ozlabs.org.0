Return-Path: <linux-erofs+bounces-1167-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 998C3BCB946
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Oct 2025 05:49:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cjXmv47jJz2xPy;
	Fri, 10 Oct 2025 14:49:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760068175;
	cv=none; b=REQORYiS82N2a9OLFWFM8SxQ/1bHYicBkMLgaBqfvg3z1hDPEIz3CVTIHazNprfimyTp7bk4DMAsqxaXfrHKVemgHIuPyWTI6KNUpchtaoyVc3RK8d8MgbTo+zCKN97J+p3t/qkHm+BoQR/9BwZwpBxidJ1u9gGbTgyBJNan5WVPaSBNuwqzzjbcCm3svXnmbsAw94ehv2255/sUl8PsIK/36WtmHqFgCsupHcSWOrOdI8VpHRU11J9YNgC02GkmuLKJDbjRHGAOoFnq8l90gAy6+fZ232RH3BnttwxJXp4p1mFVwvqD0xWZRccl6N0nbYEHzjoIIb62d5R+IneK5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760068175; c=relaxed/relaxed;
	bh=wUeW2xU+2n5/OLHAwP5FQfuJ3L1/wx/DLBWkP7zk+5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m1xfgKOEVCjDqya1MhfKwEu7+uOEmz7CYAlGhlgnqhHlSs+CHhPkjCpWl5x+fEhggJGzGhXTBKQ73uztq3spi+c0yLAmjsZX1/qY5M2oqzkpOG0g46M4wPa3GnRrIGZjYR+m6YVzZ8DDKJr3fd1XBJ84uvBbhrBj42RavC0kY/vPOwsVvk04q1jci0N0AT6Z1XNmJN9QQL/jETVl8qZqPpK8sGr1idbSwa2p03FFsXe7Ao8ec5FBbY3vxUMHvPAKaNkbO68E6GCFT5BhX7LMHivj+czjQM/fMtSgIzlOYHvg4wmBCTYuwf9GVhPq1TK0nhsqIOSVagibYeQW/jSCFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=a38Hw7eB; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=a38Hw7eB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cjXms4gxGz2xPx
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Oct 2025 14:49:32 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760068167; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=wUeW2xU+2n5/OLHAwP5FQfuJ3L1/wx/DLBWkP7zk+5g=;
	b=a38Hw7eBkHEIdbeHasZyKWGdvW7LwPXwmz8QuNG01ankzTLB3O7hmOuLJ0I0YxmZ3t/2W50Ew5bhWaSvrNsk4lyyg0HYMvbLJrwfHj+BeBaATdR3gB6jK/CDdwh+DA3WTr2qMh0/vE2t4kCnTPr1WLVnzHcd1fONIGPbUVXHvZc=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WprwzmE_1760068162 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 10 Oct 2025 11:49:26 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/2] erofs-utils: lib: fix erofs_io_sendfile()
Date: Fri, 10 Oct 2025 11:49:21 +0800
Message-ID: <20251010034922.1534943-1-hsiangkao@linux.alibaba.com>
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

The fallback logic was incomplete and has been fixed.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/io.h |  1 +
 lib/io.c           | 29 ++++++++++++++++++++++-------
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/include/erofs/io.h b/include/erofs/io.h
index a9f6d2e..4bc216a 100644
--- a/include/erofs/io.h
+++ b/include/erofs/io.h
@@ -35,6 +35,7 @@ struct erofs_vfops {
 	int (*fallocate)(struct erofs_vfile *vf, u64 offset, size_t len, bool pad);
 	int (*ftruncate)(struct erofs_vfile *vf, u64 length);
 	ssize_t (*read)(struct erofs_vfile *vf, void *buf, size_t len);
+	ssize_t (*write)(struct erofs_vfile *vf, void *buf, size_t len);
 	off_t (*lseek)(struct erofs_vfile *vf, u64 offset, int whence);
 	int (*fstat)(struct erofs_vfile *vf, struct stat *buf);
 	ssize_t (*sendfile)(struct erofs_vfile *vout, struct erofs_vfile *vin,
diff --git a/lib/io.c b/lib/io.c
index 664dd8d..d4cfbef 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -558,6 +558,13 @@ ssize_t erofs_io_read(struct erofs_vfile *vf, void *buf, size_t bytes)
         return i;
 }
 
+ssize_t erofs_io_write(struct erofs_vfile *vf, void *buf, size_t len)
+{
+	if (vf->ops)
+		return vf->ops->write(vf, buf, len);
+	return __erofs_io_write(vf->fd, buf, len);
+}
+
 #ifdef HAVE_SYS_SENDFILE_H
 #include <sys/sendfile.h>
 #endif
@@ -573,7 +580,7 @@ off_t erofs_io_lseek(struct erofs_vfile *vf, u64 offset, int whence)
 ssize_t erofs_io_sendfile(struct erofs_vfile *vout, struct erofs_vfile *vin,
 			  off_t *pos, size_t count)
 {
-	ssize_t written;
+	ssize_t read, written;
 
 	if (vin->ops || vout->ops) {
 		if (vin->ops)
@@ -597,16 +604,24 @@ ssize_t erofs_io_sendfile(struct erofs_vfile *vout, struct erofs_vfile *vin,
 	while (count) {
 		char buf[EROFS_MAX_BLOCK_SIZE];
 
-		written = min_t(u64, count, sizeof(buf));
+		read = min_t(u64, count, sizeof(buf));
 		if (pos)
-			written = erofs_io_pread(vin, buf, written, *pos);
+			read = erofs_io_pread(vin, buf, read, *pos);
 		else
-			written = erofs_io_read(vin, buf, written);
-		if (written <= 0)
+			read = erofs_io_read(vin, buf, read);
+		if (read <= 0) {
+			written = read;
 			break;
-		count -= written;
+		}
+		count -= read;
 		if (pos)
-			*pos += written;
+			*pos += read;
+		do {
+			written = erofs_io_write(vout, buf, read);
+			if (written < 0)
+				break;
+			read -= written;
+		} while (read);
 	}
 	return written < 0 ? written : count;
 }
-- 
2.43.5


