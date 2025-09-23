Return-Path: <linux-erofs+bounces-1072-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 310ECB94163
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Sep 2025 05:19:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cW4vj0b3Qz3cYR;
	Tue, 23 Sep 2025 13:19:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758597553;
	cv=none; b=ej3FkVx2uQS11tpGh8b8OuOs6UZ45K20VvELZfFwA88s2Q0oSg3+dycrscYUUg6pUK4LPKcSKKg39izfsf7ZvZ7mMuEBiR/aAcM54ysb/n7Aqcy+Nb/kG1x9zURMmdt4Z9tGxWxdG9pQMDHR+PW9TZLHNBZlKeJzAqMWmkolObOQywg1FWmPpe9n/pXjRuxgyGP9pfaZ7pjXw55T3H694lYPdaPRIKRyt7i96u0/FKxvAU+xhdW4+/cgT8XrxH00lGlSX/4pcwvyB7lfL3+VhZaU5XlTJ8k2zCkfu+NS61aMhI8SAo55lX5V62ZePVEJWMgrVvU/sMoe5y2bkmnPsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758597553; c=relaxed/relaxed;
	bh=49S06/9wRxYQuXlREnYm5hLl3IIJPdqrAO6LVIEqOag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NcTyo7w/tJkaD4JVOQCn2asty47wzEra4gqwNDCyd5xcZrOpfyGJ1r0vF9VuBOechgq7D6huGzfmU7zGIdRkUk1P5DhzRM0VxcXhu/Ty9D3CI7e0IsLmR5GD9LDtofx40JzXM9CKUzawv6qycq3p8xk7q9QNrYSqhLuze9fcQfMHFc38na1Iee/XtBevdrJXyZj2xkaAI60BHR5WHlwXGyZ+1IVzK3FcCDPNE0m+vDfNfWUt3lvRn8ebviSn0NaFQTCbFSEpilqbPFY8+Ww67wqMFDkVeoMaba1qbBS+/d7SfXgjv5vxJsxsaSmnxVLiaXy4wBL3cDQ3YvgE/nJqCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bosT4dKI; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bosT4dKI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cW4vg0BVyz3cYP
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Sep 2025 13:19:09 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758597545; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=49S06/9wRxYQuXlREnYm5hLl3IIJPdqrAO6LVIEqOag=;
	b=bosT4dKIskSwdHC7E21SrYpEH+ADKhObglAGYsuFcWwJQsMDHbkSNC4U0/uknvMl+A8yZidSiOKe5O1iyMhvEViY6a8SBQw1wec8kUGbS3M2P+jWAGHNGxmnAY87L2l5kGsZJR6uPHiRb1OuyJguDqlaiKHlKr1XKmaaq0L4T/Q=
