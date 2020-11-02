Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 666F72A2EE2
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Nov 2020 17:00:38 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CPyLW27xTzDqNn
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Nov 2020 03:00:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1604332835;
	bh=0okYWQw3HesT4p2UAGoJpVLdy45AceUJb7BTNT7kZFs=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=GJv7zAIRbQEEvdcHHGeCjxLFnUjo25ehSdjB3AunYq3gcACuRK7M2EPu9h1usQhHv
	 DXxtc0je7NR63C3CFXuec4T972VMdF5/aCu5TO7jObcL4QKjFA1Zj1GrGNUXRaGYJw
	 8aMbt0tGf6+3qSq6Kp9JgsEH/CDEqPJwbErxe7vFgN55hh6FHBOWYJ0MgtkduKv/Gl
	 csFal8y8vbXyh/HbEeDfEDG+Is9Qa0nIAjdl2+o3hrZUBnQE5xFPjW8KV7roFG9LnW
	 1K0TNlueI4w657zNLMBwjfltGD8zpHZj2OHx+7QmxCcrxBjclRLkYo3o8ebeyurfPn
	 5/dmqO7TiDeQg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.64.31; helo=sonic307-55.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=fUhDKgL9; dkim-atps=neutral
Received: from sonic307-55.consmr.mail.gq1.yahoo.com
 (sonic307-55.consmr.mail.gq1.yahoo.com [98.137.64.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CPyLP5QbgzDqKW
 for <linux-erofs@lists.ozlabs.org>; Tue,  3 Nov 2020 03:00:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1604332827; bh=6j+4mngv87uNbk6/atmOawqYsIpAmHWSzmSvO0yoqvM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=fUhDKgL9Jqi2axhn6meCLw+Yv5MjhvVXxalM/+bTLVHBllpA04W1XJKhPK+S4OQ2B6dptzBPe5cGvVxweO6qxxI9vEj30sZEHIE/yaxlKUU+DIjfi/ttIP07M0mG8ylsdx5xq7ei0/ACvJuthpqkq3kz9B/jCmoFPVrJ7386plbgLhM5q2kiQE+xnb0OFjrQxeAQcY7w6Nra+CsFQhJC7AO9/4ULecxIQSxbDGhq6l53GowlkKsJL0wi8jrVl1iYF8dmSlYIm7cKuJOhU+DOjynr3GeloI1cVURMWjAz33o9FiwcB6ysQjzB50LB9w2Z65L9dlrJtO+nFKTgB7bSyA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1604332827; bh=hvEWG8Z3Y0LcBnjTZ/VbgRrYyTCh7bPln66qFs8F/vM=;
 h=From:To:Subject:Date;
 b=LMpRB6P1KH94SXotEVgmAMogOqsjEk87cIa0LripE/30trkiwR5BSky8GrDj7cc9oH6BgVQXi9A1Z8W3aYWr2ruDekY2HmrvugTv2Oj7bXGlbjR5sGw3mF6YqnSk5zZft5Kf3xmuT8gM5utE9mXrvqrpbNyzqF/3SuCb6Xz0MPvapydTwrWHSRS8nuIcR2QtYu18hNU2kBvY1XnMFuNWLEqyXRClHAi3GM7pxCE66ej9LZubPw6gNkTpbZCs6xZ21CCmIwUAG47DuR1ggVeeGdl9S+Uqq8eQRaZ0uwfb09l68F3Zf51etdgBVZTaaNeCjWpGrUacE8/14hlVtBe4Ag==
X-YMail-OSG: ABN7c4UVM1kF9x0WrlTOaCzLV_hIhLYJ19tm3agBeAaxkBvUKFxjYUKc7BcPZWi
 Yz9I2ONY4Pu9RC.5Jfm5Yoqt6ZlsUaf9s_Rb9IYTEPp0SXkZK.nZgwsjn6GrPeVpTN3BSKWv4ikk
 OZExMySPXosprkMijkoqsVD6Sd.COBfFPa9HCOfWD2vLsvzmm4vOFchvIdn8sXj1.8t3iVm8xtFE
 YNBGo.JcZtkj4ckdjVKgg4__FtXqqEKfNpj4J9JHscu6TJZh08nQUI4lBR3RCUciRcM4D8kCm06Q
 oFp8zVajjI2u3_yu2koKhZyVxqAzdxoq0e5zLKSfsBGyq2QsnHxt.2lY8dE745TnghFudBIdH4.j
 dsMTNc05EHY0180cjHLLq6AkC40wcvZy0PPs_e3naHstotVHE5RH59iwQb9tz3PAUMNUBAujsUiP
 krV.JkL4sRSd0N_eHwiPs67mjizmubYq3Z7nytxbMcHimPLZU76tXqbvC97.aNN_zw0XdNhTcWZZ
 7DY76UTMB0Y3dfq.Qrk.qmwPVVUJgAYzO1IapWmMEdGktR4CDONgNW9tqRYfpVXaIMRmKhAUfgFw
 De.cYwmk0FfoubmxtWVAdRafFUtQr1djwCDpXEQ149DIthO6pw9z4iWarHEz2416AQd4jzX_GoME
 MvSOKfaWddzaYvjDcbhlCiU2yl3juArRi1B85HifUErsa80COVVFFSLQW_p9rGoZhkTPuXOatKwQ
 P_XeXAICza1_5CrAEatNeLDvCHtyBxd8xK_VR5H74OaeGJQAZ55Z5_ZUZiZOJdppM1i9.JvG8goQ
 3eKAsBPAMB1zvWFA9l9PHLZqYQ_OUdVIFCaextp9pngJdHBOP1jt2bQ2FIpPUqFSk816CIOXCqc8
 CamzC7PaafylDv9WhIZUTs8S5Fbf.rsVT0MmhXs16HRiYTDo9SsWpwzmGPIxmGkbuH0oWz0qVHSs
 pgGUtQTTfFu1nAQSt3ELPUbixFzAQJVn6Lnhw.Xp3osW0.L.NusGd6O_MNbVyrGpiHL8YxCykbUc
 2Iu4dJTZ7TEg8BJGPhxOxQOEhq4JU1CVErSG76iFVjl86GruZL8w.x_L6qNiIxw9BJS8g9AZhOmo
 8RcQkQ4qx74UOrueDaXH.EG94NbEEXkzXCF5csKASR_SI.hXkZTEkdml4wqsV9fRPtAfP4RxTsdn
 TVoXj5fB_gxTx8K_UWIG53YU.2pdJd8gyoBb6WTfsx70ivn4wk6E7OhVCKHPx6.kbP95tDrZrm4E
 P23m1QOOoxLEQfLR1L_sCqs_vzrdv.RVu5cNz20U_Aun6pfVnx3rEK5XTKSHODxNL4hfygOCjhmx
 O0bUkSzeGHAQi3cQHmdMBckCu6VFPga7s7Bot86q34OiN5YEZESADpYEWkcMtVMS1culvHyeTvvI
 Y9DuZzetrNNG9IyFgVV298af1dUpLoP8qJL1_DhekNc_azxMg1EHXRowwEZ4CYg9hXdspZxRrFK1
 sRIqk68Oc2cOc_SPknsKTZLG_yUN8oGS4Gd0z._wGkYl_oK8rQToCktnomeL9ntwp7znLbavMtb.
 AIBaCdi.CqUXEn35UpMabXJoYT_wO3hd1rp8BvNjGmGwD0JWVpcjmvRdETZNwXF6MNmDdxNJLGT_
 CM2ZzYX4wvnK_4ATpXIV2A2u3s7r5KcvfPpETXhxz_r5WzVt_ltjjUBRhuo_o2FRHujaL3mrnFm.
 li1wFH2DwTw.DjyKAmLjqPqozWLN_rDftt26a_dYPEbfSd_Ym3pK2ccYYU4zxDpF4f96jPZ7kqww
 yeMBJLs0iD8BPcIDtol9zDvtNzaH8EfnbN8gc0tw6Ba_uPRDwGc0Tda3eg77_7rIVvw4I7XFwyXd
 gWrz9sVZSipq7F7BGi1htkWlaLClGlBVTASd7FlviLqXr.oMvPWyPjztR8XZyo1HfqsiE8gvYjLF
 LeRSC_4c3jr3DFWneRqnR8F1I2PX.lTacihpRpZCAv.rq9I178dN2KVhEm6s_EUn7funSFDrN_bE
 MIKTj1HwJo4dr_ACJxquklDC0HjG0J2QTLHlXFO9.fP6CD.a6lW5b4YXVGRuo4lWNVRDPfjy3X50
 Tes2B6iTZPI.7zt2DClaA1O4khymgVXbPd1M1ARZEieiHRmD9oT_TnQPGziZOE6OKz22Gw.UzP_a
 6wL6pShIgBbhXyRukdCVXgGeP0q9.7gGIwUxUV_iK.CAjtmC_sMU5kQxwtd1iZF4BD70AR4et5zx
 WDY2gxXqkRb0KG_f0jqKwqQxPM.CU2THfqYKisx2T2dcZgO23KUZPBjMI_rnKucM70yScZzZ6M2h
 z.7.p2DWRRAWuA7l1CHFzwbVtadiwk6QgxHZiCqZkYfJJ6Si2oIZyGBSRufBgHHhfcbSuF69W83x
 2Kp9LInqGlrT5ETYSmt6uDh8NpGYWMR3XAgrAaufyBG2veZiOYkUGwd7bYoTefxV861Hb27Hfr33
 YNjeRnk43pysQjo9BsurDyCTMIEcOgvOP1aGtQnAyW.itveuCGyuGaqn6DXcQXXV3iInPzlK6di.
 OQw9sIpg5e6TB9fbxQFWcpZyZguUC1roSS4QNdSrKRkKFp8qiFjhqYDlULAIBd5Gh01C5FK4AbmX
 2keJEOZAtPCWD4nfI.G0SZupyI_l6BBTGwL4L45XsJ.ClsxNKdB2mODO.ybNiFp7WgQiNg1Qpalf
 CsRDRao39KgUGCQdOIcCT1aBSHvJKQozi7IdsyY7zecpCcAI-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic307.consmr.mail.gq1.yahoo.com with HTTP; Mon, 2 Nov 2020 16:00:27 +0000
Received: by smtp420.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID aa129971a4deab6e98284c88780a2fc2; 
 Mon, 02 Nov 2020 16:00:23 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v3 10/12] erofs-utils: fuse: kill getattr.c
Date: Mon,  2 Nov 2020 23:59:36 +0800
Message-Id: <20201102155938.2679-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201102155558.1995-10-hsiangkao@aol.com>
References: <20201102155558.1995-10-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 fuse/getattr.c   | 65 ------------------------------------------------
 fuse/getattr.h   | 15 -----------
 fuse/main.c      | 25 ++++++++++++++++++-
 4 files changed, 25 insertions(+), 82 deletions(-)
 delete mode 100644 fuse/getattr.c
 delete mode 100644 fuse/getattr.h

diff --git a/fuse/Makefile.am b/fuse/Makefile.am
index f54def7a1526..6e639f33f664 100644
--- a/fuse/Makefile.am
+++ b/fuse/Makefile.am
@@ -3,7 +3,7 @@
 
 AUTOMAKE_OPTIONS = foreign
 bin_PROGRAMS     = erofsfuse
-erofsfuse_SOURCES = main.c dentry.c getattr.c namei.c read.c open.c readir.c zmap.c
+erofsfuse_SOURCES = main.c dentry.c namei.c read.c open.c readir.c zmap.c
 erofsfuse_CFLAGS = -Wall -Werror \
                    -I$(top_srcdir)/include \
                    $(shell pkg-config fuse --cflags) \
diff --git a/fuse/getattr.c b/fuse/getattr.c
deleted file mode 100644
index 4c5991e7e487..000000000000
--- a/fuse/getattr.c
+++ /dev/null
@@ -1,65 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * erofs-utils/fuse/getattr.c
- *
- * Created by Li Guifu <blucerlee@gmail.com>
- */
-#include "getattr.h"
-
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <unistd.h>
-#include <errno.h>
-
-#include "erofs/defs.h"
-#include "erofs/internal.h"
-#include "erofs_fs.h"
-#include "erofs/print.h"
-
-#include "namei.h"
-
-extern struct erofs_super_block super;
-
-/* GNU's definitions of the attributes
- * (http://www.gnu.org/software/libc/manual/html_node/Attribute-Meanings.html):
- * st_uid: The user ID of the file鈥檚 owner.
- * st_gid: The group ID of the file.
- * st_atime: This is the last access time for the file.
- * st_mtime: This is the time of the last modification to the contents of the
- *           file.
- * st_mode: Specifies the mode of the file. This includes file type information
- *          (see Testing File Type) and the file permission bits (see Permission
- *          Bits).
- * st_nlink: The number of hard links to the file.This count keeps track of how
- *           many directories have entries for this file. If the count is ever
- *           decremented to zero, then the file itself is discarded as soon as
- *           no process still holds it open. Symbolic links are not counted in
- *           the total.
- * st_size: This specifies the size of a regular file in bytes. For files that
- *         are really devices this field isn鈥檛 usually meaningful.For symbolic
- *         links this specifies the length of the file name the link refers to.
- */
-int erofs_getattr(const char *path, struct stat *stbuf)
-{
-	struct erofs_vnode v;
-	int ret;
-
-	erofs_dbg("getattr(%s)", path);
-	memset(&v, 0, sizeof(v));
-	ret = erofs_iget_by_path(path, &v);
-	if (ret)
-		return -ENOENT;
-
-	stbuf->st_mode  = le16_to_cpu(v.i_mode);
-	stbuf->st_nlink = le16_to_cpu(v.i_nlink);
-	stbuf->st_size  = le32_to_cpu(v.i_size);
-	stbuf->st_blocks = stbuf->st_size / EROFS_BLKSIZ;
-	stbuf->st_uid = le16_to_cpu(v.i_uid);
-	stbuf->st_gid = le16_to_cpu(v.i_gid);
-	stbuf->st_rdev = le32_to_cpu(v.i_rdev);
-	stbuf->st_atime = super.build_time;
-	stbuf->st_mtime = super.build_time;
-	stbuf->st_ctime = super.build_time;
-
-	return 0;
-}
diff --git a/fuse/getattr.h b/fuse/getattr.h
deleted file mode 100644
index 735529a91d5b..000000000000
--- a/fuse/getattr.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * erofs-utils/fuse/getattr.h
- *
- * Created by Li Guifu <blucerlee@gmail.com>
- */
-#ifndef __EROFS_GETATTR_H
-#define __EROFS_GETATTR_H
-
-#include <fuse.h>
-#include <fuse_opt.h>
-
-int erofs_getattr(const char *path, struct stat *st);
-
-#endif
diff --git a/fuse/main.c b/fuse/main.c
index 21f8b0451732..3842fedce8c1 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -14,7 +14,6 @@
 #include "erofs/print.h"
 #include "namei.h"
 #include "read.h"
-#include "getattr.h"
 #include "open.h"
 #include "readir.h"
 #include "erofs/io.h"
@@ -126,6 +125,30 @@ void *erofs_init(struct fuse_conn_info *info)
 	return NULL;
 }
 
+int erofs_getattr(const char *path, struct stat *stbuf)
+{
+	struct erofs_vnode v;
+	int ret;
+
+	erofs_dbg("getattr(%s)", path);
+	memset(&v, 0, sizeof(v));
+	ret = erofs_iget_by_path(path, &v);
+	if (ret)
+		return -ENOENT;
+
+	stbuf->st_mode  = v.i_mode;
+	stbuf->st_nlink = v.i_nlink;
+	stbuf->st_size  = v.i_size;
+	stbuf->st_blocks = stbuf->st_size / EROFS_BLKSIZ;
+	stbuf->st_uid = v.i_uid;
+	stbuf->st_gid = v.i_gid;
+	stbuf->st_rdev = v.i_rdev;
+	stbuf->st_atime = sbi.build_time;
+	stbuf->st_mtime = sbi.build_time;
+	stbuf->st_ctime = sbi.build_time;
+	return 0;
+}
+
 static struct fuse_operations erofs_ops = {
 	.readlink = erofs_readlink,
 	.getattr = erofs_getattr,
-- 
2.24.0

