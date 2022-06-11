Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95231547403
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Jun 2022 12:56:22 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LKvs038t2z3bwr
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Jun 2022 20:56:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=InFhqVRk;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::112c; helo=mail-yw1-x112c.google.com; envelope-from=sudipm.mukherjee@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=InFhqVRk;
	dkim-atps=neutral
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LKvrw6TFZz301N
	for <linux-erofs@lists.ozlabs.org>; Sat, 11 Jun 2022 20:56:15 +1000 (AEST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-3137316bb69so12600937b3.10
        for <linux-erofs@lists.ozlabs.org>; Sat, 11 Jun 2022 03:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eqA6H/Kd3v8qLCIvaYprcutQG+OhOEiZYNUR3mtKR8g=;
        b=InFhqVRk/HMI49qxhWCdNY0P1XE0wEpBRC5azFWGcNn7x4HbOqxHc6oFfgHf6xc7ja
         ANUONPNb6l35CdrdMuoFZUtnLBuqDAGpQT+yrn0L+ezkWBq20mM6CxFRdxvZtKpWqlxm
         +JYolldNIWCvjuh+pqbUdoF/r7eMtqzYIATebPuntniMgYiwEgY68cssFw1CO/4kX0G2
         t+JZp25P706XCw63jlQzvshJt6/5Hvyo95tqAvRjnluQP34WC+v4AZlUvg6DjA04SzPH
         N1MoptCK0shoroPvLCx0hKetpvhfX1//r8LuC3fcLYPE/2wrXCtTt/G+j6mhH4DQt/+f
         wNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eqA6H/Kd3v8qLCIvaYprcutQG+OhOEiZYNUR3mtKR8g=;
        b=4XuFxH/RiCmj9XF54An6MtqHSEXmOGfbGH+I/JefolejtRksMLLeJgJUs+1M1LhOb+
         TtupXoWJuV9BnAnMtG0CmXhRntAZCbefHUvK4lwyH0OuY9DrX3mXH2veVmIGEGxzQ73t
         tCHorS8lJxFFEUCpneFyVkUzBdzBX3S+pEm+4DMDWogEdtIsiwnzw5T6ULFYQH2x6LwN
         r4JLb24/viF+MLiv0w6WboBC1Urug819MTpE4+1RQUgxCsycGjEJ0P5txVKToPhfutZR
         gmjvrP+P4tkrO2P6V9D0Hz98YdPKO3kwdB1lbJJ2oLmKCgbsKPKKBiy12N525bOpB0pD
         Qafw==
X-Gm-Message-State: AOAM532d1YPpaxMqoUXXzCjCT9Lnt48pRHvc0fp7lVlpZ1Y4o0Y64QYL
	laq4Yv62s2jMfdCV8FsciWkpKdCLqM53m2N7Dqc=
X-Google-Smtp-Source: ABdhPJzMPaMP2VjmabTBvuNSAp2tyI0KZoHPUC4tMzTy1Au1VZoxjK59G/T3tyeKHoUGM5JYj+tYJXEMmKiGGgUt7c8=
X-Received: by 2002:a81:25cc:0:b0:30f:ea57:af01 with SMTP id
 l195-20020a8125cc000000b0030fea57af01mr51233219ywl.488.1654944971327; Sat, 11
 Jun 2022 03:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <YqRyL2sIqQNDfky2@debian>
In-Reply-To: <YqRyL2sIqQNDfky2@debian>
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sat, 11 Jun 2022 11:55:35 +0100
Message-ID: <CADVatmOKtwSbdGcis4+44-G=UEdHWfOE3M4SBu=25vvp0TWxEA@mail.gmail.com>
Subject: Re: mainline build failure due to 6c77676645ad ("iov_iter: Fix iter_xarray_get_pages{,_alloc}()")
To: David Howells <dhowells@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dominique Martinet <asmadeus@codewreck.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, devel@lists.orangefs.org, Mike Marshall <hubcap@omnibond.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Jun 11, 2022 at 11:45 AM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> Hi All,
>
> The latest mainline kernel branch fails to build for "arm allmodconfig",
> "xtensa allmodconfig" and "csky allmodconfig" with the error:

missed adding "mips allmodconfig".



-- 
Regards
Sudip
