Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 919DF5B44C9
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Sep 2022 08:51:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MPk6v3kqRz3bkb
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Sep 2022 16:51:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TY6vqRLM;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+74593d5eb0e0b46c37a4+6957+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN>)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MPk6S3rW8z2yyT
	for <linux-erofs@lists.ozlabs.org>; Sat, 10 Sep 2022 16:51:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=fQqaIwOPxSuMna00dQRnvLHVvXRo+zAlkdWprGAd+Cc=; b=TY6vqRLMJhvweO+6nWY/Yk6QCH
	2wbbFyPkYsHGjWKYBe7GnKXWBeP7BegsJdll9FnrtOthJp4dUf1Kvsl5a/qlVyFhFhLHEPwEE0WQL
	wDaXd5YpJFiR0RumNIFaRd1Po+fn9GcxeyCCNfN1fJY7mmjO9rTpn8caq4TXFBBayzRcOc6bu4NKh
	IoDNIXl5IexFES5+qwaLTG71wyLwN1NbONFzYKyCJUeec2R61kCjzTUcXjZLj0pLvBFd+WW7ty19m
	JKcjT5Dzix0LV4x4Q6R9PV7MhsSEKNMJR6LZPTnwjwtyUHob7eNK6sy3hKBwQOGcSJCPj2NHLWdC9
	4OgUvzQQ==;
Received: from [2001:4bb8:198:38af:e8dc:dbbd:a9d:5c54] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWuKj-006pb8-02; Sat, 10 Sep 2022 06:51:17 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Matthew Wilcox <willy@infradead.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4/5] erofs: add manual PSI accounting for the compressed address space
Date: Sat, 10 Sep 2022 08:50:57 +0200
Message-Id: <20220910065058.3303831-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220910065058.3303831-1-hch@lst.de>
References: <20220910065058.3303831-1-hch@lst.de>
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

erofs uses an additional address space for compressed data read from disk
in addition to the one directly associated with the inode.  Reading into
the lower address space is open coded using add_to_page_cache_lru instead
of using the filemap.c helper for page allocation micro-optimizations,
which means it is not covered by the MM PSI annotations for ->read_folio
and ->readahead, so add manual ones instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/erofs/zdata.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 5792ca9e0d5ef..143a101a36887 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -7,6 +7,7 @@
 #include "zdata.h"
 #include "compress.h"
 #include <linux/prefetch.h>
+#include <linux/psi.h>
 
 #include <trace/events/erofs.h>
 
@@ -1365,6 +1366,8 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 	struct block_device *last_bdev;
 	unsigned int nr_bios = 0;
 	struct bio *bio = NULL;
+	/* initialize to 1 to make skip psi_memstall_leave unless needed */
+	unsigned long pflags = 1;
 
 	bi_private = jobqueueset_init(sb, q, fgq, force_fg);
 	qtail[JQ_BYPASS] = &q[JQ_BYPASS]->head;
@@ -1414,10 +1417,15 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 			if (bio && (cur != last_index + 1 ||
 				    last_bdev != mdev.m_bdev)) {
 submit_bio_retry:
+				if (!pflags)
+					psi_memstall_leave(&pflags);
 				submit_bio(bio);
 				bio = NULL;
 			}
 
+			if (unlikely(PageWorkingset(page)))
+				psi_memstall_enter(&pflags);
+
 			if (!bio) {
 				bio = bio_alloc(mdev.m_bdev, BIO_MAX_VECS,
 						REQ_OP_READ, GFP_NOIO);
@@ -1445,8 +1453,11 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 			move_to_bypass_jobqueue(pcl, qtail, owned_head);
 	} while (owned_head != Z_EROFS_PCLUSTER_TAIL);
 
-	if (bio)
+	if (bio) {
+		if (!pflags)
+			psi_memstall_leave(&pflags);
 		submit_bio(bio);
+	}
 
 	/*
 	 * although background is preferred, no one is pending for submission.
-- 
2.30.2

