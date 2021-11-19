Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C9545755E
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Nov 2021 18:21:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hwk3j6VSnz3bWX
	for <lists+linux-erofs@lfdr.de>; Sat, 20 Nov 2021 04:21:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel-com.20210112.gappssmtp.com header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=FQ6M7eMM;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=2607:f8b0:4864:20::632;
 helo=mail-pl1-x632.google.com; envelope-from=dan.j.williams@intel.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20210112.gappssmtp.com
 header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=FQ6M7eMM; dkim-atps=neutral
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hwk3Y5fZbz2ywV
 for <linux-erofs@lists.ozlabs.org>; Sat, 20 Nov 2021 04:21:21 +1100 (AEDT)
Received: by mail-pl1-x632.google.com with SMTP id k4so8603210plx.8
 for <linux-erofs@lists.ozlabs.org>; Fri, 19 Nov 2021 09:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2U/4HYKnAZR7qNMIeDCg5S//595luEluzFk14uv4gBU=;
 b=FQ6M7eMMvPf80QsdTpoBZi0VrX8bn7QeX7OvbRABdgkNvCMNjXzl7/FKjSfSUjRkzX
 F1usfPnFQYNtajLRg0QRwSSgzt8mzXj0XCG2cnk0+F0m/6Zhw3KmrGwYuAHqWjDxU8h7
 LoqDBYl4kQUeXb8kAZzT8ViJ+hkv5vLV1Goy6Yaluym7CVIoftX3Jldatma/nAYXl27p
 pclrbJHG5C0Blu/232w4rLGJUG53x/PsyFdu4/UMHnSQZ8XMlr5FFqwE0la2E0Wy9pBi
 QLaClBcQjJDmbuAEv+kCOvcY8AEg2J0pE5d377NWsFamWj8v0zJjbYMN2j8PjhK8WH2h
 Pe+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2U/4HYKnAZR7qNMIeDCg5S//595luEluzFk14uv4gBU=;
 b=d2Nyh8bnOyM6Ggq83RPPn1nUExJhXKSs/BhSVonhS80q/ZqaW9WZEPyQLO7ygU9Nic
 pr9vZCKTuJcz8DCZ5c6PEFu+rnF9Tbuo5DYpRwZcPBwPRTFjPoAT+XmtxgV1BYSA+vx2
 koTVGbIVxE8CBmPlOMiaLIXDyC8E6Kb5S6iHPN2RoelBOJ2KhBr5x1wy86R6L5UHf1on
 0anTBclxPJwkO9A6lRULCH7/W/Qr/o1wXvq2pnqaIogo8qjbYzBudcq3bwJLLbwPz06X
 XupstiNIGKw0OX32avLgCV5KHDoBQONGHXtRXfQTJoipqBf3UrK4jdRb/GAKeZ0Ji/sN
 2QGA==
X-Gm-Message-State: AOAM530M8gWfxFD9xC4B6cVlJj0KVNCn7pE2NFx/ylb8vlIct2aMdw5d
 v8FOvK3x0BsOnB7MCQTpR74jtEO1gROna8cuZ/5vYw==
X-Google-Smtp-Source: ABdhPJxOTsb7kpZ1mbQBZyHvrw/GjkoPNdlC1Mnmi7QTa5v33P77eZ447VYbGdz8Hsj3aBiYzZhGTejFWOktm98P3BA=
X-Received: by 2002:a17:90b:1e49:: with SMTP id
 pi9mr1505670pjb.220.1637342480174; 
 Fri, 19 Nov 2021 09:21:20 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-2-hch@lst.de>
 <CAPcyv4ijKTcABMs2tZEuPWo1WDOux+4XWN=DNF5v8SrQRSbfDg@mail.gmail.com>
 <20211119065645.GB15524@lst.de>
In-Reply-To: <20211119065645.GB15524@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 19 Nov 2021 09:21:09 -0800
Message-ID: <CAPcyv4iFG0n-vdaEi4h5ken6mPrgW6Kz6UXCTRfaHi-c99GBnw@mail.gmail.com>
Subject: Re: [PATCH 01/29] nvdimm/pmem: move dax_attribute_group from dax to
 pmem
To: Christoph Hellwig <hch@lst.de>
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

On Thu, Nov 18, 2021 at 10:56 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Nov 17, 2021 at 09:44:25AM -0800, Dan Williams wrote:
> > On Tue, Nov 9, 2021 at 12:33 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > dax_attribute_group is only used by the pmem driver, and can avoid the
> > > completely pointless lookup by the disk name if moved there.  This
> > > leaves just a single caller of dax_get_by_host, so move dax_get_by_host
> > > into the same ifdef block as that caller.
> > >
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > > Link: https://lore.kernel.org/r/20210922173431.2454024-3-hch@lst.de
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >
> > This one already made v5.16-rc1.
>
> Yes, but 5.16-rc1 did not exist yet when I pointed the series.
>
> Note that the series also has a conflict against 5.16-rc1 in pmem.c,
> and buildbot pointed out the file systems need explicit dax.h
> includes in a few files for some configurations.
>
> The current branch is here, I just did not bother to repost without
> any comments:
>
>    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dax-block-cleanup
>
> no functional changes.

Do you just want to send me a pull request after you add all the acks?
