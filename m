Return-Path: <linux-erofs+bounces-1434-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0C8C86150
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Nov 2025 18:01:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dG89F0Pbdz2yG5;
	Wed, 26 Nov 2025 04:01:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764090081;
	cv=none; b=bz/WX2LCziVV9ojBWmNHdN1oMpFJfdhak2dyH5HgNF0WQUAlq0Ch4G8x3s0nFQ2m4EpVip+bRerTBZtZ653lu6cOtvJti8laDu+0jYT1zLwVa5wNwPh6XN+Y+WKgDK4zuGkeVkbA7rSzP/ybYUFyMvKEWTBnkkYWqMYR82wp962WR4fKPQq0s2PAHawA9lwH5RSiB7+m9WcLGXh1vs8Y+G27cEHv4WCgBwzfEPQAdQUCDIFYxY+yVCPv/vzOWlwm4fgQ6z5vyCvIWWcCccGcSQmmG9t6su8Ss+zGV8aCzuu/Rj7UW6XHw77BVqwzWVCXQlU8vooWr2LFsQ9DLC40jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764090081; c=relaxed/relaxed;
	bh=Tro2eiXSL6EiV/om/2cjVBkgx7lHHnAf4trK1SQkwCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WQsJJR8aayXR8lW+6fo1bs+1iwFXRwDOI5Wvk3tah/QU2uHl2yJlqV7rSw9N3Hu51Zk+Qc5fexlUjiq3Y5pbnYruKxO1P/LkwjkYCxzCmJSz6DPk95FhsYjV01GXUz3NKbFN3jnqnx9mnURkNh5IDfyP0rGF+L/dScEma19jyjpRWhM0xTAOiLlO10qwSO6bECT6AmBZNmIQkFFwcK8X+pkqlzVfT3fVTtSOP/USmOZBiIwd4kpf91M3pp+3Trh34a2OpNikqx83fD2+sDjWXVptIGBtc5354Ai+TOdXI4d8nKgPG/bvZWABysYUXvFywysoT6zP6nsWbsl656xgXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=F2u/Mi68; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=F2u/Mi68;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dG89B4ZLXz2xqk
	for <linux-erofs@lists.ozlabs.org>; Wed, 26 Nov 2025 04:01:16 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764090071; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Tro2eiXSL6EiV/om/2cjVBkgx7lHHnAf4trK1SQkwCk=;
	b=F2u/Mi68ADHa6iKWe0XyonVIfXvOgDrB2KVGgshhfyDtJfOSxmRzGHbiYYO7wCJzHDnQixJzLelXcFEB59dsHOp2cGLKaG5PCLaqdB7q3ANqV02K+M55VhJebVY4rjx0UI+h6NxJVhUUof5+kW+sH+hrFMKQXvNpQuBd5xkNO64=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WtOkaCN_1764090063 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 26 Nov 2025 01:01:08 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: tidy up z_erofs_lz4_handle_overlap()
Date: Wed, 26 Nov 2025 01:01:02 +0800
Message-ID: <20251125170102.3604700-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

 - Add some useful comments to explain inplace I/Os and decompression;

 - Rearrange the code to get rid of one unnecessary goto.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/decompressor.c | 85 ++++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 39 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 354762c9723f..2f4cef67cf64 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -105,44 +105,58 @@ static int z_erofs_lz4_prepare_dstpages(struct z_erofs_decompress_req *rq,
 	return kaddr ? 1 : 0;
 }
 
