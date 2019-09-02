Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C4CA56A4
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2019 14:50:18 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46MVKz1nn5zDqgV
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2019 22:50:15 +1000 (AEST)
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
 header.b="lhhhD47c"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46MVH20t2XzDqgF
 for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2019 22:47:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lbUBQKgUDKPWb0RcIaYnoeNg0UvfzO7NgYVDACBffsE=; b=lhhhD47csSfZu68It2L5tINLt
 17W6y9t9pkSzoknsICEdFrT/qOji3pNE8RECrQchEr41cPbKf5RQsflQse9RyCxUlI47EBjKeEX4I
 l2rktPQdIPFQak1TMStJSEoIzfZ+tDtO/eReMV1lyPgF2bGtOJzeD+SHayMqBAQxSBw8UrsW7xEl9
 ZI6g2LEbKSjJlf5IC93Hz9DfowybXWR2pO9x5l7XYvXXmCME6Yumpg/MKMbu8lYYyAPOGlVTUM2lz
 4Z5LxY99DB7+b3p3WuQBr8DosrDjPliSvclmzL5OrrUwTpQNicLRU0GoZ5ze4PFIbg+uC4h16+9Eq
 LTBkhiI4w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat
 Linux)) id 1i4lk9-0002Y1-1W; Mon, 02 Sep 2019 12:47:37 +0000
Date: Mon, 2 Sep 2019 05:47:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH 07/21] erofs: use erofs_inode naming
Message-ID: <20190902124737.GB8369@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
 <20190901055130.30572-8-hsiangkao@aol.com>
 <20190902121021.GG15931@infradead.org>
 <20190902121306.GA2664@architecture4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902121306.GA2664@architecture4>
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

On Mon, Sep 02, 2019 at 08:13:06PM +0800, Gao Xiang wrote:
> Hi Christoph,
> 
> On Mon, Sep 02, 2019 at 05:10:21AM -0700, Christoph Hellwig wrote:
> > >  {
> > > -	struct erofs_vnode *vi = ptr;
> > > -
> > > -	inode_init_once(&vi->vfs_inode);
> > > +	inode_init_once(&((struct erofs_inode *)ptr)->vfs_inode);
> > 
> > Why doesn't this use EROFS_I?  This looks a little odd.
> 
> Thanks for your reply and suggestion...
> EROFS_I seems the revert direction ---> inode to erofs_inode
> here we need "erofs_inode" to inode...
> 
> Am I missing something?.... Hope not....

No, you are not.  But the cast still looks odd.  Why not:

	struct erofs_inode *ei = ptr;

	inode_init_once(&ei->vfs_inode);
