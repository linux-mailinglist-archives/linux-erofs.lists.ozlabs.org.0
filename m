Return-Path: <linux-erofs+bounces-742-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2C1B17DCE
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Aug 2025 09:52:18 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4btdTD3zDbz2ymc;
	Fri,  1 Aug 2025 17:52:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754034736;
	cv=none; b=NY16BrVQ5tC/XPalDbghfjDtHCvPGbnY8iIdoz8/LLbozrpr/6Y0/Pm3cYxxKmHAYcy4rvtfXnJtnY7dkrwOdcneFarGrD7yOFe/lRDU6HAliR/lqG8TZYb7ZT/LzIZO9fIZsAc9A8TH+asGflVWrW4KitdE/mEO6G0f6oYEGgk3i2Vxm3boFOD7SohoU6kB8/tQ8jtKIIUaEPgIbTe87TdqIT5dMRiUR5vJKNhhPP0KNTP92dPZKSBJxIPPoghtT93K6mwKLEALbBN2LyXIDQh6D1+zKTkh3pald6q8lF4syeWDMuNajloshBFZ8bnDLPgY8wP7COn9SVY5LRJBGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754034736; c=relaxed/relaxed;
	bh=x3h+i0PMxPnS6SSbH1EXcMSbcZrZjEe6+1htL7jktVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BLnOmboYcBmdNFexnGZs4OvFewql2FZkYfLTNHgeSp9aXX5aEn1TaOPnRi13LmnciX1SVLoUkJEOMxtdvLZMgB5FSp7zL0pgOieKlEHcxY72jSDqxRQG15cmbd5FFx0KNf1PU5gvmno0wyJFJZQITqe+Jm3TirQ6gYh+n76gHypRumTi55Pz5/HJhaTRHdw+oZzvZ0oTJCiBL7/FQSrjrXvWRK0J1EK84Pn+fI0Krs/D0w55uiu0duXMzDBpHdAE8xsxj0zAzIGPI1GwYpyCF9BKZOnX7gXz62OSUGIZKdRNfPuVT9lNXtrxMHVXVu53CNUsspzP529aZ3JMDnJF0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Z6xmRTem; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Z6xmRTem;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4btdTB1PKgz2yfL
	for <linux-erofs@lists.ozlabs.org>; Fri,  1 Aug 2025 17:52:12 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754034729; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=x3h+i0PMxPnS6SSbH1EXcMSbcZrZjEe6+1htL7jktVs=;
	b=Z6xmRTem4JarPeKwZY8TBdhmjQH58NWrGPtSHD2vyumGciKZTtzQ79GWANWyJaGD1Tn7Zd8FglauFdnw6cHcefZjdlssQkh7YV1tEk0VUQHPsn/AaiqWSa4rSrR+cbQn9OFiL6FVAm/QvoZ2qVrecDaYX7iqu9+oVUVOYjhnSBs=
Received: from 30.221.131.201(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wkdlsjf_1754034727 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 01 Aug 2025 15:52:07 +0800
Message-ID: <c52b2552-5e2c-41bc-b754-66508aeddff2@linux.alibaba.com>
Date: Fri, 1 Aug 2025 15:52:06 +0800
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] erofs-utils: mkfs: support EROFS index-only image
 generation from S3
To: Yifan Zhao <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: jingrui@huawei.com, lihongbo22@huawei.com
References: <97aa3cdb-076b-4af2-a110-79250b74fc7a@linux.alibaba.com>
 <20250801073046.1900016-1-zhaoyifan28@huawei.com>
 <20250801073046.1900016-3-zhaoyifan28@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250801073046.1900016-3-zhaoyifan28@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/8/1 15:30, Yifan Zhao wrote:
