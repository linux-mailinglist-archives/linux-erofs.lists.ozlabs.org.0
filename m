Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F4D1744F8
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Feb 2020 05:52:12 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48TvCF3hMTzDr6W
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Feb 2020 15:52:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1582951929;
	bh=IPH+6gwzIbhDuB+UF8UjZYB2E+MTcwuqxIhzsX5K6DM=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=NPu7eR4w70LFAFQ7VtWC+RsIXhgovoK0W0men8o8efBso5vRmskAZn48kKuGjwPoE
	 YcDQOoYG/K3nnohdfmTOBk9wi1wQsFFVogsK7UecNa5qqRfM1KQnFP21gWnCkxhyOh
	 VA0VePLtww+zOhU8gYR5he2I9ox6STNUrIOikmh4VQLKw3RDVhKOl/pYnR+EAgD5sY
	 2jsj3ZXXF+0vIMauLUg4qL9D/ajzMlvXEu4uXiDpOGMZCD2pkablEa6+SKLTEFvOO8
	 NssZ7H2s+/arARDPde0xpqutCBaqKCV05gzjDjbQ5eIFfpUQCzoMEYFtU/o7pU4hw7
	 sNdsZcoLbWwlw==
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
 header.s=a2048 header.b=YGeUL7GE; dkim-atps=neutral
