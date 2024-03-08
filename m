Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F174876116
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Mar 2024 10:42:17 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bTzp6ARn;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Trh5y6yTDz3dWF
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Mar 2024 20:42:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bTzp6ARn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Trh5s2P9Wz3dSj
	for <linux-erofs@lists.ozlabs.org>; Fri,  8 Mar 2024 20:42:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709890922; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=PohGYe+mm6oxbfvIxTFM4WCMG4EhVItl1TIJs+7QSW4=;
	b=bTzp6ARnd6RTOV9cFccCH94Zeuz79YqvcKFpm8BxOZG8bbsTnvp8YvyKinr9YpKOaYSWFfLy8mT4TO/iXpIXKYDZd0Gs+fVIvFJoXpSQvNnbODd7+igGbJbE0h4L9EqFjbFc3OJZoX6BSGSK99qKrfDCmKBKkTN6UqF9FCbY24M=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W22IFiv_1709890920;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W22IFiv_1709890920)
          by smtp.aliyun-inc.com;
          Fri, 08 Mar 2024 17:42:01 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs: support compressed inodes over fscache
Date: Fri,  8 Mar 2024 17:41:59 +0800
Message-Id: <20240308094159.40547-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240308094159.40547-1-jefflexu@linux.alibaba.com>
References: <20240308094159.40547-1-jefflexu@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Since fscache can utilize iov_iter to write dest buffers, bio_vec can
be used in this way too.

To simplify this, pseudo bios are prepared and bio_vec will be filled
with bio_add_page().  And a common .bi_end_io will be called directly
to handle I/O completion.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c  | 47 +++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/inode.c    | 14 ++++++--------
 fs/erofs/internal.h |  4 ++++
 fs/erofs/zdata.c    | 32 ++++++++++++++++++------------
 4 files changed, 77 insertions(+), 20 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index b9fb4c4da39c..8aff1a724805 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -174,6 +174,53 @@ static int erofs_fscache_read_io_async(struct fscache_cookie *cookie,
 	return 0;
 }
 
