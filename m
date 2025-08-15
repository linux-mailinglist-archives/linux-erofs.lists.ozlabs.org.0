Return-Path: <linux-erofs+bounces-817-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 101B6B27C14
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Aug 2025 11:04:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c3GQR5T14z3cbX;
	Fri, 15 Aug 2025 19:04:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755248687;
	cv=none; b=j87vcZ/YianjP+Psqmqg03LmW0cBpH/XXR3T55LP2Nda0nqAw8fyHe3eu1qDpibHhivFgtu0Xc+X7zeKDEYQJMJxru2RO/9JNefhrKXKIDyFTwsvtq1YCyuXfBx9n8mabWoxGpNNGPmpCwSl9iHxE5XgMnKJdT9Arb1dBa4xFNzRQY5QzEaAg8ni29R6FLBawcHtGLY40fxo23Roo5zL50o11ktu57Z1/HprIbaTAgCzZC0vDBa/hYqP2suZf0mLDU2hk7ROAehpks+jLmh0ZYuEfuGqG0Y2eadUyhZKzGLEDb8+fdresQj7LIvfJs+y9IiblyoLwjhRnl15YWDHYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755248687; c=relaxed/relaxed;
	bh=hIHiy+yF+yyWBe4KsSBHqI7dPVSsarhV91g3c9GikRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k8qXVdvR11zc5VtG2qe3U1szty5n7gKVHiZIzIcCwNAOGC/2tnV96C28gM3bAzKCQh1sT86siXPJC3/yj+t5CqiC0bXuesBYEWmoC/k1BU3lmT59YxgZsTec5T6uhWU52oOfqhpNd6vBJlrpWUchNLbFngwq/RLZRS2SFKKTHEBAujDQlcf+SHkaCw3qi8egjPqvZzWw99l1EcZT0r5K9XA7dz7tmh3VhUyYG6EMge1VAO2u5H7mGlNvg4fbMD64yVEpWcZVU/pWZIcWXQpT7KXuEQKYoGcv7l+aMTEVV9XJZsf8W7z2RkhyPivm4M3wamvsrtiDNucIgilph8vCQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Ru4M+Ooa; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Ru4M+Ooa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c3GQP4H3Hz3cZs
	for <linux-erofs@lists.ozlabs.org>; Fri, 15 Aug 2025 19:04:45 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755248680; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=hIHiy+yF+yyWBe4KsSBHqI7dPVSsarhV91g3c9GikRA=;
	b=Ru4M+OoaSUcwy15/2ZwvAVTf9m/Xcn9nZf4rE+ZqvHAsfKK4jTw/UdUjnYAePhTtMJDnOvrXGL7u4w5Oin5ff95iuY30J9QiyQDX5ypIMjd8aBXCT2uafP7Cm3OH72I2x30Gw/YvnqZswInHwDRuLaeen5xhSM0VGMzyj93YmUg=
Received: from 30.221.130.189(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wlobxuj_1755248678 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 15 Aug 2025 17:04:38 +0800
Message-ID: <f2c93019-5f92-4ee2-88bc-feda330d8a55@linux.alibaba.com>
Date: Fri, 15 Aug 2025 17:04:37 +0800
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
Subject: Re: [PATCH] erofs-utils: avoid redundant memcpy and sha256() for
 dedupe
To: wangzijie <wangzijie1@honor.com>, xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 bintian.wang@honor.com, feng.han@honor.com, Yifan Zhao <stopire@gmail.com>,
 Yifan Zhao <zhaoyifan28@huawei.com>
References: <20250815084428.4157034-1-wangzijie1@honor.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250815084428.4157034-1-wangzijie1@honor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Zijie,

On 2025/8/15 16:44, wangzijie wrote:
> We have already use xxh64() for filtering first for dedupe, when we
> need to skip the same xxh64 hash, no need to do memcpy and sha256(),
> relocate the code to avoid it.
> 
> Signed-off-by: wangzijie <wangzijie1@honor.com>

Thanks for the patch, it makes sense to me since we only keep one
record according to xxh64 (instead of sha256) for now:

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Although I think multi-threaded deduplication is more useful, see:
https://github.com/erofs/erofs-utils/issues/25
but I'm not sure if you're interested in it... ;-)

Thanks,
Gao Xiang

