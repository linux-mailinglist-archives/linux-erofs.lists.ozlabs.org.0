Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A23726A3E90
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Feb 2023 10:46:54 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PQFyN3659z3bm9
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Feb 2023 20:46:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=UnalqxKW;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=UnalqxKW;
	dkim-atps=neutral
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PQFyF5JtWz3bNn
	for <linux-erofs@lists.ozlabs.org>; Mon, 27 Feb 2023 20:46:44 +1100 (AEDT)
Received: by mail-pj1-x1035.google.com with SMTP id l1so5500917pjt.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 27 Feb 2023 01:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DiY9acwhUXmm9E/17pYm+aOoOd50FF5ohTkaGe25qyk=;
        b=UnalqxKWf9u923Jm2KHSqj32ehvjUcSk4z/E/mtGassFPdqAfkipPMF7KworlFp21d
         3Miq7QIxvOwx92ShzIZPlcflQvNErfZt2C3G7HYLI4ki4wWB9y+/L+BPH0kztD/WhpRg
         xlsQTVuPgY5kZIGCEJ6z64LqoxwhQsRc+SmHptwqeCScAwKRWUodQkcrm/XMuan/mbjE
         PyEKmsUgM3NaTKAKhubigRse0uqKNI2Rj88SI3Snvuq7TAGKJNxHN8THoPm6c00UP1FB
         9xbIAondQDQMnTBaGQUvWuzWXh9yJxwnUlv4lj6x3gCJZUIvLWGj0cvYLlF8ux+WrARO
         4wPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DiY9acwhUXmm9E/17pYm+aOoOd50FF5ohTkaGe25qyk=;
        b=gzhRPryE9tzW3SX0b3WVuFuUiIrK4MbJPp07DtU1KxNoLjKxF+4LsD5ak8uxgwVVy7
         7mgJ/JOGVlBTIU27Pwa5ON8JYzq/QrqT3RxUZle06xDiwMmDy/oVqNs3gw/fQq63fBtM
         ONuW4yBM6gVgGBYqjCvjjfulhklc6Ut5Hc5ccjJi3jhaDFHVIP2eczjooHPcNymWHnfX
         RxJ72lF5ELphPcQPTDQpS66HfeBTg5PtqIx75EI8n5NX8Xfj2mryjb7wNQDse/CBvCHv
         xse7TTDJfGaLW2mmmCgGmXLbEhtA4PfipoRKnmALN2DhNP146Ck5hpSzD27xnOwv0Zfo
         9Dlw==
X-Gm-Message-State: AO0yUKVRBEaxWjvqc9DGarwL/9gW2OKEPDFxX35GyMh3CUqU+Jizhr6/
	P5YSyFW9yQx0IFb8jN+eZgA=
X-Google-Smtp-Source: AK7set8Qucd/QV4vM3ylivB9m9bm+CndKnl8ChjQUYL9fPiF9cHX1a0Izw4RxqwQfRH6ubpv4B7ukg==
X-Received: by 2002:a17:90b:4a43:b0:233:f365:1d0b with SMTP id lb3-20020a17090b4a4300b00233f3651d0bmr24909814pjb.5.1677491201751;
        Mon, 27 Feb 2023 01:46:41 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id h3-20020a17090a648300b00230ffcb2e24sm5659958pjj.13.2023.02.27.01.46.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Feb 2023 01:46:41 -0800 (PST)
Date: Mon, 27 Feb 2023 17:52:48 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs: don't warn ztailpacking feature anymore
Message-ID: <20230227175248.00001dd9.zbestahu@gmail.com>
In-Reply-To: <4c6ada29-234f-623d-c4c6-1a98a678323b@linux.alibaba.com>
References: <20230227084457.3510-1-zbestahu@gmail.com>
	<4c6ada29-234f-623d-c4c6-1a98a678323b@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org, zhangwen@coolpad.com, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, 27 Feb 2023 17:42:40 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On 2023/2/27 16:44, Yue Hu wrote:
> > From: Yue Hu <huyue2@coolpad.com>
> > 
> > The ztailpacking feature has been merged for a year, it has been mostly
> > stable now.
> > 
> > Signed-off-by: Yue Hu <huyue2@coolpad.com>  
> 
> Let's update erofs-utils as well?

Ok, I will update it later.

> 
> > ---
> >   fs/erofs/super.c | 2 --
> >   1 file changed, 2 deletions(-)
> > 
> > diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> > index 19b1ae79cec4..733c22bcc3eb 100644
> > --- a/fs/erofs/super.c
> > +++ b/fs/erofs/super.c
> > @@ -417,8 +417,6 @@ static int erofs_read_superblock(struct super_block *sb)
> >   	/* handle multiple devices */
> >   	ret = erofs_scan_devices(sb, dsb);
> >   
> > -	if (erofs_sb_has_ztailpacking(sbi))
> > -		erofs_info(sb, "EXPERIMENTAL compressed inline data feature in use. Use at your own risk!");
> >   	if (erofs_is_fscache_mode(sb))
> >   		erofs_info(sb, "EXPERIMENTAL fscache-based on-demand read feature in use. Use at your own risk!");
> >   	if (erofs_sb_has_fragments(sbi))  

