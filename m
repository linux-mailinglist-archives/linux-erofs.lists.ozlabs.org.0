Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A297397E448
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Sep 2024 02:00:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XBjmL69zHz2yPM
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Sep 2024 10:00:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727049598;
	cv=none; b=jOFC2vSidYLJ80rK21VSp4BG2o5VNRINlnZp4HngaV31AqA2SyKI405rRYxJnEPBODWqRYKASZhjyp6dcyNzpk0Pv1bMpVyCnewy4yv8pzDVq0NUoB4Rglu6sQkLrl/mJ6A+ib4Lmes4xjThqaiiTGB07PZc4gVf7SnwV7pb3TtMd0tE1wSynsvhMl1xTK4spc6+AfSR3XxSQKOZC2NfYLxjWKA8aRMw5DeShYbYyikHPrS0I53+y2xPmNZekEvWI9FiFwLu4KFgXB8pFQyiAnJb3Sc99AekPdzRz3FK1koMH7LX0ItSit37XoaF48d5HAPfnqku7+97ZF9E9v0Giw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727049598; c=relaxed/relaxed;
	bh=AvU4Ob6gdREXCTABfXLCLBGeZMlKHvEviddTvagoF/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V1kd++/bs414mywihX1JmD2tgqG80rn6k9uJUgxuiTYnVOV2yT/Z0MTmoDoHRm6qwA7qthankj//hPpwk3D/SS42F3xX4YJUvMymzob3vQNBo0QYrD4vcnOuzbZZmBvu7UwNpVFgEto4TSgRQLcR9Tx5EKQ3GpNYOhY5f7CW5rC6oZJkQyMGlEYv1SIlLf7OuQ2MI1eYxdrxIRfXk2bFSzCxCY1dPWZ448MwEo7t4ht4nF/W6CMDUOMtH6Sldviu5t7R8pjtV8A1MFi8LYJ6BUwowaQ5zqGA4unm27bf49MCRzBMjYlkKBl8FD5DoeU72S82VKesZQdQDgS0tXZJXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=k4vY7Mcs; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=k4vY7Mcs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XBjmC2TSyz2xMQ
	for <linux-erofs@lists.ozlabs.org>; Mon, 23 Sep 2024 09:59:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727049584; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=AvU4Ob6gdREXCTABfXLCLBGeZMlKHvEviddTvagoF/8=;
	b=k4vY7McsxzDSj4SFrZXqDcQwbUBiSv4PiSBaZWoyL4AqouK4gNUGbGgygtMBsS81C3YDgtxyEF6EJGQMNjWGXX1q3ffrNK7ZDcHM+PyDUIx1Mp00ozTHa51U0hGMeSkytqCiySFfs1wWHQz1xUsvnwCl3epHqp4kaNLFf9xNMPQ=
Received: from 30.27.108.50(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFRV3dn_1727049579)
          by smtp.aliyun-inc.com;
          Mon, 23 Sep 2024 07:59:43 +0800
Message-ID: <a2336b02-1978-4cf3-aae5-cf8ea51aaee5@linux.alibaba.com>
Date: Mon, 23 Sep 2024 07:59:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Help with EROFS for specific test scenario
To: Fred Lotter <fred.lotter@canonical.com>
References: <CA+yndwhjTkF_D1QZ3UDLggAXXGen_fLr6rLvBVS8tYw3ViH+8Q@mail.gmail.com>
 <e8f84ef3-0c4e-4341-b562-d9e8c2624e4b@linux.alibaba.com>
 <CA+yndwgoF3S3k9FUY01kjAc6VyBxfVz6wiBs3M+RkhdXk+pzrQ@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CA+yndwgoF3S3k9FUY01kjAc6VyBxfVz6wiBs3M+RkhdXk+pzrQ@mail.gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/9/22 15:24, Fred Lotter wrote:
