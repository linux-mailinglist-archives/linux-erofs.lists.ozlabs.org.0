Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C59E3848CDE
	for <lists+linux-erofs@lfdr.de>; Sun,  4 Feb 2024 11:33:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TSQpk3jdDz3bsd
	for <lists+linux-erofs@lfdr.de>; Sun,  4 Feb 2024 21:33:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TSQph0h4Gz30Pp
	for <linux-erofs@lists.ozlabs.org>; Sun,  4 Feb 2024 21:33:48 +1100 (AEDT)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 97FB71008880E;
	Sun,  4 Feb 2024 18:33:35 +0800 (CST)
Received: from zhaoyf.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 0219C381F37;
	Sun,  4 Feb 2024 18:33:33 +0800 (CST)
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/7] erofs-utils: introduce multi-threading framework
Date: Sun,  4 Feb 2024 18:33:31 +0800
Message-ID: <20240204103331.141298-1-zhaoyifan@sjtu.edu.cn>
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
Cc: hsiangkao@linux.alibaba.com, xin_tong@sjtu.edu.cn
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@linux.alibaba.com>

Add a workqueue implementation based on xfsprogs for multi-threading
support.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 configure.ac              |  16 +++
 include/erofs/internal.h  |   3 +
 include/erofs/workqueue.h |  44 ++++++++
 lib/Makefile.am           |   4 +
 lib/workqueue.c           | 205 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 272 insertions(+)
 create mode 100644 include/erofs/workqueue.h
 create mode 100644 lib/workqueue.c

