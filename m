Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E23A00668
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Jan 2025 10:04:02 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YPd0w2vSdz30V0
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Jan 2025 20:04:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1735895038;
	cv=none; b=XaKoLrrgxYQNxJU0oGf499S35OgdDDRYOTh7unMeS4gkkBE0WRNgvzfwpYMNmpRnUcmUt/FihZB5nHu14iG339MUU21RIIfUgqXoB8HWJ5Q0tuwf38yDL5Q8SH3YWbG3+MQs4WeCJlIX8k6MtmbzJDZdxegkl4jCjNbMXhLdYSx7A8P5TStHmMLgI34XhnxkCKQp535vs435PKr8IHZKXgy/DLdTEp17CFOvU6o7W8QfI5mno+I28A2e6IQhd4XbriVVPswBTX7Dn0sr+iTv34KSLprY7buOagXbv4cuh39brZyGpK2zG/7tpWXtkdNTpRvjwcunc+CWFGu+UWUPOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1735895038; c=relaxed/relaxed;
	bh=9mgcwT0gD80Vj5wshaKCDK3V//RNQcsFYT67X3SZAk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hsyq993HwYcao/HxWD2y2n6bxDAeraoL1fPWynazd/Q9sVpyePQyiuGMGV9zFwkHyi6aAdxVV+VNHXrKmB5AZ8qDDuvdcdWjdS8xNbLEXLHpE6hLFqdrbiTRGGne4TRzCgbzIC5HFlKnwVbBUcbG+n7RzlCp1x+5RLh3JUbkM/Zi4eV4UhMdyUpfxGbh0tsBYWskRWfgvMy2eiZibZTDZdOdy65ZeWj0tgW3CwR1fNZq79RWAaExaGjlFlHIsZgfnPo+Jp6qJ63ksNb/8EiuEFBja2RSZykwWg52VSbCwvg4ITvBhXqX9sxMs7OTLwq4DqULwtr3dIzNoarWBA8qHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ye4dDyx8; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ye4dDyx8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YPd0q5chFz30Nl
	for <linux-erofs@lists.ozlabs.org>; Fri,  3 Jan 2025 20:03:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1735895029; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=9mgcwT0gD80Vj5wshaKCDK3V//RNQcsFYT67X3SZAk4=;
	b=ye4dDyx8Nw7HbEhcp7c2xk91jtc1KdLkrprXGgH4z4KDjMse8MnZg5paYxT4CAaWUMQjjbMW6YtJsH/QPTKNqiUFA+7ooljESkQz/HzOtzFlHyczSvw+FAwe4FeXHeWXLTsHjZkoVTWa+1FKIRuhDKLejIUujfyQk0ZPDRDYX/k=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WMsl6RK_1735895027 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 03 Jan 2025 17:03:48 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 4/5] erofs-utils: lib: optimize space allocation
Date: Fri,  3 Jan 2025 17:03:37 +0800
Message-ID: <20250103090338.740593-4-hsiangkao@linux.alibaba.com>
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

Previously, only mapped buffers were kept in the form of bucket lists
for each type and for each possible used bytes in the last block.

Apply this to unmapped buffers as well for faster greedy selection.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/cache.h |   4 +-
 lib/cache.c           | 152 ++++++++++++++++++++----------------------
 2 files changed, 73 insertions(+), 83 deletions(-)

