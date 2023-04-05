Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D6C6D8265
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Apr 2023 17:47:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ps8C23dX4z3cjL
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Apr 2023 01:47:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=uZ5h4Xuo;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+46b8a92f13ae362fdcdf+7164+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=uZ5h4Xuo;
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ps8Bs6hcqz3bfk
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Apr 2023 01:46:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/a4RYFvjJCESxZnfN0nD29LBSxPBoE93Z5aSyhucaTc=; b=uZ5h4XuoSXe9+bgTWZvctsPSxL
	J8n1Ti8TOouo/7zVirWNYVC1UyJOxKJpvj0IV+068Sq2z4depUOryc2RPjsLDhDshySk3s1ERkMpO
	twG0PSY4Y9A4gHSqC5CiZ3DMrNnYamMfG6SDrpa5Hbgson6ObhdtRptTunuu6/oiaeD91NhGeqxl2
	LLiW0vhAwI9MzSnUyZBwOw1mxO39uzvhLDuMN7ocWBeWMY6tdeepv0CTpk6k8mMGLRIx/k4z9ngyj
	nvah9ZylV5D24DoACN/gpECeBwawUgtXs3FnYtThZl3pWf+dDadXNQQ65Tb5WLmAhQS1NHqb3/aKN
	ufVxLm9g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1pk5LR-004xwQ-0b;
	Wed, 05 Apr 2023 15:46:45 +0000
Date: Wed, 5 Apr 2023 08:46:45 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Subject: Re: [PATCH v2 05/23] fsverity: make fsverity_verify_folio() accept
 folio's offset and size
Message-ID: <ZC2X5YlHMxzZQzhx@infradead.org>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-6-aalbersh@redhat.com>
 <ZCxCnC2lM9N9qtCc@infradead.org>
 <20230405103642.ykmgjgb7yi7htphf@aalbersh.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405103642.ykmgjgb7yi7htphf@aalbersh.remote.csb>
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
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, agruenba@redhat.com, djwong@kernel.org, damien.lemoal@opensource.wdc.com, linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>, cluster-devel@redhat.com, dchinner@redhat.com, rpeterso@redhat.com, jth@kernel.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Apr 05, 2023 at 12:36:42PM +0200, Andrey Albershteyn wrote:
> Hi Christoph,
> 
> On Tue, Apr 04, 2023 at 08:30:36AM -0700, Christoph Hellwig wrote:
> > On Tue, Apr 04, 2023 at 04:53:01PM +0200, Andrey Albershteyn wrote:
> > > Not the whole folio always need to be verified by fs-verity (e.g.
> > > with 1k blocks). Use passed folio's offset and size.
> > 
> > Why can't those callers just call fsverity_verify_blocks directly?
> > 
> 
> They can. Calling _verify_folio with explicit offset; size appeared
> more clear to me. But I'm ok with dropping this patch to have full
> folio verify function.

Well, there is no point in a wrapper if it has the exact same signature
and functionality as the functionality being wrapped.

That being said, right now fsverity_verify_folio, so it might make sense
to either rename it, or rename fsverity_verify_blocks to
fsverity_verify_folio.  But that's really a question for Eric.
