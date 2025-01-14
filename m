Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A7413A0FFAA
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Jan 2025 04:44:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YXFPY3YGLz30W8
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Jan 2025 14:44:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736826287;
	cv=none; b=hsL68SxHYDYjFlsOGE0ZZUD+ISVcy0IEGsJ84VdSTvtAj8HorqObEYbw24R0A0r2sQlIFr3pRicxjaz4ZNizqUascnyIXJiiVoF9UdbZQ+Xs+dqxRG/GXpebHt98mQYbXiEzK4oGWKE63U+YTmyBcnavdPR4cWiXt5I3mbs+g8ouNwjmDMPGkMHVAZWGbPIJ3YqxHjGPoXAhZ/cjy9i14mfJQg6zE/MapIW/66rcWqz+ulP/OfzT7v7w5L3jk9F+D1y7VeMdrsMH8Uu1ZvxyMl+WRKZCqgyEz9gf3FRDgBDmqlse0IOwRbEtAucEM2TQ1PNQPDfM5jiDvojHyEpgwA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736826287; c=relaxed/relaxed;
	bh=QR/F5tJqdDVTblGZarYocNDcZWCpF89SXMMjBJSlgu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N6lz11X151oUvSLv/p2DXVsWb3MdIeYpbuD2LcsUAJ3xjIMJ5oyVwqWoINxzdzPuW4FSSTeYoYQdvGTJVqFLaHXRN5e+B6uRj1aLfl6dO8k9EtxoYqqAnqxifibNdswwChgwARcogEMeUHrVQY+eiWrkF00ZVZYLnkyU6tdbqVESmTiAdXanL/dFmLxfdHWZ+csN85IU2XK/6BRtk/2xp9GrooSr+rz17Yuqb+wPYSjJv/EFXaiWpDsW9U8L7e+eLeGI/VC2Lce8uveoDINiL7EdacGdSvoZzAg5AJU8Dui3tRrLdrWrecixntPNahfJsNGm8+eSx2IhZwGvvBzRhg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Oa+4fRU/; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Oa+4fRU/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YXFPT5yV7z3005
	for <linux-erofs@lists.ozlabs.org>; Tue, 14 Jan 2025 14:44:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736826280; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=QR/F5tJqdDVTblGZarYocNDcZWCpF89SXMMjBJSlgu8=;
	b=Oa+4fRU/iPnSYcGMuXbTWj8P8XMPqgmJW7TODP5+wDo2B1rxf5zK3wrB98VOCspS+MiddGcQvmVhbIys7L9pnZkDS1yDxj3wbO8ghQe5j8MBgHzy0JKxodaJNUz7QSPhlcGDh9YVvd7iUuv1VLJea7eejRC9QWBWIJmZuuapaD0=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WNdPh2F_1736826277 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 14 Jan 2025 11:44:38 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/4] erofs: get rid of `z_erofs_next_pcluster_t`
Date: Tue, 14 Jan 2025 11:44:27 +0800
Message-ID: <20250114034429.431408-2-hsiangkao@linux.alibaba.com>
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

It was originally intended for tagged pointer reservation.

Now all encoded data can be represented uniformally with
`struct z_erofs_pcluster` as described in commit bf1aa03980f4
("erofs: sunset `struct erofs_workgroup`"), let's drop it too.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 80 ++++++++++++++++++------------------------------
 1 file changed, 29 insertions(+), 51 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 19ef4ff2a134..8bafc4d9edbe 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -12,12 +12,6 @@
 #define Z_EROFS_PCLUSTER_MAX_PAGES	(Z_EROFS_PCLUSTER_MAX_SIZE / PAGE_SIZE)
 #define Z_EROFS_INLINE_BVECS		2
 
