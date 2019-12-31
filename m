Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 1841012D70E
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Dec 2019 09:22:54 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47n6k303KfzDq9V
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Dec 2019 19:22:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47n6jy1WkyzDq8W
 for <linux-erofs@lists.ozlabs.org>; Tue, 31 Dec 2019 19:22:42 +1100 (AEDT)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 22310E19E9CE6CFAC6A1
 for <linux-erofs@lists.ozlabs.org>; Tue, 31 Dec 2019 16:22:33 +0800 (CST)
Received: from architecture4.huawei.com (10.160.196.180) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 31 Dec
 2019 16:22:23 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Li Guifu <bluce.liguifu@huawei.com>, <linux-erofs@lists.ozlabs.org>
Subject: [PATCH] erofs-utils: wrap up sb feature operations
Date: Tue, 31 Dec 2019 16:22:00 +0800
Message-ID: <20191231082200.152744-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.160.196.180]
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
Cc: Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add some helpers for shorter lines. No logic change.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 include/erofs/internal.h | 17 +++++++++++++++++
 lib/compress.c           | 18 ++++++++----------
 mkfs/main.c              |  7 +++----
 3 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index e13adda12257..0a82c226d170 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -62,6 +62,23 @@ struct erofs_sb_info {
 /* global sbi */
 extern struct erofs_sb_info sbi;
 
+#define EROFS_FEATURE_FUNCS(name, compat, feature) \
+static inline bool erofs_sb_has_##name(void) \
+{ \
+	return sbi.feature_##compat & EROFS_FEATURE_##feature; \
+} \
+static inline void erofs_sb_set_##name(void) \
+{ \
+	sbi.feature_##compat |= EROFS_FEATURE_##feature; \
+} \
+static inline void erofs_sb_clear_##name(void) \
+{ \
+	sbi.feature_##compat &= ~EROFS_FEATURE_##feature; \
+}
+
+EROFS_FEATURE_FUNCS(lz4_0padding, incompat, INCOMPAT_LZ4_0PADDING)
+EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
+
 struct erofs_inode {
 	struct list_head i_hash, i_subdirs, i_xattrs;
 
diff --git a/lib/compress.c b/lib/compress.c
index 99fd527ead50..412557fe2627 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -120,13 +120,12 @@ static int write_uncompressed_block(struct z_erofs_vle_compress_ctx *ctx,
 	int ret;
 	unsigned int count;
 
-	if (!(sbi.feature_incompat & EROFS_FEATURE_INCOMPAT_LZ4_0PADDING)) {
-		/* fix up clusterofs to 0 if possable */
-		if (ctx->head >= ctx->clusterofs) {
-			ctx->head -= ctx->clusterofs;
-			*len += ctx->clusterofs;
-			ctx->clusterofs = 0;
-		}
+	/* reset clusterofs to 0 if permitted */
+	if (!erofs_sb_has_lz4_0padding() &&
+	    ctx->head >= ctx->clusterofs) {
+		ctx->head -= ctx->clusterofs;
+		*len += ctx->clusterofs;
+		ctx->clusterofs = 0;
 	}
 
 	/* write uncompressed data */
@@ -184,8 +183,7 @@ nocompression:
 			erofs_dbg("Writing %u compressed data to block %u",
 				  count, ctx->blkaddr);
 
-			if (sbi.feature_incompat &
-			    EROFS_FEATURE_INCOMPAT_LZ4_0PADDING)
+			if (erofs_sb_has_lz4_0padding())
 				ret = blk_write(dst - (EROFS_BLKSIZ - ret),
 						ctx->blkaddr, 1);
 			else
@@ -514,7 +512,7 @@ int z_erofs_compress_init(void)
 	 */
 	if (!cfg.c_compr_alg_master ||
 	    strncmp(cfg.c_compr_alg_master, "lz4", 3))
-		sbi.feature_incompat &= ~EROFS_FEATURE_INCOMPAT_LZ4_0PADDING;
+		erofs_sb_clear_lz4_0padding();
 
 	if (!cfg.c_compr_alg_master)
 		return 0;
diff --git a/mkfs/main.c b/mkfs/main.c
index 7493a481be82..817a6c1ab967 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -98,8 +98,7 @@ static int parse_extended_opts(const char *opts)
 				return -EINVAL;
 			/* disable compacted indexes and 0padding */
 			cfg.c_legacy_compress = true;
-			sbi.feature_incompat &=
-				~EROFS_FEATURE_INCOMPAT_LZ4_0PADDING;
+			erofs_sb_clear_lz4_0padding();
 		}
 
 		if (MATCH_EXTENTED_OPT("force-inode-compact", token, keylen)) {
@@ -117,7 +116,7 @@ static int parse_extended_opts(const char *opts)
 		if (MATCH_EXTENTED_OPT("nosbcrc", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
-			sbi.feature_compat &= ~EROFS_FEATURE_COMPAT_SB_CHKSUM;
+			erofs_sb_clear_sb_chksum();
 		}
 	}
 	return 0;
@@ -424,7 +423,7 @@ int main(int argc, char **argv)
 	else
 		err = dev_resize(nblocks);
 
-	if (!err && (sbi.feature_compat & EROFS_FEATURE_COMPAT_SB_CHKSUM))
+	if (!err && erofs_sb_has_sb_chksum())
 		err = erofs_mkfs_superblock_csum_set();
 exit:
 	z_erofs_compress_exit();
-- 
2.17.1

