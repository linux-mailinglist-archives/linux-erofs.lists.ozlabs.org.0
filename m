Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1BF6393A5
	for <lists+linux-erofs@lfdr.de>; Sat, 26 Nov 2022 04:21:07 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NJxp81JXWz3f5Y
	for <lists+linux-erofs@lfdr.de>; Sat, 26 Nov 2022 14:21:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NJxp05gBpz3cTC
	for <linux-erofs@lists.ozlabs.org>; Sat, 26 Nov 2022 14:20:55 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VVhOwfb_1669432849;
Received: from 30.15.198.69(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VVhOwfb_1669432849)
          by smtp.aliyun-inc.com;
          Sat, 26 Nov 2022 11:20:50 +0800
Message-ID: <dd919a21-956b-77ef-c5d2-92ef554b31c8@linux.alibaba.com>
Date: Sat, 26 Nov 2022 11:20:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH v2] erofs: check the uniqueness of fsid in shared domain
 in advance
Content-Language: en-US
To: Hou Tao <houtao@huaweicloud.com>, linux-erofs@lists.ozlabs.org
References: <20221125110822.3812942-1-houtao@huaweicloud.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20221125110822.3812942-1-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
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
Cc: linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>, houtao1@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Tao,

Thanks for catching this!


On 11/25/22 7:08 PM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> When shared domain is enabled, doing mount twice with the same fsid and
> domain_id will trigger sysfs warning as shown below:
> 
>  sysfs: cannot create duplicate filename '/fs/erofs/d0,meta.bin'
>  CPU: 15 PID: 1051 Comm: mount Not tainted 6.1.0-rc6+ #1
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x38/0x49
>   dump_stack+0x10/0x12
>   sysfs_warn_dup.cold+0x17/0x27
>   sysfs_create_dir_ns+0xb8/0xd0
>   kobject_add_internal+0xb1/0x240
>   kobject_init_and_add+0x71/0xa0
>   erofs_register_sysfs+0x89/0x110
>   erofs_fc_fill_super+0x98c/0xaf0
>   vfs_get_super+0x7d/0x100
>   get_tree_nodev+0x16/0x20
>   erofs_fc_get_tree+0x20/0x30
>   vfs_get_tree+0x24/0xb0
>   path_mount+0x2fa/0xa90
>   do_mount+0x7c/0xa0
>   __x64_sys_mount+0x8b/0xe0
>   do_syscall_64+0x30/0x60
>   entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> The reason is erofs_fscache_register_cookie() doesn't guarantee the primary
> data blob (aka fsid) is unique in the shared domain and
> erofs_register_sysfs() invoked by the second mount will fail due to the
> duplicated fsid in the shared domain and report warning.
> 
> It would be better to check the uniqueness of fsid before doing
> erofs_register_sysfs(), so adding a new flags parameter for
> erofs_fscache_register_cookie() and doing the uniqueness check if
> EROFS_REG_COOKIE_NEED_NOEXIST is enabled.
> 
> After the patch, the error in dmesg for the duplicated mount would be:
> 
>  erofs: ...: erofs_domain_register_cookie: XX already exists in domain YY
> 
> Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
> Signed-off-by: Hou Tao <houtao1@huawei.com>

LGTM.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>


-- 
Thanks,
Jingbo
