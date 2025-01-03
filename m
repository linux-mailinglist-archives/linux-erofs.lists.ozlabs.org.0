Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 16758A00669
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Jan 2025 10:04:03 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YPd0w6hr7z30gK
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Jan 2025 20:04:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1735895038;
	cv=none; b=TQJso7SRfTItp34KVSG12b9iqfo1kYjsXCegrM/NBEpaPeh5iW8JQhtSYlVf47NsnUbAfXScqBn3Ure4CUmlOEhHOt5ri7/1scBYQ1riHLQ9lp1pEXupizRRpoS2QQ66jtUk597FWev7qJi3WB5kIhXDiu87z8UfR9yzsQcWUopjyBqcPnwsANIaw+L4TTmWDgyeycqsZsDjPjpFhngpXn2ApDeVWXpsRPUZhRrPgUaIBKWmtr5XAcuxwr7ICWWBcDMcPsN3Dla+bxksvXOwjzJZdSufJH6fC8JKvBguDyNlfjcgZUJTlmw1ndTaH1iyFuEJOzPfaDkA7Sfw8bnorQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1735895038; c=relaxed/relaxed;
	bh=6EZT8nWDXlHn7K4kQrKFZ8BvwYN+vK8T7oO4oDqIpzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EWK9Ct53e1+wCrIK1xB/rMLYPIGNfaPcegDt7enkZmzgr9a9a1hoZYEYXzKx4o+m7HK48H1avqhPeKsP+FojSaxr3soYaZgSpKdQdhTFn82n5pq8EcBcID2oUh5KPv8p7xblBP6xrz0mxzpA5m95ZNCcncuMXdFAuT2BSPOcfo4xaIMj53IMSp4Xt1qkY4knjuPO7jJDCNsrStxC82zqh29nY9/QtRNHztNcRlDFydrjdY3dkSJZkc9R5nPWpEb1R8urtG6ubcnoIKmZdhTzSMNjKW5LFoBMLyjYZffWEZ+o+ZHXv8WbsI8keO8rllmmWUVidIEMzHq/zEJDaxBfYQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=H/Id1UDc; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=H/Id1UDc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YPd0q5fJKz30Pn
	for <linux-erofs@lists.ozlabs.org>; Fri,  3 Jan 2025 20:03:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1735895028; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=6EZT8nWDXlHn7K4kQrKFZ8BvwYN+vK8T7oO4oDqIpzQ=;
	b=H/Id1UDcYyJr1anS0YUI3hsExsHRgui6HZTQK972P/c2vEhkKyue4qKJ22Sp27FPzk05IILYdhsosL1lQDeMA6NgYzzdfaWvoRFXecxXqa4OBSyA2+Gk93cIPlpXIam9FUcjtRg6oIELkotE+EtMLvZOAnFf4Kk/DmxSl0sMiv4=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WMsl6R-_1735895026 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 03 Jan 2025 17:03:47 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 3/5] erofs-utils: lib: rename `mapped_buckets` to `watermeter`
