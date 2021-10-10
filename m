Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5036D4283D2
	for <lists+linux-erofs@lfdr.de>; Sun, 10 Oct 2021 23:32:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HSFWb6Lprz2yPW
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Oct 2021 08:32:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QkQmpCNe;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=QkQmpCNe; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HSFWX5z5Rz2xtW
 for <linux-erofs@lists.ozlabs.org>; Mon, 11 Oct 2021 08:32:24 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0461610CC;
 Sun, 10 Oct 2021 21:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633901542;
 bh=7BGnAARcyEb/G0gC8heqvckUW8WKradIuwairXvNkEw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QkQmpCNeJ+Eh9nJ3l+oSm3Vi+74ZOG84k/vh691sDXpy5YQ9OvSXRytJNMQKt5T4r
 9WLX86fZ9sExAQwEKoeHXDvAekS+Dj7rhVtpBTMjUYkUyX2fF4r/SoO5f2VQyPnUtM
 0Ry80n/vATEAK3qsvp0YJ07zOluyQudh2wJFt6qWnQeXd4UAEkNhyWznjaDtuMh7ES
 EV8ZGsoLQoRsMscZxw4INUF3u1XMk3NV1jd83AMNGdL0IKu7HGZRrOz4PKSDguGhaY
 QQX2Mg09B1wLtx6aoYV/WIZBEM/7EInWSoR7zeCwTNKACA9VIU4axv4gLEKYW8p2r1
 9xEjjv2zqiMPw==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/7] lib/xz: Add MicroLZMA decoder
Date: Mon, 11 Oct 2021 05:31:42 +0800
Message-Id: <20211010213145.17462-5-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211010213145.17462-1-xiang@kernel.org>
References: <20211010213145.17462-1-xiang@kernel.org>
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
Cc: Lasse Collin <lasse.collin@tukaani.org>,
 Greg KH <gregkh@linuxfoundation.org>, Gao Xiang <hsiangkao@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Lasse Collin <lasse.collin@tukaani.org>

MicroLZMA is a yet another header format variant where the first
byte of a raw LZMA stream (without the end of stream marker) has
been replaced with a bitwise-negation of the lc/lp/pb properties
byte. MicroLZMA was created to be used in EROFS but can be used
by other things too where wasting minimal amount of space for
headers is important.

This is implemented using most of the LZMA2 code as is so the
amount of new code is small. The API has a few extra features
compared to the XZ decoder. On the other hand, the API lacks
XZ_BUF_ERROR support which is important to take into account
when using this API.

MicroLZMA doesn't support BCJ filters. In theory they could be
added later as there are many unused/reserved values for the
first byte of the compressed stream but in practice it is
somewhat unlikely to happen due to a few implementation reasons.

Signed-off-by: Lasse Collin <lasse.collin@tukaani.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/linux/xz.h    | 106 ++++++++++++++++++++++++++++
 lib/xz/Kconfig        |  13 ++++
 lib/xz/xz_dec_lzma2.c | 156 +++++++++++++++++++++++++++++++++++++++++-
 lib/xz/xz_dec_syms.c  |   9 ++-
 lib/xz/xz_private.h   |   3 +
 5 files changed, 284 insertions(+), 3 deletions(-)

diff --git a/include/linux/xz.h b/include/linux/xz.h
index 9884c8440188..7285ca5d56e9 100644
--- a/include/linux/xz.h
+++ b/include/linux/xz.h
@@ -233,6 +233,112 @@ XZ_EXTERN void xz_dec_reset(struct xz_dec *s);
  */
 XZ_EXTERN void xz_dec_end(struct xz_dec *s);
 
