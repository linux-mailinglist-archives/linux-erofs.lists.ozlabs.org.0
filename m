Return-Path: <linux-erofs+bounces-1308-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D1790C242EA
	for <lists+linux-erofs@lfdr.de>; Fri, 31 Oct 2025 10:34:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cybRM4t05z2xWc;
	Fri, 31 Oct 2025 20:34:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761903279;
	cv=none; b=PKj2NXY/5fVTee2az/+6ARc+JIHOCkGXpsyoCmK6vzsmpFx0TNuJCUBO0/URzoeX83vc3TDEgLi1OoXKmdXvQki9stW5IK3upFw8c+vAd0hPsZzElNKYYx02FmZbcLZXcpYJ0vkfB6TFy6R4jmsIAhQk3DJmW4pu7LeRLEXWevRKJ+pdbaobqrITuAXeo5NYaiokmH5k5GRuHVixoV3d6gOzKLjB7HrB3EeQSh4s8zPkwSGOXid/XQ0zX/Av/kdux/daR1ATKyWUKBvJvCVd/vaCzJlOm3jdx75xhNbLCt6m+kcWCk+P6Yg3QYLOHjLBImm/oXU+JixiMDGen7f5mg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761903279; c=relaxed/relaxed;
	bh=CcjvnZklWQvI7xhy5x3L+YD5cmZWXFdprhRyJCQLoF8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H8jIB22YeY8xX0WGonT9tY+YZFhiw5zFDS889YBB2SKWlRIcmYA/JafBXALMn6Lzy9/pBJfmdLxwQFj89SuOQj7Qu7FaID/GQ5oGnVInyM2065ysQUnxs75shKBWyyimI0cAIuZ8tKNDPiGhTnD11z+3qBWyK//2a50+tSf4w3rAuCg654FTKFtRKgWTcft1xwe7skfjPsFFz0ttwrQCOvb1LCU5kUJp7ndd4eoplXqLyqrUMYjdQlaBgN4zWtETgudiUX56HoEx2J51AQyFzMRNiaIXoFk67AMtsnfW2I+Ig606vbpppr4zJs+FAqYcDc9T9n1aaIyQaAqkoLszOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ljJOCLz8; dkim-atps=neutral; spf=pass (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ljJOCLz8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cybRJ5XLqz2xR2
	for <linux-erofs@lists.ozlabs.org>; Fri, 31 Oct 2025 20:34:34 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=CcjvnZklWQvI7xhy5x3L+YD5cmZWXFdprhRyJCQLoF8=;
	b=ljJOCLz8d5h4P+E0WjC9P+WotEM0ympJKrGG/JuuritsZHEeQY6vVWKS0WfZd0Vxv54fPMO7y
	i9atVa4odhYytElSetYbEBdUa7U1EC8Dd5da4EQbvc5V1SvosiKAf+gxi3D7PqdfWmTg1ydK2U+
	hu5r/DI+rqBwgyoq7T27b8A=
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4cybQW5TfMz1cyQ9
	for <linux-erofs@lists.ozlabs.org>; Fri, 31 Oct 2025 17:33:55 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id CE4191A0188
	for <linux-erofs@lists.ozlabs.org>; Fri, 31 Oct 2025 17:34:25 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 31 Oct
 2025 17:34:25 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <wayne.ma@huawei.com>, <jingrui@huawei.com>
Subject: [PATCH] erofs-utils: lib: add more tests for s3erofs_prepare_url()
Date: Fri, 31 Oct 2025 17:30:37 +0800
Message-ID: <20251031093037.655851-1-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.33.0
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
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add more tests varying `path` and `key` to cover real use cases.

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 lib/remotes/s3.c | 100 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 80 insertions(+), 20 deletions(-)

diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
index 74cae8b..0f7e1a9 100644
--- a/lib/remotes/s3.c
+++ b/lib/remotes/s3.c
@@ -768,10 +768,10 @@ err_global:
 }
 
 #ifdef TEST
