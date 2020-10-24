Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 4953F297C8B
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Oct 2020 15:11:45 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CJM1p37LzzDqw0
	for <lists+linux-erofs@lfdr.de>; Sun, 25 Oct 2020 00:11:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1603545102;
	bh=epMdGFWgVcliOpZY5CHGt7ZpLtMOUZs2lRzE3xYn2RE=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=I8vMyUF2e+SW8stPqP0j+gAa0zjOnmyZ8LNF8NdZ52bVxqPJy2qmO6vOYda+VWhko
	 5XXmil42Ui2HgEbqQAIwZdEdaixCnyYqzTzBBRRuM9adGZO+cYVrx73cqENSra1zJI
	 F7qmw6C2HExp0uipYTbIdqOSxLRl1NWDNNAVPdRwveNRzQPZ9Ecx6WfMDnOQIxxZCm
	 oD/2qk1V1IDlwccPUnro2Ajq7/oGIG2DuWiOTHmy0HdmfXtH65qfpczFmQ6ZyM4tRY
	 sgjmzyi/nTUmCifqzxOkLrGhbQjjbYtsKHPsSsSvmTtpxDqdVYzwLsDObk8xvZQdui
	 Zr511LnfhPOuw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.66.146; helo=sonic317-20.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=sIvfVVMO; dkim-atps=neutral
