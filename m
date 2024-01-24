Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A68CB83A006
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jan 2024 04:20:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TKTj963dDz3bv3
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jan 2024 14:19:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TKTj60LXfz2ykt
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Jan 2024 14:19:51 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W.EiNDX_1706066385;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W.EiNDX_1706066385)
          by smtp.aliyun-inc.com;
          Wed, 24 Jan 2024 11:19:45 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: get rid of unneeded GFP_NOFS
Date: Wed, 24 Jan 2024 11:19:45 +0800
Message-Id: <20240124031945.130782-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
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
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Clean up some leftovers since there is no way for EROFS to be called
again from a reclaim context.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c | 2 +-
 fs/erofs/inode.c   | 2 +-
 fs/erofs/utils.c   | 2 +-
 fs/erofs/zdata.c   | 8 ++++----
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index bc12030393b2..5ff90026fd43 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -459,7 +459,7 @@ static struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb
 
 	inode->i_size = OFFSET_MAX;
 	inode->i_mapping->a_ops = &erofs_fscache_meta_aops;
-	mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
+	mapping_set_gfp_mask(inode->i_mapping, GFP_KERNEL);
 	inode->i_blkbits = EROFS_SB(sb)->blkszbits;
 	inode->i_private = ctx;
 
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 3d616dea55dc..36e638e8b53a 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -60,7 +60,7 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 		} else {
 			const unsigned int gotten = sb->s_blocksize - *ofs;
 
-			copied = kmalloc(vi->inode_isize, GFP_NOFS);
+			copied = kmalloc(vi->inode_isize, GFP_KERNEL);
 			if (!copied) {
 				err = -ENOMEM;
 				goto err_out;
diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index 5dea308764b4..e146d09151af 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -81,7 +81,7 @@ struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
 repeat:
 	xa_lock(&sbi->managed_pslots);
 	pre = __xa_cmpxchg(&sbi->managed_pslots, grp->index,
-			   NULL, grp, GFP_NOFS);
+			   NULL, grp, GFP_KERNEL);
 	if (pre) {
 		if (xa_is_err(pre)) {
 			pre = ERR_PTR(xa_err(pre));
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 692c0c39be63..583c062cd0e4 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -230,7 +230,7 @@ static int z_erofs_bvec_enqueue(struct z_erofs_bvec_iter *iter,
 		struct page *nextpage = *candidate_bvpage;
 
 		if (!nextpage) {
-			nextpage = erofs_allocpage(pagepool, GFP_NOFS);
+			nextpage = erofs_allocpage(pagepool, GFP_KERNEL);
 			if (!nextpage)
 				return -ENOMEM;
 			set_page_private(nextpage, Z_EROFS_SHORTLIVED_PAGE);
@@ -302,7 +302,7 @@ static struct z_erofs_pcluster *z_erofs_alloc_pcluster(unsigned int size)
 		if (nrpages > pcs->maxpages)
 			continue;
 
-		pcl = kmem_cache_zalloc(pcs->slab, GFP_NOFS);
+		pcl = kmem_cache_zalloc(pcs->slab, GFP_KERNEL);
 		if (!pcl)
 			return ERR_PTR(-ENOMEM);
 		pcl->pclustersize = size;
@@ -694,7 +694,7 @@ static void z_erofs_cache_invalidate_folio(struct folio *folio,
 	DBG_BUGON(stop > folio_size(folio) || stop < length);
 
 	if (offset == 0 && stop == folio_size(folio))
-		while (!z_erofs_cache_release_folio(folio, GFP_NOFS))
+		while (!z_erofs_cache_release_folio(folio, 0))
 			cond_resched();
 }
 
@@ -713,7 +713,7 @@ int erofs_init_managed_cache(struct super_block *sb)
 	set_nlink(inode, 1);
 	inode->i_size = OFFSET_MAX;
 	inode->i_mapping->a_ops = &z_erofs_cache_aops;
-	mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
+	mapping_set_gfp_mask(inode->i_mapping, GFP_KERNEL);
 	EROFS_SB(sb)->managed_cache = inode;
 	return 0;
 }
-- 
2.19.1.6.gb485710b

