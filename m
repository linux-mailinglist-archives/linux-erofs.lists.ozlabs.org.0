Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE8A456A84
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Nov 2021 07:56:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HwSBt08fMz304w
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Nov 2021 17:56:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HwSBp5t3Bz2xYG
 for <linux-erofs@lists.ozlabs.org>; Fri, 19 Nov 2021 17:56:50 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
 id F18E168AFE; Fri, 19 Nov 2021 07:56:45 +0100 (CET)
Date: Fri, 19 Nov 2021 07:56:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 01/29] nvdimm/pmem: move dax_attribute_group from dax
 to pmem
Message-ID: <20211119065645.GB15524@lst.de>
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-2-hch@lst.de>
 <CAPcyv4ijKTcABMs2tZEuPWo1WDOux+4XWN=DNF5v8SrQRSbfDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4ijKTcABMs2tZEuPWo1WDOux+4XWN=DNF5v8SrQRSbfDg@mail.gmail.com>
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

On Wed, Nov 17, 2021 at 09:44:25AM -0800, Dan Williams wrote:
> On Tue, Nov 9, 2021 at 12:33 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > dax_attribute_group is only used by the pmem driver, and can avoid the
> > completely pointless lookup by the disk name if moved there.  This
> > leaves just a single caller of dax_get_by_host, so move dax_get_by_host
> > into the same ifdef block as that caller.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > Link: https://lore.kernel.org/r/20210922173431.2454024-3-hch@lst.de
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> This one already made v5.16-rc1.

Yes, but 5.16-rc1 did not exist yet when I pointed the series.

Note that the series also has a conflict against 5.16-rc1 in pmem.c,
and buildbot pointed out the file systems need explicit dax.h
includes in a few files for some configurations.

The current branch is here, I just did not bother to repost without
any comments:

   http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dax-block-cleanup

no functional changes.
