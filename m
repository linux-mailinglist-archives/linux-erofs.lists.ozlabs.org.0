Return-Path: <linux-erofs+bounces-1043-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 43125B82A69
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Sep 2025 04:27:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cS009327Nz30Jc;
	Thu, 18 Sep 2025 12:27:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758162441;
	cv=none; b=n/R6+NjEGgnqBqfiixLOb5jw1E7qNHozSN4nSf4a9o67Ozj+QtiLo/jyUNwcY0xgqloOfr2yJVSYFJF+MSJ+jzXx5o/n9GIatCombs41mSqImiSF4euo0QpSmtt6rzvVgumYhgrWNcd99PJbm5KK2qBoKTJl+F/nHk/WwqlfdwVKNEzigHHP5qSBmvfpWCiCIV41tXEPF7Iw4k+MTkWtYNeYVfnVrzFYwQ+dwnMQkb62X2qjrXz/FMDMwv7MOPPi3UNDTjgaRelq2ymnFGyo6XEa9aK8hdc/+D6to5BYwaC7zVmYiIwuTMMOtRArjjvUH8E3el8QrGbFvtcQQ+aZtA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758162441; c=relaxed/relaxed;
	bh=/TkibbIJ5d2NDZuO9iG+HUfJnMtTAVjEwm0Wp25fvFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HpOEui18ytqxuHJo8hMMQVO6EMdd1ZstemB1FlnvzeO5FPw/s7BZraXLeLG6P5VSZRRWxuVi96wGQc17giCTRh898U5Gv8FYZkVFu53cB8bMD39uNINAMTxW+H2gTwrx1FeSqHClP7ddZEK84v0AOa7NEK3l1Mej9qp8JxsINiiTyGOzP0EpF8LMQPMJzEc5xC94IBrA9ak/rbZ5jZpRmGsDenn9kT1tvEg+isNReSK8Ish8qNyOTy8ohpYlVruCq28qAu3fuIPFRzD342p09PseEYYxqoE3zvKNPV06/Fa+YfHlmEvZpaATevHBAS2OBLO60OiC+wxrRFhhOS/HbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Gw4ekrg9; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Gw4ekrg9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cS00712hTz3000
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Sep 2025 12:27:17 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758162433; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/TkibbIJ5d2NDZuO9iG+HUfJnMtTAVjEwm0Wp25fvFA=;
	b=Gw4ekrg9cmoHfcI3eEVi3POaz3BH4hfjaVQnmB8MDOy0UTBED876HgsOidZMwkmcclV8J9kZxGVwG0ajcToQ+PenMHnOYlNYpouFtPd+8x6sfvxdWUIAKjcgwcdEXM/b4IwWLGYK4+XrTMsRI4U9oDQwxPVs8uYb6nMaUBgetvE=
