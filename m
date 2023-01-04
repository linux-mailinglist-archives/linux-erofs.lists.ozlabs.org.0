Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7691165CD8F
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Jan 2023 08:22:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Nn1JC2Tdsz3bTJ
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Jan 2023 18:22:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=one8Tbor;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=one8Tbor;
	dkim-atps=neutral
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Nn1J41hkgz2xCd
	for <linux-erofs@lists.ozlabs.org>; Wed,  4 Jan 2023 18:21:55 +1100 (AEDT)
Received: by mail-pl1-x630.google.com with SMTP id p24so12564056plw.11
        for <linux-erofs@lists.ozlabs.org>; Tue, 03 Jan 2023 23:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iw3XIQUksqj4ssUgSZQEszCRLX4KEhd3YST2RU5OcP0=;
        b=one8Tborvjv6BnESJ7pJdh7XmYmShMVve8kJY2Meha8m+4AHB19r/O69AgW5InIj1k
         GNL5qgap5qC6wCad15RaOlIt//Wmk0QwBf1/lD/6pssPhzECrecH/GsysK6Dy0OhYrmP
         Zc9IyDu/ygzP7B563Yn/4+7YBoz2e6GAjfFKa47e2IdwLVRo52yLDQ7Y77ErueP/pA0n
         QZzUiKkeq+CPGpeIU1bI8o1LczafX4JW+W2snHfg19H14bM6WqHkBDp9p8sVspO+2NR0
         nk262i5htC433b1d/vovcWle3lVYreQRvCwAh2I2wZeFiflzaKGQkctuF3qMqclELE2s
         /AKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iw3XIQUksqj4ssUgSZQEszCRLX4KEhd3YST2RU5OcP0=;
        b=rAZViygfmpGzgtUKUnXRHRgs2W2Zpswcc+JQTDhelXQoRCb/UTPM5jwK+df8B2kTXd
         npwhxve4xyGuLPj/1QhqidbbLUK1hJymzYSsdF3wg/kc96XjpT+2JyHdVVUt1/t60fxT
         hki8SSCMz5D9o838H2Cpu+WilPTgLMiNzoS29Xdp5Yg73YR1p0LZVdUSzKzb19YPTr3V
         b/bMZ0IF3Iu9OIYdLEBqPbocCjtVpMmECR/hMzoZeQWlece9vakuhGYM+CwlwTc6ZA1S
         Z7WTCVDkIZ/x3G135ON9eau09ZTBRpnQI6Qh7+r9Ff4Bvk93S77dcxIgKjdXA3v9Omq9
         J1yg==
X-Gm-Message-State: AFqh2kr3CP42xDWNsjn7+3fcuZZrcrsM/MXDnIVP3kvQs1XwNO9MCZ2h
	LHVYtNSzm7Zf0uu8A+u+yNZRihtHffo=
X-Google-Smtp-Source: AMrXdXtP/nYsvf/6rufksPVTfBXM8n8wmOqVwnkoIJ2asVukojZKgPDDdWqFodou9AdqTwrQXa4NKA==
X-Received: by 2002:a17:902:7c95:b0:192:a04b:76be with SMTP id y21-20020a1709027c9500b00192a04b76bemr24520498pll.25.1672816912291;
        Tue, 03 Jan 2023 23:21:52 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id ij6-20020a170902ab4600b00176e6f553efsm23298023plb.84.2023.01.03.23.21.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jan 2023 23:21:52 -0800 (PST)
Date: Wed, 4 Jan 2023 15:26:51 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Xiang Gao <hsiangkao@linux.alibaba.com>
Subject: Re: [RFC PATCH] erofs-utils: fsck: support fragments
Message-ID: <20230104152651.000051df.zbestahu@gmail.com>
In-Reply-To: <5236b19c-763f-9a5b-a0c1-4c59fa7c6d05@linux.alibaba.com>
References: <20221224094319.10317-1-zbestahu@gmail.com>
	<fa1df3e5-9158-4381-5315-d243f77542a6@linux.alibaba.com>
	<20230104112445.000075d8.zbestahu@gmail.com>
	<5236b19c-763f-9a5b-a0c1-4c59fa7c6d05@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=GB18030
Content-Transfer-Encoding: 8bit
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, 4 Jan 2023 11:32:36 +0800
Xiang Gao <hsiangkao@linux.alibaba.com> wrote:

> On 2023/1/4 11:24, Yue Hu wrote:
> > Hi Xiang,
> > 
> > On Wed, 4 Jan 2023 10:48:40 +0800
> > Xiang Gao <hsiangkao@linux.alibaba.com> wrote:
> >   
> >> Hi Yue,
> >>
> >> ÔÚ 2022/12/24 17:43, Yue Hu Ð´µÀ:  
> >>> From: Yue Hu <huyue2@coolpad.com>
> >>>
> >>> Add compressed fragments support for fsck.erofs.
> >>>
> >>> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> >>> ---
> >>>    fsck/main.c | 41 +++++++++++++++++++++++++++++++++++++++--
> >>>    lib/zmap.c  |  1 +
> >>>    2 files changed, 40 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/fsck/main.c b/fsck/main.c
> >>> index 2a9c501..9babc61 100644
> >>> --- a/fsck/main.c
> >>> +++ b/fsck/main.c
> >>> @@ -421,6 +421,31 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
> >>>    		if (!(map.m_flags & EROFS_MAP_MAPPED) || !fsckcfg.check_decomp)
> >>>    			continue;
> >>>    
> >>> +		if (map.m_flags & EROFS_MAP_FRAGMENT) {
> >>> +			struct erofs_inode packed_inode = {
> >>> +				.nid = sbi.packed_nid,
> >>> +			};  
> >>
> >> Sorry for late response.
> >>
> >> a question... why don't we just rely on z_erofs_read_data()?  
> > 
> > We may fall back to uncompressed mode for packed inode due to 'ENOSPC'.  
> 
> I think we could just export parts of erofs_pread() to clean up the 
> whole erofs_verify_inode_data()...

What's the clean up referring to?

However, i think erofs_verify_inode_data() looks a little duplicate compared to erofs_read_raw_data/z_erofs_read_data().

> 
> Thanks,
> Gao Xiang
> 
> 

