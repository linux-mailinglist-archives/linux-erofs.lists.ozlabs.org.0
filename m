Return-Path: <linux-erofs+bounces-1468-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 774A0C96D9C
	for <lists+linux-erofs@lfdr.de>; Mon, 01 Dec 2025 12:16:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dKhD85lSWz2yv6;
	Mon, 01 Dec 2025 22:16:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764587768;
	cv=none; b=YJDWqIQOC/SSRrPPE980IkBPAAizjKYiNcjht2hl84fdafDdqCY1TrROhh5pqgnSltQ39db1deuc+W1oiaLmB+V0c1Bc2JjYdQYGJ0fuf9XKN6tqPpg+FtuIb1VjDrBl9OcnVKQbTf7OCFbk2XFGaCIkupMmzJbqkoGPjEYHhP+Cb9JgrnKfh1jQl+dYZW6/9y1zvsNl7fOb7nLMtwgd+Z8TM1QqURXsm9jR4vESccNIhHWeeuKgOW3Mwr9o4CzXrVrYH4kHaN9ULOTGBgZRpLH0h5saMjzFMQPp/6cG2ZRHJfpJJTJ6Hw0PXKKDKVFeXULzoE+ItYObFoIilBT8tA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764587768; c=relaxed/relaxed;
	bh=XdHt3T+SM8r4ruqfSSvlIJpkVeE/zEDUypnE6Hqr58U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=B9RloD91kJpog8LLJUjjTEgs2nA6XIu3lqmU1Vl0uAWfbr0HutPLQDr3FSGX4nAe36gwUzdSwBXZdqs9VIPD809XRMd3KeZAhUETbgIN+ZCUVe+xaiADtckJuJFPxRBN7zM6TXNyeBE9DXM0jQXMaOaM6k6xlvuPeOB+RRD5J11Zei5LNMG6ZTQYRRwJsd68ZdACnFZneVp5+TUk+w89+qk/guUL7pmJ7rPHAAKJ4FDPMy3yea/Pmi+X+uqA4gC1YkDiy9VbUpU1O3GJheZUQi8V3YgazRpMwhpZINZaS3RS8ovi02OdGWCR22OyaSd8FmcNoeJW2c54UzSnXy1HBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=hmaL6Whd; dkim-atps=neutral; spf=pass (client-ip=113.46.200.216; helo=canpmsgout01.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=hmaL6Whd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.216; helo=canpmsgout01.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dKhD42MMdz2yqP
	for <linux-erofs@lists.ozlabs.org>; Mon, 01 Dec 2025 22:16:02 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=XdHt3T+SM8r4ruqfSSvlIJpkVeE/zEDUypnE6Hqr58U=;
	b=hmaL6Whdf6NqbyGtqObUdtxOlzyUQtMIfJEd63QT2yXk5gule98JrP97rwVBe6w2NVMV8Wn1q
	Uqa8o63RKO6CBCMxS6fNHCVlYLTJvVfsJIUIC/emUUNdE/Bho+euinaOuLiCiWw7qao+yORl8uf
	y+qwKMNZ09hraBdqng/A0GM=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dKh9p17x2z1T4GD;
	Mon,  1 Dec 2025 19:14:06 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id F2C63180485;
	Mon,  1 Dec 2025 19:15:55 +0800 (CST)
Received: from [100.103.109.96] (100.103.109.96) by
 kwepemr100010.china.huawei.com (7.202.195.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 1 Dec 2025 19:15:55 +0800
Message-ID: <2d654f7f-86d0-485a-814f-1edf02caa16b@huawei.com>
Date: Mon, 1 Dec 2025 19:15:54 +0800
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
Subject: Re: [PATCH 2/2] erofs-utils: lib: oci: allow HTTP connections to
 registry
To: hudsonZhu <hudson@cyzhu.com>
CC: <linux-erofs@lists.ozlabs.org>, <hsiangkao@linux.alibaba.com>,
	<hudsonzhu@tencent.com>, <wayne.ma@huawei.com>, <jingrui@huawei.com>
References: <20251130104257.877660-1-zhaoyifan28@huawei.com>
 <20251130104257.877660-2-zhaoyifan28@huawei.com>
 <812452D6-5119-46D0-B173-C65291D16307@cyzhu.com>
From: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
In-Reply-To: <812452D6-5119-46D0-B173-C65291D16307@cyzhu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [100.103.109.96]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Chengyu,

Thanks for your review. I will try to deal with `mount.erofs` later.


Thanks,

Yifan Zhao


On 2025/12/1 17:25, hudsonZhu wrote:
> Thanks for this patch, Yifan !
>
> It looks good to me. I have tested the patch and it works as expected.
> One suggestion: it would be nice to have similar functionality in
> mount.erofs as well, for consistency across the toolkit.
>
> Reviewed-and-tested-by: Chengyu Zhu <hudsonzhu@tencent.com>
>
> Thanks,
> Chengyu
>
>> 2025年11月30日 18:42，Yifan Zhao <zhaoyifan28@huawei.com> 写道：
>>
>> Currently, the URL used to send requests to the registry is hardcoded
>> with "https://". This patch introduces an optional insecure option for
>> `--oci`, enabling registry access via the HTTP protocol.
>>
>> Also, this patch refactors the deeply nested logic in the `--oci`
>> argument parsing.
>>
>> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
>> ---
>> lib/liberofs_oci.h |  3 ++
>> lib/remotes/oci.c  | 40 +++++++++++--------
>> mkfs/main.c        | 97 ++++++++++++++++++++--------------------------
>> 3 files changed, 70 insertions(+), 70 deletions(-)
>>
>> diff --git a/lib/liberofs_oci.h b/lib/liberofs_oci.h
>> index 5298f18..9e0571f 100644
>> --- a/lib/liberofs_oci.h
>> +++ b/lib/liberofs_oci.h
>> @@ -23,6 +23,7 @@ struct erofs_importer;
>>   * @password: password for authentication (optional)
>>   * @blob_digest: specific blob digest to extract (NULL for all layers)
>>   * @layer_index: specific layer index to extract (negative for all layers)
>> + * @insecure: use HTTP for registry communication (optional)
>>   *
>>   * Configuration structure for OCI image parameters including registry
>>   * location, image identification, platform specification, and authentication
>> @@ -37,6 +38,7 @@ struct ocierofs_config {
>> 	int layer_index;
>> 	char *tarindex_path;
>> 	char *zinfo_path;
>> +	bool insecure;
>> };
>>
>> struct ocierofs_layer_info {
>> @@ -57,6 +59,7 @@ struct ocierofs_ctx {
>> 	struct ocierofs_layer_info **layers;
>> 	char *blob_digest;
>> 	int layer_count;
>> +	const char *schema;
>> };
>>
>> struct ocierofs_iostream {
>> diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
>> index c1d6cae..d5afd6a 100644
>> --- a/lib/remotes/oci.c
>> +++ b/lib/remotes/oci.c
>> @@ -496,8 +496,8 @@ static char *ocierofs_discover_auth_endpoint(struct ocierofs_ctx *ctx,
>>
>> 	api_registry = ocierofs_get_api_registry(registry);
>>
>> -	if (asprintf(&test_url, "https://%s/v2/%s/manifests/nonexistent",
>> -	     api_registry, repository) < 0)
>> +	if (asprintf(&test_url, "%s%s/v2/%s/manifests/nonexistent",
>> +	     ctx->schema, api_registry, repository) < 0)
>> 		return NULL;
>>
>> 	curl_easy_reset(ctx->curl);
>> @@ -528,9 +528,9 @@ static char *ocierofs_get_auth_token(struct ocierofs_ctx *ctx, const char *regis
>> 				     const char *password)
>> {
>> 	static const char * const auth_patterns[] = {
>> -		"https://%s/v2/auth",
>> -		"https://auth.%s/token",
>> -		"https://%s/token",
>> +		"%s%s/v2/auth",
>> +		"%sauth.%s/token",
>> +		"%s%s/token",
>> 		NULL,
>> 	};
>> 	char *auth_header = NULL;
>> @@ -561,8 +561,8 @@ static char *ocierofs_get_auth_token(struct ocierofs_ctx *ctx, const char *regis
>>
>> 		api_registry = ocierofs_get_api_registry(registry);
>>
>> -		if (asprintf(&test_url, "https://%s/v2/%s/manifests/nonexistent",
>> -		     api_registry, repository) >= 0) {
>> +		if (asprintf(&test_url, "%s%s/v2/%s/manifests/nonexistent",
>> +		     ctx->schema, api_registry, repository) >= 0) {
>> 			curl_easy_reset(ctx->curl);
>> 			ocierofs_curl_setup_common_options(ctx->curl);
>>
>> @@ -598,7 +598,7 @@ static char *ocierofs_get_auth_token(struct ocierofs_ctx *ctx, const char *regis
>> 	for (i = 0; auth_patterns[i]; i++) {
>> 		char *auth_url;
>>
>> -		if (asprintf(&auth_url, auth_patterns[i], registry) < 0)
>> +		if (asprintf(&auth_url, auth_patterns[i], ctx->schema, registry) < 0)
>> 			continue;
>>
>> 		auth_header = ocierofs_get_auth_token_with_url(ctx, auth_url,
>> @@ -629,8 +629,8 @@ static char *ocierofs_get_manifest_digest(struct ocierofs_ctx *ctx,
>> 	int ret = 0, len, i;
>>
>> 	api_registry = ocierofs_get_api_registry(registry);
>> -	if (asprintf(&req.url, "https://%s/v2/%s/manifests/%s",
>> -	     api_registry, repository, tag) < 0)
>> +	if (asprintf(&req.url, "%s%s/v2/%s/manifests/%s",
>> +	     ctx->schema, api_registry, repository, tag) < 0)
>> 		return ERR_PTR(-ENOMEM);
>>
>> 	if (auth_header && strstr(auth_header, "Bearer"))
>> @@ -749,8 +749,8 @@ static int ocierofs_fetch_layers_info(struct ocierofs_ctx *ctx)
>> 	ctx->layer_count = 0;
>> 	api_registry = ocierofs_get_api_registry(registry);
>>
>> -	if (asprintf(&req.url, "https://%s/v2/%s/manifests/%s",
>> -		     api_registry, repository, digest) < 0)
>> +	if (asprintf(&req.url, "%s%s/v2/%s/manifests/%s",
>> +		     ctx->schema, api_registry, repository, digest) < 0)
>> 		return -ENOMEM;
>>
>> 	if (auth_header && strstr(auth_header, "Bearer"))
>> @@ -1124,10 +1124,18 @@ static int ocierofs_init(struct ocierofs_ctx *ctx, const struct ocierofs_config
>> 	if (!ctx->registry || !ctx->tag || !ctx->platform)
>> 		return -ENOMEM;
>>
>> +	ctx->schema = config->insecure ? "http://" : "https://";
>> +
>> 	ret = ocierofs_parse_ref(ctx, config->image_ref);
>> 	if (ret)
>> 		return ret;
>>
>> +	if (config->insecure && (!strcmp(ctx->registry, DOCKER_API_REGISTRY) ||
>> +				 !strcmp(ctx->registry, DOCKER_REGISTRY))) {
>> +		erofs_err("Insecure connection to Docker registry is not allowed");
>> +		return -EINVAL;
>> +	}
>> +
>> 	ret = ocierofs_prepare_layers(ctx, config);
>> 	if (ret)
>> 		return ret;
>> @@ -1152,8 +1160,8 @@ static int ocierofs_download_blob_to_fd(struct ocierofs_ctx *ctx,
>> 	};
>>
>> 	api_registry = ocierofs_get_api_registry(ctx->registry);
>> -	if (asprintf(&req.url, "https://%s/v2/%s/blobs/%s",
>> -	     api_registry, ctx->repository, digest) == -1)
>> +	if (asprintf(&req.url, "%s%s/v2/%s/blobs/%s",
>> +	     ctx->schema, api_registry, ctx->repository, digest) == -1)
>> 		return -ENOMEM;
>>
>> 	if (auth_header && strstr(auth_header, "Bearer"))
>> @@ -1344,8 +1352,8 @@ static int ocierofs_download_blob_range(struct ocierofs_ctx *ctx, off_t offset,
>> 		length = (size_t)(blob_size - offset);
>>
>> 	api_registry = ocierofs_get_api_registry(ctx->registry);
>> -	if (asprintf(&req.url, "https://%s/v2/%s/blobs/%s",
>> -	     api_registry, ctx->repository, digest) == -1)
>> +	if (asprintf(&req.url, "%s%s/v2/%s/blobs/%s",
>> +	     ctx->schema, api_registry, ctx->repository, digest) == -1)
>> 		return -ENOMEM;
>>
>> 	if (length)
>> diff --git a/mkfs/main.c b/mkfs/main.c
>> index 7aa8eae..5710948 100644
>> --- a/mkfs/main.c
>> +++ b/mkfs/main.c
>> @@ -218,11 +218,12 @@ static void usage(int argc, char **argv)
>> #endif
>> #ifdef OCIEROFS_ENABLED
>> 		" --oci=[f|i]           generate a full (f) or index-only (i) image from OCI remote source\n"
>> -		"   [,=platform=X]      X=platform (default: linux/amd64)\n"
>> +		"   [,platform=X]       X=platform (default: linux/amd64)\n"
>> 		"   [,layer=#]          #=layer index to extract (0-based; omit to extract all layers)\n"
>> 		"   [,blob=Y]           Y=blob digest to extract (omit to extract all layers)\n"
>> 		"   [,username=Z]       Z=username for authentication (optional)\n"
>> 		"   [,password=W]       W=password for authentication (optional)\n"
>> +		"   [,insecure]         use HTTP instead of HTTPS (optional)\n"
>> #endif
>> 		" --tar=X               generate a full or index-only image from a tarball(-ish) source\n"
>> 		"                       (X = f|i|headerball; f=full mode, i=index mode,\n"
>> @@ -744,7 +745,7 @@ static int mkfs_parse_s3_cfg(char *cfg_str)
>>   * Parse OCI options string containing comma-separated key=value pairs.
>>   *
>>   * Supported options include f|i, platform, blob|layer, username, password,
>> - * and zinfo.
>> + * and insecure.
>>   *
>>   * Return: 0 on success, negative errno on failure
>>   */
>> @@ -772,67 +773,55 @@ static int mkfs_parse_oci_options(struct ocierofs_config *oci_cfg, char *options
>> 		if (q)
>> 			*q = '\0';
>>
>> -
>> -		p = strstr(opt, "platform=");
>> -		if (p) {
>> +		if ((p = strstr(opt, "platform="))) {
>> 			p += strlen("platform=");
>> 			free(oci_cfg->platform);
>> 			oci_cfg->platform = strdup(p);
>> 			if (!oci_cfg->platform)
>> 				return -ENOMEM;
>> -		} else {
>> -			p = strstr(opt, "blob=");
>> -			if (p) {
>> -				p += strlen("blob=");
>> -				free(oci_cfg->blob_digest);
>> +		} else if ((p = strstr(opt, "blob="))) {
>> +			p += strlen("blob=");
>> +			free(oci_cfg->blob_digest);
>>
>> -				if (oci_cfg->layer_index >= 0) {
>> -					erofs_err("invalid --oci: blob and layer cannot be set together");
>> -					return -EINVAL;
>> -				}
>> +			if (oci_cfg->layer_index >= 0) {
>> +				erofs_err("invalid --oci: blob and layer cannot be set together");
>> +				return -EINVAL;
>> +			}
>>
>> -				if (!strncmp(p, "sha256:", 7)) {
>> -					oci_cfg->blob_digest = strdup(p);
>> -					if (!oci_cfg->blob_digest)
>> -						return -ENOMEM;
>> -				} else if (asprintf(&oci_cfg->blob_digest, "sha256:%s", p) < 0) {
>> +			if (!strncmp(p, "sha256:", 7)) {
>> +				oci_cfg->blob_digest = strdup(p);
>> +				if (!oci_cfg->blob_digest)
>> 					return -ENOMEM;
>> -				}
>> -			} else {
>> -				p = strstr(opt, "layer=");
>> -				if (p) {
>> -					p += strlen("layer=");
>> -					if (oci_cfg->blob_digest) {
>> -						erofs_err("invalid --oci: layer and blob cannot be set together");
>> -						return -EINVAL;
>> -					}
>> -					idx = strtol(p, NULL, 10);
>> -					if (idx < 0)
>> -						return -EINVAL;
>> -					oci_cfg->layer_index = (int)idx;
>> -				} else {
>> -					p = strstr(opt, "username=");
>> -					if (p) {
>> -						p += strlen("username=");
>> -						free(oci_cfg->username);
>> -						oci_cfg->username = strdup(p);
>> -						if (!oci_cfg->username)
>> -							return -ENOMEM;
>> -					} else {
>> -						p = strstr(opt, "password=");
>> -						if (p) {
>> -							p += strlen("password=");
>> -							free(oci_cfg->password);
>> -							oci_cfg->password = strdup(p);
>> -							if (!oci_cfg->password)
>> -								return -ENOMEM;
>> -						} else {
>> -							erofs_err("mkfs: invalid --oci value %s", opt);
>> -							return -EINVAL;
>> -						}
>> -					}
>> -				}
>> +			} else if (asprintf(&oci_cfg->blob_digest, "sha256:%s", p) < 0) {
>> +				return -ENOMEM;
>> 			}
>> +		} else if ((p = strstr(opt, "layer="))) {
>> +			p += strlen("layer=");
>> +			if (oci_cfg->blob_digest) {
>> +				erofs_err("invalid --oci: layer and blob cannot be set together");
>> +				return -EINVAL;
>> +			}
>> +			idx = strtol(p, NULL, 10);
>> +			if (idx < 0)
>> +				return -EINVAL;
>> +			oci_cfg->layer_index = (int)idx;
>> +		} else if ((p = strstr(opt, "username="))) {
>> +			p += strlen("username=");
>> +			free(oci_cfg->username);
>> +			oci_cfg->username = strdup(p);
>> +			if (!oci_cfg->username)
>> +				return -ENOMEM;
>> +		} else if ((p = strstr(opt, "password="))) {
>> +			p += strlen("password=");
>> +			free(oci_cfg->password);
>> +			oci_cfg->password = strdup(p);
>> +			if (!oci_cfg->password)
>> +				return -ENOMEM;
>> +		} else if ((p = strstr(opt, "insecure"))) {
>> +			oci_cfg->insecure = true;
>> +		} else {
>> +			erofs_err("mkfs: invalid --oci value %s", opt);
>> +			return -EINVAL;
>> 		}
>>
>> 		opt = q ? q + 1 : NULL;
>> -- 
>> 2.43.0
>>

