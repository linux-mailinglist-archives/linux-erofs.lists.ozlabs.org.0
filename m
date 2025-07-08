Return-Path: <linux-erofs+bounces-565-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 407A5AFD4CC
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Jul 2025 19:10:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bc6zt06Sqz30Wn;
	Wed,  9 Jul 2025 03:10:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751994601;
	cv=none; b=QXOv9Umfom5FEbNai0tcFDDIyXSyrfjiJsicZuGGRMCM/jkMgfrHJ7ok85RGwTzciPx/qAG3xjer7xkIJDd4dDe10Rx6/B7xpJ7tQRal+4WvHbqNfU/uhZrKARra0xh78FQoaBk+IzSL9o8nLB9k0X9ArTvyV9W1e/9vYJQVxv6YdkmRuhfzBP1DhVdNGg2Jh1m8J65jOtUl5MnwJQSxQipQjOv6Am/R9n5DhDZP58ZPhjIFywb+ZB+1chRJ/vxqvJcx/evs/ra4ZdppC2TZ7nR5FSt3XZHefNK9+7iepjUOM1mrOlWAS5AVx0lEs0ULlcfA6E/8FkjtrSFNoG0I4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751994601; c=relaxed/relaxed;
	bh=XX/LTMe6pPkmdt3MpUQdcGQ1iSxrolB5ZnpeGne6jZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GsgA1ySCXxXgB+mIveYoTxIMAGxBelYuFtyhF6JO6GstTe6LT2pCKY1k4q8wyAT+nIqIs86baGkD7NYOEnhOi7pceY2t79Md+iKBGv50PMykOClGaU/I/8r06r7awt9bXPBnS63A2bgH5oNDj45aO7x84LHz0lDBnOWhOKzLeZtYRluPpBWZ7W+9npu6s95/w7ZNibVWfekL49j4RvjrNzDMjddwAJ5yPxWv26/l0UnW+TwDeC3QPPGkeQqvfycvU6ISesP5UclrtEXHJXRipxYGhvTktQuATiqEi9l6BlsECZ6OSVqlvs6I0IylN0aO0x+w/QHp0EPmAfIO94cGTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fZ9TJCDj; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fZ9TJCDj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bc6zr1QX7z30WX
	for <linux-erofs@lists.ozlabs.org>; Wed,  9 Jul 2025 03:09:58 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751994594; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=XX/LTMe6pPkmdt3MpUQdcGQ1iSxrolB5ZnpeGne6jZ0=;
	b=fZ9TJCDjWrZig+wn3aqDMn+ECbjV5F2EXjZ9kb1X85ma34HfCbQ0xMl0DUedSntIscernS9uVx3Mk2ggesx41kfO8tIWhoVHwzgd4ykjXk0iJD7w8Aw4wSElU08Dej8b9aRrMcEKB/HoyAHdBIbPv7PW9fTitvUxgnWf/xrB8to=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WiQuW0K_1751994590 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 09 Jul 2025 01:09:51 +0800
Message-ID: <17432623-6d5d-4a8d-b4ae-8099c589b5e4@linux.alibaba.com>
Date: Wed, 9 Jul 2025 01:09:50 +0800
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
Subject: Re: Executable loading issues with erofs on arm?
To: Jan Kiszka <jan.kiszka@siemens.com>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <38d43fae-1182-4155-9c5b-ffc7382d9917@siemens.com>
 <452a2155-ab3b-43d1-8783-0f1db13a675f@siemens.com>
 <bab2d726-5c2f-4fe0-83d4-f83a0c248add@linux.alibaba.com>
 <81a3d28b-4570-4d44-8ed6-51158353c0ff@siemens.com>
 <6216008a-dc0c-4f90-a67c-36bead99d7f2@linux.alibaba.com>
 <2bfd263e-d6f7-4dcd-adf5-2518ba34c36b@linux.alibaba.com>
 <edcffe3e-95f3-46ba-b281-33631a7653e5@linux.alibaba.com>
 <7f9d35af-d71b-46c5-b0ea-216bbf68dfe7@siemens.com>
 <eb879ced-600a-4dd3-a9d6-3c391b4460c2@siemens.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <eb879ced-600a-4dd3-a9d6-3c391b4460c2@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/7/9 01:01, Jan Kiszka wrote:
