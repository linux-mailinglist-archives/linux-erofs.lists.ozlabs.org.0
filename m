Return-Path: <linux-erofs+bounces-857-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0491B2F01E
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Aug 2025 09:52:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c6wX12XsNz2yhD;
	Thu, 21 Aug 2025 17:52:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755762737;
	cv=none; b=g4Seyv3n6YVN1SxfY0KFblgLJscMUCm1nTJ2vU5axnkBmGIPj8G2F/xDBKUuYKxYgOLHqbOkM2y11r9Y8szI0Uqs2LB2EWWz6OrHs4betU7uH4F3iF4Gp1f3HAK7PgAUcYkVP8fbR5GdeXQ1kLUpZPdrg4f0roTjNHx97JMCFMyWF61ehR3u7pcMEFUVbnmMwBIMtg6Az/c33PkSbAMTH6vcNrquUIGjyi6sUy+nViKyHoaInEaHYxYK+QKlOKakqGT/xJOXUpvVsOiwjquHgBGi9im2rIpFP+z+l2xT97VLpF2K8Tj3Ucn1Fav7qxFVl8gIKlzl2MFptid2bsTNzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755762737; c=relaxed/relaxed;
	bh=3OBmjhVmgO6wtC598KGIoEIVs4Sj1bV+vKupWvuQ81w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bF5mN1ad63VbPfYsRDSmLouBPId7+pad4WQA5GzGhIWm51vOZS/jgJiFBa6iXy0C0qwFsWRcpeDcCUGrbjK60978Bhn4hcyjMoAq17YZtbueWaEZ+/sWrkcnpujVZwTDm47cfE+GSU8CgvGWqgUUn25HAEUfcLFkDsCXMRM2TCdjSER6OSAa33w3YMbG9NOiVirVCBQ+OSfsmTnd24O2SODCbj7NyKsBZramifD6iFToD2Ug8XGEMuqccRxKW5qOfvOeCvJdEBvFW3IL3XwxopsdLULfjPiNROpniODtmwAR8x8lVutSkpiyvqjmLsKTYMoGz+vITaPYEkLgEeR1vQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=jZz0Rbez; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=jZz0Rbez;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c6wWy703Hz2yCL
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 Aug 2025 17:52:13 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755762729; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=3OBmjhVmgO6wtC598KGIoEIVs4Sj1bV+vKupWvuQ81w=;
	b=jZz0RbezKRVx6WjJScMGNTmVyBbzgdGpvc+CIlnwHOU/h6p1sVF4od0AhcZ1REIJ6Q3f3CRP1tMJQQGNqGh28KzynMfNkVuEh7Xi/RKcsz5rXN4pJzT1JnJdgi67JBtH5Ngc9rD/iiyAryVETXiMwjXKGLrJjxWh3F6fMOqagyY=
