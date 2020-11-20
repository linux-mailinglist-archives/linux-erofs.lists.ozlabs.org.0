Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F2E2BB1A4
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Nov 2020 18:45:12 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cd3ps4M4xzDr2p
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Nov 2020 04:45:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1605894309;
	bh=22rtN3dvm9A9BbxVcY09jVm6qMsxKHFoRobJyMY9EEY=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Mr/qogebv0LhKO51K7IMa1x21+sX5uhFw04/iIhxXHAG9q+Z86ZnRjPjdt7wtptXw
	 3ieshOTXgXWckFNk+nmD2Xsuz97vlVAF3FTwtG4ssk/QTwytdgHJi1QuN0Iv1l8mEC
	 PMa05xbczp0EITgAl5/u59UCs69siIQ0z/aVdUo/fUfDtjSJ0XTQw32N3b1iSXcd6t
	 V2239Po2XEoAYHk5ajVpQsvTkponMdjTb8Tsh5dY9Mh1KAk03nr6/T4X33XxTfv2K0
	 pqCkhDiYs9zU8+Vf0FUEwIFrCNHUeGOS2nUFtiqphShS4k2yVTWbOgYFfthbGEjc5m
	 UXQjA8KPpYb9w==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.64.205; helo=sonic303-24.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=jcslzYOH; dkim-atps=neutral
