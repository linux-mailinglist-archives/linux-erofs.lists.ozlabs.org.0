Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D486192B42D
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Jul 2024 11:41:39 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LGgm2p8K;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WJGGT4bhXz3dBZ
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Jul 2024 19:41:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LGgm2p8K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WJGG61nKWz30WJ
	for <linux-erofs@lists.ozlabs.org>; Tue,  9 Jul 2024 19:41:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720518072; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=mnfODdi6xR1Qy20b5GA/C0RKjSjBbS/0pCoFXuPsCN4=;
	b=LGgm2p8Kh8v6V6Ux3sDPCw/FFGA6ZIpm/0Lew0GtjgMuA1P+QgbuqCO0JBojXy7dvTvd5jkG5SH5sjyXT4VDfsNxEe7PR7P9spAXrSW+g6ChrRfatxDANvLgiQ5amyGsWHrj07r3mpIHLV785Mir4jwZntig/H7u1VWW6OA+CYc=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0WABZZmR_1720518067;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WABZZmR_1720518067)
          by smtp.aliyun-inc.com;
          Tue, 09 Jul 2024 17:41:11 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/3] erofs: move each decompressor to its own source file
Date: Tue,  9 Jul 2024 17:41:04 +0800
Message-ID: <20240709094106.3018109-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Thus *_config() function declarations can be avoided.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/compress.h             | 20 +++++-------------
 fs/erofs/decompressor.c         | 36 ++++++++++-----------------------
 fs/erofs/decompressor_deflate.c | 12 ++++++++---
 fs/erofs/decompressor_lzma.c    | 12 ++++++++---
 fs/erofs/decompressor_zstd.c    | 12 ++++++++---
 fs/erofs/zdata.c                |  2 +-
 6 files changed, 44 insertions(+), 50 deletions(-)

diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index 19d53c30c8af..c68d5739932f 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -81,21 +81,11 @@ static inline bool z_erofs_put_shortlivedpage(struct page **pagepool,
 	return true;
 }
 
+extern const struct z_erofs_decompressor z_erofs_lzma_decomp;
+extern const struct z_erofs_decompressor z_erofs_deflate_decomp;
+extern const struct z_erofs_decompressor z_erofs_zstd_decomp;
+extern const struct z_erofs_decompressor *z_erofs_decomp[];
+
 int z_erofs_fixup_insize(struct z_erofs_decompress_req *rq, const char *padbuf,
 			 unsigned int padbufsize);
-extern const struct z_erofs_decompressor erofs_decompressors[];
-
-/* prototypes for specific algorithms */
-int z_erofs_load_lzma_config(struct super_block *sb,
-			struct erofs_super_block *dsb, void *data, int size);
-int z_erofs_load_deflate_config(struct super_block *sb,
-			struct erofs_super_block *dsb, void *data, int size);
-int z_erofs_load_zstd_config(struct super_block *sb,
-			struct erofs_super_block *dsb, void *data, int size);
-int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
-			    struct page **pagepool);
-int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
-			       struct page **pagepool);
-int z_erofs_zstd_decompress(struct z_erofs_decompress_req *rq,
-			    struct page **pgpl);
 #endif
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 9d85b6c11c6b..de50a9de4e8a 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -371,40 +371,28 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
 	return 0;
 }
 
