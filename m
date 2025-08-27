Return-Path: <linux-erofs+bounces-916-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB20B37A2F
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Aug 2025 08:11:54 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cBZ1N3rj0z30T8;
	Wed, 27 Aug 2025 16:11:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756275112;
	cv=none; b=IAnKQ7lk35Ikl5Eky2eBgsKihaq25l0CGp0W/jkH67Vkrkvkt5GebNRWy64Zu/gdng+kf7vWpi0++EweQYPLNYOAMRvAUmia8PPi4Xi4Ex1B7zTNfTeG6WUr60Kpni1VcZEeKpVL4rkmTnioVVlwxq9Jolai5kNeJVSSo05dxP12CKeDC4fOouOS+FxiHEVVxgYGmF8CI2gHhpoF4kvwfnfiY5srZwOYW4+p7fQhynw3VczSRbYPEyhgDVcojYI23m28JxgJW5CnN2L4XoNJrd0zS7OXtHlddNA2iTWvB0UimXVrzB+q6O9IZ4JQis1EgutJ7vnlRruv6h4+fR45uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756275112; c=relaxed/relaxed;
	bh=I7C2+cBBfCVWMJzy9ytFlCUn4fDkvYDG0YxBHg2ad5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hwHvgy2ziSnk4GK+86KhYEVcc1kSYTEdlwDXw12s5al7SG3Fta6VUbFT/ftImAe1bVdE9DDoBQvxeNp+bDQxnjJt2IoMpBm5bylEXVszBdQqEcZ12gJkvUkoHrqkyt5hP+BW4eRH0Lqm1QV97QiEbCwXCdXdFjArgrFZntIg4UpIRgYEt3uYDlWC28gxq5itVUWWihXlFmKPmlwag2+kgiqBTA0PHcyutAOuZIpA3iR1A5VD02buMHerTt+qFU8P0woPugbVu8v5xtyPFdbkw8sxCI+FzzkA2Jx2kIyWg85wTmE+NeadKYXst03kVQnyXqJCGhOsEYFVGuJICcl5lA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=paP/VhNz; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=paP/VhNz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cBZ1L26GWz2yDH
	for <linux-erofs@lists.ozlabs.org>; Wed, 27 Aug 2025 16:11:49 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756275106; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=I7C2+cBBfCVWMJzy9ytFlCUn4fDkvYDG0YxBHg2ad5o=;
	b=paP/VhNzeLt0TxaEDBPnJCh7L8IgGxNqcdITJ5mg/2IZnWSgFQD2V9tdQvjTC8tlBGP/OfFD+ngIJsMBkz9r0pW/+w3myMsmf7xIUAxRkNBrxyt/2EdSibv3luCcLwCYcb03yCixz/pTCzSxttxsVoeDd4GSSL0bPeHWjYBzGXY=
