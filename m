Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C182B2FA8
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Nov 2020 19:26:31 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CYP1K0N5GzDqRr
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Nov 2020 05:26:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1605378389;
	bh=twCqZTMU06SK6xJeAIit4kjiJvvuv8rPfMw4M9sjtQc=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=KupQYGJrH0GwRxHJFPULDJH/Lm8ktVx3QJL11UU6zSYmcmpwha+SUcEQAWvXrYAap
	 /9a/HpkkaqafO+f0sTkKHrrlkelhPkQ5yiCsiSq51XJmpio2JLQomAoIyPhOwHzIn4
	 H2BgNXw1YZVDQhCvsI3UoDWeMOLcCQzPDbQ8h+tJ6xoelvVMUUj17ORsPy52mc1XeZ
	 poxMM09PvEwwzs8KjJLfhkmEja6yXp9DXFlifPbBoT3oy5Dkh9zlvBMj8Ci9kdwEmo
	 l+vjP0Pj+HYwYeTresiMbYWdxCVIzdGgUEoqiiz3SKtfPDbGLZZ4claXE2aEoqYVj6
	 I+fuheP7Ry3tw==
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
 header.s=a2048 header.b=g+qIPFrE; dkim-atps=neutral
Received: from sonic312-24.consmr.mail.gq1.yahoo.com
 (sonic312-24.consmr.mail.gq1.yahoo.com [98.137.69.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CYP0q0wZSzDqRr
 for <linux-erofs@lists.ozlabs.org>; Sun, 15 Nov 2020 05:26:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1605378358; bh=ql+jaAtcT9x3YaspErDvkw+hl3UtnHEsIuyU2sW4I2w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=g+qIPFrE9I6pEaAS4IY6wYSCKXoxUsdhPamRQVFdpYMcJBWcGIq6On7hugGWjOu9BACwuICCmMd4dePQfnZDqNYsuOZ4wmWbSkspHVP311uZu3xIM/dJPMxYCwSY7A/Sw8gP1USEXciyFV0iyuIBRSUmf6Kfu3wgSvrJccLkjpkJMZD6a7J0xhHqPAuVWmH3UzYXna0+mJS9VLMEdK39/UQAq/tGHAHWOIk6ziBvLhsFa0M6uTTK3MARRk3O04uNqo3HlKcExNPCsjc5cP28Kj1tJWbT+UNG2rAn6pylHVh71VoQCnuPPxNYEyH8uAy7feFOInuTf4k0/J36zB2wxg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1605378358; bh=0KB/K8qlGzQITj41PmRSPk1wDcSCnd0GZqyUvSNe3bv=;
 h=From:To:Subject:Date:From:Subject;
 b=I+/VUrHQJy2XX/yKQMjZ25H62E0FkKmE8+bR1P2LI7JxZ3vEzB2xYf/KQ2TBEWDFvQRX7Ai/qXfYM0iCj2nyORtamFBxobMoX8ULwK55MduQPkWR39SqwaIkJ1NJiurTVWUseXFfsGWm+KZjYUQ2deUDOSqeyZhtonZCmoD2wq8IsalJJ4OvSe2xaTprU3sj8euEm5TK3nf2OJWtzExZW+kChRyDmVXcnYFU/a7ZUqo4s4ndNN8F3NATwZeWrBanh2fuLLhptV/nSB44DS6+nY0OojtWUer9EKUvgCM3PvKzDS4teBsk97YNmV0zyzl7WECsB8VLcyDqtKHbjQ2vhA==
X-YMail-OSG: NCZ1T9sVM1kcsHwqVZ45mjGJqs317m9NM3zQ3.5otgJyOOLnopHOGPwYFwjAAU8
 PqOcwT6YtEPv.DBwdkb1CklXMyF21swwoU8_MVQKUdDvVS4Kb8IO8DqGT4C_8BJaL3nQ9Cs_Bh4Q
 PGSJxBN_wHLj7QrelrsYTMRwqJW3Q327aYeoMydVOggEgPNuxbRCDIH83U_7u4WPa307jdvmPlkt
 v8RO4uVfLDew2j5OnOxONYzljctiWiJa6FLdWXjXBGmu0bzmcp5PR6D_B.hqCdnJZu.gF0yYAjA0
 UcYFNHpPR2moInlG.sT3HICYb5ZWJiUQFPKKHZ1gY9iJxefzy0nNpv_B6ANZlaO0DJstTlhQEExP
 sjAMkNBnX30Pa35dklcrcQS02YRKYi5GUlK6f.2LseM7cIrupwqpAs2e.MjSgTx7HebymcUWN.5w
 0IsE0Hooo1w1xA1dKrmZxxrxk4bJgw9E0dw7bYw9PtEVXW81nKIjTaQcQJZnOatAjy5o17Rz0bid
 .zb9s1CJQhNIC0OyfpdSMmKd5xx6CJp22sFmYS_lCBN0Djb_uV3PeB1XEEi9QV3EVZv9x_y1moOx
 3tgOzV0IxWNRsx.iZ4q8AQIOnrELcCM7Vcr1MNTjSBhIzbSFvpE4rAfex516TD4wCVLKyfX.WndF
 hWaCqCKLqvW8dT7KZuCgq0qHjxrAXgNV.fjw7qIQIS31ZJYtYe3iih1rdB1VNuqyFlCffiCzIDAy
 ivQoKK6LSLRV9oTMHUNbXxyBoUMVscUG9aOqA_hpT850TPKWXd.xIVyWPkXR3JWFJZQ9rlocvfD0
 HbjZEsbkfHHpHjJjIqkvUHexOXotdz8r8d5kqujRVaJgsGHITexqZedZb0oQ12EWum6d9mgJVOxI
 hYjGlS.0Au1qkqAytjGVLlgERV_MLMVDZsyriEL02a8oQu53fpIhulmDapU6PNzougT30_1ls0cX
 bfyN00vBYUPCfC5J2jXVi8M1dhH968EH0Rd5Bm33gMhTMHMASCt3E7FNQqxeGAcy3.EQwrPxtkQs
 x2BzhQwH2WnhsSysEJEh16mOViwgt04uh2abqnNyh5ZvKf_AJowq2Z55QOkppMdycRHGV.HCZgp4
 68sc4Pqrc10s1qThYY8D7i4lIjrjdd_JV3W3UOudw9r_okEMFOsfv9mKjWss1DJrI_y_C12ZQ6Wf
 O4w7vTP6T10lHFG20ec6bf0f8nkxAeD7VIFvhZfRysEz1hNtButEdfMoP3CHXecWuDPx6HZbCq4C
 Y8soxrCu2J1GjhisB1fS7OwHTQhvfSlGk91dhdr.DG2EeaA468nwZIt0QTDlTPid9IgfGOsTCwy_
 M2iVLmCejW_Yki6fNImmY3WcP8HK7s6gE7e9aiKvxgZ9d3effrkud_RLw9OPpDrL971FiBYNeVur
 pIHHxGHzCAFJ4NrRkxRoawt48cElVj7fgfNZKoPqRCPGbj8d3MocAOZqVeZrLWjozoqf2WJRO2iu
 WQhnI.u5.5XWv8kZSvJjAnoRy9Mbg7v5Yh.8emrBd5whkpwySm.LK7aLjqKNU0_EIDhZLIah0Qar
 .VwoChX2EU1q4Qpyd3paiuxNxTX5QJ8ve4WGzBGV7iYCoa2jBQedJDv3um3I6YgOEvdNeo15.1JO
 3oYHhNKmxR7Dp3bp9.pT0Rzr7VpsR7BZ2qEYD9N7L0l395NshRwpXHgVZ5u7DrpY5mXree13eNjD
 1Ed2_ZN.f_VDrpDsQJzJ_Ux0V9ROpk5Moxftcj0wpxwk8X3dZu8.gj.QF4jvWpguTMcGOevd7W5s
 ZLVG6K4hiW4oa9y0F3GHxkYqM_2eRnLpHZh64ul58lrjZDSEkjQ_Nz_rpnc6qr7kv.Ck0MxAAnph
 0ijSfGiE.Csq8kOy7mfj2QH1GTegMyRxrcUj920r9OAGfhQStsEXAUwJ6h8rqYVpSUdroAvGzIvD
 r2U82tCykZqo5n6bGBJ2hP1mKQ5pLtH6xm6l2ezo5GQNDpjGWNYktcGdTtWLepSmGkt9RVjIk_fF
 Dsn2_5Bi11BNnmXGmAdj.2a2WwFgQ_Vs4MFbkaAQ5vQWdl0mFlqYspijFLwxh_kkdXlciMQli6Ii
 Z4bn2dIqgoEC23U8WTCH0SLA_EbkylCk2ocnEyrlZ7NuOfH.lIdGvkW9rQD35NtHwo5S_Oqlv98O
 LgpOw02rXsRT88kjCzF41ibNpn1edttw5qzKry0zqhuZxiaRoeZ39xMfWa1Of2RBB9gKSdVCX_jD
 F0kzTOYuI75zkMNWFQFe5kJt76oSJjozBp9DJPdBIzXbJ52aYoo_rKRZ3GfzglPOlCieM.chsryP
 Lv_ESbgUd4ylNoCQclI6FmPhYDkCPC2bR3HHoARn.kIbVv1N69O_sdr_.y1IWoXY7a4UIof8yKNH
 H7vvnRNMLi2Su4IDrnoQfwjNoVAbLxB4YDVDxLAAZYxDObWghkGoFZrnWsh8Q8vyCmHYdM._n74d
 t77w1_HFIy6mGwL5QeNWlasiCTbqLPhXX552abqLTUgStUOnoOtuOhqct4tq..02ipE1SLFFlF5H
 yGl4pr.0SLBRgu._jpfc09NQqQuAVNHqumkZnUHTFrDX5x0WVIgpcP6ELuSjGZktxJrILdsbAHC6
 UhPDI.MLLVVE02h6eCufD7IvR4rt1dsm18HHfLGTnhrqd1YHtNpMoT0_i09LFvWk_3uwhVlVLNfH
 JUD.PTtUVK.SABggwSexb0rxFkf9scVbOxp3lbaCmijLxM7gafH0hqgyIldCZh4El9BYYquNOqax
 fANEa2uCtf8Jjegprgeh3OwJiORlH.v3EC4Jvnb2gSWrz9f6a92kW1VoN2EqekbZC.sA.EE7s5Gg
 aeShrkAT0vxJob7wU8jNzHOb9SVTl6BXEHxoy68WgY3hQ4VoR6Tg-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic312.consmr.mail.gq1.yahoo.com with HTTP; Sat, 14 Nov 2020 18:25:58 +0000
Received: by smtp417.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 85968d25ae8d25f4ff6dfa3538a98c18; 
 Sat, 14 Nov 2020 18:25:50 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v4 03/12] erofs-utils: fuse: add compressed file support
Date: Sun, 15 Nov 2020 02:25:08 +0800
Message-Id: <20201114182517.9738-4-hsiangkao@aol.com>
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
 fuse/namei.c               |  11 +-
 fuse/read.c                |  77 ++++++-
 fuse/zmap.c                | 417 +++++++++++++++++++++++++++++++++++++
 include/erofs/decompress.h |  35 ++++
 include/erofs/defs.h       |  13 ++
 include/erofs/internal.h   |  22 +-
 include/erofs_fs.h         |   4 +
 lib/Makefile.am            |   2 +-
 lib/decompress.c           |  87 ++++++++
 10 files changed, 666 insertions(+), 6 deletions(-)
 create mode 100644 fuse/zmap.c
 create mode 100644 include/erofs/decompress.h
 create mode 100644 lib/decompress.c

diff --git a/fuse/Makefile.am b/fuse/Makefile.am
index 0c1a24763f59..84e5f834d6a4 100644
--- a/fuse/Makefile.am
+++ b/fuse/Makefile.am
@@ -3,12 +3,12 @@
 
 AUTOMAKE_OPTIONS = foreign
 bin_PROGRAMS     = erofsfuse
-erofsfuse_SOURCES = main.c namei.c read.c readir.c
+erofsfuse_SOURCES = main.c namei.c read.c readir.c zmap.c
 erofsfuse_CFLAGS = -Wall -Werror \
                    -I$(top_srcdir)/include \
                    $(shell pkg-config fuse --cflags) \
                    -DFUSE_USE_VERSION=26 \
                    -std=gnu99
 LDFLAGS += $(shell pkg-config fuse --libs)
-erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la -ldl
+erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la -ldl ${LZ4_LIBS}
 
diff --git a/fuse/namei.c b/fuse/namei.c
index e79e77d1e3c9..5ee3f8d2a4b6 100644
--- a/fuse/namei.c
+++ b/fuse/namei.c
@@ -47,7 +47,7 @@ static inline dev_t new_decode_dev(u32 dev)
 
 int erofs_iget_by_nid(erofs_nid_t nid, struct erofs_vnode *vi)
 {
-	int ret;
+	int ret, ifmt;
 	char buf[EROFS_BLKSIZ];
 	struct erofs_inode_compact *v1;
 	const erofs_off_t addr = iloc(nid);
@@ -58,6 +58,11 @@ int erofs_iget_by_nid(erofs_nid_t nid, struct erofs_vnode *vi)
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
@@ -86,6 +91,10 @@ int erofs_iget_by_nid(erofs_nid_t nid, struct erofs_vnode *vi)
 		return -EIO;
 	}
 
+	vi->z_inited = false;
+	if (erofs_inode_is_data_compressed(vi->datalayout))
+		z_erofs_fill_inode(vi);
+
 	return 0;
 }
 
