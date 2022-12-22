Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 679E8653A38
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Dec 2022 02:15:53 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ncsnb3BmMz3bTD
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Dec 2022 12:15:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1671671747;
	bh=7s8WxSVe5kYllMFW59R9oo3Uz5L7Gc36+20dWCgSI7g=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=OVwur4p9xjmu7RWOva4msOE7QtzB5Hczni8KJkw+4VMDwLuo3vM9qOirSt1KO3unn
	 Pc2DMv+2xqNmDtKfVjoj5QH1e0tGchocrdeO7Bp5ptK7VA5syZdwTR+uf0Y6TIXKQa
	 GuhHHNIA/ytJ0Pm/e41gDg0srAT3qkBy7pi+BnR+yntgLkN6es6bYMGHHGtHV5/bjs
	 I6tvFOX4mzmYyxWNWe6xNGFq3mfVZBaYJiBll6aXEAGvMe2jouqqKWj0PgIllRuWmp
	 yLWnQmwzlJJU5voskq59HIY7xB1uFMklMYSjtZTp/gUe7si0FwrVDZZ86Q3M7yO+ZM
	 vs8vkA/6l/aJw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::64a; helo=mail-pl1-x64a.google.com; envelope-from=3t6-jywckc8grvo9ozsu22uzs.q20zw18b-s52t6zw676.2dzop6.25u@flex--dhavale.bounces.google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=BNdURllP;
	dkim-atps=neutral
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NcsnS6wSSz2xWg
	for <linux-erofs@lists.ozlabs.org>; Thu, 22 Dec 2022 12:15:38 +1100 (AEDT)
Received: by mail-pl1-x64a.google.com with SMTP id c12-20020a170902d48c00b00189e5443387so367191plg.15
        for <linux-erofs@lists.ozlabs.org>; Wed, 21 Dec 2022 17:15:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7s8WxSVe5kYllMFW59R9oo3Uz5L7Gc36+20dWCgSI7g=;
        b=ULypS5lVdasoQOfrV5UtFk+P1zYCXQBNPZCuOvPG2XBl3dMzIeYMOwDeNk1S6EPkY+
         dWw+uQ+IDChJ3MGkciXPUfJrocxZ2wRaps4/t+tD7pUEvcn/KjNuLQUeW7R8PwC0tTxh
         tKz1miHctsRoiHehTRZhoCd7+7C2S20JquN7lG7hBs/aU3dEIHkHSt7hSz6OfidASKKv
         d2dIBufMvLXo/eWZ9Irf5MxDdht7eJtqT7f3lKy3VHCirmWo/N/S9vFjUcLeVG97vmiz
         +P4CTxA46Ve1kZG7aZ3QhUPLOAu7Hri19yPXAg/L9BXk5fU9Dy/0LuJJlynXDOlXfQ2O
         EubA==
X-Gm-Message-State: AFqh2ko43Q+aWqoumNlEmuzJqUu7QtPgY8uz4bUwji0CAqWmMgMzmmpG
	5dqH297jt6qrAlvwL+doWxMWG7GUcq/L
X-Google-Smtp-Source: AMrXdXvA6RU3Y6CIpQmmyh29VCl5x1vaGzuP2rtA36Ce97qyoFPx2KUHqs2UbGiTKS5CNfAo9ZR4YtMDvd/F
X-Received: from dhavale-ctop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:5e39])
 (user=dhavale job=sendgmr) by 2002:a05:6a00:26d3:b0:576:8015:8540 with SMTP
 id p19-20020a056a0026d300b0057680158540mr239844pfw.26.1671671735743; Wed, 21
 Dec 2022 17:15:35 -0800 (PST)
Date: Thu, 22 Dec 2022 01:15:29 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221222011529.3471280-1-dhavale@google.com>
Subject: [PATCH] EROFS: Replace erofs_unzipd workqueue with per-cpu threads
To: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org, kernel-team@android.com, linux-kernel@vger.kernel.org, Sandeep Dhavale <dhavale@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Using per-cpu thread pool we can reduce the scheduling latency compared
to workqueue implementation. With this patch scheduling latency and
variation is reduced as per-cpu threads are SCHED_FIFO kthread_workers.

The results were evaluated on arm64 Android devices running 5.10 kernel.

The table below shows resulting improvements of total scheduling latency
for the same app launch benchmark runs with 50 iterations. Scheduling
latency is the latency between when the task (workqueue kworker vs
kthread_worker) became eligible to run to when it actually started
running.
+-------------------------+-----------+----------------+---------+
|                         | workqueue | kthread_worker |  diff   |
+-------------------------+-----------+----------------+---------+
| Average (us)            |     15253 |           2914 | -80.89% |
| Median (us)             |     14001 |           2912 | -79.20% |
| Minimum (us)            |      3117 |           1027 | -67.05% |
| Maximum (us)            |     30170 |           3805 | -87.39% |
| Standard deviation (us) |      7166 |            359 |         |
+-------------------------+-----------+----------------+---------+

Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
 fs/erofs/zdata.c | 84 +++++++++++++++++++++++++++++++++++-------------
 fs/erofs/zdata.h |  4 ++-
 2 files changed, 64 insertions(+), 24 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index ccf7c55d477f..646667dbe615 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -8,6 +8,7 @@
 #include "compress.h"
 #include <linux/prefetch.h>
 #include <linux/psi.h>
+#include <linux/slab.h>
 
 #include <trace/events/erofs.h>
 
@@ -184,26 +185,56 @@ typedef tagptr1_t compressed_page_t;
 #define tag_compressed_page_justfound(page) \
 	tagptr_fold(compressed_page_t, page, 1)
 
