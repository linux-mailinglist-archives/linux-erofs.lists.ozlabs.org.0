Return-Path: <linux-erofs+bounces-1421-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C3BC78077
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Nov 2025 10:00:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dCThk4Vvpz2yD5;
	Fri, 21 Nov 2025 20:00:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763715654;
	cv=none; b=iu0LMg0kK+KNDBsVHCIJpez66vn41nChNAHwMz9ZdnVpkx9gx9A5Rr+IKB3efufIPYNVnPT0dSvxChNkwlcGCOJy/R+0437mMAi2ZOCShQRAP90QeP1eW6kbNSai8Bx8ssNUnJOfDZu1UzsjhRWMB7O2+8LaJeds+iphjUf4fM1NiWhjbLs7VDjfJBhQeue7IoV5FEv0/Bu/rCRdXYIqPsAhKwoD+mAVfnywDDhUvIR+/JQoLXs6t5wYI4cOr+NjzCq4po8edDaJSckZllacFX3OC/to6pvZI7+uP8SVIvvAnVH7Q6x/iV3wkkNIj8XEJEekS93aWIGBwHs17lJHZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763715654; c=relaxed/relaxed;
	bh=ODX3SHQPkSNNyJwFmjPAzgmz+3TssL6//RA4ovQTtr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bXPIPZoRzhzHBAhpjZmePzlm9F+CtXDGIWtAuc1bbjntCM6oORNATsvYrCkUn7cbXwXX01i15S1BIMuSag6C6a6dJDIGzSG8UTs2HgRDr02AuULJ/mf+s1PP2RGPA5AblYB7ZACec6ab0pNek/JvdvNv3MiXzWzSizMzTme1zdVSuNvpY/7phgZxpJA6jZkwn8/57SuYBCY4GHVFqEsjloJ/CeezudfVydddTbecuuSMhQUFciq6yI4I2aij9gMN3BXv5hpgn6bw0HEqW2mbkhRCxtcwESGP/Hbuu4oRZ1FpQWy9Xn0JYLDxa0UFfumW62N5jc/CiCEBshebb+nK3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=j5C61iNS; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=j5C61iNS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dCThg6FBxz2xqh
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Nov 2025 20:00:49 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763715644; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ODX3SHQPkSNNyJwFmjPAzgmz+3TssL6//RA4ovQTtr0=;
	b=j5C61iNS9P77xZpJ4QXYGJXt8lIVxUhL1joDmulsybOI9Vt0exs9M4T+/kjEYOclOr5n8bW/pPc/0/uCfJjN7pjwFBTD2EGjYr29nEVYczIZUE6lsCdFCs9j94zADzFbanee3RD8EyUKGxZc+zDrs2rg8CvAM0J1ppZOJl8NiT4=
