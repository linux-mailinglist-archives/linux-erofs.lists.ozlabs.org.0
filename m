Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E532443FFE6
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Oct 2021 17:55:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hgn8267bcz3054
	for <lists+linux-erofs@lfdr.de>; Sat, 30 Oct 2021 02:55:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VNGR/oT5;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=djwong@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=VNGR/oT5; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hgn7z4th4z2yKN
 for <linux-erofs@lists.ozlabs.org>; Sat, 30 Oct 2021 02:55:27 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4AB5F60FC4;
 Fri, 29 Oct 2021 15:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635522925;
 bh=/k26Brg4+jtEQ3L7YzlxV5wwLsjmiyhBtI1Xv0qe4jM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VNGR/oT5nGHHvMugzkATBbYvd9F6fQA09UpjqWqVPxKBtrRkcFw10uYcU96r4Y5e9
 BaNLU2TAu5G25fISB6pXK1/JZX+S4dr/HMvRmPUH8Edr/t1LiljcPus0OjDWw7ypW0
 4EPLVRfxgon+ImToi17MZEqzKb5Gh5cbLmWGIGdu44rLX++iOPCkcVZzYN1iNPUdhu
 ig+H9p46kun6H4yKSgjvS5hza9PP1p3D/4d0Z6Z7UeMhh3RdseFcOspVpYbIXEaaVD
 z3vlYv7WtW9WWwh+XaOu1OGv6Th/km6Qop9MOz3Oco0bjW7QLca7ef5pWDU57NAWBq
 P70mxqn/wKgSA==
Date: Fri, 29 Oct 2021 08:55:24 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: futher decouple DAX from block devices
Message-ID: <20211029155524.GE24307@magnolia>
References: <20211018044054.1779424-1-hch@lst.de>
 <CAPcyv4iEt78-XSsKjTWcpy71zaduXyyigTro6f3fmRqqFOG98Q@mail.gmail.com>
 <20211029105139.1194bb7f@canb.auug.org.au>
 <CAPcyv4g8iEyN5UN1w1xBqQDYSb3HCh7_smsmjt-PiHORRK+X9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4g8iEyN5UN1w1xBqQDYSb3HCh7_smsmjt-PiHORRK+X9Q@mail.gmail.com>
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

On Fri, Oct 29, 2021 at 08:42:29AM -0700, Dan Williams wrote:
> On Thu, Oct 28, 2021 at 4:52 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi Dan,
> >
> > On Wed, 27 Oct 2021 13:46:31 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > My merge resolution is here [1]. Christoph, please have a look. The
> > > rebase and the merge result are both passing my test and I'm now going
> > > to review the individual patches. However, while I do that and collect
> > > acks from DM and EROFS folks, I want to give Stephen a heads up that
> > > this is coming. Primarily I want to see if someone sees a better
> > > strategy to merge this, please let me know, but if not I plan to walk
> > > Stephen and Linus through the resolution.
> >
> > It doesn't look to bad to me (however it is a bit late in the cycle :-(
> > ).  Once you are happy, just put it in your tree (some of the conflicts
> > are against the current -rc3 based version of your tree anyway) and I
> > will cope with it on Monday.
> 
> Christoph, Darrick, Shiyang,
> 
> I'm losing my nerve to try to jam this into v5.16 this late in the
> cycle.

Always a solid choice to hold off for a little more testing and a little
less anxiety. :)

I don't usually accept new code patches for iomap after rc4 anyway.

> I do want to get dax+reflink squared away as soon as possible,
> but that looks like something that needs to build on top of a
> v5.16-rc1 at this point. If Linus does a -rc8 then maybe it would have
> enough soak time, but otherwise I want to take the time to collect the
> acks and queue up some more follow-on cleanups to prepare for
> block-less-dax.

I think that hwpoison-calls-xfs-rmap patchset is a prerequisite for
dax+reflink anyway, right?  /me had concluded both were 5.17 things.

--D
