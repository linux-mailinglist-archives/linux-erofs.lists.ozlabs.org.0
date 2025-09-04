Return-Path: <linux-erofs+bounces-970-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E10B434C8
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Sep 2025 09:57:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cHWzQ2ZJQz2xnM;
	Thu,  4 Sep 2025 17:57:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756972642;
	cv=none; b=Aix+grc5b4tyykHQiiwiSycGIyedV8qAItaNAQKZTZEd/NPUq/7IpO3VuJ0l/S1OszWSR//0tFEkv+kF2B9TUnXiXHMxxR1yGeSWWolqFhhfVOVHT7ZG2CR8I8IXhaBiSw98ndrTSF1I+Ln/hfuuLzme0PF/tGq9KrFLpX79z/v/aXBkEgGpSoY8mlHjJ14+oLdALP84R20ca2mlZWYrb5BS1kqoDk6rmoNlwimYkSdziKUTX31uHaLiRnfmuPffhLuDcwCVeU8R6xJtoewRjs7NwM0xKgWl2jnD3y7w3JykAQEPPKmp1WgHY96h3/MsHtlrbX7/1dL+IIYibVfywQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756972642; c=relaxed/relaxed;
	bh=zrQ6jSogSG+NLQE8Ui8aw19HhkdgE7qs5tWT6ZdounQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b2izYa1P+7+23snd+bXAIO0GWgq8VNdJDZoAjDmq9bdLKKDAHlHWOkogrZf6MT3vg/EVtXSRcAHfx32Rokjfcaf+qrvgM5zXd4tT7+86sCFzV9gL9pS3a1y0DlGcjaizR1LgyyLq/vRtoUh41xWCB0oBRE6Fmu34yiweBBJAoWPhU5tvo24BKjQ2E5x5cIdccTK6FLfsZxSgn//cn1ZBHwfbI4kzLqQIXtHwpwFaP+AV1LlP/G5PIqWtx9E3CwNm5Me/E7vhSkvtfzXHCRxFYJTC03qWeJVDKEFd+SIs8ege9OitW3n9kZrdCsDxE1l1fUWIM5PMWrfr7j0jV5Rv4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=twsZ1te9; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=twsZ1te9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cHWzM0F6Dz2xd6
	for <linux-erofs@lists.ozlabs.org>; Thu,  4 Sep 2025 17:57:17 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756972633; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=zrQ6jSogSG+NLQE8Ui8aw19HhkdgE7qs5tWT6ZdounQ=;
	b=twsZ1te9eTP0jWffeL8FOowrtGG8xuAikNnWby3u+vKeJZZGyghAmiHyDSvQ9tqARrmg4TWUwrbeUdfnQn9+qojNcQ3PNmb/uTAVDTT4MA2bSackZuQASI1OflgNz2CIjy4fcP7XIbnogpp5mk8DzeYU6HsSMsjMxLvYlD1vTKY=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WnF..rn_1756972626 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 04 Sep 2025 15:57:12 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH] erofs-utils: lib: oci: cleanup ocierofs_get_auth_token()
Date: Thu,  4 Sep 2025 15:57:04 +0800
Message-ID: <20250904075704.4024908-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_FRAUD_PHISH,
	T_FILL_THIS_FORM_SHORT,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

 - `registry` and `repository` doesn't need to be passed in again;

 - `ctx->auth_header` can be assigned directly.

Cc: Chengyu Zhu <hudsonzhu@tencent.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/remotes/oci.c | 46 +++++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
index f2b08b2..189b634 100644
--- a/lib/remotes/oci.c
+++ b/lib/remotes/oci.c
@@ -511,9 +511,8 @@ static char *ocierofs_discover_auth_endpoint(struct ocierofs_ctx *ctx,
 	return result;
 }
 
-static char *ocierofs_get_auth_token(struct ocierofs_ctx *ctx, const char *registry,
-				     const char *repository, const char *username,
-				     const char *password)
+static int ocierofs_get_auth_token(struct ocierofs_ctx *ctx, const char *username,
+				   const char *password)
 {
 	static const char * const auth_patterns[] = {
 		"https://%s/v2/auth",
@@ -521,8 +520,9 @@ static char *ocierofs_get_auth_token(struct ocierofs_ctx *ctx, const char *regis
 		"https://%s/token",
 		NULL,
 	};
-	char *auth_header = NULL;
-	char *discovered_auth_url = NULL;
+	const char *registry = ctx->registry;
+	const char *repository = ctx->repository;
+	char *auth_header, *discovered_auth_url;
 	char *discovered_service = NULL;
 	const char *service = registry;
 	bool docker_reg;
@@ -535,8 +535,10 @@ static char *ocierofs_get_auth_token(struct ocierofs_ctx *ctx, const char *regis
 		auth_header = ocierofs_get_auth_token_with_url(ctx,
 				"https://auth.docker.io/token", service, repository,
 				username, password);
-		if (!IS_ERR(auth_header))
-			return auth_header;
+		if (!IS_ERR(auth_header)) {
+			ctx->auth_header = auth_header;
+			return 0;
+		}
 	}
 
 	discovered_auth_url = ocierofs_discover_auth_endpoint(ctx, registry, repository);
@@ -579,8 +581,10 @@ static char *ocierofs_get_auth_token(struct ocierofs_ctx *ctx, const char *regis
 							       username, password);
 		free(discovered_auth_url);
 		free(discovered_service);
-		if (!IS_ERR(auth_header))
-			return auth_header;
+		if (!IS_ERR(auth_header)) {
+			ctx->auth_header = auth_header;
+			return 0;
+		}
 	}
 
 	for (i = 0; auth_patterns[i]; i++) {
@@ -594,12 +598,16 @@ static char *ocierofs_get_auth_token(struct ocierofs_ctx *ctx, const char *regis
 							       username, password);
 		free(auth_url);
 
-		if (!IS_ERR(auth_header))
-			return auth_header;
-		if (!docker_reg)
-			return NULL;
+		if (!IS_ERR(auth_header)) {
+			ctx->auth_header = auth_header;
+			return 0;
+		}
+		if (!docker_reg) {
+			ctx->auth_header = NULL;
+			return 0;
+		}
 	}
-	return ERR_PTR(-ENOENT);
+	return -ENOENT;
 }
 
 static char *ocierofs_get_manifest_digest(struct ocierofs_ctx *ctx,
@@ -863,19 +871,15 @@ static int ocierofs_prepare_auth(struct ocierofs_ctx *ctx,
 				 const char *password)
 {
 	char *auth_header = NULL;
-	int ret = 0;
+	int ret;
 
 	ctx->using_basic = false;
 	free(ctx->auth_header);
 	ctx->auth_header = NULL;
 
-	auth_header = ocierofs_get_auth_token(ctx, ctx->registry,
-					      ctx->repository,
-					      username, password);
-	if (!IS_ERR(auth_header)) {
-		ctx->auth_header = auth_header;
+	ret = ocierofs_get_auth_token(ctx, username, password);
+	if (!ret)
 		return 0;
-	}
 
 	if (username && password && *username && *password) {
 		ret = ocierofs_curl_setup_basic_auth(ctx->curl,
-- 
2.43.5