-/*
- * let's leave a type here in case of introducing
- * another tagged pointer later.
- */
-typedef void *z_erofs_next_pcluster_t;
-
 struct z_erofs_bvec {
 	struct page *page;
 	int offset;
@@ -48,7 +42,7 @@ struct z_erofs_pcluster {
 	struct lockref lockref;
 
 	/* A: point to next chained pcluster or TAILs */
-	z_erofs_next_pcluster_t next;
+	struct z_erofs_pcluster *next;
 
 	/* I: start block address of this pcluster */
 	erofs_off_t index;
@@ -94,12 +88,11 @@ struct z_erofs_pcluster {
 
 /* the end of a chain of pclusters */
 #define Z_EROFS_PCLUSTER_TAIL           ((void *) 0x700 + POISON_POINTER_DELTA)
-#define Z_EROFS_PCLUSTER_NIL            (NULL)
 
 struct z_erofs_decompressqueue {
 	struct super_block *sb;
+	struct z_erofs_pcluster *head;
 	atomic_t pending_bios;
-	z_erofs_next_pcluster_t head;
 
 	union {
 		struct completion done;
@@ -493,8 +486,7 @@ struct z_erofs_decompress_frontend {
 
 	struct page *pagepool;
 	struct page *candidate_bvpage;
-	struct z_erofs_pcluster *pcl;
-	z_erofs_next_pcluster_t owned_head;
+	struct z_erofs_pcluster *pcl, *head;
 	enum z_erofs_pclustermode mode;
 
 	erofs_off_t headoffset;
@@ -504,7 +496,7 @@ struct z_erofs_decompress_frontend {
 };
 
 #define DECOMPRESS_FRONTEND_INIT(__i) { \
-	.inode = __i, .owned_head = Z_EROFS_PCLUSTER_TAIL, \
+	.inode = __i, .head = Z_EROFS_PCLUSTER_TAIL, \
 	.mode = Z_EROFS_PCLUSTER_FOLLOWED }
 
 static bool z_erofs_should_alloc_cache(struct z_erofs_decompress_frontend *fe)
@@ -752,9 +744,7 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 	pcl->algorithmformat = map->m_algorithmformat;
 	pcl->length = 0;
 	pcl->partial = true;
-
-	/* new pclusters should be claimed as type 1, primary and followed */
-	pcl->next = fe->owned_head;
+	pcl->next = fe->head;
 	pcl->pageofs_out = map->m_la & ~PAGE_MASK;
 	fe->mode = Z_EROFS_PCLUSTER_FOLLOWED;
 
@@ -790,8 +780,7 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 			goto err_out;
 		}
 	}
-	fe->owned_head = &pcl->next;
-	fe->pcl = pcl;
+	fe->head = fe->pcl = pcl;
 	return 0;
 
 err_out:
@@ -810,7 +799,7 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
 
 	DBG_BUGON(fe->pcl);
 	/* must be Z_EROFS_PCLUSTER_TAIL or pointed to previous pcluster */
-	DBG_BUGON(fe->owned_head == Z_EROFS_PCLUSTER_NIL);
+	DBG_BUGON(!fe->head);
 
 	if (!(map->m_flags & EROFS_MAP_META)) {
 		while (1) {
@@ -838,10 +827,9 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
 	if (ret == -EEXIST) {
 		mutex_lock(&fe->pcl->lock);
 		/* check if this pcluster hasn't been linked into any chain. */
-		if (cmpxchg(&fe->pcl->next, Z_EROFS_PCLUSTER_NIL,
-			    fe->owned_head) == Z_EROFS_PCLUSTER_NIL) {
+		if (!cmpxchg(&fe->pcl->next, NULL, fe->head)) {
 			/* .. so it can be attached to our submission chain */
-			fe->owned_head = &fe->pcl->next;
+			fe->head = fe->pcl;
 			fe->mode = Z_EROFS_PCLUSTER_FOLLOWED;
 		} else {	/* otherwise, it belongs to an inflight chain */
 			fe->mode = Z_EROFS_PCLUSTER_INFLIGHT;
@@ -1394,7 +1382,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	pcl->vcnt = 0;
 
 	/* pcluster lock MUST be taken before the following line */
-	WRITE_ONCE(pcl->next, Z_EROFS_PCLUSTER_NIL);
+	WRITE_ONCE(pcl->next, NULL);
 	mutex_unlock(&pcl->lock);
 
 	if (z_erofs_is_inline_pcluster(pcl))
@@ -1412,16 +1400,14 @@ static int z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
 		.pagepool = pagepool,
 		.decompressed_secondary_bvecs =
 			LIST_HEAD_INIT(be.decompressed_secondary_bvecs),
+		.pcl = io->head,
 	};
-	z_erofs_next_pcluster_t owned = io->head;
+	struct z_erofs_pcluster *next;
 	int err = io->eio ? -EIO : 0;
 
-	while (owned != Z_EROFS_PCLUSTER_TAIL) {
-		DBG_BUGON(owned == Z_EROFS_PCLUSTER_NIL);
-
-		be.pcl = container_of(owned, struct z_erofs_pcluster, next);
-		owned = READ_ONCE(be.pcl->next);
-
+	for (; be.pcl != Z_EROFS_PCLUSTER_TAIL; be.pcl = next) {
+		DBG_BUGON(!be.pcl);
+		next = READ_ONCE(be.pcl->next);
 		err = z_erofs_decompress_pcluster(&be, err) ?: err;
 	}
 	return err;
@@ -1631,18 +1617,13 @@ enum {
 	NR_JOBQUEUES,
 };
 
-static void move_to_bypass_jobqueue(struct z_erofs_pcluster *pcl,
-				    z_erofs_next_pcluster_t qtail[],
-				    z_erofs_next_pcluster_t owned_head)
+static void z_erofs_move_to_bypass_queue(struct z_erofs_pcluster *pcl,
+					 struct z_erofs_pcluster *next,
+					 struct z_erofs_pcluster **qtail[])
 {
-	z_erofs_next_pcluster_t *const submit_qtail = qtail[JQ_SUBMIT];
-	z_erofs_next_pcluster_t *const bypass_qtail = qtail[JQ_BYPASS];
-
 	WRITE_ONCE(pcl->next, Z_EROFS_PCLUSTER_TAIL);
-
-	WRITE_ONCE(*submit_qtail, owned_head);
-	WRITE_ONCE(*bypass_qtail, &pcl->next);
-
+	WRITE_ONCE(*qtail[JQ_SUBMIT], next);
+	WRITE_ONCE(*qtail[JQ_BYPASS], pcl);
 	qtail[JQ_BYPASS] = &pcl->next;
 }
 
@@ -1677,9 +1658,9 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 {
 	struct super_block *sb = f->inode->i_sb;
 	struct address_space *mc = MNGD_MAPPING(EROFS_SB(sb));
-	z_erofs_next_pcluster_t qtail[NR_JOBQUEUES];
+	struct z_erofs_pcluster **qtail[NR_JOBQUEUES];
 	struct z_erofs_decompressqueue *q[NR_JOBQUEUES];
-	z_erofs_next_pcluster_t owned_head = f->owned_head;
+	struct z_erofs_pcluster *pcl, *next;
 	/* bio is NULL initially, so no need to initialize last_{index,bdev} */
 	erofs_off_t last_pa;
 	unsigned int nr_bios = 0;
@@ -1695,22 +1676,19 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 	qtail[JQ_SUBMIT] = &q[JQ_SUBMIT]->head;
 
 	/* by default, all need io submission */
-	q[JQ_SUBMIT]->head = owned_head;
+	q[JQ_SUBMIT]->head = next = f->head;
 
 	do {
 		struct erofs_map_dev mdev;
-		struct z_erofs_pcluster *pcl;
 		erofs_off_t cur, end;
 		struct bio_vec bvec;
 		unsigned int i = 0;
 		bool bypass = true;
 
-		DBG_BUGON(owned_head == Z_EROFS_PCLUSTER_NIL);
-		pcl = container_of(owned_head, struct z_erofs_pcluster, next);
-		owned_head = READ_ONCE(pcl->next);
-
+		pcl = next;
+		next = READ_ONCE(pcl->next);
 		if (z_erofs_is_inline_pcluster(pcl)) {
-			move_to_bypass_jobqueue(pcl, qtail, owned_head);
+			z_erofs_move_to_bypass_queue(pcl, next, qtail);
 			continue;
 		}
 
@@ -1782,8 +1760,8 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 		if (!bypass)
 			qtail[JQ_SUBMIT] = &pcl->next;
 		else
-			move_to_bypass_jobqueue(pcl, qtail, owned_head);
-	} while (owned_head != Z_EROFS_PCLUSTER_TAIL);
+			z_erofs_move_to_bypass_queue(pcl, next, qtail);
+	} while (next != Z_EROFS_PCLUSTER_TAIL);
 
 	if (bio) {
 		if (erofs_is_fileio_mode(EROFS_SB(sb)))
@@ -1815,7 +1793,7 @@ static int z_erofs_runqueue(struct z_erofs_decompress_frontend *f,
 	bool force_fg = z_erofs_is_sync_decompress(sbi, ra_folios);
 	int err;
 
-	if (f->owned_head == Z_EROFS_PCLUSTER_TAIL)
+	if (f->head == Z_EROFS_PCLUSTER_TAIL)
 		return 0;
 	z_erofs_submit_queue(f, io, &force_fg, !!ra_folios);
 
-- 
2.43.5

