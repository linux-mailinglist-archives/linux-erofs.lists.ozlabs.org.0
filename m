Return-Path: <linux-erofs+bounces-1373-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D578C5C733
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Nov 2025 11:07:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d7CVP1nlbz3046;
	Fri, 14 Nov 2025 21:07:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763114829;
	cv=none; b=BF6syz5iESl/pAsVcOa09a8dIQ5sIeCnlB5G2tvKc93NcxTekxFPDcULhFKjGQ/0SJJfXDwh34b/OmEzgQ90pMKy8Xw8UBamwghS8krzuciDb6SC4yPCcaOiIO6ydJL8nSTHn1jb5k4rSLAF026xtVXM3fn099z13m+BS/0Q719wKdK8kGCWaVj/sb41+pfk0M2N9U45eJQ34uRDe+P3zVzPAaomykvVRQRA5UspGeqnOn5VOIN1WuPmRr9DAV6d9Shq6R32vlhemdS9VDRWnA6XktWQh1NZNmbWP02vJ6mpfHedneQBrl4nXnnrBhuzCKbFDmQ0WegKaLWHqkYX7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763114829; c=relaxed/relaxed;
	bh=taDPXuSohFIbjKqHNC7TAvBRm/MUsJxB6CrB2qYxkis=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F88nR0DwFfgdaUvzu+hzZaycexpjljpxmIt/89SaW0CAeMGCyP6ml5dmBEjODbEMnEpSx2E/BvfICISZ5eWrlylmhJCbjZ2IsT/UNpyHBQNzt2VPvEU4/f/gbtV4KCiyubp1z4Xn28RE3AsMVw6gMfBnryKnfvOhu7Gvqy6kKlmjS+79gPu7G5yM2Ldu/l9T7CqMoNkdoPOBiiPjNYOikGU4cdMzEiNYYuMGEq2oicZvR+vokNRyTFt+Yoh6ZajADtQqXqJk+aDUrTrXZhoMTkrB2ZlET1WkAHqz4TFfo3w62FpYwd6ZoXA32ZozSvhCZzb2J/T2g+f4C7R/XGSKoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=EV8iVJoK; dkim-atps=neutral; spf=pass (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=EV8iVJoK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d7CVF2Wf4z301X
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Nov 2025 21:07:01 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=taDPXuSohFIbjKqHNC7TAvBRm/MUsJxB6CrB2qYxkis=;
	b=EV8iVJoK7ecc8euILR3Ko+h8dtrSgWNrVnjY8Vcmao3+AkMEaU8pATbmZEDpmMiRkSTdu+Gsa
	XMaew/zvJVirMT6LwmE63XorCDRwkPo+twFwkod6zJj3F1uqtPl3HEG9Kz0Ofnj4roJDk+bxCX2
	9s4ydz0TIyD24QrPdbVnaZc=
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4d7CSB3S9cz1prLM;
	Fri, 14 Nov 2025 18:05:14 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id CFF9C14035E;
	Fri, 14 Nov 2025 18:06:55 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 14 Nov
 2025 18:06:55 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<djwong@kernel.org>, <amir73il@gmail.com>, <joannelkoong@gmail.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v8 2/9] erofs: hold read context in iomap_iter if needed
Date: Fri, 14 Nov 2025 09:55:09 +0000
Message-ID: <20251114095516.207555-3-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20251114095516.207555-1-lihongbo22@huawei.com>
References: <20251114095516.207555-1-lihongbo22@huawei.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.174.162]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Uncoming page cache sharing needs pass read context to iomap_iter,
here we unify the way of passing the read context in EROFS. Moreover,
bmap and fiemap don't need to map the inline data.

Note that we keep `struct page *` in `struct erofs_iomap_iter_ctx` as
well to avoid bogus kmap_to_page usage.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/erofs/data.c | 79 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 59 insertions(+), 20 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index bb13c4cb8455..bd3d85c61341 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -266,14 +266,23 @@ void erofs_onlinefolio_end(struct folio *folio, int err, bool dirty)
 	folio_end_read(folio, !(v & BIT(EROFS_ONLINEFOLIO_EIO)));
 }
 
