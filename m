Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E07E977F21A
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Aug 2023 10:28:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RRJ7J64MDz3bTC
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Aug 2023 18:28:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RRJ725k85z2ytV
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Aug 2023 18:28:30 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vpz9R0e_1692260904;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vpz9R0e_1692260904)
          by smtp.aliyun-inc.com;
          Thu, 17 Aug 2023 16:28:25 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 4/8] erofs: tidy up z_erofs_do_read_page()
Date: Thu, 17 Aug 2023 16:28:09 +0800
Message-Id: <20230817082813.81180-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
References: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
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

 - Fix a typo: spiltted => split;

 - Move !EROFS_MAP_MAPPED and EROFS_MAP_FRAGMENT upwards;

 - Increase `split` in advance to avoid unnecessary repeat.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 53 ++++++++++++++++++++++--------------------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 30ecdfe41836..a200e99f7d4f 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -980,49 +980,34 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	struct erofs_map_blocks *const map = &fe->map;
 	const loff_t offset = page_offset(page);
 	bool tight = true, exclusive;
-	unsigned int cur, end, len, spiltted;
+	unsigned int cur, end, len, split;
 	int err = 0;
 
-	/* register locked file pages as online pages in pack */
 	z_erofs_onlinepage_init(page);
 
-	spiltted = 0;
+	split = 0;
 	end = PAGE_SIZE;
 repeat:
-	cur = end - 1;
-
-	if (offset + cur < map->m_la ||
-	    offset + cur >= map->m_la + map->m_llen) {
+	if (offset + end - 1 < map->m_la ||
+	    offset + end - 1 >= map->m_la + map->m_llen) {
 		z_erofs_pcluster_end(fe);
-		map->m_la = offset + cur;
+		map->m_la = offset + end - 1;
 		map->m_llen = 0;
 		err = z_erofs_map_blocks_iter(inode, map, 0);
 		if (err)
 			goto out;
-	} else if (fe->pcl) {
-		goto hitted;
 	}
 
-	if ((map->m_flags & EROFS_MAP_MAPPED) &&
-	    !(map->m_flags & EROFS_MAP_FRAGMENT)) {
-		err = z_erofs_pcluster_begin(fe);
-		if (err)
-			goto out;
-	}
-hitted:
-	/*
-	 * Ensure the current partial page belongs to this submit chain rather
-	 * than other concurrent submit chains or the noio(bypass) chain since
-	 * those chains are handled asynchronously thus the page cannot be used
-	 * for inplace I/O or bvpage (should be processed in a strict order.)
-	 */
-	tight &= (fe->mode > Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE);
+	cur = offset > map->m_la ? 0 : map->m_la - offset;
+	/* bump split parts first to avoid several separate cases */
+	++split;
 
-	cur = end - min_t(erofs_off_t, offset + end - map->m_la, end);
 	if (!(map->m_flags & EROFS_MAP_MAPPED)) {
 		zero_user_segment(page, cur, end);
+		tight = false;
 		goto next_part;
 	}
+
 	if (map->m_flags & EROFS_MAP_FRAGMENT) {
 		erofs_off_t fpos = offset + cur - map->m_la;
 
@@ -1031,12 +1016,24 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 				EROFS_I(inode)->z_fragmentoff + fpos);
 		if (err)
 			goto out;
-		++spiltted;
 		tight = false;
 		goto next_part;
 	}
 
-	exclusive = (!cur && (!spiltted || tight));
+	if (!fe->pcl) {
+		err = z_erofs_pcluster_begin(fe);
+		if (err)
+			goto out;
+	}
+
+	/*
+	 * Ensure the current partial page belongs to this submit chain rather
+	 * than other concurrent submit chains or the noio(bypass) chain since
+	 * those chains are handled asynchronously thus the page cannot be used
+	 * for inplace I/O or bvpage (should be processed in a strict order.)
+	 */
+	tight &= (fe->mode > Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE);
+	exclusive = (!cur && ((split <= 1) || tight));
 	if (cur)
 		tight &= (fe->mode >= Z_EROFS_PCLUSTER_FOLLOWED);
 
@@ -1049,8 +1046,6 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		goto out;
 
 	z_erofs_onlinepage_split(page);
-	/* bump up the number of spiltted parts of a page */
-	++spiltted;
 	if (fe->pcl->pageofs_out != (map->m_la & ~PAGE_MASK))
 		fe->pcl->multibases = true;
 	if (fe->pcl->length < offset + end - map->m_la) {
-- 
2.24.4

