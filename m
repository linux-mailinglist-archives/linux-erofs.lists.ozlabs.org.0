Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F38166D6760
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Apr 2023 17:32:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PrWwX6LzDz3cdt
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Apr 2023 01:32:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=kS417033;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+8568051c7530f6265d9e+7163+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=kS417033;
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PrWwS6rXsz3bfk
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Apr 2023 01:32:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=H6mc1gZhtXSneS6nte5uW4UZFELa9ivi94Hze/v8bew=; b=kS4170334H5m+oxgCVnmmbfs8Z
	HGcIrZO4ewhSv2x0uhcAurkfo8ppu67vASYNQq3Qd/M7iEqY5WYIWA/GGhfxTL0EqayVfGzm0ZgHC
	RchX/7zGEAnuEBysywlPXrCE17YdeutDLtHd4/UKlCfF6zaadmNmMBQRlJl7JNc1aJGI1/8ZBFQSX
	oTFeOYFfjZrVqlcF0ADAK6KzacZHHooO5I7DqGlmnK4NjCY3zQqecMMXo+G0O9qTZWVipvtosDIJI
	LaE1ceqK0n3y/4ZeJwIN/yytH+VCppgyUpHfoyunWwsKECUUoQYnJ48JKxsRMHBOhpLOZ0mtdfMi1
	q75JIVDw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1pjidr-0020pf-02;
	Tue, 04 Apr 2023 15:32:15 +0000
Date: Tue, 4 Apr 2023 08:32:14 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Subject: Re: [PATCH v2 08/23] iomap: hoist iomap_readpage_ctx from the
 iomap_readahead/_folio
Message-ID: <ZCxC/pQixOq03ltH@infradead.org>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-9-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404145319.2057051-9-aalbersh@redhat.com>
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
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, agruenba@redhat.com, hch@infradead.org, djwong@kernel.org, damien.lemoal@opensource.wdc.com, linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com, dchinner@redhat.com, rpeterso@redhat.com, jth@kernel.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Apr 04, 2023 at 04:53:04PM +0200, Andrey Albershteyn wrote:
> Make filesystems create readpage context, similar as
> iomap_writepage_ctx in write path. This will allow filesystem to
> pass _ops to iomap for ioend configuration (->prepare_ioend) which
> in turn would be used to set BIO end callout (bio->bi_end_io).
> 
> This will be utilized in further patches by fs-verity to verify
> pages on BIO completion by XFS.

Hmm.  Can't we just have a version of the readpage helper that just
gets the ops passed instead of creating all this boilerplate code?

For writepage XFS embedds the context in it's own structure, so it's
kindof needed, but I don't think we'll need that here.
