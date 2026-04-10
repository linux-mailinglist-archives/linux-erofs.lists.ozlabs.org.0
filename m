Return-Path: <linux-erofs+bounces-3273-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IPIM3zP2GngiQgAu9opvQ
	(envelope-from <linux-erofs+bounces-3273-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Apr 2026 12:22:52 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E843D59B4
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Apr 2026 12:22:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsXtd66ZMz2yZ6;
	Fri, 10 Apr 2026 20:22:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775816569;
	cv=none; b=hAMnSjSkl3KtWj5uH9GztJjkLNJ9CLnG7483XhYqviau5deqnIXsgV3kyn6zPFoDxpsyqZLQZ0YbCRYml56NZAYys2l1pwij8kJqP+ZdFJc0MpHyRzwx463DJF2IbNIPdFf8cqjVf0xQJg0y7nVH2ybl3hCAjbdaXjD1NM0kzvwZqV9xCNvvQ54DnL2gzLFSdhrM3eXwX+XS5WPUzBx6DQSDNoU//P65M2LOrMixCbuRMVEMWYHZJz7LMal2GizOU0wQg/c63nrsxVED/gu4g6radodqcdDBic098UV8Dx8StW+j553W3ao642Ym8qjykQw59c0uvSP7jSw8x8j/Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775816569; c=relaxed/relaxed;
	bh=NtWRXic568bsJt4xBzk+XesFrsjsjfwhm/XAwDSBZig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KQfagAGHOSSYV7KREMzG95ULQi8L72F8YarwHc8tGCEuQ7Gu9VZpBGQF7l/jhtsfyP0S5VO5HU89jeoq28J4IjbJ8gSyH4RAlvhhl40MoswWWQYH5yB5wSFPF0DDjFzvq/LztDziSW2tkK5PXTJfShaSkizS7bXsGAP/1CetEc8hbLpQibEV4/UtoBX+Zq5UTbYBOzMex9sJZuQMeLROfW+L4E947cHzS4wGe+l2dxWnyNxByQ+vSU5FF4ZtA3znXFsRsMdC4U3q67FQfHi92gIkzW+ZkH1tptTP51WJYME+dCJUoHtzWCUSq03JnbhptV3qXyETY9Bdttdg6sedRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OdK1T63J; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OdK1T63J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsXtb3gKgz2xLt
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Apr 2026 20:22:46 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775816562; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=NtWRXic568bsJt4xBzk+XesFrsjsjfwhm/XAwDSBZig=;
	b=OdK1T63J4FhhELMU8XWEmUrQW27Lt5UtvMFiCUQgBdslDvjjMrNu8anM2OcYNIEhbUcGNkgXGd0LgzPmxB2auzxay9lRRuzj9Ul7X+vwVtee5uzGQv4h19kN6vzUF2xik9z2v3Bx/RFuv4nhK4ROq31rCoK4XllfgggBeKCpUeQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X0kyHeF_1775816560;
Received: from 30.221.66.188(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X0kyHeF_1775816560 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 10 Apr 2026 18:22:41 +0800
Message-ID: <198c23d4-6b8b-4d13-a090-9b01c5d97698@linux.alibaba.com>
Date: Fri, 10 Apr 2026 18:22:40 +0800
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
 linux-kernel@vger.kernel.org, kernel@salutedevices.com
References: <4a2f3801-fac1-42fe-ae75-da315822e088@salutedevices.com>
 <f1ed0cff-57ff-4fb3-b102-0a0a6d79f1a9@linux.alibaba.com>
 <9d8a073a-982e-4c7b-9445-623941a16b05@salutedevices.com>
 <16ea58e8-43b7-439b-91db-9f87d2fb2b84@linux.alibaba.com>
 <a28be132-1f08-4ce1-90f9-7732301c9aa3@salutedevices.com>
 <e8bc1c98-e76b-4f02-a834-c0d2ad88ed46@linux.alibaba.com>
 <f68962d5-cce1-4993-a7d2-54c3fb752064@salutedevices.com>
 <cad241fc-c2c6-4872-ab56-be3b7b44fbea@linux.alibaba.com>
 <5301be8f-4b2e-4f1d-a90b-91da00f98994@salutedevices.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <5301be8f-4b2e-4f1d-a90b-91da00f98994@salutedevices.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3273-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:avkrasnov@salutedevices.com,m:oxffffaa@gmail.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:kernel@salutedevices.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[gmail.com,lists.ozlabs.org,vger.kernel.org,salutedevices.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 01E843D59B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/10 18:10, Arseniy Krasnov wrote:
> 
> 
> 10.04.2026 13:06, Gao Xiang пишет:
>>
>>
>> On 2026/4/10 18:03, Arseniy Krasnov wrote:
>>>
>>>
>>> 10.04.2026 13:01, Gao Xiang пишет:
>>>>
>>>>
>>>> On 2026/4/10 17:59, Arseniy Krasnov wrote:
>>>>>
>>>>>
>>>>> 10.04.2026 12:20, Gao Xiang wrote:
>>>>>>
>>>>>>
>>>>>> On 2026/4/10 16:55, Arseniy Krasnov wrote:
>>>>>>>
>>>>>>>
>>>>>>
>>>>>> ...
>>>>>>
>>>>>>>>>
>>>>>>>>> BR2_TARGET_ROOTFS_EROFS=y
>>>>>>>>> BR2_TARGET_ROOTFS_EROFS_CUSTOM_COMPRESSION=y
>>>>>>>>> BR2_TARGET_ROOTFS_EROFS_COMPRESSION_ALGORITHMS="zstd,22 --max-extent-bytes 65536 -E48bit"
>>>>>>
>>>>>> btw, may I ask what's the erofs-utils version?
>>>>>> erofs-utils 1.9?
>>>>>
>>>>> We have 1.8.5 erofs-utils
>>>>
>>>> 1.8.5 shouldn't have `-E48bit` support, that is my question.
>>>
>>> You mean to try to reproduce with 1.9 utils ?
>>
>> Nope, I meant
>>
>> BR2_TARGET_ROOTFS_EROFS_COMPRESSION_ALGORITHMS="zstd,22 --max-extent-bytes 65536 -E48bit"
>>
>> is invalid in erofs-utils 1.8.5.
>>
>> If you were using erofs-utils 1.9+, that may be due to
>> the new `-E48bit`;
>>
>> but you said you are using erofs-utils 1.8.5, that makes
>> me feel confused.
>>
> 
> Ah, ok, so need to debug it at kernel side as we talked before.

Sigh, you don't answer my questions:

1. so are you using `-E48bit` and newer erofs-utils verison?

2. Is "EXPERIMENTAL 48-bit layout support in use. Use at your
    own risk!" shown when mounting?

Thanks,
Gao Xiang

