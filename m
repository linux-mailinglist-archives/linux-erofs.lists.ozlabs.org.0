Return-Path: <linux-erofs+bounces-2439-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAt9OO0QoWlDqAQAu9opvQ
	(envelope-from <linux-erofs+bounces-2439-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Feb 2026 04:35:09 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 930E81B24B6
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Feb 2026 04:35:07 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMYqR3WJ0z2xLv;
	Fri, 27 Feb 2026 14:34:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.69
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772163299;
	cv=none; b=R0D8b0tgLAL5fYM6N1MOX1ohi3V74z/A62q2lFCoE9L2s6M3g2Z2yXkw0PyNHViit69JcIja4GIpSaQ8+vq7oVZw5zE8lMrOlJrPNCZs8b8/EwB24cPS4vRP31drCZ4jLaYp+9wubosR4o7HeqySrtWoAlP9OR0Dc9meq2/PT6+ZNZbA4W64hAvzAzGswF5I7o2taItdX1JWpJdoB5U7HSNSejRLlMlI8zv0MfJm91rsJ5AEW2t6tnqq/qwVXU7MgqoE7YS57c8H4W7HSwEFs4dkz8M3gmxSfxA5IeTbXp/aGnT1BKge488KjUjGvh23ehYIaTHTFRocur7DtrdHtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772163299; c=relaxed/relaxed;
	bh=ByK1s9nV771wRNJyMMAYVG9J9HzCavH2kNsqw0SBiws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HAgjGvSDTnk5KCcLctUVC5kKbH+JNRW+WgFq/hRYlMfcDJrWCNnzrqVT5xfeRpXb0syQe39A7M4X/X7s164sYJL00vwsuZCtTbWTO/Ko07lOI7sAuxORFB1etIX5wKV0eLkszXwrn6BOeYKVsxjhicoM91ivKn8n6Dmy1ccBzSK15jiqigdGE3DPGBnuPwMACZEvxN6s8MJB+NM56rSEBX2kx3Z0fJDln9KYdfKCmdfvjhtDl0JovkphAhRUEaIrIHjtnhG2qKLH+ULbrpUcEntqb7qs0yVhYHOlQxzuKYcvooXJzOTo6pWM+yzZmWxlXf51zK+WRh3DZtTwugUgWQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.69; helo=out28-69.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.69; helo=out28-69.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-69.mail.aliyun.com (out28-69.mail.aliyun.com [115.124.28.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMYqP2y1wz2xKh
	for <linux-erofs@lists.ozlabs.org>; Fri, 27 Feb 2026 14:34:53 +1100 (AEDT)
Received: from HUDSONZHU-MB0.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.gfvraEJ_1772163284 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 27 Feb 2026 11:34:45 +0800
From: Chengyu <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH 1/1] erofs-utils: mount: auto-detect platform for OCI recovery files
Date: Fri, 27 Feb 2026 11:34:44 +0800
Message-ID: <20260227033444.99576-1-hudson@cyzhu.com>
X-Mailer: git-send-email 2.47.1
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
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2439-lists,linux-erofs=lfdr.de];
	DMARC_NA(0.00)[cyzhu.com];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	NEURAL_HAM(-0.00)[-0.998];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[hudson@cyzhu.com,linux-erofs@lists.ozlabs.org];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cyzhu.com:mid]
X-Rspamd-Queue-Id: 930E81B24B6
X-Rspamd-Action: no action

From: Chengyu Zhu <hudsonzhu@tencent.com>

erofsmount_write_recovery_oci() writes source->ocicfg.platform into
recovery files directly, but it could be NULL when not explicitly
configured, causing reattach failures.

Fix this by falling back to ocierofs_get_platform_spec().  Also
refactor it to return a compile-time string literal instead of
asprintf(), eliminating the need for callers to free() the result.

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
---
 lib/liberofs_oci.h |  1 +
 lib/remotes/oci.c  | 55 +++++++++++++++-------------------------------
 mount/main.c       | 11 +++++++---
 3 files changed, 27 insertions(+), 40 deletions(-)

diff --git a/lib/liberofs_oci.h b/lib/liberofs_oci.h
index 9e0571f..2243c82 100644
--- a/lib/liberofs_oci.h
+++ b/lib/liberofs_oci.h
@@ -80,6 +80,7 @@ int ocierofs_io_open(struct erofs_vfile *vf, const struct ocierofs_config *cfg);
 
 char *ocierofs_encode_userpass(const char *username, const char *password);
 int ocierofs_decode_userpass(const char *b64, char **out_user, char **out_pass);
+const char *ocierofs_get_platform_spec(void);
 
 #ifdef __cplusplus
 }
diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
index e5b2f7c..47e8b27 100644
--- a/lib/remotes/oci.c
+++ b/lib/remotes/oci.c
@@ -1109,54 +1109,38 @@ static int ocierofs_parse_ref(struct ocierofs_ctx *ctx, const char *ref_str)
 	return 0;
 }
 
