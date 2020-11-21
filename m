Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D7A2BC1F9
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Nov 2020 21:12:03 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cdl1r53X3zDqlJ
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Nov 2020 07:12:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1605989520;
	bh=pU5SkG/rJPwfrG+2fRSKKOWbxm5Ta6nLeya+oMOsaTs=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=lV9OSYSRaOzUViQY3AbKfKP08Annl0fCWtYjXYhXK7uYAo4uNuB4PZuh1u65l0rnW
	 u3R0QQ+2QG87FLFTqIe/OAThWFHZF9yrwM39w1qYRMFQgqKRDQ1sv0hKjRdmX5e20R
	 2RPcO83aNpiEzBctPx3EvZDl4Z1nkrJZbvTYtjDGhayt+0MvfuUEM+N3O/4iA8x0AG
	 jg6IrM6C5f1SWR4y+7rePdD6UA5IKeM9RkYwDNPDRd45/vIYxepMTqmTc3oXFTCbFB
	 eEfhscadA1Mu90dKLyUEquKGMCVcEksn5Mt43XaAO/+UlORqQE8nP+5jFER5oSIgOT
	 XcSR4HxIqoSsg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.69.205; helo=sonic312-24.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=rrEJbPoh; dkim-atps=neutral
Received: from sonic312-24.consmr.mail.gq1.yahoo.com
 (sonic312-24.consmr.mail.gq1.yahoo.com [98.137.69.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cdl1F6wFQzDqlL
 for <linux-erofs@lists.ozlabs.org>; Sun, 22 Nov 2020 07:11:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1605989485; bh=7o9dFNmIwBLuV393RD3PYvquhm65Br1ZARhf2fXjTtA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=rrEJbPohU2CULKdOV3wXQTMhDqo8CUwaNWRxIvrL5FNBnOr1f3CSxNy3dJQJ5pSWKsF4ddNEsBSPtgxeKI8LU8MCymN+x1r88bjaPDodTABAqgCqXsll41QJutKA/+v5kRPs/DlMNEc1o0/VfL2mKMTYKhT7cXyEt0yDnarkXD47/itHuiNuWIcRE7xeGCGnp0AqB2Uj3i1ElF/E0yJLHXjkeHOS5oRvgfI9Hsz+IloaI/k4Tnb9+vLwnymrboOaeEykUy45erTt56oXCJQMtgfjt6+qH997ftxGkU/As+2f8o/RuQ1p61Y0fFQQ6qU+UuNsyjhzzyG5CcYox7f8JA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1605989485; bh=u5aYosasj8EgyoEqPcglobEWZmhqtplHu7iCpr5zVKk=;
 h=From:To:Subject:Date:From:Subject;
 b=dRGPXbMcUedwZn9YgOJkfU5omYsE3b6iihfo00Xdxxmly+F8F170rKc+T4nJZXnNz4UjicmGQQGmrVS6AFKinTdJpxnuHEqQCIto4xXgnxaoJM7IMUNlT1XxrYb4oE+hActpcJ7PU+F601F3EMokXi9fHtzirfWf9HwyxeOSn7Iw7qirnHZxkel5hBthxApUmK+yOwOz835weRqzFdYAIiCD1PNJfb+lQZ19r4HNJkxp5FAyrpckOQZcZPrPyx4Ra+aQbURWQN7f6sYnMU5s7DesSHf6IgUwei+uUbyFJvGisGhxwVlVew/x5HDSXXb+qiPEi1y89ZErj0zWu+Bedw==
X-YMail-OSG: 2JOB5CkVM1kByoKWrkPzi8W_TEzjT1JjW_o8SfU7Xv1iPOD1hwHR_482i3WsUl3
 cZ_XFfQCZtgEFZieTddZP5R6vInSr0poRwRBKluXTZ1lAqdLZsXvSq6d4pzVOfkJHGF80GGCUXEX
 Sp9JoKPobDhTE0u92LvqHRfPbjjcBzz3Pr3NIrVTUEz5avSAOxb_Gly8_acS.I3Pmyc5tIssGEep
 xY2F5A00Y80CFqCpmUHjcA_avR7YHyMXNYL692KtuugTkA5V4B8QEwqSH4qBSHNfrXZCQvxJevIq
 TafnTDCQs2.PDJLpgaF79XoGpAbUNSJ7ovlznNC0R9ePmWp9gDGz4SE1GHSkwIjh.IYmqfp4GKrk
 xazODSJ7JWrlsSNS7vrK2W.uCUEHCGW_xcpnm9bxAKVJFnUVtsCn5uGj4F.Dw_NdwjJ9IWlOqEMJ
 PBYQ3ReENlLFl7Nd7skQ75xPJknszlaGO.677UVW4SHzQDRDorg2EvkAzAkRN2MrSRAOGFJwifbS
 lB7BvqyhSexNE5PMnDKFjDAwBx2Q9tFu8ZZoo8BEHtOAhTqGIKt9Fcu05i3m60PyHEdGKkfQUkaV
 rOZAUB74AUPnkrbVGQuMoJtLX5ZnmjgBF6x.KuNiT11BRMal5jMOE2IgE8YkzRIzwf0Okswvm_9J
 qlFQAooFMEggQXf2uOClUhbOx_lqxup0IsqiaSISaPBXbz9htrQAQKHOjuvJ60sAu5vAAd3OoGCm
 KfPCDEwvdiNGrSdRwOgG37GlYAxZkecAN5.nOz7u8KLn52wH.JKFlPKghyrzFph.GNvhZpgnJKtD
 SuiwK7y115e11vBBDicX_uDrqNTs3c6E58FZ8T99MDrlmxeonFgyqHDWzXZpOXn1JiVIAd6TLfdL
 mNaFtN_1rsEneB4GBxdmsY6GuQZCXu0LC735.4ImSmoslYvkHkV5r3N5ypnklWTo.UjfGbQvYKSv
 OL4jifhG29o4hlTFCdAm40q_FjCrjl7IHECg_h5HdwXdn_ZWUSkEFJZnpUp7TOdIelzyMNmU6TuU
 OsQbYCH7FGepnjz44oxbbeHl01vxKtZxNUvM9x1eraI_roZ4gcTl9QIK2UhxUkeeTNwXC4DiHO3J
 S7a7M1xQIn5kdQKB1l.80gvgzCUw6rMF6kcED24iWMFLfMWnTvqlx9ileZDJeNrsgmdMvNVVX1IY
 xdRR.QbLRvWIhNKsfG1KdEPRMpas0lcgMqVH7824vri2x0hTWOTunLM6dxxNhDxJhzWUXaPi0xLS
 rU0FiaPjlwXm2RlO5IHh.G6pjuZJhwrbVGDEJoEPOxrcjIvIfmZGEMFMrFPhPP0Ujbf7QPUtQHIz
 0IVtDSIvsp6s3OkcASbYAx9e_Keqls5vX4g5hKoegrQar4pF.1gC_qqiKTvcggasWT3_29oI3P1f
 Fw1w0fO6JZWkMH3hFqFDC14IiRavfp1j5wJbNPt5mVknrZz9UBYq1fiq_ryHGGt6lxODk9xHC5m4
 XcElHqOwrvhO1ZcitiQeZ53F2Wo8i_A1kp8CwFZqm.cDL69dL0EkkPNL6oFIap9KMkLnJFmG56N2
 2YetM2rn1mDooXHRbTJ3BkptAg3OgmI56jSV4t6lWWRiWn5.a4aizlxA8Dlhk2CXvHyVMRX3ctDc
 DebpRi9ZOBCcQpUMtEBmCKjDwesL6g9fL2Yumgkspdwv3rEq.HjiUQNrBK_FFqNk03mCsgIxYCho
 C2e8BgDSoAP_5In4iV3_XepPgYoB5lnkbBd.wRLrJFwl7rJxq4wAhJarfB2r3WvdgWTL485eM2r9
 _YUqo_4kGrScQOVuMMQhnpWIuAyafNNHu1PvR8Dc9_KNvT7QAFiN6aXz0GLPh8hk4LGgRwzAeC7Q
 w2cNnD_UrFbZpH1wLNcpgNoRnpAO8WVLKeY9ZT8n1ZSrPotOwcEdaaM.cPb7DxslBhCwZAqBRMCh
 4g2f4qQ9xiZYrQaZliww3eVbXo84otgOvpRW.WPoqKKzhnTnxvI6Nv9nBXsdN83ovY.oSdyVhLTo
 lX8DI5DZ4Y6sVW9TrQP3R0ojMkW6cxMpzvUHkueEdahRafDlU5.EkGUhByOJLWitqb0tWwyYCfFN
 QsE9S7vopG6supSbsFWAMGhImk3_Gaaxz0_TvXQr9Jc8nKDe4LZnAjCWglFm0m_7.3EWdUwpC7fV
 fOW3H7Wu6CL0KVraJUvHKMF2u5EP2vmR_FolA5qBSdkzhV7yWhJwhblUc9EZ23jOoYnju00sAedv
 gWHZtiEnQq9qCZZ6NoetecyVpdyt3_sUpVie7f13zkFK3XMok9DM3HWbY2.XZKLSvOykvf0J9zqi
 Wpw.oe6LIE55N3Hi.SU5TtEJPtloSCNkDP0zjgVTB4LxlYVVpp17enJBueMDls7_yrjy6EX59f3N
 HVKvMVljds1qOK0hJoyPkumBP34di1Hi2bqkD67JYij.2WkVjPiQAsE64ncI4TrSwzL9exgfZu8y
 4Mf9fzc_2Wu8jJn3Q51luT_eqsmFZBjDsYjUK7eGhqc4lM56zs6VKVxgaD0BZAYlHDXUyJr.nE0h
 wQrh3tTHKS1jbTkstVejYtaBoxZCAO3OR8dBogTjfxf74MqLexnzmReVoyhzcMHRphI.O3GWVzvu
 _7kvKzPqQM1z82BdggwzBWi9ba8DE2PbcIzdtBE6G7uyRCmPTSLGF.s579BzqNbMHTECoqJ4wJi2
 Qt7GJJ3vnNf0TP2m4mstrVLawxPopkt74Yo9QlVOcm2bKjU4osCPkDSx9SmQcuWRXsU94iZAFdzm
 8NyOCDJizkWGtEwPwC4hs2jegCTxznBVbrOFVzpF1gW8rdqOjRQRj8Q.OzI_xeTpTQeRADxQBxkz
 Plr8PbWx4z7IG.c7sjLE6ulRkujlxCwfLWVmiIu8XwL9whZxIZg8tCOGwM7QZBYB1
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic312.consmr.mail.gq1.yahoo.com with HTTP; Sat, 21 Nov 2020 20:11:25 +0000
Received: by smtp419.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 6070243ff164391bfc53a248c45d6337; 
 Sat, 21 Nov 2020 20:11:20 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 3/3] erofs-utils: fuse: add compressed file support
Date: Sun, 22 Nov 2020 04:10:10 +0800
Message-Id: <20201121201010.24724-4-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201121201010.24724-1-hsiangkao@aol.com>
References: <20201121201010.24724-1-hsiangkao@aol.com>
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

From: Gao Xiang <hsiangkao@redhat.com>

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
 lib/data.c                 |  72 ++++++-
 lib/decompress.c           |  87 ++++++++
 lib/namei.c                |   4 +
 lib/zmap.c                 | 415 +++++++++++++++++++++++++++++++++++++
 8 files changed, 626 insertions(+), 2 deletions(-)
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
index 0337521f560e..3781846743aa 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -9,6 +9,7 @@
 #include "erofs/internal.h"
 #include "erofs/io.h"
 #include "erofs/trace.h"
+#include "erofs/decompress.h"
 
 static int erofs_map_blocks_flatmode(struct erofs_inode *inode,
 				     struct erofs_map_blocks *map,
@@ -116,6 +117,75 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
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
+	return 0;
+}
+
 int erofs_pread(struct erofs_inode *inode, char *buf,
 		erofs_off_t count, erofs_off_t offset)
 {
@@ -125,7 +195,7 @@ int erofs_pread(struct erofs_inode *inode, char *buf,
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

