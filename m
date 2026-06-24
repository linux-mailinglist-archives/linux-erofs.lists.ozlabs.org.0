Return-Path: <linux-erofs+bounces-3749-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BnP8AbHdO2qteQgAu9opvQ
	(envelope-from <linux-erofs+bounces-3749-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jun 2026 15:37:53 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8E86BEAF7
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jun 2026 15:37:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3749-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3749-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gljfx1XQYz2ySg;
	Wed, 24 Jun 2026 23:37:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782308265;
	cv=none; b=GT3g8AZTyPFRr4u6dHPtmJSAoRRhdM0aQSU+WPxktV1+cknlBvZ+7xpLzo7iHgB8ig0+OI5c3mFSy+0pJw+LLFyWelEiqJa7XzXqep/s5QxuVsZY45lpUdEQ6/V5hsEFXqHNdsG+JYDcS4Kg7lM1RjmF7NZ9Jl8bqCaP9ieNL3m2S/hJE2lXG+tgkox6eqondGJyw9tI6VRseLhndiLRZ5Sl66FRch1ISlSylV5jfEnLdmiQXIcxkg6phksODO5cHkjSpc1OPrZLjSo+vaCb44800wtOVbVwhCD4k6rKo1fsSdN6GhxIgysBA8xGcSPRngUAYN04SOgwaCTVlloXow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782308265; c=relaxed/relaxed;
	bh=FIp4YriSVAI6+8hoPSoLSafXLcv81sXuQ4VVHayzDMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FwmALgmtY+T/NJArdhg0fWbESVnoXc35iPt1hggjTCXXgFx9igsCjX94X5o6bB9u5kQquPbbIfhw6yL0ILbDvXBptLb+r7fX5DamLrg0C1FQdnWwE4VOG59jOFx38piFZbi/3WVf/RnWeY7kDr0KT3caWloPtmVh8tzVMcNSPcQfTZrwKHSfo+xp5tgaBkqVGKwQXbwbNGQSmTGciDnP8jUTf3WDiPJESbWR6BqK/W8f81v1nlkBtnc97MSfeWVV4/Aa2MrryFyV08WZUyfgQXX0K8qNYuYIKKPk9aFpWZdZppuUts8NOMBIV1UXJvjovfWWc04v36ohV43+JkZ8Rw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.55; helo=out28-55.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Received: from out28-55.mail.aliyun.com (out28-55.mail.aliyun.com [115.124.28.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gljft2lNyz2yZ6
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Jun 2026 23:37:40 +1000 (AEST)
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00873184-0.000536433-0.990732;FP=10238441729468007605|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam011083013073;MF=hudson@cyzhu.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.i4Wq2TU_1782308253;
Received: from HUDSONZHU-MB0.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.i4Wq2TU_1782308253 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 24 Jun 2026 21:37:33 +0800
From: Chengyu <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH 1/2] ublk: support ublk recovery
Date: Wed, 24 Jun 2026 21:37:31 +0800
Message-ID: <20260624133732.18218-2-hudson@cyzhu.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260624133732.18218-1-hudson@cyzhu.com>
References: <20260619041922.64521-1-hudson@cyzhu.com>
 <20260624133732.18218-1-hudson@cyzhu.com>
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
X-Spam-Status: No, score=0.0 required=3.0 tests=SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.00 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[cyzhu.com];
	ALIAS_RESOLVED(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hudson@cyzhu.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3749-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E8E86BEAF7

From: Chengyu Zhu <hudsonzhu@tencent.com>

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
---
 lib/backends/ublk.c |  23 +++++---
 mount/main.c        | 136 +++++++++++++++++++++++++++++++++++++-------
 2 files changed, 132 insertions(+), 27 deletions(-)

diff --git a/lib/backends/ublk.c b/lib/backends/ublk.c
index a8ecad9..9f63882 100644
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
 
@@ -528,11 +535,6 @@ static inline unsigned int user_data_to_tag(u64 user_data)
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
@@ -1259,7 +1261,14 @@ int erofs_ublk_is_recoverable(int dev_id)
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
index 5955e2d..2b8f6f4 100644
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
@@ -2108,13 +2200,15 @@ static int erofsmount_ublk(struct erofsmount_source *source,
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
@@ -2128,6 +2222,13 @@ static int erofsmount_ublk(struct erofsmount_source *source,
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
@@ -2137,6 +2238,10 @@ static int erofsmount_ublk(struct erofsmount_source *source,
 			erofs_err("erofs_ublk_start: %s", strerror(-err));
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
2.47.1


