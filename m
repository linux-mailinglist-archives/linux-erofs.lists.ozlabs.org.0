Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04336454396
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Nov 2021 10:26:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HvHcK4qw1z2yYl
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Nov 2021 20:26:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1637141185;
	bh=J6wc62kMFbJbfe/xI0qldjwynQJfQK2UalIpBtLAw58=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=Obdet7tUSccqweGbRMoS6eE1dtwewSmKM085bB0IKIgXbwiCJor4SsML2q9Iv6Apb
	 pnuK4gFkWUDanbVgisfUJBhRfX9Vn5FFUB06TjdIfqJwpVo88sJwuSQ2AyTo9Wz8O5
	 w/w9u56+tw743QrKHMqWNrD6+iEcjx2WiMZRNWKRm/bRIJI+wQMS+rVXXjhj3z7T4A
	 qax2TjH0Z8YwyBKRY3MqQb+qnK/XnzUwll2rt6ci5NWlMHeG9DSSKIRNHl9nL6TM5M
	 4irNrtA/6cRxpOKGDAaAVl92PYfiIQtUxcksf+Tb09UirlSHRPYiLKtVOv7tF3sG5o
	 lK08+kF8adE5g==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=yulong.com (client-ip=54.92.39.34; helo=smtpbgjp3.qq.com;
 envelope-from=huyue2@yulong.com; receiver=<UNKNOWN>)
X-Greylist: delayed 204 seconds by postgrey-1.36 at boromir;
 Wed, 17 Nov 2021 20:26:13 AEDT
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HvHc514JDz2yMc
 for <linux-erofs@lists.ozlabs.org>; Wed, 17 Nov 2021 20:26:12 +1100 (AEDT)
X-QQ-mid: bizesmtp38t1637141165to8g19by
Received: from localhost.localdomain (unknown [218.94.48.178])
 by esmtp6.qq.com (ESMTP) with 
 id ; Wed, 17 Nov 2021 17:25:56 +0800 (CST)
X-QQ-SSF: 01400000002000Z0Z000B00C0000000
X-QQ-FEAT: rCzLTtzQ0gc0joTxO+ZrPffdBJ1i4PbHag3N+S5X/pt8tLanYUGDI3E/kUSlR
 i9AfO/A0Ve7JR8S6XKalJNeQRub2pX6v3KbtjBct1TzsnC4QIUeBHf+1M6F8rTCE0ETDRIi
 xATxDtalmEbAbGXpPaMHASV8cSsJFECp77FUJ49cBZPSOFVwGfSncAEwuCQ+cFjdze71B5T
 cRfyhcKC6afoxaTkOe/x1miOzOW2klGjbfGcgbq82Fn8EsfOZ6RCuYuYVx2UA0ByHqX/Hfd
 XVOhxhLzdAYgvyBy+aAg3xrm0srtKBbdt56e6l4qbJ6HfTJFUzye9NfsauTD2gP6JgAfxAd
 Me3C/PQZd0+DicYESwU0zpElOc6cq00oQjwmQfE7IQsxDP4Ix8=
X-QQ-GoodBg: 2
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH] erofs: support tail-packing inline compressed data
Date: Wed, 17 Nov 2021 17:25:54 +0800
Message-Id: <20211117092554.28515-1-huyue2@yulong.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:yulong.com:qybgforeign:qybgforeign2
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
From: Yue Hu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Yue Hu <huyue2@yulong.com>
Cc: linux-kernel@vger.kernel.org, shaojunjun@yulong.com,
 Yue Hu <huyue2@yulong.com>, zhangwen@yulong.com, geshifei@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Currently, we have already support tail-packing inline for uncompressed
