Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 037822A2EC9
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Nov 2020 16:57:21 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CPyGk1NvKzDqRd
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Nov 2020 02:57:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1604332638;
	bh=Z80GcGluUcpZhNTTftFRsDFRlWrgL4tx6pOFxdFmA+4=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Fy6VXU6TX9oLc8Q5uTD0Inu2S6Hy4bqi5iPklF6WLTcpf+Ay7hCmDzur0GxD/SFlZ
	 PjMfEz81n4vye2XmSHrIP2Bb7UpvUbfGYLM6qDK+6a2BZ/u7lHRntWjDotnFurpWIr
	 oW4JrCQRPDRiVhZ2ENaNnrpjZLptyHB3zpJGYzs/ComNaSDe43n/VkA4iWK+pHO2DJ
	 YC3o1I36Fw71aP3P2btu8jtr0zFTDNqwlPFOZM/r5H00hxH9+UDWAnqlRmMgcROuJB
	 Od2EMpep5uOQe7CRZ2ROY4x3dpRe4NaPbGNKqBEHgjt0SRdyi1/5ZKfOso6f9qSnvg
	 7r8A3Mpesm6yg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.69.147; helo=sonic310-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=W4uG4GAj; dkim-atps=neutral
Received: from sonic310-21.consmr.mail.gq1.yahoo.com
 (sonic310-21.consmr.mail.gq1.yahoo.com [98.137.69.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CPyGC44xfzDqSp
 for <linux-erofs@lists.ozlabs.org>; Tue,  3 Nov 2020 02:56:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1604332606; bh=c7vVJxYOOeU6bkhSgFoFHmBs9uZAAzMlWq8soAzBhKU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=W4uG4GAj57otm9gXsAlUeTvtjsyPmWTVdyYhkdiDVMrkwDHz4VEMDp4BeBMUiBgu/4ufSMbdONVOSbNan7DzC2Qvzioj6M0KI5R+XxU02ohaSMWbPWH3+8ldA3aj+5hx784blIULK5ddXW1te5l36xcS0QVCKE/zDuvBKsgDbG4Pk4PQHjsX1Oe8d53bvdX/lhHz6dfsk7lLvakcZp1eh45sFXLDOprgdBx7iSOe5XnDrU+nUPCa+BeMO0s/aU9vfGIiJ62V2W/98CV+zqjcEU9ARZimruePPw3L5+btF5B6b6070VbD9dHjRz06JlT5Lutw6U5ysrwnJxIpyntWdQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1604332606; bh=0eM5Q2yG+hJ4Wcf6hSEiEMi439eJBfqhTizmUE5GwaS=;
 h=From:To:Subject:Date;
 b=mQVQ8z05tQlDZQmSeFNLZet49cuA1QR+nn107ZuXeedybm3p0RMCo/XvVfPF9hHq3oLPgsbW69W9FH1GHH4dxJe+rqbgnrtTSTpw6jr21PeoKqkdbOVEiLTb3gE6MFEuIuw13ljsxC3dYc1981H6TWzImmNDKBMsFji6bEo1vu6Zyt48ryKmxymDNpMG+M9umzF9VEd0Mul4lb6/oJvrtoglK9inUMz1A6cpSibw9b5VPPpn6KhEX1N++gFR7wedfgKkXXYraaT52N7AszyLtwPwJiHDvrYjk4XiKlThIf02vYAX+/vwKp9DjORY2WJGGKJjh/UDuMCFGvXDZdHJJQ==
X-YMail-OSG: 0BkuFiUVM1kmgAveZ8_nYCgl4dk4Cdn22HeyEMl9oCM7OMChMz4uqFbiI.9cOyZ
 VANxOGt9H3q7I1ojv74wUMsINuP82gbHdrHMzcT3Q1N8JPZdSCkEak_0v5xsg5C2dSiImyj.nTqT
 F9VVir59A._tSy8m.EwIXvCh2s46CS5bl0PuaV635DYnxEB62pm1gt72jYNmUa00NMkWHonO40A6
 jn6ssG0GvD9_248uz0UBAXvpG3wRGZIYbL5ge6e20wILdUzuDBRZzaKRVrJkrG0lx3aqmBOmdI61
 MpTwLLmVednfj6bBc3A0a2YOXfQM3Rrf49kPRHlNbvvbrjEzr3feJnhFQaX4kLuypWu.cUf8aG5s
 akxPAgses.R_51i0rtcJW.rplDILXmpSPZdYqc..PraSmm.2jkZycJzu8Wz.v_eVL3ILXaopxQVc
 rDn9FLc_Ew0rHvv6JldxYLLKv4grlwnOlEq6nBx4Evx63QUVQhMMRdym8aVfo_iZ3vXr5iaqAmUp
 B8drxVrBeHdlqR5ofmSh2TRwrmtqy1AWQGQbF7FLLY3ZadXFf1DB3y4lrGqhIuxA_vBVljPBAuRV
 .ktK65.H8_hqb.cikUlfOrCHNmJ0izS1YmDp6oV0oCQBnEbJT6edfqvOJi5Mpu.Ysik3ldjyM1gM
 JA7InX_zQZxKbZc4.9cHh9A6u9sp1X0SpF4Jev6Rk8TAzugT0uUjQKEjGRTDKEdkbnqCHFI14._g
 ZGDPmgIKhZKcoz_RF9t0jPKkbMiKSbl47wWsDYc8B5FBrWAsH82pUd4u2oDfdYLLq2uPg10ZneaD
 2cKz4JzFleloizylXLtgS9Yq_H0YerJRMID0FUpu5J8IuHLwn2INpZLf38Ka9nA1zYcHpa77oSyy
 Z799iQDGxbr4GxhmEdcCcLlRQeyHmYa7n6rHPcuZKBC0uVOnZe.YVsS3CEF1rONOLuz3NgDmKDsP
 UGhv1W5CPxAt8pU1A9RzcDeeOX_UvjF8u88WNKdT.nqU9tcv9LoQyfWbDfgxIZwUWNB2twMcI4ln
 cg6Q4NyOjdhk8o3hvZX.e2MtJyi7ULcv6_HWy_Q5KMiStDR6zS9AYTzbiRO.Qg02qZBstEBbtjMQ
 1jTwL2qaJD1G6Z81oqKkRQrg3qDe8l34a3vkj3hVG4NXV5JsH6VrKHJS9sbhW_cIT8ixUSF4_RWM
 oXLzIqJF19Vx6TPW5x63kB6ArSvV82SkfzhtgQa29rXpSAQHNNZuvuGx.f3sy6PKd_tzNLyNcn7p
 h8Zmj5lSSUmf9G_iyJS0NSBe6rSgBvZ5U.79VazNCrRfrnuWe__c4FA_5sYWmeOxOjDqCc4gttjo
 UngRsfrYYE3L5e_VMhom15dV91y.tpduVVw7_qzuZhumLcUvi5G_8kUtTuGECYcGaD5ED_GxARn6
 QPt3dbpK_bddV0.8DVAQygOrqqBR7RUjdgqTWIpVDc4RHTf984ggUStuFmGB7iU3cDAJOf7spPuQ
 pCGG1mtTalXDDN7XKyaDL9Z8ZvfuxC9TsTRNJwLUTDAUoDAzev_qKMHQPvQmqf.frYl6bKijg97Y
 ziiQmcE0e55haO7WEfY35P.85P.FysUNbjXcNU5FuSGdOo9AlaD.jqrzwCuv7vuHi0FUX5T_Tora
 zpkUC4w8nnMA9c3cqCLHZTrF1PeX.T973B1Efd26AlqJKM1GqsbUtzJKTYtu8NcOmE66HQpMseo2
 aLlm41lLf4CUAbMcaT8oLvF54XO9UZVgY_Oy4tfqjnavxTaTkbp0WLN2sXO8VIN.m_34dR.7DmML
 hW8qabfX6RDn0sLndQXeKXdvhOHFgX7VpOXDX0oUK7imFM2yzURXuxwmDshJqBJQjapPpISTbwFy
 6qThvP3R8R.9BzMP1x1W3ANqnU3JwrXigVlVJzBdt5EW5721kdstP.Mf1U89_j1mguGppY5xKmwt
 pKCxYQW1SqElS8.vQroHUV1toN3RohrEZ_FXFPqQqH8Uzk7ZHZhsa3i6cm5e.KDQUV5uGUpgqx.G
 veCNiH6xqbft2VMGwZr.QJqXt0QAUIWK2Qdiw.qqsSCY_M1kxtF0wNwce2YqotnrmaWluE43lohM
 pxgIDqJbc7IH_0B0qjO_hFMoqvfFx.6X6qO9QMCIWMEdtJzVtp6CB3LDl8xMCVsO17GkuH5WA2mh
 5pOa4LGifhnbkxgtCN2zHsy0HTdzxZjxYeSUr6C7UU2dAokxVrOnxLQYalmqTpSzl7Y2qva1IGKc
 NnXi6HDwceqFLQDbE61m4bfOcHOc5mUZILCJGRJ_a5TrYCy0rwQlEs1yCtCAUuLZVKVVDdeHbDGA
 g9tY2w0gRn29kSgKbp13D7iZNh_iCSP9YSe9.vuX7xnPqQM7zCD0i4g4_b7AJVUfpGvKs8btajU2
 _ImTzEcH7iUQPx2C7HEcqnnrTQPxvPwsenyOWp1xzThHIehhy2GEkjcB_To.YvNVvBsmep5TZt2.
 OLNq6T_9cqASc1ESK.rOnfNQbmirBFqMppzvE4htz6zYzdguHl74akD7ZZnxQ_QPWPXkU3RHuqLE
 Jl.bpq1KUHXZ8vVEpWReEx2q7hFG9ozYTxdJhrORPrwYc2Yhn78qLoL8WLwow8Oxqf2JuM8Mvgmn
 9pBYNI9RhuqwmGdoiN1YuuPgRtR1lN6QkWZX_OMHunSmpUsGST04AFT5gk6LlLr7hAdut1dK7FGf
 gxHvFtgfw9atmIyswsjtzA0je7gIYyQ3uQR_PrGPlWH1hjdxqT4WrAmMvi9nbDs0LS3zkIcvyT8B
 vFoAgzyrdpDMI.2FpceM8l2Q7oIhGT2B.6QWoT5oNABQ61sKnqgpuUfauU_lXwQUld7QfZO2q7lr
 WLbKbsREHvs9Qg6.EdI46Q9VhTRnnCO4Uqbo6K95lEr4duJAW
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic310.consmr.mail.gq1.yahoo.com with HTTP; Mon, 2 Nov 2020 15:56:46 +0000
Received: by smtp404.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 0de93bd81f6e7581799539af1246db07; 
 Mon, 02 Nov 2020 15:56:39 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v3 03/12] erofs-utils: fuse: add compressed file support
Date: Mon,  2 Nov 2020 23:55:49 +0800
Message-Id: <20201102155558.1995-4-hsiangkao@aol.com>
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
Cc: Guo Weichao <guoweichao@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Huang Jianan <huangjianan@oppo.com>

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 fuse/Makefile.am           |   4 +-
 fuse/dentry.h              |   5 +-
 fuse/init.c                |  22 ++
 fuse/namei.c               |  11 +-
 fuse/read.c                |  77 ++++++-
 fuse/zmap.c                | 418 +++++++++++++++++++++++++++++++++++++
 include/erofs/decompress.h |  35 ++++
 include/erofs/defs.h       |  13 ++
 include/erofs/internal.h   |  43 +++-
 include/erofs_fs.h         |   4 +
 lib/Makefile.am            |   4 +-
 lib/decompress.c           |  87 ++++++++
 12 files changed, 714 insertions(+), 9 deletions(-)
 create mode 100644 fuse/zmap.c
 create mode 100644 include/erofs/decompress.h
 create mode 100644 lib/decompress.c

diff --git a/fuse/Makefile.am b/fuse/Makefile.am
index 4921a4363cbb..2b2608f57b03 100644
--- a/fuse/Makefile.am
+++ b/fuse/Makefile.am
@@ -3,12 +3,12 @@
 
 AUTOMAKE_OPTIONS = foreign
 bin_PROGRAMS     = erofsfuse
-erofsfuse_SOURCES = main.c dentry.c getattr.c namei.c read.c init.c open.c readir.c
+erofsfuse_SOURCES = main.c dentry.c getattr.c namei.c read.c init.c open.c readir.c zmap.c
 erofsfuse_CFLAGS = -Wall -Werror \
                    -I$(top_srcdir)/include \
                    $(shell pkg-config fuse --cflags) \
                    -DFUSE_USE_VERSION=26 \
                    -std=gnu99
 LDFLAGS += $(shell pkg-config fuse --libs)
-erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la -ldl
+erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la -ldl ${LZ4_LIBS}
 
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
index 802771fc69a4..c6a3af697532 100644
--- a/fuse/init.c
+++ b/fuse/init.c
@@ -18,7 +18,25 @@
 
 
 struct erofs_super_block super;
+/* XXX: sbk needs to be replaced with sbi */
 static struct erofs_super_block *sbk = &super;
+struct erofs_sb_info sbi;
+
+static bool check_layout_compatibility(struct erofs_sb_info *sbi,
+				       struct erofs_super_block *dsb)
+{
+	const unsigned int feature = le32_to_cpu(dsb->feature_incompat);
+
+	sbi->feature_incompat = feature;
+
+	/* check if current kernel meets all mandatory requirements */
+	if (feature & (~EROFS_ALL_FEATURE_INCOMPAT)) {
+		erofs_err("unidentified incompatible feature %x, please upgrade kernel version",
+			  feature & ~EROFS_ALL_FEATURE_INCOMPAT);
+		return false;
+	}
+	return true;
+}
 
 int erofs_init_super(void)
 {
@@ -41,6 +59,9 @@ int erofs_init_super(void)
 		return -EINVAL;
 	}
 
+	if (!check_layout_compatibility(&sbi, sb))
+		return -EINVAL;
+
 	sbk->checksum = le32_to_cpu(sb->checksum);
 	sbk->feature_compat = le32_to_cpu(sb->feature_compat);
 	sbk->blkszbits = sb->blkszbits;
@@ -56,6 +77,7 @@ int erofs_init_super(void)
 	sbk->root_nid = le16_to_cpu(sb->root_nid);
 
 	erofs_dump("%-15s:0x%X\n", STR(magic), SUPER_MEM(magic));
+	erofs_dump("%-15s:0x%X\n", STR(feature_incompat), sbi.feature_incompat);
 	erofs_dump("%-15s:0x%X\n", STR(feature_compat), SUPER_MEM(feature_compat));
 	erofs_dump("%-15s:%u\n",   STR(blkszbits), SUPER_MEM(blkszbits));
 	erofs_dump("%-15s:%u\n",   STR(root_nid), SUPER_MEM(root_nid));
diff --git a/fuse/namei.c b/fuse/namei.c
index 99e5ffa34858..79273f89be1b 100644
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
index eb771c75baa7..11f7e6161f8f 100644
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
 #include "erofs/io.h"
 #include "init.h"
+#include "erofs/decompress.h"
 
 size_t erofs_read_data(struct erofs_vnode *vnode, char *buffer,
 		       size_t size, off_t offset)
@@ -77,6 +79,78 @@ finished:
 
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
+
+	erofs_info("nid:%llu size=%zd offset=%llu done",
+	     (unsigned long long)vnode->nid, size, (long long)offset);
+	return size;
+}
+
 int erofs_read(const char *path, char *buffer, size_t size, off_t offset,
 	       struct fuse_file_info *fi)
 {
@@ -105,7 +179,8 @@ int erofs_read(const char *path, char *buffer, size_t size, off_t offset,
 
 	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
 	case EROFS_INODE_FLAT_COMPRESSION:
-		/* Fixme: */
+		return erofs_read_data_compression(&v, buffer, size, offset);
+
 	default:
 		return -EINVAL;
 	}
diff --git a/fuse/zmap.c b/fuse/zmap.c
new file mode 100644
index 000000000000..9860b770362c
--- /dev/null
+++ b/fuse/zmap.c
@@ -0,0 +1,418 @@
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
+#include "erofs/io.h"
+#include "erofs/print.h"
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
+	ret = dev_read(buf, pos, 8);
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
 
diff --git a/lib/Makefile.am b/lib/Makefile.am
index e4b51e65f053..c921a62a8b23 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -2,8 +2,8 @@
 # Makefile.am
 
 noinst_LTLIBRARIES = liberofs.la
-liberofs_la_SOURCES = config.c io.c cache.c inode.c xattr.c \
-		      compress.c compressor.c exclude.c
+liberofs_la_SOURCES = config.c io.c cache.c inode.c xattr.c exclude.c \
+		      compress.c compressor.c decompress.c
 liberofs_la_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
 if ENABLE_LZ4
 liberofs_la_CFLAGS += ${LZ4_CFLAGS}
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
-- 
2.24.0

