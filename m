Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0655C5AB215
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Sep 2022 15:51:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MJzpZ285Rz2yxZ
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Sep 2022 23:51:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=OWTK6Y3P;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=OWTK6Y3P;
	dkim-atps=neutral
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MJzpP4zWTz2xyD
	for <linux-erofs@lists.ozlabs.org>; Fri,  2 Sep 2022 23:51:08 +1000 (AEST)
Received: by mail-pl1-x62a.google.com with SMTP id c2so1951409plo.3
        for <linux-erofs@lists.ozlabs.org>; Fri, 02 Sep 2022 06:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=zNUF4pLM2gZEdiAVUHg/D43GzpVxrjgPWBN3pmIBL4Q=;
        b=OWTK6Y3PL2yw7UqNBd3BKxNCZm3WWdoiwL1O1myrStMFLYjzS/PshODfkZouf8TdyM
         34cfblzJlfbsqzNTY6EcRcNxJC+uL41ewK3gT6X1TwMuFzMCqa191Inwq/0gtQUyzuNO
         cddhry2HZJMnpVcKm2BU+YBLOvZt/QL7bUiOR4zophKpy1XohzLV0QP4JcY1npbc9+x/
         vnpntCAk0tMhTT0Ghf1CTgl2cxobFno1trWx76Ijdugmfyr5paHVZm2dJ1CWMxpUWtRU
         FfyyJzCZoPRyw/CXk4ycMlyeefC51asE+FfRfTG42UBFQ5JYu76DePVZJ+j8JUeA6X/c
         SD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zNUF4pLM2gZEdiAVUHg/D43GzpVxrjgPWBN3pmIBL4Q=;
        b=zxpevGp0VX9hDS998dXQ51pnn5UB5/XOlYtZ8bVj97bPZieqxm38MhSbd3h9HhI2u+
         7qXABY2VPLM3/jtZFwIz0/BexHJLppYMAlvQxTwTyhsVEdDj0uTnjtcLmAxB5MkiaKKI
         xRCkXDqKtjtobQNhVO5gxp0L/hDO/yvnLE7Cf+M9nNqVosFYx/Qz5GeigNI9MxFmQjEs
         0XU6M22ggA8lB3Ci/FmHHTilS/kC3Kn2h30k+3Beun9s2YSh2OsykjJ1Z/oYuSDimCGp
         8isT6hGFYYS1nS+gLwy83NuZDor6fpZnc4wZlGpAr8brD9EFlP1LzFEs68e5sSyCN5TI
         2Y6Q==
X-Gm-Message-State: ACgBeo0aATpJip1h0MCg0/HypC+EgD53IuaEc7sVMtnXXIOgQFrP8F10
	WuGTEoZMrocP0mT6AY/jAuE=
X-Google-Smtp-Source: AA6agR62SVCb2fOMwXF20SiASjjKCcM0ENGQ/zfWNHw3aYk/dQ1Z0bmkeiGXxhGn8OHTbPIjNQ3wbw==
X-Received: by 2002:a17:902:f64d:b0:172:d004:8b2d with SMTP id m13-20020a170902f64d00b00172d0048b2dmr36077767plg.14.1662126664789;
        Fri, 02 Sep 2022 06:51:04 -0700 (PDT)
Received: from localhost.localdomain ([49.77.180.166])
        by smtp.gmail.com with ESMTPSA id e16-20020aa798d0000000b005360da6b26bsm1733739pfm.159.2022.09.02.06.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 06:51:04 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org
Subject: [RFC PATCH v2] erofs: support uncompressed pcluster with more than 1 block
Date: Fri,  2 Sep 2022 21:50:36 +0800
Message-Id: <20220902135036.11595-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

The length of uncompressed pcluster may exceed one block in some new
scenarios such as non 4K-sized lcluster (which will be supported later).
So, let's support the decompression for this firstly.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
v2: fix tail data length.

 fs/erofs/decompressor.c | 64 ++++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 23 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 2d55569f96ac..77d2b6cb6eda 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -320,41 +320,59 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq,
 static int z_erofs_shifted_transform(struct z_erofs_decompress_req *rq,
 				     struct page **pagepool)
 {
+	const unsigned int nrpages_in = rq->inputsize >> PAGE_SHIFT;
 	const unsigned int nrpages_out =
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
-	const unsigned int righthalf = min_t(unsigned int, rq->outputsize,
-					     PAGE_SIZE - rq->pageofs_out);
-	const unsigned int lefthalf = rq->outputsize - righthalf;
+	unsigned int righthalf, lefthalf, i;
 	unsigned char *src, *dst;
 
-	if (nrpages_out > 2) {
+	if (nrpages_in == 1 && nrpages_out > 2) {
 		DBG_BUGON(1);
 		return -EIO;
 	}
 
-	if (rq->out[0] == *rq->in) {
-		DBG_BUGON(nrpages_out != 1);
-		return 0;
-	}
+	i = 0;
+	do {
+		unsigned int outputsize = rq->outputsize;
+
+		righthalf = min_t(unsigned int, outputsize,
+				  PAGE_SIZE - rq->pageofs_out);
+		lefthalf = min_t(unsigned int, outputsize - righthalf,
+				 PAGE_SIZE - righthalf);
+
+		src = kmap_atomic(rq->in[i]) + rq->pageofs_in;
+		if (rq->out[i]) {
+			if (rq->out[i] == rq->in[i]) {
+				DBG_BUGON(nrpages_in == 1 && nrpages_out != 1);
+			} else {
+				dst = kmap_atomic(rq->out[i]);
+				memcpy(dst + rq->pageofs_out, src, righthalf);
+				kunmap_atomic(dst);
+			}
+		}
 
-	src = kmap_atomic(*rq->in) + rq->pageofs_in;
-	if (rq->out[0]) {
-		dst = kmap_atomic(rq->out[0]);
-		memcpy(dst + rq->pageofs_out, src, righthalf);
-		kunmap_atomic(dst);
-	}
+		if (i + 1 == nrpages_out) {
+			kunmap_atomic(src);
+			break;
+		}
 
-	if (nrpages_out == 2) {
-		DBG_BUGON(!rq->out[1]);
-		if (rq->out[1] == *rq->in) {
-			memmove(src, src + righthalf, lefthalf);
+		if (rq->out[i + 1]) {
+			if (rq->out[i + 1] == rq->in[i]) {
+				memmove(src, src + righthalf, lefthalf);
+			} else {
+				dst = kmap_atomic(rq->out[i + 1]);
+				memcpy(dst, src + righthalf, lefthalf);
+				kunmap_atomic(dst);
+			}
 		} else {
-			dst = kmap_atomic(rq->out[1]);
-			memcpy(dst, src + righthalf, lefthalf);
-			kunmap_atomic(dst);
+			DBG_BUGON(nrpages_in == 1 && nrpages_out == 2);
 		}
-	}
-	kunmap_atomic(src);
+		kunmap_atomic(src);
+
+		if (outputsize > PAGE_SIZE)
+			outputsize -= PAGE_SIZE;
+	} while (++i < nrpages_in);
+
 	return 0;
 }
 
-- 
2.17.1

