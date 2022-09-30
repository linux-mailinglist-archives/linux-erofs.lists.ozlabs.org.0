Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D52A15F0C63
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Sep 2022 15:24:21 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Mf9tW4NzVz3c6C
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Sep 2022 23:24:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ibGVx88R;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=220.181.12.11; helo=m12-11.163.com; envelope-from=zbestahu@163.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ibGVx88R;
	dkim-atps=neutral
X-Greylist: delayed 906 seconds by postgrey-1.36 at boromir; Fri, 30 Sep 2022 23:24:10 AEST
Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Mf9tL6RB9z2xGh
	for <linux-erofs@lists.ozlabs.org>; Fri, 30 Sep 2022 23:24:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=isqZd
	B9r/BqL8rqgj9Syma5ACgYDTSHVlPWNTGNv2IE=; b=ibGVx88RhnnZLvSiwudqA
	8TVBXyHKShP0vIIepmKic7s3QloblDNT+BZCotX6aGMx32otgDBpT8hOrP0+kTGi
	J4+TNEkzqWRXAsFEI78n/rxAEQY8vkO2evdENTxLbyES0OdNn7YQ3XVNO9mdSfWj
	73UIMtgsTKTZ8YeRteSQIo=
Received: from localhost.localdomain (unknown [112.22.168.83])
	by smtp7 (Coremail) with SMTP id C8CowACnVhVc6jZjUv9qIA--.38562S2;
	Fri, 30 Sep 2022 21:08:53 +0800 (CST)
From: Yue Hu <zbestahu@163.com>
To: hsiangkao@linux.alibaba.com
Subject: [PATCH] erofs-utils: lib: support fragments data decompression
Date: Fri, 30 Sep 2022 21:08:42 +0800
Message-Id: <20220930130842.6728-1-zbestahu@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220926152511.94832-3-hsiangkao@linux.alibaba.com>
References: <20220926152511.94832-3-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowACnVhVc6jZjUv9qIA--.38562S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xr1fCry5CrWxGrWrWw4kJFb_yoWfCr1xpF
	1qkFyrCFZYqr9xCrZ7tr1YvFy3Ka9akF4UG34xXw1Sk3WDJry8Jrn0yF9xAFZ8Wrs8WayI
	qa12v345u39rG3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j3OzsUUUUU=
X-Originating-IP: [112.22.168.83]
X-CM-SenderInfo: p2eh23xdkxqiywtou0bp/xtbBLxOMEWHmoXvIaQABsc
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, ZiyangZhang@linux.alibaba.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

Add compressed fragments support for erofsfuse.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
changes: fix an issue with fragments=4K

 include/erofs/internal.h |  6 ++++++
 include/erofs_fs.h       | 26 +++++++++++++++++------
 lib/data.c               | 19 +++++++++++++++++
 lib/super.c              |  1 +
 lib/zmap.c               | 45 +++++++++++++++++++++++++++++++++++++---
 5 files changed, 88 insertions(+), 9 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index a4a1fe3..dd3776c 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -102,6 +102,7 @@ struct erofs_sb_info {
 		u16 devt_slotoff;		/* used for mkfs */
 		u16 device_id_mask;		/* used for others */
 	};
+	erofs_nid_t packed_nid;
 };
 
 /* global sbi */
@@ -132,6 +133,7 @@ EROFS_FEATURE_FUNCS(big_pcluster, incompat, INCOMPAT_BIG_PCLUSTER)
 EROFS_FEATURE_FUNCS(chunked_file, incompat, INCOMPAT_CHUNKED_FILE)
 EROFS_FEATURE_FUNCS(device_table, incompat, INCOMPAT_DEVICE_TABLE)
 EROFS_FEATURE_FUNCS(ztailpacking, incompat, INCOMPAT_ZTAILPACKING)
+EROFS_FEATURE_FUNCS(fragments, incompat, INCOMPAT_FRAGMENTS)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 
 #define EROFS_I_EA_INITED	(1 << 0)
@@ -209,6 +211,7 @@ struct erofs_inode {
 #ifdef WITH_ANDROID
 	uint64_t capabilities;
 #endif
+	erofs_off_t fragmentoff;
 };
 
 static inline bool is_inode_layout_compression(struct erofs_inode *inode)
@@ -279,6 +282,7 @@ enum {
 	BH_Mapped,
 	BH_Encoded,
 	BH_FullMapped,
+	BH_Fragment,
 };
 
 /* Has a disk mapping */
