Return-Path: <linux-erofs+bounces-864-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9477AB30C50
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Aug 2025 05:10:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c7QD40pxcz30WS;
	Fri, 22 Aug 2025 13:10:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.66
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755832212;
	cv=none; b=NsBPbUZwr2xtiRjNzjlXdLQI54P9CgJ/oOo95FX5v4QlqIB4Nl7U9ta/BbY/PetkYUwFDjqDhtGRS8n58Fe5L6MpgKhb7elXXMJeWBNwkj1yxH7gWqCRwk1BMnaOkQ39ptC+HOyXFkL8TDIsjpSVaO+zlCiPkWQn+Wvf7LlEr3yawuke9BEZRNq7UAYkY4DvoJ+GPaND2tYhQ4w8MKYb2+iRxQTmzG8B4SyabWxtUDWxHm1yve63IN491voviOSjtpoQ3IU9Ncwi3//ZkzAE+uHiXJlky/YHed4Wo2SVsBFkmIPladIHzwRv9ZQbbdIh+MWnK25+82+UB9KFH0l2UA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755832212; c=relaxed/relaxed;
	bh=AdTDHbN5V50Jigzqcx/PPgNdbvP7tCjhZOgfnKyitXI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Wj7uAFQKH/teiVfflyGciqaGUVMcGpZe4mPCvAQq2M2UHs7D+2qiW/RmQ5WN9TrEZbeQMuixswvXHEvdTD+rWmaPeTsYewmyIciklsdzzc315znTjOZ37PzC2IV+SKgYUvXiv+S7SCcS/EIF6WIkfLTXRBNMt39yY3tohtsTKyn/ZuI9LD7PY4dnRplpP4gWa7wdBb6wgCPqP34374TAyz/Vm+GINz644MN4Zla2j86OSaScKZOGaurO6XWiJuOoa0084uJuobtT5mAH1r/gfYKobPE4yzXe+djf4X61LohsIKNF4+9lCkOwFFDn6y6gr85+F7Z4TkvxxrVhCwg2jg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.66; helo=out28-66.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.66; helo=out28-66.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-66.mail.aliyun.com (out28-66.mail.aliyun.com [115.124.28.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c7QD175Mnz30Vq
	for <linux-erofs@lists.ozlabs.org>; Fri, 22 Aug 2025 13:10:07 +1000 (AEST)
Received: from smtpclient.apple(mailfrom:hudson@cyzhu.com fp:SMTPD_---.eMZNNrL_1755832202 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 22 Aug 2025 11:10:03 +0800
Content-Type: text/plain;
	charset=utf-8
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH 1/1] erofs-utils: add OCI registry support
From: hudsonZhu <hudson@cyzhu.com>
In-Reply-To: <4de3eb31-9368-4512-a9e4-a2f65f30edb0@linux.alibaba.com>
Date: Fri, 22 Aug 2025 11:09:52 +0800
Cc: linux-erofs@lists.ozlabs.org,
 xiang@kernel.org,
 Changzhi Xie <sa.z@qq.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5189EEE5-2FA1-464C-8069-EA01AEAEB9D3@cyzhu.com>
References: <20250821073258.89073-1-hudson@cyzhu.com>
 <4de3eb31-9368-4512-a9e4-a2f65f30edb0@linux.alibaba.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-Spam-Status: No, score=0.0 required=3.0 tests=RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Xiang,

> The author doesn't seem to be updated, you could
>=20
> `git commit --amend --author=3D"Chengyu Zhu <hudson@cyzhu.com>=E2=80=9D`=

Done.

>> This patch adds support for building EROFS filesystems from =
OCI-compliant
>=20
> 72-char per line.
Fixed.

>=20
> Is it possible to enable anonymous access if username/password
> are not specified?
Yes, the new patch works.

> Your `Signed-off-by` needs to the last line of the commit message
> since you sent out the email:

Fixed.

> Can we make those string as dynamic allocated?
> Hard-coded strings look dangerous.
Done.

> is it possible to rename it as `struct erofs_oci_params`?
Done.

> What's the difference between
> OCI_AUTH_ANONYMOUS
> and
> anonymous_access?

There isn=E2=80=99t a functional difference. anonymous_access was only =
used to capture the =E2=80=9Canonymous=E2=80=9D input, which duplicated =
OCI_AUTH_ANONYMOUS. I=E2=80=99ve removed anonymous_access and now rely =
solely on OCI_AUTH_ANONYMOUS.=20

> and then make
>=20
> struct erofs_oci {
> 	CURL *curl;
> 	struct erofs_oci_params *params;
> };
Done.

>> +/* Layer information */
>=20
> The comment can be droped since it's obvious.
Removed.

>> +	} else {
>> +		snprintf(req.url, sizeof(req.url),
>> +			 =
"https://%s/token?service=3D%s&scope=3Drepository:%s:pull",
>> +			 registry, registry, repository);
>> +	}
>=20
> You could use asprintf to allocate dynamic strings=E2=80=A6
Done.

>> +	struct erofs_tarfile tarfile;
>=20
> 	what's the purpose of `struct erofs_tarfile`?

It's used by the tarerofs_parse_tar() function to iterate through tar =
archive entries and extract file information.

Thanks,
Chengyu Zhu

>=20
> 2025=E5=B9=B48=E6=9C=8821=E6=97=A5 15:52=EF=BC=8CGao Xiang =
<hsiangkao@linux.alibaba.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Hi Chengyu,
>=20
> On 2025/8/21 15:32, ChengyuZhu6 wrote:
>=20
> Thanks for the patch!
>=20
> The author doesn't seem to be updated, you could
>=20
> `git commit --amend --author=3D"Chengyu Zhu <hudson@cyzhu.com>"`
>=20
> or just use `git config` for global update.
>=20
>> This patch adds support for building EROFS filesystems from =
OCI-compliant
>=20
> 72-char per line.
>=20
>> container registries, enabling users to create EROFS images directly =
from
>> container images stored in registries like Docker Hub, Quay.io, etc.
>> The implementation includes:
>> - OCI remote backend with registry authentication support
>> - Manifest parsing for Docker v2 and OCI v1 formats
>> - Layer extraction and tar processing integration
>> - Multi-platform image selection capability
>> - Both anonymous and authenticated registry access
>> - Comprehensive build system integration
>> New mkfs.erofs option: --oci=3Dregistry/repo:tag[,options]
>> Supported options:
>> - platform=3Dos/arch (default: linux/amd64)
>> - layer=3DN (extract specific layer, default: all layers)
>> - anonymous (use anonymous access)
>=20
> Is it possible to enable anonymous access if username/password
> are not specified?
>=20
>> - username/password (basic authentication)
>> Signed-off-by: Chengyu Zhu <hudson@cyzhu.com>
>> Signed-off-by: Changzhi Xie <sa.z@qq.com>
>=20
> Your `Signed-off-by` needs to the last line of the commit message
> since you sent out the email:
>=20
> Signed-off-by: Changzhi Xie <sa.z@qq.com>
> Signed-off-by: Chengyu Zhu <hudson@cyzhu.com>
>=20
>> ---
>=20
> ...
>=20
>=20
>> diff --git a/lib/liberofs_oci.h b/lib/liberofs_oci.h
>> new file mode 100644
>> index 0000000..8ed98d7
>> --- /dev/null
>> +++ b/lib/liberofs_oci.h
>> @@ -0,0 +1,73 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
>> +/*
>> + * Copyright (C) 2025 Tencent, Inc.
>> + *             http://www.tencent.com/
>> + */
>> +#ifndef __EROFS_OCI_H
>> +#define __EROFS_OCI_H
>> +
>> +#include <stdbool.h>
>> +
>> +#ifdef __cplusplus
>> +extern "C" {
>> +#endif
>> +
>> +struct erofs_inode;
>> +
>> +/* OCI authentication modes */
>> +enum oci_auth_mode {
>> +	OCI_AUTH_ANONYMOUS,	/* No authentication */
>> +	OCI_AUTH_TOKEN,		/* Bearer token authentication */
>> +	OCI_AUTH_BASIC,		/* Basic authentication */
>> +};
>> +
>> +/* Maximum lengths for OCI parameters */
>> +#define OCI_REGISTRY_LEN		256
>> +#define OCI_REPOSITORY_LEN		256
>> +#define OCI_TAG_LEN			64
>> +#define OCI_PLATFORM_LEN		32
>> +#define OCI_USERNAME_LEN		64
>> +#define OCI_PASSWORD_LEN		256
>=20
> Can we make those string as dynamic allocated?
> Hard-coded strings look dangerous.
>=20
>> +
>> +/**
>> + * struct erofs_oci - OCI configuration
>> + * @registry:         registry hostname (e.g., =
"registry-1.docker.io")
>> + * @repository:       image repository (e.g., "library/ubuntu")
>> + * @tag:              image tag or digest (e.g., "latest" or =
sha256:...)
>> + * @platform:         target platform in "os/arch" format (e.g., =
"linux/amd64")
>> + * @username:         username for basic authentication
>> + * @password:         password for basic authentication
>> + * @auth_mode:        authentication mode to use
>> + * @layer_index:      specific layer to extract (-1 for all layers)
>> + * @anonymous_access: whether to use anonymous access
>> + */
>> +struct erofs_oci {
>=20
> is it possible to rename it as `struct erofs_oci_params`?
>=20
>> +	char registry[OCI_REGISTRY_LEN + 1];
>> +	char repository[OCI_REPOSITORY_LEN + 1];
>> +	char tag[OCI_TAG_LEN + 1];
>> +	char platform[OCI_PLATFORM_LEN + 1];
>> +	char username[OCI_USERNAME_LEN + 1];
>> +	char password[OCI_PASSWORD_LEN + 1];
>> +=09
>> +	enum oci_auth_mode auth_mode;
>=20
> What's the difference between
> OCI_AUTH_ANONYMOUS
> and
> anonymous_access?
>=20
>> +	int layer_index;
>> +	bool anonymous_access;
>> +};
>> +
>> +/**
>> + * ocierofs_build_trees - Build file trees from OCI container image =
layers
>> + * @root:     root inode to build the file tree under
>> + * @oci:      OCI configuration
>> + * @ref:      reference string (unused, kept for API compatibility)
>> + * @fillzero: if true, only create inodes without downloading actual =
data
>> + *
>> + * Return: 0 on success, negative errno on failure
>> + */
>> +int ocierofs_build_trees(struct erofs_inode *root, struct erofs_oci =
*oci,
>> +			 const char *ref, bool fillzero);
>> +
>> +#ifdef __cplusplus
>> +}
>> +#endif
>> +
>> +#endif /* __EROFS_OCI_H */
>> diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
>> new file mode 100644
>> index 0000000..e86af50
>> --- /dev/null
>> +++ b/lib/remotes/oci.c
>> @@ -0,0 +1,665 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
>> +/*
>> + * Copyright (C) 2025 Tencent, Inc.
>> + *             http://www.tencent.com/
>> + */
>> +#define _GNU_SOURCE
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <string.h>
>> +#include <unistd.h>
>> +#include <fcntl.h>
>> +#include <sys/types.h>
>> +#include <sys/stat.h>
>> +#include <errno.h>
>> +#include <curl/curl.h>
>> +#include <json-c/json.h>
>> +#include "erofs/internal.h"
>> +#include "erofs/print.h"
>> +#include "erofs/inode.h"
>> +#include "erofs/blobchunk.h"
>> +#include "erofs/diskbuf.h"
>> +#include "erofs/rebuild.h"
>> +#include "erofs/tar.h"
>> +#include "liberofs_oci.h"
>> +
>> +/* Constants */
>> +#define OCI_URL_MAX_LEN			8192
>> +#define OCI_AUTH_HEADER_MAX_LEN		1024
>> +#define OCI_TEMP_FILENAME_MAX_LEN	256
>> +
>> +/* Media types */
>> +#define DOCKER_MEDIATYPE_MANIFEST_V2	=
"application/vnd.docker.distribution.manifest.v2+json"
>> +#define DOCKER_MEDIATYPE_MANIFEST_V1	=
"application/vnd.docker.distribution.manifest.v1+json"
>> +#define DOCKER_MEDIATYPE_MANIFEST_LIST	=
"application/vnd.docker.distribution.manifest.list.v2+json"
>> +#define OCI_MEDIATYPE_MANIFEST		=
"application/vnd.oci.image.manifest.v1+json"
>> +#define OCI_MEDIATYPE_INDEX		=
"application/vnd.oci.image.index.v1+json"
>> +
>> +/* Registry constants */
>> +#define DOCKER_REGISTRY			"docker.io"
>> +#define DOCKER_API_REGISTRY		"registry-1.docker.io"
>> +#define QUAY_REGISTRY			"quay.io"
>> +
>> +/* Global CURL handle */
>> +static CURL *g_curl;
>=20
> and then make
>=20
> struct erofs_oci {
> 	CURL *curl;
> 	struct erofs_oci_params *params;
> };
>=20
> As a OCI context (it can be used for multiple instance usage
> such as runtime lazy loading.)
>=20
>> +> +/* HTTP request/response structures */
>> +struct oci_request {
>> +	char url[OCI_URL_MAX_LEN];
>> +	struct curl_slist *headers;
>> +};
>=20
> struct erofs_oci_request {
> };
>=20
>> +
>> +struct oci_response {
>=20
> erofs_oci_response...
>=20
>> +	char *data;
>> +	size_t size;
>> +	long http_code;
>> +};
>> +
>> +/* Layer information */
>=20
> The comment can be droped since it's obvious.
>=20
>> +struct oci_layer {
>=20
> erofs_oci_layer {
>=20
>> +	char *digest;
>> +	u64 size;
>> +	const char *media_type;
>> +};
>> +
>> +/* Layer streaming context */
>> +struct oci_stream {
>=20
> Same here.
>=20
>> +	struct erofs_tarfile tarfile;
>=20
> 	what's the purpose of `struct erofs_tarfile`?
>=20
>> +	FILE *temp_file;
>> +	char temp_filename[OCI_TEMP_FILENAME_MAX_LEN];
>> +	int layer_index;
>> +};
>> +
>> +/* Callback for writing response data to memory */
>> +static size_t oci_write_callback(void *contents, size_t size, size_t =
nmemb, void *userp)
>> +{
>> +	size_t realsize =3D size * nmemb;
>> +	struct oci_response *resp =3D userp;
>> +	char *ptr;
>> +
>> +	ptr =3D realloc(resp->data, resp->size + realsize + 1);
>> +	if (!ptr)
>> +		return 0;
>> +
>> +	resp->data =3D ptr;
>> +	memcpy(&resp->data[resp->size], contents, realsize);
>> +	resp->size +=3D realsize;
>> +	resp->data[resp->size] =3D '\0';
>> +	return realsize;
>> +}
>> +
>> +/* Callback for writing layer data to file */
>> +static size_t oci_layer_write_callback(void *contents, size_t size, =
size_t nmemb, void *userp)
>> +{
>> +	struct oci_stream *stream =3D userp;
>> +	size_t realsize =3D size * nmemb;
>> +=09
>> +	if (!stream->temp_file)
>> +		return 0;
>> +	=09
>> +	if (fwrite(contents, 1, realsize, stream->temp_file) !=3D =
realsize) {
>> +		erofs_err("failed to write layer data for layer %d", =
stream->layer_index);
>> +		return 0;
>> +	}
>> +=09
>> +	return realsize;
>> +}
>> +
>> +/* Perform HTTP request */
>> +static int oci_request_perform(struct oci_request *req, struct =
oci_response *resp)
>> +{
>> +	CURLcode res;
>> +=09
>> +	erofs_dbg("requesting URL: %s", req->url);
>> +=09
>> +	curl_easy_setopt(g_curl, CURLOPT_URL, req->url);
>> +	curl_easy_setopt(g_curl, CURLOPT_WRITEDATA, resp);
>> +	curl_easy_setopt(g_curl, CURLOPT_WRITEFUNCTION, =
oci_write_callback);
>> +=09
>> +	if (req->headers)
>> +		curl_easy_setopt(g_curl, CURLOPT_HTTPHEADER, =
req->headers);
>> +
>> +	res =3D curl_easy_perform(g_curl);
>> +	if (res !=3D CURLE_OK) {
>> +		erofs_err("curl request failed: %s", =
curl_easy_strerror(res));
>> +		return -EIO;
>> +	}
>> +
>> +	res =3D curl_easy_getinfo(g_curl, CURLINFO_RESPONSE_CODE, =
&resp->http_code);
>> +	if (res !=3D CURLE_OK) {
>> +		erofs_err("failed to get HTTP response code: %s", =
curl_easy_strerror(res));
>> +		return -EIO;
>> +	}
>> +
>> +	if (resp->http_code < 200 || resp->http_code >=3D 300) {
>> +		erofs_err("HTTP request failed with code %ld", =
resp->http_code);
>> +		return -EIO;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/* Get authentication token */
>> +static char *oci_get_auth_token(const char *registry, const char =
*repository,
>> +				const char *username, const char =
*password)
>> +{
>> +	struct oci_request req =3D {};
>> +	struct oci_response resp =3D {};
>> +	json_object *root, *token_obj;
>> +	const char *token;
>> +	char *auth_header =3D NULL;
>> +	int ret;
>> +
>> +	if (!registry || !repository)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	if (!strcmp(registry, DOCKER_API_REGISTRY) || !strcmp(registry, =
DOCKER_REGISTRY)) {
>> +		snprintf(req.url, sizeof(req.url),
>> +			 =
"https://auth.docker.io/token?service=3Dregistry.docker.io&scope=3Dreposit=
ory:%s:pull",
>> +			 repository);
>> +	} else if (!strcmp(registry, QUAY_REGISTRY)) {
>> +		snprintf(req.url, sizeof(req.url),
>> +			 =
"https://%s/v2/auth?service=3D%s&scope=3Drepository:%s:pull",
>> +			 QUAY_REGISTRY, QUAY_REGISTRY, repository);
>> +	} else {
>> +		snprintf(req.url, sizeof(req.url),
>> +			 =
"https://%s/token?service=3D%s&scope=3Drepository:%s:pull",
>> +			 registry, registry, repository);
>> +	}
>=20
> You could use asprintf to allocate dynamic strings...
>=20
>=20
> ...
>=20
>>  		case 'V':
>>  			version();
>> @@ -1638,7 +1775,8 @@ int main(int argc, char **argv)
>>  		erofs_uuid_generate(g_sbi.uuid);
>>    	if ((source_mode =3D=3D EROFS_MKFS_SOURCE_TAR && =
!erofstar.index_mode) ||
>> -	    (source_mode =3D=3D EROFS_MKFS_SOURCE_S3)) {
>> +	    (source_mode =3D=3D EROFS_MKFS_SOURCE_S3) ||
>> +	    (source_mode =3D=3D EROFS_MKFS_SOURCE_OCI)) {
>>  		err =3D erofs_diskbuf_init(1);
>>  		if (err) {
>>  			erofs_err("failed to initialize diskbuf: %s",
>> @@ -1756,12 +1894,27 @@ int main(int argc, char **argv)
>>  					dataimport_mode =3D=3D =
EROFS_MKFS_DATA_IMPORT_ZEROFILL);
>>  			if (err)
>>  				goto exit;
>> +#endif
>> +#ifdef OCIEROFS_ENABLED
>> +		} else if (source_mode =3D=3D EROFS_MKFS_SOURCE_OCI) {
>> +			if (incremental_mode ||
>> +			    dataimport_mode =3D=3D =
EROFS_MKFS_DATA_IMPORT_RVSP)
>> +				err =3D -EOPNOTSUPP;
>> +			else
>> +				err =3D ocierofs_build_trees(root, =
&ocicfg,
>> +							   =
cfg.c_src_path,
>> +					dataimport_mode =3D=3D =
EROFS_MKFS_DATA_IMPORT_ZEROFILL);
>> +			if (err)
>> +				goto exit;
>> +			erofs_info("OCI build_trees completed, starting =
filesystem construction");
>>  #endif
>>  		}
>>  +		erofs_info("Starting erofs_rebuild_dump_tree...");
>=20
> The debugging info can be removed..
>=20
>>  		err =3D erofs_rebuild_dump_tree(root, incremental_mode);
>>  		if (err)
>>  			goto exit;
>> +		erofs_info("erofs_rebuild_dump_tree completed");
>=20
> Same here.
>=20
> Thanks,
> Gao Xiang


