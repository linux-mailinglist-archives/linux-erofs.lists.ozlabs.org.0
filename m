Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5AD83D3F9
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jan 2024 06:36:44 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xosI5utF;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TLmf252BKz3cMQ
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jan 2024 16:36:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xosI5utF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TLmdq4dv8z3bwX
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Jan 2024 16:36:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706247384; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=h9jiGswXdStGzbdydZiMP7pJ+yL5hOmyEbJy5RVFHxs=;
	b=xosI5utF43xxuTRAPyXZs3oBNk/3Br6Xp11TfTr11uCNjEa4Tz8MfQAp1bkZb1ovoShzOgfqsqD6gkpRHooZkJUs6HYaxsUbnG+E2UaOoR2Hgks7Q1TXFO5pSymkx5eiZGfnlh3wLbUsnYBdN41IrLyJ6H1zVti4Qnj6ihIKSsA=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W.MYc8x_1706247378;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W.MYc8x_1706247378)
          by smtp.aliyun-inc.com;
          Fri, 26 Jan 2024 13:36:23 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3] erofs: relaxed temporary buffers allocation on readahead
Date: Fri, 26 Jan 2024 13:36:16 +0800
Message-Id: <20240126053616.3707834-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <TY2PR06MB3342D2245C5E515028C33FD4BE792@TY2PR06MB3342.apcprd06.prod.outlook.com>
References: <TY2PR06MB3342D2245C5E515028C33FD4BE792@TY2PR06MB3342.apcprd06.prod.outlook.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@coolpad.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, Chunhai Guo <guochunhai@vivo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Chunhai Guo <guochunhai@vivo.com>

Even with inplace decompression, sometimes very few temporary buffers
are still needed for a single decompression shot (e.g. 16 pages for 64k
sliding window or 4 pages for 16k sliding window).  In low-memory
scenarios, it would be better to try to allocate with GFP_NOWAIT on
readahead first. That can help reduce the time spent on page allocation
under durative memory pressure.

Here are detailed performance numbers under multi-app launch benchmark
workload [1] on ARM64 Android devices (8-core CPU and 8GB of memory)
running a 5.15 LTS kernel with EROFS of 4k pclusters:

+----------------+---------+---------+---------+
|      LZ4       | vanilla | patched |  diff   |
|----------------+---------+---------+---------|
|  Average (ms)  |  3364   |  2684   | -20.21% | [64k sliding window]
|----------------+---------+---------+---------|
|  Average (ms)  |  2079   |  1610   | -22.56% | [16k sliding window]
+----------------+---------+---------+---------+

The total size of system images for 4k pcluster is almost unchanged:
(64k sliding window)  9,117,044 KB
(16k sliding window)  9,113,096 KB

Therefore, in addition to switch the sliding window from 64k to 16k,
after applying this patch, it can eventually save 52.14% (3364 -> 1610)
on average with no memory reservation.  That is particularly useful for
embedded devices with limited resources.

[1] https://lore.kernel.org/r/20240109074143.4138783-1-guochunhai@vivo.com

Suggested-by: Gao Xiang <xiang@kernel.org>
Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v2: https://lore.kernel.org/r/20240120145551.1941483-1-guochunhai@vivo.com
change since v2:
 - update commit message according to test results.

I plan to apply this version.

 fs/erofs/compress.h             |  5 ++---
 fs/erofs/decompressor.c         |  5 +++--
 fs/erofs/decompressor_deflate.c | 19 +++++++++++++------
 fs/erofs/decompressor_lzma.c    | 17 ++++++++++++-----
 fs/erofs/zdata.c                | 16 ++++++++++++----
 5 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index 279933e007d2..7cc5841577b2 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -11,13 +11,12 @@
 struct z_erofs_decompress_req {
 	struct super_block *sb;
 	struct page **in, **out;
-
 	unsigned short pageofs_in, pageofs_out;
 	unsigned int inputsize, outputsize;
 
-	/* indicate the algorithm will be used for decompression */
-	unsigned int alg;
+	unsigned int alg;       /* the algorithm for decompression */
 	bool inplace_io, partial_decoding, fillgaps;
+	gfp_t gfp;      /* allocation flags for extra temporary buffers */
 };
 
 struct z_erofs_decompressor {
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 072ef6a66823..d4cee95af14c 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -111,8 +111,9 @@ static int z_erofs_lz4_prepare_dstpages(struct z_erofs_lz4_decompress_ctx *ctx,
 			victim = availables[--top];
 			get_page(victim);
 		} else {
-			victim = erofs_allocpage(pagepool,
-						 GFP_KERNEL | __GFP_NOFAIL);
+			victim = erofs_allocpage(pagepool, rq->gfp);
+			if (!victim)
+				return -ENOMEM;
 			set_page_private(victim, Z_EROFS_SHORTLIVED_PAGE);
 		}
 		rq->out[i] = victim;
diff --git a/fs/erofs/decompressor_deflate.c b/fs/erofs/decompressor_deflate.c
index 4a64a9c91dd3..b98872058abe 100644
--- a/fs/erofs/decompressor_deflate.c
+++ b/fs/erofs/decompressor_deflate.c
@@ -95,7 +95,7 @@ int z_erofs_load_deflate_config(struct super_block *sb,
 }
 
 int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
-			       struct page **pagepool)
+			       struct page **pgpl)
 {
 	const unsigned int nrpages_out =
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
@@ -158,8 +158,12 @@ int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
 			strm->z.avail_out = min_t(u32, outsz, PAGE_SIZE - pofs);
 			outsz -= strm->z.avail_out;
 			if (!rq->out[no]) {
-				rq->out[no] = erofs_allocpage(pagepool,
-						GFP_KERNEL | __GFP_NOFAIL);
+				rq->out[no] = erofs_allocpage(pgpl, rq->gfp);
+				if (!rq->out[no]) {
+					kout = NULL;
+					err = -ENOMEM;
+					break;
+				}
 				set_page_private(rq->out[no],
 						 Z_EROFS_SHORTLIVED_PAGE);
 			}
@@ -211,8 +215,11 @@ int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
 
 			DBG_BUGON(erofs_page_is_managed(EROFS_SB(sb),
 							rq->in[j]));
-			tmppage = erofs_allocpage(pagepool,
-						  GFP_KERNEL | __GFP_NOFAIL);
+			tmppage = erofs_allocpage(pgpl, rq->gfp);
+			if (!tmppage) {
+				err = -ENOMEM;
+				goto failed;
+			}
 			set_page_private(tmppage, Z_EROFS_SHORTLIVED_PAGE);
 			copy_highpage(tmppage, rq->in[j]);
 			rq->in[j] = tmppage;
@@ -230,7 +237,7 @@ int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
 			break;
 		}
 	}
