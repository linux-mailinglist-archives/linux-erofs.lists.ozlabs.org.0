Return-Path: <linux-erofs+bounces-966-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B337FB43288
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Sep 2025 08:36:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cHV9q475gz2xd6;
	Thu,  4 Sep 2025 16:36:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.44
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756967775;
	cv=none; b=YOcK9A+nNYu2r2EMB/4VSImW0vAiV83c32mpW7DCYYzbKW1WmlSUcvqtJMzhlDIXvPMy3ty6tdk+LsfmQBMbcbYQI8VxPFqewz8vmuKKqVo5PicQRWYsOts4jbqFh+Nc0m5BIB7hqUb4VLACBabU2j8LrcWPdussC/ci23rUltXLCDphdQ8zAuAbzLk6moaEEjgkdJU2tSYfFz3hpAU6HOwweiptFPEZu5bL6PKli8wx6MdJPu4YCdhJ0lGwOvSDV/Saavo56SYGMtlhWI9og/OrZBb8xExTZ6c1dmqdmGr2dWyEmgcjn4XT6kZx0q0y6y31otQSrzrQsE4Q5BHwlA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756967775; c=relaxed/relaxed;
	bh=ONTSPPVpGtr70bWophCimuS7O8tn6D2WsOXMizf3gV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EHffz1QIXQ1WemD7/4HP7AAC8om4XkK2dZz9int57zLYW7abFDH9NOVhg78oZOePnCEmeb9LiWxjQYvGYI4QfxItA4R2knCbhL9K67C7bYraRnFEsOJPh5+dTofNBiX7by9Vj83DpxtMzgY2l0X210YV1m9dMz0tM77/6daoLSA+iD3gDfYucUMxNqhtoCe/YgcN+e6CcC24xu9H50r44NXztSIeyeJlYVkai4Qlp2PovtJlglimbNXFznndB8tqs4mNL8gQlvuz1eEni3LgOEI2mBGCGbmXaTOq9lnt7DTVQqElEReIanSlQqXwLzgh31naVQ7of71IHx18oweZpg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.44; helo=out28-44.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.44; helo=out28-44.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-44.mail.aliyun.com (out28-44.mail.aliyun.com [115.124.28.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cHV9n5g3Pz2yrZ
	for <linux-erofs@lists.ozlabs.org>; Thu,  4 Sep 2025 16:36:11 +1000 (AEST)
Received: from HUDSONZHU-MC1.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.eXG5BdY_1756967766 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 04 Sep 2025 14:36:06 +0800
From: ChengyuZhu6 <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH v5 1/3] erofs-utils:mkfs: move parse_oci_ref to lib
Date: Thu,  4 Sep 2025 14:36:01 +0800
Message-ID: <20250904063603.560-2-hudson@cyzhu.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250904063603.560-1-hudson@cyzhu.com>
References: <20250901051042.10905-1-hudson@cyzhu.com>
 <20250904063603.560-1-hudson@cyzhu.com>
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

move parse_oci_ref to oci.c.

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
---
 lib/liberofs_oci.h |  12 +++--
 lib/remotes/oci.c  | 110 +++++++++++++++++++++++++++++++++++++++++
 mkfs/main.c        | 121 +--------------------------------------------
 3 files changed, 120 insertions(+), 123 deletions(-)

diff --git a/lib/liberofs_oci.h b/lib/liberofs_oci.h
index 3a8108b..bce63ef 100644
--- a/lib/liberofs_oci.h
+++ b/lib/liberofs_oci.h
@@ -8,9 +8,6 @@
 
 #include <stdbool.h>
 
-#define DOCKER_REGISTRY "docker.io"
-#define DOCKER_API_REGISTRY "registry-1.docker.io"
-
 #ifdef __cplusplus
 extern "C" {
 #endif
@@ -79,6 +76,15 @@ void ocierofs_cleanup(struct erofs_oci *oci);
  */
 int erofs_oci_params_set_string(char **field, const char *value);
 
+/*
+ * ocierofs_parse_ref - Parse OCI image reference string
+ * @oci: OCI client structure
+ * @ref_str: OCI image reference string
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+int ocierofs_parse_ref(struct erofs_oci *oci, const char *ref_str);
+
 /*
  * ocierofs_build_trees - Build file trees from OCI container image layers
  * @root:     root inode to build the file tree under
diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
index 0fb8c1f..e6f0c23 100644
--- a/lib/remotes/oci.c
+++ b/lib/remotes/oci.c
@@ -21,6 +21,9 @@
 #include "liberofs_oci.h"
 #include "liberofs_private.h"
 
+#define DOCKER_REGISTRY "docker.io"
+#define DOCKER_API_REGISTRY "registry-1.docker.io"
+
 #define DOCKER_MEDIATYPE_MANIFEST_V2 \
 	"application/vnd.docker.distribution.manifest.v2+json"
 #define DOCKER_MEDIATYPE_MANIFEST_V1 \
@@ -1066,3 +1069,110 @@ int erofs_oci_params_set_string(char **field, const char *value)
 	*field = new_value;
 	return 0;
 }
+
+int ocierofs_parse_ref(struct erofs_oci *oci, const char *ref_str)
+{
+	char *slash, *colon, *dot;
+	const char *repo_part;
+	size_t len;
+
+	slash = strchr(ref_str, '/');
+	if (slash) {
+		dot = strchr(ref_str, '.');
+		if (dot && dot < slash) {
+			char *registry_str;
+
+			len = slash - ref_str;
+			registry_str = strndup(ref_str, len);
+
+			if (!registry_str) {
+				erofs_err("failed to allocate memory for registry");
+				return -ENOMEM;
+			}
+			if (erofs_oci_params_set_string(&oci->params.registry,
+							registry_str)) {
+				free(registry_str);
+				erofs_err("failed to set registry");
+				return -ENOMEM;
+			}
+			free(registry_str);
+			repo_part = slash + 1;
+		} else {
+			repo_part = ref_str;
+		}
+	} else {
+		repo_part = ref_str;
+	}
+
+	colon = strchr(repo_part, ':');
+	if (colon) {
+		char *repo_str;
+
+		len = colon - repo_part;
+		repo_str = strndup(repo_part, len);
+
+		if (!repo_str) {
+			erofs_err("failed to allocate memory for repository");
+			return -ENOMEM;
+		}
+
+		if (!strchr(repo_str, '/') &&
+		    (!strcmp(oci->params.registry, DOCKER_API_REGISTRY) ||
+		     !strcmp(oci->params.registry, DOCKER_REGISTRY))) {
+			char *full_repo;
+
+			if (asprintf(&full_repo, "library/%s", repo_str) == -1) {
+				free(repo_str);
+				erofs_err("failed to allocate memory for full repository name");
+				return -ENOMEM;
+			}
+			free(repo_str);
+			repo_str = full_repo;
+		}
+
+		if (erofs_oci_params_set_string(&oci->params.repository,
+						repo_str)) {
+			free(repo_str);
+			erofs_err("failed to set repository");
+			return -ENOMEM;
+		}
+		free(repo_str);
+
+		if (erofs_oci_params_set_string(&oci->params.tag,
+						colon + 1)) {
+			erofs_err("failed to set tag");
+			return -ENOMEM;
+		}
+	} else {
+		char *repo_str = strdup(repo_part);
+
+		if (!repo_str) {
+			erofs_err("failed to allocate memory for repository");
+			return -ENOMEM;
+		}
+
+		if (!strchr(repo_str, '/') &&
+		    (!strcmp(oci->params.registry, DOCKER_API_REGISTRY) ||
+		     !strcmp(oci->params.registry, DOCKER_REGISTRY))) {
+			char *full_repo;
+
+			if (asprintf(&full_repo, "library/%s", repo_str) == -1) {
+				free(repo_str);
+				erofs_err("failed to allocate memory for full repository name");
+				return -ENOMEM;
+			}
+			free(repo_str);
+			repo_str = full_repo;
+		}
+
+		if (erofs_oci_params_set_string(&oci->params.repository,
+						repo_str)) {
+			free(repo_str);
+			erofs_err("failed to set repository");
+			return -ENOMEM;
+		}
+		free(repo_str);
+	}
+
+	return 0;
+}
diff --git a/mkfs/main.c b/mkfs/main.c
index bc895f1..064392d 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -763,125 +763,6 @@ static int mkfs_parse_oci_options(char *options_str)
 
 	return 0;
 }
-
-/**
- * mkfs_parse_oci_ref - Parse OCI image reference string
- * @ref_str: OCI image reference in various formats
- *
- * Parse OCI image reference which can be in formats:
- * - registry.example.com/namespace/repo:tag
- * - namespace/repo:tag (uses default registry)
- * - repo:tag (adds library/ prefix for Docker Hub)
- * - repo (uses default tag "latest")
- *
- * Return: 0 on success, negative errno on failure
- */
-static int mkfs_parse_oci_ref(const char *ref_str)
-{
-	char *slash, *colon, *dot;
-	const char *repo_part;
-	size_t len;
-
-	slash = strchr(ref_str, '/');
-	if (slash) {
-		dot = strchr(ref_str, '.');
-		if (dot && dot < slash) {
-			char *registry_str;
-
-			len = slash - ref_str;
-			registry_str = strndup(ref_str, len);
-
-			if (!registry_str) {
-				erofs_err("failed to allocate memory for registry");
-				return -ENOMEM;
-			}
-			if (erofs_oci_params_set_string(&ocicfg.params.registry,
-							registry_str)) {
-				free(registry_str);
-				erofs_err("failed to set registry");
-				return -ENOMEM;
-			}
-			free(registry_str);
-			repo_part = slash + 1;
-		} else {
-			repo_part = ref_str;
-		}
-	} else {
-		repo_part = ref_str;
-	}
-
-	colon = strchr(repo_part, ':');
-	if (colon) {
-		char *repo_str;
-
-		len = colon - repo_part;
-		repo_str = strndup(repo_part, len);
-
-		if (!repo_str) {
-			erofs_err("failed to allocate memory for repository");
-			return -ENOMEM;
-		}
-
-		if (!strchr(repo_str, '/') &&
-		    (!strcmp(ocicfg.params.registry, DOCKER_API_REGISTRY) ||
-		     !strcmp(ocicfg.params.registry, DOCKER_REGISTRY))) {
-			char *full_repo;
-
-			if (asprintf(&full_repo, "library/%s", repo_str) == -1) {
-				free(repo_str);
-				erofs_err("failed to allocate memory for full repository name");
-				return -ENOMEM;
-			}
-			free(repo_str);
-			repo_str = full_repo;
-		}
-
-		if (erofs_oci_params_set_string(&ocicfg.params.repository,
-						repo_str)) {
-			free(repo_str);
-			erofs_err("failed to set repository");
-			return -ENOMEM;
-		}
-		free(repo_str);
-
-		if (erofs_oci_params_set_string(&ocicfg.params.tag,
-						colon + 1)) {
-			erofs_err("failed to set tag");
-			return -ENOMEM;
-		}
-	} else {
-		char *repo_str = strdup(repo_part);
-
-		if (!repo_str) {
-			erofs_err("failed to allocate memory for repository");
-			return -ENOMEM;
-		}
-
-		if (!strchr(repo_str, '/') &&
-		    (!strcmp(ocicfg.params.registry, DOCKER_API_REGISTRY) ||
-		     !strcmp(ocicfg.params.registry, DOCKER_REGISTRY))) {
-			char *full_repo;
-
-			if (asprintf(&full_repo, "library/%s", repo_str) == -1) {
-				free(repo_str);
-				erofs_err("failed to allocate memory for full repository name");
-				return -ENOMEM;
-			}
-			free(repo_str);
-			repo_str = full_repo;
-		}
-
-		if (erofs_oci_params_set_string(&ocicfg.params.repository,
-						repo_str)) {
-			free(repo_str);
-			erofs_err("failed to set repository");
-			return -ENOMEM;
-		}
-		free(repo_str);
-	}
-
-	return 0;
-}
 #endif
 
 static int mkfs_parse_one_compress_alg(char *alg,
@@ -1958,7 +1839,7 @@ int main(int argc, char **argv)
 			err = mkfs_parse_oci_options(mkfs_oci_options);
 			if (err)
 				goto exit;
-			err = mkfs_parse_oci_ref(cfg.c_src_path);
+			err = ocierofs_parse_ref(&ocicfg, cfg.c_src_path);
 			if (err)
 				goto exit;
 
-- 
2.51.0


