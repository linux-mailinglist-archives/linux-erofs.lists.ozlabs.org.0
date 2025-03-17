Return-Path: <linux-erofs+bounces-80-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C07A641EE
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Mar 2025 07:42:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZGQPt6cG8z2ydW;
	Mon, 17 Mar 2025 17:42:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742193746;
	cv=none; b=cPZsIkiYr9t4qQnecxkCabCyNLFkbVCJenzVR/eqhHneHSVEc6/Tuc8THlVAP2A93t4y+BahSvOg9EyJvUMw36E9VYcp6mXkFwsIx6Cx2wTauarlhuvd0CJk8dVlDWAbfGA8VwGjd2MBqXHdVRsDelHJ3+ez4BO/UzjWR3gloMm0gJddCBC7X++6kYBMs0KcwMHp9BJzuYPoGJfV6i6HhT5zJSmTIbuUhZtQms/9l1fcmlpvhI5+hJZq5WIPqdIVkzHyIHOK9yi7fZDTfsfgYDJW0Uh56c8IZw3MXmYNOD5duv0IxwrlKBUjKgR4CEvFgx1HT4GF8O7yXlUUosvqwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742193746; c=relaxed/relaxed;
	bh=TvpXyXFH+tBXAV+c5la/nrqm5OGAAah2VoTpqxoEcVg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DPNqiiDIFX64cTA/MA5sxME55V02hmI4LXQ9VS3qfOjwRPIycBpaqkYN2+Bw6RXvzbdLxUXaUq6iEnoRk9neb5RItXc14clQhU7N8KfJzia0UzRP658ym7rNTMrV4WnjZr8fGSVnkYSaza8QLkf6BfnNRMMSXTZq558/C7egD2DnRJqbl9ZAI5wV1quDT0J8qbpIyKl6GB+xMGQ90rMZkP0IFhtyKveIginllRZ4r28/9GK5JPmMYj/b5GBZEjfQM8AMY6C1wyYG56DyspA+EuaIwdPtnUlRSWNnGLlPRel+vHE1ky/OG4jVSD7xIYI5s0tk/FfElr50jrm7FeHKmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oNE9lSrJ; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oNE9lSrJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZGQPt0gVcz2yd7
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Mar 2025 17:42:26 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 70EEA5C4839;
	Mon, 17 Mar 2025 06:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C464C4CEE3;
	Mon, 17 Mar 2025 06:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742193742;
	bh=FuS8Av9mTTAznTxqWO7qBNNd49jKIqF6PQ5eAuT/Yv8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=oNE9lSrJI67ImxHG55W0LD2RLYScUWXTrqRCcKIXq6kQqwFfGG7g1+zDQ4xVc+tXn
	 fB/E+fw2RZuoZgaxMIbSKARV+7hLdK4uTnpujfNQtiykpE7AbJo0KG+Wj6/5CXBxPc
	 mZscr9XXyDM+Du5DSnM7aI5B0jgEZAJxE0EcjkuXlnWIP9gKtTc4siw+Mvh9KMYbFw
	 03OwP1+YmrtPI4U3oC5jmGAPZllBJdaSWUJ7nMifFDS4WIoyEN2+8u+Q9iixdJLUUO
	 IZVqfmILNXmJxK6p9M6q4SqVZO6bvFAirmgW2e6HlfPMzchWG0X5krY4DSYncgr94J
	 rndBIs/7EXyrQ==
Message-ID: <1dd3b2a6-5431-4a2a-bccb-2a3672f5d1bd@kernel.org>
Date: Mon, 17 Mar 2025 14:42:19 +0800
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
Cc: chao@kernel.org, linux-kernel@vger.kernel.org,
 Hongzhen Luo <hongzhen@linux.alibaba.com>,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Subject: Re: [PATCH v5] erofs: use Z_EROFS_LCLUSTER_TYPE_MAX to simplify
 switches
To: Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20250210032923.3382136-1-hongzhen@linux.alibaba.com>
 <511c5fd9-307e-4c56-9d20-796dd06f775c@kernel.org>
 <489be3d1-a755-4756-ba82-a8f5a0dc9156@linux.alibaba.com>
 <04050888-7abf-40fa-98d6-6215b8ba989e@kernel.org>
 <18767765-53b5-4e78-b50d-9305fe1cb2d0@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <18767765-53b5-4e78-b50d-9305fe1cb2d0@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 3/17/25 14:15, Gao Xiang wrote:
> Hi Chao,
> 
> On 2025/3/17 14:03, Chao Yu wrote:
>> On 3/17/25 01:17, Gao Xiang wrote:
>>> Hi Chao,
>>>
> 
> ...
> 
>>>
>>> Previously, it was useful before Z_EROFS_LCLUSTER_TYPE_HEAD2 was
>>> introduced, but the `default:` case is already deadcode now.
>>
>> Xiang, thanks for the explanation.
>>
>> So seems it can happen when mounting last image w/ old kernel which can not
>> support newly introduced Z_EROFS_LCLUSTER_TYPE_* type, then it makes sense to
>> return EOPNOTSUPP.
> 
> Yeah.
> 
>>
>>>
>>>>
>>>> Btw, we'd better to do sanity check for m->type in z_erofs_load_full_lcluster(),
>>>> then we can treat m->type as reliable variable later.
>>>>
>>>>       advise = le16_to_cpu(di->di_advise);
>>>>       m->type = advise & Z_EROFS_LI_LCLUSTER_TYPE_MASK;
>>>>       if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
>>>
>>> It's always false here.
>>
>> So, what do you think of this?
>>
>>  From af584b2eacd468f145e9ee31ccdeedb7355d5afd Mon Sep 17 00:00:00 2001
>> From: Chao Yu <chao@kernel.org>
>> Date: Mon, 17 Mar 2025 13:57:55 +0800
>> Subject: [PATCH] erofs: remove dead codes for cleanup
>>
>> z_erofs_extent_lookback() and z_erofs_get_extent_decompressedlen() tries
>> to do sanity check on m->type, however their caller z_erofs_map_blocks_fo()
>> has already checked that, so let's remove those dead codes.
> 
> z_erofs_extent_lookback() will (lookback) read new lcn in
> z_erofs_load_lcluster_from_disk() so it won't be covered by
> the original z_erofs_map_blocks_fo().

Xiang,

Oh, I see, changed here:

- z_erofs_extent_lookback
 - z_erofs_load_lcluster_from_disk
  - z_erofs_load_full_lcluster
  : m->type = advise & Z_EROFS_LI_LCLUSTER_TYPE_MASK;
 - z_erofs_load_compact_lcluster
 : m->type = type;

> 
> I think this check can be resolved in
> z_erofs_load_lcluster_from_disk() instead but maybe address
> for the next cycle? since there are already enough features
> for this cycle and I have to make sure no major issues....

Yeah, it's fine to check the cleanup later, let's keep focusing
on improving patches in dev now.

Thanks,

> 
> Thanks,
> Gao Xiang
> 


