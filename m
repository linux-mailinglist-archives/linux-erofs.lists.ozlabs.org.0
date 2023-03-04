Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FBE6AAC41
	for <lists+linux-erofs@lfdr.de>; Sat,  4 Mar 2023 20:58:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PTbHk2mynz2ygG
	for <lists+linux-erofs@lfdr.de>; Sun,  5 Mar 2023 06:58:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PTbHc75WBz2ygG
	for <linux-erofs@lists.ozlabs.org>; Sun,  5 Mar 2023 06:58:20 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vd47ETC_1677959895;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vd47ETC_1677959895)
          by smtp.aliyun-inc.com;
          Sun, 05 Mar 2023 03:58:16 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/5] erofs-utils: switch sha256 algorithm directly from LibTomCrypt
Date: Sun,  5 Mar 2023 03:58:09 +0800
Message-Id: <20230304195812.120063-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230304195812.120063-1-hsiangkao@linux.alibaba.com>
References: <20230304195732.119053-1-hsiangkao@linux.alibaba.com>
 <20230304195812.120063-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

LibTomCrypt was released into public domain so that we don't need
to worry about license issues against Apache-2.0 later.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/blobchunk.c |   4 +-
 lib/dedupe.c    |   4 +-
 lib/sha256.c    | 306 ++++++++++++++++++++++++------------------------
 lib/sha256.h    |  21 ++++
 4 files changed, 176 insertions(+), 159 deletions(-)
 create mode 100644 lib/sha256.h

diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 55e3f85..3ff0f48 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -10,11 +10,9 @@
 #include "erofs/block_list.h"
 #include "erofs/cache.h"
 #include "erofs/io.h"
+#include "sha256.h"
 #include <unistd.h>
 
