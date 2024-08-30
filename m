Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E399655AB
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2024 05:29:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ww3XX5rFBz30Vl
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2024 13:29:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724988536;
	cv=none; b=GBzcGt8592zhFrWIEKjbtR7H0d0NfKCjACv0wwX3fSRi6NjFpSdDCF10bmzpVuBW/1qeKPm9JMPNLhMT6NgnGQxTdfkQDCk+O9IAHdHGDaDltdjUi+8jvBwPUwKT/zAbalCL431dKpm0di27MB9i/RYM7aob+bYwS2LuB3+gFByKhWWIbNJusXCkCabd+y4/2GgSScDHcWxo64Lr0SN5U4FjcFKUldfrHbN0ete4/O+poofWyXp72XW4n/iGyObD7XDJRS/IGALfCd+UqmHML+B7mB14OWFaFPKva0YhfaCs9eV/uhppQtuAeU28B3XTCbJl2I+d0P6Bh1BK5MDFEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724988536; c=relaxed/relaxed;
	bh=wmgf7mK1MAkIbQDcb6qtyCAXl4zgAOfZWv4JWPpFpmo=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=id7nwMkZtUQdhCQ/Nck1j8K0YV1qIBqettN07LVlWfTG9n/plbsTf2C/TowT9EMR0oDW/ObwK9LFnAauWcJxU2cfRlmBx0rOxk3t1nGcJweoiibiZr9GaGSCmYIlPdY6mgymEjVUkG4JXSxOJIcTDaCAtxhNUcjr3HmIEF2z/gcKm9iVkLVg94x7O9XkT5MvlDc2cONkbdpb14D0R1me0py4QbwBdQ9gKC9iHueJZV2zpo0MVKfwt4VD8S5dX5mxMPO07aV1yrAZg8XYFFD5b7LxYgVQ4pYsMwYAHm73S9fp1IqPTwuXzMXxD+Xl+KA2q+j7pUVEiroMaKWixBLNYw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YU9jDyaN; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YU9jDyaN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ww3XS2zW3z2xjd
	for <linux-erofs@lists.ozlabs.org>; Fri, 30 Aug 2024 13:28:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724988531; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=wmgf7mK1MAkIbQDcb6qtyCAXl4zgAOfZWv4JWPpFpmo=;
	b=YU9jDyaN64mqy86jutQYv1JDHa4ImCf8F+PinZ7VjLOV/OaNzHHX7KwO+zoMrf23HzeRT6JlJ0aiI9WJToRQovLG5dIL55/VETxM7Mkk5tNiFNbwFbhezp5usRG7MUk90KVYza8twCIZ+FdPxo1OMEzgaLCeghg18q2haf0txNw=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WDv3lsZ_1724988529)
          by smtp.aliyun-inc.com;
          Fri, 30 Aug 2024 11:28:50 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 3/4] erofs: support compressed inodes for fileio
Date: Fri, 30 Aug 2024 11:28:39 +0800
Message-ID: <20240830032840.3783206-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Use pseudo bios just like the previous fscache approach since
merged bio_vecs can be filled properly with unique interfaces.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/fileio.c   | 25 +++++++++++++++++++++----
 fs/erofs/inode.c    |  6 ------
 fs/erofs/internal.h |  8 ++++++++
 fs/erofs/zdata.c    | 27 +++++++++++++++++----------
 4 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index eab52b8abd0b..9e4b851d85c0 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -23,7 +23,6 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
 			container_of(iocb, struct erofs_fileio_rq, iocb);
 	struct folio_iter fi;
 
-	DBG_BUGON(rq->bio.bi_end_io);
 	if (ret > 0) {
 		if (ret != rq->bio.bi_iter.bi_size) {
 			bio_advance(&rq->bio, ret);
@@ -31,9 +30,13 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
 		}
 		ret = 0;
 	}
-	bio_for_each_folio_all(fi, &rq->bio) {
-		DBG_BUGON(folio_test_uptodate(fi.folio));
-		erofs_onlinefolio_end(fi.folio, ret);
+	if (rq->bio.bi_end_io) {
+		rq->bio.bi_end_io(&rq->bio);
+	} else {
+		bio_for_each_folio_all(fi, &rq->bio) {
+			DBG_BUGON(folio_test_uptodate(fi.folio));
+			erofs_onlinefolio_end(fi.folio, ret);
+		}
 	}
 	kfree(rq);
 }
