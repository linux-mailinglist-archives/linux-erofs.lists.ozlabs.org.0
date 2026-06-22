Return-Path: <linux-erofs+bounces-3704-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UGL2L6i1OGosggcAu9opvQ
	(envelope-from <linux-erofs+bounces-3704-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 06:10:16 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2E46AC766
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 06:10:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=3hcs0kk3;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3704-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3704-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkF904Hkpz2yVP;
	Mon, 22 Jun 2026 14:10:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782101412;
	cv=none; b=dNdH4LM8EUdgyX2MaFz9gdMm9pVgM8LRpKEF9XsfAJxXJzQ3OBzVcPkNGcXTeDU/bO5vd62BZgiypw6H/Ere8mbt6dTDF9NPq/01tP8hge1aTHZ+LpQI55TifHrohZ/hLGFR1ZLlnHf6Zn7J/q5u8tVPiNgJUdgu4i3KMBqPfoBXhUNPA5gSPopoSBEnefAH0IwmShWtX7ALsTzeN8INb3CbJhk+He0e2WzMW1fG0e9zjX7ISW90kbyqIRI7MDzShm5Ko4YuMrzRMQk4SE/vfX2LwNX/6GWac5r+JpNp43P8TVGt0CsxT4Yurul9O59omC6Wpgh7LH49etzPFKQnjA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782101412; c=relaxed/relaxed;
	bh=WHJpWvm6yapbRQh3jCBKazrKudT6xtVaOZubRbsO3os=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EUyQZ48yvM16hc50x4fQ9hIwoJXYG2o4kkSxvaveW+flLA3RhPkVxV3u96ZG8/oq27fwZ8FiqhmbponLieq1nDtJ4HZWdKBW8Ux3Fm1wb0XDxa6WIC+0W2+Dv5CYmWSqboV68cDoXJbeafcjm6nHcTwB77w8n68R3eYQoZVSVYGeeo1quFJRcI+SbjjMo16VIkAJiOuuDKH7mqAzPPLb58Tn8JfP9T02Ku1xNDMLPPzXEhcOQXAIRH2ayxlVUkVphU8EMrzg+AVWh/ktUMlQme3WjOMirduClqT34MIu5zehviz604neCnIYxX3kUBEqbJzYcUjOzhabVZ8puphusQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=3hcs0kk3; dkim-atps=neutral; spf=pass (client-ip=113.46.200.227; helo=canpmsgout12.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkF8x3Knhz2xwH
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jun 2026 14:10:07 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=WHJpWvm6yapbRQh3jCBKazrKudT6xtVaOZubRbsO3os=;
	b=3hcs0kk3Wqq8qHnuhd+VcLMiAXl0q1I0lly7xMjj/j5RJNDdhlm2DWsRHaHtxmyTMM8ePPQlU
	CP8pastjRGwQh1oFgkE25PI+Fj9qgbEe4gKYw4YwfQaR7rISNBnDdpAcRYTRfn7RC+zhpWbe2ZX
	9lEjjdrRkPCeSylSREqZO8Y=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gkDyj5vm5znTVn;
	Mon, 22 Jun 2026 12:01:17 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 00EB040574;
	Mon, 22 Jun 2026 12:10:02 +0800 (CST)
Received: from [100.102.28.251] (100.102.28.251) by
 kwepemr100010.china.huawei.com (7.202.195.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 22 Jun 2026 12:10:02 +0800
Message-ID: <b021c538-3100-4cf2-b69e-cbac93b94056@huawei.com>
Date: Mon, 22 Jun 2026 12:10:02 +0800
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
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
CC: <zhukeqian1@huawei.com>
References: <20260622034248.1047783-1-zhaoyifan28@huawei.com>
 <4433eb42-4ca9-46ae-98e5-7bd388cad0a0@linux.alibaba.com>
From: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
In-Reply-To: <4433eb42-4ca9-46ae-98e5-7bd388cad0a0@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [100.102.28.251]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3704-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:zhukeqian1@huawei.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[3];
	HAS_XOIP(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp,huawei.com:dkim,huawei.com:email,huawei.com:mid,huawei.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B2E46AC766


On 2026/6/22 11:51, Gao Xiang wrote:
> Hi Yifan,
>
> On 2026/6/22 11:42, Yifan Zhao wrote:
>> -ENOSPC can be a normal compression fallback when fragments are off.
>> Keep the global compression context reusable for that case while
>> preserving the fatal state for real errors.
>>
>> Fixes: a729584ef975 ("erofs-utils: mkfs: avoid hanging if fragment is 
>> on and tmpdir is full")
>> Reported-by: Bastian Schmitz <8330902+bshm@users.noreply.github.com>
>> Closes: https://github.com/erofs/erofs-utils/issues/50
>> Assisted-by: Codex:GPT-5.5
>> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
>> ---
>>   lib/compress.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/compress.c b/lib/compress.c
>> index ea07409..2a43b81 100644
>> --- a/lib/compress.c
>> +++ b/lib/compress.c
>> @@ -2031,7 +2031,11 @@ err_free_idata:
>>   out:
>>   #ifdef EROFS_MT_ENABLED
>>       pthread_mutex_lock(&ictx->mutex);
>> -    ictx->seg_num = ret < 0 ? INT_MAX : 0;
>> +    if (ret < 0 && (ret != -ENOSPC || inode->fragment_size))
>
> Thanks for the fix! but why `inode->fragment_size`
> is used here?
>
My understanding is that once inode->fragment_size is non-zero, -ENOSPC 
means real failure rather than compression fallback. (lib/compress.c:1374)


Thanks,

Yifan

> I guess if (ret < 0 && ret != -ENOSPC) is enough?
>
> Thanks,
> Gao Xiang

