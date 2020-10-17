Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC85B290F05
	for <lists+linux-erofs@lfdr.de>; Sat, 17 Oct 2020 07:17:38 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CCrqz6JdGzDr1g
	for <lists+linux-erofs@lfdr.de>; Sat, 17 Oct 2020 16:17:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1602911855;
	bh=3sV0eTP5tbpS9dishP8+IXyCuI2hecuYRCe0GVlwHqs=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=PVWNZJiYtkZ1d/nQiiXnX6I35oymhzdr89AvuxdZlWfi6GjQA9+vul2TdTadZC8sc
	 DeVwlqvCZKcrftcSLdzHHJVBEl0JKn98XVfADAGa7UiDvo/fWcJ5vbQ9D+yL5yx7L7
	 yAC/1FmzH8o7aoedHFSBXeopPUgnVJUGCBVBr9k44juLopviNtCgWHkKots4FxyOl3
	 XlEkNCeyu7cmGx2XbSYoSC3EeDQX4wt3RswZOj1Y1/EYpQYanEndnGwTLOSdAYSVbY
	 nhaxXVj3Pllh6SDP7tvN3+aHeE4522TLvcNo5MbKiR2q9NIclZj/6h52g8AxCek6Or
	 q4U+RjYtYZTJw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.204; helo=sonic304-23.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=STfR8vCU; dkim-atps=neutral
Received: from sonic304-23.consmr.mail.gq1.yahoo.com
 (sonic304-23.consmr.mail.gq1.yahoo.com [98.137.68.204])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CCrqs5lBHzDr0Q
 for <linux-erofs@lists.ozlabs.org>; Sat, 17 Oct 2020 16:17:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1602911845; bh=+Ovifb6qZ76ReqLTX1rIvw9JsoQs76QwPVJrWGisxW8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=STfR8vCUWM0ib6pBJyFUFrESHH8zMgGj0nrq22VfBXKzuOLCNBhuL1lc7jvIRy8UMc8reDpIZ0uIH0kZSP4a6REHDdxOrkJ0u+7qyDZe1JiKYa0a3NeNeDF7gRopAXrbkQLWJqJYrldvxR+RgjdQHWI9314AlHHPTNbOnup3KzvsJyw9GHflitltXkmcGofc1SthOG1Cg+aUID99fY2TtT/OW8eMSigFgb+AKxx0Levw+elNQ1KZM6xd124JpA8Xpv7nqR3cgTNS+58FE+fUjY69ijuWanVpYzpLPdWmJsoJC4A8ywZDgjJ4xNahfvFf0FHeABklb5dzeBFgAXuoiA==
