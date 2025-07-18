Return-Path: <linux-erofs+bounces-674-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A720BB09BC7
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Jul 2025 08:54:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bk0s94JxQz30WT;
	Fri, 18 Jul 2025 16:54:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752821677;
	cv=none; b=M6eYpexzmQt3JR+G2yzMNJWeMl3AE/2nCcuyqCyzLAj0jXZ247s8wuAyzmt9GrpORtrYqgRCm4GrBVaBZn8HZhpNzxqAMOZWMEEmLiObab5p2k7k8x5tWMJcQ9exJQNj8HFM5Lz7QaAL9nGXvFvqyEQpSypMtnIQROTi6aD4UvPf4szJ5SfBHgPnh3X3PF3oC++HPTi5lbhMIrMSp682NrICUtqEK/IZ/vdjWD3sxEJRQ6dfT3M/Qf6ja9ONZLqtELOjRJXQWDWK/JaESYMA7r/46xrvraLIrKBN8xJxjZSymURwPUplQERK0z33oQLNgRunsASpw3/MHEn6KFaLgw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752821677; c=relaxed/relaxed;
	bh=NOyMFLWbbtp4p8mECRUOjOxoq7B+o1RsGbfsROoppq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E8QIDsSoR9gMnA5YnKSmTSms1sBoTKzyV/aGXdQ9Z4nG9d80JoUqj3bHJT8cj616VBcZPuYRnjL5vthfwIkBmqt/7qw292+6F87XXVJHhNW/yS07ezN3P13eFLBtloLGALKbfz+d0q1u0dSxJ0RsCFI8SI4VdZu1Zu7X1sy64Mz4dVe+kmOrUWVdYdZmLQRe3UV0BiwuBAaL4jQtjqpDNiBvuqKAxd0AWAqAbR4jiqm6LO522kjTxS3gj2fRQeD/IhrkjAeebGkk3pnhe8SMSK6ANAM3EslJq+MNg/uh42PD4v1yibReyng27HJwGMXmbY7m93oKNoqPVy7bORGgcw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pqH+AyKq; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pqH+AyKq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bk0s8369Bz30RK
	for <linux-erofs@lists.ozlabs.org>; Fri, 18 Jul 2025 16:54:36 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752821672; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=NOyMFLWbbtp4p8mECRUOjOxoq7B+o1RsGbfsROoppq0=;
	b=pqH+AyKqCMun3hzu+cZx95kWxABJhDdo5IuX8735vENDP8S9zC7Dz46fSY+kwrCd1HCBQ4djIVuuMS5jcKyOF+VWlo0pYH7CIwYTsVi2MC3YwlZydpTsqj15MSMByt/itx7Yu8tE0l+dekucsOuKl2RllVoTy5xuQi1qnlr53nA=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WjBMlTL_1752821670 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 18 Jul 2025 14:54:31 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 09/11] erofs-utils: formalize erofs_pread()
Date: Fri, 18 Jul 2025 14:54:17 +0800
Message-ID: <20250718065419.3338307-9-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250718065419.3338307-1-hsiangkao@linux.alibaba.com>
References: <20250718065419.3338307-1-hsiangkao@linux.alibaba.com>
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

Now erofs_pread() is simply a wrapper around erofs_io_pread(), and
erofs_iopen() is used to obtain a virtual file for erofs_pread().

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 dump/main.c              | 10 +++++++--
 fsck/main.c              |  7 +++++-
 fuse/main.c              | 23 ++++++++++++++-----
 include/erofs/internal.h |  3 +--
 include/erofs/io.h       | 11 +++++++++
 lib/data.c               | 48 ++++++++++++++++++++++------------------
 lib/dir.c                | 12 ++++++----
 lib/fragments.c          | 20 +++++++++++++----
 lib/inode.c              |  7 +++++-
 lib/namei.c              |  7 +++++-
 lib/rebuild.c            | 10 +++++++--
 lib/super.c              |  3 ++-
 12 files changed, 116 insertions(+), 45 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index 632075a2..f0dab02e 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -679,6 +679,7 @@ static void erofsdump_show_file_content(void)
 	erofs_off_t pending_size;
 	erofs_off_t read_offset;
 	erofs_off_t read_size;
+	struct erofs_vfile vf;
 
 	if (dumpcfg.inode_path) {
 		err = erofs_ilookup(dumpcfg.inode_path, &inode);
@@ -694,6 +695,10 @@ static void erofsdump_show_file_content(void)
 		}
 	}
 
