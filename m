Return-Path: <linux-erofs+bounces-1431-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CA3C8081D
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Nov 2025 13:40:10 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dFQQJ4nRHz2xQq;
	Mon, 24 Nov 2025 23:40:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.220
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763988008;
	cv=none; b=XmZ/GkBwaxcBj7HTHezMAXbKN7nFQPuV0e46M98ICT/g+NCfdxuEx+rsnP7vKQK0Cnt1QhEZ4eizzZyZymc3ASYdJglDdhZw82RKdEYIakVHRKr5RW5SVaUFpjtggTbz7gz2uf0VkOJapx7zLu8WkrUtujHVPCRpeC60SVVQnYFrDIrni9PopI97Y21taj9f2iGjOK8PC1sI23ailjgnDUnysrgxIHO8db5YN8X5dMTXsdPoIkC3CavBnsLWwhzndjoupugwy25jRMG3oemagnSPImoGNwHf4b9gD0k9FVabWdmnQGPwFF/92kfZLB25pffsbWLpqug9cKY9ZuJmcw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763988008; c=relaxed/relaxed;
	bh=cVsQABCn542dZTvJ9rLno+GoqqnRXt4SMyG760mmuFA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XNaWA7dob5CAu9Yi+EFG2FUlA/7N0wBH5BDj1DbbNljOcDDvIZx0kxzW5OG61FNsnhsoJ6qms2+9/35w7NwsxFOOF0uHukeqePIjV0KMwM9h91xHPviVND46oEUpsZP0XCFtRoAIahygYlLZ+9CgCCh9L10ap21lSZekFtn1o51dZXjmBfxSh0ABI/7taEhaarD9fW5F//BLmFz/kwijq6S8zOmb+zmAHTd4qVworvhyTt2STS6kI3B8OFNXO9rci9syyQhOuN3QHnJ43lY3Bd/QtC8ulQ6jqU+g28PoceTVgh/YtWFUGCe2t8dlIFg/BN49L6awkZzNKWHyL1yzJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=S+Ony2eb; dkim-atps=neutral; spf=pass (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=S+Ony2eb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dFQQG0dWnz2xPy
	for <linux-erofs@lists.ozlabs.org>; Mon, 24 Nov 2025 23:40:05 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=cVsQABCn542dZTvJ9rLno+GoqqnRXt4SMyG760mmuFA=;
	b=S+Ony2ebzTnfIyv735FcX2CvSNre7OpiCKn+9iUfys7eydy5KjtqSX/Phi4THMlFiiOH4DJYV
	qnk8fXnMG6zEBmwIDfBKEBY0mCer66ZuFJrrOEsbyoSk+YY2QOPH0NICEI5bbYW1owV+tfM0rBW
	xy48ZTASENIXlTf4nfBt4Kw=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dFQNR52Gdz12LDJ;
	Mon, 24 Nov 2025 20:38:31 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 63118180488;
	Mon, 24 Nov 2025 20:39:56 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 24 Nov
 2025 20:39:55 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>, <hsiangkao@linux.alibaba.com>
CC: <wayne.ma@huawei.com>, <jingrui@huawei.com>
Subject: [PATCH v2] erofs-utils: lib: support AWS SigV4 for S3 backend
Date: Mon, 24 Nov 2025 20:35:53 +0800
Message-ID: <20251124123553.21318-1-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <9c78f293-9536-4463-9c25-817937e40cc2@linux.alibaba.com>
References: <9c78f293-9536-4463-9c25-817937e40cc2@linux.alibaba.com>
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

This patch introduces support for AWS Signature Version 4 for s3erofs
remote backend.

Now users can specify the folowing options:
 - passwd_file=Y, S3 credentials file in the format $ak:$sk (optional);
 - urlstyle=<vhost, path>, S3 API calling style (optional);
 - sig=<2,4>, S3 API signature version (optional);
 - region=W, region code for S3 endpoint (required for sig=4).

e.g.:
mkfs.erofs \
    --s3=s3.amazonaws.com,urlstyle=vhost,sig=4,region=us-east-1 \
    output.img \
    noaa-goes19/ABI-Flood-Day-Shapefiles/2025/08/25/

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 lib/liberofs_s3.h |   1 +
 lib/remotes/s3.c  | 581 +++++++++++++++++++++++++++++++++++++---------
 mkfs/main.c       |  14 +-
 3 files changed, 485 insertions(+), 111 deletions(-)

