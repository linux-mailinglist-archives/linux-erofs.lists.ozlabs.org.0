Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E80C75B6C03
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Sep 2022 12:55:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MRgP10Sq4z3bc8
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Sep 2022 20:55:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=W2KTiu2D;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=W2KTiu2D;
	dkim-atps=neutral
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MRgNs1jLHz2xbd
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Sep 2022 20:55:40 +1000 (AEST)
Received: by mail-pg1-x536.google.com with SMTP id g4so11000946pgc.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 13 Sep 2022 03:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=NaqE7j0Dfa/JDJrTLC0947UdzuN7zw2z+ZdzoX+1wZo=;
        b=W2KTiu2D1b+ktdB8YZJY4s2P4WHhJA8Uf8xAZo4LkNHU1/ZN6LUn/BTg4hvq0y8X2u
         DkrZsgV/SHpEYm5oBRknHyuGTTTy/qXqCtnLU7zlwGAcfAaWlDltYl8X6kGzBLfn1Epg
         pCNU13Ye9jpIe7ouXI1iK4K3s2plT1iv+/nudHFM5wvpbYOtCl0RPht0AIQB+oHWWbiR
         FE6XA1fV85XZnJi+nG8Mr3Uiic0yRQ84Q4kCPuffI4OiBOVhiiLy77NyhyRwfdnAwp8S
         eHtLy6OYZwu58nNmkbOb5WwAx/fYqEo6mCaY8OKvVfyBw3vgztX0msU78iBNw4N+tWtN
         sF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=NaqE7j0Dfa/JDJrTLC0947UdzuN7zw2z+ZdzoX+1wZo=;
        b=ydCsy2xXncRX3vZnkT3jUxnwYPXJUIIdG/VUYhAuRdn+SnilOe10GgMmrMX1b3WVrb
         h+fFO7Q8CLn90XTlLzUD+5O/0tRmpxw6+azWZAsYvv4WEjcD+auivwLmc1N/Mt9VrRw7
         k98dcH/lTPahlIH60CgBCbDrihDeO69hjmKWVrAHFIyCWUaeHbC5e7JHj1expzAsy3jW
         b+aHQzB0j3F6KQHAMTxH++Kb7FMrLGcCxgbkhaXOjObUIUvmJE8oO09r8X3ePlQNpJ5/
         IWoby2gcVUAVeaS7drnVs/IvE50smdVdhCHcv3ZzdzBDm+flqLKkVOfGN6mSJQfukDTX
         iqeg==
X-Gm-Message-State: ACgBeo0B9CQThrXMG+opfzXxzDcCgOVU3kNS5F+jG3hNNujVc1dIssSa
	n3RD55qcgtKA2Hwj6/A+yaiw36nB78M=
X-Google-Smtp-Source: AA6agR7pUSCqh8ihbjw1d/tpQ68cH/Xy3iVVIU3DA5aRgTgFaDmD6urmVbHkrs6f19cJVV4U1qNIpA==
X-Received: by 2002:aa7:88c9:0:b0:541:2b7:d655 with SMTP id k9-20020aa788c9000000b0054102b7d655mr19471852pff.72.1663066538638;
        Tue, 13 Sep 2022 03:55:38 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id g17-20020aa796b1000000b0054097cb2da6sm7475290pfk.38.2022.09.13.03.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 03:55:38 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v8 3/4] erofs-utils: mkfs: support interlaced uncompressed data layout
Date: Tue, 13 Sep 2022 18:54:48 +0800
Message-Id: <69558595652813c0eb2374e562bc83021a127a79.1663065968.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1663065968.git.huyue2@coolpad.com>
References: <cover.1663065968.git.huyue2@coolpad.com>
In-Reply-To: <cover.1663065968.git.huyue2@coolpad.com>
References: <cover.1663065968.git.huyue2@coolpad.com>
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

