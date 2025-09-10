Return-Path: <linux-erofs+bounces-1004-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FCFB50D04
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Sep 2025 07:10:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cM80Q5vnzz3cjS;
	Wed, 10 Sep 2025 15:10:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757481046;
	cv=none; b=EU3mJLZwAnkVtdztEH+LwXDu7Z85P3PwnEoTZ/j4L1Jkz1VOaYcGHkI2bPCVtC21ocIQNKs3Pe9gSLd9LVJzNPuDTTmg9jId6MCaWWa+OX/aZucKRYLLep+f2W9jkgUnYdqWil5Ned/06GFppmc8SGblxCE/ZJxgeT3p9NWpGnlRXdFkTq5x8G++9gWyIJGUbs5FwQlYEdtYEV9j5XXGgQCijwj8k7l0cljHMWrvwT2nkQ9m6zBWWtmddWJhWnh5Vmq1NFBlRR9B6v3TYZahG4n3MX24GWLbXOZtbiXfv+f3zAQkagw3BSt4YudDtyxLDV7Ez8+H0fsmLu/QX3W3Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757481046; c=relaxed/relaxed;
	bh=EsFfqLFjpTRFY5sbi0o3Mxz51Om1CMGiah+qKIFb/dY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X9oXflZd2iyHw0656L8KRUwn4g8YCIwqLKGl5H+UmWjvVXHOgCiUlxblQrPbY5p9NtXaLz11auCsCXuH07klb/DauAO2igmOlCTHMjPPKLiKBf93lQUDxitVvu/7Qpr5qz17BcD8r+EWVvX67oxrmy+HfNTlnAHZOoWJbdFLMZUZRjRLrjTSQaJWgFEI15WFJYGYg3cSwlrc/3slwTXpRfn/6cNm0ef/w0NIFjI/wxoR2NNRqtAr7DHdbmvXbNU7wwlrF/u6SwbRmaMLa4j2q4IcH8h3vIRH8YNRAKdPitq/DhdKOm9A4Kq1s02MLVea+TdGeHS0bOk+2trwwMKuCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qUHSmH7C; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qUHSmH7C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cM80N67XKz3cjR
	for <linux-erofs@lists.ozlabs.org>; Wed, 10 Sep 2025 15:10:43 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757481039; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=EsFfqLFjpTRFY5sbi0o3Mxz51Om1CMGiah+qKIFb/dY=;
	b=qUHSmH7Cn2RuE8MGFj0AQJKOZ/CAbTwYazLcRTI3KNvSZHMAJnIyEcZ9S+ymBSvBLr+BblGWdmHTT5Uo5alW+3r9HjzUoT+qXFgbyrTERydXoHkwiyYXffB9u60YQx/15U+bS9K0kse9EunyLoMsy+LL3LpjvBWUMDdZj21vZFY=
