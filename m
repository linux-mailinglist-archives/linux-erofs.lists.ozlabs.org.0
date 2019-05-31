Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0F8305F7
	for <lists+linux-erofs@lfdr.de>; Fri, 31 May 2019 02:52:13 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45FQrq0jYCzDqSt
	for <lists+linux-erofs@lfdr.de>; Fri, 31 May 2019 10:52:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1559263931;
	bh=GtDSntCTlvHcSt/O9HR30VcqAB8gtjl6pEnjkrcnOp8=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=e7o7D7Mw7D36Vq/rqlM2+l/N4VFYUHj/wRy7ivlIyCeDZ8j2H1IiXyEB53tI1UHtg
	 tMR3VTYHqfhnlheedU6t3YB8q0j+gYAXpFb9cHG8EwdeML2TPcA6JdBenGFC9V/31r
	 0AQWH/moHUdkfGnpoqcdnGcerrqiT3t8TqDts7LVAV3DyLPsnZcu1tI+xFC7je+32Y
	 sTJYiayMU+qZQ414lc2bUBr6xgFtHCukMosAd0D8DYJBbD+3UyZo2+6CVDuCOqT4CZ
	 RjoXj+gSN5pkMJp8+ZLd0YhkG3i/7qKHRNEN6NxtqQOBuW5+XzQNyWf+ufTaf3SIdS
	 DtJfDpNCXuV/A==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.65.83; helo=sonic313-20.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="K6GM4GcO"; 
 dkim-atps=neutral
