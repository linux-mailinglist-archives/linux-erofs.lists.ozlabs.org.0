Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 986F970CFB3
	for <lists+linux-erofs@lfdr.de>; Tue, 23 May 2023 02:44:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QQFvT2xy4z3cL0
	for <lists+linux-erofs@lfdr.de>; Tue, 23 May 2023 10:44:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=Lh2t3iKM;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=Lh2t3iKM;
	dkim-atps=neutral
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QQFvP4mq3z3bgr
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 May 2023 10:44:32 +1000 (AEST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2533d74895bso4984211a91.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 22 May 2023 17:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684802668; x=1687394668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ohaTtJOaeTv+DUbIMaoQB65niNoQeGMvZ+rell6iqk=;
        b=Lh2t3iKMxSvClzmCWv9vggXg6qa912HRceMhmGZW22Nea0fZW/Q4GLwhOXlOvZlt8+
         svTRTl6rlknvFhR/Vb28ViINP9WwvZd/IjbY8vu685AtJGUVUZog1b3RQQM9orQ0WDtk
         dECpFw98w8XuJATQW2Y9dMfd+3Xoavt+3vGl6CQsk2BtDr0Qu2EJi01c1Oe3q75H7bHv
         1OGVaoV2JE/o0M/8bwm9TIGFYoE8GSL+GWN8OpYHBWW6QU2KiWyW6OLC9Dv0mIABSqSV
         wS7nO7w+CYB2CEx/D2V5zSOHVLL/c3SiyK87ySOtc86/ZhxG8Hlq6aUypkW0y1WTBXZy
         cQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684802668; x=1687394668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ohaTtJOaeTv+DUbIMaoQB65niNoQeGMvZ+rell6iqk=;
        b=d7NU6N/bQc/JzFK1xrjACjQV+u41SRGp5dFtcnzQ0j77AWv11IabVqI00k81I++UDv
         Bj2BuDC5wGHktYqocJ5fYjJBx1EuX/DJN9vaiK9wVweR+LU4YoXazGvlsBZwxsjvG6Za
         yNowcBJEavDt3+Q4beFBs9CMOZR9ZkcWaAgl6fSQXHYE5iAjyndVHxHyEMK6EehC+Dj1
         Azj+Vsof7MgRoYwmdyHn3lYn6J3RjX6xHqLn15gM/KXSgCx9VM6obQC5xOf2SnuuTozv
         s8CF9sc3rDBRCiIBWNwkvm0qXLjKoaChYNPH7LBD/LU9LdrNpd3VyljU6QnGFcpdP6LP
         3Xsw==
X-Gm-Message-State: AC+VfDyozyXeTq1Jxr745UT1OFsjfVywiybtYP6BqFJbwTfJWVlxYRKL
	n6zFJSFi6rh3vE6uDa4qvkM=
X-Google-Smtp-Source: ACHHUZ7Z00JJe8o88wNi/jig565qsA7QD7/XTMHnzm4a67eYa0dAv7dLNOTRPHowJnhdhWSqEW9znQ==
X-Received: by 2002:a17:90a:d513:b0:24d:d377:d1 with SMTP id t19-20020a17090ad51300b0024dd37700d1mr12085705pju.45.1684802668474;
        Mon, 22 May 2023 17:44:28 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id lp4-20020a17090b4a8400b002555689006esm3048698pjb.47.2023.05.22.17.44.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 May 2023 17:44:28 -0700 (PDT)
Date: Tue, 23 May 2023 08:52:26 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs: use HIPRI by default if per-cpu kthreads are
 enabled
Message-ID: <20230523085226.00006933.zbestahu@gmail.com>
In-Reply-To: <20230522092141.124290-1-hsiangkao@linux.alibaba.com>
References: <20230522092141.124290-1-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: zhangwen@coolpad.com, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Sandeep Dhavale <dhavale@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, 22 May 2023 17:21:41 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> As Sandeep shown [1], high priority RT per-cpu kthreads are
> typically helpful for Android scenarios to minimize the scheduling
> latencies.
> 
> Switch EROFS_FS_PCPU_KTHREAD_HIPRI on by default if
> EROFS_FS_PCPU_KTHREAD is on since it's the typical use cases for
> EROFS_FS_PCPU_KTHREAD.
> 
> Also clean up unneeded sched_set_normal().
> 
> [1] https://lore.kernel.org/r/CAB=BE-SBtO6vcoyLNA9F-9VaN5R0t3o_Zn+FW8GbO6wyUqFneQ@mail.gmail.com
> Cc: Sandeep Dhavale <dhavale@google.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/Kconfig | 1 +
>  fs/erofs/zdata.c | 2 --
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> index 704fb59577e0..f259d92c9720 100644
> --- a/fs/erofs/Kconfig
> +++ b/fs/erofs/Kconfig
> @@ -121,6 +121,7 @@ config EROFS_FS_PCPU_KTHREAD
>  config EROFS_FS_PCPU_KTHREAD_HIPRI
>  	bool "EROFS high priority per-CPU kthread workers"
>  	depends on EROFS_FS_ZIP && EROFS_FS_PCPU_KTHREAD
> +	default y

How about removing this config option?

>  	help
>  	  This permits EROFS to configure per-CPU kthread workers to run
>  	  at higher priority.
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 92f3a01262cf..3ba505434f03 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -367,8 +367,6 @@ static struct kthread_worker *erofs_init_percpu_worker(int cpu)
>  		return worker;
>  	if (IS_ENABLED(CONFIG_EROFS_FS_PCPU_KTHREAD_HIPRI))
>  		sched_set_fifo_low(worker->task);
> -	else
> -		sched_set_normal(worker->task, 0);
>  	return worker;
>  }
>  

