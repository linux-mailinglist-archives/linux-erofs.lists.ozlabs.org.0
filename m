Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A90E481AEBB
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Dec 2023 07:24:52 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Vn8kyu8E;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SwgQB2N81z30hn
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Dec 2023 17:24:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Vn8kyu8E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1129; helo=mail-yw1-x1129.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SwgQ15vjRz2xct
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 Dec 2023 17:24:40 +1100 (AEDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5e7c1012a42so4890227b3.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 20 Dec 2023 22:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703139877; x=1703744677; darn=lists.ozlabs.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ux7YJblT1o8powK/wjkuBKhpWvZytW7tRyNBPemyUJo=;
        b=Vn8kyu8EoQTio79IIE2aRg++/rSmWVscHA9d8Z1B+hZB4/DvHAuuyczGTX2bJ8eMde
         4yx09iktM4jnfqNnTcGc3JD5PjS6xRDFT2MxZDswJVrA6hX/mIFb1xmGJeQn+4PL3izR
         I5Ewf2Rb4s+m5U03pm01o3zucOSDq797BX3xK8FVjvXbhI3vCCzsfCPclPneZwmWFilm
         b8fhZdoXzQpNgl1fnp2bnONaiv2re3V+1FInWPCM3IzzqwSw819S2clh0kDsUK/UTFKY
         094OmJxo5iVqRfAjgKMkq7GYPtompcwp8RDJ39ltGOG/td1446VBK4+mLDZT5pWmVuWY
         SM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703139877; x=1703744677;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ux7YJblT1o8powK/wjkuBKhpWvZytW7tRyNBPemyUJo=;
        b=W5455famJrDUN7NlL/cZF7uth0qlUsnhnWcyo6ycJbCOcwQTuV8G1ExRN8gRv7BG94
         +LKYX0cP1GVwBzqCNwV/hjGA2ibFeI66udxIYkKSnyK5sfb1pcZo+/0vrx+0QfZ15qMv
         PgqCn+G3giB9jmsgzc39xguT4oX6P9hl1AILePLFsfxjAzJRu6j9/IbXyTo5Y6AVB9At
         m423EGpXs0TTEm9Bj9GbG0ZFu9/EKJRltxsU3or+239h3czxJnLhD3ANxG9dj+OP66mz
         3UtQhBxSkgQUxeePZCbXufuAj3zzwH/xXp9Fz9MkyMFnxNXQosiGyYeIwMbZ6gp017u1
         EMCQ==
X-Gm-Message-State: AOJu0YzYJjfAeE28TCK2W9WyaZ4kHrJxc4j3VmOGeMhcFc+AlMp+5Y3o
	e46GWBYz7GEWmlkVfUHS7es=
X-Google-Smtp-Source: AGHT+IFuAJjblgc/7Ui3sbx2gsEil3Z1ZjY6JjDD+m5xtP/zxyNAwsucb+9lei1yW3DRSsCdJC4EvQ==
X-Received: by 2002:a0d:d990:0:b0:5e7:df55:3b1e with SMTP id b138-20020a0dd990000000b005e7df553b1emr937076ywe.12.1703139877000;
        Wed, 20 Dec 2023 22:24:37 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id k1-20020a170902ba8100b001d2ed17751asm756765pls.261.2023.12.20.22.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 22:24:36 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: allow partially filled compressed bvecs
Date: Thu, 21 Dec 2023 14:23:41 +0800
Message-Id: <20231221062341.23901-1-zbestahu@gmail.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

In order to reduce memory footprints even further, let's allow
partially filled compressed bvecs for readahead to bail out later.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/zdata.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index a2c3e87d2f81..20a0cd415cf7 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1202,34 +1202,27 @@ static int z_erofs_parse_in_bvecs(struct z_erofs_decompress_backend *be,
 		struct z_erofs_bvec *bvec = &pcl->compressed_bvecs[i];
 		struct page *page = bvec->page;
 
-		/* compressed pages ought to be present before decompressing */
+		/* compressed data ought to be valid before decompressing */
 		if (!page) {
-			DBG_BUGON(1);
+			err = -EIO;
 			continue;
 		}
 		be->compressed_pages[i] = page;
 
-		if (z_erofs_is_inline_pcluster(pcl)) {
+		if (z_erofs_is_inline_pcluster(pcl) ||
+		    erofs_page_is_managed(EROFS_SB(be->sb), page)) {
 			if (!PageUptodate(page))
 				err = -EIO;
 			continue;
 		}
 
 		DBG_BUGON(z_erofs_page_is_invalidated(page));
-		if (!z_erofs_is_shortlived_page(page)) {
-			if (erofs_page_is_managed(EROFS_SB(be->sb), page)) {
-				if (!PageUptodate(page))
-					err = -EIO;
-				continue;
-			}
-			z_erofs_do_decompressed_bvec(be, bvec);
-			*overlapped = true;
-		}
+		if (z_erofs_is_shortlived_page(page))
+			continue;
+		z_erofs_do_decompressed_bvec(be, bvec);
+		*overlapped = true;
 	}
-
-	if (err)
-		return err;
-	return 0;
+	return err;
 }
 
 static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
@@ -1238,7 +1231,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	struct erofs_sb_info *const sbi = EROFS_SB(be->sb);
 	struct z_erofs_pcluster *pcl = be->pcl;
 	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
-	const struct z_erofs_decompressor *decompressor =
+	const struct z_erofs_decompressor *decomp =
 				&erofs_decompressors[pcl->algorithmformat];
 	int i, err2;
 	struct page *page;
@@ -1274,10 +1267,8 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	err2 = z_erofs_parse_in_bvecs(be, &overlapped);
 	if (err2)
 		err = err2;
-	if (err)
-		goto out;
-
-	err = decompressor->decompress(&(struct z_erofs_decompress_req) {
+	if (!err)
+		err = decomp->decompress(&(struct z_erofs_decompress_req) {
 					.sb = be->sb,
 					.in = be->compressed_pages,
 					.out = be->decompressed_pages,
@@ -1291,7 +1282,6 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 					.fillgaps = pcl->multibases,
 				 }, be->pagepool);
 
-out:
 	/* must handle all compressed pages before actual file pages */
 	if (z_erofs_is_inline_pcluster(pcl)) {
 		page = pcl->compressed_bvecs[0].page;
@@ -1302,7 +1292,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 			/* consider shortlived pages added when decompressing */
 			page = be->compressed_pages[i];
 
-			if (erofs_page_is_managed(sbi, page))
+			if (!page || erofs_page_is_managed(sbi, page))
 				continue;
 			(void)z_erofs_put_shortlivedpage(be->pagepool, page);
 			WRITE_ONCE(pcl->compressed_bvecs[i].page, NULL);
-- 
2.17.1

