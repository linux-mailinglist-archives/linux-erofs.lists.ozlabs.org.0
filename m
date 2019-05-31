Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 75332305F0
	for <lists+linux-erofs@lfdr.de>; Fri, 31 May 2019 02:52:02 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45FQrb5hPZzDqXR
	for <lists+linux-erofs@lfdr.de>; Fri, 31 May 2019 10:51:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1559263919;
	bh=gnRTcZwg3+ST3JGKsaAmckeRsw/doKwP+enzP0lTHWY=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=BrrhYsoQ+C/IC3Pih4XP15TfTOq7bHLv40lxik4GJh8S6/Hv9PVDIoyYhQ0tyCEo3
	 XJC68IH/dIom/FI0j1wyjxbVRkvkUrt7ccqD1eZwMOk8MR9NrvOa+Am6g39IskcoQf
	 +KsxZVaa9eRTkxI1KDwZYlzaKurL49uf4GRX2/A8PVYhzrQ6VF6qu67f/sHZj4vI6m
	 sE0nTl96e86whqgvNReeKDxMNSfPz3wEEkwSiowlEdLNNkjk77xAK26DOYOItwBA/D
	 JWOGV9xBj42S9OxZmuuYKoLjTVvquc50aTu5GufNeqH5u95KGSuL0Be1uVtB2gxhV0
	 0GW3rEBD/Qqpg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.64.206; helo=sonic303-25.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="styu0Nfq"; 
 dkim-atps=neutral
