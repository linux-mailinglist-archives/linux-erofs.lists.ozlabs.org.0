Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91741957E72
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Aug 2024 08:41:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wp0Gs1xZwz2y8g
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Aug 2024 16:41:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qq2CClhW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wp0Gj5FDtz2xtp
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Aug 2024 16:40:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724136055; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=AqPhpfwx9Zg6Vl1F/hgoB8kEbAKhdADFqdRONZMQ4wE=;
	b=qq2CClhW7rJ095IQKOAuxkRQcJD+K7Rm3Jha2QquHLnXcanM9VNOqnCEExNwwTbI74ZZIxDlGN8jk3evQwhvAqvAbvsEOIr3kwkrdSv/21DDPY9TbqOhmpTyrSS1bCN0XVIjpuavadAFviE6tIK2pgjRze7oA59UjpD5JmEOv9s=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WDHRe59_1724136050)
          by smtp.aliyun-inc.com;
          Tue, 20 Aug 2024 14:40:54 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fix an indefinite wait race
Date: Tue, 20 Aug 2024 14:40:49 +0800
Message-ID: <20240820064049.1240139-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Coverity reports: In erofs_mkfs_flushjobs, a thread waits for
a thread-shared condition that may have already been satisfied,
causing a hang.

It might indeed happen if the dfops worker runs with the specific
timing.  Let's try to fix it and see if the report is cleared.

Coverity-id: 502330
Fixes: 37e5abcd8720 ("erofs-utils: mkfs: assign root NID in the main thread")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/inode.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index b9dbbd6..96f01b9 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1326,6 +1326,7 @@ struct erofs_mkfs_dfops {
 	pthread_cond_t full, empty, drain;
 	struct erofs_mkfs_jobitem *queue;
 	unsigned int entries, head, tail;
+	bool idle;	/* initialize as false before the dfops worker runs */
 };
 
 #define EROFS_MT_QUEUE_SIZE 128
@@ -1335,7 +1336,8 @@ static void erofs_mkfs_flushjobs(struct erofs_sb_info *sbi)
 	struct erofs_mkfs_dfops *q = sbi->mkfs_dfops;
 
 	pthread_mutex_lock(&q->lock);
-	pthread_cond_wait(&q->drain, &q->lock);
+	if (!q->idle)
+		pthread_cond_wait(&q->drain, &q->lock);
 	pthread_mutex_unlock(&q->lock);
 }
 
@@ -1345,12 +1347,15 @@ static void *erofs_mkfs_pop_jobitem(struct erofs_mkfs_dfops *q)
 
 	pthread_mutex_lock(&q->lock);
 	while (q->head == q->tail) {
+		/* the worker has handled everything only if sleeping here */
+		q->idle = true;
 		pthread_cond_signal(&q->drain);
 		pthread_cond_wait(&q->empty, &q->lock);
 	}
 
 	item = q->queue + q->head;
 	q->head = (q->head + 1) & (q->entries - 1);
+	q->idle = false;
 
 	pthread_cond_signal(&q->full);
 	pthread_mutex_unlock(&q->lock);
@@ -1812,7 +1817,7 @@ static int erofs_mkfs_build_tree(struct erofs_mkfs_buildtree_ctx *ctx)
 	int err, err2;
 	struct erofs_sb_info *sbi = ctx->sbi ? ctx->sbi : ctx->u.root->sbi;
 
-	q = malloc(sizeof(*q));
+	q = calloc(1, sizeof(*q));
 	if (!q)
 		return -ENOMEM;
 
@@ -1827,8 +1832,6 @@ static int erofs_mkfs_build_tree(struct erofs_mkfs_buildtree_ctx *ctx)
 	pthread_cond_init(&q->full, NULL);
 	pthread_cond_init(&q->drain, NULL);
 
-	q->head = 0;
-	q->tail = 0;
 	sbi->mkfs_dfops = q;
 	err = pthread_create(&sbi->dfops_worker, NULL,
 			     z_erofs_mt_dfops_worker, sbi);
-- 
2.43.5

