Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 659DA7293AA
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Jun 2023 10:51:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QcvvD64g5z3f8V
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Jun 2023 18:51:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1686300680;
	bh=jV7H0TlKeTQVDyLVWWCFocgYo7ua2LMccvnQfunfX0I=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=juXl8UqURp5nm6UX6ZV9IPz1716Jyu05GtpDs6ELlUbc/o0OamfJ0DqOJLSi4qgVw
	 4lxZTSSZ+W2A3K2kV2JLmt1iLO8wArqf+5SIzeTMZrgUyjBB2AFr4U14yxohKqDlAS
	 ALsQ9jWLlBm0dR8slQ73pTSUmdWiRn5T+V1Te2L/CIW+S6dcqnARVw1Af3RlhTCb6g
	 mNwAy3yag4zT91RaTdHOQyKZGfmr2hfElUI9vxg4TjzqabYAmt/MaitUXJPAe1rfZ8
	 QcX6CPeDU4mb5eqTP4QEdfjhXxXgrngWAu0rBge4s7uETE9e7iaA77xP/pizkQJpad
	 LsyPcz6I0VBpw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=huaweicloud.com (client-ip=14.137.139.23; helo=frasgout11.his.huawei.com; envelope-from=guoxuenan@huaweicloud.com; receiver=<UNKNOWN>)
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qcvtx23jHz3dqq
	for <linux-erofs@lists.ozlabs.org>; Fri,  9 Jun 2023 18:51:05 +1000 (AEST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qcvfm4NTgz9xHvg
	for <linux-erofs@lists.ozlabs.org>; Fri,  9 Jun 2023 16:40:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
	by APP2 (Coremail) with SMTP id BqC_BwD3GnXj54Jk9pqGCA--.24524S3;
	Fri, 09 Jun 2023 08:50:49 +0000 (GMT)
To: hsiangkao@linux.alibaba.com,
	jefflexu@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/4] erofs-utils: lib: refactor erofs compressors init
Date: Fri,  9 Jun 2023 16:50:38 +0800
Message-Id: <20230609085041.14987-2-guoxuenan@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230609085041.14987-1-guoxuenan@huawei.com>
References: <20230609085041.14987-1-guoxuenan@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: BqC_BwD3GnXj54Jk9pqGCA--.24524S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAF1kGFyDCFW5XF13urW5trb_yoW7JrWfpr
	1DC34rKry8Wrnxuw4fJF4rKFy3Gr1SyF1xuw1UK3s3t3Z8Jr97XF48tr95urW3Gr9xXw4v
	ywsFvw4DWw15tr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Jrv_JF4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCF04k20xvEw4C26cxK6c8Ij2
	8IcwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1xsqtUUUUU==
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

refactor compressor code using constructor.

Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
---
 lib/compressor.c         | 49 ++++++++++++++++++++++++++++++++++++++++
 lib/compressor.h         | 15 ++++++++++++
 lib/compressor_liblzma.c |  5 ++++
 lib/compressor_lz4.c     |  5 ++++
 lib/compressor_lz4hc.c   |  5 ++++
 5 files changed, 79 insertions(+)

diff --git a/lib/compressor.c b/lib/compressor.c
index 52eb761..0fa7105 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -22,6 +22,40 @@ static const struct erofs_compressor *compressors[] = {
 #endif
 };
 
