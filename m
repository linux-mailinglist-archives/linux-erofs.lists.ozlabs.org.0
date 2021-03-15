Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A554433B10C
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Mar 2021 12:29:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DzZ1p4lxXz2yjK
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Mar 2021 22:29:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ES0zV5hq;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EYTd8U5p;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=63.128.21.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=ES0zV5hq; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=EYTd8U5p; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DzZ1l69PLz2yRL
 for <linux-erofs@lists.ozlabs.org>; Mon, 15 Mar 2021 22:28:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615807734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k/i+8wDEvbmjTfeLtLR4DtORse2gYPTQ1pHIrK7qNYU=;
 b=ES0zV5hqFERlPPVrAoAl1/Mgu2k6EkKnW12LTnTAM9/ZLM9DIiKiJnRy5AWRuTSgFtdcvJ
 lPiiYCXbcKPSaAJPDfwoKidGwXaqKrcbL0fNi8ZUs86ySlb1G6SgzTRSo38hW5TYyTGuM3
 roocXoFHA8w8XbSV56N3cj7tAFKg64E=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615807735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k/i+8wDEvbmjTfeLtLR4DtORse2gYPTQ1pHIrK7qNYU=;
 b=EYTd8U5pJspLjB3TNTwR777Q77SEE7Jb1/PxNsBMr0zbUYIbS0Np/CvjkolOoGs/4xo12B
 WckObswbG0VM4Ro85E2zGowiEhXyW2HgyvF5c7/UxbEIne2J7cFKExV7zC3t9twfk5V8Zw
 a1pLS3LDF3UUJXtNvE51MihcIwuM164=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-H3eixk6hOvWeu_vEtWerzw-1; Mon, 15 Mar 2021 07:28:50 -0400
X-MC-Unique: H3eixk6hOvWeu_vEtWerzw-1
Received: by mail-pj1-f72.google.com with SMTP id r18so13337062pjz.1
 for <linux-erofs@lists.ozlabs.org>; Mon, 15 Mar 2021 04:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=k/i+8wDEvbmjTfeLtLR4DtORse2gYPTQ1pHIrK7qNYU=;
 b=GERL7GVNANgVdcxbRZeetCvhoGHWYvPokudbMKow4ktxL6INav80q5BI0hYyqZEwpP
 zQ1wKGrAIqt/iK1IAmjWPitsPMl/8ZYDpivff9JOcUe+UEFvN4reWjQpJfMfMNl5iuVl
 OZMnvp15zo+Sn4g1uNXxgNR6N76HwauZej4j/TMlw4KKddyNREILFubKUgwbkR6is1hc
 8oneoqwh+CfFZg3xElh0QPynQug48llzRvQqKmaexT6xnpO5/GCqi/ZLW/Ac0ZBvHWwp
 3byl7HW8XBK+SVJX+RS9W+hMXGM4RtSvSYlgWH+6QOSwKcZuStBwhJ12z0epHJBhIdTS
 Ts8A==
X-Gm-Message-State: AOAM531urNLe3F6eCC3ljJMAhi22ymEiT+Bbmx1Kpzo3vB8KZaa0epT4
 /a1Fk0zhDsu//Tn++4L3sRDa3TT6WtpBSbBfdoLaQB4zH1Yni14AHRt5Mq+OBKZNGMQCx2+1pVT
 UGDVy83h/1PxHEIJqLYWtmNkY
X-Received: by 2002:a17:902:aa87:b029:e5:e1fc:be6 with SMTP id
 d7-20020a170902aa87b02900e5e1fc0be6mr11730373plr.4.1615807729835; 
 Mon, 15 Mar 2021 04:28:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmWpZTgaL3v2Mj5LM9VDdAu+NKLqarMrzFd4GFRQwFyf4fK7sC/SmQFyQwrbfXAQORInKilg==
X-Received: by 2002:a17:902:aa87:b029:e5:e1fc:be6 with SMTP id
 d7-20020a170902aa87b02900e5e1fc0be6mr11730362plr.4.1615807729632; 
 Mon, 15 Mar 2021 04:28:49 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id t22sm11605800pjw.54.2021.03.15.04.28.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Mar 2021 04:28:49 -0700 (PDT)
Date: Mon, 15 Mar 2021 19:28:38 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH v5 2/2] erofs: decompress in endio if possible
Message-ID: <20210315112838.GB838000@xiangao.remote.csb>
References: <20210305062219.557128-1-huangjianan@oppo.com>
 <20210305095840.31025-1-huangjianan@oppo.com>
 <20210305095840.31025-2-huangjianan@oppo.com>
MIME-Version: 1.0
In-Reply-To: <20210305095840.31025-2-huangjianan@oppo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
Cc: zhangshiming@oppo.com, linux-erofs@lists.ozlabs.org, guoweichao@oppo.com,
 linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Mar 05, 2021 at 05:58:40PM +0800, Huang Jianan via Linux-erofs wrote:
> z_erofs_decompressqueue_endio may not be executed in the atomic
> context, for example, when dm-verity is turned on. In this scenario,
> data can be decompressed directly to get rid of additional kworker
> scheduling overhead. Also, it makes no sense to apply synchronous
> decompression for such case.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> ---
>  fs/erofs/internal.h |  2 ++
>  fs/erofs/super.c    |  1 +
>  fs/erofs/zdata.c    | 16 +++++++++++++---
>  3 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 67a7ec945686..e325da7be237 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -53,6 +53,8 @@ struct erofs_fs_context {
>  
>  	/* threshold for decompression synchronously */
>  	unsigned int max_sync_decompress_pages;
> +	/* decide whether to decompress synchronously */
> +	bool readahead_sync_decompress;

I updated this as below:

 	/* current strategy of how to use managed cache */
 	unsigned char cache_strategy;
+	/* strategy of sync decompression (false - auto, true - force on) */
+	bool readahead_sync_decompress;
 
 	/* threshold for decompression synchronously */
 	unsigned int max_sync_decompress_pages;

>  #endif
>  	unsigned int mount_opt;
>  };

...

> @@ -720,8 +723,14 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
>  		return;
>  	}
>  
> -	if (!atomic_add_return(bios, &io->pending_bios))
> -		queue_work(z_erofs_workqueue, &io->u.work);
> +	if (!atomic_add_return(bios, &io->pending_bios)) {
> +		if (in_atomic() || irqs_disabled()) {
> +			queue_work(z_erofs_workqueue, &io->u.work);
> +			sbi->ctx.readahead_sync_decompress = true;
> +		} else {
> +			z_erofs_decompressqueue_work(&io->u.work);
> +		}
> +	}

Also updated this as below to return as early as possible:

-	if (!atomic_add_return(bios, &io->pending_bios))
+	if (atomic_add_return(bios, &io->pending_bios))
+		return;
+	/* Use workqueue and sync decompression for atomic contexts only */
+	if (in_atomic() || irqs_disabled()) {
 		queue_work(z_erofs_workqueue, &io->u.work);
+		sbi->ctx.readahead_sync_decompress = true;
+		return;
+	}
+	z_erofs_decompressqueue_work(&io->u.work);
 }

Otherwise, it looks good to me. I've applied to dev-test
for preliminary testing.

Reviewed-by: Gao Xiang <hsiangkao@redhat.com>

Thanks,
Gao Xiang

