Return-Path: <linux-erofs+bounces-865-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0148FB30C6B
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Aug 2025 05:18:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c7QP34BlZz3bb2;
	Fri, 22 Aug 2025 13:17:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755832679;
	cv=none; b=ApW2DhjyBc6TVQW2xgENQMdKIY9hOF0bgYf9f3uJqBJgfNri5M+CHuFReKI+XUOIG5lT9aLY3jq0k+Hoj+CZJTBC52FKENA8h1jvLqkUz12KyQkG98FRBkU5/230+9elzTmH35pv/BqRWCL+fh+Xh7wXio2oO7hQGi3i+DCe0zHVC6STnYhgJV0CVyIB7LBQLNLf9jRdAMOXLoPEYZqRJBu+UEKj+6KW//hUyzDqJ4bhGEEHc/fbAeB6cFh0KNos8ZGdNkzT1gJAfp8L0WAKZmoqzn5Hd74J7MKRxm5GuXC7R9N9aohKQ+SEMxsd70ZIR7i9KBrvkGVJyI4qvUcPnw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755832679; c=relaxed/relaxed;
	bh=qxB5mLSmsb2QM+TypDdqB/BTBRLzOxN7ecYIwqzo6+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aKBqljPNNvFyhp+9eLSi0c4h4PMdchJLyKboqAEyRrs0pZ0IQ8npX69eaXtS37WaDA6sTSr7GrQpjANLHwv6yzmQzmswGfSyHQZGvdF04vlJ98ruLme1JJmqFdhndyqkWX9nzw7E8Z0hZzRpIakb6+lrTiOr+hCzoYwMU9+KPVlvbYXvxlEHfn/1Wa4St3Uox/aykA8lT1K7tM2W/MMtvDSyW+CvOTtaMnqgqUZDRi+ZGpZm9iQ3nx5wNu2NIB9q4n7IfICHWj0wLrfkSZXedD6kh8GHoEGnqqfUAsRwle98ql8dVOK3RbBX4F+lgQh81GM0H/kEBL9OqgMBd4ni1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=TlkyXfR9; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=TlkyXfR9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c7QP00nWwz2xpn
	for <linux-erofs@lists.ozlabs.org>; Fri, 22 Aug 2025 13:17:54 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755832670; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qxB5mLSmsb2QM+TypDdqB/BTBRLzOxN7ecYIwqzo6+w=;
	b=TlkyXfR9YU0UsTAoa1gSE67p6TwIyQwiBgRfzsxWMVOz9DtOJk74dIGvFepFqVuwlUcXddcvnEVF9LxVu3qSBbq9lkxcdB+WDD+jex9+I8NKIkWfKTRsWJX/CejfIKW/0BytPsieo35E26gypSpT5Zl8Dg/A35zNNKuDSMa4j8g=
