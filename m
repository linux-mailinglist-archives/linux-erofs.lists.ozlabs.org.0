Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0935FE917
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Oct 2022 08:49:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MpcSX3Lvjz3c9p
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Oct 2022 17:49:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57; helo=out30-57.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MpcSS11V9z3bWB
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Oct 2022 17:49:26 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VS6n2Py_1665730157;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VS6n2Py_1665730157)
          by smtp.aliyun-inc.com;
          Fri, 14 Oct 2022 14:49:22 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] erofs: fix up inplace decompression success rate
Date: Fri, 14 Oct 2022 14:49:15 +0800
Message-Id: <20221014064915.8103-1-hsiangkao@linux.alibaba.com>
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

Partial decompression should be checked after updating length.
It's a new regression when introducing multi-reference pclusters.

Fixes: 2bfab9c0edac ("erofs: record the longest decompressed size in this round")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index cce56dde135c..2417d7b73622 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -812,15 +812,14 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	++spiltted;
 	if (fe->pcl->pageofs_out != (map->m_la & ~PAGE_MASK))
 		fe->pcl->multibases = true;
-
-	if ((map->m_flags & EROFS_MAP_FULL_MAPPED) &&
-	    !(map->m_flags & EROFS_MAP_PARTIAL_REF) &&
-	    fe->pcl->length == map->m_llen)
-		fe->pcl->partial = false;
 	if (fe->pcl->length < offset + end - map->m_la) {
 		fe->pcl->length = offset + end - map->m_la;
 		fe->pcl->pageofs_out = map->m_la & ~PAGE_MASK;
 	}
+	if ((map->m_flags & EROFS_MAP_FULL_MAPPED) &&
+	    !(map->m_flags & EROFS_MAP_PARTIAL_REF) &&
+	    fe->pcl->length == map->m_llen)
+		fe->pcl->partial = false;
 next_part:
 	/* shorten the remaining extent to update progress */
 	map->m_llen = offset + cur - map->m_la;
-- 
2.24.4

