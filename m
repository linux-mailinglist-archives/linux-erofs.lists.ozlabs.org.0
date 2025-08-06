Return-Path: <linux-erofs+bounces-776-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A6FB1C7B1
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Aug 2025 16:36:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bxtCM4hJNz30W5;
	Thu,  7 Aug 2025 00:36:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754490991;
	cv=none; b=LS9YMf/uG0jepoCtGRy99WVm1MVSKx0mcJ+xQI3e2kHEZRCnAPSL1m9OlG9o/efWg7HolK7CmqpIW09qO0q8r5pux0HFrHFpsExVDs6fo3erFfRRs2kWZp8EULBXPyyvlyfC3yHeIkIJkGtM3x7JYQ70zLk8KVCFL2y4oOpQrCgI1jA6DPMQzwDhfjPIzNNp0d9HEZtQTwNQVQxwuLOH23wxCPRfkHx9ERrH7bWAFiMi6gxwM4W+JMsv2wW885Ol5kttVtFtXbsDZn1iVZiyekN1++3XaP/hPnL4k1YC7OgOugCByq5qjRt875mps+OJHwUezXPOuAR8yFJU+NWJ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754490991; c=relaxed/relaxed;
	bh=SWLSD8JcZNs1tQeBKrpieWGaJ/yoxLVBw1lVgMl1ezw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lq4fX2vQPcTZG+DLmEKRbTEg8EfZWs6/JnRXjsINcBaTvFQ8+Dyp48Ri9fgheojXkneWysC87ah0UXHJvzhvr16gPz/b3Md4mxhNwZ6elZd346kunnFO9aqPx+1MQ/I2+KZAGoRbglUQHLgNRFTw8CYi3C8eDmuaUwlne7k9S8Lqu9qv2AzWKmH27a35AyzpI4b2fCWlhAto/NSq/Vo9hlUSCb8raBT/6HzTqzIuTfuYRKj80yBONC/SQT5MY2lDiORJL/IDVoYYC1VXlYLICFbM3rpj8Qrh6tVBjW6d5E/KWXu5Pf42/XdU7N3h/s7MtxxGZrkRggp8Y/BeQKRkOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Kr/a+S2M; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Kr/a+S2M;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bxtCK0r4Zz2ygJ
	for <linux-erofs@lists.ozlabs.org>; Thu,  7 Aug 2025 00:36:27 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754490984; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=SWLSD8JcZNs1tQeBKrpieWGaJ/yoxLVBw1lVgMl1ezw=;
	b=Kr/a+S2MdKIvYSUYxgUXZsIhSjw5j24f0w8I2Lq9zhO5mw8rvMVzIp05hOtX1CpVin8D2gzQXhsAc6h92wjY7R3XOFn+UOgHMVGohP8OmoBEViGRqAQfo3SYRZLmSIS5RCFw9cTM1ajdAVTj+4nr9kI735XUhaw3Ka1oQOGVEGw=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WlBLAvp_1754490982 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 06 Aug 2025 22:36:22 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Yifan Zhao <zhaoyifan28@huawei.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v5 4/4] erofs-utils: mkfs: support EROFS meta-only image generation from S3
Date: Wed,  6 Aug 2025 22:36:14 +0800
Message-ID: <20250806143615.1661283-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250806143615.1661283-1-hsiangkao@linux.alibaba.com>
References: <20250806143615.1661283-1-hsiangkao@linux.alibaba.com>
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

From: Yifan Zhao <zhaoyifan28@huawei.com>

This patch introduces experimental S3 support for mkfs.erofs, allowing
EROFS images to be generated from AWS S3 and/or other S3 API-compatible
services.

Here are the current limitations:
 - Only meta-only EROFS image generation is supported;
 - Only AWS Signature Version 2 is supported;
 - The S3 object names and sizes are strictly respected during image
   generation.

Co-Developed-by: Hongbo Li <lihongbo22@huawei.com>
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/Makefile.am   |   3 +
 lib/liberofs_s3.h |   2 +
 lib/remotes/s3.c  | 621 ++++++++++++++++++++++++++++++++++++++++++++++
 mkfs/main.c       |   9 +-
 4 files changed, 633 insertions(+), 2 deletions(-)
 create mode 100644 lib/remotes/s3.c

diff --git a/lib/Makefile.am b/lib/Makefile.am
index 6458acf..b079897 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -67,6 +67,9 @@ else
 liberofs_la_SOURCES += xxhash.c
 endif
 liberofs_la_CFLAGS += ${libcurl_CFLAGS} ${openssl_CFLAGS} ${libxml2_CFLAGS}