-struct s3erofs_prepare_utl_testcase {
+struct s3erofs_prepare_url_testcase {
 	const char *name;
 	const char *endpoint;
-	const char *bucket;
+	const char *path;
 	const char *key;
 	enum s3erofs_url_style url_style;
 	const char *expected_url;
@@ -779,7 +779,7 @@ struct s3erofs_prepare_utl_testcase {
 	int expected_ret;
 };
 
-static bool run_s3erofs_prepare_url_test(const struct s3erofs_prepare_utl_testcase *tc)
+static bool run_s3erofs_prepare_url_test(const struct s3erofs_prepare_url_testcase *tc)
 {
 	struct s3erofs_curl_request req = { .method = "GET" };
 	struct s3erofs_query_params params = { .num = 0 };
@@ -787,7 +787,7 @@ static bool run_s3erofs_prepare_url_test(const struct s3erofs_prepare_utl_testca
 
 	printf("Running test: %s\n", tc->name);
 
-	ret = s3erofs_prepare_url(&req, tc->endpoint, tc->bucket, tc->key, &params,
+	ret = s3erofs_prepare_url(&req, tc->endpoint, tc->path, tc->key, &params,
 				  tc->url_style);
 
 	if (ret != tc->expected_ret) {
@@ -823,11 +823,11 @@ static bool run_s3erofs_prepare_url_test(const struct s3erofs_prepare_utl_testca
 
 static bool test_s3erofs_prepare_url(void)
 {
-	struct s3erofs_prepare_utl_testcase tests[] = {
+	struct s3erofs_prepare_url_testcase tests[] = {
 		{
 			.name = "Virtual-hosted style with https",
 			.endpoint = "s3.amazonaws.com",
-			.bucket = "my-bucket",
+			.path = "my-bucket",
 			.key = "path/to/object.txt",
 			.url_style = S3EROFS_URL_STYLE_VIRTUAL_HOST,
 			.expected_url =
@@ -838,7 +838,7 @@ static bool test_s3erofs_prepare_url(void)
 		{
 			.name = "Path style with https",
 			.endpoint = "s3.amazonaws.com",
-			.bucket = "my-bucket",
+			.path = "my-bucket",
 			.key = "path/to/object.txt",
 			.url_style = S3EROFS_URL_STYLE_PATH,
 			.expected_url =
@@ -849,7 +849,7 @@ static bool test_s3erofs_prepare_url(void)
 		{
 			.name = "Virtual-hosted with explicit https://",
 			.endpoint = "https://s3.us-west-2.amazonaws.com",
-			.bucket = "test-bucket",
+			.path = "test-bucket",
 			.key = "file.bin",
 			.url_style = S3EROFS_URL_STYLE_VIRTUAL_HOST,
 			.expected_url =
@@ -860,7 +860,7 @@ static bool test_s3erofs_prepare_url(void)
 		{
 			.name = "Path style with explicit http://",
 			.endpoint = "http://localhost:9000",
-			.bucket = "local-bucket",
+			.path = "local-bucket",
 			.key = "data/file.dat",
 			.url_style = S3EROFS_URL_STYLE_PATH,
 			.expected_url =
@@ -871,7 +871,7 @@ static bool test_s3erofs_prepare_url(void)
 		{
 			.name = "Virtual-hosted style with key ends with slash",
 			.endpoint = "http://localhost:9000",
-			.bucket = "local-bucket",
+			.path = "local-bucket",
 			.key = "data/file.dat/",
 			.url_style = S3EROFS_URL_STYLE_VIRTUAL_HOST,
 			.expected_url =
@@ -882,7 +882,7 @@ static bool test_s3erofs_prepare_url(void)
 		{
 			.name = "Path style with key ends with slash",
 			.endpoint = "http://localhost:9000",
-			.bucket = "local-bucket",
+			.path = "local-bucket",
 			.key = "data/file.dat/",
 			.url_style = S3EROFS_URL_STYLE_PATH,
 			.expected_url =
@@ -893,7 +893,7 @@ static bool test_s3erofs_prepare_url(void)
 		{
 			.name = "Virtual-hosted without key",
 			.endpoint = "s3.amazonaws.com",
-			.bucket = "my-bucket",
+			.path = "my-bucket",
 			.key = NULL,
 			.url_style = S3EROFS_URL_STYLE_VIRTUAL_HOST,
 			.expected_url = "https://my-bucket.s3.amazonaws.com/",
@@ -903,17 +903,77 @@ static bool test_s3erofs_prepare_url(void)
 		{
 			.name = "Path style without key",
 			.endpoint = "s3.amazonaws.com",
-			.bucket = "my-bucket",
+			.path = "my-bucket",
 			.key = NULL,
 			.url_style = S3EROFS_URL_STYLE_PATH,
 			.expected_url = "https://s3.amazonaws.com/my-bucket",
 			.expected_canonical = "/my-bucket",
 			.expected_ret = 0,
 		},
+		{
+			.name = "Path style bucket ending with slash without key",
+			.endpoint = "s3.amazonaws.com",
+			.path = "bucket/",
+			.key = NULL,
+			.url_style = S3EROFS_URL_STYLE_PATH,
+			.expected_url = "https://s3.amazonaws.com/bucket/",
+			.expected_canonical = "/bucket/",
+			.expected_ret = 0,
+		},
+		{
+			.name = "Virtual-hosted bucket ending with slash without key",
+			.endpoint = "s3.amazonaws.com",
+			.path = "bucket/",
+			.key = NULL,
+			.url_style = S3EROFS_URL_STYLE_VIRTUAL_HOST,
+			.expected_url = "https://bucket.s3.amazonaws.com/",
+			.expected_canonical = "/bucket/",
+			.expected_ret = 0,
+		},
+		{
+			.name = "Path style bucket ending with slash",
+			.endpoint = "s3.amazonaws.com",
+			.path = "bucket/",
+			.key = "object.txt",
+			.url_style = S3EROFS_URL_STYLE_PATH,
+			.expected_url = "https://s3.amazonaws.com/bucket/object.txt",
+			.expected_canonical = "/bucket/object.txt",
+			.expected_ret = 0,
+		},
+		{
+			.name = "Virtual-hosted bucket ending with slash",
+			.endpoint = "s3.amazonaws.com",
+			.path = "bucket/",
+			.key = "object.txt",
+			.url_style = S3EROFS_URL_STYLE_VIRTUAL_HOST,
+			.expected_url = "https://bucket.s3.amazonaws.com/object.txt",
+			.expected_canonical = "/bucket/object.txt",
+			.expected_ret = 0,
+		},
+		{
+			.name = "Path style bucket ending with slash key with slash",
+			.endpoint = "s3.amazonaws.com",
+			.path = "bucket/",
+			.key = "a/b/c/object.txt",
+			.url_style = S3EROFS_URL_STYLE_PATH,
+			.expected_url = "https://s3.amazonaws.com/bucket/a/b/c/object.txt",
+			.expected_canonical = "/bucket/a/b/c/object.txt",
+			.expected_ret = 0,
+		},
+		{
+			.name = "Virtual-hosted bucket ending with slash key with slash",
+			.endpoint = "s3.amazonaws.com",
+			.path = "bucket/",
+			.key = "a/b/c/object.txt",
+			.url_style = S3EROFS_URL_STYLE_VIRTUAL_HOST,
+			.expected_url = "https://bucket.s3.amazonaws.com/a/b/c/object.txt",
+			.expected_canonical = "/bucket/a/b/c/object.txt",
+			.expected_ret = 0,
+		},
 		{
 			.name = "Error: NULL endpoint",
 			.endpoint = NULL,
-			.bucket = "my-bucket",
+			.path = "my-bucket",
 			.key = "file.txt",
 			.url_style = S3EROFS_URL_STYLE_PATH,
 			.expected_url = NULL,
@@ -923,7 +983,7 @@ static bool test_s3erofs_prepare_url(void)
 		{
 			.name = "Error: NULL bucket",
 			.endpoint = "s3.amazonaws.com",
-			.bucket = NULL,
+			.path = NULL,
 			.key = "file.txt",
 			.url_style = S3EROFS_URL_STYLE_PATH,
 			.expected_url = NULL,
@@ -933,7 +993,7 @@ static bool test_s3erofs_prepare_url(void)
 		{
 			.name = "Key with special characters",
 			.endpoint = "s3.amazonaws.com",
-			.bucket = "bucket",
+			.path = "bucket",
 			.key = "path/to/file-name_v2.0.txt",
 			.url_style = S3EROFS_URL_STYLE_VIRTUAL_HOST,
 			.expected_url =
@@ -942,16 +1002,16 @@ static bool test_s3erofs_prepare_url(void)
 			.expected_ret = 0,
 		}
 	};
-	bool succ = true;
 	int i;
+	int pass = 0;
 
 	for (i = 0; i < ARRAY_SIZE(tests); ++i) {
-		succ &= run_s3erofs_prepare_url_test(&tests[i]);
+		pass += run_s3erofs_prepare_url_test(&tests[i]);
 		putc('\n', stdout);
 	}
 
-	printf("Run all %d tests\n", i);
-	return succ;
+	printf("Run all %d tests with %d PASSED\n", i, pass);
+	return ARRAY_SIZE(tests) == pass;
 }
 
 int main(int argc, char *argv[])
-- 
2.33.0


