Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDDC43C493
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Oct 2021 10:03:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HfLm26khNz2y8R
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Oct 2021 19:03:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=qqkmBjqp;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::530;
 helo=mail-pg1-x530.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=qqkmBjqp; dkim-atps=neutral
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HfLlv2ZBdz2xXJ
 for <linux-erofs@lists.ozlabs.org>; Wed, 27 Oct 2021 19:03:05 +1100 (AEDT)
Received: by mail-pg1-x530.google.com with SMTP id 83so2135921pgc.8
 for <linux-erofs@lists.ozlabs.org>; Wed, 27 Oct 2021 01:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tw+D8nGWMM1sdgzts1z82Q2nw636yB/mqwIaXvfRfNI=;
 b=qqkmBjqptUr4efFJn/TYXrWxqtVqw2AsEQRrViFLmULx3JHC5QLy18FX0iAi980w7p
 e0t3pWL5mYdyX0AtY+tqYBEsLcALeztqjqULJi6/OnZqJRc/rTT1N4fT1mgSzfjUafB7
 ri5fXQXID25zCOq7XGM9rXwXKZP8ALeXYbp9OaHwUCzgRwvAdBsLNP6ocv4lcNpjLwEQ
 KO+BuG9PJrKVTVoWTe4/4cML0BSFyORqew8Fut9ykFHQ37zL6KbjgVTzEsWlN/X9GNVl
 yEcu1i8LFQTTjH1Dig+XjeDCt/BhV51Ox8dBamK/vt82CucRXdB4ZyeUlMCkQ5xHAWCY
 4mcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tw+D8nGWMM1sdgzts1z82Q2nw636yB/mqwIaXvfRfNI=;
 b=DUpUpmt25Cwwhcf0VUhyTquJH2ccZ02lU+ZxDrTZPAp5fDfDZ8sjCjNei3zm90Pn75
 8epdTvlWWMmYST1z4AS9rkgP+ZSLA+oi6ZLd578kVzvfEPBtUAKtJTnkItbG8EAoJFrq
 cK3UXYw+fJEGCSFTo49xQtOHj8YbMvjLcPIRWz18PaUhlyCkUKObJQkMFK8X8V2s9B8d
 PLqHGbAzRKvwrxwq8YBn0N83PmHqFTWPrI2Sanlmb21G5P6El/DZDS4A9lQYhN3i/9pv
 ovQytz5NEvuyYemutPGYlf1SsoHzO6NEMIYYS1MDy67JN95c+e1xOI2UoTDtSLEZtQjU
 Bnog==
X-Gm-Message-State: AOAM533rwsEnkFmwkqWcWBwqmsPXvnXMOSbS3yEFDe4FbGJsvZK6lgL7
 +l3exNk9VENNkUL3blQzE5d6k+rhsbOLYQ==
X-Google-Smtp-Source: ABdhPJyJWeDuINiwQy3z5ZprNuExzt49Ode/uRVSKDej+W+QUoBPatv9jjy9DAkX+0dGQeOYCImXPA==
X-Received: by 2002:a63:2c91:: with SMTP id
 s139mr22505652pgs.116.1635321783050; 
 Wed, 27 Oct 2021 01:03:03 -0700 (PDT)
Received: from localhost ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id h4sm22048338pgn.6.2021.10.27.01.03.00
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 27 Oct 2021 01:03:02 -0700 (PDT)
Date: Wed, 27 Oct 2021 16:02:15 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [RFC PATCH 1/2] erofs-utils: support tail-packing inline
 compressed data
Message-ID: <20211027160215.00000527.zbestahu@gmail.com>
In-Reply-To: <YXkBIpcCG12Y8qMN@B-P7TQMD6M-0146.local>
References: <cover.1635162978.git.huyue2@yulong.com>
 <9adbee63d0bfb18ec3f8de66d196f8ffee483226.1635162978.git.huyue2@yulong.com>
 <YXft5YhayWvt3DPM@B-P7TQMD6M-0146.local>
 <20211027095452.00006c1e.zbestahu@gmail.com>
 <20211027152137.000043e5.zbestahu@gmail.com>
 <YXkBIpcCG12Y8qMN@B-P7TQMD6M-0146.local>
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
Cc: linux-erofs@lists.ozlabs.org, Yue Hu <huyue2@yulong.com>,
 geshifei@yulong.com, zhangwen@yulong.com, shaojunjun@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Xiang,

On Wed, 27 Oct 2021 15:34:58 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Hi Yue,
> 
> On Wed, Oct 27, 2021 at 03:21:37PM +0800, Yue Hu wrote:
> 
> ...
> 
> > > > > -		if (len <= pclustersize) {
> > > > > +		if (!tail_pcluster && len <= pclustersize) {
> > > > >  			if (final) {
> > > > > -				if (len <= EROFS_BLKSIZ)
> > > > > +				if (erofs_sb_has_tailpacking()) {
> > > > > +					tail_pcluster = true;
> > > > > +					pclustersize = EROFS_BLKSIZ;    
> > > > 
> > > > Not quite sure if such condition can be trigged for many times...
> > > > 
> > > > Think about it. If the original pclustersize == 16 * EROFS_BLKSIZ, so we
> > > > could have at least 16 new pclustersize == EROFS_BLKSIZ then?
> > > > 
> > > > But only the last pclustersize == EROFS_BLKSIZ can be inlined...  
> > > 
> > > Let me think about it more.  
> > 
> > I understand we need to compress the tail pcluster(len <= pclustersize) by destsize
> > of fixed 4KB to get better inline result. rt?  
> 
> I think this is the tricky part of tail-packing inline support for
> compressed data.
> 
> As you may know, EROFS supports variable-sized blocks for each pcluster
> so you could change pclustersize accordingly for the last pclusters.
> 
> For example, originally if the size of the last one pcluster is
> 16 * EROFS_BLKSIZ (therefore it cannot be tail-packing directly), there
> are 2 policies in practice can be achieved:
>  1) compress with 2 pclusters ---
>       X pcluster size + Y (Y <= 4KiB) pcluster size (so the last one can
>    be tail-packing);

Sounds good. Let me check.

>  2) compress with 4KiB pclusters ---
>       4KiB pcluster + 4KiB pcluster + ... + Z (Z <= 4KiB) pcluster
> 
> I'm not sure which one is easier to implement, maybe 2) is easier, so we
> could implement it first.

Yeah, the patch already includes it.

Thanks.

> 
> Thanks,
> Gao Xiang
> 

