Return-Path: <linux-erofs+bounces-1122-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D334CBA677E
	for <lists+linux-erofs@lfdr.de>; Sun, 28 Sep 2025 06:07:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cZ9ks3qxQz3cYJ;
	Sun, 28 Sep 2025 14:07:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759032437;
	cv=none; b=k89M9+zvzLVPAtPS2AtSghZpzwf9bsd9S5TblJemNkpGM5Cxxr4IpaSWgb3vcRDfCRTSuQRW25JM02+IIqAvG2h1LyzXvo2lbFtimdZ2kxYzg37IjLhtr2TBAcwXFuq6rXCql4GLkwdXDgKHRD0PqsJ1abgVMIHkO0hJvxj4uBcNgpXe8X14K7Hnfj7c04RNtvA5ohRbQJRSArectxtoPh5h0vE0ffjWCRB5K80BoqMTrHhLOFfopfQBkoBXjJ6S6ryWECVGtRT7UpAYG0gxnGytGdNmVlWdSBGSieHZK4jixebMZlh7Zm88ad/yBXsGViyurV4vgGINYc1BPOM+iA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759032437; c=relaxed/relaxed;
	bh=IRakoQ1TWLje0FbUd5h2tlvzJ25vBJOBr4DdctbCOoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UHScfDaSzNIkEmD9Sm18m3bSemAAlWopiw8Syg7KGN34ukHLXrBdguQOEGBOFBs9d6KLqhySi8ywwAayGgVDxyojjWoi28g9m+ZxwdzQByTh3lIiHzGqd4+X5qDwfn/6IwVlNdXAOPcfWDAHKqaF21GWBFQBiqmGTEqJIf/21ircJw5wkIGumRWuGFu/yuak8K3TACtpSluiNDgaZWSykSSTjH25WTaJamXAlY/qGAp9/DgOaIjlshYr4fsNgzV4GAj+UL/ATGT6WsVPdbnYjrYhFRMR4D5jD20X0GQ6hI+0ZypnnSc4HcNgwtmBL/lcJk+IPbwCqeAZFXrS29vTuA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=d+xHSc2G; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=d+xHSc2G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cZ9kq2r5Hz3cQx
	for <linux-erofs@lists.ozlabs.org>; Sun, 28 Sep 2025 14:07:13 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1759032430; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=IRakoQ1TWLje0FbUd5h2tlvzJ25vBJOBr4DdctbCOoQ=;
	b=d+xHSc2G7S1CsUdYAb555C0hiecWHpfHSEIpINQ6tby0YHRsH/oq7WEzFdarlj2NVEZrh9Lf0HAz5k1kjr+QtALHmhhFHXCieIZkuUfILglC/lQvZncTGIiCaVPqozx+gp2uH/dh5n7a1iOYdu6l/ex3Syj3RwaF7+oG36A7ZF4=
