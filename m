Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CC9415044
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Sep 2021 20:56:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HF6wS50lJz2ynf
	for <lists+linux-erofs@lfdr.de>; Thu, 23 Sep 2021 04:56:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130;
 helo=out30-130.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HF6wD6vTqz2yZt
 for <linux-erofs@lists.ozlabs.org>; Thu, 23 Sep 2021 04:56:44 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0UpFo0Io_1632336968; 
Received: from
 e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UpFo0Io_1632336968) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 23 Sep 2021 02:56:28 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 4/5] erofs-utils: introduce copy_file_range
Date: Thu, 23 Sep 2021 02:56:06 +0800
Message-Id: <20210922185607.49909-5-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20210922185607.49909-1-hsiangkao@linux.alibaba.com>
References: <20210922185607.49909-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Liu Bo <bo.liu@linux.alibaba.com>,
 Peng Tao <tao.peng@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add copy_file_range support. Emulate it instead if libc
doesn't support it or have no emulation.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 configure.ac       |  1 +
 include/erofs/io.h |  5 +++
 lib/io.c           | 95 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+)

diff --git a/configure.ac b/configure.ac
index a749db0aed65..9d7d5c22e53f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -158,6 +158,7 @@ AC_CHECK_DECL(lseek64,[AC_DEFINE(HAVE_LSEEK64_PROTOTYPE, 1,
 # Checks for library functions.
 AC_CHECK_FUNCS(m4_flatten([
 	backtrace
+	copy_file_range
 	fallocate
 	gettimeofday
 	lgetxattr
diff --git a/include/erofs/io.h b/include/erofs/io.h
index 0763baf50dc3..2597bf48a1c4 100644
--- a/include/erofs/io.h
+++ b/include/erofs/io.h
@@ -7,6 +7,7 @@
 #ifndef __EROFS_IO_H
 #define __EROFS_IO_H
 
+#define _GNU_SOURCE
 #include <unistd.h>
 #include "internal.h"
 
@@ -24,6 +25,10 @@ int dev_fsync(void);
 int dev_resize(erofs_blk_t nblocks);
 u64 dev_length(void);
 
+int erofs_copy_file_range(int fd_in, erofs_off_t *off_in,
+                          int fd_out, erofs_off_t *off_out,
+                          size_t length);
+
 static inline int blk_write(const void *buf, erofs_blk_t blkaddr,
 			    u32 nblocks)
 {
diff --git a/lib/io.c b/lib/io.c
index 620cb9c960e1..504a69e4bdc1 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -258,3 +258,98 @@ int dev_read(void *buf, u64 offset, size_t len)
 	}
 	return 0;
 }
+
+static int __erofs_copy_file_range(int fd_in, erofs_off_t *off_in,
+				   int fd_out, erofs_off_t *off_out,
+				   size_t length)
+{
+	size_t copied = 0;
+	char buf[8192];
+
+	/*
+	 * Main copying loop.  The buffer size is arbitrary and is a
+	 * trade-off between stack size consumption, cache usage, and
+	 * amortization of system call overhead.
+	 */
+	while (length > 0) {
+		size_t to_read;
+		ssize_t read_count;
+		char *end, *p;
+
+		to_read = min_t(size_t, length, sizeof(buf));
+#ifdef HAVE_PREAD64
+		read_count = pread64(fd_in, buf, to_read, *off_in);
+#else
+		read_count = pread(fd_in, buf, to_read, *off_in);
+#endif
+		if (read_count == 0)
+			/* End of file reached prematurely. */
+			return copied;
+		if (read_count < 0) {
+			/* Report the number of bytes copied so far. */
+			if (copied > 0)
+				return copied;
+			return -1;
+		}
+		*off_in += read_count;
+
+		/* Write the buffer part which was read to the destination. */
+		end = buf + read_count;
+		for (p = buf; p < end; ) {
+			ssize_t write_count;
+
+#ifdef HAVE_PWRITE64
+			write_count = pwrite64(fd_out, p, end - p, *off_out);
+#else
+			write_count = pwrite(fd_out, p, end - p, *off_out);
+#endif
+			if (write_count < 0) {
+				/*
+				 * Adjust the input read position to match what
+				 * we have written, so that the caller can pick
+				 * up after the error.
+				 */
+				size_t written = p - buf;
+				/*
+				 * NB: This needs to be signed so that we can
+				 * form the negative value below.
+				 */
+				ssize_t overread = read_count - written;
+
+				*off_in -= overread;
+				/* Report the number of bytes copied so far. */
+				if (copied + written > 0)
+					return copied + written;
+				return -1;
+			}
+			p += write_count;
+			*off_out += write_count;
+		} /* Write loop.  */
+		copied += read_count;
+		length -= read_count;
+	}
+	return copied;
+}
+
+int erofs_copy_file_range(int fd_in, erofs_off_t *off_in,
+			  int fd_out, erofs_off_t *off_out,
+			  size_t length)
+{
+#ifdef HAVE_COPY_FILE_RANGE
+	off64_t off64_in = *off_in, off64_out = *off_out;
+	ssize_t ret;
+
+	ret = copy_file_range(fd_in, &off64_in, fd_out, &off64_out,
+                              length, 0);
+	if (ret >= 0)
+		goto out;
+	if (errno != ENOSYS) {
+		ret = -errno;
+out:
+		*off_in = off64_in;
+		*off_out = off64_out;
+		return ret;
+	}
+#endif
+	return __erofs_copy_file_range(fd_in, off_in, fd_out, off_out, length);
+}
-- 
2.24.4

