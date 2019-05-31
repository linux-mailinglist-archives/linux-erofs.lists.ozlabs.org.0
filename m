Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABEC305F4
	for <lists+linux-erofs@lfdr.de>; Fri, 31 May 2019 02:52:10 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45FQrl55CZzDqSv
	for <lists+linux-erofs@lfdr.de>; Fri, 31 May 2019 10:52:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1559263927;
	bh=tOu2NaDy0sQhG6DkKkZD4cXVGc4wg4kXiVSri1iN8oc=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=j5G4TCueedX6Phd5sFlu6oZSeCQJIu3M0avqmxjPf0daybW74nz9uAiM0EfalA8tI
	 bu9UUXD1cbxzjf5BPgKfpXGp2iSUBq3lFOXU5gzhzKJHtaWGhhiJMhwKgt/jElayi3
	 mgl/LgFDQHEDeIVr9If1FoaFGAylZrR58Nw6N1Ep8lusrYCe9V54UAudDm5zu9ETJk
	 sV9Y8a0Rj9drOop76q3kgMugilTquT3Cw6yuzs+tsxvGu+sfjRCnejpJw5ywbRv1UR
	 spDKe97dNhpTackkagbri4SRFWFnARoRYNY9u9Ec73xm4di+tDxjTDVJiSqEHjaLKc
	 63CvKou5pRa+Q==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.68.206; helo=sonic304-25.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="MfkZJIt/"; 
 dkim-atps=neutral
