Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F2345B26C
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 04:05:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HzQqS6Lkmz2ypY
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 14:05:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NRaLXp2D;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=djwong@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=NRaLXp2D; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HzQqM4Fc7z2yPT
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Nov 2021 14:05:19 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3682660F55;
 Wed, 24 Nov 2021 03:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637723116;
 bh=8E5AHzN+aCpIUyy/IKItQsgBCFz9QjxdNsnf6Wc8sLI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NRaLXp2DQNpRDi5NBlLIrHYp1YQ84fyWovscy9PbvHAt/ymlk5DiV6yDdEv5cQWZr
 jLpg2wIKqTZyI1ywqwak+JmUmQSdDiGbC/0EDBVNmzr8LgDHb5y1ocPXF2R6jYxhnN
 GN5ZvGVK69U1jII2tRqWVd7zBvVEF9NGxPhMG0So+jx7Z6OnHCYoRXokbFrI/Qp6wI
 kbYSpUTNH7LbVZaurhYL8mcXBu98rgITDU24/fEvl1Doo9kGD/X0YwHhmZrb9tueYZ
 d/7VoK/rTTLlDbMhSGJNN93DH71+f/oSLnH2gBKrosvzkrffMmGkKX9KhJ/nEPm2kt
 Y0OPUm6XnKtFg==
Date: Tue, 23 Nov 2021 19:05:15 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 21/29] xfs: move dax device handling into
 xfs_{alloc,free}_buftarg
Message-ID: <20211124030515.GC266024@magnolia>
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-22-hch@lst.de>
 <CAPcyv4hY4g82PrjMPO=1kiM5sL=3=yR66r6LeG8RS3Ha2k1eUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hY4g82PrjMPO=1kiM5sL=3=yR66r6LeG8RS3Ha2k1eUw@mail.gmail.com>
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
 linux-ext4 <linux-ext4@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Nov 23, 2021 at 06:40:47PM -0800, Dan Williams wrote:
> On Tue, Nov 9, 2021 at 12:34 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Hide the DAX device lookup from the xfs_super.c code.
> >
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> That's an interesting spelling of "Signed-off-by", but patch looks
> good to me too. I would have expected a robot to complain about
> missing sign-off?

Nah, they only like to do that /after/ you've pushed a branch to
kernel.org and emailed the lists about it. ;)

--D

> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