@@ -289,6 +293,8 @@ enum {
 #define EROFS_MAP_ENCODED	(1 << BH_Encoded)
 /* The length of extent is full */
 #define EROFS_MAP_FULL_MAPPED	(1 << BH_FullMapped)
+/* Located in the special packed inode */
+#define EROFS_MAP_FRAGMENT	(1 << BH_Fragment)
 
 struct erofs_map_blocks {
 	char mpage[EROFS_BLKSIZ];
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index b8a7421..e492ad9 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -25,13 +25,15 @@
 #define EROFS_FEATURE_INCOMPAT_CHUNKED_FILE	0x00000004
 #define EROFS_FEATURE_INCOMPAT_DEVICE_TABLE	0x00000008
 #define EROFS_FEATURE_INCOMPAT_ZTAILPACKING	0x00000010
+#define EROFS_FEATURE_INCOMPAT_FRAGMENTS	0x00000020
 #define EROFS_ALL_FEATURE_INCOMPAT		\
 	(EROFS_FEATURE_INCOMPAT_LZ4_0PADDING | \
 	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
 	 EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER | \
 	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE | \
 	 EROFS_FEATURE_INCOMPAT_DEVICE_TABLE | \
-	 EROFS_FEATURE_INCOMPAT_ZTAILPACKING)
+	 EROFS_FEATURE_INCOMPAT_ZTAILPACKING | \
+	 EROFS_FEATURE_INCOMPAT_FRAGMENTS)
 
 #define EROFS_SB_EXTSLOT_SIZE	16
 
@@ -73,7 +75,9 @@ struct erofs_super_block {
 	} __packed u1;
 	__le16 extra_devices;	/* # of devices besides the primary device */
 	__le16 devt_slotoff;	/* startoff = devt_slotoff * devt_slotsize */
-	__u8 reserved2[38];
+	__u8 reserved[6];
+	__le64 packed_nid;	/* nid of the special packed inode */
+	__u8 reserved2[24];
 };
 
 /*
@@ -295,17 +299,26 @@ struct z_erofs_lzma_cfgs {
  * bit 2 : HEAD2 big pcluster (0 - off; 1 - on)
  * bit 3 : tailpacking inline pcluster (0 - off; 1 - on)
  * bit 4 : interlaced plain pcluster (0 - off; 1 - on)
+ * bit 5 : fragment pcluster (0 - off; 1 - on)
  */
 #define Z_EROFS_ADVISE_COMPACTED_2B		0x0001
 #define Z_EROFS_ADVISE_BIG_PCLUSTER_1		0x0002
 #define Z_EROFS_ADVISE_BIG_PCLUSTER_2		0x0004
 #define Z_EROFS_ADVISE_INLINE_PCLUSTER		0x0008
 #define Z_EROFS_ADVISE_INTERLACED_PCLUSTER	0x0010
+#define Z_EROFS_ADVISE_FRAGMENT_PCLUSTER	0x0020
 
+#define Z_EROFS_FRAGMENT_INODE_BIT		7
 struct z_erofs_map_header {
-	__le16	h_reserved1;
-	/* record the size of tailpacking data */
-	__le16  h_idata_size;
+	union {
+		/* direct addressing for fragment offset */
+		__le32	h_fragmentoff;
+		struct {
+			__le16  h_reserved1;
+			/* record the size of tailpacking data */
+			__le16	h_idata_size;
+		};
+	};
 	__le16	h_advise;
 	/*
 	 * bit 0-3 : algorithm type of head 1 (logical cluster type 01);
@@ -314,7 +327,8 @@ struct z_erofs_map_header {
 	__u8	h_algorithmtype;
 	/*
 	 * bit 0-2 : logical cluster bits - 12, e.g. 0 for 4096;
-	 * bit 3-7 : reserved.
+	 * bit 3-6 : reserved;
+	 * bit 7   : move the whole file into packed inode or not.
 	 */
 	__u8	h_clusterbits;
 };
diff --git a/lib/data.c b/lib/data.c
index af52fde..bcb0f7e 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -275,6 +275,25 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 			continue;
 		}
 
