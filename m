Return-Path: <linux-erofs+bounces-981-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB581B48752
	for <lists+linux-erofs@lfdr.de>; Mon,  8 Sep 2025 10:36:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cL0f81L4Dz2xQ0;
	Mon,  8 Sep 2025 18:36:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757320560;
	cv=none; b=XDeXWDc1LkM1gsxF1dU+q0D4WL6qShc+LoDsQI09kO2DwhLJJ7g+UeESqCGFDtwcymH1CMeSHxfGnm2YPTDjDHBrnlVkN4DZ2ZnN1C8jx5fkmjEz3Pp/JcLe1Rww48qBNz2j7TzxUqCg/39RLxJxR4lOODOn1C+32bybxS6TjO0nOy/S6ZZSGJaS7tXdaycK8fNGFrItLmbSLgznmHKDS2NDnYRcmwBQzFoB//P2kRP/vx9dPTu8FkemBWdAIbbTMEgIRJS031knfdYfbOO16Cryhy+Rm1C5KWg9BaD4jChjXhXv6BA3Kp1GT2vxEGX/A2mhy1LMOAmTaJas69bIKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757320560; c=relaxed/relaxed;
	bh=oBmKo4TaokKAaRTJFMnB5tm4Wmm309eUC+vBn6tExSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PenChpDkUfkOSlV5DtKn3sfzapggSMJVIjGYUyhnw3z9qel2lhdaCWlrAs3RaIhCIG0CkPW5RH+SSQxfQOQA6WVZL+xTQgWh3M8M+RNSW3o2QpKXmN9v0/59B2Up0+VoV9B+z78hSbmaQUwZC7C4eqg6+AJeBQfZKx/HxkXjEPQ4+nc/aDF8VMlevf5TI8FC1yDMGQaZc1IZXAwn/8d5SRYPJpTuMF7fIFywnKLwqFtH6/1vrXqRsKfXtUHL2Pj0qPgbV45QJhHhhxRzndykM8yHguW0s98kmGoVRWX8zE9bfWBpdTdhnUdDcSKgWqJLxhF/rpjSuur9fYVmwRq4OA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bZMhWA2L; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bZMhWA2L;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cL0f52PlBz2xPy
	for <linux-erofs@lists.ozlabs.org>; Mon,  8 Sep 2025 18:35:54 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757320542; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=oBmKo4TaokKAaRTJFMnB5tm4Wmm309eUC+vBn6tExSs=;
	b=bZMhWA2Lhpmj25HVAXzrVObF43Eq5aZZcnYO/o9w3cPAnl4SWsxiZ1s7tYljhQ0cZZ/EQOeCg6jajWAlyJtbZ2d1pWC45BlUG7VrSLEK6szYsbdwhyObDWQbh3Dl3FqwCbglEqwwk5PcLbtskA7vYoDbbhvjq4s1VmNYogop8uY=
