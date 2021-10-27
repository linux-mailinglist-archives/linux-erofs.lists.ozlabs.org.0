Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE26F43D7A3
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Oct 2021 01:37:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HflV22gdZz2xX4
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Oct 2021 10:37:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel-com.20210112.gappssmtp.com header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=6OnySiys;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=2607:f8b0:4864:20::42b;
 helo=mail-pf1-x42b.google.com; envelope-from=dan.j.williams@intel.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20210112.gappssmtp.com
 header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=6OnySiys; dkim-atps=neutral
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HflTy2sjVz2x9P
 for <linux-erofs@lists.ozlabs.org>; Thu, 28 Oct 2021 10:37:16 +1100 (AEDT)
Received: by mail-pf1-x42b.google.com with SMTP id b1so684761pfm.6
 for <linux-erofs@lists.ozlabs.org>; Wed, 27 Oct 2021 16:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WMTMh4JidQFbMhcZT2VkZGNAi1C8CcA8jtm6BrftSss=;
 b=6OnySiysF1hhuv+2jxJ9FfAfSmA8y9LXelAKat7WynBZQg+6PZ/Y6CL3zM18cMG3JD
 GEnUquiuE3quJvpTuotuNPBGhT162UmD7avG0jDOAcziSvLYUVDywCngB4p3fQ58ZM0M
 zEqOMtq2uc82z3Hyo8SHcJ4wrgy4SICUQMJg3EUzEQ97cTDTxpAJL+ZjXMrC9Pd6Yd4I
 Hv+o6S8B5+bjhFZmSyXmvoK3vkD+a/tR7V2R1bzY3az6V1C7tt1S3O/yFi5MScIMNOJo
 whD2gxewZ5pTPcAORmeXbNAMaeToO/lIBwIX5Bv5eefUsLjTlEzVx3onl1Zq5iL+vzm0
 cGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WMTMh4JidQFbMhcZT2VkZGNAi1C8CcA8jtm6BrftSss=;
 b=oyqXCVSBxwXlC6YtMnnaKxKD0KJiljQ4k20d6yK7YEo3ImiN6GywSnxCym+sP1BVeU
 6sGKejeh4SrvhY6zGngTI4OEozV48p4R943qIAh0QsIPzIg5N0J2F+EmDTJ9hRz6bX0t
 Su263Qh1DUVvqk8qfhQln0E3GXhNJcBsNsUsjC1AzGTXLwLgUfxCTx0PDVzuhA8ewRYG
 2iER7cJ2N4vHcPs791esEL1llBkBN+EaQbXoZWQJ4gHLhuZXLzNpK/3ijkxkliKyeN4U
 0QCieKjjcm3OtwFBv9awJcfwhFGcI8FNzE/Mmbub10x/aqvFdzxd04BoQu74z2xrExuI
 Ljvg==
X-Gm-Message-State: AOAM530uBgpwdE3tXXpogBivdFpBNMRHjqZr4ZxwepWeADggm4vXFW7Y
 6mWn678D6fKCaZNVZXWovXIy0NGfA4kbhItYEwWcRg==
X-Google-Smtp-Source: ABdhPJxcsU50q4uGsTOaoj9w67NPN0ee0O0WC5tw2bEynUFc2bhlW22w0QMQKH9wvcSAfLnnolzJDk1LCiKsNt9RVYY=
X-Received: by 2002:a63:1e0e:: with SMTP id e14mr608862pge.5.1635377832818;
 Wed, 27 Oct 2021 16:37:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211018044054.1779424-1-hch@lst.de>
 <20211018044054.1779424-7-hch@lst.de>
 <20211018164351.GT24307@magnolia> <20211019072326.GA23171@lst.de>
In-Reply-To: <20211019072326.GA23171@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 27 Oct 2021 16:37:01 -0700
Message-ID: <CAPcyv4hbLur8rN40zaqmBw7VH37FoPAzvj-U_NT7Lk2-v5JhSQ@mail.gmail.com>
Subject: Re: [PATCH 06/11] xfs: factor out a xfs_setup_dax helper
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
 linux-s390 <linux-s390@vger.kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
 linux-erofs@lists.ozlabs.org, virtualization@lists.linux-foundation.org,
 linux-xfs <linux-xfs@vger.kernel.org>,
 device-mapper development <dm-devel@redhat.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Oct 19, 2021 at 12:24 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Oct 18, 2021 at 09:43:51AM -0700, Darrick J. Wong wrote:
> > > --- a/fs/xfs/xfs_super.c
> > > +++ b/fs/xfs/xfs_super.c
> > > @@ -339,6 +339,32 @@ xfs_buftarg_is_dax(
> > >                     bdev_nr_sectors(bt->bt_bdev));
> > >  }
> > >
> > > +static int
> > > +xfs_setup_dax(
> >
> > /me wonders if this should be named xfs_setup_dax_always, since this
> > doesn't handle the dax=inode mode?
>
> Sure, why not.

I went ahead and made that change locally.

>
> > The only reason I bring that up is that Eric reminded me a while ago
> > that we don't actually print any kind of EXPERIMENTAL warning for the
> > auto-detection behavior.
>
> Yes, I actually noticed that as well when preparing this series.

The rest looks good to me.
