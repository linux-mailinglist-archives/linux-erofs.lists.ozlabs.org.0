Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B317B48069D
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Dec 2021 06:46:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JNNnv4jrMz2yws
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Dec 2021 16:46:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130;
 helo=out30-130.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JNNnn2mTcz2yw1
 for <linux-erofs@lists.ozlabs.org>; Tue, 28 Dec 2021 16:46:36 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R731e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0V0240kf_1640670365; 
Received: from
 e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V0240kf_1640670365) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 28 Dec 2021 13:46:18 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v4 5/5] erofs: add on-disk compressed tail-packing inline
 support
Date: Tue, 28 Dec 2021 13:46:04 +0800
Message-Id: <20211228054604.114518-6-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20211228054604.114518-1-hsiangkao@linux.alibaba.com>
References: <20211228054604.114518-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Yue Hu <huyue2@yulong.com>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@yulong.com>

Introduces erofs compressed tail-packing inline support.

This approach adds a new field called `h_idata_size' in the
per-file compression header to indicate the encoded size of
each tail-packing pcluster.

At runtime, it will find the start logical offset of the tail
pcluster when initializing per-inode zmap and record such
extent (headlcn, idataoff) information to the in-memory inode.
Therefore, follow-on requests can directly recognize if one
pcluster is a tail-packing inline pcluster or not.

Signed-off-by: Yue Hu <huyue2@yulong.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/erofs_fs.h |  10 +++-
 fs/erofs/internal.h |   6 +++
 fs/erofs/super.c    |   3 ++
 fs/erofs/sysfs.c    |   2 +
 fs/erofs/zmap.c     | 113 ++++++++++++++++++++++++++++++++------------
 5 files changed, 103 insertions(+), 31 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index dda79afb901d..3ea62c6fb00a 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -23,13 +23,15 @@
 #define EROFS_FEATURE_INCOMPAT_CHUNKED_FILE	0x00000004
 #define EROFS_FEATURE_INCOMPAT_DEVICE_TABLE	0x00000008
 #define EROFS_FEATURE_INCOMPAT_COMPR_HEAD2	0x00000008
+#define EROFS_FEATURE_INCOMPAT_ZTAILPACKING	0x00000010
 #define EROFS_ALL_FEATURE_INCOMPAT		\
 	(EROFS_FEATURE_INCOMPAT_ZERO_PADDING | \
 	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
 	 EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER | \
 	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE | \
 	 EROFS_FEATURE_INCOMPAT_DEVICE_TABLE | \
-	 EROFS_FEATURE_INCOMPAT_COMPR_HEAD2)
+	 EROFS_FEATURE_INCOMPAT_COMPR_HEAD2 | \
+	 EROFS_FEATURE_INCOMPAT_ZTAILPACKING)
 
 #define EROFS_SB_EXTSLOT_SIZE	16
 
@@ -292,13 +294,17 @@ struct z_erofs_lzma_cfgs {
  *                                  (4B) + 2B + (4B) if compacted 2B is on.
  * bit 1 : HEAD1 big pcluster (0 - off; 1 - on)
  * bit 2 : HEAD2 big pcluster (0 - off; 1 - on)
+ * bit 3 : tailpacking inline pcluster (0 - off; 1 - on)
  */
 #define Z_EROFS_ADVISE_COMPACTED_2B		0x0001
 #define Z_EROFS_ADVISE_BIG_PCLUSTER_1		0x0002
 #define Z_EROFS_ADVISE_BIG_PCLUSTER_2		0x0004
+#define Z_EROFS_ADVISE_INLINE_PCLUSTER		0x0008
 
 struct z_erofs_map_header {
-	__le32	h_reserved1;
+	__le16	h_reserved1;
+	/* indicates the encoded size of tailpacking data */
+	__le16  h_idata_size;
 	__le16	h_advise;
 	/*
 	 * bit 0-3 : algorithm type of head 1 (logical cluster type 01);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 8e70435629e5..fca3747d97be 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -274,6 +274,7 @@ EROFS_FEATURE_FUNCS(big_pcluster, incompat, INCOMPAT_BIG_PCLUSTER)
 EROFS_FEATURE_FUNCS(chunked_file, incompat, INCOMPAT_CHUNKED_FILE)
 EROFS_FEATURE_FUNCS(device_table, incompat, INCOMPAT_DEVICE_TABLE)
 EROFS_FEATURE_FUNCS(compr_head2, incompat, INCOMPAT_COMPR_HEAD2)
+EROFS_FEATURE_FUNCS(ztailpacking, incompat, INCOMPAT_ZTAILPACKING)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 
 /* atomic flag definitions */
@@ -308,6 +309,9 @@ struct erofs_inode {
 			unsigned short z_advise;
 			unsigned char  z_algorithmtype[2];
 			unsigned char  z_logical_clusterbits;
+			unsigned long  z_tailextent_headlcn;
+			unsigned int   z_idataoff;
+			unsigned short z_idata_size;
 		};
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	};
@@ -421,6 +425,8 @@ struct erofs_map_blocks {
 #define EROFS_GET_BLOCKS_FIEMAP	0x0002
 /* Used to map the whole extent if non-negligible data is requested for LZMA */
 #define EROFS_GET_BLOCKS_READMORE	0x0004
+/* Used to map tail extent for tailpacking inline pcluster */
+#define EROFS_GET_BLOCKS_FINDTAIL	0x0008
 
 enum {
 	Z_EROFS_COMPRESSION_SHIFTED = Z_EROFS_COMPRESSION_MAX,
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 58f381f80205..0724ad5fd6cf 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -411,6 +411,9 @@ static int erofs_read_superblock(struct super_block *sb)
 
 	/* handle multiple devices */
 	ret = erofs_init_devices(sb, dsb);
+
+	if (erofs_sb_has_ztailpacking(sbi))
+		erofs_info(sb, "EXPERIMENTAL compressed inline data feature in use. Use at your own risk!");
 out:
 	kunmap(page);
 	put_page(page);
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index 666693432107..dac252bc9228 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -75,6 +75,7 @@ EROFS_ATTR_FEATURE(chunked_file);
 EROFS_ATTR_FEATURE(device_table);
 EROFS_ATTR_FEATURE(compr_head2);
 EROFS_ATTR_FEATURE(sb_chksum);
+EROFS_ATTR_FEATURE(ztailpacking);
 
 static struct attribute *erofs_feat_attrs[] = {
 	ATTR_LIST(zero_padding),
@@ -84,6 +85,7 @@ static struct attribute *erofs_feat_attrs[] = {
 	ATTR_LIST(device_table),
 	ATTR_LIST(compr_head2),
 	ATTR_LIST(sb_chksum),
+	ATTR_LIST(ztailpacking),
 	NULL,
 };
 ATTRIBUTE_GROUPS(erofs_feat);
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 660489a7fb64..1037ac17b7a6 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -7,12 +7,17 @@
 #include <asm/unaligned.h>
 #include <trace/events/erofs.h>
 
+static int z_erofs_do_map_blocks(struct inode *inode,
+				 struct erofs_map_blocks *map,
+				 int flags);
+
 int z_erofs_fill_inode(struct inode *inode)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
 	struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
 
 	if (!erofs_sb_has_big_pcluster(sbi) &&
+	    !erofs_sb_has_ztailpacking(sbi) &&
 	    vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY) {
 		vi->z_advise = 0;
 		vi->z_algorithmtype[0] = 0;
@@ -51,6 +56,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		goto out_unlock;
 
 	DBG_BUGON(!erofs_sb_has_big_pcluster(EROFS_SB(sb)) &&
+		  !erofs_sb_has_ztailpacking(EROFS_SB(sb)) &&
 		  vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY);
 
 	pos = ALIGN(iloc(EROFS_SB(sb), vi->nid) + vi->inode_isize +
@@ -94,13 +100,34 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		err = -EFSCORRUPTED;
 		goto unmap_done;
 	}
-	/* paired with smp_mb() at the beginning of the function */
-	smp_mb();
-	set_bit(EROFS_I_Z_INITED_BIT, &vi->flags);
 unmap_done:
 	kunmap_atomic(kaddr);
 	unlock_page(page);
 	put_page(page);
+	if (err)
+		goto out_unlock;
+
+	if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER) {
+		struct erofs_map_blocks map = { .mpage = NULL };
+
+		vi->z_idata_size = le16_to_cpu(h->h_idata_size);
+		err = z_erofs_do_map_blocks(inode, &map,
+					    EROFS_GET_BLOCKS_FINDTAIL);
+		if (map.mpage)
+			put_page(map.mpage);
+
+		if (!map.m_plen ||
+		    erofs_blkoff(map.m_pa) + map.m_plen > EROFS_BLKSIZ) {
+			erofs_err(sb, "invalid tail-packing pclustersize %llu",
+				  map.m_plen);
+			err = -EFSCORRUPTED;
+		}
+		if (err < 0)
+			goto out_unlock;
+	}
+	/* paired with smp_mb() at the beginning of the function */
+	smp_mb();
+	set_bit(EROFS_I_Z_INITED_BIT, &vi->flags);
 out_unlock:
 	clear_and_wake_up_bit(EROFS_I_BL_Z_BIT, &vi->flags);
 	return err;
@@ -117,6 +144,7 @@ struct z_erofs_maprecorder {
 	u16 clusterofs;
 	u16 delta[2];
 	erofs_blk_t pblk, compressedlcs;
+	erofs_off_t nextpackoff;
 };
 
 static int z_erofs_reload_indexes(struct z_erofs_maprecorder *m,
@@ -169,6 +197,7 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	if (err)
 		return err;
 
+	m->nextpackoff = pos + sizeof(struct z_erofs_vle_decompressed_index);
 	m->lcn = lcn;
 	di = m->kaddr + erofs_blkoff(pos);
 
@@ -243,12 +272,12 @@ static int get_compacted_la_distance(unsigned int lclusterbits,
 
 static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 				  unsigned int amortizedshift,
-				  unsigned int eofs, bool lookahead)
+				  erofs_off_t pos, bool lookahead)
 {
 	struct erofs_inode *const vi = EROFS_I(m->inode);
 	const unsigned int lclusterbits = vi->z_logical_clusterbits;
 	const unsigned int lomask = (1 << lclusterbits) - 1;
-	unsigned int vcnt, base, lo, encodebits, nblk;
+	unsigned int vcnt, base, lo, encodebits, nblk, eofs;
 	int i;
 	u8 *in, type;
 	bool big_pcluster;
@@ -260,8 +289,12 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	else
 		return -EOPNOTSUPP;
 
+	/* it doesn't equal to round_up(..) */
+	m->nextpackoff = round_down(pos, vcnt << amortizedshift) +
+			 (vcnt << amortizedshift);
 	big_pcluster = vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1;
 	encodebits = ((vcnt << amortizedshift) - sizeof(__le32)) * 8 / vcnt;
+	eofs = erofs_blkoff(pos);
 	base = round_down(eofs, vcnt << amortizedshift);
 	in = m->kaddr + base;
 
@@ -399,8 +432,7 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	err = z_erofs_reload_indexes(m, erofs_blknr(pos));
 	if (err)
 		return err;
-	return unpack_compacted_index(m, amortizedshift, erofs_blkoff(pos),
-				      lookahead);
+	return unpack_compacted_index(m, amortizedshift, pos, lookahead);
 }
 
 static int z_erofs_load_cluster_from_disk(struct z_erofs_maprecorder *m,
@@ -583,11 +615,12 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 	return 0;
 }
 
-int z_erofs_map_blocks_iter(struct inode *inode,
-			    struct erofs_map_blocks *map,
-			    int flags)
+static int z_erofs_do_map_blocks(struct inode *inode,
+				 struct erofs_map_blocks *map,
+				 int flags)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
+	bool ztailpacking = vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER;
 	struct z_erofs_maprecorder m = {
 		.inode = inode,
 		.map = map,
@@ -597,22 +630,8 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 	unsigned long initial_lcn;
 	unsigned long long ofs, end;
 
-	trace_z_erofs_map_blocks_iter_enter(inode, map, flags);
-
-	/* when trying to read beyond EOF, leave it unmapped */
-	if (map->m_la >= inode->i_size) {
-		map->m_llen = map->m_la + 1 - inode->i_size;
-		map->m_la = inode->i_size;
-		map->m_flags = 0;
-		goto out;
-	}
-
-	err = z_erofs_fill_inode_lazy(inode);
-	if (err)
-		goto out;
-
 	lclusterbits = vi->z_logical_clusterbits;
-	ofs = map->m_la;
+	ofs = flags & EROFS_GET_BLOCKS_FINDTAIL ? inode->i_size - 1 : map->m_la;
 	initial_lcn = ofs >> lclusterbits;
 	endoff = ofs & ((1 << lclusterbits) - 1);
 
@@ -620,6 +639,9 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 	if (err)
 		goto unmap_out;
 
+	if (ztailpacking && (flags & EROFS_GET_BLOCKS_FINDTAIL))
+		vi->z_idataoff = m.nextpackoff;
+
 	map->m_flags = EROFS_MAP_MAPPED | EROFS_MAP_ENCODED;
 	end = (m.lcn + 1ULL) << lclusterbits;
 
@@ -659,11 +681,19 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 	}
 
 	map->m_llen = end - map->m_la;
-	map->m_pa = blknr_to_addr(m.pblk);
 
-	err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
-	if (err)
-		goto out;
+	if (flags & EROFS_GET_BLOCKS_FINDTAIL)
+		vi->z_tailextent_headlcn = m.lcn;
+	if (ztailpacking && m.lcn == vi->z_tailextent_headlcn) {
+		map->m_flags |= EROFS_MAP_META;
+		map->m_pa = vi->z_idataoff;
+		map->m_plen = vi->z_idata_size;
+	} else {
+		map->m_pa = blknr_to_addr(m.pblk);
+		err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
+		if (err)
+			goto out;
+	}
 
 	if (m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN)
 		map->m_algorithmformat = Z_EROFS_COMPRESSION_SHIFTED;
@@ -689,6 +719,31 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 		  __func__, map->m_la, map->m_pa,
 		  map->m_llen, map->m_plen, map->m_flags);
 
+	return err;
+}
+
+int z_erofs_map_blocks_iter(struct inode *inode,
+			    struct erofs_map_blocks *map,
+			    int flags)
+{
+	int err = 0;
+
+	trace_z_erofs_map_blocks_iter_enter(inode, map, flags);
+
+	/* when trying to read beyond EOF, leave it unmapped */
+	if (map->m_la >= inode->i_size) {
+		map->m_llen = map->m_la + 1 - inode->i_size;
+		map->m_la = inode->i_size;
+		map->m_flags = 0;
+		goto out;
+	}
+
+	err = z_erofs_fill_inode_lazy(inode);
+	if (err)
+		goto out;
+
+	err = z_erofs_do_map_blocks(inode, map, flags);
+out:
 	trace_z_erofs_map_blocks_iter_exit(inode, map, flags, err);
 
 	/* aggressively BUG_ON iff CONFIG_EROFS_FS_DEBUG is on */
-- 
2.24.4

