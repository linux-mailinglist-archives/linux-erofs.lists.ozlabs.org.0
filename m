Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 409921744F3
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Feb 2020 05:51:47 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48TvBm39BMzDqyJ
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Feb 2020 15:51:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1582951904;
	bh=a66yDdH33KAAfvAvptYLB7JTYf+TDkut/drVRfJgaT0=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=nzwesjn93q7tjiaX6R9099d57G42BPdk9H9vUwsBrZHEzXCbJ7P5ajnH2K0L12FhY
	 dV5WAQ+cTDOYIO2X2NVf/QXHxaSdxZnVCcN3s753dF/867fj57oj4R2YHlRFodCTSF
	 9s9cxAxa0cGdtUofDPwqEqYHJRHymeqTaN15QI6988X3xgbBLgaaUjjdOLHPy4BGiA
	 DiP3Ux34yL+S2iikrPDYmrUdxNsFbqYr8g10liNjiN/JDQY93Yaba3/f/Vu+w7Zzg0
	 Q+bVSlMkSITZAIbiZOwY03KhywFaWHfR6Bin3Or6pr4vDV6R9TA3I5n9IRITc1jDWE
	 Ir9viRkzuLAbw==
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
 header.s=a2048 header.b=j1RfbB8q; dkim-atps=neutral