diff --git a/lib/liberofs_s3.h b/lib/liberofs_s3.h
index f2ec822..f4886cd 100644
--- a/lib/liberofs_s3.h
+++ b/lib/liberofs_s3.h
@@ -27,6 +27,7 @@ enum s3erofs_signature_version {
 struct erofs_s3 {
 	void *easy_curl;
 	const char *endpoint;
+	const char *region;
 	char access_key[S3_ACCESS_KEY_LEN + 1];
 	char secret_key[S3_SECRET_KEY_LEN + 1];
 
diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
index 0f7e1a9..cc37880 100644
--- a/lib/remotes/s3.c
+++ b/lib/remotes/s3.c
@@ -23,7 +23,8 @@
 #define S3EROFS_PATH_MAX		1024
 #define S3EROFS_MAX_QUERY_PARAMS	16
 #define S3EROFS_URL_LEN			8192
-#define S3EROFS_CANONICAL_QUERY_LEN	2048
+#define S3EROFS_CANONICAL_URI_LEN	2048
+#define S3EROFS_CANONICAL_QUERY_LEN	S3EROFS_URL_LEN
 
 #define BASE64_ENCODE_LEN(len)	(((len + 2) / 3) * 4)
 
@@ -34,52 +35,156 @@ struct s3erofs_query_params {
 };
 
 struct s3erofs_curl_request {
-	const char *method;
 	char url[S3EROFS_URL_LEN];
+	char canonical_uri[S3EROFS_CANONICAL_URI_LEN];
 	char canonical_query[S3EROFS_CANONICAL_QUERY_LEN];
 };
 
+static const char *s3erofs_parse_host(const char *endpoint, const char **schema)
+{
+	const char *tmp = strstr(endpoint, "://");
+	const char *host;
+
+	if (!tmp) {
+		host = endpoint;
+		if (schema)
+			*schema = NULL;
+	} else {
+		host = tmp + sizeof("://") - 1;
+		if (schema) {
+			*schema = strndup(endpoint, host - endpoint);
+			if (!*schema)
+				return ERR_PTR(-ENOMEM);
+		}
+	}
+
+	return host;
+}
+
+static void* s3erofs_urlencode(const char *input)
+{
+	static const char hex[] = "0123456789ABCDEF";
+	int i;
+	char c, *p, *ret;
+
+	ret = malloc(strlen(input) * 3 + 1);
+	if (!ret)
+		return ERR_PTR(-ENOMEM);
+
+	p = ret;
+	for (i = 0; i < strlen(input); ++i) {
+		c = (unsigned char)input[i];
+
+		// Unreserved characters: A-Z a-z 0-9 - . _ ~
+		if ((c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z') ||
+		    (c >= '0' && c <= '9') || c == '-' || c == '.' || c == '_' ||
+		    c == '~') {
+			*p++ = c;
+		} else {
+			*p++ = '%';
+			*p++ = hex[c >> 4];
+			*p++ = hex[c & 0x0F];
+		}
+	}
+	*p = '\0';
+
+	return ret;
+}
+
+struct kv_pair {
+	char *key;
+	char *value;
+};
+
+static int compare_kv_pair(const void *a, const void *b)
+{
+	return strcmp(((const struct kv_pair *)a)->key, ((const struct kv_pair *)b)->key);
+}
+
+static int s3erofs_prepare_canonical_query(struct s3erofs_curl_request *req,
+					   struct s3erofs_query_params *params)
+{
+	struct kv_pair *pairs;
+	int i, pos = 0, ret = 0;
+
+	if (!params->num)
+		return 0;
+
+	pairs = calloc(1, sizeof(struct kv_pair) * params->num);
+	for (i = 0; i < params->num; i++) {
+		pairs[i].key = s3erofs_urlencode(params->key[i]);
+		if (IS_ERR(pairs[i].key)) {
+			ret = PTR_ERR(pairs[i].key);
+			pairs[i].key = NULL;
+			goto out;
+		}
+		pairs[i].value = s3erofs_urlencode(params->value[i]);
+		if (IS_ERR(pairs[i].value)) {
+			ret = PTR_ERR(pairs[i].value);
+			pairs[i].value = NULL;
+			goto out;
+		}
+	}
+
+	qsort(pairs, params->num, sizeof(struct kv_pair), compare_kv_pair);
+	for (i = 0; i < params->num; i++)
+		pos += snprintf(req->canonical_query + pos,
+				S3EROFS_CANONICAL_QUERY_LEN - pos, "%s=%s%s",
+				pairs[i].key, pairs[i].value,
+				(i == params->num - 1) ? "" : "&");
+	req->canonical_query[pos] = '\0';
+
+out:
+	for (i = 0; i < params->num; i++) {
+		if (pairs[i].key)
+			free(pairs[i].key);
+		if (pairs[i].value)
+			free(pairs[i].value);
+	}
+	free(pairs);
+	return ret;
+}
+
 static int s3erofs_prepare_url(struct s3erofs_curl_request *req,
 			       const char *endpoint,
 			       const char *path, const char *key,
 			       struct s3erofs_query_params *params,
-			       enum s3erofs_url_style url_style)
+			       enum s3erofs_url_style url_style,
+			       enum s3erofs_signature_version sig)
 {
 	static const char https[] = "https://";
 	const char *schema, *host;
 	/* an additional slash is added, which wasn't specified by user inputs */
 	bool slash = false;
 	char *url = req->url;
-	int pos, i;
+	int pos, canonical_uri_pos, i, ret = 0;
 
 	if (!endpoint || !path)
 		return -EINVAL;
 
-	schema = strstr(endpoint, "://");
-	if (!schema) {
+	host = s3erofs_parse_host(endpoint, &schema);
+	if (IS_ERR(host))
+		return PTR_ERR(host);
+	if (!schema)
 		schema = https;
-		host = endpoint;
-	} else {
-		host = schema + sizeof("://") - 1;
-		schema = strndup(endpoint, host - endpoint);
-		if (!schema)
-			return -ENOMEM;
-	}
 
 	if (url_style == S3EROFS_URL_STYLE_PATH) {
 		pos = snprintf(url, S3EROFS_URL_LEN, "%s%s/%s", schema,
 			       host, path);
+		canonical_uri_pos = pos - strlen(path) - 1;
 	} else {
 		const char * split = strchr(path, '/');
 
 		if (!split) {
 			pos = snprintf(url, S3EROFS_URL_LEN, "%s%s.%s/",
 				       schema, path, host);
+			canonical_uri_pos = pos - 1;
 			slash = true;
 		} else {
 			pos = snprintf(url, S3EROFS_URL_LEN, "%s%.*s.%s%s",
 				       schema, (int)(split - path), path,
 				       host, split);
+			canonical_uri_pos = pos - strlen(split);
 		}
 	}
 	if (key) {
@@ -90,46 +195,128 @@ static int s3erofs_prepare_url(struct s3erofs_curl_request *req,
 		pos += snprintf(url + pos, S3EROFS_URL_LEN - pos, "/%s", key);
 	}
 
-	i = snprintf(req->canonical_query, S3EROFS_CANONICAL_QUERY_LEN,
-		     "/%s%s%s", path, slash ? "/" : "", key ? key : "");
-	req->canonical_query[i] = '\0';
+	if (sig == S3EROFS_SIGNATURE_VERSION_2)
+		i = snprintf(req->canonical_uri, S3EROFS_CANONICAL_URI_LEN,
+			     "/%s%s%s", path, slash ? "/" : "", key ? key : "");
+	else
+		i = snprintf(req->canonical_uri, S3EROFS_CANONICAL_URI_LEN,
+			     "%s", url + canonical_uri_pos);
+	req->canonical_uri[i] = '\0';
+
+	if (params) {
+		for (i = 0; i < params->num; i++)
+			pos += snprintf(url + pos, S3EROFS_URL_LEN - pos, "%c%s=%s",
+					(!i ? '?' : '&'), params->key[i],
+					params->value[i]);
+		ret = s3erofs_prepare_canonical_query(req, params);
+		if (ret < 0)
+			goto err;
+	}
+
+	erofs_dbg("Request URL %s", url);
+	erofs_dbg("Request canonical_uri %s", req->canonical_uri);
 
-	for (i = 0; i < params->num; i++)
-		pos += snprintf(url + pos, S3EROFS_URL_LEN - pos, "%c%s=%s",
-				(!i ? '?' : '&'),
-				params->key[i], params->value[i]);
+err:
 	if (schema != https)
 		free((void *)schema);
-	erofs_dbg("Request URL %s", url);
-	return 0;
+	return ret;
+}
+
+static char *get_canonical_headers(const struct curl_slist *list)
+{
+	const struct curl_slist *current = list;
+	char *result;
+	size_t len = 0;
+
+	while (current) {
+		len += strlen(current->data) + 1;
+		current = current->next;
+	}
+
+	result = (char *)malloc(len + 1);
+	if (!result)
+		return NULL;
+
+	current = list;
+	len = 0;
+	while (current) {
+		strcpy(result + len, current->data);
+		len += strlen(current->data);
+		result[len++] = '\n';
+		current = current->next;
+	}
+
+	result[len] = '\0';
+	return result;
+}
+
+enum s3erofs_date_format {
+	S3EROFS_DATE_RFC1123,
+	S3EROFS_DATE_ISO8601,
+	S3EROFS_DATE_YYYYMMDD
+};
+
+static void s3erofs_now(char *buf, size_t maxlen, enum s3erofs_date_format fmt)
+{
+	const char *format;
+	time_t now = time(NULL);
+	struct tm *ptm = gmtime(&now);
+
+	switch (fmt) {
+	case S3EROFS_DATE_RFC1123:
+		format = "%a, %d %b %Y %H:%M:%S GMT";
+		break;
+	case S3EROFS_DATE_ISO8601:
+		format = "%Y%m%dT%H%M%SZ";
+		break;
+	case S3EROFS_DATE_YYYYMMDD:
+		format = "%Y%m%d";
+		break;
+	default:
+		erofs_err("unknown date format %d", fmt);
+		buf[0] = '\0';
+		return;
+	}
+
+	strftime(buf, maxlen, format, ptm);
 }
 
-static char *get_canonical_headers(const struct curl_slist *list) { return ""; }
+static void s3erofs_to_hex(const u8 *data, size_t len, char *output)
+{
+	static const char hex_chars[] = "0123456789abcdef";
+	size_t i;
+
+	for (i = 0; i < len; i++) {
+		output[i * 2] = hex_chars[data[i] >> 4];
+		output[i * 2 + 1] = hex_chars[data[i] & 0x0f];
+	}
+	output[len * 2] = '\0';
+}
 
 // See: https://docs.aws.amazon.com/AmazonS3/latest/API/RESTAuthentication.html#ConstructingTheAuthenticationHeader
 static char *s3erofs_sigv2_header(const struct curl_slist *headers,
-		const char *method, const char *content_md5,
-		const char *content_type, const char *date,
-		const char *canonical_query, const char *ak, const char *sk)
+				  const char *content_md5,
+				  const char *content_type, const char *date,
+				  const char *canonical_uri, const char *ak,
+				  const char *sk)
 {
 	u8 hmac_signature[EVP_MAX_MD_SIZE];
 	char *str, *output = NULL;
 	unsigned int len, pos, output_len;
-	const char *canonical_headers = get_canonical_headers(headers);
 	const char *prefix = "Authorization: AWS ";
 
-	if (!method || !date || !ak || !sk)
+	if (!date || !ak || !sk)
 		return ERR_PTR(-EINVAL);
 
 	if (!content_md5)
 		content_md5 = "";
 	if (!content_type)
 		content_type = "";
-	if (!canonical_query)
-		canonical_query = "/";
+	if (!canonical_uri)
+		canonical_uri = "/";
 
-	pos = asprintf(&str, "%s\n%s\n%s\n%s\n%s%s", method, content_md5,
-		       content_type, date, canonical_headers, canonical_query);
+	pos = asprintf(&str, "GET\n%s\n%s\n%s\n%s%s", content_md5, content_type,
+		       date, "", canonical_uri);
 	if (pos < 0)
 		return ERR_PTR(-ENOMEM);
 
@@ -154,12 +341,191 @@ free_string:
 	return output ?: ERR_PTR(-ENOMEM);
 }
 
-static void s3erofs_now_rfc1123(char *buf, size_t maxlen)
+// See: https://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-header-based-auth.html
+static char *s3erofs_sigv4_header(const struct curl_slist *headers,
+				  const char *canonical_uri,
+				  const char *canonical_query,
+				  const char *region, const char *ak,
+				  const char *sk)
 {
-	time_t now = time(NULL);
-	struct tm *ptm = gmtime(&now);
+	u8 ping_buf[EVP_MAX_MD_SIZE], pong_buf[EVP_MAX_MD_SIZE];
+	char hex_buf[EVP_MAX_MD_SIZE * 2 + 1];
+	char date_str[16], timestamp[32];
+	char *canonical_request, *canonical_headers;
+	char *string_to_sign, *scope, *aws4_secret;
+	unsigned int len;
+	char *output = NULL;
+	int err = 0;
+
+	if (!canonical_uri || !region || !ak || !sk)
+		return ERR_PTR(-EINVAL);
+
+	if (!canonical_query)
+		canonical_query = "";
+
+	canonical_headers = get_canonical_headers(headers);
+
+	// Get current time in required formats
+	s3erofs_now(date_str, sizeof(date_str), S3EROFS_DATE_YYYYMMDD);
+	s3erofs_now(timestamp, sizeof(timestamp), S3EROFS_DATE_ISO8601);
+
+	// Task 1: Create canonical request
+	if (asprintf(&canonical_request,
+		     "GET\n"
+		     "%s\n"
+		     "%s\n"
+		     "%s\n"
+		     "host;x-amz-content-sha256;x-amz-date\n"
+		     "UNSIGNED-PAYLOAD",
+		     canonical_uri, canonical_query, canonical_headers) < 0) {
+		err = -ENOMEM;
+		goto err_canonical_headers;
+	}
+
+	// Hash the canonical request
+	if (!EVP_Digest(canonical_request, strlen(canonical_request), ping_buf,
+			&len, EVP_sha256(), NULL)) {
+		err = -EIO;
+		goto err_canonical_request;
+	}
+	s3erofs_to_hex(ping_buf, len, hex_buf);
+
+	// Task 2: Create string to sign
+	if (asprintf(&scope, "%s/%s/s3/aws4_request", date_str, region) < 0) {
+		err = -ENOMEM;
+		goto err_canonical_request;
+	}
+	if (asprintf(&string_to_sign,
+		     "AWS4-HMAC-SHA256\n"
+		     "%s\n" // timestamp (ISO8601, e.g., 20251115T123456Z)
+		     "%s\n" // credential scope (e.g., 20251115/us-east-1/s3/aws4_request)
+		     "%s",  // canonical request hash (hex-encoded SHA-256)
+		     timestamp, scope, hex_buf) < 0) {
+		err = -ENOMEM;
+		goto err_scope;
+	}
+
+	// Task 3: Calculate signing key
+	if (asprintf(&aws4_secret, "AWS4%s", sk) < 0) {
+		err = -ENOMEM;
+		goto err_string_to_sign;
+	}
+	if (!HMAC(EVP_sha256(), aws4_secret, strlen(aws4_secret),
+		  (u8 *)date_str, strlen(date_str), ping_buf, &len)) {
+		err = -EIO;
+		goto err_aws4_secret;
+	}
+	if (!HMAC(EVP_sha256(), ping_buf, len, (u8 *)region, strlen(region),
+		  pong_buf, &len)) {
+		err = -EIO;
+		goto err_aws4_secret;
+	}
+	if (!HMAC(EVP_sha256(), pong_buf, len, (u8 *)"s3", strlen("s3"),
+		  ping_buf, &len)) {
+		err = -EIO;
+		goto err_aws4_secret;
+	}
+	if (!HMAC(EVP_sha256(), ping_buf, len, (u8 *)"aws4_request",
+		  strlen("aws4_request"), pong_buf, &len)) {
+		err = -EIO;
+		goto err_aws4_secret;
+	}
+
+	// Calculate signature
+	if (!HMAC(EVP_sha256(), pong_buf, len, (u8 *)string_to_sign,
+		  strlen(string_to_sign), ping_buf, &len)) {
+		err = -EIO;
+		goto err_aws4_secret;
+	}
+	s3erofs_to_hex(ping_buf, len, hex_buf);
+
+	// Build Authorization header
+	if (asprintf(&output,
+		     "Authorization: AWS4-HMAC-SHA256 "
+		     "Credential=%s/%s, "
+		     "SignedHeaders=host;x-amz-content-sha256;x-amz-date, "
+		     "Signature=%s",
+		     ak, scope, hex_buf) < 0) {
+		err = -ENOMEM;
+		goto err_aws4_secret;
+	}
+
+err_aws4_secret:
+	free(aws4_secret);
+err_string_to_sign:
+	free(string_to_sign);
+err_scope:
+	free(scope);
+err_canonical_request:
+	free(canonical_request);
+err_canonical_headers:
+	free(canonical_headers);
+	return err ? ERR_PTR(err) : output;
+}
+
+static int s3erofs_request_insert_auth_v2(struct curl_slist **request_headers,
+					  struct s3erofs_curl_request *req,
+					  struct erofs_s3 *s3)
+{
+	static const char date_prefix[] = "Date: ";
+	char date[64], *sigv2;
+
+	memcpy(date, date_prefix, sizeof(date_prefix) - 1);
+	s3erofs_now(date + sizeof(date_prefix) - 1,
+		    sizeof(date) - sizeof(date_prefix) + 1,
+		    S3EROFS_DATE_RFC1123);
+
+	sigv2 = s3erofs_sigv2_header(*request_headers, NULL, NULL,
+				     date + sizeof(date_prefix) - 1, req->canonical_uri,
+				     s3->access_key, s3->secret_key);
+	if (IS_ERR(sigv2))
+		return PTR_ERR(sigv2);
+
+	*request_headers = curl_slist_append(*request_headers, date);
+	*request_headers = curl_slist_append(*request_headers, sigv2);
 
-	strftime(buf, maxlen, "%a, %d %b %Y %H:%M:%S GMT", ptm);
+	free(sigv2);
+	return 0;
+}
+
+static int s3erofs_request_insert_auth_v4(struct curl_slist **request_headers,
+					  struct s3erofs_curl_request *req,
+					  struct erofs_s3 *s3)
+{
+	char timestamp[32], *sigv4, *tmp;
+	const char *host, *host_end;
+
+	/* Add following headers for SigV4 in alphabetical order: */
+	/* 1. host */
+	host = s3erofs_parse_host(req->url, NULL);
+	host_end = strchr(host, '/');
+	if (!host_end)
+		return -EINVAL;
+	if (asprintf(&tmp, "host:%.*s", (int)(host_end - host), host) < 0)
+		return -ENOMEM;
+	*request_headers = curl_slist_append(*request_headers, tmp);
+	free(tmp);
+
+	/* 2. x-amz-content-sha256 */
+	*request_headers = curl_slist_append(
+		*request_headers, "x-amz-content-sha256:UNSIGNED-PAYLOAD");
+
+	/* 3. x-amz-date */
+	s3erofs_now(timestamp, sizeof(timestamp), S3EROFS_DATE_ISO8601);
+	if (asprintf(&tmp, "x-amz-date:%s", timestamp) < 0)
+		return -ENOMEM;
+	*request_headers = curl_slist_append(*request_headers, tmp);
+	free(tmp);
+
+	sigv4 = s3erofs_sigv4_header(*request_headers, req->canonical_uri,
+				     req->canonical_query, s3->region, s3->access_key,
+				     s3->secret_key);
+	if (IS_ERR(sigv4))
+		return PTR_ERR(sigv4);
+	*request_headers = curl_slist_append(*request_headers, sigv4);
+	free(sigv4);
+
+	return 0;
 }
 
 struct s3erofs_curl_response {
@@ -186,31 +552,6 @@ static size_t s3erofs_request_write_memory_cb(void *contents, size_t size,
 	return realsize;
 }
 
-static int s3erofs_request_insert_auth(struct curl_slist **request_headers,
-				       const char *method,
-				       const char *canonical_query,
-				       const char *ak, const char *sk)
-{
-	static const char date_prefix[] = "Date: ";
-	char date[64], *sigv2;
-
-	memcpy(date, date_prefix, sizeof(date_prefix) - 1);
-	s3erofs_now_rfc1123(date + sizeof(date_prefix) - 1,
-			    sizeof(date) - sizeof(date_prefix) + 1);
-
-	sigv2 = s3erofs_sigv2_header(*request_headers, method, NULL, NULL,
-				     date + sizeof(date_prefix) - 1,
-				     canonical_query, ak, sk);
-	if (IS_ERR(sigv2))
-		return PTR_ERR(sigv2);
-
-	*request_headers = curl_slist_append(*request_headers, date);
-	*request_headers = curl_slist_append(*request_headers, sigv2);
-
-	free(sigv2);
-	return 0;
-}
-
 static int s3erofs_request_perform(struct erofs_s3 *s3,
 				   struct s3erofs_curl_request *req, void *resp)
 {
@@ -220,9 +561,10 @@ static int s3erofs_request_perform(struct erofs_s3 *s3,
 	int ret;
 
 	if (s3->access_key[0]) {
-		ret = s3erofs_request_insert_auth(&request_headers, req->method,
-						  req->canonical_query,
-						  s3->access_key, s3->secret_key);
+		if (s3->sig == S3EROFS_SIGNATURE_VERSION_4)
+			ret = s3erofs_request_insert_auth_v4(&request_headers, req, s3);
+		else
+			ret = s3erofs_request_insert_auth_v2(&request_headers, req, s3);
 		if (ret < 0) {
 			erofs_err("failed to insert auth headers");
 			return ret;
@@ -294,6 +636,7 @@ static int s3erofs_parse_list_objects_one(xmlNodePtr node,
 				struct tm tm;
 				char *end;
 
+				tm.tm_isdst = -1;
 				end = strptime((char *)str, "%Y-%m-%dT%H:%M:%S", &tm);
 				if (!end || (*end != '.' && *end != 'Z' && *end != '\0')) {
 					xmlFree(str);
@@ -470,9 +813,8 @@ static int s3erofs_list_objects(struct s3erofs_object_iterator *it)
 		++params.num;
 	}
 
-	req.method = "GET";
-	ret = s3erofs_prepare_url(&req, s3->endpoint, it->bucket, NULL,
-				  &params, s3->url_style);
+	ret = s3erofs_prepare_url(&req, s3->endpoint, it->bucket, NULL, &params,
+				  s3->url_style, s3->sig);
 	if (ret < 0)
 		return ret;
 
@@ -482,13 +824,14 @@ static int s3erofs_list_objects(struct s3erofs_object_iterator *it)
 
 	ret = s3erofs_request_perform(s3, &req, &resp);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	ret = s3erofs_parse_list_objects_result(resp.data, resp.size, it);
-	if (ret < 0)
-		return ret;
-	free(resp.data);
-	return 0;
+
+out:
+	if (resp.data)
+		free(resp.data);
+	return ret;
 }
 
 static struct s3erofs_object_iterator *
@@ -610,14 +953,11 @@ static int s3erofs_remote_getobject(struct erofs_importer *im,
 	struct erofs_sb_info *sbi = inode->sbi;
 	struct s3erofs_curl_request req = {};
 	struct s3erofs_curl_getobject_resp resp;
-	struct s3erofs_query_params params;
 	struct erofs_vfile vf;
 	int ret;
 
-	params.num = 0;
-	req.method = "GET";
-	ret = s3erofs_prepare_url(&req, s3->endpoint, bucket, key,
-				  &params, s3->url_style);
+	ret = s3erofs_prepare_url(&req, s3->endpoint, bucket, key, NULL,
+				  s3->url_style, s3->sig);
 	if (ret < 0)
 		return ret;
 
@@ -775,20 +1115,22 @@ struct s3erofs_prepare_url_testcase {
 	const char *key;
 	enum s3erofs_url_style url_style;
 	const char *expected_url;
-	const char *expected_canonical;
+	const char *expected_canonical_v2;
+	const char *expected_canonical_v4;
 	int expected_ret;
 };
 
-static bool run_s3erofs_prepare_url_test(const struct s3erofs_prepare_url_testcase *tc)
+static bool run_s3erofs_prepare_url_test(const struct s3erofs_prepare_url_testcase *tc,
+					 enum s3erofs_signature_version sig)
 {
-	struct s3erofs_curl_request req = { .method = "GET" };
-	struct s3erofs_query_params params = { .num = 0 };
+	struct s3erofs_curl_request req = {};
 	int ret;
+	const char *expected_canonical;
 
 	printf("Running test: %s\n", tc->name);
 
-	ret = s3erofs_prepare_url(&req, tc->endpoint, tc->path, tc->key, &params,
-				  tc->url_style);
+	ret = s3erofs_prepare_url(&req, tc->endpoint, tc->path, tc->key, NULL,
+				  tc->url_style, sig);
 
 	if (ret != tc->expected_ret) {
 		printf("  FAILED: expected return %d, got %d\n", tc->expected_ret, ret);
@@ -807,17 +1149,19 @@ static bool run_s3erofs_prepare_url_test(const struct s3erofs_prepare_url_testca
 		return false;
 	}
 
-	if (tc->expected_canonical &&
-	    strcmp(req.canonical_query, tc->expected_canonical) != 0) {
-		printf("  FAILED: Canonical query mismatch\n");
-		printf("    Expected: %s\n", tc->expected_canonical);
-		printf("    Got:      %s\n", req.canonical_query);
+	expected_canonical = (sig == S3EROFS_SIGNATURE_VERSION_2 ?
+					    tc->expected_canonical_v2 :
+					    tc->expected_canonical_v4);
+	if (expected_canonical && strcmp(req.canonical_uri, expected_canonical) != 0) {
+		printf("  FAILED: Canonical uri mismatch\n");
+		printf("    Expected: %s\n", expected_canonical);
+		printf("    Got:      %s\n", req.canonical_uri);
 		return false;
 	}
 
 	printf("  PASSED\n");
 	printf("    URL: %s\n", req.url);
-	printf("    Canonical: %s\n", req.canonical_query);
+	printf("    Canonical: %s\n", req.canonical_uri);
 	return true;
 }
 
@@ -832,7 +1176,8 @@ static bool test_s3erofs_prepare_url(void)
 			.url_style = S3EROFS_URL_STYLE_VIRTUAL_HOST,
 			.expected_url =
 				"https://my-bucket.s3.amazonaws.com/path/to/object.txt",
-			.expected_canonical = "/my-bucket/path/to/object.txt",
+			.expected_canonical_v2 = "/my-bucket/path/to/object.txt",
+			.expected_canonical_v4 = "/path/to/object.txt",
 			.expected_ret = 0,
 		},
 		{
@@ -843,7 +1188,8 @@ static bool test_s3erofs_prepare_url(void)
 			.url_style = S3EROFS_URL_STYLE_PATH,
 			.expected_url =
 				"https://s3.amazonaws.com/my-bucket/path/to/object.txt",
-			.expected_canonical = "/my-bucket/path/to/object.txt",
+			.expected_canonical_v2 = "/my-bucket/path/to/object.txt",
+			.expected_canonical_v4 = "/my-bucket/path/to/object.txt",
 			.expected_ret = 0,
 		},
 		{
@@ -854,7 +1200,8 @@ static bool test_s3erofs_prepare_url(void)
 			.url_style = S3EROFS_URL_STYLE_VIRTUAL_HOST,
 			.expected_url =
 				"https://test-bucket.s3.us-west-2.amazonaws.com/file.bin",
-			.expected_canonical = "/test-bucket/file.bin",
+			.expected_canonical_v2 = "/test-bucket/file.bin",
+			.expected_canonical_v4 = "/file.bin",
 			.expected_ret = 0,
 		},
 		{
@@ -865,7 +1212,8 @@ static bool test_s3erofs_prepare_url(void)
 			.url_style = S3EROFS_URL_STYLE_PATH,
 			.expected_url =
 				"http://localhost:9000/local-bucket/data/file.dat",
-			.expected_canonical = "/local-bucket/data/file.dat",
+			.expected_canonical_v2 = "/local-bucket/data/file.dat",
+			.expected_canonical_v4 = "/local-bucket/data/file.dat",
 			.expected_ret = 0,
 		},
 		{
@@ -876,7 +1224,8 @@ static bool test_s3erofs_prepare_url(void)
 			.url_style = S3EROFS_URL_STYLE_VIRTUAL_HOST,
 			.expected_url =
 				"http://local-bucket.localhost:9000/data/file.dat/",
-			.expected_canonical = "/local-bucket/data/file.dat/",
+			.expected_canonical_v2 = "/local-bucket/data/file.dat/",
+			.expected_canonical_v4 = "/data/file.dat/",
 			.expected_ret = 0,
 		},
 		{
@@ -887,7 +1236,8 @@ static bool test_s3erofs_prepare_url(void)
 			.url_style = S3EROFS_URL_STYLE_PATH,
 			.expected_url =
 				"http://localhost:9000/local-bucket/data/file.dat/",
-			.expected_canonical = "/local-bucket/data/file.dat/",
+			.expected_canonical_v2 = "/local-bucket/data/file.dat/",
+			.expected_canonical_v4 = "/local-bucket/data/file.dat/",
 			.expected_ret = 0,
 		},
 		{
@@ -897,7 +1247,8 @@ static bool test_s3erofs_prepare_url(void)
 			.key = NULL,
 			.url_style = S3EROFS_URL_STYLE_VIRTUAL_HOST,
 			.expected_url = "https://my-bucket.s3.amazonaws.com/",
-			.expected_canonical = "/my-bucket/",
+			.expected_canonical_v2 = "/my-bucket/",
+			.expected_canonical_v4 = "/",
 			.expected_ret = 0,
 		},
 		{
@@ -907,7 +1258,8 @@ static bool test_s3erofs_prepare_url(void)
 			.key = NULL,
 			.url_style = S3EROFS_URL_STYLE_PATH,
 			.expected_url = "https://s3.amazonaws.com/my-bucket",
-			.expected_canonical = "/my-bucket",
+			.expected_canonical_v2 = "/my-bucket",
+			.expected_canonical_v4 = "/my-bucket",
 			.expected_ret = 0,
 		},
 		{
@@ -917,7 +1269,8 @@ static bool test_s3erofs_prepare_url(void)
 			.key = NULL,
 			.url_style = S3EROFS_URL_STYLE_PATH,
 			.expected_url = "https://s3.amazonaws.com/bucket/",
-			.expected_canonical = "/bucket/",
+			.expected_canonical_v2 = "/bucket/",
+			.expected_canonical_v4 = "/bucket/",
 			.expected_ret = 0,
 		},
 		{
@@ -927,7 +1280,8 @@ static bool test_s3erofs_prepare_url(void)
 			.key = NULL,
 			.url_style = S3EROFS_URL_STYLE_VIRTUAL_HOST,
 			.expected_url = "https://bucket.s3.amazonaws.com/",
-			.expected_canonical = "/bucket/",
+			.expected_canonical_v2 = "/bucket/",
+			.expected_canonical_v4 = "/",
 			.expected_ret = 0,
 		},
 		{
@@ -937,7 +1291,8 @@ static bool test_s3erofs_prepare_url(void)
 			.key = "object.txt",
 			.url_style = S3EROFS_URL_STYLE_PATH,
 			.expected_url = "https://s3.amazonaws.com/bucket/object.txt",
-			.expected_canonical = "/bucket/object.txt",
+			.expected_canonical_v2 = "/bucket/object.txt",
+			.expected_canonical_v4 = "/bucket/object.txt",
 			.expected_ret = 0,
 		},
 		{
@@ -947,7 +1302,8 @@ static bool test_s3erofs_prepare_url(void)
 			.key = "object.txt",
 			.url_style = S3EROFS_URL_STYLE_VIRTUAL_HOST,
 			.expected_url = "https://bucket.s3.amazonaws.com/object.txt",
-			.expected_canonical = "/bucket/object.txt",
+			.expected_canonical_v2 = "/bucket/object.txt",
+			.expected_canonical_v4 = "/object.txt",
 			.expected_ret = 0,
 		},
 		{
@@ -957,7 +1313,8 @@ static bool test_s3erofs_prepare_url(void)
 			.key = "a/b/c/object.txt",
 			.url_style = S3EROFS_URL_STYLE_PATH,
 			.expected_url = "https://s3.amazonaws.com/bucket/a/b/c/object.txt",
-			.expected_canonical = "/bucket/a/b/c/object.txt",
+			.expected_canonical_v2 = "/bucket/a/b/c/object.txt",
+			.expected_canonical_v4 = "/bucket/a/b/c/object.txt",
 			.expected_ret = 0,
 		},
 		{
@@ -967,7 +1324,8 @@ static bool test_s3erofs_prepare_url(void)
 			.key = "a/b/c/object.txt",
 			.url_style = S3EROFS_URL_STYLE_VIRTUAL_HOST,
 			.expected_url = "https://bucket.s3.amazonaws.com/a/b/c/object.txt",
-			.expected_canonical = "/bucket/a/b/c/object.txt",
+			.expected_canonical_v2 = "/bucket/a/b/c/object.txt",
+			.expected_canonical_v4 = "/a/b/c/object.txt",
 			.expected_ret = 0,
 		},
 		{
@@ -977,7 +1335,8 @@ static bool test_s3erofs_prepare_url(void)
 			.key = "file.txt",
 			.url_style = S3EROFS_URL_STYLE_PATH,
 			.expected_url = NULL,
-			.expected_canonical = NULL,
+			.expected_canonical_v2 = NULL,
+			.expected_canonical_v4 = NULL,
 			.expected_ret = -EINVAL,
 		},
 		{
@@ -987,7 +1346,8 @@ static bool test_s3erofs_prepare_url(void)
 			.key = "file.txt",
 			.url_style = S3EROFS_URL_STYLE_PATH,
 			.expected_url = NULL,
-			.expected_canonical = NULL,
+			.expected_canonical_v2 = NULL,
+			.expected_canonical_v4 = NULL,
 			.expected_ret = -EINVAL,
 		},
 		{
@@ -998,7 +1358,8 @@ static bool test_s3erofs_prepare_url(void)
 			.url_style = S3EROFS_URL_STYLE_VIRTUAL_HOST,
 			.expected_url =
 				"https://bucket.s3.amazonaws.com/path/to/file-name_v2.0.txt",
-			.expected_canonical = "/bucket/path/to/file-name_v2.0.txt",
+			.expected_canonical_v2 = "/bucket/path/to/file-name_v2.0.txt",
+			.expected_canonical_v4 = "/path/to/file-name_v2.0.txt",
 			.expected_ret = 0,
 		}
 	};
@@ -1006,12 +1367,14 @@ static bool test_s3erofs_prepare_url(void)
 	int pass = 0;
 
 	for (i = 0; i < ARRAY_SIZE(tests); ++i) {
-		pass += run_s3erofs_prepare_url_test(&tests[i]);
+		pass += run_s3erofs_prepare_url_test(&tests[i], S3EROFS_SIGNATURE_VERSION_2);
+		putc('\n', stdout);
+		pass += run_s3erofs_prepare_url_test(&tests[i], S3EROFS_SIGNATURE_VERSION_4);
 		putc('\n', stdout);
 	}
 
-	printf("Run all %d tests with %d PASSED\n", i, pass);
-	return ARRAY_SIZE(tests) == pass;
+	printf("Run all %d tests with %d PASSED\n", 2 * i, pass);
+	return 2 * ARRAY_SIZE(tests) == pass;
 }
 
 int main(int argc, char *argv[])
diff --git a/mkfs/main.c b/mkfs/main.c
index 7ede520..7aa8eae 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -214,6 +214,7 @@ static void usage(int argc, char **argv)
 		"   [,passwd_file=Y]    X=endpoint, Y=s3fs-compatible password file\n"
 		"   [,urlstyle=Z]       S3 API calling style (Z = vhost|path) (default: vhost)\n"
 		"   [,sig=<2,4>]        S3 API signature version (default: 2)\n"
+		"   [,region=W]         W=region code in which endpoint belongs to (required for sig=4)\n"
 #endif
 #ifdef OCIEROFS_ENABLED
 		" --oci=[f|i]           generate a full (f) or index-only (i) image from OCI remote source\n"
@@ -706,13 +707,17 @@ static int mkfs_parse_s3_cfg(char *cfg_str)
 		} else if ((p = strstr(opt, "sig="))) {
 			p += strlen("sig=");
 			if (strncmp(p, "4", 1) == 0) {
-				erofs_warn("AWS Signature Version 4 is not supported yet, using Version 2");
+				s3cfg.sig = S3EROFS_SIGNATURE_VERSION_4;
 			} else if (strncmp(p, "2", 1) == 0) {
 				s3cfg.sig = S3EROFS_SIGNATURE_VERSION_2;
 			} else {
-				erofs_err("Invalid AWS Signature Version %s", p);
+				erofs_err("invalid AWS signature version %s", p);
 				return -EINVAL;
 			}
+		} else if ((p = strstr(opt, "region="))) {
+			p += strlen("region=");
+			opt = strchr(cfg_str, ',');
+			s3cfg.region = opt ? strndup(p, opt - p) : strdup(p);
 		} else {
 			erofs_err("invalid --s3 option %s", opt);
 			return -EINVAL;
@@ -721,6 +726,11 @@ static int mkfs_parse_s3_cfg(char *cfg_str)
 		opt = q ? q + 1 : NULL;
 	}
 
+	if (s3cfg.sig == S3EROFS_SIGNATURE_VERSION_4 && !s3cfg.region) {
+		erofs_err("invalid --s3: using sig=4 requires region provided");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 #endif
-- 
2.33.0


