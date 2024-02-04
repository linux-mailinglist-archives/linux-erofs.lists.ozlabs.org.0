Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A07848CE2
	for <lists+linux-erofs@lfdr.de>; Sun,  4 Feb 2024 11:34:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TSQqc50L3z3bsd
	for <lists+linux-erofs@lfdr.de>; Sun,  4 Feb 2024 21:34:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TSQqZ4zzPz30Pp
	for <linux-erofs@lists.ozlabs.org>; Sun,  4 Feb 2024 21:34:34 +1100 (AEDT)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 454091008AEC4;
	Sun,  4 Feb 2024 18:34:24 +0800 (CST)
Received: from zhaoyf.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 951BB381F4B;
	Sun,  4 Feb 2024 18:34:20 +0800 (CST)
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 5/7] erofs-utils: extend multi-threading framework for per-thread fields
Date: Sun,  4 Feb 2024 18:34:18 +0800
Message-ID: <20240204103418.141644-1-zhaoyifan@sjtu.edu.cn>
X-Mailer: git-send-email 2.43.0
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
Cc: hsiangkao@linux.alibaba.com, Yifan Zhao <zhaoyifan@sjtu.edu.cn>, xin_tong@sjtu.edu.cn
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Currently each worker thread is stateless. This patch allows us to bind
some per-worker fields to each worker thread, which could be reused
accross different tasks.

One of the examples is the compressor and buffer used in multi-threaded
compression.

Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
---
 include/erofs/workqueue.h | 10 +++++++---
 lib/workqueue.c           | 19 ++++++++++++++++++-
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/include/erofs/workqueue.h b/include/erofs/workqueue.h
index d0ebc5a..a11a8fc 100644
--- a/include/erofs/workqueue.h
+++ b/include/erofs/workqueue.h
@@ -13,11 +13,13 @@ struct erofs_work;
 
 typedef void erofs_workqueue_func_t(struct erofs_workqueue *wq,
 				    struct erofs_work *work);
+typedef void erofs_wq_priv_fini_t(void *);
 
 struct erofs_work {
 	struct erofs_workqueue	*queue;
 	struct erofs_work	*next;
 	erofs_workqueue_func_t	*function;
+	void 			*private;
 };
 
 struct erofs_workqueue {
@@ -32,12 +34,14 @@ struct erofs_workqueue {
 	bool			terminated;
 	int			max_queued;
 	pthread_cond_t		queue_full;
+	size_t			private_size;
+	erofs_wq_priv_fini_t	*private_fini;
 };
 
-int erofs_workqueue_create(struct erofs_workqueue *wq,
+int erofs_workqueue_create(struct erofs_workqueue *wq, size_t private_size,
+			   erofs_wq_priv_fini_t *private_fini,
 			   unsigned int nr_workers, unsigned int max_queue);
-int erofs_workqueue_add(struct erofs_workqueue	*wq,
-			struct erofs_work *wi);
+int erofs_workqueue_add(struct erofs_workqueue *wq, struct erofs_work *wi);
 int erofs_workqueue_terminate(struct erofs_workqueue *wq);
 void erofs_workqueue_destroy(struct erofs_workqueue *wq);
 
diff --git a/lib/workqueue.c b/lib/workqueue.c
index 6573821..01d12d9 100644
--- a/lib/workqueue.c
+++ b/lib/workqueue.c
@@ -18,6 +18,12 @@ static void *workqueue_thread(void *arg)
 {
 	struct erofs_workqueue		*wq = arg;
 	struct erofs_work		*wi;
+	void				*private = NULL;
+
+	if (wq->private_size) {
+		private = calloc(1, wq->private_size);
+		assert(private);
+	}
 
 	/*
 	 * Loop pulling work from the passed in work queue.
@@ -56,13 +62,22 @@ static void *workqueue_thread(void *arg)
 		}
 		pthread_mutex_unlock(&wq->lock);
 
+		wi->private = private;
 		(wi->function)(wq, wi);
 	}
+
+	if (private) {
+		assert(wq->private_fini);
+		(wq->private_fini)(private);
+		free(private);
+	}
+
 	return NULL;
 }
 
 /* Allocate a work queue and threads.  Returns zero or negative error code. */
-int erofs_workqueue_create(struct erofs_workqueue *wq,
+int erofs_workqueue_create(struct erofs_workqueue *wq, size_t private_size,
+			   erofs_wq_priv_fini_t *priv_fini,
 			   unsigned int nr_workers, unsigned int max_queue)
 {
 	unsigned int		i;
@@ -79,6 +94,8 @@ int erofs_workqueue_create(struct erofs_workqueue *wq,
 	if (err)
 		goto out_cond;
 
+	wq->private_size = private_size;
+	wq->private_fini = priv_fini;
 	wq->thread_count = nr_workers;
 	wq->max_queued = max_queue;
 	wq->threads = malloc(nr_workers * sizeof(pthread_t));
-- 
2.43.0

