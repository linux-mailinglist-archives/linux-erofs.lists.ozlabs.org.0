Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE4291A258
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jun 2024 11:12:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1719479550;
	bh=JNngtxjb6wjznx0wJic+XePvbVQlsDUECkGt7I089v8=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=bPmI6QVBbX5xEnTsyw9T7Flh4jULnMDi6wRYk6u3t/11NSkH6F5a5+Ud5PvhJXZ3E
	 ujkDl3zKH+QpHTGgiFeMvtHGWRMtvOxco26RW4y5E4Z+qtQgf/jMpg9rKnYekbKtmb
	 mS5ssGc1WE5SubA2JjWF00oZQhoyazKqc31XJzCsxm2d4r4rVlpXLQmJMXRFiY6Yqr
	 BVRv/HuvdDmEfg0V0n9ru3JYzDn0a6meJiwNJxOQqkzOxqOMa/sD6Pche72yesbkyC
	 PRcktMQ+3DTY365AumO9Us6xeq/CLPyp4BkT3CkQH34YdeC++og+dQ9E0t2FlRyP/w
	 3JGrywJPvTA+Q==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W8tBQ0xWKz3cbW
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jun 2024 19:12:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W8tBK5J7Hz3cZ6
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jun 2024 19:12:25 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W8t4f61MpzjZ6f;
	Thu, 27 Jun 2024 17:07:30 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id A8B75180088;
	Thu, 27 Jun 2024 17:11:51 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 17:11:51 +0800
Message-ID: <c1426293-7a86-49fd-a807-d577438a7828@huawei.com>
Date: Thu, 27 Jun 2024 17:11:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6.6] erofs: fix NULL dereference of dif->bdev_handle in
 fscache mode
To: <gregkh@linuxfoundation.org>
References: <20240627091345.3569167-1-lihongbo22@huawei.com>
Content-Language: en-US
In-Reply-To: <20240627091345.3569167-1-lihongbo22@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500022.china.huawei.com (7.185.36.66)
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
From: Hongbo Li via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Hongbo Li <lihongbo22@huawei.com>
Cc: brauner@kernel.org, jack@suse.cz, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

When I run nydus on linux 6.6.35, the erofs crashed with the following
messages:

```
[ 2120.070101] RIP: 0010:erofs_map_dev+0x147/0x1e0 [erofs]
[ 2120.070188] Code: e8 4e bd 6d dc 8b 43 28 4c 89 ef 8d 70 ff e8 f0 ee 
69 dc 48 85 c0 0f 84 83 00 00 00 41 80 7d 44 00 75 31 48 8b 50 10 4c 89 
e7 <48> 8b 12 48 89 53 08 48 8b 50 18 48 89 53 10 48 8b 50 20 48 89 53
[ 2120.070288] RSP: 0018:ffff982a48adb9d8 EFLAGS: 00010246
[ 2120.070357] RAX: ffff8c2607e2f040 RBX: ffff982a48adba38 RCX: 
0000000000000000
[ 2120.070431] RDX: 0000000000000000 RSI: ffff8c25d17c7dc8 RDI: 
ffff8c354725e198
[ 2120.070522] RBP: ffff8c35466cf800 R08: ffff8c2607e2f040 R09: 
ffff8c354725e188
[ 2120.070631] R10: 0000000000000000 R11: 0000000000000000 R12: 
ffff8c354725e198
[ 2120.070741] R13: ffff8c354725e180 R14: ffff8c25d14d01c0 R15: 
0000000000001000
[ 2120.070853] FS:  000000c000a00090(0000) GS:ffff8c34ffe00000(0000) 
knlGS:0000000000000000
[ 2120.070965] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2120.071054] CR2: 0000000000000000 CR3: 00000001067dc005 CR4: 
00000000001706f0
[ 2120.071163] Call Trace:
[ 2120.071245]  <TASK>
[ 2120.071325]  ? __die+0x24/0x70
[ 2120.071413]  ? page_fault_oops+0x82/0x150
[ 2120.071499]  ? fixup_exception+0x26/0x350
[ 2120.071585]  ? exc_page_fault+0x69/0x150
[ 2120.071671]  ? asm_exc_page_fault+0x26/0x30
[ 2120.071759]  ? erofs_map_dev+0x147/0x1e0 [erofs]
[ 2120.071853]  ? erofs_map_dev+0x130/0x1e0 [erofs]
[ 2120.071946]  erofs_fscache_data_read_slice+0xe7/0x390 [erofs]
[ 2120.072044]  ? xas_create+0x160/0x1b0
[ 2120.072130]  ? __kmem_cache_alloc_node+0x18c/0x2c0
[ 2120.072219]  ? erofs_fscache_readahead+0x49/0x110 [erofs]
[ 2120.072314]  ? xas_load+0xe/0x50
[ 2120.072397]  erofs_fscache_readahead+0xe0/0x110 [erofs]
[ 2120.072492]  read_pages+0x5a/0x220
[ 2120.072579]  page_cache_ra_order+0x1f0/0x2f0
[ 2120.072667]  filemap_get_pages+0xef/0x290
[ 2120.072755]  filemap_read+0xcb/0x310
[ 2120.072841]  ? ovl_open+0x9e/0xf0 [overlay]
[ 2120.072942]  ? ima_file_check+0x57/0x80
[ 2120.073028]  ? mntput_no_expire+0x4a/0x250
[ 2120.073116]  do_iter_readv_writev+0x12d/0x140
[ 2120.073204]  do_iter_read+0xfd/0x190
[ 2120.073288]  ovl_read_iter+0x1c3/0x210 [overlay]
[ 2120.073384]  vfs_read+0x1c7/0x300
[ 2120.073471]  ksys_read+0x63/0xe0
[ 2120.073555]  do_syscall_64+0x37/0x90
[ 2120.073640]  entry_SYSCALL_64_after_hwframe+0x78/0xe2
[ 2120.073729] RIP: 0033:0x403ace
```

