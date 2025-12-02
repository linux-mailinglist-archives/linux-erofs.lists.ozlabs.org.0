Return-Path: <linux-erofs+bounces-1476-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B43C9A7E0
	for <lists+linux-erofs@lfdr.de>; Tue, 02 Dec 2025 08:40:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dLCNn6xtGz3bnv;
	Tue, 02 Dec 2025 18:40:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764661225;
	cv=none; b=hnV8jDUyR4dQsgdiJUyRpG0MYB/SwYSsUayh/JMCVQiLSnDjJty3226XHlClZ6ZdFz+WI/bIAzgyOyMHTdlC/FwqQ/DP8vlKyfILnnjMXvmx8rmFx1ysOK7MZIPsogaDqZAM01uKTK8K//+W82NIQfZZHzVy6sKeH43P2PtZ3SRNC1GM9j6wXMb16S7ZKgdbbjFxnXRhiBw8ZQNWyYKpI0Oc+wxnCnFPWbvpaOkjmIMGziqu2en9/0A0KYMXxCMLo59aBHL/4f3V57Y66x/nLNnSwJJCX8IFPEFa04Vpkf19ui8tR1gjF7hqAfX0w9Cl1+jCCD1vcp4w/Lqw10kdcw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764661225; c=relaxed/relaxed;
	bh=MKAMq9WhDMk2lRJN0y4KQzYBUOpgwPfwnZVRTjPe8oU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Om8A1JhE4lvVMPWEkOrJQfO1kFkpew+KCIWvAOB/jZ+U3SOnlP/8baUU6Z/3xZEbyPzfblg6Lx2c69Tb56WHh9gHyUrTMKKGBEBhKYv6k7Vvq8vHv4sV4CY2AkDPmLmPPNuFMmPd20s82T5vhcieg2A5k2YTYXGVbL0e8CnAIqGsLjeKRPvnBesU1J0qNRwh1Ffyk8qDTn07DppZS/6OU0pc9BiXl+ti+bj4zbiBHOoPqRYc0zvL6mzmAiR0CPbDBd2+iUU0sy8p0bgqBWrvLPgVfrMBfSviXQRULo627v+hfMTcYrREpifX9bvwNOHkgnUir97yKGdF8v1EDS+URg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=oh8svMpA; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=oh8svMpA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dLCNl4Y1wz3bnL
	for <linux-erofs@lists.ozlabs.org>; Tue, 02 Dec 2025 18:40:21 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764661217; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=MKAMq9WhDMk2lRJN0y4KQzYBUOpgwPfwnZVRTjPe8oU=;
	b=oh8svMpAOoeUMT24iSYw2ogulkNQNiCWPdFr9VmZr+Vi7HZFvdzjv2OplZZFMoWUt/dehmzJk7uo7IeBQ2YVBKj+dNdmOOryWGT7CTn1TG8UbAe9ka2hQEKZwdodfW9lc8b5RlcLTO4O2UiPNmgCSeSSRLNXkT0m+1zo2uvyznE=