Received: from 30.221.131.126(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wngc2Px_1757481036 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 10 Sep 2025 13:10:37 +0800
Message-ID: <9d6aca5f-c971-41d8-8550-729afdcd53f3@linux.alibaba.com>
Date: Wed, 10 Sep 2025 13:10:36 +0800
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
Subject: Re: [PATCH v6] erofs-utils: mount: add OCI recovery support for NBD
 reattach
To: ChengyuZhu6 <hudson@cyzhu.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, Chengyu Zhu <hudsonzhu@tencent.com>
References: <20250909070909.83921-1-hudson@cyzhu.com>
 <20250910034418.13262-1-hudson@cyzhu.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250910034418.13262-1-hudson@cyzhu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/9/10 11:44, ChengyuZhu6 wrote:
> From: Chengyu Zhu <hudsonzhu@tencent.com>
> 
> This commit implements recovery support for OCI-based NBD mounts,
> allowing the system to properly reattach NBD devices after
> NBD disconnection.
> 
> Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
> ---
>   lib/liberofs_oci.h |   3 +
>   lib/remotes/oci.c  |  77 +++++++++++++++++++++++
>   mount/main.c       | 153 ++++++++++++++++++++++++++++++++++++---------
>   3 files changed, 205 insertions(+), 28 deletions(-)
> 
> diff --git a/lib/liberofs_oci.h b/lib/liberofs_oci.h
> index 01a83aa..aa41141 100644
> --- a/lib/liberofs_oci.h
> +++ b/lib/liberofs_oci.h
> @@ -71,6 +71,9 @@ int ocierofs_build_trees(struct erofs_importer *importer,
>   			 const struct ocierofs_config *cfg);
>   int ocierofs_io_open(struct erofs_vfile *vf, const struct ocierofs_config *cfg);
>   
> +char *ocierofs_encode_userpass(const char *username, const char *password);
> +int ocierofs_decode_userpass(const char *b64, char **out_user, char **out_pass);
> +
>   #ifdef __cplusplus
>   }
>   #endif
> diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
> index de18daa..7f16741 100644
> --- a/lib/remotes/oci.c
> +++ b/lib/remotes/oci.c
> @@ -24,6 +24,7 @@
>   #include "erofs/io.h"
>   #include "erofs/print.h"
>   #include "erofs/tar.h"
> +#include "liberofs_base64.h"
>   #include "liberofs_oci.h"
>   #include "liberofs_private.h"
>   
> @@ -1471,6 +1472,82 @@ int ocierofs_io_open(struct erofs_vfile *vfile, const struct ocierofs_config *cf
>   	*(struct ocierofs_iostream **)vfile->payload = oci_iostream;
>   	return 0;
>   }
> +
> +char *ocierofs_encode_userpass(const char *username, const char *password)
> +{
> +	size_t ulen = username ? strlen(username) : 0;
> +	size_t plen = password ? strlen(password) : 0;
> +	size_t inlen = ulen + 1 + plen;
> +	size_t outlen;
> +	unsigned char *buf;
> +	char *out;
> +	int ret;
> +
> +	buf = malloc(inlen + 1);
> +	if (!buf)
> +		return ERR_PTR(-ENOMEM);
> +	memcpy(buf, username ? username : "", ulen);
> +	buf[ulen] = ':';
> +	memcpy(buf + ulen + 1, password ? password : "", plen);
> +	buf[inlen] = '\0';

Just:
	asprintf(buf, "%s:%s", username ?: "",
	         password ?: "");

> +
> +	outlen = 4 * ((inlen + 2) / 3);

It seems like
`outlen = 4 * DIV_ROUND_UP(inlen, 3);`

> +	out = malloc(outlen + 1);
> +	if (!out) {
> +		free(buf);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +	ret = erofs_base64_encode(buf, inlen, out);
> +	if (ret < 0) {
> +		free(buf);
> +		free(out);
> +		return ERR_PTR(ret);
> +	}
> +	out[ret] = '\0';
> +	free(buf);
> +	return out;
> +}
> +
> +int ocierofs_decode_userpass(const char *b64, char **out_user, char **out_pass)
> +{
> +	size_t len;
> +	unsigned char *out;
> +	int ret;
> +	char *colon;
> +
> +	if (!b64 || !out_user || !out_pass)
> +		return -EINVAL;
> +	*out_user = NULL;
> +	*out_pass = NULL;
> +
> +	len = strlen(b64);
> +	out = malloc(len * 3 / 4 + 1);
> +	if (!out)
> +		return -ENOMEM;
> +	ret = erofs_base64_decode(b64, len, out);
> +	if (ret < 0) {
> +		free(out);
> +		return ret;
> +	}
> +	out[ret] = '\0';
> +	colon = (char *)memchr(out, ':', ret);
> +	if (!colon) {
> +		free(out);
> +		return -EINVAL;
> +	}
> +	*colon = '\0';
> +	*out_user = strdup((char *)out);
> +	*out_pass = strdup(colon + 1);
> +	free(out);
> +	if (!*out_user || !*out_pass) {
> +		free(*out_user);
> +		free(*out_pass);
> +		*out_user = *out_pass = NULL;
> +		return -ENOMEM;
> +	}
> +	return 0;
> +}
> +
>   #else
>   int ocierofs_io_open(struct erofs_vfile *vfile, const struct ocierofs_config *cfg)
>   {
> diff --git a/mount/main.c b/mount/main.c
> index c52ac3b..f6d0e1e 100644
> --- a/mount/main.c
> +++ b/mount/main.c
> @@ -401,10 +401,45 @@ out_closefd:
>   	return err;
>   }
>   
> -static char *erofsmount_write_recovery_info(const char *source)
> +static int erofsmount_write_recovery_oci(FILE *f, struct erofs_nbd_source *source)
> +{
> +	char *b64cred = NULL;
> +	int ret;
> +
> +	if (source->ocicfg.username || source->ocicfg.password) {
> +		b64cred = ocierofs_encode_userpass(
> +			source->ocicfg.username,
> +			source->ocicfg.password);
> +		if (IS_ERR(b64cred))
> +			return PTR_ERR(b64cred);
> +	}
> +	ret = fprintf(f, "OCI_LAYER %s %s %s %d\n",
> +		       source->ocicfg.image_ref ?: "",
> +		       source->ocicfg.platform ?: "",
> +		       b64cred ?: "",
> +		       source->ocicfg.layer_index);
> +	free(b64cred);
> +	return ret < 0 ? -ENOMEM : 0;
> +}
> +
> +static int erofsmount_write_recovery_local(FILE *f, struct erofs_nbd_source *source)
>   {
> -	char recp[] = "/var/run/erofs/mountnbd_XXXXXX";
>   	char *realp;
> +	int err;
> +
> +	realp = realpath(source->device_path, NULL);
> +	if (!realp)
> +		return -errno;
> +
> +	/* TYPE<LOCAL> <SOURCE PATH>\n(more..) */
> +	err = fprintf(f, "LOCAL %s\n", realp) < 0;
> +	free(realp);
> +	return err ? -ENOMEM : 0;
> +}
> +
> +static char *erofsmount_write_recovery_info(struct erofs_nbd_source *source)
> +{
> +	char recp[] = "/var/run/erofs/mountnbd_XXXXXX";
>   	int fd, err;
>   	FILE *f;
>   
> @@ -424,20 +459,77 @@ static char *erofsmount_write_recovery_info(const char *source)
>   		return ERR_PTR(-errno);
>   	}
>   
> -	realp = realpath(source, NULL);
> -	if (!realp) {
> -		fclose(f);
> -		return ERR_PTR(-errno);
> +	if (source->type == EROFSNBD_SOURCE_OCI) {
> +		err = erofsmount_write_recovery_oci(f, source);
> +		if (err) {
> +			fclose(f);
> +			return ERR_PTR(err);
> +		}
> +	} else {
> +		err = erofsmount_write_recovery_local(f, source);
> +		if (err) {
> +			fclose(f);
> +			return ERR_PTR(err);
> +		}
>   	}
> -	/* TYPE<LOCAL> <SOURCE PATH>\n(more..) */
> -	err = fprintf(f, "LOCAL %s\n", realp) < 0;
> +
>   	fclose(f);
> -	free(realp);
> -	if (err)
> -		return ERR_PTR(-ENOMEM);
>   	return strdup(recp) ?: ERR_PTR(-ENOMEM);
>   }
>   
> +/**
> + * Parses input string in format: "image_ref [platform] [b64cred_or_layer] [layer]"
> + * Supports 4 scenarios:
> + * 1. "image_ref platform" - basic format with platform
> + * 2. "image_ref platform layer" - with layer index only
> + * 3. "image_ref platform b64cred" - with base64 credentials
> + * 4. "image_ref platform b64cred layer" - with both credentials and layer

what's the extract behavior of case 1,3, I think we should just bail out instead?

so that I think the order should be
"<image_ref> <platform> <layer num> [b64cred]" instead.

Thanks,
Gao Xiang