diff --git a/fuse/read.c b/fuse/read.c
index a55c0f2f78cd..10a26d84c37c 100644
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
@@ -15,6 +16,7 @@
 #include "erofs/print.h"
 #include "namei.h"
 #include "erofs/io.h"
+#include "erofs/decompress.h"
 
 size_t erofs_read_data_wrapper(struct erofs_vnode *vnode, char *buffer,
 			       size_t size, off_t offset)
@@ -38,6 +40,78 @@ size_t erofs_read_data_wrapper(struct erofs_vnode *vnode, char *buffer,
 	return size;
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
@@ -64,7 +138,8 @@ int erofs_read(const char *path, char *buffer, size_t size, off_t offset,
 
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
index 000000000000..ba5c457278a8
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
+	pos = round_up(iloc(vi->nid) + vi->inode_isize + vi->xattr_isize, 8);
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
index 77fa8d82c746..fc28d82490a1 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -36,6 +36,8 @@ typedef unsigned short umode_t;
 #error incompatible PAGE_SIZE is already defined
 #endif
 
+#define PAGE_MASK		(~(PAGE_SIZE-1))
+
 #define LOG_BLOCK_SIZE          (12)
 #define EROFS_BLKSIZ            (1U << LOG_BLOCK_SIZE)
 
@@ -160,7 +162,15 @@ struct erofs_vnode {
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
 
@@ -170,6 +180,7 @@ struct erofs_vnode {
 	uint16_t i_nlink;
 	uint32_t i_rdev;
 
+	bool z_inited;
 	/* if file is inline read inline data witch inode */
 	char *idata;
 };
@@ -233,6 +244,10 @@ enum {
 #define EROFS_MAP_MAPPED	(1 << BH_Mapped)
 /* Located in metadata (could be copied from bd_inode) */
 #define EROFS_MAP_META		(1 << BH_Meta)
+/* The extent has been compressed */
+#define EROFS_MAP_ZIPPED	(1 << BH_Zipped)
+/* The length of extent is full */
+#define EROFS_MAP_FULL_MAPPED	(1 << BH_FullMapped)
 
 struct erofs_map_blocks {
 	char mpage[EROFS_BLKSIZ];
@@ -251,6 +266,11 @@ int erofs_read_superblock(void);
 int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 			erofs_off_t offset, erofs_off_t size);
 
+/* zmap.c */
+int z_erofs_fill_inode(struct erofs_vnode *vi);
+int z_erofs_map_blocks_iter(struct erofs_vnode *vi,
+			    struct erofs_map_blocks *map);
+
 #define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
 
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
index 22bd73255d04..487c4944479d 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -3,7 +3,7 @@
 
 noinst_LTLIBRARIES = liberofs.la
 liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
-		      data.c compress.c compressor.c
+		      data.c compress.c compressor.c decompress.c
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

