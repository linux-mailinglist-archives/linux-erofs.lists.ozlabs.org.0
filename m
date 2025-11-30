Return-Path: <linux-erofs+bounces-1451-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1CBC94DE8
	for <lists+linux-erofs@lfdr.de>; Sun, 30 Nov 2025 11:44:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dK3Yd4kjwz2yvR;
	Sun, 30 Nov 2025 21:44:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.220
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764499445;
	cv=none; b=NM07UV0T8c0b7vLNFdaS59JtdhQIgqOCkKoFoTjR94KcHbdPWe5Hy6PyS5MkMCz4LWN+NZLhZ9P0kXwBEFZ1jo5TjEHPK+g5aRZfDf8ETOL8C2dT3JctGT/op4VoT4RbMMiqMMQtcdC60Dd3OGuFYPl+MXc5JlzATb6L6EL7e6lCFHpxjKryO7IhKRN3R0u39AENfTiXwpD6VHzZXUt8Wp+JRXxJq8T2v8W1MiUY6tRHWZJPM94f+T9nntrXDDCL3DE3c9DvzDEXd9hW2ZOOoqW+ET4D4LxY3RmckmxKXjYQQL8qD7aDc8tB8y0WRftPEBvJ2kEnOMU+LdMzn0YBUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764499445; c=relaxed/relaxed;
	bh=4WteNzg/kcu4blxw2mExBUg0rmxoQ9m9N/6Suyjk96A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=meWN6C0q5KQ6ne+Iwu5feqgva3+4NEi/EWDoso0ob3gBGyyaYQ4I3Prxozq7K8XCKvbuvt/1twgA/j92sA+N27Sm4HbUtmwMYz8Bf2wQDyk7503cTd2LgqI6Z0CrBQC5UQsYmoTJ9G1Wd5qlbau0BBtN3TKWBGZ2kw8Qs/+AN+1Hk7J+waGTaA27UUOWpblJJaMoX9SIlve2fuUPzM5hDTL+1iW6UKsmp0HjGiIicR105iyJ44u37bhZOJVBlI5GesVM6RBUm+E78RxkDtBuk7cRq6lIPGZ14WQvmT2GPY+d4hPKUeQEcmGTxVhbEw8ji2WVhHil2dXd4qMpp3EEsg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=4nlfCXqN; dkim-atps=neutral; spf=pass (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=4nlfCXqN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dK3YY4TJZz2ynW
	for <linux-erofs@lists.ozlabs.org>; Sun, 30 Nov 2025 21:43:59 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=4WteNzg/kcu4blxw2mExBUg0rmxoQ9m9N/6Suyjk96A=;
	b=4nlfCXqN4oh65nn6QNjlvueLxPp87HVOq5Z4VZtNk3TRd1uiJklOAhsoWtiW/7t+Tpq7MpgJJ
	rJiVly5DHIBL7FRnXj0afaN7VTkUYsJk3OSI2HyhAC5gOXA3RCKPkC2xNNmPIXNKnuZdXf6F/jJ
	TEPLwuqWNaFNI2a/sKMiVPw=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dK3Vc3zbcz12LDK;
	Sun, 30 Nov 2025 18:41:28 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id F2D441804F9;
	Sun, 30 Nov 2025 18:43:51 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Sun, 30 Nov
 2025 18:43:51 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <hsiangkao@linux.alibaba.com>, <hudsonzhu@tencent.com>,
	<wayne.ma@huawei.com>, <jingrui@huawei.com>
Subject: [PATCH 1/2] erofs-utils: lib: oci: fix a corner-case in `ocierofs_parse_ref()`
Date: Sun, 30 Nov 2025 18:42:56 +0800
Message-ID: <20251130104257.877660-1-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.43.0
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
Content-Type: text/plain
X-Originating-IP: [10.50.159.234]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Currently, `ocierofs_parse_ref()` fails to correctly parse OCI
reference strings of the form "localhost:5000/myapp:latest", as it
assumes a valid registry name must contain '.', which is not the case.

Let's also treat `ref_str` with a colon before slash (i.e., containing a
port number) as valid registry names.

This patch also adds unit tests for `ocierofs_parse_ref()`.

This patch also removes repeated codes in `ocierofs_parse_ref()`.

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 lib/Makefile.am   |   9 +-
 lib/remotes/oci.c | 220 +++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 194 insertions(+), 35 deletions(-)

diff --git a/lib/Makefile.am b/lib/Makefile.am
index 4d31f6a..1721039 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -95,8 +95,15 @@ liberofs_la_LDFLAGS += ${json_c_LIBS}
 liberofs_la_SOURCES += gzran.c
 
 if ENABLE_S3
