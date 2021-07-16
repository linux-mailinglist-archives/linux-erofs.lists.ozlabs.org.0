Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B648B3CB832
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Jul 2021 15:56:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GRCTb51Jhz303h
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Jul 2021 23:56:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57;
 helo=out30-57.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GRCTW0Smgz2yNT
 for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jul 2021 23:56:45 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=10; SR=0; TI=SMTPD_---0UfzOB3Y_1626443784; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UfzOB3Y_1626443784) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 16 Jul 2021 21:56:25 +0800
Date: Fri, 16 Jul 2021 21:56:23 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/2] iomap: support tail packing inline read
Message-ID: <YPGQB3zT4Wp4Q38X@B-P7TQMD6M-0146.local>
Mail-Followup-To: Matthew Wilcox <willy@infradead.org>,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Chao Yu <chao@kernel.org>,
 Liu Bo <bo.liu@linux.alibaba.com>,
 Joseph Qi <joseph.qi@linux.alibaba.com>,
 Liu Jiang <gerry@linux.alibaba.com>
References: <20210716050724.225041-1-hsiangkao@linux.alibaba.com>
 <20210716050724.225041-2-hsiangkao@linux.alibaba.com>
 <YPGDZYT9OxdgNYf2@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPGDZYT9OxdgNYf2@casper.infradead.org>
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
Cc: "Darrick J. Wong" <djwong@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Liu Bo <bo.liu@linux.alibaba.com>, linux-fsdevel@vger.kernel.org,
 Liu Jiang <gerry@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Matthew,

On Fri, Jul 16, 2021 at 02:02:29PM +0100, Matthew Wilcox wrote:
> On Fri, Jul 16, 2021 at 01:07:23PM +0800, Gao Xiang wrote:
> > This tries to add tail packing inline read to iomap. Different from
> > the previous approach, it only marks the block range uptodate in the
> > page it covers.
> 
> Why?  This path is called under two circumstances: readahead and readpage.
> In both cases, we're trying to bring the entire page uptodate.  The inline
> extent is always the tail of the file, so we may as well zero the part of
> the page past the end of file and mark the entire page uptodate instead
> and leaving the end of the page !uptodate.
> 
> I see the case where, eg, we have the first 2048 bytes of the file
> out-of-inode and then 20 bytes in the inode.  So we'll create the iop
> for the head of the file, but then we may as well finish the entire
> PAGE_SIZE chunk as part of this iteration rather than update 2048-3071
> as being uptodate and leave the 3072-4095 block for a future iteration.

Thanks for your comments. Hmm... If I understand the words above correctly,
what I'd like to do is to cover the inline extents (blocks) only
reported by iomap_begin() rather than handling other (maybe)
logical-not-strictly-relevant areas such as post-EOF (even pages
will be finally entirely uptodated), I think such zeroed area should
be handled by from the point of view of the extent itself

         if (iomap_block_needs_zeroing(inode, iomap, pos)) {
                 zero_user(page, poff, plen);
                 iomap_set_range_uptodate(page, poff, plen);
                 goto done;
         }

The benefits I can think out are 1) it makes the logic understand
easier and no special cases just for tail-packing handling 2) it can
be then used for any inline extent cases (I mean e.g. in the middle of
the file) rather than just tail-packing inline blocks although currently
there is a BUG_ON to prevent this but it's easier to extend even further.
3) it can be used as a part for later partial page uptodate logic in
order to match the legacy buffer_head logic (I remember something if my
memory is not broken about this...)

Thanks,
Gao Xiang

