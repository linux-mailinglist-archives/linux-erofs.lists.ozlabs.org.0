Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDF3A13202
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jan 2025 05:38:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YYVVF2TSPz3bjs
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jan 2025 15:38:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737002292;
	cv=none; b=eCcDwyDW1mAGMBgYmOlqqrKaZwlu98N499bw8suH3WjR8OitIOu43eSq1SbXYBLA8MlyG3k26B1WQUstnDXUtlbHR+/E156WDLME24KCPS0CnLMwUdcqrouOt6yvg5eMZdfYSzscFTqrgFJYHw8Fy4ZkXoOSUlMXfDhh4Sd0R/p8WiHQPf4FrESv2MMDwXKO2dqZGsSs4bmDNtv29kIolP7CSF2Ok9PjitxPrH5HE/414m0kzLnzSxYHk1nhUFfbTtTSePqnGPHoY9UZIGrbhtYTK+uHH8w5ZhHZwmK5dPsusqJVM4pLyXPRHPHOk19PNeYSFhC2+YWKb07+g/q0zA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737002292; c=relaxed/relaxed;
	bh=BxxLZyVGfwUCs7QH9CsLkxUlKMUJGJTwPFgv4+7Ikt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyMEzhNwF7khr5j+IgQcq0FHjH+7fGSJmVjP063xLl22GaovhXPddPVIaFrjjSDmZ6X15rqQgeNFcrQ9yPkq2iMfRak09vsij+hZmbsfrKuIMK0NyFqZO+12rIxIzuCH1pYzBHlE7LzYcpod84G10ibd7j6QRZETl+6iNk3ijYJRGoSqXiXuwZ+0a7Bf7jbp5DK1BmzywAwV1169xlElw0JMKkhdad0M9b7QoaI6wuiEAew3Ci9S0k6IHQBXz8o3C9bcV8PhgPLkGs3m6ZnJhDZxBKFvdAzV++CMqeYJtZeGb4u4R/v3iC87VC+ZkJoAF7OX54K4gk//ayR/rr/Okw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 333 seconds by postgrey-1.37 at boromir; Thu, 16 Jan 2025 15:38:09 AEDT
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YYVV91wZqz2yhR
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 Jan 2025 15:38:09 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 050CA68BEB; Thu, 16 Jan 2025 05:32:27 +0100 (CET)
Date: Thu, 16 Jan 2025 05:32:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [PATCH 8/8] gfs2: use lockref_init for qd_lockref
Message-ID: <20250116043226.GA23137@lst.de>
References: <20250115094702.504610-1-hch@lst.de> <20250115094702.504610-9-hch@lst.de> <CAHc6FU58eBO0i8er5+gK--eAMVHULCzHPnJ9H5oN12fr=AAnbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU58eBO0i8er5+gK--eAMVHULCzHPnJ9H5oN12fr=AAnbg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, gfs2@lists.linux.dev, Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Jan 15, 2025 at 02:35:03PM +0100, Andreas Gruenbacher wrote:
> > +++ b/fs/gfs2/quota.c
> > @@ -236,8 +236,7 @@ static struct gfs2_quota_data *qd_alloc(unsigned hash, struct gfs2_sbd *sdp, str
> >                 return NULL;
> >
> >         qd->qd_sbd = sdp;
> > -       qd->qd_lockref.count = 0;
> > -       spin_lock_init(&qd->qd_lockref.lock);
> > +       lockref_init(&qd->qd_lockref, 0);
> 
> Hmm, initializing count to 0 seems to be the odd case and it's fairly
> simple to change gfs2 to work with an initial value of 1. I wonder if
> lockref_init() should really have a count argument.

Well, if you can fix it to start with 1 we could start out with 1
as the default.  FYI, I also didn't touch the other gfs2 lockref
because it initialize the lock in the slab init_once callback and
the count on every initialization.