+		if (map.m_flags & EROFS_MAP_FRAGMENT) {
+			struct erofs_inode packed_inode = {
+				.nid = sbi.packed_nid,
+			};
+
+			ret = erofs_read_inode_from_disk(&packed_inode);
+			if (ret) {
+				erofs_err("failed to read packed inode from disk");
+				return ret;
+			}
+
+			ret = z_erofs_read_data(&packed_inode,
+					buffer + end - offset, length - skip,
+					inode->fragmentoff + skip);
+			if (ret < 0)
+				break;
+			continue;
+		}
+
 		if (map.m_plen > bufsize) {
 			bufsize = map.m_plen;
 			raw = realloc(raw, bufsize);
diff --git a/lib/super.c b/lib/super.c
index b267412..30aeb36 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -104,6 +104,7 @@ int erofs_read_superblock(void)
 	sbi.xattr_blkaddr = le32_to_cpu(dsb->xattr_blkaddr);
 	sbi.islotbits = EROFS_ISLOTBITS;
 	sbi.root_nid = le16_to_cpu(dsb->root_nid);
+	sbi.packed_nid = le64_to_cpu(dsb->packed_nid);
 	sbi.inos = le64_to_cpu(dsb->inos);
 	sbi.checksum = le32_to_cpu(dsb->checksum);
 
diff --git a/lib/zmap.c b/lib/zmap.c
index 806d608..1ba7c2f 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -17,7 +17,7 @@ static int z_erofs_do_map_blocks(struct erofs_inode *vi,
 int z_erofs_fill_inode(struct erofs_inode *vi)
 {
 	if (!erofs_sb_has_big_pcluster() &&
-	    !erofs_sb_has_ztailpacking() &&
+	    !erofs_sb_has_ztailpacking() && !erofs_sb_has_fragments() &&
 	    vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY) {
 		vi->z_advise = 0;
 		vi->z_algorithmtype[0] = 0;
@@ -40,7 +40,7 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 		return 0;
 
 	DBG_BUGON(!erofs_sb_has_big_pcluster() &&
-		  !erofs_sb_has_ztailpacking() &&
+		  !erofs_sb_has_ztailpacking() && !erofs_sb_has_fragments() &&
 		  vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY);
 	pos = round_up(iloc(vi->nid) + vi->inode_isize + vi->xattr_isize, 8);
 
@@ -49,6 +49,17 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 		return -EIO;
 
 	h = (struct z_erofs_map_header *)buf;
+	/*
+	 * if the highest bit of the 8-byte map header is set, the whole file
+	 * is stored in the packed inode. The rest bits keeps z_fragmentoff.
+	 */
+	if (h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT) {
+		vi->z_advise = Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
+		vi->fragmentoff = le64_to_cpu(*(__le64 *)h) ^ (1ULL << 63);
+		vi->z_tailextent_headlcn = 0;
+		goto out;
+	}
+
 	vi->z_advise = le16_to_cpu(h->h_advise);
 	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
 	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
@@ -83,6 +94,17 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 		if (ret < 0)
 			return ret;
 	}
+	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER &&
+	    !(h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT)) {
+		struct erofs_map_blocks map = { .index = UINT_MAX };
+
+		vi->fragmentoff = le32_to_cpu(h->h_fragmentoff);
+		ret = z_erofs_do_map_blocks(vi, &map,
+					    EROFS_GET_BLOCKS_FINDTAIL);
+		if (ret < 0)
+			return ret;
+	}
+out:
 	vi->flags |= EROFS_I_Z_INITED;
 	return 0;
 }
@@ -546,6 +568,7 @@ static int z_erofs_do_map_blocks(struct erofs_inode *vi,
 				 int flags)
 {
 	bool ztailpacking = vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER;
+	bool fragment = vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
 	struct z_erofs_maprecorder m = {
 		.inode = vi,
 		.map = map,
@@ -603,12 +626,19 @@ static int z_erofs_do_map_blocks(struct erofs_inode *vi,
 	}
 
 	map->m_llen = end - map->m_la;
-	if (flags & EROFS_GET_BLOCKS_FINDTAIL)
+	if (flags & EROFS_GET_BLOCKS_FINDTAIL) {
 		vi->z_tailextent_headlcn = m.lcn;
+		/* for non-compact indexes, fragmentoff is 64 bits */
+		if (fragment &&
+		    vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY)
+			vi->fragmentoff |= (u64)m.pblk << 32;
+	}
 	if (ztailpacking && m.lcn == vi->z_tailextent_headlcn) {
 		map->m_flags |= EROFS_MAP_META;
 		map->m_pa = vi->z_idataoff;
 		map->m_plen = vi->z_idata_size;
+	} else if (fragment && m.lcn == vi->z_tailextent_headlcn) {
+		map->m_flags |= EROFS_MAP_FRAGMENT;
 	} else {
 		map->m_pa = blknr_to_addr(m.pblk);
 		err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
@@ -658,6 +688,15 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 	if (err)
 		goto out;
 
+	if ((vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER) &&
+	    !vi->z_tailextent_headlcn) {
+		map->m_la = 0;
+		map->m_llen = vi->i_size;
+		map->m_flags = EROFS_MAP_MAPPED | EROFS_MAP_FULL_MAPPED |
+				EROFS_MAP_FRAGMENT;
+		goto out;
+	}
+
 	err = z_erofs_do_map_blocks(vi, map, flags);
 out:
 	DBG_BUGON(err < 0 && err != -ENOMEM);
-- 
2.25.1

