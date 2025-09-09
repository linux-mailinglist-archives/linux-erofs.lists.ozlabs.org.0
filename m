Return-Path: <linux-erofs+bounces-996-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BE4B4AA9E
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Sep 2025 12:28:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cLg5B33M2z30DX;
	Tue,  9 Sep 2025 20:28:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.79
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757413694;
	cv=none; b=dCzQ7AL0rsf14MS5jmnwSvUAlFfz7ubgTw2Nu6mEyOFMjjDDeagS9DqzkkMy0a1UjURvfBsu/FP7qIEO+AVgDT5vkX1xGwLM7SUDzKERYxIoCkivklPIgYq0YhVRJaapeOIA2wqfYN8kfM0O7uSS6PgQT0UUXcnGlrdHeZzwNzNEGd8Rx+y7B4eTBh7JmZcX5QMeGTiUit7onTH1wUtIC6Ijwb1HzzFo5KHXspnfio9b6z3AiJ8lX5xXG0Sv5mZBRQgqPZvMw2tBgs2IszVvdZM+zjq1C1gSC/WF4Qyx7cCSCvJk8stMdFggRLv3F0l0wA1SXW/mmAybpYdu+Kezuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757413694; c=relaxed/relaxed;
	bh=NjhDaRv/3vG7+O1eKhZKPkmvecWilNQOyeGxk5bhT/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kk5T6lSnmKEShnt3lb3vonwoZYDFVJxrZbeP5KTt4SkxKZdq6W4hTO/bBQGe+DMGzWbBpEtD4ExVdV6P+kMWbtBvdYqHFvJ1fnJ5tbGqj/zGl4Qs5o48WbnRiK/935YDPg3HEf7mhOPWiO3OmH3Wrl/sJ2UmergWmFYJLtS3OldO0kdMeFG+aPhLIqIoKf03dCe5asdeQXOJsSFC9E+YMjW1bfycAziQyJYfHUuAgzEDJ5dkB3Y5XaSOHkNRklWO+RcZiYYZOD4tcis1CxRXt3/kfKbdoWAy4XpCFrtl474gUCvI+LnxFsLUtLzV9pgWA9qjaHKAQdw2HQx84Fmg/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.79; helo=out28-79.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.79; helo=out28-79.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-79.mail.aliyun.com (out28-79.mail.aliyun.com [115.124.28.79])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cLg585vvjz2yr8
	for <linux-erofs@lists.ozlabs.org>; Tue,  9 Sep 2025 20:28:10 +1000 (AEST)
Received: from HUDSONZHU-MC1.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.eb8ypGG_1757413682 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 09 Sep 2025 18:28:03 +0800
From: ChengyuZhu6 <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH v3] erofs-utils: mount: add OCI recovery support for NBD reattach
Date: Tue,  9 Sep 2025 18:28:01 +0800
Message-ID: <20250909102801.90540-1-hudson@cyzhu.com>
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
 lib/liberofs_oci.h |   5 ++
 lib/remotes/oci.c  | 129 +++++++++++++++++++++++++++++++++++++++++
 mount/main.c       | 141 ++++++++++++++++++++++++++++++++++++---------
 3 files changed, 247 insertions(+), 28 deletions(-)

diff --git a/lib/liberofs_oci.h b/lib/liberofs_oci.h
index 01a83aa..e910e6a 100644
--- a/lib/liberofs_oci.h
+++ b/lib/liberofs_oci.h
@@ -71,6 +71,11 @@ int ocierofs_build_trees(struct erofs_importer *importer,
 			 const struct ocierofs_config *cfg);
 int ocierofs_io_open(struct erofs_vfile *vf, const struct ocierofs_config *cfg);
 
+int ocierofs_b64_encode_userpass(const char *username, const char *password,
+				 char **out_b64);
+int ocierofs_b64_decode_userpass(const char *b64,
+				 char **out_user, char **out_pass);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
index de18daa..4e46e0b 100644
--- a/lib/remotes/oci.c
+++ b/lib/remotes/oci.c
@@ -1471,6 +1471,135 @@ int ocierofs_io_open(struct erofs_vfile *vfile, const struct ocierofs_config *cf
 	*(struct ocierofs_iostream **)vfile->payload = oci_iostream;
 	return 0;
 }
