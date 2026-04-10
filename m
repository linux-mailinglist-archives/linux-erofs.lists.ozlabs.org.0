Return-Path: <linux-erofs+bounces-3280-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QA8MNika2WnfmAgAu9opvQ
	(envelope-from <linux-erofs+bounces-3280-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Apr 2026 17:41:29 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 996B73D986C
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Apr 2026 17:41:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsgyF5tszz2ybQ;
	Sat, 11 Apr 2026 01:41:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775835685;
	cv=none; b=SdUqr3R+p6mN0VU8r7FE4TSILpMeZwa0Xb+hB37HqyFwXJIBW+aVzQ+l8VeD3hHxs38j4x4dt9+uMBRzbcaPLqijUsPA+CltpFw80XaFo6m78BqYdm53kgedcu6ir86RZkYZUhlkCdBdWhRy1M/CChOyAb3IfPU+yvgNpv9u0bHUIcTE1XuNE+u4X9THYZet7ypbMok6IN9y5yw1QMU6uyFNlvRYlUTpyhcxb6cTvUKZDvGckKkLXuMBJkn6NyubrO0WChQ3Ayq8vSEHTHuPn2R3Wcdz2//qHpO0cyl8cuqxDh9rA9ERI7qw2f6AnQOCvhLSuVblnzWnbo0rOfXLtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775835685; c=relaxed/relaxed;
	bh=qpSbhb9yAAn81Tu6HnLT64SJVfnfTLUbKpOYf/dcx6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tz0mgEPuc9tFl1/sKz4yGhhEdPB6vZf6c5tcTL4XJqXBBj9yEKkpP6W+ijI+tyfsAkiy2hT7o2Wem0eJpZQD9ZvS15/JjrOUqFpuRCQYRdyTPDrMZPSiNYVVlkIi1CWElvqmahUuPT8rKcom/5dhctUUd0wY8ui3zM3hjhcYmYAlZImF0IhHz3jekJ+OKnwT9qHX1bMg7940h5YBtVR/zWRuYLbbp1M2yj0XKZ+VR+r81d+LPU1tmJVLMsR+0cgesrAS9mCeHuUMjAelCRj9K1fqR8UZ2iXaD+F7DTWAz0Z0gLEeyLmyHMCvbJzjVTqjoU2IuZpq1OCLxcCWvE0eOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Nu1vDjGu; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Nu1vDjGu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsgyC5nlnz2yZ6
	for <linux-erofs@lists.ozlabs.org>; Sat, 11 Apr 2026 01:41:21 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775835676; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qpSbhb9yAAn81Tu6HnLT64SJVfnfTLUbKpOYf/dcx6U=;
	b=Nu1vDjGuO/5rasFhHKaGt/O1jvriw9qyCpC6nxIFg4b34MtFgeC0BGHSD2BkqDPBwjZJvcElkSqi/iz91Ii0RuKIsMVoZUEGEKMpF6wyNBNZ4SZPrepk/z2orj3HPT044FLoCiAJNv1eL5uWFnW79jGob7LQjPjBShunw8snmJY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X0lb6.n_1775835675;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X0lb6.n_1775835675 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 10 Apr 2026 23:41:15 +0800
Message-ID: <8c0bdfab-dbf2-4f1e-8e2a-ce18f166d841@linux.alibaba.com>
Date: Fri, 10 Apr 2026 23:41:14 +0800
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
 <c2d7d5ff-237d-48b5-82a2-ac4618f055cc@linux.alibaba.com>
 <97ca00c7-822d-4b57-9dc0-9b396049adc9@salutedevices.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <97ca00c7-822d-4b57-9dc0-9b396049adc9@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3280-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:avkrasnov@salutedevices.com,m:oxffffaa@gmail.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:kernel@salutedevices.com,m:xiang@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[gmail.com,lists.ozlabs.org,vger.kernel.org,salutedevices.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 996B73D986C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Arseniy,

On 2026/4/10 21:27, Arseniy Krasnov wrote:
> 
> 
> 10.04.2026 15:20, Gao Xiang пишет:
>>
>>
>> On 2026/4/10 19:37, Arseniy Krasnov wrote:
>>
>> (drop unrelated folks since they all subscribed erofs mailing list)
>>
>>>
>>>
>>> 10.04.2026 11:31, Gao Xiang wrote:
>>>> Hi,
>>>>
>>>> On 2026/4/10 16:13, Arseniy Krasnov wrote:
>>>>> Hi,
>>>>>
>>>>> We found unexpected behaviour of erofs:
>>>>>
>>>>> There is function in erofs - 'erofs_onlinefolio_end()'. It has pointer to
>>>>> 'struct folio' as first argument, and there is loop inside this function,
>>>>> which updates 'private' field of provided folio:
>>>>>
>>>>>      do {
>>>>>              orig = atomic_read((atomic_t *)&folio->private);
>>>>>              DBG_BUGON(orig <= 0);
>>>>>              v = dirty << EROFS_ONLINEFOLIO_DIRTY;
>>>>>              v |= (orig - 1) | (!!err << EROFS_ONLINEFOLIO_EIO);
>>>>>      } while (atomic_cmpxchg((atomic_t *)&folio->private, orig, v) != orig);
>>>>>
>>>>> Now, we see that in some rare case, this function processes folio, where
>>>>> 'private' is pointer, and thus this loop will update some bits in this
>>>>> pointer. Then later kernel dereferences such pointer and crashes.
>>>>>
>>>>> To catch this, the following small debug patch was used (e.g. we check that 'private' field is pointer):
>>>>>
>>>>> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
>>>>> index 33cb0a7330d2..b1d8deffec4d 100644
>>>>> --- a/fs/erofs/data.c
>>>>> +++ b/fs/erofs/data.c
>>>>> @@ -238,6 +238,11 @@ void erofs_onlinefolio_end(struct folio *folio, int err, bool dirty)
>>>>>     {
>>>>>         int orig, v;
>>>>>     +    if (((uintptr_t)folio->private) & 0xffff000000000000) {
>>>>
>>>> No, if erofs_onlinefolio_end() is called, `folio->private`
>>>> shouldn't be a pointer, it's just a counter inside, and
>>>> storing a pointer is unexpected.
>>>>
>>>> And since the folio is locked, it shouldn't call into
>>>> try_to_free_buffers().
>>>>
>>>> Is it easy to reproduce? if yes, can you print other
>>>> values like `folio->mapping` and `folio->index` as
>>>> well?
>>>>
>>>> I need more informations to find some clues.
>>>
>>>
>>>
>>> So reproduced again with this debug patch which adds magic to 'struct z_erofs_pcluster' and prints 'struct folio'
>>> when pointer in 'private' is passed to 'erofs_onlinefolio_end()'. In short - 'private' points to 'struct z_erofs_pcluster'.
>> First, erofs-utils 1.8.10 doesn't support `-E48bit`:
>> only erofs-utils 1.9+ ship it as an experimental
>> feature, see Changelog; so I think you're using
>> modified erofs-utils 1.8.10:
>> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/tree/ChangeLog
>>
>> ```
>> erofs-utils 1.9
>>
>>   * This release includes the following updates:
>>     - Add 48-bit layout support for larger filesystems (EXPERIMENTAL);
>> ```
>>
>> Second, I'm pretty sure this issue is related to
>> experimenal `-E48bit`, and those information is
>> not enough for me to find the root cause, so I
>> need to find a way to reproduce myself: It may
>> take time; you could debug yourself but I don't
>> think it's an easy task if you don't quite familiar
>> with the EROFS codebase.
>>
>> Anyway I really suggest if you need a rush solution
>> for production, don't use `-E48bit + zstd` like
>> this for now: try to use other options like
>> `-zzstd -C65536 -Efragments` instead since those
>> are common production choices.
> 
> Ok thanks for this advice! One more question: currently we use this options:
> "zstd,22 --max-extent-bytes 65536 -E48bit". Ok we remove "zstd,22" and "E48bit",
> but what about "--max-extent-bytes 65536" - is it considered stable option?
> Or it is better to use your version: "-zzstd -C65536 -Efragments" ?

I'm not sure how you find this
"zstd,22 --max-extent-bytes 65536 -E48bit" combination.

My suggestion based on production is that as long as
you don't use `-zzstd` ++ `-E48bit`, it should be fine.

If you need smaller images, I suggest: `-zlzma,9 -C65536 -Efragments`
Or like Android, they all use `-zlz4hc`,
Or zstd, but don't add `-E48bit`.

As for "--max-extent-bytes 65536", it can be dropped
since if `-E48bit` is not used, it only has negative
impacts.

In short, `-E48bit` + `-zzstd` + `--max-extent-bytes`
enables new unaligned compression for zstd, but it's
a relatively new feature, I still still some time to
stablize it but my own time is limited and all things
are always prioritized.

Thanks,
Gao Xiang

> 
> Thanks
> 
>>
>> Thanks,
>> Gao Xiang


