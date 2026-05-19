Return-Path: <linux-erofs+bounces-3445-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAgbC6XnC2pXQgUAu9opvQ
	(envelope-from <linux-erofs+bounces-3445-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 19 May 2026 06:31:33 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CE35773B6
	for <lists+linux-erofs@lfdr.de>; Tue, 19 May 2026 06:31:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKMFF2hHqz2yD6;
	Tue, 19 May 2026 14:31:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779165089;
	cv=none; b=kkDZ7HfqHPqHX3RDWd8umcOyB0kKP0avTD2AYNsD3kkr8fsEhY2ZEAExDCLHEQwBbHWbgo7uglyhmn1621tWwQsKvO6k33sghSBp0wpZ0bIxKvZYA2SifGEYEJ6YB/FQaoOiM8FZhBJAVVvSMi4uh9WHsF2fD8NmF0+aLcB8bhb7WxFtyfQckUK9yIxjA2lnszMWf6KkRjj2uB299XtNEEaw4Z3j5B8ut5Kef3Bf3DPd/Tp8/MILNkBXLwoz4tIq+BMyUDghFZaejtwa99ZgT/uXR/0KjaGfo3NreNqn48Tv53ryi6/86f3ekn2KkdbDGl8xxqW2KmmYat4iYyuHnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779165089; c=relaxed/relaxed;
	bh=tP88bDvowpd+Z3RMfaW6ukjjTEHEoVBSUFSvzZ+eaiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DlkVwnpJl7ZAKZiiIMjCmoaK7FuKSvxMSRlYlaRPoJUvOW9HAr+eIsHxnCskpEgKbahzs23K6qITIbiEu1//x6y92vAgkDqDW6Kmng5IKAwhFCQJhhYr9G/JBSWC286XwJi+XQ+WjdBxAfBWhuDGZvxTRT3ukO2UvufsanWzEK5QcbYv7aKygg4OrkjxN+jrw5LvbyYGHOaniJn1117+oAj1Y/Fp1xD8WgyUiTnt26iSK6BhNpxMgO/jsT9qqjIs8NyxXLl+3GfHvsn0hkLIaLdasO6WTUa+/7i9CQj32eBzJc2JaPfB0O1Bqfs+hf+eDT3h1E6EqxCxOP6WYluIjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=x1obN5X/; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=x1obN5X/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKMF91gttz2yCM
	for <linux-erofs@lists.ozlabs.org>; Tue, 19 May 2026 14:31:23 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779165079; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=tP88bDvowpd+Z3RMfaW6ukjjTEHEoVBSUFSvzZ+eaiI=;
	b=x1obN5X/NBjJvjfXAiui/4u85nvwCLLmlUNL8WQZNbfIrBnuPw6aZ1yRKBMhMj5ZpzyrGMlNvUvUOqQMAnI34Ob6Tzh3V8GpMqewO6kb45ac8BIba9wXt9vsvZG4SybnNfbJyNMGonQe5k2Zm21gbRGj4VpgLcwr4Q3EYgQCefE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X3EIuX2_1779165072;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X3EIuX2_1779165072 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 19 May 2026 12:31:16 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Chengyu Zhu <hudsonzhu@tencent.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH rebased 1/3] erofs-utils: mount: extract reusable source-opening and recovery helpers
Date: Tue, 19 May 2026 12:31:09 +0800
Message-ID: <20260519043111.2007421-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260315142745.56845-1-hudson@cyzhu.com>
References: <20260315142745.56845-1-hudson@cyzhu.com>
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
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3445-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,alibaba.com:email,lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Queue-Id: 94CE35773B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chengyu Zhu <hudsonzhu@tencent.com>

Factor out erofsmount_open_source() and erofsmount_recovery_open_source()
helpers; introduce EROFSMOUNT_RUNDIR / EROFSMOUNT_NBD_REC_FMT macros.

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 mount/main.c | 244 +++++++++++++++++++++++----------------------------
 1 file changed, 112 insertions(+), 132 deletions(-)

