Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB222F9441
	for <lists+linux-erofs@lfdr.de>; Sun, 17 Jan 2021 18:47:10 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DJj6M4ttBzDr6L
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Jan 2021 04:47:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1610905627;
	bh=T8zJ3BkQWH+oFIA7ouzoNK2rklCSbjqvEtqkYnGP6Cw=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=F2m3XzYYnpm0Cor341lU313zeklc/okcusVXAP3nc2IpY0fhyjsVuI0TDz3jZkQXm
	 MjkOg/mayI8BZvDxkTGY3AsQJoQ4oMrSFqdPeB2lOeqCdnweLFZNzQBTGdT7PVFrfi
	 sThLSIaX2EJ4MHi+BmB1d9Oeeuzit4UwZ5RuMLtFJYD0Ax4bvkTNPs6W+bQvIr6Xs2
	 Ngh8PsJ2NFyzwziHFjICK1e30vuP0sZLjbJJAQbFxbhwk0evVp7hDtPfPdNsxRRVqf
	 nbBKeT6GKliPylBGF1MsrYKFTG6WwkzkTBYLULel93sS1miT04jpQDzk7hzE3jDn+h
	 /ke10vp6Ddzxw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.64.83; helo=sonic305-20.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=EeX6Yhpp; dkim-atps=neutral
