Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D23B785EF2C
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Feb 2024 03:37:32 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=n3zoyaqJ;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TgHNp3Ct0z3cZH
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Feb 2024 13:37:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=n3zoyaqJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TgHNf26c2z3bv3
	for <linux-erofs@lists.ozlabs.org>; Thu, 22 Feb 2024 13:37:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708569436; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4Vfp/rthJouFaKYH9cD2Mw0R8n09PVuugSRvadjVFM8=;
	b=n3zoyaqJl8yEvCYbgN6xpFSq+Kd6Vb78RDIigVeju8tIHYyQNUVOYCND6IzRgNiERWKiYVJx8MGAuF7O2YDF23WreLziFeAQ4mdELkgdQswiNHRvMT0VcrEWE62IUXSC9KH2K3qpLV2SrVeCBFjw7FqwJVyxe7noN+kfpXCJyGs=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W1.Wv8Y_1708569433;
Received: from 30.97.48.199(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W1.Wv8Y_1708569433)
          by smtp.aliyun-inc.com;
          Thu, 22 Feb 2024 10:37:14 +0800
Message-ID: <a0e3e75b-c247-4699-9da1-6275d64d116e@linux.alibaba.com>
Date: Thu, 22 Feb 2024 10:37:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] erofs-utils: introduce multi-threading framework
To: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
References: <20240220075525.684205-1-zhaoyifan@sjtu.edu.cn>
 <20240220075525.684205-2-zhaoyifan@sjtu.edu.cn>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240220075525.684205-2-zhaoyifan@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 2024/2/20 15:55, Yifan Zhao wrote:
