Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC12931B0F6
	for <lists+linux-erofs@lfdr.de>; Sun, 14 Feb 2021 16:36:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ddrtz3phPz30Gw
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Feb 2021 02:36:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1613317003;
	bh=qTA1/xGjLiSgvPbGDA92NOCYDW1I+kN93Qdif+YuG8g=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=hZZ5t3aAyv+NcCfam6vs+ms+erAaGhj8CQPE1irmRLVMen7Ow39ojJQEaB5ndse+8
	 rrE05pw+TRGmuhBizB297qAYkpoECYOcejMOWENHbqd2t3naLzDUswL1VbjtlSku3e
	 zDq0zm52urYVLYsP53zH8MkHHaOL0OhahSZ/C6AkqiMcO9jZQkkAPeMEYBzNl9j/gm
	 TzeYc223/jvD38GVHPOFcB9qD6D2Z96W9cq9Pnrbxlf5XKtOuuXnJmM4JTnZg/itJu
	 d9Qx1ziQ8By7x/oKB7AC8Dgwxw9NzfMNAX7coLmOW9lCZznxJ5sUGxatLbw0g65m5n
	 jnKe5Fu3wKE6w==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.30; helo=sonic315-54.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=iGn9D8vW; dkim-atps=neutral
Received: from sonic315-54.consmr.mail.gq1.yahoo.com
 (sonic315-54.consmr.mail.gq1.yahoo.com [98.137.65.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Ddrtx2N6Fz2yRy
 for <linux-erofs@lists.ozlabs.org>; Mon, 15 Feb 2021 02:36:40 +1100 (AEDT)
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1613316998; bh=8ziJuq1o8fGOl91jIMSPXpnYywn0aZ6zFai+nv8NhxB=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=S4njlGlUU23daV6Tn4/nitSLHmotUaztprLPECM5qg/2rGUnDXFOzSokNG2CAbeiP4fOGY39ptkuOE8XgBTeHbZgziHCTaI2iaKzU7WtGb2VmuCf5HGrpbMYVHySm1cbOXFDwnC/SCzfeB2z09MX0EpKbk6QzktTewS0GDatmWiD8fLSXUt42QuhEy4079N4d7wVhKTnqlQiw2i4W/815H8/i8T/hy1I07MwMK6GP4j5syNk0EN+VUFc0XrImTvcPrMHiLZu2dXIE83Z4V90R9GYV7lKKHnOpbyCJ4QAuKiuu872/K8AJ8cq82jQcEOSAm4/4nk3Z5y1GgIeeAJOiQ==
X-YMail-OSG: kjpaxfcVM1k8uXiGJYwMwt4.KCDiSSei32lT8Xd4GGqsZeUNVo1oUuZYKH8t8zx
 IrTJNzJmDhgwthWxGz5pO8HqzSW3VbO1KRunrrkzkulPEH2TMD2hnJ8aVTE5R0xJXbWiHOCNIEAC
 8cBnWlnTFuSZyhX6PCcvmNT66vdHHASDpS6CwCCcfeoSb56c5BZkQQ081LfWGRU7Y9WCaOWOcAuU
 bVtyH1bz3rqNpIyKN4KKdno6v0gqZ9rWgJruBJnr5H0W_gWW4YlK8001eQOi.5ZF3nyYgL6tZ_wl
 0ErTyav39OT9gsZ461sU3dwrdMZKqIkCcb2VjwnwW_DkAY1KHFCwTPISpOyyN3.KqiB5icziw_Bg
 yWPukl3RNCQabQlCOsf9FXUdsObfxru_1S_35GT5tnmBaGLfWA5rQXWPc6NHJhkoCSt06qUls30W
 QaHLqgcUEUte3OcDsWJNgCJgPL3qUiNBNighbzeg2MBhx14qTFFj4tnlJpe0tSfIjxEZq9SkudxJ
 FN9Gsgfn.MMyX.BMB5G.ci_aUVY0Las6mpZq.EcaQkEoMHgB0.aGXehS3WSvGPpiWz2MyynsvsoQ
 Bl4B1WFlFuvlfVbcRmB89cHSKq7x92E85TnEomeb5rqxWXomZPr5iGFAZ2BaJsQI_.D4Boj50b98
 hzdYxIenVdttPwTvCXnsFvDPNtIyBBQnfsUOU1PmDtpiuUx3o04jM.DP99Rq4UGr0O8L2b.tM61q
 GC3kHxropYmiJRZvbbcPjaffvTNUH5rmQ_mv7KiyIwKN8gr0XXndWRbGczcdBerSttChLsLvqaoX
 zO3L7k8ZueFF2q_smJ8ajeUm7VEBuZB4kaiLazV5Jx4I0G10T7iNSPR_2DJKYkcPE2kQSyDmjCvj
 YhIQAPMymWvMp_.TIJhdAmSGYHidFrof1X5ZXJeBmukR7TnJuk9XBbcbdAlGi4lIPdD7czHnY7PQ
 nKDdJgkvE_.ZLWWZQyXF.9vzAOdTHQ1odQweWSapE.vMvqCg0DxnQluELWBhpgqV1bLKlMVnMeEN
 8.De.on29s.p8Q9Frqk2pfWHUNkZc.b54bv8YvOLpu4Gi_W_xuOeEF3crNu5X8gV_PeW3Y69R5Z5
 7Ih5YhumucoEMONaBC6E.yRv7DaBoqJ7vd07VF.NIADvnrZX6InTfKgl0mVtP36xhOyBcdSKhtPx
 4n.9miHmLaS3rG1q5CddoOBrhXXvhJfLtW8KQpLyxAcbQpNyNx8eEreSIIuv4_QUgdM3M8s7jAPD
 mkiEGSuCldU4K2KRe61xO3Jyv0itdyNe_4DOGXHL3khxqLrW9YgS7sfgogeJst__3kXdvr2GCEJD
 bQ9RBSAfUJWbBODg5vk.21ETQ0S3i7oN1BdVWn3qNq4sn_hBNJskuGufAz5KA_d4.P._Y2_ma7yN
 x7YtKP3ystxlmoTsvCiRDP_m6rcXrWZ99vjDAy5EvwpJG_ax2x919j_gZJNumHd2PirQUbY9sHwh
 6dw4ti61611t4Mc3nMcXUHuaLJ9sq3m7iARj_qfZ9a_tzOCy9Liq.TREomqAYcOHZH9rx6GIfF7T
 .oZEiQN56WrsKMdDPsT9kuTgp0nJSnY.nV_mGpguCPhYGeNqT749enAitVQwqfF_XbU6Nk_.H9Rj
 73.gTttdj59JaUc5.KSYLl2lLQ085HszkNEotHO_TirRAJyJJzmgYniwZ_F85wS9m6M_2vmHkhvs
 iQga2F.FUjJ4Bo5xn0C8.8IG3TLmqSFGjQB8ObiILfVA1eeHsovHnXc3B0dAfz98pPOvEOn.S5uO
 eWmB2O7cr6CDxFrXIfTS2Y5hNsur4.7ZeZErd1rmw9Yqpywe9fUZX2ZR.dycPsPqsG3p33PWLsK7
 SovJLpXFHB2nFCalZXR9tvmXwMcyvbZi12hLqfpSjxfjR3B7eixPGQ_drO8gyjaSrDr5.jXFBbA4
 8Iskj0dyLI.Ia0BFI8EVBY7L1pIW41aZ9xOjYz85.0GXGH06KMdVJCTKXC0oSmAlEbsx_OO1x0gu
 q6s3nF7Wl3DqoKYq94yWnv_FiJNhDpk0l_uUU7c51HWIbZoLDEzNyvozhVnB3.AVTCN5uid8Muv1
 uIu3.Rq7GiIEoq2EhPBKxkK2dhRVugGucpHrqLw1pH8qS1fZ4wrUrmxOeWL1CHFjnCWHEwBXGAfj
 ergNajR_fIrpiWVVBcfX0dk8bIAriWHCmgqEAVqVHtsntJ5dpNZE.X7OEHsV2lRvz5Wd4cSkLfrY
 z_QN0ImbejFEebRRkUWv0Bhz1n.GbmWgKRrhGq6apTw6_Y3PDXLCWeiBdt6pBStKUGkNjunLqjhH
 THkSwA39rxww6TjdqNR6eCTPArY8vKnN2CTLO80CKAFcqjvLTCbw6QNswRq6MO8KdRB7F2mJPIBN
 3fAH9xXKwv10XNP93ma.5vu9nrkUSNG2E3vC84nJVTU0TDLthBAq3KRrX9CpAXmZNMcS_zE9ZiPL
 AjFf1y2FIrcEtuuAeRhclej9zGL3hMP1QLCzCYd9KyvcebvZV2m6XiwCMc1lntAyv
X-Sonic-MF: <hsiangkao@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic315.consmr.mail.gq1.yahoo.com with HTTP; Sun, 14 Feb 2021 15:36:38 +0000
Received: by smtp405.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 07898efad2b17f635251aa7d04958857; 
 Sun, 14 Feb 2021 15:36:35 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 2/2] erofs-utils: more sanity check for buffer allocation
 optimization
Date: Sun, 14 Feb 2021 23:35:49 +0800
Message-Id: <20210214153549.2454-2-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20210214153549.2454-1-hsiangkao@aol.com>
References: <20210214153549.2454-1-hsiangkao@aol.com>
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

From: Gao Xiang <hsiangkao@aol.com>

In case that new buffer allocation optimization logic is
potentially broken.

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
changes since v1:
 - add a more check "used_before != cur->buffers.off % EROFS_BLKSIZ"

 lib/cache.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/cache.c b/lib/cache.c
index 6ae2b202e67b..340dcdd76ce3 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -186,8 +186,14 @@ static int erofs_bfind_for_attach(int type, erofs_off_t size,
 				       mapped_list);
 
 		/* last mapped block can be expended, don't handle it here */
-		if (cur == last_mapped_block)
+		if (list_next_entry(cur, list)->blkaddr == NULL_ADDR) {
+			DBG_BUGON(cur != last_mapped_block);
 			continue;
+		}
+
+		DBG_BUGON(cur->type != type);
+		DBG_BUGON(cur->blkaddr == NULL_ADDR);
+		DBG_BUGON(used_before != cur->buffers.off % EROFS_BLKSIZ);
 
 		ret = __erofs_battach(cur, NULL, size, alignsize,
 				      required_ext + inline_ext, true);
-- 
2.24.0

