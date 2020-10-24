Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 369B4297D24
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Oct 2020 17:28:12 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CJQ3F18JkzDqv4
	for <lists+linux-erofs@lfdr.de>; Sun, 25 Oct 2020 02:28:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1603553289;
	bh=D80Kj3h69XFruWZS+9TUuO3any54+gqxpbXZN0vDsbo=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=LpuTw9bUhwSo/yU3hECCLbHiP/gWqUPtQu0QmA6GC4UlTv2JK4JXHyipnqs3sWzvU
	 dinm9Y1ZHrGhyxFYgYDckMUJRhFG+pvhRu/0NKcpomdPPW7mcnHiJQU/zxx9r727VK
	 +aHrZS+TPQ/LOIqrjEGeADZRa4MYq41pyf38Ae1xeojQhr26dnI6fZjJak66ggP/Xh
	 k6Ul/Ydjl0J+9lSHFSTICp5fVSCdrG8QIDHQMe3ZYV9nwiRlGCx1EWjLCfAOzERgMR
	 yQBupveSPXeLQaTdEpoKKRkjWWZGJoUZ2X8vWk1KLbNrL4mw01XYe/Ur/f7RIcE92J
	 1j1gm4Fzy76rg==
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
 header.s=a2048 header.b=P5+/eBA5; dkim-atps=neutral
