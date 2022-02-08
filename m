Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D92224ADAC5
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Feb 2022 15:05:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JtPtF39fjz3bbH
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Feb 2022 01:05:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=HSfHLEoy;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1036;
 helo=mail-pj1-x1036.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=HSfHLEoy; dkim-atps=neutral
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JtPt83n1Mz3bV8
 for <linux-erofs@lists.ozlabs.org>; Wed,  9 Feb 2022 01:05:36 +1100 (AEDT)
Received: by mail-pj1-x1036.google.com with SMTP id
 t4-20020a17090a510400b001b8c4a6cd5dso2871457pjh.5
 for <linux-erofs@lists.ozlabs.org>; Tue, 08 Feb 2022 06:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4QckuieVcCbpIBg6yEDsF82ph7+9XY07Uul0VtmXnmc=;
 b=HSfHLEoy2G2jUmNwG81+gcwNDcLajwXHVeqh6HWso2mU3C075Fdb4FylUpQXtC5fjA
 WPPLWXDwOEt6U4ZVSwX4JCB4NZC75zR/lkIm5DmELHZDIIijv8SXWzIwMfMNcOXdd+5U
 S210Hmls/e3qou+HVSRDLq97wBYO1dc/zXLwM3bzo9uSuoypVWfMsq6iURnmGbX71yK6
 MY9ETlhYt/YcAUPlI3IUScIjAzuJ0NvslZvLjAOJx86bc0coWnU+CI7v9LSrBnnckzdV
 rBRr8hegFO3aRSXJjrhNC+704nUT7Tgi8qe07/GQNJQcdefvMw4ZEmOHmjjiJVnHJLMW
 bMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4QckuieVcCbpIBg6yEDsF82ph7+9XY07Uul0VtmXnmc=;
 b=px66CfeszlZvdaWkQd9RzvHkjui1Zul5Ld5P5D4ly8GSm1Rfp6+o81XezHVHNpF3lo
 HA9SejlNpqFjkauTPk46g5JNtCgIpC+MyZ3SXv5DGhUfAEt+vn3YMM3dCWaT5NWE7liM
 DV5iILkulAeuQh989AhpDXT/Ayl+/NNdgIz8rG0//TO4khuTVz8zQKPfVdoQ5GHPYKW9
 sP2dvEokiGcZgNScBOZ/zF412EcIq/VpQRRcRiag4cZDMmUOCtcnyhsNg2c6UzOWBKXN
 99A8aAm11FmDbU3rm0lmdnDdr1X4e3ZBGLxAS9fnYB/8gUS7tJxlZMIAw8HbYUcZqs0q
 l8mw==
X-Gm-Message-State: AOAM5325fmSjWMojTgSOXoOu78EBO/g3aGsh0ueWSlYYS/nZ3YvJV14x
 ZK6G+VR8PG/295Ty7fjzbY8=
X-Google-Smtp-Source: ABdhPJy/aNrJZacu0ttEJ/IeMb8qlyysIX39wxkB/Omvf81n7ZuyiP2cj3K6tkVkyhcmFKWDTPgIpA==
X-Received: by 2002:a17:90b:1802:: with SMTP id
 lw2mr1558201pjb.232.1644329134328; 
 Tue, 08 Feb 2022 06:05:34 -0800 (PST)
Received: from hjn-PC.localdomain (li1080-207.members.linode.com.
 [45.33.61.207])
 by smtp.gmail.com with ESMTPSA id pj4sm3012006pjb.43.2022.02.08.06.05.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Feb 2022 06:05:34 -0800 (PST)
From: Huang Jianan <jnhuang95@gmail.com>
To: u-boot@lists.denx.de,
	trini@konsulko.com
Subject: [PATCH v3 2/5] lib/lz4: update LZ4 decompressor module
Date: Tue,  8 Feb 2022 22:05:10 +0800
Message-Id: <20220208140513.30570-3-jnhuang95@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220208140513.30570-1-jnhuang95@gmail.com>
References: <20210823123646.9765-1-jnhuang95@gmail.com>
 <20220208140513.30570-1-jnhuang95@gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Update the LZ4 compression module based on LZ4 v1.8.3 in order to
