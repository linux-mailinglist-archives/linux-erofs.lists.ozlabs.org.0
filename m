Return-Path: <linux-erofs+bounces-562-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCC2AFCFD6
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Jul 2025 17:57:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bc5N52h5Gz3bjG;
	Wed,  9 Jul 2025 01:57:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751990245;
	cv=none; b=TfwN1r83zkl/cb7L4834jwm1GoK/IiW9I/XLav3/6U2F1u1Cduvz6xOCjxu/tNvVkEP28ZLuuAi50i8JqQYuZqRhrLQ+/69l1MiOqG6D0MEzO5eQErcKhER4x+1XTuqe+H4UFW5CO/lmZZzLWiz43SQjz/LTE8niYeXsFjHuCweeZmvGvpHnBiSoYvGvTfCOKNyj6JUNFoMF8aMspec21vgp9mSDed8lAOg3a6e7m1F8gCBCSX9KXDS2ISCtw/O9Pl9giXLA0zFlUJHWnxkMjQIp8mCcYnIQrsfdSHokpDWIk8dIB+84op+DZXP1vUbzuEOSqcn/rpYhyg4mzFNraA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751990245; c=relaxed/relaxed;
	bh=TqIPF46/tpQFzsQ2Mt6/LXt3YG4aD7B79RZab20n59U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nzBbM2HIxaajaLU7imRXWinAzZVDDW45UGRrgqSNvOR/U1WLkqFPixScFgAeW7UjK1fHlVuiDivBIyiLQXeXmNdWs3r7Ipz9GlQgMifdd1wKENmgvfbr4ND4WrV2/oNo6ZSS19viig75g+Mg90e5gWV3oaPXEmfCJOUNK7k/pw5twWxPelS8PwEWlgj2AJDxEoNhTGZHgX+T7StnxYcgBiq5rGJ2LVVqHqmwgmdqhxBAAs1j1tKRZ4YP5lVbyoF+j1RAC6Lw2E+PNFmhxDcrhRkVtpNg6p51iraZ76TEy7nWNwRn2G4znxg4VtIUTXck8rsF+tqsUT0PtbrGr33s0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=BWwnsuYt; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=BWwnsuYt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bc5N315qDz3bby
	for <linux-erofs@lists.ozlabs.org>; Wed,  9 Jul 2025 01:57:21 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751990238; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=TqIPF46/tpQFzsQ2Mt6/LXt3YG4aD7B79RZab20n59U=;
	b=BWwnsuYt5Q3wlbmfx+Jlu8epkz9jFeeXNRc9qf47Lzvzt0g4XjmVoS12Vd7OpgXU5oXNxIAfiXXFe8gJ/XJtsvjitF4y1uq8cO0mPQlGaaJ7NfYfeQ6vFiQYSaj3YAZgjrfWuGalFdAqr8+QJMM3gtVndF0cE2AAHsmPZRkJ91U=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WiPxJSa_1751990235 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 08 Jul 2025 23:57:16 +0800
Message-ID: <edcffe3e-95f3-46ba-b281-33631a7653e5@linux.alibaba.com>
Date: Tue, 8 Jul 2025 23:57:15 +0800
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
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <38d43fae-1182-4155-9c5b-ffc7382d9917@siemens.com>
 <452a2155-ab3b-43d1-8783-0f1db13a675f@siemens.com>
 <bab2d726-5c2f-4fe0-83d4-f83a0c248add@linux.alibaba.com>
 <81a3d28b-4570-4d44-8ed6-51158353c0ff@siemens.com>
 <6216008a-dc0c-4f90-a67c-36bead99d7f2@linux.alibaba.com>
 <2bfd263e-d6f7-4dcd-adf5-2518ba34c36b@linux.alibaba.com>
In-Reply-To: <2bfd263e-d6f7-4dcd-adf5-2518ba34c36b@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/7/8 23:36, Gao Xiang wrote:
> 
> 
> On 2025/7/8 23:32, Gao Xiang wrote:
>>
>>
>> On 2025/7/8 23:22, Jan Kiszka wrote:
>>> On 08.07.25 17:12, Gao Xiang wrote:
>>>> Hi Jan,
>>>>
>>>> On 2025/7/8 20:43, Jan Kiszka wrote:
>>>>> On 08.07.25 14:41, Jan Kiszka wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> for some days, I'm trying to understand if we have an integration issue
>>>>>> with erofs or rather some upstream bug. After playing with various
>>>>>> parameters, it rather looks like the latter:
>>>>>>
>>>>>> $ ls -l erofs-dir/
>>>>>> total 132
>>>>>> -rwxr-xr-x 1 1000 users 132868 Jul  8 10:50 dash
>>>>>> (from Debian bookworm)
>>>>>> $ mkfs.erofs -z lz4hc erofs.img erofs-dir/
>>>>>> mkfs.erofs 1.8.6 (trixie version, but same happens with bookworm 1.5)
>>>>>> Build completed.
>>>>>> ------
>>>>>> Filesystem UUID: aae0b2f0-4ee4-4850-af49-3c1aad7fa30c
>>>>>> Filesystem total blocks: 17 (of 4096-byte blocks)
>>>>>> Filesystem total inodes: 2
>>>>>> Filesystem total metadata blocks: 1
>>>>>> Filesystem total deduplicated bytes (of source files): 0
>>>>>>
>>>>>> Now I have 6.15-rc5 and a defconfig-close setting for the 32-bit ARM
>>>>>> target BeagleBone Black. When booting into init=/bin/sh, then running
>>>>>>
>>>>>> # mount -t erofs /dev/mmcblk0p1 /mnt
>>>>>> erofs (device mmcblk0p1): mounted with root inode @ nid 36.
>>>>>> # /mnt/dash
>>>>>> Segmentation fault
> 
> Two extra quick questions:
>   - If the segfault happens, then if you run /mnt/dash again, does
>     segfault still happen?
> 
>   - If the /mnt/dash segfault happens, then if you run
>       cat /mnt/dash > /dev/null
>       /mnt/dash
>     does segfault still happen?

Oh, sorry I didn't read the full hints, could you check if
the following patch resolve the issue (space-damaged)?

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 6a329c329f43..701490b3ef7d 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -245,6 +245,7 @@ void erofs_onlinefolio_end(struct folio *folio, int err)
         if (v & ~EROFS_ONLINEFOLIO_EIO)
                 return;
         folio->private = 0;
+       flush_dcache_folio(folio);
         folio_end_read(folio, !(v & EROFS_ONLINEFOLIO_EIO));
  }

Thanks,
Gao Xiang