+	err = erofs_iopen(&vf, &inode);
+	if (err)
+		return;
+
 	buffer_size = erofs_blksiz(inode.sbi);
 	buffer_ptr = malloc(buffer_size);
 	if (!buffer_ptr) {
@@ -704,8 +709,9 @@ static void erofsdump_show_file_content(void)
 	pending_size = inode.i_size;
 	read_offset = 0;
 	while (pending_size > 0) {
-		read_size = pending_size > buffer_size? buffer_size: pending_size;
-		err = erofs_pread(&inode, buffer_ptr, read_size, read_offset);
+		read_size = pending_size > buffer_size ?
+			buffer_size : pending_size;
+		err = erofs_pread(&vf, buffer_ptr, read_size, read_offset);
 		if (err) {
 			erofs_err("read file failed @ nid %llu", inode.nid | 0ULL);
 			goto out;
diff --git a/fsck/main.c b/fsck/main.c
index 96096a91..44719b95 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -775,6 +775,7 @@ again:
 
 static inline int erofs_extract_symlink(struct erofs_inode *inode)
 {
+	struct erofs_vfile vf;
 	bool tryagain = true;
 	int ret;
 	char *buf = NULL;
@@ -792,7 +793,11 @@ static inline int erofs_extract_symlink(struct erofs_inode *inode)
 		goto out;
 	}
 
-	ret = erofs_pread(inode, buf, inode->i_size, 0);
+	ret = erofs_iopen(&vf, inode);
+	if (ret)
+		goto out;
+
+	ret = erofs_pread(&vf, buf, inode->i_size, 0);
 	if (ret) {
 		erofs_err("I/O error occurred when reading symlink @ nid %llu: %d",
 			  inode->nid | 0ULL, ret);
diff --git a/fuse/main.c b/fuse/main.c
index db4f3236..001d1fde 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -366,11 +366,15 @@ out:
 static void erofsfuse_read(fuse_req_t req, fuse_ino_t ino, size_t size,
 			   off_t off, struct fuse_file_info *fi)
 {
-	int ret;
-	char *buf = NULL;
 	struct erofs_inode *vi = (struct erofs_inode *)fi->fh;
+	struct erofs_vfile vf;
+	char *buf = NULL;
+	int ret;
 
 	erofs_dbg("read(%llu): size = %zu, off = %lu", ino | 0ULL, size, off);
+	ret = erofs_iopen(&vf, vi);
+	if (ret)
+		return ret;
 
 	buf = malloc(size);
 	if (!buf) {
@@ -378,7 +382,7 @@ static void erofsfuse_read(fuse_req_t req, fuse_ino_t ino, size_t size,
 		return;
 	}
 
-	ret = erofs_pread(vi, buf, size, off);
+	ret = erofs_pread(&vf, buf, size, off);
 	if (ret) {
 		fuse_reply_err(req, -ret);
 		goto out;
@@ -398,9 +402,10 @@ out:
 
 static void erofsfuse_readlink(fuse_req_t req, fuse_ino_t ino)
 {
-	int ret;
-	char *buf = NULL;
 	struct erofs_inode vi = { .sbi = &g_sbi, .nid = erofsfuse_to_nid(ino) };
+	struct erofs_vfile vf;
+	char *buf = NULL;
+	int ret;
 
 	ret = erofs_read_inode_from_disk(&vi);
 	if (ret < 0) {
@@ -408,13 +413,19 @@ static void erofsfuse_readlink(fuse_req_t req, fuse_ino_t ino)
 		return;
 	}
 
+	ret = erofs_iopen(&vf, &vi);
+	if (ret) {
+		fuse_reply_err(req, -ret);
+		return;
+	}
+
 	buf = malloc(vi.i_size + 1);
 	if (!buf) {
 		fuse_reply_err(req, ENOMEM);
 		return;
 	}
 
-	ret = erofs_pread(&vi, buf, vi.i_size, 0);
+	ret = erofs_pread(&vf, buf, vi.i_size, 0);
 	if (ret < 0) {
 		fuse_reply_err(req, -ret);
 		goto out;
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 0a49394d..3439a183 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -440,8 +440,7 @@ void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset, bool need_kmap);
 void erofs_init_metabuf(struct erofs_buf *buf, struct erofs_sb_info *sbi);
 void *erofs_read_metabuf(struct erofs_buf *buf, struct erofs_sb_info *sbi,
 			 erofs_off_t offset);
-int erofs_pread(struct erofs_inode *inode, char *buf,
-		erofs_off_t count, erofs_off_t offset);
+int erofs_iopen(struct erofs_vfile *vf, struct erofs_inode *inode);
 int erofs_map_blocks(struct erofs_inode *inode,
 		struct erofs_map_blocks *map, int flags);
 int erofs_map_dev(struct erofs_sb_info *sbi, struct erofs_map_dev *map);
diff --git a/include/erofs/io.h b/include/erofs/io.h
index 01a7ff44..cc7a3cd2 100644
--- a/include/erofs/io.h
+++ b/include/erofs/io.h
@@ -70,6 +70,17 @@ ssize_t erofs_copy_file_range(int fd_in, u64 *off_in, int fd_out, u64 *off_out,
 int erofs_io_xcopy(struct erofs_vfile *vout, off_t pos,
 		   struct erofs_vfile *vin, unsigned int len, bool noseek);
 
+static inline int erofs_pread(struct erofs_vfile *vf, void *buf,
+			      size_t len, u64 offset)
+{
+	ssize_t read;
+
+	read = erofs_io_pread(vf, buf, len, offset);
+	if (read < 0)
+		return read;
+	return read != len ? -EIO : 0;
+}
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/data.c b/lib/data.c
index 83cc5d5d..87ced24f 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -22,12 +22,10 @@ void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset, bool need_kmap)
 	blknr = erofs_blknr(sbi, offset);
 	if (blknr != buf->blocknr) {
 		buf->blocknr = ~0ULL;
-		err = erofs_io_pread(buf->vf, buf->base, blksiz,
-				     round_down(offset, blksiz));
-		if (err < 0)
+		err = erofs_pread(buf->vf, buf->base, blksiz,
+				  round_down(offset, blksiz));
+		if (err)
 			return ERR_PTR(err);
-		if (err != blksiz)
-			return ERR_PTR(-EIO);
 		buf->blocknr = blknr;
 	}
 	return buf->base + erofs_blkoff(sbi, offset);
@@ -364,27 +362,31 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 	return ret < 0 ? ret : 0;
 }
 
-int erofs_pread(struct erofs_inode *inode, char *buf,
-		erofs_off_t count, erofs_off_t offset)
+ssize_t erofs_preadi(struct erofs_vfile *vf, void *buf, size_t len, u64 offset)
 {
-	switch (inode->datalayout) {
-	case EROFS_INODE_FLAT_PLAIN:
-	case EROFS_INODE_FLAT_INLINE:
-	case EROFS_INODE_CHUNK_BASED:
-		return erofs_read_raw_data(inode, buf, count, offset);
-	case EROFS_INODE_COMPRESSED_FULL:
-	case EROFS_INODE_COMPRESSED_COMPACT:
-		return z_erofs_read_data(inode, buf, count, offset);
-	default:
-		break;
-	}
-	return -EINVAL;
+	struct erofs_inode *inode = *(struct erofs_inode **)vf->payload;
+
+	if (erofs_inode_is_data_compressed(inode->datalayout))
+		return z_erofs_read_data(inode, buf, len, offset) ?: len;
+	return erofs_read_raw_data(inode, buf, len, offset) ?: len;
+}
+
+int erofs_iopen(struct erofs_vfile *vf, struct erofs_inode *inode)
+{
+	static struct erofs_vfops ops = {
+		.pread = erofs_preadi,
+	};
+
+	vf->ops = &ops;
+	*(struct erofs_inode **)vf->payload = inode;
+	return 0;
 }
 
 static void *erofs_read_metadata_nid(struct erofs_sb_info *sbi, erofs_nid_t nid,
 				     erofs_off_t *offset, int *lengthp)
 {
 	struct erofs_inode vi = { .sbi = sbi, .nid = nid };
+	struct erofs_vfile vf;
 	__le16 __len;
 	int ret, len;
 	char *buffer;
@@ -393,8 +395,12 @@ static void *erofs_read_metadata_nid(struct erofs_sb_info *sbi, erofs_nid_t nid,
 	if (ret)
 		return ERR_PTR(ret);
 
+	ret = erofs_iopen(&vf, &vi);
+	if (ret)
+		return ERR_PTR(ret);
+
 	*offset = round_up(*offset, 4);
-	ret = erofs_pread(&vi, (void *)&__len, sizeof(__le16), *offset);
+	ret = erofs_pread(&vf, (void *)&__len, sizeof(__le16), *offset);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -408,7 +414,7 @@ static void *erofs_read_metadata_nid(struct erofs_sb_info *sbi, erofs_nid_t nid,
 	*offset += sizeof(__le16);
 	*lengthp = len;
 
-	ret = erofs_pread(&vi, buffer, len, *offset);
+	ret = erofs_pread(&vf, buffer, len, *offset);
 	if (ret) {
 		free(buffer);
 		return ERR_PTR(ret);
diff --git a/lib/dir.c b/lib/dir.c
index 9c6849d8..98edb8e1 100644
--- a/lib/dir.c
+++ b/lib/dir.c
@@ -142,9 +142,10 @@ int erofs_iterate_dir(struct erofs_dir_context *ctx, bool fsck)
 {
 	struct erofs_inode *dir = ctx->dir;
 	struct erofs_sb_info *sbi = dir->sbi;
-	int err = 0;
+	struct erofs_vfile vf;
 	erofs_off_t pos;
 	char buf[EROFS_MAX_BLOCK_SIZE];
+	int err = 0;
 
 	if (!S_ISDIR(dir->i_mode))
 		return -ENOTDIR;
@@ -152,15 +153,18 @@ int erofs_iterate_dir(struct erofs_dir_context *ctx, bool fsck)
 	ctx->flags &= ~EROFS_READDIR_ALL_SPECIAL_FOUND;
 	if (dir->dot_omitted)
 		ctx->flags |= EROFS_READDIR_DOT_FOUND;
-	pos = 0;
-	while (pos < dir->i_size) {
+	err = erofs_iopen(&vf, dir);
+	if (err)
+		return err;
+
+	for (pos = 0; pos < dir->i_size; ) {
 		erofs_blk_t lblk = erofs_blknr(sbi, pos);
 		erofs_off_t maxsize = min_t(erofs_off_t,
 					dir->i_size - pos, erofs_blksiz(sbi));
 		const struct erofs_dirent *de = (const void *)buf;
 		unsigned int nameoff;
 
-		err = erofs_pread(dir, buf, maxsize, pos);
+		err = erofs_pread(&vf, buf, maxsize, pos);
 		if (err) {
 			erofs_err("I/O error when reading dirents @ nid %llu, lblk %llu: %s",
 				  dir->nid | 0ULL, lblk | 0ULL,
diff --git a/lib/fragments.c b/lib/fragments.c
index 887c2530..0221a538 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -510,6 +510,7 @@ static void *erofs_packedfile_preload(struct erofs_inode *pi,
 	struct erofs_sb_info *sbi = pi->sbi;
 	struct erofs_packed_inode *epi = sbi->packedinode;
 	unsigned int bsz = erofs_blksiz(sbi);
+	struct erofs_vfile vf;
 	char *buffer;
 	erofs_off_t pos, end;
 	ssize_t err;
@@ -529,13 +530,17 @@ static void *erofs_packedfile_preload(struct erofs_inode *pi,
 	else
 		DBG_BUGON(map->m_la > pos);
 
+	err = erofs_iopen(&vf, pi);
+	if (err)
+		return ERR_PTR(err);
+
 	map->m_llen = end - map->m_la;
 	DBG_BUGON(!map->m_llen);
 	buffer = malloc(map->m_llen);
 	if (!buffer)
 		return ERR_PTR(-ENOMEM);
 
-	err = erofs_pread(pi, buffer, map->m_llen, map->m_la);
+	err = erofs_pread(&vf, buffer, map->m_llen, map->m_la);
 	if (err)
 		goto err_out;
 
@@ -572,13 +577,17 @@ int erofs_packedfile_read(struct erofs_sb_info *sbi,
 	struct erofs_map_blocks map = { .buf = __EROFS_BUF_INITIALIZER };
 	unsigned int bsz = erofs_blksiz(sbi);
 	erofs_off_t end = pos + len;
+	struct erofs_vfile vf;
 	char *buffer = NULL;
 	int err;
 
 	if (!epi) {
 		err = erofs_load_packedinode_from_disk(&pi);
-		if (!err)
-			err = erofs_pread(&pi, buf, len, pos);
+		if (!err) {
+			err = erofs_iopen(&vf, &pi);
+			if (!err)
+				err = erofs_pread(&vf, buf, len, pos);
+		}
 		return err;
 	}
 
@@ -632,8 +641,11 @@ int erofs_packedfile_read(struct erofs_sb_info *sbi,
 			} else {
 fallback:
 				err = erofs_load_packedinode_from_disk(&pi);
+				if (err)
+					break;
+				err = erofs_iopen(&vf, &pi);
 				if (!err)
-					err = erofs_pread(&pi, buf, len, pos);
+					err = erofs_pread(&vf, buf, len, pos);
 				if (err)
 					break;
 			}
diff --git a/lib/inode.c b/lib/inode.c
index f7c6b87f..5f50c09f 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -371,6 +371,7 @@ static int erofs_rebuild_inode_fix_pnid(struct erofs_inode *parent,
 	};
 	unsigned int bsz = erofs_blksiz(dir.sbi);
 	unsigned int err, isz;
+	struct erofs_vfile vf;
 	erofs_off_t boff, off;
 	erofs_nid_t pnid;
 	bool fixed = false;
@@ -386,6 +387,10 @@ static int erofs_rebuild_inode_fix_pnid(struct erofs_inode *parent,
 	    dir.datalayout != EROFS_INODE_FLAT_PLAIN)
 		return -EOPNOTSUPP;
 
+	err = erofs_iopen(&vf, &dir);
+	if (err)
+		return err;
+
 	pnid = erofs_lookupnid(parent);
 	isz = dir.inode_isize + dir.xattr_isize;
 	boff = erofs_pos(dir.sbi, dir.u.i_blkaddr);
@@ -395,7 +400,7 @@ static int erofs_rebuild_inode_fix_pnid(struct erofs_inode *parent,
 		unsigned int nameoff, count, de_nameoff;
 
 		count = min_t(erofs_off_t, bsz, dir.i_size - off);
-		err = erofs_pread(&dir, buf, count, off);
+		err = erofs_pread(&vf, buf, count, off);
 		if (err)
 			return err;
 
diff --git a/lib/namei.c b/lib/namei.c
index c3ddd590..8de0a908 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -224,12 +224,17 @@ int erofs_namei(struct nameidata *nd, const char *name, unsigned int len)
 	char buf[EROFS_MAX_BLOCK_SIZE];
 	struct erofs_sb_info *sbi = nd->sbi;
 	struct erofs_inode vi = { .sbi = sbi, .nid = nid };
+	struct erofs_vfile vf;
 	erofs_off_t offset;
 
 	ret = erofs_read_inode_from_disk(&vi);
 	if (ret)
 		return ret;
 
+	ret = erofs_iopen(&vf, &vi);
+	if (ret)
+		return ret;
+
 	offset = 0;
 	while (offset < vi.i_size) {
 		erofs_off_t maxsize = min_t(erofs_off_t,
@@ -237,7 +242,7 @@ int erofs_namei(struct nameidata *nd, const char *name, unsigned int len)
 		struct erofs_dirent *de = (void *)buf;
 		unsigned int nameoff;
 
-		ret = erofs_pread(&vi, buf, maxsize, offset);
+		ret = erofs_pread(&vf, buf, maxsize, offset);
 		if (ret)
 			return ret;
 
diff --git a/lib/rebuild.c b/lib/rebuild.c
index 33857fd6..7ad0658a 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -243,13 +243,19 @@ static int erofs_rebuild_update_inode(struct erofs_sb_info *dst_sb,
 	case S_IFDIR:
 		err = erofs_init_empty_dir(inode);
 		break;
-	case S_IFLNK:
+	case S_IFLNK: {
+		struct erofs_vfile vf;
+
 		inode->i_link = malloc(inode->i_size + 1);
 		if (!inode->i_link)
 			return -ENOMEM;
-		err = erofs_pread(inode, inode->i_link, inode->i_size, 0);
+		err = erofs_iopen(&vf, inode);
+		if (err)
+			return err;
+		err = erofs_pread(&vf, inode->i_link, inode->i_size, 0);
 		erofs_dbg("\tsymlink: %s -> %s", inode->i_srcpath, inode->i_link);
 		break;
+	}
 	case S_IFREG:
 		if (!inode->i_size) {
 			inode->u.i_blkaddr = EROFS_NULL_ADDR;
diff --git a/lib/super.c b/lib/super.c
index 8c0abafd..1d13e6e3 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -81,7 +81,8 @@ int erofs_read_superblock(struct erofs_sb_info *sbi)
 	read = erofs_io_pread(&sbi->bdev, data, EROFS_MAX_BLOCK_SIZE, 0);
 	if (read < EROFS_SUPER_END) {
 		ret = read < 0 ? read : -EIO;
-		erofs_err("cannot read erofs superblock: %d", ret);
+		erofs_err("cannot read erofs superblock: %s",
+			  erofs_strerror(ret));
 		return ret;
 	}
 	dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
-- 
2.43.5


