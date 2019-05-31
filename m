Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C48305EC
	for <lists+linux-erofs@lfdr.de>; Fri, 31 May 2019 02:51:46 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45FQrJ2vhvzDqTL
	for <lists+linux-erofs@lfdr.de>; Fri, 31 May 2019 10:51:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1559263904;
	bh=3dbT3qqm5Otr4+n7HOaMIes714dptL0JPALfT94KC5s=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=FDYIwRpkF9kKLGN3cjJw/JJGS7vkwZO7kStOZk/xCo8WVMCvaVbow6igt9YRLDSVP
	 HRP8vexJEtRwBh0t485ss1zDZB+8uekGKyBvKXavaDSzAE/sB3DcdZoB9Z1YBa+Kvw
	 G2VPYvGKn1MsQoyN/ycMsnEKrXXMFZyPBxONXFm/snKBZvnMjSzIGgi4U0c1j3uSsE
	 qSlAytKw7FTHmdwU815CuVmrAf/GkXFKs3cwVbeS4PdQz26nJRw0UCA7w7lvYjLMpo
	 2Ua+cQPlTkt9qrlMIKqpxRhmN1dNjZSiMA7Y8JfNbwDQefz4cUUf2g9ZMeFh5aZBdz
	 CXFEJln7apu1Q==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.69.148; helo=sonic310-22.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="lCXLlt84"; 
 dkim-atps=neutral
Received: from sonic310-22.consmr.mail.gq1.yahoo.com
 (sonic310-22.consmr.mail.gq1.yahoo.com [98.137.69.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45FQqv178YzDqSt
 for <linux-erofs@lists.ozlabs.org>; Fri, 31 May 2019 10:51:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1559263878; bh=H6QMh1j1va8UU4ELfny1cw1jls3BghbO1Qw05W8idJE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=lCXLlt84JSVtJmH/QEyfMolBjiuyovh/HiQFVnYNe4lgDUkAPRwRInINJyVpf8EwGC7wWCOXmKVgjsIH5oh/xl5F8qdOyLvWpv+BDuNLn8L6aM6cXD2AsobByYvT5K7XfmTPZu9KPeI7EXUvf1cip5OzciPkpkmXr/Ay1JKq6f2ySp30qObpxAreKYud5Ky7xusTjobnD34Z0brhgoA9B7g2+y5nMzeUAchBY6TLdgzTPBgKnkZ0JNMAe5uvDszQwRuGjMF060LaLpzYofJ8arZh1e9dQ45rOXEGBAteT7/y7bOsvpEqpQiydD8gB66Uj8ySoHEcoIEwCTa4pKV8Lw==
X-YMail-OSG: eZKfdJMVM1mciQY1UjyPAv6yYIIsqNALLxyf9VmM1ynxzO8cAhzTrPavUX.rpOt
 9dRuKcIe78xlKqPcQgIOuuMHS11f_DReOI3bUQ_mw94USZKcEjk_jBqTa8hZ4_c_jeOL8wkToEB1
 o_7h7sF.FKCrhkUuc6weeJrcgjHoeWTPYu5.XfO3KN468fwuyeLPp5eaKKwEiPLN8WcRHX6avC8P
 G.6zyfasMOdLPwvZ_Yj.U444frs6IVUzfFWQf8__PWoxMlS0_RcHbhT5Jn5J1vbLy27b328DN59j
 rqjxH9SwxdfAw18l33NcngAllYRH5Kx0f0g_INGoEHs89m5tCEv7m4V_II7P5DlEHMd3xRaaBf5O
 bxxeoTaZYr_Q8OcG8A9Pvku8OKqPN4t2PoNCSiE.dIDcNfj6mC0E19v16yEMY3vcaT.niTI1HGjg
 e8k0.TOyFbp.TvTIkOQT7hidI329yEFYmvBBkwb9Eal2947EsGyi2oCrg28gXc3bo2xasScs84gd
 Upiuxnk2rctAcTjQvV_0ka.TbKsaNPoQs2In6MZSNSK2CEX_wr9uxsRtlNrKBqo8g7QxG7AupIqZ
 xPh4oioK6c5ZTzdD5Ncpgp0KD4JWy7DRTMd2LaP5bkPJP2IflCm9w.DgOpJAKJmVzsJMhCq_exSY
 2NvO1E7I8CFOIcLmCL6PbKjccaRvqsei1ZcN4eKQIqS2NeuuMW.vMwKRqlnoOuBuiK6JtMYDdyDu
 R2N8YpM8Y5Mm3GT.36iOxV9DaP6ik1ZlNIMQJrd.XxhDHSNm3omnWFXqdTz_dA4_JrstvjUFgNyu
 Zzf08lCrm4RRjIVFBvdi_p4sZJq4sLg0dEUf4aTLoaPtSo406TmvwyvyLkAE_z37Zba4.OvJzn7i
 dVLtn8IeIPSDWM_dOEFImZ40gOY90651cluaSU_fVX7lS7eIvnFKioEh.jYKbdouIJCWk7SfptBl
 GX2yWr3e7VWyEv_OzNIGQMZONsPCm3bmTXE3YfvTdVmfFqI1fybRwzIE.oLigZAOMLDBfndWo8NF
 weWkL8AJOvwHFPgJfmCZpZvMdrN1CfKSoVCB3JNAJxpcONYLn0xhxIK3LJYPiMgMfWlVVU7yYjYv
 CU.3FJuRuDT5ap.4EIXtBazsVSRVQfh2uT7CFLwxW.e5OMRZ5KF8YvLnoGBipRbLbLBOXoLnA3Lj
 hH1qlZ8YrxbqHNmNpaFvO3jIYSjKSj3MFN31vAvEzz9b_qbXMwT2gtPzOz0rhq.VzyQ--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic310.consmr.mail.gq1.yahoo.com with HTTP; Fri, 31 May 2019 00:51:18 +0000
Received: from 125.120.86.223 (EHLO localhost.localdomain) ([125.120.86.223])
 by smtp417.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID a9e989b6e54ef4fb7ecb5a20a6091749; 
 Fri, 31 May 2019 00:51:17 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 04/13] erofs-utils: add input/output functions
Date: Fri, 31 May 2019 08:50:38 +0800
Message-Id: <20190531005047.22093-5-hsiangkao@aol.com>
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
Cc: Miao Xie <miaoxie@huawei.com>
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

