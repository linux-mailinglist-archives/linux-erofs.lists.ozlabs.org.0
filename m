Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 45554290F0C
	for <lists+linux-erofs@lfdr.de>; Sat, 17 Oct 2020 07:18:59 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CCrsX5BhnzDr09
	for <lists+linux-erofs@lfdr.de>; Sat, 17 Oct 2020 16:18:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1602911936;
	bh=pdrkd9SvL6QL1K7UERsxSvrotCGshfCG3A/0T7ZWvyg=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=eNI6nR/jZd4HdvAxfV9AE21RFBGNfP1XWHdaLlJvjk6/oMMj4xbDfFCXb9w5wi5Eu
	 2XPhdWOazG+Ot+32rWnJQ/7pGgdAVxz+7XyQIdhl1quSKF6zpTSbD/QFrCNMRrW5zh
	 +bQ4naZ6qsmJdh7o42U9MZt0kksV8miAvOtZP7xrnsTu/Hs/JBlUbZl0H5PC5AA/OG
	 G9x+JP03qXFPi7huYsCEk1o6EXPR9YJr/JRSuq1WSs9MVh7onROBNCu6mGylvAMgw4
	 11VvB81Qlfeos51+xLkF6t2Lrm+7Eh5vtXyNBpb6ZlnBJllVve5eDlyU6x+SGFp9Nd
	 Ynrl0nZd5M7HQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.64.82; helo=sonic305-19.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=NQG7og/z; dkim-atps=neutral
