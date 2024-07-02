Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C43C923CFC
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Jul 2024 13:57:03 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Fdp+xU+E;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WD1bx0vqCz3fyp
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Jul 2024 21:57:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Fdp+xU+E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WD1br1NXgz3fwH
	for <linux-erofs@lists.ozlabs.org>; Tue,  2 Jul 2024 21:56:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719921410; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=5m+kzy6Q7l5m0lvdK/gK+0RfvVzM+fWLGsrTElNWf7U=;
	b=Fdp+xU+EQUwWtUWTYlxTcVbTQ2O2+M3mLVKPHJcd70ZbL8Yu5XWmP6ECHgPfnyz4j0Hi8kVbKa+gYQnmVopg7mS5GG6ZJuPDYc5qwP3cDChsCljtgGvTtUHVKmvd+OtunGKsxsG09JE6C/KcFwl/Y9jbkF6f6tO5VLA9sy2OjXY=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W9ihfgU_1719921408;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0W9ihfgU_1719921408)
          by smtp.aliyun-inc.com;
          Tue, 02 Jul 2024 19:56:49 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: lib: chagne function definition of erofs_blocklist_open()
Date: Tue,  2 Jul 2024 19:56:47 +0800
Message-Id: <20240702115647.2457003-1-hongzhen@linux.alibaba.com>
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

Modified the definition of the function `erofs_blocklist_open` to accept
a file pointer rather than a string, for external use in liberofs.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 include/erofs/block_list.h |  2 +-
 lib/block_list.c           |  9 ++++-----
 mkfs/main.c                | 21 ++++++++++++++-------
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/include/erofs/block_list.h b/include/erofs/block_list.h
index 9f9975e..00da82c 100644
--- a/include/erofs/block_list.h
+++ b/include/erofs/block_list.h
@@ -13,7 +13,7 @@ extern "C"
 
 #include "internal.h"
 
-int erofs_blocklist_open(char *filename, bool srcmap);
+int erofs_blocklist_open(FILE *fp, bool srcmap);
 void erofs_blocklist_close(void);
 
 void tarerofs_blocklist_write(erofs_blk_t blkaddr, erofs_blk_t nblocks,
diff --git a/lib/block_list.c b/lib/block_list.c
index f47a746..d11e2cd 100644
--- a/lib/block_list.c
+++ b/lib/block_list.c
@@ -13,12 +13,11 @@
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
diff --git a/mkfs/main.c b/mkfs/main.c
index 63ed877..79780d7 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1133,6 +1133,10 @@ int main(int argc, char **argv)
 	erofs_blk_t nblocks;
 	struct timeval t;
 	FILE *packedfile = NULL;
+	FILE  *mp_fp;
+#ifdef WITH_ANDROID	
+	FILE  *cfg_fp;
+#endif
 	u32 crc;
 
 	erofs_init_configure();
@@ -1173,11 +1177,13 @@ int main(int argc, char **argv)
 		erofs_err("failed to load fs config %s", cfg.fs_config_file);
 		return 1;
 	}
-
-	if (cfg.block_list_file &&
-	    erofs_blocklist_open(cfg.block_list_file, false)) {
-		erofs_err("failed to open %s", cfg.block_list_file);
-		return 1;
+	
+	if (cfg.block_list_file) {
+		cfg_fp = fopen(cfg.block_list_file, "w");
+		if (!cfg_fp || erofs_blocklist_open(cfg_fp, false)) {
+			erofs_err("failed to open %s", cfg.block_list_file);
+			return 1;
+		}
 	}
 #endif
 	erofs_show_config();
@@ -1210,8 +1216,9 @@ int main(int argc, char **argv)
 		erofstar.dev = rebuild_src_count + 1;
 
 		if (erofstar.mapfile) {
-			err = erofs_blocklist_open(erofstar.mapfile, true);
-			if (err) {
+			mp_fp = fopen(erofstar.mapfile, "w");
+			if (!mp_fp || erofs_blocklist_open(mp_fp, true)) {
+				err = -errno;
 				erofs_err("failed to open %s", erofstar.mapfile);
 				goto exit;
 			}
-- 
2.39.3

