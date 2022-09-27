Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C445EBDE7
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Sep 2022 10:59:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4McD7y1ZFCz3btV
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Sep 2022 18:59:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=GgBmwcCk;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=GgBmwcCk;
	dkim-atps=neutral
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4McD7r0DxFz2xsD
	for <linux-erofs@lists.ozlabs.org>; Tue, 27 Sep 2022 18:59:03 +1000 (AEST)
Received: by mail-pl1-x634.google.com with SMTP id z20so1618245plb.10
        for <linux-erofs@lists.ozlabs.org>; Tue, 27 Sep 2022 01:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=moz07TbQsZiM7w/D7SkEWNGBlBmpAeho7lKvgwF+ioc=;
        b=GgBmwcCkCghH3MmiFp36Bde43puo4yGC6iHlrQyyrizw7oRjuKA66En2G4yrAdj/Hm
         x75igb7Y2V5fQgBHvtXdEP9vrqSM8nAkGLcs1+tViPK1OPp8EpSSr/aBMRSGiZC48Vxu
         P6Xv/hQ2ifGTD9Qtfm0/5pve8/z1pwNzUDMVeaMmfjbL6RGR4T8x6107BNAEFCsrra05
         z2gqE8SKGmB2FtxIric0wWe8/zOyAaiOsoRlb6sj3CEegylEaws1mdTIM+A0u4+AVo9y
         nDDcDbj0XoSypdTwHmHwyz9nL1YrvS1pdXaiydwayVeGYESLhkGaazDr4oIM/IwK2JLi
         GCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=moz07TbQsZiM7w/D7SkEWNGBlBmpAeho7lKvgwF+ioc=;
        b=uxoYTGvOP6Xfb7zG/7BT2bzcT9ZH9hRpOcUYVNNIiBvGbiU2UYHx8yXRW0329ogmBh
         r/Y/eQwgLqu0Q2ZSlJUSQnK/xVX/CM/xJMHxDLzbfEB1ILibsJ2OgSAkYP85Cw6tFLOK
         dBnqvnSrIknzDAWpmTZcHmtXGdVjRth7yqC419hOkc6XeNJiYy3K3PVj23bPlHvVsqc/
         PMoXZT5iyyBnGeYAcRtI1NwPf01e9NokSdTvlHLytUZfBPdT9yY5XKdVMpacS1V4dSPk
         7buuQmPLDTBGancMa1Oka46CS6eQGI+WA/lGfRVmp87dKD3fJFMf+A7naIpSrCYaHPmk
         b3Aw==
X-Gm-Message-State: ACrzQf0YCKtWKP0236VczHTHm0uILa+ti3M/IxWr+xhc57NNw76Ly6u1
	Bxof2vIxE2ZZkk+4qgLl4Wc=
X-Google-Smtp-Source: AMsMyM7iCEjOg8Cze41po0WsIFUj30hSloeEo+ux85VFzGjsUyG+MekPzJ/Xwfw68xK91RCWJd3ZxA==
X-Received: by 2002:a17:902:f152:b0:179:f329:8d6d with SMTP id d18-20020a170902f15200b00179f3298d6dmr781012plb.122.1664269140134;
        Tue, 27 Sep 2022 01:59:00 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id q10-20020aa7982a000000b0053e56165f42sm1140996pfl.146.2022.09.27.01.58.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Sep 2022 01:58:59 -0700 (PDT)
Date: Tue, 27 Sep 2022 17:01:47 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 2/2] erofs: clean up erofs_iget()
Message-ID: <20220927170147.000021fe.zbestahu@gmail.com>
In-Reply-To: <20220927063607.54832-2-hsiangkao@linux.alibaba.com>
References: <20220927063607.54832-1-hsiangkao@linux.alibaba.com>
	<20220927063607.54832-2-hsiangkao@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, 27 Sep 2022 14:36:07 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> isdir indicated REQ_META|REQ_PRIO which no longer works now.
> Get rid of isdir entirely.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> ---
>  fs/erofs/inode.c             | 24 ++++++++----------------
>  fs/erofs/internal.h          |  2 +-
>  fs/erofs/namei.c             |  2 +-
>  fs/erofs/super.c             |  8 ++++----
>  include/trace/events/erofs.h | 11 ++++-------
>  5 files changed, 18 insertions(+), 29 deletions(-)
> 
