Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C482B4413
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Nov 2020 13:57:02 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CZTcC5GfzzDqJf
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Nov 2020 23:56:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1605531419;
	bh=Ew2Pjc4pg7tmDfSXpOYl38b+KrQk2QSbMyGuT6sT5D4=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=M4MSAcQj5ytE1AgXterg5JSmZBgNsTenWWp0jikdZjKm36lWi+o6bnRXF7CEFYVpy
	 vEutI6cxuXONQAwPmApu09oo1gWsQz6HbPIdDB0qbdVcQ+rrmXHS9M6T+Nf49vOe6v
	 fL8Gd6t51H23UIbwcT/JZHGqNsihb6jTKetO6ofY8m5wepW3LoL3lYm2VxnnJ4v76e
	 Mi9Y1Mi7RroWylE2bKBIlG5NVL6Vsv4BgbEIJDdrKTkTQoWPGEOw99eftapleCYcVI
	 qehsYKSBnKeiJevPu46SpZJwWoDdUcEg19eAuDwZNMd8MC7Z48i0ZZykWdczeX4luQ
	 ZtC7kEwjWbnCQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.204; helo=sonic311-23.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=M8INwtnF; dkim-atps=neutral
Received: from sonic311-23.consmr.mail.gq1.yahoo.com
 (sonic311-23.consmr.mail.gq1.yahoo.com [98.137.65.204])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CZTbJ30GwzDqMH
 for <linux-erofs@lists.ozlabs.org>; Mon, 16 Nov 2020 23:56:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1605531355; bh=eMH/G1tWguZNiH+GoFLjj8zaDz+Z6JgBz3fKcYIbtU0=;
 h=From:To:Cc:Subject:Date:References:From:Subject;
 b=M8INwtnFEap9jUeqr/KMeA00I6BcA3FvX86434AdVkoioTd1L6QsPwWlQ3SrobR3Touqmx8MWYOt0AHJv65oUJEszQP7lmkWgv4aMv/+uh+0GHjr2F9EB6Xt+YF3tYa/DDA35v000uEf5JQLfT2fOUmXrLbPLrxRHguWjakmTpRKwSFfoj4p9rd3XDjvo7zMyZQOOaT4fdqFIx04nq61CnYnhXDLgeMPUOquFL04JlupPnWSnqILb8iSX9w9GF4fwZ7wmnefxcjGNjOFStqilfhOTHiGSZdtDwYdLM6Cn+EUBOSzN6/I0Dnw20BsFQ7JvktOvG/7EtBRDu1tC9HYew==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1605531355; bh=yYyYNANnVRfHfRAbogCY2R+11UafNkZtL47JeOxkhVh=;
 h=From:To:Subject:Date:From:Subject;
 b=ESd0k5sge1ZlIKhZzzSgCGAdBlWWbJGJq9leCAnJKDCFL1IgzYRUKpdkmO7wvyhM4XL5Q/kyHAK8hzb96YA2Lq1VYBcTmmm4o93cu4YA/63E/vWg/I5QEoDO4GeYH/nyfpM8P+H07i1nmWEftYZ722+ytfX79EcncgRv0qgHWewckIvP0EumC4lMy8OjXIZl1th8cNF6iw3EhlnNZQJmIvgB8Lq1wbaeFR41qJBbZ3Vib+TeWNiP97cLmVqNqi19gfSFtDbuK9gsPSmzjtkl1vlKhY/EZkzlKLIFY5PCRKGl08VAk2e7zzd4OISXXgj26IgZWTocjn1sA4QU6vloew==
