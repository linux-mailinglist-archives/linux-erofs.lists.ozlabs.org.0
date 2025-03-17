Return-Path: <linux-erofs+bounces-81-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 77284A641F3
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Mar 2025 07:43:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZGQRc1bByz2ydW;
	Mon, 17 Mar 2025 17:43:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742193836;
	cv=none; b=WIrHTbZfuuQWiDvgI2yTciBefqd5zjkXbIAusiqiG5qFGbLWB5Z0FARXVf1qixrJOzUzENV/QDgc0x8AycjnAwkbiN+HICNnVr58Ot8PMOWb+9NpaSUetcGCQ9zM3kMcoGvjmkUVD7802jVWyZ++FK8wwiEqII/JbwEi/gsnPo62QGGJ11k0pNqsBBRdGGRz1FhNCY9BmaLOcyxUCXwJ9uZ1HCoHHIFv+TjY9V6n57M+oXcuDp6bMVN3f2OlHFFpApzv/qVLwUFpdcJxcnHMokxXjAtMEBVRsN1iYmkg1XP5B7MMoTVV2VKOOzkld3Gd+te5BVd2oauZTGsFFQMUdg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742193836; c=relaxed/relaxed;
	bh=cToQKYVimXAGyTQXffRJDfzXmpyvPuy5zS8wqsPtAj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DILsPnd+DRsYXmPFCn9y25+kdfoK6KBIFI8j9r9ZXgTB4Ka2JO/9Sgl5m4eHrng7PKQVUi4D59EabfXwpbEw0tR+8OLrp+DIy6oppuxIKjiB4IUTJOZAnsqN/MseIs/U+h/j+K1VzddRsOsaK/Owpo9AkkTtSI/Is1stSQprnmMoR9U0nDueqUQy2kCjhGn0DDj1OiRJD+ARZfLmLJGAcwZkVTEISci8OdYSyNsp4OgZBFk/pBZeYTxpdT0ejEuWhWwK5StvKTr4IQAs1iSPznomiTwfj53arDUM5lkjwK46t4UShTgXZjJNOwz/D/S80Dphf8L/Ahay0rPqyNG/cw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=oDdZ8iWu; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=oDdZ8iWu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZGQRZ24kxz2yd7
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Mar 2025 17:43:53 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742193830; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=cToQKYVimXAGyTQXffRJDfzXmpyvPuy5zS8wqsPtAj0=;
	b=oDdZ8iWu0Lx9JQ7Y/6L++Q1qFHAuZ3I/sMd2dpAkVLUOG/ez3xqJ68tsrVYPIR4qiol/jDxPSSAFmMUMz/kW0kRrOjufnsd+X+ViMsVwqe9HtV/igSUhpG2Mgf20G18/tpmuOHUZ8ckjCLK/NoXO5iNA6gJyfAi3d5NopKvMHLQ=
Received: from 30.74.130.1(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WRa37lF_1742193828 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Mar 2025 14:43:48 +0800
Message-ID: <7b4a204e-5cb5-411a-bcb6-99e281fdc470@linux.alibaba.com>
Date: Mon, 17 Mar 2025 14:43:48 +0800
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
Subject: Re: [PATCH v5] erofs: use Z_EROFS_LCLUSTER_TYPE_MAX to simplify
 switches
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, Hongzhen Luo <hongzhen@linux.alibaba.com>,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
References: <20250210032923.3382136-1-hongzhen@linux.alibaba.com>
 <511c5fd9-307e-4c56-9d20-796dd06f775c@kernel.org>
 <489be3d1-a755-4756-ba82-a8f5a0dc9156@linux.alibaba.com>
 <04050888-7abf-40fa-98d6-6215b8ba989e@kernel.org>
 <18767765-53b5-4e78-b50d-9305fe1cb2d0@linux.alibaba.com>
 <1dd3b2a6-5431-4a2a-bccb-2a3672f5d1bd@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <1dd3b2a6-5431-4a2a-bccb-2a3672f5d1bd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/3/17 14:42, Chao Yu wrote:
> On 3/17/25 14:15, Gao Xiang wrote:
>> Hi Chao,
>>
>> On 2025/3/17 14:03, Chao Yu wrote:
>>> On 3/17/25 01:17, Gao Xiang wrote:
>>>> Hi Chao,
>>>>
>>
>> ...
>>
>>>>
>>>> Previously, it was useful before Z_EROFS_LCLUSTER_TYPE_HEAD2 was
>>>> introduced, but the `default:` case is already deadcode now.
>>>
>>> Xiang, thanks for the explanation.
>>>
>>> So seems it can happen when mounting last image w/ old kernel which can not
>>> support newly introduced Z_EROFS_LCLUSTER_TYPE_* type, then it makes sense to
>>> return EOPNOTSUPP.
>>
>> Yeah.
>>
>>>
>>>>
>>>>>
>>>>> Btw, we'd better to do sanity check for m->type in z_erofs_load_full_lcluster(),
>>>>> then we can treat m->type as reliable variable later.
>>>>>
>>>>>        advise = le16_to_cpu(di->di_advise);
>>>>>        m->type = advise & Z_EROFS_LI_LCLUSTER_TYPE_MASK;
>>>>>        if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
>>>>
>>>> It's always false here.
>>>
>>> So, what do you think of this?
>>>
>>>   From af584b2eacd468f145e9ee31ccdeedb7355d5afd Mon Sep 17 00:00:00 2001
>>> From: Chao Yu <chao@kernel.org>
>>> Date: Mon, 17 Mar 2025 13:57:55 +0800
>>> Subject: [PATCH] erofs: remove dead codes for cleanup
>>>
>>> z_erofs_extent_lookback() and z_erofs_get_extent_decompressedlen() tries
>>> to do sanity check on m->type, however their caller z_erofs_map_blocks_fo()
>>> has already checked that, so let's remove those dead codes.
>>
>> z_erofs_extent_lookback() will (lookback) read new lcn in
>> z_erofs_load_lcluster_from_disk() so it won't be covered by
>> the original z_erofs_map_blocks_fo().
> 
> Xiang,
> 
> Oh, I see, changed here:
> 
> - z_erofs_extent_lookback
>   - z_erofs_load_lcluster_from_disk
>    - z_erofs_load_full_lcluster
>    : m->type = advise & Z_EROFS_LI_LCLUSTER_TYPE_MASK;
>   - z_erofs_load_compact_lcluster
>   : m->type = type;

Yeah, we'd better to move all checks into
z_erofs_load_lcluster_from_disk() later.

> 
>>
>> I think this check can be resolved in
>> z_erofs_load_lcluster_from_disk() instead but maybe address
>> for the next cycle? since there are already enough features
>> for this cycle and I have to make sure no major issues....
> 
> Yeah, it's fine to check the cleanup later, let's keep focusing
> on improving patches in dev now.

Yes.

Thanks,
Gao Xiang

> 
> Thanks,
> 
>>
>> Thanks,
>> Gao Xiang
>>


