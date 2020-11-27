Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id C647B2C65B2
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Nov 2020 13:24:45 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CjDMv0JC9zDrgf
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Nov 2020 23:24:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1606479883;
	bh=/ScIqjOcBH8OvrqJEIOAQfe/vzpNvWDyfiPyAiHPKmk=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Nc8uNa+EACKgzmwLz0mdN1pb19nfqGWSK8sjxLBsfVU4ESmHsOO2wWiMbNYDd9Azq
	 sfG95LtxtgK6COMugBCvoTfWKnFEDcUxJ1A4kYeu3Qbev03JYtNJmHkhjUiQdh8mjo
	 IV5iZ7b46FYi5/l6gMQ8K+zem5LwlnDFtQ2XFe5j18I0qvc8SJLb7KbvUL2vl9wxBq
	 eZ+AmKJRw4g8WQbmoFhi2BRVw1YuuxwQFrMBAOhcIlyRW2djeeMxGkMUzBPIKHQJ/+
	 sQJvQDCyG1nB3GrySPdk8UtJT8sHqW5Qm3vvzvtkPHc72jfIIGAvBe78v5GAxADDEo
	 j+0lOmoFCB6Ig==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.82; helo=sonic306-19.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=TGbNX9kW; dkim-atps=neutral
Received: from sonic306-19.consmr.mail.gq1.yahoo.com
 (sonic306-19.consmr.mail.gq1.yahoo.com [98.137.68.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CjDMk64bWzDrdS
 for <linux-erofs@lists.ozlabs.org>; Fri, 27 Nov 2020 23:24:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1606479870; bh=5uPWjaP/vytXSSFf6JD4MJvpvAjBbTvlf9UemZSDSAw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=TGbNX9kWoy2BKdt2gY950F+pczC/HWAcd0+MunGK58LJmdqHChmaT8mo7xThrmtq+sPTLP5IwTI8GpoqWHIOx+Y6On4WiZM171GemMllz3jy7ykNmTawSrTNmo4xBcqpkZOtqapnS46G3Zk31cRpWGqSSfX3z5rnvd+EYc9qLOFVT63pK6uqJKx2iCccHjKNGC7TNpAOX/anzIdQifGxL9Vg+XKmVnQcFjB19MJnEbf9U+hD/ncysyThGTsBleeEJ+bHSXsN/5Dm4pCoDyq+kLhsbTMjUf7vkvi9wOMq8flGAqVEcMb0K7ob4QjLmyT0hEOUzy7Ji/fd5p4ck8KkFw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1606479870; bh=jPGx7LnatmCyMK6Dto8fLXj+Kf0G0PiBOnP8k9iBwt7=;
 h=From:To:Subject:Date:From:Subject;
 b=UfXfwoJBIBSq09/r/islDXHBm/4PCSMXLc3DCSW70giBgUR/bBo4IDbHBlWymGkfvLvhRVdCqv1paCg02JtIg5nnCyQInIhtCrivqpVgKL7D4sxhSHvdgZo1CBeGLzbRhZwEHwdL50oJT8iMmnqVN60OGdjPnihW8jli6VAkGz84YuMcAL1bwd8DMgheeu6xqB5mRrRRKlaXUdov9yijVE6wUUbTkFN9LQc2TsHT4ymJknvKNCKCbivLZ2TlCfvpx96RXhORU9+1bn+2oqrnwFf4fI7ZkfSPJMuDbJwpJWVifQKcf8BScjBqIgTbHQZvfI/Thcbql9z7lor2yZ7n3g==
X-YMail-OSG: km04ts0VM1mXZycHSBsa5Jhp9EKlUL5_T0qDZ49oF7qSBcCWiPeaIh7WnKjd2Nl
 Hm_xlr6GPecxdfubG56M79xenHB7TNTx3Zhmn0cUsHL_2FJ4mEMkvcDmKrvozMG4LfHWLOX5HO4Q
 2tu0HjSa0wAa6bP8Tp4WjNe_WyZ5AoM5sKti49B3AmIji1OWXoZUQry6A0sctOsBhaO55EyKzDav
 0659fASBq4crb61YcBrOd.NBDt8Yw24Urp800zqj7rlkMXfrKT.2pb46pm.MgAJp13_pmR653rsh
 8Gnab4Ftqu9HkRUjrWLVsDzltlvUfeAcDKXeCK_vzK6iPH91ZiRW6mtjTLhSWtJN6U5TQw33bVWc
 9D1eEZKbIxyx4bSQFgyRT2UjKAzsXKY.qIByS8GMI4AbcrH_0_8ra9pXjWYExPjeSXbNhHZVuWH1
 IfGXY0hWxkKbj.sPvhCpB7XVzwUmu_h4ANMqKh4gLBqzPUTBccTJt1RRJCvpLSfoT0TCHih_oIzz
 Ih6AFlFKWJ8roZuQo2hBoRW64cfKEV6Z9wjHCwIghigCx1jW6DxQP7zsarmL1bN3JZ6VSk5wgmqx
 dtacMJ_a9D1EOw2YSew27oysMm85R8KnBkYqlCMroprWSJlKqdZxkN8CtoVqi0B5NrYAm_wnmmxl
 risAPrwnak8Qo.z1XtNb5Dv3YV04JZPW7RdGPQR48_KdQSgxvyWGSoSzzGCgqfw8GtfKWpRGDhlY
 lDhd35zKw_QAXPwmk2DNzc2TiieWjEu3DdOkNfBfVuObJQH0.y49ucMo9olVI_BjeZJmmGJLwVMj
 PkDv9UlBJp3wX87s42ZipWCNu_irj352ssTZSTZVgXoVmcrnB7vf_gMvIZFI0fbKpKBMl6mWNvhX
 8moJuYpPuM9Ugx.1LOKKBtnbVOqnG8jIrhk6Y17PrJ6HjkVWEuIWdiR..hpArd_nRIsPD3gya5sx
 CbxIayVQEVpSrpj7kl3ce7ftJ_McAO4ENjX_qlK7z6B6sdEL2yOJY_vrPAsl1bZkG77DW5XuQQWg
 KNI1XFd6JUS_jTmwxhbByYA3wM6papJgmR._i0MxY.lYMRTZmP42cCUTvZgn7JzAKk0egsoFSq.2
 3UFqDsAKNlAm_wiRZcjScmQ.bnTTLnsk0FoNXkTrQHSaTw_wYJdRJVM_cvGRrfECPOAvMIQ9oODj
 MyaJTcOdDRncFswhoQ6xjc_UJrBQMN2OHlCmwctzo.ns1sGAgPLaKNroSp0E9L4w9EGAT2jxTkAj
 FSYAI6aAfjoz6E6o0WOXj8HP.5AL6.FYR19Mao9Vu6EMOwYOZ05.0uDT96M37sRgFF.1.0.av724
 pJEY45CYphN5ywjW8nsp_nptqkWmH_ogSZcPtNSX9z2r9CxBFd0Ne9CRNrt_uWJbja0r2wA5zg3P
 XbYBSYu2kXnTu9ETL1dMV7VCCyMNsFb3OOL9vumUzu3NdqyUb.NoCo2pLBgolTHKjqQUW133dcRo
 Myrtk8sVbLrzK41Edplow0GL4IA2DGw8dS5YCfCIv2HDEJ.G0dZ7lmktxwM3TzLDoS1Lwg5AYQC8
 YFvSqJ6qW7fz1H9b16ZPXQfvpGTeigoBEyLe0cCroZxQNEHYff50YMIi2xjXdx_6AeVkDpvMlr6N
 hRBUMkg7axVAZaQ1jdccJAojw51cxQYfSb376tr3JzUiojyS8QlaiukR9Zpbp3U40Fg.RgCPqASu
 uuo8ejZ20CvFh5ugCYWyQDB4PiJDb000VuakkOIe55yOdl4MSImDgSqruts27vhVIbmgxQpoSn7U
 H4VtottjZs37GuQjxk0FcDn1EXy8Sp5UguCKxoRu77LvHtZUqj5p61O1YBMuXkD3VLDajN8b8U6k
 _fsGQy9oyw3cOuEUvLMwwZgIA13AsOkn27x9IPnMZdm8zkIttNe07cutBaZ0qi1_zqwZCK7lDYEz
 VPVBFRmj4euZNkF8RzKEAmJyGRtaum5l3SlQfQ5f6wJqEmsCDk4Fkqy7tzd4xbxXLQIf0m.VCt38
 aV19q1gWLFhhKK6y47miDpGxC5pdeMcGvqwMe_xznR95r5Z6Yiv4xTeNsnacwiazt5Y3c4_zw0C4
 2AQH3jgGYAWSHw5VmAHCMxuXigDr03Ompie.GqMQGmx_j1eXi3TP.GHdG5cyzgxwIYAcR2Z2lRfL
 xSPDN9LWJRNJxpnNwfH3L8_3KAaFgusUIfhzWRQxRuWmfQJEZIehEZYm.wNWN.MTJ8EpE4z27m4Z
 BxVddXOE2oa6iPZVejsF2AXzQhLErIdcbbJ1IEG2eb6J5IRaSKLRVjEzjf3hc45wBz1Y7SdX4R07
 SlawPL2GLmRTDO0SrsT9CyouDXdw7.LYsSdqhGv7GLidt7Qt4FRSRZRbWBdgXTlygTEodnTga.Tj
 zz6eMf7KzBdmUj9LISblx3iQGfPC12NN.UhO200mLmeT_O8YXSrjubOVH4KKpFIe7qmz4qQ5tgzc
 FKKur1Zh28hy7ugc5ycpEsDCdD8NO.84FoK8TFjxUAn1oNZVSDe.4n1rPcb0Du8q68apxWEkTMDd
 pWrENzwkmVpbJRK5Jwa91xjuDJwbI0vPI4ukBYECfiyYRRELzRR5XigPSnRf3nyELgEBUD39sPH2
 JdP1FkGiy4_OVjc8_aS.j8583Lfa5ATjbgkGpHw30bEzEdBsJJazey2OxopM9LaANv4C7mMZpCIN
 sRbzSDawo7t1XWu88KTON69zdWy_jkXNvaSsJgWGfiQ.1b9V_yV3Ugj8KafwB8lnAefHthLcIgnK
 hUrG55z7UP_cjYtMhRBcGCPRXrpeslYB4CtUlZ6p6UspjPONJu4Bb0tUlmp_MZqUkdRk_aNn83Kn
 ZnANx4OnCSOqjyaVpg.YNBYI.eql43I98pzo-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic306.consmr.mail.gq1.yahoo.com with HTTP; Fri, 27 Nov 2020 12:24:30 +0000
Received: by smtp421.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 6763bc646fd93b3c71ad5c0717d830af; 
 Fri, 27 Nov 2020 12:24:26 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v4 3/3] erofs-utils: fuse: add compressed file support
Date: Fri, 27 Nov 2020 20:24:09 +0800
Message-Id: <20201127122409.7035-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201127114617.13055-4-hsiangkao@aol.com>
References: <20201127114617.13055-4-hsiangkao@aol.com>
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
changes since v3:
 - fix build error without lz4 library.

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

