Return-Path: <linux-erofs+bounces-869-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88898B30EE8
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Aug 2025 08:27:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c7Vbq0pZgz3cR1;
	Fri, 22 Aug 2025 16:27:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.189
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755844055;
	cv=none; b=REPLoSM+6qpe+a8b07I2l+vJl/8G74DxqOl6bh3bftsgRGmqbXxYl4MqU3gwUGEslzQuq2DdRDUXLAUVi0hdSGK/D3cYUxJ9sbp2KZvIKj+OUj2Q/hl3rfFvnFVF/JTsdUEBsvcWhhvC3PSkCd1x+EZQhUqZF32lMuWoVWy5teRTRzpp783tiACZ0d3dyZlO6wO7xeKa/PHKXiiLQfCTYhL4Z3hFlu9Y+fkP0d05+gJlPdGr8H3iDULu+efZhcnhmq5/Acq56sAYXzVrO+LJ9v7VFkiOicsV0CHLbLeKcKy5ex1px3zHsTx7Gysy2ijLMohEORVMSZnlaC8ZJ7fcww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755844055; c=relaxed/relaxed;
	bh=uNlwzJWWyTwWpOahKbZG54FXBQgvkAWi5YRI13MiD+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mGbBy2coBkxZWWlLLieacrL2/5cFxQILPpDjWSoFVStv/wdqFw4oa4IL+5BvJknFJdzTgYiFrWQNhChG3040q44rNc1ox+BuZpOPdE5FtVZZ3N7TF37/XZoTybAVdPVpxzNACLzR3eSfvWEetveqKkVYc9/r23yS5Uu6BA4757zoHo06ZzaIEU5WEfvXl4zhytTCn1kq1NGLoxXkgLhyEhXS+uIQBpIXwjCRQOI9tMtm9oSzeBZ5DE/DOvePADX+GggH5d1G1Qr4VypymjOXXM+jq1VSBMBTf5KDYpIbCUg7f6dXuqwiShMuDWpi960X+2/ytgpk3GtBPIOs3DLZ6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.189; helo=szxga03-in.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.189; helo=szxga03-in.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c7Vbn0bXsz30MY
	for <linux-erofs@lists.ozlabs.org>; Fri, 22 Aug 2025 16:27:31 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4c7VVZ23F0zdcTR;
	Fri, 22 Aug 2025 14:23:02 +0800 (CST)
Received: from kwepemp500007.china.huawei.com (unknown [7.202.195.151])
	by mail.maildlp.com (Postfix) with ESMTPS id 1333C14027A;
	Fri, 22 Aug 2025 14:27:26 +0800 (CST)
Received: from [100.103.109.96] (100.103.109.96) by
 kwepemp500007.china.huawei.com (7.202.195.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 22 Aug 2025 14:27:25 +0800
Message-ID: <23118d4d-a0f1-4e70-a60a-0a0825b82ff9@huawei.com>
Date: Fri, 22 Aug 2025 14:27:24 +0800
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
Subject: Re: [PATCH v4] erofs-utils: add OCI registry support
To: ChengyuZhu6 <hudson@cyzhu.com>, <linux-erofs@lists.ozlabs.org>
CC: <xiang@kernel.org>, <hsiangkao@linux.alibaba.com>, Changzhi Xie
	<sa.z@qq.com>
References: <20250821073258.89073-1-hudson@cyzhu.com>
 <20250822060025.14787-1-hudson@cyzhu.com>
From: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
In-Reply-To: <20250822060025.14787-1-hudson@cyzhu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.103.109.96]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemp500007.china.huawei.com (7.202.195.151)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_FILL_THIS_FORM_SHORT autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org


On 2025/8/22 14:00, ChengyuZhu6 wrote:
> From: Chengyu Zhu <hudson@cyzhu.com>
>
> ...
> diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
> new file mode 100644
> index 0000000..13c2153
> --- /dev/null
> +++ b/lib/remotes/oci.c
> @@ -0,0 +1,835 @@
> +/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/*
> + * Copyright (C) 2025 Tencent, Inc.
> + *             http://www.tencent.com/
> + */
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <errno.h>
> +#include <curl/curl.h>
> +#include <json-c/json.h>
> +#include "erofs/internal.h"
> +#include "erofs/print.h"
> +#include "erofs/inode.h"
> +#include "erofs/blobchunk.h"
> +#include "erofs/diskbuf.h"
> +#include "erofs/rebuild.h"

Hi Chengyu,


