Return-Path: <linux-erofs+bounces-1967-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DD8D338DB
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Jan 2026 17:43:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dt5Jz0tS2z2xm3;
	Sat, 17 Jan 2026 03:43:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768581827;
	cv=none; b=kcX3zu0Ttsp9nNsvV0hmVXzkRqMUmBu1i4Tss/H4W/ztV2f2wiZFAPIpm+fffhx3KaNeF43MZ8bcaA9/QIDcSpJBv/45JpJwQfhoozCCLMyNG05ALLuZajkqQYgPnxFEdYdPkEE+0FFSTjT/aOCYSxK/KfwvxGx5YhdcouBr4EM55TRVby1nQMLRh6BYNC+dQ0F2ls9K6KPaXtNBu2BzAIVG/2C48T74HCgw88UV60jSL92fWVyuySUQTiIVq/SxChkW+56BEoW56KrgiwjsehosWpS5CwKeOFwbM1JV9SVQODswDJEZhZ489MsCerbbZjf3ikOSr5YY0Z0BJqM0mg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768581827; c=relaxed/relaxed;
	bh=CqdOrZ2fLYyllUFgm+eEnv6iIUPlCxvHxAAq4fRi+uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VkCjrmoeAO5YSXhTmcdKdMlWEZII5o9LZqKhpwbV+p4S7ssFs3myzsct9k5pAuP4xJvzDp4lVQq2sQLLVcO3gcysbNu5QpMRklkPp7fcSAITq4vYYPloKgwLnup6kRmRC5WPqJUuFEJO2gXZzVY70thpu3OWlLT1iJGUxDsPiLkmu6oXn/YxGfdDFgzPGekAcPvzDr9mEcN8Pg6drfSFoBuQpfUgrVZsU2YGPgnWB0o6NNAfCMgqAJ9EnVjJacKhRkRk4/udZMk3lD0OaYJ4Ut+XrybTX8+Az8x9YYnMh4gcZNh/cgO0gMw0JQ+LUk5O9U1M4OrtobIAGyDo0QpqQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MFI8GmJI; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MFI8GmJI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dt5Jw6VX0z2xS2
	for <linux-erofs@lists.ozlabs.org>; Sat, 17 Jan 2026 03:43:42 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768581817; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CqdOrZ2fLYyllUFgm+eEnv6iIUPlCxvHxAAq4fRi+uk=;
	b=MFI8GmJIcybJ2q2Ti09U6oUWDEe3o8HVqbZkOjxDCPnDQzGtaaMKvAeqvgpzr0plKM4QmYKSLFIwkI3VnFcGiIQBl4kb3VAuQfvksv+aATOjRXlxQvsoQenZ54b1AujFTTcbhZznG5oE6hxIoWC1z36XmTsMlUT7qxLmb34kzUU=
Received: from 30.180.182.138(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WxAj92w_1768581815 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 17 Jan 2026 00:43:36 +0800
Message-ID: <e8a5f615-b527-4530-bc3d-0adc4b0b05d6@linux.alibaba.com>
Date: Sat, 17 Jan 2026 00:43:35 +0800
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
Subject: Re: [PATCH v15 0/9] erofs: Introduce page cache sharing feature
To: Christoph Hellwig <hch@lst.de>, Hongbo Li <lihongbo22@huawei.com>
Cc: chao@kernel.org, brauner@kernel.org, djwong@kernel.org,
 amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260116095550.627082-1-lihongbo22@huawei.com>
 <20260116153656.GA21174@lst.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260116153656.GA21174@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2026/1/16 23:36, Christoph Hellwig wrote:

> 
> Also do you have a git tree for the whole feature?

I prepared a test tree for Hongbo but it's v14:
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git/log/?h=erofs/pagecache-share

I think v15 is almost close to the final status,
I hope Hongbo addresses your comment and I will
review the remaining parts too and apply to
linux-next at the beginning of next week.

Thanks,
Gao Xiang

