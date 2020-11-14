Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3872B2FAC
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Nov 2020 19:26:59 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CYP1r45f3zDqSN
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Nov 2020 05:26:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1605378416;
	bh=//dTJf4I2A2XKC5FKyCbx9s1scQJfgAUMTD1L87SAm8=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=ikuUG1oRQEBhBuZezcRRe8yyPu5jMYTbYhnpspx/H4PW6nRYtxaivxXPgClDHL76H
	 D2fBi2zipJKhg2cM7wPM4wpMRIXz6XdphBqsFMl1AUR2nfNRufqKhnfE21OERycwdP
	 iSWqN+zN+cEJjjF4zL08qp8oeKIXxLDPGksGOWkTx5AqEsU7vzYzUJDTn1A0QV1KjN
	 ceVU1fNEN14aoYmPQ9/Z36ghFkcndaO4CPi/oaYft8ajf1QUAQIhikHvTE6UZCFjrT
	 JDE/oQxK/GcV2+p57x7V8DbkzY8QeAaXisoMVdq3nN6hZ1A3raa8Z5Ngr3ms/5I0Fl
	 BdxOUwcrcC/9Q==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.30; helo=sonic315-54.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=DIyvARdZ; dkim-atps=neutral
Received: from sonic315-54.consmr.mail.gq1.yahoo.com
 (sonic315-54.consmr.mail.gq1.yahoo.com [98.137.65.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CYP1D0Yc4zDqS8
 for <linux-erofs@lists.ozlabs.org>; Sun, 15 Nov 2020 05:26:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1605378381; bh=GgN7jEnFZEGeD+ESpOW2nMNJ8GPd9MSG6JaOiAojUjI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=DIyvARdZSnbgaOxN32Ub/aV5dM4HJX72c/eYM2kDO6D4KcTndrzwQnwhzA1qbQPewkDAXG+b6WwWcfonEU+jT83E4a6OmUIIadG54cbJxGYjRqaatFDRx7CMiaOnfgdubsJEqpyKeneanTT7NZXJ4z2mB+wNVi1GE7kZDzQ3+7Y0K3d4/Krb+ZX0lbqAGSayWjYv3Gqa8sIPLB4eNLsMm7z3QSLEom4fl+veEJuXVz8sQ6+VKNosE8liqTTVV1G655To9LlWm6sroYVVnLE3KI3gZM4SV6YvJYx83HKpPUvrN+KQ5j8C1mt6BI034OQOm9Hy0/XNOnwDHADHraGCxw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1605378381; bh=Uas4ci1vsUW2wUBklkGzuKjwV1zo2gqpN4Mjrko0rkH=;
 h=From:To:Subject:Date:From:Subject;
 b=CHuNwPe9qmCzzmYb64oNdXFoInqqnrtY2aZMMnnXBdrvou7AU1AtSTcVOIHkukI6dk/ynto2Nr4UUL4dYq7/lKo5J9+CRMc2CiWias5J3TNljhLyT9T0N0FepGMBSGZM8nDJb0anbimOd2eDCx5eXeYkQaj0CYy6Wqn9EiZOeXoJlARoAMw2YTFEJ1bWQRjGN8sUsTleWsgQuVhZC7lV0ZQBXACMI23SWPPcJp0cBUxkKFkShv+6xYeQRcBSpLJ48skKrAyeW5q9fWrgOvgy0IWpqJ8CdehlVl3qe0WpJ4F24KLGZGR0Dk5rfp65/Ypz2VO6q71hAmy1fG6hMsr2rA==
X-YMail-OSG: zHQ0YH4VM1ljEVpLXlpSSwBMH3BR3TrZzydNQhruK6zsV.9Y4om8GgkGqnKffxz
 0QfSCbu520yCTxjp1xfzZsgpAHL_ep6k2WNped4UVlCkY.N4bua4vy4L6H763SRHXRRiRSJKqpyA
 hI_OyqUAmA55WcQ9oHtDP8Kt2MkNHDX.DKX.jgr_a7pQLx0KgbfyzUl9TfSFe7fKuGrCnqSJQ6r8
 mZQBP.Q_Q_vJqEERifcuMIJZbYIBrihjq.08UHwEReiWgzXnXm5wPq__6QnHhkqrBE5D5hZAubsI
 doR8t7tiZWJTmKYbYx_U5_lASwdNd7qH8bwrSJp_814N2MFMDDd99JlGWzq9Mq6N6vc2rvv7_E58
 Be27TOOa2mhmGmDilX4ps1GYHNM5xzbhW776A4A58nnBoamPohA4AnEVAr6wZBa.6H8x0A.Tb1GC
 .n3LrT9U4cqEtzojbPBh4I4y39LQmQBYksCg2eHuxsOT0rJwVNiA5ISFO6r0_4qH3m7SE4CUcLHO
 cOEqFhsz3n7zOZfPG5VpJF9FujpkKyHcYdNl65qzBadAhio8MyckVQ3dKE.e.oRU9Qv9Kc8j1eO6
 K1gyiR0O4t3rahkF4gw_GSplP6xXSiFrR122UxzR4C0cuh6Ow4q6yCOKNif2uvrXYcjSJze8AR7m
 ypf.pOCZz5MoU_slFrXP0aEl1UuVh0N8hkuwLlEIFXPbu4tnPUAL1MZY_QwGJ4w0YSAW5t6SGICx
 CaZWXlaSWge.fzNQ5HM2thtqv70HtoHBd1pfe4mcXIXzq.1Ac_bSXtbyKnyyuqyA0dTMDrIDwhzw
 iScLzei0VcDA_lEOxTicIpVC5X2Kcbm768A.OT_OZkCHuQYm2qRq3jKVpbyTt5K8c0IWYjz0veAF
 .nDkVi0cmsDImUHOFzNuJRdODSCP5y0Bul7fxCDLBAKnZXaIPhr.6S4psHHfd5xGq8oBbfNMp6R5
 nffi1BQ.55JI5GQ8_TO18OuxOmrBZ1_qH2G7o27x40YLvXe0SUGAXc2CfvnV6b90seVuJSe_XA.t
 _A_9AgWHEfXleMoEIgrMOwunAOaCCqOwRve0PZNoiLuwzZGe4KR.cXsFez5Y.0N9NT02VT5gHSNN
 VHw9GckJY4_nde3seAHh78amDUXz0DoqLlxsjV5wgGBRGgRp0i..eCbk.IQPMRBZgSgLOBg2MJvQ
 Tr2fHl_T9W6qeyr5M0He8r.qU0ggFCbNyZ7rSITQFNu9j3KWrM8b2tMNatXmm4IT2NVIwx1oMRWa
 3zoeofXJ8DLjLIXMYReApGCPIjQOLkF8wgmZEY4uNXy74noNeI6LAaogcSnqIyVdE2z.tC6JCIYf
 fItLfTMSqcfZQnqd3xWzG78OLT7D78QOOAA0Gd18sOLB_PxU8IcsgLdEqA2fiyjGlqEtePxxZo8q
 pCOZfBzSZ7qZqy15YXGmBdJDq9RzAWKkuDnUMQ6_X6gy35FMZEM2z204IOoYr1BtJFVN9usauqCD
 h.K9IR4XEMVLAvo4SBI1EVG1SzAdvRIXWPteqC0R7naqK6mi.lY.Q6Ni8ooE7CJWgbIeSnwJ59Ty
 .q88gtbl.niGCw9DR35TWsi8qNeQWqGPfqqfPkK4YJbUHtKf6sWjrLIneb51zxxCgL7fTBtuMvh2
 vosr4ZCLVt1iEsDw4SnIUQHXk29GnSA6t2U4KscrDhDwr9iEDeqQaLz.4ay4ueLaXjh4AWfHxWyd
 ZuYJiCk1nuvsJZsL4Z9B9LLKQehUhj1C6yztRIQ2q0o1u9fCJqf_Cnm4ZEIP81eTBH2D3KhYciVi
 mQRs8qjX9MvsR1HFj4zifkUxi3HuVXqiUOYHqOFbGX94lKrsw0bXKrdpionX8q8LfV1RFALr5cJw
 aglQXZj6iyPavfD_6LSXTH2MQpkylPogerfLd13lCFxaOHOUtUdOjUN_Cw9fyIRuWzVG2MPSxrSv
 IRMf9uZyebaeLfi9YKeIZYStVkMZR7WwYFu2UpwmzZSO6.aNdLWe_7Z0a.cT.oGSTZr3i3cH.IIp
 NxQKUA4plDNVWLKEnLwUBsqt3AdBdjljDPcjStFQaGQhfV3frMz2wcGXsuo9AdQgTQo3ogfu0ufc
 HSGEw5gqO.3EkbfqDbEtzHK3ldWHK9XEkR9r6tTXC_lMCS_PietSR0m4dVNpMRtdCdgtfWvYCtXA
 etfHNnAFPcACKaMRVIZg39e4FXtgFdtXe6seJ_mQmX3kYrFOCqeaf4.Qrr9PtnEchn7v3CpvHsfM
 mg9_apbMMkDNG.udlUd0f.DI0S9KyWORo22O4KaLN_rN8gC3ZwzO3S.c4laCz69iZ_kk9KA9kP_p
 h998wcsA3iS3.zRaQ9tQ4L9s0VBIQauqvYkVajvhBZVZD95niUUmR_22IoNF2MaOiPf92enc26lw
 DJzIdSQ1ommrXoQ8yAy75FTp2.Fsw2VgQCJzsPbzJsEilxQMb9eiwefUBdyNXE_5JYzNalMyUA_B
 BwVfwsd8uFiF8YJDJpSAtFyYVb9bK_.rnh8NsDQFhr2I.YduHygOVwmc1Qb.w8_MeS35C23yKQdU
 20GLGLR9gc48AUoEAuXUAvon5lXIc_JGcCF_i.tfriRfFVATgzXXGIQqnjUQugrP44qCeqtE.NjG
 jUMfNLwM65GJVvCy.NIDMQ3ZiVwUxcA2RVcDD5HqC_UlNtYq4gVWflRYm85u80jL61XB79ASVt1u
 UQWrnLg--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic315.consmr.mail.gq1.yahoo.com with HTTP; Sat, 14 Nov 2020 18:26:21 +0000
Received: by smtp417.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 85968d25ae8d25f4ff6dfa3538a98c18; 
 Sat, 14 Nov 2020 18:26:15 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v4 07/12] erofs-utils: fuse: move namei.c to lib/
Date: Sun, 15 Nov 2020 02:25:12 +0800
Message-Id: <20201114182517.9738-8-hsiangkao@aol.com>
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
 fuse/main.c              |  1 -
 fuse/namei.h             | 14 --------------
 fuse/read.c              |  1 -
 fuse/readir.c            |  1 -
 include/erofs/internal.h |  3 +++
 lib/Makefile.am          |  2 +-
 {fuse => lib}/namei.c    |  3 +--
 8 files changed, 6 insertions(+), 21 deletions(-)
 delete mode 100644 fuse/namei.h
 rename {fuse => lib}/namei.c (98%)

diff --git a/fuse/Makefile.am b/fuse/Makefile.am
index d6e6d60cbfdc..f37069ff7f12 100644
--- a/fuse/Makefile.am
+++ b/fuse/Makefile.am
@@ -3,7 +3,7 @@
 
 AUTOMAKE_OPTIONS = foreign
 bin_PROGRAMS     = erofsfuse
-erofsfuse_SOURCES = main.c namei.c read.c readir.c
+erofsfuse_SOURCES = main.c read.c readir.c
 erofsfuse_CFLAGS = -Wall -Werror \
                    -I$(top_srcdir)/include \
                    $(shell pkg-config fuse --cflags) \
diff --git a/fuse/main.c b/fuse/main.c
index 6176e836c2f1..fee90154a251 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -12,7 +12,6 @@
 #include <stddef.h>
 
 #include "erofs/print.h"
-#include "namei.h"
 #include "read.h"
 #include "readir.h"
 #include "erofs/io.h"
diff --git a/fuse/namei.h b/fuse/namei.h
deleted file mode 100644
index 730caf0085f7..000000000000
--- a/fuse/namei.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * erofs-utils/fuse/inode.h
- *
- * Created by Li Guifu <blucerlee@gmail.com>
- */
-#ifndef __INODE_H
-#define __INODE_H
-
-#include "erofs/internal.h"
-
-int erofs_ilookup(const char *path, struct erofs_inode *vi);
-
-#endif
diff --git a/fuse/read.c b/fuse/read.c
index 4e0058c01e81..2ef979ddba63 100644
--- a/fuse/read.c
+++ b/fuse/read.c
@@ -14,7 +14,6 @@
 #include "erofs/defs.h"
 #include "erofs/internal.h"
 #include "erofs/print.h"
-#include "namei.h"
 #include "erofs/io.h"
 #include "erofs/decompress.h"
 
diff --git a/fuse/readir.c b/fuse/readir.c
index 510aa7ebaf11..a405dd702d84 100644
--- a/fuse/readir.c
+++ b/fuse/readir.c
@@ -12,7 +12,6 @@
 #include "erofs/defs.h"
 #include "erofs/internal.h"
 #include "erofs_fs.h"
-#include "namei.h"
 #include "erofs/io.h"
 #include "erofs/print.h"
 
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 573ebfc298b5..7357ed75e3f8 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -241,6 +241,9 @@ struct erofs_map_blocks {
 /* super.c */
 int erofs_read_superblock(void);
 
+/* namei.c */
+int erofs_ilookup(const char *path, struct erofs_inode *vi);
+
 /* data.c */
 int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 			erofs_off_t offset, erofs_off_t size);
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 7d9446b3cbcf..f21dc35eda51 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -3,7 +3,7 @@
 
 noinst_LTLIBRARIES = liberofs.la
 liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
-		      data.c compress.c compressor.c zmap.c decompress.c
+		      namei.c data.c compress.c compressor.c zmap.c decompress.c
 liberofs_la_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
 if ENABLE_LZ4
 liberofs_la_CFLAGS += ${LZ4_CFLAGS}
diff --git a/fuse/namei.c b/lib/namei.c
similarity index 98%
rename from fuse/namei.c
rename to lib/namei.c
index 326ea85809bb..2e024d88d93e 100644
--- a/fuse/namei.c
+++ b/lib/namei.c
@@ -1,10 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * erofs-utils/fuse/namei.c
+ * erofs-utils/lib/namei.c
  *
  * Created by Li Guifu <blucerlee@gmail.com>
  */
-#include "namei.h"
 #include <linux/kdev_t.h>
 #include <sys/types.h>
 #include <unistd.h>
-- 
2.24.0

