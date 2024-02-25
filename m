Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9137862AC0
	for <lists+linux-erofs@lfdr.de>; Sun, 25 Feb 2024 15:28:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TjR1q4SBhz3cGY
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Feb 2024 01:28:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TjR1l5V3Bz3bsT
	for <linux-erofs@lists.ozlabs.org>; Mon, 26 Feb 2024 01:28:27 +1100 (AEDT)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 2743010089E41;
	Sun, 25 Feb 2024 22:28:04 +0800 (CST)
Received: from zhaoyf.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 83D5B37C986;
	Sun, 25 Feb 2024 22:28:01 +0800 (CST)
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
To: hsiangkao@linux.alibaba.com
Subject: [PATCH v3 1/4] erofs-utils: introduce multi-threading framework
Date: Sun, 25 Feb 2024 22:27:56 +0800
Message-ID: <20240225142759.340165-2-zhaoyifan@sjtu.edu.cn>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240225142759.340165-1-zhaoyifan@sjtu.edu.cn>
References: <20240225142759.340165-1-zhaoyifan@sjtu.edu.cn>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add a workqueue implementation for multi-threading support inspired by
xfsprogs.

Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 configure.ac              |  16 +++++
 include/erofs/internal.h  |   3 +
 include/erofs/workqueue.h |  37 +++++++++++
 lib/Makefile.am           |   4 ++
 lib/workqueue.c           | 132 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 192 insertions(+)
 create mode 100644 include/erofs/workqueue.h
 create mode 100644 lib/workqueue.c

diff --git a/configure.ac b/configure.ac
index 325431b..1c7f53b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -96,6 +96,14 @@ AC_DEFUN([EROFS_UTILS_PARSE_DIRECTORY],
 
 AC_ARG_VAR([MAX_BLOCK_SIZE], [The maximum block size which erofs-utils supports])
 
+AC_MSG_CHECKING([whether to enable multi-threading support])
+AC_ARG_ENABLE([multithreading],
+    AS_HELP_STRING([--enable-multithreading],
+                   [enable multi-threading support @<:@default=no@:>@]),
+    [enable_multithreading="$enableval"],
+    [enable_multithreading="no"])
+AC_MSG_RESULT([$enable_multithreading])
+
 AC_ARG_ENABLE([debug],
     [AS_HELP_STRING([--enable-debug],
                     [enable debugging mode @<:@default=no@:>@])],
@@ -280,6 +288,13 @@ AS_IF([test "x$MAX_BLOCK_SIZE" = "x"], [
                              [erofs_cv_max_block_size=4096]))
 ], [erofs_cv_max_block_size=$MAX_BLOCK_SIZE])
 
