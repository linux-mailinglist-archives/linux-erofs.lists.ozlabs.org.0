Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FFF2BBC3B
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Nov 2020 03:27:57 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CdHQ2084lzDqmf
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Nov 2020 13:27:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1605925674;
	bh=TyT9l1fQUwv2CdfWa1Zpev41sTmozuD4nl1/kgVbA4E=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=cynmaOEx/aF6Ri5wnZjVI5ZIkfN1MewiORjq117FMdFyAKwka+zntFWrPimyvUp5S
	 v25r/a4tEmdIdqBYyiEfZME2u/9vK8e+RFU7Z5zNWHlc+k6d2J6WwTFOmdY6UsjCJy
	 LmcgjKx9POMoSSzK2Oi3TurBBmyvZMzmgbVAVVQsxyT9XIsgeuBGX/q7T/F7aQk7cy
	 fiJ+ESc2aY8LrLgl+GPYpO4NRa60euQVxv0u1eHr+gso5kiIQ8X5VfZRHI//uI5OcG
	 pPBi2CED3cyWK4v+sjRON2Ri3GSFbru2mGh2AAgKeKuyb9HrajRFtUwbrRHk01tNuj
	 lAr2oYqRidOxw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.146; helo=sonic302-20.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=mH+XPMIA; dkim-atps=neutral
