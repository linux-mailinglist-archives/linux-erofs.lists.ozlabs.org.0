Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7261B92B428
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Jul 2024 11:41:33 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ZPorx5f+;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WJGGM1y8mz3cjt
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Jul 2024 19:41:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ZPorx5f+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WJGG6434Lz3cYY
	for <linux-erofs@lists.ozlabs.org>; Tue,  9 Jul 2024 19:41:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720518074; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=riNJyWxRa1VzSquqPBMbNCMrZG4NCzYH+P5oXM3guIM=;
	b=ZPorx5f+/zAAitGhNnUAmox2wJucedecyoMgQx+MDJ6EsAZVQ9OSBf1aHnnuhbmpXOOMHrEHaaj3O82GtDMVFOV0NDDkh2Vk+adekK+oeElZXt1t9GgqnHEM3noSXkjqS4F+qoChxB4rt7X7Ido7uv4IHcRjiW7eHasvHjRR5j4=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0WABZZp6_1720518072;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WABZZp6_1720518072)
          by smtp.aliyun-inc.com;
          Tue, 09 Jul 2024 17:41:13 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 3/3] erofs: tidy up stream decompressors
Date: Tue,  9 Jul 2024 17:41:06 +0800
Message-ID: <20240709094106.3018109-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240709094106.3018109-1-hsiangkao@linux.alibaba.com>
References: <20240709094106.3018109-1-hsiangkao@linux.alibaba.com>
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

Just use a generic helper to prepare buffers for all supported
stream decompressors, eliminating similar logic.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/compress.h             |  15 ++++
 fs/erofs/decompressor.c         |  83 ++++++++++++++++++
 fs/erofs/decompressor_deflate.c | 131 +++++++---------------------
 fs/erofs/decompressor_lzma.c    | 148 ++++++++++----------------------
 fs/erofs/decompressor_zstd.c    | 136 ++++++++---------------------
 5 files changed, 209 insertions(+), 304 deletions(-)

diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index 601f533c9649..526edc0a7d2d 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -88,6 +88,21 @@ extern const struct z_erofs_decompressor z_erofs_deflate_decomp;
 extern const struct z_erofs_decompressor z_erofs_zstd_decomp;
 extern const struct z_erofs_decompressor *z_erofs_decomp[];
 
+struct z_erofs_stream_dctx {
+	struct z_erofs_decompress_req *rq;
+	unsigned int inpages, outpages;	/* # of {en,de}coded pages */
+	int no, ni;			/* the current {en,de}coded page # */
+
+	unsigned int avail_out;		/* remaining bytes in the decoded buffer */
+	unsigned int inbuf_pos, inbuf_sz;
+					/* current status of the encoded buffer */
+	u8 *kin, *kout;			/* buffer mapped pointers */
+	void *bounce;			/* bounce buffer for inplace I/Os */
+	bool bounced;			/* is the bounce buffer used now? */
+};
+
+int z_erofs_stream_switch_bufs(struct z_erofs_stream_dctx *dctx, void **dst,
+			       void **src, struct page **pgpl);
 int z_erofs_fixup_insize(struct z_erofs_decompress_req *rq, const char *padbuf,
 			 unsigned int padbufsize);
 int __init z_erofs_init_decompressor(void);
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index b22fce114061..eac9e415194b 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -372,6 +372,89 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
 	return 0;
 }
 