X-YMail-OSG: T2J1ZbUVM1k8XaLE1lv6P6l5cdsz0sRdqsPloUt1bkIJLYnf0.mqwQqj3FwTO68
 qkvkTRgZmz9.b6ZzaVor15Koit3kvFYgDDcbADe4qNxsemL8fT5pLq9UPopwb7gZUACMKabfeIDm
 V33x9i3k0XP7m1AMDCTKHurYZ9Ye0689p.iMHOPl12n.VxJgHmSlCMvxuYfxmtCP5BljExW1P4Lz
 .im3T4KN7QFlK9YkalrxQ3IiqhqA6HbDC7Wr.jbVp8fu74rPytHi90QFg8oHN6PC8FlMMs7AVZTJ
 Bmf3ZF59BuU61SaKaCM17_gZ_vAyh0kZ8VhQO7Qh6aGNZrU2PE5qaWHCXDwzBB3GhZ7svAy6PBUy
 xRUNKR6AziXAqXzYgK5XBBzzGdrSS7iHNLke9DCyV2oz2FwBsYGOI6k4v8FTU85ka9gjMVxAnMKC
 VjhKeZzOyM7GJPYgcsiHCZXRsgktHwmzfct9EpgeSNW4X7RWUa3Y7uhE4YBuAleECFlbSZI_mHZq
 hQGzLsBD_z_LMv8WA4qgDqJjxV0A32vus6B3knBs_3oEj6wRHmxM2.2tiMMXw_xrm6LDqRSCeYS6
 Ew0anb7QpNRHXelZeEaEb9NbngjZMtSQmPpf22_cJFcB1V_HGBAdefDaNuW6G_hUpoweeCEf5KoC
 TQ.JkAd3tF4MHNUt58Ka0F8u4PvzbLBeh4COpU0mllA7_NV1cHxrFgQ6NlDrv5ZhjDyXmcRvohkd
 nFtVSQC4JicWXG23jgwOs6oMl8PaSo34LSuk3nGUF33Leeu41AO2f2mJFx6xq6uHaiDsVNct4tLF
 9wbXP1KkACvK2xwDGedwoXKnNKlmDpaglfqxT11mRLdASzsQd9SjO8dzLBLVktii1UOp2x7fL3xy
 e97fYmfYd2Kh9OOezYyknDD3Os3OSjIztgdVFKQJ9hqFKCheZIpTMsPywnM3FwECVD04vPfInhO9
 3GxePfYcb_fk1KVqzW558iaAZWDuYBy5ng2G_nnHr9f.eK0YlOCaIQuyAR1pm0T3QKg5O4lLZZ2J
 vhx9KM4ij2HPMxvfeSEtm7sJftDq2fT83tKtqW59yg_dchOMGQsC_Q.1gF_TbIDjpVyK1pmGPhRM
 0ab7XkLdNOH.rXSS45p3xM.MxxiSyY733j0e4P66HJu6tC2bN8JQqZ96DuHyEUK4mrOHyIqbqloY
 7QWZHienyVUXl1yUAjvRqoeE_1mkZ3B2Nh8OsQs3VEtZcduWMI0c7nsE5L.3VlCjOomM_uvYi3Gx
 Y0W7c_wZCP3iK_tz8abUkNodQdFdufYo.LpUuyS6W.YqPFHCJkPX_yN.bMRRY7IvymjLs3G0t_7U
 5O8I7iC4UjDIbl.72mAwXWgmzz_P9AxfLcjnVaNBHiO.iuZHLKc_QFvLH475ET56vV.pctuqNMe.
 K3j4Hy_AnnBabXpWTpFT60tMXevA3opdsUuUOz4xqtwQz9y_quv84FYr4zuzC6nUXy68_kGI1pY3
 mlHYOYaEbP5zw.es_OTMGasAFA6q_h1BBoqtEgW0OXPaM6QNUeciBOxykAIeasp1zdeIzuGFymak
 Fxd1QGv2W_UH2gf3TtrtDAbR5Dc4ds2SbHeTf37xTBVkGIi7shDw4rZWhahhaiGM0eOZoPSpDepX
 Y9Ck0nDLkDHBlN__.u_ka54RiYQmcuhtIq8y.ZjbyumzrOZu7KqukPKCpuYgx9eJfzRPCROnfMbU
 YenqAO8VtKJoHKQP4CQdhiJXtRypWHC_AGScLkYLDssRG5_t9eNEBghLaoVbNoGt7WhWwj1pnxHD
 rQi9NXJQAfirEMi.E0GZoKDISXL8i1uTCxJK63q_WuAwCr2X4gyJ5diof9r6D1FTdTr3tNvHEkMk
 wFe2yGPKnSJHCu.RQtGAjUWmtamgymdHR8lCpco8R63rFP8axwulE8ey0_zypbJCl8cpzDF13Xhy
 vxYEe5bq8NEr7085LA3tMufaqRunGQFKPEzzHq1j6Sz0tP5ZY8sz1DefpYqpZtr3JrIw7FVAcYmI
 q_VEFF5IKJBse8kRUi1Ulpxb1OAdVbdCJh.HNKQbo69wQJBDRVahEm5GxVixy3y81EoIg2uypCO8
 tsBofl0U4w_ns4OhCVAb62B.hvzgD1QLAv4wl9SgmWwV0mdUbIN.KmaJXYqCEqXYyRLrpcP4xwXD
 0vD8eEehELrDTeXF8Pz5Nk0oUfkXLQtohDad_wSwQv9tnsLPh_7u5sE3C7J2qMXOxG4qjJUEzHwD
 kGtxb_VtCTXAEkl4XLqP89suKKNqAJh5Z_YBrzF9ItXdYPC2L9GyGSOIk4Rcy1c7D.oc4z5azRAb
 WSKrf82lzv7SO2pAnBKCtq.0eRsYxV7x1y.FmGAOKpHzNjUhzR9GmBhQrMAok4MnY974Nzi7vKdb
 NG_CpBv.RlKra5Ocl2Keji64_DTHzgpenAh1BaEj15_qhW.cS6p_FzQ_PN.1X3IVSMzkpNO_LELF
 _q9sagSJ05pauvff4Da6IJMKgB7Zb4fqCPs3sD_HkOFJqV_m9K1Ro4sXQR_6f7U0VyMz24X3S2tv
 Qzrw9AJQAQVyNFdjq8UHdtxWa_UiQniYcnQymsv_VyZJbQkhThePhkpzArAV65jJn_.c_DaHBpAQ
 TfcZqMc8nyKrt2HH2Z_WRZpPwafjwcUolDpmS.PVW7zONwWSCX_rhFLDaNtHWeG2ENFdj3bOjkeS
 _c8brISBrznvvOB2k._dveQ--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic311.consmr.mail.gq1.yahoo.com with HTTP; Mon, 16 Nov 2020 12:55:55 +0000
