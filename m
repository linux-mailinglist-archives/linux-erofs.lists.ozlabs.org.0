Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D6344002F
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Oct 2021 18:17:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hgncs0cP4z3056
	for <lists+linux-erofs@lfdr.de>; Sat, 30 Oct 2021 03:17:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel-com.20210112.gappssmtp.com header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=DDH8LvTf;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=2607:f8b0:4864:20::62e;
 helo=mail-pl1-x62e.google.com; envelope-from=dan.j.williams@intel.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20210112.gappssmtp.com
 header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=DDH8LvTf; dkim-atps=neutral
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hgncn2Mx0z2xDr
 for <linux-erofs@lists.ozlabs.org>; Sat, 30 Oct 2021 03:16:50 +1100 (AEDT)
Received: by mail-pl1-x62e.google.com with SMTP id y1so7134361plk.10
 for <linux-erofs@lists.ozlabs.org>; Fri, 29 Oct 2021 09:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UuiRv/Aqc9KWf66Wmwy2yVHjihLskj+s11srG8q1vD8=;
 b=DDH8LvTf1NbwlDisv+efQao95HUsWm01LKrhjJ2uX5etHAjxnlYc1fVorsh9C2tZeZ
 IZjJyefUE9sV7SNEI3aifqWin72xUpU2BtMndIJi3ywQQBX2XMdIqeYY8510szP8t2sH
 kdBhiAG5maV3WHr8hudaPmgocYD17sC0B0D26/b8Pbwzr3F117FlSlFBx3SQdqHiOhCS
 AzK0mVaRm+n9lGW4xPZYMjIFamXjTmcm5QI7QOVxfQm9omv4teemj/fppXRavbXh1qYb
 2mUwDH8Lkp2dgVW/pz350uqfUJeZ+MOAK0wy10AUYRh1hsJJ2oVH6yHtRzop5uS3RMQt
 86wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UuiRv/Aqc9KWf66Wmwy2yVHjihLskj+s11srG8q1vD8=;
 b=h31gPR2YaLj659U3ysHgZ2wqepSvg+OeNZpeAU11YazBfjAHQkxXhyMCTR0mXc5yhd
 cmFWXi+G7zcCqIuPpbTnKZNT9JEVnbRBB8T2zH9tslAojpSGtWrotlGpMoDPV3bqqBPa
 cgY9z79dHTCLw6SXQ/kyWun8K61iuoHxNoJxHeyG+Nt6+r3PHAOahDyoVEM/Ge6dr5s1
 RYK8l8YzSx1H0UwSfB1Leq4j9Ehz0WfR7e8S2mT2XE3u/FdzJnc0c5U5gl++JdkNXNSh
 xs65tvga53PRpUaW23ht3XK73dPxZGf1COTRBgubkNJQmyG1CRB/XYN7ZjrcKw6FSwsA
 tltg==
X-Gm-Message-State: AOAM5305N/uzuykt9Z6Y5z4hmjHHpUQeK98vHI0bVJ10Q0CAXv2dNngY
 xUeMg6G/GSbrhHOt5iLZy35m/VKYRsMNW3jrYOAYhg==
X-Google-Smtp-Source: ABdhPJy6oDDE8Tua+O/7LJsaoOuN022Twl1T27YRaF2rK5Jgwv2I/UmljReJn3ItDXvNR8dsDNU53ltbLhzG+bw6RwY=
X-Received: by 2002:a17:90b:350f:: with SMTP id
 ls15mr12425415pjb.220.1635524207375; 
 Fri, 29 Oct 2021 09:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211018044054.1779424-1-hch@lst.de>
 <CAPcyv4iEt78-XSsKjTWcpy71zaduXyyigTro6f3fmRqqFOG98Q@mail.gmail.com>
 <20211029105139.1194bb7f@canb.auug.org.au>
 <CAPcyv4g8iEyN5UN1w1xBqQDYSb3HCh7_smsmjt-PiHORRK+X9Q@mail.gmail.com>
 <20211029155524.GE24307@magnolia>
In-Reply-To: <20211029155524.GE24307@magnolia>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 29 Oct 2021 09:16:35 -0700
Message-ID: <CAPcyv4hL7ox5a7L7pBs-uoj_h+9F7E_nBs-qnJKBbJ7PHpWAjw@mail.gmail.com>
Subject: Re: futher decouple DAX from block devices
To: "Darrick J. Wong" <djwong@kernel.org>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Mike Snitzer <snitzer@redhat.com>,
 Linux NVDIMM <nvdimm@lists.linux.dev>, linux-s390 <linux-s390@vger.kernel.org>,
 linux-erofs@lists.ozlabs.org, Shiyang Ruan <ruansy.fnst@fujitsu.com>,
 linux-xfs <linux-xfs@vger.kernel.org>,
 device-mapper development <dm-devel@redhat.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Christoph Hellwig <hch@lst.de>, virtualization@lists.linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Oct 29, 2021 at 8:55 AM Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Fri, Oct 29, 2021 at 08:42:29AM -0700, Dan Williams wrote:
> > On Thu, Oct 28, 2021 at 4:52 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > Hi Dan,
> > >
> > > On Wed, 27 Oct 2021 13:46:31 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
> > > >
> > > > My merge resolution is here [1]. Christoph, please have a look. The
> > > > rebase and the merge result are both passing my test and I'm now going
> > > > to review the individual patches. However, while I do that and collect
> > > > acks from DM and EROFS folks, I want to give Stephen a heads up that
> > > > this is coming. Primarily I want to see if someone sees a better
> > > > strategy to merge this, please let me know, but if not I plan to walk
> > > > Stephen and Linus through the resolution.
> > >
> > > It doesn't look to bad to me (however it is a bit late in the cycle :-(
> > > ).  Once you are happy, just put it in your tree (some of the conflicts
> > > are against the current -rc3 based version of your tree anyway) and I
> > > will cope with it on Monday.
> >
> > Christoph, Darrick, Shiyang,
> >
> > I'm losing my nerve to try to jam this into v5.16 this late in the
> > cycle.
>
> Always a solid choice to hold off for a little more testing and a little
> less anxiety. :)
>
> I don't usually accept new code patches for iomap after rc4 anyway.
>
> > I do want to get dax+reflink squared away as soon as possible,
> > but that looks like something that needs to build on top of a
> > v5.16-rc1 at this point. If Linus does a -rc8 then maybe it would have
> > enough soak time, but otherwise I want to take the time to collect the
> > acks and queue up some more follow-on cleanups to prepare for
> > block-less-dax.
>
> I think that hwpoison-calls-xfs-rmap patchset is a prerequisite for
> dax+reflink anyway, right?  /me had concluded both were 5.17 things.

Ok, cool, sounds like a plan.
