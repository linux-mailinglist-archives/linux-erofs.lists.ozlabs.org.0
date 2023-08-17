Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9115777F21D
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Aug 2023 10:28:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RRJ7V3sNJz3cN4
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Aug 2023 18:28:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RRJ761f4Nz2ytV
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Aug 2023 18:28:33 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vpz9R34_1692260908;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vpz9R34_1692260908)
          by smtp.aliyun-inc.com;
          Thu, 17 Aug 2023 16:28:29 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 7/8] erofs: adapt folios for z_erofs_readahead()
Date: Thu, 17 Aug 2023 16:28:12 +0800
Message-Id: <20230817082813.81180-7-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
References: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

It's a straight-forward conversion except that readahead_folio()
will do folio_put() in advance but it doesn't matter since folios
are still locked.

As before, since file-backed folios (pages for now) are locked, so
we could temporarily use folio->private as an internal counter to
indicate split parts of each folio for the corresponding pclusters
to decompress.

When such counter becomes zero, the folio will be finally unlocked
(see compress.h and z_erofs_onlinepage_endio()).

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index c28945532a02..79cadb88e8bf 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1852,37 +1852,35 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	struct inode *const inode = rac->mapping->host;
 	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
-	struct page *head = NULL, *page;
-	unsigned int nr_pages;
+	struct folio *head = NULL, *folio;
+	unsigned int nr_folios;
+	int err;
 
 	f.headoffset = readahead_pos(rac);
 
 	z_erofs_pcluster_readmore(&f, rac, true);
-	nr_pages = readahead_count(rac);
-	trace_erofs_readpages(inode, readahead_index(rac), nr_pages, false);
+	nr_folios = readahead_count(rac);
+	trace_erofs_readpages(inode, readahead_index(rac), nr_folios, false);
 
-	while ((page = readahead_page(rac))) {
-		set_page_private(page, (unsigned long)head);
-		head = page;
+	while ((folio = readahead_folio(rac))) {
+		folio->private = head;
+		head = folio;
 	}
 
+	/* traverse in reverse order for best metadata I/O performance */
 	while (head) {
-		struct page *page = head;
-		int err;
-
-		/* traversal in reverse order */
-		head = (void *)page_private(page);
+		folio = head;
+		head = folio_get_private(folio);
 
-		err = z_erofs_do_read_page(&f, page);
+		err = z_erofs_do_read_page(&f, &folio->page);
 		if (err && err != -EINTR)
-			erofs_err(inode->i_sb, "readahead error %d @ %lu of nid %llu",
-				  err, page->index, EROFS_I(inode)->nid);
-		put_page(page);
+			erofs_err(inode->i_sb, "readahead error at folio %lu @ nid %llu",
+				  folio->index, EROFS_I(inode)->nid);
 	}
 	z_erofs_pcluster_readmore(&f, rac, false);
 	z_erofs_pcluster_end(&f);
 
-	z_erofs_runqueue(&f, z_erofs_is_sync_decompress(sbi, nr_pages), true);
+	z_erofs_runqueue(&f, z_erofs_is_sync_decompress(sbi, nr_folios), true);
 	erofs_put_metabuf(&f.map.buf);
 	erofs_release_pages(&f.pagepool);
 }
-- 
2.24.4

