Return-Path: <linux-erofs+bounces-586-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 781A6B0183E
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Jul 2025 11:40:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bdmsd5Hyqz30VF;
	Fri, 11 Jul 2025 19:40:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.51.61.248
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752226821;
	cv=none; b=P7Ij8sM8JO5U4yu5r3B189iHtV2Aap9l2PSlzCx+zckBU4x5kdKT6oSz1N02l8HoQoXCumH9vy1h2gIFnka4NkN8yBAOtAYs3eil3Pt99UdFmpeWgMVLF4MYMsRhzbveoxcDc8+3UrWCqHtIWQmSNftDwCyeiC2WjQLfAl8FaQm73FSHb2aAyiNzgjDqzC/9DniTJTndOW7TsCVal6QnGrq56ijkvx693SHyYO4m2is8y3HeqxoS768yo999iJQpxVSs802w4U0YS3EG4wRodYSG1b6tyHFpeyV3O/0rPIq9lF2RLpZRQnIfDtqoSvXO793gXYebs5cQ9qFla0Tsow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752226821; c=relaxed/relaxed;
	bh=V70aE2eeqVBBy4QoSv0zhQ5KnDZLaIzZxpB85gpoxy8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IZvvKsBCZJd+1ucwPD+EDXzlb2gTzTo8J77z/gbByb6r1J3OoPXUAFUxrtrdijG1Eb4eNojyZ9/gaD//rc8od7KAhDbXfxrFLWx0cjvb63ur6X5u2To5L1rf7lPjw+PzxMNZUFrWVaqu+wYFgSrvpkKOKO7IHtcKhCTaQCSuZI7MEwm5Bf9MHC8zxv/oG3feAGGW1JpG5L7hyLe55KdL09/pl3YIREf8dwOGEjL+jjrHux5ChIdzXpGdsiAFpVdg2ZBI4Cmn6+UW81KV8pL5eAkP9TQ3NdBt0tbgIJJYspgZ9bxXKjPDB6Kf/C7RJOJk4ZvVkI+dHeCuFtPTEfLEWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass (client-ip=210.51.61.248; helo=ssh248.corpemail.net; envelope-from=liubo03@inspur.com; receiver=lists.ozlabs.org) smtp.mailfrom=inspur.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=inspur.com (client-ip=210.51.61.248; helo=ssh248.corpemail.net; envelope-from=liubo03@inspur.com; receiver=lists.ozlabs.org)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bdmsb334mz2yF0
	for <linux-erofs@lists.ozlabs.org>; Fri, 11 Jul 2025 19:40:15 +1000 (AEST)
Received: from jtjnmail201609.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202507111740078171;
        Fri, 11 Jul 2025 17:40:07 +0800
Received: from localhost.localdomain (10.94.8.17) by
 jtjnmail201609.home.langchao.com (10.100.2.9) with Microsoft SMTP Server id
 15.1.2507.57; Fri, 11 Jul 2025 17:40:06 +0800
From: Bo Liu <liubo03@inspur.com>
To: <xiang@kernel.org>, <chao@kernel.org>
CC: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH v2] erofs: support metadata compression
Date: Fri, 11 Jul 2025 05:40:04 -0400
Message-ID: <20250711094004.2488-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.94.8.17]
tUid: 20257111740078f0707587b4bcc90f8c608bd3faeac26
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=0.0 required=3.0 tests=RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Filesystem metadata has a high degree of redundancy, so
should compress well in the general case.
To implement this feature, we make a special on-disk inode
which keeps all metadata as its data, and then compress the
special on-disk inode with the given algorithm.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
v1: https://lore.kernel.org/linux-erofs/00fc488bbdd1489ca94f4d0bcd416403@inspur.com/T/#t

change since v1:
- add a check to determine if the bit 63 of nid is set

---
 fs/erofs/data.c              | 20 ++++++++++++--------
 fs/erofs/decompressor.c      |  2 +-
 fs/erofs/erofs_fs.h          |  4 +++-
 fs/erofs/fileio.c            |  2 +-
 fs/erofs/fscache.c           |  2 +-
 fs/erofs/inode.c             |  9 +++++----
 fs/erofs/internal.h          | 27 +++++++++++++++++++++++----
 fs/erofs/super.c             | 14 ++++++++++++--
 fs/erofs/sysfs.c             |  2 ++
 fs/erofs/xattr.c             | 29 +++++++++++++++++++++++------
 fs/erofs/zdata.c             |  2 +-
 fs/erofs/zmap.c              | 24 ++++++++++++++----------
 include/trace/events/erofs.h |  7 +++++--
 13 files changed, 103 insertions(+), 41 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 6a329c329f43..4699bfc6ff2a 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -49,13 +49,16 @@ void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset, bool need_kmap)
 	return buf->base + (offset & ~PAGE_MASK);
 }
 
