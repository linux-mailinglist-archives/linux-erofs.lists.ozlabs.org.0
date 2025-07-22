Return-Path: <linux-erofs+bounces-694-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 721BAB0CEC2
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Jul 2025 02:32:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bmJBm4bW4z2yLB;
	Tue, 22 Jul 2025 10:32:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753144368;
	cv=none; b=DSVhX2Xs8E4TRm5CHE86eaMVxhWoiBNIVihcqW/ItHZHgK+Ns9f5mpB7J57JXR8YUE8jhxAiNOsH93kDhCCcrIrxWo86qTK+X/iD/tbVjDTXS1bR4RaDAYtRe5T3Ub27M/ZmVIAs3dJBYteNZ8ViYZgcj3gnqTpZob0cP1oEt7hpXJ1zd4wr6Scol7CIXHgxgthp4wVOXckzco0MzFYW103eqSh5TmlfAiNyBB6HfEj3qy7FvU+Rk8vJOK8dlc3YfjJw3gwgFP/9gtvAG64NOyFRAvaBbqlurt3vuJ6GxV2K52o9mRR2KvFLa1ZG3TGeAMZk2fqM28S3gIpFXqIIhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753144368; c=relaxed/relaxed;
	bh=Um/Bwo24uBiewympjf4v089QIkczBuYqgLyyT9izzz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NVVl0WRgNBTKoaE1LsV3JbVl6ZnmAKCqjLfBW3vxfnCtkJz9u3/c7HabNIFDto9CDYw3VyX0DMg5U1Y/VSvvyPGRlNPjxerlH8zxp4r1ek7TONUyuryaDgU1E47sH2lvLG8wfVfYgJrT6Ex3DuK675XOJ8Tva/y0ALuWcY519LpG8eVc/uVP8223NYTSNbOaZpHf8QAB4st0ks8eRFpJoc5wJU9X5vbPPaqUnKzPHWDTYKYUW8qXrzo6KTyVk+hXfPOQnu+YVmWHwPcsydWZ13hQb81tjzRUsli9N42jEPcsJ7CzBKeGkO/AQ+GhMbEhFsiDC9gJd4jbEQSywk3EHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rxGTUF9a; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rxGTUF9a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bmJBk2Lq8z2xTh
	for <linux-erofs@lists.ozlabs.org>; Tue, 22 Jul 2025 10:32:44 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753144360; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Um/Bwo24uBiewympjf4v089QIkczBuYqgLyyT9izzz8=;
	b=rxGTUF9a7j86vsueeM6m44In+JXvpv9OB6mULPr9WrdbNRCXAFyz5KNS6BRqHb6e3jgZhy3FZYgqd2vR3ucla0zC09XrhTMlIWM/8ZLVykZzexww2o7KCGStz+fuTLpvoPSPkU+bGZ8xHMg/fRmvYQHlWW6dGvZXth7pr8ZPYxQ=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WjTQzeR_1753144352 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 22 Jul 2025 08:32:38 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Bo Liu <liubo03@inspur.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v7 2/2] erofs: implement metadata compression
Date: Tue, 22 Jul 2025 08:32:29 +0800
Message-ID: <20250722003229.2121752-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250718031942.3052585-1-hsiangkao@linux.alibaba.com>
References: <20250718031942.3052585-1-hsiangkao@linux.alibaba.com>
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Bo Liu <liubo03@inspur.com>

Thanks to the meta buffer infrastructure, metadata-compressed inodes are
just read from the metabox inode instead of the blockdevice (or backing
file) inode.

The same is true for shared extended attributes.

When metadata compression is enabled, inode numbers are divided from
on-disk NIDs because of non-LTS 32-bit application compatibility.

