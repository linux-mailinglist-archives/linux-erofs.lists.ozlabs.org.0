Return-Path: <linux-erofs+bounces-1881-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4302AD2269E
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jan 2026 06:14:07 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsB3b03wBz2xqj;
	Thu, 15 Jan 2026 16:14:03 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768454042;
	cv=none; b=F4ozZEKIAncN5dW2HOvtvmG+uqGXKY58Tnb1nPKKfpWDTilShZoX0MFnSAViitB0FCsapvyz/cDaNRNoretscmeV6yKr+x90+oxJfTBAPULwrrRarWtKsKwhUjnPpgoZFMZcyeMA3r3t3FpRYk7lTyTwxIjpE3ehViZwZLI/DzpLVbLZhrDsSxNIyReIUwqmv4g+6Si9W6NKmWDBgHGBUj2H9QfkDuPqkyQFf6wzfeK2zsHl/9OijDms7Pf5v/GbXTwMe0aW+RZUYjxhmIVQ3YpfpJ+T+niYZ6qdgsLjjYkkGb3jnVw1lfFKdR0leNHE1M1fTtMuyqUUQUBPsKVg5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768454042; c=relaxed/relaxed;
	bh=hRvD9DsGHFgK5GDW/ghvk/QGptfNn0aax/xCrYgjFNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HkFD/uh2GFoAjAsr9/77eneDiDcC2Ciw2y2bTlapu8AQwiezwczu509oGsgxOJ/Rs8nCgAzSWCK13HgtdSD+kMY7aijTbR8t2SCWnBQFV/TwtFJZwQE34RcAlrYUBC7S1d4GgqZ2MbvzlsGhlU1ZqEdF4oT8GL22fggig481SGOGsYtGZuFBX1qoVxGJCnJ9DNSHRIUd0b12bT+zL4On2Op+YJV1Mah+RKdV4+Adjr1uMmSTvxVKxKgYN4DBb/G2pVe+yvBzRWdhk4JyEitM8Yh5PHOZpBlVUbGSq76gQ44ef9OG2uKdZZYt31QbBgTEgYJx8yXMTK//dXg4KWjm/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=F7n1xqst; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=F7n1xqst;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsB3X1RRcz2xHW
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jan 2026 16:13:57 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768454032; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=hRvD9DsGHFgK5GDW/ghvk/QGptfNn0aax/xCrYgjFNo=;
	b=F7n1xqst48RlFA9lc+7IehM4qm+j6TSUh/5uR8aZ2h2QEpLMYdrKrzIw5WX3B4UZ9tYUoc267ouR8N+k+RIpPn6qxsW43vsDbjZEMhzI5xG58EpfNpp0PYxP3Pd/F3go6tCUisiU7QsD23g/u87hwlQfBMczhfnBnjnlLD8rFYM=