Received: from 30.221.131.67(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WmIIcCw_1755832668 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 22 Aug 2025 11:17:49 +0800
Message-ID: <a6f8e5c3-b553-4da8-b764-8611afda8597@linux.alibaba.com>
Date: Fri, 22 Aug 2025 11:17:48 +0800
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
Subject: Re: [PATCH v2] erofs-utils: add OCI registry support
To: ChengyuZhu6 <hudson@cyzhu.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, Changzhi Xie <sa.z@qq.com>
References: <20250821073258.89073-1-hudson@cyzhu.com>
 <20250822024522.95384-1-hudson@cyzhu.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250822024522.95384-1-hudson@cyzhu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/8/22 10:45, ChengyuZhu6 wrote:
> From: Chengyu Zhu <hudson@cyzhu.com>
> 
> This patch adds support for building EROFS filesystems from
> OCI-compliant container registries, enabling users to create EROFS
> images directly from container images stored in registries like
> Docker Hub, Quay.io, etc.
> 
> The implementation includes:
> - OCI remote backend with registry authentication support
> - Manifest parsing for Docker v2 and OCI v1 formats
> - Layer extraction and tar processing integration
> - Multi-platform image selection capability
> - Both anonymous and authenticated registry access
> - Comprehensive build system integration
> 
> New mkfs.erofs option: --oci=registry/repo:tag[,options]

Could you just write down the full command line? e,g.

mkfs.erofs --oci=registry/repo:tag[,options] <IMAGE> <?>

what's the meaning of <?>? since users already pass in
  registry/repo:tag and layer=N

> 
> Supported options:
> - platform=os/arch (default: linux/amd64)
> - layer=N (extract specific layer, default: all layers)
> - anonymous (use anonymous access)
> - username/password (basic authentication)
> 
> Signed-off-by: Changzhi Xie <sa.z@qq.com>
> Signed-off-by: Chengyu Zhu <hudson@cyzhu.com>

..

> +
> +#endif /* __EROFS_OCI_H */
> diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
> new file mode 100644
> index 0000000..0c14f90
> --- /dev/null
> +++ b/lib/remotes/oci.c
> @@ -0,0 +1,826 @@
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
> +#include "erofs/tar.h"
> +#include "liberofs_oci.h"
> +
> +#define OCI_AUTH_HEADER_MAX_LEN 1024
> +#define OCI_TEMP_FILENAME_MAX_LEN 256
> +
> +#define DOCKER_MEDIATYPE_MANIFEST_V2 "application/vnd.docker.distribution.manifest.v2+json"
> +#define DOCKER_MEDIATYPE_MANIFEST_V1 "application/vnd.docker.distribution.manifest.v1+json"
> +#define DOCKER_MEDIATYPE_MANIFEST_LIST "application/vnd.docker.distribution.manifest.list.v2+json"
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
> +struct oci_stream {

struct erofs_oci_stream {

It's prefered to use `erofs_` prefix even the structure
is internal-only or static.

> +	struct erofs_tarfile tarfile;
> +	FILE *temp_file;
> +	char temp_filename[OCI_TEMP_FILENAME_MAX_LEN];

I think you could just leave a fd for this?

and use
erofs_tmpfile().

> +	int layer_index;
> +};
> +
> +/* Callback for writing response data to memory */
> +static size_t oci_write_callback(void *contents, size_t size, size_t nmemb, void *userp)

same here.
ocierofs_write_callback

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
> +static size_t oci_layer_write_callback(void *contents, size_t size, size_t nmemb, void *userp)

ocierofs_

> +{
> +	struct oci_stream *stream = userp;
> +	size_t realsize = size * nmemb;
> +
> +	if (!stream->temp_file)
> +		return 0;
> +
> +	if (fwrite(contents, 1, realsize, stream->temp_file) != realsize) {
> +		erofs_err("failed to write layer data for layer %d", stream->layer_index);
> +		return 0;
> +	}
> +
> +	return realsize;
> +}
> +
> +static int oci_curl_setup_common_options(CURL *curl)


ocierofs_

> +{
> +	if (!curl)
> +		return -EINVAL;

Since it's an internal helper, I think it's unneeded to
check the invalid argument.

> +
> +	curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L);
> +	curl_easy_setopt(curl, CURLOPT_CONNECTTIMEOUT, 30L);
> +	curl_easy_setopt(curl, CURLOPT_TIMEOUT, 120L);
> +	curl_easy_setopt(curl, CURLOPT_NOSIGNAL, 1L);
> +	curl_easy_setopt(curl, CURLOPT_USERAGENT, "ocierofs/" PACKAGE_VERSION);
> +
> +	return 0;
> +}
> +
> +static int oci_curl_setup_basic_auth(CURL *curl, const char *username, const char *password)

ocierofs_

> +{
> +	char *userpwd = NULL;
> +
> +	if (!curl || !username || !password)
> +		return -EINVAL;

Same here too.

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
> +static int oci_curl_clear_auth(CURL *curl)
> +{
> +	if (!curl)
> +		return -EINVAL;

Same here too.

> +
> +	curl_easy_setopt(curl, CURLOPT_USERPWD, NULL);
> +	curl_easy_setopt(curl, CURLOPT_HTTPAUTH, CURLAUTH_NONE);
> +
> +	return 0;
> +}
> +
> +static int oci_curl_setup_request(CURL *curl, const char *url, size_t (*write_func)(void *, size_t, size_t, void *),
> +                                  void *write_data, struct curl_slist *headers)
> +{
> +	if (!curl || !url || !write_func)
> +		return -EINVAL;

Same here too.

> +
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
> +static int oci_request_perform(struct erofs_oci *oci, struct erofs_oci_request *req,
> +							   struct erofs_oci_response *resp)
> +{
> +	CURLcode res;
> +	int ret;
> +
> +	ret = oci_curl_setup_request(oci->curl, req->url, oci_write_callback, resp, req->headers);
> +	if (ret)
> +		return ret;
> +
> +	res = curl_easy_perform(oci->curl);
> +	if (res != CURLE_OK) {
> +		erofs_err("curl request failed: %s", curl_easy_strerror(res));
> +		return -EIO;
> +	}
> +
> +	res = curl_easy_getinfo(oci->curl, CURLINFO_RESPONSE_CODE, &resp->http_code);
> +	if (res != CURLE_OK) {
> +		erofs_err("failed to get HTTP response code: %s", curl_easy_strerror(res));
> +		return -EIO;
> +	}
> +
> +	if (resp->http_code < 200 || resp->http_code >= 300) {
> +		erofs_err("HTTP request failed with code %ld", resp->http_code);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static char *oci_get_auth_token(struct erofs_oci *oci, const char *registry,
> +								const char *repository, const char *username,
> +								const char *password)

It seems your tab style is incorrect: one tab should be 8 spaces.

> +{


...

> +
> +	if (!resp.data)
> +	{

brace should follow `if (!resp.data)`

	if (!resp.data) {

erofs-utils follows linux kernel style: K&R C style.

> +		erofs_err("empty response from auth server");
> +		ret = -EINVAL;
> +		goto out_url;
> +	}
> +
> +	root = json_tokener_parse(resp.data);
> +	if (!root)
> +	{

here.

> +		erofs_err("failed to parse auth response");
> +		ret = -EINVAL;
> +		goto out_url;
> +	}
> +
> +	if (!json_object_object_get_ex(root, "token", &token_obj))
> +	{

here.

There are still many broken braces below, I think let's
just fix the coding style first.

> +		erofs_err("no token found in auth response");
> +		ret = -EINVAL;
> +		goto out_json;
> +	}
> +
> +	token = json_object_get_string(token_obj);
> +	if (!token)
> +	{
> +		erofs_err("invalid token in auth response");
> +		ret = -EINVAL;
> +		goto out_json;
> +	}
> +
> +	if (asprintf(&auth_header, "Authorization: Bearer %s", token) == -1)
> +	{
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
Thanks,
Gao Xiang

