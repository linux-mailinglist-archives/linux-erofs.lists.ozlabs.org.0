Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DBA59B8DE
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Aug 2022 07:53:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MB1kS5Twvz3blJ
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Aug 2022 15:53:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=pNCUfvV+;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=pNCUfvV+;
	dkim-atps=neutral
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MB1kM3Wwfz3bZs
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Aug 2022 15:53:29 +1000 (AEST)
Received: by mail-pf1-x42d.google.com with SMTP id 1so2142859pfu.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 21 Aug 2022 22:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc;
        bh=O/M4gOzUrS+M1rmwcv2FdRwcaAkd5vB4biny3T6F6f4=;
        b=pNCUfvV+iKyU66Tmc1O3WHyKIWWwat/XYwIpOtl6bavoGIBn1SVzgRaalxmVXonCVa
         qaI/96P8I9/QgLqRp5MZ8bV5ZekprrUkpyKFqY/sltIlr+9ZSq+fx6groR0cOllX6o4L
         cDY2oEn4oKnsWBGfzbJeWnbgqYIlWRkqkaud1dm13ZvlQRsXqTVk0HVmIoSBAfnZFRtu
         VrCHpomQLv57X3DnTo/qErpzUSCITvsDMF0vxX7J8J3RCabeerbzFhbUM4S5EcjA5sdG
         C5BbC1MqQjy99z4b79txqQu/QxRwcHjOzYmxMUybjOqu1lUuocUmT/HYKEPIUkimz0lD
         mR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=O/M4gOzUrS+M1rmwcv2FdRwcaAkd5vB4biny3T6F6f4=;
        b=My2O8IpQmcF8Q0HFdf+qEnHSxYSBqG7cbXGKuzfL5r/jCLkKGAM6sp3V05iZxO2/TL
         d6DPvsPpyFOGjtPdzW6yS2e6ifqLThnc6XKuEw6KKREmEp+8tL1Ce+kXO2Kij5ujHtRU
         sZcCq9mUwPPdhL6eMP2fPlDrggPXDqZHIvkYUD1bKL8ZCFVTQzIFM4MuSroQ/BAEnFnC
         A37Y0bt34jvjrqRZRFLTkE/+WelyGN7Jj6jpXR0e1OInms/gwTIofleEDRQ+bJeGVhMI
         TNgqg0fKiFSfwJI33rduI+Xyar2Vz2FiAj/Fr+0KM0mZWf/ganbxqrhibGRhvWh5UCt5
         XnZw==
X-Gm-Message-State: ACgBeo1PuXQ8HdHJv9HJMI1pBCNpAHei2EL0viQxwK6Sq+N1YVz7LES+
	uA4qXGhDLSBEsNPaJnDZteY=
X-Google-Smtp-Source: AA6agR6uey2bQTOUFCW+XJ2KWuVJB6sj2RiunNYq6PyFdwCzeEFUMCOEgEzAn+7NvdRLAx1uTJ7ISQ==
X-Received: by 2002:a63:2cc6:0:b0:41c:5f9c:e15c with SMTP id s189-20020a632cc6000000b0041c5f9ce15cmr15384463pgs.241.1661147606740;
        Sun, 21 Aug 2022 22:53:26 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id cu14-20020a17090afa8e00b001f23db09351sm7078817pjb.46.2022.08.21.22.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 22:53:26 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org
Subject: [RFC PATCH 1/2] erofs: support on-disk offset for shifted decompression
Date: Mon, 22 Aug 2022 13:53:00 +0800
Message-Id: <d424334dc32483e93baf0a215dab88c90d14e5c2.1661146058.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1661146058.git.huyue2@coolpad.com>
References: <cover.1661146058.git.huyue2@coolpad.com>
In-Reply-To: <cover.1661146058.git.huyue2@coolpad.com>
References: <cover.1661146058.git.huyue2@coolpad.com>
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

Currently, there is no start offset when writing uncompressed data to
disk blocks for compressed files. However, we are using in-place I/O
which will decrease the number of memory copies a lot if we write it
just from an offset of 'pageofs_out'. So, let's support it.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/decompressor.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 2d55569f96ac..dc02d95b52d7 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -326,6 +326,7 @@ static int z_erofs_shifted_transform(struct z_erofs_decompress_req *rq,
 					     PAGE_SIZE - rq->pageofs_out);
 	const unsigned int lefthalf = rq->outputsize - righthalf;
 	unsigned char *src, *dst;
+	unsigned int headofs_in;
 
 	if (nrpages_out > 2) {
 		DBG_BUGON(1);
@@ -337,21 +338,25 @@ static int z_erofs_shifted_transform(struct z_erofs_decompress_req *rq,
 		return 0;
 	}
 
+	/* set it to pageofs_out if fragments feature is used */
+	headofs_in = 0;
+
 	src = kmap_atomic(*rq->in) + rq->pageofs_in;
 	if (rq->out[0]) {
 		dst = kmap_atomic(rq->out[0]);
-		memcpy(dst + rq->pageofs_out, src, righthalf);
+		memcpy(dst + rq->pageofs_out, src + headofs_in, righthalf);
 		kunmap_atomic(dst);
 	}
 
 	if (nrpages_out == 2) {
 		DBG_BUGON(!rq->out[1]);
-		if (rq->out[1] == *rq->in) {
-			memmove(src, src + righthalf, lefthalf);
-		} else {
+		if (rq->out[1] != *rq->in) {
 			dst = kmap_atomic(rq->out[1]);
-			memcpy(dst, src + righthalf, lefthalf);
+			memcpy(dst, src + (headofs_in ? 0 : righthalf),
+			       lefthalf);
 			kunmap_atomic(dst);
+		} else if (!headofs_in) {
+			memmove(src, src + righthalf, lefthalf);
 		}
 	}
 	kunmap_atomic(src);
-- 
2.17.1

