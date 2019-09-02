Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC613A56BF
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2019 14:54:54 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46MVRH4ZJWzDqTn
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2019 22:54:51 +1000 (AEST)
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
 header.b="nfwL6FD/"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46MVR914m5zDqJV
 for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2019 22:54:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Cfou+aUkoFJmVggCmG5eZbSGsSmpOejeEZjjhO0gxJ4=; b=nfwL6FD/J5EAsuQwSDBysBDcS
 l4z7uQMeWEypiiaMxnhvBiPDbiKdqtKF8yZaWdcy/67tm+ZPiBujr4hww6UUL2LKJGKZuCEx8Mfiw
 KR/KFNkASy3e7RmEVI9D91/iZLmvxSrzqaeRhrIqQroiOFxTYd1yTOyPhfAzRdVpS/7LrPAgab/dv
 Xy+1eLJYjahB6DI6QNqSKKeh+EdsIkKAlxXZOwq85lzYWfTn0SQPjKsZOnoIsaoKUcWPVvnkqMGvA
 xXZDRWaYbqIPpRL1pLS8KqxGbZydOOwozGUN8EHI3LhJvnJymhNZHJXpcwW3sowqW2OJQG5msHlRH
 kibL2g0KA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat
 Linux)) id 1i4lqw-0004g0-Qu; Mon, 02 Sep 2019 12:54:38 +0000
Date: Mon, 2 Sep 2019 05:54:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH 16/21] erofs: kill magic underscores
Message-ID: <20190902125438.GA17750@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
 <20190901055130.30572-17-hsiangkao@aol.com>
 <20190902122627.GN15931@infradead.org>
 <20190902123937.GA17916@architecture4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902123937.GA17916@architecture4>
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

On Mon, Sep 02, 2019 at 08:39:37PM +0800, Gao Xiang wrote:
> > 
> > > +	if (erofs_inode_version(advise) == EROFS_INODE_LAYOUT_V2) {
> > 
> > I still need to wade through the old thread - but didn't you say this
> > wasn't really a new vs old version but a compat vs full inode?  Maybe
> > the names aren't that suitable either?
> 
> Could you kindly give some suggestions for better naming about it?
> there are all supported by EROFS... (Actually we only mainly use v1...)

Maybe EROFS_INODE_LAYOUT_COMPACT and EROFS_INODE_LAYOUT_EXTENDED?
