Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3FE3EFD46
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Aug 2021 09:03:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GqJll4T2Mz3bX0
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Aug 2021 17:03:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131;
 helo=out30-131.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GqJlW6ggcz30BD
 for <linux-erofs@lists.ozlabs.org>; Wed, 18 Aug 2021 17:03:33 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=8; SR=0; TI=SMTPD_---0UjgIOt5_1629270197; 
Received: from
 e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UjgIOt5_1629270197) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 18 Aug 2021 15:03:27 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
 Liu Bo <bo.liu@linux.alibaba.com>
Subject: [PATCH 3/4] erofs-utils: introduce copy_file_range
Date: Wed, 18 Aug 2021 15:03:15 +0800
Message-Id: <20210818070316.1970-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20210818070316.1970-1-hsiangkao@linux.alibaba.com>
References: <20210818070316.1970-1-hsiangkao@linux.alibaba.com>
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
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>,
 Eryu Guan <eguan@linux.alibaba.com>, Liu Jiang <gerry@linux.alibaba.com>,
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
index 7217cf531265..af1d06c15996 100644
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
index 557424578ece..5b685d217a0f 100644
--- a/include/erofs/io.h
+++ b/include/erofs/io.h
@@ -9,6 +9,7 @@
 #ifndef __EROFS_IO_H
 #define __EROFS_IO_H
 
+#define _GNU_SOURCE
 #include <unistd.h>
 #include "internal.h"
 
@@ -26,6 +27,10 @@ int dev_fsync(void);
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
index 6067041fd829..e4083bb53c27 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -261,3 +261,98 @@ int dev_read(void *buf, u64 offset, size_t len)
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