+if ENABLE_S3
+liberofs_la_SOURCES += remotes/s3.c
+endif
 if ENABLE_EROFS_MT
 liberofs_la_LDFLAGS = -lpthread
 liberofs_la_SOURCES += workqueue.c
diff --git a/lib/liberofs_s3.h b/lib/liberofs_s3.h
index fbf2f80..fbcb8a6 100644
--- a/lib/liberofs_s3.h
+++ b/lib/liberofs_s3.h
@@ -33,6 +33,8 @@ struct erofs_s3 {
 	enum s3erofs_signature_version sig;
 };
 
+int s3erofs_build_trees(struct erofs_inode *root, struct erofs_s3 *s3cfg);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
new file mode 100644
index 0000000..c81675d
--- /dev/null
+++ b/lib/remotes/s3.c
@@ -0,0 +1,621 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
+/*
+ * Copyright (C) 2025 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Yifan Zhao <zhaoyifan28@huawei.com>
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <time.h>
+#include <curl/curl.h>
+#include <libxml/parser.h>
+#include <openssl/hmac.h>
+#include "erofs/internal.h"
+#include "erofs/print.h"
+#include "erofs/inode.h"
+#include "erofs/blobchunk.h"
+#include "erofs/rebuild.h"
+#include "liberofs_s3.h"
+
+#define S3EROFS_MAX_QUERY_PARAMS	16
+#define S3EROFS_URL_LEN			8192
+#define S3EROFS_CANONICAL_QUERY_LEN	2048
+
+#define BASE64_ENCODE_LEN(len) (((len + 2) / 3) * 4)
+
+static CURL *easy_curl;
+
+struct s3erofs_query_params {
+	int num;
+	const char *key[S3EROFS_MAX_QUERY_PARAMS];
+	const char *value[S3EROFS_MAX_QUERY_PARAMS];
+};
+
+struct s3erofs_curl_request {
+	const char *method;
+	char url[S3EROFS_URL_LEN];
+	char canonical_query[S3EROFS_CANONICAL_QUERY_LEN];
+};
+
+static int s3erofs_prepare_url(struct s3erofs_curl_request *req,
+			       const char *endpoint,
+			       const char *bucket, const char *object,
+			       struct s3erofs_query_params *params,
+			       enum s3erofs_url_style url_style)
+{
+	static const char https[] = "https://";
+	const char *schema, *host;
+	char *url = req->url;
+	int pos, i;
+
+	if (!endpoint || !bucket)
+		return -EINVAL;
+
+	schema = strstr(endpoint, "://");
+	if (!schema) {
+		schema = https;
+		host = endpoint;
+	} else {
+		host = schema + sizeof("://") - 1;
+		schema = strndup(endpoint, host - endpoint);
+		if (!schema)
+			return -ENOMEM;
+	}
+
+	if (url_style == S3EROFS_URL_STYLE_VIRTUAL_HOST)
+		pos = snprintf(url, S3EROFS_URL_LEN, "%s%s.%s", schema, bucket, host);
+	else
+		pos = snprintf(url, S3EROFS_URL_LEN, "%s%s/%s", schema, host, bucket);
+
+	if (object) {
+		pos += snprintf(url + pos, S3EROFS_URL_LEN - pos, "/%s", object);
+		i = snprintf(req->canonical_query, S3EROFS_CANONICAL_QUERY_LEN,
+			     "/%s/%s", bucket, object);
+	} else {
+		i = snprintf(req->canonical_query, S3EROFS_CANONICAL_QUERY_LEN,
+			 "/%s/", bucket);
+	}
+	req->canonical_query[i] = '\0';
+
+	erofs_err("url: %s", url);
+
+	for (i = 0; i < params->num; i++)
+		pos += snprintf(url + pos, S3EROFS_URL_LEN - pos, "%c%s=%s", (!i ? '?' : '&'),
+				params->key[i], params->value[i]);
+	if (schema != https)
+		free((void *)schema);
+	return 0;
+}
+
+static char *get_canonical_headers(const struct curl_slist *list) { return ""; }
+
+// See: https://docs.aws.amazon.com/AmazonS3/latest/API/RESTAuthentication.html#ConstructingTheAuthenticationHeader
+static char *s3erofs_sigv2_header(const struct curl_slist *headers, const char *method,
+				  const char *content_md5, const char *content_type,
+				  const char *date, const char *canonical_query, const char *ak,
+				  const char *sk)
+{
+	u8 hmac_signature[EVP_MAX_MD_SIZE];
+	char *str, *output = NULL;
+	unsigned int len, pos, output_len;
+	const char *canonical_headers = get_canonical_headers(headers);
+	const char *prefix = "Authorization: AWS ";
+
+	if (!method || !date || !ak || !sk)
+		return ERR_PTR(-EINVAL);
+
+	if (!content_md5)
+		content_md5 = "";
+	if (!content_type)
+		content_type = "";
+	if (!canonical_query)
+		canonical_query = "/";
+
+	pos = asprintf(&str, "%s\n%s\n%s\n%s\n%s%s", method, content_md5,
+		       content_type, date, canonical_headers, canonical_query);
+	if (pos < 0)
+		return ERR_PTR(-ENOMEM);
+
+	if (!HMAC(EVP_sha1(), sk, strlen(sk), (u8 *)str, strlen(str), hmac_signature, &len))
+		goto free_string;
+
+	output_len = BASE64_ENCODE_LEN(len);
+	output_len += strlen(prefix);
+	output_len += strlen(ak);
+	output_len += 1;	/* for ':' between ak and signature */
+
+	output = (char *)malloc(output_len + 1);
+	if (!output)
+		goto free_string;
+
+	pos = snprintf(output, output_len, "%s%s:", prefix, ak);
+	if (pos < 0)
+		goto free_string;
+	EVP_EncodeBlock((u8 *)output + pos, hmac_signature, len);
+free_string:
+	free(str);
+	return output ?: ERR_PTR(-ENOMEM);
+}
+
+static void s3erofs_now_rfc1123(char *buf, size_t maxlen)
+{
+	time_t now = time(NULL);
+	struct tm *ptm = gmtime(&now);
+	strftime(buf, maxlen, "%a, %d %b %Y %H:%M:%S GMT", ptm);
+}
+
+struct s3erofs_curl_response {
+	char *data;
+	size_t size;
+};
+
+static size_t s3erofs_request_write_memory_cb(void *contents, size_t size, size_t nmemb,
+					      void *userp)
+{
+	size_t realsize = size * nmemb;
+	struct s3erofs_curl_response *response = (struct s3erofs_curl_response *)userp;
+	void *tmp;
+
+	tmp = realloc(response->data, response->size + realsize + 1);
+	if (tmp == NULL)
+		return 0;
+
+	response->data = tmp;
+
+	memcpy(response->data + response->size, contents, realsize);
+	response->size += realsize;
+	response->data[response->size] = '\0';
+	return realsize;
+}
+
+static int s3erofs_request_insert_auth(struct curl_slist **request_headers, const char *method,
+				       const char *canonical_query, const char *ak, const char *sk)
+{
+	const char date_prefix[] = "Date: ";
+	char date_header[64];
+	char *sigv2_header;
+
+	memcpy(date_header, date_prefix, sizeof(date_prefix) - 1);
+	s3erofs_now_rfc1123(date_header + sizeof(date_prefix) - 1,
+			    sizeof(date_header) - sizeof(date_prefix) + 1);
+
+	sigv2_header = s3erofs_sigv2_header(*request_headers, method, NULL, NULL,
+					    date_header + sizeof(date_prefix) - 1,
+					    canonical_query, ak, sk);
+	if (IS_ERR(sigv2_header))
+		return PTR_ERR(sigv2_header);
+
+	*request_headers = curl_slist_append(*request_headers, date_header);
+	*request_headers = curl_slist_append(*request_headers, sigv2_header);
+
+	free(sigv2_header);
+	return 0;
+}
+
+static int s3erofs_request_perform(struct erofs_s3 *s3cfg,
+				   struct s3erofs_curl_request *req, void *resp)
+{
+	struct curl_slist *request_headers = NULL;
+	long http_code = 0;
+	int ret;
+
+	ret = s3erofs_request_insert_auth(&request_headers, req->method, req->canonical_query,
+					  s3cfg->access_key, s3cfg->secret_key);
+	if (ret < 0) {
+		erofs_err("failed to insert auth headers");
+		return ret;
+	}
+
+	curl_easy_setopt(easy_curl, CURLOPT_URL, req->url);
+	curl_easy_setopt(easy_curl, CURLOPT_WRITEDATA, resp);
+	curl_easy_setopt(easy_curl, CURLOPT_HTTPHEADER, request_headers);
+
+	ret = curl_easy_perform(easy_curl);
+	if (ret != CURLE_OK) {
+		erofs_err("curl_easy_perform() failed: %s", curl_easy_strerror(ret));
+		ret = -EIO;
+		goto err_header;
+	}
+
+	ret = curl_easy_getinfo(easy_curl, CURLINFO_RESPONSE_CODE, &http_code);
+	if (ret != CURLE_OK) {
+		erofs_err("curl_easy_getinfo() failed: %s", curl_easy_strerror(ret));
+		ret = -EIO;
+		goto err_header;
+	}
+
+	if (!(http_code >= 200 && http_code < 300)) {
+		erofs_err("request failed with HTTP code %ld", http_code);
+		ret = -EIO;
+	}
+
+err_header:
+	curl_slist_free_all(request_headers);
+	return ret;
+}
+
+struct s3erofs_object_info {
+	char *key;
+	u64 size;
+	time_t mtime;
+};
+
+struct s3erofs_object_iterator {
+	struct s3erofs_object_info *objects;
+	int cur;
+
+	struct erofs_s3 *s3cfg;
+	const char *prefix, *delimiter;
+
+	char *next_marker;
+	bool is_truncated;
+};
+
+static int s3erofs_parse_list_objects_one(xmlNodePtr node,
+					  struct s3erofs_object_info *info)
+{
+	xmlNodePtr child;
+	xmlChar *str;
+
+	for (child = node->children; child; child = child->next) {
+		if (child->type == XML_ELEMENT_NODE) {
+			str = xmlNodeGetContent(child);
+			if (!str)
+				return -ENOMEM;
+
+			if (xmlStrEqual(child->name, (const xmlChar *)"LastModified")) {
+				struct tm tm = {};
+
+				if (sscanf((char *)str, "%d-%d-%dT%d:%d:%d",
+					&tm.tm_year, &tm.tm_mon, &tm.tm_mday,
+					&tm.tm_hour, &tm.tm_min, &tm.tm_sec) != 6) {
+					xmlFree(str);
+					return -EIO;
+				}
+				tm.tm_year -= 1900;
+				tm.tm_mon -= 1;
+				info->mtime = mktime(&tm);
+			}
+			if (xmlStrEqual(child->name, (const xmlChar *)"Key")) {
+				info->key = strdup((char *)str);
+			} else if (xmlStrEqual(child->name, (const xmlChar *)"Size")) {
+				info->size = atoll((char *)str);
+			}
+			xmlFree(str);
+		}
+	}
+	return 0;
+}
+
+static int s3erofs_parse_list_objects_result(const char *data, int len,
+					     struct s3erofs_object_iterator *it)
+{
+	xmlNodePtr root = NULL, node, next;
+	int ret, i, contents_count;
+	xmlDocPtr doc = NULL;
+	xmlChar *str;
+	void *tmp;
+
+	doc = xmlReadMemory(data, len, NULL, NULL, 0);
+	if (!doc) {
+		erofs_err("failed to parse XML data");
+		return -EINVAL;
+	}
+
+	root = xmlDocGetRootElement(doc);
+	if (!root) {
+		erofs_err("failed to get root element");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (!xmlStrEqual(root->name, (const xmlChar *)"ListBucketResult")) {
+		erofs_err("invalid root element: expected ListBucketResult, got %s", root->name);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	contents_count = 1;
+	for (node = root->children; node; node = next) {
+		next = node->next;
+		if (node->type == XML_ELEMENT_NODE) {
+			if (xmlStrEqual(node->name, (const xmlChar *)"Contents")) {
+				++contents_count;
+				continue;
+			}
+			if (xmlStrEqual(node->name, (const xmlChar *)"IsTruncated")) {
+				str = xmlNodeGetContent(node);
+				if (str) {
+					it->is_truncated =
+						!!xmlStrEqual(str, (const xmlChar *)"true");
+					xmlFree(str);
+				}
+			} else if (xmlStrEqual(node->name, (const xmlChar *)"NextMarker")) {
+				str = xmlNodeGetContent(node);
+				if (str) {
+					free(it->next_marker);
+					it->next_marker = strdup((char *)str);
+					xmlFree(str);
+					if (!it->next_marker) {
+						ret = -ENOMEM;
+						goto out;
+					}
+				}
+			}
+			xmlUnlinkNode(node);
+		}
+		xmlUnlinkNode(node);
+		xmlFreeNode(node);
+	}
+
+	i = 0;
+	if (it->objects) {
+		for (; it->objects[i].key; ++i) {
+			free(it->objects[i].key);
+			it->objects[i].key = NULL;
+		}
+	}
+
+	if (i + 1 < contents_count) {
+		tmp = malloc(contents_count * sizeof(*it->objects));
+		if (!tmp) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		free(it->objects);
+		it->objects = tmp;
+		it->objects[0].key = NULL;
+	}
+	it->cur = 0;
+
+	ret = 0;
+	for (i = 0, node = root->children; node; node = node->next) {
+		if (__erofs_unlikely(i >= contents_count - 1)) {
+			DBG_BUGON(1);
+			continue;
+		}
+		ret = s3erofs_parse_list_objects_one(node, &it->objects[i]);
+		if (ret < 0) {
+			erofs_err("failed to parse contents node %s: %s",
+				  (const char *)node->name, erofs_strerror(ret));
+			break;
+		}
+		it->objects[++i].key = NULL;
+	}
+	if (!ret)
+		ret = i;
+out:
+	xmlFreeDoc(doc);
+	return ret;
+}
+
+static int s3erofs_list_objects(struct s3erofs_object_iterator *it)
+{
+	struct s3erofs_curl_request req = {};
+	struct s3erofs_curl_response resp = {};
+	struct s3erofs_query_params params;
+	int ret = 0;
+
+	struct erofs_s3 *s3cfg = it->s3cfg;
+
+	if (it->prefix && strlen(it->prefix) > 1024) {
+		erofs_err("prefix is too long");
+		return -EINVAL;
+	}
+
+	if (it->delimiter && strlen(it->delimiter) > 1024) {
+		erofs_err("delimiter is too long");
+		return -EINVAL;
+	}
+
+	params.num = 0;
+	if (it->prefix) {
+		params.key[params.num] = "prefix";
+		params.value[params.num] = it->prefix;
+		++params.num;
+	}
+
+	if (it->delimiter) {
+		params.key[params.num] = "delimiter";
+		params.value[params.num] = it->delimiter;
+		++params.num;
+	}
+
+	if (it->next_marker) {
+		params.key[params.num] = "marker";
+		params.value[params.num] = it->next_marker;
+		++params.num;
+	}
+
+	params.key[params.num] = "max-keys";
+	params.value[params.num] = "1000";
+	++params.num;
+
+	req.method = "GET";
+	ret = s3erofs_prepare_url(&req, s3cfg->endpoint, s3cfg->bucket, NULL,
+				  &params, s3cfg->url_style);
+	if (ret < 0)
+		return ret;
+
+	ret = s3erofs_request_perform(s3cfg, &req, &resp);
+	if (ret < 0)
+		return ret;
+
+	ret = s3erofs_parse_list_objects_result(resp.data, resp.size, it);
+	if (ret < 0)
+		return ret;
+	free(resp.data);
+	return 0;
+}
+
+static struct s3erofs_object_iterator *
+s3erofs_create_object_iterator(struct erofs_s3 *s3cfg, const char *prefix,
+			       const char *delimiter)
+{
+	struct s3erofs_object_iterator *iter;
+
+	iter = calloc(1, sizeof(struct s3erofs_object_iterator));
+	if (!iter)
+		return ERR_PTR(-ENOMEM);
+	iter->s3cfg = s3cfg;
+	iter->prefix = prefix;
+	iter->delimiter = delimiter;
+	iter->is_truncated = true;
+	return iter;
+}
+
+static void s3erofs_destroy_object_iterator(struct s3erofs_object_iterator *it)
+{
+	int i;
+
+	if (it->next_marker)
+		free(it->next_marker);
+	if (it->objects) {
+		for (i = 0; it->objects[i].key; ++i)
+			free(it->objects[i].key);
+		free(it->objects);
+	}
+	free(it);
+}
+
+static struct s3erofs_object_info *
+s3erofs_get_next_object(struct s3erofs_object_iterator *it)
+{
+	int ret;
+
+	if (it->objects && it->objects[it->cur].key)
+		return &it->objects[it->cur++];
+
+	if (it->is_truncated) {
+		ret = s3erofs_list_objects(it);
+		if (ret < 0)
+			return ERR_PTR(ret);
+		return &it->objects[it->cur++];
+	}
+	return NULL;
+}
+
+static int s3erofs_global_init(void)
+{
+	if (curl_global_init(CURL_GLOBAL_DEFAULT) != CURLE_OK)
+		return -EIO;
+
+	easy_curl = curl_easy_init();
+	if (!easy_curl)
+		goto out_err;
+
+	if (curl_easy_setopt(easy_curl, CURLOPT_WRITEFUNCTION,
+			     s3erofs_request_write_memory_cb) != CURLE_OK)
+		goto out_err;
+
+	if (curl_easy_setopt(easy_curl, CURLOPT_FOLLOWLOCATION, 1L) != CURLE_OK)
+		goto out_err;
+
+	if (curl_easy_setopt(easy_curl, CURLOPT_TIMEOUT, 30L) != CURLE_OK)
+		goto out_err;
+
+	if (curl_easy_setopt(easy_curl, CURLOPT_USERAGENT,
+			     "liberofs/" PACKAGE_VERSION) != CURLE_OK)
+		goto out_err;
+
+	xmlInitParser();
+	return 0;
+out_err:
+	curl_global_cleanup();
+	return -EIO;
+}
+
+static void s3erofs_global_exit(void)
+{
+	if (!easy_curl)
+		return;
+
+	xmlCleanupParser();
+
+	curl_easy_cleanup(easy_curl);
+	easy_curl = NULL;
+
+	curl_global_cleanup();
+}
+
+int s3erofs_build_trees(struct erofs_inode *root, struct erofs_s3 *s3cfg)
+{
+	struct erofs_sb_info *sbi = root->sbi;
+	struct s3erofs_object_iterator *iter;
+	struct s3erofs_object_info *obj;
+	struct erofs_dentry *d;
+	struct erofs_inode *inode;
+	struct stat st;
+	bool dumb;
+	int ret = 0;
+
+	st.st_uid = root->i_uid;
+	st.st_gid = root->i_gid;
+
+	ret = s3erofs_global_init();
+	if (ret) {
+		erofs_err("failed to initialize s3erofs: %s", erofs_strerror(ret));
+		return ret;
+	}
+
+	iter = s3erofs_create_object_iterator(s3cfg, NULL, NULL);
+	if (IS_ERR(iter)) {
+		erofs_err("failed to create object iterator");
+		ret = PTR_ERR(iter);
+		goto err_global;
+	}
+
+	while (1) {
+		obj = s3erofs_get_next_object(iter);
+		if (!obj) {
+			break;
+		} else if (IS_ERR(obj)) {
+			erofs_err("failed to get next object");
+			ret = PTR_ERR(obj);
+			goto err_iter;
+		}
+
+		d = erofs_rebuild_get_dentry(root, obj->key, false, &dumb, &dumb, false);
+		if (IS_ERR(d)) {
+			ret = PTR_ERR(d);
+			goto err_iter;
+		}
+		if (d->type == EROFS_FT_DIR) {
+			inode = d->inode;
+			inode->i_mode = S_IFDIR | 0755;
+		} else {
+			inode = erofs_new_inode(sbi);
+			if (IS_ERR(inode)) {
+				ret = PTR_ERR(inode);
+				goto err_iter;
+			}
+
+			inode->i_mode = S_IFREG | 0644;
+			inode->i_parent = d->inode;
+			inode->i_nlink = 1;
+
+			d->inode = inode;
+			d->type = EROFS_FT_REG_FILE;
+		}
+		inode->i_srcpath = strdup(obj->key);
+		if (!inode->i_srcpath) {
+			ret = -ENOMEM;
+			goto err_iter;
+		}
+		st.st_mtime = obj->mtime;
+		ret = __erofs_fill_inode(inode, &st, obj->key);
+		if (!ret && S_ISREG(inode->i_mode)) {
+			inode->i_size = obj->size;
+			ret = erofs_write_zero_inode(inode);
+		}
+		if (ret)
+			goto err_iter;
+	}
+
+err_iter:
+	s3erofs_destroy_object_iterator(iter);
+err_global:
+	s3erofs_global_exit();
+	return ret;
+}
diff --git a/mkfs/main.c b/mkfs/main.c
index ecc1bbe..d8dcedb 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1735,8 +1735,13 @@ int main(int argc, char **argv)
 				goto exit;
 #ifdef S3EROFS_ENABLED
 		} else if (source_mode == EROFS_MKFS_SOURCE_S3) {
-			err = -EOPNOTSUPP;
-			goto exit;
+			if (incremental_mode ||
+			    dataimport_mode != EROFS_MKFS_DATA_IMPORT_RVSP)
+				err = -EOPNOTSUPP;
+			else
+				err = s3erofs_build_trees(root, &s3cfg);
+			if (err)
+				goto exit;
 #endif
 		}
 
-- 
2.43.5