Received: from sonic305-19.consmr.mail.gq1.yahoo.com
 (sonic305-19.consmr.mail.gq1.yahoo.com [98.137.64.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CCrsS0cgXzDqHj
 for <linux-erofs@lists.ozlabs.org>; Sat, 17 Oct 2020 16:18:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1602911928; bh=A5W/4rIKBXbMDY1tVPetcvuNFVYvSMDcMbuQFs/LO4A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=NQG7og/zFldYRk8l9m4HnRMtoUryZjyskRY2hBRyOngKj8Lr912vvDAv+D7S83vvNVAFR0E79Aek7ztiWJIfp4W9UopC+Tbo+nNRdxEi3WpjV1t/AD376BLlIGIMermtIalz/mgJKg2D4rXG+VN8l6+YjVHhsTOtQKjzB+iTZ3rtNGYVoXlMxiKfBi9DpH/chycSVKgs7HZsCnGLdTMtnjPUOPGWWUwk2F03pIhTgl1AanF4aDBs3jnbYZUPv/zIDSxfVxTjGZluvYoTplxfp+5hNir6sHCuInqezZQPWHTFFxyQbN/DLopN8gMBDG3kI2ZC/dBKIh5phYhZs/Ad0A==
X-YMail-OSG: Dl.hRCgVM1lQnK.dxwWeyz_1I03zSeicZgGpkSFZQ18muAUbHZPRdir1ya6lnUY
 mB1PG5iyB2._WBY9YAnMDO8sZsQqiiHBz5twNfO1YoDuFmBEhW3Qbrf63VQ__a4_CJphozjd4W8f
 FN9FRkt8ULmwZET5PaA6m9txvnFzn7vu2OJ_q_pqV.eDRsuPP.gupgDz2dCwe8BZtDPy38QLFuWE
 x7bZWYXRk9nPLbwTjuWN9hHaA_Uqp.IAuYbXjvBwr.mVj_amzDPFUYedY_Jlh5A0VjT8yhsGmoQD
 r3.psYzrC36nBf._y4f4I06FDRqXJ42bV4ved6HPu6oCvGM7Ms6Zzh2pqbV88uqvazNgNiGYRwIL
 xW_MQjaz3sHI6AH.FhSwiyjnv1otsRhasNI.dt.r9b1JcbbY0nydBQ6J8Mj9_mmbQICmmMtghe3X
 W_K3SCGkbl36HtrCrbQBrmBMTblrYMXA2UN4tdGBqzKsgXhtnpUCnOjqkfleG.uUbW7UryLz4GBH
 rt1FiECO8UVLF8qBsm229JD8LYMiG6VDZMD07rWKoL0rcrsB6alVWNj8bvZZNbO2oSNG9Ofs80QT
 hNMkMrgIobEeviUdMZCv_F.xV.UnMbT5YXL3gErj2cp7WLb5rtUoAYeKgfGOS0BvyF8KXCLuCHCt
 ebwe.u4gBV4xvf3uuOHZzZiM1x_ql4Hy5lruADNzKmSxKFyTF04FUbhq_U3qXAnmWpOShKNd8R2p
 c8jFGJcc9lYp6ODzNrhJhRTq7MNyxCcSLa9Atdiuw2r2Gi9QVa1J0BfC7hL.gNLNTD9OmozUBiTx
 mWycL8lY6OUHN3zCaV5AMh56rh.5DOq2qfdQuHD26oZpiDR9eXtGMpCamxipoN2j.R4Fh7IRtUce
 OqCEjcnGcQFdzHkPbyGQBpyA1dTQhXRD19uz5P3kzwIUykP.23Oh47DSy9KGg0Xk5wmrLMHzxkzY
 CjVQYdrlMETbBkO4knAqLhkk.Rx1JjnHqh9Iu8sgTE5XCEGNoCP9K8iB3SKdzJv0fuQb5TdNDnVn
 mvNjHPghe_W3eJEYnMwxyyLX9LRk4l39mzocrlyK4.CPujJySaHJdmMJTPX8KoMovlEAuW0fH.mw
 EoJyckvwAo6to.8maHaNxIQkB5kfc.8EwTZYHHaik6qiFv0DdK_xoLCv.Wa3R6nmxhsaeutf4DKZ
 eGGu78Mnfgfb1DI2wPBJzO0BvfQkLoaC9VKJbmV4bQ6gLDHhJ9Vr8XqguPSgwYeLzcdJuvcZVmWJ
 yZFBayAiiVuGBg_TesyM4xMEUC.M9Fr3TnQL6CO1iRuTsyF790nGWRtQxRdjsnu4SnF454xj5ZPM
 rLsWq.WencIzDEHqsg8ooVqs5e6Pxzba0LYkfpBHaWFQz7e8ss2m6w5w7LW.agLTNmm5cI_vZnQ2
 YABMsvqOaCJlB3HDAOoJm6Jrg9yL.EPXQKs4Eily_DHJZEiqV7Tx_bmGhWqRigxBT2rclJ0gQSS_
 Yc2u2n6gJtu5DgGK0GpY_XtlWjeK22C5sVF8kHU7rjKpnqYhGCrqhYeYopA--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic305.consmr.mail.gq1.yahoo.com with HTTP; Sat, 17 Oct 2020 05:18:48 +0000
Received: by smtp424.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 9d3dc137a63e5241cc606f3cba181f35; 
 Sat, 17 Oct 2020 05:18:41 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH 11/12] erofs-utils: fuse: move up mpage in struct
 erofs_map_blocks
Date: Sat, 17 Oct 2020 13:16:20 +0800
Message-Id: <20201017051621.7810-12-hsiangkao@aol.com>
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

[ let's fold in to the original patch. ]
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 include/erofs/internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 5807b67637c8..1637b6749411 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -232,12 +232,12 @@ enum {
 #define EROFS_MAP_FULL_MAPPED	(1 << BH_FullMapped)
 
 struct erofs_map_blocks {
+	char mpage[EROFS_BLKSIZ];
+
 	erofs_off_t m_pa, m_la;
 	u64 m_plen, m_llen;
 
 	unsigned int m_flags;
-
-	char mpage[EROFS_BLKSIZ];
 	erofs_blk_t index;
 };
 
-- 
2.24.0

