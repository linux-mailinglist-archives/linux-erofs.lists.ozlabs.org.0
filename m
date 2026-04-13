Return-Path: <linux-erofs+bounces-3287-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKRmNDSZ3GkxUAkAu9opvQ
	(envelope-from <linux-erofs+bounces-3287-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Apr 2026 09:20:20 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B47833E8261
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Apr 2026 09:20:18 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvJhb4DdBz2yjV;
	Mon, 13 Apr 2026 17:20:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.181.183.35
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776064815;
	cv=none; b=gMXF+mLfkBFPcm6nW6/fkFCb+563R49LxCw6ha0zjrZ6A8DMu3eFdPn2B7hSahYVb77LenWVw2YTXqQR7MdvmwxyZLYDyVjmk7XqLg7wK+XwFKVSoMlmz6lEcr6Ti9M1pN4jX0b1mqdrw2DJNcx0W4AT4jEWYG44GlhFZByLS0TsQbvNVizLrwmloBgDbqiSMZJp53Sbj5OiAcpA68YlpEgJRrgJdiRnHoi1aktI5K8FWc6ojCpRe1Cqw1A5fCD5r5+ZlFisyaZOJLT2zjERoUjc5pFqig8LJIXZ6HkFnCdJJCPoZRpx3P1JGxNTyv0XEbmxNdgrBJ1nG4FrPOEkuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776064815; c=relaxed/relaxed;
	bh=2txxPkYhLgXwCoRTgupCKDlZL9Usyjktg6+MNVeT3iA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Dr2xWdaLruyMl3tPPRRciOFpYWaoQFpMpN/lBlvUqoGeMyaM6NWpdxI3QDybA9+kt0eYhK74lSnMoi7GEcJLoCJCH3iWuWnKmBx09Rb1fSRqNNaV+9fSicbe4A3loZjeSfDfZ1akAp+l7F1y5xUf8EQuIdNgDhsKkmcy3nrUz/w6r/VjvhuJxpnN7Y2ofX6NPVUwzkAGlh3yPUbrdABwZHaBRqI5V1qHg1ms02mVrFxQRy6csFoiQ8Vi5sn89+3bLcKZ/QuYl6bdd5NLDfLTUr6o97+2YNzeVzFczI9MkPJdWsSFVQzVneyH8tNHvR+1VsK7VllVVqp9CzPKObvBkA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.a=rsa-sha256 header.s=post header.b=bCshRACZ; dkim-atps=neutral; spf=pass (client-ip=95.181.183.35; helo=mx5.sberdevices.ru; envelope-from=avkrasnov@salutedevices.com; receiver=lists.ozlabs.org) smtp.mailfrom=salutedevices.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.a=rsa-sha256 header.s=post header.b=bCshRACZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=salutedevices.com (client-ip=95.181.183.35; helo=mx5.sberdevices.ru; envelope-from=avkrasnov@salutedevices.com; receiver=lists.ozlabs.org)
Received: from mx5.sberdevices.ru (mx5.sberdevices.ru [95.181.183.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvJhX2snzz2xTh
	for <linux-erofs@lists.ozlabs.org>; Mon, 13 Apr 2026 17:20:10 +1000 (AEST)
Received: from p-antispam-ksmg-gc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx5.sberdevices.ru (Postfix) with ESMTP id D7AE5240008;
	Mon, 13 Apr 2026 10:20:05 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx5.sberdevices.ru D7AE5240008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=post; t=1776064805;
	bh=2txxPkYhLgXwCoRTgupCKDlZL9Usyjktg6+MNVeT3iA=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=bCshRACZ6Obd21S51MmJwymbudsBIw2yX2NsQH1JXC+5A3fN7iMaO8TTq2nFEWY7J
	 vYzC/yd3l+vkvNoI+id5ghX+oKsdTgQZMh4a90wqRea7yGt5Qn6qjXDiLcb7dWdh28
	 JQlb7G0hBH4LvbG1rGK08jkvUmY7ds1v1I7vugVGFumK08L5pUSVzw2vXeea2J6cRS
	 VZQ61HwV87+L0YD/bfYecGWDLjC/DPYRB0oIDKQwjsNmXFqH5u+QoRDJYqTm0/OWZX
	 ExVHYbpkvPVraXtsEFrfqEfy+XVc2FOwtY9FUlfjqtzrpt1bNhZP3l7GV08WjCo24A
	 0JH18FMALFSRA==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "sberdevices.ru", Issuer "R12" (not verified))
	by mx5.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 13 Apr 2026 10:20:05 +0300 (MSK)
Message-ID: <15702a84-ea4f-4d12-b9e5-a37a4c3bb014@salutedevices.com>
Date: Mon, 13 Apr 2026 10:20:00 +0300
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
 <2ca3c8c6-f3ed-40ca-8f5c-1b43df479ad7@salutedevices.com>
 <36cddf44-3e08-4a19-82ed-04ca178ffab5@linux.alibaba.com>
Content-Language: ru
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <36cddf44-3e08-4a19-82ed-04ca178ffab5@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.28.3.98]
X-ClientProxiedBy: p-exch-cas-a-m2.sberdevices.ru (172.24.201.210) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-AntiPhishing: NotDetected, bases: 2026/04/13 06:13:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Info: LuaCore: 98 0.3.98 ca9d2f3beca9ca2a85e178af9d8e97d5fa2c38a3, {Tracking_phishing_log_reg_50_60}, {Tracking_uf_ne_domains}, {Tracking_bl_eng_cat}, {Tracking_arrow_http}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;git.kernel.org:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 202216 [Apr 13 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.22
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/04/13 06:49:00 #28394185
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected, bases: 2026/04/13 06:13:00
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-3287-lists,linux-erofs=lfdr.de];
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
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: B47833E8261
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



13.04.2026 10:08, Gao Xiang пишет:
> 
> 
> On 2026/4/11 23:10, Arseniy Krasnov wrote:
>>
>>
>> 10.04.2026 18:41, Gao Xiang пишет:
>>> Hi Arseniy,
>>>
>>> On 2026/4/10 21:27, Arseniy Krasnov wrote:
>>>>
>>>>
>>>> 10.04.2026 15:20, Gao Xiang пишет:
>>>>>
>>>>>
>>>>> On 2026/4/10 19:37, Arseniy Krasnov wrote:
>>>>>
>>>>> (drop unrelated folks since they all subscribed erofs mailing list)
>>>>>
>>>>>>
>>>>>>
>>>>>> 10.04.2026 11:31, Gao Xiang wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On 2026/4/10 16:13, Arseniy Krasnov wrote:
> 
> ...
> 
>>>>>>>
>>>>>>> I need more informations to find some clues.
>>>>>>
>>>>>>
>>>>>>
>>>>>> So reproduced again with this debug patch which adds magic to 'struct z_erofs_pcluster' and prints 'struct folio'
>>>>>> when pointer in 'private' is passed to 'erofs_onlinefolio_end()'. In short - 'private' points to 'struct z_erofs_pcluster'.
>>>>> First, erofs-utils 1.8.10 doesn't support `-E48bit`:
>>>>> only erofs-utils 1.9+ ship it as an experimental
>>>>> feature, see Changelog; so I think you're using
>>>>> modified erofs-utils 1.8.10:
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/tree/ChangeLog
>>>>>
>>>>> ```
>>>>> erofs-utils 1.9
>>>>>
>>>>>    * This release includes the following updates:
>>>>>      - Add 48-bit layout support for larger filesystems (EXPERIMENTAL);
>>>>> ```
>>>>>
>>>>> Second, I'm pretty sure this issue is related to
>>>>> experimenal `-E48bit`, and those information is
>>>>> not enough for me to find the root cause, so I
>>>>> need to find a way to reproduce myself: It may
>>>>> take time; you could debug yourself but I don't
>>>>> think it's an easy task if you don't quite familiar
>>>>> with the EROFS codebase.
>>>>>
>>>>> Anyway I really suggest if you need a rush solution
>>>>> for production, don't use `-E48bit + zstd` like
>>>>> this for now: try to use other options like
>>>>> `-zzstd -C65536 -Efragments` instead since those
>>>>> are common production choices.
>>>>
>>>> Ok thanks for this advice! One more question: currently we use this options:
>>>> "zstd,22 --max-extent-bytes 65536 -E48bit". Ok we remove "zstd,22" and "E48bit",
>>>> but what about "--max-extent-bytes 65536" - is it considered stable option?
>>>> Or it is better to use your version: "-zzstd -C65536 -Efragments" ?
>>>
>>> I'm not sure how you find this
>>> "zstd,22 --max-extent-bytes 65536 -E48bit" combination.
>>>
>>> My suggestion based on production is that as long as
>>> you don't use `-zzstd` ++ `-E48bit`, it should be fine.
>>>
>>> If you need smaller images, I suggest: `-zlzma,9 -C65536 -Efragments`
>>> Or like Android, they all use `-zlz4hc`,
>>> Or zstd, but don't add `-E48bit`.
>>>
>>> As for "--max-extent-bytes 65536", it can be dropped
>>> since if `-E48bit` is not used, it only has negative
>>> impacts.
>>>
>>> In short, `-E48bit` + `-zzstd` + `--max-extent-bytes`
>>> enables new unaligned compression for zstd, but it's
>>> a relatively new feature, I still still some time to
>>> stablize it but my own time is limited and all things
>>> are always prioritized.
>>
>> Ok, thanks for this advice!
> 
> FYI, I can reproduce this issue locally with `-E48bit`
> on in 600s.
> 
> I do think it's a `-E48bit` + zstd issue so
> non-`-E48bit` won't be impacted and I will find time
> to troubleshoot it this week.

Yes, without '-E48bit' we also can't reproduce it for entire weekend on several boards. No such panics.

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
>>>
>>>>
>>>> Thanks
>>>>
>>>>>
>>>>> Thanks,
>>>>> Gao Xiang
>>>
> 


