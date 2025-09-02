Return-Path: <linux-erofs+bounces-947-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EC6B4087C
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Sep 2025 17:06:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cGTbM6PWvz30g6;
	Wed,  3 Sep 2025 01:06:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756825583;
	cv=none; b=KJw2twQyAgM2KRDCAbM6Nh/YEFFTAGiLj0AYMPSOm0BLRcjhFp3cH/HxFC8Wpx9kvhoA3QmlXtZmzh9uiX2Beq5Tci5nmZElwga62bJqOpv2mvCWiaYvHa3ld5PEh+IlO3txiSed5fgWpPEVXkLXoNQEsi22XTQvje1bl3W7XnHby6IvPNbS/Q7za8X/bl+LVj9h62H6BlTRfLuY3/M99Fauzdqvf2Aii8lFQzX6H7mb+wGwhqOfUauN13wSbd9qMGR6xUMALqh+mxvaZzH0c9SoWI3AAeRWXeX5fS1IXp714OTp51+rqfXgJU8sBflv2BdkosxBTcpd7AJoGHRChQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756825583; c=relaxed/relaxed;
	bh=8XATHydEGhJFOg5jHKO7N8lWxZX9DDap6UlhJ5NDdng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cl4wLX39JbjPb5WLKaOmdytizy++3hfW0J75FLi5ZGLemr9SiiIkuSd65yb5wTNotwFQdqqPvKB8EufEE/FVGWc2LFiMSKjSWkghy8dR92surD1IK6yNWZIH7k7nsV6wSKRMJg+05Ue5/aPoJdPa11laUntgfif7vvCjGW5eWQRa9ONPSKOSI1+2DrCWoTDBiUWGwuoz/3rv7CF00LrlH9/btHcjxXuTBzvGhVRSdE2IfLuZ8pacFjuNWJ0OP/RLNiaAHAjNGAPYmaGfZ1fOKK/ag+Y40Lv8DyBS8hoBKE4Tzj2VeBiGB4jH5nYmmxKO0ArYaIV71PkLY1F8Xy/tMg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=uyZSZNgb; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=uyZSZNgb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cGTbL1cZ3z30YZ
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Sep 2025 01:06:21 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756825578; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=8XATHydEGhJFOg5jHKO7N8lWxZX9DDap6UlhJ5NDdng=;
	b=uyZSZNgb5LRDFsERjnajHjubsMkugxIOLc4ERzAeGvpQZ9mSkKhW7AWz69o+hUTEWL/pe5/vgSAefa2BJykoZ5e/G4DcDEfI9qUpGq53vzHsRznS7kcs5sB7TQnrP6eU2sRS/PjNspG7jGqSLk3txtdjpa1CGOXhqFa6+5Njx7o=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wn88ZiN_1756825575 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Sep 2025 23:06:16 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/4] erofs-utils: lib: nbd: add support for the netlink reconnection
Date: Tue,  2 Sep 2025 23:06:08 +0800
Message-ID: <20250902150610.887543-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250902150610.887543-1-hsiangkao@linux.alibaba.com>
References: <20250902150610.887543-1-hsiangkao@linux.alibaba.com>
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

In order to support NBD failover.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/backends/nbd.c | 93 ++++++++++++++++++++++++++++++++++++++++++++++
 lib/liberofs_nbd.h |  4 ++
 2 files changed, 97 insertions(+)

diff --git a/lib/backends/nbd.c b/lib/backends/nbd.c
index 7058a81..9b56a56 100644
--- a/lib/backends/nbd.c
+++ b/lib/backends/nbd.c
@@ -174,6 +174,26 @@ err_out:
 	return err;
 }
 
