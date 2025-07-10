Return-Path: <linux-erofs+bounces-574-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61728AFF85D
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Jul 2025 07:18:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bd35r5d1Qz30MY;
	Thu, 10 Jul 2025 15:18:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752124704;
	cv=none; b=Osq4onx+Ef6oXb191k//expTFJP8HNAGZNGXToGbmTZ15vlOBh1sLlge/oI8iUVO4RgEXF8UWsLVV9qQ2iZQ8ITIJqGvwcGLDPU7G6c6XdkPSq9fPT0QipBkH18LS7QaWn85TASnN4YYMJGd5EF4NKkfoSG6pxJ8PrcFLwkZ5c5vtPlaIRCnbXXCfnM76PyuBF7bGfN2W1ZH/I9ITb/7WgP6qPUMXy8eS7e9Dp5EGVFh4cTzMgdjJnNFbrLU6zIxQV3QgftCGL3QqofcQXvwyOlSTeqn62abI1LQy8GbA6aQpR3ah5BHPKYGy3NV1vvOKS/cRFXkVBevrKKGvXwZ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752124704; c=relaxed/relaxed;
	bh=IgvuMSIU4no/7pCv1hjrhM3le8Z2kO0KwGxYEchnocg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hKnbMzrlO6BXLyZV63NluUVqT/wtjrvQszGyhx0jm8OWkDwjYtteA2UEdJLOdv8yA2rTi915LQY0K9XkpvXoQGbWc4UDQdgkjIiJzOX11CGIzzGlIfD8LcjYLh11em/csWKBBq5OgfDO8ruT+LwEpViblg+4ss4j70PjHefmpctmME2we/U5J8Prs0yuKCpo4gQY8iVgo5K9GG9FviShETXQbqn9/8jPWqGmv1EkW7D3y5rJNuYLqg/baekNVTwugTRYYGQUE2P5EEtGNfFcAFWfYeB1zDo/RxqYydfjmcIQWnQsnd/f/fPJcFgJI6Plaf9wnfuHIKoHAFh0pAQQpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ZAWtsOKO; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ZAWtsOKO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bd35n6SShz2yYJ
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Jul 2025 15:18:20 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752124695; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=IgvuMSIU4no/7pCv1hjrhM3le8Z2kO0KwGxYEchnocg=;
	b=ZAWtsOKOKmtN9SFE8CMt1EW7/+pqwvkkXsrnJWPSv8mzhHj3fTG+9oqnLXZr3t+Y+YnpFyXfddO90Z2UUwMvat0jsY6T2l0yNJrHHW8YDisc1lIIhViR05NJHfFkjVrs95VdCKIrMwd0nT5CYITO53FIjCmGk2zdSsyxvtG6U9c=
Received: from 30.221.128.137(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WibNLdE_1752124692 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 10 Jul 2025 13:18:13 +0800
Message-ID: <c3ebea91-9a78-4ac8-8312-3d98008f7950@linux.alibaba.com>
Date: Thu, 10 Jul 2025 13:18:12 +0800
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
Subject: Re: [PATCH] erofs: support metadata compression
To: Bo Liu <liubo03@inspur.com>, xiang@kernel.org, chao@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250708120143.3572-1-liubo03@inspur.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250708120143.3572-1-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Bo,

On 2025/7/8 20:01, Bo Liu wrote:
> Filesystem metadata has a high degree of redundancy, so
> should compress well in the general case.
> To implement this feature, we make a special on-disk inode
> which keeps all metadata as its data, and then compress the
> special on-disk inode with the given algorithm.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>

I'm working on erofs-utils support for this feature, but
before that I tend to support optional metadata compression,
which means

if the bit 63 of nid is set, the inode itself metadata compressed.
if not, just uses the current way.

Because that we could enable image incremental builds so that
we don't have to rewrite the base inodes again.

Thanks,
Gao Xiang

