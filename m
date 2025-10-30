Return-Path: <linux-erofs+bounces-1302-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAC6C1E317
	for <lists+linux-erofs@lfdr.de>; Thu, 30 Oct 2025 04:21:50 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cxqCc38Zjz2yvv;
	Thu, 30 Oct 2025 14:21:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761794508;
	cv=none; b=CAXoMdx+p1/wB+7lpppO/yoOnp2AHT0YOPAxedfgKOlFBYNtspxtK6us5rAPvwvMiA3+5ljZtpr20IxP2vjiTwgT20e/DXTMg/0hA2JIIpDQH94nqd6M3t4LftbHuVZ2zp9p6/tViiJSmumR0djnReBdyEN1dc82vXyeFK1sABjX40zfQVLmpEk4UFzFjleMkCfqunu8BraO2OOk3B2U7HOEYgJDRfppCIdZlhdTTpGTS9EWlMaZqc9dNTqMhKHPioiFbu00KSa+zRcC/TGCMam0uMLvMELlAvysFxJ5BDB/ynLhf99VkK+K1Z0pbDyOcRD0605jKd7HasUGsa624g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761794508; c=relaxed/relaxed;
	bh=OwKGJWHNIhzScwITuDnuDK68TY5OlF6bMjo/7+LaEKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kje/1v5FD0ytOFTepZW5LasGMZ4LIxkwLXAZg/yeWSUIHTQVLQFpWx0WgNI8FLvhqMQ2hmtYcHZ1UjR+G/MwcJlUza8q5+6UFotvusWi+lfUjmMKB46jyep+riHicBu/xXlvuTO5PntCOovL1ijcUXpkMJgPFkCe2h5o9JC1oRSMexf7F1nhqlAkBxkfphTPaTaOAySmPx5a7yrvZYLtH4la3IDpcDZvsXpxVImhpxvN5/ZZzrUn0HakAOOy4oeGdAErmhnl0/n24qimgjKja7mnTzQKDckCgSSegYKj69NEgyfEyvMWoYVC3OH7ogspeFON3A64j+psS9oYFDVjKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ViNxV0rp; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ViNxV0rp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cxqCZ1p90z2yD5
	for <linux-erofs@lists.ozlabs.org>; Thu, 30 Oct 2025 14:21:45 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761794500; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=OwKGJWHNIhzScwITuDnuDK68TY5OlF6bMjo/7+LaEKY=;
	b=ViNxV0rpX1nhl4EWgvdyG9SbAzomiom5Y9HO7/OHvhwzgy5mTk/HlRq0T5H03+ToaYclL3c4c1bTmz6zlt8QSG9wqs7xqfC5SUCi9UMesPVAJj/Cn3E+4XJpClkQmgh1NPPe3AKy58OIMqay1riSaA62btZeXdU74uk2FEY0a9g=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WrIHttr_1761794493 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 30 Oct 2025 11:21:38 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH] erofs-utils: lib: gzran: slightly improve the random performance
Date: Thu, 30 Oct 2025 11:21:33 +0800
Message-ID: <20251030032133.2014456-1-hsiangkao@linux.alibaba.com>
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

 - Avoid reading overly long compressed data;

 - Increase temporary buffer to keep inflight compressed data to 128k.

Cc: Chengyu Zhu <hudsonzhu@tencent.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/gzran.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/lib/gzran.c b/lib/gzran.c
index 1136d04..0238d19 100644
--- a/lib/gzran.c
+++ b/lib/gzran.c
@@ -222,15 +222,24 @@ static ssize_t erofs_gzran_ios_vfpread(struct erofs_vfile *vf, void *buf, size_t
 	struct erofs_gzran_iostream *ios =
 		(struct erofs_gzran_iostream *)vf->payload;
 	struct erofs_gzran_cutpoint *cp = ios->cp;
-	u8 src[1 << 14], discard[EROFS_GZRAN_WINSIZE];
-	unsigned int bits;
+	u8 src[131072], discard[EROFS_GZRAN_WINSIZE];
+	union {
+		unsigned int bits, i;
+	} u;
 	bool skip = true;
-	u64 inpos;
+	u64 inpos, remin;
 	z_stream strm;
 	int ret;
 
-	while (cp < ios->cp + ios->entries - 1 && cp[1].outpos <= offset)
+	if (offset == ~0ULL) {
+		DBG_BUGON(1);
+		return -EIO;
+	}
+
+	while (cp[1].outpos <= offset)
 		++cp;
+	for (u.i = 1; cp[u.i].outpos < offset + len; ++u.i);
+	remin = (cp[u.i].in_bitpos >> 3) + !!(cp[u.i].in_bitpos & 7);
 
 	strm.zalloc = Z_NULL;
 	strm.zfree = Z_NULL;
@@ -241,20 +250,21 @@ static ssize_t erofs_gzran_ios_vfpread(struct erofs_vfile *vf, void *buf, size_t
 	if (ret != Z_OK)
 		return -EFAULT;
 
-	bits = cp->in_bitpos & 7;
-	inpos = (cp->in_bitpos >> 3) - (bits ? 1 : 0);
-	ret = erofs_io_pread(ios->vin, src, sizeof(src), inpos);
+	u.bits = cp->in_bitpos & 7;
+	inpos = (cp->in_bitpos >> 3) - (u.bits ? 1 : 0);
+	remin -= inpos;
+	ret = erofs_io_pread(ios->vin, src, min(remin, sizeof(src)), inpos);
 	if (ret < 0)
 		return ret;
-
-	if (bits) {
-		inflatePrime(&strm, bits, src[0] >> (8 - bits));
+	if (u.bits) {
+		inflatePrime(&strm, u.bits, src[0] >> (8 - u.bits));
 		strm.next_in = src + 1;
 		strm.avail_in = ret - 1;
 	} else {
 		strm.next_in = src;
 		strm.avail_in = ret;
 	}
+	remin -= ret;
 	inpos += ret;
 	(void)inflateSetDictionary(&strm, cp->window, sizeof(cp->window));
 
@@ -278,13 +288,15 @@ static ssize_t erofs_gzran_ios_vfpread(struct erofs_vfile *vf, void *buf, size_t
 		/* uncompress until avail_out filled, or end of stream */
 		do {
 			if (!strm.avail_in) {
-				ret = erofs_io_pread(ios->vin, src, sizeof(src),
+				ret = erofs_io_pread(ios->vin, src,
+						     min(remin, sizeof(src)),
 						     inpos);
 				if (ret < 0)
 					return ret;
 				if (!ret)
 					return -EIO;
 				inpos += ret;
+				remin -= ret;
 				strm.avail_in = ret;
 				strm.next_in = src;
 			}
@@ -343,7 +355,7 @@ struct erofs_vfile *erofs_gzran_zinfo_open(struct erofs_vfile *vin,
 		goto err_ios;
 	}
 
-	ios->cp = malloc(sizeof(*ios->cp) * ios->entries);
+	ios->cp = malloc(sizeof(*ios->cp) * (ios->entries + 1));
 	if (!ios->cp) {
 		ret = -ENOMEM;
 		goto err_ios;
@@ -364,6 +376,8 @@ struct erofs_vfile *erofs_gzran_zinfo_open(struct erofs_vfile *vin,
 		ios->cp[i].outpos = le64_to_cpu(c->out);
 		memcpy(ios->cp[i].window, c->window, sizeof(c->window));
 	}
+	ios->cp[i].in_bitpos = -1;
+	ios->cp[i].outpos = ~0ULL;
 	ios->vin = vin;
 	vf->ops = &erofs_gzran_ios_vfops;
 	return vf;
-- 
2.43.5


