Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6E335B14F
	for <lists+linux-erofs@lfdr.de>; Sun, 11 Apr 2021 05:49:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FHyXZ2NpQz3btn
	for <lists+linux-erofs@lfdr.de>; Sun, 11 Apr 2021 13:49:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LUxw3oVg;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=LUxw3oVg; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FHyXW2hVkz3bmX
 for <linux-erofs@lists.ozlabs.org>; Sun, 11 Apr 2021 13:48:59 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 20D58611AE;
 Sun, 11 Apr 2021 03:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618112937;
 bh=t5yU6FkmzZZVARE/6a36B7O57049S69XEo9AuRKRECE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LUxw3oVgYYeAK0mByHaWeB1lFtQGN9Ab/uTGlk2Gqwp55xdQwYv9kkoEqAtq9Qosg
 D4Eh7bgMMft+9rnHXjuaLQu+momxTDeivy58VWyh2pgLx2wXeB3Yrq8T2mYA2pAwHP
 YFrNfQtXK/WPahrRYPC54TuPPBwa1x3U24QFcGIbMDwpgFLYaxV34mf88k20Sm97yv
 n/rb0q+M4y56wodzS8SRM4O/g+vzXgVOzI5rhjm8bbsngpYzqaU2gsMfZrFuDbX2yZ
 4TEGkhV3ktGDw5n0hMQBMiaECVmsVgCl9HRxk/8SVakxZvkV1h77wKeoCM7mX5wA+C
 U5F24drx34NWg==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/8] erofs-utils: introduce ondisk compression cfgs
Date: Sun, 11 Apr 2021 11:48:38 +0800
Message-Id: <20210411034844.12673-3-xiang@kernel.org>
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
Cc: Gao Xiang <xiang@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add support to generate ondisk compression cfgs, which can generate
lz4 compression cfgs now.

Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 include/erofs/compress.h |  2 +-
 include/erofs/internal.h |  3 +++
 include/erofs_fs.h       | 17 +++++++++++++++--
 lib/compress.c           | 37 ++++++++++++++++++++++++++++++++++++-
 mkfs/main.c              |  8 ++++++--
 5 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/include/erofs/compress.h b/include/erofs/compress.h
index 952f2870a180..d234e8b25a3b 100644
--- a/include/erofs/compress.h
+++ b/include/erofs/compress.h
@@ -18,7 +18,7 @@
 
 int erofs_write_compressed_file(struct erofs_inode *inode);
 
-int z_erofs_compress_init(void);
+int z_erofs_compress_init(struct erofs_buffer_head *bh);
 int z_erofs_compress_exit(void);
 
 const char *z_erofs_list_available_compressors(unsigned int i);
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 3849980d8eab..6e481faa8c9f 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -79,6 +79,8 @@ struct erofs_sb_info {
 	u64 inos;
 
 	u8 uuid[16];
+
+	u16 available_compr_algs;
 	u16 lz4_max_distance;
 };
 
@@ -105,6 +107,7 @@ static inline void erofs_sb_clear_##name(void) \
 }
 
 EROFS_FEATURE_FUNCS(lz4_0padding, incompat, INCOMPAT_LZ4_0PADDING)
+EROFS_FEATURE_FUNCS(compr_cfgs, incompat, INCOMPAT_COMPR_CFGS)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 
 #define EROFS_I_EA_INITED	(1 << 0)
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index ae2305c1eb79..a24deb095537 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -20,7 +20,10 @@
  * be incompatible with this kernel version.
  */
 #define EROFS_FEATURE_INCOMPAT_LZ4_0PADDING	0x00000001