Received: from sonic305-20.consmr.mail.gq1.yahoo.com
 (sonic305-20.consmr.mail.gq1.yahoo.com [98.137.64.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DJj5r1JVczDqts
 for <linux-erofs@lists.ozlabs.org>; Mon, 18 Jan 2021 04:46:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1610905594; bh=MxRLphjYMWOsxa1A7xgPq2RrHQWfucI8dAS5pOVezLc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=EeX6YhppqNBYfRWdfrPdT976+17w0XZ8g+p8Gnnybmm5nCXtthaR2cJyTVVeW0ulf8zHXTmuAwZ2Duu0NZsC4x2ek2Es4X6WreFjj1t4BuKvIA+sPgfWGImPrj8R2/Vq8O8yNz6QKMwyV99UeVmPJT2PS3btWqgP/757U4L9ukAhWmtuDnQ5BJ/g43l9+mfaBblnD9TEwTemJ6tH6hwx9wO3vGZdLqy3eLJugQP6o1p/i9SKpzvB5QHXxQChwB9Zsd3lvLukflNfDdpnfIp2bKVYfK+mk1/UeXw/Ps4U51dUFbEC19bQtwPouTqnk1iio1Xm3GdRzy6iY0egbvXkew==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1610905594; bh=20CzquGn4FdjcGnsIqt185S/5NqGGTw0likikz5MPat=;
 h=From:To:Subject:Date:From:Subject:Reply-To;
 b=LarIsF3KZCVFiXCtKdSi+XOC3qOlw7brcTsNlOmTNWSLe8nzU8Pg20ibFVnnsjgXnmMl4kWveVN031PNO0OujAF9J+IYFFtM6h6DAJMIqf5OBNvo5lShkCAuxRnE7gxQ1n52Zw5Md1vJH6bc65sh3iheA7cbqbPaOVC+1mP8hwelvVQnYRRJXiTtqUqhfQitHgjd7u2Tp4mY8yNRG32YKosop+znBmp/3PbZBJb1o9u9KeIu8JHjwov7sVTmyC7cruktOEPmlIQ+/4OQSKhYHPSf1bJGdbBipIJIo0d2gb6fSRXV/Zbr46rGn5yqtXXsKTIDYKbMOhI3ubK+Wbw51w==
X-YMail-OSG: nyuUSXgVM1nYfgBPEdM8poFLnTw0c.wZtqEZyf8W5B9VVyFqmLJa3MFlGTlLaNF
 Yi8PrGBQiDp3usvj2a6exZtDHOtr_ZZ0Vx4o68z1s0bSxfB9ueapoqp5rNj09grP.gCENinuifHT
 1xrv3ROSMRBDe2Hb5w1TkPYxVis0WwU4.MyxTtTZSjeAvnJw_W3PmsfsU0AeOCLybrzIBK5Qalrz
 xL9SCBsp67TwEpnQ2bTM5q2Rvy95JNj8ZzfDWVj3On.6YXp1kwr7nWuDDrnzEuitWQAx728cVOPd
 OH5HO6M.tKySKEUO5bzu1rj9OWGKgE5_BlTZhlGZOPJEWPsyLkgt7An4twAgfn2EreCW6vfMBi3T
 ZiTm8_9jdcsyvg3bQV5Qap3bSsx3w7oHsss22b.VtgfyPUIlUj1uZO0ZvJrvpUP0ZvE63XHnZ8Tn
 hzK4uHttYrZlv4jxTbwfeqE8j8KQbxAP67..3Rzk5VmAx8lNlxT0C_CGZmkeUtcpqUNuPLsf0W6V
 J9TvebbChzrXV5IahoTAOB1rlFOxdo_Yju15HHTlskKLxJCNnD2Wh.wQrixobpnyLG3MtI4oAmlR
 OKWd3b9wB7.JXvWARYqxKL6DA4dn4sX_6OfmjUreTUfdlGdAdVWcDfk90Io_.M_dxHSC16pesQZk
 MSdgpn1TremPnEs7QJQdGM8Is6MyPET9ceCbeyYKBpT_43JbiZ.YTGPgTXpAPbYfQUwx5hOOVoH9
 oRsUkpmkCGujzMjaR3pxku2eJAAlipMru1FlgIy9vdP0flKRZgPoFo5ABbewznj5SbH7zHWGTBUm
 cqwo9Cx30EkvbfitYIH.jIanayZX1OJ2Lo_3DNI2BLFls5is_Q5J2YXTEPyLkvnV3HDNSJ6ci5ds
 2biLdU75FH7aVYdIc2OFfaNngWIaL15IY8HOVlxIMGLg4jSECXCxBSy_rieE3YoNEwUwazKRDah2
 ANnDte6MSDTslIltQV5PUjJh4105xuMufM21O03DvzSITfLRoMSUwoa1sycH6iW1sqyGRHs0EG5y
 EbjBAeLcEL5_rbGcI1088isw.rldyt7xe26Yu3ptfEp63HuBEBg9R_HnwkjnGwTCV.8zVvPVf7IM
 ZafXw07nnsh1e.7ZZpAFeCmHBiqOmdswbb0YU6qy7f8M5sNjiPJEojFb8PKSDcrp39Sp215JG3M6
 150aYdhTTWEztWgJEp7V4ZFt.5AFcRftRxpyz3JBWrBTZ5d1WLv3PmL3JW5Q6NJ_i1zBNjOsdEB9
 gVJvJdNUzQfKxQrYIPBJiY_a0xXPUQ7LP3LecKzEpG98rvDCaH_tPMETAISMx43Bxprx5qHDl2Jj
 2flG4nns0l_fe3UFhIlb0qinfhQ9S6OQMcU6IJI8k1wfErT0.SiZz1JapJhOJV1igVo2LxZf5nAB
 QgTpZzgDZfpafSVHG1AT8.b0Hvw4QaYZRBHEmw9nnvk4dVUj6AqAGF1sIhJCYqhsA8b_sbOgotgQ
 XHo1z5uGq.YWJSw._GujCxU5xomf6BjBLi_WdNTWhzgp1THtSKmDmVQzoXhpdIbMN.MBiMY0e8iN
 EeT597AGi.RMaGRI22sLX6NG5HkpN1cKHRTMDXifsvUzcndWX7kJdLWaotYR__R_EztfNJm5nXhG
 ehBTSk3bcIkQVxMcaA0y4SSPVSVVUJb3vNgt6Ty9yROHI1waHRFDjm91UpPEjtrPW_ONp103QVZs
 QVR.tokIyIvSRP70Iqh04sSRoepkNUII1d1pcEA0s8gVNka5B5bbS4I.RQmF1xevLlhAF5Jz2V9r
 TgOJ7xnwOdiFyNJ7q95hpFhecmq9zH6ukw3dD9j0u50T2syXzxw6laaH2HyqoRqE2KhN5_RcsuTF
 mBMpryswameqyQ4nGY7wtTdU9LPtNKrLPLTWME_ZsaLO7ww7ZX81_uOcO9ChVlGfv_wqtWFZZa1A
 jW8j3TgRpaYsfOpuXLXzKVaMx0TydRrKyhvEQeEwKqwh5rujnjOT.uR4mVmOt2C_O0B4hTZNfXoG
 _8Rig_EEZymjcX6Hw9CWQbD4Tt.ly8HZ4Chg7rxbvl3FVCol0d7S3jVfnxOEHJSD1s6gS7i1ye3T
 KqnABa.VfbquxQDoPNL7GEUrc1ZY9nYuQkIdqxxTYnN76qzXtIsQkrIzc3Ez0OEWa6G9SXKDVzwg
 quI5I3BvscbHtZ1_KEKa2ouhcEa4UXm9iXKqjKYFyBB.YMCyOFCI31afe2FAyfhZb12ODFLuVEnW
 OBefmPJmUAjo.QEceLDOdrdXRX6lsv2U7ky.eNBN.ZFg_l3di.H6Rzv30ZmX5FyHU0QvRCIu.y.p
 gX2KBQ2p5CzBmKO04kLw.P3IL5401Pu8OHSOh_R4ZtN.T134Wz812OUcFRpcuAgb.m0pXu3o37oV
 lnG.3lAMFVDXkielaTeZhXSND6GzSA_TnXtLHBJ8pVZx9SsJA04OGoCmruZ09HAAgeqMOpZxk3DO
 XQgeVQEawBeyjjewrg_ruFjXrfXjbwHl0B.l.BNxsjuHDfywJTrID9xjUqx8WhZn6AMp7o.axIpo
 -
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic305.consmr.mail.gq1.yahoo.com with HTTP; Sun, 17 Jan 2021 17:46:34 +0000
Received: by smtp401.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 84aafc302758bb6691fa0c94699b2296; 
 Sun, 17 Jan 2021 17:46:29 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v0 3/4] erofs-utils: mkfs: add LZMA algorithm support
Date: Mon, 18 Jan 2021 01:46:02 +0800
Message-Id: <20210117174603.17943-4-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20210117174603.17943-1-hsiangkao@aol.com>
References: <20210117174603.17943-1-hsiangkao@aol.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: Lasse Collin <lasse.collin@tukaani.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@aol.com>

This patch adds LZMA compression algorithms to erofs-utils
compression framework by using upstream liblzma.

Cc: Lasse Collin <lasse.collin@tukaani.org>
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 include/erofs_fs.h       |  3 +-
 lib/Makefile.am          |  1 +
 lib/compress.c           |  5 ++-
 lib/compressor.c         |  1 +
 lib/compressor.h         |  1 +
 lib/compressor_liblzma.c | 93 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 102 insertions(+), 2 deletions(-)
 create mode 100644 lib/compressor_liblzma.c

diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index a69f179a51a5..24772043cb8b 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -193,7 +193,8 @@ static inline unsigned int erofs_xattr_entry_size(struct erofs_xattr_entry *e)
 
 /* available compression algorithm types (for h_algorithmtype) */
 enum {
-	Z_EROFS_COMPRESSION_LZ4	= 0,
+	Z_EROFS_COMPRESSION_LZ4		= 0,
+	Z_EROFS_COMPRESSION_LZMA	= 1,
 	Z_EROFS_COMPRESSION_MAX
 };
 
diff --git a/lib/Makefile.am b/lib/Makefile.am
index e048a16d73f2..e9b3255a2653 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -14,3 +14,4 @@ endif
 endif
 
 liberofs_la_CFLAGS += -I/tmp/xz-test/include
+liberofs_la_SOURCES += compressor_liblzma.c
diff --git a/lib/compress.c b/lib/compress.c
index 2e8deaf81907..d77998fb6857 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -493,6 +493,8 @@ static int erofs_get_compress_algorithm_id(const char *name)
 {
 	if (!strcmp(name, "lz4") || !strcmp(name, "lz4hc"))
 		return Z_EROFS_COMPRESSION_LZ4;
+	if (!strcmp(name, "lzma"))
+		return Z_EROFS_COMPRESSION_LZMA;
 	return -ENOTSUP;
 }
 
@@ -511,7 +513,8 @@ int z_erofs_compress_init(void)
 	 * clear LZ4_0PADDING feature for old kernel compatibility.
 	 */
 	if (!cfg.c_compr_alg_master ||
-	    strncmp(cfg.c_compr_alg_master, "lz4", 3))
+	    (strncmp(cfg.c_compr_alg_master, "lz4", 3) &&
+	     strcmp(cfg.c_compr_alg_master, "lzma")))
 		erofs_sb_clear_lz4_0padding();
 
 	if (!cfg.c_compr_alg_master)
