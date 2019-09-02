Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F07A5A7F
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2019 17:24:37 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46MYm16nVszDqSS
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Sep 2019 01:24:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+8d7e6b8ef813b711cfc0+5853+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="NCN9+wvd"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46MYkr2TYXzDqTx
 for <linux-erofs@lists.ozlabs.org>; Tue,  3 Sep 2019 01:23:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qlt1XZvn+qXgX2CBCaJ2bCzou441y9kxu8YsfHGoCq0=; b=NCN9+wvdBIRI2Pfb0QIrDqKWa
 qHDXFSl8v9/HhWPrQ/KFTTKLr9x6MilMwRmZRtlpqvUzB91OTeE0EzFNVz6N84SRzAFGVCl5mK6F1
 MMXmumOBHphfa6vwNFPuxMkpT8P8DSD8LoROBqhL7pd3u+osqxIdiFgBpAojI6n2uNpqYfbKxnZbN
 Va5jRgrOJPmLpoSDQRd/VPVHigQ1Y9H3PH56mh20OIjulyQPprs/AaysOdvi0NrqLH2RtRHmF2fuK
 AaqYeJuBeFX2e1Bv39sBrB0YpPwcbtcT29m/uZlJ4ouiXq6EHJc8s4H+48oUyuNG2VToIoIVuRjci
 ILfA9cMow==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat
 Linux)) id 1i4oAt-0006QV-Jw; Mon, 02 Sep 2019 15:23:23 +0000
Date: Mon, 2 Sep 2019 08:23:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH 00/21] erofs: patchset addressing Christoph's comments
Message-ID: <20190902152323.GB14009@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
 <20190902124645.GA8369@infradead.org>
 <20190902142452.GE2664@architecture4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902142452.GE2664@architecture4>
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

On Mon, Sep 02, 2019 at 10:24:52PM +0800, Gao Xiang wrote:
> > code quality stuff.  We're not addressing the issues with large amounts
> > of functionality duplicating VFS helpers.
> 
> You means killing erofs_get_meta_page or avoid erofs_read_raw_page?
> 
>  - For killing erofs_get_meta_page, here is the current erofs_get_meta_page:

> I think it is simple enough. read_cache_page need write a similar
> filler, or read_cache_page_gfp will call .readpage, and then
> introduce buffer_heads, that is what I'd like to avoid now (no need these
> bd_inode buffer_heads in memory...)

If using read_cache_page_gfp and ->readpage works, please do.  The
fact that the block device inode uses buffer heads is an implementation
detail that might not last very long and should be invisible to you.
It also means you can get rid of a lot of code that you don't have
to maintain and others don't have to update for global API changes.

>  - For erofs_read_raw_page, it can be avoided after iomap tail-end packing
>    feature is done... If we remove it now, it will make EROFS broken.
>    It is no urgent and Chao will focus on iomap tail-end packing feature.

Ok.  I wish we would have just sorted this out beforehand, which we
could have trivially done without all that staging mess.