+int z_erofs_stream_switch_bufs(struct z_erofs_stream_dctx *dctx, void **dst,
+			       void **src, struct page **pgpl)
+{
+	struct z_erofs_decompress_req *rq = dctx->rq;
+	struct super_block *sb = rq->sb;
+	struct page **pgo, *tmppage;
+	unsigned int j;
+
+	if (!dctx->avail_out) {
+		if (++dctx->no >= dctx->outpages || !rq->outputsize) {
+			erofs_err(sb, "insufficient space for decompressed data");
+			return -EFSCORRUPTED;
+		}
+
+		if (dctx->kout)
+			kunmap_local(dctx->kout);
+		dctx->avail_out = min(rq->outputsize, PAGE_SIZE - rq->pageofs_out);
+		rq->outputsize -= dctx->avail_out;
+		pgo = &rq->out[dctx->no];
+		if (!*pgo && rq->fillgaps) {		/* deduped */
+			*pgo = erofs_allocpage(pgpl, rq->gfp);
+			if (!*pgo) {
+				dctx->kout = NULL;
+				return -ENOMEM;
+			}
+			set_page_private(*pgo, Z_EROFS_SHORTLIVED_PAGE);
+		}
+		if (*pgo) {
+			dctx->kout = kmap_local_page(*pgo);
+			*dst = dctx->kout + rq->pageofs_out;
+		} else {
+			*dst = dctx->kout = NULL;
+		}
+		rq->pageofs_out = 0;
+	}
+
+	if (dctx->inbuf_pos == dctx->inbuf_sz && rq->inputsize) {
+		if (++dctx->ni >= dctx->inpages) {
+			erofs_err(sb, "invalid compressed data");
+			return -EFSCORRUPTED;
+		}
+		if (dctx->kout) /* unlike kmap(), take care of the orders */
+			kunmap_local(dctx->kout);
+		kunmap_local(dctx->kin);
+
+		dctx->inbuf_sz = min_t(u32, rq->inputsize, PAGE_SIZE);
+		rq->inputsize -= dctx->inbuf_sz;
+		dctx->kin = kmap_local_page(rq->in[dctx->ni]);
+		*src = dctx->kin;
+		dctx->bounced = false;
+		if (dctx->kout) {
+			j = (u8 *)*dst - dctx->kout;
+			dctx->kout = kmap_local_page(rq->out[dctx->no]);
+			*dst = dctx->kout + j;
+		}
+		dctx->inbuf_pos = 0;
+	}
+
+	/*
+	 * Handle overlapping: Use the given bounce buffer if the input data is
+	 * under processing; Or utilize short-lived pages from the on-stack page
+	 * pool, where pages are shared among the same request.  Note that only
+	 * a few inplace I/O pages need to be doubled.
+	 */
+	if (!dctx->bounced && rq->out[dctx->no] == rq->in[dctx->ni]) {
+		memcpy(dctx->bounce, *src, dctx->inbuf_sz);
+		*src = dctx->bounce;
+		dctx->bounced = true;
+	}
+
+	for (j = dctx->ni + 1; j < dctx->inpages; ++j) {
+		if (rq->out[dctx->no] != rq->in[j])
+			continue;
+		tmppage = erofs_allocpage(pgpl, rq->gfp);
+		if (!tmppage)
+			return -ENOMEM;
+		set_page_private(tmppage, Z_EROFS_SHORTLIVED_PAGE);
+		copy_highpage(tmppage, rq->in[j]);
+		rq->in[j] = tmppage;
+	}
+	return 0;
+}
+
 const struct z_erofs_decompressor *z_erofs_decomp[] = {
 	[Z_EROFS_COMPRESSION_SHIFTED] = &(const struct z_erofs_decompressor) {
 		.decompress = z_erofs_transform_plain,
diff --git a/fs/erofs/decompressor_deflate.c b/fs/erofs/decompressor_deflate.c
index 79232ef15654..5070d2fcc737 100644
--- a/fs/erofs/decompressor_deflate.c
+++ b/fs/erofs/decompressor_deflate.c
@@ -100,24 +100,23 @@ static int z_erofs_load_deflate_config(struct super_block *sb,
 static int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
 				      struct page **pgpl)
 {
-	const unsigned int nrpages_out =
-		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
-	const unsigned int nrpages_in =
-		PAGE_ALIGN(rq->inputsize) >> PAGE_SHIFT;
 	struct super_block *sb = rq->sb;
-	unsigned int insz, outsz, pofs;
+	struct z_erofs_stream_dctx dctx = {
+		.rq = rq,
+		.inpages = PAGE_ALIGN(rq->inputsize) >> PAGE_SHIFT,
+		.outpages = PAGE_ALIGN(rq->pageofs_out + rq->outputsize)
+				>> PAGE_SHIFT,
+		.no = -1, .ni = 0,
+	};
 	struct z_erofs_deflate *strm;
-	u8 *kin, *kout = NULL;
-	bool bounced = false;
-	int no = -1, ni = 0, j = 0, zerr, err;
+	int zerr, err;
 
 	/* 1. get the exact DEFLATE compressed size */
-	kin = kmap_local_page(*rq->in);
-	err = z_erofs_fixup_insize(rq, kin + rq->pageofs_in,
-			min_t(unsigned int, rq->inputsize,
-			      sb->s_blocksize - rq->pageofs_in));
+	dctx.kin = kmap_local_page(*rq->in);
+	err = z_erofs_fixup_insize(rq, dctx.kin + rq->pageofs_in,
+			min(rq->inputsize, sb->s_blocksize - rq->pageofs_in));
 	if (err) {
-		kunmap_local(kin);
+		kunmap_local(dctx.kin);
 		return err;
 	}
 
@@ -134,102 +133,35 @@ static int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
 	spin_unlock(&z_erofs_deflate_lock);
 
 	/* 3. multi-call decompress */
-	insz = rq->inputsize;
-	outsz = rq->outputsize;
 	zerr = zlib_inflateInit2(&strm->z, -MAX_WBITS);
 	if (zerr != Z_OK) {
 		err = -EIO;
 		goto failed_zinit;
 	}
 
-	pofs = rq->pageofs_out;
-	strm->z.avail_in = min_t(u32, insz, PAGE_SIZE - rq->pageofs_in);
-	insz -= strm->z.avail_in;
-	strm->z.next_in = kin + rq->pageofs_in;
+	rq->fillgaps = true;	/* DEFLATE doesn't support NULL output buffer */
+	strm->z.avail_in = min(rq->inputsize, PAGE_SIZE - rq->pageofs_in);
+	rq->inputsize -= strm->z.avail_in;
+	strm->z.next_in = dctx.kin + rq->pageofs_in;
 	strm->z.avail_out = 0;
+	dctx.bounce = strm->bounce;
 
 	while (1) {
-		if (!strm->z.avail_out) {
-			if (++no >= nrpages_out || !outsz) {
-				erofs_err(sb, "insufficient space for decompressed data");
-				err = -EFSCORRUPTED;
-				break;
-			}
-
-			if (kout)
-				kunmap_local(kout);
-			strm->z.avail_out = min_t(u32, outsz, PAGE_SIZE - pofs);
-			outsz -= strm->z.avail_out;
-			if (!rq->out[no]) {
-				rq->out[no] = erofs_allocpage(pgpl, rq->gfp);
-				if (!rq->out[no]) {
-					kout = NULL;
-					err = -ENOMEM;
-					break;
-				}
-				set_page_private(rq->out[no],
-						 Z_EROFS_SHORTLIVED_PAGE);
-			}
-			kout = kmap_local_page(rq->out[no]);
-			strm->z.next_out = kout + pofs;
-			pofs = 0;
-		}
-
-		if (!strm->z.avail_in && insz) {
-			if (++ni >= nrpages_in) {
-				erofs_err(sb, "invalid compressed data");
-				err = -EFSCORRUPTED;
-				break;
-			}
-
-			if (kout) { /* unlike kmap(), take care of the orders */
-				j = strm->z.next_out - kout;
-				kunmap_local(kout);
-			}
-			kunmap_local(kin);
-			strm->z.avail_in = min_t(u32, insz, PAGE_SIZE);
-			insz -= strm->z.avail_in;
-			kin = kmap_local_page(rq->in[ni]);
-			strm->z.next_in = kin;
-			bounced = false;
-			if (kout) {
-				kout = kmap_local_page(rq->out[no]);
-				strm->z.next_out = kout + j;
-			}
-		}
-
-		/*
-		 * Handle overlapping: Use bounced buffer if the compressed
-		 * data is under processing; Or use short-lived pages from the
-		 * on-stack pagepool where pages share among the same request
-		 * and not _all_ inplace I/O pages are needed to be doubled.
-		 */
-		if (!bounced && rq->out[no] == rq->in[ni]) {
-			memcpy(strm->bounce, strm->z.next_in, strm->z.avail_in);
-			strm->z.next_in = strm->bounce;
-			bounced = true;
-		}
-
-		for (j = ni + 1; j < nrpages_in; ++j) {
-			struct page *tmppage;
-
-			if (rq->out[no] != rq->in[j])
-				continue;
-			tmppage = erofs_allocpage(pgpl, rq->gfp);
-			if (!tmppage) {
-				err = -ENOMEM;
-				goto failed;
-			}
-			set_page_private(tmppage, Z_EROFS_SHORTLIVED_PAGE);
-			copy_highpage(tmppage, rq->in[j]);
-			rq->in[j] = tmppage;
-		}
+		dctx.avail_out = strm->z.avail_out;
+		dctx.inbuf_sz = strm->z.avail_in;
+		err = z_erofs_stream_switch_bufs(&dctx,
+					(void **)&strm->z.next_out,
+					(void **)&strm->z.next_in, pgpl);
+		if (err)
+			break;
+		strm->z.avail_out = dctx.avail_out;
+		strm->z.avail_in = dctx.inbuf_sz;
 
 		zerr = zlib_inflate(&strm->z, Z_SYNC_FLUSH);
-		if (zerr != Z_OK || !(outsz + strm->z.avail_out)) {
+		if (zerr != Z_OK || !(rq->outputsize + strm->z.avail_out)) {
 			if (zerr == Z_OK && rq->partial_decoding)
 				break;
-			if (zerr == Z_STREAM_END && !outsz)
+			if (zerr == Z_STREAM_END && !rq->outputsize)
 				break;
 			erofs_err(sb, "failed to decompress %d in[%u] out[%u]",
 				  zerr, rq->inputsize, rq->outputsize);
@@ -237,13 +169,12 @@ static int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
 			break;
 		}
 	}
-failed:
 	if (zlib_inflateEnd(&strm->z) != Z_OK && !err)
 		err = -EIO;
-	if (kout)
-		kunmap_local(kout);
+	if (dctx.kout)
+		kunmap_local(dctx.kout);
 failed_zinit:
-	kunmap_local(kin);
+	kunmap_local(dctx.kin);
 	/* 4. push back DEFLATE stream context to the global list */
 	spin_lock(&z_erofs_deflate_lock);
 	strm->next = z_erofs_deflate_head;
diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
index 80e735dc8406..06a722b85a45 100644
--- a/fs/erofs/decompressor_lzma.c
+++ b/fs/erofs/decompressor_lzma.c
@@ -5,7 +5,6 @@
 struct z_erofs_lzma {
 	struct z_erofs_lzma *next;
 	struct xz_dec_microlzma *state;
-	struct xz_buf buf;
 	u8 bounce[PAGE_SIZE];
 };
 
@@ -150,23 +149,25 @@ static int z_erofs_load_lzma_config(struct super_block *sb,
 static int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 				   struct page **pgpl)
 {
-	const unsigned int nrpages_out =
-		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
-	const unsigned int nrpages_in =
-		PAGE_ALIGN(rq->inputsize) >> PAGE_SHIFT;
-	unsigned int inlen, outlen, pageofs;
+	struct super_block *sb = rq->sb;
+	struct z_erofs_stream_dctx dctx = {
+		.rq = rq,
+		.inpages = PAGE_ALIGN(rq->inputsize) >> PAGE_SHIFT,
+		.outpages = PAGE_ALIGN(rq->pageofs_out + rq->outputsize)
+				>> PAGE_SHIFT,
+		.no = -1, .ni = 0,
+	};
+	struct xz_buf buf = {};
 	struct z_erofs_lzma *strm;
-	u8 *kin;
-	bool bounced = false;
-	int no, ni, j, err = 0;
+	enum xz_ret xz_err;
+	int err;
 
 	/* 1. get the exact LZMA compressed size */
-	kin = kmap(*rq->in);
-	err = z_erofs_fixup_insize(rq, kin + rq->pageofs_in,
-			min_t(unsigned int, rq->inputsize,
-			      rq->sb->s_blocksize - rq->pageofs_in));
+	dctx.kin = kmap_local_page(*rq->in);
+	err = z_erofs_fixup_insize(rq, dctx.kin + rq->pageofs_in,
+			min(rq->inputsize, sb->s_blocksize - rq->pageofs_in));
 	if (err) {
-		kunmap(*rq->in);
+		kunmap_local(dctx.kin);
 		return err;
 	}
 
@@ -183,108 +184,45 @@ static int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 	spin_unlock(&z_erofs_lzma_lock);
 
 	/* 3. multi-call decompress */
-	inlen = rq->inputsize;
-	outlen = rq->outputsize;
-	xz_dec_microlzma_reset(strm->state, inlen, outlen,
+	xz_dec_microlzma_reset(strm->state, rq->inputsize, rq->outputsize,
 			       !rq->partial_decoding);
-	pageofs = rq->pageofs_out;
-	strm->buf.in = kin + rq->pageofs_in;
-	strm->buf.in_pos = 0;
-	strm->buf.in_size = min_t(u32, inlen, PAGE_SIZE - rq->pageofs_in);
-	inlen -= strm->buf.in_size;
-	strm->buf.out = NULL;
-	strm->buf.out_pos = 0;
-	strm->buf.out_size = 0;
-
-	for (ni = 0, no = -1;;) {
-		enum xz_ret xz_err;
-
-		if (strm->buf.out_pos == strm->buf.out_size) {
-			if (strm->buf.out) {
-				kunmap(rq->out[no]);
-				strm->buf.out = NULL;
-			}
-
-			if (++no >= nrpages_out || !outlen) {
-				erofs_err(rq->sb, "decompressed buf out of bound");
-				err = -EFSCORRUPTED;
-				break;
-			}
-			strm->buf.out_pos = 0;
-			strm->buf.out_size = min_t(u32, outlen,
-						   PAGE_SIZE - pageofs);
-			outlen -= strm->buf.out_size;
-			if (!rq->out[no] && rq->fillgaps) {	/* deduped */
-				rq->out[no] = erofs_allocpage(pgpl, rq->gfp);
-				if (!rq->out[no]) {
-					err = -ENOMEM;
-					break;
-				}
-				set_page_private(rq->out[no],
-						 Z_EROFS_SHORTLIVED_PAGE);
-			}
-			if (rq->out[no])
-				strm->buf.out = kmap(rq->out[no]) + pageofs;
-			pageofs = 0;
-		} else if (strm->buf.in_pos == strm->buf.in_size) {
-			kunmap(rq->in[ni]);
-
-			if (++ni >= nrpages_in || !inlen) {
-				erofs_err(rq->sb, "compressed buf out of bound");
-				err = -EFSCORRUPTED;
-				break;
-			}
-			strm->buf.in_pos = 0;
-			strm->buf.in_size = min_t(u32, inlen, PAGE_SIZE);
-			inlen -= strm->buf.in_size;
-			kin = kmap(rq->in[ni]);
-			strm->buf.in = kin;
-			bounced = false;
-		}
+	buf.in_size = min(rq->inputsize, PAGE_SIZE - rq->pageofs_in);
+	rq->inputsize -= buf.in_size;
+	buf.in = dctx.kin + rq->pageofs_in,
+	dctx.bounce = strm->bounce;
+	do {
+		dctx.avail_out = buf.out_size - buf.out_pos;
+		dctx.inbuf_sz = buf.in_size;
+		dctx.inbuf_pos = buf.in_pos;
+		err = z_erofs_stream_switch_bufs(&dctx, (void **)&buf.out,
+						 (void **)&buf.in, pgpl);
+		if (err)
+			break;
 
-		/*
-		 * Handle overlapping: Use bounced buffer if the compressed
-		 * data is under processing; Otherwise, Use short-lived pages
-		 * from the on-stack pagepool where pages share with the same
-		 * request.
-		 */
-		if (!bounced && rq->out[no] == rq->in[ni]) {
-			memcpy(strm->bounce, strm->buf.in, strm->buf.in_size);
-			strm->buf.in = strm->bounce;
-			bounced = true;
+		if (buf.out_size == buf.out_pos) {
+			buf.out_size = dctx.avail_out;
+			buf.out_pos = 0;
 		}
-		for (j = ni + 1; j < nrpages_in; ++j) {
-			struct page *tmppage;
+		buf.in_size = dctx.inbuf_sz;
+		buf.in_pos = dctx.inbuf_pos;
 
-			if (rq->out[no] != rq->in[j])
-				continue;
-			tmppage = erofs_allocpage(pgpl, rq->gfp);
-			if (!tmppage) {
-				err = -ENOMEM;
-				goto failed;
-			}
-			set_page_private(tmppage, Z_EROFS_SHORTLIVED_PAGE);
-			copy_highpage(tmppage, rq->in[j]);
-			rq->in[j] = tmppage;
-		}
-		xz_err = xz_dec_microlzma_run(strm->state, &strm->buf);
-		DBG_BUGON(strm->buf.out_pos > strm->buf.out_size);
-		DBG_BUGON(strm->buf.in_pos > strm->buf.in_size);
+		xz_err = xz_dec_microlzma_run(strm->state, &buf);
+		DBG_BUGON(buf.out_pos > buf.out_size);
+		DBG_BUGON(buf.in_pos > buf.in_size);
 
 		if (xz_err != XZ_OK) {
-			if (xz_err == XZ_STREAM_END && !outlen)
+			if (xz_err == XZ_STREAM_END && !rq->outputsize)
 				break;
-			erofs_err(rq->sb, "failed to decompress %d in[%u] out[%u]",
+			erofs_err(sb, "failed to decompress %d in[%u] out[%u]",
 				  xz_err, rq->inputsize, rq->outputsize);
 			err = -EFSCORRUPTED;
 			break;
 		}
-	}
-failed:
-	if (no < nrpages_out && strm->buf.out)
-		kunmap(rq->out[no]);
-	if (ni < nrpages_in)
-		kunmap(rq->in[ni]);
+	} while (1);
+
+	if (dctx.kout)
+		kunmap_local(dctx.kout);
+	kunmap_local(dctx.kin);
 	/* 4. push back LZMA stream context to the global list */
 	spin_lock(&z_erofs_lzma_lock);
 	strm->next = z_erofs_lzma_head;
diff --git a/fs/erofs/decompressor_zstd.c b/fs/erofs/decompressor_zstd.c
index 49415bc40d7c..7e177304967e 100644
--- a/fs/erofs/decompressor_zstd.c
+++ b/fs/erofs/decompressor_zstd.c
@@ -138,27 +138,26 @@ static int z_erofs_load_zstd_config(struct super_block *sb,
 static int z_erofs_zstd_decompress(struct z_erofs_decompress_req *rq,
 				   struct page **pgpl)
 {
-	const unsigned int nrpages_out =
-		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
-	const unsigned int nrpages_in =
-		PAGE_ALIGN(rq->inputsize) >> PAGE_SHIFT;
-	zstd_dstream *stream;
 	struct super_block *sb = rq->sb;
-	unsigned int insz, outsz, pofs;
-	struct z_erofs_zstd *strm;
+	struct z_erofs_stream_dctx dctx = {
+		.rq = rq,
+		.inpages = PAGE_ALIGN(rq->inputsize) >> PAGE_SHIFT,
+		.outpages = PAGE_ALIGN(rq->pageofs_out + rq->outputsize)
+				>> PAGE_SHIFT,
+		.no = -1, .ni = 0,
+	};
 	zstd_in_buffer in_buf = { NULL, 0, 0 };
 	zstd_out_buffer out_buf = { NULL, 0, 0 };
-	u8 *kin, *kout = NULL;
-	bool bounced = false;
-	int no = -1, ni = 0, j = 0, zerr, err;
+	struct z_erofs_zstd *strm;
+	zstd_dstream *stream;
+	int zerr, err;
 
 	/* 1. get the exact compressed size */
-	kin = kmap_local_page(*rq->in);
-	err = z_erofs_fixup_insize(rq, kin + rq->pageofs_in,
-			min_t(unsigned int, rq->inputsize,
-			      sb->s_blocksize - rq->pageofs_in));
+	dctx.kin = kmap_local_page(*rq->in);
+	err = z_erofs_fixup_insize(rq, dctx.kin + rq->pageofs_in,
+			min(rq->inputsize, sb->s_blocksize - rq->pageofs_in));
 	if (err) {
-		kunmap_local(kin);
+		kunmap_local(dctx.kin);
 		return err;
 	}
 
@@ -166,109 +165,48 @@ static int z_erofs_zstd_decompress(struct z_erofs_decompress_req *rq,
 	strm = z_erofs_isolate_strms(false);
 
 	/* 3. multi-call decompress */
-	insz = rq->inputsize;
-	outsz = rq->outputsize;
 	stream = zstd_init_dstream(z_erofs_zstd_max_dictsize, strm->wksp, strm->wkspsz);
 	if (!stream) {
 		err = -EIO;
 		goto failed_zinit;
 	}
 
-	pofs = rq->pageofs_out;
-	in_buf.size = min_t(u32, insz, PAGE_SIZE - rq->pageofs_in);
-	insz -= in_buf.size;
-	in_buf.src = kin + rq->pageofs_in;
+	rq->fillgaps = true;	/* ZSTD doesn't support NULL output buffer */
+	in_buf.size = min_t(u32, rq->inputsize, PAGE_SIZE - rq->pageofs_in);
+	rq->inputsize -= in_buf.size;
+	in_buf.src = dctx.kin + rq->pageofs_in;
+	dctx.bounce = strm->bounce;
+
 	do {
-		if (out_buf.size == out_buf.pos) {
-			if (++no >= nrpages_out || !outsz) {
-				erofs_err(sb, "insufficient space for decompressed data");
-				err = -EFSCORRUPTED;
-				break;
-			}
+		dctx.avail_out = out_buf.size - out_buf.pos;
+		dctx.inbuf_sz = in_buf.size;
+		dctx.inbuf_pos = in_buf.pos;
+		err = z_erofs_stream_switch_bufs(&dctx, &out_buf.dst,
+						 (void **)&in_buf.src, pgpl);
+		if (err)
+			break;
 
-			if (kout)
-				kunmap_local(kout);
-			out_buf.size = min_t(u32, outsz, PAGE_SIZE - pofs);
-			outsz -= out_buf.size;
-			if (!rq->out[no]) {
-				rq->out[no] = erofs_allocpage(pgpl, rq->gfp);
-				if (!rq->out[no]) {
-					kout = NULL;
-					err = -ENOMEM;
-					break;
-				}
-				set_page_private(rq->out[no],
-						 Z_EROFS_SHORTLIVED_PAGE);
-			}
-			kout = kmap_local_page(rq->out[no]);
-			out_buf.dst = kout + pofs;
+		if (out_buf.size == out_buf.pos) {
+			out_buf.size = dctx.avail_out;
 			out_buf.pos = 0;
-			pofs = 0;
 		}
+		in_buf.size = dctx.inbuf_sz;
+		in_buf.pos = dctx.inbuf_pos;
 
-		if (in_buf.size == in_buf.pos && insz) {
-			if (++ni >= nrpages_in) {
-				erofs_err(sb, "invalid compressed data");
-				err = -EFSCORRUPTED;
-				break;
-			}
-
-			if (kout) /* unlike kmap(), take care of the orders */
-				kunmap_local(kout);
-			kunmap_local(kin);
-			in_buf.size = min_t(u32, insz, PAGE_SIZE);
-			insz -= in_buf.size;
-			kin = kmap_local_page(rq->in[ni]);
-			in_buf.src = kin;
-			in_buf.pos = 0;
-			bounced = false;
-			if (kout) {
-				j = (u8 *)out_buf.dst - kout;
-				kout = kmap_local_page(rq->out[no]);
-				out_buf.dst = kout + j;
-			}
-		}
-
-		/*
-		 * Handle overlapping: Use bounced buffer if the compressed
-		 * data is under processing; Or use short-lived pages from the
-		 * on-stack pagepool where pages share among the same request
-		 * and not _all_ inplace I/O pages are needed to be doubled.
-		 */
-		if (!bounced && rq->out[no] == rq->in[ni]) {
-			memcpy(strm->bounce, in_buf.src, in_buf.size);
-			in_buf.src = strm->bounce;
-			bounced = true;
-		}
-
-		for (j = ni + 1; j < nrpages_in; ++j) {
-			struct page *tmppage;
-
-			if (rq->out[no] != rq->in[j])
-				continue;
-			tmppage = erofs_allocpage(pgpl, rq->gfp);
-			if (!tmppage) {
-				err = -ENOMEM;
-				goto failed;
-			}
-			set_page_private(tmppage, Z_EROFS_SHORTLIVED_PAGE);
-			copy_highpage(tmppage, rq->in[j]);
-			rq->in[j] = tmppage;
-		}
 		zerr = zstd_decompress_stream(stream, &out_buf, &in_buf);
-		if (zstd_is_error(zerr) || (!zerr && outsz)) {
+		if (zstd_is_error(zerr) || (!zerr && rq->outputsize)) {
 			erofs_err(sb, "failed to decompress in[%u] out[%u]: %s",
 				  rq->inputsize, rq->outputsize,
 				  zerr ? zstd_get_error_name(zerr) : "unexpected end of stream");
 			err = -EFSCORRUPTED;
 			break;
 		}
-	} while (outsz || out_buf.pos < out_buf.size);
-failed:
-	if (kout)
-		kunmap_local(kout);
+	} while (rq->outputsize || out_buf.pos < out_buf.size);
+
+	if (dctx.kout)
+		kunmap_local(dctx.kout);
 failed_zinit:
-	kunmap_local(kin);
+	kunmap_local(dctx.kin);
 	/* 4. push back ZSTD stream context to the global list */
 	spin_lock(&z_erofs_zstd_lock);
 	strm->next = z_erofs_zstd_head;
-- 
2.43.5

