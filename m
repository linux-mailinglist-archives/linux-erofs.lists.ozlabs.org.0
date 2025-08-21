Return-Path: <linux-erofs+bounces-861-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A48B2F4CF
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Aug 2025 12:03:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c6zRx03NZz2yhD;
	Thu, 21 Aug 2025 20:03:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755770636;
	cv=none; b=ou2uKx/XG++vQf1ND5eNBcarQ5i9XZWe1Corst2tC+RknIk2Fpy5LXl+mZKVxLy82UT4ekR8TYSm4e+T15BAJF81eKBjcL9qrIw9Xa20mtr9zM+SwVanUqaoM4sp63zg7nS1QZQbMD5GmRO2XQJUsxQ6TVx6BvYKJJR/lHD4WgqQNYISmdSdOSdZdqxPpEqkQQ20GppQaSKI17cDeNjDj/nXW3ZI6DeUYdH8kwBTVDPLm/shMX2QXrypfASx0rMXah8la7oZbjZY0uqXG6z9E5rpfjfJBXjsNDzb8WUDqeonMj3UyxBtVvLucvKwHgDTi8L8Uq0ONLyOgCbP1lvsBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755770636; c=relaxed/relaxed;
	bh=xE85KV3cOyexsLm5KqA0EI4+WxvjaO7fjSL4Z5UhMU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oqF76vTuVhG8FuU8u2pmlNepp5IjaMmX/LCxnjM1DpWDUah/xy8UUpiLC1GJF4DKA5MZ0SFdhkwFe+YsLkYXHkmv4Wp4SXyAdZagPYwX1Yvp66kF+s0Zy8UqXNM93AcCYcbhA8wU+AaeqbpVs5R4tbupN3bz1J5gBv7QhoNe/Vi1bR3sJ18idLE7Z8Ip1itNzwaE5HgH9IkIM+5lEqm646YJXNimr5mFCjXCE6DFL93ntaretF3/GOfdt72lYS2PiWDpA1Xi+fjhAb45TVJdVpFyCkD4gqUeHTjbt4jj0733oQkMX/xjiTQHzONCuvB2lo/5HMhsgbhsFwDKGWRTFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bQvA4YdX; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bQvA4YdX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c6zRv1mg5z2yCL
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 Aug 2025 20:03:53 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755770630; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=xE85KV3cOyexsLm5KqA0EI4+WxvjaO7fjSL4Z5UhMU0=;
	b=bQvA4YdXEwquUrHJTAqVGVQkWwAXf0pXBWigflOQ008xNbJBAOw210S/N+h63T6t8tgqRzdwS0oTPbZCMcVl4Vrio4eHghqygKknBh5O91f0vFBdilM+Z5V/lXuqLqlojf7RX63TxCq2zHQ+5FkPIACs+vIE2ZuITmCzqWCA/YA=
Received: from 30.221.130.165(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WmFo5rE_1755770628 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 21 Aug 2025 18:03:49 +0800
Message-ID: <753b7f16-71ce-499d-8e1c-dac1503929b3@linux.alibaba.com>
Date: Thu, 21 Aug 2025 18:03:48 +0800
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
Subject: Re: [PATCH v1] erofs-utils: mkfs: Implement 'dsunit' alignment on
 blobdev
To: "Friendy.Su@sony.com" <Friendy.Su@sony.com>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Cc: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
 "Daniel.Palmer@sony.com" <Daniel.Palmer@sony.com>
References: <20250820072352.4151620-1-friendy.su@sony.com>
 <39f81655-8bef-428c-843b-b57c9e50c90d@linux.alibaba.com>
 <TY0PR04MB61910F716A77A3E6F0F8FE43FD33A@TY0PR04MB6191.apcprd04.prod.outlook.com>
 <5be2a340-acbc-4ce9-8bb6-1bfb91562944@linux.alibaba.com>
 <TY0PR04MB61914EA9FEB78ACA041F59CBFD33A@TY0PR04MB6191.apcprd04.prod.outlook.com>
 <96d466e7-eb96-48b7-bd89-b67381737b4b@linux.alibaba.com>
 <TY0PR04MB61911E8A1B8975C7B69651D9FD32A@TY0PR04MB6191.apcprd04.prod.outlook.com>
 <6b611a64-6a63-4588-acbf-dd853d3bc624@linux.alibaba.com>
 <97d6c19f-1faf-423f-83e7-0996fff2ca26@linux.alibaba.com>
 <TY0PR04MB6191740A411A08FFABE272EFFD32A@TY0PR04MB6191.apcprd04.prod.outlook.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <TY0PR04MB6191740A411A08FFABE272EFFD32A@TY0PR04MB6191.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/8/21 17:36, Friendy.Su@sony.com wrote:
> Hi, Gao,
> 
>> But if there is some deduplciated chunks in the logical dsunit
>> boundary, don't align it at all since there is no real benefit.
>> Although I'm still not sure what's the default behavior of `dsunit`
>> for chunks.
> 
> Exactly, if `--chunksize=4096 --dsunit=512`, any 4K deduplicated will cause PMD map failure.  Can we consider the following countermeasure as default behavior:
> 
> 1. In man page, describe 'chunksize' and 'dsunit' should be collaborated to achieve the best performance.

Agreed, we should mention that in the manpage:

> 
> 2. At runtime, if chunksize < dsunit,
>    prompt alert message, tell user it is better set chunksize=dsunit. But still format with user set options.
>    The benefit is user can still set as desired. Current, for the use cases we can imagine, chunksize=dsunit is best. But maybe users have their own use cases, it is better let users do what they really wanted.

But could we just apply your patch only to the dsunit>=chunksize
case to fulfill your exist use case? I mean we still ignore
`dsunit` if dsunit!=chunksize and warn out users explicitly (
`dsunit` doesn't work due to dsunit!=chunksize).

I really need to think about chunksize != dsunit cases, but
since you don't have such urgent need, let's keep the old `ignore`
behavior for now...

Thanks,
Gao XIang

> 
> 
> If mkfs.erofs force to align every 2M, even there is only 4K not deduplicated in 2M, the 4K actually still occupies 2M.
> 0, 2M(only 4K data new, others all deduplicated), 4M........
> Space usage efficiency is same as chunksize=dsunit=2M.
> 
> 
> Best Regards
> Friendy
> 

