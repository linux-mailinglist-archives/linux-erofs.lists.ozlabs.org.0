Return-Path: <linux-erofs+bounces-1689-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D975CFC1D9
	for <lists+linux-erofs@lfdr.de>; Wed, 07 Jan 2026 06:52:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dmHH26QyFz2xrC;
	Wed, 07 Jan 2026 16:51:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767765118;
	cv=none; b=eafoJE9HHCI6Mncv39hwsoRC+5CjHtiKBVZnD+TTPyzdJE4spl/386Zomak1HNQF9hvXk271dM1NikjUJpX27B72SzvnELwNm3zQaKi7d7N7rNbkYBW1ySvfU5eoziHR8EiajQEidJT5XSzQznMJ3nIUbUUYNeEXk4wkGPIHHH8SQoeHGt5NaDLHqYl+KmHbU7mzkfG58YpsASpvC9UzP3F46Lfzwcv96yn1w1PK4IG9BtZ1IW6gaNstZQzaT0KlzSqfHXZJz9bAc5VE9EV3jBoPTkWD5bittun4jZjsrt5E7kM01XaIJxyETpnyxhsl5HUcW3R4db3oSo86YxyxsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767765118; c=relaxed/relaxed;
	bh=riAjk1mLYj44mzUokmcOFJgCmy8gwS2bayryYTykvbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pldc0DqsYh9vYrXKUHulSMJ2z8rAdQ+A7drhZkeofpCBIVLzm4MbCvcwjNdr9Q5CJKGsxRaCeq3gxA0RZE0xuzoLhUCkcoXXfx/njlkjrO1cpFRQ5eI5PgOEogLVbmrvm13tNccLUkBm4nK3rQGRu7nOGfxS3BKHZZUbSjovBaqHnnOG3256OrfeQA4e71qzhAXJapp+3Ze4PuJtH3VQiq6BmcX+Ame1KCGVOne14BgnGuYTnCJ3EJXZ24Dv90XsAmVPuCwLkB1tl06MjbGq0ke7JqMGQVaMhlCxFK9Tgdt+oIRUY2wt+hmO662SThYc1p6LbVovdUflqtSmJtH/RA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lUEWpw/r; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lUEWpw/r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dmHH02l2Gz2xHP
	for <linux-erofs@lists.ozlabs.org>; Wed, 07 Jan 2026 16:51:54 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767765109; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=riAjk1mLYj44mzUokmcOFJgCmy8gwS2bayryYTykvbs=;
	b=lUEWpw/rOIXvKzIlgvGofsy/i4cnBEwOB/OrElp4S46KkBtJKwarGAgkLaNH2GTe/hDrnQ9C9wnKBbs2fS1PrWQRORKqDDZ94+o1328+xSclj1/YzYjCjBKvfPKGlpCn9sfn5xigv7XWmM0m9Cn5i5EjkSCa26ut8kJPZoZmhx0=
Received: from 30.221.132.240(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WwXh5Jz_1767765107 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 07 Jan 2026 13:51:47 +0800
Message-ID: <cc4a2a0f-0bb1-4e18-92ac-0fea09ffc2f3@linux.alibaba.com>
Date: Wed, 7 Jan 2026 13:51:45 +0800
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
Subject: Re: [PATCH v12 05/10] erofs: support user-defined fingerprint name
To: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, brauner@kernel.org
Cc: djwong@kernel.org, amir73il@gmail.com, hch@lst.de,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20251231090118.541061-1-lihongbo22@huawei.com>
 <20251231090118.541061-6-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251231090118.541061-6-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/31 17:01, Hongbo Li wrote:
> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
> 
> When creating the EROFS image, users can specify the fingerprint name.
> This is to prepare for the upcoming inode page cache share.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

