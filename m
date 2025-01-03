Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7A0A0066C
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Jan 2025 10:04:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YPd0y6pgDz30hY
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Jan 2025 20:04:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1735895040;
	cv=none; b=Q/m1mN3+G6DbJ3+vN8iig05OmDbKUk2VHVhV0LgcDxtCKJRtTPNSXlzVTUJ7Nq+rmbbUP4vBMz3t1xQIby9oqBTCVINILWBvusr0Wnx4/Sk4RPs7a1N343lNVK8imtmnJpgqXgu8ckSrn3rxzMw6Te8pBCXwcQWMz1eOE6wjXMbD2tcky3QVhXxDhclAU+cyNgjUwwsB9qbmvhDKCFULkU4c7OqgCyDnC+8myoJfQEhWyEfT1yao5pWRlFCartJrhZbBX8V7s/sBmx7ZXOzAIqz9FY5Kkx7I5duhfw3seGSMmx/87sVnNiNb/iH0MLyTNhUMrCUMCRlfL7fqIElvcg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1735895040; c=relaxed/relaxed;
	bh=y4elyIMO5XxLRy2QFZZvgMyyHBGZ8fIk0G8YQ4N2+5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSzMak83akg9lKbXnPdMoIzyOFn55F1C3GDdciJvXS4Vf0gkSwml7sbAz8x+XAKDNbZGreBWrunjJ8mvOWaAe5HfYynBUYnEAdthvKdb67rb/5DjI/ahEtIYJUmInPTDGBXyj3S5h9whkqhzoTRvzWOZIfIbFA9X0RXp3MqaAYthZgXBsUYMtn3nB+K0PfNXBmTgwyXjYtujj8D1s/V3BFhPjH5w4fvj6ixzeiY6i5cHWRW/8WiENYpYOi6YpTz0jy5rCBX1CsMNwVu4z++osvPhrCPWgL5+Y3ICbufnsNAZHzecPzPJ6awfyG2X+RUBP9etzpoZF1IbeIEFOwEg0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hv/n5eGP; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hv/n5eGP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YPd0q5FXpz2yFD
	for <linux-erofs@lists.ozlabs.org>; Fri,  3 Jan 2025 20:03:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1735895030; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=y4elyIMO5XxLRy2QFZZvgMyyHBGZ8fIk0G8YQ4N2+5s=;
	b=hv/n5eGPk4t/xHYa0M1DtCdr2jDVEjy02KMWxoPLe3JljiSFX5FBeM5eFMkjw2Edq8QV+gSR4Bjz72/8UB+Ylb/Pr2UUVY2mWFFm/93dAWTHaCuGam8TeDhu9kH//RzbW1SurMlsn291/DzcL/nEin4eb5k2G6hIc74OdW1U2yg=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WMsl6Rl_1735895028 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 03 Jan 2025 17:03:49 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 5/5] erofs-utils: lib: use bitmaps to accelerate bucket selection
Date: Fri,  3 Jan 2025 17:03:38 +0800
Message-ID: <20250103090338.740593-5-hsiangkao@linux.alibaba.com>
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

Instead of looping over bucket lists directly, maintain bitmaps
for more efficient greedy selection.

ILSVRC2012_img_train.tar (1,281,168 inodes) [1]
  uncompressed EROFS (vanilla):       147,059,949,568B  36m29.529s
  uncompressed EROFS (patched):       147,059,511,296B  1m14.920s

ILSVRC2012_img_val.tar (50,001 inodes)  6,744,924,160B [2]
  uncompressed EROFS (vanilla):         6,713,278,464B  29.998s
  uncompressed EROFS (patched):         6,713,188,352B  23.753s

[1] https://image-net.org/data/ILSVRC/2012/ILSVRC2012_img_train.tar
    $ tar -xvf ILSVRC2012_img_train.tar; rm -f ILSVRC2012_img_train.tar
    $ find . -name "*.tar" | while read NAME ; do tar -xvf "${NAME}"; rm -f "${NAME}"; done

[2] https://image-net.org/data/ILSVRC/2012/ILSVRC2012_img_vol.tar
    $ mkfs.erofs --tar=f --sort none foo.erofs ILSVRC2012_img_vol.tar

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/cache.h |   1 +
 lib/cache.c           | 119 +++++++++++++++++++++++++++++++++---------
 2 files changed, 94 insertions(+), 26 deletions(-)

