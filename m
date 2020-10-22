Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2AD296165
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Oct 2020 17:03:28 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CH9bb5JYjzDqSg
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Oct 2020 02:03:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1603379003;
	bh=74m1SXVChq39Jv7vC46EuZvV1qHlLHfzCqbakQ8cVdc=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=N6M1B+hJ/aKE9O3TUf92TNdwb6zgrDrbPPaMEaj8zdPYL4/M84niUjf+jMnEdgeIq
	 MJUyUYEJ9ZDotsMb9LZ3EzS4aZkSJILdPfcNW7RCkW1Jpw7kNml5l9PKvXONIWi/hZ
	 EfJtST2lFFkH84UxRVgOmt80qMtrgfmZLRgNe1yusQxuTFZRu1amXNlkpzlEAeXSIZ
	 ILTpe7hgTeRd6z3ScsBb9U1p3tkvK9fp17LyuPlYRAdubuIXejZo9KZ/mEHwbYZGec
	 uNdH0DJQC5CcJBZZY1cwYy4R8ROrWVF8VLgetu4HcRGudLJyDra6evxrhXtCE+q3zN
	 Kob1ewoGBOCvg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.69.147; helo=sonic310-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=m0JLl2xE; dkim-atps=neutral
Received: from sonic310-21.consmr.mail.gq1.yahoo.com
 (sonic310-21.consmr.mail.gq1.yahoo.com [98.137.69.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CH9TP1lFhzDqnv
 for <linux-erofs@lists.ozlabs.org>; Fri, 23 Oct 2020 01:58:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1603378679; bh=guRsd5n/uh5BC8bHESLKo5zEBYWuxI19CPiguQJ+aXY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=m0JLl2xEZPyNp1sIPEPPcy1bxFPljMo8wHzTd9L5ca+MxzzWCiN26qY9MjpCQ+fk8nsWvbV0TOwnSDmhrNrTpSVCVEnAnWjImhp6zVd8h9WoHbPuYyD3Zy3wfUC8wfbmLEUrvQTp9M/bkJtFFS07xTYyLFaQB/RXMrXalePi0CEwTbLoM5vs0DOORKqM9I8rdJHDp5xyKZYhY0m6gAn7tKtkZCFe3ILbcv7qIuSfluCt+PqSnvhYdH8X7g0cHh723DUE5vhAANBC/Wfjeau6TuLkCxv6pX9vYgUg74UFzqZwG1+kQ9jxPkCm3abJ9DXqFiQd/1ZkVq0DnHJiG9kWsQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1603378679; bh=Sm/EasK/eFvF5q87T3xAXRupUhCHqTiBEfWLKHkj6cg=;
 h=From:To:Subject:Date;
 b=qXe462w0vd+Mz9u+WrBWdt/m5aWXJYm81EQJ2hzai43lEW5FrCYS+flWwmaTgvnNYrN+e74vlPiR62RadOob8lXgfV+ALaIlEgHzn3LXQkUGhCLY+bW0qHh8X/j2946mmNy3OlY3T81r1Wo6A608DsTu8mBfyIeXKG53PaG2R95jpebQPwDbQ4Lu4q/vXNT11y1ZlEHy/c5iBnvVQkZ1zQutd9VOCYbQwuRyGWx2z2uubnskR1C0V4SUnu58/hhUg9adI4ME1gV6iaaTJgSk/EE+OzBwVFHq2vDyyRSHEkyqqD+yjE7ZYNgRMdHgcJMBEaS1kNEA2S+apVIPhijeXA==
X-YMail-OSG: C.qA0sUVM1kSPpncm9G13h0Pq8rudPIXe7_TdhL4gyxBxObWdU3FVO8O4QuV4Sk
 UiNse8_s62Yc2WqU2AWc_KwaGgmyJMMUGiJN1kfqiLnXpIwQqNG7cuUAQXYDmCMSptsg0w0TGsvo
 c_iyZn97zWrWAUtl62G6a17TYkaHooIEvQZb6EMAc67zGoc.Ok1jtps7vsld0b6hDuZBg53g2hKZ
 NlUjCk.vhqDvqXIsnymZD0xB8Hq5WAU._8hFcnfKqneEtmL4qPDaTLikQNse2V90VJDOPLt33v5L
 dfcO.xcMzoo49S3kwRBLy_Y0MG6d.U55ujUTeomjQSzTG6OPgoNy4w5qadrjXLJg5owLdzIyGzpc
 APxu.J2JIyuGoMpfTjlzePK2icFXt7pac5n3yPWJAfaxRapQe5dNO8D.IhZt6ITljcRwDwmSCKHm
 zF41d3M9Zq.5IQ.fml9vHudBcst5Cz5hH_HeViauI00Q5DtnSkUSPysHvBmVICQs6KkJ4wOx_fvH
 wXmd7yGsnEqBKqUJb7cw8wERiNIKKD95XWNK0USAyZXlxha89rf7YJ8CJbgbTk.bkbjZxU9uzArC
 u7L8CqmL52g0xuZV00MyvPk6xVhZ0G07lHTtbil7zr0bGNCDJJkA9GryuVUtaVJbzRJsgHn4it0.
 WKw0CvKrpmH3_q3e4mExO2cXP.9a0sJ_ziurrAFlA_gwT5NJAwHL94ho4UW9tfbSVNOarijlz4eS
 hzgTF2KNuqmLW503jQK8QmrAr9wFzU2jaM7HM7DtNBNmXBBbKSmykD0C8zDYK7bg5TyHiBnET11_
 uw7b8GKQVQ97Yye7cgvNFmfeIH7TsmizllAbnkl34ovcJzgWhQJTfdi4JKImmtf1SEzYaQr.tCdT
 pZgUkaypLsbR3uBqTWbawjhRlylsTFecZcMf8gutQtjwZWwpFEGQEbSEwxH7am.f8PXGyAO4cyjy
 cOLHLM70rOxEXxfouHyPq0PXFND04kkRoeDeWCCe9fK8mdCYNZzT0TqSt6UsHB2ZM6izDujbsPJz
 SB67KucA3XFT0OLTb2BjDWZhw92KU.iPzejK2NGtzLHC_eT5Z8J9KRkyM9q.rHkoZ3FUACARdMj3
 ccgOZk_guQ8.JU_yjcEJ9XDoWAukFO.XOXL4w0urPntzS8oIzrzsXfxCgx6hZWt4hsvYrpKIbDSB
 6yB.HCIT6uy.b8_I2_YEAxLlEZOcUy6Y2f5YrILRIzX89rAvx8AcBMGwEQFCHZmn8EmK6V5KarN8
 EHPPfEENfGPRIeBL0amUTycUWeaN_KbBSPEIfM1Ht7BkBnP37iU2vyV7Iy1KCmSXGhG7ezPjlrQj
 MrA_YNdCqKvz0zO3WvlsQfVe4cQKaiVBAgoYQlglTUauktTzH8G_xazKlenIelyX64WAGtjHijpN
 YkUTyMOshzjKhA3mnK8JKaCgF7w789tQJbz0XW3xdubHIHkvV1aTeqMem3m6Y27fSpCAZPxfQ2Z2
 l5ctIPl1hU7uNh1ElcHV6aDXrqgVNntLLxqNB3Kl3_grtXxdQTTPYBIdCcTlggiLnu3AA.g.EFut
 .ZJYhdmoLRzM-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic310.consmr.mail.gq1.yahoo.com with HTTP; Thu, 22 Oct 2020 14:57:59 +0000
Received: by smtp401.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 354b2034a70b817070abfec37b60849b; 
 Thu, 22 Oct 2020 14:57:56 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 3/4] erofs: insert to managed cache after adding to pcl
Date: Thu, 22 Oct 2020 22:57:23 +0800
Message-Id: <20201022145724.27284-3-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201022145724.27284-1-hsiangkao@aol.com>
References: <20201022145724.27284-1-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@redhat.com>

Previously, it could be some concern to call add_to_page_cache_lru()
with page->mapping == Z_EROFS_MAPPING_STAGING (!= NULL).

In contrast, page->private is used instead now, so partially revert
commit 5ddcee1f3a1c ("erofs: get rid of __stagingpage_alloc helper")
with some adaption for simplicity.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/zdata.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index afeadf413c2c..edd7325570e1 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1071,28 +1071,19 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 	put_page(page);
 out_allocpage:
 	page = erofs_allocpage(pagepool, gfp | __GFP_NOFAIL);
-	if (!tocache || add_to_page_cache_lru(page, mc, index + nr, gfp)) {
-		/* turn into temporary page if fails */
-		set_page_private(page, Z_EROFS_SHORTLIVED_PAGE);
-		tocache = false;
-	}
-
 	if (oldpage != cmpxchg(&pcl->compressed_pages[nr], oldpage, page)) {
-		if (tocache) {
-			/* since it added to managed cache successfully */
-			unlock_page(page);
-			put_page(page);
-		} else {
-			list_add(&page->lru, pagepool);
-		}
+		list_add(&page->lru, pagepool);
 		cond_resched();
 		goto repeat;
 	}
 
-	if (tocache) {
-		set_page_private(page, (unsigned long)pcl);
-		SetPagePrivate(page);
+	if (!tocache || add_to_page_cache_lru(page, mc, index + nr, gfp)) {
+		/* turn into temporary page if fails */
+		set_page_private(page, Z_EROFS_SHORTLIVED_PAGE);
+		goto out;
 	}
+	set_page_private(page, (unsigned long)pcl);
+	SetPagePrivate(page);
 out:	/* the only exit (for tracing and debugging) */
 	return page;
 }
-- 
2.24.0

