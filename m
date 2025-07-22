Return-Path: <linux-erofs+bounces-701-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 45331B0D67F
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Jul 2025 12:00:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bmXp46p0Cz2yhb;
	Tue, 22 Jul 2025 20:00:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753178444;
	cv=none; b=TzB+rUk6EPl3CkivbwadgEMT4mbJmya706ftBJzV8FO1l8wwdsVMTlUPiLjJiUVz2wnRfvQQTHKBCSCHyrxu8Sc+6mmATE/OEFXedqpHd0cMe1mXezqer+OtMi62Fe/jkQLfDepllD2yStOThCsHIVa7ozHLKZa01Ou+vnDeAd0huxNfjAWtRB+6UnyFxV/1y2+6wZYPakTDKEnmtqo8WQ9gnnSd5IdaVf6ARqex7ezcdWn7jsDWZzGmjcbK7Xui3S7GIWHoqu/MojLciQPG3Ct8GICMPQASe1+29MdhHNYFVe4p3/trtjfvDwn361QHFUa2e6VFYhwlkktIl1E2ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753178444; c=relaxed/relaxed;
	bh=peBcjQkGGRXveCOODLAnQs8d0uMvJgOnnZ+JapebP7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMevhaCNmlWbxVFAgSdUo9eWKjjpRpplHogSsMEhCMo/vcr+ALL30B45hYFF055FGTJoXMKQSU3NRRXurTphkjGnqqMZJDSuy9DnMsm4YeuQOEpHGgYDhmmbPhsTxoPOwRWrjh2hDKEYnJUuK30WYWvCbs8wEaR+aIA/iBchCNBkquARyG07petloyE2SXXn1dLIPUZh3C2Z/lOtZCjAVyQFrk86ijIcxf+JuxA9RZaYxT4zMnxTNmfEypGo2/tSLbfmBj1kjrrmxFT0dI9UXzity+/sg45FKYUK2LnNGB/at5EvBKGLNgwi9e9xMaBieXV7vHtgNmLXlTDtEIpLww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=plWAqqBB; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=plWAqqBB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bmXp40p8jz2yF0
	for <linux-erofs@lists.ozlabs.org>; Tue, 22 Jul 2025 20:00:43 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753178440; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=peBcjQkGGRXveCOODLAnQs8d0uMvJgOnnZ+JapebP7o=;
	b=plWAqqBBARUkH8U/V0b98yc0C64bRLS9mMXXRvbg7/HYONmARoM+0cHUYraX19PT/2cm+s2MsqJZ0EchIUv5gzhRjkX+m7mWuZ6gmy9AXQa5VL4y0U9R7I5vtjv7nyLBMGAdK2p88dFtMNxNoNSs9ErDUsEqPVYj0QsofP3uRws=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WjVvTqv_1753178437 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 22 Jul 2025 18:00:38 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Stefan Kerkmann <s.kerkmann@pengutronix.de>
Cc: linux-erofs@lists.ozlabs.org,
	LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Yue Hu <huyue2@coolpad.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 6.1.y 3/5] erofs: drop z_erofs_page_mark_eio()
Date: Tue, 22 Jul 2025 18:00:27 +0800
Message-ID: <20250722100029.3052177-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250722100029.3052177-1-hsiangkao@linux.alibaba.com>
References: <20250722100029.3052177-1-hsiangkao@linux.alibaba.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

commit 9a05c6a8bc26138d34e87b39e6a815603bc2a66c upstream.

It can be folded into z_erofs_onlinepage_endio() to simplify the code.

Reviewed-by: Yue Hu <huyue2@coolpad.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Link: https://lore.kernel.org/r/20230817082813.81180-5-hsiangkao@linux.alibaba.com
---
 fs/erofs/zdata.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 5c0f855ab18d..b05ca443cfdf 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -144,22 +144,17 @@ static inline void z_erofs_onlinepage_split(struct page *page)
 	atomic_inc((atomic_t *)&page->private);
 }
 
-static inline void z_erofs_page_mark_eio(struct page *page)
+static void z_erofs_onlinepage_endio(struct page *page, int err)
 {
-	int orig;
+	int orig, v;
+
+	DBG_BUGON(!PagePrivate(page));
 
 	do {
 		orig = atomic_read((atomic_t *)&page->private);
-	} while (atomic_cmpxchg((atomic_t *)&page->private, orig,
-				orig | Z_EROFS_PAGE_EIO) != orig);
-}
-
-static inline void z_erofs_onlinepage_endio(struct page *page)
-{
-	unsigned int v;
+		v = (orig - 1) | (err ? Z_EROFS_PAGE_EIO : 0);
+	} while (atomic_cmpxchg((atomic_t *)&page->private, orig, v) != orig);
 
-	DBG_BUGON(!PagePrivate(page));
-	v = atomic_dec_return((atomic_t *)&page->private);
 	if (!(v & ~Z_EROFS_PAGE_EIO)) {
 		set_page_private(page, 0);
 		ClearPagePrivate(page);
@@ -930,9 +925,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		goto repeat;
 
 out:
-	if (err)
-		z_erofs_page_mark_eio(page);
-	z_erofs_onlinepage_endio(page);
+	z_erofs_onlinepage_endio(page, err);
 	return err;
 }
 
@@ -1035,9 +1028,7 @@ static void z_erofs_fill_other_copies(struct z_erofs_decompress_backend *be,
 			cur += len;
 		}
 		kunmap_local(dst);
-		if (err)
-			z_erofs_page_mark_eio(bvi->bvec.page);
-		z_erofs_onlinepage_endio(bvi->bvec.page);
+		z_erofs_onlinepage_endio(bvi->bvec.page, err);
 		list_del(p);
 		kfree(bvi);
 	}
@@ -1205,9 +1196,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 		/* recycle all individual short-lived pages */
 		if (z_erofs_put_shortlivedpage(be->pagepool, page))
 			continue;
-		if (err)
-			z_erofs_page_mark_eio(page);
-		z_erofs_onlinepage_endio(page);
+		z_erofs_onlinepage_endio(page, err);
 	}
 
 	if (be->decompressed_pages != be->onstack_pages)
-- 
2.43.5


