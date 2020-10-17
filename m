Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F8C290F0D
	for <lists+linux-erofs@lfdr.de>; Sat, 17 Oct 2020 07:19:06 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CCrsh0dNWzDr0T
	for <lists+linux-erofs@lfdr.de>; Sat, 17 Oct 2020 16:19:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1602911944;
	bh=rkr5vzUgX2HKZtMbUWShwQskP55t09+6p5wWPtvTMUE=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=VbBLFTQRLCYwx+iuyAc3jF5e9JVYRbRFXunx3knkoGRYL+5yu3IgZmeJvS+dcC5EL
	 BtA/G4A3iYPF/L6Z7X/sDXdW7S8HAGLaORg2hxJUL97tTRle0B87TUh/qwwurTEuBP
	 OTe4E0saYYDhexVlLa+VGug8oj9GgpNUCdXFhIMwP8vyRHJlg1I5MhnOTyBdvUwt4O
	 rzSlqaxYPToDVu4Ld5Q90dzpPamsPqf4fIgIKshZmowPG4KdLOA1JcjI4AbmYec6YU
	 GIPSr7K4s3g8roHfdfUj+j4hNUoc9sOlJnBLpz+WwUjJgyHmu8m5A606HzCrBVGrOz
	 64HZq+U00s3Sg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.66.148; helo=sonic317-22.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=N9zuijNZ; dkim-atps=neutral
