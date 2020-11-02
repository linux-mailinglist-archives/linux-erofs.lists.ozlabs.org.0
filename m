Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DAF2A2ECF
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Nov 2020 16:58:02 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CPyHW2k1czDqV1
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Nov 2020 02:57:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1604332679;
	bh=KbKcFrTgq91WneYHeK7NvIGHFeTr9on1alb2/IFLwNQ=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=b1cmWOXG0Q+YNPiTkrX0KUtjpxGfzH2DMHskOsiqU6kREOXeAKg4Q3NWMAjj7imqg
	 EeNgBLC2PpFf2MqqC7LJYegQh8uHll92cLmKAglELKBn4nQjlhzrsJbAQldu/h3YqH
	 4bal/kDjBV20LtgiwWB+A7q7eBikH9vJ3lYECYxLbtQndHWdDyKZPQoihTFtdLLhhC
	 4/uX6eMmlexBCECwruXGAAhHTr+g841lLOC5CS0dOucIANAD5rkBDLiqrAz436mDzw
	 yZDiCiViNKwtvnCQ+yXF1J4A0qHg/reCzaDfeTHgA6TTS5dIZ4C4LDc+uiDuoHkHhj
	 lrMZiMED8fiHA==
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
 header.s=a2048 header.b=dMZaDR0a; dkim-atps=neutral