diff --git a/include/erofs/cache.h b/include/erofs/cache.h
index 76c5671..87d743a 100644
--- a/include/erofs/cache.h
+++ b/include/erofs/cache.h
@@ -61,6 +61,7 @@ struct erofs_bufmgr {
 
 	/* buckets for all buffer blocks to boost up allocation */
 	struct list_head watermeter[META + 1][2][EROFS_MAX_BLOCK_SIZE];
+	unsigned long bktmap[META + 1][2][EROFS_MAX_BLOCK_SIZE / BITS_PER_LONG];
 
 	struct erofs_buffer_block blkh;
 	erofs_blk_t tail_blkaddr, metablkcnt;
diff --git a/lib/cache.c b/lib/cache.c
index 2e758ba..ca1061b 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -7,6 +7,7 @@
  */
 #include <stdlib.h>
 #include <erofs/cache.h>
+#include <erofs/bitops.h>
 #include "erofs/print.h"
 
 static int erofs_bh_flush_drop_directly(struct erofs_buffer_head *bh)
@@ -30,36 +31,72 @@ const struct erofs_bhops erofs_skip_write_bhops = {
 struct erofs_bufmgr *erofs_buffer_init(struct erofs_sb_info *sbi,
 				       erofs_blk_t startblk)
 {
-	struct erofs_bufmgr *bufmgr;
+	unsigned int blksiz = erofs_blksiz(sbi);
+	struct erofs_bufmgr *bmgr;
 	int i, j, k;
 
-	bufmgr = malloc(sizeof(struct erofs_bufmgr));
-	if (!bufmgr)
+	bmgr = malloc(sizeof(struct erofs_bufmgr));
+	if (!bmgr)
 		return NULL;
 
-	init_list_head(&bufmgr->blkh.list);
-	bufmgr->blkh.blkaddr = NULL_ADDR;
-	bufmgr->last_mapped_block = &bufmgr->blkh;
-
-	for (i = 0; i < ARRAY_SIZE(bufmgr->watermeter); i++)
-		for (j = 0; j < ARRAY_SIZE(bufmgr->watermeter[0]); j++)
-			for (k = 0; k < (1 << sbi->blkszbits); k++)
-				init_list_head(&bufmgr->watermeter[i][j][k]);
-	bufmgr->tail_blkaddr = startblk;
-	bufmgr->sbi = sbi;
-	return bufmgr;
+	bmgr->sbi = sbi;
+	for (i = 0; i < ARRAY_SIZE(bmgr->watermeter); i++) {
+		for (j = 0; j < ARRAY_SIZE(bmgr->watermeter[0]); j++) {
+			for (k = 0; k < blksiz; k++)
+				init_list_head(&bmgr->watermeter[i][j][k]);
+			memset(bmgr->bktmap[i][j], 0, blksiz / BITS_PER_LONG);
+		}
+	}
+	init_list_head(&bmgr->blkh.list);
+	bmgr->blkh.blkaddr = NULL_ADDR;
+	bmgr->tail_blkaddr = startblk;
+	bmgr->last_mapped_block = &bmgr->blkh;
+	return bmgr;
+}
+
+static void erofs_clear_bbktmap(struct erofs_bufmgr *bmgr, int type,
+				bool mapped, int nr)
+{
+	int bit = erofs_blksiz(bmgr->sbi) - (nr + 1);
+
+	DBG_BUGON(bit < 0);
+	__erofs_clear_bit(bit, bmgr->bktmap[type][mapped]);
 }
 
-static void erofs_update_bwatermeter(struct erofs_buffer_block *bb)
+static void erofs_set_bbktmap(struct erofs_bufmgr *bmgr, int type,
+			      bool mapped, int nr)
+{
+	int bit = erofs_blksiz(bmgr->sbi) - (nr + 1);
+
+	DBG_BUGON(bit < 0);
+	__erofs_set_bit(bit, bmgr->bktmap[type][mapped]);
+}
+
+static void erofs_update_bwatermeter(struct erofs_buffer_block *bb, bool free)
 {
 	struct erofs_bufmgr *bmgr = bb->buffers.fsprivate;
 	struct erofs_sb_info *sbi = bmgr->sbi;
-	struct list_head *bkt;
-
-	bkt = bmgr->watermeter[bb->type][bb->blkaddr != NULL_ADDR] +
-		(bb->buffers.off & (erofs_blksiz(sbi) - 1));
+	unsigned int blksiz = erofs_blksiz(sbi);
+	bool mapped = bb->blkaddr != NULL_ADDR;
+	struct list_head *h = bmgr->watermeter[bb->type][mapped];
+	unsigned int nr;
+
+	if (bb->sibling.next == bb->sibling.prev) {
+		if ((uintptr_t)(bb->sibling.next - h) < blksiz) {
+			nr = bb->sibling.next - h;
+			erofs_clear_bbktmap(bmgr, bb->type, mapped, nr);
+		} else if (bb->sibling.next != &bb->sibling) {
+			nr = bb->sibling.next -
+				bmgr->watermeter[bb->type][!mapped];
+			erofs_clear_bbktmap(bmgr, bb->type, !mapped, nr);
+		}
+	}
 	list_del(&bb->sibling);
-	list_add_tail(&bb->sibling, bkt);
+	if (free)
+		return;
+	nr = bb->buffers.off & (blksiz - 1);
+	list_add_tail(&bb->sibling, h + nr);
+	erofs_set_bbktmap(bmgr, bb->type, mapped, nr);
 }
 
 /* return occupied bytes in specific buffer block if succeed */
@@ -114,7 +151,7 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
 		/* need to update the tail_blkaddr */
 		if (tailupdate)
 			bmgr->tail_blkaddr = blkaddr + bb->buffers.nblocks;
-		erofs_update_bwatermeter(bb);
+		erofs_update_bwatermeter(bb, false);
 	}
 	return ((alignedoffset + incr + blkmask) & blkmask) + 1;
 }
