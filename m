Return-Path: <linux-erofs+bounces-3680-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qrndEmLDNGrGgQYAu9opvQ
	(envelope-from <linux-erofs+bounces-3680-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jun 2026 06:19:46 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE43E6A3C7D
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jun 2026 06:19:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3680-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3680-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghPWH5B7Jz3bpP;
	Fri, 19 Jun 2026 14:19:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781842779;
	cv=none; b=U89QqFWoXsHulcE5bfKctkciAbJljBZHIWeaBpSJstd8MuOexu9lNan1xljAWntids+wEq9jiBAlDSXeYMsOHE/ho7fintzxL1U7Cjh3rhma+FN4QwyzObN9ZLlKscONY9Ea5gDBD/QZO30WxpPrCfg34/Uf4QLJTCvMUnigritdmmanEo3qD5FS2Gg60zUJp7LeJwZ+DlRvhv7qJMinKtYsBFV6xcTI+5SxSr2t11zisekGfLDxHAJVVbDAgAtPK3Flj2VTwlFDdyFH3IHJjqa0blO7TxiAwCLMAKlznoyNk5GZ29JPSg6ffad+uP49ZjkItlChB1V9VISPnVGT5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781842779; c=relaxed/relaxed;
	bh=RlesLMPzn/h4Hz538IqxeFM+dwGbL+sZs5L+XE9FWsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AyjojKqIbCGaaCLadRCsxApDgGP8bmEcT2iKNxeC9ZL6Fw4NOKKngD9a5JnTT/1l9ULQfOt8EmjDFiM82CcD1E/WrQ3U9notJHtv1wK1jRKl9Ck7AfDCAPfZOGi1kfDUEx7b7YCHKfudu9lYQhUT7g8k/To2iOkRpvWNXlqlS57zC0NOMG+M9kIFrJ5SPfilMP9QIRDSALxc5EIY5IU88bR9vtVy1JawI9bo/eBBlZ8sgsQpKbEw0uvh7TVtQVqBYl4Nkb1j0GVCgh4NA4VG+lcUgk0O2aKP/QLvSIbp5XYMest8UVAScQfmtT4+iPOL5fXFOCcmU/CkTW4c/+tZyQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.78; helo=out28-78.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Received: from out28-78.mail.aliyun.com (out28-78.mail.aliyun.com [115.124.28.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghPWD0JBpz3bpm
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 Jun 2026 14:19:32 +1000 (AEST)
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00708238-0.00125011-0.991668;FP=9880699857432745107|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037022039;MF=hudson@cyzhu.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.i0FVOl7_1781842767;
Received: from HUDSONZHU-MB0.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.i0FVOl7_1781842767 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 19 Jun 2026 12:19:27 +0800
From: Chengyu <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH 2/2] mount: rename erofsmount_nbd_ctx to erofsmount_ctx
Date: Fri, 19 Jun 2026 12:19:22 +0800
Message-ID: <20260619041922.64521-3-hudson@cyzhu.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3680-lists,linux-erofs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[cyzhu.com];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	ALIAS_RESOLVED(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[hudson@cyzhu.com,linux-erofs@lists.ozlabs.org];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AE43E6A3C7D

From: Chengyu Zhu <hudsonzhu@tencent.com>

The struct is shared by NBD, ublk and fanotify paths, so the
nbd-specific name was misleading.

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
---
 mount/main.c | 79 +++++++++++++++++++++++++++-------------------------
 1 file changed, 41 insertions(+), 38 deletions(-)

diff --git a/mount/main.c b/mount/main.c
index 754e585..3178fbc 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -772,13 +772,13 @@ err_out:
 	return err;
 }
 
-struct erofsmount_nbd_ctx {
-	struct erofs_vfile _vd;		/* virtual device */
-	struct erofs_vfile sk;		/* socket file */
+struct erofsmount_ctx {
+	struct erofs_vfile _vd;		/* backing source */
+	struct erofs_vfile sk;		/* NBD socket (NBD backend only) */
 	struct erofs_vfile *vd;
 };
 
-static int erofsmount_open_source(struct erofsmount_nbd_ctx *ctx,
+static int erofsmount_open_source(struct erofsmount_ctx *ctx,
 				  struct erofsmount_source *source)
 {
 	int err;
@@ -817,7 +817,7 @@ static int erofsmount_open_source(struct erofsmount_nbd_ctx *ctx,
 
 static void *erofsmount_nbd_loopfn(void *arg)
 {
-	struct erofsmount_nbd_ctx *ctx = arg;
+	struct erofsmount_ctx *ctx = arg;
 	int err;
 
 	while (1) {
@@ -863,7 +863,7 @@ out:
 
 static int erofsmount_startnbd(int nbdfd, struct erofsmount_source *source)
 {
-	struct erofsmount_nbd_ctx ctx = { .vd = &ctx._vd };
+	struct erofsmount_ctx ctx = { .vd = &ctx._vd };
 	uintptr_t retcode;
 	pthread_t th;
 	int err, err2;
@@ -1190,7 +1190,7 @@ static int erofsmount_reattach_oci(struct erofs_vfile *vf,
 #endif
 
 #ifdef S3EROFS_ENABLED
-static int erofsmount_reattach_s3(struct erofsmount_nbd_ctx *ctx, char *source)
+static int erofsmount_reattach_s3(struct erofsmount_ctx *ctx, char *source)
 {
 	char *tokens[5] = {0}, *p = source;
 	char *bucket = NULL, *key = NULL;
@@ -1253,13 +1253,13 @@ err_out:
 	return err;
 }
 #else
-static int erofsmount_reattach_s3(struct erofsmount_nbd_ctx *ctx, char *source)
+static int erofsmount_reattach_s3(struct erofsmount_ctx *ctx, char *source)
 {
 	return -EOPNOTSUPP;
 }
 #endif
 
-static int erofsmount_reattach_gzran_oci(struct erofsmount_nbd_ctx *ctx,
+static int erofsmount_reattach_gzran_oci(struct erofsmount_ctx *ctx,
 					 char *source)
 {
 	char *tokens[6] = {0}, *p = source, *space, *oci_source;
@@ -1313,7 +1313,7 @@ static int erofsmount_reattach_gzran_oci(struct erofsmount_nbd_ctx *ctx,
 	return err;
 }
 
-static int erofsmount_open_recovery_source(struct erofsmount_nbd_ctx *ctx,
+static int erofsmount_open_recovery_source(struct erofsmount_ctx *ctx,
 					   FILE *f)
 {
 	char *line = NULL, *source;
@@ -1398,7 +1398,7 @@ static int erofsmount_startnbd_nl(pid_t *pid, struct erofsmount_source *source)
 		return -errno;
 
 	if ((*pid = fork()) == 0) {
-		struct erofsmount_nbd_ctx ctx = { .vd = &ctx._vd };
+		struct erofsmount_ctx ctx = { .vd = &ctx._vd };
 		char *recp;
 
 		/* Otherwise, NBD disconnect sends SIGPIPE, skipping cleanup */
@@ -1471,7 +1471,7 @@ static int ublk_dev_id_from_path(const char *path);
 
 static int erofsmount_ublk_reattach(int dev_id)
 {
-	struct erofsmount_nbd_ctx ctx = { .vd = &ctx._vd };
+	struct erofsmount_ctx ctx = { .vd = &ctx._vd };
 	char *recp;
 	FILE *f;
 	int err;
@@ -1518,9 +1518,9 @@ static int erofsmount_ublk_reattach(int dev_id)
 
 static int erofsmount_reattach(const char *target)
 {
-	struct erofsmount_nbd_ctx ctx = { .vd = &ctx._vd };
+	struct erofsmount_ctx ctx = { .vd = &ctx._vd };
 	char *identifier;
-	int nbdnum, err;
+	int dev_id, err;
 	struct stat st;
 	FILE *f;
 
@@ -1528,17 +1528,17 @@ static int erofsmount_reattach(const char *target)
 	if (err < 0)
 		return -errno;
 
-	nbdnum = ublk_dev_id_from_path(target);
-	if (S_ISBLK(st.st_mode) && nbdnum >= 0)
-		return erofsmount_ublk_reattach(nbdnum);
+	dev_id = ublk_dev_id_from_path(target);
+	if (S_ISBLK(st.st_mode) && dev_id >= 0)
+		return erofsmount_ublk_reattach(dev_id);
 
 	if (!S_ISBLK(st.st_mode) || major(st.st_rdev) != EROFS_NBD_MAJOR)
 		return -ENOTBLK;
 
-	nbdnum = erofs_nbd_get_index_from_minor(minor(st.st_rdev));
-	if (nbdnum < 0)
-		return nbdnum;
-	identifier = erofs_nbd_get_identifier(nbdnum);
+	dev_id = erofs_nbd_get_index_from_minor(minor(st.st_rdev));
+	if (dev_id < 0)
+		return dev_id;
+	identifier = erofs_nbd_get_identifier(dev_id);
 	if (IS_ERR(identifier)) {
 		identifier = NULL;
 	} else if (identifier && *identifier == '\0') {
@@ -1549,7 +1549,7 @@ static int erofsmount_reattach(const char *target)
 	if (!identifier) {
 		char *recp;
 
-		if (asprintf(&recp, EROFSMOUNT_NBD_REC_FMT, nbdnum) <= 0) {
+		if (asprintf(&recp, EROFSMOUNT_NBD_REC_FMT, dev_id) <= 0) {
 			err = -ENOMEM;
 			goto err_identifier;
 		}
@@ -1567,7 +1567,7 @@ static int erofsmount_reattach(const char *target)
 	if (err)
 		goto err_identifier;
 
-	err = erofs_nbd_nl_reconnect(nbdnum, identifier);
+	err = erofs_nbd_nl_reconnect(dev_id, identifier);
 	if (err >= 0) {
 		ctx.sk.fd = err;
 		if (fork() == 0) {
@@ -2181,7 +2181,7 @@ static int erofsmount_ublk(struct erofsmount_source *source,
 	}
 
 	if (pid == 0) {
-		struct erofsmount_nbd_ctx ctx = { .vd = &ctx._vd };
+		struct erofsmount_ctx ctx = { .vd = &ctx._vd };
 		struct erofs_ublk_dev_info info;
 		struct stat st;
 
@@ -2274,7 +2274,7 @@ static int ublk_dev_id_from_path(const char *path)
 int erofsmount_umount(char *target)
 {
 	char *device = NULL, *mountpoint = NULL;
-	int err, fd, nbdnum;
+	int err, fd, dev_id;
 	struct stat st;
 	FILE *mounts;
 	size_t n;
@@ -2346,19 +2346,22 @@ int erofsmount_umount(char *target)
 
 	if (isblk && !mountpoint && S_ISBLK(st.st_mode)) {
 		if (major(st.st_rdev) == EROFS_NBD_MAJOR) {
-			nbdnum = erofs_nbd_get_index_from_minor(minor(st.st_rdev));
-			err = erofs_nbd_nl_disconnect(nbdnum);
+			dev_id = erofs_nbd_get_index_from_minor(minor(st.st_rdev));
+			err = erofs_nbd_nl_disconnect(dev_id);
 			if (err != -EOPNOTSUPP)
 				goto err_out;
-		} else if ((nbdnum = ublk_dev_id_from_path(target)) >= 0) {
-			err = erofs_ublk_del_dev_by_id(nbdnum);
-			goto err_out;
+		} else {
+			dev_id = ublk_dev_id_from_path(target);
+			if (dev_id >= 0) {
+				err = erofs_ublk_del_dev_by_id(dev_id);
+				goto err_out;
+			}
 		}
 	}
 
 	/* XXX: ublk doesn't have autoclose feature */
-	nbdnum = ublk_dev_id_from_path(device);
-	if (nbdnum >= 0) {
+	dev_id = ublk_dev_id_from_path(device);
+	if (dev_id >= 0) {
 		if (mountpoint) {
 			err = umount(mountpoint);
 			if (err) {
@@ -2366,7 +2369,7 @@ int erofsmount_umount(char *target)
 				goto err_out;
 			}
 		}
-		err = erofs_ublk_del_dev_by_id(nbdnum);
+		err = erofs_ublk_del_dev_by_id(dev_id);
 		goto err_out;
 	}
 
@@ -2397,8 +2400,8 @@ int erofsmount_umount(char *target)
 	if (err < 0)
 		err = -errno;
 	else if (S_ISBLK(st.st_mode) && major(st.st_rdev) == EROFS_NBD_MAJOR) {
-		nbdnum = erofs_nbd_get_index_from_minor(minor(st.st_rdev));
-		err = erofs_nbd_nl_disconnect(nbdnum);
+		dev_id = erofs_nbd_get_index_from_minor(minor(st.st_rdev));
+		err = erofs_nbd_nl_disconnect(dev_id);
 		if (err == -EOPNOTSUPP)
 			err = erofs_nbd_disconnect(fd);
 	}
@@ -2412,7 +2415,7 @@ err_out:
 
 static int erofsmount_disconnect(const char *target)
 {
-	int nbdnum, err, fd;
+	int dev_id, err, fd;
 	struct stat st;
 
 	err = lstat(target, &st);
@@ -2422,8 +2425,8 @@ static int erofsmount_disconnect(const char *target)
 	if (!S_ISBLK(st.st_mode) || major(st.st_rdev) != EROFS_NBD_MAJOR)
 		return -ENOTBLK;
 
-	nbdnum = erofs_nbd_get_index_from_minor(minor(st.st_rdev));
-	err = erofs_nbd_nl_disconnect(nbdnum);
+	dev_id = erofs_nbd_get_index_from_minor(minor(st.st_rdev));
+	err = erofs_nbd_nl_disconnect(dev_id);
 	if (err == -EOPNOTSUPP) {
 		fd = open(target, O_RDWR);
 		if (fd < 0) {
-- 
2.47.1


