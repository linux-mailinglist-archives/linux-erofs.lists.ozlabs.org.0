Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B4C5B97B1
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Sep 2022 11:42:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MSsgh24Bxz3bkh
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Sep 2022 19:42:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LBYTaNgK;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+aa90abf7a61f323a8d2f+6962+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LBYTaNgK;
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MSsgM5npYz3052
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Sep 2022 19:42:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=zSqQSYiG/yhGt5jVAkpLYmREyG39C2nKNIUNc2bjsak=; b=LBYTaNgK69SCGNd0NypzW88Xv5
	Yx58YrbfYXYM3VU1TTaXmnHJhmAosi9GxG5fHizuaiSpsfQyyTrQq+gWKQKGswDMr3IXN1ZrWzMVP
	UY1tiT8IDnZgbhBOAQ3xCJ+2VZ7AX9J7984+cTjW67hOwi9a/fxdM4uq9b3MQocffDqEAIF78Qo78
	gqCr/pS8eAu+ePAIAL48Nsgbsq1v9+2L+IYizWE+7uXKkal5cK3KhOBwcusamcfxoDVeuG3s8KEDX
	vjUdj6mQwI2K2tNhBci5SxLXAld8gZc6Vz+gdOMjtgn/GsCCBLZKbXJ5lYzK1oAc2wfdMZD/5hqfX
	L5xq1muA==;
Received: from [185.122.133.20] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYlNs-005b4u-GP; Thu, 15 Sep 2022 09:42:13 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Matthew Wilcox <willy@infradead.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4/5] erofs: add manual PSI accounting for the compressed address space
Date: Thu, 15 Sep 2022 10:41:59 +0100
Message-Id: <20220915094200.139713-5-hch@lst.de>
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
Cc: linux-mm@kvack.org, Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org, Chris Mason <clm@fb.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

erofs uses an additional address space for compressed data read from disk
in addition to the one directly associated with the inode.  Reading into
the lower address space is open coded using add_to_page_cache_lru instead
of using the filemap.c helper for page allocation micro-optimizations,
which means it is not covered by the MM PSI annotations for ->read_folio
and ->readahead, so add manual ones instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Gao Xiang <hsiangkao@linux.alibaba.com>
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