Date: Fri,  3 Jan 2025 17:03:36 +0800
Message-ID: <20250103090338.740593-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250103090338.740593-1-hsiangkao@linux.alibaba.com>
References: <20250103090338.740593-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In order to prepare for the upcoming space allocation speedup.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/cache.h |  4 ++--
 lib/cache.c           | 27 +++++++++++++--------------
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/include/erofs/cache.h b/include/erofs/cache.h
index 6ff80ab..bdf6460 100644
--- a/include/erofs/cache.h
+++ b/include/erofs/cache.h
@@ -48,7 +48,7 @@ struct erofs_buffer_head {
 
 struct erofs_buffer_block {
 	struct list_head list;
-	struct list_head mapped_list;
+	struct list_head sibling;	/* blocks of the same waterline */
 
 	erofs_blk_t blkaddr;
 	int type;
@@ -60,7 +60,7 @@ struct erofs_bufmgr {
 	struct erofs_sb_info *sbi;
 
 	/* buckets for all mapped buffer blocks to boost up allocation */
-	struct list_head mapped_buckets[META + 1][EROFS_MAX_BLOCK_SIZE];
+	struct list_head watermeter[META + 1][EROFS_MAX_BLOCK_SIZE];
 
 	struct erofs_buffer_block blkh;
 	erofs_blk_t tail_blkaddr, metablkcnt;
diff --git a/lib/cache.c b/lib/cache.c
index f9aa6eb..c7243b5 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -41,15 +41,15 @@ struct erofs_bufmgr *erofs_buffer_init(struct erofs_sb_info *sbi,
 	bufmgr->blkh.blkaddr = NULL_ADDR;
 	bufmgr->last_mapped_block = &bufmgr->blkh;
 
-	for (i = 0; i < ARRAY_SIZE(bufmgr->mapped_buckets); i++)
-		for (j = 0; j < ARRAY_SIZE(bufmgr->mapped_buckets[0]); j++)
-			init_list_head(&bufmgr->mapped_buckets[i][j]);
+	for (i = 0; i < ARRAY_SIZE(bufmgr->watermeter); i++)
+		for (j = 0; j < (1 << sbi->blkszbits); j++)
+			init_list_head(&bufmgr->watermeter[i][j]);
 	bufmgr->tail_blkaddr = startblk;
 	bufmgr->sbi = sbi;
 	return bufmgr;
 }
 
-static void erofs_bupdate_mapped(struct erofs_buffer_block *bb)
+static void erofs_update_bwatermeter(struct erofs_buffer_block *bb)
 {
 	struct erofs_bufmgr *bmgr = bb->buffers.fsprivate;
 	struct erofs_sb_info *sbi = bmgr->sbi;
@@ -58,10 +58,10 @@ static void erofs_bupdate_mapped(struct erofs_buffer_block *bb)
 	if (bb->blkaddr == NULL_ADDR)
 		return;
 
-	bkt = bmgr->mapped_buckets[bb->type] +
+	bkt = bmgr->watermeter[bb->type] +
 		(bb->buffers.off & (erofs_blksiz(sbi) - 1));
-	list_del(&bb->mapped_list);
-	list_add_tail(&bb->mapped_list, bkt);
+	list_del(&bb->sibling);
+	list_add_tail(&bb->sibling, bkt);
 }
 
 /* return occupied bytes in specific buffer block if succeed */
@@ -116,7 +116,7 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
 		/* need to update the tail_blkaddr */
 		if (tailupdate)
 			bmgr->tail_blkaddr = blkaddr + bb->buffers.nblocks;
-		erofs_bupdate_mapped(bb);
+		erofs_update_bwatermeter(bb);
 	}
 	return ((alignedoffset + incr + blkmask) & blkmask) + 1;
 }
@@ -165,12 +165,11 @@ static int erofs_bfind_for_attach(struct erofs_bufmgr *bmgr,
 		used_before = rounddown(blksiz - (size + inline_ext), alignsize);
 
 	for (; used_before; --used_before) {
-		struct list_head *bt = bmgr->mapped_buckets[type] + used_before;
+		struct list_head *bt = bmgr->watermeter[type] + used_before;
 
 		if (list_empty(bt))
 			continue;
-		cur = list_first_entry(bt, struct erofs_buffer_block,
-				       mapped_list);
+		cur = list_first_entry(bt, struct erofs_buffer_block, sibling);
 
 		/* last mapped block can be expended, don't handle it here */
 		if (list_next_entry(cur, list)->blkaddr == NULL_ADDR) {
@@ -279,7 +278,7 @@ struct erofs_buffer_head *erofs_balloc(struct erofs_bufmgr *bmgr,
 				 &bmgr->last_mapped_block->list);
 		else
 			list_add_tail(&bb->list, &bmgr->blkh.list);
-		init_list_head(&bb->mapped_list);
+		init_list_head(&bb->sibling);
 
 		bh = malloc(sizeof(struct erofs_buffer_head));
 		if (!bh) {
@@ -343,7 +342,7 @@ static void __erofs_mapbh(struct erofs_buffer_block *bb)
 			}
 		}
 		bmgr->last_mapped_block = bb;
-		erofs_bupdate_mapped(bb);
+		erofs_update_bwatermeter(bb);
 	}
 
 	blkaddr = bb->blkaddr + bb->buffers.nblocks;
@@ -382,7 +381,7 @@ static void erofs_bfree(struct erofs_buffer_block *bb)
 	if (bb == bmgr->last_mapped_block)
 		bmgr->last_mapped_block = list_prev_entry(bb, list);
 
-	list_del(&bb->mapped_list);
+	list_del(&bb->sibling);
 	list_del(&bb->list);
 	free(bb);
 }
-- 
2.43.5

