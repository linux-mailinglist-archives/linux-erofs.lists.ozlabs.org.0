Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D82758E28
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Jul 2023 08:55:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R5RQx1Q3Wz2ypx
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Jul 2023 16:55:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R5RQs2XNVz2yF9
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Jul 2023 16:55:15 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Vnkhvgd_1689749700;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vnkhvgd_1689749700)
          by smtp.aliyun-inc.com;
          Wed, 19 Jul 2023 14:55:06 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: fix wrong primary bvec selection on deduplicated extents
Date: Wed, 19 Jul 2023 14:54:59 +0800
Message-Id: <20230719065459.60083-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Shijie Sun <sunshijie@xiaomi.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

When handling deduplicated compressed data, there can be multiple
decompressed extents pointing to the same compressed data in one shot.

In such cases, the bvecs which belong to the longest extent will be
selected as the primary bvecs for real decompressors to decode and the
other duplicated bvecs will be directly copied from the primary bvecs.

Previously, only relative offsets of the longest extent was checked to
decompress the primary bvecs.  On rare occasions, it can be incorrect
if there are several extents with the same start relative offset.
As a result, some short bvecs could be selected for decompression and
then cause data corruption.

For example, as Shijie Sun reported off-list, considering the following
extents of a file:
 117:   903345..  915250 |   11905 :     385024..    389120 |    4096
...
 119:   919729..  930323 |   10594 :     385024..    389120 |    4096
...
 124:   968881..  980786 |   11905 :     385024..    389120 |    4096

The start relative offset is the same: 2225, but extent 119 (919729..
930323) is shorter than the others.

Let's restrict the bvec length in addition to the start offset if bvecs
are not full.

Reported-by: Shijie Sun <sunshijie@xiaomi.com>
Fixes: 5c2a64252c5d ("erofs: introduce partial-referenced pclusters")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index b69d89a11dd0..de4f12152b62 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1144,10 +1144,11 @@ static void z_erofs_do_decompressed_bvec(struct z_erofs_decompress_backend *be,
 					 struct z_erofs_bvec *bvec)
 {
 	struct z_erofs_bvec_item *item;
+	unsigned int pgnr;
 
-	if (!((bvec->offset + be->pcl->pageofs_out) & ~PAGE_MASK)) {
-		unsigned int pgnr;
-
+	if (!((bvec->offset + be->pcl->pageofs_out) & ~PAGE_MASK) &&
+	    (bvec->end == PAGE_SIZE ||
+	     bvec->offset + bvec->end == be->pcl->length)) {
 		pgnr = (bvec->offset + be->pcl->pageofs_out) >> PAGE_SHIFT;
 		DBG_BUGON(pgnr >= be->nr_pages);
 		if (!be->decompressed_pages[pgnr]) {
-- 
2.24.4

