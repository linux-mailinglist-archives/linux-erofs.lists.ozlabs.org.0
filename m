Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (unknown [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BBC3F404E
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Aug 2021 17:49:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gt0D35krwz3035
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Aug 2021 01:49:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=kjCWo90I;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102f;
 helo=mail-pj1-x102f.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=kjCWo90I; dkim-atps=neutral
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gt0Cs0jpCz2xtp
 for <linux-erofs@lists.ozlabs.org>; Mon, 23 Aug 2021 01:48:56 +1000 (AEST)
Received: by mail-pj1-x102f.google.com with SMTP id
 hv22-20020a17090ae416b0290178c579e424so10459533pjb.3
 for <linux-erofs@lists.ozlabs.org>; Sun, 22 Aug 2021 08:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bSw2Hc/8EwAr/JZnpmb+BxOCkwFKLw9E5RyhBODyGHA=;
 b=kjCWo90IaliYJ+hK6SfbJhzqdxc0pLhKUgMbQbXydilvwtg3eTnhpcBIAsDRBpgk1M
 D4b1Iowg97ugMH6SdjLTgPll9+gxVsEwSkiiplP7x6Z6TWKm2YgBnnYdIxxc50UrtT6D
 4LcHiCXag5oADi5GePMNc5xlIWUW+vF1Jhcz27rAd/WseuBU7FCBrTnuXHQ2OAJeN5vq
 ORqgSKSMWMffwws0XurDaJISpfhmVWGi18/L3bxeR+K4F3hf6CUWZXMIeirC/Pmp9k7Q
 yw+XH/XiYWHWX5cNZeYb/YNmDUJ4hLarMD8yfae5xW084HTIx0mrVF2ZN1ABDBbKombi
 LX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bSw2Hc/8EwAr/JZnpmb+BxOCkwFKLw9E5RyhBODyGHA=;
 b=eYgFqZW6TNiQ/879gS2YxRSNAaaGI0PyeboD+obPvlKF1egDNBTEzNhZuzXkggJL+5
 c9y9h7TBbkktz1w1iUaSIpa6ExbIEE55dCwQU+fwtts4vZl/MLGUWdcqKkGBvvrIFahz
 XyXugmruFII/IN13JOyLIg8Zu9RHu/kJgL/DtqUFgST7zqA8b2Br0BiXttUf6lKZ4esd
 xbXet86n/94fCzIHte8mQqbTqZ9zk0D0fgC8qtgApgDDlYP5+2Ip4slO+/6Ehm1XA6mI
 RcEo2nMiISn6EVdT1OZ8u+jZE6xW9KUULSkwcZ/TSX+wcGP7IwgzwxyXXGWq6+wyfgS4
 IJ/Q==
X-Gm-Message-State: AOAM530KBHPq+bF8/9zi8g68tOKcQG6ciLaJrY2tqhX+BJCwwYvxrOVS
 8hyNIKgn01nrJW2At/icGA3mh+tYlIXfNKJW
X-Google-Smtp-Source: ABdhPJxqX/YF9nket5scPzIjJIGBKPZtWBtWlOtqzIYaart648unynPX4T386CYjodjTDRFhC9uFag==
X-Received: by 2002:a17:90a:2c01:: with SMTP id
 m1mr5340224pjd.134.1629647333883; 
 Sun, 22 Aug 2021 08:48:53 -0700 (PDT)
Received: from hjn-PC.localdomain (li1080-207.members.linode.com.
 [45.33.61.207])
 by smtp.gmail.com with ESMTPSA id fh19sm17161901pjb.27.2021.08.22.08.48.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Aug 2021 08:48:53 -0700 (PDT)
From: Huang Jianan <jnhuang95@gmail.com>
To: u-boot@lists.denx.de
Subject: [PATCH 2/3] fs/erofs: add lz4 1.8.3 decompressor
Date: Sun, 22 Aug 2021 23:48:42 +0800
Message-Id: <20210822154843.10971-2-jnhuang95@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210822154843.10971-1-jnhuang95@gmail.com>
References: <20210822154843.10971-1-jnhuang95@gmail.com>
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
Cc: xiang@kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Huang Jianan <huangjianan@oppo.com>

In order to use the newest LZ4_decompress_safe_partial() which can
now decode exactly the nb of bytes requested.

Signed-off-by: Huang Jianan <jnhuang95@gmail.com>
---
 fs/erofs/Makefile |   3 +-
 fs/erofs/lz4.c    | 534 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/lz4.h    |   4 +
 3 files changed, 540 insertions(+), 1 deletion(-)
 create mode 100644 fs/erofs/lz4.c
 create mode 100644 fs/erofs/lz4.h

diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index 7398ab7a36..c4fc5b794e 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -4,4 +4,5 @@
 obj-$(CONFIG_$(SPL_)FS_EROFS) = fs.o \
 				super.o \
 				namei.o \
-				data.o
+				data.o \
+				lz4.o
diff --git a/fs/erofs/lz4.c b/fs/erofs/lz4.c
new file mode 100644
index 0000000000..35f67c15eb
--- /dev/null
+++ b/fs/erofs/lz4.c
@@ -0,0 +1,534 @@
+// SPDX-License-Identifier: GPL 2.0+ OR BSD-2-Clause
+/*
+ * LZ4 - Fast LZ compression algorithm
+ * Copyright (C) 2011 - 2016, Yann Collet.
+ * BSD 2 - Clause License (http://www.opensource.org/licenses/bsd - license.php)
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are
+ * met:
+ *	* Redistributions of source code must retain the above copyright
+ *	  notice, this list of conditions and the following disclaimer.
+ *	* Redistributions in binary form must reproduce the above
+ * copyright notice, this list of conditions and the following disclaimer
+ * in the documentation and/or other materials provided with the
+ * distribution.
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ * You can contact the author at :
+ *	- LZ4 homepage : http://www.lz4.org
+ *	- LZ4 source repository : https://github.com/lz4/lz4
+ */
+#include <common.h>
+#include <compiler.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/bug.h>
+#include <asm/unaligned.h>
+
+#define FORCE_INLINE inline __attribute__((always_inline))
+
+static FORCE_INLINE u16 LZ4_readLE16(const void *src)
+{
+	return get_unaligned_le16(src);
+}
+
+static FORCE_INLINE void LZ4_copy8(void *dst, const void *src)
+{
+	put_unaligned(get_unaligned((const u64 *)src), (u64 *)dst);
+}
+
+typedef  uint8_t BYTE;
+typedef uint16_t U16;
+typedef uint32_t U32;
+typedef  int32_t S32;
+typedef uint64_t U64;
+typedef uintptr_t uptrval;
+
+static FORCE_INLINE void LZ4_write32(void *memPtr, U32 value)
+{
+	put_unaligned(value, (U32 *)memPtr);
+}
+
+/**************************************
+*  Reading and writing into memory
+**************************************/
+
+/* customized version of memcpy, which may overwrite up to 7 bytes beyond dstEnd */
+static void LZ4_wildCopy(void* dstPtr, const void* srcPtr, void* dstEnd)
+{
+    BYTE* d = (BYTE*)dstPtr;
+    const BYTE* s = (const BYTE*)srcPtr;
+    BYTE* e = (BYTE*)dstEnd;
+    do { LZ4_copy8(d,s); d+=8; s+=8; } while (d<e);
+}
+
+
+/**************************************
+*  Common Constants
+**************************************/
+#define MINMATCH 4
+
+#define WILDCOPYLENGTH 8
+#define LASTLITERALS 5
+#define MFLIMIT (WILDCOPYLENGTH + MINMATCH)
+
+/*
+ * ensure it's possible to write 2 x wildcopyLength
+ * without overflowing output buffer
+ */
+#define MATCH_SAFEGUARD_DISTANCE  ((2 * WILDCOPYLENGTH) - MINMATCH)
+
+#define KB (1 <<10)
+
+#define MAXD_LOG 16
+#define MAX_DISTANCE ((1 << MAXD_LOG) - 1)
+
+#define ML_BITS  4
+#define ML_MASK  ((1U<<ML_BITS)-1)
+#define RUN_BITS (8-ML_BITS)
+#define RUN_MASK ((1U<<RUN_BITS)-1)
+
+#define LZ4_STATIC_ASSERT(c)	BUILD_BUG_ON(!(c))
+
+/**************************************
+*  Local Structures and types
+**************************************/
+typedef enum { noDict = 0, withPrefix64k, usingExtDict } dict_directive;
+typedef enum { endOnOutputSize = 0, endOnInputSize = 1 } endCondition_directive;
+typedef enum { decode_full_block = 0, partial_decode = 1 } earlyEnd_directive;
+
+#define DEBUGLOG(l, ...) {}	/* disabled */
+
+#ifndef assert
+#define assert(condition) ((void)0)
+#endif
+
+/*
+ * LZ4_decompress_generic() :
+ * This generic decompression function covers all use cases.
+ * It shall be instantiated several times, using different sets of directives.
+ * Note that it is important for performance that this function really get inlined,
+ * in order to remove useless branches during compilation optimization.
+ */
+static FORCE_INLINE int LZ4_decompress_generic(
+	 const char * const src,
+	 char * const dst,
+	 int srcSize,
+		/*
+		 * If endOnInput == endOnInputSize,
+		 * this value is `dstCapacity`
+		 */
+	 int outputSize,
+	 /* endOnOutputSize, endOnInputSize */
+	 endCondition_directive endOnInput,
+	 /* full, partial */
+	 earlyEnd_directive partialDecoding,
+	 /* noDict, withPrefix64k, usingExtDict */
+	 dict_directive dict,
+	 /* always <= dst, == dst when no prefix */
+	 const BYTE * const lowPrefix,
+	 /* only if dict == usingExtDict */
+	 const BYTE * const dictStart,
+	 /* note : = 0 if noDict */
+	 const size_t dictSize
+	 )
+{
+	const BYTE *ip = (const BYTE *) src;
+	const BYTE * const iend = ip + srcSize;
+
+	BYTE *op = (BYTE *) dst;
+	BYTE * const oend = op + outputSize;
+	BYTE *cpy;
+
+	const BYTE * const dictEnd = (const BYTE *)dictStart + dictSize;
+	static const unsigned int inc32table[8] = {0, 1, 2, 1, 0, 4, 4, 4};
+	static const int dec64table[8] = {0, 0, 0, -1, -4, 1, 2, 3};
+
+	const int safeDecode = (endOnInput == endOnInputSize);
+	const int checkOffset = ((safeDecode) && (dictSize < (int)(64 * KB)));
+
+	/* Set up the "end" pointers for the shortcut. */
+	const BYTE *const shortiend = iend -
+		(endOnInput ? 14 : 8) /*maxLL*/ - 2 /*offset*/;
+	const BYTE *const shortoend = oend -
+		(endOnInput ? 14 : 8) /*maxLL*/ - 18 /*maxML*/;
+
+	DEBUGLOG(5, "%s (srcSize:%i, dstSize:%i)", __func__,
+		 srcSize, outputSize);
+
+	/* Special cases */
+	assert(lowPrefix <= op);
+	assert(src != NULL);
+
+	/* Empty output buffer */
+	if ((endOnInput) && (unlikely(outputSize == 0)))
+		return ((srcSize == 1) && (*ip == 0)) ? 0 : -1;
+
+	if ((!endOnInput) && (unlikely(outputSize == 0)))
+		return (*ip == 0 ? 1 : -1);
+
+	if ((endOnInput) && unlikely(srcSize == 0))
+		return -1;
+
+	/* Main Loop : decode sequences */
+	while (1) {
+		size_t length;
+		const BYTE *match;
+		size_t offset;
+
+		/* get literal length */
+		unsigned int const token = *ip++;
+		length = token>>ML_BITS;
+
+		/* ip < iend before the increment */
+		assert(!endOnInput || ip <= iend);
+
+		/*
+		 * A two-stage shortcut for the most common case:
+		 * 1) If the literal length is 0..14, and there is enough
+		 * space, enter the shortcut and copy 16 bytes on behalf
+		 * of the literals (in the fast mode, only 8 bytes can be
+		 * safely copied this way).
+		 * 2) Further if the match length is 4..18, copy 18 bytes
+		 * in a similar manner; but we ensure that there's enough
+		 * space in the output for those 18 bytes earlier, upon
+		 * entering the shortcut (in other words, there is a
+		 * combined check for both stages).
+		 *
+		 * The & in the likely() below is intentionally not && so that
+		 * some compilers can produce better parallelized runtime code
+		 */
+		if ((endOnInput ? length != RUN_MASK : length <= 8)
+		   /*
+		    * strictly "less than" on input, to re-enter
+		    * the loop with at least one byte
+		    */
+		   && likely((endOnInput ? ip < shortiend : 1) &
+			     (op <= shortoend))) {
+			/* Copy the literals */
+			memcpy(op, ip, endOnInput ? 16 : 8);
+			op += length; ip += length;
+
+			/*
+			 * The second stage:
+			 * prepare for match copying, decode full info.
+			 * If it doesn't work out, the info won't be wasted.
+			 */
+			length = token & ML_MASK; /* match length */
+			offset = LZ4_readLE16(ip);
+			ip += 2;
+			match = op - offset;
+			assert(match <= op); /* check overflow */
+
+			/* Do not deal with overlapping matches. */
+			if ((length != ML_MASK) &&
+			    (offset >= 8) &&
+			    (dict == withPrefix64k || match >= lowPrefix)) {
+				/* Copy the match. */
+				memcpy(op + 0, match + 0, 8);
+				memcpy(op + 8, match + 8, 8);
+				memcpy(op + 16, match + 16, 2);
+				op += length + MINMATCH;
+				/* Both stages worked, load the next token. */
+				continue;
+			}
+
+			/*
+			 * The second stage didn't work out, but the info
+			 * is ready. Propel it right to the point of match
+			 * copying.
+			 */
+			goto _copy_match;
+		}
+
+		/* decode literal length */
+		if (length == RUN_MASK) {
+			unsigned int s;
+
+			if (unlikely(endOnInput ? ip >= iend - RUN_MASK : 0)) {
+				/* overflow detection */
+				goto _output_error;
+			}
+			do {
+				s = *ip++;
+				length += s;
+			} while (likely(endOnInput
+				? ip < iend - RUN_MASK
+				: 1) & (s == 255));
+
+			if ((safeDecode)
+			    && unlikely((uptrval)(op) +
+					length < (uptrval)(op))) {
+				/* overflow detection */
+				goto _output_error;
+			}
+			if ((safeDecode)
+			    && unlikely((uptrval)(ip) +
+					length < (uptrval)(ip))) {
+				/* overflow detection */
+				goto _output_error;
+			}
+		}
+
+		/* copy literals */
+		cpy = op + length;
+		LZ4_STATIC_ASSERT(MFLIMIT >= WILDCOPYLENGTH);
+
+		if (((endOnInput) && ((cpy > oend - MFLIMIT)
+			|| (ip + length > iend - (2 + 1 + LASTLITERALS))))
+			|| ((!endOnInput) && (cpy > oend - WILDCOPYLENGTH))) {
+			if (partialDecoding) {
+				if (cpy > oend) {
+					/*
+					 * Partial decoding :
+					 * stop in the middle of literal segment
+					 */
+					cpy = oend;
+					length = oend - op;
+				}
+				if ((endOnInput)
+					&& (ip + length > iend)) {
+					/*
+					 * Error :
+					 * read attempt beyond
+					 * end of input buffer
+					 */
+					goto _output_error;
+				}
+			} else {
+				if ((!endOnInput)
+					&& (cpy != oend)) {
+					/*
+					 * Error :
+					 * block decoding must
+					 * stop exactly there
+					 */
+					goto _output_error;
+				}
+				if ((endOnInput)
+					&& ((ip + length != iend)
+					|| (cpy > oend))) {
+					/*
+					 * Error :
+					 * input must be consumed
+					 */
+					goto _output_error;
+				}
+			}
+
+			/*
+			 * supports overlapping memory regions; only matters
+			 * for in-place decompression scenarios
+			 */
+			memmove(op, ip, length);
+			ip += length;
+			op += length;
+
+			/* Necessarily EOF, due to parsing restrictions */
+			if (!partialDecoding || (cpy == oend))
+				break;
+		} else {
+			/* may overwrite up to WILDCOPYLENGTH beyond cpy */
+			LZ4_wildCopy(op, ip, cpy);
+			ip += length;
+			op = cpy;
+		}
+
+		/* get offset */
+		offset = LZ4_readLE16(ip);
+		ip += 2;
+		match = op - offset;
+
+		/* get matchlength */
+		length = token & ML_MASK;
+
+_copy_match:
+		if ((checkOffset) && (unlikely(match + dictSize < lowPrefix))) {
+			/* Error : offset outside buffers */
+			goto _output_error;
+		}
+
+		/* costs ~1%; silence an msan warning when offset == 0 */
+		/*
+		 * note : when partialDecoding, there is no guarantee that
+		 * at least 4 bytes remain available in output buffer
+		 */
+		if (!partialDecoding) {
+			assert(oend > op);
+			assert(oend - op >= 4);
+
+			LZ4_write32(op, (U32)offset);
+		}
+
+		if (length == ML_MASK) {
+			unsigned int s;
+
+			do {
+				s = *ip++;
+
+				if ((endOnInput) && (ip > iend - LASTLITERALS))
+					goto _output_error;
+
+				length += s;
+			} while (s == 255);
+
+			if ((safeDecode)
+				&& unlikely(
+					(uptrval)(op) + length < (uptrval)op)) {
+				/* overflow detection */
+				goto _output_error;
+			}
+		}
+
+		length += MINMATCH;
+
+		/* match starting within external dictionary */
+		if ((dict == usingExtDict) && (match < lowPrefix)) {
+			if (unlikely(op + length > oend - LASTLITERALS)) {
+				/* doesn't respect parsing restriction */
+				if (!partialDecoding)
+					goto _output_error;
+				length = min(length, (size_t)(oend - op));
+			}
+
+			if (length <= (size_t)(lowPrefix - match)) {
+				/*
+				 * match fits entirely within external
+				 * dictionary : just copy
+				 */
+				memmove(op, dictEnd - (lowPrefix - match),
+					length);
+				op += length;
+			} else {
+				/*
+				 * match stretches into both external
+				 * dictionary and current block
+				 */
+				size_t const copySize = (size_t)(lowPrefix - match);
+				size_t const restSize = length - copySize;
+
+				memcpy(op, dictEnd - copySize, copySize);
+				op += copySize;
+				if (restSize > (size_t)(op - lowPrefix)) {
+					/* overlap copy */
+					BYTE * const endOfMatch = op + restSize;
+					const BYTE *copyFrom = lowPrefix;
+
+					while (op < endOfMatch)
+						*op++ = *copyFrom++;
+				} else {
+					memcpy(op, lowPrefix, restSize);
+					op += restSize;
+				}
+			}
+			continue;
+		}
+
+		/* copy match within block */
+		cpy = op + length;
+
+		/*
+		 * partialDecoding :
+		 * may not respect endBlock parsing restrictions
+		 */
+		assert(op <= oend);
+		if (partialDecoding &&
+		    (cpy > oend - MATCH_SAFEGUARD_DISTANCE)) {
+			size_t const mlen = min(length, (size_t)(oend - op));
+			const BYTE * const matchEnd = match + mlen;
+			BYTE * const copyEnd = op + mlen;
+
+			if (matchEnd > op) {
+				/* overlap copy */
+				while (op < copyEnd)
+					*op++ = *match++;
+			} else {
+				memcpy(op, match, mlen);
+			}
+			op = copyEnd;
+			if (op == oend)
+				break;
+			continue;
+		}
+
+		if (unlikely(offset < 8)) {
+			op[0] = match[0];
+			op[1] = match[1];
+			op[2] = match[2];
+			op[3] = match[3];
+			match += inc32table[offset];
+			memcpy(op + 4, match, 4);
+			match -= dec64table[offset];
+		} else {
+			LZ4_copy8(op, match);
+			match += 8;
+		}
+
+		op += 8;
+
+		if (unlikely(cpy > oend - MATCH_SAFEGUARD_DISTANCE)) {
+			BYTE * const oCopyLimit = oend - (WILDCOPYLENGTH - 1);
+
+			if (cpy > oend - LASTLITERALS) {
+				/*
+				 * Error : last LASTLITERALS bytes
+				 * must be literals (uncompressed)
+				 */
+				goto _output_error;
+			}
+
+			if (op < oCopyLimit) {
+				LZ4_wildCopy(op, match, oCopyLimit);
+				match += oCopyLimit - op;
+				op = oCopyLimit;
+			}
+			while (op < cpy)
+				*op++ = *match++;
+		} else {
+			LZ4_copy8(op, match);
+			if (length > 16)
+				LZ4_wildCopy(op + 8, match + 8, cpy);
+		}
+		op = cpy; /* wildcopy correction */
+	}
+
+	/* end of decoding */
+	if (endOnInput) {
+		/* Nb of output bytes decoded */
+		return (int) (((char *)op) - dst);
+	} else {
+		/* Nb of input bytes read */
+		return (int) (((const char *)ip) - src);
+	}
+
+	/* Overflow error detected */
+_output_error:
+	return (int) (-(((const char *)ip) - src)) - 1;
+}
+
+int LZ4_decompress_safe(const char *source, char *dest,
+	int compressedSize, int maxDecompressedSize)
+{
+	return LZ4_decompress_generic(source, dest,
+				      compressedSize, maxDecompressedSize,
+				      endOnInputSize, decode_full_block,
+				      noDict, (BYTE *)dest, NULL, 0);
+}
+
+int LZ4_decompress_safe_partial(const char *src, char *dst,
+	int compressedSize, int targetOutputSize, int dstCapacity)
+{
+	dstCapacity = min(targetOutputSize, dstCapacity);
+	return LZ4_decompress_generic(src, dst, compressedSize, dstCapacity,
+				      endOnInputSize, partial_decode,
+				      noDict, (BYTE *)dst, NULL, 0);
+}
diff --git a/fs/erofs/lz4.h b/fs/erofs/lz4.h
new file mode 100644
index 0000000000..0b4bdf4fbe
--- /dev/null
+++ b/fs/erofs/lz4.h
@@ -0,0 +1,4 @@
+int LZ4_decompress_safe(const char *source, char *dest,
+	int compressedSize, int maxDecompressedSize);
+int LZ4_decompress_safe_partial(const char *src, char *dst,
+	int compressedSize, int targetOutputSize, int dstCapacity);
-- 
2.25.1

