Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A5B74C6FE
	for <lists+linux-erofs@lfdr.de>; Sun,  9 Jul 2023 20:25:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QzbD90WlSz3bnm
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Jul 2023 04:25:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QzbCr1XDjz30f9
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Jul 2023 04:25:27 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vmvrojx_1688927122;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vmvrojx_1688927122)
          by smtp.aliyun-inc.com;
          Mon, 10 Jul 2023 02:25:24 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 4/4] erofs-utils: mkfs: add DEFLATE algorithm support
Date: Mon, 10 Jul 2023 02:25:11 +0800
Message-Id: <20230709182511.96954-5-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230709182511.96954-1-hsiangkao@linux.alibaba.com>
References: <20230709182511.96954-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patch adds DEFLATE compression algorithm support to erofs-utils
compression framework.

Note that windowbits (which indicates dictionary size) is recorded in
the on-disk compression configuration.  Since some accelerators (e.g.
Intel IAA) don't have enough on-chip memory, compressed data generated
with large windowbits (e.g. > 12 for the IAA accelerator) doesn't seem
to be worked properly on those.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/Makefile.am          |  2 +-
 lib/compress.c           | 24 +++++++++++++
 lib/compressor.c         |  1 +
 lib/compressor.h         |  1 +
 lib/compressor_deflate.c | 77 ++++++++++++++++++++++++++++++++++++++++
 lib/decompress.c         |  8 +++--
 6 files changed, 109 insertions(+), 4 deletions(-)
 create mode 100644 lib/compressor_deflate.c

diff --git a/lib/Makefile.am b/lib/Makefile.am
index fa3b804..553b387 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -44,4 +44,4 @@ liberofs_la_CFLAGS += ${liblzma_CFLAGS}
 liberofs_la_SOURCES += compressor_liblzma.c
 endif
 
-liberofs_la_SOURCES += kite_deflate.c
+liberofs_la_SOURCES += kite_deflate.c compressor_deflate.c
diff --git a/lib/compress.c b/lib/compress.c
index 14d228f..318b8de 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1026,6 +1026,8 @@ static int erofs_get_compress_algorithm_id(const char *name)
 		return Z_EROFS_COMPRESSION_LZ4;
 	if (!strcmp(name, "lzma"))
 		return Z_EROFS_COMPRESSION_LZMA;
+	if (!strcmp(name, "deflate"))
+		return Z_EROFS_COMPRESSION_DEFLATE;
 	return -ENOTSUP;
 }
 
@@ -1080,6 +1082,28 @@ int z_erofs_build_compr_cfgs(struct erofs_buffer_head *sb_bh)
 		bh->op = &erofs_drop_directly_bhops;
 	}
 #endif
+	if (sbi.available_compr_algs & (1 << Z_EROFS_COMPRESSION_DEFLATE)) {
+		struct {
+			__le16 size;
+			struct z_erofs_deflate_cfgs z;
+		} __packed zalg = {
+			.size = cpu_to_le16(sizeof(struct z_erofs_deflate_cfgs)),
+			.z = {
+				.windowbits =
+					cpu_to_le32(ilog2(cfg.c_dict_size)),
+			}
+		};
+
+		bh = erofs_battach(bh, META, sizeof(zalg));
+		if (IS_ERR(bh)) {
+			DBG_BUGON(1);
+			return PTR_ERR(bh);
+		}
+		erofs_mapbh(bh->block);
+		ret = dev_write(&zalg, erofs_btell(bh, false),
+				sizeof(zalg));
+		bh->op = &erofs_drop_directly_bhops;
+	}
 	return ret;
 }
 
