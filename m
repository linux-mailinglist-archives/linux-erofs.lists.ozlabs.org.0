Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B701A9C13
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Apr 2020 13:23:50 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 492Kjs37jSzDqQl
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Apr 2020 21:23:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=ClQLKHw9; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 492KhC4r0CzDqq3
 for <linux-erofs@lists.ozlabs.org>; Wed, 15 Apr 2020 21:22:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=p5k96MLyrJ0Kc/9UM6Xw8FfLDEnTX/dVH39aK5qAXAA=; b=ClQLKHw92puBJhU2nimC3BH8wA
 355osRMfVxhDQVssm7Zm9jE6v3E3dRGs+Oc5jFRy3/jQbyNAsfVORzBRmGEfW7/HIf4gbDH2d4DT2
 gL3rNu+X2XBNBJ3NpW/Bx0FlYJMdgdadGJM/y2cHwCtDUUl9b+KcgcTHyz2DkqV52KYqOQaeHmfVH
 s2D+J2WiHScmuPaZ+HVg8gSTWAFyV0P0cKjdmyQFi/TapX8CRjBU8aFB/npLmiZAvjPQMvj6Rpgij
 Vy0bfVHN0vosqBiQDXjyzG7mDrHdrpJGmw7wYW8mNvb2TBTAiSuOkc9Tu/G2eouAmkldMad/NLN38
 jgC7ixKA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jOg7U-0004jU-L2; Wed, 15 Apr 2020 11:22:16 +0000
Date: Wed, 15 Apr 2020 04:22:16 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v11 05/25] mm: Add new readahead_control API
Message-ID: <20200415112216.GC5820@bombadil.infradead.org>
References: <20200414150233.24495-1-willy@infradead.org>
 <20200414150233.24495-6-willy@infradead.org>
 <20200414181705.bfc4c0087092051a9475141e@linux-foundation.org>
 <20200415021808.GA5820@bombadil.infradead.org>
 <20200414215616.f665d12f8549f52606784d1e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414215616.f665d12f8549f52606784d1e@linux-foundation.org>
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
Cc: linux-xfs@vger.kernel.org, William Kucharski <william.kucharski@oracle.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 cluster-devel@redhat.com, linux-mm@kvack.org, ocfs2-devel@oss.oracle.com,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
 linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Apr 14, 2020 at 09:56:16PM -0700, Andrew Morton wrote:
> On Tue, 14 Apr 2020 19:18:08 -0700 Matthew Wilcox <willy@infradead.org> wrote:
> > Hmm.  They don't seem that big to me.
> 
> They're really big!

v5.7-rc1:	11636	    636	    224	  12496	   30d0	fs/iomap/buffered-io.o
readahead_v11:	11528	    636	    224	  12388	   3064	fs/iomap/buffered-io.o

> > __readahead_batch is much bigger, but it's only used by btrfs and fuse,
> > and it seemed unfair to make everybody pay the cost for a function only
> > used by two filesystems.
> 
> Do we expect more filesystems to use these in the future?

I'm honestly not sure.  I think it'd be nice to be able to fill a bvec
from the page cache directly, but I haven't tried to write that function
yet.  If so, then it'd be appropriate to move that functionality into
the core.

> > > The code adds quite a few (inlined!) VM_BUG_ONs.  Can we plan to remove
> > > them at some stage?  Such as, before Linus shouts at us :)
> > 
> > I'd be happy to remove them.  Various reviewers said things like "are you
> > sure this can't happen?"
> 
> Yeah, these things tend to live for ever.  Please add a todo to remove
> them after the code has matured?

Sure!  I'm touching this code some more in the large pages patch set, so
I can get rid of it there.