It seems `inode.h` `blobchunk.h` `diskbuf.h` `rebuild.h` is redundant.
> +#include "erofs/tar.h"
> +#include "liberofs_oci.h"
> +
> +#define OCI_AUTH_HEADER_MAX_LEN 1024
> +
> +#define DOCKER_MEDIATYPE_MANIFEST_V2 \
> +	"application/vnd.docker.distribution.manifest.v2+json"
> +#define DOCKER_MEDIATYPE_MANIFEST_V1 \
> +	"application/vnd.docker.distribution.manifest.v1+json"
> +#define DOCKER_MEDIATYPE_MANIFEST_LIST \
> +	"application/vnd.docker.distribution.manifest.list.v2+json"
> +#define OCI_MEDIATYPE_MANIFEST "application/vnd.oci.image.manifest.v1+json"
> +#define OCI_MEDIATYPE_INDEX "application/vnd.oci.image.index.v1+json"
> +
> +#define DOCKER_REGISTRY "docker.io"
> +#define DOCKER_API_REGISTRY "registry-1.docker.io"
> +#define QUAY_REGISTRY "quay.io"
> +
> +struct erofs_oci_request {
> +	char *url;
> +	struct curl_slist *headers;
> +};
> +
> +struct erofs_oci_response {
> +	char *data;
> +	size_t size;
> +	long http_code;
> +};
> +
> +struct erofs_oci_stream {
> +	struct erofs_tarfile tarfile;
> +	int temp_fd;
> +	int layer_index;
> +};
> +
> +/* Callback for writing response data to memory */
> +static size_t ocierofs_write_callback(void *contents, size_t size,
> +				      size_t nmemb, void *userp)
> +{
> +	size_t realsize = size * nmemb;
> +	struct erofs_oci_response *resp = userp;
> +	char *ptr;
> +
> +	if (!resp || !contents)
> +		return 0;
> +
> +	ptr = realloc(resp->data, resp->size + realsize + 1);
> +	if (!ptr) {
> +		erofs_err("failed to allocate memory for response data");
> +		return 0;
> +	}
> +
> +	resp->data = ptr;
> +	memcpy(&resp->data[resp->size], contents, realsize);
> +	resp->size += realsize;
> +	resp->data[resp->size] = '\0';
> +	return realsize;
> +}
> +
> +/* Callback for writing layer data to file */
> +static size_t ocierofs_layer_write_callback(void *contents, size_t size,
> +					     size_t nmemb, void *userp)
> +{
> +	struct erofs_oci_stream *stream = userp;
> +	size_t realsize = size * nmemb;
> +
> +	if (stream->temp_fd < 0)
> +		return 0;
> +
> +	if (write(stream->temp_fd, contents, realsize) != realsize) {
> +		erofs_err("failed to write layer data for layer %d",
> +			  stream->layer_index);
> +		return 0;
> +	}
> +
> +	return realsize;
> +}
> +
> +static int ocierofs_curl_setup_common_options(CURL *curl)
> +{
> +	curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L);
> +	curl_easy_setopt(curl, CURLOPT_CONNECTTIMEOUT, 30L);
> +	curl_easy_setopt(curl, CURLOPT_TIMEOUT, 120L);
> +	curl_easy_setopt(curl, CURLOPT_NOSIGNAL, 1L);
> +	curl_easy_setopt(curl, CURLOPT_USERAGENT, "ocierofs/" PACKAGE_VERSION);
> +
> +	return 0;
> +}
> +
> +static int ocierofs_curl_setup_basic_auth(CURL *curl, const char *username,
> +					   const char *password)
> +{
> +	char *userpwd = NULL;
> +
> +	if (asprintf(&userpwd, "%s:%s", username, password) == -1)
> +		return -ENOMEM;
> +
> +	curl_easy_setopt(curl, CURLOPT_USERPWD, userpwd);
> +	curl_easy_setopt(curl, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
> +
> +	free(userpwd);
> +	return 0;
> +}
> +
> +static int ocierofs_curl_clear_auth(CURL *curl)
> +{
> +	curl_easy_setopt(curl, CURLOPT_USERPWD, NULL);
> +	curl_easy_setopt(curl, CURLOPT_HTTPAUTH, CURLAUTH_NONE);
> +
> +	return 0;
> +}
> +
> +static int ocierofs_curl_setup_request(CURL *curl, const char *url,
> +		size_t (*write_func)(void *, size_t, size_t, void *),
> +		void *write_data, struct curl_slist *headers)
> +{
> +	curl_easy_setopt(curl, CURLOPT_URL, url);
> +	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_func);
> +	curl_easy_setopt(curl, CURLOPT_WRITEDATA, write_data);
> +
> +	if (headers)
> +		curl_easy_setopt(curl, CURLOPT_HTTPHEADER, headers);
> +
> +	return 0;
> +}
> +
> +static int ocierofs_request_perform(struct erofs_oci *oci,
> +			       struct erofs_oci_request *req,
> +			       struct erofs_oci_response *resp)
> +{
> +	CURLcode res;
> +	int ret;
> +
> +	ret = ocierofs_curl_setup_request(oci->curl, req->url,
> +					  ocierofs_write_callback, resp,
> +					  req->headers);
> +	if (ret)
> +		return ret;
> +
> +	res = curl_easy_perform(oci->curl);
> +	if (res != CURLE_OK) {
> +		erofs_err("curl request failed: %s", curl_easy_strerror(res));
> +		return -EIO;
> +	}
> +
> +	res = curl_easy_getinfo(oci->curl, CURLINFO_RESPONSE_CODE,
> +				&resp->http_code);
> +	if (res != CURLE_OK) {
> +		erofs_err("failed to get HTTP response code: %s",
> +			  curl_easy_strerror(res));
> +		return -EIO;
> +	}
> +
> +	if (resp->http_code < 200 || resp->http_code >= 300) {
> +		erofs_err("HTTP request failed with code %ld",
> +			  resp->http_code);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static char *ocierofs_get_auth_token(struct erofs_oci *oci, const char *registry,
> +				const char *repository, const char *username,
> +				const char *password)
> +{
> +	struct erofs_oci_request req = {};
> +	struct erofs_oci_response resp = {};
> +	json_object *root, *token_obj;
> +	const char *token;
> +	char *auth_header = NULL;
> +	int ret;
> +
> +	if (!registry || !repository)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (!strcmp(registry, DOCKER_API_REGISTRY) ||
> +	    !strcmp(registry, DOCKER_REGISTRY)) {
> +		if (asprintf(&req.url,
> +			     "https://auth.docker.io/token?service="
> +			     "registry.docker.io&scope=repository:%s:pull",
> +			     repository) == -1) {
> +			return ERR_PTR(-ENOMEM);
> +		}
> +	} else if (!strcmp(registry, QUAY_REGISTRY)) {
> +		if (asprintf(&req.url,
> +			     "https://%s/v2/auth?service=%s&scope="
> +			     "repository:%s:pull",
> +			     QUAY_REGISTRY, QUAY_REGISTRY, repository) == -1) {
> +			return ERR_PTR(-ENOMEM);
> +		}
> +	} else {
> +		if (asprintf(&req.url,
> +			     "https://%s/token?service=%s&scope="
> +			     "repository:%s:pull",
> +			     registry, registry, repository) == -1) {
> +			return ERR_PTR(-ENOMEM);
> +		}
> +	}
> +
> +	if (username && password && *username) {
> +		ret = ocierofs_curl_setup_basic_auth(oci->curl, username,
> +						      password);
> +		if (ret)
> +			goto out_url;
> +	}
> +
> +	ret = ocierofs_request_perform(oci, &req, &resp);
> +
> +	ocierofs_curl_clear_auth(oci->curl);
> +
> +	if (ret)
> +		goto out_url;
> +
> +	if (!resp.data) {
> +		erofs_err("empty response from auth server");
> +		ret = -EINVAL;
> +		goto out_url;
> +	}
> +
> +	root = json_tokener_parse(resp.data);
> +	if (!root) {
> +		erofs_err("failed to parse auth response");
> +		ret = -EINVAL;
> +		goto out_url;
> +	}
> +
> +	if (!json_object_object_get_ex(root, "token", &token_obj)) {
> +		erofs_err("no token found in auth response");
> +		ret = -EINVAL;
> +		goto out_json;
> +	}
> +
> +	token = json_object_get_string(token_obj);
> +	if (!token) {
> +		erofs_err("invalid token in auth response");
> +		ret = -EINVAL;
> +		goto out_json;
> +	}
> +
> +	if (asprintf(&auth_header, "Authorization: Bearer %s", token) == -1) {
> +		ret = -ENOMEM;
> +		goto out_json;
> +	}
> +
> +out_json:
> +	json_object_put(root);
> +out_url:
> +	free(req.url);
> +	free(resp.data);
> +	return ret ? ERR_PTR(ret) : auth_header;
> +}
> +
> +static char *ocierofs_get_manifest_digest(struct erofs_oci *oci,
> +				     const char *registry,
> +				     const char *repository, const char *tag,
> +				     const char *platform,
> +				     const char *auth_header)
> +{
> +	struct erofs_oci_request req = {};
> +	struct erofs_oci_response resp = {};
> +	json_object *root, *manifests, *manifest, *platform_obj, *arch_obj;
> +	json_object *os_obj, *digest_obj, *schema_obj, *media_type_obj;
> +	char *digest = NULL;
> +	const char *api_registry;
> +	int ret, len, i;
> +
> +	if (!registry || !repository || !tag || !platform)
> +		return ERR_PTR(-EINVAL);
> +
> +	memset(&resp, 0, sizeof(resp));
> +
> +	api_registry = (!strcmp(registry, DOCKER_REGISTRY)) ?
> +		       DOCKER_API_REGISTRY : registry;
> +
> +	if (asprintf(&req.url, "https://%s/v2/%s/manifests/%s",
> +		     api_registry, repository, tag) == -1) {
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	if (auth_header && strstr(auth_header, "Bearer"))
> +		req.headers = curl_slist_append(req.headers, auth_header);
> +
> +	req.headers = curl_slist_append(req.headers,
> +		"Accept: " DOCKER_MEDIATYPE_MANIFEST_LIST ","
> +		OCI_MEDIATYPE_INDEX "," DOCKER_MEDIATYPE_MANIFEST_V1 ","
> +		DOCKER_MEDIATYPE_MANIFEST_V2);
> +
> +	ret = ocierofs_request_perform(oci, &req, &resp);
> +	if (ret)
> +		goto out;
> +
> +	if (!resp.data) {
> +		erofs_err("empty response from manifest request");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	root = json_tokener_parse(resp.data);
> +	if (!root) {
> +		erofs_err("failed to parse manifest JSON");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (json_object_object_get_ex(root, "schemaVersion", &schema_obj)) {
> +		if (json_object_get_int(schema_obj) == 1) {
> +			digest = strdup(tag);
> +			goto out_json;
> +		}
> +	}
> +
> +	if (json_object_object_get_ex(root, "mediaType", &media_type_obj)) {
> +		const char *media_type = json_object_get_string(media_type_obj);
> +
> +		if (!strcmp(media_type, DOCKER_MEDIATYPE_MANIFEST_V2) ||
> +		    !strcmp(media_type, OCI_MEDIATYPE_MANIFEST)) {
> +			digest = strdup(tag);
> +			goto out_json;
> +		}
> +	}
> +
> +	if (!json_object_object_get_ex(root, "manifests", &manifests)) {
> +		erofs_err("no manifests found in manifest list");
> +		ret = -EINVAL;
> +		goto out_json;
> +	}
> +
> +	len = json_object_array_length(manifests);
> +	for (i = 0; i < len; i++) {
> +		manifest = json_object_array_get_idx(manifests, i);
> +
> +		if (json_object_object_get_ex(manifest, "platform",
> +					      &platform_obj) &&
> +		    json_object_object_get_ex(platform_obj, "architecture",
> +					      &arch_obj) &&
> +		    json_object_object_get_ex(platform_obj, "os", &os_obj) &&
> +		    json_object_object_get_ex(manifest, "digest", &digest_obj)) {
> +			const char *arch = json_object_get_string(arch_obj);
> +			const char *os = json_object_get_string(os_obj);
> +			char manifest_platform[64];
> +
> +			snprintf(manifest_platform, sizeof(manifest_platform),
> +				 "%s/%s", os, arch);
> +			if (!strcmp(manifest_platform, platform)) {
> +				digest = strdup(json_object_get_string(digest_obj));
> +				break;
> +			}
> +		}
> +	}
> +
> +	if (!digest)
> +		ret = -ENOENT;
> +
> +out_json:
> +	json_object_put(root);
> +out:
> +	free(resp.data);
> +	if (req.headers)
> +		curl_slist_free_all(req.headers);
> +	free(req.url);
> +
> +	return ret ? ERR_PTR(ret) : digest;
> +}
> +
> +static char **ocierofs_get_layers_info(struct erofs_oci *oci,
> +				  const char *registry,
> +				  const char *repository,
> +				  const char *digest,
> +				  const char *auth_header,
> +				  int *layer_count)
> +{
> +	struct erofs_oci_request req = {};
> +	struct erofs_oci_response resp = {};
> +	json_object *root, *layers, *layer, *digest_obj;
> +	char **layers_info = NULL;
> +	const char *api_registry;
> +	int ret, len, i;
> +
> +	if (!registry || !repository || !digest || !layer_count)
> +		return ERR_PTR(-EINVAL);
> +
> +	*layer_count = 0;
> +	memset(&resp, 0, sizeof(resp));
> +	api_registry = (!strcmp(registry, DOCKER_REGISTRY)) ?
> +		       DOCKER_API_REGISTRY : registry;
> +
> +	if (asprintf(&req.url, "https://%s/v2/%s/manifests/%s",
> +		     api_registry, repository, digest) == -1) {
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	if (auth_header && strstr(auth_header, "Bearer"))
> +		req.headers = curl_slist_append(req.headers, auth_header);
> +
> +	req.headers = curl_slist_append(req.headers,
> +		"Accept: " OCI_MEDIATYPE_MANIFEST "," DOCKER_MEDIATYPE_MANIFEST_V2);
> +
> +	ret = ocierofs_request_perform(oci, &req, &resp);
> +	if (ret)
> +		goto out;
> +
> +	if (!resp.data) {
> +		erofs_err("empty response from layers request");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	root = json_tokener_parse(resp.data);
> +	if (!root) {
> +		erofs_err("failed to parse manifest JSON");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (!json_object_object_get_ex(root, "layers", &layers) ||
> +	    json_object_get_type(layers) != json_type_array) {
> +		erofs_err("no layers found in manifest");
> +		ret = -EINVAL;
> +		goto out_json;
> +	}
> +
> +	len = json_object_array_length(layers);
> +	if (len == 0) {
> +		erofs_err("empty layer list in manifest");
> +		ret = -EINVAL;
> +		goto out_json;
> +	}
> +
> +	layers_info = calloc(len, sizeof(char *));
> +	if (!layers_info) {
> +		ret = -ENOMEM;
> +		goto out_json;
> +	}
> +
> +	for (i = 0; i < len; i++) {
> +		layer = json_object_array_get_idx(layers, i);
> +
> +		if (!json_object_object_get_ex(layer, "digest", &digest_obj)) {
> +			erofs_err("failed to parse layer %d", i);
> +			ret = -EINVAL;
> +			goto out_free;
> +		}
> +
> +		layers_info[i] = strdup(json_object_get_string(digest_obj));
> +		if (!layers_info[i]) {
> +			ret = -ENOMEM;
> +			goto out_free;
> +		}
> +	}
> +
> +	*layer_count = len;
> +	json_object_put(root);
> +	free(resp.data);
> +	if (req.headers)
> +		curl_slist_free_all(req.headers);
> +	free(req.url);
> +	return layers_info;
> +
> +out_free:
> +	if (layers_info) {
> +		for (int j = 0; j < i; j++)
> +			free(layers_info[j]);
> +	}
> +	free(layers_info);
> +out_json:
> +	json_object_put(root);
> +out:
> +	free(resp.data);
> +	if (req.headers)
> +		curl_slist_free_all(req.headers);
> +	free(req.url);
> +	return ERR_PTR(ret);
> +}
> +
> +static int ocierofs_extract_layer(struct erofs_oci *oci, struct erofs_inode *root,
> +			     const char *layer_digest, const char *auth_header,
> +			     int layer_index)
> +{
> +	struct erofs_oci_request req = {};
> +	struct erofs_oci_stream stream = {};
> +	const char *api_registry;
> +	int ret, fd = -1;
> +	long http_code;
> +
> +	if (!oci || !root || !layer_digest || layer_index < 0) {
> +		erofs_err("invalid parameters for layer extraction");
> +		return -EINVAL;
> +	}
> +
> +	memset(&stream, 0, sizeof(stream));
> +	stream.layer_index = layer_index;
> +
> +	stream.temp_fd = erofs_tmpfile();

referencing `erofs_tmpfile` triggers a compiler warning, but will not cause

an runtime error because it happens have the signature `int(void)`.

Do you forget to include "liberofs_private.h"?

> +	if (stream.temp_fd < 0) {
> +		erofs_err("failed to create temporary file for layer %d",
> +			  layer_index);
> +		return -errno;
> +	}
> +
> +	api_registry = (!strcmp(oci->params.registry, DOCKER_REGISTRY)) ?
> +		       DOCKER_API_REGISTRY : oci->params.registry;
> +
> +	if (asprintf(&req.url, "https://%s/v2/%s/blobs/%s",
> +		     api_registry, oci->params.repository,
> +		     layer_digest) == -1) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	if (auth_header && strstr(auth_header, "Bearer"))
> +		req.headers = curl_slist_append(req.headers, auth_header);
> +
> +	curl_easy_reset(oci->curl);
> +
> +	ret = ocierofs_curl_setup_common_options(oci->curl);
> +	if (ret)
> +		goto out;
> +
> +	ret = ocierofs_curl_setup_request(oci->curl, req.url,
> +					  ocierofs_layer_write_callback,
> +					  &stream, req.headers);
> +	if (ret)
> +		goto out;
> +
> +	ret = curl_easy_perform(oci->curl);
> +
> +	if (ret != CURLE_OK) {
> +		erofs_err("failed to download layer: %s",
> +			  curl_easy_strerror(ret));
> +		ret = -EIO;
> +		goto out;
> +	}
> +
> +	curl_easy_getinfo(oci->curl, CURLINFO_RESPONSE_CODE, &http_code);
> +	if (http_code < 200 || http_code >= 300) {
> +		erofs_err("HTTP request failed with code %ld", http_code);
> +		ret = -EIO;
> +		goto out;
> +	}
> +
> +	if (lseek(stream.temp_fd, 0, SEEK_SET) < 0) {
> +		erofs_err("failed to seek to beginning of temp file: %s",
> +			  strerror(errno));
> +		ret = -errno;
> +		goto out;
> +	}
> +
> +	fd = dup(stream.temp_fd);
> +	if (fd < 0) {
> +		erofs_err("failed to duplicate temp file descriptor: %s",
> +			  strerror(errno));
> +		ret = -errno;
> +		goto out;
> +	}
> +
> +	memset(&stream.tarfile, 0, sizeof(stream.tarfile));
> +	init_list_head(&stream.tarfile.global.xattrs);
> +
> +	ret = erofs_iostream_open(&stream.tarfile.ios, fd,
> +				  EROFS_IOS_DECODER_GZIP);
> +	if (ret) {
> +		erofs_err("failed to initialize tar stream: %s",
> +			  erofs_strerror(ret));
> +		goto out;
> +	}
> +
> +	while (!(ret = tarerofs_parse_tar(root, &stream.tarfile))) {
> +		/* Continue parsing until end of archive */
> +	}
> +
> +	erofs_iostream_close(&stream.tarfile.ios);
> +
> +	if (ret < 0 && ret != -ENODATA) {
> +		erofs_err("failed to process tar stream: %s",
> +			  erofs_strerror(ret));
> +		goto out;
> +	}
> +
> +	ret = 0;
> +
> +out:
> +	if (fd >= 0)
> +		close(fd);
> +
> +	if (stream.temp_fd >= 0)
> +		close(stream.temp_fd);
> +
> +	if (req.headers)
> +		curl_slist_free_all(req.headers);
> +
> +	free(req.url);
> +
> +	return ret;
> +}
> +
> +int ocierofs_build_trees(struct erofs_inode *root, struct erofs_oci *oci,
> +			 bool fillzero)
> +{
> +	char *auth_header = NULL;
> +	char *manifest_digest = NULL;
> +	char **layers_info = NULL;
> +	int layer_count = 0;
> +	int ret, i;
> +
> +	if (!root || !oci)
> +		return -EINVAL;
> +
> +	if (oci->params.auth_mode != OCI_AUTH_ANONYMOUS) {
> +		if (oci->params.auth_mode == OCI_AUTH_BASIC &&
> +		    oci->params.username && oci->params.password &&
> +		    oci->params.username[0] && oci->params.password[0]) {
> +			auth_header = ocierofs_get_auth_token(oci,
> +							 oci->params.registry,
> +							 oci->params.repository,
> +							 oci->params.username,
> +							 oci->params.password);
> +			if (IS_ERR(auth_header)) {
> +				auth_header = NULL;
> +				ret = ocierofs_curl_setup_basic_auth(oci->curl,
> +						oci->params.username,
> +						oci->params.password);
> +				if (ret)
> +					goto out;
> +			}
> +		} else if (oci->params.auth_mode == OCI_AUTH_TOKEN) {
> +			auth_header = ocierofs_get_auth_token(oci,
> +							 oci->params.registry,
> +							 oci->params.repository,
> +							 NULL, NULL);
> +			if (IS_ERR(auth_header)) {
> +				ret = PTR_ERR(auth_header);
> +				erofs_err("failed to get auth token: %s",
> +					  erofs_strerror(ret));
> +				goto out;
> +			}
> +		}
> +	}
> +
> +	manifest_digest = ocierofs_get_manifest_digest(oci, oci->params.registry,
> +						  oci->params.repository,
> +						  oci->params.tag,
> +						  oci->params.platform,
> +						  auth_header);
> +	if (IS_ERR(manifest_digest)) {
> +		ret = PTR_ERR(manifest_digest);
> +		erofs_err("failed to get manifest digest: %s",
> +			  erofs_strerror(ret));
> +		goto out_auth;
> +	}
> +
> +	layers_info = ocierofs_get_layers_info(oci, oci->params.registry,
> +					  oci->params.repository,
> +					  manifest_digest, auth_header,
> +					  &layer_count);
> +	if (IS_ERR(layers_info)) {
> +		ret = PTR_ERR(layers_info);
> +		erofs_err("failed to get layers info: %s",
> +			  erofs_strerror(ret));
> +		goto out_manifest;
> +	}
> +
> +	if (oci->params.layer_index >= 0) {
> +		char *trimmed;
> +
> +		if (oci->params.layer_index >= layer_count) {
> +			erofs_err("layer index %d exceeds available layers (%d)",
> +				  oci->params.layer_index, layer_count);
> +			ret = -EINVAL;
> +			goto out_layers;
> +		}
> +
> +		i = oci->params.layer_index;
> +		trimmed = erofs_trim_for_progressinfo(layers_info[i],
> +				sizeof("Extracting layer  ...") - 1);
> +		erofs_update_progressinfo("Extracting layer %d: %s ...", i,
> +					  trimmed);
> +		free(trimmed);
> +
> +		if (!fillzero) {
> +			ret = ocierofs_extract_layer(oci, root, layers_info[i],
> +						auth_header, i);
> +			if (ret) {
> +				erofs_err("failed to extract layer %d: %s", i,
> +					  erofs_strerror(ret));
> +				goto out_layers;
> +			}
> +		}
> +	} else {
> +		for (i = 0; i < layer_count; i++) {
> +			char *trimmed = erofs_trim_for_progressinfo(layers_info[i],
> +					sizeof("Extracting layer  ...") - 1);
> +			erofs_update_progressinfo("Extracting layer %s ...",
> +						  trimmed);
> +			free(trimmed);
> +
> +			if (fillzero)
> +				continue;
> +
> +			ret = ocierofs_extract_layer(oci, root, layers_info[i],
> +						auth_header, i);
> +			if (ret) {
> +				erofs_err("failed to extract layer %d: %s", i,
> +					  erofs_strerror(ret));
> +				goto out_layers;
> +			}
> +		}
> +	}
> +
> +	ret = 0;
> +
> +out_layers:
> +	for (i = 0; i < layer_count; i++)
> +		free(layers_info[i]);
> +	free(layers_info);
> +out_manifest:
> +	free(manifest_digest);
> +out_auth:
> +	free(auth_header);
> +
> +	if (oci->params.username && oci->params.password &&
> +	    oci->params.username[0] && oci->params.password[0] &&
> +	    !auth_header) {
> +		ocierofs_curl_clear_auth(oci->curl);
> +	}
> +
> +out:
> +	return ret;
> +}
> +
> +int ocierofs_init(struct erofs_oci *oci)
> +{
> +	if (!oci)
> +		return -EINVAL;
> +
> +	memset(oci, 0, sizeof(*oci));
> +
> +	if (curl_global_init(CURL_GLOBAL_DEFAULT) != CURLE_OK)
> +		return -EIO;
> +
> +	oci->curl = curl_easy_init();
> +	if (!oci->curl) {
> +		curl_global_cleanup();
> +		return -EIO;
> +	}
> +
> +	if (ocierofs_curl_setup_common_options(oci->curl)) {
> +		ocierofs_cleanup(oci);
> +		return -EIO;
> +	}
> +
> +	if (erofs_oci_params_set_string(&oci->params.platform,
> +					"linux/amd64") ||
> +	    erofs_oci_params_set_string(&oci->params.registry,
> +					"registry-1.docker.io") ||
> +	    erofs_oci_params_set_string(&oci->params.tag, "latest")) {
> +		ocierofs_cleanup(oci);
> +		return -ENOMEM;
> +	}
> +
> +	oci->params.layer_index = -1; /* -1 means extract all layers */
> +	oci->params.auth_mode = OCI_AUTH_TOKEN;
> +
> +	return 0;
> +}
> +
> +void ocierofs_cleanup(struct erofs_oci *oci)
> +{
> +	if (!oci)
> +		return;
> +
> +	if (oci->curl) {
> +		curl_easy_cleanup(oci->curl);
> +		oci->curl = NULL;
> +	}
> +	curl_global_cleanup();
> +
> +	free(oci->params.registry);
> +	free(oci->params.repository);
> +	free(oci->params.tag);
> +	free(oci->params.platform);
> +	free(oci->params.username);
> +	free(oci->params.password);
> +
> +	oci->params.registry = NULL;
> +	oci->params.repository = NULL;
> +	oci->params.tag = NULL;
> +	oci->params.platform = NULL;
> +	oci->params.username = NULL;
> +	oci->params.password = NULL;
> +}
> +
> +int erofs_oci_params_set_string(char **field, const char *value)
> +{
> +	char *new_value;
> +
> +	if (!field)
> +		return -EINVAL;
> +
> +	if (!value) {
> +		free(*field);
> +		*field = NULL;
> +		return 0;
> +	}
> +
> +	new_value = strdup(value);
> +	if (!new_value)
> +		return -ENOMEM;
> +
> +	free(*field);
> +	*field = new_value;
> +	return 0;
> +}
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 804d483..777e91a 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -32,6 +32,7 @@
>   #include "../lib/liberofs_uuid.h"
>   #include "../lib/liberofs_metabox.h"
>   #include "../lib/liberofs_s3.h"
> +#include "../lib/liberofs_oci.h"
>   #include "../lib/compressor.h"
>   
>   static struct option long_options[] = {
> @@ -95,6 +96,9 @@ static struct option long_options[] = {
>   	{"vmdk-desc", required_argument, NULL, 532},
>   #ifdef S3EROFS_ENABLED
>   	{"s3", required_argument, NULL, 533},
> +#endif
> +#ifdef OCIEROFS_ENABLED
> +	{"oci", required_argument, NULL, 534},
>   #endif
>   	{0, 0, 0, 0},
>   };
> @@ -206,6 +210,14 @@ static void usage(int argc, char **argv)
>   		"   [,passwd_file=Y]    X=endpoint, Y=s3fs-compatible password file\n"
>   		"   [,urlstyle=Z]       S3 API calling style (Z = vhost|path) (default: vhost)\n"
>   		"   [,sig=<2,4>]        S3 API signature version (default: 2)\n"
> +#endif
> +#ifdef OCIEROFS_ENABLED
> +		" --oci=X               generate an image from OCI-compatible registry\n"
> +		"   [,platform=Y]       X=registry/repo:tag, Y=platform (default: linux/amd64)\n"
> +		"   [,layer=Z]          Z=layer index to extract (default: 0)\n"
> +		"   [,anonymous]        use anonymous access (no authentication)\n"
> +		"   [,username=U]       U=username for basic authentication\n"
> +		"   [,password=P]       P=password for basic authentication\n"
>   #endif
>   		" --tar=X               generate a full or index-only image from a tarball(-ish) source\n"
>   		"                       (X = f|i|headerball; f=full mode, i=index mode,\n"
> @@ -261,6 +273,10 @@ static u8 metabox_algorithmid;
>   static struct erofs_s3 s3cfg;
>   #endif
>   
> +#ifdef OCIEROFS_ENABLED
> +static struct erofs_oci ocicfg;
> +#endif
> +
>   enum {
>   	EROFS_MKFS_DATA_IMPORT_DEFAULT,
>   	EROFS_MKFS_DATA_IMPORT_FULLDATA,
> @@ -272,6 +288,7 @@ static enum {
>   	EROFS_MKFS_SOURCE_LOCALDIR,
>   	EROFS_MKFS_SOURCE_TAR,
>   	EROFS_MKFS_SOURCE_S3,
> +	EROFS_MKFS_SOURCE_OCI,
>   	EROFS_MKFS_SOURCE_REBUILD,
>   } source_mode;
>   
> @@ -668,6 +685,146 @@ static int mkfs_parse_s3_cfg(char *cfg_str)
>   }
>   #endif
>   
> +#ifdef OCIEROFS_ENABLED
> +static int mkfs_parse_oci_cfg(char *cfg_str)
> +{
> +	char *p, *q, *opt, *ref_str;
> +	char *slash, *colon, *dot;
> +	const char *repo_part;
> +	size_t len;
> +
> +	if (source_mode != EROFS_MKFS_SOURCE_LOCALDIR)
> +		return -EINVAL;
> +	source_mode = EROFS_MKFS_SOURCE_OCI;
> +
> +	if (!cfg_str) {
> +		erofs_err("oci: missing parameter");
> +		return -EINVAL;
> +	}
> +
> +	ocierofs_init(&ocicfg);
> +
> +	p = strchr(cfg_str, ',');
> +	ref_str = p ? strndup(cfg_str, p - cfg_str) : strdup(cfg_str);
> +	if (!ref_str)
> +		return -ENOMEM;
> +
> +	slash = strchr(ref_str, '/');
> +	if (slash) {
> +		dot = strchr(ref_str, '.');
> +		if (dot && dot < slash) {
> +			char *registry_str;
> +
> +			len = slash - ref_str;
> +			registry_str = strndup(ref_str, len);
> +
> +			if (!registry_str) {
> +				erofs_err("failed to allocate memory for registry");
> +				goto err_free;
> +			}
> +			if (erofs_oci_params_set_string(&ocicfg.params.registry,
> +							registry_str)) {
> +				free(registry_str);
> +				erofs_err("failed to set registry");
> +				goto err_free;
> +			}
> +			free(registry_str);
> +			repo_part = slash + 1;
> +		} else {
> +			repo_part = ref_str;
> +		}
> +	} else {
> +		repo_part = ref_str;
> +	}
> +
> +	colon = strchr(repo_part, ':');
> +	if (colon) {
> +		char *repo_str;
> +
> +		len = colon - repo_part;
> +		repo_str = strndup(repo_part, len);
> +
> +		if (!repo_str) {
> +			erofs_err("failed to allocate memory for repository");
> +			goto err_free;
> +		}
> +		if (erofs_oci_params_set_string(&ocicfg.params.repository,
> +						repo_str)) {
> +			free(repo_str);
> +			erofs_err("failed to set repository");
> +			goto err_free;
> +		}
> +		free(repo_str);
> +
> +		if (erofs_oci_params_set_string(&ocicfg.params.tag,
> +						colon + 1)) {
> +			erofs_err("failed to set tag");
> +			goto err_free;
> +		}
> +	} else {
> +		if (erofs_oci_params_set_string(&ocicfg.params.repository,
> +						repo_part)) {
> +			erofs_err("failed to set repository");
> +			goto err_free;
> +		}
> +	}
> +
> +	free(ref_str);
> +
> +	if (!p)
> +		return 0;
> +
> +	opt = p + 1;
> +	while (opt) {
> +		q = strchr(opt, ',');
> +		if (q)
> +			*q = '\0';
> +
> +		if ((p = strstr(opt, "platform="))) {
> +			if (erofs_oci_params_set_string(&ocicfg.params.platform,
> +							p + 9)) {
> +				erofs_err("failed to set platform");
> +				return -ENOMEM;
> +			}
> +		} else if ((p = strstr(opt, "layer="))) {
> +			ocicfg.params.layer_index = atoi(p + 6);
> +			if (ocicfg.params.layer_index < 0) {
> +				erofs_err("invalid layer index %d",
> +					  ocicfg.params.layer_index);
> +				return -EINVAL;
> +			}
> +		} else if (!strcmp(opt, "anonymous")) {
> +			ocicfg.params.auth_mode = OCI_AUTH_ANONYMOUS;
> +		} else if ((p = strstr(opt, "username="))) {
> +			if (erofs_oci_params_set_string(&ocicfg.params.username,
> +							p + 9)) {
> +				erofs_err("failed to set username");
> +				return -ENOMEM;
> +			}
> +			ocicfg.params.auth_mode = OCI_AUTH_BASIC;
> +		} else if ((p = strstr(opt, "password="))) {
> +			if (erofs_oci_params_set_string(&ocicfg.params.password,
> +							p + 9)) {
> +				erofs_err("failed to set password");
> +				return -ENOMEM;
> +			}
> +			ocicfg.params.auth_mode = OCI_AUTH_BASIC;
> +		} else {
> +			erofs_err("invalid --oci option %s", opt);
> +			return -EINVAL;
> +		}
> +
> +		opt = q ? q + 1 : NULL;
> +	}
> +
> +	return 0;
> +
> +err_free:
> +	free(ref_str);
> +	return -EINVAL;
> +}
> +#endif
> +
>   static int mkfs_parse_one_compress_alg(char *alg,
>   				       struct erofs_compr_opts *copts)
>   {
> @@ -822,6 +979,13 @@ static int mkfs_parse_sources(int argc, char *argv[], int optind)
>   		if (!cfg.c_src_path)
>   			return -ENOMEM;
>   		break;
> +#endif
> +#ifdef OCIEROFS_ENABLED
> +	case EROFS_MKFS_SOURCE_OCI:
> +		cfg.c_src_path = strdup(argv[optind++]);
> +		if (!cfg.c_src_path)
> +			return -ENOMEM;
> +		break;

Could we reuse the code of case EROFS_MKFS_SOURCE_OCI and 
EROFS_MKFS_SOURCE_S3 here?

>   #endif
>   	default:
>   		erofs_err("unexpected source_mode: %d", source_mode);
> @@ -1219,6 +1383,13 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>   			if (err)
>   				return err;
>   			break;
> +#endif
> +#ifdef OCIEROFS_ENABLED
> +		case 534:
> +			err = mkfs_parse_oci_cfg(optarg);
> +			if (err)
> +				return err;
> +			break;
>   #endif
>   		case 'V':
>   			version();
> @@ -1638,7 +1809,8 @@ int main(int argc, char **argv)
>   		erofs_uuid_generate(g_sbi.uuid);
>   
>   	if ((source_mode == EROFS_MKFS_SOURCE_TAR && !erofstar.index_mode) ||
> -	    (source_mode == EROFS_MKFS_SOURCE_S3)) {
> +	    (source_mode == EROFS_MKFS_SOURCE_S3) ||
> +	    (source_mode == EROFS_MKFS_SOURCE_OCI)) {
>   		err = erofs_diskbuf_init(1);
>   		if (err) {
>   			erofs_err("failed to initialize diskbuf: %s",
> @@ -1756,12 +1928,25 @@ int main(int argc, char **argv)
>   					dataimport_mode == EROFS_MKFS_DATA_IMPORT_ZEROFILL);
>   			if (err)
>   				goto exit;
> +#endif
> +#ifdef OCIEROFS_ENABLED
> +		} else if (source_mode == EROFS_MKFS_SOURCE_OCI) {
> +			if (incremental_mode ||
> +			    dataimport_mode == EROFS_MKFS_DATA_IMPORT_RVSP)
> +				err = -EOPNOTSUPP;
> +			else
> +				err = ocierofs_build_trees(root, &ocicfg,
> +					dataimport_mode == EROFS_MKFS_DATA_IMPORT_ZEROFILL);
> +			if (err)
> +				goto exit;

and here.


Thanks,

Yifan

>   #endif
>   		}
>   
> +		erofs_info("Starting erofs_rebuild_dump_tree...");
>   		err = erofs_rebuild_dump_tree(root, incremental_mode);
>   		if (err)
>   			goto exit;
> +		erofs_info("erofs_rebuild_dump_tree completed");
>   	}
>   
>   	if (tar_index_512b) {
> @@ -1850,6 +2035,9 @@ exit:
>   	erofs_packedfile_exit(&g_sbi);
>   	erofs_xattr_cleanup_name_prefixes();
>   	erofs_rebuild_cleanup();
> +#ifdef OCIEROFS_ENABLED
> +	ocierofs_cleanup(&ocicfg);
> +#endif
>   	erofs_diskbuf_exit();
>   	erofs_exit_configure();
>   	if (source_mode == EROFS_MKFS_SOURCE_TAR) {

