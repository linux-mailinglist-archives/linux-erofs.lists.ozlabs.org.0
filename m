Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CA52CFBEE
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Dec 2020 17:21:31 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CpFFN2nvQzDqpK
	for <lists+linux-erofs@lfdr.de>; Sun,  6 Dec 2020 03:21:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1607185288;
	bh=pIH6iD/Q5cybHDnviW6H76bVSRc0GSJwxY+QVB5qfLE=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=idMq90EAUv3p0HR0nkIBTjCdAgeQCNyPHnDOs6F1SU1yztIicBgG5Ac4AeKfZfzd+
	 Fs/xjucTnL++q9a0KghcyFijOCoi+5oyjysXadDQg8pmlw1WsXFR1vBofvSWZsIeBt
	 7luMbbD6J9HmJVga+fU6kY01ycWOrW5UieUoQO6nUQ9NVG1vMIJyyTk/1HpLAQXclk
	 7IkYpHgU565KAzcDC0xKbzbTYgCSAWvSEYjcWCkATGXuZy/Sc20CFqJkVZy8f0S24w
	 dLosqfgByFZeS+dmv2MwU9rrXlliN506FBxZCit//Z/m3Gi0rnGQzPlP4vR3b9Gh6m
	 lOa029jEZpC6A==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.205; helo=sonic311-24.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=oY6GpKeU; dkim-atps=neutral
