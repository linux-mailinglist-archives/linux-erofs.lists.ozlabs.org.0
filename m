Return-Path: <linux-erofs+bounces-3348-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOStBP0152mg5QEAu9opvQ
	(envelope-from <linux-erofs+bounces-3348-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Apr 2026 10:31:57 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2EA4382FD
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Apr 2026 10:31:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0FvW100Nz2xlK;
	Tue, 21 Apr 2026 18:31:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776760311;
	cv=none; b=JdnUWNy9WyG18+rPD5JVXBmboAbSLBXfatDMGpRON7onsy6pNjI7SSGyB7GffeI0DC4RMpf1FUOIHB1wY7nov6GwVfpO1T5hGiEOR8WHhXzxu0LMSgaaFfY+4yApWDw7+8HOVGp4MAsFSlzAL/y+szWcOCvs7xrQhRduk/w5C78GCb6jpH1BOkK7aXQc+rxlQtSQBVz7ckAIQU1v1jhvFUhWMZLkZ4AfOvE0QEQ68PIaSFDu7hgE2UC1lzER601nWWYg3c/0s+1JeZCg2IZFqjJdUG5mtSUG044lkin1xyYJal8ETlotgt1QZARgfC8suXW58EelcRLmCsbEuJ+CXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776760311; c=relaxed/relaxed;
	bh=ATytX8LlVoThaoqnc3uAzQfHYAy1bVfCBu0LICH7K2U=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cHnKmj9qJWmyn74ZVzLznNNSZwCqtrirfWf7jufA5QkpxwVU8g0xG0Jfw6aAZuFgaI8axq5tzesTjTQWOSzBmhsqBJM4YM1HajTL9TQhkRhjkDV3E5VnT6fNSzyQHQv4GN2eqfn8o5D9NpUaH06JGJ/t4iUxwqxmjId+vDaJdAKnTkAnRtUsJB0IuTwgDSWxM87S++uFdnXfFay1gMeIZO1zTpsn/zcM7OCaHjFgfX6epzfNSmFlaNsvFlfz/0RvG80MbIPjyksMSdhiOeBN3rO0JIkisF5DKVPrJol/zkAO0fXNqu4YFV+4oIGef3iieMjGBG5wwtZz+NMBDgyEvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=baLMRGq4; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=baLMRGq4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0FvT0fHTz2xNT
	for <linux-erofs@lists.ozlabs.org>; Tue, 21 Apr 2026 18:31:48 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8A699438F9;
	Tue, 21 Apr 2026 08:31:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76FDAC2BCB5;
	Tue, 21 Apr 2026 08:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776760306;
	bh=z9hoGsaXqKuWu/+mcsB/sTmS2Aq3KjYQ8GuAfdQxXiA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=baLMRGq402k5jNcIDeL0Pn8W0w/vULYkexfpKJ7Q6pZ4jtCQ1qZaPUJYTzao8a2qj
	 s5HYWQj2+aw6n0dMt7cH5GadoVenDq+CxQVg4HGlLqAkAutFXewvjEPlKT1LUqvfDv
	 IJbN5TeUU634hQSFuoDJ5a9J1joW1J+tEc1bEZkjj6WZhkobEGRFSX9aBn3VgC5X8V
	 uzjLVc0DUuArEQvcqoNqNOWPledGlLHxRZXrezbJc94UCsYLD+CtTmIeSRGEgv+wnP
	 MGWCm1lixZoDQ7MXrj82g2Ro1L8H1tdYZPHCCY4o7DomI+XXg86aomNLOLpJ2bsmCA
	 EpO2nYtD4zi/A==
Message-ID: <16fa1bbb-639d-44b6-82d0-374c56b4371f@kernel.org>
Date: Tue, 21 Apr 2026 16:31:44 +0800
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
Cc: chao@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Yuhao Jiang <danisjiang@gmail.com>, Junrui Luo <moonafterrain@outlook.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH v3] erofs: fix the out-of-bounds nameoff handling for
 trailing dirents
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20260416063511.3173774-1-hsiangkao@linux.alibaba.com>
 <20260416094408.3466613-1-hsiangkao@linux.alibaba.com>
 <b9d787ce-9020-4140-8d13-23a20809976d@kernel.org>
 <d1fe814b-9527-4dc7-b79a-9952b4199242@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <d1fe814b-9527-4dc7-b79a-9952b4199242@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3348-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,outlook.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:chao@kernel.org,m:linux-kernel@vger.kernel.org,m:danisjiang@gmail.com,m:moonafterrain@outlook.com,m:stable@vger.kernel.org,m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[chao@kernel.org,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chao@kernel.org,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,alibaba.com:email,sashiko.dev:url]