Co-developed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Bo Liu <liubo03@inspur.com>
Acked-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
change since v6:
 - fix i386 build warning:
     https://lore.kernel.org/r/b555f01c-4e9e-4b42-aa5a-2d35ef9c1c50@infradead.org
 Documentation/ABI/testing/sysfs-fs-erofs |  2 +-
 fs/erofs/data.c                          | 59 +++++++++++++++---------
 fs/erofs/decompressor.c                  |  2 +-
 fs/erofs/dir.c                           |  3 +-
 fs/erofs/erofs_fs.h                      |  2 +-
 fs/erofs/fileio.c                        |  2 +-
 fs/erofs/fscache.c                       |  3 +-
 fs/erofs/inode.c                         | 17 +++----
 fs/erofs/internal.h                      | 34 ++++++++++++--
 fs/erofs/super.c                         | 22 ++++++++-
 fs/erofs/sysfs.c                         |  2 +
 fs/erofs/xattr.c                         | 26 +++++++----
 fs/erofs/zdata.c                         |  5 +-
 fs/erofs/zmap.c                          | 16 ++++---
 14 files changed, 136 insertions(+), 59 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
index bf3b6299c15e..ad6d1a3ccd4e 100644
--- a/Documentation/ABI/testing/sysfs-fs-erofs
+++ b/Documentation/ABI/testing/sysfs-fs-erofs
@@ -5,7 +5,7 @@ Description:	Shows all enabled kernel features.
 		Supported features:
 		zero_padding, compr_cfgs, big_pcluster, chunked_file,
 		device_table, compr_head2, sb_chksum, ztailpacking,
-		dedupe, fragments.
+		dedupe, fragments, 48bit, metabox.
 
 What:		/sys/fs/erofs/<disk>/sync_decompress
 Date:		November 2021
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 383c1337e157..f46c47335b9c 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -49,11 +49,18 @@ void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset, bool need_kmap)
 	return buf->base + (offset & ~PAGE_MASK);
 }
 
-void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
+int erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb,
+		       bool in_metabox)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
 	buf->file = NULL;
+	if (in_metabox) {
+		if (unlikely(!sbi->metabox_inode))
+			return -EFSCORRUPTED;
+		buf->mapping = sbi->metabox_inode->i_mapping;
+		return 0;
+	}
 	buf->off = sbi->dif0.fsoff;
 	if (erofs_is_fileio_mode(sbi)) {
 		buf->file = sbi->dif0.file;	/* some fs like FUSE needs it */
@@ -62,12 +69,17 @@ void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
 		buf->mapping = sbi->dif0.fscache->inode->i_mapping;
 	else
 		buf->mapping = sb->s_bdev->bd_mapping;
+	return 0;
 }
 
 void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
-			 erofs_off_t offset)
+			 erofs_off_t offset, bool in_metabox)
 {
-	erofs_init_metabuf(buf, sb);
+	int err;
+
+	err = erofs_init_metabuf(buf, sb, in_metabox);
+	if (err)
+		return ERR_PTR(err);
 	return erofs_bread(buf, offset, true);
 }
 
@@ -118,7 +130,7 @@ int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
 	pos = ALIGN(erofs_iloc(inode) + vi->inode_isize +
 		    vi->xattr_isize, unit) + unit * chunknr;
 
-	idx = erofs_read_metabuf(&buf, sb, pos);
+	idx = erofs_read_metabuf(&buf, sb, pos, erofs_inode_in_metabox(inode));
 	if (IS_ERR(idx)) {
 		err = PTR_ERR(idx);
 		goto out;
@@ -264,7 +276,6 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 
 	map.m_la = offset;
 	map.m_llen = length;
-
 	ret = erofs_map_blocks(inode, &map);
 	if (ret < 0)
 		return ret;
@@ -273,35 +284,37 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	iomap->length = map.m_llen;
 	iomap->flags = 0;
 	iomap->private = NULL;
+	iomap->addr = IOMAP_NULL_ADDR;
 	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
 		iomap->type = IOMAP_HOLE;
-		iomap->addr = IOMAP_NULL_ADDR;
 		return 0;
 	}
 
