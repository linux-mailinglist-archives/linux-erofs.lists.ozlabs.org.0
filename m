Return-Path: <linux-erofs+bounces-542-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2886AAFC0B5
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Jul 2025 04:17:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bblB80mRFz30T3;
	Tue,  8 Jul 2025 12:17:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751941056;
	cv=none; b=hwtbn0RPGncXtzzKPSVov82FfY6mWV9064G12dnsFPnCyoRgTeMCJnG8zgLvqnTHfqqtSEdZnMpA4oNrXdSob7L9EQIpQw4w5YOBZCf7/qvA2v3wxR2pS/Y8KC03MxqHJPgadyTsJSD/gtpFUtNPHaQ6HfCGoFdk/N66srYcyTl0gk0bml6IjKtlKwgCEqmF+IA0mL++2JLmx2NLHrNeWPjsHH+9ZDMMhNTelrWX9dK4l9SuSczPrdCTj8VebLAbGmH8m0lPmgqUS90GNFK2AUu5tYNa+yN9KOXSmQLY7LoSp1aB68jPcltP2AeEAZV+tDfgBWZUE2gis5XMTHz7JA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751941056; c=relaxed/relaxed;
	bh=kt6wy0d3fwoLfZV5lYN8cpnvLO/s+ozyTGSJ1DExaIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O07So52xEeGJr4xYSlhoslJxjiXX2s4C8By5tav+dhrRAglqLHd7LiazU6gY+VcfIYSIvxxvM9ld8BprUdrHui36n0tgoZIONxLfRZt7oTYVdEws27ENf/kfR8bwWKfS1PCBzuMGiJuatIh4u09X/PtSVJ4Q3JUXfA4fXoO1bKnyQHY8YmFSSYvQMqRPxbQkz5kwwKwqnjDRx8O0ZjxacTxFWblmTBV7X/ksA6364ezCR+1+F0dOmLywy1Q1LBFhM3Gft5dcTGd/EMiI6sjzYntqaN/tpinr7UnHQ5ek41dU5OaFDK2yKz279zRRaYgDn4dZrmp2YYcMTRFfonoT3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=U5ywqKkO; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=U5ywqKkO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bblB62Bgvz30WQ
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Jul 2025 12:17:33 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751941050; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=kt6wy0d3fwoLfZV5lYN8cpnvLO/s+ozyTGSJ1DExaIw=;
	b=U5ywqKkO1SbLbVkaXtFWynuk2qfvk56U+cuYkzkpt6faZLpJSYQTAiT8yOkTlvBpfa6fj2BjqDLNKTiw6miTwov7EOQmoOS7gELnYiNJcNBopwDrOD4RqnEm3dRrcAt1as/ZovB6Ptn5eckewV5IM7LdINkSn82xXtYPgN64ciA=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WiIWO0t_1751941048 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 08 Jul 2025 10:17:29 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 4/4] erofs-utils: lib: fix `INTEGER_OVERFLOW`
Date: Tue,  8 Jul 2025 10:17:22 +0800
Message-ID: <20250708021722.768644-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250708021722.768644-1-hsiangkao@linux.alibaba.com>
References: <20250708021722.768644-1-hsiangkao@linux.alibaba.com>
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

Coverity-id: 569453
Fixes: 341d23a878a2 ("erofs-utils: mkfs: speed up uncompressed data handling")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 8999b2c7..bf471218 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -579,18 +579,15 @@ static int __z_erofs_compress_one(struct z_erofs_compress_sctx *ctx,
 	if (len <= ctx->pclustersize) {
 		if (!final || !len)
 			return 1;
-		if (may_packing) {
-			if (inode->fragment_size && !ictx->fix_dedupedfrag) {
-				ctx->pclustersize = roundup(len, blksz);
-				goto fix_dedupedfrag;
-			}
-			e->length = len;
-			goto frag_packing;
+		if (may_packing && inode->fragment_size && !ictx->fix_dedupedfrag) {
+			ctx->pclustersize = roundup(len, blksz);
+			goto fix_dedupedfrag;
 		}
-		if (!may_inline && len <= blksz) {
-			e->length = len;
+		e->length = len;
+		if (may_packing)
+			goto frag_packing;
+		if (!may_inline && len <= blksz)
 			goto nocompression;
-		}
 	}
 
 	e->length = min(len, cfg.c_max_decompressed_extent_bytes);
@@ -629,7 +626,7 @@ retry_aligned:
 		} else {
 			may_inline = false;
 			may_packing = false;
-			e->length = min_t(u32, e->length, ret);
+			e->length = min_t(u32, e->length, ctx->pclustersize);
 nocompression:
 			if (cfg.c_dedupe)
 				ret = write_uncompressed_block(ctx, len, dst);
-- 
2.43.5


