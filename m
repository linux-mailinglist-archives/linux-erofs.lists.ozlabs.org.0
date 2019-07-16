Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0027B6A29D
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2019 09:05:22 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45nry80CKKzDqX1
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2019 17:05:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.191; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45nrxY2VnpzDqWw
 for <linux-erofs@lists.ozlabs.org>; Tue, 16 Jul 2019 17:04:49 +1000 (AEST)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 8068BF0087C712272E8E;
 Tue, 16 Jul 2019 15:04:45 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 16 Jul
 2019 15:04:36 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Li Guifu <bluce.liguifu@huawei.com>, Fang Wei <fangwei1@huawei.com>
Subject: [PATCH v2 11/17] erofs-utils: propagate compressed size to its callers
Date: Tue, 16 Jul 2019 15:04:13 +0800
Message-ID: <20190716070419.30203-12-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190716070419.30203-1-gaoxiang25@huawei.com>
References: <20190716070419.30203-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
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
Cc: Miao Xie <miaoxie@huawei.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

It will be later used for marking whether it can
decompress in-place.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 lib/compress.c         | 2 +-
 lib/compressor.c       | 4 ++--
 lib/compressor_lz4.c   | 2 +-
 lib/compressor_lz4hc.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 4c9d8f1..b378ba4 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -131,7 +131,7 @@ static int vle_compress_one(struct erofs_inode *inode,
 		ret = erofs_compress_destsize(h, compressionlevel,
 					      ctx->queue + ctx->head,
 					      &count, dst, EROFS_BLKSIZ);
-		if (ret) {
+		if (ret <= 0) {
 			if (ret != -EAGAIN) {
 				erofs_err("failed to compress %s: %s",
 					  inode->i_srcpath,
diff --git a/lib/compressor.c b/lib/compressor.c
index a6138c6..570db14 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -26,13 +26,13 @@ int erofs_compress_destsize(struct erofs_compress *c,
 
 	ret = c->alg->compress_destsize(c, compression_level,
 					src, srcsize, dst, dstsize);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	/* check if there is enough gains to compress */
 	if (*srcsize <= dstsize * c->compress_threshold / 100)
 		return -EAGAIN;
-	return 0;
+	return ret;
 }
 
 int erofs_compressor_init(struct erofs_compress *c,
diff --git a/lib/compressor_lz4.c b/lib/compressor_lz4.c
index eacd21c..0d33223 100644
--- a/lib/compressor_lz4.c
+++ b/lib/compressor_lz4.c
@@ -21,7 +21,7 @@ static int lz4_compress_destsize(struct erofs_compress *c,
 	if (!rc)
 		return -EFAULT;
 	*srcsize = srcSize;
-	return 0;
+	return rc;
 }
 
 static int compressor_lz4_exit(struct erofs_compress *c)
diff --git a/lib/compressor_lz4hc.c b/lib/compressor_lz4hc.c
index ec9347e..14e0175 100644
--- a/lib/compressor_lz4hc.c
+++ b/lib/compressor_lz4hc.c
@@ -25,7 +25,7 @@ static int lz4hc_compress_destsize(struct erofs_compress *c,
 	if (!rc)
 		return -EFAULT;
 	*srcsize = srcSize;
-	return 0;
+	return rc;
 }
 
 static int compressor_lz4hc_exit(struct erofs_compress *c)
-- 
2.17.1

