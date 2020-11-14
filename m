Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9172B2FB2
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Nov 2020 19:28:28 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CYP3Y3PSdzDqJf
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Nov 2020 05:28:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1605378505;
	bh=9Jhtdva+kqK0eUe4CGuj9ebs2XbKXbc0vQl2WmX5dtA=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=N6Q35Xpyr1LeAw9LcKAOY/aNayjT7m4ATNuS6AOyGueOXDHPzhGZqOQrPC7PMPCQ2
	 2avaED7YSVMK6K0ujp2N57D9wx2J6ZCX8kIYMWPtZ6s/4nQ9Nlf4aSktpS9Nm3Ckmt
	 Nt721Y+iKJ9H0tIovECJzb0cDwA8knRh90zCTCqdAXXvlPdIJyGXQ02wJI72AqEySZ
	 lVIA9wNIGMRdENy1UyMBuxqwrGYrZTqSuJgEZUd9Bz4HVXAcEElhk3QPvBSqUTA3rG
	 TCNezMGedjJsP+fwvvd5PcRiVV9PY07U4Dho9PM8aCOHWQvJtVUgKIysjg0U3hqkU6
	 Zjvs7U64d6fdw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.83; helo=sonic313-20.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=EO97GwFr; dkim-atps=neutral
Received: from sonic313-20.consmr.mail.gq1.yahoo.com
 (sonic313-20.consmr.mail.gq1.yahoo.com [98.137.65.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CYP3R5khVzDqLn
 for <linux-erofs@lists.ozlabs.org>; Sun, 15 Nov 2020 05:28:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1605378496; bh=ttHSCFC5cNjM7qIXOZfQc+3KSuvMVzKslGrCFx2fiys=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=EO97GwFrXZxlnkTJcMuoDWjlHVdhiGiN3CzgcmMU/KPCUDmgJaYJAezlfrX6i6Vn7Bjw6AOWqzbyQWXyA56BayYXZfEgtBbmUSlHTq4017kmXGuRMg6Y8Ts3fsilK0gFffsNxDACzDogDTzJ8hAxR0V7+P1DSPyPGuGWueEsIPzgUtG4qcFlg2b967nwItb2Gew5bZwd5iXrw9WLK7MEchhtCXrQghHICneVejAhXBUONmv9sxY6h8zYBrC+UuF/jPs6diOmy+ooYJpe7oBDXcVqNn6c4CExqOQfczpMU9AcmSRKL7ihegBvmA2TwXjIX/8bQ478hsy9nebc64kKHw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1605378496; bh=g0ffUlFSPpkg7aLp31L7VaoqaXPbacrBklQZHXpbnG8=;
 h=From:To:Subject:Date:From:Subject;
 b=Hx7kFqztbnDb8Yrmr2zDFEFtDyG04YVrGGz+zIlIIokcFxZtjo7U8dYKaNwHrnfZVSoNEIh80SjHdVhn/T3bmPUXFzQOlYVFWMelng0Ns1xiqOdKTXK3zjOvXl3hjcgAsFB9tTK7nroINqGlfPu2P3VY0a3tjFhVEJOZGV2IqVtjsIHrB8BjFWDNdmuqrcLQzlfVKeaNrsc25xwXoPy7Qp7VzLm+fMe8FIaoPmFxu4zVVgfutXnbGRNz9Mr3m8FqDuSZKjFDXTeo8B9tkuBxIgmM0RLdkT/lH94/lmeNi1pSfIX+hPcyduVYJxBNk+6SHKL7v8WwY1JWZ0T+jLUKRQ==
X-YMail-OSG: GLneDYYVM1lXedvw9HwpW6wcFtkFpxQoH4qx8qLGEXPoPzcKA2osNSWzjLbEfap
 Nf0gW4pqXIr6PGZ5wvT43qMXHtv6GgLXrlzHhMxm8067vvT0mj80mjK4F4tAG_mOjv.OX_DXZmxb
 _s6sFwWCks42g1THSGg_Z55wOy7nnDgDd7QYoRmTDJyYs_JFHkFKWxQe3UVI3jUWo3l4AN3P_Txy
 tNdK5YUYC8mti0OQz5lz7GgyToIsfCQ8Opf18rUfN.nD2VzX9j4zdFwNKOUHWoxxd9_CtPZVJw20
 aelCeQG0uWGYBwm4gGW3oMVybF6ra255zAgfY5B26eFw1xmWqgXgNCzA65V.dMW2z8YOZekJjUg_
 eBryAXmk6H4nWUbvUN3gsAAChtMCQIlLMEVV.pXc3ZvPxrHicxsJw7xnplgM21ifGpo9wjmoaFsG
 Lo80QhkytxWig16MGTjG70jyjHmEfMB6IB2OkIbkAabTKk_mdPiBnVmvbh92ZSxdx_A7TfTI3H_h
 DBkz5lRiLErDFY8fSYaJAyMG14PrM838RXuMAQ_s5blf9QKw77PrMGHdQGIpgXRT78WAtg3D15L4
 sj7NnCdFZutkS4e1p1SOuaYKS4C03Pr4NQQvcQFEJsT5QwQKQO6urMYYkge3GaWhpjyv0V5X_jue
 3_cFoNeYu4Tcpn8ldbGssqk8GuUkfUt.JNQGvdtvvE9OZdfzrqsgpdr.1ATj5YJtdGB4OuTutLwJ
 KnjPPD0rNCWcw8nkqje_dGbRmqYCMrDMoRPC6IB1XBlQs.uaVQ11ql6AvzkFabPkdHPc8kJwj4Mc
 G.3UlGuvcmIav.MlcC2erkgcGkEru6XF4HnI2VUNE1Xi.Ps2DUm2m9_dUVj0iAhbOSpFq_OAD1KT
 hgBErsl9SPD6EQsWTyRBLtDoY_pub4ZKD8CvNtZWClXt3kmVocw6__j_5hzM2tlPRX.2KQPSPhLD
 JR4Vsm5P4HeTpH6G7Mz3F8wivJH8OA03nuZphPH5CaZ.RuGL5wHInv.2003lUUodC0TFqB8nXpNk
 WL2hpdDv12v8uCmOOpWr7RjXkCEVtmqQFW7M4V8pRxcSr.k.5faXqP1La7bMW1cOZ6ZJti672iVX
 pvCDBkvqLDxrwr0dLQmY4DrRqYxuk.mdEi3HFPiyg859dyWqHhN5Wf_fWNnLQpDJDaN5RxAlzq6h
 GB9nYW_FRFUExJTBBvfGO_25zUW7ja6MG3zO2gIARkE8t6f44b8izxdOTSF.ae6wIbyRykjX3ykQ
 7R1p6Rdhx71S9OVLuWAeCD0Eaddk__Ns1YZ3inPEOeGBaESz1uSFidDD7iYJnVxd4QEbHzBbTg0u
 LhGwJLFc_dLswZYrhIR3vJij6Nh18c2lnAklxwClkVCADdbgqKNULOmfpd16vHpdHLXp6Ne5_zFQ
 ZiYRybcU2kXl3IaCRGvbf2nPOGDMzmUCTMfbSJr_Iv45Gw_.BP1.q7jxyr1vau.ECExwgGmtTwS3
 cY1wHRE2Xj1WTF1eifmdSR.3ebUvrVTyMKEtZSOubQf9Wq49SLOmqjjJgjaXZUG84heLjkcgcjru
 Vlo.i9qQXWj0g7KcrKYzuzMupITY7yZlLBkSkQIrSYPp2EeHV5pJmuIiwNtePb.d1tlnsIQbuHnn
 eRG6GbMc8pTOBhzTWLF04deShv6HnwUoUEcSNEY3w9FU9IrmVMWu6w.oylk4cXT8_PBV8AqZ4n3m
 SDgVKYkVwCpDO17pGb09b91OJmS561.KBOxf3m7MbrZ1TL3G3u6uJZvjfOeR7jNz4VvERjOc5Rfy
 NL8sRxqBpTSnMtrPIka9Xi0iisM3znWN7I_YZsTLEw7a0KOP1qd7rpt6Iuu9LKi_Pjwnmu5Bpin2
 T_EG0XJMQACDG7rK53A4jQuPiYmw5LCo67NT5z7RmwwquC.Es4kFyr_C28lD2XarbcM_isM9Lt_d
 qoGlE8WNQPgoH8by5S3LB83e8T61CzF5M8DOLbxyaR9iqVz6u06xvfKbEn6C5ljihJDgau412m49
 k1J.Kx7.gLzb_C9Xlbl1wwAgH1CWY_tZAZGAX1wdHrT5JkV8u8_Ban8Z.63w2hOu.D9EuHzb2nDh
 nR8W.8dCQ4Ket8V3RtWfIQqAD.v.exIxIHYqvN2epmpsqKEX40kWaheSVkHXTlXXD4q35_ELczVq
 ZQWFPlBjr1rWnCftfINJ3EO0scFFie9reUWMInZfngLFdP4AXb9kqg5Jymv.QWELX2FcMlREPc5Q
 CgWmJ7VlIARccOUMmD4lyU9FuE.QF2NYY6IlWH2qmRZq6d1gxLLXHKwLv1b7r6yAGXk5OQFCfr.z
 LhoWGyz3BR_wp8riNh0Vzqp51J_A9tnNBGWJjQTHoNeAEqkxitzkM1B3I_fQqaaiBT4ZH2h_xZsQ
 ygExjwYpyAzSpLXRQaLLRNdM_SXE_v3UQSxeJKjJUPVFH3vryOcwuSJWtTw7YWyto2mveYCC8gZL
 7PunLYSj4IXWotaGg1QP2J5W1SUeYv0T.rmI2Ay87rA8cso7SsT9uZZzSfwTJ6Zie6P5hG_Xxp8H
 mXvs8m8lS0Oh0_EPlkXyTfDz_L.AGE8ECsRyIwIxmhrqgnc8wvIMwl496cuGSJSxojZJhRe5.Xvp
 WvvRNbE2uz0Mfahj_fmk42x_.Qo7Emx31VEg9dF1HJTQy.OvTOrYHGaEC5tfSJLu.v9Xkon3vITc
 JnJbEfb0Cx8LwR5BN.jhtSdG7awSUyBiwGQ9E6AGkdq9CvGBesbyrIfxibP0JCgffmnLPTQ--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic313.consmr.mail.gq1.yahoo.com with HTTP; Sat, 14 Nov 2020 18:28:16 +0000
Received: by smtp420.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 1d0fcb25c7973fe782c79ebccd4a2e5a; 
 Sat, 14 Nov 2020 18:28:13 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v4 12/12] erofs-utils: fuse: fix up configure.ac /
 Makefile.am
Date: Sun, 15 Nov 2020 02:27:50 +0800
Message-Id: <20201114182750.10089-3-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201114182750.10089-1-hsiangkao@aol.com>
References: <20201114182517.9738-1-hsiangkao@aol.com>
 <20201114182750.10089-1-hsiangkao@aol.com>
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
 Makefile.am      |  6 +++++-
 configure.ac     | 19 +++++++++++++++++++
 fuse/Makefile.am | 10 +++-------
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 24f4a7b3d5ad..b804aa90efa9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -3,4 +3,8 @@
 
 ACLOCAL_AMFLAGS = -I m4
 
-SUBDIRS = man lib mkfs fuse
+SUBDIRS = man lib mkfs
+if ENABLE_FUSE
+SUBDIRS += fuse
+endif
+
diff --git a/configure.ac b/configure.ac
index e6d2e5fd3702..80d38d0ef952 100644
--- a/configure.ac
+++ b/configure.ac
@@ -63,6 +63,10 @@ AC_ARG_ENABLE(lz4,
    [AS_HELP_STRING([--disable-lz4], [disable LZ4 compression support @<:@default=enabled@:>@])],
    [enable_lz4="$enableval"], [enable_lz4="yes"])
 
+AC_ARG_ENABLE(fuse,
+   [AS_HELP_STRING([--disable-fuse], [disable erofsfuse @<:@default=enabled@:>@])],
+   [enable_fuse="$enableval"], [enable_fuse="yes"])
+
 AC_ARG_WITH(uuid,
    [AS_HELP_STRING([--without-uuid],
       [Ignore presence of libuuid and disable uuid support @<:@default=enabled@:>@])])
@@ -183,6 +187,20 @@ AS_IF([test "x$with_selinux" != "xno"], [
   LIBS="${saved_LIBS}"
   CPPFLAGS="${saved_CPPFLAGS}"], [have_selinux="no"])
 
+# Configure fuse
+AS_IF([test "x$enable_fuse" != "xno"], [
+  PKG_CHECK_MODULES([libfuse], [fuse >= 2.6.0])
+  # Paranoia: don't trust the result reported by pkgconfig before trying out
+  saved_LIBS="$LIBS"
+  saved_CPPFLAGS=${CPPFLAGS}
+  CPPFLAGS="${libfuse_CFLAGS} ${CPPFLAGS}"
+  LIBS="${libfuse_LIBS} $LIBS"
+  AC_CHECK_LIB(fuse, fuse_main, [
+    have_fuse="yes" ], [
+    AC_MSG_ERROR([libfuse >= 2.6.0 doesn't work properly])])
+  LIBS="${saved_LIBS}"
+  CPPFLAGS="${saved_CPPFLAGS}"], [have_fuse="no"])
+
 # Configure lz4
 test -z $LZ4_LIBS && LZ4_LIBS='-llz4'
 
@@ -218,6 +236,7 @@ fi
 # Set up needed symbols, conditionals and compiler/linker flags
 AM_CONDITIONAL([ENABLE_LZ4], [test "x${have_lz4}" = "xyes"])
 AM_CONDITIONAL([ENABLE_LZ4HC], [test "x${have_lz4hc}" = "xyes"])
+AM_CONDITIONAL([ENABLE_FUSE], [test "x${have_fuse}" = "xyes"])
 
 if test "x$have_uuid" = "xyes"; then
   AC_DEFINE([HAVE_LIBUUID], 1, [Define to 1 if libuuid is found])
diff --git a/fuse/Makefile.am b/fuse/Makefile.am
index 4ed4215b9936..6636ee1aec69 100644
--- a/fuse/Makefile.am
+++ b/fuse/Makefile.am
@@ -4,11 +4,7 @@
 AUTOMAKE_OPTIONS = foreign
 bin_PROGRAMS     = erofsfuse
 erofsfuse_SOURCES = dir.c main.c
-erofsfuse_CFLAGS = -Wall -Werror \
-                   -I$(top_srcdir)/include \
-                   $(shell pkg-config fuse --cflags) \
-                   -DFUSE_USE_VERSION=26 \
-                   -std=gnu99
-LDFLAGS += $(shell pkg-config fuse --libs)
-erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la -ldl ${LZ4_LIBS}
+erofsfuse_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
+erofsfuse_CFLAGS += -DFUSE_USE_VERSION=26 ${libfuse_CFLAGS}
+erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la ${libfuse_LIBS} ${LZ4_LIBS}
 
-- 
2.24.0

