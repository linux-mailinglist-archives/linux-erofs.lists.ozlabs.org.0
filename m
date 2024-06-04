Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC9E8FADBF
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Jun 2024 10:40:47 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yVisXZac;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VtkZL0mKkz3cTZ
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Jun 2024 18:40:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yVisXZac;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VtkZ36zGcz30TC
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Jun 2024 18:40:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717490421; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=bz7Ls+IBMYdgieppkmRk5Ovuc1jhwTs6U81q4YwkgRw=;
	b=yVisXZacQpWSfse+3Ybzyb4VuuDJf/mBHUVOL8P7vhnYnn8euFiEm6LV7h9KQjJWNSikrMIKMD890CVHIsHJV0Vh5piNG8W1ymaG7+RLSJk8DCV1tV6JWfl+SZIJgreCNingHVEKJBKeb7jGt9U8/A8CmZTl9r5RQlgbJRH3mf4=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W7qIgzu_1717490416;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W7qIgzu_1717490416)
          by smtp.aliyun-inc.com;
          Tue, 04 Jun 2024 16:40:20 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs-utils: lib: wrap up zeropadding calculation
Date: Tue,  4 Jun 2024 16:40:14 +0800
Message-Id: <20240604084015.2291157-1-hsiangkao@linux.alibaba.com>
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

Use a simple helper instead of open-coding.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/decompress.c | 46 ++++++++++++++++++----------------------------
 1 file changed, 18 insertions(+), 28 deletions(-)

diff --git a/lib/decompress.c b/lib/decompress.c
index 58ce7e5..e65b924 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -9,6 +9,15 @@
 #include "erofs/err.h"
 #include "erofs/print.h"
 
+static unsigned int z_erofs_fixup_insize(const u8 *padbuf, unsigned int padbufsize)
+{
+	unsigned int inputmargin;
+
+	for (inputmargin = 0; inputmargin < padbufsize &&
+	     !padbuf[inputmargin]; ++inputmargin);
+	return inputmargin;
+}
+
 #ifdef HAVE_LIBZSTD
 #include <zstd.h>
 #include <zstd_errors.h>
@@ -16,7 +25,6 @@
 /* also a very preliminary userspace version */
 static int z_erofs_decompress_zstd(struct z_erofs_decompress_req *rq)
 {
-	struct erofs_sb_info *sbi = rq->sbi;
 	int ret = 0;
 	char *dest = rq->out;
 	char *src = rq->in;
@@ -24,10 +32,7 @@ static int z_erofs_decompress_zstd(struct z_erofs_decompress_req *rq)
 	unsigned int inputmargin = 0;
 	unsigned long long total;
 
-	while (!src[inputmargin & (erofs_blksiz(sbi) - 1)])
-		if (!(++inputmargin & (erofs_blksiz(sbi) - 1)))
-			break;
-
+	inputmargin = z_erofs_fixup_insize((u8 *)src, rq->inputsize);
 	if (inputmargin >= rq->inputsize)
 		return -EFSCORRUPTED;
 
@@ -78,19 +83,15 @@ out:
 
 static int z_erofs_decompress_deflate(struct z_erofs_decompress_req *rq)
 {
-	struct erofs_sb_info *sbi = rq->sbi;
 	u8 *dest = (u8 *)rq->out;
 	u8 *src = (u8 *)rq->in;
 	u8 *buff = NULL;
 	size_t actual_out;
-	unsigned int inputmargin = 0;
+	unsigned int inputmargin;
 	struct libdeflate_decompressor *inf;
 	enum libdeflate_result ret;
 
-	while (!src[inputmargin & (erofs_blksiz(sbi) - 1)])
-		if (!(++inputmargin & (erofs_blksiz(sbi) - 1)))
-			break;
-
+	inputmargin = z_erofs_fixup_insize(src, rq->inputsize);
 	if (inputmargin >= rq->inputsize)
 		return -EFSCORRUPTED;
 
@@ -160,18 +161,14 @@ static int zerr(int ret)
 
 static int z_erofs_decompress_deflate(struct z_erofs_decompress_req *rq)
 {
-	struct erofs_sb_info *sbi = rq->sbi;
 	u8 *dest = (u8 *)rq->out;
 	u8 *src = (u8 *)rq->in;
 	u8 *buff = NULL;
-	unsigned int inputmargin = 0;
+	unsigned int inputmargin;
 	z_stream strm;
 	int ret;
 
-	while (!src[inputmargin & (erofs_blksiz(sbi) - 1)])
-		if (!(++inputmargin & (erofs_blksiz(sbi) - 1)))
-			break;
-
+	inputmargin = z_erofs_fixup_insize(src, rq->inputsize);
 	if (inputmargin >= rq->inputsize)
 		return -EFSCORRUPTED;
 
@@ -225,18 +222,14 @@ out_inflate_end:
 static int z_erofs_decompress_lzma(struct z_erofs_decompress_req *rq)
 {
 	int ret = 0;
-	struct erofs_sb_info *sbi = rq->sbi;
 	u8 *dest = (u8 *)rq->out;
 	u8 *src = (u8 *)rq->in;
 	u8 *buff = NULL;
-	unsigned int inputmargin = 0;
+	unsigned int inputmargin;
 	lzma_stream strm;
 	lzma_ret ret2;
 
-	while (!src[inputmargin & (erofs_blksiz(sbi) - 1)])
-		if (!(++inputmargin & (erofs_blksiz(sbi) - 1)))
-			break;
-
+	inputmargin = z_erofs_fixup_insize(src, rq->inputsize);
 	if (inputmargin >= rq->inputsize)
 		return -EFSCORRUPTED;
 
@@ -297,12 +290,9 @@ static int z_erofs_decompress_lz4(struct z_erofs_decompress_req *rq)
 	if (erofs_sb_has_lz4_0padding(sbi)) {
 		support_0padding = true;
 
-		while (!src[inputmargin & (erofs_blksiz(sbi) - 1)])
-			if (!(++inputmargin & (erofs_blksiz(sbi) - 1)))
-				break;
-
+		inputmargin = z_erofs_fixup_insize((u8 *)src, rq->inputsize);
 		if (inputmargin >= rq->inputsize)
-			return -EIO;
+			return -EFSCORRUPTED;
 	}
 
 	if (rq->decodedskip) {
-- 
2.39.3