Received: from sonic303-24.consmr.mail.gq1.yahoo.com
 (sonic303-24.consmr.mail.gq1.yahoo.com [98.137.64.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cd3lz2KxjzDqbm
 for <linux-erofs@lists.ozlabs.org>; Sat, 21 Nov 2020 04:42:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1605894153; bh=4AcH8P0AnzIa07sY4dCiLAfjD5g9U9FSNwtEfhzoXSg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=jcslzYOHV+qS657lj9aK9/VpXrG/8WkmC3isaB6ENbFHJn/kwOugM38VyPFpMK64TU/7AEr0vDnST5tnFNtPpPCtOkewCtHf4L4LSpXTEOuK64mhQF9FDtWcxLlik8bFhZsFslDTVJNhZfl5LFrqJ7O6TNRxk3BC+Xf64C+c1BQ8eJgI9ai73wsjk58RZECFmp0GMcLmjdxysFL2cVdTUFh/HIRsRjvXr82Dt1AFQyEO4iTvAtFm9Fr4y3nNx05m9RU7wX9jLpp9lnmvt809np+/WlGhXR5P1sWRNOGjZL0d/XomfHFcw6cY9r8u059lkQ2VneEb+7ZW5jv7ufjgjQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1605894153; bh=J96jzqK2e9yggNH2srjZHa0PQMZE9K3ei/vSC70f2YG=;
 h=From:To:Subject:Date:From:Subject;
 b=MJexqSep9IOkhfOq/kfRXpHiNXO5EMYDfJZOIZkI40SzC2IJrzar1QOT4Ni7tX+OQdqW2iubt2xq83Sodb+C9U/oMJlSbKyG7DnusBxpbBfqhSsRjpXOd3PuIE6MQEerIjzaylS9Ihq4YoLOSp/bTf6Ak15Ps2cCaff9cKzpquNZyq3rMxb1b9aJlyh2oxn52Xm8mLHX8UxI3IITY7Nu0i2AADphrjMXDkXpfyCMl7m0D5AjU9gQg89BP4B8PnVmVXbqtPjjqbLA/nvpZXB6SDR9dJMIfnbjBswsrVHUsC7CkQkpzN/2qigWAict0WgLQGz9SpEL0avCPtcfYPK3Kw==
X-YMail-OSG: wZCdfFsVM1lCfg8tu5xD0FpVGHHGU0nBAWjnFy6v8hLXDv2TAqRFfy5s3ktd_mS
 6o6nPEOR_15yoejpA7I2p.c.EvtjyKR1UQdDyK8mM.ysaC91_170f.grVt_35SWeBb5LhMLLZVz6
 kVaQ7C4VuNX9.FAimNvsuagiM2dCiTGxKB5UyJwlME_KFeGq4Fa.eAcnWIUIGAA1zYZaizI8fU8I
 taRXIHOZ2tOUfl4brxkLLsUJ0XRCQJzHZVEfNq_BBzqPF49LZHO6htnpo5g5llV7Z0br9W5EQjZv
 E.6g8_15cy8gbXLnRKZrlv_9wZhve.yauHVZwssm9DRycsbDRy0LJ1swutwMxUne6Brat2cflIDX
 Jhp.SQYUwoc0zlngo18y6dN13w4.WDn4rAFCrlDW.tCYlpwAeO.qlI4rLoyNiwKmUDsBL0s80pGs
 NswATMx8j8vleM5_GBAdkJY5MxIlWKfDFKBMXjx1g7ZERPDCHdL2Q4sHcuNOfOZtHGXNw9rYTY8P
 425Dn_T92s.8BzQPIM99mNBDwarQItJGOqpr.LS0JNqSHio2gTK7NjRUa7MEQcu8LIJI.IMBUDVL
 mkp4SB_QlDOLNVl.a6kkgHcwh4aKZDpmspNQaLZdLf56eRPPbonVvtcpPX2TZyGN0umWOfycJhd5
 lpp90jiZhsRhHe.rp3fg2PsajFzQtWDsIXcpH_PW2GlyZC0CNwWySLj0JUBPdBWeXMwusZXv7d5d
 5jNGNIhMzvHdKwbFTBEiirDfq1Qy036BW.7ldZR0MFO24WgIGI44fxxsxhGnR9ENXmtQ2aeN4sKk
 .pEER2YpXzO9SdkG9xE4jK4h70H2nvU9fq3AHHXZmKglCiVCh0AXtGuEdqqbRrIr7.OOuYKTMQCz
 IBaAM3peE9bxRKq2wdTrYShYiZ0lApHY0VhyuhlYBs0QHncecxO5U4YKV3.FCBBa6F97l7Rk6Kpg
 .0uNI6Vl337cGwDniRjDxUfVT3A4U3BSfJ.IuXf.lxaIrTYkWtOD45DEtYlbxbtqkN.5d_atBc8K
 JMADh0nVpmjps3jpmjZSyMc6D.Ib.GMsexptpd4VbhilE985he9vyfpNy4UWtwcW.6k7AnNURrvE
 e0VxfEUUlZsbu6fXdOrgxGaDlHzqFcb.2Kn8pGn6pSR0J7Vi_jQxkNpQbOL_ezJLnwg4yBPM4D63
 huvwKjrQFFbK9zK_teVlJ1H9p.N_od8AC5sIeTGR_40CTyCsy.N0eVC2VYgY2ealtgFQwgxkrBex
 w4QCtq9xwH7PQhAPd3T6lcTLz5VlrgxCxus8XUdM9T9.GbFrv_20Jnqzzkzzu55Qd.dUMqDPKY0J
 LjwkYM3JDgL1KJgJ7g_4Hm5NVVh1z12UjLCA9HBI3vGc8m0mYiLjh.mJQntSHnRMz3ul.w7Xg0yp
 jDqsghSaBu7niHDQYVSmvo8VBECTntkg5ccBdcpiUyMIRdKeft31M6Y_g6_hIYVF8IZzYeYKF7dB
 Ue3MedHYbOKKXjlVSk_.woI14MN5Ekwe_LeoulHoj.hHQO7EARQTCMAD66i1qtRCLxYIouk6Jj1M
 1ttAjwjM684Y1liSIL4bjG_3rgVe2yz0ZjDNAq3pprLVfTf9kdNy1dt8W69vBtCnUrNGntcKxHm.
 dJfjndYf8QhL.uW8eRhpLbn7Nl0zNsi09md5.XZD4YeIx0ADmP7PPajuQmUYxvnc9w4ILqziO4_B
 XX8SSqxoJUpOMzwHsNlEOd.PhK6hAelTQ3fSYi0DbF6D1wAIXsYgASxp1EXcxjJ.nJxCkXwZdm5q
 avdkPEjgoAlpDcNJ.SWg2Hnbm0uyR_WQR4sDApYf59H_Si04qXTXHBOUwqkC20idAPKnwaRXs39s
 eUxDw9UnOH3TNYDOhQ5IPacXe5q5zUN3uPiozGtvGqI83GuJvJ1I_sff.6fWEnGFS2QY5zVDLZpO
 gwri8gDwPKxQEGmyKfs9E.neQxRT9.CJ_Qk9hK23f4eSJFCMGqXTa7MGHt0AI3GtdNSVzmWrUQH9
 5MHQtd1dTx8A9IipFZIvd_mQ4qnkwQiCfVKe_ml.CpAWue6ZHvNcNHrP60bFxjGxZyeysPdOGHH9
 XZmaNmE6ayPDQjYbLMxZos9HxF.N7E1yjKHAVMIBtbqiT9Z9Y6t3ghudLIrYZx6t56jVmMRJu9Yo
 J5ummBrBodmZn671Me39VXiF54AvszAoyVxmdWrJ4AOYH3O4c9NZFF4tL1T2Qom5AiVk3m.GUDSS
 tQdG5Y8so2tJEjme5Flsn.TWcRjWkuNpOIhQrue.fmAHO4cSdJzIL987pfSVaA7fOrZu8EgUZCNb
 tPbSCCNckC9SJnTpnl_y1ep90FwBJj_eDCOfiqJWStgx5iHptp6QZ6XoK8B4MiCF9Tyrdz8T7WTN
 kyHaA2n13sQXd3VFSExAggtgmpMRWaXyBLABv4PmafERjrlD7TzD0FQ9OF_e..zOwgkYgx7fU8CT
 j0uVlniDDlUmnVzFM1z5cC1r8OtscJ_RtMmmgpQ826g8fr3OJu3NlKK8hjr4O.XmY24xECCvWAC.
 6cKxlD4f9_U1Ag84nv_A01cbg2nqlqQCHwyPjG6S2iT2GS0nFL1trZ6n4yP_IsTCp2tkJe6cj9A.
 k9Nq_WZssYdhtdTPFR9oMxclIz2QQSZjuHb7aOZYQSKjUGB_uWjINonLlxDvuG.UTmz_9S6EoVRQ
 BmES.NCDcGFU88.aTj4U10V1Cl_ZxahU9NsbP9TLlsilluxKZpRih7IKzvaEBKQqv3P28vWgDeso
 pjQWFbmVDVWTZxAj9whWJ6rXpVc1zA94RFT9ZDaaLFHayiCFm1Avvz6SkcR_Jg_t2CpZS
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic303.consmr.mail.gq1.yahoo.com with HTTP; Fri, 20 Nov 2020 17:42:33 +0000
Received: by smtp423.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 2f08c2150b87ae58ff1849141a8a4a3f; 
 Fri, 20 Nov 2020 17:42:29 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 3/3] erofs-utils: fuse: add compressed file support
Date: Sat, 21 Nov 2020 01:41:46 +0800
Message-Id: <20201120174146.18662-4-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201120174146.18662-1-hsiangkao@aol.com>
References: <20201120174146.18662-1-hsiangkao@aol.com>
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
Cc: Guo Weichao <guoweichao@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Huang Jianan <huangjianan@oppo.com>

This patch adds a simple approach (~ 700 LOC) to EROFS fixed-sized
output decompression without inplace I/O or decompression inplace
so it's easy to be ported everywhere with less constraint.

However, the on-disk compressed index parser (aka. zmap) is largely
kept in line with the kernel side, therefore new on-disk features
under development can be verified effectively first here.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 include/erofs/decompress.h |  35 ++++
 include/erofs/defs.h       |   5 +
 include/erofs/internal.h   |   8 +
 lib/Makefile.am            |   2 +-
 lib/data.c                 |  74 ++++++-
 lib/decompress.c           |  87 ++++++++
 lib/namei.c                |   4 +
 lib/zmap.c                 | 415 +++++++++++++++++++++++++++++++++++++
 8 files changed, 628 insertions(+), 2 deletions(-)
 create mode 100644 include/erofs/decompress.h
 create mode 100644 lib/decompress.c
 create mode 100644 lib/zmap.c

diff --git a/include/erofs/decompress.h b/include/erofs/decompress.h
new file mode 100644
index 000000000000..beaac359b21f
--- /dev/null
+++ b/include/erofs/decompress.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * erofs-utils/include/erofs/decompress.h
+ *
+ * Copyright (C), 2008-2020, OPPO Mobile Comm Corp., Ltd.
+ * Created by Huang Jianan <huangjianan@oppo.com>
+ */
+#ifndef __EROFS_DECOMPRESS_H
+#define __EROFS_DECOMPRESS_H
+
+#include "internal.h"
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
+int z_erofs_decompress(struct z_erofs_decompress_req *rq);
+
+#endif
diff --git a/include/erofs/defs.h b/include/erofs/defs.h
index 8dee661ab9f0..b54cd9d99981 100644
--- a/include/erofs/defs.h
+++ b/include/erofs/defs.h
@@ -170,5 +170,10 @@ typedef int64_t         s64;
 #define __maybe_unused      __attribute__((__unused__))
 #endif
 
+static inline u32 get_unaligned_le32(const u8 *p)
+{
+	return p[0] | p[1] << 8 | p[2] << 16 | p[3] << 24;
+}
+
 #endif
 
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 38eaf0d094d3..8250e082cccb 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -106,9 +106,13 @@ static inline void erofs_sb_clear_##name(void) \
 EROFS_FEATURE_FUNCS(lz4_0padding, incompat, INCOMPAT_LZ4_0PADDING)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 
+#define EROFS_I_EA_INITED	(1 << 0)
+#define EROFS_I_Z_INITED	(1 << 1)
+
 struct erofs_inode {
 	struct list_head i_hash, i_subdirs, i_xattrs;
 
+	unsigned int flags;
 	unsigned int i_count;
 	struct erofs_inode *i_parent;
 
@@ -250,6 +254,10 @@ int erofs_ilookup(const char *path, struct erofs_inode *vi);
 /* data.c */
 int erofs_pread(struct erofs_inode *inode, char *buf,
 		erofs_off_t count, erofs_off_t offset);
+/* zmap.c */
+int z_erofs_fill_inode(struct erofs_inode *vi);
+int z_erofs_map_blocks_iter(struct erofs_inode *vi,
+			    struct erofs_map_blocks *map);
 
 #define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
 
diff --git a/lib/Makefile.am b/lib/Makefile.am
index e1c43fa89009..f21dc35eda51 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -3,7 +3,7 @@
 
 noinst_LTLIBRARIES = liberofs.la
 liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
-		      namei.c data.c compress.c compressor.c
+		      namei.c data.c compress.c compressor.c zmap.c decompress.c
 liberofs_la_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
 if ENABLE_LZ4
 liberofs_la_CFLAGS += ${LZ4_CFLAGS}
diff --git a/lib/data.c b/lib/data.c
index 0337521f560e..34811e49512f 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -9,6 +9,7 @@
 #include "erofs/internal.h"
 #include "erofs/io.h"
 #include "erofs/trace.h"
+#include "erofs/decompress.h"
 
 static int erofs_map_blocks_flatmode(struct erofs_inode *inode,
 				     struct erofs_map_blocks *map,
@@ -116,6 +117,77 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 	return 0;
 }
 
+static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
+			     erofs_off_t size, erofs_off_t offset)
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
+		ret = z_erofs_map_blocks_iter(inode, &map);
+		if (ret)
+			return ret;
+
+		if (!(map.m_flags & EROFS_MAP_MAPPED)) {
+			end = map.m_la;
+			continue;
+		}
+
+		ret = dev_read(raw, map.m_pa, EROFS_BLKSIZ);
+		if (ret < 0)
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
+			DBG_BUGON(end != map.m_la + map.m_llen);
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
+	erofs_dbg("nid:%llu size=%zd offset=%llu done",
+		  inode->nid | 0ULL, size, (long long)offset);
+	return 0;
+}
+
 int erofs_pread(struct erofs_inode *inode, char *buf,
 		erofs_off_t count, erofs_off_t offset)
 {
@@ -125,7 +197,7 @@ int erofs_pread(struct erofs_inode *inode, char *buf,
 		return erofs_read_raw_data(inode, buf, count, offset);
 	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
 	case EROFS_INODE_FLAT_COMPRESSION:
-		return -EOPNOTSUPP;
+		return z_erofs_read_data(inode, buf, count, offset);
 	default:
 		break;
 	}
diff --git a/lib/decompress.c b/lib/decompress.c
new file mode 100644
index 000000000000..870b85430dd1
--- /dev/null
+++ b/lib/decompress.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/lib/decompress.c
+ *
+ * Copyright (C), 2008-2020, OPPO Mobile Comm Corp., Ltd.
+ * Created by Huang Jianan <huangjianan@oppo.com>
+ */
+#include <stdlib.h>
+#include <lz4.h>
+
+#include "erofs/decompress.h"
+#include "erofs/err.h"
+
+#ifdef LZ4_ENABLED
+static int z_erofs_decompress_lz4(struct z_erofs_decompress_req *rq)
+{
+	int ret = 0;
+	char *dest = rq->out;
+	char *src = rq->in;
+	char *buff = NULL;
+	bool support_0padding = false;
+	unsigned int inputmargin = 0;
+
+	if (erofs_sb_has_lz4_0padding()) {
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
+#endif
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
+#ifdef LZ4_ENABLED
+	if (rq->alg == Z_EROFS_COMPRESSION_LZ4)
+		return z_erofs_decompress_lz4(rq);
+#endif
+	return -EOPNOTSUPP;
+}
diff --git a/lib/namei.c b/lib/namei.c
index e8275a42f090..4e06ba468dc4 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -122,6 +122,10 @@ static int erofs_read_inode_from_disk(struct erofs_inode *vi)
 			  erofs_inode_version(ifmt), vi->nid | 0ULL);
 		return -EOPNOTSUPP;
 	}
