Return-Path: <linux-erofs+bounces-1620-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C06CDF548
	for <lists+linux-erofs@lfdr.de>; Sat, 27 Dec 2025 09:48:53 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ddbkB56XKz2xlP;
	Sat, 27 Dec 2025 19:48:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.227
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766825330;
	cv=none; b=I0l7ybIh8sTjhBc8N4f3zaqLqDUDgBeL1S6alazac+uNaF2y+bm1zkfCaFoeAh5WfN1R0joNFLikaeW0g5F4HPvDikmpoQFHrqSHFWT+/5w8YZBtfvGmRi0on4TNhfSpJRbWtce1+82f7HyAR0fwkr3OW6iwaxWvrlzmjeIQ8O3Goj3YsyVFfa/Nhs8Xgry2v1k99vljQSGR3LFpRi0SI+fDFvcpnz0BJ1mEq3ZiZdIzSsNmtLzG6n8kT7s0IV1imQDAClYHuGVS7MetDkbpxCgrj1bnW1obh2U7j/vSTf5VitHOhoHMBP4cIO6jZPFBsZBxmgh7bIFZvjx+N8xRzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766825330; c=relaxed/relaxed;
	bh=fLbfEA2x5pJ7VvbxdlfCbXpcVd8bwK1cWG5XW+r3Jkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=S3O/jiDL9pL7snQu5p+uO9uh2wngdVQUJCuuKVz5KeqTr5YOvJpfVQhSp+871K59V5PjCLLTMdssXmfxEa6puKWN4x3C2z+WHWXLk5zrbg3R5bGjes5+4Hz4N4Od2Xq4o66gLvp8aw4ji4gUn/DQApRbkFpkOi1vW7ZLVzeW05GQMlNtAnQQiAf9DE979RW2MDmbyE9EEF7PWuJWK1X9/K9p6uDl7ZF+2+cHNgS0N9Trx9lRJF+DF780zC/00QeUd6NVHGbvRy3EQIpDIjZ8m6wh190saXjEBgoceueJDcuolkYjqJFhdz7zxeG5B9KiQ659uGlf8JQsx3wrK7zFDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=E2TC65Y9; dkim-atps=neutral; spf=pass (client-ip=113.46.200.227; helo=canpmsgout12.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=E2TC65Y9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.227; helo=canpmsgout12.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ddbk64bZSz2x99
	for <linux-erofs@lists.ozlabs.org>; Sat, 27 Dec 2025 19:48:45 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=fLbfEA2x5pJ7VvbxdlfCbXpcVd8bwK1cWG5XW+r3Jkc=;
	b=E2TC65Y91szIZdM9KtK4rrAC06xWPfuK7T0xp3UZgJ2dCHPGQHtUOHkmBJUNTMxIHSX3XGZ+s
	6v0oitH51/93hLJKoqyUIBmvsoYsExUEsNFjOf6uinMNMea3cgI2fwvKA39N0sSFItIlO7s8dy9
	Nv92ZdZdZJqLn+c17WBozUc=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4ddbfF0CnCznTW4;
	Sat, 27 Dec 2025 16:45:25 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id ACBC340562;
	Sat, 27 Dec 2025 16:48:35 +0800 (CST)
Received: from [100.103.109.96] (100.103.109.96) by
 kwepemr100010.china.huawei.com (7.202.195.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Sat, 27 Dec 2025 16:48:35 +0800
Message-ID: <0027bee0-b4b0-4cf2-888e-d410d08713e3@huawei.com>
Date: Sat, 27 Dec 2025 16:48:34 +0800
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
Subject: Re: [PATCH 2/2] erofs-utils: lib: oci: restrict `ocierofs_io_open()`
 to single-layer images
To: <linux-erofs@lists.ozlabs.org>
CC: <hsiangkao@linux.alibaba.com>, <hudson@cyzhu.com>, <jingrui@huawei.com>,
	<wayne.ma@huawei.com>
References: <20251216070557.743122-1-zhaoyifan28@huawei.com>
 <20251216070557.743122-2-zhaoyifan28@huawei.com>
From: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
In-Reply-To: <20251216070557.743122-2-zhaoyifan28@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [100.103.109.96]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Xiang,

Could you consider apply this patch first? As we disscussed before it 
prevents subprocess

from segfault while oci.layer or oci.blob is not specified in mount.erofs.


We would better not add an error print for now until we refactor the 
current codebase and

fork one child process for both netlink and ioctl, otherwise double 
error messages are shown.


Thanks,

Yifan Zhao


On 2025/12/16 15:05, Yifan Zhao wrote:
> When mounting an OCI image with `mount.erofs -t erofs.nbd` without
> specifying either `oci.layer=` or `oci.blob=`, a segfault occurs in the
> `ocierofs_download_blob_range() → ocierofs_find_layer_by_digest()` call
> path due to an empty `ctx->blob_digest`.
>
> As mounting multi-layer OCI images is not yet supported, let's exit
> early in `ocierofs_io_open()` with an error in this case.
>
> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
> ---
>   lib/remotes/oci.c | 19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
> index d5afd6a..ce7a1a5 100644
> --- a/lib/remotes/oci.c
> +++ b/lib/remotes/oci.c
> @@ -1479,16 +1479,18 @@ int ocierofs_io_open(struct erofs_vfile *vfile, const struct ocierofs_config *cf
>   		return -ENOMEM;
>   
>   	err = ocierofs_init(ctx, cfg);
> -	if (err) {
> -		free(ctx);
> -		return err;
> +	if (err)
> +		goto out;
> +
> +	if (!ctx->blob_digest) {
> +		err = -EINVAL;
> +		goto out;
>   	}
>   
>   	oci_iostream = calloc(1, sizeof(*oci_iostream));
>   	if (!oci_iostream) {
> -		ocierofs_ctx_cleanup(ctx);
> -		free(ctx);
> -		return -ENOMEM;
> +		err = -ENOMEM;
> +		goto out;
>   	}
>   
>   	oci_iostream->ctx = ctx;
> @@ -1496,6 +1498,11 @@ int ocierofs_io_open(struct erofs_vfile *vfile, const struct ocierofs_config *cf
>   	*vfile = (struct erofs_vfile){.ops = &ocierofs_io_vfops};
>   	*(struct ocierofs_iostream **)vfile->payload = oci_iostream;
>   	return 0;
> +
> +out:
> +	ocierofs_ctx_cleanup(ctx);
> +	free(ctx);
> +	return err;
>   }
>   
>   char *ocierofs_encode_userpass(const char *username, const char *password)

