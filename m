Return-Path: <linux-erofs+bounces-1807-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 42737D0D349
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Jan 2026 09:27:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dpBbS4Mc4z2y8c;
	Sat, 10 Jan 2026 19:27:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.78
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768033668;
	cv=none; b=T6MuU2PnEENzTkPo/zZvyRK8AjKQko/zSXwAmKe56GbgfYVIVzVIUWmtbqVOGaeNK8Pk0Mpq5/0iagizjBpKxUjtjImy38jpLt7Kps6VafO47ZEhPFLfujH8m39rYH1+F+4YnJlLQKlvF34GZrX29b22/DxXhyKrEe7pNlI4nm6NG2pzti7deHXKeGliP9dBxXWWu6TpBGUcApPxEic1qBKBCjeDXB5sUydOF/1Xs7M/UR102comElLBH/L7vpWEHHb2WZTX1j95HxhZoh9o37jwu6pM2f1x2kpCVT0l09ZZP01aForICvDKUz7f4Ki0Y6CvEcdUF1yUIMvuBli5Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768033668; c=relaxed/relaxed;
	bh=UwlWR5USWpV9c/upg0gxpAp8RhsnonF8ICk/eLMhKnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EXF3aD2Y7off9sltmNT+PH2IKnNydBohi3BZyNHynJ2epHOc92H03XOm7N6llJfU5qzc0xJlRZOHOU1qUUovwQyDaKR4tx0Zm/NxfJgDiTiQU5WaxXjojmF3gspGfGhk7JTEW7EYAqqw1UcEI5gRyPBGfiMXcBwW7pQSltbvbntk2StDb2iz0Y5QgZb08wkTqRlitVHDuz56ljP6H+LxBjt6R4RrQt1BkCMWX+hW5lurEC2pTOZ/RtOsW6uAgsCal35sbEkQh+ZyxeYAn0Gvm6dGRx8j3daXbW/php9WZXQp84FtZzYqvYSjvZ61m87W8z1ExTvm9Jc2YzJyJKdKVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.78; helo=out28-78.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.78; helo=out28-78.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-78.mail.aliyun.com (out28-78.mail.aliyun.com [115.124.28.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dpBbQ1628z2xRv
	for <linux-erofs@lists.ozlabs.org>; Sat, 10 Jan 2026 19:27:42 +1100 (AEDT)
Received: from HUDSONZHU-MC1.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.g33.8Ld_1768033654 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 10 Jan 2026 16:27:35 +0800
From: ChengyuZhu6 <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH v1] erofs-utils: lib: oci: support auto-detecting host platform
Date: Sat, 10 Jan 2026 16:27:32 +0800
Message-ID: <20260110082732.61528-1-hudson@cyzhu.com>
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

Currently, the platform is hard-coded to "linux/amd64" if not specified.
This patch introduces `ocierofs_get_platform_spec` helper to detect the
host platform (OS and architecture) at compile time.

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
---
 lib/remotes/oci.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
index c8711ea..911abd5 100644
--- a/lib/remotes/oci.c
+++ b/lib/remotes/oci.c
@@ -1089,13 +1089,55 @@ static int ocierofs_parse_ref(struct ocierofs_ctx *ctx, const char *ref_str)
 	return 0;
 }
 
+static char *ocierofs_get_platform_spec(void)
+{
+#if defined(__linux__)
+	const char *os = "linux";
+#elif defined(__APPLE__)
+	const char *os = "darwin";
+#elif defined(_WIN32)
+	const char *os = "windows";
+#elif defined(__FreeBSD__)
+	const char *os = "freebsd";
+#else
+	const char *os = "linux";
+#endif
+
+#if defined(__x86_64__) || defined(__amd64__)
+	const char *arch = "amd64";
+#elif defined(__aarch64__) || defined(__arm64__)
+	const char *arch = "arm64";
+#elif defined(__i386__)
+	const char *arch = "386";
+#elif defined(__arm__)
+	const char *arch = "arm";
+#elif defined(__riscv) && (__riscv_xlen == 64)
+	const char *arch = "riscv64";
+#elif defined(__ppc64__)
+#if defined(__BYTE_ORDER__) && (__BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__)
+	const char *arch = "ppc64le";
+#else
+	const char *arch = "ppc64";
+#endif
+#elif defined(__s390x__)
+	const char *arch = "s390x";
+#else
+	const char *arch = "amd64";
+#endif
+	char *platform;
+
+	if (asprintf(&platform, "%s/%s", os, arch) < 0)
+		return NULL;
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
@@ -1120,7 +1162,7 @@ static int ocierofs_init(struct ocierofs_ctx *ctx, const struct ocierofs_config
 	if (config->platform)
 		ctx->platform = strdup(config->platform);
 	else
-		ctx->platform = strdup("linux/amd64");
+		ctx->platform = ocierofs_get_platform_spec();
 	if (!ctx->registry || !ctx->tag || !ctx->platform)
 		return -ENOMEM;
 
-- 
2.51.0


