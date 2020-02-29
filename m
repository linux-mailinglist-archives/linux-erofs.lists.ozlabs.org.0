Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id F12AB1744F4
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Feb 2020 05:51:52 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48TvBt3z6bzDrMh
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Feb 2020 15:51:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1582951910;
	bh=S/jYSiJvUyOmKm4xxOFTUQ+sdKyjiRYRdHscXh+KYno=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=JUJCELDXvzh8lhlR0XSkVxsTjAnhPBjURmxEPsRD3WgmsINWkAOH9JheNaW4yjWye
	 wLXaEUBEBKB92RzS4Mo+O1DspoR6mrtUUXVr5tt47ywKNkCExkrCaf4x+aRQEU5kwb
	 /SBYTtqfeNs7lUo8sSVtinv3bJH+0qPuDq02awgYE3+C7yhyqLhVdpWSEM3G2aWEv/
	 66vtJzeDlceawjkgsCNQ6BEcbi8/qvgNhsQamHvDLwCPafoIx9byWo66SP30pYBQvX
	 9whJkMXwtDwUESF5xIuDSHka/ICRXwa/2KO3Gfs1qeTlvXkT4ouu3q5gSGeT8nETL+
	 Il+TcpMous3pA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.84; helo=sonic306-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=AQF64KYg; dkim-atps=neutral
