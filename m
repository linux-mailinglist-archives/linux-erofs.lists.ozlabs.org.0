Return-Path: <linux-erofs+bounces-3679-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aljtJl/DNGrFgQYAu9opvQ
	(envelope-from <linux-erofs+bounces-3679-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jun 2026 06:19:43 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6F16A3C76
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jun 2026 06:19:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3679-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3679-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghPWH0gTNz3bpp;
	Fri, 19 Jun 2026 14:19:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781842779;
	cv=none; b=A8YJyyyaek26EDkCv+nMiGY58MmR93OUJooVOYd8bnq6Y5MLm6s6xU/3rDWXha7ylQIwiMsM7iTf9kkSnnrwYr7XoBxpRFRuZLeToqf91r5hwGHOH1hL3SkXeie3D0Gl2J/hI+O0hfob1I5AxOtGCqegeaLrZWQcJ7m+vJFuRxr19IahUO/VyQcaZsAbKxgo488TJsN9WA0POW70D+UXpZFfntXyhbuaaTBmbiLKfwt2OohHDXhC7joOzjOfpVdkz3aG+c0/Zn+gt0AtA+jFKVRbQNDQGzjdAriIALgS3MuGJaDAfYPK2/0XNJyJ5s7ogPcfVtBHg7rronDPkheXPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781842779; c=relaxed/relaxed;
	bh=dxF+dsODJxuJAMF2QN0VTGOiOMPZrdUCR7g+wEcDaNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KT68V8mu2DRTEawdrJ9vtXfgPdHc856sFqyFUUkTRKTv6yuMOjfWPbB9U1vSog4qcm0t29JOT72aDui6X8ioDEl8BNI7FQS0M+ExVQAbgIXsGI/cTzyo5Hs3vD5LxmaxvbpF8FapSGkPzddwn0lvwt2KgFwZg0Ltc501u75a33iGYOgLIFlgP1qjybuh4aA/QKlWvg7ZNM20P4FxVFbu2QYSRXQV5dj6IzuVdENaQiW+rPA/ABUK9aN66c0b9FEpV8799Iqe8e2mFS7la2tB+Qzbi5LaxLaVdODmL/aI2ZOK4TbNb5hDBS0h9bFQgFq9Ltzuc5Uucf2jWJJyb4AzAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.60; helo=out28-60.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Received: from out28-60.mail.aliyun.com (out28-60.mail.aliyun.com [115.124.28.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghPWC6R2Fz3bpP
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 Jun 2026 14:19:32 +1000 (AEST)
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0110094-0.000423491-0.988567;FP=14850140942034142389|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033023018039;MF=hudson@cyzhu.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.i0FVOkZ_1781842767;
Received: from HUDSONZHU-MB0.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.i0FVOkZ_1781842767 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 19 Jun 2026 12:19:27 +0800
From: Chengyu <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH 1/2] ublk: support ublk recovery
Date: Fri, 19 Jun 2026 12:19:21 +0800
Message-ID: <20260619041922.64521-2-hudson@cyzhu.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260619041922.64521-1-hudson@cyzhu.com>
References: <20260619041922.64521-1-hudson@cyzhu.com>
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
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.00 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3679-lists,linux-erofs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[cyzhu.com];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	ALIAS_RESOLVED(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[hudson@cyzhu.com,linux-erofs@lists.ozlabs.org];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E6F16A3C76

From: Chengyu Zhu <hudsonzhu@tencent.com>

Enable ublk user recovery so erofsmount can reattach a daemon to a
recoverable ublk device after the previous userspace server exits.

Store the recovery source information in a ublk-specific runtime record,
create ublk devices with user recovery enabled, and add the mount-side
reattach path for existing recoverable ublk devices.

Also encode ublk IO uring command opcodes explicitly for non-legacy kernels,
and initialize the control ring before querying whether a ublk device is
recoverable.

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
---
 lib/backends/ublk.c |  23 ++++++---
 mount/main.c        | 115 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 122 insertions(+), 16 deletions(-)

diff --git a/lib/backends/ublk.c b/lib/backends/ublk.c
index a8ecad9..49191de 100644
--- a/lib/backends/ublk.c
+++ b/lib/backends/ublk.c
@@ -258,7 +258,16 @@ static unsigned int erofsublk_formalize_cmd_op(unsigned int op)
 	DBG_BUGON(_IOC_DIR(op) != 0);
 	DBG_BUGON(_IOC_SIZE(op) != 0);
 
-	if (op < ARRAY_SIZE(ctrl_cmd_op) && !erofs_ublk_use_legacy_cmds)
+	if (erofs_ublk_use_legacy_cmds)
+		return op;
+
+	/* IO opcodes live above the ctrl table and need explicit encoding */
+	if (op == UBLK_IO_FETCH_REQ)
+		return UBLK_U_IO_FETCH_REQ;
+	if (op == UBLK_IO_COMMIT_AND_FETCH_REQ)
+		return UBLK_U_IO_COMMIT_AND_FETCH_REQ;
+
+	if (op < ARRAY_SIZE(ctrl_cmd_op))
 		return ctrl_cmd_op[op];
 	return op;
 }
@@ -528,11 +537,6 @@ static inline unsigned int user_data_to_tag(u64 user_data)
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
@@ -1259,7 +1263,14 @@ int erofs_ublk_is_recoverable(int dev_id)
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
index 5955e2d..754e585 100644
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
 
+static int erofsmount_write_recovery_path(struct erofsmount_source *source,
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
@@ -1438,6 +1467,55 @@ static int erofsmount_ublk_handler(void *ctx, struct erofs_ublk_request *rq)
 	return 0;
 }
 
+static int ublk_dev_id_from_path(const char *path);
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
@@ -1450,6 +1528,10 @@ static int erofsmount_reattach(const char *target)
 	if (err < 0)
 		return -errno;
 
+	nbdnum = ublk_dev_id_from_path(target);
+	if (S_ISBLK(st.st_mode) && nbdnum >= 0)
+		return erofsmount_ublk_reattach(nbdnum);
+
 	if (!S_ISBLK(st.st_mode) || major(st.st_rdev) != EROFS_NBD_MAJOR)
 		return -ENOTBLK;
 
@@ -2108,13 +2190,15 @@ static int erofsmount_ublk(struct erofsmount_source *source,
 		if (err)
 			exit(EXIT_FAILURE);
 
+		char *recp = NULL;
+
 		info = (struct erofs_ublk_dev_info) {
 			.nr_hw_queues = EROFS_UBLK_DEF_NR_HW_QUEUES,
 			.queue_depth = EROFS_UBLK_DEF_QUEUE_DEPTH,
 			.max_io_buf_bytes = EROFS_UBLK_DEF_MAX_IO_BUF_BYTES,
 			.dev_id = -1,
 			.blkbits = EROFS_UBLK_DEF_BLK_BITS,
-			.flags = 0,
+			.flags = EROFS_UBLK_F_USER_RECOVERY,
 			.dev_size = source->type == EROFSMOUNT_SOURCE_LOCAL &&
 				erofs_io_fstat(ctx.vd, &st) == 0 ?
 					st.st_size : INT64_MAX,
@@ -2128,6 +2212,13 @@ static int erofsmount_ublk(struct erofsmount_source *source,
 			exit(EXIT_FAILURE);
 		}
 
+		if (asprintf(&recp, EROFSMOUNT_UBLK_REC_FMT, dev_id) > 0) {
+			err = erofsmount_write_recovery_path(source, recp);
+			if (err)
+				erofs_warn("ublk dev %d recovery info unwritable: %s",
+					   dev_id, strerror(-err));
+		}
+
 		if (write(pipefd[1], &dev_id,
 			  sizeof(dev_id)) != sizeof(dev_id))
 			exit(EXIT_FAILURE);
@@ -2137,6 +2228,10 @@ static int erofsmount_ublk(struct erofsmount_source *source,
 			erofs_err("erofs_ublk_start: %s", strerror(-err));
 		erofs_ublk_destroy(dev_id);
 		erofs_io_close(ctx.vd);
+		if (recp) {
+			(void)unlink(recp);
+			free(recp);
+		}
 		exit(EXIT_SUCCESS);
 	}
 
-- 
2.47.1


