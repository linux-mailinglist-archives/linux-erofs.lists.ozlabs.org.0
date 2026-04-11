Return-Path: <linux-erofs+bounces-3284-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDqYA5Nk2mnb1ggAu9opvQ
	(envelope-from <linux-erofs+bounces-3284-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Apr 2026 17:11:15 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C5C3E0914
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Apr 2026 17:11:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ftHDs11rkz2ymg;
	Sun, 12 Apr 2026 01:11:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.181.183.35
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775920269;
	cv=none; b=d1nOMkXUgVgxK3dboVZJVAFLwWwTkcXaVRpyktI4PBnkZqqbwAn7HSgNDnvyQCmB6jALty5SyM66yan/ei7+FHxxlLHp5NlofmA9AaJRqeGXib4DK9Cj2j2MdLbVjqYRzX4i6Q/LJqAF+lW+QiNwGQwJ0Iv9X7ydodNFFGWbktM61PbO48pzeL4seB8dh40fy5+AB3VaULxoLcELpFSju4rSzcm5Hb5jkiEnmOt7xLQTdDFiX2/IiNInsW4L4u+OEBYcSmmZCGvN7jlWMNhurBJtNepXNRU2/YeK5US5tnSNBgyj0iuB4VoUZjMJ/tI9uBhoQpVTf0AmXBHPFrqJuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775920269; c=relaxed/relaxed;
	bh=gaBtEXe4+rq93ONEe+uKio6hRabg4UwNzzo4NC47tiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kvaJhiGYqj0QFHXCee6s7hMTFTgQoMpeU5uzR5W4zInWRXwdugTF1vN1sUhJcuMzhlOF4wa7XPdBwtvDicFA1UmhQSXEp237qVBrf2r5qZ66tDVr0FYpt3wjMLnOy8DWZOxqoN1Mv8+4uha6Ojlaxvj96Hr00Qg6UN5tB8GTIbEWm/5iSEsHlyYP3NJLHmhkjDpGR7spqv5iI1wBhYMPKJ2MJujuctY5cV2EFPCa4iHQRpIG5LioT6cM24bn9ABBoiRKVk7Jvyu3jzlLoyQG8F6eOxq6P0F5iDhNJNuNQVgOZebp0UzAYd3pqXviVEllzQx0H2vYEO6BHFVJDuttfw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.a=rsa-sha256 header.s=post header.b=L/FLCHFK; dkim-atps=neutral; spf=pass (client-ip=95.181.183.35; helo=mx5.sberdevices.ru; envelope-from=avkrasnov@salutedevices.com; receiver=lists.ozlabs.org) smtp.mailfrom=salutedevices.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.a=rsa-sha256 header.s=post header.b=L/FLCHFK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=salutedevices.com (client-ip=95.181.183.35; helo=mx5.sberdevices.ru; envelope-from=avkrasnov@salutedevices.com; receiver=lists.ozlabs.org)
Received: from mx5.sberdevices.ru (mx5.sberdevices.ru [95.181.183.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ftHDp0hC2z2yl2
	for <linux-erofs@lists.ozlabs.org>; Sun, 12 Apr 2026 01:11:03 +1000 (AEST)
Received: from p-antispam-ksmg-gc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx5.sberdevices.ru (Postfix) with ESMTP id 27DA8240005;
	Sat, 11 Apr 2026 18:10:54 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx5.sberdevices.ru 27DA8240005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=post; t=1775920254;
	bh=gaBtEXe4+rq93ONEe+uKio6hRabg4UwNzzo4NC47tiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=L/FLCHFKmYv5UrI957Tv7YBk4I6vvcKEcDKVLez83H2LM995r1Vt2l2HKPVlZTB5Y
	 vz9cG1hkiDB8petvcmA+UOMdu1DrR9EQnC6IZJvuuJ8IXB0w2KFnGZ3dNyGYvWFaVR
	 1KH8A+JgzuKZI1vTYy/ZvHztx/l0GZOriz5pdUNlirT0E/PP8uGwKgkgx2WSYRTX3l
	 BeumzHStd6dizkKnOi+U9OqRIahldk+R+CzQ4NAw/Y1B/HEXV5Br7cueCegbOk9p/e
	 Mn6qeB/ueeyo57w6qsawNJtocGznfBcIYyN8Xnyn1N2GzrCCL8yH891iSdtg0xa30L
	 c0LYXd34ZEbUQ==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "sberdevices.ru", Issuer "R12" (not verified))
	by mx5.sberdevices.ru (Postfix) with ESMTPS;
	Sat, 11 Apr 2026 18:10:53 +0300 (MSK)
Message-ID: <2ca3c8c6-f3ed-40ca-8f5c-1b43df479ad7@salutedevices.com>
Date: Sat, 11 Apr 2026 18:10:47 +0300
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
To: Gao Xiang <hsiangkao@linux.alibaba.com>
CC: <oxffffaa@gmail.com>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <kernel@salutedevices.com>, Gao Xiang
	<xiang@kernel.org>
References: <4a2f3801-fac1-42fe-ae75-da315822e088@salutedevices.com>
 <f1ed0cff-57ff-4fb3-b102-0a0a6d79f1a9@linux.alibaba.com>
 <2e916997-0557-45e7-831a-b436c07c5ba4@salutedevices.com>
 <c2d7d5ff-237d-48b5-82a2-ac4618f055cc@linux.alibaba.com>
 <97ca00c7-822d-4b57-9dc0-9b396049adc9@salutedevices.com>
 <8c0bdfab-dbf2-4f1e-8e2a-ce18f166d841@linux.alibaba.com>
Content-Language: ru
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <8c0bdfab-dbf2-4f1e-8e2a-ce18f166d841@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.28.3.98]
X-ClientProxiedBy: p-exch-cas-a-m2.sberdevices.ru (172.24.201.210) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-AntiPhishing: NotDetected, bases: 2026/04/11 14:53:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Info: LuaCore: 98 0.3.98 ca9d2f3beca9ca2a85e178af9d8e97d5fa2c38a3, {Tracking_uf_ne_domains}, {Tracking_bl_eng_cat}, {Tracking_arrow_http}, {Tracking_from_domain_doesnt_match_to}, git.kernel.org:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 202202 [Apr 10 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.22
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/04/11 11:59:00 #28387229
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected, bases: 2026/04/11 14:53:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[salutedevices.com,none];
	R_DKIM_ALLOW(-0.20)[salutedevices.com:s=post];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-3284-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	FORGED_SENDER(0.00)[avkrasnov@salutedevices.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:oxffffaa@gmail.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:kernel@salutedevices.com,m:xiang@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[gmail.com,lists.ozlabs.org,vger.kernel.org,salutedevices.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	HAS_XOIP(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avkrasnov@salutedevices.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[salutedevices.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[salutedevices.com:dkim,salutedevices.com:mid]
X-Rspamd-Queue-Id: 45C5C3E0914
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



10.04.2026 18:41, Gao Xiang пишет:
> Hi Arseniy,
> 
> On 2026/4/10 21:27, Arseniy Krasnov wrote:
>>
>>
>> 10.04.2026 15:20, Gao Xiang пишет:
>>>
>>>
>>> On 2026/4/10 19:37, Arseniy Krasnov wrote:
>>>
>>> (drop unrelated folks since they all subscribed erofs mailing list)
>>>
>>>>
>>>>
>>>> 10.04.2026 11:31, Gao Xiang wrote:
>>>>> Hi,
>>>>>
>>>>> On 2026/4/10 16:13, Arseniy Krasnov wrote:
>>>>>> Hi,
>>>>>>
>>>>>> We found unexpected behaviour of erofs:
>>>>>>
>>>>>> There is function in erofs - 'erofs_onlinefolio_end()'. It has pointer to
>>>>>> 'struct folio' as first argument, and there is loop inside this function,
>>>>>> which updates 'private' field of provided folio:
>>>>>>
>>>>>>      do {
>>>>>>              orig = atomic_read((atomic_t *)&folio->private);
>>>>>>              DBG_BUGON(orig <= 0);
>>>>>>              v = dirty << EROFS_ONLINEFOLIO_DIRTY;
>>>>>>              v |= (orig - 1) | (!!err << EROFS_ONLINEFOLIO_EIO);
>>>>>>      } while (atomic_cmpxchg((atomic_t *)&folio->private, orig, v) != orig);
>>>>>>
>>>>>> Now, we see that in some rare case, this function processes folio, where
>>>>>> 'private' is pointer, and thus this loop will update some bits in this
>>>>>> pointer. Then later kernel dereferences such pointer and crashes.
>>>>>>
>>>>>> To catch this, the following small debug patch was used (e.g. we check that 'private' field is pointer):
>>>>>>
>>>>>> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
>>>>>> index 33cb0a7330d2..b1d8deffec4d 100644
>>>>>> --- a/fs/erofs/data.c
>>>>>> +++ b/fs/erofs/data.c
>>>>>> @@ -238,6 +238,11 @@ void erofs_onlinefolio_end(struct folio *folio, int err, bool dirty)
>>>>>>     {
>>>>>>         int orig, v;
>>>>>>     +    if (((uintptr_t)folio->private) & 0xffff000000000000) {
>>>>>
>>>>> No, if erofs_onlinefolio_end() is called, `folio->private`
>>>>> shouldn't be a pointer, it's just a counter inside, and
>>>>> storing a pointer is unexpected.
>>>>>
>>>>> And since the folio is locked, it shouldn't call into
>>>>> try_to_free_buffers().
>>>>>
>>>>> Is it easy to reproduce? if yes, can you print other
>>>>> values like `folio->mapping` and `folio->index` as
>>>>> well?
>>>>>
>>>>> I need more informations to find some clues.
>>>>
>>>>
>>>>
>>>> So reproduced again with this debug patch which adds magic to 'struct z_erofs_pcluster' and prints 'struct folio'
>>>> when pointer in 'private' is passed to 'erofs_onlinefolio_end()'. In short - 'private' points to 'struct z_erofs_pcluster'.
>>> First, erofs-utils 1.8.10 doesn't support `-E48bit`:
>>> only erofs-utils 1.9+ ship it as an experimental
>>> feature, see Changelog; so I think you're using
>>> modified erofs-utils 1.8.10:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/tree/ChangeLog
>>>
>>> ```
>>> erofs-utils 1.9
>>>
>>>   * This release includes the following updates:
>>>     - Add 48-bit layout support for larger filesystems (EXPERIMENTAL);
>>> ```
>>>
>>> Second, I'm pretty sure this issue is related to
>>> experimenal `-E48bit`, and those information is
>>> not enough for me to find the root cause, so I
>>> need to find a way to reproduce myself: It may
>>> take time; you could debug yourself but I don't
>>> think it's an easy task if you don't quite familiar
>>> with the EROFS codebase.
>>>
>>> Anyway I really suggest if you need a rush solution
>>> for production, don't use `-E48bit + zstd` like
>>> this for now: try to use other options like
>>> `-zzstd -C65536 -Efragments` instead since those
>>> are common production choices.
>>
>> Ok thanks for this advice! One more question: currently we use this options:
>> "zstd,22 --max-extent-bytes 65536 -E48bit". Ok we remove "zstd,22" and "E48bit",
>> but what about "--max-extent-bytes 65536" - is it considered stable option?
>> Or it is better to use your version: "-zzstd -C65536 -Efragments" ?
> 
> I'm not sure how you find this
> "zstd,22 --max-extent-bytes 65536 -E48bit" combination.
> 
> My suggestion based on production is that as long as
> you don't use `-zzstd` ++ `-E48bit`, it should be fine.
> 
> If you need smaller images, I suggest: `-zlzma,9 -C65536 -Efragments`
> Or like Android, they all use `-zlz4hc`,
> Or zstd, but don't add `-E48bit`.
> 
> As for "--max-extent-bytes 65536", it can be dropped
> since if `-E48bit` is not used, it only has negative
> impacts.
> 
> In short, `-E48bit` + `-zzstd` + `--max-extent-bytes`
> enables new unaligned compression for zstd, but it's
> a relatively new feature, I still still some time to
> stablize it but my own time is limited and all things
> are always prioritized.

Ok, thanks for this advice!

Thanks

> 
> Thanks,
> Gao Xiang
> 
>>
>> Thanks
>>
>>>
>>> Thanks,
>>> Gao Xiang
> 


