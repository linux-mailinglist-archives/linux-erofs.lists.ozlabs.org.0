Return-Path: <linux-erofs+bounces-3346-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGEwC50p52mo4wEAu9opvQ
	(envelope-from <linux-erofs+bounces-3346-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Apr 2026 09:39:09 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C33A437B69
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Apr 2026 09:39:07 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0Dkd2FrPz2ySW;
	Tue, 21 Apr 2026 17:39:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776757145;
	cv=none; b=M9pEhEIvLuB2m0g2BGXGhTqkFjeoGWql2sMPY65E/I0gH0T9jr3VvQqfmHDpzFLDn2eQe69ltC59P06BuCzmyJG2Vv5EQJXzqthUi9QRoyE4VaYHfytZOMT5bquY1MKG0wIHIVdMgi/Hr5ZHTSvaAaf4Epu+Po6Mi4M6BTaFFL+eP1gCoo8dGmaBwCOcc4s8PQRdTVRm5Kct1Si+IOyLfTzN7TvO6yJkssUQpM0ar5on+v8XZlmCnvk7MSQLJqbHN8N/PebTU89eqGBUVEJG0uPWwzyAX66lF1tzxYCE6RmIsRlT4nGujraYFfPnTZsuixG5XzTUjUxZaLnR0kWUmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776757145; c=relaxed/relaxed;
	bh=bBR+x8/rFj/yPCNM4srOeJsm+pZYnjkZyx2mrSw3Ooc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bgksIVZ04tXTRbz8y5t3oJgp3+l1AE0L9TXolmEoXo2AnkIv07MmXyQ8i80WhLJ1b0+mbynCA7/9yoLGpjxQytsS21Gg6apgOGSvk3/gcCbCy/7CMPp+EpGi8FMIZZLPFhoWtadhzD+uShrnnWV00Hqeu1wzPQEJGOvT3r/M6A+Xuduf7tovnYBkEknwK62NpoL97KDFbM9UAd/D/+ULPixE1YeGUWPLx7wzBcPWcUPlidgQ4vcnRJG5IIU9qbKa+fSINGT6GaNrzLFGhzz4qWd/ZpGVv6TESblEyps4Ct7ERw5gT8o1evZ1ph66MUWnVY6WPjqu9Y4zw+O9Vu+y1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sNl7Ekjz; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sNl7Ekjz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0Dkb1MJhz2yFl
	for <linux-erofs@lists.ozlabs.org>; Tue, 21 Apr 2026 17:39:01 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1776757136; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=bBR+x8/rFj/yPCNM4srOeJsm+pZYnjkZyx2mrSw3Ooc=;
	b=sNl7Ekjz4XaeEI2G5MZXWT4zcQ3aWmuestUG0HBFB3V+Pd5+nqwG6xZKEV04wiwc/jSmjVeIV+yuBFNj7F2U8zcxNbIs7gKa0AM/5YK9p4DgYl7hQu54i/5nfqHbKuel5rz/ynQc3mqrdRttZfKry7Xd+Uv4mQWvwNY6nxyi5FA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X1S7tuK_1776757134;
Received: from 30.221.132.26(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X1S7tuK_1776757134 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 21 Apr 2026 15:38:55 +0800
Message-ID: <d1fe814b-9527-4dc7-b79a-9952b4199242@linux.alibaba.com>
Date: Tue, 21 Apr 2026 15:38:54 +0800
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
Subject: Re: [PATCH v3] erofs: fix the out-of-bounds nameoff handling for
 trailing dirents
To: Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>, Yuhao Jiang <danisjiang@gmail.com>,
 Junrui Luo <moonafterrain@outlook.com>, stable@vger.kernel.org
References: <20260416063511.3173774-1-hsiangkao@linux.alibaba.com>
 <20260416094408.3466613-1-hsiangkao@linux.alibaba.com>
 <b9d787ce-9020-4140-8d13-23a20809976d@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <b9d787ce-9020-4140-8d13-23a20809976d@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3346-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:chao@kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:danisjiang@gmail.com,m:moonafterrain@outlook.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,outlook.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,outlook.com:email,alibaba.com:email]
X-Rspamd-Queue-Id: 2C33A437B69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/21 15:26, Chao Yu wrote:
> On 4/16/2026 5:44 PM, Gao Xiang wrote:
>> Currently we already have boundary-checks for nameoffs, but the trailing
>> dirents are special since the namelens are calculated with strnlen()
>> with unchecked nameoffs.
>>
>> If a crafted EROFS has a trailing dirent with nameoff >= maxsize,
>> maxsize - nameoff can underflow, causing strnlen() to read past the
>> directory block.
>>
>> nameoff0 should also be verified to be a multiple of
>> `sizeof(struct erofs_dirent)` as well [1].
>>
>> [1] https://sashiko.dev/#/patchset/20260416063511.3173774-1-hsiangkao%40linux.alibaba.com
>> Fixes: 3aa8ec716e52 ("staging: erofs: add directory operations")
>> Fixes: 33bac912840f ("staging: erofs: keep corrupted fs from crashing kernel in erofs_readdir()")
>> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
>> Reported-by: Junrui Luo <moonafterrain@outlook.com>
>> Closes: https://lore.kernel.org/r/A0FD7E0F-7558-49B0-8BC8-EB1ECDB2479A@outlook.com
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>> v3:
>>   - Disallow unaligned nameoff0 to avoid petential oob reads as well.
>>
>>   fs/erofs/dir.c | 29 ++++++++++++++++-------------
>>   1 file changed, 16 insertions(+), 13 deletions(-)
>>
>> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
>> index e5132575b9d3..d074fded1577 100644
>> --- a/fs/erofs/dir.c
>> +++ b/fs/erofs/dir.c
>> @@ -19,20 +19,18 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
>>           const char *de_name = (char *)dentry_blk + nameoff;
>>           unsigned int de_namelen;
>> -        /* the last dirent in the block? */
>> -        if (de + 1 >= end)
>> -            de_namelen = strnlen(de_name, maxsize - nameoff);
>> -        else
>> +        /* non-trailing dirent in the directory block? */
>> +        if (de + 1 < end)
>>               de_namelen = le16_to_cpu(de[1].nameoff) - nameoff;
>> +        else if (maxsize <= nameoff)
>> +            goto err_bogus;
>> +        else
>> +            de_namelen = strnlen(de_name, maxsize - nameoff);
>> -        /* a corrupted entry is found */
>> -        if (nameoff + de_namelen > maxsize ||
>> -            de_namelen > EROFS_NAME_LEN) {
>> -            erofs_err(dir->i_sb, "bogus dirent @ nid %llu",
>> -                  EROFS_I(dir)->nid);
>> -            DBG_BUGON(1);
>> -            return -EFSCORRUPTED;
>> -        }
>> +        /* a corrupted entry is found (including negative namelen) */
>> +        if (!in_range32(de_namelen, 1, EROFS_NAME_LEN) ||
>> +            nameoff + de_namelen > maxsize)
>> +            goto err_bogus;
>>           if (!dir_emit(ctx, de_name, de_namelen,
>>                     erofs_nid_to_ino64(EROFS_SB(dir->i_sb),
>> @@ -42,6 +40,10 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
>>           ctx->pos += sizeof(struct erofs_dirent);
>>       }
>>       return 0;
>> +err_bogus:
>> +    erofs_err(dir->i_sb, "bogus dirent @ nid %llu", EROFS_I(dir)->nid);
>> +    DBG_BUGON(1);
>> +    return -EFSCORRUPTED;
>>   }
>>   static int erofs_readdir(struct file *f, struct dir_context *ctx)
>> @@ -88,7 +90,8 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>>           }
>>           nameoff = le16_to_cpu(de->nameoff);
>> -        if (nameoff < sizeof(struct erofs_dirent) || nameoff >= bsz) {
> 
> You mean?
> 
> if (!nameoff || nameoff >= bsz || nameoff % sizeof(struct erofs_dirent))

The explanation can be seen as:
https://sashiko.dev/#/patchset/20260416063511.3173774-1-hsiangkao%40linux.alibaba.com

But I think `nameoff < sizeof(struct erofs_dirent)` is also fine?
I could also switch to your suggested version.

Thanks,
Gao Xiang


