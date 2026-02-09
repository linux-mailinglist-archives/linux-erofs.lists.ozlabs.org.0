Return-Path: <linux-erofs+bounces-2279-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJbzBquSiWlz+wQAu9opvQ
	(envelope-from <linux-erofs+bounces-2279-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 09 Feb 2026 08:54:19 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C797E10CA55
	for <lists+linux-erofs@lfdr.de>; Mon, 09 Feb 2026 08:54:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f8cQv0QPYz2yFm;
	Mon, 09 Feb 2026 18:54:15 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770623654;
	cv=none; b=LILhoGPJbznBPkpNcXphZk9OpqHtwvk+HKuDwnsDxuZ7UMkOm4fprTx5lLpF9r8IghBWeJqA+ihRouubaXOAkOJHxgvCUXjfW950JCV19O+5Yj6Tfp5pIyMn/w/nUuA86+U1ZyRkOQF1Xm1HIEtNEYQXGMlIV2rfugalrAXbsKToikvbyNgmQsZwcqRhyJbGfJ5T91RuUlFrVkpK3f//2q8qadBJTHyDCl738yaZDbLEpYnrWsAP46wAavrHRD1afz/nfH6Va0y6BtLkSJjjaQWQi91LAA2WHusyBZIqYit2aDX4DaQBOPQmSY+65RfAfXBAxAUU/bBRIhsJ9Lq5fg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770623654; c=relaxed/relaxed;
	bh=3lyWIRGR47+x/vNQHKgTQu+AZtT0VEklis/PbKbVBO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SAwcrPkZgD7P8YQ7bHgisD/tttXtYe0wJ0f7lnsOnM8WrPDjyPWb2L/TZ8CF49ToUq39jZbVCRTERGU6A0q2YrZthP733YTaEuSutzWYR6dKU+bKkVUTt0Chnkh/DHZ7+JpzDzft02v7DL56Z3Li31lFCXZyIt/zoBVo6EtxKuJ2l5LhzJ306FdoI/E/OexFkZ7Tof05Oh/BICh/32z5oGgM8BPy4icauEWxyvg8XCfwHaC4jLT5m/uG2k4fJUYChyMSHkinJh9wBUj26MFCELxqYAhZkClXCLA1TlPosCXN500NThIcELfb5yw0h0y8YblYanK8bAFGq0TBELToUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.55; helo=out28-55.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.55; helo=out28-55.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-55.mail.aliyun.com (out28-55.mail.aliyun.com [115.124.28.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f8cQr4LPHz2xc8
	for <linux-erofs@lists.ozlabs.org>; Mon, 09 Feb 2026 18:54:08 +1100 (AEDT)
Received: from HUDSONZHU-MC1.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.gStoIi9_1770623638 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 09 Feb 2026 15:53:59 +0800
From: ChengyuZhu6 <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH 1/1] erofs-utils: lib: oci: support reading credentials from docker config
Date: Mon,  9 Feb 2026 15:53:55 +0800
Message-ID: <20260209075355.16969-1-hudson@cyzhu.com>
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
X-Spam-Status: No, score=0.0 required=3.0 tests=SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.00 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2279-lists,linux-erofs=lfdr.de];
	DMARC_NA(0.00)[cyzhu.com];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	NEURAL_HAM(-0.00)[-0.795];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[hudson@cyzhu.com,linux-erofs@lists.ozlabs.org];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cyzhu.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: C797E10CA55
X-Rspamd-Action: no action

From: Chengyu Zhu <hudsonzhu@tencent.com>

This patch adds support for reading authentication credentials from
Docker's `config.json` (typically in `~/.docker/config.json` or via
`DOCKER_CONFIG`).

If no username/password is provided via command-line arguments, the
implementation will attempt to look up the registry in the docker config
file and use the stored credentials if found.

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
---
 lib/Makefile.am             |   2 +-
 lib/liberofs_dockerconfig.h |  28 +++++
 lib/remotes/docker_config.c | 243 ++++++++++++++++++++++++++++++++++++
 lib/remotes/oci.c           |  18 ++-
 4 files changed, 286 insertions(+), 5 deletions(-)
 create mode 100644 lib/liberofs_dockerconfig.h
 create mode 100644 lib/remotes/docker_config.c

diff --git a/lib/Makefile.am b/lib/Makefile.am
index 817f69a..7a65b2c 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -95,7 +95,7 @@ liberofs_la_LDFLAGS += ${liburing_LIBS}
 liberofs_la_SOURCES += backends/ublk.c
 endif
 endif
-liberofs_la_SOURCES += remotes/oci.c
+liberofs_la_SOURCES += remotes/oci.c remotes/docker_config.c
 liberofs_la_CFLAGS += ${json_c_CFLAGS}
 liberofs_la_LDFLAGS += ${json_c_LIBS}
 liberofs_la_SOURCES += gzran.c
