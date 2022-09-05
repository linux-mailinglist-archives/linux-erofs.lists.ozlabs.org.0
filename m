Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A5F5AC8E4
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Sep 2022 04:52:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MLY2v2zYVz300l
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Sep 2022 12:52:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=KS9rVULv;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=KS9rVULv;
	dkim-atps=neutral
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MLY2q6rkpz2yWl
	for <linux-erofs@lists.ozlabs.org>; Mon,  5 Sep 2022 12:52:19 +1000 (AEST)
Received: by mail-pg1-x535.google.com with SMTP id q63so6949141pga.9
        for <linux-erofs@lists.ozlabs.org>; Sun, 04 Sep 2022 19:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=XYjN5lCzbHoFRvPw87nv7GSMGFiv+rXmIHlgogPYD78=;
        b=KS9rVULvIRKH48Om6LQ+6iIm24kAIIRDXu3FYYwmVPYgGZhiXgA2mZfKwomCcTgp+G
         +yPI7l0/4oph4/cyGMmTnrQUalwz8X6AWBnrqKnGyAhWHrNDhEW0y7ZSu3jkmFFziKjh
         5Zz7fpfuLlSlAxVayvP7djE54cL5wdcYdIiVnZ0gEwrbNTEv5IDyvPDHIz0W73TfIGlt
         uBo4HD1On+Sp1AF0+LNk1hBF+lAUUUD9ARrD3EJcCErkO4GoLfK4dR22d7SKxartlkJq
         w1dzYGnscJZT34tbaT9tbyNvM30G2x1PiNdKMZRI7y/XcxOpELrXSptum3PG4TFmHaRp
         giGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=XYjN5lCzbHoFRvPw87nv7GSMGFiv+rXmIHlgogPYD78=;
        b=Bsf0GDA0f5oONR7hqIxJRUAp/UIKNHnQ+UfGHGkis4PgVynXyvbOmEj6sbrLpyhOdC
         Chfgn/CZAIxtPZt7AoQwDXLXwvru6EdDbbLTTEPH9cKbraNvnjCqCcqY0kVyzqlsxoxk
         ctq4L7ktVKmn8ynAJRhdFAxgiJJ3gNgLb9oqEML8zmlxWAugzxHSyjA4LFR2ZTDuSnoq
         ZC65kNMla13rFDh/ErOx1nOzLOAmHln2AkglOnEyZl69LdqpUU6FhPSTJ903krgTpEJD
         9PNmqZptKzy15FbyzCobWDS+LnqY9MlDp5lxuxrqr+U2jd5WfJFAVLzRE7M+ksuliTia
         6ROQ==
X-Gm-Message-State: ACgBeo03yj9BVZZ5I9b9zK6YecPEOh5sGHDLfXF0JSe/n8XuAMpLlmT4
	0XVvXJ3CU0JntTyc43wYYOe4mC0Kzkw=
X-Google-Smtp-Source: AA6agR7ii4RJul/+7uaDLJSDKbX7JAMxUJsi5s33pC3AB56V40ENiplAYE459/gc0+Y3L+eQgaWRuQ==
X-Received: by 2002:a63:1f1b:0:b0:429:b4be:72f0 with SMTP id f27-20020a631f1b000000b00429b4be72f0mr39391296pgf.622.1662346337074;
        Sun, 04 Sep 2022 19:52:17 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id i194-20020a6287cb000000b0053788e9f865sm6378729pfe.21.2022.09.04.19.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 19:52:16 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v6 3/4] erofs-utils: mkfs: support interlaced uncompressed data layout
Date: Mon,  5 Sep 2022 10:51:46 +0800
Message-Id: <a499aa4f070de64ab8dac9d4168d83f78cc53ac9.1662345408.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <5a6077e3e3745ae80f2a0fc13444898e86cc838d.1662345408.git.huyue2@coolpad.com>
References: <5a6077e3e3745ae80f2a0fc13444898e86cc838d.1662345408.git.huyue2@coolpad.com>
In-Reply-To: <cover.1662345408.git.huyue2@coolpad.com>
References: <cover.1662345408.git.huyue2@coolpad.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

This can benefit from in-place I/O we are using.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
v6: clean all first + cleanup + minor change to title

 lib/compress.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index fd02053..4bd4e6b 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -139,11 +139,12 @@ static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
 	ctx->clusterofs = clusterofs + count;
 }
 
-static int write_uncompressed_extent(struct z_erofs_vle_compress_ctx *ctx,
+static int write_uncompressed_extent(struct erofs_inode *inode,
+				     struct z_erofs_vle_compress_ctx *ctx,
 				     unsigned int *len, char *dst)
 {
 	int ret;
-	unsigned int count;
+	unsigned int count, interlaced_offset, rightpart;
 
 	/* reset clusterofs to 0 if permitted */
 	if (!erofs_sb_has_lz4_0padding() && ctx->clusterofs &&
@@ -153,11 +154,19 @@ static int write_uncompressed_extent(struct z_erofs_vle_compress_ctx *ctx,
 		ctx->clusterofs = 0;
 	}
 
-	/* write uncompressed data */
 	count = min(EROFS_BLKSIZ, *len);
 
-	memcpy(dst, ctx->queue + ctx->head, count);
-	memset(dst + count, 0, EROFS_BLKSIZ - count);
+	/*
+	 * write uncompressed data from clusterofs which can benefit from
+	 * in-place I/O, loop shift right when to exceed EROFS_BLKSIZ.
+	 */
+	interlaced_offset = 0; /* will set it to clusterofs */
+	rightpart = min(EROFS_BLKSIZ - interlaced_offset, count);
+
+	memset(dst, 0, EROFS_BLKSIZ);
+
+	memcpy(dst + interlaced_offset, ctx->queue + ctx->head, rightpart);
+	memcpy(dst, ctx->queue + ctx->head + rightpart, count - rightpart);
 
 	erofs_dbg("Writing %u uncompressed data to block %u",
 		  count, ctx->blkaddr);
@@ -263,7 +272,8 @@ static int vle_compress_one(struct erofs_inode *inode,
 						len, true);
 			else
 nocompression:
-				ret = write_uncompressed_extent(ctx, &len, dst);
+				ret = write_uncompressed_extent(inode, ctx,
+								&len, dst);
 
 			if (ret < 0)
 				return ret;
-- 
2.17.1

