Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 195B5A47C2
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2019 07:53:39 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Lj7h4ctbzDqsL
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2019 15:53:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1567317216;
	bh=V6v19qYF2PCr2q8Mi69ZYXhsnx7ZrAYv/h7bTxG2DcI=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=IQREHO8f2qBzO7RTDAOAIJjDxMLea01hyvM5t5fgxoaLjfkRLBOmcLlowll4KObVH
	 bm2A9gJepqRjrOvYxnK1kCH1aP4eCGF2bXWk7POEu59parYD4YtokwfgcKtBHao9Kn
	 TvxFH3mhg4ynKKjJEtFQTQaQ+30bxZ0KfL2neRk/JXK2DV8WVeG50JX8QzIfMwnX2J
	 hFLAFJt4rMuxWzATP0e8g6DdYbLJb0gyuTIgY6E6YhO6D4nHAV4GKFn/FDMTDV1r5K
	 TJotFAIf/GsfFeoRz84Xdtzw7e/jpDo/BmTa9T4Cel2bAykYUwdhr6Q4szQaQrv86c
	 SwqYrXVCSPkKg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.69.84; helo=sonic314-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="mXDvfj5D"; 
 dkim-atps=neutral
Received: from sonic314-21.consmr.mail.gq1.yahoo.com
 (sonic314-21.consmr.mail.gq1.yahoo.com [98.137.69.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Lj781wcczDqvK
 for <linux-erofs@lists.ozlabs.org>; Sun,  1 Sep 2019 15:53:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1567317185; bh=A0DY0dOyy+x6psHQtnucMUPA/7zTLDXv/4VtOvMsf7M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=mXDvfj5DLqqp2xN98RuZh5ifhIEu8g+bNGW9bl58VtF1P+86CIukUCl1H8ZOLWFPbEMpqahqk9aVCPDO2UYw8eUGe1QuntRsMQAkHKT7dic75qHlWW0NvqcITHqnJPkc8w6hLd4pTtLeREzbxK7OPX/2nMdTFiEQsXVbRCIuxiufo8YUjYEG+YmJkls1XG52M+VjQqU4iqepUDz9HB86tmkW9+XWr7qYtR4p9/mAww4w+jLJ/fEpTfSvWy8YVk10Kk6lemC1907+hz0M4HFu76MNRLkmo+u0Yy3474pxCuw3CQ1ZhOQo/eN/ClF3uLI3j5zRVjdwV8LaxJQuTvFh6w==
X-YMail-OSG: Uo5Gn0IVM1mBl9ltwDSwr8G3EVOzXFaEgTT7AimYIR5tMcWNx.6xoGHJvJfBdfE
 NYXACcq7NyoJ2Nrqz9M7EpIW619xAL5UGjjL7JWCeMcYcfR8Ch3TlYReWwALafXj9u4TZbCXha_9
 1BOol.e6fMqbQxg1CPVz2.ISiAryydqWwmvhJjAWGk7w_mjAVM22HjLx2t8lkQwR2JyoujrV96fH
 sf58AU2gIILEYg1N_.wpHsEYCdcIEI3By.CMt8ipMqZu7ThjgKHnijNVaQYnBQM67udTnbdjb07W
 41WMgz9BB5gZhBnKC5KGIPim7HutSK2maVLP25C0ElyR64d_yPvIieExVb1mUbSr27zbYmjhylkm
 5lrW7npU_BqqgQJ9_8Telt8XOwwn5HhMT5rxIDiqBm90zFy0GAVpFuNsoepJ5lNK_wCp5FbsLca8
 aJGcxHfvS0thILOaNcx7L8VN2oB731Ol3ow7YBPy0lfCUh.jCOdvoVI9VJ6ndCkSNCc606URc1YD
 7udzlfyM2A_WjK9iaVY8Lk7BTTYpAstPaCx700aoGamtGAd.TN7Ewm_9tRRL.IIo96GmIfRVQsi6
 ZnkwkX6dWRhpyhYfmwnN_WWNIRGOI5fsFGeqwJ_SwmkQ9w52P4wU8j2HSGsWPKfFu.FRzpgLEmOL
 HbDBCOzPmBQ7x803lA0ThaoHH3fmb5HWeY5at90QkzSYaOD9oCia3i3k8zCM2GjV5Z2o3vv7mUXA
 8tS5vkiYVP77IeCSr13anAR2VidmTX5CyPXYeQvoea7.4s7k95PnuQ_OZ8kl3LdeaNZu_FYxiU5n
 qLFLV72ACbRMDIOGroehQu16cDjyZhKKtRQZ9Y_7XRkbkJPwsAYob89BQv0LYDFH.YaWQr__eaqP
 0UlOOGAs9r98K_TEYadFTf.01c3yWEBeDwHPyY9QfWXBwobSohQVG5li4zc6BUJmuR8pyDThzDSg
 td8SjfUd5Y0Zk9XTb633gl0WnzIkVBzzz3QbmUzEObGKVI7Cu7TSeji234KmfPSSzY5LWwU0lL.o
 bfN58UQ2rm7ss8XAB8Ws65eovCKz1DvROqy43IKST.zBrMeKZsg0p4n96Wic_C_1iHu1WbIRU_XZ
 zoCCud.dzxiVSYtBVuMs8PVgc1qKTHzWEcwrRdO4v3Y2Zw_nD8_JXsssoqaW2ctNPCQoQkDFG7vW
 Zx23Y22cbGqpkBY0XJNKFK1p9WNDj9xaAXxjhlHWHEVf5hz08iRbNZYBEtD2d2vFCbb2ggW9NGBD
 e_oAV8CXJGwa_6bFWH_fq9p.bW5Z.3quzw88g2BFgckDqOMnFHA--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic314.consmr.mail.gq1.yahoo.com with HTTP; Sun, 1 Sep 2019 05:53:05 +0000
Received: by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 426e3b5ec1af9e36f409445c51071a70; 
 Sun, 01 Sep 2019 05:53:03 +0000 (UTC)
To: Christoph Hellwig <hch@infradead.org>, Chao Yu <yuchao0@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 15/21] erofs: kill __submit_bio()
Date: Sun,  1 Sep 2019 13:51:24 +0800
Message-Id: <20190901055130.30572-16-hsiangkao@aol.com>
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

As Christoph pointed out [1], "
Why is there __submit_bio which really just obsfucates
what is going on?  Also why is __submit_bio using
bio_set_op_attrs instead of opencode it as the comment
right next to it asks you to? "

Let's use submit_bio directly instead.

[1] https://lore.kernel.org/lkml/20190830162812.GA10694@infradead.org/
Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/data.c     | 15 ++++++++-------
 fs/erofs/internal.h |  9 ++-------
 fs/erofs/zdata.c    |  6 +++---
 3 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 837b07cd2761..d3cd7a453648 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -57,14 +57,15 @@ struct page *erofs_get_meta_page(struct super_block *sb, erofs_blk_t blkaddr)
 	if (!PageUptodate(page)) {
 		struct bio *bio;
 
-		bio = erofs_grab_bio(sb, blkaddr, 1, sb, read_endio);
+		bio = erofs_grab_bio(sb, REQ_OP_READ | REQ_META,
+				     blkaddr, 1, sb, read_endio);
 
 		if (bio_add_page(bio, page, PAGE_SIZE, 0) != PAGE_SIZE) {
 			err = -EFAULT;
 			goto err_out;
 		}
 
-		__submit_bio(bio, REQ_OP_READ, REQ_META);
+		submit_bio(bio);
 		lock_page(page);
 
 		/* this page has been truncated by others */
@@ -188,7 +189,7 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
 	    /* not continuous */
 	    *last_block + 1 != current_block) {
 submit_bio_retry:
-		__submit_bio(bio, REQ_OP_READ, 0);
+		submit_bio(bio);
 		bio = NULL;
 	}
 
@@ -258,7 +259,8 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
 		if (nblocks > BIO_MAX_PAGES)
 			nblocks = BIO_MAX_PAGES;
 
-		bio = erofs_grab_bio(sb, blknr, nblocks, sb, read_endio);
+		bio = erofs_grab_bio(sb, REQ_OP_READ, blknr, nblocks,
+				     sb, read_endio);
 	}
 
 	err = bio_add_page(bio, page, PAGE_SIZE, 0);
