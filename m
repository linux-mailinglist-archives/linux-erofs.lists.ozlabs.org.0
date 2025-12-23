Return-Path: <linux-erofs+bounces-1537-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD18CD7CF1
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Dec 2025 03:09:03 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dZz2g6ldwz2yFW;
	Tue, 23 Dec 2025 13:08:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766455739;
	cv=none; b=RWN8/PZ8V5BWRh1sMnplCbGDXTH1YM0jw2xkbhyFTW6/PK/hX96f4a8FLHu6wg6wtjUOJ2YFL7qnDWKaMaqVr61FJ1UOXn5MnJYx+et3FLTii+RRbZKhIORWJa9jhd0siY09vupx6lQw9Rx46lgrDvd8CwGNGFtXBc0Rrjc9tciWQvgHB8gIxt28zDIM6YyAGW9xmedWcaHoLrPIVT0j5+RJy5WFsZsHywYKl0RuTo2n2o5Qz8dfdQrIPpilG4Vjf9ZJVO7x3zFX+3sh0nKSbDb9wowewfFw6tx1vIUsMzaN8VR1W4w9km1++ITJXEM7MQVgWrP9R7fgqba1EhAzEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766455739; c=relaxed/relaxed;
	bh=p2PKDgkJQIEgxRGETyAjQ3sbTCuZuHWHL+n4YmBZzHo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b4EtnekrTXHQT5xDaprPxe6jvQvkEH0qr/CQpB9ezftQuGIj6H1p61zZr4JiMX82VvSJs8QF/Sn9EOqdmLAlq7kETaOBKJ8uXx8jcgW5fdxur/+/shpeJrKlXpz0/04kQMROKBITZyMTd1uDuOqinyChkhXstDMzS79+XWPLaqydUaoLgROj7R08O+27Hy6P3o51WQfnJP7w1aasRQjpbWDaQg72gVTRMsbNiAVMOesevD6zH/oYkPUvQyncXU1XawzHsg1vcdUqggHwL/MociBD8dRIoaPkY0/sTWVWhe+mSBe3s3hWzGM4LD6KYDst/3WkySAY0YUitiNX+o25TA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=326suT3+; dkim-atps=neutral; spf=pass (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=326suT3+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dZz2d3hy1z2xlP
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Dec 2025 13:08:56 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=p2PKDgkJQIEgxRGETyAjQ3sbTCuZuHWHL+n4YmBZzHo=;
	b=326suT3+br41/A9g+87bPgtTPQLDC/N9ehuHDhGEee+yYKSBlB7kQ9EaKkliS9jR+xKPpvlkj
	/hJdU/PUGuk+qFBlnPV8Wepz1vLKXWy5aqu8pfPOYBZHh6XcSaxrpLyk0eLbrlnkh9LLm7DYDPP
	DM9dsVeO23AmanRWv/kA2t8=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dZyyx2m2FzKmgb;
	Tue, 23 Dec 2025 10:05:45 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 32CD44056C;
	Tue, 23 Dec 2025 10:08:52 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 23 Dec
 2025 10:08:51 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>
CC: <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v10 01/10] iomap: stash iomap read ctx in the private field of iomap_iter
Date: Tue, 23 Dec 2025 01:56:10 +0000
Message-ID: <20251223015618.485626-2-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20251223015618.485626-1-lihongbo22@huawei.com>
References: <20251223015618.485626-1-lihongbo22@huawei.com>
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
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

It's useful to get filesystem-specific information using the
existing private field in the @iomap_iter passed to iomap_{begin,end}
for advanced usage for iomap buffered reads, which is much like the
current iomap DIO.

For example, EROFS needs it to:

 - implement an efficient page cache sharing feature, since iomap
   needs to apply to anon inode page cache but we'd like to get the
   backing inode/fs instead, so filesystem-specific private data is
   needed to keep such information;

 - pass in both struct page * and void * for inline data to avoid
   kmap_to_page() usage (which is bogus).

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/fuse/file.c         | 4 ++--
 fs/iomap/buffered-io.c | 6 ++++--
 include/linux/iomap.h  | 8 ++++----
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 01bc894e9c2b..f5d8887c1922 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -979,7 +979,7 @@ static int fuse_read_folio(struct file *file, struct folio *folio)
 		return -EIO;
 	}
 
-	iomap_read_folio(&fuse_iomap_ops, &ctx);
+	iomap_read_folio(&fuse_iomap_ops, &ctx, NULL);
 	fuse_invalidate_atime(inode);
 	return 0;
 }
@@ -1081,7 +1081,7 @@ static void fuse_readahead(struct readahead_control *rac)
 	if (fuse_is_bad(inode))
 		return;
 
-	iomap_readahead(&fuse_iomap_ops, &ctx);
+	iomap_readahead(&fuse_iomap_ops, &ctx, NULL);
 }
 
 static ssize_t fuse_cache_read_iter(struct kiocb *iocb, struct iov_iter *to)
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index e5c1ca440d93..5f7dcbabbda3 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -555,13 +555,14 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 }
 
 void iomap_read_folio(const struct iomap_ops *ops,
-		struct iomap_read_folio_ctx *ctx)
+		struct iomap_read_folio_ctx *ctx, void *private)
 {
 	struct folio *folio = ctx->cur_folio;
 	struct iomap_iter iter = {
 		.inode		= folio->mapping->host,
 		.pos		= folio_pos(folio),
 		.len		= folio_size(folio),
+		.private	= private,
 	};
 	size_t bytes_submitted = 0;
 	int ret;
@@ -620,13 +621,14 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
  * the filesystem to be reentered.
  */
 void iomap_readahead(const struct iomap_ops *ops,
-		struct iomap_read_folio_ctx *ctx)
+		struct iomap_read_folio_ctx *ctx, void *private)
 {
 	struct readahead_control *rac = ctx->rac;
 	struct iomap_iter iter = {
 		.inode	= rac->mapping->host,
 		.pos	= readahead_pos(rac),
 		.len	= readahead_length(rac),
+		.private = private,
 	};
 	size_t cur_bytes_submitted;
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 520e967cb501..441d614e9fdf 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -341,9 +341,9 @@ ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops,
 		const struct iomap_write_ops *write_ops, void *private);
 void iomap_read_folio(const struct iomap_ops *ops,
-		struct iomap_read_folio_ctx *ctx);
+		struct iomap_read_folio_ctx *ctx, void *private);
 void iomap_readahead(const struct iomap_ops *ops,
-		struct iomap_read_folio_ctx *ctx);
+		struct iomap_read_folio_ctx *ctx, void *private);
 bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
 struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len);
 bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);
@@ -595,7 +595,7 @@ static inline void iomap_bio_read_folio(struct folio *folio,
 		.cur_folio	= folio,
 	};
 
-	iomap_read_folio(ops, &ctx);
+	iomap_read_folio(ops, &ctx, NULL);
 }
 
 static inline void iomap_bio_readahead(struct readahead_control *rac,
@@ -606,7 +606,7 @@ static inline void iomap_bio_readahead(struct readahead_control *rac,
 		.rac		= rac,
 	};
 
-	iomap_readahead(ops, &ctx);
+	iomap_readahead(ops, &ctx, NULL);
 }
 #endif /* CONFIG_BLOCK */
 
-- 
2.22.0


