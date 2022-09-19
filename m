Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C285BC10A
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Sep 2022 03:35:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MW6gZ3jJdz303t
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Sep 2022 11:35:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=VwTS/iD3;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=VwTS/iD3;
	dkim-atps=neutral
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MW6gT1Bgwz2xJM
	for <linux-erofs@lists.ozlabs.org>; Mon, 19 Sep 2022 11:35:15 +1000 (AEST)
Received: by mail-pj1-x1030.google.com with SMTP id fs14so26308462pjb.5
        for <linux-erofs@lists.ozlabs.org>; Sun, 18 Sep 2022 18:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=N8eqqewSNmFIl18uGjm9/zwnlUkZ2Q0UubEd4wLISog=;
        b=VwTS/iD32l18B+pXNDm5P9ZD7eMFp3vlJSuYaDdUPeMCzLhQhs/JW2ONtw3Q1opXD+
         I40OrHfOKTnrKAUE1loXBWZO+JGcdVA7OmXCKEimDHHimhVvAVyB9Yl+kECFQgRxyf7g
         SGINgLLmK8IMTm/lCy30VpdNramxoJtCwpGevCIujBagUt7koRlyMbu4m8jXTcJCC155
         cESv0n5Wdu6HCyvbfLMk6KhdV6Oh2ZGPnY+oSJV7+Sgs3SrbkGyjq8p0m4POIyJm0w4x
         6up2jG4lOk4Ipm0ofExSwhwmPg88SShlFEiY/H6nfMdyjF6u+JJvFQXd70PjDvBz4TRM
         g3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=N8eqqewSNmFIl18uGjm9/zwnlUkZ2Q0UubEd4wLISog=;
        b=kAJ3UzFdPsHEpKgDmMeCWGaCWGGrsmHri8t2l2a1AJ9sjvSq81dIffWQ6+LFrUWhgv
         qG2j5jJNdAKvLdlzFFwrPvmMDFekjnKL4IRXxHVX86IsRMp51E3gMpYO2e5ilw5RhI6E
         o14ks7/a4uLgwthK8ktSaqPLTDB9zDW/I+UTa7ib6hKtgPuMhj6lvh40g15Z13GjEQsI
         uPNf/BKP582v1Xj5Ka/tlx3L851DVwkBpO+5noO1A/9eBmENz1O/8Sl/rSz0qdLTqtGk
         UmOy7y9AFcbK21CACMGehhkHqufxDAXP8h94sXz/dI0AkZcG48xRhqrsBHWE6tJlbeqP
         ZDBQ==
X-Gm-Message-State: ACrzQf1slffoqN0eluY3gHEeQKUJsm7AEbfbW6gWhBapO2n37pEAUf2z
	ibs2GBMuup0wW4pldMuUeaQ=
X-Google-Smtp-Source: AMsMyM7lvEM+F5KGX5dk+CXMe09P0qpCz6hXV6oKU7UGjQPmGeo6vkBsjnZ8m1oqiBhixFIlsEMQ8g==
X-Received: by 2002:a17:903:2290:b0:178:48b6:f57c with SMTP id b16-20020a170903229000b0017848b6f57cmr10663601plh.78.1663551311817;
        Sun, 18 Sep 2022 18:35:11 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id a5-20020aa794a5000000b00543a098a6ffsm15837530pfl.212.2022.09.18.18.35.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Sep 2022 18:35:11 -0700 (PDT)
Date: Mon, 19 Sep 2022 09:37:47 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs: fix order >= MAX_ORDER warning due to crafted
 nagative i_size
Message-ID: <20220919093747.00005bd6.zbestahu@gmail.com>
In-Reply-To: <20220909023948.28925-1-hsiangkao@linux.alibaba.com>
References: <000000000000ac8efa05e7feaa1f@google.com>
	<20220909023948.28925-1-hsiangkao@linux.alibaba.com>
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
Cc: syzkaller-bugs <syzkaller-bugs@googlegroups.com>, syzbot+f966c13b1b4fc0403b19@syzkaller.appspotmail.com, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri,  9 Sep 2022 10:39:48 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> As syzbot reported [1], the root cause is that i_size field is a
> signed type, and negative i_size is also less than EROFS_BLKSIZ.
> As a consequence, it's handled as fast symlink unexpectedly.
> 
> Let's fall back to the generic path to deal with such unusual i_size.
> 
> [1] https://lore.kernel.org/r/000000000000ac8efa05e7feaa1f@google.com
> Reported-by: syzbot+f966c13b1b4fc0403b19@syzkaller.appspotmail.com
> Fixes: 431339ba9042 ("staging: erofs: add inode operations")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index 95a403720e8c..16cf9a283557 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -214,7 +214,7 @@ static int erofs_fill_symlink(struct inode *inode, void *kaddr,
>  
>  	/* if it cannot be handled with fast symlink scheme */
>  	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
> -	    inode->i_size >= EROFS_BLKSIZ) {
> +	    inode->i_size >= EROFS_BLKSIZ || inode->i_size < 0) {

Reviewed-by: Yue Hu <huyue2@coolpad.com>

>  		inode->i_op = &erofs_symlink_iops;
>  		return 0;
>  	}

