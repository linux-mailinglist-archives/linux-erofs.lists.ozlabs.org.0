Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFB3D79EF
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2019 17:38:40 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46t02P1hgQzDr3h
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Oct 2019 02:38:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=blucerlee@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jl2n0G60"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46t02L0QCdzDr3T
 for <linux-erofs@lists.ozlabs.org>; Wed, 16 Oct 2019 02:38:33 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id q5so12699306pfg.13
 for <linux-erofs@lists.ozlabs.org>; Tue, 15 Oct 2019 08:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding;
 bh=UOFjLSpQeOxDpzvtJqbqg/ojAd+2wcRKp3wDo7ylv44=;
 b=Jl2n0G60vWxHSPEvdhKIsRIIus8uLG517ldQC5cHo/MZM7v5ov7PdG2og3QkiMBsns
 CGBTPIFmRNS4BtbZ8PjHVIRDOrvcCfJ87Fz8yMynjepNn0M9jdGpujuGhm0VHuTZBHSu
 P4jC66K/gfQFnjXUTFuh+TZNOOJiMv/vJd3ebOyQhUXVWfdq0Nn8h1RSZUwl94/opCfq
 E97RASF/x83n8gn1IUUEh9oUQJrdrePvnpRE3k+mhX2gCbSGfSI0dsuBvdlXFnWwL4VE
 lGEKdTq+EpcCmRst6hKbYUezG2r3hT+pc9w8e4aRdKfhfPHTDhr2IuvaeRl+J1ccWN1R
 tLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding;
 bh=UOFjLSpQeOxDpzvtJqbqg/ojAd+2wcRKp3wDo7ylv44=;
 b=kcvyTNh4RbQeKOfQdQiZ/7z9BHmnvhxSKtNG4JjpH/+Mqn4THYUDLAv8UV3ak6lTKG
 HkBpsom8UWZH8Hu/IUm5nSwweBkfFf3QzglgEPHtRrujMbCKKfkqMWk1EvWFUd/a5Doh
 AV4zA78SgqXMP1KEGxdZx4RdXlA34xPhVjRWUgMrD+NoHHgGjkT7icdRXhgDey/yTwrS
 ielYH+8DyoopkEhX8oVHvL3dGupu6gpGtg/CrYWN3PAkYwF/LOgo1LGAiilayf5+tmuy
 +7Jz73F5QKSULddr+tws/YjJgOr3fsbQvCuuIaUAndm852OvIBzAojgWhmbR6YLs3iDK
 vCww==
X-Gm-Message-State: APjAAAX6w/nkQxjQUmHQ7ZVr5nvu+zLz4Eck6hw9wOtGe5h8rnPhwpfd
 vKpRxMZIu9XgSuDsCiS+8Sg=
X-Google-Smtp-Source: APXvYqztkKK35EyL2bpdKrU0n/ogTlgfkbt2qc9st91c4QfkAd6kBa+dDCdmhaimCdEDt1jwXVFIsQ==
X-Received: by 2002:a17:90a:bd82:: with SMTP id
 z2mr44477739pjr.15.1571153909895; 
 Tue, 15 Oct 2019 08:38:29 -0700 (PDT)
Received: from [0.0.0.0] (li2016-34.members.linode.com. [172.105.123.34])
 by smtp.gmail.com with ESMTPSA id t13sm19742838pfh.12.2019.10.15.08.38.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 15 Oct 2019 08:38:29 -0700 (PDT)
Subject: Re: [PATCH] erofs-utils: use cmpsgn(x, y) for standardized large
 value comparsion
To: Gao Xiang <hsiangkao@aol.com>, Li Guifu <bluce.liguifu@huawei.com>,
 linux-erofs@lists.ozlabs.org
References: <20191014113048.32067-1-hsiangkao@aol.com>
 <20191014235505.GB31674@hsiangkao-HP-ZHAN-66-Pro-G1>
From: Li Guifu <blucerlee@gmail.com>
Message-ID: <ef338ece-ea98-d4f9-18e3-db5d1e163995@gmail.com>
Date: Tue, 15 Oct 2019 23:38:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191014235505.GB31674@hsiangkao-HP-ZHAN-66-Pro-G1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Gao Xiang,

It runs ok, but could you resend it to adjust line algin ?

 >> -#define sgn(x) ({		\
 >> +#define cmpsgn(x, y) ({		\
 >>   	typeof(x) _x = (x);	\
 >> -(_x > 0) - (_x < 0); })
 >> +	typeof(y) _y = (y);	\
 >> +(_x > _y) - (_x < _y); }) ----> here


> On Mon, Oct 14, 2019 at 07:30:48PM +0800, Gao Xiang wrote:
>> Previously, roundup(bb->buffers.off % EROFS_BLKSIZ, alignsize)
>> + incr + extrasize is a unsigned 64bit value and sgn(x) didn't
>> work properly. Fix it.
> 
> Update commit message:
> 
> erofs-utils: use cmpsgn(x, y) for standardized large value comparsion
>      
> Previously, roundup(bb->buffers.off % EROFS_BLKSIZ, alignsize)
> + incr + extrasize is an unsigned 64bit value and sgn(x) didn't
> work properly. Fix it.
>      
> Fixes: b0ca535297b6 ("erofs-utils: support 64-bit internal buffer cache")
> 
> Guifu, do you have time reviewing and testing those patches?
> I'd like to release erofs-utils 1.0 for upstreaming AOSP these days...
> 
> Thanks,
> Gao Xiang
> 
>>
>> Signed-off-by: Gao Xiang <hsiangkao@aol.com>
>> ---
>>   include/erofs/defs.h | 5 +++--
>>   lib/cache.c          | 6 +++---
>>   2 files changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/erofs/defs.h b/include/erofs/defs.h
>> index 15db4e3..db51350 100644
>> --- a/include/erofs/defs.h
>> +++ b/include/erofs/defs.h
>> @@ -136,9 +136,10 @@ typedef int64_t         s64;
>>   	type __max2 = (y);			\
>>   	__max1 > __max2 ? __max1: __max2; })
>>   
>> -#define sgn(x) ({		\
>> +#define cmpsgn(x, y) ({		\
>>   	typeof(x) _x = (x);	\
>> -(_x > 0) - (_x < 0); })
>> +	typeof(y) _y = (y);	\
>> +(_x > _y) - (_x < _y); })
>>   
>>   #define ARRAY_SIZE(arr)	(sizeof(arr) / sizeof((arr)[0]))
>>   
>> diff --git a/lib/cache.c b/lib/cache.c
>> index 41d2d5d..e61b201 100644
>> --- a/lib/cache.c
>> +++ b/lib/cache.c
>> @@ -80,9 +80,9 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
>>   			   bool dryrun)
>>   {
>>   	const erofs_off_t alignedoffset = roundup(bb->buffers.off, alignsize);
>> -	const int oob = sgn(roundup(bb->buffers.off % EROFS_BLKSIZ,
>> -				    alignsize) + incr + extrasize -
>> -			    EROFS_BLKSIZ);
>> +	const int oob = cmpsgn(roundup(bb->buffers.off % EROFS_BLKSIZ,
>> +				       alignsize) + incr + extrasize,
>> +			       EROFS_BLKSIZ);
>>   	bool tailupdate = false;
>>   	erofs_blk_t blkaddr;
>>   
>> -- 
>> 2.17.1
>>
