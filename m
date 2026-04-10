Return-Path: <linux-erofs+bounces-3267-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AR4J//A2Gk4hwgAu9opvQ
	(envelope-from <linux-erofs+bounces-3267-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Apr 2026 11:21:03 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B85553D4A85
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Apr 2026 11:21:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsWWJ21c4z2yZ6;
	Fri, 10 Apr 2026 19:21:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775812860;
	cv=none; b=egr9iNchqvkxDIcZAp4xME8YSDPu+DS89oQABEfssfLlRD65tttVaqTHlAgAN/VBBkX82VLtnd9qfoFE668L+TRXQNiGF96vknd/58YpG8OrWOAOe7mAsPVNRVfx1I0Z3jx3NxPj60nVh1tluoJivUrMIFzkq6+beB1wvSFCTWJsQrTzH0o7+iwfZZTpctvoDz8E4TFDo+3hqQPe2GSSEkpbJlv1HIPobOsQiFwVZpA3zvrOxg8WeD9FqEY4+aX1/kgi8Fol2ni+Jwqee6LXsnEYm74tvfpRG9w5GMv8kFJGPrEkaM86Ss86Iam6ln+lXmiCRn4oA3Q3O5Q6oLoKiA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775812860; c=relaxed/relaxed;
	bh=wnWcYguAqwjF8FcXrJmbksHV5AKeP1VA/I33KJYK2h8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G7tqKR6nL5LSm+8Tl06SCVwJigDLtpkx4TS1ZMmbUEiauAsLIEuR36PsXr3jAvSaOU6/YUgt0nHYlYyhuD7cQ1zSG5E5mTyRA44ljFvqpr4bnKaFZJdGd+vxE5V009G+oWpCCxFOw6xPKvYXjhjXH1+7DAKGbSqI9YrHUcNL4Z7SsSAnk9PY4t4zogo9I2Wwt4wY7sOjGft9bHyusXhsxI1vchREY88INfQgNZ5VyF41tCjUUx8xKgkmrFDu3vQQKk7TA+dmdyDnJWCofAw1Bn+gR4o7a2CV1xvOq7zVvRhsFE6mkEscUgFuHav4PLCuGP8ZdhRZPvsb+nL7Fd/POQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OoHbOBmb; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OoHbOBmb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsWWF5DRFz2xT6
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Apr 2026 19:20:56 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775812852; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=wnWcYguAqwjF8FcXrJmbksHV5AKeP1VA/I33KJYK2h8=;
	b=OoHbOBmbGFqGbfL2Fxlw4LTy8zL2m7Cxr8m3sU35Ia11N1T3Lr41j9ZSGUcHGVtR03ttviZQWobY04lSiqYmcC3O+/4nQpvqgK+qGeV8ZkDreSiXBa1Bd7e9sSpCDkafErBh9xHoT973Z7PTV0mIf3mCY1WEbUHIIgaGTP2Qlzs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X0ksjaY_1775812850;
Received: from 30.221.132.105(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X0ksjaY_1775812850 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 10 Apr 2026 17:20:51 +0800
Message-ID: <16ea58e8-43b7-439b-91db-9f87d2fb2b84@linux.alibaba.com>
Date: Fri, 10 Apr 2026 17:20:50 +0800
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
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <9d8a073a-982e-4c7b-9445-623941a16b05@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
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
	TAGGED_FROM(0.00)[bounces-3267-lists,linux-erofs=lfdr.de];
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
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: B85553D4A85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/10 16:55, Arseniy Krasnov wrote:
> 
> 

...

>>>
>>> BR2_TARGET_ROOTFS_EROFS=y
>>> BR2_TARGET_ROOTFS_EROFS_CUSTOM_COMPRESSION=y
>>> BR2_TARGET_ROOTFS_EROFS_COMPRESSION_ALGORITHMS="zstd,22 --max-extent-bytes 65536 -E48bit"

btw, may I ask what's the erofs-utils version?
erofs-utils 1.9?

I guess it's related to a relatively new experimental
feature (-E48bit + encoded extents + zstd) introduced in v6.15.

If you don't use this new feature, the issue may not be
reproduced anymore.

Thanks,
Gao Xiang


>>> BR2_TARGET_ROOTFS_EROFS_FRAGMENTS=y
>>> BR2_TARGET_ROOTFS_EROFS_PCLUSTERSIZE=65536
>>>
>>>
>>>
>>> May be You know how to fix it or some ideas? Because we are new at erofs and need to discover and
>>> learn its source code.
>>>
>>> Thanks
>>


