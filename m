Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEB517B422
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Mar 2020 03:03:31 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48YW9s1MR7zDqs6
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Mar 2020 13:03:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1583460209;
	bh=z+b7b5/kmhmGC6i59vDh1u2SgkTKRDg2K3YfjcFtDW4=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=ROgZDVPag2twJPrbBi4hGZZh4mSrfIJvsauJh1CFdEdf8TSporCJN5rxwpehq1AyE
	 rkwTC7QjwLQP8EBIXgdp0NQzXF/E6vUIpxx+yRcGvOZaSA9YVBxQvJmTXc+Rekabrf
	 dtm9v0L6fte0Ekk92ZWquZkdBacdqQpI6yKzws76MKO2oc3lmrvHwwqDQqRyVkQ3jH
	 vP9nOUcEF2kUc1u4wlsL/gQ72poHkUhCa+JZop4Ib1CgvjbODBnDtiHX8CMQeK16vz
	 ra+gzKLEKqFk96Ut3pnwLH+xz/73CKyyKLD5AeaAQ0Q97D4dlmDji34GcRvZfayTDR
	 ty6JKlx6D5d3g==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.31; helo=sonic315-55.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=Eh0etmUE; dkim-atps=neutral
Received: from sonic315-55.consmr.mail.gq1.yahoo.com
 (sonic315-55.consmr.mail.gq1.yahoo.com [98.137.65.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48YW9f6R7NzDqr6
 for <linux-erofs@lists.ozlabs.org>; Fri,  6 Mar 2020 13:03:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1583460193; bh=HcBCpILXva6mmy8UjDuUNAyz5ABweM8QXSKCnaA3vPI=;
 h=From:To:Cc:Subject:Date:References:From:Subject;
 b=Eh0etmUEmydxVreX0hmvps8xrlmRwKttRed/GdB+xUzLQ9ZbXLmrrhTzQExf6O1cmD+ceff0g9KloQBB7P//M/+vHshJxwuvsGOwbEn5/WI1elUHbvFzNgUAgVSSB30g3s/gd86nIJJV1uIOr4b2aMReydarJenStNwMRqYFRL2rUw2C0NUyG32AHylNif7+Mf8BqjOtsDkehEtiUv8fvXfOnvYI3eqTszydNJScT8otLgeGrY4RVX3L+A862OZpF9yVdUtCZQKd4Rr7nbGYiUvPgIofHrmBQ6FpvJBVk0rfGbqNIt4ktKesZ3Urdzfh1MP9BXKdcZvg0XLIjYB7KQ==
X-YMail-OSG: oafx3nEVM1ll4CCvgJ3gaiq0gUUr7I_2SpJ.j9FrHtFKQKMmWdf0sGVFnxlIx4Y
 PgP5ntYzjfIkLSZ7Rf90j7kkT0tkJ7AHfkfvjju5sTzF_VGtu5pcm40tAZQj4P0vodS0BUX5oeCV
 DPdMrJ5zTTRF6qHci5dmkB08_7us_tANCtbshOwOo8nkr.q6wEoTMAghoTIjsNRla9OrnFsrOoLZ
 Ho3GF4fmeuhwRZoL1tgCyzu4P2QV_L2TGZVNjMDSMWv.ljdPLDXWPmDniMW84xHVEtuwqpzgUmP3
 tG_Y1IcDs4NpsVMoqzk15MzdJszu_WOSItIm5f7sKCOQM2s07R67M_1.fjUDCaLTVNXelws0rPaG
 UiGUDTJ9hWkavsTk2tqt6cSD8h6viv1HH4M27idDQKScTSRByUYrdi__Mgc1_o3riQqSzyYAsSE6
 RHSKSFhNJQOctDPxOMDfCueyNJzqzqSStxmkYzfUsAl8F2Y.mGbMAm0JQhMx2SBOEYaGtkNho20k
 kjOipmZFk8Nc5NAwhuccyIK7dSLopdyPmisLN2V7su74KD1XQM_2HnsJG__GOHY1a1XdFtPJ1okz
 cR9BQIidDv1RikInaOcg0KNyeWk_zBl0xlDWh.U6lffU4Ch85lFMQeZW_s47Wp_DyqQ9Jizd.EAo
 yo_77KQuQCrlhIRatapJWbj5NgLKyGKnzNf0RdipqY932n8JqDDHr5IxwOIRsSocMUDq6Xfj8uVr
 ARtjjUl92rDO26x6HhRJcb1WzBOjyo7M5zNXXLPcVceXCjgmgy3oQUEVkOpS_bkQDqz_6Rl26trU
 TMNz_ImnqDmbxTtCJyEUHBgUHlTm2UsHffKi24zzC.5VN7iK17fDEG6zQIWziRVaUUzVdiZkizTf
 dOh7._A1A_ISmTRMEUeilyfd_5jlmTzdBdoUp8B5dvsSUE988ZrKDK9_Ws6BpxWb4EKDU0Kx1sEa
 kbxMhJk9NOdoEiHg2cbTyFDT8qgSpO22T_RdxVTo5t3YpJhSMmgFPfOwFhB6PuhiWhCyCEMPUIMA
 j1CqPkSqmBVRJW3KC8D9RoOpViRQvJgwoQlJ4BseC92BkpcV.CUgXuTWrD3MGMjryqE.DquL0aZ6
 FKmwwuNGqgtyUctV6SsiI9zd9WKDSQH_f5Htb5qWlPrFILD7MOVUsO94qHpoLkowmXR4Li__AZUz
 tUwtmDGjkyoRscrqeEcPcaWhY28PLFPBpQ1Uh8OTX5SB7QzS4pzUTYqwlU32HooyNQnHbA6ceHTr
 HNOq4tAlX7pvYtmeSo44SQVVgR04yvUB6O33N25UyAF46IzslRYorneoep0SGfCbUi3Joif66i53
 eoyR6n.dm446ITIo_8_.lYiRzpTcXjDOczQc8nKUOhaBIxB4yTScN.D9kCohrIPwK7dFkJoUqR_d
 2dTcqItfK5xFgaz9.PoF.kOJc
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic315.consmr.mail.gq1.yahoo.com with HTTP; Fri, 6 Mar 2020 02:03:13 +0000
Received: by smtp401.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID d4f812450c4d83a23f1404ad2d2d7df4; 
 Fri, 06 Mar 2020 02:03:09 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [RFC PATCH] lib/xz: preliminary EROFS LZMA support v0.2
Date: Fri,  6 Mar 2020 10:02:52 +0800
Message-Id: <20200306020252.9041-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20200306020252.9041-1-hsiangkao.ref@aol.com>
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

From: Lasse Collin <lasse.collin@tukaani.org>

Here is the preliminary XZ embedded patch for EROFS
from Lasse Collin. Just for archiving only as well.
Note that it's *not* a final formal patch and I send
it to linux-erofs mailing list only for now.

And the brief outline of our discussion for reference:
EROFS would use raw LZMA format, which means no LZMA/
LZMA2/XZ headers and no LZMA EOPM as well since EROFS
records all uncompressed sizes. The initial raw LZMA
byte (0x00) will be used to store lc/lp/pb and for
later BCJ filters.

Cc: Lasse Collin <lasse.collin@tukaani.org>
[ Currently no Signed-off-by: here. ]
---
 include/linux/xz.h    |  83 +++++++++++++++++++++++++++++
 lib/xz/Kconfig        |   4 ++
 lib/xz/xz_dec_lzma2.c | 120 ++++++++++++++++++++++++++++++++++++++++++
 lib/xz/xz_dec_syms.c  |   9 +++-
 lib/xz/xz_private.h   |   3 ++
 5 files changed, 218 insertions(+), 1 deletion(-)

diff --git a/include/linux/xz.h b/include/linux/xz.h
index 64cffa6ddfce..c1cb2abe9fe7 100644
--- a/include/linux/xz.h
+++ b/include/linux/xz.h
@@ -233,6 +233,89 @@ XZ_EXTERN void xz_dec_reset(struct xz_dec *s);
  */
 XZ_EXTERN void xz_dec_end(struct xz_dec *s);
 
+/*
+ * Decompressor for the LZMA variant in EROFS
+ *
+ * These functions aren't used or available in preboot code and thus aren't
+ * marked with XZ_EXTERN. This avoids warnings about static functions that
+ * are never defined.
+ */
+/**
+ * struct xz_dec_erofs_lzma - Opaque type to hold the EROFS LZMA decoder state
+ */
+struct xz_dec_erofs_lzma;
+
+/**
+ * xz_dec_erofs_lzma_alloc() - Allocate memory for the EROFS LZMA decoder
+ * @dict_size   LZMA dictionary size. This must be at least 4 KiB and
+ *              at most 3 GiB.
+ *
+ * In contrast to xz_dec_init(), this function only allocates the memory (less
+ * than 30 KiB) and remembers the dictionary size. xz_dec_erofs_lzma_reset()
+ * must be used before calling xz_dec_erofs_lzma_run().
+ *
+ * On success, xz_dec_erofs_lzma_alloc() returns a pointer to
+ * struct xz_dec_erofs_lzma. If memory allocation fails or
+ * dict_size is invalid, NULL is returned.
+ */
+extern struct xz_dec_erofs_lzma *xz_dec_erofs_lzma_alloc(uint32_t dict_size);
+
+/**
+ * xz_dec_erofs_lzma_reset() - Reset the EROFS LZMA decoder state
+ * @s           Decoder state allocated using xz_dec_erofs_alloc()
+ * @uncomp_size Uncompressed size of the input stream
+ * @comp_size   Compressed size of the input stream
+ */
+extern void xz_dec_erofs_lzma_reset(struct xz_dec_erofs_lzma *s,
+				    uint32_t uncomp_size, uint32_t comp_size);
+
+/**
+ * xz_dec_erofs_lzma_run() - Run the EROFS LZMA decoder
+ * @s           Decoder state initialized using xz_dec_erofs_lzma_reset()
+ * @b:          Input and output buffers
+ *
+ * This works the same way as xz_dec_run() in single-call mode (XZ_SINGLE)
+ * except this may also return XZ_OK. After XZ_OK the bytes decoded so far
+ * may be read from the output buffer. It is also possible to continue
+ * decoding but the variables b->out, b->out_pos, and b->out_size MUST NOT
+ * be changed by the caller. The input buffer may be changed normally (like
+ * with xz_dec_run() in multi-call mode). This way input data can be provided
+ * from non-contiguous memory. The output space must still be contiguous
+ * and it must be provided as a whole on the first call to this function.
+ *
+ * It is OK to provide an output buffer smaller than the uncompressed size.
+ * In this case XZ_BUF_ERROR is returned once the output buffer is full.
+ * If an undersided output buffer is used intentionally, XZ_BUF_ERROR can
+ * be treated like XZ_STREAM_END.
+ *
+ * If output buffer is at least as big as the specified uncompressed size,
+ * then XZ_STREAM_END is returned when uncompressed size number of bytes
+ * have been decoded.
+ *
+ * If the compressed data seems to be corrupt, XZ_DATA_ERROR is returned.
+ * This can happen also when incorrect dictionary, uncompressed, or
+ * compressed sizes have been specified.
+ *
+ * Return values other than XZ_STREAM_END, XZ_BUF_ERROR, XZ_OK, and
+ * XZ_DATA_ERROR are not possible.
+ *
+ * The compressed format supported by this decoder is a raw LZMA stream
+ * whose first byte (always 0x00) has been replaced with bitwise-negation
+ * of the the LZMA properties (lc/lp/pb) byte. For example, if lc/lp/pb is
+ * 3/0/2, the first byte is 0xA2. This way the first byte can never be 0x00.
+ * Just like with LZMA2, lc + lp <= 4 must be true. The LZMA end-of-stream
+ * marker must not be used.
+ */
+extern enum xz_ret xz_dec_erofs_lzma_run(struct xz_dec_erofs_lzma *s,
+					 struct xz_buf *b);
+
+/**
+ * xz_dec_erofs_lzma_end() - Free the memory allocated for the decoder state
+ * @s:          Decoder state allocated using xz_dec_erofs_alloc().
+ *              If s is NULL, this function does nothing.
+ */
+extern void xz_dec_erofs_lzma_end(struct xz_dec_erofs_lzma *s);
+
 /*
  * Standalone build (userspace build or in-kernel build for boot time use)
  * needs a CRC32 implementation. For normal in-kernel use, kernel's own
diff --git a/lib/xz/Kconfig b/lib/xz/Kconfig
index 22528743d4ce..27c64e0e55fc 100644
--- a/lib/xz/Kconfig
+++ b/lib/xz/Kconfig
@@ -45,6 +45,10 @@ config XZ_DEC_BCJ
 	bool
 	default n
 
+config XZ_DEC_EROFS_LZMA
+	bool
+	default n
+
 config XZ_DEC_TEST
 	tristate "XZ decompressor tester"
 	default n
diff --git a/lib/xz/xz_dec_lzma2.c b/lib/xz/xz_dec_lzma2.c
index 156f26fdc4c9..5040ff5734c8 100644
--- a/lib/xz/xz_dec_lzma2.c
+++ b/lib/xz/xz_dec_lzma2.c
@@ -1174,3 +1174,123 @@ XZ_EXTERN void xz_dec_lzma2_end(struct xz_dec_lzma2 *s)
 
 	kfree(s);
 }
+
+#ifdef XZ_DEC_EROFS_LZMA
+/* This is a wrapper struct to have a nice struct name in the public API. */
+struct xz_dec_erofs_lzma {
+	struct xz_dec_lzma2 s;
+};
+
+enum xz_ret xz_dec_erofs_lzma_run(struct xz_dec_erofs_lzma *s_ptr,
+				  struct xz_buf *b)
+{
+	struct xz_dec_lzma2 *s = &s_ptr->s;
+
+	/*
+	 * sequence is SEQ_PROPERTIES before the first input byte,
+	 * SEQ_LZMA_PREPARE until a total of five bytes have been read,
+	 * and SEQ_LZMA_RUN for the rest of the input stream.
+	 */
+	if (s->lzma2.sequence != SEQ_LZMA_RUN) {
+		if (s->lzma2.sequence == SEQ_PROPERTIES) {
+			/* One byte is needed for the props. */
+			if (b->in_pos >= b->in_size)
+				return XZ_OK;
+
+			/*
+			 * Don't increment b->in_pos here. The same byte is
+			 * also passed to rc_read_init() which will ignore it.
+			 */
+			if (!lzma_props(s, ~b->in[b->in_pos]))
+				return XZ_DATA_ERROR;
+
+			s->lzma2.sequence = SEQ_LZMA_PREPARE;
+		}
+
+		/*
+		 * xz_dec_erofs_lzma_reset() doesn't validate the compressed
+		 * size so we do it here. We have to limit the maximum size
+		 * to avoid integer overflows in lzma2_lzma(). 3 GiB is a nice
+		 * round number and much more than EROFS may ever need.
+		 */
+		if (s->lzma2.compressed < RC_INIT_BYTES
+				|| s->lzma2.compressed > (3U << 30))
+			return XZ_DATA_ERROR;
+
+		if (!rc_read_init(&s->rc, b))
+			return XZ_OK;
+
+		s->lzma2.compressed -= RC_INIT_BYTES;
+		s->lzma2.sequence = SEQ_LZMA_RUN;
+
+		dict_reset(&s->dict, b);
+	}
+
+	/*
+	 * The output buffer is used as the dictionary, thus the dictionary
+	 * cannot wrap. So this can be outside of the loop below.
+	 */
+	dict_limit(&s->dict, min_t(size_t, b->out_size - b->out_pos,
+				   s->lzma2.uncompressed));
+
+	while (true) {
+		if (!lzma2_lzma(s, b))
+			return XZ_DATA_ERROR;
+
+		s->lzma2.uncompressed -= dict_flush(&s->dict, b);
+
+		if (s->lzma2.uncompressed == 0) {
+			if (s->lzma2.compressed > 0 || s->lzma.len > 0
+					|| !rc_is_finished(&s->rc))
+				return XZ_DATA_ERROR;
+
+			return XZ_STREAM_END;
+		}
+
+		if (b->out_pos == b->out_size)
+			return XZ_BUF_ERROR;
+
+		if (b->in_pos == b->in_size
+				&& s->temp.size < s->lzma2.compressed)
+			return XZ_OK;
+	}
+}
+
+struct xz_dec_erofs_lzma *xz_dec_erofs_lzma_alloc(uint32_t dict_size)
+{
+	struct xz_dec_erofs_lzma *s;
+
+	/* Restrict dict_size to the same range as in the LZMA2 code. */
+	if (dict_size < 4096 || dict_size > (3U << 30))
+		return NULL;
+
+	s = kmalloc(sizeof(*s), GFP_KERNEL);
+	if (s == NULL)
+		return NULL;
+
+	s->s.dict.mode = XZ_SINGLE;
+	s->s.dict.size = dict_size;
+	return s;
+}
+
+void xz_dec_erofs_lzma_reset(struct xz_dec_erofs_lzma *s,
+			     uint32_t uncomp_size, uint32_t comp_size)
+{
+	/*
+	 * uncomp_size can safely be anything.
+	 * comp_size is validated in xz_dec_erofs_lzma_run().
+	 */
+	s->s.lzma2.uncompressed = uncomp_size;
+	s->s.lzma2.compressed = comp_size;
+
+	/* FIXME? Move .len = 0 to lzma_reset(). */
+	s->s.lzma.len = 0;
+	s->s.lzma2.sequence = SEQ_PROPERTIES;
+	s->s.temp.size = 0;
+}
+
+void xz_dec_erofs_lzma_end(struct xz_dec_erofs_lzma *s)
+{
+	kfree(s);
+}
+#endif
diff --git a/lib/xz/xz_dec_syms.c b/lib/xz/xz_dec_syms.c
index 32eb3c03aede..a5b58205553e 100644
--- a/lib/xz/xz_dec_syms.c
+++ b/lib/xz/xz_dec_syms.c
@@ -15,8 +15,15 @@ EXPORT_SYMBOL(xz_dec_reset);
 EXPORT_SYMBOL(xz_dec_run);
 EXPORT_SYMBOL(xz_dec_end);
 
+#ifdef CONFIG_XZ_DEC_EROFS_LZMA
+EXPORT_SYMBOL(xz_dec_erofs_lzma_alloc);
+EXPORT_SYMBOL(xz_dec_erofs_lzma_reset);
+EXPORT_SYMBOL(xz_dec_erofs_lzma_run);
+EXPORT_SYMBOL(xz_dec_erofs_lzma_end);
+#endif
+
 MODULE_DESCRIPTION("XZ decompressor");
-MODULE_VERSION("1.0");
+MODULE_VERSION("1.1");
 MODULE_AUTHOR("Lasse Collin <lasse.collin@tukaani.org> and Igor Pavlov");
 
 /*
diff --git a/lib/xz/xz_private.h b/lib/xz/xz_private.h
index 09360ebb510e..74fe97874b1b 100644
--- a/lib/xz/xz_private.h
+++ b/lib/xz/xz_private.h
@@ -37,6 +37,9 @@
 #		ifdef CONFIG_XZ_DEC_SPARC
 #			define XZ_DEC_SPARC
 #		endif
+#		ifdef CONFIG_XZ_DEC_EROFS_LZMA
+#			define XZ_DEC_EROFS_LZMA
+#		endif
 #		define memeq(a, b, size) (memcmp(a, b, size) == 0)
 #		define memzero(buf, size) memset(buf, 0, size)
 #	endif
-- 
2.20.1