Received: from sonic317-20.consmr.mail.gq1.yahoo.com
 (sonic317-20.consmr.mail.gq1.yahoo.com [98.137.66.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CJM0s13M7zDqwP
 for <linux-erofs@lists.ozlabs.org>; Sun, 25 Oct 2020 00:10:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1603545047; bh=ZRdD29YptZhWJdv7dun5dw830WpDaqv/S419YrKT+qI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=sIvfVVMO5P2hNRJYmp2JozXapOJ67gpFtTYDTBPdvYZkTz7Pq9GC9xlT29dJmWowKwAseQufziES78eQgAjdSv2KgIOBnrwu2b09WSeOcgWcDFd9GXrJY9qkGeKTs45vSEwzjIkRdMDNjSLYpOnnu7pw70Un5O3ixk66BvL/0lEIVexewLOVJs1B2EgAwdb8bpnAlSbF0zFJStMJx4PnW8eggB7DPA9OdBaeCr/tGsBfuNNjZgbTIma45EbzoWhFhh7+R3xJvN0v7Do1V/+Aiv2sljFOqlcYFJCfyWt2DpQaNKHQVv2RvxpKnHfxT+CBOYMgHQN30Ehc0RElMXLbhA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1603545047; bh=m3rT9pZYoMtjDQg5jBXTZxyhLV8tzO1TrkxlCVLjVnt=;
 h=From:To:Subject:Date;
 b=LsGCwDce++8rhmWOu/Hb3IRFGagHqHjBE5LfaZGZ4PQQ3lHbzIfbNstwqbn2ALFX8b4b8j+4dQebwBQh5p3Zjngeru0DBvgmWDtsziyW2Kuk2tdTcvaWVMyRx0ouO0qQbjTWP5lR1yu64CccckzXbmPJ71spFrILwRK/Ts8ybngp4d4H/S4eE1Vk/zwh83IKaFaUG8OOQvWzihUVLc1Y11RjwkSNMuYmOZMPL1OSSWmJTKEDpNUJ7TGwROED1Uye/PMEvO4yez+0c7tWZQTPJnsA/8JCb+YTPHTvRYHiohturMbqJLIY/tsqGtQSTxMjdZp0bHNcXSLLOSR4SJcrjg==
X-YMail-OSG: IlZKNSMVM1ktufZWU4btUSbsSpMkYaPKnpS_Qi3Qs_78ZxsfL3VMn3zss34fa4o
 RRl5C4lwKuUuR13eWal2M7Cb1Dvp8ZDxC9gRYpx6NQYbLWczIBrg_CL.ICnVEiM2O5o3N8LKB2u4
 F54NAuky.ZsSjTQ1mH2ZfEX2KDZmqm5SyDXG944HevpklkMEdV0a6OaCp6p7bqeWFFxlO_oliyXj
 645DKeOkSZE.xyUAFIwsGbCMIA1ZQZsRUFv.N8CrEtL4EuIsJ10HcwCBcNrMFyGGbFbYqeogip.c
 JP_kFbEJpkFy8hWzR.dCHhgIv3cibPm19w8w80eufsHYtjJqB05yjemCyxgaitqRFSXhk6YxOOC_
 zuvz1W3.Wd71mXwOAu12eL13JmadV42ZT_4O4PEtUsYwtOHhaN0oWGLXI_YZlZZGVD_um6Kcj7Ep
 s.2qeDM5k16pS1b3Jzsl3.MXu1c5bKLjmUML8hFa_K45ZP.G5N1VICO8NywOrwk.qViE2JlAKDQa
 hbBvC0bHEjpqzGNR9L38zffDyXG22BfIEtjvvFOGSzWCXCOC.EjDIySOr_Zn9C5wmV58N203ipIA
 h2JojL9NDg.1fuvvTgboGTVu_Civ_K1AfplmVHUfknzhHFFfsAVxET6iDTgjpZLQ2QzqXb_97GO0
 GTij1rXbMJbu_QZvzYX4VPbaMFQ5lGDgSYF6NBQE0Bkk9kN9CfCzX8c.Fu4A1u.qwqVFUPYs0UOl
 uXXJuWDXCnz1g7qQ3CHTpjfolc.kH69GF1spZeJ.LewFFwXQ7I2FBlRKa7kDwojurZPJaceKTVEI
 mHnsSfoUH4vD39NrKPjKwmI1Om6lFkJ2g_Bs0umvGVytzDGqrhAN9p_ooHqYBMZRDziI.L5uqTSE
 amqwLeSVpQLBWdB6X1RYEN9OGyRIRXpHCcOlD9OpQSNK7UOd.5MmTQQiqj1voewbKxJhJPBSQbhD
 .C15dlVmsygzCld4zDC3HCnhhWH3j2BiHl5PHeCDKxgbQ3XaDokDUfDDgF5WU_2HKMJCwxsmdFi4
 I3kS2P4VJCqCvTLZ4CkwIwlSmab.4w3V2lJ71hyr8Aq8o.KeRbDp_ocQxHDoCG6MOra3ePIZIKff
 jYXG6RdykpSCkBjMNdmC72HDMeCFEFXLhj_E5TJdne_7Hi9mei4eEmZ0MH7_dompl7I0QaJ4I.cR
 .NgRj9Vpw2loIfhZQllXtUil4HuxUvDbgWt2x3vCYNbeb4yIdIHiXXbbZbfzOUa_8K0ahoZ2Tg1b
 5CfPsBJ9s2uC6ffQLLLfKKzskN0unruI0wmopJR01MX7Y78grMFNWb2VTTHrT3FIPHGHkrAva0W8
 ldZLSSGXnG9clSdrZIqtzYjjEP2a7r7Taz_LidCzsnS1B_RIdIaODa_m9qvR6nCuFA4VfCQZWyN1
 x_JxpULoPBC4ghH24JEqGmVqZwPAUzT1VBQlvmC3jAbNZ.407Maz1GRLZtMCKzXx1k2KAvtOFB2Q
 F3IePad0WnM_s4lA9TOQg3hShebT0df8dmyyX1HytIWmcMkZU4FpqeGvbf4btA60koMhuRiqaVh7
 k844bLklznCDTWOf_bTtlsn5AlUaCPC2KFAu176qaFnUa4Z8omD2Yzx9XPJSPHLWlkool31pCnHI
 TWqkLF2_kjiKg2zMuR.N_xbzGmaiNuo1xwmbqqBfQ9g19Cx5AVIeK6tI7.dtgorgiDvp1mHm1MCH
 eqozleCrcrCxTD0fYEFFY65XL_SMVUw6gt4YY8Ug2hN6hxFvVy6vl80HqFza4okjQgtiPy.f1Jai
 4obhbKbQiWJnXyonR7MeY6154_nDLS_Vk49MsqpiiAG14azPwl5P6oPYS36KXJmOvVxxCFD8CdGT
 rajvUs3a4mRBHAXM2XCpSeHSYNqlHdlxl8tNLcnkRc3W26alt_EnOQ7rjOumndL6WOKVyA.IWFnb
 zFbtJitpTQz9U3UcZF0CaqmaCkNo_TKK75qpeszsFTjDV0za.e0CQD3n2qU9sUq.dB7tcUHkPwcX
 hq7eD8MG9b3YWf8C2Cn6cTiRbdNDZS4hIcXiFq6t6qmHmg2ai0pbQNDE.m8vqU7089MXAyJGLt8p
 nT0_XYXxRs2phVAyHCWY3pSaw8YK8ItNTKs6lYHy2KGDhAB.VGZlmc1EadZQFXrXs1b2uk7K8PFH
 RqFaJIvPlKHLlESZ0mzW_RrBEReYorXiZrwvg69OaIxq9Tn4yeGue4TNOEMK3mwM1hg.7FKLUCYs
 tzI1Gf5kx593H_Ox30oQ_ES3xeVAxZ9mJTdivMPvl8gcWl39nHwdno5YSpu6U3SmNJVSVXmPFJDH
 9CKvdQ7YpTEtUcNCPY0PJj9oXmzRW.UO4uxEAox1H7pwtAcRzoogcS3fPNHE5RjIh6cNv1zGevkL
 CvmYhlCkLQIlN7pTAUl25yH4OhXDe1q2AvOhYnsP5hhjx9a4Z.VKuqCPFeq1mgkdpE_4rpuJfasZ
 1.Ufdjo8OtA_m1xyLmxG2gI9UA.gRuNDPKMkEwRIEycE6.30A6Eru36EihqlD6pgmrTCrFMgHFyh
 AUbwuVdCBd2YXBOJxOl2KcTcyZn7ivdr8Tw7olJSZ3UdpV3w8nXHY_5PbzxwtlW7Le1Zln1Y3QL5
 zwMtTJVesE0XFauLHPZu23XrHsNlS0RKjUl9PbqqTXvaYkEPKsOOW5NM4k0bfo3S61WOxYhhwtaT
 IVKTbcx6IfE2JkOEDcwEmMlQFsnSNC1NRSFcPGQcc6n9wF_urVoS1lxd0kH7awf2t1xRGDmM4_KU
 Gstkzrpx8I8HHjFJx5gm8CSYTf4ccROidqPrPQjFSHPG9Jjbpb_HcfRSbPK72ZwTtQLTt4kAIY93
 WH2NuQnp.S3Vccq2MczqaayNcjoAPEspZCqIyQanxLS5BzuF1Q1egIjFVo.6ezuMIAWiNSwDc2OW
 VpqOnnok-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic317.consmr.mail.gq1.yahoo.com with HTTP; Sat, 24 Oct 2020 13:10:47 +0000
Received: by smtp419.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID afd45167a3858f59b7d63d6cfac9db14; 
 Sat, 24 Oct 2020 13:10:41 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v2 3/5] erofs-utils: fuse: add compressed file support
Date: Sat, 24 Oct 2020 21:09:57 +0800
Message-Id: <20201024130959.23720-4-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201024130959.23720-1-hsiangkao@aol.com>
References: <20201024130959.23720-1-hsiangkao@aol.com>
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
Cc: Zhang Shiming <zhangshiming@oppo.com>, Guo Weichao <guoweichao@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Huang Jianan <huangjianan@oppo.com>

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 fuse/Makefile.am         |   8 +-
 fuse/decompress.c        |  84 ++++++++
 fuse/decompress.h        |  42 ++++
 fuse/dentry.h            |   5 +-
 fuse/init.c              |  22 ++-
 fuse/init.h              |   2 +
 fuse/namei.c             |  11 +-
 fuse/read.c              |  78 +++++++-
 fuse/zmap.c              | 417 +++++++++++++++++++++++++++++++++++++++
 include/erofs/defs.h     |  13 ++
 include/erofs/internal.h |  43 +++-
 include/erofs_fs.h       |   4 +
 12 files changed, 720 insertions(+), 9 deletions(-)
 create mode 100644 fuse/decompress.c
 create mode 100644 fuse/decompress.h
 create mode 100644 fuse/zmap.c

diff --git a/fuse/Makefile.am b/fuse/Makefile.am
index fffd67a53fe1..052c7163dff7 100644
--- a/fuse/Makefile.am
+++ b/fuse/Makefile.am
@@ -3,12 +3,16 @@
 
 AUTOMAKE_OPTIONS = foreign
 bin_PROGRAMS     = erofsfuse
-erofsfuse_SOURCES = main.c dentry.c getattr.c logging.c namei.c read.c disk_io.c init.c open.c readir.c
+erofsfuse_SOURCES = main.c dentry.c getattr.c logging.c namei.c read.c disk_io.c init.c open.c readir.c zmap.c
+if ENABLE_LZ4
+erofsfuse_SOURCES += decompress.c
+endif
 erofsfuse_CFLAGS = -Wall -Werror -Wextra \
+                   -Wno-implicit-fallthrough \
                    -I$(top_srcdir)/include \
                    $(shell pkg-config fuse --cflags) \
                    -DFUSE_USE_VERSION=26 \
                    -std=gnu99
 LDFLAGS += $(shell pkg-config fuse --libs)
-erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la -ldl
+erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la -ldl ${LZ4_LIBS}
 
diff --git a/fuse/decompress.c b/fuse/decompress.c
new file mode 100644
index 000000000000..f2aa84146946
--- /dev/null
+++ b/fuse/decompress.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/fuse/decompress.c
+ *
+ * Copyright (C), 2008-2020, OPPO Mobile Comm Corp., Ltd.
+ * Created by Huang Jianan <huangjianan@oppo.com>
+ */
+#include <stdlib.h>
+#include <lz4.h>
+
+#include "erofs/internal.h"
+#include "erofs/err.h"
+#include "decompress.h"
+#include "logging.h"
+#include "init.h"
+
+static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq)
+{
+	int ret = 0;
+	char *dest = rq->out;
+	char *src = rq->in;
+	char *buff = NULL;
+	bool support_0padding = false;
+	unsigned int inputmargin = 0;
+
+	if (sbk->feature_incompat & EROFS_FEATURE_INCOMPAT_LZ4_0PADDING) {
+		support_0padding = true;
+
+		while (!src[inputmargin & ~PAGE_MASK])
+			if (!(++inputmargin & ~PAGE_MASK))
+				break;
+
+		if (inputmargin >= rq->inputsize)
+			return -EIO;
+	}
+
+	if (rq->decodedskip) {
+		buff = malloc(rq->decodedlength);
+		if (!buff)
+			return -ENOMEM;
+		dest = buff;
+	}
+
+	if (rq->partial_decoding || !support_0padding)
+		ret = LZ4_decompress_safe_partial(src + inputmargin, dest,
+				rq->inputsize - inputmargin,
+				rq->decodedlength, rq->decodedlength);
+	else
+		ret = LZ4_decompress_safe(src + inputmargin, dest,
+					  rq->inputsize - inputmargin,
+					  rq->decodedlength);
+
+	if (ret != (int)rq->decodedlength) {
+		ret = -EIO;
+		goto out;
+	}
+
+	if (rq->decodedskip)
+		memcpy(rq->out, dest + rq->decodedskip,
+		       rq->decodedlength - rq->decodedskip);
+
+out:
+	if (buff)
+		free(buff);
+
+	return ret;
+}
+
+int z_erofs_decompress(struct z_erofs_decompress_req *rq)
+{
+	if (rq->alg == Z_EROFS_COMPRESSION_SHIFTED) {
+		if (rq->inputsize != EROFS_BLKSIZ)
+			return -EFSCORRUPTED;
+
+		DBG_BUGON(rq->decodedlength > EROFS_BLKSIZ);
+		DBG_BUGON(rq->decodedlength < rq->decodedskip);
+
+		memcpy(rq->out, rq->in + rq->decodedskip,
+		       rq->decodedlength - rq->decodedskip);
+		return 0;
+	}
+
+	return z_erofs_decompress_generic(rq);
+}
diff --git a/fuse/decompress.h b/fuse/decompress.h
new file mode 100644
index 000000000000..508aabab1664
--- /dev/null
+++ b/fuse/decompress.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * erofs-utils/fuse/decompress.h
+ *
+ * Copyright (C), 2008-2020, OPPO Mobile Comm Corp., Ltd.
+ * Created by Huang Jianan <huangjianan@oppo.com>
+ */
+#ifndef __EROFS_DECOMPRESS_H
+#define __EROFS_DECOMPRESS_H
+
+#include "erofs/internal.h"
+
+enum {
+	Z_EROFS_COMPRESSION_SHIFTED = Z_EROFS_COMPRESSION_MAX,
+	Z_EROFS_COMPRESSION_RUNTIME_MAX
+};
+
+struct z_erofs_decompress_req {
+	char *in, *out;
+
+	/*
+	 * initial decompressed bytes that need to be skipped
+	 * when finally copying to output buffer
+	 */
+	unsigned int decodedskip;
+	unsigned int inputsize, decodedlength;
+
+	/* indicate the algorithm will be used for decompression */
+	unsigned int alg;
+	bool partial_decoding;
+};
+
+#ifdef LZ4_ENABLED
+int z_erofs_decompress(struct z_erofs_decompress_req *rq);
+#else
+int z_erofs_decompress(struct z_erofs_decompress_req *rq)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
+#endif
diff --git a/fuse/dentry.h b/fuse/dentry.h
index cb4d87972b2d..12f4cf6bafd9 100644
--- a/fuse/dentry.h
+++ b/fuse/dentry.h
@@ -10,10 +10,11 @@
 #include <stdint.h>
 #include "erofs/internal.h"
 
