Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB77914DCE
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Jun 2024 14:58:57 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=w4dGT0Gx;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W77M23z3Pz3cXH
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Jun 2024 22:58:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=w4dGT0Gx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W77Lx34gBz30Vs
	for <linux-erofs@lists.ozlabs.org>; Mon, 24 Jun 2024 22:58:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719233922; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lVIWYWEN2qIAku3JaojT66eoQjBhzdiz1tVDHkwyM3Q=;
	b=w4dGT0GxZY5gztjUUPan67nt8EfCF8hsmSIL4VnfEwY2HGEKAiUOCQHGP57IHuzeCHKN9WeGdfMko1RYdoji2iyThsscnGpMoM3dbwzvBIX+Ytw1FOg0F6gh4dbi0UZSPhmZ5Q7a7FK0um2/CwvLaKCanQB3vplF3nd4OBbPf7c=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W9AJGfV_1719233920;
Received: from 192.168.3.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W9AJGfV_1719233920)
          by smtp.aliyun-inc.com;
          Mon, 24 Jun 2024 20:58:41 +0800
Message-ID: <c7b280a7-c7b6-473f-8c55-65d09548b3b6@linux.alibaba.com>
Date: Mon, 24 Jun 2024 20:58:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cachefiles: support query cachefiles ondemand feature
To: Hongbo Li <lihongbo22@huawei.com>, xiang@kernel.org, chao@kernel.org,
 huyue2@coolpad.com, jefflexu@linux.alibaba.com, dhavale@google.com,
 dhowells@redhat.com
References: <20240621061808.1585253-1-lihongbo22@huawei.com>
 <20240621061808.1585253-3-lihongbo22@huawei.com>
 <c4748d68-b61f-4935-815b-f4d3af77f890@linux.alibaba.com>
 <1fe0f4e5-37b0-4bbd-bcd3-9764f65660e8@huawei.com>
 <f148e340-26c5-44ce-887f-076c2c76137c@linux.alibaba.com>
 <88888ec4-1e45-477a-8084-2c122c0bfda2@linux.alibaba.com>
 <3f542dc9-2686-43af-a915-2bfede803771@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <3f542dc9-2686-43af-a915-2bfede803771@huawei.com>
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
Cc: netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/6/24 19:58, Hongbo Li wrote:
> 
> 
> On 2024/6/21 18:42, Gao Xiang wrote:
>> Hi,
>>
>> On 2024/6/21 18:06, Gao Xiang wrote:
>>>
>>>
>>> On 2024/6/21 17:37, Hongbo Li wrote:
>>>>
>>>>
>>>> On 2024/6/21 17:14, Gao Xiang wrote:
>>>>>
>>>>>
>>>>> On 2024/6/21 14:18, Hongbo Li wrote:
>>>>>> Erofs over fscache need CONFIG_CACHEFILES_ONDEMAND in cachefiles
>>>>>> module. We cannot know whether it is supported from userspace, so
>>>>>> we export this feature to user by sysfs interface.
>>>>>>
>>>>>> [Before]
>>>>>> $ cat /sys/fs/cachefiles/features/cachefiles_ondemand
>>>>>> cat: /sys/fs/cachefiles/features/cachefiles_ondemand: No such file or directory
>>>>>>
>>>>>> [After]
>>>>>> $ cat /sys/fs/cachefiles/features/cachefiles_ondemand
>>>>>> supported
>>>>>>
>>>>>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>>>>>
>>>>> I don't think such sysfs is needed, you could just use
>>>>> `bind ondemand` to check if it is supported:
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/cachefiles/daemon.c?h=v6.9#n780
>>>>>
>>>> Thanks for reply!
>>>> `bind ondemand` can check if it is supported, but it requires a more complicated procedure for user to implement. For example, a serial of system call (open, ioctl, close) are need.The containerd snapshotter daemon relies on these feature, only use a simple check method is usable in product environment. The snapshotter developers may know how cachefiles works, but for snapshotter users, a simple way to check whether snapshotter can be launched is useful. Even though they do not know how cachefiles works.
>>>
>>> I don't think it needs to be considered as long as userspace
>>> has a way to check since you could wrap up these as a helper
>>> (I will do in the official erofs-utils later or if you have
>>> some interest you could help too) and even some erofs-utils
>>> binary for this.
>>>
>>> sysfs maintainence just for some random feature doesn't
>>> sound good to me (similar to ext4/xfs on-disk features) and
>>> even if works, you cannot use this way for 5.19~6.10
>>> upstream kernels.
>>
>> Anyway, I know userspace folks always would like to have a
>> simple kernel way to check if a feature is supported for a
>> kernel, but (many years later) my current thought is that
>> the simplist way to check this is to introduce a simple
>> helper to try.  You cannot list every kernel features you
>> concerned as some sysfs file and in time properly, or you
>> could cause some inconsistency.
>>
>> Anyway, that is my personal thought, having another detailed
>> list for all features users care about along with the real
>> implementaions seems unnecessary.
> Thanks for explaining!
> Maybe the way of showing the features in erofs now seems not
> quite reasonable. It only output the "supported" string from
> sysfs. What suggestions do you have for this?

As I said, just using "bind ondemand" and "mount fsid" to check
if erofs over fscache is supported is enough.

If userspace folks don't like the internals, these logic could
be wrapped up in erofs-utils or whatever libraries.

Thanks,
Gao Xiang

> 
> Thanks,
> Hongbo
>>
>> Thanks,
>> Gao Xiang
