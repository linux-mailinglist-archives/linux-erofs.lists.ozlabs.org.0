Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3948A6A2A2
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2019 09:05:37 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45nryQ2l6czDqKt
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2019 17:05:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.191; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45nrxd3pkMzDqKt
 for <linux-erofs@lists.ozlabs.org>; Tue, 16 Jul 2019 17:04:53 +1000 (AEST)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 87A22F3E780A500B8D14;
 Tue, 16 Jul 2019 15:04:50 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 16 Jul
 2019 15:04:42 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Li Guifu <bluce.liguifu@huawei.com>, Fang Wei <fangwei1@huawei.com>
Subject: [PATCH v2 16/17] erofs-utils: support decompress in-place
Date: Tue, 16 Jul 2019 15:04:18 +0800
Message-ID: <20190716070419.30203-17-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190716070419.30203-1-gaoxiang25@huawei.com>
References: <20190716070419.30203-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
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
Cc: Miao Xie <miaoxie@huawei.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In the view of kernel, it usually loads compressed data into
last pages of the extent (the last page for 4k) for in-place
decompression (more specifically, in-place IO), as ilustration
below,

         start of compressed logical extent
           |                          end of this logical extent
           |                           |
     ______v___________________________v________
... |  page 6  |  page 7  |  page 8  |  page 9  | ...
    |__________|__________|__________|__________|
           .                         ^ .        ^
           .                         |compressed|
           .                         |   data   |
           .                           .        .
           |<          dstsize        >|<margin>|
                                       oend     iend
           op                        ip

It's natural to think it further, why not decompressing in-place?

1) Decompressing in-place can be easily implemented since oend is
   _strictly_ not greater than iend for fixed-output decompression;
2) Decompressing in-place can be guaranteed with a appropriate
   minimum margin rather than do decompress simulatation
   for all extents;
*) Many implementations of memcpy can perform overlapped copy
   well if op <= ip (it'd better to use memmove, of course).

This patch enables 0PADDING in order to support decompress in-place.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 include/erofs/internal.h |  2 ++
 include/erofs_fs.h       | 14 +++++++--
 lib/compress.c           | 61 +++++++++++++++++++++++++++-------------
 lib/config.c             |  2 ++
 mkfs/main.c              |  1 +
 5 files changed, 57 insertions(+), 23 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 07a6f72..b7ce6f8 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -51,6 +51,8 @@ struct erofs_buffer_head;
 struct erofs_sb_info {
 	erofs_blk_t meta_blkaddr;
 	erofs_blk_t xattr_blkaddr;
+
+	u32 requirements;
 };
 
 /* global sbi */
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index d9999bb..ad01494 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -17,10 +17,17 @@
 #define EROFS_SUPER_MAGIC_V1    0xE0F5E1E2
 #define EROFS_SUPER_OFFSET      1024
 
+/*
+ * Any bits that aren't in EROFS_ALL_REQUIREMENTS should be
+ * incompatible with this kernel version.
+ */
+#define EROFS_REQUIREMENT_LZ4_0PADDING	0x00000001
+#define EROFS_ALL_REQUIREMENTS		EROFS_REQUIREMENT_LZ4_0PADDING
+
 struct erofs_super_block {
 /*  0 */__le32 magic;           /* in the little endian */
 /*  4 */__le32 checksum;        /* crc32c(super_block) */
-/*  8 */__le32 features;
+/*  8 */__le32 features;        /* (aka. feature_compat) */
 /* 12 */__u8 blkszbits;         /* support block_size == PAGE_SIZE only */
 /* 13 */__u8 reserved;
 
@@ -34,9 +41,10 @@ struct erofs_super_block {
 /* 44 */__le32 xattr_blkaddr;
 /* 48 */__u8 uuid[16];          /* 128-bit uuid for volume */
 /* 64 */__u8 volume_name[16];   /* volume name */
+/* 80 */__le32 requirements;    /* (aka. feature_incompat) */
 
-/* 80 */__u8 reserved2[48];     /* 128 bytes */
-} __packed;
+/* 84 */__u8 reserved2[44];
+} __packed;                     /* 128 bytes */
 
 /*
  * erofs inode data mapping:
diff --git a/lib/compress.c b/lib/compress.c
index 0063b97..bb799b4 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -110,6 +110,36 @@ static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
 	ctx->clusterofs = clusterofs + count;
 }
 
+static int write_uncompressed_block(struct z_erofs_vle_compress_ctx *ctx,
+				    unsigned int *len,
+				    char *dst)
+{
+	int ret;
+	unsigned int count;
+
+	if (!(sbi.requirements & EROFS_REQUIREMENT_LZ4_0PADDING)) {
+		/* fix up clusterofs to 0 if possable */
+		if (ctx->head >= ctx->clusterofs) {
+			ctx->head -= ctx->clusterofs;
+			*len += ctx->clusterofs;
+			ctx->clusterofs = 0;
+		}
+	}
+
+	/* write uncompressed data */
+	count = min(EROFS_BLKSIZ, *len);
+
+	memcpy(dst, ctx->queue + ctx->head, count);
+	memset(dst + count, 0, EROFS_BLKSIZ - count);
+
+	erofs_dbg("Writing %u uncompressed data to block %u",
+		  count, ctx->blkaddr);
+	ret = blk_write(dst, ctx->blkaddr, 1);
+	if (ret)
+		return ret;
+	return count;
+}
+
 static int vle_compress_one(struct erofs_inode *inode,
 			    struct z_erofs_vle_compress_ctx *ctx,
 			    bool final)
