Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D6A2A2EE3
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Nov 2020 17:00:47 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CPyLh4SjbzDqNZ
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Nov 2020 03:00:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1604332844;
	bh=enIFgzv/eKCvfCJfV6qP+xTJyk15uUNDJCgZrSm9opQ=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=irEIYjLvbQ7UguO1uaZXV4I6iTie0DkDGNzKXEM3AFV0UKGZV2kXbFgVjNzjYVyec
	 B46TPiziKY4ro2/+EUeuKYF76ibuuKsqGDhyysLFVOUo5LzfX2Y+w7KjC5JswUx9uO
	 p0UMd6OSfhj+gYB2JBbkPR2d/NMgm2l1+pvNXmizQFvzdZ2QYHgXh7jjAq8gJk2yRS
	 CsByoJop3Kre1/CAiaP+LyCpreompxuL3Nen4Hj0WyIlCQYN7E8YeLUAw/fauFVnCO
	 V1oGzHQi1mTsq5bXQLVK0RHi5nl6VlGn+h+VQxZ5Lx01jjcJkhU3zgxg91YW+olVBl
	 S+3QJn9Gz+fnQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.82; helo=sonic313-19.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=K3GMyuBY; dkim-atps=neutral
Received: from sonic313-19.consmr.mail.gq1.yahoo.com
 (sonic313-19.consmr.mail.gq1.yahoo.com [98.137.65.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CPyLW51WLzDqP2
 for <linux-erofs@lists.ozlabs.org>; Tue,  3 Nov 2020 03:00:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1604332833; bh=861rQtDuHCxoFDaW5GY+oGZXTvndA94yyDIaiRAxOps=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=K3GMyuBYMnY9/QySmuvPOxJI3nlCg7slF/vpSMTC2hKkJYXORkjPx+9HcwM9Z19sVz1ivAj07w6E7IjVRPF4gVxchKQF8/AdGS6hXjxbhGlyYk/faZNrOZQKaxnY52O1SrM7lRPJa+7/S5oSUhcCE2Wz/5vu1/Us5x+TRpBxzS0irxZS1N51uLhVoWg36dk+ZdkTEKW+IbZuXLPXU/SUnXabIAOu6mVnnhY/0aDPC7/llyVVy/bRqYH9pHmaRVeuO0cpIOcIPL+bTeOgiKplThOWd42MZvdvyzTP38Hoa49AzQuAwPgJC+b3yWTPMzBRKfvpZkls9aZTTpb20+N5rg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1604332833; bh=lPnDZI0PPy61ZCLq48MKFJSiqzAOd4Gmn1NOLZhwSUx=;
 h=From:To:Subject:Date;
 b=cY+MmR041um6XOtpkkFusGaOFR7CLkxuF3D8ZNDAsBDBanfBdDjMJdYx6ot4v8l4QyxU8p6S9H5QOVVOZUXinKOWrpmbp/NUd+vflSf0VIu18YjTJeUvw7tfxRkIRHHf2KVgBwGsy4L91dkPKmyfs1h7GCj4cN5UrypaOGkVtnzxGC/VArm5waD4SCC3bFs4CrdcHrClCleIIygHInci8zd+ANjLNVRGO16bu6K/rjfPuVxYQ7XrZQwaTQApBf6FI3SuJ03bgkMy9GV7xD/42xqVeYSvMQy7zYbpZx6IHeZcN4KgmF6wMJnCVo7jXqz8cn2FzOxV5SjMgbZNGDa+GA==
X-YMail-OSG: RMGH204VM1mccaGt_8CT7EOeZUxIvq8F9EtlDKxMe6Dft3lE5so41uWp6lh7418
 Uzz9Vii093_aiPNhyMtY0fAKguF7BzPZtdNMc7EwMhaxw6j9RC1WjlC3w6xEITx0bCQuiS8PTM9.
 qwIQkY5oq3fsxnT4HsgZukGtoEnzy1Pfmu_u6LWEblrxu11Gz6Ds4KtZY5j5272bv_CdFYeRdLND
 tfkCYBSWblJC3qdghc1xrIp2J5vUtrOwf37z22TuybHhRNM2fbF8MH1wspRgVXXyhnrkpooIDLSg
 k.IQdLaPt6HWS.jDRdPmwLr59UPumbZ1waBoSmODwntrvg6x8nAvuXwy1.ObyMK3nh5_JLStnn.g
 qK59u_PlRkU3NhU9ImnJ2vnJULvtwjSdn3x6htmphNB2Zo5jMmAD6kYoPxNLxw5HC4hRcSyBqUjY
 9whdWXvgseBnnu7kGDN8KuQePTofwuv7lhOr3hQiAvSSyf2RZ6H51_F.se.vJ.SjX5UoAfP38vLz
 Vr7_zfBFFNEyKgnyuBXHH1zEZ0o2TGaI9y1uGrE74nb7xF9crlwybfiVkSmWKSzD7LI_fTkyblyX
 wV6RCISfQgTOCXLskloU1v__GxT7zLdsSkjVjQ23g0rOZV2uz1cF8q4Ti2WVi7eGyhuDBz9.y1q5
 nC53mT3jA4Rbcsx4g5ACl2p3jvN67.1WLtblaClf1Piu3.yq8MInYCxn2kfuVdAxTF3IiyVXsqtK
 CrYP9h5bC2FjHUx2Yr_4bYaueAHSem2U07wvxt99Y0ulGlml4KV.UGFq4ZIuu6ck8z10DFwlimr_
 ZP.So1Fs7HGi._EjwODOfNtupBPfBmIVW53YwzvI.I12rP9CHoV13cPduKhQT8x2bEa6hBvMuAm4
 zqDHwqF.dcdjHY5jYzg2zJyIq.tdpwb8K8l8oMHQpqFo4iE7ovUOvLs2PO9hOPUTUST2ocwLUJ9L
 2UrCkNEUfGKnEOtwv_Fmsts4ZoYE7e_y8Nb73tqkNw5.8TZrqJ7flKHpRY5OasYUaSEc9R3wbMtM
 zlwy5wAZliNp5NIFunZE.e2461e6fULBskUfDL2OytTYOH9bicyb6jN9BGov1G1I9MXi0xenTUx2
 CBJKSD_9xuN_ZZXe3DPGMeYDUZoeVEpEyK6Naj7JkYH4QjnN8ARbhAZgbSl9JuHU23CtnzF2_iak
 Z33Ly3HWtrRlNhU5lT4UP61zlgN0YRZ9MuBJaVgaOO4gfCWrlMAAtafVeg9YBocNXsGVoKnujwO3
 jJDTA2Jjq1wgdQHovZH6qD3RC1r0JkBsceQme_LU0e4uEdFC2cumHfYl7fOsAcZTiZSXwMoYfDUd
 AD.6Gf9FTO3LfyLYlfo39Vw0CbfuYc3NsFPpESZ4Yjhu.tglGNsExJWSo5brNhDWiH.Qd4kiohFg
 F1KLpjHk2INj9pAYkFg3obMPmHgSKHs0ckHfYZKwsXPP3a6NgFY7jt3z2t03RPC9rKwDVwf9Gmns
 U3G16NUFrEto8MhndkEcR2DX2NihAfshKvIr0WCoqtxoraiU1b3eTnFe7hbC6cay0gJKzlg.2a8v
 WmpCYmypzRiRCY2wXsxTp8bqKoRilmYeIdXUC2br2RFB_0JPcmr4Q0byFha8IhzXS4U5lPCVWA8S
 d_BS6z4ZQFc.yYOPvU.YFT77gLB..p5yEaHQiF68dhiyjgS61UCxGr1P1QjtEJw1fxG0k8E8otF3
 aQ.KmIRZ3N9szcAFHm1Tv1vUQRwR3UHoUyOIr4V38jeObHOcp3CnAiqfCJtQG6M.JmWZKJ5fQ1nk
 Qlcyh2YBi19g80BpwWcZSIvARBU_JNVo1iN4p0aCAn31OBiAlPWPeekx3Q4eq_5KjWvMHfCEJMOK
 tTN7Q8PyE6Ts7njaA3J4AKueMS1Vp8inliAoWEzbGifQnasfNZC3Ek5pzYPkJoPnq.mX6Hz5Pm6H
 zELYg4ig6Rccln.recwdNa9bX_C92eqL2yTnzdpIQSqb4PyrqEH2PF3fnU2tVn6MSRRl9nuuO7zu
 PLtOXkc50hrEkBfL6TH3d5q8a2RCzEshXHcDYnurwDNjdZUBR8kWb0fFDVDBv5ZgBLb6yB6x4iXF
 lT_9jAKfEFfLwlf1FERmBXq93kVPAbsYnjrFjcaTNF9vi.dpz_6Egad.HpjNl13prPM1PnjpR6uY
 pihcauASnRgrF05jd7s8mQ9P.f9bsyMVLsoJrDtxtxPL4e6MhAg.JfakQc82TIvqFy5sYmv.sqwE
 m.8lccAo2sMpTY89ZHzxqPgKR0MKsLNbJ_ohWVIkJvn6KZ2Xwq6wC8TNHAdo8MhJGZjMXlh435UM
 noqUURULjOvHq5l1leY0O5LV5nCfj1Mnw9kRVzvvrZeszvzGy2mQ68jc9i8mkWXxa2PGpDTRVHbz
 VPB2FSU7iZk5C8znn32auvfIot4Tu1F0ClOBaq8AcTUOP12LbXekVdZCIpaOGprfgEQcBu3aq.GJ
 XYmypL2AeCuv8XHt0Aq1HvZRqBicfV68Xsc32ravteB_vmbr8ypGIHdx12ECionR2yZTyIo1sHa9
 .F_zYU6BVQtFMxK.yYErzJiuUog1URZ5JlDr96XvmthZnJM2LZBOgAKL5.52MiQ5HYZRHnoB4cet
 hb29X_0hbp3Eyq2oKMBr9AZo0M77JAt0lWayiRA3jNXGtrIIhj04tOY0dfEOXz3mJz1DjEOIx2Uc
 XjsLN4jxwYl_Yte5RiMobVxvBU7xEn8ed_29YdA--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic313.consmr.mail.gq1.yahoo.com with HTTP; Mon, 2 Nov 2020 16:00:33 +0000
Received: by smtp420.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID aa129971a4deab6e98284c88780a2fc2; 
 Mon, 02 Nov 2020 16:00:31 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v3 11/12] erofs-utils: fuse: kill open.c
Date: Mon,  2 Nov 2020 23:59:37 +0800
Message-Id: <20201102155938.2679-2-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201102155938.2679-1-hsiangkao@aol.com>
References: <20201102155558.1995-10-hsiangkao@aol.com>
 <20201102155938.2679-1-hsiangkao@aol.com>
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

(will fold into the original patch.)

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 fuse/Makefile.am |  2 +-
 fuse/main.c      | 11 ++++++++++-
 fuse/open.c      | 22 ----------------------
 fuse/open.h      | 15 ---------------
 4 files changed, 11 insertions(+), 39 deletions(-)
 delete mode 100644 fuse/open.c
 delete mode 100644 fuse/open.h

diff --git a/fuse/Makefile.am b/fuse/Makefile.am
index 6e639f33f664..5ff0b4d0e6ab 100644
--- a/fuse/Makefile.am
+++ b/fuse/Makefile.am
@@ -3,7 +3,7 @@
 
 AUTOMAKE_OPTIONS = foreign
 bin_PROGRAMS     = erofsfuse
-erofsfuse_SOURCES = main.c dentry.c namei.c read.c open.c readir.c zmap.c
+erofsfuse_SOURCES = main.c dentry.c namei.c read.c readir.c zmap.c
 erofsfuse_CFLAGS = -Wall -Werror \
                    -I$(top_srcdir)/include \
                    $(shell pkg-config fuse --cflags) \
diff --git a/fuse/main.c b/fuse/main.c
index 3842fedce8c1..e423312d9e1a 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -14,7 +14,6 @@
 #include "erofs/print.h"
 #include "namei.h"
 #include "read.h"
-#include "open.h"
 #include "readir.h"
 #include "erofs/io.h"
 
@@ -125,6 +124,16 @@ void *erofs_init(struct fuse_conn_info *info)
 	return NULL;
 }
 
