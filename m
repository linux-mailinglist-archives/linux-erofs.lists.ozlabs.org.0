Return-Path: <linux-erofs+bounces-964-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8866CB431CE
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Sep 2025 07:53:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cHTDT4x8lz2xns;
	Thu,  4 Sep 2025 15:53:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756965209;
	cv=none; b=Tk+3OC994dUo7YYYSNKp0OrKBGqFyBJNxaywHotkLiyv2uqeJF6vLtZxGxbg2/HFb/ZIwwZa7FmT5j5shvBOUY+kKi5A08Q3ROSG1uEGSYLnCGswJ5f4TjHLHX8ozKFNO7/ctrvSlsE8G4/+TQjxJCw9KDJzgJZWw0+ko4FpzUiXMPkFt0WwuFEGgykr5JFIkLKAbnY+MPxfv63yaSNCW1HVvBvq6KuqexyJ5okc3g73MaE5OmIiNmPEcFEtu80RF32M6uK/oPfVgDrEaZy/0pGEvSTSWBd7dID5O/xyEfaOcfbBRzT+otT52IJvwIZ4cMoHr/xkgmPETPJTDscAZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756965209; c=relaxed/relaxed;
	bh=4ukTJH+GQFC99poUH/NgsI7Y9tq8FB4tDcA2Ko/jzac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RGPlHrpj+DBN4DOT1KX00UF7aPixRVpioEEMxR5n3Q8U1Uvg77eyjLIeafsueoyfaWF1SbWC+rgc196nIc76DkBW+oahae0gpUBG1ta6l2h0dRqoxoy59gE799maERRtKMMk5re/JzSdxvOJNOqMXHNlE0d8InlOIWKijhsrgmip+RxcB+1iaQ4XhPUIwLaENN0aSj2YIs+XctgAo3dNVRPBuD+AT3giXkiPUPbyix3xViv2cA//pF6TGHsmGLJhiIe2W1nTdd77jpvDUFXzko8Ls9iihaRJjOklngZp227/ScIwYrdfo/07/AZdo9vv+N7WPfzyAsONkCjif+LgZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=w32nS7w6; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=w32nS7w6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cHTDR4xzJz2xQ5
	for <linux-erofs@lists.ozlabs.org>; Thu,  4 Sep 2025 15:53:26 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756965202; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4ukTJH+GQFC99poUH/NgsI7Y9tq8FB4tDcA2Ko/jzac=;
	b=w32nS7w6fPnX/0Brets5b1AxqrmnQUdl3pFOlPH9UrAYLERDUEQEZqKBeFtkWke4ptQT3SCWbvNMzI38B7XJcGH3jOiK2FAeBfWtw3bsiYUQyz86O4+gORLc27as/onic8RJwzFv07GEXKF5+r4dEDk+ZKdC/hSG+YPLVtMOg1E=
