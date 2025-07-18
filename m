Return-Path: <linux-erofs+bounces-678-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A4CB0A06E
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Jul 2025 12:14:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bk5Hx5rPXz2xfR;
	Fri, 18 Jul 2025 20:14:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752833677;
	cv=none; b=kzT8DR6lm+hm0hJiOOFyuBDV9TrwtAwTUsQmOIFxFUGPIduoyotclLVf5R8TXityy7fi6rBdqqrPGaM9/JprIXI5eGGITJPm/HAfRQmYHbiczd0/srwZ8zKSO/5G8EvZZp8CHzbkoeAeth4t7YUL+hJUdtfqcbE1gePNiBGamKUXbZApb9EKCYZWg2UOlOzWy5s0/XMBLIpMS93d3hPvVfJLYC+pmc5vmtE5v/Vsc4eO09Yi30zlZ6v+9vQI4zw9hfDpb1KzL9zWO8um1YK4iyuXwaql6SLcsEL0IV166kFsLgfSA4VwtHBE0BhH1rwpGD9wfeONrw1eVbmeZGA4Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752833677; c=relaxed/relaxed;
	bh=5g4K3T+Dn2sXjGbPs5wvOW5W0DZxv29RtgUq1i98IMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BST/S70WArQ4CgERdAwSqK4cDs638RoINeBgIk3gF0/vQVhUZ/rSuI041yhi+RY5786HY++EVW4iYgZFqTPx2LmLq2yJsk6R6rjOmzCzvQcaKwPyp53ZNliBo9v0lScNTtO4+5Mymp/FllHnE3Asakp20WfatMf1EksCptow3b5L7UJhEvTb/71nwCOcUbCQWQN3xxAW6f824BRhoM284zUJ/3kzIiUoh3d/q0VqA32CYD5lAKiRnaqIN+UefKFvf2VtXNSjU7okNQ78QPX+NK8LFm2YXUtoMmvzRo9uTQq3a/IgwHWZrdRrlw4QJXJvzaf9U3QC6aTME+0K2nqvhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qLuBQqH2; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qLuBQqH2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bk5Hv11Hwz2xd6
	for <linux-erofs@lists.ozlabs.org>; Fri, 18 Jul 2025 20:14:33 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752833668; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=5g4K3T+Dn2sXjGbPs5wvOW5W0DZxv29RtgUq1i98IMs=;
	b=qLuBQqH29o8qCNrxeCUIaHvkAHU5A6JL3eYtW8+/0syP3unJLmnGIKvcfXZPWLA13jvRWSHiCErN0A6j2jE97gx8TdYJK3rdjNHrdRSTM5xrBKPxvrUxmI3sNtgMUrXgfjzJyN3m9r0vvgsTm8/0yQCIrthxT0fDYQ+zfZbdyqA=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WjBsB3U_1752833663 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 18 Jul 2025 18:14:27 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: lib: fix BFINAL judgment for kite-deflate
Date: Fri, 18 Jul 2025 18:14:21 +0800
Message-ID: <20250718101421.3614925-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

There should be enough space to generate a new DEFLATE block with an
end-of-block symbol, which requires at least 10 bits for BTYPE 01.

Fixes: 861037f4fc15 ("erofs-utils: add a built-in DEFLATE compressor")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/kite_deflate.c | 134 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 115 insertions(+), 19 deletions(-)

diff --git a/lib/kite_deflate.c b/lib/kite_deflate.c
index 7e92c7ca..e9f7e40e 100644
--- a/lib/kite_deflate.c
+++ b/lib/kite_deflate.c
@@ -1005,6 +1005,8 @@ static void kite_deflate_writestore(struct kite_deflate *s)
 
 static void kite_deflate_endblock(struct kite_deflate *s)
 {
+	u64 b = s->outlen - s->pos_out;
+
 	if (s->encode_mode == 1) {
 		u32 fixedcost = s->costbits;
 		unsigned int storelen, storeblocks, storecost;
@@ -1025,8 +1027,11 @@ static void kite_deflate_endblock(struct kite_deflate *s)
 		}
 	}
 
-	s->lastblock |= (s->costbits + s->bitpos >=
-			(s->outlen - s->pos_out) * 8);
+	if (s->costbits + s->bitpos +
+	    3 + kstaticHuff_litLenLevels[kSymbolEndOfBlock] >= b * 8) {
+		DBG_BUGON(s->costbits + s->bitpos > b * 8);
+		s->lastblock = true;
+	}
 }
 
 static void kite_deflate_startblock(struct kite_deflate *s)
