Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2785D9D45C2
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Nov 2024 03:35:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xv2Qj0ZdDz2ytQ
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Nov 2024 13:35:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732156540;
	cv=none; b=h3kWynYKq6Yf5ZD9VJP3yOcveBwZOZUpQf5vJyz3okoaGrw71f7ahlNRs87WfEtUSmIQ/JuJH0oih/5bfzlkUPBH8/Hk0S5YOCCs+Gyr85z0ejYWWr6tvGntGhtMp3fnkAFi78QDw5+IbIwcG8IuW+YPtGYtl+d04HrNwr2HN+pF8tlTGNQ98tdzudrE6U/3gFqcTwtP1xPL77+tElbscabgGtRnB1T40BNPBJRiMbx66iP1wd4jfOfFiQr/692tY0EHr5TYzzVUIWh9Y3oD30/OJahQIJcZU6XPumhPRNagrm7yPZewvHDeMA4fryKxkvb/8ffDAjZZgEjLy0lO+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732156540; c=relaxed/relaxed;
	bh=NosvDIxGFj68XX1j/3gc4a+mkjwt/oVHxHz6nxUPLqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6IoWd9v8Mg21Vt9S4TDsaI+q/VVA1I9gNh76DzYifkJ6ydVeLf4MTn2FNWYryLIZkrYVda+mc2GW85ohKjvYPxNE0rFtPY/EaQvPNfsKFIFnSj0PSNc5nFtH8xnkvmiTgqv8EhVKmcFAJbsUlxMSBtkXQ3DP/7bmdtzpq818f6UjMCrQvjb5wdENLoew0+5+qLXxGyFgXy3DIa19jjYHO4PjNVH2En6vg9YZLyU+QEFO82RvjbWM+OFJZtB82F20VhQkiIkYLIHd+Kq252TReHtE/tGfj2brhaAPWFkOqrEpIDM1/0hL/ST3TzuVFKVO7ESpanDIH3sBpwRDinPrw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QJHZeZgt; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QJHZeZgt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xv2Qc4M4fz2yjR
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 Nov 2024 13:35:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732156527; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=NosvDIxGFj68XX1j/3gc4a+mkjwt/oVHxHz6nxUPLqg=;
	b=QJHZeZgtH3hrtO4ryypTTD07mBPakWgD8Hjl3iXbHmjiQ7HRbHbWS7lhG/q82RyEpf7M2IfwKicxnTL9jS4hbQEDLoTb0+myBfEr4nAcNlLtUJZnJ6dnnPjq3StR/81GjstAtmCjcTu7uCu//VkaG/wx3tPYt01+FlXCkIZujgo=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJuAbow_1732156520 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 21 Nov 2024 10:35:25 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 2/2] erofs-utils: lib: clean up z_erofs_load_full_lcluster()
Date: Thu, 21 Nov 2024 10:35:17 +0800
Message-ID: <20241121023517.581040-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241119085427.1672789-2-hsiangkao@linux.alibaba.com>
References: <20241119085427.1672789-2-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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

Let's keep in sync with kernel commit d69189428d50 ("erofs: clean up
z_erofs_load_full_lcluster()").

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v2:
 - fix build error in erofs_check_ondisk_layout_definitions().

 include/erofs_fs.h |  7 ++-----
 lib/compress.c     | 15 +++++----------
 lib/zmap.c         | 20 +++++---------------
 3 files changed, 12 insertions(+), 30 deletions(-)

diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index fc21915..c579ba0 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -414,8 +414,7 @@ enum {
 	Z_EROFS_LCLUSTER_TYPE_MAX
 };
 
-#define Z_EROFS_LI_LCLUSTER_TYPE_BITS        2
-#define Z_EROFS_LI_LCLUSTER_TYPE_BIT         0
+#define Z_EROFS_LI_LCLUSTER_TYPE_MASK	(Z_EROFS_LCLUSTER_TYPE_MAX - 1)
 
 /* (noncompact only, HEAD) This pcluster refers to partial decompressed data */
 #define Z_EROFS_LI_PARTIAL_REF		(1 << 15)
@@ -474,9 +473,7 @@ static inline void erofs_check_ondisk_layout_definitions(void)
 		     sizeof(struct z_erofs_lcluster_index));
 	BUILD_BUG_ON(sizeof(struct erofs_deviceslot) != 128);
 
