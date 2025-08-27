Return-Path: <linux-erofs+bounces-914-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A255CB37A01
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Aug 2025 07:53:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cBYc05nnQz30Vn;
	Wed, 27 Aug 2025 15:53:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756274000;
	cv=none; b=Ue/AxmAtwckpCDl/ykH42odkVrj8MzBBdbKy6ReDByNUH0oWZJHlbHn9cCdsu+RwHPByfMh8QsLRa1949LtFMYu8Yg/N44bPZc9Ogzuph6uqKW3xeu0KTcAUjvf60S0ykMknDRvLlO8d6n0RsJ7U+R8YM+Wi83kjUrX/V5WvJMgJVOtx6XS5RPgdhEpIeMRz4HklCY84aw+4gO/SgU7vXqYW813mfhqIl0UmBEtGR3M1vmzM91/988x1kZEKTe9hVT2PfApkjOSFDfhBcqGOuWZmmQmeE3N7BkQtBM3AaeSBXNp2RDEAJ4oR6YEVyBwPWsXuFr9gPZVQe7hbh4uOcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756274000; c=relaxed/relaxed;
	bh=QK5nqa517XrZ+09J7oU91HQ5x3hpyMGv96NWX8UPScg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J7hgwg4vM/tVYtVO3tmBSUlgnC+6pBovfU9ruwwZFK52lBujTIQdQgAYTRBOGmmTaELledCVDFKh9kmJtd9hWqGkWXqwOH97uMwZv1zFBRXc2yqFVUT82BazMTAP5Bkrcc68k+bhgBkiexS3V0mYG5XAlmzFvnKaAh5+POnw8OPAnNLc0Y9dymeDPMwJ0CHDiIrtOlwf7YgmpIc8XBIaECXNgnZLdyAJ4WOKU+rG1Jf/MqbUOLNOQTlbfk73JxQ8IuqopRqsNdZOtoGbMrntrbDtmeUtj0MEHzvN9KQ0HZtazca+T8gVN4ZSne/AcAvSrDrYOutBATvMljWhL7zhLw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=XI68jINj; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=XI68jINj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cBYbx4nXrz2xS2
	for <linux-erofs@lists.ozlabs.org>; Wed, 27 Aug 2025 15:53:16 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756273991; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=QK5nqa517XrZ+09J7oU91HQ5x3hpyMGv96NWX8UPScg=;
	b=XI68jINj9KtCUL62pmgrzrMQvnVL81JlSNPVrglTsAsPuTyCvdNWcmc0nsgRo05ueh8ZrCtHscw3Y/FBWGxNUtBbLVJQwTt4VXy6aixNAM2p34wYjt5Iij+S4fzvsWZdG4HXcS9uJc7yp/Sae288Cj2XFhakeW4zjureFDWlsn0=