+char *erofs_nbd_get_identifier(int nbdnum)
+{
+	char s[32], *line = NULL;
+	size_t n;
+	FILE *f;
+	int err;
+
+	(void)snprintf(s, sizeof(s), "/sys/block/nbd%d/backend", nbdnum);
+	f = fopen(s, "r");
+	if (!f)
+		return ERR_PTR(-errno);
+
+	if (getline(&line, &n, f) < 0)
+		err = -errno;
+	else
+		err = 0;
+	fclose(f);
+	return err ? ERR_PTR(err) : line;
+}
+
 #if defined(HAVE_NETLINK_GENL_GENL_H) && defined(HAVE_LIBNL_GENL_3)
 enum {
 	NBD_ATTR_UNSPEC,
@@ -209,6 +229,7 @@ enum {
 	NBD_CMD_UNSPEC,
 	NBD_CMD_CONNECT,
 	NBD_CMD_DISCONNECT,
+	NBD_CMD_RECONFIGURE,
 	__NBD_CMD_MAX,
 };
 
@@ -312,6 +333,7 @@ int erofs_nbd_nl_connect(int *index, int blkbits, u64 blocks,
 	NLA_PUT_U64(msg, NBD_ATTR_SIZE_BYTES, blocks << blkbits);
 	NLA_PUT_U64(msg, NBD_ATTR_SERVER_FLAGS, NBD_FLAG_READ_ONLY);
 	NLA_PUT_U64(msg, NBD_ATTR_TIMEOUT, 0);
+	NLA_PUT_U64(msg, NBD_ATTR_DEAD_CONN_TIMEOUT, EROFS_NBD_DEAD_CONN_TIMEOUT);
 	if (identifier)
 		NLA_PUT_STRING(msg, NBD_ATTR_BACKEND_IDENTIFIER, identifier);
 
@@ -339,6 +361,72 @@ int erofs_nbd_nl_connect(int *index, int blkbits, u64 blocks,
 		return cbctx.errcode;
 	return sv[0];
 
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
+
+int erofs_nbd_nl_reconnect(int index, const char *identifier)
+{
+	struct nlattr *sock_attr, *sock_opt;
+	struct nl_sock *socket;
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
+
+	msg = nlmsg_alloc();
+	if (!msg) {
+		erofs_err("Couldn't allocate netlink message");
+		err = -ENOMEM;
+		goto err_nls_free;
+	}
+
+	genlmsg_put(msg, NL_AUTO_PORT, NL_AUTO_SEQ, driver_id, 0, 0,
+		    NBD_CMD_RECONFIGURE, 0);
+	NLA_PUT_U32(msg, NBD_ATTR_INDEX, index);
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
+	return sv[0];
+
 nla_put_failure:
 	nla_nest_cancel(msg, sock_opt);
 	nla_nest_cancel(msg, sock_attr);
@@ -357,6 +445,11 @@ int erofs_nbd_nl_connect(int *index, int blkbits, u64 blocks,
 {
 	return -EOPNOTSUPP;
 }
+
+int erofs_nbd_nl_reconnect(int index, const char *identifier)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 int erofs_nbd_do_it(int nbdfd)
diff --git a/lib/liberofs_nbd.h b/lib/liberofs_nbd.h
index 89c4cf2..03886de 100644
--- a/lib/liberofs_nbd.h
+++ b/lib/liberofs_nbd.h
@@ -31,6 +31,9 @@ struct erofs_nbd_request {
         u32 len;
 } __packed;
 
+/* 30-day timeout for NBD recovery */
+#define EROFS_NBD_DEAD_CONN_TIMEOUT	(3600 * 24 * 30)
+
 long erofs_nbd_in_service(int nbdnum);
 int erofs_nbd_devscan(void);
 int erofs_nbd_connect(int nbdfd, int blkbits, u64 blocks);
@@ -41,4 +44,5 @@ int erofs_nbd_disconnect(int nbdfd);
 
 int erofs_nbd_nl_connect(int *index, int blkbits, u64 blocks,
 			 const char *identifier);
+int erofs_nbd_nl_reconnect(int index, const char *identifier);
 #endif
-- 
2.43.5


