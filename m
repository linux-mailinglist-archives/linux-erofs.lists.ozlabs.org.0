Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5F22B2FAD
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Nov 2020 19:27:04 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CYP1x4S0TzDqSR
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Nov 2020 05:27:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1605378421;
	bh=6Gcrp8nuA651ewMU95u4TVUipsqUqNir4HR8zi0Nki0=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=PGeQm0IQX/aTea6a4Awkt16tYuJ7Jr5FNIlbIIWzInGTjnVtnOpcCwGv4qhc23lnE
	 te4FNJDbUG3CRy9uFWV5mLbOuNS8+shs9DjOw6MGti48o/Sfkz5d33OUcPKzIKWWyg
	 9Cz5snF4+RvHSM4Fn9LWMDGwh22hsq4AT5bPx8YMw+J293Y89VXGDxjJ85ESDcZYaz
	 NGAXb6Wkfp0z3R6T06rYrNaPcqTPxab2VSU7yzX4OTGVstWmjjDJv4Pkd0XpLPW0kn
	 naVjWM5Bwr+oLeBtR/nKo57yRcecLcmLgLLnKdbAjNLYNPk0Q8o5LFJtaDd1070dBr
	 /A4uPoZm8wJHQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.83; helo=sonic306-20.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=RepVJVHY; dkim-atps=neutral
