Return-Path: <linux-erofs+bounces-2706-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Bb1MvvBtmkWHwEAu9opvQ
	(envelope-from <linux-erofs+bounces-2706-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Mar 2026 15:28:11 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C908D291076
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Mar 2026 15:28:10 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fYgYZ3XFrz2yYy;
	Mon, 16 Mar 2026 01:28:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.56
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773584882;
	cv=none; b=X7knSU/Np92VBkiDikzX+CGoDSv94qV1xfnlP1mjE7zMbiO8uELFDl7kKWKcjGyF9Eps/ZemkBqMUc1PxCwD6fE4Mk6HXO3s+7Obq9XwJDkkKYC+DYsDFYsUKvwRdjx2r0kzt3/xJNA6o7/UBuxl54vwr+CG8y9dz2SOFKkR0TUKNHG5UGoCWgFLtqxeyIbIGQ4rzYM/4xifDu6rX4RtsY9sJ9iyTkRqQTzrkTiV0vc8tR+4QBeuVWm4JxNHrvAvqIjdClZaow9cItv7LlYtc6zLrCy4JpNdr7pkpRrp2QCaQUnZTwP/nkUy6RfTPdhhZVGalz6FVqMK7QSTvjSzPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773584882; c=relaxed/relaxed;
	bh=h0U/UJiGZslaK+UcAmE7FLSKuuiBJIrLcXZ9LbNd160=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mk/9DrXJOrJgUvcr2SXFrCj3dYPRtZzAmKGVODQsGW5657dBh/LgLPiX+UGZTJcqfvlz106yn5LDerouugljEGK7XLWnW05+TvREtozQ7PrEqydm/wukQtvIyvlCApvTHkAUsLFsBfqkMhxWtcNUGlLrTq+XqrRF/wQSLtR64OPXkrzP58Z8gpleK1VarwuafHS+ZTYRKZCvR0uEnFleNM6DCRPShGpKCuGlafzDefU3Wb6p2lcA3tTirpAhvdcPM1NnsXbx0AjDaQfz8BtUlHFZYpMQongfwyZbevI1vNjtyFeWTjlu03Te2su8QIRRtD5cyDZfYuwyyJXXilPqlw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.56; helo=out28-56.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.56; helo=out28-56.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-56.mail.aliyun.com (out28-56.mail.aliyun.com [115.124.28.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fYgYW1jqMz2yZ8
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 01:27:58 +1100 (AEDT)
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07355791|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00320115-0.00365682-0.993142;FP=15722396229474129915|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037022039;MF=hudson@cyzhu.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.gsmlGz._1773584869;
Received: from HUDSONZHU-MB0.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.gsmlGz._1773584869 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 15 Mar 2026 22:27:49 +0800
From: Chengyu <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH 3/4] erofs-utils: add ublk userspace block device backend
Date: Sun, 15 Mar 2026 22:27:44 +0800
Message-ID: <20260315142745.56845-4-hudson@cyzhu.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260315142745.56845-1-hudson@cyzhu.com>
References: <20260315142745.56845-1-hudson@cyzhu.com>
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
X-Spam-Status: No, score=0.0 required=3.0 tests=RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [0.00 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2706-lists,linux-erofs=lfdr.de];
	DMARC_NA(0.00)[cyzhu.com];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	NEURAL_HAM(-0.00)[-0.792];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[hudson@cyzhu.com,linux-erofs@lists.ozlabs.org];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,cyzhu.com:mid]
X-Rspamd-Queue-Id: C908D291076
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chengyu Zhu <hudsonzhu@tencent.com>

Add a ublk backend powered by io_uring. This provides
an alternative to nbd for exposing an erofs image
as a block device.

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
---
 configure.ac        |   34 +
 lib/Makefile.am     |    9 +-
 lib/backends/ublk.c | 1429 +++++++++++++++++++++++++++++++++++++++++++
 lib/liberofs_ublk.h |   53 ++
 4 files changed, 1524 insertions(+), 1 deletion(-)
 create mode 100644 lib/backends/ublk.c
 create mode 100644 lib/liberofs_ublk.h

diff --git a/configure.ac b/configure.ac
index 8a8e9b3..08f16e5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -185,6 +185,10 @@ AC_ARG_WITH(libnl3,
    [AS_HELP_STRING([--with-libnl3],
       [Enable and build with libnl3 support @<:@default=auto@:>@])])
 
+AC_ARG_ENABLE(ublk,
+   [AS_HELP_STRING([--enable-ublk], [enable ublk block device support @<:@default=no@:>@])],
+   [enable_ublk="$enableval"], [enable_ublk="no"])
+
 AC_ARG_ENABLE(s3,
    [AS_HELP_STRING([--enable-s3], [enable s3 image generation support @<:@default=no@:>@])],
    [enable_s3="$enableval"], [enable_s3="no"])
@@ -727,6 +731,29 @@ AS_IF([test "x$with_libnl3" != "xno"], [
   ])
 ])
 
