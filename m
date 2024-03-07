Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A853874AA6
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Mar 2024 10:20:23 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=TmFxMohW;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Tr3g86Sknz3dXT
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Mar 2024 20:20:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=TmFxMohW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tr3g40KHCz3dCH
	for <linux-erofs@lists.ozlabs.org>; Thu,  7 Mar 2024 20:20:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709803210; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4QBG2QheUKTY1OnbPSDP0o85jjGq1EgwtF8LIisWhmc=;
	b=TmFxMohWx6YFLdBkADbcek1+Md9sKmaNfWafWw3MZX2lTgg5q9wYrSPhtiDj8NH+hXP0odKroUUbsxLsC1Hzz8heExyAl5YXsO/o5TildRrxSVcExRH01fu9zgnM3hBvevhMMIpjAW8Gpifh4+r6yp/Trm4cuKyEAI3Cr9MduAw=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W2-5tED_1709803206;
Received: from 30.97.48.224(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W2-5tED_1709803206)
          by smtp.aliyun-inc.com;
          Thu, 07 Mar 2024 17:20:07 +0800
Message-ID: <50205009-07e6-4e7e-9ac5-e6d04e12e62d@linux.alibaba.com>
Date: Thu, 7 Mar 2024 17:20:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix lockdep false positives on initializing
 erofs_pseudo_mnt
To: Christian Brauner <brauner@kernel.org>
References: <20240307024459.883044-1-libaokun1@huawei.com>
 <f9e30004-6691-4171-abc5-7e286d9ccec6@linux.alibaba.com>
 <7e262242-d90d-4f61-a217-f156219eaa4d@linux.alibaba.com>
 <38934cc4-58da-47b4-a120-00a2f3a56836@linux.alibaba.com>
 <20240307-segmentieren-sitzkissen-5086f5e1f99f@brauner>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240307-segmentieren-sitzkissen-5086f5e1f99f@brauner>
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
Cc: chengzhihao1@huawei.com, yangerkun@huawei.com, linux-kernel@vger.kernel.org, huyue2@coolpad.com, Al Viro <viro@zeniv.linux.org.uk>, yukuai3@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Christian,

