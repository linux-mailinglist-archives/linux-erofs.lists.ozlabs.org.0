Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A0E57EC6A
	for <lists+linux-erofs@lfdr.de>; Sat, 23 Jul 2022 09:17:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lqd1S6wwSz3bmY
	for <lists+linux-erofs@lfdr.de>; Sat, 23 Jul 2022 17:17:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=SkxdbuRx;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=SkxdbuRx;
	dkim-atps=neutral
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Lqd1K0Szjz3blb
	for <linux-erofs@lists.ozlabs.org>; Sat, 23 Jul 2022 17:17:39 +1000 (AEST)
Received: by mail-pl1-x634.google.com with SMTP id q5so6246561plr.11
        for <linux-erofs@lists.ozlabs.org>; Sat, 23 Jul 2022 00:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=xvSPk/kMBjNo78lXbzngYRP4R7U33XUYvUp+I4vHPog=;
        b=SkxdbuRxr5IguDQYWFFUr6FT0260xz12JV3LVwpWKd83re4GtbB+kM/Fp3tGOBHRr+
         4dn3rhBJdJsPC6vW26MdKwdu5bnC+T3oi2/Oc3eGop97LLPzVoPusuo6jq94zJrEXpug
         KDKaLvq1dRCVujYTu1DRhVtYT9pEuKpKg3qE9JeuH+4UFGEfwuklyamft42dzrKZjQAC
         uQak1x1iv22sYxIbQsgAO6F42bCZpYzw8aKvtmJ6AtkNAmlROcqmWzWo7CB4CkX48w24
         tjjk6HOPyV1PoCLtyUirDWDYHAjsSSdOmNN75czctWRiUE42Ict+B+swxUeogQ37gtaW
         PL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=xvSPk/kMBjNo78lXbzngYRP4R7U33XUYvUp+I4vHPog=;
        b=3NGBK38url8atoeRbS9qI4Rvjm1ZpvsTPKMpZRZE3jwLGihNWoaRhggE1yZvlFdohC
         P4plrZmIgQwsGEiTZHdwV7o3hgQ/3it2/PWrFqZXHeHZFJEllsngNCOfVT8yehkvwjpa
         76rReDN+o+S0XEEx13BXfQpAvoHLUO5eR1fqGko3B2GNdSL9ZsffR5E2AQh8hNF2wF+9
         yo0VJsCVsPDEXbxDyGYngJs3LjwBKF5bna+sAWdoFaETjB94OkDxrRKA0lct4zM9hBGU
         +vUUP3nRFAfhFceCPeC+MjXgNIpo6T9HlIGm6lpS9Zvlis2co1c53c9TuDPp+eY3SHbw
         n8Ig==
X-Gm-Message-State: AJIora/WBvH/WDYuvBaxbFknRwlmUcR0/NNWnsQf5pN3uB6PYr8X9yvk
	rqQMHm2o+wX1mm/NtSgna2Jf8pZfB14=
X-Google-Smtp-Source: AGRyM1tiUPc7jlo/80ZxFv2E0Z49sIl8o8k5K+RgodTZDckayuplvGEHrQB1/fgeSO9HFe6xWMBszQ==
X-Received: by 2002:a17:902:e886:b0:16d:5184:11fa with SMTP id w6-20020a170902e88600b0016d518411famr1452406plg.2.1658560657233;
        Sat, 23 Jul 2022 00:17:37 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id y66-20020a633245000000b00411955c03e5sm4535290pgy.29.2022.07.23.00.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 00:17:37 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
X-Google-Original-From: Yue Hu <huyue2@coolpad.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v2 2/3] erofs-utils: lib: support on-disk offset for shifted decompression
Date: Sat, 23 Jul 2022 15:17:14 +0800
Message-Id: <f0063da92e828e42bbd7e876ffb2e612f205faa7.1658556336.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1658556336.git.huyue2@coolpad.com>
References: <cover.1658556336.git.huyue2@coolpad.com>
In-Reply-To: <cover.1658556336.git.huyue2@coolpad.com>
References: <cover.1658556336.git.huyue2@coolpad.com>
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
Cc: huyue2@coolpad.com, zbestahu@163.com, shaojunjun@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

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
index 2f3ebb8..16e2ffd 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -226,7 +226,7 @@ static int z_erofs_do_read_data(struct erofs_inode *inode, char *buffer,
 	};
 	struct erofs_map_dev mdev;
 	bool partial;
-	unsigned int bufsize = 0;
+	unsigned int bufsize = 0, head;
 	char *raw = NULL;
 	int ret = 0;
 
@@ -308,10 +308,16 @@ static int z_erofs_do_read_data(struct erofs_inode *inode, char *buffer,
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