Received: from sonic302-20.consmr.mail.gq1.yahoo.com
 (sonic302-20.consmr.mail.gq1.yahoo.com [98.137.68.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CdHPg4cbMzDr1S
 for <linux-erofs@lists.ozlabs.org>; Sat, 21 Nov 2020 13:27:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1605925650; bh=FRN9wZauZcMt2Mx+XKDJL+QzVvEnSVMCdGNekZQTqho=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=mH+XPMIAFOID0FxSPq0ZFiUpDFp+0Iad2N18FJHyHYqy8LawbWA7geQohoBqiPd8U49XuOf9CU6nfnX9QFOJoZUYHLg7+zkw3Q8xfFcrcZ6v77KD7R/ipswsaYZ9Mexazaslb/MftSzv/neF7HpoM5Mk+ZSOMq9GhULZF5WxCOjhku6nZyjnGdI3hsz3Lki8jN5LrUHi+S2G43sCtdwsQIBn0tBDMW1YCOh0aJpLglGhWOQOLeTyfgTWNLsuaTrunbSfXO+KVZBMdx12V9DcTWixclyG6IVD8sjuFf5jFtUtKrmZzJWQQkWJLqNPUDBzWWbQmMmv9DVtuCYYevzc/g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1605925650; bh=O9M0c8826Xp7hI2Ski7icf17Y8GXQ7zorhysaSHMqKG=;
 h=From:To:Subject:Date:From:Subject;
 b=h5vn3upfcqzANXkc2m3EfDzG37QN/UKY4G1xeGiRAXtun4RoRv2hX6MzT+m3BOAUZLGq8C4OekMxJbx8tmhEiFD35s5JO95Y+oiPtGWvPcSxN60n4pO5mJK2gtwyz3TcmB7jgUvrFBlOckCHgSFe+G/26UoCxxLipSFP6pIUG14sSwMtYjHXpB3K3avqmjhRmyT7jR3X2quz48P9/MUjkLDTbs4XMelfudMp1IknaDPyclC3xiocmgyneZfKyvt7OM+lNwR58ucAPMeC5qZjD+RUltGzNnuI8/S7yZ53Qygef4t/ReBjsvcRvRn7ALObAg6Imy5VEqOrDCHzXhyFug==
X-YMail-OSG: PSCLF_MVM1m.ByiesCxJA6SqZ8MFfxEOzq3zidLXcvcwwlaJuYlxev_8kB7Wo_4
 ltE1S8FB6955mHxMpU2jHINRDPCFJF_1JCrzg2O9cqp0AqhDG4Gk7MjzVnU6DPOg8dggRgsZ894h
 RfF4fiX6aS_vgGvDlQAG5imn0w8rJYQCipC_Hhb9mieiDBNUqseECrqxkBVpeiG7FGoPHMpB5zXJ
 hrC1I1JA7XedUG6fQc5w5EfZ97nirN2rIHBV_1aftvTxfem6ThhIFUfUAekrSZEp0Y1JLKiw4HrD
 3c6ASBob0mHvufxM4B_c1OYLmsImuZpSJ7YTO9PT3hi5H22LgOGlUVlHTtD8lm1UR8geXgGKnT7X
 Pu0ZkupMwueiYqBqOqFDiFHl4G80xD4UFvA3C2cidj8MbkXjA_G3lyZHAytztJmYu7H4b7bwFcO9
 7sU4zaLxb0GkYFCHPGfo6EJ44LUEG1Xe2zhCGcPHGOcGTAfZJrcLsNY9Iy5D2H.nvqXkWjVfjXLQ
 k_oXrmB.PWB1xoLeU8605GW7ue.LI3YRGPbBSu8U7ua3acpizSVF_vxC7EyQA9iBIVhF4swCcQ84
 aH0ePTvCnlwaEP2kKOH41laLGK519q6A7AKYqj1fmEfmJUSnIUQtU8_y8yi88HDbIz_Ym3dtqzJ_
 ICxytlwC63sTKx_mjihEBPDPgWyw1CM3Qljav8tsnlJjOu_T7xSLYfPUhl0RlC2nzcH1l0VmY5Go
 wYtO_np1by_VzL_gx6EQK7Lg7BlsAS8cFf03zoIAKybCweoT7OkGE9WKRlEys_BQ7PUrME9tJjrk
 sLUlfplNYNZJspAS2V9G4A9xYJXpSnxZ5uLSVl3HVYfL.apQwQ8GKf9CNTI6b9kJoIlXWgm5Gds0
 6nnxY5NaVRXIZnJ7sJdgSqB1Jf5edr9brjIeucdnYYaIRLF_tj8YaAaXTYVP.LyDtNxqzLnrd5KG
 hRQA1mA1peawR6doeGGaAJNI1GdO7TI_duMfFUlW.w14kXcZwswsn7xPLQal30xqT5qnNGEqAdrv
 8HEjsxMF3mq2qjv5Vtcz6PTzVii0CYsjieJj.hvdorP8rvpW.wX8Yd.qAw83jFoLq9yceP3e3UML
 nQNGpyOcczEn_6LtnXBoac3K7vh40ykK0q0luE06zrorKu5usgPNkCoYcfhYhrMKiwd40Y8UrD5u
 FsK5era_ooaOCmMTrjYUlcprYDpopJSwvZtUXXGPCNrnaZGqhhZ8ympUOovhYMe5K4OwPNURrs2c
 GVKG9O.ExW5rZfg.0GdLkYyPIjn0QAgTn18Hh831y_.n9Lo7d8ZIFzYcVi0J3AirK6e_foixKONS
 WfhMbwm.N8nEyYB7Zxa2TFX.Qn0vm.Z3Iw0H3m9mYUx6wXkVbZfxpZgxpSfIRASzG4jXk_KWuTla
 nmHnvoaNl29A_ywL.b..NjtO8OlcRhmyj4JMEiMxBoHMXHm.4PgFBbBl6Lf549vn92iRynITcZOK
 UL0bVzAe_jREh7kuQjIi_DjtjjY2ByF0BdWGTy_BtFd1hPs8QKE3gj_ojx6Tmhc0CskNXGixAHwS
 YjipD2Ed_78R1F7whRvNZlQUV6UqpUegtaU7Pzz1UDq.Qp4VtThtrfDSMUNE80R7n6_BKIg9myTI
 a51g0HlVckO94YCqom5NxukFnfs2N54CUxiJ2nGYn_Qk23vn6UR9HjfbuT_LriMgbsaB8ihvel7b
 IXCqXLUahaMpDsDc0vDkaCOeFN4QXn0WDSbieTMZZ7flUPYE_ZdatGewZM9QuvHyd7FKif7fatu1
 CmDolPcZ4G0dgn_xnEo_QSjXHRhqCTICAGTBhG3FFokayKkepAm_SUM3rn.OAp2AYA2czDiNRM4t
 MRPB2H4CRB0K0I3KHu3DEg47R43aZrzraq6mjXF96qNxBvdjm3jGovqDHlzNd0wZiYaPDD4jiIh5
 WsaaBVgn_CbIdBhB9LmA4UxJNfGxAdT4lehqI8Lt5wtu6Kd9nK3cSmLrDeZvU4pULZLlnC305oHu
 rbzXFBAXUoRscG10HtNQF20lUO_FCeV9zVTHRTyvikpR4bXU7sHO08hA7G2uPEvp8uesqejaFpVk
 _Ec.4SSUz1OO92YWnvoNYB2s9LDwvKp9elFfpBdOd0pQNoEyYzO_NDm78O1JH.4s4zCEdORsgmsq
 dMx2t9.WV1T4ynK.xTajdCvWB5Qh6aGxiwCLambMXEXAlHMCmZyGfINjHbeidOwIPub57gSq3L8H
 8YQLHmpWRHF6EHU9tgRDQx1We0QV9Oc7AjuNM8OKVTjccyUq2G55XopBCOtXTrrIgGIjk8bDrq4q
 oZhVERd1ubG6g.aevU4zXq.1xA1cM91h0OH0lYtFDStiHAmn48ue9HWtnE4GcC5KgWvSrIVOOYyU
 DdXmUG1jiKoqXVZs7x6sRsFtAizpen5U66B5wjc8N8ES0lhCdCNpOtFwQ90n9__aC2xWDd7bcEVY
 oFsVAEGbw9lA3jM.EoYdePY5pCodjRdT7harC8LHoRrqE.rw1w1rGz0Lffugx9DGPwKQuXiOGpbf
 5rzW5lEAFRIZ9UDKf6miRCrBRcqUTMzVhIIq2W4dlpXIsaBI3H188KX2dUnWPRHtDTZzOmX__Nn2
 08oRpolIDfpf0bWSgjjpNlIpjYjOJBbeo.iR0Pak.ummCUjuhiZFk
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic302.consmr.mail.gq1.yahoo.com with HTTP; Sat, 21 Nov 2020 02:27:30 +0000
Received: by smtp401.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 74b21d6d18b50adda7c1c053fd211ed4; 
 Sat, 21 Nov 2020 02:27:27 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 2/2] erofs-utils: update README
Date: Sat, 21 Nov 2020 10:26:23 +0800
Message-Id: <20201121022623.3882-2-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201121022623.3882-1-hsiangkao@aol.com>
References: <20201121022623.3882-1-hsiangkao@aol.com>
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

From: Gao Xiang <hsiangkao@aol.com>

Make it easier to understand...

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
v3:
 more typo fixes:
  "algrithm" => "algorithm";
  "it's still not recommended to use" => "it's still not recommended using";
  "developped" => "developed";
  "unoffical" => "unofficial".

 README | 74 +++++++++++++++++++++++++++++++---------------------------
 1 file changed, 39 insertions(+), 35 deletions(-)

diff --git a/README b/README
index 7a7ac5d5cb6f..980f1d02cb19 100644
--- a/README
+++ b/README
@@ -1,30 +1,32 @@
 erofs-utils
 ===========
 
-erofs-utils includes user-space tools for erofs filesystem images.
+erofs-utils includes user-space tools for erofs filesystem.
 Currently only mkfs.erofs is available.
 
 mkfs.erofs
 ----------
 
-It can create 2 primary kinds of erofs images: (un)compressed.
+It can generate 2 primary kinds of erofs images: (un)compressed.
 
- - For compressed images, it's able to use several compression
-   algorithms, but lz4(hc) are only supported due to the current
-   linux kernel implementation.
+ - For uncompressed images, there will be none of compression
+   files in these images. However, it can decide whether the tail
+   block of a file should be inlined or not properly [1].
 
- - For uncompressed images, it can decide whether the last page of
-   a file should be inlined or not properly [1].
+ - For compressed images, it will try to use lz4(hc) algorithm
+   first for each regular file and see if storage space can be
+   saved with compression. If not, fallback to an uncompressed
+   file.
 
 Dependencies
 ~~~~~~~~~~~~
 
- lz4-1.8.0+ for lz4 enabled [2], lz4-1.9.3+ recommended [4].
+ lz4-1.8.0+ for lz4 enabled [2], lz4-1.9.3+ highly recommended [4].
 
 How to build for lz4-1.9.0 or above
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-To build you can run the following commands in order:
+To build, you can run the following commands in order:
 
 ::
 
@@ -32,23 +34,26 @@ To build you can run the following commands in order:
 	$ ./configure
 	$ make
 
-mkfs.erofs binary will be generated under mkfs folder. There are still
-some issues which affect the stability of LZ4_compress_destSize()
-* they have impacts on lz4 only rather than lz4HC * [3].
+mkfs.erofs binary will be generated under mkfs folder.
+
+* For lz4 < 1.9.2, there are some stability issues about
+  LZ4_compress_destSize(). (lz4hc isn't impacted) [3].
 
 How to build for lz4-1.8.0~1.8.3
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-For these old lz4 versions, lz4hc algorithm cannot be supported without
-lz4 static libary due to LZ4_compress_HC_destSize unstable api usage,
-which means only lz4 algrithm is available if lz4 static library isn't found.
+For these old lz4 versions, lz4hc algorithm cannot be supported
+without lz4-static installed due to LZ4_compress_HC_destSize()
+unstable api usage, which means lz4 will only be available if
+lz4-static isn't found.
 
-On Fedora, static lz4 can be installed using:
+On Fedora, lz4-static can be installed by using:
 
 	yum install lz4-static.x86_64
 
-However, it's not recommended to use those versions since there were bugs
-in these compressors, see [2] [3] [4] as well.
+However, it's still not recommended using those versions directly
+since there are serious bugs in these compressors, see [2] [3] [4]
+as well.
 
 How to generate erofs images
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -56,36 +61,34 @@ How to generate erofs images
 Currently lz4 and lz4hc are available for compression, e.g.
  $ mkfs.erofs -zlz4hc foo.erofs.img foo/
 
-Or leave all files uncompressed as a option:
+Or leave all files uncompressed as an option:
  $ mkfs.erofs foo.erofs.img foo/
 
 How to generate legacy erofs images
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Decompression inplace and compacted indexes have been introduced in
-linux-5.3, which are not backward-compatible with older kernels.
+linux-5.3, which are not forward-compatible with older kernels.
 
 In order to generate _legacy_ erofs images for old kernels,
-add "-E legacy-compress" to the command line, e.g.
+consider adding "-E legacy-compress" to the command line, e.g.
 
  $ mkfs.erofs -E legacy-compress -zlz4hc foo.erofs.img foo/
 
 Obsoleted erofs.mkfs
 ~~~~~~~~~~~~~~~~~~~~
 
-There is an original erofs.mkfs version developped by Li Guifu,
+There is an original erofs.mkfs version developed by Li Guifu,
 which was replaced by the new erofs-utils implementation.
 
 git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git -b obsoleted_mkfs
 
-It may still be useful since new erofs-utils has not been widely used in
-commercial products. However, if that happens, please report bug to us
-as well.
+PLEASE NOTE: This version is highly _NOT recommended_ now.
 
 Contribution
 ------------
 
-erofs-utils is a GPLv2+ project as a part of erofs file system,
+erofs-utils is under GPLv2+ as a part of erofs project,
 feel free to send patches or feedback to us.
 
 To:
@@ -101,19 +104,20 @@ Cc:
 Comments
 --------
 
-[1] According to the erofs on-disk format, the last page of files could
-    be inlined aggressively with its metadata in order to reduce the I/O
-    overhead and save the storage space.
+[1] According to the erofs on-disk format, the tail block of files
+    could be inlined aggressively with its metadata in order to reduce
+    the I/O overhead and save the storage space (called tail-packing).
 
-[2] There was a bug until lz4-1.8.3, which can crash erofs-utils randomly.
-    Fortunately bugfix by our colleague Qiuyang Sun was merged in lz4-1.9.0.
+[2] There was a bug until lz4-1.8.3, which can crash erofs-utils
+    randomly. Fortunately bugfix by our colleague Qiuyang Sun was
+    merged in lz4-1.9.0.
 
     For more details, please refer to
     https://github.com/lz4/lz4/commit/660d21272e4c8a0f49db5fc1e6853f08713dff82
 
-[3] There are many crash fixes merged to lz4 1.9.2 for LZ4_compress_destSize(),
-    and I once ran into some crashs due to those issues.
-    * Again lz4HC is not effected for this section. *
+[3] There were many bugfixes merged into lz4-1.9.2 for
+    LZ4_compress_destSize(), and I once ran into some crashs due to
+    those issues. * Again lz4hc is not affected. *
 
     [LZ4_compress_destSize] Allow 2 more bytes of match length
     https://github.com/lz4/lz4/commit/690009e2c2f9e5dcb0d40e7c0c40610ce6006eda
@@ -134,7 +138,7 @@ Comments
     preferred to use latest upstream lz4 library (although some regressions
     could happen since new features are also introduced to latest upstream
     version as well) or backport all stable bugfixes to old stable versions,
-    e.g. our unoffical lz4 fork: https://github.com/erofs/lz4
+    e.g. our unofficial lz4 fork: https://github.com/erofs/lz4
 
 [4] LZ4HC didn't compress long zeroed buffer properly with
     LZ4_compress_HC_destSize()
-- 
2.24.0

