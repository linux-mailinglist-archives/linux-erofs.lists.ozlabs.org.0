Return-Path: <linux-erofs+bounces-3775-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id alvvAyUyQWq9mAkAu9opvQ
	(envelope-from <linux-erofs+bounces-3775-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 28 Jun 2026 16:39:33 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 209DF6D41C5
	for <lists+linux-erofs@lfdr.de>; Sun, 28 Jun 2026 16:39:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=O1glBJHR;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3775-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3775-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gpBrG463Vz2xjd;
	Mon, 29 Jun 2026 00:39:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782657566;
	cv=none; b=UyTYNKMpLcrwaiVCxXucEpmTrXWjPM7TbpR54BN/l3rX+zKh4/k1uPxNBS60DXp0PUr8t83HMajj/TLvbpgw1kG7DTsv7WAK+wOPyvF5o8xQASXScWwLLVL5InXvQUFTTxqS1T8CcTojJktJr/L4JyaMI3sDSw7whk+RwLD/jA/nlFOs2N1Be68bn6naCBvDwM5Oxm5Npc2PlJLDJ517WSlsQ407IIFLi++tF8nqGq2OgrqiEruQEmVAWbOouLBy2LIdAlSYZDAoc1QKznLDP6G/EccFjLA8DHjsoP4UAfVQppZZ1fk8aQqLvMTIRbiSuLaEn38xAlKJrYMj3xFrNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782657566; c=relaxed/relaxed;
	bh=YrYYmwuKcGBe5qSQoZ8Ad5cBs/ef66qbP91l+GGZMBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=boF0Q/aoYFk4BQLg+OEbNpp77Q1MXH/pel2asdw7PQLyBtnp32D+aYis5kg6dI7qY/cjSm76V/JO9jpAC1CJmbywY2G8WCmNwr9Q4vNEfDChYeLauq/t47+dHaPxSc5gtl9+XXW6Pa4bPWPczSfpJj5lazd5glwXPMhpxYDD3Ss69lvPIFa8UrsjqsZDhhVkPT6b/IgvyiPwyTsLlDm78Wtz+26N11AqS93Z4mnW3NBi3j6aZnl+bqWmW3ZNA/2UCRsRbbU8nNAZCVHxl1A964bskNuxU6EAQ6jk54eomXYky9e/bLppqpOIgejkSkLK65UyCCh8SiNF5gZ0eVkN3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=O1glBJHR; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpBrC6vzVz2xM7
	for <linux-erofs@lists.ozlabs.org>; Mon, 29 Jun 2026 00:39:22 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782657557; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=YrYYmwuKcGBe5qSQoZ8Ad5cBs/ef66qbP91l+GGZMBk=;
	b=O1glBJHR0k9QfDC6j9Svy0wCNHqr/nvLAI64q2ijMEwLuowAJrJYBH4iSDh6gI7UUHYNjlxjrTh0I+93D4EFQ3GgCZrFP2JCA8pkLQjNEOlEnSzShBq3/s+y39L5B9UgLRBQcfWyblYZ7BjTPZBaakcTdFI0UOazLrPDyZdmUFs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X5kT1Q0_1782657551;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X5kT1Q0_1782657551 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 28 Jun 2026 22:39:14 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Chengyu Zhu <hudsonzhu@tencent.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v3 1/2] erofs-utils: mount: support ublk recovery
Date: Sun, 28 Jun 2026 22:39:09 +0800
Message-ID: <20260628143910.1062931-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260624133732.18218-1-hudson@cyzhu.com>
References: <20260624133732.18218-1-hudson@cyzhu.com>
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
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-3775-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 209DF6D41C5

From: Chengyu Zhu <hudsonzhu@tencent.com>

Allow users to reattach to an existing ublk device after deamon crashes.

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/backends/ublk.c |  33 +++++++---
 mount/main.c        | 142 +++++++++++++++++++++++++++++++++++++-------
 2 files changed, 143 insertions(+), 32 deletions(-)