diff --git a/lib/compressor.c b/lib/compressor.c
index 52eb761..ca4d364 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -20,6 +20,7 @@ static const struct erofs_compressor *compressors[] = {
 #if HAVE_LIBLZMA
 		&erofs_compressor_lzma,
 #endif
+		&erofs_compressor_deflate,
 };
 
 int erofs_compress_destsize(const struct erofs_compress *c,
diff --git a/lib/compressor.h b/lib/compressor.h
index cf063f1..c1eee20 100644
--- a/lib/compressor.h
+++ b/lib/compressor.h
@@ -44,6 +44,7 @@ struct erofs_compress {
 extern const struct erofs_compressor erofs_compressor_lz4;
 extern const struct erofs_compressor erofs_compressor_lz4hc;
 extern const struct erofs_compressor erofs_compressor_lzma;
+extern const struct erofs_compressor erofs_compressor_deflate;
 
 int erofs_compress_destsize(const struct erofs_compress *c,
 			    const void *src, unsigned int *srcsize,
diff --git a/lib/compressor_deflate.c b/lib/compressor_deflate.c
new file mode 100644
index 0000000..ad76b7c
--- /dev/null
+++ b/lib/compressor_deflate.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
+/*
+ * Copyright (C) 2023, Alibaba Cloud
+ * Copyright (C) 2023, Gao Xiang <xiang@kernel.org>
+ */
+#include "erofs/internal.h"
+#include "erofs/print.h"
+#include "erofs/config.h"
+#include "compressor.h"
+
+void *kite_deflate_init(int level, unsigned int dict_size);
+void kite_deflate_end(void *s);
+int kite_deflate_destsize(void *s, const u8 *in, u8 *out,
+			  unsigned int *srcsize, unsigned int target_dstsize);
+
+static int deflate_compress_destsize(const struct erofs_compress *c,
+				     const void *src, unsigned int *srcsize,
+				     void *dst, unsigned int dstsize)
+{
+	int rc = kite_deflate_destsize(c->private_data, src, dst,
+				       srcsize, dstsize);
+
+	if (rc <= 0)
+		return -EFAULT;
+	return rc;
+}
+
+static int compressor_deflate_exit(struct erofs_compress *c)
+{
+	if (!c->private_data)
+		return -EINVAL;
+
+	kite_deflate_end(c->private_data);
+	return 0;
+}
+
+static int compressor_deflate_init(struct erofs_compress *c)
+{
+	c->alg = &erofs_compressor_deflate;
+	c->private_data = NULL;
+
+	erofs_warn("EXPERIMENTAL DEFLATE feature in use. Use at your own risk!");
+	erofs_warn("Please *carefully* check filesystem data correctness to avoid corruption!");
+	return 0;
+}
+
+static int erofs_compressor_deflate_setlevel(struct erofs_compress *c,
+					     int compression_level)
+{
+	void *s;
+
+	if (c->private_data) {
+		kite_deflate_end(c->private_data);
+		c->private_data = NULL;
+	}
+
+	if (compression_level < 0)
+		compression_level = erofs_compressor_deflate.default_level;
+
+	s = kite_deflate_init(compression_level, cfg.c_dict_size);
+	if (IS_ERR(s))
+		return PTR_ERR(s);
+
+	c->private_data = s;
+	c->compression_level = compression_level;
+	return 0;
+}
+
+const struct erofs_compressor erofs_compressor_deflate = {
+	.name = "deflate",
+	.default_level = 1,
+	.best_level = 9,
+	.init = compressor_deflate_init,
+	.exit = compressor_deflate_exit,
+	.setlevel = erofs_compressor_deflate_setlevel,
+	.compress_destsize = deflate_compress_destsize,
+};
diff --git a/lib/decompress.c b/lib/decompress.c
index 5bc55c5..a3e8ed7 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -133,9 +133,11 @@ static int z_erofs_decompress_deflate(struct z_erofs_decompress_req *rq)
 	strm.avail_out = rq->decodedlength;
 
 	ret = inflate(&strm, rq->partial_decoding ? Z_SYNC_FLUSH : Z_FINISH);
-	if (ret != Z_STREAM_END) {
-		ret = zerr(ret);
-		goto out_inflate_end;
+	if (ret != Z_STREAM_END || strm.total_out != rq->decodedlength) {
+		if (rq->partial_decoding && ret != Z_OK) {
+			ret = zerr(ret);
+			goto out_inflate_end;
+		}
 	}
 
 	if (rq->decodedskip)
-- 
2.24.4

