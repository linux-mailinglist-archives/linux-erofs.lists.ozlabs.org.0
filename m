Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0BE6A295
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2019 09:04:50 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45nrxV6rg6zDqXJ
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2019 17:04:46 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 45nrxM0WjzzDqTk
 for <linux-erofs@lists.ozlabs.org>; Tue, 16 Jul 2019 17:04:39 +1000 (AEST)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 67EA3A52E07961A38557;
 Tue, 16 Jul 2019 15:04:35 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 16 Jul
 2019 15:04:28 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Li Guifu <bluce.liguifu@huawei.com>, Fang Wei <fangwei1@huawei.com>
Subject: [PATCH v2 04/17] erofs-utils: add input/output functions
Date: Tue, 16 Jul 2019 15:04:06 +0800
Message-ID: <20190716070419.30203-5-gaoxiang25@huawei.com>
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

From: Li Guifu <bluce.liguifu@huawei.com>

This patch adds definitions and functions which are
mainly used for reading and writing target image files.

Signed-off-by: Li Guifu <bluce.liguifu@huawei.com>
Signed-off-by: Miao Xie <miaoxie@huawei.com>
Signed-off-by: Fang Wei <fangwei1@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 include/erofs/io.h |  33 ++++++++++++
 lib/Makefile.am    |   2 +-
 lib/io.c           | 123 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 157 insertions(+), 1 deletion(-)
 create mode 100644 include/erofs/io.h
 create mode 100644 lib/io.c

diff --git a/include/erofs/io.h b/include/erofs/io.h
new file mode 100644
index 0000000..9471388
--- /dev/null
+++ b/include/erofs/io.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * erofs_utils/include/erofs/io.h
+ *
+ * Copyright (C) 2018-2019 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Li Guifu <bluce.liguifu@huawei.com>
+ */
+#ifndef __EROFS_IO_H
+#define __EROFS_IO_H
+
+#include <unistd.h>
+#include "internal.h"
+
+#ifndef O_BINARY
+#define O_BINARY	0
+#endif
+
+int dev_open(const char *devname);
+void dev_close(void);
+int dev_write(const void *buf, u64 offset, size_t len);
+int dev_fsync(void);
+u64 dev_length(void);
+
+static inline int blk_write(const void *buf, erofs_blk_t blkaddr,
+			    u32 nblocks)
+{
+	return dev_write(buf, blknr_to_addr(blkaddr),
+			 blknr_to_addr(nblocks));
+}
+
+#endif
+
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 6f1da26..a2c1b24 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -2,6 +2,6 @@
 # Makefile.am
 
 noinst_LTLIBRARIES = liberofs.la
-liberofs_la_SOURCES = config.c
+liberofs_la_SOURCES = config.c io.c
 liberofs_la_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
 
diff --git a/lib/io.c b/lib/io.c
new file mode 100644
index 0000000..f624535
--- /dev/null
+++ b/lib/io.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs_utils/lib/io.c
+ *
+ * Copyright (C) 2018 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Li Guifu <bluce.liguifu@huawei.com>
+ */
+#define _LARGEFILE64_SOURCE
+#include <sys/stat.h>
+#include "erofs/io.h"
+
+#define pr_fmt(fmt) "EROFS IO: " FUNC_LINE_FMT fmt "\n"
+#include "erofs/print.h"
+
+static const char *erofs_devname;
+static int erofs_devfd = -1;
+static u64 erofs_devsz;
+
+void dev_close(void)
+{
+	close(erofs_devfd);
+	erofs_devname = NULL;
+	erofs_devfd   = -1;
+	erofs_devsz   = 0;
+}
+
+int dev_open(const char *dev)
+{
+	struct stat st;
+	int fd, ret;
+
+	fd = open(dev, O_RDWR | O_CREAT | O_BINARY, 0644);
+	if (fd < 0) {
+		erofs_err("failed to open(%s).", dev);
+		return -errno;
+	}
+
+	ret = fstat(fd, &st);
+	if (ret) {
+		erofs_err("failed to fstat(%s).", dev);
+		close(fd);
+		return -errno;
+	}
+
+	switch (st.st_mode & S_IFMT) {
+	case S_IFBLK:
+		erofs_devsz = st.st_size;
+		break;
+	case S_IFREG:
+		ret = ftruncate(fd, 0);
+		if (ret) {
+			erofs_err("failed to ftruncate(%s).", dev);
+			close(fd);
+			return -errno;
+		}
+		/* INT64_MAX is the limit of kernel vfs */
+		erofs_devsz = INT64_MAX;
+		break;
+	default:
+		erofs_err("bad file type (%s, %o).", dev, st.st_mode);
+		close(fd);
+		return -EINVAL;
+	}
+
+	erofs_devname = dev;
+	erofs_devfd = fd;
+	erofs_devsz = round_down(erofs_devsz, EROFS_BLKSIZ);
+
+	erofs_info("successfully to open %s", dev);
+	return 0;
+}
+
+u64 dev_length(void)
+{
+	return erofs_devsz;
+}
+
+int dev_write(const void *buf, u64 offset, size_t len)
+{
+	int ret;
+
+	if (cfg.c_dry_run)
+		return 0;
+
+	if (!buf) {
+		erofs_err("buf is NULL");
+		return -EINVAL;
+	}
+
+	if (offset >= erofs_devsz || len > erofs_devsz ||
+	    offset > erofs_devsz - len) {
+		erofs_err("Write posion[%" PRIu64 ", %zd] is too large beyond the end of device(%" PRIu64 ").",
+			  offset, len, erofs_devsz);
+		return -EINVAL;
+	}
+
+	ret = pwrite64(erofs_devfd, buf, len, (off64_t)offset);
+	if (ret != (int)len) {
+		if (ret < 0) {
+			erofs_err("Failed to write data into device - %s:[%" PRIu64 ", %zd].",
+				  erofs_devname, offset, len);
+			return -errno;
+		}
+
+		erofs_err("Writing data into device - %s:[%" PRIu64 ", %zd] - was truncated.",
+			  erofs_devname, offset, len);
+		return -ERANGE;
+	}
+	return 0;
+}
+
+int dev_fsync(void)
+{
+	int ret;
+
+	ret = fsync(erofs_devfd);
+	if (ret) {
+		erofs_err("Could not fsync device!!!");
+		return -EIO;
+	}
+	return 0;
+}
-- 
2.17.1

