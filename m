Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A33F56B0D1
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Jul 2022 05:25:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LfJZT1yM9z3c3c
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Jul 2022 13:25:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.45; helo=out30-45.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LfJZN3v1wz3bhQ
	for <linux-erofs@lists.ozlabs.org>; Fri,  8 Jul 2022 13:25:30 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VIhZoLB_1657250717;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VIhZoLB_1657250717)
          by smtp.aliyun-inc.com;
          Fri, 08 Jul 2022 11:25:18 +0800
Date: Fri, 8 Jul 2022 11:25:17 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Guowei Du <duguoweisz@gmail.com>
Subject: Re: [PATCH 2/2] erofs: sequence each shrink task
Message-ID: <YsejnaY7cy3SeHBF@B-P7TQMD6M-0146.local>
References: <20220708031155.21878-1-duguoweisz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220708031155.21878-1-duguoweisz@gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, duguowei <duguowei@xiaomi.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Guowei,

On Fri, Jul 08, 2022 at 11:11:55AM +0800, Guowei Du wrote:
> From: duguowei <duguowei@xiaomi.com>
> 
> Because of 'list_move_tail', if two or more tasks are shrinking, there
> will be different results for them.

Thanks for the patch. Two quick questions:
 1) where is the PATCH 1/2;
 2) What problem is the current patch trying to resolve...

> 
> For example:
> After the first round, if shrink_run_no of entry equals run_no of task,
> task will break directly at the beginning of next round; if they are
> not equal, task will continue to shrink until encounter one entry
> which has the same number.
> 
> It is difficult to confirm the real results of all tasks, so add a lock
> to only allow one task to shrink at the same time.
> 
> How to test:
> task1:
> root#echo 3 > /proc/sys/vm/drop_caches
> [743071.839051] Call Trace:
> [743071.839052]  <TASK>
> [743071.839054]  do_shrink_slab+0x112/0x300
> [743071.839058]  shrink_slab+0x211/0x2a0
> [743071.839060]  drop_slab+0x72/0xe0
> [743071.839061]  drop_caches_sysctl_handler+0x50/0xb0
> [743071.839063]  proc_sys_call_handler+0x173/0x250
> [743071.839066]  proc_sys_write+0x13/0x20
> [743071.839067]  new_sync_write+0x104/0x180
> [743071.839070]  ? send_command+0xe0/0x270
> [743071.839073]  vfs_write+0x247/0x2a0
> [743071.839074]  ksys_write+0xa7/0xe0
> [743071.839075]  ? fpregs_assert_state_consistent+0x23/0x50
> [743071.839078]  __x64_sys_write+0x1a/0x20
> [743071.839079]  do_syscall_64+0x3a/0x80
> [743071.839081]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> task2:
> root#echo 3 > /proc/sys/vm/drop_caches
> [743079.843214] Call Trace:
> [743079.843214]  <TASK>
> [743079.843215]  do_shrink_slab+0x112/0x300
> [743079.843219]  shrink_slab+0x211/0x2a0
> [743079.843221]  drop_slab+0x72/0xe0
> [743079.843222]  drop_caches_sysctl_handler+0x50/0xb0
> [743079.843224]  proc_sys_call_handler+0x173/0x250
> [743079.843227]  proc_sys_write+0x13/0x20
> [743079.843228]  new_sync_write+0x104/0x180
> [743079.843231]  ? send_command+0xe0/0x270
> [743079.843233]  vfs_write+0x247/0x2a0
> [743079.843234]  ksys_write+0xa7/0xe0
> [743079.843235]  ? fpregs_assert_state_consistent+0x23/0x50
> [743079.843238]  __x64_sys_write+0x1a/0x20
> [743079.843239]  do_syscall_64+0x3a/0x80
> [743079.843241]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> Signed-off-by: duguowei <duguowei@xiaomi.com>
> ---
>  fs/erofs/utils.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
> index ec9a1d780dc1..9eca13a7e594 100644
> --- a/fs/erofs/utils.c
> +++ b/fs/erofs/utils.c
> @@ -186,6 +186,8 @@ static unsigned int shrinker_run_no;
>  
>  /* protects the mounted 'erofs_sb_list' */
>  static DEFINE_SPINLOCK(erofs_sb_list_lock);
> +/* sequence each shrink task */
> +static DEFINE_SPINLOCK(erofs_sb_shrink_lock);
>  static LIST_HEAD(erofs_sb_list);
>  
>  void erofs_shrinker_register(struct super_block *sb)
> @@ -226,13 +228,14 @@ static unsigned long erofs_shrink_scan(struct shrinker *shrink,
>  	struct list_head *p;
>  
>  	unsigned long nr = sc->nr_to_scan;
> -	unsigned int run_no;
>  	unsigned long freed = 0;
>  
> +	spin_lock(&erofs_sb_shrink_lock);

Btw, we cannot make the whole shrinker under one spin_lock.

Thanks,
Gao Xiang