Received: from sonic306-21.consmr.mail.gq1.yahoo.com
 (sonic306-21.consmr.mail.gq1.yahoo.com [98.137.68.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48TvBb20QJzDr8v
 for <linux-erofs@lists.ozlabs.org>; Sat, 29 Feb 2020 15:51:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1582951891; bh=m0ZQ0U4hziZ5N+KLWz6WxvYyKbPjEuilDaDKmclVvfo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=AQF64KYgBSRf4ujTKYqRoGMcfPMyKUjn8LLn6ATVMsHCNluXQNUOoxEwLbb/4r4T5KrIH85ImN3hADBK1Clld3itoqAK+scMP32kRnWAgdNkTlFdkta498+bEPIsydEpFUVEPP6LblJa/AyBwg7P0DvdQxkWuHC0cQSudP0jh6s1lQ0gZfG2A13R0lIQrhvqX2YOSlNA8WCVZy6uO0sR+JP3JAvpGezWRLkRLf/zzQ9z99v9Hnt6WNxZxOYu738c1z21RjAA8NN3Eb7s2+AqQ3qvE1btzO7xd972w08k4iBJERloeQSq20EdAmP4OnXr0JssaaogpofEwkPCkD+y0A==
X-YMail-OSG: KDiUKc0VM1mc_UevR00ID5Lpv69pislrbkpJf7Cj2s8G15tbqFpT3tAuD9xb_YX
 bbRTJxwHfUs4SMzacLtM0URLH73ebOPoEy21aVDyy4h9vPwU55BIX3SB_5V76Lgt0RpLmzAYlHUC
 lQSlv0ckeHgMQjHDzUH5sugjQgWdClZywyggVR4_IVOU_HM0sqgRrOoFgytoRSwKdH.8LpT2rLHe
 8XK5jngrAXE69QQdGXfkCoXnfGP.vBA8EvldydlMDvr9_GqXkQeadRUCUhXGT4Mmm7ceav0YP7W7
 J3zHxlFzTQ3AtGotivdqRyM.ypz94.1JVhh9fcXctjkc15MqWMyZvkTm3VYQCSmAR5ptY_VSm0wL
 SsdHGO76dt4RRkQIdUWgEmz4JnF8P1.XFB_3A_MILQ.WisfGYAhhNmjJOtuiVxPTYWXKUVTEzoHe
 NrP1j6iqHqAfhhowiNnlWJx0OnTbyXVyTujeUGzFqxpJhVSXtDnGEy2H0sgD50weUznrcacp5TXJ
 iUd35E.esYh5LlW.T0eDcdWac8MXe.LTSPaAOfgxcg6VJbAY2bX3EC77a.pb4RxULFAYbwfH_4s3
 0vINEaR2FbVlcbDWBYLGm37uypB3.Q8iKiwtwf3SQFJ6kB8_aROCsJ2usTOL9ROX3K25NK7nvVGZ
 cNQlCv9ZBJVxhGS0YDJjbpCYSvTu3Pl0lzlunyfR_LEGQe0nLDHe.uUyqUganxj7VbACyBMF7SlG
 TM3S2qp_fIAuScttvaGfMGZ0wQ5O_w_Yaa.hCbm6kqBgFLPd61OaPFf4vxxKP51O41R0c0mxHdYi
 fSjUhGyqiM..a6GVNtB.9.CHhjcoqZnE4NiZI5Qmk3HRd22y57q08CxtWHjxzqufplA3eJUxuyRE
 DP4mpNPPttzXnPcTuBGQOOhb185hI_EnHnsYrzabyt0U50Gd6Rq0lzqrydlqrJVC2WK9coKDnPV7
 vijhp9k4hUOh4ky2aEH8au_.Np6AN0deTZ1Cs9bEZDa7_S0yJANjZ0ScaBV6A9WjIkWQkyXWNX1z
 gpW1PqBjRMggEQKBXx4_chxU1b9_qznZD799Cw8lTcqzEJgqeRJVthLNmAKzOLmhOSiL6.PPeLfD
 9OIaQiGwNMtYPxHkCCS1ZOyPTZUrwtD04LOnmzMbwuqipUXx0ulP1Ucokz4Fmg7bQFRpPrnJoiLV
 ndBKjO5.45mv3LgTTX3qd4wfJ4K7z76mOsTLnnS86IvNRF1PrJ8LTKhysjZi0iIkUG2tmqerNzeL
 9HtAFHrCQ6P2DE6vZAPKeF.w1G1nfuNm8d1dWWkZxNw2pWpitNKVcXZ4hvsbZN6t37scNyXKmFoi
 5jf3ufbeCpamtOXBidDveVY.AZPvA3UFpbmJwOOh8Ip0AYVeI2yqqLBC6k975je7AtSlODXcUoL.
 cRHp9s1RJXeS1IxVNPhxNXRyYDaPjdw--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic306.consmr.mail.gq1.yahoo.com with HTTP; Sat, 29 Feb 2020 04:51:31 +0000
Received: by smtp409.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 16922bddfd3cbd213433d5c12bb81660; 
 Sat, 29 Feb 2020 04:51:26 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v0.0-20200229 05/11] ez: lzma: add common header file
Date: Sat, 29 Feb 2020 12:50:11 +0800
Message-Id: <20200229045017.12424-6-hsiangkao@aol.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200229045017.12424-1-hsiangkao@aol.com>
References: <20200229045017.12424-1-hsiangkao@aol.com>
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

Note that meaningful names mentioned in LZMA implementation
keep in sync with LZMA SDK rather than XZ utils so that we
can follow latest offical LZMA SDK easily.

Apart from that, Linux kernel coding style is applied to
other parts of ez.

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 lzma/lzma_common.h | 59 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 lzma/lzma_common.h

diff --git a/lzma/lzma_common.h b/lzma/lzma_common.h
new file mode 100644
index 0000000..14df123
--- /dev/null
+++ b/lzma/lzma_common.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: Unlicense */
+/*
+ * ez/lzma/lzma_common.h - common definitions of LZMA encoder
+ *
+ * Copyright (C) 2019-2020 Gao Xiang <hsiangkao@aol.com>
+ *
+ * Authors: Igor Pavlov <http://7-zip.org/>
+ *          Gao Xiang <hsiangkao@aol.com>
+ */
+#ifndef __EZ_LZMA_LZMA_COMMON_H
+#define __EZ_LZMA_LZMA_COMMON_H
+
+#include <ez/defs.h>
+#include <ez/unaligned.h>
+
+/*
+ * LZMA Matchlength
+ */
+
+/* Minimum length of a match is two bytes. */
+#define kMatchMinLen	2
+
+/*
+ * Match length is encoded with 4, 5, or 10 bits.
+ *
+ * Length    Bits
+ *    2-9     4 = (Choice = 0) + 3 bits
+ *  10-17     5 = (Choice = 1) + (Choice2 = 0) + 3 bits
+ * 18-273    10 = (Choice = 1) + (Choice2 = 1) + 8 bits
+ */
+#define kLenNumLowBits		3
+#define kLenNumLowSymbols	(1 << kLenNumLowBits)
+#define kLenNumHighBits		8
+#define kLenNumHighSymbols	(1 << kLenNumHighBits)
+#define kLenNumSymbolsTotal	(kLenNumLowSymbols * 2 + kLenNumHighSymbols)
+
+/*
+ * Maximum length of a match is 273 which is a result
+ * of the encoding described above.
+ */
+#define kMatchMaxLen	(kMatchMinLen + kLenNumSymbolsTotal - 1)
+
+/*
+ * LZMA remembers the four most recent match distances.
+ * Reusing these distances tend to take less space than
+ * re-encoding the actual distance value.
+ */
+#define LZMA_NUM_REPS	4
+
+#define MARK_LIT ((uint32_t)-1)
+
+/*
+ * LZMA_REQUIRED_INPUT_MAX = number of required input bytes for worst case.
+ * Num bits = log2((2^11 / 31) ^ 22) + 26 < 134 + 26 = 160;
+ */
+#define LZMA_REQUIRED_INPUT_MAX 20
+
+#endif
+
-- 
2.20.1