Received: from sonic304-25.consmr.mail.gq1.yahoo.com
 (sonic304-25.consmr.mail.gq1.yahoo.com [98.137.68.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45FQrV46JmzDqTK
 for <linux-erofs@lists.ozlabs.org>; Fri, 31 May 2019 10:51:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1559263912; bh=6noYIvp5e736j3mwfie/GLeklN1SGAYtzfcCooLNVL4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=MfkZJIt/H5JfhIP7rSA1OVt20mmBIA6ZMgGILgPjxTxFVLEOx8JG/CW4ewvpG/mfHALNMdAcLvyOH/DJ4WP5ioVlVCXSBII+LxikuGY5U6+phdy5LiE7pTGRIStUoAWyCTWj8DSMKl8kZxnFYaXye9BAd0a/XBQt8bnym306F7jsgkirlGuT8dnNMCzyOgikQC7xotEkfthxQ3GDC/r6rqq2lotllHHICXravn6qJD4L+gpdnYhb/jFTpNtNvycCxgW9PfjW5gb7MDKR7XVgGWJALCTyBWUjbDbRnKrVkulp+Igtxw791CxykS8efsg4FFjbPt+42lt/1oobGov6RQ==
X-YMail-OSG: S8_2tO4VM1kbo_yNMdeQ0dvWXuzj68E97kSuT9JT6m_PY73P8A9pNQ9td9b.gpl
 5dPoMpTBktQJQmfVCR31V5hmMFZqfKtvwaUS4RM0pbVuXGLgwUyt6DVweKqd2hNTHLx59UcMW.Sx
 k0PzZ7Ej83oNF3dVo2Wi5upxOt9ym43lYGkHW6tLcrq7d7k79DnEfAUIUUUaTDSM.u1iVo6MBTEG
 02YywJWdbSPWG2YhmjV.zj0VTBDyDbMFjPDy473A13ozqE0yWtC2QmW3sTd.jomSdMrHgx_SxqYb
 h77kHu6HMM9QAaPqgCXAvTJOwdcQli61lOmD4luba2kuXcCvXNwQPASCvQPq3imV8yIAMJJkilT2
 0T4LMscWm3MMxfdI0UBB2QkNZO56e5qcCMQtW2jJzDHUNzWNPCvdUTxv5MztlVNNpck8niPHCALh
 rHrxygpGdZV28v.SU_ZO2Ut6Hw_RNFOxS1dn3fdx5eoXtQHiLFtVraByfD14wgjY0kQRypYqKG5v
 7jk1T.TqSmA4GDRhq3mr1B0F5_5Pwgfk87.5ysmGcFHqHPfA0RvzdtBWIMlf7IEpkmJHJpINmwnm
 YVsMOhQ5hTaMmZnUb.V4YduhJHx7V55EtnDX3Kj5rfR1G0d0wwGSBtbyV0cJ.Kg36F9M8cg32FKw
 891kT1b2Q6edVmtNFcPxzvMcqiqvEGh1JO7G3n5VK.rA.779UTQcLvAZ2GxZ0c42GySqSnTTYj1w
 Xhlt9apKSoUxyd8ocblrbpDcRg.CorRtxW0UT0pJUYaojw7z_KgoUBDXwXj6MIVAvnrzvRH1ZtYV
 pHfzP_zjIYmsmWbP0J1hQSaIwGo3rSJisNbleAt3M624E9OJqKvZqoir4g_2r4HQNqglTstVwrEG
 7Whu4uBaAF7IzD3bfHlh3uUIrRTlD8S7DhtmghFmes60tqSY_OhXd4_iMK9HMhyRRnp0i99g8QrC
 whb1Cdicf.Q4_BbbzX_ghQVO4fV9NBmqUjlYP2Obt_INgwSB2TfG4gWzLa0zQOHSX2Qc_tetIMvS
 UMK0j90xl8YAnWYiJr9Dl.Vgokm_0DSJzV6FhunPp2PdznoMdpWN6YasKxcHU.v4JiS_wiodXeO5
 vj7bBQDlam6LYQVrwdRdBwszMiOhuymhwVxSXPsOROztfpTNbD3CIUk9I_w_DXfmS2wI4Ol7CdR6
 gbSDk14_ZuW5TfhdNTussxZKCtXFu4ZBY8sYLJqaLb9GZ1DEbN8q4BehkcUkgAXIXkBX._ofrMQ-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic304.consmr.mail.gq1.yahoo.com with HTTP; Fri, 31 May 2019 00:51:52 +0000
Received: from 125.120.86.223 (EHLO localhost.localdomain) ([125.120.86.223])
 by smtp417.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID a9e989b6e54ef4fb7ecb5a20a6091749; 
 Fri, 31 May 2019 00:51:50 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 10/13] erofs-utils: introduce compression for regular files
Date: Fri, 31 May 2019 08:50:44 +0800
Message-Id: <20190531005047.22093-11-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190531005047.22093-1-hsiangkao@aol.com>
References: <20190531005047.22093-1-hsiangkao@aol.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <gaoxiang25@huawei.com>

Yay! Let's try to transparent file compression
for all regular files if necessary.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 include/erofs/compress.h |  25 ++++
 include/erofs/config.h   |   2 +
 include/erofs/internal.h |   1 +
 lib/Makefile.am          |   2 +-
 lib/compress.c           | 303 +++++++++++++++++++++++++++++++++++++++
 lib/config.c             |   1 +
 lib/inode.c              |  18 ++-
 mkfs/main.c              |  21 +++
 8 files changed, 369 insertions(+), 4 deletions(-)
 create mode 100644 include/erofs/compress.h
 create mode 100644 lib/compress.c

diff --git a/include/erofs/compress.h b/include/erofs/compress.h
new file mode 100644
index 0000000..e0abb8f
--- /dev/null
+++ b/include/erofs/compress.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * erofs_utils/include/erofs/compress.h
+ *
+ * Copyright (C) 2019 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Gao Xiang <gaoxiang25@huawei.com>
+ */
+#ifndef __EROFS_COMPRESS_H
+#define __EROFS_COMPRESS_H
+
+#include "internal.h"
+
+/* workaround for an upstream lz4 compression issue, which can crash us */
+/* #define EROFS_CONFIG_COMPR_MAX_SZ        (1024 * 1024) */
+#define EROFS_CONFIG_COMPR_MAX_SZ           (900  * 1024)
+#define EROFS_CONFIG_COMPR_MIN_SZ           (32   * 1024)
+
+int erofs_write_compressed_file(struct erofs_inode *inode);
+
+int z_erofs_compress_init(void);
+int z_erofs_compress_exit(void);
+
+#endif
+
diff --git a/include/erofs/config.h b/include/erofs/config.h
index e31732b..177017b 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -19,6 +19,8 @@ struct erofs_configure {
 	/* related arguments for mkfs.erofs */
 	char *c_img_path;
 	char *c_src_path;
+	char *c_compr_alg_master;
+	int c_compr_level_master;
 };
 
 extern struct erofs_configure cfg;
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index dfa6173..78da589 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -94,6 +94,7 @@ struct erofs_inode {
 	struct erofs_buffer_head *bh_inline, *bh_data;
 
 	void *idata;
+	void *compressmeta;
 };
 
 #define IS_ROOT(x)	((x) == (x)->i_parent)
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 17dc9e1..dea82f7 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -2,7 +2,7 @@
 # Makefile.am
 
 noinst_LTLIBRARIES = liberofs.la
-liberofs_la_SOURCES = config.c io.c cache.c inode.c compressor.c
+liberofs_la_SOURCES = config.c io.c cache.c inode.c compress.c compressor.c
 liberofs_la_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
 if ENABLE_LZ4
 liberofs_la_CFLAGS += ${LZ4_CFLAGS}
diff --git a/lib/compress.c b/lib/compress.c
new file mode 100644
index 0000000..205a4f2
--- /dev/null
+++ b/lib/compress.c
@@ -0,0 +1,303 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs_utils/lib/compress.c
+ *
+ * Copyright (C) 2018-2019 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Miao Xie <miaoxie@huawei.com>
+ * with heavy changes by Gao Xiang <gaoxiang25@huawei.com>
+ */
+#define _LARGEFILE64_SOURCE
+#include <string.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include "erofs/print.h"
+#include "erofs/io.h"
+#include "erofs/cache.h"
+#include "erofs/compress.h"
+#include "compressor.h"
+
+static struct erofs_compress compresshandle;
+static int compressionlevel;
+
+struct z_erofs_vle_compress_ctx {
+	u8 *metacur;
+
+	u8 queue[EROFS_CONFIG_COMPR_MAX_SZ * 2];
+	unsigned int head, tail;
+
+	erofs_blk_t blkaddr;	/* pointing to the next blkaddr */
+	u16 clusterofs;
+};
+
+static unsigned int get_vle_compress_metasize(erofs_off_t filesize)
+{
+	const unsigned int indexsize = BLK_ROUND_UP(filesize) *
+		sizeof(struct z_erofs_vle_decompressed_index);
+
+	return sizeof(struct erofs_extent_header) + indexsize;
+}
+
+static void vle_write_indexes_final(struct z_erofs_vle_compress_ctx *ctx)
+{
+	const unsigned int type = Z_EROFS_VLE_CLUSTER_TYPE_PLAIN;
+	struct z_erofs_vle_decompressed_index di;
+
+	if (!ctx->clusterofs)
+		return;
+
+	di.di_clusterofs = cpu_to_le16(ctx->clusterofs);
+	di.di_u.blkaddr = 0;
+	di.di_advise = cpu_to_le16(type << Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT);
+
+	memcpy(ctx->metacur, &di, sizeof(di));
+	ctx->metacur += sizeof(di);
+}
+
+static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
+			      unsigned int count, bool raw)
+{
+	unsigned int d0 = 0, d1 = (ctx->clusterofs + count) / EROFS_BLKSIZ;
+	unsigned int clusterofs = ctx->clusterofs;
+	struct z_erofs_vle_decompressed_index di;
+	unsigned int type;
+	__le16 advise;
+
+	di.di_clusterofs = cpu_to_le16(ctx->clusterofs);
+
+	/* whether the tail-end (un)compressed block or not */
+	if (clusterofs + count < EROFS_BLKSIZ) {
+		type = raw ? Z_EROFS_VLE_CLUSTER_TYPE_PLAIN :
+			Z_EROFS_VLE_CLUSTER_TYPE_HEAD;
+		advise = cpu_to_le16(type << Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT);
+
+		di.di_advise = advise;
+		di.di_u.blkaddr = cpu_to_le32(ctx->blkaddr);
+		memcpy(ctx->metacur, &di, sizeof(di));
+		ctx->metacur += sizeof(di);
+
+		/* don't add the final index if the tail-end block exists */
+		ctx->clusterofs = 0;
+		return;
+	}
+
+	do {
+		if (d0) {
+			type = Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD;
+
+			di.di_u.delta[0] = cpu_to_le16(d0);
+			di.di_u.delta[1] = cpu_to_le16(d1);
+		} else {
+			type = raw ? Z_EROFS_VLE_CLUSTER_TYPE_PLAIN :
+				Z_EROFS_VLE_CLUSTER_TYPE_HEAD;
+			di.di_u.blkaddr = cpu_to_le32(ctx->blkaddr);
+		}
+		advise = cpu_to_le16(type << Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT);
+		di.di_advise = advise;
+
+		memcpy(ctx->metacur, &di, sizeof(di));
+		ctx->metacur += sizeof(di);
+
+		count -= EROFS_BLKSIZ - clusterofs;
+		clusterofs = 0;
+
+		++d0;
+		--d1;
+	} while (clusterofs + count >= EROFS_BLKSIZ);
+
+	ctx->clusterofs = clusterofs + count;
+}
+
+static int vle_compress_one(struct erofs_inode *inode,
+			    struct z_erofs_vle_compress_ctx *ctx,
+			    bool final)
+{
+	struct erofs_compress *const h = &compresshandle;
+	unsigned int len = ctx->tail - ctx->head;
+	unsigned int count;
+	int ret;
+	char dst[EROFS_BLKSIZ];
+
+	while (len) {
+		bool raw;
+
+		if (len <= EROFS_BLKSIZ) {
+			if (final)
+				goto nocompression;
+			break;
+		}
+
+		count = len;
+		ret = erofs_compress_destsize(h, compressionlevel,
+					      ctx->queue + ctx->head,
+					      &count, dst, EROFS_BLKSIZ);
+		if (ret) {
+			if (ret != -EAGAIN) {
+				erofs_err("failed to compress %s: %s",
+					  inode->i_srcpath,
+					  erofs_strerror(ret));
+			}
+nocompression:
+			/* fix up clusterofs to 0 if possable */
+			if (ctx->head >= ctx->clusterofs) {
+				ctx->head -= ctx->clusterofs;
+				len += ctx->clusterofs;
+				ctx->clusterofs = 0;
+			}
+
+			/* write uncompressed data */
+			count = min(EROFS_BLKSIZ, len);
+
+			memcpy(dst, ctx->queue + ctx->head, count);
+			memset(dst + count, 0, EROFS_BLKSIZ - count);
+
+			erofs_dbg("Writing %u uncompressed data to block %u",
+				  count, ctx->blkaddr);
+
+			ret = blk_write(dst, ctx->blkaddr, 1);
+			if (ret)
+				return ret;
+			raw = true;
+		} else {
+			/* write compressed data */
+			erofs_dbg("Writing %u compressed data to block %u",
+				  count, ctx->blkaddr);
+
+			ret = blk_write(dst, ctx->blkaddr, 1);
+			if (ret)
+				return ret;
+			raw = false;
+		}
+
+		ctx->head += count;
+		/* write compression indexes for this blkaddr */
+		vle_write_indexes(ctx, count, raw);
+
+		++ctx->blkaddr;
+		len -= count;
+
+		if (!final && ctx->head >= EROFS_CONFIG_COMPR_MAX_SZ) {
+			const uint qh_aligned = round_down(ctx->head, EROFS_BLKSIZ);
+			const uint qh_after = ctx->head - qh_aligned;
+
+			memmove(ctx->queue, ctx->queue + qh_aligned,
+				len + qh_after);
+			ctx->head = qh_after;
+			ctx->tail = qh_after + len;
+			break;
+		}
+	}
+	return 0;
+}
+
+int erofs_write_compressed_file(struct erofs_inode *inode)
+{
+	const unsigned int metasize = get_vle_compress_metasize(inode->i_size);
+	struct erofs_buffer_head *bh;
+	struct z_erofs_vle_compress_ctx ctx;
+	erofs_off_t remaining;
+	erofs_blk_t blkaddr;
+
+	int ret, fd;
+	u8 *compressmeta = malloc(metasize);
+
+	if (!compressmeta)
+		return -ENOMEM;
+
+	fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
+	if (fd < 0) {
+		ret = -errno;
+		goto err_free;
+	}
+
+	/* allocate main data buffer */
+	bh = erofs_balloc(DATA, 0, 0, 0);
+	if (IS_ERR(bh)) {
+		ret = PTR_ERR(bh);
+		goto err_close;
+	}
+
+	blkaddr = erofs_mapbh(bh->block, true);	/* start_blkaddr */
+	ctx.blkaddr = blkaddr;
+	ctx.metacur = compressmeta + sizeof(struct erofs_extent_header);
+	ctx.head = ctx.tail = 0;
+	ctx.clusterofs = 0;
+	remaining = inode->i_size;
+
+	while (remaining) {
+		const uint readcount = min_t(uint, remaining,
+					     sizeof(ctx.queue) - ctx.tail);
+
+		ret = read(fd, ctx.queue + ctx.tail, readcount);
+		if (ret != readcount) {
+			ret = -errno;
+			goto err_bdrop;
+		}
+		remaining -= readcount;
+		ctx.tail += readcount;
+
+		/* do one compress round */
+		ret = vle_compress_one(inode, &ctx, false);
+		if (ret)
+			goto err_bdrop;
+	}
+
+	/* do the final round */
+	ret = vle_compress_one(inode, &ctx, true);
+	if (ret)
+		goto err_bdrop;
+
+	/* fall back to no compression mode */
+	if (ctx.blkaddr - blkaddr >= BLK_ROUND_UP(inode->i_size)) {
+		ret = -ENOSPC;
+		goto err_bdrop;
+	}
+
+	vle_write_indexes_final(&ctx);
+
+	close(fd);
+	ret = erofs_bh_balloon(bh, blknr_to_addr(ctx.blkaddr - blkaddr));
+	DBG_BUGON(ret);
+
+	erofs_info("compressed %s (%lu bytes) into %u blocks",
+		   inode->i_srcpath, inode->i_size, ctx.blkaddr - blkaddr);
+
+	/*
+	 * TODO: need to move erofs_bdrop to erofs_write_tail_end
+	 *       when both mkfs & kernel support compression inline.
+	 */
+	erofs_bdrop(bh, false);
+	inode->compressmeta = compressmeta;
+	inode->idata_size = 0;
+	inode->extent_isize = metasize;
+	inode->data_mapping_mode = EROFS_INODE_LAYOUT_COMPRESSION;
+	return 0;
+
+err_bdrop:
+	erofs_bdrop(bh, true);	/* revoke buffer */
+err_close:
+	close(fd);
+err_free:
+	free(compressmeta);
+	return ret;
+}
+
+int z_erofs_compress_init(void)
+{
+	/* initialize for primary compression algorithm */
+	int ret = erofs_compressor_init(&compresshandle,
+					cfg.c_compr_alg_master);
+	if (ret)
+		return ret;
+
+	compressionlevel = cfg.c_compr_level_master < 0 ?
+		compresshandle.alg->default_level :
+		cfg.c_compr_level_master;
+	return 0;
+}
+
+int z_erofs_compress_exit(void)
+{
+	return erofs_compressor_exit(&compresshandle);
+}
+
diff --git a/lib/config.c b/lib/config.c
index 6ff8e4d..3312c9b 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -18,6 +18,7 @@ void erofs_init_configure(void)
 	cfg.c_dbg_lvl  = 0;
 	cfg.c_version  = PACKAGE_VERSION;
 	cfg.c_dry_run  = false;
