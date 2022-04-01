Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBFF4EE83C
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Apr 2022 08:33:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KV9NL05dHz2yw1
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Apr 2022 17:33:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=WoNiWEEr;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::82a;
 helo=mail-qt1-x82a.google.com; envelope-from=hongyu.jin.cn@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=WoNiWEEr; dkim-atps=neutral
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KV9ND4v43z2yJF
 for <linux-erofs@lists.ozlabs.org>; Fri,  1 Apr 2022 17:33:16 +1100 (AEDT)
Received: by mail-qt1-x82a.google.com with SMTP id a11so1408576qtb.12
 for <linux-erofs@lists.ozlabs.org>; Thu, 31 Mar 2022 23:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SqNkjGMdx19rOQwmIoNh25UIriLkrLW9XqSKxf4BlxM=;
 b=WoNiWEEr3lUtIdM8++lqs9EvesAMK5QxgMsHPr3Lgy0ukwwby/jnjhEEJAffjOtCVo
 I4VO69z1IKfrfPROzlqOuyvJRLbhIetO6mFh7XJEXzS509Dvuf5NrYAnB/gXA62NLy6R
 HVGUYflHMndn8mHWBpFqa+0vAd6u4dx/lkWuWxbjqffpdF6BVNbm5wM+WYuZHTJevIBz
 CXuFfSUWV+r2/xrJW5CwsUzwV++hdX3+hgYf7fXTE/KI0rXFC9mrfP84CDnLQ8ZgQps+
 Rm2UbO2aQR7u98yUoJJOoHxWEUlBci2Jxx/PPb9M4+GHcxqBpamiXWH/WgKjVGQ2CByx
 AKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SqNkjGMdx19rOQwmIoNh25UIriLkrLW9XqSKxf4BlxM=;
 b=AME7ZudQQEXeWS0nUxUxcDxsWAljMbHYiLk+PzhnwF1GCUF6wiqzKnUlB/I+/hm3Tj
 iSLQ9PIF3ujCFkHyQ9SoHCNOgZIXI0J6yyfGaeHKTZtwzf2EkDgklBaO3yj+tY0kmQUj
 +6OU1tK6VhsX4vn5cGZn5hJYPCWhYYiu6C9dapkfvUAWfShen9onEH3VCNXrmRIIvvjl
 bA1i7ZlqmawwOMFaDsqG3NIUa6y9JPBeHdblBcFXJ4z1OeZYWB3G7BzlVHyQ21v4eFdR
 w8R5y0nxpOmh5RJeADDJkheDdrKGO8oBQ9CV9p0WG8L6mrI+GSc0+wABwTDHEhkY1K4S
 ZB/Q==
X-Gm-Message-State: AOAM531XleAanMnRRGD9KtSGNSTVNNHT4GW1VL58yxWUccCP95gJArtP
 XP1Yj7As469tUHRF4Je4EDU4ktIbm5MTqJ/r
X-Google-Smtp-Source: ABdhPJzvvc7yn5xWBurnSZdDwNUXeIIbzlvscsgVJUJoGYhgh63UgMmKTTG5bNezulTKNuSjRYCpig==
X-Received: by 2002:a05:622a:492:b0:2e1:ee8a:b1c0 with SMTP id
 p18-20020a05622a049200b002e1ee8ab1c0mr7265242qtx.162.1648794790906; 
 Thu, 31 Mar 2022 23:33:10 -0700 (PDT)
Received: from localhost.localdomain ([117.18.48.102])
 by smtp.gmail.com with ESMTPSA id
 br13-20020a05620a460d00b00680d020b4cbsm822841qkb.10.2022.03.31.23.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Mar 2022 23:33:10 -0700 (PDT)
From: Hongyu Jin <hongyu.jin.cn@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: fix use-after-free of on-stack io[]
Date: Fri,  1 Apr 2022 14:33:01 +0800
Message-Id: <20220401063301.3150-1-hongyu.jin.cn@gmail.com>
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

The root cause is the race as follows(k5.4):
Thread #1                               Thread #2(irq ctx)

z_erofs_submit_and_unzip()
  struct z_erofs_vle_unzip_io io_A[]
  submit bio A
                                        z_erofs_vle_read_endio() // bio A
                                        z_erofs_vle_unzip_kickoff()
                                        spin_lock_irqsave()
                                        atomic_add_return()
  wait_event()
  [end of function]
z_erofs_submit_and_unzip() // bio B
                                        wake_up_locked(io_A[]) // crash
  struct z_erofs_vle_unzip_io io_B[]
  submit bio B
  wait_event()

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
 fs/erofs/zdata.c | 12 ++++--------
 fs/erofs/zdata.h |  2 +-
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 11c7a1aaebad..4c26faa817a3 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -782,12 +782,9 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 
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
 
@@ -1207,7 +1204,7 @@ jobqueue_init(struct super_block *sb,
 	} else {
 fg_out:
 		q = fgq;
-		init_waitqueue_head(&fgq->u.wait);
+		init_completion(&fgq->u.done);
 		atomic_set(&fgq->pending_bios, 0);
 	}
 	q->sb = sb;
@@ -1370,8 +1367,7 @@ static void z_erofs_runqueue(struct super_block *sb,
 		return;
 
 	/* wait until all bios are completed */
-	io_wait_event(io[JQ_SUBMIT].u.wait,
-		      !atomic_read(&io[JQ_SUBMIT].pending_bios));
+	wait_for_completion_io(&io[JQ_SUBMIT].u.done);
 
 	/* handle synchronous decompress queue in the caller context */
 	z_erofs_decompress_queue(&io[JQ_SUBMIT], pagepool);
diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index 3a008f1b9f78..1027ffe744a2 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -89,7 +89,7 @@ struct z_erofs_decompressqueue {
 	z_erofs_next_pcluster_t head;
 
 	union {
-		wait_queue_head_t wait;
+		struct completion done;
 		struct work_struct work;
 	} u;
 };
-- 
2.25.1

