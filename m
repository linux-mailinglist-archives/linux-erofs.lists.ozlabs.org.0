Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E6ED0C19
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Oct 2019 12:03:13 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46p8t54my3zDqKr
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Oct 2019 21:03:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.35; helo=huawei.com; envelope-from=gaoxiang25@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46p8sz5NzBzDqHr
 for <linux-erofs@lists.ozlabs.org>; Wed,  9 Oct 2019 21:03:02 +1100 (AEDT)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id DAC71E80F4130BEA6712;
 Wed,  9 Oct 2019 18:02:56 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 9 Oct 2019
 18:02:51 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>, 
 Chao Yu <yuchao0@huawei.com>
Subject: [PATCH for-5.3 5/5] staging: erofs: detect potential multiref due to
 corrupted images
Date: Wed, 9 Oct 2019 18:05:54 +0800
Message-ID: <20191009100554.165048-5-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191009100554.165048-1-gaoxiang25@huawei.com>
References: <20191009100554.165048-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
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
Cc: Miao Xie <miaoxie@huawei.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

commit e12a0ce2fa69798194f3a8628baf6edfbd5c548f upstream.

As reported by erofs-utils fuzzer, currently, multiref
(ondisk deduplication) hasn't been supported for now,
we should forbid it properly.

Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
Cc: <stable@vger.kernel.org> # 4.19+
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Link: https://lore.kernel.org/r/20190821140152.229648-1-gaoxiang25@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Gao Xiang: Since earlier kernels don't define EFSCORRUPTED,
             let's use EIO instead. ]
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/unzip_vle.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 5069cc4c9fb8..155cee68fed5 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -943,6 +943,7 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 	for (i = 0; i < nr_pages; ++i)
 		pages[i] = NULL;
 
+	err = 0;
 	z_erofs_pagevec_ctor_init(&ctor, Z_EROFS_NR_INLINE_PAGEVECS,
 				  work->pagevec, 0);
 
@@ -964,8 +965,17 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 			pagenr = z_erofs_onlinepage_index(page);
 
 		DBG_BUGON(pagenr >= nr_pages);
-		DBG_BUGON(pages[pagenr]);
 
+		/*
+		 * currently EROFS doesn't support multiref(dedup),
+		 * so here erroring out one multiref page.
+		 */
+		if (pages[pagenr]) {
+			DBG_BUGON(1);
+			SetPageError(pages[pagenr]);
+			z_erofs_onlinepage_endio(pages[pagenr]);
+			err = -EIO;
+		}
 		pages[pagenr] = page;
 	}
 	sparsemem_pages = i;
@@ -975,7 +985,6 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 	overlapped = false;
 	compressed_pages = grp->compressed_pages;
 
-	err = 0;
 	for (i = 0; i < clusterpages; ++i) {
 		unsigned int pagenr;
 
@@ -999,7 +1008,12 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 			pagenr = z_erofs_onlinepage_index(page);
 
 			DBG_BUGON(pagenr >= nr_pages);
-			DBG_BUGON(pages[pagenr]);
+			if (pages[pagenr]) {
+				DBG_BUGON(1);
+				SetPageError(pages[pagenr]);
+				z_erofs_onlinepage_endio(pages[pagenr]);
+				err = -EIO;
+			}
 			++sparsemem_pages;
 			pages[pagenr] = page;
 
-- 
2.17.1

