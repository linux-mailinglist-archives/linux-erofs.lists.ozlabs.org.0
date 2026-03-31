Return-Path: <linux-erofs+bounces-3132-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAU4DIA4y2nGEwYAu9opvQ
	(envelope-from <linux-erofs+bounces-3132-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Mar 2026 04:59:12 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4321F36394C
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Mar 2026 04:59:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flCWJ3T4Hz2xSb;
	Tue, 31 Mar 2026 13:59:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774925948;
	cv=none; b=m9VqtTiZiE+TAbcp7V79a09D8YnXNt0pXifWhAzBum9KV+Mdd1A3O8LgouBQheV63TghviEXfxG91TtjYGuobYGxiqC47+GR2glBJLZFPXKf9k/WVn/SYNnnT8vsvHQlESuA05NKhNZP4scDQKLtSSfsTFCWEzuejDgaSCW30SyfC+40Gkr3TICniwsm6EaenxdkJjS9BpHhdcOSRbOsaVr+Bx9GIvYC9tU+1MFzhRYnJhwLorMdeF2WsfxPzS0ZeIGO/DbyH2syLqtd+U/SEKVr+MsgDlezH+7RsAE04fsA65Os3OHyDtDR0wZ1otW00f9Xp5DG1ml0tgEk4uLJFA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774925948; c=relaxed/relaxed;
	bh=qnEFCuxJf8bvijfk1/OEXlSQgWfpUL2dOo0rrZFQZRY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YTsVeGByduqDc7p6FnClLzaHwTbgYeZfPc+64N0lHTa6C+sAVmY7fCkBw3p6UpR0WPXzPKIVlPBFY7Arrl+x6Bl/h/9hqzsrNdu0zQ5CNm0kRZ5NoRevwAjxe66huuzdGyCmB8BRdxwod0j7UpxH/vo69PUbHa5F3KhEPBQGF0YH5G+hKyt3IrnkWmGOxowr1+57617rw3dbQJtWe6tIzLa3RK7Dm4RzXopeZRAa19y28IoBcBdNtFKHzdXJw7O6NhMH7dP5Ssp4NlrSfDc3ICgHBbhTYGsi337vdD6PloGB1b6EWaqWgq/32jBw3craFTmZKzAQnZDeY9uhDKBHVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FNqHcF9E; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FNqHcF9E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flCWG2Cg6z2xHX
	for <linux-erofs@lists.ozlabs.org>; Tue, 31 Mar 2026 13:59:05 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774925941; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=qnEFCuxJf8bvijfk1/OEXlSQgWfpUL2dOo0rrZFQZRY=;
	b=FNqHcF9EuL5PcurOoOk2LQPI7td0d2rfmKj+h+dS2McXISWaMwlSNjoIpeJBuHrQ9RKqbpsYrMRCQTlWVHy/UQM+o8f7EM7+/MoQ+GzjDrw1smrmvLb2r3YUsIPSA3/Wqrne7zt8cM3vXlQO37PFbgxDj6z75ZVojXwvsM4PkQA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X02lc82_1774925938;
Received: from 30.221.131.145(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X02lc82_1774925938 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 31 Mar 2026 10:58:59 +0800
Message-ID: <cd8dd7e1-709b-4b4b-93b8-8d4147293c0c@linux.alibaba.com>
Date: Tue, 31 Mar 2026 10:58:58 +0800
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
Subject: Re: [PATCH] erofs: fix missing folio_unlock causing lock imbalance
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>, Gao Xiang <xiang@kernel.org>
Cc: "open list:EROFS FILE SYSTEM" <linux-erofs@lists.ozlabs.org>,
 linux-kernel@vger.kernel.org, Zhan Xusheng <zhanxusheng@xiaomi.com>
References: <20260331023306.18574-1-zhanxusheng@xiaomi.com>
 <669c3c5c-aece-42a6-907a-fdee99e9f1a8@linux.alibaba.com>
In-Reply-To: <669c3c5c-aece-42a6-907a-fdee99e9f1a8@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhanxusheng1024@gmail.com,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:zhanxusheng@xiaomi.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3132-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[xiaomi.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 4321F36394C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/31 10:50, Gao Xiang wrote:
> Hi Zhan,
> 
> On 2026/3/31 10:33, Zhan Xusheng wrote:
>> folio_trylock() in erofs_try_to_free_all_cached_folios() may
>> successfully acquire the folio lock, but the subsequent check
>> for erofs_folio_is_managed() can skip unlocking when the folio
>> is not managed by EROFS.
> 
> Do you find some real timing?
> 
> I don't think it can really happen, because:
> 
>>
>> This leads to a lock imbalance and leaves the folio permanently
>> locked, which may cause reclaim stalls or interfere with memory
>> management.
>>
>> Fix this by ensuring folio_unlock() is called before continuing.
> 
> If a folio links to a pcluster, folio->private will be non-NULL,
> and pcl->compressed_bvecs[i] points to that folios.
> 
> And z_erofs_cache_release_folio() will be called with folio lock,
> and pcl->compressed_bvecs[i] will be set NULL here.
> 
> So I don't think erofs_try_to_free_all_cached_folios() can find
> !erofs_folio_is_managed(sbi, folio) in the real world.
> 
>>
>> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
>> ---
>>   fs/erofs/zdata.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
>> index fe8121df9ef2..9d7ff22f1622 100644
>> --- a/fs/erofs/zdata.c
>> +++ b/fs/erofs/zdata.c
>> @@ -605,8 +605,10 @@ static int erofs_try_to_free_all_cached_folios(struct erofs_sb_info *sbi,
>>               if (!folio_trylock(folio))
>>                   return -EBUSY;
>> -            if (!erofs_folio_is_managed(sbi, folio))
>> +            if (!erofs_folio_is_managed(sbi, folio)) {
>> +                folio_unlock(folio);
>>                   continue;
>> +            }
>>               pcl->compressed_bvecs[i].page = NULL;
>>               folio_detach_private(folio);
> 
> But I admit that we should rewrite in function as:
> 
>              if (!erofs_folio_is_managed(sbi, folio)) {
>                  DBG_BUGON(1);
>              } else {
>                  pcl->compressed_bvecs[i].page = NULL;
>                  folio_detach_private(folio);
>              }

Or maybe just:
		DBG_BUGON(!erofs_folio_is_managed(sbi, folio));
		pcl->compressed_bvecs[i].page = NULL;
		folio_detach_private(folio);
		folio_unlock(folio);

Since if a pcluster goes here (!pcl->lockref.count),
`pcl->compressed_bvecs[i]` should leave all valid cached
folios (Or some should be recycled by .release_folio
instead.)

Unless there is the other bug somewhere, but in any case,
I don't think your phenomenon is related to EROFS.

Thanks,
Gao Xiang

>              folio_unlock(folio);
> 
> Thanks,
> Gao Xiang
> 
> 
>>               folio_unlock(folio);
> 


