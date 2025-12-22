Return-Path: <linux-erofs+bounces-1529-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9C1CD4E53
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Dec 2025 08:47:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dZVbF4hxdz2yFb;
	Mon, 22 Dec 2025 18:47:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766389625;
	cv=none; b=nhU3cLmhjNSu7G9V8mEJ2unx5p1WM4nNyw1eNIXdTjAJTjfTbqDDiwxw1Xm4XUPGzd1yWFIwB8Ra6x3MGQ16ViNE3XsZ5oPBoakJLr3TGFzcNmlSykTrd7UdnDvMCpNt/rLPUp7PuQiSClqlhloK71hx/f4mOTuNHzIm/gzbWypWM84w9OpuL3uN8yewQ5QxkUFornfwtCkgHREd5OI2PXutxs2+nTU69m6SsJdaHqkZGbOQ1bz47cdoV3kIwPP6T36pQbYP1ssMV791BR9HtxZToNVgVcS41MCIb/hvHoRzu00jm8G1ufSuWgKb3C0wSaRQWpFMuf9kMED1IrD38Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766389625; c=relaxed/relaxed;
	bh=7GmwEiKUPne2Mf44eSRKaeOFRthJdvlepQE93TMAStk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q3OzMOw7zWy+I6vU65bBXEybbaFIOO5HXfvNClXqvfsCrm5hm8LhTkmc2sZvIyon4QwM012mml6K3Mxddsumg63XqM/l3v+UoSmIQEyNDt5rjiZ+zcoN5acKohNtkImRLO/q0fs3oe1rWiJFvplCoip0VXeAc2oDz7UTGxu8V7QtpBG1IesoHRZ6JYmWMSjiPRmRj/5YXdjSykvRFr0kY/06NRfYrZWe/6GbRN5oC+s6BEtcHDB3gS0LBBuc93QtdDScOCfns4UMosrwJId0DQnNVuP3N25XUMKkWugc3gRh3CQQBsnRsbGuMRu2opbx2vyEmIpDypObZW71FYsc2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LLnZQVE+; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LLnZQVE+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dZVbC5y5fz2xFn
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Dec 2025 18:47:03 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766389618; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=7GmwEiKUPne2Mf44eSRKaeOFRthJdvlepQE93TMAStk=;
	b=LLnZQVE+AkLb4XN9Sz1jEs3NpgEPOz19QwU8BkVqYB9qo2GNGxTVlRqoqE10xLMSahnCcozx70JBHYqz6BXKf9acR60MikFjnd0BLybLaW+Ed3WLvEF+rOqYBAdFuCBE+MICg+Vh4DBbSjJ3ke8wxZ0FMkEd1hq+c6wQNGQC1qQ=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvMyaqF_1766389612 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Dec 2025 15:46:56 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/2] erofs-utils: mount: add support for netlink disconnection
Date: Mon, 22 Dec 2025 15:46:51 +0800
Message-ID: <20251222074652.1947729-1-hsiangkao@linux.alibaba.com>
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

One significant benefit of using the netlink interface is that it
avoids opening NBD device files since openers can hang in the kernel
in some cases (it's hard to resolve with traditional ioctl interfaces,
but I don't want to explain more kernel internals here.)

In fact, using the NBD netlink interface is now always recommended.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/backends/nbd.c | 37 +++++++++++++++++++++++++++++++++++++
 lib/liberofs_nbd.h |  1 +
 mount/main.c       | 18 +++++++++++++++---
 3 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/lib/backends/nbd.c b/lib/backends/nbd.c
index 2e54814af6ca..77c4f609d5de 100644
--- a/lib/backends/nbd.c
+++ b/lib/backends/nbd.c
@@ -515,6 +515,39 @@ err_nls_free:
 	nl_socket_free(socket);
 	return err;
 }
