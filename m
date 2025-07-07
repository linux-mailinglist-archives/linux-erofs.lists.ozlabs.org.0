Return-Path: <linux-erofs+bounces-537-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA82AFB0F5
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Jul 2025 12:18:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bbKtv1hf3z30W1;
	Mon,  7 Jul 2025 20:17:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751883479;
	cv=none; b=CS78rTw8Z5dKjTgtA04B8h0TWWe/2cxXbQO7WU2igQRwjhcvQAfidPRBUeHHgGHZGrCcjfuPOR3WenREgaTDlk2yzRdehx71Ob2eh5I538NmxQEh44n+bWqfjEibHv7EbzfTsKQvhn9pxEE74AETFu2veB5MqRgfzl87RU0TTtszxB/b4hnU6w6LVIm+J7CfWTSqRLMrUcSBF4abMt6x5Sotlg0QFOD7NQMWLyQDMPTT8EGRdRls96wvg1qJnuyeC8TG62QdBIsrb+B2IZ5vH+TmxmDXwr3BYRTuj4VXGb85EGZwjoX9bli8HevySps4GoTGqH2pRuT7HNhQiQzM/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751883479; c=relaxed/relaxed;
	bh=Bji7LAvBySu+UkXIYAKQCCtk6TOYzFoTM8HXHtwzswk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ErP/pn63BcsMyIwaWtuB+C/T7baoOHwCVioBN9tvkxEKH2qe0MjoDz+F//KqqPkLxEMHIXR0JyRel19LqTqAI0d9XBgE2An7cssHkrTvgFm9imU1GWqZb44YEcjxFqPgfaaHKxm8MmMSricRiI4kOj6m1OvYnYb56fmQgyCXWHHeg8KTwPaeT68FtkNyk2fDl4WqIVybD2eL0VZb3g3J1vVSleE0aMub0ZV7upDXDGcGZ7VrQyfNtLZJAVtlSUv8PrvSsWB4UtgM8FsLItkRtRmPFXu3KqPlte+9wO5V4+ewNfiLuky7syoBAhXNGY3G1fd1aMdibyQKt3dM5hR7rg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RltoH478; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RltoH478;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bbKts3QbTz30Vs
	for <linux-erofs@lists.ozlabs.org>; Mon,  7 Jul 2025 20:17:56 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751883471; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Bji7LAvBySu+UkXIYAKQCCtk6TOYzFoTM8HXHtwzswk=;
	b=RltoH478ZYcrz+TIKngT1c95SGqiFUQLpx7y0L36+cDhUWfGZlY5PH1hzRVR0cMHy9sfp8bR6EpsUnvbEKJ+8hUyadOQkMGisvtMsETAF9IzZ8zzykPcVgGzXgLCVjSVcywHah9fdKaeELcPT3JU8BKk00mf5jVkg8aEnVPf7aI=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wi5uWjj_1751883468 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 07 Jul 2025 18:17:49 +0800
Message-ID: <c911e159-d216-4b0f-865b-f4524e6f8f0f@linux.alibaba.com>
Date: Mon, 7 Jul 2025 18:17:48 +0800
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
Subject: Re: [PATCH] erofs: fix to add missing tracepoint in erofs_readahead()
To: Chao Yu <chao@kernel.org>, xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>
References: <20250707084832.2725677-1-chao@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250707084832.2725677-1-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/7/7 16:48, Chao Yu wrote:
> Commit 771c994ea51f ("erofs: convert all uncompressed cases to iomap")
> converts to use iomap interface, it removed trace_erofs_readahead()
> tracepoint in the meantime, let's add it back.
> 
> Fixes: 771c994ea51f ("erofs: convert all uncompressed cases to iomap")

Thanks Chao, btw, should we add tracepoint to erofs_read_folio() too?

Thanks,
Gao Xiang

> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>   fs/erofs/data.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 6a329c329f43..534ac359976e 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -356,6 +356,9 @@ static int erofs_read_folio(struct file *file, struct folio *folio)
>   
>   static void erofs_readahead(struct readahead_control *rac)
>   {
> +	trace_erofs_readahead(rac->mapping->host, readahead_index(rac),
> +					readahead_count(rac), true);
> +
>   	return iomap_readahead(rac, &erofs_iomap_ops);
>   }
>   