+/* fixme: Deal with names that exceed the allocated size */
 #ifdef __64BITS
-#define DCACHE_ENTRY_NAME_LEN       40
+#define DCACHE_ENTRY_NAME_LEN       EROFS_NAME_LEN
 #else
-#define DCACHE_ENTRY_NAME_LEN       48
+#define DCACHE_ENTRY_NAME_LEN       EROFS_NAME_LEN
 #endif
 
 /* This struct declares a node of a k-tree.  Every node has a pointer to one of
diff --git a/fuse/init.c b/fuse/init.c
index 043629ff1088..48125c5791fa 100644
--- a/fuse/init.c
+++ b/fuse/init.c
@@ -17,7 +17,23 @@
 
 
 struct erofs_super_block super;
-static struct erofs_super_block *sbk = &super;
+struct erofs_super_block *sbk = &super;
+
+static bool check_layout_compatibility(struct erofs_super_block *sb,
+				       struct erofs_super_block *dsb)
+{
+	const unsigned int feature = le32_to_cpu(dsb->feature_incompat);
+
+	sb->feature_incompat = feature;
+
+	/* check if current kernel meets all mandatory requirements */
+	if (feature & (~EROFS_ALL_FEATURE_INCOMPAT)) {
+		loge("unidentified incompatible feature %x, please upgrade kernel version",
+		     feature & ~EROFS_ALL_FEATURE_INCOMPAT);
+		return false;
+	}
+	return true;
+}
 
 int erofs_init_super(void)
 {
@@ -40,6 +56,9 @@ int erofs_init_super(void)
 		return -EINVAL;
 	}
 