-void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
+void erofs_init_metabuf(struct erofs_buf *buf,
+			struct super_block *sb, bool meta_compr)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
 	buf->file = NULL;
 	buf->off = sbi->dif0.fsoff;
-	if (erofs_is_fileio_mode(sbi)) {
+	if (meta_compr)
+		buf->mapping = sbi->meta_inode->i_mapping;
+	else if (erofs_is_fileio_mode(sbi)) {
 		buf->file = sbi->dif0.file;	/* some fs like FUSE needs it */
 		buf->mapping = buf->file->f_mapping;
 	} else if (erofs_is_fscache_mode(sb))
@@ -65,9 +68,9 @@ void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
 }
 
 void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
-			 erofs_off_t offset, bool need_kmap)
+			 erofs_off_t offset, bool need_kmap, bool meta_compr)
 {
-	erofs_init_metabuf(buf, sb);
+	erofs_init_metabuf(buf, sb, meta_compr);
 	return erofs_bread(buf, offset, need_kmap);
 }
 
@@ -83,6 +86,7 @@ int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
 	erofs_off_t pos;
 	u64 chunknr;
 	int err = 0;
+	bool meta_compr = false;
 
 	trace_erofs_map_blocks_enter(inode, map, 0);
 	map->m_deviceid = 0;
