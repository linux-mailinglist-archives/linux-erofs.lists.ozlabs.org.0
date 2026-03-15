Return-Path: <linux-erofs+bounces-2704-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGkIJPbBtmkWHwEAu9opvQ
	(envelope-from <linux-erofs+bounces-2704-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Mar 2026 15:28:06 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E11291066
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Mar 2026 15:28:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fYgYX01jzz2yZ3;
	Mon, 16 Mar 2026 01:28:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.67
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773584879;
	cv=none; b=WV49FVOQBaO0sWqSxPomlrowxb3xaGfiEYyUUAl7xqNvuUW6vsLukb5ndTrm//4l4BGa0/5c8JUFws2NJJFRyEPStPWxubYoROA1Vaf0iHxuIeHlRtfsThoBJoLEmMZtjcp3bZ6IrWk7sQgGJcCJLuFqcR7G4HdQbqp+C6W4cWYIJr7Usti3eJ7/yEFzR79okw+NxAyiaOVaTPeWCUjB0KWy0Kt6sx0RZw9Q1GiMivFBFz6o1sA1SSZcE0X7bBmSctCmUDEvwApF/TOA6V6EIhoAkl7Lvzzi/15iXqLPCrG9+2/RoLgF6m23fEmR4ZQoe+H5fUDBna33UmiAfoS8NA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773584879; c=relaxed/relaxed;
	bh=F+ccKxHaDtG2vdUg4UXjWQ/5bhHXiqc70fDZPEOx+m4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aEuHlJoP6hc1LB80FRwhlNqShRF1iIWJGrNd0TqDWMZBN6wiqTTfY8TZj0aOVcAiZm7TmK/ft4yzjNWWxoMltvodtsit5rpnm2yLk4sHGOFNfl3DIKWCpht/BTK0rtbjbqmbRNLB5P//ov0U06g0g1TDs48mnqh1LjmuXPhWowW29+OgpsVJ48iwToEUytzR//gSY71K8zMEKPwZr7p1/kPPH/3/YHhY9gGTLqMszVftJSlPdAV83KUg0RJVOXac5xPCr/udFIC/2LcBJ7+O/A7OO7SLznqJDu3aufbho1GpUjLxObB1XDLwtKTN7Janfhc6I0IoNZlI5zcxSStPnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.67; helo=out28-67.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.67; helo=out28-67.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-67.mail.aliyun.com (out28-67.mail.aliyun.com [115.124.28.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fYgYT3JT2z2yZ5
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 01:27:56 +1100 (AEDT)
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0822712-0.000765939-0.916963;FP=14487635230645126290|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033068005250;MF=hudson@cyzhu.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.gsmlGyi_1773584869;
Received: from HUDSONZHU-MB0.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.gsmlGyi_1773584869 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 15 Mar 2026 22:27:49 +0800
From: Chengyu <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH 2/4] erofs-utils: mount: extract reusable source-opening and recovery helpers
Date: Sun, 15 Mar 2026 22:27:43 +0800
Message-ID: <20260315142745.56845-3-hudson@cyzhu.com>
X-Mailer: git-send-email 2.47.1
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
X-Spam-Status: No, score=0.0 required=3.0 tests=RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [0.00 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2704-lists,linux-erofs=lfdr.de];
	DMARC_NA(0.00)[cyzhu.com];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	NEURAL_HAM(-0.00)[-0.935];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[hudson@cyzhu.com,linux-erofs@lists.ozlabs.org];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,cyzhu.com:mid]
X-Rspamd-Queue-Id: F1E11291066
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chengyu Zhu <hudsonzhu@tencent.com>

Factor out erofsmount_open_source() and erofsmount_open_recovery_source()
helpers; introduce EROFSMOUNT_RUNDIR / EROFSMOUNT_NBD_REC_FMT macros.

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
---
 mount/main.c | 196 +++++++++++++++++++++++++--------------------------
 1 file changed, 98 insertions(+), 98 deletions(-)

