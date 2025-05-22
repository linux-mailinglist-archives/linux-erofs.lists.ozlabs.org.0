Return-Path: <linux-erofs+bounces-355-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC12AC0731
	for <lists+linux-erofs@lfdr.de>; Thu, 22 May 2025 10:34:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b31mr08Ybz3c4D;
	Thu, 22 May 2025 18:34:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747902875;
	cv=none; b=mRKMSU2TmwemPMlvXtRDiKjUOIp9sri3kvb5HUgT44+jbt++CpzT1w417xos65Z5jus9RrUTma/IMBd9KEox12fmyIOKI5CZM2O8uR41K6Mu7Hu9+e47TUA5wvJTh0CyCjZep3UjBWA+fmz8FdHrNmbBjh1TaceSNA+A70hFWuHuhnJRVZ0QkspVQ9zMFYrh2+UXnBu2P77YpzWn+8WROFawDlzd6FXHqhYycGkN9xR47ehwtGLcvmQ+nmidxK1WIzbnKBvw/DF2U3OFyZ28vLKE1qxlFkLHfD3tnM3CCx7XkjaYeaj31sI3ygai9pBJgLvBgucAIG6h4Gv/WYPyfg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747902875; c=relaxed/relaxed;
	bh=KUGgemjCNoc+n3/4dsLp3BrhWvshg2iuaiRUeDCi01w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MPTdGh7jCYVD0s6r03okNdsdP3MGd+Kh+1UUvDZWZEZQxAa2Qdy9xptUycGGkjGo//OBJwxBvb7NtbVz2JQlWsaparRAqNgcMrsWfQv3+/KmWcLEqXeGm458KWzyKTucPt/jcH65J7qC/NaCAcVMcfIgLrO617H99LSSfMY5C8iz3zBEYaGct+TcKsbto2w+upMlVwneAA6+SXKhmUkHeig80IVd/b24szmk9sFM3UuivXjjm6sVwnrP+LuQKOzFLTwTQHcch/qof8Gn+UMmZ1RkyBMJ/oERLVCU4S/A257Y2VOiDVd/rfl6mD+SoZ9hbL//hxt+YB3XnHeUCGEXBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vWmSOGhZ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vWmSOGhZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b31mp0g4bz3c3D
	for <linux-erofs@lists.ozlabs.org>; Thu, 22 May 2025 18:34:32 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747902869; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=KUGgemjCNoc+n3/4dsLp3BrhWvshg2iuaiRUeDCi01w=;
	b=vWmSOGhZBUrONQTKu6Z0Nqnx9Mi8OMxv0oqv/BiZzR5fxFraxXI+tUAYUREra25Hmed5y5NoKP7lowFF9kaVzHcJUd2Dtp9AyMlS64OuQBJ5XlfCbSTj9s3SpiWRyIXnqe2RfCDgZ1fQM6vI0W4RMUmrl7hXbmm/Ark/fLNH/dY=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WbV5-qC_1747902867 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 22 May 2025 16:34:28 +0800
Message-ID: <c4829613-1fea-488d-9d58-373e0d3b6bc1@linux.alibaba.com>
Date: Thu, 22 May 2025 16:34:27 +0800
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
Subject: Re: [PATCH v6] erofs: support deflate decompress by using Intel QAT
To: Bo Liu <liubo03@inspur.com>, xiang@kernel.org, chao@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250522081433.16812-1-liubo03@inspur.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250522081433.16812-1-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/5/22 16:14, Bo Liu wrote:

...

> +
> +static int __z_erofs_crypto_decompress(struct z_erofs_decompress_req *rq,
> +				struct crypto_acomp *tfm)
> +{
> +	struct sg_table st_src, st_dst;
> +	struct acomp_req *req;
> +	struct crypto_wait wait;
> +	u8 *headpage;
> +	int ret;
> +
> +	headpage = kmap_local_page(*rq->in);
> +	ret = z_erofs_fixup_insize(rq, headpage + rq->pageofs_in,
> +				min_t(unsigned int, rq->inputsize,
> +							rq->sb->s_blocksize - rq->pageofs_in));

Please fix the alignment of this line.

Thanks,
Gao Xiang

