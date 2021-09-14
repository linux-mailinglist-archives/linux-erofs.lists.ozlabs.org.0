Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0E940A5AB
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Sep 2021 06:57:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H7rh32wWwz2yPt
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Sep 2021 14:57:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=TGB04PEP;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::435;
 helo=mail-pf1-x435.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=TGB04PEP; dkim-atps=neutral
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H7rgz4GqYz2yNT
 for <linux-erofs@lists.ozlabs.org>; Tue, 14 Sep 2021 14:57:50 +1000 (AEST)
Received: by mail-pf1-x435.google.com with SMTP id m26so11032498pff.3
 for <linux-erofs@lists.ozlabs.org>; Mon, 13 Sep 2021 21:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=D4LVaOvMmQ70E4qW2vDWFmGBELkJCXPkZqyGHnKOmKs=;
 b=TGB04PEPuMcUxrZ020LUMyuCOfwLO5ZmT24uXjInd2ifJ6ZlFMybNLG9m9O7yAK3zw
 1etKaqxliDAeqpGLIuOMra/2q0A4MmM5BKPiB12HdFU/OcHwpsJvAvjbe+DDT+II70db
 P8O/c0XoIRimNy6JHSl0yTIBviNxKKablBtdhU4a2r24TwVH8buS26KQ14RfjgWXhqh/
 OBjop0frwtSK9+DjafzHeq7q8rRzSGqQG2BkFymjtxGrtrabYV2/B5r2pLQrW479Xy/u
 EOIcTtLMoQT5joytfg/NO4xIJu3lUQsEXoF+qaVnS2AcoWG0GP+cxfKm3yDx+Lauy0aR
 CqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D4LVaOvMmQ70E4qW2vDWFmGBELkJCXPkZqyGHnKOmKs=;
 b=el/p91nBiEznvyuH6YutS6F/Y9dcpVgSeztDbp+AkxdB+4xYTPW4axAupC4THikAAu
 TfGLXBGbkYbYCt8IOICG1CX8ehwbZX3Xu9AbOsAn7o4VRDa6+KIJLmb17mWdQgTNtIaR
 b9QSL7aB9Bbp2p3L7w8uQri4nsa67d2EtPptyOcIdJA2MNCXgZuIJQUkR3tqhiHyIx7n
 d1EST1GXgHmyPrl+JkSgpxXDMNkss+bSt3npAWcp/t6pmiZazPly+JJ03MjhZdzujAE6
 /TAHQo9ixUpc63UYjCOGqL03Zr9W4DI+Vp1/ZpRS8JswCw82EFzVKfJ6CDa1UCYJO+hH
 CmUA==
X-Gm-Message-State: AOAM5322GNHi5XKPShyGrftlQAaN0BGXVZLvYq5gdQTtfjENrwQP2Q3f
 TD49O7WohmvBHBa/paXEvyg=
X-Google-Smtp-Source: ABdhPJyGEWZLlLE4uzs0uDEFk3wJOwobzmkM46m2moyVAU+MWl07EGvtqqq48GQ+wXFUD37pIw3r5A==
X-Received: by 2002:a62:16c8:0:b0:43d:d6b8:f38 with SMTP id
 191-20020a6216c8000000b0043dd6b80f38mr2931552pfw.9.1631595465996; 
 Mon, 13 Sep 2021 21:57:45 -0700 (PDT)
Received: from localhost ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id o11sm8811383pfd.124.2021.09.13.21.57.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 13 Sep 2021 21:57:45 -0700 (PDT)
Date: Tue, 14 Sep 2021 12:57:48 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs: fix compacted_2b if compacted_4b_initial > totalidx
Message-ID: <20210914125748.00003cd2.zbestahu@gmail.com>
In-Reply-To: <YUAm+kOdKcCzgcEy@B-P7TQMD6M-0146.local>
References: <20210914035915.1190-1-zbestahu@gmail.com>
 <YUAm+kOdKcCzgcEy@B-P7TQMD6M-0146.local>
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

On Tue, 14 Sep 2021 12:37:14 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On Tue, Sep 14, 2021 at 11:59:15AM +0800, Yue Hu wrote:
> > From: Yue Hu <huyue2@yulong.com>
> > 
> > Currently, the whole indexes will only be compacted 4B if
> > compacted_4b_initial > totalidx. So, the calculated compacted_2b
> > is worthless for that case. It may waste CPU resources.
> > 
> > No need to update compacted_4b_initial as mkfs since it's used to
> > fulfill the alignment of the 1st compacted_2b pack and would handle
> > the case above.
> > 
> > We also need to clarify compacted_4b_end here. It's used for the
> > last lclusters which aren't fitted in the previous compacted_2b
> > packs.
> > 
> > Some messages are from Xiang.
> > 
> > Signed-off-by: Yue Hu <huyue2@yulong.com>  
> 
> Looks good to me,
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> (although I think the subject title would be better changed into
>  "clear compacted_2b if compacted_4b_initial > totalidx"

Yeah, 'clear' is much better for this change.

Thanks.

>  since 'fix'-likewise words could trigger some AI bot for stable
>  kernel backporting..)
> 
> Thanks,
> Gao Xiang
> 
> > ---
> >  fs/erofs/zmap.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> > index 9fb98d8..aeed404 100644
> > --- a/fs/erofs/zmap.c
> > +++ b/fs/erofs/zmap.c
> > @@ -369,7 +369,8 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
> >  	if (compacted_4b_initial == 32 / 4)
> >  		compacted_4b_initial = 0;
> >  
> > -	if (vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B)
> > +	if ((vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B) &&
> > +	    compacted_4b_initial <= totalidx) {
> >  		compacted_2b = rounddown(totalidx - compacted_4b_initial, 16);
> >  	else
> >  		compacted_2b = 0;
> > -- 
> > 1.9.1  

