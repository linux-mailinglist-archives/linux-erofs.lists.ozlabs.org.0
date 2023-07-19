Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5F0758F15
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Jul 2023 09:33:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R5SH93FJcz3cNC
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Jul 2023 17:33:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R5SGt5qRCz3c0n
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Jul 2023 17:33:25 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VnkkMkl_1689752000;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VnkkMkl_1689752000)
          by smtp.aliyun-inc.com;
          Wed, 19 Jul 2023 15:33:21 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 1/2] erofs-utils: simplify iloc()
Date: Wed, 19 Jul 2023 15:33:18 +0800
Message-Id: <20230719073319.27996-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230719073319.27996-1-jefflexu@linux.alibaba.com>
References: <20230719073319.27996-1-jefflexu@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Pass in inodes directly to clean up all callers.  Also rename iloc() as
erofs_iloc().

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fsck/main.c              |  2 +-
 include/erofs/internal.h | 10 +++++-----
 lib/data.c               |  4 ++--
 lib/namei.c              |  2 +-
 lib/xattr.c              |  8 ++++----
 lib/zmap.c               |  6 +++---
 6 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 608635e..aabfda4 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -325,7 +325,7 @@ static int erofs_verify_xattr(struct erofs_inode *inode)
 		}
 	}
 
-	addr = iloc(inode->nid) + inode->inode_isize;
+	addr = erofs_iloc(inode) + inode->inode_isize;
 	ret = dev_read(0, buf, addr, xattr_hdr_size);
 	if (ret < 0) {
 		erofs_err("failed to read xattr header @ nid %llu: %d",
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 46690f5..93e3a0b 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -103,11 +103,6 @@ struct erofs_sb_info {
 /* make sure that any user of the erofs headers has atleast 64bit off_t type */
 extern int erofs_assert_largefile[sizeof(off_t)-8];
 
-static inline erofs_off_t iloc(erofs_nid_t nid)
-{
-	return erofs_pos(sbi.meta_blkaddr) + (nid << sbi.islotbits);
-}
-
 #define EROFS_FEATURE_FUNCS(name, compat, feature) \
 static inline bool erofs_sb_has_##name(void) \
 { \
@@ -219,6 +214,11 @@ struct erofs_inode {
 	unsigned int fragment_size;
 };
 
+static inline erofs_off_t erofs_iloc(struct erofs_inode *inode)
+{
+	return erofs_pos(sbi.meta_blkaddr) + (inode->nid << sbi.islotbits);
+}
+
 static inline bool is_inode_layout_compression(struct erofs_inode *inode)
 {
 	return erofs_inode_is_data_compressed(inode->datalayout);
diff --git a/lib/data.c b/lib/data.c
index 612112a..86e28d9 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -33,7 +33,7 @@ static int erofs_map_blocks_flatmode(struct erofs_inode *inode,
 		map->m_plen = erofs_pos(lastblk) - offset;
 	} else if (tailendpacking) {
 		/* 2 - inode inline B: inode, [xattrs], inline last blk... */
-		map->m_pa = iloc(vi->nid) + vi->inode_isize +
+		map->m_pa = erofs_iloc(vi) + vi->inode_isize +
 			vi->xattr_isize + erofs_blkoff(map->m_la);
 		map->m_plen = inode->i_size - offset;
 
@@ -89,7 +89,7 @@ int erofs_map_blocks(struct erofs_inode *inode,
 		unit = EROFS_BLOCK_MAP_ENTRY_SIZE;	/* block map */
 
 	chunknr = map->m_la >> vi->u.chunkbits;
-	pos = roundup(iloc(vi->nid) + vi->inode_isize +
+	pos = roundup(erofs_iloc(vi) + vi->inode_isize +
 		      vi->xattr_isize, unit) + unit * chunknr;
 
 	err = blk_read(0, buf, erofs_blknr(pos), 1);
diff --git a/lib/namei.c b/lib/namei.c
index 3751741..423c1dd 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -28,7 +28,7 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 	char buf[sizeof(struct erofs_inode_extended)];
 	struct erofs_inode_compact *dic;
 	struct erofs_inode_extended *die;
-	const erofs_off_t inode_loc = iloc(vi->nid);
+	const erofs_off_t inode_loc = erofs_iloc(vi);
 
 	ret = dev_read(0, buf, inode_loc, sizeof(*dic));
 	if (ret < 0)
diff --git a/lib/xattr.c b/lib/xattr.c
index 87a95c7..9e83935 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -871,8 +871,8 @@ static int init_inode_xattrs(struct erofs_inode *vi)
 		return -ENOATTR;
 	}
 
-	it.blkaddr = erofs_blknr(iloc(vi->nid) + vi->inode_isize);
-	it.ofs = erofs_blkoff(iloc(vi->nid) + vi->inode_isize);
+	it.blkaddr = erofs_blknr(erofs_iloc(vi) + vi->inode_isize);
+	it.ofs = erofs_blkoff(erofs_iloc(vi) + vi->inode_isize);
 
 	ret = blk_read(0, it.page, it.blkaddr, 1);
 	if (ret < 0)
@@ -962,8 +962,8 @@ static int inline_xattr_iter_pre(struct xattr_iter *it,
 
 	inline_xattr_ofs = vi->inode_isize + xattr_header_sz;
 
-	it->blkaddr = erofs_blknr(iloc(vi->nid) + inline_xattr_ofs);
-	it->ofs = erofs_blkoff(iloc(vi->nid) + inline_xattr_ofs);
+	it->blkaddr = erofs_blknr(erofs_iloc(vi) + inline_xattr_ofs);
+	it->ofs = erofs_blkoff(erofs_iloc(vi) + inline_xattr_ofs);
 
 	ret = blk_read(0, it->page, it->blkaddr, 1);
 	if (ret < 0)
diff --git a/lib/zmap.c b/lib/zmap.c
index 209b5d7..7428d11 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -39,7 +39,7 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 	if (vi->flags & EROFS_I_Z_INITED)
 		return 0;
 
-	pos = round_up(iloc(vi->nid) + vi->inode_isize + vi->xattr_isize, 8);
+	pos = round_up(erofs_iloc(vi) + vi->inode_isize + vi->xattr_isize, 8);
 	ret = dev_read(0, buf, pos, sizeof(buf));
 	if (ret < 0)
 		return -EIO;
@@ -143,7 +143,7 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 					 unsigned long lcn)
 {
 	struct erofs_inode *const vi = m->inode;
-	const erofs_off_t ibase = iloc(vi->nid);
+	const erofs_off_t ibase = erofs_iloc(vi);
 	const erofs_off_t pos = Z_EROFS_FULL_INDEX_ALIGN(ibase +
 			vi->inode_isize + vi->xattr_isize) +
 		lcn * sizeof(struct z_erofs_lcluster_index);
@@ -342,7 +342,7 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 {
 	struct erofs_inode *const vi = m->inode;
 	const unsigned int lclusterbits = vi->z_logical_clusterbits;
-	const erofs_off_t ebase = round_up(iloc(vi->nid) + vi->inode_isize +
+	const erofs_off_t ebase = round_up(erofs_iloc(vi) + vi->inode_isize +
 					   vi->xattr_isize, 8) +
 		sizeof(struct z_erofs_map_header);
 	const unsigned int totalidx = BLK_ROUND_UP(vi->i_size);
-- 
2.19.1.6.gb485710b

