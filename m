Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08746DF5B6
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Apr 2023 14:42:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PxMmY4h5gz3cfJ
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Apr 2023 22:42:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0NE81cyr;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+76e3400107323edf7514+7171+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0NE81cyr;
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PxMmP73rzz3c7S
	for <linux-erofs@lists.ozlabs.org>; Wed, 12 Apr 2023 22:42:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ddg0vAHFen4K0AUyZN8TD9RJ8e2AKTjO8ch3srJurzE=; b=0NE81cyrNaY13C8K9Ohz51hMMT
	H8xLDlox7rtYU3JMpi/o1SAdWWlvObLHFQJfTqJCbAGM9dcW5OL8gHOZ2ZyXZ5JEpZ35YBRQ/SJDw
	Awg6JdUVWLxnk5KF/M2Zl8rnE5rVIWXzbsN5geWGxL03pJgn+yPqrtFK/f1rScaWvqKNiob9Q1uq4
	zwBzDQd4VSvi9A91DWhyreN5V2CWY4ROZWwPn6JruDwiEvPhDvD3Tdms4YsiY3X3AIsTMbXL2g90M
	hMjXbvq2r3mP+FN6fVrvENh5aI7Debl3VW76+MlDBh6fTbdSchuGtO8uG4TwA5+cmLhI6OwLIqLCA
	8ozb6KTg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1pmZnb-003BFA-1a;
	Wed, 12 Apr 2023 12:42:07 +0000
Date: Wed, 12 Apr 2023 05:42:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2 00/23] fs-verity support for XFS
Message-ID: <ZDanH46VI7KmQeSV@infradead.org>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <ZDTt8jSdG72/UnXi@infradead.org>
 <20230412023319.GA5105@sol.localdomain>
 <20230412031826.GI3223426@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412031826.GI3223426@dread.disaster.area>
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
Cc: fsverity@lists.linux.dev, Christoph Hellwig <hch@infradead.org>, jth@kernel.org, agruenba@redhat.com, djwong@kernel.org, Andrey Albershteyn <aalbersh@redhat.com>, linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com, linux-ext4@vger.kernel.org, dchinner@redhat.com, rpeterso@redhat.com, damien.lemoal@opensource.wdc.com, linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Apr 12, 2023 at 01:18:26PM +1000, Dave Chinner wrote:
> Right. It's not entirely simple to store metadata on disk beyond EOF
> in XFS because of all the assumptions throughout the IO path and
> allocator interfaces that it can allocate space beyond EOF at will
> and something else will clean it up later if it is not needed. This
> impacts on truncate, delayed allocation, writeback, IO completion,
> EOF block removal on file close, background garbage collection,
> ENOSPC/EDQUOT driven space freeing, etc.  Some of these things cross
> over into iomap infrastructure, too.

To me that actually makes it easier to support the metadata beyond
i_size.  Remember that the file is immutable after add fsverity
hash is added.  So basically we just need to skip freeing the
eofblocks if that flag is set.
