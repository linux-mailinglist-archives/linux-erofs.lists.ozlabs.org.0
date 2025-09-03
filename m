Return-Path: <linux-erofs+bounces-950-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C42BB41245
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Sep 2025 04:20:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cGmY02C7Vz305M;
	Wed,  3 Sep 2025 12:20:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756866020;
	cv=none; b=Wz4gUXvGQUv++QZKg4itQkLGffw7FMBipq+y1kxFg+svVNy2eQJ0Ghylz1dGKDvOA79j8aE6vmKM0OyyIflDpOdxSa9q7QaX1TyekdaWblzRSyIhW2jkOz9vhmCdMzYQCMsKpgNlfA80RkCrPrJaBKqseeJIKdlDKo0oiXCG1Va2eOKbbXpX5pWXlGpc1O6pVEPvvqANsN6+We6k8yRME3TiZOqLuGwUtCdMRrp37lhoM/gZ6utt0kIkDSIZ6RgDwkKJZlrEqMgvv4GGZIIGKhiqBWDY0EkNKTLCfHJEn+36851kiu23m99IYXePivZlfcI2LgPkLe138ZdOlnPOiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756866020; c=relaxed/relaxed;
	bh=aZI0wfKJBUTXmpfxjUkGnMX6jNvcr0yCkl1/Se1SmFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=azEe60MVGbc5RjtgLM92GwpuBb6MrZnFC6fHMP7xmggEmuRHinXeLOkT1njd33x69PQsarkIEPDnV0Na2PSEifgsMO8RSQ1wCsOVjlCAMDnvi66fYcI6WLzLB0GpjVHBaoQ9kAr1cwSZvZlRqXV+LcTEnNrb9VqNCVHxAyAtI/GEZ/dKBVwXASoOhHuAt/21P1nCsqZQ8SD9xOTeM9iIqAcLetSGFTYZRdX1HhKwJyHN9R/XTVoYqShzML9xh4yt+PcTEPzSxW8uiZCvnqMmnko/UTYcoiMpYrdAQLi27BRc7nhkQWqbFSSXpkVd3UnExOqAX2fiTukTgP31mJAjlQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=F8/VmyH0; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=F8/VmyH0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cGmXy32YFz2xgX
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Sep 2025 12:20:17 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756866013; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=aZI0wfKJBUTXmpfxjUkGnMX6jNvcr0yCkl1/Se1SmFU=;
	b=F8/VmyH0+yAYf1ENseu5KMOKS45hG+1XUsbxIEeMxDoDWEghM4yzGj6L8E+GuL4QmYbMln1pMTwx20NJgC2hNW/Tqgt0Fd4H2S4e25IgrWAUEKYHv9/66J0xytLK/ZEQJmlP9lMhZqnOE0ZRKQnte786ybYMIx/csOinKYmoptc=
Received: from localhost.localdomain(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wn9cUCV_1756866012 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Sep 2025 10:20:12 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2 2/4] erofs-utils: lib: nbd: add support for the netlink reconnection
Date: Wed,  3 Sep 2025 10:18:56 +0800
Message-ID: <20250903021858.66418-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250903021858.66418-1-hsiangkao@linux.alibaba.com>
References: <20250903021858.66418-1-hsiangkao@linux.alibaba.com>
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
 lib/backends/nbd.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++
 lib/liberofs_nbd.h |  4 ++
 2 files changed, 99 insertions(+)

diff --git a/lib/backends/nbd.c b/lib/backends/nbd.c
index 8b1842c..bf1b43c 100644
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
 
@@ -339,6 +361,74 @@ int erofs_nbd_nl_connect(int *index, int blkbits, u64 blocks,
 		return cbctx.errcode;
 	return sv[0];
 
+nla_put_failure:
+	if (sock_opt)
+		nla_nest_cancel(msg, sock_opt);
+	if (sock_attr)
+		nla_nest_cancel(msg, sock_attr);
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
+	struct nlattr *sock_attr = NULL, *sock_opt = NULL;
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
+	if (!sock_opt) {
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
 	if (sock_opt)
 		nla_nest_cancel(msg, sock_opt);
@@ -359,6 +449,11 @@ int erofs_nbd_nl_connect(int *index, int blkbits, u64 blocks,
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
2.43.0


