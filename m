Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E59575C8F
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Jul 2022 09:44:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lkjzn19jKz3c4r
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Jul 2022 17:44:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=mSh4pzzI;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=mSh4pzzI;
	dkim-atps=neutral
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Lkjzg5HX7z3c20
	for <linux-erofs@lists.ozlabs.org>; Fri, 15 Jul 2022 17:44:13 +1000 (AEST)
Received: by mail-pj1-x1034.google.com with SMTP id o31-20020a17090a0a2200b001ef7bd037bbso5411353pjo.0
        for <linux-erofs@lists.ozlabs.org>; Fri, 15 Jul 2022 00:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=avIvPkXnH4SzoYsvQQ3wX9xzRxcp+KK0o8HXPKUV/IE=;
        b=mSh4pzzIpXEloPc9V5bLiMFg43NSDwzfV8P5RYg4xbMKDQ3m8yx50pQcKM57obdU6k
         iUoDXjXFzQK7wAvMS+QGgpIzeTw4XCSKiHnNPXpcyXLBOj0q2o8a2p+7Vx4HaykgWdSz
         3cWehxBsAn7z2EcC3PdUesMa4b+uMoHfWfuEdjtPJ9b2rrUHNSr6HyDmtfk7Gh8HSR+P
         RptNpT1h6qAZJ7MICp0GZouSomyEPh45qEEDvLcO8fwTyWSevcXXIMCax6Z5lSiLXKmq
         GMr69r4tGe5YFi+OTCNzbM+Zb4ZU6nLM2aohWXEZxyfwQihHkgij84pqNfm8x8vfoGve
         q2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=avIvPkXnH4SzoYsvQQ3wX9xzRxcp+KK0o8HXPKUV/IE=;
        b=GuG4/RewKH2arHfn5dVwd0CziamgXsge/gUEGmKU60PjQJFC4yCPShzAL8nITqTd4m
         tTovwy4VvVxLSwsMsb/SWadhTcl9jsDIFLitj/Zk3E/SW3qgYY260HGecBgfIsktukso
         ZrxziPy++kOwr60W9MHWWS1dgLH4QQp8AyfSrPCVWe2ETA2fYBdBAVhRDzrMY4CAu/oc
         aHXETaw8nwaqEmA5OexFitT+DPeUooHYGpQlf/5m6tkXfxKkD9HsFisqlsfPadV2/V7k
         wVHNjIPjd1ASiWl5IOiE8/WyccckBxHstj/JiML9hQXJ+c/0Q7D95aCoI4AuMvkcfnNb
         a+Ag==
X-Gm-Message-State: AJIora9hRbIJYXQcsDHYHFPmmRAbb6q2t0neuOEdwzRNkQflEoTcrx1D
	MrgAnwPoI27flJD5U1FPeMg=
X-Google-Smtp-Source: AGRyM1vaDyYSLJnrEGMuCac23Hk82LYQVuGvvv4seL7ZU6BSHWE12BwXlG1YUvAMNkm6SOCwKZqRJQ==
X-Received: by 2002:a17:902:f691:b0:16c:4fb6:e08b with SMTP id l17-20020a170902f69100b0016c4fb6e08bmr12610701plg.174.1657871048772;
        Fri, 15 Jul 2022 00:44:08 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id d1-20020a170902cec100b0016a091eb88esm2851078plg.126.2022.07.15.00.44.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jul 2022 00:44:08 -0700 (PDT)
Date: Fri, 15 Jul 2022 15:45:31 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 05/16] erofs: drop the old pagevec approach
Message-ID: <20220715154531.00005153.zbestahu@gmail.com>
In-Reply-To: <YtEVEtTOD2peFXum@B-P7TQMD6M-0146.local>
References: <20220714132051.46012-1-hsiangkao@linux.alibaba.com>
	<20220714132051.46012-6-hsiangkao@linux.alibaba.com>
	<20220715150737.00006764.zbestahu@gmail.com>
	<YtEVEtTOD2peFXum@B-P7TQMD6M-0146.local>
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, 15 Jul 2022 15:19:46 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On Fri, Jul 15, 2022 at 03:07:37PM +0800, Yue Hu wrote:
> > On Thu, 14 Jul 2022 21:20:40 +0800
> > Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> >   
> > > Remove the old pagevec approach but keep z_erofs_page_type for now.
> > > It will be reworked in the following commits as well.
> > > 
> > > Also rename Z_EROFS_NR_INLINE_PAGEVECS as Z_EROFS_INLINE_BVECS with
> > > the new value 2 since it's actually enough to bootstrap.  
> > 
> > I notice there are 2 comments as below which still use pagevec, should we
> > update it as well?
> > 
> > [1] 
> > * pagevec) since it can be directly decoded without I/O submission.
> > [2]
> > * for inplace I/O or pagevec (should be processed in strict order.)  
> 
> Yeah, thanks for reminder... I will update it in this patch in the next
> version.
> 
> > 
> > BTW, utils.c includes needles <pagevec.h>, we can remove it along with the patchset
> > or remove it later.  
> 
> That is a completely different stuff, would you mind submitting a patch
> to remove it if needed?

ok, may submit later.

> 
> Thanks,
> Gao Xiang

