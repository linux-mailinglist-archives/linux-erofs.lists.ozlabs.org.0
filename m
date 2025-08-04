Return-Path: <linux-erofs+bounces-753-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DEDB19E13
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Aug 2025 10:59:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bwVqw521fz3069;
	Mon,  4 Aug 2025 18:59:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754297996;
	cv=none; b=WxAVVK8hz5lKDaCJ2WRo72X6wYAsi+mmvZ4dJntg33T4fNoO/yg2OuuNIsRf4r74jyYF77+y7ERA8gd6af7U68BzonZyNgT5RuY2OE7SOc8u5Rnw20YNpqM8fZv82xb2u7s0GkXX9R9hWMwSxXg2CGpc0Uyzg77QJ6SWYEhWMjzMdXW2ZDesV71uOexA0PzBAZd4dK22qjPmTrVlPhj69ItdNo2ph0X0O8KSNlP/XmTv5bYdQGvgGtfnAxwEEGSZpaY002H6DHPZMaJ5j9ji07ImzP+Bj2t4FfsR8kUYhGR21vdZRt4WOzWfyBfEZ8kWXYcbnCvHJyqg3ZZd+ko8TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754297996; c=relaxed/relaxed;
	bh=kVDqTQkWRvs+VsDEwe5bifWicO5KdITd3j+JwjIPmo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L7WiOoyX+o47mKBIiXmS+58f+Pjr5kYBIKZbREL+d5NojIKwrdrYHpfvBO6aWbd0s/Our6ny4XbJYZkYy4lqv7mhAurMV1A8Q6dqiNhc2Lw7ugDh+1/2Pi5YGwEgh9w2LSQROh7DlUbEMLNoFABvFpC7pKSrwlvRVKTk6MXkt0jtXY+UrxsNVj0qYSw3wgiPY01PyGOQZa170zq/W2WyUu/Nu3R2n6EXKPs7b6NUheZ3ChRKNkxrxndGXYnsmuIevtQeCjJrUqqHDcawf2asseWEEbQ+v6fuYcJQLhf4MJpWd1SLa6O/v1C/TTFjihAxfYTxte5RklMzJKbMrDaYjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pOfWZ00g; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pOfWZ00g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bwVqt2wjCz2yLB
	for <linux-erofs@lists.ozlabs.org>; Mon,  4 Aug 2025 18:59:53 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754297989; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kVDqTQkWRvs+VsDEwe5bifWicO5KdITd3j+JwjIPmo4=;
	b=pOfWZ00geFfmH/+kpsyY9DhzCYQNFoCYhgtcZpW5UkPybwgQ/LdPFuhlX0VLZNqWpTr/+yP+i/RxrYG2/NDs2mL3tWA6UleiFM2SwqglFAnvbXRIc5c3HbdY/ul4UO9medWbtwtZjt56dI4QQGylX8V1Y3F9CAZW6sXExevrKRg=
