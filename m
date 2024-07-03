Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB4E924E43
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jul 2024 05:03:44 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mtzgV6tX;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WDPk63xhpz3cXG
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jul 2024 13:03:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mtzgV6tX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WDPjz3m6Gz30VS
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Jul 2024 13:03:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719975809; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=T4tYeHORwrXpXNOiXeLxOfFlgKmEDeXFn3ANmGjLvQ4=;
	b=mtzgV6tXOSK53DE0vkOJ28wUTEfA6P6/SEGLq/psJFMbOqNAUt+QqF7lTJQi0HJ0Yr5jq6atdyNLsN9fdnIOSGkO9BqZQ2+s0y2pRFOyn2C2SU97pw8Irswrl/6IO7eyAejalMjoZrUSScA7NdWeGwwV0qvJu6xzfKrKMWcWWsk=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W9kVDX1_1719975808;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0W9kVDX1_1719975808)
          by smtp.aliyun-inc.com;
          Wed, 03 Jul 2024 11:03:29 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3] erofs-utils: lib: change function definition of erofs_blocklist_open()
Date: Wed,  3 Jul 2024 11:03:27 +0800
Message-Id: <20240703030327.3280503-1-hongzhen@linux.alibaba.com>
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
Cc: Hongzhen Luo <hongzhen@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Modify erofs_blocklist_open to accept a file pointer instead of a
file path, making it suitable for external use in liberofs.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
v3: Changes since v2: Correct spelling errors and add null checks for erofs_blocklist_close.
v2: https://lore.kernel.org/all/20240702121445.2475200-1-hongzhen@linux.alibaba.com/
v1: https://lore.kernel.org/all/20240702115647.2457003-1-hongzhen@linux.alibaba.com/
---
 include/erofs/block_list.h |  4 ++--
 lib/block_list.c           | 17 +++++++----------
 mkfs/main.c                | 20 +++++++++++++-------
 3 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/include/erofs/block_list.h b/include/erofs/block_list.h
index 9f9975e..7db4d0c 100644
--- a/include/erofs/block_list.h
+++ b/include/erofs/block_list.h
@@ -13,8 +13,8 @@ extern "C"
 
 #include "internal.h"
 
-int erofs_blocklist_open(char *filename, bool srcmap);
-void erofs_blocklist_close(void);
+int erofs_blocklist_open(FILE *fp, bool srcmap);
+FILE *erofs_blocklist_close(void);
 
 void tarerofs_blocklist_write(erofs_blk_t blkaddr, erofs_blk_t nblocks,
 			      erofs_off_t srcoff);
diff --git a/lib/block_list.c b/lib/block_list.c
index f47a746..10c7c6a 100644
--- a/lib/block_list.c
+++ b/lib/block_list.c
@@ -13,23 +13,20 @@
 static FILE *block_list_fp;
 bool srcmap_enabled;
 
-int erofs_blocklist_open(char *filename, bool srcmap)
+int erofs_blocklist_open(FILE *fp, bool srcmap)
 {
-	block_list_fp = fopen(filename, "w");
-
-	if (!block_list_fp)
-		return -errno;
+	if (!fp)
+		return -ENOENT;
+	block_list_fp = fp;
 	srcmap_enabled = srcmap;
 	return 0;
 }
 
-void erofs_blocklist_close(void)
+FILE *erofs_blocklist_close(void)
 {
-	if (!block_list_fp)
-		return;
-
-	fclose(block_list_fp);
+	FILE *ret = block_list_fp;
 	block_list_fp = NULL;
+	return ret;
 }
 
 /* XXX: really need to be cleaned up */
diff --git a/mkfs/main.c b/mkfs/main.c
index 321b8ac..bfd6d60 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1133,6 +1133,7 @@ int main(int argc, char **argv)
 	erofs_blk_t nblocks;
 	struct timeval t;
 	FILE *packedfile = NULL;
+	FILE *blklst = NULL;
 	u32 crc;
 
 	erofs_init_configure();
@@ -1174,10 +1175,12 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
-	if (cfg.block_list_file &&
-	    erofs_blocklist_open(cfg.block_list_file, false)) {
-		erofs_err("failed to open %s", cfg.block_list_file);
-		return 1;
+	if (cfg.block_list_file) {
+		blklst = fopen(cfg.block_list_file, "w");
+		if (!blklst || erofs_blocklist_open(blklst, false)) {
+			erofs_err("failed to open %s", cfg.block_list_file);
+			return 1;
+		}
 	}
 #endif
 	erofs_show_config();
@@ -1210,8 +1213,9 @@ int main(int argc, char **argv)
 		erofstar.dev = rebuild_src_count + 1;
 
 		if (erofstar.mapfile) {
-			err = erofs_blocklist_open(erofstar.mapfile, true);
-			if (err) {
+			blklst = fopen(erofstar.mapfile, "w");
+			if (!blklst || erofs_blocklist_open(blklst, true)) {
+				err = -errno;
 				erofs_err("failed to open %s", erofstar.mapfile);
 				goto exit;
 			}
@@ -1417,7 +1421,9 @@ exit:
 		erofs_iput(root);
 	z_erofs_compress_exit();
 	z_erofs_dedupe_exit();
-	erofs_blocklist_close();
+	blklst = erofs_blocklist_close();
+	if (blklst)
+		fclose(blklst);
 	erofs_dev_close(&sbi);
 	erofs_cleanup_compress_hints();
 	erofs_cleanup_exclude_rules();
-- 
2.39.3

