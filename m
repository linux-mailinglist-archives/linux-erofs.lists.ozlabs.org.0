Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BE65039E
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Jun 2019 09:35:28 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45XLg20D6xzDqBv
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Jun 2019 17:35:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1561361726;
	bh=pjQSqqz1khKcN8C0zdXdKGZF/ab4TpSVWdQm6UWCHng=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=TYvVQgW6J2FdqMoXePoBRaMtus8RAkr/QJ+Dnrhn8aawRfE+QZ0FqmwxFzokLLrgX
	 5FyB/CV2J0CcDWGMNe876k/FF97e1SQZbzGJFc9MfFoWVC8RzLWEfD5GYsKxEgF/RS
	 zDIMNV6sagXghGvFcWM/wDsP+pHtXbRKG0pfg0sQRWdCqpX5SqorwGvsRClDCdIvSk
	 RJgpAi7IBRMtnpF7k5uOEr9MVOrdZrR86/78cDsl6jZVBvQ0LD+R4yKt+5BnuFf+OQ
	 mQg1BFpwOhT1KJGDrkK3eq4u54rcXurvnKS9Np36TdqhsP5m7EasN/EZqGp1SPWXGv
	 2NEOG5M2OmocA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.68.204; helo=sonic304-23.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="FQ4HAh2T"; 
 dkim-atps=neutral
Received: from sonic304-23.consmr.mail.gq1.yahoo.com
 (sonic304-23.consmr.mail.gq1.yahoo.com [98.137.68.204])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45XLPf0Xk2zDqWL
 for <linux-erofs@lists.ozlabs.org>; Mon, 24 Jun 2019 17:23:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1561361027; bh=72/4/tIRruuHyD5zxc5fHMG03oiLPzj3D9KScNuMvAs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=FQ4HAh2T4oLp2GH+2GAzvG5CUJoc1G3iQchFAIgmYf4tQhcL9T+m6bAe9WRd7JEj6tPpr0GnsEVIUTQqpHuOQVSqQTrtcQXmZCOa2JWpv2hWvjILbQTumdsyz46L/vG6xsgqOpG2OL+xhuBwuMeCH8S6E5zO52K80z+c3k4KASyRQ8KHqw07pSRNyEBLidBm9aYm23mO9i/RMa6rKG/Av4/d81JdDKId3szil9vRUvsP+O4cP842GlicYq0jbGC446A9p/KIwOpdB9QbHuq53xy90pZi0nKrQbKAcp8t5eRj+UQHz0fUU7hnJQtC/mcelnquv4RlfQCLIAKesdVpfw==
