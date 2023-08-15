Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE0D77C6C9
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Aug 2023 06:56:01 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=MuKJ8sCz;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RPzVk6vFXz3c82
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Aug 2023 14:55:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=MuKJ8sCz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::22d; helo=mail-oi1-x22d.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RPzVV0VC1z309D
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Aug 2023 14:55:45 +1000 (AEST)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a76cbd4bbfso4754801b6e.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 14 Aug 2023 21:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692075343; x=1692680143;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zb347FChaRgBAam95b+72JtftC50VIMXPy1MpKsImUY=;
        b=MuKJ8sCzGv5TZGAv0gTsbtnapSL60hfFVr8mkYoctwMVESbsDI7LO0RWwuR8BPS5Ak
         PdFI8JIL4bsyi9KWDt1uO/4PYUxFxDJPjKl9RgzprtQIIyMEceYwysEpEjEqKhmUlbm8
         86ZOrUVD8l/Ft8zPmeXIXCyhzLzV5N5wKzmnj8jlg+0nDCLWAsHx4dEhnbz6DMHG+qDN
         bGZb6p2P1q+2+4ZFVw2fNh8/RiJBKsrNZeZy3wB3VERkBLTLmqWamejehrB3rArrfGWD
         nSOaFeTZpvV6xrMlu9meC/JIGbohS0tPkU9gGYXkNWgFU++r2RKBKEuEnhnzhScqipDI
         C5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692075343; x=1692680143;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zb347FChaRgBAam95b+72JtftC50VIMXPy1MpKsImUY=;
        b=hWkEg0C0puPomZDDWUk0BoHt+RZKVKMOHNMtdnckkbWx5nYKldeEIRCFbElVl3Kbja
         4p3jgQHzKjd6wA5VkpffffOF47dVIaCPzS0Y/6iON8+e/i4rwL3gcRmHtKVsIdXEGKnX
         NkaTWXvKU8D+b3eT00F9nnLrsRtLuqk2aR8yGMbD8wiJhwcczMzDVQQTEJjteNKa7H5s
         apYgSzOFTJsuoP3z1/kOYRcF4UBk+u5OaPF/hObzjhNsgIFyZk72M9M3ucMqrGnKLDD/
         QDwqmb1Zx+6L2aiNULvLdy35BSoaBd9HE2J37Q6OVUkX1d8zbcJempZXWf03uNSUnO87
         j/gw==
X-Gm-Message-State: AOJu0YxVeCpusPUMgVdiNZ6fKU/NgXfyB8ecqBNzW9FO0c+ldukSrtvG
	VfngQU3KRPcNiTwCCiUp9s1oTxHUH4U=
X-Google-Smtp-Source: AGHT+IFrMLIlhsy+xAWysXlFMEyAHKLj6MEqmielbHGC2p+ysNlOklmV6to9pbKU+03LLLR7KBWbWg==
X-Received: by 2002:a54:4819:0:b0:3a4:4b42:612b with SMTP id j25-20020a544819000000b003a44b42612bmr12031848oij.42.1692075343019;
        Mon, 14 Aug 2023 21:55:43 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.163])
        by smtp.gmail.com with ESMTPSA id v13-20020a63bf0d000000b00564b313d526sm8590942pgf.54.2023.08.14.21.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 21:55:42 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] AOSP: erofs-utils: add a variable to validate tail block map in block list
Date: Tue, 15 Aug 2023 12:55:25 +0800
Message-Id: <20230815045525.17990-2-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230815045525.17990-1-zbestahu@gmail.com>
References: <20230815045525.17990-1-zbestahu@gmail.com>
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
Cc: Yue Hu <huyue2@coolpad.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

We write the block map directly before the tail, as this applies only to
regular files.  However, the tail block map does not follow the rule.

Therefore, introduce a variable to track whether the tail block is safe
to write before its map if it exists rather than separately check the
file type when mapping.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 lib/block_list.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/lib/block_list.c b/lib/block_list.c
index a1c719d..e59a8d7 100644
--- a/lib/block_list.c
+++ b/lib/block_list.c
@@ -12,6 +12,7 @@
 #include "erofs/print.h"
 
 static FILE *block_list_fp;
+static bool regular_tail = false;
 
 int erofs_droid_blocklist_fopen(void)
 {
@@ -77,22 +78,23 @@ void erofs_droid_blocklist_write_extent(struct erofs_inode *inode,
 void erofs_droid_blocklist_write(struct erofs_inode *inode,
 				 erofs_blk_t blk_start, erofs_blk_t nblocks)
 {
-	if (!block_list_fp || !cfg.mount_point || !nblocks)
+	if (!block_list_fp || !cfg.mount_point)
 		return;
 
-	blocklist_write(inode->i_srcpath, blk_start, nblocks,
-			true, !inode->idata_size);
+	if (nblocks)
+		blocklist_write(inode->i_srcpath, blk_start, nblocks, true,
+				!inode->idata_size);
+	if (inode->idata_size)
+		regular_tail = true;
 }
 
 void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
 					  erofs_blk_t blkaddr, bool first_block)
 {
-	if (!block_list_fp || !cfg.mount_point)
+	if (!block_list_fp || !cfg.mount_point || !regular_tail)
 		return;
 
-	/* XXX: a bit hacky.. may need a better approach */
-	if (S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode))
-		return;
+	regular_tail = false;
 
 	if (!first_block) {
 		if (blkaddr == NULL_ADDR)
-- 
2.17.1

