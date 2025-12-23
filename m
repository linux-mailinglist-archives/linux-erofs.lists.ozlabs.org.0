Return-Path: <linux-erofs+bounces-1566-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F77CD8BD6
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Dec 2025 11:12:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4db9mb0Qjlz2xlP;
	Tue, 23 Dec 2025 21:12:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766484751;
	cv=none; b=h39cowyPDqCwX9YeuHqq27mnloTIXrBK1zUII1ddjSZeOrueVYCH7COEWjeywrU7S1tFEXw7ctCZBpE4XUwb54lDyraY1KubBRyKO0U3jQj3D/2NdtESM3BgSvOcP6x33752pGsPN9+a7KhVSybgEpTYFpWRGZuA1ONWGtZGFVx2/On/yx5ROEYblvauG8GRrLip68GozOIJkhY9iSz0CjIhtWYPhCnbThTKqrRoJ3yL0bkoqoOb3m5x9ZcMHwFMoJRdFImC3t7iXzkA1PjCip8HNY2W7BXTTf2oT+hLRM4AYoJKYUUjE+OefyL64NznosXuQM95EiDuTL4m4FLI7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766484751; c=relaxed/relaxed;
	bh=NZuejPMp7Gc4hYpu3CDs65UUAST0Ext0RchlNXea0+E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L3eRU7TGFuEXfVPTYfQjJBrbMwMXYDEWetjeIDZb0YWrP2sp0FohmftRcBs3VwWXB9vZ7bQh36m6UTevKjXzI/UlAmpdiGmw0mJ/JsFf7wPLPiQUoSAxL5U6ih+v2XmYl2+LsXtpnS8XKXOm63mSaGlin/Zpw79T/vEMrVeQNmKIIHgTE+cwvcsyEl4ovFU/XfujagGh7t78IJkt9ckD6Hfymy6K4c93tjoUbilY9OYlH3q75WfIsF2iGdlTGAjq7K3V7rwD12jKtf/3SE7AcbmKDGzp5aAiRih+0pw3Xv2Na/VrNyFQkUMmUYYBOx42EcY6uWM91lomu66Fx43Gwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=vVxIc9S9; dkim-atps=neutral; spf=pass (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=vVxIc9S9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4db9mX5wRNz2xQK
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Dec 2025 21:12:27 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=NZuejPMp7Gc4hYpu3CDs65UUAST0Ext0RchlNXea0+E=;
	b=vVxIc9S9QLUjRI3aX5ojw3sxLOoOVo3X9Ktjg+veWUCVP7a8GclsgqCejbdW16Eg75e9+cw7i
	S3R49L0i4cd6uCJRtyFasIYh1bCZ8dog7vcvShCwD2LF85RDWh6mnFDGqTAjshKuXVIBwDYHYXV
	w8/vdKBalk10tYjjxeFou9o=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4db9hq2c4wzKm5C
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Dec 2025 18:09:15 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 605604056C
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Dec 2025 18:12:22 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 23 Dec
 2025 18:12:21 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <jingrui@huawei.com>, <wayne.ma@huawei.com>, <zhaoyifan28@huawei.com>
Subject: [PATCH v2 2/5] erofs-utils: mount: Refactor NBD connection logic in erofsmount_nbd()
Date: Tue, 23 Dec 2025 18:11:23 +0800
Message-ID: <20251223101123.230306-1-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251223100452.229684-1-zhaoyifan28@huawei.com>
References: <20251223100452.229684-1-zhaoyifan28@huawei.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.50.159.234]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

The current NBD connection logic has the following issues:

1.It first tries netlink (forking a child), then falls back to ioctl
(forking another), causing redundant process overhead and double-opening
of erofs_nbd_source on fallback.
2.Child processes fail silently, hiding the error cause from the parent
and confusing users.
3.erofsmount_startnbd() doesn't ignore SIGPIPE, causing nbd_loopfn to be
killed abruptly without clean up during disconnect.
4.During disconnect, -EPIPE from NBD socket I/O is expected, but
erofsmount_nbd_loopfn() does not suppress it, leading to uncessary
"NBD worker failed with EPIPE" message printed in erofsmount_startnbd().

