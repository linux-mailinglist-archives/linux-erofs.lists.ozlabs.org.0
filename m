Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4F475DD2F
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Jul 2023 17:23:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1690039424;
	bh=aRnGXOlXzwHSWakVof75mNAZl3Vt9CQga1aoQPRJJ5E=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Kb59t/GV9MfWImYgBg6XCG11BY2sruMLVlB0lFiLeyTnZ7wwO6GPy5eSE3FgaPHpp
	 SYA4kocOb3YsJMPu+CWcsUEp+w6Ha26AE/bz4A+uzcXWuCfFfULUPXecfmU5/kXyD6
	 u3+5Ud7lRW+xGBBc4oQh6kx+rdlwL2Xa733e0krNNY5WiokzJKaIB55XK9oIAGZRif
	 rJiwmiz2ySGzhzqCcO0PKEkVGDOlRF33LwDqpxfRQQciftAWpiahgrFDRDKeu8GS96
	 ktJug/oHWXGnWsQH4G1FLHst2+SkFkHWLHn09wPeB0JY1pXJXyI0+BgPtoJ4jpiZfk
	 TRwCvFj/P+e8A==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R7VZ83MBLz300C
	for <lists+linux-erofs@lfdr.de>; Sun, 23 Jul 2023 01:23:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=huaweicloud.com (client-ip=14.137.139.23; helo=frasgout11.his.huawei.com; envelope-from=guoxuenan@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from frasgout11.his.huawei.com (ecs-14-137-139-23.compute.hwclouds-dns.com [14.137.139.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R7VZ222mhz2ynD
	for <linux-erofs@lists.ozlabs.org>; Sun, 23 Jul 2023 01:23:37 +1000 (AEST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4R7TvH5BXxz9v7Gt
	for <linux-erofs@lists.ozlabs.org>; Sat, 22 Jul 2023 22:53:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
	by APP2 (Coremail) with SMTP id BqC_BwCXnVcE8LtkMMq2Cg--.24810S3;
	Sat, 22 Jul 2023 15:04:42 +0000 (GMT)
To: hsiangkao@linux.alibaba.com,
	jefflexu@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 1/4] erofs-utils: lib: refactor erofs compressors init
Date: Sat, 22 Jul 2023 23:04:31 +0800
Message-Id: <20230722150434.2921381-2-guoxuenan@huawei.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20230722150434.2921381-1-guoxuenan@huawei.com>
References: <20230722150434.2921381-1-guoxuenan@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: BqC_BwCXnVcE8LtkMMq2Cg--.24810S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAF1kGFy7WFy3Kr15Kw4rKrg_yoW5urW5pF
	1UCryrGry8Wr13uws3JF4rKFy3tF1IyF4xWw1xJ3s3t3Z8Jr97WF1ktr98ZrW5Gr93Xrsa
	kwsFvw4UCw15tr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
 lib/compressor.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++
 lib/compressor.h |  2 ++
 2 files changed, 63 insertions(+)

diff --git a/lib/compressor.c b/lib/compressor.c
index 4333f26..6288297 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -26,6 +26,67 @@ static const struct erofs_compressor *compressors[] = {
 #endif
 };
 
+static struct erofs_supported_algorithm {
+	bool enable;
+	unsigned int algtype;
+	const char *name;
+	struct erofs_compress handle;
+} erofs_supported_algorithms[] = {
+	{ .algtype = Z_EROFS_COMPRESSION_LZ4, .name = "lz4" },
+	{ .algtype = Z_EROFS_COMPRESSION_LZ4, .name = "lz4hc" },
+	{ .algtype = Z_EROFS_COMPRESSION_LZMA, .name = "lzma" },
+	{ .algtype = Z_EROFS_COMPRESSION_DEFLATE, .name = "deflate" },
+	{ .algtype = Z_EROFS_COMPRESSION_DEFLATE, .name = "libdeflate" },
+};
+
+static void erofs_init_compressor(struct erofs_sb_info *sbi,
+		struct erofs_compress *handle, const struct erofs_compressor *alg)
+{
+
+	handle->alg = alg;
+
+	/* should be written in "minimum compression ratio * 100" */
+	handle->compress_threshold = 100;
+
+	/* optimize for 4k size page */
+	handle->destsize_alignsize = erofs_blksiz(sbi);
+	handle->destsize_redzone_begin = erofs_blksiz(sbi) - 16;
+	handle->destsize_redzone_end = EROFS_CONFIG_COMPR_DEF_BOUNDARY;
+
+	if (alg && alg->init)
+		alg->init(handle);
+}
+
+static void erofs_compressor_register(struct erofs_sb_info *sbi,
+		const char *name, const struct erofs_compressor *alg)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(erofs_supported_algorithms); i++) {
+		if (!strcmp(erofs_supported_algorithms[i].name, name)) {
+			erofs_init_compressor(sbi, &erofs_supported_algorithms[i].handle, alg);
+			return;
+		}
+	}
+}
+
+void erofs_register_compressors(struct erofs_sb_info *sbi)
+{
+#if LZ4_ENABLED
+	erofs_compressor_register(sbi, "lz4", &erofs_compressor_lz4);
+#if LZ4HC_ENABLED
+	erofs_compressor_register(sbi, "lz4hc", &erofs_compressor_lz4hc);
+#endif
+#endif
+#if HAVE_LIBLZMA
+	erofs_compressor_register(sbi, "lzma", &erofs_compressor_lzma);
+#endif
+	erofs_compressor_register(sbi, "deflate", &erofs_compressor_deflate);
+#if HAVE_LIBDEFLATE
+	erofs_compressor_register(sbi, "libdeflate", &erofs_compressor_libdeflate);
+#endif
+}
+
 int erofs_compress_destsize(const struct erofs_compress *c,
 			    const void *src, unsigned int *srcsize,
 			    void *dst, unsigned int dstsize, bool inblocks)
diff --git a/lib/compressor.h b/lib/compressor.h
index 08a3988..66ea933 100644
--- a/lib/compressor.h
+++ b/lib/compressor.h
@@ -8,6 +8,7 @@
 #define __EROFS_LIB_COMPRESSOR_H
 
 #include "erofs/defs.h"
+#include "erofs/config.h"
 
 struct erofs_compress;
 
@@ -56,5 +57,6 @@ int erofs_compressor_setlevel(struct erofs_compress *c, int compression_level);
 int erofs_compressor_init(struct erofs_sb_info *sbi,
 		struct erofs_compress *c, char *alg_name);
 int erofs_compressor_exit(struct erofs_compress *c);
+void erofs_register_compressors(struct erofs_sb_info *sbi);
 
 #endif
-- 
2.34.3

