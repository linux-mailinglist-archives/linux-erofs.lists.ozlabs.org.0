Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 007712E7730
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Dec 2020 09:48:38 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D5Q1H1NgpzDqHh
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Dec 2020 19:48:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1609318115;
	bh=/x0/PrJkJv2kPojdw3N/wYbdJ+4STVrASQwI+bMOlxA=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=h4sD6OQQYGImAF6IiY1kIKVICI8raIpHYjkatMmCn9/NyGFuI9ezqFLxShoDJ344L
	 zJet+VzR1Jv33CuBDvPstrkigu1nzlSPGTCheSeQH+AMoP77gWhGVQd3bs+RHDhIkp
	 7XVbLCpywmfyEcYTyVUIofJ7GGYmNdVydWcEAKU2s/N16Gvti9VNCnfGLwyo5w0JuS
	 1dYhnINNUOnOYiAU9P1IHPH7hy/aAdSa+5STzki3ottjQblwnA9RUG3EvuLzioGb/m
	 4SVb6BzkSEQT0IiLGYjczi1OUTfmo3/Pdx1TqrMYrCLT1OqVUNgw71kYwHe6Jn1Xvz
	 5V2ikb3BiRp/A==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.66.148; helo=sonic317-22.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Received: from sonic317-22.consmr.mail.gq1.yahoo.com
 (sonic317-22.consmr.mail.gq1.yahoo.com [98.137.66.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D5Q0Y6JXfzDqGv
 for <linux-erofs@lists.ozlabs.org>; Wed, 30 Dec 2020 19:47:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1609318072; bh=kuoRt+BV9onKukuwFZvszlYP1HHbDIMIPfl5TDEAcqk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=MjbZpmMeLptHfok/95DLSKVeFZs6vn24wGwesDaTfBvoOv3Hz+iBlhNfOyM75czVKEcIAG4hRaM4BZzBeWxCs8xJDrvef9sOjKAlThUvtk3ZzXD9TtM/13jU1wkusynrq/lAwnMaD6xgSXqeTW2M/aoeJYLXKXOvGjN3XT7zcoUOazkmTkncbseNOe5narbTknKfUrS9hKQlnrkJ1+p2y6sgESsY8rMrHEpeBtaWWK/YqwiUKhGfrf4H5N+O7h4cmzaFKPI+sUGIcpXBSeKxbRcgILhZCBOz6ZawsBpJFXAHkYcJiF4fQd8ZyNcsiu8Gska3bscwel3VcsHzzRoy7Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1609318072; bh=WC7xducC2iD+NUzfOFhfBMEH9QhaFBU1TZ3zSuEz5A7=;
 h=From:To:Subject:Date:From:Subject;
 b=pckuyzrM3qomqTs3eebHzWQsRvzR2yh1aklLmFHtjf4iJ8CQAteNU/UsXHFEyAndHgf9x+Dt4CqxeuIwWbxuPBvstI5XgXVl8heJQ+8M9hwSRS4QWSagFSART3cL4uN3SVxZlP39Z8rD4B78YlQZrNsv4JW8vmUSb8n2jXW29bk6/G3tswvgokN3YhTdh821P0D8p22vFW/JjWl4oUiLyDs0zqjxNBqYvGNGKhYijYly2XDRuZ6GZhiz6u5b3qEz9a6WJCcXoDFiZlf9c3tma6kpbdDcpFHWJsz4IpQYvik6jTSiUWNspgqZ+80zY323ikoSG1GTk2HNGILMhN1aRA==
X-YMail-OSG: Dn9g0GQVM1lzv_0pfRWap6MMiKqrNHjAZ3vgi1ZnlYBKtu80dpSLY7kBAcKmk4r
 0zJP_.JcPmxw1u0spRbxTthHHbHWK.hkwwqPghmvjtijfqlKoV71xwdgww9QM.IhRaj4gUCaHNdW
 MYWsLx0o7.q5VStpLgmqNixbOPwbDP.yWzpmyy7cYOyBcIJkZtt35F_wHzdMageNZc7JMcf6wimD
 EOyir.FBAKOxUAJloRrfHBs7IxR9HV0H0T_ryba9_Qypr14gZmXDTUNhrh5Kc7goXp.aDSfMZv1o
 QeohMTW.mClzjE40GEK1FiujmYfBk5.YA3CiMFrDxxRJEqn3nup.x26GxAG3sljogfeE7pmJpQQY
 iEyMmv6hLBspf.jRp.SXFJZePSYbKq_mM5rMTYP5R.b8LWCPK9PNun.Le4FCU6mNAZ5zR86BhPiG
 Zr3xrS3pxnb8r4CE1yQVabLaLV0l1.bfXZ.ofTN_ddVU_HdqTzAfinYpOxHB9zWL68VAEknp1eWT
 hbkR9opyjotpROKta0B9oPvL77iinTfQMk7o_yLz4ttB3zXhJFd6ySzfiJTHFtgU7KWkW8umIOGJ
 CR1_aT6IvjOmyMf0KLU8G6q2t0Fr88a1TnUVsuu3A92WP_hiZydXUW.So8t7mzDB4oSbqsYNBIrF
 ux_0CvrDtkX_OCIBgVVGu8qb9J0Rmm5VE12vGx.yaDuJ9jl6yH0.p.su.tAnKwDOLjkXVeDQVW9o
 xP0isRrcVn5VfH0L2z.DzedcDIE9YzNHpyWNbhulkAoErFUfKNgjoficE8seku1ehhGHbwSp2QTZ
 i8AOYB5CVdnZaw48laEzy9XtKsAN24o.G2eBLjnxTzt_3wCuckX1PRk9LCEDen5tiq7fDGQ94Mw5
 IsGZK7coy_NTUG88VwVohkE1X5uHQYQ4zVIJ_mPoqActJTkBLvZGaLEqYMCJdSq5q6A0vNa_6h.S
 pKtU14W9szrgnt_LJa57dhxlzlAN6_tqyFgRerB8iwtmAIV6bNBjh78D_UTXg6fKMJQhba2Jd5RZ
 UaAfKv79p3EP2NDPuhv9tC.muYKskC.s1b0Oxi9DZOfuVIUXvvhkF1x45HnA4QDdId_MgydaBg3f
 w9utAIj.wkR.nPQXq_7WhZ2p4WUNqwQ0_4G5q81D4ehya2P6aBh5Hcl8lzpCVBSHJOacAbhff1bs
 HUULmqPNn6L6A4o7OqTaQWc5LI0Krf0p5_dDLJenMMoB..qXOguScqmlIg60fiuOSHZRPOvZz1IX
 wq26nBoEj5TTRzHcIXq2klTKMkJi2cFW0N.odW0dFM5q7RpvpBExn3gqRUuvAwJuKavUuCXuyhPV
 wSc7EZ.m81zJO3PVR6UkHTgfGKw6VX8rMUpX31OFhEwUW5xGloiKuMIVWK4MtKfLVaG2c9fzV4Dg
 2cxC40qLMBJJK8yjHMmzLHAtR7kZPIqP5COmGMhU23Q.Mae0rLJRJkjGaVrNQ03hOTKAjGfoIndd
 WSbyjR8t1exLKVEtA8Hr0LOLfhHWPpvB667QQxC6G413oCuHL7EO6DhormhtxEmr_Ky9OuoJ5qNf
 5WbEsWu833Av594MQ9eMhx0lko_VLQrZ_phyZWjgYEaBUkh0X9rhk8wsy0kiX4mBWgKu7bbrYIK9
 TVMsaa4m4reZFfvhx1oiHtu8xDXc9U18vyNI9hq9wxF4RStKvxBw.GzgQZSGiUzhN8mF_EQo_VLL
 pl1KRAiW5QlfdwfuEX.aGrH3yzLo7VmoFjMGTQ.i7W.ZuLGRvtYQoTMOGuVD7yGOcUHsg0CyiYGt
 qdeJqO9CO4cVupPpAA2suOzazrUGxndSkjVmC5kygBme4kNX8NZYnJod8b1QYF4.DjIzIQfZB5eM
 QgR6IKjpd.V.jfuZP00P.0ZuitGH5MlDX7TrsS3Riux8eRqfcOUe85lvfx4DIFhpqeB24EpnaPQ_
 VZOfosnA8OJNF3Q_wR9pYVjDE4vxXL8MCasdOfiHXQOR.kzx9lpX7qt4cFMq8Yp4Rw9aA_QutqBs
 X5_iXJ40zodGKcf3hbT6Ilt.A.SEgEHaJSWyknjtKBsN2xUzMeVWaymeZx6Rs.PGf7oVb34MNlX3
 .08GgIRY8aVqg2Nz6Xq9G.8VnMJwRHP8rOLjOGzct3myLAhQnTm48rM8eN8wWALkC3aQ8b9_kzHl
 _bMjzth8qwe8W7kkqEJ5_f8hQmJY5XusI31Bxsyg9jBzGOAlSNLFTvFcqCgP2_Hll1jmBsNuo2tE
 OylDSp5_3cX2a9_6O05uHOV1CLi1Q_2wpWajuvdtgGVIBVCby_8tkbRg25lhNvXIWp8p28crsI1_
 LIAOeUZPCIiMstjqMuXPLj1wuR7Fep48LGuAM3w1X3MzMzM5rkWHV8yZPkLefpTXvOXbmIJIzXtI
 gfeIec4HKIKH2tjdH7XIZo5wkuomxr9qyJL8fT0FXdMMNciWFi1Yw9cG3TVseLy4_KFZ7dnOY6HD
 nk2bKu7iS8cAI1aT.c1CFX9UvfBtvZkpV7gz02rrHxg--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic317.consmr.mail.gq1.yahoo.com with HTTP; Wed, 30 Dec 2020 08:47:52 +0000
Received: by smtp416.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 68e206c49d6e76b1b6872a88eb7f98ec; 
 Wed, 30 Dec 2020 08:47:49 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v0 2/3] erofs-utils: mkfs: support multiple block
 compression
Date: Wed, 30 Dec 2020 16:47:27 +0800
Message-Id: <20201230084728.813-3-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201230084728.813-1-hsiangkao@aol.com>
References: <20201230084728.813-1-hsiangkao@aol.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@aol.com>

Store compressed block count to the compressed index so that EROFS
can compress from variable-sized input to variable-sized compressed
blocks and make the in-place decompression possible as well.

TODO: support storing compressed block count for compact indexes.

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 include/erofs/internal.h |  1 +
 include/erofs_fs.h       | 19 ++++++++---
 lib/compress.c           | 70 ++++++++++++++++++++++++++--------------
 3 files changed, 62 insertions(+), 28 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index ac5b270329e2..de307e7f3d8f 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -104,6 +104,7 @@ static inline void erofs_sb_clear_##name(void) \
 }
 
 EROFS_FEATURE_FUNCS(lz4_0padding, incompat, INCOMPAT_LZ4_0PADDING)
