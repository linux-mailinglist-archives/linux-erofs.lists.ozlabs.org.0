Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 161721744FA
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Feb 2020 05:52:22 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48TvCR40RdzDrMW
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Feb 2020 15:52:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1582951939;
	bh=y92/x1n5ST7n4U1/naOlbPj7Pye8536/z08D61cNdko=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=R/ZJq21ZogHhROqvNrXKGxBnSauDBBxDfZzUsq6mcxoBTgF2kfYTk3QU8R8pGr4qc
	 QAytxEL7YYEUPfMwHWq4yHidg9QT0TVgJmJbOGycThBdHUFo/rqdUC7dTExGKJ46Vh
	 oQkll7mSuMHJk4ohtVj7txrB9VnhoDGaO2cYsyfhFHeRWGKXar77jk+lU71rkbJlsZ
	 DyLyFp4DXc/lzzFxSpz4qJQBwj5A6M2QGnAExzbTQrOMs70cmhPgLk58+nNsK+w9Hd
	 163GHjtC3hzCHVszY2Rm5ZAhzp+M9edNL0vcbJ9urIGiDjvL+kKzzvRkGS4ynfNdyq
	 SFoQMHTwVbzoA==
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
 header.s=a2048 header.b=dh2MWmzN; dkim-atps=neutral
Received: from sonic304-23.consmr.mail.gq1.yahoo.com
 (sonic304-23.consmr.mail.gq1.yahoo.com [98.137.68.204])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48TvCK0TcBzDrND
 for <linux-erofs@lists.ozlabs.org>; Sat, 29 Feb 2020 15:52:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1582951931; bh=PUFpPk+RtvGMGm7vQl+qykoSeFAYNz9GzLc4h+oxUbs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=dh2MWmzN6i4am8Os963JGAHK8RUxIqiu4OULcXywv+AONRKl7dHAZS0gkRsz6lI5qO3gLeG4u5+5ZeMnuKHPespF7ypNwe1/mcnzOwAEmLL7SFwufdfJgKPg+lb7CqxvQJoV76Hu3NQiWJmXjqLePFgtoUH77p0xl+7TSFkaUx8OeZEuKOr3m1sk42Eizx9VduWqAXHo2xTTIfroaXRYi645GkEsNwfLw5uDRVIxTGOY17XE1xPt0Lm7HfB3pwFUPlA3opjc269NcNnuJCVf3tP7nOn7O4OQbcyMdke+1O7dMNiUhpraOiRVCXHbjcUE1dtioNB0FRzgvmkBMSunNg==
X-YMail-OSG: ekY1P6MVM1kK2tCrtevl_bYN6EcqIpcDiaLF5u5Q2a6MaidmI.KJIq0AyZov10.
 G.ly4q45x3fDMY1k.H97R.SBRMrHPfqKcVJ_v7xJIK3e.A8u91pdgfWdQgwDR2wkUOjPduDDb2qQ
 Vg0q16_W0.3su7cf8VR1csRdqOrBm1rFqaMazQm2RxTPsK1mPcMq6Bxu27leJenPfXthimaShEA4
 x_wkoRMmEisqlQX95eMT.1C_o5GrFvonCMu2JiIcCJ5x5p1CFKe5ckBwa2IpsSbXt9HY1R4M3nqI
 dR2oWzS2iKx9ynfnQ6rvS5KSaCPLBC77NzB1WbhVbilvk.G9p1iYGyF33VbxVAcULgBkFsGKLyfo
 cSEqsKWHcEoDgjLpgrIm9BGsQ8uq1_B6Sh0Gyu6MnNN4sNs.ZSOLEwiINTIx1KNRIsCdoOBxG8nO
 GvC.m1iOiYqN2B4knM5rotW7hHEvhaoLE7RybImZ5QNuEneNwgwVfqjVD8DFg8tvZVe1.8PFgUbs
 cwRLvbz8fSxtFl4jJbEDB9rovIey2xMm6Xu8WokbsDYX0GGu.BJGhJyUx1XOUeG41gB93s1RQQDn
 kKuoRvworf3._pKx2wfQBQAiXGM9fFBameqHXU25THt2XLC49Dq1Q2Iq8evElOlZWYZG74w5nkH0
 qi7lyEYNk245bDIdHPchpdzU5ZVeZQop1pTOhyWEzPl7iL1JXD3e8HYZtFOaGZqW6IFa_3iW9z8n
 rh0LDVc6uzaST.wEi4RzB6cjPOv425rbHr4P6eQ7GerZr5E7BAVmFe2lAevmEaHOwBFkE4iaW9.A
 9ZnHFo5q0Gw65YHSBc.HyWj.mppGYus.20VsF_y5ZBbh6WpMHtwLKJevn2YBV8WUQftmZCyrMFaF
 fqKF.lxTuStUxCk3sqBTqoHKBxQf3lGIC0mObRm.suqVf8r7HByd4XnPD_pwofq.4be4CNpS1tdP
 K9OSVzXwvXLfzQJYiGMiGC0O3k_oxwQUnDMJPhM83LVnm93CIbgMJ0VtZpOyjelopDKp3ETYR3cF
 Ekr21b20es0yP6HCR4hF9yERT4HLnq0KiWjBGzyeSnL9ubNnpXWs296ro71vhJUYjmaDGEbvLbEZ
 vhGMPLY.MisBwEvb8M0B37PjnwCuZbpuxYW96jSd7g3kgOuS1mDg8fX.6JxwClm1fuiX8SulvkaN
 XKhg3gUkxinbrkOvqZz_OFqJ35PkjJbw51pb03k.5dc3mAH8tJdmS3NtnovvjUTX5okPP8kLrBPA
 X4lxxPA2WpZD5LhxGotx2EX1nv_zCa55YnW8lYLShOkHj_XWY4KhWpBGe1s7g6EO7OL5b6qmr5IY
 m6LGMi_RCsLw1889APCxZCXFJi8smNxX11i8tuTXP2jIq7baU242xX29x5ZEthfNDpxPImrT1mA-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic304.consmr.mail.gq1.yahoo.com with HTTP; Sat, 29 Feb 2020 04:52:11 +0000
