Return-Path: <linux-erofs+bounces-3496-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOEgOJhWHmrfigkAu9opvQ
	(envelope-from <linux-erofs+bounces-3496-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 02 Jun 2026 06:05:44 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 53251627F86
	for <lists+linux-erofs@lfdr.de>; Tue, 02 Jun 2026 06:05:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gTy1022zVz2xdh;
	Tue, 02 Jun 2026 14:05:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780373140;
	cv=none; b=FoD4+fhSXaETU7li4uWsW1EgWcnAaacT/4quLcAhMqj1/6Zj2u8vLXImctuEmu+o6Ne8YmereQAwEYexVrhUPlhxFHoLn9st204xa0tzMVdR0iiQdUE43Q8n3tVPg3DWv3hkas/gfRgjMM8vo1/Z1Ea1RFSo/7qcbzPuNrDE8vll0BKK3OoXf4+npqdJ6f1PRCWTjnjgOs2Rxdtzp0Gyjyk9x09b8uuVXT4GXrkZ3Vb9EOmWQ9nPjQmENetL1Odr8eQbOfyoO6h9aZhJinANorIeN7k5WcP/ZYI3xWj0NvP/LcHMY1Dr7BPesqoXOVJDi/HNIdjti90yPg+b0PC1Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780373140; c=relaxed/relaxed;
	bh=qwf3ZSM+5G2UFiSkjGZ9LMU4F3NKkUp9Mo954AVU76o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RPRTrFbNGBBK/NA2eImS51uhH5yknObJCEQceVD0ypJ4jZQgTfOcrUhE8I1qHKXLTmAtUuquHteWpsx2v3XffHYHGIivSp6rWChNfICjVWbEDEI6QlV6rMrtJrcFNo3ZkVuow5uVdT9tDiAshujOi/NawSpKZ/Nk4frJva1ZuX8IfhPttbCvYOut1aySV0H19DAnUcfCIgW11YUKufQ9ks6vk3TzAKVfeM3ZbK4VPVNK3TspSBj71wyftvUg0er1PXGB1K20gDDmxvitti7C/TC3K2+tnMFx3mCqVwV1r4jSG+v8M4MpYgn22CXNjFV2za+q5lohsT2p7agMy+Ev2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MDDJZ5i+; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MDDJZ5i+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gTy0w33CXz2xdb
	for <linux-erofs@lists.ozlabs.org>; Tue, 02 Jun 2026 14:05:34 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780373130; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=qwf3ZSM+5G2UFiSkjGZ9LMU4F3NKkUp9Mo954AVU76o=;
	b=MDDJZ5i+kJPUxYcpIM6Y1p4huYuf9gcT9OHCvdzekW0RrU7cfyuIo4RF7b5hvhHTfc2xXrcRDCo3q4lR/wunhH/BpZpZJbut555PAzrh2tdcgiO4PlmeJOYeXUsEoMazXsj1+2ofV56LxRWC6uqV8jH+EFpdWzjEUhjbjV7aNI8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X43-fow_1780373124;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X43-fow_1780373124 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Jun 2026 12:05:28 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Chengyu Zhu <hudsonzhu@tencent.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2 1/3] erofs-utils: mount: extract reusable source-opening and recovery helpers
Date: Tue,  2 Jun 2026 12:05:21 +0800
Message-ID: <20260602040523.286074-1-hsiangkao@linux.alibaba.com>
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
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3496-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim,lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Queue-Id: 53251627F86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chengyu Zhu <hudsonzhu@tencent.com>

Factor out erofsmount_open_source() and erofsmount_open_recovery_source()
helpers; introduce EROFSMOUNT_RUNDIR / EROFSMOUNT_NBD_REC_FMT macros.

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 mount/main.c | 255 ++++++++++++++++++++++++---------------------------
 1 file changed, 119 insertions(+), 136 deletions(-)

