Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBB23D7948
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Jul 2021 17:04:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GZ0T30n0qz306h
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Jul 2021 01:04:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131;
 helo=out30-131.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GZ0Sz60Qzz2yYS
 for <linux-erofs@lists.ozlabs.org>; Wed, 28 Jul 2021 01:04:49 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=10; SR=0; TI=SMTPD_---0UhAAkxc_1627398276; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UhAAkxc_1627398276) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 27 Jul 2021 23:04:38 +0800
Date: Tue, 27 Jul 2021 23:04:36 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Matthew Wilcox <willy@infradead.org>,
 "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v7] iomap: make inline data support more flexible
Message-ID: <YQAghPSTWdTGYAm5@B-P7TQMD6M-0146.local>
Mail-Followup-To: Matthew Wilcox <willy@infradead.org>,
 "Darrick J . Wong" <djwong@kernel.org>, dsterba@suse.cz,
 Christoph Hellwig <hch@lst.de>,
 Andreas Gruenbacher <agruenba@redhat.com>,
 Huang Jianan <huangjianan@oppo.com>, linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
References: <CAHpGcMKZP8b3TbRv3D-pcrE_iDU5TKUFHst9emuQmRPntFSArA@mail.gmail.com>
 <CAHpGcMJBhWcwteLDSBU3hgwq1tk_+LqogM1ZM=Fv8U0VtY5hMg@mail.gmail.com>
 <20210723174131.180813-1-hsiangkao@linux.alibaba.com>
 <20210725221639.426565-1-agruenba@redhat.com>
 <YP4zUvnBCAb86Mny@B-P7TQMD6M-0146.local>
 <20210726110611.459173-1-agruenba@redhat.com>
 <20210726121702.GA528@lst.de> <20210727082042.GI5047@twin.jikos.cz>
 <YQALsvt0UWGW+iMw@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YQALsvt0UWGW+iMw@casper.infradead.org>
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
Cc: Andreas Gruenbacher <agruenba@redhat.com>, linux-kernel@vger.kernel.org,
 Andreas Gruenbacher <andreas.gruenbacher@gmail.com>, dsterba@suse.cz,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Jul 27, 2021 at 02:35:46PM +0100, Matthew Wilcox wrote:
> On Tue, Jul 27, 2021 at 10:20:42AM +0200, David Sterba wrote:
> > On Mon, Jul 26, 2021 at 02:17:02PM +0200, Christoph Hellwig wrote:
> > > > Subject: iomap: Support tail packing
> > > 
> > > I can't say I like this "tail packing" language here when we have the
> > > perfectly fine inline wording.  Same for various comments in the actual
> > > code.
> > 
> > Yes please, don't call it tail-packing when it's an inline extent, we'll
> > use that for btrfs eventually and conflating the two terms has been
> > cofusing users. Except reiserfs, no linux filesystem does tail-packing.
> 
> Hmm ... I see what reiserfs does as packing tails of multiple files into
> one block.  What gfs2 (and ext4) do is inline data.  Erofs packs the
> tail of a single file into the same block as the inode.  If I understand

Plus each erofs block can have multiple inodes (thus multi-tail blocks) 
oo as long as the meta block itself can fit.

No matter what it's called, it's a kind of inline data (I think inline
means that data mixes with metadata according to [1]). I was called it
tail-block inline initially... whatever.

Hopefully, Darrick could update the v8 title if some concern here.

[1] https://www.kernel.org/doc/Documentation/filesystems/fiemap.txt

Thanks,
Gao Xiang

> what btrfs does correctly, it stores data in the btree.  But (like
> gfs2/ext4), it's only for the entire-file-is-small case, not for
> its-just-ten-bytes-into-the-last-block case.
> 
> So what would you call what erofs is doing if not tail-packing?
> Wikipedia calls it https://en.wikipedia.org/wiki/Block_suballocation
> which doesn't quite fit.  We need a phrase which means "this isn't
> just for small files but for small tails of large files".
