Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2455E1927A7
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Mar 2020 13:03:16 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48nRb52cJ2zDqk5
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Mar 2020 23:03:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48nRZp2XVGzDqfZ
 for <linux-erofs@lists.ozlabs.org>; Wed, 25 Mar 2020 23:02:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=547A7ZAoUu2JDJ2ptSJ8vxecAwOtjI/NDzIFsvFTzXo=; b=QvbtCWiIh5Xi5+8xr7F3LHchs/
 /enb5Ja0xjCQg6d/l+MMlIiwXqB1vmDvW34OsfyaSVHmfQx5kxyhZIn0FH5/13KsLe0hUWrGWbB2g
 sxNran2m7QzQfFcu/qurUajS+kK4kEiY6Nojd22Yoyfhsr09GRoJw/fKvlcE/cgG6L+etNC0U3vkq
 0DIgu/p6cickFzYi2VQqX4rMn0g6k0JEQQFCQ8RoqdCtQshCfS8K0j4G2044VrBkohrju2ToJ8dze
 6LtjdH/dgtWCSE8hybN/l8eLj9N52oB+rKd+z7jbkSCM2Y9hSv9O3RaK4nV1mItf8R8C4rGnL9moV
 mHDZZ7Cg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jH4kI-0002HH-Er; Wed, 25 Mar 2020 12:02:54 +0000
Date: Wed, 25 Mar 2020 05:02:54 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v10 24/25] fuse: Convert from readpages to readahead
Message-ID: <20200325120254.GA22483@bombadil.infradead.org>
References: <20200323202259.13363-1-willy@infradead.org>
 <20200323202259.13363-25-willy@infradead.org>
 <CAJfpegu7EFcWrg3bP+-2BX_kb52RrzBCo_U3QKYzUkZfe4EjDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegu7EFcWrg3bP+-2BX_kb52RrzBCo_U3QKYzUkZfe4EjDA@mail.gmail.com>
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
Cc: linux-xfs <linux-xfs@vger.kernel.org>,
 William Kucharski <william.kucharski@oracle.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com,
 Dave Chinner <dchinner@redhat.com>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Mar 25, 2020 at 10:42:56AM +0100, Miklos Szeredi wrote:
> > +       while ((page = readahead_page(rac))) {
> > +               if (fuse_readpages_fill(&data, page) != 0)
> 
> Shouldn't this unlock + put page on error?

We're certainly inconsistent between the two error exits from
fuse_readpages_fill().  But I think we can simplify the whole thing
... how does this look to you?

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 5749505bcff6..57ea9a364e62 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -915,76 +915,32 @@ static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file)
 	fuse_readpages_end(fc, &ap->args, err);
 }
 
-struct fuse_fill_data {
-	struct fuse_io_args *ia;
-	struct file *file;
-	struct inode *inode;
-	unsigned int nr_pages;
-	unsigned int max_pages;
-};
-
-static int fuse_readpages_fill(struct fuse_fill_data *data, struct page *page)
-{
-	struct fuse_io_args *ia = data->ia;
-	struct fuse_args_pages *ap = &ia->ap;
-	struct inode *inode = data->inode;
-	struct fuse_conn *fc = get_fuse_conn(inode);
-
-	fuse_wait_on_page_writeback(inode, page->index);
-
-	if (ap->num_pages &&
-	    (ap->num_pages == fc->max_pages ||
-	     (ap->num_pages + 1) * PAGE_SIZE > fc->max_read ||
-	     ap->pages[ap->num_pages - 1]->index + 1 != page->index)) {
-		data->max_pages = min_t(unsigned int, data->nr_pages,
-					fc->max_pages);
-		fuse_send_readpages(ia, data->file);
-		data->ia = ia = fuse_io_alloc(NULL, data->max_pages);
-		if (!ia)
-			return -ENOMEM;
-		ap = &ia->ap;
-	}
-
-	if (WARN_ON(ap->num_pages >= data->max_pages)) {
-		unlock_page(page);
-		fuse_io_free(ia);
-		return -EIO;
-	}
-
-	ap->pages[ap->num_pages] = page;
-	ap->descs[ap->num_pages].length = PAGE_SIZE;
-	ap->num_pages++;
-	data->nr_pages--;
-	return 0;
-}
-
 static void fuse_readahead(struct readahead_control *rac)
 {
 	struct inode *inode = rac->mapping->host;
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	struct fuse_fill_data data;
-	struct page *page;
 
 	if (is_bad_inode(inode))
 		return;
 
-	data.file = rac->file;
-	data.inode = inode;
-	data.nr_pages = readahead_count(rac);
-	data.max_pages = min_t(unsigned int, data.nr_pages, fc->max_pages);
-	data.ia = fuse_io_alloc(NULL, data.max_pages);
-	if (!data.ia)
-		return;
+	while (readahead_count(rac)) {
+		struct fuse_io_args *ia;
+		struct fuse_args_pages *ap;
+		unsigned int i, nr_pages;
 
-	while ((page = readahead_page(rac))) {
-		if (fuse_readpages_fill(&data, page) != 0)
+		nr_pages = min(readahead_count(rac), fc->max_pages);
+		ia = fuse_io_alloc(NULL, nr_pages);
+		if (!ia)
 			return;
+		ap = &ia->ap;
+		__readahead_batch(rac, ap->pages, nr_pages);
+		for (i = 0; i < nr_pages; i++) {
+			fuse_wait_on_page_writeback(inode, ap->pages[i]->index);
+			ap->descs[i].length = PAGE_SIZE;
+		}
+		ap->num_pages = nr_pages;
+		fuse_send_readpages(ia, rac->file);
 	}
-
-	if (data.ia->ap.num_pages)
-		fuse_send_readpages(data.ia, rac->file);
-	else
-		fuse_io_free(data.ia);
 }
 
 static ssize_t fuse_cache_read_iter(struct kiocb *iocb, struct iov_iter *to)