diff --git a/lib/backends/ublk.c b/lib/backends/ublk.c
index a8ecad9fc031..090c6d5bd1e8 100644
--- a/lib/backends/ublk.c
+++ b/lib/backends/ublk.c
@@ -258,8 +258,15 @@ static unsigned int erofsublk_formalize_cmd_op(unsigned int op)
 	DBG_BUGON(_IOC_DIR(op) != 0);
 	DBG_BUGON(_IOC_SIZE(op) != 0);
 
-	if (op < ARRAY_SIZE(ctrl_cmd_op) && !erofs_ublk_use_legacy_cmds)
-		return ctrl_cmd_op[op];
+	if (!erofs_ublk_use_legacy_cmds) {
+		/* IO opcodes live above the ctrl table and need explicit encoding */
+		if (op == UBLK_IO_FETCH_REQ)
+			return UBLK_U_IO_FETCH_REQ;
+		if (op == UBLK_IO_COMMIT_AND_FETCH_REQ)
+			return UBLK_U_IO_COMMIT_AND_FETCH_REQ;
+		if (op < ARRAY_SIZE(ctrl_cmd_op))
+			return ctrl_cmd_op[op];
+	}
 	return op;
 }
 
@@ -492,8 +499,14 @@ static int ublk_get_dev_info(struct erofs_ublk_dev *dev, int dev_id)
 	int ret;
 
 	ret = ublk_dev_ctrl_cmd(dev, UBLK_CMD_GET_DEV_INFO, &cmd);
-	if (ret < 0)
-		erofs_err("GET_DEV_INFO failed: %s", strerror(-ret));
+	if ((ret == -ENODEV || ret == -EOPNOTSUPP) &&
+	    !erofs_ublk_use_legacy_cmds) {
+		erofs_ublk_use_legacy_cmds = true;
+		ret = ublk_dev_ctrl_cmd(dev, UBLK_CMD_GET_DEV_INFO, &cmd);
+		if (ret < 0)
+			erofs_err("GET_DEV_INFO failed for device %d: %s",
+				  dev_id, erofs_strerror(ret));
+	}
 	return ret;
 }
 
@@ -528,11 +541,6 @@ static inline unsigned int user_data_to_tag(u64 user_data)
 	return user_data & 0xffff;
 }
 
