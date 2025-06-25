Return-Path: <linux-erofs+bounces-491-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DB67EAE7B10
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Jun 2025 10:58:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bRwhR1cGTz2yKq;
	Wed, 25 Jun 2025 18:58:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750841895;
	cv=none; b=NNTwttqzh0HRkSzGXN0D/hFsHe6fnKsQdE1m0x3cMwdKM4gX1LD3ZgGysShr2w/y3/lBu8yOY+v8zbgb72KYk7XOOqAZo3uJEutyiFIWZ964eHvzoNiMvyCYAiQ02WsgCmMOM7YzB8k66x/+8kXoI+iMHIFp1Uvp7TF4fBUwOxBBa2afiU50fLgVjZ5E3ddLujYyxRMuSJAW9R+9w8Z9/NKtTbDuLpcRiZghbtW82/j7kAle1l341camzpM3JzrbY+NSrglJFDwhQlC66PadSUa6WycRlKCPJ2URP0tyGLYkMmSSl8EpY/E/e/KfIL1bt7ddj9+EFt7rdcgkukQmSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750841895; c=relaxed/relaxed;
	bh=XUFkMkeU8Nr26uPDgGLIjIE2EZyH3Uro1BcXTpKnSMA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FeabA5APuVGG3J4262Re7H+dDKd+wiHVSHWpIa++2NXZNNpe7N1IanJtH0u01uPDdsKvimonTt/apUdQ99nDL5hyd6cN9MxmUtCJfWboMMuqtFAOJYYuV3F5CIPt12Yra6YlJFxaSBRFS/h3yQvqf75fdHREcJfAEy19NlXdT6tpORSr9DffsoH0Z/6/bsObbDm7eSw6JkDq2dsebId3azGqpfxf0Xx3FCebien0exWBslhbK38SnQCoHzMA5NTWUXosw9hH436/RrGM3Sca6p7Zp65gXYeIJ++sKfYpFStxMzcVUM08fIgtz2TRiR63YjzFNzL2BDcderMdjQHCwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bVmvooza; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bVmvooza;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bRwhN3JdNz2xk5
	for <linux-erofs@lists.ozlabs.org>; Wed, 25 Jun 2025 18:58:10 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1750841886; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=XUFkMkeU8Nr26uPDgGLIjIE2EZyH3Uro1BcXTpKnSMA=;
	b=bVmvoozaF6uYk9Qz7b7XOBP0PXOhzJ43zbQLYxgB6cQlkk+xUXPn3FJQ23DgnCndBiNDlYAYU+2dOc1Q0/gCwQlOCtEOOhEoAsTI+jIXyc7SJG24+xSPKVVU+k68la8QaQNz+BcxP66G9HZXA5oN/oJ44Xvv08K2nLGgRRk5HGg=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wevtuz4_1750841879 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Jun 2025 16:58:04 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: lib: fix crafted Z_EROFS_COMPRESSION_INTERLACED extents
Date: Wed, 25 Jun 2025 16:57:59 +0800
Message-ID: <20250625085759.1965251-1-hsiangkao@linux.alibaba.com>
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

`fuzz_erofsfsck` reports a heap-buffer-overflow issue.

Reproducible image (base64-encoded gzipped blob):
H4sICEI5WmgCA2Vyb2ZzZnNja19saWJmdXp6ZXJfdVhJS1BnAGNkAIKu////M8ABIwMDO8NA
AA6iVSqQYCoTkepWMQwDwIPGFxhUrvv/nx+fNDUdizMFs1DdV9vpHc5MVDHlN5h89PDrg/1G
87YxgxOPigcs3KSXrUsH0ReXSWLoNMASlo8eQMzhgJgDDP8usDNVEEouLuMElS1AwHeRESq2
iZn9N4NNtzOXVqL1bNf7CTO2RkIM/c8KpvqJBFiSGrBI+0FRIUPNhP+F4SGIdiBeC0aK+kFE
8WlMIqBnGDQMZIVBTuEEzhoG8KwBKlJGkzDNk7ABPmBpZGBqYmpoYgZMu+amxgbmBhbU8R1f
JDw+2YAYFJ3g2Jxxze3Cxog9oNZRCitS7cJEXJ2Dz8P7KWlvAAAOXVIStwkAAA==

Add a `rq->decodedlength > rq->inputsize` check to match the kernel
implementation for now.

Closes: https://github.com/erofs/erofs-utils/issues/20
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/decompress.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/decompress.c b/lib/decompress.c
index 1e9fad7..3e7a173 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -514,14 +514,13 @@ int z_erofs_decompress(struct z_erofs_decompress_req *rq)
 	if (rq->alg == Z_EROFS_COMPRESSION_INTERLACED) {
 		unsigned int count, rightpart, skip;
 
-		/* XXX: should support inputsize >= erofs_blksiz(sbi) later */
-		if (rq->inputsize > erofs_blksiz(sbi))
-			return -EFSCORRUPTED;
-
-		if (rq->decodedlength > erofs_blksiz(sbi))
+		if (rq->decodedlength > rq->inputsize)
+			return -EOPNOTSUPP;
+		if (rq->decodedlength < rq->decodedskip)
 			return -EFSCORRUPTED;
 
-		if (rq->decodedlength < rq->decodedskip)
+		/* XXX: should support inputsize >= erofs_blksiz(sbi) later */
+		if (rq->inputsize > erofs_blksiz(sbi))
 			return -EFSCORRUPTED;
 
 		count = rq->decodedlength - rq->decodedskip;
@@ -532,9 +531,10 @@ int z_erofs_decompress(struct z_erofs_decompress_req *rq)
 		return 0;
 	} else if (rq->alg == Z_EROFS_COMPRESSION_SHIFTED) {
 		if (rq->decodedlength > rq->inputsize)
+			return -EOPNOTSUPP;
+		if (rq->decodedlength < rq->decodedskip)
 			return -EFSCORRUPTED;
 
-		DBG_BUGON(rq->decodedlength < rq->decodedskip);
 		memcpy(rq->out, rq->in + rq->decodedskip,
 		       rq->decodedlength - rq->decodedskip);
 		return 0;
-- 
2.43.5