+
+static const char ocierofs_b64_tbl[] =
+	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
+
+int ocierofs_b64_encode_userpass(const char *username, const char *password,
+				 char **out_b64)
+{
+	const unsigned char *in;
+	size_t ulen = username ? strlen(username) : 0;
+	size_t plen = password ? strlen(password) : 0;
+	size_t inlen = ulen + 1 + plen;
+	size_t outlen;
+	unsigned char *buf;
+	char *out;
+	size_t i, j;
+	unsigned int octet_a, octet_b, octet_c, triple;
+
+	if (!out_b64)
+		return -EINVAL;
+	*out_b64 = NULL;
+
+	buf = malloc(inlen + 1);
+	if (!buf)
+		return -ENOMEM;
+	memcpy(buf, username ? username : "", ulen);
+	buf[ulen] = ':';
+	memcpy(buf + ulen + 1, password ? password : "", plen);
+	buf[inlen] = '\0';
+	in = buf;
+
+	outlen = 4 * ((inlen + 2) / 3);
+	out = malloc(outlen + 1);
+	if (!out) {
+		free(buf);
+		return -ENOMEM;
+	}
+
+	for (i = 0, j = 0; i < inlen;) {
+		octet_a = i < inlen ? in[i++] : 0;
+		octet_b = i < inlen ? in[i++] : 0;
+		octet_c = i < inlen ? in[i++] : 0;
+		triple = (octet_a << 16) | (octet_b << 8) | octet_c;
+		out[j++] = ocierofs_b64_tbl[(triple >> 18) & 0x3F];
+		out[j++] = ocierofs_b64_tbl[(triple >> 12) & 0x3F];
+		out[j++] = (i - 1 > inlen) ? '=' : ocierofs_b64_tbl[(triple >> 6) & 0x3F];
+		out[j++] = (i > inlen) ? '=' : ocierofs_b64_tbl[triple & 0x3F];
+	}
+	if (inlen % 3 == 1) {
+		out[outlen - 1] = '=';
+		out[outlen - 2] = '=';
+	} else if (inlen % 3 == 2) {
+		out[outlen - 1] = '=';
+	}
+	out[outlen] = '\0';
+	free(buf);
+	*out_b64 = out;
+	return 0;
+}
+
+static int ocierofs_b64_inv(int c)
+{
+	if (c >= 'A' && c <= 'Z')
+		return c - 'A';
+	if (c >= 'a' && c <= 'z')
+		return c - 'a' + 26;
+	if (c >= '0' && c <= '9')
+		return c - '0' + 52;
+	if (c == '+')
+		return 62;
+	if (c == '/')
+		return 63;
+	return -1;
+}
+
+int ocierofs_b64_decode_userpass(const char *b64,
+				 char **out_user, char **out_pass)
+{
+	size_t len, i, j;
+	unsigned char *out;
+	int val = 0, valb = -8, c;
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
+
+	for (i = 0, j = 0; i < len; i++) {
+		c = b64[i];
+
+		if (c == '=')
+			break;
+		c = ocierofs_b64_inv(c);
+		if (c < 0)
+			continue;
+		val = (val << 6) + c;
+		valb += 6;
+		if (valb >= 0) {
+			out[j++] = (unsigned char)((val >> valb) & 0xFF);
+			valb -= 8;
+		}
+	}
+	out[j] = '\0';
+
+	{
+		char *colon = (char *)memchr(out, ':', j);
+
+		if (!colon) {
+			free(out);
+			return -EINVAL;
+		}
+		*colon = '\0';
+		*out_user = strdup((char *)out);
+		*out_pass = strdup(colon + 1);
+		free(out);
+		if (!*out_user || !*out_pass) {
+			free(*out_user);
+			free(*out_pass);
+			*out_user = *out_pass = NULL;
+			return -ENOMEM;
+		}
+	}
+	return 0;
+}
+
 #else
 int ocierofs_io_open(struct erofs_vfile *vfile, const struct ocierofs_config *cfg)
 {
diff --git a/mount/main.c b/mount/main.c
index c52ac3b..4fe54c5 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -401,10 +401,48 @@ out_closefd:
 	return err;
 }
 
-static char *erofsmount_write_recovery_info(const char *source)
+static int erofsmount_write_recovery_oci(FILE *f, struct erofs_nbd_source *source)
+{
+	char *b64cred = NULL;
+	int ret;
+
+	if (source->ocicfg.username || source->ocicfg.password) {
+		ret = ocierofs_b64_encode_userpass(
+			source->ocicfg.username,
+			source->ocicfg.password,
+			&b64cred);
+		if (ret) {
+			fclose(f);
+			return ret;
+		}
+	}
+	ret = fprintf(f, "OCI_LAYER %s %s %s %d\n",
+		       source->ocicfg.image_ref ?: "",
+		       source->ocicfg.platform ?: "",
+		       b64cred ?: "",
+		       source->ocicfg.layer_index);
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
 
@@ -424,20 +462,62 @@ static char *erofsmount_write_recovery_info(const char *source)
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
 
+static int erofsmount_parse_recovery_ocilayer(struct ocierofs_config *oci_cfg,
+					      char *source)
+{
+	char *platform, *b64cred, *layer_str;
+	int err;
+	char *endptr;
+	unsigned long v;
+
+	platform = strchr(source, ' ');
+	if (platform) {
+		*platform++ = '\0';
+		oci_cfg->image_ref = source;
+		oci_cfg->platform = platform;
+	} else {
+		oci_cfg->image_ref = source;
+	}
+
+	b64cred = strchr(platform ?: source, ' ');
+	if (b64cred) {
+		*b64cred++ = '\0';
+		err = ocierofs_b64_decode_userpass(b64cred,
+						   &oci_cfg->username,
+						   &oci_cfg->password);
+		if (err)
+			return err;
+	}
+
+	layer_str = strchr(b64cred ?: (platform ?: source), ' ');
+	if (layer_str) {
+		*layer_str++ = '\0';
+		v = strtoul(layer_str, &endptr, 10);
+		if (endptr == layer_str || *endptr != '\0')
+			return -EINVAL;
+		oci_cfg->layer_index = (int)v;
+	}
+	return 0;
+}
+
 static int erofsmount_nbd_fix_backend_linkage(int num, char **recp)
 {
 	char *newrecp;
@@ -491,15 +571,10 @@ static int erofsmount_startnbd_nl(pid_t *pid, struct erofs_nbd_source *source)
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
@@ -595,19 +670,29 @@ static int erofsmount_reattach(const char *target)
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


