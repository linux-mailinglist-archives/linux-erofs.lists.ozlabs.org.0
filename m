Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325B09302ED
	for <lists+linux-erofs@lfdr.de>; Sat, 13 Jul 2024 03:04:37 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=P3vUCHdQ;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WLVc11mygz3cZ1
	for <lists+linux-erofs@lfdr.de>; Sat, 13 Jul 2024 11:04:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=P3vUCHdQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2607:f8b0:4864:20::236; helo=mail-oi1-x236.google.com; envelope-from=dan.carpenter@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WLVbw1yF6z30WW
	for <linux-erofs@lists.ozlabs.org>; Sat, 13 Jul 2024 11:04:24 +1000 (AEST)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3dab2bb288aso163916b6e.3
        for <linux-erofs@lists.ozlabs.org>; Fri, 12 Jul 2024 18:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720832659; x=1721437459; darn=lists.ozlabs.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yH7mUDs9iCLcnupWVzAlTv4cUV/drEJ2d5DV9IL4ZtM=;
        b=P3vUCHdQyu6J1qmdxolMVCgCXn40nllIjz5iEA6kxSVK+ukqPOoxm2PZYeaZGM8zZT
         v7p9HZlxzRUexskvFTt4JrO/JY+EUybND7eaibOnVmuLnZKA+9onP5FHx7oSTtd7WoSz
         LxAEy/6GMIA3PnXPhwkD0tzpzjfDHESXQ2+82fYS2vk+9nmeY5ou+mKIsnQniCQlFFxn
         yUG5L5UW58Lkcr4NjC+LdnOwbzybKyMLY0Q+UMtsZtiA4UFmVhooUPmYFZKIPYAnNJD/
         vHP7igg3aaZT+cbkPkxr2sfX2FeVTKvy0AVuU9McnNJlS/NRTIvnmniS3HuxtW05nDkC
         GHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720832659; x=1721437459;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yH7mUDs9iCLcnupWVzAlTv4cUV/drEJ2d5DV9IL4ZtM=;
        b=T415HeaMcI26rbTIoLuioTkZNCbHLVClEeZJUl7/SaTIOMnNSOopcEduf4ddxEKCW7
         ydr6+8FqOXI/y7PZBiBJSU82QkW7BtgTitEqWfue1+aqFihJjEObHfqSmXEhFV05rFO1
         B9Z3BkPZmAQRNF9fuMkl1ARfyKGyp3GWG6GqtimweZcnOJmThA8GbmzrhDYpTEXYULy5
         gRrb2QG+O/mIfwyekY1BVHNgBLQZ7lHQotBpEl1LveEhgW1JqYLfR17SfuBR8JovcIOB
         M9yT0JEm5gUet3wrWZSXht+YOavGpWi1QNUIT1z0kS6/CX1j8qrOjQ+UxCeCi27VvFTP
         LkIw==
X-Forwarded-Encrypted: i=1; AJvYcCWDG9+Ac08UKAF50V1HOxYfPsP8qEpd5a6DBXTuVqKjF/3Cnv0YZo4YfsLCoVWQ2IL7wDf5m6v+o+av6TY8xR7Q3U6RdgM2W1O6tUYu
X-Gm-Message-State: AOJu0YxE9VQFkNWnlyBJ6Mcd2HvW178xMHp6Ag69Mg+3kWiWIPN4yk6t
	C3CrJ21h/6d+nax8uxwdB7QbIMyP7LdVaOnXQiB4+hMt9kGUhipaeo9qkR21VqE=
X-Google-Smtp-Source: AGHT+IGQ/I0WaFhGJFtcL3N/xdoeqsNKfep4fanzD9WvQoCVAUijIIi04JLfIvB+6AR9sfiTtDBmRA==
X-Received: by 2002:a05:6808:17a5:b0:3d2:23e0:d7aa with SMTP id 5614622812f47-3d93bef8b38mr17705419b6e.13.1720832659290;
        Fri, 12 Jul 2024 18:04:19 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::1cb1])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dab3e1d054sm25642b6e.53.2024.07.12.18.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 18:04:18 -0700 (PDT)
Date: Fri, 12 Jul 2024 20:04:16 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Gao Xiang <xiang@kernel.org>
Subject: [PATCH] erofs: silence uninitialized variable warning in
 z_erofs_scan_folio()
Message-ID: <f78ab50e-ed6d-4275-8dd4-a4159fa565a2@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Smatch complains that:

    fs/erofs/zdata.c:1047 z_erofs_scan_folio()
    error: uninitialized symbol 'err'.

The issue is if we hit this (!(map->m_flags & EROFS_MAP_MAPPED)) {
condition then "err" isn't set.  It's inside a loop so we would have to
hit that condition on every iteration.  Initialize "err" to zero to
solve this.

Fixes: 5b9654efb604 ("erofs: teach z_erofs_scan_folios() to handle multi-page folios")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/erofs/zdata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index aff3cdf114ad..ac5ffd4674e4 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -962,7 +962,7 @@ static int z_erofs_scan_folio(struct z_erofs_decompress_frontend *f,
 	const unsigned int bs = i_blocksize(inode);
 	unsigned int end = folio_size(folio), split = 0, cur, pgs;
 	bool tight, excl;
-	int err;
+	int err = 0;
 
 	tight = (bs == PAGE_SIZE);
 	z_erofs_onlinefolio_init(folio);
-- 
2.43.0