Received: from sonic306-20.consmr.mail.gq1.yahoo.com
 (sonic306-20.consmr.mail.gq1.yahoo.com [98.137.68.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CYP1J0nWLzDqSK
 for <linux-erofs@lists.ozlabs.org>; Sun, 15 Nov 2020 05:26:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1605378384; bh=5/HJce7Q0NfWQi3OWD6zJ5Ez8ZouEpbTcfYi0yXnC7E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=RepVJVHYPAujoaYmZCkPsJjGFd37qnH157StblVSDzS9rYTsRuTtize8FMdjSiZEPMy+Q4nUtEUVx4m21R9p1F5kENma1bnT561eWb2ZQt8AI0Ln1+iHxGUxTEDnjLGBh/yUat5y1q5e3HGBFXY6LlGlbEtDcvy03mu2sTxrWE7lV6Et9DwjLz8Zw43/YWFX/a/Yk3VfKG9wClxUX+HR4QmXpR2rqKgNMjoJ8vVU+jPNK4Nlq2IFxPwnA9Oa+1nudqF4XkR3tIw+5mr/o4lU6a2j9w6mqCOIdAPluiePihcfg3liu3TkSZOPTxgx1ycRNR9TPERCrLlh07X/J7PJKQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1605378384; bh=4ZRRLZghOJb77y6rDJtzu5e2b9uXkjsq4WAx8a02akQ=;
 h=From:To:Subject:Date:From:Subject;
 b=K89cLVEAQlQDpk0KsR5y2zzIon7tsLjwHjUqunBTmADFxac1CmO/0EHf13ZqMgp5I2R81JnM8Clgs/cqKWxrD/WChsroj6ctNgduMuILSoekHPaJAQnIT7eKdvADY9+GMhaBiebxFYhTyl+GUhcTjud4h79zKmmgFIrnyBu2HqiHDXta6u+OblOxda5fDQsyI67KwV1+OIvQFYVtEaiC0jcO6wG4TNK1uITnhrhikm6RaJY1T2/jdYsYD9PJJ9C41j9jLIbNxVp0EPZAoNW4HAZJLrXoc7Luasscqb3224jdjWcM6vN+fF5hu2rEWERJJzamhNWSojQbpbq3eN5+RA==
X-YMail-OSG: zlketLwVM1mOJARpvlF1dts9AI2X0WEURMi7w3lygsMpy46A3dkwjOyLobYoNA9
 INP8P6SsRoImkof87rXELFyWXscd0hkSBDvm9TEOyoQsGWQ6zRiDXEXuKS3PMwBasSP_mGRJYVIW
 7zLOV9Y0LKiOs07aklP2rkcsRiAZ_U4vxnZzPeOPybzA_jaxCsvRP6ymp7RCEUirsTohSLNdVtni
 5FBCbDHyUOtqhCE0AmTZmRTIyO.pCWH.wthOY7z10dQLeLGdv4bEN_9hnkwg.flc4GeglvE2z.on
 rDRgCv_CWDiH2lBg2Zde90dGxOs3TsPA63AXXF1IwUUgAEAKYK8hZQQMq.NKaXgpOW2y7GftUpjz
 ruw5VEyjd7vdQTXWj_EKEDcQsFc5hZ66nsUndK0ugB.RPg5FE43MnLCSE0SIQ6PSbn2O66Z.Fhvj
 SmGHCex6jB7LEAXVfITCysoF4KVqoe3wxJEb51KxBjmrvpeBvOp1iIGG4re8WRSTN2LpH2ZJSCTR
 dFkenG4HCV2us0BRKFJYr0svp1EuBDeC9aempvttzKGToG9hFxM3u5G46Ispi0LLqRo7gGNPyxuc
 AjHsCYYUC49gNXo6oHbiJNjWu3foyIphX7AAYsMc4NEu3NxjDjoTqL7sZ4XN35qpIEHUGDGdh4s.
 .yhiU35eELCFepKuKevERmYQpFKVawqI2cNDHVJU6oLEpnARlLFT_C_ZvUTjzRSQ2Y.fUu7U9DoC
 aIz1BPtvW6TXtszyXGhm6EiMjufQTmDsUjTNWKtUaAKhRMc07sLhjrFa711rG3H3Or3ggKfd...R
 MB3FHTgRnZIpTjJaObtCTGThTCyONVHuOXPel6k8jxj1efupWcVh5BuQbOTyAmK0CjZNWze48Fmm
 INc1SsjTBFPtvoIQtt.ifFhucogOIC2rmyQgQSKUbu5xi2F_K_qWeoNuQ4lHl74A8PRzPBHlkh7r
 ZOx_Mf5CxVyZPldiUNIdGDyoZzBpwBn7GIuSE.kfCtvvyRHA3X5QSUn_eDNNvEKf3wDlS.jYuKNd
 c57Fhx2QYYKmxZaFJBLaVdoEaniOdBCpxkGFizIhVBDa68PkZStpeafWosjEal1Se7Nn2Wh9dnXQ
 oD9mgd7pA_TeActVb33RD7vBkIiM2Mw.74QwEieaae8D7aBImnD7JHzVWYp2NxRoImeHM4QhfO6D
 5U8WOkb8EsObdYPK7CzyDs8l8VKHcYYPVe0_9JeozZyd2norE.Jz9ZBOXoKWdUHZx69EBP4B8lNV
 LtCQDfMTvV9TUPqpAW9mvAlLJJZlRBbIuWVHZuumcaw3BEUU1Sira4YdDZS3TlCuFj.TqB.hc6qi
 sDPAOVSzcLCCKlECc9rFGM_ow8Gi3NTIhxSsLjRaGJW9hLmlID0GbDlq_JHRP2Zxtxn9b4okIL76
 ZO_aJefO7t_CKXcDCpow6.O6ErUw8aAxUFBl8YFcnBPMNKrjJv_gekSrrzyilGY_FNhVw7taFCWV
 Z4nNINAXwUMKLYgN6JAipocVAAzEmYF02YG5n_PD9UuQCew6bHYhfUoz7OAHcDPSl6neeRMrzHZJ
 AFC08NfD6pqO0FrVq7JMsLNQKD7e8BfUEXxBV9b6k_Rs.QadYr6Ei4aQLQ4yLUTc2QiHn4_LlqCI
 8nTKNo1qMrcbIAr.h4bWOkYgdXmbi_6DwB3Z_S2fWmOSapfLB4UsNlCCr_0SGb1xbu3lH99NwnkJ
 08mI_V5brNut6uDVL7JYmLuwDDw2Rf_Bwsxpsgq9un3qZhCf19Owqt_hJ_Hm_zlaeXFHUkAIBlw9
 esYh9gdGjL0NPn05agtIcsxDBRmbpep_wlcUhd68_Ak1d3Dd_vFfk6c1D8JVBCsgARbj1QRrnjah
 JN30PADzEZ9sj.L27Nn2adbpu41R98._bKI67TeE4ddmZ4_MCnx7uccwvT1OYVR_O8pRq3pFwDM7
 8IeRlAqLYiWS71GVDG4ebFzaqWpR2WqNad6YzDhzpwJD_LB1QGwLRi_mhr4xizYslAVrwQZYuvgd
 3ZtKX5huwgZtQIlyn2x2aB2NRWzzeRL6EkLpIOQdtVuNDMqpQQk0P4scknfdLIEJqn55L2BKmBro
 7GFCKh_1YvlExNBg4Z6uI9LFtSsgJLOcyPtjuzC_4GPPTVY36ro8CpSDROEnqyu5HYnNF2Aoa_Qp
 bc4D7S0O_EIWeG1Az4fJG1RONDPCB0J7DeG1Ufx8HETQd5v1j.XO3XPiykqH4S9DF0Nn6RR_J.XJ
 DFp99COkOFr1Vnm2MmFaxWDNxHjJ7E5LfiDhg6RXdbQmoOz.aJg5w2m_nmu8erf5jVYHt6BfgW6y
 qYn_dMGAW8zU9XNEdRrlHHFxpjYNO42Skp5JFJIm5C34an6auOEMleYErYvqUSV05yisXeem.i6h
 EQHINPhg5jeFEkLpXK3ZQHavcazvf4O0Z0ObwcTd8qcGUZp0jVafdXcaaw8dJEPDYgGNZF9x.vU8
 Cd3Jihk5g7CT5wBH6W9L.MlZJ51g.H9RBxaEw_kExi4WHoNbXUTUSfkB_t9nSY_8BBZkOu7_tF9r
 ZyK51BUwStnvMQSD8JiG46kVH__B8Ih0QD16KU5XiLhWYG_RyIGaMTMRgLapWlVN.kxZkPOS5Lgm
 ehBqEAI5cwmUeBqEN7Fvd4zU3zKdVTVp2wWRmuUYcn9oD9LUtUciFezM.uKnqW5g2eyM8mA--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic306.consmr.mail.gq1.yahoo.com with HTTP; Sat, 14 Nov 2020 18:26:24 +0000
Received: by smtp417.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 85968d25ae8d25f4ff6dfa3538a98c18; 
 Sat, 14 Nov 2020 18:26:20 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v4 08/12] erofs-utils: fuse: kill read.c
Date: Sun, 15 Nov 2020 02:25:13 +0800
Message-Id: <20201114182517.9738-9-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201114182517.9738-1-hsiangkao@aol.com>
References: <20201114182517.9738-1-hsiangkao@aol.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 fuse/Makefile.am         |  2 +-
 fuse/main.c              | 34 +++++++++++++++++++++--
 fuse/read.c              | 59 ----------------------------------------
 fuse/read.h              | 17 ------------
 include/erofs/internal.h |  6 ++--
 lib/data.c               | 24 +++++++++++++---
 lib/namei.c              |  2 +-
 7 files changed, 55 insertions(+), 89 deletions(-)
 delete mode 100644 fuse/read.c
 delete mode 100644 fuse/read.h

diff --git a/fuse/Makefile.am b/fuse/Makefile.am
index f37069ff7f12..21a1ee975141 100644
--- a/fuse/Makefile.am
+++ b/fuse/Makefile.am
@@ -3,7 +3,7 @@
 
 AUTOMAKE_OPTIONS = foreign
 bin_PROGRAMS     = erofsfuse
-erofsfuse_SOURCES = main.c read.c readir.c
+erofsfuse_SOURCES = main.c readir.c
 erofsfuse_CFLAGS = -Wall -Werror \
                    -I$(top_srcdir)/include \
                    $(shell pkg-config fuse --cflags) \
diff --git a/fuse/main.c b/fuse/main.c
index fee90154a251..9ac8149c88d9 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -12,7 +12,6 @@
 #include <stddef.h>
 
 #include "erofs/print.h"
-#include "read.h"
 #include "readir.h"
 #include "erofs/io.h"
 
@@ -151,12 +150,41 @@ int erofs_getattr(const char *path, struct stat *stbuf)
 	return 0;
 }
 
