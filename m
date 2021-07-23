Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E63313D3D81
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Jul 2021 18:24:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GWZQh61kJz30DM
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Jul 2021 02:24:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54;
 helo=out30-54.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GWZQc2dPHz2yMg
 for <linux-erofs@lists.ozlabs.org>; Sat, 24 Jul 2021 02:24:21 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=7; SR=0; TI=SMTPD_---0UgjV2MC_1627057445; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UgjV2MC_1627057445) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 24 Jul 2021 00:24:06 +0800
Date: Sat, 24 Jul 2021 00:24:04 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v6] iomap: support tail packing inline read
Message-ID: <YPrtJLLsjvvQm1sD@B-P7TQMD6M-0146.local>
Mail-Followup-To: Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@lst.de>, linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 "Darrick J . Wong" <djwong@kernel.org>,
 Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
References: <20210722031729.51628-1-hsiangkao@linux.alibaba.com>
 <20210722053947.GA28594@lst.de>
 <YPrauRjG7+vCw7f9@casper.infradead.org>
 <YPre+j906ywgRHEZ@B-P7TQMD6M-0146.local>
 <YPrms0fWPwEZGNAL@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPrms0fWPwEZGNAL@casper.infradead.org>
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
Cc: "Darrick J . Wong" <djwong@kernel.org>,
 Andreas Gruenbacher <andreas.gruenbacher@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Jul 23, 2021 at 04:56:35PM +0100, Matthew Wilcox wrote:
> On Fri, Jul 23, 2021 at 11:23:38PM +0800, Gao Xiang wrote:
> > Hi Matthew,
> > 
> > On Fri, Jul 23, 2021 at 04:05:29PM +0100, Matthew Wilcox wrote:
> > > On Thu, Jul 22, 2021 at 07:39:47AM +0200, Christoph Hellwig wrote:
> > > > @@ -675,7 +676,7 @@ static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
> > > >  
> > > >  	flush_dcache_page(page);
> > > >  	addr = kmap_atomic(page);
> > > > -	memcpy(iomap->inline_data + pos, addr + pos, copied);
> > > > +	memcpy(iomap_inline_buf(iomap, pos), addr + pos, copied);
> > > 
> > > This is wrong; pos can be > PAGE_SIZE, so this needs to be
> > > addr + offset_in_page(pos).
> > 
> > Yeah, thanks for pointing out. It seems so, since EROFS cannot test
> > such write path, previously it was disabled explicitly. I could
> > update it in the next version as above.
> 
> We're also missing a call to __set_page_dirty_nobuffers().  This
> matters to nobody right now -- erofs is read-only and gfs2 only
> supports inline data in the inode.  I presume what is happening
> for gfs2 is that at inode writeback time, it copies the ~60 bytes
> from the page cache into the inode and then schedules the inode
> for writeback.
> 
> But logically, we should mark the page as dirty.  It'll be marked
> as dirty by ->mkwrite, should the page be mmaped, so gfs2 must
> already cope with a dirty page for inline data.

I'd suggest we still disable tail-packing inline for buffered write
path until some real user for testing. I can see some (maybe) page
writeback, inode writeback and inline converting cases which is
somewhat complicated than just update like this.

I suggest it could be implemented with some real users, at least it can
provide the real write pattern and paths for testing. I will send the
next version like my previous version to disable it until some real fs
user cares and works out a real pattern.

Thanks,
Gao Xiang