Received: from sonic308-8.consmr.mail.gq1.yahoo.com
 (sonic308-8.consmr.mail.gq1.yahoo.com [98.137.68.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48TvBR60RczDrMG
 for <linux-erofs@lists.ozlabs.org>; Sat, 29 Feb 2020 15:51:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1582951886; bh=175O74GynOCObkhytQUm3NjGaK/sR+qJZ0E/ZqNwong=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=j1RfbB8qo25fo1xIH7JPlLsgqSyS3URJFiwe/NFXLTfm2OTvVVSxXp/idEX4CeIwP6g0W9WWm87yvY5j0mYFZSagpFzu/W5hWRbI37SDElO0cgZ+ogOs7+JpnsEtZlwceShQ4uXU1T7GH5HvuCsK8wx5ebF1xTFP8PIl2bh/VyAluT77aWhMYmnHgCbYG4Hvz0AUk+TsCtVGKsxDCoUBKiySFjj54Si6GWQzeFQK6FX6IOV+RB4iJ/MuvnZGT60LxNfI9MR0V8Gk6eAfGpYgzWoEZtNSlW0TOrwutHNInpg5pu1C2js6Kqx8nOXTbJjM5bioLem0CGlFhzTCtiUihg==
X-YMail-OSG: ZXgNb3AVM1ky9dpod9avGRcOY327nNCbEEuYFmHNyztUvUTmhUEubBjICwfFtVS
 8SXeDyVxMpzHhkTWhqmxoVlwqAZ3Eu5Q_YB9NpAZGIxslb8k7lQI09NxpzT8Mf431iDvIUfWx1tr
 yQaylRlzpjxLrturj8cTk0oQU4aq.hpOMM3o8qPXNhoHeFNfvFCi3VqdIxSRLhNxeJda4zzIzFC1
 FF5G8eWj_GoWz0RCtLP49Fq_p8WAOeRwmZLM.Zkz1PNd1azlmwoEtOoDdXMBGv2ELVpHHqg4R_iY
 58keUn.guKHkLDvYNudDKmrUJdmojfRFN8OhPvDVW7H0.EQbvmmu419ENqbM4hUoFVNA6YmJvw1i
 AntuETZcVrdEM.FSVJt2xciWrpL3b2CRnmbGqMZ0T3thEw3tWeffhS9DsWy8cJBb.Y0jTcVOo76R
 Si21GXzLYs9ubgHqnQMU6sH3Th66N2BZUPAabot4I3my0R2y_lfNsgk9jBpZ2lrukV71tgRz_RWt
 YjqucExwVT.YAc1Y2H3_tJsqa4g0nFeUaW63GBsp2S8uhyIiSvWkeg04IkZXkLOmV_8BHO3SByRP
 S5YUUFqxmtZ_JHwO85nhRFmPJ9xzgn6J4YPrLhCAyF31b7BsZzyyRjdfzxeJ7pElrSAsalEzLmDF
 VbVdF0Rdy4PJ9BxuGi2yyELqgXLDicj.OqWf.mbkBZ86UvnOq.rBD49zsSN4sdxMr7vi54xf0FDg
 9BPMC_o2LGX1T1_6su0foGQPbUixMSkt54fscmbGZjksrhLitttyMApUq..KJPncVX1jkdaMP_hE
 LeLRwMDwKEwZuiEM3KUjV.UzR72BTTei_QOFVNudSc0zN8.WH3XbK8TJdQ4shVnO78031tgvIo4F
 oMgOo3E5V2UtSZ_jgkxpp2Xv4lCf5m6bImWdzdCOQBwn1xbQ6j6mVwfQ3gPecQ3TuBX4gqpqvLYe
 iCXC4aaf_XEao9wW..Q_0RWuJcc9zccXWjARNyDKX1Q0uRBPu6.nZKJn7fRWVnmQPdJC0T.DWIPO
 zdlZIepYVnGTjxlMsOosqsdb8bJ5h6c7t0dkd8CJXuOAJ6Cn1rfTBnuwcNDXhkGUabjdqyx3d2Dr
 Bi7CqmXIPMA_yrGW44c0WKuWgiKDk5bFAE5.37QpTB.tn_n6Jnp.zipQweXJGjKYbqi04LXYnKzp
 BlLhdtTNU3Bz3VxkRf21FjBfdySh0I8Wxi85Y88zf6WGWq..6d62i93n7qWL4qDecWpVYhywTcUo
 3zlVmf_wy5b3q.dlU8HJDsP0eNdI8UuQq9eAvcUj3zshOdFe_LapwlFp.ivNvf4wJcpTlQ094KC8
 gWWqPgn70uTB7ApBZcORes0T5PMapNd9iXjF8Ib.SY2FrDv.Y5ufS338zHX.i_s9Ti17As7nJDii
 9YK7PJO7ETue1bmWyuK3zwQ--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic308.consmr.mail.gq1.yahoo.com with HTTP; Sat, 29 Feb 2020 04:51:26 +0000
Received: by smtp409.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 16922bddfd3cbd213433d5c12bb81660; 
 Sat, 29 Feb 2020 04:51:19 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v0.0-20200229 04/11] ez: lzma: add range encoder
Date: Sat, 29 Feb 2020 12:50:10 +0800
Message-Id: <20200229045017.12424-5-hsiangkao@aol.com>
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

The implementation is greatly inspired by XZ Utils,
which is created by Lasse Collin <lasse.collin@tukaani.org>.

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 lzma/rc_common.h  |  48 ++++++++++
 lzma/rc_encoder.h | 221 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 269 insertions(+)
 create mode 100644 lzma/rc_common.h
 create mode 100644 lzma/rc_encoder.h

diff --git a/lzma/rc_common.h b/lzma/rc_common.h
new file mode 100644
index 0000000..b424fa1
--- /dev/null
+++ b/lzma/rc_common.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: Unlicense */
+/*
+ * ez/lzma/rc_common.h - common definitions for range coder
+ *
+ * Copyright (C) 2019-2020 Gao Xiang <hsiangkao@aol.com>
+ *
+ * Authors: Igor Pavlov <http://7-zip.org/>
+ *          Lasse Collin <lasse.collin@tukaani.org>
+ *          Gao Xiang <hsiangkao@aol.com>
+ */
+#ifndef __EZ_LZMA_RC_COMMON_H
+#define __EZ_LZMA_RC_COMMON_H
+
+#include <ez/defs.h>
+
+/* Constants */
+#define RC_SHIFT_BITS		8
+#define RC_TOP_BITS		24
+#define RC_TOP_VALUE		(1U << RC_TOP_BITS)
+#define RC_BIT_MODEL_TOTAL_BITS	11
+#define RC_BIT_MODEL_TOTAL	(1U << RC_BIT_MODEL_TOTAL_BITS)
+#define RC_MOVE_BITS		5
+
+/* Type definitions */
+
+/*
+ * Type of probabilities used with range coder
+ *
+ * This needs to be at least 12-bit, so uint16_t is a logical choice. However,
+ * on some architecture and compiler combinations, a bigger type may give
+ * better speed since the probability variables are accessed a lot.
+ * On the other hand, bigger probability type increases cache footprint,
+ * since there are 2 to 14 thousand probability variables in LZMA (assuming
+ * the limit of lc + lp <= 4; with lc + lp <= 12 there would be about 1.5
+ * million variables).
+ *
+ * I will stick unless some specific architectures are *much* faster (20-50%)
+ * with uint32_t than uint16_t.
+ */
+typedef uint16_t probability;
+
+static inline uint32_t rc_bound(uint32_t range, probability prob)
+{
+	return (range >> RC_BIT_MODEL_TOTAL_BITS) * prob;
+}
+
+#endif
+
diff --git a/lzma/rc_encoder.h b/lzma/rc_encoder.h
new file mode 100644
index 0000000..98bf34d
--- /dev/null
+++ b/lzma/rc_encoder.h
@@ -0,0 +1,221 @@
+/* SPDX-License-Identifier: Unlicense */
+/*
+ * ez/lzma/rc_encoder.h - range code encoder
+ *
+ * Copyright (C) 2019-2020 Gao Xiang <hsiangkao@aol.com>
+ *
+ * Authors: Igor Pavlov <http://7-zip.org/>
+ *          Lasse Collin <lasse.collin@tukaani.org>
+ *          Gao Xiang <hsiangkao@aol.com>
+ */
+#ifndef __EZ_LZMA_RC_ENCODER_H
+#define __EZ_LZMA_RC_ENCODER_H
+
+#include "rc_common.h"
+
+/*
+ * Maximum number of symbols that can be put pending into lzma_range_encoder
+ * structure between calls to lzma_rc_encode(). For LZMA, 52+5 is enough
+ * (match with big distance and length followed by range encoder flush).
+ */
+#define RC_SYMBOLS_MAX 58
+
+#define RC_BIT_0	0
+#define RC_BIT_1	1
+#define RC_DIRECT_0	2
+#define RC_DIRECT_1	3
+#define RC_FLUSH	4
+
+struct lzma_rc_encoder {
+	uint64_t low;
+	uint64_t extended_bytes;
+	uint32_t range;
+	uint8_t firstbyte;
+
+	/* Number of symbols in the tables */
+	uint8_t count;
+
+	/* rc_encode()'s position in the tables */
+	uint8_t pos;
+
+	/* Symbols to encode (use uint8_t so can be in a single cacheline.) */
+	uint8_t symbols[RC_SYMBOLS_MAX];
+
+	/* Probabilities associated with RC_BIT_0 or RC_BIT_1 */
+	probability *probs[RC_SYMBOLS_MAX];
+};
+
+static inline void rc_reset(struct lzma_rc_encoder *rc)
+{
+	*rc = (struct lzma_rc_encoder) {
+		.range = UINT32_MAX,
+		/* .firstbyte = 0, */
+	};
+}
+
+static inline void rc_bit(struct lzma_rc_encoder *rc,
+			  probability *prob, uint32_t bit)
+{
+	rc->symbols[rc->count] = bit;
+	rc->probs[rc->count] = prob;
+	++rc->count;
+}
+
+static inline void rc_bittree(struct lzma_rc_encoder *rc,
+			      probability *probs, uint32_t nbits,
+			      uint32_t symbol)
+{
+	uint32_t model_index = 1;
+
+	do {
+		const uint32_t bit = (symbol >> --nbits) & 1;
+
+		rc_bit(rc, &probs[model_index], bit);
+		model_index = (model_index << 1) + bit;
+	} while (nbits);
+}
+
+static inline void rc_bittree_reverse(struct lzma_rc_encoder *rc,
+				      probability *probs,
+				      uint32_t nbits, uint32_t symbol)
+{
+	uint32_t model_index = 1;
+
+	do {
+		const uint32_t bit = symbol & 1;
+
+		symbol >>= 1;
+		rc_bit(rc, &probs[model_index], bit);
+		model_index = (model_index << 1) + bit;
+	} while (--nbits);
+}
+
+static inline void rc_direct(struct lzma_rc_encoder *rc,
+			     uint32_t val, uint32_t nbits)
+{
+	do {
+		rc->symbols[rc->count] = RC_DIRECT_0 + ((val >> --nbits) & 1);
+		++rc->count;
+	} while (nbits);
+}
+
+
+static inline void rc_flush(struct lzma_rc_encoder *rc)
+{
+	unsigned int i;
+
+	for (i = 0; i < 5; ++i)
+		rc->symbols[rc->count++] = RC_FLUSH;
+}
+
+static inline bool rc_shift_low(struct lzma_rc_encoder *rc,
+				uint8_t **ppos, uint8_t *oend)
+{
+	if (rc->low >> 24 != UINT8_MAX) {
+		const uint32_t carrybit = rc->low >> 32;
+
+		DBG_BUGON(carrybit > 1);
+
+		/* first or interrupted byte */
+		if (unlikely(*ppos >= oend))
+			return true;
+		*(*ppos)++ = rc->firstbyte + carrybit;
+
+		while (rc->extended_bytes) {
+			--rc->extended_bytes;
+			if (unlikely(*ppos >= oend)) {
+				rc->firstbyte = UINT8_MAX;
+				return true;
+			}
+			*(*ppos)++ = carrybit - 1;
+		}
+		rc->firstbyte = rc->low >> 24;
+	} else {
+		++rc->extended_bytes;
+	}
+	rc->low = (rc->low & 0x00FFFFFF) << RC_SHIFT_BITS;
+	return false;
+}
+
+static inline bool rc_encode(struct lzma_rc_encoder *rc,
+			     uint8_t **ppos, uint8_t *oend)
+{
+	DBG_BUGON(rc->count > RC_SYMBOLS_MAX);
+
+	while (rc->pos < rc->count) {
+		/* Normalize */
+		if (rc->range < RC_TOP_VALUE) {
+			if (rc_shift_low(rc, ppos, oend))
+				return true;
+
+			rc->range <<= RC_SHIFT_BITS;
+		}
+
+		/* Encode a bit */
+		switch (rc->symbols[rc->pos]) {
+		case RC_BIT_0: {
+			probability prob = *rc->probs[rc->pos];
+
+			rc->range = rc_bound(rc->range, prob);
+			prob += (RC_BIT_MODEL_TOTAL - prob) >> RC_MOVE_BITS;
+			*rc->probs[rc->pos] = prob;
+			break;
+		}
+
+		case RC_BIT_1: {
+			probability prob = *rc->probs[rc->pos];
+			const uint32_t bound = rc_bound(rc->range, prob);
+
+			rc->low += bound;
+			rc->range -= bound;
+			prob -= prob >> RC_MOVE_BITS;
+			*rc->probs[rc->pos] = prob;
+			break;
+		}
+
+		case RC_DIRECT_0:
+			rc->range >>= 1;
+			break;
+
+		case RC_DIRECT_1:
+			rc->range >>= 1;
+			rc->low += rc->range;
+			break;
+
+		case RC_FLUSH:
+			/* Prevent further normalizations */
+			rc->range = UINT32_MAX;
+
+			/* Flush the last five bytes (see rc_flush()) */
+			do {
+				if (rc_shift_low(rc, ppos, oend))
+					return true;
+			} while (++rc->pos < rc->count);
+
+			/*
+			 * Reset the range encoder so we are ready to continue
+			 * encoding if we weren't finishing the stream.
+			 */
+			rc_reset(rc);
+			return false;
+
+		default:
+			DBG_BUGON(1);
+			break;
+		}
+		++rc->pos;
+	}
+
+	rc->count = 0;
+	rc->pos = 0;
+	return false;
+}
+
+
+static inline uint64_t rc_pending(const struct lzma_rc_encoder *rc)
+{
+	return rc->extended_bytes + 5;
+}
+
+#endif
+
-- 
2.20.1

