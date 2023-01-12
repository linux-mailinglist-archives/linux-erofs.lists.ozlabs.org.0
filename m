Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE276669CA
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Jan 2023 04:48:03 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Nsr9X5RjCz3bVs
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Jan 2023 14:48:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Nsr9R02jNz3c3m
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Jan 2023 14:47:53 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VZPGQNn_1673495267;
Received: from 30.221.131.229(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VZPGQNn_1673495267)
          by smtp.aliyun-inc.com;
          Thu, 12 Jan 2023 11:47:48 +0800
Message-ID: <42d0b5da-73e8-59f2-c20b-ba1d6143da14@linux.alibaba.com>
Date: Thu, 12 Jan 2023 11:47:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH v2 1/2] fscache: Use wait_on_bit() to wait for the freeing
 of relinquished volume
To: Hou Tao <houtao@huaweicloud.com>, linux-cachefs@redhat.com
References: <20221226103309.953112-1-houtao@huaweicloud.com>
 <20221226103309.953112-2-houtao@huaweicloud.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20221226103309.953112-2-houtao@huaweicloud.com>
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
Cc: David Howells <dhowells@redhat.com>, linux-erofs@lists.ozlabs.org, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, houtao1@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 12/26/22 6:33 PM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> The freeing of relinquished volume will wake up the pending volume
> acquisition by using wake_up_bit(), however it is mismatched with
> wait_var_event() used in fscache_wait_on_volume_collision() and it will
> never wake up the waiter in the wait-queue because these two functions
> operate on different wait-queues.
> 
> According to the implementation in fscache_wait_on_volume_collision(),
> if the wake-up of pending acquisition is delayed longer than 20 seconds
> (e.g., due to the delay of on-demand fd closing), the first
> wait_var_event_timeout() will timeout and the following wait_var_event()
> will hang forever as shown below:
> 
>  FS-Cache: Potential volume collision new=00000024 old=00000022
>  ......
>  INFO: task mount:1148 blocked for more than 122 seconds.
>        Not tainted 6.1.0-rc6+ #1
>  task:mount           state:D stack:0     pid:1148  ppid:1
>  Call Trace:
>   <TASK>
>   __schedule+0x2f6/0xb80
>   schedule+0x67/0xe0
>   fscache_wait_on_volume_collision.cold+0x80/0x82
>   __fscache_acquire_volume+0x40d/0x4e0
>   erofs_fscache_register_volume+0x51/0xe0 [erofs]
>   erofs_fscache_register_fs+0x19c/0x240 [erofs]
>   erofs_fc_fill_super+0x746/0xaf0 [erofs]
>   vfs_get_super+0x7d/0x100
>   get_tree_nodev+0x16/0x20
>   erofs_fc_get_tree+0x20/0x30 [erofs]
>   vfs_get_tree+0x24/0xb0
>   path_mount+0x2fa/0xa90
>   do_mount+0x7c/0xa0
>   __x64_sys_mount+0x8b/0xe0
>   do_syscall_64+0x30/0x60
>   entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> Considering that wake_up_bit() is more selective, so fixing it by using
							^
						       fix
> wait_on_bit() instead of wait_var_event() to wait for the freeing of
> relinquished volume. In addition because waitqueue_active() is used in
> wake_up_bit() and clear_bit() doesn't imply any memory barrier, so also
> adding smp_mb__after_atomic() before wake_up_bit().

... doesn't imply any memory barrier, add ...

> 
> Fixes: 62ab63352350 ("fscache: Implement volume registration")
> Signed-off-by: Hou Tao <houtao1@huawei.com>


Otherwise LGTM :)

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

> ---
>  fs/fscache/volume.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/fscache/volume.c b/fs/fscache/volume.c
> index ab8ceddf9efa..fc3dd3bc851d 100644
> --- a/fs/fscache/volume.c
> +++ b/fs/fscache/volume.c
> @@ -141,13 +141,14 @@ static bool fscache_is_acquire_pending(struct fscache_volume *volume)
>  static void fscache_wait_on_volume_collision(struct fscache_volume *candidate,
>  					     unsigned int collidee_debug_id)
>  {
> -	wait_var_event_timeout(&candidate->flags,
> -			       !fscache_is_acquire_pending(candidate), 20 * HZ);
> +	wait_on_bit_timeout(&candidate->flags, FSCACHE_VOLUME_ACQUIRE_PENDING,
> +			    TASK_UNINTERRUPTIBLE, 20 * HZ);
>  	if (fscache_is_acquire_pending(candidate)) {
>  		pr_notice("Potential volume collision new=%08x old=%08x",
>  			  candidate->debug_id, collidee_debug_id);
>  		fscache_stat(&fscache_n_volumes_collision);
> -		wait_var_event(&candidate->flags, !fscache_is_acquire_pending(candidate));
> +		wait_on_bit(&candidate->flags, FSCACHE_VOLUME_ACQUIRE_PENDING,
> +			    TASK_UNINTERRUPTIBLE);
>  	}
>  }
>  
> @@ -348,6 +349,11 @@ static void fscache_wake_pending_volume(struct fscache_volume *volume,
>  		if (fscache_volume_same(cursor, volume)) {
>  			fscache_see_volume(cursor, fscache_volume_see_hash_wake);
>  			clear_bit(FSCACHE_VOLUME_ACQUIRE_PENDING, &cursor->flags);
> +			/*
> +			 * Paired with barrier in wait_on_bit(). Check
> +			 * wake_up_bit() and waitqueue_active() for details.
> +			 */
> +			smp_mb__after_atomic();
>  			wake_up_bit(&cursor->flags, FSCACHE_VOLUME_ACQUIRE_PENDING);
>  			return;
>  		}

-- 
Thanks,
Jingbo
