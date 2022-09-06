Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 222AE5AE837
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Sep 2022 14:33:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MMPtN61H6z2yx2
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Sep 2022 22:33:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=VgbUiEmr;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=VgbUiEmr;
	dkim-atps=neutral
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MMPtC0HXsz2xRq
	for <linux-erofs@lists.ozlabs.org>; Tue,  6 Sep 2022 22:32:50 +1000 (AEST)
Received: by mail-pl1-x62c.google.com with SMTP id jm11so11098974plb.13
        for <linux-erofs@lists.ozlabs.org>; Tue, 06 Sep 2022 05:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=NaqE7j0Dfa/JDJrTLC0947UdzuN7zw2z+ZdzoX+1wZo=;
        b=VgbUiEmrQhYlhtRAVMVU8ikiWK7V7ujouXHIm42fmZSnWGFHa8lKHOWTkaVTmax/mF
         WHEQhqImDpjWU+WR//L/h9+Wqz7NGINJB+ouQZFFBaadhVRtrfxDY28f23U8f1KFlwwe
         8TLoadzmeBlP5ysKPA4Dn99CEmkwMC6mCr1GC8dphSGPA0vA5ST9ku8J1xGMgd+0rSNm
         pJl1kp4+ZvK7dtkyHeIQiXI2JUVd1XICGbziSwbE7Fbu7oC8S4QSQ0K/lIy3VmpcOlok
         6hhjeeUFKccaxzPC1mmnTjCadluJksGkEKFpgeqVLwTgwFDPo7VlPogg9kfoxYge9Ax5
         0b2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=NaqE7j0Dfa/JDJrTLC0947UdzuN7zw2z+ZdzoX+1wZo=;
        b=Y7AMWBMNjXB9DOhYE0dXcSxXbBNRwApT07yFnwWLSmDoagcdMcIimOdmaMfiltXoRM
         +54nSdiF8SxFq0nFuXVYeeMyg10wWuLpSeqYnw3T+xBQPxnUIYngU2RLhNEIO+0jPi2M
         kGws9Ac1pt/Qj0XP4oFpqRS1H4sr7KZ+b130TUef3bWHUxEQFxQhaKvwBLdMf8Qw0VKu
         cIAlDueR/lqzSGOYdF3hLyv6co36AFmruc9+3mpnJgmf1zbD23i27PLkEn1+XUPdj/7Y
         8QaTmNl79falB4lQt7k2K/o3me23yi52vWLwR9ZCsW/XCMtfhbIWt/Aeb2U5j6GQsuQY
         kj+A==
X-Gm-Message-State: ACgBeo3dhwhaLbKAqLQm2DQX3Ts7JZblpr8j2LvSnTzHhArTGvCC9A97
	JRSJXBsFiYAEPEAmPodzqF2V6D7wso4=
X-Google-Smtp-Source: AA6agR7rgPsMff9VOqfGr56CiNrwqxGB0vqjzngNppvbkCkEhp6lpiGIT1cb5NA/1ieZyyQGwPskAw==
X-Received: by 2002:a17:90b:1649:b0:200:336:118f with SMTP id il9-20020a17090b164900b002000336118fmr19710175pjb.86.1662467568569;
        Tue, 06 Sep 2022 05:32:48 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001714c36a6e7sm3510993pli.284.2022.09.06.05.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 05:32:48 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH V7 3/4] erofs-utils: mkfs: support interlaced uncompressed data layout
Date: Tue,  6 Sep 2022 20:32:34 +0800
Message-Id: <440364c96a52460618b3679ccca118168f1a5344.1662460303.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1662460303.git.huyue2@coolpad.com>
References: <cover.1662460303.git.huyue2@coolpad.com>
In-Reply-To: <cover.1662460303.git.huyue2@coolpad.com>
References: <cover.1662460303.git.huyue2@coolpad.com>
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