+EROFS_FEATURE_FUNCS(big_pcluster, incompat, INCOMPAT_BIG_PCLUSTER)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 
 #define EROFS_I_EA_INITED	(1 << 0)
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index a69f179a51a5..fa9467a2608c 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -20,7 +20,10 @@
  * be incompatible with this kernel version.
  */
 #define EROFS_FEATURE_INCOMPAT_LZ4_0PADDING	0x00000001
-#define EROFS_ALL_FEATURE_INCOMPAT		EROFS_FEATURE_INCOMPAT_LZ4_0PADDING
+#define EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER	0x00000002
+#define EROFS_ALL_FEATURE_INCOMPAT	\
+	(EROFS_FEATURE_INCOMPAT_LZ4_0PADDING | \
+	 EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER)
 
 /* 128-byte erofs on-disk super block */
 struct erofs_super_block {
@@ -201,10 +204,11 @@ enum {
  * bit 0 : COMPACTED_2B indexes (0 - off; 1 - on)
  *  e.g. for 4k logical cluster size,      4B        if compacted 2B is off;
  *                                  (4B) + 2B + (4B) if compacted 2B is on.
+ * bit 1 : HEAD1 big pcluster (0 - off; 1 - on)
+ * bit 2 : (reserved now) HEAD2 big pcluster (0 - off; 1 - on)
  */
-#define Z_EROFS_ADVISE_COMPACTED_2B_BIT         0
-
-#define Z_EROFS_ADVISE_COMPACTED_2B     (1 << Z_EROFS_ADVISE_COMPACTED_2B_BIT)
+#define Z_EROFS_ADVISE_COMPACTED_2B		0x0001
+#define Z_EROFS_ADVISE_BIG_PCLUSTER_1		0x0002
 
 struct z_erofs_map_header {
 	__le32	h_reserved1;
@@ -261,6 +265,13 @@ enum {
 #define Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS        2
 #define Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT         0
 
+/*
+ * D0_CBLKCNT will be marked _only_ for the 1st non-head lcluster to
+ * store the compressed block count of a compressed extent (aka. block
+ * count of a pcluster).
+ */
+#define Z_EROFS_VLE_DI_D0_CBLKCNT		0x8000
+
 struct z_erofs_vle_decompressed_index {
 	__le16 di_advise;
 	/* where to decompress in the head cluster */
diff --git a/lib/compress.c b/lib/compress.c
index 86db940b6edd..f340f432c6b7 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -29,8 +29,8 @@ struct z_erofs_vle_compress_ctx {
 
 	u8 queue[EROFS_CONFIG_COMPR_MAX_SZ * 2];
 	unsigned int head, tail;
-
-	erofs_blk_t blkaddr;	/* pointing to the next blkaddr */
+	unsigned int compressedblks;
+	erofs_blk_t blkaddr;		/* pointing to the next blkaddr */
 	u16 clusterofs;
 };
 
@@ -89,7 +89,13 @@ static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
 	}
 
 	do {
-		if (d0) {
+		/* XXX: big pcluster feature should be per-inode */
+		if (d0 == 1 && cfg.c_physical_clusterblks > 1) {
+			type = Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD;
+			di.di_u.delta[0] = cpu_to_le16(ctx->compressedblks |
+					Z_EROFS_VLE_DI_D0_CBLKCNT);
+			di.di_u.delta[1] = cpu_to_le16(d1);
+		} else if (d0) {
 			type = Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD;
 
 			di.di_u.delta[0] = cpu_to_le16(d0);
@@ -115,9 +121,8 @@ static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
 	ctx->clusterofs = clusterofs + count;
 }
 
-static int write_uncompressed_block(struct z_erofs_vle_compress_ctx *ctx,
-				    unsigned int *len,
-				    char *dst)
+static int write_uncompressed_extent(struct z_erofs_vle_compress_ctx *ctx,
+				     unsigned int *len, char *dst)
 {
 	int ret;
 	unsigned int count;
@@ -148,17 +153,19 @@ static int vle_compress_one(struct erofs_inode *inode,
 			    struct z_erofs_vle_compress_ctx *ctx,
 			    bool final)
 {
+	const unsigned int pclusterblks = cfg.c_physical_clusterblks;
+	const unsigned int pclustersize = pclusterblks * EROFS_BLKSIZ;
 	struct erofs_compress *const h = &compresshandle;
 	unsigned int len = ctx->tail - ctx->head;
 	unsigned int count;
 	int ret;
-	static char dstbuf[EROFS_BLKSIZ * 2];
+	static char dstbuf[EROFS_CONFIG_COMPR_MAX_SZ + EROFS_BLKSIZ];
 	char *const dst = dstbuf + EROFS_BLKSIZ;
 
 	while (len) {
 		bool raw;
 
-		if (len <= EROFS_BLKSIZ) {
+		if (len <= pclustersize) {
 			if (final)
 				goto nocompression;
 			break;
@@ -167,7 +174,7 @@ static int vle_compress_one(struct erofs_inode *inode,
 		count = len;
 		ret = erofs_compress_destsize(h, compressionlevel,
 					      ctx->queue + ctx->head,
-					      &count, dst, EROFS_BLKSIZ);
+					      &count, dst, pclustersize);
 		if (ret <= 0) {
 			if (ret != -EAGAIN) {
 				erofs_err("failed to compress %s: %s",
@@ -175,32 +182,36 @@ static int vle_compress_one(struct erofs_inode *inode,
 					  erofs_strerror(ret));
 			}
 nocompression:
-			ret = write_uncompressed_block(ctx, &len, dst);
+			ret = write_uncompressed_extent(ctx, &len, dst);
 			if (ret < 0)
 				return ret;
 			count = ret;
+			ctx->compressedblks = 1;
 			raw = true;
 		} else {
-			/* write compressed data */
-			erofs_dbg("Writing %u compressed data to block %u",
-				  count, ctx->blkaddr);
+			const unsigned int used = ret & (EROFS_BLKSIZ - 1);
+			const unsigned int margin =
+				erofs_sb_has_lz4_0padding() && used ?
+					EROFS_BLKSIZ - used : 0;
 
-			if (erofs_sb_has_lz4_0padding())
-				ret = blk_write(dst - (EROFS_BLKSIZ - ret),
-						ctx->blkaddr, 1);
-			else
-				ret = blk_write(dst, ctx->blkaddr, 1);
+			ctx->compressedblks = DIV_ROUND_UP(ret, EROFS_BLKSIZ);
 
+			/* write compressed data */
+			erofs_dbg("Writing %u compressed data to %u of %u blocks",
+				  count, ctx->blkaddr, ctx->compressedblks);
+
+			ret = blk_write(dst - margin, ctx->blkaddr,
+					ctx->compressedblks);
 			if (ret)
 				return ret;
 			raw = false;
 		}
 
 		ctx->head += count;
-		/* write compression indexes for this blkaddr */
+		/* write compression indexes for this pcluster */
 		vle_write_indexes(ctx, count, raw);
 
-		++ctx->blkaddr;
+		ctx->blkaddr += ctx->compressedblks;
 		len -= count;
 
 		if (!final && ctx->head >= EROFS_CONFIG_COMPR_MAX_SZ) {
@@ -345,8 +356,6 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 
 	out = in = inode->compressmeta;
 
-	/* write out compacted header */
-	memcpy(out, &mapheader, sizeof(mapheader));
 	out += sizeof(mapheader);
 	in += Z_EROFS_LEGACY_MAP_HEADER_SIZE;
 
@@ -415,6 +424,8 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	}
 
 	memset(compressmeta, 0, Z_EROFS_LEGACY_MAP_HEADER_SIZE);
+	/* write out compressed header */
+	memcpy(compressmeta, &mapheader, sizeof(mapheader));
 
 	blkaddr = erofs_mapbh(bh->block, true);	/* start_blkaddr */
 	ctx.blkaddr = blkaddr;
@@ -473,7 +484,8 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	inode->u.i_blocks = compressed_blocks;
 
 	legacymetasize = ctx.metacur - compressmeta;
-	if (cfg.c_legacy_compress) {
+	/* XXX: temporarily use legacy index instead for mbpcluster */
+	if (cfg.c_legacy_compress || cfg.c_physical_clusterblks > 1) {
 		inode->extent_isize = legacymetasize;
 		inode->datalayout = EROFS_INODE_FLAT_COMPRESSION_LEGACY;
 	} else {
@@ -531,7 +543,17 @@ int z_erofs_compress_init(void)
 
 	algorithmtype[0] = ret;	/* primary algorithm (head 0) */
 	algorithmtype[1] = 0;	/* secondary algorithm (head 1) */
-	mapheader.h_advise |= Z_EROFS_ADVISE_COMPACTED_2B;
+	mapheader.h_advise = 0;
+	if (!cfg.c_legacy_compress)
+		mapheader.h_advise |= Z_EROFS_ADVISE_COMPACTED_2B;
+	/*
+	 * if big pcluster is enabled, an extra CBLKCNT lcluster index needs
+	 * to be loaded in order to get those compressed block counts.
+	 */
+	if (cfg.c_physical_clusterblks > 1) {
+		erofs_sb_set_big_pcluster();
+		mapheader.h_advise |= Z_EROFS_ADVISE_BIG_PCLUSTER_1;
+	}
 	mapheader.h_algorithmtype = algorithmtype[1] << 4 |
 					  algorithmtype[0];
 	mapheader.h_clusterbits = LOG_BLOCK_SIZE - 12;
-- 
2.24.0

