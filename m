Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDD55107D9
	for <lists+linux-erofs@lfdr.de>; Tue, 26 Apr 2022 21:02:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Knrps4FRgz3bcZ
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Apr 2022 05:02:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=cJ+h3nGs;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=cJ+h3nGs; 
 dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Knrpp0xnVz2yNG
 for <linux-erofs@lists.ozlabs.org>; Wed, 27 Apr 2022 05:02:09 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 83416CE20E9;
 Tue, 26 Apr 2022 19:02:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1E0C385AF;
 Tue, 26 Apr 2022 19:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650999724;
 bh=lZSgcARiKu563cMVPF9TLhAYaBQcnyIOkxgPX0ZQyPk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cJ+h3nGs0WIRmXyRDFcnxccbAvEBreyfrwWZJ4KS+oEj3XsVqDQV9+7aEhsKpBVva
 je6xFRnVpZpuC30gdMdSUab09P7sWVOlvG/hoHzKnsau2LCnHJXURVT0ASTGuLQ0Mo
 CEOlwdDrqgpoab5NUO9ZEPSHkyLj5XSgitV+kGWLzGQ7LxplmWwAUGBw5XjtBZTVO9
 9OcFcKTsmf2qK0/Tg08POWlnqR5gypmuJnvDsClzTseu/1Tjttrw88skoYZzCfs1yX
 zVlN6RWv2/a5BKXmtSTRVWoZdSSX+Dsmsu1EeZw/ZY6GpMJAOtkSSWXMQWjDNCEbmt
 eTl7yJoN9S9vw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.17 13/22] erofs: fix use-after-free of on-stack io[]
Date: Tue, 26 Apr 2022 15:01:36 -0400
Message-Id: <20220426190145.2351135-13-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220426190145.2351135-1-sashal@kernel.org>
References: <20220426190145.2351135-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
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
Cc: Sasha Levin <sashal@kernel.org>, Hongyu Jin <hongyu.jin@unisoc.com>,
 Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Hongyu Jin <hongyu.jin@unisoc.com>

[ Upstream commit 60b30050116c0351b90154044345c1b53ae1f323 ]

The root cause is the race as follows:
Thread #1                              Thread #2(irq ctx)

z_erofs_runqueue()
  struct z_erofs_decompressqueue io_A[];
  submit bio A
  z_erofs_decompress_kickoff(,,1)
                                       z_erofs_decompressqueue_endio(bio A)
                                       z_erofs_decompress_kickoff(,,-1)
                                       spin_lock_irqsave()
                                       atomic_add_return()
  io_wait_event()	-> pending_bios is already 0
  [end of function]
                                       wake_up_locked(io_A[]) // crash

Referenced backtrace in kernel 5.4:

[   10.129422] Unable to handle kernel paging request at virtual address eb0454a4
[   10.364157] CPU: 0 PID: 709 Comm: getprop Tainted: G        WC O      5.4.147-ab09225 #1
[   11.556325] [<c01b33b8>] (__wake_up_common) from [<c01b3300>] (__wake_up_locked+0x40/0x48)
[   11.565487] [<c01b3300>] (__wake_up_locked) from [<c044c8d0>] (z_erofs_vle_unzip_kickoff+0x6c/0xc0)
[   11.575438] [<c044c8d0>] (z_erofs_vle_unzip_kickoff) from [<c044c854>] (z_erofs_vle_read_endio+0x16c/0x17c)
[   11.586082] [<c044c854>] (z_erofs_vle_read_endio) from [<c06a80e8>] (clone_endio+0xb4/0x1d0)
[   11.595428] [<c06a80e8>] (clone_endio) from [<c04a1280>] (blk_update_request+0x150/0x4dc)
[   11.604516] [<c04a1280>] (blk_update_request) from [<c06dea28>] (mmc_blk_cqe_complete_rq+0x144/0x15c)
[   11.614640] [<c06dea28>] (mmc_blk_cqe_complete_rq) from [<c04a5d90>] (blk_done_softirq+0xb0/0xcc)
[   11.624419] [<c04a5d90>] (blk_done_softirq) from [<c010242c>] (__do_softirq+0x184/0x56c)
[   11.633419] [<c010242c>] (__do_softirq) from [<c01051e8>] (irq_exit+0xd4/0x138)
[   11.641640] [<c01051e8>] (irq_exit) from [<c010c314>] (__handle_domain_irq+0x94/0xd0)
[   11.650381] [<c010c314>] (__handle_domain_irq) from [<c04fde70>] (gic_handle_irq+0x50/0xd4)
[   11.659641] [<c04fde70>] (gic_handle_irq) from [<c0101b70>] (__irq_svc+0x70/0xb0)

Signed-off-by: Hongyu Jin <hongyu.jin@unisoc.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Link: https://lore.kernel.org/r/20220401115527.4935-1-hongyu.jin.cn@gmail.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/zdata.c | 12 ++++--------
 fs/erofs/zdata.h |  2 +-
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 423bc1a61da5..a1b48bcafe63 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1073,12 +1073,9 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 
 	/* wake up the caller thread for sync decompression */
 	if (sync) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&io->u.wait.lock, flags);
 		if (!atomic_add_return(bios, &io->pending_bios))
-			wake_up_locked(&io->u.wait);
-		spin_unlock_irqrestore(&io->u.wait.lock, flags);
+			complete(&io->u.done);
+
 		return;
 	}
 
@@ -1224,7 +1221,7 @@ jobqueue_init(struct super_block *sb,
 	} else {
 fg_out:
 		q = fgq;
-		init_waitqueue_head(&fgq->u.wait);
+		init_completion(&fgq->u.done);
 		atomic_set(&fgq->pending_bios, 0);
 	}
 	q->sb = sb;
@@ -1428,8 +1425,7 @@ static void z_erofs_runqueue(struct super_block *sb,
 		return;
 
 	/* wait until all bios are completed */
-	io_wait_event(io[JQ_SUBMIT].u.wait,
-		      !atomic_read(&io[JQ_SUBMIT].pending_bios));
+	wait_for_completion_io(&io[JQ_SUBMIT].u.done);
 
 	/* handle synchronous decompress queue in the caller context */
 	z_erofs_decompress_queue(&io[JQ_SUBMIT], pagepool);
diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index e043216b545f..800b11c53f57 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -97,7 +97,7 @@ struct z_erofs_decompressqueue {
 	z_erofs_next_pcluster_t head;
 
 	union {
-		wait_queue_head_t wait;
+		struct completion done;
 		struct work_struct work;
 	} u;
 };
-- 
2.35.1

