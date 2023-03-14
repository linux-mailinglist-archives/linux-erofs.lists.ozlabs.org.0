Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 460B06B8C1F
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Mar 2023 08:43:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PbQVn0hV8z3cKm
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Mar 2023 18:43:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PbQVg3xlfz3bym
	for <linux-erofs@lists.ozlabs.org>; Tue, 14 Mar 2023 18:43:06 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VdrKDUo_1678779773;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VdrKDUo_1678779773)
          by smtp.aliyun-inc.com;
          Tue, 14 Mar 2023 15:43:01 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 3/4] erofs-utils: drop hard-coded block size
Date: Tue, 14 Mar 2023 15:42:51 +0800
Message-Id: <20230314074251.80425-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230314062121.115020-3-hsiangkao@linux.alibaba.com>
References: <20230314062121.115020-3-hsiangkao@linux.alibaba.com>
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

Now block sizes can be less than PAGE_SIZE.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Link: https://lore.kernel.org/r/20230314062121.115020-3-hsiangkao@linux.alibaba.com
---
v3: fix wrong calculation of zero_padding in lib/decompress.c
 dump/main.c              |  4 +-
 fsck/main.c              | 10 ++---
 fuse/main.c              |  2 +-
 include/erofs/cache.h    |  4 +-
 include/erofs/internal.h | 36 +++++++-----------
 include/erofs/io.h       |  6 +--
 include/erofs/xattr.h    |  4 +-
 lib/blobchunk.c          | 14 +++----
 lib/cache.c              | 36 +++++++++---------
 lib/compress.c           | 80 ++++++++++++++++++++--------------------
 lib/compress_hints.c     |  8 ++--
 lib/compressor.c         | 10 ++---
 lib/data.c               | 34 ++++++++---------
 lib/decompress.c         | 16 ++++----
 lib/dir.c                |  6 +--
 lib/inode.c              | 56 ++++++++++++++--------------
 lib/io.c                 | 14 +++----
 lib/namei.c              | 11 +++---
 lib/super.c              |  6 +--
 lib/xattr.c              | 24 ++++++------
 lib/zmap.c               | 12 +++---
 mkfs/main.c              | 29 +++++++--------
 22 files changed, 204 insertions(+), 218 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index bc4e028..fd1923f 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -203,7 +203,7 @@ static int erofsdump_get_occupied_size(struct erofs_inode *inode,
 	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
 	case EROFS_INODE_FLAT_COMPRESSION:
 		stats.compressed_files++;
-		*size = inode->u.i_blocks * EROFS_BLKSIZ;
+		*size = inode->u.i_blocks * erofs_blksiz();
 		break;
 	default:
 		erofs_err("unknown datalayout");
@@ -448,7 +448,7 @@ static void erofsdump_show_fileinfo(bool show_extent)
 			.m_deviceid = map.m_deviceid,
 			.m_pa = map.m_pa,
 		};
