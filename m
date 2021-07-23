Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 374BB3D34AB
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Jul 2021 08:28:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GWKBV15P2z303L
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Jul 2021 16:28:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=XZneUd2O;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62c;
 helo=mail-pl1-x62c.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=XZneUd2O; dkim-atps=neutral
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GWKBP0brtz2xtv
 for <linux-erofs@lists.ozlabs.org>; Fri, 23 Jul 2021 16:27:56 +1000 (AEST)
Received: by mail-pl1-x62c.google.com with SMTP id n10so2139993plf.4
 for <linux-erofs@lists.ozlabs.org>; Thu, 22 Jul 2021 23:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9wYg47XczjPbE3ZmzvUn30hkDX90rTnMC7RvcxCdQ8g=;
 b=XZneUd2Olqs4eFfdgHuojaxqbsFxZFwQ4E2YvCChCDCazTAYQWAV4UlcTUbzDTs8S7
 Hfjr0NGrfR5MV2MZJW+gFu55V4B2gM+JfyWgXizPVCRsFyCO2FtxlEZHnit4MoJZcAh2
 k1gH6L0/Vv+geFkbgOmSKwb0Eu4NyfMnavbfja4IqzpbsahWakxtml+wecnwHdPdg9kY
 bAPAnnanq8H+XS+tEfqyRHoMb5fn8ZD2Tl1JYaGTM3MIwmMWsDWM8kx+6Exv9SQ79DRN
 N0BFZog4OOBaRuQJ6Lfi6bhe7dmCv2ca6JagHs/LP3Ztb6idVA7VaSyemGvUt2zFfAoG
 6ung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9wYg47XczjPbE3ZmzvUn30hkDX90rTnMC7RvcxCdQ8g=;
 b=lCLYy0qQFyNljmGi17afjAfyZ95Q1h9v49/EdLAC2mGWnIP5FlwVDfvxN9gMOo+/R5
 hK2gyBHdpayru3tWrR2muAI9zHUj11NtokfqMjH9oOozt2aMYMa70rU7VcPmJf/nlgVL
 Yl76op+9w3VJTc1YSOJ4UO95Bn6pYSvLj7wb+1N5Cxy/D+iPkAmONMtkYAfxUhNaXXH3
 ubh+t0OBe7Ko8ABwLWGmaXTw3wmSiCqX84eHMIGdC/ZmevD1ljj2hCxEL/M3y3jq6nWY
 DkP9Kryg0Udmpc7OJdnupIn39wys3xyqRI7XVF6Pb6YGg4xi9A9SxAlNGipYMSywb2kc
 1XHg==
X-Gm-Message-State: AOAM530DWmHxIe23BxVl+UDLlg5WxmPjk10Uw35Qp8vdstPM6mTrEEsm
 Da/g5V+OMNKmo/aSYypjC0Qketdyp6RAug==
X-Google-Smtp-Source: ABdhPJwFVV1fscIQV7JV+lM80aveQGtV7Le4eENZECUqQl8s4ZITvXuOroyoL0eynu6IOxYxMgcwaA==
X-Received: by 2002:a17:903:189:b029:12b:3fd7:d95d with SMTP id
 z9-20020a1709030189b029012b3fd7d95dmr2937173plg.24.1627021673013; 
 Thu, 22 Jul 2021 23:27:53 -0700 (PDT)
Received: from tj.ccdomain.com ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id w16sm36969814pgi.41.2021.07.22.23.27.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jul 2021 23:27:52 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org
Subject: [PATCH v2] erofs-utils: no compression case for tail-end block in
 vle_write_indexes()
Date: Fri, 23 Jul 2021 14:27:39 +0800
Message-Id: <20210723062739.1415-1-zbestahu@gmail.com>
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
Cc: huyue2@yulong.com, yuchao0@huawei.com, zhangwen@yulong.com,
 zbestahu@163.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@yulong.com>

Note that count value will be always greater than EROFS_BLKSIZ when
calling erofs_compress_destsize() in vle_compress_one(). So, the d1
always >= 1 for compressed block in vle_write_indexes(). That is to
say tail-end block can't be compressed.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
v2: add DBG_BUGON(!raw), a TODO comment.

 lib/compress.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index af0c720..40723a1 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -73,10 +73,11 @@ static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
 
 	di.di_clusterofs = cpu_to_le16(ctx->clusterofs);
 
-	/* whether the tail-end (un)compressed block or not */
+	/* whether the tail-end uncompressed block or not */
 	if (!d1) {
-		type = raw ? Z_EROFS_VLE_CLUSTER_TYPE_PLAIN :
-			Z_EROFS_VLE_CLUSTER_TYPE_HEAD;
+		/* TODO: tail-packing inline compressed data */
+		DBG_BUGON(!raw);
+		type = Z_EROFS_VLE_CLUSTER_TYPE_PLAIN;
 		advise = cpu_to_le16(type << Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT);
 
 		di.di_advise = advise;
-- 
1.9.1

