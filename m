Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1667C3D76EE
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Jul 2021 15:38:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GYyYW6k0tz307g
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Jul 2021 23:38:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=o3L8a9jE;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=o3L8a9jE; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GYyYM3xsJz301P
 for <linux-erofs@lists.ozlabs.org>; Tue, 27 Jul 2021 23:38:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=EpSbFrEHGAQA1xr1naEuF16MkP61b5G7e9AV8x/Ex4E=; b=o3L8a9jEH3Ul9rQPCR8ay1CcPx
 wIvSa1TgAQ50cmZBTGLgdFt+6KKz9MeISZt2oLyJAD+VrxC8sVZkQDWVTFzAm7Iwxmpok/1Mp4p6l
 P3Nl2s2YEtHdeeEepN52ujuAy8ErrEuQsmZ0DzDilBtZpMXt8pbSZ387BLsESn7wQtqgtyy131Fgr
 V9tKJps9bOSaCDF4lQ4fPtAksGfWW7/qHx9sl878omOclcnrAte+06XMAscDe8xg0q4Zv3OxvS6QB
 8i4Bw2KjwG4FkaEEwKm3MCpXkLEBkiiptKY01o0p92Uxi/IvCJJVRpyiIPCzrVvjXAgtyPhGczHr3
 KaXHSOCg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1m8NFL-00F2s7-Bz; Tue, 27 Jul 2021 13:36:29 +0000
Date: Tue, 27 Jul 2021 14:35:46 +0100
From: Matthew Wilcox <willy@infradead.org>
To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
 Andreas Gruenbacher <agruenba@redhat.com>,
 Gao Xiang <hsiangkao@linux.alibaba.com>,
 "Darrick J . Wong" <djwong@kernel.org>,
 Huang Jianan <huangjianan@oppo.com>, linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Subject: Re: [PATCH v7] iomap: make inline data support more flexible
Message-ID: <YQALsvt0UWGW+iMw@casper.infradead.org>
References: <CAHpGcMKZP8b3TbRv3D-pcrE_iDU5TKUFHst9emuQmRPntFSArA@mail.gmail.com>
 <CAHpGcMJBhWcwteLDSBU3hgwq1tk_+LqogM1ZM=Fv8U0VtY5hMg@mail.gmail.com>
 <20210723174131.180813-1-hsiangkao@linux.alibaba.com>
 <20210725221639.426565-1-agruenba@redhat.com>
 <YP4zUvnBCAb86Mny@B-P7TQMD6M-0146.local>
 <20210726110611.459173-1-agruenba@redhat.com>
 <20210726121702.GA528@lst.de> <20210727082042.GI5047@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727082042.GI5047@twin.jikos.cz>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Jul 27, 2021 at 10:20:42AM +0200, David Sterba wrote:
> On Mon, Jul 26, 2021 at 02:17:02PM +0200, Christoph Hellwig wrote:
> > > Subject: iomap: Support tail packing
> > 
> > I can't say I like this "tail packing" language here when we have the
> > perfectly fine inline wording.  Same for various comments in the actual
> > code.
> 
> Yes please, don't call it tail-packing when it's an inline extent, we'll
> use that for btrfs eventually and conflating the two terms has been
> cofusing users. Except reiserfs, no linux filesystem does tail-packing.

Hmm ... I see what reiserfs does as packing tails of multiple files into
one block.  What gfs2 (and ext4) do is inline data.  Erofs packs the
tail of a single file into the same block as the inode.  If I understand
what btrfs does correctly, it stores data in the btree.  But (like
gfs2/ext4), it's only for the entire-file-is-small case, not for
its-just-ten-bytes-into-the-last-block case.

So what would you call what erofs is doing if not tail-packing?
Wikipedia calls it https://en.wikipedia.org/wiki/Block_suballocation
which doesn't quite fit.  We need a phrase which means "this isn't
just for small files but for small tails of large files".
