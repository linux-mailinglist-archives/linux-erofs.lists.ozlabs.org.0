Return-Path: <linux-erofs+bounces-1503-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BD3CC6590
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Dec 2025 08:16:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dWQ8f2CkFz2yhX;
	Wed, 17 Dec 2025 18:16:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765955810;
	cv=none; b=I3yoE9q0B8XPr9pT+FAS3gxKMT6rsh2s6Rwfik9vIlW6jOk9JUrtQRN5l+l6ZZ/qyqNA8jzMsA9fhjywKAgCDTmRlvzecVpBSyGDpcDtM85MIPEltBL+SLdwFJ9SKoxxvA5zmn5ZFbMB+TIp62Nhe1fZe+grTYn4ncSLhAyAwCYtojBzEHSae7SVi6KSN0vt0/eJiQkJ1955xeV8Fa9k871NE4rnoOezFZwVjC1eqzfM5WYejTSl6DzanS3Az+hRNU0acZQd2heRLJ5ix68tAIQxr3B8F+daHDg+PgUiTgRLMYrQxYcBOlZGF3NkaytWBpQLq596DEMKtdC9yjo4kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765955810; c=relaxed/relaxed;
	bh=329GlnPlyVErPOD02wc7xeLQ4F/qXvANt7pFyz3xbIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LfiW5EZvyx4W9oIxVSxDyES/QegRNfAMrnjaarVmO2YWTdGr+cOeW9E432ULDwtJhbujZDHWAvxuusMAxzbgH+qSr5jgZ1F/AdhPYPUMvp233+1xVQJqiV2WzCADW58zsFxBrklnrWdhQ6UnRmFsv2f6sQi+2M4KXm4pX0LC8jBrUYVbovd5NK7qwX7A972uyPj4id5ab9gcJgrkTbsUrb7rj0SEw2HzDZCCOSfuGf/4JJebp1Zqn2a8yXZ5gFxaQbKvtX87BSdlpKTykMWbZDmZ+i9Z9fwYI4MGQW1c3oRGAUPbcKV+h+7QUplKUe6mUMVoShCSaC6ASVg/YbWx+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PgHX63hf; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PgHX63hf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dWQ8Z1Pyhz2ydn
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 Dec 2025 18:16:44 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765955799; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=329GlnPlyVErPOD02wc7xeLQ4F/qXvANt7pFyz3xbIk=;
	b=PgHX63hfi1mti3QzgdeJb/yw5juKtfQEHNR4p8tr3/Wf2V+d7PHNyJnq06+Of3OHhq5Aq6TcwecLpftFu/9ALddZsOCTfwx9C9fMQ5YFLabpOD415SaP1obhXyRmmqgzgYgMTzNgGZWJFaGACNlQGJov0AIPjuvUBqE2itLcBBI=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wv2U2fR_1765955793 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 17 Dec 2025 15:16:37 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: lib: s3: support bucket domain names
Date: Wed, 17 Dec 2025 15:16:32 +0800
Message-ID: <20251217071632.1236986-1-hsiangkao@linux.alibaba.com>
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
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add support for S3 bucket domain names when the S3 source path starts
with '/', as this format is currently invalid, see [1].

e.g.
 $ mkfs.erofs \
	--s3=noaa-goes19.s3.amazonaws.com,sig=4,region=us-east-1 \
	output.img /ABI-Flood-Day-Shapefiles/2025/08/25/
and
 $ mkfs.erofs \
	--s3=noaa-goes19.s3.amazonaws.com,sig=2 \
	output.img /ABI-Flood-Day-Shapefiles/2025/08/25/

[1] https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-keys.html
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/remotes/s3.c | 80 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 68 insertions(+), 12 deletions(-)

diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
index b78c127807ca..296df61c06e5 100644
--- a/lib/remotes/s3.c
+++ b/lib/remotes/s3.c
@@ -152,10 +152,11 @@ static int s3erofs_prepare_url(struct s3erofs_curl_request *req,
 	const char *schema, *host;
 	/* an additional slash is added, which wasn't specified by user inputs */
 	bool slash = false;
+	bool bucket_domain = false;
 	char *url = req->url;
 	int pos, canonical_uri_pos, i, ret = 0;
 
-	if (!endpoint || !path)
+	if (!endpoint)
 		return -EINVAL;
 
 	host = s3erofs_parse_host(endpoint, &schema);
@@ -164,14 +165,27 @@ static int s3erofs_prepare_url(struct s3erofs_curl_request *req,
 	if (!schema)
 		schema = https;
 
+	if (__erofs_unlikely(!path))
+		path = "/";
+	if (__erofs_unlikely(path[0] == '/')) {
+		path++;
+		bucket_domain = true;
+		if (url_style != S3EROFS_URL_STYLE_VIRTUAL_HOST)
+			return -EINVAL;
+	}
+
 	if (url_style == S3EROFS_URL_STYLE_PATH) {
 		pos = snprintf(url, S3EROFS_URL_LEN, "%s%s/%s", schema,
 			       host, path);
 		canonical_uri_pos = pos - strlen(path) - 1;
 	} else {
-		const char * split = strchr(path, '/');
+		const char *split = strchr(path, '/');
 
-		if (!split) {
+		if (bucket_domain) {
+			pos = snprintf(url, S3EROFS_URL_LEN, "%s%s/%s",
+				       schema, host, path);
+			canonical_uri_pos = pos - 1;
+		} else if (!split) {
 			pos = snprintf(url, S3EROFS_URL_LEN, "%s%s.%s/",
 				       schema, path, host);
 			canonical_uri_pos = pos - 1;
@@ -191,12 +205,26 @@ static int s3erofs_prepare_url(struct s3erofs_curl_request *req,
 		pos += snprintf(url + pos, S3EROFS_URL_LEN - pos, "/%s", key);
 	}
 
-	if (sig == S3EROFS_SIGNATURE_VERSION_2)
-		i = snprintf(req->canonical_uri, S3EROFS_CANONICAL_URI_LEN,
-			     "/%s%s%s", path, slash ? "/" : "", key ? key : "");
-	else
+	if (sig == S3EROFS_SIGNATURE_VERSION_2) {
+		if (bucket_domain) {
+			const char *bucket = strchr(host, '.');
+
+			if (!bucket) {
+				ret = -EINVAL;
+				goto err;
+			}
+			i = snprintf(req->canonical_uri, S3EROFS_CANONICAL_URI_LEN,
+				     "/%.*s/", (int)(bucket - host), host);
+		} else {
+			req->canonical_uri[0] = '/';
+			i = 1;
+		}
+		i += snprintf(req->canonical_uri + i, S3EROFS_CANONICAL_URI_LEN - i,
+			      "%s%s%s", path, slash ? "/" : "", key ? key : "");
+	} else {
 		i = snprintf(req->canonical_uri, S3EROFS_CANONICAL_URI_LEN,
 			     "%s", url + canonical_uri_pos);
+	}
 	req->canonical_uri[i] = '\0';
 
 	if (params) {
@@ -841,14 +869,17 @@ s3erofs_create_object_iterator(struct erofs_s3 *s3, const char *path,
 		return ERR_PTR(-ENOMEM);
 	iter->s3 = s3;
 	prefix = strchr(path, '/');
-	if (prefix) {
+	if (!prefix) {
+		iter->bucket = strdup(path);
+		iter->prefix = NULL;
+	} else if (prefix == path) {
+		iter->bucket = NULL;
+		iter->prefix = strdup(path + 1);
+	} else {
 		if (++prefix - path > S3EROFS_PATH_MAX)
 			return ERR_PTR(-EINVAL);
 		iter->bucket = strndup(path, prefix - path);
 		iter->prefix = strdup(prefix);
-	} else {
-		iter->bucket = strdup(path);
-		iter->prefix = NULL;
 	}
 	iter->delimiter = delimiter;
 	iter->is_truncated = true;
@@ -1041,8 +1072,8 @@ int s3erofs_build_trees(struct erofs_importer *im, struct erofs_s3 *s3,
 		if (!obj) {
 			break;
 		} else if (IS_ERR(obj)) {
-			erofs_err("failed to get next object");
 			ret = PTR_ERR(obj);
+			erofs_err("failed to get next object: %s", erofs_strerror(ret));
 			goto err_iter;
 		}
 
@@ -1356,7 +1387,32 @@ static bool test_s3erofs_prepare_url(void)
 			.expected_canonical_v2 = "/bucket/path/to/file-name_v2.0.txt",
 			.expected_canonical_v4 = "/path/to/file-name_v2.0.txt",
 			.expected_ret = 0,
+		},
+		{
+			.name = "S3 Bucket domain name (1)",
+			.endpoint = "bucket.s3.amazonaws.com",
+			.path = "/",
+			.key = "object.txt",
+			.url_style = S3EROFS_URL_STYLE_VIRTUAL_HOST,
+			.expected_url =
+				"https://bucket.s3.amazonaws.com/object.txt",
+			.expected_canonical_v2 = "/bucket/object.txt",
+			.expected_canonical_v4 = "/object.txt",
+			.expected_ret = 0,
+		},
+		{
+			.name = "S3 Bucket domain name (2)",
+			.endpoint = "bucket.s3.amazonaws.com",
+			.path = NULL,
+			.key = "object.txt",
+			.url_style = S3EROFS_URL_STYLE_VIRTUAL_HOST,
+			.expected_url =
+				"https://bucket.s3.amazonaws.com/object.txt",
+			.expected_canonical_v2 = "/bucket/object.txt",
+			.expected_canonical_v4 = "/object.txt",
+			.expected_ret = 0,
 		}
+
 	};
 	int i;
 	int pass = 0;
-- 
2.43.5


