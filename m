Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D28935629E
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Apr 2021 06:40:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FFWsC3Qt4z302y
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Apr 2021 14:39:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mkghiKb/;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=mkghiKb/; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FFWsB2Pw3z2yjD
 for <linux-erofs@lists.ozlabs.org>; Wed,  7 Apr 2021 14:39:58 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E73A0613EE;
 Wed,  7 Apr 2021 04:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617770396;
 bh=N3Nu902lLqMabzpP3jIJJSVcw/F9ZzXRkR/2BDkhn0w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mkghiKb/TBTyDQKVASTGY4puescI/g8Ka6CHJwdG6tbQeGizVY1xwowyJDjWvgA88
 xeQkgvLBIDsTttqtgvY///VP6Nt8izpjcpHlTAzNsKB3uA5muFA5lMd6GfDqEUNyNg
 /VQteInxIjDZZtqwW0aW8QRF3aPuc0miPPLhv+fu/CejCNEoCPbnqDalZd1AYwLF6B
 vHQpx797fMlU0dL5TkvZ1c+PrJHcOltXpALdo9CA1F6po2lInAcXotL/NWAxF54s7V
 Lxqh6/xvZT+ATioJrsZktF/JUEM/XIXVeAmMMIzZ0M6BbFgjAp2a5dNvnhOvPnXhSC
 n0mWJJkK7SrCQ==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
 Chao Yu <chao@kernel.org>
Subject: [PATCH v3 09/10] erofs: support decompress big pcluster for lz4
 backend
Date: Wed,  7 Apr 2021 12:39:26 +0800
Message-Id: <20210407043927.10623-10-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407043927.10623-1-xiang@kernel.org>
References: <20210407043927.10623-1-xiang@kernel.org>
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@redhat.com>

Prior to big pcluster, there was only one compressed page so it'd
easy to map this. However, when big pcluster is enabled, more work
needs to be done to handle multiple compressed pages. In detail,

 - (maptype 0) if there is only one compressed page + no need
   to copy inplace I/O, just map it directly what we did before;

 - (maptype 1) if there are more compressed pages + no need to
   copy inplace I/O, vmap such compressed pages instead;

 - (maptype 2) if inplace I/O needs to be copied, use per-CPU
   buffers for decompression then.

Another thing is how to detect inplace decompression is feasable or
not (it's still quite easy for non big pclusters), apart from the
inplace margin calculation, inplace I/O page reusing order is also
needed to be considered for each compressed page. Currently, if the
compressed page is the xth page, it shouldn't be reused as [0 ...
nrpages_out - nrpages_in + x], otherwise a full copy will be triggered.

Although there are some extra optimization ideas for this, I'd like
to make big pcluster work correctly first and obviously it can be
further optimized later since it has nothing with the on-disk format
at all.

Acked-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/decompressor.c | 217 +++++++++++++++++++++++-----------------
 fs/erofs/internal.h     |  15 +++
 2 files changed, 138 insertions(+), 94 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 900de4725d35..ff15461b389d 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -120,44 +120,84 @@ static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
 	return kaddr ? 1 : 0;
 }
 
