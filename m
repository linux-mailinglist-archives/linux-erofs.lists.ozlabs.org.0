Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 277F6A419DC
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Feb 2025 10:58:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1740391133;
	bh=ajsOfd9FBnSAmCDC0EG4GS29hmOQ4DtAyNnSn8VTz3M=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=nWr1ydtusgut9hOYzxcQZNa/NYDqJzPOYsB4jgCbdOQ0nSPGXNbSaJm8lwy6MGuUG
	 Pct8Sy8c54wSvBl6UkqaxF16Yik7D+IIQktB16LBrLSAp3t9yTBWV6QF79KXqO5+Jr
	 8GW/xPCPXiAYVFTAfVhpb6/nrX9OwZIxdJtTQsZiZ8VpV7sbtzDOy2W/jigkxKPy43
	 5qOCkxdLPMD6e4q6hCWbespW/kDJqeqI4JqwB91KEFHwbB6qF69ZyRr04zTS/FuKU0
	 A9eqXcJGr28b367ZBNNgNCL8TVaqBhQzNMR39gfZ6tUPv+SrUfCOgLrlK2QKk7Rvb6
	 HvzxolRAi54Ug==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z1bmF4j31z3057
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Feb 2025 20:58:53 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740391132;
	cv=none; b=A2Gwc3zBdLC3ieTakO6jJT870EwIQdbayqpT3k6SVfuqZBPEeUu86Op6MCtmLsYcP2usqa1I1Cti5VnWO/TzXp4s+T1zk4xJ5NIYSFNAu76mbSMlk/rXp7+TVVse2qiP3UZObMmu0QF1ratY09sRCQYYg8HYAQxM0aqj6WCPzlZ71MnKANIPHu6owcHBs+657T2L0M3Gcpj1bVbsM0A0c6O6yFq6B++emia0n4gTYUZ+Cz6mWavoKemdgCY8c7mlEQlefdTROpHcytyTo/mEYCu355BmmSD3zMq57NK/TEvdjkv5cGhXg9Jxse6rg6dPMjX8CvDe+KDKJdwL5Q/X6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740391132; c=relaxed/relaxed;
	bh=ajsOfd9FBnSAmCDC0EG4GS29hmOQ4DtAyNnSn8VTz3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwhaBnCgtFmTIfVSmEdI8leicypwBWoa0DtEUyyJZiRFDY+VZJxfmkw3xc1HXhZwDsmrj3okhtvOk1JxKd5H2F4bDAEUZGryfWUupkTN/iogIUAeCfgXBjBMZ/jnTdGpMFU8aenKwth1+4OROZrMfegdQq4CEOc+iUdUC7fYMY3bOKkd8OmWyB6aVbHiQKupUF8EofXe8lZVmmpXU1MYTZrb+xBwwcCQfRI2B9G101Y6l7y167c+llAoigAWOxTLB6E1Gxu29oghxDpQgUpfs49E/IvqAdAQNvoPszi2fr7PKgEqkOCyTVfbD6Dx86YM2DLFeu7huEndJ6JiLw/nAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=PO1llj0k; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=gustavoars@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=PO1llj0k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=gustavoars@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z1bmC1npjz2yDS
	for <linux-erofs@lists.ozlabs.org>; Mon, 24 Feb 2025 20:58:51 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2998161193;
	Mon, 24 Feb 2025 09:58:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C03C4CED6;
	Mon, 24 Feb 2025 09:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740391128;
	bh=ZjDnXrksprqcdBpDIG/amfeXKgB6c4lJruai5qe5AhA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PO1llj0k12h5/Jb8CQuV57BkdgYfH/eqbVrzvtMdBv4G6bGDgxunu7xzsOu2NcAHI
	 PlCedtu+UkUKI2UZXTaIRl0ltFlFDeBPxRC83CzYSEPFqd9bp3ovwjLYLSljJxTagn
	 oQMHZa4qstKk4u3mvru+7XQSTjUiTQk13D5PzzBJChsWn2qBBphPqTK7QToFd0sa+8
	 1ke1OxIH4CQChKZDNFzuPV765Og8okFL3psFARQzGAGcWXX7OWRgBsLkFUxf0X+hBS
	 nkPPO3ctYZmqfgdFMDw2V+50D0ky4xivMPA1a1rP4V7OeKV3G3ikmsJPkHkS3frsB8
	 HeGzCJ72wsshw==
Date: Mon, 24 Feb 2025 20:28:43 +1030
To: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
	Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>
Subject: [PATCH 4/8][next] erofs: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <334f60e884cc0314ef98731e60a1b419e462e2d2.1739957534.git.gustavoars@kernel.org>
References: <cover.1739957534.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1739957534.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-0.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
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
From: "Gustavo A. R. Silva via Linux-erofs" <linux-erofs@lists.ozlabs.org>
Reply-To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Change the type of the middle struct member currently causing trouble from
`struct bio` to `struct bio_hdr`.

We also use `container_of()` whenever we need to retrieve a pointer to
the flexible structure `struct bio`, through which we can access the
flexible-array member in it, if necessary.

With these changes fix the following warnings:
fs/erofs/fileio.c:10:20: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
fs/erofs/fscache.c:179:20: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/erofs/fileio.c  | 25 +++++++++++++++----------
 fs/erofs/fscache.c | 13 +++++++------
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index 0ffd1c63beeb..3080963caf78 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -7,7 +7,7 @@
 
 struct erofs_fileio_rq {
 	struct bio_vec bvecs[16];
-	struct bio bio;
+	struct bio_hdr bio;
 	struct kiocb iocb;
 	struct super_block *sb;
 };