+
+int erofs_nbd_nl_disconnect(int index)
+{
+	struct nl_sock *socket;
+	struct nl_msg *msg;
+	int driver_id, err;
+
+	socket= erofs_nbd_get_nl_sock(&driver_id);
+	if (IS_ERR(socket))
+		return PTR_ERR(socket);
+	msg = nlmsg_alloc();
+	if (!msg) {
+		erofs_err("Couldn't allocate netlink message");
+		err = -ENOMEM;
+		goto err_nls_free;
+	}
+
+	err = -EINVAL;
+	genlmsg_put(msg, NL_AUTO_PORT, NL_AUTO_SEQ, driver_id, 0, 0,
+		    NBD_CMD_DISCONNECT, 0);
+	NLA_PUT_U32(msg, NBD_ATTR_INDEX, index);
+	err = nl_send_sync(socket, msg);
+	if (err < 0)
+		erofs_err("Failed to disconnect device %d, check dmesg", err);
+	nl_socket_free(socket);
+	return err;
+nla_put_failure:
+	erofs_err("Failed to create netlink message");
+	nlmsg_free(msg);
+err_nls_free:
+	nl_socket_free(socket);
+	return err;
+}
 #else
 int erofs_nbd_nl_connect(int *index, int blkbits, u64 blocks,
 			 const char *identifier)
@@ -532,6 +565,10 @@ int erofs_nbd_nl_reconfigure(int index, const char *identifier,
 {
 	return -EOPNOTSUPP;
 }
+int erofs_nbd_nl_disconnect(int index)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 int erofs_nbd_do_it(int nbdfd)
diff --git a/lib/liberofs_nbd.h b/lib/liberofs_nbd.h
index 260605ae201a..78c8af511bec 100644
--- a/lib/liberofs_nbd.h
+++ b/lib/liberofs_nbd.h
@@ -49,4 +49,5 @@ int erofs_nbd_nl_connect(int *index, int blkbits, u64 blocks,
 int erofs_nbd_nl_reconnect(int index, const char *identifier);
 int erofs_nbd_nl_reconfigure(int index, const char *identifier,
 			     bool autoclear);
+int erofs_nbd_nl_disconnect(int index);
 #endif
diff --git a/mount/main.c b/mount/main.c
index ed6bcdcfe26d..b3b2e0fc33e0 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -1306,9 +1306,9 @@ out_err:
 int erofsmount_umount(char *target)
 {
 	char *device = NULL, *mountpoint = NULL;
+	int err, fd, nbdnum;
 	struct stat st;
 	FILE *mounts;
-	int err, fd;
 	size_t n;
 	char *s;
 	bool isblk;
@@ -1376,6 +1376,14 @@ int erofsmount_umount(char *target)
 		goto err_out;
 	}
 
+	if (isblk && !mountpoint &&
+	    S_ISBLK(st.st_mode) && major(st.st_rdev) == EROFS_NBD_MAJOR) {
+		nbdnum = erofs_nbd_get_index_from_minor(minor(st.st_rdev));
+		err = erofs_nbd_nl_disconnect(nbdnum);
+		if (err != -EOPNOTSUPP)
+			return err;
+	}
+
 	/* Avoid TOCTOU issue with NBD_CFLAG_DISCONNECT_ON_CLOSE */
 	fd = open(isblk ? target : device, O_RDWR);
 	if (fd < 0) {
@@ -1393,8 +1401,12 @@ int erofsmount_umount(char *target)
 	err = fstat(fd, &st);
 	if (err < 0)
 		err = -errno;
-	else if (S_ISBLK(st.st_mode) && major(st.st_rdev) == EROFS_NBD_MAJOR)
-		err = erofs_nbd_disconnect(fd);
+	else if (S_ISBLK(st.st_mode) && major(st.st_rdev) == EROFS_NBD_MAJOR) {
+		nbdnum = erofs_nbd_get_index_from_minor(minor(st.st_rdev));
+		err = erofs_nbd_nl_disconnect(nbdnum);
+		if (err == -EOPNOTSUPP)
+			err = erofs_nbd_disconnect(fd);
+	}
 	close(fd);
 err_out:
 	free(device);
-- 
2.43.5


