Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0F979FBB3
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Sep 2023 08:12:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RmRn96BHvz3c5f
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Sep 2023 16:12:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RmRn60YjNz3brX
	for <linux-erofs@lists.ozlabs.org>; Thu, 14 Sep 2023 16:12:23 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vs19fa5_1694671931;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vs19fa5_1694671931)
          by smtp.aliyun-inc.com;
          Thu, 14 Sep 2023 14:12:16 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: lib: avoid unnecessary modulo in cache.c
Date: Thu, 14 Sep 2023 14:12:10 +0800
Message-Id: <20230914061210.1296457-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Previously, EROFS_BLKSIZ was a constant so it doesn't matter to use %
operator.  Let's convert the remaining ones now.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/cache.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/cache.c b/lib/cache.c
index 5205d57..ea80a10 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -63,7 +63,8 @@ static void erofs_bupdate_mapped(struct erofs_buffer_block *bb)
 	if (bb->blkaddr == NULL_ADDR)
 		return;
 
-	bkt = mapped_buckets[bb->type] + bb->buffers.off % erofs_blksiz(&sbi);
+	bkt = mapped_buckets[bb->type] +
+		(bb->buffers.off & (erofs_blksiz(&sbi) - 1));
 	list_del(&bb->mapped_list);
 	list_add_tail(&bb->mapped_list, bkt);
 }
@@ -77,8 +78,9 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
 			   bool dryrun)
 {
 	const unsigned int blksiz = erofs_blksiz(&sbi);
+	const unsigned int blkmask = blksiz - 1;
 	const erofs_off_t alignedoffset = roundup(bb->buffers.off, alignsize);
-	const int oob = cmpsgn(roundup((bb->buffers.off - 1) % blksiz + 1,
+	const int oob = cmpsgn(roundup(((bb->buffers.off - 1) & blkmask) + 1,
 				       alignsize) + incr + extrasize, blksiz);
 	bool tailupdate = false;
 	erofs_blk_t blkaddr;
@@ -110,7 +112,7 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
 					DIV_ROUND_UP(bb->buffers.off, blksiz);
 		erofs_bupdate_mapped(bb);
 	}
-	return ((alignedoffset + incr - 1) & (blksiz - 1)) + 1;
+	return ((alignedoffset + incr - 1) & blkmask) + 1;
 }
 
 int erofs_bh_balloon(struct erofs_buffer_head *bh, erofs_off_t incr)
@@ -170,7 +172,7 @@ static int erofs_bfind_for_attach(int type, erofs_off_t size,
 
 		DBG_BUGON(cur->type != type);
 		DBG_BUGON(cur->blkaddr == NULL_ADDR);
-		DBG_BUGON(used_before != cur->buffers.off % blksiz);
+		DBG_BUGON(used_before != (cur->buffers.off & (blksiz - 1)));
 
 		ret = __erofs_battach(cur, NULL, size, alignsize,
 				      required_ext + inline_ext, true);
-- 
2.39.3

