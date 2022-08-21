Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFB659B42C
	for <lists+linux-erofs@lfdr.de>; Sun, 21 Aug 2022 15:58:22 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M9cXB2f3mz3c6J
	for <lists+linux-erofs@lfdr.de>; Sun, 21 Aug 2022 23:58:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Bb6iM8Rp;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Bb6iM8Rp;
	dkim-atps=neutral
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M9cX229hyz3bXn
	for <linux-erofs@lists.ozlabs.org>; Sun, 21 Aug 2022 23:58:09 +1000 (AEST)
Received: by mail-pl1-x635.google.com with SMTP id u22so7788641plq.12
        for <linux-erofs@lists.ozlabs.org>; Sun, 21 Aug 2022 06:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc;
        bh=CyB1iVoJ13rLKpWUs9On76v+K/qZR0cvZmq+2m/XQmo=;
        b=Bb6iM8RpQu2AJC4iLgnjODwKjnoig+DNqa2WkMbG5Pksxi+rr5eeQRZlkOMxJopt/p
         lSL9nlnSTgXz1q4lyGv97PAEOTYvggYPSngq8iqWxKbHOaU4kT0Oj8L+qYF56RYay9B+
         hHVtoHrXL2V59UisC2EjBAlXarrkTOS3P/sE7TJIrMtoW3N6ddOi6XEqq5LmUDzbqNle
         ozMEBuZuqkwBCJp5TwGOCqiNt1l6yuVxNE39F63YT64NtTL9Ud5ySSyGp4m4dvuNd8Ae
         xMTdTAAggprZYzHAHJHE3RX6e7sfN86TesCn87x3CnMuLKQZIHY+4aKXRVBsJrsMsjVw
         mUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=CyB1iVoJ13rLKpWUs9On76v+K/qZR0cvZmq+2m/XQmo=;
        b=qo+k7leFsnbY2zrEtcuGby03Uebe6AAV5jVZWPCymWVCdu+VxP6Y6SLK8C1E0L7DXB
         DLyeuMGSOhGQX2Lj6qVQVj/qMb5d5X/OTDTZZIJjTS811tuaQIASpwP0bCTBGKQmkQEm
         sXkpDParAk4IuZhWbvZEsRu+qmcL5CWSpBP55h3HPDUej8twO2vTD3RHBNvJg1FQGgri
         9vc+7rScOhWuN4Xy9vk6XgNhQWQh+cYApALmjreJNMgjWtQikw1McN9mPfE9UvdhHfDD
         VHJsLa5GTNMnqcJKXJyZ0eg0y8ApxMe70AO7cTHSVcwVX1k6IlxSztM1wg5Qxfj5b8Of
         hYCg==
X-Gm-Message-State: ACgBeo3IM+lj3k5kJqHjdF2NkFEEggAJ+f0lV+GxWXpkujZoW1Hm50xK
	3kl8G0f4neZ2euSniHL4ZPf914DTHfg=
X-Google-Smtp-Source: AA6agR5Dr5Ep7TXy+bLM3qZhAwQyF5JDa7QwKZ2Ud08DgIQMb9qooCj8Ha73yWW0ecYx9Hj4f1sByA==
X-Received: by 2002:a17:90b:1a88:b0:1f7:3daa:f2f6 with SMTP id ng8-20020a17090b1a8800b001f73daaf2f6mr24207134pjb.245.1661090286759;
        Sun, 21 Aug 2022 06:58:06 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id g29-20020aa796bd000000b00535e46171c1sm6088318pfk.117.2022.08.21.06.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 06:58:06 -0700 (PDT)
From: zbestahu@gmail.com
X-Google-Original-From: huyue2@coolpad.com
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v4 2/3] erofs-utils: lib: support on-disk offset for shifted decompression
Date: Sun, 21 Aug 2022 21:57:24 +0800
Message-Id: <9f59c86102b06555e39e62c99ca288647120ee01.1661087840.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1661087840.git.huyue2@coolpad.com>
References: <cover.1661087840.git.huyue2@coolpad.com>
In-Reply-To: <cover.1661087840.git.huyue2@coolpad.com>
References: <cover.1661087840.git.huyue2@coolpad.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, shaojunjun@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

Add support to uncompressed data layout with on-disk offset for
compressed files.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 include/erofs/decompress.h |  3 +++
 lib/data.c                 |  8 +++++++-
 lib/decompress.c           | 10 ++++++++--
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/erofs/decompress.h b/include/erofs/decompress.h
index 82bf7b8..b622df5 100644
--- a/include/erofs/decompress.h
+++ b/include/erofs/decompress.h
@@ -23,6 +23,9 @@ struct z_erofs_decompress_req {
 	unsigned int decodedskip;
 	unsigned int inputsize, decodedlength;
 
+	/* head offset of uncompressed data */
+	unsigned int shiftedhead;
+
 	/* indicate the algorithm will be used for decompression */
 	unsigned int alg;
 	bool partial_decoding;
diff --git a/lib/data.c b/lib/data.c
index 2af73c7..008790d 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -226,7 +226,7 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 	};
 	struct erofs_map_dev mdev;
 	bool partial;
-	unsigned int bufsize = 0;
+	unsigned int bufsize = 0, head;
 	char *raw = NULL;
 	int ret = 0;
 
@@ -307,10 +307,16 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 		if (ret < 0)
 			break;
 
+		head = 0;
+		if (erofs_sb_has_fragments() &&
+		    map.m_algorithmformat == Z_EROFS_COMPRESSION_SHIFTED)
+			head = erofs_blkoff(end);
+
 		ret = z_erofs_decompress(&(struct z_erofs_decompress_req) {
 					.in = raw,
 					.out = buffer + end - offset,
 					.decodedskip = skip,
+					.shiftedhead = head,
 					.inputsize = map.m_plen,
 					.decodedlength = length,
 					.alg = map.m_algorithmformat,
diff --git a/lib/decompress.c b/lib/decompress.c
index 1661f91..08a0861 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -132,14 +132,20 @@ out:
 int z_erofs_decompress(struct z_erofs_decompress_req *rq)
 {
 	if (rq->alg == Z_EROFS_COMPRESSION_SHIFTED) {
+		unsigned int count, rightpart;
+
 		if (rq->inputsize > EROFS_BLKSIZ)
 			return -EFSCORRUPTED;
 
 		DBG_BUGON(rq->decodedlength > EROFS_BLKSIZ);
 		DBG_BUGON(rq->decodedlength < rq->decodedskip);
 
-		memcpy(rq->out, rq->in + rq->decodedskip,
-		       rq->decodedlength - rq->decodedskip);
+		count = rq->decodedlength - rq->decodedskip;
+		rightpart = min(EROFS_BLKSIZ - rq->shiftedhead, count);
+
+		memcpy(rq->out, rq->in + (erofs_sb_has_fragments() ?
+		       rq->shiftedhead : rq->decodedskip), rightpart);
+		memcpy(rq->out + rightpart, rq->in, count - rightpart);
 		return 0;
 	}
 
-- 
2.17.1

