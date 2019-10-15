Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07968D7A76
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2019 17:51:13 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46t0Js57kZzDr42
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Oct 2019 02:51:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1571154669;
	bh=C12IfwyrvQWXF2OXPazSP8dK4t5PnuJWQMbXc9aEMEk=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=nzkH8n3NOlndjnTnQuYejApycXMR/xpp5FqCXvLaMF9OeGIOEsjPocL67Wmpx+xqi
	 mlODdzHYTwNAsQ2ucXspEKU/P+LI1LDAfsb0kipe+WCDZnCLWnEGRzWCN+NDxoATXH
	 9iEFLdem7WF210m9iDuhSjOU1Q8pG/QbtwtgQc/B/yMyRHil9Xlk+DTHMKBOe0QOpu
	 39hUtzVZ5xhe34dH9kD8h/wfHhPJGppt5ATADyulzBmSf3Xsn9VGYeEwhEfHRKasy9
	 F9cVwu8BcjJ8BrldrXw6XVLxLagHsjZ85KyIPLCGrjD2V+ZgigoIgWG4z8EGdLU5EM
	 5/qjWcudWQlbQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=77.238.178.201; helo=sonic303-20.consmr.mail.ir2.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="mKg6v8mY"; 
 dkim-atps=neutral
Received: from sonic303-20.consmr.mail.ir2.yahoo.com
 (sonic303-20.consmr.mail.ir2.yahoo.com [77.238.178.201])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46t0Jb4nxHzDr3l
 for <linux-erofs@lists.ozlabs.org>; Wed, 16 Oct 2019 02:50:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1571154646; bh=8BLKdIlocnjHNd5LakcSDOyDI4PTRcm8/F4b7S75hwQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=mKg6v8mYLVamadSFfAKU5LBUwvwLiSkyuaI308m++2zoi9k3KKHVPHgS3AddwW3Ru+H/H+pcUI2QgjBiEIBU9+NfGxLlWbL1YW4EXVo8HIFNOaMT2IoEHdrakjVQuEEakSKVDyKE+b0SOEHM5IW9NH8OQ8DwDEYC65wXEp6wUiHilXkb2vIH4WJI32eqb+D68yFTpEEZldAblZ083ZKRIu5QJm49TKq3FJJ/st7k8RhiOWm7lXbh/1TYukXwVpeFJ/BLQoisHWsU86gMklJl3N9YwsOxHb84W3DRIBvhrwKYbqke6Nl3SCAqsNe+2K1yW99SS/9hkrXtYYi36RuSEg==
