Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 774FA30095B
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jan 2021 18:12:58 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DMm6b5Jx0zDrph
	for <lists+linux-erofs@lfdr.de>; Sat, 23 Jan 2021 04:12:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1611335575;
	bh=/hsMVykSfG+JdD++NYU3F7+GUxTEj3QRJ+4TJOOiQE8=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=KADBAOoKiNaGACC9F3OpXGIDQJQnmxl+Q40sDyzjwfsVZjEQb7vpi82E2LEOcCAg0
	 fynRarZlLhOeAgEPD4on74YUsFjm7Jtxb5rmCJDFY7XS/EPE6ETQBIBetebWTk8h/0
	 t3MN/sw+P3ja2jRPOZvNheNKxGAAwfEDXUx8KLAxiRnz1cfyHbtqqU/RrOyg6b9IsG
	 0SRJ1jo1mN7tzonqVvGIWfeyqpnoHOocgBORFvsmz+9wDEzZaGfW0f/v8yeBzxNiJ9
	 IXzw9EAsHowsDIz6iztbw9P1VnbZo6A4Yk74hG5+lg2yJDmaf4t+7r+kRXsMZpyHul
	 Fi5hOQoqaCGfw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.66.146; helo=sonic317-20.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=dA+wp7pq; dkim-atps=neutral