> Hi Gao,
> 
> On Sat, Sep 21, 2024 at 1:02 AM Gao Xiang <hsiangkao@linux.alibaba.com <mailto:hsiangkao@linux.alibaba.com>> wrote:
> 
> 
>     Hi Fred,
> 
>     On 2024/9/21 00:11, Fred Lotter wrote:
>      > Hi,
>      >
>      > In the context of this page:
>      > https://erofs.docs.kernel.org/en/latest/merging.html <https://erofs.docs.kernel.org/en/latest/merging.html> <https://erofs.docs.kernel.org/en/latest/merging.html <https://erofs.docs.kernel.org/en/latest/merging.html>>
>      >
>      > I am trying to experiment with EROFS where I want to try something crazy like the following setup:
>      >
>      > /dev/mmcblk0p3:
>      > |
>      > EROFS root image
>      > |
>      > --------
>      > |
>      > EROFS second image
>      > |
>      > --------
>      >
>      > I wanted to have a primate root EROFS filesystem written at the start of a partition. Then I would like to "append" files to the immutable root EROFS filesystem, by adding a concatenated EROFS filesystem after the root filesystem, with an external device reference pointing to the root EROFS filesystem.
> 
>     Thanks for your question.
> 
> 
> Thank you for your quick assistance. My final round of questions hopefully!
> 
> 
>      >
>      > My idea in my head was then to boot the Linux kernel with something like:
>      >
>      > root=/dev/mmcblk0p3 rootfstype=erofs rootoptions=device=/dev/mmcblk0p3,offset=<root size>
>      >
>      > 1. Is it possible to have the "blobdevice" point to a complete EROFS filesystem?
> 
>     If there are two partitions, currently EROFS kernel runtime supports
>     your requirement in practice, for example:
> 
>        /dev/mmcblk0p3:
>        |
>        EROFS root image
>        |
>        -------- /dev/mmcblk0p4:
>        |
>        EROFS second image
>        |
>        --------
> 
>     You could boot with:
>     root=/dev/mmcblk0p4 rootfstype=erofs rootoptions=device=/dev/mmcblk0p3
> 
>     to get the incremental filesystem and use:
> 
>     root=/dev/mmcblk0p3 rootfstype=erofs
> 
>     to boot the original filesystem.
> 
>     The two images are both usable for booting.
> 
> 
> This is still an interesting case for me, even if it has to be two explicit partitions.
> 
> In the case of the external device pointing to a complete EROFS filesystem.
> 
> Quoting from the documentation:
> "There are no centralized inode and directory tables because they are not quite friendly for image incremental
> updates, metadata flexibility, and extensibility. It’s up to users whether inodes or directories are arranged one
> by one or not."
> 
> Does this mean with the current kernel implementation that the super erofs filesystem (containing a link to the
> external erofs) can point to the original erofs filesystem, and only discover its contents at runtime? This would
> allow me to mkfs.erofs a super erofs filesystem, without knowing anything about the external device content
> at creation time?

The incremental filesystem uses the new on-disk superblock
which is specified by users (e.g. /dev/mmcblk0p4).  But it
will reuse the old inodes or directories metadata in
/dev/mmcblk0p3 if no changes.

I'm not sure if autometicly discovery is needed, since the
original design you could just reuse /dev/mmcblk0p3 to
mount the original filesystem.  In order to
implement autometicly discovery, either you need a modified
original superblock or a full scan of all external devices..

Or if your use cases is just like squashfs incremental use
cases (you don't need to mount the original image anymore)?
but just would like to leave incremental data in an external
device?  That is also supported by EROFS on-disk format, so
I wonder your use cases though.

> 
> 
>     The `offset` option is only supported by the loop device, and parsed by
>     util-linux `mount` command, as in:
>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/block/loop.c?h=v6.11#n52 <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/block/loop.c?h=v6.11#n52>
> 
>     So if you'd like to use the same partition, I guess it's still possible
>     as long as you have a minimal initramfs to generate a special loop
>     device with a specific offset, like:
> 
>     losetup -ooffset=<root size> /dev/loop0 /dev/mmcblk0p3
>     mount -odevice=/dev/mmcblk0p3 /dev/loop0 /
> 
>     for example.  I'm not sure if it meets your requirement.
> 
>     In short, the on-disk format supports your requirement, and
>     kernel runtime supports your requirement too, but just with
>     two independent devices (or loop devices with `offset`).
> 
>     I'm not sure EROFS modules needs to support `offset`
>     semantics since other filesystems don't support this too.
> 
>      >
>      > 2. If yes, is there userspace support for creating this setup?
> 
>     Unfortunately, currently mkfs.erofs incremental build doesn't
>     support this mode, but it can be implemented in the next
>     erofs-utils 1.9 version.
> 
> 
> Is this a feature you plan to add in v1.9 in any case?

Yes.

> 
> 
>     Thanks,
>     Gao Xiang
> 
>      >
>      > Kind Regards,
>      > Fred
>      >
> 
> 
> I read some discussions on erofs verification:
> https://lore.kernel.org/lkml/Y69UjZP4dNYdbXW0@sol.localdomain/T/ <https://lore.kernel.org/lkml/Y69UjZP4dNYdbXW0@sol.localdomain/T/>
> 
> My impression is that dm-verity should work for EROFS filesystems today, in the same way it works with Squashfs.
> 
> However, I guess this would not work if the erofs super block device has a device table pointing to external block devices (erofs)?

I think you could just enable dm-verity seperately for
each device in advance (and check if the root hash of
each device is expected), which is transparentto EROFS.

Thanks,
Gao Xiang

