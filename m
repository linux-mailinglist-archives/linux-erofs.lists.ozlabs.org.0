Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B185B97AD
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Sep 2022 11:42:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MSsgT6Z71z3bvd
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Sep 2022 19:42:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=os6+qAq+;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+aa90abf7a61f323a8d2f+6962+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=os6+qAq+;
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MSsgL3xMrz3bZC
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Sep 2022 19:42:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Sn1STluEcmAEl2IDkRqQTtdfy5beUs4WRE2QQKAsD/8=; b=os6+qAq+Yh06rcP0f4OouU/22o
	oWMxav2lmp8ydZQlV6kYJHiVg8ZVYPX5Z5bUp7SoaxqFj/nUS4D885nff+ExvyS+/ZeTUGV4jsgEU
	ER77a8FARvGVxYQc08pU28vamvOLA93UJlOYB+wMD6hJYfaFlwU7gVGEBvA4QBbVOudz8qGi3zl6j
	PD4HWCk7kfMEuJEharZdxwNNq3YjLexhD9ZuJU9XTK/fP5VUj1cnMn1ePeBY44Kxrp22zlpCAneVa
	pYT72nSZOveSvkojw81g64FzZrU9pT28Z+dU81UCAkWPRoOJZqNkQwmhvF/DotA52n+uG+9hsXvG2
	598sGqsQ==;
Received: from [185.122.133.20] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYlNq-005b3C-78; Thu, 15 Sep 2022 09:42:10 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Matthew Wilcox <willy@infradead.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/5] btrfs: add manual PSI accounting for compressed reads
Date: Thu, 15 Sep 2022 10:41:58 +0100
Message-Id: <20220915094200.139713-4-hch@lst.de>
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

btrfs compressed reads try to always read the entire compressed chunk,
even if only a subset is requested.  Currently this is covered by the
magic PSI accounting underneath submit_bio, but that is about to go
away. Instead add manual psi_memstall_{enter,leave} annotations.

Note that for readahead this really should be using readahead_expand,
but the additionals reads are also done for plain ->read_folio where
readahead_expand can't work, so this overall logic is left as-is for
now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: David Sterba <dsterba@suse.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 fs/btrfs/compression.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index e84d22c5c6a83..370788b9b1249 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -15,6 +15,7 @@
 #include <linux/string.h>
 #include <linux/backing-dev.h>
 #include <linux/writeback.h>
+#include <linux/psi.h>
 #include <linux/slab.h>
 #include <linux/sched/mm.h>
 #include <linux/log2.h>
@@ -519,7 +520,8 @@ static u64 bio_end_offset(struct bio *bio)
  */
 static noinline int add_ra_bio_pages(struct inode *inode,
 				     u64 compressed_end,
-				     struct compressed_bio *cb)
+				     struct compressed_bio *cb,
+				     unsigned long *pflags)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	unsigned long end_index;
@@ -588,6 +590,9 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 			continue;
 		}
 
+		if (PageWorkingset(page))
+			psi_memstall_enter(pflags);
+
 		ret = set_page_extent_mapped(page);
 		if (ret < 0) {
 			unlock_page(page);
@@ -674,6 +679,8 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	u64 em_len;
 	u64 em_start;
 	struct extent_map *em;
+	/* Initialize to 1 to make skip psi_memstall_leave unless needed */
+	unsigned long pflags = 1;
 	blk_status_t ret;
 	int ret2;
 	int i;
@@ -729,7 +736,7 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 		goto fail;
 	}
 
-	add_ra_bio_pages(inode, em_start + em_len, cb);
+	add_ra_bio_pages(inode, em_start + em_len, cb, &pflags);
 
 	/* include any pages we added in add_ra-bio_pages */
 	cb->len = bio->bi_iter.bi_size;
@@ -810,6 +817,9 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 		}
 	}
 
+	if (!pflags)
+		psi_memstall_leave(&pflags);
+
 	if (refcount_dec_and_test(&cb->pending_ios))
 		finish_compressed_bio_read(cb);
 	return;
-- 
2.30.2

