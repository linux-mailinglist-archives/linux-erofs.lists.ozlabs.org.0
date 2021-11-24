Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C3F45B51B
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 08:14:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HzXM14GgGz2yQw
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 18:14:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HzXLz4rRSz2xKJ
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Nov 2021 18:14:35 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8727968AFE; Wed, 24 Nov 2021 08:14:30 +0100 (CET)
Date: Wed, 24 Nov 2021 08:14:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH 23/29] xfs: use IOMAP_DAX to check for DAX mappings
Message-ID: <20211124071430.GD7229@lst.de>
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-24-hch@lst.de> <20211123230124.GR266024@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123230124.GR266024@magnolia>
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

On Tue, Nov 23, 2021 at 03:01:24PM -0800, Darrick J. Wong wrote:
> On Tue, Nov 09, 2021 at 09:33:03AM +0100, Christoph Hellwig wrote:
> > Use the explicit DAX flag instead of checking the inode flag in the
> > iomap code.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Any particular reason to pass this in as a flag vs. querying the inode?

Same reason as the addition of IOMAP_DAX.  But I think I'll redo this
a bit to do the XFS paramater passing first and then actually check
IOMAP_DAX together with introducing it to make it all a little more clear.
