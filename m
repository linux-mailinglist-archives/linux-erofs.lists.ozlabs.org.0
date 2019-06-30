Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 030D25B15F
	for <lists+linux-erofs@lfdr.de>; Sun, 30 Jun 2019 20:59:38 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45cKYd2mgRzDqWT
	for <lists+linux-erofs@lfdr.de>; Mon,  1 Jul 2019 04:59:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1561921173;
	bh=Uvqfr8qVoZPEAep6cDwBL4XXqSnziyg/10JkoonAYB0=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=MLJfOQScLvCdWPLHW+CNfR8nu5/jO/zAwQxapTWK6oCEPG3Aqy7yenjqZtx4r5+7o
	 ed0eoMaVWNo4omxc2/p1IUi5BAyd7eFYLJuJfNiNZipLUxuHbhJCSZQ0QsKGI7vzFJ
	 SqWTT/BaOj9j30dBnqeEpByH/G8RdYDc82HuFxZfs3YmcVecDnJtoxfQht/u0RJwIj
	 LX//PhmF/QnJHFI2rsXFnCDhBS769b/3weoM/fUwYqQWRNEIarSXKusaANTMezQOiy
	 FxfLeoksO453jxcjGJ/+wrwVsoDaA3l5RNHaAgWu0+lCg5v5HPeBalsHDtGGRjeWag
	 Yiz7YUN1+Q4sQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.68.31; helo=sonic308-55.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="CW+oGbza"; 
 dkim-atps=neutral