Received: from 30.221.128.245(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Woxya8n_1759032428 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 28 Sep 2025 12:07:09 +0800
Message-ID: <d6ff9f68-b8ed-4083-8952-faae1c1ce2a5@linux.alibaba.com>
Date: Sun, 28 Sep 2025 12:07:08 +0800
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
Subject: Re: [PATCH v1] erofs-utils: add hybrid source support for local
 metadata and gzran
To: ChengyuZhu6 <hudson@cyzhu.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, Chengyu Zhu <hudsonzhu@tencent.com>
References: <20250928033227.18870-1-hudson@cyzhu.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250928033227.18870-1-hudson@cyzhu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/9/28 11:32, ChengyuZhu6 wrote:
> From: Chengyu Zhu <hudsonzhu@tencent.com>
> 
> Add support for combining local metadata files with remote OCI blobs
> through a new hybrid source mechanism. This enables local metadata
> storage while keeping blob data in remote registries.
> 


..

>   	oci_iostream = calloc(1, sizeof(*oci_iostream));
>   	if (!oci_iostream) {
>   		ocierofs_ctx_cleanup(ctx);
> diff --git a/mount/main.c b/mount/main.c
> index eb0dd01..fd5736d 100644
> --- a/mount/main.c
> +++ b/mount/main.c
> @@ -16,6 +16,7 @@
>   #include "erofs/io.h"
>   #include "../lib/liberofs_nbd.h"
>   #include "../lib/liberofs_oci.h"
> +#include "../lib/liberofs_gzran.h"
>   #ifdef HAVE_LINUX_LOOP_H
>   #include <linux/loop.h>
>   #else
> @@ -141,7 +142,25 @@ static int erofsmount_parse_oci_option(const char *option)
>   						if (!oci_cfg->password)
>   							return -ENOMEM;
>   					} else {
> -						return -EINVAL;
> +						p = strstr(option, "oci.local_meta=");

oci.tarindex ?

> +						if (p != NULL) {
> +							p += strlen("oci.local_meta=");
> +							free(oci_cfg->local_meta_path);
> +							oci_cfg->local_meta_path = strdup(p);
> +							if (!oci_cfg->local_meta_path)
> +								return -ENOMEM;
> +						} else {
> +							p = strstr(option, "oci.zinfo=");
> +							if (p != NULL) {
> +								p += strlen("oci.zinfo=");
> +								free(oci_cfg->zinfo_path);
> +								oci_cfg->zinfo_path = strdup(p);
> +								if (!oci_cfg->zinfo_path)
> +									return -ENOMEM;
> +							} else {
> +								return -EINVAL;
> +							}
> +						}
>   					}
>   				}
>   			}
> @@ -332,11 +351,265 @@ static int erofsmount_fuse(const char *source, const char *mountpoint,
>   	return 0;
>   }
>   
> +struct erofs_hybrid_source {

struct erofsmount_tarindex_source {

> +	struct erofs_vfile local_vf;

	struct erofs_vfile *tarindex_vf;

> +	struct erofs_vfile *gzran_vf;

	struct erofs_vfile *zinfo_vf;

> +	u64 local_size;
> +};
> +
>   struct erofsmount_nbd_ctx {
>   	struct erofs_vfile vd;		/* virtual device */
>   	struct erofs_vfile sk;		/* socket file */
>   };
>   
> +static ssize_t erofs_hybrid_pread(struct erofs_vfile *vf, void *buf,
> +				  size_t count, u64 offset)

s/hybrid/tarindex/

> +{
> +	struct erofs_hybrid_source *hs;
> +	ssize_t local_read, remote_read;
> +
> +	hs = *(struct erofs_hybrid_source **)vf->payload;
> +	if (!hs)
> +		return -EINVAL;
> +
> +	/* Handle device boundary probe requests */
> +	if (offset >= (INT64_MAX >> 9))

Let's define a macro for this.

> +		return 0;
> +
> +	if (hs->local_size == 0)
> +		return hs->gzran_vf->ops->pread(hs->gzran_vf, buf, count, offset);
> +
> +	if (offset >= hs->local_size) {
> +		u64 remote_offset = offset - hs->local_size;

no need to defina a variable, if it's needed, add a comment for this.

> +
> +		return hs->gzran_vf->ops->pread(hs->gzran_vf, buf, count, remote_offset);
> +	}
> +
> +	if (offset + count <= hs->local_size)
> +		return erofs_io_pread(&hs->local_vf, buf, count, offset);
> +
> +	u64 local_part = hs->local_size - offset;
> +	u64 remote_part = count - local_part;

they shouldn't be defined here.

Thanks,
Gao Xiang

> +
> +	local_read = erofs_io_pread(&hs->local_vf, buf, local_part, offset);
> +	if (local_read < 0)
> +		return local_read;
> +
> +	remote_read = hs->gzran_vf->ops->pread(hs->gzran_vf,
> +					      (char *)buf + local_read,
> +					      remote_part, 0);
> +	if (remote_read < 0)
> +		return remote_read;
> +	return local_read + remote_read;
> +}
> +
> +static void erofs_hybrid_close(struct erofs_vfile *vf)
> +{
> +	struct erofs_hybrid_source *hs;
> +
> +	if (!vf)
> +		return;
> +
> +	hs = *(struct erofs_hybrid_source **)vf->payload;
> +	if (!hs)
> +		return;
> +
> +	if (hs->local_size > 0)
> +		erofs_io_close(&hs->local_vf);
> +
> +	if (hs->gzran_vf)
> +		erofs_io_close(hs->gzran_vf);
> +
> +	free(hs);
> +}
> +
> +static int load_file_to_buf(const char *path, void **out, unsigned int *out_len)
> +{
> +	FILE *fp = NULL;
> +	void *buf = NULL;
> +	int ret = 0;
> +	long sz;
> +	size_t num;
> +
> +	fp = fopen(path, "rb");
> +	if (!fp)
> +		return -errno;
> +
> +	if (fseek(fp, 0, SEEK_END) != 0) {
> +		ret = -errno;
> +		goto out;
> +	}