+static int erofsfuse_read(const char *path, char *buffer,
+			  size_t size, off_t offset,
+			  struct fuse_file_info *fi)
+{
+	int ret;
+	struct erofs_inode vi;
+
+	UNUSED(fi);
+	erofs_info("path:%s size=%zd offset=%llu", path, size, (long long)offset);
+
+	ret = erofs_ilookup(path, &vi);
+	if (ret)
+		return ret;
+
+	ret = erofs_pread(&vi, buffer, size, offset);
+	if (ret)
+		return ret;
+	return size;
+}
+
+static int erofsfuse_readlink(const char *path, char *buffer, size_t size)
+{
+	int ret = erofsfuse_read(path, buffer, size, 0, NULL);
+
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
 static struct fuse_operations erofs_ops = {
-	.readlink = erofs_readlink,
+	.readlink = erofsfuse_readlink,
 	.getattr = erofs_getattr,
 	.readdir = erofs_readdir,
 	.open = erofs_open,
-	.read = erofs_read,
+	.read = erofsfuse_read,
 	.init = erofs_init,
 };
 
diff --git a/fuse/read.c b/fuse/read.c
deleted file mode 100644
index 2ef979ddba63..000000000000
--- a/fuse/read.c
+++ /dev/null
@@ -1,59 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * erofs-utils/fuse/read.c
- *
- * Created by Li Guifu <blucerlee@gmail.com>
- * Compression support by Huang Jianan <huangjianan@oppo.com>
- */
-#include "read.h"
-#include <errno.h>
-#include <linux/fs.h>
-#include <sys/stat.h>
-#include <string.h>
-
-#include "erofs/defs.h"
-#include "erofs/internal.h"
-#include "erofs/print.h"
-#include "erofs/io.h"
-#include "erofs/decompress.h"
-
-int erofs_read(const char *path, char *buffer, size_t size, off_t offset,
-	       struct fuse_file_info *fi)
-{
-	int ret;
-	struct erofs_inode vi;
-
-	UNUSED(fi);
-	erofs_info("path:%s size=%zd offset=%llu", path, size, (long long)offset);
-
-	ret = erofs_ilookup(path, &vi);
-	if (ret)
-		return ret;
-
-	erofs_info("path:%s nid=%llu mode=%u", path, vi.nid | 0ULL, vi.datalayout);
-	switch (vi.datalayout) {
-	case EROFS_INODE_FLAT_PLAIN:
-	case EROFS_INODE_FLAT_INLINE:
-		ret = erofs_read_raw_data(&vi, buffer, offset, size);
-		break;
-	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
-	case EROFS_INODE_FLAT_COMPRESSION:
-		ret = z_erofs_read_data(&vi, buffer, offset, size);
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	return ret ? ret : size;
-}
-
-int erofs_readlink(const char *path, char *buffer, size_t size)
-{
-	int ret = erofs_read(path, buffer, size, 0, NULL);
-
-	if (ret < 0)
-		return ret;
-	return 0;
-}
-
diff --git a/fuse/read.h b/fuse/read.h
deleted file mode 100644
index e901c607dc91..000000000000
--- a/fuse/read.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * erofs-utils/fuse/read.h
- *
- * Created by Li Guifu <blucerlee@gmail.com>
- */
-#ifndef __EROFS_READ_H
-#define __EROFS_READ_H
-
-#include <fuse.h>
-#include <fuse_opt.h>
-
-int erofs_read(const char *path, char *buffer, size_t size, off_t offset,
-	    struct fuse_file_info *fi);
-int erofs_readlink(const char *path, char *buffer, size_t size);
-
-#endif
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 7357ed75e3f8..13420a8e7733 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -245,10 +245,8 @@ int erofs_read_superblock(void);
 int erofs_ilookup(const char *path, struct erofs_inode *vi);
 
 /* data.c */
-int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
-			erofs_off_t offset, erofs_off_t size);
-int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
-		      erofs_off_t size, erofs_off_t offset);
+int erofs_pread(struct erofs_inode *inode, char *buf,
+		erofs_off_t count, erofs_off_t offset);
 /* zmap.c */
 int z_erofs_fill_inode(struct erofs_inode *vi);
 int z_erofs_map_blocks_iter(struct erofs_inode *vi,
diff --git a/lib/data.c b/lib/data.c
index 62fd057185ee..34811e49512f 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -70,8 +70,8 @@ err_out:
 	return err;
 }
 
