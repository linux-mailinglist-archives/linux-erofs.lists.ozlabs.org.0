Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9334C6DAEAF
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Apr 2023 16:17:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PtL6W3mtZz3fVc
	for <lists+linux-erofs@lfdr.de>; Sat,  8 Apr 2023 00:17:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PtL6N6cR1z3fSD
	for <linux-erofs@lists.ozlabs.org>; Sat,  8 Apr 2023 00:17:16 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VfX2QQC_1680877032;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VfX2QQC_1680877032)
          by smtp.aliyun-inc.com;
          Fri, 07 Apr 2023 22:17:12 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/7] erofs: keep meta inode into erofs_buf
Date: Fri,  7 Apr 2023 22:17:04 +0800
Message-Id: <20230407141710.113882-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230407141710.113882-1-jefflexu@linux.alibaba.com>
References: <20230407141710.113882-1-jefflexu@linux.alibaba.com>
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

From: Gao Xiang <hsiangkao@linux.alibaba.com>

So that erofs_read_metadata() can read metadata from other inodes
(e.g. packed inode) as well.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/data.c     | 23 ++++++++++++++---------
 fs/erofs/dir.c      |  3 ++-
 fs/erofs/internal.h |  6 ++++--
 fs/erofs/namei.c    |  4 +++-
 fs/erofs/super.c    |  6 +++---
 fs/erofs/zdata.c    |  4 ++--
 6 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index e5458b4c3d0c..aa7f9e4f86fb 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -31,11 +31,11 @@ void erofs_put_metabuf(struct erofs_buf *buf)
  * Derive the block size from inode->i_blkbits to make compatible with
  * anonymous inode in fscache mode.
  */