X-YMail-OSG: CEaD4JkVM1lB_BT3pdesHWYuXRckYL2Q0miqO_dZcAhwN_t0aqVRMooR4.C409f
 UPkfQzEcqP2zYhCQorxkajve0XhYWcdL3tl43jMw2Bf6IJxWxtlnasAzoPET_hK493VKPtlRNdch
 0KlrvosTbeLvuMAVamGYux.q09DYr2_hTHT8w2ymnhQUM_dha0owaQdSPOHpufZNE_lVpjGdMgko
 ywhq_4FJHzPkzxhw.knuHoHCm1a_EW1mnn0f8wE6nvHgfcYS28.Ww3QJhRn_m.FIR3DIUmcgjVXR
 qV9pbYK1xgJGkBeqLuc2mVGLI2_NWpNhUwbMJ6WLg2BMi_1jHL2OfZxOwzeNpL.DUPwZC0YZZToP
 w_0IV6KWyoBMh3ueSlesbCMpPsCTQF.eJnnFWxigNaZ0lpPGSR5p3MN5m0lYNXWoRXUiggxL5.Ez
 Ri0ldc2AArbCNuCfwNGRwGbGaiOAZrkEYyaWK_jZjHch7B2KfZ6mOQ2qkwKuN4bnh3Dg04SYC3mG
 dcaUsobSDGFQ0gB5WJF7x7YTPsKfdzDN.kmv8iBuFGv2yUJ3WKCCkLFGz6hxqd7z0ZHt2IuWnAkD
 LSeS.Y7E11LlU3X7P_7jIChBq25RwBPzNwW47eW49NS3MR5M.a1hjtod3TaRPweHgKa6AfyZLcUe
 OBnQOtAQddtHKIiz3lfbkC_LhrHLys7ZrPpcQY8964vFZHh8Um4gE7xqH1eBLTN1diAAsLVUXgn2
 YYr4RXxJsMkV.EAV0OifEjn2mYV2ZZ.StSl6TU52Zc59Pj2z_YRjjXiDhSbJcMZIrLHYuimIZwuM
 B7Wp9CMUw3E5Hu8dpKAh7hlMnDXR5RDPRO439FjCFPe3JIyVWPish28CCVLlXfjRRINiU0hOc.JN
 lMN.LPvjDdcWafDGM8QgKwc0PJZms1MYkSJCf9SwGTT7oZzByUA4m.X.MKJKK9CDkrxa7LzrWI.u
 uSEg.GWALuP5_lqvzsU5VbmtYQwJ_5w2GLzWdTQ62MyITZnD47tKlbVfRdHGlzO1YuXyDkFHAUNJ
 frhmpEvCyxJTgBAKrKDRx58cb2BxqwRKhrYnMVGkRlATBh8gFkBGRlMvQaP1uXg5gn4_ovhIBSNZ
 Cv0xv5gjq1TavlKQ2GrzFdmoA2rE9FCqtlL2rUtglWi8Cq7_kaXbmXoFPBPrzze0hlPVW_5K6QpB
 LtpHKNOqqHf5d.d5L_QSu857yAMCWqwUmkgfuqYPjzPwkBjUNZasrecO6z.qh3uJt1oIGvJucIop
 g.xWN93Mc6oYr.OveFeXv1T6hFFIq8bwg1SeGgahsZpky7oq8InoAVuYIgZKkRSUDCXjR4P9I7FY
 8_gIs0d.vgV6OXXvRL.g4JPTOoqH8Myr1w626E385KrlIwUyFRCVI1vRQYV1zuJzNxkmv9v4F_t1
 nCkdNNJFmSqJbtAGjZrei2uG5k2cHMXnhzsBn.CgaCKO57RKx5Zy58yRjb6BQnh17irqSst5yYm9
 0k5i1fR.cZ.SDTFB5aF.iRTDBobCER75s5_epFVlCkO5.FDPI84cV4J3cqYiZF4wLQCjAIuIMh_E
 tJ5uXs9o4Qg--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic304.consmr.mail.gq1.yahoo.com with HTTP; Sat, 17 Oct 2020 05:17:25 +0000
Received: by smtp424.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 9d3dc137a63e5241cc606f3cba181f35; 
 Sat, 17 Oct 2020 05:17:22 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH 04/12] erofs-utils: fuse: adjust larger extent handling
Date: Sat, 17 Oct 2020 13:16:13 +0800
Message-Id: <20201017051621.7810-5-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201017051621.7810-1-hsiangkao@aol.com>
References: <20201017051621.7810-1-hsiangkao@aol.com>
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
Cc: Zhang Shiming <zhangshiming@oppo.com>, Guo Weichao <guoweichao@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

so more easy to understand.

[ let's fold in to the original patch. ]
Cc: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 fuse/read.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fuse/read.c b/fuse/read.c
index 0d0e3b0fa468..dd44adaa1c40 100644
--- a/fuse/read.c
+++ b/fuse/read.c
@@ -112,12 +112,17 @@ size_t erofs_read_data_compression(struct erofs_vnode *vnode, char *buffer,
 						Z_EROFS_COMPRESSION_LZ4 :
 						Z_EROFS_COMPRESSION_SHIFTED;
 
-		if (end >= map.m_la + map.m_llen) {
-			count = map.m_llen;
-			partial = !(map.m_flags & EROFS_MAP_FULL_MAPPED);
-		} else {
+		/*
+		 * trim to the needed size if the returned extent is quite
+		 * larger than requested, and set up partial flag as well.
+		 */
+		if (end < map.m_la + map.m_llen) {
 			count = end - map.m_la;
 			partial = true;
+		} else {
+			ASSERT(end == map.m_la + map_m_llen);
+			count = map.m_llen;
+			partial = !(map.m_flags & EROFS_MAP_FULL_MAPPED);
 		}
 
 		if ((off_t)map.m_la < offset) {
-- 
2.24.0

