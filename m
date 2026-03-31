Return-Path: <linux-erofs+bounces-3142-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UO42HL3Iy2mnLgYAu9opvQ
	(envelope-from <linux-erofs+bounces-3142-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Mar 2026 15:14:37 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F5B36A053
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Mar 2026 15:14:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flT9P183mz2ybR;
	Wed, 01 Apr 2026 00:14:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774962873;
	cv=none; b=LKwOJxHEN89Ib2QCHg1+a9SES3sXWNajJbDoRIuHYEkzMYtf/ioz/Qqe0XZFl50hurze1t92rXz2JdCvaXzkXroMG7pcw1Z/JU81TOKKflNpUrGSaD2RemjD936HaYOYgNHJlCckR0/+adQK1/XSh8VaSuxvYxbWVl5aVUULjuqn7jtL7eHei3OAfRsDpuRv7FGZYMLS8omcF1HQDbyz4w5n3Y1AcvLiikTzLgmyD9ED6zEMuScXb/svnrTdUT6lmlFLd5NYjtBynvMchZNZgkadq3ceXsC4knClpfuCJSJLCa4iCeBXCsgK4VOgx+cYKtKDyMOYgUJ0+iGvff4P6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774962873; c=relaxed/relaxed;
	bh=HmWOpmEI7ZMAHD79/m1gIfuw5DBa977DUvvfdrKh5Z8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UDfAbwQ2bJQJjpmHrcg/RGsaiWpVE0KG322ZcFVcrSQ+dO+lg2LQjuCOW9T7V0e2vlFAnLvqaZ6oFiqczmw7dJbMgDYVl6X8zFf76vhomk60g0NwOgKTVQuK21igNvNr6BGf7ouT9Kg1itge5xz8ssoiNooEUcFmBABRJfYXWzIX68sx5fPXMPf3nXG9z8bAAoGc7fFhyzCMwGjh6HrpSJKjlPju1rFbJrSILa6PNAbU4Ble9tk3sN56ahTQPXpz6aw5MC7KsnbFjwj07qEEXD4ETJ9w0jOqCUUtkpsq4ZdULiOkfZymlH0OKdnmmVRLcd4al42Ht+jtYfUMu0CeNw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=vk+GM1ZD; dkim-atps=neutral; spf=pass (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=vk+GM1ZD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flT9L05Jgz2ybQ
	for <linux-erofs@lists.ozlabs.org>; Wed, 01 Apr 2026 00:14:29 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=HmWOpmEI7ZMAHD79/m1gIfuw5DBa977DUvvfdrKh5Z8=;
	b=vk+GM1ZDlajyl5heHVOtB1tYfaPzvVy50iyvv8VXqLkwV9KyvCi9W46bL+4PgA+pQPqqFbJmV
	AnBjsC4yc/ySY1X8OT2WnCZI6jXo9+KEDEwj2GAmMa25ACcua+C737lTgC1GOhSxqqCbVTv0VuG
	d/GelRqeUlhcODGj4pLU0yQ=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4flT250tM6zRhQm;
	Tue, 31 Mar 2026 21:08:13 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 65DDD40575;
	Tue, 31 Mar 2026 21:14:22 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 31 Mar
 2026 21:14:21 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
CC: <jingrui@huawei.com>, <zhukeqian1@huawei.com>, <zhaoyifan28@huawei.com>,
	<hudsonzhu@tencent.com>
Subject: [PATCH v2 2/2] erofs-utils: mount: add fanotify pre-content OCI backend
Date: Tue, 31 Mar 2026 21:14:01 +0800
Message-ID: <20260331131401.901584-1-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260330124402.899394-2-zhaoyifan28@huawei.com>
References: <20260330124402.899394-2-zhaoyifan28@huawei.com>
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
Content-Type: text/plain
X-Originating-IP: [10.50.159.234]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-3142-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:jingrui@huawei.com,m:zhukeqian1@huawei.com,m:zhaoyifan28@huawei.com,m:hudsonzhu@tencent.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	HAS_XOIP(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,huawei.com:dkim,huawei.com:email,huawei.com:mid,state.pid:url]
X-Rspamd-Queue-Id: C2F5B36A053
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a fanotify-backed mount mode for OCI sources that uses
FAN_PRE_ACCESS permission events to populate a local sparse file
on demand before the kernel consumes the requested data.

The new erofs.fanotify subtype resolves a single OCI blob,
creates a sparse cache file, and runs a fanotify event loop
that fetches missing ranges before allowing access to proceed.

A pid file recording the canonical mountpoint and sparse-file
source is written for unmount to track the corresponding worker.

[ Developed with assistance from GPT-5.4 ]
Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 configure.ac            |  28 +++
 lib/Makefile.am         |   7 +
 lib/backends/fanotify.c | 283 ++++++++++++++++++++++++
 lib/liberofs_fanotify.h |  59 +++++
 lib/liberofs_oci.h      |   3 +
 lib/remotes/oci.c       |  10 +-
 mount/main.c            | 476 +++++++++++++++++++++++++++++++++++++++-
 7 files changed, 860 insertions(+), 6 deletions(-)
 create mode 100644 lib/backends/fanotify.c
 create mode 100644 lib/liberofs_fanotify.h

diff --git a/configure.ac b/configure.ac
index 8a8e9b3..45b8190 100644
--- a/configure.ac
+++ b/configure.ac
@@ -194,6 +194,10 @@ AC_ARG_ENABLE(oci,
                    [enable OCI registry based input support @<:@default=no@:>@]),
     [enable_oci="$enableval"],[enable_oci="no"])
 
+AC_ARG_ENABLE(fanotify,
+   [AS_HELP_STRING([--enable-fanotify], [enable fanotify pre-content backend @<:@default=no@:>@])],
+   [enable_fanotify="$enableval"], [enable_fanotify="no"])
+
 AC_ARG_ENABLE(fuse,
    [AS_HELP_STRING([--enable-fuse], [enable erofsfuse @<:@default=no@:>@])],
    [enable_fuse="$enableval"], [enable_fuse="no"])
@@ -651,6 +655,24 @@ AS_IF([test "x$enable_oci" = "xyes"], [
   ])
 ], [have_oci="no"])
 