On 2024/3/7 17:17, Christian Brauner wrote:
> On Thu, Mar 07, 2024 at 12:18:52PM +0800, Gao Xiang wrote:
>> Hi,
>>
>> (try to +Cc Christian and Al here...)
>>
>> On 2024/3/7 11:41, Jingbo Xu wrote:
>>> Hi Baokun,
>>>
>>> Thanks for catching this!
>>>
>>>
>>> On 3/7/24 10:52 AM, Gao Xiang wrote:
>>>> Hi Baokun,
>>>>
>>>> On 2024/3/7 10:44, Baokun Li wrote:
>>>>> Lockdep reported the following issue when mounting erofs with a
>>>>> domain_id:
>>>>>
>>>>> ============================================
>>>>> WARNING: possible recursive locking detected
>>>>> 6.8.0-rc7-xfstests #521 Not tainted
>>>>> --------------------------------------------
>>>>> mount/396 is trying to acquire lock:
>>>>> ffff907a8aaaa0e0 (&type->s_umount_key#50/1){+.+.}-{3:3},
>>>>>                           at: alloc_super+0xe3/0x3d0
>>>>>
>>>>> but task is already holding lock:
>>>>> ffff907a8aaa90e0 (&type->s_umount_key#50/1){+.+.}-{3:3},
>>>>>                           at: alloc_super+0xe3/0x3d0
>>>>>
>>>>> other info that might help us debug this:
>>>>>     Possible unsafe locking scenario:
>>>>>
>>>>>           CPU0
>>>>>           ----
>>>>>      lock(&type->s_umount_key#50/1);
>>>>>      lock(&type->s_umount_key#50/1);
>>>>>
>>>>>     *** DEADLOCK ***
>>>>>
>>>>>     May be due to missing lock nesting notation
>>>>>
>>>>> 2 locks held by mount/396:
>>>>>     #0: ffff907a8aaa90e0 (&type->s_umount_key#50/1){+.+.}-{3:3},
>>>>>               at: alloc_super+0xe3/0x3d0
>>>>>     #1: ffffffffc00e6f28 (erofs_domain_list_lock){+.+.}-{3:3},
>>>>>               at: erofs_fscache_register_fs+0x3d/0x270 [erofs]
>>>>>
>>>>> stack backtrace:
>>>>> CPU: 1 PID: 396 Comm: mount Not tainted 6.8.0-rc7-xfstests #521
>>>>> Call Trace:
>>>>>     <TASK>
>>>>>     dump_stack_lvl+0x64/0xb0
>>>>>     validate_chain+0x5c4/0xa00
>>>>>     __lock_acquire+0x6a9/0xd50
>>>>>     lock_acquire+0xcd/0x2b0
>>>>>     down_write_nested+0x45/0xd0
>>>>>     alloc_super+0xe3/0x3d0
>>>>>     sget_fc+0x62/0x2f0
>>>>>     vfs_get_super+0x21/0x90
>>>>>     vfs_get_tree+0x2c/0xf0
>>>>>     fc_mount+0x12/0x40
>>>>>     vfs_kern_mount.part.0+0x75/0x90
>>>>>     kern_mount+0x24/0x40
>>>>>     erofs_fscache_register_fs+0x1ef/0x270 [erofs]
>>>>>     erofs_fc_fill_super+0x213/0x380 [erofs]
>>>>>
>>>>> This is because the file_system_type of both erofs and the pseudo-mount
>>>>> point of domain_id is erofs_fs_type, so two successive calls to
>>>>> alloc_super() are considered to be using the same lock and trigger the
>>>>> warning above.
>>>>>
>>>>> Therefore add a nodev file_system_type named erofs_anon_fs_type to
>>>>> silence this complaint. In addition, to reduce code coupling, refactor
>>>>> out the erofs_anon_init_fs_context() and erofs_kill_pseudo_sb() functions
>>>>> and move the erofs_pseudo_mnt related code to fscache.c.
>>>>>
>>>>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>>>>
>>>> IMHO, in the beginning, I'd like to avoid introducing another fs type
>>>> for erofs to share (meta)data between filesystems since it will cause
>>>> churn, could we use some alternative way to resolve this?
>>>
>>> Yeah as Gao Xiang said, this is initially intended to avoid introducing
>>> anothoer file_system_type, say erofs_anon_fs_type.
>>>
>>> What we need is actually a method of allocating anonymous inode as a
>>> sentinel identifying each blob.  There is indeed a global mount, i.e.
>>> anon_inode_mnt, for allocating anonymous inode/file specifically.  At
>>> the time the share domain feature is introduced, there's only one
>>> anonymous inode, i.e. anon_inode_inode, and all the allocated anonymous
>>> files are bound to this single anon_inode_inode.  Thus we decided to
>>> implement a erofs internal pseudo mount for this usage.
>>>
>>> But I noticed that we can now allocate unique anonymous inodes from
>>> anon_inode_mnt since commit e7e832c ("fs: add LSM-supporting anon-inode
>>> interface"), though the new interface is initially for LSM usage.
>>
>> Yes, as summary, EROFS now maintains a bunch of anon inodes among
>> all different filesystem instances, so that like
>>
>> blob sharing or
>> page cache sharing across filesystems can be done.
>>
>> In brief, I think the following patch is a good idea but it
>> hasn't been landed until now:
>> https://lore.kernel.org/r/20210309155348.974875-3-hch@lst.de
>>
>> Other than that, is it a good idea to introduce another fs type
>> (like erofs_anon_fs_type) for such usage?
> 
> It depends. If you're allocating a lot of inodes then having a separate
> filesystem type for erofs makes sense. If it's just a few then it
> probably doesn't matter. If you need custom inode operations for these
> anonymous inodes then it also makes sense to have a separate filesystem
> type.

Yeah, I think some time this year we will finish a formal
page cache sharing design and implementation for both bdev
and fscache mode.

So a separate filesystem type seems more reasonable in the
future,  thanks for your confirmation!

Thanks,
Gao Xiang
