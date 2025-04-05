Return-Path: <linux-erofs+bounces-148-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A408A7CB9B
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Apr 2025 20:57:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZVPq64XhSz2xRs;
	Sun,  6 Apr 2025 04:57:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1743879442;
	cv=none; b=WhdIcQDo1z36ZhLamnRo0OvVKSFkWRsc+3GxuQF5qGtEkQwfq/uR9D7Oa+4miMssnKxddlMmIz7toW9L/RufnKFk+YlHvymlCVES+roL4LA+iFDJkH4SNbC0fZwq3kx3E8JXs1dFWlFtdz2hI2CJzu2H8IxF48M0BJftoljJf2O1p4AjnOd8dDd3YmpybVSdXxWDAXdDPvW/wf3+RTZ1/WEKJphCF29cZaOwS9vX87/lq3F3YstkcBaC0ZdlMoS7dqgm/9DPqTf/QZvk/Pxg9xxwZArQhh0wkqKqkXucvixkCOXi/yXoBeR9wlEcvDDstPpwILVTbaSwgLeKvGZe0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1743879442; c=relaxed/relaxed;
	bh=POjpij0tX1ip9UWvKi0GKUqTnVM8FwvVHLlI+6+Hn00=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D2Z1jp1jmJjaqZxwMSxWV0tslLQ7JSxcEJ4T+Z/dtLnbA0tV8S+7SL4IcmxJbrBX3ACfzLi2OAEgmriwr2bABLgpSAgihSxNghPtTpbHZs9ndIaDGM9AssYXBDF4axFwltRWT6QH98JFx5t2dIX8BrKUw+9Zyj5B8JADgTkb2crC657PoziMUWJZTLIr9bUmD+xYbFUlC10Fj1drX31s+mOJmRcZXJrEBY9d85yI3XAyCV0LAs60ArTOmpteUsB/Adh/wlwS0irLDjlr2N/Sl3g6qW74zY9Ra6jRLUAK9g2d1XbF/3AqfNJAhpGibDseDIE7PSL9w2nbUo9IdCUbjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Fw1HOPL5; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Fw1HOPL5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZVPq416Whz2xRx
	for <linux-erofs@lists.ozlabs.org>; Sun,  6 Apr 2025 04:57:18 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1743879434; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=POjpij0tX1ip9UWvKi0GKUqTnVM8FwvVHLlI+6+Hn00=;
	b=Fw1HOPL55NSI1vPn1WA3jo929q3C0prHim9YSMmlRJzUSWYMH5bpa4F/73eExiMbgkZA8/wedqlWcBA0m4AGFQwbzTrU3xoCcZxXN6IOz3LzZn3Ihk7adKnX4t/GvtNmt5D+X/DFbVrRb0SpjAF+WPEJNKCL5GLPyC1HVned76U=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WVLL3MS_1743879428 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 06 Apr 2025 02:57:12 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/4] erofs-utils: lib: only apply `fix_dedupedfrag` to the last segment
Date: Sun,  6 Apr 2025 02:57:04 +0800
Message-ID: <20250405185707.3202298-1-hsiangkao@linux.alibaba.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Only the segment containing the fragment needs to be fixed.

Fixes: b8cc6a36b560 ("erofs-utils: mkfs: implement multi-threaded fragments")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/compress.c b/lib/compress.c
index 5ecb9c8..4b966d8 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -729,6 +729,7 @@ fix_dedupedfrag:
 static int z_erofs_compress_one(struct z_erofs_compress_sctx *ctx)
 {
 	struct z_erofs_compress_ictx *ictx = ctx->ictx;
+	bool tsg = ctx->seg_idx + 1 >= ictx->seg_num;
 	struct z_erofs_extent_item *ei;
 
 	while (ctx->tail > ctx->head) {
@@ -753,7 +754,7 @@ static int z_erofs_compress_one(struct z_erofs_compress_sctx *ctx)
 		}
 
 		ctx->pivot = ei;
-		if (ictx->fix_dedupedfrag && !ictx->fragemitted &&
+		if (tsg && ictx->fix_dedupedfrag && !ictx->fragemitted &&
 		    z_erofs_fixup_deduped_fragment(ctx))
 			break;
 
-- 
2.43.5


