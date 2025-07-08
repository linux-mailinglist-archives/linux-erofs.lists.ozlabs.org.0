Return-Path: <linux-erofs+bounces-557-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 63819AFCEF9
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Jul 2025 17:21:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bc4ZK0zR4z3bjG;
	Wed,  9 Jul 2025 01:21:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751988073;
	cv=none; b=lLa1VMqwJvZ4xQ6qtWPODtMSmrW1LMJw5YRg+MUeNtPzjrvyUlzYo+fTMEKjH9Hy0eU0eXkkQAUbSgz51nHKhpVulDfdijcauQvf1O429eWma3IWQxRJZXU70aFp3u7Vc/2s1QtM7U0O8ia1aeY0JJVdxcdX4FxPmTzqT1hp3aQgUwB7QtdS+isA8a4XEiLOlKvqTyejbuPMCQWtCPmo755EhPyFU3PUrILVV47Sti6uim1AzU0V0YntwfQJr3bbSLIzx9nwk40KUQKExVENJIl7Nu8uyGPlOcAPwlsIGp1Bjtd2se7fRmoy8qZ/bWtFEdd6vj6+nV4kVI7Z1CBpuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751988073; c=relaxed/relaxed;
	bh=+WoqLLLoCcM1gSeayj0eMKjgqDNXR/FG0MlfB9nFK6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PN6REMql/yTtE+tmXTRmTC4Je0P5tOgiSmAYJq0/M8bFNdpjelyjBQn5d3X7NQaneEOqgBiPOCif62NIgmS/UAjVl9emaKuZau3CffY6/N+tVOhbAl7Y2IDLNOFuob65JjalTEJWZqkIrHJV2nSsFumiYh49a5hLGhIktSmFfSxxfVrHNLKvi1RKGwefEsTwYq64CdWuKmT0wfaW5BlXnKcCoi1afV0IjUAik35NI0gR/41O7gPUWKIFKNfCzQ1G8EiR9CWmJcyZPa7zadTMgGXrYEBKiTA59tPw0otN1WHpY+p8TaDbnvQq52z+BHfN5qWMHowS/gp3zWZ4Mw1wAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=scf9axj2; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=scf9axj2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bc4ZH416Bz3bVW
	for <linux-erofs@lists.ozlabs.org>; Wed,  9 Jul 2025 01:21:10 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751988066; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+WoqLLLoCcM1gSeayj0eMKjgqDNXR/FG0MlfB9nFK6M=;
	b=scf9axj2k9lavrtr13SVQM6k5s6f37+O1YGD+wEANm1hqWCW+SWORSLDSoeNmbwx5BnV5zZ7XxX9oensAG32UcbnB5GM5ZqO4xTL8FG9Jctig/lIjytXI3afC6z10jf73FYQ3R3aNnxltOhGMQVMaDp9Iv39pvvz8dpJjJ5F8HI=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WiQCvYs_1751988064 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 08 Jul 2025 23:21:04 +0800
Message-ID: <9865fdbe-12bf-44ff-badd-f0bd0fc6aca6@linux.alibaba.com>
Date: Tue, 8 Jul 2025 23:21:03 +0800
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
Subject: Re: [PATCH] erofs: fix to add missing tracepoint in
 erofs_read_folio()
To: Chao Yu <chao@kernel.org>, xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>
References: <20250708111942.3120926-1-chao@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250708111942.3120926-1-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/7/8 19:19, Chao Yu wrote:
> Commit 771c994ea51f ("erofs: convert all uncompressed cases to iomap")
> converts to use iomap interface, it removed trace_erofs_readpage()
> tracepoint in the meantime, let's add it back.
> 
> Fixes: 771c994ea51f ("erofs: convert all uncompressed cases to iomap")
> Signed-off-by: Chao Yu <chao@kernel.org>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

