Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABEF6F3C49
	for <lists+linux-erofs@lfdr.de>; Tue,  2 May 2023 05:17:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Q9QHH3LY9z3bxY
	for <lists+linux-erofs@lfdr.de>; Tue,  2 May 2023 13:17:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Q9QHD1M7Dz3bbX
	for <linux-erofs@lists.ozlabs.org>; Tue,  2 May 2023 13:17:10 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VhTYa8w_1682997424;
Received: from 192.168.68.73(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VhTYa8w_1682997424)
          by smtp.aliyun-inc.com;
          Tue, 02 May 2023 11:17:05 +0800
Message-ID: <86f08d9c-ea37-6012-fbb9-c2e2710c00f1@linux.alibaba.com>
Date: Tue, 2 May 2023 11:17:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: Merging multiple erofs file systems on the same block device
To: Daan De Meyer <daan.j.demeyer@gmail.com>, linux-erofs@lists.ozlabs.org
References: <CAO8sHc=vxhp_+98Om7C83zOyXmdAkAxeoOrnffgwqkPntvO2fw@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAO8sHc=vxhp_+98Om7C83zOyXmdAkAxeoOrnffgwqkPntvO2fw@mail.gmail.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,

On 2023/5/1 22:09, Daan De Meyer wrote:
> Hi,
> 
> I've been looking into erofs as an initramfs replacement by using
> root=/dev/ram0 to tell the kernel to load the initramfs as a ramdisk.

Sorry, I'm on vacation now.

May I ask what's your detailed use cases?  Sure, you could use
/dev/ram0 as a replacement, but currently it still takes double
memory compared with initramfs since ramdisk doesn't support FSDAX
for now (by enabling FSDAX, it won't take double memory at all.)

Actually I think ramdisk FSDAX is useful and I might sync up this on
the following LSF/MM/BPF 2023.

> However, by using a ramdisk instead of the usual compressed cpio, I
> would lose the feature where the kernel merges multiple individual
> cpios together into a single tmpfs filesystem. Looking at the
> documentation for erofs, I noticed that erofs already seems to support
> merging multiple erofs filesystems on separate block devices using the
> device= cmdline option. Would it be possible to extend this so that
Here `device=` is actually used to refer to seperate blobs with the
merged metadata.  For example, you could have

   device=/dev/ram1 original tar1
   device=/dev/ram2 original tar2
   /dev/ram0        merged metadata for tar1 + tar2.

which means, if you'd like to merge multiple EROFS filesystems, you
might need another step to build a merged metadata in advance in order
to merges multiple individual tarballs together, which could be built
when applying images or booting (by using a special bootloader with
such functionality.)

EROFS doesn't support stacking multiple fses runtimely since it seems
a duplicated feature of overlayfs (you could consider using overlayfs
honestly.)

> multiple erofs filesystems that follow each other on the same block
> device can also be merged? This would allow me to pass multiple erofs
> filesystems to the kernel via initrd=, which would get concatenated
> together into a single buffer, which the kernel would write to a
> ramdisk (using root=/dev/ram0) which the kernel would then have erofs
> mount to /dev/root. erofs would notice that there's multiple erofs
> filesystems on the ramdisk and overlay them together (perhaps only if
> a cmdline option is enabled).

Recently, A merged EROFS filesystem with a single block device can
be passed but you might still need a step to build a merged fs tree
before mounting.  Such feature is used to build a metadata and
reuse original tar blobs.

> 
> Does this make sense at all?

Hopefully it helps.

Thanks,
Gao Xiang

> 
> Cheers,
> 
> Daan De Meyer
