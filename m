Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8820297C8C
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Oct 2020 15:11:58 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CJM231kFczDqwV
	for <lists+linux-erofs@lfdr.de>; Sun, 25 Oct 2020 00:11:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1603545115;
	bh=tToSXo+bblRc/MlyKzSXVboUDcmOUzHPD/7Bm+pJmpY=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=i9UiRR8l/Siuguq+2MQWi8nJkvJzrIFmHqr/mMsTWeIy9boxhxGxByJstTiE6Hmao
	 mf+hYCrV74Z0+EWGuZwrz68nMJv61XUswmiWEz8ws4f1+GJz1vstskAAdSETjaYBAN
	 A/5UV5qqgFFFv3LpvijW/T2L7zBTqFnnkunn/TGic56HhRFpBFxM01uCb+QzHFOtCD
	 aqZ0dEQvhJ1tnqXUDeX9lrgIKFqtjNggtcdwFuS1fS7Ntv5FgzpVIef/foNMnbGfN7
	 CMZpP8pTl/7LWYhxGXJQFinamUu6VU/WwAZysrwj8o+bADBWYor25B1Go79P4xhj8w
	 CNlhRBVpv1jCw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.64.147; helo=sonic301-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=VGQV4OAs; dkim-atps=neutral
Received: from sonic301-21.consmr.mail.gq1.yahoo.com
 (sonic301-21.consmr.mail.gq1.yahoo.com [98.137.64.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CJM0w0yv1zDqwC
 for <linux-erofs@lists.ozlabs.org>; Sun, 25 Oct 2020 00:10:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1603545053; bh=yNgDG+O+lLtaSEY82ZORluWi+rh+Qwyaz4ldmgtL30o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=VGQV4OAsl/4RENPlkQ9+bgk55d+LZ+f67GL70CFlGZP7NQvFslmPHXry352QBMAVLPfL3GF0tCIyXQFCKB67ZVYm24qZZe4+R2j4SRRbpkeyOUqyskyDcjIddWlrvCfsrD6FLSd8sDB8572k3mi1Zs147PkWkcg/pFMoycIX3jT/zrAv5s2XC31nyKlSaIutYZ56k9sJsCRba03ElhSgw+6b2AV8hiqV+3CX7AlNk5KC6UTzJHAyl2BL3Qu905zHHchi+NOgGfPlgXqyV9gKlRCQptu2qzyHP7gG29smnBDb+5ojJ23zfsLzc3rLXuI6hkR/hTskm7hIUuoe3F9img==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1603545053; bh=gSmMEuCW6xZCLQ9jwWRnDLPSLjw11r4nNpGWS7roARU=;
 h=From:To:Subject:Date;
 b=jvhOHXoyXEOGz96Hk9+25RRKIylPjybGzq4pimvXf7RJljINcXEIT7HuCN+6o57SnRW7tiDxvm+albiXxuOpPSXO/Tqy7t7XP0wz6k6qwGQrnfobX52ASIHxMfpacZ0DM2jLbhJjhO2O1j1riUIAOdD39uV37AcS/fv/YamshpS9+HSjzLNihUVRFn9CT/HkwokulQpZmIdEJr2d0Jy8eUznzamd1mCIMgKOc0DIPfSitehwSb0wiwvZxZciEN4dtjrBi4Lr2jvbiZ+Y8BkYBN7pWp4nbJVgBH5VeJwYu9fzUWLAa8vDM0fEqfzmCoUjJZPCitGO4NS2vc29M982Cw==
X-YMail-OSG: ILhgw6sVM1lFa3TgItrhjF1nlt35YHB.kXEex9lY7Fz.jfbqbGqivjf.f_r3GWR
 Jp2LUC0Wolk70ZVgVi8Bm6.IEs8w5eeU7Bo2TAKAK_kHRVvsrjcO7TrLgiNv2qmYdUtSsNKdQsYa
 36gDiGOVcihqVTY0TPpNKnM4mYTFkA3J178fmoFKVPhmBtG7dNcKupqs_1mwosbEhuZxnLtRLy6e
 Dm.mdzyH8SZ2EavmIZGIopgMczIXSO3oJLECxswngpWzXgNSNlp7bi2w7bp46BZMs9RCIW3kMYm6
 FSKujNRUOQ7nrEwVbPHEQHZd7azVva2Zxz2G8uYyuEcJ52K.0AsKW0LFD1IOK1PnEHonlR37YpOj
 dK.TSGbRVJFlva8hoUmh4syhLsplWWxWh0AnZafKXZN56BZDafdGB5tOlPqKZ6rV7mPQsgfRXPP6
 XLZP81vF4F.inFcwJ1hdshfDx_UWxH6frcBAQ9c21rollXzpW_SLGGotvcc5uEZ7UiHBbo72uRn7
 s745AxazM.oDIIve7kNUzhlSmKwEHtKGfKYLNwSWG5hKA.KmevE58OmrysxDqSnFeF6UWvrNp1B5
 ejMfGqKTKzznN_NVgbQxW.R4OUqjGrJC.fuDl4GFnLHoGtwOQsG7tJvwxh4RowFj4h4iBamzGzgx
 K.k5G.MAnJMHlOM5GQUnpBq3ZYDLns07.11UXVOL7xMWGI0T6.sG3wCEolARwU7ZPPqgnb1yf1GN
 8KJInneKzX4ApWZUIfTyEusOyMQCxLPNO4BAquGXaQFrGNCty15ilNL0eToES1QSt.0HvQ945vVg
 UTd48_YDs2vzxXImC1qrnPqML1SYjepyXkFuAxYabI97m4pUknF5XBWjwIXPOxyyvJQHGwAolQK1
 YkzsvHFl2nANrLPjBlocOjLznXuth324QGFOYp7OJtNh3Q9YLAbp1vTHdTgCZiMrYBZExyOa9t3k
 TTW3im4vLiRhZqmbIv81h8D7LIlw1FxgYdkMG0jnGLT34HBbLRSA8Fw5WLgKdIQq.e9F.n2LqUBy
 cXeW2lZs55yCMYh_vjI._i9XuvFIPgE1uO7qbYrTwFtS8hEYFO74EnlvWwFfpbJJi1H4rbgeVZBK
 sHeac59qnVztoxEt6fPNRtTX4ngYJVr60A67yurdtVO1_fdVba69Qiywn6HR4_bGYVmVGcbVRPJ4
 ybpXNhdHmtFvOPnWr2f.mY2gTe8TbkyrUA9ozC7TSzrkFMQUa9WEbyH72baWolCjgo.bba4WIkNA
 QDAeJqge.YElx76TBj055okXCqcrvZ.aGBmC_XFXKb_wElKj8pbzVSK4r0ZvNOeDM4CRb9yRuDhh
 G.aS6_zom2jVtqf1qRSUSCQ4qovbSyqzSY.q23zGcXYF1s6uR5PSXrOeBWiRiYJzD0TcaHbHcTAy
 9g_R1TAxEO7b3ZMXRTELEjrqev67s9k38Svj.fTWnmnCC2EZsStqwGyzZw77774IxVC8NtCAfShD
 CaJLvvKkn5T3aQUgPBQAvOr4T0EHZFBcR2fQ2JQgNauRe3wya5h2iNdB7UIfG7i.SCjPDDqiQ5CH
 jlL3RVeAdcMNA8c_ovTMDHgiZZTJKI9nHC9tHoYzRvyg1wx4rxo3M5iP3wbXvKRJuzJUvnrfWPex
 wSTsd.RqOm_e6ygubJrYiOvDZSG5xVQWsVeqDJVWZy6GqLYPcoODsP0X1hfGzFR7B_iGES6heLj2
 3RIL2XvWuPUnSn62scyFZzAbZqRWEj42c1EM_L9cL3v9PL3DKjFxqvwFzfZjWdXaxtzwc8WSUvZ4
 H_fS3U8AwigUMNx_xDhoZNI82.8fDVtgffsVcAvzIaM2nd0jdFrJwwO2Wvx1hIsSSwiBW89QyiA_
 LJEx.q7p0OZJ_E0AUzNYRMmTvrwvdzGZUm5s.JiFIi4fsjlNDPXbqT7Izam3ughtsG652Tv4q4Ci
 Jn395UfmVOKRtURFZUGvU8aLvCk0lPH3Vj8IIWQFW8S27K6I_HzyqrRFkTC_wSqF_rAPnWDpUHPm
 znp3.2cRJmYYzh02QzUAlTGP9qiNOOcUZd0lTWhTpXa34e73XCQ5hjKQs4ZQ9AfI2OEwWLef7EmM
 aEG_LoiV4xpkjke4ReCCmo7OTOOkIkflDI6iV1VggRUuxSTEPNyKYLRzw7CFSHK1NGv3CLsk32TS
 qbB7Tf8cZFhfXa9ooU6rHS4xDEKbfsOy72AWL3LWQjmBGJsxkMufmcNS5.Vd6YGd4tx2R_iYwDh0
 SAKoG7wG4dNP.fk.yhUGD94M.5PdzZbJNZ0hsgjPZKm.wuH_W2g3MqP3q_3ZKkRfv3G8BRQQMn0K
 3r9ihJsSuz2xHRjLsXzEbhwjwjz9kspel_cSya1qSVWgERo7PsMKjpKRX03eCLbQdMbBQx8Jo.dk
 xKliVZaG9xDTHRcMPdl1S_VH9ntxRiBVt.lQnpNX2PWkzhr_MefhLtp66FqqWkZi3Sp2uqq94_d4
 K4b4l8E98MNHN71t1WzZG4ChbqNxKA3U1aX8aFl65KNWPnnrmXRQicEAojOdSaSAJHneNQLPLCHA
 hNneqpYxfMydRrS4lWVblYf3hXBJ5op1lacZYWC6t5pc_RUBDKWiCR5Sp2e8CuDU5TRlmKC0KoLN
 9SLifuFQD81zADk1oecGXL.xzvJlahAqDopIofO_UZ1x0zwFKSmgoN1eV1zVGUXlxl2IHPoWd016
 IfLKP2N.cveACg8r0efdzbAOu8ms1Q5PzG2oL9.XVtJZ_nbYp8MTCSglXY19ef68SNcYcZr7UuCO
 Tw_CxWnIU0LJjl46gx3fYW8cwO9Ws0_nnkfNBUhnz2FpYzV3aVpMlmUiC_6vk44q6PxK2lYHJ2MP
 nkEDD0HhAdQ7ezpVJEp4S_F0VxYlwGbdK2gFwmcHM.C2.9VtmSuX5qMHuYCz35lbANq4_gTum2sH
 Dqktn1V2lRa26p6jUG1Bf4wd1vQS6nscc4PNNZWKk1gEEqXu1lh7Es0tFvIPRDao-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic301.consmr.mail.gq1.yahoo.com with HTTP; Sat, 24 Oct 2020 13:10:53 +0000
Received: by smtp419.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID afd45167a3858f59b7d63d6cfac9db14; 
 Sat, 24 Oct 2020 13:10:49 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v2 4/5] erofs-utils: fuse: drop "-Wextra" and
 "-Wno-implicit-fallthrough"
Date: Sat, 24 Oct 2020 21:09:58 +0800
Message-Id: <20201024130959.23720-5-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201024130959.23720-1-hsiangkao@aol.com>
References: <20201024130959.23720-1-hsiangkao@aol.com>
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

[ will be folded to the original patch. ]

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 fuse/Makefile.am | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fuse/Makefile.am b/fuse/Makefile.am
index 052c7163dff7..a50d2c4d0ab3 100644
--- a/fuse/Makefile.am
+++ b/fuse/Makefile.am
@@ -7,8 +7,7 @@ erofsfuse_SOURCES = main.c dentry.c getattr.c logging.c namei.c read.c disk_io.c
 if ENABLE_LZ4
 erofsfuse_SOURCES += decompress.c
 endif
-erofsfuse_CFLAGS = -Wall -Werror -Wextra \
-                   -Wno-implicit-fallthrough \
+erofsfuse_CFLAGS = -Wall -Werror \
                    -I$(top_srcdir)/include \
                    $(shell pkg-config fuse --cflags) \
                    -DFUSE_USE_VERSION=26 \
-- 
2.24.0

