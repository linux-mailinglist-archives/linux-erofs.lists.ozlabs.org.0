Return-Path: <linux-erofs+bounces-2963-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAVrD5ZYwWnbSQQAu9opvQ
	(envelope-from <linux-erofs+bounces-2963-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Mar 2026 16:13:26 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2FD2F5FFB
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Mar 2026 16:13:25 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffcB95jlbz2xLt;
	Tue, 24 Mar 2026 02:13:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774278801;
	cv=none; b=Yz8wIjwaJ6eA1XD+PtspXn4hdBsmYtTxbKuSKa5ca2g4z0JfiuSQAi172KdcOCzStPd0ZTDG+PUTJzzhI6U5/kByaap6O8ZxxdXzeFT3yPLVZWexkzILBkKNYdssnIYgQra/csOIaDCcZcsTWMUf0jkaWw3v+5CxM4YfpQ/H4PYSss9GS6UkVAEH+m2uTYi9uRDilH5zVsEMASWMhcLeAXQk8GZZWm4sL519wCaWyWYRVR59KjRcJ3vRt2RNq15F0e77RjC/aAjGJ4e/mKsc8ch5jGoqGgUu+s8B4x7rtIe4cIQXm/iA6jPtmgNUkHswh9H0vvxpSzSxinRr+NawlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774278801; c=relaxed/relaxed;
	bh=kllI6hJN9VXv6yFYlgtzf39WhxEOlkkHf4/HHes6XEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KLeBFaTYqPfmCgavWfh6oKKsVrR6fEerIq7akHKxT4ctWmisdLF2Kz4m3Jrkml//MizImHZvJvvLfUirG+JlKGgQ0/ZHiMn+xeM34Fpuxc+ioHM4bko9Ts8ME40+AzIDqbb3iw2P4t/k2d0TC7gjOKDn5cLIRNREi099mE18vpdB4NeVPZIYjVf/yuT8RhGEn3T0hsc8/bTesaSKLF3cFB2Zrn1i+JwyvakewB8/BIZ9/R9vM0AxJ6etCj12ElFFIELIJGAhJhWrM6Epnyqquh3WVncdee0j26C+nkcHkSfmaW3TGstTLSRoXZMXTmv8BUnstGc1PVF876OoMwl2Hg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GYrX29LO; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GYrX29LO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffcB646yJz2xGF
	for <linux-erofs@lists.ozlabs.org>; Tue, 24 Mar 2026 02:13:17 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774278792; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kllI6hJN9VXv6yFYlgtzf39WhxEOlkkHf4/HHes6XEw=;
	b=GYrX29LOW/H3sLmRr955OLcIFQA/DxC8mUrpj05pKsvPPvV4+k3uxbv/gTATo69g/ufRsR9muu9XHNoBEKde1gM2/TcLFc6baD9GY8xNinZVJTbSMkqLvwYZ34dh+k4e3gF6mM5VoluN2k6BJIsj84kZ0QRchw1H1u9wO7BVcY0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X.Z5BoM_1774278790;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.Z5BoM_1774278790 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 23 Mar 2026 23:13:11 +0800
Message-ID: <cee1977e-38cc-48f6-a474-7d27fb6c4bc9@linux.alibaba.com>
Date: Mon, 23 Mar 2026 23:13:10 +0800
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
Subject: Re: [PATCH 1/4] fs/erofs: align the malloc'ed data
To: Michael Walle <mwalle@kernel.org>, Huang Jianan <jnhuang95@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: linux-erofs@lists.ozlabs.org, u-boot@lists.denx.de
References: <20260323134305.2675822-1-mwalle@kernel.org>
 <20260323134305.2675822-2-mwalle@kernel.org>
 <b761dcf1-db25-47f3-8ef6-096c7a2f0493@linux.alibaba.com>
 <DHA98B2R8313.2J0R49KQ2WE1X@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <DHA98B2R8313.2J0R49KQ2WE1X@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,konsulko.com];
	TAGGED_FROM(0.00)[bounces-2963-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mwalle@kernel.org,m:jnhuang95@gmail.com,m:trini@konsulko.com,m:linux-erofs@lists.ozlabs.org,m:u-boot@lists.denx.de,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 4E2FD2F5FFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/23 23:08, Michael Walle wrote:
> Hi Gao,
> 
> On Mon Mar 23, 2026 at 3:41 PM CET, Gao Xiang wrote:
>> Hi Michael,
>>
>> On 2026/3/23 21:42, Michael Walle wrote:
>>> The data buffers are used to transfer from or to hardware peripherals.
>>> Often, there are restrictions on addresses, i.e. they have to be aligned
>>> at a certain size. Thus, allocate the data on the heap instead of the
>>> stack (at a random address alignment). Use malloc_cache_aligned() to get
>>> an aligned buffer.
>>
>> Many thanks for the patch, I wonder if it's possible to
>> submit the patches to erofs-utils first (even make
>> malloc_cache_aligned() as another malloc() for example)?
>>
>> Since I'd like to make u-boot codebase following
>> erofs-utils, but I don't think Jianan have the
>> bandwidth now, but if you have some use cases,
>> you could help syncing up a bit.
> 
> Sorry, I don't have the bandwidth neither. But now I see where all
> this is coming from. In userspace, you have much less (or none at
> all) restrictions. So not sure, if that even makes sense to share. As
> you've already pointed out the malloc_cache_aligned() would have to
> be changed (back!) to malloc() again.

But it can align the codebase between erofs-utils and u-boot,
in that way, all potential bug fixes can be addressed
together.

> 
>> Or at least, let's keep these four patches in sync
>> between erofs-utils and u-boot.
> 
> Not sure what a DMA alignment has to do with userspace, or do you
> mean moving all the block data from stack to heap?

I think if it's not complex, we could do that, but if some
case is very hard, we can leave them alone.

> 
> This is more or less the result from an internal evaluation. You (or
> anybody else) might take it - or leave it.
> 
> Do you share code between linux and erofs-utils, too? How does that
> work?

Only the majority of metadata parsing logic is shared by
the linux kernel and erofs-utils, much like XFS shares
libxfs between the kernel and xfsprogs.

Thanks,
Gao Xiang
  
> 
> Thanks,
> -michael
> 
>>
>> Many thanks!
>> Gao Xiang
>>
>>>
>>> Signed-off-by: Michael Walle <mwalle@kernel.org>
>>> ---
>>>    fs/erofs/data.c     | 11 ++++-------
>>>    fs/erofs/internal.h |  1 +
>>>    2 files changed, 5 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
>>> index b58ec6fcc66..61dbae51a9a 100644
>>> --- a/fs/erofs/data.c
>>> +++ b/fs/erofs/data.c
>>> @@ -319,15 +319,13 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
>>>    		}
>>>    
>>>    		if (map.m_plen > bufsize) {
>>> -			char *tmp;
>>> -
>>>    			bufsize = map.m_plen;
>>> -			tmp = realloc(raw, bufsize);
>>> -			if (!tmp) {
>>> +			free(raw);
>>> +			raw = malloc_cache_aligned(bufsize);
>>> +			if (!raw) {
>>>    				ret = -ENOMEM;
>>>    				break;
>>>    			}
>>> -			raw = tmp;
>>>    		}
>>>    
>>>    		ret = z_erofs_read_one_data(inode, &map, raw,
>>> @@ -336,8 +334,7 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
>>>    		if (ret < 0)
>>>    			break;
>>>    	}
>>> -	if (raw)
>>> -		free(raw);
>>> +	free(raw);
>>>    	return ret < 0 ? ret : 0;
>>>    }
>>>    
>>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>>> index 1875f37fcd2..13c862325a6 100644
>>> --- a/fs/erofs/internal.h
>>> +++ b/fs/erofs/internal.h
>>> @@ -11,6 +11,7 @@
>>>    #include <linux/printk.h>
>>>    #include <linux/log2.h>
>>>    #include <inttypes.h>
>>> +#include <memalign.h>
>>>    #include "erofs_fs.h"
>>>    
>>>    #define erofs_err(fmt, ...)	\
> 


