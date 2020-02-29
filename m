Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B77001744F2
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Feb 2020 05:51:39 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48TvBc6CmRzDqLY
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Feb 2020 15:51:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1582951896;
	bh=0M+5c2tuy9NQ0G8+JzgIO1j0+TFjRGa1MdzHysnEZUo=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=UuLKLv20aG+viBub+f8qUCpcdLPASILZzgst8FfEpxhYqLedqHtZelJ2AICZRCRfP
	 uL62rVpY93hpTeS9CCWXxE5o0lip8e9jmKzCiRnM1Wa1d2lQTRyCcSDy02Qc66XH5s
	 3zCi6OoVh7fg1F4mo1joPwPll3NEAmCJH5J/46gi/RNEDjhnNs+Wrgt9Id+rnf/tfK
	 QezHlcaFpvZgDXgOqyDGkIsN2Y7IKBCdykMLYKGMNeB/eIwjys/eMZPHwWnzpZL80q
	 R4xSJuQ2kcOnctXbnx1rwvmAJMMwyIjm7fdaGgEl6t3cfOIV7FSFHclBMdG50L6eKy
	 UiziRDW7cYE0Q==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.64.204; helo=sonic303-23.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=tSOlzAYt; dkim-atps=neutral
Received: from sonic303-23.consmr.mail.gq1.yahoo.com
 (sonic303-23.consmr.mail.gq1.yahoo.com [98.137.64.204])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48TvBJ1Y3jzDrCT
 for <linux-erofs@lists.ozlabs.org>; Sat, 29 Feb 2020 15:51:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1582951877; bh=kYl+oV5/x8BtBva2HFVvmixgyGqYjXD2vo7nMfW46qY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=tSOlzAYtpPe3fxJybxbisnP5L8bBAHJwbCwUeD8gjRPkHlt4cfiFzNGVjTL/rKj+Qg5FA/ifGM8N60IqEoeFUI6efq5um0Nel62ku613K+ulA2vxyocHOPjfHkdmCxBu+oobGuB0fhP1tVzk3r6h2CseYZeuJaQeHc+zISNgIYLz3cjPAN2KBicSZ6mnGX6fOBnCeBgSmOvvKq+G3U40hu/dbqYkBRY7SDp4avJfsUJbKczwIovI8bML7kDeYkkAxAh1kScPiCM6/QShIEBWhJy3mHWIccqB5RQ8PMrTUulNH/ViB4Ikyb3ou2JI6UkE3NNUOo87KnCNpImgvgm1hA==
X-YMail-OSG: 3GQI8osVM1nRyyCIcYm9KH7ZVLdoeauEV6yrGXxNWm7BDqcAINoTpAR0lsOlXvG
 1aZTrtZkIS5fetGmEhZXXosVcWviSDLLHgzNiZut8oVwwg8eIWlnrjhHVUk_UwqWL8FPZeP2LOiQ
 Cc3amPX6faWIf5hMseGi1.AFVYxfphFnj5KC1oYq0gMX8Iwk8xRs2SX3FbtinAguNDxYB6KZqdIA
 IR5D8Y4osMW6WRagL3XzRSvTp_3Qrz9nLozgIuco9sr6CI7C.6ZoTkaev8hlSLKIdcTWXosLxs1Z
 nXeavbWEpGafiPcEDkJw50_rO7KC67sjsvqSg2T0EjKbXfTnKsxDG3OAa.M8fn8N1v48LKBDqE_y
 12sIpcTdfST5z9f3suqyi9QO.s2cM1Yty0bJmunTr1XEg_EDFv1S6VLjyx.aE4_HCjwhdpQkqZpT
 lDh8EkX6ZtCYDrkfmZrctmxUnNGmetOEi8E5qhCL82mR9ZnszhyMO8HK37sMCG5jt7k2tcJGZeLC
 hEPN9Sx2vv_YXHXrXaM5HG.jA.STK.20w3o9W.GkbCs35mTE7qNeNqE6MOEsn8P6xYMqbrxmreJw
 FSFYp9Q72qN1BX5le2vExMiOR970puF6ThwNoJ2Jj7HL6f9UwU0HeWfg.xlgGIWC.DYwhrHGq8yI
 U12nEveDtzMnnRyErUZRJEzBD5hVV7eJiFqwhJ44Ehn3mf.q9YwXohjCFeWzwA3I6TFvg1kMzBAU
 pfSSZqaI8YDVnIkIni7oLz_8ejZLpWS0DJC8pYMBwpUVYbsl6yD_de0A5pdc51UIPQLbiEwuRk74
 a8mtloNqqZ5beo8kXZ2vcrUs2AMUjyixF9CqUmROI023KCy0s54IdRnfZEqmOZqQZtQ8dUPMKDan
 _CEcBufsLYUJ1QDG3h4D7oqbwECm3_2Hlv2RHO9zSgHw2KsjilXEhh4VDSbfHLaminordX3Q2QM0
 tVsEtSYsAt1a8FRjuvoaagLCGXJTgK3tnCCuUcEZMAUJhw18JaF.ZZqsYpYO38aDw0Wtb.Cys00y
 frTdIbg.fm7Jq_AAMKB_W25QDK63uezTaqZPsRb.oiGisTF8nxrQbJ_JBRLMOXb1UsFGVoLFii3K
 wAQnCgPb_gS1nga_lIUaTkY6Z0_P4orRz1citJ_YXYe5u_NKgNkpo._Ip4bbnAxgWOI9vvS1irDW
 pARHCpRgL7s2V6y7htJtG2WK2YQGvb8Acp24Te6NQpfnOlaEye6Rv_J6kXPPIrTvP9xXsD.PWwhv
 qdEpg7kNTqtvNljr1BysV6jcmg4VRss.Wm6v5fLnxejAWlvrERHOyz6bfnZWhhN85ZrVEIUFMWLm
 SYKv_cK51dZvP.AedXaDVNisV_Y2A1EoG.SGErLfsCz3FhrALtcNMnYaM3ePTd.7NoO_RPS3lUec
 CEyFxWz96gBd8GB.u_bK.EYQZ
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic303.consmr.mail.gq1.yahoo.com with HTTP; Sat, 29 Feb 2020 04:51:17 +0000
Received: by smtp409.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 16922bddfd3cbd213433d5c12bb81660; 
 Sat, 29 Feb 2020 04:51:15 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v0.0-20200229 03/11] ez: introduce bitops header file
Date: Sat, 29 Feb 2020 12:50:09 +0800
Message-Id: <20200229045017.12424-4-hsiangkao@aol.com>
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

Currently it's used to find most significant set bit.

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 include/ez/bitops.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 include/ez/bitops.h

diff --git a/include/ez/bitops.h b/include/ez/bitops.h
new file mode 100644
index 0000000..5d8858e
--- /dev/null
+++ b/include/ez/bitops.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: Apache-2.0 */
+/*
+ * ez/include/ez/bitops.h
+ *
+ * Copyright (C) 2020 Gao Xiang <hsiangkao@aol.com>
+ */
+#ifndef __EZ_BITOPS_H
+#define __EZ_BITOPS_H
+
+/**
+ * fls - find last (most-significant) bit set
+ * @x: the word to search
+ *
+ * This is defined the same way as ffs.
+ * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
+ */
+static inline int fls(unsigned int x)
+{
+	return x ? sizeof(x) * 8 - __builtin_clz(x) : 0;
+}
+
+#endif
+
-- 
2.20.1

