Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E5C6D827B
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Apr 2023 17:48:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ps8DY4SFpz3cjJ
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Apr 2023 01:48:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jOrY6DoC;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+46b8a92f13ae362fdcdf+7164+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jOrY6DoC;
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ps8DS6PKfz3bfk
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Apr 2023 01:48:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0N3bnEoqyxD9JBa9a3Jw/h398bdzAlmE4MCZrbnnAyo=; b=jOrY6DoC95aQn3Vv3VAZND7yl3
	m/hXKJSP8boSFOIai+u31LfUiKZoGUmX/xp4vPr2Sa4RL85kbsf6Lwnp3H3kLpt8V3g8BNHuYEXTQ
	wONj00nh8D1I8/iYMjQUF7yh8yBKD0gu19Rxi60u40GbOrJPRmpaFoCyRyO3aOYxAxoOytrqPRQb5
	99dNgh/6QHoQwvKeFp1L8sZLbahEtSmp0Wr0v0/2ug5W9kpxw2A9YkmVeQcxYuvP2zMfKAaisAzse
	ZbSboN0UYogpn15gaXKO0zCWpYuCPGAvWfMqKwR/k38KllD4rrVbRB9+Aidw4KtsBb8XxeGSYDpv4
	m6odhUjA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1pk5Mv-004zVF-1j;
	Wed, 05 Apr 2023 15:48:17 +0000
Date: Wed, 5 Apr 2023 08:48:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v2 09/23] iomap: allow filesystem to implement read path
 verification
Message-ID: <ZC2YQalRTGxzmNDK@infradead.org>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-10-aalbersh@redhat.com>
 <ZCxEHkWayQyGqnxL@infradead.org>
 <20230405110116.ia5wv3qxbnpdciui@aalbersh.remote.csb>
 <20230405150627.GC303486@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405150627.GC303486@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: fsverity@lists.linux.dev, jth@kernel.org, agruenba@redhat.com, linux-ext4@vger.kernel.org, Andrey Albershteyn <aalbersh@redhat.com>, linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>, cluster-devel@redhat.com, dchinner@redhat.com, rpeterso@redhat.com, damien.lemoal@opensource.wdc.com, linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Apr 05, 2023 at 08:06:27AM -0700, Darrick J. Wong wrote:
> > > I wonder if that also makes sense and keep all the deferral in the
> > > file system.  We'll need that for the btrfs iomap conversion anyway,
> > > and it seems more flexible.  The ioend processing would then move into
> > > XFS.
> > > 
> > 
> > Not sure what you mean here.
> 
> I /think/ Christoph is talking about allowing callers of iomap pagecache
> operations to supply a custom submit_bio function and a bio_set so that
> filesystems can add in their own post-IO processing and appropriately
> sized (read: minimum you can get away with) bios.  I imagine btrfs has
> quite a lot of (read) ioend processing they need to do, as will xfs now
> that you're adding fsverity.

Exactly.

> I think the point is that this is a general "check what we just read"
> hook, so it could be in readpage_ops since we're never going to need to
> re-validate verity contents, right?  Hence it could be in readpage_ops
> instead of the general iomap_folio_ops.
> 
> <shrug> Is there a use case for ->verify_folio that isn't a read post-
> processing step?

Yes.  In fact I wonder if the verification might actually be done
in the per-bio end_io handler in the file system.  But I'll need
to find some more time to read through the XFS parts of series to
come up with a more intelligent suggestion on that.
