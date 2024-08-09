Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA6794CF07
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Aug 2024 12:57:03 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=O8yMEwOA;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WgLT904ZLz2ynf
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Aug 2024 20:57:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=O8yMEwOA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WgLT13l87z2yYn
	for <linux-erofs@lists.ozlabs.org>; Fri,  9 Aug 2024 20:56:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723201005; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=4UOyli46tn80YPC76DMOAAtWopeRHhv7KPW9QLSGXtA=;
	b=O8yMEwOA2fYZaD+hBhJg47f1bv4Zjspan+BhrBWCwowkfEpHsP7y5GwfW+kVcvxhTdWB66HuDnTn1uEkJ1vsPyLBSlem2VHKAX4/S0T0bj8TikRQUJxQRUtT40uRanVZ4d/0vXLOJjSmuH6/upxeCoyo6P1yXrvmcKpXdGFqlzM=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WCPy9-x_1723200997)
          by smtp.aliyun-inc.com;
          Fri, 09 Aug 2024 18:56:43 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fix partial decompression for libdeflate
Date: Fri,  9 Aug 2024 18:56:36 +0800
Message-ID: <20240809105636.3641536-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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

Actually, libdeflate doesn't support partial decompression; therefore,
fix it by reallocating larger decompression buffers.

Although a better approach would be to obtain the exact decompressed
length instead for libdeflate decompressor, which requires more changes,
a quick fix is needed.

Fixes: 29b9e7140162 ("erofs-utils: fuse,fsck: add DEFLATE algorithm support")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/decompress.c | 42 +++++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/lib/decompress.c b/lib/decompress.c
index 1b44a18..3f553a8 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -247,32 +247,47 @@ static int z_erofs_decompress_deflate(struct z_erofs_decompress_req *rq)
 	unsigned int inputmargin;
 	struct libdeflate_decompressor *inf;
 	enum libdeflate_result ret;
+	unsigned int decodedcapacity;
 
 	inputmargin = z_erofs_fixup_insize(src, rq->inputsize);
 	if (inputmargin >= rq->inputsize)
 		return -EFSCORRUPTED;
 
-	if (rq->decodedskip) {
-		buff = malloc(rq->decodedlength);
+	decodedcapacity = rq->decodedlength << (4 * rq->partial_decoding);
+	if (rq->decodedskip || rq->partial_decoding) {
+		buff = malloc(decodedcapacity);
 		if (!buff)
 			return -ENOMEM;
 		dest = buff;
 	}
 
 	inf = libdeflate_alloc_decompressor();
-	if (!inf)
-		return -ENOMEM;
+	if (!inf) {
+		ret = -ENOMEM;
+		goto out_free_mem;
+	}
 
 	if (rq->partial_decoding) {
-		ret = libdeflate_deflate_decompress(inf, src + inputmargin,
-				rq->inputsize - inputmargin, dest,
-				rq->decodedlength, &actual_out);
-		if (ret && ret != LIBDEFLATE_INSUFFICIENT_SPACE) {
-			ret = -EIO;
-			goto out_inflate_end;
+		while (1) {
+			ret = libdeflate_deflate_decompress(inf, src + inputmargin,
+					rq->inputsize - inputmargin, dest,
+					decodedcapacity, &actual_out);
+			if (ret == LIBDEFLATE_SUCCESS)
+				break;
+			if (ret != LIBDEFLATE_INSUFFICIENT_SPACE) {
+				ret = -EIO;
+				goto out_inflate_end;
+			}
+			decodedcapacity = decodedcapacity << 1;
+			dest = realloc(buff, decodedcapacity);
+			if (!dest) {
+				ret = -ENOMEM;
+				goto out_inflate_end;
+			}
+			buff = dest;
 		}
 
-		if (actual_out != rq->decodedlength) {
+		if (actual_out < rq->decodedlength) {
 			ret = -EIO;
 			goto out_inflate_end;
 		}
@@ -280,18 +295,19 @@ static int z_erofs_decompress_deflate(struct z_erofs_decompress_req *rq)
 		ret = libdeflate_deflate_decompress(inf, src + inputmargin,
 				rq->inputsize - inputmargin, dest,
 				rq->decodedlength, NULL);
-		if (ret) {
+		if (ret != LIBDEFLATE_SUCCESS) {
 			ret = -EIO;
 			goto out_inflate_end;
 		}
 	}
 
-	if (rq->decodedskip)
+	if (rq->decodedskip || rq->partial_decoding)
 		memcpy(rq->out, dest + rq->decodedskip,
 		       rq->decodedlength - rq->decodedskip);
 
 out_inflate_end:
 	libdeflate_free_decompressor(inf);
+out_free_mem:
 	if (buff)
 		free(buff);
 	return ret;
-- 
2.43.5

