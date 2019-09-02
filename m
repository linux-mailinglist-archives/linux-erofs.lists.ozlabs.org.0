Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A5AA56A5
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2019 14:50:25 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46MVL65qYnzDqSv
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2019 22:50:22 +1000 (AEST)
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
 header.b="ZVUGTMsp"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46MVHL0m9czDqfs
 for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2019 22:47:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8e5pl/cUyEaSaTIP0gVix4kLe1LPGSDBfLiK5Z6oMK4=; b=ZVUGTMspxfe3xQHunBefXYA5b
 RRbaGgX6OxaI5bD/kap+hgR/IMcivPmetVVU0OUh7XfX/onX4ou9VeUjDQzoj7QsZuFRnisygmRMR
 6aSRZqCeGTIR7HBudutdMooyrGcPpR0hkheR6CyDRkG5dnHP0PPWBnPiut+u+ir5xS3zAUTvIKeMp
 9kadYDIyHlr8crmhMNQf+xk98sFwL/p9FMNGUL465OFDk2tte+kQXPCeD4kLiTtAJCrJKcZsmRYhZ
 uS4+zLv9VrGHCAGQSoOHn9VVeP/qV/SEF74aqb+LcB7q27YkoFsxkDnZqLUWMBKzyYIaO02PDTHcf
 rwwT6O0Pw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat
 Linux)) id 1i4lhx-00028u-J6; Mon, 02 Sep 2019 12:45:21 +0000
Date: Mon, 2 Sep 2019 05:45:21 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <hsiangkao@aol.com>
Subject: Re: [PATCH v6 01/24] erofs: add on-disk layout
Message-ID: <20190902124521.GA22153@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-2-gaoxiang25@huawei.com>
 <20190829095954.GB20598@infradead.org>
 <20190901075240.GA2938@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901075240.GA2938@hsiangkao-HP-ZHAN-66-Pro-G1>
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
Cc: devel@driverdev.osuosl.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-erofs@lists.ozlabs.org, Jan Kara <jack@suse.cz>,
 "Darrick J . Wong" <darrick.wong@oracle.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Amir Goldstein <amir73il@gmail.com>, Dave Chinner <david@fromorbit.com>,
 LKML <linux-kernel@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 Christoph Hellwig <hch@infradead.org>, Pavel Machek <pavel@denx.de>,
 David Sterba <dsterba@suse.cz>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, Sep 01, 2019 at 03:54:11PM +0800, Gao Xiang wrote:
> It could be better has a name though, because 1) erofs.mkfs uses this
> definition explicitly, and we keep this on-disk definition erofs_fs.h
> file up with erofs-utils.
> 
> 2) For kernel use, first we have,
>    datamode < EROFS_INODE_LAYOUT_MAX; and
>    !erofs_inode_is_data_compressed, so there are only two mode here,
>         1) EROFS_INODE_FLAT_INLINE,
>         2) EROFS_INODE_FLAT_PLAIN
>    if its datamode isn't EROFS_INODE_FLAT_INLINE (tail-end block packing),
>    it should be EROFS_INODE_FLAT_PLAIN.
> 
>    The detailed logic in erofs_read_inode and
>    erofs_map_blocks_flatmode....

Ok.  At least the explicit numbering makes this a little more obvious
now.  What seems fairly odd is that there are only various places that
check for some inode layouts/formats but nothing that does a switch
over all of them.

> > why are we adding a legacy field to a brand new file system?
> 
> The difference is just EROFS_INODE_FLAT_COMPRESSION_LEGACY doesn't
> have z_erofs_map_header, so it only supports default (4k clustersize)
> fixed-sized output compression rather than per-file setting, nothing
> special at all...

It still seems odd to add a legacy field to a brand new file system.

> > structures, as that keeps it clear in everyones mind what needs to
> > stay persistent and what can be chenged easily.
> 
> All fields in this file are on-disk representation by design
> (no logic for in-memory presentation).

Ok, make sense.    Maybe add a note to the top of the file comment
that this is the on-disk format.

One little oddity is that erofs_inode_is_data_compressed is here, while
is_inode_flat_inline is in internal.h.  There are arguments for either
place, but I'd suggest to keep the related macros together.