+/*
+ * Decompressor for MicroLZMA, an LZMA variant with a very minimal header.
+ * See xz_dec_microlzma_alloc() below for details.
+ *
+ * These functions aren't used or available in preboot code and thus aren't
+ * marked with XZ_EXTERN. This avoids warnings about static functions that
+ * are never defined.
+ */
+/**
+ * struct xz_dec_microlzma - Opaque type to hold the MicroLZMA decoder state
+ */
+struct xz_dec_microlzma;
+
+/**
+ * xz_dec_microlzma_alloc() - Allocate memory for the MicroLZMA decoder
+ * @mode        XZ_SINGLE or XZ_PREALLOC
+ * @dict_size   LZMA dictionary size. This must be at least 4 KiB and
+ *              at most 3 GiB.
+ *
+ * In contrast to xz_dec_init(), this function only allocates the memory
+ * and remembers the dictionary size. xz_dec_microlzma_reset() must be used
+ * before calling xz_dec_microlzma_run().
+ *
+ * The amount of allocated memory is a little less than 30 KiB with XZ_SINGLE.
+ * With XZ_PREALLOC also a dictionary buffer of dict_size bytes is allocated.
+ *
+ * On success, xz_dec_microlzma_alloc() returns a pointer to
+ * struct xz_dec_microlzma. If memory allocation fails or
+ * dict_size is invalid, NULL is returned.
+ *
+ * The compressed format supported by this decoder is a raw LZMA stream
+ * whose first byte (always 0x00) has been replaced with bitwise-negation
+ * of the LZMA properties (lc/lp/pb) byte. For example, if lc/lp/pb is
+ * 3/0/2, the first byte is 0xA2. This way the first byte can never be 0x00.
+ * Just like with LZMA2, lc + lp <= 4 must be true. The LZMA end-of-stream
+ * marker must not be used. The unused values are reserved for future use.
+ * This MicroLZMA header format was created for use in EROFS but may be used
+ * by others too.
+ */
+extern struct xz_dec_microlzma *xz_dec_microlzma_alloc(enum xz_mode mode,
+						       uint32_t dict_size);
+
+/**
+ * xz_dec_microlzma_reset() - Reset the MicroLZMA decoder state
+ * @s           Decoder state allocated using xz_dec_microlzma_alloc()
+ * @comp_size   Compressed size of the input stream
+ * @uncomp_size Uncompressed size of the input stream. A value smaller
+ *              than the real uncompressed size of the input stream can
+ *              be specified if uncomp_size_is_exact is set to false.
+ *              uncomp_size can never be set to a value larger than the
+ *              expected real uncompressed size because it would eventually
+ *              result in XZ_DATA_ERROR.
+ * @uncomp_size_is_exact  This is an int instead of bool to avoid
+ *              requiring stdbool.h. This should normally be set to true.
+ *              When this is set to false, error detection is weaker.
+ */
+extern void xz_dec_microlzma_reset(struct xz_dec_microlzma *s,
+				   uint32_t comp_size, uint32_t uncomp_size,
+				   int uncomp_size_is_exact);
+
+/**
+ * xz_dec_microlzma_run() - Run the MicroLZMA decoder
+ * @s           Decoder state initialized using xz_dec_microlzma_reset()
+ * @b:          Input and output buffers
+ *
+ * This works similarly to xz_dec_run() with a few important differences.
+ * Only the differences are documented here.
+ *
+ * The only possible return values are XZ_OK, XZ_STREAM_END, and
+ * XZ_DATA_ERROR. This function cannot return XZ_BUF_ERROR: if no progress
+ * is possible due to lack of input data or output space, this function will
+ * keep returning XZ_OK. Thus, the calling code must be written so that it
+ * will eventually provide input and output space matching (or exceeding)
+ * comp_size and uncomp_size arguments given to xz_dec_microlzma_reset().
+ * If the caller cannot do this (for example, if the input file is truncated
+ * or otherwise corrupt), the caller must detect this error by itself to
+ * avoid an infinite loop.
+ *
+ * If the compressed data seems to be corrupt, XZ_DATA_ERROR is returned.
+ * This can happen also when incorrect dictionary, uncompressed, or
+ * compressed sizes have been specified.
+ *
+ * With XZ_PREALLOC only: As an extra feature, b->out may be NULL to skip over
+ * uncompressed data. This way the caller doesn't need to provide a temporary
+ * output buffer for the bytes that will be ignored.
+ *
+ * With XZ_SINGLE only: In contrast to xz_dec_run(), the return value XZ_OK
+ * is also possible and thus XZ_SINGLE is actually a limited multi-call mode.
+ * After XZ_OK the bytes decoded so far may be read from the output buffer.
+ * It is possible to continue decoding but the variables b->out and b->out_pos
+ * MUST NOT be changed by the caller. Increasing the value of b->out_size is
+ * allowed to make more output space available; one doesn't need to provide
+ * space for the whole uncompressed data on the first call. The input buffer
+ * may be changed normally like with XZ_PREALLOC. This way input data can be
+ * provided from non-contiguous memory.
+ */
+extern enum xz_ret xz_dec_microlzma_run(struct xz_dec_microlzma *s,
+					struct xz_buf *b);
+
+/**
+ * xz_dec_microlzma_end() - Free the memory allocated for the decoder state
+ * @s:          Decoder state allocated using xz_dec_microlzma_alloc().
+ *              If s is NULL, this function does nothing.
+ */
+extern void xz_dec_microlzma_end(struct xz_dec_microlzma *s);
+
 /*
  * Standalone build (userspace build or in-kernel build for boot time use)
  * needs a CRC32 implementation. For normal in-kernel use, kernel's own
diff --git a/lib/xz/Kconfig b/lib/xz/Kconfig
index 5cb50245a878..adce22ac18d6 100644
--- a/lib/xz/Kconfig
+++ b/lib/xz/Kconfig
@@ -39,6 +39,19 @@ config XZ_DEC_SPARC
 	default y
 	select XZ_DEC_BCJ
 
+config XZ_DEC_MICROLZMA
+	bool "MicroLZMA decoder"
+	default n
+	help
+	  MicroLZMA is a header format variant where the first byte
+	  of a raw LZMA stream (without the end of stream marker) has
+	  been replaced with a bitwise-negation of the lc/lp/pb
+	  properties byte. MicroLZMA was created to be used in EROFS
+	  but can be used by other things too where wasting minimal
+	  amount of space for headers is important.
+
+	  Unless you know that you need this, say N.
+
 endif
 
 config XZ_DEC_BCJ
diff --git a/lib/xz/xz_dec_lzma2.c b/lib/xz/xz_dec_lzma2.c
index 22b789645ce5..46b186d7eb45 100644
--- a/lib/xz/xz_dec_lzma2.c
+++ b/lib/xz/xz_dec_lzma2.c
@@ -248,6 +248,10 @@ struct lzma2_dec {
 	 * before the first LZMA chunk.
 	 */
 	bool need_props;