Received: from localhost.localdomain(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wmhqrmf_1756275100 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 27 Aug 2025 14:11:44 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: mount: add NBD backend support
Date: Wed, 27 Aug 2025 14:11:39 +0800
Message-ID: <20250827061139.1310-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
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

Currently, only local images are supported (so using the current NBD
backend is mostly for functional testing), e.g.:

However, it already uses the vfile interface, so extending it to
remote sources should be straightforward.

NBD failover is not supported yet and should be implemented via the
new netlink interface.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/defs.h |   9 ++
 include/erofs/io.h   |   6 ++
 lib/Makefile.am      |   4 +
 lib/backends/nbd.c   | 223 +++++++++++++++++++++++++++++++++++++++++++
 lib/io.c             |  69 ++++++++++++-
 lib/liberofs_nbd.h   |  39 ++++++++
 mount/main.c         | 156 +++++++++++++++++++++++++++++-
 7 files changed, 499 insertions(+), 7 deletions(-)
 create mode 100644 lib/backends/nbd.c
 create mode 100644 lib/liberofs_nbd.h

diff --git a/include/erofs/defs.h b/include/erofs/defs.h
index 0f3e754..8af99ae 100644
--- a/include/erofs/defs.h
+++ b/include/erofs/defs.h
@@ -88,6 +88,10 @@ typedef int64_t         s64;
 #define le32_to_cpu(x) ((__u32)(x))
 #define le64_to_cpu(x) ((__u64)(x))
 
+#define cpu_to_be32(x) ((__be32)__builtin_bswap32(x))
+#define cpu_to_be64(x) ((__be64)__builtin_bswap64(x))
+#define be32_to_cpu(x) (__builtin_bswap32(x))
+#define be64_to_cpu(x) (__builtin_bswap64(x))
 #else
 #if __BYTE_ORDER == __BIG_ENDIAN
 #define cpu_to_le16(x) (__builtin_bswap16(x))
@@ -96,6 +100,11 @@ typedef int64_t         s64;
 #define le16_to_cpu(x) (__builtin_bswap16(x))
 #define le32_to_cpu(x) (__builtin_bswap32(x))
 #define le64_to_cpu(x) (__builtin_bswap64(x))
+
+#define cpu_to_be32(x) ((__be32)(x))
+#define cpu_to_be64(x) ((__be64)(x))
+#define be32_to_cpu(x) ((__u32)(x))
+#define be64_to_cpu(x) ((__u64)(x))
 #else
 #pragma error
 #endif
diff --git a/include/erofs/io.h b/include/erofs/io.h
index cc7a3cd..370765f 100644
--- a/include/erofs/io.h
+++ b/include/erofs/io.h
@@ -16,6 +16,7 @@ extern "C"
 #define _GNU_SOURCE
 #endif
 #include <unistd.h>
+#include <sys/stat.h>
 #include <sys/uio.h>
 #include "defs.h"
 
@@ -36,6 +37,8 @@ struct erofs_vfops {
 	ssize_t (*read)(struct erofs_vfile *vf, void *buf, size_t len);
 	off_t (*lseek)(struct erofs_vfile *vf, u64 offset, int whence);
 	int (*fstat)(struct erofs_vfile *vf, struct stat *buf);
+	ssize_t (*sendfile)(struct erofs_vfile *vout, struct erofs_vfile *vin,
+			    off_t *pos, size_t count);
 	int (*xcopy)(struct erofs_vfile *vout, off_t pos,
 		     struct erofs_vfile *vin, unsigned int len, bool noseek);
 };
@@ -53,6 +56,7 @@ struct erofs_vfile {
 };
 
 ssize_t __erofs_io_write(int fd, const void *buf, size_t len);
+int __erofs_0write(int fd, size_t len);
 
 int erofs_io_fstat(struct erofs_vfile *vf, struct stat *buf);
 ssize_t erofs_io_pwrite(struct erofs_vfile *vf, const void *buf, u64 pos, size_t len);
@@ -67,6 +71,8 @@ off_t erofs_io_lseek(struct erofs_vfile *vf, u64 offset, int whence);
 
 ssize_t erofs_copy_file_range(int fd_in, u64 *off_in, int fd_out, u64 *off_out,
 			      size_t length);
+ssize_t erofs_io_sendfile(struct erofs_vfile *vout, struct erofs_vfile *vin,
+			  off_t *pos, size_t count);
 int erofs_io_xcopy(struct erofs_vfile *vout, off_t pos,
 		   struct erofs_vfile *vin, unsigned int len, bool noseek);
 
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 955495d..4f8e767 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -31,6 +31,7 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
       $(top_srcdir)/lib/liberofs_private.h \
       $(top_srcdir)/lib/liberofs_xxhash.h \
       $(top_srcdir)/lib/liberofs_metabox.h \
+      $(top_srcdir)/lib/liberofs_nbd.h \
       $(top_srcdir)/lib/liberofs_s3.h
 
 noinst_HEADERS += compressor.h
@@ -76,3 +77,6 @@ if ENABLE_EROFS_MT
 liberofs_la_LDFLAGS = -lpthread
 liberofs_la_SOURCES += workqueue.c
 endif
+if OS_LINUX
+liberofs_la_SOURCES += backends/nbd.c
+endif
diff --git a/lib/backends/nbd.c b/lib/backends/nbd.c
new file mode 100644
index 0000000..398a1e9
--- /dev/null
+++ b/lib/backends/nbd.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
+/*
+ * Copyright (C) 2025 Alibaba Cloud
+ */
+#include <errno.h>
+#include <sys/socket.h>
+#include <arpa/inet.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <sys/un.h>
+#include <sys/ioctl.h>
+#include <sys/types.h>
+#include <dirent.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include "erofs/io.h"
+#include "erofs/err.h"
+#include "erofs/print.h"
+#include "liberofs_nbd.h"
+
+#define NBD_SET_SOCK		_IO( 0xab, 0 )
+#define NBD_SET_BLKSIZE		_IO( 0xab, 1 )
+#define NBD_DO_IT		_IO( 0xab, 3 )
+#define NBD_CLEAR_SOCK		_IO( 0xab, 4 )
+#define NBD_SET_SIZE_BLOCKS     _IO( 0xab, 7 )
+#define NBD_SET_TIMEOUT		_IO( 0xab, 9 )
+#define NBD_SET_FLAGS		_IO( 0xab, 10)
+
+#define NBD_REQUEST_MAGIC	0x25609513
+#define NBD_REPLY_MAGIC		0x67446698
+
+#define NBD_FLAG_READ_ONLY	(1 << 1)	/* device is read-only */
+
+/*
+ * This is the reply packet that nbd-server sends back to the client after
+ * it has completed an I/O request (or an error occurs).
+ */
+struct nbd_reply {
+	__be32 magic;		/* NBD_REPLY_MAGIC */
+	__be32 error;		/* 0 = ok, else error */
+	union {
+		__be64 cookie;	/* Opaque identifier from request */
+		char handle[8];	/* older spelling of cookie */
+	};
+} __packed;
+
+long erofs_nbd_in_service(int nbdnum)
+{
+	int fd, err;
+	char s[32];
+
+	(void)snprintf(s, sizeof(s), "/sys/block/nbd%d/size", nbdnum);
+	fd = open(s, O_RDONLY);
+	if (fd < 0)
+		return -errno;
+	err = read(fd, s, sizeof(s));
+	if (err < 0) {
+		err = -errno;
+		close(fd);
+		return err;
+	}
+	close(fd);
+	if (!memcmp(s, "0\n", sizeof("0\n") - 1))
+		return -ENOTCONN;
+
+	(void)snprintf(s, sizeof(s), "/sys/block/nbd%d/pid", nbdnum);
+	fd = open(s, O_RDONLY);
+	if (fd < 0)
+		return -errno;
+	err = read(fd, s, sizeof(s));
+	if (err < 0) {
+		err = -errno;
+		close(fd);
+		return err;
+	}
+	close(fd);
+	return strtol(s, NULL, 10);
+}
+
+int erofs_nbd_devscan(void)
+{
+	DIR *_dir;
+	int err;
+
+	_dir = opendir("/sys/block");
+	if (!_dir) {
+		fprintf(stderr, "failed to opendir /sys/block: %s\n",
+			strerror(errno));
+		return -errno;
+	}
+
+	while (1) {
+		struct dirent *dp;
+		char path[64];
+
+		/*
+		 * set errno to 0 before calling readdir() in order to
+		 * distinguish end of stream and from an error.
+		 */
+		errno = 0;
+		dp = readdir(_dir);
+		if (!dp) {
+			if (errno)
+				err = -errno;
+			else
+				err = -EBUSY;
+			break;
+		}
+
+		if (strncmp(dp->d_name, "nbd", 3))
+			continue;
+
+		/* Skip nbdX with valid `pid` or `backend` */
+		err = snprintf(path, sizeof(path), "%s/pid", dp->d_name);
+		if (err < 0)
+			continue;
+		if (!faccessat(dirfd(_dir), path, F_OK, 0))
+			continue;
+		err = snprintf(path, sizeof(path), "%s/backend", dp->d_name);
+		if (err < 0)
+			continue;
+		if (!faccessat(dirfd(_dir), path, F_OK, 0))
+			continue;
+		err = atoi(dp->d_name + 3);
+		break;
+	}
+	closedir(_dir);
+	return err;
+}
+
+int erofs_nbd_connect(int nbdfd, int blkbits, u64 blocks)
+{
+	int sv[2], err;
+
+	err = socketpair(AF_UNIX, SOCK_STREAM, 0, sv);
+	if (err < 0)
+		return -errno;
+
+	err = ioctl(nbdfd, NBD_CLEAR_SOCK, 0);
+	if (err < 0)
+		goto err_out;
+
+	err = ioctl(nbdfd, NBD_SET_BLKSIZE, 1U << blkbits);
+	if (err < 0)
+		goto err_out;
+
+	err = ioctl(nbdfd, NBD_SET_SIZE_BLOCKS, blocks);
+	if (err < 0)
+		goto err_out;
+
+	err = ioctl(nbdfd, NBD_SET_TIMEOUT, 0);
+	if (err < 0)
+		goto err_out;
+
+	err = ioctl(nbdfd, NBD_SET_FLAGS, NBD_FLAG_READ_ONLY);
+	if (err < 0)
+		goto err_out;
+
+	err = ioctl(nbdfd, NBD_SET_SOCK, sv[1]);
+	if (err < 0)
+		goto err_out;
+	return sv[0];
+err_out:
+	close(sv[0]);
+	close(sv[1]);
+	return err;
+}
+
+int erofs_nbd_do_it(int nbdfd)
+{
+	int err;
+
+	err = ioctl(nbdfd, NBD_DO_IT, 0);
+	if (err < 0) {
+		if (errno == EPIPE)
+			/*
+			 * `ioctl(NBD_DO_IT)` normally returns EPIPE when someone has
+			 * disconnected the socket via NBD_DISCONNECT.  We do not want
+			 * to return 1 in that case.
+			*/
+			err = 0;
+		else
+			err = -errno;
+	}
+	if (err)
+		erofs_err("NBD_DO_IT ends with %s", erofs_strerror(err));
+	close(nbdfd);
+	return err;
+}
+
+int erofs_nbd_get_request(int skfd, struct erofs_nbd_request *rq)
+{
+	struct erofs_vfile vf = { .fd = skfd };
+	int err;
+
+	err = erofs_io_read(&vf, rq, sizeof(*rq));
+	if (err < sizeof(*rq))
+		return -EPIPE;
+
+	if (rq->magic != cpu_to_be32(NBD_REQUEST_MAGIC))
+		return -EIO;
+
+	rq->type = be32_to_cpu((__be32)rq->type);
+	rq->from = be64_to_cpu((__be64)rq->from);
+	rq->len = be32_to_cpu((__be32)rq->len);
+	return 0;
+}
+
+int erofs_nbd_send_reply_header(int skfd, __le64 cookie, int err)
+{
+	struct nbd_reply reply = {
+		.magic = cpu_to_be32(NBD_REPLY_MAGIC),
+		.error = cpu_to_be32(err),
+		.cookie = cookie,
+	};
+	int ret;
+
+	ret = write(skfd, &reply, sizeof(reply));
+	if (ret == sizeof(reply))
+		return 0;
+	return ret < 0 ? -errno : -EIO;
+}
diff --git a/lib/io.c b/lib/io.c
index b91c93c..ff3b794 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -147,10 +147,29 @@ int erofs_io_fsync(struct erofs_vfile *vf)
 	return 0;
 }
 