+/* compressing configuration specified by users */
+static struct erofs_supported_algothrim {
+	int algtype;
+	const char *name;
+} erofs_supported_algothrims[] = {
+	{ Z_EROFS_COMPRESSION_LZ4, "lz4"},
+	{ Z_EROFS_COMPRESSION_LZ4, "lz4hc"},
+	{ Z_EROFS_COMPRESSION_LZMA, "lzma"},
+};
+
+static struct erofs_compressors_cfg erofs_ccfg;
+
+int erofs_compressor_num(void)
+{
+	return erofs_ccfg.erofs_ccfg_num;
+}
+
+void erofs_compressor_register(const char *name, const struct erofs_compressor *alg)
+{
+	int i;
+
+	for (i = 0; i < erofs_compressor_num(); i++) {
+		if (!strcmp(erofs_ccfg.compressors[i].name, name)) {
+			erofs_ccfg.compressors[i].handle.alg = alg;
+			return;
+		}
+	}
+
+	erofs_ccfg.compressors[i].name = name;
+	erofs_ccfg.compressors[i].handle.alg = alg;
+	erofs_ccfg.compressors[i].algorithmtype = erofs_supported_algothrims[i].algtype;
+	erofs_ccfg.erofs_ccfg_num = ++i;
+}
+
 int erofs_compress_destsize(const struct erofs_compress *c,
 			    const void *src, unsigned int *srcsize,
 			    void *dst, unsigned int dstsize, bool inblocks)
@@ -106,3 +140,18 @@ int erofs_compressor_exit(struct erofs_compress *c)
 		return c->alg->exit(c);
 	return 0;
 }
+
+void __attribute__((constructor(101))) __erofs_compressor_init(void)
+{
+	int i;
+
+	erofs_ccfg.erofs_ccfg_num = 0;
+	for (i = 0; i < ARRAY_SIZE(erofs_supported_algothrims); i++) {
+		erofs_compressor_register(erofs_supported_algothrims[i].name, NULL);
+	}
+}
+
+void __attribute__((destructor)) __erofs_compressor_exit(void)
+{
+	erofs_err("__erofs_compressor_exit");
+}
diff --git a/lib/compressor.h b/lib/compressor.h
index cf063f1..3c1b328 100644
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
@@ -53,4 +66,6 @@ int erofs_compressor_setlevel(struct erofs_compress *c, int compression_level);
 int erofs_compressor_init(struct erofs_compress *c, char *alg_name);
 int erofs_compressor_exit(struct erofs_compress *c);
 
+void erofs_compressor_register(const char *name, const struct erofs_compressor *alg);
+int erofs_compressor_num(void);
 #endif
diff --git a/lib/compressor_liblzma.c b/lib/compressor_liblzma.c
index f274dce..b24139c 100644
--- a/lib/compressor_liblzma.c
+++ b/lib/compressor_liblzma.c
@@ -108,4 +108,9 @@ const struct erofs_compressor erofs_compressor_lzma = {
 	.setlevel = erofs_compressor_liblzma_setlevel,
 	.compress_destsize = erofs_liblzma_compress_destsize,
 };
+
+static void __attribute__((constructor)) register_lzma_compressor(void)
+{
+	erofs_compressor_register("lzma", &erofs_compressor_lzma);
+}
 #endif
diff --git a/lib/compressor_lz4.c b/lib/compressor_lz4.c
index b6f6e7e..a8adffe 100644
--- a/lib/compressor_lz4.c
+++ b/lib/compressor_lz4.c
@@ -45,3 +45,8 @@ const struct erofs_compressor erofs_compressor_lz4 = {
 	.exit = compressor_lz4_exit,
 	.compress_destsize = lz4_compress_destsize,
 };
+
+static void __attribute__((constructor)) register_lz4_compressor(void)
+{
+	erofs_compressor_register("lz4", &erofs_compressor_lz4);
+}
diff --git a/lib/compressor_lz4hc.c b/lib/compressor_lz4hc.c
index eec1c84..2b7e900 100644
--- a/lib/compressor_lz4hc.c
+++ b/lib/compressor_lz4hc.c
@@ -68,3 +68,8 @@ const struct erofs_compressor erofs_compressor_lz4hc = {
 	.setlevel = compressor_lz4hc_setlevel,
 	.compress_destsize = lz4hc_compress_destsize,
 };
+
+static void __attribute__((constructor)) register_lz4hc_compressor(void)
+{
+	erofs_compressor_register("lz4hc", &erofs_compressor_lz4hc);
+}
-- 
2.31.1

