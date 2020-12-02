Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 917AD2CB9BA
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Dec 2020 10:54:25 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CmDp60TDCzDr3Z
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Dec 2020 20:54:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1606902862;
	bh=VTUrV/ZBaVn6GRZ4HcezvrwzTI/lefnzdlwENvxpjL8=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=A/CgNqPY47jAQlT64h+fGEsKPKJb1sX4x5mJ5MasjoPdgnGuXShwU8ERC4KA+Uf+9
	 U5gPais7lg8UwLWF8s0+DqCkm3gUuUJPZrjMSA+LTdYe3UJ2lqS4pEAaseBOcO9QvG
	 gJI4DxgDJvjCJlXr1GeA9f1M2WV/HHwVTLcLAc+wtiWDLT9y/riYGHyKoV252BXstN
	 9tR+owhw/qRx7x84ZxYRgpq3Yso8WZMRUCIp6u0m03pfN4Lpar4G4ZA0F//3T8couC
	 5R8Otgsv9CVbVBVynjZSaIf2FkEjmnNaLnEPIk9E16iyXphad1YmrmAUavqu/V+dUQ
	 4fKkbYd43mtag==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.32; helo=sonic315-8.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=eYxexSg/; dkim-atps=neutral
Received: from sonic315-8.consmr.mail.gq1.yahoo.com
 (sonic315-8.consmr.mail.gq1.yahoo.com [98.137.65.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CmDnv0BXMzDr2r
 for <linux-erofs@lists.ozlabs.org>; Wed,  2 Dec 2020 20:54:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1606902838; bh=D6kDA5aV1kzTixQSU9AIZHA/BVmUziTpSXosSScfkKo=;
 h=From:To:Cc:Subject:Date:References:From:Subject;
 b=eYxexSg/pCqNj4eZ7uD7mribLrBIztO99IQElAj9RZETvoIYxAXMlXJ5H7IYY8boZXcvh98crzcwYz+OCEPMK6pKwN6g+XrJF2A35YT4rtGRxv5o1oN+R5J1lfppUbm276WgCJ9vV57+ZWo0gglvgc5YQF24VTGE0VweMYuD+JzaULlNQQQ5jMJZKBVOeBwuQi7EIqp1lkPfBi2WBIlUhRS2yev7psDK44wQJI+kp4eG9D9XKSQQdvmTuLWBYLxuYeVjANMpZjkasRQGJFae0HRkaLtwbAWx381rOHIm/2olOACi7d4R9+eeNfvHVnrLxyBeFR5RRDtJDmMroURViA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1606902838; bh=KFbrvSUr4NMC8Lm2Roc8lN2/nv8gq7MQVqxUx4dDcfv=;
 h=From:To:Subject:Date:From:Subject;
 b=MVh34x+YoQItHJbQi8QD993RtlFHwTDFtRbBhxAdVyimus642E5ZFX4ryHdJB6r7SB+TfhK4DSycESS6g4q+6s9WHVydQxQwnIduncTdzcFdE3GgWdupGip0I17qhIAg+nArBrU08hIckVEZB3Sf4GGvPPKbUJqiQPNy/5C6km+azGvYWTEPzDwVefmGBSSEcjYosg9xyX9TV10UlPO8nFrGIrqLSeBm5mzTGk1B/xU7QkV51OQhgCRGJintJ4naEIj/UMc6gUdNE/Nw8/CZRhQiJ6S/CBN9B+yF+dWW5G5T839kZJc57kLXxXVB+bPiYoeTHudXyT+6ljMJujaaGw==
X-YMail-OSG: NaKjEDgVM1mlvUhYup12ncGYCk72BUYKULFVT0fl1pjV4nPdTc_Cm8U8DCcXNZt
 2GY0xeTZYp.HUKwjHPIbusoO1FbjkqQOLCQs6mxgXQ80OsgZm2RbLDh_e0qOnNyGlluqpsgx1ai8
 vCV8CkH2N3Dw3_nGeGlunqHytgNmDpliLk8pAr8S9RyBGlsY320XlR8T2SPg_L9BYuVYidx7QUqg
 oES_x.klmNOTfFVU7LtAnFttRkiFs_k2x5WkyIy7UuWFRUsOzFTOVE0DYj3d1L4kY3ibquCmfQrN
 bVXc4I3YQo95T5eOkhfg_8gMXVdvhQn.wpfvWPsUozhXJNiWh8RH2r9Q.m_funyzenIkXmlya4FL
 A1EFfKQt_NyljIEs9orDT8Cjj67.DWvw8tAH6K.oUKRJzUSJrGVgl.OhNx3VwVtvs94Msq.h7y4j
 ilf6gs71zQRNv.G6spXfVRyv34_rw1Cmt9nufXwP_aA4UwSCENGrj2neiIq1n2uXDZsPJ6hmxxAP
 9daq_Eeyy0pTcVhj76x8mlGnSnlymEWLA7hiz0DT8YXveSzVqs4rSwavdFYT2X21ok2VsSRS7Dxr
 Rj1yOT_GKxm.3BxEF0A.N27AFq2yz94gSlWDQAY_Rad_AX5wPh4By3jNTsnFvmnQxgZRuL_7xvOb
 YTRYYfCHe2xeHrcLLI2ENztBT35x0288iNwwwWvQz0BMADAWIVRlzBKUQyYzGlCu4d36svFLhvf9
 AeaVYapfIDW8t2.SVXvmiHfAcx9HGF_O5xaVpLL3XyFUq1TSN7ohS5DPdkFi.mFq2jmHgmRdaUgf
 PM5EXAhU3_ucBBnBl9vjW60rxGBkTNjdFCjOf_EaXmHbwkAnHw.6qebbXyO5yVfH9NrDliBH5Zd8
 fxIvX58wuJNkB0Vds5wL280wMSPlGS6yQLq724yuhvkFw2i44C2gH3J878VXPMSaPUHtkE9WoOAU
 UxF8OmSY6N3w99r.wMTYVN6oVqoHfLzEbenfRMyojtw_rKYezPSIDIbPj5G5gDu8Ne5dZI5OfFeg
 oFpW_AFA1kh_3JVoYxuzqftNk3o446zUV8TSdBKJiczsVey3BLmgR3c_Q9lgydVrXfWDlkm49eBV
 Wsn6SJ7GaD6HAI85boesO51MSI7XxQ0BeEJwIMBcYgJEr57I8IjSRwzscY_2SswkXVXFT1Cn1qzX
 Jkh4T8d2IP.6rLY6YewBpZFGNmfAG7DlRuYTO7DxyjEtzouQbpEZ_y55m2l0ikWOnj8gbD8wj6Za
 kK0YhbZ1ceIxVMGGbvS6GnQ.SGo9Hc2gZNG3JBgsHLNZsUw4kDP..EHdcWeQgIBiR6wkc8ODvk8l
 YeEBMN1_OMt2o8ptk_Eh6ergOi6wuIZolm6sZrlGYHADM1UHZ1nuZKZWimGkyo8EGpQeL4YXHeIG
 Ct6bMpAWF4OhPdmgqGucW.P7QomAd4B8ZAqr_xy59_vVpFoXXcc8xOCPJidGAGx.jquy6DXedLdm
 WJ9gJvqkwoak2XbfD8ZrXgbXn_H2l4Lg59iXZT2lLXG8TuKWkwwIyyYuKxy2_hz4gmnyhbotM3JJ
 wsexD0VYaJjIUStyp4eHL5xWvOkQ5gOiGEmu7vc.iDaRwBlfsLR2XM_9SVDfvNfZmjLh4RkuazYv
 .8WXkbv.IAwpDm8jcdOq_4Ia1w6_1qzTY837c3c5Aplu2M9uTjTgOe2IR9JFw4iGCNXyaKrXsLIe
 WjyfAglv2LjybDy83Au0CaV_u8gx5OlXiZM6yxFJ6XWW74Jg8.RLwOK6P5mZwqkfj8JVidsa0a5i
 yv0v4udQFp4wrx67xWy1oNOGujx1mg95EGRdWf2Wl5qN8.sn1aDZ7Z4nezQpr0sE9EY07NPOEmjL
 ZKOTrg.OI1LMZ3K6_hYsocbXaeK4_BmOA_RBOVNntF8QabGypGTxSv_Zv3.shUfnkKvVioMzotlm
 u2rrsVzkRm2xUFSOFDPXJtpYYXjk_b6Dwk3.jWLvj3vlbDXhyS.I12B9fThlwPJa0b5hlZBMvzef
 8qBMOA9DZ60nSewc0ZhV_EpsEMWKuhY.3qJCvsFzNYWAL4su7D6hMg8qhc58hs5dKiYhe.ArfpvV
 ah.tfTXufCW66ixNfwHGPKFriKQ.Sg0i3a_N7jcn5d27H.E74WKs3EN83BvCV3BRMAmed07E9Jgz
 6aiRLwY3vXP7haA2QeiuxSaHLkC1F9fHJykzCnHILGbAnX1RK_l3ZWH3OVFqDcNT..5Yr55bAqta
 dUCIKxKnwPRY2Q6eSgs2Dos9jBCZuN2zLPC7SVCegz.qmSV0Oxeq4q6yFsJIVgMRqYhmO_Z.X2_c
 T9CO7pgS5l2a9UpBL1w.HA.yG2gy1iH.CJAjc9bkz8RL4XIyp_Gf37vcPO.3n9_XtfSVKPDRg6rY
 mWQbYylqSr033ZGbt3tcrPR087afOFNx2RndBfmiz.cJXuez.lfuLdW470NvxXDsembXG12tF.m.
 zDe27PiyNWYKjAgHhVrk1ax0u3C2BiDwGucBjjKYmEM6YGd73wmhq.7jSPcrjt_E8C76kPJfh5u2
 DIZ0TwvLSnVJUFclv9Wk7xp5EvI1qc.LUoSY6HBkbZ4isFPsDT3tZYlG.7JS5S0GhhqgJ.77n1Z2
 IX8goa_75f4LpzP6q69PazeP0oTJObbFE
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic315.consmr.mail.gq1.yahoo.com with HTTP; Wed, 2 Dec 2020 09:53:58 +0000
Received: by smtp409.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 093915b198cd35a57b68a434f9458e55; 
 Wed, 02 Dec 2020 09:53:54 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: update .gitignore
Date: Wed,  2 Dec 2020 17:53:45 +0800
Message-Id: <20201202095345.10485-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20201202095345.10485-1-hsiangkao.ref@aol.com>
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

Add more extensions to .gitignore.

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 .gitignore | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/.gitignore b/.gitignore
index 3a39a1e82e55..8bdd50518074 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,11 +1,16 @@
 .*
 *~
+*.[ao]
 *.diff
-*.o
 *.la
-*.a
+*.lo
+*.mod.c
+*.orig
 *.patch
 *.rej
+*.so
+*.so.dbg
+*.tar.*
 
 #
 # Generated files
-- 
2.24.0

