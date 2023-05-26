Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A48712E09
	for <lists+linux-erofs@lfdr.de>; Fri, 26 May 2023 22:15:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QSbl1007Qz3fJB
	for <lists+linux-erofs@lfdr.de>; Sat, 27 May 2023 06:15:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QSbkm6Fk7z3fCb
	for <linux-erofs@lists.ozlabs.org>; Sat, 27 May 2023 06:15:11 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VjXYN3g_1685132106;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VjXYN3g_1685132106)
          by smtp.aliyun-inc.com;
          Sat, 27 May 2023 04:15:07 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/6] erofs: allocate extra bvec pages directly instead of retrying
Date: Sat, 27 May 2023 04:14:54 +0800
Message-Id: <20230526201459.128169-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230526201459.128169-1-hsiangkao@linux.alibaba.com>
References: <20230526201459.128169-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

If non-bootstrap bvecs cannot be kept in place (very rarely), an extra
short-lived page is allocated.

Let's just allocate it immediately rather than do unnecessary -EAGAIN
return first and retry as a cleanup.  Also it's unnecessary to use
__GFP_NOFAIL here since we could gracefully fail out this case instead.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
no change.

 fs/erofs/zdata.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 1de6c84285a6..59dc2537af00 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -242,12 +242,17 @@ static int z_erofs_bvec_enqueue(struct z_erofs_bvec_iter *iter,
 				struct z_erofs_bvec *bvec,
 				struct page **candidate_bvpage)
 {
-	if (iter->cur == iter->nr) {
-		if (!*candidate_bvpage)
-			return -EAGAIN;
-
+	if (iter->cur >= iter->nr) {
+		struct page *nextpage = *candidate_bvpage;
+
+		if (!nextpage) {
+			nextpage = alloc_page(GFP_NOFS);
+			if (!nextpage)
+				return -ENOMEM;
+			set_page_private(nextpage, Z_EROFS_SHORTLIVED_PAGE);
+		}
 		DBG_BUGON(iter->bvset->nextpage);
-		iter->bvset->nextpage = *candidate_bvpage;
+		iter->bvset->nextpage = nextpage;
 		z_erofs_bvset_flip(iter);
 
 		iter->bvset->nextpage = NULL;
@@ -908,10 +913,8 @@ static bool z_erofs_collector_end(struct z_erofs_decompress_frontend *fe)
 	z_erofs_bvec_iter_end(&fe->biter);
 	mutex_unlock(&pcl->lock);
 
-	if (fe->candidate_bvpage) {
-		DBG_BUGON(z_erofs_is_shortlived_page(fe->candidate_bvpage));
+	if (fe->candidate_bvpage)
 		fe->candidate_bvpage = NULL;
-	}
 
 	/*
 	 * if all pending pages are added, don't hold its reference
@@ -1056,24 +1059,13 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	if (cur)
 		tight &= (fe->mode >= Z_EROFS_PCLUSTER_FOLLOWED);
 
-retry:
 	err = z_erofs_attach_page(fe, &((struct z_erofs_bvec) {
 					.page = page,
 					.offset = offset - map->m_la,
 					.end = end,
 				  }), exclusive);
-	/* should allocate an additional short-lived page for bvset */
-	if (err == -EAGAIN && !fe->candidate_bvpage) {
-		fe->candidate_bvpage = alloc_page(GFP_NOFS | __GFP_NOFAIL);
-		set_page_private(fe->candidate_bvpage,
-				 Z_EROFS_SHORTLIVED_PAGE);
-		goto retry;
-	}
-
-	if (err) {
-		DBG_BUGON(err == -EAGAIN && fe->candidate_bvpage);
+	if (err)
 		goto out;
-	}
 
 	z_erofs_onlinepage_split(page);
 	/* bump up the number of spiltted parts of a page */
-- 
2.24.4