Received: from sonic303-25.consmr.mail.gq1.yahoo.com
 (sonic303-25.consmr.mail.gq1.yahoo.com [98.137.64.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45FQrD4kWXzDqV2
 for <linux-erofs@lists.ozlabs.org>; Fri, 31 May 2019 10:51:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1559263896; bh=l1qPzLOUks6G3KBmo6APYeHpA7nmTV00DYb70xsDR3I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=styu0NfqED/aPkw+IzaZe9tBLQlIdfV5ZO+aAWpCOdXNqGJSW49lDptmw3YLLe0iURmO2RLFW5rxWRSq1MWYtlylT9rbLKFmeQ65Fjnh+NBLLu/lS0u1Fc3TWzLFcR0JKkcN9q+6KQ3dJJEvpL+q9ti48CgyDQERsjpcUYPoiiYwCCbeAnFn/BKxwyigMlFoYlRZ6XVouovvNF2Cs2++Y/5JPwcls+CMEJsFnCib9p0RwmVlrUOmu3K2krFU3T/E+K9veVgzL7vJ95Tn9ME6l1/JOSYyvFGXTp5W7NEUeSe1hEcy8lcwfGVco+sWSieHKESMJUFffvcoAT1dcqf64w==
X-YMail-OSG: HPFauToVM1l6Ors5Px3S35DeOEqq6zrXh_SOJ9KLqKMB9rRr5MldpFEMpKpn9nd
 calx2PGG4vEaOmChvP7E_q6h9C1apP7QsJ4E2BE.etaQoy0fLB4y5Jeh5aorUo3CdOTMlfs9.iip
 PjIwhf43gNYH5aHF8kZ2E6MYjneui.RAxgDBlcyGkauWmS2kdup_AMw4CYaU8ifoCF.KW93eOU87
 uXwX3yIx7089PpcRCy8v201e1RZU9zZClrEH_InW163VuWX5WuemuRmF86N.ERxxpSOJmVhFHjiU
 oAKyGAAHVtD41.8_C5bHlBp08tKE59t1UxkLAbSlbudF7i0WjYMO6w4vwhRwCJK9leZVr.cgyRwG
 FtHIpJpFTCT4DYiIFOGLBzSd1yQY9gm0OzIrCpaR.mZ_iuchcFv6iwLGpR82x7VdFOp1t4P..eov
 Fbby.D_81ejLXl8UxFSauQsyL0n5E1pJEjv8TShD6S_UtuVh1so9L8Wvalud4t2xkHashUDWJ.QS
 _kP0MDD2TNfoZ7JKEtOEQSgOuvsssLo07fVrTY4SD77E.W817QzfC6I2UnQGT8psaRI_Ag4_dtmh
 bsP0CKmOeuOTSWDepkBWyb2x4SUyCuTnuNiN15n9Tohs1YThZppzT0W1.sRLPFYRPkVt7lVIbjUA
 VSxpijXh_Xqh.gL62UoIfhZdW2RBvPLFKCVWTdMT2Dh8jg9tzIaWi04ljc.yPTyVEqi7ScAIAVNk
 Fr5.6foWLV87z4.xnSt2tGR_oKbtnJSwnUA1OSGR5Ki._sRNXlijhFDhmSQSny070fzjbLeccUNM
 qPVMckUqsQg3tUFF2jQlehuZNuZ1Eb78ajUfwf4l0Hj2uyhGN3HtW5rJBhb4DP5yowEiONh.wBCE
 o8HmN1JBJ420lFXlOeRR6fSVah0CrFzwP_Lq161bxjm6LPGendm9buzQAfQKDD2XAGGgRfF7RZWB
 RO9VkhS4SM8ORDh5JlXR3lrCx.9ela4Xlwd91IcxjlOC9ycFNT5tlDv2.LL96eqPX0wGm4am1_o2
 wyfJIZ5L_g8S13bmsy0uB_GpqLiqYzSut_tMAU_nM_p680llwRQ2C4zPtnUtjI0kezpnCS4TQVkV
 BptKw6oAdDHo5GPeux_qllLl6SnKwezS.Q5hTHGaDZHPX2jXdJRKIcH093__91Iml_wSIzDXN8K_
 Uy46KpyPdyje7maCpSPe7PtbctzJdVx3Gje3ZYaGrCwLteH_yJX93vZtiq0LkpV.yUoGKRA--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic303.consmr.mail.gq1.yahoo.com with HTTP; Fri, 31 May 2019 00:51:36 +0000
Received: from 125.120.86.223 (EHLO localhost.localdomain) ([125.120.86.223])
 by smtp417.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID a9e989b6e54ef4fb7ecb5a20a6091749; 
 Fri, 31 May 2019 00:51:30 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 08/13] erofs-utils: introduce generic compression framework
Date: Fri, 31 May 2019 08:50:42 +0800
Message-Id: <20190531005047.22093-9-hsiangkao@aol.com>
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

This patch adds a new flexable compression framework
to user-space utilities, which is designed in order
to integrate more compression algorithms easily.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 lib/Makefile.am  |  2 +-
 lib/compressor.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++
 lib/compressor.h | 48 +++++++++++++++++++++++++++++++
 3 files changed, 123 insertions(+), 1 deletion(-)
 create mode 100644 lib/compressor.c
 create mode 100644 lib/compressor.h

diff --git a/lib/Makefile.am b/lib/Makefile.am
index 5257d71..64da708 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -2,6 +2,6 @@
 # Makefile.am
 
 noinst_LTLIBRARIES = liberofs.la
-liberofs_la_SOURCES = config.c io.c cache.c inode.c
+liberofs_la_SOURCES = config.c io.c cache.c inode.c compressor.c
 liberofs_la_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
 
diff --git a/lib/compressor.c b/lib/compressor.c
new file mode 100644
index 0000000..cc97cfb
--- /dev/null
+++ b/lib/compressor.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/lib/compressor.c
+ *
+ * Copyright (C) 2018-2019 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Gao Xiang <gaoxiang25@huawei.com>
+ */
+#include "erofs/internal.h"
+#include "compressor.h"
+
+#define EROFS_CONFIG_COMPR_DEF_BOUNDARY		(128)
+
+int erofs_compress_destsize(struct erofs_compress *c,
+			    int compression_level,
+			    void *src,
+			    unsigned int *srcsize,
+			    void *dst,
+			    unsigned int dstsize)
+{
+	int ret;
+
+	DBG_BUGON(!c->alg);
+	if (!c->alg->compress_destsize)
+		return -ENOTSUP;
+
+	ret = c->alg->compress_destsize(c, compression_level,
+					src, srcsize, dst, dstsize);
+	if (ret)
+		return ret;
+
+	/* check if there is enough gains to compress */
+	if (*srcsize <= dstsize * c->compress_threshold / 100)
+		return -EAGAIN;
+	return 0;
+}
+
+int erofs_compressor_init(struct erofs_compress *c,
+			  char *alg_name)
+{
+	static struct erofs_compressor *compressors[] = {
+	};
+
+	int ret, i;
+
+	/* should be written in "minimum compression ratio * 100" */
+	c->compress_threshold = 100;
+
+	/* optimize for 4k size page */
+	c->destsize_alignsize = PAGE_SIZE;
+	c->destsize_redzone_begin = PAGE_SIZE - 16;
+	c->destsize_redzone_end = EROFS_CONFIG_COMPR_DEF_BOUNDARY;
+
+	ret = -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(compressors); ++i) {
+		ret = compressors[i]->init(c, alg_name);
+		if (!ret) {
+			DBG_BUGON(!c->alg);
+			return 0;
+		}
+	}
+	return ret;
+}
+
+int erofs_compressor_exit(struct erofs_compress *c)
+{
+	DBG_BUGON(!c->alg);
+
+	if (c->alg->exit)
+		return c->alg->exit(c);
+	return 0;
+}
+
diff --git a/lib/compressor.h b/lib/compressor.h
new file mode 100644
index 0000000..8ad9d11
--- /dev/null
+++ b/lib/compressor.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * erofs-utils/lib/compressor.h
+ *
+ * Copyright (C) 2018-2019 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Gao Xiang <gaoxiang25@huawei.com>
+ */
+#ifndef __EROFS_LIB_COMPRESSOR_H
+#define __EROFS_LIB_COMPRESSOR_H
+
+#include "erofs/defs.h"
+
+struct erofs_compress;
+
+struct erofs_compressor {
+	int default_level;
+	int best_level;
+
+	int (*init)(struct erofs_compress *c, char *alg_name);
+	int (*exit)(struct erofs_compress *c);
+
+	int (*compress_destsize)(struct erofs_compress *c,
+				 int compress_level,
+				 void *src, unsigned int *srcsize,
+				 void *dst, unsigned int dstsize);
+};
+
+struct erofs_compress {
+	struct erofs_compressor *alg;
+
+	unsigned int compress_threshold;
+
+	/* *_destsize specific */
+	unsigned int destsize_alignsize;
+	unsigned int destsize_redzone_begin;
+	unsigned int destsize_redzone_end;
+};
+
+int erofs_compress_destsize(struct erofs_compress *c, int compression_level,
+			    void *src, unsigned int *srcsize,
+			    void *dst, unsigned int dstsize);
+
+int erofs_compressor_init(struct erofs_compress *c, char *alg_name);
+int erofs_compressor_exit(struct erofs_compress *c);
+
+#endif
+
-- 
2.17.1