Received: from 30.221.131.79(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wt..9lz_1763715642 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 21 Nov 2025 17:00:43 +0800
Message-ID: <9c78f293-9536-4463-9c25-817937e40cc2@linux.alibaba.com>
Date: Fri, 21 Nov 2025 17:00:42 +0800
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
Subject: Re: [PATCH 2/2] erofs-utils: lib: support AWS SigV4 for S3 backend
To: Yifan Zhao <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: wayne.ma@huawei.com, jingrui@huawei.com
References: <20251120092215.3635202-1-zhaoyifan28@huawei.com>
 <20251120092215.3635202-2-zhaoyifan28@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251120092215.3635202-2-zhaoyifan28@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Yifan,

On 2025/11/20 17:22, Yifan Zhao wrote:
> This patch introduces support for AWS Signature Version 4 for s3erofs
> remote backend.
> 
> Now users can specify the folowing options:
>   - passwd_file=Y, S3 credentials file in the format $ak:$sk (optional);
>   - urlstyle=<vhost, path>, S3 API calling style (optional);
>   - sig=<2,4>, S3 API signature version (optional);
>   - region=W, region code for S3 endpoint (required for sig=4).
> 
> e.g.:
> mkfs.erofs \
>      --s3=s3.us-east-1.amazonaws.com,sig=4,region=us-east-1 \
>      output.img some_bucket/path/to/object

Thanks for the effort!

Could we find a public s3 bucket and post here as an example?

> 
> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
> ---
>   lib/liberofs_s3.h |   1 +
>   lib/remotes/s3.c  | 567 +++++++++++++++++++++++++++++++++++++---------
>   mkfs/main.c       |  14 +-
>   3 files changed, 471 insertions(+), 111 deletions(-)
> 
> diff --git a/lib/liberofs_s3.h b/lib/liberofs_s3.h
> index f2ec822..f4886cd 100644
> --- a/lib/liberofs_s3.h
> +++ b/lib/liberofs_s3.h
> @@ -27,6 +27,7 @@ enum s3erofs_signature_version {
>   struct erofs_s3 {
>   	void *easy_curl;
>   	const char *endpoint;
> +	const char *region;
>   	char access_key[S3_ACCESS_KEY_LEN + 1];
>   	char secret_key[S3_SECRET_KEY_LEN + 1];
>   
> diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
> index 0f7e1a9..3263dd7 100644
> --- a/lib/remotes/s3.c
> +++ b/lib/remotes/s3.c
> @@ -23,7 +23,8 @@
>   #define S3EROFS_PATH_MAX		1024
>   #define S3EROFS_MAX_QUERY_PARAMS	16
>   #define S3EROFS_URL_LEN			8192
> -#define S3EROFS_CANONICAL_QUERY_LEN	2048
> +#define S3EROFS_CANONICAL_URI_LEN	1024

Is there a spec to document that?

> +#define S3EROFS_CANONICAL_QUERY_LEN	S3EROFS_URL_LEN
>   
>   #define BASE64_ENCODE_LEN(len)	(((len + 2) / 3) * 4)
>   
> @@ -34,52 +35,142 @@ struct s3erofs_query_params {
>   };
>   
>   struct s3erofs_curl_request {
> -	const char *method;

It seems it's removed... S3 only allows `GET` method?

>   	char url[S3EROFS_URL_LEN];
> +	char canonical_uri[S3EROFS_CANONICAL_URI_LEN];
>   	char canonical_query[S3EROFS_CANONICAL_QUERY_LEN];
>   };
>   
> +static const char *s3erofs_parse_host(const char *endpoint, const char **schema) {

K&R style is:

static const char *s3erofs_parse_host()
{
	if (!tmp) {
		...
	} else {
		...
	}

}

> +	const char *tmp = strstr(endpoint, "://");
> +	const char *host;
> +
> +	if (!tmp) {
> +		host = endpoint;
> +		if (schema)
> +			*schema = NULL;
> +	} else {
> +		host = tmp + sizeof("://") - 1;
> +		if (schema) {
> +			*schema = strndup(endpoint, host - endpoint);
> +			if (!*schema)
> +				return ERR_PTR(-ENOMEM);
> +		}
> +	}
> +
> +	return host;
> +}
> +
> +static int s3erofs_urlencode(const char *input, char **output)
> +{

static void *s3erofs_urlencode(const char *input)
{
	char *output;

	output = malloc(strlen(input) * 3 + 1);
	if (!output)
		return ERR_PTR(-ENOMEM);

	...

	return output;

}

> +	static const char hex[] = "0123456789ABCDEF";
> +	int i;
> +	char c, *p;
> +
> +	*output = malloc(strlen(input) * 3 + 1);
> +	if (!*output)
> +		return -ENOMEM;
> +
> +	p = *output;
> +	for (i = 0; i < strlen(input); ++i) {
> +		c = (unsigned char)input[i];
> +
> +		// Unreserved characters: A-Z a-z 0-9 - . _ ~
> +		if ((c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z') ||
> +		    (c >= '0' && c <= '9') || c == '-' || c == '.' || c == '_' ||
> +		    c == '~') {
> +			*p++ = c;
> +		} else {
> +			*p++ = '%';
> +			*p++ = hex[c >> 4];
> +			*p++ = hex[c & 0x0F];
> +		}
> +	}
> +	*p = '\0';
> +
> +	return 0;
> +}
> +
> +struct kv_pair {
> +	char *key;
> +	char *value;
> +};
> +
> +static int compare_kv_pair(const void *a, const void *b)
> +{
> +	return strcmp(((const struct kv_pair *)a)->key, ((const struct kv_pair *)b)->key);
> +}
> +
> +static int s3erofs_prepare_canonical_query(struct s3erofs_curl_request *req,
> +					   struct s3erofs_query_params *params)
> +{
> +	struct kv_pair *pairs;
> +	int i, pos = 0, ret = 0;
> +
> +	if (params->num == 0)

	if (!params->num) {
	}

> +		return 0;
> +
> +	pairs = malloc(sizeof(struct kv_pair) * params->num);
> +	for (i = 0; i < params->num; i++) {
> +		ret = s3erofs_urlencode(params->key[i], &pairs[i].key);
> +		if (ret < 0)
> +			goto out;
> +		ret = s3erofs_urlencode(params->value[i], &pairs[i].value);

Why we use urlencoding now?

Thanks,
Gao Xiang

