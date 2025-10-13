Return-Path: <linux-erofs+bounces-1179-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F102BD1530
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Oct 2025 05:32:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4clNG030H2z2yrT;
	Mon, 13 Oct 2025 14:32:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760326360;
	cv=none; b=W50XLoVjhCuYKZfcYrDbM6Oq+dMpdw0SAN1yjXPeYBxjLhdROra9c+s3vcBa5kN0gINDYnF3YfnkSMm3XvzCVkwwS79sYz/kJQsbDFo5uEGk3gnW8bi/7O8p7s61+CPoLs8L75cznRYgZYZlrIDeluns35VSglYOYc0PkaKU0Kb3JBj6kgcmsqoRmtyeG2iUGlH7uELOq5CABE7jYCDtPbQ9MkhH3V0Rx9gU1ccJtr3gN9lELc0Mq34MKATwzM+zJ3Zps2zpzqlAWqO1No763ZV5i6qAU3xOFrz+vc9SK5EyoXLg0+21AJ/PekhLTn7fl7Dc1bYZgxX27ABfmI/3UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760326360; c=relaxed/relaxed;
	bh=rU9NZWGDKo77/szyK333BgwZ4xQ+H3N6Onu4WTgOk+4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Av90WDVpgckDIQMEx5IRGU79YlAtEswJWfnc1ChTPo+zW1cBGY231fQX7lQa3dkDaBPPWe2BcosT9Ffg1aZsXK52fyanD4M3GRfQbNFVgT0slq6eyTr7FhEAPZkXFF94gOA5YzMkee8n4RQo1WQ59GxKYPECEXL5JbWgWhApEbh5pIbtQ64LfFoWaH3Fgrv3vUbuMzO3vkEEHB4Gmkd2h2DzmlRXdZfBDp/0jYeWZGVNGisXP39n7aIzGYw0JwDgp/CrooytA5JUwShIwVPRPyJbbH7lkud4vtp/PD03BNJgBL4UdETETi8frD75Y5+uhvr/2U0FJWPQ5q2tdXxeWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=5K0VpSBD; dkim-atps=neutral; spf=pass (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=5K0VpSBD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4clNFy6sJqz301G
	for <linux-erofs@lists.ozlabs.org>; Mon, 13 Oct 2025 14:32:38 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=rU9NZWGDKo77/szyK333BgwZ4xQ+H3N6Onu4WTgOk+4=;
	b=5K0VpSBDXHBprXoeOk5V7q2BQG+ikIO2hIkVZtCTeNcx9pOTZAOID83CVq/EiJfkNw8vwM4Eg
	SDpBD2tmcwg+P/kLaP5LVc9mr2oFUC5o4JQxn5IceEXJUtYIULo4IcDxmY60q4vZqSn7YnkBnP5
	1Jl6C1GKLyQb31yRckRvIDw=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4clNFQ0q7pzRhR8
	for <linux-erofs@lists.ozlabs.org>; Mon, 13 Oct 2025 11:32:10 +0800 (CST)
Received: from kwepemp500007.china.huawei.com (unknown [7.202.195.151])
	by mail.maildlp.com (Postfix) with ESMTPS id 2CC5A180064
	for <linux-erofs@lists.ozlabs.org>; Mon, 13 Oct 2025 11:32:29 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemp500007.china.huawei.com
 (7.202.195.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 13 Oct
 2025 11:32:28 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <jingrui@huawei.com>
Subject: [PATCH 1/2] erofs-utils: lib: simplify s3erofs_prepare_url logic
Date: Mon, 13 Oct 2025 11:32:21 +0800
Message-ID: <20251013033222.31072-1-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.46.0
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
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemp500007.china.huawei.com (7.202.195.151)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

`mkfs.erofs` failed to generate image from Huawei OBS with the following command:

	mkfs.erofs --s3=<endpoint>,urlstyle=vhost,sig=2 s3.erofs test-bucket

because it mistakenly generated a url with repeated '/':

	https://test-bucket.<endpoint>//<keyname>

In fact, the splitting of bucket name and path has already been performed prior
to the call to `s3erofs_prepare_url`, and this function does not need to handle
this logic. This patch simplifies this part accordingly and fixes the problem.

Fixes: 29728ba8f6f6 ("erofs-utils: mkfs: support EROFS meta-only image generation from S3")
Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 lib/remotes/s3.c | 226 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 201 insertions(+), 25 deletions(-)

diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
index 2e7763e..0f24c65 100644
--- a/lib/remotes/s3.c
+++ b/lib/remotes/s3.c
@@ -41,17 +41,16 @@ struct s3erofs_curl_request {
 
 static int s3erofs_prepare_url(struct s3erofs_curl_request *req,
 			       const char *endpoint,
-			       const char *path, const char *key,
+			       const char *bucket, const char *key,
 			       struct s3erofs_query_params *params,
 			       enum s3erofs_url_style url_style)
 {
 	static const char https[] = "https://";
 	const char *schema, *host;
-	bool slash = false;
 	char *url = req->url;
 	int pos, i;
 
-	if (!endpoint || !path)
+	if (!endpoint || !bucket)
 		return -EINVAL;
 
 	schema = strstr(endpoint, "://");
@@ -65,30 +64,16 @@ static int s3erofs_prepare_url(struct s3erofs_curl_request *req,
 			return -ENOMEM;
 	}
 
-	if (url_style == S3EROFS_URL_STYLE_PATH) {
-		pos = snprintf(url, S3EROFS_URL_LEN, "%s%s/%s", schema,
-			       host, path);
-	} else {
-		const char * split = strchr(path, '/');
+	if (url_style == S3EROFS_URL_STYLE_PATH)
+		pos = snprintf(url, S3EROFS_URL_LEN, "%s%s/%s/", schema, host, bucket);
+	else
+		pos = snprintf(url, S3EROFS_URL_LEN, "%s%s.%s/", schema, bucket, host);
 
-		if (!split) {
-			pos = snprintf(url, S3EROFS_URL_LEN, "%s%s.%s/",
-				       schema, path, host);
-			slash = true;
-		} else {
-			pos = snprintf(url, S3EROFS_URL_LEN, "%s%.*s.%s%s",
-				       schema, (int)(split - path), path,
-				       host, split);
-		}
-	}
-	if (key) {
-		slash |= url[pos - 1] != '/';
-		pos -= !slash;
-		pos += snprintf(url + pos, S3EROFS_URL_LEN - pos, "/%s", key);
-	}
+	if (key)
+		pos += snprintf(url + pos, S3EROFS_URL_LEN - pos, "%s", key);
 
 	i = snprintf(req->canonical_query, S3EROFS_CANONICAL_QUERY_LEN,
-		     "/%s%s%s", path, slash ? "/" : "", key ? key : "");
+		     "/%s/%s", bucket, key ? key : "");
 	req->canonical_query[i] = '\0';
 
 	for (i = 0; i < params->num; i++)
@@ -503,7 +488,7 @@ s3erofs_create_object_iterator(struct erofs_s3 *s3, const char *path,
 	if (prefix) {
 		if (++prefix - path > S3EROFS_PATH_MAX)
 			return ERR_PTR(-EINVAL);
-		iter->bucket = strndup(path, prefix - path);
+		iter->bucket = strndup(path, prefix - 1 - path);
 		iter->prefix = strdup(prefix);
 	} else {
 		iter->bucket = strdup(path);
@@ -763,3 +748,194 @@ err_global:
 	s3erofs_curl_easy_exit(s3);
 	return ret;
 }
+
+#ifdef TEST
+struct s3erofs_prepare_utl_testcase {
+	const char *name;
+	const char *endpoint;
+	const char *bucket;
+	const char *key;
+	enum s3erofs_url_style url_style;
+	const char *expected_url;
+	const char *expected_canonical;
+	int expected_ret;
+};
+
+static void run_s3erofs_prepare_url_test(const struct s3erofs_prepare_utl_testcase *tc)
+{
+	struct s3erofs_curl_request req = { .method = "GET" };
+	struct s3erofs_query_params params = { .num = 0 };
+	int ret;
+
+	printf("Running test: %s\n", tc->name);
+
+	ret = s3erofs_prepare_url(&req, tc->endpoint, tc->bucket, tc->key, &params,
+				  tc->url_style);
+
+	if (ret != tc->expected_ret) {
+		printf("  FAILED: expected return %d, got %d\n", tc->expected_ret, ret);
+		return;
+	}
+
+	if (ret < 0) {
+		printf("  PASSED (expected error)\n");
+		return;
+	}
+
+	if (tc->expected_url && strcmp(req.url, tc->expected_url) != 0) {
+		printf("  FAILED: URL mismatch\n");
+		printf("    Expected: %s\n", tc->expected_url);
+		printf("    Got:      %s\n", req.url);
+		return;
+	}
+
+	if (tc->expected_canonical &&
+	    strcmp(req.canonical_query, tc->expected_canonical) != 0) {
+		printf("  FAILED: Canonical query mismatch\n");
+		printf("    Expected: %s\n", tc->expected_canonical);
+		printf("    Got:      %s\n", req.canonical_query);
+		return;
+	}
+
+	printf("  PASSED\n");
+	printf("    URL: %s\n", req.url);
+	printf("    Canonical: %s\n", req.canonical_query);
+}
+
+static void test_s3erofs_prepare_url()
+{
+	struct s3erofs_prepare_utl_testcase tests[] = {
+		{
+			.name = "Virtual-hosted style with https",
+			.endpoint = "s3.amazonaws.com",
+			.bucket = "my-bucket",
+			.key = "path/to/object.txt",
+			.url_style = S3EROFS_URL_STYLE_VIRTUAL_HOST,
+			.expected_url =
+				"https://my-bucket.s3.amazonaws.com/path/to/object.txt",
+			.expected_canonical = "/my-bucket/path/to/object.txt",
+			.expected_ret = 0,
+		},
+		{
+			.name = "Path style with https",
+			.endpoint = "s3.amazonaws.com",
+			.bucket = "my-bucket",
+			.key = "path/to/object.txt",
+			.url_style = S3EROFS_URL_STYLE_PATH,
+			.expected_url =
+				"https://s3.amazonaws.com/my-bucket/path/to/object.txt",
+			.expected_canonical = "/my-bucket/path/to/object.txt",
+			.expected_ret = 0,
+		},
+		{
+			.name = "Virtual-hosted with explicit https://",
+			.endpoint = "https://s3.us-west-2.amazonaws.com",
+			.bucket = "test-bucket",
+			.key = "file.bin",
+			.url_style = S3EROFS_URL_STYLE_VIRTUAL_HOST,
+			.expected_url =
+				"https://test-bucket.s3.us-west-2.amazonaws.com/file.bin",
+			.expected_canonical = "/test-bucket/file.bin",
+			.expected_ret = 0,
+		},
+		{
+			.name = "Path style with explicit http://",
+			.endpoint = "http://localhost:9000",
+			.bucket = "local-bucket",
+			.key = "data/file.dat",
+			.url_style = S3EROFS_URL_STYLE_PATH,
+			.expected_url =
+				"http://localhost:9000/local-bucket/data/file.dat",
+			.expected_canonical = "/local-bucket/data/file.dat",
+			.expected_ret = 0,
+		},
+		{
+			.name = "Virtual-hosted style with key ends with slash",
+			.endpoint = "http://localhost:9000",
+			.bucket = "local-bucket",
+			.key = "data/file.dat/",
+			.url_style = S3EROFS_URL_STYLE_VIRTUAL_HOST,
+			.expected_url =
+				"http://local-bucket.localhost:9000/data/file.dat/",
+			.expected_canonical = "/local-bucket/data/file.dat/",
+			.expected_ret = 0,
+		},
+		{
+			.name = "Path style with key ends with slash",
+			.endpoint = "http://localhost:9000",
+			.bucket = "local-bucket",
+			.key = "data/file.dat/",
+			.url_style = S3EROFS_URL_STYLE_PATH,
+			.expected_url =
+				"http://localhost:9000/local-bucket/data/file.dat/",
+			.expected_canonical = "/local-bucket/data/file.dat/",
+			.expected_ret = 0,
+		},
+		{
+			.name = "Virtual-hosted without key",
+			.endpoint = "s3.amazonaws.com",
+			.bucket = "my-bucket",
+			.key = NULL,
+			.url_style = S3EROFS_URL_STYLE_VIRTUAL_HOST,
+			.expected_url = "https://my-bucket.s3.amazonaws.com/",
+			.expected_canonical = "/my-bucket/",
+			.expected_ret = 0,
+		},
+		{
+			.name = "Path style without key",
+			.endpoint = "s3.amazonaws.com",
+			.bucket = "my-bucket",
+			.key = NULL,
+			.url_style = S3EROFS_URL_STYLE_PATH,
+			.expected_url = "https://s3.amazonaws.com/my-bucket/",
+			.expected_canonical = "/my-bucket/",
+			.expected_ret = 0,
+		},
+		{
+			.name = "Error: NULL endpoint",
+			.endpoint = NULL,
+			.bucket = "my-bucket",
+			.key = "file.txt",
+			.url_style = S3EROFS_URL_STYLE_PATH,
+			.expected_url = NULL,
+			.expected_canonical = NULL,
+			.expected_ret = -EINVAL,
+		},
+		{
+			.name = "Error: NULL bucket",
+			.endpoint = "s3.amazonaws.com",
+			.bucket = NULL,
+			.key = "file.txt",
+			.url_style = S3EROFS_URL_STYLE_PATH,
+			.expected_url = NULL,
+			.expected_canonical = NULL,
+			.expected_ret = -EINVAL,
+		},
+		{
+			.name = "Key with special characters",
+			.endpoint = "s3.amazonaws.com",
+			.bucket = "bucket",
+			.key = "path/to/file-name_v2.0.txt",
+			.url_style = S3EROFS_URL_STYLE_VIRTUAL_HOST,
+			.expected_url =
+				"https://bucket.s3.amazonaws.com/path/to/file-name_v2.0.txt",
+			.expected_canonical = "/bucket/path/to/file-name_v2.0.txt",
+			.expected_ret = 0,
+		}
+	};
+
+	int num_tests = sizeof(tests) / sizeof(tests[0]);
+
+	for (int i = 0; i < num_tests; i++) {
+		run_s3erofs_prepare_url_test(&tests[i]);
+		printf("\n");
+	}
+
+	printf("Run all %d tests\n", num_tests);
+}
+
+int main(int argc, char *argv[])
+{
+	test_s3erofs_prepare_url();
+}
+#endif
-- 
2.46.0