-#define EROFS_ALL_FEATURE_INCOMPAT		EROFS_FEATURE_INCOMPAT_LZ4_0PADDING
+#define EROFS_FEATURE_INCOMPAT_COMPR_CFGS	0x00000002
+#define EROFS_ALL_FEATURE_INCOMPAT		\
+	(EROFS_FEATURE_INCOMPAT_LZ4_0PADDING | \
+	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS)
 
 /* 128-byte erofs on-disk super block */
 struct erofs_super_block {
@@ -41,7 +44,11 @@ struct erofs_super_block {
 	__u8 uuid[16];          /* 128-bit uuid for volume */
 	__u8 volume_name[16];   /* volume name */
 	__le32 feature_incompat;
-	__le16 lz4_max_distance;
+	union {
+		/* bitmap for available compression algorithms */
+		__le16 available_compr_algs;
+		__le16 lz4_max_distance;
+	} u1;
 	__u8 reserved2[42];
 };
 
@@ -198,6 +205,12 @@ enum {
 	Z_EROFS_COMPRESSION_MAX
 };
 
+/* 14 bytes (+ length field = 16 bytes) */
+struct z_erofs_lz4_cfgs {
+	__le16 max_distance;
+	u8 reserved[12];
+} __packed;
+
 /*
  * bit 0 : COMPACTED_2B indexes (0 - off; 1 - on)
  *  e.g. for 4k logical cluster size,      4B        if compacted 2B is off;
diff --git a/lib/compress.c b/lib/compress.c
index 4b685cd27080..c991c13dfd1a 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -500,7 +500,37 @@ static int erofs_get_compress_algorithm_id(const char *name)
 	return -ENOTSUP;
 }
 
-int z_erofs_compress_init(void)
+int z_erofs_build_compr_cfgs(struct erofs_buffer_head *sb_bh)
+{
+	struct erofs_buffer_head *bh = sb_bh;
+	int ret = 0;
+
+	if (sbi.available_compr_algs & (1 << Z_EROFS_COMPRESSION_LZ4)) {
+		struct {
+			__le16 size;
+			struct z_erofs_lz4_cfgs lz4;
+		} __packed lz4alg = {
+			.size = cpu_to_le16(sizeof(struct z_erofs_lz4_cfgs)),
+			.lz4 = {
+				.max_distance =
+					cpu_to_le16(sbi.lz4_max_distance),
+			}
+		};
+
+		bh = erofs_battach(bh, META, sizeof(lz4alg));
+		if (IS_ERR(bh)) {
+			DBG_BUGON(1);
+			return PTR_ERR(bh);
+		}
+		erofs_mapbh(bh->block);
+		ret = dev_write(&lz4alg, erofs_btell(bh, false),
+				sizeof(lz4alg));
+		bh->op = &erofs_drop_directly_bhops;
+	}
+	return ret;
+}
+
+int z_erofs_compress_init(struct erofs_buffer_head *sb_bh)
 {
 	unsigned int algorithmtype[2];
 	/* initialize for primary compression algorithm */
@@ -536,6 +566,11 @@ int z_erofs_compress_init(void)
 	mapheader.h_algorithmtype = algorithmtype[1] << 4 |
 					  algorithmtype[0];
 	mapheader.h_clusterbits = LOG_BLOCK_SIZE - 12;
+
+	if (erofs_sb_has_compr_cfgs()) {
+		sbi.available_compr_algs |= 1 << ret;
+		return z_erofs_build_compr_cfgs(sb_bh);
+	}
 	return 0;
 }
 
diff --git a/mkfs/main.c b/mkfs/main.c
index 4c9743d077a7..c2a0214c84e2 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -299,7 +299,6 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 		.feature_incompat = cpu_to_le32(sbi.feature_incompat),
 		.feature_compat = cpu_to_le32(sbi.feature_compat &
 					      ~EROFS_FEATURE_COMPAT_SB_CHKSUM),
-		.lz4_max_distance = cpu_to_le16(sbi.lz4_max_distance),
 	};
 	const unsigned int sb_blksize =
 		round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
@@ -310,6 +309,11 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 	sb.root_nid     = cpu_to_le16(root_nid);
 	memcpy(sb.uuid, sbi.uuid, sizeof(sb.uuid));
 
+	if (erofs_sb_has_compr_cfgs())
+		sb.u1.available_compr_algs = sbi.available_compr_algs;
+	else
+		sb.u1.lz4_max_distance = cpu_to_le16(sbi.lz4_max_distance);
+
 	buf = calloc(sb_blksize, 1);
 	if (!buf) {
 		erofs_err("Failed to allocate memory for sb: %s",
@@ -499,7 +503,7 @@ int main(int argc, char **argv)
 		goto exit;
 	}
 
-	err = z_erofs_compress_init();
+	err = z_erofs_compress_init(sb_bh);
 	if (err) {
 		erofs_err("Failed to initialize compressor: %s",
 			  erofs_strerror(err));
-- 
2.20.1