file, let's also support it for compressed file to decrease tail extent
I/O and save more space.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 fs/erofs/compress.h     |   2 +-
 fs/erofs/decompressor.c |  29 ++++---
 fs/erofs/erofs_fs.h     |  10 ++-
 fs/erofs/internal.h     |   3 +
 fs/erofs/super.c        |   3 +
 fs/erofs/zdata.c        |  76 +++++++++++++++----
 fs/erofs/zdata.h        |   7 +-
 fs/erofs/zmap.c         | 164 ++++++++++++++++++++++++++++++++++------
 8 files changed, 238 insertions(+), 56 deletions(-)

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
index bf37fc76b182..9ce4b2d23e29 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -186,7 +186,7 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_decompress_req *rq,
 				      u8 *out)
 {
 	unsigned int inputmargin;
-	u8 *headpage, *src;
+	u8 *headpage, *src, *in;
 	bool support_0padding;
 	int ret, maptype;
 
@@ -196,7 +196,7 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_decompress_req *rq,
 	support_0padding = false;
 
 	/* decompression inplace is only safe when 0padding is enabled */
-	if (erofs_sb_has_lz4_0padding(EROFS_SB(rq->sb))) {
+	if (!rq->pageofs_in && erofs_sb_has_lz4_0padding(EROFS_SB(rq->sb))) {
 		support_0padding = true;
 
 		while (!headpage[inputmargin & ~PAGE_MASK])
@@ -215,20 +215,22 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_decompress_req *rq,
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
 
@@ -299,7 +301,7 @@ static int z_erofs_shifted_transform(struct z_erofs_decompress_req *rq,
 {
 	const unsigned int nrpages_out =
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
-	const unsigned int righthalf = PAGE_SIZE - rq->pageofs_out;
+	unsigned int righthalf = PAGE_SIZE - rq->pageofs_out;
 	unsigned char *src, *dst;
 
 	if (nrpages_out > 2) {
@@ -312,20 +314,25 @@ static int z_erofs_shifted_transform(struct z_erofs_decompress_req *rq,
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
index 083997a034e5..19153cd6f5e8 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -23,13 +23,15 @@
 #define EROFS_FEATURE_INCOMPAT_CHUNKED_FILE	0x00000004
 #define EROFS_FEATURE_INCOMPAT_DEVICE_TABLE	0x00000008
 #define EROFS_FEATURE_INCOMPAT_COMPR_HEAD2	0x00000008
+#define EROFS_FEATURE_INCOMPAT_TAIL_PACKING	0x00000010
 #define EROFS_ALL_FEATURE_INCOMPAT		\
 	(EROFS_FEATURE_INCOMPAT_LZ4_0PADDING | \
 	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
 	 EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER | \
 	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE | \
 	 EROFS_FEATURE_INCOMPAT_DEVICE_TABLE | \
-	 EROFS_FEATURE_INCOMPAT_COMPR_HEAD2)
+	 EROFS_FEATURE_INCOMPAT_COMPR_HEAD2 | \
+	 EROFS_FEATURE_INCOMPAT_TAIL_PACKING)
 
 #define EROFS_SB_EXTSLOT_SIZE	16
 
@@ -292,13 +294,17 @@ struct z_erofs_lzma_cfgs {
  *                                  (4B) + 2B + (4B) if compacted 2B is on.
  * bit 1 : HEAD1 big pcluster (0 - off; 1 - on)
  * bit 2 : HEAD2 big pcluster (0 - off; 1 - on)
+ * bit 3 : tail-packing inline data
  */
 #define Z_EROFS_ADVISE_COMPACTED_2B		0x0001
 #define Z_EROFS_ADVISE_BIG_PCLUSTER_1		0x0002
 #define Z_EROFS_ADVISE_BIG_PCLUSTER_2		0x0004
+#define Z_EROFS_ADVISE_INLINE_DATA		0x0008
 
 struct z_erofs_map_header {
-	__le32	h_reserved1;
+	__le16	h_reserved1;
+	/* record the size of tail-packing pcluster */
+	__le16  h_idata_size;
 	__le16	h_advise;
 	/*
 	 * bit 0-3 : algorithm type of head 1 (logical cluster type 01);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 3265688af7f9..9ab3d38c7919 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -262,6 +262,7 @@ EROFS_FEATURE_FUNCS(lz4_0padding, incompat, INCOMPAT_LZ4_0PADDING)
 EROFS_FEATURE_FUNCS(compr_cfgs, incompat, INCOMPAT_COMPR_CFGS)
 EROFS_FEATURE_FUNCS(big_pcluster, incompat, INCOMPAT_BIG_PCLUSTER)
 EROFS_FEATURE_FUNCS(device_table, incompat, INCOMPAT_DEVICE_TABLE)
+EROFS_FEATURE_FUNCS(tail_packing, incompat, INCOMPAT_TAIL_PACKING)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 
 /* atomic flag definitions */
@@ -296,6 +297,8 @@ struct erofs_inode {
 			unsigned short z_advise;
 			unsigned char  z_algorithmtype[2];
 			unsigned char  z_logical_clusterbits;
+			unsigned short z_idata_size;
+			unsigned long  z_idata_headlcn;
 		};
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	};
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 6a969b1e0ee6..6f8bb83795a1 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -411,6 +411,9 @@ static int erofs_read_superblock(struct super_block *sb)
 
 	/* handle multiple devices */
 	ret = erofs_init_devices(sb, dsb);
+
+	if (erofs_sb_has_tail_packing(sbi))
+		erofs_info(sb, "EXPERIMENTAL compression inline data feature in use. Use at your own risk!");
 out:
 	kunmap(page);
 	put_page(page);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index bcb1b91b234f..85c46170598d 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -432,7 +432,7 @@ static int z_erofs_lookup_collection(struct z_erofs_collector *clt,
 	}
 
 	cl = z_erofs_primarycollection(pcl);
-	if (cl->pageofs != (map->m_la & ~PAGE_MASK)) {
+	if (cl->pageofs_out != (map->m_la & ~PAGE_MASK)) {
 		DBG_BUGON(1);
 		return -EFSCORRUPTED;
 	}
@@ -472,6 +472,7 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
 	struct z_erofs_pcluster *pcl;
 	struct z_erofs_collection *cl;
 	struct erofs_workgroup *grp;
+	unsigned int nrpages;
 	int err;
 
 	if (!(map->m_flags & EROFS_MAP_ENCODED)) {
@@ -479,13 +480,23 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
 		return -EFSCORRUPTED;
 	}
 
+	if (map->m_plen < EROFS_BLKSIZ && !(map->m_flags & EROFS_MAP_META))
+		nrpages = 1;
+	else
+		nrpages = map->m_plen >> PAGE_SHIFT;
+
 	/* no available pcluster, let's allocate one */
-	pcl = z_erofs_alloc_pcluster(map->m_plen >> PAGE_SHIFT);
+	pcl = z_erofs_alloc_pcluster(nrpages);
 	if (IS_ERR(pcl))
 		return PTR_ERR(pcl);
 
-	atomic_set(&pcl->obj.refcount, 1);
-	pcl->obj.index = map->m_pa >> PAGE_SHIFT;
+	pcl->pclusterlen = map->m_plen < EROFS_BLKSIZ ? map->m_plen : 0;
+
+	if (!(map->m_flags & EROFS_MAP_META)) {
+		atomic_set(&pcl->obj.refcount, 1);
+		pcl->obj.index = map->m_pa >> PAGE_SHIFT;
+	}
+
 	pcl->algorithmformat = map->m_algorithmformat;
 	pcl->length = (map->m_llen << Z_EROFS_PCLUSTER_LENGTH_BIT) |
 		(map->m_flags & EROFS_MAP_FULL_MAPPED ?
@@ -496,7 +507,16 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
 	clt->mode = COLLECT_PRIMARY_FOLLOWED;
 
 	cl = z_erofs_primarycollection(pcl);
-	cl->pageofs = map->m_la & ~PAGE_MASK;
+	cl->pageofs_out = map->m_la & ~PAGE_MASK;
+	cl->pageofs_in = 0;
+
+	/* no inplace I/O if inline and fill compressed page first */
+	if (map->m_flags & EROFS_MAP_META) {
+		cl->pageofs_in = map->m_pa & ~PAGE_MASK;
+
+		clt->mode = COLLECT_PRIMARY_FOLLOWED_NOINPLACE;
+		WRITE_ONCE(pcl->compressed_pages[0], map->mpage);
+	}
 
 	/*
 	 * lock all primary followed works before visible to others
@@ -505,6 +525,9 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
 	mutex_init(&cl->lock);
 	DBG_BUGON(!mutex_trylock(&cl->lock));
 
+	if (map->m_flags & EROFS_MAP_META)
+		goto skip_workgroup;
+
 	grp = erofs_insert_workgroup(inode->i_sb, &pcl->obj);
 	if (IS_ERR(grp)) {
 		err = PTR_ERR(grp);
@@ -516,6 +539,8 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
 		err = -EEXIST;
 		goto err_out;
 	}
+
+skip_workgroup:
 	/* used to check tail merging loop due to corrupted images */
 	if (clt->owned_head == Z_EROFS_PCLUSTER_TAIL)
 		clt->tailpcl = pcl;
@@ -543,6 +568,9 @@ static int z_erofs_collector_begin(struct z_erofs_collector *clt,
 	DBG_BUGON(clt->owned_head == Z_EROFS_PCLUSTER_NIL);
 	DBG_BUGON(clt->owned_head == Z_EROFS_PCLUSTER_TAIL_CLOSED);
 
+	if (map->m_flags & EROFS_MAP_META)
+		goto collection;
+
 	if (!PAGE_ALIGNED(map->m_pa)) {
 		DBG_BUGON(1);
 		return -EINVAL;
@@ -552,6 +580,7 @@ static int z_erofs_collector_begin(struct z_erofs_collector *clt,
 	if (grp) {
 		clt->pcl = container_of(grp, struct z_erofs_pcluster, obj);
 	} else {
+collection:
 		ret = z_erofs_register_collection(clt, inode, map);
 
 		if (!ret)
@@ -692,6 +721,9 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	if (err)
 		goto err_out;
 
+	if (map->m_flags & EROFS_MAP_META)
+		goto hitted;
+
 	/* preload all compressed pages (maybe downgrade role if necessary) */
 	if (should_alloc_managed_pages(fe, sbi->opt.cache_strategy, map->m_la))
 		cache_strategy = TRYALLOC;
@@ -832,6 +864,13 @@ static void z_erofs_decompressqueue_endio(struct bio *bio)
 	bio_put(bio);
 }
 
+static inline bool z_erofs_pcluster_is_inline(struct z_erofs_pcluster *pcl)
+{
+	struct z_erofs_collection *cl = z_erofs_primarycollection(pcl);
+
+	return !!cl->pageofs_in;
+}
+
 static int z_erofs_decompress_pcluster(struct super_block *sb,
 				       struct z_erofs_pcluster *pcl,
 				       struct page **pagepool)
@@ -963,20 +1002,22 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 		goto out;
 
 	llen = pcl->length >> Z_EROFS_PCLUSTER_LENGTH_BIT;
-	if (nr_pages << PAGE_SHIFT >= cl->pageofs + llen) {
+	if (nr_pages << PAGE_SHIFT >= cl->pageofs_out + llen) {
 		outputsize = llen;
 		partial = !(pcl->length & Z_EROFS_PCLUSTER_FULL_LENGTH);
 	} else {
-		outputsize = (nr_pages << PAGE_SHIFT) - cl->pageofs;
+		outputsize = (nr_pages << PAGE_SHIFT) - cl->pageofs_out;
 		partial = true;
 	}
 
-	inputsize = pcl->pclusterpages * PAGE_SIZE;
+	inputsize = pcl->pclusterlen ? pcl->pclusterlen :
+		    pcl->pclusterpages * PAGE_SIZE;
 	err = z_erofs_decompress(&(struct z_erofs_decompress_req) {
 					.sb = sb,
 					.in = compressed_pages,
 					.out = pages,
-					.pageofs_out = cl->pageofs,
+					.pageofs_in = cl->pageofs_in,
+					.pageofs_out = cl->pageofs_out,
 					.inputsize = inputsize,
 					.outputsize = outputsize,
 					.alg = pcl->algorithmformat,
@@ -1290,6 +1331,13 @@ static void z_erofs_submit_queue(struct super_block *sb,
 
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
@@ -1299,10 +1347,6 @@ static void z_erofs_submit_queue(struct super_block *sb,
 		cur = erofs_blknr(mdev.m_pa);
 		end = cur + pcl->pclusterpages;
 
-		/* close the main owned chain at first */
-		owned_head = cmpxchg(&pcl->next, Z_EROFS_PCLUSTER_TAIL,
-				     Z_EROFS_PCLUSTER_TAIL_CLOSED);
-
 		do {
 			struct page *page;
 
@@ -1341,10 +1385,12 @@ static void z_erofs_submit_queue(struct super_block *sb,
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
index 879df5362777..cc724c51eda8 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -25,8 +25,8 @@
 struct z_erofs_collection {
 	struct mutex lock;
 
-	/* I: page offset of start position of decompression */
-	unsigned short pageofs;
+	/* I: page offset of start position of (de)compression */
+	unsigned short pageofs_in, pageofs_out;
 
 	/* L: maximum relative page index in pagevec[] */
 	unsigned short nr_pages;
@@ -62,6 +62,9 @@ struct z_erofs_pcluster {
 	/* A: lower limit of decompressed length and if full length or not */
 	unsigned int length;
 
+	/* I: tail-packing physical cluster length */
+	unsigned short pclusterlen;
+
 	/* I: physical cluster size in pages */
 	unsigned short pclusterpages;
 
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 660489a7fb64..e62b81c94865 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -7,6 +7,10 @@
 #include <asm/unaligned.h>
 #include <trace/events/erofs.h>
 
+static int z_erofs_do_map_blocks(struct inode *inode,
+				 struct erofs_map_blocks *map,
+				 int flags);
+
 int z_erofs_fill_inode(struct inode *inode)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
@@ -18,12 +22,74 @@ int z_erofs_fill_inode(struct inode *inode)
 		vi->z_algorithmtype[0] = 0;
 		vi->z_algorithmtype[1] = 0;
 		vi->z_logical_clusterbits = LOG_BLOCK_SIZE;
+		vi->z_idata_size = 0;
 		set_bit(EROFS_I_Z_INITED_BIT, &vi->flags);
+
+		DBG_BUGON(erofs_sb_has_tail_packing(sbi));
 	}
 	inode->i_mapping->a_ops = &z_erofs_aops;
 	return 0;
 }
 
+static erofs_off_t compacted_inline_data_addr(struct erofs_inode *vi,
+					      erofs_off_t i_off,
+					      unsigned int totalidx)
+{
+	const erofs_off_t ebase = ALIGN(i_off + vi->inode_isize +
+					vi->xattr_isize, 8) +
+				  sizeof(struct z_erofs_map_header);
+	unsigned int compacted_4b_initial, compacted_4b_end;
+	unsigned int compacted_2b;
+	erofs_off_t addr;
+
+	compacted_4b_initial = (32 - ebase % 32) / 4;
+	if (compacted_4b_initial == 32 / 4)
+		compacted_4b_initial = 0;
+
+	if (compacted_4b_initial > totalidx) {
+		compacted_4b_initial = 0;
+		compacted_2b = 0;
+	} else if (vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B) {
+		compacted_2b = rounddown(totalidx - compacted_4b_initial, 16);
+	} else
+		compacted_2b = 0;
+
+	compacted_4b_end = totalidx - compacted_4b_initial - compacted_2b;
+
+	addr = ebase + compacted_4b_initial * 4 + compacted_2b * 2;
+	if (compacted_4b_end > 1)
+		addr += (compacted_4b_end / 2) * 8;
+	if (compacted_4b_end % 2)
+		addr += 8;
+
+	return addr;
+}
+
+static erofs_off_t legacy_inline_data_addr(struct erofs_inode *vi,
+					   erofs_off_t i_off,
+					   unsigned int totalidx)
+{
+	return Z_EROFS_VLE_LEGACY_INDEX_ALIGN(i_off + vi->inode_isize +
+					      vi->xattr_isize) +
+		totalidx * sizeof(struct z_erofs_vle_decompressed_index);
+}
+
+static erofs_off_t z_erofs_inline_data_addr(struct inode *inode)
+{
+	struct erofs_inode *const vi = EROFS_I(inode);
+	const unsigned int datamode = vi->datalayout;
+	const unsigned int totalidx = DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);
+	const erofs_off_t ibase = iloc(EROFS_I_SB(inode), vi->nid);
+
+	if (datamode == EROFS_INODE_FLAT_COMPRESSION)
+		return compacted_inline_data_addr(vi, ibase, totalidx);
+
+	if (datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY)
+		return legacy_inline_data_addr(vi, ibase, totalidx);
+
+	return -EINVAL;
+}
+
 static int z_erofs_fill_inode_lazy(struct inode *inode)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
@@ -65,6 +131,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 
 	h = kaddr + erofs_blkoff(pos);
 	vi->z_advise = le16_to_cpu(h->h_advise);
+	vi->z_idata_size = le16_to_cpu(h->h_idata_size);
 	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
 	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
 
@@ -94,13 +161,29 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
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
+	/* record HEAD lcn for tail-packing pcluster */
+	if (vi->z_idata_size) {
+		struct erofs_map_blocks map = { .m_la = inode->i_size - 1 };
+
+		err = z_erofs_do_map_blocks(inode, &map, 0);
+		if (map.mpage)
+			put_page(map.mpage);
+		if (err < 0)
+			goto out_unlock;
+
+		vi->z_idata_headlcn = map.m_la >> vi->z_logical_clusterbits;
+	}
+
+	/* paired with smp_mb() at the beginning of the function */
+	smp_mb();
+	set_bit(EROFS_I_Z_INITED_BIT, &vi->flags);
 out_unlock:
 	clear_and_wake_up_bit(EROFS_I_BL_Z_BIT, &vi->flags);
 	return err;
@@ -305,7 +388,7 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	}
 	m->clusterofs = lo;
 	m->delta[0] = 0;
-	/* figout out blkaddr (pblk) for HEAD lclusters */
+	/* figure out blkaddr (pblk) for HEAD lclusters */
 	if (!big_pcluster) {
 		nblk = 1;
 		while (i > 0) {
@@ -466,7 +549,8 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 }
 
 static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
-					    unsigned int initial_lcn)
+					    unsigned int initial_lcn,
+					    bool idatamap)
 {
 	struct erofs_inode *const vi = EROFS_I(m->inode);
 	struct erofs_map_blocks *const map = m->map;
@@ -479,6 +563,11 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 		  m->type != Z_EROFS_VLE_CLUSTER_TYPE_HEAD2);
 	DBG_BUGON(m->type != m->headtype);
 
+	if (idatamap) {
+		map->m_plen = vi->z_idata_size;
+		return 0;
+	}
+
 	if (m->headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN ||
 	    ((m->headtype == Z_EROFS_VLE_CLUSTER_TYPE_HEAD1) &&
 	     !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) ||
@@ -583,9 +672,9 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
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
@@ -596,20 +685,7 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 	unsigned int lclusterbits, endoff;
 	unsigned long initial_lcn;
 	unsigned long long ofs, end;
-
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
+	bool idatamap;
 
 	lclusterbits = vi->z_logical_clusterbits;
 	ofs = map->m_la;
@@ -658,10 +734,23 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 		goto unmap_out;
 	}
 
+	/* check if mapping tail-packing data */
+	idatamap = vi->z_idata_size && (ofs == inode->i_size - 1 ||
+		   m.lcn == vi->z_idata_headlcn);
+
+	/* need to trim tail-packing data if beyond file size */
 	map->m_llen = end - map->m_la;
-	map->m_pa = blknr_to_addr(m.pblk);
+	if (idatamap && end > inode->i_size)
+		map->m_llen -= end - inode->i_size;
 
-	err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
+	if (idatamap && (vi->z_advise & Z_EROFS_ADVISE_INLINE_DATA)) {
+		map->m_pa = z_erofs_inline_data_addr(inode);
+		map->m_flags |= EROFS_MAP_META;
+	} else {
+		map->m_pa = blknr_to_addr(m.pblk);
+	}
+
+	err = z_erofs_get_extent_compressedlen(&m, initial_lcn, idatamap);
 	if (err)
 		goto out;
 
@@ -689,9 +778,34 @@ int z_erofs_map_blocks_iter(struct inode *inode,
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