-void erofs_sha256(const unsigned char *in, unsigned long in_size,
-		  unsigned char out[32]);
-
 struct erofs_blobchunk {
 	struct hashmap_entry ent;
 	char		sha256[32];
diff --git a/lib/dedupe.c b/lib/dedupe.c
index 9cad905..7f6e56f 100644
--- a/lib/dedupe.c
+++ b/lib/dedupe.c
@@ -6,9 +6,7 @@
 #include "erofs/print.h"
 #include "rb_tree.h"
 #include "rolling_hash.h"
-
-void erofs_sha256(const unsigned char *in, unsigned long in_size,
-		  unsigned char out[32]);
+#include "sha256.h"
 
 static unsigned int window_size, rollinghash_rm;
 static struct rb_tree *dedupe_tree, *dedupe_subtree;
diff --git a/lib/sha256.c b/lib/sha256.c
index dd0e058..9bb7fbb 100644
--- a/lib/sha256.c
+++ b/lib/sha256.c
@@ -1,49 +1,45 @@
+// SPDX-License-Identifier: Unlicense
 /*
  * sha256.c --- The sha256 algorithm
  *
- * Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>
- * (copied from libtomcrypt and then relicensed under GPLv2)
- *
- * %Begin-Header%
- * This file may be redistributed under the terms of the GNU Library
- * General Public License, version 2.
- * %End-Header%
+ * (copied from LibTomCrypt with adaption.)
  */
-#include "erofs/defs.h"
+#include "sha256.h"
 #include <string.h>
 
-static const __u32 K[64] = {
-    0x428a2f98UL, 0x71374491UL, 0xb5c0fbcfUL, 0xe9b5dba5UL, 0x3956c25bUL,
-    0x59f111f1UL, 0x923f82a4UL, 0xab1c5ed5UL, 0xd807aa98UL, 0x12835b01UL,
-    0x243185beUL, 0x550c7dc3UL, 0x72be5d74UL, 0x80deb1feUL, 0x9bdc06a7UL,
-    0xc19bf174UL, 0xe49b69c1UL, 0xefbe4786UL, 0x0fc19dc6UL, 0x240ca1ccUL,
-    0x2de92c6fUL, 0x4a7484aaUL, 0x5cb0a9dcUL, 0x76f988daUL, 0x983e5152UL,
-    0xa831c66dUL, 0xb00327c8UL, 0xbf597fc7UL, 0xc6e00bf3UL, 0xd5a79147UL,
-    0x06ca6351UL, 0x14292967UL, 0x27b70a85UL, 0x2e1b2138UL, 0x4d2c6dfcUL,
-    0x53380d13UL, 0x650a7354UL, 0x766a0abbUL, 0x81c2c92eUL, 0x92722c85UL,
-    0xa2bfe8a1UL, 0xa81a664bUL, 0xc24b8b70UL, 0xc76c51a3UL, 0xd192e819UL,
-    0xd6990624UL, 0xf40e3585UL, 0x106aa070UL, 0x19a4c116UL, 0x1e376c08UL,
-    0x2748774cUL, 0x34b0bcb5UL, 0x391c0cb3UL, 0x4ed8aa4aUL, 0x5b9cca4fUL,
-    0x682e6ff3UL, 0x748f82eeUL, 0x78a5636fUL, 0x84c87814UL, 0x8cc70208UL,
-    0x90befffaUL, 0xa4506cebUL, 0xbef9a3f7UL, 0xc67178f2UL
+/* This is based on SHA256 implementation in LibTomCrypt that was released into
+ * public domain by Tom St Denis. */
+/* the K array */
+static const unsigned long K[64] = {
+	0x428a2f98UL, 0x71374491UL, 0xb5c0fbcfUL, 0xe9b5dba5UL, 0x3956c25bUL,
+	0x59f111f1UL, 0x923f82a4UL, 0xab1c5ed5UL, 0xd807aa98UL, 0x12835b01UL,
+	0x243185beUL, 0x550c7dc3UL, 0x72be5d74UL, 0x80deb1feUL, 0x9bdc06a7UL,
+	0xc19bf174UL, 0xe49b69c1UL, 0xefbe4786UL, 0x0fc19dc6UL, 0x240ca1ccUL,
+	0x2de92c6fUL, 0x4a7484aaUL, 0x5cb0a9dcUL, 0x76f988daUL, 0x983e5152UL,
+	0xa831c66dUL, 0xb00327c8UL, 0xbf597fc7UL, 0xc6e00bf3UL, 0xd5a79147UL,
+	0x06ca6351UL, 0x14292967UL, 0x27b70a85UL, 0x2e1b2138UL, 0x4d2c6dfcUL,
+	0x53380d13UL, 0x650a7354UL, 0x766a0abbUL, 0x81c2c92eUL, 0x92722c85UL,
+	0xa2bfe8a1UL, 0xa81a664bUL, 0xc24b8b70UL, 0xc76c51a3UL, 0xd192e819UL,
+	0xd6990624UL, 0xf40e3585UL, 0x106aa070UL, 0x19a4c116UL, 0x1e376c08UL,
+	0x2748774cUL, 0x34b0bcb5UL, 0x391c0cb3UL, 0x4ed8aa4aUL, 0x5b9cca4fUL,
+	0x682e6ff3UL, 0x748f82eeUL, 0x78a5636fUL, 0x84c87814UL, 0x8cc70208UL,
+	0x90befffaUL, 0xa4506cebUL, 0xbef9a3f7UL, 0xc67178f2UL
 };
-
 /* Various logical functions */
+#define RORc(x, y) \
+( ((((unsigned long) (x) & 0xFFFFFFFFUL) >> (unsigned long) ((y) & 31)) | \
+   ((unsigned long) (x) << (unsigned long) (32 - ((y) & 31)))) & 0xFFFFFFFFUL)
 #define Ch(x,y,z)       (z ^ (x & (y ^ z)))
 #define Maj(x,y,z)      (((x | y) & z) | (x & y))
-#define S(x, n)         RORc((x),(n))
+#define S(x, n)         RORc((x), (n))
 #define R(x, n)         (((x)&0xFFFFFFFFUL)>>(n))
 #define Sigma0(x)       (S(x, 2) ^ S(x, 13) ^ S(x, 22))
 #define Sigma1(x)       (S(x, 6) ^ S(x, 11) ^ S(x, 25))
 #define Gamma0(x)       (S(x, 7) ^ S(x, 18) ^ R(x, 3))
 #define Gamma1(x)       (S(x, 17) ^ S(x, 19) ^ R(x, 10))
-#define RORc(x, y) ( ((((__u32)(x)&0xFFFFFFFFUL)>>(__u32)((y)&31)) | ((__u32)(x)<<(__u32)(32-((y)&31)))) & 0xFFFFFFFFUL)
-
-#define RND(a,b,c,d,e,f,g,h,i)                         \
-     t0 = h + Sigma1(e) + Ch(e, f, g) + K[i] + W[i];   \
-     t1 = Sigma0(a) + Maj(a, b, c);                    \
-     d += t0;                                          \
-     h  = t0 + t1;
+#ifndef MIN
+#define MIN(x, y) (((x) < (y)) ? (x) : (y))
+#endif
 
 #define STORE64H(x, y) \
 	do { \
@@ -61,145 +57,149 @@ static const __u32 K[64] = {
        (y)[2] = (unsigned char)(((x)>>8)&255); (y)[3] = (unsigned char)((x)&255); } while(0)
 
 #define LOAD32H(x, y)                            \
-  do { x = ((__u32)((y)[0] & 255)<<24) | \
-           ((__u32)((y)[1] & 255)<<16) | \
-           ((__u32)((y)[2] & 255)<<8)  | \
-           ((__u32)((y)[3] & 255)); } while(0)
-
-struct sha256_state {
-    __u64 length;
-    __u32 state[8], curlen;
-    unsigned char buf[64];
-};
-
-/* This is a highly simplified version from libtomcrypt */
-struct hash_state {
-	struct sha256_state sha256;
-};
+  do { x = ((u32)((y)[0] & 255)<<24) | \
+           ((u32)((y)[1] & 255)<<16) | \
+           ((u32)((y)[2] & 255)<<8)  | \
+           ((u32)((y)[3] & 255)); } while(0)
 
-static void sha256_compress(struct hash_state * md, const unsigned char *buf)
+/* compress 512-bits */
+static int sha256_compress(struct sha256_state *md, unsigned char *buf)
 {
-    __u32 S[8], W[64], t0, t1;
-    __u32 t;
-    int i;
-
-    /* copy state into S */
-    for (i = 0; i < 8; i++) {
-        S[i] = md->sha256.state[i];
-    }
-
-    /* copy the state into 512-bits into W[0..15] */
-    for (i = 0; i < 16; i++) {
-        LOAD32H(W[i], buf + (4*i));
-    }
-
-    /* fill W[16..63] */
-    for (i = 16; i < 64; i++) {
-        W[i] = Gamma1(W[i - 2]) + W[i - 7] + Gamma0(W[i - 15]) + W[i - 16];
-    }
-
-    /* Compress */
-     for (i = 0; i < 64; ++i) {
-         RND(S[0],S[1],S[2],S[3],S[4],S[5],S[6],S[7],i);
-         t = S[7]; S[7] = S[6]; S[6] = S[5]; S[5] = S[4];
-         S[4] = S[3]; S[3] = S[2]; S[2] = S[1]; S[1] = S[0]; S[0] = t;
-     }
-
-    /* feedback */
-    for (i = 0; i < 8; i++) {
-        md->sha256.state[i] = md->sha256.state[i] + S[i];
-    }
+	u32 S[8], W[64], t0, t1;
+	u32 t;
+	int i;
+	/* copy state into S */
+	for (i = 0; i < 8; i++) {
+		S[i] = md->state[i];
+	}
+	/* copy the state into 512-bits into W[0..15] */
+	for (i = 0; i < 16; i++)
+		LOAD32H(W[i], buf + (4 * i));
+	/* fill W[16..63] */
+	for (i = 16; i < 64; i++) {
+		W[i] = Gamma1(W[i - 2]) + W[i - 7] + Gamma0(W[i - 15]) +
+			W[i - 16];
+	}
+	/* Compress */
+#define RND(a,b,c,d,e,f,g,h,i)                          \
+	t0 = h + Sigma1(e) + Ch(e, f, g) + K[i] + W[i];	\
+	t1 = Sigma0(a) + Maj(a, b, c);			\
+	d += t0;					\
+	h  = t0 + t1;
+	for (i = 0; i < 64; ++i) {
+		RND(S[0], S[1], S[2], S[3], S[4], S[5], S[6], S[7], i);
+		t = S[7]; S[7] = S[6]; S[6] = S[5]; S[5] = S[4];
+		S[4] = S[3]; S[3] = S[2]; S[2] = S[1]; S[1] = S[0]; S[0] = t;
+	}
+	/* feedback */
+	for (i = 0; i < 8; i++) {
+		md->state[i] = md->state[i] + S[i];
+	}
+	return 0;
 }
-
-static void sha256_init(struct hash_state * md)
+/* Initialize the hash state */
+void erofs_sha256_init(struct sha256_state *md)
 {
-    md->sha256.curlen = 0;
-    md->sha256.length = 0;
-    md->sha256.state[0] = 0x6A09E667UL;
-    md->sha256.state[1] = 0xBB67AE85UL;
-    md->sha256.state[2] = 0x3C6EF372UL;
-    md->sha256.state[3] = 0xA54FF53AUL;
-    md->sha256.state[4] = 0x510E527FUL;
-    md->sha256.state[5] = 0x9B05688CUL;
-    md->sha256.state[6] = 0x1F83D9ABUL;
-    md->sha256.state[7] = 0x5BE0CD19UL;
+	md->curlen = 0;
+	md->length = 0;
+	md->state[0] = 0x6A09E667UL;
+	md->state[1] = 0xBB67AE85UL;
+	md->state[2] = 0x3C6EF372UL;
+	md->state[3] = 0xA54FF53AUL;
+	md->state[4] = 0x510E527FUL;
+	md->state[5] = 0x9B05688CUL;
+	md->state[6] = 0x1F83D9ABUL;
+	md->state[7] = 0x5BE0CD19UL;
 }
-
-#define MIN(x, y) ( ((x)<(y))?(x):(y) )
-#define SHA256_BLOCKSIZE 64
-static void sha256_process(struct hash_state * md, const unsigned char *in, unsigned long inlen)
+/**
+   Process a block of memory though the hash
+   @param md     The hash state
+   @param in     The data to hash
+   @param inlen  The length of the data (octets)
+   @return CRYPT_OK if successful
+*/
+int erofs_sha256_process(struct sha256_state *md,
+		const unsigned char *in, unsigned long inlen)
 {
-    unsigned long n;
-
-    while (inlen > 0) {
-	    if (md->sha256.curlen == 0 && inlen >= SHA256_BLOCKSIZE) {
-		    sha256_compress(md, in);
-		    md->sha256.length += SHA256_BLOCKSIZE * 8;
-		    in += SHA256_BLOCKSIZE;
-		    inlen -= SHA256_BLOCKSIZE;
-	    } else {
-		    n = MIN(inlen, (SHA256_BLOCKSIZE - md->sha256.curlen));
-		    memcpy(md->sha256.buf + md->sha256.curlen, in, (size_t)n);
-		    md->sha256.curlen += n;
-		    in += n;
-		    inlen -= n;
-		    if (md->sha256.curlen == SHA256_BLOCKSIZE) {
-			    sha256_compress(md, md->sha256.buf);
-			    md->sha256.length += 8*SHA256_BLOCKSIZE;
-			    md->sha256.curlen = 0;
-		    }
-	    }
-    }
+	unsigned long n;
+#define block_size 64
+	if (md->curlen > sizeof(md->buf))
+		return -1;
+	while (inlen > 0) {
+		if (md->curlen == 0 && inlen >= block_size) {
+			if (sha256_compress(md, (unsigned char *) in) < 0)
+				return -1;
+			md->length += block_size * 8;
+			in += block_size;
+			inlen -= block_size;
+		} else {
+			n = MIN(inlen, (block_size - md->curlen));
+			memcpy(md->buf + md->curlen, in, n);
+			md->curlen += n;
+			in += n;
+			inlen -= n;
+			if (md->curlen == block_size) {
+				if (sha256_compress(md, md->buf) < 0)
+					return -1;
+				md->length += 8 * block_size;
+				md->curlen = 0;
+			}
+		}
+	}
+	return 0;
 }
-
-static void sha256_done(struct hash_state * md, unsigned char *out)
+/**
+   Terminate the hash to get the digest
+   @param md  The hash state
+   @param out [out] The destination of the hash (32 bytes)
+   @return CRYPT_OK if successful
+*/
+int erofs_sha256_done(struct sha256_state *md, unsigned char *out)
 {
-    int i;
-
-    /* increase the length of the message */
-    md->sha256.length += md->sha256.curlen * 8;
-
-    /* append the '1' bit */
-    md->sha256.buf[md->sha256.curlen++] = (unsigned char)0x80;
-
-    /* if the length is currently above 56 bytes we append zeros
-     * then compress.  Then we can fall back to padding zeros and length
-     * encoding like normal.
-     */
-    if (md->sha256.curlen > 56) {
-        while (md->sha256.curlen < 64) {
-            md->sha256.buf[md->sha256.curlen++] = (unsigned char)0;
-        }
-        sha256_compress(md, md->sha256.buf);
-        md->sha256.curlen = 0;
-    }
-
-    /* pad upto 56 bytes of zeroes */
-    while (md->sha256.curlen < 56) {
-        md->sha256.buf[md->sha256.curlen++] = (unsigned char)0;
-    }
-
-    /* store length */
-    STORE64H(md->sha256.length, md->sha256.buf+56);
-    sha256_compress(md, md->sha256.buf);
-
-    /* copy output */
-    for (i = 0; i < 8; i++) {
-        STORE32H(md->sha256.state[i], out+(4*i));
-    }
+	int i;
+	if (md->curlen >= sizeof(md->buf))
+		return -1;
+	/* increase the length of the message */
+	md->length += md->curlen * 8;
+	/* append the '1' bit */
+	md->buf[md->curlen++] = (unsigned char) 0x80;
+	/* if the length is currently above 56 bytes we append zeros
+	 * then compress.  Then we can fall back to padding zeros and length
+	 * encoding like normal.
+	 */
+	if (md->curlen > 56) {
+		while (md->curlen < 64) {
+			md->buf[md->curlen++] = (unsigned char) 0;
+		}
+		sha256_compress(md, md->buf);
+		md->curlen = 0;
+	}
+	/* pad upto 56 bytes of zeroes */
+	while (md->curlen < 56) {
+		md->buf[md->curlen++] = (unsigned char) 0;
+	}
+	/* store length */
+	STORE64H(md->length, md->buf+56);
+	sha256_compress(md, md->buf);
+	/* copy output */
+	for (i = 0; i < 8; i++)
+		STORE32H(md->state[i], out + (4 * i));
+	return 0;
 }
 
 void erofs_sha256(const unsigned char *in, unsigned long in_size,
 		  unsigned char out[32])
 {
-	struct hash_state md;
+	struct sha256_state md;
 
-	sha256_init(&md);
-	sha256_process(&md, in, in_size);
-	sha256_done(&md, out);
+	erofs_sha256_init(&md);
+	erofs_sha256_process(&md, in, in_size);
+	erofs_sha256_done(&md, out);
 }
 
 #ifdef UNITTEST
+#include <stdio.h>
+
 static const struct {
 	char *msg;
 	unsigned char hash[32];
diff --git a/lib/sha256.h b/lib/sha256.h
new file mode 100644
index 0000000..dd39970
--- /dev/null
+++ b/lib/sha256.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
+#ifndef __EROFS_LIB_SHA256_H
+#define __EROFS_LIB_SHA256_H
+
+#include "erofs/defs.h"
+
+struct sha256_state {
+	u64 length;
+	u32 state[8], curlen;
+	u8 buf[64];
+};
+
+void erofs_sha256_init(struct sha256_state *md);
+int erofs_sha256_process(struct sha256_state *md,
+		const unsigned char *in, unsigned long inlen);
+int erofs_sha256_done(struct sha256_state *md, unsigned char *out);
+
+void erofs_sha256(const unsigned char *in, unsigned long in_size,
+		  unsigned char out[32]);
+
+#endif
-- 
2.24.4