-	mdev = (struct erofs_map_dev) {
-		.m_deviceid = map.m_deviceid,
-		.m_pa = map.m_pa,
-	};
-	ret = erofs_map_dev(sb, &mdev);
-	if (ret)
-		return ret;
-
-	if (flags & IOMAP_DAX)
-		iomap->dax_dev = mdev.m_dif->dax_dev;
-	else
-		iomap->bdev = mdev.m_bdev;
-
-	iomap->addr = mdev.m_dif->fsoff + mdev.m_pa;
-	if (flags & IOMAP_DAX)
-		iomap->addr += mdev.m_dif->dax_part_off;
+	if (!(map.m_flags & EROFS_MAP_META) || !erofs_inode_in_metabox(inode)) {
+		mdev = (struct erofs_map_dev) {
+			.m_deviceid = map.m_deviceid,
+			.m_pa = map.m_pa,
+		};
+		ret = erofs_map_dev(sb, &mdev);
+		if (ret)
+			return ret;
+
+		if (flags & IOMAP_DAX)
+			iomap->dax_dev = mdev.m_dif->dax_dev;
+		else
+			iomap->bdev = mdev.m_bdev;
+		iomap->addr = mdev.m_dif->fsoff + mdev.m_pa;
+		if (flags & IOMAP_DAX)
+			iomap->addr += mdev.m_dif->dax_part_off;
+	}
 
 	if (map.m_flags & EROFS_MAP_META) {
 		void *ptr;
 		struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 
 		iomap->type = IOMAP_INLINE;
-		ptr = erofs_read_metabuf(&buf, sb, mdev.m_pa);
+		ptr = erofs_read_metabuf(&buf, sb, map.m_pa,
+					 erofs_inode_in_metabox(inode));
 		if (IS_ERR(ptr))
 			return PTR_ERR(ptr);
 		iomap->inline_data = ptr;
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 358061d7b660..354762c9723f 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -467,7 +467,7 @@ int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb)
 		return -EOPNOTSUPP;
 	}
 
-	erofs_init_metabuf(&buf, sb);
+	(void)erofs_init_metabuf(&buf, sb, false);
 	offset = EROFS_SUPER_OFFSET + sbi->sb_size;
 	alg = 0;
 	for (algs = sbi->available_compr_algs; algs; algs >>= 1, ++alg) {
diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index 3e4b38bec0aa..d1c6cd1a45e8 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -34,7 +34,8 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
 		}
 
 		if (!dir_emit(ctx, de_name, de_namelen,
-			      le64_to_cpu(de->nid), d_type))
+			      erofs_nid_to_ino64(EROFS_SB(dir->i_sb),
+						 le64_to_cpu(de->nid)), d_type))
 			return 1;
 		++de;
 		ctx->pos += sizeof(struct erofs_dirent);
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 7b150ac64742..377ee12b8b96 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -34,7 +34,7 @@
 #define EROFS_FEATURE_INCOMPAT_48BIT		0x00000080
 #define EROFS_FEATURE_INCOMPAT_METABOX		0x00000100
 #define EROFS_ALL_FEATURE_INCOMPAT		\
-	((EROFS_FEATURE_INCOMPAT_48BIT << 1) - 1)
+	((EROFS_FEATURE_INCOMPAT_METABOX << 1) - 1)
 
 #define EROFS_SB_EXTSLOT_SIZE	16
 
diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index 3ee082476c8c..b7b3432a9882 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -115,7 +115,7 @@ static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
 			void *src;
 
 			src = erofs_read_metabuf(&buf, inode->i_sb,
-						 map->m_pa + ofs);
+				map->m_pa + ofs, erofs_inode_in_metabox(inode));
 			if (IS_ERR(src)) {
 				err = PTR_ERR(src);
 				break;
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 9a8ee646e51d..362acf828279 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -274,7 +274,8 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_rq *req)
 		size_t size = map.m_llen;
 		void *src;
 
