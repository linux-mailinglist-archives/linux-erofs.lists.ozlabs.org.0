Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B1983874664
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Mar 2024 03:53:53 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ib6WhThj;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Tqv5C34hjz3vnT
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Mar 2024 13:53:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ib6WhThj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tqv4H47w9z3vlR
	for <linux-erofs@lists.ozlabs.org>; Thu,  7 Mar 2024 13:53:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709779977; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=dPMLinAyobi1hl2nRZz6LJSam7sTYWgf4JFdTQaJ6CY=;
	b=ib6WhThjOWfcKDCeS63fSnGpb4fAQMmuJwI8QFdqPMtTZZdVIDQHQe+fuRGnVyvTR2mBpjfol/TlbOCeCyL84CT7rH907tBPrxYPN9yLGbqdAcjDc5IhP0N9DLjq4TwQ8ARwYuZOWO9jsN6oSSBm1EyVFkHFY6D2en72W0EroYk=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W1zDaJZ_1709779974;
Received: from 30.97.48.224(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W1zDaJZ_1709779974)
          by smtp.aliyun-inc.com;
          Thu, 07 Mar 2024 10:52:56 +0800
Message-ID: <f9e30004-6691-4171-abc5-7e286d9ccec6@linux.alibaba.com>
Date: Thu, 7 Mar 2024 10:52:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix lockdep false positives on initializing
 erofs_pseudo_mnt
To: Baokun Li <libaokun1@huawei.com>, linux-erofs@lists.ozlabs.org
References: <20240307024459.883044-1-libaokun1@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240307024459.883044-1-libaokun1@huawei.com>
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
Cc: yangerkun@huawei.com, linux-kernel@vger.kernel.org, huyue2@coolpad.com, yukuai3@huawei.com, chengzhihao1@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Baokun,

On 2024/3/7 10:44, Baokun Li wrote:
> Lockdep reported the following issue when mounting erofs with a domain_id:
> 
> ============================================
> WARNING: possible recursive locking detected
> 6.8.0-rc7-xfstests #521 Not tainted
> --------------------------------------------
> mount/396 is trying to acquire lock:
> ffff907a8aaaa0e0 (&type->s_umount_key#50/1){+.+.}-{3:3},
> 						at: alloc_super+0xe3/0x3d0
> 
> but task is already holding lock:
> ffff907a8aaa90e0 (&type->s_umount_key#50/1){+.+.}-{3:3},
> 						at: alloc_super+0xe3/0x3d0
> 
> other info that might help us debug this:
>   Possible unsafe locking scenario:
> 
>         CPU0
>         ----
>    lock(&type->s_umount_key#50/1);
>    lock(&type->s_umount_key#50/1);
> 
>   *** DEADLOCK ***
> 
>   May be due to missing lock nesting notation
> 
> 2 locks held by mount/396:
>   #0: ffff907a8aaa90e0 (&type->s_umount_key#50/1){+.+.}-{3:3},
> 			at: alloc_super+0xe3/0x3d0
>   #1: ffffffffc00e6f28 (erofs_domain_list_lock){+.+.}-{3:3},
> 			at: erofs_fscache_register_fs+0x3d/0x270 [erofs]
> 
> stack backtrace:
> CPU: 1 PID: 396 Comm: mount Not tainted 6.8.0-rc7-xfstests #521
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x64/0xb0
>   validate_chain+0x5c4/0xa00
>   __lock_acquire+0x6a9/0xd50
>   lock_acquire+0xcd/0x2b0
>   down_write_nested+0x45/0xd0
>   alloc_super+0xe3/0x3d0
>   sget_fc+0x62/0x2f0
>   vfs_get_super+0x21/0x90
>   vfs_get_tree+0x2c/0xf0
>   fc_mount+0x12/0x40
>   vfs_kern_mount.part.0+0x75/0x90
>   kern_mount+0x24/0x40
>   erofs_fscache_register_fs+0x1ef/0x270 [erofs]
>   erofs_fc_fill_super+0x213/0x380 [erofs]
> 
> This is because the file_system_type of both erofs and the pseudo-mount
> point of domain_id is erofs_fs_type, so two successive calls to
> alloc_super() are considered to be using the same lock and trigger the
> warning above.
> 
> Therefore add a nodev file_system_type named erofs_anon_fs_type to
> silence this complaint. In addition, to reduce code coupling, refactor
> out the erofs_anon_init_fs_context() and erofs_kill_pseudo_sb() functions
> and move the erofs_pseudo_mnt related code to fscache.c.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

IMHO, in the beginning, I'd like to avoid introducing another fs type
for erofs to share (meta)data between filesystems since it will cause
churn, could we use some alternative way to resolve this?

Or Jingbo might have some other ideas?

Thanks,
Gao Xiang
