Return-Path: <linux-erofs+bounces-3194-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDodB3xhz2kVvwYAu9opvQ
	(envelope-from <linux-erofs+bounces-3194-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 03 Apr 2026 08:43:08 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F41A391786
	for <lists+linux-erofs@lfdr.de>; Fri, 03 Apr 2026 08:43:07 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fn8LH60Jqz2yhG;
	Fri, 03 Apr 2026 17:43:03 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775198583;
	cv=none; b=GsLtD0UdeaXZC4+HiBSLhoO0uZ5dloLWmAv6QEz0V6KbTtqm67BV+/YZ0N5L0ZVpaULcvwAdkwaCf/FXW1V4Y1sqveepFj5BHcMWPqO4Jsm3RqYvpSLevQX/X+jSoGoVBkeUIS0q2mWPzOf2tBJBf2WzLRxImpYGEEUD1CxMsKyvUPuVrT+pD4AtJS/SriOMNOMk8QFgvEZwOoS69OGtymlkIiipoqa+e9GZVi49CxZRrsK63C3VRegq0V+MqlOP/wQ/DtLMnwC42QDMW5F98TVmqmbLcB40JDeRdKAdOi+eWwJe3i/2cpduDyau5Ss2Roh0WbHvzkXfUEQ6M//+Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775198583; c=relaxed/relaxed;
	bh=cpRtT085UNgu2VSKGXqqNpPRZ4LxU/Lg+ecQxz5qgnQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RWgfLNttzT7+10nirsSwyofgtESrtLdjVxtIAIPCr7nrdKxmm0XTZaAfiuwjwlCMDVkvj4/cozi3veaxAy1gCVaiITc4ZA8QTVjZNhPdt1p4DXpzkWNmlZzzI5/DDANZIirYMk1q6njB9fU2zWQGjdYz2TtfbsFT0F517+vJeZv2Q7TBSsZhKQh7g80jLCWW5WFJYFTIj4CFE4mArRAYPEJnE/gaxbsFh+WzVBauhe7nFzXg2hwtUldRvhgywAZLB2YgbvPwCzlOMlCu3p9kJCIZM+5QC6vCiVM/5YNKcz8REiMR2jszSSmk1IOG7kaop8BtJkVOACTuHmUq7rHmLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=2l3PlLtr; dkim-atps=neutral; spf=pass (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=2l3PlLtr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fn8LD5FNdz2xm3
	for <linux-erofs@lists.ozlabs.org>; Fri, 03 Apr 2026 17:43:00 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=cpRtT085UNgu2VSKGXqqNpPRZ4LxU/Lg+ecQxz5qgnQ=;
	b=2l3PlLtrxCaVR2eI+DXuzjPRlad1/ZMcaGhvCLq5IiSqQpQV8+Zm2w6xafFjaFux81K+Fx3I3
	RM+acEZ8pr+1lKW94DeIgtcq+O6U9wd+Ar3bZBX6XhxpWZYKQ8T7oRqRjakKqT9A6uRpi0t9bDV
	iQmiskFAOXnIjXl00+CEvS8=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fn8Bx43QBzRhRN
	for <linux-erofs@lists.ozlabs.org>; Fri,  3 Apr 2026 14:36:41 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 838CE40538
	for <linux-erofs@lists.ozlabs.org>; Fri,  3 Apr 2026 14:42:52 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 3 Apr
 2026 14:42:52 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <jingrui@huawei.com>, <zhukeqian1@huawei.com>, <zhaoyifan28@huawei.com>
Subject: [PATCH 1/2] erofs-utils: mount: gracefully handle long-lived backend workers
Date: Fri, 3 Apr 2026 14:42:29 +0800
Message-ID: <20260403064230.914563-1-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.47.3
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
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3194-lists,linux-erofs=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	HAS_XOIP(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3F41A391786
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently long-lived backend workers were created with a bare fork() and
kept running with the caller's process context. They still inherited
CLI-oriented session and stdio, making the background worker fragile.

Refine the worker setup used by the NBD and fanotify mount paths so
forked children behave like well-formed long-lived background processes.

Assisted-by: Codex:GPT-5.4
Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 mount/main.c | 208 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 156 insertions(+), 52 deletions(-)

diff --git a/mount/main.c b/mount/main.c
index e09e585..45ac32e 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -98,6 +98,75 @@ static struct erofsmount_source {
 	};
 } mountsrc;
 
+static int erofsmount_spawn_worker(pid_t *pid)
+{
+	*pid = fork();
+	if (*pid < 0)
+		return -errno;
+	return *pid;
+}
+
+static int erofsmount_worker_set_signal(int signum, sighandler_t handler)
+{
+	struct sigaction act = {
+		.sa_handler = handler,
+	};
+
+	if (sigemptyset(&act.sa_mask) < 0)
+		return -errno;
+	if (sigaction(signum, &act, NULL) < 0)
+		return -errno;
+	return 0;
+}
+
+static int erofsmount_worker_detach(void)
+{
+	sigset_t mask;
+	int fd, err;
+
+	if (setsid() < 0)
+		return -errno;
+
+	if (sigemptyset(&mask) < 0)
+		return -errno;
+	if (sigprocmask(SIG_SETMASK, &mask, NULL) < 0)
+		return -errno;
+
+	err = erofsmount_worker_set_signal(SIGHUP, SIG_DFL);
+	if (err)
+		return err;
+	err = erofsmount_worker_set_signal(SIGINT, SIG_DFL);
+	if (err)
+		return err;
+	err = erofsmount_worker_set_signal(SIGQUIT, SIG_DFL);
+	if (err)
+		return err;
+	err = erofsmount_worker_set_signal(SIGTERM, SIG_DFL);
+	if (err)
+		return err;
+	err = erofsmount_worker_set_signal(SIGPIPE, SIG_IGN);
+	if (err)
+		return err;
+
+	fd = open("/dev/null", O_RDWR);
+	if (fd < 0)
+		return -errno;
+	if (dup2(fd, STDIN_FILENO) < 0 || dup2(fd, STDOUT_FILENO) < 0 ||
+	    dup2(fd, STDERR_FILENO) < 0) {
+		err = -errno;
+		close(fd);
+		return err;
+	}
+	if (fd > STDERR_FILENO)
+		close(fd);
+	return 0;
+}
+
+static void erofsmount_worker_exit(int err)
+{
+	_exit(err ? EXIT_FAILURE : EXIT_SUCCESS);
+}
+
 static void usage(int argc, char **argv)
 {
 	printf("Usage: %s [OPTIONS] SOURCE [MOUNTPOINT]\n"
@@ -720,6 +789,13 @@ static int erofsmount_startnbd(int nbdfd, struct erofsmount_source *source)
 	}
 	ctx.sk.fd = err;
 
+	err = erofsmount_worker_detach();
+	if (err) {
+		erofs_io_close(&ctx.vd);
+		erofs_io_close(&ctx.sk);
+		goto out_closefd;
+	}
+
 	err = -pthread_create(&th, NULL, erofsmount_nbd_loopfn, &ctx);
 	if (err) {
 		erofs_io_close(&ctx.vd);
@@ -1050,67 +1126,79 @@ static int erofsmount_nbd_fix_backend_linkage(int num, char **recp)
 static int erofsmount_startnbd_nl(pid_t *pid, struct erofsmount_source *source)
 {
 	int pipefd[2], err, num;
+	pid_t ret;
 
 	err = pipe(pipefd);
 	if (err < 0)
 		return -errno;
 
-	if ((*pid = fork()) == 0) {
+	ret = erofsmount_spawn_worker(pid);
+	if (ret < 0) {
+		close(pipefd[0]);
+		close(pipefd[1]);
+		return ret;
+	}
+	if (ret == 0) {
 		struct erofsmount_nbd_ctx ctx = {};
 		char *recp;
 
-		/* Otherwise, NBD disconnect sends SIGPIPE, skipping cleanup */
-		if (signal(SIGPIPE, SIG_IGN) == SIG_ERR)
-			exit(EXIT_FAILURE);
-
 		if (source->type == EROFSMOUNT_SOURCE_OCI) {
 			if (source->ocicfg.tarindex_path || source->ocicfg.zinfo_path) {
 				err = erofsmount_tarindex_open(&ctx.vd, &source->ocicfg,
 							       source->ocicfg.tarindex_path,
 							       source->ocicfg.zinfo_path);
 				if (err)
-					exit(EXIT_FAILURE);
+					erofsmount_worker_exit(err);
 			} else {
 				err = ocierofs_io_open(&ctx.vd, &source->ocicfg);
 				if (err)
-					exit(EXIT_FAILURE);
+					erofsmount_worker_exit(err);
 			}
 		} else {
 			err = open(source->device_path, O_RDONLY);
 			if (err < 0)
-				exit(EXIT_FAILURE);
+				erofsmount_worker_exit(-errno);
 			ctx.vd.fd = err;
 		}
 		recp = erofsmount_write_recovery_info(source);
 		if (IS_ERR(recp)) {
 			erofs_io_close(&ctx.vd);
-			exit(EXIT_FAILURE);
+			erofsmount_worker_exit(PTR_ERR(recp));
 		}
 
 		num = -1;
 		err = erofs_nbd_nl_connect(&num, 9, EROFSMOUNT_NBD_DISK_SIZE, recp);
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
+		if (err < 0)
+			goto err_vd;
+
+		ctx.sk.fd = err;
+		err = erofsmount_nbd_fix_backend_linkage(num, &recp);
+		if (err)
+			goto err_sk;
+
+		err = erofsmount_worker_detach();
+		if (err)
+			goto err_sk;
+
+		err = write(pipefd[1], &num, sizeof(int));
+		if (err < 0)
+			err = -errno;
+		close(pipefd[1]);
+		close(pipefd[0]);
+		if (err >= (int)sizeof(int)) {
+			err = (int)(uintptr_t)erofsmount_nbd_loopfn(&ctx);
+			goto out_fork;
 		}
+		goto err_sk;
+
+err_sk:
+		erofs_io_close(&ctx.sk);
+err_vd:
 		erofs_io_close(&ctx.vd);
 out_fork:
 		(void)unlink(recp);
 		free(recp);
-		exit(err ? EXIT_FAILURE : EXIT_SUCCESS);
+		erofsmount_worker_exit(err);
 	}
 	close(pipefd[1]);
 	err = read(pipefd[0], &num, sizeof(int));
@@ -1122,11 +1210,12 @@ out_fork:
 
 static int erofsmount_reattach(const char *target)
 {
-	char *identifier, *line, *source, *recp = NULL;
+	char *identifier, *line = NULL, *source, *recp = NULL;
 	struct erofsmount_nbd_ctx ctx = {};
+	pid_t pid;
 	int nbdnum, err;
 	struct stat st;
-	size_t n;
+	size_t n = 0;
 	FILE *f;
 
 	err = lstat(target, &st);
@@ -1154,18 +1243,16 @@ static int erofsmount_reattach(const char *target)
 	}
 
 	f = fopen(identifier ?: recp, "r");
+	free(recp);
+
 	if (!f) {
 		err = -errno;
-		free(recp);
 		goto err_identifier;
 	}
-	free(recp);
-
-	line = NULL;
 	if ((err = getline(&line, &n, f)) <= 0) {
 		err = -errno;
 		fclose(f);
-		goto err_identifier;
+		goto err_line;
 	}
 	fclose(f);
 	if (err && line[err - 1] == '\n')
@@ -1202,18 +1289,27 @@ static int erofsmount_reattach(const char *target)
 	}
 
 	err = erofs_nbd_nl_reconnect(nbdnum, identifier);
-	if (err >= 0) {
-		ctx.sk.fd = err;
-		if (fork() == 0) {
-			free(line);
-			free(identifier);
-			if ((uintptr_t)erofsmount_nbd_loopfn(&ctx))
-				return EXIT_FAILURE;
-			return EXIT_SUCCESS;
-		}
+	if (err < 0)
+		goto err_vd;
+	ctx.sk.fd = err;
+
+	err = erofsmount_spawn_worker(&pid);
+	if (err < 0) {
 		erofs_io_close(&ctx.sk);
-		err = 0;
+		goto err_vd;
+	}
+	if (err == 0) {
+		free(line);
+		free(identifier);
+		err = erofsmount_worker_detach();
+		if (!err)
+			err = (int)(uintptr_t)erofsmount_nbd_loopfn(&ctx);
+		erofsmount_worker_exit(err);
 	}
+	erofs_io_close(&ctx.sk);
+
+	err = 0;
+err_vd:
 	erofs_io_close(&ctx.vd);
 err_line:
 	free(line);
@@ -1251,9 +1347,15 @@ static int erofsmount_nbd(struct erofsmount_source *source,
 		if (nbdfd < 0)
 			return -errno;
 
-		if ((pid = fork()) == 0)
-			return erofsmount_startnbd(nbdfd, source) ?
-				EXIT_FAILURE : EXIT_SUCCESS;
+		err = erofsmount_spawn_worker(&pid);
+		if (err < 0) {
+			close(nbdfd);
+			return err;
+		}
+		if (err == 0) {
+			err = erofsmount_startnbd(nbdfd, source);
+			erofsmount_worker_exit(err);
+		}
 	} else {
 		num = err;
 		(void)snprintf(nbdpath, sizeof(nbdpath), "/dev/nbd%d", num);
@@ -1661,6 +1763,10 @@ static int erofsmount_fanotify_child(struct erofs_fanotify_ctx *ctx,
 	if (err)
 		goto notify;
 
+	err = erofsmount_worker_detach();
+	if (err)
+		goto notify;
+
 	err = 0;
 notify:
 	write(pipefd, &err, sizeof(err));
@@ -1730,19 +1836,17 @@ static int erofsmount_fanotify(struct erofsmount_source *source,
 		goto out;
 	}
 
-	pid = fork();
-	if (pid < 0) {
-		err = -errno;
+	err = erofsmount_spawn_worker(&pid);
+	if (err < 0) {
 		close(pipefd[0]);
 		close(pipefd[1]);
 		goto out;
 	}
-
-	if (pid == 0) {
+	if (err == 0) {
 		close(pipefd[0]);
 		err = erofsmount_fanotify_child(&ctx, pipefd[1]);
 		erofsmount_fanotify_ctx_cleanup(&ctx);
-		exit(err ? EXIT_FAILURE : EXIT_SUCCESS);
+		erofsmount_worker_exit(err);
 	}
 
 	/* Wait for child to report fanotify initialization result */
-- 
2.47.3


