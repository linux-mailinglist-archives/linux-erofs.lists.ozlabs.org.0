Return-Path: <linux-erofs+bounces-3117-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mwr4NTVwymkF9AUAu9opvQ
	(envelope-from <linux-erofs+bounces-3117-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 14:44:37 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A59C35B391
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 14:44:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkrYF3Cwvz2xpt;
	Mon, 30 Mar 2026 23:44:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.218
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774874673;
	cv=none; b=TZdSff/yPb+L0s/oTfxbc05E13K9hH25ttUG6dEI84X6eZ0+RAn12fANd/5YLHrGYQ2VVHt9fWM5DtQrHKDgjAHznSXOslC1J4JBKYf4quR4sNPY9Oo6U+MtR8hRLLQN1RNmEIDoGRraJz8VaoiqLaBHoB2z4p/HsRI5AfidVDermfKBtC5pBhw3vAW4lWM4buewMk8Dc8dNazUR/3MVQR5QqaJodHskSYZBbwDsdZV+PPFza8nh/v8ztP1Vw4QchKu9YWUER1avaH1mnvcG+twJOJHd9348TZ02g3FamoK3IRayzu6QXQ//YLtJWW1kOJla4atajDuo9d6J3FZb9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774874673; c=relaxed/relaxed;
	bh=NDZzd54xSBelgYoQEbtkuSXuOFCnzgwQe59OAY4fFH4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=STl4R67ixZ1ENETmUM3qMzXx5c0s6l7xA7ozoX36ybgaPAF2J864zn2UFBSVzKjOj/iMRI3bX3MPy+ljlWrN/Y6hDOeJPs1RbsSFLBBVlO1vWyuoGCcTPrblhUvE215MlqLfCvj1bZXeA4Nv8H52WTqqvIsWHq7Eb41MsQ9C8jFQ4m/cfL1eM3owfC17hAvQl+qQh2iH75cvtHmIx2qtdA/psNurtaRSM2nDCf9TmSQUzsmuTSpdhAceRolz10Dhg6eSn/s5SHorERdXWtzEv+9M0eEQ6AopKFRzOh1ccvq3o5m3y4cy06FlY4V1PrqXtELpoDuq0DEQzn/83B6x9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=bb5FAKsL; dkim-atps=neutral; spf=pass (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=bb5FAKsL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkrYB3Zqzz2xlK
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 23:44:29 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=NDZzd54xSBelgYoQEbtkuSXuOFCnzgwQe59OAY4fFH4=;
	b=bb5FAKsLFIdAHn+dHzkufWVfaSk8UqkBHw9quUKce2ct1O60zXyXKo2lZ3Yq6AMqVayQLMOIH
	otjBCTKhsAgziuTYTkdxtBVzUVww1P9kZ6O7H7iUdeCQ52+v/UtHspbYbrx+lTmXCdcR54OOVP2
	INfKeG5axUzKHg/DNLqff0Q=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fkrQP5KYWzpStK;
	Mon, 30 Mar 2026 20:38:37 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 7D4D240561;
	Mon, 30 Mar 2026 20:44:22 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 30 Mar
 2026 20:44:21 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <hsiangkao@linux.alibaba.com>, <jingrui@huawei.com>,
	<zhukeqian1@huawei.com>, <zhaoyifan28@huawei.com>, <hudsonzhu@tencent.com>
Subject: [PATCH 1/2 RESEND] erofs-utils: mount: generalize nbd source types for multi-backend support
Date: Mon, 30 Mar 2026 20:44:01 +0800
Message-ID: <20260330124402.899394-1-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.47.3
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
Content-Type: text/plain
X-Originating-IP: [10.50.159.234]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3117-lists,linux-erofs=lfdr.de];
	TO_DN_NONE(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	HAS_XOIP(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:mid,tencent.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 2A59C35B391
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chengyu Zhu <hudsonzhu@tencent.com>

Rename nbd-specific source type names to generic mount-level names in
preparation for adding ublk backend support.

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
---
Note: This is a former patch authored by Chengyu Zhu.

 mount/main.c | 52 ++++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/mount/main.c b/mount/main.c
index 3ef4e9c..350738d 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -71,18 +71,18 @@ static struct erofsmount_cfg {
 	.fstype = "erofs",
 };
 
-enum erofs_nbd_source_type {
-	EROFSNBD_SOURCE_LOCAL,
-	EROFSNBD_SOURCE_OCI,
+enum erofsmount_source_type {
+	EROFSMOUNT_SOURCE_LOCAL,
+	EROFSMOUNT_SOURCE_OCI,
 };
 
-static struct erofs_nbd_source {
-	enum erofs_nbd_source_type type;
+static struct erofsmount_source {
+	enum erofsmount_source_type type;
 	union {
 		const char *device_path;
 		struct ocierofs_config ocicfg;
 	};
-} nbdsrc;
+} mountsrc;
 
 static void usage(int argc, char **argv)
 {
@@ -122,7 +122,7 @@ static void version(void)
 #ifdef OCIEROFS_ENABLED
 static int erofsmount_parse_oci_option(const char *option)
 {
-	struct ocierofs_config *oci_cfg = &nbdsrc.ocicfg;
+	struct ocierofs_config *oci_cfg = &mountsrc.ocicfg;
 	const char *p;
 	long idx;
 
@@ -229,12 +229,12 @@ static long erofsmount_parse_flagopts(char *s, long flags, char **more)
 		if (!strcmp(s, "loop")) {
 			mountcfg.force_loopdev = true;
 		} else if (strncmp(s, "oci", 3) == 0) {
-			/* Initialize ocicfg here iff != EROFSNBD_SOURCE_OCI */
-			if (nbdsrc.type != EROFSNBD_SOURCE_OCI) {
+			/* Initialize ocicfg here iff != EROFSMOUNT_SOURCE_OCI */
+			if (mountsrc.type != EROFSMOUNT_SOURCE_OCI) {
 				erofs_warn("EXPERIMENTAL OCI mount support in use, use at your own risk.");
 				erofs_warn("Note that runtime performance is still unoptimized.");
-				nbdsrc.type = EROFSNBD_SOURCE_OCI;
-				nbdsrc.ocicfg.layer_index = -1;
+				mountsrc.type = EROFSMOUNT_SOURCE_OCI;
+				mountsrc.ocicfg.layer_index = -1;
 			}
 			err = erofsmount_parse_oci_option(s);
 			if (err < 0)
@@ -288,7 +288,7 @@ static int erofsmount_parse_options(int argc, char **argv)
 	int opt;
 	int i;
 
-	nbdsrc.ocicfg.layer_index = -1;
+	mountsrc.ocicfg.layer_index = -1;
 
 	while ((opt = getopt_long(argc, argv, "VNfhd:no:st:uv",
 				  long_options, NULL)) != -1) {
@@ -664,14 +664,14 @@ out:
 	return (void *)(uintptr_t)err;
 }
 
-static int erofsmount_startnbd(int nbdfd, struct erofs_nbd_source *source)
+static int erofsmount_startnbd(int nbdfd, struct erofsmount_source *source)
 {
 	struct erofsmount_nbd_ctx ctx = {};
 	uintptr_t retcode;
 	pthread_t th;
 	int err, err2;
 
-	if (source->type == EROFSNBD_SOURCE_OCI) {
+	if (source->type == EROFSMOUNT_SOURCE_OCI) {
 		if (source->ocicfg.tarindex_path || source->ocicfg.zinfo_path) {
 			err = erofsmount_tarindex_open(&ctx.vd, &source->ocicfg,
 						       source->ocicfg.tarindex_path,
@@ -720,7 +720,7 @@ out_closefd:
 }
 
 #ifdef OCIEROFS_ENABLED
-static int erofsmount_write_recovery_oci(FILE *f, struct erofs_nbd_source *source)
+static int erofsmount_write_recovery_oci(FILE *f, struct erofsmount_source *source)
 {
 	char *b64cred = NULL;
 	const char *platform;
@@ -774,13 +774,13 @@ static int erofsmount_write_recovery_oci(FILE *f, struct erofs_nbd_source *sourc
 	return -EINVAL;
 }
 #else
-static int erofsmount_write_recovery_oci(FILE *f, struct erofs_nbd_source *source)
+static int erofsmount_write_recovery_oci(FILE *f, struct erofsmount_source *source)
 {
 	return -EOPNOTSUPP;
 }
 #endif
 
-static int erofsmount_write_recovery_local(FILE *f, struct erofs_nbd_source *source)
+static int erofsmount_write_recovery_local(FILE *f, struct erofsmount_source *source)
 {
 	char *realp;
 	int err;
@@ -795,7 +795,7 @@ static int erofsmount_write_recovery_local(FILE *f, struct erofs_nbd_source *sou
 	return err ? -ENOMEM : 0;
 }
 
-static char *erofsmount_write_recovery_info(struct erofs_nbd_source *source)
+static char *erofsmount_write_recovery_info(struct erofsmount_source *source)
 {
 	char recp[] = "/var/run/erofs/mountnbd_XXXXXX";
 	int fd, err;
@@ -817,7 +817,7 @@ static char *erofsmount_write_recovery_info(struct erofs_nbd_source *source)
 		return ERR_PTR(-errno);
 	}
 
-	if (source->type == EROFSNBD_SOURCE_OCI)
+	if (source->type == EROFSMOUNT_SOURCE_OCI)
 		err = erofsmount_write_recovery_oci(f, source);
 	else
 		err = erofsmount_write_recovery_local(f, source);
@@ -1026,7 +1026,7 @@ static int erofsmount_nbd_fix_backend_linkage(int num, char **recp)
 	return 0;
 }
 
-static int erofsmount_startnbd_nl(pid_t *pid, struct erofs_nbd_source *source)
+static int erofsmount_startnbd_nl(pid_t *pid, struct erofsmount_source *source)
 {
 	int pipefd[2], err, num;
 
@@ -1042,7 +1042,7 @@ static int erofsmount_startnbd_nl(pid_t *pid, struct erofs_nbd_source *source)
 		if (signal(SIGPIPE, SIG_IGN) == SIG_ERR)
 			exit(EXIT_FAILURE);
 
-		if (source->type == EROFSNBD_SOURCE_OCI) {
+		if (source->type == EROFSMOUNT_SOURCE_OCI) {
 			if (source->ocicfg.tarindex_path || source->ocicfg.zinfo_path) {
 				err = erofsmount_tarindex_open(&ctx.vd, &source->ocicfg,
 							       source->ocicfg.tarindex_path,
@@ -1201,7 +1201,7 @@ err_identifier:
 	return err;
 }
 
-static int erofsmount_nbd(struct erofs_nbd_source *source,
+static int erofsmount_nbd(struct erofsmount_source *source,
 			  const char *mountpoint, const char *fstype,
 			  int flags, const char *options)
 {
@@ -1524,11 +1524,11 @@ int main(int argc, char *argv[])
 	}
 
 	if (mountcfg.backend == EROFSNBD) {
-		if (nbdsrc.type == EROFSNBD_SOURCE_OCI)
-			nbdsrc.ocicfg.image_ref = mountcfg.device;
+		if (mountsrc.type == EROFSMOUNT_SOURCE_OCI)
+			mountsrc.ocicfg.image_ref = mountcfg.device;
 		else
-			nbdsrc.device_path = mountcfg.device;
-		err = erofsmount_nbd(&nbdsrc, mountcfg.target,
+			mountsrc.device_path = mountcfg.device;
+		err = erofsmount_nbd(&mountsrc, mountcfg.target,
 				     mountcfg.fstype, mountcfg.flags, mountcfg.options);
 		goto exit;
 	}
-- 
2.47.3