-const struct z_erofs_decompressor erofs_decompressors[] = {
-	[Z_EROFS_COMPRESSION_SHIFTED] = {
+const struct z_erofs_decompressor *z_erofs_decomp[] = {
+	[Z_EROFS_COMPRESSION_SHIFTED] = &(const struct z_erofs_decompressor) {
 		.decompress = z_erofs_transform_plain,
 		.name = "shifted"
 	},
-	[Z_EROFS_COMPRESSION_INTERLACED] = {
+	[Z_EROFS_COMPRESSION_INTERLACED] = &(const struct z_erofs_decompressor) {
 		.decompress = z_erofs_transform_plain,
 		.name = "interlaced"
 	},
-	[Z_EROFS_COMPRESSION_LZ4] = {
+	[Z_EROFS_COMPRESSION_LZ4] = &(const struct z_erofs_decompressor) {
 		.config = z_erofs_load_lz4_config,
 		.decompress = z_erofs_lz4_decompress,
 		.name = "lz4"
 	},
 #ifdef CONFIG_EROFS_FS_ZIP_LZMA
-	[Z_EROFS_COMPRESSION_LZMA] = {
-		.config = z_erofs_load_lzma_config,
-		.decompress = z_erofs_lzma_decompress,
-		.name = "lzma"
-	},
+	[Z_EROFS_COMPRESSION_LZMA] = &z_erofs_lzma_decomp,
 #endif
 #ifdef CONFIG_EROFS_FS_ZIP_DEFLATE
-	[Z_EROFS_COMPRESSION_DEFLATE] = {
-		.config = z_erofs_load_deflate_config,
-		.decompress = z_erofs_deflate_decompress,
-		.name = "deflate"
-	},
+	[Z_EROFS_COMPRESSION_DEFLATE] = &z_erofs_deflate_decomp,
 #endif
 #ifdef CONFIG_EROFS_FS_ZIP_ZSTD
-	[Z_EROFS_COMPRESSION_ZSTD] = {
-		.config = z_erofs_load_zstd_config,
-		.decompress = z_erofs_zstd_decompress,
-		.name = "zstd"
-	},
+	[Z_EROFS_COMPRESSION_ZSTD] = &z_erofs_zstd_decomp,
 #endif
 };
 
@@ -432,6 +420,7 @@ int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb)
 	offset = EROFS_SUPER_OFFSET + sbi->sb_size;
 	alg = 0;
 	for (algs = sbi->available_compr_algs; algs; algs >>= 1, ++alg) {
+		const struct z_erofs_decompressor *dec = z_erofs_decomp[alg];
 		void *data;
 
 		if (!(algs & 1))
@@ -443,16 +432,13 @@ int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb)
 			break;
 		}
 
-		if (alg >= ARRAY_SIZE(erofs_decompressors) ||
-		    !erofs_decompressors[alg].config) {
+		if (alg < Z_EROFS_COMPRESSION_MAX && dec && dec->config) {
+			ret = dec->config(sb, dsb, data, size);
+		} else {
 			erofs_err(sb, "algorithm %d isn't enabled on this kernel",
 				  alg);
 			ret = -EOPNOTSUPP;
-		} else {
-			ret = erofs_decompressors[alg].config(sb,
-					dsb, data, size);
 		}
-
 		kfree(data);
 		if (ret)
 			break;
diff --git a/fs/erofs/decompressor_deflate.c b/fs/erofs/decompressor_deflate.c
index 3a3461561a3c..1c0ed77dcdb2 100644
--- a/fs/erofs/decompressor_deflate.c
+++ b/fs/erofs/decompressor_deflate.c
@@ -49,7 +49,7 @@ int __init z_erofs_deflate_init(void)
 	return 0;
 }
 
-int z_erofs_load_deflate_config(struct super_block *sb,
+static int z_erofs_load_deflate_config(struct super_block *sb,
 			struct erofs_super_block *dsb, void *data, int size)
 {
 	struct z_erofs_deflate_cfgs *dfl = data;
@@ -97,8 +97,8 @@ int z_erofs_load_deflate_config(struct super_block *sb,
 	return -ENOMEM;
 }
 
-int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
-			       struct page **pgpl)
+static int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
+				      struct page **pgpl)
 {
 	const unsigned int nrpages_out =
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
@@ -252,3 +252,9 @@ int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
 	wake_up(&z_erofs_deflate_wq);
 	return err;
 }
+
+const struct z_erofs_decompressor z_erofs_deflate_decomp = {
+	.config = z_erofs_load_deflate_config,
+	.decompress = z_erofs_deflate_decompress,
+	.name = "deflate",
+};
diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
index 4b28dc130c9f..9cab3a2f7558 100644
--- a/fs/erofs/decompressor_lzma.c
+++ b/fs/erofs/decompressor_lzma.c
@@ -70,7 +70,7 @@ int __init z_erofs_lzma_init(void)
 	return 0;
 }
 
-int z_erofs_load_lzma_config(struct super_block *sb,
+static int z_erofs_load_lzma_config(struct super_block *sb,
 			struct erofs_super_block *dsb, void *data, int size)
 {
 	static DEFINE_MUTEX(lzma_resize_mutex);
@@ -147,8 +147,8 @@ int z_erofs_load_lzma_config(struct super_block *sb,
 	return err;
 }
 
-int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
-			    struct page **pgpl)
+static int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
+				   struct page **pgpl)
 {
 	const unsigned int nrpages_out =
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
@@ -293,3 +293,9 @@ int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 	wake_up(&z_erofs_lzma_wq);
 	return err;
 }
+
+const struct z_erofs_decompressor z_erofs_lzma_decomp = {
+	.config = z_erofs_load_lzma_config,
+	.decompress = z_erofs_lzma_decompress,
+	.name = "lzma"
+};
diff --git a/fs/erofs/decompressor_zstd.c b/fs/erofs/decompressor_zstd.c
index 63a23cac3af4..e8f931d41e60 100644
--- a/fs/erofs/decompressor_zstd.c
+++ b/fs/erofs/decompressor_zstd.c
@@ -72,7 +72,7 @@ int __init z_erofs_zstd_init(void)
 	return 0;
 }
 
-int z_erofs_load_zstd_config(struct super_block *sb,
+static int z_erofs_load_zstd_config(struct super_block *sb,
 			struct erofs_super_block *dsb, void *data, int size)
 {
 	static DEFINE_MUTEX(zstd_resize_mutex);
@@ -135,8 +135,8 @@ int z_erofs_load_zstd_config(struct super_block *sb,
 	return strm ? -ENOMEM : 0;
 }
 
-int z_erofs_zstd_decompress(struct z_erofs_decompress_req *rq,
-			    struct page **pgpl)
+static int z_erofs_zstd_decompress(struct z_erofs_decompress_req *rq,
+				   struct page **pgpl)
 {
 	const unsigned int nrpages_out =
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
@@ -277,3 +277,9 @@ int z_erofs_zstd_decompress(struct z_erofs_decompress_req *rq,
 	wake_up(&z_erofs_zstd_wq);
 	return err;
 }
+
+const struct z_erofs_decompressor z_erofs_zstd_decomp = {
+	.config = z_erofs_load_zstd_config,
+	.decompress = z_erofs_zstd_decompress,
+	.name = "zstd",
+};
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index d6fe002a4a71..40ad9c80433e 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1221,7 +1221,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	struct z_erofs_pcluster *pcl = be->pcl;
 	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
 	const struct z_erofs_decompressor *decomp =
-				&erofs_decompressors[pcl->algorithmformat];
+				z_erofs_decomp[pcl->algorithmformat];
 	int i, err2;
 	struct page *page;
 	bool overlapped;
-- 
2.43.5

