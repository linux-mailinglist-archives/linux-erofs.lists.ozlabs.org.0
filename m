Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB3A185574
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Mar 2020 11:53:30 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48ffYg2xpSzDqSC
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Mar 2020 21:53:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1584183207;
	bh=8gKvKc7cDDA/8t/gp/bRSxQPHsnGnwyfKyYOS/m6S/g=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=PgC+HnfZ5ir9H0PqjVeluu5Ll3AspiE9GhsExqpKAeypHvGmB0agX3cMYYxzvwv47
	 7sqOKGPrtvG3YFbZ68PUvlfaIq4EBSumYSjn+QiasCVdaH+fSz6bTCmBfMya5/7XUY
	 7gV7YcYSyyfVF0GLHOqRIxU3DUla2H2QSg40YDG2GPu2X/AN5zhjHtAmI+pHhLRegx
	 P9Z4IPVUstiR/orlcQoOeFUKJ3WB6IemLvRp1c2rDZKCd0P4C6+BLalFp36pAWK94g
	 Z60Vi6WFzL/iyQDEAAo3jwxyTcyGEdFfY9h5kBSvgCpnFtnfmndc3RdyEAA7c8YPbj
	 oay7hxaqaeVBA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.147; helo=sonic302-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=CAf262KZ; dkim-atps=neutral