Received: from sonic317-22.consmr.mail.gq1.yahoo.com
 (sonic317-22.consmr.mail.gq1.yahoo.com [98.137.66.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CCrsc0ndLzDr0T
 for <linux-erofs@lists.ozlabs.org>; Sat, 17 Oct 2020 16:18:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1602911938; bh=2ESiGQLJ6Slfa8P+8LP6pkjKbUCPir8tsGM1LOBiriE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=N9zuijNZp4e6O4I2tgO2rdk9Jlmlo58eWMhUtu/13O64UvkrKB6wukbpki1MxxotxmkzJOjY6ct3X8biDkcTubf6M71odlO5hNcgWIl4YjeVa0yKGgFZJmOUSkUod8Szt0UlZFkTlFsE4eObXNRmRGF1BxGqt3+rk3gQlE0RcELHe5i8MQZKr0Ri21PjbZAzabskJFv6DVxwpvRiC18Y9QvKB1e+boZ7cBiK/M6wS+iDDxN7UmFzOYHPQgon/hL0rOY77bvgbhlASKrVtEOao2sAqT1XoWXOkwV1MlYPJiXSNI9YnUkpZ+kyDm5FYXvNRC4ke0QskmtyS3InvQhRBQ==
X-YMail-OSG: GkVN2V8VM1kyr1tMIlN0Fb2h81B3he9.5KdG_EcjpRr5q.lA3cWtXtstbDMbeCe
 eHv72d476TTpsLvnnuW7IoYkZxXkVVN0_IIr4xBjQRepShoPEB0GEW1WsfeKVCFbWsctb4MhVLvq
 MomUEFBBKO2K1Lh8gUIxyu3kDxhpRxEknUdvytyml5feC5S3ZaUe47FQmAw.8QMlz5tb5v07XwXg
 z6vIdL1OGvUEeDWFD1xsJO5s4rQ8pgV5sbNdp5KSAYFg6TMp_a4EG40IOB_1dXEuKx46xxyp.Frz
 h5SJswQ_pX4g0yxEpJiJhVp4EQ_3._TdPNy3VIDLznAip3Ls1JPM4khkV07hGE6xJbrIr6zwJy5V
 BKM_va88iCgxCp6RO2MKuRpPfDS8LYNZ3QvM6neRpLS0FtMQ2Ihx6q0ERgsRZOAq.11M1fNQCH.N
 0pgyA7Ox6BjSPUBymBl1Eje.nsBtYSp_teXBi3XSOwt7VfTtDWjn_WgE7UN.FpwpM0aKwBPqKWWa
 wlqoq3ghXD1KVvF.caUfoW8jDuun44F6u2GZjLczdaHOZCMNGC1KsHIkY0uYzsBKwvKe9MoLQxrU
 pDzZQEDGH94oZMJhkAd_yC4XHwHz9vc01lmDkOUyzlXTdky1WuSwZAtiyYNCsJ4F3Lar2GQJHq5h
 OvDQB2a5_UOdsbIgHHH6_ZfeZIH7JdMpFq5x8lMvluytUB9zXV39ADgsuFMVpfeAHlAsFgoFc8VQ
 GaeOnNaU2QmjhwPxvb4dTowLYqKQxm.RFWpIE6xoaPDllM2PMezqu6n_QqG4o2rFuGpTi.9r2T5u
 mDwyYhl66nZrH4z8AjNmGV0E0lDsrSJA3G1qjlk2P2d0wALMJEvpZh2n7poTZ6Ve1OIQKDuTG6nQ
 bv2g26yUu7tCdrEZ603ypt4q6kXDes.vz6X5biLt7imroh7eOJ5HKtVcBRsoyhzbyYW8j1NKpB0b
 RgzfrF0cE_PZ2lD_n8O9sMXUl0KoIQc8Sla7wWsRaSvAJ6S8QI_VxvDKdbB.X2.Wlc.a1xnW54LN
 JEtlwMtJjygrGy8YQyWGvVfv2NFFK.QOfbJpPpDACCP0uBwuO9ntxOBAMjBvcZQNvoGbXvDo2iMb
 FqCb3w.ML9d232pWFUfNWdzDRRu.uPyyjzhv3tmoDmMpkE0irWMhghm_rBK8_qsMDgFkOFhmvu2w
 5u2Gu3_5139_U2Scrax2ZJLQG32SyZ21ZXW2gfFiVuhNsbFfqtYuhyPn.UMI6w2McFghpfoUYTEd
 tgC_mkXqkA2Nm40jaiF9kRsMqarbZI4UXfX9S3Bm5.jcOopqilakHpAJ7x5mKMVn1pbW1HvcII2Y
 xsdgKzCTZCM9pHcHHZ35sx2t1APBRVwAvFBLSGjkwO_yAwaEOQAJpNazUr8.Me5Ypwpt4trIEuDG
 TFQYuzjBXUZmfs..gZi_Ckf5HKKxQuu.9NH7uTD.5wI9.PTKQZ0_uxWuSB9F7Aq2wpixywuh9_C.
 dgHsjNAATuwiNla.AO5vlj9fDQdsc9LX3GYHjqyhjreSpJaGET6nOBXP9vEaOrYxqvZZahrAL47u
 _Ao1HBgMaiG1g_2RXu9k-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic317.consmr.mail.gq1.yahoo.com with HTTP; Sat, 17 Oct 2020 05:18:58 +0000
Received: by smtp424.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 9d3dc137a63e5241cc606f3cba181f35; 
 Sat, 17 Oct 2020 05:18:54 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH 12/12] erofs-utils: fuse: fix up source headers
Date: Sat, 17 Oct 2020 13:16:21 +0800
Message-Id: <20201017051621.7810-13-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201017051621.7810-1-hsiangkao@aol.com>
References: <20201017051621.7810-1-hsiangkao@aol.com>
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

fix up weird paths and relicense zmap.c

[ let's fold in to the original patch. ]
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 fuse/decompress.c | 5 +++--
 fuse/decompress.h | 3 ++-
 fuse/dentry.c     | 4 ++--
 fuse/dentry.h     | 4 ++--
 fuse/disk_io.c    | 4 ++--
 fuse/disk_io.h    | 4 ++--
 fuse/getattr.c    | 4 ++--
 fuse/getattr.h    | 4 ++--
 fuse/init.c       | 4 ++--
 fuse/init.h       | 4 ++--
 fuse/logging.c    | 4 ++--
 fuse/logging.h    | 4 ++--
 fuse/main.c       | 4 ++--
 fuse/namei.c      | 4 ++--
 fuse/namei.h      | 4 ++--
 fuse/open.c       | 4 ++--
 fuse/open.h       | 4 ++--
 fuse/read.c       | 5 +++--
 fuse/read.h       | 4 ++--
 fuse/readir.c     | 4 ++--
 fuse/readir.h     | 4 ++--
 fuse/zmap.c       | 7 ++++---
 22 files changed, 48 insertions(+), 44 deletions(-)

diff --git a/fuse/decompress.c b/fuse/decompress.c
index fc12852ac6b7..f2aa84146946 100644
--- a/fuse/decompress.c
+++ b/fuse/decompress.c
@@ -1,9 +1,10 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+// SPDX-License-Identifier: GPL-2.0+
 /*
+ * erofs-utils/fuse/decompress.c
+ *
  * Copyright (C), 2008-2020, OPPO Mobile Comm Corp., Ltd.
  * Created by Huang Jianan <huangjianan@oppo.com>
  */
-
 #include <stdlib.h>
 #include <lz4.h>
 
diff --git a/fuse/decompress.h b/fuse/decompress.h
index 7d436f18da86..508aabab1664 100644
--- a/fuse/decompress.h
+++ b/fuse/decompress.h
@@ -1,9 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
+ * erofs-utils/fuse/decompress.h
+ *
  * Copyright (C), 2008-2020, OPPO Mobile Comm Corp., Ltd.
  * Created by Huang Jianan <huangjianan@oppo.com>
  */
-
 #ifndef __EROFS_DECOMPRESS_H
 #define __EROFS_DECOMPRESS_H
 
diff --git a/fuse/dentry.c b/fuse/dentry.c
index 27192ecfd32e..1ae37e3abc86 100644
--- a/fuse/dentry.c
+++ b/fuse/dentry.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * erofs-fuse\dentry.c
+ * erofs-utils/fuse/dentry.c
+ *
  * Created by Li Guifu <blucerlee@gmail.com>
  */
-
 #include "dentry.h"
 #include "erofs/internal.h"
 #include "logging.h"
diff --git a/fuse/dentry.h b/fuse/dentry.h
index f89c50646fb5..12f4cf6bafd9 100644
--- a/fuse/dentry.h
+++ b/fuse/dentry.h
@@ -1,9 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * erofs-fuse\dentry.h
+ * erofs-utils/fuse/dentry.h
+ *
  * Created by Li Guifu <blucerlee@gmail.com>
  */
-
 #ifndef _EROFS_DENTRY_H
 #define _EROFS_DENTRY_H
 
diff --git a/fuse/disk_io.c b/fuse/disk_io.c
index 72d351b17806..3fc087699dc9 100644
--- a/fuse/disk_io.c
+++ b/fuse/disk_io.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * erofs-fuse\disk_io.c
+ * erofs-utils/fuse/disk_io.c
+ *
  * Created by Li Guifu <blucerlee@gmail.com>
  */
-
 #define _XOPEN_SOURCE 500
 #include "disk_io.h"
 
diff --git a/fuse/disk_io.h b/fuse/disk_io.h
index 6b4bd3cce085..d2c3dd598bc0 100644
--- a/fuse/disk_io.h
+++ b/fuse/disk_io.h
@@ -1,9 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * erofs-fuse\disk_io.h
+ * erofs-utils/fuse/disk_io.h
+ *
  * Created by Li Guifu <blucerlee@gmail.com>
  */
-
 #ifndef __DISK_IO_H
 #define __DISK_IO_H
 
diff --git a/fuse/getattr.c b/fuse/getattr.c
index d2134f486e19..e5200ebeef1a 100644
--- a/fuse/getattr.c
+++ b/fuse/getattr.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * erofs-fuse\getattr.c
+ * erofs-utils/fuse/getattr.c
+ *
  * Created by Li Guifu <blucerlee@gmail.com>
  */
-
 #include "getattr.h"
 
 #include <sys/types.h>
diff --git a/fuse/getattr.h b/fuse/getattr.h
index dbcff7c1a6e1..735529a91d5b 100644
--- a/fuse/getattr.h
+++ b/fuse/getattr.h
@@ -1,9 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * erofs-fuse\getattr.h
+ * erofs-utils/fuse/getattr.h
+ *
  * Created by Li Guifu <blucerlee@gmail.com>
  */
-
 #ifndef __EROFS_GETATTR_H
 #define __EROFS_GETATTR_H
 
diff --git a/fuse/init.c b/fuse/init.c
index e9cc9f81d4c7..48125c5791fa 100644
--- a/fuse/init.c
+++ b/fuse/init.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * erofs-fuse\init.c
+ * erofs-utils/fuse/init.c
+ *
  * Created by Li Guifu <blucerlee@gmail.com>
  */
-
 #include "init.h"
 #include <string.h>
 #include <asm-generic/errno-base.h>
diff --git a/fuse/init.h b/fuse/init.h
index 3fc4eb548dda..405a92913b4a 100644
--- a/fuse/init.h
+++ b/fuse/init.h
@@ -1,9 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * erofs-fuse\init.h
+ * erofs-utils/fuse/init.h
+ *
  * Created by Li Guifu <blucerlee@gmail.com>
  */
-
 #ifndef __EROFS_INIT_H
 #define __EROFS_INIT_H
 
diff --git a/fuse/logging.c b/fuse/logging.c
index 2d1f1c77c2a4..192f546b94ec 100644
--- a/fuse/logging.c
+++ b/fuse/logging.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * erofs-fuse\logging.c
+ * erofs-utils/fuse/logging.c
+ *
  * Created by Li Guifu <blucerlee@gmail.com>
  */
-
 #include "logging.h"
 
 #include <stdio.h>
diff --git a/fuse/logging.h b/fuse/logging.h
index 7aa2eda405db..3aa77ab08107 100644
--- a/fuse/logging.h
+++ b/fuse/logging.h
@@ -1,9 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * erofs-fuse\logging.h
+ * erofs-utils/fuse/logging.h
+ *
  * Created by Li Guifu <blucerlee@gmail.com>
  */
-
 #ifndef __LOGGING_H
 #define __LOGGING_H
 
diff --git a/fuse/main.c b/fuse/main.c
index 884101374bcf..9c8169725fa7 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * erofs-fuse\main.c
+ * erofs-utils/fuse/main.c
+ *
  * Created by Li Guifu <blucerlee@gmail.com>
  */
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/fuse/namei.c b/fuse/namei.c
index 0b71072027ce..c33af4b04b45 100644
--- a/fuse/namei.c
+++ b/fuse/namei.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * erofs-fuse\namei.c
+ * erofs-utils/fuse/namei.c
+ *
  * Created by Li Guifu <blucerlee@gmail.com>
  */
-
 #include "namei.h"
 #include <linux/kdev_t.h>
 #include <sys/types.h>
diff --git a/fuse/namei.h b/fuse/namei.h
index 80e84d7220aa..1803a673daaf 100644
--- a/fuse/namei.h
+++ b/fuse/namei.h
@@ -1,9 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * erofs-fuse\inode.h
+ * erofs-utils/fuse/inode.h
+ *
  * Created by Li Guifu <blucerlee@gmail.com>
  */
-
 #ifndef __INODE_H
 #define __INODE_H
 
diff --git a/fuse/open.c b/fuse/open.c
index 9d2edca54d23..c219d3870000 100644
--- a/fuse/open.c
+++ b/fuse/open.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * erofs-fuse\open.c
+ * erofs-utils/fuse/open.c
+ *
  * Created by Li Guifu <blucerlee@gmail.com>
  */
-
 #include "open.h"
 #include <asm-generic/errno-base.h>
 #include <fuse.h>
diff --git a/fuse/open.h b/fuse/open.h
index d02c1f752204..dfc8b3cdd515 100644
--- a/fuse/open.h
+++ b/fuse/open.h
@@ -1,9 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * erofs-fuse\open.h
+ * erofs-utils/fuse/open.h
+ *
  * Created by Li Guifu <blucerlee@gmail.com>
  */
-
 #ifndef __EROFS_OPEN_H
 #define __EROFS_OPEN_H
 
diff --git a/fuse/read.c b/fuse/read.c
index f3aa628945e3..621f7d6ce6ea 100644
--- a/fuse/read.c
+++ b/fuse/read.c
@@ -1,9 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * erofs-fuse\read.c
+ * erofs-utils/fuse/read.c
+ *
  * Created by Li Guifu <blucerlee@gmail.com>
+ * Compression support by Huang Jianan <huangjianan@oppo.com>
  */
-
 #include "read.h"
 #include <errno.h>
 #include <linux/fs.h>
diff --git a/fuse/read.h b/fuse/read.h
index 89d4b4cd600c..e901c607dc91 100644
--- a/fuse/read.h
+++ b/fuse/read.h
@@ -1,9 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * erofs-fuse\read.h
+ * erofs-utils/fuse/read.h
+ *
  * Created by Li Guifu <blucerlee@gmail.com>
  */
-
 #ifndef __EROFS_READ_H
 #define __EROFS_READ_H
 
diff --git a/fuse/readir.c b/fuse/readir.c
index 46ceb1d90a7f..f3dd0c42c6e2 100644
--- a/fuse/readir.c
+++ b/fuse/readir.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * erofs-fuse\readir.c
+ * erofs-utils/fuse/readir.c
+ *
  * Created by Li Guifu <blucerlee@gmail.com>
  */
-
 #include "readir.h"
 #include <errno.h>
 #include <linux/fs.h>
diff --git a/fuse/readir.h b/fuse/readir.h
index 21ab7a4e4e0b..ee2ab8bdd0f0 100644
--- a/fuse/readir.h
+++ b/fuse/readir.h
@@ -1,9 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * erofs-fuse\readir.h
+ * erofs-utils/fuse/readir.h
+ *
  * Created by Li Guifu <blucerlee@gmail.com>
  */
-
 #ifndef __EROFS_READDIR_H
 #define __EROFS_READDIR_H
 
diff --git a/fuse/zmap.c b/fuse/zmap.c
index 022ca1b9e437..8ec0a7707fd6 100644
--- a/fuse/zmap.c
+++ b/fuse/zmap.c
@@ -1,13 +1,14 @@
-// SPDX-License-Identifier: GPL-2.0-only
+// SPDX-License-Identifier: GPL-2.0+
 /*
- * Many parts of codes are copied from Linux kernel/fs/erofs.
+ * erofs-utils/fuse/zmap.c
+ *
+ * (a large amount of code was adapted from Linux kernel. )
  *
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             https://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
  * Modified by Huang Jianan <huangjianan@oppo.com>
  */
-
 #include "init.h"
 #include "disk_io.h"
 #include "logging.h"
-- 
2.24.0

