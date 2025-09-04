Return-Path: <linux-erofs+bounces-973-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4E1B4359C
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Sep 2025 10:24:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cHXZL2K0Qz2yrZ;
	Thu,  4 Sep 2025 18:24:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756974250;
	cv=none; b=jYi8kgILxxDTF2//zziMW0dRkQ7V7kQD4BP+8W7BmStBOcmBHLNKHII765AqQY7wltk1kcIuxo4tC2L5bLcyctKOeZAmJ+KXSsMD/rh+iXgM2IZW8psApOC6T0BK2T+WgJr8KY+JbufmGYChKtdwYWv3CX3lWYUfa/x6ZFNZwXSNhWFZJzbeCnw1s6CpzSjzeUo9pRB7Fr8b39elE7mswQnwS7M3kaTGQrfm1c/gvOGYWMz/MUK4zIs2cEMa5dhzt2HoaNOcY2CqDYxvtexCKIYuT8xOX1h/9abKcMCVAkzWk9d1f7T4zljGwXuv8H1BmvErf6O2hBMbLwq5MghJaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756974250; c=relaxed/relaxed;
	bh=R/gML6l7liaDPTDvH3i8bd7LJZiUk3MWFeBrkf4jiCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wli2QH1BfOmka5RcPS3UsgPwcYdVMxWJYWNdKVWY7w0Ks4QCVFj/fJeVPEjqFOhOQwSkOkAlUxAL1cOlbExn5pFP6CC+vAsEWtjw/Ipfu1m+ZPUXuYTykFsWf0hy2+Q2GM3Xx8oNd65gdoN2+Jf7j1MXE6c78xCS94Nke4Ko+mICT3AbWAPawOo3ohGXwsYAfJD/eFNioyE0ngIiXg3+SKJ06KT86xtYaL052PzVFOLvwXIVqHEA6utnbLIogpLP9eJ89ZWFj6O8/QOKaq30ouWzCTakKSrp3WhwJHC5BdrjVgIWC6+g0lAZPxxckM80my/jTBb8sqORSIuyCOEujw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=oF288Pfi; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=oF288Pfi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cHXZH6wPBz2xd6
	for <linux-erofs@lists.ozlabs.org>; Thu,  4 Sep 2025 18:24:06 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756974242; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=R/gML6l7liaDPTDvH3i8bd7LJZiUk3MWFeBrkf4jiCw=;
	b=oF288PfiQBGCQW7Y8m+iDu9s/LnaxmPEbvB0D+0kVTuqogpwj0K2o9hVGdNnYwqEGLu7M2TAAExuQPtrCJBqZ+gk2Bn2uBmCi7fq/macuD9MKkSEl/Xzaqoiz7aSGij/iSp+BSEMLENimJvrBUatoUAsHOiE1TO6pd8/rOKIUpU=
