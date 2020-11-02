Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9542A2ECA
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Nov 2020 16:57:25 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CPyGq1vwGzDqT4
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Nov 2020 02:57:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1604332643;
	bh=hSmesUpwMhz+/5a2ta5OsPot/4EVcBb02MVNYHsisTs=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=aqAOMeU4YYEkla5Ppxs7QwuWYBTmwHduMWbolvKQQrB0y0hx2fmsC7GbWZp6UHNfL
	 oEPLIPh56Ckjzlqp30q6IZW9hco1VoEBKk02CxQv1bf64qWihEdLl768RFtByKgjDc
	 Ra/cDvEIT7hUEO5Kv11kTgmzZVy7X3fsfUOGbOtTydCEfHBcv1TGn0heXNj8nMb2Oj
	 tDFhdCznhoZr1zz6VGpg3WTmVGL1YBZKsmB5gAMwGfMeHgGaKNSWDq3CQIUHYIRZV9
	 g2Cj4MO7cxMMUezp22BgJyyOyVMjdfu1ErqhCOkXjVDlo7p7yX4pL9GyGDIpR0Pvsw
	 PCts2DZlVloeg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.69.30; helo=sonic316-54.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=Y5+iUmbo; dkim-atps=neutral
Received: from sonic316-54.consmr.mail.gq1.yahoo.com
 (sonic316-54.consmr.mail.gq1.yahoo.com [98.137.69.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CPyGD3nPLzDqS5
 for <linux-erofs@lists.ozlabs.org>; Tue,  3 Nov 2020 02:56:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1604332608; bh=i9FK/htK8oiMi9mlARIyFEIAcNpBsbStDGAwQW4ScOI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=Y5+iUmbojGBjAOmTpe0OM1XmWt7kWwPOXSbpumR4wnHoVgZoINqdJOYf6QV0ObimBSurQOpOLVQRYGF6pGv4EzJ8ysR8wtOfgqteohcXbAveznGvMtIyMKzNqcJvCFt2SBHZqaEe9UBvL4zFuHLEb7y6V/5qouT/QEiqiXOfD8FHaqprD/fsQ5MWfXN1UvktHUK75kPIDz0L8b0sXMYCSpfCCYO/v1xOkhUz0S0UOIQs65jvPXjSrlEiSu8MqixAAGyDoBYHR6H2HeifKDV897/obttB/AgEH4OVvDi3ALwKSzQjs8sOsP8/iOS0TCfpj4xTAdrfin621c9zwnc7RA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1604332608; bh=jPu/Qbyd3z/nbwcHD7eEH/rhLjzsPzpEBMV1LUzNenF=;
 h=From:To:Subject:Date;
 b=G+KoYGSIN2LvRE8vvKXnmYCORkG7/Zpqcc2XF47KqyWWavtSTtI4L9saiv20eXVZCo/Nb30Sn0xdcOkBrYv9LBqunHDEcmQhiOqgzOSCYh/NhsdEvFTD5YrKoLGWZnH9+a5X0gPysstQY/wC4sv3qBWKJG+i5xsef400620lK4USj3SV9oOZJd1PxiwKS027QvfJlvTw+WyDazOm3H5/2v/KGBLkZ1cx/MjEL1knpnSzIhJQ956N3GKzZVi33eu4au88Ytc/bTzAyqEd2N2Ck8J4oMejUp5Dh8OpgkSq6RLDkHWDPIdbtrnHmmPMrg6e1oLV32RJHJjNsQ0ZkjjzkQ==
X-YMail-OSG: UkE7HkYVM1lrHuDOygD.76K4DXd4ZN8aZVkSYz6Cb9X4lBNPt7JNWWC1lRTrxKZ
 UB9G2KEwAu55PDa_I4w8fU37MzeeI_e5PuEkYLojlkJ3vvyHWuojY5786q9NKD9AP8hOFyD5qiuG
 qIb85LatSkrvaBQ1mpWkfPPWRVipO3vTpfPUOif6HlyKiyo6Ww9xC18m452ujlnTSt7g3eAab2DE
 hHc1Oof5as3fDm4sCIEHc901r1y6ZMy2E5Q.4BhxDaFs0gRICguCHGxLxMojhMNgdtefewnKjm6E
 u1ltGZKu9mWSeJqA_p6JK2mlql8gwmOmwi14Vco2CTT4aqxxuK99uNHTPFzBFp6j0UwZ6yvbMhtg
 Gihna18yfxeZHgGiE85Ap5ATYd2G5JmaxtiQ.KhLzCMAwMz8GQtkP5uNg2ENJ.yLk97uxTffgDcw
 WK5Q9gH_PKQA7rPPFB.1U2e_5_flyfXOCXoyoMUlhh7I2pqcKYyfdS0bqt9gOAKwV0dcKZL_ITd1
 QcWEHPUHG0wgCHmtCTYynITME9XcIAMk.oUNv6Sb6LjJ5BYXgO0nS4zyZC3dmJahB2ix0bLTRirP
 cpDQrEa0ukP3oBn00bW6HPH15e9Iwphbo1O_oXlp52yo2.vAtCVaxbokbtxE8U2cv7bF7e18uGyi
 p3ilGotRnd97Vj3h6IRuMtNdkrdn8EVO4usLli7dr2XM6_o9Gdbo4egq2jvmSNYLzvNNoEiLRnGt
 hwDVryNUpH_jgoh3Tmz3gnYqkCTEATzcX.rYvB5MjrzRBOgurpmUX76_NEmSXsPDyyMbLLZToBTn
 G2KUe12VlM9RQImsWLGanE76WuQ_geZdb1x.g_pBtpj3sKFUiok1CVSqXtIAie8Gyhxtf2xBnLYD
 PYr.dFhLAVbgdloHhfCwJCox0iBLbs6Yk03h03KxesXx4qTRudIg8dQVOM4qneUbuba4.R_lCh.X
 7A.XHrAoKpZn9TxsCkEQS.uCqB9iMNNRSTsBo6FEiiShfcn.2Zr.lLJlU4Txi__kCX8s_ZMozzLv
 1XEK7USUD_7.dfeITPTpw78NwfZUYpRIo2gWymscIZF6_YJD8pJo6__IqHdibFODlGHLFH9prg7H
 b0eoSEFJduW6SwJ_6JAn4RIX5NO3LhPnuCAcc.IKKZKRg5vqX.eO0CfhY0anRTAec8T7IQIt9w4S
 86cA2hAaEL6s4FCK7UqzmGFD9FkEmufurKoOz.OlaAvpGHvO1jdALNqrpSiti.9h.CuLoGwkw1fO
 PbI3rhMTmDtX52YvLyXNS1NSrJ119seGIZP8gieOINdI3RGJSNnRg6n9G8gRSj5Gccm7KuED7pwO
 WzSWXo05mjQa6q12tDJtf6N9l7SFX6IBzSeeN0xP9Qn4PX9gX9u0JRIBq_l8sVLuab40F38Keiul
 nHMO5pokeynWZkKXpk76eTAn56yAm59mshhgNLmFleMHD2xvfkl7BOEZ23g64AAX.syGZQHe9GVJ
 f8LStbTlGawxX3FtH9NBZqXCimZk0i6Rx5dhwKgqi8vJnWnCLJKTwSoRmD7DBNwHyZw.UU_2S5i0
 gtSYlLCBmbxttHqTEMuBt8SABpiMQ_rTFendTfQCCTPH1BQEZi9Q4d9th2A82oz65eG9_aBjfYWr
 gMkdvB_Ss4fXEJicQ.x_Q13u4k12qlUMP4HMEiSijO7.idvP32woczSPmBx1luu2o5rqseO98fyB
 GsZQVqKmPv7pdN4mHeQh3.IyIVoFqgtSVjcGrVA_dlk1Fuf5LuLaCVUaWoG_m12TrUskqirgLel0
 xu4inK.10rmUdIW44KABH4DYjeNrrRI7y68s7Bs291eXiy3hudiiL5m3Ow87kvIH4e_JW4.X4PgS
 Nzz6hiKm75F55Lraa9M_EDoATFSuaQ8GgDGyCO._623K55fBnV7FEkncA_C9j4GBeYS6Y6GR805g
 23Z2rqswqHaX4fAnLPij7LmVNgDgh4hSpAir7YiFT9_DpZCIvX5lWg14lLSjo5p.L6E97l44agw2
 AjLcLHjX73Wlq10NHV6aoW7kPt0DBh55kxkUDkYHjkwgogkM8bmd_FUmC5earKFpjO0CIHPV3aA_
 _KyM_E.vklR1se93r4euuZxT.QkOBk8fhgcdSdwnPJuy53zOfKM3.Y1qQU9gm1dwyPRM1JWHWdgk
 A8in7iP26dKrCGvhFgDq7KjmGQ.GkuCEGVQXLXvp3HbD.9BwGTVB8g2cs85JGW37d7rVBcTGeiPX
 wXJESn_Q5yr2MNrUMwe3_URiqGtIY8K4.gEx3WGE1CE0PaS3MTB9.0ZRMeCLzP3EdEjDN2UTUJ80
 JFAswlJCOGUre5_0lVuyiasccnvhaqv4QvLwlB0p3hAAeWWYRAVE5xP._nIQB4fwdYNaWeUBaN43
 Y_AjRPcWnjlsCYT11A3dMxwfL3w02m1WgtGkCmvT8TQpfwrM7vpF70YC7ONtVTuu1pOV1jq66Q8w
 wsSfv.QTZ6dv8KH4ViKQ92PHiXi8xPaCWGe_ucHFNIxVna49Zut4zdyIxiKOKDllxF8mIOCz90Om
 TsGJPSGdNrWBMfuCRd5njFRT67bGKtXOVhIxsXancU7qR_Vtj6wHdHI_gvE0y98hp0HBAMQL77f8
 .tOJwFn9Kv1E0GLJLWBBJ9fSxtcTFFwuWg89g5SJoCXHm9pyeiurCuHZgFdgy7_szCtd8W3GtWX4
 ebqpkNkyVACcT6v4-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic316.consmr.mail.gq1.yahoo.com with HTTP; Mon, 2 Nov 2020 15:56:48 +0000
Received: by smtp404.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 0de93bd81f6e7581799539af1246db07; 
 Mon, 02 Nov 2020 15:56:45 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v3 04/12] erofs-utils: fuse: refactor raw data logic
Date: Mon,  2 Nov 2020 23:55:50 +0800
Message-Id: <20201102155558.1995-5-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201102155558.1995-1-hsiangkao@aol.com>
References: <20201102155558.1995-1-hsiangkao@aol.com>
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

As a common logic and move into lib/
( will fold in to the original patch. )

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 fuse/init.c              |   2 +
 fuse/read.c              |  76 ++++++-------------------
 include/erofs/internal.h |  19 ++++++-
 lib/Makefile.am          |   2 +-
 lib/data.c               | 117 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 155 insertions(+), 61 deletions(-)
 create mode 100644 lib/data.c

diff --git a/fuse/init.c b/fuse/init.c
index c6a3af697532..09e7b1210006 100644
--- a/fuse/init.c
+++ b/fuse/init.c
@@ -71,7 +71,9 @@ int erofs_init_super(void)
 	sbk->build_time_nsec = le32_to_cpu(sb->build_time_nsec);
 	sbk->blocks = le32_to_cpu(sb->blocks);
 	sbk->meta_blkaddr = le32_to_cpu(sb->meta_blkaddr);
+	sbi.meta_blkaddr = sbk->meta_blkaddr;
 	sbk->xattr_blkaddr = le32_to_cpu(sb->xattr_blkaddr);
+	sbi.islotbits = EROFS_ISLOTBITS;
 	memcpy(sbk->uuid, sb->uuid, 16);
 	memcpy(sbk->volume_name, sb->volume_name, 16);
 	sbk->root_nid = le16_to_cpu(sb->root_nid);
diff --git a/fuse/read.c b/fuse/read.c
index 11f7e6161f8f..dc88b24eaae3 100644
--- a/fuse/read.c
+++ b/fuse/read.c
@@ -19,64 +19,26 @@
 #include "init.h"
 #include "erofs/decompress.h"
 
-size_t erofs_read_data(struct erofs_vnode *vnode, char *buffer,
-		       size_t size, off_t offset)
+size_t erofs_read_data_wrapper(struct erofs_vnode *vnode, char *buffer,
+			       size_t size, off_t offset)
 {
-	int ret;
-	size_t sum, rdsz = 0;
-	uint32_t addr = blknr_to_addr(vnode->raw_blkaddr) + offset;
-
-	sum = (offset + size) > vnode->i_size ?
-		(size_t)(vnode->i_size - offset) : size;
-	while (rdsz < sum) {
-		size_t count = min(EROFS_BLKSIZ, (uint32_t)(sum - rdsz));
-
-		ret = dev_read(buffer + rdsz, addr + rdsz, count);
-		if (ret < 0)
-			return -EIO;
-		rdsz += count;
-	}
-
-	erofs_info("nid:%llu size=%zd offset=%llu realsize=%zd done",
-	     (unsigned long long)vnode->nid, size, (long long)offset, rdsz);
-	return rdsz;
-
-}
-
-size_t erofs_read_data_inline(struct erofs_vnode *vnode, char *buffer,
-			      size_t size, off_t offset)
-{
-	int ret;
-	size_t sum, suminline, rdsz = 0;
-	uint32_t addr = blknr_to_addr(vnode->raw_blkaddr) + offset;
-	uint32_t szblk = vnode->i_size - erofs_blkoff(vnode->i_size);
-
-	sum = (offset + size) > szblk ? (size_t)(szblk - offset) : size;
-	suminline = size - sum;
-
-	while (rdsz < sum) {
-		size_t count = min(EROFS_BLKSIZ, (uint32_t)(sum - rdsz));
-
-		ret = dev_read(buffer + rdsz, addr + rdsz, count);
-		if (ret < 0)
-			return -EIO;
-		rdsz += count;
-	}
-
-	if (!suminline)
-		goto finished;
-
-	addr = nid2addr(vnode->nid) + vnode->inode_isize + vnode->xattr_isize;
-	ret = dev_read(buffer + rdsz, addr, suminline);
-	if (ret < 0)
-		return -EIO;
-	rdsz += suminline;
+	struct erofs_inode tmp = {
+		.u = {
+			.i_blkaddr = vnode->raw_blkaddr,
+		},
+		.nid = vnode->nid,
+		.i_size = vnode->i_size,
+		.datalayout = vnode->datalayout,
+		.inode_isize = vnode->inode_isize,
+		.xattr_isize = vnode->xattr_isize,
+	};
 
-finished:
-	erofs_info("nid:%llu size=%zd suminline=%u offset=%llu realsize=%zd done",
-	     (unsigned long long)vnode->nid, size, (unsigned)suminline, (long long)offset, rdsz);
-	return rdsz;
+	int ret = erofs_read_raw_data(&tmp, buffer, offset, size);
+	if (ret)
+		return ret;
 
+	erofs_info("nid:%llu size=%zd done", (unsigned long long)vnode->nid, size);
+	return size;
 }
 
 size_t erofs_read_data_compression(struct erofs_vnode *vnode, char *buffer,
@@ -172,10 +134,8 @@ int erofs_read(const char *path, char *buffer, size_t size, off_t offset,
 	erofs_info("path:%s nid=%llu mode=%u", path, (unsigned long long)nid, v.datalayout);
 	switch (v.datalayout) {
 	case EROFS_INODE_FLAT_PLAIN:
-		return erofs_read_data(&v, buffer, size, offset);
-
 	case EROFS_INODE_FLAT_INLINE:
-		return erofs_read_data_inline(&v, buffer, size, offset);
+		return erofs_read_data_wrapper(&v, buffer, size, offset);
 
 	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
 	case EROFS_INODE_FLAT_COMPRESSION:
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 6c5fbd3c5d3c..54038071bf84 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -70,12 +70,20 @@ struct erofs_sb_info {
 	u32 feature_incompat;
 	u64 build_time;
 	u32 build_time_nsec;
+
+	unsigned char islotbits;
+
 	u8 uuid[16];
 };
 
 /* global sbi */
 extern struct erofs_sb_info sbi;
 
+static inline erofs_off_t iloc(erofs_nid_t nid)
+{
+	return blknr_to_addr(sbi.meta_blkaddr) + (nid << sbi.islotbits);
+}
+
 #define EROFS_FEATURE_FUNCS(name, compat, feature) \
 static inline bool erofs_sb_has_##name(void) \
 { \
@@ -219,13 +227,16 @@ static inline const char *erofs_strerror(int err)
 }
 
 enum {
-	BH_Mapped ,
-	BH_Zipped ,
+	BH_Meta,
+	BH_Mapped,
+	BH_Zipped,
 	BH_FullMapped,
 };
 
 /* Has a disk mapping */
 #define EROFS_MAP_MAPPED	(1 << BH_Mapped)
+/* Located in metadata (could be copied from bd_inode) */
+#define EROFS_MAP_META		(1 << BH_Meta)
 /* The extent has been compressed */
 #define EROFS_MAP_ZIPPED	(1 << BH_Zipped)
 /* The length of extent is full */
@@ -241,6 +252,10 @@ struct erofs_map_blocks {
 	erofs_blk_t index;
 };
 
+/* data.h */
+int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
+			erofs_off_t offset, erofs_off_t size);
+
 /* zmap.c */
 int z_erofs_fill_inode(struct erofs_vnode *vi);
 int z_erofs_map_blocks_iter(struct erofs_vnode *vi,
diff --git a/lib/Makefile.am b/lib/Makefile.am
index c921a62a8b23..54c43897aa49 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -3,7 +3,7 @@
 
 noinst_LTLIBRARIES = liberofs.la
 liberofs_la_SOURCES = config.c io.c cache.c inode.c xattr.c exclude.c \
-		      compress.c compressor.c decompress.c
+		      data.c compress.c compressor.c decompress.c
 liberofs_la_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
 if ENABLE_LZ4
 liberofs_la_CFLAGS += ${LZ4_CFLAGS}
diff --git a/lib/data.c b/lib/data.c
new file mode 100644
index 000000000000..56b208513980
--- /dev/null
+++ b/lib/data.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/lib/data.c
+ *
+ * Copyright (C) 2020 Gao Xiang <hsiangkao@aol.com>
+ */
+#include "erofs/print.h"
+#include "erofs/internal.h"
+#include "erofs/io.h"
+#include "erofs/trace.h"
+
+static int erofs_map_blocks_flatmode(struct erofs_inode *inode,
+				     struct erofs_map_blocks *map,
+				     int flags)
+{
+	int err = 0;
+	erofs_blk_t nblocks, lastblk;
+	u64 offset = map->m_la;
+	struct erofs_inode *vi = inode;
+	bool tailendpacking = (vi->datalayout == EROFS_INODE_FLAT_INLINE);
+
+	trace_erofs_map_blocks_flatmode_enter(inode, map, flags);
+
+	nblocks = DIV_ROUND_UP(inode->i_size, PAGE_SIZE);
+	lastblk = nblocks - tailendpacking;
+
+	if (offset >= inode->i_size) {
+		/* leave out-of-bound access unmapped */
+		map->m_flags = 0;
+		goto out;
+	}
+
+	/* there is no hole in flatmode */
+	map->m_flags = EROFS_MAP_MAPPED;
+
+	if (offset < blknr_to_addr(lastblk)) {
+		map->m_pa = blknr_to_addr(vi->u.i_blkaddr) + map->m_la;
+		map->m_plen = blknr_to_addr(lastblk) - offset;
+	} else if (tailendpacking) {
+		/* 2 - inode inline B: inode, [xattrs], inline last blk... */
+		map->m_pa = iloc(vi->nid) + vi->inode_isize +
+			vi->xattr_isize + erofs_blkoff(map->m_la);
+		map->m_plen = inode->i_size - offset;
+
+		/* inline data should be located in one meta block */
+		if (erofs_blkoff(map->m_pa) + map->m_plen > PAGE_SIZE) {
+			erofs_err("inline data cross block boundary @ nid %" PRIu64,
+				  vi->nid);
+			DBG_BUGON(1);
+			err = -EFSCORRUPTED;
+			goto err_out;
+		}
+
+		map->m_flags |= EROFS_MAP_META;
+	} else {
+		erofs_err("internal error @ nid: %" PRIu64 " (size %llu), m_la 0x%" PRIx64,
+			  vi->nid, (unsigned long long)inode->i_size, map->m_la);
+		DBG_BUGON(1);
+		err = -EIO;
+		goto err_out;
+	}
+
+out:
+	map->m_llen = map->m_plen;
+
+err_out:
+	trace_erofs_map_blocks_flatmode_exit(inode, map, flags, 0);
+	return err;
+}
+
+int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
+			erofs_off_t offset, erofs_off_t size)
+{
+	struct erofs_map_blocks map = {
+		.index = UINT_MAX,
+	};
+	int ret;
+	erofs_off_t ptr = offset;
+
+	while (ptr < offset + size) {
+		erofs_off_t eend;
+
+		map.m_la = ptr;
+		ret = erofs_map_blocks_flatmode(inode, &map, 0);
+		if (ret)
+			return ret;
+
+		DBG_BUGON(map.m_plen != map.m_llen);
+
+		if (!(map.m_flags & EROFS_MAP_MAPPED)) {
+			if (!map.m_llen) {
+				ptr = offset + size;
+				continue;
+			}
+			ptr = map.m_la + map.m_llen;
+			continue;
+		}
+
+		/* trim extent */
+		eend = min(offset + size, map.m_la + map.m_llen);
+		DBG_BUGON(ptr < map.m_la);
+
+		if (ptr > map.m_la) {
+			map.m_pa += ptr - map.m_la;
+			map.m_la = ptr;
+		}
+
+		ret = dev_read(buffer + ptr - offset,
+			       map.m_pa, eend - map.m_la);
+		if (ret < 0)
+			return -EIO;
+
+		ptr = eend;
+	}
+	return 0;
+}
+
-- 
2.24.0

