Return-Path: <linux-erofs+bounces-955-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D04B41852
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Sep 2025 10:23:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cGwcX65fxz2yFJ;
	Wed,  3 Sep 2025 18:23:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756887836;
	cv=none; b=jknJKPFWaQA+AQ1mCLGINqTMQTQ0BqyN8+hDwtEVEeLsEI9JSpQ7aC5Hh7sVPGZMHYUdaDConU6ZRWtbkSpbPFvXVi7vwI9hpz6Ks6HY9J0NKZgkrq4GTYhVVJ/9MFfGqUAHdcji3xuEr9miMWAIW4sUc9G//FY3pAYVnh6CPiIcssdWyK7xyaDJZciZZspm04DGqYXzGCAE4GhN3PyrRc8wCvucT9d0Lj18C0jjyxBiMt3wONDHZ/0dTnuz8cRhgaxSRrKKF20hf5kAYxvhh2z2wkaWVKQF4UbVBn+GJTIFpz28keDv5S9/Fs9yyElLht+m2gOa9aY9pcj4CjdtDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756887836; c=relaxed/relaxed;
	bh=LeGdrM5MOdOXjx/WCqwwR+688T+THqWKDEiDVbio+XI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G0fdYMS+l4N2W/78/U1KzQDTbX8dG/KXDndeNApVQ4DLnfFdmo5KXVoyT7FSBgESXr1fGIrnP73D2F04MoAs/uGmacNW7ZpgpL9GO4BIrw0eIWQdpWMK5ys0dLTIvtvD1WDNzoCEq1qqCQArbLpPINb3GMLQpkmuEr4Sz8p0Z0s8nGpz/kDKnU+LLLtgjTXeVNArY+ehVDex2DN8z5+HvlbFlTpmppTKF77MFzvu9w9kZ8szgRfLy5j5HMxzmW5MuuB9QvnNh/OpyWk4xTVcC5VOFu7qi3XNhQDLH8e7ZsqWpTLK9s1Or/tr3y4ujjBiP+hdVyHQmIjMmtRRWZtZUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wacBVBv9; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wacBVBv9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cGwcV5t9kz2xQ1
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Sep 2025 18:23:52 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756887828; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=LeGdrM5MOdOXjx/WCqwwR+688T+THqWKDEiDVbio+XI=;
	b=wacBVBv9xMgit+gy6bR5MwxL64WzqsMm6cnKv7EBPrtg74ITrxYWE5+AW6evMSOjtGaBtQ0nI0rKyI3fRsA/GbVZgCxQyWW5CJXMfP7QjkEEGzpHjdxSZ4lVdOXFklF8Hb8F9uOUH+CKuOfgtAqGUtHyTxvrKrL3Sy5ZYcNJ09o=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WnB98Ob_1756887823 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Sep 2025 16:23:47 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: mount: enable autoclear for NBD devices
Date: Wed,  3 Sep 2025 16:23:41 +0800
Message-ID: <20250903082341.2240726-1-hsiangkao@linux.alibaba.com>
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
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Enable NBD_CFLAG_DISCONNECT_ON_CLOSE to allow `umount(2)` to unmount
the filesystem and disconnect NBD devices in a single operation.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/backends/nbd.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 lib/liberofs_nbd.h |  2 ++
 mount/main.c       | 16 +++++++++++++++-
 3 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/lib/backends/nbd.c b/lib/backends/nbd.c
index 682fc7b..b9535dc 100644
--- a/lib/backends/nbd.c
+++ b/lib/backends/nbd.c
@@ -466,6 +466,46 @@ err_out:
 	close(sv[1]);
 	return err;
 }
+
+int erofs_nbd_nl_reconfigure(int index, const char *identifier,
+			     bool autoclear)
+{
+	struct nl_sock *socket;
+	struct nl_msg *msg;
+	int err, driver_id;
+	unsigned int cflags;
+
+	socket = erofs_nbd_get_nl_sock(&driver_id);
+	if (IS_ERR(socket))
+		return PTR_ERR(socket);
+
+	msg = nlmsg_alloc();
+	if (!msg) {
+		erofs_err("Couldn't allocate netlink message");
+		err = -ENOMEM;
+		goto err_nls_free;
+	}
+
+	err = -EINVAL;
+	genlmsg_put(msg, NL_AUTO_PORT, NL_AUTO_SEQ, driver_id, 0, 0,
+		    NBD_CMD_RECONFIGURE, 0);
+	NLA_PUT_U32(msg, NBD_ATTR_INDEX, index);
+	if (identifier)
+		NLA_PUT_STRING(msg, NBD_ATTR_BACKEND_IDENTIFIER, identifier);
+
+	cflags = (autoclear ? NBD_CFLAG_DISCONNECT_ON_CLOSE : 0);
+	NLA_PUT_U64(msg, NBD_ATTR_CLIENT_FLAGS, cflags);
+
+	err = nl_send_sync(socket, msg);
+	nl_socket_free(socket);
+	return err;
+
+nla_put_failure:
+	nlmsg_free(msg);
+err_nls_free:
+	nl_socket_free(socket);
+	return err;
+}
 #else
 int erofs_nbd_nl_connect(int *index, int blkbits, u64 blocks,
 			 const char *identifier)
@@ -477,6 +517,12 @@ int erofs_nbd_nl_reconnect(int index, const char *identifier)
 {
 	return -EOPNOTSUPP;
 }
+
+int erofs_nbd_nl_reconfigure(int index, const char *identifier,
+			     bool autoclear)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 int erofs_nbd_do_it(int nbdfd)
diff --git a/lib/liberofs_nbd.h b/lib/liberofs_nbd.h
index 049c318..260605a 100644
--- a/lib/liberofs_nbd.h
+++ b/lib/liberofs_nbd.h
@@ -47,4 +47,6 @@ int erofs_nbd_disconnect(int nbdfd);
 int erofs_nbd_nl_connect(int *index, int blkbits, u64 blocks,
 			 const char *identifier);
 int erofs_nbd_nl_reconnect(int index, const char *identifier);
+int erofs_nbd_nl_reconfigure(int index, const char *identifier,
+			     bool autoclear);
 #endif
diff --git a/mount/main.c b/mount/main.c
index 139b532..a270f0a 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -544,7 +544,8 @@ static int erofsmount_nbd(const char *source, const char *mountpoint,
 			  const char *fstype, int flags,
 			  const char *options)
 {
-	char nbdpath[32];
+	bool is_netlink = false;
+	char nbdpath[32], *id;
 	int num, nbdfd;
 	pid_t pid = 0;
 	long err;
@@ -575,6 +576,7 @@ static int erofsmount_nbd(const char *source, const char *mountpoint,
 	} else {
 		num = err;
 		(void)snprintf(nbdpath, sizeof(nbdpath), "/dev/nbd%d", num);
+		is_netlink = true;
 	}
 
 	while (1) {
@@ -591,6 +593,18 @@ static int erofsmount_nbd(const char *source, const char *mountpoint,
 		err = mount(nbdpath, mountpoint, fstype, flags, options);
 		if (err < 0)
 			err = -errno;
+
+		if (!err && is_netlink) {
+			id = erofs_nbd_get_identifier(num);
+			if (id == ERR_PTR(-ENOENT))
+				id = NULL;
+
+			err = IS_ERR(id) ? PTR_ERR(id) :
+				erofs_nbd_nl_reconfigure(num, id, true);
+			if (err)
+				erofs_warn("failed to turn on autoclear for nbd%d: %s",
+					   num, erofs_strerror(err));
+		}
 	}
 	return err;
 }
-- 
2.43.5


