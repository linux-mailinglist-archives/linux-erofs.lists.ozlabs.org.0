Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1236564A7
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Dec 2022 19:38:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ngml95Khlz2xJF
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Dec 2022 05:38:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1672079925;
	bh=UGh9r/jsaAqCGWD2zZzfloJ7Dxl5ALoC+WNsAoZ68QE=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=Mj9m5ZLxnEJx5GUagCGjo4iQBlbadcEGwRq7OnB7qLy3+0mEgkaobxBZjtoUW+pwF
	 QlR4X818+Ao1XjE9COTBtfOhvu2+5BZzzC1BW++3sVqt21fLNvwXxO6lXrN35u7rbi
	 2YcckAR2M4hwyFYiqgwk3EydlldOU6AlpC0T9GxYq7IJ/JPZ4GpyePSwD+oOylx2Jc
	 eC8raWuEEw4jwcOr8JsLS5L9GCR6xhP0f9BOVcpckhU4LIchfaQl/upaOTEMELBxFW
	 sXj+C+klTKx16eAy9cwc8CF47UPPoUOIJKYovuyawy7DQZV/Xvy2ycfORbMSziOXLc
	 NxXlk2r4F/+BA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com; envelope-from=dhavale@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=YZsJ/Wu7;
	dkim-atps=neutral
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ngml26Whsz2xJF
	for <linux-erofs@lists.ozlabs.org>; Tue, 27 Dec 2022 05:38:37 +1100 (AEDT)
Received: by mail-ot1-x32a.google.com with SMTP id l8-20020a056830054800b006705fd35eceso6997689otb.12
        for <linux-erofs@lists.ozlabs.org>; Mon, 26 Dec 2022 10:38:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UGh9r/jsaAqCGWD2zZzfloJ7Dxl5ALoC+WNsAoZ68QE=;
        b=Gv+6I8+imzaIsEuqZrtmsFxOdwPByGgN3F0VQDeEJW7irmke8+kLZH85k/LT46lgeL
         KaE9vBfgL4aTT4gLwuz6zAG/HFY695lV7WeSUCQeraUJioY5+svPZF6P23vDtaUqZMnM
         JE0cDgbinTFQA3e9goaulW28pxjWZ+OljA5zOMziXvu/xu0v4YFb1SLXFkcImZDX3H+u
         wkl6bvRNoAQlAaPP/NMmk20bTobsZzCtHCWAKG/r+MEf7lyGKPql70VJQY4iq6k0U8oH
         PSsstBxXGgAPiQS8Hlz3ESM2jfqRYQNwlob9qHkKjj/ryoNbnmOqE0AemmrxY4ya17NW
         UE5g==
X-Gm-Message-State: AFqh2kqc4qrcP56XrVZUFgJ5mIJ2pD87eCkK1veL+yYK+7sqIdWXIKCK
	IODtHjAYKY22+mjuAMwo8XDLd3IFnzo9WRQZY0wLzA==
X-Google-Smtp-Source: AMrXdXt5SjHOi+TWqO0LV+UDUGSbTzxqs+KFHbaCN4ODYEykVdplk0Q24mZQeayTPNtb1D6EbXC1S+xwLm5fcmuv0VA=
X-Received: by 2002:a05:6830:108d:b0:678:202c:1b93 with SMTP id
 y13-20020a056830108d00b00678202c1b93mr1321705oto.160.1672079914091; Mon, 26
 Dec 2022 10:38:34 -0800 (PST)