Received: from sonic317-20.consmr.mail.gq1.yahoo.com
 (sonic317-20.consmr.mail.gq1.yahoo.com [98.137.66.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CJQ2z2mmFzDqsx
 for <linux-erofs@lists.ozlabs.org>; Sun, 25 Oct 2020 02:27:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1603553269; bh=51IpFUyBpLZ+sQdgIbaD7KYfYNesYHwf4nsJIOKrpY4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=P5+/eBA5Rr4sfNJSqatdDctj5CKGW0EyKgoB6td7GGPMZUDFAiBSiUxfoqh36YYw3nZfsMPoDb/EbKmLX/8Th2SPL29ppe8AJCJcQKaUOFfWcVS+P474xpuxevO3Wonj8guIoCmvMzwTrC4aRtkdrUj2FWMyAq8pVGhsg5k2BfPVbs/f1dnHwC6x3xeiHU8eRjVmFV4BEqFp+QT8wmWtvhho1U2fGWR7ZyJaIC1p7J9a8lwUO/fz0dj48DDeJ8IX7JrIHbHOpiLmSVi5ENxUF87RlNYHsHcPbmNsORTqzWkid8+GlsJ9diJONfBq9fgQz4GudrJC++NWVkKqHvlJoQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1603553269; bh=T0M7BlF1wbIXBf2j35YsMU1B9P3OKp7k/1UPNGYsXTs=;
 h=From:To:Subject:Date;
 b=hCGEWOV7YpNXW8sYc5iVXBexS08NGYrcGaQAtPEFkzt05vOdbacggAp5h19jGchuwdHkvVnWBu5s0Oc12QJNIYvbwQbL0AkE3EYwblXm6U9KH42MIDhAaHGQed7CNcCK7RNunQbSyXygKkqykGre9lijDtsSh2cRLv5lyagBJyVUG9GXEWqwyrliYWRJOq8WS0P8Ju4aYQOlpykz6soe1hFjbNavmGmwWl8gX35Q1J36rCn0BiAbVa6cnGcYsoIMtoc6lZWmujHHKaRwLdtLGZq9RI5JW/PHZnW2bJBoAbh+Mbzikg23O+8tE5PZNXUKTPvgsF+FkznUx3cfE+WjrA==
X-YMail-OSG: 5eN3IYYVM1lu4V7LI86.m_ZPksvSc4QCg6pPyIxZLItdelOIQvoe6GMHd3onuDW
 0YERJ9moFQh8I4vzYo0KWtPN6PlQ7eU4D17sd1PBPR0wAmiu72ntlr7BOnmLgURuWQc2vDjzhq9V
 a5NjCb39klKriyIkGHxJnBRL6GjkG.ANlziM0CCrU2gkPO4kmKC4Wv1bZVvCPjOzFEZd0zzouXxp
 9e8hUyK9ysQQiepUGQBj8NtKp.xJ.GxNkagPWbpyv3E82TECQgRC2uWd.5qUnqjKsjdZ0yWlJcnj
 0wGihRrcukyZkbvTaLIZ6V4wcRILwQs78l4n5oJMP3tsALfFviSmuYqPYt8n.LbNV3Y6JIfOwUU3
 _MwOVqthNbCeNz89YRmV4bGBJKGnqmXkApbZGWK2xeNHflrmNKFhXs3GptUkPviSWm6nq89cC_Qw
 fDvhhs_O8niSB_3F5AeGGPukg4M5s3BKMtvJGa27cGSqcMum.s.r8DdKRPy.qNfYb.JCJojyhT9_
 hF9LXxBl4xbWPdZKYEZBH662DEdjHKEUPIqDRCrselEeIjYR_DoeVrfen2Vn9ycMwBZ3JTTO0AHH
 rU1V7wSOcKr11sHabhk2yxP.61obfB9cIiPk1sBHA0dmmaxy1Ic5Qqi9HD0XBFeThZt9WzdFsXkN
 H0mQ_E75299Jd0Cm7A5Rab2nwIOrJxR.C2xCPvxuldBJPXhE.AkSxshBU.jW7ySvWpN_B.oMCDz5
 dNoRcIiOvUxQZVDHSsPSVsJRuLa58_e1ejcIDBP_GVGUEGxmTnPFokoTugD1x_UYFypWmb9PJb54
 S0uLqBKIhUROdqAE6vzgKkvQhma6ozodcCEvW1ugBmgcYEHWolRIXYQKE0w1vxKAhuXyrBH1u0ls
 Y4paMfkbC1eRCzeOk5Bm25aiWi5PVsXG5UrIqY.q5bpzSqWMBobezYsbQU2Crwn_SZ1RXGHCvORn
 zdtNRr5Uhdfr.d_YzdF26gLy1htv.eBOSiOCps08j1yFZuLKe2Kv2cp5pmVQIcqBf8InFwr0TNpg
 6YQTeQn_3q63gZo6sOBuSCnFruwoOuK3wBNziVvmy44Tcw_qoRQ.HRYmywrQyvq7blrTO7V_VyGs
 Bhv1w8M6Z_pt11gyD93AY3XYPc5ckI5OlgGExPsMBdX8iNGZAsB1S0AAm.JF61COca4ZCqk.C1jx
 TO.SK5XO7nt6gtzaxzjuRT.JOGnulantTqKCjT1gJM9KiIGDeHU764iAsc3nByzhdOVL7bJ2GUrj
 mVaAJXGxUSA0Y6s5sxP9GiiaiMzpt0zTpcG2jmNcqBs.fnDuuZlXZ0ZZOrBxyHjIkQGVbXMyx_ab
 E7Hjs6Nl1jYwMnoeM9pQMrDp3lvcQDoQ8hrQykyFaO5xXFLIYpqRNbaFOUsDFjd3_YpyKV8JiGKD
 izAW_rKrfpIobfP583CqjTLopoOMas8xLpV9fIahg5QNYZxPyT2Qq_gtqDQV0EDTu2Xo7EyvGLAY
 PTVndEkmlgxPqwts0iGBPdd2o3N6JVQhKCOnLu5.ZUigLjW8wHg.5orLcJamLSIdd6k3NausiI4q
 TCRDqjo5zuibyLW5UTVLMclzAn.4dvPkuhYWbE_7134cscqGW_Hj406BHYcsOwxBaGPg4RZt3y0.
 _rX7pGIVLPJtGw44qFdVO6DZJG6EB4M3EwqJxhcpQuus.AGOu01Wvj1qVi8tyutc4zkOHd_nIZWd
 hfNG2b5ipj1CUHZ1XR2ubcGL8cqRcEWhX.hr.hRJOrJbjpqUoa_aobDzHE5Rmc6oj1CePF9FbABT
 lGDn8YBgfYNIFWYphrF2pMmzzggNrRijSjI9pBHpgph.qX9VGRsTXys9N_rfdtJUpzALlIsN6UUc
 9taltKg7ezuB_YwJJTIgWo6TZJJk2xWFe3Q4bls3nGazNmKEmLX_GmeP.3KTromXm3ky4qUVYkUd
 XSNykISoEUCymO_lFQqqUrQLrM6u9DzgYQDOa8jVpd5BICoQT.W7I8uYK0zf75.L9GGJgwRoKE45
 gDL6gkoaSPlNS3vfHgYP5ULDUsVEp.lICNZgR6osUoPXiCoetlMhqsXXveWfCbt_2XmILIU0NzmE
 jVS5PnX4ceNVaUtu059BCtNgt.M3oZYbz62VMpt1vHO0wYwoB6MTS.xiWt645sKTfX0oO_.zWlcd
 5iDRcxcSV41YDbE7UXn8ynvzoHhgC4HxIVCz2_0OXnecBdBMjBbDaedsqYupnB0exSmKCXT8dIZe
 SrfvYYcKou9kVSKuJWa4G8QekU9fBbLXPaHBcVT_buN9EmGM44HmZTkmPRNeQWZojFxAKGUiGlkp
 cW5GRN5wfQRAGjSqmXHAoTarAuqOnLOJgNUwmPasgcKLeqkkgRzBxGeXtRvY1mH6Ga5Mjb7tAw1e
 cqc6ny3sVZwNPcO7_TpQEDeDR8_aDwky_1vsz0A8whYd5PA0srgSgTH.GiaDu5xvxORX_RLewK9k
 4smTVfVX9Q4Ga_4c_5daoXmDJc0ECtdjmVrsBbWQ2x5eafGdVTa1zki5XCFql9W0rmguRJO8MucU
 bEwVP_XDqLQ.2.5RMe7GWTwa73YOgrEBN1jAh0W60V97I7Z7T6hQ5BUsUSgbjV9.RoEr2pqDOu2A
 Te3s3b1QgpOX3iM4SQ_hW3vAVWw9psO6Hl848kPhzk.v80QHi3aQk8kYDF1NRqmf.Y83z.Q4m0Du
 iVHk1_gqAGCPZrWK6X5LyuAOavz4BIHGBscrwUgVI1SWITik7.Axy.tCOSDv_kcTaj_z6Sm7ATU_
 R8ajyDE6HYVK2TB9dXFpQakw862qSS_SQxa1heoSy_B1c1k6IZJrNCdQSkLUl_kWaJDpU9ravl.n
 eIf1fRNDPqSLYd4ZBKN7KRKZr4JxO4_nqCxZAwdJAuvttZ4.zqmsKLdIwsb0ZsFYyjN4hCBxXOmO
 76_A-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic317.consmr.mail.gq1.yahoo.com with HTTP; Sat, 24 Oct 2020 15:27:49 +0000
Received: by smtp419.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 2916ee8ddb6600cadb9ae76b200a557d; 
 Sat, 24 Oct 2020 15:27:46 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH 8/5] erofs-utils: fuse: move decompress backend to lib
Date: Sat, 24 Oct 2020 23:27:20 +0800
Message-Id: <20201024152720.30603-3-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201024152720.30603-1-hsiangkao@aol.com>
References: <20201024130959.23720-6-hsiangkao@aol.com>
 <20201024152720.30603-1-hsiangkao@aol.com>
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

[ will be folded to the original patch. ]
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 fuse/Makefile.am                     |  3 ---
 fuse/read.c                          |  2 +-
 {fuse => include/erofs}/decompress.h | 11 ++---------
 lib/Makefile.am                      |  4 ++--
 {fuse => lib}/decompress.c           | 16 ++++++++++------
 5 files changed, 15 insertions(+), 21 deletions(-)
 rename {fuse => include/erofs}/decompress.h (80%)
 rename {fuse => lib}/decompress.c (84%)

diff --git a/fuse/Makefile.am b/fuse/Makefile.am
index dc8839c84d73..2b2608f57b03 100644
--- a/fuse/Makefile.am
+++ b/fuse/Makefile.am
@@ -4,9 +4,6 @@
 AUTOMAKE_OPTIONS = foreign
 bin_PROGRAMS     = erofsfuse
 erofsfuse_SOURCES = main.c dentry.c getattr.c namei.c read.c init.c open.c readir.c zmap.c
-if ENABLE_LZ4
-erofsfuse_SOURCES += decompress.c
-endif
 erofsfuse_CFLAGS = -Wall -Werror \
                    -I$(top_srcdir)/include \
                    $(shell pkg-config fuse --cflags) \
diff --git a/fuse/read.c b/fuse/read.c
index 8e332e89478f..11f7e6161f8f 100644
--- a/fuse/read.c
+++ b/fuse/read.c
@@ -17,7 +17,7 @@
 #include "namei.h"
 #include "erofs/io.h"
 #include "init.h"
-#include "decompress.h"
+#include "erofs/decompress.h"
 
 size_t erofs_read_data(struct erofs_vnode *vnode, char *buffer,
 		       size_t size, off_t offset)
diff --git a/fuse/decompress.h b/include/erofs/decompress.h
similarity index 80%
rename from fuse/decompress.h
rename to include/erofs/decompress.h
index 508aabab1664..beaac359b21f 100644
--- a/fuse/decompress.h
+++ b/include/erofs/decompress.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * erofs-utils/fuse/decompress.h
+ * erofs-utils/include/erofs/decompress.h
  *
  * Copyright (C), 2008-2020, OPPO Mobile Comm Corp., Ltd.
  * Created by Huang Jianan <huangjianan@oppo.com>
@@ -8,7 +8,7 @@
 #ifndef __EROFS_DECOMPRESS_H
 #define __EROFS_DECOMPRESS_H
 
-#include "erofs/internal.h"
+#include "internal.h"
 
 enum {
 	Z_EROFS_COMPRESSION_SHIFTED = Z_EROFS_COMPRESSION_MAX,
@@ -30,13 +30,6 @@ struct z_erofs_decompress_req {
 	bool partial_decoding;
 };
 
-#ifdef LZ4_ENABLED
 int z_erofs_decompress(struct z_erofs_decompress_req *rq);
-#else
-int z_erofs_decompress(struct z_erofs_decompress_req *rq)
-{
-	return -EOPNOTSUPP;
-}
-#endif
 
 #endif
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
diff --git a/fuse/decompress.c b/lib/decompress.c
similarity index 84%
rename from fuse/decompress.c
rename to lib/decompress.c
index 766e6639aa68..870b85430dd1 100644
--- a/fuse/decompress.c
+++ b/lib/decompress.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * erofs-utils/fuse/decompress.c
+ * erofs-utils/lib/decompress.c
  *
  * Copyright (C), 2008-2020, OPPO Mobile Comm Corp., Ltd.
  * Created by Huang Jianan <huangjianan@oppo.com>
@@ -8,12 +8,11 @@
 #include <stdlib.h>
 #include <lz4.h>
 
-#include "erofs/internal.h"
+#include "erofs/decompress.h"
 #include "erofs/err.h"
-#include "decompress.h"
-#include "init.h"
 
-static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq)
+#ifdef LZ4_ENABLED
+static int z_erofs_decompress_lz4(struct z_erofs_decompress_req *rq)
 {
 	int ret = 0;
 	char *dest = rq->out;
@@ -64,6 +63,7 @@ out:
 
 	return ret;
 }
+#endif
 
 int z_erofs_decompress(struct z_erofs_decompress_req *rq)
 {
@@ -79,5 +79,9 @@ int z_erofs_decompress(struct z_erofs_decompress_req *rq)
 		return 0;
 	}
 
-	return z_erofs_decompress_generic(rq);
+#ifdef LZ4_ENABLED
+	if (rq->alg == Z_EROFS_COMPRESSION_LZ4)
+		return z_erofs_decompress_lz4(rq);
+#endif
+	return -EOPNOTSUPP;
 }
-- 
2.24.0

