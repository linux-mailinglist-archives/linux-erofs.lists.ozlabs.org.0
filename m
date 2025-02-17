Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F28A37E9B
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Feb 2025 10:33:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YxHWZ2p75z30TS
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Feb 2025 20:32:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.51.61.247
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739784777;
	cv=none; b=myPrdPjt3a0KNJ/4SXZgp4+hSBSdD/DWhBucNHG7MT6tSb/IpdgL0yjsoYnq8GqVxGMlYxOKpCEGym7rEsVKJ0bOx5rsqfi6pCOyirAVXEcEMl6oC5lQPT5SKAY16Ropj/iDf+QQCskjkxY7oD+rFsphaaeI+FrVydraJ9SpILmtncwrxAmMYWxU+aTIkjTtrkoeYyZtgA5deeHzvjdvb6C3m2rx2+u5bCs+65lxH4rUYO6++CEkJaxta1j4csQNoibrDdGmkn6m/SR9U9Atc0IDn2rEL2KiJ0cyKeB0uSDyfLKtT/FSdO8Wk2wFvgRJthwwZAdw4P0EtrE5XQ28vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739784777; c=relaxed/relaxed;
	bh=PRRjC9YLJXGChLnUF2EXgniY5iluv60tW8cMajjww70=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K85Z/Is+/iu2OYUNyxB1CLA1nfLxm47I7/6cVqI5271Q+FtRLdhZb2sPBT59XiZk25CrgKs9AbsUc6YYTDvZGP0MZRm8qmLTcy6B/4WrfAlOhxRR4633vUKwiFOv2Nl3Ex2P07NNkzVGSIu8ArB76zcJRXnSlLQR3Lpn10a/N4GNFnxmmKlGtCXuNCK8GqMY/ZvJQc6GFrEkgq09ToUoRkdfaSZ3x33IP+J1HZGFWFr0gnw4O3dcFhuHLf7FaBeqzgUpQ3Ml+z7fr0IUTpFSvnynpMrklTRC9aTZrmy3kEF0nA4wHyL6o/t3WrhGa6yk6UefeSQ1g0fy9zN0+HrGwA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass (client-ip=210.51.61.247; helo=ssh247.corpemail.net; envelope-from=liubo03@inspur.com; receiver=lists.ozlabs.org) smtp.mailfrom=inspur.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=inspur.com (client-ip=210.51.61.247; helo=ssh247.corpemail.net; envelope-from=liubo03@inspur.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 64 seconds by postgrey-1.37 at boromir; Mon, 17 Feb 2025 20:32:56 AEDT
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YxHWX0mPdz302c
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Feb 2025 20:32:55 +1100 (AEDT)
Received: from ssh247.corpemail.net
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id PDX00143;
        Mon, 17 Feb 2025 17:31:43 +0800
Received: from localhost.localdomain (10.94.10.240) by
 jtjnmail201604.home.langchao.com (10.100.2.4) with Microsoft SMTP Server id
 15.1.2507.39; Mon, 17 Feb 2025 17:31:42 +0800
From: Bo Liu <liubo03@inspur.com>
To: <xiang@kernel.org>, <chao@kernel.org>
Subject: [v2] erofs: get rid of erofs_kmap_type
Date: Mon, 17 Feb 2025 04:31:41 -0500
Message-ID: <20250217093141.2659-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.94.10.240]
tUid: 202521717314390236f9de244629bbe98a4a41f0267b2
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, Bo Liu <liubo03@inspur.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Since EROFS_KMAP_ATOMIC is no longer valid, get rid of erofs_kmap_type too.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 fs/erofs/data.c     | 17 ++++++++---------
 fs/erofs/dir.c      |  2 +-
 fs/erofs/fileio.c   |  2 +-
 fs/erofs/fscache.c  |  2 +-
 fs/erofs/inode.c    |  6 +++---
 fs/erofs/internal.h | 10 ++--------
 fs/erofs/namei.c    |  2 +-
 fs/erofs/super.c    |  8 ++++----
 fs/erofs/xattr.c    | 12 ++++++------
 fs/erofs/zdata.c    |  4 ++--
 fs/erofs/zmap.c     |  6 +++---
 11 files changed, 32 insertions(+), 39 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 0cd6b5c4df98..1d2cb0fa1baf 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -25,8 +25,7 @@ void erofs_put_metabuf(struct erofs_buf *buf)
 	buf->page = NULL;
 }
 
