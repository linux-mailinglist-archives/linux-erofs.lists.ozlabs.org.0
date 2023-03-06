Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CD26AB805
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Mar 2023 09:12:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PVWXK2nFdz3f3q
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Mar 2023 19:12:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=fOfqDdJ9;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=fOfqDdJ9;
	dkim-atps=neutral
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PVWWZ5DVRz309V
	for <linux-erofs@lists.ozlabs.org>; Mon,  6 Mar 2023 19:11:53 +1100 (AEDT)
Received: by mail-pf1-x42b.google.com with SMTP id cp12so5176289pfb.5
        for <linux-erofs@lists.ozlabs.org>; Mon, 06 Mar 2023 00:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678090310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qp1gun1BLOT9XnkM22r0ylB6HbLuHvziOHShU4JCZiI=;
        b=fOfqDdJ9QLzyJMMXV0jxGLG8CPsKKTmz4HUgvY+E8fI0wotkwxnS3/3mX1kROASB5L
         1xNFdLFVSA4PlVui6IJjrU0JlY4HL+prbiFw8DpgJI/zEKFAFKT4KS4/72KMNaBkl2DB
         TrwQ3hkOqrUg1fzDNb970ZgwEvKLAHNT9w+AAjMCH1NyoWdLPW2AEq0SaFIZDKzQnU9R
         skFRIMxFxSaecDgulm0frpPe21wXQ1v6Fjghmzwp70/enlOarYGRPQEkd9OfIbccAkk7
         RAgW66ARDVAbBw1MZTU89Yl7bKRcNymlRqbumb/Kf4H901pGaF1pUiCukXJhPymgPk48
         X5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678090310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qp1gun1BLOT9XnkM22r0ylB6HbLuHvziOHShU4JCZiI=;
        b=k4u5gA4NSRkABUGV/tv7f2FR2MNU4Z0b/+H8OVLdzFgSkdhQ9CzY1IQU3HhW7FO0kz
         59QMSrsWF0wmwM8clVPoNCQzuNmvUm4UQ6tQ2E3BZCM0RHai+LpieR/rdEX+pSkdRdre
         FVITy7NKObzlYz5sQJvNuHQmuMzYNnu3QWO+gBmSHS+p7xJ/+AURwH1txttkcSmUrgTu
         QFNaJk792F2gwiGfg96TDglffsr864d+V572o5oN0DNoJzE2vnq+oBErHjnWCxVfB8Kp
         aWaKazu3VmEO5yfkZDEckRziwZ3ZiXIqPvRPTa1+iJi8WqWqQExMvNhISX0u7puS/Hy1
         Y0MA==
X-Gm-Message-State: AO0yUKXS9/2eGh1l7Bmb5gxLI+8DAzlRnitKx+8N4PXlBKsnPVvNwm8T
	8l54myXMJvhXrs5h4kYtjfg=
X-Google-Smtp-Source: AK7set/LFfMaDVI9c/CcJesoRQEmXetMxIz7x1oo+Oe1MxbjGixZgj6gUzdRsFXwFdkE1H2Z1VUX4A==
X-Received: by 2002:aa7:9426:0:b0:60e:950c:7a55 with SMTP id y6-20020aa79426000000b0060e950c7a55mr8032387pfo.9.1678090310580;
        Mon, 06 Mar 2023 00:11:50 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id 9-20020aa79109000000b0060c55143fdesm5706038pfh.68.2023.03.06.00.11.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Mar 2023 00:11:50 -0800 (PST)
Date: Mon, 6 Mar 2023 16:18:08 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs: fix wrong kunmap when using LZMA on HIGHMEM
 platforms
Message-ID: <20230306161808.000046c0.zbestahu@gmail.com>
In-Reply-To: <20230305134455.88236-1-hsiangkao@linux.alibaba.com>
References: <20230305134455.88236-1-hsiangkao@linux.alibaba.com>
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun,  5 Mar 2023 21:44:55 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> As the call trace shown, the root cause is kunmap incorrect pages:
> 
>  BUG: kernel NULL pointer dereference, address: 00000000
>  CPU: 1 PID: 40 Comm: kworker/u5:0 Not tainted 6.2.0-rc5 #4
>  Workqueue: erofs_worker z_erofs_decompressqueue_work
>  EIP: z_erofs_lzma_decompress+0x34b/0x8ac
>   z_erofs_decompress+0x12/0x14
>   z_erofs_decompress_queue+0x7e7/0xb1c
>   z_erofs_decompressqueue_work+0x32/0x60
>   process_one_work+0x24b/0x4d8
>   ? process_one_work+0x1a4/0x4d8
>   worker_thread+0x14c/0x3fc
>   kthread+0xe6/0x10c
>   ? rescuer_thread+0x358/0x358
>   ? kthread_complete_and_exit+0x18/0x18
>   ret_from_fork+0x1c/0x28
>  ---[ end trace 0000000000000000 ]---
> 
> The bug is trivial and should be fixed now.  It has no impact on
> !HIGHMEM platforms.
> 
> Fixes: 622ceaddb764 ("erofs: lzma compression support")
> Cc: <stable@vger.kernel.org> # 5.16+
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> ---
>  fs/erofs/decompressor_lzma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
> index 091fd5adf818..5cd612a8f858 100644
> --- a/fs/erofs/decompressor_lzma.c
> +++ b/fs/erofs/decompressor_lzma.c
> @@ -278,7 +278,7 @@ int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
>  		}
>  	}
>  	if (no < nrpages_out && strm->buf.out)
> -		kunmap(rq->in[no]);
> +		kunmap(rq->out[no]);
>  	if (ni < nrpages_in)
>  		kunmap(rq->in[ni]);
>  	/* 4. push back LZMA stream context to the global list */