Received: from 30.221.131.253(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WmhY4Z1_1756273989 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 27 Aug 2025 13:53:09 +0800
Message-ID: <3bb55784-514e-4ab8-9f38-d9e34fdbb8ab@linux.alibaba.com>
Date: Wed, 27 Aug 2025 13:53:08 +0800
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
Subject: Re: [PATCH v7-change-email] erofs-utils: add OCI registry support
To: ChengyuZhu6 <hudson@cyzhu.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, Chengyu Zhu <hudsonzhu@tencent.com>,
 Changzhi Xie <sa.z@qq.com>
References: <20250821073258.89073-1-hudson@cyzhu.com>
 <20250827044822.22559-1-hudson@cyzhu.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250827044822.22559-1-hudson@cyzhu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/8/27 12:48, ChengyuZhu6 wrote:
> From: Chengyu Zhu <hudsonzhu@tencent.com>
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
> Configure: ./configure --enable-oci
> New mkfs.erofs option: --oci=[option] target source-image
> 
> Supported options:
> - platform=os/arch (default: linux/amd64)
> - layer=N (extract specific layer, default: all layers)
> - username/password (basic authentication)
> 
> e.g.:
> - mkfs.erofs \
>    --oci=platform=linux/amd64, \
>    username=1234,password=1234 \
>    image.erofs ubuntu
> 
> Signed-off-by: Changzhi Xie <sa.z@qq.com>
> Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
> ---
>   configure.ac       |   47 ++
>   lib/Makefile.am    |    8 +-
>   lib/liberofs_oci.h |   95 ++++
>   lib/remotes/oci.c  | 1170 ++++++++++++++++++++++++++++++++++++++++++++
>   mkfs/main.c        |  267 +++++++++-
>   5 files changed, 1585 insertions(+), 2 deletions(-)
>   create mode 100644 lib/liberofs_oci.h
>   create mode 100644 lib/remotes/oci.c
> 
> diff --git a/configure.ac b/configure.ac
> index 1efb57a..5c33b78 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -177,10 +177,19 @@ AC_ARG_WITH(libxml2,
>      [AS_HELP_STRING([--with-libxml2],
>         [Enable and build with libxml2 support @<:@default=auto@:>@])])
>   
> +AC_ARG_WITH(json_c,
> +   [AS_HELP_STRING([--with-json-c],
> +      [Enable and build with json-c support @<:@default=auto@:>@])])
> +
>   AC_ARG_ENABLE(s3,
>      [AS_HELP_STRING([--enable-s3], [enable s3 image generation support @<:@default=no@:>@])],
>      [enable_s3="$enableval"], [enable_s3="no"])
>   
> +AC_ARG_ENABLE(oci,
> +    AS_HELP_STRING([--enable-oci],
> +                   [enable OCI registry based input support @<:@default=no@:>@]),
> +    [enable_oci="$enableval"],[enable_oci="no"])
> +
>   AC_ARG_ENABLE(fuse,
>      [AS_HELP_STRING([--enable-fuse], [enable erofsfuse @<:@default=no@:>@])],
>      [enable_fuse="$enableval"], [enable_fuse="no"])
> @@ -624,6 +633,39 @@ AS_IF([test "x$with_libcurl" != "xno"], [
>     ])
>   ])
>   
> +# Configure json-c
> +have_json_c="no"
> +AS_IF([test "x$with_json_c" != "xno"], [
> +  PKG_CHECK_MODULES([json_c], [json-c], [
> +    saved_LIBS="$LIBS"
> +    saved_CPPFLAGS=${CPPFLAGS}
> +    CPPFLAGS="${json_c_CFLAGS} ${CPPFLAGS}"
> +    LIBS="${json_c_LIBS} $LIBS"
> +    AC_CHECK_HEADERS([json-c/json.h],[
> +      AC_CHECK_DECL(json_tokener_parse, [have_json_c="yes"],
> +        [AC_MSG_ERROR([json-c doesn't work properly])], [[
> +#include <json-c/json.h>
> +      ]])
> +    ])
> +    LIBS="${saved_LIBS}"
> +    CPPFLAGS="${saved_CPPFLAGS}"
> +  ], [
> +    AS_IF([test "x$with_json_c" = "xyes"], [
> +      AC_MSG_ERROR([Cannot find proper json-c])
> +    ])
> +  ])
> +])
> +
> +# Validate dependencies for OCI registry
> +AS_IF([test "x$enable_oci" = "xyes"], [
> +  AS_IF([test "x$have_libcurl" = "xyes" -a "x$have_json_c" = "xyes"], [
> +    have_oci="yes"
> +  ], [
> +    have_oci="no"
> +    AC_MSG_ERROR([OCI registry disabled: missing libcurl or json-c])
> +  ])
> +], [have_oci="no"])
> +
>   # Configure openssl
>   have_openssl="no"
>   AS_IF([test "x$with_openssl" != "xno"], [
> @@ -713,6 +755,7 @@ AM_CONDITIONAL([ENABLE_OPENSSL], [test "x${have_openssl}" = "xyes"])
>   AM_CONDITIONAL([ENABLE_LIBXML2], [test "x${have_libxml2}" = "xyes"])
>   AM_CONDITIONAL([ENABLE_S3], [test "x${have_s3}" = "xyes"])
>   AM_CONDITIONAL([ENABLE_STATIC_FUSE], [test "x${enable_static_fuse}" = "xyes"])
> +AM_CONDITIONAL([ENABLE_OCI], [test "x${have_oci}" = "xyes"])
>   
>   if test "x$have_uuid" = "xyes"; then
>     AC_DEFINE([HAVE_LIBUUID], 1, [Define to 1 if libuuid is found])
> @@ -785,6 +828,10 @@ if test "x$have_s3" = "xyes"; then
>     AC_DEFINE([S3EROFS_ENABLED], 1, [Define to 1 if s3 is enabled])
>   fi
>   
> +if test "x$have_oci" = "xyes"; then
> +  AC_DEFINE([OCIEROFS_ENABLED], 1, [Define to 1 if OCI registry is enabled])
> +fi
> +
>   # Dump maximum block size
>   AS_IF([test "x$erofs_cv_max_block_size" = "x"],
>         [$erofs_cv_max_block_size = 4096], [])
> diff --git a/lib/Makefile.am b/lib/Makefile.am
> index 955495d..118b047 100644
> --- a/lib/Makefile.am
> +++ b/lib/Makefile.am
> @@ -42,6 +42,7 @@ liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
>   		      vmdk.c metabox.c global.c importer.c
>   
>   liberofs_la_CFLAGS = -Wall ${libuuid_CFLAGS} -I$(top_srcdir)/include
> +liberofs_la_LDFLAGS =
>   if ENABLE_LZ4
>   liberofs_la_CFLAGS += ${liblz4_CFLAGS}
>   liberofs_la_SOURCES += compressor_lz4.c
> @@ -73,6 +74,11 @@ if ENABLE_S3
>   liberofs_la_SOURCES += remotes/s3.c
>   endif
>   if ENABLE_EROFS_MT
> -liberofs_la_LDFLAGS = -lpthread
> +liberofs_la_LDFLAGS += -lpthread
>   liberofs_la_SOURCES += workqueue.c
>   endif
> +if ENABLE_OCI
> +liberofs_la_SOURCES += remotes/oci.c
> +liberofs_la_CFLAGS += ${libcurl_CFLAGS} ${json_c_CFLAGS}
> +liberofs_la_LDFLAGS += ${libcurl_LIBS} ${json_c_LIBS}
> +endif
> diff --git a/lib/liberofs_oci.h b/lib/liberofs_oci.h
> new file mode 100644
> index 0000000..3a8108b
> --- /dev/null
> +++ b/lib/liberofs_oci.h
> @@ -0,0 +1,95 @@
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
> +#define DOCKER_REGISTRY "docker.io"
> +#define DOCKER_API_REGISTRY "registry-1.docker.io"
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +struct erofs_inode;
> +struct CURL;
> +struct erofs_importer;
> +
> +/**
> + * struct erofs_oci_params - OCI configuration parameters
> + * @registry: registry hostname (e.g., "registry-1.docker.io")
> + * @repository: image repository (e.g., "library/ubuntu")
> + * @tag: image tag or digest (e.g., "latest" or sha256:...)
> + * @platform: target platform in "os/arch" format (e.g., "linux/amd64")
> + * @username: username for authentication (optional)
> + * @password: password for authentication (optional)
> + * @layer_index: specific layer to extract (-1 for all layers)
> + *
> + * Configuration structure for OCI image parameters including registry
> + * location, image identification, platform specification, and authentication
> + * credentials.
> + */
> +struct erofs_oci_params {
> +	char *registry;
> +	char *repository;
> +	char *tag;
> +	char *platform;
> +	char *username;
> +	char *password;
> +	int layer_index;
> +};
> +
> +/**
> + * struct erofs_oci - Combined OCI client structure
> + * @curl: CURL handle for HTTP requests
> + * @params: OCI configuration parameters
> + *
> + * Main OCI client structure combining CURL HTTP client with
> + * OCI-specific configuration parameters.
> + */
> +struct erofs_oci {
> +	struct CURL *curl;
> +	struct erofs_oci_params params;
> +};
> +
> +/*
> + * ocierofs_init - Initialize OCI client with default parameters
> + * @oci: OCI client structure to initialize
> + *
> + * Return: 0 on success, negative errno on failure
> + */
> +int ocierofs_init(struct erofs_oci *oci);
> +
> +/*
> + * ocierofs_cleanup - Clean up OCI client and free allocated resources
> + * @oci: OCI client structure to clean up
> + */
> +void ocierofs_cleanup(struct erofs_oci *oci);
> +
> +/*
> + * erofs_oci_params_set_string - Set a string field with dynamic allocation
> + * @field: pointer to the string field to set
> + * @value: string value to set
> + *
> + * Return: 0 on success, negative errno on failure
> + */
> +int erofs_oci_params_set_string(char **field, const char *value);
> +
> +/*
> + * ocierofs_build_trees - Build file trees from OCI container image layers
> + * @root:     root inode to build the file tree under
> + * @oci:      OCI client structure with configured parameters
> + *
> + * Return: 0 on success, negative errno on failure
> + */
> +int ocierofs_build_trees(struct erofs_importer *importer, struct erofs_oci *oci);
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif /* __EROFS_OCI_H */
> diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
> new file mode 100644
> index 0000000..a64c2ee
> --- /dev/null
> +++ b/lib/remotes/oci.c
> @@ -0,0 +1,1170 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
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
> +#include "erofs/importer.h"
> +#include "erofs/internal.h"
> +#include "erofs/print.h"
> +#include "erofs/inode.h"
> +#include "erofs/blobchunk.h"
> +#include "erofs/diskbuf.h"
> +#include "erofs/rebuild.h"

Yifan mentioned:
It seems `inode.h` `blobchunk.h` `diskbuf.h` `rebuild.h` is redundant.

> +#include "erofs/tar.h"
> +#include "liberofs_oci.h"
> +#include "liberofs_private.h"
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
> +static size_t ocierofs_write_callback(void *contents, size_t size,
> +				       size_t nmemb, void *userp)
> +{
> +	size_t realsize = size * nmemb;
> +	struct erofs_oci_response *resp = userp;
> +	char *ptr;
> +
> +	if (!resp || !contents)
> +		return 0;
> +
> +	if (resp->data == NULL)
> +		resp->size = 0;
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
> +static int ocierofs_curl_setup_common_options(struct CURL *curl)
> +{
> +	curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L);
> +	curl_easy_setopt(curl, CURLOPT_CONNECTTIMEOUT, 30L);
> +	curl_easy_setopt(curl, CURLOPT_TIMEOUT, 120L);
> +	curl_easy_setopt(curl, CURLOPT_NOSIGNAL, 1L);
> +	curl_easy_setopt(curl, CURLOPT_USERAGENT, "ocierofs/" PACKAGE_VERSION);
> +	return 0;
> +}
> +
> +static int ocierofs_curl_setup_basic_auth(struct CURL *curl, const char *username,
> +					 const char *password)
> +{
> +	char *userpwd;
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
> +static int ocierofs_curl_clear_auth(struct CURL *curl)
> +{
> +	curl_easy_setopt(curl, CURLOPT_USERPWD, NULL);
> +	curl_easy_setopt(curl, CURLOPT_HTTPAUTH, CURLAUTH_NONE);
> +
> +	return 0;
> +}
> +
> +enum ocierofs_http_method { OCIEROFS_HTTP_GET, OCIEROFS_HTTP_HEAD };
> +
> +static int ocierofs_curl_setup_request_ex(struct CURL *curl, const char *url,
> +					   enum ocierofs_http_method method,
> +					   struct curl_slist *headers,
> +					   size_t (*write_func)(void *, size_t, size_t, void *),
> +					   void *write_data,
> +					   size_t (*header_func)(void *, size_t, size_t, void *),
> +					   void *header_data)

Why ocierofs_curl_setup_request_ex? it seems there is no
`ocierofs_curl_setup_request`, so I think it would be
better to rename it as `ocierofs_curl_setup_request`.

> +{
> +	curl_easy_setopt(curl, CURLOPT_URL, url);
> +
> +	if (method == OCIEROFS_HTTP_HEAD) {
> +		curl_easy_setopt(curl, CURLOPT_NOBODY, 1L);
> +	} else {
> +		curl_easy_setopt(curl, CURLOPT_NOBODY, 0L);
> +		curl_easy_setopt(curl, CURLOPT_HTTPGET, 1L);
> +	}
> +
> +	if (write_func) {
> +		curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_func);
> +		curl_easy_setopt(curl, CURLOPT_WRITEDATA, write_data);
> +	}
> +
> +	curl_easy_setopt(curl, CURLOPT_HEADERFUNCTION, header_func);
> +	curl_easy_setopt(curl, CURLOPT_HEADERDATA, header_data);
> +
> +	if (headers)
> +		curl_easy_setopt(curl, CURLOPT_HTTPHEADER, headers);
> +
> +	return 0;
> +}
> +
> +static int ocierofs_curl_perform(struct CURL *curl, long *http_code_out)
> +{
> +	CURLcode res;
> +	long http_code = 0;
> +
> +	res = curl_easy_perform(curl);
> +	if (res != CURLE_OK) {
> +		erofs_err("curl request failed: %s", curl_easy_strerror(res));
> +		return -EIO;
> +	}
> +
> +	if (http_code_out) {
> +		res = curl_easy_getinfo(curl, CURLINFO_RESPONSE_CODE, &http_code);
> +		if (res != CURLE_OK) {
> +			erofs_err("failed to get HTTP response code: %s",
> +				  curl_easy_strerror(res));
> +			return -EIO;
> +		}
> +		*http_code_out = http_code;
> +	}
> +	return 0;
> +}
> +
> +static int ocierofs_request_perform(struct erofs_oci *oci,
> +				   struct erofs_oci_request *req,
> +				   struct erofs_oci_response *resp)
> +{
> +	int ret;
> +
> +	ret = ocierofs_curl_setup_request_ex(oci->curl, req->url,
> +					    OCIEROFS_HTTP_GET,
> +					    req->headers,
> +					    ocierofs_write_callback, resp,
> +					    NULL, NULL);
> +	if (ret)
> +		return ret;
> +
> +	ret = ocierofs_curl_perform(oci->curl, &resp->http_code);
> +	if (ret)
> +		return ret;
> +
> +	if (resp->http_code < 200 || resp->http_code >= 300)
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +/**
> + * ocierofs_parse_auth_header - Parse WWW-Authenticate header for Bearer auth
> + * @auth_header: authentication header string
> + * @realm_out: pointer to store realm value
> + * @service_out: pointer to store service value
> + * @scope_out: pointer to store scope value
> + *
> + * Parse Bearer authentication header and extract realm, service, and scope
> + * parameters for subsequent token requests.
> + *
> + * Return: 0 on success, negative errno on failure
> + */
> +static int ocierofs_parse_auth_header(const char *auth_header,
> +				      char **realm_out, char **service_out,
> +				      char **scope_out)
> +{
> +	const char *p, *start;
> +	char *value;
> +	size_t len;
> +	char *realm = NULL, *service = NULL, *scope = NULL;
> +	char *header_copy = NULL;
> +
> +	if (!auth_header || strncmp(auth_header, "Bearer ", strlen("Bearer ")) != 0)
> +		return -EINVAL;

I think auth_header doesn't need to be checked since it's
an internal function.

> +
> +	header_copy = strdup(auth_header);
> +	if (!header_copy)
> +		return -ENOMEM;
> +
> +	for (char *q = header_copy; *q; q++) {
> +		if (*q == '\n' || *q == '\r')
> +			*q = ' ';
> +	}
> +
> +	for (char *q = header_copy; *q; q++) {
> +		if (*q == ' ' && *(q+1) == ' ') {
> +			memmove(q, q+1, strlen(q+1) + 1);
> +			q--;
> +		}
> +	}
> +
> +	p = header_copy + strlen("Bearer ");
> +
> +	p = strstr(p, "realm=\"");

Is the order of `realm`, `service` and `scope` fixed?

I guess it needs to be worked out as the way of
mkfs_parse_oci_options() or similar?

> +	if (p) {
> +		p += strlen("realm=\"");
> +		start = p;
> +		p = strchr(start, '"');
> +		if (p) {
> +			len = p - start;
> +			value = strndup(start, len);
> +			if (!value)
> +				goto enomem;
> +			realm = value;
> +		}
> +	}
> +
> +	p = strstr(header_copy, "service=\"");
> +	if (p) {
> +		p += strlen("service=\"");
> +		start = p;
> +		p = strchr(start, '"');
> +		if (p) {
> +			len = p - start;
> +			value = strndup(start, len);
> +			if (!value)
> +				goto enomem;
> +			service = value;
> +		}
> +	}
> +
> +	p = strstr(header_copy, "scope=\"");
> +	if (p) {
> +		p += strlen("scope=\"");
> +		start = p;
> +		p = strchr(start, '"');
> +		if (p) {
> +			len = p - start;
> +			value = strndup(start, len);
> +			if (!value)
> +				goto enomem;
> +			scope = value;
> +		}
> +	}
> +
> +	if (realm_out) {
> +		*realm_out = realm;
> +		realm = NULL;
> +	}
> +	if (service_out) {
> +		*service_out = service;
> +		service = NULL;
> +	}
> +	if (scope_out) {
> +		*scope_out = scope;
> +		scope = NULL;
> +	}
> +
> +	free(header_copy);
> +	free(realm);
> +	free(service);
> +	free(scope);
> +	return 0;
> +
> +enomem:
> +	free(header_copy);
> +	free(realm);
> +	free(service);
> +	free(scope);
> +	return -ENOMEM;
> +}
> +
> +/**
> + * ocierofs_extract_www_auth_info - Extract WWW-Authenticate header information
> + * @resp_data: HTTP response data containing headers
> + * @realm_out: pointer to store realm value (optional)
> + * @service_out: pointer to store service value (optional)
> + * @scope_out: pointer to store scope value (optional)
> + *
> + * Extract realm, service, and scope from WWW-Authenticate header in HTTP response.
> + * This function handles the common pattern of parsing WWW-Authenticate headers
> + * that appears in multiple places in the OCI authentication flow.
> + *
> + * Return: 0 on success, negative errno on failure
> + */
> +static int ocierofs_extract_www_auth_info(const char *resp_data,
> +					 char **realm_out, char **service_out,
> +					 char **scope_out)
> +{
> +	char *www_auth;
> +	char *line_end;
> +	char *realm = NULL, *service = NULL, *scope = NULL;
> +	int ret = -ENOENT;
> +
> +	if (!resp_data)
> +		return -EINVAL;

resp_data won't be NULL all the time.

> +
> +	www_auth = strcasestr(resp_data, "www-authenticate:");
> +	if (!www_auth)
> +		return -ENOENT;
> +
> +	line_end = strchr(www_auth, '\n');
> +	if (line_end)
> +		*line_end = '\0';
> +
> +	www_auth += strlen("www-authenticate:");
> +	while (*www_auth == ' ')
> +		www_auth++;
> +> +	ret = ocierofs_parse_auth_header(www_auth, &realm, &service, &scope);
> +	if (ret == 0) {
> +		if (realm_out) {
> +			*realm_out = realm;
> +			realm = NULL;
> +		}
> +		if (service_out) {
> +			*service_out = service;
> +			service = NULL;
> +		}
> +		if (scope_out) {
> +			*scope_out = scope;
> +			scope = NULL;
> +		}
> +	}
> +
> +	free(realm);
> +	free(service);
> +	free(scope);
> +	return ret;
> +}
> +
> +/**
> + * ocierofs_get_auth_token_with_url - Get authentication token from auth server
> + * @oci: OCI client structure
> + * @auth_url: authentication server URL
> + * @service: service name for authentication
> + * @repository: repository name
> + * @username: username for basic auth (optional)
> + * @password: password for basic auth (optional)
> + *
> + * Request authentication token from the specified auth server URL using
> + * basic authentication if credentials are provided.
> + *
> + * Return: authentication header string on success, ERR_PTR on failure
> + */
> +static char *ocierofs_get_auth_token_with_url(struct erofs_oci *oci,
> +					      const char *auth_url,
> +					      const char *service,
> +					      const char *repository,
> +					      const char *username,
> +					      const char *password)
> +{
> +	struct erofs_oci_request req = {};
> +	struct erofs_oci_response resp = {};
> +	json_object *root, *token_obj, *access_token_obj;
> +	const char *token;
> +	char *auth_header = NULL;
> +	int ret;
> +
> +	if (!auth_url || !service || !repository)
> +		return ERR_PTR(-EINVAL);

These three checks are unneeded too.

..

> +
> +static char *ocierofs_discover_auth_endpoint(struct erofs_oci *oci,
> +					    const char *registry,
> +					    const char *repository)
> +{
> +	struct erofs_oci_response resp = {};
> +	char *realm = NULL;
> +	char *service = NULL;
> +	char *result = NULL;
> +	char *test_url;
> +	const char *api_registry;
> +	CURLcode res;
> +	long http_code;
> +
> +	api_registry = (!strcmp(registry, DOCKER_REGISTRY)) ? DOCKER_API_REGISTRY : registry;
> +
> +	if (asprintf(&test_url, "https://%s/v2/%s/manifests/nonexistent",
> +	     api_registry, repository) == -1) {
> +		return NULL;
> +	}
> +
> +	curl_easy_reset(oci->curl);
> +	ocierofs_curl_setup_common_options(oci->curl);
> +
> +	ocierofs_curl_setup_request_ex(oci->curl, test_url,
> +				      OCIEROFS_HTTP_HEAD,
> +				      NULL,
> +				      NULL, NULL,
> +				      ocierofs_write_callback, &resp);
> +
> +	res = curl_easy_perform(oci->curl);
> +	curl_easy_getinfo(oci->curl, CURLINFO_RESPONSE_CODE, &http_code);
> +
> +	if (res == CURLE_OK && (http_code == 401 || http_code == 403 ||
> +	    http_code == 404) && resp.data) {
> +		if (ocierofs_extract_www_auth_info(resp.data, &realm, &service, NULL) == 0) {
> +			result = realm;
> +			realm = NULL;
> +		}
> +	}
> +
> +	free(realm);
> +	free(service);
> +	free(resp.data);
> +	free(test_url);
> +	return result;
> +}
> +
> +static char *ocierofs_get_auth_token(struct erofs_oci *oci, const char *registry,
> +				    const char *repository, const char *username,
> +				    const char *password)
> +{
> +	char *auth_header = NULL;
> +	char *discovered_auth_url = NULL;
> +	char *discovered_service = NULL;
> +	const char *service = registry;
> +
> +	if (!strcmp(registry, DOCKER_API_REGISTRY) ||
> +	    !strcmp(registry, DOCKER_REGISTRY)) {
> +		service = "registry.docker.io";
> +		auth_header = ocierofs_get_auth_token_with_url(oci,
> +							      "https://auth.docker.io/token",
> +							      service, repository,
> +							      username, password);
> +		if (!IS_ERR(auth_header))
> +			return auth_header;
> +	}
> +
> +	discovered_auth_url = ocierofs_discover_auth_endpoint(oci, registry, repository);
> +	if (discovered_auth_url) {
> +		struct erofs_oci_response resp = {};
> +		char *test_url;
> +		const char *api_registry;
> +		CURLcode res;
> +		long http_code;
> +
> +		api_registry = (!strcmp(registry, DOCKER_REGISTRY)) ? DOCKER_API_REGISTRY : registry;
> +
> +		if (asprintf(&test_url, "https://%s/v2/%s/manifests/nonexistent",
> +		     api_registry, repository) != -1) {
> +			curl_easy_reset(oci->curl);
> +			ocierofs_curl_setup_common_options(oci->curl);
> +
> +			ocierofs_curl_setup_request_ex(oci->curl, test_url,
> +						      OCIEROFS_HTTP_HEAD,
> +						      NULL,
> +						      NULL, NULL,
> +						      ocierofs_write_callback, &resp);
> +
> +			res = curl_easy_perform(oci->curl);
> +			curl_easy_getinfo(oci->curl, CURLINFO_RESPONSE_CODE, &http_code);
> +
> +			if (res == CURLE_OK && (http_code == 401 || http_code == 403 ||
> +			    http_code == 404) && resp.data) {
> +				char *realm = NULL;
> +
> +				ocierofs_extract_www_auth_info(resp.data, &realm, &discovered_service, NULL);
> +				free(realm);
> +			}
> +			free(resp.data);
> +			free(test_url);
> +		}
> +
> +		const char *auth_service = discovered_service ? discovered_service : service;
> +
> +		auth_header = ocierofs_get_auth_token_with_url(oci, discovered_auth_url,
> +							      auth_service, repository,
> +							      username, password);
> +		free(discovered_auth_url);
> +		free(discovered_service);
> +		if (!IS_ERR(auth_header))
> +			return auth_header;
> +	}
> +
> +	static const char * const auth_patterns[] = {
> +		"https://%s/v2/auth",
> +		"https://auth.%s/token",
> +		"https://%s/token",
> +		NULL
> +	};
> +
> +	for (int i = 0; auth_patterns[i]; i++) {
> +		char *auth_url;
> +
> +		if (asprintf(&auth_url, auth_patterns[i], registry) == -1)
> +			continue;
> +
> +		auth_header = ocierofs_get_auth_token_with_url(oci, auth_url,
> +							      service, repository,
> +							      username, password);
> +		free(auth_url);
> +
> +		if (!IS_ERR(auth_header))
> +			return auth_header;
> +
> +		if (strcmp(registry, DOCKER_API_REGISTRY) &&
> +		    strcmp(registry, DOCKER_REGISTRY)) {
> +			break;
> +		}
> +	}
> +
> +	if (strcmp(registry, DOCKER_API_REGISTRY) &&
> +	    strcmp(registry, DOCKER_REGISTRY)) {
> +		return NULL;
> +	}
> +
> +	return ERR_PTR(-ENOENT);
> +}
> +
> +static char *ocierofs_get_manifest_digest(struct erofs_oci *oci,
> +					 const char *registry,
> +					 const char *repository, const char *tag,
> +					 const char *platform,
> +					 const char *auth_header)
> +{
> +	struct erofs_oci_request req = {};
> +	struct erofs_oci_response resp = {};
> +	json_object *root, *manifests, *manifest, *platform_obj, *arch_obj;
> +	json_object *os_obj, *digest_obj, *schema_obj, *media_type_obj;
> +	char *digest = NULL;
> +	const char *api_registry;
> +	int ret = 0, len, i;
> +
> +	if (!registry || !repository || !tag || !platform)
> +		return ERR_PTR(-EINVAL);
> +
> +	memset(&resp, 0, sizeof(resp));
> +
> +	api_registry = (!strcmp(registry, DOCKER_REGISTRY)) ? DOCKER_API_REGISTRY : registry;
> +
> +	if (asprintf(&req.url, "https://%s/v2/%s/manifests/%s",
> +	     api_registry, repository, tag) == -1) {
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
> +			ret = 0;
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
> +			ret = 0;
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
> +					     &platform_obj) &&
> +		    json_object_object_get_ex(platform_obj, "architecture",
> +					     &arch_obj) &&
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
> +				       const char *registry,
> +				       const char *repository,
> +				       const char *digest,
> +				       const char *auth_header,
> +				       int *layer_count)
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
> +	api_registry = (!strcmp(registry, DOCKER_REGISTRY)) ? DOCKER_API_REGISTRY : registry;
> +
> +	if (asprintf(&req.url, "https://%s/v2/%s/manifests/%s",
> +	     api_registry, repository, digest) == -1) {
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
> +static int ocierofs_extract_layer(struct erofs_oci *oci, struct erofs_importer *importer,
> +				 const char *layer_digest, const char *auth_header,
> +				 int layer_index)
> +{
> +	struct erofs_oci_request req = {};
> +	struct erofs_oci_stream stream = {};
> +	const char *api_registry;
> +	int ret, fd = -1;
> +	long http_code;
> +
> +	if (!oci || !importer || !layer_digest || layer_index < 0) {
> +		erofs_err("invalid parameters for layer extraction");
> +		return -EINVAL;
> +	}
> +
> +	memset(&stream, 0, sizeof(stream));
> +	stream.layer_index = layer_index;
> +
> +	stream.temp_fd = erofs_tmpfile();
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
> +	     api_registry, oci->params.repository,
> +	     layer_digest) == -1) {
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
> +	ret = ocierofs_curl_setup_request_ex(oci->curl, req.url,
> +					    OCIEROFS_HTTP_GET,
> +					    req.headers,
> +					    ocierofs_layer_write_callback,
> +					    &stream,
> +					    NULL, NULL);
> +	if (ret)
> +		goto out;
> +
> +	ret = ocierofs_curl_perform(oci->curl, &http_code);
> +	if (ret)
> +		goto out;
> +
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

Just some quick quesion:

  why we need dup a fd for this? the fd position is the same so
I don't see `dup` here is needed...

> +
> +	memset(&stream.tarfile, 0, sizeof(stream.tarfile));
> +	init_list_head(&stream.tarfile.global.xattrs);
> +

Thanks,
Gao Xiang


