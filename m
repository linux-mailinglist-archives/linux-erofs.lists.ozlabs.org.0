Return-Path: <linux-erofs+bounces-959-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B50FB418FE
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Sep 2025 10:47:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cGx7l6FZqz2yr4;
	Wed,  3 Sep 2025 18:47:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756889251;
	cv=none; b=S180e2vhNLIfH8n+rkW+Uh3cil4gVV9Hok3tuBrLpa9zcguOKRnP6e0GCrdt2eyfzRuGU1GUmc/tH/3CbP4zTsvj1yRa91Ubf+p1WLejx79p/hjDO9M3GMpeQyld6j8ZQuBMhar/61COfXDRcRMMMwruE3zC1deUpkdVYzo7/K+ZR3RVycsCMg+OT2tNrIFN2zTHtZ1bj7k/cAcLOo8+UTQfUDwSC7nKFpfmiedZwl+CG1DFoLXsqi+XpbK5GNwWxSwsMBVTOX7/NAEeZSnbARDZYariaT+MKPQpcaILwu/u0u5uxckThiB/FCuabEaFLbQY7O7oLV3abKfKKnK1Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756889251; c=relaxed/relaxed;
	bh=tMqDvpZnuJKmPjaDdUgF7RaEeDHWSCEYZm4wqSao270=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gAWNEhaM8KiLErg8pwE+ur4NzlPlIyDoe509rBKoNroGMQRJJO3odCm3wU5vydEAfg0rSWEWhQnmfiwhGDynYIPDktJNvc5BwgOS+U0tT+gQSsXGyL51d3nH5yoI9i7A+43mcimNe3J2FV8xdVPmxd1/y8RRF4l+74IjV1KVxLh6i8I16aiKIy/JmmRId3GjbpK+P83A9P8VG5vkKghD/v0RqLl5IT3V3AkaDJPqxGkyzKcz4ybjZYJLvw92pbBSyJv+tgOBEFcgWM5fZTdAIaT8+G6yI7WAvf2HSh5XrvqKI2n2EnwHHMXmi4rc0ggYOaLWrlHd2c7Gwv4+FmETrg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FSZS+qRa; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FSZS+qRa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cGx7j46VSz2yFJ
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Sep 2025 18:47:28 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756889244; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tMqDvpZnuJKmPjaDdUgF7RaEeDHWSCEYZm4wqSao270=;
	b=FSZS+qRaPEzMA6dP6O63iVMkFjQgpeRaly072KgWxmoNMUlllDqwHusTzU3c2h6BSX1kgVaRY2x7WbN7eoVhk1zM/KS3aSVLz2MJNrrsxsnFzUXSWaGQZw43OphPVooM6c+4d6i1BspMfzwLsbYff7Kjm3TojHaEWcQm6dNG8+g=
