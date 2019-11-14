Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6E5FC836
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Nov 2019 14:57:39 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47DNN10B8tzF4x7
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Nov 2019 00:57:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1573739857;
	bh=cuwyGFT2m39/hYHhaT+1rpO4HyH4NrBrwgKemLtoFMQ=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=n4jJVrAfFUdZPHOAD8myUDcK/6bZ/Cnsa1SaF+rlCAWVRJ4PpTf8FfDTNTmHpO3eB
	 Ve9IYwXQixUaJiklsxw3A0cTvHFJjJXtQxuQuRxK484CHC8mx9MzFfLoRIuy9yRyiu
	 szUm+pY/noosFPkLZ2qlyuzLxTOAyUvY0RNpnDepFv4ENIr5d5tmeinmkPOitQBy7q
	 10ewVzoLpEcfXNvjTEjh3yJfLvqYo4pOnpmhoyranA3Cc6FJQbXm0YK4jREnrHMjC8
	 emBQBagioRa9Q2uhaGmK+oFqYcPrrKLVuMOgm1h346Sreg/lUU7m7AjzupasmzNxP4
	 ZQoTzJP/ftpGw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.147; helo=sonic302-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="r6B9sIAx"; 
 dkim-atps=neutral
Received: from sonic302-21.consmr.mail.gq1.yahoo.com
 (sonic302-21.consmr.mail.gq1.yahoo.com [98.137.68.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47DN6S5TqhzF7gY
 for <linux-erofs@lists.ozlabs.org>; Fri, 15 Nov 2019 00:45:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1573739146; bh=+UYswj7I8buuSGF12yDYq6ITT8dtlmNJXeefE9Bg0LY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=r6B9sIAx1xMPT3YRv4Sw+PAO4ulw4DFPvHPZCT5gDWB9pwHLcCUMCZBHGt8ruXakojByG8uk0O3NgIDTTrLUO6ZYaUe9YQVPsxEWpjHj14GCOX8iixifpGYJ2YzRY5N/f/qYSTWoUMbQyYB3lSMvjTuH3ULSDUx6R+/vxl71w5N7YeJDSupApkGSB4thiAdGEKaf0OjoaTul4m4KFINx7O4swyuj2m5X9T8EpWPuSG/P4JYBXOST4qIBo19hhW7LkSSoRLkW++Nw9O9/bfinnZ30MyL6MXOp7oonoT8I4X1i4gUJ6RgBhwd9uLNAB+fmwmHwv1A16+ymslTDY1Q18Q==
X-YMail-OSG: t6_hmfYVM1nmD3L6Sn4a0gSDjabu02e.0aM_x.WQREp_3RMez5A_j7Is_LqVGYG
 oKi6MToFZDSQQ.INAGbCqWG9ZmlL1XfZsn_5W.xyos6rFn57ug5xodURTovL9d9wYgCV8uXcJ9N1
 Gfu78AbWBDYLDGtGSBYtlIMzB4bgel2H8WhgMrqWj.PvuEqGTMax5UOmS0CAnfJ1zynBqf44aK1M
 DgQDTMxhtUJXH5Us282pv_LquSXbYXRjt7CYQGNuTKERDx0iUjMobaOiPB8592CHAmvuS9zYQzHo
 3KakkFXcGTAuLMOQd6qja5.FwXZ_Oux2eAdWqAvxy.YjryYpBXKSlUAOnMcA7VC12LyvFl7GHeop
 zIhABUN9qBR9Z8Fz0H4C2Ok5KczAbE10sjWfuEa.i7y6RpfPa7wihhF8qleFdlN7APKoL4TYXORM
 8ux_4_L6xt9XLegWwjv46GPXemw8fbH3hV9uiK3Ts9xeJZMhL1_2oHfTqd6anP3g.WAByP7whyGf
 vovLjgJOFeRzcmPBwNpESVl6KV4DWn2qITRUtHu.ilJhk.G_ne93Abp0Gfth7bffOgiEVtXX_Ay1
 WiQ3c2.vTIpymQzZu4CZfrCsLq8G6Vp6aergxO.aVwla.7L6nlE1V5FrL8SzFYZ0vHR1SIzJyHjv
 oY3KMleP3KU65N1DM86M6bu.xPyLPnQWNlVnHQ7ZtW6zomi9kAnCgtnDqLro6i7HXavUFVbLg_QR
 9LE44IMxKXUytc3xsAMReKs4kM.TnQo826cy0yiXwm5g7412jEqkMq8tdVE93XezT5WYqoKUxYHz
 BI_MGm2AfYBgusU0C2Aw4tdzpw6cIGv_RLSgkxiBngnLl5q5cjiy9Rod.XuVC60_z1eV.Fb5e3Vp
 BKLiCDFM9FNVGx_NWrvjmIYLlbRzMjvN1fQ.fJ5A2yt7HTWlxM0xEyxg6RMEjDkkeIZuNH.ahEu6
 4nI9wPSxkuT3svZ_sq2K2tis6H_NWumSe1YjnU2nv7yAlpe0C3uh12ieiMsuJYdnGb7jwwBwREYR
 yQK8sH3U_FpqKP.oAXwnzMC6uS92HZzKU9sBGijqKIn.dkOVQN5mWi4lpM_yw3yyLc78SvzYdp03
 BHdLCGClt5O80gqOL3UbKoQ_XEi63WHuLJYsHM0dcuI0u1mYt1PfMCPymzvuc263Wy9KgSfnxmfb
 Iyn3AchQDcSx7B.1_Vyk3_D.d9wRhg_bVuCvHv0lkgJkrgjX5REsehBtm5U5pXVpMeX1xxlsJtbY
 2IOGIb6xCWu3zy4WKTEtlMPOv6vT95GUCFvcjTztk6vDbXjRTzx5BvEBagzsMv04DD9c8u.Uo5jK
 2DK13N0ZqJ.2ztgEAXGJ.DTZ5WaeyEajBI2sSOJlnVC66nUWeE3MqwOjB.zYOR32MrNNoY5Qmi3H
 j9z4qiAlFU0MLEx5d64_a
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic302.consmr.mail.gq1.yahoo.com with HTTP; Thu, 14 Nov 2019 13:45:46 +0000
Received: by smtp413.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 3c6c0dd42c75895c3efba6a59184fdcb; 
 Thu, 14 Nov 2019 13:45:44 +0000 (UTC)
To: Li Guifu <bluce.liguifu@huawei.com>, Chao Yu <yuchao0@huawei.com>,
 linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: set up all compiler/linker variables
 independently
Date: Thu, 14 Nov 2019 21:45:21 +0800
Message-Id: <20191114134521.12416-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191114002651.GB2809@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20191114002651.GB2809@hsiangkao-HP-ZHAN-66-Pro-G1>
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
Cc: Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Otherwise, the following checking will be effected
and it can cause unexpected behavior on configuring.

Founded by the upcoming XZ algorithm patches.

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
changes since v1:
 - rebase the patch suggested by Guifu.

 configure.ac | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/configure.ac b/configure.ac
index c7dbe0e..f925358 100644
--- a/configure.ac
+++ b/configure.ac
@@ -168,7 +168,7 @@ if test "x$enable_lz4" = "xyes"; then
   test -z "${with_lz4_libdir}" || LZ4_LIBS="-L$with_lz4_libdir $LZ4_LIBS"
 
   saved_CPPFLAGS=${CPPFLAGS}
-  CPPFLAGS="${LZ4_CFLAGS} ${CFLAGS}"
+  CPPFLAGS="${LZ4_CFLAGS} ${CPPFLAGS}"
 
   AC_CHECK_HEADERS([lz4.h],[have_lz4h="yes"], [])
 
@@ -187,31 +187,32 @@ if test "x$enable_lz4" = "xyes"; then
       ])
     ], [AC_MSG_ERROR([Cannot find proper lz4 version (>= 1.8.0)])])
     LDFLAGS=${saved_LDFLAGS}
