Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C316EEFBF
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Apr 2023 10:00:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Q5rrR36JHz3cJn
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Apr 2023 18:00:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=UJjx2uOO;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=UJjx2uOO;
	dkim-atps=neutral
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Q5rrJ3l5Hz3bjy
	for <linux-erofs@lists.ozlabs.org>; Wed, 26 Apr 2023 17:59:58 +1000 (AEST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-63b70f0b320so8755861b3a.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 26 Apr 2023 00:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682495996; x=1685087996;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qc4wDl/tbFwtdOVf6B2vMeyGyk+KqhBb2cMLF7Q7QOA=;
        b=UJjx2uOOeSPNRatofuOeass7kXfXaJ/hZeZaX82LMUL4prH8MXwLYwvFxgl441r1/E
         d8uDza9GS52WmP2+5fjykj4VeSYiWwjz2EDxUvBRTBoweXqbWkaxU2eLT/4skyRCmVHr
         sRyHF9vP23xkE4ZEmBbEMm1uyxqYKH553phHmJOgsyoxWGbYOhSovDiM/fE9FQpsKZe2
         /eHKJDqUWR0NhOyLvGGs6hLU9KHB7ysaeSxoM6hIenCSTYmutzzLoivJXOdPSiVERKT6
         4Rq+3k3icLaWJ3xSc5SQ174qICutDkrFhAVSJvdNVspH/teldHImc0GTuR/AXRW3vxcd
         FRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682495996; x=1685087996;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qc4wDl/tbFwtdOVf6B2vMeyGyk+KqhBb2cMLF7Q7QOA=;
        b=KsGCPOhDJhPSioL6GrP0Gv6ZjhCAWpoZuWanFRC3JNH7ZG9euvD8tkAkrTnK8+/csg
         NQCnkjr2GZ0Jisbh4gfKErzkzNKKrjTC8FZYqapqBgFyDXNq/DfTQn4uczwsdzfPKWe9
         tcRdgsofGu9a5sZ9STEsWJf3oLYhltfzqSVkYh016pSXcf4+a4yEiB4SydsCKxU5Pkhe
         BI+Zr70Bak3T+k2oyw9kG1t17wQsZxR7Ar1aVZiBZgrumDlHfEPklfupfHetX48TIDgI
         rCxgU23uhJuLhoxdijtxURKoMU7UyamKdZhzoV7ikEESwzkivaVHoK09llLGJ0eY5Hv7
         OchQ==
X-Gm-Message-State: AAQBX9fUztt03SXgt1uW0h4gUljCXe9yjcDL6XSqw3I+34Fz4vqByLLq
	Vl25hqNjiJa1Svt9BxdIeSQ=
X-Google-Smtp-Source: AKy350aQV1dryEZ5Nx3UA8cjnGTmq4Rjsc/TJqsW1biOz6F9bTsbGajPGMeD7QD6iUn3BlDXyn9V3A==
X-Received: by 2002:a05:6a00:2385:b0:63d:4358:9140 with SMTP id f5-20020a056a00238500b0063d43589140mr29634914pfc.34.1682495996234;
        Wed, 26 Apr 2023 00:59:56 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id a22-20020a62d416000000b0063f9de332f8sm5364486pfh.167.2023.04.26.00.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 00:59:55 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: fold in z_erofs_decompress()
Date: Wed, 26 Apr 2023 15:59:43 +0800
Message-Id: <20230426075943.26629-1-zbestahu@gmail.com>
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
 fs/erofs/compress.h     | 3 +--
 fs/erofs/decompressor.c | 8 +-------
 fs/erofs/zdata.c        | 4 +++-
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index 26fa170090b8..9e423316f5a1 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -89,8 +89,7 @@ static inline bool erofs_page_is_managed(const struct erofs_sb_info *sbi,
 
 int z_erofs_fixup_insize(struct z_erofs_decompress_req *rq, const char *padbuf,
 			 unsigned int padbufsize);
-int z_erofs_decompress(struct z_erofs_decompress_req *rq,
-		       struct page **pagepool);
+extern const struct z_erofs_decompressor decompressors[];
 
 /* prototypes for specific algorithms */
 int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 7021e2cf6146..5ed82b72a5a5 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -363,7 +363,7 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
 	return 0;
 }
 
-static struct z_erofs_decompressor decompressors[] = {
+const struct z_erofs_decompressor decompressors[] = {
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
index a90d37c7bdd7..f5c8ab176b23 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1290,6 +1290,8 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	struct erofs_sb_info *const sbi = EROFS_SB(be->sb);
 	struct z_erofs_pcluster *pcl = be->pcl;
 	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
+	struct z_erofs_decompressor decompressor =
+				decompressors[pcl->algorithmformat];
 	unsigned int i, inputsize;
 	int err2;
 	struct page *page;
@@ -1333,7 +1335,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	else
 		inputsize = pclusterpages * PAGE_SIZE;
 
-	err = z_erofs_decompress(&(struct z_erofs_decompress_req) {
+	err = decompressor.decompress(&(struct z_erofs_decompress_req) {
 					.sb = be->sb,
 					.in = be->compressed_pages,
 					.out = be->decompressed_pages,
-- 
2.17.1

