Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6850A56F9E9
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Jul 2022 11:10:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LhJ5H2Z4xz3by2
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Jul 2022 19:10:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=UquCQV6K;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=UquCQV6K;
	dkim-atps=neutral
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LhJ5425vHz3bf5
	for <linux-erofs@lists.ozlabs.org>; Mon, 11 Jul 2022 19:10:32 +1000 (AEST)
Received: by mail-pl1-x634.google.com with SMTP id d5so3902640plo.12
        for <linux-erofs@lists.ozlabs.org>; Mon, 11 Jul 2022 02:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=dAImj3SWIPNnau/kHdHa+K0fEY1n3FRm7Zg1qUEE2/o=;
        b=UquCQV6K31t8HJN/kMNQaFY1xpM7wE5ORI8AUQERVNZNtQMNcAYfm+2vNcLwWfRKlU
         9oITaWdIFIEOzh7RkOuSbZxoCzYJxsIe7/GqgJmUu6X9LadTNjT+HPQeZVhsuUMICINb
         K5sfGIaMlmIL7FTHa20FqeuuexH1yt87N8yrjUbXedMKWzbrVqeuog7jye2sq4hwbRz1
         FCeLaQg/ngehGq5dAW9lG96orpkt2vrT8i1E6kIfX2hSIdMgH06eKb4SSuBBYNZxPdNd
         ULIaSkz1mE7PKvE9qH9lp+GwKRwzr+qE4SQ2hAii4rgKi8O/FVFuqZ51/l71/exEzZyI
         ZZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=dAImj3SWIPNnau/kHdHa+K0fEY1n3FRm7Zg1qUEE2/o=;
        b=wEmHNOuEzHSuv3gtRLLdfm3n/Bp/8QE1B6te2KIs3jnY0Zil3w97w0tDa577A/5rkD
         kEHFT8IzExu4SkggvOQLUqxuo40GPimAzAWxQlEM+TO0bRD2em4Q+2Ws7JHoS6afnFxl
         3eJWO+EpOZPqjMu44ArTQWXMts/H6wrPLEE1+d3XFI66CtwOPxQIedbODCUNnQGDTS1f
         jm3qb+Pqu/pmwYHffXCaPLTZrDErDVTjJ79/Dx1Mi7V4MMyKPxGToYWcR3P6XqPmS6bF
         3+kQS9z5s9gGTov2cPwRDE2Jb6qDybY3pLniLhbqAmK0+XryfWTDHF/u5kfepjnp/ZjG
         EjNQ==
X-Gm-Message-State: AJIora9Fkro8XmTF9KRouEJHa6gtvCjk5fkzKwcC+q7zuemHBhdpsBib
	WLsb0Hrx09YsBdTwOiqjYdYZs5B98NQ=
X-Google-Smtp-Source: AGRyM1uCKc0js+ncGbc5wxYIYJbci/QtbrPZ7IlKxl+Q8tLFABZY8WQ/jI07DFzgFyMh5kfJH1BSSQ==
X-Received: by 2002:a17:902:e885:b0:16c:49c9:792a with SMTP id w5-20020a170902e88500b0016c49c9792amr4513941plg.11.1657530629914;
        Mon, 11 Jul 2022 02:10:29 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id n2-20020a170902968200b00165105518f6sm4145052plp.287.2022.07.11.02.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 02:10:29 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
X-Google-Original-From: Yue Hu <huyue2@coolpad.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH 2/3] erofs-utils: lib: support on-disk offset for shifted decompression
Date: Mon, 11 Jul 2022 17:09:57 +0800
Message-Id: <3b38c6f8c6e16b74042602144997e62bdd3259da.1657530420.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1657528899.git.huyue2@coolpad.com>
References: <cover.1657528899.git.huyue2@coolpad.com>
In-Reply-To: <cover.1657530420.git.huyue2@coolpad.com>
References: <cover.1657530420.git.huyue2@coolpad.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, zhangwen@coolpad.com, shaojunjun@coolpad.com, zbestahu@163.com
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
index c2ecbc9..5e44db9 100644
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
 
@@ -313,10 +313,16 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
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