-
-    if test "x${have_lz4}" = "xyes"; then
-      AC_DEFINE([LZ4_ENABLED], [1], [Define to 1 if lz4 is enabled.])
-
-      if test "x${have_lz4hc}" = "xyes"; then
-        AC_DEFINE([LZ4HC_ENABLED], [1], [Define to 1 if lz4hc is enabled.])
-      fi
-
-      if test "x${lz4_force_static}" = "xyes"; then
-        LDFLAGS="-all-static ${LDFLAGS}"
-      else
-	test -z "${with_lz4_libdir}" || LZ4_LIBS="-R ${with_lz4_libdir} $LZ4_LIBS"
-      fi
-      LIBS="$LZ4_LIBS $LIBS"
-    fi
   fi
-  CFLAGS=${saved_CPPFLAGS}
+  CPPFLAGS=${saved_CPPFLAGS}
 fi
 
+# Set up needed symbols, conditionals and compiler/linker flags
+AM_CONDITIONAL([ENABLE_LZ4], [test "x${have_lz4}" = "xyes"])
+AM_CONDITIONAL([ENABLE_LZ4HC], [test "x${have_lz4hc}" = "xyes"])
+
 if test "x$have_uuid" = "xyes"; then
   AC_DEFINE([HAVE_LIBUUID], 1, [Define to 1 if libuuid is found])
 fi
 
-AM_CONDITIONAL([ENABLE_LZ4], [test "x${have_lz4}" = "xyes"])
-AM_CONDITIONAL([ENABLE_LZ4HC], [test "x${have_lz4hc}" = "xyes"])
+if test "x${have_lz4}" = "xyes"; then
+  AC_DEFINE([LZ4_ENABLED], [1], [Define to 1 if lz4 is enabled.])
+
+  if test "x${have_lz4hc}" = "xyes"; then
+    AC_DEFINE([LZ4HC_ENABLED], [1], [Define to 1 if lz4hc is enabled.])
+  fi
+
+  if test "x${lz4_force_static}" = "xyes"; then
+    LDFLAGS="-all-static ${LDFLAGS}"
+  else
+    test -z "${with_lz4_libdir}" || LZ4_LIBS="-R ${with_lz4_libdir} $LZ4_LIBS"
+  fi
+  LIBS="$LZ4_LIBS $LIBS"
+fi
 
 AC_CONFIG_FILES([Makefile
 		 man/Makefile
-- 
2.17.1