Received: from sonic302-21.consmr.mail.gq1.yahoo.com
 (sonic302-21.consmr.mail.gq1.yahoo.com [98.137.68.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48ffYR6HHqzDqQh
 for <linux-erofs@lists.ozlabs.org>; Sat, 14 Mar 2020 21:53:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1584183188; bh=GEHz7AUkFbWFkOnPe0ftXnISX9UlZJ5azhdzvU8OpbM=;
 h=From:To:Cc:Subject:Date:References:From:Subject;
 b=CAf262KZEqGY1B1Kb+vBP3Z7iR9jRO+GSBWUPRkDuGmMf9/vk2a9TEuMa4e7EMdADy7e31vO8V+nD8TAjBlmt2afItDDlBtrv61bj4p7LUzX/oDR1TAyZdaO4EH5Zb9KC9XLBcJHsv7/L1d3YdcU46RRsB4eyHxpySL9JhMJfYfwhBqdpMwhDWLjfc6f8lMAEAYdUr7mK4jZamMBQ7A7LICvQP6W21U7uq0mPe5CGh44WUjhE1LFHBSd7e+fO9zQXoF9J6ZZN2oXLllQ6CqpsGk67vphEAl9+fl0lbvoWPEGDHspdGOsNetBbEcOcepnouLbRvHtAIZk4wDRoF8ppA==
X-YMail-OSG: hpP9CIIVM1lXC8oUA4GCstLdKyds9Yp9L3vueFXQmNh0kdYDM1CrnMlDK2MIBUA
 DZX2sx_O90vK7LtcVPJnKpKZYPWNU_MmpxDB.S1jGZLNUO7AO4qm7krGtPSg3uR3pMQc_uw5xX0c
 PmhhZgLV2C61Yw_rZHf3oej8s3e_bb0CqsWVP1K8UHwOKEgl_WUXbWMstN0TQUFUcemCPJSvejpX
 6IhBWvzaed2cSLxsV21nEDlKBjPwJayDA7JeHcKauSANYQUNTuPe8kwSBvaeHBBQL8BBHeeneBYC
 I3kqGhCs7zB_W.uUE9QkKIbd9FNdUshSqS6ikfClV1o8C2uAr_rdXt3A3I9VFrUMd9ezGhP4hyy6
 V_wculPFYH0Mr3ll61CVKx.LeNwvdeJb1tmEm5rAM3bqe8cEd25tvVMt85U6KWWmU7qVEILdEpWc
 8etghJajcNcdUuBsu0g5PBRMcNleVkcNklB8gXkTqwiAQxhJV.9t9pPayjMDFnTerxZHUbd023EY
 kK2X3vfrgup0EUg0JLI3_Oc70UCtsO97XZg7CIVCQwDyB2E_ZyZc97vo9qylXmyXzsMl1eFAV0W0
 vn5UNkQOESQY2cKzwKUVf3GkC3ZInEPIDj8eNr45neyNfbrrmfopzUdL6lxqKvi.faHv.JYyF4iv
 qJlmz6s.hzkk2.u3IV9Hjk3gUzjaXHqz27ENK3BrhDzlSydvEP71fOSXn8nky.phosjQKfRJuR3w
 DQeecFQC48aZoJeSjMvPv5XyIJeZhgsZBjxXDd2NrcNjHIJijgkxCLFQy5FF_.rz9_1_K5bw9UeL
 2jWKtkAN620Phh5.gw41FljoQeY79vZgkqML7ZUHmzPT2Cvt4moSOl4nC0Nacnh8Vo_NGEJvQTLo
 Fu2.lk7g916pGN7VrcEMWxwfKtLQRfxIiDbUuUR..sTofXM0GKgdOT_9G_Kuebd3Wr19LdHpU3Lh
 WSgqrPxHWz_m9jPZxL0DDhA4MdjSLssRjLRNTk40kHPGCvUI3iHxCyF9r9atrN9Obkb5H_cHQg0e
 K0RbjiZa6zdcw9G2o.9Y20q9_zxIZ.d5RYSy3a.FbXdk1nocMAl5KX_fqcgx_44jNkqqUPtyQRUp
 gck7DNKMOC6n7tlqj71qqslNpvwDTj4aw8wFR_m1DfdOXZmL2c4PM38MKr5MEjMDf7Omdn6WHSWs
 Y8I6kryTO5VFnvvL57Q3vYCQZfzkFFRnTAX0D5Q9cMQ.5PkkL8Eo3UuaPieV9E_a0YOBgy34DHg7
 61z.GjgniIfNkCuy7ru5G07BLRysSOBBEuewBUFnBO.5KVGfy5eGgfUBVv1NaMaAf4XrCmxvN7kt
 BCGhRtXIAtOaQnHu7UOQX1J13vna5M3OBusHCuF0ShcRJQqEkYzKoBkH07KRPt6cKHIug1kLT
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic302.consmr.mail.gq1.yahoo.com with HTTP; Sat, 14 Mar 2020 10:53:08 +0000
Received: by smtp419.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID c5b344f71318df663ff10803014dc754; 
 Sat, 14 Mar 2020 10:53:07 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org, Li Guifu <bluce.liguifu@huawei.com>,
 Li GuiFu <bluce.lee@aliyun.com>
Subject: [PATCH] erofs-utils: avoid _LARGEFILE64_SOURCE and _GNU_SOURCE
 redefinition
Date: Sat, 14 Mar 2020 18:52:56 +0800
Message-Id: <20200314105256.20142-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20200314105256.20142-1-hsiangkao.ref@aol.com>
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

This patch can be used to resolve the following build errors:

compress.c:10: error: "_LARGEFILE64_SOURCE" redefined [-Werror]
 #define _LARGEFILE64_SOURCE

<command-line>: note: this is the location of the previous definition

io.c:9: error: "_LARGEFILE64_SOURCE" redefined [-Werror]
 #define _LARGEFILE64_SOURCE

<command-line>: note: this is the location of the previous definition

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 lib/compress.c | 2 ++
 lib/io.c       | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/lib/compress.c b/lib/compress.c
index 8337487..b14ff17 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -7,7 +7,9 @@
  * Created by Miao Xie <miaoxie@huawei.com>
  * with heavy changes by Gao Xiang <gaoxiang25@huawei.com>
  */
+#ifndef _LARGEFILE64_SOURCE
 #define _LARGEFILE64_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <unistd.h>
diff --git a/lib/io.c b/lib/io.c
index 52f9424..5b998d8 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -6,8 +6,12 @@
  *             http://www.huawei.com/
  * Created by Li Guifu <bluce.liguifu@huawei.com>
  */
+#ifndef _LARGEFILE64_SOURCE
 #define _LARGEFILE64_SOURCE
+#endif
+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <sys/stat.h>
 #include <sys/ioctl.h>
 #include "erofs/io.h"
-- 
2.20.1

