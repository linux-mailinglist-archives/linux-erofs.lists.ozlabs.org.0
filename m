Return-Path: <linux-erofs+bounces-2702-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KaTHvPBtmkWHwEAu9opvQ
	(envelope-from <linux-erofs+bounces-2702-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Mar 2026 15:28:03 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E15291058
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Mar 2026 15:28:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fYgYV6pWLz2yZ6;
	Mon, 16 Mar 2026 01:27:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773584878;
	cv=none; b=NNRMjyctuzxKwjTVV5vS4KHkA5OWtpR7KssKcd9syJffz2Xo7IJDD2U3efongzdngrda/jmDEByB0Dww6zkAHGD37DYp/wPaTSSGdIMHgJ5PeHB9XyLvaVqJx14SfXfrf99omdz13lzhKSSVDbdSxxUywwFvNzSYPj/Q2P983KU+a8qX7SgWpcAYtDuKa/zTi7dgEp4PLrOQVV1SC8eSES1iGVfhHRNy13a6HNId17ulBAZTBXWHPQrNWhlNTLm8D/6eDvnt4quIKi3S8MKU/3tHCE2s6QaY5MSHPIoqRklBw/3T47kfQETgLDeX62roZtKY0VpbGozU3zYELQlrpg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773584878; c=relaxed/relaxed;
	bh=LQOx7jCZcdxUizBOr0bONoTjggb8r5D8dmuCbSaJ7oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RvR8nloark9DYN3cwHbPWUmVlpi5niKI30WDff2s1zYs3yLAUsHjLNwtl7VnF2LDE7e6dp7Qw5ojRmztk5R6Y3UVh3VQ6jMFP/LvteFNtisVlNg5TETaL6jh2sv7iGxbeQ1lTKDo/OooFELdwjO/8EJbM8hJy1BD9NElbrFwZqL6jC75pOdNyG02VuqBZ8z1m1xHAfHkoAOPB9wN0zv1CqhZqLcP9GtL712aB9i6jUo7fMzDViVSrL+Q/W0Byf/GaCESmJuonhF6xjjbvAJ/vK1T746RCGEdsEDtqd3IM6IxRPjALXnB149JL1+YpeoXwuQxMCxdI2Dn0EhKgSv43g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.55; helo=out28-55.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.55; helo=out28-55.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-55.mail.aliyun.com (out28-55.mail.aliyun.com [115.124.28.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fYgYS5B4Mz2xlM
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 01:27:55 +1100 (AEDT)
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0512903-0.000417864-0.948292;FP=11402946485420000946|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037032089;MF=hudson@cyzhu.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.gsmlGyN_1773584868;
Received: from HUDSONZHU-MB0.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.gsmlGyN_1773584868 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 15 Mar 2026 22:27:48 +0800
From: Chengyu <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH 1/4] erofs-utils: mount: generalize nbd source types for multi-backend support
Date: Sun, 15 Mar 2026 22:27:42 +0800
Message-ID: <20260315142745.56845-2-hudson@cyzhu.com>
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
X-Spam-Status: No, score=0.0 required=3.0 tests=SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [0.00 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2702-lists,linux-erofs=lfdr.de];
	DMARC_NA(0.00)[cyzhu.com];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	NEURAL_HAM(-0.00)[-0.935];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[hudson@cyzhu.com,linux-erofs@lists.ozlabs.org];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,cyzhu.com:mid]
X-Rspamd-Queue-Id: E4E15291058
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chengyu Zhu <hudsonzhu@tencent.com>

Rename nbd-specific source type names to generic mount-level names in
preparation for adding ublk backend support.

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
---
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
2.47.1