use the newest LZ4_decompress_safe_partial() which can now decode
exactly the nb of bytes requested.

Signed-off-by: Huang Jianan <jnhuang95@gmail.com>
---
 include/u-boot/lz4.h |  49 ++++
 lib/lz4.c            | 679 +++++++++++++++++++++++++++++++------------
 lib/lz4_wrapper.c    |  23 +-
 3 files changed, 536 insertions(+), 215 deletions(-)

diff --git a/include/u-boot/lz4.h b/include/u-boot/lz4.h
index e18b39a5dc..655adbfcd1 100644
--- a/include/u-boot/lz4.h
+++ b/include/u-boot/lz4.h
@@ -21,4 +21,53 @@
  */
 int ulz4fn(const void *src, size_t srcn, void *dst, size_t *dstn);
 
+/**
+ * LZ4_decompress_safe() - Decompression protected against buffer overflow
+ * @source: source address of the compressed data
+ * @dest: output buffer address of the uncompressed data
+ *	which must be already allocated
+ * @compressedSize: is the precise full size of the compressed block
+ * @maxDecompressedSize: is the size of 'dest' buffer
+ *
+ * Decompresses data from 'source' into 'dest'.
+ * If the source stream is detected malformed, the function will
+ * stop decoding and return a negative result.
+ * This function is protected against buffer overflow exploits,
+ * including malicious data packets. It never writes outside output buffer,
+ * nor reads outside input buffer.
+ *
+ * Return: number of bytes decompressed into destination buffer
+ *	(necessarily <= maxDecompressedSize)
+ *	or a negative result in case of error
+ */
+int LZ4_decompress_safe(const char *source, char *dest,
+	int compressedSize, int maxDecompressedSize);
+
+/**
+ * LZ4_decompress_safe_partial() - Decompress a block of size 'compressedSize'
+ *	at position 'source' into buffer 'dest'
+ * @source: source address of the compressed data
+ * @dest: output buffer address of the decompressed data which must be
+ *	already allocated
+ * @compressedSize: is the precise full size of the compressed block.
+ * @targetOutputSize: the decompression operation will try
+ *	to stop as soon as 'targetOutputSize' has been reached
+ * @maxDecompressedSize: is the size of destination buffer
+ *
+ * This function decompresses a compressed block of size 'compressedSize'
+ * at position 'source' into destination buffer 'dest'
+ * of size 'maxDecompressedSize'.
+ * The function tries to stop decompressing operation as soon as
+ * 'targetOutputSize' has been reached, reducing decompression time.
+ * This function never writes outside of output buffer,
+ * and never reads outside of input buffer.
+ * It is therefore protected against malicious data packets.
+ *
+ * Return: the number of bytes decoded in the destination buffer
+ *	(necessarily <= maxDecompressedSize)
+ *	or a negative result in case of error
+ *
+ */
+int LZ4_decompress_safe_partial(const char *src, char *dst,
+	int compressedSize, int targetOutputSize, int dstCapacity);
 #endif
diff --git a/lib/lz4.c b/lib/lz4.c
index 046c34e390..5337842126 100644
--- a/lib/lz4.c
+++ b/lib/lz4.c
@@ -1,13 +1,63 @@
-// SPDX-License-Identifier: BSD-2-Clause
+// SPDX-License-Identifier: GPL 2.0+ OR BSD-2-Clause
 /*
-   LZ4 - Fast LZ compression algorithm
-   Copyright (C) 2011-2015, Yann Collet.
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
+#include <u-boot/lz4.h>
+
+#define FORCE_INLINE inline __attribute__((always_inline))
+
+static FORCE_INLINE u16 LZ4_readLE16(const void *src)
+{
+	return get_unaligned_le16(src);
+}
 
-   You can contact the author at :
-   - LZ4 source repository : https://github.com/Cyan4973/lz4
-   - LZ4 public forum : https://groups.google.com/forum/#!forum/lz4c
-*/
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
 