+
+	vi->flags = 0;
+	if (erofs_inode_is_data_compressed(vi->datalayout))
+		z_erofs_fill_inode(vi);
 	return 0;
 bogusimode:
 	erofs_err("bogus i_mode (%o) @ nid %llu", vi->i_mode, vi->nid | 0ULL);
diff --git a/lib/zmap.c b/lib/zmap.c
new file mode 100644
index 000000000000..ee63de74cab2
--- /dev/null
+++ b/lib/zmap.c
@@ -0,0 +1,415 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/lib/zmap.c
+ *
+ * (a large amount of code was adapted from Linux kernel. )
+ *
+ * Copyright (C) 2018-2019 HUAWEI, Inc.
+ *             https://www.huawei.com/
+ * Created by Gao Xiang <gaoxiang25@huawei.com>
+ * Modified by Huang Jianan <huangjianan@oppo.com>
+ */
+#include "erofs/io.h"
+#include "erofs/print.h"
+
+int z_erofs_fill_inode(struct erofs_inode *vi)
+{
+	if (vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY) {
+		vi->z_advise = 0;
+		vi->z_algorithmtype[0] = 0;
+		vi->z_algorithmtype[1] = 0;
+		vi->z_logical_clusterbits = LOG_BLOCK_SIZE;
+		vi->z_physical_clusterbits[0] = vi->z_logical_clusterbits;
+		vi->z_physical_clusterbits[1] = vi->z_logical_clusterbits;
+
+		vi->flags |= EROFS_I_Z_INITED;
+	}
+	return 0;
+}
+
+static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
+{
+	int ret;
+	erofs_off_t pos;
+	struct z_erofs_map_header *h;
+	char buf[sizeof(struct z_erofs_map_header)];
+
+	if (vi->flags & EROFS_I_Z_INITED)
+		return 0;
+
+	DBG_BUGON(vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY);
+	pos = round_up(iloc(vi->nid) + vi->inode_isize + vi->xattr_isize, 8);
+
+	ret = dev_read(buf, pos, sizeof(buf));
+	if (ret < 0)
+		return -EIO;
+
+	h = (struct z_erofs_map_header *)buf;
+	vi->z_advise = le16_to_cpu(h->h_advise);
+	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
+	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
+
+	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX) {
+		erofs_err("unknown compression format %u for nid %llu",
+			  vi->z_algorithmtype[0], (unsigned long long)vi->nid);
+		return -EOPNOTSUPP;
+	}
+
+	vi->z_logical_clusterbits = LOG_BLOCK_SIZE + (h->h_clusterbits & 7);
+	vi->z_physical_clusterbits[0] = vi->z_logical_clusterbits +
+					((h->h_clusterbits >> 3) & 3);
+
+	if (vi->z_physical_clusterbits[0] != LOG_BLOCK_SIZE) {
+		erofs_err("unsupported physical clusterbits %u for nid %llu",
+			  vi->z_physical_clusterbits[0], (unsigned long long)vi->nid);
+		return -EOPNOTSUPP;
+	}
+
+	vi->z_physical_clusterbits[1] = vi->z_logical_clusterbits +
+					((h->h_clusterbits >> 5) & 7);
+	vi->flags |= EROFS_I_Z_INITED;
+	return 0;
+}
+
+struct z_erofs_maprecorder {
+	struct erofs_inode *inode;
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
+	ret = blk_read(mpage, eblk, 1);
+	if (ret < 0)
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
+	struct erofs_inode *const vi = m->inode;
+	const erofs_off_t ibase = iloc(vi->nid);
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
+	struct erofs_inode *const vi = m->inode;
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
+	struct erofs_inode *const vi = m->inode;
+	const unsigned int lclusterbits = vi->z_logical_clusterbits;
+	const erofs_off_t ebase = round_up(iloc(vi->nid) + vi->inode_isize +
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
+	const unsigned int datamode = m->inode->datalayout;
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
+	struct erofs_inode *const vi = m->inode;
+	struct erofs_map_blocks *const map = m->map;
+	const unsigned int lclusterbits = vi->z_logical_clusterbits;
+	unsigned long lcn = m->lcn;
+	int err;
+
+	if (lcn < lookback_distance) {
+		erofs_err("bogus lookback distance @ nid %llu",
+			  (unsigned long long)vi->nid);
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
+			erofs_err("invalid lookback distance 0 @ nid %llu",
+				  (unsigned long long)vi->nid);
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
+		erofs_err("unknown type %u @ lcn %lu of nid %llu",
+			  m->type, lcn, (unsigned long long)vi->nid);
+		DBG_BUGON(1);
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+int z_erofs_map_blocks_iter(struct erofs_inode *vi,
+			    struct erofs_map_blocks *map)
+{
+	struct z_erofs_maprecorder m = {
+		.inode = vi,
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
+			erofs_err("invalid logical cluster 0 at nid %llu",
+				  (unsigned long long)vi->nid);
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
+		erofs_err("unknown type %u @ offset %llu of nid %llu",
+			  m.type, ofs, (unsigned long long)vi->nid);
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
+	erofs_dbg("m_la %" PRIu64 " m_pa %" PRIu64 " m_llen %" PRIu64 " m_plen %" PRIu64 " m_flags 0%o",
+		  map->m_la, map->m_pa,
+		  map->m_llen, map->m_plen, map->m_flags);
+
+	DBG_BUGON(err < 0 && err != -ENOMEM);
+	return err;
+}
-- 
2.24.0

