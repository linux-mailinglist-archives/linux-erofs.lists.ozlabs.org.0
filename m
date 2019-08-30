Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFCAA3ACA
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2019 17:46:27 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46KkNc3RDNzDqx4
	for <lists+linux-erofs@lfdr.de>; Sat, 31 Aug 2019 01:46:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+b0e6514120785512acaa+5850+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="ACtDIJSR"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46KkNK2B0dzDqwr
 for <linux-erofs@lists.ozlabs.org>; Sat, 31 Aug 2019 01:46:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wePmmyRAqzc9E8AvYvRy4CjZhcBEJxH2FmSPiZPoaEw=; b=ACtDIJSRM2EBOX+MHFb+Pg7Gj
 okiQGHIbGoDwFEpUIcFKrJ5P2TzxRrH8kQt1x1ttlmn8Hi6EYwnOS5wxfPX12SyRasM7GrLFcfwGx
 SpmwqgAHfveVdSQRIdU/UNLxWv8nu5nF0S836rOWWjtWiQyyofMPsjTctBlFlFLwk0O+rjXPPnoeG
 0IU3703HDn+vjNLkMF6/eqk5amnwC0IUBIaE9ezBMcoSxbwHmp0lqRizsJo4jiPkejwxITaV14R6V
 VyhLyMS9aa2J98Zbwpo/kX8fZcwV27B+kZWNwBCvhPEgnijY51i27p6dW51LFFz8No1uGrBKNHO6J
 1NLVlItmg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat
 Linux)) id 1i3j5z-0005dZ-2P; Fri, 30 Aug 2019 15:45:51 +0000
Date: Fri, 30 Aug 2019 08:45:51 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 2/7] erofs: some marcos are much more readable as a
 function
Message-ID: <20190830154551.GA11571@infradead.org>
References: <20190830030040.10599-1-gaoxiang25@huawei.com>
 <20190830030040.10599-2-gaoxiang25@huawei.com>
 <5b2ecf5cec1a6aa3834e9af41886a7fcb18ae86a.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b2ecf5cec1a6aa3834e9af41886a7fcb18ae86a.camel@perches.com>
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
 Miao Xie <miaoxie@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, weidu.du@huawei.com,
 linux-erofs@lists.ozlabs.org, Dan Carpenter <dan.carpenter@oracle.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Aug 29, 2019 at 08:16:27PM -0700, Joe Perches wrote:
> > -		sizeof(__u32) * ((__count) - 1); })
> > +static inline unsigned int erofs_xattr_ibody_size(__le16 d_icount)
> > +{
> > +	unsigned int icount = le16_to_cpu(d_icount);
> > +
> > +	if (!icount)
> > +		return 0;
> > +
> > +	return sizeof(struct erofs_xattr_ibody_header) +
> > +		sizeof(__u32) * (icount - 1);
> 
> Maybe use struct_size()?

Declaring a variable that is only used for struct_size is rather ugly.
But while we are nitpicking: you don't need to byteswap to check for 0,
so the local variable could be avoided.

Also what is that magic -1 for?  Normally we use that for the
deprecated style where a variable size array is declared using
varname[1], but that doesn't seem to be the case for erofs.