MIME-Version: 1.0
References: <20221222011529.3471280-1-dhavale@google.com> <Y6PFfEnJE3g98X/e@debian>
In-Reply-To: <Y6PFfEnJE3g98X/e@debian>
Date: Mon, 26 Dec 2022 10:38:23 -0800
Message-ID: <CAB=BE-Qh72tB+z9zRxqiC7Jg+RVcip1+vHJXopuzykR08FYiCA@mail.gmail.com>
Subject: Re: [PATCH] EROFS: Replace erofs_unzipd workqueue with per-cpu threads
To: Sandeep Dhavale <dhavale@google.com>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	Yue Hu <huyue2@coolpad.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, kernel-team@android.com, 
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Dec 21, 2022 at 6:48 PM Gao Xiang <xiang@kernel.org> wrote:
>
> Hi Sandeen,
>
> On Thu, Dec 22, 2022 at 01:15:29AM +0000, Sandeep Dhavale wrote:
> > Using per-cpu thread pool we can reduce the scheduling latency compared
> > to workqueue implementation. With this patch scheduling latency and
> > variation is reduced as per-cpu threads are SCHED_FIFO kthread_workers.
> >
> > The results were evaluated on arm64 Android devices running 5.10 kernel.
> >
> > The table below shows resulting improvements of total scheduling latency
> > for the same app launch benchmark runs with 50 iterations. Scheduling
> > latency is the latency between when the task (workqueue kworker vs
> > kthread_worker) became eligible to run to when it actually started
> > running.
> > +-------------------------+-----------+----------------+---------+
> > |                         | workqueue | kthread_worker |  diff   |
> > +-------------------------+-----------+----------------+---------+
> > | Average (us)            |     15253 |           2914 | -80.89% |
> > | Median (us)             |     14001 |           2912 | -79.20% |
> > | Minimum (us)            |      3117 |           1027 | -67.05% |
> > | Maximum (us)            |     30170 |           3805 | -87.39% |
> > | Standard deviation (us) |      7166 |            359 |         |
> > +-------------------------+-----------+----------------+---------+
> >
> > Signed-off-by: Sandeep Dhavale <dhavale@google.com>
>
> Thanks for the patch.  Generally, This path looks good to me (compared
> with softirq context.)
>
> With the background at LPC 22, I can see how important such low latency
> requirement is needed for Android upstream and AOSP.  However, could you
> add some link or some brief background to other folks without such
> impression?
>
> > ---
> >  fs/erofs/zdata.c | 84 +++++++++++++++++++++++++++++++++++-------------
> >  fs/erofs/zdata.h |  4 ++-
> >  2 files changed, 64 insertions(+), 24 deletions(-)
> >
> > diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> > index ccf7c55d477f..646667dbe615 100644
> > --- a/fs/erofs/zdata.c
> > +++ b/fs/erofs/zdata.c
> > @@ -8,6 +8,7 @@
> >  #include "compress.h"
> >  #include <linux/prefetch.h>
> >  #include <linux/psi.h>
> > +#include <linux/slab.h>
> >
> >  #include <trace/events/erofs.h>
> >
> > @@ -184,26 +185,56 @@ typedef tagptr1_t compressed_page_t;
> >  #define tag_compressed_page_justfound(page) \
> >       tagptr_fold(compressed_page_t, page, 1)
> >
> > -static struct workqueue_struct *z_erofs_workqueue __read_mostly;
> > +static struct kthread_worker **z_erofs_kthread_pool;
> >
> > -void z_erofs_exit_zip_subsystem(void)
> > +static void z_erofs_destroy_kthread_pool(void)
> >  {
> > -     destroy_workqueue(z_erofs_workqueue);
> > -     z_erofs_destroy_pcluster_pool();
> > +     unsigned long cpu;
> > +
> > +     for_each_possible_cpu(cpu) {
> > +             if (z_erofs_kthread_pool[cpu]) {
> > +                     kthread_destroy_worker(z_erofs_kthread_pool[cpu]);
> > +                     z_erofs_kthread_pool[cpu] = NULL;
> > +             }
> > +     }
> > +     kfree(z_erofs_kthread_pool);
> >  }
> >
> > -static inline int z_erofs_init_workqueue(void)
> > +static int z_erofs_create_kthread_workers(void)
> >  {
> > -     const unsigned int onlinecpus = num_possible_cpus();
> > +     unsigned long cpu;
> > +     struct kthread_worker *worker;
> > +
> > +     for_each_possible_cpu(cpu) {
> > +             worker = kthread_create_worker_on_cpu(cpu, 0, "z_erofs/%ld", cpu);
>
> how about calling them as erofs_worker/%ld, since in the future they
> can also be used for other uses (like verification or decryption).
>
Sure, it makes sense.

> > +             if (IS_ERR(worker)) {
> > +                     z_erofs_destroy_kthread_pool();
> > +                     return -ENOMEM;
> > +             }
> > +             sched_set_fifo(worker->task);
>
> Could we add some kernel configuration option to enable/disable this,
> since I'm not sure if all users need RT threads.
>
Ok, will do.
> > +             z_erofs_kthread_pool[cpu] = worker;
> > +     }
> > +     return 0;
> > +}
> >
> > -     /*
> > -      * no need to spawn too many threads, limiting threads could minimum
> > -      * scheduling overhead, perhaps per-CPU threads should be better?
> > -      */
> > -     z_erofs_workqueue = alloc_workqueue("erofs_unzipd",
> > -                                         WQ_UNBOUND | WQ_HIGHPRI,
> > -                                         onlinecpus + onlinecpus / 4);
> > -     return z_erofs_workqueue ? 0 : -ENOMEM;
> > +static int z_erofs_init_kthread_pool(void)
> > +{
> > +     int err;
> > +
> > +     z_erofs_kthread_pool = kcalloc(num_possible_cpus(),
> > +                     sizeof(struct kthread_worker *), GFP_ATOMIC);
> > +     if (!z_erofs_kthread_pool)
> > +             return -ENOMEM;
> > +     err = z_erofs_create_kthread_workers();
> > +
> > +     return err;
> > +}
> > +
> > +
> > +void z_erofs_exit_zip_subsystem(void)
> > +{
> > +     z_erofs_destroy_kthread_pool();
> > +     z_erofs_destroy_pcluster_pool();
> >  }
> >
> >  int __init z_erofs_init_zip_subsystem(void)
> > @@ -211,10 +242,16 @@ int __init z_erofs_init_zip_subsystem(void)
> >       int err = z_erofs_create_pcluster_pool();
> >
> >       if (err)
> > -             return err;
> > -     err = z_erofs_init_workqueue();
> > +             goto out_error_pcluster_pool;
> > +
> > +     err = z_erofs_init_kthread_pool();
> >       if (err)
> > -             z_erofs_destroy_pcluster_pool();
> > +             goto out_error_kthread_pool;
> > +
> > +     return err;
> > +out_error_kthread_pool:
> > +     z_erofs_destroy_pcluster_pool();
> > +out_error_pcluster_pool:
> >       return err;
> >  }
> >
> > @@ -1143,7 +1180,7 @@ static void z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
> >       }
> >  }
> >
> > -static void z_erofs_decompressqueue_work(struct work_struct *work)
> > +static void z_erofs_decompressqueue_kthread_work(struct kthread_work *work)
> >  {
> >       struct z_erofs_decompressqueue *bgq =
> >               container_of(work, struct z_erofs_decompressqueue, u.work);
> > @@ -1170,15 +1207,16 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
> >
> >       if (atomic_add_return(bios, &io->pending_bios))
> >               return;
> > -     /* Use workqueue and sync decompression for atomic contexts only */
> > +     /* Use kthread_workers and sync decompression for atomic contexts only */
> >       if (in_atomic() || irqs_disabled()) {
> > -             queue_work(z_erofs_workqueue, &io->u.work);
> > +             kthread_queue_work(z_erofs_kthread_pool[raw_smp_processor_id()],
> > +                            &io->u.work);
>
> Should we need to handle cpu online/offline as well?
>
Ok, let me try to add cpuhp support. I will work on V2.

> Thanks,
> Gao Xiang

Thanks,
Sandeep.