-void *erofs_bread(struct erofs_buf *buf, struct inode *inode,
-		  erofs_blk_t blkaddr, enum erofs_kmap_type type)
+void *erofs_bread(struct erofs_buf *buf, erofs_blk_t blkaddr,
+		  enum erofs_kmap_type type)
 {
+	struct inode *inode = buf->inode;
 	erofs_off_t offset = blkaddr << inode->i_blkbits;
-	struct address_space *const mapping = inode->i_mapping;
 	pgoff_t index = offset >> PAGE_SHIFT;
 	struct page *page = buf->page;
 	struct folio *folio;
@@ -45,7 +45,7 @@ void *erofs_bread(struct erofs_buf *buf, struct inode *inode,
 		erofs_put_metabuf(buf);
 
 		nofs_flag = memalloc_nofs_save();
-		folio = read_cache_folio(mapping, index, NULL, NULL);
+		folio = read_cache_folio(inode->i_mapping, index, NULL, NULL);
 		memalloc_nofs_restore(nofs_flag);
 		if (IS_ERR(folio))
 			return folio;
@@ -67,14 +67,19 @@ void *erofs_bread(struct erofs_buf *buf, struct inode *inode,
 	return buf->base + (offset & ~PAGE_MASK);
 }
 
-void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
-			 erofs_blk_t blkaddr, enum erofs_kmap_type type)
+void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
 {
 	if (erofs_is_fscache_mode(sb))
-		return erofs_bread(buf, EROFS_SB(sb)->s_fscache->inode,
-				   blkaddr, type);
+		buf->inode = EROFS_SB(sb)->s_fscache->inode;
+	else
+		buf->inode = sb->s_bdev->bd_inode;
+}
 
-	return erofs_bread(buf, sb->s_bdev->bd_inode, blkaddr, type);
+void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
+			 erofs_blk_t blkaddr, enum erofs_kmap_type type)
+{
+	erofs_init_metabuf(buf, sb);
+	return erofs_bread(buf, blkaddr, type);
 }
 
 static int erofs_map_blocks_flatmode(struct inode *inode,
diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index 963bbed0b699..b80abec0531a 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -58,11 +58,12 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 	int err = 0;
 	bool initial = true;
 
+	buf.inode = dir;
 	while (ctx->pos < dirsize) {
 		struct erofs_dirent *de;
 		unsigned int nameoff, maxsize;
 
-		de = erofs_bread(&buf, dir, i, EROFS_KMAP);
+		de = erofs_bread(&buf, i, EROFS_KMAP);
 		if (IS_ERR(de)) {
 			erofs_err(sb, "fail to readdir of logical block %u of nid %llu",
 				  i, EROFS_I(dir)->nid);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index e30a4fd43ccb..2bcff3194e4a 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -247,6 +247,7 @@ enum erofs_kmap_type {
 };
 
 struct erofs_buf {
+	struct inode *inode;
 	struct page *page;
 	void *base;
 	enum erofs_kmap_type kmap_type;
@@ -440,8 +441,9 @@ extern const struct iomap_ops z_erofs_iomap_report_ops;
 
 void erofs_unmap_metabuf(struct erofs_buf *buf);
 void erofs_put_metabuf(struct erofs_buf *buf);
-void *erofs_bread(struct erofs_buf *buf, struct inode *inode,
-		  erofs_blk_t blkaddr, enum erofs_kmap_type type);
+void *erofs_bread(struct erofs_buf *buf, erofs_blk_t blkaddr,
+		  enum erofs_kmap_type type);
+void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb);
 void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
 			 erofs_blk_t blkaddr, enum erofs_kmap_type type);
 int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *dev);
diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
index f091e9a0f0a1..43096bac4c99 100644
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -99,7 +99,8 @@ static void *erofs_find_target_block(struct erofs_buf *target,
 		struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 		struct erofs_dirent *de;
 
-		de = erofs_bread(&buf, dir, mid, EROFS_KMAP);
+		buf.inode = dir;
+		de = erofs_bread(&buf, mid, EROFS_KMAP);
 		if (!IS_ERR(de)) {
 			const int nameoff = nameoff_from_disk(de->nameoff, bsz);
 			const int ndirents = nameoff / sizeof(*de);
@@ -170,6 +171,7 @@ int erofs_namei(struct inode *dir, const struct qstr *name, erofs_nid_t *nid,
 
 	qn.name = name->name;
 	qn.end = name->name + name->len;
+	buf.inode = dir;
 
 	ndirents = 0;
 	de = erofs_find_target_block(&buf, dir, &qn, &ndirents);
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 9e56a6fb2267..58ffbf410bfb 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -135,7 +135,7 @@ static void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
 	int len, i, cnt;
 
 	*offset = round_up(*offset, 4);
-	ptr = erofs_read_metabuf(buf, sb, erofs_blknr(sb, *offset), EROFS_KMAP);
+	ptr = erofs_bread(buf, erofs_blknr(sb, *offset), EROFS_KMAP);
 	if (IS_ERR(ptr))
 		return ptr;
 
@@ -151,8 +151,7 @@ static void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
 	for (i = 0; i < len; i += cnt) {
 		cnt = min_t(int, sb->s_blocksize - erofs_blkoff(sb, *offset),
 			    len - i);
-		ptr = erofs_read_metabuf(buf, sb, erofs_blknr(sb, *offset),
-					 EROFS_KMAP);
+		ptr = erofs_bread(buf, erofs_blknr(sb, *offset), EROFS_KMAP);
 		if (IS_ERR(ptr)) {
 			kfree(buffer);
 			return ptr;
@@ -179,6 +178,7 @@ static int erofs_load_compr_cfgs(struct super_block *sb,
 		return -EINVAL;
 	}
 
+	erofs_init_metabuf(&buf, sb);
 	offset = EROFS_SUPER_OFFSET + sbi->sb_size;
 	alg = 0;
 	for (algs = sbi->available_compr_algs; algs; algs >>= 1, ++alg) {
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index a90d37c7bdd7..34944e400037 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -939,12 +939,12 @@ static int z_erofs_read_fragment(struct inode *inode, erofs_off_t pos,
 	if (!packed_inode)
 		return -EFSCORRUPTED;
 
+	buf.inode = packed_inode;
 	pos += EROFS_I(inode)->z_fragmentoff;
 	for (i = 0; i < len; i += cnt) {
 		cnt = min_t(unsigned int, len - i,
 			    sb->s_blocksize - erofs_blkoff(sb, pos));
-		src = erofs_bread(&buf, packed_inode,
-				  erofs_blknr(sb, pos), EROFS_KMAP);
+		src = erofs_bread(&buf, erofs_blknr(sb, pos), EROFS_KMAP);
 		if (IS_ERR(src)) {
 			erofs_put_metabuf(&buf);
 			return PTR_ERR(src);
-- 
2.19.1.6.gb485710b

