Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFD56EF068
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Apr 2023 10:45:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Q5srS50D3z3cJq
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Apr 2023 18:45:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=k3YUwEGK;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=k3YUwEGK;
	dkim-atps=neutral
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Q5srP3Csxz3bqB
	for <linux-erofs@lists.ozlabs.org>; Wed, 26 Apr 2023 18:45:07 +1000 (AEST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-517c840f181so4055605a12.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 26 Apr 2023 01:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682498703; x=1685090703;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNu7vD1mUAOPWPPCLuonoHF/qKJcaDrZr6u09Js53+Q=;
        b=k3YUwEGKnZgw2ZIFSI7w3xy42irEElPKklzcAkwNdvRh0nkJTSAKfk7sJgUQYlHjuv
         iQ0t/n+ASWfHscSjYgQksetRLpZpBcsbDFlfHc6HZzlYSD0Yn9+1xz0eXcllJA4l99bI
         w/NUNqUj4rqTqubfrRg0RJyjWJfcguHIDWDRxv+gicCuO9Ly4qjcsEOZ6ajRAxu7Vryi
         vVSKEnDYfO8bES7F3wl8jdsvnL2MZIaaWADA8tZYfnkSHR6W8Jpg8n31SFqIYA1e5AKu
         RFWM6U/D8xCIjldtgsIY3X4kxp7fe1uKBbgLjoJEpVdT8vXe9epO2bOeCDPGhPmQ5S7C
         LhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682498703; x=1685090703;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JNu7vD1mUAOPWPPCLuonoHF/qKJcaDrZr6u09Js53+Q=;
        b=Pxingx8+arxUMXcNMR9qAw5pExipYLCM5RywcS6B7I9hkQ8fER0z3Ehu81050F3d7O
         eYD9xvwTQTeHtsKFBgwNGkMJTxK/S9cBPFVc/ZevKrKuL5jRSOgOL01op3Z8EL9+7cxk
         iZGTQ15/Y+a35xlg37rowpf2uJ3tTWwsvvpbLjKRtBFEQrB3Q/frU1zDJU9KLLPQnuow
         18mscY/N/3CFL+DF+0Rvsliiu0iCitlATa9d1iW1xHZJ6oKDDwdjinRX0s6WyIsz1wxP
         dB2MgUQ49EXUr0oM3o75zSBvrleROHqq5XT2CMR9Cxc1UWNESWmmhkTPJkQH5Wylekg9
         iySw==
X-Gm-Message-State: AAQBX9eFRynRwSYNyKraNXZCFCIjEX4957M7x00MIUQ3glQvL7EDUfNx
	kb5TnTfskZB7PG8HSy+6MHU=
X-Google-Smtp-Source: AKy350YbGbwFOFqkJ36bCgdjW82+T26Giy4o1eeWJPBupmIJDDIDVigW6NwGuaxsDdjjkPF9/9dIHA==
X-Received: by 2002:a17:90a:e2d1:b0:24b:af7c:4626 with SMTP id fr17-20020a17090ae2d100b0024baf7c4626mr10706116pjb.16.1682498702794;
        Wed, 26 Apr 2023 01:45:02 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id gw13-20020a17090b0a4d00b002470b9503desm11001082pjb.55.2023.04.26.01.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 01:45:02 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs: fold in z_erofs_decompress()
Date: Wed, 26 Apr 2023 16:44:49 +0800
Message-Id: <20230426084449.12781-1-zbestahu@gmail.com>
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

No need this helper since it's just a simple wrapper for decompress
method and only one caller.  So, let's fold in directly instead.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
v2:
 - rename decompressors[] -> erofs_decompressors[]
 - do not copy struct z_erofs_decompressor item

 fs/erofs/compress.h     | 3 +--
 fs/erofs/decompressor.c | 8 +-------
 fs/erofs/zdata.c        | 4 +++-
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index 26fa170090b8..b1b846504027 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -89,8 +89,7 @@ static inline bool erofs_page_is_managed(const struct erofs_sb_info *sbi,
 
 int z_erofs_fixup_insize(struct z_erofs_decompress_req *rq, const char *padbuf,
 			 unsigned int padbufsize);
-int z_erofs_decompress(struct z_erofs_decompress_req *rq,
-		       struct page **pagepool);
+extern const struct z_erofs_decompressor erofs_decompressors[];
 
 /* prototypes for specific algorithms */
 int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 7021e2cf6146..2a29943fa5cc 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -363,7 +363,7 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
 	return 0;
 }
 
-static struct z_erofs_decompressor decompressors[] = {
+const struct z_erofs_decompressor erofs_decompressors[] = {
 	[Z_EROFS_COMPRESSION_SHIFTED] = {
 		.decompress = z_erofs_transform_plain,
 		.name = "shifted"
@@ -383,9 +383,3 @@ static struct z_erofs_decompressor decompressors[] = {
 	},
 #endif
 };
-
-int z_erofs_decompress(struct z_erofs_decompress_req *rq,
-		       struct page **pagepool)
-{
-	return decompressors[rq->alg].decompress(rq, pagepool);
-}
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index a90d37c7bdd7..5ef9d3863ff9 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1290,6 +1290,8 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	struct erofs_sb_info *const sbi = EROFS_SB(be->sb);
 	struct z_erofs_pcluster *pcl = be->pcl;
 	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
+	const struct z_erofs_decompressor *decompressor =
+				&erofs_decompressors[pcl->algorithmformat];
 	unsigned int i, inputsize;
 	int err2;
 	struct page *page;
@@ -1333,7 +1335,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	else
 		inputsize = pclusterpages * PAGE_SIZE;
 
-	err = z_erofs_decompress(&(struct z_erofs_decompress_req) {
+	err = decompressor->decompress(&(struct z_erofs_decompress_req) {
 					.sb = be->sb,
 					.in = be->compressed_pages,
 					.out = be->decompressed_pages,
-- 
2.17.1