> On 08.07.25 18:39, Jan Kiszka wrote:
>> On 08.07.25 17:57, Gao Xiang wrote:
>>>
>>>
>>> On 2025/7/8 23:36, Gao Xiang wrote:
>>>>
>>>>
>>>> On 2025/7/8 23:32, Gao Xiang wrote:
>>>>>
>>>>>
>>>>> On 2025/7/8 23:22, Jan Kiszka wrote:
>>>>>> On 08.07.25 17:12, Gao Xiang wrote:
>>>>>>> Hi Jan,
>>>>>>>
>>>>>>> On 2025/7/8 20:43, Jan Kiszka wrote:
>>>>>>>> On 08.07.25 14:41, Jan Kiszka wrote:
>>>>>>>>> Hi all,
>>>>>>>>>
>>>>>>>>> for some days, I'm trying to understand if we have an integration
>>>>>>>>> issue
>>>>>>>>> with erofs or rather some upstream bug. After playing with various
>>>>>>>>> parameters, it rather looks like the latter:
>>>>>>>>>
>>>>>>>>> $ ls -l erofs-dir/
>>>>>>>>> total 132
>>>>>>>>> -rwxr-xr-x 1 1000 users 132868 Jul  8 10:50 dash
>>>>>>>>> (from Debian bookworm)
>>>>>>>>> $ mkfs.erofs -z lz4hc erofs.img erofs-dir/
>>>>>>>>> mkfs.erofs 1.8.6 (trixie version, but same happens with bookworm
>>>>>>>>> 1.5)
>>>>>>>>> Build completed.
>>>>>>>>> ------
>>>>>>>>> Filesystem UUID: aae0b2f0-4ee4-4850-af49-3c1aad7fa30c
>>>>>>>>> Filesystem total blocks: 17 (of 4096-byte blocks)
>>>>>>>>> Filesystem total inodes: 2
>>>>>>>>> Filesystem total metadata blocks: 1
>>>>>>>>> Filesystem total deduplicated bytes (of source files): 0
>>>>>>>>>
>>>>>>>>> Now I have 6.15-rc5 and a defconfig-close setting for the 32-bit ARM
>>>>>>>>> target BeagleBone Black. When booting into init=/bin/sh, then
>>>>>>>>> running
>>>>>>>>>
>>>>>>>>> # mount -t erofs /dev/mmcblk0p1 /mnt
>>>>>>>>> erofs (device mmcblk0p1): mounted with root inode @ nid 36.
>>>>>>>>> # /mnt/dash
>>>>>>>>> Segmentation fault
>>>>
>>>> Two extra quick questions:
>>>>    - If the segfault happens, then if you run /mnt/dash again, does
>>>>      segfault still happen?
>>>>
>>>>    - If the /mnt/dash segfault happens, then if you run
>>>>        cat /mnt/dash > /dev/null
>>>>        /mnt/dash
>>>>      does segfault still happen?
>>>
>>> Oh, sorry I didn't read the full hints, could you check if
>>> the following patch resolve the issue (space-damaged)?
>>>
>>> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
>>> index 6a329c329f43..701490b3ef7d 100644
>>> --- a/fs/erofs/data.c
>>> +++ b/fs/erofs/data.c
>>> @@ -245,6 +245,7 @@ void erofs_onlinefolio_end(struct folio *folio, int
>>> err)
>>>          if (v & ~EROFS_ONLINEFOLIO_EIO)
>>>                  return;
>>>          folio->private = 0;
>>> +       flush_dcache_folio(folio);
>>>          folio_end_read(folio, !(v & EROFS_ONLINEFOLIO_EIO));
>>>   }
>>>
>>
>> Yeah, indeed that seem to have helped with the minimal test. Will do the
>> full scenario test (complete rootfs) next.
>>
> 
> And that looks good as! Thanks a lot for that quick fix - hoping that is
> the real solution already.
> 
> BTW, that change does not look very specific to the armhf arch, rather
> like we were lucky that it didn't hit elsewhere, right?

I may submit a formal patch tomorrow.

This issue doesn't impact x86 and arm64. For example on arm64,
PG_dcache_clean is clear when it's a new page cache folio.

But it seems on arm platform flush_dcache_folio() does more
to handle D-cache aliasing so some caching setup may be
impacted.

Thanks,
Gao Xiang

> 
> Jan
> 


