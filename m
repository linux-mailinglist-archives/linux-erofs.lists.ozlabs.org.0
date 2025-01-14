Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19550A0FFA9
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Jan 2025 04:44:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YXFPY0kTtz307K
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Jan 2025 14:44:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736826287;
	cv=none; b=chTyCkvD/iIhPcY6pJ0fy+xjNXhg/KxtTBeWhvPjCZkWsjFMbfEG3H8QFIuR4QO6JmrWxY/IYhGOymytJNuXyiYgqR/lAblJQDnT9ki6IgQvcHcnRjr7Eh34qc8ll7+DDEcbfqPY9ujL0P+PV6viNbtWiEmQJ/XJBlCtsRVqUmV2TAn5uaskfjV459jHXi91h799XqAXDDKb8Ow76uqbFM0UhCPkRdFpbTTbka4pF0HkyScnxSrdkudLs4ea0PGyQvvzMjr1sxEFEwSvHrMR+EIJHeGg7v1yeWvy9itguphwp+72PwvFl7VfzlHE0YYzUfa29wk8qZ0cWQWlQWhHnA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736826287; c=relaxed/relaxed;
	bh=KRm1P7fmX0GwPI71JA3RVjZjxIVZHsCiEwuznOJo5I4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lzwqYEG0YaZzUKdkxYh0VCsGbxG35CiD2a2FD/ySl5NeHfE6Lkt1pxYCC8KB1bPY9jmo/U/CjKSWNBHIAiBdx1VIOAuJI5nXQh21HjU3yKtOL1jCTsahXIQ36pEyL1b6MQ3yHSk70XMr3ZL+h96mwdqH72aUgjQvTQB85oOJA+N2zCj/FiPC6bYSN5AUX/v05MLQ2SAMvMeGJyroGex6BL0BNIEEPiyO7T0pJMH8DvzjuaURlLp2H4mQ7xtqb9YEPF3IBtwOIbmhnI9Vnoi6Uva8hZIiC4vebJPaIusJE36dtNpb0WTO1sN5ziQyJJ1vQOl5nGQEBg/T2Ka7QAEurA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tDUNRq17; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tDUNRq17;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YXFPT4ctxz2yyJ
	for <linux-erofs@lists.ozlabs.org>; Tue, 14 Jan 2025 14:44:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736826281; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=KRm1P7fmX0GwPI71JA3RVjZjxIVZHsCiEwuznOJo5I4=;
	b=tDUNRq17vmvhzUBVaoD5K6z2WGUgndvLGLI/BGGzZfBCAk43S/dhH/Xie/qbpeBTsCTmzZZn7Nda/BLisLQ54ZIsEBfB4swFrGtcOiF8C/HB4oSe+xopVU1rZ8C+Fv4VNBAswET83IUxQTT96CwD3sDiOPPFY4ZMTLIcqU3dZ1I=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WNdPh39_1736826278 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 14 Jan 2025 11:44:39 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 3/4] erofs: tidy up zdata.c
Date: Tue, 14 Jan 2025 11:44:28 +0800
Message-ID: <20250114034429.431408-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250114034429.431408-1-hsiangkao@linux.alibaba.com>
References: <20250114034429.431408-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

All small code style adjustments, no logic changes:

 - z_erofs_decompress_frontend => z_erofs_frontend;
 - z_erofs_decompress_backend => z_erofs_backend;
 - Use Z_EROFS_DEFINE_FRONTEND() to replace DECOMPRESS_FRONTEND_INIT();
 - `nr_folios` should be `nrpages` in z_erofs_readahead();
 - Refine in-line comments.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 111 ++++++++++++++++++-----------------------------
 1 file changed, 43 insertions(+), 68 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 8bafc4d9edbe..dcbb692ac058 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -455,31 +455,25 @@ int __init z_erofs_init_subsystem(void)
 }
 
 enum z_erofs_pclustermode {
+	/* It has previously been linked into another processing chain */
 	Z_EROFS_PCLUSTER_INFLIGHT,
 	/*
-	 * a weak form of Z_EROFS_PCLUSTER_FOLLOWED, the difference is that it
-	 * could be dispatched into bypass queue later due to uptodated managed
-	 * pages. All related online pages cannot be reused for inplace I/O (or
-	 * bvpage) since it can be directly decoded without I/O submission.
+	 * A weaker form of Z_EROFS_PCLUSTER_FOLLOWED; the difference is that it
+	 * may be dispatched to the bypass queue later due to uptodated managed
+	 * folios.  All file-backed folios related to this pcluster cannot be
+	 * reused for in-place I/O (or bvpage) since the pcluster may be decoded
+	 * in a separate queue (and thus out of order).
 	 */
 	Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE,
 	/*
-	 * The pcluster was just linked to a decompression chain by us.  It can
-	 * also be linked with the remaining pclusters, which means if the
-	 * processing page is the tail page of a pcluster, this pcluster can
-	 * safely use the whole page (since the previous pcluster is within the
-	 * same chain) for in-place I/O, as illustrated below:
-	 *  ___________________________________________________
-	 * |  tail (partial) page  |    head (partial) page    |
-	 * |  (of the current pcl) |   (of the previous pcl)   |
-	 * |___PCLUSTER_FOLLOWED___|_____PCLUSTER_FOLLOWED_____|
-	 *
-	 * [  (*) the page above can be used as inplace I/O.   ]
+	 * The pcluster has just been linked to our processing chain.
+	 * File-backed folios (except for the head page) related to it can be
+	 * used for in-place I/O (or bvpage).
 	 */
 	Z_EROFS_PCLUSTER_FOLLOWED,
 };
 
