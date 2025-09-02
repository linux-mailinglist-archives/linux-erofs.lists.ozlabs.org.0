Return-Path: <linux-erofs+bounces-949-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7B1B40882
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Sep 2025 17:06:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cGTbP04ncz30gC;
	Wed,  3 Sep 2025 01:06:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756825584;
	cv=none; b=VQEvlCzMEgjloFq1+pWqyryuXpLXftioCylCULY8I0SKlRQ1Kq0ceyoXr0dJIZJsyjbyeEpRrW0XwSRO87OD19sUVEtN5qWFOgjHShNNcsq7HNBmzGKHbtp0jwuCvqRsyhcAR/y0loJfs4rRQtmJnSw508YDDVAZNXHNY5R4WbEerZp38albHM348ywNZEZJ9uBPBmwZo0wa8b2jtln/VcqGrhrNDKSSoFaskteuoVoPseW5u6kszWxTct8c0sSGdgmZyb4LO09bZGVaJT+nwoOA8yL3zKUsFkcqZVmXEag0jtuOOnyW4p3fpnFOztgDouCh+DGW9CnQY9HiBIGz8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756825584; c=relaxed/relaxed;
	bh=s6eqfDmH8vs9iaeB4My6rL0C9QJScXGL8juQZvBhfRw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FzEpiFh1MMHwt3W48DMNjrfNzYj1WMI+Ask2Z1tJwRlJcQMkh40VPc61Uc2HLklrJqv0vXwC+hpzlInZ+Pd+tw0++ct1tU55DiDiI0e8lW/2OjzqjKLi4P3l/IvmxTtRJE+H3rYnpCuYA5qsHY/RaDUllB7Thtq6HO6FdHeZz3FJMfIClKOgb5roNhUk2zxKEiiLnQM5q8Fv+0FP2HoPSJVGrEGCuDaUxHU887yUP/OyhFoMyisd0+68hSVn6oIZzv9EWV2dBk1KfgB5yqnyPOVGKfn6z/brnr3GjeWlzDJuwcFqu7B10difGCeYULO3B9zaUijomiKxcG2Xea+Weg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=EfgrWM7D; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=EfgrWM7D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cGTbL07WHz2yN1
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Sep 2025 01:06:20 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756825576; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=s6eqfDmH8vs9iaeB4My6rL0C9QJScXGL8juQZvBhfRw=;
	b=EfgrWM7Dry+avv2oj89O4IOLZolKX6UbLdVjUH7D0d1xzEkSyeKg/f7Hl93JRzt9TDBtRWwe6luMYu5hJ/TLOPK9j816OtM9DsPBsF17nQAZO0sBwTi60723lJQDIQi+wNuC2g1AbZANZem8sKSUEXgy6J/ACcZgocjXmlyj3Xw=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wn88ZhS_1756825571 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Sep 2025 23:06:15 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/4] erofs-utils: lib: nbd: add support for the netlink interface
Date: Tue,  2 Sep 2025 23:06:07 +0800
Message-ID: <20250902150610.887543-1-hsiangkao@linux.alibaba.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Meta (formerly Facebook) developed a new netlink‑based interface [1]
since Linux 4.12 to replace the old ioctl‑based interface for crash
recovery and daemon hot upgrade.

[1] https://lore.kernel.org/r/1491512527-4286-1-git-send-email-jbacik@fb.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 configure.ac       |  29 +++++++
 lib/Makefile.am    |   1 +
 lib/backends/nbd.c | 191 +++++++++++++++++++++++++++++++++++++++++++++
 lib/liberofs_nbd.h |   2 +
 mount/Makefile.am  |   2 +-
 mount/main.c       |  79 ++++++++++++++++---
 6 files changed, 290 insertions(+), 14 deletions(-)

diff --git a/configure.ac b/configure.ac
index 7db4489..0c03a1d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -181,6 +181,10 @@ AC_ARG_WITH(json_c,
    [AS_HELP_STRING([--with-json-c],
       [Enable and build with json-c support @<:@default=auto@:>@])])
 
+AC_ARG_WITH(libnl3,
+   [AS_HELP_STRING([--with-libnl3],
+      [Enable and build with libnl3 support @<:@default=auto@:>@])])
+
 AC_ARG_ENABLE(s3,
    [AS_HELP_STRING([--enable-s3], [enable s3 image generation support @<:@default=no@:>@])],
    [enable_s3="$enableval"], [enable_s3="no"])
@@ -718,6 +722,31 @@ AS_IF([test "x$with_libxml2" != "xno"], [
   ])
 ])
 
