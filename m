Return-Path: <linux-erofs+bounces-942-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBAEB3F205
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Sep 2025 03:52:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cG7zR5D98z2yhb;
	Tue,  2 Sep 2025 11:52:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756777955;
	cv=none; b=HE4GtiELeCjJRI1SN/wrFmRJ3UhnwWOF0YLVPk4R/Fr1/+H1sHn+iTcitvtV04L7TdHinZupP3jnRrIwZZJ5Yz2YIqdGnCgpMvGVqRGoLUJX76XksYmb6703Ncgmb5Up93UCyLAOH+XHR2Hzii/+gS+2Xxht6AdCHkqKK54NId/YGWt96kc9ENKoeagr9+KYXnpZzLVN+XtUDs7dmUulIwDVMDghBEtSZp/AqX9fE6l7XamzMg0W8056ipWVZlSg+5jnPzn6d8h5vaguYm0hm+gDdHDYLgX3BV+M+6V68QAv4qzjKqRR2y56SkXste5JCvYRMdU/+elhWFUJ+CZUdA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756777955; c=relaxed/relaxed;
	bh=bRbI2nKIEA+ayJ0xHCWa+BgcyktlZMCpNGT7HJb93uY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PZsgO67wXc2bNQ1obJdHZUJvxz8zAtOm3VaU/YxH01MwG+zPgJlv+UWCyf2eaPhCeUOKKL2aEcCjBMJWY9KAtUOOFkw1w4WXsTl9aeXGyI/EwExgoWW7vXd4A8Xj8UHCK6/LAetDCM/o1SQXkuqVhmzDAM36duvIRe93Pfs9ccYIDzypIpsf16II7YhdHgo5zkVbqVsBrjnWWLVAmBtEg6f8vdPC1uCQbIeIBt4rmAPlbrgozb8YybvwyoYC6c3ltd8pttyC3+gC4iQzVhYM5vYz64ZEIyyThRdULsDHKm8TnpldNGYMK3GnZMClHq1yk615k7vkRcoyAiXdMJjdrA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Of4rqjKz; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Of4rqjKz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cG7zP4xZgz2yD5
	for <linux-erofs@lists.ozlabs.org>; Tue,  2 Sep 2025 11:52:32 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756777948; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=bRbI2nKIEA+ayJ0xHCWa+BgcyktlZMCpNGT7HJb93uY=;
	b=Of4rqjKzxDgM/TTokCNPArY41Mk2beNoJkROXB0v9JeC2ayBZeKVcFwoZlIL8dRPuAITMBuS8fVUaqGf+Hxq5wVcs/IfafDEKxkYKEwTK/hhbyWnWh8goggSl334bbVU2YB14ZA8b+syCZ8PeLP1OzrCpRetiQTKi+hKJMDOvBY=
