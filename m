Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC781A47B9
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2019 07:53:29 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Lj7V5f4HzDqsR
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2019 15:53:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1567317206;
	bh=Q0GdPvIGItr9AWXeiO8Zkh2ix5lR62v0Loh9lnNzmPE=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=CXktB3S3C3WEOlTBbAe3XztyBJLBPuM17xAQiRYKoiMV6SzbnuQDPO22O6LN7DB5i
	 KWiYVnaHq/WWcMmEUTODbcn2Jsbez5AChn4PZ2bEDXrQBu94EOpYscCGbjbmrfrWR6
	 2I2ndbWNGN0qv49vjBnPKrhvnKyoAIZMnczxRDhO6lhECWu/V0KThD4e419WbgvmLv
	 h6MMipb27HwLN/R8bKUFxRwh7mK8PQX5FQzrzthwcEaOdJr55Md2ZZuQdDBrrJqO20
	 avOlpKRgH10BoQpHgPmf9GDBVbgQwxZ92qqfu86J5M4RS5x0aAVJxs9Ap/QJ3xShrQ
	 y/xLyw8S5vQHg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.64.146; helo=sonic301-20.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="nsaedDEn"; 
 dkim-atps=neutral
Received: from sonic301-20.consmr.mail.gq1.yahoo.com
 (sonic301-20.consmr.mail.gq1.yahoo.com [98.137.64.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Lj6y5NyTzDqlr
 for <linux-erofs@lists.ozlabs.org>; Sun,  1 Sep 2019 15:52:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1567317177; bh=iKgK3mvVxGQeB6KnRecyHZqxODhGiQC6k6vY5xVKgJQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=nsaedDEnzvXROlfGZibbv/xQVVjG64uU/kX5L2/HF8o1Eu0GISGT2a4pLr1iQo2Mxq4c1xgFfZYlzhyYxbjQmndm/k0x6xSd9RzCCNT6VXOMEkMEcaCxG3czmKUXHDqYLVdV4RAc/S2x/+GQ+4rJU7ma6aA6+lu3Nobq1t59ZhtzUKxmx3DBmyBORKFtP+0avT1qMNcNEj0YrNcHOQZtPr9mlVIds4kOn+P2Mug7PZGs1yGT9gczna/ik/i1+YsjRdh1cEqmm7u6uVWjYSlccW++oBuniIOSq6vh5ID67by3KPqibvpwfW+wRDUqSIUz5HuOhyl67NepnFIM6t73tg==
X-YMail-OSG: N5YY0GsVM1mQoU9e_xpSw.93T6gRUNB9eblDiKCScDMJUpZ6pfP3WlbCr8BNh2s
 Z3KpSv9dEy7SoJqaEzRU_figupwmshXRvHJAUGCZshA9Rtg9S6qwNQkoX659TD5BYauDsW6x5UJ4
 Le9FYRBQA.9IkF3Avg3klqkmQZgzNRt5_4eFcFFH5ywRC.LShIPQ_wPZT2EJKIwz4E9xZWCLuZeu
 xhAdxiZWNsjXNVqi3ebbUOgYlwszNbkjLF1zXPQev0oSNDSnjpHTNtZcedGk.khRIw_CuxaCSV2n
 0KsWf7uqOlzvL6_Q3ZcM2or7HPaDOb8l6tLa7IG_WQ8sL45TkN_DQsOH2QkF3PvRvE86XFJZdVV8
 NAdhL1APBeIA9DSqECsuzqcEdqY5hY1yAnI9GMXXolyMnsvgEvYks7uQdYvH88S93U4flVBgPlf1
 OwAJtjwp6YCreMhQXU.lKE.3syy.9M0.OKJnM00PQzq2E3nr1yjYbYg.tPeyYwn2OTfiLrhl8ENQ
 r8DISzzJFmVwyu8tMRmMpCkWGFvg0P94kWQhOqJJtm64nmCLAFjHyY4EOEdAP.w6cH1y9oF469Io
 U._AC5a8rGkZ4kdE5ayZiNIkUORq7U8BO.HGrcHoQdyCFNsNo.ZiYnFvgDsUECO9VIZB4IpdKTpQ
 oSzsWgwuyc4r5jurgKlIH2TayVcOeqdAUkCnoIiCkHSI3nfYDctUN_V7hBFmzQkK_vU5gYq7okAN
 eyd0YYsPezjqTkrCwpbkLe3M4_c86EM7tCD_BCWY7Mj77GcWmMtJHnZ3fFE8OaO2qiRW1z_J700P
 btSREr2mzdx4XyYJ216bGKaPpb_3yraNwzlwcKY7g38200AetT.exN09JrPbzNeFFmFmht4TTMKI
 3.Y4hY1h_PE09Wc.KVJtRE3KKmVvzeUssWO872SO_dFZfn09xgvYxkkvajQjuZyBkc.9D0sDU2KZ
 0Rac3RLbVnfhzBKCBWX4w0SdvbMHhGp9wEr8vmIJ_EbjIk_e0jCTipFzKEKYRNyjLk_KVlIOB_mU
 8hVKqi7Yw6LbNeQDgNayzSRtAg0hj1etiowfn.dX.46s4w9QGBptCIFjatduGgrSXcDj3Zt2L6_X
 PaDPd0O5nj6qjI1lBQFzSWz7l7dWPGL8nmXK7FSzPoy.B4U4OVghj0NN7oGVSCDP91UbiPg8tqg1
 SllE.nGHXwNEbqD2mlBI06Ayubz9qg40pI6jmajwX08lyoHhamBN.xkIgVZ0OJeEWk0tFTutQPur
 KyDgTw8OI5yQEkdXkIacwvSbZc5P.fD44Xp6u6KDe7RejDDKHEQ--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic301.consmr.mail.gq1.yahoo.com with HTTP; Sun, 1 Sep 2019 05:52:57 +0000
Received: by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 426e3b5ec1af9e36f409445c51071a70; 
 Sun, 01 Sep 2019 05:52:52 +0000 (UTC)
To: Christoph Hellwig <hch@infradead.org>, Chao Yu <yuchao0@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 13/21] erofs: simplify erofs_grab_bio() since bio_alloc()
 never fail
Date: Sun,  1 Sep 2019 13:51:22 +0800
Message-Id: <20190901055130.30572-14-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190901055130.30572-1-hsiangkao@aol.com>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <gaoxiang25@huawei.com>

As Christoph pointed out [1], "erofs_grab_bio tries to
handle a bio_alloc failure, except that the function will
not actually fail due the mempool backing it."

Sorry about useless code, fix it now.

[1] https://lore.kernel.org/lkml/20190830162812.GA10694@infradead.org/
Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/data.c     | 15 ++-------------
 fs/erofs/internal.h | 19 ++-----------------
 fs/erofs/zdata.c    |  2 +-
 3 files changed, 5 insertions(+), 31 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index e2e40ec2bfd1..621954d4fb09 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -62,12 +62,7 @@ struct page *__erofs_get_meta_page(struct super_block *sb,
 	if (!PageUptodate(page)) {
 		struct bio *bio;
 
-		bio = erofs_grab_bio(sb, blkaddr, 1, sb, read_endio, nofail);
-		if (IS_ERR(bio)) {
-			DBG_BUGON(nofail);
-			err = PTR_ERR(bio);
-			goto err_out;
-		}
+		bio = erofs_grab_bio(sb, blkaddr, 1, sb, read_endio);
 
 		if (bio_add_page(bio, page, PAGE_SIZE, 0) != PAGE_SIZE) {
 			err = -EFAULT;
@@ -275,13 +270,7 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
 		if (nblocks > BIO_MAX_PAGES)
 			nblocks = BIO_MAX_PAGES;
 
-		bio = erofs_grab_bio(sb, blknr, nblocks, sb,
-				     read_endio, false);
-		if (IS_ERR(bio)) {
-			err = PTR_ERR(bio);
-			bio = NULL;
-			goto err_out;
-		}
+		bio = erofs_grab_bio(sb, blknr, nblocks, sb, read_endio);
 	}
 
 	err = bio_add_page(bio, page, PAGE_SIZE, 0);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 6bd82a82b11f..01749be24f3d 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -410,24 +410,9 @@ static inline int z_erofs_map_blocks_iter(struct inode *inode,
 static inline struct bio *erofs_grab_bio(struct super_block *sb,
 					 erofs_blk_t blkaddr,
 					 unsigned int nr_pages,
-					 void *bi_private, bio_end_io_t endio,
-					 bool nofail)
+					 void *bi_private, bio_end_io_t endio)
 {
-	const gfp_t gfp = GFP_NOIO;
-	struct bio *bio;
-
-	do {
-		if (nr_pages == 1) {
-			bio = bio_alloc(gfp | (nofail ? __GFP_NOFAIL : 0), 1);
-			if (!bio) {
-				DBG_BUGON(nofail);
-				return ERR_PTR(-ENOMEM);
-			}
-			break;
-		}
-		bio = bio_alloc(gfp, nr_pages);
-		nr_pages /= 2;
-	} while (!bio);
+	struct bio *bio = bio_alloc(GFP_NOIO, nr_pages);
 
 	bio->bi_end_io = endio;
 	bio_set_dev(bio, sb->s_bdev);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index f06a2fad7af2..abe28565d6c0 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1265,7 +1265,7 @@ static bool z_erofs_vle_submit_all(struct super_block *sb,
 		if (!bio) {
 			bio = erofs_grab_bio(sb, first_index + i,
 					     BIO_MAX_PAGES, bi_private,
-					     z_erofs_vle_read_endio, true);
+					     z_erofs_vle_read_endio);
 			++nr_bios;
 		}
 
-- 
2.17.1