+
+#ifdef XZ_DEC_MICROLZMA
+	bool pedantic_microlzma;
+#endif
 };
 
 struct xz_dec_lzma2 {
@@ -419,6 +423,12 @@ static void dict_uncompressed(struct dictionary *dict, struct xz_buf *b,
 	}
 }
 
+#ifdef XZ_DEC_MICROLZMA
+#	define DICT_FLUSH_SUPPORTS_SKIPPING true
+#else
+#	define DICT_FLUSH_SUPPORTS_SKIPPING false
+#endif
+
 /*
  * Flush pending data from dictionary to b->out. It is assumed that there is
  * enough space in b->out. This is guaranteed because caller uses dict_limit()
@@ -437,9 +447,14 @@ static uint32_t dict_flush(struct dictionary *dict, struct xz_buf *b)
 		 * decompression because in multi-call mode dict->buf
 		 * has been allocated by us in this file; it's not
 		 * provided by the caller like in single-call mode.
+		 *
+		 * With MicroLZMA, b->out can be NULL to skip bytes that
+		 * the caller doesn't need. This cannot be done with XZ
+		 * because it would break BCJ filters.
 		 */
-		memcpy(b->out + b->out_pos, dict->buf + dict->start,
-				copy_size);
+		if (!DICT_FLUSH_SUPPORTS_SKIPPING || b->out != NULL)
+			memcpy(b->out + b->out_pos, dict->buf + dict->start,
+					copy_size);
 	}
 
 	dict->start = dict->pos;
@@ -1190,3 +1205,140 @@ XZ_EXTERN void xz_dec_lzma2_end(struct xz_dec_lzma2 *s)
 
 	kfree(s);
 }