X-YMail-OSG: 0ZCloKsVM1m2P9393kY.cQrHLu_3iHoqalxOKxm0qDzbpmifKVafFedboCBlORF
 OdWz3e_k5Q6ck83Byk9NLO.64bHxP1dZ5KkWIefv8WKb7F1TQzXGvQF872Y6wQdJA2rboODDjXkr
 iHCmrHPqIMO5bbgsPZBAe9HyZrW.4e5BjoJrGylUtg1HjG6VjV0tm1CQF0R8ntEGum89DwEGF.Hd
 OxI9num7E2gJ8_0qe20ZKHhyHwsQaz46cVnqxWXHjPQVwrQpkxSd1xfjqxyzaOSFEEZwKFuZUvP9
 ZUPZERTgRgTNP3hXTgi2dLFcFOVe2URyLJGCjhqvQS6923LKpLFn9QE8CgIrgbIVyNCxc.jWe2HC
 efj2k.uytDZRr59n3iRk8iAaQaGFzQr6yGme_K1cZefi1HI2PdilzYfqMiDl3Ur982BPA8GdKubH
 VZCEaJjoFp6KIvpJsIIOzXhuEUlYb6ZTlgffUrA8NaVFRCgqWFUXcoMzXTorbEkczapMRwKUljOw
 .Umk6b5VJWusgz1lV5DauzL9zPYd7rwp02BiTHap7jeKpetkZCHrRu7cutyV.b55BPrPm6PgVWwH
 hjVtjIzlfHPYJKq9.aSUu5qtiaNLsta00GMoHdDKahvRgQVGBmlYfSLW7hq_lVD6azA6WMCxC9hR
 iAhK7V84GQD1XmUwemdBfsI1CHcJF1JbfPnPj8tlosybDLeEhhTBr5aYNJ1YtOX_oiLlakh6tmI1
 sfK3hE5kWecSCSDXtxccN5c19Iap1D8I0hl.49TfI5cvONFwK8rgDSsAvfLpzGXwzBqmdl5CSLli
 gSjbekcYgkGJaW.1T36iJe4JV4hnPzDhAS1QP5hnvNNAxGiR2e.xPV74YCBF.qLdlu.aNrJbo_Zv
 PVEaXgV.7_eu7e9tBG5rq7AyBcdedSztRAp.i7ms2p_GGgm1H0WK6N0J1DgfwXcoSudDKNafPUkd
 JfJjIDi_E3thHUrs3PeX0rFVM2xxk4lAqJX7QvyokPf4Q539lzGUe.NQc6_o74ZZkTv4j9DHZuGu
 9S.Y9cvDNQHwa7afrsP7LDxcDAV7SjoRNHibcsRbPLbzbyXbR5lajhewJZ0wEKPSVpellJjahQei
 Mx.F6f_zqkL0mYypGbD2pwUzsebX3g8Ma_V05gnnO8DqE_AV7lrgd0dasRjUSwb73oJYXvmTaejI
 XAqsG3wOXjm5dfEHQ4IW.boX8LN3OPTf.Qh8fSRrnqB4oXdmSOFRKihuG.BGMvCj65cwAsLUQNSh
 YWzIbZ8Nwl.Xd2rqAvjj8ugvfROJUpTW1mBgHcjWyTWc3kMnrR5jVrPhHPzhMmDGfn9tFWPt9msG
 q3ATT7zYs5N6C5CE-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic303.consmr.mail.ir2.yahoo.com with HTTP; Tue, 15 Oct 2019 15:50:46 +0000
Received: by smtp403.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 1d86730668fa1297b8062182209c974e; 
 Tue, 15 Oct 2019 15:50:41 +0000 (UTC)
To: Li Guifu <bluce.liguifu@huawei.com>,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v3] erofs-utils: use cmpsgn(x,
 y) for standardized large value comparsion
Date: Tue, 15 Oct 2019 23:50:25 +0800
Message-Id: <20191015155025.13215-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <ef338ece-ea98-d4f9-18e3-db5d1e163995@gmail.com>
References: <ef338ece-ea98-d4f9-18e3-db5d1e163995@gmail.com>
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

Previously, roundup(bb->buffers.off % EROFS_BLKSIZ, alignsize)
+ incr + extrasize is an unsigned 64bit value and sgn(x) didn't
work properly. Fix it.

Fixes: b0ca535297b6 ("erofs-utils: support 64-bit internal buffer cache")
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
change since v2:
 - update an indention suggested by Guifu.

 include/erofs/defs.h | 5 +++--
 lib/cache.c          | 6 +++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/erofs/defs.h b/include/erofs/defs.h
index 15db4e3..d3c1156 100644
--- a/include/erofs/defs.h
+++ b/include/erofs/defs.h
@@ -136,9 +136,10 @@ typedef int64_t         s64;
 	type __max2 = (y);			\
 	__max1 > __max2 ? __max1: __max2; })
 
-#define sgn(x) ({		\
+#define cmpsgn(x, y) ({		\
 	typeof(x) _x = (x);	\
-(_x > 0) - (_x < 0); })
+	typeof(y) _y = (y);	\
+	(_x > _y) - (_x < _y); })
 
 #define ARRAY_SIZE(arr)	(sizeof(arr) / sizeof((arr)[0]))
 
diff --git a/lib/cache.c b/lib/cache.c
index 41d2d5d..e61b201 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -80,9 +80,9 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
 			   bool dryrun)
 {
 	const erofs_off_t alignedoffset = roundup(bb->buffers.off, alignsize);
-	const int oob = sgn(roundup(bb->buffers.off % EROFS_BLKSIZ,
-				    alignsize) + incr + extrasize -
-			    EROFS_BLKSIZ);
+	const int oob = cmpsgn(roundup(bb->buffers.off % EROFS_BLKSIZ,
+				       alignsize) + incr + extrasize,
+			       EROFS_BLKSIZ);
 	bool tailupdate = false;
 	erofs_blk_t blkaddr;
 
-- 
2.17.1

