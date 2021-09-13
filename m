Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8FB4087B3
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Sep 2021 11:00:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H7L6G1g3mz2yKJ
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Sep 2021 19:00:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=kBpAPqK3;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1030;
 helo=mail-pj1-x1030.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=kBpAPqK3; dkim-atps=neutral
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H7L6B5Jgfz2xrT
 for <linux-erofs@lists.ozlabs.org>; Mon, 13 Sep 2021 19:00:17 +1000 (AEST)
Received: by mail-pj1-x1030.google.com with SMTP id
 j10-20020a17090a94ca00b00181f17b7ef7so6064246pjw.2
 for <linux-erofs@lists.ozlabs.org>; Mon, 13 Sep 2021 02:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VkpJ0ngl+MoG+ZOZwlNHaKDQYip+ieFhBWnmpJwyR7I=;
 b=kBpAPqK3g4R8wFMAdR40WxYIRIRgjY2dtlxtTWoM0n2TM0vNpUO9DdJIagGY7WdlOv
 JyLh+Jhr5EvO/R364B5Y7IznobfoKS26FNX36oIVDidA7rmBYzt0giJeg4Bun8yslmkq
 XdEnMZ72o7N0Qpan97hOZD11iKw+I/gJU+Akv00hBJPRb0wIF3XJF8FRGCpKPzS2Qfyp
 h4KKt+gGsUnIG7oZiM37zRYF+BkKKjohSGejcWxwZ8giY2Ga8lquOOc/1YAIV6faEPZ4
 1c3Rh0hZSZytMVgwhfUYHbm5KIt0kQfM73uTLEbVUzUwxj3sxUEuxHFO0yaoRtr7iGag
 EvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VkpJ0ngl+MoG+ZOZwlNHaKDQYip+ieFhBWnmpJwyR7I=;
 b=4/0Hu85QLAgnP28qSrxXVtfeBgrZj2GLKrsU93QLdN9r/VGhRZCrwSzA7OMiI5FXbR
 uLZAs4rra/C2BucDArQb16n7gfCafPs8SM/xq/3H7cgM5FuxLa696jL9Vrq15atP8jHa
 GjJlXY+cgQ44RGmJ+ODQgPPRMLcD/4xsz0RvL6liCN38p+ZHnCIEU74bj38Wr+NF0IWB
 6yw4VDLBvud/d7X343XM5/jtz9idvB+oRihn1COxBEQhPoINe9ZIZ6WxkNPNa2Pys0zH
 dgPuIz7n3EZoy6sCvpEn2Vh5pBv6MukVCNEywmEA4VNteYmh0Onw65l1lIDpaeupYgUq
 TwFw==
X-Gm-Message-State: AOAM533nLzD+jBeuSKbo4YFFUE+t25wWDhcR38/qldbzLMXnuhWn6ptD
 KpY94GJXNi1ilVyyHSOT2EI=
X-Google-Smtp-Source: ABdhPJwHLwwJSnil6LxlzpTe1aIE0cj1zgWJzPmjo2kTx3RcMUdCQo0BwN6k+wi4yDGJ8bujJDvkTg==
X-Received: by 2002:a17:90a:af92:: with SMTP id
 w18mr11750582pjq.98.1631523614113; 
 Mon, 13 Sep 2021 02:00:14 -0700 (PDT)
Received: from localhost ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id z62sm3113984pjj.53.2021.09.13.02.00.12
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 13 Sep 2021 02:00:13 -0700 (PDT)
Date: Mon, 13 Sep 2021 17:00:16 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs: fix compacted_{4b_initial, 2b} when
 compacted_4b_initial > totalidx
Message-ID: <20210913170016.00007580.zbestahu@gmail.com>
In-Reply-To: <YT8QbaAEkqBw//R0@B-P7TQMD6M-0146.local>
References: <20210913072405.1128-1-zbestahu@gmail.com>
 <YT8QbaAEkqBw//R0@B-P7TQMD6M-0146.local>
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
Cc: linux-kernel@vger.kernel.org, zbestahu@163.com, huyue2@yulong.com,
 linux-erofs@lists.ozlabs.org, zhangwen@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, 13 Sep 2021 16:48:45 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Hi Yue,
> 
> On Mon, Sep 13, 2021 at 03:24:05PM +0800, Yue Hu wrote:
> > From: Yue Hu <huyue2@yulong.com>
> > 
> > mkfs.erofs will treat compacted_4b_initial & compacted_2b as 0 if
> > compacted_4b_initial > totalidx, kernel should be aligned with it
> > accordingly.  
> 
> There is no difference between compacted_4b_initial or compacted_4b_end
> for compacted 4B. Since in this way totalidx for compact 2B won't larger
> than 16 (number of lclusters in a compacted 2B pack.)

However, we can see compacted_2b is a big number for this case. It should
be pointless.

Thanks.

> 
> So it can be handled in either compacted_4b_initial or compacted_4b_end
> cases, because there are all compacted 4B.
> 
> Thanks,
> Gao Xiang
> 
> > 
> > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > ---
> >  fs/erofs/zmap.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> > index 9fb98d8..4f941b6 100644
> > --- a/fs/erofs/zmap.c
> > +++ b/fs/erofs/zmap.c
> > @@ -369,7 +369,10 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
> >  	if (compacted_4b_initial == 32 / 4)
> >  		compacted_4b_initial = 0;
> >  
> > -	if (vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B)
> > +	if (compacted_4b_initial > totalidx) {
> > +		compacted_4b_initial = 0;
> > +		compacted_2b = 0;
> > +	} else if (vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B)
> >  		compacted_2b = rounddown(totalidx - compacted_4b_initial, 16);
> >  	else
> >  		compacted_2b = 0;
> > -- 
> > 1.9.1  

