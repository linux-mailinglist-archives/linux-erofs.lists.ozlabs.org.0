Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFE24283D6
	for <lists+linux-erofs@lfdr.de>; Sun, 10 Oct 2021 23:32:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HSFX80MWtz2yQL
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Oct 2021 08:32:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bmPJVWO5;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=bmPJVWO5; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HSFX50WPMz2xtS
 for <linux-erofs@lists.ozlabs.org>; Mon, 11 Oct 2021 08:32:53 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACDCE610A4;
 Sun, 10 Oct 2021 21:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633901571;
 bh=EdTe58Z93d8p2+g9qWxuiL0mLrdMImIRJz89rzGB5nU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bmPJVWO5fxg9eagNTae2c6AagTqrP0etuWyFdEakN0BmyBdrtrdVvtjQ3rtW/Vd0+
 G2+yud6TCclWNpu8YBhwsgQyVfF7pCTU1hUgLo1CUHz+U3TAI2aUC+E6DfEJ8CZC2W
 cfBgcFNwmPnlx7y00En5CG7JG0QIR3zP2KUF52qrE9mmSOMS8ThNrXVhqMW75xa4Ix
 soDi4RsCr95lkCNTq+KIyVoBeK84wcVm0AiFo8N0CgwdO1zQN+2zp0f8DQKPShkTka
 IZFTQcP9K4bz9ileL5mLR3nYBVjvS6FvLaYvLEExiTX01Co6/6AJO43yf4IMgQtdOd
 2I2e3c87VFbUA==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/7] erofs: rename some generic methods in decompressor
Date: Mon, 11 Oct 2021 05:31:44 +0800
Message-Id: <20211010213145.17462-7-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211010213145.17462-1-xiang@kernel.org>
References: <20211010213145.17462-1-xiang@kernel.org>
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
Cc: Lasse Collin <lasse.collin@tukaani.org>,
 Greg KH <gregkh@linuxfoundation.org>, Gao Xiang <hsiangkao@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@linux.alibaba.com>