@@ -26,20 +26,21 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
 
 	if (ret > 0) {
 		if (ret != rq->bio.bi_iter.bi_size) {
-			bio_advance(&rq->bio, ret);
-			zero_fill_bio(&rq->bio);
+			bio_advance(container_of(&rq->bio, struct bio, __hdr),
+				    ret);
+			zero_fill_bio(container_of(&rq->bio, struct bio, __hdr));
 		}
 		ret = 0;
 	}
 	if (rq->bio.bi_end_io) {
-		rq->bio.bi_end_io(&rq->bio);
+		rq->bio.bi_end_io(container_of(&rq->bio, struct bio, __hdr));
 	} else {
-		bio_for_each_folio_all(fi, &rq->bio) {
+		bio_for_each_folio_all(fi, container_of(&rq->bio, struct bio, __hdr)) {
 			DBG_BUGON(folio_test_uptodate(fi.folio));
 			erofs_onlinefolio_end(fi.folio, ret);
 		}
 	}
-	bio_uninit(&rq->bio);
+	bio_uninit(container_of(&rq->bio, struct bio, __hdr));
 	kfree(rq);
 }
 
@@ -68,7 +69,8 @@ static struct erofs_fileio_rq *erofs_fileio_rq_alloc(struct erofs_map_dev *mdev)
 	struct erofs_fileio_rq *rq = kzalloc(sizeof(*rq),
 					     GFP_KERNEL | __GFP_NOFAIL);
 
-	bio_init(&rq->bio, NULL, rq->bvecs, ARRAY_SIZE(rq->bvecs), REQ_OP_READ);
+	bio_init(container_of(&rq->bio, struct bio, __hdr), NULL, rq->bvecs,
+		 ARRAY_SIZE(rq->bvecs), REQ_OP_READ);
 	rq->iocb.ki_filp = mdev->m_dif->file;
 	rq->sb = mdev->m_sb;
 	return rq;
@@ -76,12 +78,13 @@ static struct erofs_fileio_rq *erofs_fileio_rq_alloc(struct erofs_map_dev *mdev)
 
 struct bio *erofs_fileio_bio_alloc(struct erofs_map_dev *mdev)
 {
-	return &erofs_fileio_rq_alloc(mdev)->bio;
+	return container_of(&erofs_fileio_rq_alloc(mdev)->bio, struct bio, __hdr);
 }
 
 void erofs_fileio_submit_bio(struct bio *bio)
 {
-	return erofs_fileio_rq_submit(container_of(bio, struct erofs_fileio_rq,
+	return erofs_fileio_rq_submit(container_of(&bio->__hdr,
+						   struct erofs_fileio_rq,
 						   bio));
 }
 
@@ -150,7 +153,9 @@ static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
 			}
 			if (!attached++)
 				erofs_onlinefolio_split(folio);
-			if (!bio_add_folio(&io->rq->bio, folio, len, cur))
+			if (!bio_add_folio(container_of(&io->rq->bio,
+							struct bio, __hdr),
+					   folio, len, cur))
 				goto io_retry;
 			io->dev.m_pa += len;
 		}
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index ce3d8737df85..719ec96c8f22 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -176,7 +176,7 @@ static int erofs_fscache_read_io_async(struct fscache_cookie *cookie,
 
 struct erofs_fscache_bio {
 	struct erofs_fscache_io io;
-	struct bio bio;		/* w/o bdev to share bio_add_page/endio() */
+	struct bio_hdr bio;	/* w/o bdev to share bio_add_page/endio() */
 	struct bio_vec bvecs[BIO_MAX_VECS];
 };
 
@@ -187,7 +187,7 @@ static void erofs_fscache_bio_endio(void *priv,
 
 	if (IS_ERR_VALUE(transferred_or_error))
 		io->bio.bi_status = errno_to_blk_status(transferred_or_error);
-	io->bio.bi_end_io(&io->bio);
+	io->bio.bi_end_io(container_of(&io->bio, struct bio, __hdr));
 	BUILD_BUG_ON(offsetof(struct erofs_fscache_bio, io) != 0);
 	erofs_fscache_io_put(&io->io);
 }
@@ -197,17 +197,18 @@ struct bio *erofs_fscache_bio_alloc(struct erofs_map_dev *mdev)
 	struct erofs_fscache_bio *io;
 
 	io = kmalloc(sizeof(*io), GFP_KERNEL | __GFP_NOFAIL);
-	bio_init(&io->bio, NULL, io->bvecs, BIO_MAX_VECS, REQ_OP_READ);
+	bio_init(container_of(&io->bio, struct bio, __hdr), NULL, io->bvecs,
+		 BIO_MAX_VECS, REQ_OP_READ);
 	io->io.private = mdev->m_dif->fscache->cookie;
 	io->io.end_io = erofs_fscache_bio_endio;
 	refcount_set(&io->io.ref, 1);
-	return &io->bio;
+	return container_of(&io->bio, struct bio, __hdr);
 }
 
 void erofs_fscache_submit_bio(struct bio *bio)
 {
-	struct erofs_fscache_bio *io = container_of(bio,
-			struct erofs_fscache_bio, bio);
+	struct erofs_fscache_bio *io =
+		container_of(&bio->__hdr, struct erofs_fscache_bio, bio);
 	int ret;
 
 	iov_iter_bvec(&io->io.iter, ITER_DEST, io->bvecs, bio->bi_vcnt,
-- 
2.43.0