-		src = erofs_read_metabuf(&buf, sb, map.m_pa);
+		src = erofs_read_metabuf(&buf, sb, map.m_pa,
+					 erofs_inode_in_metabox(inode));
 		if (IS_ERR(src))
 			return PTR_ERR(src);
 
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 47215c5e3385..9a2f59721522 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -29,6 +29,7 @@ static int erofs_read_inode(struct inode *inode)
 	struct super_block *sb = inode->i_sb;
 	erofs_blk_t blkaddr = erofs_blknr(sb, erofs_iloc(inode));
 	unsigned int ofs = erofs_blkoff(sb, erofs_iloc(inode));
+	bool in_mbox = erofs_inode_in_metabox(inode);
 	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	erofs_blk_t addrmask = BIT_ULL(48) - 1;
@@ -39,7 +40,7 @@ static int erofs_read_inode(struct inode *inode)
 	void *ptr;
 	int err = 0;
 
-	ptr = erofs_read_metabuf(&buf, sb, erofs_pos(sb, blkaddr));
+	ptr = erofs_read_metabuf(&buf, sb, erofs_pos(sb, blkaddr), in_mbox);
 	if (IS_ERR(ptr)) {
 		err = PTR_ERR(ptr);
 		erofs_err(sb, "failed to read inode meta block (nid: %llu): %d",
@@ -78,7 +79,7 @@ static int erofs_read_inode(struct inode *inode)
 
 			memcpy(&copied, dic, gotten);
 			ptr = erofs_read_metabuf(&buf, sb,
-					erofs_pos(sb, blkaddr + 1));
+					erofs_pos(sb, blkaddr + 1), in_mbox);
 			if (IS_ERR(ptr)) {
 				err = PTR_ERR(ptr);
 				erofs_err(sb, "failed to read inode payload block (nid: %llu): %d",
@@ -264,13 +265,13 @@ static int erofs_fill_inode(struct inode *inode)
  * ino_t is 32-bits on 32-bit arch. We have to squash the 64-bit value down
  * so that it will fit.
  */
-static ino_t erofs_squash_ino(erofs_nid_t nid)
+static ino_t erofs_squash_ino(struct super_block *sb, erofs_nid_t nid)
 {
-	ino_t ino = (ino_t)nid;
+	u64 ino64 = erofs_nid_to_ino64(EROFS_SB(sb), nid);
 
 	if (sizeof(ino_t) < sizeof(erofs_nid_t))
-		ino ^= nid >> (sizeof(erofs_nid_t) - sizeof(ino_t)) * 8;
-	return ino;
+		ino64 ^= ino64 >> (sizeof(erofs_nid_t) - sizeof(ino_t)) * 8;
+	return (ino_t)ino64;
 }
 
 static int erofs_iget5_eq(struct inode *inode, void *opaque)
@@ -282,7 +283,7 @@ static int erofs_iget5_set(struct inode *inode, void *opaque)
 {
 	const erofs_nid_t nid = *(erofs_nid_t *)opaque;
 
-	inode->i_ino = erofs_squash_ino(nid);
+	inode->i_ino = erofs_squash_ino(inode->i_sb, nid);
 	EROFS_I(inode)->nid = nid;
 	return 0;
 }
@@ -291,7 +292,7 @@ struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid)
 {
 	struct inode *inode;
 
-	inode = iget5_locked(sb, erofs_squash_ino(nid), erofs_iget5_eq,
+	inode = iget5_locked(sb, erofs_squash_ino(sb, nid), erofs_iget5_eq,
 			     erofs_iget5_set, &nid);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index ad932f670bb6..26f9aa57ff3c 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -125,6 +125,7 @@ struct erofs_sb_info {
 	struct erofs_sb_lz4_info lz4;
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	struct inode *packed_inode;
+	struct inode *metabox_inode;
 	struct erofs_dev_context *devs;
 	u64 total_blocks;
 
@@ -148,6 +149,7 @@ struct erofs_sb_info {
 	/* what we really care is nid, rather than ino.. */
 	erofs_nid_t root_nid;
 	erofs_nid_t packed_nid;
+	erofs_nid_t metabox_nid;
 	/* used for statfs, f_files - f_favail */
 	u64 inos;
 
@@ -232,6 +234,23 @@ EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
 EROFS_FEATURE_FUNCS(shared_ea_in_metabox, compat, COMPAT_SHARED_EA_IN_METABOX)
 
+static inline u64 erofs_nid_to_ino64(struct erofs_sb_info *sbi, erofs_nid_t nid)
+{
+	if (!erofs_sb_has_metabox(sbi))
+		return nid;
+
+	/*
+	 * When metadata compression is enabled, avoid generating excessively
+	 * large inode numbers for metadata-compressed inodes.  Shift NIDs in
+	 * the 31-62 bit range left by one and move the metabox flag to bit 31.
+	 *
+	 * Note: on-disk NIDs remain unchanged as they are primarily used for
+	 * compatibility with non-LFS 32-bit applications.
+	 */
+	return ((nid << 1) & GENMASK_ULL(63, 32)) | (nid & GENMASK(30, 0)) |
+		((nid >> EROFS_DIRENT_NID_METABOX_BIT) << 31);
+}
+
 /* atomic flag definitions */
 #define EROFS_I_EA_INITED_BIT	0
 #define EROFS_I_Z_INITED_BIT	1
@@ -281,12 +300,20 @@ struct erofs_inode {
 
 #define EROFS_I(ptr)	container_of(ptr, struct erofs_inode, vfs_inode)
 
+static inline bool erofs_inode_in_metabox(struct inode *inode)
+{
+	return EROFS_I(inode)->nid & BIT_ULL(EROFS_DIRENT_NID_METABOX_BIT);
+}
+
 static inline erofs_off_t erofs_iloc(struct inode *inode)
 {
 	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
+	erofs_nid_t nid_lo = EROFS_I(inode)->nid & EROFS_DIRENT_NID_MASK;
 
+	if (erofs_inode_in_metabox(inode))
+		return nid_lo << sbi->islotbits;
 	return erofs_pos(inode->i_sb, sbi->meta_blkaddr) +
-		(EROFS_I(inode)->nid << sbi->islotbits);
+		(nid_lo << sbi->islotbits);
 }
 
 static inline unsigned int erofs_inode_version(unsigned int ifmt)
@@ -385,9 +412,10 @@ void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
 void erofs_unmap_metabuf(struct erofs_buf *buf);
 void erofs_put_metabuf(struct erofs_buf *buf);
 void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset, bool need_kmap);
-void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb);
+int erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb,
+		       bool in_metabox);
 void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
-			 erofs_off_t offset);
+			 erofs_off_t offset, bool in_metabox);
 int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *dev);
 int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		 u64 start, u64 len);
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index bc27fa3bd678..c7b9b784dc3d 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -141,7 +141,7 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 	struct erofs_deviceslot *dis;
 	struct file *file;
 
