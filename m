Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 087CA2B2FB0
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Nov 2020 19:28:13 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CYP3G3xWSzDqDy
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Nov 2020 05:28:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1605378490;
	bh=P1Wt6wtSUiHZX+y1C3h2aSt/ZkTFI+NQ28rbUgL9t00=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=L85pB5KRUjE9b+F/SjCG0J3SOhML1/KTPYyYDX4090+h/G3J5bq9P8Y1nzJKzIvot
	 BTiHRgepgzh2CEPqkCLKX3Mu+OJ2Pr0MG3FWopNLRJy8J2rAeoAudjXaAYUjcCVpjD
	 +JYBRQ7inAGrEsyrcRTQbT1xU3EK8kV7hJrQdRgaT8ts+g+B4znw3cTJsjNT4Oylyk
	 w1CoOZz+VDn3eJpQRT2KthcoLHVAlkFgs9hf9vEJECSN1WxY28JcynvAdW2IzLNmyL
	 cFxl0rAulqjm0uunOaD0VzgRNt/EeSp/GD5AdNq/gogNa1W6y+1jwYsRcBD2KAgcr9
	 Uoq0ajv0gfMuQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.148; helo=sonic302-22.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=r5I5VfsW; dkim-atps=neutral
Received: from sonic302-22.consmr.mail.gq1.yahoo.com
 (sonic302-22.consmr.mail.gq1.yahoo.com [98.137.68.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CYP3C0qgszDq61
 for <linux-erofs@lists.ozlabs.org>; Sun, 15 Nov 2020 05:28:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1605378482; bh=Zs7jGu0awG2cahHzQJRrihwGc32qIACFI6YoCtmsnl0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=r5I5VfsWfBRrNrDMjWIWjyt2X1+pkeeVd6QsEurJoZTXuXbbNEa3BIEyQS/4E1QvXt6TyfDglQoeLC2icgpEgnEXx5R03DCPlavyY75cJJQ/iu5nbl0UbiN7K3Av5aEtMW935Afhygba7c5RPo8BHL1n9wrcKYARxzKdb5SHk3oXJcW9Ff9XxGlyjozqk4l3ZD9tcBDEXKSudVkVtIMf7HbiOo9ZbTBZCmCfbfWmXK1zugoj7Z47oNhfm4yfUpBv/ojo5z2wIMfEmc6FytbW98Dcgs8WMp9gPMQCSrrNdh5VXKZnrcP20vJbj1DIqOFcofVfWV8Q0Se3OkXPeeeJgw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1605378482; bh=IfH09Vxs+bAzmhI4Cqmt8tFWTeefRH1PnDi1RNyyg7w=;
 h=From:To:Subject:Date:From:Subject;
 b=FABICttUbckS1J9rPG+4fAKoHIkUdanQNE/nutJ6KkiGbo5gqGauBI3Bt90PHv6lUKwiofD4l/WjVQL0GRT31TqtswouVAcMlbEeV0m8YwQqs5muNC15uFSLnZcsK/NZOvDEimGtaBDcABAmmeYa/ec7Lgiqg2vcWsLTDtvhQPpX5jmlFUcFqCvJNAsRc9BiGk+HBIQ4jnnIhfBkyUMohABlF68hZzl4tylCOAV+TqIq4qIf322Pt51GVtJCMHcUYyRJmsqKhYp9BZFP/UuGXC41G/EQrsdUDHft/u3uVvn5s/KPpnf5uHP0aYa5CJne9x1fb7ScfShDVj5S+R7jYQ==
X-YMail-OSG: cCO2i5AVM1mIHCwsJOWCrQTrJdIE1NKdfiQwoWQ9u7pkEduDo19RBYTjXnlQcer
 KYNnfkgWXnxNR5HSWirw3MmOUxBB2JPNJaGA0Gnwi6vSA.4MJac5BD_8m2kQVgxEFcmcpZ9fZ3i6
 6CoA8Zchn.F5lZZfOins_D9FqeFpxC48BygTgpF3VgywtH.eG_rRqCroZpvpLzRryfhOmTtXhWPQ
 pQVgksDeZlv3jYro1KiM5gemvUzHQY3swd0FZ2FEPhYNm.x8pVoTskPrlMSfiBTNs8YSLWdO_kUY
 JusPOHZ1Ay0hxkyiBx7C4a_QkKSSCU9lJJAUNj1_H9zQe.V1tD7QeJvMhDzDCWWr.MnsXJboZy3f
 vdP5vIyOBxYefg9MIKqYejUm_oVi01mfIHk3AwpS26fe5TDeOhFz6an_QqfLIm8Ya1g3DifLwxPq
 dcaBvezHG1zg9q_WqI8CZAr2Pv1dxy2O2QQ7Zf9aQTBPjSkK5Hi0_znFvjs2fNnqVazdxrStxeK_
 SFcjLrRy0VK38jsL7exa5phO4BwBByMAcH6xjaLijusluC0.KxEAiC.O_qIo2dXiX6hyva_I0PxU
 j_27SEPBaD6VEzRGwcQUH2tmvMv6VzAys.CkWAuSJO2KnLaBRntAH4a7jp3LetSvIHoOZyKQpcXw
 k4iuP.pUGLMpLapBEF0CiZvMO4L9lPnnylINn9jC8qe9vg3o7OnAgve4_OXVHthpfOLesonpcjyp
 8LyT0jf81tGjRQZcBW4FloSDwxG8lohLVy2cfs8N6uy72vEFTLRDPIOOIwsatzTOH9U8fwg7Fblm
 iqnGwFz_9d5e1M6Ej4jpC5.87Buuk0J0SwiVIwxdWiGlWLjBF9TaEXWnXsAWnX._8sXMFlj4IYEy
 4AvTa8qv1c5qZGP9aEuDDfhvXW1zy0cNqPGXqZOBUptPo6MYfxtZ4ZHjiwZQl_Uj9X8SJAjcr4cV
 6LccqS0Fp_kZepINuXFBghmr4oVmArkzXsLPy01C3y9XKDgOaaxqhlxTGdganTAE4fyh8kHAdHdX
 zeiDTsiLRKzaFqxgHwrCqnONuXu9KBdBW31vAHw6DJfN0B7dK6FBNxkXwIhv5v_pjZbgmx4wLr3w
 rV_SHClBdrRWSx4QWLht8eZRhnfrY1nKa2id7UBaZZG6Idb66M_Milt5WcSxg6c1RG_7xcwnoKBN
 93FOkkGE_dNrLtSLfqhmSV.WdbCeexbAzbUT11ECd2H40o.DjknsvytBTch5OoK.O38VEoSAG9z5
 wTaFcrfdNMXJtwM_yVyAfeOk_iV9bSUNaQmhLxfca83baqr_K33XA7ceYyynKm5h_gv_7e.IavmB
 cUHUTfyjhCSbi9.xfcj_kyYNQH07ywrOzVqH_VAxvD6HiJwpREumbpTiPNJTsXPGgkedyEvnap96
 E5RMecjQ2Ew4SbSL2fuBL8ussY5OtRi.Q0_cRhtlsEhHdai0UqNqlofAide5o8W2FfD3d9T1rY6H
 ut2kppPph1wAYvHAZhMLLDUoHuBu2DXQgooiR.GQmJyqhii67TaN8bsTCQ9ShEpHyLOZ71.TeeVC
 sW0O.DRWrldRQOGDu.Lv7kOgfgtjsaIslRolCc3jvpTdlQVJG8C2JwN75.wLObB6paBBsLZ6Uddq
 qq4V5RYPg7pMSg9QwpwKXWANjEu.v9.Q4mMkiJzfiKRuO_O3d.sb8efGUs7uwILiXf0XS5uFlC3I
 sLTKYCPPkvVL4mEkvaRf3W97GAYA632O13LkF4AmCbbtetSXxzd_3NzW7qZ4pN0jCAAFtY50CopA
 d8Q6O28YYkg6VDqnyMaiASJi4QyW5L.30yhw5GxBozCfFMUp1.9zShFNQZhi88ZOY08.ieJ_L3AZ
 UdYtdud_Ky8J7Zz00nXoa2kunwq0PY.m16logtPtLCnxHiwxYHYGIXCbQJsc54WEbAXS6DzC64uk
 44kP0tETkfcBEF4S4U73Fr6MBt6Rw4.6nzRi7tjSFDFcXul61YwSB.KZegixWwNwTJ5QsRxf1cjm
 cwr_p9G6RLg3SZsbLTsujX26hg3GBN4dlCDA12YzoZbieXKQH.6Nhscz5NYgzcMqkkgLAaZnfkYT
 AOT2nUbi8lU3VIavt3669ilhb2QUDGGgsTRHAwKY8ueVexEFe73i2x7l4ytOtu3sCPj.wFEeSG1O
 XIKNcxRtMnftGoxp2Xy6aOqgT5_y218TfuZnTqG_mFK2eIfT2NlSd.jzr3XaUXMuNx9BJHc37Xef
 UafvNnoWSFuJHaFuSx3jFCH8Za2tkCB9tZ4WTwW.pw.4wNIAjmUtQFvLyDU439P5ZdjQGL2WxJh7
 N6.L4UGRDgo_1qDJw8lX.Vi_iiqtAG0J1kTmxwo6_zdpl.kSZmXI9GEKx85rb44e6_iAlxD5OvZ_
 jnXAU34u6cQAXL89.EOQAf5Mk1KTtAo_4qRxTJRk3hjhdZq.NLqibID6ROTpSPi78aS6lVkcILcq
 3AI8R1u0LPKbWJMb3z98homSPS1UsC8dX5zKXd4LnNknm1CYQB8Y3CYCEama2MkyeqvJgM6dySQr
 qhiE34U1_njWwNdImaW7o3JdABgn0BLh5Ros_3z04YM1tr7gFaZardVykmR_qzi30o.t6w_e8fII
 ryXqJb.XLFc7tjXB2wM1GeXJQ83N6sIlA11E5dGTF38PDA3svbU3UNhAZiM_7QELM0AsDHn6X0VD
 oQZYFeIBt_Nq9hVJAbHQByzBRXAymeXWc0cdZNB32nbAOiOSspgohjZ53
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic302.consmr.mail.gq1.yahoo.com with HTTP; Sat, 14 Nov 2020 18:28:02 +0000
Received: by smtp420.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 1d0fcb25c7973fe782c79ebccd4a2e5a; 
 Sat, 14 Nov 2020 18:28:00 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v4 10/12] erofs-utils: fuse: rename readir.c to dir.c
Date: Sun, 15 Nov 2020 02:27:48 +0800
Message-Id: <20201114182750.10089-1-hsiangkao@aol.com>
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
 fuse/{readir.c => dir.c} |  2 +-
 fuse/main.c              |  7 ++++++-
 fuse/readir.h            | 17 -----------------
 4 files changed, 8 insertions(+), 20 deletions(-)
 rename fuse/{readir.c => dir.c} (98%)
 delete mode 100644 fuse/readir.h

diff --git a/fuse/Makefile.am b/fuse/Makefile.am
index 21a1ee975141..4ed4215b9936 100644
--- a/fuse/Makefile.am
+++ b/fuse/Makefile.am
@@ -3,7 +3,7 @@
 
 AUTOMAKE_OPTIONS = foreign
 bin_PROGRAMS     = erofsfuse
-erofsfuse_SOURCES = main.c readir.c
+erofsfuse_SOURCES = dir.c main.c
 erofsfuse_CFLAGS = -Wall -Werror \
                    -I$(top_srcdir)/include \
                    $(shell pkg-config fuse --cflags) \
diff --git a/fuse/readir.c b/fuse/dir.c
similarity index 98%
rename from fuse/readir.c
rename to fuse/dir.c
index 2e90c95c38aa..f6c1295f52bd 100644
--- a/fuse/readir.c
+++ b/fuse/dir.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * erofs-utils/fuse/readir.c
+ * erofs-utils/fuse/dir.c
  *
  * Created by Li Guifu <blucerlee@gmail.com>
  */
diff --git a/fuse/main.c b/fuse/main.c
index a4b7a3692c19..236d54635acb 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -11,10 +11,15 @@
 #include <signal.h>
 #include <stddef.h>
 
+#include <fuse.h>
+#include <fuse_opt.h>
+
 #include "erofs/print.h"
-#include "readir.h"
 #include "erofs/io.h"
 
+int erofsfuse_readdir(const char *path, void *buffer, fuse_fill_dir_t filler,
+		      off_t offset, struct fuse_file_info *fi);
+
 /* XXX: after liberofs is linked in, it should be removed */
 struct erofs_configure cfg;
 
diff --git a/fuse/readir.h b/fuse/readir.h
deleted file mode 100644
index 16b878fe9f29..000000000000
--- a/fuse/readir.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * erofs-utils/fuse/readir.h
- *
- * Created by Li Guifu <blucerlee@gmail.com>
- */
-#ifndef __EROFS_READDIR_H
-#define __EROFS_READDIR_H
-
-#include <fuse.h>
-#include <fuse_opt.h>
-
-int erofsfuse_readdir(const char *path, void *buffer, fuse_fill_dir_t filler,
-		      off_t offset, struct fuse_file_info *fi);
-
-
-#endif
-- 
2.24.0

