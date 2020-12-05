Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 231B32CFBAB
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Dec 2020 16:16:40 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CpCpX5y7GzDqjg
	for <lists+linux-erofs@lfdr.de>; Sun,  6 Dec 2020 02:16:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1607181396;
	bh=e+BhMUiqJppTZiAEr8By926z5ZFBpe5FrOTzHUXtdLg=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=dFes2hhjOKx4L+lsSuXJZ5Y+yCtwO/DQ4f01Rdj6i0qAsL6OfSTn/TpQNjK28EbLd
	 IwP83YuGE19hkUezmx5C4Eq2zD0KMTVBCpPLOdi/bqmQfkHuD5kyG3HxN66CdMddwX
	 9dK092s07EA6RtZSlDtaM+Q4OdKN9vZ/5CHnR3/YN+btEjjzkPky5a7TBHx5Mc5wKK
	 5TRYYA14tE4ovah+gGKcjDowTycThkt0npJC8A6/CGog2cmHVuzDDaHHu51EcZ2ZAz
	 zl01BGvCnqZ+E107KETyx2OTTq0X8tby1AtDOF0PYny8euVeA+LwDNN9svR000zjDV
	 XM0XranERh7BA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.147; helo=sonic302-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Received: from sonic302-21.consmr.mail.gq1.yahoo.com
 (sonic302-21.consmr.mail.gq1.yahoo.com [98.137.68.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CpCp02Vm2zDqgl
 for <linux-erofs@lists.ozlabs.org>; Sun,  6 Dec 2020 02:16:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1607181357; bh=zHhejYq5ffF241B2duOJV+4XdN2bm0j9SB7cvhohtxA=;
 h=From:To:Cc:Subject:Date:References:From:Subject;
 b=L/P3M+GNnU6zwyM14lHuRyikhDwetpCbDRlP7O5gxVKTLs2Ir8iit+1cmiUB+LrYjkiwY9AAGVV8t925VqlIg/vBRnxrUo55N8IBRzN1zoBGTK5MlXSb26NkseH7JigV08ksR0/RbaOPY0cup/ad6DMndlt6uYDd/X6xSejAYxXhLo+LdSr3XmOL5njCbSslpPxnp0VmBKs4kqet2XlcRj2PzoG4c70iE4d3eKqeN8IB6mr0xVzJm6rEqKOV6QuouaNMvjXw6CEcmJxdmXRGDcunos52sIm0oR6TZwaDPTsG4Vwg5+q0mzGy9SZRb2pf2RRBORAHMg9isOxbMUFREg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1607181357; bh=lC771+qRLeve245ASSJfY995fTfkxQncR/utP6AUJG1=;
 h=From:To:Subject:Date:From:Subject;
 b=kplwjOIvLbck8x6m+Wa/BeFbMdyakAbqcV40xRgGjtlGmDQG5madOSTcN/+ndnsafaLt7lcwPo4bGNP8FqHLxECNfnTip7u7hezx6MZoGkzCAhmIgTZTUssqwgZsas3ROpxg+XUDRIshXTje6wXX8PLlaDpKv41r7qd0R+MTicOKicKCDqZRRJIWUWzrMdbbSlmxEhDerH4SW3olLE07Z+/ELLBrc3P7qfGC496k82vGzurV54Gp8c9PuHvS89vg9vJ+7fx3rwD05wBdB8FHDI52BbDhBPMvgQLEabsdP2AFqjqm163Fyxq1H5Vw1GLru9Z0vC2QMuAVKzOLIC1+Tg==
X-YMail-OSG: VcHgERwVM1k0Sqk.XV2O_jJuRLv6COXeU3YKv2Ef.uwQSUGM0FvNSlIAUVuD1An
 fff8_8u8ZPLBxN_Jb7u7WAnBsY1MQ0NV.YF0mAmU4jnSrFKjhKGhLkfRo4kBemgQ6xzGjOKbg0EL
 LjQuDEQCX6C2VlwezipaCI.3QLd5GRTdg2KyIGqR0llo8gEJ7z.AO3fzcdslKEuWEG4AxzAlGPFE
 eeKjYNgNOWU.6wivXNQJnDyeFXWW7LRnIgdrUs0dGi3dyYCyxO_7Tx6M3hZYSZ8ZlTjZUHcpL0pk
 7PYIkeHvzzrZc6AjLwljdCuul8RrmeqKmsC1zaNjhHn.kmOcP7sl7PXDP9v8p8CNIx4sbkTfpLyb
 8tL5urNkBzFlGsy9W9rZKU62wa1LrzUp1PYkiAGbBiOcBdw0Wsc30isENDCFKIQEJF4U9dZekKxq
 hbtMTa3L733_v4kqlX0n7jobzJfIrFffTYuLq3chJ3Ruje6TPsxe6IfPKt7MoIyFWtuMLzekj2ys
 _7j3i9glxdm8XAqGQ0Um.63936xNstdjc1GT.cJ9Ad3v66br88yWWzXtIM.pZf1d2nOxkwTWDbvH
 VamLEOsHRZ.RIoRJ0k2MSgmLEe6z9So.CzEp7J0wMqLkK9JKXUqnTdVd6PbdtmzRmg7kxuacVgEW
 jjUe8gdEOYccj8AIC5inx3CT4XpMyjOyx6WXzVtmaexYJ1IIJobMfZ0r4vo3BfJMbu5E8GGniQ2b
 tFcIMgY00BMkh8vD.jkfiGwqbOWRvqLhCrhWSWwqwdOQPQwMUG6kSRwQf.hoCs4CAUwUkXdXXhsk
 708eyMqZnSsIi4TycdqBYW1mbm51LKZh2R0KFl_xKSFBvPf_saiDhsNQjbd6cmfDupVxkzdN677z
 y4DOdXvMHRHaoa3vctJqPxBaq_QcdfOOA7FHAG7N2aOQwwx7XZvnjtEACmo8vsfk5SXMdIVZLFsw
 vF.ZUhbx9wDPQbB.wZFACJ332xyg_E1YjOjggzMgiA85VeBF.ZXxto9M8qvZtOBZg4zS9dk05QgY
 71xhp12YTCyRcJXrP3KPoHqZayfD_kWZgAHJGyMtVy6kesCsH8zvOxG2mjpRh58BbwKJhQF9DcdQ
 8lrUZceWpuCMIgrJPaetn0ZG2HjQ05MDnwD3LHMHW61kgJ0BRmtZWUizYiTrHbdJMVysZTVvTQsM
 2SUYwyUBWyysHkhsq8usHcbzUaSllTFbEJrOxXG8vVBS0H5zrA87k24IJshlxYMFK2uvIpdCOa65
 yteqfKEuumRanbZsnybO_rtqYuAASYFeHEq5ji4UlZNc2mC59zbqstA0ehboL1Q0GKgsBO7IdlQ6
 rzq1iDdOFCAwmBS.m51pKimF5RueGg2BAzeuKGgOfkyu0oNsgR6npc.J6ijdD5hKYeTJ9spcVcCy
 iIUDEGKj4gM0PuJgOBJhK1Y.LcTpfFZ8bC4npWoU1BXQuuKufgdSWQ2BgI7yd0wVPRBDXCiZKeSv
 ahBmhk5q7.4myL0_QQ61G5ZSo2dfsCh2naEkoZDklKXl3FrlGUsY9_AC_Nlf0NdCDvNFju1yHYC1
 YEMQ4qUUzJGLbhi0jL6niSp6bIH2qa5qyWObDdahWiIhp8xy4nuvNzvpFT5Yre6pfBTKa9hWwo9h
 hyrjoZWc0zh5xYgnqv72gX600ru4_DobPNwNQ8x.25ZU3DSmS1oKK8GnZkvnvmOfsYgSg_CjisKc
 AnArwXP3FNj0wu1m3qS1cmBQ7WlSZIMnj6hwWBrKlX8gIZ_zgxVsX3CACM.GapJpS.G7I2Cfh6lU
 qbAzyNz_o1FfkuGS8si343Z4jp4C2lwsqrgk3RmOAFIgw5jkGZbKQH5p_mwyawUQo_tl6YDnaP9j
 0bEO_hsktxMcVds.EPykjtFhHJFM1Opq5N.S9eSUMegC5YSoxTNicBBv.TTLSUKgEXmpNLeImnWP
 naLsSUs6JM_MsCDW.vq8sQ3nZHXhw8Mw3B3H44cnGYSHjEDUUvoR2e7Zgoit_3Lu24GyJw3G2soR
 S6yk.ZkCqrPXe1bNCfCs5aNsq9JzgKqeQbxQtcYwSosaNC8mpcVWGtIBRlQhS5yOo1jIZl1eKWZQ
 4t4bq.mXAo9dUhiPBHfQ9AhH1BWottfnosOPGyacADc3J0CMr1bQTbulxStIbwDDlYniG_J5Tzxl
 AEUtlCSU5Q6Ljbmn3dT6l0kmYvrn1bmq.G.7NYKbyaBQy6nQ07AmnTD0enYdVTKk_5QBW9RUklUa
 D8.CA3sLJwohrxHk5NwJBgtJWiMds3M8JAHPbof3UtXx.510miCTWWUETYuRTeMN5JYbvFeDSZP9
 Gg_BEMSRP5v.4Hjp_HRVDaTTJFtWZ_nuvy0ZzmxR5sctcN1ZDs9Ma1pWhNDGAcN_lkbMQqm.zvnZ
 u4TIyd6jliR3WQhuWLkp.GimrHEMYsPMZrOX992RlrmPp0HA-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic302.consmr.mail.gq1.yahoo.com with HTTP; Sat, 5 Dec 2020 15:15:57 +0000
Received: by smtp404.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 87ec5af4550f725afb36b1d024a1477f; 
 Sat, 05 Dec 2020 15:15:56 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: document erofsfuse in README
Date: Sat,  5 Dec 2020 23:15:45 +0800
Message-Id: <20201205151545.10935-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20201205151545.10935-1-hsiangkao.ref@aol.com>
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

We are about to release erofs-utils 1.2, add some words
to README about erofsfuse itself.

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 README | 79 +++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 61 insertions(+), 18 deletions(-)

diff --git a/README b/README
index 980f1d02cb19..8e4335449b6d 100644
--- a/README
+++ b/README
@@ -2,26 +2,12 @@ erofs-utils
 ===========
 
 erofs-utils includes user-space tools for erofs filesystem.
-Currently only mkfs.erofs is available.
+Currently mkfs.erofs and erofsfuse (experimental) are available.
 
-mkfs.erofs
-----------
-
-It can generate 2 primary kinds of erofs images: (un)compressed.
-
- - For uncompressed images, there will be none of compression
-   files in these images. However, it can decide whether the tail
-   block of a file should be inlined or not properly [1].
-
- - For compressed images, it will try to use lz4(hc) algorithm
-   first for each regular file and see if storage space can be
-   saved with compression. If not, fallback to an uncompressed
-   file.
-
-Dependencies
-~~~~~~~~~~~~
+Dependencies & build
+--------------------
 
- lz4-1.8.0+ for lz4 enabled [2], lz4-1.9.3+ highly recommended [4].
+ lz4-1.8.0+ for lz4 enabled [2], lz4-1.9.3+ highly recommended [4][5].
 
 How to build for lz4-1.9.0 or above
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -39,6 +25,10 @@ mkfs.erofs binary will be generated under mkfs folder.
 * For lz4 < 1.9.2, there are some stability issues about
   LZ4_compress_destSize(). (lz4hc isn't impacted) [3].
 
+** For lz4 = 1.9.2, there is a noticeable regression about
+   LZ4_decompress_safe_partial() [5], which impacts erofsfuse
+   functionality for legacy images (without 0PADDING).
+
 How to build for lz4-1.8.0~1.8.3
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -55,6 +45,20 @@ However, it's still not recommended using those versions directly
 since there are serious bugs in these compressors, see [2] [3] [4]
 as well.
 
+mkfs.erofs
+----------
+
+two main kinds of erofs images can be generated: (un)compressed.
+
+ - For uncompressed images, there will be none of compression
+   files in these images. However, it can decide whether the tail
+   block of a file should be inlined or not properly [1].
+
+ - For compressed images, it will try to use lz4(hc) algorithm
+   first for each regular file and see if storage space can be
+   saved with compression. If not, fallback to an uncompressed
+   file.
+
 How to generate erofs images
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -85,6 +89,40 @@ git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git -b obsoleted
 
 PLEASE NOTE: This version is highly _NOT recommended_ now.
 
+erofsfuse (experimental, unstable)
+----------------------------------
+
+erofsfuse is introduced to support erofs format for various platforms
+(including older linux kernels) and new on-disk features iteration.
+It can also be used as an unpacking tool for unprivileged users.
+
+It supports fixed-sized output decompression *without* any in-place
+I/O or in-place decompression optimization, Also like the other FUSE
+implementations, it suffers from most common performance issues (e.g.
+significant I/O overhead, double caching, etc.)
+
+Therefore, NEVER use it if performance is the top concern.
+
+Note that xattr & ACL aren't implemented yet due to the current Android
+use-case vs limited time. If you have some interest, contribution is,
+as always, welcome.
+
+How to mount a erofs image with erofsfuse
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+As the other FUSE implementations, it's quite simple to mount with
+erofsfuse, e.g.:
+ $ erofsfuse foo.erofs.img foo/
+
+Alternatively, to make it run in foreground (with debugging level 3):
+ $ erofsfuse -f --dbglevel=3 foo.erofs.img foo/
+
+To debug erofsfuse (also automatically run in foreground):
+ $ erofsfuse -d foo.erofs.img foo/
+
+To unmount an erofsfuse mountpoint as a non-root user:
+ $ fusermount -u foo/
+
 Contribution
 ------------
 
@@ -150,3 +188,8 @@ Comments
     and already included in lz4-1.9.3, see:
     https://github.com/lz4/lz4/releases/tag/v1.9.3
 
+[5] LZ4_decompress_safe_partial is broken in 1.9.2
+    https://github.com/lz4/lz4/issues/783
+
+    which is also resolved in lz4-1.9.3.
+
-- 
2.24.0

