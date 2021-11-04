Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AF86B445871
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Nov 2021 18:34:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HlW3N4P7Mz2yHS
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Nov 2021 04:34:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JxlU4yVv;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=djwong@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=JxlU4yVv; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HlW3K1ytHz2xCN
 for <linux-erofs@lists.ozlabs.org>; Fri,  5 Nov 2021 04:34:21 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id C09B961168;
 Thu,  4 Nov 2021 17:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636047257;
 bh=AR8NcrNj5hyA3HWt9nLXt5h1bS993/cghgbNSGVz0kI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JxlU4yVvWXPKAVgMlcKtQCmxXE/TikimATxyIFd8unO637JRzA9xVEGorhtbue1Al
 eAjNGYaYn/WxnzE1oojAaGA4jsOHFJledlnSyk5GXBYjtaYzo6Vrc7SNp5YLO8KXm5
 GnXLyjMFRczpgqpxzikwuszii7B+smdLRFlqr6ePyrQtkdaWhWxNadYJyLsd2jgbpP
 Rc+pttEDLYdgyZbTpx0NqCCj/YwPUR6PiF/crWlSmxacWLyoEpUGMiWV6we2w37+Rm
 T+p9bgJyo3VrNLtooKl07eXMQfg5tpv2X7xvy3irecWZ0ZYekQFGKTDVcUnLqQe3vh
 uWg8NUeRjeEXg==
Date: Thu, 4 Nov 2021 10:34:17 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: futher decouple DAX from block devices
Message-ID: <20211104173417.GJ2237511@magnolia>
References: <20211018044054.1779424-1-hch@lst.de>
 <21ff4333-e567-2819-3ae0-6a2e83ec7ce6@sandeen.net>
 <20211104081740.GA23111@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104081740.GA23111@lst.de>
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
Cc: nvdimm@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-s390@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 Eric Sandeen <sandeen@sandeen.net>, virtualization@lists.linux-foundation.org,
 linux-xfs@vger.kernel.org, dm-devel@redhat.com, linux-fsdevel@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, linux-ext4@vger.kernel.org,
 Ira Weiny <ira.weiny@intel.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Nov 04, 2021 at 09:17:40AM +0100, Christoph Hellwig wrote:
> On Wed, Nov 03, 2021 at 12:59:31PM -0500, Eric Sandeen wrote:
> > Christoph, can I ask what the end game looks like, here? If dax is completely
> > decoupled from block devices, are there user-visible changes?
> 
> Yes.
> 
> > If I want to
> > run fs-dax on a pmem device - what do I point mkfs at, if not a block device?
> 
> The rough plan is to use the device dax character devices.  I'll hopefully
> have a draft version in the next days.

/me wonders, are block devices going away?  Will mkfs.xfs have to learn
how to talk to certain chardevs?  I guess jffs2 and others already do
that kind of thing... but I suppose I can wait for the real draft to
show up to ramble further. ;)

--D