-void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset,
-		  enum erofs_kmap_type type)
+void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset, bool need_kmap)
 {
 	pgoff_t index = offset >> PAGE_SHIFT;
 	struct folio *folio = NULL;
@@ -43,10 +42,10 @@ void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset,
 			return folio;
 	}
 	buf->page = folio_file_page(folio, index);
-	if (!buf->base && type == EROFS_KMAP)
-		buf->base = kmap_local_page(buf->page);
-	if (type == EROFS_NO_KMAP)
+	if (!need_kmap)
 		return NULL;
+	if (!buf->base)
+		buf->base = kmap_local_page(buf->page);
 	return buf->base + (offset & ~PAGE_MASK);
 }
 
@@ -65,10 +64,10 @@ void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
 }
 
 void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
-			 erofs_off_t offset, enum erofs_kmap_type type)
+			 erofs_off_t offset, bool need_kmap)
 {
 	erofs_init_metabuf(buf, sb);
-	return erofs_bread(buf, offset, type);
+	return erofs_bread(buf, offset, need_kmap);
 }
 
 static int erofs_map_blocks_flatmode(struct inode *inode,
@@ -135,7 +134,7 @@ int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
 	pos = ALIGN(erofs_iloc(inode) + vi->inode_isize +
 		    vi->xattr_isize, unit) + unit * chunknr;
 
-	kaddr = erofs_read_metabuf(&buf, sb, pos, EROFS_KMAP);
+	kaddr = erofs_read_metabuf(&buf, sb, pos, true);
 	if (IS_ERR(kaddr)) {
 		err = PTR_ERR(kaddr);
 		goto out;
@@ -312,7 +311,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 
 		iomap->type = IOMAP_INLINE;
-		ptr = erofs_read_metabuf(&buf, sb, mdev.m_pa, EROFS_KMAP);
+		ptr = erofs_read_metabuf(&buf, sb, mdev.m_pa, true);
 		if (IS_ERR(ptr))
 			return PTR_ERR(ptr);
 		iomap->inline_data = ptr;
diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index c3b90abdee37..1d3bb8746ab1 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -58,7 +58,7 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 		struct erofs_dirent *de;
 		unsigned int nameoff, maxsize;
 
-		de = erofs_bread(&buf, dbstart, EROFS_KMAP);
+		de = erofs_bread(&buf, dbstart, true);
 		if (IS_ERR(de)) {
 			erofs_err(sb, "fail to readdir of logical block %u of nid %llu",
 				  erofs_blknr(sb, dbstart), EROFS_I(dir)->nid);
diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index 0ffd1c63beeb..bec4b56b3826 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -112,7 +112,7 @@ static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
 			void *src;
 
 			src = erofs_read_metabuf(&buf, inode->i_sb,
-						 map->m_pa + ofs, EROFS_KMAP);
+						 map->m_pa + ofs, true);
 			if (IS_ERR(src)) {
 				err = PTR_ERR(src);
 				break;
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index ce3d8737df85..9c9129bca346 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -276,7 +276,7 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_rq *req)
 		size_t size = map.m_llen;
 		void *src;
 
-		src = erofs_read_metabuf(&buf, sb, map.m_pa, EROFS_KMAP);
+		src = erofs_read_metabuf(&buf, sb, map.m_pa, true);
 		if (IS_ERR(src))
 			return PTR_ERR(src);
 
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index d4b89407822a..4936bd43c438 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -42,7 +42,7 @@ static int erofs_read_inode(struct inode *inode)
 	blkaddr = erofs_blknr(sb, inode_loc);
 	ofs = erofs_blkoff(sb, inode_loc);
 
-	kaddr = erofs_read_metabuf(&buf, sb, erofs_pos(sb, blkaddr), EROFS_KMAP);
+	kaddr = erofs_read_metabuf(&buf, sb, erofs_pos(sb, blkaddr), true);
 	if (IS_ERR(kaddr)) {
 		erofs_err(sb, "failed to get inode (nid: %llu) page, err %ld",
 			  vi->nid, PTR_ERR(kaddr));
@@ -82,8 +82,8 @@ static int erofs_read_inode(struct inode *inode)
 				goto err_out;
 			}
 			memcpy(copied, dic, gotten);
-			kaddr = erofs_read_metabuf(&buf, sb, erofs_pos(sb, blkaddr + 1),
-						   EROFS_KMAP);
+			kaddr = erofs_read_metabuf(&buf, sb,
+					erofs_pos(sb, blkaddr + 1), true);
 			if (IS_ERR(kaddr)) {
 				erofs_err(sb, "failed to get inode payload block (nid: %llu), err %ld",
 					  vi->nid, PTR_ERR(kaddr));
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 686d835eb533..f955793146f4 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -199,11 +199,6 @@ enum {
 	EROFS_ZIP_CACHE_READAROUND
 };
 
-enum erofs_kmap_type {
-	EROFS_NO_KMAP,		/* don't map the buffer */
-	EROFS_KMAP,		/* use kmap_local_page() to map the buffer */
-};
-
 struct erofs_buf {
 	struct address_space *mapping;
 	struct file *file;
@@ -387,11 +382,10 @@ void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
 			  erofs_off_t *offset, int *lengthp);
 void erofs_unmap_metabuf(struct erofs_buf *buf);
 void erofs_put_metabuf(struct erofs_buf *buf);
-void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset,
-		  enum erofs_kmap_type type);
+void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset, bool need_kmap);
 void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb);
 void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
