Return-Path: <linux-erofs+bounces-187-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 76114A84C1E
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Apr 2025 20:33:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZYT3j5Yw3z3bmJ;
	Fri, 11 Apr 2025 04:33:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744310033;
	cv=none; b=cSbIsWmGTWgZ/dQtqPISVAaGFJZNPw3dmSI8alDRuiFbRGxPVPMvYSMn0AQVd1d7heiEL+0LIPFmTBi5tXoR20mBlHinusow/jB+jfy+JhNlIh+yBDna2fbb11auc0z7XTMZuzXlDWCHJRzwvXXpAFdUoCs8pFSDKT7AtCu51A1v6fSbH3nq+2blQaPCEAhZNCvUFsp8Wju8mttVHg55+sLJGgDzJ33KzngH32TRCRXyziJ7Fw0R9eS9xAczSrbxYVc02TV1lgpOvne0p8FaQyosTPKK7S9gEBl2mq+OHRto0ukpRd83Zcl4mYdoBOOJ2wFaSHKpq2RN1Z1ltQLElA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744310033; c=relaxed/relaxed;
	bh=cSJKlC8jVFxYez4mhA2yvRvvYscJmCZieLB620BKtJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WxIETePzEJIJFuSADKix250UGpxOvtKSZp46Qdfg5i9AoanaeYWAECpVe3TqKpIP0G32V2IuTBAOmaYRw6xkylv8dAoGXfxY2SLd2/LZmX7vlmK9aBwPpMLGCJjZzEpEK2/plY+w4OZdFevTljdP9l163/CDILvWBT4Ey2lLxXU/sqR/LRsfk/F4UI2/Tz/g4F8pKsLuzfj7eAa0XA3avRnGkOLYFIMbKXzB/RLAFABjKdffOJ2oJk+WnMOPULe5UOJUDa9gKS0c8eB5ALSqBmmeYR4wFaUwjz+BIwZ8y6iGyx33jBTn3KlYWAHtSbiqJ82iYW1RDe2i+codkE6uHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xi1sK10F; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xi1sK10F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZYT3g6svlz3bm7
	for <linux-erofs@lists.ozlabs.org>; Fri, 11 Apr 2025 04:33:50 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1744310023; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=cSJKlC8jVFxYez4mhA2yvRvvYscJmCZieLB620BKtJ0=;
	b=xi1sK10F2DnxGtmU4FRExW9aDa+DpeVBl4/VoLtLiSuUP/L1m3AnYBenuphsvx49pN/LhMYraKCWgylLBxChzcI5R/TlQcS2qnUSW5wgz/93zdUYFmMbHDiN9mFrpyfE/f2rLKSjwAXb2fTAd4ifVdcJSr10umZVt5q1nYm+QGQ=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WWQ1rXi_1744310012 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 11 Apr 2025 02:33:41 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Bo Liu <liubo03@inspur.com>
Subject: [PATCH] erofs-utils: lib: fix maximum huffman length for kite-deflate
Date: Fri, 11 Apr 2025 02:33:31 +0800
Message-ID: <20250410183331.50544-1-hsiangkao@linux.alibaba.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

It should be kTableDirectLevels - 1 (15) instead of 16; otherwise,
it will be incorrectly identified as kBitLensRepNumber_3_6.

Reported-by: Bo Liu <liubo03@inspur.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/kite_deflate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/kite_deflate.c b/lib/kite_deflate.c
index 592c4d1..7e92c7c 100644
--- a/lib/kite_deflate.c
+++ b/lib/kite_deflate.c
@@ -52,6 +52,8 @@ unsigned long erofs_memcmp2(const u8 *s1, const u8 *s2,
 #define kBitLens0Number_3_10    (kBitLensRepNumber_3_6 + 1)
 #define kBitLens0Number_11_138  (kBitLens0Number_3_10 + 1)
 
+#define kMaxLen                 (kTableDirectLevels - 1)
+
 static u32 kstaticHuff_mainCodes[kFixedLenTableSize];
 static const u8 kstaticHuff_litLenLevels[kFixedLenTableSize] = {
 	[0   ... 143] = 8, [144 ... 255] = 9,
@@ -180,8 +182,6 @@ static void flushbits(struct kite_deflate *s)
 	s->inflightbits = 0;
 }
 
-#define kMaxLen 16
-
 static void deflate_genhuffcodes(const u8 *lens, u32 *p, unsigned int nr_codes,
 				 const u32 *bl_count)
 {
-- 
2.43.5


