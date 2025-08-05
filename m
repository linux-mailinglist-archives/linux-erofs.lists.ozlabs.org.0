Return-Path: <linux-erofs+bounces-767-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77827B1AC9B
	for <lists+linux-erofs@lfdr.de>; Tue,  5 Aug 2025 05:05:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bwywv0X1Fz2yLJ;
	Tue,  5 Aug 2025 13:05:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754363151;
	cv=none; b=PDh6Z5CFGKSs6dt5EB0gseSRkd2smo09bPVrAra1kRovdRlNqd6RINItYw/08TL26MI89CImQ9TOwarpkjn5bbkYeig6/tNo7WuOAWbXcgzGhno1Y0kWcf9Lqqx9tr63GSVn++A9dpUxYXf3yfGm6K+q/f0psP61/budn/C4Jsz0/XCCbCjLeAyikYvtNJWnt1ErQXG4LV7wN+7KhPQ3eoul/vqZWoYFUfNwQsSczuwa9Skhg7kDPUgcaFCr7DaedUcYW9AayPgV4QE9NkQL/nNSbG0ayCPrR0togiEOArwnk0awaFgF0zakcEptJpp+xrbqoivuCzw6wZu2B3nY9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754363151; c=relaxed/relaxed;
	bh=anYfHUT20aV60ulh/IQQoUGlyVssZ2ZVWFEYUMAnMto=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PalckPSIJcQbzdJP9AdmxIuPgCUDlVZ0P/NGOJQx4mx0A1lCsWC3LtoYU+5tJWwOi3CRtpiwHx2qsmi6qIRB+VQjyD1ujowsGD26GAnAP77ajBevWXxU89WJxOJ3PogM+AmVlPCCjVXVlMdHgvdsKT3vIlAHmVPT4nRrCCp8TVgIn1x4hH0CmTngyma/gz5CFnVljeBJu0Eab1lEqGVH34ox7k8UiBHTmNEvUDcaFcp9b+z4hjAIsj+naT/kL33L1zeP9c3sVOl8k3fm6fAV37F2nFbXXT1ey0eNVvSdLKfOOw92L7koWQG1YsjCZXBHJ/OHXhNDx4LNCXIQMEhNgQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bwyws3SHFz3bby
	for <linux-erofs@lists.ozlabs.org>; Tue,  5 Aug 2025 13:05:49 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bwypN0lbNz14MBt;
	Tue,  5 Aug 2025 11:00:12 +0800 (CST)
Received: from kwepemp500007.china.huawei.com (unknown [7.202.195.151])
	by mail.maildlp.com (Postfix) with ESMTPS id BF22F140144;
	Tue,  5 Aug 2025 11:05:07 +0800 (CST)