+int erofs_open(const char *path, struct fuse_file_info *fi)
+{
+	erofs_info("open path=%s", path);
+
+	if ((fi->flags & O_ACCMODE) != O_RDONLY)
+		return -EACCES;
+
+	return 0;
+}
+
 int erofs_getattr(const char *path, struct stat *stbuf)
 {
 	struct erofs_vnode v;
diff --git a/fuse/open.c b/fuse/open.c
deleted file mode 100644
index beb9a8615512..000000000000
--- a/fuse/open.c
+++ /dev/null
@@ -1,22 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * erofs-utils/fuse/open.c
- *
- * Created by Li Guifu <blucerlee@gmail.com>
- */
-#include "open.h"
-#include <asm-generic/errno-base.h>
-#include <fuse.h>
-#include <fuse_opt.h>
-#include "erofs/print.h"
-
-int erofs_open(const char *path, struct fuse_file_info *fi)
-{
-	erofs_info("open path=%s", path);
-
-	if ((fi->flags & O_ACCMODE) != O_RDONLY)
-		return -EACCES;
-
-	return 0;
-}
-
diff --git a/fuse/open.h b/fuse/open.h
deleted file mode 100644
index dfc8b3cdd515..000000000000
--- a/fuse/open.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * erofs-utils/fuse/open.h
- *
- * Created by Li Guifu <blucerlee@gmail.com>
- */
-#ifndef __EROFS_OPEN_H
-#define __EROFS_OPEN_H
-
-#include <fuse.h>
-#include <fuse_opt.h>
-
-int erofs_open(const char *path, struct fuse_file_info *fi);
-
-#endif
-- 
2.24.0

