Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACF88A39FC
	for <lists+linux-erofs@lfdr.de>; Sat, 13 Apr 2024 03:02:38 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vFv6yG42;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VGZsm1Vwxz3dgN
	for <lists+linux-erofs@lfdr.de>; Sat, 13 Apr 2024 11:02:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vFv6yG42;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VGZsg2Ny9z3cGc
	for <linux-erofs@lists.ozlabs.org>; Sat, 13 Apr 2024 11:02:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712970145; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=r2+HYoqgGCp8SrYMZ5py7L9eSKKFZdlc8PTSBYsOViw=;
	b=vFv6yG42sqwHFMwSNQZ9jliZPjXfFA7Lzztx74qjLWv/sIy2u1QT4EBecSbhNVigKF3AM4N7hX0cvt1xs+1VsW2Q3FJAW53kl1qwcxUQWMAj8D+k4Q3Mk/zKMmuCoR5zTRKMZug0Wfj3Iwqhd1KK020gVl21MqjOKT40JuD+hkU=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W4POwE0_1712970142;
Received: from 192.168.3.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W4POwE0_1712970142)
          by smtp.aliyun-inc.com;
          Sat, 13 Apr 2024 09:02:23 +0800
Message-ID: <9fe4a34c-d291-4e83-966d-8e07f21d7100@linux.alibaba.com>
Date: Sat, 13 Apr 2024 09:02:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] erofs-utils: dump: print filesystem blocksize
To: Sandeep Dhavale <dhavale@google.com>
References: <20240412225107.1240188-1-dhavale@google.com>
 <2f1c9a66-7fe2-4df3-8025-4f8075bc06a1@linux.alibaba.com>
 <CAB=BE-RsPmjGgWKmuguTYQzkmmxGLdrqvaGcBFWA--AcsUr8sQ@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAB=BE-RsPmjGgWKmuguTYQzkmmxGLdrqvaGcBFWA--AcsUr8sQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: kernel-team@android.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/4/13 09:00, Sandeep Dhavale wrote:
> On Fri, Apr 12, 2024 at 5:09 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>> Hi Sandeep,
>>
>> On 2024/4/13 06:51, Sandeep Dhavale wrote:
>>> mkfs.erofs supports creating filesystem images with different
>>> blocksizes. Add filesystem blocksize in super block dump so
>>> its easier to inspect the filesystem.
>>>
>>> The filed is added at last, so the output now looks like:
>>>
>>> Filesystem magic number:                      0xE0F5E1E2
>>> Filesystem blocks:                            21
>>> Filesystem inode metadata start block:        0
>>> Filesystem shared xattr metadata start block: 0
>>> Filesystem root nid:                          36
>>> Filesystem lz4_max_distance:                  65535
>>> Filesystem sb_extslots:                       0
>>> Filesystem inode count:                       10
>>> Filesystem created:                           Fri Apr 12 15:43:40 2024
>>> Filesystem features:                          sb_csum mtime 0padding
>>> Filesystem UUID:                              a84a2acc-08d8-4b72-8b8c-b811a815fa07
>>> Filesystem blocksize:                         65536
>>>
>>> Signed-off-by: Sandeep Dhavale <dhavale@google.com>
>>
>> Just a minor nit:
>> Could we move "Filesystem blocksize:" between the line of
>> "Filesystem magic number:" and "Filesystem blocks:" ?
>>
>> Otherwise it looks good to me, thanks for this!
>>
> Hi Gao,
> Sure I can change the location. I didn't do it assuming someone might
> have scripted around it (not that I know of!), so I added it last.

Yeah, I could guess your original intentation. But it seems somewhat
strange to show `Filesystem blocksize` in the very end...

Thanks,
Gao Xiang

> I will send V2 by moving it after magic number.
> 
> Thanks,
> Sandeep.
>> Thanks,
>> Gao Xiang