Received: from 30.221.132.160(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WnF8WLb_1756974241 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 04 Sep 2025 16:24:01 +0800
Message-ID: <570f6803-b0e2-4a53-832e-976c43c317e5@linux.alibaba.com>
Date: Thu, 4 Sep 2025 16:24:00 +0800
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
Subject: Re: [PATCH v1] erofs-utils: add NBD-backed OCI image mounting
To: ChengyuZhu6 <hudson@cyzhu.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, Chengyu Zhu <hudsonzhu@tencent.com>
References: <20250904080624.57376-1-hudson@cyzhu.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250904080624.57376-1-hudson@cyzhu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/9/4 16:06, ChengyuZhu6 wrote:
> From: Chengyu Zhu <hudsonzhu@tencent.com>
> 
> - Add HTTP range downloads for OCI blobs
> - Introduce ocierofs_iostream for virtual file I/O
> - Add oci option for OCI image mounting with NBD backend
> 
> New mount.erofs -t erofs.nbd option: -o=[options] source-image mountpoint
> 
> Supported oci options:
> - oci.platform=os/arch (default: linux/amd64)
> - oci=N (extract specific layer, default: all layers)
> - oci.username/oci.password (basic authentication)
> 
> e.g.:
> sudo mount.erofs -t erofs.nbd  -o 'oci=0,oci.platform=linux/amd64' \
> quay.io/chengyuzhu6/golang:1.22.8-erofs /tmp/test/
> 
> Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
> ---
>   lib/liberofs_oci.h |  14 +++
>   lib/remotes/oci.c  | 249 ++++++++++++++++++++++++++++++++++++++++++++-
>   mount/Makefile.am  |   2 +-
>   mount/main.c       | 233 ++++++++++++++++++++++++++++++++++--------
>   4 files changed, 452 insertions(+), 46 deletions(-)
> 
> diff --git a/lib/liberofs_oci.h b/lib/liberofs_oci.h
> index 2896308..077b7f9 100644
> --- a/lib/liberofs_oci.h
> +++ b/lib/liberofs_oci.h
> @@ -55,6 +55,12 @@ struct ocierofs_ctx {
>   	int layer_count;
>   };
>   
> +struct ocierofs_iostream {
> +	struct ocierofs_ctx *ctx;
> +	struct erofs_vfile vf;
> +	u64 offset;
> +};
> +
>   int ocierofs_init(struct ocierofs_ctx *ctx, const struct ocierofs_config *config);
>   
>   /*
> @@ -67,6 +73,14 @@ int ocierofs_init(struct ocierofs_ctx *ctx, const struct ocierofs_config *config
>   int ocierofs_build_trees(struct erofs_importer *importer,
>   			 const struct ocierofs_config *cfg);
>   
> +int ocierofs_is_erofs_native_image(struct ocierofs_ctx *ctx);
> +
> +void ocierofs_ctx_cleanup(struct ocierofs_ctx *ctx);
> +
> +int ocierofs_iostream_open(struct ocierofs_iostream *oci_iostream, struct ocierofs_ctx *oci_ctx);
> +
> +void ocierofs_iostream_close(struct ocierofs_iostream *oci_iostream);
> +
>   #ifdef __cplusplus
>   }
>   #endif
> diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
> index f2b08b2..5c393e1 100644
> --- a/lib/remotes/oci.c
> +++ b/lib/remotes/oci.c
> @@ -33,6 +33,9 @@
>   #define OCI_MEDIATYPE_MANIFEST "application/vnd.oci.image.manifest.v1+json"
>   #define OCI_MEDIATYPE_INDEX "application/vnd.oci.image.index.v1+json"
>   
> +/* Erofs Native Layer Media Type */
> +#define EROFS_MEDIATYPE "application/vnd.erofs"
> +
>   struct ocierofs_request {
>   	char *url;
>   	struct curl_slist *headers;
> @@ -1161,7 +1164,7 @@ out:
>    * Clean up CURL handle, free all allocated string parameters, and
>    * reset the OCI context structure to a clean state.
>    */
> -static void ocierofs_ctx_cleanup(struct ocierofs_ctx *ctx)
> +void ocierofs_ctx_cleanup(struct ocierofs_ctx *ctx)
>   {
>   	if (!ctx)
>   		return;
> @@ -1226,3 +1229,247 @@ int ocierofs_build_trees(struct erofs_importer *importer,
>   	ocierofs_ctx_cleanup(&ctx);
>   	return ret;
>   }
> +
> +static int ocierofs_download_blob_range(struct ocierofs_ctx *ctx, off_t offset, size_t length,
> +					void **out_buf, size_t *out_size)
> +{
> +	struct ocierofs_request req = {};
> +	struct ocierofs_response resp = {};
> +	const char *api_registry;
> +	char rangehdr[64];
> +	long http_code = 0;
> +	int ret;
> +	int index = ctx->layer_index;
> +	u64 blob_size = ctx->layers[index]->size;
> +	size_t available;
> +	size_t copy_size;
> +
> +	if (offset < 0)
> +		return -EINVAL;
> +
> +	if (offset >= blob_size)
> +		return 0;
> +
> +	if (length && offset + (off_t)length > blob_size)
> +		length = (size_t)(blob_size - offset);
> +
> +	api_registry = ocierofs_get_api_registry(ctx->registry);
> +	if (asprintf(&req.url, "https://%s/v2/%s/blobs/%s",
> +	     api_registry, ctx->repository, ctx->layers[index]->digest) == -1)
> +		return -ENOMEM;
> +
> +	if (length)
> +		snprintf(rangehdr, sizeof(rangehdr), "Range: bytes=%lld-%lld",
> +			 (long long)offset, (long long)(offset + (off_t)length - 1));
> +	else
> +		snprintf(rangehdr, sizeof(rangehdr), "Range: bytes=%lld-",
> +			 (long long)offset);
> +
> +	if (ctx->auth_header && strstr(ctx->auth_header, "Bearer"))
> +		req.headers = curl_slist_append(req.headers, ctx->auth_header);
> +	req.headers = curl_slist_append(req.headers, rangehdr);
> +
> +	curl_easy_reset(ctx->curl);
> +
> +	ret = ocierofs_curl_setup_common_options(ctx->curl);
> +	if (ret)
> +		goto out;
> +
> +	ret = ocierofs_curl_setup_rq(ctx->curl, req.url, OCIEROFS_HTTP_GET,
> +				     req.headers,
> +				     ocierofs_write_callback,
> +				     &resp, NULL, NULL);
> +	if (ret)
> +		goto out;
> +
> +	ret = ocierofs_curl_perform(ctx->curl, &http_code);
> +	if (ret)
> +		goto out;
> +
> +	if (http_code == 206) {
> +		*out_buf = resp.data;
> +		*out_size = resp.size;
> +		resp.data = NULL;
> +		ret = 0;
> +	} else if (http_code == 200) {
> +		if (offset == 0) {

Never use `offset == 0` in the linux kernel style, use:

`if (!offset)` instead.


> +			*out_buf = resp.data;
> +			*out_size = resp.size;
> +			resp.data = NULL;
> +			ret = 0;
> +		} else {
> +			if (offset < resp.size) {
> +				available = resp.size - offset;
> +				copy_size = length ? min_t(size_t, length, available) : available;
> +
> +				*out_buf = malloc(copy_size);
> +				if (!*out_buf) {
> +					ret = -ENOMEM;
> +					goto out;
> +				}
> +				memcpy(*out_buf, resp.data + offset, copy_size);
> +				*out_size = copy_size;
> +				ret = 0;
> +			} else {
> +				ret = 0;
> +			}
> +		}
> +	} else {
> +		erofs_err("HTTP range request failed with code %ld", http_code);
> +		ret = -EIO;
> +	}
> +
> +out:
> +	if (req.headers)
> +		curl_slist_free_all(req.headers);
> +	free(req.url);
> +	free(resp.data);
> +	return ret;
> +}
> +
> +static ssize_t ocierofs_io_pread(struct erofs_vfile *vf, void *buf, size_t len, u64 offset)
> +{
> +	struct ocierofs_iostream *oci_iostream = *(struct ocierofs_iostream **)vf->payload;
> +	void *download_buf = NULL;
> +	size_t download_size = 0;
> +	ssize_t ret;
> +
> +	ret = ocierofs_download_blob_range(oci_iostream->ctx, offset, len,
> +					   &download_buf, &download_size);
> +	if (ret < 0) {
> +		memset(buf, 0, len);
> +		return len;
> +	}
> +
> +	if (download_buf && download_size > 0) {
> +		memcpy(buf, download_buf, download_size);
> +		free(download_buf);
> +		return download_size;
> +	}
> +
> +	return 0;
> +}
> +
> +static ssize_t ocierofs_io_read(struct erofs_vfile *vf, void *buf, size_t len)
> +{
> +	struct ocierofs_iostream *oci_iostream = *(struct ocierofs_iostream **)vf->payload;
> +	ssize_t ret;
> +
> +	ret = ocierofs_io_pread(vf, buf, len, oci_iostream->offset);
> +	if (ret > 0)
> +		oci_iostream->offset += ret;
> +
> +	return ret;
> +}
> +
> +static off_t ocierofs_io_lseek(struct erofs_vfile *vf, u64 offset, int whence)
> +{
> +	struct ocierofs_iostream *oci_iostream = *(struct ocierofs_iostream **)vf->payload;
> +	off_t new_offset;

	u64 new_offset;

> +	int layer_index = oci_iostream->ctx->layer_index;
> +

	new_offset = offset;

	switch (whence) {
	case SEEK_SET:
		break;
	case SEEK_CUR:
		new_offset += oci_iostream->offset;
		break;
	case SEEK_END:
		new_offset += oci_iostream->ctx->layers[layer_index]->size;
		break;
	default:
		return -EINVAL;
	}


> +	switch (whence) {
> +	case SEEK_SET:
> +		new_offset = offset;
> +		break;
> +	case SEEK_CUR:
> +		new_offset = oci_iostream->offset + offset;
> +		break;
> +	case SEEK_END:
> +		new_offset = oci_iostream->ctx->layers[layer_index]->size + offset;
> +		break;
> +	default:
> +		return -1;
> +	}
> +
> +	if (new_offset < 0 || new_offset > oci_iostream->ctx->layers[layer_index]->size)
> +		return -1;

No needed.

> +
> +	oci_iostream->offset = new_offset;
> +	return new_offset;
> +}
> +
> +static ssize_t ocierofs_io_sendfile(struct erofs_vfile *vout, struct erofs_vfile *vin,
> +			       off_t *pos, size_t count)
> +{
> +	struct ocierofs_iostream *oci_iostream = *(struct ocierofs_iostream **)vin->payload;
> +	char *buf = NULL;
> +	ssize_t total_written = 0;
> +	ssize_t ret = 0;
> +
> +	buf = malloc(min_t(size_t, count, 32768));

if it's only 32768 bytes, just allocate it on stack.

> +	if (!buf)
> +		return -ENOMEM;
> +
> +	while (count > 0) {
> +		size_t to_read = min_t(size_t, count, 32768);
> +		u64 read_offset = pos ? *pos : oci_iostream->offset;
> +
> +		ret = ocierofs_io_pread(vin, buf, to_read, read_offset);
> +		if (ret <= 0) {
> +			if (ret < 0)
> +				erofs_err("OCI I/O sendfile: failed to read from OCI: %s",
> +					  erofs_strerror(ret));
> +			memset(buf, 0, to_read);
> +			ret = to_read;
> +		}
> +
> +		ssize_t written = write(vout->fd, buf, ret);

Use erofs_io_write() instead.

> +
> +		if (written < 0) {
> +			erofs_err("OCI I/O sendfile: failed to write to output: %s",
> +				  strerror(errno));
> +			ret = -errno;
> +			break;
> +		}
> +
> +		if (written != ret) {
> +			erofs_err("OCI I/O sendfile: partial write: %zd != %zd", written, ret);
> +			ret = written;
> +		}
> +
> +		total_written += ret;
> +		count -= ret;
> +		if (pos)
> +			*pos += ret;
> +		else
> +			oci_iostream->offset += ret;
> +	}
> +
> +	free(buf);
> +	return count;
> +}
> +
> +static struct erofs_vfops ocierofs_io_vfops = {
> +	.pread = ocierofs_io_pread,
> +	.read = ocierofs_io_read,
> +	.lseek = ocierofs_io_lseek,
> +	.sendfile = ocierofs_io_sendfile,
> +};
> +
> +int ocierofs_iostream_open(struct ocierofs_iostream *oci_iostream, struct ocierofs_ctx *oci_ctx)
> +{
> +	memset(oci_iostream, 0, sizeof(*oci_iostream));

	*oci_iostream = (struct ocierofs_iostream){};

> +	oci_iostream->ctx = oci_ctx;
> +	oci_iostream->vf.ops = &ocierofs_io_vfops;
> +	oci_iostream->vf.fd = -1;

No need `oci_iostream->vf.fd = -1`.

> +	*(struct ocierofs_iostream **)oci_iostream->vf.payload = oci_iostream;
> +
> +	return 0;
> +}
> +
> +void ocierofs_iostream_close(struct ocierofs_iostream *oci_iostream)
> +{
> +	close(oci_iostream->vf.fd);

Why close the invalid fd?

> +}
> +
> +int ocierofs_is_erofs_native_image(struct ocierofs_ctx *ctx)
> +{
> +	if (ctx->layer_count > 0 && ctx->layers[0] &&
> +	    ctx->layers[0]->media_type) {
> +		if (strcmp(ctx->layers[0]->media_type, EROFS_MEDIATYPE) != 0)
> +			return -ENOENT;
> +		return 0;
> +	}
> +	return -ENOENT;
> +}
> diff --git a/mount/Makefile.am b/mount/Makefile.am
> index d93f3f4..0b4447f 100644
> --- a/mount/Makefile.am
> +++ b/mount/Makefile.am
> @@ -9,5 +9,5 @@ mount_erofs_SOURCES = main.c
>   mount_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
>   mount_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
>   	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} \
> -	${libzstd_LIBS} ${libqpl_LIBS} ${libxxhash_LIBS} ${libnl3_LIBS}
> +	${libzstd_LIBS} ${libqpl_LIBS} ${libxxhash_LIBS} ${libnl3_LIBS} ${openssl_LIBS}
>   endif
> diff --git a/mount/main.c b/mount/main.c
> index a270f0a..3af4d63 100644
> --- a/mount/main.c
> +++ b/mount/main.c
> @@ -15,6 +15,7 @@
>   #include "erofs/err.h"
>   #include "erofs/io.h"
>   #include "../lib/liberofs_nbd.h"
> +#include "../lib/liberofs_oci.h"
>   #ifdef HAVE_LINUX_LOOP_H
>   #include <linux/loop.h>
>   #else
> @@ -34,6 +35,10 @@ struct loop_info {
>   #include <sys/sysmacros.h>
>   #endif
>   
> +#ifdef OCIEROFS_ENABLED
> +static struct ocierofs_config ocicfg;
> +#endif
> +
>   enum erofs_backend_drv {
>   	EROFSAUTO,
>   	EROFSLOCAL,
> @@ -56,12 +61,76 @@ static struct erofsmount_cfg {
>   	long flags;
>   	enum erofs_backend_drv backend;
>   	enum erofsmount_mode mountmode;
> +#ifdef OCIEROFS_ENABLED
> +	bool use_oci;
> +#endif
>   } mountcfg = {
>   	.full_options = "ro",
>   	.flags = MS_RDONLY,		/* default mountflags */
>   	.fstype = "erofs",
>   };
>   
> +enum erofs_nbd_source_type {
> +	EROFSNBD_SOURCE_LOCAL,
> +	EROFSNBD_SOURCE_OCI,
> +};
> +
> +union erofs_nbd_source {
> +	const char *device_path;
> +	struct ocierofs_ctx *oci_ctx;
> +};
> +
> +union erofs_nbd_source src;
> +
> +static int parse_oci_option(struct ocierofs_config *oci_cfg, const char *option)

static int erofsmount_parse_oci_option(....)

> +{
> +	char *p;
> +
> +	p = strstr(option, "oci=");
> +	if (p != NULL) {
> +		p += strlen("oci=");
> +		{
> +			char *endptr;
> +			unsigned long v = strtoul(p, &endptr, 10);
> +
> +			if (endptr == p || *endptr != '\0')
> +				return -EINVAL;
> +			oci_cfg->layer_index = (int)v;
> +		}
> +	} else {
> +		p = strstr(option, "oci.platform=");
> +		if (p != NULL) {
> +			p += strlen("oci.platform=");
> +			free(oci_cfg->platform);
> +			oci_cfg->platform = strdup(p);
> +			if (!oci_cfg->platform)
> +				return -ENOMEM;
> +		} else {
> +			p = strstr(option, "oci.username=");
> +			if (p != NULL) {
> +				p += strlen("oci.username=");
> +				free(oci_cfg->username);
> +				oci_cfg->username = strdup(p);
> +				if (!oci_cfg->username)
> +					return -ENOMEM;
> +			} else {
> +				p = strstr(option, "oci.password=");
> +				if (p != NULL) {
> +					p += strlen("oci.password=");
> +					free(oci_cfg->password);
> +					oci_cfg->password = strdup(p);
> +					if (!oci_cfg->password)
> +						return -ENOMEM;
> +				} else {
> +					return -EINVAL;
> +				}
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>   static long erofsmount_parse_flagopts(char *s, long flags, char **more)
>   {
>   	static const struct {
> @@ -90,29 +159,41 @@ static long erofsmount_parse_flagopts(char *s, long flags, char **more)
>   		comma = strchr(s, ',');
>   		if (comma)
>   			*comma = '\0';
> -		for (i = 0; i < ARRAY_SIZE(opts); ++i) {
> -			if (!strcasecmp(s, opts[i].name)) {
> -				if (opts[i].flags < 0)
> -					flags &= opts[i].flags;
> -				else
> -					flags |= opts[i].flags;
> -				break;
> -			}
> -		}
>   
> -		if (more && i >= ARRAY_SIZE(opts)) {
> -			int sl = strlen(s);
> -			char *new = *more;
> +		if (strncmp(s, "oci", 3) == 0) {
> +#ifdef OCIEROFS_ENABLED
> +			int err = parse_oci_option(&ocicfg, s);
>   
> -			i = new ? strlen(new) : 0;
> -			new = realloc(new, i + strlen(s) + 2);
> -			if (!new)
> -				return -ENOMEM;
> -			if (i)
> -				new[i++] = ',';
> -			memcpy(new + i, s, sl);
> -			new[i + sl] = '\0';
> -			*more = new;
> +			if (err < 0)
> +				return err;
> +#else
> +			return -EINVAL;
> +#endif

		if (!strncmp(s, "oci", 3)) {
			int err = erofsmount_parse_oci_option(&ocicfg, s);

			if (ret < 0)
				return err;
			continue;			
		}

Thanks,
Gao Xiang