Received: from 30.221.131.110(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WkxxuDS_1754297987 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 04 Aug 2025 16:59:48 +0800
Message-ID: <4978e947-f68f-455a-a318-5f365d686496@linux.alibaba.com>
Date: Mon, 4 Aug 2025 16:59:47 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: Fix detection of atomic context to prevent
 sleeping in invalid context
To: Junli Liu <liujunli@lixiang.com>, linux-erofs@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, gao.xiang@linux.alibaba.com,
 linux-mediatek@lists.infradead.org, chao@kernel.org, xiang@kernel.org,
 yangsonghua@lixiang.com
References: <20250804082912.242580-1-liujunli@lixiang.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250804082912.242580-1-liujunli@lixiang.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Junli,

The patch format is broken, please check your email client (you
could just use a simple `git send-email` to submit) and (if
possible) send to yourself first.

I think the subject can just be

subject: erofs: fix atomic context detection when !CONFIG_DEBUG_LOCK_ALLOC

On 2025/8/4 16:29, Junli Liu wrote:
> From: Junli liu
> 
> The current atomic context detection is insufficient and can lead to
> sleeping function calls in invalid contexts, causing kernel warnings
> and potential system instability. See the stacktrace [1]

Yes, the issue is still valid, and it was discussed before in:
https://lore.kernel.org/r/58b661d0-0ebb-4b45-a10d-c5927fb791cd@paulmck-laptop

I prefer to apply to CONFIG_PREEMPT_COUNT cases only since
I don't see any real Android user uses !CONFIG_PREEMPT_COUNT.

But the commit message can be further improved as:

"Since EROFS handles decompression in non-atomic contexts due to
uncontrollable decompression latencies and vmap() usage, it tries
to detect atomic contexts and only kicks off a kworker on demand
in order to reduce unnecessary scheduling overhead.

However, the current approach is insufficient and can lead to
sleeping function calls in invalid contexts, causing kernel
warnings and potential system instability. See the stacktrace [1]"


Also shorten the commit message to 72 chars per line at maximum.

> 
> The current implementation only checks rcu_read_lock_any_held(), which
> behaves inconsistently across different kernel configurations:
> 
> - When CONFIG_DEBUG_LOCK_ALLOC is enabled: correctly detects RCU critical
> sections by checking rcu_lock_map
> - When CONFIG_DEBUG_LOCK_ALLOC is disabled: compiles to "!preemptible()",
> which only checks preempt_count and misses RCU critical sections
> 
> This patch introduces z_erofs_in_atomic() to provide comprehensive atomic
> context detection:
> 
> 1. Check RCU preemption depth when CONFIG_PREEMPTION is enabled, as RCU
> critical sections may not affect preempt_count but still require
> atomic handling
> 
> 2. Always use async processing when CONFIG_PREEMPT_COUNT is disabled,
> as preemption state cannot be reliably determined
> 
> 3. Fall back to standard preemptible() check for remaining cases
> 
> The function replaces the previous complex condition check and ensures
> that z_erofs always uses (kthread_)work in atomic contexts to minimize
> scheduling overhead and prevent sleeping in invalid contexts.
> 
> ==============================================
> [1] Problem stacktrace
> [ 61.266692] BUG: sleeping function called from invalid context at kernel/locking/rtmutex_api.c:510
> [ 61.266702] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 107, name: irq/54-ufshcd
> [ 61.266704] preempt_count: 0, expected: 0
> [ 61.266705] RCU nest depth: 2, expected: 0
> [ 61.266710] CPU: 0 UID: 0 PID: 107 Comm: irq/54-ufshcd Tainted: G W O 6.12.17 #1
> [ 61.266714] Tainted: [W]=WARN, [O]=OOT_MODULE
> [ 61.266715] Hardware name: schumacher (DT)
> [ 61.266717] Call trace:
> [ 61.266718] dump_backtrace+0x9c/0x100
> [ 61.266727] show_stack+0x20/0x38
> [ 61.266728] dump_stack_lvl+0x78/0x90
> [ 61.266734] dump_stack+0x18/0x28
> [ 61.266736] __might_resched+0x11c/0x180
> [ 61.266743] __might_sleep+0x64/0xc8
> [ 61.266745] mutex_lock+0x2c/0xc0
> [ 61.266748] z_erofs_decompress_queue+0xe8/0x978
> [ 61.266753] z_erofs_decompress_kickoff+0xa8/0x190
> [ 61.266756] z_erofs_endio+0x168/0x288
> [ 61.266758] bio_endio+0x160/0x218
> [ 61.266762] blk_update_request+0x244/0x458
> [ 61.266766] scsi_end_request+0x38/0x278
> [ 61.266770] scsi_io_completion+0x4c/0x600
> [ 61.266772] scsi_finish_command+0xc8/0xe8
> [ 61.266775] scsi_complete+0x88/0x148
> [ 61.266777] blk_mq_complete_request+0x3c/0x58
> [ 61.266780] scsi_done_internal+0xcc/0x158
> [ 61.266782] scsi_done+0x1c/0x30
> [ 61.266783] ufshcd_compl_one_cqe+0x12c/0x438
> [ 61.266786] __ufshcd_transfer_req_compl+0x2c/0x78
> [ 61.266788] ufshcd_poll+0xf4/0x210
> [ 61.266789] ufshcd_transfer_req_compl+0x50/0x88
> [ 61.266791] ufshcd_intr+0x21c/0x7c8
> [ 61.266792] irq_forced_thread_fn+0x44/0xd8
> [ 61.266796] irq_thread+0x1a4/0x358
> [ 61.266799] kthread+0x12c/0x138
> [ 61.266802] ret_from_fork+0x10/0x20
> 
> Signed-off-by: Junli Liu
> ---
> fs/erofs/zdata.c | 14 ++++++++++++--
> 1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 792f20888..1883781c9 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -1432,6 +1432,16 @@ static void z_erofs_decompressqueue_kthread_work(struct kthread_work *work)
> }
> #endif
> 
> +/* Use (kthread_)work in atomic contexts to minimize scheduling overhead */
> +static inline bool z_erofs_in_atomic(void)
> +{
> + if (IS_ENABLED(CONFIG_PREEMPTION) && rcu_preempt_depth())
> + return true;
> + if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
> + return true;
> + return !preemptible();
> +}
> +
> static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
> int bios)
> {
> @@ -1446,8 +1456,8 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
> 
> if (atomic_add_return(bios, &io->pending_bios))
> return;
> - /* Use (kthread_)work and sync decompression for atomic contexts only */
> - if (!in_task() || irqs_disabled() || rcu_read_lock_any_held()) {
> +
> + if (z_erofs_in_atomic()) {

Please avoid the unnecessary new line in the next version.

Thanks,
Gao XIang