-static void *z_erofs_lz4_handle_overlap(struct z_erofs_decompress_req *rq,
+static void *z_erofs_lz4_handle_overlap(const struct z_erofs_decompress_req *rq,
 			void *inpage, void *out, unsigned int *inputmargin,
 			int *maptype, bool may_inplace)
 {
-	unsigned int oend, omargin, total, i;
+	unsigned int oend, omargin, cnt, i;
 	struct page **in;
-	void *src, *tmp;
-
-	if (rq->inplace_io) {
-		oend = rq->pageofs_out + rq->outputsize;
-		omargin = PAGE_ALIGN(oend) - oend;
-		if (rq->partial_decoding || !may_inplace ||
-		    omargin < LZ4_DECOMPRESS_INPLACE_MARGIN(rq->inputsize))
-			goto docopy;
+	void *src;
 
+	/*
+	 * If in-place I/O isn't used, for example, the bounce compressed cache
+	 * can hold data for incomplete read requests. Just map the compressed
+	 * buffer as well and decompress directly.
+	 */
+	if (!rq->inplace_io) {
+		if (rq->inpages <= 1) {
+			*maptype = 0;
+			return inpage;
+		}
+		kunmap_local(inpage);
+		src = erofs_vm_map_ram(rq->in, rq->inpages);
+		if (!src)
+			return ERR_PTR(-ENOMEM);
+		*maptype = 1;
+		return src;
+	}
+	/*
+	 * Then, deal with in-place I/Os. The reasons why in-place I/O is useful
+	 * are: (1) It minimizes memory footprint during the I/O submission,
+	 * which is useful for slow storage (including network devices and
+	 * low-end HDDs/eMMCs) but with a lot inflight I/Os; (2) If in-place
+	 * decompression can also be applied, it will reuse the unique buffer so
+	 * that no extra CPU D-cache is polluted with temporary compressed data
+	 * for extreme performance.
+	 */
+	oend = rq->pageofs_out + rq->outputsize;
+	omargin = PAGE_ALIGN(oend) - oend;
+	if (!rq->partial_decoding && may_inplace &&
+	    omargin >= LZ4_DECOMPRESS_INPLACE_MARGIN(rq->inputsize)) {
 		for (i = 0; i < rq->inpages; ++i)
 			if (rq->out[rq->outpages - rq->inpages + i] !=
 			    rq->in[i])
-				goto docopy;
-		kunmap_local(inpage);
-		*maptype = 3;
-		return out + ((rq->outpages - rq->inpages) << PAGE_SHIFT);
-	}
-
-	if (rq->inpages <= 1) {
-		*maptype = 0;
-		return inpage;
+				break;
+		if (i >= rq->inpages) {
+			kunmap_local(inpage);
+			*maptype = 3;
+			return out + ((rq->outpages - rq->inpages) << PAGE_SHIFT);
+		}
 	}
-	kunmap_local(inpage);
-	src = erofs_vm_map_ram(rq->in, rq->inpages);
-	if (!src)
-		return ERR_PTR(-ENOMEM);
-	*maptype = 1;
-	return src;
-
-docopy:
-	/* Or copy compressed data which can be overlapped to per-CPU buffer */
-	in = rq->in;
+	/*
+	 * If in-place decompression can't be applied, copy compressed data that
+	 * may potentially overlap during decompression to a per-CPU buffer.
+	 */
 	src = z_erofs_get_gbuf(rq->inpages);
 	if (!src) {
 		DBG_BUGON(1);
@@ -150,20 +164,13 @@ static void *z_erofs_lz4_handle_overlap(struct z_erofs_decompress_req *rq,
 		return ERR_PTR(-EFAULT);
 	}
 
-	tmp = src;
-	total = rq->inputsize;
-	while (total) {
-		unsigned int page_copycnt =
-			min_t(unsigned int, total, PAGE_SIZE - *inputmargin);
-
+	for (i = 0, in = rq->in; i < rq->inputsize; i += cnt, ++in) {
+		cnt = min_t(u32, rq->inputsize - i, PAGE_SIZE - *inputmargin);
 		if (!inpage)
 			inpage = kmap_local_page(*in);
-		memcpy(tmp, inpage + *inputmargin, page_copycnt);
+		memcpy(src + i, inpage + *inputmargin, cnt);
 		kunmap_local(inpage);
 		inpage = NULL;
-		tmp += page_copycnt;
-		total -= page_copycnt;
-		++in;
 		*inputmargin = 0;
 	}
 	*maptype = 2;
-- 
2.43.5


