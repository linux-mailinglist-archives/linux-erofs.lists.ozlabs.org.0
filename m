Return-Path: <linux-erofs+bounces-3247-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNrIKa2712l0SAgAu9opvQ
	(envelope-from <linux-erofs+bounces-3247-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Apr 2026 16:46:05 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A5A3CC2AA
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Apr 2026 16:46:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fs2mn4TJ4z2yfS;
	Fri, 10 Apr 2026 00:46:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775745961;
	cv=none; b=OecE40Zxfb2QICT3kLjYh2v9zi0Pm4gfvfwu3yMukKq1Z/Nmdihn/xYxYqZHBRntg9VkmPvbz0puX+n/jt8HlW/blpwIfsl5HQFgB+iK5AmahlqRgDn3h2iK6NLDr0aqwybcQ+/Hwa1vz8VEJAXwgifaS8NORuao4YGL12ll3Um93o0jupPJkPpLASewOZYgDxsAkXPB5r0HDJuxJCWcIwhs/BvUV1qBNT8xzxZsV9lIN9IMC+Nn4CLuTWmsie4pBO3tL5So/sO1BKoVdCFLsVfaj404z+uXvvH9cP+Vmc+mhMyxW0Pl1b6OvNDUtVIuwLR8TyesAghQXqD6URznbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775745961; c=relaxed/relaxed;
	bh=1CxMrqRleKIy6Nt4HyYbC7H+SGU2EQDTFuCq1iGE0dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YXJ9rlfcDjkVLLhfPJvucx+AfqDEWEmrO5Rtxd4ox2EI0emf8cA9T3/pLc6kQNEqEk1QlGz6fEN/0jVeq86uwftKkaC1D9F5BtZKz2FxuaPZn5SJjVCqdlv0rnP7LxNeTcu11NfZ8PlpP1SqZRSLB+W4zoIya2Smi5qwHtLJl/hIjdYOAh2LNq0QWhel5j0Zgwr4CA4gexWgIzwmc8EpZ5pahAWJq3/UNS5jxFdKjnPG/3xNnSpSDCs0lxXUU0eP2N85e6UEjDtSpBGG4fM1hn3uOjBTs02CvF4nEtoEOzIhr+hRDDCLhyb6ECaPiq5/k1KogrSg8Gpq19Efoi7WxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QW6SCE3P; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QW6SCE3P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fs2ml1wMkz2yS9
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Apr 2026 00:45:56 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775745951; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=1CxMrqRleKIy6Nt4HyYbC7H+SGU2EQDTFuCq1iGE0dg=;
	b=QW6SCE3PsThaXwjtsM+USrPryYhL2wcmbt3AUHCXkNkNLE1sELYwdNeOrqwNcQpYD/EtGsFT9AAsXQ/zP67CG5Rx0MGY3eyWA06FltN+6Zx6U//QEg6ATjRVGUSTs6R3ianQbpBaKjkbcUb4aktL6GHrRAzk9o4h+HMqTcg04Ss=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X0iZeRf_1775745949;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X0iZeRf_1775745949 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 09 Apr 2026 22:45:50 +0800
Message-ID: <6e6c5928-6ec3-4735-85ce-64460004eafa@linux.alibaba.com>
Date: Thu, 9 Apr 2026 22:45:49 +0800
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
Subject: Re: [PATCH] erofs-utils: fix erofs_sys_lsetxattr() returning positive
 errno
To: Lucas Karpinski <lkarpinski@nvidia.com>,
 Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: linux-erofs@lists.ozlabs.org, Zhan Xusheng <zhanxusheng@xiaomi.com>
References: <20260407092141.11697-1-zhanxusheng@xiaomi.com>
 <8cf20051-dfa5-4ed3-a52d-6556734830c0@nvidia.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <8cf20051-dfa5-4ed3-a52d-6556734830c0@nvidia.com>
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
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3247-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lkarpinski@nvidia.com,m:zhanxusheng1024@gmail.com,m:linux-erofs@lists.ozlabs.org,m:zhanxusheng@xiaomi.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nvidia.com,gmail.com];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCPT_COUNT_THREE(0.00)[4];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-erofs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 46A5A3CC2AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Lucus,

On 2026/4/9 22:35, Lucas Karpinski wrote:
> On 2026-04-07 5:21 a.m., Zhan Xusheng wrote:
>> erofs_sys_lsetxattr() returns bare `errno` (a positive value) on
>> failure, unlike its sibling erofs_sys_lgetxattr() which correctly
>> returns `-errno`.
>>
>> Fix by returning -errno, consistent with erofs_sys_lgetxattr().
>>
>> Fixes: e0d85fc5a282 ("erofs-utils: lib: introduce erofs_sys_lsetxattr()")
>> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
>> ---
>>   lib/xattr.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/xattr.c b/lib/xattr.c
>> index 565070a..af1b9ca 100644
>> --- a/lib/xattr.c
>> +++ b/lib/xattr.c
>> @@ -123,7 +123,7 @@ ssize_t erofs_sys_lsetxattr(const char *path, const char *name,
>>   	errno = ENODATA;
>>   #endif
>>   	if (ret < 0)
>> -		return errno;
>> +		return -errno;
>>   	return ret;
>>   }
>>   
> For consistency with erofs_sys_lgetxattr():
> -		return errno;
> +		ret = -errno;

Thanks for the suggestion, but it has been applied
to -dev branch, so I have to leave it as-is (I tend
to avoid rebasing -dev).

Thanks,
Gao Xiang

> 
> Regards,
> Lucas