-struct z_erofs_decompress_frontend {
+struct z_erofs_frontend {
 	struct inode *const inode;
 	struct erofs_map_blocks map;
 	struct z_erofs_bvec_iter biter;
@@ -495,11 +489,11 @@ struct z_erofs_decompress_frontend {
 	unsigned int icur;
 };
 
-#define DECOMPRESS_FRONTEND_INIT(__i) { \
-	.inode = __i, .head = Z_EROFS_PCLUSTER_TAIL, \
-	.mode = Z_EROFS_PCLUSTER_FOLLOWED }
+#define Z_EROFS_DEFINE_FRONTEND(fe, i, ho) struct z_erofs_frontend fe = { \
+	.inode = i, .head = Z_EROFS_PCLUSTER_TAIL, \
+	.mode = Z_EROFS_PCLUSTER_FOLLOWED, .headoffset = ho }
 
-static bool z_erofs_should_alloc_cache(struct z_erofs_decompress_frontend *fe)
+static bool z_erofs_should_alloc_cache(struct z_erofs_frontend *fe)
 {
 	unsigned int cachestrategy = EROFS_I_SB(fe->inode)->opt.cache_strategy;
 
@@ -516,7 +510,7 @@ static bool z_erofs_should_alloc_cache(struct z_erofs_decompress_frontend *fe)
 	return false;
 }
 
-static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe)
+static void z_erofs_bind_cache(struct z_erofs_frontend *fe)
 {
 	struct address_space *mc = MNGD_MAPPING(EROFS_I_SB(fe->inode));
 	struct z_erofs_pcluster *pcl = fe->pcl;
@@ -673,7 +667,7 @@ int erofs_init_managed_cache(struct super_block *sb)
 }
 
 /* callers must be with pcluster lock held */
-static int z_erofs_attach_page(struct z_erofs_decompress_frontend *fe,
+static int z_erofs_attach_page(struct z_erofs_frontend *fe,
 			       struct z_erofs_bvec *bvec, bool exclusive)
 {
 	struct z_erofs_pcluster *pcl = fe->pcl;
@@ -719,7 +713,7 @@ static bool z_erofs_get_pcluster(struct z_erofs_pcluster *pcl)
 	return true;
 }
 
-static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
+static int z_erofs_register_pcluster(struct z_erofs_frontend *fe)
 {
 	struct erofs_map_blocks *map = &fe->map;
 	struct super_block *sb = fe->inode->i_sb;
@@ -789,7 +783,7 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 	return err;
 }
 
-static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
+static int z_erofs_pcluster_begin(struct z_erofs_frontend *fe)
 {
 	struct erofs_map_blocks *map = &fe->map;
 	struct super_block *sb = fe->inode->i_sb;
@@ -862,14 +856,9 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
 	return 0;
 }
 
-/*
- * keep in mind that no referenced pclusters will be freed
- * only after a RCU grace period.
- */
 static void z_erofs_rcu_callback(struct rcu_head *head)
 {
-	z_erofs_free_pcluster(container_of(head,
-			struct z_erofs_pcluster, rcu));
+	z_erofs_free_pcluster(container_of(head, struct z_erofs_pcluster, rcu));
 }
 
 static bool __erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
@@ -911,8 +900,7 @@ static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
 	return free;
 }
 
