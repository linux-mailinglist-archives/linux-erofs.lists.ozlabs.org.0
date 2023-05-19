Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9965709024
	for <lists+linux-erofs@lfdr.de>; Fri, 19 May 2023 09:08:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QMybx4FlZz3f8y
	for <lists+linux-erofs@lfdr.de>; Fri, 19 May 2023 17:08:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QMybt1Q96z3bNj
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 May 2023 17:08:09 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VizfTZj_1684480078;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VizfTZj_1684480078)
          by smtp.aliyun-inc.com;
          Fri, 19 May 2023 15:08:02 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: fix a race of deduplicated compressed images to avoid loops
Date: Fri, 19 May 2023 15:07:58 +0800
Message-Id: <20230519070758.36779-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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

After heavily stressing EROFS with several images which include a
hand-crafted image of repeated patttens for more than 46 days, I found
two chains could be linked with each other almost simultaneously and
form a loop, so the entire loop won't be submitted to the device.  As a
consequence, the corresponding file pages will remain locked forever.

It can be _only_ observed on data-deduplicated compressed images.  For
example, consider two chains with five pclusters in total:
	Chain 1:  2->3->4->5    -- The tail pcluster is .;
        Chain 2:  5->1->2       -- The tail pcluster is 2.

Chain 2 could link to Chain 1 with pcluster 5; and Chain 1 could link
to Chain 2 at the same time with pcluster 2  (Note that Chain 2 is
invalid on traditional compressed images without data deduplciation.)

Fix this by checking if the tail of a chain is extended after the chain
itself is attached into another chain.  If so, bail out instead.

Fixes: 267f2492c8f7 ("erofs: introduce multi-reference pclusters (fully-referenced)")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
I plan to stress this patch for a week before upstreaming.

 fs/erofs/zdata.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 45f21db2303a..88295c73ff90 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -756,13 +756,17 @@ static void z_erofs_try_to_claim_pcluster(struct z_erofs_decompress_frontend *f)
 	 * type 2, link to the end of an existing open chain, be careful
 	 * that its submission is controlled by the original attached chain.
 	 */
-	if (*owned_head != &pcl->next && pcl != f->tailpcl &&
-	    cmpxchg(&pcl->next, Z_EROFS_PCLUSTER_TAIL,
-		    *owned_head) == Z_EROFS_PCLUSTER_TAIL) {
-		*owned_head = Z_EROFS_PCLUSTER_TAIL;
-		f->mode = Z_EROFS_PCLUSTER_HOOKED;
-		f->tailpcl = NULL;
-		return;
+	if (pcl != f->tailpcl && cmpxchg(&pcl->next, Z_EROFS_PCLUSTER_TAIL,
+					*owned_head) == Z_EROFS_PCLUSTER_TAIL) {
+		/* switch to type 3 if our owned chain is attached by others */
+		if (f->tailpcl && f->tailpcl->next != Z_EROFS_PCLUSTER_TAIL) {
+			WRITE_ONCE(pcl->next, Z_EROFS_PCLUSTER_TAIL);
+		} else {
+			*owned_head = Z_EROFS_PCLUSTER_TAIL;
+			f->mode = Z_EROFS_PCLUSTER_HOOKED;
+			f->tailpcl = NULL;
+			return;
+		}
 	}
 	/* type 3, it belongs to a chain, but it isn't the end of the chain */
 	f->mode = Z_EROFS_PCLUSTER_INFLIGHT;
@@ -825,9 +829,6 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 			goto err_out;
 		}
 	}
-	/* used to check tail merging loop due to corrupted images */
-	if (fe->owned_head == Z_EROFS_PCLUSTER_TAIL)
-		fe->tailpcl = pcl;
 	fe->owned_head = &pcl->next;
 	fe->pcl = pcl;
 	return 0;
@@ -867,14 +868,14 @@ static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe)
 
 	if (ret == -EEXIST) {
 		mutex_lock(&fe->pcl->lock);
-		/* used to check tail merging loop due to corrupted images */
-		if (fe->owned_head == Z_EROFS_PCLUSTER_TAIL)
-			fe->tailpcl = fe->pcl;
-
 		z_erofs_try_to_claim_pcluster(fe);
 	} else if (ret) {
 		return ret;
 	}
+
+	/* detect/avoid loop formed out of chain linking (type 2) */
+	if (fe->pcl->next == Z_EROFS_PCLUSTER_TAIL)
+		fe->tailpcl = fe->pcl;
 	z_erofs_bvec_iter_begin(&fe->biter, &fe->pcl->bvset,
 				Z_EROFS_INLINE_BVECS, fe->pcl->vcnt);
 	/* since file-backed online pages are traversed in reverse order */
-- 
2.24.4