This patch consolidates the netlink and ioctl fallback logic into a
single child process, eliminating redundant erofs_nbd_source opens. It
also ensure SIGPIPE and -EPIPE are properly suppressed during disconnect
in erofsmount_nbd_loopfn(), enabling cleanup and graceful exit.
Additionally, the child process now reports error code via exit() for
better user visibility.

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
diff against v1:
- fix incorrectly configured commit author name and email

Also, I believe corresponding tests are needed to safeguard this code change
and I am working on them.

 lib/backends/nbd.c |   1 +
 mount/main.c       | 346 +++++++++++++++++++++++++--------------------
 2 files changed, 194 insertions(+), 153 deletions(-)

diff --git a/lib/backends/nbd.c b/lib/backends/nbd.c
index da27334..46e75cd 100644
--- a/lib/backends/nbd.c
+++ b/lib/backends/nbd.c
@@ -108,6 +108,7 @@ int erofs_nbd_devscan(void)
 		errno = 0;
 		dp = readdir(_dir);
 		if (!dp) {
+			erofs_err("no available nbd device found in /sys/block");
 			if (errno)
 				err = -errno;
 			else
diff --git a/mount/main.c b/mount/main.c
index 02a7962..2a21979 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -610,6 +610,32 @@ struct erofsmount_nbd_ctx {
 	struct erofs_vfile sk;		/* socket file */
 };
 
+static int erofsmount_open_nbd_source(struct erofs_vfile *vd,
+				      struct erofs_nbd_source *source)
+{
+	int err;
+
+	if (source->type == EROFSNBD_SOURCE_OCI) {
+		if (source->ocicfg.tarindex_path || source->ocicfg.zinfo_path) {
+			err = erofsmount_tarindex_open(vd, &source->ocicfg,
+						       source->ocicfg.tarindex_path,
+						       source->ocicfg.zinfo_path);
+			if (err)
+				return err;
+		} else {
+			err = ocierofs_io_open(vd, &source->ocicfg);
+			if (err)
+				return err;
+		}
+	} else {
+		err = open(source->device_path, O_RDONLY);
+		if (err < 0)
+			return -errno;
+		vd->fd = err;
+	}
+	return 0;
+}
+
 static void *erofsmount_nbd_loopfn(void *arg)
 {
 	struct erofsmount_nbd_ctx *ctx = arg;
@@ -621,11 +647,8 @@ static void *erofsmount_nbd_loopfn(void *arg)
 		off_t pos;
 
 		err = erofs_nbd_get_request(ctx->sk.fd, &rq);
-		if (err < 0) {
-			if (err == -EPIPE)
-				err = 0;
+		if (err < 0)
 			break;
-		}
 
 		if (rq.type != EROFS_NBD_CMD_READ) {
 			err = erofs_nbd_send_reply_header(ctx->sk.fd,
@@ -653,64 +676,11 @@ static void *erofsmount_nbd_loopfn(void *arg)
 out:
 	erofs_io_close(&ctx->vd);
 	erofs_io_close(&ctx->sk);
+	if (err == -EPIPE)
+		err = 0;
 	return (void *)(uintptr_t)err;
 }
 
-static int erofsmount_startnbd(int nbdfd, struct erofs_nbd_source *source)
-{
-	struct erofsmount_nbd_ctx ctx = {};
-	uintptr_t retcode;
-	pthread_t th;
-	int err, err2;
-
-	if (source->type == EROFSNBD_SOURCE_OCI) {
-		if (source->ocicfg.tarindex_path || source->ocicfg.zinfo_path) {
-			err = erofsmount_tarindex_open(&ctx.vd, &source->ocicfg,
-						       source->ocicfg.tarindex_path,
-						       source->ocicfg.zinfo_path);
-			if (err)
-				goto out_closefd;
-		} else {
-			err = ocierofs_io_open(&ctx.vd, &source->ocicfg);
-			if (err)
-				goto out_closefd;
-		}
-	} else {
-		err = open(source->device_path, O_RDONLY);
-		if (err < 0) {
-			err = -errno;
-			goto out_closefd;
-		}
-		ctx.vd.fd = err;
-	}
-
-	err = erofs_nbd_connect(nbdfd, 9, EROFSMOUNT_NBD_DISK_SIZE);
-	if (err < 0) {
-		erofs_io_close(&ctx.vd);
-		goto out_closefd;
-	}
-	ctx.sk.fd = err;
-
-	err = -pthread_create(&th, NULL, erofsmount_nbd_loopfn, &ctx);
-	if (err) {
-		erofs_io_close(&ctx.vd);
-		erofs_io_close(&ctx.sk);
-		goto out_closefd;
-	}
-
-	err = erofs_nbd_do_it(nbdfd);
-	err2 = -pthread_join(th, (void **)&retcode);
-	if (!err2 && retcode) {
-		erofs_err("NBD worker failed with %s",
-		          erofs_strerror(retcode));
-		err2 = retcode;
-	}
-	return err ?: err2;
-out_closefd:
-	close(nbdfd);
-	return err;
-}
-
 #ifdef OCIEROFS_ENABLED
 static int erofsmount_write_recovery_oci(FILE *f, struct erofs_nbd_source *source)
 {
@@ -1013,77 +983,136 @@ static int erofsmount_nbd_fix_backend_linkage(int num, char **recp)
 	return 0;
 }
 
-static int erofsmount_startnbd_nl(pid_t *pid, struct erofs_nbd_source *source)
+struct erofsmount_nbd_msg {
+	int nbdnum;
+	bool is_netlink;
+};
+
+static void erofsmount_startnbd_ioctl(struct erofsmount_nbd_ctx *ctx, struct erofsmount_nbd_msg *msg, int pipefd)
 {
-	int pipefd[2], err, num;
+	uintptr_t retcode;
+	pthread_t th;
+	char nbddev[32];
+	int err = 0, err2 = 0, nbdfd;
 
-	err = pipe(pipefd);
-	if (err < 0)
-		return -errno;
+	msg->nbdnum = erofs_nbd_devscan();
+	if (msg->nbdnum < 0) {
+		close(pipefd);
+		err = msg->nbdnum;
+		goto err_exit;
+	}
 
-	if ((*pid = fork()) == 0) {
-		struct erofsmount_nbd_ctx ctx = {};
-		char *recp;
-
-		/* Otherwise, NBD disconnect sends SIGPIPE, skipping cleanup */
-		if (signal(SIGPIPE, SIG_IGN) == SIG_ERR)
-			exit(EXIT_FAILURE);
-
-		if (source->type == EROFSNBD_SOURCE_OCI) {
-			if (source->ocicfg.tarindex_path || source->ocicfg.zinfo_path) {
-				err = erofsmount_tarindex_open(&ctx.vd, &source->ocicfg,
-							       source->ocicfg.tarindex_path,
-							       source->ocicfg.zinfo_path);
-				if (err)
-					exit(EXIT_FAILURE);
-			} else {
-				err = ocierofs_io_open(&ctx.vd, &source->ocicfg);
-				if (err)
-					exit(EXIT_FAILURE);
-			}
-		} else {
-			err = open(source->device_path, O_RDONLY);
-			if (err < 0)
-				exit(EXIT_FAILURE);
-			ctx.vd.fd = err;
-		}
+	(void)snprintf(nbddev, sizeof(nbddev), "/dev/nbd%d", msg->nbdnum);
+	nbdfd = open(nbddev, O_RDWR);
+	if (nbdfd < 0) {
+		close(pipefd);
+		err = -errno;
+		goto err_exit;
+	}
+
+	err = erofs_nbd_connect(nbdfd, 9, EROFSMOUNT_NBD_DISK_SIZE);
+	if (err < 0) {
+		close(pipefd);
+		goto err_nbdfd;
+	}
+	ctx->sk.fd = err;
+
+	/* Send device number to parent */
+	err = write(pipefd, msg, sizeof(*msg));
+	close(pipefd);
+	if (err != sizeof(*msg)) {
+		err = err < 0 ? -errno : -EIO;
+		goto err_nbdfd;
+	}
+
+	err = -pthread_create(&th, NULL, erofsmount_nbd_loopfn, ctx);
+	if (err) {
+		erofs_io_close(&ctx->sk);
+		goto err_nbdfd;
+	}
+
+	err = erofs_nbd_do_it(nbdfd);
+	err2 = -pthread_join(th, (void **)&retcode);
+	if (!err2 && retcode) {
+		erofs_err("NBD worker failed with %s",
+			  erofs_strerror(retcode));
+		err2 = retcode;
+	}
+	close(nbdfd);
+	exit(-(err ?: err2));
+
+err_nbdfd:
+	close(nbdfd);
+err_exit:
+	erofs_io_close(&ctx->vd);
+	exit(-err);
+}
+
+/* Try to start NBD server with netlink first; fall back to ioctl if failed */
+static void erofsmount_startnbd(struct erofs_nbd_source *source, int pipefd)
+{
+	struct erofsmount_nbd_ctx ctx = {};
+	int err;
+	char *recp;
+	struct erofsmount_nbd_msg msg = { .is_netlink = false };
+
+	/* Otherwise, NBD disconnect sends SIGPIPE, skipping cleanup */
+	if (signal(SIGPIPE, SIG_IGN) == SIG_ERR) {
+		close(pipefd);
+		exit(errno);
+	}
+
+	err = erofsmount_open_nbd_source(&ctx.vd, source);
+	if (err) {
+		close(pipefd);
+		exit(-err);
+	}
+
+	{
+		/* Try netlink-based NBD first */
 		recp = erofsmount_write_recovery_info(source);
-		if (IS_ERR(recp)) {
-			erofs_io_close(&ctx.vd);
-			exit(EXIT_FAILURE);
+		if (IS_ERR(recp))
+			goto fallback_ioctl;
+
+		msg.nbdnum = -1;
+		err = erofs_nbd_nl_connect(&msg.nbdnum, 9, EROFSMOUNT_NBD_DISK_SIZE, recp);
+		if (err < 0)
+			goto err_recp;
+
+		ctx.sk.fd = err;
+		err = erofsmount_nbd_fix_backend_linkage(msg.nbdnum, &recp);
+		if (err) {
+			erofs_io_close(&ctx.sk);
+			goto err_recp;
 		}
 
-		num = -1;
-		err = erofs_nbd_nl_connect(&num, 9, EROFSMOUNT_NBD_DISK_SIZE, recp);
-		if (err >= 0) {
-			ctx.sk.fd = err;
-			err = erofsmount_nbd_fix_backend_linkage(num, &recp);
-			if (err) {
-				erofs_io_close(&ctx.sk);
-			} else {
-				err = write(pipefd[1], &num, sizeof(int));
-				if (err < 0)
-					err = -errno;
-				close(pipefd[1]);
-				close(pipefd[0]);
-				if (err >= sizeof(int)) {
-					err = (int)(uintptr_t)erofsmount_nbd_loopfn(&ctx);
-					goto out_fork;
-				}
-			}
+		/* Succeed in starting netlink-based NBD */
+		msg.is_netlink = true;
+
+		/* Send device number to parent */
+		err = write(pipefd, &msg, sizeof(msg));
+		close(pipefd);
+		if (err != sizeof(msg)) {
+			/* will not fall back if encounter pipe write error */
+			err = err < 0 ? -errno : -EIO;
+			erofs_io_close(&ctx.sk);
+			goto err_recp;
 		}
-		erofs_io_close(&ctx.vd);
-out_fork:
-		(void)unlink(recp);
-		free(recp);
-		exit(err ? EXIT_FAILURE : EXIT_SUCCESS);
+
+		err = (int)(uintptr_t)erofsmount_nbd_loopfn(&ctx);
 	}
-	close(pipefd[1]);
-	err = read(pipefd[0], &num, sizeof(int));
-	close(pipefd[0]);
-	if (err < sizeof(int))
-		return -EPIPE;
-	return num;
+
+err_recp:
+	(void)unlink(recp);
+	free(recp);
+
+fallback_ioctl:
+	if (!msg.is_netlink) {
+		erofs_info("Fall back to ioctl-based NBD; failover is unsupported");
+		erofsmount_startnbd_ioctl(&ctx, &msg, pipefd);
+		/* never returns */
+	}
+	exit(-err);
 }
 
 static int erofsmount_reattach(const char *target)
@@ -1192,10 +1221,11 @@ static int erofsmount_nbd(struct erofs_nbd_source *source,
 			  const char *mountpoint, const char *fstype,
 			  int flags, const char *options)
 {
-	bool is_netlink = false;
 	char nbdpath[32], *id;
-	int num, nbdfd;
-	pid_t pid = 0;
+	struct erofsmount_nbd_msg msg;
+	int pipefd[2];
+	pid_t child;
+	int child_status;
 	long err;
 
 	if (strcmp(fstype, "erofs")) {
@@ -1205,59 +1235,69 @@ static int erofsmount_nbd(struct erofs_nbd_source *source,
 	}
 	flags |= MS_RDONLY;
 
-	err = erofsmount_startnbd_nl(&pid, source);
-	if (err < 0) {
-		erofs_info("Fall back to ioctl-based NBD; failover is unsupported");
-		num = erofs_nbd_devscan();
-		if (num < 0)
-			return num;
+	err = pipe(pipefd);
+	if (err < 0)
+		return -errno;
 
-		(void)snprintf(nbdpath, sizeof(nbdpath), "/dev/nbd%d", num);
-		nbdfd = open(nbdpath, O_RDWR);
-		if (nbdfd < 0)
-			return -errno;
+	if ((child = fork()) == 0) {
+		close(pipefd[0]);
+		erofsmount_startnbd(source, pipefd[1]);
+		/* Never returns */
+	}
 
-		if ((pid = fork()) == 0)
-			return erofsmount_startnbd(nbdfd, source) ?
-				EXIT_FAILURE : EXIT_SUCCESS;
-		close(nbdfd);
-	} else {
-		num = err;
-		(void)snprintf(nbdpath, sizeof(nbdpath), "/dev/nbd%d", num);
-		is_netlink = true;
+	close(pipefd[1]);
+	err = read(pipefd[0], &msg, sizeof(msg));
+	close(pipefd[0]);
+
+	if (err != sizeof(msg)) {
+		int retries = 5;
+
+		while (retries-- > 0) {
+			if (waitpid(child, &child_status, WNOHANG) > 0) {
+				/* child exited, return its exit status */
+				return WIFEXITED(child_status) ? -WEXITSTATUS(child_status) : -EIO;
+			}
+			usleep(10000);  /* Wait 10ms */
+		}
+
+		/* child still running, kill it before returning */
+		kill(child, SIGTERM);
+		waitpid(child, &child_status, 0);
+		return err < 0 ? -errno : -EIO;
 	}
 
+	(void)snprintf(nbdpath, sizeof(nbdpath), "/dev/nbd%d", msg.nbdnum);
+
 	while (1) {
-		err = erofs_nbd_in_service(num);
+		err = erofs_nbd_in_service(msg.nbdnum);
 		if (err == -ENOENT || err == -ENOTCONN) {
-			int status;
-
-			err = waitpid(pid, &status, WNOHANG);
+			err = waitpid(child, &child_status, WNOHANG);
 			if (err < 0)
 				return -errno;
 			else if (err > 0)
-				return status ? -EIO : 0;
+				return WIFEXITED(child_status) ? -WEXITSTATUS(child_status) : -EIO;
 
 			usleep(50000);
 			continue;
 		}
 		if (err >= 0)
-			err = (err != pid ? -EBUSY : 0);
+			err = (err != child ? -EBUSY : 0);
 		break;
 	}
+
 	if (!err) {
 		err = mount(nbdpath, mountpoint, fstype, flags, options);
 		if (err < 0)
 			err = -errno;
 
-		if (!err && is_netlink) {
-			id = erofs_nbd_get_identifier(num);
+		if (!err && msg.is_netlink) {
+			id = erofs_nbd_get_identifier(msg.nbdnum);
 
 			err = IS_ERR(id) ? PTR_ERR(id) :
-				erofs_nbd_nl_reconfigure(num, id, true);
+				erofs_nbd_nl_reconfigure(msg.nbdnum, id, true);
 			if (err)
 				erofs_warn("failed to turn on autoclear for nbd%d: %s",
-					   num, erofs_strerror(err));
+					   msg.nbdnum, erofs_strerror(err));
 			if (!IS_ERR(id))
 				free(id);
 		}
-- 
2.43.0