The reason is the same with 8bd90b6ae7856("erofs: fix NULL dereference 
of dif->bdev_handle in fscache mode") in mainline. So we should backport 
this
patch into stable linux-6.6.y to avoid this bug.

On 2024/6/27 17:13, Hongbo Li wrote:
> From: Jingbo Xu <jefflexu@linux.alibaba.com>
> 
> Avoid NULL dereference of dif->bdev_handle, as dif->bdev_handle is NULL
> in fscache mode.
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   RIP: 0010:erofs_map_dev+0xbd/0x1c0
>   Call Trace:
>    <TASK>
>    erofs_fscache_data_read_slice+0xa7/0x340
>    erofs_fscache_data_read+0x11/0x30
>    erofs_fscache_readahead+0xd9/0x100
>    read_pages+0x47/0x1f0
>    page_cache_ra_order+0x1e5/0x270
>    filemap_get_pages+0xf2/0x5f0
>    filemap_read+0xb8/0x2e0
>    vfs_read+0x18d/0x2b0
>    ksys_read+0x53/0xd0
>    do_syscall_64+0x42/0xf0
>    entry_SYSCALL_64_after_hwframe+0x6e/0x76
> 
> Reported-by: Yiqun Leng <yqleng@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7245
> Fixes: 49845720080d ("erofs: Convert to use bdev_open_by_path()")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Reviewed-by: Yue Hu <huyue2@coolpad.com>
> Reviewed-by: Chao Yu <chao@kernel.org>
> Link: https://lore.kernel.org/r/20231114070704.23398-1-jefflexu@linux.alibaba.com
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   fs/erofs/data.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 029c761670bf..c98aeda8abb2 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -220,7 +220,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
>   			up_read(&devs->rwsem);
>   			return 0;
>   		}
> -		map->m_bdev = dif->bdev_handle->bdev;
> +		map->m_bdev = dif->bdev_handle ? dif->bdev_handle->bdev : NULL;
>   		map->m_daxdev = dif->dax_dev;
>   		map->m_dax_part_off = dif->dax_part_off;
>   		map->m_fscache = dif->fscache;
> @@ -238,7 +238,8 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
>   			if (map->m_pa >= startoff &&
>   			    map->m_pa < startoff + length) {
>   				map->m_pa -= startoff;
> -				map->m_bdev = dif->bdev_handle->bdev;
> +				map->m_bdev = dif->bdev_handle ?
> +					      dif->bdev_handle->bdev : NULL;
>   				map->m_daxdev = dif->dax_dev;
>   				map->m_dax_part_off = dif->dax_part_off;
>   				map->m_fscache = dif->fscache;
