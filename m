Return-Path: <linux-erofs+bounces-3729-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PtqdEfn1OWrRzQcAu9opvQ
	(envelope-from <linux-erofs+bounces-3729-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jun 2026 04:56:57 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C83D6B3A6D
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jun 2026 04:56:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=zjuU89t7;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3729-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3729-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkqTy0r1cz2xwP;
	Tue, 23 Jun 2026 12:56:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782183414;
	cv=none; b=byXu3J3OAYyhxxP24MfsabbVSpsQH45YjDJGlZyGXXpm3cz0k73uIeGHVySgnSAF+GLyBHWg4pEAVH5mgJfXi2Mmt8/5HnMuYPZI62W/cTluA8/ksv7zf5sCdrVQAXMVXEB92oayax6SC+e93kKffaIJzA5/nUi1xm4xlu8N3mtP3SFACntBj42cvgwc5ciWJW7AbZBTvBc/Ys3s2vei6HrBV+fMZvxe8MfCbSafbd1/83ncuKI+XbtVx+A555snjZoC8nDiIy2Smv0ptSOBCNZuGCLKOOqCdlIRWXcT/JHNaXrq78uOYnq93lrgj1Mjdwq3rObvW2HI7x2YaS3Mxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782183414; c=relaxed/relaxed;
	bh=3FP7inGyWy0E6+I1Eu/AJAPBgjw2ccMJU9V06wXPaqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=N09uAUSUtG5plvC1k3HgKZQk77tRfrOWKeUqpgUaQob/jZyRw86KwnkKJIksrDThmv+KlNgbKAf0PU1/CnNIaTF11u1g8ZLJAyLTJVwsPoS7vqAq+fgN6OCLuVpmlV0WxnzjReuEmrmZV+HfrOYMNkn33euSJdMTI0VGA6U6Bm2khuaJ7UEZS8baeRsHpXBrKm72OZrUzV74OJW2D2DUEgR2+ulXsEqX9OjaV2iPM8qiccLhaa0V8EFlbIQJExgfS1QzDH3OXKrO1sscSemey90lokJVNcXevo2nkYo6ZLhcC5KwRVdQRIu0Fvp7g+BhBRzlVNsqylCUaU5iCKlgGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=zjuU89t7; dkim-atps=neutral; spf=pass (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkqTx2LYfz2xnQ
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jun 2026 12:56:53 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=3FP7inGyWy0E6+I1Eu/AJAPBgjw2ccMJU9V06wXPaqI=;
	b=zjuU89t7Sp/UZRwcTT5ZJlcHRAgH1jMiQDzH8dqXcExtejF+xNLbKCrbbFpM07HzYeAqASvqZ
	s9UUwgbGhwD6mtIg1EVFBv55C9dOL0wKm9+SkOwXW1MgzMhKdY7F1WG9jir3vdmxJPt1q3Bh3iA
	jy48XyDN6D5YJlt1S+YItdM=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gkqJT4mvszKm5J;
	Tue, 23 Jun 2026 10:48:41 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 2FC5D40563;
	Tue, 23 Jun 2026 10:56:46 +0800 (CST)
Received: from [100.102.28.251] (100.102.28.251) by
 kwepemr100010.china.huawei.com (7.202.195.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 23 Jun 2026 10:56:45 +0800
Message-ID: <7d47c915-7db4-4510-8d62-5fda278b0ed6@huawei.com>
Date: Tue, 23 Jun 2026 10:56:45 +0800
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
Subject: Re: [RESEND PATCH 2/2] erofs-utils: lib: honor rebuild whiteouts for
 recreated dirs
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
CC: <zhukeqian1@huawei.com>
References: <20260622034248.1047783-1-zhaoyifan28@huawei.com>
 <20260622034248.1047783-2-zhaoyifan28@huawei.com>
 <7f1e369d-f3fe-4aab-976b-29c5e765fca3@linux.alibaba.com>
From: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
In-Reply-To: <7f1e369d-f3fe-4aab-976b-29c5e765fca3@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [100.102.28.251]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3729-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:zhukeqian1@huawei.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
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
X-Rspamd-Queue-Id: 5C83D6B3A6D


On 2026/6/22 11:58, Gao Xiang wrote:
>
>
> On 2026/6/22 11:42, Yifan Zhao wrote:
>> When rebuilding from upper to lower, a whiteout below an already
>> recreated directory should keep that directory but stop older lower
>> entries from being merged into it.
>>
>> Mark the existing directory opaque before applying the generic
>> non-directory bailout.
>>
>> Reported-by: cayoub-oai <276123840+cayoub-oai@users.noreply.github.com>
>
> I hope it could be a real email if the reporter
> can give us, which helps us to give the exact
> credits too..
>
>> Closes: https://github.com/erofs/erofs-utils/issues/49
>> Assisted-by: Codex:GPT-5.5
>> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
>> ---
>>   lib/rebuild.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/rebuild.c b/lib/rebuild.c
>> index 51dfe18..108a464 100644
>> --- a/lib/rebuild.c
>> +++ b/lib/rebuild.c
>> @@ -401,7 +401,13 @@ static int erofs_rebuild_dirent_iter(struct 
>> erofs_dir_context *ctx)
>>               .nid = ctx->de_nid
>>           };
>>           ret = erofs_read_inode_from_disk(&src);
>> -        if (ret || !S_ISDIR(src.i_mode))
>> +        if (ret)
>> +            goto out;
>
>         if (S_ISDIR(d->inode->i_mode) &&
>             erofs_inode_is_whiteout(&src))
>
> I guess?  If the upper is not a directory, I think
> it should be ignored instead?
>
S_ISDIR has already been checked earlier in this block, so I think 
current logic is enouth.


Thanks,

Yifan

> Thanks,
> Gao Xiang

