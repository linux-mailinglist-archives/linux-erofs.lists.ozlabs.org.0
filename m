Return-Path: <linux-erofs+bounces-556-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C8CAFCEAD
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Jul 2025 17:12:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bc4Nb6nQLz3bjG;
	Wed,  9 Jul 2025 01:12:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751987567;
	cv=none; b=KTd09IVeyzvzEah7/ZnJRzKLqFf8PaNPvaPlRHjCYtvdP0Tkxx2BfGJEA8IvVkE1nhPbiUsJ7Nx7JNHIoQnQEr6V/sOwqEPsw2DRNqsKM7QrjbqaRTDDaVgD8q4s6xQQHwqIQS4PSwgNMXJBw4SpVkeZ/ZvySfVL2FUnAndtxFkenEmvF3oteCJbkMenVaZ3qqKUfUBPinTKmeT3TLOhHjFF0oh6mA/C+zjL7ek1+rYYJO2DrMcR7sFvKl/1b4BDFxYmHy44US9wLs45Fu/Rmh083tG+q91qZR8lBeHRmpgwg8M+3SOWvrUO5qy96Lb8nOoiG/C5/bsJvzugY//s5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751987567; c=relaxed/relaxed;
	bh=iougDzW3D3SBa8Um4dOsc8Bp3F+DjNmLCnoOTK86N+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GV8i8kfjAvsyx017T0oA3UpLelxZDPDxBvk65U94f/RuMR0k4vz89rTpWfC/bvn6wSTpwR8Y7801kXClSbM412HR0hhOlE1gLNqtlFXDQFelEOAugJ36Uy4uSnZOl/ZTSqTp3lhAncJFAVMlqoqgM1qZlmxrMApETCc5o8OcSIoojUp/nI9nNBF7V/HXDY80cmvapMX+/WRFZ8XMNiN2MkNavZ95dETZ48HIMEar4rcQbah60Lo0JKNBlgXcS8WVtpoSLJTeqBOgzQEFpVKHz3hwJjwKVQrJq1up5HPthoKWQJQQUGlMhl5A8ib173kb5ZgBlDQvCh/7ISEwBO5qMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KsLEbHaL; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KsLEbHaL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bc4NY61Tjz3bVW
	for <linux-erofs@lists.ozlabs.org>; Wed,  9 Jul 2025 01:12:44 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751987559; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=iougDzW3D3SBa8Um4dOsc8Bp3F+DjNmLCnoOTK86N+Y=;
	b=KsLEbHaLjs2Aw2ZpbjV59er7f3rPwDrVlSmmPWX/cdTiy520m54GOfac6i5jYb6qjySWbVaIMSwIv3qASW7kSzvYXyF85pW9KImkLUMNgDULvd6i6BuzrXn2ipQ49br7X2d6R95jbmL4ByjTc4Gh4UtxTgYvVBPO1CLnzV94zBw=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WiPkcpx_1751987557 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 08 Jul 2025 23:12:37 +0800
Message-ID: <bab2d726-5c2f-4fe0-83d4-f83a0c248add@linux.alibaba.com>
Date: Tue, 8 Jul 2025 23:12:35 +0800
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
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <452a2155-ab3b-43d1-8783-0f1db13a675f@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Jan,

On 2025/7/8 20:43, Jan Kiszka wrote:
> On 08.07.25 14:41, Jan Kiszka wrote:
>> Hi all,
>>
>> for some days, I'm trying to understand if we have an integration issue
>> with erofs or rather some upstream bug. After playing with various
>> parameters, it rather looks like the latter:
>>
>> $ ls -l erofs-dir/
>> total 132
>> -rwxr-xr-x 1 1000 users 132868 Jul  8 10:50 dash
>> (from Debian bookworm)
>> $ mkfs.erofs -z lz4hc erofs.img erofs-dir/
>> mkfs.erofs 1.8.6 (trixie version, but same happens with bookworm 1.5)
>> Build completed.
>> ------
>> Filesystem UUID: aae0b2f0-4ee4-4850-af49-3c1aad7fa30c
>> Filesystem total blocks: 17 (of 4096-byte blocks)
>> Filesystem total inodes: 2
>> Filesystem total metadata blocks: 1
>> Filesystem total deduplicated bytes (of source files): 0
>>
>> Now I have 6.15-rc5 and a defconfig-close setting for the 32-bit ARM
>> target BeagleBone Black. When booting into init=/bin/sh, then running
>>
>> # mount -t erofs /dev/mmcblk0p1 /mnt
>> erofs (device mmcblk0p1): mounted with root inode @ nid 36.
>> # /mnt/dash
>> Segmentation fault
>>
>> I once also got this:
>>
>> Alignment trap: not handling instruction 2b00 at [<004debc0>]
>> 8<--- cut here ---
>> Unhandled fault: alignment exception (0x001) at 0x000004d9
>> [000004d9] *pgd=00000000
>> Bus error
>>
>> All is fine if I
>>   - run the command once more
>>   - dump the file first (cat /mnt/dash > /dev/null; /mnt/dash)
> 
> Forgot to mention: That first dump when done via md5sum or so actually
> gives the right checksum. So pure reading of the binary is also ok, just
> trying to load it for execution fails on the first attempt.

Thanks for your report.  I rarely take care arm32 platform
because I don't have such setup.

but could you share a reproducible rootfs image and
I wonder if qemu could reproduce this?

Otherwise it's hard for me to debug this issue...

Thanks,
Gao Xiang

> 
> Jan
> 
>>   - boot a full Debian system and then mount & run the command
>>   - do not compress erofs
>>
>> Also broken is -z zstd, so the decompression algorithm itself should not
>> be the reason. I furthermore tested older kernels as well, namely
>> stable-derived 6.1-cip and 6.12-cip, and those are equally affected.
>>
>> Any ideas? I have CONFIG_EROFS_FS_DEBUG=y, but that does not trigger
>> anything. Is there anything I could instrument?
>>
>> Jan
>>
> 