+	cfg.c_compr_level_master = -1;
 }
 
 void erofs_show_config(void)
diff --git a/lib/inode.c b/lib/inode.c
index d3e5ed8..b7fcf0e 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -17,6 +17,7 @@
 #include "erofs/inode.h"
 #include "erofs/cache.h"
 #include "erofs/io.h"
+#include "erofs/compress.h"
 
 struct erofs_sb_info sbi;
 
@@ -286,8 +287,11 @@ int erofs_write_file(struct erofs_inode *inode)
 	unsigned int nblocks, i;
 	int ret, fd;
 
-	if (erofs_file_is_compressible(inode)) {
-		/* to be implemented */
+	if (cfg.c_compr_alg_master && erofs_file_is_compressible(inode)) {
+		ret = erofs_write_compressed_file(inode);
+
+		if (!ret || ret != -ENOSPC)
+			return ret;
 	}
 
 	/* fallback to all data uncompressed */
@@ -340,7 +344,7 @@ fail:
 static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 {
 	struct erofs_inode *const inode = bh->fsprivate;
-	const erofs_off_t off = erofs_btell(bh, false);
+	erofs_off_t off = erofs_btell(bh, false);
 
 	/* let's support v1 currently */
 	struct erofs_inode_v1 v1 = {0};
@@ -379,6 +383,14 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 	if (ret)
 		return false;
 
+	if (inode->extent_isize) {
+		/* write compression metadata */
+		off = Z_EROFS_VLE_EXTENT_ALIGN(off + inode->inode_isize);
+		ret = dev_write(inode->compressmeta, off, inode->extent_isize);
+		if (ret)
+			return false;
+	}
+
 	erofs_iput(inode);
 	return erofs_bh_flush_generic_end(bh);
 }
diff --git a/mkfs/main.c b/mkfs/main.c
index 1ed15d2..ce64ece 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -17,6 +17,7 @@
 #include "erofs/cache.h"
 #include "erofs/inode.h"
 #include "erofs/io.h"
+#include "erofs/compress.h"
 
 #define EROFS_SUPER_END (EROFS_SUPER_OFFSET + sizeof(struct erofs_super_block))
 
@@ -25,6 +26,7 @@ static void usage(char *execpath)
 	fprintf(stderr, "%s %s\n", basename(execpath), cfg.c_version);
 	fprintf(stderr, "usage: [options] FILE DIRECTORY\n\n");
 	fprintf(stderr, "Generate erofs image from DIRECTORY to FILE, and [options] are:\n");
+	fprintf(stderr, " -zX[,Y]  X=compressor (Y=compression level, optional)\n");
 	fprintf(stderr, " -d#      set output message level to # (maximum 9)\n");
 }
 