Received: from sonic308-55.consmr.mail.gq1.yahoo.com
 (sonic308-55.consmr.mail.gq1.yahoo.com [98.137.68.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45cKYS12QMzDqT4
 for <linux-erofs@lists.ozlabs.org>; Mon,  1 Jul 2019 04:59:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1561921156; bh=qvS6AX1nqTURIJxkra+F23NzHGUKeOF9WJqZLfkSZ3I=;
 h=From:To:Cc:Subject:Date:From:Subject;
 b=CW+oGbzaBWtkvpId2t7MjFmW3VQ1LGlDqhON0VM2t/0CxgH2BBjkyQKOquW/AXGsvZil2x/axn8pSyW5zDy1VgTvJjBFBtkNthJOhDImFuF9ydc+dvHHVRRcE0rkUlQxUcXrTJk/k6aHK5PNclXNyfOVT3eQnF+X9faLTBnE+YP84nMeMkcH4Usw/F1pqIeYhoX4u9SeNE5aPjZjITBTSfMQ9kN+jlbTPan4bkjbq76Q3Pjy93GrOgyXcxd4zvCbqbzQYQdZdg05r3KviubxLLiIRpXcMvhGeC6oRI+66uIlMvMFxUPjbHuAzfFNPnm+y1qEBC6R9RkUwq1zvVcPlw==
X-YMail-OSG: _MUMI6UVM1kHv.o_3n8h5.C86RBWmC5Ch5VWinQzlhBgdFfZyAkqN9w.q0VDv8O
 Bq9_fJ0niS4mJdEJX41zaNPoEBzdm.tTw3mfdOMbcWRGuxtZRygQcbDSILjfbJYHHb7WJQJ2M6B_
 8HQCd7dMN4viBzEBufJeYgzPtIcEY0NBEZVKsWTDHUvQ_ukCnhSix81RWjSMp1rv4shCKr.j3P5P
 QWHZ4.o_ehIKIZhBNBKQR9vKDsAL.H7rClKvw1h0elZEWGMrFbcD1J6hL4qjiW9l8qzkIFRp2zHU
 9CTcnEpcqKaQD0GIkoPoi..vWvUsWBUSp08LXnT0bmj32AewdLZ4ZWnJS5PvJoBGRr_6egNFCl4M
 _ZQuGUpSsZKWLgqwmk2FvbfEqxneyW9rLUA12kcSgUi4a84KBAIqs7K59cq1j_Zck5FBomu.tjFY
 dBxgANcpbre88L.WWoGP_RKI694ntxZMgcSPo82XRl0iMrEQmdt6hCmlDWRANLXlWiVJCsISd8ZO
 KxedfV_HVtTwvCJYzUwc0QlUloGcBRtY0PF13_047K1m7pg1mp4NC7VtEGp2k035dF3LW2miBjob
 C.ubNzB4a2Uo_NnlK5noM27sGWWsBEPvnpnuXC3CJbrDSW9ywmaqwKPqJaS4Cxbkn6czw_ET.Luq
 9LtQIHA5sMYC8zLgD0CIU0uA2OFTYlE.LqPu8ZVGhoDbYTzeYSrPoYP08xD5Ao4AyxPuSEFH9emA
 ZvgTcx1A8msiqfMcM8EUyLMV.p0M7tO.w6SsGk3JRjcAFjUS0M0ls7eBKI1aE_HqQgLNQlwUp4O5
 Y5lcAA0cwNjR4tpgfHWYkOsxnNFzQ.3Jw_OEC6UIqX5QD2kUOQXN.UH0XyEF8BbdktSzuAC.NF1A
 KXmB9ORyvvv_O8inwLQ1N5EtinF8ThdmTEfjinP7ThaF7zE2z3zPuxhWziHVE45e.kttoRyFhjJR
 82r6PmUl8sFRyGXDWe4YhDxcS7TQhpyA1OfmjOaHggE8PrqX_mi9CYc0qtpLXuOrdFwBNCsn7yau
 ErZ5xWgKVFfHFHDW5r7nwzI2N2U94_Yux6TMx9TZB5Ed_TunUSAgUyz_VN8lqYvttnh3K8DONMVL
 39OrpEG4EbCILlzmT.oZ86fgtQ4svSTqUp9aZ2ktxhUOxXI5dRr6xrAxVp4qahdXNFEGNGsrtNEr
 5okIlXlIeW8H5N2BzOdG1w9Mht7wdD0OUIUEWNJHd_LdcpFBab5_Igyd_Avg-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic308.consmr.mail.gq1.yahoo.com with HTTP; Sun, 30 Jun 2019 18:59:16 +0000
Received: from 115.192.39.149 (EHLO localhost.localdomain) ([115.192.39.149])
 by smtp430.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 4f455e50a02bda45690c67a6db1d1f3b; 
 Sun, 30 Jun 2019 18:59:13 +0000 (UTC)
To: Chao Yu <yuchao0@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] staging: erofs: fix LZ4 limited bounced page mis-reuse
Date: Mon,  1 Jul 2019 02:58:46 +0800
Message-Id: <20190630185846.16624-1-hsiangkao@aol.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>, Du Wei <weidu.du@huawei.com>,
 Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <gaoxiang25@huawei.com>

Like all lz77-based algrithms, lz4 has a dynamically populated
("sliding window") dictionary and the maximum lookback distance
is 65535. Therefore the number of bounced pages could be limited
by erofs based on this property.

However, just now we observed some lz4 sequences in the extreme
case cannot be decompressed correctly after this feature is enabled,
the root causes after analysis are clear as follows:
1) max bounced pages should be 17 rather than 16 pages;
2) considering the following case, the broken implementation
   could reuse unsafely in advance (in other words, reuse it
   less than a safe distance),
   0 1 2 ... 16 17 18 ... 33 34
   b             p  b         b
   note that the bounce page that we are concerned was allocated
   at 0, and it reused at 18 since page 17 exists, but it mis-reused
   at 34 in advance again, which causes decompress failure.

This patch resolves the issue by introducing a bitmap to mark
whether the page in the same position of last round is a bounced
page or not, and a micro stack data structure to store all
available bounced pages.

