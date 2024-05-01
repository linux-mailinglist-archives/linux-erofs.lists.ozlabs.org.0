Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0F98B8455
	for <lists+linux-erofs@lfdr.de>; Wed,  1 May 2024 04:24:36 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sijam-com.20230601.gappssmtp.com header.i=@sijam-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=Y++/s7iL;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VTgr16k5wz3cQX
	for <lists+linux-erofs@lfdr.de>; Wed,  1 May 2024 12:24:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sijam-com.20230601.gappssmtp.com header.i=@sijam-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=Y++/s7iL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=sijam.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=asai@sijam.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VTgqy526pz2xHK
	for <linux-erofs@lists.ozlabs.org>; Wed,  1 May 2024 12:24:29 +1000 (AEST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1e40042c13eso43867565ad.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 30 Apr 2024 19:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sijam-com.20230601.gappssmtp.com; s=20230601; t=1714530267; x=1715135067; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=32f1ZCVs2gJe254KMGVTpOHvGyTNbH4XQHR5SD3X1yI=;
        b=Y++/s7iL5PVr3XKYB4VZ2b/PhVTNEN2gB4tREeHeBOMfKlDR7xiRd9W5DJGlumToYt
         cyFWz3+VrdUj6aONu1rcruFhC/4qjChuplW/Xaq9ZmS/jwZMOWkz123mVBc/CIamRHcr
         FfICTL2MO379cO4jSR2pO+vGcX+IMd1FIcoLJsnVVWToVEbCh/3peq2OGwreec6cvo9G
         iusRrsSfNVcXY8Hogq8tVfVWe61TsaNZShORJhYYLRY8oxJNVxJ6NNKCCnqbPG9ZrSWT
         N79VlT2PlaWSPoNdDKAtkl5mCPYlRmb5ribNl3QA2ivg9wOLXdI70IEY6LvpJPSV0L/m
         UtUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714530267; x=1715135067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=32f1ZCVs2gJe254KMGVTpOHvGyTNbH4XQHR5SD3X1yI=;
        b=dosYn7Ua320jYiaEzqxU6Oq7agsYJLbQ1l/YB3SDW+pUt/Vg36Wini7MHpIM/5pkQ4
         yVuoGB84RI+ODMRSaoxizFv/9QxkRB055tOyjokz50QvodvUoo6ZyD+d6HOutEMKghrZ
         /I8Atdzqgi+AWGewJn9UvKNriL2fagFSn1bf1O4gqi4J7QpvUPk1L7NelZnCxFmoBY+Y
         KsQ0kytlKfUvl1fAV5+d94eH9XD8IcgHbioNfr+gzpT1vC3qBZz8rxNhLDm0heJ0gLW7
         MG5mRRcnbh6AXO1ysvux800D2GFaB1A6JbUEVZKxLaGiLaBSxORjCajni6TtTZ8DC0b+
         CavQ==
X-Gm-Message-State: AOJu0YzhW3Zw3pErp7IQB3PAHcQ43qSvgXPgUz4R5zZsbIo3zUwQVk2M
	FeDhdz1sjWhEsafS7LI+D9HuAPu0eFHygnolh6pmzIZsf1vKvTIzvzTvBSrosKzfb4fS4M+JiAx
	fGfE=
X-Google-Smtp-Source: AGHT+IGEh5PUPz5U3ySpehLR1dPp3g2I5U523yOQ9UD0kI/GmmHCdnerg6qmes6etVPwRMYVu0Ww8w==
X-Received: by 2002:a17:902:ce0f:b0:1e3:e081:d29b with SMTP id k15-20020a170902ce0f00b001e3e081d29bmr1447148plg.45.1714530266934;
        Tue, 30 Apr 2024 19:24:26 -0700 (PDT)
Received: from elric.localdomain (i121-112-72-48.s41.a027.ap.plala.or.jp. [121.112.72.48])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902dac600b001eb03a2bb0asm8895621plx.53.2024.04.30.19.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 19:24:26 -0700 (PDT)
From: Noboru Asai <asai@sijam.com>
To: hsiangkao@linux.alibaba.com
Subject: [PATCH] erofs-utils: optimize pthread_cond_signal calling
Date: Wed,  1 May 2024 11:24:20 +0900
Message-ID: <20240501022420.1881305-1-asai@sijam.com>
X-Mailer: git-send-email 2.44.0
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

Call pthread_cond_signal once per file.

Signed-off-by: Noboru Asai <asai@sijam.com>
---
 lib/compress.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 7fef698..5c25ca8 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1261,8 +1261,8 @@ void z_erofs_mt_workfn(struct erofs_work *work, void *tlsp)
 out:
 	cwork->errcode = ret;
 	pthread_mutex_lock(&ictx->mutex);
-	++ictx->nfini;
-	pthread_cond_signal(&ictx->cond);
+	if (++ictx->nfini == ictx->seg_num)
+		pthread_cond_signal(&ictx->cond);
 	pthread_mutex_unlock(&ictx->mutex);
 }
 
-- 
2.44.0

