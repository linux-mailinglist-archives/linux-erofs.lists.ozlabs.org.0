Return-Path: <linux-erofs+bounces-1834-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD537D16C64
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Jan 2026 07:12:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dqzRH0ZrPz2xKx;
	Tue, 13 Jan 2026 17:11:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.225
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768284715;
	cv=none; b=WcrAt7iqVSeQf3GYmKZlTsi/Gwr7qvKW62uDb8veOUwwfoqZE25Z7Dm9jA6qvRI/ZNOSel2ccOAO9uSLvpovvHxu8IK8lUFaEBYAYEQVQ0SAZgODp4JveSSpeRmobqni/L8cLYJURgrKWPgxJFQH5U/BdLtQfQM3wkQke2K5+pIyy0L4qUob+XZQBqejSylj9xURdbUOu7wYoM68gGzqFPlwcgOauxuUf7sITn9I7gfwMmWbwrrqbNGhpwSF34uxP74LDj2fXxc3KvOGIk7I2fMMkBNHNpvGPTfng4QM1cWQsJ86b0d4VUzl7wbqZ2+fCpMCdPgsE8Ro8yjZLk745A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768284715; c=relaxed/relaxed;
	bh=uTFexSLZINx1zQYb/Aw5Nj729oObyXDx2xfwugiSOks=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nMxpswdqcSNisyfMPribCtfdtBrYPMFrB8Y+SBq80SdmHjUHQMF927W9/dmssnU5hsbxvOOxyjI6GQ7ZtQ2s8IAIAeoL8FzrDDVNKhCw/MhK1Cguh0/jbxxOUnFDso1IG0LzB9sRJtEI8UxvZblVJmHJke3ww5Kg8BL5cQsq4zqDZpy1E0xYxfHxmtW40OB6iYkxO5Pe2RurZCqWW2c8Wl+RmNgdORKBsJs0GUdX9D17isBksX1NN6CEwsKYNdGal/YL7Isc9MmmuvkK0K7PUi32ECqzggOCEvSQ8LNcNIdv5JRNclapWfKLvq+si8meEJ5KedDgjAhwGwK/g6wuvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=oT2qHh4P; dkim-atps=neutral; spf=pass (client-ip=113.46.200.225; helo=canpmsgout10.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=oT2qHh4P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.225; helo=canpmsgout10.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dqzRC1jVVz2xHP
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Jan 2026 17:11:49 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=uTFexSLZINx1zQYb/Aw5Nj729oObyXDx2xfwugiSOks=;
	b=oT2qHh4PA2+ZvrcqsIqpSOTfXIcmOJlqi0gg8JfSmRanHTYvOm4A9BKqnDai97YM5TsN9mDM7
	LZzydfQ2ldYWlFM8oRccc7CQ2ryOr9a7TSqTLUJgNdOxdko8MsbuiPmaEFvRIJ761U3LcYVLmuT
	EeUtbxU5UBnftCzjGUueh5U=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4dqzMJ2fSqz1K971
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Jan 2026 14:08:28 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 38FBF40363
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Jan 2026 14:11:45 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 13 Jan
 2026 14:11:44 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <jingrui@huawei.com>, <wayne.ma@huawei.com>, <zhaoyifan28@huawei.com>
Subject: [PATCH 3/3] erofs-utils: lib: s3: properly escape object key names
Date: Tue, 13 Jan 2026 14:11:49 +0800
Message-ID: <20260113061149.3630464-3-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260113061149.3630464-1-zhaoyifan28@huawei.com>
References: <20260113061149.3630464-1-zhaoyifan28@huawei.com>
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

The current implementation does not correctly handle the escaping of
object key names. This patch ensures compliance with the AWS S3
documentation [1] for proper key name encoding and character handling.

[1] https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-keys.html

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 lib/remotes/s3.c | 115 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 105 insertions(+), 10 deletions(-)

diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
index 8351674..a5b27eb 100644
--- a/lib/remotes/s3.c
+++ b/lib/remotes/s3.c
@@ -61,11 +61,17 @@ static const char *s3erofs_parse_host(const char *endpoint, const char **schema)
 	return host;
 }
 
