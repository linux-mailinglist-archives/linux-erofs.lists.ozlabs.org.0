Return-Path: <linux-erofs+bounces-3705-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BQx/MA+2OGpYggcAu9opvQ
	(envelope-from <linux-erofs+bounces-3705-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 06:11:59 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E54136AC7A1
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 06:11:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=JiazSPei;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3705-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3705-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkFC06PHCz2yVP;
	Mon, 22 Jun 2026 14:11:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782101516;
	cv=none; b=cBakKl2VmoGFGih/b7CmD0T3eR/4IZC2SEXdinnx5LAYa89elZ9iXOr3syuWZbLT6UyS2ahlWJVQ+hnLg6SeWJfYqhki+D1XFT+JjnzQZCQ0huWJqqnWConQuyvbHh9Mf8Jcl9i4/kW1CjwTTk9TVnM+gmhFV0zMQmGb++3rEgINZ96H08r69Pwr1USoMHKU+EgauNCvZUMbRnBVZrlq3keThtC0romDRN9YJVGkPn3xl1dRSNhoxg3LfuCp7I+wt6zvooBiXdBP0MLmEnF3pZwd52CuXpv8/g6op0Umi+HdlMNPiNiHZa/N87FjRehzGM7aLX3tc2qCWDDaGoTlcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782101516; c=relaxed/relaxed;
	bh=wjyy/0VnwcXowjY8u22tURU3A/I1PaVcNFYZtMPFeXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QaxNyOB6O3x2akIYrd7MLPs8hQ1Fegp15j8Yw2JgyHn2ADZH+ZEA66ZXdFgnmuok+XzAzwz9xHgRdUn9TJ/LN1YHQFFgphJwJVfpAA3xX/6YU9kLMQG22xzv5Xqdh+DLvs0oM96YWzPAm5TK4L9OhL86XonOntuwIxtmJi+kT0wNrD+Hyz+GoyVKS5DkvqrgneR8b8tNmA4znFrY+SUMxEf2FG/vGWhBV3F8gezYIEfcDbuZsEgSmkeMitk68at0JpaH6c760yVoWAffKa42SbI6kg6H/PSseMHWrES0w4lXaR83Y++172TZ9sfIgsJfdbfeY/6fnsLkFCNdJV7bKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=JiazSPei; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkFBy5JtJz2xwH
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jun 2026 14:11:53 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782101510; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=wjyy/0VnwcXowjY8u22tURU3A/I1PaVcNFYZtMPFeXM=;
	b=JiazSPeiLxi02bEfwh3QwXqDD3Kamiu28awk1tiwsv3oYwqziyV/R1Kt4seENEtnP50XhA6IRBVMvh7/G48c5pdR9z7AMnLOwX1cWstcAVppNs5kl3ugUC3RGVk1o+PFOWBbP6Q9Fc/RWXXbOthpFcMmpGB13TvRkykTv+kICkw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X5H72IP_1782101508;
Received: from 30.221.130.114(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X5H72IP_1782101508 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Jun 2026 12:11:48 +0800
Message-ID: <700b7898-36b4-45ef-add6-604e74cc00f3@linux.alibaba.com>
Date: Mon, 22 Jun 2026 12:11:47 +0800
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
Subject: Re: [RESEND PATCH 1/2] erofs-utils: lib: don't abort on compression
 fallback
To: "zhaoyifan (H)" <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: zhukeqian1@huawei.com
References: <20260622034248.1047783-1-zhaoyifan28@huawei.com>
 <4433eb42-4ca9-46ae-98e5-7bd388cad0a0@linux.alibaba.com>
 <b021c538-3100-4cf2-b69e-cbac93b94056@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <b021c538-3100-4cf2-b69e-cbac93b94056@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3705-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:zhaoyifan28@huawei.com,m:linux-erofs@lists.ozlabs.org,m:zhukeqian1@huawei.com,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCPT_COUNT_THREE(0.00)[3];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp,linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E54136AC7A1



On 2026/6/22 12:10, zhaoyifan (H) wrote:
> 
> On 2026/6/22 11:51, Gao Xiang wrote:
>> Hi Yifan,
>>
>> On 2026/6/22 11:42, Yifan Zhao wrote:
>>> -ENOSPC can be a normal compression fallback when fragments are off.
>>> Keep the global compression context reusable for that case while
>>> preserving the fatal state for real errors.
>>>
>>> Fixes: a729584ef975 ("erofs-utils: mkfs: avoid hanging if fragment is on and tmpdir is full")
>>> Reported-by: Bastian Schmitz <8330902+bshm@users.noreply.github.com>
>>> Closes: https://github.com/erofs/erofs-utils/issues/50
>>> Assisted-by: Codex:GPT-5.5
>>> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
>>> ---
>>>   lib/compress.c | 6 +++++-
>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/lib/compress.c b/lib/compress.c
>>> index ea07409..2a43b81 100644
>>> --- a/lib/compress.c
>>> +++ b/lib/compress.c
>>> @@ -2031,7 +2031,11 @@ err_free_idata:
>>>   out:
>>>   #ifdef EROFS_MT_ENABLED
>>>       pthread_mutex_lock(&ictx->mutex);
>>> -    ictx->seg_num = ret < 0 ? INT_MAX : 0;
>>> +    if (ret < 0 && (ret != -ENOSPC || inode->fragment_size))
>>
>> Thanks for the fix! but why `inode->fragment_size`
>> is used here?
>>
> My understanding is that once inode->fragment_size is non-zero, -ENOSPC means real failure rather than compression fallback. (lib/compress.c:1374)

hmmm, I guess we should give another specific error
number for compression fallbacks instead to distiguish
no space and compression fallbacks...

Thanks,
Gao Xiang

