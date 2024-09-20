Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1918A97DAAE
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Sep 2024 01:02:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X9SZV28XQz2yVj
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Sep 2024 09:02:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726873324;
	cv=none; b=U5HZx4GtukrGOcKSOqTBPHZNASMYaR1XBZW1RfjyFv9DadNaKUICtMm4S2/qZb3pQR7dRlVPvSAyunJHXuXQ2+aQ7jB6BFygIsfhdZIqY/rUAGPgzCgv59jrEBKT0tFthyfivt2Bbz8d1R6KfV2TQmsYXQ3n649lmWHhK7rSeYolGHTPO6SLwmVy4tFmuyHPXgI/BD8eicQ6M5MOYnxvofLW6KrDVe/2EC+HC30+4f+DOZ835xWJ8JNx3uvZiSyKkONDKNv3+pfXjCpefy9y2ZZ/ta2EdXyK2Z9aZ34irJ+9jcQaoBc75GgLIh3aIM/FpwGzFoUoe6JumFlUvyjpLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726873324; c=relaxed/relaxed;
	bh=ibNj52UzkWaMXY9PLe6xYLJWrrrRMHk7/f/yzGJOKw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Rt5Jlkgdp5YkGZDOnhH62pJpjLzD8VA47c6Mk41skI+IWpd08oBlWmgT5IqTYJU6de3HkOAVW+1aMOSAD0ev96B9MGgJxU9lXmKyvkggcRq7mqoKvrPyZvl3nys/X8oEGdDWmBnRqQrsE2k0g60tjDu9ir5KpfLnTnrY6McmKuyYJ8QqaqMKxdrLc/NWm5G7OJvM8PWj5UqqnLN0nDqEFkgJSwY6iiVf+bIzuX+6mX62p25uAqNFVypJs2SZGXLTIFtZ3r+6hA8ducC16g3KEB1v4bbh3gi/WyhmxoI7QKT+nSRFhdvHCKooh9nrzoNG/TvZv+lip30gkocPeImFNg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xQGqG6Xg; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xQGqG6Xg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X9SZK4b99z2xps
	for <linux-erofs@lists.ozlabs.org>; Sat, 21 Sep 2024 09:01:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726873314; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ibNj52UzkWaMXY9PLe6xYLJWrrrRMHk7/f/yzGJOKw4=;
	b=xQGqG6XgpVwuJdrhlE/hc3yqgvT9e3J+PZHfyJe9oWF6L2j53XvR4s0P/+gE2x5DYa39+5tvFmKzYxhMqYmVb4zHFoKi6m+BpkkH5oMLAG4uiO7it3ewNcCwzSmcPqpGArIknc9NaIF84ipwUHRqamH7GdxNWO6HAkptQZQNsHA=
Received: from 30.244.151.63(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFMK13M_1726873311)
          by smtp.aliyun-inc.com;
          Sat, 21 Sep 2024 07:01:52 +0800
Message-ID: <e8f84ef3-0c4e-4341-b562-d9e8c2624e4b@linux.alibaba.com>
Date: Sat, 21 Sep 2024 07:01:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Help with EROFS for specific test scenario
To: Fred Lotter <fred.lotter@canonical.com>, linux-erofs@lists.ozlabs.org
References: <CA+yndwhjTkF_D1QZ3UDLggAXXGen_fLr6rLvBVS8tYw3ViH+8Q@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CA+yndwhjTkF_D1QZ3UDLggAXXGen_fLr6rLvBVS8tYw3ViH+8Q@mail.gmail.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


Hi Fred,

On 2024/9/21 00:11, Fred Lotter wrote:
> Hi,
> 
> In the context of this page:
> https://erofs.docs.kernel.org/en/latest/merging.html <https://erofs.docs.kernel.org/en/latest/merging.html>
> 
> I am trying to experiment with EROFS where I want to try something crazy like the following setup:
> 
> /dev/mmcblk0p3:
> |
> EROFS root image
> |
> --------
> |
> EROFS second image
> |
> --------
> 
> I wanted to have a primate root EROFS filesystem written at the start of a partition. Then I would like to "append" files to the immutable root EROFS filesystem, by adding a concatenated EROFS filesystem after the root filesystem, with an external device reference pointing to the root EROFS filesystem.

Thanks for your question.

> 
> My idea in my head was then to boot the Linux kernel with something like:
> 
> root=/dev/mmcblk0p3 rootfstype=erofs rootoptions=device=/dev/mmcblk0p3,offset=<root size>
> 
> 1. Is it possible to have the "blobdevice" point to a complete EROFS filesystem?

If there are two partitions, currently EROFS kernel runtime supports
your requirement in practice, for example:

  /dev/mmcblk0p3:
  |
  EROFS root image
  |
  -------- /dev/mmcblk0p4:
  |
  EROFS second image
  |
  --------

You could boot with:
root=/dev/mmcblk0p4 rootfstype=erofs rootoptions=device=/dev/mmcblk0p3

to get the incremental filesystem and use:

root=/dev/mmcblk0p3 rootfstype=erofs

to boot the original filesystem.

The two images are both usable for booting.

The `offset` option is only supported by the loop device, and parsed by
util-linux `mount` command, as in:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/block/loop.c?h=v6.11#n52

So if you'd like to use the same partition, I guess it's still possible
as long as you have a minimal initramfs to generate a special loop
device with a specific offset, like:

losetup -ooffset=<root size> /dev/loop0 /dev/mmcblk0p3
mount -odevice=/dev/mmcblk0p3 /dev/loop0 /

for example.  I'm not sure if it meets your requirement.

In short, the on-disk format supports your requirement, and
kernel runtime supports your requirement too, but just with
two independent devices (or loop devices with `offset`).

I'm not sure EROFS modules needs to support `offset`
semantics since other filesystems don't support this too.

> 
> 2. If yes, is there userspace support for creating this setup?

Unfortunately, currently mkfs.erofs incremental build doesn't
support this mode, but it can be implemented in the next
erofs-utils 1.9 version.

Thanks,
Gao Xiang

> 
> Kind Regards,
> Fred
> 
> 
> 
> 