Received: by smtp409.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 16922bddfd3cbd213433d5c12bb81660; 
 Sat, 29 Feb 2020 04:52:09 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v0.0-20200229 10/11] ez: lzma: add fixed-sized output
 compression
Date: Sat, 29 Feb 2020 12:50:16 +0800
Message-Id: <20200229045017.12424-11-hsiangkao@aol.com>
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

After this patch, compressed data can be as
much as close to destsize but not exceed.

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 lzma/lzma_encoder.c | 133 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 132 insertions(+), 1 deletion(-)

diff --git a/lzma/lzma_encoder.c b/lzma/lzma_encoder.c
index b213504..98cde22 100644
--- a/lzma/lzma_encoder.c
+++ b/lzma/lzma_encoder.c
@@ -10,7 +10,7 @@
  */
 #include <stdlib.h>
 #include <ez/bitops.h>
-#include "rc_encoder.h"
+#include "rc_encoder_ckpt.h"
 #include "lzma_common.h"
 #include "mf.h"
 
@@ -72,12 +72,23 @@ struct lzma_length_encoder {
 	probability high[kLenNumHighSymbols];
 };
 
+struct lzma_encoder_destsize {
+	struct lzma_rc_ckpt cp;
+
+	uint8_t *op;
+	uint32_t capacity;
+
+	uint32_t esz;
+	uint8_t ending[LZMA_REQUIRED_INPUT_MAX + 5];
+};
+
 struct lzma_encoder {
 	struct lzma_mf mf;
 	struct lzma_rc_encoder rc;
 
 	uint8_t *op, *oend;
 	bool finish;
+	bool need_eopm;
 
 	unsigned int state;
 
@@ -109,6 +120,8 @@ struct lzma_encoder {
 		struct lzma_match matches[kMatchMaxLen];
 		unsigned int matches_count;
 	} fast;
+
+	struct lzma_encoder_destsize *dstsize;
 };
 
 #define change_pair(smalldist, bigdist) (((bigdist) >> 7) > (smalldist))
@@ -449,6 +462,46 @@ static void rep_match(struct lzma_encoder *lzma, const uint32_t pos_state,
 	}
 }
 
