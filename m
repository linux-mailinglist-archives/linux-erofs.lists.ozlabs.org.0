Return-Path: <linux-erofs+bounces-2306-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id p+ufGxQ1jWl70AAAu9opvQ
	(envelope-from <linux-erofs+bounces-2306-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Feb 2026 03:04:04 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 512F0129174
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Feb 2026 03:04:03 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fBJWM1fMfz2xcB;
	Thu, 12 Feb 2026 13:03:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.60
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770861839;
	cv=none; b=X3U6FsmMLhvZPokzaqMzuGjcSlJIWnIOFfnhM3fgJZQgtIAjUGmIM60QVGKkq8MpXhq3AdSXx6ru4Ym8Bem9diWEge8UpgsZyB/pr9WFQ4TpgsjiiXmwWKyExPLdpjbNZcSfU8aY/M2EDvQhwPvPjF+d11RSyM/wy6+ow6eL+DSqeURdG/ERXAMX41b8Bc1WMXyIb+gfxUv+pPPMiZ2CDcErLO3gSSsGjpIIzTFRtnjZp9UuCrrB9VR7aOglASF6vIwAAS8IqhwJ2hv/YCfmvah5sHhDS1Jew9gEN2x710EQ2xXGuvkBNceKvKlsQysWxhy+4FBvAB5/HIFehPcB4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770861839; c=relaxed/relaxed;
	bh=CndbhKZXUyrrGNoCtFYsQk8Nwpgq1bNLS14qaTTW2K8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bA8zsKc4NWFBLU1mCQzO7o34T6EbvSE4UC2qiTH80wrORb8Bb38EbTB4I7/3Y7DoqCTuLpApELLvWwbLWtxwIBw/NPfan8j3mBTBEyO/C+zVDMaRNip+zO4/o1uRG8patMP+ZQvHiDQ0arXA+vXadYkAnhbrwvhfoJkM0oBbeoDMm8evSHEd+HFdbeYchoxIUiSh5tL5rCjsPkbl4ddotQ2nssU2NUT6EwYlPz0XjWpj54IuQpQ3baEOqCcb5NevL5jiPe9OqTFmexRfQzbJMq9Ga46XOXVuXltMeywszDqIR6OFMrcKQvaII370Co6wx9CyO2ejnykk67RAMlwWsw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.60; helo=out28-60.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.60; helo=out28-60.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-60.mail.aliyun.com (out28-60.mail.aliyun.com [115.124.28.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fBJWJ4L3yz2xHX
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Feb 2026 13:03:54 +1100 (AEDT)
Received: from HUDSONZHU-MC1.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.gVKKSVH_1770861827 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 12 Feb 2026 10:03:48 +0800
From: ChengyuZhu6 <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH v3] erofs-utils: lib: oci: support reading credentials from docker config
Date: Thu, 12 Feb 2026 10:03:18 +0800
Message-ID: <20260212020318.41955-1-hudson@cyzhu.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209075355.16969-1-hudson@cyzhu.com>
References: <20260209075355.16969-1-hudson@cyzhu.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.00 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DMARC_NA(0.00)[cyzhu.com];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[hudson@cyzhu.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-2306-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:url,tencent.com:email,cyzhu.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 512F0129174
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
 include/erofs/internal.h    |  10 ++
 lib/Makefile.am             |   2 +-
 lib/liberofs_dockerconfig.h |  30 +++++
 lib/remotes/docker_config.c | 240 ++++++++++++++++++++++++++++++++++++
 lib/remotes/oci.c           |  18 ++-
 5 files changed, 295 insertions(+), 5 deletions(-)
 create mode 100644 lib/liberofs_dockerconfig.h
 create mode 100644 lib/remotes/docker_config.c

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index ef019a5..3f1e4ff 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -25,6 +25,8 @@ typedef unsigned short umode_t;
 #ifdef HAVE_PTHREAD_H
 #include <pthread.h>
 #endif
+#include <stdlib.h>
+#include <string.h>
 #include "atomic.h"
 #include "io.h"
 
@@ -542,6 +544,14 @@ static inline int erofs_blk_read(struct erofs_sb_info *sbi, int device_id,
 			      erofs_pos(sbi, nblocks));
 }
 
+static inline void erofs_free_sensitive(void *ptr, size_t len)
+{
+	if (!ptr)
+		return;
+	memset(ptr, 0, len);
+	free(ptr);
+}
+
 /* vmdk.c */
 int erofs_dump_vmdk_desc(FILE *f, struct erofs_sb_info *sbi);
 
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 1721039..77f6fd8 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -89,7 +89,7 @@ liberofs_la_CFLAGS += ${libnl3_CFLAGS}
 liberofs_la_LDFLAGS += ${libnl3_LIBS}
 liberofs_la_SOURCES += backends/nbd.c
 endif
-liberofs_la_SOURCES += remotes/oci.c
+liberofs_la_SOURCES += remotes/oci.c remotes/docker_config.c
 liberofs_la_CFLAGS += ${json_c_CFLAGS}
 liberofs_la_LDFLAGS += ${json_c_LIBS}
 liberofs_la_SOURCES += gzran.c
diff --git a/lib/liberofs_dockerconfig.h b/lib/liberofs_dockerconfig.h
new file mode 100644
index 0000000..1580e1c
--- /dev/null
+++ b/lib/liberofs_dockerconfig.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
+/*
+ * Copyright (C) 2026 Tencent, Inc.
+ *             http://www.tencent.com/
+ */
+#ifndef __EROFS_DOCKER_CONFIG_H
+#define __EROFS_DOCKER_CONFIG_H
+
+#include "erofs/internal.h"
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
index 0000000..89fb826
--- /dev/null
+++ b/lib/remotes/docker_config.c
@@ -0,0 +1,240 @@
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
+	if (dir) {
+		if (!*dir)
+			return NULL;
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
+		erofs_free_sensitive(decoded, decoded_len);
+		return -EINVAL;
+	}
+
+	*colon = '\0';
+	*out_user = strdup((char *)decoded);
+	*out_pass = strdup(colon + 1);
+
+	erofs_free_sensitive(decoded, decoded_len);
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
+	erofs_free_sensitive(content, strlen(content));
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
+		erofs_free_sensitive(cred->username, strlen(cred->username));
+		cred->username = NULL;
+	}
+	if (cred->password) {
+		erofs_free_sensitive(cred->password, strlen(cred->password));
+		cred->password = NULL;
+	}
+}
+
+#endif /* HAVE_JSON_C_JSON_H */
diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
index 4c4568f..193464b 100644
--- a/lib/remotes/oci.c
+++ b/lib/remotes/oci.c
@@ -26,14 +26,12 @@
 #include "erofs/tar.h"
 #include "liberofs_base64.h"
 #include "liberofs_oci.h"
+#include "liberofs_dockerconfig.h"
 #include "liberofs_private.h"
 #include "liberofs_gzran.h"
 
 #ifdef OCIEROFS_ENABLED
 
-#define DOCKER_REGISTRY "docker.io"
-#define DOCKER_API_REGISTRY "registry-1.docker.io"
-
 #define DOCKER_MEDIATYPE_MANIFEST_V2 \
 	"application/vnd.docker.distribution.manifest.v2+json"
 #define DOCKER_MEDIATYPE_MANIFEST_V1 \
@@ -964,9 +962,21 @@ static int ocierofs_find_layer_by_digest(struct ocierofs_ctx *ctx, const char *d
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


