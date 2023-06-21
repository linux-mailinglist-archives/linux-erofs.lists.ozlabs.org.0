Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E19E739253
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jun 2023 00:12:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1687385563;
	bh=X5VBBI/+jK44r8RvxRWw6Pxxx0HHmouRM7Vuu61DxBc=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=jyQYJMjCgSvdlHEeNDGEw7gSwR+EmhOjYrkqEDecsFTNvChYYemmtxbVnmHk1oxep
	 QPx4YLHRllTThbJyfl3v6/t654nF4gkDmCpcNEkLHKzSvivULSBi9bO48ziAghsTHa
	 X3kxnUk7i7PsDSA0ZKsq7lopms+JFcla/TDpJ1oj6aJEBWD+oi1W0dmLN0sM7c0LDO
	 RvOEQv9nMo3n6/CNx/3Y7oOn2QVD6FX0pkYINXGwPoOYWmf7PESexZLs63SMcYEA0y
	 NZGXSuTEWOblLVt9z+BHHWBbGoeaVjJYmoGwFBRGntZeiwEJt4bsW7kFwF1GIx5WXT
	 CWAn3XlfMcOmw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qmd6M0tr3z304M
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jun 2023 08:12:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20221208 header.b=ZKFduUXM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::549; helo=mail-pg1-x549.google.com; envelope-from=30hwtzackczuuyrmrcvxffxcv.tfdczelo-vifwjczjkj.fqcrsj.fix@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qmd6G3RRXz2yyT
	for <linux-erofs@lists.ozlabs.org>; Thu, 22 Jun 2023 08:12:36 +1000 (AEST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5343c1d114cso4920088a12.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 21 Jun 2023 15:12:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687385553; x=1689977553;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X5VBBI/+jK44r8RvxRWw6Pxxx0HHmouRM7Vuu61DxBc=;
        b=FuMItlAs/UkDRZzuZsyHA5ZdCJUtWq8w3azfeGTu/37BgtU3y3cjscd/ABo03aMb8D
         +cT8uZ7lf5D2p4FGa0MAWnAA29qKTovpY5UpBkA3FjQLAZ9QKt2513nXIfviSCE6280Z
         pa5YST/A7rF5GYGwOlU8UBdZZccts/cyPkEj/ZqAYlGT+KJXjIp4IipIyzL1f1j8Ys5H
         lY+E904LjOm7T3TD4Tdq/o5taOe+VzqXaDqWjxTxeXJQhI6Du4hjSz922n8JZXfYNhqj
         QCh6SnvLgSq6a2530wq7R2CpO4xFoIaTjfbpkRI9jdWwNCtixy+x/w+0mpgI0orIusC2
         LDlw==
X-Gm-Message-State: AC+VfDx/R9abV/UstdsrLyCzpIHQeWMEy0vuSGbpHRAwyy8uasGcdv9j
	OdS9OJlC1V0jKIuckaepiPPfZ88/5zVb
X-Google-Smtp-Source: ACHHUZ4+BET7n1d9xU6fAnQCVLRtCIOnbouCbHDq7OzYGEOhVbYdx7BTlJVjV41tRdd49wW6zTh+HLTcl2dz
X-Received: from dhavale-ctop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:5e39])
 (user=dhavale job=sendgmr) by 2002:a65:6418:0:b0:553:c671:b9f4 with SMTP id
 a24-20020a656418000000b00553c671b9f4mr1423444pgv.6.1687385552761; Wed, 21 Jun
 2023 15:12:32 -0700 (PDT)
Date: Wed, 21 Jun 2023 15:08:47 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230621220848.3379029-1-dhavale@google.com>
Subject: [PATCH v1] erofs: Fix detection of atomic context
To: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
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
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: Will Shiu <Will.Shiu@mediatek.com>, kernel-team@android.com, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-erofs@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Current check for atomic context is not sufficient as
z_erofs_decompressqueue_endio can be called under rcu lock
from blk_mq_flush_plug_list(). See the stacktrace [1]

In such case we should hand off the decompression work for async
processing rather than trying to do sync decompression in current
context. Patch fixes the detection by checking for
rcu_read_lock_any_held() and while at it use more appropriate
!in_task() check than in_atomic().

Background: Historically erofs would always schedule a kworker for
decompression which would incur the scheduling cost regardless of
the context. But z_erofs_decompressqueue_endio() may not always
be in atomic context and we could actually benefit from doing the
decompression in z_erofs_decompressqueue_endio() if we are in
thread context, for example when running with dm-verity.
This optimization was later added in patch [2] which has shown
improvement in performance benchmarks.

==============================================
[1] Problem stacktrace
[name:core&]BUG: sleeping function called from invalid context at kernel/locking/mutex.c:291
[name:core&]in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1615, name: CpuMonitorServi
[name:core&]preempt_count: 0, expected: 0
[name:core&]RCU nest depth: 1, expected: 0
CPU: 7 PID: 1615 Comm: CpuMonitorServi Tainted: G S      W  OE      6.1.25-android14-5-maybe-dirty-mainline #1
Hardware name: MT6897 (DT)
Call trace:
 dump_backtrace+0x108/0x15c
 show_stack+0x20/0x30
 dump_stack_lvl+0x6c/0x8c
 dump_stack+0x20/0x48
 __might_resched+0x1fc/0x308
 __might_sleep+0x50/0x88
 mutex_lock+0x2c/0x110
 z_erofs_decompress_queue+0x11c/0xc10
 z_erofs_decompress_kickoff+0x110/0x1a4
 z_erofs_decompressqueue_endio+0x154/0x180
 bio_endio+0x1b0/0x1d8
 __dm_io_complete+0x22c/0x280
 clone_endio+0xe4/0x280
 bio_endio+0x1b0/0x1d8
 blk_update_request+0x138/0x3a4
 blk_mq_plug_issue_direct+0xd4/0x19c
 blk_mq_flush_plug_list+0x2b0/0x354
 __blk_flush_plug+0x110/0x160
 blk_finish_plug+0x30/0x4c
 read_pages+0x2fc/0x370
 page_cache_ra_unbounded+0xa4/0x23c
 page_cache_ra_order+0x290/0x320
 do_sync_mmap_readahead+0x108/0x2c0
 filemap_fault+0x19c/0x52c
 __do_fault+0xc4/0x114
 handle_mm_fault+0x5b4/0x1168
 do_page_fault+0x338/0x4b4
 do_translation_fault+0x40/0x60
 do_mem_abort+0x60/0xc8
 el0_da+0x4c/0xe0
 el0t_64_sync_handler+0xd4/0xfc
 el0t_64_sync+0x1a0/0x1a4

[2] Link: https://lore.kernel.org/all/20210317035448.13921-1-huangjianan@oppo.com/

Reported-by: Will Shiu <Will.Shiu@mediatek.com>
Suggested-by: Gao Xiang <xiang@kernel.org>
Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
 fs/erofs/zdata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 264bf553c287..5f1890e309c6 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1447,7 +1447,7 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 	if (atomic_add_return(bios, &io->pending_bios))
 		return;
 	/* Use (kthread_)work and sync decompression for atomic contexts only */
-	if (in_atomic() || irqs_disabled()) {
+	if (!in_task() || irqs_disabled() || rcu_read_lock_any_held()) {
 #ifdef CONFIG_EROFS_FS_PCPU_KTHREAD
 		struct kthread_worker *worker;
 
-- 
2.41.0.162.gfafddb0af9-goog