Received: from sonic308-8.consmr.mail.gq1.yahoo.com
 (sonic308-8.consmr.mail.gq1.yahoo.com [98.137.68.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48TvC65s5lzDrNR
 for <linux-erofs@lists.ozlabs.org>; Sat, 29 Feb 2020 15:52:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1582951921; bh=Cj2CwhRiWI4c4B5NC6HA7VPugLKQhGtXS4e5V7MiorA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=YGeUL7GEzv3g7XMpLiEPm1poCAE1JkcBVD1eq5I+RGqTkTmzV86hm00ch9QfsS+AJtzPfQiJbxFlQzxVYmBfQ7sCl9g5X3HgNj8M2GrJmluIifV7L+ivlkx9PhXF0kgwSAf1UKxs4DLoLLuJr6qZXqrxxUfYpBxCcnOqeikpb2OD5iNglSbZflHn8/YCderDGrGKcl+bgCj32VAzQfR+kjs29Ib9YUPswCmYH9RcCHfkKuXnC9kZY9zTMHJe/sFHXGnQha6G3cSJY8eSlUm8kF4hl4XiUBG99PJwbPdB6vUclyXBrLtZ65cC68L9oD95bIM/3FanB+FK1mhe6IG51Q==
X-YMail-OSG: bPzKLLMVM1mwjIVDgzXkL2H7SD2JyaFkJ2FXdKA7aeJAiVB9K4r91XZyNFC7_qa
 X3QVTH6BTx0s7ieDqexc7P9ldgToOBnnPxNCR88ZyoSjvMMI6WAzm4N1vrQzsWmOMlYon3fchBHu
 XPzSL6kH4nj1CGF9kD1At9..pyLjjhVjDXywwbTw717PigyalTUdhaRGj3oizwxpKRJFbDqzufLD
 ul1NoxR8bP9yKvRsesTY9Z.84S5pXGVCtFrvxTThHi1vKHbchfnIbwGxpwTyj9tNcWmhnRkOmG9K
 UgIR49nf80GHdExEXbx5C6CX9qHQNAfQB3rx0l867vqbWiaaQeNhrtTUT0.cOrcN6.SuzUj3LIZd
 SfUjIP1hyXtw9GP2OZ9VUSN8HdfmCOryD5GbvMyuRlSMV8FlhWyBxjXwMEaS2UOKKO0ZcpnMNYf6
 wZ_w.My_kGncRasJ9C2NZsO4KAp._XafETmFTL3BYOuGDNu6HVQ.famgdThdO9WOcCQPlJGv2aeG
 5NZ9vVQKmeaU2sUmligoMwrMOlKIVEVEgZQHG5NQ9BdM5MZ.7eYw.72YbGcU4DQnJQN5PFNorKuq
 1lDHfQlGOTOfe2xvKdcD88XVuqTDlZBQ3SwUpUdE2IgUhjqcdUUhUifN6ihloeMTBoclKofyw6X9
 jeGB_O_hov12Px5AZw9fYJ0GL57oGFUaCNmU8VwhAToHpbeEuVJnmpJTOWLu41Gw.7TWhIxBdABZ
 GalTpNjsC3OZYHGbeIrKmLLZjrYRATKazh9e32UubZQ1CtgBWNNH5cNDUSSCe2XEoxYAI.shW58e
 t09xSk2DEFpZewRzfyZWzQTXcwz8keVBobY4jN6uiqFtsqflHiSGD4KhXJfeuJktEHu5PJM.ke91
 J2uhYw7OVGmDNlqOncSWD9I_GHJh748BCbNSFY6Rdhf1zlo2_S9egZJyET2fA..tpPSNQIoha3ks
 9txFiV6FW2mhao9RVFEtdliEzNwgmXsVRRD2XV6TsHP0hFNuBkbleUvfbS8fwDfQu5C54vhOKkhF
 ELzVQzWc4ZU6pWPQcQMzjRPyJFwdCaO6yBRDhGlF98ClnLygom4YfZ0qS8KP6omlKfR8jXeWIXzZ
 w0NLtlqFteGny8a7Qw1JlljizHzKD3shAZT0vshSCGzLRSk9m60.HGkOlMSZb6L845iz7rQTuLma
 XoHjdgWmywU598P0GcG5IDwjOPOE_sL7BY7srKCD_qTNbfzmjvVEkTb0IKpv5_16Zt1Eu6RNxGSd
 ljg.p.ft2dr_XKaSeV9TTSXwaImbEIASHx8nqUG5GViM6FIfZIQSpSri.mt6.2k1lopj1CkU0P6a
 6EJf5.HB0KIGa10AFSaJ2DTketVaVmutpFzZnPgVW0S5rXFwrAkq7id42SRhAWnQkefuCbWuUFOU
 UiD4Dj92r.WJBwMU_l_MSu4bbMoV3N6o-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic308.consmr.mail.gq1.yahoo.com with HTTP; Sat, 29 Feb 2020 04:52:01 +0000
Received: by smtp409.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 16922bddfd3cbd213433d5c12bb81660; 
 Sat, 29 Feb 2020 04:51:48 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v0.0-20200229 08/11] ez: lzma: add LZMA encoder
Date: Sat, 29 Feb 2020 12:50:14 +0800
Message-Id: <20200229045017.12424-9-hsiangkao@aol.com>
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

It adds an improved fast optimizer which implements
lazy matching and a LZMA symbol encoder.

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 lzma/lzma_encoder.c | 628 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 628 insertions(+)
 create mode 100644 lzma/lzma_encoder.c

diff --git a/lzma/lzma_encoder.c b/lzma/lzma_encoder.c
new file mode 100644
index 0000000..b213504
--- /dev/null
+++ b/lzma/lzma_encoder.c
@@ -0,0 +1,628 @@
+// SPDX-License-Identifier: Apache-2.0
+/*
+ * ez/lzma/lzma_encoder.c
+ *
+ * Copyright (C) 2019-2020 Gao Xiang <hsiangkao@aol.com>
+ *
+ * Authors: Igor Pavlov <http://7-zip.org/>
+ *          Lasse Collin <lasse.collin@tukaani.org>
+ *          Gao Xiang <hsiangkao@aol.com>
+ */
+#include <stdlib.h>
+#include <ez/bitops.h>
+#include "rc_encoder.h"
+#include "lzma_common.h"
+#include "mf.h"
+
+#define kNumBitModelTotalBits	11
+#define kBitModelTotal		(1 << kNumBitModelTotalBits)
+#define kProbInitValue		(kBitModelTotal >> 1)
+
+#define kNumStates		12
+#define LZMA_PB_MAX		4
+#define LZMA_NUM_PB_STATES_MAX	(1 << LZMA_PB_MAX)
+
+#define kNumLenToPosStates	4
+#define kNumPosSlotBits		6
+
+#define kStartPosModelIndex	4
+#define kEndPosModelIndex	14
+#define kNumFullDistances	(1 << (kEndPosModelIndex >> 1))
+
+#define kNumAlignBits		4
+#define kAlignTableSize		(1 << kNumAlignBits)
+#define kAlignMask		(kAlignTableSize - 1)
+
+#define kNumLenToPosStates	4
+
+#define is_literal_state(state) ((state) < 7)
+
+/* note that here dist is an zero-based distance */
+static unsigned int get_pos_slot2(unsigned int dist)
+{
+	const unsigned int zz = fls(dist) - 1;
+
+	return (zz + zz) + ((dist >> (zz - 1)) & 1);
+}
+
+static unsigned int get_pos_slot(unsigned int dist)
+{
+	return dist <= 4 ? dist : get_pos_slot2(dist);
+}
+
+/* aka. GetLenToPosState in LZMA */
+static inline unsigned int get_len_state(unsigned int len)
+{
+	if (len < kNumLenToPosStates - 1 + kMatchMinLen)
+		return len - kMatchMinLen;
+
+	return kNumLenToPosStates - 1;
+}
+
+struct lzma_properties {
+	uint32_t lc;	/* 0 <= lc <= 8, default = 3 */
+	uint32_t lp;	/* 0 <= lp <= 4, default = 0 */
+	uint32_t pb;	/* 0 <= pb <= 4, default = 2 */
+
+	struct lzma_mf_properties mf;
+};
+
+struct lzma_length_encoder {
+	probability low[LZMA_NUM_PB_STATES_MAX << (kLenNumLowBits + 1)];
+	probability high[kLenNumHighSymbols];
+};
+
+struct lzma_encoder {
+	struct lzma_mf mf;
+	struct lzma_rc_encoder rc;
+
+	uint8_t *op, *oend;
+	bool finish;
+
+	unsigned int state;
+
+	/* the four most recent match distances */
+	uint32_t reps[LZMA_NUM_REPS];
+
+	unsigned int pbMask, lpMask;
+
+	unsigned int lc, lp;
+
+	/* the following names came from lzma-specification.txt */
+	probability isMatch[kNumStates][LZMA_NUM_PB_STATES_MAX];
+	probability isRep[kNumStates];
+	probability isRepG0[kNumStates];
+	probability isRepG1[kNumStates];
+	probability isRepG2[kNumStates];
+	probability isRep0Long[kNumStates][LZMA_NUM_PB_STATES_MAX];
+
+	probability posSlotEncoder[kNumLenToPosStates][1 << kNumPosSlotBits];
+	probability posEncoders[kNumFullDistances];
+	probability posAlignEncoder[1 << kNumAlignBits];
+
+	probability *literal;
+
+	struct lzma_length_encoder lenEnc;
+	struct lzma_length_encoder repLenEnc;
+
+	struct {
+		struct lzma_match matches[kMatchMaxLen];
+		unsigned int matches_count;
+	} fast;
+};
+
+#define change_pair(smalldist, bigdist) (((bigdist) >> 7) > (smalldist))
+
+static int lzma_get_optimum_fast(struct lzma_encoder *lzma,
+				 uint32_t *back_res, uint32_t *len_res)
+{
+	struct lzma_mf *const mf = &lzma->mf;
+	const uint32_t nice_len = mf->nice_len;
+
+	unsigned int matches_count, i;
+	unsigned int longest_match_length, longest_match_back;
+	unsigned int best_replen, best_rep;
+	const uint8_t *ip, *ilimit, *ista;
+	uint32_t len;
+	int ret;
+
+	if (!mf->lookahead) {
+		ret = lzma_mf_find(mf, lzma->fast.matches, lzma->finish);
+
+		if (ret < 0)
+			return ret;
+
+		matches_count = ret;
+	} else {
+		matches_count = lzma->fast.matches_count;
+	}
+
+	ip = mf->buffer + mf->cur - mf->lookahead;
+
+	/* no valid match found by matchfinder */
+	if (!matches_count ||
+	/* not enough input left to encode a match */
+	   mf->iend - ip <= 2)
+		goto out_literal;
+
+	ilimit = (mf->iend <= ip + kMatchMaxLen ?
+		  mf->iend : ip + kMatchMaxLen);
+
+	best_replen = 0;
+
+	/* look for all valid repeat matches */
+	for (i = 0; i < LZMA_NUM_REPS; ++i) {
+		const uint8_t *const repp = ip - lzma->reps[i];
+
+		/* the first two bytes (MATCH_LEN_MIN == 2) do not match */
+		if (get_unaligned16(ip) != get_unaligned16(repp))
+			continue;
+
+		len = ez_memcmp(ip + 2, repp + 2, ilimit) - ip;
+		/* a repeated match at least nice_len, return it immediately */
+		if (len >= nice_len) {
+			*back_res = i;
+			*len_res = len;
+			lzma_mf_skip(mf, len - 1);
+			return 0;
+		}
+
+		if (len > best_replen) {
+			best_rep = i;
+			best_replen = len;
+		}
+	}
+
+	/*
+	 * although we didn't find a long enough repeated match,
+	 * the normal match is long enough to use directly.
+	 */
+	longest_match_length = lzma->fast.matches[matches_count - 1].len;
+	longest_match_back = lzma->fast.matches[matches_count - 1].dist;
+	if (longest_match_length >= nice_len) {
+		/* it's encoded as 0-based match distances */
+		*back_res = LZMA_NUM_REPS + longest_match_back - 1;
+		*len_res = longest_match_length;
+		lzma_mf_skip(mf, longest_match_length - 1);
+		return 0;
+	}
+
+	while (matches_count > 1) {
+		const struct lzma_match *const victim =
+			&lzma->fast.matches[matches_count - 2];
+
+		/* only (longest_match_length - 1) would be considered */
+		if (longest_match_length > victim->len + 1)
+			break;
+
+		if (!change_pair(victim->dist, longest_match_back))
+			break;
+
+		--matches_count;
+		longest_match_length = victim->len;
+		longest_match_back = victim->dist;
+	}
+
+	if (longest_match_length > best_replen + 1) {
+		best_replen = 0;
+
+		if (longest_match_length < 3 &&
+		    longest_match_back > 0x80)
+			goto out_literal;
+	} else {
+		longest_match_length = best_replen;
+		longest_match_back = 0;
+	}
+
+	ista = ip;
+
+	while (1) {
+		const struct lzma_match *victim;
+
+		ret = lzma_mf_find(mf, lzma->fast.matches, lzma->finish);
+
+		if (ret < 0) {
+			lzma->fast.matches_count = 0;
+			break;
+		}
+
+		lzma->fast.matches_count = ret;
+		if (!ret)
+			break;
+
+		victim = &lzma->fast.matches[lzma->fast.matches_count - 1];
+
+		/* both sides have eliminated '+ nlits' */
+		if (victim->len + 1 < longest_match_length)
+			break;
+
+		if (!best_replen) {
+			/* victim->len (should) >= longest_match_length - 1 */
+			const uint8_t *ip1 = ip + 1;
+			const uint32_t rl = max(2U, longest_match_length - 1);
+
+			/* TODO: lazy match for this */
+			for (i = 0; i < LZMA_NUM_REPS; ++i) {
+				if (!memcmp(ip1, ip1 - lzma->reps[i], rl)) {
+					*len_res = 0;
+					return ip1 - ista;
+				}
+			}
+
+			len = UINT32_MAX;
+		} else {
+			len = 0;
+		}
+
+		for (i = 0; i < LZMA_NUM_REPS; ++i) {
+			if (lzma->reps[i] == victim->dist) {
+				len = victim->len;
+				break;
+			}
+		}
+
+		/* if the previous match is a rep, this should be longer */
+		if (len <= best_replen)
+			break;
+
+		/* if it's not a rep */
+		if (len == UINT32_MAX) {
+			if (victim->len + 1 == longest_match_length &&
+			    !change_pair(victim->dist, longest_match_back))
+				break;
+
+			if (victim->len == longest_match_length &&
+			    get_pos_slot(victim->dist - 1) >=
+			    get_pos_slot(longest_match_back))
+				break;
+			len = 0;
+		}
+		longest_match_length = victim->len;
+		longest_match_back = victim->dist;
+		best_replen = len;
+		best_rep = i;
+		++ip;
+	}
+
+	/* it's encoded as 0-based match distances */
+	if (best_replen)
+		*back_res = best_rep;
+	else
+		*back_res = LZMA_NUM_REPS + longest_match_back - 1;
+
+	*len_res = longest_match_length;
+	lzma_mf_skip(mf, longest_match_length - 2 + (ret < 0));
+	return ip - ista;
+
+out_literal:
+	*len_res = 0;
+	return 1;
+}
+
+static void literal_matched(struct lzma_rc_encoder *rc, probability *probs,
+			    uint32_t match_byte, uint32_t symbol)
+{
+	uint32_t offset = 0x100;
+
+	symbol += 0x100;
+	do {
+		const unsigned int bit = (symbol >> 7) & 1;
+		const unsigned int match_bit = (match_byte <<= 1) & offset;
+
+		rc_bit(rc, &probs[offset + match_bit + (symbol >> 8)], bit);
+		symbol <<= 1;
+		offset &= ~(match_byte ^ symbol);
+	} while (symbol < 0x10000);
+}
+
+static void literal(struct lzma_encoder *lzma, uint32_t position)
+{
+	static const unsigned char kLiteralNextStates[] = {
+		0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 4, 5
+	};
+	struct lzma_mf *mf = &lzma->mf;
+	const uint8_t *ptr = &mf->buffer[mf->cur - mf->lookahead];
+	const unsigned int state = lzma->state;
+
+	probability *probs = lzma->literal +
+		3 * ((((position << 8) + ptr[-1]) & lzma->lpMask) << lzma->lc);
+
+	if (is_literal_state(state)) {
+		/*
+		 * Previous LZMA-symbol was a literal. Encode a normal
+		 * literal without a match byte.
+		 */
+		rc_bittree(&lzma->rc, probs, 8, *ptr);
+	} else {
+		/*
+		 * Previous LZMA-symbol was a match. Use the byte + 1
+		 * of the last match as a "match byte". That is, compare
+		 * the bits of the current literal and the match byte.
+		 */
+		const uint8_t match_byte = *(ptr - lzma->reps[0]);
+
+		literal_matched(&lzma->rc, probs, match_byte, *ptr);
+	}
+
+	lzma->state = kLiteralNextStates[state];
+}
+
+/* LenEnc_Encode */
+static void length(struct lzma_rc_encoder *rc,
+		   struct lzma_length_encoder *lc,
+		   const uint32_t pos_state, const uint32_t len)
+{
+	uint32_t sym = len - kMatchMinLen;
+	probability *probs = lc->low;
+
+	if (sym >= kLenNumLowSymbols) {
+		rc_bit(rc, probs, 1);
+		probs += kLenNumLowSymbols;
+		if (sym >= kLenNumLowSymbols * 2 /* + kLenNumMidSymbols */) {
+			rc_bit(rc, probs, 1);
+			rc_bittree(rc, lc->high, kLenNumHighBits,
+				   sym - kLenNumLowSymbols * 2);
+			return;
+		}
+		sym -= kLenNumLowSymbols;
+	}
+	rc_bit(rc, probs, 0);
+	rc_bittree(rc, probs + (pos_state << (kLenNumLowBits + 1)),
+		   kLenNumLowBits, sym);
+}
+
+/* Match */
+static void match(struct lzma_encoder *lzma, const uint32_t pos_state,
+		  const uint32_t dist, const uint32_t len)
+{
+	const uint32_t posSlot = get_pos_slot(dist);
+	const uint32_t lenState = get_len_state(len);
+
+	lzma->state = (is_literal_state(lzma->state) ? 7 : 10);
+	length(&lzma->rc, &lzma->lenEnc, pos_state, len);
+
+	/* - unsigned posSlot = PosSlotDecoder[lenState].Decode(&RangeDec); */
+	rc_bittree(&lzma->rc, lzma->posSlotEncoder[lenState],
+		   kNumPosSlotBits, posSlot);
+
+	if (dist >= kStartPosModelIndex) {
+		const uint32_t footer_bits = (posSlot >> 1) - 1;
+		const uint32_t base = (2 | (posSlot & 1)) << footer_bits;
+
+		if (dist < kNumFullDistances) {
+			rc_bittree_reverse(&lzma->rc,
+					   lzma->posEncoders + base,
+					   footer_bits, dist);
+		} else {
+			const uint32_t dist_reduced = dist - base;
+
+			rc_direct(&lzma->rc, dist_reduced >> kNumAlignBits,
+				  footer_bits - kNumAlignBits);
+
+#if 0
+			rc_bittree_reverse(&lzma->rc, lzma->posAlignEncoder,
+					   kNumAlignBits,
+					   dist_reduced & kAlignMask);
+#endif
+			rc_bittree_reverse(&lzma->rc, lzma->posAlignEncoder,
+					   kNumAlignBits, dist);
+		}
+	}
+	lzma->reps[3] = lzma->reps[2];
+	lzma->reps[2] = lzma->reps[1];
+	lzma->reps[1] = lzma->reps[0];
+	lzma->reps[0] = dist + 1;
+}
+
+static void rep_match(struct lzma_encoder *lzma, const uint32_t pos_state,
+		      const uint32_t rep, const uint32_t len)
+{
+	const unsigned int state = lzma->state;
+
+	if (rep == 0) {
+		rc_bit(&lzma->rc, &lzma->isRepG0[state], 0);
+		rc_bit(&lzma->rc, &lzma->isRep0Long[state][pos_state],
+		       len != 1);
+	} else {
+		const uint32_t distance = lzma->reps[rep];
+
+		rc_bit(&lzma->rc, &lzma->isRepG0[state], 1);
+		if (rep == 1) {
+			rc_bit(&lzma->rc, &lzma->isRepG1[state], 0);
+		} else {
+			rc_bit(&lzma->rc, &lzma->isRepG1[state], 1);
+			rc_bit(&lzma->rc, &lzma->isRepG2[state], rep - 2);
+
+			if (rep == 3)
+				lzma->reps[3] = lzma->reps[2];
+			lzma->reps[2] = lzma->reps[1];
+		}
+		lzma->reps[1] = lzma->reps[0];
+		lzma->reps[0] = distance;
+	}
+
+	if (len == 1) {
+		lzma->state = is_literal_state(state) ? 9 : 11;
+	} else {
+		length(&lzma->rc, &lzma->repLenEnc, pos_state, len);
+		lzma->state = is_literal_state(state) ? 8 : 11;
+	}
+}
+
+static void encode_eopm(struct lzma_encoder *lzma)
+{
+	const uint32_t pos_state =
+		(lzma->mf.cur - lzma->mf.lookahead) & lzma->pbMask;
+	const unsigned int state = lzma->state;
+
+	rc_bit(&lzma->rc, &lzma->isMatch[state][pos_state], 1);
+	rc_bit(&lzma->rc, &lzma->isRep[state], 0);
+	match(lzma, pos_state, UINT32_MAX, kMatchMinLen);
+}
+
+static int flush_symbol(struct lzma_encoder *lzma)
+{
+	return rc_encode(&lzma->rc, &lzma->op, lzma->oend) ? -ENOSPC : 0;
+}
+
+static int encode_symbol(struct lzma_encoder *lzma, uint32_t back,
+			 uint32_t len, uint32_t *position)
+{
+	int err = flush_symbol(lzma);
+
+	if (!err) {
+		const uint32_t pos_state = *position & lzma->pbMask;
+		const unsigned int state = lzma->state;
+		struct lzma_mf *const mf = &lzma->mf;
+
+		if (back == MARK_LIT) {
+			/* literal i.e. 8-bit byte */
+			rc_bit(&lzma->rc, &lzma->isMatch[state][pos_state], 0);
+			literal(lzma, *position);
+			len = 1;
+		} else {
+			rc_bit(&lzma->rc, &lzma->isMatch[state][pos_state], 1);
+
+			if (back < LZMA_NUM_REPS) {
+				/* repeated match */
+				rc_bit(&lzma->rc, &lzma->isRep[state], 1);
+				rep_match(lzma, pos_state, back, len);
+			} else {
+				/* normal match */
+				rc_bit(&lzma->rc, &lzma->isRep[state], 0);
+				match(lzma, pos_state,
+				      back - LZMA_NUM_REPS, len);
+			}
+		}
+
+		/* len bytes has been consumed by encoder */
+		DBG_BUGON(mf->lookahead < len);
+		mf->lookahead -= len;
+		*position += len;
+	}
+	return err;
+}
+
+/* encode sequence (literal, match) */
+static int encode_sequence(struct lzma_encoder *lzma, unsigned int nliterals,
+			   uint32_t back, uint32_t len, uint32_t *position)
+{
+	while (nliterals) {
+		int err = encode_symbol(lzma, MARK_LIT, 0, position);
+
+		if (err)
+			return err;
+		--nliterals;
+	}
+	if (!len)	/* no match */
+		return 0;
+	return encode_symbol(lzma, back, len, position);
+}
+
+static int __lzma_encode(struct lzma_encoder *lzma)
+{
+	uint32_t pos32 = lzma->mf.cur - lzma->mf.lookahead;
+	int err;
+
+	do {
+		uint32_t back, len;
+		int nlits;
+
+		nlits = lzma_get_optimum_fast(lzma, &back, &len);
+
+		if (nlits < 0) {
+			err = nlits;
+			break;
+		}
+
+		err = encode_sequence(lzma, nlits, back, len, &pos32);
+	} while (!err);
+	return err;
+}
+
+static void lzma_length_encoder_reset(struct lzma_length_encoder *lc)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(lc->low); i++)
+		lc->low[i] = kProbInitValue;
+
+	for (i = 0; i < ARRAY_SIZE(lc->high); i++)
+		lc->high[i] = kProbInitValue;
+}
+
+static int lzma_encoder_reset(struct lzma_encoder *lzma,
+			      const struct lzma_properties *props)
+{
+	unsigned int i, j, oldlclp, lclp;
+
+	lzma_mf_reset(&lzma->mf, &props->mf);
+	rc_reset(&lzma->rc);
+
+	/* refer to "The main loop of decoder" of lzma specification */
+	lzma->state = 0;
+	lzma->reps[0] = lzma->reps[1] = lzma->reps[2] =
+		lzma->reps[3] = 1;
+
+	/* reset all LZMA probability matrices */
+	for (i = 0; i < kNumStates; ++i) {
+		for (j = 0; j < LZMA_NUM_PB_STATES_MAX; ++j) {
+			lzma->isMatch[i][j] = kProbInitValue;
+			lzma->isRep0Long[i][j] = kProbInitValue;
+		}
+		lzma->isRep[i] = kProbInitValue;
+		lzma->isRepG0[i] = kProbInitValue;
+		lzma->isRepG1[i] = kProbInitValue;
+		lzma->isRepG2[i] = kProbInitValue;
+	}
+
+	for (i = 0; i < kNumLenToPosStates; ++i)
+		for (j = 0; j < (1 << kNumPosSlotBits); j++)
+			lzma->posSlotEncoder[i][j] = kProbInitValue;
+
+	for (i = 0; i < ARRAY_SIZE(lzma->posEncoders); i++)
+		lzma->posEncoders[i] = kProbInitValue;
+
+	for (i = 0; i < ARRAY_SIZE(lzma->posAlignEncoder); i++)
+		lzma->posAlignEncoder[i] = kProbInitValue;
+
+	/* set up LZMA literal probabilities */
+	oldlclp = lzma->lc + lzma->lp;
+	lclp = props->lc + props->lp;
+	lzma->lc = props->lc;
+	lzma->lp = props->lp;
+
+	if (lzma->literal && lclp != oldlclp) {
+		free(lzma->literal);
+		lzma->literal = NULL;
+	}
+
+	if (!lzma->literal) {
+		lzma->literal = malloc((0x300 << lclp) * sizeof(probability));
+		if (!lzma->literal)
+			return -ENOMEM;
+	}
+
+	for (i = 0; i < (0x300 << lclp); i++)
+		lzma->literal[i] = kProbInitValue;
+
+	lzma->pbMask = (1 << props->pb) - 1;
+	lzma->lpMask = (0x100 << props->lp) - (0x100 >> props->lc);
+
+	lzma_length_encoder_reset(&lzma->lenEnc);
+	lzma_length_encoder_reset(&lzma->repLenEnc);
+	return 0;
+}
+
+void lzma_default_properties(struct lzma_properties *p, int level)
+{
+	if (level < 0)
+		level = 5;
+
+	p->lc = 3;
+	p->lp = 0;
+	p->pb = 2;
+	p->mf.nice_len = (level < 7 ? 32 : 64);	/* LZMA SDK numFastBytes */
+	p->mf.depth = (16 + (p->mf.nice_len >> 1)) >> 1;
+}
+
-- 
2.20.1