@@ -101,7 +105,7 @@ int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
 			map->m_pa = erofs_pos(sb, vi->startblk) + map->m_la;
 			map->m_llen = pos - map->m_la;
 		} else {
-			map->m_pa = erofs_iloc(inode) + vi->inode_isize +
+			map->m_pa = erofs_iloc(inode, &meta_compr) + vi->inode_isize +
 				vi->xattr_isize + erofs_blkoff(sb, map->m_la);
 			map->m_llen = inode->i_size - map->m_la;
 			map->m_flags |= EROFS_MAP_META;
@@ -115,10 +119,10 @@ int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
 		unit = EROFS_BLOCK_MAP_ENTRY_SIZE;	/* block map */
 
 	chunknr = map->m_la >> vi->chunkbits;
-	pos = ALIGN(erofs_iloc(inode) + vi->inode_isize +
+	pos = ALIGN(erofs_iloc(inode, &meta_compr) + vi->inode_isize +
 		    vi->xattr_isize, unit) + unit * chunknr;
 
-	idx = erofs_read_metabuf(&buf, sb, pos, true);
+	idx = erofs_read_metabuf(&buf, sb, pos, true, meta_compr);
 	if (IS_ERR(idx)) {
 		err = PTR_ERR(idx);
 		goto out;
@@ -293,7 +297,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 
 		iomap->type = IOMAP_INLINE;
-		ptr = erofs_read_metabuf(&buf, sb, mdev.m_pa, true);
+		ptr = erofs_read_metabuf(&buf, sb, mdev.m_pa, true, false);
 		if (IS_ERR(ptr))
 			return PTR_ERR(ptr);
 		iomap->inline_data = ptr;
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index bf62e2836b60..e15f39f0769d 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -471,7 +471,7 @@ int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb)
 		return -EOPNOTSUPP;
 	}
 
-	erofs_init_metabuf(&buf, sb);
+	erofs_init_metabuf(&buf, sb, false);
 	offset = EROFS_SUPER_OFFSET + sbi->sb_size;
 	alg = 0;
 	for (algs = sbi->available_compr_algs; algs; algs >>= 1, ++alg) {
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 767fb4acdc93..9294ff3dabd6 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -15,6 +15,7 @@
 #define EROFS_FEATURE_COMPAT_SB_CHKSUM          0x00000001
 #define EROFS_FEATURE_COMPAT_MTIME              0x00000002
 #define EROFS_FEATURE_COMPAT_XATTR_FILTER	0x00000004
+#define EROFS_FEATURE_COMPAT_XATTR_COMPR	0x00000008
 
 /*
  * Any bits that aren't in EROFS_ALL_FEATURE_INCOMPAT should
@@ -31,6 +32,7 @@
 #define EROFS_FEATURE_INCOMPAT_DEDUPE		0x00000020
 #define EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES	0x00000040
 #define EROFS_FEATURE_INCOMPAT_48BIT		0x00000080
+#define EROFS_FEATURE_INCOMPAT_META_COMPR	0X00000100
 #define EROFS_ALL_FEATURE_INCOMPAT		\
 	((EROFS_FEATURE_INCOMPAT_48BIT << 1) - 1)
 
@@ -82,7 +84,7 @@ struct erofs_super_block {
 	__u8 reserved[3];
 	__le32 build_time;	/* seconds added to epoch for mkfs time */
 	__le64 rootnid_8b;	/* (48BIT on) nid of root directory */
-	__u8 reserved2[8];
+	__le64 meta_nid;	/* meta data nid */
 };
 
 /*
diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index df5cc63f2c01..89229ef171b4 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -117,7 +117,7 @@ static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
 			void *src;
 
 			src = erofs_read_metabuf(&buf, inode->i_sb,
-						 map->m_pa + ofs, true);
+						 map->m_pa + ofs, true, false);
 			if (IS_ERR(src)) {
 				err = PTR_ERR(src);
 				break;
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 34517ca9df91..f33a782af74b 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -274,7 +274,7 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_rq *req)
 		size_t size = map.m_llen;
 		void *src;
 
-		src = erofs_read_metabuf(&buf, sb, map.m_pa, true);
+		src = erofs_read_metabuf(&buf, sb, map.m_pa, true, false);
 		if (IS_ERR(src))
 			return PTR_ERR(src);
 
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index a0ae0b4f7b01..8f4fe3dd1e9a 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -27,8 +27,9 @@ static int erofs_fill_symlink(struct inode *inode, void *kaddr,
 static int erofs_read_inode(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
-	erofs_blk_t blkaddr = erofs_blknr(sb, erofs_iloc(inode));
-	unsigned int ofs = erofs_blkoff(sb, erofs_iloc(inode));
+	bool meta_compr = false;
+	erofs_blk_t blkaddr = erofs_blknr(sb, erofs_iloc(inode, &meta_compr));
+	unsigned int ofs = erofs_blkoff(sb, erofs_iloc(inode, &meta_compr));
 	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	erofs_blk_t addrmask = BIT_ULL(48) - 1;
@@ -39,7 +40,7 @@ static int erofs_read_inode(struct inode *inode)
 	void *ptr;
 	int err = 0;
 
-	ptr = erofs_read_metabuf(&buf, sb, erofs_pos(sb, blkaddr), true);
+	ptr = erofs_read_metabuf(&buf, sb, erofs_pos(sb, blkaddr), true, meta_compr);
 	if (IS_ERR(ptr)) {
 		err = PTR_ERR(ptr);
 		erofs_err(sb, "failed to get inode (nid: %llu) page, err %d",
@@ -78,7 +79,7 @@ static int erofs_read_inode(struct inode *inode)
 
 			memcpy(&copied, dic, gotten);
 			ptr = erofs_read_metabuf(&buf, sb,
-					erofs_pos(sb, blkaddr + 1), true);
+					erofs_pos(sb, blkaddr + 1), true, meta_compr);
 			if (IS_ERR(ptr)) {
 				err = PTR_ERR(ptr);
 				erofs_err(sb, "failed to get inode payload block (nid: %llu), err %d",
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index a32c03a80c70..e853f916566c 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -125,6 +125,7 @@ struct erofs_sb_info {
 	struct erofs_sb_lz4_info lz4;
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	struct inode *packed_inode;
+	struct inode *meta_inode;
 	struct erofs_dev_context *devs;
 	u64 total_blocks;
 
@@ -148,6 +149,7 @@ struct erofs_sb_info {
 	/* what we really care is nid, rather than ino.. */
 	erofs_nid_t root_nid;
 	erofs_nid_t packed_nid;
+	erofs_nid_t meta_nid;
 	/* used for statfs, f_files - f_favail */
 	u64 inos;
 
@@ -227,8 +229,10 @@ EROFS_FEATURE_FUNCS(fragments, incompat, INCOMPAT_FRAGMENTS)
 EROFS_FEATURE_FUNCS(dedupe, incompat, INCOMPAT_DEDUPE)
 EROFS_FEATURE_FUNCS(xattr_prefixes, incompat, INCOMPAT_XATTR_PREFIXES)
 EROFS_FEATURE_FUNCS(48bit, incompat, INCOMPAT_48BIT)
+EROFS_FEATURE_FUNCS(meta_compr, incompat, INCOMPAT_META_COMPR)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
+EROFS_FEATURE_FUNCS(xattr_compr, compat, COMPAT_XATTR_COMPR)
 
 /* atomic flag definitions */
 #define EROFS_I_EA_INITED_BIT	0
@@ -279,12 +283,26 @@ struct erofs_inode {
 
 #define EROFS_I(ptr)	container_of(ptr, struct erofs_inode, vfs_inode)
 
-static inline erofs_off_t erofs_iloc(struct inode *inode)
+static inline bool erofs_is_metacompr_mode(struct inode *inode)
+{
+	return EROFS_I(inode)->nid >> 63;
+}
+
+static inline erofs_off_t erofs_iloc(struct inode *inode, bool *meta_compr)
 {
 	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
+	erofs_nid_t nid;
+
+	if (erofs_is_metacompr_mode(inode)) {
+		*meta_compr = true;
+		nid = EROFS_I(inode)->nid & ~(0x1ULL << 63);
+	} else {
+		*meta_compr = false;
+		nid = EROFS_I(inode)->nid;
+	}
 
 	return erofs_pos(inode->i_sb, sbi->meta_blkaddr) +
-		(EROFS_I(inode)->nid << sbi->islotbits);
+			(nid << sbi->islotbits);
 }
 
 static inline unsigned int erofs_inode_version(unsigned int ifmt)
@@ -381,9 +399,10 @@ void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
 void erofs_unmap_metabuf(struct erofs_buf *buf);
 void erofs_put_metabuf(struct erofs_buf *buf);
 void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset, bool need_kmap);
-void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb);
+void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb,
+			bool meta_compr);
 void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
