Return-Path: <linux-erofs+bounces-997-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F8BB4AAF3
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Sep 2025 12:55:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cLggy0WlXz30Pl;
	Tue,  9 Sep 2025 20:54:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757415294;
	cv=none; b=kW2Zs4QOUL1XRBEeqd53AZz2vm186RrUEGnqqhZ2MYuq6D/n2H/P/eEjGsOekfpUkxJf1SjuQN2cZ5Fha9evMENKVHU8qNLpuJ8b1aXjFk3i9cCjwiahmgSN0g3/2GGRmPDtJauWVieiQQJrCqJ4gMKSiPnibeKMZrjV0M8H+5k9I5Wd/1MCQEK+3RMe2KIBD3AJ4+VfeADYHnNb88eC/WbmLkaWvTK05sIdayqlpra6R1vgFaXPG1Bcbaq4JVLMCPNOqJq3J5yxyaMCcdqm3lOXuzDETNTvDpAjVWxNnJrj50EvgGvMY7tbWDlqW3N3XGWvMDdGbaPD9SJ1JX2SPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757415294; c=relaxed/relaxed;
	bh=KLEkdQSoDdGD3+U+PflRq23E1RsLyED8p0MIJEOCXp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VqwGmAAwBWW9xMHOwPwrrj9QtzHsUSx848+xZT1sQjKWrXTXgE4/QsZEZS/kRkEbNgADPFpW6jfHpAZQWlk4sY7RqV8AHjzA2Rt47zA9Cfa9iVfqPZPo+p7uNu8L0wsXCL2+GC3sWVR1+HO2TNtA4jGypiCtBiHrNZStaw7aSZiaqmfcGhAfjO+rGGHEJCagML/h/UXTLIsXggj8uYbb/eOSzY6Ahq5n1E3QrrpUdNCKTanM/SB+B0yZWgPgBGSY+9DPmFj4SaRYTXx/6ZS4HwC/O4LKXpVVXFAwC0B+gfTDIkP3ZIPAS4EpTzqKgnxSHDLkQZ1WQyteJMXDG3VR5Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=l96hPYRp; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=l96hPYRp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cLggv6Mkrz30M0
	for <linux-erofs@lists.ozlabs.org>; Tue,  9 Sep 2025 20:54:49 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757415286; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=KLEkdQSoDdGD3+U+PflRq23E1RsLyED8p0MIJEOCXp0=;
	b=l96hPYRp9msokmMX6mEDLl+694IqbkQp9T+9M82NbAjSzU3VHPpxs4KJsjbnHBOX3x2O+FW/IEl+NZABj5A19EKixd7Y3Sc9wvSVyMvrTZjR8VTs3yVol9aUOZ5/JAdivbk/OysfmPg8yU5SC47P+msfaU/UmYR+LujtaQEAlbs=
Received: from 30.221.131.27(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WndtrFL_1757415284 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 09 Sep 2025 18:54:44 +0800
Message-ID: <3ba78657-27cd-4c28-aeb4-97093cb91b76@linux.alibaba.com>
Date: Tue, 9 Sep 2025 18:54:43 +0800
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
Subject: Re: [PATCH v3] erofs-utils: mount: add OCI recovery support for NBD
 reattach
To: ChengyuZhu6 <hudson@cyzhu.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, Chengyu Zhu <hudsonzhu@tencent.com>
References: <20250909070909.83921-1-hudson@cyzhu.com>
 <20250909102801.90540-1-hudson@cyzhu.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250909102801.90540-1-hudson@cyzhu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/9/9 18:28, ChengyuZhu6 wrote:
> From: Chengyu Zhu <hudsonzhu@tencent.com>
> 
> This commit implements recovery support for OCI-based NBD mounts,
> allowing the system to properly reattach NBD devices after
> NBD disconnection.
> 
> Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
> ---
>   lib/liberofs_oci.h |   5 ++
>   lib/remotes/oci.c  | 129 +++++++++++++++++++++++++++++++++++++++++
>   mount/main.c       | 141 ++++++++++++++++++++++++++++++++++++---------
>   3 files changed, 247 insertions(+), 28 deletions(-)
> 
> diff --git a/lib/liberofs_oci.h b/lib/liberofs_oci.h
> index 01a83aa..e910e6a 100644
> --- a/lib/liberofs_oci.h
> +++ b/lib/liberofs_oci.h
> @@ -71,6 +71,11 @@ int ocierofs_build_trees(struct erofs_importer *importer,
>   			 const struct ocierofs_config *cfg);
>   int ocierofs_io_open(struct erofs_vfile *vf, const struct ocierofs_config *cfg);
>   
> +int ocierofs_b64_encode_userpass(const char *username, const char *password,
> +				 char **out_b64);
> +int ocierofs_b64_decode_userpass(const char *b64,
> +				 char **out_user, char **out_pass);
> +
>   #ifdef __cplusplus
>   }
>   #endif
> diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
> index de18daa..4e46e0b 100644
> --- a/lib/remotes/oci.c
> +++ b/lib/remotes/oci.c
> @@ -1471,6 +1471,135 @@ int ocierofs_io_open(struct erofs_vfile *vfile, const struct ocierofs_config *cf
>   	*(struct ocierofs_iostream **)vfile->payload = oci_iostream;
>   	return 0;
>   }
> +
> +static const char ocierofs_b64_tbl[] =
> +	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
> +
> +int ocierofs_b64_encode_userpass(const char *username, const char *password,
> +				 char **out_b64)