+# Configure multi-threading support
+AS_IF([test "x$enable_multithreading" != "xno"], [
+    AC_CHECK_HEADERS([pthread.h])
+    AC_CHECK_LIB([pthread], [pthread_mutex_lock], [], AC_MSG_ERROR([libpthread is required for multi-threaded build]))
+    AC_DEFINE(EROFS_MT_ENABLED, 1, [Enable multi-threading support])
+], [])
+
 # Configure debug mode
 AS_IF([test "x$enable_debug" != "xno"], [], [
   dnl Turn off all assert checking.
@@ -471,6 +486,7 @@ AS_IF([test "x$enable_fuzzing" != "xyes"], [], [
 AM_CONDITIONAL([ENABLE_FUZZING], [test "x${enable_fuzzing}" = "xyes"])
 
 # Set up needed symbols, conditionals and compiler/linker flags
+AM_CONDITIONAL([ENABLE_EROFS_MT], [test "x${enable_multithreading}" != "xno"])
 AM_CONDITIONAL([ENABLE_LZ4], [test "x${have_lz4}" = "xyes"])
 AM_CONDITIONAL([ENABLE_LZ4HC], [test "x${have_lz4hc}" = "xyes"])
 AM_CONDITIONAL([ENABLE_FUSE], [test "x${have_fuse}" = "xyes"])
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 82797e1..954aef4 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -22,6 +22,9 @@ typedef unsigned short umode_t;
 #include <sys/types.h> /* for off_t definition */
 #include <sys/stat.h> /* for S_ISCHR definition */
 #include <stdio.h>
+#ifdef HAVE_PTHREAD_H
+#include <pthread.h>
+#endif
 
 #ifndef PATH_MAX
 #define PATH_MAX        4096    /* # chars in a path name including nul */
diff --git a/include/erofs/workqueue.h b/include/erofs/workqueue.h
new file mode 100644
index 0000000..b4b3901
--- /dev/null
+++ b/include/erofs/workqueue.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
+#ifndef __EROFS_WORKQUEUE_H
+#define __EROFS_WORKQUEUE_H
+
+#include "internal.h"
+
+struct erofs_work;
+
+typedef void erofs_wq_func_t(struct erofs_work *);
+typedef void erofs_wq_priv_fini_t(void *);
+
+struct erofs_work {
+	void (*func)(struct erofs_work *work);
+	struct erofs_work *next;
+	void *priv;
+};
+
+struct erofs_workqueue {
+	struct erofs_work *head, *tail;
+	pthread_mutex_t lock;
+	pthread_cond_t cond_empty;
+	pthread_cond_t cond_full;
+	pthread_t *workers;
+	unsigned int nworker;
+	unsigned int max_jobs;
+	unsigned int job_count;
+	bool shutdown;
+	size_t priv_size;
+	erofs_wq_priv_fini_t *priv_fini;
+};
+
+int erofs_alloc_workqueue(struct erofs_workqueue *wq, unsigned int nworker,
+			 unsigned int max_jobs, size_t priv_size,
+			 erofs_wq_priv_fini_t *priv_fini);
+int erofs_queue_work(struct erofs_workqueue *wq, struct erofs_work *work);
+int erofs_destroy_workqueue(struct erofs_workqueue *wq);
+#endif
\ No newline at end of file
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 54b9c9c..7307f7b 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -53,3 +53,7 @@ liberofs_la_SOURCES += kite_deflate.c compressor_deflate.c
 if ENABLE_LIBDEFLATE
 liberofs_la_SOURCES += compressor_libdeflate.c
 endif
+if ENABLE_EROFS_MT
+liberofs_la_CFLAGS += -lpthread
+liberofs_la_SOURCES += workqueue.c
+endif
diff --git a/lib/workqueue.c b/lib/workqueue.c
new file mode 100644
index 0000000..138afd5
--- /dev/null
+++ b/lib/workqueue.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
+#include <pthread.h>
+#include <stdlib.h>
+#include "erofs/workqueue.h"
+
+static void *worker_thread(void *arg)
+{
+	struct erofs_workqueue *wq = arg;
+	struct erofs_work *work;
+	void *priv = NULL;
+
+	if (wq->priv_size) {
+		priv = calloc(wq->priv_size, 1);
+		assert(priv);
+	}
+
+	while (true) {
+		pthread_mutex_lock(&wq->lock);
+
+		while (wq->job_count == 0 && !wq->shutdown)
+			pthread_cond_wait(&wq->cond_empty, &wq->lock);
+		if (wq->job_count == 0 && wq->shutdown) {
+			pthread_mutex_unlock(&wq->lock);
+			break;
+		}
+
+		work = wq->head;
+		wq->head = work->next;
+		if (!wq->head)
+			wq->tail = NULL;
+		wq->job_count--;
+
+		if (wq->job_count == wq->max_jobs - 1)
+			pthread_cond_broadcast(&wq->cond_full);
+
+		pthread_mutex_unlock(&wq->lock);
+
+		work->priv = priv;
+		work->func(work);
+	}
+
+	if (priv) {
+		assert(wq->priv_fini);
+		(wq->priv_fini)(priv);
+		free(priv);
+	}
+
+	return NULL;
+}
+
+int erofs_alloc_workqueue(struct erofs_workqueue *wq, unsigned int nworker,
+			 unsigned int max_jobs, size_t priv_size,
+			 erofs_wq_priv_fini_t *priv_fini)
+{
+	unsigned int i;
+
+	if (!wq || nworker <= 0 || max_jobs <= 0)
+		return -EINVAL;
+
+	wq->head = wq->tail = NULL;
+	wq->nworker = nworker;
+	wq->max_jobs = max_jobs;
+	wq->job_count = 0;
+	wq->shutdown = false;
+	wq->priv_size = priv_size;
+	wq->priv_fini = priv_fini;
+	pthread_mutex_init(&wq->lock, NULL);
+	pthread_cond_init(&wq->cond_empty, NULL);
+	pthread_cond_init(&wq->cond_full, NULL);
+
+	wq->workers = malloc(nworker * sizeof(pthread_t));
+	if (!wq->workers)
+		return -ENOMEM;
+
+	for (i = 0; i < nworker; i++) {
+		if (pthread_create(&wq->workers[i], NULL, worker_thread, wq)) {
+			while (i--)
+				pthread_cancel(wq->workers[i]);
+			free(wq->workers);
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+int erofs_queue_work(struct erofs_workqueue *wq, struct erofs_work *work)
+{
+	if (!wq || !work)
+		return -EINVAL;
+
+	pthread_mutex_lock(&wq->lock);
+
+	while (wq->job_count == wq->max_jobs)
+		pthread_cond_wait(&wq->cond_full, &wq->lock);
+
+	work->next = NULL;
+	if (!wq->head)
+		wq->head = work;
+	else
+		wq->tail->next = work;
+	wq->tail = work;
+	wq->job_count++;
+
+	pthread_cond_signal(&wq->cond_empty);
+	pthread_mutex_unlock(&wq->lock);
+
+	return 0;
+}
+
+int erofs_destroy_workqueue(struct erofs_workqueue *wq)
+{
+	unsigned int i;
+
+	if (!wq)
+		return -EINVAL;
+
+	pthread_mutex_lock(&wq->lock);
+	wq->shutdown = true;
+	pthread_cond_broadcast(&wq->cond_empty);
+	pthread_mutex_unlock(&wq->lock);
+
+	for (i = 0; i < wq->nworker; i++)
+		pthread_join(wq->workers[i], NULL);
+
+	free(wq->workers);
+	pthread_mutex_destroy(&wq->lock);
+	pthread_cond_destroy(&wq->cond_empty);
+	pthread_cond_destroy(&wq->cond_full);
+
+	return 0;
+}
\ No newline at end of file
-- 
2.44.0