+static const char erofs_zeroed[EROFS_MAX_BLOCK_SIZE];
+
+int __erofs_0write(int fd, size_t len)
+{
+	int err = 0;
+
+	while (len) {
+		u32 count = min_t(u64, sizeof(erofs_zeroed), len);
+
+		err = write(fd, erofs_zeroed, count);
+		if (err <= 0) {
+			if (err < 0)
+				err = -errno;
+			break;
+		}
+		len -= err;
+	}
+	return err < 0 ? err : len;
+}
+
 int erofs_io_fallocate(struct erofs_vfile *vf, u64 offset,
 		       size_t len, bool zeroout)
 {
-	static const char zero[EROFS_MAX_BLOCK_SIZE] = {0};
 	ssize_t ret;
 
 	if (__erofs_unlikely(cfg.c_dry_run))
@@ -164,14 +183,15 @@ int erofs_io_fallocate(struct erofs_vfile *vf, u64 offset,
 		    FALLOC_FL_KEEP_SIZE, offset + vf->offset, len) >= 0)
 		return 0;
 #endif
-	while (len > EROFS_MAX_BLOCK_SIZE) {
-		ret = erofs_io_pwrite(vf, zero, offset, EROFS_MAX_BLOCK_SIZE);
+	while (len > sizeof(erofs_zeroed)) {
+		ret = erofs_io_pwrite(vf, erofs_zeroed, offset,
+				      sizeof(erofs_zeroed));
 		if (ret < 0)
 			return (int)ret;
 		len -= ret;
 		offset += ret;
 	}
-	return erofs_io_pwrite(vf, zero, offset, len) == len ? 0 : -EIO;
+	return erofs_io_pwrite(vf, erofs_zeroed, offset, len) == len ? 0 : -EIO;
 }
 
 int erofs_io_ftruncate(struct erofs_vfile *vf, u64 length)