I think ocierofs_encode_userpass() is enough.


> +{
> +	const unsigned char *in;
> +	size_t ulen = username ? strlen(username) : 0;
> +	size_t plen = password ? strlen(password) : 0;
> +	size_t inlen = ulen + 1 + plen;
> +	size_t outlen;
> +	unsigned char *buf;
> +	char *out;
> +	size_t i, j;
> +	unsigned int octet_a, octet_b, octet_c, triple;
> +
> +	if (!out_b64)
> +		return -EINVAL;
> +	*out_b64 = NULL;
> +
> +	buf = malloc(inlen + 1);
> +	if (!buf)
> +		return -ENOMEM;
> +	memcpy(buf, username ? username : "", ulen);
> +	buf[ulen] = ':';
> +	memcpy(buf + ulen + 1, password ? password : "", plen);
> +	buf[inlen] = '\0';
> +	in = buf;
> +
> +	outlen = 4 * ((inlen + 2) / 3);
> +	out = malloc(outlen + 1);
> +	if (!out) {
> +		free(buf);
> +		return -ENOMEM;
> +	}
> +
> +	for (i = 0, j = 0; i < inlen;) {
> +		octet_a = i < inlen ? in[i++] : 0;
> +		octet_b = i < inlen ? in[i++] : 0;
> +		octet_c = i < inlen ? in[i++] : 0;
> +		triple = (octet_a << 16) | (octet_b << 8) | octet_c;
> +		out[j++] = ocierofs_b64_tbl[(triple >> 18) & 0x3F];
> +		out[j++] = ocierofs_b64_tbl[(triple >> 12) & 0x3F];
> +		out[j++] = (i - 1 > inlen) ? '=' : ocierofs_b64_tbl[(triple >> 6) & 0x3F];
> +		out[j++] = (i > inlen) ? '=' : ocierofs_b64_tbl[triple & 0x3F];
> +	}
> +	if (inlen % 3 == 1) {
> +		out[outlen - 1] = '=';
> +		out[outlen - 2] = '=';
> +	} else if (inlen % 3 == 2) {
> +		out[outlen - 1] = '=';
> +	}
> +	out[outlen] = '\0';
> +	free(buf);
> +	*out_b64 = out;
> +	return 0;
> +}
> +
> +static int ocierofs_b64_inv(int c)
> +{
> +	if (c >= 'A' && c <= 'Z')
> +		return c - 'A';
> +	if (c >= 'a' && c <= 'z')
> +		return c - 'a' + 26;
> +	if (c >= '0' && c <= '9')
> +		return c - '0' + 52;
> +	if (c == '+')
> +		return 62;
> +	if (c == '/')
> +		return 63;
> +	return -1;
> +}
> +
> +int ocierofs_b64_decode_userpass(const char *b64,
> +				 char **out_user, char **out_pass)

same ocierofs_decode_userpass().


Also lib/tar.c already has base64_decode(), I wonder
if it's can be reused.


> +{
> +	size_t len, i, j;
> +	unsigned char *out;
> +	int val = 0, valb = -8, c;
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
> +
> +	for (i = 0, j = 0; i < len; i++) {
> +		c = b64[i];
> +
> +		if (c == '=')
> +			break;
> +		c = ocierofs_b64_inv(c);
> +		if (c < 0)
> +			continue;
> +		val = (val << 6) + c;
> +		valb += 6;
> +		if (valb >= 0) {
> +			out[j++] = (unsigned char)((val >> valb) & 0xFF);
> +			valb -= 8;
> +		}
> +	}
> +	out[j] = '\0';
> +
> +	{
> +		char *colon = (char *)memchr(out, ':', j);
> +
> +		if (!colon) {
> +			free(out);
> +			return -EINVAL;
> +		}
> +		*colon = '\0';
> +		*out_user = strdup((char *)out);
> +		*out_pass = strdup(colon + 1);
> +		free(out);
> +		if (!*out_user || !*out_pass) {
> +			free(*out_user);
> +			free(*out_pass);
> +			*out_user = *out_pass = NULL;
> +			return -ENOMEM;
> +		}
> +	}
> +	return 0;
> +}
> +
>   #else
>   int ocierofs_io_open(struct erofs_vfile *vfile, const struct ocierofs_config *cfg)
>   {
> diff --git a/mount/main.c b/mount/main.c
> index c52ac3b..4fe54c5 100644
> --- a/mount/main.c
> +++ b/mount/main.c
> @@ -401,10 +401,48 @@ out_closefd:
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
> +		ret = ocierofs_b64_encode_userpass(
> +			source->ocicfg.username,
> +			source->ocicfg.password,
> +			&b64cred);

I think you could just return `char *` or ERR_PTR(-ENOMEM)

Thanks,
Gao Xiang

