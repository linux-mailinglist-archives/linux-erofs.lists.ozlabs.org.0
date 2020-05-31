Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 419971E951D
	for <lists+linux-erofs@lfdr.de>; Sun, 31 May 2020 05:47:04 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49ZPPc5ljTzDqnF
	for <lists+linux-erofs@lfdr.de>; Sun, 31 May 2020 13:47:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1590896820;
	bh=zRq39ZBGZ3+tzWkVTaWefLlHjocuimLRH+CjbGzbTQY=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=IYKg39CEM5hIusgN7WlrXX84yeYak+XDwwzhTTptLTomcoEsZ9+ZOENsh+/MjXSNx
	 rkBKOmbJ1a30hEThip0ISFlC7g/0e3qRr8vP+SHp09Ba9sb7z9zx8937GTPr776aG0
	 +Wh4BfWsfyoh8FVJTpu85e6iTF9EBOmJKLu03lZJNZpPdt4OYK3cUS077AnlUPRuh0
	 4OI9I2UR/4NkrDztPWJbNSXUxtj4XflgiC4ek2Q3euOCVSV1sW/snznyP3csOjyJjV
	 gXhbMhBGYehNlEF/9wuGUfCtMJdSoI1n1aJtbrvotLQpa5Z1cdUVOmFu9xVpDeDP+j
	 ZubOZSel114rQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.32; helo=sonic315-8.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=Rvh5lMmp; dkim-atps=neutral
Received: from sonic315-8.consmr.mail.gq1.yahoo.com
 (sonic315-8.consmr.mail.gq1.yahoo.com [98.137.65.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49ZPPK101BzDqll
 for <linux-erofs@lists.ozlabs.org>; Sun, 31 May 2020 13:46:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1590896790; bh=xdFQm7rd/nhil61+7Rio+EQwcxwC4Zi/mGglVzz3gx8=;
 h=From:To:Cc:Subject:Date:References:From:Subject;
 b=Rvh5lMmpUaD8uAWUyFKki/mW4vBHX1k814EhDGHaHyc/ymj4fuI4fpcdacIgZCNaezA2PsEr0g75CdfSOCPnIJ85wpMGzUn3kPNExft/H4wpdbwumM0bn6GLU8SBFzBxDPAarnlgWdQf20EeSSmyV8s0YSDM85NShCEIFR+bDUZ07sTjpxxVtWKaRpuNia+sii5GzjtIRsQV9tS4SIyjwLo6r6P63Jtvh8r3IlnUSiniEiXgbtS4bwYnJu7Bza71kTPMZeHPUCL9JUpsVzkMXJDd3xj4u0eCkoBdC2LBnuWOiSmpFmHBlLHQxVtWmatBeg0AOnurVpRHI/FjauFWWg==
X-YMail-OSG: ujFmgdAVM1n91flBnJkCtl..Zg8O_Sq3JJB8gCP6y.b6uHo5TgKgiH1n5zne1Pi
 DfLOFL.8LBaojYJfIOy7yURSjKDZcsNdMWZaYFOOVfTvlQVEFLkVxXy0ynmMOhVrQd3ZALss_YvR
 RQ0mbnB6FMi03hkG3G2lL2xNw4mrIb9DGyt1hhtCg0p.pDig8hj6Z6owT0XUx2kzmhUAlpL3dCxw
 GXl583xCSZdyeT3_qoSh25xn8W5yfISsFtXbRXFkucS8u5zeDab.qNpqiXoc73BhTzr05YxGwRmB
 QT.7QH4rERO4_gwARjvYJZAPjk97xfZr80tZQZmyt1KHnQhO_Do3HGTI_isbEZzta5l8ARB7_6aw
 _MQc6Skh8Be.tpghsPDdg2CjGTt1QuKI8y2VA5CD9GH6jp1UTIVGAHVI2b80d7sw2Q9nIr4APg9v
 voL0w.no6enFeGVI2sIuXk63daEG7dlfb.idKO9kXGb0L1kSD68_89k0pDiF2tLLTfET3XuuGUF6
 23EO7hBr46Iyw.kxw4qb5et3s_4A1ts.fsvIsf6WIIUjO54Q3nYifP8D47Q1ZVmPdZOEhLJRMA5X
 7jytpslXcpCCiAa2rQOeye_rTDFUmwGsoQlAbwxJ59pwF4RCV16qpD2FxYDkubjfTHaX0MI.Czc0
 yj5WX8YNVMW.Csmp2VGgXHItOG7tVxAvGD8al96F87CwAADt8i6PGBlwGySzmWHILYr6.fgZqyLO
 mdEysZNZqYiCcWvjUgisL8JhqCWlSUfvgv0SiPh1.kMYewvDaWTqEGDYohSKAi6Uj6iJfu8iNx0.
 uXUiCFdNQQ07cwLPpEsvXCqiyA0c8SGPcJOWf_tg9FXSQwkD2aWEdiSgRNrD3HgKs.i8A8eN5BjU
 0.umXEFy6AMoPxi7eoX.RvpNg_Gz3GklaDHhDD8FEWycJBRZ8NbB459kMrEQL.cRcAQ8Cbk.IwlR
 K0rMhcBM8du5N4I_oAOeLwHnWQGCE2g9NHcnzl5M7x3_tT4ubrLbMFrTDfp9vemWdH7F8xTA0BW1
 kFb_t2cmoh2xcK1LghlO1OXznco6tzMOx8oJhHqckfjuegeqjn30tFrH9XHiEa2TWr56fJ_0B5YG
 wHdnTiJY04LK1yoEaE7_X7wnbFNQVzFHDbFTaD9AV3jdY3v4pvH5t1Mu.6CXcd7kj7ChzBktVLNd
 9wVLkFJgiFx_IkLQqFY4dfr93zCBYygduMDe5fPbaKYMDf3KbvMJWOSiHFjRMOkZM4L0LuadSvtL
 uTOvy6In9W8vJjkT25.CW7f6geJqHd6fKLTod8.vJgKpN5GjmSvdpup6VaF18gdOmsUAEUR2YcjY
 spwBnHZ6p3xrx2eJXTIGQX0YJDZS9o0POi1DZzSmLCNhIjmOwTHlC0_gwZ5IevM6iqBqohzZ8Ulw
 2Kv80f7Qe4LuAzQ3H1_e_om.XnJ4XxX4-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic315.consmr.mail.gq1.yahoo.com with HTTP; Sun, 31 May 2020 03:46:30 +0000
Received: by smtp431.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 42d72fc3fe221b04394a01fe05080935; 
 Sun, 31 May 2020 03:46:27 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: enhance static linking for lz4 1.8.x
Date: Sun, 31 May 2020 11:45:10 +0800
Message-Id: <20200531034510.5019-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20200531034510.5019-1-hsiangkao.ref@aol.com>
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
Reply-To: hsiangkao@aol.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@redhat.com>

Since LZ4_compress_HC_destSize is static linking only on lz4 < 1.9.0,
but usually both lz4 static and dynamic library are available.

Previously, -all-static is used in erofs-utils compilation for such
lz4 versions, but it has conficts with libselinux linking. Use another
workable way [1] I've found instead.

[1] https://stackoverflow.com/questions/8045707/how-to-link-to-the-libabc-a-instead-of-libabc-so
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 configure.ac     | 9 +++++----
 mkfs/Makefile.am | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/configure.ac b/configure.ac
index 5145971..0f40a84 100644
--- a/configure.ac
+++ b/configure.ac
@@ -188,7 +188,6 @@ test -z $LZ4_LIBS && LZ4_LIBS='-llz4'
 
 if test "x$enable_lz4" = "xyes"; then
   test -z "${with_lz4_incdir}" || LZ4_CFLAGS="-I$with_lz4_incdir $LZ4_CFLAGS"
-  test -z "${with_lz4_libdir}" || LZ4_LIBS="-L$with_lz4_libdir $LZ4_LIBS"
 
   saved_CPPFLAGS=${CPPFLAGS}
   CPPFLAGS="${LZ4_CFLAGS} ${CPPFLAGS}"
@@ -196,6 +195,7 @@ if test "x$enable_lz4" = "xyes"; then
   AC_CHECK_HEADERS([lz4.h],[have_lz4h="yes"], [])
 
   if test "x${have_lz4h}" = "xyes" ; then
+    saved_LIBS="$LIBS"
     saved_LDFLAGS=${LDFLAGS}
     test -z "${with_lz4_libdir}" || LDFLAGS="-L$with_lz4_libdir ${LDFLAGS}"
     AC_CHECK_LIB(lz4, LZ4_compress_destSize, [
@@ -210,6 +210,7 @@ if test "x$enable_lz4" = "xyes"; then
       ])
     ], [AC_MSG_ERROR([Cannot find proper lz4 version (>= 1.8.0)])])
     LDFLAGS=${saved_LDFLAGS}
