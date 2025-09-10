Return-Path: <linux-erofs+bounces-1014-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEF5B50F6C
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Sep 2025 09:31:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cMC6R0sD8z3d7n;
	Wed, 10 Sep 2025 17:31:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.58
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757489471;
	cv=none; b=oBtotpqrv9YJTExRiDBvjT6R1PBJto411prGJJCZ6b95GvSd6mYa/WXcNHfkehRx0pcmiQBzF8Bmz9bPTsWEp5gPWrgfVQhSifR8IMbnUcUxc/69YyLDQGkaMoLO7Vbr+bu+qEIfNFEoszvnuJQqENTn6BOEQDtVoMuIcWdWfEO6egIxn/hrcvqh8WmFMkNRDvyHDfPmJ1NQ/H9Xuig/pyGNLYMbUZNUZ9QcDpw6CNUVk/uDGnhNSXEjws21eV5C6hkcvuIKCWpRKrYnO0upkSjwe9rapJAvJ+ezITIiuDbSs9zs+Fxnjj7K7sI8R2eq+A1N3EiWbS0aKG0xwHkatQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757489471; c=relaxed/relaxed;
	bh=A2THRJe4QrqQ4B8v0niqAS4TKOwLI56Y4QAgnuwKXyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MVnpoT673SiB2A1h08EBiyxfZyI8NWLqqP0rCnEWNL5U2IIV2H26ykYbERkz9Z72r6shM6c54G1Pe1o6OlVkctRxgXR1MbUuy+dfcC1hXEXN24wP5bPuKSAyY6B2wgz3te/uCvEacOgNT6eVcHMuw1e704g2O8luYvWFc/Fx8P9XD51TQf9AEkkvyu8lTa1yVhIavtKBBssRvo0+4mZSZ/a4Lzv1WmwwE4s/7aNqlbhiZ0FM5lW58lSRRDFTN3jAAtGdO6yWysVFi8kfMpFYeiKYOzaWVOYyYYdS8cWnNVk/E3AGIjJ5ysNw9bHQ7hFvFX9Aiu4GpoigJqEKGq2jbg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.58; helo=out28-58.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.58; helo=out28-58.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-58.mail.aliyun.com (out28-58.mail.aliyun.com [115.124.28.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cMC6P3vn6z3d28
	for <linux-erofs@lists.ozlabs.org>; Wed, 10 Sep 2025 17:31:07 +1000 (AEST)
Received: from HUDSONZHU-MC1.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.ebsL8Xv_1757489459 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 10 Sep 2025 15:31:00 +0800
From: ChengyuZhu6 <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH v8] erofs-utils: mount: add OCI recovery support for NBD reattach
Date: Wed, 10 Sep 2025 15:30:58 +0800
Message-ID: <20250910073058.33296-1-hudson@cyzhu.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909070909.83921-1-hudson@cyzhu.com>
References: <20250909070909.83921-1-hudson@cyzhu.com>
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
 lib/liberofs_oci.h |   3 +
 lib/remotes/oci.c  |  66 +++++++++++++++++++++
 mount/main.c       | 143 ++++++++++++++++++++++++++++++++++++---------
 3 files changed, 184 insertions(+), 28 deletions(-)

diff --git a/lib/liberofs_oci.h b/lib/liberofs_oci.h
index 01a83aa..aa41141 100644
--- a/lib/liberofs_oci.h
+++ b/lib/liberofs_oci.h
@@ -71,6 +71,9 @@ int ocierofs_build_trees(struct erofs_importer *importer,
 			 const struct ocierofs_config *cfg);
 int ocierofs_io_open(struct erofs_vfile *vf, const struct ocierofs_config *cfg);
 
+char *ocierofs_encode_userpass(const char *username, const char *password);
+int ocierofs_decode_userpass(const char *b64, char **out_user, char **out_pass);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
index de18daa..937eed7 100644
--- a/lib/remotes/oci.c
+++ b/lib/remotes/oci.c
@@ -24,6 +24,7 @@
 #include "erofs/io.h"
 #include "erofs/print.h"
 #include "erofs/tar.h"
+#include "liberofs_base64.h"
 #include "liberofs_oci.h"
 #include "liberofs_private.h"
 
@@ -1471,6 +1472,71 @@ int ocierofs_io_open(struct erofs_vfile *vfile, const struct ocierofs_config *cf
 	*(struct ocierofs_iostream **)vfile->payload = oci_iostream;
 	return 0;
 }
+
+char *ocierofs_encode_userpass(const char *username, const char *password)
+{
+	char *buf;
+	char *out;
+	int ret;
+	size_t outlen;
+
+	ret = asprintf(&buf, "%s:%s", username ?: "", password ?: "");
+	if (ret == -1)
+		return ERR_PTR(-ENOMEM);
+	outlen = 4 * DIV_ROUND_UP(ret, 3);
+	out = malloc(outlen + 1);
+	if (!out) {
+		ret = -ENOMEM;
+	} else {
+		ret = erofs_base64_encode((unsigned char *)buf, ret, out);
+		if (ret < 0)
+			free(out);
+		out[ret] = '\0';
+	}
+	free(buf);
+	return ret < 0 ? ERR_PTR(ret) : out;
+}
+
+int ocierofs_decode_userpass(const char *b64, char **out_user, char **out_pass)
+{
+	size_t len;
+	unsigned char *out;
+	int ret;
+	char *colon;
+
+	if (!b64 || !out_user || !out_pass)
+		return -EINVAL;
+	*out_user = NULL;
+	*out_pass = NULL;
+
+	len = strlen(b64);
+	out = malloc(len * 3 / 4 + 1);
+	if (!out)
+		return -ENOMEM;
+	ret = erofs_base64_decode(b64, len, out);
+	if (ret < 0) {
+		free(out);
+		return ret;
+	}
+	out[ret] = '\0';
+	colon = (char *)memchr(out, ':', ret);
+	if (!colon) {
+		free(out);
+		return -EINVAL;
+	}
+	*colon = '\0';
+	*out_user = strdup((char *)out);
+	*out_pass = strdup(colon + 1);
+	free(out);
+	if (!*out_user || !*out_pass) {
+		free(*out_user);
+		free(*out_pass);
+		*out_user = *out_pass = NULL;
+		return -ENOMEM;
+	}
+	return 0;
+}
+
 #else
 int ocierofs_io_open(struct erofs_vfile *vfile, const struct ocierofs_config *cfg)
 {
diff --git a/mount/main.c b/mount/main.c
index c52ac3b..a759689 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -401,10 +401,45 @@ out_closefd:
 	return err;
 }
 
-static char *erofsmount_write_recovery_info(const char *source)
+static int erofsmount_write_recovery_oci(FILE *f, struct erofs_nbd_source *source)
+{
+	char *b64cred = NULL;
+	int ret;
+
+	if (source->ocicfg.username || source->ocicfg.password) {
+		b64cred = ocierofs_encode_userpass(
+			source->ocicfg.username,
+			source->ocicfg.password);
+		if (IS_ERR(b64cred))
+			return PTR_ERR(b64cred);
+	}
+	ret = fprintf(f, "OCI_LAYER %s %s %d %s\n",
+		       source->ocicfg.image_ref ?: "",
+		       source->ocicfg.platform ?: "",
+		       source->ocicfg.layer_index,
+		       b64cred ?: "");
+	free(b64cred);
+	return ret < 0 ? -ENOMEM : 0;
+}
+
+static int erofsmount_write_recovery_local(FILE *f, struct erofs_nbd_source *source)
 {
-	char recp[] = "/var/run/erofs/mountnbd_XXXXXX";
 	char *realp;
+	int err;
+
+	realp = realpath(source->device_path, NULL);
+	if (!realp)
+		return -errno;
+
+	/* TYPE<LOCAL> <SOURCE PATH>\n(more..) */
+	err = fprintf(f, "LOCAL %s\n", realp) < 0;
+	free(realp);
+	return err ? -ENOMEM : 0;
+}
+
+static char *erofsmount_write_recovery_info(struct erofs_nbd_source *source)
+{
+	char recp[] = "/var/run/erofs/mountnbd_XXXXXX";
 	int fd, err;
 	FILE *f;
 
@@ -424,20 +459,67 @@ static char *erofsmount_write_recovery_info(const char *source)
 		return ERR_PTR(-errno);
 	}
 
-	realp = realpath(source, NULL);
-	if (!realp) {
-		fclose(f);
-		return ERR_PTR(-errno);
+	if (source->type == EROFSNBD_SOURCE_OCI) {
+		err = erofsmount_write_recovery_oci(f, source);
+		if (err) {
+			fclose(f);
+			return ERR_PTR(err);
+		}
+	} else {
+		err = erofsmount_write_recovery_local(f, source);
+		if (err) {
+			fclose(f);
+			return ERR_PTR(err);
+		}
 	}
-	/* TYPE<LOCAL> <SOURCE PATH>\n(more..) */
-	err = fprintf(f, "LOCAL %s\n", realp) < 0;
+
 	fclose(f);
-	free(realp);
-	if (err)
-		return ERR_PTR(-ENOMEM);
 	return strdup(recp) ?: ERR_PTR(-ENOMEM);
 }
 
+/**
+ * Parses input string in format: "image_ref platform layer [b64cred]"
+ */
+static int erofsmount_parse_recovery_ocilayer(struct ocierofs_config *oci_cfg,
+					      char *source)
+{
+	char *tokens[4] = {0};
+	int token_count = 0;
+	char *p = source;
+	int err;
+	char *endptr;
+	unsigned long v;
+
+	while (token_count < 4 && (p = strchr(p, ' ')) != NULL) {
+		*p++ = '\0';
+		while (*p == ' ')
+			p++;
+		if (*p == '\0')
+			break;
+		tokens[token_count++] = p;
+	}
+
+	if (token_count < 2)
+		return -EINVAL;
+
+	oci_cfg->image_ref = source;
+	oci_cfg->platform = tokens[0];
+
+	v = strtoul(tokens[1], &endptr, 10);
+	if (endptr == tokens[1] || *endptr != '\0')
+		return -EINVAL;
+	oci_cfg->layer_index = (int)v;
+
+	if (token_count > 2) {
+		err = ocierofs_decode_userpass(tokens[2], &oci_cfg->username,
+					       &oci_cfg->password);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int erofsmount_nbd_fix_backend_linkage(int num, char **recp)
 {
 	char *newrecp;
@@ -491,15 +573,10 @@ static int erofsmount_startnbd_nl(pid_t *pid, struct erofs_nbd_source *source)
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
@@ -595,19 +672,29 @@ static int erofsmount_reattach(const char *target)
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
+
+		err = erofsmount_parse_recovery_ocilayer(&oci_cfg, source);
+		if (err)
+			goto err_line;
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


