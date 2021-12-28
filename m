Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 104B1480692
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Dec 2021 06:46:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JNNnk6sm0z2yZd
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Dec 2021 16:46:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57;
 helo=out30-57.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JNNnb2MYPz2yZd
 for <linux-erofs@lists.ozlabs.org>; Tue, 28 Dec 2021 16:46:24 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R211e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0V0240kf_1640670365; 
Received: from
 e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V0240kf_1640670365) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 28 Dec 2021 13:46:14 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v4 2/5] erofs: introduce z_erofs_fixup_insize
Date: Tue, 28 Dec 2021 13:46:01 +0800
Message-Id: <20211228054604.114518-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20211228054604.114518-1-hsiangkao@linux.alibaba.com>
References: <20211228054604.114518-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Yue Hu <huyue2@yulong.com>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

To prepare for the upcoming ztailpacking feature, introduce
z_erofs_fixup_insize() and pageofs_in to wrap up the process
to get the exact compressed size via zero padding.

Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/compress.h          |  4 +++-
 fs/erofs/decompressor.c      | 34 +++++++++++++++++++++++++---------
 fs/erofs/decompressor_lzma.c | 19 ++++++++-----------
 3 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index 579406504919..19e6c56a9f47 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -12,7 +12,7 @@ struct z_erofs_decompress_req {
 	struct super_block *sb;
 	struct page **in, **out;
 
-	unsigned short pageofs_out;
+	unsigned short pageofs_in, pageofs_out;
 	unsigned int inputsize, outputsize;
 
 	/* indicate the algorithm will be used for decompression */
@@ -87,6 +87,8 @@ static inline bool erofs_page_is_managed(const struct erofs_sb_info *sbi,
 	return page->mapping == MNGD_MAPPING(sbi);
 }
 
+int z_erofs_fixup_insize(struct z_erofs_decompress_req *rq, const char *padbuf,
+			 unsigned int padbufsize);
 int z_erofs_decompress(struct z_erofs_decompress_req *rq,
 		       struct page **pagepool);
 
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 1d137fd42306..b8b2a3e34053 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -184,6 +184,24 @@ static void *z_erofs_lz4_handle_overlap(struct z_erofs_lz4_decompress_ctx *ctx,
 	return src;
 }
 
+/*
+ * Get the exact inputsize with zero_padding feature.
+ *  - For LZ4, it should work if zero_padding feature is on (5.3+);
+ *  - For MicroLZMA, it'd be enabled all the time.
+ */
+int z_erofs_fixup_insize(struct z_erofs_decompress_req *rq, const char *padbuf,
+			 unsigned int padbufsize)
+{
+	const char *padend;
+
+	padend = memchr_inv(padbuf, 0, padbufsize);
+	if (!padend)
+		return -EFSCORRUPTED;
+	rq->inputsize -= padend - padbuf;
+	rq->pageofs_in += padend - padbuf;
+	return 0;
+}
+
 static int z_erofs_lz4_decompress_mem(struct z_erofs_lz4_decompress_ctx *ctx,
 				      u8 *out)
 {
@@ -198,21 +216,19 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_lz4_decompress_ctx *ctx,
 	inputmargin = 0;
 	support_0padding = false;
 
-	/* decompression inplace is only safe when zero_padding is enabled */
+	/* LZ4 decompression inplace is only safe if zero_padding is enabled */
 	if (erofs_sb_has_zero_padding(EROFS_SB(rq->sb))) {
 		support_0padding = true;
-
-		while (!headpage[inputmargin & ~PAGE_MASK])
-			if (!(++inputmargin & ~PAGE_MASK))
-				break;
-
-		if (inputmargin >= rq->inputsize) {
+		ret = z_erofs_fixup_insize(rq, headpage + rq->pageofs_in,
+				min_t(unsigned int, rq->inputsize,
+				      EROFS_BLKSIZ - rq->pageofs_in));
+		if (ret) {
 			kunmap_atomic(headpage);
-			return -EIO;
+			return ret;
 		}
 	}
 
-	rq->inputsize -= inputmargin;
+	inputmargin = rq->pageofs_in;
 	src = z_erofs_lz4_handle_overlap(ctx, headpage, &inputmargin,
 					 &maptype, support_0padding);
 	if (IS_ERR(src))
diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
index 50045510a1f4..05a3063cf2bc 100644
--- a/fs/erofs/decompressor_lzma.c
+++ b/fs/erofs/decompressor_lzma.c
@@ -156,7 +156,7 @@ int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
 	const unsigned int nrpages_in =
 		PAGE_ALIGN(rq->inputsize) >> PAGE_SHIFT;
-	unsigned int inputmargin, inlen, outlen, pageofs;
+	unsigned int inlen, outlen, pageofs;
 	struct z_erofs_lzma *strm;
 	u8 *kin;
 	bool bounced = false;
@@ -164,16 +164,13 @@ int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 
 	/* 1. get the exact LZMA compressed size */
 	kin = kmap(*rq->in);
-	inputmargin = 0;
-	while (!kin[inputmargin & ~PAGE_MASK])
-		if (!(++inputmargin & ~PAGE_MASK))
-			break;
-
-	if (inputmargin >= PAGE_SIZE) {
+	err = z_erofs_fixup_insize(rq, kin + rq->pageofs_in,
+				   min_t(unsigned int, rq->inputsize,
+					 EROFS_BLKSIZ - rq->pageofs_in));
+	if (err) {
 		kunmap(*rq->in);
-		return -EFSCORRUPTED;
+		return err;
 	}
-	rq->inputsize -= inputmargin;
 
 	/* 2. get an available lzma context */
 again:
@@ -193,9 +190,9 @@ int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 	xz_dec_microlzma_reset(strm->state, inlen, outlen,
 			       !rq->partial_decoding);
 	pageofs = rq->pageofs_out;
-	strm->buf.in = kin + inputmargin;
+	strm->buf.in = kin + rq->pageofs_in;
 	strm->buf.in_pos = 0;
-	strm->buf.in_size = min_t(u32, inlen, PAGE_SIZE - inputmargin);
+	strm->buf.in_size = min_t(u32, inlen, PAGE_SIZE - rq->pageofs_in);
 	inlen -= strm->buf.in_size;
 	strm->buf.out = NULL;
 	strm->buf.out_pos = 0;
-- 
2.24.4

