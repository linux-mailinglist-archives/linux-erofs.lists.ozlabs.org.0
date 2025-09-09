Return-Path: <linux-erofs+bounces-986-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FCBB4A30F
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Sep 2025 09:09:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cLZgh3DmSz3054;
	Tue,  9 Sep 2025 17:09:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.59
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757401760;
	cv=none; b=CTEERSdkmFqnnj2BZnG9hVmfCIF8/w92iSDFT5i5n5OipuFP/5mCxnAxygN7RM73bH+eD+g5LsVQ62ObSagsyZpxON4Ih0mvOwJpe6fnlb4ulq8lifAvFPClg5GQccXL5iY6+HN+W68TcWObhIvkelQ6eO4iC0DUb/mFA0QwK09e493OWrK8Fvc+Zrn15yvzNdh+kRa1R7TXUXlGKCNknMDjLYPhVu7rE62Zzezd7fjliNMnakYjUOcTT459z9vKo38R+IqP88yYK5bCrG5scWJ9ZqL4k5fFdhvswQDVlLEjJMaJ/3Z+mp7UKkyv33Z0rqOvbeA743RxZ364LeVQag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757401760; c=relaxed/relaxed;
	bh=CxOcvt87MYeAa7ZXlycZ0ZQFoqdZtp99OQ6MvQDuKkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dGdyFnkFq+Lbkhz4+A6ZR5ltjSJeru03jeHPyA5ifpIOF8utlPZ/U1UBu90F/hC/3Ls18ez5t0+JA7FVoTlu9kC/xMsax4gbnxWu2FUaaOP7Ee6NJA5h72/BD5SegjOPQqK7/qUqnyyVcHMzTw1cWZhd+T3NvrM0iqfqkGwtZG7wZ08ctJwVE9r+INEvpmSvvQCN7jejO7s9641BM7+VyoJ3q8GNZGFgMzbgAij5AkFJi1nrJgoMaDOiCeYTuw2ZJVm4qQQDLNRrSqhqHKihSJbyNJEZrmkEN4F9PYwUZlv/hBcVq1LFn9cTzbTZVKUjBKi+Iu705TlCPZ+nhWFEQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.59; helo=out28-59.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.59; helo=out28-59.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-59.mail.aliyun.com (out28-59.mail.aliyun.com [115.124.28.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cLZgf6X3yz2xPw
	for <linux-erofs@lists.ozlabs.org>; Tue,  9 Sep 2025 17:09:16 +1000 (AEST)
Received: from HUDSONZHU-MC1.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.eb-1jV3_1757401750 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 09 Sep 2025 15:09:11 +0800
From: ChengyuZhu6 <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH v1] erofs-utils:mount: add OCI recovery support for NBD reattach
Date: Tue,  9 Sep 2025 15:09:09 +0800
Message-ID: <20250909070909.83921-1-hudson@cyzhu.com>
X-Mailer: git-send-email 2.51.0
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

From: Chengyu Zhu <hudsonzhu@tencent.com>

This commit implements recovery support for OCI-based NBD mounts,
allowing the system to properly reattach NBD devices after
NBD disconnection.

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
---
 mount/main.c | 100 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 75 insertions(+), 25 deletions(-)

diff --git a/mount/main.c b/mount/main.c
index c52ac3b..37e9f6d 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -401,12 +401,14 @@ out_closefd:
 	return err;
 }
 