Received: from 30.221.132.3(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WoEEmy4_1758162430 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 18 Sep 2025 10:27:11 +0800
Message-ID: <5c965c9c-30c5-43d6-8861-d8f2a1c0ea87@linux.alibaba.com>
Date: Thu, 18 Sep 2025 10:27:10 +0800
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
Subject: Re: [PATCH v2] erofs-utils: oci: add support for indexing by layer
 digest
To: ChengyuZhu6 <hudson@cyzhu.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, Chengyu Zhu <hudsonzhu@tencent.com>
References: <06E91C03-951E-46B5-85C9-8F61F9BDE8EF@cyzhu.com>
 <20250916153415.93839-1-hudson@cyzhu.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250916153415.93839-1-hudson@cyzhu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/9/16 23:34, ChengyuZhu6 wrote:
> From: Chengyu Zhu <hudsonzhu@tencent.com>
> 
> Add support for indexing by layer_digest string for more precise
> and reliable OCI layer identification. This change affects both mkfs.erofs
> and mount.erofs tools.
> 
> Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
> ---
>   lib/liberofs_oci.h |   6 +-
>   lib/remotes/oci.c  |  89 +++++++++++++++++++------
>   mkfs/main.c        |  75 +++++++++++++--------
>   mount/main.c       | 160 +++++++++++++++++++++++++++++++++------------
>   4 files changed, 240 insertions(+), 90 deletions(-)
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
> + * @layer_index: specific layer index to extract (negative for all layers)
>    *
>    * Configuration structure for OCI image parameters including registry
>    * location, image identification, platform specification, and authentication
> @@ -32,6 +33,7 @@ struct ocierofs_config {
>   	char *platform;
>   	char *username;
>   	char *password;
> +	char *layer_digest;
>   	int layer_index;
>   };
>   
> @@ -51,7 +53,7 @@ struct ocierofs_ctx {
>   	char *tag;
>   	char *manifest_digest;
>   	struct ocierofs_layer_info **layers;
> -	int layer_index;
> +	char *layer_digest;
>   	int layer_count;
>   };
>   
> diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
> index 26aec27..d22aa2e 100644
> --- a/lib/remotes/oci.c
> +++ b/lib/remotes/oci.c
> @@ -898,6 +898,21 @@ static int ocierofs_prepare_auth(struct ocierofs_ctx *ctx,
>   	return 0;
>   }
>   
> +static int ocierofs_find_layer_by_digest(struct ocierofs_ctx *ctx, const char *digest)
> +{
> +	int i;
> +
> +	if (!digest || !ctx->layers)
> +		return -1;

It's an internal function, let's not check input argument validity (`digest`).
Or if users misuse an internal function, I'd rather to have a coredump instead
of slient failure.

In principle, `ctx->layers` won't be NULL here too (if ctx->layer_count > 0),
if it really needs to check, I suggest using `DBG_BUGON(!ctx->layers)` or
just get rid of this check.

> +
> +	for (i = 0; i < ctx->layer_count; i++) {

		DBG_BUGON(!ctx->layers[i]);
		DBG_BUGON(!ctx->layers[i]->digest);

		if (!strcmp(ctx->layers[i]->digest, digest))
			return i;


> +		if (ctx->layers[i] && ctx->layers[i]->digest &&
> +		    !strcmp(ctx->layers[i]->digest, digest))
> +			return i;
> +	}
> +	return -1;
> +}
> +
>   static int ocierofs_prepare_layers(struct ocierofs_ctx *ctx,
>   				   const struct ocierofs_config *config)
>   {
> @@ -925,16 +940,35 @@ static int ocierofs_prepare_layers(struct ocierofs_ctx *ctx,
>   		goto out_manifest;
>   	}
>   
> -	if (ctx->layer_index >= ctx->layer_count) {
> -		erofs_err("layer index %d exceeds available layers (%d)",
> -			  ctx->layer_index, ctx->layer_count);
> -		ret = -EINVAL;
> -		goto out_layers;
> +	if (config->layer_index >= 0) {
> +		if (config->layer_index >= ctx->layer_count) {
> +			erofs_err("layer index %d out of range (0..%d)",
> +				  config->layer_index, ctx->layer_count - 1);
> +			ret = -EINVAL;
> +			goto out_layers;
> +		}
> +		if (!ctx->layers[config->layer_index] ||
> +		    !ctx->layers[config->layer_index]->digest) {
> +			ret = -EINVAL;
> +			goto out_layers;
> +		}

		DBG_BUGON(!ctx->layers[config->layer_index]);
		DBG_BUGON(!ctx->layers[config->layer_index]->digest);

> +		ctx->layer_digest = strdup(ctx->layers[config->layer_index]->digest);
> +		if (!ctx->layer_digest) {
> +			ret = -ENOMEM;
> +			goto out_layers;
> +		}
> +	} else if (ctx->layer_digest) {
> +		if (ocierofs_find_layer_by_digest(ctx, ctx->layer_digest) < 0) {

	} else if (ctx->layer_digest &&
		   ocierofs_find_layer_by_digest(ctx, ctx->layer_digest) < 0) {

		erofs_err("layer digest %s not found in image layers",
			  ctx->layer_digest);
		ret = -ENOENT;
		goto out_layers;
	}


...

> -/* Parse input string in format: "image_ref platform layer [b64cred]" */
> +/* Parse input string in format: "image_ref platform layer [b64cred]"
> + * where layer is one of:
> + *   - "digest:<sha256...>" (layer_digest)
> + *   - "index:<N>"          (layer_index)
> + *   - ""                   (no specific layer)


can we just add another tag for this?
	OCI_LAYER and OCI_DIGEST

Thanks,
Gao Xiang