+	if (!check_layout_compatibility(sbk, sb))
+		return -EINVAL;
+
 	sbk->checksum = le32_to_cpu(sb->checksum);
 	sbk->feature_compat = le32_to_cpu(sb->feature_compat);
 	sbk->blkszbits = sb->blkszbits;
@@ -56,6 +75,7 @@ int erofs_init_super(void)
 	sbk->root_nid = le16_to_cpu(sb->root_nid);
 
 	logp("%-15s:0x%X", STR(magic), SUPER_MEM(magic));
+	logp("%-15s:0x%X", STR(feature_incompat), SUPER_MEM(feature_incompat));
 	logp("%-15s:0x%X", STR(feature_compat), SUPER_MEM(feature_compat));
 	logp("%-15s:%u",   STR(blkszbits), SUPER_MEM(blkszbits));
 	logp("%-15s:%u",   STR(root_nid), SUPER_MEM(root_nid));
diff --git a/fuse/init.h b/fuse/init.h
index 34085f2b548d..405a92913b4a 100644
--- a/fuse/init.h
+++ b/fuse/init.h
@@ -13,6 +13,8 @@
 
 #define BOOT_SECTOR_SIZE	0x400
 
+extern struct erofs_super_block *sbk;
+
 int erofs_init_super(void);
 erofs_nid_t erofs_get_root_nid(void);
 erofs_off_t nid2addr(erofs_nid_t nid);
diff --git a/fuse/namei.c b/fuse/namei.c
index 6917d78d4f22..c33af4b04b45 100644
--- a/fuse/namei.c
+++ b/fuse/namei.c
@@ -49,7 +49,7 @@ static inline dev_t new_decode_dev(u32 dev)
 
 int erofs_iget_by_nid(erofs_nid_t nid, struct erofs_vnode *vi)
 {
-	int ret;
+	int ret, ifmt;
 	char buf[EROFS_BLKSIZ];
 	struct erofs_inode_compact *v1;
 	const erofs_off_t addr = nid2addr(nid);
@@ -60,6 +60,11 @@ int erofs_iget_by_nid(erofs_nid_t nid, struct erofs_vnode *vi)
 		return -EIO;
 
 	v1 = (struct erofs_inode_compact *)buf;
+	/* fixme: support extended inode */
+	ifmt = le16_to_cpu(v1->i_format);
+	if (__inode_version(ifmt) != EROFS_INODE_LAYOUT_COMPACT)
+		return -EOPNOTSUPP;
+
 	vi->datalayout = __inode_data_mapping(le16_to_cpu(v1->i_format));
 	vi->inode_isize = sizeof(struct erofs_inode_compact);
 	vi->xattr_isize = erofs_xattr_ibody_size(v1->i_xattr_icount);
@@ -88,6 +93,10 @@ int erofs_iget_by_nid(erofs_nid_t nid, struct erofs_vnode *vi)
 		return -EIO;
 	}
 
