Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A724F3EE54C
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Aug 2021 06:07:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GpctH3lQKz308f
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Aug 2021 14:07:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=In3WKkXn;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102c;
 helo=mail-pj1-x102c.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=In3WKkXn; dkim-atps=neutral
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gpct83yfDz302d
 for <linux-erofs@lists.ozlabs.org>; Tue, 17 Aug 2021 14:06:54 +1000 (AEST)
Received: by mail-pj1-x102c.google.com with SMTP id
 n13-20020a17090a4e0d00b0017946980d8dso2730759pjh.5
 for <linux-erofs@lists.ozlabs.org>; Mon, 16 Aug 2021 21:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Gv/KRmQkaRD68+dzf+e0Q4DuYE4pfQDXLsDt9tMjElY=;
 b=In3WKkXn4v/2dnhnHnXDPCHeAipNCMmcBdaGLQxiZUeWO4lgFTeN+2x+MTxjx99oeB
 iK8u1Xm0U0akT3SN1KGCafCxYxd/Roo7h5IxSX7TlsErSy2dSaSsJA+nS7bRvHj7vWhX
 PSn0u/t7cjD/waJlFvUum24sEbtZEr8VqnvwhFwcD9+FCBGOw2kDUQc4wfejVfijQNES
 tIE95OWPLBGaG9gi6VU0/MvydNZQrMJAZ6hUcGduNKUPvO6qyFXnokEYRMba7ShxmHWP
 kwm9WbGAqesvHXMI8ovbf+MOtnTrHanwcyQkr4KKAbifpLhGIgPpRUWPGHcW9/OryG0b
 jnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Gv/KRmQkaRD68+dzf+e0Q4DuYE4pfQDXLsDt9tMjElY=;
 b=fEeXBvqUy2FAxBATc8BYHoXDUyX2va5O4pC4XReBgj0azIPKEDl+w7quRjabZgsKmw
 IB+NvCoeBymxz+KYfjK+5ARiYQeEAkg2GAg9LtIHWNHqeRaxPHWxE8v2LggOBTl43bNj
 dmuEVbv+ALcRSKOqzoOO1qmm0tJSQ0cxkvBLGrzqXStCOU8zHAh39NpLCBC3UPS3tU7j
 oor9tZ7P+948+YgVe14RLTwzfWno2EuQItz4cFFFWYOauHDwH4I7PjbYNCxA3hIAHklV
 7NWkyaekQKpylYcoA6qpLnidAiw2zhRP9dHGWeJ1LuENQVzK6m5UrSXlwty2gbaBqwxL
 mw0g==
X-Gm-Message-State: AOAM530l3rNMhBFbClWWf7NLSNRntM24s8JdXUSj/jfBLqa4/8Sa85Tf
 5b71jx8/jnM5LQFci+nS2Ad0c+fFT6UsBA==
X-Google-Smtp-Source: ABdhPJwnf+/X324yvnlNyqAU2E33jWHSfZrEGu5c+qEMabNJWgiVRh0QI6ZliU9jnYSw5X1jgtlW/w==
X-Received: by 2002:a17:902:8a98:b029:12c:3177:c3ef with SMTP id
 p24-20020a1709028a98b029012c3177c3efmr1253027plo.21.1629173211159; 
 Mon, 16 Aug 2021 21:06:51 -0700 (PDT)
Received: from tj.ccdomain.com ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id u21sm808772pgk.57.2021.08.16.21.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Aug 2021 21:06:50 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org
Subject: [PATCH] erofs-utils: add clusterofs zero check to
 write_uncompressed_extent()
Date: Tue, 17 Aug 2021 12:06:04 +0800
Message-Id: <20210817040605.732-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
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
Cc: huyue2@yulong.com, zbestahu@163.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@yulong.com>

No need to reset clusterofs to 0 if it's already 0. Acturally, we also
observed that case frequently. Let's avoid it.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 lib/compress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/compress.c b/lib/compress.c
index 40723a1..a8ebbc1 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -130,7 +130,7 @@ static int write_uncompressed_extent(struct z_erofs_vle_compress_ctx *ctx,
 	unsigned int count;
 
 	/* reset clusterofs to 0 if permitted */
-	if (!erofs_sb_has_lz4_0padding() &&
+	if (!erofs_sb_has_lz4_0padding() && ctx->clusterofs &&
 	    ctx->head >= ctx->clusterofs) {
 		ctx->head -= ctx->clusterofs;
 		*len += ctx->clusterofs;
-- 
1.9.1