diff --git a/lib/compressor.c b/lib/compressor.c
index e28aa8f934c0..cc39fc7a685a 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -19,6 +19,7 @@ static struct erofs_compressor *compressors[] = {
 #endif
 		&erofs_compressor_lz4,
 #endif
+		&erofs_compressor_lzma,
 };
 
 int erofs_compress_destsize(struct erofs_compress *c,
diff --git a/lib/compressor.h b/lib/compressor.h
index 8c4e72cfa8b9..e783ca1de509 100644
--- a/lib/compressor.h
+++ b/lib/compressor.h
@@ -45,6 +45,7 @@ struct erofs_compress {
 /* list of compression algorithms */
 extern struct erofs_compressor erofs_compressor_lz4;
 extern struct erofs_compressor erofs_compressor_lz4hc;
+extern struct erofs_compressor erofs_compressor_lzma;
 
 int erofs_compress_destsize(struct erofs_compress *c,
 			    void *src, unsigned int *srcsize,
diff --git a/lib/compressor_liblzma.c b/lib/compressor_liblzma.c
new file mode 100644
index 000000000000..af135c2cd32b
--- /dev/null
+++ b/lib/compressor_liblzma.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/lib/compressor_liblzma.c
+ *
+ * Copyright (C) 2018-2019 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Gao Xiang <gaoxiang25@huawei.com>
+ */
+#include <stdlib.h>
+#include <lzma.h>
+#include "erofs/internal.h"
+#include "compressor.h"
+
+struct erofs_liblzma_context {
+	lzma_options_lzma opt;
+	lzma_stream strm;
+};
+
+static int erofs_liblzma_compress_destsize(struct erofs_compress *c,
+					   void *src, unsigned int *srcsize,
+					   void *dst, unsigned int dstsize)
+{
+	struct erofs_liblzma_context *ctx = c->private_data;
+	lzma_stream *strm = &ctx->strm;
+
+	lzma_ret ret = lzma_erofs_encoder(strm, &ctx->opt);
+	if (ret != LZMA_OK)
+		return -EFAULT;
+
+	strm->next_in = src;
+	strm->avail_in = *srcsize;
+	strm->next_out = dst;
+	strm->avail_out = dstsize;
+
+	ret = lzma_code(strm, LZMA_FINISH);
+	if (ret != LZMA_STREAM_END)
+		return -EBADMSG;
+
+	*srcsize = strm->total_in;
+	return strm->total_out;
+}
+
+static int erofs_compressor_liblzma_exit(struct erofs_compress *c)
+{
+	struct erofs_liblzma_context *ctx = c->private_data;
+
+	if (!ctx)
+		return -EINVAL;
+
+	lzma_end(&ctx->strm);
+	free(ctx);
+	return 0;
+}
+
+static int erofs_compressor_liblzma_setlevel(struct erofs_compress *c,
+					     int compression_level)
+{
+	struct erofs_liblzma_context *ctx = c->private_data;
+
+	if (compression_level < 0)
+		compression_level = LZMA_PRESET_DEFAULT;
+
+	if (lzma_lzma_preset(&ctx->opt, compression_level))
+		return -EINVAL;
+
+	ctx->opt.dict_size = 64U << 10;
+	c->compression_level = compression_level;
+	return 0;
+}
+
+static int erofs_compressor_liblzma_init(struct erofs_compress *c)
+{
+	struct erofs_liblzma_context *ctx;
+
+	c->alg = &erofs_compressor_lzma;
+	ctx = malloc(sizeof(*ctx));
+	if (!ctx)
+		return -ENOMEM;
+	ctx->strm = (lzma_stream)LZMA_STREAM_INIT;
+	c->private_data = ctx;
+	return 0;
+}
+
+struct erofs_compressor erofs_compressor_lzma = {
+	.name = "lzma",
+	.default_level = LZMA_PRESET_DEFAULT,
+	.best_level = LZMA_PRESET_EXTREME,
+	.init = erofs_compressor_liblzma_init,
+	.exit = erofs_compressor_liblzma_exit,
+	.setlevel = erofs_compressor_liblzma_setlevel,
+	.compress_destsize = erofs_liblzma_compress_destsize,
+};
+
-- 
2.24.0