Received: from 30.221.131.35(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WnBCxiv_1756889242 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Sep 2025 16:47:23 +0800
Message-ID: <2b7f2c20-f68e-4d1d-b015-4a403fcc9dae@linux.alibaba.com>
Date: Wed, 3 Sep 2025 16:47:22 +0800
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
Subject: Re: [PATCH v3 1/2] erofs-utils: refactor OCI code for better
 modularity
To: ChengyuZhu6 <hudson@cyzhu.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, Chengyu Zhu <hudsonzhu@tencent.com>
References: <20250901051042.10905-1-hudson@cyzhu.com>
 <20250903082906.83826-1-hudson@cyzhu.com>
 <20250903082906.83826-2-hudson@cyzhu.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250903082906.83826-2-hudson@cyzhu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/9/3 16:29, ChengyuZhu6 wrote:
> From: Chengyu Zhu <hudsonzhu@tencent.com>
> 
> Refactor OCI code to improve code organization and maintainability:
> 
> Key changes:
> - Add `ocierofs_get_api_registry()` and unify API endpoint selection.
> - Implement Bearer token discovery with Basic fallback; cache auth header.
> - Parse layer metadata (digest, mediaType, size) and add a proper free helper.
> - Split blob download from tar processing; process tar via a temp fd.
> - Rework init/teardown into `ocierofs_init()` and `ocierofs_ctx_cleanup()`.
> - Update mkfs to use `struct ocierofs_config` and new `--oci` parsing.
> 
> Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
> ---
>   lib/liberofs_oci.h |  84 ++---
>   lib/remotes/oci.c  | 885 ++++++++++++++++++++++++++-------------------
>   mkfs/main.c        | 192 ++--------
>   3 files changed, 566 insertions(+), 595 deletions(-)
> 
> diff --git a/lib/liberofs_oci.h b/lib/liberofs_oci.h
> index 3a8108b..d119a2b 100644
> --- a/lib/liberofs_oci.h
> +++ b/lib/liberofs_oci.h
> @@ -8,85 +8,65 @@
>   
>   #include <stdbool.h>
>   
> -#define DOCKER_REGISTRY "docker.io"
> -#define DOCKER_API_REGISTRY "registry-1.docker.io"
> -
>   #ifdef __cplusplus
>   extern "C" {
>   #endif
>   
> -struct erofs_inode;
> -struct CURL;
>   struct erofs_importer;
>   
> -/**
> - * struct erofs_oci_params - OCI configuration parameters
> - * @registry: registry hostname (e.g., "registry-1.docker.io")
> - * @repository: image repository (e.g., "library/ubuntu")
> - * @tag: image tag or digest (e.g., "latest" or sha256:...)
> +/*
> + * struct ocierofs_config - OCI configuration structure
> + * @image_ref: OCI image reference (e.g., "ubuntu:latest", "myregistry.com/app:v1.0")
>    * @platform: target platform in "os/arch" format (e.g., "linux/amd64")
>    * @username: username for authentication (optional)
>    * @password: password for authentication (optional)
>    * @layer_index: specific layer to extract (-1 for all layers)
>    *
> - * Configuration structure for OCI image parameters including registry
> - * location, image identification, platform specification, and authentication
> - * credentials.
>    */
> -struct erofs_oci_params {
> -	char *registry;
> -	char *repository;
> -	char *tag;
> +struct ocierofs_config {
> +	char *image_ref;
>   	char *platform;
>   	char *username;
>   	char *password;
>   	int layer_index;
>   };
>   
> -/**
> - * struct erofs_oci - Combined OCI client structure
> - * @curl: CURL handle for HTTP requests
> - * @params: OCI configuration parameters
> - *
> - * Main OCI client structure combining CURL HTTP client with
> - * OCI-specific configuration parameters.
> - */
> -struct erofs_oci {
> -	struct CURL *curl;
> -	struct erofs_oci_params params;
> +struct ocierofs_layer_info {
> +	char *digest;
> +	char *media_type;
> +	u64 size;
>   };
>   
> -/*
> - * ocierofs_init - Initialize OCI client with default parameters
> - * @oci: OCI client structure to initialize
> - *
> - * Return: 0 on success, negative errno on failure
> - */
> -int ocierofs_init(struct erofs_oci *oci);
> +struct ocierofs_ctx {
> +	struct {
> +		struct CURL *curl;
> +		char *auth_header;
> +		bool using_basic;
> +	} net;

Is it necessary to use two anonymous structures here?

Could we just unfold those fields?

...

> diff --git a/mkfs/main.c b/mkfs/main.c
> index bc895f1..5e8da7a 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -150,18 +150,18 @@ static void usage(int argc, char **argv)
>   				 * "0-9,100-109" instead of a continuous "0-109", and to
>   				 * state what those two subranges respectively mean.  */
>   				printf("%s  [,level=<0-9,100-109>]\t0-9=normal, 100-109=extreme (default=%i)\n",
> -				       spaces, s->c->default_level);
> +			       spaces, s->c->default_level);
>   			else
>   				printf("%s  [,level=<0-%i>]\t\t(default=%i)\n",
> -				       spaces, s->c->best_level, s->c->default_level);
> +			       spaces, s->c->best_level, s->c->default_level);
>   		}
>   		if (s->c->setdictsize) {
>   			if (s->c->default_dictsize)
>   				printf("%s  [,dictsize=<dictsize>]\t(default=%u, max=%u)\n",
> -				       spaces, s->c->default_dictsize, s->c->max_dictsize);
> +			       spaces, s->c->default_dictsize, s->c->max_dictsize);
>   			else
>   				printf("%s  [,dictsize=<dictsize>]\t(default=<auto>, max=%u)\n",
> -				       spaces, s->c->max_dictsize);
> +			       spaces, s->c->max_dictsize);

Are those changes unnecessary?

>   		}
>   	}
>   	printf(
> @@ -272,7 +272,7 @@ static struct erofs_s3 s3cfg;
>   #endif
>   
>   #ifdef OCIEROFS_ENABLED
> -static struct erofs_oci ocicfg;
> +static struct ocierofs_config ocicfg;
>   static char *mkfs_oci_options;
>   #endif
>   
> @@ -689,21 +689,14 @@ static int mkfs_parse_s3_cfg(char *cfg_str)
>   #endif
>   
>   #ifdef OCIEROFS_ENABLED
> -
> -
> -/**
> - * mkfs_parse_oci_options - Parse comma-separated OCI options string
> +/*
> + * mkfs_parse_oci_options - Parse OCI options for mkfs tool
> + * @cfg: OCI configuration structure to update
>    * @options_str: comma-separated options string
> - *
> - * Parse OCI options string containing comma-separated key=value pairs.
> - * Supported options include platform, layer, username, and password.
> - *
> - * Return: 0 on success, negative errno on failure
>    */
> -static int mkfs_parse_oci_options(char *options_str)
> +static int mkfs_parse_oci_options(struct ocierofs_config *oci_cfg, char *options_str)
>   {
>   	char *opt, *q, *p;
> -	int ret;
>   
>   	if (!options_str)
>   		return 0;
> @@ -717,41 +710,38 @@ static int mkfs_parse_oci_options(char *options_str)
>   		p = strstr(opt, "platform=");
>   		if (p) {
>   			p += strlen("platform=");
> -			ret = erofs_oci_params_set_string(&ocicfg.params.platform, p);
> -			if (ret) {
> -				erofs_err("failed to set platform");
> -				return ret;
> -			}
> +			free(oci_cfg->platform);
> +			oci_cfg->platform = strdup(p);
> +			if (!oci_cfg->platform)
> +				return -ENOMEM;
>   		} else {
>   			p = strstr(opt, "layer=");
>   			if (p) {
>   				p += strlen("layer=");
> -				ocicfg.params.layer_index = atoi(p);
> -				if (ocicfg.params.layer_index < 0) {
> +				oci_cfg->layer_index = atoi(p);
> +				if (oci_cfg->layer_index < 0) {

Could you just use `strtoul` since it can check invalid
arguments better?

>   					erofs_err("invalid layer index %d",
> -						  ocicfg.params.layer_index);
> +					  oci_cfg->layer_index);
>   					return -EINVAL;
>   				}
>   			} else {
>   				p = strstr(opt, "username=");
>   				if (p) {
>   					p += strlen("username=");
> -					ret = erofs_oci_params_set_string(&ocicfg.params.username, p);
> -					if (ret) {
> -						erofs_err("failed to set username");
> -						return ret;
> -					}
> +					free(oci_cfg->username);
> +					oci_cfg->username = strdup(p);
> +					if (!oci_cfg->username)
> +						return -ENOMEM;
>   				} else {
>   					p = strstr(opt, "password=");
>   					if (p) {
>   						p += strlen("password=");
> -						ret = erofs_oci_params_set_string(&ocicfg.params.password, p);
> -						if (ret) {
> -							erofs_err("failed to set password");
> -							return ret;
> -						}
> +											free(oci_cfg->password);
> +					oci_cfg->password = strdup(p);
> +					if (!oci_cfg->password)
> +						return -ENOMEM;
>   					} else {
> -						erofs_err("invalid --oci value %s", opt);
> +						erofs_err("mkfs: invalid --oci value %s", opt);

`mkfs:` prefix is unneeded.

Thanks,
Gao Xiang

