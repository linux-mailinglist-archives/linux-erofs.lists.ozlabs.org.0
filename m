Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E458D5FEAAB
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Oct 2022 10:41:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Mpfxr5kC5z3c9p
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Oct 2022 19:41:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=f74R1eu/;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::e30; helo=mail-vs1-xe30.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=f74R1eu/;
	dkim-atps=neutral
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mpfxh7098z2xf4
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Oct 2022 19:41:27 +1100 (AEDT)
Received: by mail-vs1-xe30.google.com with SMTP id p7so4196480vsr.7
        for <linux-erofs@lists.ozlabs.org>; Fri, 14 Oct 2022 01:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRQg6RjQGJENsG7CF0FPudfuL82rZYfFlg8d/iSFwrg=;
        b=f74R1eu/WjTVGmhtltkZ29+rXHklK7MZtjpK8vfbJaE0DuZFsOXVtx9bsH+UO3hu14
         6e8c20KtsJ+qF14rlJyjkwbQi3AxIIV0oTxLbX0XArv6r0i+Hu2gqKaeGDrThDUni1+U
         tUj5Khe3nlHobA1U8n5SK0TET6hevXcQ3zp3PQAdxS4v21f/z8E9+32e0q1H78el5zKP
         FN8o3POBAGtivXBUiQ/7rDVAIIuFW7va77Ob7yfXu1rl+rduov81DhUnvUDxxEuvIJ/u
         TVMlsECT2P1Ue0gp0O+MJrl5hEQ2i8NkSyVXf07yR6ovBNnEtWwdeqPO1xdK3sn0pmhJ
         8GRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tRQg6RjQGJENsG7CF0FPudfuL82rZYfFlg8d/iSFwrg=;
        b=JtEUrEFRenVsMdIHSi7kc4cnmu23SzLPK2w+Yic67gSav1Nv4ArUPo/uw0UYtBOYUE
         Wd0OuUa82EcjpSSfnF7WNZoONP61PdqVvSQnLXbwEAW9w0zL7pnBgnq3dV4rM72NCd/d
         2dD1G/DF8pitP1HAklXcxNtP/o6uDObXnb4w7K46rcATpfrIXWjSabxF16I0cA3ycKwb
         kco2aA6YFVzMow41+gjhJizykskQiipZ81iCM8LCSXywiRT/DiDInOuUV+GVRY5wtYOl
         d6B7BfqAdWI70tfNkp7IceGM69CRof9xaSzED0jYU8tpj4Dfe86pQDhDEDnSJnmRMwwx
         8/3A==
X-Gm-Message-State: ACrzQf251S1rMOh7XzGEHV9K/CocJBWp6jwJK1iJ5v3O0u7M0gQrcd8U
	MRzROBuBXwxmIPxP8qDuvrpHaTSAaIM=
X-Google-Smtp-Source: AMsMyM68VgWNRfuve9zyXSSI0tuO9Cc3UW+BRaQQgHw2DEDWrU0OSSA8EXdE7A2pkIS4RmBMOLyg6g==
X-Received: by 2002:a17:903:48e:b0:17f:802b:f079 with SMTP id jj14-20020a170903048e00b0017f802bf079mr4210484plb.89.1665736873654;
        Fri, 14 Oct 2022 01:41:13 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id cq14-20020a17090af98e00b001fe39bda429sm1000986pjb.38.2022.10.14.01.41.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Oct 2022 01:41:13 -0700 (PDT)
Date: Fri, 14 Oct 2022 16:44:22 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs-utils: avoid unnecessary insert behavior when not
 deduplicating
Message-ID: <20221014164422.0000497a.zbestahu@gmail.com>
In-Reply-To: <Y0jGP6gDnP+2WAry@B-P7TQMD6M-0146.local>
References: <20221013040011.31944-1-zbestahu@gmail.com>
	<Y0fTbmoezlKid246@B-P7TQMD6M-0146.local>
	<20221014094846.00005bdb.zbestahu@gmail.com>
	<Y0jGP6gDnP+2WAry@B-P7TQMD6M-0146.local>
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Xiang,

On Fri, 14 Oct 2022 10:15:27 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On Fri, Oct 14, 2022 at 09:48:46AM +0800, Yue Hu wrote:
> > On Thu, 13 Oct 2022 16:59:26 +0800
> > Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> >   
> > > Hi Yue,
> > > 
> > > On Thu, Oct 13, 2022 at 12:00:11PM +0800, Yue Hu wrote:  
> > > > From: Yue Hu <huyue2@coolpad.com>
> > > > 
> > > > We should do nothing in dedupe inserting when it's not configured.
> > > > 
> > > > Signed-off-by: Yue Hu <huyue2@coolpad.com>
> > > > ---    
> > > 
> > > Thanks for the patch, do you observe some strange happening?   
> > 
> > I can see malloc/memcpy at runtime when dedupe is disabled. So, just skip.  
> 
> Would you mind confirming the numbers of e->length and window_size 
> at that time?

The caller to insert function is just checking "!may_inline && !may_packing".

Check below (-zlz4hc foo.img foo/):

Processing .gitignore ...
<E> erofs: z_erofs_dedupe_insert() Line[105] e->length 84, window_size 0
Processing Kconfig.freezer ...
<E> erofs: z_erofs_dedupe_insert() Line[105] e->length 92, window_size 0
Processing Kconfig.hz ...
<E> erofs: z_erofs_dedupe_insert() Line[105] e->length 1709, window_size 0

--- a/lib/dedupe.c
+++ b/lib/dedupe.c
@@ -102,6 +102,8 @@ int z_erofs_dedupe_insert(struct z_erofs_inmem_extent *e,
        if (e->length < window_size)
                return 0;

+       erofs_err("e->length %u, window_size %u", e->length, window_size);
+
        di = malloc(sizeof(*di) + e->length - window_size);

Thanks.

> 
> Thanks,
> Gao Xiang
> 
> >   
> > > 
> > > IMO, If dedupe is not enabled, window_size will be 0 I think.
> > > However, I think we might need to disable it explicitly like below.
> > > 
> > > So,
> > > Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > > 
> > > Thanks,
> > > Gao Xiang  