-			 erofs_off_t offset, enum erofs_kmap_type type);
+			 erofs_off_t offset, bool need_kmap);
 int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *dev);
 int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		 u64 start, u64 len);
diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
index c94d0c1608a8..f7cf4f41af28 100644
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -100,7 +100,7 @@ static void *erofs_find_target_block(struct erofs_buf *target,
 		struct erofs_dirent *de;
 
 		buf.mapping = dir->i_mapping;
-		de = erofs_bread(&buf, erofs_pos(dir->i_sb, mid), EROFS_KMAP);
+		de = erofs_bread(&buf, erofs_pos(dir->i_sb, mid), true);
 		if (!IS_ERR(de)) {
 			const int nameoff = nameoff_from_disk(de->nameoff, bsz);
 			const int ndirents = nameoff / sizeof(*de);
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 827b62665649..3dc86d931ef1 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -94,7 +94,7 @@ void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
 	int len, i, cnt;
 
 	*offset = round_up(*offset, 4);
-	ptr = erofs_bread(buf, *offset, EROFS_KMAP);
+	ptr = erofs_bread(buf, *offset, true);
 	if (IS_ERR(ptr))
 		return ptr;
 
@@ -110,7 +110,7 @@ void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
 	for (i = 0; i < len; i += cnt) {
 		cnt = min_t(int, sb->s_blocksize - erofs_blkoff(sb, *offset),
 			    len - i);
-		ptr = erofs_bread(buf, *offset, EROFS_KMAP);
+		ptr = erofs_bread(buf, *offset, true);
 		if (IS_ERR(ptr)) {
 			kfree(buffer);
 			return ptr;
@@ -141,7 +141,7 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 	struct erofs_deviceslot *dis;
 	struct file *file;
 
-	dis = erofs_read_metabuf(buf, sb, *pos, EROFS_KMAP);
+	dis = erofs_read_metabuf(buf, sb, *pos, true);
 	if (IS_ERR(dis))
 		return PTR_ERR(dis);
 
@@ -255,7 +255,7 @@ static int erofs_read_superblock(struct super_block *sb)
 	void *data;
 	int ret;
 
-	data = erofs_read_metabuf(&buf, sb, 0, EROFS_KMAP);
+	data = erofs_read_metabuf(&buf, sb, 0, true);
 	if (IS_ERR(data)) {
 		erofs_err(sb, "cannot read erofs superblock");
 		return PTR_ERR(data);
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index df2777e05661..9cf84717a92e 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -81,7 +81,7 @@ static int erofs_init_inode_xattrs(struct inode *inode)
 	it.pos = erofs_iloc(inode) + vi->inode_isize;
 
 	/* read in shared xattr array (non-atomic, see kmalloc below) */
-	it.kaddr = erofs_bread(&it.buf, it.pos, EROFS_KMAP);
+	it.kaddr = erofs_bread(&it.buf, it.pos, true);
 	if (IS_ERR(it.kaddr)) {
 		ret = PTR_ERR(it.kaddr);
 		goto out_unlock;
@@ -102,7 +102,7 @@ static int erofs_init_inode_xattrs(struct inode *inode)
 	it.pos += sizeof(struct erofs_xattr_ibody_header);
 
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
-		it.kaddr = erofs_bread(&it.buf, it.pos, EROFS_KMAP);
+		it.kaddr = erofs_bread(&it.buf, it.pos, true);
 		if (IS_ERR(it.kaddr)) {
 			kfree(vi->xattr_shared_xattrs);
 			vi->xattr_shared_xattrs = NULL;
@@ -183,7 +183,7 @@ static int erofs_xattr_copy_to_buffer(struct erofs_xattr_iter *it,
 	void *src;
 
 	for (processed = 0; processed < len; processed += slice) {
-		it->kaddr = erofs_bread(&it->buf, it->pos, EROFS_KMAP);
+		it->kaddr = erofs_bread(&it->buf, it->pos, true);
 		if (IS_ERR(it->kaddr))
 			return PTR_ERR(it->kaddr);
 
@@ -286,7 +286,7 @@ static int erofs_getxattr_foreach(struct erofs_xattr_iter *it)
 
 	/* 2. handle xattr name */
 	for (processed = 0; processed < entry.e_name_len; processed += slice) {
-		it->kaddr = erofs_bread(&it->buf, it->pos, EROFS_KMAP);
+		it->kaddr = erofs_bread(&it->buf, it->pos, true);
 		if (IS_ERR(it->kaddr))
 			return PTR_ERR(it->kaddr);
 
@@ -330,7 +330,7 @@ static int erofs_xattr_iter_inline(struct erofs_xattr_iter *it,
 	it->pos = erofs_iloc(inode) + vi->inode_isize + xattr_header_sz;
 
 	while (remaining) {
-		it->kaddr = erofs_bread(&it->buf, it->pos, EROFS_KMAP);
+		it->kaddr = erofs_bread(&it->buf, it->pos, true);
 		if (IS_ERR(it->kaddr))
 			return PTR_ERR(it->kaddr);
 
@@ -367,7 +367,7 @@ static int erofs_xattr_iter_shared(struct erofs_xattr_iter *it,
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
 		it->pos = erofs_pos(sb, sbi->xattr_blkaddr) +
 				vi->xattr_shared_xattrs[i] * sizeof(__le32);
-		it->kaddr = erofs_bread(&it->buf, it->pos, EROFS_KMAP);
+		it->kaddr = erofs_bread(&it->buf, it->pos, true);
 		if (IS_ERR(it->kaddr))
 			return PTR_ERR(it->kaddr);
 
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index d771e06db738..ad674eee400a 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -832,7 +832,7 @@ static int z_erofs_pcluster_begin(struct z_erofs_frontend *fe)
 	} else {
 		void *mptr;
 
-		mptr = erofs_read_metabuf(&map->buf, sb, map->m_pa, EROFS_NO_KMAP);
+		mptr = erofs_read_metabuf(&map->buf, sb, map->m_pa, false);
 		if (IS_ERR(mptr)) {
 			ret = PTR_ERR(mptr);
 			erofs_err(sb, "failed to get inline data %d", ret);
@@ -967,7 +967,7 @@ static int z_erofs_read_fragment(struct super_block *sb, struct folio *folio,
 	buf.mapping = packed_inode->i_mapping;
 	for (; cur < end; cur += cnt, pos += cnt) {
 		cnt = min(end - cur, sb->s_blocksize - erofs_blkoff(sb, pos));
-		src = erofs_bread(&buf, pos, EROFS_KMAP);
+		src = erofs_bread(&buf, pos, true);
 		if (IS_ERR(src)) {
 			erofs_put_metabuf(&buf);
 			return PTR_ERR(src);
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 689437e99a5a..75daac513050 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -31,7 +31,7 @@ static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
 	struct z_erofs_lcluster_index *di;
 	unsigned int advise;
 
-	di = erofs_read_metabuf(&m->map->buf, inode->i_sb, pos, EROFS_KMAP);
+	di = erofs_read_metabuf(&m->map->buf, inode->i_sb, pos, true);
 	if (IS_ERR(di))
 		return PTR_ERR(di);
 	m->lcn = lcn;
@@ -146,7 +146,7 @@ static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
 	else
 		return -EOPNOTSUPP;
 
-	in = erofs_read_metabuf(&m->map->buf, m->inode->i_sb, pos, EROFS_KMAP);
+	in = erofs_read_metabuf(&m->map->buf, m->inode->i_sb, pos, true);
 	if (IS_ERR(in))
 		return PTR_ERR(in);
 
@@ -561,7 +561,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		goto out_unlock;
 
 	pos = ALIGN(erofs_iloc(inode) + vi->inode_isize + vi->xattr_isize, 8);
-	h = erofs_read_metabuf(&buf, sb, pos, EROFS_KMAP);
+	h = erofs_read_metabuf(&buf, sb, pos, true);
 	if (IS_ERR(h)) {
 		err = PTR_ERR(h);
 		goto out_unlock;
-- 
2.31.1

