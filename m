Return-Path: <linux-erofs+bounces-3748-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4zRmOq7dO2qseQgAu9opvQ
	(envelope-from <linux-erofs+bounces-3748-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jun 2026 15:37:50 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC32D6BEAF0
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jun 2026 15:37:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3748-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3748-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gljfw3vxrz2yVv;
	Wed, 24 Jun 2026 23:37:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782308264;
	cv=none; b=YmtAa7jILvOkr2X95PrqanM4fI/FrZawEnd3aCOfZkSPIpeEc0VX8OxPbKBfpy5JHpsL/2T4XFNgqNI4Tz4fbUlP53yxzDhmky2DEYMbKwnclzcJz+7w2CPXfQl0SxLRLCiMVRVGuLpplA7Jo1z1sTNwmr7FReIXiAnG59dWCYUwm4g9IwuPBBy/xxpTKWGI9f5vAcnaIFJpf2x1st159n4h94utqDLYpyv0SagMrTvoX5kfzu87xHUlYc0QxXaeOJw5bz5cxCM+JbajLJm7gsYtGV9CTYFPHpjWFZ8BQsmjdoVhtsQd9nz/3E76v/ysH05gt5w3DQkTPuVlGFnoVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782308264; c=relaxed/relaxed;
	bh=AxUabnhGGsOhWMcdB79xrc6powKU3CRd9EQgnQ4xhTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKCuk5PhLAjm0ilJ16aYL1tSnQCmLi/sT5KVyDZrlpHRHcLl3BJp0G4SrzfmuqEMHf1mpVKfh9cwjfv94rlJWp9uWw1SyMhjHj84N/ht0B06NT1AzZ/UEnXR8P1h2+lakitgoGFsqEmyrrx7VcPNX+3kgtUgyKluS9jn7vuN8gnPETztge2ALuoxzvHS2+wNZ3EpC9csHtsTPTV+ua9/jBX5UJQAWNqa8/yQ9xWBUTDW8dk1pTf06ThLTeAEk6IG5mXJ7qBrVO+HQ5IsJkDHzQbVrH4B/GDrhIXxDX509lyoBGrSe4UyhphEqQHhspcyZ8hSDZi3uPyrkXT0xjldSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.79; helo=out28-79.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Received: from out28-79.mail.aliyun.com (out28-79.mail.aliyun.com [115.124.28.79])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gljft1yDSz2ySg
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Jun 2026 23:37:40 +1000 (AEST)
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00687922-0.00142645-0.991694;FP=9880702056456000659|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=hudson@cyzhu.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.i4Wq2Tr_1782308253;
Received: from HUDSONZHU-MB0.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.i4Wq2Tr_1782308253 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 24 Jun 2026 21:37:33 +0800
From: Chengyu <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH 2/2] mount: rename erofsmount_nbd_ctx to erofsmount_ctx
Date: Wed, 24 Jun 2026 21:37:32 +0800
Message-ID: <20260624133732.18218-3-hudson@cyzhu.com>
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
X-Spam-Status: No, score=0.0 required=3.0 tests=RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=disabled
	version=4.0.1
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
	TAGGED_FROM(0.00)[bounces-3748-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC32D6BEAF0

From: Chengyu Zhu <hudsonzhu@tencent.com>

The struct is shared by NBD, ublk and fanotify paths, so the
nbd-specific name was misleading.

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
---
 mount/main.c | 79 +++++++++++++++++++++++++++-------------------------
 1 file changed, 41 insertions(+), 38 deletions(-)

diff --git a/mount/main.c b/mount/main.c
index 2b8f6f4..0941b0a 100644
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
@@ -1478,7 +1478,7 @@ static int ublk_dev_id_from_path(const char *path)
 
 static int erofsmount_ublk_reattach(int dev_id)
 {
-	struct erofsmount_nbd_ctx ctx = { .vd = &ctx._vd };
+	struct erofsmount_ctx ctx = { .vd = &ctx._vd };
 	char *recp;
 	FILE *f;
 	int err;
@@ -1525,9 +1525,9 @@ static int erofsmount_ublk_reattach(int dev_id)
 
 static int erofsmount_reattach(const char *target)
 {
-	struct erofsmount_nbd_ctx ctx = { .vd = &ctx._vd };
+	struct erofsmount_ctx ctx = { .vd = &ctx._vd };
 	char *identifier;
-	int nbdnum, err;
+	int dev_id, err;
 	struct stat st;
 	FILE *f;
 
@@ -1538,17 +1538,17 @@ static int erofsmount_reattach(const char *target)
 	if (!S_ISBLK(st.st_mode))
 		return -ENOTBLK;
 
-	nbdnum = ublk_dev_id_from_path(target);
-	if (nbdnum >= 0)
-		return erofsmount_ublk_reattach(nbdnum);
+	dev_id = ublk_dev_id_from_path(target);
+	if (dev_id >= 0)
+		return erofsmount_ublk_reattach(dev_id);
 
 	if (major(st.st_rdev) != EROFS_NBD_MAJOR)
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
@@ -1559,7 +1559,7 @@ static int erofsmount_reattach(const char *target)
 	if (!identifier) {
 		char *recp;
 
-		if (asprintf(&recp, EROFSMOUNT_NBD_REC_FMT, nbdnum) <= 0) {
+		if (asprintf(&recp, EROFSMOUNT_NBD_REC_FMT, dev_id) <= 0) {
 			err = -ENOMEM;
 			goto err_identifier;
 		}
@@ -1577,7 +1577,7 @@ static int erofsmount_reattach(const char *target)
 	if (err)
 		goto err_identifier;
 
-	err = erofs_nbd_nl_reconnect(nbdnum, identifier);
+	err = erofs_nbd_nl_reconnect(dev_id, identifier);
 	if (err >= 0) {
 		ctx.sk.fd = err;
 		if (fork() == 0) {
@@ -2191,7 +2191,7 @@ static int erofsmount_ublk(struct erofsmount_source *source,
 	}
 
 	if (pid == 0) {
-		struct erofsmount_nbd_ctx ctx = { .vd = &ctx._vd };
+		struct erofsmount_ctx ctx = { .vd = &ctx._vd };
 		struct erofs_ublk_dev_info info;
 		struct stat st;
 
@@ -2275,7 +2275,7 @@ static int erofsmount_ublk(struct erofsmount_source *source,
 int erofsmount_umount(char *target)
 {
 	char *device = NULL, *mountpoint = NULL;
-	int err, fd, nbdnum;
+	int err, fd, dev_id;
 	struct stat st;
 	FILE *mounts;
 	size_t n;
@@ -2347,19 +2347,22 @@ int erofsmount_umount(char *target)
 
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
@@ -2367,7 +2370,7 @@ int erofsmount_umount(char *target)
 				goto err_out;
 			}
 		}
-		err = erofs_ublk_del_dev_by_id(nbdnum);
+		err = erofs_ublk_del_dev_by_id(dev_id);
 		goto err_out;
 	}
 
@@ -2398,8 +2401,8 @@ int erofsmount_umount(char *target)
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
@@ -2413,7 +2416,7 @@ err_out:
 
 static int erofsmount_disconnect(const char *target)
 {
-	int nbdnum, err, fd;
+	int dev_id, err, fd;
 	struct stat st;
 
 	err = lstat(target, &st);
@@ -2423,8 +2426,8 @@ static int erofsmount_disconnect(const char *target)
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


