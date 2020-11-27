Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0912C6412
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Nov 2020 12:48:02 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CjCYX0rwWzDrcG
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Nov 2020 22:48:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1606477680;
	bh=7cz2GxooXh+UGOQhlEiateQ8UzQmKSFXflVWHvaR75A=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=difmvY5BxNu+VuojBKI3/lM1MRX7rTjGr++SsfDMCgykCxvNjOu1UMk9UPDU+944A
	 CFEgUGppBavnLt/W+EZfkc3JscM2CGnbYDswAK1+hXw01OjIfriLfjQmGcSw48v0Zd
	 T8XPZkSVSsdVgcvo54llNTur4+hOM/7fCHeGZ6OHRtwSeQC7o5AcOACOyimwAnS3aW
	 KhStC5oEWZQmWAj0gDgTRqniu5qz67SW7M0dJZLJqkdlbAsunJyKx6zGqbfVnNEGRs
	 I+H+DwLVTdSCGdnc88LV/QICTY8hsW8YfT4/w5OwD7fYFxifLfXJPQwOXGY14xNhYQ
	 mNIjC+eZsJeEA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.69.82; helo=sonic314-19.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=ko1uROf1; dkim-atps=neutral
Received: from sonic314-19.consmr.mail.gq1.yahoo.com
 (sonic314-19.consmr.mail.gq1.yahoo.com [98.137.69.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CjCXP0W3CzDrc1
 for <linux-erofs@lists.ozlabs.org>; Fri, 27 Nov 2020 22:47:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1606477617; bh=ozlF6Qfrbz4qpLBmMDun3KJLMBhq7bVge985suSbe5c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=ko1uROf1q0W35A+6jDwHHY+Lnm8i/qJzRAh6Bp1QIhyw3fnwulxccZPFjkR0jp8t93KpaxkZc1NhYEpuvKSPX++uiGhW4jSTaJ0DF9PAGGAXM+W4+9rCbn8n408X+WiOEyYVwEWyUzjEonmbXlkEpIY9aDDSGkLJ1rkg8WVlXRXoIa2nfd8vWD3Pb94KeU7SfZEwtssB+0k6F55Dw7g7zavTASlL7LhFKCwkCmK0MYumN8q2jqR8yIZccfWfOaw8xzs7s36DzWBJxf0/3dffrXI5BKsfgSYZ15wWMBwcO5TbTj+0nSGN+WUFoSkfUevJwHlqzu8EeVIwOZ+E5ngIcg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1606477617; bh=4Gf4h2s17A6RqT2NIwFHzEGESm2TTzwUYgg4qgD3OES=;
 h=From:To:Subject:Date:From:Subject;
 b=EIYex6k2r1xjbDoVuA726VlVCQuxW1zu9vUv9NJZMdjHreUW0z/JWbGz4gYot4ikf3LiPm2VKKZnYtrNHu4Lf26IQ9GH3awNwqIe9M9PgDimMuxUzQj4h4BiXyLl9s1vNAs6YKsr7L6EvY/9qICnCioOQ7rFtNeGAeRKitWYCuw8Y89H5vp61hAEM+3PIRZdkJuAq+Qk2wDx/CQxwE4OtGjXPQdIogRejfHUXCs2jTSUbAJJUcqjTN5gbLD8niOgE1bBHCZdnJu/4WNZPgaeQRP8RhwdKxzyGBa3Ke+BxxkT11ajERXnbrBt7XXZPJCnKC1Tubf0pkX16bvjU9FCIA==
X-YMail-OSG: ZpORr2cVM1nC.bS7Eld91qaD7O7bJTbCtPxg_NU3ivY0C4TKyL6vGj2hpdDEZ0Z
 lVDpI5egWsAXHw4Zbuh9SxZZoOsnppU_AlmIpsC52G9Y5p6golMSJCWYVjVo0B.pIPGZxsga3DTj
 ZE05nsKyu63WD3PKOL3XDc99BqhxhjX31l3Cu24vcZ2Nz8Bv6DhJfRPGBjKJzfopCPBzSc6fRagE
 EA5FKL4uRvgRr_z1v72Tl0nRL7iucoRqE6SoJpRfrVcE40K1UgUh1RqmYHRPftTdfFtOfDBwiYNv
 ERvsZwb.8XES4yL8NSj65l.fHoywmUA5yR9JQappPtsTvFM8c5SlfS.pMe4TKLaVywqdm.G8BZZ4
 GAfEtm0xCcqhc5BuzX5fNiO6hhn_mJ6v0UDcHifKXeehZNEo.f1JXEzAxYLinftkQACHsn9bfvhQ
 zMTjMxiepVpaPH9BnDeEuJzdtQJIlLXsrNr8LRElngH2OHEzxPJMo1feIpZdIZBaZjipO7GrSLKS
 6F.hgPPlurE0i50tUcZPVHB66ZUmVFiwvEpXtRyfCxTktRuAJPvej.jm0_XKcJ8QKmPLpM7Zypor
 oREu6Dj3t9MvZOjBVBIc7DpAPvUUt7iJX5nnplxwxOTzKu3SL.9B45LqtOZ3WcTGFAuH0PoxLT5Q
 eOaBkUloefl1MzviH0SdY.g6qml9K35..VQAFk4BR8sYK5UWVzt0rWEzQDnMbRr0fCOVczQXVOaN
 oEvMNRNZjdYgIOnQ3jDatMa65AFWOEfbsXIc9yTIs6hDqX8XovxZV5B.W33bAXUxEh.fZo6YXjCk
 RNzpCjnowFmDHg0ZiZes.WIkN9kfB1.mwS8H4reOOVfxKICFKgXyZrmlPOZdifFUBSLhbQP9TMKc
 S_rgmRx77vd2qskRdJiaie_0Pusa.cIvM1LlNOb0XkWsw5XdhS1IG0xq8yo1gBWxV_MB7CR9wHFQ
 gNhwCje4rSd2v5e1c7kMAB1Em4w6k2US442BjpTibhBXJUY0JzYfyTMg3VC1sqz1ykcZNvpEmONI
 LwGpS2IqOVtk2weoKrDoB2lG2.Z5Bn6cTs476SNai9.8is8Y8aJHlAD7Qeid3IIfVRGGl3zekvsT
 ZRjpgtsDZFceOGjZ1pVgv_VFQ0KkSszpF7_mqibWPkyqIcwW7UBZueUoMaTWSvpcFjIOBctRGZMz
 bYFWDme9_OkGnHGNZdhzkRnkuiynExsdB1t4Cz3_85dxp.nXEfe.XCl6BC9h4zW.i9C4MddbqjLQ
 HyJOh_D25hq8bY07QZhn7EGExMXn5jmFqaK5l1n81w.ElRFXnHB1s.StR.24d4bnbLGNuce.5_a7
 ahwGW9ReFhb93BECU.Wyz0DFIQOcWy1Ku.BNWYGMBuIhJfyaaDNNLgAebCdyfI85uaBEI7QnJozy
 _8KwrW2AlNaRkhXo3xpe70a5tLEJM1uGdOaQ1oC.mMlDH76Dg3bhoWoFdMn7JdJlAdLvVvfUbet9
 aII85J35nK1Ibs5QdCQX.ImhKMKECIWU_PZ4sliYFJ790ZjoAcYU.CbIRZ1nnoGgDPqtKuOxzs34
 I83tDPSwfKvLNReqAiwC_iDLhCqjs726QlUfCySSc9Lm5QQCiT8Au_9fRCdI.ghb9eSVuKWYZZ6S
 rxRLAelfqo_UxLL9cd6ECfvdUK8USYU6L.p4A14bPUE43Frq2WcPKTjlDKnwPFph89HI1Ekqnrp2
 jzvBcT0Wu5HWSoTn2O.P52PI6L.Xqctu9ORj.loI4bf2FuiNrwYXoNNWgDilHEPSxRhwlt.d8KtQ
 5o2Y3o.DpN5hoXIAlA7d.TqLM0jXyXQIoWflP5SGWcs8KQCp2quMNOXFiL4jCP3Cc9BaqZQ1GWB8
 ZeBom3v8Lb8kuO4HyT9_RmKP2sGTSnhrU7C7Dy9rxy3V3za8GmjICDbzbgfkp2Ud5HbTj5su7vgo
 6L_S5DC3pntwRPzNZ7t.._QFNtwN947KRH1aGjSCwtiPVHVRZ22EQ6jORB7zac2GgjixusS6E3k6
 Hq1zszta19E6c9HapIsvRQG93mTy8twNNLlfNqpZwhWUVIHX7cBoMn7Wuc_zVmbtiwd1zobCW785
 owUV9DzDZXgUajfdT7yLsx3UhKJiFW7ft54yTfNI.o5PTCuUVpAqjr3ir7LNdywR7ySn4lFop_3t
 LdPLLzNfkNnB8iB409c91.pihZmRCfMVXyftAeZjOFcuhPjiTZm5eX4LRs9dJhz6gMlmX4zfFF2A
 lgGzhk0_5reo2UXmnuivmZNS_LE2LPOVORqNGFNNFwSJpLTm_UJZlBG5rn7ZvnDQFKnzoeKdWx8D
 nIoldc94w7TEFFij7Z5_4S7VOCpXfIeYZoDRM9c_ClNXc3HQ0v0ddy0TpFImXmaHIcT_LD39_3oL
 .J91wRY4uoRcsw0E9lCbZQfQs4_RcHM4icbS7Z_yb3izjV0OyuNodG4BzZIPp4qLdUS6zBeY4SqW
 khRuz5uVphmEBAa6yd6x1x9z1Y5P0wTnxydY0nQse2E6jZEJqBNpJaPoeVzCWKIYi1Pe5vTJ6n2q
 B224v3LHsw3q13KmM5NMm4_Jevz84HJcBPHGy17AXY_BW4wI99ynMkapsEBYIF3B4NozVxTqsCzP
 4m12MO0s1X35S7puiJd7JYT1i4oQfKRwd0RP3ZdWjVqep.1QSNgro6tgDH_as2QUexhepw7s4QHy
 oGqLUG_C0cpmfrgrKPw4yPGHLKx6z6.f4mzY.Z72iqM30EvHNims8tpg0Lek0mpdlqUbB9d_61ER
 3UMDcK6DAmp6OOiuOAaXq3mDGcafPosViDsZnPtOETw_ZuQ3xnwLofhi599ZOBAREHmUmt0pDDQ-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic314.consmr.mail.gq1.yahoo.com with HTTP; Fri, 27 Nov 2020 11:46:57 +0000
Received: by smtp425.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 3a2b2602d95632a301ae818aa8f56dbe; 
 Fri, 27 Nov 2020 11:46:53 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 3/3] erofs-utils: fuse: add compressed file support
Date: Fri, 27 Nov 2020 19:46:17 +0800
Message-Id: <20201127114617.13055-4-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201127114617.13055-1-hsiangkao@aol.com>
References: <20201127114617.13055-1-hsiangkao@aol.com>
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
index ec2646c23b78..bf13c166ba16 100644
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
 
@@ -248,6 +252,10 @@ int erofs_ilookup(const char *path, struct erofs_inode *vi);
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

