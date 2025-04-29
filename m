Return-Path: <linux-erofs+bounces-266-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFCBAA0962
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Apr 2025 13:16:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZmySV1MBnz30TG;
	Tue, 29 Apr 2025 21:16:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=121.200.0.92
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745925402;
	cv=none; b=VIf2BOJlt+xo9ZMwyckwZd0M0C+WLAMIRdAUcWxB/YsMvsQrGzU94VmKx8Y2Vc1HstAr39qViKkf/7L+Hx9+N8SaUKluxzbxbGBa71Rf71in93p18CmVzA7u520GqjGYBAmDsD3flix+CL3PK9iFgxTBzHB4s/Aek6XbJiLjQViDXdXIIitfBIezAuTIGEILivg69xi5J4bQTaGZNjJ3TbdybU+gh7dm6KpjVJEUayB402T9arFf2Lma9NG0eCJw7q9OmiyVdXHubCD1DmQl3Dr/8BdACTjZVrWqKP3tej80dFnWQY3KKLZdd3ducRA2G9rbCdGKVgW000c0Newinw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745925402; c=relaxed/relaxed;
	bh=KD7Yer2JzATB5/FGHiIbrbSDoq9I1hTznofnLLb6xh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ErrM3n1MzfKZVquEzFF8fucyggRJmASljU82FRSKo041ElbPtRWeDldBGqtPcsBpj2R+4Epeo9CgG2V6Wcw0diZmwJBOZ3EC/ks4HWelzBgdqi51IBraoqkEkFILgZmcFIbRArcyQRTEjX9BEDy/HCbM/upc79Z5NQq+NxdD7QWXkkrLVwnyyJg12LY+jeXIFjDrAOGQw7hFO3ZdJGZV7VHwtX2VvrQyvVp1LZwBsbaOw6LjdYUj2LrHwkBVR08xS31eEorVGjqEBfChHdyJwC1szmDHHISj07C6NvWLN2uCUH+8Ba+/7dwxuuf707I3WHiePqDYRoKp7u7H6PKlBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=themaw.net; spf=neutral (client-ip=121.200.0.92; helo=smtp01.aussiebb.com.au; envelope-from=raven@themaw.net; receiver=lists.ozlabs.org) smtp.mailfrom=themaw.net
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=themaw.net
Authentication-Results: lists.ozlabs.org; spf=neutral (access neither permitted nor denied) smtp.mailfrom=themaw.net (client-ip=121.200.0.92; helo=smtp01.aussiebb.com.au; envelope-from=raven@themaw.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 522 seconds by postgrey-1.37 at boromir; Tue, 29 Apr 2025 21:16:41 AEST
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [121.200.0.92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZmyST31TNz30T3
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Apr 2025 21:16:41 +1000 (AEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp01.aussiebb.com.au (Postfix) with ESMTP id 585CD100352
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Apr 2025 21:07:55 +1000 (AEST)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
	by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZciKk58wTVGp for <linux-erofs@lists.ozlabs.org>;
	Tue, 29 Apr 2025 21:07:55 +1000 (AEST)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
	id 4747B10051F; Tue, 29 Apr 2025 21:07:55 +1000 (AEST)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=SPF_HELO_NONE,SPF_NEUTRAL
	autolearn=disabled version=4.0.1
Received: from [192.168.50.229] (159-196-82-144.9fc452.per.static.aussiebb.net [159.196.82.144])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ian146@aussiebb.com.au)
	by smtp01.aussiebb.com.au (Postfix) with ESMTPSA id 0C847100352
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Apr 2025 21:07:53 +1000 (AEST)
Message-ID: <5a1e0be3-f669-4fbe-a3d6-b7a6b9bd1e5a@themaw.net>
Date: Tue, 29 Apr 2025 19:07:52 +0800
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
Subject: Re: [PATCH v1 1/1] erofs-utils: fix endiannes issue
To: linux-erofs@lists.ozlabs.org
References: <20250429073052.53681-1-egorenar@linux.ibm.com>
 <6492b5cc-092a-46ff-98b4-9cd874af3c07@huawei.com>
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net; keydata=
 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
In-Reply-To: <6492b5cc-092a-46ff-98b4-9cd874af3c07@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/4/25 16:30, Hongbo Li wrote:
>
>
> On 2025/4/29 15:30, Alexander Egorenkov wrote:
>> From: Super User <root@a8345034.lnxne.boe>
>>
>> Macros __BYTE_ORDER, __LITTLE_ENDIAN and __BIG_ENDIAN are defined in
>> user space header 'endian.h'. Not including this header results in
>> the condition #if __BYTE_ORDER == __LITTLE_ENDIAN being always true, 
>> even on
>> BE architectures (e.g. s390x). Due to this bug the compressor library 
>> was
>> built for LE byte-order on BE arch s390x.
>>
>> Fixes: bc99c763e3fe ("erofs-utils: switch to effective unaligned 
>> access")
>> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
>> ---
>>   include/erofs/defs.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/erofs/defs.h b/include/erofs/defs.h
>> index 051a270531ca..196dfa8191a8 100644
>> --- a/include/erofs/defs.h
>> +++ b/include/erofs/defs.h
>> @@ -19,6 +19,7 @@ extern "C"
>>   #include <inttypes.h>
>>   #include <limits.h>
>>   #include <stdbool.h>
>> +#include <endian.h>
>
> Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

Yes, it makes sense.

Reviewed-by: Ian Kent <raven@themaw.net>


