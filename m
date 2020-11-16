Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8F72B4664
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Nov 2020 15:52:45 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CZX9j5R4JzDqLd
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Nov 2020 01:52:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1605538361;
	bh=ahtf3wR9zAQZLD3wn2vYb5BqFVnQ4zCmkHok7iz4BBY=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=VoNkxpnAyp+/Heg+xV9fKl+EAiHCSZzTFfiyEK5fuiPUjoGaxzp7gd31x7FbP6kHK
	 cylaF9UGyuJEAa60JCftCvc3iMtMW6kOuUMVPxT9Gnrb8m9oyBzND5zXz6lYuABPHg
	 kNZmjlmaq0HiQUYI+KXfvDIcQZUEouunFBL3ZAn1aBcCtUWNd5YWVWESPIi8+OctK+
	 q9MgMUB/LHNlTHnOoBS7bIjecGgk074xCX0ynswQkFX4ZcdrFHkrmJKVnH/s4oUXYt
	 avEyH0sZ8cSCab5K0rcIfvlpDWSLszJ5kwm0DBMOvJ/hRIgoNjLWsFYNbQ84eTYhTC
	 Gic7uhnkupOxw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.146; helo=sonic309-20.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=KvBnc76w; dkim-atps=neutral
Received: from sonic309-20.consmr.mail.gq1.yahoo.com
 (sonic309-20.consmr.mail.gq1.yahoo.com [98.137.65.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CZX9T07lfzDqKP
 for <linux-erofs@lists.ozlabs.org>; Tue, 17 Nov 2020 01:52:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1605538343; bh=4ELPHoV+c93PVu1KpVyRb7QXQYE5D4RAcUDewN/dr1s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=KvBnc76wwt5TK4Q93iFjLeDtmDdMPi73Bq4W5EsOAmtHI8vOPNa2rBlfqvQ6H3TboS5lUsUaJs+LHDxrvdgN7rVzL7Zf9bY35EKIA/axMRVg2TrLGKlZBnA1AQC+UoRM7wwS+QPA8ZyGPfueYZHzvUet5+D2+sVlvzwwEZ3bKKO5Fc3TWpFTRCxezPuB3l8Mxyg5H5ui68qvDWIJU7hZRtjPQlnZ8RFnPgiPhIeLd2lsSdbifRH3dV+7L0wm5YbCe3FHb+JQ4MgmG8sO4ZqOSaBwWZk3sDmoY/blKUQkaDmbmJLbdatZ6wpvjk/ozzrHcSnBy53jdE6caVOBcCYEvg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1605538343; bh=4KZRLdmrq6c1arDy0lB5d5mKyeL9l7PtBErakgc8GU6=;
 h=From:To:Subject:Date:From:Subject;
 b=oU1t5cOdmbLCDbj13SNXekG4/fIUNa0k94+NC0AhBvV2tvAe6kzed+LA0zO7BxSW2YWypP+o8WQsjn/aSwjXGOVM+ngTJeQktd9q3i5aTUpTASN7S5HOQRH8abMI8aaQkFPslLQVo5Fk7pgRuCINLt41GA+v1BGMmUGdGHo7RHb6TbDL0nnAUhetqd0jzIryTNJTjJkpvdsj5YBwSaIGx8qgWKcXOLSxZobfwBYEMUj8gBEjQHaQiRWlyeHy0bxV5Ejhpb8XkI08KP/Rc5QX1sC9BgHu7sIpc7JAMEjfGF8MTouZxQfHYgI9rurqXtyZdEZp+tCPpUjJTfjCy6q+qQ==
X-YMail-OSG: eIQtXR0VM1mAaK798R3Fw_VcSZ5uhmbF4kvWy1Nuu_y8x36aMjCRAm_FKfMo.dK
 .ccz9mR41ZU833qkuPn4F4NeEqzRGByGing37LdcYd6kLAawTMP._pQcpp3kFP3tjTvXR.GtTqRA
 1aZcAU2jcdhunOeUU0e.lb8r5RRhsSGfixA8WOePML9kkjKaYOV4JkygMdVRurhQ6uqhmmOwkJ4K
 aDdhTn38A.oOcNNOzS1ZzKqhbH1DJPmFWOpOa2Mvh8qOPbgIVTQ_mv5jTXIfoo5TVqkPry7ofw1N
 qk7Ejda6z7jcdfJRk7nglOmZhvDSaCX_vq5iQP2cpDevTgVIFvp5SMiXM8ADiT9fpWSqqDrtpIrO
 U_RnI2fbRiWwfxqs5C9KF__mz3ZGr1Q0aWN5etoMb2_DHX6291MY7VYXqqtIHrSRotCPQ.QsTXAr
 Vu6HaQ9K1CEndpy9djyufEQVXmC43RRLBjCbQi0yDMY3a7.DNmER8AjROQ7kTOyWRIdp.XqNNail
 aYqJXiRv2411uvT4AGeZlFMz0bD7ooeq3BtPdy_XTLFr_x4qsRxaWiFXPJWBv4N27ZXWF_stAQuU
 .ljD9MNkqvIZ3yQSagKdPcIZz5Zog0NfbxKnvXkx9J0tsqEq7E2dh0O.8Dpd9Mt.xJgdzsZMZxQa
 Croy8fbFT56lMYdBcFOSRsdP92dlV_BQWuSWtuHQuDZnaLfIlesmSmV9h0nboQ_evy0XMsI7VJTB
 U8SdO4yCH2vyeAADH0Y_YOfBnD_x6Ky6DJ6gU9yTQ4EpqQOaNEc6YrGINE2yAtvjmldlULZmhpZQ
 vQpEleJa5PlyATf2_TSb1jAoCqB93s3YbR8guSzcpoHJCLeM9pv4j4bpESDRJ3RfJwMXwmbDQGHw
 LjQQ_O8w8R1sMYV8Y5qOXmVF6dg41978F8addduVd7vZOO5NWa7kpAkiiM_3IFVwBSmNFxUZJr_p
 Mn_1C6EhAchjOeB6XbVDYNRG9UoK43W24G9_NnJLRPyAwrXDElV6_QoCSAeB6fslX3maT0YAI34b
 BC5zjKUqrRis1.xkHHMk7gxVASWPezi1.rsRTB2WT9Wl.GsTwnKp1n4Tqslae9xx0wjrnc1R2duc
 DqLpmmbYQOjgz9TWaXOz_7aq8iEAZ7S319KjTrVwMJgC4TpFhvi.1TzcQ1fpyQATdVyUoi.VYFv.
 kcYxMzkC_1UrhEzUXturrtUfgdQaexEoNw5JlyJzAFMulOpq73zvve9UUNIwiCAYTfAD9vbTcdNi
 rHfa1QhNKG0JL.3G8k5B5vbD9u79KUlsMw7BWaPxg_a3pbKXiyjXKmP4.QOCI9NcbuN3vXj0dz3H
 U7iK6kkrLCkWfKPNGaatRa6gej25OQ7wIjGRH0d10ftr5A.qfiXjxO3yQhRwdCZxdQQ87190LFRd
 vuriAQAwhFbnsC0bIloh.Ij5rUsYj6LHpYfAR71Ven3ViMf3cs17DqSdmK7d9aCWXvpr_3FLCv48
 4WyJfYY_Xob.KSQlA74CPgV..svpX55FP_3R4jlxhEBLwyezyIXhV80TE4JpQSfDSdAxANk2Q4Wd
 j6Fjpw_ZkkMBJaJ6IaC.te3rxRMhT2TVMu5.Crh7NBD6HZbzTzINexbfXVjs2AhyJak1OgjCCgDp
 6v678Z8imOgulgy564U8mlokwhBx2F6Jll5Idq0Joz4hDrPd9hAOj8VIXB294EdmCGRxmcnrNK0_
 829DTecugtkhuyV2O6umvR3x4qiC_tfLFODXr140_wN5Q8mmX96UOnnJiepgD8cHl1YeH_DDffvA
 GnzawsV4flQOI6tFu_c.DvV8lLTK_EajjOrMlpe0pNRMd1G4gr5SEg2f3rH.FEXuOXdOOSn_FwJC
 IA7XBNgI0fWXgO8EQ0xKvC9jyNgiJt97X1.rkp3_lR8svzv.VGjZA.td8gVbUQjanDXu2sDYi3XT
 NrCabq3VzHU1L4hylJ8SRgTHBNQhKtBoznPQAqWtPiJ53R4DnCgS0CrX7TMTPW0ukuIt79wpgQpe
 vV.JbJ4f6LkkcyaogCGIxCvBvxQPnObqxzcABp6oc11LNmzwf1oobTEKtArlh7Vvu7wIOgrOi79b
 g3sP0sc5X6A6xgbV0eky9g4lQWnBBo5KhbhN0DLGs8TUE_QEP8OW.4smNOka52yYJ6n8lal2sAot
 zu9tDCE8GLiWgR5W6QmZKv.VbjnKRODpW5MWppIzfCsyit72k10SXjBwXdREhd45BxNX6ujMKmq6
 yPQ0d3oBv.dZMA6PjNHjEAKh2j2Pd6Pn4sPICzL6TwXeev5QFLqyDxPOMktLVua5gnHT5MPlMn1K
 Q6eAOAW8MEUjVPpogaD6toXMV..9uvUbPlDCMvMaMoz5ZM1P00JJ6NXwDTUTPJJUUphUpRMB71LW
 SRlPo.RpK71Fg.v1zIxniw6QTgXNQBkQPQYONw.esrvGqCOLMpXwvRBZLfBxLAMAqUMJ3hEzubjL
 FbVNV33NMl4yKRZuXyMxU_NXzrYb1JHNB6SsP4diOhJGs4_NIBG4jSBlVMMPxEpQvIDW9JpXEK0C
 IWEihFPKw05NTuFDb1gprUGcqyhQeaDg5NmccmwDFMdRPVhjCZjG2BruyfylNi4Gq6Ezs7ufcFye
 _NGUl4P96aAyRZx9mUpXTKjEqnTQhIeRCb_mCKJPlGBWJ9SM8SWgPfmAj1yjr.3C06uneUx4BDfd
 XNuVAxVxreCdfDqN0Y0Z62P4ZWVs80k.4UQ--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic309.consmr.mail.gq1.yahoo.com with HTTP; Mon, 16 Nov 2020 14:52:23 +0000
Received: by smtp425.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID e2a85983a6c055d9c82ef00b649b05f9; 
 Mon, 16 Nov 2020 14:52:19 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 2/2] erofs-utils: update README
Date: Mon, 16 Nov 2020 22:51:54 +0800
Message-Id: <20201116145154.9279-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201116125527.3644-2-hsiangkao@aol.com>
References: <20201116125527.3644-2-hsiangkao@aol.com>
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

Make it easier to understand...

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
changes since v1:
 - fix more typos and descriptions.

 README | 70 +++++++++++++++++++++++++++++++---------------------------
 1 file changed, 37 insertions(+), 33 deletions(-)

diff --git a/README b/README
index 7a7ac5d5cb6f..88c45a25ace9 100644
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
+unstable api usage, which means only lz4 algrithm will be available
+if lz4-static isn't found.
 
-On Fedora, static lz4 can be installed using:
+On Fedora, lz4-static can be installed by using:
 
 	yum install lz4-static.x86_64
 
-However, it's not recommended to use those versions since there were bugs
-in these compressors, see [2] [3] [4] as well.
+However, it's still not recommended to use those versions directly
+since there are serious bugs in these compressors, see [2] [3] [4]
+as well.
 
 How to generate erofs images
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -56,17 +61,17 @@ How to generate erofs images
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
 
@@ -78,14 +83,12 @@ which was replaced by the new erofs-utils implementation.
 
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
-- 
2.24.0