-	dis = erofs_read_metabuf(buf, sb, *pos);
+	dis = erofs_read_metabuf(buf, sb, *pos, false);
 	if (IS_ERR(dis))
 		return PTR_ERR(dis);
 
@@ -258,7 +258,7 @@ static int erofs_read_superblock(struct super_block *sb)
 	void *data;
 	int ret;
 
-	data = erofs_read_metabuf(&buf, sb, 0);
+	data = erofs_read_metabuf(&buf, sb, 0, false);
 	if (IS_ERR(data)) {
 		erofs_err(sb, "cannot read erofs superblock");
 		return PTR_ERR(data);
@@ -319,6 +319,14 @@ static int erofs_read_superblock(struct super_block *sb)
 		sbi->root_nid = le16_to_cpu(dsb->rb.rootnid_2b);
 	}
 	sbi->packed_nid = le64_to_cpu(dsb->packed_nid);
+	if (erofs_sb_has_metabox(sbi)) {
+		if (sbi->sb_size <= offsetof(struct erofs_super_block,
+					     metabox_nid))
+			return -EFSCORRUPTED;
+		sbi->metabox_nid = le64_to_cpu(dsb->metabox_nid);
+		if (sbi->metabox_nid & BIT_ULL(EROFS_DIRENT_NID_METABOX_BIT))
+			return -EFSCORRUPTED;	/* self-loop detection */
+	}
 	sbi->inos = le64_to_cpu(dsb->inos);
 
 	sbi->epoch = (s64)le64_to_cpu(dsb->epoch);
