Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BAF6A298
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2019 09:05:07 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45nrxr4xMlzDqLP
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2019 17:05:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.190; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45nrxR1BWWzDqTk
 for <linux-erofs@lists.ozlabs.org>; Tue, 16 Jul 2019 17:04:42 +1000 (AEST)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 63B9CFD2F50C78A4E429;
 Tue, 16 Jul 2019 15:04:40 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 16 Jul
 2019 15:04:33 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Li Guifu <bluce.liguifu@huawei.com>, Fang Wei <fangwei1@huawei.com>
Subject: [PATCH v2 08/17] erofs-utils: introduce generic compression framework
Date: Tue, 16 Jul 2019 15:04:10 +0800
Message-ID: <20190716070419.30203-9-gaoxiang25@huawei.com>
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

