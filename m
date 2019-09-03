Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29388A6209
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Sep 2019 08:58:28 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46MyTX5GrkzDqjJ
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Sep 2019 16:58:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+680e2818d6643897e706+5854+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="rpXp0SPn"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46MyTJ5BtSzDqR5
 for <linux-erofs@lists.ozlabs.org>; Tue,  3 Sep 2019 16:58:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4hSYkiCPCpSgRGHZSvIjoW5chKDDuf7TDPZ/KesWimM=; b=rpXp0SPnAU2Bqz1hm0nm2/Yhf
 UNxaHXOTptV/vZxgW3l45UkXmbSzFCF6jpcGgR4N3NWzh00kL4gHglfJtSMHQvR60R6+PNJDDrW0d
 nlQ6UmPC6dG+rbeDzAOVh+DAfSlcO467RK/ptDPHANCLGc0TquzUn/UuPyqUQQAs9e/x7qVnC0pN5
 oGhHbdcJW7UypcG0tDscA3Rv00tKuFzAz15Ot23KmxGbbcv4gjTz0zF3F72iLahRGtWWNR3c8raTD
 m0dAbbkkgkLz1z+7Yy5HZ8Y5BF/zMkUDMO5uyeI7JxTtiMS8hPeSYqePPLoHLc+WsBf4OrHTAsIfJ
 W14CT7M+A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat
 Linux)) id 1i52lP-0003At-I5; Tue, 03 Sep 2019 06:58:03 +0000
Date: Mon, 2 Sep 2019 23:58:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH 00/21] erofs: patchset addressing Christoph's comments
Message-ID: <20190903065803.GA11205@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
 <20190902124645.GA8369@infradead.org>
 <20190902142452.GE2664@architecture4>
 <20190902152323.GB14009@infradead.org>
 <20190902155037.GD179615@architecture4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902155037.GD179615@architecture4>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Sep 02, 2019 at 11:50:38PM +0800, Gao Xiang wrote:
> > > You means killing erofs_get_meta_page or avoid erofs_read_raw_page?
> > > 
> > >  - For killing erofs_get_meta_page, here is the current erofs_get_meta_page:
> > 
> > > I think it is simple enough. read_cache_page need write a similar
> > > filler, or read_cache_page_gfp will call .readpage, and then
> > > introduce buffer_heads, that is what I'd like to avoid now (no need these
> > > bd_inode buffer_heads in memory...)
> > 
> > If using read_cache_page_gfp and ->readpage works, please do.  The
> > fact that the block device inode uses buffer heads is an implementation
> > detail that might not last very long and should be invisible to you.
> > It also means you can get rid of a lot of code that you don't have
> > to maintain and others don't have to update for global API changes.
> 
> I care about those useless buffer_heads in memory for our products...
> 
> Since we are nobh filesystem (a little request, could I use it
> after buffer_heads are fully avoided, I have no idea why I need
> those buffer_heads in memory.... But I think bd_inode is good
> for caching metadata...)

Then please use read_cache_page with iomap_readpage(s), and write
comment explaining why your are not using read_cache_page_gfp.
