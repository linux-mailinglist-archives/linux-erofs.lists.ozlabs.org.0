Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45143166A71
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Feb 2020 23:39:26 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48NqJq3LgXzDqWH
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Feb 2020 09:39:23 +1100 (AEDT)
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
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=tRp/RfyO; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48NqJf2rKvzDqNW
 for <linux-erofs@lists.ozlabs.org>; Fri, 21 Feb 2020 09:39:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=PJX15g/idnsbi9mBK4m/qgB4NAR6fjeo4oenehrzb84=; b=tRp/RfyOc8MMAOEnFbjVZPeWaN
 2KkzEKXiN/S1p09Bqu90S2Z278xQaeJcCcxdgeXrdpytnUBFOLEh/tcVUgBOZ3WDQA1fyr25gzLyH
 gRM7sCok3nV4KM0JhdGQW17PpL0/Q+08nFcey+vxgYObaAojcT6v9r7vvwC4L45gbM+E1ObajSRbu
 9fqhh3Le7FzPdJj54Iv5P1uuGStaEN80lg311yLhBq1nMBvGvQ80nBsaseT/97o8elxjyPsMZtK46
 3NBlICNdJTCPRvVzyFRBHETaOyBq9s1mCrpI3p5mh7mcYzLn6aixyJdO3+xKTmslXOd/sUkUMeqtP
 kTySNnYQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j4uTN-0006hx-9M; Thu, 20 Feb 2020 22:39:09 +0000
Date: Thu, 20 Feb 2020 14:39:09 -0800
From: Matthew Wilcox <willy@infradead.org>
To: dsterba@suse.cz, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v7 00/23] Change readahead API
Message-ID: <20200220223909.GB24185@bombadil.infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200220175400.GB2902@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220175400.GB2902@twin.jikos.cz>
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

On Thu, Feb 20, 2020 at 06:54:00PM +0100, David Sterba wrote:
> On Wed, Feb 19, 2020 at 01:00:39PM -0800, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > This series adds a readahead address_space operation to eventually
> > replace the readpages operation.  The key difference is that
> > pages are added to the page cache as they are allocated (and
> > then looked up by the filesystem) instead of passing them on a
> > list to the readpages operation and having the filesystem add
> > them to the page cache.  It's a net reduction in code for each
> > implementation, more efficient than walking a list, and solves
> > the direct-write vs buffered-read problem reported by yu kuai at
> > https://lore.kernel.org/linux-fsdevel/20200116063601.39201-1-yukuai3@huawei.com/
> > 
> > The only unconverted filesystems are those which use fscache.
> > Their conversion is pending Dave Howells' rewrite which will make the
> > conversion substantially easier.
> > 
> > I want to thank the reviewers; Dave Chinner, John Hubbard and Christoph
> > Hellwig have done a marvellous job of providing constructive criticism.
> > Eric Biggers pointed out how I'd broken ext4 (which led to a substantial
> > change).  I've tried to take it all on board, but I may have missed
> > something simply because you've done such a thorough job.
> > 
> > This series can also be found at
> > http://git.infradead.org/users/willy/linux-dax.git/shortlog/refs/tags/readahead_v7
> > (I also pushed the readahead_v6 tag there in case anyone wants to diff, and
> > they're both based on 5.6-rc2 so they're easy to diff)
> > 
> > v7:
> >  - Now passes an xfstests run on ext4!
> 
> On btrfs it still chokes on the first test btrfs/001, with the following
> warning, the test is stuck there.

Thanks.  The warning actually wasn't the problem, but it did need to
be addressed.  I got a test system up & running with btrfs, and it's
currently on generic/027 with the following patch:

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 9c782c15f7f7..d23a224d2ad2 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -676,7 +676,7 @@ static inline unsigned int __readahead_batch(struct readahead_control *rac,
 		struct page **array, unsigned int array_sz)
 {
 	unsigned int i = 0;
-	XA_STATE(xas, &rac->mapping->i_pages, rac->_index);
+	XA_STATE(xas, &rac->mapping->i_pages, 0);
 	struct page *page;
 
 	BUG_ON(rac->_batch_count > rac->_nr_pages);
@@ -684,6 +684,8 @@ static inline unsigned int __readahead_batch(struct readahead_control *rac,
 	rac->_index += rac->_batch_count;
 	rac->_batch_count = 0;
 
+	xas_set(&xas, rac->_index);
+	rcu_read_lock();
 	xas_for_each(&xas, page, rac->_index + rac->_nr_pages - 1) {
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
 		VM_BUG_ON_PAGE(PageTail(page), page);
@@ -702,6 +704,7 @@ static inline unsigned int __readahead_batch(struct readahead_control *rac,
 		if (i == array_sz)
 			break;
 	}
+	rcu_read_unlock();
 
 	return i;
 }
