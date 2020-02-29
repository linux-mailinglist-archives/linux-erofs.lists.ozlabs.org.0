Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 947901744F1
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Feb 2020 05:51:33 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48TvBW01VbzDr7K
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Feb 2020 15:51:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1582951891;
	bh=kFhxv1iEaw++syNVlayg2o7KDL3AZXNBWfatPIbnwew=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=DhD2i6yx/4Cb2NuajdXv43HEPzhSW39ty024rOovR8Vy+UuWLA3bjQ+U7P39DCEir
	 mnEZPvbxbQAFInyj3ti5/oE9hmY30GqmIL5nxVsHNQfXsp9M/b0yM3jODJZOWQewCF
	 Wtc8MWG/xdmYMkX4xTusqXnM0PjtG+M88nut1NLOnBYuE2pfNKcxEcNdyLX4bkP8g7
	 Xq4XWU4vREu34cEG+Pr5kPg1wnXkkBx6zX1v4lNdxBz9WEmqZnm0TuzNt2HFpXxGoo
	 OjrlNX5DNKvb31MQ8X4NjWO3eDqn6mPn/wqwV6PCr6DKHOjubLwP7cd/yZ9lf9vaJ7
	 KaK6mEgRnLKvw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.32; helo=sonic308-8.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=Imz7LbiO; dkim-atps=neutral
