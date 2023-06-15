Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 045B8731511
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jun 2023 12:18:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1686824281;
	bh=mLeVgovL//KBR9FTiPt6HM0b/j+0wBmMGvvwLUGPZWI=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Y6kZTN//0IV7wMzmoHO5jGoWz5ohyxkJ5h1gwVHm7IhXpVe0CZ0wGjyXz+x+k11oX
	 y9t1frOerS2n/zrUW1LouqGrQr/EeY5NdWn/CVdPN6ubkM5OmEnmgjqG2ov9jVGTx0
	 rtew5ad9EycHbtiRXQRvG5gU2N4laH71dcz8HNyl2RyofAi1OlEVFEB2Ke5kL+rDHh
	 DXYp4DsZv+aHwk3OuHQZ098A2WlNmaBZdLaSKxbv7ZuAfPkcoOOUi6yMorEpnZz8xh
	 XR7JeDLE1Vj1rutTxLud3ozOw7gr2mAMQ7Tvh0F0jkKB/Q9koPFJoC6ATcuWGPCmlx
	 oCO6/p/zX0y3w==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QhdXT3CXDz3bTb
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jun 2023 20:18:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=huaweicloud.com (client-ip=14.137.139.46; helo=frasgout13.his.huawei.com; envelope-from=guoxuenan@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QhdXD0gQQz30dm
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jun 2023 20:17:46 +1000 (AEST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4QhdHw6Yyyz9yKXR
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jun 2023 18:07:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
	by APP2 (Coremail) with SMTP id BqC_BwDXvYc55YpkT63TCA--.7908S3;
	Thu, 15 Jun 2023 10:17:35 +0000 (GMT)
To: hsiangkao@linux.alibaba.com,
	jefflexu@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 1/4] erofs-utils: lib: refactor erofs compressors init
Date: Thu, 15 Jun 2023 18:17:24 +0800
Message-Id: <20230615101727.946446-2-guoxuenan@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230615101727.946446-1-guoxuenan@huawei.com>
References: <20230615101727.946446-1-guoxuenan@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: BqC_BwDXvYc55YpkT63TCA--.7908S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAF1DWry8XFWfKw4fJr4xJFb_yoWrXr4rpr
	1UCryrGry8Wr13uw4fJr4rKFy3Kr1IyF17uw17K3s3t3W5Jr97XF18tr95ZrW7Gr93Xw4v
	ywsFvw4DGw15tr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Jrv_JF4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267AKxVWU
	JVW8JwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7V
	C0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j
	6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxAIw28IcVAKzI0EY4vE52x082
	I5MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUF2-eDUUUU
X-CM-SenderInfo: xjxr53hhqd0q5kxd4v5lfo033gof0z/
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
From: Guo Xuenan via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Guo Xuenan <guoxuenan@huawei.com>
Cc: jack.qiu@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

using struct erofs_compressors_cfg for erofs compressor
global configuration.

Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
---
 lib/compressor.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++
 lib/compressor.h | 14 ++++++++++
 2 files changed, 82 insertions(+)

diff --git a/lib/compressor.c b/lib/compressor.c
index 52eb761..88a2fb0 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -22,6 +22,74 @@ static const struct erofs_compressor *compressors[] = {
 #endif
 };
 
+/* for compressors type configuration */
+static struct erofs_supported_algothrim {
+	int algtype;
+	const char *name;
+} erofs_supported_algothrims[] = {
+	{ Z_EROFS_COMPRESSION_LZ4, "lz4"},
+	{ Z_EROFS_COMPRESSION_LZ4, "lz4hc"},
+	{ Z_EROFS_COMPRESSION_LZMA, "lzma"},
+};
+
+/* global compressors configuration */
+static struct erofs_compressors_cfg erofs_ccfg;
+
+static void erofs_init_compressor(struct compressor *compressor,
+	const struct erofs_compressor *alg)
+{
+
+	compressor->handle.alg = alg;
+
+	/* should be written in "minimum compression ratio * 100" */
+	compressor->handle.compress_threshold = 100;
+
+	/* optimize for 4k size page */
+	compressor->handle.destsize_alignsize = erofs_blksiz();
+	compressor->handle.destsize_redzone_begin = erofs_blksiz() - 16;
+	compressor->handle.destsize_redzone_end = EROFS_CONFIG_COMPR_DEF_BOUNDARY;
+
+	if (alg && alg->init)
+		alg->init(&compressor->handle);
+}
+
+static void erofs_compressor_register(const char *name, const struct erofs_compressor *alg)
+{
+	int i;
+
+	for (i = 0; i < erofs_ccfg.erofs_ccfg_num; i++) {
+		if (!strcmp(erofs_ccfg.compressors[i].name, name)) {
+			erofs_init_compressor(&erofs_ccfg.compressors[i], alg);
+			return;
+		}
+	}
+
+	erofs_ccfg.compressors[i].name = name;
+	erofs_ccfg.compressors[i].algorithmtype = erofs_supported_algothrims[i].algtype;
+	erofs_init_compressor(&erofs_ccfg.compressors[i], alg);
+	erofs_ccfg.erofs_ccfg_num = ++i;
+}
+
+void erofs_register_compressors(void)
+{
+	int i;
+
+	erofs_ccfg.erofs_ccfg_num = 0;
+	for (i = 0; i < ARRAY_SIZE(erofs_supported_algothrims); i++) {
+		erofs_compressor_register(erofs_supported_algothrims[i].name, NULL);
+	}
+
+#if LZ4_ENABLED
+	erofs_compressor_register("lz4", &erofs_compressor_lz4);
+#if LZ4HC_ENABLED
+	erofs_compressor_register("lz4hc", &erofs_compressor_lz4hc);
+#endif
+#endif
+#if HAVE_LIBLZMA
+	erofs_compressor_register("lzma", &erofs_compressor_lzma);
+#endif
+}
+
 int erofs_compress_destsize(const struct erofs_compress *c,
 			    const void *src, unsigned int *srcsize,
 			    void *dst, unsigned int dstsize, bool inblocks)
diff --git a/lib/compressor.h b/lib/compressor.h
index cf063f1..1e760b6 100644
--- a/lib/compressor.h
+++ b/lib/compressor.h
@@ -8,6 +8,7 @@
 #define __EROFS_LIB_COMPRESSOR_H
 
 #include "erofs/defs.h"
+#include "erofs/config.h"
 
 struct erofs_compress;
 
@@ -40,6 +41,18 @@ struct erofs_compress {
 	void *private_data;
 };
 
+struct compressor {
+	const char *name;
+	struct erofs_compress handle;
+	unsigned int algorithmtype;
+	bool enable;
+};
+
+struct erofs_compressors_cfg {
+	struct compressor compressors[EROFS_MAX_COMPR_CFGS];
+	int erofs_ccfg_num;
+};
+
 /* list of compression algorithms */
 extern const struct erofs_compressor erofs_compressor_lz4;
 extern const struct erofs_compressor erofs_compressor_lz4hc;
@@ -52,5 +65,6 @@ int erofs_compress_destsize(const struct erofs_compress *c,
 int erofs_compressor_setlevel(struct erofs_compress *c, int compression_level);
 int erofs_compressor_init(struct erofs_compress *c, char *alg_name);
 int erofs_compressor_exit(struct erofs_compress *c);
+void erofs_register_compressors(void);
 
 #endif
-- 
2.31.1