-static void *generic_copy_inplace_data(struct z_erofs_decompress_req *rq,
-				       u8 *src, unsigned int pageofs_in)
+static void *z_erofs_handle_inplace_io(struct z_erofs_decompress_req *rq,
+			void *inpage, unsigned int *inputmargin, int *maptype,
+			bool support_0padding)
 {
-	/*
-	 * if in-place decompression is ongoing, those decompressed
-	 * pages should be copied in order to avoid being overlapped.
-	 */
-	struct page **in = rq->in;
-	u8 *const tmp = erofs_get_pcpubuf(1);
-	u8 *tmpp = tmp;
-	unsigned int inlen = rq->inputsize - pageofs_in;
-	unsigned int count = min_t(uint, inlen, PAGE_SIZE - pageofs_in);
-
-	while (tmpp < tmp + inlen) {
-		if (!src)
-			src = kmap_atomic(*in);
-		memcpy(tmpp, src + pageofs_in, count);
-		kunmap_atomic(src);
-		src = NULL;
-		tmpp += count;
-		pageofs_in = 0;
-		count = PAGE_SIZE;
+	unsigned int nrpages_in, nrpages_out;
+	unsigned int ofull, oend, inputsize, total, i, j;
+	struct page **in;
+	void *src, *tmp;
+
+	inputsize = rq->inputsize;
+	nrpages_in = PAGE_ALIGN(inputsize) >> PAGE_SHIFT;
+	oend = rq->pageofs_out + rq->outputsize;
+	ofull = PAGE_ALIGN(oend);
+	nrpages_out = ofull >> PAGE_SHIFT;
+
+	if (rq->inplace_io) {
+		if (rq->partial_decoding || !support_0padding ||
+		    ofull - oend < LZ4_DECOMPRESS_INPLACE_MARGIN(inputsize))
+			goto docopy;
+
+		for (i = 0; i < nrpages_in; ++i) {
+			DBG_BUGON(rq->in[i] == NULL);
+			for (j = 0; j < nrpages_out - nrpages_in + i; ++j)
+				if (rq->out[j] == rq->in[i])
+					goto docopy;
+		}
+	}
+
+	if (nrpages_in <= 1) {
+		*maptype = 0;
+		return inpage;
+	}
+	kunmap_atomic(inpage);
+	might_sleep();
+	src = erofs_vm_map_ram(rq->in, nrpages_in);
+	if (!src)
+		return ERR_PTR(-ENOMEM);
+	*maptype = 1;
+	return src;
+
+docopy:
+	/* Or copy compressed data which can be overlapped to per-CPU buffer */
+	in = rq->in;
+	src = erofs_get_pcpubuf(nrpages_in);
+	if (!src) {
+		DBG_BUGON(1);
+		return ERR_PTR(-EFAULT);
+	}
+
+	tmp = src;
+	total = rq->inputsize;
+	while (total) {
+		unsigned int page_copycnt =
+			min_t(unsigned int, total, PAGE_SIZE - *inputmargin);
+
+		if (!inpage)
+			inpage = kmap_atomic(*in);
+		memcpy(tmp, inpage + *inputmargin, page_copycnt);
+		kunmap_atomic(inpage);
+		inpage = NULL;
+		tmp += page_copycnt;
+		total -= page_copycnt;
 		++in;
+		*inputmargin = 0;
 	}
-	return tmp;
+	*maptype = 2;
+	return src;
 }
 
 static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 {
-	unsigned int inputmargin, inlen;
-	u8 *src;
-	bool copied, support_0padding;
-	int ret;
-
-	if (rq->inputsize > PAGE_SIZE)
-		return -EOPNOTSUPP;
+	unsigned int inputmargin;
+	u8 *headpage, *src;
+	bool support_0padding;
+	int ret, maptype;
 
-	src = kmap_atomic(*rq->in);
+	DBG_BUGON(*rq->in == NULL);
+	headpage = kmap_atomic(*rq->in);
 	inputmargin = 0;
 	support_0padding = false;
 
@@ -165,50 +205,39 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 	if (erofs_sb_has_lz4_0padding(EROFS_SB(rq->sb))) {
 		support_0padding = true;
 
-		while (!src[inputmargin & ~PAGE_MASK])
+		while (!headpage[inputmargin & ~PAGE_MASK])
 			if (!(++inputmargin & ~PAGE_MASK))
 				break;
 
 		if (inputmargin >= rq->inputsize) {
-			kunmap_atomic(src);
+			kunmap_atomic(headpage);
 			return -EIO;
 		}
 	}
 
-	copied = false;
-	inlen = rq->inputsize - inputmargin;
-	if (rq->inplace_io) {
-		const uint oend = (rq->pageofs_out +
-				   rq->outputsize) & ~PAGE_MASK;
-		const uint nr = PAGE_ALIGN(rq->pageofs_out +
-					   rq->outputsize) >> PAGE_SHIFT;
-
-		if (rq->partial_decoding || !support_0padding ||
-		    rq->out[nr - 1] != rq->in[0] ||
-		    rq->inputsize - oend <
-		      LZ4_DECOMPRESS_INPLACE_MARGIN(inlen)) {
-			src = generic_copy_inplace_data(rq, src, inputmargin);
-			inputmargin = 0;
-			copied = true;
-		}
+	rq->inputsize -= inputmargin;
+	src = z_erofs_handle_inplace_io(rq, headpage, &inputmargin, &maptype,
+					support_0padding);
+	if (IS_ERR(src)) {
+		kunmap_atomic(headpage);
+		return PTR_ERR(src);
 	}
 
 	/* legacy format could compress extra data in a pcluster. */
 	if (rq->partial_decoding || !support_0padding)
 		ret = LZ4_decompress_safe_partial(src + inputmargin, out,
-						  inlen, rq->outputsize,
-						  rq->outputsize);
+				rq->inputsize, rq->outputsize, rq->outputsize);
 	else
 		ret = LZ4_decompress_safe(src + inputmargin, out,
-					  inlen, rq->outputsize);
+					  rq->inputsize, rq->outputsize);
 
 	if (ret != rq->outputsize) {
 		erofs_err(rq->sb, "failed to decompress %d in[%u, %u] out[%u]",
-			  ret, inlen, inputmargin, rq->outputsize);
+			  ret, rq->inputsize, inputmargin, rq->outputsize);
 
 		WARN_ON(1);
 		print_hex_dump(KERN_DEBUG, "[ in]: ", DUMP_PREFIX_OFFSET,
-			       16, 1, src + inputmargin, inlen, true);
+			       16, 1, src + inputmargin, rq->inputsize, true);
 		print_hex_dump(KERN_DEBUG, "[out]: ", DUMP_PREFIX_OFFSET,
 			       16, 1, out, rq->outputsize, true);
 