Received: from 30.221.132.160(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WnEZNBM_1756965200 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 04 Sep 2025 13:53:21 +0800
Message-ID: <0ddb7258-3502-4eeb-bf17-e1362b00a291@linux.alibaba.com>
Date: Thu, 4 Sep 2025 13:53:18 +0800
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
Subject: Re: [PATCH v4 2/3] erofs-utils: refactor OCI code for better
 modularity
To: ChengyuZhu6 <hudson@cyzhu.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, Chengyu Zhu <hudsonzhu@tencent.com>
References: <20250901051042.10905-1-hudson@cyzhu.com>
 <20250904053314.65700-1-hudson@cyzhu.com>
 <20250904053314.65700-3-hudson@cyzhu.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250904053314.65700-3-hudson@cyzhu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Chengyu,

On 2025/9/4 13:33, ChengyuZhu6 wrote:
> From: Chengyu Zhu <hudsonzhu@tencent.com>

..

> @@ -96,6 +142,14 @@ static int ocierofs_curl_setup_common_options(struct CURL *curl)
>   	curl_easy_setopt(curl, CURLOPT_TIMEOUT, 120L);
>   	curl_easy_setopt(curl, CURLOPT_NOSIGNAL, 1L);
>   	curl_easy_setopt(curl, CURLOPT_USERAGENT, "ocierofs/" PACKAGE_VERSION);
> +	curl_easy_setopt(curl, CURLOPT_ACCEPT_ENCODING, "");
> +	curl_easy_setopt(curl, CURLOPT_TCP_KEEPALIVE, 1L);
> +#if defined(CURLOPT_TCP_KEEPIDLE)
> +	curl_easy_setopt(curl, CURLOPT_TCP_KEEPIDLE, 30L);
> +#endif
> +#if defined(CURLOPT_TCP_KEEPINTVL)
> +	curl_easy_setopt(curl, CURLOPT_TCP_KEEPINTVL, 15L);
> +#endif
>   	return 0;
>   }
>   
> @@ -114,10 +168,10 @@ static int ocierofs_curl_setup_basic_auth(struct CURL *curl, const char *usernam
>   	return 0;
>   }
>   
> -static int ocierofs_curl_clear_auth(struct CURL *curl)
> +static int ocierofs_curl_clear_auth(struct ocierofs_ctx *ctx)
>   {
> -	curl_easy_setopt(curl, CURLOPT_USERPWD, NULL);
> -	curl_easy_setopt(curl, CURLOPT_HTTPAUTH, CURLAUTH_NONE);
> +	curl_easy_setopt(ctx->curl, CURLOPT_USERPWD, NULL);
> +	curl_easy_setopt(ctx->curl, CURLOPT_HTTPAUTH, CURLAUTH_NONE);
>   	return 0;
>   }
>   
> @@ -176,20 +230,20 @@ static int ocierofs_curl_perform(struct CURL *curl, long *http_code_out)
>   	return 0;
>   }
>   
> -static int ocierofs_request_perform(struct erofs_oci *oci,
> -				    struct erofs_oci_request *req,
> -				    struct erofs_oci_response *resp)
> +static int ocierofs_request_perform(struct ocierofs_ctx *ctx,
> +				   

...

>   
> @@ -204,15 +258,10 @@ static int ocierofs_request_perform(struct erofs_oci *oci,
>    * @realm_out: pointer to store realm value
>    * @service_out: pointer to store service value
>    * @scope_out: pointer to store scope value
> - *
> - * Parse Bearer authentication header and extract realm, service, and scope
> - * parameters for subsequent token requests.
> - *
> - * Return: 0 on success, negative errno on failure

Why do we drop this comment?

>    */
>   static int ocierofs_parse_auth_header(const char *auth_header,
> -				      char **realm_out, char **service_out,
> -				      char **scope_out)
> +			      char **realm_out, char **service_out,
> +			      char **scope_out)

Let's not adjust lines which are unrelated to the commit.

>   {
>   	char *realm = NULL, *service = NULL, *scope = NULL;
>   	static const char * const param_names[] = {"realm=", "service=", "scope="};
> @@ -221,7 +270,6 @@ static int ocierofs_parse_auth_header(const char *auth_header,
>   	const char *p;
>   	int i, ret = 0;
>   
> -	// https://datatracker.ietf.org/doc/html/rfc6750#section-3

Same here.

>   	if (strncmp(auth_header, "Bearer ", strlen("Bearer ")))
>   		return -EINVAL;
>   
> @@ -229,7 +277,6 @@ static int ocierofs_parse_auth_header(const char *auth_header,
>   	if (!header_copy)
>   		return -ENOMEM;
>   
> -	/* Clean up header: replace newlines with spaces and remove double spaces */

Same here.

If they are unrelated to the new feature, let's refine
ocierofs_parse_auth_header() later.

>   	for (char *q = header_copy; *q; q++) {
>   		if (*q == '\n' || *q == '\r')
>   			*q = ' ';
> @@ -277,22 +324,9 @@ out:
>   	return ret;
>   }
>   
> -/**
> - * ocierofs_extract_www_auth_info - Extract WWW-Authenticate header information
> - * @resp_data: HTTP response data containing headers
> - * @realm_out: pointer to store realm value (optional)
> - * @service_out: pointer to store service value (optional)
> - * @scope_out: pointer to store scope value (optional)
> - *
> - * Extract realm, service, and scope from WWW-Authenticate header in HTTP response.
> - * This function handles the common pattern of parsing WWW-Authenticate headers
> - * that appears in multiple places in the OCI authentication flow.
> - *
> - * Return: 0 on success, negative errno on failure
> - */

Same here.

>   static int ocierofs_extract_www_auth_info(const char *resp_data,
> -					  char **realm_out, char **service_out,
> -					  char **scope_out)
> +				  char **realm_out, char **service_out,
> +				  char **scope_out)

Same here.

>   {>   	char *www_auth;
>   	char *line_end;
> @@ -336,29 +370,12 @@ static int ocierofs_extract_www_auth_info(const char *resp_data,
>   	return ret;
>   }
>   
> -/**
> - * ocierofs_get_auth_token_with_url - Get authentication token from auth server
> - * @oci: OCI client structure
> - * @auth_url: authentication server URL
> - * @service: service name for authentication
> - * @repository: repository name
> - * @username: username for basic auth (optional)
> - * @password: password for basic auth (optional)
> - *
> - * Request authentication token from the specified auth server URL using
> - * basic authentication if credentials are provided.
> - *
> - * Return: authentication header string on success, ERR_PTR on failure
> - */
> -static char *ocierofs_get_auth_token_with_url(struct erofs_oci *oci,
> -					      const char *auth_url,
> -					      const char *service,
> -					      const char *repository,
> -					      const char *username,
> -					      const char *password)
> +static char *ocierofs_get_auth_token_with_url(struct ocierofs_ctx *ctx, const char *auth_url,
> +					      const char *service, const char *repository,
> +					      const char *username, const char *password)

Since the arguments are changed, I'm fine with this change.

>   {
> -	struct erofs_oci_request req = {};
> -	struct erofs_oci_response resp = {};
> +	struct ocierofs_request req = {};
> +	struct ocierofs_response resp = {};
>   	json_object *root, *token_obj, *access_token_obj;
>   	const char *token;
>   	char *auth_header = NULL;
> @@ -373,40 +390,36 @@ static char *ocierofs_get_auth_token_with_url(struct erofs_oci *oci,
>   	}
>   
>   	if (username && password && *username) {
> -		ret = ocierofs_curl_setup_basic_auth(oci->curl, username,
> -						     password);
> +		ret = ocierofs_curl_setup_basic_auth(ctx->curl, username,
> +					     password);

Password can be aligned with `(` in the previous line?

>   		if (ret)
>   			goto out_url;
>   	}
>   
> -	ret = ocierofs_request_perform(oci, &req, &resp);
> -	ocierofs_curl_clear_auth(oci->curl);
> +	ret = ocierofs_request_perform(ctx, &req, &resp);
> +	ocierofs_curl_clear_auth(ctx);
>   	if (ret)
>   		goto out_url;
>   
>   	if (!resp.data) {
> -		erofs_err("empty response from auth server");

Why drop this?

>   		ret = -EINVAL;
>   		goto out_url;
>   	}
>   
>   	root = json_tokener_parse(resp.data);
>   	if (!root) {
> -		erofs_err("failed to parse auth response");

Why drop this?

>   		ret = -EINVAL;
> -		goto out_url;
> +		goto out_json;
>   	}
>   
>   	if (!json_object_object_get_ex(root, "token", &token_obj) &&
>   	    !json_object_object_get_ex(root, "access_token", &access_token_obj)) {
> -		erofs_err("no token found in auth response");

Why drop this?

>   		ret = -EINVAL;
>   		goto out_json;
>   	}
>   
>   	token = json_object_get_string(token_obj ? token_obj : access_token_obj);
>   	if (!token) {
> -		erofs_err("invalid token in auth response");

Why drop this?


...

>   		auth_service = discovered_service ? discovered_service : service;
> -		auth_header = ocierofs_get_auth_token_with_url(oci, discovered_auth_url,
> -							       auth_service, repository,
> -							       username, password);
> +		auth_header = ocierofs_get_auth_token_with_url(ctx, discovered_auth_url,
> +				       auth_service, repository,
> +				       username, password);

Same here.

>   		free(discovered_auth_url);
>   		free(discovered_service);
>   		if (!IS_ERR(auth_header))
> @@ -544,9 +555,9 @@ static char *ocierofs_get_auth_token(struct erofs_oci *oci, const char *registry
>   		if (asprintf(&auth_url, auth_patterns[i], registry) < 0)
>   			continue;
>   
> -		auth_header = ocierofs_get_auth_token_with_url(oci, auth_url,
> -							       service, repository,
> -							       username, password);
> +		auth_header = ocierofs_get_auth_token_with_url(ctx, auth_url,
> +				       service, repository,
> +				       username, password);

Same here.

>   		free(auth_url);
>   
>   		if (!IS_ERR(auth_header))
> @@ -557,24 +568,21 @@ static char *ocierofs_get_auth_token(struct erofs_oci *oci, const char *registry
>   	return ERR_PTR(-ENOENT);
>   }
>   
> -static char *ocierofs_get_manifest_digest(struct erofs_oci *oci,
> -					  const char *registry,
> -					  const char *repository, const char *tag,
> -					  const char *platform,
> -					  const char *auth_header)
> +static char *ocierofs_get_manifest_digest(struct ocierofs_ctx *ctx,
> +				  const char *registry,
> +				  const char *repository, const char *tag,
> +				  const char *platform,
> +				  const char *auth_header)
>   {
> -	struct erofs_oci_request req = {};
> -	struct erofs_oci_response resp = {};
> +	struct ocierofs_request req = {};
> +	struct ocierofs_response resp = {};
>   	json_object *root, *manifests, *manifest, *platform_obj, *arch_obj;
>   	json_object *os_obj, *digest_obj, *schema_obj, *media_type_obj;
>   	char *digest = NULL;
>   	const char *api_registry;
>   	int ret = 0, len, i;
>   
> -	if (!registry || !repository || !tag || !platform)
> -		return ERR_PTR(-EINVAL);
> -
> -	api_registry = (!strcmp(registry, DOCKER_REGISTRY)) ? DOCKER_API_REGISTRY : registry;
> +	api_registry = ocierofs_get_api_registry(registry);
>   	if (asprintf(&req.url, "https://%s/v2/%s/manifests/%s",
>   	     api_registry, repository, tag) < 0)
>   		return ERR_PTR(-ENOMEM);
> @@ -584,22 +592,20 @@ static char *ocierofs_get_manifest_digest(struct erofs_oci *oci,
>   
>   	req.headers = curl_slist_append(req.headers,
>   		"Accept: " DOCKER_MEDIATYPE_MANIFEST_LIST ","
> -		OCI_MEDIATYPE_INDEX "," DOCKER_MEDIATYPE_MANIFEST_V1 ","
> -		DOCKER_MEDIATYPE_MANIFEST_V2);
> +		OCI_MEDIATYPE_INDEX "," OCI_MEDIATYPE_MANIFEST ","
> +		DOCKER_MEDIATYPE_MANIFEST_V1 "," DOCKER_MEDIATYPE_MANIFEST_V2);
>   
> -	ret = ocierofs_request_perform(oci, &req, &resp);
> +	ret = ocierofs_request_perform(ctx, &req, &resp);
>   	if (ret)
>   		goto out;
>   
>   	if (!resp.data) {
> -		erofs_err("empty response from manifest request");

Same here.

>   		ret = -EINVAL;
>   		goto out;
>   	}
>   
>   	root = json_tokener_parse(resp.data);
>   	if (!root) {
> -		erofs_err("failed to parse manifest JSON");

Same here.

>   		ret = -EINVAL;
>   		goto out;
>   	}
> @@ -615,8 +621,7 @@ static char *ocierofs_get_manifest_digest(struct erofs_oci *oci,
>   	if (json_object_object_get_ex(root, "mediaType", &media_type_obj)) {
>   		const char *media_type = json_object_get_string(media_type_obj);
>   
> -		if (!strcmp(media_type, DOCKER_MEDIATYPE_MANIFEST_V2) ||
> -		    !strcmp(media_type, OCI_MEDIATYPE_MANIFEST)) {
> +		if (ocierofs_is_manifest(media_type)) {
>   			digest = strdup(tag);
>   			ret = 0;
>   			goto out_json;
> @@ -624,7 +629,6 @@ static char *ocierofs_get_manifest_digest(struct erofs_oci *oci,
>   	}
>   
>   	if (!json_object_object_get_ex(root, "manifests", &manifests)) {
> -		erofs_err("no manifests found in manifest list");

Same here.

>   		ret = -EINVAL;
>   		goto out_json;
>   	}
> @@ -634,9 +638,9 @@ static char *ocierofs_get_manifest_digest(struct erofs_oci *oci,
>   		manifest = json_object_array_get_idx(manifests, i);
>   
>   		if (json_object_object_get_ex(manifest, "platform",
> -					      &platform_obj) &&
> +				      &platform_obj) &&

No need to change.

>   		    json_object_object_get_ex(platform_obj, "architecture",
> -					      &arch_obj) &&
> +				      &arch_obj) &&

No need to change.


...
> -						}
> +					free(oci_cfg->password);
> +					oci_cfg->password = strdup(p);
> +					if (!oci_cfg->password)
> +						return -ENOMEM;
>   					} else {
> -						erofs_err("invalid --oci value %s", opt);
> +						erofs_err("mkfs: invalid --oci value %s", opt);

Unneeded `mkfs:`.


Thanks,
Gao Xiang

