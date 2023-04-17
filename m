Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BF76E3FFB
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Apr 2023 08:42:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Q0HXl4zBsz3cM3
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Apr 2023 16:42:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=exAhRPnq;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=exAhRPnq;
	dkim-atps=neutral
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Q0HXc59wLz2xjw
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Apr 2023 16:42:07 +1000 (AEST)
Received: by mail-pl1-x629.google.com with SMTP id w11so24569037plp.13
        for <linux-erofs@lists.ozlabs.org>; Sun, 16 Apr 2023 23:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681713725; x=1684305725;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHGyWlcoQD9UeffDXzUOvm+FtnM3Ld1GsqM2RKnrFyc=;
        b=exAhRPnqf1otSCxJRXagmwhR/d7yMDEjNw/kOlbIsgCnTfYzFkuqXuzM358CnunZTJ
         nq4uL/PXp0JIV1IPC9XURHdKoikyWadpWZ/z9J+oR+wZGHy6ktIggsVYk3oN9HRza+4i
         yFpOJORSSMO8t+iyn8vgvV2MWl9KNyNZzR3tBobP/SQcZmsL/5z7khjfo39gRSnOjHYG
         u9pFWDCBedrlQyxGLDA9LX6PDOJG25CSisAXNs25vP2S7F07/pP+5X+9zABOqxowhUv8
         bXpyahKyD1mXl5CLNzxqKf/k6+32CWg5X2eiesaBOuhU+ujRoKxc5diQfv0kse6XSHnM
         mJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681713725; x=1684305725;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHGyWlcoQD9UeffDXzUOvm+FtnM3Ld1GsqM2RKnrFyc=;
        b=bQ5lLO/Yubb+a3f/0BDwFBCrZtXHHhtZDx+O6arMSXI3ksgi00nAwgBurXnoHXGr1W
         hZi+FKJ4VcvcoYgh3TOZzQjHJScy5nrvuqJanHPfyLpHFK57oaKIz0kGJ+jyzftSI1YA
         e5L0cn50Q7ItzuH3Ci+HV8Q6iNud//WmS7BOIRbH1LDBjFjWyYbti2DyO9d27dixPYVf
         j3DbuXz1irzMtKGFy3sfCYBG05cn4zht2Z2FG6M58OrPY8ss7IKhvJlknBARogywClll
         ZckSI+CaXDRUGYKWWXxw5oANJ4FT3eU8XbtPGTwr0NWudgZxEib/6RzhvwiadPz7pWT7
         wq4Q==
X-Gm-Message-State: AAQBX9cKHBF6Lk7CcnASF0weCGfieubUKml9laa1697cfsy2/ApvIizT
	t9BN+xrIYRZg17NQqrZyNnE=
X-Google-Smtp-Source: AKy350Z9r/nm7Hue6j1B9JqqNUGMYGRMBJg8i+lW0xdRIiZhw8JHyqOnWZNK8ZE40Wcn9ntjjJ/q7A==
X-Received: by 2002:a05:6a20:748b:b0:ef:2d6:446c with SMTP id p11-20020a056a20748b00b000ef02d6446cmr7924499pzd.17.1681713724956;
        Sun, 16 Apr 2023 23:42:04 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id l15-20020a654c4f000000b0051a3c744256sm6337824pgr.93.2023.04.16.23.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 23:42:04 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: remove unneeded icur field from struct z_erofs_decompress_frontend
Date: Mon, 17 Apr 2023 14:41:35 +0800
Message-Id: <20230417064136.5890-1-zbestahu@gmail.com>
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
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

The icur field is only used in z_erofs_try_inplace_io(). Let's just use
a local variable instead. And no need to check if the pcluster is inline
when setting icur since inline page cannot be used for inplace I/O.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/zdata.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index f759152feffa..f8bf2b227942 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -554,9 +554,6 @@ struct z_erofs_decompress_frontend {
 	/* used for applying cache strategy on the fly */
 	bool backmost;
 	erofs_off_t headoffset;
-
-	/* a pointer used to pick up inplace I/O pages */
-	unsigned int icur;
 };
 
 #define DECOMPRESS_FRONTEND_INIT(__i) { \
@@ -707,11 +704,13 @@ static bool z_erofs_try_inplace_io(struct z_erofs_decompress_frontend *fe,
 				   struct z_erofs_bvec *bvec)
 {
 	struct z_erofs_pcluster *const pcl = fe->pcl;
+	/* file-backed online pages are traversed in reverse order */
+	unsigned int icur = pcl->pclusterpages;
 
-	while (fe->icur > 0) {
-		if (!cmpxchg(&pcl->compressed_bvecs[--fe->icur].page,
+	while (icur > 0) {
+		if (!cmpxchg(&pcl->compressed_bvecs[--icur].page,
 			     NULL, bvec->page)) {
-			pcl->compressed_bvecs[fe->icur] = *bvec;
+			pcl->compressed_bvecs[icur] = *bvec;
 			return true;
 		}
 	}
@@ -877,8 +876,6 @@ static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe)
 	}
 	z_erofs_bvec_iter_begin(&fe->biter, &fe->pcl->bvset,
 				Z_EROFS_INLINE_BVECS, fe->pcl->vcnt);
-	/* since file-backed online pages are traversed in reverse order */
-	fe->icur = z_erofs_pclusterpages(fe->pcl);
 	return 0;
 }
 
-- 
2.17.1