+have_fanotify="no"
+AS_IF([test "x$enable_fanotify" = "xyes"], [
+  AS_IF([test "x$build_linux" != "xyes"], [
+    AC_MSG_ERROR([fanotify backend requires Linux])
+  ])
+  AS_IF([test "x$have_oci" != "xyes"], [
+    AC_MSG_ERROR([fanotify backend requires --enable-oci])
+  ])
+  AC_CHECK_HEADERS([sys/fanotify.h], [
+    have_fanotify="yes"
+    AC_CHECK_TYPES([struct fanotify_event_info_range], [], [], [[
+#include <sys/fanotify.h>
+    ]])
+  ], [
+    AC_MSG_ERROR([fanotify backend disabled: missing sys/fanotify.h])
+  ])
+])
+
 # Configure openssl
 have_openssl="no"
 AS_IF([test "x$with_openssl" != "xno"], [
@@ -766,6 +788,7 @@ AM_CONDITIONAL([ENABLE_LIBXML2], [test "x${have_libxml2}" = "xyes"])
 AM_CONDITIONAL([ENABLE_S3], [test "x${have_s3}" = "xyes"])
 AM_CONDITIONAL([ENABLE_STATIC_FUSE], [test "x${enable_static_fuse}" = "xyes"])
 AM_CONDITIONAL([ENABLE_OCI], [test "x${have_oci}" = "xyes"])
+AM_CONDITIONAL([ENABLE_FANOTIFY], [test "x${have_fanotify}" = "xyes"])
 
 if test "x$have_uuid" = "xyes"; then
   AC_DEFINE([HAVE_LIBUUID], 1, [Define to 1 if libuuid is found])
@@ -842,6 +865,11 @@ if test "x$have_oci" = "xyes"; then
   AC_DEFINE([OCIEROFS_ENABLED], 1, [Define to 1 if OCI registry is enabled])
 fi
 
+if test "x$have_fanotify" = "xyes"; then
+  AC_DEFINE([EROFS_FANOTIFY_ENABLED], 1,
+	    [Define to 1 if fanotify backend is enabled])
+fi
+
 # Dump maximum block size
 AS_IF([test "x$erofs_cv_max_block_size" = "x"],
       [$erofs_cv_max_block_size = 4096], [])
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 77f6fd8..5f8812f 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -36,6 +36,10 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
       $(top_srcdir)/lib/liberofs_s3.h
 
 noinst_HEADERS += compressor.h
+if ENABLE_FANOTIFY
+noinst_HEADERS += $(top_srcdir)/lib/liberofs_fanotify.h
+endif
+
 liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
 		      namei.c data.c compress.c compressor.c zmap.c decompress.c \
 		      compress_hints.c hashmap.c sha256.c blobchunk.c dir.c \
@@ -88,6 +92,9 @@ if OS_LINUX
 liberofs_la_CFLAGS += ${libnl3_CFLAGS}
 liberofs_la_LDFLAGS += ${libnl3_LIBS}
 liberofs_la_SOURCES += backends/nbd.c
+if ENABLE_FANOTIFY
+liberofs_la_SOURCES += backends/fanotify.c
+endif
 endif
 liberofs_la_SOURCES += remotes/oci.c remotes/docker_config.c
 liberofs_la_CFLAGS += ${json_c_CFLAGS}
diff --git a/lib/backends/fanotify.c b/lib/backends/fanotify.c
new file mode 100644
index 0000000..bbe131a
--- /dev/null
+++ b/lib/backends/fanotify.c
@@ -0,0 +1,283 @@
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <poll.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include "erofs/err.h"
+#include "erofs/print.h"
+#include "liberofs_fanotify.h"
+
+int erofs_fanotify_init_precontent(void)
+{
+	int fan_fd;
+
+	fan_fd = fanotify_init(EROFS_FAN_CLASS_PRE_CONTENT | FAN_CLOEXEC | FAN_NONBLOCK,
+			       O_RDONLY | O_LARGEFILE);
+	if (fan_fd < 0) {
+		erofs_err("fanotify_init failed: %s", strerror(errno));
+		return -errno;
+	}
+
+	return fan_fd;
+}
+
+int erofs_fanotify_mark_file(int fan_fd, const char *path)
+{
+	int err;
+
+	err = fanotify_mark(fan_fd, FAN_MARK_ADD, EROFS_FAN_PRE_ACCESS,
+			    AT_FDCWD, path);
+	if (err < 0) {
+		erofs_err("fanotify_mark failed for %s: %s", path, strerror(errno));
+		return -errno;
+	}
+
+	erofs_dbg("Marked %s for EROFS_FAN_PRE_ACCESS monitoring", path);
+	return 0;
+}
+
+static int erofs_fanotify_parse_range_event(const struct fanotify_event_metadata *meta,
+					    u64 *offset, u64 *count)
+{
+	const struct fanotify_event_info_header *info_hdr;
+	const erofs_fanotify_event_info_range_t *range_info;
+	const char *ptr, *end;
+
+	if (meta->metadata_len > meta->event_len) {
+		erofs_err("Invalid fanotify metadata length");
+		return -EIO;
+	}
+
+	if (meta->vers != FANOTIFY_METADATA_VERSION) {
+		erofs_err("Unsupported fanotify metadata version %d", meta->vers);
+		return -EINVAL;
+	}
+
+	/* Initialize range to full file (will be overridden if range info present) */
+	*offset = 0;
+	*count = 0;
+
+	/* Parse additional info records for range information */
+	ptr = (const char *)meta + meta->metadata_len;
+	end = (const char *)meta + meta->event_len;
+
+	while (ptr < end) {
+		size_t info_len;
+
+		if (end - ptr < sizeof(*info_hdr)) {
+			erofs_err("Incomplete fanotify event info header");
+			return -EIO;
+		}
+		info_hdr = (const struct fanotify_event_info_header *)ptr;
+		info_len = info_hdr->len;
+		if (info_len < sizeof(*info_hdr) || ptr + info_len > end) {
+			erofs_err("Invalid fanotify event info length");
+			return -EIO;
+		}
+
+		if (info_hdr->info_type == EROFS_FAN_EVENT_INFO_TYPE_RANGE) {
+			if (info_len < sizeof(*range_info)) {
+				erofs_err("Incomplete fanotify range info");
+				return -EIO;
+			}
+			range_info = (const erofs_fanotify_event_info_range_t *)ptr;
+			*offset = range_info->offset;
+			*count = range_info->count;
+			break;
+		}
+
+		ptr += info_hdr->len;
+	}
+
+	return 0;
+}
+
+static int erofs_fanotify_respond(int fan_fd, int event_fd, bool allow)
+{
+	struct fanotify_response response = {
+		.fd = event_fd,
+		.response = allow ? FAN_ALLOW : FAN_DENY,
+	};
+	ssize_t ret;
+
+	ret = write(fan_fd, &response, sizeof(response));
+	if (ret != sizeof(response)) {
+		erofs_err("Failed to respond to fanotify event: %s",
+			  ret < 0 ? strerror(errno) : "short write");
+		return ret < 0 ? -errno : -EIO;
+	}
+
+	return 0;
+}
+
+static bool erofs_fanotify_range_in_sparse(int fd, u64 offset, size_t length)
+{
+	off_t data_start, hole_start;
+
+	data_start = lseek(fd, offset, SEEK_DATA);
+	if (data_start < 0)
+		return false;
+	if ((u64)data_start != offset)
+		return false;
+
+	hole_start = lseek(fd, offset, SEEK_HOLE);
+	if (hole_start < 0)
+		return false;
+	if ((u64)hole_start < offset + length)
+		return false;
+
+	return true;
+}
+
+static int erofs_fanotify_handle_range(struct erofs_fanotify_ctx *ctx,
+				       u64 offset, u64 count)
+{
+	size_t length = count;
+	ssize_t read_len, written;
+
+	if (offset >= ctx->image_size)
+		return 0;
+
+	if (length == 0)
+		length = min_t(u64, 4 * 1024 * 1024, ctx->image_size - offset);
+	if (offset + length > ctx->image_size)
+		length = ctx->image_size - offset;
+
+	if (erofs_fanotify_range_in_sparse(ctx->sparse_fd, offset, length)) {
+		erofs_dbg("Range [%llu, %llu) already local, skipping fetch",
+			  (unsigned long long)offset,
+			  (unsigned long long)(offset + length));
+		return 0;
+	}
+
+	if (ctx->fetch_buf_size < length) {
+		void *newbuf = realloc(ctx->fetch_buf, length);
+
+		if (!newbuf) {
+			erofs_err("Failed to allocate %zu bytes", length);
+			return -ENOMEM;
+		}
+		ctx->fetch_buf = newbuf;
+		ctx->fetch_buf_size = length;
+	}
+
+	erofs_dbg("Fetching range [%llu, %llu)",
+		  (unsigned long long)offset,
+		  (unsigned long long)(offset + length));
+
+	read_len = erofs_io_pread(&ctx->vd, ctx->fetch_buf, length, offset);
+	if (read_len < 0) {
+		erofs_err("Failed to fetch range [%llu, %llu): %s",
+			  (unsigned long long)offset,
+			  (unsigned long long)(offset + length),
+			  erofs_strerror(read_len));
+		return read_len;
+	}
+
+	written = pwrite(ctx->sparse_fd, ctx->fetch_buf, read_len, offset);
+	if (written != read_len) {
+		erofs_err("Failed to write to sparse file at offset %llu: %s",
+			  (unsigned long long)offset,
+			  written < 0 ? strerror(errno) : "short write");
+		return written < 0 ? -errno : -EIO;
+	}
+
+	fsync(ctx->sparse_fd);
+	return 0;
+}
+
+static int erofs_fanotify_handle_event(struct erofs_fanotify_ctx *ctx,
+				       struct fanotify_event_metadata *meta)
+{
+	u64 offset, count;
+	bool allow_access = true;
+	int err = 0, resp_err;
+
+	erofs_dbg("Handling fanotify event: mask=0x%llx fd=%d pid=%d",
+		  (unsigned long long)meta->mask, meta->fd, meta->pid);
+
+	if ((meta->mask & EROFS_FAN_PRE_ACCESS)) {
+		err = erofs_fanotify_parse_range_event(meta, &offset, &count);
+		if (err < 0) {
+			allow_access = false;
+			goto response;
+		}
+
+		err = erofs_fanotify_handle_range(ctx, offset, count);
+		if (err < 0)
+			allow_access = false;
+	}
+
+response:
+	resp_err = erofs_fanotify_respond(ctx->fan_fd, meta->fd, allow_access);
+	if (meta->fd >= 0)
+		close(meta->fd);
+	return resp_err ? resp_err : err;
+}
+
+int erofs_fanotify_loop(struct erofs_fanotify_ctx *ctx)
+{
+	char event_buf[4096] __attribute__((aligned(8)));
+	struct pollfd pfd = {
+		.fd = ctx->fan_fd,
+		.events = POLLIN,
+	};
+	int err = 0;
+
+	if (!ctx)
+		return -EINVAL;
+
+	while (1) {
+		struct fanotify_event_metadata *meta;
+		ssize_t len, remaining;
+
+		len = read(ctx->fan_fd, event_buf, sizeof(event_buf));
+		if (len <= 0) {
+			if (len < 0) {
+				if (errno == EAGAIN) {
+					if (poll(&pfd, 1, -1) < 0) {
+						if (errno == EINTR)
+							continue;
+						err = -errno;
+						break;
+					}
+					continue;
+				}
+				if (errno == EINTR)
+					continue;
+				err = -errno;
+				if (err == -EPIPE) {
+					err = 0;
+					break;
+				}
+				erofs_err("Failed to read fanotify events: %s",
+					  strerror(errno));
+				break;
+			}
+			erofs_err("Unexpected EOF on fanotify fd");
+			err = -EIO;
+			break;
+		}
+
+		remaining = len;
+		for (meta = (struct fanotify_event_metadata *)event_buf;
+		     FAN_EVENT_OK(meta, remaining);
+		     meta = FAN_EVENT_NEXT(meta, remaining)) {
+			err = erofs_fanotify_handle_event(ctx, meta);
+			if (err < 0)
+				break;
+		}
+		if (err)
+			break;
+		if (remaining) {
+			erofs_err("Invalid or incomplete fanotify event buffer");
+			err = -EIO;
+			break;
+		}
+	}
+
+	return err;
+}
diff --git a/lib/liberofs_fanotify.h b/lib/liberofs_fanotify.h
new file mode 100644
index 0000000..965090f
--- /dev/null
+++ b/lib/liberofs_fanotify.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
+#ifndef __EROFS_LIB_LIBEROFS_FANOTIFY_H
+#define __EROFS_LIB_LIBEROFS_FANOTIFY_H
+
+#include "erofs/defs.h"
+#include "erofs/io.h"
+#include <sys/fanotify.h>
+
+/* FAN_PRE_ACCESS may not be defined in older headers */
+#ifndef FAN_PRE_ACCESS
+#define EROFS_FAN_PRE_ACCESS	0x00100000
+#else
+#define EROFS_FAN_PRE_ACCESS	FAN_PRE_ACCESS
+#endif
+
+#ifndef FAN_CLASS_PRE_CONTENT
+#define EROFS_FAN_CLASS_PRE_CONTENT	0x00000008
+#else
+#define EROFS_FAN_CLASS_PRE_CONTENT	FAN_CLASS_PRE_CONTENT
+#endif
+
+#ifndef FAN_EVENT_INFO_TYPE_RANGE
+#define EROFS_FAN_EVENT_INFO_TYPE_RANGE	6
+#else
+#define EROFS_FAN_EVENT_INFO_TYPE_RANGE	FAN_EVENT_INFO_TYPE_RANGE
+#endif
+
+/* Provide a local alias for fanotify_event_info_range compatibility. */
+#ifndef HAVE_STRUCT_FANOTIFY_EVENT_INFO_RANGE
+typedef struct erofs_fanotify_event_info_range {
+	struct fanotify_event_info_header hdr;
+	__u32 pad;
+	__u64 offset;
+	__u64 count;
+} erofs_fanotify_event_info_range_t;
+#else
+typedef struct fanotify_event_info_range erofs_fanotify_event_info_range_t;
+#endif
+
+struct erofs_fanotify_ctx {
+	struct erofs_vfile vd;
+	int sparse_fd;
+	int fan_fd;
+	char *sparse_path;
+	void *fetch_buf;
+	size_t fetch_buf_size;
+	u64 image_size;
+};
+
+/* Initialize fanotify with EROFS_FAN_CLASS_PRE_CONTENT */
+int erofs_fanotify_init_precontent(void);
+
+/* Mark file for EROFS_FAN_PRE_ACCESS monitoring */
+int erofs_fanotify_mark_file(int fan_fd, const char *path);
+
+/* Run the fanotify event loop for a sparse-file backed OCI context. */
+int erofs_fanotify_loop(struct erofs_fanotify_ctx *ctx);
+
+#endif
diff --git a/lib/liberofs_oci.h b/lib/liberofs_oci.h
index 2243c82..3b3d66d 100644
--- a/lib/liberofs_oci.h
+++ b/lib/liberofs_oci.h
@@ -76,6 +76,9 @@ struct ocierofs_iostream {
  */
 int ocierofs_build_trees(struct erofs_importer *importer,
 			 const struct ocierofs_config *cfg);
+int ocierofs_ctx_init(struct ocierofs_ctx *ctx,
+		      const struct ocierofs_config *cfg);
+void ocierofs_ctx_cleanup(struct ocierofs_ctx *ctx);
 int ocierofs_io_open(struct erofs_vfile *vf, const struct ocierofs_config *cfg);
 
 char *ocierofs_encode_userpass(const char *username, const char *password);
diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
index 47e8b27..f96be13 100644
--- a/lib/remotes/oci.c
+++ b/lib/remotes/oci.c
@@ -1144,7 +1144,7 @@ const char *ocierofs_get_platform_spec(void)
 }
 
 /**
- * ocierofs_init - Initialize OCI context
+ * ocierofs_ctx_init - Initialize OCI context
  * @ctx: OCI context structure to initialize
  * @config: OCI configuration
  *
@@ -1154,7 +1154,7 @@ const char *ocierofs_get_platform_spec(void)
  *
  * Return: 0 on success, negative errno on failure
  */
-static int ocierofs_init(struct ocierofs_ctx *ctx, const struct ocierofs_config *config)
+int ocierofs_ctx_init(struct ocierofs_ctx *ctx, const struct ocierofs_config *config)
 {
 	int ret;
 
@@ -1288,7 +1288,7 @@ out:
  * Clean up CURL handle, free all allocated string parameters, and
  * reset the OCI context structure to a clean state.
  */
-static void ocierofs_ctx_cleanup(struct ocierofs_ctx *ctx)
+void ocierofs_ctx_cleanup(struct ocierofs_ctx *ctx)
 {
 	if (!ctx)
 		return;
@@ -1316,7 +1316,7 @@ int ocierofs_build_trees(struct erofs_importer *importer,
 	int ret, i, end, fd;
 	u64 tar_offset = 0;
 
-	ret = ocierofs_init(&ctx, config);
+	ret = ocierofs_ctx_init(&ctx, config);
 	if (ret) {
 		ocierofs_ctx_cleanup(&ctx);
 		return ret;
@@ -1529,7 +1529,7 @@ int ocierofs_io_open(struct erofs_vfile *vfile, const struct ocierofs_config *cf
 	if (!ctx)
 		return -ENOMEM;
 
-	err = ocierofs_init(ctx, cfg);
+	err = ocierofs_ctx_init(ctx, cfg);
 	if (err)
 		goto out;
 
diff --git a/mount/main.c b/mount/main.c
index 350738d..488ce02 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 #define _GNU_SOURCE
+#include <dirent.h>
 #include <fcntl.h>
 #include <getopt.h>
 #include <stdio.h>
@@ -18,6 +19,9 @@
 #include "../lib/liberofs_nbd.h"
 #include "../lib/liberofs_oci.h"
 #include "../lib/liberofs_gzran.h"
+#ifdef EROFS_FANOTIFY_ENABLED
+#include "../lib/liberofs_fanotify.h"
+#endif
 
 #ifdef HAVE_LINUX_LOOP_H
 #include <linux/loop.h>
@@ -40,12 +44,22 @@ struct loop_info {
 
 /* Device boundary probe */
 #define EROFSMOUNT_NBD_DISK_SIZE	(INT64_MAX >> 9)
+#define EROFSMOUNT_CACHE_DIR	"/var/cache/erofsmount"
+#define EROFSMOUNT_RUNTIME_DIR	"/run/erofsmount"
+#define EROFSMOUNT_FANOTIFY_STATE_DIR	EROFSMOUNT_RUNTIME_DIR "/fanotify"
+
+#ifdef EROFS_FANOTIFY_ENABLED
+#define EROFSMOUNT_FANOTIFY_HELP	", fanotify"
+#else
+#define EROFSMOUNT_FANOTIFY_HELP	""
+#endif
 
 enum erofs_backend_drv {
 	EROFSAUTO,
 	EROFSLOCAL,
 	EROFSFUSE,
 	EROFSNBD,
+	EROFSFANOTIFY,
 };
 
 enum erofsmount_mode {
@@ -95,7 +109,7 @@ static void usage(int argc, char **argv)
 		" -d <0-9>              set output verbosity; 0=quiet, 9=verbose (default=%i)\n"
 		" -o options            comma-separated list of mount options\n"
 		" -t type[.subtype]     filesystem type (and optional subtype)\n"
-		"                       subtypes: fuse, local, nbd\n"
+		"                       subtypes: fuse, local, nbd" EROFSMOUNT_FANOTIFY_HELP "\n"
 		" -u                    unmount the filesystem\n"
 		"    --disconnect       abort an existing NBD device forcibly\n"
 		"    --reattach         reattach to an existing NBD device\n"
@@ -324,6 +338,13 @@ static int erofsmount_parse_options(int argc, char **argv)
 					mountcfg.backend = EROFSLOCAL;
 				} else if (!strcmp(dot + 1, "nbd")) {
 					mountcfg.backend = EROFSNBD;
+				} else if (!strcmp(dot + 1, "fanotify")) {
+#ifdef EROFS_FANOTIFY_ENABLED
+					mountcfg.backend = EROFSFANOTIFY;
+#else
+					erofs_err("fanotify backend is not enabled at build time");
+					return -EINVAL;
+#endif
 				} else {
 					erofs_err("invalid filesystem subtype `%s`", dot + 1);
 					return -EINVAL;
@@ -1342,6 +1363,435 @@ out_err:
 	return -errno;
 }
 
+#ifdef EROFS_FANOTIFY_ENABLED
+struct erofsmount_fanotify_state {
+	pid_t pid;
+	char *mountpoint;
+	char *source;
+};
+
+static void erofsmount_free_fanotify_state(struct erofsmount_fanotify_state *state)
+{
+	free(state->mountpoint);
+	free(state->source);
+	state->mountpoint = NULL;
+	state->source = NULL;
+}
+
+static int erofsmount_write_fanotify_state(const char *state_path, pid_t pid,
+					   const char *mountpoint,
+					   const char *source)
+{
+	struct erofsmount_fanotify_state state;
+	char *tmp_path = NULL;
+	FILE *f = NULL;
+	int fd = -1, err;
+
+	if (mkdir(EROFSMOUNT_RUNTIME_DIR, 0700) < 0 && errno != EEXIST)
+		return -errno;
+	if (mkdir(EROFSMOUNT_FANOTIFY_STATE_DIR, 0700) < 0 &&
+	    errno != EEXIST)
+		return -errno;
+
+	state.pid = pid;
+	state.mountpoint = (char *)mountpoint;
+	state.source = (char *)source;
+
+	if (asprintf(&tmp_path, "%s.tmpXXXXXX", state_path) < 0)
+		return -ENOMEM;
+
+	fd = mkstemp(tmp_path);
+	if (fd < 0) {
+		err = -errno;
+		goto out;
+	}
+
+	f = fdopen(fd, "w");
+	if (!f) {
+		err = -errno;
+		goto out;
+	}
+	fd = -1;
+
+	if (fprintf(f, "%d\n%s\n%s\n", state.pid, state.mountpoint,
+		    state.source) < 0 || fflush(f) == EOF) {
+		err = errno ? -errno : -EIO;
+		goto out;
+	}
+
+	if (fsync(fileno(f)) < 0) {
+		err = -errno;
+		goto out;
+	}
+
+	if (fclose(f) < 0) {
+		err = -errno;
+		f = NULL;
+		goto out;
+	}
+	f = NULL;
+
+	if (rename(tmp_path, state_path) < 0) {
+		err = -errno;
+		goto out;
+	}
+
+	err = 0;
+out:
+	if (f)
+		fclose(f);
+	else if (fd >= 0)
+		close(fd);
+	if (err && tmp_path)
+		unlink(tmp_path);
+	free(tmp_path);
+	return err;
+}
+
+static int erofsmount_read_fanotify_state(const char *state_path,
+					  struct erofsmount_fanotify_state *state)
+{
+	FILE *f;
+	size_t n = 0;
+	int err = 0;
+
+	memset(state, 0, sizeof(*state));
+
+	f = fopen(state_path, "r");
+	if (!f)
+		return -errno;
+
+	if (fscanf(f, "%d", &state->pid) != 1)
+		err = -EINVAL;
+	else if (fgetc(f) != '\n')
+		err = -EINVAL;
+	else if (getline(&state->mountpoint, &n, f) < 0)
+		err = feof(f) ? -EINVAL : -errno;
+	else if (getline(&state->source, &n, f) < 0)
+		err = feof(f) ? -EINVAL : -errno;
+	fclose(f);
+	if (err) {
+		erofsmount_free_fanotify_state(state);
+		return err;
+	}
+
+	state->mountpoint[strcspn(state->mountpoint, "\n")] = '\0';
+	state->source[strcspn(state->source, "\n")] = '\0';
+	return err;
+}
+
+static int erofsmount_cleanup_fanotify_worker(const char *mountpoint,
+					      const char *source)
+{
+	DIR *dir;
+	struct dirent *de;
+	int err = 0;
+
+	dir = opendir(EROFSMOUNT_FANOTIFY_STATE_DIR);
+	if (!dir) {
+		if (errno == ENOENT)
+			return 0;
+		return -errno;
+	}
+
+	while ((de = readdir(dir)) != NULL) {
+		struct erofsmount_fanotify_state state;
+		char *state_path;
+
+		if (strcmp(de->d_name, ".") == 0 || strcmp(de->d_name, "..") == 0)
+			continue;
+		if (!strstr(de->d_name, ".state"))
+			continue;
+		if (asprintf(&state_path, "%s/%s", EROFSMOUNT_FANOTIFY_STATE_DIR,
+			     de->d_name) < 0) {
+			err = -ENOMEM;
+			goto out;
+		}
+
+		err = erofsmount_read_fanotify_state(state_path, &state);
+		if (err == -ENOENT) {
+			free(state_path);
+			err = 0;
+			continue;
+		}
+		if (err) {
+			free(state_path);
+			goto out;
+		}
+		if (strcmp(state.mountpoint, mountpoint) ||
+		    strcmp(state.source, source)) {
+			erofsmount_free_fanotify_state(&state);
+			free(state_path);
+			continue;
+		}
+		if (kill(state.pid, SIGTERM) < 0 && errno != ESRCH)
+			err = -errno;
+		else if (unlink(state_path) < 0 && errno != ENOENT)
+			err = -errno;
+		erofsmount_free_fanotify_state(&state);
+		free(state_path);
+		goto out;
+	}
+out:
+	closedir(dir);
+	if (!err)
+		return 0;
+	return err;
+}
+
+static int erofsmount_create_sparse_file(struct erofs_fanotify_ctx *ctx,
+					 u64 size, const char *blob_digest)
+{
+	char filepath[PATH_MAX];
+	const char *hex_digest;
+	int fd, err;
+
+	/* Extract hex part from "sha256:xxxx..." */
+	if (!blob_digest || strncmp(blob_digest, "sha256:", 7) != 0)
+		return -EINVAL;
+	hex_digest = blob_digest + 7;
+
+	/* Construct file path using blob SHA256 */
+	snprintf(filepath, sizeof(filepath), EROFSMOUNT_CACHE_DIR "/%s",
+		 hex_digest);
+
+	/* Try to open existing file or create new one */
+	fd = open(filepath, O_RDWR | O_CREAT, 0600);
+	if (fd < 0 && errno == ENOENT) {
+		err = mkdir(EROFSMOUNT_CACHE_DIR, 0700);
+		if (err)
+			return -errno;
+		fd = open(filepath, O_RDWR | O_CREAT, 0600);
+	}
+	if (fd < 0)
+		return -errno;
+
+	ctx->sparse_path = strdup(filepath);
+	if (!ctx->sparse_path) {
+		err = -ENOMEM;
+		goto err_path;
+	}
+
+	/* Set file size (creates sparse file) */
+	if (ftruncate(fd, size) < 0) {
+		err = -errno;
+		goto err_ftruncate;
+	}
+
+	ctx->sparse_fd = fd;
+	ctx->image_size = size;
+
+	erofs_dbg("Created local sparse file %s (size: %llu bytes)",
+		  ctx->sparse_path, (unsigned long long)size);
+	return 0;
+
+err_ftruncate:
+	free(ctx->sparse_path);
+	ctx->sparse_path = NULL;
+err_path:
+	close(fd);
+	unlink(filepath);
+	return err;
+}
+
+static int erofsmount_resolve_fanotify_blob(const struct ocierofs_config *oci_cfg,
+					    char **digest, u64 *image_size)
+{
+	struct ocierofs_ctx oci_ctx = {};
+	int err, i = -1;
+
+	err = ocierofs_ctx_init(&oci_ctx, oci_cfg);
+	if (err)
+		return err;
+
+	if (oci_ctx.blob_digest) {
+		for (i = 0; i < oci_ctx.layer_count; ++i) {
+			if (!strcmp(oci_ctx.layers[i]->digest, oci_ctx.blob_digest))
+				break;
+		}
+		if (i >= oci_ctx.layer_count) {
+			err = -ENOENT;
+			goto out;
+		}
+	} else if (oci_ctx.layer_count == 1) {
+		i = 0;
+	} else {
+		erofs_err("fanotify backend requires exactly one OCI blob; use oci.blob= or oci.layer=");
+		err = -EINVAL;
+		goto out;
+	}
+
+	*digest = strdup(oci_ctx.layers[i]->digest);
+	if (!*digest) {
+		err = -ENOMEM;
+		goto out;
+	}
+	*image_size = oci_ctx.layers[i]->size;
+	err = 0;
+
+out:
+	ocierofs_ctx_cleanup(&oci_ctx);
+	return err;
+}
+
+static void erofsmount_fanotify_ctx_cleanup(struct erofs_fanotify_ctx *ctx)
+{
+	if (ctx->fan_fd >= 0)
+		close(ctx->fan_fd);
+	if (ctx->sparse_fd >= 0)
+		close(ctx->sparse_fd);
+	if (ctx->vd.ops || ctx->vd.fd >= 0)
+		erofs_io_close(&ctx->vd);
+	free(ctx->fetch_buf);
+	free(ctx->sparse_path);
+}
+
+static int erofsmount_fanotify_child(struct erofs_fanotify_ctx *ctx,
+				     int pipefd)
+{
+	int err;
+
+	ctx->fan_fd = erofs_fanotify_init_precontent();
+	if (ctx->fan_fd < 0) {
+		err = ctx->fan_fd;
+		goto notify;
+	}
+
+	err = erofs_fanotify_mark_file(ctx->fan_fd, ctx->sparse_path);
+	if (err)
+		goto notify;
+
+	err = 0;
+notify:
+	write(pipefd, &err, sizeof(err));
+	close(pipefd);
+
+	if (err)
+		return err;
+
+	return erofs_fanotify_loop(ctx);
+}
+
+static int erofsmount_fanotify(struct erofsmount_source *source,
+			       const char *mountpoint, const char *fstype,
+			       int flags, const char *options)
+{
+	struct erofs_fanotify_ctx ctx = {
+		.vd = {.fd = -1},
+		.sparse_fd = -1,
+		.fan_fd = -1,
+	};
+	struct ocierofs_config layer_cfg;
+	char *blob_digest = NULL;
+	char *state_mountpoint = NULL;
+	char *state_path = NULL;
+	pid_t pid = -1;
+	int pipefd[2];
+	int err, child_err;
+	u64 image_size;
+
+	if (strcmp(fstype, "erofs")) {
+		fprintf(stderr, "unsupported filesystem type `%s`\n", fstype);
+		return -ENODEV;
+	}
+	flags |= MS_RDONLY;
+
+	if (source->ocicfg.tarindex_path || source->ocicfg.zinfo_path) {
+		erofs_err("fanotify backend does not support tarindex or zinfo");
+		return -EOPNOTSUPP;
+	}
+
+	state_mountpoint = realpath(mountpoint, NULL);
+	if (!state_mountpoint) {
+		err = -errno;
+		goto out;
+	}
+
+	err = erofsmount_resolve_fanotify_blob(&source->ocicfg, &blob_digest,
+					       &image_size);
+	if (err)
+		goto out;
+
+	layer_cfg = source->ocicfg;
+	layer_cfg.blob_digest = blob_digest;
+	layer_cfg.layer_index = -1;
+
+	err = ocierofs_io_open(&ctx.vd, &layer_cfg);
+	if (err)
+		goto out;
+
+	err = erofsmount_create_sparse_file(&ctx, image_size, blob_digest);
+	if (err)
+		goto out;
+
+	/* Create pipe for parent-child communication */
+	if (pipe(pipefd) < 0) {
+		err = -errno;
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		err = -errno;
+		close(pipefd[0]);
+		close(pipefd[1]);
+		goto out;
+	}
+
+	if (pid == 0) {
+		close(pipefd[0]);
+		err = erofsmount_fanotify_child(&ctx, pipefd[1]);
+		erofsmount_fanotify_ctx_cleanup(&ctx);
+		exit(err ? EXIT_FAILURE : EXIT_SUCCESS);
+	}
+
+	/* Wait for child to report fanotify initialization result */
+	close(pipefd[1]);
+	if (read(pipefd[0], &child_err, sizeof(child_err)) != sizeof(child_err))
+		child_err = -EPIPE;
+	close(pipefd[0]);
+
+	if (child_err) {
+		erofs_err("Child process failed: %s", erofs_strerror(child_err));
+		err = child_err;
+		goto kill_child;
+	}
+
+	err = mount(ctx.sparse_path, mountpoint, fstype, flags, options);
+	if (err < 0)
+		err = -errno;
+	if (err)
+		goto kill_child;
+
+	if (asprintf(&state_path, "%s/%d.state",
+		     EROFSMOUNT_FANOTIFY_STATE_DIR, pid) < 0) {
+		err = -ENOMEM;
+		goto out_umount;
+	}
+
+	err = erofsmount_write_fanotify_state(state_path, pid, state_mountpoint,
+					      ctx.sparse_path);
+	if (err)
+		goto out_umount;
+	erofs_dbg("Mounted %s at %s successfully", ctx.sparse_path, mountpoint);
+	goto out;
+
+out_umount:
+	(void)umount(mountpoint);
+kill_child:
+	if (pid > 0) {
+		(void)kill(pid, SIGTERM);
+		(void)waitpid(pid, NULL, 0);
+	}
+out:
+	free(state_path);
+	free(state_mountpoint);
+	erofsmount_fanotify_ctx_cleanup(&ctx);
+	free(blob_digest);
+	return err;
+}
+#endif
+
 int erofsmount_umount(char *target)
 {
 	char *device = NULL, *mountpoint = NULL;
@@ -1437,6 +1887,15 @@ int erofsmount_umount(char *target)
 			goto err_out;
 		}
 	}
+#ifdef EROFS_FANOTIFY_ENABLED
+	if (!isblk) {
+		err = erofsmount_cleanup_fanotify_worker(target, device);
+		if (err) {
+			close(fd);
+			goto err_out;
+		}
+	}
+#endif
 	err = fstat(fd, &st);
 	if (err < 0)
 		err = -errno;
@@ -1533,6 +1992,21 @@ int main(int argc, char *argv[])
 		goto exit;
 	}
 
+#ifdef EROFS_FANOTIFY_ENABLED
+	if (mountcfg.backend == EROFSFANOTIFY) {
+		if (mountsrc.type != EROFSMOUNT_SOURCE_OCI) {
+			erofs_err("Fanotify backend only supports OCI sources");
+			err = -EINVAL;
+			goto exit;
+		}
+		mountsrc.ocicfg.image_ref = mountcfg.device;
+		err = erofsmount_fanotify(&mountsrc, mountcfg.target,
+					  mountcfg.fstype, mountcfg.flags,
+					  mountcfg.options);
+		goto exit;
+	}
+#endif
+
 	if (mountcfg.force_loopdev)
 		goto loopmount;
 
-- 
2.47.3


