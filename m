Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A90D29EC276
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Dec 2024 03:50:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y7Kpb4fCTz30Vv
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Dec 2024 13:50:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733885429;
	cv=none; b=Vt5Hfx55L2TAUe0XK1hpCadINWJmc2Pl+5JF6m4QuyzknTZUFJs7rKKqlixgUEKUYPmleuIBePrL05i/DQWvW021hxHGqzO41qNMXXPz/sfrtsA7iLZWf/lX4lcJJlF0n7DjcHLzF4g9kGaja9JxG3wHnV/0xsXcSUPErtUy9oAh0+RjBdS4xHv5Ilb26cFg04pUmF0VOFMdquIlhQ+AYU7vL8leVs93xl85x1kdbZFg4chftgK37C9sBz29CFV9gBvhLe4aeL0XGPv5DAUpeGge/wtEOWxQDTqadoXdBYRXSipigkmXrP5G6Nn48LHFzNpwE5f2BsN2mQwpN9dQAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733885429; c=relaxed/relaxed;
	bh=Jw545oj4nm7i32IG7IfJ5qZEO4HgHzgUapkz7yjmpZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GqY0yBK2maguZu+xVjl5avJ4QM2PtbASujBAd7w0EotVIXMOH8BnQBxWvLP5OpBmh1sPwGsiXoVWARs0vFBmN9bKojl9LjjVi374WIVNCDdHbmiUaDwe+pYd/6UN5RZYm3m196R9sZxa+9Qg9Gfan5/+WGayvMrg3XV7OsydqlhMLKSFV4vgfsbYQ2F41Dtd45NYk6SY080SVvu3q77G/XTOjM0gvCWbX2uwgGWDYUPRw50qet62g2def1lCIMX8MHvYV2W8v+saOKDGPgcNmAPDygUMgVi6vho4BY1TDKOs64ewUbf05LeW7wpvb7m92vm+4IMnQbbtVUozziLwjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=L5WeiIBq; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=L5WeiIBq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y7KpV6Zwjz30St
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Dec 2024 13:50:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733885416; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Jw545oj4nm7i32IG7IfJ5qZEO4HgHzgUapkz7yjmpZs=;
	b=L5WeiIBqLxVaawPNl4RiAFJaWW55fBAS+1QXlD+WrwVGTqt69ZsOpFz60Z4ng2j6TDnVIsCIqFomtswqz4iW1nEs9IHW69BhgUZ+2mXRA8+n1gfzD3d5xTI/lwBBsJ7nRk1udC/yA7s3/050IyT7j0UdGiLdqO/8hheI0I7ejDU=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WLGib84_1733885410 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Dec 2024 10:50:15 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: lib: get rid of pthread_cancel() for workqueue
Date: Wed, 11 Dec 2024 10:50:09 +0800
Message-ID: <20241211025009.3393476-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Yifan Zhao <zhaoyifan@sjtu.edu.cn>, Kelvin Zhang <zhangkelvin@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Bionic (Android's libc) does not have pthread_cancel, call
erofs_destroy_workqueue() when initialization fails.

Cc: Kelvin Zhang <zhangkelvin@google.com>
Cc: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
https://lore.kernel.org/r/20241002174308.2585690-1-zhangkelvin@google.com
https://lore.kernel.org/r/20241002174912.42486-1-zhaoyifan@sjtu.edu.cn

 lib/workqueue.c | 63 ++++++++++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/lib/workqueue.c b/lib/workqueue.c
index 47cec9b..840c204 100644
--- a/lib/workqueue.c
+++ b/lib/workqueue.c
@@ -15,9 +15,9 @@ static void *worker_thread(void *arg)
 	while (true) {
 		pthread_mutex_lock(&wq->lock);
 
-		while (wq->job_count == 0 && !wq->shutdown)
+		while (!wq->job_count && !wq->shutdown)
 			pthread_cond_wait(&wq->cond_empty, &wq->lock);
-		if (wq->job_count == 0 && wq->shutdown) {
+		if (!wq->job_count && wq->shutdown) {
 			pthread_mutex_unlock(&wq->lock);
 			break;
 		}
@@ -40,6 +40,29 @@ static void *worker_thread(void *arg)
 	return NULL;
 }
 
+int erofs_destroy_workqueue(struct erofs_workqueue *wq)
+{
+	if (!wq)
+		return -EINVAL;
+
+	pthread_mutex_lock(&wq->lock);
+	wq->shutdown = true;
+	pthread_cond_broadcast(&wq->cond_empty);
+	pthread_mutex_unlock(&wq->lock);
+
+	while (wq->nworker) {
+		int ret = -pthread_join(wq->workers[wq->nworker - 1], NULL);
+
+		if (ret)
+			return ret;
+		--wq->nworker;
+	}
+	free(wq->workers);
+	pthread_mutex_destroy(&wq->lock);
+	pthread_cond_destroy(&wq->cond_empty);
+	pthread_cond_destroy(&wq->cond_full);
+	return 0;
+}
 int erofs_alloc_workqueue(struct erofs_workqueue *wq, unsigned int nworker,
 			  unsigned int max_jobs, erofs_wq_func_t on_start,
 			  erofs_wq_func_t on_exit)
@@ -51,7 +74,6 @@ int erofs_alloc_workqueue(struct erofs_workqueue *wq, unsigned int nworker,
 		return -EINVAL;
 
 	wq->head = wq->tail = NULL;
-	wq->nworker = nworker;
 	wq->max_jobs = max_jobs;
 	wq->job_count = 0;
 	wq->shutdown = false;
@@ -67,14 +89,13 @@ int erofs_alloc_workqueue(struct erofs_workqueue *wq, unsigned int nworker,
 
 	for (i = 0; i < nworker; i++) {
 		ret = pthread_create(&wq->workers[i], NULL, worker_thread, wq);
-		if (ret) {
-			while (i)
-				pthread_cancel(wq->workers[--i]);
-			free(wq->workers);
-			return ret;
-		}
+		if (ret)
+			break;
 	}
-	return 0;
+	wq->nworker = i;
+	if (ret)
+		erofs_destroy_workqueue(wq);
+	return ret;
 }
 
 int erofs_queue_work(struct erofs_workqueue *wq, struct erofs_work *work)
@@ -99,25 +120,3 @@ int erofs_queue_work(struct erofs_workqueue *wq, struct erofs_work *work)
 	pthread_mutex_unlock(&wq->lock);
 	return 0;
 }
-
-int erofs_destroy_workqueue(struct erofs_workqueue *wq)
-{
-	unsigned int i;
-
-	if (!wq)
-		return -EINVAL;
-
-	pthread_mutex_lock(&wq->lock);
-	wq->shutdown = true;
-	pthread_cond_broadcast(&wq->cond_empty);
-	pthread_mutex_unlock(&wq->lock);
-
-	for (i = 0; i < wq->nworker; i++)
-		pthread_join(wq->workers[i], NULL);
-
-	free(wq->workers);
-	pthread_mutex_destroy(&wq->lock);
-	pthread_cond_destroy(&wq->cond_empty);
-	pthread_cond_destroy(&wq->cond_full);
-	return 0;
-}
-- 
2.43.5