X-Rspamd-Queue-Id: 3E2EA4382FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/21/2026 3:38 PM, Gao Xiang wrote:
> 
> 
> On 2026/4/21 15:26, Chao Yu wrote:
>> On 4/16/2026 5:44 PM, Gao Xiang wrote:
>>> Currently we already have boundary-checks for nameoffs, but the trailing
>>> dirents are special since the namelens are calculated with strnlen()
>>> with unchecked nameoffs.
>>>
>>> If a crafted EROFS has a trailing dirent with nameoff >= maxsize,
>>> maxsize - nameoff can underflow, causing strnlen() to read past the
>>> directory block.
>>>
>>> nameoff0 should also be verified to be a multiple of
>>> `sizeof(struct erofs_dirent)` as well [1].
>>>
>>> [1] https://sashiko.dev/#/patchset/20260416063511.3173774-1-hsiangkao%40linux.alibaba.com
>>> Fixes: 3aa8ec716e52 ("staging: erofs: add directory operations")
>>> Fixes: 33bac912840f ("staging: erofs: keep corrupted fs from crashing kernel in erofs_readdir()")
>>> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
>>> Reported-by: Junrui Luo <moonafterrain@outlook.com>
>>> Closes: https://lore.kernel.org/r/A0FD7E0F-7558-49B0-8BC8-EB1ECDB2479A@outlook.com
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>>> ---
>>> v3:
>>>    - Disallow unaligned nameoff0 to avoid petential oob reads as well.
>>>
>>>    fs/erofs/dir.c | 29 ++++++++++++++++-------------
>>>    1 file changed, 16 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
>>> index e5132575b9d3..d074fded1577 100644
>>> --- a/fs/erofs/dir.c
>>> +++ b/fs/erofs/dir.c
>>> @@ -19,20 +19,18 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
>>>            const char *de_name = (char *)dentry_blk + nameoff;
>>>            unsigned int de_namelen;
>>> -        /* the last dirent in the block? */
>>> -        if (de + 1 >= end)
>>> -            de_namelen = strnlen(de_name, maxsize - nameoff);
>>> -        else
>>> +        /* non-trailing dirent in the directory block? */
>>> +        if (de + 1 < end)
>>>                de_namelen = le16_to_cpu(de[1].nameoff) - nameoff;
>>> +        else if (maxsize <= nameoff)
>>> +            goto err_bogus;
>>> +        else
>>> +            de_namelen = strnlen(de_name, maxsize - nameoff);
>>> -        /* a corrupted entry is found */
>>> -        if (nameoff + de_namelen > maxsize ||
>>> -            de_namelen > EROFS_NAME_LEN) {
>>> -            erofs_err(dir->i_sb, "bogus dirent @ nid %llu",
>>> -                  EROFS_I(dir)->nid);
>>> -            DBG_BUGON(1);
>>> -            return -EFSCORRUPTED;
>>> -        }
>>> +        /* a corrupted entry is found (including negative namelen) */
>>> +        if (!in_range32(de_namelen, 1, EROFS_NAME_LEN) ||
>>> +            nameoff + de_namelen > maxsize)
>>> +            goto err_bogus;
>>>            if (!dir_emit(ctx, de_name, de_namelen,
>>>                      erofs_nid_to_ino64(EROFS_SB(dir->i_sb),
>>> @@ -42,6 +40,10 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
>>>            ctx->pos += sizeof(struct erofs_dirent);
>>>        }
>>>        return 0;
>>> +err_bogus:
>>> +    erofs_err(dir->i_sb, "bogus dirent @ nid %llu", EROFS_I(dir)->nid);
>>> +    DBG_BUGON(1);
>>> +    return -EFSCORRUPTED;
>>>    }
>>>    static int erofs_readdir(struct file *f, struct dir_context *ctx)
>>> @@ -88,7 +90,8 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>>>            }
>>>            nameoff = le16_to_cpu(de->nameoff);
>>> -        if (nameoff < sizeof(struct erofs_dirent) || nameoff >= bsz) {
>>
>> You mean?
>>
>> if (!nameoff || nameoff >= bsz || nameoff % sizeof(struct erofs_dirent))
> 
> The explanation can be seen as:
> https://sashiko.dev/#/patchset/20260416063511.3173774-1-hsiangkao%40linux.alibaba.com
> 
> But I think `nameoff < sizeof(struct erofs_dirent)` is also fine?

Yes, it's fine to use "nameoff < sizeof(struct erofs_dirent)", it's a minor
cleanup to use "!nameof".

Thanks,

> I could also switch to your suggested version.
> 
> Thanks,
> Gao Xiang
> 


