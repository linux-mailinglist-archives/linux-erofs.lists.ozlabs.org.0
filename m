Return-Path: <linux-erofs+bounces-1430-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABF0C80745
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Nov 2025 13:27:10 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dFQ7F1ZKBz2xQq;
	Mon, 24 Nov 2025 23:27:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763987225;
	cv=none; b=mSFv0LnSMmwmuB4oqpuAqooVEDY6EmlfAeFSIBMLFRfyzfd8/O0E25oA5+7CEBU129HkJnO4wg4KrcMYjXNBqy7U8R0i70HTce6HG1fm1yYhNB5p3AY04243DEsfvObWiiFVCzUWHfF7ZSzjTo88aoHjC469KbHB4FBvtI2cOJV7YZUoO9wwWoWQ8n/LP/BmxhZ4xB6cyf0QgGZDAzx48NS5EUM2m3DhI8hbp/++VjBLkijpLzOPejqPckzpTjNvmF45+nz8C4sVf/35OB//jjF2flt+NI+QjbNssnHiQPKyw6Qch2l1rGEBrNTYxqTPx/UA6LsQCR6pJxJnY3o9Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763987225; c=relaxed/relaxed;
	bh=WVAlLbTOe+7U4bCzozW+jr5TZEpBdXQH7OxPEpvgXrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kYryh8EaDTFtcHR6q9z+VJpBdX3eK9llhP4lBmTis38TkvYmwLIe4SlfF0ST8ywpjRQ2B0BGIVIqhJQpu05ZYzAc/g2vNq0GW6X2ikwZJnuPXv27qNhqFNDjECU0X/tovYo/uq6cZJfSxQoYzLv92c1HH7hIfKPJ3hr9MKepQJhjzDvtQOxlSPIELVB6NhMROBCMuwpt49Sz5vinWNd6xSc0McVywuFmal0gojrV+yjVsWgbV28CLDGAMX9+Kbj0Xxd6kxTRqLUEK3QtyHs2oYzyQPyOvw3WHXAN63qaRb9G2lTsZw6f++jwv3C8Nbptr6fuevTSZMEGuKzivxZuJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=3vp6cacz; dkim-atps=neutral; spf=pass (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=3vp6cacz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dFQ796Gzdz2xPB
	for <linux-erofs@lists.ozlabs.org>; Mon, 24 Nov 2025 23:27:00 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=WVAlLbTOe+7U4bCzozW+jr5TZEpBdXQH7OxPEpvgXrk=;
	b=3vp6cacz41G+f88AlNNm3dUPIedkNTbHUaTUQlxSKV/xixTlSPANbWg8ONO5y7OlDe33DcIhB
	f6acRtAsNETl4WRpW7PzsXER/YEBgFK6S6a6oyv0gjD7a8PHlaBPsbYxfFFZlmkfO0G8LjDkmxc
	Sfod5Q721oKNvpJB24mhhug=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dFQ4T12Kmzcb16;
	Mon, 24 Nov 2025 20:24:41 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id BFB2C1401F2;
	Mon, 24 Nov 2025 20:26:52 +0800 (CST)
Received: from [100.103.109.96] (100.103.109.96) by
 kwepemr100010.china.huawei.com (7.202.195.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 24 Nov 2025 20:26:52 +0800
Message-ID: <5460a290-d1b5-4ae2-8f8b-8c8aff1a6d0e@huawei.com>
Date: Mon, 24 Nov 2025 20:26:51 +0800
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
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
CC: <wayne.ma@huawei.com>, <jingrui@huawei.com>
References: <20251120092215.3635202-1-zhaoyifan28@huawei.com>
 <20251120092215.3635202-2-zhaoyifan28@huawei.com>
 <9c78f293-9536-4463-9c25-817937e40cc2@linux.alibaba.com>
From: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
In-Reply-To: <9c78f293-9536-4463-9c25-817937e40cc2@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [100.103.109.96]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 2025/11/21 17:00, Gao Xiang wrote:

> Hi Yifan,
>
> On 2025/11/20 17:22, Yifan Zhao wrote:
>> This patch introduces support for AWS Signature Version 4 for s3erofs
>> remote backend.
>>
>> Now users can specify the folowing options:
>>   - passwd_file=Y, S3 credentials file in the format $ak:$sk (optional);
>>   - urlstyle=<vhost, path>, S3 API calling style (optional);
>>   - sig=<2,4>, S3 API signature version (optional);
>>   - region=W, region code for S3 endpoint (required for sig=4).
>>
>> e.g.:
>> mkfs.erofs \
>>      --s3=s3.us-east-1.amazonaws.com,sig=4,region=us-east-1 \
>>      output.img some_bucket/path/to/object
>
> Thanks for the effort!
>
> Could we find a public s3 bucket and post here as an example?

Hi Xiang,

I have found *noaa-goes19.s3.amazonaws.com* and update the commit msg.

>
>>
>> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
>> ---
>>   lib/liberofs_s3.h |   1 +
>>   lib/remotes/s3.c  | 567 +++++++++++++++++++++++++++++++++++++---------
>>   mkfs/main.c       |  14 +-
>>   3 files changed, 471 insertions(+), 111 deletions(-)
>>
>> diff --git a/lib/liberofs_s3.h b/lib/liberofs_s3.h
>> index f2ec822..f4886cd 100644
>> --- a/lib/liberofs_s3.h
>> +++ b/lib/liberofs_s3.h
>> @@ -27,6 +27,7 @@ enum s3erofs_signature_version {
>>   struct erofs_s3 {
>>       void *easy_curl;
>>       const char *endpoint;
>> +    const char *region;
>>       char access_key[S3_ACCESS_KEY_LEN + 1];
>>       char secret_key[S3_SECRET_KEY_LEN + 1];
>>   diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
>> index 0f7e1a9..3263dd7 100644
>> --- a/lib/remotes/s3.c
>> +++ b/lib/remotes/s3.c
>> @@ -23,7 +23,8 @@
>>   #define S3EROFS_PATH_MAX        1024
>>   #define S3EROFS_MAX_QUERY_PARAMS    16
>>   #define S3EROFS_URL_LEN            8192
>> -#define S3EROFS_CANONICAL_QUERY_LEN    2048
>> +#define S3EROFS_CANONICAL_URI_LEN    1024
>
> Is there a spec to document that?

Sorry, I made a mistake. The AWS documentation [1] explicitly specifies

that the maximum key length is 1024 bytes; therefore, setting the length

here to 1024 is unreasonable. I' ve reverted it back to 2048.

[1] https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-keys.html

>
>> +#define S3EROFS_CANONICAL_QUERY_LEN S3EROFS_URL_LEN
>>     #define BASE64_ENCODE_LEN(len)    (((len + 2) / 3) * 4)
>>   @@ -34,52 +35,142 @@ struct s3erofs_query_params {
>>   };
>>     struct s3erofs_curl_request {
>> -    const char *method;
>
> It seems it's removed... S3 only allows `GET` method?

In our foreseeable usage scenarios, we will not modify the OBS bucket;

therefore, I believe we can use only the GET method to reduce the

number of unnecessary parameters.

>
>>       char url[S3EROFS_URL_LEN];
>> +    char canonical_uri[S3EROFS_CANONICAL_URI_LEN];
>>       char canonical_query[S3EROFS_CANONICAL_QUERY_LEN];
>>   };
>>   +static const char *s3erofs_parse_host(const char *endpoint, const 
>> char **schema) {
>
> K&R style is:
>
> static const char *s3erofs_parse_host()
> {
>     if (!tmp) {
>         ...
>     } else {
>         ...
>     }
>
> }
>
Fixed.
>> +    const char *tmp = strstr(endpoint, "://");
>> +    const char *host;
>> +
>> +    if (!tmp) {
>> +        host = endpoint;
>> +        if (schema)
>> +            *schema = NULL;
>> +    } else {
>> +        host = tmp + sizeof("://") - 1;
>> +        if (schema) {
>> +            *schema = strndup(endpoint, host - endpoint);
>> +            if (!*schema)
>> +                return ERR_PTR(-ENOMEM);
>> +        }
>> +    }
>> +
>> +    return host;
>> +}
>> +
>> +static int s3erofs_urlencode(const char *input, char **output)
>> +{
>
> static void *s3erofs_urlencode(const char *input)
> {
>     char *output;
>
>     output = malloc(strlen(input) * 3 + 1);
>     if (!output)
>         return ERR_PTR(-ENOMEM);
>
>     ...
>
>     return output;
>
> }
>
Fixed.
>> +    static const char hex[] = "0123456789ABCDEF";
>> +    int i;
>> +    char c, *p;
>> +
>> +    *output = malloc(strlen(input) * 3 + 1);
>> +    if (!*output)
>> +        return -ENOMEM;
>> +
>> +    p = *output;
>> +    for (i = 0; i < strlen(input); ++i) {
>> +        c = (unsigned char)input[i];
>> +
>> +        // Unreserved characters: A-Z a-z 0-9 - . _ ~
>> +        if ((c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z') ||
>> +            (c >= '0' && c <= '9') || c == '-' || c == '.' || c == 
>> '_' ||
>> +            c == '~') {
>> +            *p++ = c;
>> +        } else {
>> +            *p++ = '%';
>> +            *p++ = hex[c >> 4];
>> +            *p++ = hex[c & 0x0F];
>> +        }
>> +    }
>> +    *p = '\0';
>> +
>> +    return 0;
>> +}
>> +
>> +struct kv_pair {
>> +    char *key;
>> +    char *value;
>> +};
>> +
>> +static int compare_kv_pair(const void *a, const void *b)
>> +{
>> +    return strcmp(((const struct kv_pair *)a)->key, ((const struct 
>> kv_pair *)b)->key);
>> +}
>> +
>> +static int s3erofs_prepare_canonical_query(struct 
>> s3erofs_curl_request *req,
>> +                       struct s3erofs_query_params *params)
>> +{
>> +    struct kv_pair *pairs;
>> +    int i, pos = 0, ret = 0;
>> +
>> +    if (params->num == 0)
>
>     if (!params->num) {
>     }
>
Fixed.
>> +        return 0;
>> +
>> +    pairs = malloc(sizeof(struct kv_pair) * params->num);
>> +    for (i = 0; i < params->num; i++) {
>> +        ret = s3erofs_urlencode(params->key[i], &pairs[i].key);
>> +        if (ret < 0)
>> +            goto out;
>> +        ret = s3erofs_urlencode(params->value[i], &pairs[i].value);
>
> Why we use urlencoding now?
>
According to AWS docs [2] urlencoding is needed when Calculate 
*CanonicalQueryString*,

and custom UriEncode function is recommended to cover the (potential) 
semantic differerence.

[2] 
https://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-header-based-auth.html


Thanks,

Yifan Zhao

> Thanks,
> Gao Xiang