diff --git a/mount/main.c b/mount/main.c
index 259a37eb3ddf..90fbdc68f88d 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -49,6 +49,9 @@ struct loop_info {
 #define EROFSMOUNT_RUNTIME_DIR	"/run/erofsmount"
 #define EROFSMOUNT_FANOTIFY_STATE_DIR	EROFSMOUNT_RUNTIME_DIR "/fanotify"
 
+#define EROFSMOUNT_RUNDIR		"/var/run/erofs"
+#define EROFSMOUNT_NBD_REC_FMT		EROFSMOUNT_RUNDIR "/mountnbd_nbd%d"
+
 #ifdef EROFS_FANOTIFY_ENABLED
 #define EROFSMOUNT_FANOTIFY_HELP	", fanotify"
 #else
@@ -758,6 +761,43 @@ struct erofsmount_nbd_ctx {
 	struct erofs_vfile *vd;
 };
 
+static int erofsmount_open_source(struct erofsmount_nbd_ctx *ctx,
+				  struct erofsmount_source *source)
+{
+	int err;
+
+	if (source->type == EROFSMOUNT_SOURCE_OCI) {
+		if (source->ocicfg.tarindex_path || source->ocicfg.zinfo_path)
+			return erofsmount_tarindex_open(ctx->vd, &source->ocicfg,
+							source->ocicfg.tarindex_path,
+							source->ocicfg.zinfo_path);
+		return ocierofs_io_open(ctx->vd, &source->ocicfg);
+#ifdef S3EROFS_ENABLED
+	} else if (source->type == EROFSMOUNT_SOURCE_S3_OBJECT) {
+		char *bucket = NULL, *key = NULL;
+		struct erofs_vfile *s3vf;
+
+		err = erofsmount_parse_s3_source(&source->s3cfg, source->device_path,
+						 &bucket, &key);
+		if (err)
+			return err;
+
+		s3vf = s3erofs_io_open(&source->s3cfg, bucket, key);
+		free(bucket);
+		free(key);
+		if (IS_ERR(s3vf))
+			return PTR_ERR(s3vf);
+		ctx->vd = s3vf;
+		return 0;
+#endif
+	}
+	err = open(source->device_path, O_RDONLY);
+	if (err < 0)
+		return err;
+	ctx->_vd.fd = err;
+	return 0;
+}
+
 static void *erofsmount_nbd_loopfn(void *arg)
 {
 	struct erofsmount_nbd_ctx *ctx = arg;
@@ -811,45 +851,9 @@ static int erofsmount_startnbd(int nbdfd, struct erofsmount_source *source)
 	pthread_t th;
 	int err, err2;
 
-	if (source->type == EROFSMOUNT_SOURCE_OCI) {
-		if (source->ocicfg.tarindex_path || source->ocicfg.zinfo_path) {
-			err = erofsmount_tarindex_open(ctx.vd, &source->ocicfg,
-						       source->ocicfg.tarindex_path,
-						       source->ocicfg.zinfo_path);
-			if (err)
-				goto out_closefd;
-		} else {
-			err = ocierofs_io_open(ctx.vd, &source->ocicfg);
-			if (err)
-				goto out_closefd;
-		}
-#ifdef S3EROFS_ENABLED
-	} else if (source->type == EROFSMOUNT_SOURCE_S3_OBJECT) {
-		char *bucket = NULL, *key = NULL;
-		struct erofs_vfile *s3vf;
-
-		err = erofsmount_parse_s3_source(&source->s3cfg, source->device_path,
-						 &bucket, &key);
-		if (err)
-			goto out_closefd;
-
-		s3vf = s3erofs_io_open(&source->s3cfg, bucket, key);
-		free(bucket);
-		free(key);
-		if (IS_ERR(s3vf)) {
-			err = PTR_ERR(s3vf);
-			goto out_closefd;
-		}
-		ctx.vd = s3vf;
-#endif
-	} else {
-		err = open(source->device_path, O_RDONLY);
-		if (err < 0) {
-			err = -errno;
-			goto out_closefd;
-		}
-		ctx._vd.fd = err;
-	}
+	err = erofsmount_open_source(&ctx, source);
+	if (err)
+		goto out_closefd;
 
 	err = erofs_nbd_connect(nbdfd, 9, EROFSMOUNT_NBD_DISK_SIZE);
 	if (err < 0) {
@@ -987,13 +991,13 @@ static int erofsmount_write_recovery_s3(FILE *f, struct erofsmount_source *sourc
 
 static char *erofsmount_write_recovery_info(struct erofsmount_source *source)
 {
-	char recp[] = "/var/run/erofs/mountnbd_XXXXXX";
+	char recp[] = EROFSMOUNT_RUNDIR "/mountnbd_XXXXXX";
 	int fd, err;
 	FILE *f;
 
 	fd = mkstemp(recp);
 	if (fd < 0 && errno == ENOENT) {
-		err = mkdir("/var/run/erofs", 0700);
+		err = mkdir(EROFSMOUNT_RUNDIR, 0700);
 		if (err)
 			return ERR_PTR(-errno);
 		fd = mkstemp(recp);
@@ -1261,6 +1265,55 @@ static int erofsmount_reattach_gzran_oci(struct erofsmount_nbd_ctx *ctx,
 	return err;
 }
 
+static int erofsmount_recovery_open_source(struct erofsmount_nbd_ctx *ctx,
+					   FILE *f)
+{
+	char *line = NULL, *source;
+	size_t n = 0;
+	int err;
+
+	err = getline(&line, &n, f);
+	if (err <= 0) {
+		err = -errno;
+		fclose(f);
+		goto out;
+	}
+	fclose(f);
+	if (err && line[err - 1] == '\n')
+		line[err - 1] = '\0';
+
+	source = strchr(line, ' ');
+	if (!source) {
+		erofs_err("invalid source in recovery file: %s", line);
+		err = -EINVAL;
+		goto out;
+	}
+	*(source++) = '\0';
+
+	if (!strcmp(line, "LOCAL")) {
+		err = open(source, O_RDONLY);
+		if (err < 0) {
+			err = -errno;
+			goto out;
+		}
+		ctx->vd->fd = err;
+		err = 0;
+	} else if (!strcmp(line, "TARINDEX_OCI_BLOB")) {
+		err = erofsmount_reattach_gzran_oci(ctx, source);
+	} else if (!strcmp(line, "OCI_LAYER") || !strcmp(line, "OCI_NATIVE_BLOB")) {
+		err = erofsmount_reattach_oci(ctx->vd, line, source);
+	} else if (!strcmp(line, "S3_OBJECT")) {
+		err = erofsmount_reattach_s3(ctx, source);
+	} else {
+		erofs_err("unsupported source type %s in recovery file",
+			  line);
+		err = -EOPNOTSUPP;
+	}
+out:
+	free(line);
+	return err;
+}
+
 static int erofsmount_nbd_fix_backend_linkage(int num, char **recp)
 {
 	char *newrecp;
@@ -1275,7 +1328,7 @@ static int erofsmount_nbd_fix_backend_linkage(int num, char **recp)
 		return err;
 	}
 
-	if (asprintf(&newrecp, "/var/run/erofs/mountnbd_nbd%d", num) <= 0)
+	if (asprintf(&newrecp, EROFSMOUNT_NBD_REC_FMT, num) <= 0)
 		return -ENOMEM;
 
 	if (rename(*recp, newrecp) < 0) {
@@ -1304,41 +1357,9 @@ static int erofsmount_startnbd_nl(pid_t *pid, struct erofsmount_source *source)
 		if (signal(SIGPIPE, SIG_IGN) == SIG_ERR)
 			exit(EXIT_FAILURE);
 
-		if (source->type == EROFSMOUNT_SOURCE_OCI) {
-			if (source->ocicfg.tarindex_path || source->ocicfg.zinfo_path) {
-				err = erofsmount_tarindex_open(ctx.vd, &source->ocicfg,
-							       source->ocicfg.tarindex_path,
-							       source->ocicfg.zinfo_path);
-				if (err)
-					exit(EXIT_FAILURE);
-			} else {
-				err = ocierofs_io_open(ctx.vd, &source->ocicfg);
-				if (err)
-					exit(EXIT_FAILURE);
-			}
-#ifdef S3EROFS_ENABLED
-		} else if (source->type == EROFSMOUNT_SOURCE_S3_OBJECT) {
-			char *bucket = NULL, *key = NULL;
-			struct erofs_vfile *s3vf;
-
-			err = erofsmount_parse_s3_source(&source->s3cfg, source->device_path,
-							 &bucket, &key);
-			if (err)
-				exit(EXIT_FAILURE);
-
-			s3vf = s3erofs_io_open(&source->s3cfg, bucket, key);
-			free(bucket);
-			free(key);
-			if (IS_ERR(s3vf))
-				exit(EXIT_FAILURE);
-			ctx.vd = s3vf;
-#endif
-		} else {
-			err = open(source->device_path, O_RDONLY);
-			if (err < 0)
-				exit(EXIT_FAILURE);
-			ctx._vd.fd = err;
-		}
+		err = erofsmount_open_source(&ctx, source);
+		if (err)
+			exit(EXIT_FAILURE);
 		recp = erofsmount_write_recovery_info(source);
 		if (IS_ERR(recp)) {
 			erofs_io_close(ctx.vd);
@@ -1380,11 +1401,10 @@ out_fork:
 
 static int erofsmount_reattach(const char *target)
 {
-	char *identifier, *line, *source, *recp = NULL;
 	struct erofsmount_nbd_ctx ctx = { .vd = &ctx._vd };
+	char *identifier;
 	int nbdnum, err;
 	struct stat st;
-	size_t n;
 	FILE *f;
 
 	err = lstat(target, &st);
@@ -1405,69 +1425,31 @@ static int erofsmount_reattach(const char *target)
 		identifier = NULL;
 	}
 
-	if (!identifier &&
-	    (asprintf(&recp, "/var/run/erofs/mountnbd_nbd%d", nbdnum) <= 0)) {
-		err = -ENOMEM;
-		goto err_identifier;
-	}
+	if (!identifier) {
+		char *recp;
 
-	f = fopen(identifier ?: recp, "r");
-	if (!f) {
-		err = -errno;
+		if (asprintf(&recp, EROFSMOUNT_NBD_REC_FMT, nbdnum) <= 0) {
+			err = -ENOMEM;
+			goto err_identifier;
+		}
+		f = fopen(recp, "r");
 		free(recp);
-		goto err_identifier;
+	} else {
+		f = fopen(identifier, "r");
 	}
-	free(recp);
-
-	line = NULL;
-	if ((err = getline(&line, &n, f)) <= 0) {
+	if (!f) {
 		err = -errno;
-		fclose(f);
 		goto err_identifier;
 	}
-	fclose(f);
-	if (err && line[err - 1] == '\n')
-		line[err - 1] = '\0';
-
-	source = strchr(line, ' ');
-	if (!source) {
-		erofs_err("invalid source recorded in recovery file: %s", line);
-		err = -EINVAL;
-		goto err_line;
-	} else {
-		*(source++) = '\0';
-	}
 
-	if (!strcmp(line, "LOCAL")) {
-		err = open(source, O_RDONLY);
-		if (err < 0) {
-			err = -errno;
-			goto err_line;
-		}
-		ctx.vd->fd = err;
-	} else if (!strcmp(line, "TARINDEX_OCI_BLOB")) {
-		err = erofsmount_reattach_gzran_oci(&ctx, source);
-		if (err)
-			goto err_line;
-	} else if (!strcmp(line, "OCI_LAYER") || !strcmp(line, "OCI_NATIVE_BLOB")) {
-		err = erofsmount_reattach_oci(ctx.vd, line, source);
-		if (err)
-			goto err_line;
-	} else if (!strcmp(line, "S3_OBJECT")) {
-		err = erofsmount_reattach_s3(&ctx, source);
-		if (err)
-			goto err_line;
-	} else {
-		err = -EOPNOTSUPP;
-		erofs_err("unsupported source type %s recorded in recovery file", line);
-		goto err_line;
-	}
+	err = erofsmount_recovery_open_source(&ctx, f);
+	if (err)
+		goto err_identifier;
 
 	err = erofs_nbd_nl_reconnect(nbdnum, identifier);
 	if (err >= 0) {
 		ctx.sk.fd = err;
 		if (fork() == 0) {
-			free(line);
 			free(identifier);
 			if ((uintptr_t)erofsmount_nbd_loopfn(&ctx))
 				return EXIT_FAILURE;
@@ -1477,8 +1459,6 @@ static int erofsmount_reattach(const char *target)
 		err = 0;
 	}
 	erofs_io_close(ctx.vd);
-err_line:
-	free(line);
 err_identifier:
 	free(identifier);
 	return err;
-- 
2.43.5


