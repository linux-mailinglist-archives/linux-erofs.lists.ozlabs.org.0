Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7563386C5D0
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Feb 2024 10:43:46 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lYdE9UL7;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TlmWN0XL2z3dS8
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Feb 2024 20:43:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lYdE9UL7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TlmWF5Hh7z2xQ7
	for <linux-erofs@lists.ozlabs.org>; Thu, 29 Feb 2024 20:43:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709199810; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=H7smYOej/gCDLn4iRRG2PShQwg2I1/5H2EIEfeLmGxo=;
	b=lYdE9UL7wKrrO1i+NAi9+9TX9ToUPLauoEnlQqGPXyDX83SbvUG6GKYTNgJz5EHeQs3GJW0FEth9Kx6IX3iLnttEziSBbg0b2PBhxyWz4RIyFtqtB67tqz/f8hDM5IqFVOXo7Iqx4oPzEX+kDUy4u2Q9v2g29051lYgJ/baUFK8=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W1SYXsT_1709199808;
Received: from 30.97.48.246(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W1SYXsT_1709199808)
          by smtp.aliyun-inc.com;
          Thu, 29 Feb 2024 17:43:29 +0800
Message-ID: <e7077c8d-bce6-422a-9c6e-e8f05a0aa457@linux.alibaba.com>
Date: Thu, 29 Feb 2024 17:43:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] erofs-utils: introduce multi-threading framework
To: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
References: <20240228161652.1010997-1-zhaoyifan@sjtu.edu.cn>
 <20240228161652.1010997-2-zhaoyifan@sjtu.edu.cn>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240228161652.1010997-2-zhaoyifan@sjtu.edu.cn>
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

Hi Yifan,

On 2024/2/29 00:16, Yifan Zhao wrote:
> Add a workqueue implementation for multi-threading support inspired by
> xfsprogs.
> 
> Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
> Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>   configure.ac              |  16 +++++
>   include/erofs/internal.h  |   3 +
>   include/erofs/workqueue.h |  37 +++++++++++
>   lib/Makefile.am           |   4 ++
>   lib/workqueue.c           | 132 ++++++++++++++++++++++++++++++++++++++
>   5 files changed, 192 insertions(+)
>   create mode 100644 include/erofs/workqueue.h
>   create mode 100644 lib/workqueue.c
> 
> diff --git a/configure.ac b/configure.ac
> index 4b59230..3ccd6bb 100644
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
> @@ -280,6 +288,13 @@ AS_IF([test "x$MAX_BLOCK_SIZE" = "x"], [
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
> @@ -471,6 +486,7 @@ AS_IF([test "x$enable_fuzzing" != "xyes"], [], [
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
> index 0000000..b4b3901
> --- /dev/null
> +++ b/include/erofs/workqueue.h
> @@ -0,0 +1,37 @@
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
> +	struct erofs_work *head, *tail;
> +	pthread_mutex_t lock;
> +	pthread_cond_t cond_empty;
> +	pthread_cond_t cond_full;
> +	pthread_t *workers;
> +	unsigned int nworker;
> +	unsigned int max_jobs;
> +	unsigned int job_count;
> +	bool shutdown;
> +	size_t priv_size;

I don't like this way honestly, how about
	..
	erofs_wq_func_t on_start, on_exit;
	void *private;
	..

much like:
https://www.gnu.org/software/libc/manual/html_node/Cleanups-on-Exit.html

> +	erofs_wq_priv_fini_t *priv_fini;
> +};
> +
> +int erofs_alloc_workqueue(struct erofs_workqueue *wq, unsigned int nworker,
> +			 unsigned int max_jobs, size_t priv_size,
> +			 erofs_wq_priv_fini_t *priv_fini);
> +int erofs_queue_work(struct erofs_workqueue *wq, struct erofs_work *work);
> +int erofs_destroy_workqueue(struct erofs_workqueue *wq);
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
> index 0000000..138afd5
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

	if (wq->on_start)
		wq->on_start(wq);

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

	if (wq->on_exit)
		wq->on_exit(wq);

> +
> +	return NULL;
> +}
> +
> +int erofs_alloc_workqueue(struct erofs_workqueue *wq, unsigned int nworker,
> +			 unsigned int max_jobs, size_t priv_size,
> +			 erofs_wq_priv_fini_t *priv_fini)
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

How about
			while (i)
				pthread_cancel(wq->workers[--i]);

I preferred this since i won't be < 0.

Thanks,
Gao Xiang