@@ -1256,38 +1261,129 @@ int kite_deflate_destsize(struct kite_deflate *s, const u8 *in, u8 *out,
 #include <fcntl.h>
 #include <sys/mman.h>
 
+#ifdef HAVE_ZLIB
+#include <zlib.h>
+
+static int kite_deflate_decompress_zlib(const u8 *in, size_t inlen,
+					u8 *out, size_t out_capacity)
+{
+	z_stream z;
+	int res;
+
+	memset(&z, 0, sizeof(z));
+	res = inflateInit2(&z, -15);
+	if (res != Z_OK) {
+		DBG_BUGON(1);
+		return -1;
+	}
+	z.next_in = (void *)in;
+	z.avail_in = inlen;
+	z.next_out = (void *)out;
+	z.avail_out = out_capacity;
+	res = inflate(&z, Z_FINISH);
+	if (res != Z_STREAM_END) {
+		DBG_BUGON(1);
+		return -1;
+	}
+	inflateEnd(&z);
+	return out_capacity - z.avail_out;
+}
+
+static void kite_deflate_decompress_test_zlib(const u8 *in, size_t inlen,
+					      u8 *out, size_t out_capacity,
+					      const u8 *expected_out,
+					      size_t expected_outlen)
+{
+	int outlen;
+
+	outlen = kite_deflate_decompress_zlib(in, inlen, out, out_capacity);
+	BUG_ON(outlen != expected_outlen);
+	if (expected_outlen)
+		BUG_ON(memcmp(out, expected_out, expected_outlen));
+}
+#endif
+
+static void kite_deflate_decompress_test(const u8 *in, size_t inlen,
+					 u8 *out, size_t out_capacity,
+					 const u8 *expected_out,
+					 size_t expected_outlen)
+{
+#ifdef HAVE_ZLIB
+	kite_deflate_decompress_test_zlib(in, inlen, out, out_capacity,
+					  expected_out, expected_outlen);
+#endif
+}
+
+static void kite_deflate_test1(void)
+{
+	struct kite_deflate *s;
+	u8 enc[3], vb[10];
+
+	s = kite_deflate_init(1, 0);
+	BUG_ON(!s || IS_ERR(s));
+
+	s->out = enc;
+	s->outlen = sizeof(enc);
+
+	writebits(s, (kFixedHuffman << 1) + 1, 3);
+	writebits(s, kstaticHuff_mainCodes[kSymbolEndOfBlock],
+		  kstaticHuff_litLenLevels[kSymbolEndOfBlock]);
+	flushbits(s);
+
+	kite_deflate_decompress_test(enc, s->pos_out,
+				     vb, sizeof(vb), NULL, 0);
+}
+
 int main(int argc, char *argv[])
 {
-	int fd;
-	u64 filelength;
-	u8 out[1048576], *buf;
-	int dstsize = 4096;
-	unsigned int srcsize, outsize;
+	unsigned int srcsize, outsize, dstsize, level;
 	struct kite_deflate *s;
+	u8 out[1048576], *buf;
+	u64 filelength;
+	u8 *vbuf;
+	int fd;
 
+	if (argc < 2) {
+		kite_deflate_test1();
+		fprintf(stdout, "PASS\n");
+		return 0;
+	}
+	dstsize = level = 0;
 	fd = open(argv[1], O_RDONLY);
-	if (fd < 0)
-		return -errno;
-	if (argc > 2)
+	BUG_ON(fd < 0);
+	if (argc > 2) {
 		dstsize = atoi(argv[2]);
-	filelength = lseek(fd, 0, SEEK_END);
+		if (argc > 3)
+			level = atoi(argv[3]);
+	}
+	if (!dstsize || dstsize > sizeof(out))
+		dstsize = 4096;
+	if (!level)
+		level = 9;
 
-	s = kite_deflate_init(9, 0);
-	if (IS_ERR(s))
-		return PTR_ERR(s);
+	s = kite_deflate_init(level, 0);
+	BUG_ON(IS_ERR(s));
 
 	filelength = lseek(fd, 0, SEEK_END);
 	buf = mmap(NULL, filelength, PROT_READ, MAP_SHARED, fd, 0);
-	if (buf == MAP_FAILED)
-		return -errno;
+	BUG_ON(buf == MAP_FAILED);
 	close(fd);
 
 	srcsize = filelength;
 	outsize = kite_deflate_destsize(s, buf, out, &srcsize, dstsize);
-	fd = open("out.txt", O_WRONLY | O_CREAT | O_TRUNC, 0644);
-	write(fd, out, outsize);
-	close(fd);
 	kite_deflate_end(s);
+#ifdef HAVE_ZLIB
+	vbuf = malloc(srcsize);
+	if (!vbuf) {
+		fprintf(stderr, "buffer allocation failed\n");
+	} else {
+		BUG_ON(kite_deflate_decompress_zlib(out, outsize,
+						    vbuf, srcsize) != srcsize);
+		BUG_ON(memcmp(buf, vbuf, srcsize));
+		free(vbuf);
+	}
+#endif
+	BUG_ON(fwrite(out, outsize, 1, stdout) != 1);
 	return 0;
 }
 #endif
-- 
2.43.5


