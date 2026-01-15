Return-Path: <linux-erofs+bounces-1880-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EB2D22524
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jan 2026 04:38:54 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ds7xm3WwCz2xqj;
	Thu, 15 Jan 2026 14:38:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.44
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768448332;
	cv=none; b=mNHbs4WmLGF1zmfU00jS1Zda1Ixv9diobCHmqQwjI2DkJGQOe4ldKYU+P3++DTHa+CGrnIAoCU/c7emak6L889FdjKApq/D//p4XNSxygkLxkLJ9jKr9cdHtpiXkzemmRvvzerVv4KXyrH4RPDpcEKqCDlJ+7cX7L806qE8mIOJzweICiqDfwJrLqniml3SNuLDYzmk2ArEN5f1MnFhgglMyeDeMTimrr8q174PgjKbYiEddXrNM9tRy/GS6y7NXi26KqKdq7fJMamrskii6ghTqWhc5elGL3xNKg0NY/DxiiSOJxMXQOrRiJzPLiRzsXg6bxHucXdumadbUxfgm1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768448332; c=relaxed/relaxed;
	bh=rl952jug/i6KYCXOpxLjXPwmjMn8pCOZ/F4uM4Pr37Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QE3UC9QwhVt0Qi6tnSIPj9wiXiHHA2IT16mT29nBE1ouHDt0lxlacPo8frFE8rc3DzHfB/hvw0wyDlAqDoVbsnqo9yAwympQJq6pWHPyHN7z1OuVW4s5TBC5Yukw5ud8/2fGBuq35CsFuRv23J0jv6GbwPySWp0kNcmNo8jv7ALI8KybzK463MD/qr5DNB9mtbQUXCQ5jZojbcADy84q3nfSamgxcVqOUPLkKLbhOQqUkQOTfXK/OQI+pSxf7rtLm3RjqZde5y+7FHgZnb/gwvCY8IXpcQI6YLsV5Wx+jY55/0kV0HaUujOwXxVYKxFL+nQeMiaFHva4iUYxLJH2mA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.44; helo=out28-44.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.44; helo=out28-44.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-44.mail.aliyun.com (out28-44.mail.aliyun.com [115.124.28.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ds7xj5bRpz2xHW
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jan 2026 14:38:45 +1100 (AEDT)
Received: from HUDSONZHU-MC1.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.g6s2SUR_1768448317 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 15 Jan 2026 11:38:38 +0800
From: ChengyuZhu6 <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH v2] erofs-utils: lib: oci: support auto-detecting host platform
Date: Thu, 15 Jan 2026 11:38:35 +0800
Message-ID: <20260115033835.81033-1-hudson@cyzhu.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260110082732.61528-1-hudson@cyzhu.com>
References: <20260110082732.61528-1-hudson@cyzhu.com>
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

Currently, the platform is hard-coded to "linux/amd64" if not specified.
This patch introduces `ocierofs_get_platform_spec` helper to detect the
host platform (OS, architecture, and variant) at compile time using
preprocessor macros.

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
---
 lib/remotes/oci.c | 68 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 64 insertions(+), 4 deletions(-)

diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
index c8711ea..4c4568f 100644
--- a/lib/remotes/oci.c
+++ b/lib/remotes/oci.c
@@ -694,10 +694,20 @@ static char *ocierofs_get_manifest_digest(struct ocierofs_ctx *ctx,
 		    json_object_object_get_ex(manifest, "digest", &digest_obj)) {
 			const char *arch = json_object_get_string(arch_obj);
 			const char *os = json_object_get_string(os_obj);
+			json_object *variant_obj;
+			const char *variant = NULL;
 			char manifest_platform[64];
 
-			snprintf(manifest_platform, sizeof(manifest_platform),
-				 "%s/%s", os, arch);
+			if (json_object_object_get_ex(platform_obj, "variant", &variant_obj))
+				variant = json_object_get_string(variant_obj);
+
+			if (variant)
+				snprintf(manifest_platform, sizeof(manifest_platform),
+					 "%s/%s/%s", os, arch, variant);
+			else
+				snprintf(manifest_platform, sizeof(manifest_platform),
+					 "%s/%s", os, arch);
+
 			if (!strcmp(manifest_platform, platform)) {
 				digest = strdup(json_object_get_string(digest_obj));
 				break;
@@ -1089,13 +1099,63 @@ static int ocierofs_parse_ref(struct ocierofs_ctx *ctx, const char *ref_str)
 	return 0;
 }
 
+static char *ocierofs_get_platform_spec(void)
+{
+	const char *os = NULL, *arch = NULL, *variant = NULL;
+	char *platform;
+
+#if defined(__linux__)
+	os = "linux";
+#elif defined(__APPLE__)
+	os = "darwin";
+#elif defined(_WIN32)
+	os = "windows";
+#elif defined(__FreeBSD__)
+	os = "freebsd";
+#endif
+
+#if defined(__x86_64__) || defined(__amd64__)
+	arch = "amd64";
+#elif defined(__aarch64__) || defined(__arm64__)
+	arch = "arm64";
+	variant = "v8";
+#elif defined(__i386__)
+	arch = "386";
+#elif defined(__arm__)
+	arch = "arm";
+	variant = "v7";
+#elif defined(__riscv) && (__riscv_xlen == 64)
+	arch = "riscv64";
+#elif defined(__ppc64__)
+#if defined(__BYTE_ORDER__) && (__BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__)
+	arch = "ppc64le";
+#else
+	arch = "ppc64";
+#endif
+#elif defined(__s390x__)
+	arch = "s390x";
+#endif
+
+	if (!os || !arch)
+		return NULL;
+
+	if (variant) {
+		if (asprintf(&platform, "%s/%s/%s", os, arch, variant) < 0)
+			return NULL;
+	} else {
+		if (asprintf(&platform, "%s/%s", os, arch) < 0)
+			return NULL;
+	}
+	return platform;
+}
+
 /**
  * ocierofs_init - Initialize OCI context
  * @ctx: OCI context structure to initialize
  * @config: OCI configuration
  *
  * Initialize OCI context structure, set up CURL handle, and configure
- * default parameters including platform (linux/amd64), registry
+ * default parameters including platform (host platform), registry
  * (registry-1.docker.io), and tag (latest).
  *
  * Return: 0 on success, negative errno on failure
@@ -1120,7 +1180,7 @@ static int ocierofs_init(struct ocierofs_ctx *ctx, const struct ocierofs_config
 	if (config->platform)
 		ctx->platform = strdup(config->platform);
 	else
-		ctx->platform = strdup("linux/amd64");
+		ctx->platform = ocierofs_get_platform_spec();
 	if (!ctx->registry || !ctx->tag || !ctx->platform)
 		return -ENOMEM;
 
-- 
2.51.0