@@ -335,6 +343,8 @@ static int erofs_read_superblock(struct super_block *sb)
 
 	if (erofs_sb_has_48bit(sbi))
 		erofs_info(sb, "EXPERIMENTAL 48-bit layout support in use. Use at your own risk!");
+	if (erofs_sb_has_metabox(sbi))
+		erofs_info(sb, "EXPERIMENTAL metadata compression support in use. Use at your own risk!");
 	if (erofs_is_fscache_mode(sb))
 		erofs_info(sb, "[deprecated] fscache-based on-demand read feature in use. Use at your own risk!");
 out:
@@ -690,6 +700,12 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 			return PTR_ERR(inode);
 		sbi->packed_inode = inode;
 	}
+	if (erofs_sb_has_metabox(sbi)) {
+		inode = erofs_iget(sb, sbi->metabox_nid);
+		if (IS_ERR(inode))
+			return PTR_ERR(inode);
+		sbi->metabox_inode = inode;
+	}
 
 	inode = erofs_iget(sb, sbi->root_nid);
 	if (IS_ERR(inode))
@@ -845,6 +861,8 @@ static void erofs_drop_internal_inodes(struct erofs_sb_info *sbi)
 {
 	iput(sbi->packed_inode);
 	sbi->packed_inode = NULL;
+	iput(sbi->metabox_inode);
+	sbi->metabox_inode = NULL;
 #ifdef CONFIG_EROFS_FS_ZIP
 	iput(sbi->managed_cache);
 	sbi->managed_cache = NULL;
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index eed8797a193f..a9fe35ba0906 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -95,6 +95,7 @@ EROFS_ATTR_FEATURE(ztailpacking);
 EROFS_ATTR_FEATURE(fragments);
 EROFS_ATTR_FEATURE(dedupe);
 EROFS_ATTR_FEATURE(48bit);
+EROFS_ATTR_FEATURE(metabox);
 
 static struct attribute *erofs_feat_attrs[] = {
 	ATTR_LIST(zero_padding),
@@ -108,6 +109,7 @@ static struct attribute *erofs_feat_attrs[] = {
 	ATTR_LIST(fragments),
 	ATTR_LIST(dedupe),
 	ATTR_LIST(48bit),
+	ATTR_LIST(metabox),
 	NULL,
 };
 ATTRIBUTE_GROUPS(erofs_feat);
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index d61110f511e0..eaa9efd766ee 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -77,7 +77,9 @@ static int erofs_init_inode_xattrs(struct inode *inode)
 	}
 
 	it.buf = __EROFS_BUF_INITIALIZER;
-	erofs_init_metabuf(&it.buf, sb);
+	ret = erofs_init_metabuf(&it.buf, sb, erofs_inode_in_metabox(inode));
+	if (ret)
+		goto out_unlock;
 	it.pos = erofs_iloc(inode) + vi->inode_isize;
 
 	/* read in shared xattr array (non-atomic, see kmalloc below) */
@@ -326,6 +328,9 @@ static int erofs_xattr_iter_inline(struct erofs_xattr_iter *it,
 		return -ENODATA;
 	}
 
+	ret = erofs_init_metabuf(&it->buf, it->sb, erofs_inode_in_metabox(inode));
+	if (ret)
+		return ret;
 	remaining = vi->xattr_isize - xattr_header_sz;
 	it->pos = erofs_iloc(inode) + vi->inode_isize + xattr_header_sz;
 
@@ -361,12 +366,17 @@ static int erofs_xattr_iter_shared(struct erofs_xattr_iter *it,
 	struct erofs_inode *const vi = EROFS_I(inode);
 	struct super_block *const sb = it->sb;
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
-	unsigned int i;
-	int ret = -ENODATA;
+	unsigned int i = 0;
+	int ret;
 
-	for (i = 0; i < vi->xattr_shared_count; ++i) {
+	ret = erofs_init_metabuf(&it->buf, sb,
+				 erofs_sb_has_shared_ea_in_metabox(sbi));
+	if (ret)
+		return ret;
+
+	while (i < vi->xattr_shared_count) {
 		it->pos = erofs_pos(sb, sbi->xattr_blkaddr) +
-				vi->xattr_shared_xattrs[i] * sizeof(__le32);
+				vi->xattr_shared_xattrs[i++] * sizeof(__le32);
 		it->kaddr = erofs_bread(&it->buf, it->pos, true);
 		if (IS_ERR(it->kaddr))
 			return PTR_ERR(it->kaddr);
@@ -378,7 +388,7 @@ static int erofs_xattr_iter_shared(struct erofs_xattr_iter *it,
 		if ((getxattr && ret != -ENODATA) || (!getxattr && ret))
 			break;
 	}
-	return ret;
+	return i ? ret : -ENODATA;
 }
 
 int erofs_getxattr(struct inode *inode, int index, const char *name,
@@ -413,7 +423,6 @@ int erofs_getxattr(struct inode *inode, int index, const char *name,
 
 	it.sb = inode->i_sb;
 	it.buf = __EROFS_BUF_INITIALIZER;
-	erofs_init_metabuf(&it.buf, it.sb);
 	it.buffer = buffer;
 	it.buffer_size = buffer_size;
 	it.buffer_ofs = 0;
@@ -439,7 +448,6 @@ ssize_t erofs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 
 	it.sb = dentry->d_sb;
 	it.buf = __EROFS_BUF_INITIALIZER;
-	erofs_init_metabuf(&it.buf, it.sb);
 	it.dentry = dentry;
 	it.buffer = buffer;
 	it.buffer_size = buffer_size;
@@ -485,7 +493,7 @@ int erofs_xattr_prefixes_init(struct super_block *sb)
 	if (sbi->packed_inode)
 		buf.mapping = sbi->packed_inode->i_mapping;
 	else
-		erofs_init_metabuf(&buf, sb);
+		(void)erofs_init_metabuf(&buf, sb, false);
 
 	for (i = 0; i < sbi->xattr_prefix_count; i++) {
 		void *ptr = erofs_read_metadata(sb, &buf, &pos, &len);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 0d1ddd9b15de..792f20888a8f 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -855,7 +855,10 @@ static int z_erofs_pcluster_begin(struct z_erofs_frontend *fe)
 		/* bind cache first when cached decompression is preferred */
 		z_erofs_bind_cache(fe);
 	} else {
-		erofs_init_metabuf(&map->buf, sb);
+		ret = erofs_init_metabuf(&map->buf, sb,
+					 erofs_inode_in_metabox(fe->inode));
+		if (ret)
+			return ret;
 		ptr = erofs_bread(&map->buf, map->m_pa, false);
 		if (IS_ERR(ptr)) {
 			ret = PTR_ERR(ptr);
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index b72a0e3f9362..a93efd95c555 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -17,7 +17,7 @@ struct z_erofs_maprecorder {
 	u16 delta[2];
 	erofs_blk_t pblk, compressedblks;
 	erofs_off_t nextpackoff;
-	bool partialref;
+	bool partialref, in_mbox;
 };
 
 static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
@@ -31,7 +31,7 @@ static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
 	struct z_erofs_lcluster_index *di;
 	unsigned int advise;
 
-	di = erofs_read_metabuf(&m->map->buf, inode->i_sb, pos);
+	di = erofs_read_metabuf(&m->map->buf, inode->i_sb, pos, m->in_mbox);
 	if (IS_ERR(di))
 		return PTR_ERR(di);
 	m->lcn = lcn;
@@ -146,7 +146,7 @@ static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
 	else
 		return -EOPNOTSUPP;
 
-	in = erofs_read_metabuf(&m->map->buf, m->inode->i_sb, pos);
+	in = erofs_read_metabuf(&m->map->buf, inode->i_sb, pos, m->in_mbox);
 	if (IS_ERR(in))
 		return PTR_ERR(in);
 
@@ -392,6 +392,7 @@ static int z_erofs_map_blocks_fo(struct inode *inode,
 	struct z_erofs_maprecorder m = {
 		.inode = inode,
 		.map = map,
+		.in_mbox = erofs_inode_in_metabox(inode),
 	};
 	int err = 0;
 	unsigned int endoff, afmt;
@@ -521,6 +522,7 @@ static int z_erofs_map_blocks_ext(struct inode *inode,
 	unsigned int recsz = z_erofs_extent_recsize(vi->z_advise);
 	erofs_off_t pos = round_up(Z_EROFS_MAP_HEADER_END(erofs_iloc(inode) +
 				   vi->inode_isize + vi->xattr_isize), recsz);
+	bool in_mbox = erofs_inode_in_metabox(inode);
 	erofs_off_t lend = inode->i_size;
 	erofs_off_t l, r, mid, pa, la, lstart;
 	struct z_erofs_extent *ext;
@@ -530,7 +532,7 @@ static int z_erofs_map_blocks_ext(struct inode *inode,
 	map->m_flags = 0;
 	if (recsz <= offsetof(struct z_erofs_extent, pstart_hi)) {
 		if (recsz <= offsetof(struct z_erofs_extent, pstart_lo)) {
-			ext = erofs_read_metabuf(&map->buf, sb, pos);
+			ext = erofs_read_metabuf(&map->buf, sb, pos, in_mbox);
 			if (IS_ERR(ext))
 				return PTR_ERR(ext);
 			pa = le64_to_cpu(*(__le64 *)ext);
@@ -543,7 +545,7 @@ static int z_erofs_map_blocks_ext(struct inode *inode,
 		}
 
 		for (; lstart <= map->m_la; lstart += 1 << vi->z_lclusterbits) {
-			ext = erofs_read_metabuf(&map->buf, sb, pos);
+			ext = erofs_read_metabuf(&map->buf, sb, pos, in_mbox);
 			if (IS_ERR(ext))
 				return PTR_ERR(ext);
 			map->m_plen = le32_to_cpu(ext->plen);
@@ -563,7 +565,7 @@ static int z_erofs_map_blocks_ext(struct inode *inode,
 		for (l = 0, r = vi->z_extents; l < r; ) {
 			mid = l + (r - l) / 2;
 			ext = erofs_read_metabuf(&map->buf, sb,
-						 pos + mid * recsz);
+						 pos + mid * recsz, in_mbox);
 			if (IS_ERR(ext))
 				return PTR_ERR(ext);
 
@@ -645,7 +647,7 @@ static int z_erofs_fill_inode(struct inode *inode, struct erofs_map_blocks *map)
 		goto out_unlock;
 
 	pos = ALIGN(erofs_iloc(inode) + vi->inode_isize + vi->xattr_isize, 8);
-	h = erofs_read_metabuf(&map->buf, sb, pos);
+	h = erofs_read_metabuf(&map->buf, sb, pos, erofs_inode_in_metabox(inode));
 	if (IS_ERR(h)) {
 		err = PTR_ERR(h);
 		goto out_unlock;
-- 
2.43.5


