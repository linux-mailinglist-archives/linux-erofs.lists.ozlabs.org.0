Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DB145B4CD
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 07:59:48 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HzX1t3qLWz2yX8
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 17:59:46 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HzX1q1S6pz2xrS
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Nov 2021 17:59:42 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2A62068AFE; Wed, 24 Nov 2021 07:59:38 +0100 (CET)
Date: Wed, 24 Nov 2021 07:59:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 25/29] dax: return the partition offset from
 fs_dax_get_by_bdev
Message-ID: <20211124065938.GB7229@lst.de>
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-26-hch@lst.de>
 <CAPcyv4jtWzd3c_S1_4fYA1SXTJZfBzP_1xk_OwYkeNp0UhxwSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jtWzd3c_S1_4fYA1SXTJZfBzP_1xk_OwYkeNp0UhxwSg@mail.gmail.com>
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

On Tue, Nov 23, 2021 at 06:56:29PM -0800, Dan Williams wrote:
> On Tue, Nov 9, 2021 at 12:34 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Prepare from removing the block_device from the DAX I/O path by returning
> 
> s/from removing/for the removal of/

Fixed.

> >         td->dm_dev.bdev = bdev;
> > -       td->dm_dev.dax_dev = fs_dax_get_by_bdev(bdev);
> > +       td->dm_dev.dax_dev = fs_dax_get_by_bdev(bdev, &part_off);
> 
> Perhaps allow NULL as an argument for callers that do not care about
> the start offset?

All callers currently care, dm just has another way to get at the
information.  So for now I'd like to not add the NULL special case,
but we can reconsider that as needed if/when more callers show up.
