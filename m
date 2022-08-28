Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8895A3DDF
	for <lists+linux-erofs@lfdr.de>; Sun, 28 Aug 2022 15:52:07 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MFw3n3xkNz3bbj
	for <lists+linux-erofs@lfdr.de>; Sun, 28 Aug 2022 23:52:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=HpvsL35w;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=HpvsL35w;
	dkim-atps=neutral
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MFw3X2BJgz30Lb
	for <linux-erofs@lists.ozlabs.org>; Sun, 28 Aug 2022 23:51:52 +1000 (AEST)
Received: by mail-pj1-x1029.google.com with SMTP id t5so5716404pjs.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 28 Aug 2022 06:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc;
        bh=/reJbX4sutYJGTvMEjZY4yMsPj2X/AQ8IIppPaju3EQ=;
        b=HpvsL35wzv1viF2s+v/4r/hQJvH2GB06oS99K5alO64PtNBXzpmEtiavZ8rV9UpUpR
         +NzM+p6cClolnzli27Z4/xO6IESgd3+ZiqU8mhDSYhgpSdTrRcu4SEB1sHYsuazyN4RP
         ek9YpSo9vK4OQ0Rd1eVgBM4+kiw4OSCR/qHnnzDPoLGiMSoZqo1Yx2IT17cQkMI1Oh3S
         FFEFkuskKojiPbM8T82OflOMdzz0pHB/4ZfQ5QKqviuakal67eMsp2NI29CNQoe2bKPN
         zJYJevponqjyUEN9AF3BvpSKXkhXD4djlx6aGNacFfupzc70irVbPykUHcZjCnD1tONm
         DQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=/reJbX4sutYJGTvMEjZY4yMsPj2X/AQ8IIppPaju3EQ=;
        b=hlMyfZU1cz3k1zbZ6a1qOlrbzuuLR37XwiI3+S0RbXCOj+TA6ycms2y+vR6M1uBZQp
         t8Smgyg+eialvv8ZKpX/9d8TmxQ5ffJDrpwttk1fICuS5l6RTq4laAYWA55ieF9g2sur
         rybE0RbPAQLD2CI66SJ7riSDidxu2EgTZKsPtTiD5oljGeCsvUpbmjKgHJ+6An13vkXE
         YfdXMqg4bbW72T3WbpYBzwIYc6x3V4dWLGdsDXMOBJa1CKUnOhAgqY2wem+3NGsqbAmr
         ujLAhPe0LBSz9snMYSevSS3yBL/zbpb5Am4hjb8TzBCpn3gXkSQ68oYVj2y920iwxb53
         MJZA==
X-Gm-Message-State: ACgBeo3Xy7a7T2DSWmDU7CUL5mRkveJ+nOvapXQvFwdhahycR5JUR8x/
	6VkXSaFRdGxkf7dauVnqYgxM4tR5ZO0=
X-Google-Smtp-Source: AA6agR7TY6/6II1+0biHo/QkKFtyW8Hz0DzL+C645xiM3LW67fmd6jjP4p1OP6URklWEuZEbdEVEvg==
X-Received: by 2002:a17:90b:3b4f:b0:1fb:5b03:6822 with SMTP id ot15-20020a17090b3b4f00b001fb5b036822mr13919304pjb.87.1661694709903;
        Sun, 28 Aug 2022 06:51:49 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id o9-20020a17090a4b4900b001fbb0f0b00fsm4795754pjl.35.2022.08.28.06.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 06:51:49 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v5 3/4] erofs-utils: lib: support interlaced uncompressed data layout when compressing
Date: Sun, 28 Aug 2022 21:51:08 +0800
Message-Id: <c531940d290489a643ccab65206cc80bc74e6702.1661694414.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1661687617.git.huyue2@coolpad.com>
References: <cover.1661687617.git.huyue2@coolpad.com>
In-Reply-To: <cover.1661694414.git.huyue2@coolpad.com>
References: <cover.1661694414.git.huyue2@coolpad.com>
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

This can benefit from in-place I/O we are using.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 lib/compress.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index fd02053..3f02fee 100644
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
+	unsigned int count, interlaced_offset, rcopied, rzeroed;
 
 	/* reset clusterofs to 0 if permitted */
 	if (!erofs_sb_has_lz4_0padding() && ctx->clusterofs &&
@@ -153,11 +154,26 @@ static int write_uncompressed_extent(struct z_erofs_vle_compress_ctx *ctx,
 		ctx->clusterofs = 0;
 	}
 
-	/* write uncompressed data */
+	/*
+	 * write uncompressed data from clusterofs which can benefit from
+	 * in-place I/O, loop shift right when to exceed EROFS_BLKSIZ.
+	 */
 	count = min(EROFS_BLKSIZ, *len);
 
-	memcpy(dst, ctx->queue + ctx->head, count);
-	memset(dst + count, 0, EROFS_BLKSIZ - count);
+	if (0) { /* ENABLEME */
+		interlaced_offset = ctx->clusterofs;
+		inode->z_advise |= Z_EROFS_ADVISE_INTERLACED_PCLUSTER;
+	} else {
+		interlaced_offset = 0;
+	}
+	rcopied = min(EROFS_BLKSIZ - interlaced_offset, count);
+	rzeroed = EROFS_BLKSIZ - interlaced_offset - rcopied;
+
+	memcpy(dst + interlaced_offset, ctx->queue + ctx->head, rcopied);
+	memcpy(dst, ctx->queue + ctx->head + rcopied, count - rcopied);
+
+	memset(dst + interlaced_offset + rcopied, 0, rzeroed);
+	memset(dst + count - rcopied, 0, EROFS_BLKSIZ - count - rzeroed);
 
 	erofs_dbg("Writing %u uncompressed data to block %u",
 		  count, ctx->blkaddr);
@@ -263,7 +279,8 @@ static int vle_compress_one(struct erofs_inode *inode,
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

