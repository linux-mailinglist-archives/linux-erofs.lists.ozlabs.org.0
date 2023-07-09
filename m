Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829F274C77E
	for <lists+linux-erofs@lfdr.de>; Sun,  9 Jul 2023 20:52:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QzbpS3MJjz3f6q
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Jul 2023 04:52:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QzbgB3Pgnz3dWm
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Jul 2023 04:45:42 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vmvryh1_1688928336;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vmvryh1_1688928336)
          by smtp.aliyun-inc.com;
          Mon, 10 Jul 2023 02:45:38 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 4/4] erofs-utils: mkfs: add DEFLATE algorithm support
Date: Mon, 10 Jul 2023 02:45:25 +0800
Message-Id: <20230709184525.120677-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230709184525.120677-1-hsiangkao@linux.alibaba.com>
References: <20230709182511.96954-1-hsiangkao@linux.alibaba.com>
 <20230709184525.120677-1-hsiangkao@linux.alibaba.com>
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
v2:
  improve print message.

 lib/Makefile.am          |  2 +-
 lib/compress.c           | 24 +++++++++++++
 lib/compressor.c         |  1 +
 lib/compressor.h         |  1 +
 lib/compressor_deflate.c | 78 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 105 insertions(+), 1 deletion(-)
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
index 0000000..5a7a657
--- /dev/null
+++ b/lib/compressor_deflate.c
@@ -0,0 +1,78 @@
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
+	erofs_warn("EXPERIMENTAL DEFLATE algorithm in use. Use at your own risk!");
+	erofs_warn("*Carefully* check filesystem data correctness to avoid corruption!");
+	erofs_warn("Please send a report to <linux-erofs@lists.ozlabs.org> if something is wrong.");
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
-- 
2.24.4