@@ -68,6 +71,20 @@ static struct erofs_fileio_rq *erofs_fileio_rq_alloc(struct erofs_map_dev *mdev)
 	return rq;
 }
 
+struct bio *erofs_fileio_bio_alloc(struct erofs_map_dev *mdev)
+{
+	struct erofs_fileio_rq *rq;
+
+	rq = erofs_fileio_rq_alloc(mdev);
+	return rq ? &rq->bio : NULL;
+}
+
+void erofs_fileio_submit_bio(struct bio *bio)
+{
+	return erofs_fileio_rq_submit(container_of(bio, struct erofs_fileio_rq,
+						   bio));
+}
+
 static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
 {
 	struct inode *inode = folio_inode(folio);
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 4a902e6e69a5..82259553d9f6 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -260,12 +260,6 @@ static int erofs_fill_inode(struct inode *inode)
 	mapping_set_large_folios(inode->i_mapping);
 	if (erofs_inode_is_data_compressed(vi->datalayout)) {
 #ifdef CONFIG_EROFS_FS_ZIP
-#ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
-		if (erofs_is_fileio_mode(EROFS_SB(inode->i_sb))) {
-			err = -EOPNOTSUPP;
-			goto out_unlock;
-		}
-#endif
 		DO_ONCE_LITE_IF(inode->i_blkbits != PAGE_SHIFT,
 			  erofs_info, inode->i_sb,
 			  "EXPERIMENTAL EROFS subpage compressed block support in use. Use at your own risk!");
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 9bc4dcfd06d7..4efd578d7c62 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -489,6 +489,14 @@ static inline void z_erofs_exit_subsystem(void) {}
 static inline int erofs_init_managed_cache(struct super_block *sb) { return 0; }
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
+#ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
+struct bio *erofs_fileio_bio_alloc(struct erofs_map_dev *mdev);
+void erofs_fileio_submit_bio(struct bio *bio);
+#else
+static inline struct bio *erofs_fileio_bio_alloc(struct erofs_map_dev *mdev) { return NULL; }
+static inline void erofs_fileio_submit_bio(struct bio *bio) {}
+#endif
+
 #ifdef CONFIG_EROFS_FS_ONDEMAND
 int erofs_fscache_register_fs(struct super_block *sb);
 void erofs_fscache_unregister_fs(struct super_block *sb);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 350612f32ac6..2271cb74ae3a 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1618,10 +1618,12 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 			if (bio && (cur != last_pa ||
 				    bio->bi_bdev != mdev.m_bdev)) {
 io_retry:
-				if (!erofs_is_fscache_mode(sb))
-					submit_bio(bio);
-				else
+				if (erofs_is_fileio_mode(EROFS_SB(sb)))
+					erofs_fileio_submit_bio(bio);
+				else if (erofs_is_fscache_mode(sb))
 					erofs_fscache_submit_bio(bio);
+				else
+					submit_bio(bio);
 
 				if (memstall) {
 					psi_memstall_leave(&pflags);
@@ -1637,10 +1639,13 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 			}
 
 			if (!bio) {
-				bio = erofs_is_fscache_mode(sb) ?
-					erofs_fscache_bio_alloc(&mdev) :
-					bio_alloc(mdev.m_bdev, BIO_MAX_VECS,
-						  REQ_OP_READ, GFP_NOIO);
+				if (erofs_is_fileio_mode(EROFS_SB(sb)))
+					bio = erofs_fileio_bio_alloc(&mdev);
+				else if (erofs_is_fscache_mode(sb))
+					bio = erofs_fscache_bio_alloc(&mdev);
+				else
+					bio = bio_alloc(mdev.m_bdev, BIO_MAX_VECS,
+							REQ_OP_READ, GFP_NOIO);
 				bio->bi_end_io = z_erofs_endio;
 				bio->bi_iter.bi_sector = cur >> 9;
 				bio->bi_private = q[JQ_SUBMIT];
@@ -1667,10 +1672,12 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 	} while (owned_head != Z_EROFS_PCLUSTER_TAIL);
 
 	if (bio) {
-		if (!erofs_is_fscache_mode(sb))
-			submit_bio(bio);
-		else
+		if (erofs_is_fileio_mode(EROFS_SB(sb)))
+			erofs_fileio_submit_bio(bio);
+		else if (erofs_is_fscache_mode(sb))
 			erofs_fscache_submit_bio(bio);
+		else
+			submit_bio(bio);
 		if (memstall)
 			psi_memstall_leave(&pflags);
 	}
-- 
2.43.5

