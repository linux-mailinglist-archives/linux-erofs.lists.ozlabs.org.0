Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C1487194B
	for <lists+linux-erofs@lfdr.de>; Tue,  5 Mar 2024 10:15:20 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pC6Tygwp;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TpqfF5X5sz3dV4
	for <lists+linux-erofs@lfdr.de>; Tue,  5 Mar 2024 20:15:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pC6Tygwp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tpqdz1GWfz30gn
	for <linux-erofs@lists.ozlabs.org>; Tue,  5 Mar 2024 20:15:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709630099; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=lShtNtGrB8mCBzJiVbOL4WhuapIFOn1RsN9gwurF4Ig=;
	b=pC6TygwpE7M24aVCDrQ6uwV4q1PAL7MujzrSLHZGIJb6PPYrYUebj75+0kIt4LVSP1ih0lYjWzDo13RIH7UEUJ7RzDGDvbRXOiKJtQ6LmYbeu7kJ/l9LcgfASx0WOirwnSm2IY2Ny4L0Qs9obFY8DwRCg6nAxazeXx3DE3qxfVo=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W1tgGhK_1709630097;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W1tgGhK_1709630097)
          by smtp.aliyun-inc.com;
          Tue, 05 Mar 2024 17:14:58 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 5/6] erofs: convert z_erofs_submissionqueue_endio() to folios
Date: Tue,  5 Mar 2024 17:14:47 +0800
Message-Id: <20240305091448.1384242-5-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240305091448.1384242-1-hsiangkao@linux.alibaba.com>
References: <20240305091448.1384242-1-hsiangkao@linux.alibaba.com>
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

Use bio_for_each_folio() to iterate over each folio in the bio and
there is no large folios for now.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index d78cc54a96f5..63990c8192f2 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1566,19 +1566,19 @@ static void z_erofs_submissionqueue_endio(struct bio *bio)
 {
 	struct z_erofs_decompressqueue *q = bio->bi_private;
 	blk_status_t err = bio->bi_status;
-	struct bio_vec *bvec;
-	struct bvec_iter_all iter_all;
+	struct folio_iter fi;
 
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		struct page *page = bvec->bv_page;
+	bio_for_each_folio_all(fi, bio) {
+		struct folio *folio = fi.folio;
 
-		DBG_BUGON(PageUptodate(page));
-		DBG_BUGON(z_erofs_page_is_invalidated(page));
-		if (erofs_page_is_managed(EROFS_SB(q->sb), page)) {
-			if (!err)
-				SetPageUptodate(page);
-			unlock_page(page);
-		}
+		DBG_BUGON(folio_test_uptodate(folio));
+		DBG_BUGON(z_erofs_page_is_invalidated(&folio->page));
+		if (!erofs_page_is_managed(EROFS_SB(q->sb), &folio->page))
+			continue;
+
+		if (!err)
+			folio_mark_uptodate(folio);
+		folio_unlock(folio);
 	}
 	if (err)
 		q->eio = true;
-- 
2.39.3

