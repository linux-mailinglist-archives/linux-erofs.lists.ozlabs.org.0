Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F20D57EBB52
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Nov 2023 03:50:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SVSMS2ywMz3cRs
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Nov 2023 13:50:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.15; helo=out199-15.us.a.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out199-15.us.a.mail.aliyun.com (out199-15.us.a.mail.aliyun.com [47.90.199.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SVSMJ1t05z3byh
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Nov 2023 13:50:16 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VwRB4y-_1700016593;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VwRB4y-_1700016593)
          by smtp.aliyun-inc.com;
          Wed, 15 Nov 2023 10:49:58 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: lib: `fragment_size` should be 64 bits
Date: Wed, 15 Nov 2023 10:49:52 +0800
Message-Id: <20231115024952.1256243-1-hsiangkao@linux.alibaba.com>
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

`-Eall-fragments` is broken if i_size is more than 32 bits.

Fixes: fcaa988a6ef6 ("erofs-utils: add `-Eall-fragments` option")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/internal.h | 12 ++++++++----
 lib/compress.c           |  9 +++++----
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 78b9f32..82797e1 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -233,16 +233,20 @@ struct erofs_inode {
 			uint8_t  z_algorithmtype[2];
 			uint8_t  z_logical_clusterbits;
 			uint8_t  z_physical_clusterblks;
-			uint64_t z_tailextent_headlcn;
-			unsigned int    z_idataoff;
+			union {
+				uint64_t z_tailextent_headlcn;
+				erofs_off_t fragment_size;
+			};
+			union {
+				unsigned int z_idataoff;
+				erofs_off_t fragmentoff;
+			};
 #define z_idata_size	idata_size
 		};
 	};
 #ifdef WITH_ANDROID
 	uint64_t capabilities;
 #endif
-	erofs_off_t fragmentoff;
-	unsigned int fragment_size;
 };
 
 static inline erofs_off_t erofs_iloc(struct erofs_inode *inode)
diff --git a/lib/compress.c b/lib/compress.c
index 4eac363..47f1c1d 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -373,9 +373,9 @@ static bool z_erofs_fixup_deduped_fragment(struct z_erofs_vle_compress_ctx *ctx,
 
 	/* try to fix again if it gets larger (should be rare) */
 	if (inode->fragment_size < newsize) {
-		ctx->pclustersize = min(z_erofs_get_max_pclustersize(inode),
-					roundup(newsize - inode->fragment_size,
-						erofs_blksiz(sbi)));
+		ctx->pclustersize = min_t(erofs_off_t, z_erofs_get_max_pclustersize(inode),
+					  roundup(newsize - inode->fragment_size,
+						  erofs_blksiz(sbi)));
 		return false;
 	}
 
@@ -1005,7 +1005,8 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 		sbi->saved_by_deduplication += inode->fragment_size;
 
 	/* if the entire file is a fragment, a simplified form is used. */
-	if (inode->i_size == inode->fragment_size) {
+	if (inode->i_size <= inode->fragment_size) {
+		DBG_BUGON(inode->i_size < inode->fragment_size);
 		DBG_BUGON(inode->fragmentoff >> 63);
 		*(__le64 *)compressmeta =
 			cpu_to_le64(inode->fragmentoff | 1ULL << 63);
-- 
2.39.3