diff --git a/include/erofs/cache.h b/include/erofs/cache.h
index bdf6460..76c5671 100644
--- a/include/erofs/cache.h
+++ b/include/erofs/cache.h
@@ -59,8 +59,8 @@ struct erofs_buffer_block {
 struct erofs_bufmgr {
 	struct erofs_sb_info *sbi;
 
-	/* buckets for all mapped buffer blocks to boost up allocation */
-	struct list_head watermeter[META + 1][EROFS_MAX_BLOCK_SIZE];
+	/* buckets for all buffer blocks to boost up allocation */
+	struct list_head watermeter[META + 1][2][EROFS_MAX_BLOCK_SIZE];
 
 	struct erofs_buffer_block blkh;
 	erofs_blk_t tail_blkaddr, metablkcnt;
diff --git a/lib/cache.c b/lib/cache.c
index c7243b5..2e758ba 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -31,7 +31,7 @@ struct erofs_bufmgr *erofs_buffer_init(struct erofs_sb_info *sbi,
 				       erofs_blk_t startblk)
 {
 	struct erofs_bufmgr *bufmgr;
-	int i, j;
+	int i, j, k;
 
 	bufmgr = malloc(sizeof(struct erofs_bufmgr));
 	if (!bufmgr)
@@ -42,8 +42,9 @@ struct erofs_bufmgr *erofs_buffer_init(struct erofs_sb_info *sbi,
 	bufmgr->last_mapped_block = &bufmgr->blkh;
 
 	for (i = 0; i < ARRAY_SIZE(bufmgr->watermeter); i++)
-		for (j = 0; j < (1 << sbi->blkszbits); j++)
-			init_list_head(&bufmgr->watermeter[i][j]);
+		for (j = 0; j < ARRAY_SIZE(bufmgr->watermeter[0]); j++)
+			for (k = 0; k < (1 << sbi->blkszbits); k++)
+				init_list_head(&bufmgr->watermeter[i][j][k]);
 	bufmgr->tail_blkaddr = startblk;
 	bufmgr->sbi = sbi;
 	return bufmgr;
@@ -55,10 +56,7 @@ static void erofs_update_bwatermeter(struct erofs_buffer_block *bb)
 	struct erofs_sb_info *sbi = bmgr->sbi;
 	struct list_head *bkt;
 
-	if (bb->blkaddr == NULL_ADDR)
-		return;
-
-	bkt = bmgr->watermeter[bb->type] +
+	bkt = bmgr->watermeter[bb->type][bb->blkaddr != NULL_ADDR] +
 		(bb->buffers.off & (erofs_blksiz(sbi) - 1));
 	list_del(&bb->sibling);
 	list_add_tail(&bb->sibling, bkt);
@@ -139,96 +137,88 @@ static int erofs_bfind_for_attach(struct erofs_bufmgr *bmgr,
 				  struct erofs_buffer_block **bbp)
 {
 	const unsigned int blksiz = erofs_blksiz(bmgr->sbi);
+	const unsigned int blkmask = blksiz - 1;
 	struct erofs_buffer_block *cur, *bb;
-	unsigned int used0, used_before, usedmax, used;
+	unsigned int index, used0, end, mapped;
+	unsigned int usedmax, used;
 	int ret;
 
-	used0 = (size & (blksiz - 1)) + inline_ext;
-	/* inline data should be in the same fs block */
-	if (used0 > blksiz)
-		return -ENOSPC;
-
-	if (!used0 || alignsize == blksiz) {
+	if (alignsize == blksiz) {
 		*bbp = NULL;
 		return 0;
 	}
-
 	usedmax = 0;
 	bb = NULL;
 
-	/* try to find a most-fit mapped buffer block first */
-	if (__erofs_unlikely(bmgr->dsunit > 1))
-		used_before = blksiz - alignsize;
-	else if (size + inline_ext >= blksiz)
-		goto skip_mapped;
-	else
-		used_before = rounddown(blksiz - (size + inline_ext), alignsize);
-
-	for (; used_before; --used_before) {
-		struct list_head *bt = bmgr->watermeter[type] + used_before;
-
-		if (list_empty(bt))
-			continue;
-		cur = list_first_entry(bt, struct erofs_buffer_block, sibling);
-
-		/* last mapped block can be expended, don't handle it here */
-		if (list_next_entry(cur, list)->blkaddr == NULL_ADDR) {
-			DBG_BUGON(cur != bmgr->last_mapped_block);
-			continue;
-		}
-
-		DBG_BUGON(cur->type != type);
-		DBG_BUGON(cur->blkaddr == NULL_ADDR);
-		DBG_BUGON(used_before != (cur->buffers.off & (blksiz - 1)));
-
-		ret = __erofs_battach(cur, NULL, size, alignsize,
-				      inline_ext, true);
-		if (ret < 0) {
-			DBG_BUGON(!(bmgr->dsunit > 1));
-			continue;
-		}
-
-		usedmax = ret + inline_ext;
-		/* should contain all data in the current block */
-		DBG_BUGON(usedmax > blksiz);
-		bb = cur;
-		break;
+	mapped = ARRAY_SIZE(bmgr->watermeter);
+	used0 = rounddown(blksiz - ((size + inline_ext) & blkmask), alignsize);
+	if (__erofs_unlikely(bmgr->dsunit > 1)) {
+		end = used0 + alignsize - 1;
+	} else {
+		end = blksiz;
+		if (size + inline_ext >= blksiz)
+			--mapped;
 	}
+	index = used0 + blksiz;
 
-skip_mapped:
-	/* try to start from the last mapped one, which can be expended */
-	cur = bmgr->last_mapped_block;
-	if (cur == &bmgr->blkh)
-		cur = list_next_entry(cur, list);
-	for (; cur != &bmgr->blkh; cur = list_next_entry(cur, list)) {
-		used_before = cur->buffers.off & (blksiz - 1);
-
-		/* skip if buffer block is just full */
-		if (!used_before)
-			continue;
+	while (mapped) {
+		--mapped;
+		for (; index > end; --index) {
+			struct list_head *bt;
 
-		/* skip if the entry which has different type */
-		if (cur->type != type)
-			continue;
+			used = index & blkmask;
+			bt = bmgr->watermeter[type][mapped] + used;
+			if (list_empty(bt))
+				continue;
+			cur = list_first_entry(bt, struct erofs_buffer_block,
+					       sibling);
+
+			/* skip the last mapped block */
+			if (mapped &&
+			    list_next_entry(cur, list)->blkaddr == NULL_ADDR) {
+				DBG_BUGON(cur != bmgr->last_mapped_block);
+				cur = list_next_entry(cur, sibling);
+				if (&cur->sibling == bt)
+					continue;
+			}
 
-		ret = __erofs_battach(cur, NULL, size, alignsize,
-				      inline_ext, true);
-		if (ret < 0)
-			continue;
+			DBG_BUGON(cur->type != type);
+			DBG_BUGON((cur->blkaddr != NULL_ADDR) ^ mapped);
+			DBG_BUGON(used != (cur->buffers.off & blkmask));
 
-		used = ret + inline_ext;
-		DBG_BUGON(used > blksiz);
+			ret = __erofs_battach(cur, NULL, size, alignsize,
+					      inline_ext, true);
+			if (ret < 0) {
+				DBG_BUGON(mapped && !(bmgr->dsunit > 1));
+				continue;
+			}
 
-		/*
-		 * remaining should be smaller than before or
-		 * larger than allocating a new buffer block
-		 */
-		if (used < used_before && used < used0)
-			continue;
+			used = ret + inline_ext;
 
-		if (usedmax < used) {
-			bb = cur;
-			usedmax = used;
+			/* should contain all data in the current block */
+			DBG_BUGON(used > blksiz);
+			if (used > usedmax) {
+				usedmax = used;
+				bb = cur;
+			}
+			break;
+		}
+		end = used0 + alignsize - 1;
+		index = used0 + blksiz;
+
+		/* try the last mapped block independently */
+		cur = bmgr->last_mapped_block;
+		if (mapped && cur != &bmgr->blkh && cur->type == type) {
+			ret = __erofs_battach(cur, NULL, size,
+					      alignsize, inline_ext, true);
+			if (ret >= 0) {
+				used = ret + inline_ext;
+				DBG_BUGON(used > blksiz);
+				if (used > usedmax) {
+					usedmax = used;
+					bb = cur;
+				}
+			}
 		}
 	}
 	*bbp = bb;
-- 
2.43.5