Received: from 30.221.130.165(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WmF9vBt_1755762728 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 21 Aug 2025 15:52:09 +0800
Message-ID: <4de3eb31-9368-4512-a9e4-a2f65f30edb0@linux.alibaba.com>
Date: Thu, 21 Aug 2025 15:52:08 +0800
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
Subject: Re: [PATCH 1/1] erofs-utils: add OCI registry support
To: ChengyuZhu6 <hudson@cyzhu.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, Changzhi Xie <sa.z@qq.com>
References: <20250821073258.89073-1-hudson@cyzhu.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250821073258.89073-1-hudson@cyzhu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Chengyu,

On 2025/8/21 15:32, ChengyuZhu6 wrote:

Thanks for the patch!

The author doesn't seem to be updated, you could

`git commit --amend --author="Chengyu Zhu <hudson@cyzhu.com>"`

or just use `git config` for global update.

> This patch adds support for building EROFS filesystems from OCI-compliant

72-char per line.

> container registries, enabling users to create EROFS images directly from
> container images stored in registries like Docker Hub, Quay.io, etc.
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
> 
> Supported options:
> - platform=os/arch (default: linux/amd64)
> - layer=N (extract specific layer, default: all layers)
> - anonymous (use anonymous access)

Is it possible to enable anonymous access if username/password
are not specified?

> - username/password (basic authentication)
> 
> Signed-off-by: Chengyu Zhu <hudson@cyzhu.com>
> Signed-off-by: Changzhi Xie <sa.z@qq.com>

Your `Signed-off-by` needs to the last line of the commit message
since you sent out the email:

Signed-off-by: Changzhi Xie <sa.z@qq.com>
Signed-off-by: Chengyu Zhu <hudson@cyzhu.com>

> ---

...


> diff --git a/lib/liberofs_oci.h b/lib/liberofs_oci.h
> new file mode 100644
> index 0000000..8ed98d7
> --- /dev/null
> +++ b/lib/liberofs_oci.h
> @@ -0,0 +1,73 @@
> +/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/*
> + * Copyright (C) 2025 Tencent, Inc.
> + *             http://www.tencent.com/
> + */
> +#ifndef __EROFS_OCI_H
> +#define __EROFS_OCI_H
> +
> +#include <stdbool.h>
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +struct erofs_inode;
> +
> +/* OCI authentication modes */
> +enum oci_auth_mode {
> +	OCI_AUTH_ANONYMOUS,	/* No authentication */
> +	OCI_AUTH_TOKEN,		/* Bearer token authentication */
> +	OCI_AUTH_BASIC,		/* Basic authentication */
> +};
> +
> +/* Maximum lengths for OCI parameters */
> +#define OCI_REGISTRY_LEN		256
> +#define OCI_REPOSITORY_LEN		256
> +#define OCI_TAG_LEN			64
> +#define OCI_PLATFORM_LEN		32
> +#define OCI_USERNAME_LEN		64
> +#define OCI_PASSWORD_LEN		256

Can we make those string as dynamic allocated?
Hard-coded strings look dangerous.

> +
> +/**
> + * struct erofs_oci - OCI configuration
> + * @registry:         registry hostname (e.g., "registry-1.docker.io")
> + * @repository:       image repository (e.g., "library/ubuntu")
> + * @tag:              image tag or digest (e.g., "latest" or sha256:...)
> + * @platform:         target platform in "os/arch" format (e.g., "linux/amd64")
> + * @username:         username for basic authentication
> + * @password:         password for basic authentication
> + * @auth_mode:        authentication mode to use
> + * @layer_index:      specific layer to extract (-1 for all layers)
> + * @anonymous_access: whether to use anonymous access
> + */
> +struct erofs_oci {

is it possible to rename it as `struct erofs_oci_params`?

> +	char registry[OCI_REGISTRY_LEN + 1];
> +	char repository[OCI_REPOSITORY_LEN + 1];
> +	char tag[OCI_TAG_LEN + 1];
> +	char platform[OCI_PLATFORM_LEN + 1];
> +	char username[OCI_USERNAME_LEN + 1];
> +	char password[OCI_PASSWORD_LEN + 1];
> +	
> +	enum oci_auth_mode auth_mode;

What's the difference between
  OCI_AUTH_ANONYMOUS
and
  anonymous_access?

> +	int layer_index;
> +	bool anonymous_access;
> +};
> +
> +/**
> + * ocierofs_build_trees - Build file trees from OCI container image layers
> + * @root:     root inode to build the file tree under
> + * @oci:      OCI configuration
> + * @ref:      reference string (unused, kept for API compatibility)
> + * @fillzero: if true, only create inodes without downloading actual data
> + *
> + * Return: 0 on success, negative errno on failure
> + */
> +int ocierofs_build_trees(struct erofs_inode *root, struct erofs_oci *oci,
> +			 const char *ref, bool fillzero);
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif /* __EROFS_OCI_H */
> diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
> new file mode 100644
> index 0000000..e86af50
> --- /dev/null
> +++ b/lib/remotes/oci.c
> @@ -0,0 +1,665 @@
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
> +/* Constants */
> +#define OCI_URL_MAX_LEN			8192
> +#define OCI_AUTH_HEADER_MAX_LEN		1024
> +#define OCI_TEMP_FILENAME_MAX_LEN	256
> +
> +/* Media types */
> +#define DOCKER_MEDIATYPE_MANIFEST_V2	"application/vnd.docker.distribution.manifest.v2+json"
> +#define DOCKER_MEDIATYPE_MANIFEST_V1	"application/vnd.docker.distribution.manifest.v1+json"
> +#define DOCKER_MEDIATYPE_MANIFEST_LIST	"application/vnd.docker.distribution.manifest.list.v2+json"
> +#define OCI_MEDIATYPE_MANIFEST		"application/vnd.oci.image.manifest.v1+json"
> +#define OCI_MEDIATYPE_INDEX		"application/vnd.oci.image.index.v1+json"
> +
> +/* Registry constants */
> +#define DOCKER_REGISTRY			"docker.io"
> +#define DOCKER_API_REGISTRY		"registry-1.docker.io"
> +#define QUAY_REGISTRY			"quay.io"
> +
> +/* Global CURL handle */
> +static CURL *g_curl;

and then make

struct erofs_oci {
	CURL *curl;
	struct erofs_oci_params *params;
};

As a OCI context (it can be used for multiple instance usage
such as runtime lazy loading.)

> +> +/* HTTP request/response structures */
> +struct oci_request {
> +	char url[OCI_URL_MAX_LEN];
> +	struct curl_slist *headers;
> +};

struct erofs_oci_request {
};

> +
> +struct oci_response {

erofs_oci_response...

> +	char *data;
> +	size_t size;
> +	long http_code;
> +};
> +
> +/* Layer information */

The comment can be droped since it's obvious.

> +struct oci_layer {

erofs_oci_layer {

> +	char *digest;
> +	u64 size;
> +	const char *media_type;
> +};
> +
> +/* Layer streaming context */
> +struct oci_stream {

Same here.

> +	struct erofs_tarfile tarfile;

	what's the purpose of `struct erofs_tarfile`?

> +	FILE *temp_file;
> +	char temp_filename[OCI_TEMP_FILENAME_MAX_LEN];
> +	int layer_index;
> +};
> +
> +/* Callback for writing response data to memory */
> +static size_t oci_write_callback(void *contents, size_t size, size_t nmemb, void *userp)
> +{
> +	size_t realsize = size * nmemb;
> +	struct oci_response *resp = userp;
> +	char *ptr;
> +
> +	ptr = realloc(resp->data, resp->size + realsize + 1);
> +	if (!ptr)
> +		return 0;
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
> +/* Perform HTTP request */
> +static int oci_request_perform(struct oci_request *req, struct oci_response *resp)
> +{
> +	CURLcode res;
> +	
> +	erofs_dbg("requesting URL: %s", req->url);
> +	
> +	curl_easy_setopt(g_curl, CURLOPT_URL, req->url);
> +	curl_easy_setopt(g_curl, CURLOPT_WRITEDATA, resp);
> +	curl_easy_setopt(g_curl, CURLOPT_WRITEFUNCTION, oci_write_callback);
> +	
> +	if (req->headers)
> +		curl_easy_setopt(g_curl, CURLOPT_HTTPHEADER, req->headers);
> +
> +	res = curl_easy_perform(g_curl);
> +	if (res != CURLE_OK) {
> +		erofs_err("curl request failed: %s", curl_easy_strerror(res));
> +		return -EIO;
> +	}
> +
> +	res = curl_easy_getinfo(g_curl, CURLINFO_RESPONSE_CODE, &resp->http_code);
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
> +/* Get authentication token */
> +static char *oci_get_auth_token(const char *registry, const char *repository,
> +				const char *username, const char *password)
> +{
> +	struct oci_request req = {};
> +	struct oci_response resp = {};
> +	json_object *root, *token_obj;
> +	const char *token;
> +	char *auth_header = NULL;
> +	int ret;
> +
> +	if (!registry || !repository)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (!strcmp(registry, DOCKER_API_REGISTRY) || !strcmp(registry, DOCKER_REGISTRY)) {
> +		snprintf(req.url, sizeof(req.url),
> +			 "https://auth.docker.io/token?service=registry.docker.io&scope=repository:%s:pull",
> +			 repository);
> +	} else if (!strcmp(registry, QUAY_REGISTRY)) {
> +		snprintf(req.url, sizeof(req.url),
> +			 "https://%s/v2/auth?service=%s&scope=repository:%s:pull",
> +			 QUAY_REGISTRY, QUAY_REGISTRY, repository);
> +	} else {
> +		snprintf(req.url, sizeof(req.url),
> +			 "https://%s/token?service=%s&scope=repository:%s:pull",
> +			 registry, registry, repository);
> +	}

You could use asprintf to allocate dynamic strings...


...

>   		case 'V':
>   			version();
> @@ -1638,7 +1775,8 @@ int main(int argc, char **argv)
>   		erofs_uuid_generate(g_sbi.uuid);
>   
>   	if ((source_mode == EROFS_MKFS_SOURCE_TAR && !erofstar.index_mode) ||
> -	    (source_mode == EROFS_MKFS_SOURCE_S3)) {
> +	    (source_mode == EROFS_MKFS_SOURCE_S3) ||
> +	    (source_mode == EROFS_MKFS_SOURCE_OCI)) {
>   		err = erofs_diskbuf_init(1);
>   		if (err) {
>   			erofs_err("failed to initialize diskbuf: %s",
> @@ -1756,12 +1894,27 @@ int main(int argc, char **argv)
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
> +							   cfg.c_src_path,
> +					dataimport_mode == EROFS_MKFS_DATA_IMPORT_ZEROFILL);
> +			if (err)
> +				goto exit;
> +			erofs_info("OCI build_trees completed, starting filesystem construction");
>   #endif
>   		}
>   
> +		erofs_info("Starting erofs_rebuild_dump_tree...");

The debugging info can be removed..

>   		err = erofs_rebuild_dump_tree(root, incremental_mode);
>   		if (err)
>   			goto exit;
> +		erofs_info("erofs_rebuild_dump_tree completed");

Same here.

Thanks,
Gao Xiang

