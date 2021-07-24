Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F290A3D4630
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Jul 2021 09:52:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GWz1Y5n0mz30Dh
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Jul 2021 17:52:33 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GWz1T1gTkz2xfN
 for <linux-erofs@lists.ozlabs.org>; Sat, 24 Jul 2021 17:52:27 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R531e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0UgmyvHs_1627113140; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UgmyvHs_1627113140) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 24 Jul 2021 15:52:21 +0800
Date: Sat, 24 Jul 2021 15:52:20 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH 2/2] iomap: Support inline data with block size < page size
Message-ID: <YPvGtP89rmiy9sU0@B-P7TQMD6M-0146.local>
Mail-Followup-To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-xfs@vger.kernel.org
References: <20210724034435.2854295-1-willy@infradead.org>
 <20210724034435.2854295-3-willy@infradead.org>
 <YPubNbDS0KgUALtt@B-P7TQMD6M-0146.local>
 <YPug7VUMZboQu4QW@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPug7VUMZboQu4QW@B-P7TQMD6M-0146.local>
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
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Jul 24, 2021 at 01:11:09PM +0800, Gao Xiang wrote:
> On Sat, Jul 24, 2021 at 12:46:45PM +0800, Gao Xiang wrote:

...

> > 
> > Thanks for the patch!
> > 
> > Previously I'd like to skip the leading uptodate blocks and update the
> > extent it covers that is due to already exist iop. If we get rid of the
> > offset_in_page(pos) restriction like this, I'm not sure if we (or some
> > other fs users) could face something like below (due to somewhat buggy
> > fs users likewise):
> > 
> >  [0 - 4096)    plain block
> > 
> >  [4096 - 4608)  tail INLINE 1 (e.g. by mistake or just splitted
> >                                     .iomap_begin() report.)
> >  [4608 - 5120]  tail INLINE 2
> > 
> 
> (cont.)
> 
> So I think without the !offset_in_page(pos) restriction, at least we
> may need to add something like:
> 
> if (WARN_ON_ONCE(size != i_size_read(inode) - iomap->offset))
> 	return -EIO;
> 
> to the approach to detect such cases at least but that is no need with
> page-sized and !offset_in_page(pos) restriction.
> 

Never mind, after rethinking with clear head, I think I was overthinking
this part and it shouldn't behave like this. Sorry about the noise above.

> > 
> > >  
> > > -	addr = kmap_atomic(page);
> > > +	addr = kmap_atomic(page) + poff;
> > >  	memcpy(addr, iomap_inline_buf(iomap, pos), size);
> > > -	memset(addr + size, 0, PAGE_SIZE - size);
> > > +	memset(addr + size, 0, PAGE_SIZE - poff - size);
> > >  	kunmap_atomic(addr);
> > 
> > As my limited understanding, this may need to be fixed, since it
> > doesn't match kmap_atomic(page)...
> > 
> > Thanks,
> > Gao Xiang
> > 
> > > -	SetPageUptodate(page);
> > > -	return PAGE_SIZE;
> > > +	iomap_set_range_uptodate(page, poff, PAGE_SIZE - poff);
> > > +	return PAGE_SIZE - poff;
> > >  }
> > >  
> > >  static inline bool iomap_block_needs_zeroing(struct inode *inode,
> > > -- 
> > > 2.30.2
> > > 