+# Configure ublk (requires liburing)
+have_ublk="no"
+AS_IF([test "x$enable_ublk" = "xyes"], [
+  PKG_CHECK_MODULES([liburing], [liburing >= 2.0], [
+    # Paranoia: don't trust the result reported by pkgconfig before trying out
+    saved_LIBS="$LIBS"
+    saved_CPPFLAGS=${CPPFLAGS}
+    CPPFLAGS="${liburing_CFLAGS} ${CPPFLAGS}"
+    LIBS="${liburing_LIBS} $LIBS"
+    AC_CHECK_HEADERS([liburing.h],[
+      AC_CHECK_LIB(uring, io_uring_queue_init, [], [
+        AC_MSG_ERROR([liburing doesn't work properly])])
+      AC_CHECK_DECL(io_uring_queue_init, [have_ublk="yes"],
+        [AC_MSG_ERROR([liburing doesn't work properly])], [[
+#include <liburing.h>
+      ]])
+    ])
+    LIBS="${saved_LIBS}"
+    CPPFLAGS="${saved_CPPFLAGS}"], [
+    AC_MSG_ERROR([ublk requires liburing >= 2.0])
+  ])
+])
+
 AS_IF([test "x$enable_s3" != "xno"], [
   AS_IF(
     [test "x$have_libcurl" = "xyes" && \
@@ -766,6 +793,7 @@ AM_CONDITIONAL([ENABLE_LIBXML2], [test "x${have_libxml2}" = "xyes"])
 AM_CONDITIONAL([ENABLE_S3], [test "x${have_s3}" = "xyes"])
 AM_CONDITIONAL([ENABLE_STATIC_FUSE], [test "x${enable_static_fuse}" = "xyes"])
 AM_CONDITIONAL([ENABLE_OCI], [test "x${have_oci}" = "xyes"])
+AM_CONDITIONAL([ENABLE_UBLK], [test "x${have_ublk}" = "xyes"])
 
 if test "x$have_uuid" = "xyes"; then
   AC_DEFINE([HAVE_LIBUUID], 1, [Define to 1 if libuuid is found])
@@ -842,6 +870,12 @@ if test "x$have_oci" = "xyes"; then
   AC_DEFINE([OCIEROFS_ENABLED], 1, [Define to 1 if OCI registry is enabled])
 fi
 
+if test "x$have_ublk" = "xyes"; then
+  AC_DEFINE([HAVE_LIBURING], 1, [Define to 1 if liburing is found])
+  AC_SUBST([liburing_LIBS])
+  AC_SUBST([liburing_CFLAGS])
+fi
+
 # Dump maximum block size
 AS_IF([test "x$erofs_cv_max_block_size" = "x"],
       [$erofs_cv_max_block_size = 4096], [])
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 77f6fd8..fd94e46 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -33,7 +33,8 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
       $(top_srcdir)/lib/liberofs_gzran.h \
       $(top_srcdir)/lib/liberofs_metabox.h \
       $(top_srcdir)/lib/liberofs_nbd.h \
-      $(top_srcdir)/lib/liberofs_s3.h
+      $(top_srcdir)/lib/liberofs_s3.h \
+      $(top_srcdir)/lib/liberofs_ublk.h
 
 noinst_HEADERS += compressor.h
 liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
@@ -89,6 +90,12 @@ liberofs_la_CFLAGS += ${libnl3_CFLAGS}
 liberofs_la_LDFLAGS += ${libnl3_LIBS}
 liberofs_la_SOURCES += backends/nbd.c
 endif
+
+if ENABLE_UBLK
+liberofs_la_CFLAGS += ${liburing_CFLAGS}
+liberofs_la_LDFLAGS += ${liburing_LIBS}
+liberofs_la_SOURCES += backends/ublk.c
+endif
 liberofs_la_SOURCES += remotes/oci.c remotes/docker_config.c
 liberofs_la_CFLAGS += ${json_c_CFLAGS}
 liberofs_la_LDFLAGS += ${json_c_LIBS}
diff --git a/lib/backends/ublk.c b/lib/backends/ublk.c
new file mode 100644
index 0000000..c1ef0a9
--- /dev/null
+++ b/lib/backends/ublk.c
@@ -0,0 +1,1429 @@
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
+/*
+ * Copyright (C) 2026 Tencent, Inc.
+ *             http://www.tencent.com/
+ */
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <pthread.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <sys/resource.h>
+#include <sys/types.h>
+#include <sys/eventfd.h>
+#include <sys/prctl.h>
+#include <unistd.h>
+#include <linux/io_uring.h>
+
+#include "erofs/err.h"
+#include "erofs/print.h"
+#include "liberofs_ublk.h"
+
+#ifdef HAVE_LIBURING
+#include <liburing.h>
+#endif
+
+#ifndef PR_SET_IO_FLUSHER
+#define PR_SET_IO_FLUSHER 49
+#endif
+
+#define UBLK_CMD_GET_QUEUE_AFFINITY	0x01
+#define UBLK_CMD_GET_DEV_INFO		0x02
+#define UBLK_CMD_ADD_DEV		0x04
+#define UBLK_CMD_DEL_DEV		0x05
+#define UBLK_CMD_START_DEV		0x06
+#define UBLK_CMD_STOP_DEV		0x07
+#define UBLK_CMD_SET_PARAMS		0x08
+#define UBLK_CMD_GET_PARAMS		0x09
+#define UBLK_CMD_START_USER_RECOVERY	0x10
+#define UBLK_CMD_END_USER_RECOVERY	0x11
+
+#define UBLK_IO_FETCH_REQ		0x20
+#define UBLK_IO_COMMIT_AND_FETCH_REQ	0x21
+#define UBLK_IO_NEED_GET_DATA		0x22
+
+#define UBLK_U_CMD_GET_QUEUE_AFFINITY	\
+	_IOR('u', UBLK_CMD_GET_QUEUE_AFFINITY, struct ublksrv_ctrl_cmd)
+#define UBLK_U_CMD_GET_DEV_INFO		\
+	_IOR('u', UBLK_CMD_GET_DEV_INFO, struct ublksrv_ctrl_cmd)
+#define UBLK_U_CMD_ADD_DEV		\
+	_IOWR('u', UBLK_CMD_ADD_DEV, struct ublksrv_ctrl_cmd)
+#define UBLK_U_CMD_DEL_DEV		\
+	_IOWR('u', UBLK_CMD_DEL_DEV, struct ublksrv_ctrl_cmd)
+#define UBLK_U_CMD_START_DEV		\
+	_IOWR('u', UBLK_CMD_START_DEV, struct ublksrv_ctrl_cmd)
+#define UBLK_U_CMD_STOP_DEV		\
+	_IOWR('u', UBLK_CMD_STOP_DEV, struct ublksrv_ctrl_cmd)
+#define UBLK_U_CMD_SET_PARAMS		\
+	_IOWR('u', UBLK_CMD_SET_PARAMS, struct ublksrv_ctrl_cmd)
+#define UBLK_U_CMD_GET_PARAMS		\
+	_IOR('u', UBLK_CMD_GET_PARAMS, struct ublksrv_ctrl_cmd)
+#define UBLK_U_CMD_START_USER_RECOVERY	\
+	_IOWR('u', UBLK_CMD_START_USER_RECOVERY, struct ublksrv_ctrl_cmd)
+#define UBLK_U_CMD_END_USER_RECOVERY	\
+	_IOWR('u', UBLK_CMD_END_USER_RECOVERY, struct ublksrv_ctrl_cmd)
+#define UBLK_U_CMD_DEL_DEV_ASYNC	\
+	_IOR('u', 0x14, struct ublksrv_ctrl_cmd)
+
+#define UBLK_U_IO_FETCH_REQ		\
+	_IOWR('u', UBLK_IO_FETCH_REQ, struct ublksrv_io_cmd)
+#define UBLK_U_IO_COMMIT_AND_FETCH_REQ	\
+	_IOWR('u', UBLK_IO_COMMIT_AND_FETCH_REQ, struct ublksrv_io_cmd)
+#define UBLK_U_IO_NEED_GET_DATA		\
+	_IOWR('u', UBLK_IO_NEED_GET_DATA, struct ublksrv_io_cmd)
+
+#define UBLK_F_URING_CMD_COMP_IN_TASK	(1ULL << 1)
+#define UBLK_F_USER_RECOVERY		(1ULL << 3)
+#define UBLK_F_UNPRIVILEGED_DEV		(1ULL << 5)
+#define UBLK_F_CMD_IOCTL_ENCODE		(1ULL << 6)
+#define UBLK_F_USER_COPY		(1ULL << 7)
+
+#define UBLK_S_DEV_QUIESCED	2
+#define UBLK_S_DEV_FAIL_IO	3
+
+#define UBLK_IO_RES_NEED_GET_DATA	1
+#define UBLK_IO_RES_ABORT		(-ENODEV)
+
+#define UBLKSRV_CMD_BUF_OFFSET		0
+#define UBLKSRV_IO_BUF_OFFSET		0x80000000
+
+#define UBLK_MAX_QUEUE_DEPTH		4096
+
+#define UBLK_IO_BUF_BITS		25
+#define UBLK_IO_BUF_BITS_MASK		((1ULL << UBLK_IO_BUF_BITS) - 1)
+#define UBLK_TAG_OFF			UBLK_IO_BUF_BITS
+#define UBLK_TAG_BITS			16
+#define UBLK_QID_OFF			(UBLK_TAG_OFF + UBLK_TAG_BITS)
+
+#define UBLK_IO_OP_READ			0
+
+struct ublksrv_ctrl_cmd {
+	__u32 dev_id;
+	__u16 queue_id;
+	__u16 len;
+	__u64 addr;
+	__u64 data[1];
+	__u16 dev_path_len;
+	__u16 pad;
+	__u32 reserved;
+};
+
+struct ublksrv_ctrl_dev_info {
+	__u16 nr_hw_queues;
+	__u16 queue_depth;
+	__u16 state;
+	__u16 pad0;
+	__u32 max_io_buf_bytes;
+	__u32 dev_id;
+	__s32 ublksrv_pid;
+	__u32 pad1;
+	__u64 flags;
+	__u64 ublksrv_flags;
+	__u32 owner_uid;
+	__u32 owner_gid;
+	__u64 reserved1;
+	__u64 reserved2;
+};
+
+struct ublksrv_io_cmd {
+	__u16 q_id;
+	__u16 tag;
+	__s32 result;
+	__u64 addr;
+};
+
+struct ublksrv_io_desc {
+	__u32 op_flags;
+	__u32 nr_sectors;
+	__u64 start_sector;
+	__u64 addr;
+};
+
+#define UBLK_PARAM_TYPE_BASIC		(1 << 0)
+
+struct ublk_param_basic {
+#define UBLK_ATTR_READ_ONLY		(1 << 0)
+	__u32 attrs;
+	__u8 logical_bs_shift;
+	__u8 physical_bs_shift;
+	__u8 io_opt_shift;
+	__u8 io_min_shift;
+	__u32 max_sectors;
+	__u32 chunk_sectors;
+	__u64 dev_sectors;
+	__u64 virt_boundary_mask;
+};
+
+struct ublk_params {
+	__u32 len;
+	__u32 types;
+	struct ublk_param_basic basic;
+};
+
+
+#ifdef HAVE_LIBURING
+
+#define EROFS_UBLK_DEF_NR_HW_QUEUES	1
+#define EROFS_UBLK_DEF_QUEUE_DEPTH	128
+#define EROFS_UBLK_DEF_MAX_IO_BUF_BYTES	(512 * 1024)
+#define EROFS_UBLK_DEF_BLK_BITS		12
+
+#define UBLKSRV_IO_FREE			(1U << 0)
+#define UBLKSRV_NEED_COMMIT_RQ_COMP	(1U << 2)
+#define UBLKSRV_IO_NEED_GET_DATA	(1U << 3)
+
+#define UBLKSRV_QUEUE_STOPPING		(1U << 0)
+#define UBLKSRV_QUEUE_IDLE		(1U << 1)
+
+struct erofs_ublk_io {
+	unsigned int flags;
+	int result;
+};
+
+struct erofs_ublk_queue {
+	int q_id;
+	int q_depth;
+	struct erofs_ublk_dev *dev;
+	struct ublksrv_io_desc *io_cmd_buf;
+	struct erofs_ublk_io *ios;
+	void *io_buf;
+	size_t io_buf_size;
+	pthread_t thread;
+	unsigned int state;
+	cpu_set_t *cpuset;
+	int idle_ticks;
+	pthread_barrier_t *init_barrier;
+	struct io_uring ring;
+};
+
+struct erofs_ublk_dev {
+	int ctrl_fd;
+	int cdev_fd;
+	struct ublksrv_ctrl_dev_info dev_info;
+	struct ublk_params params;
+	struct erofs_ublk_queue *queues;
+	erofs_ublk_io_handler_t handler;
+	void *handler_ctx;
+	int running;
+	int stop_requested;
+	int stop_efd;
+	int recovering;
+	struct io_uring ctrl_ring;
+	int ctrl_ring_initialized;
+};
+
+#define UBLK_CTRL_DEV		"/dev/ublk-control"
+#define UBLK_CDEV_FMT		"/dev/ublkc%d"
+
+#define UBLK_IDLE_TIMEOUT_TICKS	200
+
+#define UBLK_MAX_DEVS		128
+static struct erofs_ublk_dev *ublk_devs[UBLK_MAX_DEVS];
+
+static struct erofs_ublk_dev *ublk_get_dev(int dev_id)
+{
+	if (dev_id < 0 || dev_id >= UBLK_MAX_DEVS)
+		return NULL;
+	return ublk_devs[dev_id];
+}
+
+static volatile sig_atomic_t g_sig_dev_id = -1;
+
+static inline __u8 ublksrv_get_op(const struct ublksrv_io_desc *iod)
+{
+	return iod->op_flags & 0xff;
+}
+
+static inline unsigned int ublk_cmd_buf_sz(int q_depth)
+{
+	unsigned int size = q_depth * sizeof(struct ublksrv_io_desc);
+	unsigned int page_size = getpagesize();
+
+	return (size + page_size - 1) & ~(page_size - 1);
+}
+
+static inline void *ublk_get_io_buf(struct erofs_ublk_queue *q, int tag)
+{
+	return (char *)q->io_buf + tag * q->dev->dev_info.max_io_buf_bytes;
+}
+
+static inline __u64 ublk_pos(__u16 q_id, __u16 tag, __u32 offset)
+{
+	return UBLKSRV_IO_BUF_OFFSET +
+		(((__u64)q_id) << UBLK_QID_OFF) |
+		(((__u64)tag) << UBLK_TAG_OFF) |
+		((__u64)(offset & UBLK_IO_BUF_BITS_MASK));
+}
+
+static void ublk_apply_oom_protection(void)
+{
+	char path[64];
+	int fd;
+
+	snprintf(path, sizeof(path), "/proc/%d/oom_score_adj", getpid());
+	fd = open(path, O_RDWR);
+	if (fd >= 0) {
+		const char *val = "-1000";
+		ssize_t ret = write(fd, val, strlen(val));
+
+		if (ret != (ssize_t)strlen(val))
+			erofs_dbg("failed to set oom_score_adj: %s",
+				  strerror(errno));
+		close(fd);
+	}
+}
+
+static void ublk_set_io_flusher(void)
+{
+	if (prctl(PR_SET_IO_FLUSHER, 0, 0, 0, 0) != 0)
+		erofs_dbg("prctl(PR_SET_IO_FLUSHER) failed: %s",
+			  strerror(errno));
+}
+
+static int ublk_ctrl_ring_init(struct io_uring *ring)
+{
+	struct io_uring_params p;
+
+	memset(&p, 0, sizeof(p));
+	p.flags = IORING_SETUP_SQE128;
+
+	return io_uring_queue_init_params(4, ring, &p);
+}
+
+static int ublk_ctrl_cmd_ring(struct io_uring *ring, int ctrl_fd,
+			      __u32 cmd_op,
+			      const struct ublksrv_ctrl_cmd *cmd_data)
+{
+	struct io_uring_sqe *sqe;
+	struct io_uring_cqe *cqe;
+	struct ublksrv_ctrl_cmd *cmd;
+	int ret;
+
+	sqe = io_uring_get_sqe(ring);
+	if (!sqe)
+		return -ENOMEM;
+
+	io_uring_prep_rw(IORING_OP_URING_CMD, sqe, ctrl_fd, NULL, 0, 0);
+	sqe->cmd_op = cmd_op;
+
+	if (cmd_data) {
+		cmd = (struct ublksrv_ctrl_cmd *)sqe->cmd;
+		memcpy(cmd, cmd_data, sizeof(*cmd_data));
+	}
+
+	ret = io_uring_submit(ring);
+	if (ret < 0) {
+		erofs_err("io_uring_submit failed: %s", strerror(-ret));
+		return ret;
+	}
+
+	ret = io_uring_wait_cqe(ring, &cqe);
+	if (ret < 0) {
+		erofs_err("io_uring_wait_cqe failed: %s", strerror(-ret));
+		return ret;
+	}
+
+	ret = cqe->res;
+	io_uring_cqe_seen(ring, cqe);
+	return ret;
+}
+
+static int ublk_ctrl_cmd(int ctrl_fd, __u32 cmd_op,
+			 const struct ublksrv_ctrl_cmd *cmd_data)
+{
+	struct io_uring ring;
+	int ret;
+
+	ret = ublk_ctrl_ring_init(&ring);
+	if (ret < 0) {
+		erofs_err("io_uring_queue_init failed: %s", strerror(-ret));
+		return ret;
+	}
+
+	ret = ublk_ctrl_cmd_ring(&ring, ctrl_fd, cmd_op, cmd_data);
+	io_uring_queue_exit(&ring);
+	return ret;
+}
+
+static int ublk_dev_ctrl_cmd(struct erofs_ublk_dev *dev, __u32 cmd_op,
+			     const struct ublksrv_ctrl_cmd *cmd_data)
+{
+	return ublk_ctrl_cmd_ring(&dev->ctrl_ring, dev->ctrl_fd,
+				  cmd_op, cmd_data);
+}
+
+static int ublk_get_queue_affinity(struct erofs_ublk_dev *dev, int q_id,
+				   cpu_set_t *cpuset)
+{
+	struct ublksrv_ctrl_cmd cmd = {0};
+	int ret;
+
+	cmd.dev_id = dev->dev_info.dev_id;
+	cmd.queue_id = q_id;
+	cmd.len = sizeof(cpu_set_t);
+	cmd.addr = (__u64)(uintptr_t)cpuset;
+
+	ret = ublk_dev_ctrl_cmd(dev, UBLK_U_CMD_GET_QUEUE_AFFINITY, &cmd);
+	if (ret < 0)
+		erofs_dbg("GET_QUEUE_AFFINITY failed for q%d: %s",
+			  q_id, strerror(-ret));
+	return ret;
+}
+
+static int ublk_add_dev(struct erofs_ublk_dev *dev,
+			const struct erofs_ublk_dev_info *info)
+{
+	struct ublksrv_ctrl_cmd cmd = {0};
+	struct ublksrv_ctrl_dev_info *dev_info = &dev->dev_info;
+	int ret;
+
+	memset(dev_info, 0, sizeof(*dev_info));
+	dev_info->nr_hw_queues = info->nr_hw_queues;
+	dev_info->queue_depth = info->queue_depth;
+	dev_info->max_io_buf_bytes = info->max_io_buf_bytes;
+	dev_info->dev_id = info->dev_id;
+
+	dev_info->flags = UBLK_F_CMD_IOCTL_ENCODE |
+			  UBLK_F_URING_CMD_COMP_IN_TASK;
+
+	dev_info->flags |= UBLK_F_USER_COPY;
+
+	if (info->flags & EROFS_UBLK_F_UNPRIVILEGED)
+		dev_info->flags |= UBLK_F_UNPRIVILEGED_DEV;
+	if (info->flags & EROFS_UBLK_F_USER_RECOVERY)
+		dev_info->flags |= UBLK_F_USER_RECOVERY;
+
+	cmd.dev_id = dev_info->dev_id;
+	cmd.queue_id = (__u16)-1;
+	cmd.len = sizeof(*dev_info);
+	cmd.addr = (__u64)(uintptr_t)dev_info;
+
+	ret = ublk_dev_ctrl_cmd(dev, UBLK_U_CMD_ADD_DEV, &cmd);
+	if (ret < 0) {
+		erofs_err("UBLK_CMD_ADD_DEV failed: %s", strerror(-ret));
+		return ret;
+	}
+
+	erofs_info("ublk device %d added (queues=%d, depth=%d, io_buf=%u)",
+		   dev_info->dev_id, dev_info->nr_hw_queues,
+		   dev_info->queue_depth, dev_info->max_io_buf_bytes);
+	return 0;
+}
+
+static int ublk_del_dev(struct erofs_ublk_dev *dev)
+{
+	struct ublksrv_ctrl_cmd cmd = {0};
+
+	cmd.dev_id = dev->dev_info.dev_id;
+	cmd.queue_id = (__u16)-1;
+
+	return ublk_dev_ctrl_cmd(dev, UBLK_U_CMD_DEL_DEV, &cmd);
+}
+
+static int ublk_set_params(struct erofs_ublk_dev *dev,
+			   const struct erofs_ublk_dev_info *info)
+{
+	struct ublksrv_ctrl_cmd cmd = {0};
+	struct ublk_params *params = &dev->params;
+	int ret;
+
+	memset(params, 0, sizeof(*params));
+	params->len = sizeof(*params);
+	params->types = UBLK_PARAM_TYPE_BASIC;
+
+	params->basic.attrs = UBLK_ATTR_READ_ONLY;
+	params->basic.logical_bs_shift = info->blkbits;
+	params->basic.physical_bs_shift = info->blkbits;
+	params->basic.io_opt_shift = info->blkbits;
+	params->basic.io_min_shift = info->blkbits;
+	params->basic.max_sectors = info->max_io_buf_bytes >> 9;
+	params->basic.dev_sectors = info->dev_size >> 9;
+
+	cmd.dev_id = dev->dev_info.dev_id;
+	cmd.queue_id = (__u16)-1;
+	cmd.len = sizeof(*params);
+	cmd.addr = (__u64)(uintptr_t)params;
+
+	ret = ublk_dev_ctrl_cmd(dev, UBLK_U_CMD_SET_PARAMS, &cmd);
+	if (ret < 0)
+		erofs_err("UBLK_CMD_SET_PARAMS failed: %s", strerror(-ret));
+
+	return ret;
+}
+
+static int ublk_start_dev(struct erofs_ublk_dev *dev)
+{
+	struct ublksrv_ctrl_cmd cmd = {0};
+	int ret;
+
+	cmd.dev_id = dev->dev_info.dev_id;
+	cmd.queue_id = (__u16)-1;
+	cmd.data[0] = getpid();
+
+	ret = ublk_dev_ctrl_cmd(dev, UBLK_U_CMD_START_DEV, &cmd);
+	if (ret < 0)
+		erofs_err("UBLK_CMD_START_DEV failed: %s", strerror(-ret));
+	else
+		erofs_info("ublk device /dev/ublkb%d started",
+			   dev->dev_info.dev_id);
+
+	return ret;
+}
+
+static int ublk_stop_dev(struct erofs_ublk_dev *dev)
+{
+	struct ublksrv_ctrl_cmd cmd = {0};
+
+	cmd.dev_id = dev->dev_info.dev_id;
+	cmd.queue_id = (__u16)-1;
+
+	return ublk_dev_ctrl_cmd(dev, UBLK_U_CMD_STOP_DEV, &cmd);
+}
+
+static int ublk_start_recovery(struct erofs_ublk_dev *dev)
+{
+	struct ublksrv_ctrl_cmd cmd = {0};
+	int ret;
+
+	cmd.dev_id = dev->dev_info.dev_id;
+	cmd.queue_id = (__u16)-1;
+
+	ret = ublk_dev_ctrl_cmd(dev, UBLK_U_CMD_START_USER_RECOVERY, &cmd);
+	if (ret < 0)
+		erofs_err("START_USER_RECOVERY failed: %s", strerror(-ret));
+	else
+		erofs_info("ublk device %d recovery started",
+			   dev->dev_info.dev_id);
+
+	return ret;
+}
+
+static int ublk_end_recovery(struct erofs_ublk_dev *dev)
+{
+	struct ublksrv_ctrl_cmd cmd = {0};
+	int ret;
+
+	cmd.dev_id = dev->dev_info.dev_id;
+	cmd.queue_id = (__u16)-1;
+	cmd.data[0] = getpid();
+
+	ret = ublk_dev_ctrl_cmd(dev, UBLK_U_CMD_END_USER_RECOVERY, &cmd);
+	if (ret < 0)
+		erofs_err("END_USER_RECOVERY failed: %s", strerror(-ret));
+	else
+		erofs_info("ublk device %d recovery completed",
+			   dev->dev_info.dev_id);
+
+	return ret;
+}
+
+static int ublk_get_dev_info(struct erofs_ublk_dev *dev, int dev_id)
+{
+	struct ublksrv_ctrl_cmd cmd = {0};
+	int ret;
+
+	cmd.dev_id = dev_id;
+	cmd.queue_id = (__u16)-1;
+	cmd.len = sizeof(dev->dev_info);
+	cmd.addr = (__u64)(uintptr_t)&dev->dev_info;
+
+	ret = ublk_ctrl_cmd(dev->ctrl_fd, UBLK_U_CMD_GET_DEV_INFO, &cmd);
+	if (ret < 0)
+		erofs_err("GET_DEV_INFO failed: %s", strerror(-ret));
+
+	return ret;
+}
+
+static int ublk_get_params(struct erofs_ublk_dev *dev)
+{
+	struct ublksrv_ctrl_cmd cmd = {0};
+	int ret;
+
+	dev->params.len = sizeof(dev->params);
+
+	cmd.dev_id = dev->dev_info.dev_id;
+	cmd.queue_id = (__u16)-1;
+	cmd.len = sizeof(dev->params);
+	cmd.addr = (__u64)(uintptr_t)&dev->params;
+
+	ret = ublk_dev_ctrl_cmd(dev, UBLK_U_CMD_GET_PARAMS, &cmd);
+	if (ret < 0)
+		erofs_err("GET_PARAMS failed: %s", strerror(-ret));
+
+	return ret;
+}
+
+static int ublk_queue_io_cmd(struct erofs_ublk_queue *q, int tag)
+{
+	struct io_uring_sqe *sqe;
+	struct ublksrv_io_cmd *cmd;
+	struct erofs_ublk_io *io = &q->ios[tag];
+	__u32 cmd_op;
+
+	sqe = io_uring_get_sqe(&q->ring);
+	if (!sqe)
+		return -ENOMEM;
+
+	if (io->flags & UBLKSRV_IO_FREE)
+		cmd_op = UBLK_U_IO_FETCH_REQ;
+	else if (io->flags & UBLKSRV_IO_NEED_GET_DATA)
+		cmd_op = UBLK_U_IO_NEED_GET_DATA;
+	else
+		cmd_op = UBLK_U_IO_COMMIT_AND_FETCH_REQ;
+
+	memset(sqe, 0, sizeof(*sqe) * 2);
+
+	sqe->opcode = IORING_OP_URING_CMD;
+	sqe->fd = q->dev->cdev_fd;
+	sqe->cmd_op = cmd_op;
+	sqe->user_data = tag;
+
+	cmd = (struct ublksrv_io_cmd *)sqe->cmd;
+	cmd->q_id = q->q_id;
+	cmd->tag = tag;
+
+	if (cmd_op == UBLK_U_IO_COMMIT_AND_FETCH_REQ)
+		cmd->result = io->result;
+	else
+		cmd->result = 0;
+
+	cmd->addr = 0;
+
+	io->flags = 0;
+
+	return 0;
+}
+
+static int ublk_submit_fetch_commands(struct erofs_ublk_queue *q)
+{
+	int i, ret;
+
+	for (i = 0; i < q->q_depth; i++) {
+		q->ios[i].flags = UBLKSRV_IO_FREE;
+		ret = ublk_queue_io_cmd(q, i);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = io_uring_submit(&q->ring);
+	if (ret < 0) {
+		erofs_err("io_uring_submit (fetch) failed: %s", strerror(-ret));
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ublk_user_copy_read(struct erofs_ublk_queue *q, int tag, size_t len)
+{
+	__u64 pos = ublk_pos(q->q_id, tag, 0);
+	void *buf = ublk_get_io_buf(q, tag);
+	ssize_t ret;
+
+	ret = pread(q->dev->cdev_fd, buf, len, pos);
+	if (ret < 0) {
+		erofs_err("user_copy pread failed: %s", strerror(errno));
+		return -errno;
+	}
+	if ((size_t)ret != len) {
+		erofs_err("user_copy pread short: %zd/%zu", ret, len);
+		return -EIO;
+	}
+	return 0;
+}
+
+static int ublk_user_copy_write(struct erofs_ublk_queue *q, int tag, size_t len)
+{
+	__u64 pos = ublk_pos(q->q_id, tag, 0);
+	void *buf = ublk_get_io_buf(q, tag);
+	ssize_t ret;
+
+	ret = pwrite(q->dev->cdev_fd, buf, len, pos);
+	if (ret < 0) {
+		erofs_err("user_copy pwrite failed: %s", strerror(errno));
+		return -errno;
+	}
+	if ((size_t)ret != len) {
+		erofs_err("user_copy pwrite short: %zd/%zu", ret, len);
+		return -EIO;
+	}
+	return 0;
+}
+
+static int ublk_handle_io(struct erofs_ublk_queue *q, int tag)
+{
+	struct erofs_ublk_dev *dev = q->dev;
+	const struct ublksrv_io_desc *iod = &q->io_cmd_buf[tag];
+	struct erofs_ublk_io *io = &q->ios[tag];
+	struct erofs_ublk_request req;
+	int ret;
+
+	req.op = ublksrv_get_op(iod);
+	req.start_sector = iod->start_sector;
+	req.nr_sectors = iod->nr_sectors;
+	req.buf = ublk_get_io_buf(q, tag);
+	req.result = 0;
+
+	if (dev->handler) {
+		ret = dev->handler(dev->handler_ctx, &req);
+
+		if (ret < 0) {
+			io->result = ret;
+		} else {
+			size_t io_bytes = req.nr_sectors << 9;
+
+			if (req.op == UBLK_IO_OP_READ && io_bytes > 0) {
+				ret = ublk_user_copy_write(q, tag, io_bytes);
+				if (ret < 0)
+					io->result = ret;
+				else
+					io->result = io_bytes;
+			} else {
+				io->result = io_bytes;
+			}
+		}
+	} else {
+		io->result = -EOPNOTSUPP;
+	}
+
+	io->flags = UBLKSRV_NEED_COMMIT_RQ_COMP;
+
+	return 0;
+}
+
+static int ublk_handle_cqe(struct erofs_ublk_queue *q,
+			   struct io_uring_cqe *cqe)
+{
+	int tag = cqe->user_data;
+	struct erofs_ublk_io *io = &q->ios[tag];
+	int ret = cqe->res;
+
+	if (ret == UBLK_IO_RES_ABORT)
+		return -ENODEV;
+
+	if (ret == UBLK_IO_RES_NEED_GET_DATA) {
+		const struct ublksrv_io_desc *iod = &q->io_cmd_buf[tag];
+		size_t io_bytes = (size_t)iod->nr_sectors << 9;
+
+		ret = ublk_user_copy_read(q, tag, io_bytes);
+		if (ret < 0) {
+			io->result = ret;
+			io->flags = UBLKSRV_NEED_COMMIT_RQ_COMP;
+			return ublk_queue_io_cmd(q, tag);
+		}
+
+		io->flags = UBLKSRV_IO_NEED_GET_DATA;
+		return ublk_queue_io_cmd(q, tag);
+	}
+
+	if (ret < 0) {
+		erofs_err("queue %d tag %d IO error: %s",
+			  q->q_id, tag, strerror(-ret));
+		io->flags = UBLKSRV_IO_FREE;
+		return ublk_queue_io_cmd(q, tag);
+	}
+
+	ublk_handle_io(q, tag);
+
+	return ublk_queue_io_cmd(q, tag);
+}
+
+static void ublk_queue_enter_idle(struct erofs_ublk_queue *q)
+{
+	if (q->state & UBLKSRV_QUEUE_IDLE)
+		return;
+
+	q->state |= UBLKSRV_QUEUE_IDLE;
+
+	if (q->io_buf && q->io_buf_size > 0)
+		madvise(q->io_buf, q->io_buf_size, MADV_DONTNEED);
+
+	erofs_dbg("queue %d entered idle state", q->q_id);
+}
+
+static void ublk_queue_exit_idle(struct erofs_ublk_queue *q)
+{
+	if (!(q->state & UBLKSRV_QUEUE_IDLE))
+		return;
+
+	q->state &= ~UBLKSRV_QUEUE_IDLE;
+	q->idle_ticks = 0;
+	erofs_dbg("queue %d exited idle state", q->q_id);
+}
+
+static void *ublk_queue_thread(void *arg)
+{
+	struct erofs_ublk_queue *q = arg;
+	struct io_uring_cqe *cqe;
+	struct __kernel_timespec ts = {
+		.tv_sec = 0,
+		.tv_nsec = 100000000,
+	};
+	unsigned int head;
+	int ret, nr_events;
+
+	if (q->cpuset)
+		sched_setaffinity(0, sizeof(cpu_set_t), q->cpuset);
+
+	setpriority(PRIO_PROCESS, 0, -20);
+
+	ublk_set_io_flusher();
+
+	ret = ublk_submit_fetch_commands(q);
+	if (ret < 0) {
+		erofs_err("Failed to submit fetch commands: %s",
+			  strerror(-ret));
+		if (q->init_barrier)
+			pthread_barrier_wait(q->init_barrier);
+		return NULL;
+	}
+
+	if (q->init_barrier)
+		pthread_barrier_wait(q->init_barrier);
+
+	erofs_info("queue %d thread started (tid=%d)", q->q_id, gettid());
+
+	while (!(q->state & UBLKSRV_QUEUE_STOPPING)) {
+		ret = io_uring_submit_and_wait_timeout(&q->ring, &cqe, 1,
+						       &ts, NULL);
+		if (ret == -ETIME) {
+			if (++q->idle_ticks >= UBLK_IDLE_TIMEOUT_TICKS)
+				ublk_queue_enter_idle(q);
+			continue;
+		}
+
+		if (ret < 0) {
+			if (ret == -EINTR)
+				continue;
+			erofs_err("io_uring_submit_and_wait_timeout: %s",
+				  strerror(-ret));
+			break;
+		}
+
+		ublk_queue_exit_idle(q);
+
+		nr_events = 0;
+		io_uring_for_each_cqe(&q->ring, head, cqe) {
+			ret = ublk_handle_cqe(q, cqe);
+			nr_events++;
+			if (ret == -ENODEV) {
+				q->state |= UBLKSRV_QUEUE_STOPPING;
+				break;
+			}
+		}
+
+		if (nr_events)
+			io_uring_cq_advance(&q->ring, nr_events);
+
+		io_uring_submit(&q->ring);
+	}
+
+	erofs_info("queue %d thread exiting", q->q_id);
+	__atomic_store_n(&q->dev->stop_requested, 1, __ATOMIC_RELAXED);
+	if (q->dev->stop_efd >= 0) {
+		uint64_t val = 1;
+
+		(void)write(q->dev->stop_efd, &val, sizeof(val));
+	}
+	return NULL;
+}
+
+static int ublk_init_queue(struct erofs_ublk_dev *dev, int q_id)
+{
+	struct erofs_ublk_queue *q = &dev->queues[q_id];
+	struct io_uring_params p;
+	unsigned int cmd_buf_size;
+	int ret;
+
+	q->q_id = q_id;
+	q->q_depth = dev->dev_info.queue_depth;
+	q->dev = dev;
+	q->state = 0;
+	q->idle_ticks = 0;
+
+	q->cpuset = malloc(sizeof(cpu_set_t));
+	if (q->cpuset) {
+		CPU_ZERO(q->cpuset);
+		ret = ublk_get_queue_affinity(dev, q_id, q->cpuset);
+		if (ret < 0) {
+			free(q->cpuset);
+			q->cpuset = NULL;
+		}
+	}
+
+	cmd_buf_size = ublk_cmd_buf_sz(q->q_depth);
+	q->io_cmd_buf = mmap(NULL, cmd_buf_size, PROT_READ,
+			     MAP_SHARED | MAP_POPULATE, dev->cdev_fd,
+			     UBLKSRV_CMD_BUF_OFFSET +
+			     q_id * (UBLK_MAX_QUEUE_DEPTH *
+				     sizeof(struct ublksrv_io_desc)));
+	if (q->io_cmd_buf == MAP_FAILED) {
+		erofs_err("mmap io_cmd_buf failed: %s", strerror(errno));
+		ret = -errno;
+		goto err_free_cpuset;
+	}
+
+	q->ios = calloc(q->q_depth, sizeof(struct erofs_ublk_io));
+	if (!q->ios) {
+		ret = -ENOMEM;
+		goto err_unmap_cmd;
+	}
+
+	q->io_buf_size = (size_t)q->q_depth * dev->dev_info.max_io_buf_bytes;
+	q->io_buf = mmap(NULL, q->io_buf_size, PROT_READ | PROT_WRITE,
+			 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (q->io_buf == MAP_FAILED) {
+		erofs_err("mmap io_buf failed: %s", strerror(errno));
+		ret = -errno;
+		goto err_free_ios;
+	}
+
+	memset(&p, 0, sizeof(p));
+	p.flags = IORING_SETUP_SQE128;
+
+	ret = io_uring_queue_init_params(q->q_depth * 2, &q->ring, &p);
+	if (ret < 0) {
+		erofs_err("io_uring_queue_init failed: %s", strerror(-ret));
+		goto err_unmap_buf;
+	}
+
+	return 0;
+
+err_unmap_buf:
+	munmap(q->io_buf, q->io_buf_size);
+err_free_ios:
+	free(q->ios);
+err_unmap_cmd:
+	munmap(q->io_cmd_buf, cmd_buf_size);
+err_free_cpuset:
+	free(q->cpuset);
+	return ret;
+}
+
+static void ublk_cleanup_queue(struct erofs_ublk_dev *dev, int q_id)
+{
+	struct erofs_ublk_queue *q = &dev->queues[q_id];
+
+	q->state |= UBLKSRV_QUEUE_STOPPING;
+
+	if (q->thread) {
+		pthread_join(q->thread, NULL);
+		q->thread = 0;
+	}
+
+	io_uring_queue_exit(&q->ring);
+
+	if (q->io_buf && q->io_buf != MAP_FAILED)
+		munmap(q->io_buf, q->io_buf_size);
+
+	free(q->ios);
+
+	if (q->io_cmd_buf && q->io_cmd_buf != MAP_FAILED)
+		munmap(q->io_cmd_buf, ublk_cmd_buf_sz(q->q_depth));
+
+	free(q->cpuset);
+}
+
+static int erofs_ublk_stop(int dev_id)
+{
+	struct erofs_ublk_dev *dev = ublk_get_dev(dev_id);
+	int i;
+
+	if (!dev)
+		return -EINVAL;
+
+	__atomic_store_n(&dev->stop_requested, 1, __ATOMIC_RELAXED);
+
+	if (dev->stop_efd >= 0) {
+		uint64_t val = 1;
+
+		if (write(dev->stop_efd, &val, sizeof(val)) != sizeof(val))
+			erofs_dbg("stop_efd write failed");
+	}
+
+	for (i = 0; i < dev->dev_info.nr_hw_queues; i++)
+		dev->queues[i].state |= UBLKSRV_QUEUE_STOPPING;
+
+	if (__atomic_load_n(&dev->running, __ATOMIC_RELAXED))
+		ublk_stop_dev(dev);
+
+	__atomic_store_n(&dev->running, 0, __ATOMIC_RELAXED);
+	return 0;
+}
+
+static void ublk_sig_handler(int sig)
+{
+	if (sig == SIGTERM || sig == SIGINT) {
+		erofs_info("received signal %d, stopping ublk device",
+			   sig);
+		if (g_sig_dev_id >= 0)
+			erofs_ublk_stop(g_sig_dev_id);
+	}
+}
+
+static int ublk_install_sig_handler(int dev_id)
+{
+	struct sigaction sa;
+
+	g_sig_dev_id = dev_id;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler = ublk_sig_handler;
+	sigemptyset(&sa.sa_mask);
+	sa.sa_flags = 0;
+
+	if (sigaction(SIGTERM, &sa, NULL) < 0) {
+		erofs_err("sigaction(SIGTERM) failed: %s",
+			  strerror(errno));
+		return -errno;
+	}
+
+	if (sigaction(SIGINT, &sa, NULL) < 0) {
+		erofs_err("sigaction(SIGINT) failed: %s",
+			  strerror(errno));
+		return -errno;
+	}
+	return 0;
+}
+
+int erofs_ublk_init(void)
+{
+	if (access(UBLK_CTRL_DEV, F_OK) != 0)
+		return -EOPNOTSUPP;
+	return 0;
+}
+
+int erofs_ublk_create_dev(const struct erofs_ublk_dev_info *info,
+			  erofs_ublk_io_handler_t handler,
+			  void *handler_ctx)
+{
+	struct erofs_ublk_dev *dev;
+	struct erofs_ublk_dev_info def_info;
+	char cdev_path[64];
+	int i, ret, dev_id;
+
+	if (!info) {
+		memset(&def_info, 0, sizeof(def_info));
+		def_info.nr_hw_queues = EROFS_UBLK_DEF_NR_HW_QUEUES;
+		def_info.queue_depth = EROFS_UBLK_DEF_QUEUE_DEPTH;
+		def_info.max_io_buf_bytes = EROFS_UBLK_DEF_MAX_IO_BUF_BYTES;
+		def_info.blkbits = EROFS_UBLK_DEF_BLK_BITS;
+		def_info.dev_id = (__u32)-1;
+		info = &def_info;
+	}
+
+	dev = calloc(1, sizeof(*dev));
+	if (!dev)
+		return -ENOMEM;
+
+	dev->handler = handler;
+	dev->handler_ctx = handler_ctx;
+	dev->ctrl_fd = -1;
+	dev->cdev_fd = -1;
+	dev->stop_efd = -1;
+
+	dev->ctrl_fd = open(UBLK_CTRL_DEV, O_RDWR);
+	if (dev->ctrl_fd < 0) {
+		ret = -errno;
+		erofs_err("failed to open %s: %s",
+			  UBLK_CTRL_DEV, strerror(errno));
+		goto err_free;
+	}
+
+	ret = ublk_ctrl_ring_init(&dev->ctrl_ring);
+	if (ret < 0) {
+		erofs_err("ctrl ring init failed: %s",
+			  strerror(-ret));
+		goto err_close_ctrl;
+	}
+	dev->ctrl_ring_initialized = 1;
+
+	dev->stop_efd = eventfd(0, EFD_CLOEXEC);
+	if (dev->stop_efd < 0)
+		erofs_dbg("stop eventfd creation failed: %s",
+			  strerror(errno));
+
+	ret = ublk_add_dev(dev, info);
+	if (ret < 0)
+		goto err_close_ctrl;
+
+	snprintf(cdev_path, sizeof(cdev_path), UBLK_CDEV_FMT,
+		 dev->dev_info.dev_id);
+	dev->cdev_fd = open(cdev_path, O_RDWR);
+	if (dev->cdev_fd < 0) {
+		ret = -errno;
+		erofs_err("failed to open %s: %s",
+			  cdev_path, strerror(errno));
+		goto err_del_dev;
+	}
+
+	ret = ublk_set_params(dev, info);
+	if (ret < 0)
+		goto err_close_cdev;
+
+	dev->queues = calloc(dev->dev_info.nr_hw_queues,
+			     sizeof(struct erofs_ublk_queue));
+	if (!dev->queues) {
+		ret = -ENOMEM;
+		goto err_close_cdev;
+	}
+
+	for (i = 0; i < dev->dev_info.nr_hw_queues; i++) {
+		ret = ublk_init_queue(dev, i);
+		if (ret < 0)
+			goto err_cleanup_queues;
+	}
+
+	dev_id = dev->dev_info.dev_id;
+	if (dev_id < 0 || dev_id >= UBLK_MAX_DEVS) {
+		erofs_err("kernel assigned dev_id %d out of range",
+			  dev_id);
+		ret = -ERANGE;
+		goto err_cleanup_queues;
+	}
+	ublk_devs[dev_id] = dev;
+	return dev_id;
+
+err_cleanup_queues:
+	for (i = i - 1; i >= 0; i--)
+		ublk_cleanup_queue(dev, i);
+	free(dev->queues);
+err_close_cdev:
+	close(dev->cdev_fd);
+err_del_dev:
+	ublk_del_dev(dev);
+err_close_ctrl:
+	close(dev->ctrl_fd);
+err_free:
+	free(dev);
+	return ret;
+}
+
+void erofs_ublk_destroy(int dev_id)
+{
+	struct erofs_ublk_dev *dev = ublk_get_dev(dev_id);
+	int i;
+
+	if (!dev)
+		return;
+
+	erofs_ublk_stop(dev_id);
+
+	if (dev->queues) {
+		for (i = 0; i < dev->dev_info.nr_hw_queues; i++)
+			ublk_cleanup_queue(dev, i);
+		free(dev->queues);
+	}
+
+	if (dev->cdev_fd >= 0)
+		close(dev->cdev_fd);
+
+	if (dev->ctrl_fd >= 0) {
+		ublk_del_dev(dev);
+		close(dev->ctrl_fd);
+	}
+
+	if (dev->ctrl_ring_initialized)
+		io_uring_queue_exit(&dev->ctrl_ring);
+
+	if (dev->stop_efd >= 0)
+		close(dev->stop_efd);
+
+	ublk_devs[dev_id] = NULL;
+	free(dev);
+}
+
+int erofs_ublk_start(int dev_id, int ready_fd)
+{
+	struct erofs_ublk_dev *dev = ublk_get_dev(dev_id);
+	pthread_barrier_t init_barrier;
+	int i, ret;
+
+	if (!dev)
+		return -EINVAL;
+
+	ublk_install_sig_handler(dev_id);
+	ublk_apply_oom_protection();
+
+	ret = pthread_barrier_init(&init_barrier,
+				   NULL, dev->dev_info.nr_hw_queues + 1);
+	if (ret) {
+		erofs_err("pthread_barrier_init failed: %s", strerror(ret));
+		return -ret;
+	}
+
+	for (i = 0; i < dev->dev_info.nr_hw_queues; i++) {
+		dev->queues[i].init_barrier = &init_barrier;
+		ret = pthread_create(&dev->queues[i].thread, NULL,
+				     ublk_queue_thread, &dev->queues[i]);
+		if (ret) {
+			erofs_err("pthread_create failed: %s", strerror(ret));
+			goto err_stop_threads;
+		}
+	}
+
+	pthread_barrier_wait(&init_barrier);
+	pthread_barrier_destroy(&init_barrier);
+	for (i = 0; i < dev->dev_info.nr_hw_queues; i++)
+		dev->queues[i].init_barrier = NULL;
+
+	if (dev->recovering)
+		ret = ublk_end_recovery(dev);
+	else
+		ret = ublk_start_dev(dev);
+	if (ret < 0)
+		goto err_stop_threads;
+
+	__atomic_store_n(&dev->running, 1, __ATOMIC_RELAXED);
+
+	if (!dev->recovering && ready_fd >= 0) {
+		char ready = 0;
+
+		if (write(ready_fd, &ready, 1) != 1)
+			erofs_dbg("ready_fd write failed");
+		close(ready_fd);
+	}
+	erofs_info("ublk device %s successfully",
+		   dev->recovering ? "recovery completed" : "started");
+
+	if (dev->stop_efd >= 0) {
+		uint64_t val;
+
+		while (!__atomic_load_n(&dev->stop_requested, __ATOMIC_RELAXED)) {
+			if (read(dev->stop_efd, &val, sizeof(val)) < 0) {
+				if (errno == EINTR)
+					continue;
+				break;
+			}
+			break;
+		}
+	} else {
+		while (!__atomic_load_n(&dev->stop_requested, __ATOMIC_RELAXED))
+			usleep(100000);
+	}
+
+	return 0;
+
+err_stop_threads:
+	pthread_barrier_destroy(&init_barrier);
+	for (i = 0; i < dev->dev_info.nr_hw_queues; i++) {
+		dev->queues[i].init_barrier = NULL;
+		if (dev->queues[i].thread) {
+			dev->queues[i].state |= UBLKSRV_QUEUE_STOPPING;
+			pthread_join(dev->queues[i].thread, NULL);
+			dev->queues[i].thread = 0;
+		}
+	}
+	return ret;
+}
+
+int erofs_ublk_recover_dev(int dev_id,
+			   erofs_ublk_io_handler_t handler,
+			   void *handler_ctx)
+{
+	struct erofs_ublk_dev *dev;
+	char cdev_path[64];
+	int i, ret;
+
+	if (dev_id < 0)
+		return -EINVAL;
+
+	dev = calloc(1, sizeof(*dev));
+	if (!dev)
+		return -ENOMEM;
+
+	dev->handler = handler;
+	dev->handler_ctx = handler_ctx;
+	dev->ctrl_fd = -1;
+	dev->cdev_fd = -1;
+	dev->stop_efd = -1;
+
+	dev->ctrl_fd = open(UBLK_CTRL_DEV, O_RDWR);
+	if (dev->ctrl_fd < 0) {
+		ret = -errno;
+		erofs_err("failed to open %s: %s",
+			  UBLK_CTRL_DEV, strerror(errno));
+		goto err_free;
+	}
+
+	ret = ublk_ctrl_ring_init(&dev->ctrl_ring);
+	if (ret < 0) {
+		erofs_err("ctrl ring init failed: %s",
+			  strerror(-ret));
+		goto err_close_ctrl;
+	}
+	dev->ctrl_ring_initialized = 1;
+
+	dev->stop_efd = eventfd(0, EFD_CLOEXEC);
+	if (dev->stop_efd < 0)
+		erofs_dbg("stop eventfd creation failed: %s",
+			  strerror(errno));
+
+	ret = ublk_get_dev_info(dev, dev_id);
+	if (ret < 0)
+		goto err_close_ctrl;
+
+	if (!(dev->dev_info.flags & UBLK_F_USER_RECOVERY)) {
+		erofs_err("Device %d does not support user recovery", dev_id);
+		ret = -EOPNOTSUPP;
+		goto err_close_ctrl;
+	}
+
+	if (dev->dev_info.state != UBLK_S_DEV_QUIESCED &&
+	    dev->dev_info.state != UBLK_S_DEV_FAIL_IO) {
+		erofs_err("Device %d is not in recoverable state (state=%d)",
+			  dev_id, dev->dev_info.state);
+		ret = -EBUSY;
+		goto err_close_ctrl;
+	}
+
+	ret = ublk_get_params(dev);
+	if (ret < 0)
+		goto err_close_ctrl;
+
+	ret = ublk_start_recovery(dev);
+	if (ret < 0)
+		goto err_close_ctrl;
+
+	snprintf(cdev_path, sizeof(cdev_path), UBLK_CDEV_FMT, dev_id);
+	dev->cdev_fd = open(cdev_path, O_RDWR);
+	if (dev->cdev_fd < 0) {
+		ret = -errno;
+		erofs_err("Failed to open %s: %s", cdev_path, strerror(errno));
+		goto err_close_ctrl;
+	}
+
+	dev->queues = calloc(dev->dev_info.nr_hw_queues,
+			     sizeof(struct erofs_ublk_queue));
+	if (!dev->queues) {
+		ret = -ENOMEM;
+		goto err_close_cdev;
+	}
+
+	for (i = 0; i < dev->dev_info.nr_hw_queues; i++) {
+		ret = ublk_init_queue(dev, i);
+		if (ret < 0)
+			goto err_cleanup_queues;
+	}
+
+	dev->recovering = 1;
+	ublk_devs[dev_id] = dev;
+	return 0;
+
+err_cleanup_queues:
+	for (i = i - 1; i >= 0; i--)
+		ublk_cleanup_queue(dev, i);
+	free(dev->queues);
+err_close_cdev:
+	close(dev->cdev_fd);
+err_close_ctrl:
+	close(dev->ctrl_fd);
+err_free:
+	free(dev);
+	return ret;
+}
+
+int erofs_ublk_is_recoverable(int dev_id)
+{
+	struct erofs_ublk_dev dev;
+	int ctrl_fd, ret;
+
+	ctrl_fd = open(UBLK_CTRL_DEV, O_RDWR);
+	if (ctrl_fd < 0)
+		return 0;
+
+	memset(&dev, 0, sizeof(dev));
+	dev.ctrl_fd = ctrl_fd;
+
+	ret = ublk_get_dev_info(&dev, dev_id);
+	close(ctrl_fd);
+
+	if (ret < 0)
+		return 0;
+
+	if ((dev.dev_info.flags & UBLK_F_USER_RECOVERY) &&
+	    dev.dev_info.state == UBLK_S_DEV_QUIESCED)
+		return 1;
+
+	return 0;
+}
+
+int erofs_ublk_del_dev_by_id(int dev_id)
+{
+	struct ublksrv_ctrl_cmd cmd = {0};
+	int ctrl_fd, ret;
+
+	ctrl_fd = open(UBLK_CTRL_DEV, O_RDWR);
+	if (ctrl_fd < 0)
+		return -errno;
+
+	cmd.dev_id = dev_id;
+	cmd.queue_id = (__u16)-1;
+
+	ret = ublk_ctrl_cmd(ctrl_fd, UBLK_U_CMD_STOP_DEV, &cmd);
+	if (ret < 0 && ret != -ENODEV)
+		erofs_dbg("STOP_DEV %d: %s", dev_id, strerror(-ret));
+
+	ret = ublk_ctrl_cmd(ctrl_fd, UBLK_U_CMD_DEL_DEV_ASYNC, &cmd);
+	close(ctrl_fd);
+	return ret;
+}
+
+#else /* !HAVE_LIBURING */
+
+int erofs_ublk_init(void)
+{
+	return -EOPNOTSUPP;
+}
+
+int erofs_ublk_create_dev(const struct erofs_ublk_dev_info *info,
+			  erofs_ublk_io_handler_t handler,
+			  void *handler_ctx)
+{
+	(void)info;
+	(void)handler;
+	(void)handler_ctx;
+	return -EOPNOTSUPP;
+}
+
+void erofs_ublk_destroy(int dev_id)
+{
+	(void)dev_id;
+}
+
+int erofs_ublk_start(int dev_id, int ready_fd)
+{
+	(void)dev_id;
+	(void)ready_fd;
+	return -EOPNOTSUPP;
+}
+
+int erofs_ublk_recover_dev(int dev_id,
+			   erofs_ublk_io_handler_t handler,
+			   void *handler_ctx)
+{
+	(void)dev_id;
+	(void)handler;
+	(void)handler_ctx;
+	return -EOPNOTSUPP;
+}
+
+int erofs_ublk_is_recoverable(int dev_id)
+{
+	(void)dev_id;
+	return 0;
+}
+
+int erofs_ublk_del_dev_by_id(int dev_id)
+{
+	(void)dev_id;
+	return -EOPNOTSUPP;
+}
+
+#endif /* HAVE_LIBURING */
diff --git a/lib/liberofs_ublk.h b/lib/liberofs_ublk.h
new file mode 100644
index 0000000..5aef9c3
--- /dev/null
+++ b/lib/liberofs_ublk.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
+/*
+ * Copyright (C) 2026 Tencent, Inc.
+ *             http://www.tencent.com/
+ */
+#ifndef __EROFS_LIB_LIBEROFS_UBLK_H
+#define __EROFS_LIB_LIBEROFS_UBLK_H
+
+#include "erofs/defs.h"
+
+#define EROFS_UBLK_F_UNPRIVILEGED	(1U << 0)
+#define EROFS_UBLK_F_USER_RECOVERY	(1U << 1)
+
+#define EROFS_UBLK_OP_READ		0
+
+struct erofs_ublk_dev_info {
+	u16 nr_hw_queues;
+	u16 queue_depth;
+	u32 max_io_buf_bytes;
+	u32 dev_id;
+	u64 dev_size;
+	u8 blkbits;
+	u8 reserved[3];
+	u32 flags;
+};
+
+struct erofs_ublk_request {
+	u8 op;
+	u64 start_sector;
+	u32 nr_sectors;
+	void *buf;
+	int result;
+};
+
+typedef int (*erofs_ublk_io_handler_t)(void *ctx,
+				       struct erofs_ublk_request *req);
+
+int erofs_ublk_init(void);
+
+int erofs_ublk_create_dev(const struct erofs_ublk_dev_info *info,
+			  erofs_ublk_io_handler_t handler,
+			  void *handler_ctx);
+int erofs_ublk_start(int dev_id, int ready_fd);
+void erofs_ublk_destroy(int dev_id);
+
+int erofs_ublk_del_dev_by_id(int dev_id);
+
+int erofs_ublk_recover_dev(int dev_id,
+			   erofs_ublk_io_handler_t handler,
+			   void *handler_ctx);
+int erofs_ublk_is_recoverable(int dev_id);
+
+#endif
-- 
2.47.1