Received: from localhost.localdomain (10.175.124.27) by
 kwepemp500007.china.huawei.com (7.202.195.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 5 Aug 2025 11:05:07 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <hsiangkao@linux.alibaba.com>, <jingrui@huawei.com>,
	<lihongbo22@huawei.com>, zhaoyifan <zhaoyifan28@huawei.com>
Subject: [PATCH v4 4/4] erofs-utils: mkfs: support EROFS index-only image generation from S3
Date: Tue, 5 Aug 2025 11:04:43 +0800
Message-ID: <20250805030443.446435-1-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250804152825.428197-4-zhaoyifan28@huawei.com>
References: <20250804152825.428197-4-zhaoyifan28@huawei.com>
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
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemp500007.china.huawei.com (7.202.195.151)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: zhaoyifan <zhaoyifan28@huawei.com>

This patch introduces experimental S3 support for mkfs.erofs, allowing
EROFS images to be generated from AWS S3 (and other S3 API compatible
services).

Currently the functionality is limited:
- only index-only EROFS image generation are supported
- only AWS Signature Version 2 is supported
- only S3 object name and size are respected during image generation

Co-Developed-by: Hongbo Li <lihongbo22@huawei.com>
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
change since v3:
- use ssl on default
- endpoint must begin with "http(s)", keep consistent with s3fs

 lib/liberofs_s3.h |   2 +
 lib/remotes/s3.c  | 615 ++++++++++++++++++++++++++++++++++++++++++++++
 mkfs/main.c       |   5 +-
 3 files changed, 620 insertions(+), 2 deletions(-)

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
index 6b83949..dd682a4 100644
--- a/lib/remotes/s3.c
+++ b/lib/remotes/s3.c
@@ -4,4 +4,619 @@
  *             http://www.huawei.com/
  * Created by Yifan Zhao <zhaoyifan28@huawei.com>
  */
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
 #include "liberofs_s3.h"
+
+#define S3EROFS_MAX_QUERY_PARAMS    16
+#define S3EROFS_URL_LEN		    8192
+#define S3EROFS_CANONICAL_QUERY_LEN 2048
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
+static int s3erofs_prepare_url(const char *endpoint, const char *bucket, const char *object,
+			       struct s3erofs_query_params *params, char *url,
+			       enum s3erofs_url_style url_style)
+{
+	const char *schema = NULL;
+	const char *host = NULL;
+	size_t pos = 0;
+	int i;
+
+	if (!endpoint || !bucket || !url)
+		return -EINVAL;
+
+	if (strncmp(endpoint, "https://", 8) == 0) {
+		schema = "https://";
+		host = endpoint + 8;
+	} else if (strncmp(endpoint, "http://", 7) == 0) {
+		schema = "http://";
+		host = endpoint + 7;
+	} else {
+		erofs_err("endpoint has invalid format, missing http/https protocol");
+		return -EINVAL;
+	}
+
+	if (url_style == S3EROFS_URL_STYLE_VIRTUAL_HOST) {
+		pos += snprintf(url, S3EROFS_URL_LEN, "%s%s.%s", schema, bucket, host);
+	} else {
+		pos += snprintf(url, S3EROFS_URL_LEN, "%s%s/%s", schema, host, bucket);
+	}
+
+	if (object) {
+		pos += snprintf(url + pos, S3EROFS_URL_LEN - pos, "/%s", object);
+	}
+
+	for (i = 0; i < params->num; i++) {
+		pos += snprintf(url + pos, S3EROFS_URL_LEN - pos, "%c%s=%s", (i == 0 ? '?' : '&'),
+				params->key[i], params->value[i]);
+	}
+
+	return 0;
+}
+
+static char *get_canonical_headers(const struct curl_slist *list) { return ""; }
+
+static char *s3erofs_sigv2_header(const struct curl_slist *headers, const char *method,
+				  const char *content_md5, const char *content_type,
+				  const char *date, const char *canonical_query, const char *ak,
+				  const char *sk)
+{
+	char *str, *output = NULL;
+	u8 *hmac_signature;
+	unsigned int len = 0, pos = 0, output_len;
+	const char *canonical_headers = get_canonical_headers(headers);
+	const char *prefix = "Authorization: AWS ";
+
+	if (!method || !date || !ak || !sk) {
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (!content_md5)
+		content_md5 = "";
+	if (!content_type)
+		content_type = "";
+	if (!canonical_query)
+		canonical_query = "/";
+
+	len += strlen(method) + 1;
+	len += strlen(content_md5) + 1;
+	len += strlen(content_type) + 1;
+	len += strlen(date) + 1;
+	len += strlen(canonical_headers);
+	len += strlen(canonical_query);
+
+	str = (char *)malloc(++len);
+	if (!str)
+		return ERR_PTR(-ENOMEM);
+
+	pos += snprintf(str + pos, len - pos, "%s\n", method);
+	pos += snprintf(str + pos, len - pos, "%s\n", content_md5);
+	pos += snprintf(str + pos, len - pos, "%s\n", content_type);
+	pos += snprintf(str + pos, len - pos, "%s\n", date);
+	pos += snprintf(str + pos, len - pos, "%s", canonical_headers);
+	pos += snprintf(str + pos, len - pos, "%s", canonical_query);
+
+	hmac_signature = (u8 *)malloc(EVP_MAX_MD_SIZE);
+	if (!hmac_signature)
+		goto free_string;
+
+	if (!HMAC(EVP_sha1(), sk, strlen(sk), (u8 *)str, strlen(str), hmac_signature, &len))
+		goto free_hmac;
+
+	output_len = BASE64_ENCODE_LEN(len);
+	output_len += strlen(prefix);
+	output_len += strlen(ak);
+	/* for ':' between ak and signature*/
+	output_len += 1;
+
+	output = (char *)malloc(output_len);
+	if (!output)
+		goto free_hmac;
+
+	memcpy(output, prefix, strlen(prefix));
+	memcpy(output + strlen(prefix), ak, strlen(ak));
+	output[strlen(prefix) + strlen(ak)] = ':';
+
+	EVP_EncodeBlock((unsigned char *)output + strlen(prefix) + strlen(ak) + 1, hmac_signature,
+			len);
+
+free_hmac:
+	free(hmac_signature);
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
+struct s3erofs_curl_request {
+	const char *method;
+	char url[S3EROFS_URL_LEN];
+	char canonical_query[S3EROFS_CANONICAL_QUERY_LEN];
+};
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
+
+	return realsize;
+}
+
+static int s3erofs_request_insert_auth(struct curl_slist **request_headers, const char *method,
+				       const char *canonical_query, const char *ak, const char *sk)
+{
+	char date_header[40];
+	const char *date_prefix = "Date: ";
+	size_t date_prefix_len = strlen(date_prefix);
+	char *sigv2_header;
+
+	memcpy(date_header, date_prefix, date_prefix_len);
+	s3erofs_now_rfc1123(date_header + date_prefix_len, sizeof(date_header) - date_prefix_len);
+
+	sigv2_header = s3erofs_sigv2_header(*request_headers, method, NULL, NULL,
+					    date_header + date_prefix_len, canonical_query, ak, sk);
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
+static int s3erofs_request_perform(struct erofs_s3 *s3cfg, struct s3erofs_curl_request *req,
+				   struct s3erofs_curl_response *resp)
+{
+	struct curl_slist *request_headers = NULL;
+	long http_code = 0;
+	int ret;
+
+	ret = s3erofs_request_insert_auth(&request_headers, req->method, req->canonical_query,
+					  s3cfg->access_key, s3cfg->secret_key);
+	if (ret < 0) {
+		erofs_err("failed to insert auth headers\n");
+		return ret;
+	}
+
+	curl_easy_setopt(easy_curl, CURLOPT_URL, req->url);
+	curl_easy_setopt(easy_curl, CURLOPT_WRITEDATA, resp);
+	curl_easy_setopt(easy_curl, CURLOPT_HTTPHEADER, request_headers);
+
+	ret = curl_easy_perform(easy_curl);
+	if (ret != CURLE_OK) {
+		erofs_err("curl_easy_perform() failed: %s\n", curl_easy_strerror(ret));
+		ret = -EIO;
+		goto err_header;
+	}
+
+	ret = curl_easy_getinfo(easy_curl, CURLINFO_RESPONSE_CODE, &http_code);
+	if (ret != CURLE_OK) {
+		erofs_err("curl_easy_getinfo() failed: %s\n", curl_easy_strerror(ret));
+		ret = -EIO;
+		goto err_header;
+	}
+
+	if (!(http_code >= 200 && http_code < 300)) {
+		erofs_err("request failed with HTTP code %ld\n", http_code);
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
+	int cur, total;
+
+	struct erofs_s3 *s3cfg;
+	const char *prefix, *delimiter;
+
+	char *next_marker;
+	bool is_truncated;
+};
+
+static int s3erofs_parse_list_objects_one(xmlNodePtr node, struct s3erofs_object_info *info)
+{
+	xmlNodePtr child;
+	xmlChar *str;
+
+	for (child = node->children; child; child = child->next) {
+		if (child->type == XML_ELEMENT_NODE) {
+			str = xmlNodeGetContent(child);
+			if (!str) {
+				return -ENOMEM;
+			}
+
+			if (xmlStrEqual(child->name, (const xmlChar *)"LastModified")) {
+				struct tm tm = {0};
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
+
+			xmlFree(str);
+		}
+	}
+
+	return 0;
+}
+
+static int s3erofs_parse_list_objects_result(const char *data, int len,
+					     struct s3erofs_object_iterator *it)
+{
+	xmlDocPtr doc = NULL;
+	xmlNodePtr root = NULL, node;
+	xmlChar *str;
+	xmlNodePtr contents_nodes[1000];
+	int contents_count = 0;
+	int i = 0;
+	int ret = 0;
+	void *tmp;
+
+	doc = xmlReadMemory(data, len, NULL, NULL, 0);
+	if (!doc) {
+		erofs_err("failed to parse XML data\n");
+		return -EINVAL;
+	}
+
+	root = xmlDocGetRootElement(doc);
+	if (!root) {
+		erofs_err("failed to get root element\n");
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
+	for (node = root->children; node; node = node->next) {
+		if (node->type == XML_ELEMENT_NODE) {
+			if (xmlStrEqual(node->name, (const xmlChar *)"Contents")) {
+				if (contents_count < 1000)
+					contents_nodes[contents_count++] = node;
+			} else if (xmlStrEqual(node->name, (const xmlChar *)"IsTruncated")) {
+				str = xmlNodeGetContent(node);
+				if (str) {
+					it->is_truncated =
+					    xmlStrEqual(str, (const xmlChar *)"true") ? true
+										      : false;
+					xmlFree(str);
+				}
+			} else if (xmlStrEqual(node->name, (const xmlChar *)"NextMarker")) {
+				str = xmlNodeGetContent(node);
+				if (str) {
+					if (it->next_marker)
+						free(it->next_marker);
+					it->next_marker = strdup((char *)str);
+					if (!it->next_marker) {
+						xmlFree(str);
+						ret = -ENOMEM;
+						goto out;
+					}
+					xmlFree(str);
+				}
+			}
+		}
+	}
+
+	if (contents_count == 0)
+		goto out;
+
+	tmp = realloc(it->objects, contents_count * sizeof(struct s3erofs_object_info));
+	if (!tmp) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	memset(tmp, 0, contents_count * sizeof(struct s3erofs_object_info));
+	it->objects = tmp;
+
+	for (i = 0; i < contents_count; i++) {
+		ret = s3erofs_parse_list_objects_one(contents_nodes[i], &it->objects[i]);
+		if (ret < 0) {
+			erofs_err("failed to parse contents node #%d, ret:%d", i, ret);
+			while (--i >= 0)
+				free(it->objects[i].key);
+			free(it->objects);
+			goto out;
+		}
+	}
+
+	it->total = contents_count;
+
+out:
+	xmlFreeDoc(doc);
+	return ret;
+}
+
+static int s3erofs_list_objects(struct s3erofs_object_iterator *it)
+{
+	struct s3erofs_curl_request req = {0};
+	struct s3erofs_curl_response resp = {0};
+	struct s3erofs_query_params params = {0};
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
+	ret = s3erofs_prepare_url(s3cfg->endpoint, s3cfg->bucket, NULL, &params,
+				  req.url, s3cfg->url_style);
+	if (ret < 0)
+		return ret;
+
+	snprintf(req.canonical_query, S3EROFS_CANONICAL_QUERY_LEN, "/%s", s3cfg->bucket);
+
+	ret = s3erofs_request_perform(s3cfg, &req, &resp);
+	if (ret < 0)
+		return ret;
+
+	ret = s3erofs_parse_list_objects_result(resp.data, resp.size, it);
+	if (ret < 0)
+		return ret;
+
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
+		for (i = 0; i < it->total; i++)
+			free(it->objects[i].key);
+		free(it->objects);
+	}
+
+	free(it);
+}
+
+static struct s3erofs_object_info *
+s3erofs_get_next_object(struct s3erofs_object_iterator *it)
+{
+	int ret = 0;
+
+	if (it->cur < it->total)
+		return &it->objects[it->cur++];
+
+	if (it->is_truncated) {
+		ret = s3erofs_list_objects(it);
+		if (ret < 0)
+			return ERR_PTR(ret);
+
+		it->cur = 0;
+		return &it->objects[it->cur++];
+	}
+
+	return NULL;
+}
+
+static int s3erofs_global_init(void)
+{
+	int ret;
+
+	ret = curl_global_init(CURL_GLOBAL_DEFAULT);
+	if (ret != CURLE_OK)
+		return -EIO;
+
+	easy_curl = curl_easy_init();
+	if (!easy_curl) {
+		curl_global_cleanup();
+		return -EIO;
+	}
+
+	curl_easy_setopt(easy_curl, CURLOPT_WRITEFUNCTION, s3erofs_request_write_memory_cb);
+	curl_easy_setopt(easy_curl, CURLOPT_FOLLOWLOCATION, 1L);
+	curl_easy_setopt(easy_curl, CURLOPT_TIMEOUT, 30L);
+
+	xmlInitParser();
+
+	return ret;
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
+	st.st_uid = getuid();
+	st.st_gid = getgid();
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
+		if (ret)
+			goto err_iter;
+		inode->i_size = obj->size;
+		if (S_ISREG(inode->i_mode)) {
+			ret = erofs_write_zero_inode(inode);
+			if (ret)
+				goto err_iter;
+		}
+	}
+
+err_iter:
+	s3erofs_destroy_object_iterator(iter);
+err_global:
+	s3erofs_global_exit();
+	return ret;
+}
diff --git a/mkfs/main.c b/mkfs/main.c
index 2671834..6874c09 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1738,8 +1738,9 @@ int main(int argc, char **argv)
 				goto exit;
 #ifdef S3_ENABLED
 		} else if (source_mode == EROFS_MKFS_SOURCE_S3) {
-			err = -EOPNOTSUPP;
-			goto exit;
+			err = s3erofs_build_trees(root, &s3cfg);
+			if (err)
+				goto exit;
 #endif
 		}
 
-- 
2.46.0