-unsigned long z_erofs_shrink_scan(struct erofs_sb_info *sbi,
-				  unsigned long nr_shrink)
+unsigned long z_erofs_shrink_scan(struct erofs_sb_info *sbi, unsigned long nr)
 {
 	struct z_erofs_pcluster *pcl;
 	unsigned int freed = 0;
@@ -926,7 +914,7 @@ unsigned long z_erofs_shrink_scan(struct erofs_sb_info *sbi,
 		xa_unlock(&sbi->managed_pslots);
 
 		++freed;
-		if (!--nr_shrink)
+		if (!--nr)
 			return freed;
 		xa_lock(&sbi->managed_pslots);
 	}
@@ -955,7 +943,7 @@ static void z_erofs_put_pcluster(struct erofs_sb_info *sbi,
 		call_rcu(&pcl->rcu, z_erofs_rcu_callback);
 }
 
-static void z_erofs_pcluster_end(struct z_erofs_decompress_frontend *fe)
+static void z_erofs_pcluster_end(struct z_erofs_frontend *fe)
 {
 	struct z_erofs_pcluster *pcl = fe->pcl;
 
@@ -968,13 +956,9 @@ static void z_erofs_pcluster_end(struct z_erofs_decompress_frontend *fe)
 	if (fe->candidate_bvpage)
 		fe->candidate_bvpage = NULL;
 
-	/*
-	 * if all pending pages are added, don't hold its reference
-	 * any longer if the pcluster isn't hosted by ourselves.
-	 */
+	/* Drop refcount if it doesn't belong to our processing chain */
 	if (fe->mode < Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE)
 		z_erofs_put_pcluster(EROFS_I_SB(fe->inode), pcl, false);
-
 	fe->pcl = NULL;
 }
 
@@ -1003,7 +987,7 @@ static int z_erofs_read_fragment(struct super_block *sb, struct folio *folio,
 	return 0;
 }
 
-static int z_erofs_scan_folio(struct z_erofs_decompress_frontend *f,
+static int z_erofs_scan_folio(struct z_erofs_frontend *f,
 			      struct folio *folio, bool ra)
 {
 	struct inode *const inode = f->inode;
@@ -1118,7 +1102,7 @@ static bool z_erofs_page_is_invalidated(struct page *page)
 	return !page_folio(page)->mapping && !z_erofs_is_shortlived_page(page);
 }
 
-struct z_erofs_decompress_backend {
+struct z_erofs_backend {
 	struct page *onstack_pages[Z_EROFS_ONSTACK_PAGES];
 	struct super_block *sb;
 	struct z_erofs_pcluster *pcl;
@@ -1138,7 +1122,7 @@ struct z_erofs_bvec_item {
 	struct list_head list;
 };
 
-static void z_erofs_do_decompressed_bvec(struct z_erofs_decompress_backend *be,
+static void z_erofs_do_decompressed_bvec(struct z_erofs_backend *be,
 					 struct z_erofs_bvec *bvec)
 {
 	struct z_erofs_bvec_item *item;
@@ -1161,8 +1145,7 @@ static void z_erofs_do_decompressed_bvec(struct z_erofs_decompress_backend *be,
 	list_add(&item->list, &be->decompressed_secondary_bvecs);
 }
 
-static void z_erofs_fill_other_copies(struct z_erofs_decompress_backend *be,
-				      int err)
+static void z_erofs_fill_other_copies(struct z_erofs_backend *be, int err)
 {
 	unsigned int off0 = be->pcl->pageofs_out;
 	struct list_head *p, *n;
@@ -1203,7 +1186,7 @@ static void z_erofs_fill_other_copies(struct z_erofs_decompress_backend *be,
 	}
 }
 
-static void z_erofs_parse_out_bvecs(struct z_erofs_decompress_backend *be)
+static void z_erofs_parse_out_bvecs(struct z_erofs_backend *be)
 {
 	struct z_erofs_pcluster *pcl = be->pcl;
 	struct z_erofs_bvec_iter biter;
@@ -1228,8 +1211,7 @@ static void z_erofs_parse_out_bvecs(struct z_erofs_decompress_backend *be)
 		z_erofs_put_shortlivedpage(be->pagepool, old_bvpage);
 }
 
-static int z_erofs_parse_in_bvecs(struct z_erofs_decompress_backend *be,
-				  bool *overlapped)
+static int z_erofs_parse_in_bvecs(struct z_erofs_backend *be, bool *overlapped)
 {
 	struct z_erofs_pcluster *pcl = be->pcl;
 	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
@@ -1264,8 +1246,7 @@ static int z_erofs_parse_in_bvecs(struct z_erofs_decompress_backend *be,
 	return err;
 }
 
-static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
-				       int err)
+static int z_erofs_decompress_pcluster(struct z_erofs_backend *be, int err)
 {
 	struct erofs_sb_info *const sbi = EROFS_SB(be->sb);
 	struct z_erofs_pcluster *pcl = be->pcl;
@@ -1395,7 +1376,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 static int z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
 				    struct page **pagepool)
 {
-	struct z_erofs_decompress_backend be = {
+	struct z_erofs_backend be = {
 		.sb = io->sb,
 		.pagepool = pagepool,
 		.decompressed_secondary_bvecs =
@@ -1473,7 +1454,7 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 }
 
 static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
-				 struct z_erofs_decompress_frontend *f,
+				 struct z_erofs_frontend *f,
 				 struct z_erofs_pcluster *pcl,
 				 unsigned int nr,
 				 struct address_space *mc)
@@ -1652,7 +1633,7 @@ static void z_erofs_endio(struct bio *bio)
 		bio_put(bio);
 }
 
-static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
+static void z_erofs_submit_queue(struct z_erofs_frontend *f,
 				 struct z_erofs_decompressqueue *fgq,
 				 bool *force_fg, bool readahead)
 {
@@ -1785,17 +1766,16 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 	z_erofs_decompress_kickoff(q[JQ_SUBMIT], nr_bios);
 }
 
-static int z_erofs_runqueue(struct z_erofs_decompress_frontend *f,
-			    unsigned int ra_folios)
+static int z_erofs_runqueue(struct z_erofs_frontend *f, unsigned int rapages)
 {
 	struct z_erofs_decompressqueue io[NR_JOBQUEUES];
 	struct erofs_sb_info *sbi = EROFS_I_SB(f->inode);
-	bool force_fg = z_erofs_is_sync_decompress(sbi, ra_folios);
+	bool force_fg = z_erofs_is_sync_decompress(sbi, rapages);
 	int err;
 
 	if (f->head == Z_EROFS_PCLUSTER_TAIL)
 		return 0;
-	z_erofs_submit_queue(f, io, &force_fg, !!ra_folios);
+	z_erofs_submit_queue(f, io, &force_fg, !!rapages);
 
 	/* handle bypass queue (no i/o pclusters) immediately */
 	err = z_erofs_decompress_queue(&io[JQ_BYPASS], &f->pagepool);
@@ -1813,7 +1793,7 @@ static int z_erofs_runqueue(struct z_erofs_decompress_frontend *f,
  * Since partial uptodate is still unimplemented for now, we have to use
  * approximate readmore strategies as a start.
  */
-static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
+static void z_erofs_pcluster_readmore(struct z_erofs_frontend *f,
 		struct readahead_control *rac, bool backmost)
 {
 	struct inode *inode = f->inode;
@@ -1868,12 +1848,10 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
 static int z_erofs_read_folio(struct file *file, struct folio *folio)
 {
 	struct inode *const inode = folio->mapping->host;
-	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
+	Z_EROFS_DEFINE_FRONTEND(f, inode, folio_pos(folio));
 	int err;
 
 	trace_erofs_read_folio(folio, false);
-	f.headoffset = (erofs_off_t)folio->index << PAGE_SHIFT;
-
 	z_erofs_pcluster_readmore(&f, NULL, true);
 	err = z_erofs_scan_folio(&f, folio, false);
 	z_erofs_pcluster_readmore(&f, NULL, false);
@@ -1893,17 +1871,14 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
 static void z_erofs_readahead(struct readahead_control *rac)
 {
 	struct inode *const inode = rac->mapping->host;
-	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
+	Z_EROFS_DEFINE_FRONTEND(f, inode, readahead_pos(rac));
 	struct folio *head = NULL, *folio;
-	unsigned int nr_folios;
+	unsigned int nrpages = readahead_count(rac);
 	int err;
 
-	f.headoffset = readahead_pos(rac);
-
 	z_erofs_pcluster_readmore(&f, rac, true);
-	nr_folios = readahead_count(rac);
-	trace_erofs_readpages(inode, readahead_index(rac), nr_folios, false);
-
+	nrpages = readahead_count(rac);
+	trace_erofs_readpages(inode, readahead_index(rac), nrpages, false);
 	while ((folio = readahead_folio(rac))) {
 		folio->private = head;
 		head = folio;
@@ -1922,7 +1897,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	z_erofs_pcluster_readmore(&f, rac, false);
 	z_erofs_pcluster_end(&f);
 
-	(void)z_erofs_runqueue(&f, nr_folios);
+	(void)z_erofs_runqueue(&f, nrpages);
 	erofs_put_metabuf(&f.map.buf);
 	erofs_release_pages(&f.pagepool);
 }
-- 
2.43.5

