Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6768746CD
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Mar 2024 04:31:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1709782291;
	bh=iYFOllAuOcUfaX+FmOYbqRJCEteOg9veh7T9Yz+e6sw=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=djFCJMtY+asdzMVJAFATrS4n3Xc6kpPyLFhi0Fd5+01/dbdzI+VUCIJ5m+/RumLmk
	 R2YXxpZI1M7c0wefu0al7F1wXn6R7qUEPYUPnDIKxSG8gOPrv78b78n90dO0z6AG1o
	 B5iJvi/Q2GNsHctSCjGmBhu68X+rJPcH9k4kxEJhNxDJkzXHL+tL4BcC2NWV2YMgvx
	 UGT9/YKoRk6TjNwzv2DodCgoKTGqUiy5RHcab6ZZknQMelN4+N+c38MmeVEvtZuj8y
	 17Lzer+Q+JjSW0quR/w7IbF6tkwnT2Gd8JYtFW1VKwvXUTueb3hre7AC2CD/ZMTZRn
	 eOBnDx9LnJy3w==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Tqvwg0tJTz3dT8
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Mar 2024 14:31:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=libaokun1@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TqvwZ2jcHz3bsw
	for <linux-erofs@lists.ozlabs.org>; Thu,  7 Mar 2024 14:31:23 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TqvwF0TKXz1FJCs;
	Thu,  7 Mar 2024 11:31:09 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id E8B98180062;
	Thu,  7 Mar 2024 11:31:17 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 11:31:17 +0800
Message-ID: <7e9a15b9-f841-a7d4-7f72-7aee9cefb0f0@huawei.com>
Date: Thu, 7 Mar 2024 11:31:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] erofs: fix lockdep false positives on initializing
 erofs_pseudo_mnt
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
References: <20240307024459.883044-1-libaokun1@huawei.com>
 <f9e30004-6691-4171-abc5-7e286d9ccec6@linux.alibaba.com>
In-Reply-To: <f9e30004-6691-4171-abc5-7e286d9ccec6@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500021.china.huawei.com (7.185.36.21)
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
From: Baokun Li via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Baokun Li <libaokun1@huawei.com>
Cc: yangerkun@huawei.com, linux-kernel@vger.kernel.org, huyue2@coolpad.com, yukuai3@huawei.com, chengzhihao1@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Xiang,

On 2024/3/7 10:52, Gao Xiang wrote:
> Hi Baokun,
>
> On 2024/3/7 10:44, Baokun Li wrote:
>> Lockdep reported the following issue when mounting erofs with a 
>> domain_id:
>>
>> ============================================
>> WARNING: possible recursive locking detected
>> 6.8.0-rc7-xfstests #521 Not tainted
>> --------------------------------------------
>> mount/396 is trying to acquire lock:
>> ffff907a8aaaa0e0 (&type->s_umount_key#50/1){+.+.}-{3:3},
>>                         at: alloc_super+0xe3/0x3d0
>>
>> but task is already holding lock:
>> ffff907a8aaa90e0 (&type->s_umount_key#50/1){+.+.}-{3:3},
>>                         at: alloc_super+0xe3/0x3d0
>>
>> other info that might help us debug this:
>>   Possible unsafe locking scenario:
>>
>>         CPU0
>>         ----
>>    lock(&type->s_umount_key#50/1);
>>    lock(&type->s_umount_key#50/1);
>>
>>   *** DEADLOCK ***
>>
>>   May be due to missing lock nesting notation
>>
>> 2 locks held by mount/396:
>>   #0: ffff907a8aaa90e0 (&type->s_umount_key#50/1){+.+.}-{3:3},
>>             at: alloc_super+0xe3/0x3d0
>>   #1: ffffffffc00e6f28 (erofs_domain_list_lock){+.+.}-{3:3},
>>             at: erofs_fscache_register_fs+0x3d/0x270 [erofs]
>>
>> stack backtrace:
>> CPU: 1 PID: 396 Comm: mount Not tainted 6.8.0-rc7-xfstests #521
>> Call Trace:
>>   <TASK>
>>   dump_stack_lvl+0x64/0xb0
>>   validate_chain+0x5c4/0xa00
>>   __lock_acquire+0x6a9/0xd50
>>   lock_acquire+0xcd/0x2b0
>>   down_write_nested+0x45/0xd0
>>   alloc_super+0xe3/0x3d0
>>   sget_fc+0x62/0x2f0
>>   vfs_get_super+0x21/0x90
>>   vfs_get_tree+0x2c/0xf0
>>   fc_mount+0x12/0x40
>>   vfs_kern_mount.part.0+0x75/0x90
>>   kern_mount+0x24/0x40
>>   erofs_fscache_register_fs+0x1ef/0x270 [erofs]
>>   erofs_fc_fill_super+0x213/0x380 [erofs]
>>
>> This is because the file_system_type of both erofs and the pseudo-mount
>> point of domain_id is erofs_fs_type, so two successive calls to
>> alloc_super() are considered to be using the same lock and trigger the
>> warning above.
>>
>> Therefore add a nodev file_system_type named erofs_anon_fs_type to
>> silence this complaint. In addition, to reduce code coupling, refactor
>> out the erofs_anon_init_fs_context() and erofs_kill_pseudo_sb() 
>> functions
>> and move the erofs_pseudo_mnt related code to fscache.c.
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>
> IMHO, in the beginning, I'd like to avoid introducing another fs type
> for erofs to share (meta)data between filesystems since it will cause
> churn, could we use some alternative way to resolve this?
>
> Or Jingbo might have some other ideas?
>
> Thanks,
> Gao Xiang

The usual way to avoid this kind of false positive is to add a subclass to
the lock, but s_umount is allocated, initialised and locked in 
alloc_super(),
so we can't find a place to set the subclass.

Alternatively, kern_mount(&erofs_fs_type) could be moved to
erofs_module_init() or erofs_fc_parse_param() to avoid s_umount nesting,
but that would have looked a bit strange.

So the final choice was to add a new file_system_type to avoid this false
positive. Since you don't like the idea of adding a new file_system_type,
do you think it would be ok to move kern_mount(&erofs_fs_type) to
erofs_module_init() or erofs_fc_parse_param()?

Thanks!
-- 
With Best Regards,
Baokun Li
.