Received: from 30.221.132.28(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wx5MdXF_1768454030 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 15 Jan 2026 13:13:51 +0800
Message-ID: <ea8d655c-73f2-45b2-9a1a-1882c414570e@linux.alibaba.com>
Date: Thu, 15 Jan 2026 13:13:50 +0800
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
Subject: Re: [PATCH v2] erofs-utils: lib: oci: support auto-detecting host
 platform
To: ChengyuZhu6 <hudson@cyzhu.com>, linux-erofs@lists.ozlabs.org
Cc: Chengyu Zhu <hudsonzhu@tencent.com>
References: <20260110082732.61528-1-hudson@cyzhu.com>
 <20260115033835.81033-1-hudson@cyzhu.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260115033835.81033-1-hudson@cyzhu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2026/1/15 11:38, ChengyuZhu6 wrote:
> From: Chengyu Zhu <hudsonzhu@tencent.com>
> 
> Currently, the platform is hard-coded to "linux/amd64" if not specified.
> This patch introduces `ocierofs_get_platform_spec` helper to detect the
> host platform (OS, architecture, and variant) at compile time using
> preprocessor macros.
> 
> Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
> ---
>   lib/remotes/oci.c | 68 ++++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 64 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
> index c8711ea..4c4568f 100644
> --- a/lib/remotes/oci.c
> +++ b/lib/remotes/oci.c
> @@ -694,10 +694,20 @@ static char *ocierofs_get_manifest_digest(struct ocierofs_ctx *ctx,
>   		    json_object_object_get_ex(manifest, "digest", &digest_obj)) {
>   			const char *arch = json_object_get_string(arch_obj);
>   			const char *os = json_object_get_string(os_obj);
> +			json_object *variant_obj;
> +			const char *variant = NULL;
>   			char manifest_platform[64];
>   
> -			snprintf(manifest_platform, sizeof(manifest_platform),
> -				 "%s/%s", os, arch);
> +			if (json_object_object_get_ex(platform_obj, "variant", &variant_obj))
> +				variant = json_object_get_string(variant_obj);
> +
> +			if (variant)
> +				snprintf(manifest_platform, sizeof(manifest_platform),
> +					 "%s/%s/%s", os, arch, variant);
> +			else
> +				snprintf(manifest_platform, sizeof(manifest_platform),
> +					 "%s/%s", os, arch);
> +
>   			if (!strcmp(manifest_platform, platform)) {
>   				digest = strdup(json_object_get_string(digest_obj));
>   				break;
> @@ -1089,13 +1099,63 @@ static int ocierofs_parse_ref(struct ocierofs_ctx *ctx, const char *ref_str)
>   	return 0;
>   }
>   
> +static char *ocierofs_get_platform_spec(void)
> +{
> +	const char *os = NULL, *arch = NULL, *variant = NULL;
> +	char *platform;
> +
> +#if defined(__linux__)
> +	os = "linux";
> +#elif defined(__APPLE__)
> +	os = "darwin";
> +#elif defined(_WIN32)
> +	os = "windows";
> +#elif defined(__FreeBSD__)
> +	os = "freebsd";
> +#endif
> +
> +#if defined(__x86_64__) || defined(__amd64__)
> +	arch = "amd64";
> +#elif defined(__aarch64__) || defined(__arm64__)
> +	arch = "arm64";
> +	variant = "v8";
> +#elif defined(__i386__)
> +	arch = "386";
> +#elif defined(__arm__)
> +	arch = "arm";
> +	variant = "v7";
> +#elif defined(__riscv) && (__riscv_xlen == 64)
> +	arch = "riscv64";
> +#elif defined(__ppc64__)
> +#if defined(__BYTE_ORDER__) && (__BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__)
> +	arch = "ppc64le";
> +#else
> +	arch = "ppc64";
> +#endif
> +#elif defined(__s390x__)
> +	arch = "s390x";
> +#endif
> +
> +	if (!os || !arch)
> +		return NULL;
> +
> +	if (variant) {
> +		if (asprintf(&platform, "%s/%s/%s", os, arch, variant) < 0)
> +			return NULL;
> +	} else {
> +		if (asprintf(&platform, "%s/%s", os, arch) < 0)
> +			return NULL;
> +	}
> +	return platform;
> +}
> +
>   /**
>    * ocierofs_init - Initialize OCI context
>    * @ctx: OCI context structure to initialize
>    * @config: OCI configuration
>    *
>    * Initialize OCI context structure, set up CURL handle, and configure
> - * default parameters including platform (linux/amd64), registry
> + * default parameters including platform (host platform), registry
>    * (registry-1.docker.io), and tag (latest).
>    *
>    * Return: 0 on success, negative errno on failure
> @@ -1120,7 +1180,7 @@ static int ocierofs_init(struct ocierofs_ctx *ctx, const struct ocierofs_config
>   	if (config->platform)
>   		ctx->platform = strdup(config->platform);
>   	else
> -		ctx->platform = strdup("linux/amd64");
> +		ctx->platform = ocierofs_get_platform_spec();

	if (!ctx->platform)
		return -EOPNOTSUPP;

I will update this part manually, otherwise it looks good to me.

Thanks,
Gao Xiang

