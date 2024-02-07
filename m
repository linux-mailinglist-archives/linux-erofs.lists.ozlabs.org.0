Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B48B484C353
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Feb 2024 04:55:37 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SGlDxCLw;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TV5qq4ptkz3btX
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Feb 2024 14:55:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SGlDxCLw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TV5qf26xwz2yps
	for <linux-erofs@lists.ozlabs.org>; Wed,  7 Feb 2024 14:55:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707278119; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=SEJm1bza6UQtYMGW9oSeabVfsW9eI53huT3qL/AHmj0=;
	b=SGlDxCLwHG0HBzzrVSj6Ws6laMME4iuSwYB6RetxO2uMi03jmLIsbQxgWISIDd9nKBxKUBrAuwVLr2lbfcdqL+N6YyrpPvOsnOtMiS7BMBbR17YYHMGEmj7mHgdF4kiAS+LuqTWUv2fsolj1RRjM9VB5cgYqMbIr82NdFDFd37Q=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W0FTSM-_1707278116;
Received: from 30.25.197.54(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W0FTSM-_1707278116)
          by smtp.aliyun-inc.com;
          Wed, 07 Feb 2024 11:55:17 +0800
Message-ID: <eff090ba-7456-4141-8442-acfa41abab07@linux.alibaba.com>
Date: Wed, 7 Feb 2024 11:55:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] erofs-utils: introduce multi-threading framework
To: Yifan Zhao <zhaoyifan@sjtu.edu.cn>, linux-erofs@lists.ozlabs.org,
 "Darrick J. Wong" <djwong@kernel.org>
References: <20240204103331.141298-1-zhaoyifan@sjtu.edu.cn>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240204103331.141298-1-zhaoyifan@sjtu.edu.cn>
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
Cc: xin_tong@sjtu.edu.cn
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,

On 2024/2/4 18:33, Yifan Zhao wrote:
> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Add a workqueue implementation based on xfsprogs for multi-threading
> support.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---

...


> --- /dev/null
> +++ b/include/erofs/workqueue.h
> @@ -0,0 +1,44 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2017 Oracle.  All Rights Reserved.
> + * Author: Darrick J. Wong <darrick.wong@oracle.com>
> + */

Since it was taken from xfsprogs and the majority of
erofs-utils needs to be licensed with (.. OR Apache 2.0)
too.

I've asked Darrick to confirm this if the relicensing
(GPL-2.0+ OR Apache-2.0) is possible, since basically
it's no need to mimic another not good one for this...

Thanks,
Gao Xiang

> +#ifndef __EROFS_WORKQUEUE_H
> +#define __EROFS_WORKQUEUE_H
> +
> +#include "internal.h"
> +
> +struct erofs_workqueue;
> +struct erofs_work;
> +
> +typedef void erofs_workqueue_func_t(struct erofs_workqueue *wq,
> +				    struct erofs_work *work);
> +
> +struct erofs_work {
> +	struct erofs_workqueue	*queue;
> +	struct erofs_work	*next;
> +	erofs_workqueue_func_t	*function;
> +};
> +
> +struct erofs_workqueue {
> +	pthread_t		*threads;
> +	struct erofs_work	*next_item;
> +	struct erofs_work	*last_item;
> +	pthread_mutex_t		lock;
> +	pthread_cond_t		wakeup;
> +	unsigned int		item_count;
> +	unsigned int		thread_count;
> +	bool			terminate;
> +	bool			terminated;
> +	int			max_queued;
> +	pthread_cond_t		queue_full;
> +};
> +
> +int erofs_workqueue_create(struct erofs_workqueue *wq,
> +			   unsigned int nr_workers, unsigned int max_queue);
> +int erofs_workqueue_add(struct erofs_workqueue	*wq,
> +			struct erofs_work *wi);
> +int erofs_workqueue_terminate(struct erofs_workqueue *wq);
> +void erofs_workqueue_destroy(struct erofs_workqueue *wq);
> +
> +#endif
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
> index 0000000..6573821
> --- /dev/null
> +++ b/lib/workqueue.c
> @@ -0,0 +1,205 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2017 Oracle.  All Rights Reserved.
> + * Author: Darrick J. Wong <darrick.wong@oracle.com>
> + */