@@ -118,7 +148,8 @@ static int vle_compress_one(struct erofs_inode *inode,
 	unsigned int len = ctx->tail - ctx->head;
 	unsigned int count;
 	int ret;
-	char dst[EROFS_BLKSIZ];
+	static char dstbuf[EROFS_BLKSIZ * 2];
+	char *const dst = dstbuf + EROFS_BLKSIZ;
 
 	while (len) {
 		bool raw;
@@ -140,32 +171,22 @@ static int vle_compress_one(struct erofs_inode *inode,
 					  erofs_strerror(ret));
 			}
 nocompression:
-			/* fix up clusterofs to 0 if possable */
-			if (ctx->head >= ctx->clusterofs) {
-				ctx->head -= ctx->clusterofs;
-				len += ctx->clusterofs;
-				ctx->clusterofs = 0;
-			}
-
-			/* write uncompressed data */
-			count = min(EROFS_BLKSIZ, len);
-
-			memcpy(dst, ctx->queue + ctx->head, count);
-			memset(dst + count, 0, EROFS_BLKSIZ - count);
-
-			erofs_dbg("Writing %u uncompressed data to block %u",
-				  count, ctx->blkaddr);
-
-			ret = blk_write(dst, ctx->blkaddr, 1);
-			if (ret)
+			ret = write_uncompressed_block(ctx, &len, dst);
+			if (ret < 0)
 				return ret;
+			count = ret;
 			raw = true;
 		} else {
 			/* write compressed data */
 			erofs_dbg("Writing %u compressed data to block %u",
 				  count, ctx->blkaddr);
 
-			ret = blk_write(dst, ctx->blkaddr, 1);
+			if (sbi.requirements & EROFS_REQUIREMENT_LZ4_0PADDING)
+				ret = blk_write(dst - (EROFS_BLKSIZ - ret),
+						ctx->blkaddr, 1);
+			else
+				ret = blk_write(dst, ctx->blkaddr, 1);
+
 			if (ret)
 				return ret;
 			raw = false;
diff --git a/lib/config.c b/lib/config.c
index 07e2846..2e91b92 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -8,6 +8,7 @@
  */
 #include <string.h>
 #include "erofs/print.h"
+#include "erofs/internal.h"
 
 struct erofs_configure cfg;
 
@@ -20,6 +21,7 @@ void erofs_init_configure(void)
 	cfg.c_dry_run  = false;
 	cfg.c_legacy_compress = false;
 	cfg.c_compr_level_master = -1;
+	sbi.requirements = EROFS_REQUIREMENT_LZ4_0PADDING;
 }
 
 void erofs_show_config(void)
diff --git a/mkfs/main.c b/mkfs/main.c
index 595137b..eb75bdb 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -107,6 +107,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 		.blocks = 0,
 		.meta_blkaddr  = sbi.meta_blkaddr,
 		.xattr_blkaddr = 0,
+		.requirements = cpu_to_le32(sbi.requirements),
 	};
 	const unsigned int sb_blksize =
 		round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
-- 
2.17.1

