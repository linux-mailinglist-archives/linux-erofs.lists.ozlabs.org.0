Return-Path: <linux-erofs+bounces-3271-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAEKBpnL2GktiQgAu9opvQ
	(envelope-from <linux-erofs+bounces-3271-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Apr 2026 12:06:17 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8E33D5673
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Apr 2026 12:06:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsXWT5Dgjz2yZ6;
	Fri, 10 Apr 2026 20:06:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775815573;
	cv=none; b=Iskwmlzq5SbEdI9L4ch1cD2/fqfJmHw9EUZlyPDqEodUzKrmK/owShQwiIASrZW48LyRf6ijc/rTsegSi91fE69JMvAe2Mp5HHv+fsF50RcA+yu74pXtKCdR2zWCX0NclKvZSaTglHFwvY7VdfA0DYiS2Y7lxVnfeVWBoPhHehmwQoHL4utNOKSzCqgcjZAJ2aQksJHTtlAhQ4a12MxJg86cnl3/q8Ju9H9dhVFiDxYg0s9EOt7JuqJ2C1/wMspsOqzCU1v+/ilR1qC5D3O2YRMD4jfkCQhCT3IK6WYKOOzJI7MtALi4tQB72NwD++4hmURLbwALGUBlvce8v2ccfg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775815573; c=relaxed/relaxed;
	bh=AeAHf9/ou6cD3bpJp5OYIP7QdLqeK8HJO0Wre2/s2bE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EIhihYbqJvaP8zykESEouCvS9S8ybSysUS91WE/uuJ4nvxZypc3SBot4GfrzCKP8+tfDjP+Fjd4KYJMAW/UoepMmdoaP8VLAKro+yQyDO7mMUNMGo7BSA89KTuyvj4+07zSITfr5z0nDGZaj/Igl5l/8F/d/bmxkk0w2fr2CBlNbEy6Q/qH2SgBYLdlHwyPMgzsYMRgLJzYc36RDWK/KbnAgjYb2wpMm/QnypRlmjjP4+6MiGuZoFrBODIwZ3nPWOlcax2tqrOgf4aOg9v4G06JqM91mDFZL84Od/F5nJdV4oVIe5Hmsxf/qsjdPC7cy6TpzjNJSQY9f8rBTuEl+6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=U89RjBb1; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=U89RjBb1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsXWS60cZz2yYy
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Apr 2026 20:06:11 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775815568; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=AeAHf9/ou6cD3bpJp5OYIP7QdLqeK8HJO0Wre2/s2bE=;
	b=U89RjBb1ahIkrBOLlXHmEuQb3hFWktxyaN0CcR641bdxDByTjdHK56r5o776BTjgjXR2HMa6QrmLfUnpCErhaf53Pb5sMOcXpBMBsgdPEUDlcflw7aRMbKenL5EhvsaZCazXx8mabZtDmo5PI378wGjugxtv4LixcjY6x94zqZw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X0kw22-_1775815565;
Received: from 30.221.132.105(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X0kw22-_1775815565 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 10 Apr 2026 18:06:06 +0800
Message-ID: <cad241fc-c2c6-4872-ab56-be3b7b44fbea@linux.alibaba.com>
Date: Fri, 10 Apr 2026 18:06:05 +0800
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
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>,
 Sheng Yong <shengyong1@xiaomi.com>
References: <4a2f3801-fac1-42fe-ae75-da315822e088@salutedevices.com>
 <f1ed0cff-57ff-4fb3-b102-0a0a6d79f1a9@linux.alibaba.com>
 <9d8a073a-982e-4c7b-9445-623941a16b05@salutedevices.com>
 <16ea58e8-43b7-439b-91db-9f87d2fb2b84@linux.alibaba.com>
 <a28be132-1f08-4ce1-90f9-7732301c9aa3@salutedevices.com>
 <e8bc1c98-e76b-4f02-a834-c0d2ad88ed46@linux.alibaba.com>
 <f68962d5-cce1-4993-a7d2-54c3fb752064@salutedevices.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <f68962d5-cce1-4993-a7d2-54c3fb752064@salutedevices.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3271-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:avkrasnov@salutedevices.com,m:oxffffaa@gmail.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:kernel@salutedevices.com,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:shengyong1@xiaomi.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[gmail.com,lists.ozlabs.org,vger.kernel.org,salutedevices.com,kernel.org,linux.alibaba.com,google.com,huawei.com,xiaomi.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
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
X-Rspamd-Queue-Id: 3A8E33D5673
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/10 18:03, Arseniy Krasnov wrote:
> 
> 
> 10.04.2026 13:01, Gao Xiang пишет:
>>
>>
>> On 2026/4/10 17:59, Arseniy Krasnov wrote:
>>>
>>>
>>> 10.04.2026 12:20, Gao Xiang wrote:
>>>>
>>>>
>>>> On 2026/4/10 16:55, Arseniy Krasnov wrote:
>>>>>
>>>>>
>>>>
>>>> ...
>>>>
>>>>>>>
>>>>>>> BR2_TARGET_ROOTFS_EROFS=y
>>>>>>> BR2_TARGET_ROOTFS_EROFS_CUSTOM_COMPRESSION=y
>>>>>>> BR2_TARGET_ROOTFS_EROFS_COMPRESSION_ALGORITHMS="zstd,22 --max-extent-bytes 65536 -E48bit"
>>>>
>>>> btw, may I ask what's the erofs-utils version?
>>>> erofs-utils 1.9?
>>>
>>> We have 1.8.5 erofs-utils
>>
>> 1.8.5 shouldn't have `-E48bit` support, that is my question.
> 
> You mean to try to reproduce with 1.9 utils ?

Nope, I meant

BR2_TARGET_ROOTFS_EROFS_COMPRESSION_ALGORITHMS="zstd,22 --max-extent-bytes 65536 -E48bit"

is invalid in erofs-utils 1.8.5.

If you were using erofs-utils 1.9+, that may be due to
the new `-E48bit`;

but you said you are using erofs-utils 1.8.5, that makes
me feel confused.

Thanks,
Gao Xiang