+static FORCE_INLINE void LZ4_write32(void *memPtr, U32 value)
+{
+	put_unaligned(value, (U32 *)memPtr);
+}
 
 /**************************************
 *  Reading and writing into memory
@@ -28,14 +78,17 @@ static void LZ4_wildCopy(void* dstPtr, const void* srcPtr, void* dstEnd)
 **************************************/
 #define MINMATCH 4
 
-#define COPYLENGTH 8
+#define WILDCOPYLENGTH 8
 #define LASTLITERALS 5
-#define MFLIMIT (COPYLENGTH+MINMATCH)
-static const int LZ4_minLength = (MFLIMIT+1);
+#define MFLIMIT (WILDCOPYLENGTH + MINMATCH)
 
-#define KB *(1 <<10)
-#define MB *(1 <<20)
-#define GB *(1U<<30)
+/*
+ * ensure it's possible to write 2 x wildcopyLength
+ * without overflowing output buffer
+ */
+#define MATCH_SAFEGUARD_DISTANCE  ((2 * WILDCOPYLENGTH) - MINMATCH)
+
+#define KB (1 <<10)
 
 #define MAXD_LOG 16
 #define MAX_DISTANCE ((1 << MAXD_LOG) - 1)
@@ -45,198 +98,438 @@ static const int LZ4_minLength = (MFLIMIT+1);
 #define RUN_BITS (8-ML_BITS)
 #define RUN_MASK ((1U<<RUN_BITS)-1)
 
+#define LZ4_STATIC_ASSERT(c)	BUILD_BUG_ON(!(c))
 
 /**************************************
 *  Local Structures and types
 **************************************/
 typedef enum { noDict = 0, withPrefix64k, usingExtDict } dict_directive;
 typedef enum { endOnOutputSize = 0, endOnInputSize = 1 } endCondition_directive;
-typedef enum { full = 0, partial = 1 } earlyEnd_directive;
+typedef enum { decode_full_block = 0, partial_decode = 1 } earlyEnd_directive;
 
+#define DEBUGLOG(l, ...) {}	/* disabled */
 
+#ifndef assert
+#define assert(condition) ((void)0)
+#endif
 
-/*******************************
-*  Decompression functions
-*******************************/
 /*
- * This generic decompression function cover all use cases.
- * It shall be instantiated several times, using different sets of directives
- * Note that it is essential this generic function is really inlined,
+ * LZ4_decompress_generic() :
+ * This generic decompression function covers all use cases.
+ * It shall be instantiated several times, using different sets of directives.
+ * Note that it is important for performance that this function really get inlined,
  * in order to remove useless branches during compilation optimization.
  */