Received: from 30.221.131.45(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WodN33C_1758597544 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Sep 2025 11:19:04 +0800
Message-ID: <4aaa8d40-f49e-40d8-a972-3ee2bdd8de31@linux.alibaba.com>
Date: Tue, 23 Sep 2025 11:19:03 +0800
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
Subject: Re: [PATCH v4] erofs-utils: oci: add support for indexing by layer
 digest
To: ChengyuZhu6 <hudson@cyzhu.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, Chengyu Zhu <hudsonzhu@tencent.com>
References: <20250916153415.93839-1-hudson@cyzhu.com>
 <20250923025501.59542-1-hudson@cyzhu.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250923025501.59542-1-hudson@cyzhu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/9/23 10:55, ChengyuZhu6 wrote:
> From: Chengyu Zhu <hudsonzhu@tencent.com>
> 
> Add support for indexing by layer_digest string for more precise
> and reliable OCI layer identification. This change affects both mkfs.erofs
> and mount.erofs tools.
> 
> Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
> ---
>   lib/liberofs_oci.h |   6 +-
>   lib/remotes/oci.c  |  87 +++++++++++++++++++-------
>   mkfs/main.c        |  78 ++++++++++++++---------
>   mount/main.c       | 153 ++++++++++++++++++++++++++++++++-------------
>   4 files changed, 228 insertions(+), 96 deletions(-)
> 
> diff --git a/lib/liberofs_oci.h b/lib/liberofs_oci.h
> index aa41141..621eb2b 100644
> --- a/lib/liberofs_oci.h
> +++ b/lib/liberofs_oci.h
> @@ -21,7 +21,8 @@ struct erofs_importer;
>    * @platform: target platform in "os/arch" format (e.g., "linux/amd64")
>    * @username: username for authentication (optional)
>    * @password: password for authentication (optional)
> - * @layer_index: specific layer to extract (-1 for all layers)
> + * @layer_digest: specific layer digest to extract (NULL for all layers)

blob_digest?

> + * @layer_index: specific layer index to extract (negative for all layers)
>    *
>    * Configuration structure for OCI image parameters including registry
>    * location, image identification, platform specification, and authentication
> @@ -32,6 +33,7 @@ struct ocierofs_config {
>   	char *platform;
>   	char *username;
>   	char *password;
> +	char *layer_digest;

blob_digest?

>   	int layer_index;
>   };
>   
> @@ -51,7 +53,7 @@ struct ocierofs_ctx {
>   	char *tag;
>   	char *manifest_digest;
>   	struct ocierofs_layer_info **layers;
> -	int layer_index;
> +	char *layer_digest;

blob_digest?

>   	int layer_count;
>   };
>   
> diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
> index 26aec27..b6118da 100644
> --- a/lib/remotes/oci.c
> +++ b/lib/remotes/oci.c
> @@ -898,6 +898,20 @@ static int ocierofs_prepare_auth(struct ocierofs_ctx *ctx,
>   	return 0;
>   }
>   
> +static int ocierofs_find_layer_by_digest(struct ocierofs_ctx *ctx, const char *digest)
> +{
> +	int i;
> +
> +	for (i = 0; i < ctx->layer_count; i++) {
> +		DBG_BUGON(!ctx->layers[i]);
> +		DBG_BUGON(!ctx->layers[i]->digest);
> +
> +		if (!strcmp(ctx->layers[i]->digest, digest))
> +			return i;
> +	}
> +	return -1;
> +}
> +
>   static int ocierofs_prepare_layers(struct ocierofs_ctx *ctx,
>   				   const struct ocierofs_config *config)
>   {
> @@ -925,16 +939,34 @@ static int ocierofs_prepare_layers(struct ocierofs_ctx *ctx,
>   		goto out_manifest;
>   	}
>   
> -	if (ctx->layer_index >= ctx->layer_count) {
> -		erofs_err("layer index %d exceeds available layers (%d)",
> -			  ctx->layer_index, ctx->layer_count);
> -		ret = -EINVAL;
> -		goto out_layers;
> +	if (!ctx->layer_digest && config->layer_index >= 0) {
> +		if (config->layer_index >= ctx->layer_count) {
> +			erofs_err("layer index %d out of range (0..%d)",
> +				  config->layer_index, ctx->layer_count - 1);
> +			ret = -EINVAL;
> +			goto out_layers;
> +		}
> +		DBG_BUGON(!ctx->layers[config->layer_index]);
> +		DBG_BUGON(!ctx->layers[config->layer_index]->digest);
> +		ctx->layer_digest = strdup(ctx->layers[config->layer_index]->digest);
> +		if (!ctx->layer_digest) {
> +			ret = -ENOMEM;
> +			goto out_layers;
> +		}
> +	}
> +
> +	if (ctx->layer_digest) {
> +		if (ocierofs_find_layer_by_digest(ctx, ctx->layer_digest) < 0) {
> +			erofs_err("layer digest %s not found in image layers",
> +				  ctx->layer_digest);
> +			ret = -ENOENT;
> +			goto out_layers;
> +		}
>   	}
>   	return 0;
>   
>   out_layers:
> -	free(ctx->layers);
> +	ocierofs_free_layers_info(ctx->layers, ctx->layer_count);
>   	ctx->layers = NULL;
>   out_manifest:
>   	free(ctx->manifest_digest);
> @@ -1054,10 +1086,10 @@ static int ocierofs_init(struct ocierofs_ctx *ctx, const struct ocierofs_config
>   	if (ocierofs_curl_setup_common_options(ctx->curl))
>   		return -EIO;
>   
> -	if (config->layer_index >= 0)
> -		ctx->layer_index = config->layer_index;
> +	if (config->layer_digest)
> +		ctx->layer_digest = strdup(config->layer_digest);
>   	else
> -		ctx->layer_index = -1;
> +		ctx->layer_digest = NULL;
>   	ctx->registry = strdup("registry-1.docker.io");
>   	ctx->tag = strdup("latest");
>   	if (config->platform)
> @@ -1190,6 +1222,7 @@ static void ocierofs_ctx_cleanup(struct ocierofs_ctx *ctx)
>   	free(ctx->tag);
>   	free(ctx->platform);
>   	free(ctx->manifest_digest);
> +	free(ctx->layer_digest);
>   }
>   
>   int ocierofs_build_trees(struct erofs_importer *importer,
> @@ -1204,8 +1237,13 @@ int ocierofs_build_trees(struct erofs_importer *importer,
>   		return ret;
>   	}
>   
> -	if (ctx.layer_index >= 0) {
> -		i = ctx.layer_index;
> +	if (ctx.layer_digest) {
> +		i = ocierofs_find_layer_by_digest(&ctx, ctx.layer_digest);
> +		if (i < 0) {
> +			erofs_err("layer digest %s not found", ctx.layer_digest);
> +			ret = -ENOENT;
> +			goto out;
> +		}
>   		end = i + 1;
>   	} else {
>   		i = 0;
> @@ -1215,25 +1253,26 @@ int ocierofs_build_trees(struct erofs_importer *importer,
>   	while (i < end) {
>   		char *trimmed = erofs_trim_for_progressinfo(ctx.layers[i]->digest,
>   				sizeof("Extracting layer  ...") - 1);
> -		erofs_update_progressinfo("Extracting layer %d: %s ...", i,
> -				  trimmed);
> +		erofs_update_progressinfo("Extracting layer %s ...", trimmed);
>   		free(trimmed);
>   		fd = ocierofs_extract_layer(&ctx, ctx.layers[i]->digest,
>   					    ctx.auth_header);
>   		if (fd < 0) {
> -			erofs_err("failed to extract layer %d: %s", i,
> -				  erofs_strerror(fd));
> +			erofs_err("failed to extract layer %s: %s",
> +				  ctx.layers[i]->digest, erofs_strerror(fd));
> +			ret = fd;
>   			break;
>   		}
>   		ret = ocierofs_process_tar_stream(importer, fd);
>   		close(fd);
>   		if (ret) {
> -			erofs_err("failed to process tar stream for layer %d: %s", i,
> -				  erofs_strerror(ret));
> +			erofs_err("failed to process tar stream for layer %s: %s",
> +				  ctx.layers[i]->digest, erofs_strerror(ret));
>   			break;
>   		}
>   		i++;
>   	}
> +out:
>   	ocierofs_ctx_cleanup(&ctx);
>   	return ret;
>   }
> @@ -1246,12 +1285,18 @@ static int ocierofs_download_blob_range(struct ocierofs_ctx *ctx, off_t offset,
>   	const char *api_registry;
>   	char rangehdr[64];
>   	long http_code = 0;
> -	int ret;
> -	int index = ctx->layer_index;
> -	u64 blob_size = ctx->layers[index]->size;
> +	int ret, index;
> +	const char *digest;
> +	u64 blob_size;
>   	size_t available;
>   	size_t copy_size;
>   
> +	index = ocierofs_find_layer_by_digest(ctx, ctx->layer_digest);
> +	if (index < 0)
> +		return -ENOENT;
> +	digest = ctx->layer_digest;
> +	blob_size = ctx->layers[index]->size;
> +
>   	if (offset < 0)
>   		return -EINVAL;
>   
> @@ -1265,7 +1310,7 @@ static int ocierofs_download_blob_range(struct ocierofs_ctx *ctx, off_t offset,
>   
>   	api_registry = ocierofs_get_api_registry(ctx->registry);
>   	if (asprintf(&req.url, "https://%s/v2/%s/blobs/%s",
> -	     api_registry, ctx->repository, ctx->layers[index]->digest) == -1)
> +	     api_registry, ctx->repository, digest) == -1)
>   		return -ENOMEM;
>   
>   	if (length)
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 50e2bdb..6eb4203 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -215,9 +215,10 @@ static void usage(int argc, char **argv)
>   #endif
>   #ifdef OCIEROFS_ENABLED
>   		" --oci[=platform=X]    X=platform (default: linux/amd64)\n"
> -		"   [,layer=Y]          Y=layer index to extract (0-based; omit to extract all layers)\n"
> -		"   [,username=Z]       Z=username for authentication (optional)\n"
> -		"   [,password=W]       W=password for authentication (optional)\n"
> +		"   [,layer_index=Y]    Y=layer index to extract (0-based; omit to extract all layers)\n"
> +		"   [,layer_digest=Z]   Z=layer digest to extract (omit to extract all layers)\n"

Can we use
		"   [,layer=#]          #=layer index to extract (0-based; omit to extract all layers)\n"
		"   [,blob=Y]           Y=layer digest to extract (omit to extract all layers)\n"

instead?

> +		"   [,username=W]       W=username for authentication (optional)\n"
> +		"   [,password=V]       V=password for authentication (optional)\n"
>   #endif
>   		" --tar=X               generate a full or index-only image from a tarball(-ish) source\n"
>   		"                       (X = f|i|headerball; f=full mode, i=index mode,\n"
> @@ -707,13 +708,14 @@ static int mkfs_parse_s3_cfg(char *cfg_str)
>    * @options_str: comma-separated options string
>    *
>    * Parse OCI options string containing comma-separated key=value pairs.
> - * Supported options include platform, layer, username, and password.
> + * Supported options include platform, layer_digest, layer_index, username, and password.
>    *
>    * Return: 0 on success, negative errno on failure
>    */
>   static int mkfs_parse_oci_options(struct ocierofs_config *oci_cfg, char *options_str)
>   {
>   	char *opt, *q, *p;
> +	long idx;
>   
>   	if (!options_str)
>   		return 0;
> @@ -732,40 +734,57 @@ static int mkfs_parse_oci_options(struct ocierofs_config *oci_cfg, char *options
>   			if (!oci_cfg->platform)
>   				return -ENOMEM;
>   		} else {
> -			p = strstr(opt, "layer=");
> +			p = strstr(opt, "layer_digest=");


layer=

>   			if (p) {
> -				p += strlen("layer=");
> -				{
> -					char *endptr;
> -					unsigned long v = strtoul(p, &endptr, 10);
> -
> -					if (endptr == p || *endptr != '\0') {
> -						erofs_err("invalid layer index %s",
> -						  p);
> -						return -EINVAL;
> -					}
> -					oci_cfg->layer_index = (int)v;
> +				p += strlen("layer_digest=");


blob=

> +				free(oci_cfg->layer_digest);
> +
> +				if (oci_cfg->layer_index >= 0) {
> +					erofs_err("invalid --oci: layer_digest and layer_index cannot be set together");
> +					return -EINVAL;
> +				}
> +
> +				if (strncmp(p, "sha256:", 7) != 0) {
> +					if (asprintf(&oci_cfg->layer_digest, "sha256:%s", p) < 0)
> +						return -ENOMEM;
> +				} else {
> +					oci_cfg->layer_digest = strdup(p);
> +					if (!oci_cfg->layer_digest)
> +						return -ENOMEM;
>   				}
>   			} else {
> -				p = strstr(opt, "username=");
> +				p = strstr(opt, "layer_index=");
>   				if (p) {
> -					p += strlen("username=");
> -					free(oci_cfg->username);
> -					oci_cfg->username = strdup(p);
> -					if (!oci_cfg->username)
> -						return -ENOMEM;
> +					p += strlen("layer_index=");
> +					if (oci_cfg->layer_digest) {
> +						erofs_err("invalid --oci: layer_index and layer_digest cannot be set together");
> +						return -EINVAL;
> +					}
> +					idx = strtol(p, NULL, 10);
> +					if (idx < 0)
> +						return -EINVAL;
> +					oci_cfg->layer_index = (int)idx;
>   				} else {
> +					p = strstr(opt, "username=");
> +					if (p) {
> +						p += strlen("username=");
> +						free(oci_cfg->username);
> +						oci_cfg->username = strdup(p);
> +						if (!oci_cfg->username)
> +							return -ENOMEM;
> +					}
> +
>   					p = strstr(opt, "password=");
>   					if (p) {
>   						p += strlen("password=");
> -					free(oci_cfg->password);
> -					oci_cfg->password = strdup(p);
> -					if (!oci_cfg->password)
> -						return -ENOMEM;
> -					} else {
> -						erofs_err("mkfs: invalid --oci value %s", opt);
> -						return -EINVAL;
> +						free(oci_cfg->password);
> +						oci_cfg->password = strdup(p);
> +						if (!oci_cfg->password)
> +							return -ENOMEM;
>   					}
> +
> +					erofs_err("mkfs: invalid --oci value %s", opt);
> +					return -EINVAL;
>   				}
>   			}
>   		}
> @@ -1850,6 +1869,7 @@ int main(int argc, char **argv)
>   #endif
>   #ifdef OCIEROFS_ENABLED
>   		} else if (source_mode == EROFS_MKFS_SOURCE_OCI) {
> +			ocicfg.layer_digest = NULL;
>   			ocicfg.layer_index = -1;
>   
>   			err = mkfs_parse_oci_options(&ocicfg, mkfs_oci_options);
> diff --git a/mount/main.c b/mount/main.c
> index f368746..323d1de 100644
> --- a/mount/main.c
> +++ b/mount/main.c
> @@ -81,51 +81,76 @@ static int erofsmount_parse_oci_option(const char *option)
>   {
>   	struct ocierofs_config *oci_cfg = &nbdsrc.ocicfg;
>   	char *p;
> +	long idx;
>   
> -	p = strstr(option, "oci.layer=");
> +	if (oci_cfg->layer_index == 0 && !oci_cfg->layer_digest &&
> +	    !oci_cfg->platform && !oci_cfg->username && !oci_cfg->password)
> +		oci_cfg->layer_index = -1;
> +
> +	p = strstr(option, "oci.layer_digest=");
>   	if (p != NULL) {
> -		p += strlen("oci.layer=");
> -		{
> -			char *endptr;
> -			unsigned long v = strtoul(p, &endptr, 10);
> +		p += strlen("oci.layer_digest=");

oci.blob=

> +		free(oci_cfg->layer_digest);
>   
> -			if (endptr == p || *endptr != '\0')
> -				return -EINVAL;
> -			oci_cfg->layer_index = (int)v;
> +		if (oci_cfg->layer_index >= 0) {
> +			erofs_err("invalid options: oci.layer_digest and oci.layer_index cannot be set together");
> +			return -EINVAL;
> +		}
> +
> +		if (strncmp(p, "sha256:", 7) != 0) {
> +			if (asprintf(&oci_cfg->layer_digest, "sha256:%s", p) < 0)
> +				return -ENOMEM;
> +		} else {
> +			oci_cfg->layer_digest = strdup(p);
> +			if (!oci_cfg->layer_digest)
> +				return -ENOMEM;
>   		}
>   	} else {
> -		p = strstr(option, "oci.platform=");
> +		p = strstr(option, "oci.layer_index=");

oci.layer =


Thanks,
Gao Xiang

