Return-Path: <linux-erofs+bounces-184-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D78EA83872
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Apr 2025 07:34:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZY7mW4HhXz30W1;
	Thu, 10 Apr 2025 15:34:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744263275;
	cv=none; b=hSSLN326zADM8ADOEdoyT7IqL4+VktaHTegMaJs/ZNDw0ewMyM/oTPAGiLg9T4GWm/Fyq9TN9JeLTRtKB1hN3A33yeqGhynLVeA6ii42KZfksYu4T435LABNdVl+yy8I6A28M4PBkZ07mnxp7IqJWMyoZsF7MyWh++hV3MKKEG3KrqXPaznzAPtmRaXjjFZrCM2nJoEXnuA+9wfgCCKSx6EW/2ZZ8l1z2GJjKq1h/NNgvZhjpvT1b4erAFRz9K7nm3qgIxzwvQIrK22leVm+p8ngMe2KmJ7p63qE2PmEcmwZ8AKkOZCp+6WUHYE/tlI+6Ly0AvABYmscGhlA3Gh1UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744263275; c=relaxed/relaxed;
	bh=Bs2n4ggmpJKAVXgPqf/grfYUsXVtkpC5QXujA5eZfrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iPJE8uGNig2dGVgnorcGvG80320Qh/EwfArpz/8NE0XqOctiba6Y4uHJiPlhCFDC/5nAd7JPCmoytPU9mZYPxDA8UVgt0zBbJm8M+eWtFMjZmo5aLNhj6fPCWJ8C2xFJwWnXUJ25+ZM1df42A8s88UQyMl/ZyKY/TgO/EDG4a2+e88mijh1I8OwrDGn5Hj6Ybb862Hdd1DXnzcLMnN3H/VZlXXh8nyDH+ed27cRhAERa46q3MD7jtPujTlAe4KPj8HHBnK1iCTIvTzR94waZweVlJJsSke0XCgPVwt3R5jjAELGfUaw+GdEOdNi6hXQHyqBzIwiwZJxIj9yESp2yMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rO97Pg4z; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rO97Pg4z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZY7mT1dscz2yf0
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Apr 2025 15:34:31 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1744263266; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Bs2n4ggmpJKAVXgPqf/grfYUsXVtkpC5QXujA5eZfrs=;
	b=rO97Pg4zTD+/cKsTYh5emKR9wu7NCdQXkw6DYB23Xt61LwD9dfMVhcz0bviUEE6xSOxLunHRzf00vJfb+M1n3gkbV/Lyli24GSSP4tDqmG7nU5L8sJgc2pffoL2F2ihfk9zAZHAdEnMxlibkCttgdOD3amtan4UPXULEflMqNOM=
Received: from 30.74.129.130(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WWNI0Qe_1744263264 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 10 Apr 2025 13:34:24 +0800
Message-ID: <a3ce2b97-2898-4856-a1bc-07d9ac40a55d@linux.alibaba.com>
Date: Thu, 10 Apr 2025 13:34:23 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] erofs: remove duplicate code
To: Bo Liu <liubo03@inspur.com>, xiang@kernel.org, chao@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250410042048.3044-1-liubo03@inspur.com>
 <20250410042048.3044-2-liubo03@inspur.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250410042048.3044-2-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/4/10 12:20, Bo Liu wrote:
> Remove duplicate code in function z_erofs_register_pcluster()
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>

Thanks for catching this, will apply it first:
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

