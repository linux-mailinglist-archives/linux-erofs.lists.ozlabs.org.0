Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FAA79F4C5
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Sep 2023 00:11:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1694643111;
	bh=y/9bzfpE8MaVK7XAgft626Lce4zdbHmctlBy9duFWEo=;
	h=Date:In-Reply-To:References:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=POyXoXnBXvsggPWwHkAURY2zJxDD6wGcAUcE3ofEuHSmbhcajCFX/i+cXg6L7ME5B
	 tOyxi+jnAoNuk1AjMF6ZrvZ4afstNd67Q/VPklir4Ol+lSSJZ7Z7tWELDQIPhEUk9z
	 LPlU1CCrECGR/pLoGityhOKwbWo9I2Z2dhWagVXlN9LEckrGgqfvuWeDfTmanclf6e
	 WJpjlBFq6D3RZUFeF6aKdV91N3BUkj7/3IzXZ/Hcn2nfwQHOymQbS48Zc74x97zElg
	 whLAhRqPK8TGoW7KmBXh2Rvfm99tqB8JmGYdYB3DddOMhtx1HDYJrbafW+2xUwLIQ4
	 FnK6vrxzl0GXA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RmF6b6YtHz3cDR
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Sep 2023 08:11:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=SnLYH+Tz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::1149; helo=mail-yw1-x1149.google.com; envelope-from=3jzmczqckcy4nrkfkvoqyyqvo.mywvsxeh-obypcvscdc.yjvklc.ybq@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RmF690sc3z3cC5
	for <linux-erofs@lists.ozlabs.org>; Thu, 14 Sep 2023 08:11:29 +1000 (AEST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58fb8933e18so3921187b3.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 13 Sep 2023 15:11:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694643087; x=1695247887;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y/9bzfpE8MaVK7XAgft626Lce4zdbHmctlBy9duFWEo=;
        b=hvcks8VhjxjGo3uQ9I9Dw1AgEeCzNlA7R45h65OdwSmfTLtISxNd09WZXZTKWUTns8
         Q7MWnY/I+f1azagNogJoi4/WhskjGEUIovBRPwdN2ekBBUDGe6plyRnv0Fmn4eaO6mqa
         IeBmQg4SSZ4c0CdqM0ZZ2fv0w3BHX7Yy1MsrRG5S5CQeDTpOjxHSohsVFxsufcXWxPit
         DOWfs9cYFSKGVmPGXG+p++60I9EbnCnGs41Z/jZOjMQFZDYCfo1GyLmyw1B8KuVBSERk
         oZPRwN5XUqn26TxISfWJDOJH+eFtFKa4yvza+/ChBDJGcNdOA6FH3Cbv/htW1wUikcKc
         SfEQ==
X-Gm-Message-State: AOJu0YyjLPv5qSsTfoe36PUR3+68EDmPqoDQ+anWo8V8oyt6gtnDt1cF
	ynZ/XSXlVZ+pik5j63KdG6YApgpT/1v8P7t2FJ4KVKuPPiRBhm0b1LVIZAVDTzt3xgppVnSlf/d
	gpQwhIuF2UbrHvWpH9ushVLJToerhva5nrtjrvkUpbA25GdBM3t24vSK5+CwENNVxQVzifvSu
X-Google-Smtp-Source: AGHT+IEUMhR+1IVQPD3t5+48WnFY4h8BoKWVI15Ez9J0GIYE7XSWOfVjZFkwQtlsnGYIQPp1sdEU4IBFsLeQ
X-Received: from dhavale-ctop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:5e39])
 (user=dhavale job=sendgmr) by 2002:a25:d113:0:b0:d81:4107:7a1 with SMTP id
 i19-20020a25d113000000b00d81410707a1mr88370ybg.2.1694643087004; Wed, 13 Sep
 2023 15:11:27 -0700 (PDT)
Date: Wed, 13 Sep 2023 15:11:02 -0700
In-Reply-To: <20230913221104.429825-1-dhavale@google.com>
Mime-Version: 1.0
References: <20230913221104.429825-1-dhavale@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230913221104.429825-6-dhavale@google.com>
Subject: [PATCH v1 5/7] erofs-utils: lib: Fix the memory leak in error path
To: linux-erofs@lists.ozlabs.org, hsiangkao@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
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
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: kernel-team@android.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

If call to inflateInit2() fails, release the memory allocated for buff
before returning.

Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
 lib/decompress.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/decompress.c b/lib/decompress.c
index 01f0141..fe8a40c 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -126,8 +126,10 @@ static int z_erofs_decompress_deflate(struct z_erofs_decompress_req *rq)
 	strm.avail_in = 0;
 	strm.next_in = Z_NULL;
 	ret = inflateInit2(&strm, -15);
-	if (ret != Z_OK)
+	if (ret != Z_OK) {
+		free(buff);
 		return zerr(ret);
+	}
 
 	strm.next_in = src + inputmargin;
 	strm.avail_in = rq->inputsize - inputmargin;
-- 
2.42.0.283.g2d96d420d3-goog