+struct erofs_fscache_bio {
+	struct erofs_fscache_io io;
+	struct bio bio;		/* w/o bdev to share bio_add_page/endio() */
+	struct bio_vec bvecs[BIO_MAX_VECS];
+};
+
+static void erofs_fscache_bio_endio(void *priv,
+		ssize_t transferred_or_error, bool was_async)
+{
+	struct erofs_fscache_bio *io = priv;
+
+	if (IS_ERR_VALUE(transferred_or_error))
+		io->bio.bi_status = errno_to_blk_status(transferred_or_error);
+	io->bio.bi_end_io(&io->bio);
+	BUILD_BUG_ON(offsetof(struct erofs_fscache_bio, io) != 0);
+	erofs_fscache_io_put(&io->io);
+}
+
+struct bio *erofs_fscache_bio_alloc(struct erofs_map_dev *mdev)
+{
+	struct erofs_fscache_bio *io;
+
+	io = kmalloc(sizeof(*io), GFP_KERNEL | __GFP_NOFAIL);
+	bio_init(&io->bio, NULL, io->bvecs, BIO_MAX_VECS, REQ_OP_READ);
+	io->io.private = mdev->m_fscache->cookie;
+	io->io.end_io = erofs_fscache_bio_endio;
+	refcount_set(&io->io.ref, 1);
+	return &io->bio;
+}
+
+void erofs_fscache_submit_bio(struct bio *bio)
+{
+	struct erofs_fscache_bio *io = container_of(bio,
+			struct erofs_fscache_bio, bio);
+	int ret;
+
+	iov_iter_bvec(&io->io.iter, ITER_DEST, io->bvecs, bio->bi_vcnt,
+		      bio->bi_iter.bi_size);
+	ret = erofs_fscache_read_io_async(io->io.private,
+				bio->bi_iter.bi_sector << 9, &io->io);
+	erofs_fscache_io_put(&io->io);
+	if (!ret)
+		return;
+	bio->bi_status = errno_to_blk_status(ret);
+	bio->bi_end_io(bio);
+}
+
 static int erofs_fscache_meta_read_folio(struct file *data, struct folio *folio)
 {
 	struct erofs_fscache *ctx = folio->mapping->host->i_private;
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 36e638e8b53a..0eb0e6f933c3 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -259,14 +259,12 @@ static int erofs_fill_inode(struct inode *inode)
 
 	if (erofs_inode_is_data_compressed(vi->datalayout)) {
 #ifdef CONFIG_EROFS_FS_ZIP
-		if (!erofs_is_fscache_mode(inode->i_sb)) {
-			DO_ONCE_LITE_IF(inode->i_sb->s_blocksize != PAGE_SIZE,
-				  erofs_info, inode->i_sb,
-				  "EXPERIMENTAL EROFS subpage compressed block support in use. Use at your own risk!");
-			inode->i_mapping->a_ops = &z_erofs_aops;
-			err = 0;
-			goto out_unlock;
-		}
+		DO_ONCE_LITE_IF(inode->i_blkbits != PAGE_SHIFT,
+			  erofs_info, inode->i_sb,
+			  "EXPERIMENTAL EROFS subpage compressed block support in use. Use at your own risk!");
+		inode->i_mapping->a_ops = &z_erofs_aops;
+		err = 0;
+		goto out_unlock;
 #endif
 		err = -EOPNOTSUPP;
 		goto out_unlock;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index f8623113be6c..92120bf4ab71 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -512,6 +512,8 @@ void erofs_fscache_unregister_fs(struct super_block *sb);
 struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
 					char *name, unsigned int flags);
 void erofs_fscache_unregister_cookie(struct erofs_fscache *fscache);
+struct bio *erofs_fscache_bio_alloc(struct erofs_map_dev *mdev);
+void erofs_fscache_submit_bio(struct bio *bio);
 #else
 static inline int erofs_fscache_register_fs(struct super_block *sb)
 {
@@ -529,6 +531,8 @@ struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
 static inline void erofs_fscache_unregister_cookie(struct erofs_fscache *fscache)
 {
 }
+static inline struct bio *erofs_fscache_bio_alloc(struct erofs_map_dev *mdev) { return NULL; }
+static inline void erofs_fscache_submit_bio(struct bio *bio) {}
 #endif
 
 #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index c1bd4d8392eb..3216b920d369 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1561,7 +1561,7 @@ static void move_to_bypass_jobqueue(struct z_erofs_pcluster *pcl,
 	qtail[JQ_BYPASS] = &pcl->next;
 }
 
-static void z_erofs_submissionqueue_endio(struct bio *bio)
+static void z_erofs_endio(struct bio *bio)
 {
 	struct z_erofs_decompressqueue *q = bio->bi_private;
 	blk_status_t err = bio->bi_status;
@@ -1582,7 +1582,8 @@ static void z_erofs_submissionqueue_endio(struct bio *bio)
 	if (err)
 		q->eio = true;
 	z_erofs_decompress_kickoff(q, -1);
-	bio_put(bio);
+	if (bio->bi_bdev)
+		bio_put(bio);
 }
 
 static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
@@ -1596,7 +1597,6 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 	z_erofs_next_pcluster_t owned_head = f->owned_head;
 	/* bio is NULL initially, so no need to initialize last_{index,bdev} */
 	erofs_off_t last_pa;
-	struct block_device *last_bdev;
 	unsigned int nr_bios = 0;
 	struct bio *bio = NULL;
 	unsigned long pflags;
@@ -1643,9 +1643,13 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 				continue;
 
 			if (bio && (cur != last_pa ||
-				    last_bdev != mdev.m_bdev)) {
-submit_bio_retry:
-				submit_bio(bio);
+				    bio->bi_bdev != mdev.m_bdev)) {
+io_retry:
+				if (!erofs_is_fscache_mode(sb))
+					submit_bio(bio);
+				else
+					erofs_fscache_submit_bio(bio);
+
 				if (memstall) {
 					psi_memstall_leave(&pflags);
 					memstall = 0;
@@ -1660,15 +1664,16 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 			}
 
 			if (!bio) {
-				bio = bio_alloc(mdev.m_bdev, BIO_MAX_VECS,
-						REQ_OP_READ, GFP_NOIO);
-				bio->bi_end_io = z_erofs_submissionqueue_endio;
+				bio = erofs_is_fscache_mode(sb) ?
+					erofs_fscache_bio_alloc(&mdev) :
+					bio_alloc(mdev.m_bdev, BIO_MAX_VECS,
+						  REQ_OP_READ, GFP_NOIO);
+				bio->bi_end_io = z_erofs_endio;
 				bio->bi_iter.bi_sector = cur >> 9;
 				bio->bi_private = q[JQ_SUBMIT];
 				if (readahead)
 					bio->bi_opf |= REQ_RAHEAD;
 				++nr_bios;
-				last_bdev = mdev.m_bdev;
 			}
 
 			if (cur + bvec.bv_len > end)
@@ -1676,7 +1681,7 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 			DBG_BUGON(bvec.bv_len < sb->s_blocksize);
 			if (!bio_add_page(bio, bvec.bv_page, bvec.bv_len,
 					  bvec.bv_offset))
-				goto submit_bio_retry;
+				goto io_retry;
 
 			last_pa = cur + bvec.bv_len;
 			bypass = false;
@@ -1689,7 +1694,10 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 	} while (owned_head != Z_EROFS_PCLUSTER_TAIL);
 
 	if (bio) {
-		submit_bio(bio);
+		if (!erofs_is_fscache_mode(sb))
+			submit_bio(bio);
+		else
+			erofs_fscache_submit_bio(bio);
 		if (memstall)
 			psi_memstall_leave(&pflags);
 	}
-- 
2.19.1.6.gb485710b