-static char *ocierofs_get_platform_spec(void)
+const char *ocierofs_get_platform_spec(void)
 {
-	const char *os = NULL, *arch = NULL, *variant = NULL;
-	char *platform;
-
 #if defined(__linux__)
-	os = "linux";
+#define EROFS_OCI_OS "linux"
 #elif defined(__APPLE__)
-	os = "darwin";
+#define EROFS_OCI_OS "darwin"
 #elif defined(_WIN32)
-	os = "windows";
+#define EROFS_OCI_OS "windows"
 #elif defined(__FreeBSD__)
-	os = "freebsd";
+#define EROFS_OCI_OS "freebsd"
 #endif
 
 #if defined(__x86_64__) || defined(__amd64__)
-	arch = "amd64";
+	return EROFS_OCI_OS "/amd64";
 #elif defined(__aarch64__) || defined(__arm64__)
-	arch = "arm64";
-	variant = "v8";
+	return EROFS_OCI_OS "/arm64/v8";
 #elif defined(__i386__)
-	arch = "386";
+	return EROFS_OCI_OS "/386";
 #elif defined(__arm__)
-	arch = "arm";
-	variant = "v7";
+	return EROFS_OCI_OS "/arm/v7";
 #elif defined(__riscv) && (__riscv_xlen == 64)
-	arch = "riscv64";
+	return EROFS_OCI_OS "/riscv64";
+#elif defined(__ppc64__) && defined(__BYTE_ORDER__) && \
+	  (__BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__)
+	return EROFS_OCI_OS "/ppc64le";
 #elif defined(__ppc64__)
-#if defined(__BYTE_ORDER__) && (__BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__)
-	arch = "ppc64le";
-#else
-	arch = "ppc64";
-#endif
+	return EROFS_OCI_OS "/ppc64";
 #elif defined(__s390x__)
-	arch = "s390x";
+	return EROFS_OCI_OS "/s390x";
+#else
+	return NULL;
 #endif
-
-	if (!os || !arch)
-		return NULL;
-
-	if (variant) {
-		if (asprintf(&platform, "%s/%s/%s", os, arch, variant) < 0)
-			return NULL;
-	} else {
-		if (asprintf(&platform, "%s/%s", os, arch) < 0)
-			return NULL;
-	}
-	return platform;
 }
 
 /**
@@ -1187,10 +1171,7 @@ static int ocierofs_init(struct ocierofs_ctx *ctx, const struct ocierofs_config
 		ctx->blob_digest = NULL;
 	ctx->registry = strdup("registry-1.docker.io");
 	ctx->tag = strdup("latest");
-	if (config->platform)
-		ctx->platform = strdup(config->platform);
-	else
-		ctx->platform = ocierofs_get_platform_spec();
+	ctx->platform = strdup(config->platform ?: ocierofs_get_platform_spec());
 	if (!ctx->registry || !ctx->tag || !ctx->platform)
 		return -ENOMEM;
 
diff --git a/mount/main.c b/mount/main.c
index 3530b2c..b04be5d 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -717,6 +717,7 @@ out_closefd:
 static int erofsmount_write_recovery_oci(FILE *f, struct erofs_nbd_source *source)
 {
 	char *b64cred = NULL;
+	const char *platform;
 	int ret;
 
 	if (source->ocicfg.username || source->ocicfg.password) {
@@ -726,11 +727,15 @@ static int erofsmount_write_recovery_oci(FILE *f, struct erofs_nbd_source *sourc
 			return PTR_ERR(b64cred);
 	}
 
+	platform = source->ocicfg.platform;
+	if (!platform || !*platform)
+		platform = ocierofs_get_platform_spec();
+
 	if ((source->ocicfg.tarindex_path || source->ocicfg.zinfo_path) &&
 	    source->ocicfg.blob_digest && *source->ocicfg.blob_digest) {
 		ret = fprintf(f, "TARINDEX_OCI_BLOB %s %s %s %s %s %s\n",
 			      source->ocicfg.image_ref ?: "",
-			      source->ocicfg.platform ?: "",
+			      platform ?: "",
 			      source->ocicfg.blob_digest,
 			      b64cred ?: "",
 			      source->ocicfg.tarindex_path ?: "",
@@ -742,7 +747,7 @@ static int erofsmount_write_recovery_oci(FILE *f, struct erofs_nbd_source *sourc
 	if (source->ocicfg.blob_digest && *source->ocicfg.blob_digest) {
 		ret = fprintf(f, "OCI_NATIVE_BLOB %s %s %s %s\n",
 			      source->ocicfg.image_ref ?: "",
-			      source->ocicfg.platform ?: "",
+			      platform ?: "",
 			      source->ocicfg.blob_digest,
 			      b64cred ?: "");
 		free(b64cred);
@@ -752,7 +757,7 @@ static int erofsmount_write_recovery_oci(FILE *f, struct erofs_nbd_source *sourc
 	if (source->ocicfg.layer_index >= 0) {
 		ret = fprintf(f, "OCI_LAYER %s %s %d %s\n",
 			      source->ocicfg.image_ref ?: "",
-			      source->ocicfg.platform ?: "",
+			      platform ?: "",
 			      source->ocicfg.layer_index,
 			      b64cred ?: "");
 		free(b64cred);
-- 
2.47.1


