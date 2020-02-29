Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F011744F6
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Feb 2020 05:52:04 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48TvC53CPBzDr6K
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Feb 2020 15:52:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1582951921;
	bh=xZ5YvKzdp9AFYo86ksPAjwB9ZiVHrOLrme427efvb1s=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=nIdArx+yFSoTu6Kd/i3x2ZD5lbc9pms1tCXWnnjxnk+f+VJASdRz/UtF2DXAk8XH3
	 1t9Ts2COyQtOx7U2qOfbFzXnwb0QqTwx5ZnmgWQRlk8mJb8OkQwKBBhxJ+/tLjcwky
	 co7uz6QN0yW+8NymDGBBuBW5e+/NKfiTU4+8mAcBp9vyeKanjvDM21v+Q4ro9J4Ef0
	 89vRFjhDkkvnGdWkYMyUSCblWmY4zPDQq1Jy8ZPjXjSR/ODLRt2RLRre0OBz3zIE/v
	 ITV47qCVhgRnoW8da2iDCiv9q8jXe+APFIq3Opg1TGJzOg0d2tn4JwvOxF2WAcZ2lI
	 gIo6veVotE4Hw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.64.146; helo=sonic301-20.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=rpoVgLBc; dkim-atps=neutral
Received: from sonic301-20.consmr.mail.gq1.yahoo.com
 (sonic301-20.consmr.mail.gq1.yahoo.com [98.137.64.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48TvBp5nyWzDrMW
 for <linux-erofs@lists.ozlabs.org>; Sat, 29 Feb 2020 15:51:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1582951902; bh=B+7nJ3dgQlf17lEgi0yEaF2t66YKcGizDg7pu3XEeBg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=rpoVgLBcsu7wJb2bIXMSdWsngQsyY2bkXukeqrXluPepqEt8oplIEOqCcX4wy/5EGPhvcRy1r37f1qnYzPWSeaIr4Ajw7v6tD1mb03njTkNwEXqnTKZ8YFRpHC3x9wBgDvacT+gH/CQ1q3kT1BrDc9KQihkVaQuaaYzQQ/2BEJpHkBzE9L0/yGjZWtcpcNmvuqTtRhPkfkU5Vy+UHSho+12yZhzNLq9P6eN1kJtm3N8QG2O58Fjs9z45fJ/+pHtSJH947rSG4750+gTJCpCkbGQPBZp+PpLmNmfjVUo3b/GxA3FzsC82wVaQvf+LO5aftNLTK4WyoeUjBWwnmoLXmA==
X-YMail-OSG: gtGxGeMVM1mO2eOSHuBvyd9TBEvhu0J.u7Ttwhdx96Ebc.GdNMGrLcGuH.2sAhO
 tGVmozc2S2usZvyWOFdPU2ZEix_wlmiFgytWLZLHrm3n4RnwFr89W2XZDOoAkaCJxtNU70kpHraI
 Um3jCOIRxirKo4iZ5n16SHAa.8LuLXZiwgXf8Xnzah0i4Gwpa.JpF.bGaE7kBtgbpLi4_AaR5TBe
 8Ts0LBekdvovnPkFD_gVDKSilngen6yBooYERpuZsNfmrKhraPbXnN23an3NuSf6Y4bb5XbvQi6A
 z.KcBWrFVOTx6._EslrlRjmYykRFPSp25FD_uCFnuA44bLNgJmbR7Cuiq3aCOCY2voKdfEbG5y7l
 4jtcxoeqijg061hSVw5BAjbWBOAoyZlBHSMAn2q75PUARZ5c0skB54QxAOFhMihSxj71BN.64FPE
 52C_4oILdGG4kUPfOV7SBY2ooNbUEQ11QWgM0IQIS95WGZxMa2WfyMULM21yDgkOjyfpBqGbZXWh
 yM3V8EdXoc2iMge3.ZXisFYAg4qG_XrLgY9_m8KBK9_reYaY.7BlnKYt53MNHyR6O_CmVoMo7kTq
 nYQHVN_cdbKXI_EKzk8dG2XfYQ67ZIFLY1yII3AO3l.g1i5eBTOODw8YcqR9zASjEOM0mTLmb6QL
 QpZ.UKkVwcB0F7LNEpTbeXycRMk66n3n53a.449zBbtFTSbAKwL14EXk7CNbZvQYGMaLCPQNDH00
 nGVnXj7yWFl2rGEdi4folPMc0QPA6OVTLei3rGjD9B4tVV4DQ70dD6fSXW3TpdCeGxr32Y7nuGK9
 9DYGRBRIqU5QTvw_0YzvUkKEHpNZjyOKwu3Uza2P1kOnrW6PAaDnIXVxG_JNnbaOO9S8tsEVx4tQ
 cmckPWwDn38aY.2oFdgeZheyx2WDLEkz4EdRTSwVqFlS4LKN6B48YNhV5B9.a4XCXyeiD9P3nqJI
 Mj6e0tNuMJTEgMM.LL_IG4BOXljsHFqtfr7qh1idNgDz9CW5E_o9qzn0mF6JleKDobpr5yAR0iWL
 6eS4BtIalAyOSY7wqiZn6hvTFVsCHpK21kJ9jcPk.VY8_Ks4ROMgjWiNcjIrerpB8EWEi_0cn0kQ
 9D45xZqevp8IOne_n9w0FSl5QDvPQto3tGb1qGdCNNuXeTrpI_6w31JzYc9u0UW7YhoegqCd7bBE
 xKAaIfQ.GmvZ.GvQwC3sff7jZFO1Bv2JpH8uU8LCLPlOQlVBF90t1FHO8FIXU1m1o00gaEux73Yn
 LuA32UUb6Ul8HQV_R5YdIBERzXJQ0FTr8PR2y.ZhoZa__0kVm2yJB0VjB7MSW0otQqG6zUm5BV_k
 Z8E2S5xC41SEYzBoWg8yc7l7VyUaIST0kIQpwXGDx2E5lNe3da2iZl7Whe3Z7aYPj7Tfu
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic301.consmr.mail.gq1.yahoo.com with HTTP; Sat, 29 Feb 2020 04:51:42 +0000
Received: by smtp409.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 16922bddfd3cbd213433d5c12bb81660; 
 Sat, 29 Feb 2020 04:51:38 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v0.0-20200229 07/11] ez: lzma: add LZMA matchfinder
Date: Sat, 29 Feb 2020 12:50:13 +0800
Message-Id: <20200229045017.12424-8-hsiangkao@aol.com>
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

It implements HC4 matchfinder for now
with some minor optimization.

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 lzma/mf.c | 311 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 lzma/mf.h |  73 +++++++++++++
 2 files changed, 384 insertions(+)
 create mode 100644 lzma/mf.c
 create mode 100644 lzma/mf.h

diff --git a/lzma/mf.c b/lzma/mf.c
new file mode 100644
index 0000000..e7bcc40
--- /dev/null
+++ b/lzma/mf.c
@@ -0,0 +1,311 @@
+// SPDX-License-Identifier: Apache-2.0
+/*
+ * ez/lzma/mf.c - LZMA matchfinder
+ *
+ * Copyright (C) 2019-2020 Gao Xiang <hsiangkao@aol.com>
+ */
+#include <stdlib.h>
+#include <ez/unaligned.h>
+#include <ez/bitops.h>
+#include "mf.h"
+#include "bytehash.h"
+
+#define LZMA_HASH_2_SZ		(1U << 10)
+#define LZMA_HASH_3_SZ		(1U << 16)
+
+#define LZMA_HASH_3_BASE	(LZMA_HASH_2_SZ)
+#define LZMA_HASH_4_BASE	(LZMA_HASH_2_SZ + LZMA_HASH_3_SZ)
+
+static inline uint32_t mt_calc_dualhash(const uint8_t cur[2])
+{
+	return crc32_byte_hashtable[cur[0]] ^ cur[1];
+}
+
+static inline uint32_t mt_calc_hash_3(const uint8_t cur[3],
+				      const uint32_t dualhash)
+{
+	return (dualhash ^ (cur[2] << 8)) & (LZMA_HASH_3_SZ - 1);
+}
+
+static inline uint32_t mt_calc_hash_4(const uint8_t cur[4], unsigned int nbits)
+{
+	const uint32_t golden_ratio_32 = 0x61C88647;
+
+	return (get_unaligned_le32(cur) * golden_ratio_32) >> (32 - nbits);
+}
+
+/* Mark the current byte as processed from point of view of the match finder. */
+static void mf_move(struct lzma_mf *mf)
+{
+	if (mf->chaincur + 1 > mf->max_distance)
+		mf->chaincur = 0;
+	else
+		++mf->chaincur;
+
+	++mf->cur;
+	DBG_BUGON(mf->buffer + mf->cur > mf->iend);
+}
+
+static unsigned int lzma_mf_do_hc4_find(struct lzma_mf *mf,
+					struct lzma_match *matches)
+{
+	const uint32_t cur = mf->cur;
+	const uint8_t *ip = mf->buffer + cur;
+	const uint32_t pos = cur + mf->offset;
+	const uint32_t nice_len = mf->nice_len;
+	const uint8_t *ilimit =
+		ip + nice_len < mf->iend ? ip + nice_len : mf->iend;
+
+	const uint32_t dualhash = mt_calc_dualhash(ip);
+	const uint32_t hash_2 = dualhash & (LZMA_HASH_2_SZ - 1);
+	const uint32_t delta2 = pos - mf->hash[hash_2];
+	const uint32_t hash_3 = mt_calc_hash_3(ip, dualhash);
+	const uint32_t delta3 = pos - mf->hash[LZMA_HASH_3_BASE + hash_3];
+	const uint32_t hash_value = mt_calc_hash_4(ip, mf->hashbits);
+	uint32_t cur_match = mf->hash[LZMA_HASH_4_BASE + hash_value];
+	unsigned int bestlen, depth;
+	const uint8_t *matchend;
+	struct lzma_match *mp;
+
+	mf->hash[hash_2] = pos;
+	mf->hash[LZMA_HASH_3_BASE + hash_3] = pos;
+	mf->hash[LZMA_HASH_4_BASE + hash_value] = pos;
+	mf->chain[mf->chaincur] = cur_match;
+
+	mp = matches;
+	bestlen = 0;
+
+	/* check the 2-byte match */
+	if (delta2 <= mf->max_distance && *(ip - delta2) == *ip) {
+		matchend = ez_memcmp(ip + 2, ip - delta2 + 2, ilimit);
+
+		bestlen = matchend - ip;
+		*(mp++) = (struct lzma_match) { .len = bestlen,
+						.dist = delta2 };
+
+		if (matchend >= ilimit)
+			goto out;
+	}
+
+	/* check the 3-byte match */
+	if (delta2 != delta3 && delta3 <= mf->max_distance &&
+	    *(ip - delta3) == *ip) {
+		matchend = ez_memcmp(ip + 3, ip - delta3 + 3, ilimit);
+
+		if (matchend - ip > bestlen) {
+			bestlen = matchend - ip;
+			*(mp++) = (struct lzma_match) { .len = bestlen,
+							.dist = delta3 };
+
+			if (matchend >= ilimit)
+				goto out;
+		}
+	}
+
+	/* check 4 or more byte matches, traversal the whole hash chain */
+	for (depth = mf->depth; depth; --depth) {
+		const uint32_t delta = pos - cur_match;
+		const uint8_t *match = ip - delta;
+		uint32_t nextcur;
+
+		if (delta > mf->max_distance)
+			break;
+
+		nextcur = (mf->chaincur >= delta ? mf->chaincur - delta :
+			   mf->max_distance + 1 + mf->chaincur - delta);
+		cur_match = mf->chain[nextcur];
+
+		if (get_unaligned32(match) == get_unaligned32(ip) &&
+		    match[bestlen] == ip[bestlen]) {
+			matchend = ez_memcmp(ip + 4, match + 4, ilimit);
+
+			if (matchend - ip <= bestlen)
+				continue;
+
+			bestlen = matchend - ip;
+			*(mp++) = (struct lzma_match) { .len = bestlen,
+							.dist = delta };
+
+			if (matchend >= ilimit)
+				break;
+		}
+	}
+
+out:
+	return mp - matches;
+}
+
+/* aka. lzma_mf_hc4_skip */
+void lzma_mf_skip(struct lzma_mf *mf, unsigned int bytetotal)
+{
+	const unsigned int hashbits = mf->hashbits;
+	unsigned int unhashedskip = mf->unhashedskip;
+	unsigned int bytecount = 0;
+
+	if (unhashedskip) {
+		bytetotal += unhashedskip;
+		mf->cur -= unhashedskip;
+		mf->lookahead -= unhashedskip;
+		mf->unhashedskip = 0;
+	}
+
+	if (unlikely(!bytetotal))
+		return;
+
+	do {
+		const uint8_t *ip = mf->buffer + mf->cur;
+		uint32_t pos, dualhash, hash_2, hash_3, hash_value;
+
+		if (mf->iend - ip < 4) {
+			unhashedskip = bytetotal - bytecount;
+
+			mf->unhashedskip = unhashedskip;
+			mf->cur += unhashedskip;
+			break;
+		}
+
+		pos = mf->cur + mf->offset;
+
+		dualhash = mt_calc_dualhash(ip);
+		hash_2 = dualhash & (LZMA_HASH_2_SZ - 1);
+		mf->hash[hash_2] = pos;
+
+		hash_3 = mt_calc_hash_3(ip, dualhash);
+		mf->hash[LZMA_HASH_3_BASE + hash_3] = pos;
+
+		hash_value = mt_calc_hash_4(ip, hashbits);
+
+		mf->chain[mf->chaincur] =
+			mf->hash[LZMA_HASH_4_BASE + hash_value];
+		mf->hash[LZMA_HASH_4_BASE + hash_value] = pos;
+
+		mf_move(mf);
+	} while (++bytecount < bytetotal);
+
+	mf->lookahead += bytetotal;
+}
+
+static int lzma_mf_hc4_find(struct lzma_mf *mf,
+			    struct lzma_match *matches, bool finish)
+{
+	int ret;
+
+	if (mf->iend - &mf->buffer[mf->cur] < 4) {
+		if (!finish)
+			return -ERANGE;
+
+		mf->eod = true;
+		if (mf->buffer + mf->cur == mf->iend)
+			return -ERANGE;
+	}
+
+	if (!mf->eod) {
+		ret = lzma_mf_do_hc4_find(mf, matches);
+	} else {
+		ret = 0;
+		/* ++mf->unhashedskip; */
+		mf->unhashedskip = 0;	/* bypass all lzma_mf_skip(mf, 0); */
+	}
+	mf_move(mf);
+	++mf->lookahead;
+	return ret;
+}
+
+int lzma_mf_find(struct lzma_mf *mf, struct lzma_match *matches, bool finish)
+{
+	const uint8_t *ip = mf->buffer + mf->cur;
+	const uint8_t *iend = max((const uint8_t *)mf->iend,
+				  ip + kMatchMaxLen);
+	unsigned int i;
+	int ret;
+
+	/* if (mf->unhashedskip && !mf->eod) */
+	if (mf->unhashedskip)
+		lzma_mf_skip(mf, 0);
+
+	ret = lzma_mf_hc4_find(mf, matches, finish);
+	if (ret <= 0)
+		return ret;
+
+	i = ret;
+	do {
+		const uint8_t *cur = ip + matches[--i].len;
+
+		if (matches[i].len < mf->nice_len || cur >= iend)
+			break;
+
+		/* extend the candicated match as far as it can */
+		matches[i].len = ez_memcmp(cur, cur - matches[i].dist,
+					   iend) - ip;
+	} while (i);
+	return ret;
+}
+
+void lzma_mf_fill(struct lzma_mf *mf, const uint8_t *in, unsigned int size)
+{
+	DBG_BUGON(mf->buffer + mf->cur > mf->iend);
+
+	/* move the sliding window in advance if needed */
+	//if (mf->cur >= mf->size - mf->keep_size_after)
+	//	move_window(mf);
+
+	memcpy(mf->iend, in, size);
+	mf->iend += size;
+}
+
+int lzma_mf_reset(struct lzma_mf *mf, const struct lzma_mf_properties *p)
+{
+	const uint32_t dictsize = p->dictsize;
+	unsigned int new_hashbits;
+
+	if (!dictsize)
+		return -EINVAL;
+
+	if (dictsize < UINT16_MAX) {
+		new_hashbits = 16;
+	/* most significant set bit + 1 of distsize to derive hashbits */
+	} else {
+		const unsigned int hs = fls(dictsize);
+
+		new_hashbits = hs - (1 << (hs - 1) == dictsize);
+		if (new_hashbits > 31)
+			new_hashbits = 31;
+	}
+
+	if (new_hashbits != mf->hashbits ||
+	    mf->max_distance != dictsize - 1) {
+		if (mf->hash)
+			free(mf->hash);
+		if (mf->chain)
+			free(mf->chain);
+
+		mf->hashbits = 0;
+		mf->hash = calloc(LZMA_HASH_4_BASE + (1 << new_hashbits),
+				  sizeof(mf->hash[0]));
+		if (!mf->hash)
+			return -ENOMEM;
+
+		mf->chain = malloc(sizeof(mf->chain[0]) * (dictsize - 1));
+		if (!mf->chain) {
+			free(mf->hash);
+			return -ENOMEM;
+		}
+		mf->hashbits = new_hashbits;
+	}
+
+	mf->max_distance = dictsize - 1;
+	/*
+	 * Set the initial value as mf->max_distance + 1.
+	 * This would avoid hash zero initialization.
+	 */
+	mf->offset = mf->max_distance + 1;
+
+	mf->nice_len = p->nice_len;
+	mf->depth = p->depth;
+
+	mf->cur = 0;
+	mf->lookahead = 0;
+	mf->chaincur = 0;
+	return 0;
+}
+
diff --git a/lzma/mf.h b/lzma/mf.h
new file mode 100644
index 0000000..3df5043
--- /dev/null
+++ b/lzma/mf.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: Apache-2.0 */
+/*
+ * ez/lzma/mf.h - header file for LZMA matchfinder
+ *
+ * Copyright (C) 2019-2020 Gao Xiang <hsiangkao@aol.com>
+ */
+#ifndef __LZMA_MF_H
+#define __LZMA_MF_H
+
+#include <ez/util.h>
+#include "lzma_common.h"
+
+struct lzma_mf_properties {
+	uint32_t dictsize;
+
+	uint32_t nice_len, depth;
+};
+
+/*
+ * an array used used by the LZ-based encoder to hold
+ * the length-distance pairs found by LZMA matchfinder.
+ */
+struct lzma_match {
+	unsigned int len;
+	unsigned int dist;
+};
+
+struct lzma_mf {
+	/* pointer to buffer with data to be compressed */
+	uint8_t *buffer;
+
+	/* size of the whole LZMA matchbuffer */
+	uint32_t size;
+
+	uint32_t offset;
+
+	/* indicate the next byte to run through the match finder */
+	uint32_t cur;
+
+	/* maximum length of a match that the matchfinder will try to find. */
+	uint32_t nice_len;
+
+	/* indicate the first byte that doesn't contain valid input data */
+	uint8_t *iend;
+
+	/* indicate the number of bytes still not encoded */
+	uint32_t lookahead;
+
+	/* LZ matchfinder hash chain representation */
+	uint32_t *hash, *chain;
+
+	/* indicate the next byte in chain (0 ~ max_distance) */
+	uint32_t chaincur;
+	uint8_t hashbits;
+
+	/* maximum number of loops in the match finder */
+	uint8_t depth;
+
+	uint32_t max_distance;
+
+	/* the number of bytes unhashed, and wait to roll back later */
+	uint32_t unhashedskip;
+
+	bool eod;
+};
+
+int lzma_mf_find(struct lzma_mf *mf, struct lzma_match *matches, bool finish);
+void lzma_mf_skip(struct lzma_mf *mf, unsigned int n);
+void lzma_mf_fill(struct lzma_mf *mf, const uint8_t *in, unsigned int size);
+int lzma_mf_reset(struct lzma_mf *mf, const struct lzma_mf_properties *p);
+
+#endif
+
-- 
2.20.1

