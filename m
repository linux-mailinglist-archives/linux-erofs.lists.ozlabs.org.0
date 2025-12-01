Return-Path: <linux-erofs+bounces-1457-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CCEC9583F
	for <lists+linux-erofs@lfdr.de>; Mon, 01 Dec 2025 02:42:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dKRTs5M7mz2yvD;
	Mon, 01 Dec 2025 12:42:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764553329;
	cv=none; b=bu9ey52kgceMcqO4SzSz1Q8/88iNQilwHguxtlVYN419latIxhJwekQeK2y3FdOvgTsQQvyijJJBQ8k35Btf5IXa1iYtmAASlvne7GddenUqrndmHLkrVr91RGDGeV3LfBbzKI4j1H5tTE2dwwVjxCesVFm5Uq5jOwiGz9rmOFHc/8pD55uNgK89Ct/qEsfQbJBTpF7UHYVWKqycZqy390IWcnigSNb8PLHVQvZ8VhobaBVBwe4fJcvGwueEqx2P1PeZ/i7ZWucuK6aS17wZ1EbjydFXTY4Zrf9XmGAl1AbnpS+denW9b4t0n1xKD/SasIrhuni7EagSyZDU2TNKzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764553329; c=relaxed/relaxed;
	bh=LU2lrMs6pSpE5G9w7TdylqeWSFAwURb08IFSO67bRss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jM8WtgnjEBIw1LHBGbUWJc/SaYDS8RLOtR7Xxc6Zj2h8RozJK/HoOQuO2rwfM0DXXJLyZQ0h/D/xNj6F778lh15QUwbzACnt9nK/yllrbpvWeiQqpIMnfquC9/MJsKqnUYvhnUQR5i5DcNVasf9k2V/1SjFasQzVZY3z9b3nBnSdqXX5OVM2Gx/WnqPNOYwZXT+ca8i/Hl7uMsYeu2ttnKD8P9PNhQ70d3kjl1PcQvkdh0K1bScDrVBENTCaXmUeIkglPEAcci6Cew+zsRSAATxUaBkJfxaay0ELrH/NdeyL8A+ynBB/Nk6jjRgXLLmfN86uCnQkbrmLnUXgJLHBPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pYq0uPVx; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pYq0uPVx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dKRTq0BhDz2yv1
	for <linux-erofs@lists.ozlabs.org>; Mon, 01 Dec 2025 12:42:05 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764553320; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=LU2lrMs6pSpE5G9w7TdylqeWSFAwURb08IFSO67bRss=;
	b=pYq0uPVxm9/L7GBC/F7LdTEnRT3ovPHSaVHdCgJCQy6/ZNhS8Gkk5TtB+/vENX+cU2R97kc0f1wkNJGmoAPTZFxINoJX4txivJHwKw0f+mumXXZLsz9hDi3/EZePL+AHxaf3GWKPMhCrlFroOadSkv6jO1qeYu2sywRTjoVhnJM=
Received: from 30.221.131.75(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wtk47in_1764553319 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 01 Dec 2025 09:41:59 +0800
Message-ID: <6b79eaf1-f3a3-4c15-8bf0-ae70b2cf22bb@linux.alibaba.com>
Date: Mon, 1 Dec 2025 09:41:58 +0800
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
Subject: Re: [PATCH 1/2] erofs-utils: lib: oci: fix a corner-case in
 `ocierofs_parse_ref()`
To: Yifan Zhao <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org,
 ChengyuZhu6 <hudson@cyzhu.com>
Cc: hudsonzhu@tencent.com, wayne.ma@huawei.com, jingrui@huawei.com
References: <20251130104257.877660-1-zhaoyifan28@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251130104257.877660-1-zhaoyifan28@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Chengyu,

On 2025/11/30 18:42, Yifan Zhao wrote:
> Currently, `ocierofs_parse_ref()` fails to correctly parse OCI
> reference strings of the form "localhost:5000/myapp:latest", as it
> assumes a valid registry name must contain '.', which is not the case.
> 
> Let's also treat `ref_str` with a colon before slash (i.e., containing a
> port number) as valid registry names.
> 
> This patch also adds unit tests for `ocierofs_parse_ref()`.
> 
> This patch also removes repeated codes in `ocierofs_parse_ref()`.
> 
> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>

Could you take a look at this series too?

Thanks,
Gao Xiang

