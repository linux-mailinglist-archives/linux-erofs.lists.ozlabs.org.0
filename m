Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A63542F9442
	for <lists+linux-erofs@lfdr.de>; Sun, 17 Jan 2021 18:47:19 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DJj6X6WHlzDrcV
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Jan 2021 04:47:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1610905636;
	bh=rABAsJL3OQtodozVGPTBRT78gCHlsERFR5+BlS9/vuw=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=asG+iRZ/412xF16TleSnyle67afynJmyFGkox+YYvJRIJI9rUQEpZ8KNx4TO73hdq
	 7molY2UhnDnFbp3exfY17e6Ddhljb45ocsigHvs7Hf/WCYw0DiexEFAUxS0PQvP7wB
	 hDbBuF25sTeb8ZCYnAh/dgvs1thJ++EFqK4JXq8cRbGZYMuIFgqpFZVtP0+EmvlzCc
	 1PRjH+SMlY3ZPHxEI9M2phpngL4Gq1AOdr+2vL2rg34G29D4J+dcjUrjo7+TzQWcTJ
	 DKT4QiYaLwwx95RFlzsxcx9JdbQTLpuRqU1C1Ej4T/8yxFJ73Q2kJUK9JZF3mzDjfc
	 8fRNfmzJemwhg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.205; helo=sonic304-24.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=WwfznBfx; dkim-atps=neutral
