Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BD5480F88
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Dec 2021 05:14:50 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JNyjM6WnVz3036
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Dec 2021 15:14:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132;
 helo=out30-132.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JNyjF4qPvz2ybD
 for <linux-erofs@lists.ozlabs.org>; Wed, 29 Dec 2021 15:14:40 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R911e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0V0Bi34J_1640751246; 
Received: from
 e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V0Bi34J_1640751246) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 29 Dec 2021 12:14:18 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
 Liu Bo <bo.liu@linux.alibaba.com>
Subject: [PATCH 3/5] erofs: use meta buffers for super operations
Date: Wed, 29 Dec 2021 12:14:03 +0800
Message-Id: <20211229041405.45921-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20211229041405.45921-1-hsiangkao@linux.alibaba.com>
References: <20211229041405.45921-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Get rid of old erofs_get_meta_page() within super operations by
using on-stack meta buffers in order to prepare subpage and folio
features.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/super.c | 105 ++++++++++++-----------------------------------
 1 file changed, 26 insertions(+), 79 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 0724ad5fd6cf..38305fa2969b 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2017-2018 HUAWEI, Inc.
  *             https://www.huawei.com/
+ * Copyright (C) 2021, Alibaba Cloud
  */
 #include <linux/module.h>
 #include <linux/buffer_head.h>
@@ -124,80 +125,48 @@ static bool check_layout_compatibility(struct super_block *sb,
 
 #ifdef CONFIG_EROFS_FS_ZIP
 /* read variable-sized metadata, offset will be aligned by 4-byte */
-static void *erofs_read_metadata(struct super_block *sb, struct page **pagep,
+static void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
 				 erofs_off_t *offset, int *lengthp)
 {
-	struct page *page = *pagep;
 	u8 *buffer, *ptr;
 	int len, i, cnt;
-	erofs_blk_t blk;
 
 	*offset = round_up(*offset, 4);
-	blk = erofs_blknr(*offset);
+	ptr = erofs_read_metabuf(buf, sb, erofs_blknr(*offset), EROFS_KMAP);
+	if (IS_ERR(ptr))
+		return ptr;
 
-	if (!page || page->index != blk) {
-		if (page) {
-			unlock_page(page);
-			put_page(page);
-		}
-		page = erofs_get_meta_page(sb, blk);
-		if (IS_ERR(page))
-			goto err_nullpage;
-	}
-
-	ptr = kmap(page);
 	len = le16_to_cpu(*(__le16 *)&ptr[erofs_blkoff(*offset)]);
 	if (!len)
 		len = U16_MAX + 1;
 	buffer = kmalloc(len, GFP_KERNEL);
-	if (!buffer) {
-		buffer = ERR_PTR(-ENOMEM);
-		goto out;
-	}
+	if (!buffer)
+		return ERR_PTR(-ENOMEM);
 	*offset += sizeof(__le16);
 	*lengthp = len;
 
 	for (i = 0; i < len; i += cnt) {
 		cnt = min(EROFS_BLKSIZ - (int)erofs_blkoff(*offset), len - i);
-		blk = erofs_blknr(*offset);
-
-		if (!page || page->index != blk) {
-			if (page) {
-				kunmap(page);
-				unlock_page(page);
-				put_page(page);
-			}
-			page = erofs_get_meta_page(sb, blk);
-			if (IS_ERR(page)) {
-				kfree(buffer);
-				goto err_nullpage;
-			}
-			ptr = kmap(page);
-		}
+		ptr = erofs_read_metabuf(buf, sb, erofs_blknr(*offset),
+					 EROFS_KMAP);
+		if (IS_ERR(ptr))
+			return ptr;
 		memcpy(buffer + i, ptr + erofs_blkoff(*offset), cnt);
 		*offset += cnt;
 	}
-out:
-	kunmap(page);
-	*pagep = page;
 	return buffer;
-err_nullpage:
-	*pagep = NULL;
-	return page;
 }
 
 static int erofs_load_compr_cfgs(struct super_block *sb,
 				 struct erofs_super_block *dsb)
 {
-	struct erofs_sb_info *sbi;
-	struct page *page;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 	unsigned int algs, alg;
 	erofs_off_t offset;
-	int size, ret;
+	int size, ret = 0;
 
-	sbi = EROFS_SB(sb);
 	sbi->available_compr_algs = le16_to_cpu(dsb->u1.available_compr_algs);
-
 	if (sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS) {
 		erofs_err(sb, "try to load compressed fs with unsupported algorithms %x",
 			  sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS);
@@ -205,21 +174,16 @@ static int erofs_load_compr_cfgs(struct super_block *sb,
 	}
 
 	offset = EROFS_SUPER_OFFSET + sbi->sb_size;
-	page = NULL;
 	alg = 0;
-	ret = 0;
-
 	for (algs = sbi->available_compr_algs; algs; algs >>= 1, ++alg) {
 		void *data;
 
 		if (!(algs & 1))
 			continue;
 
-		data = erofs_read_metadata(sb, &page, &offset, &size);
-		if (IS_ERR(data)) {
-			ret = PTR_ERR(data);
-			goto err;
-		}
+		data = erofs_read_metadata(sb, &buf, &offset, &size);
+		if (IS_ERR(data))
+			return PTR_ERR(data);
 
 		switch (alg) {
 		case Z_EROFS_COMPRESSION_LZ4:
@@ -234,13 +198,9 @@ static int erofs_load_compr_cfgs(struct super_block *sb,
 		}
 		kfree(data);
 		if (ret)
-			goto err;
-	}
-err:
-	if (page) {
-		unlock_page(page);
-		put_page(page);
+			break;
 	}
+	erofs_put_metabuf(&buf);
 	return ret;
 }
 #else
@@ -261,7 +221,7 @@ static int erofs_init_devices(struct super_block *sb,
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	unsigned int ondisk_extradevs;
 	erofs_off_t pos;
-	struct page *page = NULL;
+	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 	struct erofs_device_info *dif;
 	struct erofs_deviceslot *dis;
 	void *ptr;
@@ -285,22 +245,13 @@ static int erofs_init_devices(struct super_block *sb,
 	pos = le16_to_cpu(dsb->devt_slotoff) * EROFS_DEVT_SLOT_SIZE;
 	down_read(&sbi->devs->rwsem);
 	idr_for_each_entry(&sbi->devs->tree, dif, id) {
-		erofs_blk_t blk = erofs_blknr(pos);
 		struct block_device *bdev;
 
-		if (!page || page->index != blk) {
-			if (page) {
-				kunmap(page);
-				unlock_page(page);
-				put_page(page);
-			}
-
-			page = erofs_get_meta_page(sb, blk);
-			if (IS_ERR(page)) {
-				up_read(&sbi->devs->rwsem);
-				return PTR_ERR(page);
-			}
-			ptr = kmap(page);
+		ptr = erofs_read_metabuf(&buf, sb, erofs_blknr(pos),
+					 EROFS_KMAP);
+		if (IS_ERR(ptr)) {
+			up_read(&sbi->devs->rwsem);
+			return PTR_ERR(ptr);
 		}
 		dis = ptr + erofs_blkoff(pos);
 
@@ -320,11 +271,7 @@ static int erofs_init_devices(struct super_block *sb,
 	}
 err_out:
 	up_read(&sbi->devs->rwsem);
-	if (page) {
-		kunmap(page);
-		unlock_page(page);
-		put_page(page);
-	}
+	erofs_put_metabuf(&buf);
 	return err;
 }
 
-- 
2.24.4