diff --git a/mount/main.c b/mount/main.c
index 259a37eb3ddf..140591006e5d 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -46,8 +46,12 @@ struct loop_info {
 /* Device boundary probe */
 #define EROFSMOUNT_NBD_DISK_SIZE	(INT64_MAX >> 9)
 #define EROFSMOUNT_CACHE_DIR	"/var/cache/erofsmount"
-#define EROFSMOUNT_RUNTIME_DIR	"/run/erofsmount"
-#define EROFSMOUNT_FANOTIFY_STATE_DIR	EROFSMOUNT_RUNTIME_DIR "/fanotify"
+
+#define EROFSMOUNT_RUNDIR		"/var/run/erofsmount"
+#define EROFSMOUNT_NBD_RUNDIR		EROFSMOUNT_RUNDIR "/nbd"
+#define EROFSMOUNT_NBD_REC_FMT		EROFSMOUNT_NBD_RUNDIR "/mountnbd_nbd%d"
+
+#define EROFSMOUNT_FANOTIFY_STATE_DIR	EROFSMOUNT_RUNDIR "/fanotify"
 
 #ifdef EROFS_FANOTIFY_ENABLED
 #define EROFSMOUNT_FANOTIFY_HELP	", fanotify"
@@ -758,6 +762,43 @@ struct erofsmount_nbd_ctx {
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
@@ -811,45 +852,9 @@ static int erofsmount_startnbd(int nbdfd, struct erofsmount_source *source)
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
@@ -987,14 +992,16 @@ static int erofsmount_write_recovery_s3(FILE *f, struct erofsmount_source *sourc
 
 static char *erofsmount_write_recovery_info(struct erofsmount_source *source)
 {
-	char recp[] = "/var/run/erofs/mountnbd_XXXXXX";
+	char recp[] = EROFSMOUNT_NBD_RUNDIR "/mountnbd_XXXXXX";
 	int fd, err;
 	FILE *f;
 
 	fd = mkstemp(recp);
 	if (fd < 0 && errno == ENOENT) {
-		err = mkdir("/var/run/erofs", 0700);
-		if (err)
+		if (mkdir(EROFSMOUNT_RUNDIR, 0700) < 0 && errno != EEXIST)
+			return ERR_PTR(-errno);
+		if (mkdir(EROFSMOUNT_NBD_RUNDIR, 0700) < 0 &&
+		    errno != EEXIST)
 			return ERR_PTR(-errno);
 		fd = mkstemp(recp);
 	}
@@ -1261,6 +1268,55 @@ static int erofsmount_reattach_gzran_oci(struct erofsmount_nbd_ctx *ctx,
 	return err;
 }
 
+static int erofsmount_open_recovery_source(struct erofsmount_nbd_ctx *ctx,
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
@@ -1275,7 +1331,7 @@ static int erofsmount_nbd_fix_backend_linkage(int num, char **recp)
 		return err;
 	}
 
-	if (asprintf(&newrecp, "/var/run/erofs/mountnbd_nbd%d", num) <= 0)
+	if (asprintf(&newrecp, EROFSMOUNT_NBD_REC_FMT, num) <= 0)
 		return -ENOMEM;
 
 	if (rename(*recp, newrecp) < 0) {
@@ -1304,41 +1360,9 @@ static int erofsmount_startnbd_nl(pid_t *pid, struct erofsmount_source *source)
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
@@ -1380,11 +1404,10 @@ out_fork:
 
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
@@ -1405,69 +1428,31 @@ static int erofsmount_reattach(const char *target)
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
+	err = erofsmount_open_recovery_source(&ctx, f);
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
@@ -1477,8 +1462,6 @@ static int erofsmount_reattach(const char *target)
 		err = 0;
 	}
 	erofs_io_close(ctx.vd);
-err_line:
-	free(line);
 err_identifier:
 	free(identifier);
 	return err;
@@ -1649,7 +1632,7 @@ static int erofsmount_write_fanotify_state(const char *state_path, pid_t pid,
 	FILE *f = NULL;
 	int fd = -1, err;
 
-	if (mkdir(EROFSMOUNT_RUNTIME_DIR, 0700) < 0 && errno != EEXIST)
+	if (mkdir(EROFSMOUNT_RUNDIR, 0700) < 0 && errno != EEXIST)
 		return -errno;
 	if (mkdir(EROFSMOUNT_FANOTIFY_STATE_DIR, 0700) < 0 &&
 	    errno != EEXIST)
-- 
2.43.5


