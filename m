Return-Path: <linux-erofs+bounces-1497-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 826BFCC14A5
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Dec 2025 08:23:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dVpLl6Q3Xz2yDY;
	Tue, 16 Dec 2025 18:23:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765869807;
	cv=none; b=Q3Ah3DAxqEJNqAbgEgDkcSX/xf3BTPmjLXF526ZvECdsVmzuy89ywZbnskUbc2zTGNqFxc5I6hROrZrLy/dMSuoQ0xlqzWqOQQAO29QOBLna/hFXhU3CpIQdRrqxPqf4VQaByvOrp90DnZhzF8MZR/HdyAada/KL7bi+1GKx8lBB3CX/VOIfLuLIIyrbfWfhYovHmwuycTvKlfNuPRO0fACSCl6lmR6sK9XpGt9bbgWvI6XvWGgzHwRlWIjvCmQK9hycpydnzRxF1CHdeWVul24K0I1diMzfp9P4DNRKSWPsUggm2nJL1WQDlBJ1XuXTCMOAbygCrvMxkJtccy/fWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765869807; c=relaxed/relaxed;
	bh=5JvPo4E/WlCQKkaoLrvqGjQlneRm1gL4/y57us+FFFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V1SkxXWJuID6sor8tY0O/XIrsvoXAno5+JaHpsh4DMI0neSaSULDry3asguUi916xr2wopCqWEFraw+t6xH/agKRAqVdI9MEePcRXUb7R7LFPFARpuvRaptlGBaS+RkfBcUqh05HvEjwMx4cLlQ7QbZaTK0dribWNwx/CKKFs4+xSlSLXVwTLamNMC3DNq5mHJvZ5RFOWTx24GCQk5+VeLVEi9lgsAJuWgXiQ/9fwLasH7RTlp49DEhb+VMe4/8WBhJEIL4mn0+0mZWIyQZI6LKJLSPxM1sWQnxx3lvhQD8IsRDdNU5nmotrWk54kiJscJuUSJB13jFQGwjaJj7qAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NhET024L; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NhET024L;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dVpLk4Yd4z2xJ6
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Dec 2025 18:23:26 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765869801; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=5JvPo4E/WlCQKkaoLrvqGjQlneRm1gL4/y57us+FFFE=;
	b=NhET024LEt3257dVUHcApZoVB6ROBV15a4vN1CNeRjdf8PWBbeCiDfJtkwSaIIt54Q3Cb9PMzZD1puOO5sqPbL0/RpLRDo9yZVXnlRE9OAzlIo7+yKmHFqOLd6lFQNOXNC8CSwtnTN05nO4SDba59W6lsiGkrCaX2Ngqjvr00eg=
Received: from 30.221.132.163(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WuyIxai_1765869799 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 16 Dec 2025 15:23:19 +0800
Message-ID: <31adc60f-fc76-471f-aea9-18304b9f01b8@linux.alibaba.com>
Date: Tue, 16 Dec 2025 15:23:19 +0800
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
To: Yifan Zhao <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: hudson@cyzhu.com, jingrui@huawei.com, wayne.ma@huawei.com
References: <20251216070557.743122-1-zhaoyifan28@huawei.com>
 <20251216070557.743122-2-zhaoyifan28@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251216070557.743122-2-zhaoyifan28@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/16 16:05, Yifan Zhao wrote:
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

Is it possible to add a dedicated error message for this case?

Thanks,
Gao Xiang