> From: zhaoyifan <zhaoyifan28@huawei.com>
> 
> This patch introduces experimental S3 support for mkfs.erofs, allowing EROFS
> images to be generated from AWS S3 (and other S3 API compatible services).
> 
> Currently the functionality is limited:
> - only index-only EROFS image generation are supported
> - only AWS Signature Version 2 is supported
> - only S3 object name and size are respected during image generation
> 
> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
> ---
> change since v1:
> - get rid of erofs_init_empty_dir() as described in commit cea8581
> 
>   lib/liberofs_s3.h |   2 +
>   lib/remotes/s3.c  | 605 +++++++++++++++++++++++++++++++++++++++++++++-
>   mkfs/main.c       |   5 +-
>   3 files changed, 609 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/liberofs_s3.h b/lib/liberofs_s3.h
> index 16a06c9..a975fbb 100644
> --- a/lib/liberofs_s3.h
> +++ b/lib/liberofs_s3.h
> @@ -33,6 +33,8 @@ struct erofs_s3 {
>   	enum s3erofs_signature_version sig;
>   };
>   
> +int s3erofs_build_trees(struct erofs_inode *root, struct erofs_s3 *s3cfg);
> +
>   #ifdef __cplusplus
>   }
>   #endif
> diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
> index 358ee91..a062a50 100644
> --- a/lib/remotes/s3.c
> +++ b/lib/remotes/s3.c
> @@ -4,4 +4,607 @@
>    *             http://www.huawei.com/
>    * Created by Yifan Zhao <zhaoyifan28@huawei.com>
>    */
> -#include "liberofs_s3.h"
> \ No newline at end of file

"\ No newline at end of file"

Let's check the editor first, in principle the patches
shouldn't have this.