Received: from sonic317-20.consmr.mail.gq1.yahoo.com
 (sonic317-20.consmr.mail.gq1.yahoo.com [98.137.66.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CPyGw0mLZzDqT8
 for <linux-erofs@lists.ozlabs.org>; Tue,  3 Nov 2020 02:57:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1604332643; bh=sDteunkGsnQ/Xqx2QpSdCE568bcnOUEg03nzq5Ml9II=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=dMZaDR0aajRn9p/vbF7vowSBzHynFV/8n6ggLoPzcCOeZoT33+cI1O4jTJqVvv/GBGEugjP0hblvZVghMv5usSDsSVguPVSpSeBurfMlTJ9uAlgHO6ptF3ctsDPajptg6Mi3mDDUZ4/aXWiJi7w1taqqOmVdOmV3UZK8E7m8OMJ2NtvMHgcP2+8bp+nDNsF4Nt00F1CpzRjKcL9zaPNKw2F+vCiBRIsrQV4zNA8cW2O1Q7L4EduxqdGFB5/0pHp3J12m/18AtvYTojsHM70Xdo+mjYMdjexqVUpPq101+I8O0vfFp/z4wMQpNhRWC+gdbDqK+3AH3NOyOfmVDYIW4g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1604332643; bh=xpAyxaTkLn7Y4RNVH4UTwo40ye4FD2Kz9VVzGIQJaTL=;
 h=From:To:Subject:Date;
 b=f156PKkyKzZMZh9hWyLpeyu2CbcAFnVYqF8wKevK3T4dy/2oSLqNuSKTZsjkE5cadBkKFJsOiXbuEXnlV2eZbbxD9zBoC9xWOgvPRDVWMUV0shB5wZ3VkjDiRYEUgstnYgRJL6hEWYqfzLh1Oajh+TElbqrZyXt5J/5HAAs9Y7p9LGN4Fu/JI0klreHhH6m173kcKqpVkOxletn8453M8TCz68gfbSHeo0fuj5iyxK/jihXgFcYYWXu0t/vBaGzTPHU8ln75L8XeVvrRngT7ETdWWmL9f4wUmxKbOVdEKJ70ijwcXfkhyfL6Ny+jAv9c1TeiBFBGDlysOP9E8+Yivw==
X-YMail-OSG: TFgcmvsVM1lwJgedjIHWiLHAduR6VquFjdx9AFk.yaKmZNwIb5ACFNtCxikB5In
 M77daDqot.W8MZr2EXHY_B8k51kCjealkx7UllgXu9KJIkOnin5xBp3_pI0igohlM_HNH9DpKOuO
 WXI3bvh4NzH_fGA6xXBvmjr5mk7Tp_YKCW6xojxj8PnKGEkvvp5jEso0EV5ElScxcIbeU66NenqB
 U7Rq8LHFVNkwzaQXFMqUu5GCjLisMoy9xfemmZgTdT3QzYdBnLuJ_swluOLQo8.RZtU05PyvNByo
 sbiNZXKvBHv0D0n1TX2arkx78ixrVpE4ve5n2fCAX3eYioYC.BDTFyllHqSqgbC7..trQODrDTqe
 by.Cy6axqMFtvZNb9a2o42HaHs7YQ4KTccBOqto6GDPkNhVYXJrUDPdEqhpfQS3PGdXMhLLLdLEd
 zaDrIcQ_Pcnl5btoUxRRSk9OjtD0X22OWmn8D2alTkYiV5uRpgXZ1BD2UAoMdZb.nogl82EHulx.
 MXuOmLoLqNAXPdjvsWIl7PpMzlf40z4OYViLMzvU7tUlJvl_.9XE29yQTPPAxW4sTwJk4rqnoMQb
 QinHgvJa49FX5CUWyal4wFhV75FqRKn5us_GMsk_dp0b.0S3zN7mzwzJLDqtigV7S34p3hQC51tQ
 mpvex1qEgTZpvW7GL6H5eJVLTMJPVlU6fw0LoZqWZesam_UJo9dBmBZcn7z453l72bl1ulsbnCgQ
 lNbT7W_LYNtouoGxMjDY4fHihcsuUtDfoIUEIDMf7OubB34PhOHJcyY.KaHlwcb_wG_pT3uF3gE.
 58clMZ4dTwR8U2Z64rg6KltSHnGtq9Uz_MOyRBnnn94iaR8f38wmE3jGH2xAdsRfxEhP0D.ZIFJu
 K79GM6L2IOpT1ZCetiosnu5n4D5DMrtdCYG_bAq4ETvo4a0PS8Bu89fmP5IsJjQ7XNXbXPKlHXlv
 bvKzbHkMh3suLJTusW2oNo2DhiubcKMfa3_R1G16E5r5.T3TxNSq2e.3SZ.K6JpsKf5vJM39GaVB
 jj2zoq4sXhQGL0jEN2z1vvZiIoMz3NTNCZwJ_L90g82u_Pl56RpVfcW1Zmz8W1YcGDW1snR.XINs
 8PYeBB2swtgcUm2da5It8Q.rXgCkrCy.t1G4BSPtXzYoJd09ujPZkX9kCx6kp8le7vHOOlUL4XSt
 nu1qDpyRlZKhmTLbyYzkwJiA_IGmxVY3hCVWhrsutsx0zqQJa72jGQEMzCFSBLjnSfGSSa7Mlkhn
 fEFAexfakeW9gGBTQK4toZpWlidvp_3YcXCorLwVDVMO.EIAvT9p8YHpTsK8ZeT2cJhYTNJTfxuM
 suyhhEm_.ZGDs84vGxupPxtRK3wo9eTW1LV_wRvkTo1SEPR0VyzCDzlFcDMNrdmWS2qTSJMlVam2
 cwDFccwlvUTfkBY0VDSYUuBEcXa7h44eyzqo6AigSUePYP7_6RkpWzj1rI3xIi4EwhLqkOX4VzNN
 fSNjJiFEIMCiyjJFFnZ74ev2azxzpKjJ4hG6VcRAKHAXGyrFguQFXuH7ufGfSVurSUWnxWKl8cmI
 Z42mg7BgT8BW0x4tuQv3ThVQ08qX9iDnedyQchgQpmbp1AeLSpN..9F5uIadErQsfYOI7E2fMm53
 WJTyy.f3plc3WhiZs3J4aA3jJHxO2gSGODWZjS49_IuXAtm9RbQhSPlEUa6CrYd6_Oh2C9SbrEEC
 s0dybNijuhqEttf6EmbM5X6P6LU7NKDoCw0A6T_vbq2o7emduopg9hittx5GBOfHIVZT74ZPbKgI
 c5zsfjXnzc_hQi5tprsq3WpZHGbG.dep_I2pKQMaEoerU2QUqvzFCVoXOvuxxdJvL99a68i_iHx6
 CHI5Is_jZ3Rtpx6f6c1qq_3Bm8HW2zcwZOWANRFCNeJLy9PmF0i.8rIusXQqgXjZGXAH43DU4gfp
 6riN7RkhMUiGPR4tRMvIE63nD73mx_ppkjHyPKx9I9bWitQxlcTCe9fmrI3waNKgNhAixvcX91aV
 DNms5vddumHgxhues__nTTS9gtxITICTrOrsKWdXYITQyznggeCQj025q0J38u4oVR7Tqgt6.rs8
 x_yXPsmJjDE0nvBH8MPYCYWuYI.higt404s2zFMdgsD5davgIdvrEz6v_m21WPu7UU5zEzFJz2Nl
 .pku6IT6opTtGWbgxKiBVyv8eL6ODlw0uywGYH7lTVAzk8m3ZgIXJaTl9t41zL7AULcXWkCojo2n
 0uBGCrTuZ6ADARHFCOv3MFoTYy9zFsLV.xJXC3TBvWEerI2mR3uqMNz6Z5raZt2.4fBY44J5tjER
 Niyj9pDXllUWDykc8QYLKxl_v0EMLI2UtbY402AdM_Cs83ilPZgFRyUSBP99o54RdLPic5Ao5jTu
 1hPEH4ItWBdkl72j52yWCqQh9B943q_dWXmJOML0Yg5zluLkMZrarB5Oowpvs8of4X0mW1Ylv8AK
 04nHYmVqDlLqFcSPxGXmxUFvtmtjhByuAkbSK53FnR3j_8jKDPIZ6MPlxwLhxEtv4aALmmsWkdt2
 iGUvKmZyoof8WH0FlztnWUD67BxM1zFqbtgUugnXDhYg.4jr.IE43Fnvc8bFk6_wGSphGGZ.w4vg
 r_KK32kGhn7hL6A90b0Pc8mPiJyoK00bcZWYO8tSBS7cFW7QCv817a6SuElEOG3ZsLSMbtGzA3YB
 moL534JQRsKwbapYJHEAr3qggkm6R8Li.8jirJbahu7O2OdkObUYb0OepG5Swqw--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic317.consmr.mail.gq1.yahoo.com with HTTP; Mon, 2 Nov 2020 15:57:23 +0000
Received: by smtp404.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 0de93bd81f6e7581799539af1246db07; 
 Mon, 02 Nov 2020 15:57:18 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v3 09/12] erofs-utils: fuse: move superblock logic into
 lib/
Date: Mon,  2 Nov 2020 23:55:55 +0800
Message-Id: <20201102155558.1995-10-hsiangkao@aol.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

(will fold into the original patch.)

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 fuse/Makefile.am           |  2 +-
 fuse/init.h                | 19 -------------------
 fuse/main.c                |  1 -
 fuse/namei.c               |  1 -
 fuse/read.c                |  1 -
 fuse/readir.c              |  1 -
 fuse/zmap.c                |  1 -
 include/erofs/internal.h   |  3 +++
 lib/Makefile.am            |  2 +-
 fuse/init.c => lib/super.c |  8 +-------
 10 files changed, 6 insertions(+), 33 deletions(-)
 delete mode 100644 fuse/init.h
 rename fuse/init.c => lib/super.c (94%)

diff --git a/fuse/Makefile.am b/fuse/Makefile.am
index 2b2608f57b03..f54def7a1526 100644
--- a/fuse/Makefile.am
+++ b/fuse/Makefile.am
@@ -3,7 +3,7 @@
 
 AUTOMAKE_OPTIONS = foreign
 bin_PROGRAMS     = erofsfuse
-erofsfuse_SOURCES = main.c dentry.c getattr.c namei.c read.c init.c open.c readir.c zmap.c
+erofsfuse_SOURCES = main.c dentry.c getattr.c namei.c read.c open.c readir.c zmap.c
 erofsfuse_CFLAGS = -Wall -Werror \
                    -I$(top_srcdir)/include \
                    $(shell pkg-config fuse --cflags) \
diff --git a/fuse/init.h b/fuse/init.h
deleted file mode 100644
index f0211707b5ff..000000000000
--- a/fuse/init.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * erofs-utils/fuse/init.h
- *
- * Created by Li Guifu <blucerlee@gmail.com>
- */
-#ifndef __EROFS_INIT_H
-#define __EROFS_INIT_H
-
-#include <fuse.h>
-#include <fuse_opt.h>
-#include "erofs/internal.h"
-
-#define BOOT_SECTOR_SIZE	0x400
-
-int erofs_read_superblock(void);
-void *erofs_init(struct fuse_conn_info *info);
-
-#endif
diff --git a/fuse/main.c b/fuse/main.c
index 30e4839bdcb4..21f8b0451732 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -12,7 +12,6 @@
 #include <stddef.h>
 
 #include "erofs/print.h"
-#include "init.h"
 #include "namei.h"
 #include "read.h"
 #include "getattr.h"
diff --git a/fuse/namei.c b/fuse/namei.c
index c3766f9a9f02..4c428dbc59f6 100644
--- a/fuse/namei.c
+++ b/fuse/namei.c
@@ -17,7 +17,6 @@
 #include "erofs/print.h"
 #include "erofs/io.h"
 #include "dentry.h"
-#include "init.h"
 
 #define IS_PATH_SEPARATOR(__c)      ((__c) == '/')
 #define MINORBITS	20
diff --git a/fuse/read.c b/fuse/read.c
index dc88b24eaae3..10a26d84c37c 100644
--- a/fuse/read.c
+++ b/fuse/read.c
@@ -16,7 +16,6 @@
 #include "erofs/print.h"
 #include "namei.h"
 #include "erofs/io.h"
-#include "init.h"
 #include "erofs/decompress.h"
 
 size_t erofs_read_data_wrapper(struct erofs_vnode *vnode, char *buffer,
diff --git a/fuse/readir.c b/fuse/readir.c
index 496f4e73a9c2..5281c8b80e59 100644
--- a/fuse/readir.c
+++ b/fuse/readir.c
@@ -15,7 +15,6 @@
 #include "namei.h"
 #include "erofs/io.h"
 #include "erofs/print.h"
-#include "init.h"
 
 erofs_nid_t split_entry(char *entry, off_t ofs, char *end, char *name,
 			uint32_t dirend)
diff --git a/fuse/zmap.c b/fuse/zmap.c
index cb667da4e0c8..ba5c457278a8 100644
--- a/fuse/zmap.c
+++ b/fuse/zmap.c
@@ -9,7 +9,6 @@
  * Created by Gao Xiang <gaoxiang25@huawei.com>
  * Modified by Huang Jianan <huangjianan@oppo.com>
  */
-#include "init.h"
 #include "erofs/io.h"
 #include "erofs/print.h"
 
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 306005dea2a7..e56fd1898f3e 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -259,6 +259,9 @@ struct erofs_map_blocks {
 	erofs_blk_t index;
 };
 
+/* super.c */
+int erofs_read_superblock(void);
+
 /* data.h */
 int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 			erofs_off_t offset, erofs_off_t size);
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 54c43897aa49..487c4944479d 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -2,7 +2,7 @@
 # Makefile.am
 
 noinst_LTLIBRARIES = liberofs.la
-liberofs_la_SOURCES = config.c io.c cache.c inode.c xattr.c exclude.c \
+liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
 		      data.c compress.c compressor.c decompress.c
 liberofs_la_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
 if ENABLE_LZ4
diff --git a/fuse/init.c b/lib/super.c
similarity index 94%
rename from fuse/init.c
rename to lib/super.c
index a5694beaf519..6213585c085d 100644
--- a/fuse/init.c
+++ b/lib/super.c
@@ -1,22 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * erofs-utils/fuse/init.c
+ * erofs-utils/lib/super.c
  *
  * Created by Li Guifu <blucerlee@gmail.com>
  */
-#include "init.h"
 #include <string.h>
 #include <stdlib.h>
 #include <asm-generic/errno-base.h>
 
-#include "namei.h"
 #include "erofs/io.h"
 #include "erofs/print.h"
 
-#define STR(_X) (#_X)
-#define SUPER_MEM(_X) (super._X)
-
-
 struct erofs_super_block super;
 struct erofs_sb_info sbi;
 
-- 
2.24.0