-static char *erofsmount_write_recovery_info(const char *source)
+static char *erofsmount_write_recovery_info(struct erofs_nbd_source *source)
 {
 	char recp[] = "/var/run/erofs/mountnbd_XXXXXX";
 	char *realp;
 	int fd, err;
 	FILE *f;
+	char *content = NULL;
+	int ret;
 
 	fd = mkstemp(recp);
 	if (fd < 0 && errno == ENOENT) {
@@ -424,15 +426,32 @@ static char *erofsmount_write_recovery_info(const char *source)
 		return ERR_PTR(-errno);
 	}
 
-	realp = realpath(source, NULL);
-	if (!realp) {
-		fclose(f);
-		return ERR_PTR(-errno);
+	if (source->type == EROFSNBD_SOURCE_OCI) {
+		ret = asprintf(&content, "%s %s %s %s %d",
+			       source->ocicfg.image_ref ?: "",
+			       source->ocicfg.platform ?: "",
+			       source->ocicfg.username ?: "",
+			       source->ocicfg.password ?: "",
+			       source->ocicfg.layer_index);
+		if (ret < 0) {
+			fclose(f);
+			return ERR_PTR(-ENOMEM);
+		}
+		err = fprintf(f, "OCI_LAYER %s\n", content) < 0;
+		free(content);
+	} else {
+		realp = realpath(source->device_path, NULL);
+		if (!realp) {
+			fclose(f);
+			return ERR_PTR(-errno);
+		}
+
+		/* TYPE<LOCAL> <SOURCE PATH>\n(more..) */
+		err = fprintf(f, "LOCAL %s\n", realp) < 0;
+		free(realp);
 	}
-	/* TYPE<LOCAL> <SOURCE PATH>\n(more..) */
-	err = fprintf(f, "LOCAL %s\n", realp) < 0;
+
 	fclose(f);
-	free(realp);
 	if (err)
 		return ERR_PTR(-ENOMEM);
 	return strdup(recp) ?: ERR_PTR(-ENOMEM);
@@ -491,15 +510,10 @@ static int erofsmount_startnbd_nl(pid_t *pid, struct erofs_nbd_source *source)
 				exit(EXIT_FAILURE);
 			ctx.vd.fd = err;
 		}
-
-		if (source->type == EROFSNBD_SOURCE_LOCAL) {
-			recp = erofsmount_write_recovery_info(source->device_path);
-			if (IS_ERR(recp)) {
-				erofs_io_close(&ctx.vd);
-				exit(EXIT_FAILURE);
-			}
-		} else {
-			recp = NULL;
+		recp = erofsmount_write_recovery_info(source);
+		if (IS_ERR(recp)) {
+			erofs_io_close(&ctx.vd);
+			exit(EXIT_FAILURE);
 		}
 
 		num = -1;
@@ -595,19 +609,55 @@ static int erofsmount_reattach(const char *target)
 		*(source++) = '\0';
 	}
 
-	if (strcmp(line, "LOCAL")) {
+	if (!strcmp(line, "LOCAL")) {
+		err = open(source, O_RDONLY);
+		if (err < 0) {
+			err = -errno;
+			goto err_line;
+		}
+		ctx.vd.fd = err;
+	} else if (!strcmp(line, "OCI_LAYER")) {
+		struct ocierofs_config oci_cfg = {};
+		char *platform, *username, *password, *layer_str;
+		int layer_index;
+
+		platform = strchr(source, ' ');
+		if (platform) {
+			*platform++ = '\0';
+			oci_cfg.image_ref = source;
+			oci_cfg.platform = platform;
+		} else {
+			oci_cfg.image_ref = source;
+		}
+
+		username = strchr(platform ?: source, ' ');
+		if (username) {
+			*username++ = '\0';
+			oci_cfg.username = username;
+		}
+
+		password = strchr(username ?: (platform ?: source), ' ');
+		if (password) {
+			*password++ = '\0';
+			oci_cfg.password = password;
+		}
+
+		layer_str = strchr(password ?: (username ?: (platform ?: source)), ' ');
+		if (layer_str) {
+			*layer_str++ = '\0';
+			layer_index = atoi(layer_str);
+			oci_cfg.layer_index = layer_index;
+		}
+
+		err = ocierofs_io_open(&ctx.vd, &oci_cfg);
+		if (err < 0)
+			goto err_line;
+	} else {
 		err = -EOPNOTSUPP;
 		erofs_err("unsupported source type %s recorded in recovery file", line);
 		goto err_line;
 	}
 
-	err = open(source, O_RDONLY);
-	if (err < 0) {
-		err = -errno;
-		goto err_line;
-	}
-	ctx.vd.fd = err;
-
 	err = erofs_nbd_nl_reconnect(nbdnum, identifier);
 	if (err >= 0) {
 		ctx.sk.fd = err;
-- 
2.51.0