diff --git a/mount/main.c b/mount/main.c
index 350738d..93c8444 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -41,6 +41,9 @@ struct loop_info {
 /* Device boundary probe */
 #define EROFSMOUNT_NBD_DISK_SIZE	(INT64_MAX >> 9)
 
+#define EROFSMOUNT_RUNDIR		"/var/run/erofs"
+#define EROFSMOUNT_NBD_REC_FMT		EROFSMOUNT_RUNDIR "/mountnbd_nbd%d"
+
 enum erofs_backend_drv {
 	EROFSAUTO,
 	EROFSLOCAL,
@@ -613,6 +616,25 @@ err_out:
 	return err;
 }
 
+static int erofsmount_open_source(struct erofs_vfile *vf,
+				  struct erofsmount_source *source)
+{
+	int err;
+
+	if (source->type == EROFSMOUNT_SOURCE_OCI) {
+		if (source->ocicfg.tarindex_path || source->ocicfg.zinfo_path)
+			return erofsmount_tarindex_open(vf, &source->ocicfg,
+							source->ocicfg.tarindex_path,
+							source->ocicfg.zinfo_path);
+		return ocierofs_io_open(vf, &source->ocicfg);
+	}
+	err = open(source->device_path, O_RDONLY);
+	if (err < 0)
+		return -errno;
+	vf->fd = err;
+	return 0;
+}
+
 struct erofsmount_nbd_ctx {
 	struct erofs_vfile vd;		/* virtual device */
 	struct erofs_vfile sk;		/* socket file */
@@ -671,26 +693,9 @@ static int erofsmount_startnbd(int nbdfd, struct erofsmount_source *source)
 	pthread_t th;
 	int err, err2;
 
-	if (source->type == EROFSMOUNT_SOURCE_OCI) {
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
+	err = erofsmount_open_source(&ctx.vd, source);
+	if (err)
+		goto out_closefd;
 
 	err = erofs_nbd_connect(nbdfd, 9, EROFSMOUNT_NBD_DISK_SIZE);
 	if (err < 0) {
@@ -797,13 +802,13 @@ static int erofsmount_write_recovery_local(FILE *f, struct erofsmount_source *so
 
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
@@ -945,7 +950,7 @@ static int erofsmount_reattach_oci(struct erofs_vfile *vf,
 }
 #endif
 
-static int erofsmount_reattach_gzran_oci(struct erofsmount_nbd_ctx *ctx,
+static int erofsmount_reattach_gzran_oci(struct erofs_vfile *vd,
 					 char *source)
 {
 	char *tokens[6] = {0}, *p = source, *space, *oci_source;
@@ -975,12 +980,12 @@ static int erofsmount_reattach_gzran_oci(struct erofsmount_nbd_ctx *ctx,
 	if (err < 0)
 		return -ENOMEM;
 
-	err = erofsmount_reattach_oci(&ctx->vd, "OCI_NATIVE_BLOB", oci_source);
+	err = erofsmount_reattach_oci(vd, "OCI_NATIVE_BLOB", oci_source);
 	free(oci_source);
 	if (err)
 		return err;
 
-	temp_vd = ctx->vd;
+	temp_vd = *vd;
 	oci_cfg.image_ref = strdup(source);
 	if (!oci_cfg.image_ref) {
 		erofs_io_close(&temp_vd);
@@ -992,13 +997,60 @@ static int erofsmount_reattach_gzran_oci(struct erofsmount_nbd_ctx *ctx,
 	if (token_count > 4 && tokens[4] && *tokens[4])
 		zinfo_path = tokens[4];
 
-	err = erofsmount_tarindex_open(&ctx->vd, &oci_cfg,
+	err = erofsmount_tarindex_open(vd, &oci_cfg,
 				       meta_path, zinfo_path);
 	free(oci_cfg.image_ref);
 	erofs_io_close(&temp_vd);
 	return err;
 }
 
+static int erofsmount_open_recovery_source(FILE *f,
+					   struct erofs_vfile *vd)
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
+		vd->fd = err;
+		err = 0;
+	} else if (!strcmp(line, "TARINDEX_OCI_BLOB")) {
+		err = erofsmount_reattach_gzran_oci(vd, source);
+	} else if (!strcmp(line, "OCI_LAYER") || !strcmp(line, "OCI_NATIVE_BLOB")) {
+		err = erofsmount_reattach_oci(vd, line, source);
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
@@ -1013,7 +1065,7 @@ static int erofsmount_nbd_fix_backend_linkage(int num, char **recp)
 		return err;
 	}
 
-	if (asprintf(&newrecp, "/var/run/erofs/mountnbd_nbd%d", num) <= 0)
+	if (asprintf(&newrecp, EROFSMOUNT_NBD_REC_FMT, num) <= 0)
 		return -ENOMEM;
 
 	if (rename(*recp, newrecp) < 0) {
@@ -1042,24 +1094,9 @@ static int erofsmount_startnbd_nl(pid_t *pid, struct erofsmount_source *source)
 		if (signal(SIGPIPE, SIG_IGN) == SIG_ERR)
 			exit(EXIT_FAILURE);
 
-		if (source->type == EROFSMOUNT_SOURCE_OCI) {
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
+		err = erofsmount_open_source(&ctx.vd, source);
+		if (err)
+			exit(EXIT_FAILURE);
 		recp = erofsmount_write_recovery_info(source);
 		if (IS_ERR(recp)) {
 			erofs_io_close(&ctx.vd);
@@ -1101,11 +1138,10 @@ out_fork:
 
 static int erofsmount_reattach(const char *target)
 {
-	char *identifier, *line, *source, *recp = NULL;
+	char *identifier;
 	struct erofsmount_nbd_ctx ctx = {};
 	int nbdnum, err;
 	struct stat st;
-	size_t n;
 	FILE *f;
 
 	err = lstat(target, &st);
@@ -1126,65 +1162,31 @@ static int erofsmount_reattach(const char *target)
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
+			goto err_out;
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
-		goto err_identifier;
-	}
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
+		goto err_out;
 	}
 
-	if (!strcmp(line, "LOCAL")) {
-		err = open(source, O_RDONLY);
-		if (err < 0) {
-			err = -errno;
-			goto err_line;
-		}
-		ctx.vd.fd = err;
-	} else if (!strcmp(line, "TARINDEX_OCI_BLOB")) {
-		err = erofsmount_reattach_gzran_oci(&ctx, source);
-		if (err)
-			goto err_line;
-	} else if (!strcmp(line, "OCI_LAYER") || !strcmp(line, "OCI_NATIVE_BLOB")) {
-		err = erofsmount_reattach_oci(&ctx.vd, line, source);
-		if (err)
-			goto err_line;
-	} else {
-		err = -EOPNOTSUPP;
-		erofs_err("unsupported source type %s recorded in recovery file", line);
-		goto err_line;
-	}
+	err = erofsmount_open_recovery_source(f, &ctx.vd);
+	if (err)
+		goto err_out;
 
 	err = erofs_nbd_nl_reconnect(nbdnum, identifier);
 	if (err >= 0) {
 		ctx.sk.fd = err;
 		if (fork() == 0) {
-			free(line);
 			free(identifier);
 			if ((uintptr_t)erofsmount_nbd_loopfn(&ctx))
 				return EXIT_FAILURE;
@@ -1194,9 +1196,7 @@ static int erofsmount_reattach(const char *target)
 		err = 0;
 	}
 	erofs_io_close(&ctx.vd);
-err_line:
-	free(line);
-err_identifier:
+err_out:
 	free(identifier);
 	return err;
 }
-- 
2.47.1


