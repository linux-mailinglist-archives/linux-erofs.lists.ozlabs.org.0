Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 900B1875BC2
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Mar 2024 02:05:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1709859901;
	bh=Wbv4glGwGkmvfTZqqlgHYUKZqtRCP86vA85awE5s7Vk=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Fvukr36n5IAMYn+UQl7z1tG3ymxlHNms+0Kk7lvh8KTjvhjrtgB3Ul2UuwctU1zWx
	 rcod7lrHNG3k7nr/eQYnUAaEe+z+Y9GarLMY1x8V8sXrKEOfq/wk8Nsuv4WgY9Y33L
	 /jYY/p3GBhkEQNuDGBEvvuTWDKpfGUyS9fhdV6tUYw67uQMisI7WxnJhV7fWXTd4+M
	 CuziGC6VKpfGpOPUaw2uPHyUKlTjUnaLYH4utZfSfB6120Gg0sGUHrvWA9+ZChJ/Ox
	 YSBbN550YPw7BOgvo+zyPXo8sf9qCEfo5M4WOVCJUuI2QJmU2r4q2JDM/NeJize6mQ
	 kmWc2hFTuxwNQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TrSd94qGtz3cxn
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Mar 2024 12:05:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=libaokun1@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TrSd21kqZz2ykC
	for <linux-erofs@lists.ozlabs.org>; Fri,  8 Mar 2024 12:04:51 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TrSch10vFz1FM6W;
	Fri,  8 Mar 2024 09:04:36 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 017241400D3;
	Fri,  8 Mar 2024 09:04:46 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Mar 2024 09:04:45 +0800
Message-ID: <70dae3d9-a4d3-f9e2-6c8b-ec08eb6b1321@huawei.com>
Date: Fri, 8 Mar 2024 09:04:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2] erofs: fix lockdep false positives on initializing
 erofs_pseudo_mnt
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
References: <20240307101018.2021925-1-libaokun1@huawei.com>
 <60c18887-db8a-42a8-8a04-ef9d17263b15@linux.alibaba.com>
In-Reply-To: <60c18887-db8a-42a8-8a04-ef9d17263b15@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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
Cc: brauner@kernel.org, yangerkun@huawei.com, linux-kernel@vger.kernel.org, huyue2@coolpad.com, viro@zeniv.linux.org.uk, yukuai3@huawei.com, chengzhihao1@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/3/7 22:18, Gao Xiang wrote:
>
>
> On 2024/3/7 18:10, Baokun Li wrote:
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
>> Therefore add a nodev file_system_type called erofs_anon_fs_type in
>> fscache.c to silence this complaint. Because kern_mount() takes a
>> pointer to struct file_system_type, not its (string) name. So we don't
>> need to call register_filesystem(). In addition, call init_pseudo() in
>> erofs_anon_init_fs_context() as suggested by Al Viro, so that we can
>> remove erofs_fc_fill_pseudo_super(), erofs_fc_anon_get_tree(), and
>> erofs_anon_context_ops.
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>
> I will add
>
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
>
> when applying..
Okay, thanks for adding it.
>
> Also since it's a false positive and too close to the
> final so let's keep this patch in -next for a while and
> then aim for v6.9-rc1 instead.
>
> Thanks,
> Gao Xiang
Fine! Thanks!
-- 
With Best Regards,
Baokun Li
.
