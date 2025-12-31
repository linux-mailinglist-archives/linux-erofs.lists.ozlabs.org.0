Return-Path: <linux-erofs+bounces-1667-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CC8CEBA65
	for <lists+linux-erofs@lfdr.de>; Wed, 31 Dec 2025 10:14:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dh45b710Lz2yRM;
	Wed, 31 Dec 2025 20:14:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.223
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767172451;
	cv=none; b=mj7zjAIDNVrGqEfSpSU3UGgpsVpTMkq+WUrwMgXS7wHy3X/wD+DTHlTHFkTSsm1vp9enISxP0dZhiYDYRgXTsjqYqMgVegNtd5iAwI0Nk5j0TFqPqt2I9T4I3Rew9vKbK8L4yPuSn0doomAziFko7lHdMl7yYz6uRppi4J2o0uGjCK61f5VUsw8UDYeEou79q+0iHAir+hB+VbqIXv0ifqO8fsxvQcZgt8iKloDCZFzCDXRoG+GxnJRh8QsvFrAmNbfA9okdV1HzwAPtsp+Rf0CzNX56ePeWccwfsO07Kk2yMCOB+7P0WlQwwfaZCNiHPkcTsuOlzpB3VcbLwRjdwA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767172451; c=relaxed/relaxed;
	bh=lfJ/O4D8J9vNgJSRQcHGc3PWqPTwsbyNQanvesy0zuM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D8iazrGflYv5/QdIVKqaheJ1ThsvvxWD22Y7xX9hcYkTBp3Z7Y/6OfnZxnHR7bIxHniMifwjvmDZVBaL0a1Q+j1ayFEu+shHGlbpLSkU+62FMe16ZdcujUC6XSacEg4fBSuDYwaBDQqopRa528UXDlzNFsyL9vNSwlg/z4bzbIGynkPR0FwhRKeeUWbS3eSBj5fxUAhLarMIO61xmQ9M935oAN2WOWznhfBR/vRyk078T0LX9zGM/1S5mqcWv1DU8F5C3J0tLGpXFCYfzZpe9FS14HHutZ62KoQoOyJo7KUSyWlNdXdFqEQToK1A5+0X6unMFBLXUVTWL/muX2buqw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ZP999kvm; dkim-atps=neutral; spf=pass (client-ip=113.46.200.223; helo=canpmsgout08.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ZP999kvm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.223; helo=canpmsgout08.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dh45T42HKz2yNv
	for <linux-erofs@lists.ozlabs.org>; Wed, 31 Dec 2025 20:14:04 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=lfJ/O4D8J9vNgJSRQcHGc3PWqPTwsbyNQanvesy0zuM=;
	b=ZP999kvmVIM5g0Z3M5rHvI+y02z5I7bYWmfzFpC634J7gM4BedPDjrL4fqVf3LZONrFV0gfaN
	U6jq58kyErcj7RXi+ftcBapO3T3+xxEGWoIu19ZNf2zZg2VcSoQLSsTRGstQrWQnaVXJm2+QAMb
	wvyKxEUvvb4EU52IoW46QKE=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4dh41f5hq2zmV71;
	Wed, 31 Dec 2025 17:10:46 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 90BE74069C;
	Wed, 31 Dec 2025 17:13:58 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 31 Dec
 2025 17:13:57 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>
CC: <djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>,
	<lihongbo22@huawei.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 01/10] iomap: stash iomap read ctx in the private field of iomap_iter
Date: Wed, 31 Dec 2025 09:01:09 +0000
Message-ID: <20251231090118.541061-2-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20251231090118.541061-1-lihongbo22@huawei.com>
References: <20251231090118.541061-1-lihongbo22@huawei.com>
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
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
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