Fixes: 7fc45dbc938a ("staging: erofs: introduce generic decompression backend")
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/decompressor.c | 50 ++++++++++++++++------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/erofs/decompressor.c b/drivers/staging/erofs/decompressor.c
index 80f1f39719ba..1fb0abb98dff 100644
--- a/drivers/staging/erofs/decompressor.c
+++ b/drivers/staging/erofs/decompressor.c
@@ -13,7 +13,7 @@
 #define LZ4_DISTANCE_MAX 65535	/* set to maximum value by default */
 #endif
 
-#define LZ4_MAX_DISTANCE_PAGES	DIV_ROUND_UP(LZ4_DISTANCE_MAX, PAGE_SIZE)
+#define LZ4_MAX_DISTANCE_PAGES	(DIV_ROUND_UP(LZ4_DISTANCE_MAX, PAGE_SIZE) + 1)
 #ifndef LZ4_DECOMPRESS_INPLACE_MARGIN
 #define LZ4_DECOMPRESS_INPLACE_MARGIN(srcsize)  (((srcsize) >> 8) + 32)
 #endif
@@ -35,19 +35,28 @@ static int lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
 	const unsigned int nr =
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
 	struct page *availables[LZ4_MAX_DISTANCE_PAGES] = { NULL };
-	unsigned long unused[DIV_ROUND_UP(LZ4_MAX_DISTANCE_PAGES,
-					  BITS_PER_LONG)] = { 0 };
+	unsigned long bounced[DIV_ROUND_UP(LZ4_MAX_DISTANCE_PAGES,
+					   BITS_PER_LONG)] = { 0 };
 	void *kaddr = NULL;
-	unsigned int i, j, k;
+	unsigned int i, j, top;
 
-	for (i = 0; i < nr; ++i) {
+	top = 0;
+	for (i = j = 0; i < nr; ++i, ++j) {
 		struct page *const page = rq->out[i];
+		struct page *victim;
 
-		j = i & (LZ4_MAX_DISTANCE_PAGES - 1);
-		if (availables[j])
-			__set_bit(j, unused);
+		if (j >= LZ4_MAX_DISTANCE_PAGES)
+			j = 0;
+
+		/* 'valid' bounced can only be tested after a complete round */
+		if (test_bit(j, bounced)) {
+			DBG_BUGON(i < LZ4_MAX_DISTANCE_PAGES);
+			DBG_BUGON(top >= LZ4_MAX_DISTANCE_PAGES);
+			availables[top++] = rq->out[i - LZ4_MAX_DISTANCE_PAGES];
+		}
 
 		if (page) {
+			__clear_bit(j, bounced);
 			if (kaddr) {
 				if (kaddr + PAGE_SIZE == page_address(page))
 					kaddr += PAGE_SIZE;
@@ -59,27 +68,24 @@ static int lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
 			continue;
 		}
 		kaddr = NULL;
+		__set_bit(j, bounced);
 
-		k = find_first_bit(unused, LZ4_MAX_DISTANCE_PAGES);
-		if (k < LZ4_MAX_DISTANCE_PAGES) {
-			j = k;
-			get_page(availables[j]);
+		if (top) {
+			victim = availables[--top];
+			get_page(victim);
 		} else {
-			DBG_BUGON(availables[j]);
-
 			if (!list_empty(pagepool)) {
-				availables[j] = lru_to_page(pagepool);
-				list_del(&availables[j]->lru);
-				DBG_BUGON(page_ref_count(availables[j]) != 1);
+				victim = lru_to_page(pagepool);
+				list_del(&victim->lru);
+				DBG_BUGON(page_ref_count(victim) != 1);
 			} else {
-				availables[j] = alloc_pages(GFP_KERNEL, 0);
-				if (!availables[j])
+				victim = alloc_pages(GFP_KERNEL, 0);
+				if (!victim)
 					return -ENOMEM;
 			}
-			availables[j]->mapping = Z_EROFS_MAPPING_STAGING;
+			victim->mapping = Z_EROFS_MAPPING_STAGING;
 		}
-		rq->out[i] = availables[j];
-		__clear_bit(j, unused);
+		rq->out[i] = victim;
 	}
 	return kaddr ? 1 : 0;
 }
-- 
2.17.1