Previously, some LZ4 methods were named with `generic'. However, while
evaluating the effective LZMA approach, it seems they aren't quite
generic at all (e.g. no need preparing dstpages for most LZMA cases.)

Avoid such naming instead.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/decompressor.c | 65 ++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 34 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index a5bc4b1b7813..bceaa2b06b17 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -17,13 +17,8 @@
 #endif
 
 struct z_erofs_decompressor {
-	/*
-	 * if destpages have sparsed pages, fill them with bounce pages.
-	 * it also check whether destpages indicate continuous physical memory.
-	 */
-	int (*prepare_destpages)(struct z_erofs_decompress_req *rq,
-				 struct list_head *pagepool);
-	int (*decompress)(struct z_erofs_decompress_req *rq, u8 *out);
+	int (*decompress)(struct z_erofs_decompress_req *rq,
+			  struct list_head *pagepool);
 	char *name;
 };
 
@@ -63,8 +58,12 @@ int z_erofs_load_lz4_config(struct super_block *sb,
 	return erofs_pcpubuf_growsize(sbi->lz4.max_pclusterblks);
 }
 
-static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
-					 struct list_head *pagepool)
+/*
+ * Fill all gaps with bounce pages if it's a sparse page list. Also check if
+ * all physical pages are consecutive, which can be seen for moderate CR.
+ */
+static int z_erofs_lz4_prepare_dstpages(struct z_erofs_decompress_req *rq,
+					struct list_head *pagepool)
 {
 	const unsigned int nr =
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
@@ -119,7 +118,7 @@ static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
 	return kaddr ? 1 : 0;
 }
 
-static void *z_erofs_handle_inplace_io(struct z_erofs_decompress_req *rq,
+static void *z_erofs_lz4_handle_inplace_io(struct z_erofs_decompress_req *rq,
 			void *inpage, unsigned int *inputmargin, int *maptype,
 			bool support_0padding)
 {
@@ -189,7 +188,8 @@ static void *z_erofs_handle_inplace_io(struct z_erofs_decompress_req *rq,
 	return src;
 }
 
-static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
+static int z_erofs_lz4_decompress_mem(struct z_erofs_decompress_req *rq,
+				      u8 *out)
 {
 	unsigned int inputmargin;
 	u8 *headpage, *src;
@@ -216,8 +216,8 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 	}
 
 	rq->inputsize -= inputmargin;
-	src = z_erofs_handle_inplace_io(rq, headpage, &inputmargin, &maptype,
-					support_0padding);
+	src = z_erofs_lz4_handle_inplace_io(rq, headpage, &inputmargin,
+					    &maptype, support_0padding);
 	if (IS_ERR(src))
 		return PTR_ERR(src);
 
@@ -257,17 +257,6 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 	return ret;
 }
 
-static struct z_erofs_decompressor decompressors[] = {
-	[Z_EROFS_COMPRESSION_SHIFTED] = {
-		.name = "shifted"
-	},
-	[Z_EROFS_COMPRESSION_LZ4] = {
-		.prepare_destpages = z_erofs_lz4_prepare_destpages,
-		.decompress = z_erofs_lz4_decompress,
-		.name = "lz4"
-	},
-};
-
 static void copy_from_pcpubuf(struct page **out, const char *dst,
 			      unsigned short pageofs_out,
 			      unsigned int outputsize)
@@ -295,12 +284,11 @@ static void copy_from_pcpubuf(struct page **out, const char *dst,
 	}
 }
 
-static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
-				      struct list_head *pagepool)
+static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq,
+				  struct list_head *pagepool)
 {
 	const unsigned int nrpages_out =
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
-	const struct z_erofs_decompressor *alg = decompressors + rq->alg;
 	unsigned int dst_maptype;
 	void *dst;
 	int ret;
@@ -325,7 +313,7 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
 				return PTR_ERR(dst);
 
 			rq->inplace_io = false;
-			ret = alg->decompress(rq, dst);
+			ret = z_erofs_lz4_decompress_mem(rq, dst);
 			if (!ret)
 				copy_from_pcpubuf(rq->out, dst, rq->pageofs_out,
 						  rq->outputsize);
@@ -336,7 +324,7 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
 	}
 
 	/* general decoding path which can be used for all cases */
-	ret = alg->prepare_destpages(rq, pagepool);
+	ret = z_erofs_lz4_prepare_dstpages(rq, pagepool);
 	if (ret < 0)
 		return ret;
 	if (ret) {
@@ -351,7 +339,7 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
 	dst_maptype = 2;
 
 dstmap_out:
-	ret = alg->decompress(rq, dst + rq->pageofs_out);
+	ret = z_erofs_lz4_decompress_mem(rq, dst + rq->pageofs_out);
 
 	if (!dst_maptype)
 		kunmap_atomic(dst);
@@ -360,7 +348,7 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
 	return ret;
 }
 
-static int z_erofs_shifted_transform(const struct z_erofs_decompress_req *rq,
+static int z_erofs_shifted_transform(struct z_erofs_decompress_req *rq,
 				     struct list_head *pagepool)
 {
 	const unsigned int nrpages_out =
@@ -399,10 +387,19 @@ static int z_erofs_shifted_transform(const struct z_erofs_decompress_req *rq,
 	return 0;
 }
 
+static struct z_erofs_decompressor decompressors[] = {
+	[Z_EROFS_COMPRESSION_SHIFTED] = {
+		.decompress = z_erofs_shifted_transform,
+		.name = "shifted"
+	},
+	[Z_EROFS_COMPRESSION_LZ4] = {
+		.decompress = z_erofs_lz4_decompress,
+		.name = "lz4"
+	},
+};
+
 int z_erofs_decompress(struct z_erofs_decompress_req *rq,
 		       struct list_head *pagepool)
 {
-	if (rq->alg == Z_EROFS_COMPRESSION_SHIFTED)
-		return z_erofs_shifted_transform(rq, pagepool);
-	return z_erofs_decompress_generic(rq, pagepool);
+	return decompressors[rq->alg].decompress(rq, pagepool);
 }
-- 
2.20.1