-noinst_PROGRAMS  = s3erofs_test
+noinst_PROGRAMS = s3erofs_test
 s3erofs_test_SOURCES = remotes/s3.c
 s3erofs_test_CFLAGS = -Wall -I$(top_srcdir)/include ${libxml2_CFLAGS} ${openssl_CFLAGS} -DTEST
 s3erofs_test_LDADD = liberofs.la
 endif
+
+if ENABLE_OCI
+noinst_PROGRAMS = ocierofs_test
+ocierofs_test_SOURCES = remotes/oci.c
+ocierofs_test_CFLAGS = -Wall -I$(top_srcdir)/include ${json_c_CFLAGS} -DTEST
+ocierofs_test_LDADD = liberofs.la
+endif
diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
index ac8d495..c1d6cae 100644
--- a/lib/remotes/oci.c
+++ b/lib/remotes/oci.c
@@ -1038,7 +1038,9 @@ static int ocierofs_parse_ref(struct ocierofs_ctx *ctx, const char *ref_str)
 	slash = strchr(ref_str, '/');
 	if (slash) {
 		dot = strchr(ref_str, '.');
-		if (dot && dot < slash) {
+		colon = strchr(ref_str, ':');
+		/* a dot or colon before the slash indicating a registry */
+		if ((dot && dot < slash) || (colon && colon < slash)) {
 			len = slash - ref_str;
 			tmp = strndup(ref_str, len);
 			if (!tmp)
@@ -1057,48 +1059,32 @@ static int ocierofs_parse_ref(struct ocierofs_ctx *ctx, const char *ref_str)
 	if (colon) {
 		len = colon - repo_part;
 		tmp = strndup(repo_part, len);
-		if (!tmp)
-			return -ENOMEM;
+	} else {
+		tmp = strdup(repo_part);
+	}
+	if (!tmp)
+		return -ENOMEM;
 
-		if (!strchr(tmp, '/') &&
-		    (!strcmp(ctx->registry, DOCKER_API_REGISTRY) ||
-		     !strcmp(ctx->registry, DOCKER_REGISTRY))) {
-			char *full_repo;
+	if (!strchr(tmp, '/') &&
+	    (!strcmp(ctx->registry, DOCKER_API_REGISTRY) ||
+	     !strcmp(ctx->registry, DOCKER_REGISTRY))) {
+		char *full_repo;
 
-			if (asprintf(&full_repo, "library/%s", tmp) == -1) {
-				free(tmp);
-				return -ENOMEM;
-			}
+		if (asprintf(&full_repo, "library/%s", tmp) == -1) {
 			free(tmp);
-			tmp = full_repo;
+			return -ENOMEM;
 		}
-		free(ctx->repository);
-		ctx->repository = tmp;
+		free(tmp);
+		tmp = full_repo;
+	}
+	free(ctx->repository);
+	ctx->repository = tmp;
 
+	if (colon) {
 		free(ctx->tag);
 		ctx->tag = strdup(colon + 1);
 		if (!ctx->tag)
 			return -ENOMEM;
-	} else {
-		tmp = strdup(repo_part);
-		if (!tmp)
-			return -ENOMEM;
-
-		if (!strchr(tmp, '/') &&
-		    (!strcmp(ctx->registry, DOCKER_API_REGISTRY) ||
-		     !strcmp(ctx->registry, DOCKER_REGISTRY))) {
-
-			char *full_repo;
-
-			if (asprintf(&full_repo, "library/%s", tmp) == -1) {
-				free(tmp);
-				return -ENOMEM;
-			}
-			free(tmp);
-			tmp = full_repo;
-		}
-		free(ctx->repository);
-		ctx->repository = tmp;
 	}
 	return 0;
 }
@@ -1575,3 +1561,169 @@ int ocierofs_io_open(struct erofs_vfile *vfile, const struct ocierofs_config *cf
 	return -EOPNOTSUPP;
 }
 #endif
+
+#if defined(OCIEROFS_ENABLED) && defined(TEST)
+struct ocierofs_parse_ref_testcase {
+	const char *name;
+	const char *ref_str;
+	const char *expected_registry;
+	const char *expected_repository;
+	const char *expected_tag;
+};
+
+static bool run_ocierofs_parse_ref_test(const struct ocierofs_parse_ref_testcase *tc)
+{
+	struct ocierofs_ctx ctx = {};
+	int ret;
+
+	printf("Running test: %s\n", tc->name);
+
+	/* Initialize with default values */
+	ctx.registry = strdup(DOCKER_API_REGISTRY);
+	ctx.tag = strdup("latest");
+	if (!ctx.registry || !ctx.tag) {
+		printf("  FAILED: memory allocation error during setup\n");
+		free(ctx.registry);
+		free(ctx.tag);
+		return false;
+	}
+
+	ret = ocierofs_parse_ref(&ctx, tc->ref_str);
+	if (ret < 0) {
+		printf("  FAILED: ocierofs_parse_ref returned %d\n", ret);
+		goto cleanup;
+	}
+
+	if (tc->expected_registry && strcmp(ctx.registry, tc->expected_registry) != 0) {
+		printf("  FAILED: registry mismatch\n");
+		printf("    Expected: %s\n", tc->expected_registry);
+		printf("    Got:      %s\n", ctx.registry);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (tc->expected_repository && strcmp(ctx.repository, tc->expected_repository) != 0) {
+		printf("  FAILED: repository mismatch\n");
+		printf("    Expected: %s\n", tc->expected_repository);
+		printf("    Got:      %s\n", ctx.repository);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (tc->expected_tag && strcmp(ctx.tag, tc->expected_tag) != 0) {
+		printf("  FAILED: tag mismatch\n");
+		printf("    Expected: %s\n", tc->expected_tag);
+		printf("    Got:      %s\n", ctx.tag);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	printf("  PASSED\n");
+	printf("    Registry:   %s\n", ctx.registry);
+	printf("    Repository: %s\n", ctx.repository);
+	printf("    Tag:        %s\n", ctx.tag);
+
+cleanup:
+	free(ctx.registry);
+	free(ctx.repository);
+	free(ctx.tag);
+	return ret == 0;
+}
+
+static int test_ocierofs_parse_ref(void)
+{
+	struct ocierofs_parse_ref_testcase tests[] = {
+		{
+			.name = "Simple image name (Docker Hub library)",
+			.ref_str = "nginx",
+			.expected_registry = DOCKER_API_REGISTRY,
+			.expected_repository = "library/nginx",
+			.expected_tag = "latest",
+		},
+		{
+			.name = "Image with tag (Docker Hub library)",
+			.ref_str = "nginx:1.21",
+			.expected_registry = DOCKER_API_REGISTRY,
+			.expected_repository = "library/nginx",
+			.expected_tag = "1.21",
+		},
+		{
+			.name = "User repository without tag",
+			.ref_str = "user/myapp",
+			.expected_registry = DOCKER_API_REGISTRY,
+			.expected_repository = "user/myapp",
+			.expected_tag = "latest",
+		},
+		{
+			.name = "User repository with tag",
+			.ref_str = "user/myapp:v2.0",
+			.expected_registry = DOCKER_API_REGISTRY,
+			.expected_repository = "user/myapp",
+			.expected_tag = "v2.0",
+		},
+		{
+			.name = "Custom registry without tag",
+			.ref_str = "registry.example.com/myapp",
+			.expected_registry = "registry.example.com",
+			.expected_repository = "myapp",
+			.expected_tag = "latest",
+		},
+		{
+			.name = "Custom registry with tag",
+			.ref_str = "registry.example.com/myapp:v1.0",
+			.expected_registry = "registry.example.com",
+			.expected_repository = "myapp",
+			.expected_tag = "v1.0",
+		},
+		{
+			.name = "Custom registry with port",
+			.ref_str = "localhost:5000/myapp:latest",
+			.expected_registry = "localhost:5000",
+			.expected_repository = "myapp",
+			.expected_tag = "latest",
+		},
+		{
+			.name = "Custom registry with ip & port",
+			.ref_str = "127.0.0.1:5000/myapp:latest",
+			.expected_registry = "127.0.0.1:5000",
+			.expected_repository = "myapp",
+			.expected_tag = "latest",
+		},
+		{
+			.name = "Custom registry with nested repository",
+			.ref_str = "registry.example.com/org/project/app:dev",
+			.expected_registry = "registry.example.com",
+			.expected_repository = "org/project/app",
+			.expected_tag = "dev",
+		},
+		{
+			.name = "Tag with digest-like format",
+			.ref_str = "myapp:sha256-abc123",
+			.expected_registry = DOCKER_API_REGISTRY,
+			.expected_repository = "library/myapp",
+			.expected_tag = "sha256-abc123",
+		},
+		{
+			.name = "Multi-level path without registry",
+			.ref_str = "org/team/app:v1",
+			.expected_registry = DOCKER_API_REGISTRY,
+			.expected_repository = "org/team/app",
+			.expected_tag = "v1",
+		},
+	};
+	int i, pass = 0;
+
+	for (i = 0; i < ARRAY_SIZE(tests); ++i) {
+		pass += run_ocierofs_parse_ref_test(&tests[i]);
+		putc('\n', stdout);
+	}
+
+	printf("Run all %d tests with %d PASSED\n", i, pass);
+	return ARRAY_SIZE(tests) == pass;
+}
+
+int main(int argc, char *argv[])
+{
+	exit(test_ocierofs_parse_ref() ? EXIT_SUCCESS : EXIT_FAILURE);
+}
+#endif
\ No newline at end of file
-- 
2.43.0