-static void *s3erofs_urlencode(const char *input)
+enum s3erofs_urlencode_mode {
+	S3EROFS_URLENCODE_QUERY_PARAM,
+	S3EROFS_URLENCODE_S3_KEY,
+};
+
+static void *s3erofs_urlencode(const char *input, enum s3erofs_urlencode_mode mode)
 {
 	static const char hex[] = "0123456789ABCDEF";
 	char *p, *url;
 	int i, c;
+	bool safe;
 
 	url = malloc(strlen(input) * 3 + 1);
 	if (!url)
@@ -73,13 +79,31 @@ static void *s3erofs_urlencode(const char *input)
 
 	p = url;
 	for (i = 0; i < strlen(input); ++i) {
-		c = input[i];
-
-		// Unreserved characters: A-Z a-z 0-9 - . _ ~
-		if (isalpha(c) || isdigit(c) || c == '-' || c == '.' ||
-		    c == '_' || c == '~') {
+		c = (unsigned char)input[i];
+
+		if (mode == S3EROFS_URLENCODE_S3_KEY)
+			/*
+			 * AWS S3 safe characters for object key names:
+			 * - Alphanumeric: 0-9 a-z A-Z
+			 * - Special: ! - _ . * ' ( )
+			 * - Forward slash (/) for hierarchy
+			 * See: https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-keys.html
+			 */
+			safe = isalpha(c) || isdigit(c) || c == '!' || c == '-' ||
+			       c == '_' || c == '.' || c == '*' || c == '(' || c == ')' ||
+			       c == '\'' || c == '/';
+		else
+			/*
+			 * URL encode query parameters
+			 * See: https://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-header-based-auth.html#create-signature-presign-entire-payload
+			 */
+			safe = isalpha(c) || isdigit(c) || c == '-' || c == '.' ||
+			       c == '_' || c == '~';
+
+		if (safe) {
 			*p++ = c;
 		} else {
+			/* URL encode this character */
 			*p++ = '%';
 			*p++ = hex[c >> 4];
 			*p++ = hex[c & 0x0F];
@@ -111,13 +135,13 @@ static int s3erofs_prepare_canonical_query(struct s3erofs_curl_request *req,
 
 	pairs = calloc(1, sizeof(struct s3erofs_qsort_kv) * params->num);
 	for (i = 0; i < params->num; i++) {
-		pairs[i].key = s3erofs_urlencode(params->key[i]);
+		pairs[i].key = s3erofs_urlencode(params->key[i], S3EROFS_URLENCODE_QUERY_PARAM);
 		if (IS_ERR(pairs[i].key)) {
 			ret = PTR_ERR(pairs[i].key);
 			pairs[i].key = NULL;
 			goto out;
 		}
-		pairs[i].value = s3erofs_urlencode(params->value[i]);
+		pairs[i].value = s3erofs_urlencode(params->value[i], S3EROFS_URLENCODE_QUERY_PARAM);
 		if (IS_ERR(pairs[i].value)) {
 			ret = PTR_ERR(pairs[i].value);
 			pairs[i].value = NULL;
@@ -154,6 +178,7 @@ static int s3erofs_prepare_url(struct s3erofs_curl_request *req,
 	bool slash = false;
 	bool bucket_domain = false;
 	char *url = req->url;
+	char *encoded_key = NULL;
 	int pos, canonical_uri_pos, i, ret = 0;
 
 	if (!endpoint)
@@ -198,11 +223,18 @@ static int s3erofs_prepare_url(struct s3erofs_curl_request *req,
 		}
 	}
 	if (key) {
+		encoded_key = s3erofs_urlencode(key, S3EROFS_URLENCODE_S3_KEY);
+		if (IS_ERR(encoded_key)) {
+			ret = PTR_ERR(encoded_key);
+			encoded_key = NULL;
+			goto err;
+		}
+
 		if (url[pos - 1] == '/')
 			--pos;
 		else
 			slash = true;
-		pos += snprintf(url + pos, S3EROFS_URL_LEN - pos, "/%s", key);
+		pos += snprintf(url + pos, S3EROFS_URL_LEN - pos, "/%s", encoded_key);
 	}
 
 	if (sig == S3EROFS_SIGNATURE_VERSION_2) {
@@ -220,7 +252,8 @@ static int s3erofs_prepare_url(struct s3erofs_curl_request *req,
 			i = 1;
 		}
 		i += snprintf(req->canonical_uri + i, S3EROFS_CANONICAL_URI_LEN - i,
-			      "%s%s%s", path, slash ? "/" : "", key ? key : "");
+			      "%s%s%s", path, slash ? "/" : "",
+			      encoded_key ? encoded_key : "");
 	} else {
 		i = snprintf(req->canonical_uri, S3EROFS_CANONICAL_URI_LEN,
 			     "%s", url + canonical_uri_pos);
@@ -241,6 +274,8 @@ static int s3erofs_prepare_url(struct s3erofs_curl_request *req,
 	erofs_dbg("Request canonical_uri %s", req->canonical_uri);
 
 err:
+	if (encoded_key)
+		free(encoded_key);
 	if (schema != https)
 		free((void *)schema);
 	return ret;
@@ -1410,6 +1445,66 @@ static bool test_s3erofs_prepare_url(void)
 			.expected_canonical_v2 = "/bucket/object.txt",
 			.expected_canonical_v4 = "/object.txt",
 			.expected_ret = 0,
+		},
+		{
+			.name = "Key with spaces",
+			.endpoint = "s3.amazonaws.com",
+			.path = "bucket",
+			.key = "my folder/my file.txt",
+			.url_style = S3EROFS_URL_STYLE_VIRTUAL_HOST,
+			.expected_url =
+				"https://bucket.s3.amazonaws.com/my%20folder/my%20file.txt",
+			.expected_canonical_v2 = "/bucket/my%20folder/my%20file.txt",
+			.expected_canonical_v4 = "/my%20folder/my%20file.txt",
+			.expected_ret = 0,
+		},
+		{
+			.name = "Key with special characters (&, $, @, =)",
+			.endpoint = "s3.amazonaws.com",
+			.path = "bucket",
+			.key = "file&name$test@sign=value.txt",
+			.url_style = S3EROFS_URL_STYLE_PATH,
+			.expected_url =
+				"https://s3.amazonaws.com/bucket/file%26name%24test%40sign%3Dvalue.txt",
+			.expected_canonical_v2 = "/bucket/file%26name%24test%40sign%3Dvalue.txt",
+			.expected_canonical_v4 = "/bucket/file%26name%24test%40sign%3Dvalue.txt",
+			.expected_ret = 0,
+		},
+		{
+			.name = "Key with semicolon, colon, and plus",
+			.endpoint = "s3.amazonaws.com",
+			.path = "bucket",
+			.key = "file;name:test+data.txt",
+			.url_style = S3EROFS_URL_STYLE_VIRTUAL_HOST,
+			.expected_url =
+				"https://bucket.s3.amazonaws.com/file%3Bname%3Atest%2Bdata.txt",
+			.expected_canonical_v2 = "/bucket/file%3Bname%3Atest%2Bdata.txt",
+			.expected_canonical_v4 = "/file%3Bname%3Atest%2Bdata.txt",
+			.expected_ret = 0,
+		},
+		{
+			.name = "Key with comma and question mark",
+			.endpoint = "s3.amazonaws.com",
+			.path = "bucket",
+			.key = "file,name?query.txt",
+			.url_style = S3EROFS_URL_STYLE_PATH,
+			.expected_url =
+				"https://s3.amazonaws.com/bucket/file%2Cname%3Fquery.txt",
+			.expected_canonical_v2 = "/bucket/file%2Cname%3Fquery.txt",
+			.expected_canonical_v4 = "/bucket/file%2Cname%3Fquery.txt",
+			.expected_ret = 0,
+		},
+		{
+			.name = "Key with multiple special characters",
+			.endpoint = "s3.amazonaws.com",
+			.path = "bucket",
+			.key = "path/to/file name & data@2024.txt",
+			.url_style = S3EROFS_URL_STYLE_VIRTUAL_HOST,
+			.expected_url =
+				"https://bucket.s3.amazonaws.com/path/to/file%20name%20%26%20data%402024.txt",
+			.expected_canonical_v2 = "/bucket/path/to/file%20name%20%26%20data%402024.txt",
+			.expected_canonical_v4 = "/path/to/file%20name%20%26%20data%402024.txt",
+			.expected_ret = 0,
 		}
 
 	};
-- 
2.47.3