Received: by smtp414.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID ffa261d8c171b0beb5d1b98e92e0ae62; 
 Mon, 16 Nov 2020 12:55:51 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs-utils: drop known issue in README
Date: Mon, 16 Nov 2020 20:55:26 +0800
Message-Id: <20201116125527.3644-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20201116125527.3644-1-hsiangkao.ref@aol.com>
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

From: Gao Xiang <hsiangkao@aol.com>

Since lz4-1.9.3 has been released,
https://github.com/lz4/lz4/releases/tag/v1.9.3

Move this lz4hc issue (lz4 <= 1.8.2) to "Comments" instead.

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 README | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/README b/README
index 5addd6b80e04..7a7ac5d5cb6f 100644
--- a/README
+++ b/README
@@ -19,7 +19,7 @@ It can create 2 primary kinds of erofs images: (un)compressed.
 Dependencies
 ~~~~~~~~~~~~
 
- lz4-1.8.0+ for lz4 enabled [2], lz4-1.9.0+ recommended
+ lz4-1.8.0+ for lz4 enabled [2], lz4-1.9.3+ recommended [4].
 
 How to build for lz4-1.9.0 or above
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -48,7 +48,7 @@ On Fedora, static lz4 can be installed using:
 	yum install lz4-static.x86_64
 
 However, it's not recommended to use those versions since there were bugs
-in these compressors, see [2] [3] as well.
+in these compressors, see [2] [3] [4] as well.
 
 How to generate erofs images
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -70,19 +70,6 @@ add "-E legacy-compress" to the command line, e.g.
 
  $ mkfs.erofs -E legacy-compress -zlz4hc foo.erofs.img foo/
 
-
-Known issues
-~~~~~~~~~~~~
-
-1. LZ4HC cannot compress long zeroed buffer properly with
-   LZ4_compress_HC_destSize()
-   https://github.com/lz4/lz4/issues/784
-
-   which has been resolved in
-   https://github.com/lz4/lz4/commit/e7fe105ac6ed02019d34731d2ba3aceb11b51bb1
-
-   and will be included in lz4-1.9.3 if all goes well.
-
 Obsoleted erofs.mkfs
 ~~~~~~~~~~~~~~~~~~~~
 
@@ -149,3 +136,13 @@ Comments
     version as well) or backport all stable bugfixes to old stable versions,
     e.g. our unoffical lz4 fork: https://github.com/erofs/lz4
 
+[4] LZ4HC didn't compress long zeroed buffer properly with
+    LZ4_compress_HC_destSize()
+    https://github.com/lz4/lz4/issues/784
+
+    which has been resolved in
+    https://github.com/lz4/lz4/commit/e7fe105ac6ed02019d34731d2ba3aceb11b51bb1
+
+    and already included in lz4-1.9.3, see:
+    https://github.com/lz4/lz4/releases/tag/v1.9.3
+
-- 
2.24.0

