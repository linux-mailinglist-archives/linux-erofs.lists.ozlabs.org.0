Return-Path: <linux-erofs+bounces-954-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81166B4124F
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Sep 2025 04:29:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cGmlp0t8yz2xnw;
	Wed,  3 Sep 2025 12:29:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756866582;
	cv=none; b=H/n6WkXRfwuxXXtYnPughausnliqW/ao5W/XD/JG+FBCN+yZZ87lfhARjeejXCrXRJrqR/OYdhl/QQXvFhjihySVgyOHRFekNDzWg6d32bTeshBl/HuBDYS8Ka49tpovOaRRDsdFh/ba7ZpNVyxv0j3lFZuj6a1Oc+r+BAkJ4nj81dSmSRv4H91Eb6vQRUztCcD4umhh+YWICXUY4ZZEm/JbPKY2ejTt/+jxhzC5lvqjWH4Rwgn/xXTydUMb8gwx75QuJDFEPukGpSgdySnXBPmxx6JdgF0WmcY5vg4esd5dvDnygE+HHSdDLL9NrR9/HF7kWJR7bAR8ofpCD1/hvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756866582; c=relaxed/relaxed;
	bh=SuKTwFolHZWfypbqc6fjsRpgBWqvCrrszw6yeJpDLRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVhV+9CpV4qgZfoQ6i/uOC73KoXkHeK8URBzg9WnzL/VgJkYl3pxhFmtE6kraRRO9a8O9hMxdvY4IBbzAqysjWbYQnqxp2p+w/IOHRT1DNn9m8bZZYrErGhlX5+gpJGWLQ+IeWnT3qctYlKARHJ+ZSHjgS5S7kUtSk+q2q8TEN1poQ/B/YNO9mS67NNoBovk7H/0bsfAF2t9k8xCalTqKFXGvfI8MArfC26h+A0WWYeA1Ri6QoKIdV/liKcTcb9V5aZ44zeIuPYGVOkgJmz+17kAo/uOJIXPERBBHJXCtTjOwoE2WmEQpX0JHROC3HeFa0NpJ+QM9qp3skPUcrJUTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=x9vpyTUN; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=x9vpyTUN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cGmlm2ydqz2xgX
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Sep 2025 12:29:39 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756866576; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=SuKTwFolHZWfypbqc6fjsRpgBWqvCrrszw6yeJpDLRQ=;
	b=x9vpyTUNrbjLeTFMDQHvP88/LgOSxlbW2tO3mqvx/sSLSxaVe2Cq5pP2qoZzKRnt0xerVzzeaV0KNXurSRj2RghIpsoDK0RrWjCsID+q6CZUyt6GXDIZzPkLy7uS6+wJiG9anLCMUc5zHdZOR3k/gyXdQzcs9sVMMN5hvrTL7xc=
Received: from localhost.localdomain(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wn9faMx_1756866575 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Sep 2025 10:29:35 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v3 3/4] erofs-utils: mount: record recovery files for NBD failover
Date: Wed,  3 Sep 2025 10:29:12 +0800
Message-ID: <20250903022912.66610-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250903021858.66418-3-hsiangkao@linux.alibaba.com>
References: <20250903021858.66418-3-hsiangkao@linux.alibaba.com>
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

In order to re-attach, it's necessary to know the exact image
source for local images.

For later remote images, more information is expected to be recorded.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v3:
 - should record realpath() in recovery files.

 mount/main.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 88 insertions(+), 7 deletions(-)

diff --git a/mount/main.c b/mount/main.c
index d82e526..9123618 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -300,6 +300,71 @@ out_closefd:
 	return err;
 }
 