+	vi->z_inited = false;
+	if (erofs_inode_is_data_compressed(vi->datalayout))
+		z_erofs_fill_inode(vi);
+
 	return 0;
 }
 
diff --git a/fuse/read.c b/fuse/read.c
index 760c9aa37f91..e2f967aefb8a 100644
--- a/fuse/read.c
+++ b/fuse/read.c
@@ -3,6 +3,7 @@
  * erofs-utils/fuse/read.c
  *
  * Created by Li Guifu <blucerlee@gmail.com>
+ * Compression support by Huang Jianan <huangjianan@oppo.com>
  */
 #include "read.h"
 #include <errno.h>
@@ -16,6 +17,7 @@
 #include "namei.h"
 #include "disk_io.h"
 #include "init.h"
+#include "decompress.h"
 
 size_t erofs_read_data(struct erofs_vnode *vnode, char *buffer,
 		       size_t size, off_t offset)
@@ -77,6 +79,77 @@ finished:
 
 }
 
+size_t erofs_read_data_compression(struct erofs_vnode *vnode, char *buffer,
+				   erofs_off_t size, erofs_off_t offset)
+{
+	int ret;
+	erofs_off_t end, length, skip;
+	struct erofs_map_blocks map = {
+		.index = UINT_MAX,
+	};
+	bool partial;
+	unsigned int algorithmformat;
+	char raw[EROFS_BLKSIZ];
+
+	end = offset + size;
+	while (end > offset) {
+		map.m_la = end - 1;
+
+		ret = z_erofs_map_blocks_iter(vnode, &map);
+		if (ret)
+			return ret;
+
+		if (!(map.m_flags & EROFS_MAP_MAPPED)) {
+			end = map.m_la;
+			continue;
+		}
+
+		ret = dev_read(raw, EROFS_BLKSIZ, map.m_pa);
+		if (ret < 0 || (size_t)ret != EROFS_BLKSIZ)
+			return -EIO;
+
+		algorithmformat = map.m_flags & EROFS_MAP_ZIPPED ?
+						Z_EROFS_COMPRESSION_LZ4 :
+						Z_EROFS_COMPRESSION_SHIFTED;
+
+		/*
+		 * trim to the needed size if the returned extent is quite
+		 * larger than requested, and set up partial flag as well.
+		 */
+		if (end < map.m_la + map.m_llen) {
+			length = end - map.m_la;
+			partial = true;
+		} else {
+			ASSERT(end == map.m_la + map.m_llen);
+			length = map.m_llen;
+			partial = !(map.m_flags & EROFS_MAP_FULL_MAPPED);
+		}
+
+		if (map.m_la < offset) {
+			skip = offset - map.m_la;
+			end = offset;
+		} else {
+			skip = 0;
+			end = map.m_la;
+		}
+
+		ret = z_erofs_decompress(&(struct z_erofs_decompress_req) {
+					.in = raw,
+					.out = buffer + end - offset,
+					.decodedskip = skip,
+					.inputsize = map.m_plen,
+					.decodedlength = length,
+					.alg = algorithmformat,
+					.partial_decoding = partial
+					 });
+		if (ret < 0)
+			return ret;
+	}
+
+	logi("nid:%u size=%zd offset=%llu done",
+	     vnode->nid, size, (long long)offset);
+	return size;
+}
 
 int erofs_read(const char *path, char *buffer, size_t size, off_t offset,
 	       struct fuse_file_info *fi)
@@ -106,7 +179,8 @@ int erofs_read(const char *path, char *buffer, size_t size, off_t offset,
 
 	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
 	case EROFS_INODE_FLAT_COMPRESSION:
-		/* Fixme: */
+		return erofs_read_data_compression(&v, buffer, size, offset);
+
 	default:
 		return -EINVAL;
 	}
@@ -136,4 +210,4 @@ int erofs_readlink(const char *path, char *buffer, size_t size)
 
 	logi("path:%s link=%s size=%llu", path, buffer, lnksz);
 	return 0;