-			 erofs_off_t offset, bool need_kmap);
+			 erofs_off_t offset, bool need_kmap, bool meta_compr);
 int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *dev);
 int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		 u64 start, u64 len);
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index e1e9f06e8342..434dec1cbd1b 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -141,7 +141,7 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 	struct erofs_deviceslot *dis;
 	struct file *file;
 
-	dis = erofs_read_metabuf(buf, sb, *pos, true);
+	dis = erofs_read_metabuf(buf, sb, *pos, true, false);
 	if (IS_ERR(dis))
 		return PTR_ERR(dis);
 
@@ -258,7 +258,7 @@ static int erofs_read_superblock(struct super_block *sb)
 	void *data;
 	int ret;
 
-	data = erofs_read_metabuf(&buf, sb, 0, true);
+	data = erofs_read_metabuf(&buf, sb, 0, true, false);
 	if (IS_ERR(data)) {
 		erofs_err(sb, "cannot read erofs superblock");
 		return PTR_ERR(data);
@@ -324,6 +324,7 @@ static int erofs_read_superblock(struct super_block *sb)
 	sbi->epoch = (s64)le64_to_cpu(dsb->epoch);
 	sbi->fixed_nsec = le32_to_cpu(dsb->fixed_nsec);
 	super_set_uuid(sb, (void *)dsb->uuid, sizeof(dsb->uuid));
+	sbi->meta_nid = le64_to_cpu(dsb->meta_nid);
 
 	/* parse on-disk compression configurations */
 	ret = z_erofs_parse_cfgs(sb, dsb);
@@ -691,6 +692,13 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 		sbi->packed_inode = inode;
 	}
 
