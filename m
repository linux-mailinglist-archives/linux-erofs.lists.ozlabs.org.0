Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1282A7D2C47
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Oct 2023 10:12:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SDSc90DX1z30gH
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Oct 2023 19:12:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SDSc50839z2xX4
	for <linux-erofs@lists.ozlabs.org>; Mon, 23 Oct 2023 19:12:51 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vuh9U2c_1698048761;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vuh9U2c_1698048761)
          by smtp.aliyun-inc.com;
          Mon, 23 Oct 2023 16:12:46 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/3] erofs-utils: lib: use BLK_ROUND_UP() for __erofs_battach()
Date: Mon, 23 Oct 2023 16:12:39 +0800
Message-Id: <20231023081241.1946579-1-hsiangkao@linux.alibaba.com>
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

Also avoid division in BLK_ROUND_UP().

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/internal.h |  3 ++-
 lib/cache.c              | 15 ++++++++-------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index c1ff582..4d794ae 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -49,7 +49,8 @@ extern struct erofs_sb_info sbi;
 #define erofs_blknr(sbi, addr)  ((addr) >> (sbi)->blkszbits)
 #define erofs_blkoff(sbi, addr) ((addr) & (erofs_blksiz(sbi) - 1))
 #define erofs_pos(sbi, nr)      ((erofs_off_t)(nr) << (sbi)->blkszbits)
-#define BLK_ROUND_UP(sbi, addr)	DIV_ROUND_UP(addr, erofs_blksiz(sbi))
+#define BLK_ROUND_UP(sbi, addr)	\
+	(roundup(addr, erofs_blksiz(sbi)) >> (sbi)->blkszbits)
 
 struct erofs_buffer_head;
 
diff --git a/lib/cache.c b/lib/cache.c
index caca49b..3424e59 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -79,9 +79,10 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
 {
 	const unsigned int blksiz = erofs_blksiz(&sbi);
 	const unsigned int blkmask = blksiz - 1;
-	const erofs_off_t alignedoffset = roundup(bb->buffers.off, alignsize);
-	const int oob = cmpsgn(roundup(((bb->buffers.off - 1) & blkmask) + 1,
-				       alignsize) + incr + extrasize, blksiz);
+	erofs_off_t boff = bb->buffers.off;
+	const erofs_off_t alignedoffset = roundup(boff, alignsize);
+	const int oob = cmpsgn(roundup(((boff - 1) & blkmask) + 1, alignsize) +
+					incr + extrasize, blksiz);
 	bool tailupdate = false;
 	erofs_blk_t blkaddr;
 
@@ -93,7 +94,7 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
 		blkaddr = bb->blkaddr;
 		if (blkaddr != NULL_ADDR) {
 			tailupdate = (tail_blkaddr == blkaddr +
-				      DIV_ROUND_UP(bb->buffers.off, blksiz));
+				      BLK_ROUND_UP(&sbi, boff));
 			if (oob && !tailupdate)
 				return -EINVAL;
 		}
@@ -105,11 +106,11 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
 			bh->block = bb;
 			list_add_tail(&bh->list, &bb->buffers.list);
 		}
-		bb->buffers.off = alignedoffset + incr;
+		boff = alignedoffset + incr;
+		bb->buffers.off = boff;
 		/* need to update the tail_blkaddr */
 		if (tailupdate)
-			tail_blkaddr = blkaddr +
-					DIV_ROUND_UP(bb->buffers.off, blksiz);
+			tail_blkaddr = blkaddr + BLK_ROUND_UP(&sbi, boff);
 		erofs_bupdate_mapped(bb);
 	}
 	return ((alignedoffset + incr - 1) & blkmask) + 1;
-- 
2.39.3

