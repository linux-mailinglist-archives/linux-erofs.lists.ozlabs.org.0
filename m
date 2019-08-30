Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DECFBA2D26
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2019 05:02:39 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46KPRJ5MD4zF0RM
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2019 13:02:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.190; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46KPQW4Jm9zF0QQ
 for <linux-erofs@lists.ozlabs.org>; Fri, 30 Aug 2019 13:01:55 +1000 (AEST)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id F0DE5383FA9D5B9BA3D7;
 Fri, 30 Aug 2019 11:01:50 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 30 Aug
 2019 11:01:44 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 Christoph Hellwig <hch@infradead.org>, Joe Perches <joe@perches.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, <devel@driverdev.osuosl.org>
Subject: [PATCH v2 6/7] erofs: remove all likely/unlikely annotations
Date: Fri, 30 Aug 2019 11:00:39 +0800
Message-ID: <20190830030040.10599-6-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830030040.10599-1-gaoxiang25@huawei.com>
References: <20190830030040.10599-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 weidu.du@huawei.com, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

As Dan Carpenter suggested [1], I have to remove
all erofs likely/unlikely annotations.

[1] https://lore.kernel.org/linux-fsdevel/20190829154346.GK23584@kadam/
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
v2: no change, just resend in case of dependency problem;

 fs/erofs/data.c         | 22 ++++++++++-----------
 fs/erofs/decompressor.c |  2 +-
 fs/erofs/dir.c          | 14 ++++++-------
 fs/erofs/inode.c        | 10 +++++-----
 fs/erofs/internal.h     |  4 ++--
 fs/erofs/namei.c        | 14 ++++++-------
 fs/erofs/super.c        | 16 +++++++--------
 fs/erofs/utils.c        | 12 +++++------
 fs/erofs/xattr.c        | 12 +++++------
 fs/erofs/zdata.c        | 44 ++++++++++++++++++++---------------------
 fs/erofs/zmap.c         |  8 ++++----
 fs/erofs/zpvec.h        |  6 +++---
 12 files changed, 82 insertions(+), 82 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index fda16ec8863e..0f2f1a839372 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -27,7 +27,7 @@ static inline void read_endio(struct bio *bio)
 		/* page is already locked */
 		DBG_BUGON(PageUptodate(page));
 
-		if (unlikely(err))
+		if (err)
 			SetPageError(page);
 		else
 			SetPageUptodate(page);
