Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C70D99176E
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Oct 2024 16:41:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XLSlp5mbFz3bdW
	for <lists+linux-erofs@lfdr.de>; Sun,  6 Oct 2024 00:41:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728139284;
	cv=none; b=hsf4LmxrlHTbbyZ4aFTPuxGv+7MJPFuXwGlCupTMhV50dixk3m4Y0/3NNhDOvngwSUxPVRPp8pmt/sVTi0fqpNDLGuWYGrJL8nbAUJpWtHm9dOz/iQ/HftvuoDfhuvmUAVNwJreItx0rzv5E9iJxDd2dSkDRwCEB5H1HFxDK/bAbP1vgfUCZKvi62i6KOiCPE6ZeIZpalWOsyx6tq/fVp9WudnAA0wuWUKXVKJPmyyYrHUBUm+r73cp460o+QUL3DD8aro98XfapEpYf0K5EuTXjn5uLOrp/3Df2/m9fkezLOy9lBCX+E/HqjNV6L7kOMgdPQ2niQZ5r1AUqLfliMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728139284; c=relaxed/relaxed;
	bh=gCbXyy0cblcXk7UDUVtGH5kGEQ3mspdwjmhYqK8wCyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IYA28PDYCG/XITCTI3vZSRqGBmva2ZLTBG4V5lVotzZYKicJTVBySzij5l6W9sqysKqhirYuBUUJ0QzEpjpeSoBnrwX5o4K4yLDrznQk4vyEdY+fvVFT96vh07r2p30PRam09T8kTFaRLcsqRqqmwlRUxs3I1EeseNPM5b7/4/LZfTE9Lkk70xHhVZ6jblipbzArZ0w9HDgHwpAbn9+R5HdclIfQzyxGSPdZQA9qQhd6f6wQBs5iOM5ylq5VQpUb3c7ZdiPAv/uvvbULla0moO1u+256AF14pCaDiQuFtsAoefjG+P3Dt/5BBJqNRhifh9Uo7BRaUd2/p+fLdpBx3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=EjWo5t/a; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=EjWo5t/a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XLSlh3yf9z2xjM
	for <linux-erofs@lists.ozlabs.org>; Sun,  6 Oct 2024 00:41:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728139273; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gCbXyy0cblcXk7UDUVtGH5kGEQ3mspdwjmhYqK8wCyo=;
	b=EjWo5t/amdmygQ1UQBlKoOnIxC/3B51oMeoAmhVVWl15MyMmdklP2zXbocl3/xp3EPiSn8C8el3ooU6T029RjJqYy2EwuNqbh1XQpl1GE+VHUIecawMXUAsW3CVQwDVDotsya4kbjWy/Q0R2W/gFKf9Yaezj5nnjFKVavGOaI5I=
Received: from 192.168.2.29(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGHfK9X_1728139270)
          by smtp.aliyun-inc.com;
          Sat, 05 Oct 2024 22:41:11 +0800
Message-ID: <bb781cf6-1baf-4a98-94a5-f261a556d492@linux.alibaba.com>
Date: Sat, 5 Oct 2024 22:41:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Incorrect error message from erofs "backed by file" in 6.12-rc
To: Allison Karlitskaya <allison.karlitskaya@redhat.com>,
 Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
References: <CAOYeF9VQ8jKVmpy5Zy9DNhO6xmWSKMB-DO8yvBB0XvBE7=3Ugg@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAOYeF9VQ8jKVmpy5Zy9DNhO6xmWSKMB-DO8yvBB0XvBE7=3Ugg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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

Hi Allison,

(try to +Cc Christian)

On 2024/10/2 20:58, Allison Karlitskaya wrote:
> hi,
> 
> In context of my work on composefs/bootc I've been testing the new support for directly mounting files with erofs (ie: without a loopback device) and it's working well.  Thanks for adding this feature --- it's a huge quality of life improvement for us.
> 
> I've observed a strange behaviour, though: when mounting a file as an erofs, if you read() the filesystem context fd, you always get the following error message reported: Can't lookup blockdev.
> 
> That's caused by the code in erofs_fc_get_tree() trying to call get_tree_bdev() and recovering from the error in case it was ENOTBLK and CONFIG_EROFS_FS_BACKED_BY_FILE.  Unfortunately, get_tree_bdev() logs the error directly on the fs_context, so you get the error message even on successful mounts.
> > It looks something like this at the syscall level:
> 
> fsopen("erofs", FSOPEN_CLOEXEC)         = 3
> fsconfig(3, FSCONFIG_SET_FLAG, "ro", NULL, 0) = 0
> fsconfig(3, FSCONFIG_SET_STRING, "source", "/home/lis/src/mountcfs/cfs", 0) = 0
> fsconfig(3, FSCONFIG_CMD_CREATE, NULL, NULL, 0) = 0
> fsmount(3, FSMOUNT_CLOEXEC, 0)          = 5
> move_mount(5, "", AT_FDCWD, "/tmp/composefs.upper.KuT5aV", MOVE_MOUNT_F_EMPTY_PATH) = 0
> read(3, "e /home/lis/src/mountcfs/cfs: Can't lookup blockdev\n", 1024) = 52
> 
> This is kernel 6.12.0-0.rc0.20240926git11a299a7933e.13.fc42.x86_64 from Fedora Rawhide.
> 
> It's a pretty minor issue, but it sent me on a wild goose chase for an hour or two, so probably it should get fixed before the final release.
> 

Sorry for late response. I'm on vacation recently.

Yes, I also observed this message, but I'm not sure
how to handle it better.  Indeed, the message itself
is out of get_tree_bdev() as you said.

Yet I tend to avoid unnecessary extra lookup_bdev()
likewise to confirm the type of the source in advance,
since the majority mount type of EROFS is still
bdev-based instead file-based so I tend to make
file-based mount as a fallback...

Hi Christian, if possible, could you give some other
idea to handle this case better? Many thanks!

Thanks,
Gao Xiang

> Thanks again for this awesome feature!
> 
> Allison Karlitskaya

