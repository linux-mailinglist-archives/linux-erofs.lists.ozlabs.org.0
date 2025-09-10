Return-Path: <linux-erofs+bounces-1013-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838F7B50EC6
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Sep 2025 09:11:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cMBg92G82z3clh;
	Wed, 10 Sep 2025 17:11:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757488261;
	cv=none; b=Fha135ThAaW7+hW6ZtFJJoV/xq4fscBYuHKXppw8Uu7FhL5lIZ0G+IFntf1DoXFIg6Ec9rFJIaF8P4rrJpe6M8pZDywt0t3AYlGwcSTlCbIkZNhZLaW2AecdDCjpmM6eNefMnozYkqp+HMkz+RSMvitVQgVmwXncrq27XSDlapAFvmALVpmGNQ6obZd87jQBtJ3CZ7udx8/ntfYYaZSSHSDW4g2886LTdYu3epA+W0ZlUomLHIz+Tystdkk7Scq/IkfCf+pw9A+YA0a91Wivmp5/j2TwyfHjTKLHxM62LVnb2Kj0yBmlDxWr56EAA0loZQHlAodoW9AUeiBWzDfqhw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757488261; c=relaxed/relaxed;
	bh=uPiS6jETBhawOY1ik9oxoxTyitp9GQLix6LcZWtFk7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NRRGY0XsUPaJ1SIQNhdxlfABFyC9uQ5hFx5HDtEtqbaq2+mRddpTnczCwPoRfJJkNVQ7OJSljfTtcDdiKJG7EkFw7LJA025IBgJ4UbcUS/mJ9756LNHWedhP+r71D20dIcTRaSSvr7uQTcslyg9AHO4jNh1nteVA5kI2kZNyBs77s5WdVNXx1QmFegfIdD8aktjBPueVgBnTdjGXdpSnqEwY7d97jY1J/CWeC62VXtaBnWEnt4cid7FFlQMeZ7l5PxmtxWmlLSpI8lmTfEF9YcalfRkmUj2ykHz+Xar3xRGzgGTowpJFdtcD5yCltc7k2B8wXm5yQGpYTtg/3lKNkQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rL+5tvck; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rL+5tvck;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cMBg73LLSz3cl0
	for <linux-erofs@lists.ozlabs.org>; Wed, 10 Sep 2025 17:10:58 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757488254; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=uPiS6jETBhawOY1ik9oxoxTyitp9GQLix6LcZWtFk7s=;
	b=rL+5tvckjGk6N3C/BtxMvVSb/BvE3ViQwDTyJiCj5URYNG/P/V9lPZPOCYrX5P/bg7CHU1QCmR25bzpyZXBQtB/WZ/dQDdmDar1aLusM89uybTf5WV/DBrLC9JHvFDti050uK5WFmM3bBdBjUNgB5ZSL1Jik1pvSugVtQOiruVg=
Received: from 30.221.131.126(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wnh8Ame_1757488252 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 10 Sep 2025 15:10:52 +0800
Message-ID: <6feb9463-d18a-4f37-aa5a-ab0776bce0e7@linux.alibaba.com>
Date: Wed, 10 Sep 2025 15:10:52 +0800
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
Subject: Re: [PATCH v7] erofs-utils: mount: add OCI recovery support for NBD
 reattach
To: ChengyuZhu6 <hudson@cyzhu.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, Chengyu Zhu <hudsonzhu@tencent.com>
References: <20250909070909.83921-1-hudson@cyzhu.com>
 <20250910061302.84602-1-hudson@cyzhu.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250910061302.84602-1-hudson@cyzhu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/9/10 14:13, ChengyuZhu6 wrote:
> From: Chengyu Zhu <hudsonzhu@tencent.com>
> 
> This commit implements recovery support for OCI-based NBD mounts,
> allowing the system to properly reattach NBD devices after
> NBD disconnection.
> 
> Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
> ---
>   lib/liberofs_oci.h |   3 +
>   lib/remotes/oci.c  |  71 ++++++++++++++++++++++
>   mount/main.c       | 143 ++++++++++++++++++++++++++++++++++++---------
>   3 files changed, 189 insertions(+), 28 deletions(-)
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
> index de18daa..a00c04a 100644
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
> @@ -1471,6 +1472,76 @@ int ocierofs_io_open(struct erofs_vfile *vfile, const struct ocierofs_config *cf
>   	*(struct ocierofs_iostream **)vfile->payload = oci_iostream;
>   	return 0;
>   }
> +
> +char *ocierofs_encode_userpass(const char *username, const char *password)
> +{
> +	char *buf;
> +	char *out;
> +	int ret;
> +	size_t outlen;
> +	size_t inlen;
> +
> +	if (asprintf(&buf, "%s:%s", username ?: "", password ?: "") == -1)
> +		return ERR_PTR(-ENOMEM);

inlen can be gotten from the return value of `asprintf`...

> +
> +	inlen = strlen(buf);
> +	outlen = 4 * DIV_ROUND_UP(inlen, 3);
> +	out = malloc(outlen + 1);
> +	if (!out) {
> +		free(buf);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +	ret = erofs_base64_encode((unsigned char *)buf, inlen, out);
> +	if (ret < 0) {
> +		free(buf);
> +		free(out);
> +		return ERR_PTR(ret);
> +	}

	if (!out) {
		ret = -ENOMEM;
	} else {
		ret = erofs_base64_encode((unsigned char *)buf, inlen, out);
		if (ret < 0)
			free(out);
	}
	free(buf);
	return ret < 0 ? ERR_PTR(ret) : out;

Otherwise it looks good to me.

Thanks,
Gao Xiang

