Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 901ED536FCE
	for <lists+linux-erofs@lfdr.de>; Sun, 29 May 2022 07:56:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L9npw3kH2z3bl2
	for <lists+linux-erofs@lfdr.de>; Sun, 29 May 2022 15:56:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NQ92FUYn;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NQ92FUYn;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4L9npp2tN8z2xXV
	for <linux-erofs@lists.ozlabs.org>; Sun, 29 May 2022 15:56:18 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 5299AB8074C;
	Sun, 29 May 2022 05:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14116C34119;
	Sun, 29 May 2022 05:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1653803773;
	bh=amPGy2cvxos9O4S7PoD7U4xa2f9tjDNJm/zivn/cku0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NQ92FUYnCmD99dRrN0EKMWexEBIDdoM2RzKUqBrzVC7pkS+Z6IVHakzShhwBLvEJ7
	 dVM7pOxPtGGwlaSQoWBbRf/L6P1vaj3i0DNBuipiXdzNBNRclzuckaJe6VD/g5CtEQ
	 YTenH9AVirxLCKZ/tlpmPo68ZgnZBJf66bhAHUjjvW+9lZ1NrA9BgQqfVoo5A4441X
	 DKpwrzhfhR2yYFRlhL/Ob/1dKb4tr1vHRXW5mAtXUXSXthNNEmiceP1pxfTu+nVVsw
	 oOyTJMGeOH8GsNRb0Hh63eLhQwPY1c//vpVdXX8xxW9fJsiRqF3IYw94mxp9637ACN
	 uwzUH/0o9+8iw==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 1/3] erofs: get rid of `struct z_erofs_collection'
Date: Sun, 29 May 2022 13:54:23 +0800
Message-Id: <20220529055425.226363-2-xiang@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220529055425.226363-1-xiang@kernel.org>
References: <20220529055425.226363-1-xiang@kernel.org>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@linux.alibaba.com>

It was incompletely introduced for deduplication between different
logical extents backed with the same pcluster.

We will have a better in-memory representation in the next release
cycle for this, as well as partial memory folios support. So get rid
of it instead.

No logic changes.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 111 ++++++++++++++++++-----------------------------
 fs/erofs/zdata.h |  50 ++++++++++-----------
 2 files changed, 65 insertions(+), 96 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index e6dea6dfca16..4fd66a66c5f9 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -199,7 +199,6 @@ struct z_erofs_decompress_frontend {
 	struct z_erofs_pagevec_ctor vector;
 
 	struct z_erofs_pcluster *pcl, *tailpcl;
-	struct z_erofs_collection *cl;
 	/* a pointer used to pick up inplace I/O pages */
 	struct page **icpage_ptr;
 	z_erofs_next_pcluster_t owned_head;
@@ -357,7 +356,7 @@ static bool z_erofs_try_inplace_io(struct z_erofs_decompress_frontend *fe,
 	return false;
 }
 
-/* callers must be with collection lock held */
+/* callers must be with pcluster lock held */
 static int z_erofs_attach_page(struct z_erofs_decompress_frontend *fe,
 			       struct page *page, enum z_erofs_page_type type,
 			       bool pvec_safereuse)
@@ -372,7 +371,7 @@ static int z_erofs_attach_page(struct z_erofs_decompress_frontend *fe,
 
 	ret = z_erofs_pagevec_enqueue(&fe->vector, page, type,
 				      pvec_safereuse);
-	fe->cl->vcnt += (unsigned int)ret;
+	fe->pcl->vcnt += (unsigned int)ret;
 	return ret ? 0 : -EAGAIN;
 }
 
@@ -405,12 +404,11 @@ static void z_erofs_try_to_claim_pcluster(struct z_erofs_decompress_frontend *f)
 	f->mode = COLLECT_PRIMARY;
 }
 
-static int z_erofs_lookup_collection(struct z_erofs_decompress_frontend *fe,
-				     struct inode *inode,
-				     struct erofs_map_blocks *map)
+static int z_erofs_lookup_pcluster(struct z_erofs_decompress_frontend *fe,
+				   struct inode *inode,
+				   struct erofs_map_blocks *map)
 {
 	struct z_erofs_pcluster *pcl = fe->pcl;
-	struct z_erofs_collection *cl;
 	unsigned int length;
 
 	/* to avoid unexpected loop formed by corrupted images */
@@ -419,8 +417,7 @@ static int z_erofs_lookup_collection(struct z_erofs_decompress_frontend *fe,
 		return -EFSCORRUPTED;
 	}
 
-	cl = z_erofs_primarycollection(pcl);
-	if (cl->pageofs != (map->m_la & ~PAGE_MASK)) {
+	if (pcl->pageofs_out != (map->m_la & ~PAGE_MASK)) {
 		DBG_BUGON(1);
 		return -EFSCORRUPTED;
 	}
@@ -443,23 +440,21 @@ static int z_erofs_lookup_collection(struct z_erofs_decompress_frontend *fe,
 			length = READ_ONCE(pcl->length);
 		}
 	}
-	mutex_lock(&cl->lock);
+	mutex_lock(&pcl->lock);
 	/* used to check tail merging loop due to corrupted images */
 	if (fe->owned_head == Z_EROFS_PCLUSTER_TAIL)
 		fe->tailpcl = pcl;
 
 	z_erofs_try_to_claim_pcluster(fe);
-	fe->cl = cl;
 	return 0;
 }
 
-static int z_erofs_register_collection(struct z_erofs_decompress_frontend *fe,
-				       struct inode *inode,
-				       struct erofs_map_blocks *map)
+static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe,
+				     struct inode *inode,
+				     struct erofs_map_blocks *map)
 {
 	bool ztailpacking = map->m_flags & EROFS_MAP_META;
 	struct z_erofs_pcluster *pcl;
-	struct z_erofs_collection *cl;
 	struct erofs_workgroup *grp;
 	int err;
 
@@ -482,17 +477,15 @@ static int z_erofs_register_collection(struct z_erofs_decompress_frontend *fe,
 
 	/* new pclusters should be claimed as type 1, primary and followed */
 	pcl->next = fe->owned_head;
+	pcl->pageofs_out = map->m_la & ~PAGE_MASK;
 	fe->mode = COLLECT_PRIMARY_FOLLOWED;
 
-	cl = z_erofs_primarycollection(pcl);
-	cl->pageofs = map->m_la & ~PAGE_MASK;
-
 	/*
 	 * lock all primary followed works before visible to others
 	 * and mutex_trylock *never* fails for a new pcluster.
 	 */
-	mutex_init(&cl->lock);
-	DBG_BUGON(!mutex_trylock(&cl->lock));
+	mutex_init(&pcl->lock);
+	DBG_BUGON(!mutex_trylock(&pcl->lock));
 
 	if (ztailpacking) {
 		pcl->obj.index = 0;	/* which indicates ztailpacking */
@@ -519,11 +512,10 @@ static int z_erofs_register_collection(struct z_erofs_decompress_frontend *fe,
 		fe->tailpcl = pcl;
 	fe->owned_head = &pcl->next;
 	fe->pcl = pcl;
-	fe->cl = cl;
 	return 0;
 
 err_out:
-	mutex_unlock(&cl->lock);
+	mutex_unlock(&pcl->lock);
 	z_erofs_free_pcluster(pcl);
 	return err;
 }
@@ -535,9 +527,9 @@ static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe,
 	struct erofs_workgroup *grp;
 	int ret;
 
-	DBG_BUGON(fe->cl);
+	DBG_BUGON(fe->pcl);
 
-	/* must be Z_EROFS_PCLUSTER_TAIL or pointed to previous collection */
+	/* must be Z_EROFS_PCLUSTER_TAIL or pointed to previous pcluster */
 	DBG_BUGON(fe->owned_head == Z_EROFS_PCLUSTER_NIL);
 	DBG_BUGON(fe->owned_head == Z_EROFS_PCLUSTER_TAIL_CLOSED);
 
@@ -554,14 +546,14 @@ static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe,
 		fe->pcl = container_of(grp, struct z_erofs_pcluster, obj);
 	} else {
 tailpacking:
-		ret = z_erofs_register_collection(fe, inode, map);
+		ret = z_erofs_register_pcluster(fe, inode, map);
 		if (!ret)
 			goto out;
 		if (ret != -EEXIST)
 			return ret;
 	}
 
-	ret = z_erofs_lookup_collection(fe, inode, map);
+	ret = z_erofs_lookup_pcluster(fe, inode, map);
 	if (ret) {
 		erofs_workgroup_put(&fe->pcl->obj);
 		return ret;
@@ -569,7 +561,7 @@ static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe,
 
 out:
 	z_erofs_pagevec_ctor_init(&fe->vector, Z_EROFS_NR_INLINE_PAGEVECS,
-				  fe->cl->pagevec, fe->cl->vcnt);
+				  fe->pcl->pagevec, fe->pcl->vcnt);
 	/* since file-backed online pages are traversed in reverse order */
 	fe->icpage_ptr = fe->pcl->compressed_pages +
 			z_erofs_pclusterpages(fe->pcl);
@@ -582,48 +574,36 @@ static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe,
  */
 static void z_erofs_rcu_callback(struct rcu_head *head)
 {
-	struct z_erofs_collection *const cl =
-		container_of(head, struct z_erofs_collection, rcu);
-
-	z_erofs_free_pcluster(container_of(cl, struct z_erofs_pcluster,
-					   primary_collection));
+	z_erofs_free_pcluster(container_of(head,
+			struct z_erofs_pcluster, rcu));
 }
 
 void erofs_workgroup_free_rcu(struct erofs_workgroup *grp)
 {
 	struct z_erofs_pcluster *const pcl =
 		container_of(grp, struct z_erofs_pcluster, obj);
-	struct z_erofs_collection *const cl = z_erofs_primarycollection(pcl);
 
-	call_rcu(&cl->rcu, z_erofs_rcu_callback);
-}
-
-static void z_erofs_collection_put(struct z_erofs_collection *cl)
-{
-	struct z_erofs_pcluster *const pcl =
-		container_of(cl, struct z_erofs_pcluster, primary_collection);
-
-	erofs_workgroup_put(&pcl->obj);
+	call_rcu(&pcl->rcu, z_erofs_rcu_callback);
 }
 
 static bool z_erofs_collector_end(struct z_erofs_decompress_frontend *fe)
 {
-	struct z_erofs_collection *cl = fe->cl;
+	struct z_erofs_pcluster *pcl = fe->pcl;
 
-	if (!cl)
+	if (!pcl)
 		return false;
 
 	z_erofs_pagevec_ctor_exit(&fe->vector, false);
-	mutex_unlock(&cl->lock);
+	mutex_unlock(&pcl->lock);
 
 	/*
 	 * if all pending pages are added, don't hold its reference
 	 * any longer if the pcluster isn't hosted by ourselves.
 	 */
 	if (fe->mode < COLLECT_PRIMARY_FOLLOWED_NOINPLACE)
-		z_erofs_collection_put(cl);
+		erofs_workgroup_put(&pcl->obj);
 
-	fe->cl = NULL;
+	fe->pcl = NULL;
 	return true;
 }
 
@@ -666,8 +646,8 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	/* lucky, within the range of the current map_blocks */
 	if (offset + cur >= map->m_la &&
 	    offset + cur < map->m_la + map->m_llen) {
-		/* didn't get a valid collection previously (very rare) */
-		if (!fe->cl)
+		/* didn't get a valid pcluster previously (very rare) */
+		if (!fe->pcl)
 			goto restart_now;
 		goto hitted;
 	}
@@ -766,7 +746,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	/* bump up the number of spiltted parts of a page */
 	++spiltted;
 	/* also update nr_pages */
-	fe->cl->nr_pages = max_t(pgoff_t, fe->cl->nr_pages, index + 1);
+	fe->pcl->nr_pages = max_t(pgoff_t, fe->pcl->nr_pages, index + 1);
 next_part:
 	/* can be used for verification */
 	map->m_llen = offset + cur - map->m_la;
@@ -821,15 +801,13 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 
 	enum z_erofs_page_type page_type;
 	bool overlapped, partial;
-	struct z_erofs_collection *cl;
 	int err;
 
 	might_sleep();
-	cl = z_erofs_primarycollection(pcl);
-	DBG_BUGON(!READ_ONCE(cl->nr_pages));
+	DBG_BUGON(!READ_ONCE(pcl->nr_pages));
 
-	mutex_lock(&cl->lock);
-	nr_pages = cl->nr_pages;
+	mutex_lock(&pcl->lock);
+	nr_pages = pcl->nr_pages;
 
 	if (nr_pages <= Z_EROFS_VMAP_ONSTACK_PAGES) {
 		pages = pages_onstack;
@@ -857,9 +835,9 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 
 	err = 0;
 	z_erofs_pagevec_ctor_init(&ctor, Z_EROFS_NR_INLINE_PAGEVECS,
-				  cl->pagevec, 0);
+				  pcl->pagevec, 0);
 
-	for (i = 0; i < cl->vcnt; ++i) {
+	for (i = 0; i < pcl->vcnt; ++i) {
 		unsigned int pagenr;
 
 		page = z_erofs_pagevec_dequeue(&ctor, &page_type);
@@ -945,11 +923,11 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 		goto out;
 
 	llen = pcl->length >> Z_EROFS_PCLUSTER_LENGTH_BIT;
-	if (nr_pages << PAGE_SHIFT >= cl->pageofs + llen) {
+	if (nr_pages << PAGE_SHIFT >= pcl->pageofs_out + llen) {
 		outputsize = llen;
 		partial = !(pcl->length & Z_EROFS_PCLUSTER_FULL_LENGTH);
 	} else {
-		outputsize = (nr_pages << PAGE_SHIFT) - cl->pageofs;
+		outputsize = (nr_pages << PAGE_SHIFT) - pcl->pageofs_out;
 		partial = true;
 	}
 
@@ -963,7 +941,7 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 					.in = compressed_pages,
 					.out = pages,
 					.pageofs_in = pcl->pageofs_in,
-					.pageofs_out = cl->pageofs,
+					.pageofs_out = pcl->pageofs_out,
 					.inputsize = inputsize,
 					.outputsize = outputsize,
 					.alg = pcl->algorithmformat,
@@ -1012,16 +990,12 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 	else if (pages != pages_onstack)
 		kvfree(pages);
 
-	cl->nr_pages = 0;
-	cl->vcnt = 0;
+	pcl->nr_pages = 0;
+	pcl->vcnt = 0;
 
-	/* all cl locks MUST be taken before the following line */
+	/* pcluster lock MUST be taken before the following line */
 	WRITE_ONCE(pcl->next, Z_EROFS_PCLUSTER_NIL);
-
-	/* all cl locks SHOULD be released right now */
-	mutex_unlock(&cl->lock);
-
-	z_erofs_collection_put(cl);
+	mutex_unlock(&pcl->lock);
 	return err;
 }
 
@@ -1043,6 +1017,7 @@ static void z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
 		owned = READ_ONCE(pcl->next);
 
 		z_erofs_decompress_pcluster(io->sb, pcl, pagepool);
+		erofs_workgroup_put(&pcl->obj);
 	}
 }
 
diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index 800b11c53f57..58053bb5066f 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -12,21 +12,40 @@
 #define Z_EROFS_PCLUSTER_MAX_PAGES	(Z_EROFS_PCLUSTER_MAX_SIZE / PAGE_SIZE)
 #define Z_EROFS_NR_INLINE_PAGEVECS      3
 
+#define Z_EROFS_PCLUSTER_FULL_LENGTH    0x00000001
+#define Z_EROFS_PCLUSTER_LENGTH_BIT     1
+
+/*
+ * let's leave a type here in case of introducing
+ * another tagged pointer later.
+ */
+typedef void *z_erofs_next_pcluster_t;
+
 /*
  * Structure fields follow one of the following exclusion rules.
  *
  * I: Modifiable by initialization/destruction paths and read-only
  *    for everyone else;
  *
- * L: Field should be protected by pageset lock;
+ * L: Field should be protected by the pcluster lock;
  *
  * A: Field should be accessed / updated in atomic for parallelized code.
  */
-struct z_erofs_collection {
+struct z_erofs_pcluster {
+	struct erofs_workgroup obj;
 	struct mutex lock;
 
+	/* A: point to next chained pcluster or TAILs */
+	z_erofs_next_pcluster_t next;
+
+	/* A: lower limit of decompressed length and if full length or not */
+	unsigned int length;
+
 	/* I: page offset of start position of decompression */
-	unsigned short pageofs;
+	unsigned short pageofs_out;
+
+	/* I: page offset of inline compressed data */
+	unsigned short pageofs_in;
 
 	/* L: maximum relative page index in pagevec[] */
 	unsigned short nr_pages;
@@ -41,29 +60,6 @@ struct z_erofs_collection {
 		/* I: can be used to free the pcluster by RCU. */
 		struct rcu_head rcu;
 	};
-};
-
-#define Z_EROFS_PCLUSTER_FULL_LENGTH    0x00000001
-#define Z_EROFS_PCLUSTER_LENGTH_BIT     1
-
-/*
- * let's leave a type here in case of introducing
- * another tagged pointer later.
- */
-typedef void *z_erofs_next_pcluster_t;
-
-struct z_erofs_pcluster {
-	struct erofs_workgroup obj;
-	struct z_erofs_collection primary_collection;
-
-	/* A: point to next chained pcluster or TAILs */
-	z_erofs_next_pcluster_t next;
-
-	/* A: lower limit of decompressed length and if full length or not */
-	unsigned int length;
-
-	/* I: page offset of inline compressed data */
-	unsigned short pageofs_in;
 
 	union {
 		/* I: physical cluster size in pages */
@@ -80,8 +76,6 @@ struct z_erofs_pcluster {
 	struct page *compressed_pages[];
 };
 
-#define z_erofs_primarycollection(pcluster) (&(pcluster)->primary_collection)
-
 /* let's avoid the valid 32-bit kernel addresses */
 
 /* the chained workgroup has't submitted io (still open) */
-- 
2.30.2