+static char *erofsmount_write_recovery_info(const char *source)
+{
+	char recp[] = "/var/run/erofs/mountnbd_XXXXXX";
+	char *realp;
+	int fd, err;
+	FILE *f;
+
+	fd = mkstemp(recp);
+	if (fd < 0 && errno == ENOENT) {
+		err = mkdir("/var/run/erofs", 0700);
+		if (err)
+			return ERR_PTR(-errno);
+		fd = mkstemp(recp);
+	}
+	if (fd < 0)
+		return ERR_PTR(-errno);
+
+	f = fdopen(fd, "w+");
+	if (!f) {
+		close(fd);
+		return ERR_PTR(-errno);
+	}
+
+	realp = realpath(source, NULL);
+	if (!realp) {
+		fclose(f);
+		return ERR_PTR(-errno);
+	}
+	/* TYPE<LOCAL> <SOURCE PATH>\n(more..) */
+	err = fprintf(f, "LOCAL %s\n", realp) < 0;
+	fclose(f);
+	free(realp);
+	if (err)
+		return ERR_PTR(-ENOMEM);
+	return strdup(recp) ?: ERR_PTR(-ENOMEM);
+}
+
+static int erofsmount_nbd_fix_backend_linkage(int num, char **recp)
+{
+	char *newrecp;
+	int err;
+
+	newrecp = erofs_nbd_get_identifier(num);
+	if (!IS_ERR(newrecp)) {
+		err = strlen(newrecp);
+		if (newrecp[err - 1] == '\n')
+			newrecp[err - 1] = '\0';
+		err = strcmp(newrecp, *recp) ? -EFAULT : 0;
+		free(newrecp);
+		return err;
+	}
+
+	if (asprintf(&newrecp, "/var/run/erofs/mountnbd_nbd%d", num) <= 0)
+		return -ENOMEM;
+
+	if (rename(*recp, newrecp) < 0) {
+		err = -errno;
+		free(newrecp);
+		return err;
+	}
+	free(*recp);
+	*recp = newrecp;
+	return 0;
+}
+
 static int erofsmount_startnbd_nl(pid_t *pid, const char *source)
 {
 	struct erofsmount_nbd_ctx ctx = {};
@@ -318,26 +383,42 @@ static int erofsmount_startnbd_nl(pid_t *pid, const char *source)
 		return err;
 	}
 	if ((*pid = fork()) == 0) {
+		char *recp;
+
 		/* Otherwise, NBD disconnect sends SIGPIPE, skipping cleanup */
 		if (signal(SIGPIPE, SIG_IGN) == SIG_ERR) {
 			close(ctx.vd.fd);
 			exit(EXIT_FAILURE);
 		}
-
+		recp = erofsmount_write_recovery_info(source);
+		if (IS_ERR(recp)) {
+			close(ctx.vd.fd);
+			exit(EXIT_FAILURE);
+		}
 		num = -1;
-		err = erofs_nbd_nl_connect(&num, 9, INT64_MAX >> 9, NULL);
+		err = erofs_nbd_nl_connect(&num, 9, INT64_MAX >> 9, recp);
 		if (err >= 0) {
 			ctx.sk.fd = err;
-			err = write(pipefd[1], &num, sizeof(int));
-			if (err >= sizeof(int)) {
+			err = erofsmount_nbd_fix_backend_linkage(num, &recp);
+			if (err) {
+				close(ctx.sk.fd);
+			} else {
+				err = write(pipefd[1], &num, sizeof(int));
+				if (err < 0)
+					err = -errno;
 				close(pipefd[1]);
 				close(pipefd[0]);
-				err = (int)(uintptr_t)erofsmount_nbd_loopfn(&ctx);
-				exit(err ? EXIT_FAILURE : EXIT_SUCCESS);
+				if (err >= sizeof(int)) {
+					err = (int)(uintptr_t)erofsmount_nbd_loopfn(&ctx);
+					goto out_fork;
+				}
 			}
 		}
 		close(ctx.vd.fd);
-		exit(EXIT_FAILURE);
+out_fork:
+		(void)unlink(recp);
+		free(recp);
+		exit(err ? EXIT_FAILURE : EXIT_SUCCESS);
 	}
 	close(pipefd[1]);
 	err = read(pipefd[0], &num, sizeof(int));
-- 
2.43.0


