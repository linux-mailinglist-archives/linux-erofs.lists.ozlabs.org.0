Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 244D787484C
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Mar 2024 07:46:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1709793987;
	bh=Z8jDYxtTSQHeyBVnJ9MJfTgyjVJ1oYXFlJYF1zvb8YA=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=JWxV4BSzTmOk7aPP9drHeFGIo/p+5/b02ka8AOTpIU0c4oE71tFzi4KduaCsT6U2C
	 IQTRahF9d6f5qvIazruuOWU1ELs3PdAg2IlZkGVK8BEFGBJxqTJvIlsOHfn64B3Hh2
	 rW7qKjpvW+982Y6NVKBUeET+dvJfVB8CbWSfHGR0UDb6gJhbsIEVRKab2iH2D1Ze1F
	 DGm3E6JI9MjFwcsuID4S7bS72B0p60mrVgGY97eD7r2AZeVDvpqOfBz6iezUHNVvLx
	 Jz5wAt5pNAFrmVxFS6csz/3i6zPif5qc0Zc9UPkXm1ZUnCgUFGzvkKbrbQ77VXg7jF
	 QMfeHwWPZ5nDQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Tr0Fb2Rsdz3dVq
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Mar 2024 17:46:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.35; helo=szxga07-in.huawei.com; envelope-from=libaokun1@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tr0FS0GYVz3cGW
	for <linux-erofs@lists.ozlabs.org>; Thu,  7 Mar 2024 17:46:15 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Tr0BW2mr0z1QB3F;
	Thu,  7 Mar 2024 14:43:47 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 93AED1A016C;
	Thu,  7 Mar 2024 14:46:09 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 14:46:08 +0800
Message-ID: <65d09bbe-9389-4502-1504-8c1557fe5e52@huawei.com>
Date: Thu, 7 Mar 2024 14:46:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] erofs: fix lockdep false positives on initializing
 erofs_pseudo_mnt
Content-Language: en-US
To: Jingbo Xu <jefflexu@linux.alibaba.com>, Gao Xiang
	<hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
References: <20240307024459.883044-1-libaokun1@huawei.com>
 <f9e30004-6691-4171-abc5-7e286d9ccec6@linux.alibaba.com>
 <7e262242-d90d-4f61-a217-f156219eaa4d@linux.alibaba.com>
In-Reply-To: <7e262242-d90d-4f61-a217-f156219eaa4d@linux.alibaba.com>
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
Cc: yangerkun@huawei.com, linux-kernel@vger.kernel.org, huyue2@coolpad.com, yukuai3@huawei.com, chengzhihao1@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/3/7 11:41, Jingbo Xu wrote:
> Hi Baokun,
>
> Thanks for catching this!
>
>
> On 3/7/24 10:52 AM, Gao Xiang wrote:
>> Hi Baokun,
>>
>> On 2024/3/7 10:44, Baokun Li wrote:
>>> Lockdep reported the following issue when mounting erofs with a
>>> domain_id:
>>>
>>> ============================================
>>> WARNING: possible recursive locking detected
>>> 6.8.0-rc7-xfstests #521 Not tainted
>>> --------------------------------------------
>>> mount/396 is trying to acquire lock:
>>> ffff907a8aaaa0e0 (&type->s_umount_key#50/1){+.+.}-{3:3},
>>>                          at: alloc_super+0xe3/0x3d0
>>>
>>> but task is already holding lock:
>>> ffff907a8aaa90e0 (&type->s_umount_key#50/1){+.+.}-{3:3},
>>>                          at: alloc_super+0xe3/0x3d0
>>>
>>> other info that might help us debug this:
>>>    Possible unsafe locking scenario:
>>>
>>>          CPU0
>>>          ----
>>>     lock(&type->s_umount_key#50/1);
>>>     lock(&type->s_umount_key#50/1);
>>>
>>>    *** DEADLOCK ***
>>>
>>>    May be due to missing lock nesting notation
>>>
>>> 2 locks held by mount/396:
>>>    #0: ffff907a8aaa90e0 (&type->s_umount_key#50/1){+.+.}-{3:3},
>>>              at: alloc_super+0xe3/0x3d0
>>>    #1: ffffffffc00e6f28 (erofs_domain_list_lock){+.+.}-{3:3},
>>>              at: erofs_fscache_register_fs+0x3d/0x270 [erofs]
>>>
>>> stack backtrace:
>>> CPU: 1 PID: 396 Comm: mount Not tainted 6.8.0-rc7-xfstests #521
>>> Call Trace:
>>>    <TASK>
>>>    dump_stack_lvl+0x64/0xb0
>>>    validate_chain+0x5c4/0xa00
>>>    __lock_acquire+0x6a9/0xd50
>>>    lock_acquire+0xcd/0x2b0
>>>    down_write_nested+0x45/0xd0
>>>    alloc_super+0xe3/0x3d0
>>>    sget_fc+0x62/0x2f0
>>>    vfs_get_super+0x21/0x90
>>>    vfs_get_tree+0x2c/0xf0
>>>    fc_mount+0x12/0x40
>>>    vfs_kern_mount.part.0+0x75/0x90
>>>    kern_mount+0x24/0x40
>>>    erofs_fscache_register_fs+0x1ef/0x270 [erofs]
>>>    erofs_fc_fill_super+0x213/0x380 [erofs]
>>>
>>> This is because the file_system_type of both erofs and the pseudo-mount
>>> point of domain_id is erofs_fs_type, so two successive calls to
>>> alloc_super() are considered to be using the same lock and trigger the
>>> warning above.
>>>
>>> Therefore add a nodev file_system_type named erofs_anon_fs_type to
>>> silence this complaint. In addition, to reduce code coupling, refactor
>>> out the erofs_anon_init_fs_context() and erofs_kill_pseudo_sb() functions
>>> and move the erofs_pseudo_mnt related code to fscache.c.
>>>
>>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> IMHO, in the beginning, I'd like to avoid introducing another fs type
>> for erofs to share (meta)data between filesystems since it will cause
>> churn, could we use some alternative way to resolve this?
> Yeah as Gao Xiang said, this is initially intended to avoid introducing
> anothoer file_system_type, say erofs_anon_fs_type.
>
> What we need is actually a method of allocating anonymous inode as a
> sentinel identifying each blob.  There is indeed a global mount, i.e.
> anon_inode_mnt, for allocating anonymous inode/file specifically.  At
> the time the share domain feature is introduced, there's only one
> anonymous inode, i.e. anon_inode_inode, and all the allocated anonymous
> files are bound to this single anon_inode_inode.  Thus we decided to
> implement a erofs internal pseudo mount for this usage.
>
> But I noticed that we can now allocate unique anonymous inodes from
> anon_inode_mnt since commit e7e832c ("fs: add LSM-supporting anon-inode
> interface"), though the new interface is initially for LSM usage.
>
Thank you for your feedback!

If I understand you correctly, you mean to remove erofs_pseudo_mnt
directly to avoid this false positive, and use anon_inode_create_getfile()
to create the required anonymous inode.

-- 
With Best Regards,
Baokun Li
.
