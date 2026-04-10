Return-Path: <linux-erofs+bounces-3270-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sII0EfrK2GktiQgAu9opvQ
	(envelope-from <linux-erofs+bounces-3270-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Apr 2026 12:03:38 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7C83D55D6
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Apr 2026 12:03:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsXSP6bRyz2yZ6;
	Fri, 10 Apr 2026 20:03:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.181.183.35
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775815413;
	cv=none; b=BLayKKbCQR5xX54rTN9w3si5GCgFNmQl5w2EQKYiyU4FGJJ9Hz+0TGF3QpaxeynJaJh7ukXaLQSlRMrwWxYUR3nh4UqvbeFK5e+eKZdf2/ZCV+dB7/sQiMJ5+bGTrN0Dyrs1DZXA4J0uU2kKhZkSMablakTsFRyCgex0I9JhAaY4IhM0OyQ5IF3WW5OdS0YNNhbI79Vr1LRdCkzkG1hpYyV400AzATtgKBqYbpbCbDnVP9Tf5hlBQeUv7deRzi8+BuRHnBe9lwe8zFZvFCqkrdKZ7nHFewqLWLR7bAm088cJafDVEP4YqYiWN1IfdZL6WDOF5y9480iUe5lRXa0diQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775815413; c=relaxed/relaxed;
	bh=vFQ9ql+BNZ2pTamNVN3LEbcRKTb++kFpo/wdZBE225A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=buwTEeeQAxy05dzQsZcr7WTm1gfpeb9VtthhenuTW23JfIdB2mxyI+O+uSyhuuVtX3c1iaRM98wPPbkIWnYia3edKa0Ticth2tItU4SDDA0p4XVbKga2l3Dt3fN8ASjHanMalbFzyKiOF6y6O1fUdaTGHbwM2tyN/V1h5zSBPUyRTKBVBDBur9ST1KMSHeZppVDHVAD1Ke0Larw0NCWGq+rzx/fwCQSs6WKyeeoqsbODuArKSf7zyAcOjBIL3cka6hvuMmywKIGgh3RxHnI0L1Y+sh8P3qipbx9shIoxIJLAyYgeOCf+hCkEZfI6BtXBBvWKefRqeb0/vFqp7rk8Dg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.a=rsa-sha256 header.s=post header.b=nGlT0IgW; dkim-atps=neutral; spf=pass (client-ip=95.181.183.35; helo=mx5.sberdevices.ru; envelope-from=avkrasnov@salutedevices.com; receiver=lists.ozlabs.org) smtp.mailfrom=salutedevices.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.a=rsa-sha256 header.s=post header.b=nGlT0IgW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=salutedevices.com (client-ip=95.181.183.35; helo=mx5.sberdevices.ru; envelope-from=avkrasnov@salutedevices.com; receiver=lists.ozlabs.org)
Received: from mx5.sberdevices.ru (mx5.sberdevices.ru [95.181.183.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsXSN5tKQz2yYy
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Apr 2026 20:03:32 +1000 (AEST)
Received: from p-antispam-ksmg-gc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx5.sberdevices.ru (Postfix) with ESMTP id 79460240005;
	Fri, 10 Apr 2026 13:03:30 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx5.sberdevices.ru 79460240005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=post; t=1775815410;
	bh=vFQ9ql+BNZ2pTamNVN3LEbcRKTb++kFpo/wdZBE225A=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=nGlT0IgWTX4SCyEIaUKFWGRepA+IHxbiXK8THPcTgFdOmnodQM/NjxbYNfja8n1Vm
	 xTG2fqQiAW38Gx1EMNXAMIZmE5M8NQtl9p0iB26YfZWkCpBIRGoaFB3PLkB4Em+Hzo
	 hwU025XKr4UBlTvFNc0pjvK8EHMrRBDORSBWbsDQQ7e6P+37aN1ooTr7yqZFuPi9M1
	 SyD87gE4JwSm6VnXOBisA8A3BhdCEIIpJnnZSiqYxffE2e+90Z26bXSREsirm0L2G9
	 a9oF5Jq1/OT/nfz+fGw3gvA58ZKILoTvttto95o6KLETkSwVm0PR6T3kUx+Li3rLwz
	 PgXwfBW+p00Kg==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "sberdevices.ru", Issuer "R12" (not verified))
	by mx5.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 10 Apr 2026 13:03:30 +0300 (MSK)
Message-ID: <f68962d5-cce1-4993-a7d2-54c3fb752064@salutedevices.com>
Date: Fri, 10 Apr 2026 13:03:28 +0300
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
	<xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>, Sheng Yong <shengyong1@xiaomi.com>
References: <4a2f3801-fac1-42fe-ae75-da315822e088@salutedevices.com>
 <f1ed0cff-57ff-4fb3-b102-0a0a6d79f1a9@linux.alibaba.com>
 <9d8a073a-982e-4c7b-9445-623941a16b05@salutedevices.com>
 <16ea58e8-43b7-439b-91db-9f87d2fb2b84@linux.alibaba.com>
 <a28be132-1f08-4ce1-90f9-7732301c9aa3@salutedevices.com>
 <e8bc1c98-e76b-4f02-a834-c0d2ad88ed46@linux.alibaba.com>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <e8bc1c98-e76b-4f02-a834-c0d2ad88ed46@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.28.3.98]
X-ClientProxiedBy: p-exch-cas-a-m2.sberdevices.ru (172.24.201.210) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Info: LuaCore: 98 0.3.98 ca9d2f3beca9ca2a85e178af9d8e97d5fa2c38a3, {Tracking_arrow_text}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 202167 [Apr 10 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.22
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/04/09 21:06:00 #28382314
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-3270-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:oxffffaa@gmail.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:kernel@salutedevices.com,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:shengyong1@xiaomi.com,s:lists@lfdr.de];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	FORGED_SENDER(0.00)[avkrasnov@salutedevices.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[gmail.com,lists.ozlabs.org,vger.kernel.org,salutedevices.com,kernel.org,linux.alibaba.com,google.com,huawei.com,xiaomi.com];
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
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 5B7C83D55D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



10.04.2026 13:01, Gao Xiang пишет:
> 
> 
> On 2026/4/10 17:59, Arseniy Krasnov wrote:
>>
>>
>> 10.04.2026 12:20, Gao Xiang wrote:
>>>
>>>
>>> On 2026/4/10 16:55, Arseniy Krasnov wrote:
>>>>
>>>>
>>>
>>> ...
>>>
>>>>>>
>>>>>> BR2_TARGET_ROOTFS_EROFS=y
>>>>>> BR2_TARGET_ROOTFS_EROFS_CUSTOM_COMPRESSION=y
>>>>>> BR2_TARGET_ROOTFS_EROFS_COMPRESSION_ALGORITHMS="zstd,22 --max-extent-bytes 65536 -E48bit"
>>>
>>> btw, may I ask what's the erofs-utils version?
>>> erofs-utils 1.9?
>>
>> We have 1.8.5 erofs-utils
> 
> 1.8.5 shouldn't have `-E48bit` support, that is my question.

You mean to try to reproduce with 1.9 utils ?

> 
> Thanks,
> Gao Xiang


