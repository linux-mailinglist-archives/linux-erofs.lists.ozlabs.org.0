Return-Path: <linux-erofs+bounces-3276-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAlJJ4vr2GlBjwgAu9opvQ
	(envelope-from <linux-erofs+bounces-3276-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Apr 2026 14:22:35 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D4D3D6D87
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Apr 2026 14:22:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsbWD1TBGz3dyq;
	Fri, 10 Apr 2026 22:21:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775823672;
	cv=none; b=JcKD672O3ZVp/mLBAclfkXh2TxU+FxoRzNwhnZo0w2tKvvyK98bM8q0qzHlY/8g0Qr2t56DJGTnZcfEhwY/yXsy7kBoHcZ4P/aJHQA2ENFW/FbHe7pg3w5s14BZSifAmU7yld5LXjQfVzMPiTl8Z8SxFZD8i43QYj5NYYLartCT7qkADE4c+NvybGL/4ceBRH3H7UOjdtVDVOdl3w5KrjYLhdNOCLRmTHlUajGd5ryBEnhi8rD1Eu4PCgLERbbChu4C5dFZoQP7Don01oJRHgivMzo96dIK6Q+0Wflfia7UGceK3D074qQ4cuwIC9E2Axirp5q0/1jZ545CUxjAoYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775823672; c=relaxed/relaxed;
	bh=7jd40Vyoz/C8/8hlu3IWoHDYU/k9DOsf7STa3E9MOI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kpyt24rWyDKYMXKBvdKhy+X5NGDd+uBQ/l48t1F8Z9cpyjVJmCbiFOFm09TtHnskZUpWDklnHhQZPlZIza6m26fg48B3oIi0kRFuuLLndPRQ1mvsiTvO2UoQcT5Nmc6vKnr+7u2ZXYJo4YBd48ODikpyAC06Yn2EDZnkmFfX2nULK6+9laoJlOhjL3Qm4adA6AR1argWfsQDuLAGorqnuc5DlLxACl6s88AioiadEwXF0Ub488/Sl9TpjbgcBAeVRLiY3crkh611I1sUh4oyfMiRPohVYVfwzyfXY2rjHO8Cfwtzj+dA4MaS/u7hJ5SxCeR+C+glo8a1B/3WiSeaew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PadRVYyu; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PadRVYyu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsbWB1ZNHz2ytJ
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Apr 2026 22:21:08 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775823663; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7jd40Vyoz/C8/8hlu3IWoHDYU/k9DOsf7STa3E9MOI8=;
	b=PadRVYyuHt7LTGFkaiBPHzRP+aw0IYGL6UopUGUAV68ycuHtzuy9sztvAnenWg4aqNN2N5Na3lhG0NXUAnVgG1HVYP43aMU/9U4Ab9f96cMFAXf7dPlPHJYMiYaxAe/qt9PxgjZQN6AB/gRebxvR6+F1IIvCym7W/HKP89TTXjY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X0lGJnj_1775823660;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X0lGJnj_1775823660 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 10 Apr 2026 20:21:00 +0800
Message-ID: <c2d7d5ff-237d-48b5-82a2-ac4618f055cc@linux.alibaba.com>
Date: Fri, 10 Apr 2026 20:20:59 +0800
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
Subject: Re: erofs pointer corruption and kernel crash
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: oxffffaa@gmail.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kernel@salutedevices.com,
 Gao Xiang <xiang@kernel.org>
References: <4a2f3801-fac1-42fe-ae75-da315822e088@salutedevices.com>
 <f1ed0cff-57ff-4fb3-b102-0a0a6d79f1a9@linux.alibaba.com>
 <2e916997-0557-45e7-831a-b436c07c5ba4@salutedevices.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <2e916997-0557-45e7-831a-b436c07c5ba4@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3276-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:avkrasnov@salutedevices.com,m:oxffffaa@gmail.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:kernel@salutedevices.com,m:xiang@kernel.org,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,lists.ozlabs.org,vger.kernel.org,salutedevices.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: C6D4D3D6D87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/10 19:37, Arseniy Krasnov wrote:

(drop unrelated folks since they all subscribed erofs mailing list)

> 
> 
> 10.04.2026 11:31, Gao Xiang wrote:
>> Hi,
>>
>> On 2026/4/10 16:13, Arseniy Krasnov wrote:
>>> Hi,
>>>
>>> We found unexpected behaviour of erofs:
>>>
>>> There is function in erofs - 'erofs_onlinefolio_end()'. It has pointer to
>>> 'struct folio' as first argument, and there is loop inside this function,
>>> which updates 'private' field of provided folio:
>>>
>>>     do {
>>>             orig = atomic_read((atomic_t *)&folio->private);
>>>             DBG_BUGON(orig <= 0);
>>>             v = dirty << EROFS_ONLINEFOLIO_DIRTY;
>>>             v |= (orig - 1) | (!!err << EROFS_ONLINEFOLIO_EIO);
>>>     } while (atomic_cmpxchg((atomic_t *)&folio->private, orig, v) != orig);
>>>
>>> Now, we see that in some rare case, this function processes folio, where
>>> 'private' is pointer, and thus this loop will update some bits in this
>>> pointer. Then later kernel dereferences such pointer and crashes.
>>>
>>> To catch this, the following small debug patch was used (e.g. we check that 'private' field is pointer):
>>>
>>> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
>>> index 33cb0a7330d2..b1d8deffec4d 100644
>>> --- a/fs/erofs/data.c
>>> +++ b/fs/erofs/data.c
>>> @@ -238,6 +238,11 @@ void erofs_onlinefolio_end(struct folio *folio, int err, bool dirty)
>>>    {
>>>        int orig, v;
>>>    +    if (((uintptr_t)folio->private) & 0xffff000000000000) {
>>
>> No, if erofs_onlinefolio_end() is called, `folio->private`
>> shouldn't be a pointer, it's just a counter inside, and
>> storing a pointer is unexpected.
>>
>> And since the folio is locked, it shouldn't call into
>> try_to_free_buffers().
>>
>> Is it easy to reproduce? if yes, can you print other
>> values like `folio->mapping` and `folio->index` as
>> well?
>>
>> I need more informations to find some clues.
> 
> 
> 
> So reproduced again with this debug patch which adds magic to 'struct z_erofs_pcluster' and prints 'struct folio'
> when pointer in 'private' is passed to 'erofs_onlinefolio_end()'. In short - 'private' points to 'struct z_erofs_pcluster'.
First, erofs-utils 1.8.10 doesn't support `-E48bit`:
only erofs-utils 1.9+ ship it as an experimental
feature, see Changelog; so I think you're using
modified erofs-utils 1.8.10:
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/tree/ChangeLog

```
erofs-utils 1.9

  * This release includes the following updates:
    - Add 48-bit layout support for larger filesystems (EXPERIMENTAL);
```

Second, I'm pretty sure this issue is related to
experimenal `-E48bit`, and those information is
not enough for me to find the root cause, so I
need to find a way to reproduce myself: It may
take time; you could debug yourself but I don't
think it's an easy task if you don't quite familiar
with the EROFS codebase.

Anyway I really suggest if you need a rush solution
for production, don't use `-E48bit + zstd` like
this for now: try to use other options like
`-zzstd -C65536 -Efragments` instead since those
are common production choices.

Thanks,
Gao Xiang

