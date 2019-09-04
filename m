Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EAEA789F
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Sep 2019 04:12:34 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46NS5B74pCzDqlr
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Sep 2019 12:12:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.191; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46NS373HJPzDqlS
 for <linux-erofs@lists.ozlabs.org>; Wed,  4 Sep 2019 12:10:43 +1000 (AEST)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id B042EC183FF5ADEC2FEC;
 Wed,  4 Sep 2019 10:10:40 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 4 Sep 2019
 10:10:33 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@lst.de>,
 <devel@driverdev.osuosl.org>
Subject: [PATCH v2 25/25] erofs: use read_cache_page_gfp for
 erofs_get_meta_page
Date: Wed, 4 Sep 2019 10:09:12 +0800
Message-ID: <20190904020912.63925-26-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904020912.63925-1-gaoxiang25@huawei.com>
References: <20190901055130.30572-1-hsiangkao@aol.com>
 <20190904020912.63925-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
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
Cc: linux-fsdevel@vger.kernel.org, Miao Xie <miaoxie@huawei.com>,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

As Christoph said [1], "I'd much prefer to just use
read_cache_page_gfp, and live with the fact that this
allocates bufferheads behind you for now.  I'll try to
speed up my attempts to get rid of the buffer heads on
the block device mapping instead. "

This simplifies the code a lot and a minor thing is
"no REQ_META (e.g. for blktrace) on metadata at all..."

[1] https://lore.kernel.org/r/20190903153704.GA2201@infradead.org/
Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/data.c | 70 +++++++------------------------------------------
 1 file changed, 9 insertions(+), 61 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index eb7bbae89ed0..8a9fcbd0e8ac 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -32,71 +32,13 @@ static void erofs_readendio(struct bio *bio)
 	bio_put(bio);
 }
 
-static struct bio *erofs_grab_raw_bio(struct super_block *sb,
-				      erofs_blk_t blkaddr,
-				      unsigned int nr_pages,
-				      bool ismeta)
-{
-	struct bio *bio = bio_alloc(GFP_NOIO, nr_pages);
-
-	bio->bi_end_io = erofs_readendio;
-	bio_set_dev(bio, sb->s_bdev);
-	bio->bi_iter.bi_sector = (sector_t)blkaddr << LOG_SECTORS_PER_BLOCK;
-	if (ismeta)
-		bio->bi_opf = REQ_OP_READ | REQ_META;
-	else
-		bio->bi_opf = REQ_OP_READ;
-
-	return bio;
-}
-
 struct page *erofs_get_meta_page(struct super_block *sb, erofs_blk_t blkaddr)
 {
 	struct inode *const bd_inode = sb->s_bdev->bd_inode;
 	struct address_space *const mapping = bd_inode->i_mapping;
-	const gfp_t gfp = mapping_gfp_constraint(mapping, ~__GFP_FS);
-	struct page *page;
-	int err;
-
-repeat:
-	page = find_or_create_page(mapping, blkaddr, gfp);
-	if (!page)
-		return ERR_PTR(-ENOMEM);
-
-	DBG_BUGON(!PageLocked(page));
-
-	if (!PageUptodate(page)) {
-		struct bio *bio;
-
-		bio = erofs_grab_raw_bio(sb, blkaddr, 1, true);
-
-		if (bio_add_page(bio, page, PAGE_SIZE, 0) != PAGE_SIZE) {
-			err = -EFAULT;
-			goto err_out;
-		}
-
-		submit_bio(bio);
-		lock_page(page);
 
-		/* this page has been truncated by others */
-		if (page->mapping != mapping) {
-			unlock_page(page);
-			put_page(page);
-			goto repeat;
-		}
-
-		/* more likely a read error */
-		if (!PageUptodate(page)) {
-			err = -EIO;
-			goto err_out;
-		}
-	}
-	return page;
-
-err_out:
-	unlock_page(page);
-	put_page(page);
-	return ERR_PTR(err);
+	return read_cache_page_gfp(mapping, blkaddr,
+				   mapping_gfp_constraint(mapping, ~__GFP_FS));
 }
 
 static int erofs_map_blocks_flatmode(struct inode *inode,
@@ -272,7 +214,13 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
 		if (nblocks > BIO_MAX_PAGES)
 			nblocks = BIO_MAX_PAGES;
 
-		bio = erofs_grab_raw_bio(sb, blknr, nblocks, false);
+		bio = bio_alloc(GFP_NOIO, nblocks);
+
+		bio->bi_end_io = erofs_readendio;
+		bio_set_dev(bio, sb->s_bdev);
+		bio->bi_iter.bi_sector = (sector_t)blknr <<
+			LOG_SECTORS_PER_BLOCK;
+		bio->bi_opf = REQ_OP_READ;
 	}
 
 	err = bio_add_page(bio, page, PAGE_SIZE, 0);
-- 
2.17.1

