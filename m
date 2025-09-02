Return-Path: <linux-erofs+bounces-946-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DE18FB4087B
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Sep 2025 17:06:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cGTbM5T9yz3bTR;
	Wed,  3 Sep 2025 01:06:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756825583;
	cv=none; b=gW9LRR2hIhdye0ignVHw/9Q7QI8rZYKjvM8x7so5Q0weUK/j74i9jTHIeHB3JH2Q5VGTDdfRAk9LNDESzv5OgWIp0G6Cm0EIX/0CzbS1RiAS6y/kWbLJR16NvP9RyMM+gjOcFS7+ICPpWMzUJCJGsdURl1Y5ebwaWdalBDJDDjY+f7at19zn/+0wlnRxlqESVtMpu/ghdjWGanp4x+wd3OkfG0ruoN/wmuiE6QwoDPi2ilj+x+hbjbiAQsU3glFYtA71KgwaNT3PIXylwYcsXdBbkVe9AUeDlzf1ZcVeF5s0UoPeBcA2IR0x/KiVwktHbHJjFEMCP+MV4ZtDmZLWbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756825583; c=relaxed/relaxed;
	bh=lUCEEVEq/zQKXOcJp1ldneaYSwpQkA5QmrnWF87XsxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JhPapjzKkzkK1YYctG//ybDgLnu35TDS8SiLN9WRxcGcKEdcehExuF6i0msHwShxTS9LGHBqhQu0KswFeGtQwoKV1lXZpecHRZf+xw/nX7JwoyF94QGB4WTXZ1UO6gNMyE7CMm5+hhSy5WLawzrvWKrw9ubtjX6e0oNoIjUykykv4AjwUNZSh9ZYyLg7DsbxC5dwXEKVmhLVRms+azkst2G3i8ATxUWP4QQouItwmEAaUD8CYluCgvB9uMTLZb4jUuzsm8iPfSaEwYBSXHmZ1joBDzvkbEaYAIiM/aS/tHg8QuTar7i9wvNX0ueMw1r3np+1lPm8mq0dHT+chcbJjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=P7VXL0uK; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=P7VXL0uK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cGTbL27c1z30g6
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Sep 2025 01:06:21 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756825578; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=lUCEEVEq/zQKXOcJp1ldneaYSwpQkA5QmrnWF87XsxI=;
	b=P7VXL0uKcFXmZdAZHBqPJnd+MMnyR3FQtga18n3wfjDWR4OyXNwR5TfvJt4hhNTAXt78IlUp0/apW2MKrjLljjFv8QG7wmhRAYkeasZA0Oz0j7JL0qRa/4QH5JiwfiW+iYfY2ko6sT61r/ibuSAqkEDR9KLqU5LuuT6uFusMzJQ=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wn88Zia_1756825576 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Sep 2025 23:06:16 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 3/4] erofs-utils: mount: record recovery files for NBD failover
Date: Tue,  2 Sep 2025 23:06:09 +0800
Message-ID: <20250902150610.887543-3-hsiangkao@linux.alibaba.com>
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

In order to re-attach, it's necessary to know the exact image
source for local images.

For later remote images, more information is expected to be recorded.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 mount/main.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 79 insertions(+), 7 deletions(-)

diff --git a/mount/main.c b/mount/main.c
index 0df885b..a534dd3 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -5,6 +5,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <signal.h>
 #include <sys/mount.h>
 #include <sys/types.h>
 #include <pthread.h>
@@ -299,6 +300,61 @@ out_closefd:
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
+	err = fprintf(f, "LOCAL %s\n", source) < 0;
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
@@ -317,26 +373,42 @@ static int erofsmount_startnbd_nl(pid_t *pid, const char *source)
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
2.43.5