Received: from sonic311-24.consmr.mail.gq1.yahoo.com
 (sonic311-24.consmr.mail.gq1.yahoo.com [98.137.65.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CpDN16b3HzDqBv
 for <linux-erofs@lists.ozlabs.org>; Sun,  6 Dec 2020 02:42:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1607182923; bh=Cbl4nC5K8iGXe0WzdRDODtR5OOeVy2S5V/z+2b7imhU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=oY6GpKeU5nNXS2MwYHAME/KpxVJBg9FQ31cUu/vvn+POD8WhBPv9C9Tkanklh2LHkZfAWG1xBad2eieRNd0xftA2HMegCuHHgfzJXO6WK+hTaSm99OsrExnlMel+YL/nawD5443oh/15yLsjgnlcucnCz+WDfniYy0wCRQJXCkXFXixl6HVDFuQMKJJwJSYv1FXGlo0biCJMkNMhBZW2gGaT+Cp/ewfXFwEf/z9W7T5T+zcydBsyyuQPkHt87eLFazgvtCkCQd0jDag02LsQaVLkxjCKeMnGZ+axfCpFE4pWp9eYbi0SBKZZEsVfdR4peDmlIsvaCcRSqA5emkh3sw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1607182923; bh=+yxexMOfbhfXac5BwRRxSMRsACsnSLByMpTEWr8ettE=;
 h=From:To:Subject:Date:From:Subject;
 b=PFLcyC4CDOS+SwKOZnA0X2GylLeV+F+sVRk5IrdVok3376rV5aRmdzW4KrBLW+OI3/sOcdnqhJzCjpyKjsXMcDMxM+Hl7JivhrxhlVF9rahgcofszTe7WUXTar099EuPhixsaM1UYelZ7xyH+xkS+zq9dvliDa+ojd0kY9MsQhwVRtyHRo6wync4uwVDufaKd+zA91eJ0YBmIfyWcVo9uzPhJg9mg3vHEdJUV8C7Z1Rcwshs9ZBoWdB72CJOIHOYtVDh8cs6MkF5O1ml2kXyI6WOU7jcNmvQh1+MheCrtCv5Gq+FSKTx3M4vqiS3ySrD9wYUOQ6ou8iRhQP7g4aRRg==
X-YMail-OSG: w5KuO0YVM1lCrWfj7UzKkvJO0dj8_045lYtLQgaE_v.ghAtzpbDmjtrIgeyIpTT
 Hq7eyK9vQ5WjLbE6kHap21Pf7UItYpDCxVvVsyvi8YnI1834inVTxhbjPp5AV1LE8HbbJ_vyM_Xh
 ZmX5w4FZP4G9lvfNinlzp4U2EFRTtPoodaoFMRBmyRC.ZspPGVfS5.GD2QWCg..qOwL5m7cyyMpg
 e1q_P8nEUGfW4B19BrY3OLyiNKxKzjDj6fA5ktW4LodpPAjQMr1lNbMUSBQS1e144HxDI.O47Rpc
 C4ZTo9MpVMHh9mISIg7072HHjdRHn2ob9eclWHZqoiC8bUjc4G5RcAdQs2IG8Ntpa5UHuReinIB5
 uRQaaaokyq1Z9Hv8GXkX3dixkbxkeAb_WwnrOp2uE90Iqdg05d.NBwv6emBOc.d_j2lgCeuEEdnX
 L9H6o2omgVVTAvLD52R1riJIskzo2TT5qiFk3wrl9hWIAFrpts6tB2I07.m0sYsWHAdb0CTeZPQ1
 xAdjrAcUo9NnkSsb5wGrCa0cl1k5noAsbS8sGtY_PpuGAIK5.7wFafemRz.zi9UVN9ntgB.jPta1
 KIyS70GTdARV_2T17O.bxvZ8yEzjY5FDmYoKg.e64h6_V0IO.FRWIyxuQJIYHtVndoL37cjG207L
 9e0glBVlOtDFcgisR80.azkNt7DyXhrSjdbcmJX3hwZHROFNyqlBGgmbGLo57AH9k.XzZWtl.RSl
 1.6.UA..E.Gr_6yfl2RUM2J50VCpE7PtvAM_tEJSjmwkYkM8tas18H0VgSpQqL0wDnxikpinpdfr
 DqAk.058NqJ6xYs.z2S4zyt1LNMGKc5y5eDAkRcFyL.KkGGdgVWkzZULX8EVtjDNpHfs1w.SdDKa
 LJcy5vD8DbvFlE9dUSDJJzcI013R9nmKlAC4Etd_4rvIaBY5mfhHuSEESG9zJuNZPqcIs0XwNPMh
 On6pm8qQJl5gqAF3OHS_MDzy9UomQXiQQfSGG7xMW00v93cjzvihtDECyjHG9mxsF3sKPWoVSER_
 dey9BFfDwplEAl8Z0PxKcqRjvFGiGAzZf4IuzBHI2T.HlaxqISRyfRBAmcDwGZjx_ktCfMPwibal
 VxJaDreOrW7VT_Q1jsidCRILV_ZsEXUWLeVH6Dbh8y6y6oWQiL8XHWABfYOylsb.XImfywTxhGmt
 UdnOM2uLVV_fn2F2T1K_K9uCOKfHLfOll31e_qYh130Bft1YkEpyj_0tDUwJ6sDzJjoVU3gnzLQ6
 wIb4uuXNY7A9A.i7q_bO_85Z42iDQWy7LS1NCjD8.VldFNtyxPF_appEpYI6CbqlnAQCkSqeALRo
 QMlSh5nay.ttSF8nApsdFVA4l1Tb9XcwuF9frtpAnRiX4WVzBrBjfN4TRiijjfgixNMDkbFFsATg
 lkaFFn.yKABu7BXlFcbKQq8qlXSiiNUQiywq8P7eX2OOqqrvf2DA8wjbJvZYitkoIw5w4.gmbQb6
 ZXU6dmUg..czllll9z.XLbsUKehPTOZx8sLY4lsCOLyKxXgXJLXGqKoKevdwJodvV5fO5pmIGHJj
 993SlzEFTHtSqAaPArSZ9Mk_ZKH2YJc_WpR6uRjYS_bNUMpsMIyfJ7w38rroX.fzQNUJFKCK6_Pr
 _sfPrgKNhjTSr4RNf0kBat1tdMCp9jnymX_.B.j2or6JfYianEOgY2yg1jTzhOL1_2KhpzJA1Tr3
 o.cvGN8KDvwvWyAe6cOFDoZzRq.Bsdfk0pqGBOUspx4vcQ61LSSM1cnQZFMER2Ccke0s8XLZg3jU
 gnLN7XSo3iYIBEag5cy_XJ9TpI2iFaMAfA2P7T9Qi5PtRa.hYzz2rFwLQJBJtIl03QNf9r0SvZYy
 JeW0ZHCNtBxLMU1lzKzFO1TdjGpk23O23dM6jjzEoQbpNf1KDpsYVzRmKxEcumxej_tQ84z546Lg
 yzRTveYlKR_1xSYsv4QYL5yF8HHanpJkFQ7BLOpyXl.seJ49BotauSzZ45FJWir.zkAgTolk37wQ
 SuCBPYXCGBc2_CeYyymYlAtNqQkDI1TJ5jdGr7sXARRx90FF1lv0qwvudz.CsN4t8Oy99fIzvtu.
 VYY4hJImOCXNMdCw0QCX2tMsHZhIYoHPM.S7ztbiU7tuQSO6h4dnKUUXkuNiWtB0nC7DymZ1dw5V
 kyd_c23wxBfIRTfdgB4ZRslfrIrjBUQOjvz3uk0Qy1Qhh_1H_euPlZwK.VLlADPxahvFMtAQRbpy
 1nxbEILPZOITUt64n4SGQcagkqMYBVn8jovUy.LcUcXdhwGMEJQixbRPsMYBU49wYGtX1uXpGC_o
 WMke7XBUcFZQoJcAjSCEkw2LtDPzMrf8glssFN9FtVTa3WZlRME4iP06O8izqfO7j.jY3DldTF3m
 SjkW2nT.ytjWHm8OV5mFL5iMsGe0zosvb1anItRnczkfnHFeoCcfvAQnMsxC6G7uVuhygaBAMyCo
 Lu_Cz_B3fX_LLnO.zhkokMF3EmC5oRNM-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic311.consmr.mail.gq1.yahoo.com with HTTP; Sat, 5 Dec 2020 15:42:03 +0000
Received: by smtp423.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID ad7da56780a5b2c758e0b6bf27f59a7f; 
 Sat, 05 Dec 2020 15:41:58 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: document erofsfuse in README
Date: Sat,  5 Dec 2020 23:41:41 +0800
Message-Id: <20201205154141.14588-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201205151545.10935-1-hsiangkao@aol.com>
References: <20201205151545.10935-1-hsiangkao@aol.com>
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

We are about to release erofs-utils 1.2, add some words
to README about erofsfuse itself.

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
changes since v1:
 - fix some typos;
 - add libfuse dependency and "How to build erofsfuse" section.

 README | 90 +++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 73 insertions(+), 17 deletions(-)

diff --git a/README b/README
index 980f1d02cb19..0001a67fc37c 100644
--- a/README
+++ b/README
@@ -2,26 +2,14 @@ erofs-utils
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
+Dependencies & build
+--------------------
 
-Dependencies
-~~~~~~~~~~~~
+ lz4 1.8.0+ for lz4 enabled [2], lz4 1.9.3+ highly recommended [4][5].
 
- lz4-1.8.0+ for lz4 enabled [2], lz4-1.9.3+ highly recommended [4].
+ libfuse 2.6+ for erofsfuse enabled as a plus.
 
 How to build for lz4-1.9.0 or above
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -39,6 +27,10 @@ mkfs.erofs binary will be generated under mkfs folder.
 * For lz4 < 1.9.2, there are some stability issues about
   LZ4_compress_destSize(). (lz4hc isn't impacted) [3].
 
+** For lz4 = 1.9.2, there is a noticeable regression about
+   LZ4_decompress_safe_partial() [5], which impacts erofsfuse
+   functionality for legacy images (without 0PADDING).
+
 How to build for lz4-1.8.0~1.8.3
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -55,6 +47,20 @@ However, it's still not recommended using those versions directly
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
 
@@ -85,6 +91,51 @@ git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git -b obsoleted
 
 PLEASE NOTE: This version is highly _NOT recommended_ now.
 
+erofsfuse (experimental, unstable)
+----------------------------------
+
+erofsfuse is introduced to support erofs format for various platforms
+(including older linux kernels) and new on-disk features iteration.
+It can also be used as an unpacking tool for unprivileged users.
+
+It supports fixed-sized output decompression *without* any in-place
+I/O or in-place decompression optimization. Also like the other FUSE
+implementations, it suffers from most common performance issues (e.g.
+significant I/O overhead, double caching, etc.)
+
+Therefore, NEVER use it if performance is the top concern.
+
+Note that xattr & ACL aren't implemented yet due to the current Android
+use-case vs limited time. If you have some interest, contribution is,
+as always, welcome.
+
+How to build erofsfuse
+~~~~~~~~~~~~~~~~~~~~~~
+
+It's disabled by default as an experimental feature for now, to enable
+and build it manually:
+
+	$ ./configure --enable-fuse
+	$ make
+
+erofsfuse binary will be generated under fuse folder.
+
+How to mount an erofs image with erofsfuse
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
 
@@ -150,3 +201,8 @@ Comments
     and already included in lz4-1.9.3, see:
     https://github.com/lz4/lz4/releases/tag/v1.9.3
 
+[5] LZ4_decompress_safe_partial is broken in 1.9.2
+    https://github.com/lz4/lz4/issues/783
+
+    which is also resolved in lz4-1.9.3.
+
-- 
2.24.0