Received: from 30.221.131.182(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WtvdWw._1764661216 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Dec 2025 15:40:16 +0800
Message-ID: <65b4743c-8720-4493-aff1-8cc73e606f53@linux.alibaba.com>
Date: Tue, 2 Dec 2025 15:40:15 +0800
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
To: "zhaoyifan (H)" <zhaoyifan28@huawei.com>, hudsonZhu <hudson@cyzhu.com>
Cc: linux-erofs@lists.ozlabs.org, hudsonzhu@tencent.com, wayne.ma@huawei.com,
 jingrui@huawei.com
References: <20251130104257.877660-1-zhaoyifan28@huawei.com>
 <20251130104257.877660-2-zhaoyifan28@huawei.com>
 <812452D6-5119-46D0-B173-C65291D16307@cyzhu.com>
 <2d654f7f-86d0-485a-814f-1edf02caa16b@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <2d654f7f-86d0-485a-814f-1edf02caa16b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Yifan,

Would you mind updating mkfs.erofs manpage too?

Thanks,
Gao Xiang

On 2025/12/1 19:15, zhaoyifan (H) wrote:
> Hi Chengyu,
> 
> Thanks for your review. I will try to deal with `mount.erofs` later.
> 
> 
> Thanks,
> 
> Yifan Zhao
> 
> 
> On 2025/12/1 17:25, hudsonZhu wrote:
>> Thanks for this patch, Yifan !
>>
>> It looks good to me. I have tested the patch and it works as expected.
>> One suggestion: it would be nice to have similar functionality in
>> mount.erofs as well, for consistency across the toolkit.
>>
>> Reviewed-and-tested-by: Chengyu Zhu <hudsonzhu@tencent.com>
>>
>> Thanks,
>> Chengyu
>>
>>> 2025年11月30日 18:42，Yifan Zhao <zhaoyifan28@huawei.com> 写道：
>>>
>>> Currently, the URL used to send requests to the registry is hardcoded
>>> with "https://". This patch introduces an optional insecure option for
>>> `--oci`, enabling registry access via the HTTP protocol.
>>>
>>> Also, this patch refactors the deeply nested logic in the `--oci`
>>> argument parsing.
>>>
>>> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
>>> ---
>>> lib/liberofs_oci.h |  3 ++
>>> lib/remotes/oci.c  | 40 +++++++++++--------
>>> mkfs/main.c        | 97 ++++++++++++++++++++--------------------------
>>> 3 files changed, 70 insertions(+), 70 deletions(-)
>>>
>>> diff --git a/lib/liberofs_oci.h b/lib/liberofs_oci.h
>>> index 5298f18..9e0571f 100644
>>> --- a/lib/liberofs_oci.h
>>> +++ b/lib/liberofs_oci.h
>>> @@ -23,6 +23,7 @@ struct erofs_importer;
>>>   * @password: password for authentication (optional)
>>>   * @blob_digest: specific blob digest to extract (NULL for all layers)
>>>   * @layer_index: specific layer index to extract (negative for all layers)
>>> + * @insecure: use HTTP for registry communication (optional)
>>>   *
>>>   * Configuration structure for OCI image parameters including registry
>>>   * location, image identification, platform specification, and authentication
>>> @@ -37,6 +38,7 @@ struct ocierofs_config {
>>>     int layer_index;
>>>     char *tarindex_path;
>>>     char *zinfo_path;
>>> +    bool insecure;
>>> };
>>>
>>> struct ocierofs_layer_info {
>>> @@ -57,6 +59,7 @@ struct ocierofs_ctx {
>>>     struct ocierofs_layer_info **layers;
>>>     char *blob_digest;
>>>     int layer_count;
>>> +    const char *schema;
>>> };
>>>
>>> struct ocierofs_iostream {
>>> diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
>>> index c1d6cae..d5afd6a 100644
>>> --- a/lib/remotes/oci.c
>>> +++ b/lib/remotes/oci.c
>>> @@ -496,8 +496,8 @@ static char *ocierofs_discover_auth_endpoint(struct ocierofs_ctx *ctx,
>>>
>>>     api_registry = ocierofs_get_api_registry(registry);
>>>
>>> -    if (asprintf(&test_url, "https://%s/v2/%s/manifests/nonexistent",
>>> -         api_registry, repository) < 0)
>>> +    if (asprintf(&test_url, "%s%s/v2/%s/manifests/nonexistent",
>>> +         ctx->schema, api_registry, repository) < 0)
>>>         return NULL;
>>>
>>>     curl_easy_reset(ctx->curl);
>>> @@ -528,9 +528,9 @@ static char *ocierofs_get_auth_token(struct ocierofs_ctx *ctx, const char *regis
>>>                      const char *password)
>>> {
>>>     static const char * const auth_patterns[] = {
>>> -        "https://%s/v2/auth",
>>> -        "https://auth.%s/token",
>>> -        "https://%s/token",
>>> +        "%s%s/v2/auth",
>>> +        "%sauth.%s/token",
>>> +        "%s%s/token",
>>>         NULL,
>>>     };
>>>     char *auth_header = NULL;
>>> @@ -561,8 +561,8 @@ static char *ocierofs_get_auth_token(struct ocierofs_ctx *ctx, const char *regis
>>>
>>>         api_registry = ocierofs_get_api_registry(registry);
>>>
>>> -        if (asprintf(&test_url, "https://%s/v2/%s/manifests/nonexistent",
>>> -             api_registry, repository) >= 0) {
>>> +        if (asprintf(&test_url, "%s%s/v2/%s/manifests/nonexistent",
>>> +             ctx->schema, api_registry, repository) >= 0) {
>>>             curl_easy_reset(ctx->curl);
>>>             ocierofs_curl_setup_common_options(ctx->curl);
>>>
>>> @@ -598,7 +598,7 @@ static char *ocierofs_get_auth_token(struct ocierofs_ctx *ctx, const char *regis
>>>     for (i = 0; auth_patterns[i]; i++) {
>>>         char *auth_url;
>>>
>>> -        if (asprintf(&auth_url, auth_patterns[i], registry) < 0)
>>> +        if (asprintf(&auth_url, auth_patterns[i], ctx->schema, registry) < 0)
>>>             continue;
>>>
>>>         auth_header = ocierofs_get_auth_token_with_url(ctx, auth_url,
>>> @@ -629,8 +629,8 @@ static char *ocierofs_get_manifest_digest(struct ocierofs_ctx *ctx,
>>>     int ret = 0, len, i;
>>>
>>>     api_registry = ocierofs_get_api_registry(registry);
>>> -    if (asprintf(&req.url, "https://%s/v2/%s/manifests/%s",
>>> -         api_registry, repository, tag) < 0)
>>> +    if (asprintf(&req.url, "%s%s/v2/%s/manifests/%s",
>>> +         ctx->schema, api_registry, repository, tag) < 0)
>>>         return ERR_PTR(-ENOMEM);
>>>
>>>     if (auth_header && strstr(auth_header, "Bearer"))
>>> @@ -749,8 +749,8 @@ static int ocierofs_fetch_layers_info(struct ocierofs_ctx *ctx)
>>>     ctx->layer_count = 0;
>>>     api_registry = ocierofs_get_api_registry(registry);
>>>
>>> -    if (asprintf(&req.url, "https://%s/v2/%s/manifests/%s",
>>> -             api_registry, repository, digest) < 0)
>>> +    if (asprintf(&req.url, "%s%s/v2/%s/manifests/%s",
>>> +             ctx->schema, api_registry, repository, digest) < 0)
>>>         return -ENOMEM;
>>>
>>>     if (auth_header && strstr(auth_header, "Bearer"))
>>> @@ -1124,10 +1124,18 @@ static int ocierofs_init(struct ocierofs_ctx *ctx, const struct ocierofs_config
>>>     if (!ctx->registry || !ctx->tag || !ctx->platform)
>>>         return -ENOMEM;
>>>
>>> +    ctx->schema = config->insecure ? "http://" : "https://";
>>> +
>>>     ret = ocierofs_parse_ref(ctx, config->image_ref);
>>>     if (ret)
>>>         return ret;
>>>
>>> +    if (config->insecure && (!strcmp(ctx->registry, DOCKER_API_REGISTRY) ||
>>> +                 !strcmp(ctx->registry, DOCKER_REGISTRY))) {
>>> +        erofs_err("Insecure connection to Docker registry is not allowed");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>>     ret = ocierofs_prepare_layers(ctx, config);
>>>     if (ret)
>>>         return ret;
>>> @@ -1152,8 +1160,8 @@ static int ocierofs_download_blob_to_fd(struct ocierofs_ctx *ctx,
>>>     };
>>>
>>>     api_registry = ocierofs_get_api_registry(ctx->registry);
>>> -    if (asprintf(&req.url, "https://%s/v2/%s/blobs/%s",
>>> -         api_registry, ctx->repository, digest) == -1)
>>> +    if (asprintf(&req.url, "%s%s/v2/%s/blobs/%s",
>>> +         ctx->schema, api_registry, ctx->repository, digest) == -1)
>>>         return -ENOMEM;
>>>
>>>     if (auth_header && strstr(auth_header, "Bearer"))
>>> @@ -1344,8 +1352,8 @@ static int ocierofs_download_blob_range(struct ocierofs_ctx *ctx, off_t offset,
>>>         length = (size_t)(blob_size - offset);
>>>
>>>     api_registry = ocierofs_get_api_registry(ctx->registry);
>>> -    if (asprintf(&req.url, "https://%s/v2/%s/blobs/%s",
>>> -         api_registry, ctx->repository, digest) == -1)
>>> +    if (asprintf(&req.url, "%s%s/v2/%s/blobs/%s",
>>> +         ctx->schema, api_registry, ctx->repository, digest) == -1)
>>>         return -ENOMEM;
>>>
>>>     if (length)
>>> diff --git a/mkfs/main.c b/mkfs/main.c
>>> index 7aa8eae..5710948 100644
>>> --- a/mkfs/main.c
>>> +++ b/mkfs/main.c
>>> @@ -218,11 +218,12 @@ static void usage(int argc, char **argv)
>>> #endif
>>> #ifdef OCIEROFS_ENABLED
>>>         " --oci=[f|i]           generate a full (f) or index-only (i) image from OCI remote source\n"
>>> -        "   [,=platform=X]      X=platform (default: linux/amd64)\n"
>>> +        "   [,platform=X]       X=platform (default: linux/amd64)\n"
>>>         "   [,layer=#]          #=layer index to extract (0-based; omit to extract all layers)\n"
>>>         "   [,blob=Y]           Y=blob digest to extract (omit to extract all layers)\n"
>>>         "   [,username=Z]       Z=username for authentication (optional)\n"
>>>         "   [,password=W]       W=password for authentication (optional)\n"
>>> +        "   [,insecure]         use HTTP instead of HTTPS (optional)\n"
>>> #endif
>>>         " --tar=X               generate a full or index-only image from a tarball(-ish) source\n"
>>>         "                       (X = f|i|headerball; f=full mode, i=index mode,\n"
>>> @@ -744,7 +745,7 @@ static int mkfs_parse_s3_cfg(char *cfg_str)
>>>   * Parse OCI options string containing comma-separated key=value pairs.
>>>   *
>>>   * Supported options include f|i, platform, blob|layer, username, password,
>>> - * and zinfo.
>>> + * and insecure.
>>>   *
>>>   * Return: 0 on success, negative errno on failure
>>>   */
>>> @@ -772,67 +773,55 @@ static int mkfs_parse_oci_options(struct ocierofs_config *oci_cfg, char *options
>>>         if (q)
>>>             *q = '\0';
>>>
>>> -
>>> -        p = strstr(opt, "platform=");
>>> -        if (p) {
>>> +        if ((p = strstr(opt, "platform="))) {
>>>             p += strlen("platform=");
>>>             free(oci_cfg->platform);
>>>             oci_cfg->platform = strdup(p);
>>>             if (!oci_cfg->platform)
>>>                 return -ENOMEM;
>>> -        } else {
>>> -            p = strstr(opt, "blob=");
>>> -            if (p) {
>>> -                p += strlen("blob=");
>>> -                free(oci_cfg->blob_digest);
>>> +        } else if ((p = strstr(opt, "blob="))) {
>>> +            p += strlen("blob=");
>>> +            free(oci_cfg->blob_digest);
>>>
>>> -                if (oci_cfg->layer_index >= 0) {
>>> -                    erofs_err("invalid --oci: blob and layer cannot be set together");
>>> -                    return -EINVAL;
>>> -                }
>>> +            if (oci_cfg->layer_index >= 0) {
>>> +                erofs_err("invalid --oci: blob and layer cannot be set together");
>>> +                return -EINVAL;
>>> +            }
>>>
>>> -                if (!strncmp(p, "sha256:", 7)) {
>>> -                    oci_cfg->blob_digest = strdup(p);
>>> -                    if (!oci_cfg->blob_digest)
>>> -                        return -ENOMEM;
>>> -                } else if (asprintf(&oci_cfg->blob_digest, "sha256:%s", p) < 0) {
>>> +            if (!strncmp(p, "sha256:", 7)) {
>>> +                oci_cfg->blob_digest = strdup(p);
>>> +                if (!oci_cfg->blob_digest)
>>>                     return -ENOMEM;
>>> -                }
>>> -            } else {
>>> -                p = strstr(opt, "layer=");
>>> -                if (p) {
>>> -                    p += strlen("layer=");
>>> -                    if (oci_cfg->blob_digest) {
>>> -                        erofs_err("invalid --oci: layer and blob cannot be set together");
>>> -                        return -EINVAL;
>>> -                    }
>>> -                    idx = strtol(p, NULL, 10);
>>> -                    if (idx < 0)
>>> -                        return -EINVAL;
>>> -                    oci_cfg->layer_index = (int)idx;
>>> -                } else {
>>> -                    p = strstr(opt, "username=");
>>> -                    if (p) {
>>> -                        p += strlen("username=");
>>> -                        free(oci_cfg->username);
>>> -                        oci_cfg->username = strdup(p);
>>> -                        if (!oci_cfg->username)
>>> -                            return -ENOMEM;
>>> -                    } else {
>>> -                        p = strstr(opt, "password=");
>>> -                        if (p) {
>>> -                            p += strlen("password=");
>>> -                            free(oci_cfg->password);
>>> -                            oci_cfg->password = strdup(p);
>>> -                            if (!oci_cfg->password)
>>> -                                return -ENOMEM;
>>> -                        } else {
>>> -                            erofs_err("mkfs: invalid --oci value %s", opt);
>>> -                            return -EINVAL;
>>> -                        }
>>> -                    }
>>> -                }
>>> +            } else if (asprintf(&oci_cfg->blob_digest, "sha256:%s", p) < 0) {
>>> +                return -ENOMEM;
>>>             }
>>> +        } else if ((p = strstr(opt, "layer="))) {
>>> +            p += strlen("layer=");
>>> +            if (oci_cfg->blob_digest) {
>>> +                erofs_err("invalid --oci: layer and blob cannot be set together");
>>> +                return -EINVAL;
>>> +            }
>>> +            idx = strtol(p, NULL, 10);
>>> +            if (idx < 0)
>>> +                return -EINVAL;
>>> +            oci_cfg->layer_index = (int)idx;
>>> +        } else if ((p = strstr(opt, "username="))) {
>>> +            p += strlen("username=");
>>> +            free(oci_cfg->username);
>>> +            oci_cfg->username = strdup(p);
>>> +            if (!oci_cfg->username)
>>> +                return -ENOMEM;
>>> +        } else if ((p = strstr(opt, "password="))) {
>>> +            p += strlen("password=");
>>> +            free(oci_cfg->password);
>>> +            oci_cfg->password = strdup(p);
>>> +            if (!oci_cfg->password)
>>> +                return -ENOMEM;
>>> +        } else if ((p = strstr(opt, "insecure"))) {
>>> +            oci_cfg->insecure = true;
>>> +        } else {
>>> +            erofs_err("mkfs: invalid --oci value %s", opt);
>>> +            return -EINVAL;
>>>         }
>>>
>>>         opt = q ? q + 1 : NULL;
>>> -- 
>>> 2.43.0
>>>


