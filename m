Return-Path: <linux-erofs+bounces-1397-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 154E5C64651
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Nov 2025 14:37:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d981j62txz2yvM;
	Tue, 18 Nov 2025 00:37:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.222
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763386649;
	cv=none; b=Xnx8odP5TSzIiaKikfv41NeL3QLcdchw5D8+QQD+xCpZO1YOD4imKBeXUvQ6hW5ycuwkRASKTlERNZdZhcerb6+SjEgWQRPTzIb99CLKmk+DReBAschcUv57SbitTFWwAriTrrg2xenOj5/Rd/5ya2u1q4Hq8w/27XDUqXSee5fr/HdvTDSMLC1YEpmtdl3OJNFZ8qwYp5CtfOfrvlFJAc/VK9dGXSecPgW1PCm54ZccxmvhjYnJ3T1aS6T4Ng4EvLYSoFORPP/xfaqe9IFj05NE/Y6YqImYPZi3YGqq9uHlRUe91epgUQ0w0e4Nx7y2wG6PLBJTTA7p2fQdiqMItg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763386649; c=relaxed/relaxed;
	bh=vU6EJAy0LzGznIOrPjQLaa18klM/ZD1fI+JTkKlV6BU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CR0MGAf0/R5Kxrzi8BOUE7w7CkrbyTG4dQbjGwa/Ilu/NvB/GW3hN0e7u85QQ2tX0wS9JBaac019PMocZVeVZz5uEt0SDijfu0ZGHwbItfOxYJonf7wV2cjcLUMobSykFAXKjkvVAhHu1jLdpg0JV7NwbUaYYkEf+khhG9+r6B6PrUSF97l3Rq/KomLuQPNOBRt/xC+HiurgAT/H0V1DH2AlJdu/fC0YzF103E/mKEF2558YtUQInKg8eOOVtEG8d3CtT2EZEqXcyYwtQruGrLlgeSagcXHDjwgt6Or8meNX+lOm+YdmKto2Mtl2ZUWUX+viM6Y8N+dJGTWznVs4gw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=f6aakdSN; dkim-atps=neutral; spf=pass (client-ip=113.46.200.222; helo=canpmsgout07.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=f6aakdSN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.222; helo=canpmsgout07.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d981d1zzkz304h
	for <linux-erofs@lists.ozlabs.org>; Tue, 18 Nov 2025 00:37:25 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=vU6EJAy0LzGznIOrPjQLaa18klM/ZD1fI+JTkKlV6BU=;
	b=f6aakdSNbQueOa3f+ZI/EEU7cWYT96Fbg8l2aQim9xeUvHRcv3ouCihqRFyYJgVzMzJ1qHECA
	NvXGFDhH2WlOqf+7SJ88Yb7nMVFTwulSfqgu78YKG4v1UTh+YpFIVh06BiUqlF4V0UMysBYMYvP
	ddNtYj5L05/B6/mSV9tNClU=
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4d97zV1Cs6zLlXd;
	Mon, 17 Nov 2025 21:35:34 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 7AB60140113;
	Mon, 17 Nov 2025 21:37:16 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 17 Nov
 2025 21:37:15 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<djwong@kernel.org>, <amir73il@gmail.com>, <joannelkoong@gmail.com>
CC: <lihongbo22@huawei.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 02/10] erofs: hold read context in iomap_iter if needed
Date: Mon, 17 Nov 2025 13:25:29 +0000
Message-ID: <20251117132537.227116-3-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20251117132537.227116-1-lihongbo22@huawei.com>
References: <20251117132537.227116-1-lihongbo22@huawei.com>
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
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Introduce `struct erofs_iomap_iter_ctx` to hold both `struct page *`
and `void *base`, avoiding bogus use of `kmap_to_page()` in
`erofs_iomap_end()`.

With this change, fiemap and bmap no longer need to read inline data.

Additionally, the upcoming page cache sharing mechanism requires
passing the backing inode pointer to `erofs_iomap_{begin,end}()`, as
I/O accesses must apply to backing inodes rather than anon inodes.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/erofs/data.c | 67 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 46 insertions(+), 21 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index bb13c4cb8455..71e23d91123d 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -266,13 +266,20 @@ void erofs_onlinefolio_end(struct folio *folio, int err, bool dirty)
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
-	int ret;
+	struct iomap_iter *iter = container_of(iomap, struct iomap_iter, iomap);
+	struct erofs_iomap_iter_ctx *ctx = iter->private;
 	struct super_block *sb = inode->i_sb;
 	struct erofs_map_blocks map;
 	struct erofs_map_dev mdev;
+	int ret;
 
 	map.m_la = offset;
 	map.m_llen = length;
@@ -283,7 +290,6 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	iomap->offset = map.m_la;
 	iomap->length = map.m_llen;
 	iomap->flags = 0;
-	iomap->private = NULL;
 	iomap->addr = IOMAP_NULL_ADDR;
 	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
 		iomap->type = IOMAP_HOLE;
@@ -309,16 +315,20 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
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
+			struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
+			void *ptr;
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
@@ -328,18 +338,18 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 static int erofs_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 		ssize_t written, unsigned int flags, struct iomap *iomap)
 {
-	void *ptr = iomap->private;
+	struct iomap_iter *iter = container_of(iomap, struct iomap_iter, iomap);
+	struct erofs_iomap_iter_ctx *ctx = iter->private;
 
-	if (ptr) {
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
+		ctx->base = NULL;
 	}
 	return written;
 }
@@ -369,18 +379,30 @@ int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
  */
 static int erofs_read_folio(struct file *file, struct folio *folio)
 {
+	struct iomap_read_folio_ctx read_ctx = {
+		.ops		= &iomap_bio_read_ops,
+		.cur_folio	= folio,
+	};
+	struct erofs_iomap_iter_ctx iter_ctx = {};
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
+	struct erofs_iomap_iter_ctx iter_ctx = {};
+
 	trace_erofs_readahead(rac->mapping->host, readahead_index(rac),
 					readahead_count(rac), true);
 
-	iomap_bio_readahead(rac, &erofs_iomap_ops);
+	iomap_readahead(&erofs_iomap_ops, &read_ctx, &iter_ctx);
 }
 
 static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
@@ -400,9 +422,12 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	if (IS_DAX(inode))
 		return dax_iomap_rw(iocb, to, &erofs_iomap_ops);
 #endif
-	if ((iocb->ki_flags & IOCB_DIRECT) && inode->i_sb->s_bdev)
+	if ((iocb->ki_flags & IOCB_DIRECT) && inode->i_sb->s_bdev) {
+		struct erofs_iomap_iter_ctx iter_ctx = {};
+
 		return iomap_dio_rw(iocb, to, &erofs_iomap_ops,
-				    NULL, 0, NULL, 0);
+				    NULL, 0, &iter_ctx, 0);
+	}
 	return filemap_read(iocb, to, 0);
 }
 
-- 
2.22.0