+    LIBS="${saved_LIBS}"
   fi
   CPPFLAGS=${saved_CPPFLAGS}
 fi
@@ -234,11 +235,11 @@ if test "x${have_lz4}" = "xyes"; then
   fi
 
   if test "x${lz4_force_static}" = "xyes"; then
-    LDFLAGS="-all-static ${LDFLAGS}"
+    LZ4_LIBS="-Wl,-Bstatic -Wl,-whole-archive -Xlinker ${LZ4_LIBS} -Wl,-no-whole-archive -Wl,-Bdynamic"
+    test -z "${with_lz4_libdir}" || LZ4_LIBS="-L${with_lz4_libdir} $LZ4_LIBS"
   else
-    test -z "${with_lz4_libdir}" || LZ4_LIBS="-R ${with_lz4_libdir} $LZ4_LIBS"
+    test -z "${with_lz4_libdir}" || LZ4_LIBS="-R${with_lz4_libdir} $LZ4_LIBS"
   fi
-  LIBS="$LZ4_LIBS $LIBS"
 fi
 
 AC_CONFIG_FILES([Makefile
diff --git a/mkfs/Makefile.am b/mkfs/Makefile.am
index 97ba148..ecc468c 100644
--- a/mkfs/Makefile.am
+++ b/mkfs/Makefile.am
@@ -6,5 +6,5 @@ bin_PROGRAMS     = mkfs.erofs
 AM_CPPFLAGS = ${libuuid_CFLAGS} ${libselinux_CFLAGS}
 mkfs_erofs_SOURCES = main.c
 mkfs_erofs_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
-mkfs_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libuuid_LIBS} ${libselinux_LIBS}
+mkfs_erofs_LDADD = ${libuuid_LIBS} $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} ${LZ4_LIBS}
 
-- 
2.24.0

