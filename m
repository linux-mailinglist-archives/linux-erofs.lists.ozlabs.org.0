Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8086B3A00
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Mar 2023 10:16:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PY0m51ncFz3chV
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Mar 2023 20:16:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PY0lw655kz3cB9
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Mar 2023 20:16:11 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VdWq.JV_1678439762;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VdWq.JV_1678439762)
          by smtp.aliyun-inc.com;
          Fri, 10 Mar 2023 17:16:06 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs-utils: fix liblzma extreme compression levels
Date: Fri, 10 Mar 2023 17:16:00 +0800
Message-Id: <20230310091601.97930-1-hsiangkao@linux.alibaba.com>
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

100 ~ 109 are now valid for LZMA extreme compression.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compressor_liblzma.c | 11 ++++++++---
 man/mkfs.erofs.1         |  3 ++-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/lib/compressor_liblzma.c b/lib/compressor_liblzma.c
index 4886d6a..f274dce 100644
--- a/lib/compressor_liblzma.c
+++ b/lib/compressor_liblzma.c
@@ -56,11 +56,16 @@ static int erofs_compressor_liblzma_setlevel(struct erofs_compress *c,
 					     int compression_level)
 {
 	struct erofs_liblzma_context *ctx = c->private_data;
+	u32 preset;
 
 	if (compression_level < 0)
-		compression_level = LZMA_PRESET_DEFAULT;
+		preset = LZMA_PRESET_DEFAULT;
+	else if (compression_level >= 100)
+		preset = (compression_level - 100) | LZMA_PRESET_EXTREME;
+	else
+		preset = compression_level;
 
-	if (lzma_lzma_preset(&ctx->opt, compression_level))
+	if (lzma_lzma_preset(&ctx->opt, preset))
 		return -EINVAL;
 
 	/* XXX: temporary hack */
@@ -97,7 +102,7 @@ static int erofs_compressor_liblzma_init(struct erofs_compress *c)
 const struct erofs_compressor erofs_compressor_lzma = {
 	.name = "lzma",
 	.default_level = LZMA_PRESET_DEFAULT,
-	.best_level = LZMA_PRESET_EXTREME,
+	.best_level = 109,
 	.init = erofs_compressor_liblzma_init,
 	.exit = erofs_compressor_liblzma_exit,
 	.setlevel = erofs_compressor_liblzma_setlevel,
diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index c1ad47d..e237877 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -22,7 +22,8 @@ from \fISOURCE\fR directory.
 .TP
 .BI "\-z " compression-algorithm " [" ",#" "]"
 Set an algorithm for file compression, which can be set with an optional
-compression level separated by a comma.
+compression level (1 to 12 for LZ4HC, 0 to 9 for LZMA and 100 to 109 for LZMA
+extreme compression) separated by a comma.
 .TP
 .BI "\-C " max-pcluster-size
 Specify the maximum size of compress physical cluster in bytes. It may enable
-- 
2.24.4

