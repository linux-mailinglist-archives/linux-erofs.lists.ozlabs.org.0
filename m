Return-Path: <linux-erofs+bounces-3278-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOOxEqz82GmRkggAu9opvQ
	(envelope-from <linux-erofs+bounces-3278-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Apr 2026 15:35:40 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E5F3D829A
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Apr 2026 15:35:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsd9502Tbz2yZ6;
	Fri, 10 Apr 2026 23:35:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.181.183.35
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775828136;
	cv=none; b=feXvghSblaHTXPHdyuffyHn2z2YXyrsj6I2bvyy4v+vdn2YLJ3fv7DOGm+g9PKj+gRKKOjufHUZSVb3PidNEV18DqKSB1fv26ghUOA3DTYOK1rc929AR8jPMRZ+UCHwNNsG7h/jFmlHN09RlG/0zDZphI8iWFQZBhxO1YAq+XRWZvcJ8nuBZ+9W/ufpY4lL88nzotnvMTxyituJUKyMwQPZk3LW3HS2z7oTpoYGTbOzlRDo6mo+zQ6N7QGSFjs0av/OxMV+UJavaMJwFE72yrGoqZ9mcA3IEQEho6F/xO0CEcnfo8HNBAn/1aOgQ3iU6TgHxEKZX6PE3ePCZJF9VXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775828136; c=relaxed/relaxed;
	bh=SZ7jwynapIAt9mBp0rBEOzX7lSbubkQWfBGTq3VGWfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lhk2B19ksQmhKiJGiOidqND1Xrcfc6am+h/iFbL2ANOSVtRNRjS/xAGX4tdwJOAOR2XioeXnCnkzhLS3bxgKQyZdGtvFum09nz/RITnumlK5aHEVy/5yieHuOtImhYXQWdeyiXlYyBZl3LKI5Y1EZPUrsB/oSRvBXzjIgFr0VQRvaFGwlkq5H8kS2rTqzIMlwCoJvPYPxbQqXhI+X/rZ7242fUKFI7R+k8lGXwtpIqNd46Xh1OPaFjAqy3p1qKHtPe3rFGuXNcLcjap7qZhjLaLVo9ew6p4p1PVApdpG/KcSvThUDbZ4qATebMa5HkGKNK33Hjrkq09sisiCMxhZAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.a=rsa-sha256 header.s=post header.b=bbi56FIB; dkim-atps=neutral; spf=pass (client-ip=95.181.183.35; helo=mx5.sberdevices.ru; envelope-from=avkrasnov@salutedevices.com; receiver=lists.ozlabs.org) smtp.mailfrom=salutedevices.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.a=rsa-sha256 header.s=post header.b=bbi56FIB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=salutedevices.com (client-ip=95.181.183.35; helo=mx5.sberdevices.ru; envelope-from=avkrasnov@salutedevices.com; receiver=lists.ozlabs.org)
Received: from mx5.sberdevices.ru (mx5.sberdevices.ru [95.181.183.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsd940Qs5z2ySc
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Apr 2026 23:35:35 +1000 (AEST)
Received: from p-antispam-ksmg-gc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx5.sberdevices.ru (Postfix) with ESMTP id 924C2240004;
	Fri, 10 Apr 2026 16:35:33 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx5.sberdevices.ru 924C2240004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=post; t=1775828133;
	bh=SZ7jwynapIAt9mBp0rBEOzX7lSbubkQWfBGTq3VGWfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=bbi56FIBwfyoEXkyP2auk0FiGR0BmUzVkcXXTZycpthyP4937NpYC8n9JLT7J34G/
	 wfWoozf9TYlrVXUDk///WoV8Q9OrrBEtvjITfBuzGwtx00Gb+K22I5eSi7yWn1tEpJ
	 dwrEvuPk7TNY+tGo1KFYLOuJVHNJphRZeVeL+xcxTkCBwpKN6EY7oYCd2hhTWqbMo1
	 lWVs7c2ntq7yEgZ5U/u/KCynJScZOVQwbYvlVmxfS5xqTziK1p1h9Xl9KYuS2hffsM
	 xLGSrvX2+LgdJfQQsJ1UIVM3sKQ7FbgCpHBJMayN9nYFv2mJiMqIEh2p94ghvtIB2H
	 fovCJRaRkHiAQ==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "sberdevices.ru", Issuer "R12" (not verified))
	by mx5.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 10 Apr 2026 16:35:33 +0300 (MSK)
Message-ID: <66510e89-ff50-43ab-b8dc-289372b004f0@salutedevices.com>
Date: Fri, 10 Apr 2026 16:35:31 +0300
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
Content-Language: ru
To: Gao Xiang <hsiangkao@linux.alibaba.com>
CC: <oxffffaa@gmail.com>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <kernel@salutedevices.com>, Gao Xiang
	<xiang@kernel.org>
References: <4a2f3801-fac1-42fe-ae75-da315822e088@salutedevices.com>
 <f1ed0cff-57ff-4fb3-b102-0a0a6d79f1a9@linux.alibaba.com>
 <2e916997-0557-45e7-831a-b436c07c5ba4@salutedevices.com>
 <c2d7d5ff-237d-48b5-82a2-ac4618f055cc@linux.alibaba.com>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <c2d7d5ff-237d-48b5-82a2-ac4618f055cc@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.28.3.98]
X-ClientProxiedBy: p-exch-cas-a-m1.sberdevices.ru (172.24.201.216) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-AntiPhishing: NotDetected, bases: 2026/04/10 12:52:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Info: LuaCore: 98 0.3.98 ca9d2f3beca9ca2a85e178af9d8e97d5fa2c38a3, {Tracking_uf_ne_domains}, {Tracking_bl_eng_cat}, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;git.kernel.org:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 202189 [Apr 10 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.22
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/04/09 21:06:00 #28382314
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected, bases: 2026/04/10 12:52:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[salutedevices.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[salutedevices.com:s=post];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3278-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:oxffffaa@gmail.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:kernel@salutedevices.com,m:xiang@kernel.org,s:lists@lfdr.de];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.ozlabs.org,vger.kernel.org,salutedevices.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[avkrasnov@salutedevices.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
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
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 70E5F3D829A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



10.04.2026 15:20, Gao Xiang пишет:
> 
> 
> On 2026/4/10 19:37, Arseniy Krasnov wrote:
> 
> (drop unrelated folks since they all subscribed erofs mailing list)
> 
>>
>>
>> 10.04.2026 11:31, Gao Xiang wrote:
>>> Hi,
>>>
>>> On 2026/4/10 16:13, Arseniy Krasnov wrote:
>>>> Hi,
>>>>
>>>> We found unexpected behaviour of erofs:
>>>>
>>>> There is function in erofs - 'erofs_onlinefolio_end()'. It has pointer to
>>>> 'struct folio' as first argument, and there is loop inside this function,
>>>> which updates 'private' field of provided folio:
>>>>
>>>>     do {
>>>>             orig = atomic_read((atomic_t *)&folio->private);
>>>>             DBG_BUGON(orig <= 0);
>>>>             v = dirty << EROFS_ONLINEFOLIO_DIRTY;
>>>>             v |= (orig - 1) | (!!err << EROFS_ONLINEFOLIO_EIO);
>>>>     } while (atomic_cmpxchg((atomic_t *)&folio->private, orig, v) != orig);
>>>>
>>>> Now, we see that in some rare case, this function processes folio, where
>>>> 'private' is pointer, and thus this loop will update some bits in this
>>>> pointer. Then later kernel dereferences such pointer and crashes.
>>>>
>>>> To catch this, the following small debug patch was used (e.g. we check that 'private' field is pointer):
>>>>
>>>> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
>>>> index 33cb0a7330d2..b1d8deffec4d 100644
>>>> --- a/fs/erofs/data.c
>>>> +++ b/fs/erofs/data.c
>>>> @@ -238,6 +238,11 @@ void erofs_onlinefolio_end(struct folio *folio, int err, bool dirty)
>>>>    {
>>>>        int orig, v;
>>>>    +    if (((uintptr_t)folio->private) & 0xffff000000000000) {
>>>
>>> No, if erofs_onlinefolio_end() is called, `folio->private`
>>> shouldn't be a pointer, it's just a counter inside, and
>>> storing a pointer is unexpected.
>>>
>>> And since the folio is locked, it shouldn't call into
>>> try_to_free_buffers().
>>>
>>> Is it easy to reproduce? if yes, can you print other
>>> values like `folio->mapping` and `folio->index` as
>>> well?
>>>
>>> I need more informations to find some clues.
>>
>>
>>
>> So reproduced again with this debug patch which adds magic to 'struct z_erofs_pcluster' and prints 'struct folio'
>> when pointer in 'private' is passed to 'erofs_onlinefolio_end()'. In short - 'private' points to 'struct z_erofs_pcluster'.
> First, erofs-utils 1.8.10 doesn't support `-E48bit`:
> only erofs-utils 1.9+ ship it as an experimental
> feature, see Changelog; so I think you're using
> modified erofs-utils 1.8.10:
> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/tree/ChangeLog
> 
> ```
> erofs-utils 1.9
> 
>  * This release includes the following updates:
>    - Add 48-bit layout support for larger filesystems (EXPERIMENTAL);
> ```
> 
> Second, I'm pretty sure this issue is related to
> experimenal `-E48bit`, and those information is
> not enough for me to find the root cause, so I
> need to find a way to reproduce myself: It may
> take time; you could debug yourself but I don't
> think it's an easy task if you don't quite familiar
> with the EROFS codebase.

Also some more information just catched with CONFIG_EROFS_FS_DEBUG. Same problem, but enabled
debug logic BUGed kernel earlier. May be useful for You.

Thanks


[  368.587000][  T608] ------------[ cut here ]------------
[  368.587079][  T608] kernel BUG at fs/erofs/zdata.c:1606!
[  368.591977][  T608] Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
[  368.593622][ T1214] ------------[ cut here ]------------
[  368.598779][  T608] Modules linked in: vlsicomm(O)
[  368.604040][ T1214] kernel BUG at fs/erofs/zdata.c:1606!
[  368.608787][  T608] CPU: 1 UID: 0 PID: 608 Comm: kworker/1:3H Tainted: G           O        6.15.11-sdkernel #1 PREEMPT
[  368.624876][  T608] Tainted: [O]=OOT_MODULE
[  368.635015][  T608] Workqueue: kverityd verity_work
[  368.639844][  T608] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  368.647428][  T608] pc : z_erofs_endio+0x220/0x270
[  368.652172][  T608] lr : z_erofs_endio+0x23c/0x270
[  368.656920][  T608] sp : ffff80008215bbe0
[  368.660887][  T608] x29: ffff80008215bbe0 x28: ffff0000032feb40 x27: ffff0000032feb80
[  368.668646][  T608] x26: fffffdffc0029280 x25: 0000000000000009 x24: ffff000000be17e0
[  368.676408][  T608] x23: ffff000007e85c00 x22: 0000000000001000 x21: 0000000000001000
[  368.684170][  T608] x20: 0000000000000000 x19: 0000000000001000 x18: 00000000e6fb12fd
[  368.691933][  T608] x17: 00000000c98c11f0 x16: 00000000ac7e39e2 x15: 00000000c3362985
[  368.699696][  T608] x14: 0000000001040820 x13: 00000000a3bddb58 x12: ffff80008215bb68
[  368.707458][  T608] x11: 0000000049a63821 x10: ffff8000809febe0 x9 : 0000000000000000
[  368.715221][  T608] x8 : ffff000003cee8e8 x7 : 0000000000000000 x6 : 459ea227f0118cc9
[  368.722983][  T608] x5 : 0000000000000000 x4 : 1ff0000000004021 x3 : 0000000000000000
[  368.730746][  T608] x2 : 0000000000000000 x1 : ffff0000029f3e00 x0 : fffffdffc0029240
[  368.738513][  T608] Call trace:
[  368.741619][  T608]  z_erofs_endio+0x220/0x270 (P)
[  368.746362][  T608]  bio_endio+0x138/0x150
[  368.750411][  T608]  __dm_io_complete+0x1e0/0x2b0
[  368.755068][  T608]  clone_endio+0xd0/0x270
[  368.759213][  T608]  bio_endio+0x138/0x150
[  368.763262][  T608]  verity_finish_io+0x64/0xf0
[  368.767747][  T608]  verity_work+0x30/0x40
[  368.771800][  T608]  process_one_work+0x180/0x2e0
[  368.776463][  T608]  worker_thread+0x2c4/0x3f0
[  368.780862][  T608]  kthread+0x12c/0x210
[  368.784742][  T608]  ret_from_fork+0x10/0x20
[  368.788979][  T608] Code: 17ffffc8 f9401401 b100103f 54fff5a0 (d4210000)
[  368.795698][  T608] ---[ end trace 0000000000000000 ]---
[  368.813672][  T608] Kernel panic - not syncing: Oops - BUG: Fatal exception
[  368.815015][  T608] SMP: stopping secondary CPUs
[  369.896670][  T608] SMP: failed to stop secondary CPUs 0
[  369.896729][  T608] Kernel Offset: disabled
[  369.900508][  T608] CPU features: 0x0000,00000000,01000000,0200420b
[  369.906718][  T608] Memory Limit: none
[  369.922397][  T608] Rebooting in 5 seconds..



> 
> Anyway I really suggest if you need a rush solution
> for production, don't use `-E48bit + zstd` like
> this for now: try to use other options like
> `-zzstd -C65536 -Efragments` instead since those
> are common production choices.
> 
> Thanks,
> Gao Xiang