+struct lzma_endstate {
+	struct lzma_length_encoder lenEnc;
+
+	probability simpleMatch[2];
+	probability posSlot[kNumPosSlotBits];
+	probability posAlign[kNumAlignBits];
+};
+
+static void encode_eopm_stateless(struct lzma_encoder *lzma,
+				  struct lzma_endstate *endstate)
+{
+	const uint32_t pos_state =
+		(lzma->mf.cur - lzma->mf.lookahead) & lzma->pbMask;
+	const unsigned int state = lzma->state;
+	unsigned int i;
+
+	endstate->simpleMatch[0] = lzma->isMatch[state][pos_state];
+	endstate->simpleMatch[1] = lzma->isRep[state];
+	endstate->lenEnc = lzma->lenEnc;
+
+	rc_bit(&lzma->rc, endstate->simpleMatch, 1);
+	rc_bit(&lzma->rc, endstate->simpleMatch + 1, 0);
+	length(&lzma->rc, &endstate->lenEnc, pos_state, kMatchMinLen);
+
+	for (i = 0; i < kNumPosSlotBits; ++i) {
+		endstate->posSlot[i] =
+			lzma->posSlotEncoder[0][(1 << (i + 1)) - 1];
+		rc_bit(&lzma->rc, endstate->posSlot + i, 1);
+	}
+
+	rc_direct(&lzma->rc, (1 << (30 - kNumAlignBits)) - 1,
+		  30 - kNumAlignBits);
+
+	for (i = 0; i < kNumAlignBits; ++i) {
+		endstate->posAlign[i] =
+			lzma->posAlignEncoder[(1 << (i + 1)) - 1];
+		rc_bit(&lzma->rc, endstate->posAlign + i, 1);
+	}
+}
+
 static void encode_eopm(struct lzma_encoder *lzma)
 {
 	const uint32_t pos_state =
@@ -460,8 +513,86 @@ static void encode_eopm(struct lzma_encoder *lzma)
 	match(lzma, pos_state, UINT32_MAX, kMatchMinLen);
 }
 
+static int __flush_symbol_destsize(struct lzma_encoder *lzma)
+{
+	uint8_t *op2;
+	unsigned int symbols_size;
+	unsigned int esz = 0;
+
+	if (lzma->dstsize->capacity < 5)
+		return -ENOSPC;
+
+	if (!lzma->rc.pos) {
+		rc_write_checkpoint(&lzma->rc, &lzma->dstsize->cp);
+		lzma->dstsize->op = lzma->op;
+	}
+
+	if (rc_encode(&lzma->rc, &lzma->op, lzma->oend))
+		return -ENOSPC;
+
+	op2 = lzma->op;
+	symbols_size = op2 - lzma->dstsize->op;
+	if (lzma->dstsize->capacity < symbols_size + 5)
+		goto err_enospc;
+
+	if (!lzma->need_eopm)
+		goto out;
+
+	if (lzma->dstsize->capacity < symbols_size +
+	    LZMA_REQUIRED_INPUT_MAX + 5) {
+		struct lzma_rc_ckpt cp2;
+		struct lzma_endstate endstate;
+		uint8_t ending[sizeof(lzma->dstsize->ending)];
+		uint8_t *ep;
+
+		rc_write_checkpoint(&lzma->rc, &cp2);
+		encode_eopm_stateless(lzma, &endstate);
+		rc_flush(&lzma->rc);
+
+		ep = ending;
+		if (rc_encode(&lzma->rc, &ep, ending + sizeof(ending)))
+			DBG_BUGON(1);
+
+		esz = ep - ending;
+
+		if (lzma->dstsize->capacity < symbols_size + esz)
+			goto err_enospc;
+		rc_restore_checkpoint(&lzma->rc, &cp2);
+
+		memcpy(lzma->dstsize->ending, ending, sizeof(ending));
+		lzma->dstsize->esz = esz;
+	}
+
+out:
+	lzma->dstsize->capacity -= symbols_size;
+	lzma->dstsize->esz = esz;
+	return 0;
+
+err_enospc:
+	rc_restore_checkpoint(&lzma->rc, &lzma->dstsize->cp);
+	lzma->op = lzma->dstsize->op;
+	lzma->dstsize->capacity = 0;
+	return -ENOSPC;
+}
+
 static int flush_symbol(struct lzma_encoder *lzma)
 {
+	if (lzma->rc.count && lzma->dstsize) {
+		const unsigned int safemargin =
+			5 + (LZMA_REQUIRED_INPUT_MAX << !!lzma->need_eopm);
+		uint8_t *op;
+		bool ret;
+
+		if (lzma->dstsize->capacity < safemargin)
+			return __flush_symbol_destsize(lzma);
+
+		op = lzma->op;
+		ret = rc_encode(&lzma->rc, &lzma->op, lzma->oend);
+
+		lzma->dstsize->capacity -= lzma->op - op;
+		return ret ? -ENOSPC : 0;
+	}
+
 	return rc_encode(&lzma->rc, &lzma->op, lzma->oend) ? -ENOSPC : 0;
 }
 
-- 
2.20.1

