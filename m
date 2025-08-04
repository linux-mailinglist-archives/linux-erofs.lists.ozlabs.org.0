Return-Path: <linux-erofs+bounces-755-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C8AB19EFD
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Aug 2025 11:49:18 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bwWwr2CWrz30Yb;
	Mon,  4 Aug 2025 19:49:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754300956;
	cv=none; b=kR1Vofz1NZMJrYaHA3zCpYT/d3Zb/knJ4KUXDYbAC7Rsl3bMcxbD/QDXpQTEScm7x06JaSEhb0rDMsnRX4DGpso8V1o8pVCJJuWCBajj+0S5RTz6lyX+5WcD9jm+7PT3ZulQgsfJ0uomupFAQ1MPq5C9O0CoqtUYyts+lhFWNsyW75JkHQ9wTcwGhOqYP8IBiCj0K0q4VtxNLOr5HUnCq+8nh504WJmHaS06VJRCx84seCt0U/eZ0dCNlLNCBUOKi1g7uRmEa3eaHr7BVUMGWpNIYRuY34ztrPR/5xN348yNMYVAFKHTnSbKm9M/PpbvNnaYooieIgi70Lj3LndHyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754300956; c=relaxed/relaxed;
	bh=tOi3xkOlfqtkI4ihbv9ehKJO2uOAALksoSwZIOWMYcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BfVUjmpfIm1xyS47Bk+iDkZJ+fytwCmsmyuQ/NEMLkbzEgJd/WFJO+xRgUHFc/b3g0c5Finx6vCDD45pl7tDHMOZpjkJu5CCFAIH5V5kDRBT5v2GvQfZoDmKWAKa2KAj7rJl72GLyKT4cFKaoFzW6x4LtJ2hvFljvS2chxPG1GgReVZH22WkoYFSxa+3pouTCID0iEfkNEAfsjIB2+g1THuTBak/tChaxJU/XpiZmAa4kz0NQ8BFX06Z2ZyxopAcCPUxLOuIS/YVmbCvWdF3zZlpEz9iz3ZahcqpZkoUgJLcztIciBzAXustiMrTvMU0PesuSO3Ik7YXvCMHLQboSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qZqFCiGG; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qZqFCiGG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bwWwp3z6vz3069
	for <linux-erofs@lists.ozlabs.org>; Mon,  4 Aug 2025 19:49:13 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754300950; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tOi3xkOlfqtkI4ihbv9ehKJO2uOAALksoSwZIOWMYcA=;
	b=qZqFCiGGEurJ0khroieHegKKn9PcLkJrJ1hbR9+lfEp2glHXV84KYRwTEC/OajI3KGTi+XiL1EEQ9OoB3by0QIre757GrAYDqO9NzWzUo4C/q0XXN8Js31hnO2Pg4Ly+Us+8I9HvFx7gnR9vD1KSDp2yNPD2jLHhTQBo5C45o0c=
Received: from 30.221.131.110(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WkyYPsm_1754300947 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 04 Aug 2025 17:49:08 +0800
Message-ID: <960a1491-47bc-464b-a955-37d62470c0ef@linux.alibaba.com>
Date: Mon, 4 Aug 2025 17:49:07 +0800
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
Subject: Re: [PATCH v2] erofs: fix atomic context detection when
 !CONFIG_DEBUG_LOCK_ALLOC
To: Junli Liu <liujunli@lixiang.com>, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: xiang@kernel.org, chao@kernel.org, yangsonghua@lixiang.com
References: <20250804093811.295563-1-liujunli@lixiang.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250804093811.295563-1-liujunli@lixiang.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



... the patch format is still broken, is your mail server
or your mail client broken?

On 2025/8/4 17:38, Junli Liu wrote:
> Since EROFS handles decompression in non-atomic contexts due to
> uncontrollable decompression latencies and vmap() usage, it tries
> to detect atomic contexts and only kicks off a kworker on demand
> in order to reduce unnecessary scheduling overhead.
> 
> However, the current approach is insufficient and can lead to
> sleeping function calls in invalid contexts, causing kernel
> warnings and potential system instability. See the stacktrace [1]


... and previous discussion [2].


> 
> The current implementation only checks rcu_read_lock_any_held(),
> which behaves inconsistently across different kernel configurations:
> 
> - When CONFIG_DEBUG_LOCK_ALLOC is enabled: correctly detects RCU
> critical sections by checking rcu_lock_map
> - When CONFIG_DEBUG_LOCK_ALLOC is disabled: compiles to
> "!preemptible()", which only checks preempt_count and misses
> RCU critical sections
> 
> This patch introduces z_erofs_in_atomic() to provide comprehensive
> atomic context detection:
> 
> 1. Check RCU preemption depth when CONFIG_PREEMPTION is enabled,
> as RCU critical sections may not affect preempt_count but still
> require atomic handling
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
> BUG: sleeping function called from invalid context at
> kernel/locking/rtmutex_api.c:510
> in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 107,
> name: irq/54-ufshcd
> preempt_count: 0, expected: 0
> RCU nest depth: 2, expected: 0
> 
> Link: https://lore.kernel.org/r/58b661d0-0ebb-4b45-a10d-c5927fb791cd@paulmck-laptop

I prefer to replace the "Link:" to
[2] https://lore.kernel.org/r/58b661d0-0ebb-4b45-a10d-c5927fb791cd@paulmck-laptop

Since "Link:" tag mainly refers to the your current patch
in the lore...

Thanks,
Gao Xiang

> Signed-off-by: Junli Liu
> ---
> fs/erofs/zdata.c | 13 +++++++++++--
> 1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 792f20888..2d7329700 100644
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
> @@ -1446,8 +1456,7 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
> 
> if (atomic_add_return(bios, &io->pending_bios))
> return;
> - /* Use (kthread_)work and sync decompression for atomic contexts only */
> - if (!in_task() || irqs_disabled() || rcu_read_lock_any_held()) {
> + if (z_erofs_in_atomic()) {
> #ifdef CONFIG_EROFS_FS_PCPU_KTHREAD
> struct kthread_worker *worker;
> 
> -- 
> 2.25.1
> 
> 
> 声明：这封邮件只允许文件接收者阅读，有很高的机密性要求。禁止其他人使用、打开、复制或转发里面的任何内容。如果本邮件错误地发给了你，请联系邮件发出者并删除这个文件。机密及法律的特权并不因为误发邮件而放弃或丧失。任何提出的观点或意见只属于作者的个人见解，并不一定代表本公司。
> Disclaimer: This email is intended to be read only by the designated recipient of the document and has high confidentiality requirements. Anyone else is prohibited from using, opening, copying or forwarding any of the contents inside. If this email was sent to you by mistake, please contact the sender of the email and delete this file immediately. Confidentiality and legal privileges are not waived or lost by misdirected emails. Any views or opinions expressed in the email are those of the author and do not necessarily represent those of the Company.
> 