> +#include <stdlib.h>
> +#include <time.h>
> +#include <curl/curl.h>
> +#include <libxml/parser.h>
> +#include <openssl/hmac.h>
> +#include "erofs/internal.h"
> +#include "erofs/print.h"
> +#include "erofs/inode.h"
> +#include "erofs/blobchunk.h"
> +#include "erofs/rebuild.h"
> +#include "liberofs_s3.h"
> +
> +#define S3EROFS_MAX_QUERY_PARAMS    16
> +#define S3EROFS_URL_LEN		    8192
> +#define S3EROFS_CANONICAL_QUERY_LEN 2048
> +
> +#define BASE64_ENCODE_LEN(len) (((len + 2) / 3) * 4)
> +
> +static CURL *easy_curl;
> +
> +struct s3erofs_query_params {
> +	int num;
> +	const char *key[S3EROFS_MAX_QUERY_PARAMS];
> +	const char *value[S3EROFS_MAX_QUERY_PARAMS];
> +};
> +
> +static void s3erofs_prepare_url(const char *endpoint, const char *bucket, const char *object,
> +				struct s3erofs_query_params *params, char *url,
> +				enum s3erofs_url_style url_style)
> +{
> +	const char *schema = NULL;
> +	const char *host = NULL;
> +	size_t pos = 0;
> +	int i;
> +
> +	if (!endpoint || !bucket || !url) {
> +		return;
> +	}
> +
> +	if (strncmp(endpoint, "https://", 8) == 0) {
> +		schema = "https://";
> +		host = endpoint + 8;
> +	} else if (strncmp(endpoint, "http://", 7) == 0) {
> +		schema = "http://";
> +		host = endpoint + 7;
> +	} else {
> +		schema = "https://";
> +		host = endpoint;
> +	}
> +
> +	if (url_style == S3EROFS_URL_STYLE_VIRTUAL_HOST) {
> +		pos += snprintf(url, S3EROFS_URL_LEN, "%s%s.%s", schema, bucket, host);
> +	} else {
> +		pos += snprintf(url, S3EROFS_URL_LEN, "%s%s/%s", schema, host, bucket);
> +	}
> +
> +	if (object) {
> +		pos += snprintf(url + pos, S3EROFS_URL_LEN - pos, "/%s", object);
> +	}
> +
> +	for (i = 0; i < params->num; i++) {
> +		pos += snprintf(url + pos, S3EROFS_URL_LEN - pos, "%c%s=%s", (i == 0 ? '?' : '&'),
> +				params->key[i], params->value[i]);
> +	}
> +}
> +
> +static char *get_canonical_headers(const struct curl_slist *list) { return ""; }
> +
> +static char *s3erofs_sigv2_header(const struct curl_slist *headers, const char *method,
> +				  const char *content_md5, const char *content_type,
> +				  const char *date, const char *canonical_query, const char *ak,
> +				  const char *sk)
> +{
> +	char *str, *output = NULL;
> +	u8 *hmac_signature;
> +	unsigned int len = 0, pos = 0, output_len;
> +	const char *canonical_headers = get_canonical_headers(headers);
> +	const char *prefix = "Authorization: AWS ";
> +
> +	if (!method || !date || !ak || !sk) {
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (!content_md5)
> +		content_md5 = "";
> +	if (!content_type)
> +		content_type = "";
> +	if (!canonical_query)
> +		canonical_query = "/";
> +
> +	len += strlen(method) + 1;
> +	len += strlen(content_md5) + 1;
> +	len += strlen(content_type) + 1;
> +	len += strlen(date) + 1;
> +	len += strlen(canonical_headers);
> +	len += strlen(canonical_query);
> +
> +	str = (char *)malloc(++len);
> +	if (!str)
> +		return ERR_PTR(-ENOMEM);
> +
> +	pos += snprintf(str + pos, len - pos, "%s\n", method);
> +	pos += snprintf(str + pos, len - pos, "%s\n", content_md5);
> +	pos += snprintf(str + pos, len - pos, "%s\n", content_type);
> +	pos += snprintf(str + pos, len - pos, "%s\n", date);
> +	pos += snprintf(str + pos, len - pos, "%s", canonical_headers);
> +	pos += snprintf(str + pos, len - pos, "%s", canonical_query);
> +
> +	hmac_signature = (u8 *)malloc(EVP_MAX_MD_SIZE);
> +	if (!hmac_signature)
> +		goto free_string;
> +
> +	if (!HMAC(EVP_sha1(), sk, strlen(sk), (u8 *)str, strlen(str), hmac_signature, &len))
> +		goto free_hmac;
> +
> +	output_len = BASE64_ENCODE_LEN(len);
> +	output_len += strlen(prefix);
> +	output_len += strlen(ak);
> +	/* for ':' between ak and signature*/
> +	output_len += 1;
> +
> +	output = (char *)malloc(output_len);
> +	if (!output)
> +		goto free_hmac;
> +
> +	memcpy(output, prefix, strlen(prefix));
> +	memcpy(output + strlen(prefix), ak, strlen(ak));
> +	output[strlen(prefix) + strlen(ak)] = ':';
> +
> +	EVP_EncodeBlock((unsigned char *)output + strlen(prefix) + strlen(ak) + 1, hmac_signature,
> +			len);
> +
> +free_hmac:
> +	free(hmac_signature);
> +free_string:
> +	free(str);
> +	return output ?: ERR_PTR(-ENOMEM);
> +}
> +
> +static void s3erofs_now_rfc1123(char *buf, size_t maxlen)
> +{
> +	time_t now = time(NULL);
> +	struct tm *ptm = gmtime(&now);
> +	strftime(buf, maxlen, "%a, %d %b %Y %H:%M:%S GMT", ptm);
> +}
> +
> +struct s3erofs_curl_request {
> +	const char *method;
> +	char url[S3EROFS_URL_LEN];
> +	char canonical_query[S3EROFS_CANONICAL_QUERY_LEN];
> +};
> +
> +struct s3erofs_curl_response {
> +	char *data;
> +	size_t size;
> +};
> +
> +static size_t s3erofs_request_write_memory_cb(void *contents, size_t size, size_t nmemb,
> +					      void *userp)
> +{
> +	size_t realsize = size * nmemb;
> +	struct s3erofs_curl_response *response = (struct s3erofs_curl_response *)userp;
> +	void *tmp;
> +
> +	tmp = realloc(response->data, response->size + realsize + 1);
> +	if (tmp == NULL)
> +		return 0;
> +
> +	response->data = tmp;
> +
> +	memcpy(response->data + response->size, contents, realsize);
> +	response->size += realsize;
> +	response->data[response->size] = '\0';
> +
> +	return realsize;
> +}
> +
> +static int s3erofs_request_insert_auth(struct curl_slist **request_headers, const char *method,
> +				       const char *canonical_query, const char *ak, const char *sk)
> +{
> +	char date_header[40];
> +	const char *date_prefix = "Date: ";
> +	size_t date_prefix_len = strlen(date_prefix);
> +	char *sigv2_header;
> +
> +	memcpy(date_header, date_prefix, date_prefix_len);
> +	s3erofs_now_rfc1123(date_header + date_prefix_len, sizeof(date_header) - date_prefix_len);
> +
> +	sigv2_header = s3erofs_sigv2_header(*request_headers, method, NULL, NULL,
> +					    date_header + date_prefix_len, canonical_query, ak, sk);
> +	if (IS_ERR(sigv2_header))
> +		return PTR_ERR(sigv2_header);
> +
> +	*request_headers = curl_slist_append(*request_headers, date_header);
> +	*request_headers = curl_slist_append(*request_headers, sigv2_header);
> +
> +	free(sigv2_header);
> +	return 0;
> +}
> +
> +static int s3erofs_request_perform(struct erofs_s3 *s3cfg, struct s3erofs_curl_request *req,
> +				   struct s3erofs_curl_response *resp)
> +{
> +	struct curl_slist *request_headers = NULL;
> +	long http_code = 0;
> +	int ret;
> +
> +	ret = s3erofs_request_insert_auth(&request_headers, req->method, req->canonical_query,
> +					  s3cfg->access_key, s3cfg->secret_key);
> +	if (ret < 0) {
> +		erofs_err("failed to insert auth headers\n");
> +		return ret;
> +	}
> +
> +	curl_easy_setopt(easy_curl, CURLOPT_URL, req->url);
> +	curl_easy_setopt(easy_curl, CURLOPT_WRITEDATA, resp);
> +	curl_easy_setopt(easy_curl, CURLOPT_HTTPHEADER, request_headers);
> +
> +	ret = curl_easy_perform(easy_curl);
> +	if (ret != CURLE_OK) {
> +		erofs_err("curl_easy_perform() failed: %s\n", curl_easy_strerror(ret));
> +		ret = -EIO;
> +		goto err_header;
> +	}
> +
> +	ret = curl_easy_getinfo(easy_curl, CURLINFO_RESPONSE_CODE, &http_code);
> +	if (ret != CURLE_OK) {
> +		erofs_err("curl_easy_getinfo() failed: %s\n", curl_easy_strerror(ret));
> +		ret = -EIO;
> +		goto err_header;
> +	}
> +
> +	if (!(http_code >= 200 && http_code < 300)) {
> +		erofs_err("request failed with HTTP code %ld\n", http_code);
> +		ret = -EIO;
> +	}
> +
> +err_header:
> +	curl_slist_free_all(request_headers);
> +	return ret;
> +}
> +
> +struct s3erofs_object_info {
> +	char *key;
> +	u64 size;
> +};
> +
> +struct s3erofs_object_iterator {
> +	struct s3erofs_object_info *objects;
> +	int cur, total;
> +
> +	struct erofs_s3 *s3cfg;
> +	const char *prefix, *delimiter;
> +
> +	char *next_marker;
> +	bool is_truncated;
> +};
> +
> +static int s3erofs_parse_list_objects_one(xmlNodePtr node, struct s3erofs_object_info *info)
> +{
> +	xmlNodePtr child;
> +	xmlChar *str;
> +
> +	for (child = node->children; child; child = child->next) {
> +		if (child->type == XML_ELEMENT_NODE) {
> +			str = xmlNodeGetContent(child);
> +			if (!str) {
> +				return -ENOMEM;
> +			}
> +
> +			if (xmlStrEqual(child->name, (const xmlChar *)"Key")) {
> +				info->key = strdup((char *)str);
> +			} else if (xmlStrEqual(child->name, (const xmlChar *)"Size")) {
> +				info->size = atoll((char *)str);
> +			}
> +
> +			xmlFree(str);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int s3erofs_parse_list_objects_result(const char *data, int len,
> +					     struct s3erofs_object_iterator *it)
> +{
> +	xmlDocPtr doc = NULL;
> +	xmlNodePtr root = NULL, node;
> +	xmlChar *str;
> +	xmlNodePtr contents_nodes[1000];
> +	int contents_count = 0;
> +	int i = 0;
> +	int ret = 0;
> +	void *tmp;
> +
> +	doc = xmlReadMemory(data, len, NULL, NULL, 0);
> +	if (!doc) {
> +		erofs_err("failed to parse XML data\n");
> +		return -EINVAL;
> +	}
> +
> +	root = xmlDocGetRootElement(doc);
> +	if (!root) {
> +		erofs_err("failed to get root element\n");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (!xmlStrEqual(root->name, (const xmlChar *)"ListBucketResult")) {
> +		erofs_err("invalid root element: expected ListBucketResult, got %s", root->name);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	for (node = root->children; node; node = node->next) {
> +		if (node->type == XML_ELEMENT_NODE) {
> +			if (xmlStrEqual(node->name, (const xmlChar *)"Contents")) {
> +				if (contents_count < 1000)
> +					contents_nodes[contents_count++] = node;
> +			} else if (xmlStrEqual(node->name, (const xmlChar *)"IsTruncated")) {
> +				str = xmlNodeGetContent(node);
> +				if (str) {
> +					it->is_truncated =
> +					    xmlStrEqual(str, (const xmlChar *)"true") ? true
> +										      : false;
> +					xmlFree(str);
> +				}
> +			} else if (xmlStrEqual(node->name, (const xmlChar *)"NextMarker")) {
> +				str = xmlNodeGetContent(node);
> +				if (str) {
> +					if (it->next_marker)
> +						free(it->next_marker);
> +					it->next_marker = strdup((char *)str);
> +					if (!it->next_marker) {
> +						xmlFree(str);
> +						ret = -ENOMEM;
> +						goto out;
> +					}
> +					xmlFree(str);
> +				}
> +			}
> +		}
> +	}
> +
> +	if (contents_count == 0)
> +		goto out;
> +
> +	tmp = realloc(it->objects, contents_count * sizeof(struct s3erofs_object_info));
> +	if (!tmp) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	memset(tmp, 0, contents_count * sizeof(struct s3erofs_object_info));
> +	it->objects = tmp;
> +
> +	for (i = 0; i < contents_count; i++) {
> +		ret = s3erofs_parse_list_objects_one(contents_nodes[i], &it->objects[i]);
> +		if (ret < 0) {
> +			erofs_err("failed to parse contents node #%d", i);
> +			while (--i >= 0)
> +				free(it->objects[i].key);
> +			free(it->objects);
> +			goto out;
> +		}
> +	}
> +
> +	it->total = contents_count;
> +
> +out:
> +	xmlFreeDoc(doc);
> +	return ret;
> +}
> +
> +static int s3erofs_list_objects(struct s3erofs_object_iterator *it)
> +{
> +	struct s3erofs_curl_request req = {0};
> +	struct s3erofs_curl_response resp = {0};
> +	struct s3erofs_query_params params = {0};
> +	int ret = 0;
> +
> +	struct erofs_s3 *s3cfg = it->s3cfg;
> +
> +	if (it->prefix && strlen(it->prefix ) > 1024) {
> +		erofs_err("prefix is too long");
> +		return -EINVAL;
> +	}
> +
> +	if (it->delimiter && strlen(it->delimiter) > 1024) {
> +		erofs_err("delimiter is too long");
> +		return -EINVAL;
> +	}
> +
> +	if (it->prefix) {
> +		params.key[params.num] = "prefix";
> +		params.value[params.num] = it->prefix;
> +		++params.num;
> +	}
> +
> +	if (it->delimiter) {
> +		params.key[params.num] = "delimiter";
> +		params.value[params.num] = it->delimiter;
> +		++params.num;
> +	}
> +
> +	if (it->next_marker) {
> +		params.key[params.num] = "marker";
> +		params.value[params.num] = it->next_marker;
> +		++params.num;
> +	}
> +
> +	params.key[params.num] = "max-keys";
> +	params.value[params.num] = "1000";
> +	++params.num;
> +
> +	req.method = "GET";
> +	s3erofs_prepare_url(s3cfg->endpoint, s3cfg->bucket, NULL, &params, req.url,
> +				s3cfg->url_style);
> +	snprintf(req.canonical_query, S3EROFS_CANONICAL_QUERY_LEN, "/%s", s3cfg->bucket);
> +
> +	ret = s3erofs_request_perform(s3cfg, &req, &resp);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = s3erofs_parse_list_objects_result(resp.data, resp.size, it);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static struct s3erofs_object_iterator *
> +s3erofs_create_object_iterator(struct erofs_s3 *s3cfg, const char *prefix,
> +			       const char *delimiter)
> +{
> +	struct s3erofs_object_iterator *it = calloc(1, sizeof(*it));
> +
> +	it->s3cfg = s3cfg;
> +	it->prefix = prefix;
> +	it->delimiter = delimiter;
> +
> +	it->is_truncated = true;
> +
> +	return it;
> +}
> +
> +static void s3erofs_destroy_object_iterator(struct s3erofs_object_iterator *it)
> +{
> +	if (it->next_marker)
> +		free(it->next_marker);
> +	if (it->objects) {
> +		for (int i = 0; i < it->total; i++)
> +			free(it->objects[i].key);
> +		free(it->objects);
> +	}
> +
> +	free(it);
> +}
> +
> +static struct s3erofs_object_info *
> +s3erofs_get_next_object(struct s3erofs_object_iterator *it)
> +{
> +	int ret = 0;
> +
> +	if (it->cur < it->total) {
> +		return &it->objects[it->cur++];
> +	}
> +
> +	if (it->is_truncated) {
> +		ret = s3erofs_list_objects(it);
> +		if (ret < 0)
> +			return ERR_PTR(ret);
> +
> +		it->cur = 0;
> +		return &it->objects[it->cur++];
> +	}
> +
> +	return NULL;
> +}
> +
> +static int s3erofs_global_init(void)
> +{
> +	int ret;

Does it support multiple remotes?

Use a mutex to protect this for multiple instances?

> +
> +	ret = curl_global_init(CURL_GLOBAL_DEFAULT);
> +	if (ret != CURLE_OK)
> +		return -EIO;
> +
> +	easy_curl = curl_easy_init();
> +	if (!easy_curl) {
> +		curl_global_cleanup();
> +		return -EIO;
> +	}
> +
> +	curl_easy_setopt(easy_curl, CURLOPT_WRITEFUNCTION, s3erofs_request_write_memory_cb);
> +	curl_easy_setopt(easy_curl, CURLOPT_FOLLOWLOCATION, 1L);
> +	curl_easy_setopt(easy_curl, CURLOPT_TIMEOUT, 30L);
> +
> +	xmlInitParser();
> +
> +	return ret;
> +}
> +
> +static void s3erofs_global_exit(void)
> +{
> +	if (!easy_curl)
> +		return;
> +
> +	xmlCleanupParser();
> +
> +	curl_easy_cleanup(easy_curl);
> +	easy_curl = NULL;
> +
> +	curl_global_cleanup();
> +}
> +
> +int s3erofs_build_trees(struct erofs_inode *root, struct erofs_s3 *s3cfg)
> +{
> +	struct erofs_sb_info *sbi = root->sbi;
> +	struct s3erofs_object_iterator *iter;
> +	struct s3erofs_object_info *obj;
> +	struct erofs_dentry *d;
> +	struct erofs_inode *inode;
> +	struct stat st;
> +	bool dumb;
> +	int ret = 0;
> +
> +	st.st_uid = getuid();
> +	st.st_gid = getgid();
> +
> +	/* XXX */
> +	st.st_mtime = sbi->epoch;


	st.st_mtime = sbi->epoch + sbi->build_time?

build_time can be specified by users too.

Thanks,
Gao Xiang