@@ -130,6 +167,36 @@ int erofs_bh_balloon(struct erofs_buffer_head *bh, erofs_off_t incr)
 	return __erofs_battach(bb, NULL, incr, 1, 0, false);
 }
 
+static bool __find_next_bucket(struct erofs_bufmgr *bmgr, int type, bool mapped,
+			       unsigned int *index, unsigned int end)
+{
+	const unsigned int blksiz = erofs_blksiz(bmgr->sbi);
+	const unsigned int blkmask = blksiz - 1;
+	unsigned int l = *index, r;
+
+	if (l <= end) {
+		DBG_BUGON(l < end);
+		return false;
+	}
+
+	l = blkmask - (l & blkmask);
+	r = blkmask - (end & blkmask);
+	if (l >= r) {
+		l = erofs_find_next_bit(bmgr->bktmap[type][mapped], blksiz, l);
+		if (l < blksiz) {
+			*index = round_down(*index, blksiz) + blkmask - l;
+			return true;
+		}
+		l = 0;
+		*index -= blksiz;
+	}
+	l = erofs_find_next_bit(bmgr->bktmap[type][mapped], r, l);
+	if (l >= r)
+		return false;
+	*index = round_down(*index, blksiz) + blkmask - l;
+	return true;
+}
+
 static int erofs_bfind_for_attach(struct erofs_bufmgr *bmgr,
 				  int type, erofs_off_t size,
 				  unsigned int inline_ext,
@@ -163,13 +230,13 @@ static int erofs_bfind_for_attach(struct erofs_bufmgr *bmgr,
 
 	while (mapped) {
 		--mapped;
-		for (; index > end; --index) {
+		for (; __find_next_bucket(bmgr, type, mapped, &index, end);
+		     --index) {
 			struct list_head *bt;
 
 			used = index & blkmask;
 			bt = bmgr->watermeter[type][mapped] + used;
-			if (list_empty(bt))
-				continue;
+			DBG_BUGON(list_empty(bt));
 			cur = list_first_entry(bt, struct erofs_buffer_block,
 					       sibling);
 
@@ -332,7 +399,7 @@ static void __erofs_mapbh(struct erofs_buffer_block *bb)
 			}
 		}
 		bmgr->last_mapped_block = bb;
-		erofs_update_bwatermeter(bb);
+		erofs_update_bwatermeter(bb, false);
 	}
 
 	blkaddr = bb->blkaddr + bb->buffers.nblocks;
@@ -371,7 +438,7 @@ static void erofs_bfree(struct erofs_buffer_block *bb)
 	if (bb == bmgr->last_mapped_block)
 		bmgr->last_mapped_block = list_prev_entry(bb, list);
 
-	list_del(&bb->sibling);
+	erofs_update_bwatermeter(bb, true);
 	list_del(&bb->list);
 	free(bb);
 }
-- 
2.43.5