-int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
-			erofs_off_t offset, erofs_off_t size)
+static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
+			       erofs_off_t size, erofs_off_t offset)
 {
 	struct erofs_map_blocks map = {
 		.index = UINT_MAX,
@@ -117,8 +117,8 @@ int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 	return 0;
 }
 
-int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
-		      erofs_off_t offset, erofs_off_t size)
+static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
+			     erofs_off_t size, erofs_off_t offset)
 {
 	int ret;
 	erofs_off_t end, length, skip;
@@ -188,3 +188,19 @@ int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 	return 0;
 }
 
+int erofs_pread(struct erofs_inode *inode, char *buf,
+		erofs_off_t count, erofs_off_t offset)
+{
+	switch (inode->datalayout) {
+	case EROFS_INODE_FLAT_PLAIN:
+	case EROFS_INODE_FLAT_INLINE:
+		return erofs_read_raw_data(inode, buf, count, offset);
+	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
+	case EROFS_INODE_FLAT_COMPRESSION:
+		return z_erofs_read_data(inode, buf, count, offset);
+	default:
+		break;
+	}
+	return -EINVAL;
+}
+
diff --git a/lib/namei.c b/lib/namei.c
index 2e024d88d93e..4e6aceb90df1 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -136,7 +136,7 @@ int erofs_namei(struct nameidata *nd,
 		struct erofs_dirent *de = (void *)buf;
 		unsigned int nameoff;
 
-		ret = erofs_read_raw_data(&vi, buf, offset, maxsize);
+		ret = erofs_pread(&vi, buf, maxsize, offset);
 		if (ret)
 			return ret;
 
-- 
2.24.0

