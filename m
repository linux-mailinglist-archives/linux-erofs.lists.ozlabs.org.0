Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5906F905865
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Jun 2024 18:18:50 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YtuXoxiO;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VzrMC2FV1z3dWr
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jun 2024 02:18:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YtuXoxiO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VzrM64dm1z3dH4
	for <linux-erofs@lists.ozlabs.org>; Thu, 13 Jun 2024 02:18:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718209117; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=kG7H1KCxNJMcbhqxcEnRGNQOHc6h6LkD+wEhd8pMyUc=;
	b=YtuXoxiOH6QyYYC/E5KP2aZsavK5QW8K7od9GAWUYZ5RzP7W6ts1GXw1N5CviwCJUz60szoMzdn9ED1POox1xsAp+E53RTNpBQTgNkJ3L62V0IUfW1GMYc1cljM4fJeUbetDS9wX9JRCt4cs/hEPdJYiXLV0YY87f+w5dNb9aZI=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W8LOtTz_1718209114;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W8LOtTz_1718209114)
          by smtp.aliyun-inc.com;
          Thu, 13 Jun 2024 00:18:36 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 3/5] erofs-utils: wrap up superblock reservation for incremental builds
Date: Thu, 13 Jun 2024 00:18:24 +0800
Message-Id: <20240612161826.711279-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240612161826.711279-1-hsiangkao@linux.alibaba.com>
References: <20240612161826.711279-1-hsiangkao@linux.alibaba.com>
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

Refactor `erofs_buffer_init()` to wrap up necessary operations for full
builds.

Introduce another `erofs_buffer_init()` to specify start block address
for the upcoming incremental builds.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/cache.h    |  2 +-
 include/erofs/internal.h |  1 +
 lib/cache.c              | 11 ++---------
 lib/super.c              | 31 +++++++++++++++++++++++++++++++
 mkfs/main.c              | 17 +----------------
 5 files changed, 36 insertions(+), 26 deletions(-)

diff --git a/include/erofs/cache.h b/include/erofs/cache.h
index 350cec6..f30fe9f 100644
--- a/include/erofs/cache.h
+++ b/include/erofs/cache.h
@@ -98,7 +98,7 @@ static inline int erofs_bh_flush_generic_end(struct erofs_buffer_head *bh)
 	return 0;
 }
 
-struct erofs_buffer_head *erofs_buffer_init(void);
+void erofs_buffer_init(erofs_blk_t startblk);
 int erofs_bh_balloon(struct erofs_buffer_head *bh, erofs_off_t incr);
 
 struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 277295e..f8a01ce 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -397,6 +397,7 @@ int erofs_read_superblock(struct erofs_sb_info *sbi);
 void erofs_put_super(struct erofs_sb_info *sbi);
 int erofs_writesb(struct erofs_sb_info *sbi, struct erofs_buffer_head *sb_bh,
 		  erofs_blk_t *blocks);
+struct erofs_buffer_head *erofs_reserve_sb(void);
 
 /* namei.c */
 int erofs_read_inode_from_disk(struct erofs_inode *vi);
diff --git a/lib/cache.c b/lib/cache.c
index 664e598..328ca4a 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -38,21 +38,14 @@ const struct erofs_bhops erofs_skip_write_bhops = {
 	.flush = erofs_bh_flush_skip_write,
 };
 
-/* return buffer_head of erofs super block (with size 0) */
-struct erofs_buffer_head *erofs_buffer_init(void)
+void erofs_buffer_init(erofs_blk_t startblk)
 {
 	int i, j;
-	struct erofs_buffer_head *bh = erofs_balloc(META, 0, 0, 0);
-
-	if (IS_ERR(bh))
-		return bh;
-
-	bh->op = &erofs_skip_write_bhops;
 
 	for (i = 0; i < ARRAY_SIZE(mapped_buckets); i++)
 		for (j = 0; j < ARRAY_SIZE(mapped_buckets[0]); j++)
 			init_list_head(&mapped_buckets[i][j]);
-	return bh;
+	tail_blkaddr = startblk;
 }
 
 static void erofs_bupdate_mapped(struct erofs_buffer_block *bb)
diff --git a/lib/super.c b/lib/super.c
index 33e908a..c8c33b6 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -201,3 +201,34 @@ int erofs_writesb(struct erofs_sb_info *sbi, struct erofs_buffer_head *sb_bh,
 		erofs_bdrop(sb_bh, false);
 	return ret;
 }
+
+struct erofs_buffer_head *erofs_reserve_sb(void)
+{
+	struct erofs_buffer_head *bh;
+	int err;
+
+	erofs_buffer_init(0);
+	bh = erofs_balloc(META, 0, 0, 0);
+	if (IS_ERR(bh)) {
+		erofs_err("failed to allocate super: %s", PTR_ERR(bh));
+		return bh;
+	}
+	bh->op = &erofs_skip_write_bhops;
+	err = erofs_bh_balloon(bh, EROFS_SUPER_END);
+	if (err < 0) {
+		erofs_err("failed to balloon super: %s", erofs_strerror(err));
+		goto err_bdrop;
+	}
+
+	/* make sure that the super block should be the very first blocks */
+	(void)erofs_mapbh(bh->block);
+	if (erofs_btell(bh, false) != 0) {
+		erofs_err("failed to pin super block @ 0");
+		err = -EFAULT;
+		goto err_bdrop;
+	}
+	return bh;
+err_bdrop:
+	erofs_bdrop(bh, true);
+	return ERR_PTR(err);
+}
diff --git a/mkfs/main.c b/mkfs/main.c
index 6577267..1e8ca3c 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1244,24 +1244,9 @@ int main(int argc, char **argv)
 		sbi.blkszbits = src->blkszbits;
 	}
 
-	sb_bh = erofs_buffer_init();
+	sb_bh = erofs_reserve_sb();
 	if (IS_ERR(sb_bh)) {
 		err = PTR_ERR(sb_bh);
-		erofs_err("failed to initialize buffers: %s",
-			  erofs_strerror(err));
-		goto exit;
-	}
-	err = erofs_bh_balloon(sb_bh, EROFS_SUPER_END);
-	if (err < 0) {
-		erofs_err("failed to balloon erofs_super_block: %s",
-			  erofs_strerror(err));
-		goto exit;
-	}
-
-	/* make sure that the super block should be the very first blocks */
-	(void)erofs_mapbh(sb_bh->block);
-	if (erofs_btell(sb_bh, false) != 0) {
-		erofs_err("failed to reserve erofs_super_block");
 		goto exit;
 	}
 
-- 
2.39.3

