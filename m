Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D68E8A5A7C
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2019 17:24:21 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46MYlk5Cd3zDqJ1
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Sep 2019 01:24:18 +1000 (AEST)
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
 header.b="hg55rG0H"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46MYf60wnJzDqRL
 for <linux-erofs@lists.ozlabs.org>; Tue,  3 Sep 2019 01:19:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2EGoFqF4zos5OWv6WNlwPBiBbR4EbKkewLh/Q5wrwzg=; b=hg55rG0HzZ77yWw3lDcHMwEJH
 4h8tXaA10F6hxvy5EoMJeMlsFgva45iKJC3AS9g/Ap2If6wlb+9lOoQjF6RautWXs7fuH2KbLPGpN
 TokyPVRzEED9kDfKmX0u4MhmhuRBVRYt+Z3SxO5dLwR2lBE5cfOK80/paYacTHWmSW0sdGT1Na+S7
 7aF0pm3wH2AIQejEdf+A1hMOAsn/lirsJZGtZPGXN77GBmAO/1wDvwfOk84jnwhxPVK1KEgzMy3sG
 1aboGacoWyhc+tMzP691PSZ/lxTmBIA7WJAdPZghGGSWUKZNLU67+qXiJdEu+WBVcVmXLOES8qJf1
 UBT+u7T5g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat
 Linux)) id 1i4o6o-0004hD-LX; Mon, 02 Sep 2019 15:19:10 +0000
Date: Mon, 2 Sep 2019 08:19:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH v6 03/24] erofs: add super block operations
Message-ID: <20190902151910.GA14009@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-4-gaoxiang25@huawei.com>
 <20190829101545.GC20598@infradead.org>
 <20190901085452.GA4663@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190902125109.GA9826@infradead.org>
 <20190902144303.GF2664@architecture4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902144303.GF2664@architecture4>
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
Cc: Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
 David Sterba <dsterba@suse.cz>, Miao Xie <miaoxie@huawei.com>,
 devel@driverdev.osuosl.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 "Darrick J . Wong" <darrick.wong@oracle.com>,
 Christoph Hellwig <hch@infradead.org>, Amir Goldstein <amir73il@gmail.com>,
 linux-erofs@lists.ozlabs.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@denx.de>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Sep 02, 2019 at 10:43:04PM +0800, Gao Xiang wrote:
> Hi Christoph,
> > > ...
> > >  24         __le32 features;        /* (aka. feature_compat) */
> > > ...
> > >  38         __le32 requirements;    /* (aka. feature_incompat) */
> > > ...
> > >  41 };
> > 
> > This is only cosmetic, why not stick to feature_compat and
> > feature_incompat?
> 
> Okay, will fix. (however, in my mind, I'm some confused why
> "features" could be incompatible...)

The feature is incompatible if it requires changes to the driver.
An easy to understand historic example is that ext3 originally did not
have the file types in the directory entry.  Adding them means old
file system drivers can not read a file system with this new feature,
so an incompat flag has to be added.

> > > > > +	memcpy(&sb->s_uuid, layout->uuid, sizeof(layout->uuid));
> > > > > +	memcpy(sbi->volume_name, layout->volume_name,
> > > > > +	       sizeof(layout->volume_name));
> > > > 
> > > > s_uuid should preferably be a uuid_t (assuming it is a real BE uuid,
> > > > if it is le it should be a guid_t).
> > > 
> > > For this case, I have no idea how to deal with...
> > > I have little knowledge about this uuid stuff, so I just copied
> > > from f2fs... (Could be no urgent of this field...)
> > 
> > Who fills out this field in the on-disk format and how?
> 
> mkfs.erofs, but this field leaves 0 for now. Is that reasonable?
> (using libuuid can generate it easily...)

If the filed is always zero for now please don't fill it out.  If you
decide it is worth adding the uuid eventually please add a compat
feature flag that you have a valid uuid and only fill out the field
if the file system actualy has a valid uuid.