@@ -551,6 +571,47 @@ off_t erofs_io_lseek(struct erofs_vfile *vf, u64 offset, int whence)
 	return lseek(vf->fd, offset, whence);
 }
 
+ssize_t erofs_io_sendfile(struct erofs_vfile *vout, struct erofs_vfile *vin,
+			  off_t *pos, size_t count)
+{
+	ssize_t written;
+
+	if (vin->ops || vout->ops) {
+		if (vin->ops)
+			return vin->ops->sendfile(vout, vin, pos, count);
+		return vout->ops->sendfile(vout, vin, pos, count);
+	}
+#if defined(HAVE_SYS_SENDFILE_H) && defined(HAVE_SENDFILE)
+	do {
+		written = sendfile(vout->fd, vin->fd, pos, count);
+		if (written <= 0) {
+			if (written < 0) {
+				written = -errno;
+				if (written == -EOVERFLOW && pos)
+					written = 0;
+			}
+			break;
+		}
+		count -= written;
+	} while (written);
+#endif
+	while (count) {
+		char buf[EROFS_MAX_BLOCK_SIZE];
+
+		written = min_t(u64, count, sizeof(buf));
+		if (pos)
+			written = erofs_io_pread(vin, buf, written, *pos);
+		else
+			written = erofs_io_read(vin, buf, written);
+		if (written <= 0)
+			break;
+		count -= written;
+		if (pos)
+			*pos += written;
+	}
+	return written < 0 ? written : count;
+}
+
 int erofs_io_xcopy(struct erofs_vfile *vout, off_t pos,
 		   struct erofs_vfile *vin, unsigned int len, bool noseek)
 {
diff --git a/lib/liberofs_nbd.h b/lib/liberofs_nbd.h
new file mode 100644
index 0000000..6660df1
--- /dev/null
+++ b/lib/liberofs_nbd.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
+/*
+ * Copyright (C) 2025 Alibaba Cloud
+ */
+#ifndef __EROFS_LIB_LIBEROFS_NBD_H
+#define __EROFS_LIB_LIBEROFS_NBD_H
+
+#include "erofs/defs.h"
+
+/* Supported request types */
+enum {
+	EROFS_NBD_CMD_READ		= 0,
+	EROFS_NBD_CMD_WRITE		= 1,
+	EROFS_NBD_CMD_DISC		= 2,
+	EROFS_NBD_CMD_FLUSH		= 3,
+	EROFS_NBD_CMD_TRIM		= 4,
+	/* userspace defines additional extension commands */
+	EROFS_NBD_CMD_WRITE_ZEROES	= 6,
+};
+
+struct erofs_nbd_request {
+	__be32 magic;			/* NBD_REQUEST_MAGIC */
+	u32 type;			/* See NBD_CMD_* */
+	union {
+		__be64 cookie;		/* Opaque identifier for request */
+		char   handle[8];	/* older spelling of cookie */
+	};
+	u64 from;
+        u32 len;
+} __packed;
+
+long erofs_nbd_in_service(int nbdnum);
+int erofs_nbd_devscan(void);
+int erofs_nbd_connect(int nbdfd, int blkbits, u64 blocks);
+int erofs_nbd_do_it(int nbdfd);
+int erofs_nbd_get_request(int skfd, struct erofs_nbd_request *rq);
+int erofs_nbd_send_reply_header(int skfd, __le64 cookie, int err);
+
+#endif
diff --git a/mount/main.c b/mount/main.c
index 0f7538a..9cb203f 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -6,10 +6,13 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sys/mount.h>
+#include <pthread.h>
 #include <unistd.h>
 #include "erofs/config.h"
 #include "erofs/print.h"
 #include "erofs/err.h"
+#include "erofs/io.h"
+#include "../lib/liberofs_nbd.h"
 #ifdef HAVE_LINUX_LOOP_H
 #include <linux/loop.h>
 #else
@@ -30,6 +33,7 @@ enum erofs_backend_drv {
 	EROFSAUTO,
 	EROFSLOCAL,
 	EROFSFUSE,
+	EROFSNBD,
 };
 
 static struct erofsmount_cfg {
@@ -132,6 +136,8 @@ static int erofsmount_parse_options(int argc, char **argv)
 					mountcfg.backend = EROFSFUSE;
 				} else if (!strcmp(dot + 1, "local")) {
 					mountcfg.backend = EROFSLOCAL;
+				} else if (!strcmp(dot + 1, "nbd")) {
+					mountcfg.backend = EROFSNBD;
 				} else {
 					erofs_err("invalid filesystem subtype `%s`", dot + 1);
 					return -EINVAL;
@@ -196,11 +202,148 @@ static int erofsmount_fuse(const char *source, const char *mountpoint,
 	return 0;
 }
 
+struct erofsmount_nbd_ctx {
+	struct erofs_vfile vd;		/* virtual device */
+	struct erofs_vfile sk;		/* socket file */
+};
+
+static void *erofsmount_nbd_loopfn(void *arg)
+{
+	struct erofsmount_nbd_ctx *ctx = arg;
+	int err;
+
+	while (1) {
+		struct erofs_nbd_request rq;
+		ssize_t rem;
+		off_t pos;
+
+		err = erofs_nbd_get_request(ctx->sk.fd, &rq);
+		if (err < 0) {
+			if (err == -EPIPE)
+				err = 0;
+			break;
+		}
+
+		if (rq.type != EROFS_NBD_CMD_READ) {
+			err = erofs_nbd_send_reply_header(ctx->sk.fd,
+						rq.cookie, -EIO);
+			if (err)
+				break;
+		}
+
+		erofs_nbd_send_reply_header(ctx->sk.fd, rq.cookie, 0);
+		pos = rq.from;
+		rem = erofs_io_sendfile(&ctx->sk, &ctx->vd, &pos, rq.len);
+		if (rem < 0) {
+			err = -errno;
+			break;
+		}
+		err = __erofs_0write(ctx->sk.fd, rem);
+		if (err) {
+			if (err > 0)
+				err = -EIO;
+			break;
+		}
+	}
+	close(ctx->vd.fd);
+	close(ctx->sk.fd);
+	return (void *)(uintptr_t)err;
+}
+
+static int erofsmount_startnbd(int nbdfd, const char *source)
+{
+	struct erofsmount_nbd_ctx ctx = {};
+	uintptr_t retcode;
+	pthread_t th;
+	int err, err2;
+
+	err = open(source, O_RDONLY);
+	if (err < 0) {
+		err = -errno;
+		goto out_closefd;
+	}
+	ctx.vd.fd = err;
+
+	err = erofs_nbd_connect(nbdfd, 9, INT64_MAX >> 9);
+	if (err < 0) {
+		close(ctx.vd.fd);
+		goto out_closefd;
+	}
+	ctx.sk.fd = err;
+
+	err = -pthread_create(&th, NULL, erofsmount_nbd_loopfn, &ctx);
+	if (err) {
+		close(ctx.vd.fd);
+		close(ctx.sk.fd);
+		goto out_closefd;
+	}
+
+	err = erofs_nbd_do_it(nbdfd);
+	err2 = -pthread_join(th, (void **)&retcode);
+	if (!err2 && retcode) {
+		erofs_err("NBD worker failed with %s",
+		          erofs_strerror(retcode));
+		err2 = retcode;
+	}
+	return err ?: err2;
+out_closefd:
+	close(nbdfd);
+	return err;
+}
+
+static int erofsmount_nbd(const char *source, const char *mountpoint,
+			  const char *fstype, int flags,
+			  const char *options)
+{
+	char nbdpath[32];
+	int num, nbdfd;
+	pid_t pid;
+	long err;
+
+	if (strcmp(fstype, "erofs")) {
+		fprintf(stderr, "unsupported filesystem type `%s`\n",
+			mountcfg.fstype);
+		return -ENODEV;
+	}
+	flags |= MS_RDONLY;
+
+	num = erofs_nbd_devscan();
+	if (num < 0)
+		return num;
+
+	(void)snprintf(nbdpath, sizeof(nbdpath), "/dev/nbd%d", num);
+	nbdfd = open(nbdpath, O_RDWR);
+	if (nbdfd < 0)
+		return -errno;
+
+	if ((pid = fork()) == 0)
+		return erofsmount_startnbd(nbdfd, source) ?
+			EXIT_FAILURE : EXIT_SUCCESS;
+	close(nbdfd);
+
+	while (1) {
+		err = erofs_nbd_in_service(num);
+		if (err == -ENOENT || err == -ENOTCONN) {
+			usleep(50000);
+			continue;
+		}
+		if (err >= 0)
+			err = (err != pid ? -EBUSY : 0);
+		break;
+	}
+	if (!err) {
+		err = mount(nbdpath, mountpoint, fstype, flags, options);
+		if (err < 0)
+			err = -errno;
+	}
+	return err;
+}
+
 #define EROFSMOUNT_LOOPDEV_RETRIES	3
 
-int erofsmount_loopmount(const char *source, const char *mountpoint,
-			 const char *fstype, int flags,
-			 const char *options)
+static int erofsmount_loopmount(const char *source, const char *mountpoint,
+				const char *fstype, int flags,
+				const char *options)
 {
 	int fd, dfd, num;
 	struct loop_info li = {};
@@ -269,6 +412,13 @@ int main(int argc, char *argv[])
 		goto exit;
 	}
 
+	if (mountcfg.backend == EROFSNBD) {
+		err = erofsmount_nbd(mountcfg.device, mountcfg.mountpoint,
+				     mountcfg.fstype, mountcfg.flags,
+				     mountcfg.options);
+		goto exit;
+	}
+
 	err = mount(mountcfg.device, mountcfg.mountpoint, mountcfg.fstype,
 		    mountcfg.flags, mountcfg.options);
 	if (err < 0)
-- 
2.43.0


