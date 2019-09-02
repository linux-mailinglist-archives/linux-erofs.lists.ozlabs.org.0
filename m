Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC880A5718
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2019 15:04:35 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46MVfS4r3WzDqYB
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2019 23:04:32 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.187; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46MVdW5pJbzDqSW
 for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2019 23:03:43 +1000 (AEST)
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id 6A3C43110C48CBDD4B54;
 Mon,  2 Sep 2019 21:03:37 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 2 Sep 2019 21:03:37 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 2 Sep 2019 21:03:36 +0800
Date: Mon, 2 Sep 2019 21:02:45 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v6 01/24] erofs: add on-disk layout
Message-ID: <20190902130245.GC17916@architecture4>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-2-gaoxiang25@huawei.com>
 <20190829095954.GB20598@infradead.org>
 <20190901075240.GA2938@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190902124521.GA22153@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190902124521.GA22153@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme707-chm.china.huawei.com (10.1.199.103) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
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
 linux-erofs@lists.ozlabs.org, Amir Goldstein <amir73il@gmail.com>,
 Jan Kara <jack@suse.cz>, "Darrick J . Wong" <darrick.wong@oracle.com>, Linus
 Torvalds <torvalds@linux-foundation.org>, Dave Chinner <david@fromorbit.com>,
 LKML <linux-kernel@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 David Sterba <dsterba@suse.cz>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Pavel Machek <pavel@denx.de>,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Christoph,

On Mon, Sep 02, 2019 at 05:45:21AM -0700, Christoph Hellwig wrote:
> On Sun, Sep 01, 2019 at 03:54:11PM +0800, Gao Xiang wrote:
> > It could be better has a name though, because 1) erofs.mkfs uses this
> > definition explicitly, and we keep this on-disk definition erofs_fs.h
> > file up with erofs-utils.
> > 
> > 2) For kernel use, first we have,
> >    datamode < EROFS_INODE_LAYOUT_MAX; and
> >    !erofs_inode_is_data_compressed, so there are only two mode here,
> >         1) EROFS_INODE_FLAT_INLINE,
> >         2) EROFS_INODE_FLAT_PLAIN
> >    if its datamode isn't EROFS_INODE_FLAT_INLINE (tail-end block packing),
> >    it should be EROFS_INODE_FLAT_PLAIN.
> > 
> >    The detailed logic in erofs_read_inode and
> >    erofs_map_blocks_flatmode....
> 
> Ok.  At least the explicit numbering makes this a little more obvious
> now.  What seems fairly odd is that there are only various places that
> check for some inode layouts/formats but nothing that does a switch
> over all of them.

(Maybe not explicitly for this part....)

erofs_map_blocks_flatmode()
...
 97         nblocks = DIV_ROUND_UP(inode->i_size, PAGE_SIZE);
 98         lastblk = nblocks - is_inode_flat_inline(inode);
                                ^ here
...

Believe me EROFS_INODE_FLAT_PLAIN is used widely for EROFS images....
(if EROFS_INODE_FLAT_INLINE tail-end packing is not suitable and
 no compression....)

> 
> > > why are we adding a legacy field to a brand new file system?
> > 
> > The difference is just EROFS_INODE_FLAT_COMPRESSION_LEGACY doesn't
> > have z_erofs_map_header, so it only supports default (4k clustersize)
> > fixed-sized output compression rather than per-file setting, nothing
> > special at all...
> 
> It still seems odd to add a legacy field to a brand new file system.

Since 4.19 EROFS only supports EROFS_INODE_FLAT_COMPRESSION_LEGACY
(per-filesystem setting), we'd like to introduce per-file setting and
more configration for future requirements....

> 
> > > structures, as that keeps it clear in everyones mind what needs to
> > > stay persistent and what can be chenged easily.
> > 
> > All fields in this file are on-disk representation by design
> > (no logic for in-memory presentation).
> 
> Ok, make sense.    Maybe add a note to the top of the file comment
> that this is the on-disk format.
> 
> One little oddity is that erofs_inode_is_data_compressed is here, while
> is_inode_flat_inline is in internal.h.  There are arguments for either
> place, but I'd suggest to keep the related macros together.

(Just my personal thought... erofs_inode_is_data_compressed operates
ondisk field like datamode (because we have 2 datamode for compression,
need to wrap them to judge if the file is compressed...)
so it stays at erofs_fs.h... is_inode_flat_inline operates in-memory
struct inode so it in internal.h....)

Thanks,
Gao Xiang

