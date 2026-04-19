Return-Path: <linux-erofs+bounces-3327-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKnlLqfV5GnZagEAu9opvQ
	(envelope-from <linux-erofs+bounces-3327-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 19 Apr 2026 15:16:23 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DAECF424117
	for <lists+linux-erofs@lfdr.de>; Sun, 19 Apr 2026 15:16:22 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fz8Jh3SSWz2ytw;
	Sun, 19 Apr 2026 23:16:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::436"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776604580;
	cv=none; b=KqtVcUwjZ1liMq1Nrr70AKsDBvXAqjLj5vR3dVgeR1SrAThlc2njwXMev8ZzrXkcCQFMMO3W1Ey1qcg+PCQVkNFArCatunHnepc7Zm+DdFIX/k8V3iJqqpF+0oer8pvdckCymD+Zyc1RhgGnppqptQrXzHNS8DO2symeFOWToqQO8UqamumxRfBb5CBQlugMRaEOCohRpcMQ3wlgcMtslrRkMc2s202fkJEdRR+5peEUQh3n/UB4p4Rg7AnTkn5U5FfmOT2PUZNBSaUheQ3F8qALwOR2NwjxM8AAC8DBIX1iuFsk/LA48AL43I6/iiEQ2js0CyA+sU+77bpJ6uAkQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776604580; c=relaxed/relaxed;
	bh=VQ8hIJNEE9cPoA2WcZQt5hcd0hTazcN4cicv5bFpS8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wv7kuV6fzrb7T4ygJJG8qTC/VpFNa7eilbCbWWy09ut6Q2AtoUKL3iab74w2ScwAGFNGrg7c0JrhBQYrvEWvA2jz10+79iHWrKlIhknkydCmZLPTAAM4z6kXNKqgyxSqIiC9BiWgJMFCd963MZIteVceTljrEXYLEIZ+c+/LMxkJ8/fLKPu32vI8hClSC9KkuRmZNqnM0M62S90RnCvjms13qUzUBKFmSjtAAtA+URz+BroPPwvoihBxC0oLqti6IVmmmM20E25b4snqb3ymCJEFOq2k7p3g4jrVc7qaxzuVNgUTDMjbot4PUz9eFYJHQ2hO9G+aNjijNeJj8u1P2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=M0pPSW/D; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=M0pPSW/D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fz8Jg52xLz2ynn
	for <linux-erofs@lists.ozlabs.org>; Sun, 19 Apr 2026 23:16:19 +1000 (AEST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-82f68b3aaf7so755844b3a.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 19 Apr 2026 06:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776604577; x=1777209377; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQ8hIJNEE9cPoA2WcZQt5hcd0hTazcN4cicv5bFpS8Y=;
        b=M0pPSW/DzsUdV/t7NeIPSL0+AbfDoSIqIiAr55zcLM0u/iM3f2Xk66zHtvRbxoqDHL
         cAF3CxmIoAewPP2MViY3HDUnKffsWG/rL3nY58ek5hQPsu1hx9LI1vJ52bhg+SaTjkYh
         f3C5m6baUYbh71tjUPR8297NYwLaYIblSD8K2XUGQytXy8rd4rYgTFkMRcHpJlZ4gJfD
         yhBJQvzXSfJD/8TQsBTaaD3uWTwK9OUQJvYdexqI9VdTzTbsspaOm0kJ5nZgevAMPWJe
         ld+89MR5sautz2+SUh3UJ9Af6/CLVD3y4eG/hiHoJ7EStItfDuaekX2v/rELD6AmLWQJ
         6kLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776604577; x=1777209377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VQ8hIJNEE9cPoA2WcZQt5hcd0hTazcN4cicv5bFpS8Y=;
        b=R8fisxJ3jZcu9T/gL7B+LMUxEFrxLhDS/RWnH0Nah1DmGCow/ClGvdAnYxJP5Xg0UR
         vitQ4KbeAnL5NAlvFxWH+g4ekpQfdkUwDShL19jGhiGZGsUN+ZFfJ6olbWcgTzF4a8ay
         EIS1nrSRZqix5/YkjzwYNwWeMMn62Z9oyVmWWKjQgguFI1XXCbrgZ4Vw30ol9zQEIySA
         TAtRgt5esZrpubrx0+bPxDI4m/C5uA0bQs+FOY4a1SQhKwgYAngbFxOnaiP48k7ruXup
         xaSJNX67J9wC7WShrXL3Qq30i5GVgMZAuaZAWsELXw/CDrrG2JF07jHuKzI/m8IAfBny
         dq3A==
X-Gm-Message-State: AOJu0YyVe0/8MhuP2AqPMs84p5E1hP6u28X5jYr8fnNyJdFM+gbeLWAZ
	NUS9U/1DY9xE813DD6D+NLY5Wn7gy0gqsksFhA0y1yJ7YgNgXbtSFlmH75DAJA==
X-Gm-Gg: AeBDievu96tW9RLB9JXeh9ewPLemjSN4Pd1K86aqWjwIcXdNUa/YMvboXrFpHGygapQ
	bJLVQJJZkvJLfR87e0CLi0l7e2BI8/RbpPuUSkYzIgEitBCScq7uXioy1hT1uaYUZAEr5FyUHOF
	e8gkI6CTPV8ZQascmF03JMAVmdMn4YibsKRFK3zRYzY2mV0XaVJqD3fttq01zh0qO9tmKs1Hk9a
	FnVSEGrTJwZs/wAb9X8PBw6B7AwT+mVBkAOjxF5nkM8Z563Ci84jKQryGXTyo9RgtmegcqGibkg
	CvQyliUwzN/qFydyGLz983hTqFidpy7d29NYcMn2CPuQzbNRz6KM4JiXjozP1lQ9hF9ruSUyNx5
	kto89kUWpQnSr7zVoDeY38frzeKsJGIUY1IRBmw0UT8zyOHu8MP1b6B1hcyLZaq7gn221RulyNY
	tXihTOzPG7Pp7OQTHxqffgcEB67QuNXvk7JwaA9pkdT7s/5HxL2SOnrESTC6xI98yulYs=
X-Received: by 2002:a05:6a00:bc90:b0:82f:2b0:2809 with SMTP id d2e1a72fcca58-82f8c7dbe19mr9676585b3a.1.1776604577479;
        Sun, 19 Apr 2026 06:16:17 -0700 (PDT)
Received: from localhost.localdomain ([45.114.151.61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f97eb5ce8sm5557779b3a.61.2026.04.19.06.16.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Apr 2026 06:16:17 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Nithurshen <nithurshen.dev@gmail.com>
Subject: [PATCH 2/2] erofs-utils: libzstd: fix undefined behavior shift in setdictsize
Date: Sun, 19 Apr 2026 18:46:04 +0530
Message-ID: <20260419131604.95875-2-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260419131604.95875-1-nithurshen.dev@gmail.com>
References: <20260419131604.95875-1-nithurshen.dev@gmail.com>
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
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.20 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-3327-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,linux.alibaba.com,gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: DAECF424117
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In erofs_compressor_libzstd_setdictsize(), if pclustersize_max is 0,
dict_size becomes 0, leading to undefined behavior when calling
ilog2(0). This results in an invalid bit shift (e.g., shifting
a 32-bit value by 63 bits), as reported by cppcheck.

Fix this by adding guards to ensure dict_size is non-zero before
performing power-of-two rounding and validation.

Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
---
 lib/compressor_libzstd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/compressor_libzstd.c b/lib/compressor_libzstd.c
index 6330f44..eb768de 100644
--- a/lib/compressor_libzstd.c
+++ b/lib/compressor_libzstd.c
@@ -123,10 +123,11 @@ static int erofs_compressor_libzstd_setdictsize(struct erofs_compress *c,
 		} else {
 			dict_size = min_t(u32, Z_EROFS_ZSTD_MAX_DICT_SIZE,
 					  pclustersize_max << 3);
-			dict_size = 1U << ilog2(dict_size);
+			if (dict_size)
+				dict_size = 1U << ilog2(dict_size);
 		}
 	}
-	if (dict_size != 1U << ilog2(dict_size) ||
+	if (!dict_size || dict_size != 1U << ilog2(dict_size) ||
 	    dict_size > Z_EROFS_ZSTD_MAX_DICT_SIZE) {
 		erofs_err("invalid dictionary size %u", dict_size);
 		return -EINVAL;
-- 
2.52.0


