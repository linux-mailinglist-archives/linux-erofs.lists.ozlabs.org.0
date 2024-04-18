Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 421228A92A0
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Apr 2024 07:53:07 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sijam-com.20230601.gappssmtp.com header.i=@sijam-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=wo2rziTH;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VKn4d0DmTz3cRF
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Apr 2024 15:53:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sijam-com.20230601.gappssmtp.com header.i=@sijam-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=wo2rziTH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=sijam.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=asai@sijam.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VKn4K0nqXz3cTF
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Apr 2024 15:52:48 +1000 (AEST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1e0bec01232so4343185ad.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 17 Apr 2024 22:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sijam-com.20230601.gappssmtp.com; s=20230601; t=1713419566; x=1714024366; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHYuy1EXvOqPLdQda7Xe2DGhtJ/N5Gg2TY02nPWPJ6E=;
        b=wo2rziTHKKduz57PFjdwD3N70smiVDlsD9BQWmkcBsvmdAneituV8bn0gsGxxP2lld
         gFxj0tkqWKSqNFitFMs5YqON/joVS1sa6SEK4+KTywM1x8L6Z1xGYZl+w8lz0FbO52nI
         MMQ9r/r//abnxJDXbIhOm24PmYL2v+EhdC+8gwd917FJYDIBhNoEUaPwzL8BFJWePZrh
         tmtGsnr0sTjmpU5+CLh6StyYzBAJaQAY2NgTBW0TwJQUmngHOVzwNZCS4pmqF6a2k9eo
         0be3ZfgrEtRBih0t2r8fn+OQYT97m8XRD1gCqHIcv5sWf2Ftd8rKEiZ9bgtYB40TSvkr
         jfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713419566; x=1714024366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YHYuy1EXvOqPLdQda7Xe2DGhtJ/N5Gg2TY02nPWPJ6E=;
        b=AaFKjRI1VZd25ly5dU2CNWwWHM2WJiKYOQ6XS2h4E+WzGa1pr5O28WGQGWrIkldad1
         /FIzsF+GXNMzXhPne764Magk7mXSLXqklOcmrcnqdD6FaM3g50irBPnohc/GF7NQy3hc
         5ZJBoKTxVhNEuCWDlgwerl5j3Kx6UlEq2SwKGxlLFEt119V3NvuRFTxnt7QERZDHMPB+
         ApUDwWCxgmNyakavQkaDYxmxkq7gq8IMVfpjhSNNpIbobVPLw9Efs5Q7TJ0J7va/9FQ9
         RukP5ODzoWJ4FWAUQ8vrskZXj3RUkKmqjR+ZB70d2GCKTOgtlLcbTpdjTuLuhX74OZXA
         DE7A==
X-Gm-Message-State: AOJu0Ywn7p0g2UO1C6PL9fKKDRMUatQNjpbhiZjq/mAsHMtFvY4fAr1G
	/fWR5CnWBytSicJwn0VLHVQNBB924UPYT+EHUb7imrlYHiNz/n9Nv0x4y+p54xA=
X-Google-Smtp-Source: AGHT+IHNHUqKE23aiBn9tlzBHeI1PyzwGTOlTFgF0qtVN02oKdw6oG9y5PIOadV2HMrOOBMLN+JdTQ==
X-Received: by 2002:a17:902:f68b:b0:1e7:f944:b000 with SMTP id l11-20020a170902f68b00b001e7f944b000mr2169379plg.24.1713419566678;
        Wed, 17 Apr 2024 22:52:46 -0700 (PDT)
Received: from elric.localdomain (i121-112-72-48.s41.a027.ap.plala.or.jp. [121.112.72.48])
        by smtp.gmail.com with ESMTPSA id w6-20020a170902e88600b001e4ea358407sm642991plg.46.2024.04.17.22.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 22:52:46 -0700 (PDT)
From: Noboru Asai <asai@sijam.com>
To: hsiangkao@linux.alibaba.com,
	zhaoyifan@sjtu.edu.cn
Subject: [PATCH 3/3] erofs-utils: allow blkaddr == EROFS_NULL_ADDR for zpacking in write_compacted_indexes()
Date: Thu, 18 Apr 2024 14:52:31 +0900
Message-ID: <20240418055231.146591-3-asai@sijam.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418055231.146591-1-asai@sijam.com>
References: <20240418055231.146591-1-asai@sijam.com>
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

With ztailpacking, the value of blkaddr corresponding to the ztailpacking block
in the extent list is EROFS_NULL_ADDR(-1), allow this value in write_compacted_indexes()
function.

Signed-off-by: Noboru Asai <asai@sijam.com>
---
 lib/compress.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/compress.c b/lib/compress.c
index d745e5b..5b70490 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -790,7 +790,8 @@ static void *write_compacted_indexes(u8 *out,
 			*dummy_head = true;
 			update_blkaddr = false;
 
-			if (cv[i].u.blkaddr != blkaddr) {
+			if (cv[i].u.blkaddr != EROFS_NULL_ADDR &&
+			    cv[i].u.blkaddr != blkaddr) {
 				if (i + 1 != vcnt)
 					DBG_BUGON(!final);
 				DBG_BUGON(cv[i].u.blkaddr);
-- 
2.44.0

