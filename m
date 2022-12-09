Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A75647CA9
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Dec 2022 04:54:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NSxwM1Gwlz3bbJ
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Dec 2022 14:54:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=O1rYO1Mc;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=O1rYO1Mc;
	dkim-atps=neutral
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NSxwD2n1Nz2yRV
	for <linux-erofs@lists.ozlabs.org>; Fri,  9 Dec 2022 14:54:03 +1100 (AEDT)
Received: by mail-pf1-x431.google.com with SMTP id t18so2802604pfq.13
        for <linux-erofs@lists.ozlabs.org>; Thu, 08 Dec 2022 19:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOhCE5cIfiw7Mx1VgqbMEntY03WvstAD+tMaMCDfHZg=;
        b=O1rYO1Mcp4vw6Bu/X+ei+hDFt3qoqmPZPEDKw78tXXz/vQYkRHAuEzU/w0o6QY9obo
         0DPTOUrvJ/7YQ8SINSBPULPVoMpMb7K7fWBS1U0nDZnB4FVK2zQnT2oqqGPMIcNvDyw6
         4onTHzZ8i2ijkBLGCqTyrzuFQ4YD0zraB5XM0prYVmhBPZ8BQRml3V99AA9g3WxWg3YP
         kdE7Xa6Azh31R94uJIj0slR51ueJJ2IcCoE51IRChZekcF5DlwQr5fgAWrCwsRgtaK9j
         dPfO2pP8UZv03n8h10ZJynfSR2H3WHmtCoAXcVxwZTf1elwlc3D7FiIhRDZkerl2xlZM
         1HKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OOhCE5cIfiw7Mx1VgqbMEntY03WvstAD+tMaMCDfHZg=;
        b=wtEeyscjSZ665fQOiJTOyfMijD28VtC9pc9xNAJs/wz1srcrCmIrru6xvB2Pwtx8gW
         bK+ZuglnnzCXU5VfVXurfKSxchNDFNKVjIrPlc63cP2Hlb1t2JefAyA69bZP6Le2ohaZ
         itdxiIS4bRl+Wd208Ndzk4SlxIIyCPHvf1fdtIvJ0EXBG6vZGJ0XzyeRMFChvwn6Wd5c
         H+coDxLyaaR1wF30pZMlM4wxLYPUxza3WF299o+D2Sdf5Fg3kYSpuKij9pUBpQezMD3t
         TdS/OZA3uESqTSun6WzEbCH76f2Xqd0rPG5NKrM16TNwMxagZXQu2xrDxQfv3Cdn+nnQ
         VdMQ==
X-Gm-Message-State: ANoB5pl1Zd4rOMKnpQrfsMIttMCUJzWKF/OWhRdBTD4RgpPNGKF9fyov
	uwBn6qqWF7kJTD3U/Zpp7ZiDraVMKpg=
X-Google-Smtp-Source: AA0mqf6EKVu55tGMfeIazz01oS3UeTfc6RMRG7K4XPrEn1fYgPEFCH0x8mhOPZ5zaJvJdYh/7GAkiA==
X-Received: by 2002:aa7:9112:0:b0:574:35fd:379e with SMTP id 18-20020aa79112000000b0057435fd379emr3572795pfh.2.1670558039633;
        Thu, 08 Dec 2022 19:53:59 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id z16-20020aa79590000000b0056bb36c047asm249142pfj.105.2022.12.08.19.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 19:53:59 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: do not deduplicate compressed data for packed inode
Date: Fri,  9 Dec 2022 11:53:37 +0800
Message-Id: <20221209035337.26998-1-zbestahu@gmail.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

Packed inode is composed of fragments which have already been
deduplicated before.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 lib/compress.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 4fced9a..2987b10 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -174,6 +174,13 @@ static int z_erofs_compress_dedupe(struct z_erofs_vle_compress_ctx *ctx,
 	struct erofs_inode *inode = ctx->inode;
 	int ret = 0;
 
+	/*
+	 * No need dedupe for packed inode since it is composed of
+	 * fragments which have already been deduplicated.
+	 */
+	if (erofs_is_packed_inode(inode))
+		goto out;
+
 	do {
 		struct z_erofs_dedupe_ctx dctx = {
 			.start = ctx->queue + ctx->head - ({ int rc;
@@ -238,6 +245,7 @@ static int z_erofs_compress_dedupe(struct z_erofs_vle_compress_ctx *ctx,
 		}
 	} while (*len);
 
+out:
 	z_erofs_write_indexes(ctx);
 	return ret;
 }
@@ -369,12 +377,13 @@ static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx)
 	char *const dst = dstbuf + EROFS_BLKSIZ;
 	struct erofs_compress *const h = &compresshandle;
 	unsigned int len = ctx->tail - ctx->head;
+	bool is_packed_inode = erofs_is_packed_inode(inode);
 	bool final = !ctx->remaining;
 	int ret;
 
 	while (len) {
 		bool may_packing = (cfg.c_fragments && final &&
-				   !erofs_is_packed_inode(inode));
+				   !is_packed_inode);
 		bool may_inline = (cfg.c_ztailpacking && final &&
 				  !may_packing);
 		bool fix_dedupedfrag = ctx->fix_dedupedfrag;
@@ -513,7 +522,7 @@ frag_packing:
 		}
 		ctx->e.partial = false;
 		ctx->e.blkaddr = ctx->blkaddr;
-		if (!may_inline && !may_packing)
+		if (!may_inline && !may_packing && !is_packed_inode)
 			(void)z_erofs_dedupe_insert(&ctx->e,
 						    ctx->queue + ctx->head);
 		ctx->blkaddr += ctx->e.compressedblks;
-- 
2.17.1

