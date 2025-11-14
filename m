Return-Path: <linux-erofs+bounces-1367-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B6739C5C725
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Nov 2025 11:07:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d7CVM1zrvz2xnh;
	Fri, 14 Nov 2025 21:07:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763114827;
	cv=none; b=mUf0arlwpFWmPSuZkczszwcJpxHzSH3/afleFjp0gCseJq5l7eUYP0RjZbqFgQGjAO98Q/HSWXtcDr3nMJMheyGnKOO6dD8oW6Bs7JqO5w9l8rmnoEnuFVddJdTueZmdXZw3gMCGtdocrMy2DAQCMA0Gh6dbxzc2UhoIqIGtGQxxVhTMy+GptiZn8U9XpQEmiNhHsGh95qEkwZMZmp6Mw2ahPK+huDXwR5o9HIKahTybjKKBE1GQMzypddLwkzswTFFVaY7Rthg6TjY3rbvjoU1egkeX0S9FscrRYEH/fAGqEIl8Pqc7KeWnA4I+d8nR77wiKGvU/Nv94j5NjUPi4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763114827; c=relaxed/relaxed;
	bh=K0Uha1E1AoTTdsUqS8ogAzLegDGAzEZvOWEH95Tolb8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ctCYGuukVrrldJURdfprEsIlVn6kpC2O6UJakv9ycug1MFTg/VVhpYuisQFqxiBvDTrZJQAaeMbO1B978GSRqUbuNSYmBkw7AYplvdnmylIE6+zZGxnvE3E6gsyy5PrbwtV49tBOvRHtt/2eIbiqdssLuPveq2L6LxT2DTQ4oA8A9UTis4A0s2shGKK2B6ZJcRHLL5TGrTRtRH0n1a6Ltuv61JGLkTX/fRYEX3HFFwWk4e3OYSo888dAaRrYeKaqFGl/jQISiXq2/9RD8S1/YqTY1EuCuVRq4DhEFzA2stytmzPCRWaJbMkufiF6ivouBVQFjYWNvPWJLMF3R+qYAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=5Sv2DVfY; dkim-atps=neutral; spf=pass (client-ip=113.46.200.216; helo=canpmsgout01.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=5Sv2DVfY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.216; helo=canpmsgout01.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d7CVF2PTsz2yyd
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Nov 2025 21:06:59 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=K0Uha1E1AoTTdsUqS8ogAzLegDGAzEZvOWEH95Tolb8=;
	b=5Sv2DVfYlUO5XY0hrSs5KJkDBSjT4n4BjyMTqeRgBOCu/hEpoWKoDtvPeyeiwpN7ITrrKdI+H
	SUkDpdCFVlqGPxDYdg+28EA8YS0U5/89lTWDTFLCX/kAs7UOW2z69706j/87dD0m2QBL+m40TIX
	1BM+x9kwrSfbkY4tKSv0d+Q=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4d7CST1Rt2z1T4LW;
	Fri, 14 Nov 2025 18:05:29 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 4FA03180478;
	Fri, 14 Nov 2025 18:06:55 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 14 Nov
 2025 18:06:54 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<djwong@kernel.org>, <amir73il@gmail.com>, <joannelkoong@gmail.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v8 1/9] iomap: stash iomap read ctx in the private field of iomap_iter
Date: Fri, 14 Nov 2025 09:55:08 +0000
Message-ID: <20251114095516.207555-2-lihongbo22@huawei.com>
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
index 8275b6681b9b..98dd20f0bb53 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -973,7 +973,7 @@ static int fuse_read_folio(struct file *file, struct folio *folio)
 		return -EIO;
 	}
 
-	iomap_read_folio(&fuse_iomap_ops, &ctx);
+	iomap_read_folio(&fuse_iomap_ops, &ctx, NULL);
 	fuse_invalidate_atime(inode);
 	return 0;
 }
@@ -1075,7 +1075,7 @@ static void fuse_readahead(struct readahead_control *rac)
 	if (fuse_is_bad(inode))
 		return;
 
-	iomap_readahead(&fuse_iomap_ops, &ctx);
+	iomap_readahead(&fuse_iomap_ops, &ctx, NULL);
 }
 
 static ssize_t fuse_cache_read_iter(struct kiocb *iocb, struct iov_iter *to)
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 6ae031ac8058..8e79303c074e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -496,13 +496,14 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
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
 	size_t bytes_pending = 0;
 	int ret;
@@ -560,13 +561,14 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
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
 	size_t cur_bytes_pending;
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 8b1ac08c7474..c3ecbbdb14e8 100644
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
@@ -594,7 +594,7 @@ static inline void iomap_bio_read_folio(struct folio *folio,
 		.cur_folio	= folio,
 	};
 
-	iomap_read_folio(ops, &ctx);
+	iomap_read_folio(ops, &ctx, NULL);
 }
 
 static inline void iomap_bio_readahead(struct readahead_control *rac,
@@ -605,7 +605,7 @@ static inline void iomap_bio_readahead(struct readahead_control *rac,
 		.rac		= rac,
 	};
 
-	iomap_readahead(ops, &ctx);
+	iomap_readahead(ops, &ctx, NULL);
 }
 #endif /* CONFIG_BLOCK */
 
-- 
2.22.0