diff --git a/lib/liberofs_dockerconfig.h b/lib/liberofs_dockerconfig.h
new file mode 100644
index 0000000..9a84592
--- /dev/null
+++ b/lib/liberofs_dockerconfig.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
+/*
+ * Copyright (C) 2026 Tencent, Inc.
+ *             http://www.tencent.com/
+ */
+#ifndef __EROFS_DOCKER_CONFIG_H
+#define __EROFS_DOCKER_CONFIG_H
+
+#define DOCKER_REGISTRY "docker.io"
+#define DOCKER_API_REGISTRY "registry-1.docker.io"
+#define DOCKER_HUB_AUTH_KEY "https://index.docker.io/v1/"
+
+struct erofs_docker_credential {
+	char *username;
+	char *password;
+};
+
+/**
+ * erofs_docker_config_lookup - look up registry credentials from Docker config
+ * @registry: the registry hostname (e.g. "index.docker.io")
+ * @cred: output credential structure
+ */
+int erofs_docker_config_lookup(const char *registry,
+			       struct erofs_docker_credential *cred);
+
+void erofs_docker_credential_free(struct erofs_docker_credential *cred);
+
+#endif
diff --git a/lib/remotes/docker_config.c b/lib/remotes/docker_config.c
new file mode 100644
index 0000000..9f039e4
--- /dev/null
+++ b/lib/remotes/docker_config.c
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
+/*
+ * Copyright (C) 2026 Tencent, Inc.
+ *             http://www.tencent.com/
+ */
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+
+#ifdef HAVE_JSON_C_JSON_H
+#include <json-c/json.h>
+#endif
+
+#include "erofs/defs.h"
+#include "erofs/print.h"
+#include "liberofs_base64.h"
+#include "liberofs_dockerconfig.h"
+
+#ifndef HAVE_JSON_C_JSON_H
+
+int erofs_docker_config_lookup(const char *registry,
+			       struct erofs_docker_credential *cred)
+{
+	(void)registry;
+	(void)cred;
+	return -EOPNOTSUPP;
+}
+
+void erofs_docker_credential_free(struct erofs_docker_credential *cred)
+{
+	(void)cred;
+}
+
+#else /* HAVE_JSON_C_JSON_H */
+
+static char *docker_config_path(void)
+{
+	const char *dir;
+	char *path = NULL;
+
+	dir = getenv("DOCKER_CONFIG");
+	if (dir && *dir) {
+		if (asprintf(&path, "%s/config.json", dir) < 0)
+			return NULL;
+		return path;
+	}
+
+	dir = getenv("HOME");
+	if (!dir || !*dir) {
+		erofs_dbg("HOME is not set, cannot locate docker config");
+		return NULL;
+	}
+
+	if (asprintf(&path, "%s/.docker/config.json", dir) < 0)
+		return NULL;
+	return path;
+}
+
+static char *read_file_to_string(const char *path)
+{
+	FILE *fp;
+	struct stat st;
+	char *buf;
+	size_t nread;
+
+	if (stat(path, &st) < 0)
+		return NULL;
+
+	if (st.st_size <= 0 || st.st_size > (1 << 22))
+		return NULL;
+
+	fp = fopen(path, "r");
+	if (!fp)
+		return NULL;
+
+	buf = malloc(st.st_size + 1);
+	if (!buf) {
+		fclose(fp);
+		return NULL;
+	}
+
+	nread = fread(buf, 1, st.st_size, fp);
+	fclose(fp);
+
+	if ((off_t)nread != st.st_size) {
+		free(buf);
+		return NULL;
+	}
+	buf[nread] = '\0';
+	return buf;
+}
+
+/*
+ * Check if @key (an auths entry key) matches @registry.
+ *
+ * For Docker Hub: @registry is docker.io or registry-1.docker.io.
+ * The auths key in config.json is always "https://index.docker.io/v1/".
+ * For other registries: the auths key is an exact match against @registry.
+ */
+static bool registry_match(const char *key, const char *registry)
+{
+	if (!key || !registry)
+		return false;
+
+	if (!strcasecmp(registry, DOCKER_REGISTRY) ||
+	    !strcasecmp(registry, DOCKER_API_REGISTRY))
+		return !strcmp(key, DOCKER_HUB_AUTH_KEY);
+
+	return !strcasecmp(key, registry);
+}
+
+static int decode_auth_field(const char *b64, char **out_user, char **out_pass)
+{
+	int b64_len = strlen(b64);
+	int decoded_max = b64_len;
+	u8 *decoded;
+	int decoded_len;
+	char *colon;
+
+	decoded = malloc(decoded_max + 1);
+	if (!decoded)
+		return -ENOMEM;
+
+	decoded_len = erofs_base64_decode(b64, b64_len, decoded);
+	if (decoded_len <= 0) {
+		free(decoded);
+		return -EINVAL;
+	}
+	decoded[decoded_len] = '\0';
+
+	colon = strchr((char *)decoded, ':');
+	if (!colon) {
+		memset(decoded, 0, decoded_len);
+		free(decoded);
+		return -EINVAL;
+	}
+
+	*colon = '\0';
+	*out_user = strdup((char *)decoded);
+	*out_pass = strdup(colon + 1);
+
+	memset(decoded, 0, decoded_len);
+	free(decoded);
+
+	if (!*out_user || !*out_pass) {
+		free(*out_user);
+		free(*out_pass);
+		*out_user = NULL;
+		*out_pass = NULL;
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+int erofs_docker_config_lookup(const char *registry,
+			       struct erofs_docker_credential *cred)
+{
+	char *path = NULL;
+	char *content = NULL;
+	struct json_object *root = NULL, *auths_obj = NULL;
+	int ret = -ENOENT;
+
+	memset(cred, 0, sizeof(*cred));
+
+	path = docker_config_path();
+	if (!path)
+		return -ENOENT;
+
+	content = read_file_to_string(path);
+	if (!content) {
+		erofs_dbg("cannot read docker config: %s", path);
+		free(path);
+		return -ENOENT;
+	}
+	free(path);
+
+	root = json_tokener_parse(content);
+	memset(content, 0, strlen(content));
+	free(content);
+
+	if (!root) {
+		erofs_warn("failed to parse docker config.json");
+		return -EINVAL;
+	}
+
+	if (!json_object_object_get_ex(root, "auths", &auths_obj)) {
+		erofs_dbg("no \"auths\" in docker config.json");
+		json_object_put(root);
+		return -ENOENT;
+	}
+
+	struct json_object_iterator it = json_object_iter_begin(auths_obj);
+	struct json_object_iterator end = json_object_iter_end(auths_obj);
+
+	while (!json_object_iter_equal(&it, &end)) {
+		const char *key = json_object_iter_peek_name(&it);
+		struct json_object *entry, *auth_field;
+		const char *b64;
+
+		if (!registry_match(key, registry)) {
+			json_object_iter_next(&it);
+			continue;
+		}
+
+		entry = json_object_iter_peek_value(&it);
+		if (json_object_object_get_ex(entry, "auth", &auth_field)) {
+			b64 = json_object_get_string(auth_field);
+			if (b64 && *b64) {
+				ret = decode_auth_field(b64, &cred->username,
+							&cred->password);
+				if (!ret)
+					erofs_dbg("found docker credentials for %s",
+						  registry);
+			}
+		}
+		break;
+	}
+
+	json_object_put(root);
+	return ret;
+}
+
+void erofs_docker_credential_free(struct erofs_docker_credential *cred)
+{
+	if (cred->username) {
+		memset(cred->username, 0, strlen(cred->username));
+		free(cred->username);
+		cred->username = NULL;
+	}
+	if (cred->password) {
+		memset(cred->password, 0, strlen(cred->password));
+		free(cred->password);
+		cred->password = NULL;
+	}
+}
+
+#endif /* HAVE_JSON_C_JSON_H */
diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
index fe5df29..48bf37f 100644
--- a/lib/remotes/oci.c
+++ b/lib/remotes/oci.c
@@ -30,6 +30,7 @@
 #include "erofs/tar.h"
 #include "liberofs_base64.h"
 #include "liberofs_oci.h"
+#include "liberofs_dockerconfig.h"
 #include "liberofs_private.h"
 #include "liberofs_gzran.h"
 
@@ -39,9 +40,6 @@
 
 #ifdef OCIEROFS_ENABLED
 
-#define DOCKER_REGISTRY "docker.io"
-#define DOCKER_API_REGISTRY "registry-1.docker.io"
-
 #define DOCKER_MEDIATYPE_MANIFEST_V2 \
 	"application/vnd.docker.distribution.manifest.v2+json"
 #define DOCKER_MEDIATYPE_MANIFEST_V1 \
@@ -985,9 +983,21 @@ static int ocierofs_find_layer_by_digest(struct ocierofs_ctx *ctx, const char *d
 static int ocierofs_prepare_layers(struct ocierofs_ctx *ctx,
 				   const struct ocierofs_config *config)
 {
+	struct erofs_docker_credential dcred = { NULL, NULL };
+	const char *username = config->username;
+	const char *password = config->password;
 	int ret;
 
-	ret = ocierofs_prepare_auth(ctx, config->username, config->password);
+	/* Fallback to Docker config.json if no CLI credentials provided */
+	if ((!username || !*username) && (!password || !*password)) {
+		if (!erofs_docker_config_lookup(ctx->registry, &dcred)) {
+			username = dcred.username;
+			password = dcred.password;
+		}
+	}
+
+	ret = ocierofs_prepare_auth(ctx, username, password);
+	erofs_docker_credential_free(&dcred);
 	if (ret)
 		return ret;
 
-- 
2.51.0