-
+failed:
 	if (zlib_inflateEnd(&strm->z) != Z_OK && !err)
 		err = -EIO;
 	if (kout)
diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
index 2dd14f99c1dc..6ca357d83cfa 100644
--- a/fs/erofs/decompressor_lzma.c
+++ b/fs/erofs/decompressor_lzma.c
@@ -148,7 +148,7 @@ int z_erofs_load_lzma_config(struct super_block *sb,
 }
 
 int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
-			    struct page **pagepool)
+			    struct page **pgpl)
 {
 	const unsigned int nrpages_out =
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
@@ -215,8 +215,11 @@ int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 						   PAGE_SIZE - pageofs);
 			outlen -= strm->buf.out_size;
 			if (!rq->out[no] && rq->fillgaps) {	/* deduped */
-				rq->out[no] = erofs_allocpage(pagepool,
-						GFP_KERNEL | __GFP_NOFAIL);
+				rq->out[no] = erofs_allocpage(pgpl, rq->gfp);
+				if (!rq->out[no]) {
+					err = -ENOMEM;
+					break;
+				}
 				set_page_private(rq->out[no],
 						 Z_EROFS_SHORTLIVED_PAGE);
 			}
@@ -258,8 +261,11 @@ int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 
 			DBG_BUGON(erofs_page_is_managed(EROFS_SB(rq->sb),
 							rq->in[j]));
-			tmppage = erofs_allocpage(pagepool,
-						  GFP_KERNEL | __GFP_NOFAIL);
+			tmppage = erofs_allocpage(pgpl, rq->gfp);
+			if (!tmppage) {
+				err = -ENOMEM;
+				goto failed;
+			}
 			set_page_private(tmppage, Z_EROFS_SHORTLIVED_PAGE);
 			copy_highpage(tmppage, rq->in[j]);
 			rq->in[j] = tmppage;
@@ -277,6 +283,7 @@ int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 			break;
 		}
 	}
+failed:
 	if (no < nrpages_out && strm->buf.out)
 		kunmap(rq->out[no]);
 	if (ni < nrpages_in)
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index c1c77166b30f..1d0fdc145fd6 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -82,6 +82,9 @@ struct z_erofs_pcluster {
 	/* L: indicate several pageofs_outs or not */
 	bool multibases;
 
+	/* L: whether extra buffer allocations are best-effort */
+	bool besteffort;
+
 	/* A: compressed bvecs (can be cached or inplaced pages) */
 	struct z_erofs_bvec compressed_bvecs[];
 };
@@ -960,7 +963,7 @@ static int z_erofs_read_fragment(struct super_block *sb, struct page *page,
 }
 
 static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
-				struct page *page)
+				struct page *page, bool ra)
 {
 	struct inode *const inode = fe->inode;
 	struct erofs_map_blocks *const map = &fe->map;
@@ -1010,6 +1013,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		err = z_erofs_pcluster_begin(fe);
 		if (err)
 			goto out;
+		fe->pcl->besteffort |= !ra;
 	}
 
 	/*
@@ -1276,7 +1280,11 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 					.inplace_io = overlapped,
 					.partial_decoding = pcl->partial,
 					.fillgaps = pcl->multibases,
+					.gfp = pcl->besteffort ?
+						GFP_KERNEL | __GFP_NOFAIL :
+						GFP_NOWAIT | __GFP_NORETRY
 				 }, be->pagepool);
+	pcl->besteffort = false;
 
 	/* must handle all compressed pages before actual file pages */
 	if (z_erofs_is_inline_pcluster(pcl)) {
@@ -1787,7 +1795,7 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
 			if (PageUptodate(page))
 				unlock_page(page);
 			else
-				(void)z_erofs_do_read_page(f, page);
+				(void)z_erofs_do_read_page(f, page, !!rac);
 			put_page(page);
 		}
 
@@ -1808,7 +1816,7 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
 	f.headoffset = (erofs_off_t)folio->index << PAGE_SHIFT;
 
 	z_erofs_pcluster_readmore(&f, NULL, true);
-	err = z_erofs_do_read_page(&f, &folio->page);
+	err = z_erofs_do_read_page(&f, &folio->page, false);
 	z_erofs_pcluster_readmore(&f, NULL, false);
 	z_erofs_pcluster_end(&f);
 
@@ -1849,7 +1857,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 		folio = head;
 		head = folio_get_private(folio);
 
-		err = z_erofs_do_read_page(&f, &folio->page);
+		err = z_erofs_do_read_page(&f, &folio->page, true);
 		if (err && err != -EINTR)
 			erofs_err(inode->i_sb, "readahead error at folio %lu @ nid %llu",
 				  folio->index, EROFS_I(inode)->nid);
-- 
2.39.3