-static struct workqueue_struct *z_erofs_workqueue __read_mostly;
+static struct kthread_worker **z_erofs_kthread_pool;
 
-void z_erofs_exit_zip_subsystem(void)
+static void z_erofs_destroy_kthread_pool(void)
 {
-	destroy_workqueue(z_erofs_workqueue);
-	z_erofs_destroy_pcluster_pool();
+	unsigned long cpu;
+
+	for_each_possible_cpu(cpu) {
+		if (z_erofs_kthread_pool[cpu]) {
+			kthread_destroy_worker(z_erofs_kthread_pool[cpu]);
+			z_erofs_kthread_pool[cpu] = NULL;
+		}
+	}
+	kfree(z_erofs_kthread_pool);
 }
 
-static inline int z_erofs_init_workqueue(void)
+static int z_erofs_create_kthread_workers(void)
 {
-	const unsigned int onlinecpus = num_possible_cpus();
+	unsigned long cpu;
+	struct kthread_worker *worker;
+
+	for_each_possible_cpu(cpu) {
+		worker = kthread_create_worker_on_cpu(cpu, 0, "z_erofs/%ld", cpu);
+		if (IS_ERR(worker)) {
+			z_erofs_destroy_kthread_pool();
+			return -ENOMEM;
+		}
+		sched_set_fifo(worker->task);
+		z_erofs_kthread_pool[cpu] = worker;
+	}
+	return 0;
+}
 
-	/*
-	 * no need to spawn too many threads, limiting threads could minimum
-	 * scheduling overhead, perhaps per-CPU threads should be better?
-	 */
-	z_erofs_workqueue = alloc_workqueue("erofs_unzipd",
-					    WQ_UNBOUND | WQ_HIGHPRI,
-					    onlinecpus + onlinecpus / 4);
-	return z_erofs_workqueue ? 0 : -ENOMEM;
+static int z_erofs_init_kthread_pool(void)
+{
+	int err;
+
+	z_erofs_kthread_pool = kcalloc(num_possible_cpus(),
+			sizeof(struct kthread_worker *), GFP_ATOMIC);
+	if (!z_erofs_kthread_pool)
+		return -ENOMEM;
+	err = z_erofs_create_kthread_workers();
+
+	return err;
+}
+
+
+void z_erofs_exit_zip_subsystem(void)
+{
+	z_erofs_destroy_kthread_pool();
+	z_erofs_destroy_pcluster_pool();
 }
 
 int __init z_erofs_init_zip_subsystem(void)
@@ -211,10 +242,16 @@ int __init z_erofs_init_zip_subsystem(void)
 	int err = z_erofs_create_pcluster_pool();
 
 	if (err)
-		return err;
-	err = z_erofs_init_workqueue();
+		goto out_error_pcluster_pool;
+
+	err = z_erofs_init_kthread_pool();
 	if (err)
-		z_erofs_destroy_pcluster_pool();
+		goto out_error_kthread_pool;
+
+	return err;
+out_error_kthread_pool:
+	z_erofs_destroy_pcluster_pool();
+out_error_pcluster_pool:
 	return err;
 }
 
@@ -1143,7 +1180,7 @@ static void z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
 	}
 }
 
-static void z_erofs_decompressqueue_work(struct work_struct *work)
+static void z_erofs_decompressqueue_kthread_work(struct kthread_work *work)
 {
 	struct z_erofs_decompressqueue *bgq =
 		container_of(work, struct z_erofs_decompressqueue, u.work);
@@ -1170,15 +1207,16 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 
 	if (atomic_add_return(bios, &io->pending_bios))
 		return;
-	/* Use workqueue and sync decompression for atomic contexts only */
+	/* Use kthread_workers and sync decompression for atomic contexts only */
 	if (in_atomic() || irqs_disabled()) {
-		queue_work(z_erofs_workqueue, &io->u.work);
+		kthread_queue_work(z_erofs_kthread_pool[raw_smp_processor_id()],
+			       &io->u.work);
 		/* enable sync decompression for readahead */
 		if (sbi->opt.sync_decompress == EROFS_SYNC_DECOMPRESS_AUTO)
 			sbi->opt.sync_decompress = EROFS_SYNC_DECOMPRESS_FORCE_ON;
 		return;
 	}
-	z_erofs_decompressqueue_work(&io->u.work);
+	z_erofs_decompressqueue_kthread_work(&io->u.work);
 }
 
 static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
@@ -1306,7 +1344,7 @@ jobqueue_init(struct super_block *sb,
 			*fg = true;
 			goto fg_out;
 		}
-		INIT_WORK(&q->u.work, z_erofs_decompressqueue_work);
+		kthread_init_work(&q->u.work, z_erofs_decompressqueue_kthread_work);
 	} else {
 fg_out:
 		q = fgq;
@@ -1500,7 +1538,7 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 
 	/*
 	 * although background is preferred, no one is pending for submission.
-	 * don't issue workqueue for decompression but drop it directly instead.
+	 * don't issue kthread_work for decompression but drop it directly instead.
 	 */
 	if (!*force_fg && !nr_bios) {
 		kvfree(q[JQ_SUBMIT]);
diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index d98c95212985..808bbbf71b7b 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -6,6 +6,8 @@
 #ifndef __EROFS_FS_ZDATA_H
 #define __EROFS_FS_ZDATA_H
 
+#include <linux/kthread.h>
+
 #include "internal.h"
 #include "tagptr.h"
 
@@ -107,7 +109,7 @@ struct z_erofs_decompressqueue {
 
 	union {
 		struct completion done;
-		struct work_struct work;
+		struct kthread_work work;
 	} u;
 
 	bool eio;
-- 
2.39.0.314.g84b9a713c41-goog

