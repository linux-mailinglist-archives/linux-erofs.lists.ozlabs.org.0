Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 580E15B97AF
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Sep 2022 11:42:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MSsgY4m2Bz3bcc
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Sep 2022 19:42:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=XCKKlba9;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+aa90abf7a61f323a8d2f+6962+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=XCKKlba9;
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MSsgK5Z1Gz3052
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Sep 2022 19:42:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=SxtVDqdat7BUx/W51wS73TW46FWCaaqoJViREBV0E4g=; b=XCKKlba980yHrEb7U2Z7nxXZcq
	YZzQTA/3rSfLmxP/itoKa1cbxHecjo6lZ+/daLAoQ54ZywDoNmcYhRKQh7BhjSSHYgAkEROhNV0/F
	14GG/i0DGrSzBpEno94+6Ri22JjcTLo6AeQn1wLhshEvNQWMAE80uVSy7lfx0Ic4vGDqbQuJxd+jz
	TiTrR0NISz7uCi8jJpu5X0J1hYZD+scAZRZY54MvRA9w34a9r6/My0FLliJ93QY1RS4/0GnzTnRsB
	BSei3Ct+cvW3zZBM7lACxj9tSoD9XtuX3iLfVJvhdqhe9e4BywOrgFoGIoW0PNpYxnkBWmNGmZv+S
	fkJwuS3g==;
Received: from [185.122.133.20] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYlNk-005b0u-Ql; Thu, 15 Sep 2022 09:42:05 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Matthew Wilcox <willy@infradead.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/5] mm: add PSI accounting around ->read_folio and ->readahead calls
Date: Thu, 15 Sep 2022 10:41:56 +0100
Message-Id: <20220915094200.139713-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220915094200.139713-1-hch@lst.de>
References: <20220915094200.139713-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: linux-mm@kvack.org, Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

PSI tries to account for the cost of bringing back in pages discarded by
the MM LRU management.  Currently the prime place for that is hooked into
the bio submission path, which is a rather bad place:

 - it does not actually account I/O for non-block file systems, of which
   we have many
 - it adds overhead and a layering violation to the block layer

Add the accounting into the two places in the core MM code that read
pages into an address space by calling into ->read_folio and ->readahead
so that the entire file system operations are covered, to broaden
the coverage and allow removing the accounting in the block layer going
forward.

As psi_memstall_enter can deal with nested calls this will not lead to
double accounting even while the bio annotations are still present.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/pagemap.h |  2 ++
 mm/filemap.c            |  7 +++++++
 mm/readahead.c          | 22 ++++++++++++++++++----
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 0178b2040ea38..201dc7281640b 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1173,6 +1173,8 @@ struct readahead_control {
 	pgoff_t _index;
 	unsigned int _nr_pages;
 	unsigned int _batch_count;
+	bool _workingset;
+	unsigned long _pflags;
 };
 
 #define DEFINE_READAHEAD(ractl, f, r, m, i)				\
diff --git a/mm/filemap.c b/mm/filemap.c
index 15800334147b3..c943d1b90cc26 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2382,6 +2382,8 @@ static void filemap_get_read_batch(struct address_space *mapping,
 static int filemap_read_folio(struct file *file, filler_t filler,
 		struct folio *folio)
 {
+	bool workingset = folio_test_workingset(folio);
+	unsigned long pflags;
 	int error;
 
 	/*
@@ -2390,8 +2392,13 @@ static int filemap_read_folio(struct file *file, filler_t filler,
 	 * fails.
 	 */
 	folio_clear_error(folio);
+
 	/* Start the actual read. The read will unlock the page. */
+	if (unlikely(workingset))
+		psi_memstall_enter(&pflags);
 	error = filler(file, folio);
+	if (unlikely(workingset))
+		psi_memstall_leave(&pflags);
 	if (error)
 		return error;
 
diff --git a/mm/readahead.c b/mm/readahead.c
index fdcd28cbd92de..b10f0cf81d804 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -122,6 +122,7 @@
 #include <linux/task_io_accounting_ops.h>
 #include <linux/pagevec.h>
 #include <linux/pagemap.h>
+#include <linux/psi.h>
 #include <linux/syscalls.h>
 #include <linux/file.h>
 #include <linux/mm_inline.h>
@@ -152,6 +153,8 @@ static void read_pages(struct readahead_control *rac)
 	if (!readahead_count(rac))
 		return;
 
+	if (unlikely(rac->_workingset))
+		psi_memstall_enter(&rac->_pflags);
 	blk_start_plug(&plug);
 
 	if (aops->readahead) {
@@ -179,6 +182,9 @@ static void read_pages(struct readahead_control *rac)
 	}
 
 	blk_finish_plug(&plug);
+	if (unlikely(rac->_workingset))
+		psi_memstall_leave(&rac->_pflags);
+	rac->_workingset = false;
 
 	BUG_ON(readahead_count(rac));
 }
@@ -252,6 +258,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 		}
 		if (i == nr_to_read - lookahead_size)
 			folio_set_readahead(folio);
+		ractl->_workingset |= folio_test_workingset(folio);
 		ractl->_nr_pages++;
 	}
 
@@ -480,11 +487,14 @@ static inline int ra_alloc_folio(struct readahead_control *ractl, pgoff_t index,
 	if (index == mark)
 		folio_set_readahead(folio);
 	err = filemap_add_folio(ractl->mapping, folio, index, gfp);
-	if (err)
+	if (err) {
 		folio_put(folio);
-	else
-		ractl->_nr_pages += 1UL << order;
-	return err;
+		return err;
+	}
+
+	ractl->_nr_pages += 1UL << order;
+	ractl->_workingset |= folio_test_workingset(folio);
+	return 0;
 }
 
 void page_cache_ra_order(struct readahead_control *ractl,
@@ -826,6 +836,10 @@ void readahead_expand(struct readahead_control *ractl,
 			put_page(page);
 			return;
 		}
+		if (unlikely(PageWorkingset(page)) && !ractl->_workingset) {
+			ractl->_workingset = true;
+			psi_memstall_enter(&ractl->_pflags);
+		}
 		ractl->_nr_pages++;
 		if (ra) {
 			ra->size++;
-- 
2.30.2