+struct erofs_iomap_iter_ctx {
+	struct page *page;
+	void *base;
+};
+
 static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
 {
 	int ret;
+	struct erofs_iomap_iter_ctx *ctx;
 	struct super_block *sb = inode->i_sb;
 	struct erofs_map_blocks map;
 	struct erofs_map_dev mdev;
+	struct iomap_iter *iter;
 
+	iter = container_of(iomap, struct iomap_iter, iomap);
+	ctx = iter->private;
 	map.m_la = offset;
 	map.m_llen = length;
 	ret = erofs_map_blocks(inode, &map);
@@ -283,7 +292,8 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	iomap->offset = map.m_la;
 	iomap->length = map.m_llen;
 	iomap->flags = 0;
-	iomap->private = NULL;
+	if (ctx)
+		ctx->base = NULL;
 	iomap->addr = IOMAP_NULL_ADDR;
 	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
 		iomap->type = IOMAP_HOLE;
@@ -309,16 +319,20 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	}
 
 	if (map.m_flags & EROFS_MAP_META) {
-		void *ptr;
-		struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
-
 		iomap->type = IOMAP_INLINE;
-		ptr = erofs_read_metabuf(&buf, sb, map.m_pa,
-					 erofs_inode_in_metabox(inode));
-		if (IS_ERR(ptr))
-			return PTR_ERR(ptr);
-		iomap->inline_data = ptr;
-		iomap->private = buf.base;
+		/* read context should read the inlined data */
+		if (ctx) {
+			void *ptr;
+			struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
+
+			ptr = erofs_read_metabuf(&buf, sb, map.m_pa,
+						 erofs_inode_in_metabox(inode));
+			if (IS_ERR(ptr))
+				return PTR_ERR(ptr);
+			iomap->inline_data = ptr;
+			ctx->page = buf.page;
+			ctx->base = buf.base;
+		}
 	} else {
 		iomap->type = IOMAP_MAPPED;
 	}
@@ -328,18 +342,19 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 static int erofs_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 		ssize_t written, unsigned int flags, struct iomap *iomap)
 {
-	void *ptr = iomap->private;
+	struct erofs_iomap_iter_ctx *ctx;
+	struct iomap_iter *iter;
 
-	if (ptr) {
+	iter = container_of(iomap, struct iomap_iter, iomap);
+	ctx = iter->private;
+	if (ctx && ctx->base) {
 		struct erofs_buf buf = {
-			.page = kmap_to_page(ptr),
-			.base = ptr,
+			.page = ctx->page,
+			.base = ctx->base,
 		};
 
 		DBG_BUGON(iomap->type != IOMAP_INLINE);
 		erofs_put_metabuf(&buf);
-	} else {
-		DBG_BUGON(iomap->type == IOMAP_INLINE);
 	}
 	return written;
 }
@@ -369,18 +384,36 @@ int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
  */
 static int erofs_read_folio(struct file *file, struct folio *folio)
 {
+	struct iomap_read_folio_ctx read_ctx = {
+		.ops		= &iomap_bio_read_ops,
+		.cur_folio	= folio,
+	};
+	struct erofs_iomap_iter_ctx iter_ctx = {
+		.page		= NULL,
+		.base		= NULL,
+	};
+
 	trace_erofs_read_folio(folio, true);
 
-	iomap_bio_read_folio(folio, &erofs_iomap_ops);
+	iomap_read_folio(&erofs_iomap_ops, &read_ctx, &iter_ctx);
 	return 0;
 }
 
 static void erofs_readahead(struct readahead_control *rac)
 {
+	struct iomap_read_folio_ctx read_ctx = {
+		.ops		= &iomap_bio_read_ops,
+		.rac		= rac,
+	};
+	struct erofs_iomap_iter_ctx iter_ctx = {
+		.page		= NULL,
+		.base		= NULL,
+	};
+
 	trace_erofs_readahead(rac->mapping->host, readahead_index(rac),
 					readahead_count(rac), true);
 
-	iomap_bio_readahead(rac, &erofs_iomap_ops);
+	iomap_readahead(&erofs_iomap_ops, &read_ctx, &iter_ctx);
 }
 
 static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
@@ -400,9 +433,15 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	if (IS_DAX(inode))
 		return dax_iomap_rw(iocb, to, &erofs_iomap_ops);
 #endif
-	if ((iocb->ki_flags & IOCB_DIRECT) && inode->i_sb->s_bdev)
+	if ((iocb->ki_flags & IOCB_DIRECT) && inode->i_sb->s_bdev) {
+		struct erofs_iomap_iter_ctx iter_ctx = {
+			.page = NULL,
+			.base = NULL,
+		};
+
 		return iomap_dio_rw(iocb, to, &erofs_iomap_ops,
-				    NULL, 0, NULL, 0);
+				    NULL, 0, &iter_ctx, 0);
+	}
 	return filemap_read(iocb, to, 0);
 }
 
-- 
2.22.0


