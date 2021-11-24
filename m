Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8224045B458
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 07:36:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HzWVs2qYBz2yS3
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 17:36:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HzWVk3vsDz2xsv
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Nov 2021 17:36:12 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
 id C659668AFE; Wed, 24 Nov 2021 07:36:05 +0100 (CET)
Date: Wed, 24 Nov 2021 07:36:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH 06/29] dax: move the partition alignment check into
 fs_dax_get_by_bdev
Message-ID: <20211124063605.GA6889@lst.de>
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-7-hch@lst.de> <20211123222555.GE266024@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123222555.GE266024@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
 virtualization@lists.linux-foundation.org, linux-xfs@vger.kernel.org,
 dm-devel@redhat.com, linux-fsdevel@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, linux-ext4@vger.kernel.org,
 Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Nov 23, 2021 at 02:25:55PM -0800, Darrick J. Wong wrote:
> > +	if ((get_start_sect(bdev) * SECTOR_SIZE) % PAGE_SIZE ||
> > +	    (bdev_nr_sectors(bdev) * SECTOR_SIZE) % PAGE_SIZE) {
> 
> Do we have to be careful about 64-bit division here, or do we not
> support DAX on 32-bit?

I can't find anything in the Kconfig limiting DAX to 32-bit.  But
then again the existing code has divisions like this, so the compiler
is probably smart enough to turn them into shifts.

> > +		pr_info("%pg: error: unaligned partition for dax\n", bdev);
> 
> I also wonder if this should be ratelimited...?

This happens once (or maybe three times for XFS with rt and log devices)
at mount time, so I see no need for a ratelimit.