-FORCE_INLINE int LZ4_decompress_generic(
-                 const char* const source,
-                 char* const dest,
-                 int inputSize,
-                 int outputSize,         /* If endOnInput==endOnInputSize, this value is the max size of Output Buffer. */
-
-                 int endOnInput,         /* endOnOutputSize, endOnInputSize */
-                 int partialDecoding,    /* full, partial */
-                 int targetOutputSize,   /* only used if partialDecoding==partial */
-                 int dict,               /* noDict, withPrefix64k, usingExtDict */
-                 const BYTE* const lowPrefix,  /* == dest if dict == noDict */
-                 const BYTE* const dictStart,  /* only if dict==usingExtDict */
-                 const size_t dictSize         /* note : = 0 if noDict */
-                 )
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
 {
-    /* Local Variables */
-    const BYTE* ip = (const BYTE*) source;
-    const BYTE* const iend = ip + inputSize;
-
-    BYTE* op = (BYTE*) dest;
-    BYTE* const oend = op + outputSize;
-    BYTE* cpy;
-    BYTE* oexit = op + targetOutputSize;
-    const BYTE* const lowLimit = lowPrefix - dictSize;
-
-    const BYTE* const dictEnd = (const BYTE*)dictStart + dictSize;
-    const size_t dec32table[] = {4, 1, 2, 1, 4, 4, 4, 4};
-    const size_t dec64table[] = {0, 0, 0, (size_t)-1, 0, 1, 2, 3};
-
-    const int safeDecode = (endOnInput==endOnInputSize);
-    const int checkOffset = ((safeDecode) && (dictSize < (int)(64 KB)));
-
-
-    /* Special cases */
-    if ((partialDecoding) && (oexit> oend-MFLIMIT)) oexit = oend-MFLIMIT;                         /* targetOutputSize too high => decode everything */
-    if ((endOnInput) && (unlikely(outputSize==0))) return ((inputSize==1) && (*ip==0)) ? 0 : -1;  /* Empty output buffer */
-    if ((!endOnInput) && (unlikely(outputSize==0))) return (*ip==0?1:-1);
-
-
-    /* Main Loop */
-    while (1)
-    {
-        unsigned token;
-        size_t length;
-        const BYTE* match;
-
-        /* get literal length */
-        token = *ip++;
-        if ((length=(token>>ML_BITS)) == RUN_MASK)
-        {
-            unsigned s;
-            do
-            {
-                s = *ip++;
-                length += s;
-            }
-            while (likely((endOnInput)?ip<iend-RUN_MASK:1) && (s==255));
-            if ((safeDecode) && unlikely((size_t)(op+length)<(size_t)(op))) goto _output_error;   /* overflow detection */
-            if ((safeDecode) && unlikely((size_t)(ip+length)<(size_t)(ip))) goto _output_error;   /* overflow detection */
-        }
-
-        /* copy literals */
-        cpy = op+length;
-        if (((endOnInput) && ((cpy>(partialDecoding?oexit:oend-MFLIMIT)) || (ip+length>iend-(2+1+LASTLITERALS))) )
-            || ((!endOnInput) && (cpy>oend-COPYLENGTH)))
-        {
-            if (partialDecoding)
-            {
-                if (cpy > oend) goto _output_error;                           /* Error : write attempt beyond end of output buffer */
-                if ((endOnInput) && (ip+length > iend)) goto _output_error;   /* Error : read attempt beyond end of input buffer */
-            }
-            else
-            {
-                if ((!endOnInput) && (cpy != oend)) goto _output_error;       /* Error : block decoding must stop exactly there */
-                if ((endOnInput) && ((ip+length != iend) || (cpy > oend))) goto _output_error;   /* Error : input must be consumed */
-            }
-            memcpy(op, ip, length);
-            ip += length;
-            op += length;
-            break;     /* Necessarily EOF, due to parsing restrictions */
-        }
-        LZ4_wildCopy(op, ip, cpy);
-        ip += length; op = cpy;
-
-        /* get offset */
-        match = cpy - LZ4_readLE16(ip); ip+=2;
-        if ((checkOffset) && (unlikely(match < lowLimit))) goto _output_error;   /* Error : offset outside destination buffer */
-
-        /* get matchlength */
-        length = token & ML_MASK;
-        if (length == ML_MASK)
-        {
-            unsigned s;
-            do
-            {
-                if ((endOnInput) && (ip > iend-LASTLITERALS)) goto _output_error;
-                s = *ip++;
-                length += s;
-            } while (s==255);
-            if ((safeDecode) && unlikely((size_t)(op+length)<(size_t)op)) goto _output_error;   /* overflow detection */
-        }
-        length += MINMATCH;
-
-        /* check external dictionary */
-        if ((dict==usingExtDict) && (match < lowPrefix))
-        {
-            if (unlikely(op+length > oend-LASTLITERALS)) goto _output_error;   /* doesn't respect parsing restriction */
-
-            if (length <= (size_t)(lowPrefix-match))
-            {
-                /* match can be copied as a single segment from external dictionary */
-                match = dictEnd - (lowPrefix-match);
-                memmove(op, match, length); op += length;
-            }
-            else
-            {
-                /* match encompass external dictionary and current segment */
-                size_t copySize = (size_t)(lowPrefix-match);
-                memcpy(op, dictEnd - copySize, copySize);
-                op += copySize;
-                copySize = length - copySize;
-                if (copySize > (size_t)(op-lowPrefix))   /* overlap within current segment */
-                {
-                    BYTE* const endOfMatch = op + copySize;
-                    const BYTE* copyFrom = lowPrefix;
-                    while (op < endOfMatch) *op++ = *copyFrom++;
-                }
-                else
-                {
-                    memcpy(op, lowPrefix, copySize);
-                    op += copySize;
-                }
-            }
-            continue;
-        }
-
-        /* copy repeated sequence */
-        cpy = op + length;
-        if (unlikely((op-match)<8))
-        {
-            const size_t dec64 = dec64table[op-match];
-            op[0] = match[0];
-            op[1] = match[1];
-            op[2] = match[2];
-            op[3] = match[3];
-            match += dec32table[op-match];
-            LZ4_copy4(op+4, match);
-            op += 8; match -= dec64;
-        } else { LZ4_copy8(op, match); op+=8; match+=8; }
-
-        if (unlikely(cpy>oend-12))
-        {
-            if (cpy > oend-LASTLITERALS) goto _output_error;    /* Error : last LASTLITERALS bytes must be literals */
-            if (op < oend-8)
-            {
-                LZ4_wildCopy(op, match, oend-8);
-                match += (oend-8) - op;
-                op = oend-8;
-            }
-            while (op<cpy) *op++ = *match++;
-        }
-        else
-            LZ4_wildCopy(op, match, cpy);
-        op=cpy;   /* correction */
-    }
-
-    /* end of decoding */
-    if (endOnInput)
-       return (int) (((char*)op)-dest);     /* Nb of output bytes decoded */
-    else
-       return (int) (((const char*)ip)-source);   /* Nb of input bytes read */
-
-    /* Overflow error detected */
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
 _output_error:
-    return (int) (-(((const char*)ip)-source))-1;
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
 }
