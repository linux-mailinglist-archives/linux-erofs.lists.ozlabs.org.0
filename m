Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2268C6005A9
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Oct 2022 05:18:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MrMd56l5Cz3blY
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Oct 2022 14:18:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57; helo=out30-57.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MrMcz4wDWz2xWx
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Oct 2022 14:17:54 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VSGPZcA_1665976659;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VSGPZcA_1665976659)
          by smtp.aliyun-inc.com;
          Mon, 17 Oct 2022 11:17:48 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: use chunk-based data deduplication if compression is off
Date: Mon, 17 Oct 2022 11:17:36 +0800
Message-Id: <20221017031736.90542-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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

After this patch, "-E dedupe" can now support chunk-based data
deduplication with block-sized chunks if compression is off.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 mkfs/main.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 00a2deb..77d635c 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -663,12 +663,6 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
-	if (cfg.c_chunkbits) {
-		err = erofs_blob_init(cfg.c_blobdev_path);
-		if (err)
-			return 1;
-	}
-
 	err = lstat64(cfg.c_src_path, &st);
 	if (err)
 		return 1;
@@ -747,15 +741,6 @@ int main(int argc, char **argv)
 		goto exit;
 	}
 
-	if (cfg.c_dedupe) {
-		err = z_erofs_dedupe_init(EROFS_BLKSIZ);
-		if (err) {
-			erofs_err("failed to initialize deduplication: %s",
-				  erofs_strerror(err));
-			goto exit;
-		}
-	}
-
 	err = z_erofs_compress_init(sb_bh);
 	if (err) {
 		erofs_err("failed to initialize compressor: %s",
@@ -763,6 +748,26 @@ int main(int argc, char **argv)
 		goto exit;
 	}
 
+	if (cfg.c_dedupe) {
+		if (!cfg.c_compr_alg_master) {
+			erofs_err("Compression is not enabled.  Turn on chunk-based data deduplication instead.");
+			cfg.c_chunkbits = LOG_BLOCK_SIZE;
+		} else {
+			err = z_erofs_dedupe_init(EROFS_BLKSIZ);
+			if (err) {
+				erofs_err("failed to initialize deduplication: %s",
+					  erofs_strerror(err));
+				goto exit;
+			}
+		}
+	}
+
+	if (cfg.c_chunkbits) {
+		err = erofs_blob_init(cfg.c_blobdev_path);
+		if (err)
+			return 1;
+	}
+
 	err = erofs_generate_devtable();
 	if (err) {
 		erofs_err("failed to generate device table: %s",
-- 
2.24.4