diff --git a/configure.ac b/configure.ac
index bf6e99f..53306c3 100644
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
@@ -288,6 +296,13 @@ AS_IF([test "x$MAX_BLOCK_SIZE" = "x"], [
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
@@ -467,6 +482,7 @@ AS_IF([test "x$enable_fuzzing" != "xyes"], [], [
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
index 0000000..d0ebc5a
--- /dev/null
+++ b/include/erofs/workqueue.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2017 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <darrick.wong@oracle.com>
+ */
+#ifndef __EROFS_WORKQUEUE_H
+#define __EROFS_WORKQUEUE_H
+
+#include "internal.h"
+
+struct erofs_workqueue;
+struct erofs_work;
+
+typedef void erofs_workqueue_func_t(struct erofs_workqueue *wq,
+				    struct erofs_work *work);
+
+struct erofs_work {
+	struct erofs_workqueue	*queue;
+	struct erofs_work	*next;
+	erofs_workqueue_func_t	*function;
+};
+
+struct erofs_workqueue {
+	pthread_t		*threads;
+	struct erofs_work	*next_item;
+	struct erofs_work	*last_item;
+	pthread_mutex_t		lock;
+	pthread_cond_t		wakeup;
+	unsigned int		item_count;
+	unsigned int		thread_count;
+	bool			terminate;
+	bool			terminated;
+	int			max_queued;
+	pthread_cond_t		queue_full;
+};
+
+int erofs_workqueue_create(struct erofs_workqueue *wq,
+			   unsigned int nr_workers, unsigned int max_queue);
+int erofs_workqueue_add(struct erofs_workqueue	*wq,
+			struct erofs_work *wi);
+int erofs_workqueue_terminate(struct erofs_workqueue *wq);
+void erofs_workqueue_destroy(struct erofs_workqueue *wq);
+
+#endif
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
index 0000000..6573821
--- /dev/null
+++ b/lib/workqueue.c
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2017 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <darrick.wong@oracle.com>
+ */
+#include <pthread.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <errno.h>
+#include <assert.h>
+#include "erofs/workqueue.h"
+
+/* Main processing thread */
+static void *workqueue_thread(void *arg)
+{
+	struct erofs_workqueue		*wq = arg;
+	struct erofs_work		*wi;
+
+	/*
+	 * Loop pulling work from the passed in work queue.
+	 * Check for notification to exit after every chunk of work.
+	 */
+	while (1) {
+		pthread_mutex_lock(&wq->lock);
+
+		/*
+		 * Wait for work.
+		 */
+		while (wq->next_item == NULL && !wq->terminate) {
+			assert(wq->item_count == 0);
+			pthread_cond_wait(&wq->wakeup, &wq->lock);
+		}
+		if (wq->next_item == NULL && wq->terminate) {
+			pthread_mutex_unlock(&wq->lock);
+			break;
+		}
+
+		/*
+		 *  Dequeue work from the head of the list. If the queue was
+		 *  full then send a wakeup if we're configured to do so.
+		 */
+		assert(wq->item_count > 0);
+		if (wq->max_queued)
+			pthread_cond_broadcast(&wq->queue_full);
+
+		wi = wq->next_item;
+		wq->next_item = wi->next;
+		wq->item_count--;
+
+		if (wq->max_queued && wq->next_item) {
+			/* more work, wake up another worker */
+			pthread_cond_signal(&wq->wakeup);
+		}
+		pthread_mutex_unlock(&wq->lock);
+
+		(wi->function)(wq, wi);
+	}
+	return NULL;
+}
+
+/* Allocate a work queue and threads.  Returns zero or negative error code. */
+int erofs_workqueue_create(struct erofs_workqueue *wq,
+			   unsigned int nr_workers, unsigned int max_queue)
+{
+	unsigned int		i;
+	int			err = 0;
+
+	memset(wq, 0, sizeof(*wq));
+	err = -pthread_cond_init(&wq->wakeup, NULL);
+	if (err)
+		return err;
+	err = -pthread_cond_init(&wq->queue_full, NULL);
+	if (err)
+		goto out_wake;
+	err = -pthread_mutex_init(&wq->lock, NULL);
+	if (err)
+		goto out_cond;
+
+	wq->thread_count = nr_workers;
+	wq->max_queued = max_queue;
+	wq->threads = malloc(nr_workers * sizeof(pthread_t));
+	if (!wq->threads) {
+		err = -errno;
+		goto out_mutex;
+	}
+	wq->terminate = false;
+	wq->terminated = false;
+
+	for (i = 0; i < nr_workers; i++) {
+		err = -pthread_create(&wq->threads[i], NULL, workqueue_thread,
+				wq);
+		if (err)
+			break;
+	}
+
+	/*
+	 * If we encounter errors here, we have to signal and then wait for all
+	 * the threads that may have been started running before we can destroy
+	 * the workqueue.
+	 */
+	if (err)
+		erofs_workqueue_destroy(wq);
+	return err;
+out_mutex:
+	pthread_mutex_destroy(&wq->lock);
+out_cond:
+	pthread_cond_destroy(&wq->queue_full);
+out_wake:
+	pthread_cond_destroy(&wq->wakeup);
+	return err;
+}
+
+/*
+ * Create a work item consisting of a function and some arguments and schedule
+ * the work item to be run via the thread pool.  Returns zero or a negative
+ * error code.
+ */
+int erofs_workqueue_add(struct erofs_workqueue	*wq,
+			struct erofs_work *wi)
+{
+	int	ret;
+
+	assert(!wq->terminated);
+
+	if (wq->thread_count == 0) {
+		(wi->function)(wq, wi);
+		return 0;
+	}
+
+	wi->queue = wq;
+	wi->next = NULL;
+
+	/* Now queue the new work structure to the work queue. */
+	pthread_mutex_lock(&wq->lock);
+restart:
+	if (wq->next_item == NULL) {
+		assert(wq->item_count == 0);
+		ret = -pthread_cond_signal(&wq->wakeup);
+		if (ret) {
+			pthread_mutex_unlock(&wq->lock);
+			return ret;
+		}
+		wq->next_item = wi;
+	} else {
+		/* throttle on a full queue if configured */
+		if (wq->max_queued && wq->item_count == wq->max_queued) {
+			pthread_cond_wait(&wq->queue_full, &wq->lock);
+			/*
+			 * Queue might be empty or even still full by the time
+			 * we get the lock back, so restart the lookup so we do
+			 * the right thing with the current state of the queue.
+			 */
+			goto restart;
+		}
+		wq->last_item->next = wi;
+	}
+	wq->last_item = wi;
+	wq->item_count++;
+	pthread_mutex_unlock(&wq->lock);
+	return 0;
+}
+
+/*
+ * Wait for all pending work items to be processed and tear down the
+ * workqueue thread pool.  Returns zero or a negative error code.
+ */
+int erofs_workqueue_terminate(struct erofs_workqueue *wq)
+{
+	unsigned int		i;
+	int			ret;
+
+	pthread_mutex_lock(&wq->lock);
+	wq->terminate = true;
+	pthread_mutex_unlock(&wq->lock);
+
+	ret = -pthread_cond_broadcast(&wq->wakeup);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < wq->thread_count; i++) {
+		ret = -pthread_join(wq->threads[i], NULL);
+		if (ret)
+			return ret;
+	}
+
+	pthread_mutex_lock(&wq->lock);
+	wq->terminated = true;
+	pthread_mutex_unlock(&wq->lock);
+	return 0;
+}
+
+/* Tear down the workqueue. */
+void erofs_workqueue_destroy(struct erofs_workqueue *wq)
+{
+	assert(wq->terminated);
+
+	free(wq->threads);
+	pthread_mutex_destroy(&wq->lock);
+	pthread_cond_destroy(&wq->wakeup);
+	pthread_cond_destroy(&wq->queue_full);
+	memset(wq, 0, sizeof(*wq));
+}
-- 
2.43.0

