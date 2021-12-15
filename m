Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E02475565
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Dec 2021 10:47:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JDVlS5Qrnz306m
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Dec 2021 20:47:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=yulong.com (client-ip=54.92.39.34; helo=smtpbgjp3.qq.com;
 envelope-from=huyue2@yulong.com; receiver=<UNKNOWN>)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JDVlK3YrHz304n
 for <linux-erofs@lists.ozlabs.org>; Wed, 15 Dec 2021 20:47:09 +1100 (AEDT)
X-QQ-mid: bizesmtp37t1639561538txwjvb3h
Received: from localhost.localdomain (unknown [49.65.247.231])
 by esmtp6.qq.com (ESMTP) with 
 id ; Wed, 15 Dec 2021 17:44:51 +0800 (CST)
X-QQ-SSF: 01400000002000Z0Z000B00D0000000
X-QQ-FEAT: eTtJes0duVvFFsCvBR0ucOSPT3u4dfhF8od96XbJvfQZP0rOoldEuS4keZzoB
 LFFRUSZySGTXGLfigUUIZRvFBTjlij6hAGsq3DDpWkvPPetfbDxXyMKUr3cEiOZxOwPYLvA
 ahanyCQpTjgA+mrd2je3364mB2FQnKmM8i+tI7y32ocqCASBmzzt5ztAC7VhWBXu/6hyjUi
 AWjbRls9TkY1ucxmnAvx2bORXYoqTBUhUvtICQ9eKuhrFYHEfDfNrMeqDIBvz5zmVP5Zyrp
 sHxQ5WmSjq/MGgcxfjgfsdt0rrbJq9TX5U80CwiNZ1YnpoKDhMNtC9syVnEHnPJRrRDQ0W5
 CegtHqArXi3lbdzyHDep7FSmm/F1LdG72GIXieSo7kJnseIABh2Rbdwe6ma+g==
X-QQ-GoodBg: 2
From: Yue Hu <huyue2@yulong.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v2] erofs: support tail-packing inline compressed data
Date: Wed, 15 Dec 2021 17:44:49 +0800
Message-Id: <20211215094449.15162-1-huyue2@yulong.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:yulong.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
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
Cc: geshifei@coolpad.com, linux-kernel@vger.kernel.org, zhangwen@coolpad.com,
 Yue Hu <huyue2@yulong.com>, shaojunjun@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Currently, we have already support tail-packing inline for
uncompressed file, let's also support it for compressed file to
decrease tail extent I/O and save more space.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
Changes in v2:
- rebase on latest v5.16-rc3+
- refer to fuse to update zmap.c
- move filling compressed meta page to preload_compressed_pages()
- pclusterlen -> inline_size and use it to indicate if inline
- code polish

 fs/erofs/compress.h     |   2 +-
 fs/erofs/decompressor.c |  34 ++++++-----
 fs/erofs/erofs_fs.h     |  10 +++-
 fs/erofs/internal.h     |   6 ++
 fs/erofs/super.c        |   3 +
 fs/erofs/zdata.c        |  70 +++++++++++++++++-----
 fs/erofs/zdata.h        |  11 ++++
 fs/erofs/zmap.c         | 127 ++++++++++++++++++++++++++++++----------
 8 files changed, 198 insertions(+), 65 deletions(-)

diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index 579406504919..9de40229be14 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -12,7 +12,7 @@ struct z_erofs_decompress_req {
 	struct super_block *sb;
 	struct page **in, **out;
 
-	unsigned short pageofs_out;
+	unsigned short pageofs_in, pageofs_out;
 	unsigned int inputsize, outputsize;
 
 	/* indicate the algorithm will be used for decompression */
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index c373a199c407..0fc05f52c331 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -186,19 +186,18 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_decompress_req *rq,
 				      u8 *out)
 {
 	unsigned int inputmargin;
-	u8 *headpage, *src;
+	u8 *headpage, *src, *in;
 	bool support_0padding;
 	int ret, maptype;
 
 	DBG_BUGON(*rq->in == NULL);
 	headpage = kmap_atomic(*rq->in);
 	inputmargin = 0;
-	support_0padding = false;
+	support_0padding = erofs_sb_has_zero_padding(EROFS_SB(rq->sb)) ? true :
+			   false;
 
 	/* decompression inplace is only safe when zero_padding is enabled */
-	if (erofs_sb_has_zero_padding(EROFS_SB(rq->sb))) {
-		support_0padding = true;
-
+	if (rq->inputsize >= PAGE_SIZE && support_0padding) {
 		while (!headpage[inputmargin & ~PAGE_MASK])
 			if (!(++inputmargin & ~PAGE_MASK))
 				break;
@@ -215,20 +214,22 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_decompress_req *rq,
 	if (IS_ERR(src))
 		return PTR_ERR(src);
 
+	in = src + rq->pageofs_in + inputmargin;
+
 	/* legacy format could compress extra data in a pcluster. */
 	if (rq->partial_decoding || !support_0padding)
-		ret = LZ4_decompress_safe_partial(src + inputmargin, out,
-				rq->inputsize, rq->outputsize, rq->outputsize);
+		ret = LZ4_decompress_safe_partial(in, out, rq->inputsize,
+						rq->outputsize, rq->outputsize);
 	else
-		ret = LZ4_decompress_safe(src + inputmargin, out,
-					  rq->inputsize, rq->outputsize);
+		ret = LZ4_decompress_safe(in, out, rq->inputsize,
+					  rq->outputsize);
 
 	if (ret != rq->outputsize) {
 		erofs_err(rq->sb, "failed to decompress %d in[%u, %u] out[%u]",
 			  ret, rq->inputsize, inputmargin, rq->outputsize);
 
 		print_hex_dump(KERN_DEBUG, "[ in]: ", DUMP_PREFIX_OFFSET,
-			       16, 1, src + inputmargin, rq->inputsize, true);
+			       16, 1, in, rq->inputsize, true);
 		print_hex_dump(KERN_DEBUG, "[out]: ", DUMP_PREFIX_OFFSET,
 			       16, 1, out, rq->outputsize, true);
 
@@ -299,7 +300,7 @@ static int z_erofs_shifted_transform(struct z_erofs_decompress_req *rq,
 {
 	const unsigned int nrpages_out =
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
-	const unsigned int righthalf = PAGE_SIZE - rq->pageofs_out;
+	unsigned int righthalf = PAGE_SIZE - rq->pageofs_out;
 	unsigned char *src, *dst;
 
 	if (nrpages_out > 2) {
@@ -312,20 +313,25 @@ static int z_erofs_shifted_transform(struct z_erofs_decompress_req *rq,
 		return 0;
 	}
 
+	if (nrpages_out == 1 && rq->outputsize < righthalf)
+		righthalf = rq->outputsize;
+
 	src = kmap_atomic(*rq->in);
 	if (rq->out[0]) {
 		dst = kmap_atomic(rq->out[0]);
-		memcpy(dst + rq->pageofs_out, src, righthalf);
+		memcpy(dst + rq->pageofs_out, src + rq->pageofs_in, righthalf);
 		kunmap_atomic(dst);
 	}
 
 	if (nrpages_out == 2) {
 		DBG_BUGON(!rq->out[1]);
 		if (rq->out[1] == *rq->in) {
-			memmove(src, src + righthalf, rq->pageofs_out);
+			memmove(src, src + rq->pageofs_in + righthalf,
+				rq->pageofs_out);
 		} else {
 			dst = kmap_atomic(rq->out[1]);
-			memcpy(dst, src + righthalf, rq->pageofs_out);
+			memcpy(dst, src + rq->pageofs_in + righthalf,
+			       rq->pageofs_out);
 			kunmap_atomic(dst);
 		}
 	}
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index dda79afb901d..ced574436ef5 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -23,13 +23,15 @@
 #define EROFS_FEATURE_INCOMPAT_CHUNKED_FILE	0x00000004
 #define EROFS_FEATURE_INCOMPAT_DEVICE_TABLE	0x00000008
 #define EROFS_FEATURE_INCOMPAT_COMPR_HEAD2	0x00000008
+#define EROFS_FEATURE_INCOMPAT_ZTAILPACKING	0x00000010
 #define EROFS_ALL_FEATURE_INCOMPAT		\
 	(EROFS_FEATURE_INCOMPAT_ZERO_PADDING | \
 	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
 	 EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER | \
 	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE | \
 	 EROFS_FEATURE_INCOMPAT_DEVICE_TABLE | \
-	 EROFS_FEATURE_INCOMPAT_COMPR_HEAD2)
+	 EROFS_FEATURE_INCOMPAT_COMPR_HEAD2 | \
+	 EROFS_FEATURE_INCOMPAT_ZTAILPACKING)
 
 #define EROFS_SB_EXTSLOT_SIZE	16
 
@@ -292,13 +294,17 @@ struct z_erofs_lzma_cfgs {
  *                                  (4B) + 2B + (4B) if compacted 2B is on.
  * bit 1 : HEAD1 big pcluster (0 - off; 1 - on)
  * bit 2 : HEAD2 big pcluster (0 - off; 1 - on)
+ * bit 3 : tailpacking inline pcluster (0 - off; 1 - on)
  */
 #define Z_EROFS_ADVISE_COMPACTED_2B		0x0001
 #define Z_EROFS_ADVISE_BIG_PCLUSTER_1		0x0002
 #define Z_EROFS_ADVISE_BIG_PCLUSTER_2		0x0004
+#define Z_EROFS_ADVISE_INLINE_PCLUSTER		0x0008
 
 struct z_erofs_map_header {
-	__le32	h_reserved1;
+	__le16	h_reserved1;
+	/* record the size of tailpacking data */
+	__le16  h_idata_size;
 	__le16	h_advise;
 	/*
 	 * bit 0-3 : algorithm type of head 1 (logical cluster type 01);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 8e70435629e5..83a51c7977be 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -274,6 +274,7 @@ EROFS_FEATURE_FUNCS(big_pcluster, incompat, INCOMPAT_BIG_PCLUSTER)
 EROFS_FEATURE_FUNCS(chunked_file, incompat, INCOMPAT_CHUNKED_FILE)
 EROFS_FEATURE_FUNCS(device_table, incompat, INCOMPAT_DEVICE_TABLE)
 EROFS_FEATURE_FUNCS(compr_head2, incompat, INCOMPAT_COMPR_HEAD2)
+EROFS_FEATURE_FUNCS(ztailpacking, incompat, INCOMPAT_ZTAILPACKING)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 
 /* atomic flag definitions */
@@ -308,6 +309,9 @@ struct erofs_inode {
 			unsigned short z_advise;
 			unsigned char  z_algorithmtype[2];
 			unsigned char  z_logical_clusterbits;
+			unsigned short z_idata_size;
+			unsigned long  z_idata_headlcn;
+			unsigned long  z_idataoff;
 		};
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	};
@@ -421,6 +425,8 @@ struct erofs_map_blocks {
 #define EROFS_GET_BLOCKS_FIEMAP	0x0002
 /* Used to map the whole extent if non-negligible data is requested for LZMA */
 #define EROFS_GET_BLOCKS_READMORE	0x0004
+/* Used to map tail extent for tailpacking inline pcluster */
+#define EROFS_GET_BLOCKS_FINDTAIL	0x0008
 
 enum {
 	Z_EROFS_COMPRESSION_SHIFTED = Z_EROFS_COMPRESSION_MAX,
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 58f381f80205..dbe48405bc64 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -411,6 +411,9 @@ static int erofs_read_superblock(struct super_block *sb)
 
 	/* handle multiple devices */
 	ret = erofs_init_devices(sb, dsb);
+
+	if (erofs_sb_has_ztailpacking(sbi))
+		erofs_info(sb, "EXPERIMENTAL compression inline data feature in use. Use at your own risk!");
 out:
 	kunmap(page);
 	put_page(page);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index bc765d8a6dc2..c3a196596e65 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -229,7 +229,8 @@ static DEFINE_MUTEX(z_pagemap_global_lock);
 static void preload_compressed_pages(struct z_erofs_collector *clt,
 				     struct address_space *mc,
 				     enum z_erofs_cache_alloctype type,
-				     struct page **pagepool)
+				     struct page **pagepool,
+				     struct page *mpage)
 {
 	struct z_erofs_pcluster *pcl = clt->pcl;
 	bool standalone = true;
@@ -243,6 +244,21 @@ static void preload_compressed_pages(struct z_erofs_collector *clt,
 
 	pages = pcl->compressed_pages;
 	index = pcl->obj.index;
+
+	if (z_erofs_pcluster_is_inline(pcl)) {
+		if (mpage->index != index) {
+			mpage = erofs_get_meta_page(mc->host->i_sb, index);
+			if (IS_ERR(mpage)) {
+				erofs_err(mc->host->i_sb,
+					  "failed to get meta page, err %ld",
+					  PTR_ERR(mpage));
+				return;
+			}
+		}
+		WRITE_ONCE(pcl->compressed_pages[0], mpage);
+		goto out;
+	}
+
 	for (; index < pcl->obj.index + pcl->pclusterpages; ++index, ++pages) {
 		struct page *page;
 		compressed_page_t t;
@@ -282,6 +298,7 @@ static void preload_compressed_pages(struct z_erofs_collector *clt,
 			erofs_pagepool_add(pagepool, newpage);
 	}
 
+out:
 	/*
 	 * don't do inplace I/O if all compressed pages are available in
 	 * managed cache since it can be moved to the bypass queue instead.
@@ -473,6 +490,8 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
 	if (IS_ERR(pcl))
 		return PTR_ERR(pcl);
 
+	pcl->inline_size = map->m_flags & EROFS_MAP_META ? map->m_plen : 0;
+
 	atomic_set(&pcl->obj.refcount, 1);
 	pcl->obj.index = map->m_pa >> PAGE_SHIFT;
 	pcl->algorithmformat = map->m_algorithmformat;
@@ -486,6 +505,8 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
 
 	cl = z_erofs_primarycollection(pcl);
 	cl->pageofs = map->m_la & ~PAGE_MASK;
+	cl->mpageofs = map->m_flags & EROFS_MAP_META ?
+		       map->m_pa & ~PAGE_MASK : 0;
 
 	/*
 	 * lock all primary followed works before visible to others
@@ -494,7 +515,10 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
 	mutex_init(&cl->lock);
 	DBG_BUGON(!mutex_trylock(&cl->lock));
 
-	grp = erofs_insert_workgroup(inode->i_sb, &pcl->obj);
+	grp = &pcl->obj;
+	if (!(map->m_flags & EROFS_MAP_META))
+		grp = erofs_insert_workgroup(inode->i_sb, &pcl->obj);
+
 	if (IS_ERR(grp)) {
 		err = PTR_ERR(grp);
 		goto err_out;
@@ -523,7 +547,7 @@ static int z_erofs_collector_begin(struct z_erofs_collector *clt,
 				   struct inode *inode,
 				   struct erofs_map_blocks *map)
 {
-	struct erofs_workgroup *grp;
+	struct erofs_workgroup *grp = NULL;
 	int ret;
 
 	DBG_BUGON(clt->cl);
@@ -532,12 +556,10 @@ static int z_erofs_collector_begin(struct z_erofs_collector *clt,
 	DBG_BUGON(clt->owned_head == Z_EROFS_PCLUSTER_NIL);
 	DBG_BUGON(clt->owned_head == Z_EROFS_PCLUSTER_TAIL_CLOSED);
 
-	if (!PAGE_ALIGNED(map->m_pa)) {
-		DBG_BUGON(1);
-		return -EINVAL;
-	}
+	if (!(map->m_flags & EROFS_MAP_META))
+		grp = erofs_find_workgroup(inode->i_sb,
+					   map->m_pa >> PAGE_SHIFT);
 
-	grp = erofs_find_workgroup(inode->i_sb, map->m_pa >> PAGE_SHIFT);
 	if (grp) {
 		clt->pcl = container_of(grp, struct z_erofs_pcluster, obj);
 	} else {
@@ -688,7 +710,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		cache_strategy = DONTALLOC;
 
 	preload_compressed_pages(clt, MNGD_MAPPING(sbi),
-				 cache_strategy, pagepool);
+				 cache_strategy, pagepool, map->mpage);
 
 hitted:
 	/*
@@ -978,11 +1000,14 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 		partial = true;
 	}
 
-	inputsize = pcl->pclusterpages * PAGE_SIZE;
+	inputsize = pcl->inline_size ? pcl->inline_size :
+		    pcl->pclusterpages * PAGE_SIZE;
+
 	err = z_erofs_decompress(&(struct z_erofs_decompress_req) {
 					.sb = sb,
 					.in = compressed_pages,
 					.out = pages,
+					.pageofs_in = cl->mpageofs,
 					.pageofs_out = cl->pageofs,
 					.inputsize = inputsize,
 					.outputsize = outputsize,
@@ -993,6 +1018,14 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 
 out:
 	/* must handle all compressed pages before ending pages */
+	if (z_erofs_pcluster_is_inline(pcl)) {
+		page = compressed_pages[0];
+
+		if (PageLocked(page))
+			unlock_page(page);
+		WRITE_ONCE(page, NULL);
+	}
+
 	for (i = 0; i < pcl->pclusterpages; ++i) {
 		page = compressed_pages[i];
 
@@ -1288,6 +1321,13 @@ static void z_erofs_submit_queue(struct super_block *sb,
 
 		pcl = container_of(owned_head, struct z_erofs_pcluster, next);
 
+		/* close the main owned chain at first */
+		owned_head = cmpxchg(&pcl->next, Z_EROFS_PCLUSTER_TAIL,
+				     Z_EROFS_PCLUSTER_TAIL_CLOSED);
+
+		if (z_erofs_pcluster_is_inline(pcl))
+			goto noio_submission;
+
 		/* no device id here, thus it will always succeed */
 		mdev = (struct erofs_map_dev) {
 			.m_pa = blknr_to_addr(pcl->obj.index),
@@ -1297,10 +1337,6 @@ static void z_erofs_submit_queue(struct super_block *sb,
 		cur = erofs_blknr(mdev.m_pa);
 		end = cur + pcl->pclusterpages;
 
-		/* close the main owned chain at first */
-		owned_head = cmpxchg(&pcl->next, Z_EROFS_PCLUSTER_TAIL,
-				     Z_EROFS_PCLUSTER_TAIL_CLOSED);
-
 		do {
 			struct page *page;
 
@@ -1339,10 +1375,12 @@ static void z_erofs_submit_queue(struct super_block *sb,
 			bypass = false;
 		} while (++cur < end);
 
-		if (!bypass)
+		if (!bypass) {
 			qtail[JQ_SUBMIT] = &pcl->next;
-		else
+		} else {
+noio_submission:
 			move_to_bypass_jobqueue(pcl, qtail, owned_head);
+		}
 	} while (owned_head != Z_EROFS_PCLUSTER_TAIL);
 
 	if (bio)
diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index 4a69515dea75..92219cc52527 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -28,6 +28,9 @@ struct z_erofs_collection {
 	/* I: page offset of start position of decompression */
 	unsigned short pageofs;
 
+	/* I: page offset of start position of compression for inline case */
+	unsigned short mpageofs;
+
 	/* L: maximum relative page index in pagevec[] */
 	unsigned short nr_pages;
 
@@ -65,6 +68,9 @@ struct z_erofs_pcluster {
 	/* I: physical cluster size in pages */
 	unsigned short pclusterpages;
 
+	/* I: tailpacking inline physical cluster size */
+	unsigned short inline_size;
+
 	/* I: compression algorithm format */
 	unsigned char algorithmformat;
 
@@ -174,6 +180,11 @@ static inline void z_erofs_onlinepage_endio(struct page *page)
 	erofs_dbg("%s, page %p value %x", __func__, page, atomic_read(u.o));
 }
 
+static inline bool z_erofs_pcluster_is_inline(struct z_erofs_pcluster *pcl)
+{
+	return !!pcl->inline_size;
+}
+
 #define Z_EROFS_VMAP_ONSTACK_PAGES	\
 	min_t(unsigned int, THREAD_SIZE / 8 / sizeof(struct page *), 96U)
 #define Z_EROFS_VMAP_GLOBAL_PAGES	2048
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 660489a7fb64..a5553903892f 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -7,12 +7,17 @@
 #include <asm/unaligned.h>
 #include <trace/events/erofs.h>
 
+static int z_erofs_do_map_blocks(struct inode *inode,
+				 struct erofs_map_blocks *map,
+				 int flags);
+
 int z_erofs_fill_inode(struct inode *inode)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
 	struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
 
 	if (!erofs_sb_has_big_pcluster(sbi) &&
+	    !erofs_sb_has_ztailpacking(sbi) &&
 	    vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY) {
 		vi->z_advise = 0;
 		vi->z_algorithmtype[0] = 0;
@@ -51,6 +56,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		goto out_unlock;
 
 	DBG_BUGON(!erofs_sb_has_big_pcluster(EROFS_SB(sb)) &&
+		  !erofs_sb_has_ztailpacking(EROFS_SB(sb)) &&
 		  vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY);
 
 	pos = ALIGN(iloc(EROFS_SB(sb), vi->nid) + vi->inode_isize +
@@ -65,6 +71,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 
 	h = kaddr + erofs_blkoff(pos);
 	vi->z_advise = le16_to_cpu(h->h_advise);
+	vi->z_idata_size = le16_to_cpu(h->h_idata_size);
 	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
 	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
 
@@ -94,13 +101,32 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		err = -EFSCORRUPTED;
 		goto unmap_done;
 	}
-	/* paired with smp_mb() at the beginning of the function */
-	smp_mb();
-	set_bit(EROFS_I_Z_INITED_BIT, &vi->flags);
 unmap_done:
 	kunmap_atomic(kaddr);
 	unlock_page(page);
 	put_page(page);
+	if (err)
+		goto out_unlock;
+
+	if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER) {
+		struct erofs_map_blocks map = { .m_la = inode->i_size - 1 };
+
+		if (!vi->z_idata_size || vi->z_idata_size > EROFS_BLKSIZ) {
+			erofs_err(sb, "invalid tail-packing pclustersize %u",
+				  vi->z_idata_size);
+			return -EFSCORRUPTED;
+		}
+		err = z_erofs_do_map_blocks(inode, &map,
+					    EROFS_GET_BLOCKS_FINDTAIL);
+		if (map.mpage)
+			put_page(map.mpage);
+		if (err < 0)
+			goto out_unlock;
+	}
+
+	/* paired with smp_mb() at the beginning of the function */
+	smp_mb();
+	set_bit(EROFS_I_Z_INITED_BIT, &vi->flags);
 out_unlock:
 	clear_and_wake_up_bit(EROFS_I_BL_Z_BIT, &vi->flags);
 	return err;
@@ -117,6 +143,7 @@ struct z_erofs_maprecorder {
 	u16 clusterofs;
 	u16 delta[2];
 	erofs_blk_t pblk, compressedlcs;
+	erofs_off_t nextpackoff;
 };
 
 static int z_erofs_reload_indexes(struct z_erofs_maprecorder *m,
@@ -169,6 +196,8 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	if (err)
 		return err;
 
+	m->nextpackoff = pos + sizeof(struct z_erofs_vle_decompressed_index);
+
 	m->lcn = lcn;
 	di = m->kaddr + erofs_blkoff(pos);
 
@@ -243,12 +272,12 @@ static int get_compacted_la_distance(unsigned int lclusterbits,
 
 static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 				  unsigned int amortizedshift,
-				  unsigned int eofs, bool lookahead)
+				  erofs_off_t pos, bool lookahead)
 {
 	struct erofs_inode *const vi = EROFS_I(m->inode);
 	const unsigned int lclusterbits = vi->z_logical_clusterbits;
 	const unsigned int lomask = (1 << lclusterbits) - 1;
-	unsigned int vcnt, base, lo, encodebits, nblk;
+	unsigned int vcnt, base, lo, encodebits, nblk, eofs;
 	int i;
 	u8 *in, type;
 	bool big_pcluster;
@@ -260,8 +289,12 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	else
 		return -EOPNOTSUPP;
 
+	m->nextpackoff = rounddown(pos, vcnt << amortizedshift) +
+			 (vcnt << amortizedshift);
+
 	big_pcluster = vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1;
 	encodebits = ((vcnt << amortizedshift) - sizeof(__le32)) * 8 / vcnt;
+	eofs = erofs_blkoff(pos);
 	base = round_down(eofs, vcnt << amortizedshift);
 	in = m->kaddr + base;
 
@@ -305,7 +338,7 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	}
 	m->clusterofs = lo;
 	m->delta[0] = 0;
-	/* figout out blkaddr (pblk) for HEAD lclusters */
+	/* figure out blkaddr (pblk) for HEAD lclusters */
 	if (!big_pcluster) {
 		nblk = 1;
 		while (i > 0) {
@@ -373,8 +406,10 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	if (compacted_4b_initial == 32 / 4)
 		compacted_4b_initial = 0;
 
-	if ((vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B) &&
-	    compacted_4b_initial < totalidx)
+	if (compacted_4b_initial > totalidx)
+		compacted_4b_initial = compacted_2b = 0;
+	else if ((vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B) &&
+		 compacted_4b_initial < totalidx)
 		compacted_2b = rounddown(totalidx - compacted_4b_initial, 16);
 	else
 		compacted_2b = 0;
@@ -399,8 +434,7 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	err = z_erofs_reload_indexes(m, erofs_blknr(pos));
 	if (err)
 		return err;
-	return unpack_compacted_index(m, amortizedshift, erofs_blkoff(pos),
-				      lookahead);
+	return unpack_compacted_index(m, amortizedshift, pos, lookahead);
 }
 
 static int z_erofs_load_cluster_from_disk(struct z_erofs_maprecorder *m,
@@ -583,9 +617,9 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 	return 0;
 }
 
-int z_erofs_map_blocks_iter(struct inode *inode,
-			    struct erofs_map_blocks *map,
-			    int flags)
+static int z_erofs_do_map_blocks(struct inode *inode,
+				 struct erofs_map_blocks *map,
+				 int flags)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
 	struct z_erofs_maprecorder m = {
@@ -597,20 +631,6 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 	unsigned long initial_lcn;
 	unsigned long long ofs, end;
 
-	trace_z_erofs_map_blocks_iter_enter(inode, map, flags);
-
-	/* when trying to read beyond EOF, leave it unmapped */
-	if (map->m_la >= inode->i_size) {
-		map->m_llen = map->m_la + 1 - inode->i_size;
-		map->m_la = inode->i_size;
-		map->m_flags = 0;
-		goto out;
-	}
-
-	err = z_erofs_fill_inode_lazy(inode);
-	if (err)
-		goto out;
-
 	lclusterbits = vi->z_logical_clusterbits;
 	ofs = map->m_la;
 	initial_lcn = ofs >> lclusterbits;
@@ -620,6 +640,9 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 	if (err)
 		goto unmap_out;
 
+	if (flags & EROFS_GET_BLOCKS_FINDTAIL)
+		vi->z_idataoff = m.nextpackoff;
+
 	map->m_flags = EROFS_MAP_MAPPED | EROFS_MAP_ENCODED;
 	end = (m.lcn + 1ULL) << lclusterbits;
 
@@ -630,6 +653,8 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 		if (endoff >= m.clusterofs) {
 			m.headtype = m.type;
 			map->m_la = (m.lcn << lclusterbits) | m.clusterofs;
+			if (end > inode->i_size)
+				end = inode->i_size;
 			break;
 		}
 		/* m.lcn should be >= 1 if endoff < m.clusterofs */
@@ -658,12 +683,25 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 		goto unmap_out;
 	}
 
+	if (flags & EROFS_GET_BLOCKS_FINDTAIL) {
+		vi->z_idata_headlcn = m.lcn;
+		goto unmap_out;
+	}
+
 	map->m_llen = end - map->m_la;
-	map->m_pa = blknr_to_addr(m.pblk);
 
-	err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
-	if (err)
-		goto out;
+	if ((vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER) &&
+	    (m.lcn == vi->z_idata_headlcn)) {
+		map->m_flags |= EROFS_MAP_META;
+		map->m_pa = vi->z_idataoff;
+		map->m_plen = vi->z_idata_size;
+	} else {
+		map->m_pa = blknr_to_addr(m.pblk);
+
+		err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
+		if (err)
+			goto out;
+	}
 
 	if (m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN)
 		map->m_algorithmformat = Z_EROFS_COMPRESSION_SHIFTED;
@@ -689,9 +727,34 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 		  __func__, map->m_la, map->m_pa,
 		  map->m_llen, map->m_plen, map->m_flags);
 
+	return err;
+}
+
+int z_erofs_map_blocks_iter(struct inode *inode,
+			    struct erofs_map_blocks *map,
+			    int flags)
+{
+	int err = 0;
+
+	trace_z_erofs_map_blocks_iter_enter(inode, map, flags);
+
+	/* when trying to read beyond EOF, leave it unmapped */
+	if (map->m_la >= inode->i_size) {
+		map->m_llen = map->m_la + 1 - inode->i_size;
+		map->m_la = inode->i_size;
+		map->m_flags = 0;
+		goto out;
+	}
+
+	err = z_erofs_fill_inode_lazy(inode);
+	if (err)
+		goto out;
+
+	err = z_erofs_do_map_blocks(inode, map, flags);
+out:
 	trace_z_erofs_map_blocks_iter_exit(inode, map, flags, err);
 
-	/* aggressively BUG_ON iff CONFIG_EROFS_FS_DEBUG is on */
+	/* aggressively BUG_ON if CONFIG_EROFS_FS_DEBUG is on */
 	DBG_BUGON(err < 0 && err != -ENOMEM);
 	return err;
 }
-- 
2.17.1



