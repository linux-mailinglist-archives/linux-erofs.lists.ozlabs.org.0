Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id D02B4BA1B7
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Sep 2019 12:06:16 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46bjlV2lhkzDqPv
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Sep 2019 20:06:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.32; helo=huawei.com; envelope-from=gaoxiang25@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46bjlJ14nZzDqNQ
 for <linux-erofs@lists.ozlabs.org>; Sun, 22 Sep 2019 20:06:01 +1000 (AEST)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 55743E99B679547D9151;
 Sun, 22 Sep 2019 18:05:57 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.439.0; Sun, 22 Sep
 2019 18:05:47 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>, <linux-erofs@lists.ozlabs.org>
Subject: [PATCH] erofs: fix mis-inplace determination related with noio chain
Date: Sun, 22 Sep 2019 18:04:34 +0800
Message-ID: <20190922100434.229340-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
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
Cc: Miao Xie <miaoxie@huawei.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Fix a recent cleanup patch. noio (bypass) chain is
handled asynchronously against submit chain, therefore
inplace I/O or pagevec cannot be applied to such pages.
Add detailed comment for this as well.

Fixes: 97e86a858bc3 ("staging: erofs: tidy up decompression frontend")
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---

[ Need stress for more hours on phones to catch this race.
  No more smoke out till now on latest mainline for our
  stress I/O & memory workloads compared with old versions. ]

 fs/erofs/zdata.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 96e34c90f814..fad80c97d247 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -575,7 +575,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	struct erofs_map_blocks *const map = &fe->map;
 	struct z_erofs_collector *const clt = &fe->clt;
 	const loff_t offset = page_offset(page);
-	bool tight = (clt->mode >= COLLECT_PRIMARY_HOOKED);
+	bool tight = true;
 
 	enum z_erofs_cache_alloctype cache_strategy;
 	enum z_erofs_page_type page_type;
@@ -628,8 +628,16 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	preload_compressed_pages(clt, MNGD_MAPPING(sbi),
 				 cache_strategy, pagepool);
 
-	tight &= (clt->mode >= COLLECT_PRIMARY_HOOKED);
 hitted:
+	/*
+	 * Ensure the current partial page belongs to this submit chain rather
+	 * than other concurrent submit chains or the noio(bypass) chain since
+	 * those chains are handled asynchronously thus the page cannot be used
+	 * for inplace I/O or pagevec (should be processed in strict order.)
+	 */
+	tight &= (clt->mode >= COLLECT_PRIMARY_HOOKED &&
+		  clt->mode != COLLECT_PRIMARY_FOLLOWED_NOINPLACE);
+
 	cur = end - min_t(unsigned int, offset + end - map->m_la, end);
 	if (!(map->m_flags & EROFS_MAP_MAPPED)) {
 		zero_user_segment(page, cur, end);
-- 
2.17.1

