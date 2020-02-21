Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id BE109168995
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Feb 2020 22:49:08 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48PQ8L0t1XzDqrm
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Feb 2020 08:49:06 +1100 (AEDT)
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
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=iCNdT0BZ; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48PQ892xTQzDqqW
 for <linux-erofs@lists.ozlabs.org>; Sat, 22 Feb 2020 08:48:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=MjU0vaJ+i1WQ4UQpS8eKlaynh2uwVXzGNQNy57Q9C9k=; b=iCNdT0BZXgtTW3Fw9E7mV20LZ3
 6bABfCOOFRCJ7uEiieuVoc7VQvPYz9c1AqPQS7RqHIO2SPtmECRCJ7fINKg3kWrEwzycOHzoI2EXq
 gb8xBz4Q6YqdlmdYSYmNzPYMGLnkARpEro+4SyAMM0qv/bPjVCXcHHSSe2kepGwYnmLclyWoT72Ri
 xVH+asjJnQ5gia6IN546JKq8u1xVU9xK4MZ7CcV53GDFQceXlwOtV+auqB/eJnS3NjFkIZuYn1p/U
 bzlnG8k5S9m/fPbCpIe+WYxJl419e2ENRT98jQ6jjA5WKiplo70Ono1aN5F+tvL7N8eBzKyaRDymg
 11ulvQcg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j5GAH-0001lk-Uz; Fri, 21 Feb 2020 21:48:53 +0000
Date: Fri, 21 Feb 2020 13:48:53 -0800
From: Matthew Wilcox <willy@infradead.org>
To: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v7 01/24] mm: Move readahead prototypes from mm.h
Message-ID: <20200221214853.GF24185@bombadil.infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-2-willy@infradead.org>
 <e065679e-222f-7323-9782-0c4471bb9233@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e065679e-222f-7323-9782-0c4471bb9233@nvidia.com>
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
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Feb 20, 2020 at 06:43:31PM -0800, John Hubbard wrote:
> Yes. But I think these files also need a similar change:
> 
>     fs/btrfs/disk-io.c

That gets pagemap.h through ctree.h, so I think it's fine.  It's
already using mapping_set_gfp_mask(), so it already depends on pagemap.h.

>     fs/nfs/super.c

That gets it through linux/nfs_fs.h.

I was reluctant to not add it to blk-core.c because it doesn't seem
necessarily intuitive that the block device core would include pagemap.h.

That said, blkdev.h does include pagemap.h, so maybe I don't need to
include it here.

> ...because they also use VM_READAHEAD_PAGES, and do not directly include
> pagemap.h yet.

> > +#define VM_READAHEAD_PAGES	(SZ_128K / PAGE_SIZE)
> > +
> > +void page_cache_sync_readahead(struct address_space *, struct file_ra_state *,
> > +		struct file *, pgoff_t index, unsigned long req_count);
> 
> Yes, "struct address_space *mapping" is weird, but I don't know if it's
> "misleading", given that it's actually one of the things you have to learn
> right from the beginning, with linux-mm, right? Or is that about to change?
> 
> I'm not asking to restore this to "struct address_space *mapping", but I thought
> it's worth mentioning out loud, especially if you or others are planning on
> changing those names or something. Just curious.

No plans (on my part) to change the name, although I have heard people
grumbling that there's very little need for it to be a separate struct
from inode, except for the benefit of coda, which is not exactly a
filesystem with a lot of users ...

Anyway, no plans to change it.  If there were something _special_ about
it like a theoretical:

void mapping_dedup(struct address_space *canonical,
		struct address_space *victim);

then that's useful information and shouldn't be deleted.  But I don't
think the word 'mapping' there conveys anything useful (other than the
convention is to call a 'struct address_space' a mapping, which you'll
see soon enough once you look at any of the .c files).
