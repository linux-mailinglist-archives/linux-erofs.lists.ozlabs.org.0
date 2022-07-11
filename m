Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AABC56FE86
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Jul 2022 12:13:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LhKTY271Kz3by6
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Jul 2022 20:13:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=RH05kk3h;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=RH05kk3h;
	dkim-atps=neutral
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LhKTQ5BgPz3btW
	for <linux-erofs@lists.ozlabs.org>; Mon, 11 Jul 2022 20:13:12 +1000 (AEST)
Received: by mail-pl1-x62a.google.com with SMTP id c13so4033278pla.6
        for <linux-erofs@lists.ozlabs.org>; Mon, 11 Jul 2022 03:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hl6SPBbcxnLLqUyEqwGr1xCp1ST4jLdZII9tc/ys75w=;
        b=RH05kk3hMZDKvbvrNTCOEaPOXhCfh8wdSCPwJy4v1sfheyVkPT6SrL8R5e9L+z7yiL
         0OOb62yTqwxKSQzWnGrTXnjq4qXknHE321VsYonW5upN5rirHR9Hs5/0TpntCUZQXVXf
         uiowtslfDNLDG0SSVR2bRCqfiQR1q3AxMU9fYm5V8yKG1YmisGonf72Wv2W6paPHC7Xq
         nCy7/Lk4sPuphw+xF2ioFo2ummIIyTdT+tYYD7sYsz6Gn7YYnq8iEBvMU1t/2DXmkUUP
         tt3YGY3IOKVOdWsnx0/fcDNFRhB47wDs2tSEtzhVUjVwsdYH/hxQVJ/ehuaPG9+Lv7Dz
         zvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hl6SPBbcxnLLqUyEqwGr1xCp1ST4jLdZII9tc/ys75w=;
        b=KwZKgmE5q35owdHPx9rMic+Ja8hGSsfF4LBMsJNp2s2rEMI3AfwMeUbLA8FGrF08cS
         kGtqbEcgZo1cLqDiG6zBbCcoHzBj30US06ySlfGL0R9+aqTZKZ1oTDLSut8FVM3WFlKQ
         jlHYemI+vyc+4AL8nC8DKyU6+z5aSn/9GSX2rS6rHx55bmSWhq9AKvP2cvWgpWnglN7X
         oL0X2D0hbR4RYCpTK0hQEvdxiiuyorSjAUoATdi3V/B7Qa9yiIfimWWUkia6PMNXS3ZK
         kurO+TQt2WKoWOhmZQ0vPYnIo8uqjptnS9Vp9otRo0XMD3wEEmct59PDh+J2igWjdp+h
         ziaQ==
X-Gm-Message-State: AJIora9BpvuQlJb024uyQz7FMG1sVpv2mmaWeNGxD7YafQhq2b/9aRz5
	BjUlnNm/w346Fv4mbYIsfuA=
X-Google-Smtp-Source: AGRyM1vfwxhg0wpcqdiS201pXwdYjtwaHRutWaklx717Xd3k2UCJqQ+NIRSa9yERA8T60o0zi7ZvNQ==
X-Received: by 2002:a17:902:db12:b0:16c:3273:c7a9 with SMTP id m18-20020a170902db1200b0016c3273c7a9mr11440548plx.49.1657534390630;
        Mon, 11 Jul 2022 03:13:10 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id q11-20020aa7982b000000b005289fad1bbesm4523218pfl.94.2022.07.11.03.13.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jul 2022 03:13:10 -0700 (PDT)
Date: Mon, 11 Jul 2022 18:14:30 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [RFC PATCH 0/3] erofs-utils: compressed fragments feature
Message-ID: <20220711181430.000006bd.zbestahu@gmail.com>
In-Reply-To: <Ysv1QyAvxfmiRECJ@B-P7TQMD6M-0146.local>
References: <cover.1657528899.git.huyue2@coolpad.com>
	<Ysv1QyAvxfmiRECJ@B-P7TQMD6M-0146.local>
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, zbestahu@163.com, shaojunjun@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Xiang,

On Mon, 11 Jul 2022 18:02:43 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Hi Yue,
> 
> On Mon, Jul 11, 2022 at 05:09:55PM +0800, Yue Hu wrote:
> > In order to achieve greater compression ratio, let's introduce
> > compressed fragments feature which can merge tail of per-file or the
> > whole files into one special inode to reach the target.
> > 
> > And we can also set pcluster size to fragments inode for different
> > compression requirments.
> > 
> > In this patchset, we also improve the uncompressed data layout of
> > compressed files. Just write it from 'clusterofs' instead of 0 since it
> > can benefit from in-place I/O. For now, it only goes with fragments.
> > 
> > The main idea above is from Xiang.
> >   
> 
> I just took a preliminary try and it seems work, but in order to form it
> better, I have to postpone it for the next version of 5.20 (6.0?)
> since I'm still working on cleaning up and rolling hash deduplication.

Got it.

Thanks.

> 
> Thanks,
> Gao Xiang