@@ -44,6 +46,23 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 
 	while ((opt = getopt(argc, argv, "d:z:")) != -1) {
 		switch (opt) {
+		case 'z':
+			if (!optarg) {
+				cfg.c_compr_alg_master = "(default)";
+				break;
+			}
+			/* get specified compression level */
+			for (i = 0; optarg[i] != '\0'; ++i) {
+				if (optarg[i] == ',') {
+					cfg.c_compr_level_master =
+						atoi(optarg + i + 1);
+					optarg[i] = '\0';
+					break;
+				}
+			}
+			cfg.c_compr_alg_master = strndup(optarg, i);
+			break;
+
 		case 'd':
 			cfg.c_dbg_lvl = parse_num_from_str(optarg);
 			break;
@@ -148,6 +167,7 @@ int main(int argc, char **argv)
 		goto exit;
 	}
 
+	z_erofs_compress_init();
 	erofs_inode_manager_init();
 
 	root_inode = erofs_mkfs_build_tree_from_path(NULL, cfg.c_src_path);
@@ -167,6 +187,7 @@ int main(int argc, char **argv)
 	if (!erofs_bflush(NULL))
 		err = -EIO;
 exit:
+	z_erofs_compress_exit();
 	dev_close();
 	erofs_exit_configure();
 
-- 
2.17.1