Received: from 30.221.132.16(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wn5XfxY_1756777946 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Sep 2025 09:52:27 +0800
Message-ID: <86166f85-5ebb-453a-adcd-7eb8f6bea372@linux.alibaba.com>
Date: Tue, 2 Sep 2025 09:52:26 +0800
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
Subject: Re: [PATCH v1-changed] erofs-utils: refactor OCI code for better
 modularity
To: ChengyuZhu6 <hudson@cyzhu.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, Chengyu Zhu <hudsonzhu@tencent.com>
References: <20250901051042.10905-1-hudson@cyzhu.com>
 <20250901070115.70603-1-hudson@cyzhu.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250901070115.70603-1-hudson@cyzhu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/9/1 15:01, ChengyuZhu6 wrote:
> From: Chengyu Zhu <hudsonzhu@tencent.com>
> 
> Refactor OCI code to improve code organization and maintainability:
> 
> - Add `struct ocierofs_layer_info` to encapsulate layer metadata
> - Extract authentication logic into `ocierofs_prepare_auth()`
> - Split layer processing into `ocierofs_prepare_layers()`
> - Move OCI parsing functions from `mkfs/main.c` to `lib/remotes/oci.c`
> - Add `ocierofs_process_tar_stream()` for separate tar processing
> - Improve error handling with `ocierofs_free_layers_info()`
> - Refactor `ocierofs_extract_layer()` to return file descriptor
> 
> Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
> ---
>   lib/liberofs_oci.h | 100 +++++++++
>   lib/remotes/oci.c  | 540 +++++++++++++++++++++++++++++++++------------
>   mkfs/main.c        | 200 +----------------
>   3 files changed, 506 insertions(+), 334 deletions(-)
> 
> diff --git a/lib/liberofs_oci.h b/lib/liberofs_oci.h
> index 3a8108b..698fe07 100644
> --- a/lib/liberofs_oci.h
> +++ b/lib/liberofs_oci.h
> @@ -19,6 +19,23 @@ struct erofs_inode;
>   struct CURL;
>   struct erofs_importer;
>   
> +/**
> + * struct ocierofs_layer_info
> + * @digest: OCI content-addressable digest (e.g. "sha256:...")
> + * @media_type: mediaType string from the manifest
> + * @size: layer size in bytes from the manifest (0 if not available)
> + *
> + * This structure is exposed to callers so they can enumerate image layers,
> + * decide which ones to fetch, and pass the digest back to download APIs.
> + * Fields are heap-allocated NUL-terminated strings owned by the caller
> + * once returned from public APIs; the caller must free them.
> + */
> +struct ocierofs_layer_info {
> +	char *digest;
> +	char *media_type;
> +	u64 size;
> +};
> +
>   /**
>    * struct erofs_oci_params - OCI configuration parameters
>    * @registry: registry hostname (e.g., "registry-1.docker.io")
> @@ -88,6 +105,89 @@ int erofs_oci_params_set_string(char **field, const char *value);
>    */
>   int ocierofs_build_trees(struct erofs_importer *importer, struct erofs_oci *oci);
>   
> +/*
> + * ocierofs_parse_options - Parse comma-separated OCI options string
> + * @oci: OCI client structure to update
> + * @options_str: comma-separated options string
> + *
> + * Parse OCI options string containing comma-separated key=value pairs.
> + * Supported options include platform, layer, username, and password.
> + *
> + * Return: 0 on success, negative errno on failure
> + */
> +int ocierofs_parse_options(struct erofs_oci *oci, char *options_str);

Can we leave this functionality in `mkfs/main.c`.

liberofs is not the place to keep option parser.

> +
> +/*
> + * ocierofs_parse_ref - Parse OCI image reference string
> + * @oci: OCI client structure to update
> + * @ref_str: OCI image reference in various formats
> + *
> + * Parse OCI image reference which can be in formats:
> + * - registry.example.com/namespace/repo:tag
> + * - namespace/repo:tag (uses default registry)
> + * - repo:tag (adds library/ prefix for Docker Hub)

Is there some reference for this rule?

> + * - repo (uses default tag "latest")
> + *
> + * Return: 0 on success, negative errno on failure
> + */
> +int ocierofs_parse_ref(struct erofs_oci *oci, const char *ref_str);
> +
> +/*
> + * ocierofs_prepare_layers - Prepare OCI layers for processing
> + * @oci: OCI client structure with configured parameters
> + * @auth_header: Pointer to store authentication header
> + * @using_basic: Pointer to store basic auth flag
> + * @manifest_digest: Pointer to store manifest digest
> + * @layers: Pointer to store layers information
> + * @layer_count: Pointer to store number of layers
> + * @start_index: Pointer to store starting layer index
> + *
> + * Prepare authentication, get manifest digest and layers information
> + * for OCI image processing. This function handles all the preparation
> + * work needed before processing OCI layers.
> + *
> + * Return: 0 on success, negative errno on failure
> + */
> +int ocierofs_prepare_layers(struct erofs_oci *oci, char **auth_header,
> +			   bool *using_basic, char **manifest_digest,
> +			   struct ocierofs_layer_info ***layers,
> +			   int *layer_count, int *start_index);

Could we have a way to wrap these arguments into
a structure too?

> +
> +/**
> + * ocierofs_free_layers_info - Free layer information array
> + * @layers: array of layer information structures
> + * @count: number of layers in the array
> + *
> + * Free all layer information structures and the array itself.
> + * This function handles NULL pointers safely.
> + */
> +void ocierofs_free_layers_info(struct ocierofs_layer_info **layers, int count);
> +
> +/**
> + * ocierofs_prepare_auth - Prepare authentication for OCI requests
> + * @oci: OCI client structure
> + * @auth_header_out: pointer to store authentication header
> + * @using_basic_auth: pointer to store basic auth flag
> + *
> + * Prepare authentication header for OCI registry requests.
> + * This function handles both token-based and basic authentication.
> + *
> + * Return: 0 on success, negative errno on failure
> + */
> +int ocierofs_prepare_auth(struct erofs_oci *oci, char **auth_header_out,
> +			  bool *using_basic_auth);
> +
> +/**
> + * ocierofs_curl_clear_auth - Clear basic authentication from CURL handle
> + * @curl: CURL handle to clear authentication from
> + *
> + * Clear basic authentication credentials from a CURL handle.
> + * This should be called after using basic authentication to clean up.
> + *
> + * Return: 0 on success, negative errno on failure
> + */
> +int ocierofs_curl_clear_auth(struct CURL *curl);

pass in `erofs_oci` instead?

> +
>   #ifdef __cplusplus
>   }
>   #endif
> diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
> index 0fb8c1f..9774d8d 100644
> --- a/lib/remotes/oci.c
> +++ b/lib/remotes/oci.c
> @@ -42,7 +42,6 @@ struct erofs_oci_response {
>   };
>   
>   struct erofs_oci_stream {
> -	struct erofs_tarfile tarfile;
>   	const char *digest;
>   	int blobfd;
>   };
> @@ -111,7 +110,7 @@ static int ocierofs_curl_setup_basic_auth(struct CURL *curl, const char *usernam
>   	return 0;
>   }
>   
> -static int ocierofs_curl_clear_auth(struct CURL *curl)
> +int ocierofs_curl_clear_auth(struct CURL *curl)
>   {
>   	curl_easy_setopt(curl, CURLOPT_USERPWD, NULL);
>   	curl_easy_setopt(curl, CURLOPT_HTTPAUTH, CURLAUTH_NONE);
> @@ -181,7 +180,7 @@ static int ocierofs_request_perform(struct erofs_oci *oci,
>   
>   	ret = ocierofs_curl_setup_rq(oci->curl, req->url,
>   				     OCIEROFS_HTTP_GET, req->headers,
> -			             ocierofs_write_callback, resp,
> +				     ocierofs_write_callback, resp,
>   				     NULL, NULL);
>   	if (ret)
>   		return ret;
> @@ -568,7 +567,7 @@ static char *ocierofs_get_manifest_digest(struct erofs_oci *oci,
>   	const char *api_registry;
>   	int ret = 0, len, i;
>   
> -	if (!registry || !repository || !tag || !platform)
> +	if (!registry || !repository || !tag)
>   		return ERR_PTR(-EINVAL);
>   
>   	api_registry = (!strcmp(registry, DOCKER_REGISTRY)) ? DOCKER_API_REGISTRY : registry;
> @@ -581,8 +580,8 @@ static char *ocierofs_get_manifest_digest(struct erofs_oci *oci,
>   
>   	req.headers = curl_slist_append(req.headers,
>   		"Accept: " DOCKER_MEDIATYPE_MANIFEST_LIST ","
> -		OCI_MEDIATYPE_INDEX "," DOCKER_MEDIATYPE_MANIFEST_V1 ","
> -		DOCKER_MEDIATYPE_MANIFEST_V2);
> +		OCI_MEDIATYPE_INDEX "," OCI_MEDIATYPE_MANIFEST ","
> +		DOCKER_MEDIATYPE_MANIFEST_V1 "," DOCKER_MEDIATYPE_MANIFEST_V2);
>   
>   	ret = ocierofs_request_perform(oci, &req, &resp);
>   	if (ret)
> @@ -663,7 +662,24 @@ out:
>   	return ret ? ERR_PTR(ret) : digest;
>   }
>   
> -static char **ocierofs_get_layers_info(struct erofs_oci *oci,
> +void ocierofs_free_layers_info(struct ocierofs_layer_info **layers, int count)
> +{
> +	int i;
> +
> +	if (!layers)
> +		return;
> +
> +	for (i = 0; i < count; i++) {
> +		if (layers[i]) {
> +			free(layers[i]->digest);
> +			free(layers[i]->media_type);
> +			free(layers[i]);
> +		}
> +	}
> +	free(layers);
> +}
> +
> +static struct ocierofs_layer_info **ocierofs_fetch_layers_info(struct erofs_oci *oci,
>   				       const char *registry,
>   				       const char *repository,
>   				       const char *digest,
> @@ -672,10 +688,10 @@ static char **ocierofs_get_layers_info(struct erofs_oci *oci,
>   {
>   	struct erofs_oci_request req = {};
>   	struct erofs_oci_response resp = {};
> -	json_object *root, *layers, *layer, *digest_obj;
> -	char **layers_info = NULL;
> +	json_object *root, *layers, *layer, *digest_obj, *media_type_obj, *size_obj;
> +	struct ocierofs_layer_info **layers_info = NULL;
>   	const char *api_registry;
> -	int ret, len, i, j;
> +	int ret, len, i;
>   
>   	if (!registry || !repository || !digest || !layer_count)
>   		return ERR_PTR(-EINVAL);
> @@ -725,7 +741,7 @@ static char **ocierofs_get_layers_info(struct erofs_oci *oci,
>   		goto out_json;
>   	}
>   
> -	layers_info = calloc(len, sizeof(char *));
> +	layers_info = calloc(len, sizeof(*layers_info));
>   	if (!layers_info) {
>   		ret = -ENOMEM;
>   		goto out_json;
> @@ -740,11 +756,25 @@ static char **ocierofs_get_layers_info(struct erofs_oci *oci,
>   			goto out_free;
>   		}
>   
> -		layers_info[i] = strdup(json_object_get_string(digest_obj));
> +		layers_info[i] = calloc(1, sizeof(**layers_info));
>   		if (!layers_info[i]) {
>   			ret = -ENOMEM;
>   			goto out_free;
>   		}
> +		layers_info[i]->digest = strdup(json_object_get_string(digest_obj));
> +		if (!layers_info[i]->digest) {
> +			ret = -ENOMEM;
> +			goto out_free;
> +		}
> +		if (json_object_object_get_ex(layer, "mediaType", &media_type_obj))
> +			layers_info[i]->media_type = strdup(json_object_get_string(media_type_obj));
> +		else
> +			layers_info[i]->media_type = NULL;
> +
> +		if (json_object_object_get_ex(layer, "size", &size_obj))
> +			layers_info[i]->size = json_object_get_int64(size_obj);
> +		else
> +			layers_info[i]->size = 0;
>   	}
>   
>   	*layer_count = len;
> @@ -756,11 +786,7 @@ static char **ocierofs_get_layers_info(struct erofs_oci *oci,
>   	return layers_info;
>   
>   out_free:
> -	if (layers_info) {
> -		for (j = 0; j < i; j++)
> -			free(layers_info[j]);
> -	}
> -	free(layers_info);
> +	ocierofs_free_layers_info(layers_info, i);
>   out_json:
>   	json_object_put(root);
>   out:
> @@ -771,8 +797,93 @@ out:
>   	return ERR_PTR(ret);
>   }
>   
> -static int ocierofs_extract_layer(struct erofs_oci *oci, struct erofs_importer *importer,
> -				  const char *digest, const char *auth_header)
> +/**
> + * ocierofs_process_tar_stream - Process tar stream from file descriptor
> + * @importer: EROFS importer structure
> + * @fd: File descriptor containing tar data
> + *
> + * Initialize tar stream, parse all entries, and clean up resources.
> + *
> + * Return: 0 on success, negative errno on failure
> + */
> +static int ocierofs_process_tar_stream(struct erofs_importer *importer, int fd)
> +{
> +	struct erofs_tarfile tarfile = {};
> +	int ret;
> +
> +	memset(&tarfile, 0, sizeof(tarfile));

	struct erofs_tarfile tarfile = {};

already indicates
	memset(&tarfile, 0, sizeof(tarfile));

Thanks,
Gao Xiang