> Add a workqueue implementation for multi-threading support inspired by
> xfsprogs.
> 
> Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
> Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>   configure.ac              |  16 +++++
>   include/erofs/internal.h  |   3 +
>   include/erofs/workqueue.h |  38 +++++++++++
>   lib/Makefile.am           |   4 ++
>   lib/workqueue.c           | 132 ++++++++++++++++++++++++++++++++++++++
>   5 files changed, 193 insertions(+)
>   create mode 100644 include/erofs/workqueue.h
>   create mode 100644 lib/workqueue.c
> 
> diff --git a/configure.ac b/configure.ac
> index bf6e99f..53306c3 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -96,6 +96,14 @@ AC_DEFUN([EROFS_UTILS_PARSE_DIRECTORY],
>   
>   AC_ARG_VAR([MAX_BLOCK_SIZE], [The maximum block size which erofs-utils supports])
>   
> +AC_MSG_CHECKING([whether to enable multi-threading support])
> +AC_ARG_ENABLE([multithreading],
> +    AS_HELP_STRING([--enable-multithreading],
> +                   [enable multi-threading support @<:@default=no@:>@]),
> +    [enable_multithreading="$enableval"],
> +    [enable_multithreading="no"])
> +AC_MSG_RESULT([$enable_multithreading])
> +
>   AC_ARG_ENABLE([debug],
>       [AS_HELP_STRING([--enable-debug],
>                       [enable debugging mode @<:@default=no@:>@])],
> @@ -288,6 +296,13 @@ AS_IF([test "x$MAX_BLOCK_SIZE" = "x"], [
>                                [erofs_cv_max_block_size=4096]))
>   ], [erofs_cv_max_block_size=$MAX_BLOCK_SIZE])
>   
> +# Configure multi-threading support
> +AS_IF([test "x$enable_multithreading" != "xno"], [
> +    AC_CHECK_HEADERS([pthread.h])
> +    AC_CHECK_LIB([pthread], [pthread_mutex_lock], [], AC_MSG_ERROR([libpthread is required for multi-threaded build]))
> +    AC_DEFINE(EROFS_MT_ENABLED, 1, [Enable multi-threading support])
> +], [])
> +
>   # Configure debug mode
>   AS_IF([test "x$enable_debug" != "xno"], [], [
>     dnl Turn off all assert checking.
> @@ -467,6 +482,7 @@ AS_IF([test "x$enable_fuzzing" != "xyes"], [], [
>   AM_CONDITIONAL([ENABLE_FUZZING], [test "x${enable_fuzzing}" = "xyes"])
>   
>   # Set up needed symbols, conditionals and compiler/linker flags
> +AM_CONDITIONAL([ENABLE_EROFS_MT], [test "x${enable_multithreading}" != "xno"])
>   AM_CONDITIONAL([ENABLE_LZ4], [test "x${have_lz4}" = "xyes"])
>   AM_CONDITIONAL([ENABLE_LZ4HC], [test "x${have_lz4hc}" = "xyes"])
>   AM_CONDITIONAL([ENABLE_FUSE], [test "x${have_fuse}" = "xyes"])
> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> index 82797e1..954aef4 100644
> --- a/include/erofs/internal.h
> +++ b/include/erofs/internal.h
> @@ -22,6 +22,9 @@ typedef unsigned short umode_t;
>   #include <sys/types.h> /* for off_t definition */
>   #include <sys/stat.h> /* for S_ISCHR definition */
>   #include <stdio.h>
> +#ifdef HAVE_PTHREAD_H
> +#include <pthread.h>
> +#endif
>   
>   #ifndef PATH_MAX
>   #define PATH_MAX        4096    /* # chars in a path name including nul */
> diff --git a/include/erofs/workqueue.h b/include/erofs/workqueue.h
> new file mode 100644
> index 0000000..857947b
> --- /dev/null
> +++ b/include/erofs/workqueue.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +#ifndef __EROFS_WORKQUEUE_H
> +#define __EROFS_WORKQUEUE_H
> +
> +#include "internal.h"
> +
> +struct erofs_work;
> +
> +typedef void erofs_wq_func_t(struct erofs_work *);
> +typedef void erofs_wq_priv_fini_t(void *);
> +
> +struct erofs_work {
> +	void (*func)(struct erofs_work *work);
> +	struct erofs_work *next;
> +	void *priv;
> +};
> +
> +struct erofs_workqueue {
> +	struct erofs_work *head;
> +	struct erofs_work *tail;

I'd suggest
struct erofs_work *head, *tail;

since they seem the same functionality.

> +	pthread_mutex_t lock;
> +	pthread_cond_t cond_empty;
> +	pthread_cond_t cond_full;
> +	pthread_t *workers;
> +	unsigned int nworker;
> +	unsigned int max_jobs;
> +	unsigned int job_count;
> +	bool shutdown;
> +	size_t priv_size;
> +	erofs_wq_priv_fini_t *priv_fini;
> +};
> +
> +int erofs_workqueue_init(struct erofs_workqueue *wq, unsigned int nworker,
> +			 unsigned int max_jobs, size_t priv_size,
> +			 erofs_wq_priv_fini_t *priv_fini);
> +int erofs_workqueue_add(struct erofs_workqueue *wq, struct erofs_work *work);
> +int erofs_workqueue_shutdown(struct erofs_workqueue *wq);
> +#endif
> \ No newline at end of file
> diff --git a/lib/Makefile.am b/lib/Makefile.am
> index 54b9c9c..7307f7b 100644
> --- a/lib/Makefile.am
> +++ b/lib/Makefile.am
> @@ -53,3 +53,7 @@ liberofs_la_SOURCES += kite_deflate.c compressor_deflate.c
>   if ENABLE_LIBDEFLATE
>   liberofs_la_SOURCES += compressor_libdeflate.c
>   endif
> +if ENABLE_EROFS_MT
> +liberofs_la_CFLAGS += -lpthread
> +liberofs_la_SOURCES += workqueue.c
> +endif
> diff --git a/lib/workqueue.c b/lib/workqueue.c
> new file mode 100644
> index 0000000..3ec6142
> --- /dev/null
> +++ b/lib/workqueue.c
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +#include <pthread.h>
> +#include <stdlib.h>
> +#include "erofs/workqueue.h"
> +
> +static void *worker_thread(void *arg)
> +{
> +	struct erofs_workqueue *wq = arg;
> +	struct erofs_work *work;
> +	void *priv = NULL;
> +
> +	if (wq->priv_size) {
> +		priv = calloc(wq->priv_size, 1);
> +		assert(priv);
> +	}
> +
> +	while (true) {
> +		pthread_mutex_lock(&wq->lock);
> +
> +		while (wq->job_count == 0 && !wq->shutdown)
> +			pthread_cond_wait(&wq->cond_empty, &wq->lock);
> +		if (wq->job_count == 0 && wq->shutdown) {
> +			pthread_mutex_unlock(&wq->lock);
> +			break;
> +		}
> +
> +		work = wq->head;
> +		wq->head = work->next;
> +		if (!wq->head)
> +			wq->tail = NULL;
> +		wq->job_count--;
> +
> +		if (wq->job_count == wq->max_jobs - 1)
> +			pthread_cond_broadcast(&wq->cond_full);
> +
> +		pthread_mutex_unlock(&wq->lock);
> +
> +		work->priv = priv;
> +		work->func(work);
> +	}
> +
> +	if (priv) {
> +		assert(wq->priv_fini);
> +		(wq->priv_fini)(priv);
> +		free(priv);
> +	}
> +
> +	return NULL;
> +}
> +
> +int erofs_workqueue_init(struct erofs_workqueue *wq, unsigned int nworker,
> +			 unsigned int max_jobs, size_t priv_size,
> +			 erofs_wq_priv_fini_t *priv_fini)

Let's match kernel workqueue naming...

erofs_alloc_workqueue...

> +{
> +	unsigned int i;
> +
> +	if (!wq || nworker <= 0 || max_jobs <= 0)
> +		return -EINVAL;
> +
> +	wq->head = wq->tail = NULL;
> +	wq->nworker = nworker;
> +	wq->max_jobs = max_jobs;
> +	wq->job_count = 0;
> +	wq->shutdown = false;
> +	wq->priv_size = priv_size;
> +	wq->priv_fini = priv_fini;
> +	pthread_mutex_init(&wq->lock, NULL);
> +	pthread_cond_init(&wq->cond_empty, NULL);
> +	pthread_cond_init(&wq->cond_full, NULL);
> +
> +	wq->workers = malloc(nworker * sizeof(pthread_t));
> +	if (!wq->workers)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < nworker; i++) {
> +		if (pthread_create(&wq->workers[i], NULL, worker_thread, wq)) {
> +			while (i--)
> +				pthread_cancel(wq->workers[i]);
> +			free(wq->workers);
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +int erofs_workqueue_add(struct erofs_workqueue *wq, struct erofs_work *work)

erofs_queue_work


> +{
> +	if (!wq || !work)
> +		return -EINVAL;
> +
> +	pthread_mutex_lock(&wq->lock);
> +
> +	while (wq->job_count == wq->max_jobs)
> +		pthread_cond_wait(&wq->cond_full, &wq->lock);
> +
> +	work->next = NULL;
> +	if (!wq->head)
> +		wq->head = work;
> +	else
> +		wq->tail->next = work;
> +	wq->tail = work;
> +	wq->job_count++;
> +
> +	pthread_cond_signal(&wq->cond_empty);
> +	pthread_mutex_unlock(&wq->lock);
> +
> +	return 0;
> +}
> +
> +int erofs_workqueue_shutdown(struct erofs_workqueue *wq)

erofs_destroy_workqueue

Thanks,
Gao Xiang

> +{
> +	unsigned int i;
> +
> +	if (!wq)
> +		return -EINVAL;
> +
> +	pthread_mutex_lock(&wq->lock);
> +	wq->shutdown = true;
> +	pthread_cond_broadcast(&wq->cond_empty);
> +	pthread_mutex_unlock(&wq->lock);
> +
> +	for (i = 0; i < wq->nworker; i++)
> +		pthread_join(wq->workers[i], NULL);
> +
> +	free(wq->workers);
> +	pthread_mutex_destroy(&wq->lock);
> +	pthread_cond_destroy(&wq->cond_empty);
> +	pthread_cond_destroy(&wq->cond_full);
> +
> +	return 0;
> +}
> \ No newline at end of file