@@ -53,7 +53,7 @@ struct page *__erofs_get_meta_page(struct super_block *sb,
 
 repeat:
 	page = find_or_create_page(mapping, blkaddr, gfp);
-	if (unlikely(!page)) {
+	if (!page) {
 		DBG_BUGON(nofail);
 		return ERR_PTR(-ENOMEM);
 	}
@@ -70,7 +70,7 @@ struct page *__erofs_get_meta_page(struct super_block *sb,
 		}
 
 		err = bio_add_page(bio, page, PAGE_SIZE, 0);
-		if (unlikely(err != PAGE_SIZE)) {
+		if (err != PAGE_SIZE) {
 			err = -EFAULT;
 			goto err_out;
 		}
@@ -81,7 +81,7 @@ struct page *__erofs_get_meta_page(struct super_block *sb,
 		lock_page(page);
 
 		/* this page has been truncated by others */
-		if (unlikely(page->mapping != mapping)) {
+		if (page->mapping != mapping) {
 unlock_repeat:
 			unlock_page(page);
 			put_page(page);
@@ -89,7 +89,7 @@ struct page *__erofs_get_meta_page(struct super_block *sb,
 		}
 
 		/* more likely a read error */
-		if (unlikely(!PageUptodate(page))) {
+		if (!PageUptodate(page)) {
 			if (io_retries) {
 				--io_retries;
 				goto unlock_repeat;
@@ -120,7 +120,7 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
 	nblocks = DIV_ROUND_UP(inode->i_size, PAGE_SIZE);
 	lastblk = nblocks - is_inode_flat_inline(inode);
 
-	if (unlikely(offset >= inode->i_size)) {
+	if (offset >= inode->i_size) {
 		/* leave out-of-bound access unmapped */
 		map->m_flags = 0;
 		map->m_plen = 0;
@@ -170,7 +170,7 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
 int erofs_map_blocks(struct inode *inode,
 		     struct erofs_map_blocks *map, int flags)
 {
-	if (unlikely(is_inode_layout_compression(inode))) {
+	if (is_inode_layout_compression(inode)) {
 		int err = z_erofs_map_blocks_iter(inode, map, flags);
 
 		if (map->mpage) {
@@ -218,11 +218,11 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
 		unsigned int blkoff;
 
 		err = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
-		if (unlikely(err))
+		if (err)
 			goto err_out;
 
 		/* zero out the holed page */
-		if (unlikely(!(map.m_flags & EROFS_MAP_MAPPED))) {
+		if (!(map.m_flags & EROFS_MAP_MAPPED)) {
 			zero_user_segment(page, 0, PAGE_SIZE);
 			SetPageUptodate(page);
 
@@ -315,7 +315,7 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
 submit_bio_out:
 		__submit_bio(bio, REQ_OP_READ, 0);
 
-	return unlikely(err) ? ERR_PTR(err) : NULL;
+	return err ? ERR_PTR(err) : NULL;
 }
 
 /*
@@ -377,7 +377,7 @@ static int erofs_raw_access_readpages(struct file *filp,
 	DBG_BUGON(!list_empty(pages));
 
 	/* the rare case (end in gaps) */
-	if (unlikely(bio))
+	if (bio)
 		__submit_bio(bio, REQ_OP_READ, 0);
 	return 0;
 }
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 5f4b7f302863..df349888f911 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -78,7 +78,7 @@ static int lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
 			get_page(victim);
 		} else {
 			victim = erofs_allocpage(pagepool, GFP_KERNEL, false);
-			if (unlikely(!victim))
+			if (!victim)
 				return -ENOMEM;
 			victim->mapping = Z_EROFS_MAPPING_STAGING;
 		}
diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index 1976e60e5174..6a5b43f7fb29 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -45,8 +45,8 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
 			de_namelen = le16_to_cpu(de[1].nameoff) - nameoff;
 
 		/* a corrupted entry is found */
-		if (unlikely(nameoff + de_namelen > maxsize ||
-			     de_namelen > EROFS_NAME_LEN)) {
+		if (nameoff + de_namelen > maxsize ||
+		    de_namelen > EROFS_NAME_LEN) {
 			errln("bogus dirent @ nid %llu", EROFS_V(dir)->nid);
 			DBG_BUGON(1);
 			return -EFSCORRUPTED;
@@ -94,8 +94,8 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 
 		nameoff = le16_to_cpu(de->nameoff);
 
-		if (unlikely(nameoff < sizeof(struct erofs_dirent) ||
-			     nameoff >= PAGE_SIZE)) {
+		if (nameoff < sizeof(struct erofs_dirent) ||
+		    nameoff >= PAGE_SIZE) {
 			errln("%s, invalid de[0].nameoff %u @ nid %llu",
 			      __func__, nameoff, EROFS_V(dir)->nid);
 			err = -EFSCORRUPTED;
@@ -106,11 +106,11 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 				dirsize - ctx->pos + ofs, PAGE_SIZE);
 
 		/* search dirents at the arbitrary position */
-		if (unlikely(initial)) {
+		if (initial) {
 			initial = false;
 
 			ofs = roundup(ofs, sizeof(struct erofs_dirent));
-			if (unlikely(ofs >= nameoff))
+			if (ofs >= nameoff)
 				goto skip_this;
 		}
 
@@ -123,7 +123,7 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 
 		ctx->pos = blknr_to_addr(i) + ofs;
 
-		if (unlikely(err))
+		if (err)
 			break;
 		++i;
 		ofs = 0;
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index cf31554075c9..871a6d8ed6f9 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -18,7 +18,7 @@ static int read_inode(struct inode *inode, void *data)
 
 	vi->datamode = __inode_data_mapping(advise);
 
-	if (unlikely(vi->datamode >= EROFS_INODE_LAYOUT_MAX)) {
+	if (vi->datamode >= EROFS_INODE_LAYOUT_MAX) {
 		errln("unsupported data mapping %u of nid %llu",
 		      vi->datamode, vi->nid);
 		DBG_BUGON(1);
@@ -133,13 +133,13 @@ static int fill_inline_data(struct inode *inode, void *data,
 	if (S_ISLNK(inode->i_mode) && inode->i_size < PAGE_SIZE) {
 		char *lnk = erofs_kmalloc(sbi, inode->i_size + 1, GFP_KERNEL);
 
-		if (unlikely(!lnk))
+		if (!lnk)
 			return -ENOMEM;
 
 		m_pofs += vi->inode_isize + vi->xattr_isize;
 
 		/* inline symlink data shouldn't across page boundary as well */
-		if (unlikely(m_pofs + inode->i_size > PAGE_SIZE)) {
+		if (m_pofs + inode->i_size > PAGE_SIZE) {
 			kfree(lnk);
 			errln("inline data cross block boundary @ nid %llu",
 			      vi->nid);
@@ -268,7 +268,7 @@ struct inode *erofs_iget(struct super_block *sb,
 {
 	struct inode *inode = erofs_iget_locked(sb, nid);
 
-	if (unlikely(!inode))
+	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
 	if (inode->i_state & I_NEW) {
@@ -278,7 +278,7 @@ struct inode *erofs_iget(struct super_block *sb,
 		vi->nid = nid;
 
 		err = fill_inode(inode, isdir);
-		if (likely(!err))
+		if (!err)
 			unlock_new_inode(inode);
 		else {
 			iget_failed(inode);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 620b73fcc416..141ea424587d 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -424,7 +424,7 @@ static inline struct bio *erofs_grab_bio(struct super_block *sb,
 	do {
 		if (nr_pages == 1) {
 			bio = bio_alloc(gfp | (nofail ? __GFP_NOFAIL : 0), 1);
-			if (unlikely(!bio)) {
+			if (!bio) {
 				DBG_BUGON(nofail);
 				return ERR_PTR(-ENOMEM);
 			}
@@ -432,7 +432,7 @@ static inline struct bio *erofs_grab_bio(struct super_block *sb,
 		}
 		bio = bio_alloc(gfp, nr_pages);
 		nr_pages /= 2;
-	} while (unlikely(!bio));
+	} while (!bio);
 
 	bio->bi_end_io = endio;
 	bio_set_dev(bio, sb->s_bdev);
diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
index 8832b5d95d91..c1068ad0535e 100644
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -64,7 +64,7 @@ static struct erofs_dirent *find_target_dirent(struct erofs_qstr *name,
 		unsigned int matched = min(startprfx, endprfx);
 		struct erofs_qstr dname = {
 			.name = data + nameoff,
-			.end = unlikely(mid >= ndirents - 1) ?
+			.end = mid >= ndirents - 1 ?
 				data + dirblksize :
 				data + nameoff_from_disk(de[mid + 1].nameoff,
 							 dirblksize)
@@ -73,7 +73,7 @@ static struct erofs_dirent *find_target_dirent(struct erofs_qstr *name,
 		/* string comparison without already matched prefix */
 		int ret = dirnamecmp(name, &dname, &matched);
 
-		if (unlikely(!ret)) {
+		if (!ret) {
 			return de + mid;
 		} else if (ret > 0) {
 			head = mid + 1;
@@ -113,7 +113,7 @@ static struct page *find_target_block_classic(struct inode *dir,
 			unsigned int matched;
 			struct erofs_qstr dname;
 
-			if (unlikely(!ndirents)) {
+			if (!ndirents) {
 				kunmap_atomic(de);
 				put_page(page);
 				errln("corrupted dir block %d @ nid %llu",
@@ -137,7 +137,7 @@ static struct page *find_target_block_classic(struct inode *dir,
 			diff = dirnamecmp(name, &dname, &matched);
 			kunmap_atomic(de);
 
-			if (unlikely(!diff)) {
+			if (!diff) {
 				*_ndirents = 0;
 				goto out;
 			} else if (diff > 0) {
@@ -174,7 +174,7 @@ int erofs_namei(struct inode *dir,
 	struct erofs_dirent *de;
 	struct erofs_qstr qn;
 
-	if (unlikely(!dir->i_size))
+	if (!dir->i_size)
 		return -ENOENT;
 
 	qn.name = name->name;
@@ -221,7 +221,7 @@ static struct dentry *erofs_lookup(struct inode *dir,
 	trace_erofs_lookup(dir, dentry, flags);
 
 	/* file name exceeds fs limit */
-	if (unlikely(dentry->d_name.len > EROFS_NAME_LEN))
+	if (dentry->d_name.len > EROFS_NAME_LEN)
 		return ERR_PTR(-ENAMETOOLONG);
 
 	/* false uninitialized warnings on gcc 4.8.x */
@@ -230,7 +230,7 @@ static struct dentry *erofs_lookup(struct inode *dir,
 	if (err == -ENOENT) {
 		/* negative dentry */
 		inode = NULL;
-	} else if (unlikely(err)) {
+	} else if (err) {
 		inode = ERR_PTR(err);
 	} else {
 		debugln("%s, %s (nid %llu) found, d_type %u", __func__,
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 556aae5426d6..0c412de33315 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -92,7 +92,7 @@ static int superblock_read(struct super_block *sb)
 
 	blkszbits = layout->blkszbits;
 	/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
-	if (unlikely(blkszbits != LOG_BLOCK_SIZE)) {
+	if (blkszbits != LOG_BLOCK_SIZE) {
 		errln("blksize %u isn't supported on this platform",
 		      1 << blkszbits);
 		goto out;
@@ -364,7 +364,7 @@ static int erofs_init_managed_cache(struct super_block *sb)
 	struct erofs_sb_info *const sbi = EROFS_SB(sb);
 	struct inode *const inode = new_inode(sb);
 
-	if (unlikely(!inode))
+	if (!inode)
 		return -ENOMEM;
 
 	set_nlink(inode, 1);
@@ -391,13 +391,13 @@ static int erofs_fill_super(struct super_block *sb, void *data, int silent)
 
 	sb->s_magic = EROFS_SUPER_MAGIC;
 
-	if (unlikely(!sb_set_blocksize(sb, EROFS_BLKSIZ))) {
+	if (!sb_set_blocksize(sb, EROFS_BLKSIZ)) {
 		errln("failed to set erofs blksize");
 		return -EINVAL;
 	}
 
 	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
-	if (unlikely(!sbi))
+	if (!sbi)
 		return -ENOMEM;
 
 	sb->s_fs_info = sbi;
@@ -418,7 +418,7 @@ static int erofs_fill_super(struct super_block *sb, void *data, int silent)
 	default_options(sbi);
 
 	err = parse_options(sb, data);
-	if (unlikely(err))
+	if (err)
 		return err;
 
 	if (!silent)
@@ -438,7 +438,7 @@ static int erofs_fill_super(struct super_block *sb, void *data, int silent)
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
-	if (unlikely(!S_ISDIR(inode->i_mode))) {
+	if (!S_ISDIR(inode->i_mode)) {
 		errln("rootino(nid %llu) is not a directory(i_mode %o)",
 		      ROOT_NID(sbi), inode->i_mode);
 		iput(inode);
@@ -446,13 +446,13 @@ static int erofs_fill_super(struct super_block *sb, void *data, int silent)
 	}
 
 	sb->s_root = d_make_root(inode);
-	if (unlikely(!sb->s_root))
+	if (!sb->s_root)
 		return -ENOMEM;
 
 	erofs_shrinker_register(sb);
 	/* sb->s_umount is already locked, SB_ACTIVE and SB_BORN are not set */
 	err = erofs_init_managed_cache(sb);
-	if (unlikely(err))
+	if (err)
 		return err;
 
 	if (!silent)
diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index 1dd041aa0f5a..d92b3e753a6f 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -46,14 +46,14 @@ static int erofs_workgroup_get(struct erofs_workgroup *grp)
 
 repeat:
 	o = erofs_wait_on_workgroup_freezed(grp);
-	if (unlikely(o <= 0))
+	if (o <= 0)
 		return -1;
 
-	if (unlikely(atomic_cmpxchg(&grp->refcount, o, o + 1) != o))
+	if (atomic_cmpxchg(&grp->refcount, o, o + 1) != o)
 		goto repeat;
 
 	/* decrease refcount paired by erofs_workgroup_put */
-	if (unlikely(o == 1))
+	if (o == 1)
 		atomic_long_dec(&erofs_global_shrink_cnt);
 	return 0;
 }
@@ -91,7 +91,7 @@ int erofs_register_workgroup(struct super_block *sb,
 	int err;
 
 	/* grp shouldn't be broken or used before */
-	if (unlikely(atomic_read(&grp->refcount) != 1)) {
+	if (atomic_read(&grp->refcount) != 1) {
 		DBG_BUGON(1);
 		return -EINVAL;
 	}
@@ -113,7 +113,7 @@ int erofs_register_workgroup(struct super_block *sb,
 	__erofs_workgroup_get(grp);
 
 	err = radix_tree_insert(&sbi->workstn_tree, grp->index, grp);
-	if (unlikely(err))
+	if (err)
 		/*
 		 * it's safe to decrease since the workgroup isn't visible
 		 * and refcount >= 2 (cannot be freezed).
@@ -212,7 +212,7 @@ static unsigned long erofs_shrink_workstation(struct erofs_sb_info *sbi,
 			continue;
 
 		++freed;
-		if (unlikely(!--nr_shrink))
+		if (!--nr_shrink)
 			break;
 	}
 	xa_unlock(&sbi->workstn_tree);
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 7ef8d4bb45cd..620cbc15f4d0 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -19,7 +19,7 @@ struct xattr_iter {
 static inline void xattr_iter_end(struct xattr_iter *it, bool atomic)
 {
 	/* the only user of kunmap() is 'init_inode_xattrs' */
-	if (unlikely(!atomic))
+	if (!atomic)
 		kunmap(it->page);
 	else
 		kunmap_atomic(it->kaddr);
@@ -72,7 +72,7 @@ static int init_inode_xattrs(struct inode *inode)
 		ret = -EOPNOTSUPP;
 		goto out_unlock;
 	} else if (vi->xattr_isize < sizeof(struct erofs_xattr_ibody_header)) {
-		if (unlikely(vi->xattr_isize)) {
+		if (vi->xattr_isize) {
 			errln("bogus xattr ibody @ nid %llu", vi->nid);
 			DBG_BUGON(1);
 			ret = -EFSCORRUPTED;
@@ -112,7 +112,7 @@ static int init_inode_xattrs(struct inode *inode)
 	it.ofs += sizeof(struct erofs_xattr_ibody_header);
 
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
-		if (unlikely(it.ofs >= EROFS_BLKSIZ)) {
+		if (it.ofs >= EROFS_BLKSIZ) {
 			/* cannot be unaligned */
 			DBG_BUGON(it.ofs != EROFS_BLKSIZ);
 			xattr_iter_end(&it, atomic_map);
@@ -189,7 +189,7 @@ static int inline_xattr_iter_begin(struct xattr_iter *it,
 	unsigned int xattr_header_sz, inline_xattr_ofs;
 
 	xattr_header_sz = inlinexattr_header_size(inode);
-	if (unlikely(xattr_header_sz >= vi->xattr_isize)) {
+	if (xattr_header_sz >= vi->xattr_isize) {
 		DBG_BUGON(xattr_header_sz > vi->xattr_isize);
 		return -ENOATTR;
 	}
@@ -234,7 +234,7 @@ static int xattr_foreach(struct xattr_iter *it,
 		unsigned int entry_sz = erofs_xattr_entry_size(&entry);
 
 		/* xattr on-disk corruption: xattr entry beyond xattr_isize */
-		if (unlikely(*tlimit < entry_sz)) {
+		if (*tlimit < entry_sz) {
 			DBG_BUGON(1);
 			return -EFSCORRUPTED;
 		}
@@ -436,7 +436,7 @@ int erofs_getxattr(struct inode *inode, int index,
 	int ret;
 	struct getxattr_iter it;
 
-	if (unlikely(!name))
+	if (!name)
 		return -EINVAL;
 
 	ret = init_inode_xattrs(inode);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index b32ad585237c..653bde0a619a 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -230,7 +230,7 @@ int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
 		if (!trylock_page(page))
 			return -EBUSY;
 
-		if (unlikely(page->mapping != mapping))
+		if (page->mapping != mapping)
 			continue;
 
 		/* barrier is implied in the following 'unlock_page' */
@@ -358,7 +358,7 @@ static struct z_erofs_collection *cllookup(struct z_erofs_collector *clt,
 	}
 
 	cl = z_erofs_primarycollection(pcl);
-	if (unlikely(cl->pageofs != (map->m_la & ~PAGE_MASK))) {
+	if (cl->pageofs != (map->m_la & ~PAGE_MASK)) {
 		DBG_BUGON(1);
 		erofs_workgroup_put(grp);
 		return ERR_PTR(-EFSCORRUPTED);
@@ -406,7 +406,7 @@ static struct z_erofs_collection *clregister(struct z_erofs_collector *clt,
 
 	/* no available workgroup, let's allocate one */
 	pcl = kmem_cache_alloc(pcluster_cachep, GFP_NOFS);
-	if (unlikely(!pcl))
+	if (!pcl)
 		return ERR_PTR(-ENOMEM);
 
 	init_always(pcl);
@@ -474,7 +474,7 @@ static int z_erofs_collector_begin(struct z_erofs_collector *clt,
 	if (!cl) {
 		cl = clregister(clt, inode, map);
 
-		if (unlikely(cl == ERR_PTR(-EAGAIN)))
+		if (cl == ERR_PTR(-EAGAIN))
 			goto repeat;
 	}
 
@@ -607,15 +607,15 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	map->m_la = offset + cur;
 	map->m_llen = 0;
 	err = z_erofs_map_blocks_iter(inode, map, 0);
-	if (unlikely(err))
+	if (err)
 		goto err_out;
 
 restart_now:
-	if (unlikely(!(map->m_flags & EROFS_MAP_MAPPED)))
+	if (!(map->m_flags & EROFS_MAP_MAPPED))
 		goto hitted;
 
 	err = z_erofs_collector_begin(clt, inode, map);
-	if (unlikely(err))
+	if (err)
 		goto err_out;
 
 	/* preload all compressed pages (maybe downgrade role if necessary) */
@@ -630,7 +630,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	tight &= (clt->mode >= COLLECT_PRIMARY_HOOKED);
 hitted:
 	cur = end - min_t(unsigned int, offset + end - map->m_la, end);
-	if (unlikely(!(map->m_flags & EROFS_MAP_MAPPED))) {
+	if (!(map->m_flags & EROFS_MAP_MAPPED)) {
 		zero_user_segment(page, cur, end);
 		goto next_part;
 	}
@@ -653,11 +653,11 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 
 		err = z_erofs_attach_page(clt, newpage,
 					  Z_EROFS_PAGE_TYPE_EXCLUSIVE);
-		if (likely(!err))
+		if (!err)
 			goto retry;
 	}
 
-	if (unlikely(err))
+	if (err)
 		goto err_out;
 
 	index = page->index - (map->m_la >> PAGE_SHIFT);
@@ -723,7 +723,7 @@ static inline void z_erofs_vle_read_endio(struct bio *bio)
 		DBG_BUGON(PageUptodate(page));
 		DBG_BUGON(!page->mapping);
 
-		if (unlikely(!sbi && !z_erofs_page_is_staging(page))) {
+		if (!sbi && !z_erofs_page_is_staging(page)) {
 			sbi = EROFS_SB(page->mapping->host->i_sb);
 
 			if (time_to_inject(sbi, FAULT_READ_IO)) {
@@ -736,7 +736,7 @@ static inline void z_erofs_vle_read_endio(struct bio *bio)
 		if (sbi)
 			cachemngd = erofs_page_is_managed(sbi, page);
 
-		if (unlikely(err))
+		if (err)
 			SetPageError(page);
 		else if (cachemngd)
 			SetPageUptodate(page);
@@ -772,7 +772,7 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 	mutex_lock(&cl->lock);
 	nr_pages = cl->nr_pages;
 
-	if (likely(nr_pages <= Z_EROFS_VMAP_ONSTACK_PAGES)) {
+	if (nr_pages <= Z_EROFS_VMAP_ONSTACK_PAGES) {
 		pages = pages_onstack;
 	} else if (nr_pages <= Z_EROFS_VMAP_GLOBAL_PAGES &&
 		   mutex_trylock(&z_pagemap_global_lock)) {
@@ -787,7 +787,7 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 				       gfp_flags);
 
 		/* fallback to global pagemap for the lowmem scenario */
-		if (unlikely(!pages)) {
+		if (!pages) {
 			mutex_lock(&z_pagemap_global_lock);
 			pages = z_pagemap_global;
 		}
@@ -823,7 +823,7 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 		 * currently EROFS doesn't support multiref(dedup),
 		 * so here erroring out one multiref page.
 		 */
-		if (unlikely(pages[pagenr])) {
+		if (pages[pagenr]) {
 			DBG_BUGON(1);
 			SetPageError(pages[pagenr]);
 			z_erofs_onlinepage_endio(pages[pagenr]);
@@ -847,7 +847,7 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 
 		if (!z_erofs_page_is_staging(page)) {
 			if (erofs_page_is_managed(sbi, page)) {
-				if (unlikely(!PageUptodate(page)))
+				if (!PageUptodate(page))
 					err = -EIO;
 				continue;
 			}
@@ -859,7 +859,7 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 			pagenr = z_erofs_onlinepage_index(page);
 
 			DBG_BUGON(pagenr >= nr_pages);
-			if (unlikely(pages[pagenr])) {
+			if (pages[pagenr]) {
 				DBG_BUGON(1);
 				SetPageError(pages[pagenr]);
 				z_erofs_onlinepage_endio(pages[pagenr]);
@@ -871,13 +871,13 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 		}
 
 		/* PG_error needs checking for inplaced and staging pages */
-		if (unlikely(PageError(page))) {
+		if (PageError(page)) {
 			DBG_BUGON(PageUptodate(page));
 			err = -EIO;
 		}
 	}
 
-	if (unlikely(err))
+	if (err)
 		goto out;
 
 	llen = pcl->length >> Z_EROFS_PCLUSTER_LENGTH_BIT;
@@ -926,7 +926,7 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 		if (z_erofs_put_stagingpage(pagepool, page))
 			continue;
 
-		if (unlikely(err < 0))
+		if (err < 0)
 			SetPageError(page);
 
 		z_erofs_onlinepage_endio(page);
@@ -934,7 +934,7 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 
 	if (pages == z_pagemap_global)
 		mutex_unlock(&z_pagemap_global_lock);
-	else if (unlikely(pages != pages_onstack))
+	else if (pages != pages_onstack)
 		kvfree(pages);
 
 	cl->nr_pages = 0;
@@ -1212,7 +1212,7 @@ static bool z_erofs_vle_submit_all(struct super_block *sb,
 	bool force_submit = false;
 	unsigned int nr_bios;
 
-	if (unlikely(owned_head == Z_EROFS_PCLUSTER_TAIL))
+	if (owned_head == Z_EROFS_PCLUSTER_TAIL)
 		return false;
 
 	force_submit = false;
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 4dc9cec01297..850e0e3d57a8 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -348,7 +348,7 @@ static int vle_extent_lookback(struct z_erofs_maprecorder *m,
 
 	switch (m->type) {
 	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
-		if (unlikely(!m->delta[0])) {
+		if (!m->delta[0]) {
 			errln("invalid lookback distance 0 at nid %llu",
 			      vi->nid);
 			DBG_BUGON(1);
@@ -386,7 +386,7 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 	trace_z_erofs_map_blocks_iter_enter(inode, map, flags);
 
 	/* when trying to read beyond EOF, leave it unmapped */
-	if (unlikely(map->m_la >= inode->i_size)) {
+	if (map->m_la >= inode->i_size) {
 		map->m_llen = map->m_la + 1 - inode->i_size;
 		map->m_la = inode->i_size;
 		map->m_flags = 0;
@@ -420,7 +420,7 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 			break;
 		}
 		/* m.lcn should be >= 1 if endoff < m.clusterofs */
-		if (unlikely(!m.lcn)) {
+		if (!m.lcn) {
 			errln("invalid logical cluster 0 at nid %llu",
 			      vi->nid);
 			err = -EFSCORRUPTED;
@@ -433,7 +433,7 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
 		/* get the correspoinding first chunk */
 		err = vle_extent_lookback(&m, m.delta[0]);
-		if (unlikely(err))
+		if (err)
 			goto unmap_out;
 		break;
 	default:
diff --git a/fs/erofs/zpvec.h b/fs/erofs/zpvec.h
index bd3cee16491c..58556903aa94 100644
--- a/fs/erofs/zpvec.h
+++ b/fs/erofs/zpvec.h
@@ -111,11 +111,11 @@ static inline bool z_erofs_pagevec_enqueue(struct z_erofs_pagevec_ctor *ctor,
 					   bool *occupied)
 {
 	*occupied = false;
-	if (unlikely(!ctor->next && type))
+	if (!ctor->next && type)
 		if (ctor->index + 1 == ctor->nr)
 			return false;
 
-	if (unlikely(ctor->index >= ctor->nr))
+	if (ctor->index >= ctor->nr)
 		z_erofs_pagevec_ctor_pagedown(ctor, false);
 
 	/* exclusive page type must be 0 */
@@ -137,7 +137,7 @@ z_erofs_pagevec_dequeue(struct z_erofs_pagevec_ctor *ctor,
 {
 	erofs_vtptr_t t;
 
-	if (unlikely(ctor->index >= ctor->nr)) {
+	if (ctor->index >= ctor->nr) {
 		DBG_BUGON(!ctor->next);
 		z_erofs_pagevec_ctor_pagedown(ctor, true);
 	}
-- 
2.17.1

