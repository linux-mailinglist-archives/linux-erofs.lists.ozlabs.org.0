Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F22694EECA5
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Apr 2022 13:55:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KVJXT5ldlz2yxP
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Apr 2022 22:55:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Se1u4B0D;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f2b;
 helo=mail-qv1-xf2b.google.com; envelope-from=hongyu.jin.cn@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=Se1u4B0D; dkim-atps=neutral
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KVJXP4Qc2z2xSM
 for <linux-erofs@lists.ozlabs.org>; Fri,  1 Apr 2022 22:55:47 +1100 (AEDT)
Received: by mail-qv1-xf2b.google.com with SMTP id kd21so1813139qvb.6
 for <linux-erofs@lists.ozlabs.org>; Fri, 01 Apr 2022 04:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0ZwdWLDL9/cktHEaTg2C7/VovaE9PeITf4iJGIUdfOU=;
 b=Se1u4B0DIyIRAoRb2kkqYjldGNqX8EaD3ce113Lasz0ZN4EnOZjW1ALvOEaQiVo0ut
 7R/AApiGBYDupx/RZzA0/WbMAlkkUTBhyF1aHc+XMY6h9t/QaEJARtgnXQvOkT0rs+5u
 R1lacY+El6vrk3aNJrqDYsF0yP40Z1k64Ce06EvQTb6lx1r5hGTuqzwovVx82sn6Huqm
 FlbcCGGN+1JjbEVcfa/fXAKchdGGQXOHZv3EtJ93YgCGPV78/uTbcatEOwv+VTelCSQo
 J/pWWOkHsKqUVz1El5wrSAHib4kJhiFReKNfT/S3+k0cVx27C3D68ivsI0zB8+rExMaw
 3XbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0ZwdWLDL9/cktHEaTg2C7/VovaE9PeITf4iJGIUdfOU=;
 b=G5jDr5ceixDcOM8KpgT0d+ZKShBRzQ8md0OK77bxjkh6EQ4VDJi4E/ts1FIer7Uj/2
 HFr6XV6w4FpsE4yIVzSzaMwSZ4Xug6SRB7wNOlJEZqPlS1nwSXlH62o1il1DOuPrWKYj
 bllRPQbEh1eae2PymOfpFtEGCfpmdiQnexWsTmhshNvdXe9vnQYF2MhUmW74o5EJSfVP
 Kf1zgABu6JC85g3Hw6yfndcA8wcbYxOFgrSG9RhRgUSjIt6OD++Kj3w90yr406Yv40Dr
 qxUdOnEXRd8h6twuLCJ2OtJjnJskAO/yEanJDK4dQqz/0kRrmCGuk7vylammtSOSIizl
 zhEQ==
X-Gm-Message-State: AOAM530VzJk/x6SRbRC59fpj8FVaPCKmTAiLLx5QQJ6U+1Dqywm335Ge
 Cxn/El1hoLoEhZ5ReSv5Zk2Tx9puVFDrS3nq
X-Google-Smtp-Source: ABdhPJzwF9jXBCubUv7qVSf8zAQxEUqNCoqbqh5w6tGy7mPzGJnThWJNCqlQRz5yxZ34haGfe4VW9A==
X-Received: by 2002:a05:6214:528b:b0:441:13b4:9523 with SMTP id
 kj11-20020a056214528b00b0044113b49523mr7285325qvb.3.1648814142179; 
 Fri, 01 Apr 2022 04:55:42 -0700 (PDT)
Received: from localhost.localdomain ([117.18.48.102])
 by smtp.gmail.com with ESMTPSA id
 f19-20020a05620a409300b00680c933fb1csm1370484qko.20.2022.04.01.04.55.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Apr 2022 04:55:41 -0700 (PDT)
From: Hongyu Jin <hongyu.jin.cn@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs: fix use-after-free of on-stack io[]
Date: Fri,  1 Apr 2022 19:55:27 +0800
Message-Id: <20220401115527.4935-1-hongyu.jin.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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
Cc: hongyu.jin.cn@gmail.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Hongyu Jin <hongyu.jin@unisoc.com>

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
  io_wait_event()
  [end of function]
z_erofs_runqueue() // bio B
                                       wake_up_locked(io_A[]) // crash
  struct z_erofs_decompressqueue io_B[];
  submit bio B
  z_erofs_decompress_kickoff(,,1)

Backtrace in kernel5.4:
[   10.129413] 8<--- cut here ---
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
---
Changes in v2:
 - Turn the race function names in commit message to the current 

 fs/erofs/zdata.c | 12 ++++--------
 fs/erofs/zdata.h |  2 +-
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 0ed880f42525..e6dea6dfca16 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1066,12 +1066,9 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 
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
 
@@ -1217,7 +1214,7 @@ jobqueue_init(struct super_block *sb,
 	} else {
 fg_out:
 		q = fgq;
-		init_waitqueue_head(&fgq->u.wait);
+		init_completion(&fgq->u.done);
 		atomic_set(&fgq->pending_bios, 0);
 	}
 	q->sb = sb;
@@ -1419,8 +1416,7 @@ static void z_erofs_runqueue(struct super_block *sb,
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
2.25.1