Received: from sonic304-24.consmr.mail.gq1.yahoo.com
 (sonic304-24.consmr.mail.gq1.yahoo.com [98.137.68.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DJj5w50jzzDrR9
 for <linux-erofs@lists.ozlabs.org>; Mon, 18 Jan 2021 04:46:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1610905600; bh=+npJkTWGjvbeUHo2Q96l+L4N/aou/IkFXPF9DWPkRPQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=WwfznBfx+8CY3/Lf9MdgM4BuoJc7kKd+xfMh2VBZkXf4RYLRGEhgIcwj/hmOhOYFldeIuOeC6PSgNX+3dzfrm1fmYk2DoqBQUiHJb5X2iqSzmsynsbpfVH+HE05D+5I1c4sm6a6qTq9PZx3H6wu4nWtbCsFC7XHYp8RXflRJJphayg2gUjGT7EDWa17AbgdzKf77yS9o6hz6kOp2vFAD4o1Qq8T0S5kQxJILSIK4AlIfL3m/pWOPXAC8cPYcOH8AblSNvAlvM8jyXA3stQ5a7u8ejGETeRK7EmejYR8J9GBPuXAzfNLR4BOFHvLGAQJHtqLuSmaIeOPJw5Z60UlKZw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1610905600; bh=Dl+0UU4d74QIpWg1Psg3PlMRk8y0QsiK7xBO5nAyHKY=;
 h=From:To:Subject:Date:From:Subject:Reply-To;
 b=ensEAfpaDLF5Ra9T/7BMkwf9rEpaD6SAqE2rMOBr07DLJDz8T6Nonh6m4ncXymkXe8pjGx24xcaIPHPlInkkUvZkh6KRiLsu7nLJWmMisRol13n/HHiu0P9qQLtGkTOrotUHpiRXS22RV6XP77B//QyyLf3UOULqbhXB274i0npL166HAn/JXnHYXChOs9QmLbK6JKIaJ6p5BKwmzcjX6XtVoPH7GAoieACSjxqSgB8fS3K+5cOm3fJUtZ1bNWfOnkz1BJFdwHXqRgy7eHhEuyXpSNswUBa+L0Q/SayerDrKUfN7w+KsF1bGMPXKRE2olw+gGJdjTgoqCbEW6/RuHA==
X-YMail-OSG: sg1jxm8VM1mujI1UyAnIFVkwQCImcwyx15CHK5ukGHwQlc9egmOoLzo63JkubEx
 IOvKwZvFbgchVb1wwWgJ4sCL.iaoa8oR0XyPWi8l0gsn7m7.xVeiyBugWEfMh2nTPTquPTJpIWIO
 9gKxRKulhrfKVbI1rNoPrGnUfpyYEYkciaY_t1bjvTfV6ZS5Msm2RAkXvuThIUo8bG92.JiFf5CZ
 ueRMDz8qnmVhwHIsO7NBY.z.GDRosgJbaq8eMKnAV0R4a2wIRU98iwUJNVXrQTuMRKqwE0fjJXZR
 kzGVki.KHmhHgjTlO894jODEqi1fFFoPdDpLNUuGP2mxfP7Au06PlMSLAHGmZOqmBJt1MgfOYZ1Y
 K7MHB6c9_xNaIVGW8p1EEXXGBF640UEuvG03g.JZp4d6Zkkngh492hTQ0OS3KupYX7sf99AFRYTd
 CBrRvhb6n_WClNBNUiBrh_MK70V77CycFNbzGV.YEIY7xUMA4YEFqXAm5.OKRw41jlw3myioXaIX
 4NnoYzeB1ovdysaep002ktM5SMi6RE4YLxoWcyMduuAKPVmP6EacHMurIzEusScaP8Yt_4GS2t6F
 zpNjxvWQydNIG4pvaJmAVrbzCuDnEOyBY2T9S1slLWKyCN8tbkW19RrP7fdOZ.IqyrGLS4cz4k4T
 JZQYJD6Db3Yi6TtSw91idw4Zl_TsQBK4P7zThz_gEQJ3qngLKMlcAWjJe6AV5phzWgiF__OhKcad
 WEu2mCVJ6v9bxjMkRhQ4ijF20eyE_KwEjPe.BQRQmINJXuORyJ0rKSXr4nT1Z1L6UT5WfqnydQu4
 hSV30BKLsPV3v.T.HYV3DlnnwYLYHIu6fDHCvekJCXgW8U.V1Mp73KuHqKnot5T3caANjW9tlEJo
 gFIsdqteCs3o43_hRnqaVIGIfx2IDb36H_NgfA7bVDeaz1FH_pnlZigC3R5.P4WPzXgKKb.PX4Zo
 3QGGh1Dw9NJYR99bExDST1N1zXs2XIHns2vtVRp8qpvuXgXEbDHRS33Iq6YVkFOV2paF4w00bzDD
 GHHr7V0dLfNG76DDdj.D23o3ms8R61etF8Xrxygw5kk.C7ptBhoIbc7xBHEYnIpH1jgcajl8ah_E
 NItiJi0prkma.H3_.1koO8mxHowYzYTxSmxFmCauUPNTeUvrbk954ltUKoeixiAKcq5GPHku1wrJ
 Xd1goQqOIkhfKQ64XhfsAUO.pxBCbNcIsImpRhVw8tBxPb.P6Tbmi8NytDb9GiPQRY9fXtL4f7_N
 EalW8DbA44S49TEH3kinvsRLIZmOIiIhTc2I0MY.xkVpI_bAM1sabxitiwKUIV8wka9m97vYAlfY
 C9hqRg4Cqs62Gm4.1NDJDfHTQZ5p68wswGEwA3A8hGdiu_2cJxiOMBX8V__O58mZUcJCHuwfsVLH
 8p9SOS4Bl4HpSR.ckc2dxTonuklEUXIrIxJAGPh7DCIKfGEwo3n0rsvYVSm.9oXANFbn1NNLnGxM
 CPFXTVUs0nZuoMjSYHJBs_3PT2wCFeuQeqEiVSTyW_4hRva4hXxYYOrUIuOli4LLd9Bpj8WfsfIT
 nfhEGhYUlBTWAb9qpia52uGTmj9ri9rLcLiUgn.e8U_mv4fSf0QnfK1ruIOg8mrkV0WvLWptslvd
 OJvotE0PYRVQgxqhDpELWRfOpkhRBIysm24gp7YAUbPNM9m2ib6dDCKGeSWMaUwyLceCSmI2VMIv
 XONHscVvzycX0prKs3B32SdIn8ArKyyhOVkx3Yxr7Oc1HzkFKeUVddzh6p7JXKcUrjFFHCMI68ED
 ReiZp8ZszhPdHDRlebyCfDu9sdbNHNsVLfeS01vnt6Z4feGAUBoTC.JJEZoXExJHNTbJJXri4Cpp
 Ekp2kPxr4sTEhDFsrnlVqnrLwr4lRn5vMHy_8otaaPTUn8H06Ujg9_Lw4MPb1UqyEMHTxwapqZaF
 wFi8n5Uf7P6zgyiH.qLV8_Pt5mhS4g50PV69zxUBVy9S84xtpMpIEHpfSIP_QSZklq2JZVZuIlx.
 Ir22esRinpVLfhMjaDFT8SFP.IS8YFx5zu0fgEV72vryYkGEl7DuIcKgrBW9lZCr5ZPCjKqOzmDG
 ZIK3OKjci6fhDXbqw51z86HkvHtIGmo.bu7UmESUlca.U.zYE6DmsoS10vqekDXnzWvDzLtZj.iS
 YKcwdR9ESKJFNq45kGCdcfrsqtfKxWnb4uGu0hh34BU4qH3bfkRX8MiaBHF90Tc6GRmreSFOiaTx
 qMXp3iwy8J4wZpRW4EcTNhaX6.HVB3nvFO4sa59Qgp2HthAFKC8Gs6jeT25.5ox.frw2PBOrGK_E
 Uii8rtkE0tezZ3nY_mzEGpZeFNzlAVKnCVHQFDakqnDdTZLiN9mxqwdc14yXN50cGIXIwqzxGJfB
 0iOMUievCcyG3a7OA63DC2LMKPCp.KaPTnXrc88QV9SJZ1a07CvsqkK9UmKDtguXTeG1aK38O8jp
 EVyvF7AzT8APmQVNTDNie4Z9JOM0QvyFXjtFw6qPN.vXHoGl03zljdJe4UhTsMZYtrQggZViAZnQ
 1ASUX
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic304.consmr.mail.gq1.yahoo.com with HTTP; Sun, 17 Jan 2021 17:46:40 +0000
Received: by smtp401.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 84aafc302758bb6691fa0c94699b2296; 
 Sun, 17 Jan 2021 17:46:34 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v0 4/4] erofs-utils: fuse: add LZMA algorithm support
Date: Mon, 18 Jan 2021 01:46:03 +0800
Message-Id: <20210117174603.17943-5-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20210117174603.17943-1-hsiangkao@aol.com>
References: <20210117174603.17943-1-hsiangkao@aol.com>
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
Cc: Lasse Collin <lasse.collin@tukaani.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@aol.com>

This patch adds LZMA compression algorithms to erofsfuse to test
if LZMA fixed-sized output algorithm works as expected.

Cc: Lasse Collin <lasse.collin@tukaani.org>
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 lib/data.c       |  7 +++---
 lib/decompress.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/lib/data.c b/lib/data.c
index 3781846743aa..4247dd3a33aa 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -146,9 +146,10 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 		if (ret < 0)
 			return -EIO;
 
-		algorithmformat = map.m_flags & EROFS_MAP_ZIPPED ?
-						Z_EROFS_COMPRESSION_LZ4 :
-						Z_EROFS_COMPRESSION_SHIFTED;
+		if (map.m_flags & EROFS_MAP_ZIPPED)
+			algorithmformat = inode->z_algorithmtype[0];
+		else
+			algorithmformat = Z_EROFS_COMPRESSION_SHIFTED;
 
 		/*
 		 * trim to the needed size if the returned extent is quite
diff --git a/lib/decompress.c b/lib/decompress.c
index 490c4bc771da..fd9f24bcbeb6 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -10,6 +10,66 @@
 #include "erofs/decompress.h"
 #include "erofs/err.h"
 
+#include <lzma.h>
+
+/* FIXME! need to record it into superblock */
+#define DICT_SIZE	(64U << 10)
+
+static int z_erofs_decompress_lzma(struct z_erofs_decompress_req *rq)
+{
+	int ret = 0;
+	u8 *dest = (u8 *)rq->out;
+	u8 *src = (u8 *)rq->in;
+	u8 *buff = NULL;
+	unsigned int inputmargin = 0;
+	lzma_stream strm;
+	lzma_ret ret2;
+
+	if (!erofs_sb_has_lz4_0padding())
+		return -EFSCORRUPTED;
+
+	while (!src[inputmargin & ~PAGE_MASK])
+		if (!(++inputmargin & ~PAGE_MASK))
+			break;
+
+	if (inputmargin >= rq->inputsize)
+		return -EFSCORRUPTED;
+
+	if (rq->decodedskip) {
+		buff = malloc(rq->decodedlength);
+		if (!buff)
+			return -ENOMEM;
+		dest = buff;
+	}
+
+	strm = (lzma_stream)LZMA_STREAM_INIT;
+	strm.next_in = src + inputmargin;
+	strm.avail_in = rq->inputsize - inputmargin;
+	strm.next_out = dest;
+	strm.avail_out = rq->decodedlength;
+
+	ret2 = lzma_erofs_decoder(&strm, strm.avail_in, rq->decodedlength,
+				  !rq->partial_decoding, DICT_SIZE);
+	if (ret2 != LZMA_OK) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	ret2 = lzma_code(&strm, LZMA_FINISH);
+	if (ret2 != LZMA_STREAM_END) {
+		ret = -EFSCORRUPTED;
+		goto out;
+	}
+
+	if (rq->decodedskip)
+		memcpy(rq->out, dest + rq->decodedskip,
+		       rq->decodedlength - rq->decodedskip);
+out:
+	if (buff)
+		free(buff);
+	return ret;
+}
+
 #ifdef LZ4_ENABLED
 #include <lz4.h>
 
@@ -84,5 +144,7 @@ int z_erofs_decompress(struct z_erofs_decompress_req *rq)
 	if (rq->alg == Z_EROFS_COMPRESSION_LZ4)
 		return z_erofs_decompress_lz4(rq);
 #endif
+	if (rq->alg == Z_EROFS_COMPRESSION_LZMA)
+		return z_erofs_decompress_lzma(rq);
 	return -EOPNOTSUPP;
 }
-- 
2.24.0