+
+#ifdef XZ_DEC_MICROLZMA
+/* This is a wrapper struct to have a nice struct name in the public API. */
+struct xz_dec_microlzma {
+	struct xz_dec_lzma2 s;
+};
+
+enum xz_ret xz_dec_microlzma_run(struct xz_dec_microlzma *s_ptr,
+				 struct xz_buf *b)
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
+		 * xz_dec_microlzma_reset() doesn't validate the compressed
+		 * size so we do it here. We have to limit the maximum size
+		 * to avoid integer overflows in lzma2_lzma(). 3 GiB is a nice
+		 * round number and much more than users of this code should
+		 * ever need.
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
+	/* This is to allow increasing b->out_size between calls. */
+	if (DEC_IS_SINGLE(s->dict.mode))
+		s->dict.end = b->out_size - b->out_pos;
+
+	while (true) {
+		dict_limit(&s->dict, min_t(size_t, b->out_size - b->out_pos,
+					   s->lzma2.uncompressed));
+
+		if (!lzma2_lzma(s, b))
+			return XZ_DATA_ERROR;
+
+		s->lzma2.uncompressed -= dict_flush(&s->dict, b);
+
+		if (s->lzma2.uncompressed == 0) {
+			if (s->lzma2.pedantic_microlzma) {
+				if (s->lzma2.compressed > 0 || s->lzma.len > 0
+						|| !rc_is_finished(&s->rc))
+					return XZ_DATA_ERROR;
+			}
+
+			return XZ_STREAM_END;
+		}
+
+		if (b->out_pos == b->out_size)
+			return XZ_OK;
+
+		if (b->in_pos == b->in_size
+				&& s->temp.size < s->lzma2.compressed)
+			return XZ_OK;
+	}
+}
+
+struct xz_dec_microlzma *xz_dec_microlzma_alloc(enum xz_mode mode,
+						uint32_t dict_size)
+{
+	struct xz_dec_microlzma *s;
+
+	/* Restrict dict_size to the same range as in the LZMA2 code. */
+	if (dict_size < 4096 || dict_size > (3U << 30))
+		return NULL;
+
+	s = kmalloc(sizeof(*s), GFP_KERNEL);
+	if (s == NULL)
+		return NULL;
+
+	s->s.dict.mode = mode;
+	s->s.dict.size = dict_size;
+
+	if (DEC_IS_MULTI(mode)) {
+		s->s.dict.end = dict_size;
+
+		s->s.dict.buf = vmalloc(dict_size);
+		if (s->s.dict.buf == NULL) {
+			kfree(s);
+			return NULL;
+		}
+	}
+
+	return s;
+}
+
+void xz_dec_microlzma_reset(struct xz_dec_microlzma *s, uint32_t comp_size,
+			    uint32_t uncomp_size, int uncomp_size_is_exact)
+{
+	/*
+	 * comp_size is validated in xz_dec_microlzma_run().
+	 * uncomp_size can safely be anything.
+	 */
+	s->s.lzma2.compressed = comp_size;
+	s->s.lzma2.uncompressed = uncomp_size;
+	s->s.lzma2.pedantic_microlzma = uncomp_size_is_exact;
+
+	s->s.lzma2.sequence = SEQ_PROPERTIES;
+	s->s.temp.size = 0;
+}
+
+void xz_dec_microlzma_end(struct xz_dec_microlzma *s)
+{
+	if (DEC_IS_MULTI(s->s.dict.mode))
+		vfree(s->s.dict.buf);
+
+	kfree(s);
+}
+#endif
diff --git a/lib/xz/xz_dec_syms.c b/lib/xz/xz_dec_syms.c
index 32eb3c03aede..61098c67a413 100644
--- a/lib/xz/xz_dec_syms.c
+++ b/lib/xz/xz_dec_syms.c
@@ -15,8 +15,15 @@ EXPORT_SYMBOL(xz_dec_reset);
 EXPORT_SYMBOL(xz_dec_run);
 EXPORT_SYMBOL(xz_dec_end);
 
+#ifdef CONFIG_XZ_DEC_MICROLZMA
+EXPORT_SYMBOL(xz_dec_microlzma_alloc);
+EXPORT_SYMBOL(xz_dec_microlzma_reset);
+EXPORT_SYMBOL(xz_dec_microlzma_run);
+EXPORT_SYMBOL(xz_dec_microlzma_end);
+#endif
+
 MODULE_DESCRIPTION("XZ decompressor");
-MODULE_VERSION("1.0");
+MODULE_VERSION("1.1");
 MODULE_AUTHOR("Lasse Collin <lasse.collin@tukaani.org> and Igor Pavlov");
 
 /*
diff --git a/lib/xz/xz_private.h b/lib/xz/xz_private.h
index 09360ebb510e..bf1e94ec7873 100644
--- a/lib/xz/xz_private.h
+++ b/lib/xz/xz_private.h
@@ -37,6 +37,9 @@
 #		ifdef CONFIG_XZ_DEC_SPARC
 #			define XZ_DEC_SPARC
 #		endif
+#		ifdef CONFIG_XZ_DEC_MICROLZMA
+#			define XZ_DEC_MICROLZMA
+#		endif
 #		define memeq(a, b, size) (memcmp(a, b, size) == 0)
 #		define memzero(buf, size) memset(buf, 0, size)
 #	endif
-- 
2.20.1

