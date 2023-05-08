Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 183A16FAAA4
	for <lists+linux-erofs@lfdr.de>; Mon,  8 May 2023 13:04:54 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QFJN406zRz3cKb
	for <lists+linux-erofs@lfdr.de>; Mon,  8 May 2023 21:04:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QFJMy19F0z30QQ
	for <linux-erofs@lists.ozlabs.org>; Mon,  8 May 2023 21:04:44 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vi4YlCm_1683543875;
Received: from 172.20.4.208(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vi4YlCm_1683543875)
          by smtp.aliyun-inc.com;
          Mon, 08 May 2023 19:04:39 +0800
Message-ID: <ba535bd9-fdd3-b23e-4e9b-73a5d6fb93a2@linux.alibaba.com>
Date: Mon, 8 May 2023 04:04:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: Merging multiple erofs file systems on the same block device
To: Daan De Meyer <daan.j.demeyer@gmail.com>
References: <CAO8sHc=vxhp_+98Om7C83zOyXmdAkAxeoOrnffgwqkPntvO2fw@mail.gmail.com>
 <86f08d9c-ea37-6012-fbb9-c2e2710c00f1@linux.alibaba.com>
 <CAO8sHc=7FHA8vEnHHOySnOCDQ9HvWbCEC3nVqyG6J=OJEfz38Q@mail.gmail.com>
 <3e0474fc-2d24-8c47-9f0f-40b6709d6e74@linux.alibaba.com>
 <CAO8sHcmFF5KrB5GkXvCcueNHzZcyksWsGTJjjxSE=uo+=xRVFg@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAO8sHcmFF5KrB5GkXvCcueNHzZcyksWsGTJjjxSE=uo+=xRVFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/5/5 16:19, Daan De Meyer wrote:
>> On 2023/5/2 18:03, Daan De Meyer wrote:
>>>> On 2023/5/1 22:09, Daan De Meyer wrote:
>>>>> Hi,
>>>>>
>>>>> I've been looking into erofs as an initramfs replacement by using
>>>>> root=/dev/ram0 to tell the kernel to load the initramfs as a ramdisk.
>>>>
>>>> Sorry, I'm on vacation now.
>>>>
>>>> May I ask what's your detailed use cases?  Sure, you could use
>>>> /dev/ram0 as a replacement, but currently it still takes double
>>>> memory compared with initramfs since ramdisk doesn't support FSDAX
>>>> for now (by enabling FSDAX, it won't take double memory at all.)
>>>
>>> I'm experimenting with larger initramfses and running into memory
>>> bottlenecks since the entire compressed cpio has to be decompressed
>>> into memory. I was hoping to use erofs as a replacement that could stay
>>> compressed, where only the files that are actually accessed are
>>> decompressed at runtime.
>>
>> Sorry for late reply.
>>
>> Okay, that makes sense, although FSDAX cannot be used as this way since
>> decompressed data is needed for mmapped accesses.
> 
> Can you clarify why using a ramdisk would take double the memory if FSDAX
> is not used?

You could take a look at
https://www.kernel.org/doc/Documentation/filesystems/ramfs-rootfs-initramfs.txt

and section "ramfs and ramdisk" describes the details, but FSDAX could avoid
this problem.

> 
>>>
>>>> Actually I think ramdisk FSDAX is useful and I might sync up this on
>>>> the following LSF/MM/BPF 2023.
>>>>
>>>>> However, by using a ramdisk instead of the usual compressed cpio, I
>>>>> would lose the feature where the kernel merges multiple individual
>>>>> cpios together into a single tmpfs filesystem. Looking at the
>>>>> documentation for erofs, I noticed that erofs already seems to support
>>>>> merging multiple erofs filesystems on separate block devices using the
>>>>> device= cmdline option. Would it be possible to extend this so that
>>>> Here `device=` is actually used to refer to seperate blobs with the
>>>> merged metadata.  For example, you could have
>>>>
>>>>      device=/dev/ram1 original tar1
>>>>      device=/dev/ram2 original tar2
>>>>      /dev/ram0        merged metadata for tar1 + tar2.
>>>>
>>>> which means, if you'd like to merge multiple EROFS filesystems, you
>>>> might need another step to build a merged metadata in advance in order
>>>> to merges multiple individual tarballs together, which could be built
>>>> when applying images or booting (by using a special bootloader with
>>>> such functionality.)
>>>
>>> Ahh, I misunderstood the device= option then.
>>>
>>>> EROFS doesn't support stacking multiple fses runtimely since it seems
>>>> a duplicated feature of overlayfs (you could consider using overlayfs
>>>> honestly.)
>>>
>>> I would love to use overlayfs, but there's no way to specify to the kernel that
>>> the initrd should be set up as an overlayfs of a set of ram disks. It would be
>>> interesting if I could put multiple filesystems in the initrd and the
>>> kernel would
>>> notice and automatically set up an overlayfs of them.
>>
>> I didn't use overlayfs as this way so I'm not sure as well.  Yet as a wild
>> guess, you could specify a ramdisk with a customized init to stack
>> overlayfs like this in the userspace?  Not sure though...
> 
> This approach generally works, but if you want to enforce all mounted
> filesystems to be dm-verity protected, you now need to add verity data
> for all these filesystems to the initramfs. That's why we're looking
> for a solution where the kernel sets up the filesystem mount of the
> ramdisk which is special cased and doesn't require verity data to be
> present. Anyway, the overlayfs issue is not something for erofs to
> solve. If at all desirable, it should probably be filesystem
> independent where the kernel just looks for multiple filesystems in
> the initrd buffer and sets up an overlay mount using each found
> filesystem.

I'm not sure if you could still specify one root filesystem with
dm-verity and it mounts filesystems of rest layers and then uses
overlayfs properly with a customized init.

Yes, anyway, you could enhance kernel init code as well.

Thanks,
Gao Xiang

> 
> Cheers,
> 
> Daan De Meyer