+	if (erofs_sb_has_meta_compr(sbi) && sbi->meta_nid) {
+		inode = erofs_iget(sb, sbi->meta_nid);
+		if (IS_ERR(inode))
+			return PTR_ERR(inode);
+		sbi->meta_inode = inode;
+	}
+
 	inode = erofs_iget(sb, sbi->root_nid);
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
@@ -845,6 +853,8 @@ static void erofs_drop_internal_inodes(struct erofs_sb_info *sbi)
 {
 	iput(sbi->packed_inode);
 	sbi->packed_inode = NULL;
+	iput(sbi->meta_inode);
+	sbi->meta_inode = NULL;
 #ifdef CONFIG_EROFS_FS_ZIP
 	iput(sbi->managed_cache);
 	sbi->managed_cache = NULL;
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index eed8797a193f..0f65fe8204be 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -95,6 +95,7 @@ EROFS_ATTR_FEATURE(ztailpacking);
 EROFS_ATTR_FEATURE(fragments);
 EROFS_ATTR_FEATURE(dedupe);
 EROFS_ATTR_FEATURE(48bit);
+EROFS_ATTR_FEATURE(meta_compr);
 
 static struct attribute *erofs_feat_attrs[] = {
 	ATTR_LIST(zero_padding),
@@ -108,6 +109,7 @@ static struct attribute *erofs_feat_attrs[] = {
 	ATTR_LIST(fragments),
 	ATTR_LIST(dedupe),
 	ATTR_LIST(48bit),
+	ATTR_LIST(meta_compr),
 	NULL,
 };
 ATTRIBUTE_GROUPS(erofs_feat);
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 9cf84717a92e..1c2659e3a2ce 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -33,6 +33,7 @@ static int erofs_init_inode_xattrs(struct inode *inode)
 	struct erofs_xattr_ibody_header *ih;
 	struct super_block *sb = inode->i_sb;
 	int ret = 0;
+	bool meta_compr = false;
 
 	/* the most case is that xattrs of this inode are initialized. */
 	if (test_bit(EROFS_I_EA_INITED_BIT, &vi->flags)) {
@@ -77,8 +78,10 @@ static int erofs_init_inode_xattrs(struct inode *inode)
 	}
 
 	it.buf = __EROFS_BUF_INITIALIZER;
-	erofs_init_metabuf(&it.buf, sb);
-	it.pos = erofs_iloc(inode) + vi->inode_isize;
+	it.pos = erofs_iloc(inode, &meta_compr) + vi->inode_isize;
+	if (!erofs_is_metacompr_mode(inode))
+		meta_compr = false;
+	erofs_init_metabuf(&it.buf, sb, meta_compr);
 
 	/* read in shared xattr array (non-atomic, see kmalloc below) */
 	it.kaddr = erofs_bread(&it.buf, it.pos, true);
@@ -318,6 +321,7 @@ static int erofs_xattr_iter_inline(struct erofs_xattr_iter *it,
 	unsigned int xattr_header_sz, remaining, entry_sz;
 	erofs_off_t next_pos;
 	int ret;
+	bool meta_compr = false;
 
 	xattr_header_sz = sizeof(struct erofs_xattr_ibody_header) +
 			  sizeof(u32) * vi->xattr_shared_count;
@@ -327,7 +331,7 @@ static int erofs_xattr_iter_inline(struct erofs_xattr_iter *it,
 	}
 
 	remaining = vi->xattr_isize - xattr_header_sz;
-	it->pos = erofs_iloc(inode) + vi->inode_isize + xattr_header_sz;
+	it->pos = erofs_iloc(inode, &meta_compr) + vi->inode_isize + xattr_header_sz;
 
 	while (remaining) {
 		it->kaddr = erofs_bread(&it->buf, it->pos, true);
@@ -389,6 +393,7 @@ int erofs_getxattr(struct inode *inode, int index, const char *name,
 	struct erofs_xattr_iter it;
 	struct erofs_inode *vi = EROFS_I(inode);
 	struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
+	bool meta_compr = false;
 
 	if (!name)
 		return -EINVAL;
@@ -411,9 +416,12 @@ int erofs_getxattr(struct inode *inode, int index, const char *name,
 	if (it.name.len > EROFS_NAME_LEN)
 		return -ERANGE;
 
+	if (erofs_sb_has_xattr_compr(sbi))
+		meta_compr = erofs_is_metacompr_mode(inode);
+
 	it.sb = inode->i_sb;
 	it.buf = __EROFS_BUF_INITIALIZER;
-	erofs_init_metabuf(&it.buf, it.sb);
+	erofs_init_metabuf(&it.buf, it.sb, meta_compr);
 	it.buffer = buffer;
 	it.buffer_size = buffer_size;
 	it.buffer_ofs = 0;
@@ -430,16 +438,21 @@ ssize_t erofs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 	int ret;
 	struct erofs_xattr_iter it;
 	struct inode *inode = d_inode(dentry);
+	struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
+	bool meta_compr = false;
 
 	ret = erofs_init_inode_xattrs(inode);
 	if (ret == -ENOATTR)
 		return 0;
 	if (ret)
+
 		return ret;
+	if (erofs_sb_has_xattr_compr(sbi))
+		meta_compr = erofs_is_metacompr_mode(inode);
 
 	it.sb = dentry->d_sb;
 	it.buf = __EROFS_BUF_INITIALIZER;
-	erofs_init_metabuf(&it.buf, it.sb);
+	erofs_init_metabuf(&it.buf, it.sb, meta_compr);
 	it.dentry = dentry;
 	it.buffer = buffer;
 	it.buffer_size = buffer_size;
@@ -474,6 +487,7 @@ int erofs_xattr_prefixes_init(struct super_block *sb)
 	erofs_off_t pos = (erofs_off_t)sbi->xattr_prefix_start << 2;
 	struct erofs_xattr_prefix_item *pfs;
 	int ret = 0, i, len;
+	bool meta_compr = false;
 
 	if (!sbi->xattr_prefix_count)
 		return 0;
@@ -482,10 +496,13 @@ int erofs_xattr_prefixes_init(struct super_block *sb)
 	if (!pfs)
 		return -ENOMEM;
 
+	if (erofs_sb_has_xattr_compr(sbi) && sbi->meta_inode)
+		meta_compr = true;
+
 	if (sbi->packed_inode)
 		buf.mapping = sbi->packed_inode->i_mapping;
 	else
-		erofs_init_metabuf(&buf, sb);
+		erofs_init_metabuf(&buf, sb, meta_compr);
 
 	for (i = 0; i < sbi->xattr_prefix_count; i++) {
 		void *ptr = erofs_read_metadata(sb, &buf, &pos, &len);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index d80e3bf4fa79..cf0111ecbd94 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -855,7 +855,7 @@ static int z_erofs_pcluster_begin(struct z_erofs_frontend *fe)
 		/* bind cache first when cached decompression is preferred */
 		z_erofs_bind_cache(fe);
 	} else {
-		ptr = erofs_read_metabuf(&map->buf, sb, map->m_pa, false);
+		ptr = erofs_read_metabuf(&map->buf, sb, map->m_pa, false, false);
 		if (IS_ERR(ptr)) {
 			ret = PTR_ERR(ptr);
 			erofs_err(sb, "failed to get inline data %d", ret);
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 0bebc6e3a4d7..ea8670953b0d 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -24,14 +24,15 @@ static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
 				      unsigned long lcn)
 {
 	struct inode *const inode = m->inode;
+	bool meta_compr = false;
 	struct erofs_inode *const vi = EROFS_I(inode);
-	const erofs_off_t pos = Z_EROFS_FULL_INDEX_START(erofs_iloc(inode) +
+	const erofs_off_t pos = Z_EROFS_FULL_INDEX_START(erofs_iloc(inode, &meta_compr) +
 			vi->inode_isize + vi->xattr_isize) +
 			lcn * sizeof(struct z_erofs_lcluster_index);
 	struct z_erofs_lcluster_index *di;
 	unsigned int advise;
 
-	di = erofs_read_metabuf(&m->map->buf, inode->i_sb, pos, true);
+	di = erofs_read_metabuf(&m->map->buf, inode->i_sb, pos, true, meta_compr);
 	if (IS_ERR(di))
 		return PTR_ERR(di);
 	m->lcn = lcn;
@@ -102,7 +103,8 @@ static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
 {
 	struct inode *const inode = m->inode;
 	struct erofs_inode *const vi = EROFS_I(inode);
-	const erofs_off_t ebase = Z_EROFS_MAP_HEADER_END(erofs_iloc(inode) +
+	bool meta_compr = false;
+	const erofs_off_t ebase = Z_EROFS_MAP_HEADER_END(erofs_iloc(inode, &meta_compr) +
 			vi->inode_isize + vi->xattr_isize);
 	const unsigned int lclusterbits = vi->z_lclusterbits;
 	const unsigned int totalidx = erofs_iblks(inode);
@@ -146,7 +148,7 @@ static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
 	else
 		return -EOPNOTSUPP;
 
-	in = erofs_read_metabuf(&m->map->buf, m->inode->i_sb, pos, true);
+	in = erofs_read_metabuf(&m->map->buf, m->inode->i_sb, pos, true, meta_compr);
 	if (IS_ERR(in))
 		return PTR_ERR(in);
 
@@ -540,8 +542,9 @@ static int z_erofs_map_blocks_ext(struct inode *inode,
 	struct erofs_inode *vi = EROFS_I(inode);
 	struct super_block *sb = inode->i_sb;
 	bool interlaced = vi->z_advise & Z_EROFS_ADVISE_INTERLACED_PCLUSTER;
+	bool meta_compr = false;
 	unsigned int recsz = z_erofs_extent_recsize(vi->z_advise);
-	erofs_off_t pos = round_up(Z_EROFS_MAP_HEADER_END(erofs_iloc(inode) +
+	erofs_off_t pos = round_up(Z_EROFS_MAP_HEADER_END(erofs_iloc(inode, &meta_compr) +
 				   vi->inode_isize + vi->xattr_isize), recsz);
 	erofs_off_t lend = inode->i_size;
 	erofs_off_t l, r, mid, pa, la, lstart;
@@ -552,7 +555,7 @@ static int z_erofs_map_blocks_ext(struct inode *inode,
 	map->m_flags = 0;
 	if (recsz <= offsetof(struct z_erofs_extent, pstart_hi)) {
 		if (recsz <= offsetof(struct z_erofs_extent, pstart_lo)) {
-			ext = erofs_read_metabuf(&map->buf, sb, pos, true);
+			ext = erofs_read_metabuf(&map->buf, sb, pos, true, meta_compr);
 			if (IS_ERR(ext))
 				return PTR_ERR(ext);
 			pa = le64_to_cpu(*(__le64 *)ext);
@@ -565,7 +568,7 @@ static int z_erofs_map_blocks_ext(struct inode *inode,
 		}
 
 		for (; lstart <= map->m_la; lstart += 1 << vi->z_lclusterbits) {
-			ext = erofs_read_metabuf(&map->buf, sb, pos, true);
+			ext = erofs_read_metabuf(&map->buf, sb, pos, true, meta_compr);
 			if (IS_ERR(ext))
 				return PTR_ERR(ext);
 			map->m_plen = le32_to_cpu(ext->plen);
@@ -585,7 +588,7 @@ static int z_erofs_map_blocks_ext(struct inode *inode,
 		for (l = 0, r = vi->z_extents; l < r; ) {
 			mid = l + (r - l) / 2;
 			ext = erofs_read_metabuf(&map->buf, sb,
-						 pos + mid * recsz, true);
+						 pos + mid * recsz, true, meta_compr);
 			if (IS_ERR(ext))
 				return PTR_ERR(ext);
 
@@ -650,6 +653,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 	erofs_off_t pos;
 	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 	struct z_erofs_map_header *h;
+	bool meta_compr = false;
 
 	if (test_bit(EROFS_I_Z_INITED_BIT, &vi->flags)) {
 		/*
@@ -667,8 +671,8 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 	if (test_bit(EROFS_I_Z_INITED_BIT, &vi->flags))
 		goto out_unlock;
 
-	pos = ALIGN(erofs_iloc(inode) + vi->inode_isize + vi->xattr_isize, 8);
-	h = erofs_read_metabuf(&buf, sb, pos, true);
+	pos = ALIGN(erofs_iloc(inode, &meta_compr) + vi->inode_isize + vi->xattr_isize, 8);
+	h = erofs_read_metabuf(&buf, sb, pos, true, meta_compr);
 	if (IS_ERR(h)) {
 		err = PTR_ERR(h);
 		goto out_unlock;
diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
index dad7360f42f9..260c949880d5 100644
--- a/include/trace/events/erofs.h
+++ b/include/trace/events/erofs.h
@@ -66,13 +66,16 @@ TRACE_EVENT(erofs_fill_inode,
 		__field(erofs_nid_t,	nid	)
 		__field(erofs_blk_t,	blkaddr )
 		__field(unsigned int,	ofs	)
+		__field(bool,		meta_compr	)
 	),
 
 	TP_fast_assign(
 		__entry->dev		= inode->i_sb->s_dev;
 		__entry->nid		= EROFS_I(inode)->nid;
-		__entry->blkaddr	= erofs_blknr(inode->i_sb, erofs_iloc(inode));
-		__entry->ofs		= erofs_blkoff(inode->i_sb, erofs_iloc(inode));
+		__entry->blkaddr	=
+			erofs_blknr(inode->i_sb, erofs_iloc(inode, &__entry->meta_compr));
+		__entry->ofs		=
+			erofs_blkoff(inode->i_sb, erofs_iloc(inode, &__entry->meta_compr));
 	),
 
 	TP_printk("dev = (%d,%d), nid = %llu, blkaddr %llu ofs %u",
-- 
2.31.1