Received: from sonic313-20.consmr.mail.gq1.yahoo.com
 (sonic313-20.consmr.mail.gq1.yahoo.com [98.137.65.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45FQrY4dHQzDqV9
 for <linux-erofs@lists.ozlabs.org>; Fri, 31 May 2019 10:51:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1559263913; bh=qLYab7wcYpgCdA+vDShSs9fOafnkajo1UO3OdS7I44E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=K6GM4GcOaArHI4u972GY9n8E02mEyw8oes2BmlqzvOZnDlmgVDyjTlAI1bhRLmChBqE2jaxw3H7hheuoUeTSRZuZAKygs4hfuo1dhYbzJw6U/xXMXv59bUAHkOLe86rCqjSS4ToqnT4MP2MH+CyssAZK1FbZ5mOwLrwU4n4qVP0yAcSYlsqQ3l0iQWfGDe3FliawXjFGgXNXx6ljH4Ab4XrpS6hgxfXSjqPtSRVqSdTL9UGhrZpVEtwjJ9JlCILMVRIHmgUILZj3dDJLOPO/3I+gS5G3OKhcCjcno0gjnl/aI8XD1fOGLyMxBGUBF1+2HfknhebaJBkBG7jKK4gecQ==
X-YMail-OSG: 4XWujK0VM1l5p1whDOjd2QoH5S.G6Dax9P2EBga6YDd_CsNaA_ic0_LsQLJQGBw
 aTEFCSAy0yLENlhNgsD0NHfo08aPNH01Ds4AP1aietAEpo0Y.zwiqlzDfoYMTGFk2ffHDWiXbwdR
 TaGu5n0WH7BcuAF28Qkd0HOL5ek9ybSheW0DBpFTNIDPOtIp6n9xngfCjmM3iQZBejhTeRTNLt5c
 VXFRNxHtUmZzzzf0aM2XY7KYjC3zDgZp0X5X0Qx492_vRW8ZniW0B70NNNoc_2m2coTn1G57vlk0
 IkyFFkYrITsv_T31fBnkodpD_VB2oly7QA6nmt.QEVIW2lVT5_FlV7Zl1eKnMvVkgE.5WvdLrq_c
 xyeFi0NE.IEdcrFYTA3F5wP_BTYb8V4Exdr_MuvJ1NI2uJa1Vp_yf5CuftkXWyB7YCpios3AjOLR
 EuJwtKnwJIZscpK871.dFGqXsaNht6F2cyhk5TvAZPKlZFwzTYg1FLSOec.otyKofCtz933WgVnj
 ggg4zCkw1C0oIi16.bIRw52BBUYpI_SlncmtcEdvEo8lSymQs1ScHDlZJaSQC0Jyv17uqO90iJ19
 XWbjvETZI6cJ.._tmjkjC7OEmHwIvF.gm8dYz3KXmLDdueBRkXE4VSVemiOK9gnZXKnCGZjlzjDD
 KriRm95C6OGdqWkot9jpPoHMcTH8eeUD45U4ahF6Ex0BuUWAaZ5AkOWUWaXgfrFKWNHSA9HP3D8L
 _as5w0Zul2.7tGMkS0Y_QpX27JVz7Jlnqd8Zf0D7S7b8_ykk12vANtmxDJccPudDLNsUXWtmQ3D9
 p0h3g5.MYsx5j3LbjKJZVK0x2gOgycAJWDKf4yQ6ImhagpEN.TqUSBxgLHKh5Wol60txFsfhxQuU
 wbvTJDDAJhrT0S0X2AM5b7P9_YQhv8gAJlXJ71lBvmVUnNLzKFTaPCbsOKrgSbR8tFUwbcCshg73
 oIxTzqTup7kpWkO8GBiz0mYconettsk0flOEqW4BcAALZOggeEkxPZ875d8JgiMOlbmJJd5lce21
 uZvX6fV9UeeEQSzPC9elSK7WSsdM6TAu7eXGkQR9VYaxlxryPjmhFh1.digbbkhESBvRyqcJkem2
 UyLAlT3GpODn3DwgVu2ibH534UbWGhLyn7R2SOD2xWTAhvv3CQQaA41xbA0MRX0JMbbT3MnuxuGd
 uqrCxJ8HC8S0gWZ8PvfqpH9BneRWDyE9QjLHaaplsA7gfIYuZn.KzoA_dcTU-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic313.consmr.mail.gq1.yahoo.com with HTTP; Fri, 31 May 2019 00:51:53 +0000
Received: from 125.120.86.223 (EHLO localhost.localdomain) ([125.120.86.223])
 by smtp417.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID a9e989b6e54ef4fb7ecb5a20a6091749; 
 Fri, 31 May 2019 00:51:53 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 11/13] erofs-utils: propagate compressed size to its callers
Date: Fri, 31 May 2019 08:50:45 +0800
Message-Id: <20190531005047.22093-12-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190531005047.22093-1-hsiangkao@aol.com>
References: <20190531005047.22093-1-hsiangkao@aol.com>
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

From: Gao Xiang <gaoxiang25@huawei.com>

It will be later used for marking whether it can
decompress in-place.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 lib/compress.c         | 2 +-
 lib/compressor.c       | 4 ++--
 lib/compressor_lz4.c   | 2 +-
 lib/compressor_lz4hc.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 205a4f2..7bfb8ce 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -131,7 +131,7 @@ static int vle_compress_one(struct erofs_inode *inode,
 		ret = erofs_compress_destsize(h, compressionlevel,
 					      ctx->queue + ctx->head,
 					      &count, dst, EROFS_BLKSIZ);
-		if (ret) {
+		if (ret <= 0) {
 			if (ret != -EAGAIN) {
 				erofs_err("failed to compress %s: %s",
 					  inode->i_srcpath,
diff --git a/lib/compressor.c b/lib/compressor.c
index a6138c6..570db14 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -26,13 +26,13 @@ int erofs_compress_destsize(struct erofs_compress *c,
 
 	ret = c->alg->compress_destsize(c, compression_level,
 					src, srcsize, dst, dstsize);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	/* check if there is enough gains to compress */
 	if (*srcsize <= dstsize * c->compress_threshold / 100)
 		return -EAGAIN;
-	return 0;
+	return ret;
 }
 
 int erofs_compressor_init(struct erofs_compress *c,
diff --git a/lib/compressor_lz4.c b/lib/compressor_lz4.c
index eacd21c..0d33223 100644
--- a/lib/compressor_lz4.c
+++ b/lib/compressor_lz4.c
@@ -21,7 +21,7 @@ static int lz4_compress_destsize(struct erofs_compress *c,
 	if (!rc)
 		return -EFAULT;
 	*srcsize = srcSize;
-	return 0;
+	return rc;
 }
 
 static int compressor_lz4_exit(struct erofs_compress *c)
diff --git a/lib/compressor_lz4hc.c b/lib/compressor_lz4hc.c
index 3bbb754..d9413e2 100644
--- a/lib/compressor_lz4hc.c
+++ b/lib/compressor_lz4hc.c
@@ -25,7 +25,7 @@ static int lz4hc_compress_destsize(struct erofs_compress *c,
 	if (!rc)
 		return -EFAULT;
 	*srcsize = srcSize;
-	return 0;
+	return rc;
 }
 
 static int compressor_lz4hc_exit(struct erofs_compress *c)
-- 
2.17.1

