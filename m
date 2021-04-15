Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C0436006A
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Apr 2021 05:27:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FLPsf42KNz30CC
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Apr 2021 13:27:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QXNW+XL0;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=QXNW+XL0; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FLPsc44B6z2yZF
 for <linux-erofs@lists.ozlabs.org>; Thu, 15 Apr 2021 13:27:16 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 326F16103E;
 Thu, 15 Apr 2021 03:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618457232;
 bh=YOTTnMazYp58ZqXGV/bIvBZvvcAPBzK+4Fh37NV2Xs8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QXNW+XL0/zLB1CvQ7P2igm2qXl5aDuRnMS9zmEq8gYqUDONPBu5dh4+rQah0kak8y
 YiYKOY6g0iLGd3l9OlJPtVvjjDJlKUaFCWp24GFH2glrA5s8zET34DS3u5dTWpb9+X
 lHxt7mOQhcwj/3OpCVCg9ZCVeproQB7tPazdyTDZjoCBaPYROhM0yd+5KnsjMs/MwM
 qbppCBWonysKLb6Uoq7EhvnfWSOJAoXFsSgXAFZxsTX4MyIUHn5xzNHN3sliGZnKW6
 /HN4FSbCM7smZeuMR3uGYjQ5AciKN5MkMkpfqKPj/6qiHXuwn1DrSKhPpH9VJjcvLp
 kDOOHwLweWAmw==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v1.1 1/8] erofs-utils: support adjust lz4 history window size
Date: Thu, 15 Apr 2021 11:27:05 +0800
Message-Id: <20210415032705.27515-1-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210411034844.12673-1-xiang@kernel.org>
References: <20210411034844.12673-1-xiang@kernel.org>
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
Cc: Gao Xiang <xiang@kernel.org>, Guo Weichao <guoweichao@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Huang Jianan <huangjianan@oppo.com>

lz4 uses LZ4_DISTANCE_MAX to record history preservation. When
using rolling decompression, a block with a higher compression
ratio will cause a larger memory allocation (up to 64k). It may
cause a large resource burden in extreme cases on devices with
small memory and a large number of concurrent IOs. So appropriately
reducing this value can improve performance.

Decreasing this value will reduce the compression ratio (except
when input_size <LZ4_DISTANCE_MAX). But considering that erofs
currently only supports 4k output, reducing this value will not
significantly reduce the compression benefits.

The maximum value of LZ4_DISTANCE_MAX defined by lz4 is 64k, and
we can only reduce this value. For the old kernel, it just can't
reduce the memory allocation during rolling decompression without
affecting the decompression result.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
Signed-off-by: Gao Xiang <xiang@kernel.org>
---
changes since v1:
 - fix missing LZ4_DISTANCE_MAX definition for lz4hc reported
   by travis CI.

 include/erofs/internal.h | 1 +
 include/erofs_fs.h       | 3 ++-
 lib/compressor_lz4.c     | 5 +++++
 lib/compressor_lz4hc.c   | 6 ++++++
 mkfs/main.c              | 1 +
 5 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index ac5b270329e2..3849980d8eab 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -79,6 +79,7 @@ struct erofs_sb_info {
 	u64 inos;
 
 	u8 uuid[16];
+	u16 lz4_max_distance;
 };
 
 /* global sbi */
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index a69f179a51a5..ae2305c1eb79 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -41,7 +41,8 @@ struct erofs_super_block {
 	__u8 uuid[16];          /* 128-bit uuid for volume */
 	__u8 volume_name[16];   /* volume name */
 	__le32 feature_incompat;
-	__u8 reserved2[44];
+	__le16 lz4_max_distance;
+	__u8 reserved2[42];
 };
 
 /*
diff --git a/lib/compressor_lz4.c b/lib/compressor_lz4.c
index 8540a0d01cbb..292d0f27fe0e 100644
--- a/lib/compressor_lz4.c
+++ b/lib/compressor_lz4.c
@@ -10,6 +10,10 @@
 #include "erofs/internal.h"
 #include "compressor.h"
 
+#ifndef LZ4_DISTANCE_MAX	/* history window size */
+#define LZ4_DISTANCE_MAX 65535	/* set to maximum value by default */
+#endif
+
 static int lz4_compress_destsize(struct erofs_compress *c,
 				 int compression_level,
 				 void *src, unsigned int *srcsize,
@@ -32,6 +36,7 @@ static int compressor_lz4_exit(struct erofs_compress *c)
 static int compressor_lz4_init(struct erofs_compress *c)
 {
 	c->alg = &erofs_compressor_lz4;
+	sbi.lz4_max_distance = LZ4_DISTANCE_MAX;
 	return 0;
 }
 
diff --git a/lib/compressor_lz4hc.c b/lib/compressor_lz4hc.c
index 6680563986c3..14c3a71b0a80 100644
--- a/lib/compressor_lz4hc.c
+++ b/lib/compressor_lz4hc.c
@@ -11,6 +11,10 @@
 #include "erofs/internal.h"
 #include "compressor.h"
 
+#ifndef LZ4_DISTANCE_MAX	/* history window size */
+#define LZ4_DISTANCE_MAX 65535	/* set to maximum value by default */
+#endif
+
 static int lz4hc_compress_destsize(struct erofs_compress *c,
 				   int compression_level,
 				   void *src,
@@ -44,6 +48,8 @@ static int compressor_lz4hc_init(struct erofs_compress *c)
 	c->private_data = LZ4_createStreamHC();
 	if (!c->private_data)
 		return -ENOMEM;
+
+	sbi.lz4_max_distance = LZ4_DISTANCE_MAX;
 	return 0;
 }
 
diff --git a/mkfs/main.c b/mkfs/main.c
index 6bc179db8dc3..8a9611f0f3d0 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -322,6 +322,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 		.feature_incompat = cpu_to_le32(sbi.feature_incompat),
 		.feature_compat = cpu_to_le32(sbi.feature_compat &
 					      ~EROFS_FEATURE_COMPAT_SB_CHKSUM),
+		.lz4_max_distance = cpu_to_le16(sbi.lz4_max_distance),
 	};
 	const unsigned int sb_blksize =
 		round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
-- 
2.20.1

