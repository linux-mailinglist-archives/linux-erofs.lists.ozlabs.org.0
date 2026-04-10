Return-Path: <linux-erofs+bounces-3265-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKVgD9O82GlVhggAu9opvQ
	(envelope-from <linux-erofs+bounces-3265-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Apr 2026 11:03:15 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4B93D476D
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Apr 2026 11:03:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsW6l6Mztz2yZ6;
	Fri, 10 Apr 2026 19:03:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775811791;
	cv=none; b=DWjSwqkc4y1RVF1Sto3jR2DwlWFQV2kk+q7N99r5CzYxc3h9Gguplm73nNgD/hfyqLw7+/YgaLg9qJz3M0Vz5qX4zYHtjSeoeJ43c5qPvnSQN2DQHwF+OSmDkvpJuCsujQhT3BY0rlUxZaPDCX4IhIyG+jRsWPDuV8uCAT+HMT0354iHZT0nrpwIxUo+Aj5sgvvj+VgqaUw1Ea2YRqA6nfvxjqRVfsj9CUKkDEXPqG1tL/Qk+6pulroOCW5eHojrAKzpNfvDeE8976WtYOg5YyvgCpSyQ+l2DVk98pW7SvChIWZfr9ZrP2nCMYx36QpNbOFjSHRjOLF/a7gBwOY9hw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775811791; c=relaxed/relaxed;
	bh=forOFrPyu5Q08G2ykBikyfX5j8/G9BBHB1ga9Qe4bA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KS5W362G9xsbv3PWcVFkVlUJ3CxPnTXu1kXBR+B0CTZcxwdqy0oMEyq4zjpb1Obzu6rdqUbWkr9xagYQLtCtY1yw1yr+YXQEqfEvXIrOl6rH+8Wu+kQ1SenqxH5jJ2ELHKORb2g/X96tUBfox3BXK8BwKfIvgak+LJTdPE/7tT0hpjyHQUfhWvU3mdJOZ34zYNsOkiobYJ5oqhysyITesaWbCfEpE93KPxLYOVMxwiuIj3Lh/akeaRuI/kao+n0nSdVQG1XMlGXc5CPdcolsYcjj5unJxiZWom9mECK2jPiA40KD8CnXmFaQsj/RELyamSxuFjvYMVzom9fNbqDFhw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=oFnmHm3S; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=oFnmHm3S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsW6k6PFGz2xTh
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Apr 2026 19:03:09 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775811786; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=forOFrPyu5Q08G2ykBikyfX5j8/G9BBHB1ga9Qe4bA4=;
	b=oFnmHm3ScUrIn3GsFwTcvDxzcMoJpGEsPlxCfZJKNwwHIt2seY25k1ocaJK8nSntLssTjs3kwgtDkVKSh2c0ecHwXHJPfDpEb/4eQ6UUSXLxssIg6cR9niioK825ovTbUD/+Fv0/SM3KcOGTKmV8vhOvyeRb9mhGyWhMOp7qUhQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X0kq4cf_1775811784;
Received: from 30.221.132.105(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X0kq4cf_1775811784 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 10 Apr 2026 17:03:05 +0800
Message-ID: <85a0c42a-1e8e-492f-95c9-5a724abf70dd@linux.alibaba.com>
Date: Fri, 10 Apr 2026 17:03:04 +0800
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
Subject: Re: [PATCH v1] erofs-utils: mkfs: fix fingerprint not set in certain
 modes
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Cc: "Friendy.Su@sony.com" <Friendy.Su@sony.com>,
 "Daniel.Palmer@sony.com" <Daniel.Palmer@sony.com>
References: <20260410060539.417457-2-Yuezhang.Mo@sony.com>
 <c1514566-e3ca-4ef6-b23b-054f9e1a49c5@linux.alibaba.com>
 <TY0PR04MB63283F67989B4A1649F6149E81592@TY0PR04MB6328.apcprd04.prod.outlook.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <TY0PR04MB63283F67989B4A1649F6149E81592@TY0PR04MB6328.apcprd04.prod.outlook.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3265-lists,linux-erofs=lfdr.de];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:Yuezhang.Mo@sony.com,m:linux-erofs@lists.ozlabs.org,m:Friendy.Su@sony.com,m:Daniel.Palmer@sony.com,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCPT_COUNT_THREE(0.00)[4];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,linux.alibaba.com:dkim,linux.alibaba.com:mid,sony.com:email]
X-Rspamd-Queue-Id: 6C4B93D476D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/10 17:00, Yuezhang.Mo@sony.com wrote:
>> On 2026/4/10 14:05, Yuezhang Mo wrote:
>>> In certain modes, such as "--tar=f --sort=none", data is written to
>>> the image before fingerprint calculation. In this case, ->datasource
>>> will be set to `EROFS_INODE_DATA_SOURCE_NONE`.
>>>
>>> The original `erofs_set_inode_fingerprint()` function only attempts to
>>> read data from a local file or disk buffer; it cannot handle the
>>> `EROFS_INODE_DATA_SOURCE_NONE` case, causing fingerprint setting to be
>>> skipped.
>>>
>>> This patch adds handling for the `EROFS_INODE_DATA_SOURCE_NONE` case,
>>> reading data from the image and calculating the fingerprint.
>>>
>>> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
>>> Reviewed-by: Friendy Su <friendy.su@sony.com>
>>> Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>
>>> ---
>>>    lib/inode.c | 20 ++++++++++++++------
>>>    1 file changed, 14 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/lib/inode.c b/lib/inode.c
>>> index 2cfc6c5..51d5266 100644
>>> --- a/lib/inode.c
>>> +++ b/lib/inode.c
>>> @@ -1975,6 +1975,13 @@ static int erofs_set_inode_fingerprint(struct erofs_inode *inode, int fd,
>>>
>>>        if (!ishare_xattr_prefix_id)
>>>                return 0;
>>> +
>>> +     if (inode->datasource == EROFS_INODE_DATA_SOURCE_NONE) {
>>> +             ret = erofs_iopen(&vf, inode);
>>> +             if (ret)
>>> +                     return ret;
>>> +     }
>>> +
>>>        erofs_sha256_init(&md);
>>>        do {
>>>                u8 buf[32768];
>>> @@ -2018,12 +2025,6 @@ static int erofs_mkfs_begin_nondirectory(const struct erofs_mkfs_btctx *btctx,
>>>                        goto out;
>>>                }
>>>
>>> -             if (S_ISREG(inode->i_mode) && inode->i_size) {
>>> -                     ret = erofs_set_inode_fingerprint(inode, ctx.fd, ctx.fpos);
>>> -                     if (ret < 0)
>>> -                             return ret;
>>> -             }
>>
>> I vaguely remembered we have to leave it here since
>> otherwise it may impact compressed files.
>>
>> Also EROFS_INODE_DATA_SOURCE_NONE means that mkfs
>> dump will change nothing about that, so I suggest
>>
>> apply erofs_set_inode_fingerprint() to every
>> EROFS_INODE_DATA_SOURCE_NONE user
>> (e.g. in lib/tar.c) instead.
>>
> 
> Hi Xiang,
> 
> This will bring a bit big code change.
> 
> How about changing it like this? It maintains the original
> order and the change is simple.

`EROFS_INODE_DATA_SOURCE_NONE` should assume that metadata
is done as-is, that is the current design principle.

using erofs_iopen() to reuse erofs_pread() is really
unexpected for me TBH.

Thanks,
Gao Xiang