-		err = erofs_map_dev(&sbi, &mdev);
+		err = erofs_map_dev(&mdev);
 		if (err) {
 			erofs_err("failed to map device");
 			return;
diff --git a/fsck/main.c b/fsck/main.c
index 6b42252..ad40537 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -259,7 +259,7 @@ static void erofsfsck_set_attributes(struct erofs_inode *inode, char *path)
 static int erofs_check_sb_chksum(void)
 {
 	int ret;
-	u8 buf[EROFS_BLKSIZ];
+	u8 buf[EROFS_MAX_BLOCK_SIZE];
 	u32 crc;
 	struct erofs_super_block *sb;
 
@@ -273,7 +273,7 @@ static int erofs_check_sb_chksum(void)
 	sb = (struct erofs_super_block *)(buf + EROFS_SUPER_OFFSET);
 	sb->checksum = 0;
 
-	crc = erofs_crc32c(~0, (u8 *)sb, EROFS_BLKSIZ - EROFS_SUPER_OFFSET);
+	crc = erofs_crc32c(~0, (u8 *)sb, erofs_blksiz() - EROFS_SUPER_OFFSET);
 	if (crc != sbi.checksum) {
 		erofs_err("superblock chksum doesn't match: saved(%08xh) calculated(%08xh)",
 			  sbi.checksum, crc);
@@ -292,7 +292,7 @@ static int erofs_verify_xattr(struct erofs_inode *inode)
 	struct erofs_xattr_ibody_header *ih;
 	struct erofs_xattr_entry *entry;
 	int i, remaining = inode->xattr_isize, ret = 0;
-	char buf[EROFS_BLKSIZ];
+	char buf[EROFS_MAX_BLOCK_SIZE];
 
 	if (inode->xattr_isize == xattr_hdr_size) {
 		erofs_err("xattr_isize %d of nid %llu is not supported yet",
@@ -322,8 +322,8 @@ static int erofs_verify_xattr(struct erofs_inode *inode)
 	addr += xattr_hdr_size;
 	remaining -= xattr_hdr_size;
 	for (i = 0; i < xattr_shared_count; ++i) {
-		if (ofs >= EROFS_BLKSIZ) {
-			if (ofs != EROFS_BLKSIZ) {
+		if (ofs >= erofs_blksiz()) {
+			if (ofs != erofs_blksiz()) {
 				erofs_err("unaligned xattr entry in xattr shared area @ nid %llu",
 					  inode->nid | 0ULL);
 				ret = -EFSCORRUPTED;
diff --git a/fuse/main.c b/fuse/main.c
index e6af890..b060e06 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -95,7 +95,7 @@ static int erofsfuse_getattr(const char *path, struct stat *stbuf)
 	stbuf->st_mode  = vi.i_mode;
 	stbuf->st_nlink = vi.i_nlink;
 	stbuf->st_size  = vi.i_size;
-	stbuf->st_blocks = roundup(vi.i_size, EROFS_BLKSIZ) >> 9;
+	stbuf->st_blocks = roundup(vi.i_size, erofs_blksiz()) >> 9;
 	stbuf->st_uid = vi.i_uid;
 	stbuf->st_gid = vi.i_gid;
 	if (S_ISBLK(vi.i_mode) || S_ISCHR(vi.i_mode))
diff --git a/include/erofs/cache.h b/include/erofs/cache.h
index de12399..1461305 100644
--- a/include/erofs/cache.h
+++ b/include/erofs/cache.h
@@ -55,7 +55,7 @@ struct erofs_buffer_block {
 static inline const int get_alignsize(int type, int *type_ret)
 {
 	if (type == DATA)
-		return EROFS_BLKSIZ;
+		return erofs_blksiz();
 
 	if (type == INODE) {
 		*type_ret = META;
@@ -84,7 +84,7 @@ static inline erofs_off_t erofs_btell(struct erofs_buffer_head *bh, bool end)
 	if (bb->blkaddr == NULL_ADDR)
 		return NULL_ADDR_UL;
 
-	return blknr_to_addr(bb->blkaddr) +
+	return erofs_pos(bb->blkaddr) +
 		(end ? list_next_entry(bh, list)->off : bh->off);
 }
 
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index a031915..a727312 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -35,17 +35,7 @@ typedef unsigned short umode_t;
 #define PAGE_SIZE		(1U << PAGE_SHIFT)
 #endif
 
-/* no obvious reason to support explicit PAGE_SIZE != 4096 for now */
-#if PAGE_SIZE != 4096
-#warning EROFS may be incompatible on your platform
-#endif
-
-#ifndef PAGE_MASK
-#define PAGE_MASK		(~(PAGE_SIZE-1))
-#endif
-
-#define LOG_BLOCK_SIZE          (12)
-#define EROFS_BLKSIZ            (1U << LOG_BLOCK_SIZE)
+#define EROFS_MAX_BLOCK_SIZE	PAGE_SIZE
 
 #define EROFS_ISLOTBITS		5
 #define EROFS_SLOTSIZE		(1U << EROFS_ISLOTBITS)
@@ -58,11 +48,15 @@ typedef u32 erofs_blk_t;
 #define NULL_ADDR	((unsigned int)-1)
 #define NULL_ADDR_UL	((unsigned long)-1)
 
-#define erofs_blknr(addr)       ((addr) / EROFS_BLKSIZ)
-#define erofs_blkoff(addr)      ((addr) % EROFS_BLKSIZ)
-#define blknr_to_addr(nr)       ((erofs_off_t)(nr) * EROFS_BLKSIZ)
+/* global sbi */
+extern struct erofs_sb_info sbi;
 
-#define BLK_ROUND_UP(addr)	DIV_ROUND_UP(addr, EROFS_BLKSIZ)
+#define erofs_blksiz()		(1u << sbi.blkszbits)
+#define erofs_blknr(addr)       ((addr) >> sbi.blkszbits)
+#define erofs_blkoff(addr)      ((addr) & (erofs_blksiz() - 1))
+#define erofs_pos(nr)           ((erofs_off_t)(nr) << sbi.blkszbits)
+
+#define BLK_ROUND_UP(addr)	DIV_ROUND_UP(addr, 1u << sbi.blkszbits)
 
 struct erofs_buffer_head;
 
@@ -110,16 +104,12 @@ struct erofs_sb_info {
 	erofs_nid_t packed_nid;
 };
 
-
 /* make sure that any user of the erofs headers has atleast 64bit off_t type */
 extern int erofs_assert_largefile[sizeof(off_t)-8];
 
-/* global sbi */
-extern struct erofs_sb_info sbi;
-
 static inline erofs_off_t iloc(erofs_nid_t nid)
 {
-	return blknr_to_addr(sbi.meta_blkaddr) + (nid << sbi.islotbits);
+	return erofs_pos(sbi.meta_blkaddr) + (nid << sbi.islotbits);
 }
 
 #define EROFS_FEATURE_FUNCS(name, compat, feature) \
@@ -311,7 +301,7 @@ enum {
 #define EROFS_MAP_PARTIAL_REF	(1 << BH_Partialref)
 
 struct erofs_map_blocks {
-	char mpage[EROFS_BLKSIZ];
+	char mpage[EROFS_MAX_BLOCK_SIZE];
 
 	erofs_off_t m_pa, m_la;
 	u64 m_plen, m_llen;
@@ -355,7 +345,7 @@ int erofs_pread(struct erofs_inode *inode, char *buf,
 		erofs_off_t count, erofs_off_t offset);
 int erofs_map_blocks(struct erofs_inode *inode,
 		struct erofs_map_blocks *map, int flags);
-int erofs_map_dev(struct erofs_sb_info *sbi, struct erofs_map_dev *map);
+int erofs_map_dev(struct erofs_map_dev *map);
 int erofs_read_one_data(struct erofs_map_blocks *map, char *buffer, u64 offset,
 			size_t len);
 int z_erofs_read_one_data(struct erofs_inode *inode,
@@ -374,7 +364,7 @@ static inline int erofs_get_occupied_size(const struct erofs_inode *inode,
 		break;
 	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
 	case EROFS_INODE_FLAT_COMPRESSION:
-		*size = inode->u.i_blocks * EROFS_BLKSIZ;
+		*size = inode->u.i_blocks * erofs_blksiz();
 		break;
 	default:
 		return -ENOTSUP;
diff --git a/include/erofs/io.h b/include/erofs/io.h
index 0f58c70..36210a3 100644
--- a/include/erofs/io.h
+++ b/include/erofs/io.h
@@ -43,15 +43,13 @@ ssize_t erofs_copy_file_range(int fd_in, erofs_off_t *off_in,
 static inline int blk_write(const void *buf, erofs_blk_t blkaddr,
 			    u32 nblocks)
 {
-	return dev_write(buf, blknr_to_addr(blkaddr),
-			 blknr_to_addr(nblocks));
+	return dev_write(buf, erofs_pos(blkaddr), erofs_pos(nblocks));
 }
 
 static inline int blk_read(int device_id, void *buf,
 			   erofs_blk_t start, u32 nblocks)
 {
-	return dev_read(device_id, buf, blknr_to_addr(start),
-			 blknr_to_addr(nblocks));
+	return dev_read(device_id, buf, erofs_pos(start), erofs_pos(nblocks));
 }
 
 #ifdef __cplusplus
diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index a0528c0..9efadc5 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -27,12 +27,12 @@ static inline unsigned int inlinexattr_header_size(struct erofs_inode *vi)
 static inline erofs_blk_t xattrblock_addr(unsigned int xattr_id)
 {
 	return sbi.xattr_blkaddr +
-		xattr_id * sizeof(__u32) / EROFS_BLKSIZ;
+		((xattr_id * sizeof(__u32)) >> sbi.blkszbits);
 }
 
 static inline unsigned int xattrblock_offset(unsigned int xattr_id)
 {
-	return (xattr_id * sizeof(__u32)) % EROFS_BLKSIZ;
+	return (xattr_id * sizeof(__u32)) & (erofs_blksiz() - 1);
 }
 
 #define EROFS_INODE_XATTR_ICOUNT(_size)	({\
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 3ff0f48..8142cc3 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -32,7 +32,7 @@ struct erofs_blobchunk erofs_holechunk = {
 static struct erofs_blobchunk *erofs_blob_getchunk(int fd,
 		erofs_off_t chunksize)
 {
-	static u8 zeroed[EROFS_BLKSIZ];
+	static u8 zeroed[EROFS_MAX_BLOCK_SIZE];
 	u8 *chunkdata, sha256[32];
 	int ret;
 	unsigned int hash;
@@ -72,7 +72,7 @@ static struct erofs_blobchunk *erofs_blob_getchunk(int fd,
 	erofs_dbg("Writing chunk (%u bytes) to %u", chunksize, chunk->blkaddr);
 	ret = fwrite(chunkdata, chunksize, 1, blobfile);
 	if (ret == 1 && erofs_blkoff(chunksize))
-		ret = fwrite(zeroed, EROFS_BLKSIZ - erofs_blkoff(chunksize),
+		ret = fwrite(zeroed, erofs_blksiz() - erofs_blkoff(chunksize),
 			     1, blobfile);
 	if (ret < 1) {
 		struct hashmap_entry key;
@@ -181,15 +181,15 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode)
 	/* if the file is fully sparsed, use one big chunk instead */
 	if (lseek(fd, 0, SEEK_DATA) < 0 && errno == ENXIO) {
 		chunkbits = ilog2(inode->i_size - 1) + 1;
-		if (chunkbits < LOG_BLOCK_SIZE)
-			chunkbits = LOG_BLOCK_SIZE;
+		if (chunkbits < sbi.blkszbits)
+			chunkbits = sbi.blkszbits;
 	}
 #endif
-	if (chunkbits - LOG_BLOCK_SIZE > EROFS_CHUNK_FORMAT_BLKBITS_MASK)
-		chunkbits = EROFS_CHUNK_FORMAT_BLKBITS_MASK + LOG_BLOCK_SIZE;
+	if (chunkbits - sbi.blkszbits > EROFS_CHUNK_FORMAT_BLKBITS_MASK)
+		chunkbits = EROFS_CHUNK_FORMAT_BLKBITS_MASK + sbi.blkszbits;
 	chunksize = 1ULL << chunkbits;
 	count = DIV_ROUND_UP(inode->i_size, chunksize);
-	inode->u.chunkformat |= chunkbits - LOG_BLOCK_SIZE;
+	inode->u.chunkformat |= chunkbits - sbi.blkszbits;
 	if (multidev)
 		inode->u.chunkformat |= EROFS_CHUNK_FORMAT_INDEXES;
 
diff --git a/lib/cache.c b/lib/cache.c
index c735363..3ada3eb 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -17,7 +17,7 @@ static struct erofs_buffer_block blkh = {
 static erofs_blk_t tail_blkaddr;
 
 /* buckets for all mapped buffer blocks to boost up allocation */
-static struct list_head mapped_buckets[META + 1][EROFS_BLKSIZ];
+static struct list_head mapped_buckets[META + 1][EROFS_MAX_BLOCK_SIZE];
 /* last mapped buffer block to accelerate erofs_mapbh() */
 static struct erofs_buffer_block *last_mapped_block = &blkh;
 
@@ -86,7 +86,7 @@ static void erofs_bupdate_mapped(struct erofs_buffer_block *bb)
 	if (bb->blkaddr == NULL_ADDR)
 		return;
 
-	bkt = mapped_buckets[bb->type] + bb->buffers.off % EROFS_BLKSIZ;
+	bkt = mapped_buckets[bb->type] + bb->buffers.off % erofs_blksiz();
 	list_del(&bb->mapped_list);
 	list_add_tail(&bb->mapped_list, bkt);
 }
@@ -100,9 +100,9 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
 			   bool dryrun)
 {
 	const erofs_off_t alignedoffset = roundup(bb->buffers.off, alignsize);
-	const int oob = cmpsgn(roundup((bb->buffers.off - 1) % EROFS_BLKSIZ + 1,
+	const int oob = cmpsgn(roundup((bb->buffers.off - 1) % erofs_blksiz() + 1,
 				       alignsize) + incr + extrasize,
-			       EROFS_BLKSIZ);
+			       erofs_blksiz());
 	bool tailupdate = false;
 	erofs_blk_t blkaddr;
 
@@ -132,7 +132,7 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
 			tail_blkaddr = blkaddr + BLK_ROUND_UP(bb->buffers.off);
 		erofs_bupdate_mapped(bb);
 	}
-	return (alignedoffset + incr - 1) % EROFS_BLKSIZ + 1;
+	return (alignedoffset + incr - 1) % erofs_blksiz() + 1;
 }
 
 int erofs_bh_balloon(struct erofs_buffer_head *bh, erofs_off_t incr)
@@ -156,12 +156,12 @@ static int erofs_bfind_for_attach(int type, erofs_off_t size,
 	unsigned int used0, used_before, usedmax, used;
 	int ret;
 
-	used0 = (size + required_ext) % EROFS_BLKSIZ + inline_ext;
+	used0 = (size + required_ext) % erofs_blksiz() + inline_ext;
 	/* inline data should be in the same fs block */
-	if (used0 > EROFS_BLKSIZ)
+	if (used0 > erofs_blksiz())
 		return -ENOSPC;
 
-	if (!used0 || alignsize == EROFS_BLKSIZ) {
+	if (!used0 || alignsize == erofs_blksiz()) {
 		*bbp = NULL;
 		return 0;
 	}
@@ -170,10 +170,10 @@ static int erofs_bfind_for_attach(int type, erofs_off_t size,
 	bb = NULL;
 
 	/* try to find a most-fit mapped buffer block first */
-	if (size + required_ext + inline_ext >= EROFS_BLKSIZ)
+	if (size + required_ext + inline_ext >= erofs_blksiz())
 		goto skip_mapped;
 
-	used_before = rounddown(EROFS_BLKSIZ -
+	used_before = rounddown(erofs_blksiz() -
 				(size + required_ext + inline_ext), alignsize);
 	for (; used_before; --used_before) {
 		struct list_head *bt = mapped_buckets[type] + used_before;
@@ -191,7 +191,7 @@ static int erofs_bfind_for_attach(int type, erofs_off_t size,
 
 		DBG_BUGON(cur->type != type);
 		DBG_BUGON(cur->blkaddr == NULL_ADDR);
-		DBG_BUGON(used_before != cur->buffers.off % EROFS_BLKSIZ);
+		DBG_BUGON(used_before != cur->buffers.off % erofs_blksiz());
 
 		ret = __erofs_battach(cur, NULL, size, alignsize,
 				      required_ext + inline_ext, true);
@@ -202,7 +202,7 @@ static int erofs_bfind_for_attach(int type, erofs_off_t size,
 
 		/* should contain all data in the current block */
 		used = ret + required_ext + inline_ext;
-		DBG_BUGON(used > EROFS_BLKSIZ);
+		DBG_BUGON(used > erofs_blksiz());
 
 		bb = cur;
 		usedmax = used;
@@ -215,7 +215,7 @@ skip_mapped:
 	if (cur == &blkh)
 		cur = list_next_entry(cur, list);
 	for (; cur != &blkh; cur = list_next_entry(cur, list)) {
-		used_before = cur->buffers.off % EROFS_BLKSIZ;
+		used_before = cur->buffers.off % erofs_blksiz();
 
 		/* skip if buffer block is just full */
 		if (!used_before)
@@ -230,10 +230,10 @@ skip_mapped:
 		if (ret < 0)
 			continue;
 
-		used = (ret + required_ext) % EROFS_BLKSIZ + inline_ext;
+		used = (ret + required_ext) % erofs_blksiz() + inline_ext;
 
 		/* should contain inline data in current block */
-		if (used > EROFS_BLKSIZ)
+		if (used > erofs_blksiz())
 			continue;
 
 		/*
@@ -396,9 +396,9 @@ bool erofs_bflush(struct erofs_buffer_block *bb)
 		if (skip)
 			continue;
 
-		padding = EROFS_BLKSIZ - p->buffers.off % EROFS_BLKSIZ;
-		if (padding != EROFS_BLKSIZ)
-			dev_fillzero(blknr_to_addr(blkaddr) - padding,
+		padding = erofs_blksiz() - p->buffers.off % erofs_blksiz();
+		if (padding != erofs_blksiz())
+			dev_fillzero(erofs_pos(blkaddr) - padding,
 				     padding, true);
 
 		DBG_BUGON(!list_empty(&p->buffers.list));
diff --git a/lib/compress.c b/lib/compress.c
index afa3bf7..06bacdb 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -79,7 +79,7 @@ static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
 	struct erofs_inode *inode = ctx->inode;
 	unsigned int clusterofs = ctx->clusterofs;
 	unsigned int count = ctx->e.length;
-	unsigned int d0 = 0, d1 = (clusterofs + count) / EROFS_BLKSIZ;
+	unsigned int d0 = 0, d1 = (clusterofs + count) / erofs_blksiz();
 	struct z_erofs_vle_decompressed_index di;
 	unsigned int type, advise;
 
@@ -164,12 +164,12 @@ static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
 		memcpy(ctx->metacur, &di, sizeof(di));
 		ctx->metacur += sizeof(di);
 
-		count -= EROFS_BLKSIZ - clusterofs;
+		count -= erofs_blksiz() - clusterofs;
 		clusterofs = 0;
 
 		++d0;
 		--d1;
-	} while (clusterofs + count >= EROFS_BLKSIZ);
+	} while (clusterofs + count >= erofs_blksiz());
 
 	ctx->clusterofs = clusterofs + count;
 }
@@ -190,12 +190,12 @@ static int z_erofs_compress_dedupe(struct z_erofs_vle_compress_ctx *ctx,
 	do {
 		struct z_erofs_dedupe_ctx dctx = {
 			.start = ctx->queue + ctx->head - ({ int rc;
-				if (ctx->e.length <= EROFS_BLKSIZ)
+				if (ctx->e.length <= erofs_blksiz())
 					rc = 0;
-				else if (ctx->e.length - EROFS_BLKSIZ >= ctx->head)
+				else if (ctx->e.length - erofs_blksiz() >= ctx->head)
 					rc = ctx->head;
 				else
-					rc = ctx->e.length - EROFS_BLKSIZ;
+					rc = ctx->e.length - erofs_blksiz();
 				rc; }),
 			.end = ctx->queue + ctx->head + *len,
 			.cur = ctx->queue + ctx->head,
@@ -212,8 +212,8 @@ static int z_erofs_compress_dedupe(struct z_erofs_vle_compress_ctx *ctx,
 		 * decompresssion could be done as another try in practice.
 		 */
 		if (dctx.e.compressedblks > 1 &&
-		    (ctx->clusterofs + ctx->e.length - delta) % EROFS_BLKSIZ +
-			dctx.e.length < 2 * EROFS_BLKSIZ)
+		    (ctx->clusterofs + ctx->e.length - delta) % erofs_blksiz() +
+			dctx.e.length < 2 * erofs_blksiz())
 			break;
 
 		/* fall back to noncompact indexes for deduplication */
@@ -239,7 +239,7 @@ static int z_erofs_compress_dedupe(struct z_erofs_vle_compress_ctx *ctx,
 
 		if (ctx->head >= EROFS_CONFIG_COMPR_MAX_SZ) {
 			const unsigned int qh_aligned =
-				round_down(ctx->head, EROFS_BLKSIZ);
+				round_down(ctx->head, erofs_blksiz());
 			const unsigned int qh_after = ctx->head - qh_aligned;
 
 			memmove(ctx->queue, ctx->queue + qh_aligned,
@@ -270,16 +270,16 @@ static int write_uncompressed_extent(struct z_erofs_vle_compress_ctx *ctx,
 		ctx->clusterofs = 0;
 	}
 
-	count = min(EROFS_BLKSIZ, *len);
+	count = min(erofs_blksiz(), *len);
 
 	/* write interlaced uncompressed data if needed */
 	if (ctx->inode->z_advise & Z_EROFS_ADVISE_INTERLACED_PCLUSTER)
 		interlaced_offset = ctx->clusterofs;
 	else
 		interlaced_offset = 0;
-	rightpart = min(EROFS_BLKSIZ - interlaced_offset, count);
+	rightpart = min(erofs_blksiz() - interlaced_offset, count);
 
-	memset(dst, 0, EROFS_BLKSIZ);
+	memset(dst, 0, erofs_blksiz());
 
 	memcpy(dst + interlaced_offset, ctx->queue + ctx->head, rightpart);
 	memcpy(dst, ctx->queue + ctx->head + rightpart, count - rightpart);
@@ -333,14 +333,14 @@ static void tryrecompress_trailing(struct erofs_compress *ec,
 	int ret = *compressedsize;
 
 	/* no need to recompress */
-	if (!(ret & (EROFS_BLKSIZ - 1)))
+	if (!(ret & (erofs_blksiz() - 1)))
 		return;
 
 	count = *insize;
 	ret = erofs_compress_destsize(ec, in, &count, (void *)tmp,
-				      rounddown(ret, EROFS_BLKSIZ), false);
+				      rounddown(ret, erofs_blksiz()), false);
 	if (ret <= 0 || ret + (*insize - count) >=
-			roundup(*compressedsize, EROFS_BLKSIZ))
+			roundup(*compressedsize, erofs_blksiz()))
 		return;
 
 	/* replace the original compressed data if any gain */
@@ -360,7 +360,7 @@ static bool z_erofs_fixup_deduped_fragment(struct z_erofs_vle_compress_ctx *ctx,
 	/* try to fix again if it gets larger (should be rare) */
 	if (inode->fragment_size < newsize) {
 		ctx->pclustersize = roundup(newsize - inode->fragment_size,
-					    EROFS_BLKSIZ);
+					    erofs_blksiz());
 		return false;
 	}
 
@@ -379,9 +379,9 @@ static bool z_erofs_fixup_deduped_fragment(struct z_erofs_vle_compress_ctx *ctx,
 
 static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx)
 {
-	static char dstbuf[EROFS_CONFIG_COMPR_MAX_SZ + EROFS_BLKSIZ];
+	static char dstbuf[EROFS_CONFIG_COMPR_MAX_SZ + EROFS_MAX_BLOCK_SIZE];
 	struct erofs_inode *inode = ctx->inode;
-	char *const dst = dstbuf + EROFS_BLKSIZ;
+	char *const dst = dstbuf + erofs_blksiz();
 	struct erofs_compress *const h = &ctx->ccfg->handle;
 	unsigned int len = ctx->tail - ctx->head;
 	bool is_packed_inode = erofs_is_packed_inode(inode);
@@ -404,13 +404,13 @@ static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx)
 			if (may_packing) {
 				if (inode->fragment_size && !fix_dedupedfrag) {
 					ctx->pclustersize =
-						roundup(len, EROFS_BLKSIZ);
+						roundup(len, erofs_blksiz());
 					goto fix_dedupedfrag;
 				}
 				ctx->e.length = len;
 				goto frag_packing;
 			}
-			if (!may_inline && len <= EROFS_BLKSIZ)
+			if (!may_inline && len <= erofs_blksiz())
 				goto nocompression;
 		}
 
@@ -426,7 +426,7 @@ static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx)
 					  erofs_strerror(ret));
 			}
 
-			if (may_inline && len < EROFS_BLKSIZ) {
+			if (may_inline && len < erofs_blksiz()) {
 				ret = z_erofs_fill_inline_data(inode,
 						ctx->queue + ctx->head,
 						len, true);
@@ -463,8 +463,8 @@ frag_packing:
 			fix_dedupedfrag = false;
 		/* tailpcluster should be less than 1 block */
 		} else if (may_inline && len == ctx->e.length &&
-			   ret < EROFS_BLKSIZ) {
-			if (ctx->clusterofs + len <= EROFS_BLKSIZ) {
+			   ret < erofs_blksiz()) {
+			if (ctx->clusterofs + len <= erofs_blksiz()) {
 				inode->eof_tailraw = malloc(len);
 				if (!inode->eof_tailraw)
 					return -ENOMEM;
@@ -490,10 +490,10 @@ frag_packing:
 			 * Otherwise, just drop it and go to packing.
 			 */
 			if (may_packing && len == ctx->e.length &&
-			    (ret & (EROFS_BLKSIZ - 1)) &&
+			    (ret & (erofs_blksiz() - 1)) &&
 			    ctx->tail < sizeof(ctx->queue)) {
 				ctx->pclustersize =
-					BLK_ROUND_UP(ret) * EROFS_BLKSIZ;
+					BLK_ROUND_UP(ret) * erofs_blksiz();
 				goto fix_dedupedfrag;
 			}
 
@@ -501,18 +501,18 @@ frag_packing:
 				tryrecompress_trailing(h, ctx->queue + ctx->head,
 						&ctx->e.length, dst, &ret);
 
-			tailused = ret & (EROFS_BLKSIZ - 1);
+			tailused = ret & (erofs_blksiz() - 1);
 			padding = 0;
 			ctx->e.compressedblks = BLK_ROUND_UP(ret);
-			DBG_BUGON(ctx->e.compressedblks * EROFS_BLKSIZ >=
+			DBG_BUGON(ctx->e.compressedblks * erofs_blksiz() >=
 				  ctx->e.length);
 
 			/* zero out garbage trailing data for non-0padding */
 			if (!erofs_sb_has_lz4_0padding())
 				memset(dst + ret, 0,
-				       roundup(ret, EROFS_BLKSIZ) - ret);
+				       roundup(ret, erofs_blksiz()) - ret);
 			else if (tailused)
-				padding = EROFS_BLKSIZ - tailused;
+				padding = erofs_blksiz() - tailused;
 
 			/* write compressed data */
 			erofs_dbg("Writing %u compressed data to %u of %u blocks",
@@ -542,7 +542,7 @@ frag_packing:
 
 		if (!final && ctx->head >= EROFS_CONFIG_COMPR_MAX_SZ) {
 			const unsigned int qh_aligned =
-				round_down(ctx->head, EROFS_BLKSIZ);
+				round_down(ctx->head, erofs_blksiz());
 			const unsigned int qh_after = ctx->head - qh_aligned;
 
 			memmove(ctx->queue, ctx->queue + qh_aligned,
@@ -682,10 +682,10 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 	unsigned int compacted_2b;
 	bool dummy_head;
 
-	if (logical_clusterbits < LOG_BLOCK_SIZE || LOG_BLOCK_SIZE < 12)
+	if (logical_clusterbits < sbi.blkszbits || sbi.blkszbits < 12)
 		return -EINVAL;
 	if (logical_clusterbits > 14)	/* currently not supported */
-		return -ENOTSUP;
+		return -EOPNOTSUPP;
 	if (logical_clusterbits == 12) {
 		compacted_4b_initial = (32 - mpos % 32) / 4;
 		if (compacted_4b_initial == 32 / 4)
@@ -810,8 +810,8 @@ void z_erofs_drop_inline_pcluster(struct erofs_inode *inode)
 		base = round_down(eofs, 8);
 		pos = 16 /* encodebits */ * ((eofs - base) / 4);
 		out = inode->compressmeta + base;
-		lo = get_unaligned_le32(out + pos / 8) & (EROFS_BLKSIZ - 1);
-		v = (type << LOG_BLOCK_SIZE) | lo;
+		lo = get_unaligned_le32(out + pos / 8) & (erofs_blksiz() - 1);
+		v = (type << sbi.blkszbits) | lo;
 		out[pos / 8] = v & 0xff;
 		out[pos / 8 + 1] = v >> 8;
 	} else {
@@ -875,7 +875,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 	ctx.ccfg = &erofs_ccfg[inode->z_algorithmtype[0]];
 	inode->z_algorithmtype[0] = ctx.ccfg[0].algorithmtype;
 	inode->z_algorithmtype[1] = 0;
-	inode->z_logical_clusterbits = LOG_BLOCK_SIZE;
+	inode->z_logical_clusterbits = sbi.blkszbits;
 
 	inode->idata_size = 0;
 	inode->fragment_size = 0;
@@ -892,7 +892,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 
 	blkaddr = erofs_mapbh(bh->block);	/* start_blkaddr */
 	ctx.inode = inode;
-	ctx.pclustersize = z_erofs_get_max_pclusterblks(inode) * EROFS_BLKSIZ;
+	ctx.pclustersize = z_erofs_get_max_pclusterblks(inode) * erofs_blksiz();
 	ctx.blkaddr = blkaddr;
 	ctx.metacur = compressmeta + Z_EROFS_LEGACY_MAP_HEADER_SIZE;
 	ctx.head = ctx.tail = 0;
@@ -945,7 +945,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 	legacymetasize = ctx.metacur - compressmeta;
 	/* estimate if data compression saves space or not */
 	if (!inode->fragment_size &&
-	    compressed_blocks * EROFS_BLKSIZ + inode->idata_size +
+	    compressed_blocks * erofs_blksiz() + inode->idata_size +
 	    legacymetasize >= inode->i_size) {
 		z_erofs_dedupe_commit(true);
 		ret = -ENOSPC;
@@ -964,8 +964,8 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 	}
 
 	if (compressed_blocks) {
-		ret = erofs_bh_balloon(bh, blknr_to_addr(compressed_blocks));
-		DBG_BUGON(ret != EROFS_BLKSIZ);
+		ret = erofs_bh_balloon(bh, erofs_pos(compressed_blocks));
+		DBG_BUGON(ret != erofs_blksiz());
 	} else {
 		if (!cfg.c_fragments && !cfg.c_dedupe)
 			DBG_BUGON(!inode->idata_size);
@@ -1114,7 +1114,7 @@ int z_erofs_compress_init(struct erofs_buffer_head *sb_bh)
 	 */
 	if (cfg.c_pclusterblks_max > 1) {
 		if (cfg.c_pclusterblks_max >
-		    Z_EROFS_PCLUSTER_MAX_SIZE / EROFS_BLKSIZ) {
+		    Z_EROFS_PCLUSTER_MAX_SIZE / erofs_blksiz()) {
 			erofs_err("unsupported clusterblks %u (too large)",
 				  cfg.c_pclusterblks_max);
 			return -EINVAL;
diff --git a/lib/compress_hints.c b/lib/compress_hints.c
index 1e9e05d..0182e93 100644
--- a/lib/compress_hints.c
+++ b/lib/compress_hints.c
@@ -133,21 +133,21 @@ int erofs_load_compress_hints(void)
 			}
 		}
 
-		if (pclustersize % EROFS_BLKSIZ) {
+		if (pclustersize % erofs_blksiz()) {
 			erofs_warn("invalid physical clustersize %u, "
 				   "use default pclusterblks %u",
 				   pclustersize, cfg.c_pclusterblks_def);
 			continue;
 		}
 		erofs_insert_compress_hints(pattern,
-					    pclustersize / EROFS_BLKSIZ, ccfg);
+					    pclustersize / erofs_blksiz(), ccfg);
 
 		if (pclustersize > max_pclustersize)
 			max_pclustersize = pclustersize;
 	}
 
-	if (cfg.c_pclusterblks_max * EROFS_BLKSIZ < max_pclustersize) {
-		cfg.c_pclusterblks_max = max_pclustersize / EROFS_BLKSIZ;
+	if (cfg.c_pclusterblks_max * erofs_blksiz() < max_pclustersize) {
+		cfg.c_pclusterblks_max = max_pclustersize / erofs_blksiz();
 		erofs_warn("update max pclusterblks to %u", cfg.c_pclusterblks_max);
 	}
 out:
diff --git a/lib/compressor.c b/lib/compressor.c
index a46bc39..52eb761 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -38,10 +38,10 @@ int erofs_compress_destsize(const struct erofs_compress *c,
 	if (ret < 0)
 		return ret;
 
-	/* XXX: ret >= EROFS_BLKSIZ is a temporary hack for ztailpacking */
-	if (inblocks || ret >= EROFS_BLKSIZ ||
+	/* XXX: ret >= erofs_blksiz() is a temporary hack for ztailpacking */
+	if (inblocks || ret >= erofs_blksiz() ||
 	    uncompressed_capacity != *srcsize)
-		compressed_size = roundup(ret, EROFS_BLKSIZ);
+		compressed_size = roundup(ret, erofs_blksiz());
 	else
 		compressed_size = ret;
 	DBG_BUGON(c->compress_threshold < 100);
@@ -76,8 +76,8 @@ int erofs_compressor_init(struct erofs_compress *c, char *alg_name)
 	c->compress_threshold = 100;
 
 	/* optimize for 4k size page */
-	c->destsize_alignsize = EROFS_BLKSIZ;
-	c->destsize_redzone_begin = EROFS_BLKSIZ - 16;
+	c->destsize_alignsize = erofs_blksiz();
+	c->destsize_redzone_begin = erofs_blksiz() - 16;
 	c->destsize_redzone_end = EROFS_CONFIG_COMPR_DEF_BOUNDARY;
 
 	if (!alg_name) {
diff --git a/lib/data.c b/lib/data.c
index c7d08e7..211cdb5 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -28,9 +28,9 @@ static int erofs_map_blocks_flatmode(struct erofs_inode *inode,
 	/* there is no hole in flatmode */
 	map->m_flags = EROFS_MAP_MAPPED;
 
-	if (offset < blknr_to_addr(lastblk)) {
-		map->m_pa = blknr_to_addr(vi->u.i_blkaddr) + map->m_la;
-		map->m_plen = blknr_to_addr(lastblk) - offset;
+	if (offset < erofs_pos(lastblk)) {
+		map->m_pa = erofs_pos(vi->u.i_blkaddr) + map->m_la;
+		map->m_plen = erofs_pos(lastblk) - offset;
 	} else if (tailendpacking) {
 		/* 2 - inode inline B: inode, [xattrs], inline last blk... */
 		map->m_pa = iloc(vi->nid) + vi->inode_isize +
@@ -38,7 +38,7 @@ static int erofs_map_blocks_flatmode(struct erofs_inode *inode,
 		map->m_plen = inode->i_size - offset;
 
 		/* inline data should be located in the same meta block */
-		if (erofs_blkoff(map->m_pa) + map->m_plen > EROFS_BLKSIZ) {
+		if (erofs_blkoff(map->m_pa) + map->m_plen > erofs_blksiz()) {
 			erofs_err("inline data cross block boundary @ nid %" PRIu64,
 				  vi->nid);
 			DBG_BUGON(1);
@@ -66,7 +66,7 @@ int erofs_map_blocks(struct erofs_inode *inode,
 {
 	struct erofs_inode *vi = inode;
 	struct erofs_inode_chunk_index *idx;
-	u8 buf[EROFS_BLKSIZ];
+	u8 buf[EROFS_MAX_BLOCK_SIZE];
 	u64 chunknr;
 	unsigned int unit;
 	erofs_off_t pos;
@@ -98,7 +98,7 @@ int erofs_map_blocks(struct erofs_inode *inode,
 
 	map->m_la = chunknr << vi->u.chunkbits;
 	map->m_plen = min_t(erofs_off_t, 1UL << vi->u.chunkbits,
-			    roundup(inode->i_size - map->m_la, EROFS_BLKSIZ));
+			    roundup(inode->i_size - map->m_la, erofs_blksiz()));
 
 	/* handle block map */
 	if (!(vi->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES)) {
@@ -107,7 +107,7 @@ int erofs_map_blocks(struct erofs_inode *inode,
 		if (le32_to_cpu(*blkaddr) == EROFS_NULL_ADDR) {
 			map->m_flags = 0;
 		} else {
-			map->m_pa = blknr_to_addr(le32_to_cpu(*blkaddr));
+			map->m_pa = erofs_pos(le32_to_cpu(*blkaddr));
 			map->m_flags = EROFS_MAP_MAPPED;
 		}
 		goto out;
@@ -121,7 +121,7 @@ int erofs_map_blocks(struct erofs_inode *inode,
 	default:
 		map->m_deviceid = le16_to_cpu(idx->device_id) &
 			sbi.device_id_mask;
-		map->m_pa = blknr_to_addr(le32_to_cpu(idx->blkaddr));
+		map->m_pa = erofs_pos(le32_to_cpu(idx->blkaddr));
 		map->m_flags = EROFS_MAP_MAPPED;
 		break;
 	}
@@ -130,23 +130,23 @@ out:
 	return err;
 }
 
-int erofs_map_dev(struct erofs_sb_info *sbi, struct erofs_map_dev *map)
+int erofs_map_dev(struct erofs_map_dev *map)
 {
 	struct erofs_device_info *dif;
 	int id;
 
 	if (map->m_deviceid) {
-		if (sbi->extra_devices < map->m_deviceid)
+		if (sbi.extra_devices < map->m_deviceid)
 			return -ENODEV;
-	} else if (sbi->extra_devices) {
-		for (id = 0; id < sbi->extra_devices; ++id) {
+	} else if (sbi.extra_devices) {
+		for (id = 0; id < sbi.extra_devices; ++id) {
 			erofs_off_t startoff, length;
 
-			dif = sbi->devs + id;
+			dif = sbi.devs + id;
 			if (!dif->mapped_blkaddr)
 				continue;
-			startoff = blknr_to_addr(dif->mapped_blkaddr);
-			length = blknr_to_addr(dif->blocks);
+			startoff = erofs_pos(dif->mapped_blkaddr);
+			length = erofs_pos(dif->blocks);
 
 			if (map->m_pa >= startoff &&
 			    map->m_pa < startoff + length) {
@@ -168,7 +168,7 @@ int erofs_read_one_data(struct erofs_map_blocks *map, char *buffer, u64 offset,
 		.m_deviceid = map->m_deviceid,
 		.m_pa = map->m_pa,
 	};
-	ret = erofs_map_dev(&sbi, &mdev);
+	ret = erofs_map_dev(&mdev);
 	if (ret)
 		return ret;
 
@@ -253,7 +253,7 @@ int z_erofs_read_one_data(struct erofs_inode *inode,
 	mdev = (struct erofs_map_dev) {
 		.m_pa = map->m_pa,
 	};
-	ret = erofs_map_dev(&sbi, &mdev);
+	ret = erofs_map_dev(&mdev);
 	if (ret) {
 		DBG_BUGON(1);
 		return ret;
diff --git a/lib/decompress.c b/lib/decompress.c
index 36ddd9e..8d1b25d 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -22,8 +22,8 @@ static int z_erofs_decompress_lzma(struct z_erofs_decompress_req *rq)
 	lzma_stream strm;
 	lzma_ret ret2;
 
-	while (!src[inputmargin & ~PAGE_MASK])
-		if (!(++inputmargin & ~PAGE_MASK))
+	while (!src[inputmargin & (erofs_blksiz() - 1)])
+		if (!(++inputmargin & (erofs_blksiz() - 1)))
 			break;
 
 	if (inputmargin >= rq->inputsize)
@@ -85,8 +85,8 @@ static int z_erofs_decompress_lz4(struct z_erofs_decompress_req *rq)
 	if (erofs_sb_has_lz4_0padding()) {
 		support_0padding = true;
 
-		while (!src[inputmargin & ~PAGE_MASK])
-			if (!(++inputmargin & ~PAGE_MASK))
+		while (!src[inputmargin & (erofs_blksiz() - 1)])
+			if (!(++inputmargin & (erofs_blksiz() - 1)))
 				break;
 
 		if (inputmargin >= rq->inputsize)
@@ -134,15 +134,15 @@ int z_erofs_decompress(struct z_erofs_decompress_req *rq)
 	if (rq->alg == Z_EROFS_COMPRESSION_INTERLACED) {
 		unsigned int count, rightpart, skip;
 
-		/* XXX: should support inputsize >= EROFS_BLKSIZ later */
-		if (rq->inputsize > EROFS_BLKSIZ)
+		/* XXX: should support inputsize >= erofs_blksiz() later */
+		if (rq->inputsize > erofs_blksiz())
 			return -EFSCORRUPTED;
 
-		DBG_BUGON(rq->decodedlength > EROFS_BLKSIZ);
+		DBG_BUGON(rq->decodedlength > erofs_blksiz());
 		DBG_BUGON(rq->decodedlength < rq->decodedskip);
 		count = rq->decodedlength - rq->decodedskip;
 		skip = erofs_blkoff(rq->interlaced_offset + rq->decodedskip);
-		rightpart = min(EROFS_BLKSIZ - skip, count);
+		rightpart = min(erofs_blksiz() - skip, count);
 		memcpy(rq->out, rq->in + skip, rightpart);
 		memcpy(rq->out + rightpart, rq->in, count - rightpart);
 		return 0;
diff --git a/lib/dir.c b/lib/dir.c
index e6b9283..cb8c188 100644
--- a/lib/dir.c
+++ b/lib/dir.c
@@ -125,7 +125,7 @@ int erofs_iterate_dir(struct erofs_dir_context *ctx, bool fsck)
 	struct erofs_inode *dir = ctx->dir;
 	int err = 0;
 	erofs_off_t pos;
-	char buf[EROFS_BLKSIZ];
+	char buf[EROFS_MAX_BLOCK_SIZE];
 
 	if (!S_ISDIR(dir->i_mode))
 		return -ENOTDIR;
@@ -135,7 +135,7 @@ int erofs_iterate_dir(struct erofs_dir_context *ctx, bool fsck)
 	while (pos < dir->i_size) {
 		erofs_blk_t lblk = erofs_blknr(pos);
 		erofs_off_t maxsize = min_t(erofs_off_t,
-					dir->i_size - pos, EROFS_BLKSIZ);
+					dir->i_size - pos, erofs_blksiz());
 		const struct erofs_dirent *de = (const void *)buf;
 		unsigned int nameoff;
 
@@ -148,7 +148,7 @@ int erofs_iterate_dir(struct erofs_dir_context *ctx, bool fsck)
 
 		nameoff = le16_to_cpu(de->nameoff);
 		if (nameoff < sizeof(struct erofs_dirent) ||
-		    nameoff >= EROFS_BLKSIZ) {
+		    nameoff >= erofs_blksiz()) {
 			erofs_err("invalid de[0].nameoff %u @ nid %llu, lblk %u",
 				  nameoff, dir->nid | 0ULL, lblk);
 			return -EFSCORRUPTED;
diff --git a/lib/inode.c b/lib/inode.c
index bcb0986..39874a0 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -154,7 +154,7 @@ static int __allocate_inode_bh_data(struct erofs_inode *inode,
 	}
 
 	/* allocate main data buffer */
-	bh = erofs_balloc(DATA, blknr_to_addr(nblocks), 0, 0);
+	bh = erofs_balloc(DATA, erofs_pos(nblocks), 0, 0);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
 
@@ -221,8 +221,8 @@ int erofs_prepare_dir_file(struct erofs_inode *dir, unsigned int nr_subdirs)
 	list_for_each_entry(d, &dir->i_subdirs, d_child) {
 		int len = strlen(d->name) + sizeof(struct erofs_dirent);
 
-		if (d_size % EROFS_BLKSIZ + len > EROFS_BLKSIZ)
-			d_size = round_up(d_size, EROFS_BLKSIZ);
+		if ((d_size & (erofs_blksiz() - 1)) + len > erofs_blksiz())
+			d_size = round_up(d_size, erofs_blksiz());
 		d_size += len;
 
 		i_nlink += (d->type == EROFS_FT_DIR);
@@ -247,7 +247,7 @@ int erofs_prepare_dir_file(struct erofs_inode *dir, unsigned int nr_subdirs)
 		return ret;
 
 	/* it will be used in erofs_prepare_inode_buffer */
-	dir->idata_size = d_size % EROFS_BLKSIZ;
+	dir->idata_size = d_size % erofs_blksiz();
 	return 0;
 }
 
@@ -278,9 +278,9 @@ static void fill_dirblock(char *buf, unsigned int size, unsigned int q,
 static int write_dirblock(unsigned int q, struct erofs_dentry *head,
 			  struct erofs_dentry *end, erofs_blk_t blkaddr)
 {
-	char buf[EROFS_BLKSIZ];
+	char buf[EROFS_MAX_BLOCK_SIZE];
 
-	fill_dirblock(buf, EROFS_BLKSIZ, q, head, end);
+	fill_dirblock(buf, erofs_blksiz(), q, head, end);
 	return blk_write(buf, blkaddr, 1);
 }
 
@@ -299,7 +299,7 @@ static int erofs_write_dir_file(struct erofs_inode *dir)
 		const unsigned int len = strlen(d->name) +
 			sizeof(struct erofs_dirent);
 
-		if (used + len > EROFS_BLKSIZ) {
+		if (used + len > erofs_blksiz()) {
 			ret = write_dirblock(q, head, d,
 					     dir->u.i_blkaddr + blkno);
 			if (ret)
@@ -313,13 +313,13 @@ static int erofs_write_dir_file(struct erofs_inode *dir)
 		q += sizeof(struct erofs_dirent);
 	}
 
-	DBG_BUGON(used > EROFS_BLKSIZ);
-	if (used == EROFS_BLKSIZ) {
-		DBG_BUGON(dir->i_size % EROFS_BLKSIZ);
+	DBG_BUGON(used > erofs_blksiz());
+	if (used == erofs_blksiz()) {
+		DBG_BUGON(dir->i_size % erofs_blksiz());
 		DBG_BUGON(dir->idata_size);
 		return write_dirblock(q, head, d, dir->u.i_blkaddr + blkno);
 	}
-	DBG_BUGON(used != dir->i_size % EROFS_BLKSIZ);
+	DBG_BUGON(used != dir->i_size % erofs_blksiz());
 	if (used) {
 		/* fill tail-end dir block */
 		dir->idata = malloc(used);
@@ -344,12 +344,12 @@ static int erofs_write_file_from_buffer(struct erofs_inode *inode, char *buf)
 
 	if (nblocks)
 		blk_write(buf, inode->u.i_blkaddr, nblocks);
-	inode->idata_size = inode->i_size % EROFS_BLKSIZ;
+	inode->idata_size = inode->i_size % erofs_blksiz();
 	if (inode->idata_size) {
 		inode->idata = malloc(inode->idata_size);
 		if (!inode->idata)
 			return -ENOMEM;
-		memcpy(inode->idata, buf + blknr_to_addr(nblocks),
+		memcpy(inode->idata, buf + erofs_pos(nblocks),
 		       inode->idata_size);
 	}
 	return 0;
@@ -369,17 +369,17 @@ static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
 	unsigned int nblocks, i;
 
 	inode->datalayout = EROFS_INODE_FLAT_INLINE;
-	nblocks = inode->i_size / EROFS_BLKSIZ;
+	nblocks = inode->i_size / erofs_blksiz();
 
 	ret = __allocate_inode_bh_data(inode, nblocks);
 	if (ret)
 		return ret;
 
 	for (i = 0; i < nblocks; ++i) {
-		char buf[EROFS_BLKSIZ];
+		char buf[EROFS_MAX_BLOCK_SIZE];
 
-		ret = read(fd, buf, EROFS_BLKSIZ);
-		if (ret != EROFS_BLKSIZ) {
+		ret = read(fd, buf, erofs_blksiz());
+		if (ret != erofs_blksiz()) {
 			if (ret < 0)
 				return -errno;
 			return -EAGAIN;
@@ -391,7 +391,7 @@ static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
 	}
 
 	/* read the tail-end data */
-	inode->idata_size = inode->i_size % EROFS_BLKSIZ;
+	inode->idata_size = inode->i_size % erofs_blksiz();
 	if (inode->idata_size) {
 		inode->idata = malloc(inode->idata_size);
 		if (!inode->idata)
@@ -590,7 +590,7 @@ static int erofs_prepare_tail_block(struct erofs_inode *inode)
 
 	bh = inode->bh_data;
 	if (!bh) {
-		bh = erofs_balloc(DATA, EROFS_BLKSIZ, 0, 0);
+		bh = erofs_balloc(DATA, erofs_blksiz(), 0, 0);
 		if (IS_ERR(bh))
 			return PTR_ERR(bh);
 		bh->op = &erofs_skip_write_bhops;
@@ -604,8 +604,8 @@ static int erofs_prepare_tail_block(struct erofs_inode *inode)
 		return 0;
 	}
 	/* expend a block as the tail block (should be successful) */
-	ret = erofs_bh_balloon(bh, EROFS_BLKSIZ);
-	DBG_BUGON(ret != EROFS_BLKSIZ);
+	ret = erofs_bh_balloon(bh, erofs_blksiz());
+	DBG_BUGON(ret != erofs_blksiz());
 	return 0;
 }
 
@@ -729,12 +729,12 @@ static int erofs_write_tail_end(struct erofs_inode *inode)
 		erofs_off_t pos, zero_pos;
 
 		erofs_mapbh(bh->block);
-		pos = erofs_btell(bh, true) - EROFS_BLKSIZ;
+		pos = erofs_btell(bh, true) - erofs_blksiz();
 
 		/* 0'ed data should be padded at head for 0padding conversion */
 		if (erofs_sb_has_lz4_0padding() && inode->compressed_idata) {
 			zero_pos = pos;
-			pos += EROFS_BLKSIZ - inode->idata_size;
+			pos += erofs_blksiz() - inode->idata_size;
 		} else {
 			/* pad 0'ed data for the other cases */
 			zero_pos = pos + inode->idata_size;
@@ -743,10 +743,10 @@ static int erofs_write_tail_end(struct erofs_inode *inode)
 		if (ret)
 			return ret;
 
-		DBG_BUGON(inode->idata_size > EROFS_BLKSIZ);
-		if (inode->idata_size < EROFS_BLKSIZ) {
+		DBG_BUGON(inode->idata_size > erofs_blksiz());
+		if (inode->idata_size < erofs_blksiz()) {
 			ret = dev_fillzero(zero_pos,
-					   EROFS_BLKSIZ - inode->idata_size,
+					   erofs_blksiz() - inode->idata_size,
 					   false);
 			if (ret)
 				return ret;
@@ -996,7 +996,7 @@ static void erofs_fixup_meta_blkaddr(struct erofs_inode *rootdir)
 	off = erofs_btell(bh, false);
 
 	if (off > rootnid_maxoffset)
-		meta_offset = round_up(off - rootnid_maxoffset, EROFS_BLKSIZ);
+		meta_offset = round_up(off - rootnid_maxoffset, erofs_blksiz());
 	else
 		meta_offset = 0;
 	sbi.meta_blkaddr = erofs_blknr(meta_offset);
@@ -1014,7 +1014,7 @@ erofs_nid_t erofs_lookupnid(struct erofs_inode *inode)
 	erofs_mapbh(bh->block);
 	off = erofs_btell(bh, false);
 
-	meta_offset = blknr_to_addr(sbi.meta_blkaddr);
+	meta_offset = erofs_pos(sbi.meta_blkaddr);
 	DBG_BUGON(off < meta_offset);
 	return inode->nid = (off - meta_offset) >> EROFS_ISLOTBITS;
 }
diff --git a/lib/io.c b/lib/io.c
index ccd433f..b318d91 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -82,7 +82,7 @@ int dev_open(const char *dev)
 			close(fd);
 			return ret;
 		}
-		erofs_devsz = round_down(erofs_devsz, EROFS_BLKSIZ);
+		erofs_devsz = round_down(erofs_devsz, erofs_blksiz());
 		break;
 	case S_IFREG:
 		ret = ftruncate(fd, 0);
@@ -192,7 +192,7 @@ int dev_write(const void *buf, u64 offset, size_t len)
 
 int dev_fillzero(u64 offset, size_t len, bool padding)
 {
-	static const char zero[EROFS_BLKSIZ] = {0};
+	static const char zero[EROFS_MAX_BLOCK_SIZE] = {0};
 	int ret;
 
 	if (cfg.c_dry_run)
@@ -203,12 +203,12 @@ int dev_fillzero(u64 offset, size_t len, bool padding)
 				  FALLOC_FL_KEEP_SIZE, offset, len) >= 0)
 		return 0;
 #endif
-	while (len > EROFS_BLKSIZ) {
-		ret = dev_write(zero, offset, EROFS_BLKSIZ);
+	while (len > erofs_blksiz()) {
+		ret = dev_write(zero, offset, erofs_blksiz());
 		if (ret)
 			return ret;
-		len -= EROFS_BLKSIZ;
-		offset += EROFS_BLKSIZ;
+		len -= erofs_blksiz();
+		offset += erofs_blksiz();
 	}
 	return dev_write(zero, offset, len);
 }
@@ -240,7 +240,7 @@ int dev_resize(unsigned int blocks)
 		return -errno;
 	}
 
-	length = (u64)blocks * EROFS_BLKSIZ;
+	length = (u64)blocks * erofs_blksiz();
 	if (st.st_size == length)
 		return 0;
 	if (st.st_size > length)
diff --git a/lib/namei.c b/lib/namei.c
index 7b69a59..6ee4925 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -134,7 +134,7 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 				  vi->u.chunkformat, vi->nid | 0ULL);
 			return -EOPNOTSUPP;
 		}
-		vi->u.chunkbits = LOG_BLOCK_SIZE +
+		vi->u.chunkbits = sbi.blkszbits +
 			(vi->u.chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
 	} else if (erofs_inode_is_data_compressed(vi->datalayout))
 		return z_erofs_fill_inode(vi);
@@ -186,12 +186,11 @@ struct nameidata {
 	unsigned int	ftype;
 };
 
-int erofs_namei(struct nameidata *nd,
-		const char *name, unsigned int len)
+int erofs_namei(struct nameidata *nd, const char *name, unsigned int len)
 {
 	erofs_nid_t nid = nd->nid;
 	int ret;
-	char buf[EROFS_BLKSIZ];
+	char buf[EROFS_MAX_BLOCK_SIZE];
 	struct erofs_inode vi = { .nid = nid };
 	erofs_off_t offset;
 
@@ -202,7 +201,7 @@ int erofs_namei(struct nameidata *nd,
 	offset = 0;
 	while (offset < vi.i_size) {
 		erofs_off_t maxsize = min_t(erofs_off_t,
-					    vi.i_size - offset, EROFS_BLKSIZ);
+					    vi.i_size - offset, erofs_blksiz());
 		struct erofs_dirent *de = (void *)buf;
 		unsigned int nameoff;
 
@@ -212,7 +211,7 @@ int erofs_namei(struct nameidata *nd,
 
 		nameoff = le16_to_cpu(de->nameoff);
 		if (nameoff < sizeof(struct erofs_dirent) ||
-		    nameoff >= EROFS_BLKSIZ) {
+		    nameoff >= erofs_blksiz()) {
 			erofs_err("invalid de[0].nameoff %u @ nid %llu",
 				  nameoff, nid | 0ULL);
 			return -EFSCORRUPTED;
diff --git a/lib/super.c b/lib/super.c
index 6b91011..ff19493 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -68,7 +68,7 @@ static int erofs_init_devices(struct erofs_sb_info *sbi,
 
 int erofs_read_superblock(void)
 {
-	char data[EROFS_BLKSIZ];
+	char data[EROFS_MAX_BLOCK_SIZE];
 	struct erofs_super_block *dsb;
 	int ret;
 
@@ -89,9 +89,9 @@ int erofs_read_superblock(void)
 
 	sbi.blkszbits = dsb->blkszbits;
 	/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
-	if (sbi.blkszbits != LOG_BLOCK_SIZE) {
+	if (1u << sbi.blkszbits != PAGE_SIZE) {
 		erofs_err("blksize %d isn't supported on this platform",
-			  1 << sbi.blkszbits);
+			  erofs_blksiz());
 		return ret;
 	}
 
diff --git a/lib/xattr.c b/lib/xattr.c
index dbe0519..1a22284 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -619,8 +619,8 @@ int erofs_build_shared_xattrs_from_path(const char *path)
 	erofs_mapbh(bh->block);
 	off = erofs_btell(bh, false);
 
-	sbi.xattr_blkaddr = off / EROFS_BLKSIZ;
-	off %= EROFS_BLKSIZ;
+	sbi.xattr_blkaddr = off / erofs_blksiz();
+	off %= erofs_blksiz();
 	p = 0;
 
 	sorted_n = malloc(shared_xattrs_count * sizeof(n));
@@ -716,7 +716,7 @@ char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned int size)
 }
 
 struct xattr_iter {
-	char page[EROFS_BLKSIZ];
+	char page[EROFS_MAX_BLOCK_SIZE];
 
 	void *kaddr;
 
@@ -775,9 +775,9 @@ static int init_inode_xattrs(struct erofs_inode *vi)
 	it.ofs += sizeof(struct erofs_xattr_ibody_header);
 
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
-		if (it.ofs >= EROFS_BLKSIZ) {
+		if (it.ofs >= erofs_blksiz()) {
 			/* cannot be unaligned */
-			DBG_BUGON(it.ofs != EROFS_BLKSIZ);
+			DBG_BUGON(it.ofs != erofs_blksiz());
 
 			ret = blk_read(0, it.page, ++it.blkaddr, 1);
 			if (ret < 0) {
@@ -819,7 +819,7 @@ static inline int xattr_iter_fixup(struct xattr_iter *it)
 {
 	int ret;
 
-	if (it->ofs < EROFS_BLKSIZ)
+	if (it->ofs < erofs_blksiz())
 		return 0;
 
 	it->blkaddr += erofs_blknr(it->ofs);
@@ -906,8 +906,8 @@ static int xattr_foreach(struct xattr_iter *it,
 	processed = 0;
 
 	while (processed < entry.e_name_len) {
-		if (it->ofs >= EROFS_BLKSIZ) {
-			DBG_BUGON(it->ofs > EROFS_BLKSIZ);
+		if (it->ofs >= erofs_blksiz()) {
+			DBG_BUGON(it->ofs > erofs_blksiz());
 
 			err = xattr_iter_fixup(it);
 			if (err)
@@ -915,7 +915,7 @@ static int xattr_foreach(struct xattr_iter *it,
 			it->ofs = 0;
 		}
 
-		slice = min_t(unsigned int, EROFS_BLKSIZ - it->ofs,
+		slice = min_t(unsigned int, erofs_blksiz() - it->ofs,
 			      entry.e_name_len - processed);
 
 		/* handle name */
@@ -941,8 +941,8 @@ static int xattr_foreach(struct xattr_iter *it,
 	}
 
 	while (processed < value_sz) {
-		if (it->ofs >= EROFS_BLKSIZ) {
-			DBG_BUGON(it->ofs > EROFS_BLKSIZ);
+		if (it->ofs >= erofs_blksiz()) {
+			DBG_BUGON(it->ofs > erofs_blksiz());
 
 			err = xattr_iter_fixup(it);
 			if (err)
@@ -950,7 +950,7 @@ static int xattr_foreach(struct xattr_iter *it,
 			it->ofs = 0;
 		}
 
-		slice = min_t(unsigned int, EROFS_BLKSIZ - it->ofs,
+		slice = min_t(unsigned int, erofs_blksiz() - it->ofs,
 			      value_sz - processed);
 		op->value(it, processed, it->kaddr + it->ofs, slice);
 		it->ofs += slice;
diff --git a/lib/zmap.c b/lib/zmap.c
index 69b468d..7b0fd83 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -22,7 +22,7 @@ int z_erofs_fill_inode(struct erofs_inode *vi)
 		vi->z_advise = 0;
 		vi->z_algorithmtype[0] = 0;
 		vi->z_algorithmtype[1] = 0;
-		vi->z_logical_clusterbits = LOG_BLOCK_SIZE;
+		vi->z_logical_clusterbits = sbi.blkszbits;
 
 		vi->flags |= EROFS_I_Z_INITED;
 	}
@@ -66,7 +66,7 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 		return -EOPNOTSUPP;
 	}
 
-	vi->z_logical_clusterbits = LOG_BLOCK_SIZE + (h->h_clusterbits & 7);
+	vi->z_logical_clusterbits = sbi.blkszbits + (h->h_clusterbits & 7);
 	if (vi->datalayout == EROFS_INODE_FLAT_COMPRESSION &&
 	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1) ^
 	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
@@ -82,7 +82,7 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 		ret = z_erofs_do_map_blocks(vi, &map,
 					    EROFS_GET_BLOCKS_FINDTAIL);
 		if (!map.m_plen ||
-		    erofs_blkoff(map.m_pa) + map.m_plen > EROFS_BLKSIZ) {
+		    erofs_blkoff(map.m_pa) + map.m_plen > erofs_blksiz()) {
 			erofs_err("invalid tail-packing pclustersize %llu",
 				  map.m_plen | 0ULL);
 			return -EFSCORRUPTED;
@@ -496,7 +496,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 		 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type
 		 * rather than CBLKCNT, it's a 1 lcluster-sized pcluster.
 		 */
-		m->compressedblks = 1 << (lclusterbits - LOG_BLOCK_SIZE);
+		m->compressedblks = 1 << (lclusterbits - sbi.blkszbits);
 		break;
 	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
 		if (m->delta[0] != 1)
@@ -511,7 +511,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 		return -EFSCORRUPTED;
 	}
 out:
-	map->m_plen = m->compressedblks << LOG_BLOCK_SIZE;
+	map->m_plen = m->compressedblks << sbi.blkszbits;
 	return 0;
 err_bonus_cblkcnt:
 	erofs_err("bogus CBLKCNT @ lcn %lu of nid %llu",
@@ -640,7 +640,7 @@ static int z_erofs_do_map_blocks(struct erofs_inode *vi,
 	} else if (fragment && m.lcn == vi->z_tailextent_headlcn) {
 		map->m_flags |= EROFS_MAP_FRAGMENT;
 	} else {
-		map->m_pa = blknr_to_addr(m.pblk);
+		map->m_pa = erofs_pos(m.pblk);
 		err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
 		if (err)
 			goto out;
diff --git a/mkfs/main.c b/mkfs/main.c
index be3d805..b4e4c8d 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -474,7 +474,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		}
 	}
 
-	if (cfg.c_blobdev_path && cfg.c_chunkbits < LOG_BLOCK_SIZE) {
+	if (cfg.c_blobdev_path && cfg.c_chunkbits < sbi.blkszbits) {
 		erofs_err("--blobdev must be used together with --chunksize");
 		return -EINVAL;
 	}
@@ -517,29 +517,29 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 	}
 
 	if (pclustersize_max) {
-		if (pclustersize_max < EROFS_BLKSIZ ||
-		    pclustersize_max % EROFS_BLKSIZ) {
+		if (pclustersize_max < erofs_blksiz() ||
+		    pclustersize_max % erofs_blksiz()) {
 			erofs_err("invalid physical clustersize %u",
 				  pclustersize_max);
 			return -EINVAL;
 		}
-		cfg.c_pclusterblks_max = pclustersize_max / EROFS_BLKSIZ;
+		cfg.c_pclusterblks_max = pclustersize_max >> sbi.blkszbits;
 		cfg.c_pclusterblks_def = cfg.c_pclusterblks_max;
 	}
-	if (cfg.c_chunkbits && 1u << cfg.c_chunkbits < EROFS_BLKSIZ) {
+	if (cfg.c_chunkbits && cfg.c_chunkbits < sbi.blkszbits) {
 		erofs_err("chunksize %u must be larger than block size",
 			  1u << cfg.c_chunkbits);
 		return -EINVAL;
 	}
 
 	if (pclustersize_packed) {
-		if (pclustersize_max < EROFS_BLKSIZ ||
-		    pclustersize_max % EROFS_BLKSIZ) {
+		if (pclustersize_max < erofs_blksiz() ||
+		    pclustersize_max % erofs_blksiz()) {
 			erofs_err("invalid pcluster size for the packed file %u",
 				  pclustersize_packed);
 			return -EINVAL;
 		}
-		cfg.c_pclusterblks_packed = pclustersize_packed / EROFS_BLKSIZ;
+		cfg.c_pclusterblks_packed = pclustersize_packed >> sbi.blkszbits;
 	}
 	return 0;
 }
@@ -551,7 +551,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 {
 	struct erofs_super_block sb = {
 		.magic     = cpu_to_le32(EROFS_SUPER_MAGIC_V1),
-		.blkszbits = LOG_BLOCK_SIZE,
+		.blkszbits = sbi.blkszbits,
 		.inos   = cpu_to_le64(sbi.inos),
 		.build_time = cpu_to_le64(sbi.build_time),
 		.build_time_nsec = cpu_to_le32(sbi.build_time_nsec),
@@ -564,8 +564,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 		.extra_devices = cpu_to_le16(sbi.extra_devices),
 		.devt_slotoff = cpu_to_le16(sbi.devt_slotoff),
 	};
-	const unsigned int sb_blksize =
-		round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
+	const u32 sb_blksize = round_up(EROFS_SUPER_END, erofs_blksiz());
 	char *buf;
 
 	*blocks         = erofs_mapbh(NULL);
@@ -596,7 +595,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 static int erofs_mkfs_superblock_csum_set(void)
 {
 	int ret;
-	u8 buf[EROFS_BLKSIZ];
+	u8 buf[EROFS_MAX_BLOCK_SIZE];
 	u32 crc;
 	struct erofs_super_block *sb;
 
@@ -621,7 +620,7 @@ static int erofs_mkfs_superblock_csum_set(void)
 	/* turn on checksum feature */
 	sb->feature_compat = cpu_to_le32(le32_to_cpu(sb->feature_compat) |
 					 EROFS_FEATURE_COMPAT_SB_CHKSUM);
-	crc = erofs_crc32c(~0, (u8 *)sb, EROFS_BLKSIZ - EROFS_SUPER_OFFSET);
+	crc = erofs_crc32c(~0, (u8 *)sb, erofs_blksiz() - EROFS_SUPER_OFFSET);
 
 	/* set up checksum field to erofs_super_block */
 	sb->checksum = cpu_to_le32(crc);
@@ -801,9 +800,9 @@ int main(int argc, char **argv)
 	if (cfg.c_dedupe) {
 		if (!cfg.c_compr_alg[0]) {
 			erofs_err("Compression is not enabled.  Turn on chunk-based data deduplication instead.");
-			cfg.c_chunkbits = LOG_BLOCK_SIZE;
+			cfg.c_chunkbits = sbi.blkszbits;
 		} else {
-			err = z_erofs_dedupe_init(EROFS_BLKSIZ);
+			err = z_erofs_dedupe_init(erofs_blksiz());
 			if (err) {
 				erofs_err("failed to initialize deduplication: %s",
 					  erofs_strerror(err));
-- 
2.24.4