X-YMail-OSG: Iri4VqQVM1kEBwuoMOJNU9Ma.qUhQdQuML1.QqT5t0VzNr1hkEKQ0duBExR1V6P
 TLnL6bxcQI9qkLAIZhOBN1TkMGqWL3dG3I1iLt0TGAzOgAyfa8qOY22JfJTRLi3DsEOPYMT6MV0G
 M3YAltYXvVRryde5QTeVSKOCJZZhte_asWhaIhE74PnT5EFqv7tOvBxYUqwbdZjs9V2HKVSf7Hrp
 8Y6xFjbW_1p2C1SohZGyQa.2O_4Pq47YTU.e2my_Q4Z5_44A2LTGHLTcZ5FVQQk.VkniRIU83OQV
 OOPLD0SdP6jBLsp2GkhyBMSX_1._WjgsZtU9X9OdrbVwNZNUQTSLxcsABnlxknPwMuLLQvoK.EJN
 VjNl4J5SZF6yocNV1KfDpxhukvsR0HwGXQlLaq0kLpD3UzRnzFIHbVdSdMVggqueq0lp1GTtdKU6
 G7Kyz8aL7mUi9vzLyVarQs_5w1TnSMcjTVgkFxq9c73eyPm4bPIMl6sOz4PCX5TM9n1CmIwzEt40
 Q.UFl50k23sCczdMCEdHknu9Ce9EdoRFYYrdufeN7fvs.HguaZBah9a5hD4h0HJ6H_cRN5d0MXYm
 nGGEj_ybOoQkbY5oDpoDl5XA5fjyDeAdCloj.BtyOr32nEwUdlB.Ah66tBnVnycL2yHWu4Ogu1TF
 D4km3oHT3jqwgMGOdE6WJhj7ljN9Cq1TAgsFesfMyxN6kPQwpnFuAEX551EI.f.nIfxDQfTLgHtA
 tKG7V8cUO8HJecYirWIOmLwQ3qSEsiVlF98uFvpssai1xnYHj4V2jm3teqPYwfKq2ut8MIgJT3Bz
 lf2RodK3Ireh.P9Qrmgdm8USMHbIf0uY.GQ45zRYkPCnMS5t9PHJ_EzOqc6egN.p_8md8xd37FpF
 UlEdV4KmJ.eaLWWgbHHawsrDNSkhNk6V5YHoUevc5Dq4whoeHB.x0WoeWtCPszjUIpAvKdPtmZ4W
 ulqz7SS0z2ouybesgbtkXUuaq_dLf3WNxOrDLzg.MrIhY21SF6S2Q29R5TtVyvS0eiK5bDGYRa7o
 s5GFGdgdaEwIPXL24p36IdbakR.vImBXcqd8xohGdkh50tO6GpyObc9nbzXtDKsEeZvIpU1PGJF7
 jX_97_UZVurYAWyC8eNbWNfLsl1BqyPAkun6guDrmNFWKwow6JV2d2naI0rW5YTjrans3aaL3SHk
 wRtw.87khDRjfayrIL8co86dCYtDGSnp1QUYjjPQte06kYPd5P0VZlUeWnz3NDiU-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic304.consmr.mail.gq1.yahoo.com with HTTP; Mon, 24 Jun 2019 07:23:47 +0000
Received: from 116.226.249.212 (EHLO localhost.localdomain) ([116.226.249.212])
 by smtp415.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID
 6d1878af4efb7cadb69856afeea1b125; 
 Mon, 24 Jun 2019 07:23:44 +0000 (UTC)
To: Chao Yu <yuchao0@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 4/8] staging: erofs: move stagingpage operations to
 compress.h
Date: Mon, 24 Jun 2019 15:22:54 +0800
Message-Id: <20190624072258.28362-5-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190624072258.28362-1-hsiangkao@aol.com>
References: <20190624072258.28362-1-hsiangkao@aol.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>, Du Wei <weidu.du@huawei.com>,
 linux-fsdevel@vger.kernel.org, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <gaoxiang25@huawei.com>

stagingpages are behaved as bounce pages for temporary use.
Move to compress.h since the upcoming decompressor will
allocate stagingpages as well.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/compress.h  | 40 +++++++++++++++++++++++++++++++
 drivers/staging/erofs/unzip_vle.c | 11 +++++----
 drivers/staging/erofs/unzip_vle.h | 20 ----------------
 3 files changed, 46 insertions(+), 25 deletions(-)
 create mode 100644 drivers/staging/erofs/compress.h

diff --git a/drivers/staging/erofs/compress.h b/drivers/staging/erofs/compress.h
new file mode 100644
index 000000000000..1dcfc3b35118
--- /dev/null
+++ b/drivers/staging/erofs/compress.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * linux/drivers/staging/erofs/compress.h
+ *
+ * Copyright (C) 2019 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Gao Xiang <gaoxiang25@huawei.com>
+ */
+#ifndef __EROFS_FS_COMPRESS_H
+#define __EROFS_FS_COMPRESS_H
+
+/*
+ * - 0x5A110C8D ('sallocated', Z_EROFS_MAPPING_STAGING) -
+ * used to mark temporary allocated pages from other
+ * file/cached pages and NULL mapping pages.
+ */
+#define Z_EROFS_MAPPING_STAGING         ((void *)0x5A110C8D)
+
+/* check if a page is marked as staging */
+static inline bool z_erofs_page_is_staging(struct page *page)
+{
+	return page->mapping == Z_EROFS_MAPPING_STAGING;
+}
+
+static inline bool z_erofs_put_stagingpage(struct list_head *pagepool,
+					   struct page *page)
+{
+	if (!z_erofs_page_is_staging(page))
+		return false;
+
+	/* staging pages should not be used by others at the same time */
+	if (page_ref_count(page) > 1)
+		put_page(page);
+	else
+		list_add(&page->lru, pagepool);
+	return true;
+}
+
+#endif
+
diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 08f2d4302ecb..d95f985936b6 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -11,6 +11,7 @@
  * distribution for more details.
  */
 #include "unzip_vle.h"