diff --git a/lib/lz4_wrapper.c b/lib/lz4_wrapper.c
index ebcb5c09a2..0d2a3655a8 100644
--- a/lib/lz4_wrapper.c
+++ b/lib/lz4_wrapper.c
@@ -11,27 +11,6 @@
 #include <asm/unaligned.h>
 #include <u-boot/lz4.h>
 
-static u16 LZ4_readLE16(const void *src)
-{
-	return get_unaligned_le16(src);
-}
-static void LZ4_copy4(void *dst, const void *src)
-{
-	put_unaligned(get_unaligned((const u32 *)src), (u32 *)dst);
-}
-static void LZ4_copy8(void *dst, const void *src)
-{
-	put_unaligned(get_unaligned((const u64 *)src), (u64 *)dst);
-}
-
-typedef  uint8_t BYTE;
-typedef uint16_t U16;
-typedef uint32_t U32;
-typedef  int32_t S32;
-typedef uint64_t U64;
-
-#define FORCE_INLINE static inline __attribute__((always_inline))
-
 /* lz4.c is unaltered (except removing unrelated code) from github.com/Cyan4973/lz4. */
 #include "lz4.c"	/* #include for inlining, do not link! */
 
@@ -112,7 +91,7 @@ int ulz4fn(const void *src, size_t srcn, void *dst, size_t *dstn)
 			/* constant folding essential, do not touch params! */
 			ret = LZ4_decompress_generic(in, out, block_size,
 					end - out, endOnInputSize,
-					full, 0, noDict, out, NULL, 0);
+					decode_full_block, noDict, out, NULL, 0);
 			if (ret < 0) {
 				ret = -EPROTO;	/* decompression error */
 				break;
-- 
2.25.1

