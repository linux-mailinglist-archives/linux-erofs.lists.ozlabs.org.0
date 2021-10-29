Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEEC43FFC5
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Oct 2021 17:42:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HgmsX5DX6z2yxx
	for <lists+linux-erofs@lfdr.de>; Sat, 30 Oct 2021 02:42:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel-com.20210112.gappssmtp.com header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=6wmVMWLA;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=2607:f8b0:4864:20::532;
 helo=mail-pg1-x532.google.com; envelope-from=dan.j.williams@intel.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20210112.gappssmtp.com
 header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=6wmVMWLA; dkim-atps=neutral
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HgmsS0dJWz2xBm
 for <linux-erofs@lists.ozlabs.org>; Sat, 30 Oct 2021 02:42:44 +1100 (AEDT)
Received: by mail-pg1-x532.google.com with SMTP id s136so10258673pgs.4
 for <linux-erofs@lists.ozlabs.org>; Fri, 29 Oct 2021 08:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kkrK8/+uwUhU1+ibCc9sihgvRMe3oeCDEJlEEAsQMNY=;
 b=6wmVMWLAKN8exE8XR8wv/iFYhudFZm/xaEJpNEZmOxWSzGBAVEn+M6ckTQFipGdRJT
 yb6PYTTcKIVqTXGsV3bkPy2TCiq4+HLgRy2cRXBAvM33znfROc4XjMNFzIfr4UE69rdj
 4eISFf7aFEyAHo2Sf/MANtuSqjdRnwdAyb7h0RnbdOmg2MrJVd+mPCxh87qxZR21UV1T
 Jo7MDmjd0zsp2/1yCw8PZ5/EZTwQNFNoOJVWhez881Nf3OlrTKHfCKrLAxk43DLXDdPH
 n00SPDakiTsjm+voDnH7pSuvR7gHcdocX6KbBQemE5xaUaALVKmTKfT7gJVRpb96WLOa
 Bfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kkrK8/+uwUhU1+ibCc9sihgvRMe3oeCDEJlEEAsQMNY=;
 b=RuPZPI7HzaTLmweBAcj6LUPdqslWfLIDduZ1Ti+Ke/getzm4OwOyWl53IhpQ/dFvNp
 b52aAblEbCcNeiJiA+Ac8ERgqjC/jaFxaRwdnWF8midJN5Lt0G/a90tBvCZfC+Dn9yTP
 R/2EP86xRqt8CHENR45SiEWLpVojDXWpWBTCm+D1sV9rzDkQbxmo+r1cGNQD4YuGjNMf
 TRqVmNV2PSrEk//xAScBjf+Ppyr/P5oi6PDAVJLQDotnKzj/0XQ9X6KaOrFOXO3C8kWU
 ciksf3BqpXcRZeNSoD45yxVs+VQGjf/TgC4HTKlKaKXUjyPc5wB6KrlMOvLqKzxn8nXJ
 lFAg==
X-Gm-Message-State: AOAM531BoGWBNR+9tRg/cUOczbHGpzmquvdm19cmzSq60fptLOn0YTvY
 mkJbYI4wNtYqP3Oh0OdeWVL1jMgWJx4klTqC522ibg==
X-Google-Smtp-Source: ABdhPJwscYMJBcsf4QuT7rFuYsL/BYYBLAhJeu/07ZB2t6F9Qexmb3kIziq0UAiLr3A7UbGhuhxXArjTEfzlR4kAptU=
X-Received: by 2002:a05:6a00:140e:b0:444:b077:51ef with SMTP id
 l14-20020a056a00140e00b00444b07751efmr11616698pfu.61.1635522160977; Fri, 29
 Oct 2021 08:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <20211018044054.1779424-1-hch@lst.de>
 <CAPcyv4iEt78-XSsKjTWcpy71zaduXyyigTro6f3fmRqqFOG98Q@mail.gmail.com>
 <20211029105139.1194bb7f@canb.auug.org.au>
In-Reply-To: <20211029105139.1194bb7f@canb.auug.org.au>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 29 Oct 2021 08:42:29 -0700
Message-ID: <CAPcyv4g8iEyN5UN1w1xBqQDYSb3HCh7_smsmjt-PiHORRK+X9Q@mail.gmail.com>
Subject: Re: futher decouple DAX from block devices
To: Stephen Rothwell <sfr@canb.auug.org.au>, Christoph Hellwig <hch@lst.de>, 
 "Darrick J. Wong" <djwong@kernel.org>,
 Shiyang Ruan <ruansy.fnst@fujitsu.com>
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
Cc: Linux NVDIMM <nvdimm@lists.linux.dev>, Mike Snitzer <snitzer@redhat.com>,
 linux-s390 <linux-s390@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org,
 linux-xfs <linux-xfs@vger.kernel.org>,
 device-mapper development <dm-devel@redhat.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Oct 28, 2021 at 4:52 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Dan,
>
> On Wed, 27 Oct 2021 13:46:31 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > My merge resolution is here [1]. Christoph, please have a look. The
> > rebase and the merge result are both passing my test and I'm now going
> > to review the individual patches. However, while I do that and collect
> > acks from DM and EROFS folks, I want to give Stephen a heads up that
> > this is coming. Primarily I want to see if someone sees a better
> > strategy to merge this, please let me know, but if not I plan to walk
> > Stephen and Linus through the resolution.
>
> It doesn't look to bad to me (however it is a bit late in the cycle :-(
> ).  Once you are happy, just put it in your tree (some of the conflicts
> are against the current -rc3 based version of your tree anyway) and I
> will cope with it on Monday.

Christoph, Darrick, Shiyang,

I'm losing my nerve to try to jam this into v5.16 this late in the
cycle. I do want to get dax+reflink squared away as soon as possible,
but that looks like something that needs to build on top of a
v5.16-rc1 at this point. If Linus does a -rc8 then maybe it would have
enough soak time, but otherwise I want to take the time to collect the
acks and queue up some more follow-on cleanups to prepare for
block-less-dax.
