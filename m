Return-Path: <linux-erofs+bounces-3268-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAWSIhfK2GktiQgAu9opvQ
	(envelope-from <linux-erofs+bounces-3268-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Apr 2026 11:59:51 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A35C53D5549
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Apr 2026 11:59:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsXN31B3bz2yZ6;
	Fri, 10 Apr 2026 19:59:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.181.183.35
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775815187;
	cv=none; b=cVSO55IM79lGgBur36AlBrf9r2tco1ysjR1ooXmm94Fuscj+WoBMBlXFD3h5v2pu7egSl0QNEcl36jSED6ppGye7KvJeVdv1889xxgBK61ZQ2+NuOog1iEI/h7yhI5Q36oCTnmshnuZKdRf+yHsFAVOv6+fS17xrHboDocZEq2hHB+S3VMggXFlf6Kzzp4DHIfjIaPvj1y4aXw+QHf+IEIkT1IS9eGKSp2tRqKl2hWpJvH1vhb4gIPRmCLbcW3ZyJ7sfACboEFm/xqzelzvuw3QWfmJIKnIWIYgdOkRyV763Ff9wU+HDWyDl6rn/of5As05W2qVACp3DdJJOSmuZpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775815187; c=relaxed/relaxed;
	bh=BtIe4IBWmj/P7r6crAbsh8CsZp4kJz/jWqbVA9Nmhtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kpleNMk2xpCqQweZThn0B3QZDcq2RUMjqi7NKHG/dbWC3iIEoShfzcnXUIKzJXlBbVlmXwfwgPjPR9FSGh8z6GQi6rs8HijpVFXBTO4k/zDCuCbBiuQRIkGHsFTxrbVOKGcJum7UGhETUDGjgCL/VYaFjF2PH9WT9+iLNfVlBjFcIAklN62TrrqDo8a/xNQYMXdUtuFremh/poggjbyFmEszis04kBv+IcWNdkY/LyGwtP7kgATH57buJxWfqLrWgHmt2O+gsLOwWhEtp5vq5E3D0KRFR0gJyevx33CQE9ophfjlFISeOCymj6dAi3/E0JnTX3PhPnt7X5q3USToiA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.a=rsa-sha256 header.s=post header.b=d5HbE3+h; dkim-atps=neutral; spf=pass (client-ip=95.181.183.35; helo=mx5.sberdevices.ru; envelope-from=avkrasnov@salutedevices.com; receiver=lists.ozlabs.org) smtp.mailfrom=salutedevices.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.a=rsa-sha256 header.s=post header.b=d5HbE3+h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=salutedevices.com (client-ip=95.181.183.35; helo=mx5.sberdevices.ru; envelope-from=avkrasnov@salutedevices.com; receiver=lists.ozlabs.org)
Received: from mx5.sberdevices.ru (mx5.sberdevices.ru [95.181.183.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsXN0195Cz2yYy
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Apr 2026 19:59:42 +1000 (AEST)
Received: from p-antispam-ksmg-gc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx5.sberdevices.ru (Postfix) with ESMTP id 172AB240005;
	Fri, 10 Apr 2026 12:59:38 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx5.sberdevices.ru 172AB240005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=post; t=1775815178;
	bh=BtIe4IBWmj/P7r6crAbsh8CsZp4kJz/jWqbVA9Nmhtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=d5HbE3+hgFLg7giJPVrevRLO0lnj+7cvwHQlFY96vQVsqdJBCKEsQONwtJ0PUh1xR
	 7e8dgCfp2qE5O2247sf+5LAf4F1VT4hTl9CLSV/eqycTCzcKhZRt4N0wwzy1U3ZS/B
	 aA8mGnTk27iWTcmn0peiE6OSxn2tK2qNNHrM0VnyqKC3Y7mu7TPhkb6EX+i4rt+4Ou
	 gblPIwC56J1ZvZjG0kAGJp7pyil2Qnx3I3ZgRNNgP9gz/W21cau0GXO/+MeO/MlV+b
	 n6UAdPjYenLua8teYC4m3KP9YRZdA2pTBGwYkV3zbpNg89i3EJxqK5N4sSF8eex9gE
	 V+Mfr9oT3iOCA==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "sberdevices.ru", Issuer "R12" (not verified))
	by mx5.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 10 Apr 2026 12:59:37 +0300 (MSK)
Message-ID: <a28be132-1f08-4ce1-90f9-7732301c9aa3@salutedevices.com>
Date: Fri, 10 Apr 2026 12:59:36 +0300
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
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <16ea58e8-43b7-439b-91db-9f87d2fb2b84@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.28.3.98]
X-ClientProxiedBy: p-exch-cas-a-m2.sberdevices.ru (172.24.201.210) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Info: LuaCore: 98 0.3.98 ca9d2f3beca9ca2a85e178af9d8e97d5fa2c38a3, {Tracking_arrow_text}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[salutedevices.com:s=post];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3268-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.ozlabs.org,vger.kernel.org,salutedevices.com,kernel.org,linux.alibaba.com,google.com,huawei.com,xiaomi.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:oxffffaa@gmail.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:kernel@salutedevices.com,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:shengyong1@xiaomi.com,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[avkrasnov@salutedevices.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A35C53D5549
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



10.04.2026 12:20, Gao Xiang wrote:
> 
> 
> On 2026/4/10 16:55, Arseniy Krasnov wrote:
>>
>>
> 
> ...
> 
>>>>
>>>> BR2_TARGET_ROOTFS_EROFS=y
>>>> BR2_TARGET_ROOTFS_EROFS_CUSTOM_COMPRESSION=y
>>>> BR2_TARGET_ROOTFS_EROFS_COMPRESSION_ALGORITHMS="zstd,22 --max-extent-bytes 65536 -E48bit"
> 
> btw, may I ask what's the erofs-utils version?
> erofs-utils 1.9?

We have 1.8.5 erofs-utils

> 
> I guess it's related to a relatively new experimental
> feature (-E48bit + encoded extents + zstd) introduced in v6.15.
> 
> If you don't use this new feature, the issue may not be
> reproduced anymore.
> 
> Thanks,
> Gao Xiang
> 
> 
>>>> BR2_TARGET_ROOTFS_EROFS_FRAGMENTS=y
>>>> BR2_TARGET_ROOTFS_EROFS_PCLUSTERSIZE=65536
>>>>
>>>>
>>>>
>>>> May be You know how to fix it or some ideas? Because we are new at erofs and need to discover and
>>>> learn its source code.
>>>>
>>>> Thanks
>>>
> 