-	BUILD_BUG_ON(BIT(Z_EROFS_LI_LCLUSTER_TYPE_BITS) <
-		     Z_EROFS_LCLUSTER_TYPE_MAX - 1);
-#ifndef __cplusplus
+`#ifndef __cplusplus
 	/* exclude old compiler versions like gcc 7.5.0 */
 	BUILD_BUG_ON(__builtin_constant_p(fmh.v) ?
 		     fmh.v != cpu_to_le64(1ULL << 63) : 0);
diff --git a/lib/compress.c b/lib/compress.c
index d75e9c3..c679843 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -129,7 +129,7 @@ static void z_erofs_write_indexes_final(struct z_erofs_compress_ictx *ctx)
 
 	di.di_clusterofs = cpu_to_le16(ctx->clusterofs);
 	di.di_u.blkaddr = 0;
-	di.di_advise = cpu_to_le16(type << Z_EROFS_LI_LCLUSTER_TYPE_BIT);
+	di.di_advise = cpu_to_le16(type);
 
 	memcpy(ctx->metacur, &di, sizeof(di));
 	ctx->metacur += sizeof(di);
@@ -159,8 +159,7 @@ static void z_erofs_write_extent(struct z_erofs_compress_ictx *ctx,
 		DBG_BUGON(e->partial);
 		type = e->raw ? Z_EROFS_LCLUSTER_TYPE_PLAIN :
 			Z_EROFS_LCLUSTER_TYPE_HEAD1;
-		advise = type << Z_EROFS_LI_LCLUSTER_TYPE_BIT;
-		di.di_advise = cpu_to_le16(advise);
+		di.di_advise = cpu_to_le16(type);
 
 		if (inode->datalayout == EROFS_INODE_COMPRESSED_FULL &&
 		    !e->compressedblks)
@@ -218,8 +217,7 @@ static void z_erofs_write_extent(struct z_erofs_compress_ictx *ctx,
 				advise |= Z_EROFS_LI_PARTIAL_REF;
 			}
 		}
-		advise |= type << Z_EROFS_LI_LCLUSTER_TYPE_BIT;
-		di.di_advise = cpu_to_le16(advise);
+		di.di_advise = cpu_to_le16(advise | type);
 
 		memcpy(ctx->metacur, &di, sizeof(di));
 		ctx->metacur += sizeof(di);
@@ -758,8 +756,7 @@ static void *parse_legacy_indexes(struct z_erofs_compressindex_vec *cv,
 		struct z_erofs_lcluster_index *const di = db + i;
 		const unsigned int advise = le16_to_cpu(di->di_advise);
 
-		cv->clustertype = (advise >> Z_EROFS_LI_LCLUSTER_TYPE_BIT) &
-			((1 << Z_EROFS_LI_LCLUSTER_TYPE_BITS) - 1);
+		cv->clustertype = advise & Z_EROFS_LI_LCLUSTER_TYPE_MASK;
 		cv->clusterofs = le16_to_cpu(di->di_clusterofs);
 
 		if (cv->clustertype == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
@@ -987,10 +984,8 @@ void z_erofs_drop_inline_pcluster(struct erofs_inode *inode)
 		struct z_erofs_lcluster_index *di =
 			(inode->compressmeta + inode->extent_isize) -
 			sizeof(struct z_erofs_lcluster_index);
-		__le16 advise =
-			cpu_to_le16(type << Z_EROFS_LI_LCLUSTER_TYPE_BIT);
 
-		di->di_advise = advise;
+		di->di_advise = cpu_to_le16(type);
 	} else if (inode->datalayout == EROFS_INODE_COMPRESSED_COMPACT) {
 		/* handle the last compacted 4B pack */
 		unsigned int eofs, base, pos, v, lo;
diff --git a/lib/zmap.c b/lib/zmap.c
index e04a99a..f1cdc66 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -152,7 +152,7 @@ static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
 			vi->inode_isize + vi->xattr_isize) +
 		lcn * sizeof(struct z_erofs_lcluster_index);
 	struct z_erofs_lcluster_index *di;
-	unsigned int advise, type;
+	unsigned int advise;
 	int err;
 
 	err = z_erofs_reload_indexes(m, erofs_blknr(sbi, pos));
@@ -164,10 +164,8 @@ static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
 	di = m->kaddr + erofs_blkoff(sbi, pos);
 
 	advise = le16_to_cpu(di->di_advise);
-	type = (advise >> Z_EROFS_LI_LCLUSTER_TYPE_BIT) &
-		((1 << Z_EROFS_LI_LCLUSTER_TYPE_BITS) - 1);
-	switch (type) {
-	case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
+	m->type = advise & Z_EROFS_LI_LCLUSTER_TYPE_MASK;
+	if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
 		m->clusterofs = 1 << vi->z_logical_clusterbits;
 		m->delta[0] = le16_to_cpu(di->di_u.delta[0]);
 		if (m->delta[0] & Z_EROFS_LI_D0_CBLKCNT) {
@@ -180,19 +178,11 @@ static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
 			m->delta[0] = 1;
 		}
 		m->delta[1] = le16_to_cpu(di->di_u.delta[1]);
-		break;
-	case Z_EROFS_LCLUSTER_TYPE_PLAIN:
-	case Z_EROFS_LCLUSTER_TYPE_HEAD1:
-		if (advise & Z_EROFS_LI_PARTIAL_REF)
-			m->partialref = true;
+	} else {
+		m->partialref = !!(advise & Z_EROFS_LI_PARTIAL_REF);
 		m->clusterofs = le16_to_cpu(di->di_clusterofs);
 		m->pblk = le32_to_cpu(di->di_u.blkaddr);
-		break;
-	default:
-		DBG_BUGON(1);
-		return -EOPNOTSUPP;
 	}
-	m->type = type;
 	return 0;
 }
 
-- 
2.43.5