@@ -289,8 +291,7 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
 	/* if updated manually, continuous pages has a gap */
 	if (bio)
 submit_bio_out:
-		__submit_bio(bio, REQ_OP_READ, 0);
-
+		submit_bio(bio);
 	return err ? ERR_PTR(err) : NULL;
 }
 
@@ -354,7 +355,7 @@ static int erofs_raw_access_readpages(struct file *filp,
 
 	/* the rare case (end in gaps) */
 	if (bio)
-		__submit_bio(bio, REQ_OP_READ, 0);
+		submit_bio(bio);
 	return 0;
 }
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 40d4dd47bb7a..15545959af92 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -406,6 +406,7 @@ static inline int z_erofs_map_blocks_iter(struct inode *inode,
 
 /* data.c */
 static inline struct bio *erofs_grab_bio(struct super_block *sb,
+					 unsigned int bi_opf,
 					 erofs_blk_t blkaddr,
 					 unsigned int nr_pages,
 					 void *bi_private, bio_end_io_t endio)
@@ -416,16 +417,10 @@ static inline struct bio *erofs_grab_bio(struct super_block *sb,
 	bio_set_dev(bio, sb->s_bdev);
 	bio->bi_iter.bi_sector = (sector_t)blkaddr << LOG_SECTORS_PER_BLOCK;
 	bio->bi_private = bi_private;
+	bio->bi_opf = bi_opf;
 	return bio;
 }
 
-static inline void __submit_bio(struct bio *bio, unsigned int op,
-				unsigned int op_flags)
-{
-	bio_set_op_attrs(bio, op, op_flags);
-	submit_bio(bio);
-}
-
 struct page *erofs_get_meta_page(struct super_block *sb, erofs_blk_t blkaddr);
 
 int erofs_map_blocks(struct inode *, struct erofs_map_blocks *, int);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index abe28565d6c0..ce1a0f2997a9 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1258,12 +1258,12 @@ static bool z_erofs_vle_submit_all(struct super_block *sb,
 
 		if (bio && force_submit) {
 submit_bio_retry:
-			__submit_bio(bio, REQ_OP_READ, 0);
+			submit_bio(bio);
 			bio = NULL;
 		}
 
 		if (!bio) {
-			bio = erofs_grab_bio(sb, first_index + i,
+			bio = erofs_grab_bio(sb, REQ_OP_READ, first_index + i,
 					     BIO_MAX_PAGES, bi_private,
 					     z_erofs_vle_read_endio);
 			++nr_bios;
@@ -1286,7 +1286,7 @@ static bool z_erofs_vle_submit_all(struct super_block *sb,
 	} while (owned_head != Z_EROFS_PCLUSTER_TAIL);
 
 	if (bio)
-		__submit_bio(bio, REQ_OP_READ, 0);
+		submit_bio(bio);
 
 	if (postsubmit_is_all_bypassed(q, nr_bios, force_fg))
 		return true;
-- 
2.17.1