-}
\ No newline at end of file
+}
diff --git a/fuse/zmap.c b/fuse/zmap.c
new file mode 100644
index 000000000000..8ec0a7707fd6
--- /dev/null
+++ b/fuse/zmap.c
@@ -0,0 +1,417 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/fuse/zmap.c
+ *
+ * (a large amount of code was adapted from Linux kernel. )
+ *
+ * Copyright (C) 2018-2019 HUAWEI, Inc.
+ *             https://www.huawei.com/
+ * Created by Gao Xiang <gaoxiang25@huawei.com>
+ * Modified by Huang Jianan <huangjianan@oppo.com>
+ */
+#include "init.h"
+#include "disk_io.h"
+#include "logging.h"
+
+int z_erofs_fill_inode(struct erofs_vnode *vi)
+{
+	if (vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY) {
+		vi->z_advise = 0;
+		vi->z_algorithmtype[0] = 0;
+		vi->z_algorithmtype[1] = 0;
+		vi->z_logical_clusterbits = LOG_BLOCK_SIZE;
+		vi->z_physical_clusterbits[0] = vi->z_logical_clusterbits;
+		vi->z_physical_clusterbits[1] = vi->z_logical_clusterbits;
+		vi->z_inited = true;
+	}
+
+	return 0;
+}
+
+static int z_erofs_fill_inode_lazy(struct erofs_vnode *vi)
+{
+	int ret;
+	erofs_off_t pos;
+	struct z_erofs_map_header *h;
+	char buf[8];
+
+	if (vi->z_inited)
+		return 0;
+
+	DBG_BUGON(vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY);
+
+	pos = round_up(nid2addr(vi->nid) + vi->inode_isize + vi->xattr_isize, 8);
+
+	ret = dev_read(buf, 8, pos);
+	if (ret < 0 && (uint32_t)ret != 8)
+		return -EIO;
+
+	h = (struct z_erofs_map_header *)buf;
+	vi->z_advise = le16_to_cpu(h->h_advise);
+	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
+	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
+
+	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX) {
+		loge("unknown compression format %u for nid %llu",
+		     vi->z_algorithmtype[0], vi->nid);
+		return -EOPNOTSUPP;
+	}
+
+	vi->z_logical_clusterbits = LOG_BLOCK_SIZE + (h->h_clusterbits & 7);
+	vi->z_physical_clusterbits[0] = vi->z_logical_clusterbits +
+					((h->h_clusterbits >> 3) & 3);
+
+	if (vi->z_physical_clusterbits[0] != LOG_BLOCK_SIZE) {
+		loge("unsupported physical clusterbits %u for nid %llu",
+		     vi->z_physical_clusterbits[0], vi->nid);
+		return -EOPNOTSUPP;
+	}
+
+	vi->z_physical_clusterbits[1] = vi->z_logical_clusterbits +
+					((h->h_clusterbits >> 5) & 7);
+	vi->z_inited = true;
+
+	return 0;
+}
+
+struct z_erofs_maprecorder {
+	struct erofs_vnode *vnode;
+	struct erofs_map_blocks *map;
+	void *kaddr;
+
+	unsigned long lcn;
+	/* compression extent information gathered */
+	u8  type;
+	u16 clusterofs;
+	u16 delta[2];
+	erofs_blk_t pblk;
+};
+
+static int z_erofs_reload_indexes(struct z_erofs_maprecorder *m,
+				  erofs_blk_t eblk)
+{
+	int ret;
+	struct erofs_map_blocks *const map = m->map;
+	char *mpage = map->mpage;
+
+	if (map->index == eblk)
+		return 0;
+
+	ret = dev_read(mpage, EROFS_BLKSIZ, blknr_to_addr(eblk));
+	if (ret < 0 && (uint32_t)ret != EROFS_BLKSIZ)
+		return -EIO;
+
+	map->index = eblk;
+
+	return 0;
+}
+
+static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
+					 unsigned long lcn)
+{
+	struct erofs_vnode *const vi = m->vnode;
+	const erofs_off_t ibase = nid2addr(vi->nid);
+	const erofs_off_t pos =
+		Z_EROFS_VLE_LEGACY_INDEX_ALIGN(ibase + vi->inode_isize +
+					       vi->xattr_isize) +
+		lcn * sizeof(struct z_erofs_vle_decompressed_index);
+	struct z_erofs_vle_decompressed_index *di;
+	unsigned int advise, type;
+	int err;
+
+	err = z_erofs_reload_indexes(m, erofs_blknr(pos));
+	if (err)
+		return err;
+
+	m->lcn = lcn;
+	di = m->kaddr + erofs_blkoff(pos);
+
+	advise = le16_to_cpu(di->di_advise);
+	type = (advise >> Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT) &
+		((1 << Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS) - 1);
+	switch (type) {
+	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
+		m->clusterofs = 1 << vi->z_logical_clusterbits;
+		m->delta[0] = le16_to_cpu(di->di_u.delta[0]);
+		m->delta[1] = le16_to_cpu(di->di_u.delta[1]);
+		break;
+	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
+	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
+		m->clusterofs = le16_to_cpu(di->di_clusterofs);
+		m->pblk = le32_to_cpu(di->di_u.blkaddr);
+		break;
+	default:
+		DBG_BUGON(1);
+		return -EOPNOTSUPP;
+	}
+	m->type = type;
+	return 0;
+}
+
+static unsigned int decode_compactedbits(unsigned int lobits,
+					 unsigned int lomask,
+					 u8 *in, unsigned int pos, u8 *type)
+{
+	const unsigned int v = get_unaligned_le32(in + pos / 8) >> (pos & 7);
+	const unsigned int lo = v & lomask;
+
+	*type = (v >> lobits) & 3;
+	return lo;
+}
+
+static int unpack_compacted_index(struct z_erofs_maprecorder *m,
+				  unsigned int amortizedshift,
+				  unsigned int eofs)
+{
+	struct erofs_vnode *const vi = m->vnode;
+	const unsigned int lclusterbits = vi->z_logical_clusterbits;
+	const unsigned int lomask = (1 << lclusterbits) - 1;
+	unsigned int vcnt, base, lo, encodebits, nblk;
+	int i;
+	u8 *in, type;
+
+	if (1 << amortizedshift == 4)
+		vcnt = 2;
+	else if (1 << amortizedshift == 2 && lclusterbits == 12)
+		vcnt = 16;
+	else
+		return -EOPNOTSUPP;
+
+	encodebits = ((vcnt << amortizedshift) - sizeof(__le32)) * 8 / vcnt;
+	base = round_down(eofs, vcnt << amortizedshift);
+	in = m->kaddr + base;
+
+	i = (eofs - base) >> amortizedshift;
+
+	lo = decode_compactedbits(lclusterbits, lomask,
+				  in, encodebits * i, &type);
+	m->type = type;
+	if (type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) {
+		m->clusterofs = 1 << lclusterbits;
+		if (i + 1 != (int)vcnt) {
+			m->delta[0] = lo;
+			return 0;
+		}
+		/*
+		 * since the last lcluster in the pack is special,
+		 * of which lo saves delta[1] rather than delta[0].
+		 * Hence, get delta[0] by the previous lcluster indirectly.
+		 */
+		lo = decode_compactedbits(lclusterbits, lomask,
+					  in, encodebits * (i - 1), &type);
+		if (type != Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD)
+			lo = 0;
+		m->delta[0] = lo + 1;
+		return 0;
+	}
+	m->clusterofs = lo;
+	m->delta[0] = 0;
+	/* figout out blkaddr (pblk) for HEAD lclusters */
+	nblk = 1;
+	while (i > 0) {
+		--i;
+		lo = decode_compactedbits(lclusterbits, lomask,
+					  in, encodebits * i, &type);
+		if (type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD)
+			i -= lo;
+
+		if (i >= 0)
+			++nblk;
+	}
+	in += (vcnt << amortizedshift) - sizeof(__le32);
+	m->pblk = le32_to_cpu(*(__le32 *)in) + nblk;
+	return 0;
+}
+
+static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
+					    unsigned long lcn)
+{
+	struct erofs_vnode *const vi = m->vnode;
+	const unsigned int lclusterbits = vi->z_logical_clusterbits;
+	const erofs_off_t ebase = round_up(nid2addr(vi->nid) + vi->inode_isize +
+					   vi->xattr_isize, 8) +
+		sizeof(struct z_erofs_map_header);
+	const unsigned int totalidx = DIV_ROUND_UP(vi->i_size, EROFS_BLKSIZ);
+	unsigned int compacted_4b_initial, compacted_2b;
+	unsigned int amortizedshift;
+	erofs_off_t pos;
+	int err;
+
+	if (lclusterbits != 12)
+		return -EOPNOTSUPP;
+
+	if (lcn >= totalidx)
+		return -EINVAL;
+
+	m->lcn = lcn;
+	/* used to align to 32-byte (compacted_2b) alignment */
+	compacted_4b_initial = (32 - ebase % 32) / 4;
+	if (compacted_4b_initial == 32 / 4)
+		compacted_4b_initial = 0;
+
+	if (vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B)
+		compacted_2b = rounddown(totalidx - compacted_4b_initial, 16);
+	else
+		compacted_2b = 0;
+
+	pos = ebase;
+	if (lcn < compacted_4b_initial) {
+		amortizedshift = 2;
+		goto out;
+	}
+	pos += compacted_4b_initial * 4;
+	lcn -= compacted_4b_initial;
+
+	if (lcn < compacted_2b) {
+		amortizedshift = 1;
+		goto out;
+	}
+	pos += compacted_2b * 2;
+	lcn -= compacted_2b;
+	amortizedshift = 2;
+out:
+	pos += lcn * (1 << amortizedshift);
+	err = z_erofs_reload_indexes(m, erofs_blknr(pos));
+	if (err)
+		return err;
+	return unpack_compacted_index(m, amortizedshift, erofs_blkoff(pos));
+}
+
+static int z_erofs_load_cluster_from_disk(struct z_erofs_maprecorder *m,
+					  unsigned int lcn)
+{
+	const unsigned int datamode = m->vnode->datalayout;
+
+	if (datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY)
+		return legacy_load_cluster_from_disk(m, lcn);
+
+	if (datamode == EROFS_INODE_FLAT_COMPRESSION)
+		return compacted_load_cluster_from_disk(m, lcn);
+
+	return -EINVAL;
+}
+
+static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
+				   unsigned int lookback_distance)
+{
+	struct erofs_vnode *const vi = m->vnode;
+	struct erofs_map_blocks *const map = m->map;
+	const unsigned int lclusterbits = vi->z_logical_clusterbits;
+	unsigned long lcn = m->lcn;
+	int err;
+
+	if (lcn < lookback_distance) {
+		loge("bogus lookback distance @ nid %llu", vi->nid);
+		DBG_BUGON(1);
+		return -EFSCORRUPTED;
+	}
+
+	/* load extent head logical cluster if needed */
+	lcn -= lookback_distance;
+	err = z_erofs_load_cluster_from_disk(m, lcn);
+	if (err)
+		return err;
+
+	switch (m->type) {
+	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
+		if (!m->delta[0]) {
+			loge("invalid lookback distance 0 @ nid %llu",
+				  vi->nid);
+			DBG_BUGON(1);
+			return -EFSCORRUPTED;
+		}
+		return z_erofs_extent_lookback(m, m->delta[0]);
+	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
+		map->m_flags &= ~EROFS_MAP_ZIPPED;
+	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
+		map->m_la = (lcn << lclusterbits) | m->clusterofs;
+		break;
+	default:
+		loge("unknown type %u @ lcn %lu of nid %llu",
+		     m->type, lcn, vi->nid);
+		DBG_BUGON(1);
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+int z_erofs_map_blocks_iter(struct erofs_vnode *vi,
+			    struct erofs_map_blocks *map)
+{
+	struct z_erofs_maprecorder m = {
+		.vnode = vi,
+		.map = map,
+		.kaddr = map->mpage,
+	};
+	int err = 0;
+	unsigned int lclusterbits, endoff;
+	unsigned long long ofs, end;
+
+	/* when trying to read beyond EOF, leave it unmapped */
+	if (map->m_la >= vi->i_size) {
+		map->m_llen = map->m_la + 1 - vi->i_size;
+		map->m_la = vi->i_size;
+		map->m_flags = 0;
+		goto out;
+	}
+
+	err = z_erofs_fill_inode_lazy(vi);
+	if (err)
+		goto out;
+
+	lclusterbits = vi->z_logical_clusterbits;
+	ofs = map->m_la;
+	m.lcn = ofs >> lclusterbits;
+	endoff = ofs & ((1 << lclusterbits) - 1);
+
+	err = z_erofs_load_cluster_from_disk(&m, m.lcn);
+	if (err)
+		goto out;
+
+	map->m_flags = EROFS_MAP_ZIPPED;	/* by default, compressed */
+	end = (m.lcn + 1ULL) << lclusterbits;
+	switch (m.type) {
+	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
+		if (endoff >= m.clusterofs)
+			map->m_flags &= ~EROFS_MAP_ZIPPED;
+	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
+		if (endoff >= m.clusterofs) {
+			map->m_la = (m.lcn << lclusterbits) | m.clusterofs;
+			break;
+		}
+		/* m.lcn should be >= 1 if endoff < m.clusterofs */
+		if (!m.lcn) {
+			loge("invalid logical cluster 0 at nid %llu",
+			     vi->nid);
+			err = -EFSCORRUPTED;
+			goto out;
+		}
+		end = (m.lcn << lclusterbits) | m.clusterofs;
+		map->m_flags |= EROFS_MAP_FULL_MAPPED;
+		m.delta[0] = 1;
+	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
+		/* get the correspoinding first chunk */
+		err = z_erofs_extent_lookback(&m, m.delta[0]);
+		if (err)
+			goto out;
+		break;
+	default:
+		loge("unknown type %u @ offset %llu of nid %llu",
+		     m.type, ofs, vi->nid);
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+
+	map->m_llen = end - map->m_la;
+	map->m_plen = 1 << lclusterbits;
+	map->m_pa = blknr_to_addr(m.pblk);
+	map->m_flags |= EROFS_MAP_MAPPED;
+
+out:
+	logd("m_la %llu m_pa %llu m_llen %llu m_plen %llu m_flags 0%o",
+	     map->m_la, map->m_pa,
+	     map->m_llen, map->m_plen, map->m_flags);
+
+	DBG_BUGON(err < 0 && err != -ENOMEM);
+	return err;
+}
diff --git a/include/erofs/defs.h b/include/erofs/defs.h
index e97de36aa04b..c42ca401a8ee 100644
--- a/include/erofs/defs.h
+++ b/include/erofs/defs.h
@@ -173,5 +173,18 @@ typedef int64_t         s64;
 #define __maybe_unused      __attribute__((__unused__))
 #endif
 
+struct __una_u32 { u32 x; } __packed;
+
+static inline u32 __get_unaligned_cpu32(const void *p)
+{
+	const struct __una_u32 *ptr = (const struct __una_u32 *)p;
+	return ptr->x;
+}
+
+static inline u32 get_unaligned_le32(const void *p)
+{
+	return __get_unaligned_cpu32((const u8 *)p);
+}
+
 #endif
 
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index e2769a6be4c9..6c5fbd3c5d3c 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -36,6 +36,8 @@ typedef unsigned short umode_t;
 #error incompatible PAGE_SIZE is already defined
 #endif
 
+#define PAGE_MASK		(~(PAGE_SIZE-1))
+
 #define LOG_BLOCK_SIZE          (12)
 #define EROFS_BLKSIZ            (1U << LOG_BLOCK_SIZE)
 
@@ -145,7 +147,15 @@ struct erofs_vnode {
 	uint16_t xattr_shared_count;
 	char *xattr_shared_xattrs;
 
-	erofs_blk_t raw_blkaddr;
+	union {
+		erofs_blk_t raw_blkaddr;
+		struct {
+			uint16_t z_advise;
+			uint8_t  z_algorithmtype[2];
+			uint8_t  z_logical_clusterbits;
+			uint8_t  z_physical_clusterbits[2];
+		};
+	};
 	erofs_nid_t nid;
 	uint32_t i_ino;
 
@@ -155,6 +165,7 @@ struct erofs_vnode {
 	uint16_t i_nlink;
 	uint32_t i_rdev;
 
+	bool z_inited;
 	/* if file is inline read inline data witch inode */
 	char *idata;
 };
@@ -207,5 +218,35 @@ static inline const char *erofs_strerror(int err)
 	return msg;
 }
 
+enum {
+	BH_Mapped ,
+	BH_Zipped ,
+	BH_FullMapped,
+};
+
+/* Has a disk mapping */
+#define EROFS_MAP_MAPPED	(1 << BH_Mapped)
+/* The extent has been compressed */
+#define EROFS_MAP_ZIPPED	(1 << BH_Zipped)
+/* The length of extent is full */
+#define EROFS_MAP_FULL_MAPPED	(1 << BH_FullMapped)
+
+struct erofs_map_blocks {
+	char mpage[EROFS_BLKSIZ];
+
+	erofs_off_t m_pa, m_la;
+	u64 m_plen, m_llen;
+
+	unsigned int m_flags;
+	erofs_blk_t index;
+};
+
+/* zmap.c */
+int z_erofs_fill_inode(struct erofs_vnode *vi);
+int z_erofs_map_blocks_iter(struct erofs_vnode *vi,
+			    struct erofs_map_blocks *map);
+
+#define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
+
 #endif
 
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 4cd79f01d820..a69f179a51a5 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -279,6 +279,10 @@ struct z_erofs_vle_decompressed_index {
 	} di_u;
 };
 
+#define Z_EROFS_VLE_LEGACY_INDEX_ALIGN(size) \
+	(round_up(size, sizeof(struct z_erofs_vle_decompressed_index)) + \
+	 sizeof(struct z_erofs_map_header) + Z_EROFS_VLE_LEGACY_HEADER_PADDING)
+
 #define Z_EROFS_VLE_EXTENT_ALIGN(size) round_up(size, \
 	sizeof(struct z_erofs_vle_decompressed_index))
 
-- 
2.24.0

