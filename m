Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FF3350D17
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Apr 2021 05:30:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F9pbm32FRz30D8
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Apr 2021 14:30:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lroptYsJ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=lroptYsJ; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F9pbj3wDtz303j
 for <linux-erofs@lists.ozlabs.org>; Thu,  1 Apr 2021 14:30:25 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C6B6610E7;
 Thu,  1 Apr 2021 03:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617247823;
 bh=uGWjJH85wbX6CbvuAjpt3Dm/EjLddOSVub+7avAm6o0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lroptYsJl6XmASMDGntb9Y3SX92ep55i8QD39zXZMjBCJ4m7JbsqPQlzI5ni5B8Ka
 J5/HX6c2XYOCYRzqKfH2mJq1Qh/IyIKQtJHsVRsCOFc4IcQ7hqu5eW7myypuoWACza
 PVVZkCKQ4TsCogCfjxtCnnWDo4zp7DxTKMFWzCLiLVHvCfWaLM8DyFuMU83u0/+leE
 BtQ6i+ARrGkTqSF+5ndHtFt7wAFfmeXPIp/T9y8O/eY56TH1sxAXe92Tj06dJh3uAh
 0vC+uBKuAhZSYgA2uXLLOaUF8o2wV4HlaY21CswMD8MwOKvIzmPqRZhQcRVRKcFdEQ
 jLStQbF5v0N2w==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
 Chao Yu <chao@kernel.org>
Subject: [PATCH v2 09/10] erofs: support decompress big pcluster for lz4
 backend
Date: Thu,  1 Apr 2021 11:29:53 +0800
Message-Id: <20210401032954.20555-10-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210401032954.20555-1-xiang@kernel.org>
References: <20210401032954.20555-1-xiang@kernel.org>
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

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/decompressor.c | 202 ++++++++++++++++++++++++----------------
 1 file changed, 122 insertions(+), 80 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 5d9f9dbd3681..c7b1d3fe8184 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -116,44 +116,87 @@ static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
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
+	while (1) {
+		src = vm_map_ram(rq->in, nrpages_in, -1);
+		/* retry two more times (totally 3 times) */
+		if (src || ++i >= 3)
+			break;
+		vm_unmap_aliases();
+	}
+	*maptype = 1;
+	return src;
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
+	unsigned int inputmargin;
+	u8 *headpage, *src;
+	bool support_0padding;
+	int ret, maptype;
 
-	if (rq->inputsize > PAGE_SIZE)
-		return -EOPNOTSUPP;
-
-	src = kmap_atomic(*rq->in);
+	DBG_BUGON(*rq->in == NULL);
+	headpage = kmap_atomic(*rq->in);
 	inputmargin = 0;
 	support_0padding = false;
 
@@ -161,50 +204,39 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
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
 
@@ -213,10 +245,16 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
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
 
@@ -268,33 +306,37 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
 	void *dst;
 	int ret, i;
 
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
 	if (ret < 0) {
 		return ret;
-- 
2.20.1

