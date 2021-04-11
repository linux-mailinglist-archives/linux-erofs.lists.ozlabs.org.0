Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A7635B14E
	for <lists+linux-erofs@lfdr.de>; Sun, 11 Apr 2021 05:49:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FHyXX54drz3bs2
	for <lists+linux-erofs@lfdr.de>; Sun, 11 Apr 2021 13:49:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QJNvLtaF;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=QJNvLtaF; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FHyXT2yvdz30Cy
 for <linux-erofs@lists.ozlabs.org>; Sun, 11 Apr 2021 13:48:57 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C405611AD;
 Sun, 11 Apr 2021 03:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618112935;
 bh=U8LqDJREu8cfWITQZOfAceSuuNXvD/kQzRsnaOM2VoM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QJNvLtaF/boA946oL1B0TEIUN/mIB/mmsKAx5pAE0ORt5CI1aCGqb6j16flmNPTQy
 PtgguCoEggFDFg8kA5ejEbTarpFpRldzc7sK9QCoX16S5NdEvz5RRLu5e7kot20aQg
 w7O/6vpUn18w0n40nsl2xl8N6HadfiDx3RaQ+Q2tcnjF3LLKPoZs3FupY5DpsBFWrO
 DlGedpNiUNC1W4/DRIbXEgSLZUIPU4AIwTvYgTfML8q9cUh+qaZs/f2XfxXI+meypI
 vmV4GNXA/OOTzhDUzsPWz9FGMxaReB65+IQYyOgXAw8J63SanmeV7KJmnPjllYxAn3
 aEu+rji/pzFcQ==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/8] erofs-utils: support adjust lz4 history window size
Date: Sun, 11 Apr 2021 11:48:37 +0800
Message-Id: <20210411034844.12673-2-xiang@kernel.org>
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
 include/erofs/internal.h | 1 +
 include/erofs_fs.h       | 3 ++-
 lib/compressor_lz4.c     | 5 +++++
 lib/compressor_lz4hc.c   | 2 ++
 mkfs/main.c              | 1 +
 5 files changed, 11 insertions(+), 1 deletion(-)

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
index 6680563986c3..052c6ba0cc41 100644
--- a/lib/compressor_lz4hc.c
+++ b/lib/compressor_lz4hc.c
@@ -44,6 +44,8 @@ static int compressor_lz4hc_init(struct erofs_compress *c)
 	c->private_data = LZ4_createStreamHC();
 	if (!c->private_data)
 		return -ENOMEM;
+
+	sbi.lz4_max_distance = LZ4_DISTANCE_MAX;
 	return 0;
 }
 
diff --git a/mkfs/main.c b/mkfs/main.c
index d9c4c7fff5c1..4c9743d077a7 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -299,6 +299,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 		.feature_incompat = cpu_to_le32(sbi.feature_incompat),
 		.feature_compat = cpu_to_le32(sbi.feature_compat &
 					      ~EROFS_FEATURE_COMPAT_SB_CHKSUM),
+		.lz4_max_distance = cpu_to_le16(sbi.lz4_max_distance),
 	};
 	const unsigned int sb_blksize =
 		round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
-- 
2.20.1