Received: from sonic317-20.consmr.mail.gq1.yahoo.com
 (sonic317-20.consmr.mail.gq1.yahoo.com [98.137.66.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DMm660QJqzDrnp
 for <linux-erofs@lists.ozlabs.org>; Sat, 23 Jan 2021 04:12:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1611335543; bh=YOmZR1kLxPBA8Jsxx0RKVmHIfJ06yEoV1SzEPRobr/M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=dA+wp7pqu5RZ3gbGBe2FUdyOFefeSxO40rUY0xRC6yQry+fuoT3yiL/TeQFRjj5jP+XJla/w9ypvjaGDsNcgHIh6+InWCYbtTDwXLErqqktbBtw5XZ4wlgpyMQz7/4+zfJnkSnaqvzQ2XFmkrTVmrV21Q2O3HzWd/koJ5jIrbhBXYHjlxLZ7C+CNhuPpz2ZkceCutBOsESGa/Wd/RgLu+vKnNjNiSkRqDCrFmGFMB8mJ70MwhbLkfRX6+oAhfbQ7iqMRBzlOOQpnmRmpWVPwJRQktYurBgomLO3jzvS+/ndz3rWeJ9XjTPfx+Dgkt9Y8lfBpI9nz9UJx297nuWNxxQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1611335543; bh=sF+AGWc6Fy/yZTzp2cs4UFf67BefSqqaKcKwMxEkLT9=;
 h=From:To:Subject:Date:From:Subject:Reply-To;
 b=EkfFhlmEfKzlzgmsv2hftuR+jYLLH/dA+qVqSk7JyPi7NUYVOCWHml91go62lk343GS9Xjizdv6SO+4GaVnP1kwDk+wEEltMor0gpTWzKLYsOKvcnA0AHCdf2OfoaygChgBQAeLT03HDUSGNu0G1lWv0RWruVRh4u2eN3nFOcuwRwyvtUf7vl7R2jo3zybcCJnbqutOZ/pYm4XNfiCHM55mFGCZs/OvRW/+AKdnWLsNbVNYUPDF/+iBK5POUKjp5bwUw2lZqWaA15JaFa+CQ05pxCAtEWwLnZHQSUG6zXR+TXfURK2/GoPqsBnL2PvlmdBzWwOpB2viGkGxt1iQ6Lg==
X-YMail-OSG: 89YNmuMVM1nkd9X9PmfvCwwbvwLaHhjj3_7B.oVnUd4OkffuDMTriAFxGFZ3L9J
 KqgbfurpvBmL9XdQ5IkBJRbW_gf9M77h01l0B7oBJTUk6lGVbA9y6yLXA6VBfUM0eiwOX776Hu5y
 .qzkjCKLVs2sU1g2B_1ehVOK8G7aX87vs6ASH7NdU9jq4eEIooPExVlf8D3VjgF5rBw44W.FDFft
 nAyGHtR8LwrRgg6PgL.FwO60eI1l7AbKfaB8CL6SEPlIqhDnXki07jiNZcBa97Fm_IatrOrluL5g
 d_p6F5BOQ95856DQBYv1L4he3lwtlQdz6_l6XZUmxgJfdVD14o7T4v62rEKORlWW9Ovt7Y5LiN3X
 icABUoBSpFRe6qZCExWetbblayLFhGpXnaw5GbxNS61URo7YaWAlIzDZIv_G4dQT7DcGKMiQLnWc
 K8wikO7wtU.oxVM2Fu2rfVxU06UpuBzD0zZqjaM4xme4vmDZcyYuC0qgMJP7epOYB_uYYe5Wweox
 uNuCH2ijjZjyt1aS6O6Xj3YCNZX.BbdNnEtZuVW97HvXa_aRRo0pJHFH2vLpZdPFiIhesfv7651O
 2gRQUCzFnoxZqPCwSlvyD_MU5FG.sbB_OYkudgJwA5ImivQuQ1Icl7dZhbKZuHhLHwPpOjq.oNYv
 jwqwZidcXoThwYmjYorFeTq0m9fA4aIIKIu8rAnmWLkdjFUN3iC95QTfmCNK9fcEyPPm3Cu5Tjbx
 GkC.M3n_txuvzMI71z.a2R4wW4sLCAqOM7cqBBqkPtCqZ1.hI7r_j58zuDET4LBpb9XM3PaODRef
 pdEFI6HypZJ4HbdjO3Xj8aonHH43bKMQbKIX_1tf..jq99E10Qost4xMed_YyqfCvNHNM6oYIVxZ
 LLrdty.8sZ0xhy69lAbr1sAdSK43pdlYluRb4_CG9rHuxIS7rR0utDX91wRRYMIR81F3BjlXkFxg
 GYoKpUx7fte48lAoK945.vgGajNdyr6Mkg3SofDA6.XHDxqni3dgedlHkV27bfKf15AGShBu_xxw
 QHAbzkwSFbU9VR1XpAGXljGao6jQuvUxP0ROqaeYS6U8FVP__VugC6nFzc3WPkGAxajcoIFqNedj
 FtBkboB917iL0n.o40U2RwaupQNbguiGUEq1UGByIcgGx6BvCXWtpVzauFIQFNm7qI9f7NLqEUY1
 CWsntXbpS3dx3EXzZOejNpBkWBYtIC6tSwp51HbyypHRnHweQTT.z3aAEmwOIMBZW1u.20aE0UNl
 a.K8UrVkpSpxQKV5Lb9SGumvOkdydwu13jfVVu2HUpzvh53HxfQDWuenNPoDjHnc2Fk210GZen97
 j89qfPLxkGGKaFfgw0jcXV6tuB8C9Rd4kkLLYJnLlCtyZNe5IRTKGdTJjWinz2aCkj6RRgVBsbK6
 653qRCIe9BLNYMZ_osVcAB4MiDiJXpH0NI0EDusDeAbTJ349QKg.DflFIAQ_1hS1fqR.vtmRPrHs
 ZM66951hcgF6lMy18Bwv51jfJ9HouYGXKixL73Uw40Bxuw2DwCEMoUYD.wR5OCyL3ev2wcYPphoA
 7YMDbuSH8Xq1CN6YyzuV4xOdmnKx9mTSOcqKbRx7CkzvKpWaHBVyWXexnVw4ondGoj_H6GEosH2a
 jx7nntvVbspFZwO6lCYHe7r9MtAKyshoFuLEx8RfV.pZIHWU6_1aehTq6Bv2ddGmi5oPALVoEQJU
 zADw3e_eSH3cIiJdkWRsn5.xfitzzXRefPMflbVG4O2rHbk9AX6O_uXm8XIU2c_mqDMHuG_YqwHL
 7VhJuUMOlkzEQBF7MaBFNAVKhstWHj4w6PjgizLfHSgEflra_ZGbo85Q4zl4XUXgB08VHodJpTya
 p_deuErR_spf9ss6ZxIRY9S_3T41YXNIoX16ltV.kB9bQzypIIrrmWMAb5zibZJNVpt9feDpnsFZ
 gjqMr.HLpavp.u8dkr5Sty6WJgoC_kj8MaOwmMqkuHFIgeStILPwRmesyxymEYiSeM5cPpIZIk2t
 GPn.kH.jgaTTMJyijEMowezn8Sz46HvC7Qg716O0QZo9VZFJmO8NvA48PIqO5KaL0Uj.3Qu7pIUJ
 EMf.O8gFszSO8LsRPIVuRGeFPP923.dRKBNjN9wsCdSRpjdjmgKodpYiw.LSDak9jdqyzGGCJOvZ
 PjCZ7iMuOF.HqupjQEH5XH8CPu4p2.g45Vp5GDlL.guXYoA76GslSe0mY83cim_InU0MD8sy9tyq
 JtW1pa8LcpZPEekJuKLKRTYXe74o6iVu0AtBdi8mSCw50YyDXsvQ110OLkEGo7Utiv.t_R.c1ytB
 0kLEFrIR.ykUJ7Y7uTsayhc2E2C4yfwVy5AghCfJ1eMZwDruNfA_nbL9WAvp0pSE3fUKLfTrZq95
 ya_iYq0JM8pLd3C.AOCbzu9kdedfwjcqRv31M8vLPaew4v33SreDiGysoZ0Vwg1x9AogpS9g5X2_
 OL3OTq_vQOv5wK.Z1t7acdutU.orSXEAfbfntdM4d1uTsnRNxDfa7y__e_liOVpM-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic317.consmr.mail.gq1.yahoo.com with HTTP; Fri, 22 Jan 2021 17:12:23 +0000
Received: by smtp414.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 421cb1d2e6456159bc18db7d03d7fd0e; 
 Fri, 22 Jan 2021 17:12:17 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v7 2/3] erofs-utils: introduce erofs_bfind_for_attach()
Date: Sat, 23 Jan 2021 01:11:52 +0800
Message-Id: <20210122171153.27404-3-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20210122171153.27404-1-hsiangkao@aol.com>
References: <20210122171153.27404-1-hsiangkao@aol.com>
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

Seperate erofs_balloc() to make the logic more clearer.

Cc: Hu Weiwen <sehuww@mail.scut.edu.cn>
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 lib/cache.c | 81 +++++++++++++++++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 31 deletions(-)

diff --git a/lib/cache.c b/lib/cache.c
index 32a58311f563..f02413d0f887 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -125,25 +125,25 @@ int erofs_bh_balloon(struct erofs_buffer_head *bh, erofs_off_t incr)
 	return __erofs_battach(bb, NULL, incr, 1, 0, false);
 }
 
-struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
-				       unsigned int required_ext,
-				       unsigned int inline_ext)
+static int erofs_bfind_for_attach(int type, erofs_off_t size,
+				  unsigned int required_ext,
+				  unsigned int inline_ext,
+				  unsigned int alignsize,
+				  struct erofs_buffer_block **bbp)
 {
 	struct erofs_buffer_block *cur, *bb;
-	struct erofs_buffer_head *bh;
-	unsigned int alignsize, used0, usedmax;
-
-	int ret = get_alignsize(type, &type);
-
-	if (ret < 0)
-		return ERR_PTR(ret);
-	alignsize = ret;
+	unsigned int used0, usedmax;
 
 	used0 = (size + required_ext) % EROFS_BLKSIZ + inline_ext;
+	/* inline data should be in the same fs block */
+	if (used0 > EROFS_BLKSIZ)
+		return -ENOSPC;
+
 	usedmax = 0;
 	bb = NULL;
 
 	list_for_each_entry(cur, &blkh.list, list) {
+		int ret;
 		unsigned int used_before, used;
 
 		used_before = cur->buffers.off % EROFS_BLKSIZ;
@@ -179,34 +179,53 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
 			usedmax = used;
 		}
 	}
+	*bbp = bb;
+	return 0;
+}
+
+struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
+				       unsigned int required_ext,
+				       unsigned int inline_ext)
+{
+	struct erofs_buffer_block *bb;
+	struct erofs_buffer_head *bh;
+	unsigned int alignsize;
+
+	int ret = get_alignsize(type, &type);
+
+	if (ret < 0)
+		return ERR_PTR(ret);
+	alignsize = ret;
+
+	/* try to find if we could reuse an allocated buffer block */
+	ret = erofs_bfind_for_attach(type, size, required_ext, inline_ext,
+				     alignsize, &bb);
+	if (ret)
+		return ERR_PTR(ret);
 
 	if (bb) {
 		bh = malloc(sizeof(struct erofs_buffer_head));
 		if (!bh)
 			return ERR_PTR(-ENOMEM);
-		goto found;
-	}
-
-	/* allocate a new buffer block */
-	if (used0 > EROFS_BLKSIZ)
-		return ERR_PTR(-ENOSPC);
-
-	bb = malloc(sizeof(struct erofs_buffer_block));
-	if (!bb)
-		return ERR_PTR(-ENOMEM);
+	} else {
+		/* get a new buffer block instead */
+		bb = malloc(sizeof(struct erofs_buffer_block));
+		if (!bb)
+			return ERR_PTR(-ENOMEM);
 
-	bb->type = type;
-	bb->blkaddr = NULL_ADDR;
-	bb->buffers.off = 0;
-	init_list_head(&bb->buffers.list);
-	list_add_tail(&bb->list, &blkh.list);
+		bb->type = type;
+		bb->blkaddr = NULL_ADDR;
+		bb->buffers.off = 0;
+		init_list_head(&bb->buffers.list);
+		list_add_tail(&bb->list, &blkh.list);
 
-	bh = malloc(sizeof(struct erofs_buffer_head));
-	if (!bh) {
-		free(bb);
-		return ERR_PTR(-ENOMEM);
+		bh = malloc(sizeof(struct erofs_buffer_head));
+		if (!bh) {
+			free(bb);
+			return ERR_PTR(-ENOMEM);
+		}
 	}
-found:
+
 	ret = __erofs_battach(bb, bh, size, alignsize,
 			      required_ext + inline_ext, false);
 	if (ret < 0)
-- 
2.24.0