Received: from 30.221.130.235(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WnTxkzU_1757320540 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 08 Sep 2025 16:35:41 +0800
Message-ID: <799913f4-39a6-48f8-9aaf-a43b425fab71@linux.alibaba.com>
Date: Mon, 8 Sep 2025 16:35:40 +0800
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
Subject: Re: [PATCH v2] erofs-utils: add NBD-backed OCI image mounting
To: ChengyuZhu6 <hudson@cyzhu.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, Chengyu Zhu <hudsonzhu@tencent.com>
References: <20250904100719.31892-1-hudson@cyzhu.com>
 <20250905143021.91960-1-hudson@cyzhu.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250905143021.91960-1-hudson@cyzhu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Chengyu,

On 2025/9/5 22:30, ChengyuZhu6 wrote:
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
> quay.io/chengyuzhu6/golang:1.22.8-erofs /mnt
> 
> Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>

Sorry for late reply.

> ---
>   lib/liberofs_oci.h |   8 +-
>   lib/remotes/oci.c  | 247 ++++++++++++++++++++++++++++++++++++++++++++-
>   mount/Makefile.am  |   2 +-
>   mount/main.c       | 196 +++++++++++++++++++++++++++--------
>   4 files changed, 406 insertions(+), 47 deletions(-)
> 
> diff --git a/lib/liberofs_oci.h b/lib/liberofs_oci.h
> index 2896308..873a560 100644
> --- a/lib/liberofs_oci.h
> +++ b/lib/liberofs_oci.h
> @@ -55,7 +55,11 @@ struct ocierofs_ctx {
>   	int layer_count;
>   };
>   
> -int ocierofs_init(struct ocierofs_ctx *ctx, const struct ocierofs_config *config);
> +struct ocierofs_iostream {
> +	struct ocierofs_ctx *ctx;
> +	struct erofs_vfile vf;

Why need this?

> +	u64 offset;
> +};
>   
>   /*
>    * ocierofs_build_trees - Build file trees from OCI container image layers
> @@ -67,6 +71,8 @@ int ocierofs_init(struct ocierofs_ctx *ctx, const struct ocierofs_config *config
>   int ocierofs_build_trees(struct erofs_importer *importer,
>   			 const struct ocierofs_config *cfg);
>   
> +int ocierofs_io_open(struct erofs_vfile *vf, const struct ocierofs_config *cfg);
> +
>   #ifdef __cplusplus
>   }
>   #endif
> diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
> index f2b08b2..ba01a0e 100644
> --- a/lib/remotes/oci.c
> +++ b/lib/remotes/oci.c
> @@ -16,6 +16,7 @@
>   #include <json-c/json.h>
>   #include "erofs/importer.h"
>   #include "erofs/internal.h"
> +#include "erofs/io.h"
>   #include "erofs/print.h"
>   #include "erofs/tar.h"
>   #include "liberofs_oci.h"
> @@ -33,6 +34,8 @@
>   #define OCI_MEDIATYPE_MANIFEST "application/vnd.oci.image.manifest.v1+json"
>   #define OCI_MEDIATYPE_INDEX "application/vnd.oci.image.index.v1+json"
>   
> +#define OCIEROFS_IO_CHUNK_SIZE 32768
> +
>   struct ocierofs_request {
>   	char *url;
>   	struct curl_slist *headers;
> @@ -1032,7 +1035,7 @@ static int ocierofs_parse_ref(struct ocierofs_ctx *ctx, const char *ref_str)
>    *
>    * Return: 0 on success, negative errno on failure
>    */
> -int ocierofs_init(struct ocierofs_ctx *ctx, const struct ocierofs_config *config)
> +static int ocierofs_init(struct ocierofs_ctx *ctx, const struct ocierofs_config *config)
>   {
>   	int ret;
>   
> @@ -1226,3 +1229,245 @@ int ocierofs_build_trees(struct erofs_importer *importer,
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

It's possible that NBD reads offset >= blob_size here, so I think you
should

	if (offset >= blob_size) {
		*out_size = 0;
		return 0;
	}

here.

> +		return 0;
> +
> +	if (length && offset + (off_t)length > blob_size)


		why `(off_t)length`? since length is already `off_t`.


> +		length = (size_t)(blob_size - offset);


	if (offset + length > blob_size)
		length = blob_size - offset.

?

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

		ret = 0;

> +		if (!offset) {
> +			*out_buf = resp.data;
> +			*out_size = resp.size;
> +			resp.data = NULL;
> +			ret = 0;
> +		} else {

		} else if (offset < resp.size) {
			available = resp.size - offset;
			...
		}

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

...

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
> index 2826dac..359dbbf 100644
> --- a/mount/main.c
> +++ b/mount/main.c
> @@ -15,6 +15,7 @@

...


> +

>   
>   			err = IS_ERR(id) ? PTR_ERR(id) :
> @@ -789,9 +887,19 @@ int main(int argc, char *argv[])
>   	}
>   
>   	if (mountcfg.backend == EROFSNBD) {
> -		err = erofsmount_nbd(mountcfg.device, mountcfg.target,
> -				     mountcfg.fstype, mountcfg.flags,
> -				     mountcfg.options);
> +		if (mountcfg.use_oci) {
> +			struct erofs_vfile vfile = {};

Could you just move this to
	ocierofs_io_open() instead?

e.g.
	vfile = (struct erofs_vfile){.ops = &ocierofs_io_vfops};
	*(struct ocierofs_iostream **)vfile->payload = oci_iostream;

> +
> +			ocicfg.image_ref = mountcfg.device;
> +			src.vf = &vfile;
> +			err = erofsmount_nbd(src, EROFSNBD_SOURCE_OCI, mountcfg.target,
> +					     mountcfg.fstype, mountcfg.flags, mountcfg.options);
> +		} else {
> +			src.device_path = mountcfg.device;
> +			err = erofsmount_nbd(src, EROFSNBD_SOURCE_LOCAL, mountcfg.target,
> +					     mountcfg.fstype, mountcfg.flags,
> +					     mountcfg.options);
> +		}

I think you could just

		struct erofs_vfile vfile;
		int sourcetype;

		if (mountcfg.use_oci) {
			sourcetype = EROFSNBD_SOURCE_OCI;
			ocicfg.image_ref = mountcfg.device;
			src.vf = &vfile;
		} else {
			sourcetype = EROFSNBD_SOURCE_LOCAL;
			src.device_path = mountcfg.device;
		}

		err = erofsmount_nbd(src, sourcetype, mountcfg.target,
				     mountcfg.fstype, mountcfg.flags,
				     mountcfg.options);

Thanks,
Gao Xiang

>   		goto exit;
>   	}
>   