Received: from sonic308-8.consmr.mail.gq1.yahoo.com
 (sonic308-8.consmr.mail.gq1.yahoo.com [98.137.68.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48TvBH2YRRzDr8L
 for <linux-erofs@lists.ozlabs.org>; Sat, 29 Feb 2020 15:51:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1582951876; bh=+d22eBcmUKi8d57R9/Zm2tw5hTeqacs9127tsXMQ198=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=Imz7LbiOntg+S41yAZ5CFIALw06xGc91gOrmvwRYBdHlDj3d/X5GxdJhUaZilA91BjnGCVo5nwJazgR9cuM1+rQmCcLIagl6w2+F0hkOs3QF8b1IZINV8okv6+se12SCTFkfSWOfSfdWkD5aCIOTHSNajvNuGyS0Tci9JNY9Gf5RBEmZgZzBLUcAt1LCQAzI0kaC+YtGFMKH3WA+EiZatI3HuRSwnXur458ERZCiWTbNdrQCKjddmva9+9PPqTvnYkgW9O5jG7bQBykj2QYdBYj3mhHAHF5v7WfKYjFpqPQBRCNScXnr4x1CQkzr35Mt0HAyCbyE/kqx/6lSb7oXOw==
X-YMail-OSG: 1R38dL0VM1nz171kBt4pbw6qLVmnKr9t4x_XKm1s7z8C9b9VNvb6WgUOQXDEJYn
 r1YTHEoCG2LYA_VbCLjNx5t.dFJjdO5F1V0G2yPBvT796wBRwimKAFItkhfVkVmXMmSX_wjbLTKn
 cOSJMIbGvhWFIOeiCk7LIIG1BxJDkzs8CF28EHPDMPqwGRYycst._1wpe0p0FzMmksEgZkdUWN4Y
 mS5iCBZF86G8CJUJdjSH_tsbqCTdezzoCGBRtMRt5h4PQOzo4pEf7o_taHnZTsXJBm2pRQ1gAQNp
 CuaSBcDWZQcmRxUk1xcVP4QZuXLaeF8LH6wGR34kIqW5E3WrNHhU0B9ANuEHgUK5mUXomZJTnh_Z
 xDxrHbq9w6g1ay6L_.FPEIK1UT_s3VE_5XeCbllG8pDN4LUtUQC1qxbbFX0dCMn0bw5h6O0xtJLd
 D4SvX1KQIBgrsmxb_de.bOdXj6bnuT0EH5g32psuraq4o0z2sn3IUZonuD2TpQ6YvRZVRPs18nI7
 SbUztLFRnUC3MVDW_bk158czvEUUJa6_EOjIwI5bpg.gBQxtEPJJ.dEne7d4yWCSjW_s90vKDYHu
 rA3WJmOBxKBx6bV1wUcBdOQQaHjXMxs_scRTfOPaceCtwlVP2uogto6coWpHVqM7Hep_mCRFidca
 H_PP3xJ46ptjlXmoF..xP6cg0Vya4ItaRTepYcgpX172me4LmDiZOyktKZaFxyQ69ih33kUU.PjV
 HIsVoQWExyoEjecGnztHeJUxqCEFXVhVUkMZNUCKrALtehhjYIl3qsr6Zpp7OSCWlkmVc0JRD9XU
 Uwavb8oYuLP_siKWYmvRK8Yf2aarwm7DcwkKERGhnYHhRt5Xnh68jhSSErddq6A6_OfNGB4Y1tgu
 4H2EppBFMr42oXtOlvoT9sdESXTwn.Hh43Wmw9.n.W0JpmsxcONPa5G6Y._gJz5ZZpMsaeAnjMG8
 414zsZS6Xkl4t47ms12c_ZHR864OdKDU0IeMjaMKPoVtotfQxJrajlAAdSLmi85g6vwryln_Cv5T
 nASa0YXKBkENGafcPli.hN7NMMNq8OZg93x.Fjv_imJTpZDgbdAqh65UPxJH23qkskc5pjuXod7C
 9ITpuj_7kyoCiO2UT2GYFKRGwabckgkltQT3SPGH02227BY3RToh612p0DrVszt_GFvdCtQdJ7Tg
 pXPH18sns_6ELJ2_CFoTmibPTvEaRbX9WlByJx_S3_VpXWaV_1gb_ONc0PquLnuGEHjOJae9JSsc
 9kjlmva2OZ5ET4Ct3f6VrXMbA80lZ.PvRPiZw_gv78QVGbILqYNmyYP0OaWTA5D4P3uLeXCGWryI
 Oxe84GQfGJc_O7X7T.jwWFa1_Rpq9C86kFN4_RLN8Q8LC.gQeCOUvKVHHBMoqOT0-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic308.consmr.mail.gq1.yahoo.com with HTTP; Sat, 29 Feb 2020 04:51:16 +0000
Received: by smtp409.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 16922bddfd3cbd213433d5c12bb81660; 
 Sat, 29 Feb 2020 04:51:11 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v0.0-20200229 02/11] ez: add helpers for unaligned
 accesses
Date: Sat, 29 Feb 2020 12:50:08 +0800
Message-Id: <20200229045017.12424-3-hsiangkao@aol.com>
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

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 include/ez/unaligned.h | 55 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 include/ez/unaligned.h

diff --git a/include/ez/unaligned.h b/include/ez/unaligned.h
new file mode 100644
index 0000000..f7c7f4f
--- /dev/null
+++ b/include/ez/unaligned.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: Apache-2.0 */
+/*
+ * ez/include/ez/unaligned.h
+ *
+ * Copyright (C) 2019 Gao Xiang <hsiangkao@aol.com>
+ */
+#ifndef __EZ_UNALIGNED_H
+#define __EZ_UNALIGNED_H
+
+#include <stdint.h>
+
+/*
+ * __pack instructions are safer, but compiler specific, hence potentially
+ * problematic for some compilers (workable on gcc, clang).
+ */
+static inline uint16_t get_unaligned16(const void *ptr)
+{
+	const struct { uint16_t v; } __attribute__((packed)) *unalign = ptr;
+
+	return unalign->v;
+}
+
+static inline uint32_t get_unaligned32(const void *ptr)
+{
+	const struct { uint32_t v; } __attribute__((packed)) *unalign = ptr;
+
+	return unalign->v;
+}
+
+static inline unsigned int __is_little_endian(void)
+{
+#ifdef __LITTLE_ENDIAN
+	return 1;
+#elif defined(__BIG_ENDIAN)
+	return 0;
+#else
+	/* don't use static : performance detrimental */
+	const union { uint32_t u; uint8_t c[4]; } one = { 1 };
+
+	return one.c[0];
+#endif
+}
+
+static inline uint32_t get_unaligned_le32(const void *ptr)
+{
+	if (!__is_little_endian()) {
+		const uint8_t *p = (const uint8_t *)ptr;
+
+		return p[0] | (p[1] << 8) | (p[2] << 16) | (p[3] << 24);
+	}
+	return get_unaligned32(ptr);
+}
+
+#endif
+
-- 
2.20.1

