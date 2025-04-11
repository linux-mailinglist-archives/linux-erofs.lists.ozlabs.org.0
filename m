Return-Path: <linux-erofs+bounces-191-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E2EA85192
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Apr 2025 04:28:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZYgbc6rVLz3bn4;
	Fri, 11 Apr 2025 12:28:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744338524;
	cv=none; b=UmwyS2W2TOSyq5bTrSelQdzFSpnexol5acY0Zpc9jdVdCM4BJ+37mWNuFe9ueaAVbGzaCwo7tyfajBvZlUyo0P+p331eqWOnzwjZhtTpxoS3RwMDWTZL0KQ/0PwPB8en+TtWX6rTQEMvH/+o9liLQDH8Z/YX2+Lj1kVF1dt6cTqpuk2Kj3hT27kZ5ynU4MZ8hgYAzBYaBl25JvSFLuttlXAFdF899Wtf06Yz87gA8pqcfkiBFe9BNAzG+iyubScKZNI4H7op+EgvAyCWwh/MCD27l67B+xYesbMAqNUvS4h2z4F17nioLCSnbudSid8jwT8FosNczeChcvAriKb4wA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744338524; c=relaxed/relaxed;
	bh=E9bGGUreuEr9WcQwyHdCJYupubC8PqSvroGU5lP73V0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j6WFwiWezFVQBxxFjk3sA+JB0hl1xye7p3h/pPUS9z+s76PuFJumkJT0OeSrvU0Oq8+eTjZZ5Ez/AaqVCTB2ox/d+GctLPkXY99WbtUTFwK4bBvlSx/mCtql7/JSltd9OXHGKhyFkM3zzrv5rHehzlMHifh1E5HxEbZuCkLsiboLrTPQTVODqhxBdgy1HuyN6raqzdG4idUHAmuugJPiEcvOXgVfLLZetoFLeosESecu1yb1gtS39KHC9I5iB3DS+g0X72KlGc3r3oWij/sQGbtvReMHKjMKjM30Zqa2SeTumg1yiqYeuh6Rf6HFacY7FYCquUAlZ+AtPMJkpXnsjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=o48enWjl; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=o48enWjl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZYgbb2VQqz2ym3
	for <linux-erofs@lists.ozlabs.org>; Fri, 11 Apr 2025 12:28:42 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1744338518; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=E9bGGUreuEr9WcQwyHdCJYupubC8PqSvroGU5lP73V0=;
	b=o48enWjlElFpTTskjgH6aoHBWaqoszf2G34m/0x76rQ/eio0267aAZXQsSQNYVdAH5EIUBJMEKXM3y6Zl7gvQsVuIykR3Kiz2Y7c/0bz+O4NY4AZLbkO7ufCRB3V7MwwJZuyoywndWueAD7BG3k97WjeeHBzZy/T8XqQyVw38+8=
Received: from 30.74.129.90(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WWRQjjz_1744338516 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 11 Apr 2025 10:28:36 +0800
Message-ID: <3f901a84-9157-4f93-86a4-b56f5c240f78@linux.alibaba.com>
Date: Fri, 11 Apr 2025 10:28:35 +0800
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
Subject: Re: [PATCH 1/2] erofs: add __packed annotation to union(__le16..)
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 kernel test robot <lkp@intel.com>
References: <20250408114448.4040220-1-hsiangkao@linux.alibaba.com>
 <20250409195222.4cadc368@pumpkin>
 <7af3e868-04cb-47b1-a81b-651be3756ec5@linux.alibaba.com>
 <20250410215305.0c919e78@pumpkin>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250410215305.0c919e78@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/4/11 04:53, David Laight wrote:
> On Thu, 10 Apr 2025 07:56:45 +0800
> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> 
>> Hi David,
>>
>> On 2025/4/10 02:52, David Laight wrote:
>>> On Tue,  8 Apr 2025 19:44:47 +0800
>>> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>>    
>>>> I'm unsure why they aren't 2 bytes in size only in arm-linux-gnueabi.
>>>
>>> IIRC one of the arm ABI aligns structures on 32 bit boundaries.
>>
>> Thanks for your reply, but I'm not sure if it's the issue.
> 
> Twas a guess, the fragment in the patch doesn't look as though it
> will add padding.
> 
> All tests I've tried generate a 2 byte union.
> But there might be something odd about the definition of __le16.
> 
> Or the compiler is actually broken!

Sigh, I'm not sure, it's really a mess but I don't have
more time to look into that.

> 
>>
>>>    
>>>>


..

>>
>> I doesn't work and will report
>>
>> In file included from <command-line>:
>> In function 'erofs_check_ondisk_layout_definitions',
>>       inlined from 'erofs_module_init' at ../fs/erofs/super.c:817:2:
>> ./../include/linux/compiler_types.h:542:38: error: call to '__compiletime_assert_332' declared with attribute error: BUILD_BUG_ON failed: sizeof(struct erofs_inode_compact) != 32
>>     542 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>         |
> 
> Try with just __packed __aligned(2) on the union definition.
> That should overcome whatever brain-damage is causing the larger alignment,

Currently it works fine with `__packed` on the union definition,

do you suggest adding both `__packed` and `__aligned(2)`, may
I ask what's the benefit of `__aligned(2)`?

> 
>>
>>>
>>> I'd add a compile assert (of some form) on the size of the structure.
>>
>> you mean
>>
>> @@ -435,6 +435,7 @@ static inline void erofs_check_ondisk_layout_definitions(void)
>>           };
>>
>>           BUILD_BUG_ON(sizeof(struct erofs_super_block) != 128);
>> +       BUILD_BUG_ON(sizeof(union erofs_inode_i_nb) != 2);
>>           BUILD_BUG_ON(sizeof(struct erofs_inode_compact) != 32);
> 
> I'm sure there is one that you can put in the .h file itself.
> Might have to be Static_assert().
> 
>>
>> ?
>>
>>
>> ./../include/linux/compiler_types.h:542:38: error: call to '__compiletime_assert_332' declared with attribute error: BUILD_BUG_ON failed: sizeof(union erofs_inode_i_nb) != 2
>>     542 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>         |                                      ^
>>
>> That doesn't work too.
> 
> That it the root of the problem.
> I'd check with just a 'short' rather than the __le16.

.. sigh.. I have no more interest on this now due to lack
of time (my current employer doesn't allow me), I think
if there is no better ideas, let's keep the original patch
way to resolve arm compile issues...

Thanks,
Gao Xiang