+#include "compress.h"
 #include <linux/prefetch.h>
 
 #include <trace/events/erofs.h>
@@ -855,7 +856,7 @@ static inline void z_erofs_vle_read_endio(struct bio *bio)
 		DBG_BUGON(PageUptodate(page));
 		DBG_BUGON(!page->mapping);
 
-		if (unlikely(!sbi && !z_erofs_is_stagingpage(page))) {
+		if (unlikely(!sbi && !z_erofs_page_is_staging(page))) {
 			sbi = EROFS_SB(page->mapping->host->i_sb);
 
 			if (time_to_inject(sbi, FAULT_READ_IO)) {
@@ -947,7 +948,7 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 		DBG_BUGON(!page);
 		DBG_BUGON(!page->mapping);
 
-		if (z_erofs_gather_if_stagingpage(page_pool, page))
+		if (z_erofs_put_stagingpage(page_pool, page))
 			continue;
 
 		if (page_type == Z_EROFS_VLE_PAGE_TYPE_HEAD)
@@ -977,7 +978,7 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 		DBG_BUGON(!page);
 		DBG_BUGON(!page->mapping);
 
-		if (!z_erofs_is_stagingpage(page)) {
+		if (!z_erofs_page_is_staging(page)) {
 			if (erofs_page_is_managed(sbi, page)) {
 				if (unlikely(!PageUptodate(page)))
 					err = -EIO;
@@ -1055,7 +1056,7 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 			continue;
 
 		/* recycle all individual staging pages */
-		(void)z_erofs_gather_if_stagingpage(page_pool, page);
+		(void)z_erofs_put_stagingpage(page_pool, page);
 
 		WRITE_ONCE(compressed_pages[i], NULL);
 	}
@@ -1068,7 +1069,7 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 		DBG_BUGON(!page->mapping);
 
 		/* recycle all individual staging pages */
-		if (z_erofs_gather_if_stagingpage(page_pool, page))
+		if (z_erofs_put_stagingpage(page_pool, page))
 			continue;
 
 		if (unlikely(err < 0))
diff --git a/drivers/staging/erofs/unzip_vle.h b/drivers/staging/erofs/unzip_vle.h
index 9c53009700cf..6c3e0deb63e7 100644
--- a/drivers/staging/erofs/unzip_vle.h
+++ b/drivers/staging/erofs/unzip_vle.h
@@ -16,26 +16,6 @@
 #include "internal.h"
 #include "unzip_pagevec.h"
 
-/*
- *  - 0x5A110C8D ('sallocated', Z_EROFS_MAPPING_STAGING) -
- * used for temporary allocated pages (via erofs_allocpage),
- * in order to seperate those from NULL mapping (eg. truncated pages)
- */
-#define Z_EROFS_MAPPING_STAGING		((void *)0x5A110C8D)
-
-#define z_erofs_is_stagingpage(page)	\
-	((page)->mapping == Z_EROFS_MAPPING_STAGING)
-
-static inline bool z_erofs_gather_if_stagingpage(struct list_head *page_pool,
-						 struct page *page)
-{
-	if (z_erofs_is_stagingpage(page)) {
-		list_add(&page->lru, page_pool);
-		return true;
-	}
-	return false;
-}
-
 /*
  * Structure fields follow one of the following exclusion rules.
  *
-- 
2.17.1