+# Configure libnl3
+have_libnl3="no"
+AS_IF([test "x$with_libnl3" != "xno"], [
+  PKG_CHECK_MODULES([libnl3], [libnl-genl-3.0 >= 3.1], [
+    # Paranoia: don't trust the result reported by pkgconfig before trying out
+    saved_LIBS="$LIBS"
+    saved_CPPFLAGS=${CPPFLAGS}
+    CPPFLAGS="${libnl3_CFLAGS} ${CPPFLAGS}"
+    LIBS="${libnl3_LIBS} $LIBS"
+    AC_CHECK_HEADERS([netlink/genl/genl.h],[
+      AC_CHECK_LIB(nl-genl-3, genl_connect, [], [
+        AC_MSG_ERROR([libnl3 doesn't work properly])])
+      AC_CHECK_DECL(genl_connect, [have_libnl3="yes"],
+        [AC_MSG_ERROR([libnl3 doesn't work properly])], [[
+#include <netlink/genl/genl.h>
+      ]])
+    ])
+    LIBS="${saved_LIBS}"
+    CPPFLAGS="${saved_CPPFLAGS}"], [
+    AS_IF([test "x$with_libnl3" = "xyes"], [
+      AC_MSG_ERROR([Cannot find proper libnl3])
+    ])
+  ])
+])
+
 AS_IF([test "x$enable_s3" != "xno"], [
   AS_IF(
     [test "x$have_libcurl" = "xyes" && \
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 1c8be2c..1d7958b 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -79,6 +79,7 @@ liberofs_la_LDFLAGS += -lpthread
 liberofs_la_SOURCES += workqueue.c
 endif
 if OS_LINUX
+liberofs_la_CFLAGS += ${libnl3_CFLAGS}
 liberofs_la_SOURCES += backends/nbd.c
 endif
 if ENABLE_OCI
diff --git a/lib/backends/nbd.c b/lib/backends/nbd.c
index 43630f0..7058a81 100644
--- a/lib/backends/nbd.c
+++ b/lib/backends/nbd.c
@@ -19,6 +19,12 @@
 #include "erofs/print.h"
 #include "liberofs_nbd.h"
 
+#ifdef HAVE_NETLINK_GENL_GENL_H
+#include <netlink/netlink.h>
+#include <netlink/genl/genl.h>
+#include <netlink/genl/ctrl.h>
+#endif
+
 #define NBD_SET_SOCK		_IO( 0xab, 0 )
 #define NBD_SET_BLKSIZE		_IO( 0xab, 1 )
 #define NBD_DO_IT		_IO( 0xab, 3 )
@@ -168,6 +174,191 @@ err_out:
 	return err;
 }
 
+#if defined(HAVE_NETLINK_GENL_GENL_H) && defined(HAVE_LIBNL_GENL_3)
+enum {
+	NBD_ATTR_UNSPEC,
+	NBD_ATTR_INDEX,
+	NBD_ATTR_SIZE_BYTES,
+	NBD_ATTR_BLOCK_SIZE_BYTES,
+	NBD_ATTR_TIMEOUT,
+	NBD_ATTR_SERVER_FLAGS,
+	NBD_ATTR_CLIENT_FLAGS,
+	NBD_ATTR_SOCKETS,
+	NBD_ATTR_DEAD_CONN_TIMEOUT,
+	NBD_ATTR_DEVICE_LIST,
+	NBD_ATTR_BACKEND_IDENTIFIER,
+	__NBD_ATTR_MAX,
+};
+#define NBD_ATTR_MAX (__NBD_ATTR_MAX - 1)
+
+enum {
+	NBD_SOCK_ITEM_UNSPEC,
+	NBD_SOCK_ITEM,
+	__NBD_SOCK_ITEM_MAX,
+};
+#define NBD_SOCK_ITEM_MAX (__NBD_SOCK_ITEM_MAX - 1)
+
+enum {
+	NBD_SOCK_UNSPEC,
+	NBD_SOCK_FD,
+	__NBD_SOCK_MAX,
+};
+#define NBD_SOCK_MAX (__NBD_SOCK_MAX - 1)
+
+enum {
+	NBD_CMD_UNSPEC,
+	NBD_CMD_CONNECT,
+	NBD_CMD_DISCONNECT,
+	__NBD_CMD_MAX,
+};
+
+/* client behavior specific flags */
+/* delete the nbd device on disconnect */
+#define NBD_CFLAG_DESTROY_ON_DISCONNECT		(1 << 0)
+/* disconnect the nbd device on close by last opener */
+#define NBD_CFLAG_DISCONNECT_ON_CLOSE		(1 << 1)
+
+static struct nl_sock *erofs_nbd_get_nl_sock(int *driver_id)
+{
+	struct nl_sock *socket;
+	int err;
+
+	socket = nl_socket_alloc();
+	if (!socket) {
+		erofs_err("Couldn't allocate netlink socket");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	err = genl_connect(socket);
+	if (err) {
+		erofs_err("Couldn't connect to the generic netlink socket");
+		return ERR_PTR(err);
+	}
+
+	err = genl_ctrl_resolve(socket, "nbd");
+	if (err < 0) {
+		erofs_err("Failed to resolve NBD netlink family. Ensure the NBD module is loaded and it supports netlink.");
+		return ERR_PTR(err);
+	}
+	*driver_id = err;
+	return socket;
+}
+
+struct erofs_nbd_nl_cfg_cbctx {
+	int *index;
+	int errcode;
+};
+
+static int erofs_nbd_nl_cfg_cb(struct nl_msg *msg, void *arg)
+{
+	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
+	struct nlattr *msg_attr[NBD_ATTR_MAX + 1];
+	struct erofs_nbd_nl_cfg_cbctx *ctx = arg;
+	int err;
+
+	err = nla_parse(msg_attr, NBD_ATTR_MAX, genlmsg_attrdata(gnlh, 0),
+			genlmsg_attrlen(gnlh, 0), NULL);
+	if (err) {
+		erofs_err("Invalid response from the kernel");
+		ctx->errcode = err;
+	}
+
+	if (!msg_attr[NBD_ATTR_INDEX]) {
+		erofs_err("Did not receive index from the kernel");
+		ctx->errcode = -EBADMSG;
+	}
+	*ctx->index = nla_get_u32(msg_attr[NBD_ATTR_INDEX]);
+	erofs_dbg("Connected /dev/nbd%d\n", *ctx->index);
+	ctx->errcode = 0;
+	return NL_OK;
+}
+
+int erofs_nbd_nl_connect(int *index, int blkbits, u64 blocks,
+			 const char *identifier)
+{
+	struct erofs_nbd_nl_cfg_cbctx cbctx = {
+		.index = index,
+	};
+	struct nl_sock *socket;
+	struct nlattr *sock_attr, *sock_opt;
+	struct nl_msg *msg;
+	int sv[2], err;
+	int driver_id;
+
+	err = socketpair(AF_UNIX, SOCK_STREAM, 0, sv);
+	if (err < 0)
+		return -errno;
+
+	socket = erofs_nbd_get_nl_sock(&driver_id);
+	if (IS_ERR(socket)) {
+		err = PTR_ERR(socket);
+		goto err_out;
+	}
+	nl_socket_modify_cb(socket, NL_CB_VALID, NL_CB_CUSTOM,
+			    erofs_nbd_nl_cfg_cb, &cbctx);
+
+	msg = nlmsg_alloc();
+	if (!msg) {
+		erofs_err("Couldn't allocate netlink message");
+		err = -ENOMEM;
+		goto err_nls_free;
+	}
+
+	genlmsg_put(msg, NL_AUTO_PORT, NL_AUTO_SEQ, driver_id, 0, 0,
+		    NBD_CMD_CONNECT, 0);
+	if (*index >= 0)
+		NLA_PUT_U32(msg, NBD_ATTR_INDEX, *index);
+	NLA_PUT_U64(msg, NBD_ATTR_BLOCK_SIZE_BYTES, 1u << blkbits);
+	NLA_PUT_U64(msg, NBD_ATTR_SIZE_BYTES, blocks << blkbits);
+	NLA_PUT_U64(msg, NBD_ATTR_SERVER_FLAGS, NBD_FLAG_READ_ONLY);
+	NLA_PUT_U64(msg, NBD_ATTR_TIMEOUT, 0);
+	if (identifier)
+		NLA_PUT_STRING(msg, NBD_ATTR_BACKEND_IDENTIFIER, identifier);
+
+	err = -EINVAL;
+	sock_attr = nla_nest_start(msg, NBD_ATTR_SOCKETS);
+	if (!sock_attr) {
+		erofs_err("Couldn't nest the sockets for our connection");
+		goto err_nlm_free;
+	}
+
+	sock_opt = nla_nest_start(msg, NBD_SOCK_ITEM);
+	if (!sock_attr) {
+		nla_nest_cancel(msg, sock_attr);
+		goto err_nlm_free;
+	}
+	NLA_PUT_U32(msg, NBD_SOCK_FD, sv[1]);
+	nla_nest_end(msg, sock_opt);
+	nla_nest_end(msg, sock_attr);
+
+	err = nl_send_sync(socket, msg);
+	if (err)
+		goto err_out;
+	nl_socket_free(socket);
+	if (cbctx.errcode)
+		return cbctx.errcode;
+	return sv[0];
+
+nla_put_failure:
+	nla_nest_cancel(msg, sock_opt);
+	nla_nest_cancel(msg, sock_attr);
+err_nlm_free:
+	nlmsg_free(msg);
+err_nls_free:
+	nl_socket_free(socket);
+err_out:
+	close(sv[0]);
+	close(sv[1]);
+	return err;
+}
+#else
+int erofs_nbd_nl_connect(int *index, int blkbits, u64 blocks,
+			 const char *identifier)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 int erofs_nbd_do_it(int nbdfd)
 {
 	int err;
diff --git a/lib/liberofs_nbd.h b/lib/liberofs_nbd.h
index c493aca..89c4cf2 100644
--- a/lib/liberofs_nbd.h
+++ b/lib/liberofs_nbd.h
@@ -39,4 +39,6 @@ int erofs_nbd_get_request(int skfd, struct erofs_nbd_request *rq);
 int erofs_nbd_send_reply_header(int skfd, __le64 cookie, int err);
 int erofs_nbd_disconnect(int nbdfd);
 
+int erofs_nbd_nl_connect(int *index, int blkbits, u64 blocks,
+			 const char *identifier);
 #endif
diff --git a/mount/Makefile.am b/mount/Makefile.am
index b76e336..d93f3f4 100644
--- a/mount/Makefile.am
+++ b/mount/Makefile.am
@@ -9,5 +9,5 @@ mount_erofs_SOURCES = main.c
 mount_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
 mount_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
 	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} \
-	${libzstd_LIBS} ${libqpl_LIBS} ${libxxhash_LIBS}
+	${libzstd_LIBS} ${libqpl_LIBS} ${libxxhash_LIBS} ${libnl3_LIBS}
 endif
diff --git a/mount/main.c b/mount/main.c
index c9deae2..0df885b 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -299,6 +299,53 @@ out_closefd:
 	return err;
 }
 
+static int erofsmount_startnbd_nl(pid_t *pid, const char *source)
+{
+	struct erofsmount_nbd_ctx ctx = {};
+	int err, num;
+	int pipefd[2];
+
+	err = open(source, O_RDONLY);
+	if (err < 0)
+		return -errno;
+	ctx.vd.fd = err;
+
+	err = pipe(pipefd);
+	if (err < 0) {
+		err = -errno;
+		close(ctx.vd.fd);
+		return err;
+	}
+	if ((*pid = fork()) == 0) {
+		/* Otherwise, NBD disconnect sends SIGPIPE, skipping cleanup */
+		if (signal(SIGPIPE, SIG_IGN) == SIG_ERR) {
+			close(ctx.vd.fd);
+			exit(EXIT_FAILURE);
+		}
+
+		num = -1;
+		err = erofs_nbd_nl_connect(&num, 9, INT64_MAX >> 9, NULL);
+		if (err >= 0) {
+			ctx.sk.fd = err;
+			err = write(pipefd[1], &num, sizeof(int));
+			if (err >= sizeof(int)) {
+				close(pipefd[1]);
+				close(pipefd[0]);
+				err = (int)(uintptr_t)erofsmount_nbd_loopfn(&ctx);
+				exit(err ? EXIT_FAILURE : EXIT_SUCCESS);
+			}
+		}
+		close(ctx.vd.fd);
+		exit(EXIT_FAILURE);
+	}
+	close(pipefd[1]);
+	err = read(pipefd[0], &num, sizeof(int));
+	close(pipefd[0]);
+	if (err < sizeof(int))
+		return -EPIPE;
+	return num;
+}
+
 static int erofsmount_nbd(const char *source, const char *mountpoint,
 			  const char *fstype, int flags,
 			  const char *options)
@@ -315,19 +362,25 @@ static int erofsmount_nbd(const char *source, const char *mountpoint,
 	}
 	flags |= MS_RDONLY;
 
-	num = erofs_nbd_devscan();
-	if (num < 0)
-		return num;
-
-	(void)snprintf(nbdpath, sizeof(nbdpath), "/dev/nbd%d", num);
-	nbdfd = open(nbdpath, O_RDWR);
-	if (nbdfd < 0)
-		return -errno;
-
-	if ((pid = fork()) == 0)
-		return erofsmount_startnbd(nbdfd, source) ?
-			EXIT_FAILURE : EXIT_SUCCESS;
-	close(nbdfd);
+	err = erofsmount_startnbd_nl(&pid, source);
+	if (err < 0) {
+		num = erofs_nbd_devscan();
+		if (num < 0)
+			return num;
+
+		(void)snprintf(nbdpath, sizeof(nbdpath), "/dev/nbd%d", num);
+		nbdfd = open(nbdpath, O_RDWR);
+		if (nbdfd < 0)
+			return -errno;
+
+		if ((pid = fork()) == 0)
+			return erofsmount_startnbd(nbdfd, source) ?
+				EXIT_FAILURE : EXIT_SUCCESS;
+		close(nbdfd);
+	} else {
+		num = err;
+		(void)snprintf(nbdpath, sizeof(nbdpath), "/dev/nbd%d", num);
+	}
 
 	while (1) {
 		err = erofs_nbd_in_service(num);
-- 
2.43.5