@@ -217,10 +246,16 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 		ret = -EIO;
 	}
 
-	if (copied)
-		erofs_put_pcpubuf(src);
-	else
+	if (maptype == 0) {
 		kunmap_atomic(src);
+	} else if (maptype == 1) {
+		vm_unmap_ram(src, PAGE_ALIGN(rq->inputsize) >> PAGE_SHIFT);
+	} else if (maptype == 2) {
+		erofs_put_pcpubuf(src);
+	} else {
+		DBG_BUGON(1);
+		return -EFAULT;
+	}
 	return ret;
 }
 
@@ -270,57 +305,51 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
 	const struct z_erofs_decompressor *alg = decompressors + rq->alg;
 	unsigned int dst_maptype;
 	void *dst;
-	int ret, i;
+	int ret;
 
-	if (nrpages_out == 1 && !rq->inplace_io) {
-		DBG_BUGON(!*rq->out);
-		dst = kmap_atomic(*rq->out);
-		dst_maptype = 0;
-		goto dstmap_out;
-	}
+	/* two optimized fast paths only for non bigpcluster cases yet */
+	if (rq->inputsize <= PAGE_SIZE) {
+		if (nrpages_out == 1 && !rq->inplace_io) {
+			DBG_BUGON(!*rq->out);
+			dst = kmap_atomic(*rq->out);
+			dst_maptype = 0;
+			goto dstmap_out;
+		}
 
-	/*
-	 * For the case of small output size (especially much less
-	 * than PAGE_SIZE), memcpy the decompressed data rather than
-	 * compressed data is preferred.
-	 */
-	if (rq->outputsize <= PAGE_SIZE * 7 / 8) {
-		dst = erofs_get_pcpubuf(1);
-		if (IS_ERR(dst))
-			return PTR_ERR(dst);
-
-		rq->inplace_io = false;
-		ret = alg->decompress(rq, dst);
-		if (!ret)
-			copy_from_pcpubuf(rq->out, dst, rq->pageofs_out,
-					  rq->outputsize);
-
-		erofs_put_pcpubuf(dst);
-		return ret;
+		/*
+		 * For the case of small output size (especially much less
+		 * than PAGE_SIZE), memcpy the decompressed data rather than
+		 * compressed data is preferred.
+		 */
+		if (rq->outputsize <= PAGE_SIZE * 7 / 8) {
+			dst = erofs_get_pcpubuf(1);
+			if (IS_ERR(dst))
+				return PTR_ERR(dst);
+
+			rq->inplace_io = false;
+			ret = alg->decompress(rq, dst);
+			if (!ret)
+				copy_from_pcpubuf(rq->out, dst, rq->pageofs_out,
+						  rq->outputsize);
+
+			erofs_put_pcpubuf(dst);
+			return ret;
+		}
 	}
 
+	/* general decoding path which can be used for all cases */
 	ret = alg->prepare_destpages(rq, pagepool);
-	if (ret < 0) {
+	if (ret < 0)
 		return ret;
-	} else if (ret) {
+	if (ret) {
 		dst = page_address(*rq->out);
 		dst_maptype = 1;
 		goto dstmap_out;
 	}
 
-	i = 0;
-	while (1) {
-		dst = vm_map_ram(rq->out, nrpages_out, -1);
-
-		/* retry two more times (totally 3 times) */
-		if (dst || ++i >= 3)
-			break;
-		vm_unmap_aliases();
-	}
-
+	dst = erofs_vm_map_ram(rq->out, nrpages_out);
 	if (!dst)
 		return -ENOMEM;
-
 	dst_maptype = 2;
 
 dstmap_out:
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index f1305af50f67..cb48f9dc50d5 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -402,6 +402,21 @@ int erofs_namei(struct inode *dir, struct qstr *name,
 /* dir.c */
 extern const struct file_operations erofs_dir_fops;
 
+static inline void *erofs_vm_map_ram(struct page **pages, unsigned int count)
+{
+	int retried = 0;
+
+	while (1) {
+		void *p = vm_map_ram(pages, count, -1);
+
+		/* retry two more times (totally 3 times) */
+		if (p || ++retried >= 3)
+			return p;
+		vm_unmap_aliases();
+	}
+	return NULL;
+}
+
 /* pcpubuf.c */
 void *erofs_get_pcpubuf(unsigned int requiredpages);
 void erofs_put_pcpubuf(void *ptr);
-- 
2.20.1

