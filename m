Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E0471F9A2
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Jun 2023 07:21:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QXWYp0H2Kz3dxN
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Jun 2023 15:21:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sijam-com.20221208.gappssmtp.com header.i=@sijam-com.20221208.gappssmtp.com header.a=rsa-sha256 header.s=20221208 header.b=UNr164ki;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=sijam.com (client-ip=2607:f8b0:4864:20::22b; helo=mail-oi1-x22b.google.com; envelope-from=asai@sijam.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sijam-com.20221208.gappssmtp.com header.i=@sijam-com.20221208.gappssmtp.com header.a=rsa-sha256 header.s=20221208 header.b=UNr164ki;
	dkim-atps=neutral
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QXWYf3s3xz3dvt
	for <linux-erofs@lists.ozlabs.org>; Fri,  2 Jun 2023 15:20:52 +1000 (AEST)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-39a50fcc719so1195381b6e.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 01 Jun 2023 22:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sijam-com.20221208.gappssmtp.com; s=20221208; t=1685683249; x=1688275249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HdFpFkJpb/nW90v/f4mFibVLmV96mE5yKgu1SZSIz8w=;
        b=UNr164kir/Aa+zXfeREGpFDuZtE0Ngjk5DAGVFUHeBVA8/ESoYST1p/pGBRm5edAG0
         lw9qVsJnRdVzbBVEzTMSq3ZhNduXER6l3+be6mWEIk6K1koxksO9ljMIbfyrQrXB9SgD
         ig1BfMCZ/vT6RqdupmLU5Uxw5IFsq+0atQ3w0om5Z8nB1bdfl+CrBQ7uQSqTNenwYeJx
         iVGOZkxyG0vNhPOgmLOOaPBY8ZmzrbiVyfyIUftC7ClHKezV5K5wOtPuHvPv7jgwJT06
         2iMEhzvPw/6Z2x77PNOEHWRLxynZ3+yOk2H6cYyDr8B8m+VCsXKN1Bk4HREtAJ8Ct5zW
         Y2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685683249; x=1688275249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HdFpFkJpb/nW90v/f4mFibVLmV96mE5yKgu1SZSIz8w=;
        b=Z+gh3N016Xh8qye+gIiLTWvkfT1+x2BqEJy0pU8jmy3m6QIKKW/DwBE5nh3+bZKPfK
         6LdbJ4/i6EdPkhY1JsstsmE2Q4RW3r0ulClQ1xaQ03/C5pIbopSOJm+U3Nr4JHVtmoGC
         Y2GTE7GudMWqM6X/AGxntNLEyoJoRcIcKbY8hN2dBWS7hM0huZFO6guQuYRnvJHVQA6w
         Ou9tI1QW8XkJElSN01d0njKBgnesgAsJxoKqFnD2BvrEKYiNp8OiHmJAQc/LFaM0Vno1
         Zrd0WeaNE4SbC3AsR4isJUnn5ZPo6hJ4h9WL42HFGy6tUsY++Z6IJvsTCaW9NC+vHivD
         XhVg==
X-Gm-Message-State: AC+VfDyzz0borCGuSBvVrPYyELYu0raNa2m7KOVUvr1Gl64k/yAkmzYg
	IZmy/m0vviWX5fwSjcXXDAw0+1oYJGQlPzNskwo=
X-Google-Smtp-Source: ACHHUZ4cdfDMi/9VbSg+o7OqOyI1EIGfUWkeO3vYVrQuqp5y/VRgp2HMNFOiva9WZbaHZqP0tPlO+w==
X-Received: by 2002:a05:6808:4d4:b0:398:f91:9660 with SMTP id a20-20020a05680804d400b003980f919660mr1438790oie.47.1685683249164;
        Thu, 01 Jun 2023 22:20:49 -0700 (PDT)
Received: from elric.localdomain (i121-112-72-48.s41.a027.ap.plala.or.jp. [121.112.72.48])
        by smtp.gmail.com with ESMTPSA id y12-20020a170903010c00b001aaea39043dsm343317plc.41.2023.06.01.22.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 22:20:48 -0700 (PDT)
From: Noboru Asai <asai@sijam.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com
Subject: [PATCH] erofs-utils: limit pclustersize in z_erofs_fixup_deduped_fragment()
Date: Fri,  2 Jun 2023 14:20:39 +0900
Message-Id: <20230602052039.615632-1-asai@sijam.com>
X-Mailer: git-send-email 2.40.1
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The variable 'ctx->pclustersize' could be larger than max pclustersize.

Signed-off-by: Noboru Asai <asai@sijam.com>
---
 lib/compress.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 2e1dfb3..e943056 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -359,8 +359,9 @@ static bool z_erofs_fixup_deduped_fragment(struct z_erofs_vle_compress_ctx *ctx,
 
 	/* try to fix again if it gets larger (should be rare) */
 	if (inode->fragment_size < newsize) {
-		ctx->pclustersize = roundup(newsize - inode->fragment_size,
-					    erofs_blksiz());
+		ctx->pclustersize = min(z_erofs_get_max_pclusterblks(inode) * erofs_blksiz(),
+					roundup(newsize - inode->fragment_size,
+						erofs_blksiz()));
 		return false;
 	}
 
-- 
2.40.1