-static inline unsigned int user_data_to_op(u64 user_data)
-{
-	return (user_data >> 16) & 0xff;
-}
-
 static inline struct io_uring_sqe *erofsublk_alloc_sqe(struct io_uring *r)
 {
 	unsigned int left = io_uring_sq_space_left(r);
@@ -1259,7 +1267,14 @@ int erofs_ublk_is_recoverable(int dev_id)
 	memset(&dev, 0, sizeof(dev));
 	dev.ctrl_fd = ctrl_fd;
 
+	ret = ublk_ctrl_ring_init(&dev.ctrl_ring);
+	if (ret < 0) {
+		close(ctrl_fd);
+		return 0;
+	}
+
 	ret = ublk_get_dev_info(&dev, dev_id);
+	io_uring_queue_exit(&dev.ctrl_ring);
 	close(ctrl_fd);
 
 	if (ret < 0)
diff --git a/mount/main.c b/mount/main.c
index 5955e2d209dc..dbf5cdddd265 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -51,6 +51,8 @@ struct loop_info {
 #define EROFSMOUNT_RUNDIR		"/var/run/erofsmount"
 #define EROFSMOUNT_NBD_RUNDIR		EROFSMOUNT_RUNDIR "/nbd"
 #define EROFSMOUNT_NBD_REC_FMT		EROFSMOUNT_NBD_RUNDIR "/mountnbd_nbd%d"
+#define EROFSMOUNT_UBLK_RUNDIR		EROFSMOUNT_RUNDIR "/ublk"
+#define EROFSMOUNT_UBLK_REC_FMT		EROFSMOUNT_UBLK_RUNDIR "/mountublk_ublk%d"
 
 #define EROFSMOUNT_FANOTIFY_STATE_DIR	EROFSMOUNT_RUNDIR "/fanotify"
 
@@ -1004,6 +1006,17 @@ static int erofsmount_write_recovery_s3(FILE *f, struct erofsmount_source *sourc
 }
 #endif
 
+static int erofsmount_write_recovery_fp(FILE *f, struct erofsmount_source *source)
+{
+	if (source->type == EROFSMOUNT_SOURCE_OCI)
+		return erofsmount_write_recovery_oci(f, source);
+	if (source->type == EROFSMOUNT_SOURCE_S3_OBJECT)
+		return erofsmount_write_recovery_s3(f, source);
+	if (source->type == EROFSMOUNT_SOURCE_LOCAL)
+		return erofsmount_write_recovery_local(f, source);
+	return -EOPNOTSUPP;
+}
+
 static char *erofsmount_write_recovery_info(struct erofsmount_source *source)
 {
 	char recp[] = EROFSMOUNT_NBD_RUNDIR "/mountnbd_XXXXXX";
@@ -1028,21 +1041,37 @@ static char *erofsmount_write_recovery_info(struct erofsmount_source *source)
 		return ERR_PTR(-errno);
 	}
 
-	if (source->type == EROFSMOUNT_SOURCE_OCI)
-		err = erofsmount_write_recovery_oci(f, source);
-	else if (source->type == EROFSMOUNT_SOURCE_S3_OBJECT)
-		err = erofsmount_write_recovery_s3(f, source);
-	else if (source->type == EROFSMOUNT_SOURCE_LOCAL)
-		err = erofsmount_write_recovery_local(f, source);
-	else
-		err = -EOPNOTSUPP;
-
+	err = erofsmount_write_recovery_fp(f, source);
 	fclose(f);
 	if (err)
 		return ERR_PTR(err);
 	return strdup(recp) ?: ERR_PTR(-ENOMEM);
 }
 
+static int erofsmount_ublk_write_recovery(struct erofsmount_source *source,
+					  const char *path)
+{
+	FILE *f;
+	int err;
+
+	f = fopen(path, "w");
+	if (!f && errno == ENOENT) {
+		if (mkdir(EROFSMOUNT_RUNDIR, 0700) < 0 && errno != EEXIST)
+			return -errno;
+		if (mkdir(EROFSMOUNT_UBLK_RUNDIR, 0700) < 0 && errno != EEXIST)
+			return -errno;
+		f = fopen(path, "w");
+	}
+	if (!f)
+		return -errno;
+
+	err = erofsmount_write_recovery_fp(f, source);
+	fclose(f);
+	if (err)
+		(void)unlink(path);
+	return err;
+}
+
 #ifdef OCIEROFS_ENABLED
 /* Parse input string in format: "image_ref platform layer [b64cred]" */
 static int erofsmount_parse_recovery_ocilayer(struct ocierofs_config *oci_cfg,
@@ -1438,6 +1467,62 @@ static int erofsmount_ublk_handler(void *ctx, struct erofs_ublk_request *rq)
 	return 0;
 }
 
+static int ublk_dev_id_from_path(const char *path)
+{
+	int dev_id;
+
+	if (sscanf(path, "/dev/ublkb%d", &dev_id) == 1)
+		return dev_id;
+	return -1;
+}
+
+static int erofsmount_ublk_reattach(int dev_id)
+{
+	struct erofsmount_nbd_ctx ctx = { .vd = &ctx._vd };
+	char *recp;
+	FILE *f;
+	int err;
+
+	if (!erofs_ublk_is_recoverable(dev_id))
+		return -EINVAL;
+
+	if (asprintf(&recp, EROFSMOUNT_UBLK_REC_FMT, dev_id) <= 0)
+		return -ENOMEM;
+
+	f = fopen(recp, "r");
+	if (!f) {
+		err = -errno;
+		free(recp);
+		return err;
+	}
+
+	err = erofsmount_open_recovery_source(&ctx, f);
+	if (err) {
+		free(recp);
+		return err;
+	}
+
+	if (fork() == 0) {
+		err = erofs_ublk_recover_dev(dev_id, erofsmount_ublk_handler,
+					     ctx.vd);
+		if (err) {
+			erofs_err("ublk recover dev %d failed: %s",
+				  dev_id, strerror(-err));
+			erofs_io_close(ctx.vd);
+			exit(EXIT_FAILURE);
+		}
+		err = erofs_ublk_start(dev_id, -1);
+		erofs_ublk_destroy(dev_id);
+		erofs_io_close(ctx.vd);
+		(void)unlink(recp);
+		exit(err ? EXIT_FAILURE : EXIT_SUCCESS);
+	}
+
+	erofs_io_close(ctx.vd);
+	free(recp);
+	return 0;
+}
+
 static int erofsmount_reattach(const char *target)
 {
 	struct erofsmount_nbd_ctx ctx = { .vd = &ctx._vd };
@@ -1450,7 +1535,14 @@ static int erofsmount_reattach(const char *target)
 	if (err < 0)
 		return -errno;
 
-	if (!S_ISBLK(st.st_mode) || major(st.st_rdev) != EROFS_NBD_MAJOR)
+	if (!S_ISBLK(st.st_mode))
+		return -ENOTBLK;
+
+	nbdnum = ublk_dev_id_from_path(target);
+	if (nbdnum >= 0)
+		return erofsmount_ublk_reattach(nbdnum);
+
+	if (major(st.st_rdev) != EROFS_NBD_MAJOR)
 		return -ENOTBLK;
 
 	nbdnum = erofs_nbd_get_index_from_minor(minor(st.st_rdev));
@@ -2101,6 +2193,7 @@ static int erofsmount_ublk(struct erofsmount_source *source,
 	if (pid == 0) {
 		struct erofsmount_nbd_ctx ctx = { .vd = &ctx._vd };
 		struct erofs_ublk_dev_info info;
+		char *recp = NULL;
 		struct stat st;
 
 		close(pipefd[0]);
@@ -2114,7 +2207,7 @@ static int erofsmount_ublk(struct erofsmount_source *source,
 			.max_io_buf_bytes = EROFS_UBLK_DEF_MAX_IO_BUF_BYTES,
 			.dev_id = -1,
 			.blkbits = EROFS_UBLK_DEF_BLK_BITS,
-			.flags = 0,
+			.flags = EROFS_UBLK_F_USER_RECOVERY,
 			.dev_size = source->type == EROFSMOUNT_SOURCE_LOCAL &&
 				erofs_io_fstat(ctx.vd, &st) == 0 ?
 					st.st_size : INT64_MAX,
@@ -2123,20 +2216,32 @@ static int erofsmount_ublk(struct erofsmount_source *source,
 		dev_id = erofs_ublk_create_dev(&info, erofsmount_ublk_handler,
 					       ctx.vd);
 		if (dev_id < 0) {
-			erofs_err("erofs_ublk_create_dev failed: %s",
-				  strerror(-dev_id));
+			erofs_err("failed to erofs_ublk_create_dev: %s",
+				  erofs_strerror(dev_id));
 			exit(EXIT_FAILURE);
 		}
 
+		if (asprintf(&recp, EROFSMOUNT_UBLK_REC_FMT, dev_id) > 0) {
+			err = erofsmount_ublk_write_recovery(source, recp);
+			if (err)
+				erofs_warn("failed to write recovery info for ublk %d: %s",
+					   dev_id, erofs_strerror(err));
+		}
+
 		if (write(pipefd[1], &dev_id,
 			  sizeof(dev_id)) != sizeof(dev_id))
 			exit(EXIT_FAILURE);
 
 		err = erofs_ublk_start(dev_id, pipefd[1]);
 		if (err)
-			erofs_err("erofs_ublk_start: %s", strerror(-err));
+			erofs_err("failed to erofs_ublk_start: %s",
+				  erofs_strerror(err));
 		erofs_ublk_destroy(dev_id);
 		erofs_io_close(ctx.vd);
+		if (recp) {
+			(void)unlink(recp);
+			free(recp);
+		}
 		exit(EXIT_SUCCESS);
 	}
 
@@ -2167,15 +2272,6 @@ static int erofsmount_ublk(struct erofsmount_source *source,
 	return 0;
 }
 
-static int ublk_dev_id_from_path(const char *path)
-{
-	int dev_id;
-
-	if (sscanf(path, "/dev/ublkb%d", &dev_id) == 1)
-		return dev_id;
-	return -1;
-}
-
 int erofsmount_umount(char *target)
 {
 	char *device = NULL, *mountpoint = NULL;
-- 
2.43.5


