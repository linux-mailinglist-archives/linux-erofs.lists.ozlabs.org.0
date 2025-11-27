Return-Path: <linux-erofs+bounces-1439-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8EBC8D1B4
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Nov 2025 08:31:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dH7R15Q1yz2yx7;
	Thu, 27 Nov 2025 18:31:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764228701;
	cv=none; b=LZR7Y75vhsQ7K0651M+TsLCWgO/mD4N/MVfWd1cU4LNQKnFhFLmNODjNSH1O0empkhWuZr8ODZ2sIb0MQ/+vfyD0LoflUEAzqpG7d+ZSYbuW5d3ZTJNlRojxQSgbjb5Gnka1t+iopOV1VfcWBlf3qSytxtrJUsS5PqG9wndo7SloTb/uJn0SphiOwFzPRPSHcT6NJwt1nYpNdGFzMt4ADfqC1TrcmKlj39K/0NgCWzjso8kKIYyyZnf1p23J9Wkvu3wtcAP5fqQpwbDCsj6M3YntYOIy314H1FpWW/xJrJcq064xwcGzSnVfJVhpXGENqocJ3IRZXu2HEEl/JztUEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764228701; c=relaxed/relaxed;
	bh=mnm/SyF5+AnakOhGEYOeFuZGqAHAdF95wHRRpNISF90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yd9T5rKQBefW05TAZpWgKsNOOG34tsmDtKQGgNTfNP9pvX2ueRT6LsPryAX4mbNo2a3xZF4HQyxkO3cMaTteiuYoOdWVjh7afiiOe8Qx+I2nvtLqWlwaHV4LrtqsBaFbtoU2r/XHdVhRsfqvWva/qOcSu5g5KSQCGwU0v9E8HBTQB6J+hv79Q1gHONooFybHGuEc+SNjV8UIZT0Qrm6+IdJFzpVAsuO+k1oSFzuGIaygEletFLCyxjJLabcYnvUjbRe4iSzmQzFoAt9/wgUtEsO6D+M25lANoFrjdEyWNsgqDWxTTZWN5nDZvtSVa5OUFaaKaTBcH6NmE2vXuKWZrg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wgA2mzvI; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wgA2mzvI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dH7Qy0JWlz2yx8
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Nov 2025 18:31:36 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764228691; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=mnm/SyF5+AnakOhGEYOeFuZGqAHAdF95wHRRpNISF90=;
	b=wgA2mzvIu9Yc+jA0iESThdURVfL4onWSEBv+lETjAGFlizSAS2UmpzHAG5luZPyXMseS7v7BBBLXymTtixvpfWBeZbNUg4256cHTEZjwntlCtn8eflBlk+vmkig5Nw6uXb6uxMefQ6fAJOXPp3kHQax1925cUnMDePgY0o9N+Es=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WtWGgGK_1764228689 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 27 Nov 2025 15:31:29 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 3/4] erofs: enable error reporting for z_erofs_stream_switch_bufs()
Date: Thu, 27 Nov 2025 15:31:21 +0800
Message-ID: <20251127073122.2542542-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251127073122.2542542-1-hsiangkao@linux.alibaba.com>
References: <20251127073122.2542542-1-hsiangkao@linux.alibaba.com>
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
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Enable propagation of detailed errors to callers.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/compress.h             |  4 ++--
 fs/erofs/decompressor.c         | 23 +++++++++--------------
 fs/erofs/decompressor_deflate.c |  4 ++--
 fs/erofs/decompressor_lzma.c    |  6 +++---
 fs/erofs/decompressor_zstd.c    |  4 ++--
 5 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index 1ee4ad934c1f..91dbc8bb5ddf 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -70,8 +70,8 @@ struct z_erofs_stream_dctx {
 	bool bounced;			/* is the bounce buffer used now? */
 };
 
-int z_erofs_stream_switch_bufs(struct z_erofs_stream_dctx *dctx, void **dst,
-			       void **src, struct page **pgpl);
+const char *z_erofs_stream_switch_bufs(struct z_erofs_stream_dctx *dctx,
+				void **dst, void **src, struct page **pgpl);
 int z_erofs_fixup_insize(struct z_erofs_decompress_req *rq, const char *padbuf,
 			 unsigned int padbufsize);
 int __init z_erofs_init_decompressor(void);
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index f9d29f43666f..638b5f87bd0c 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -342,19 +342,16 @@ static const char *z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
 	return NULL;
 }
 
-int z_erofs_stream_switch_bufs(struct z_erofs_stream_dctx *dctx, void **dst,
-			       void **src, struct page **pgpl)
+const char *z_erofs_stream_switch_bufs(struct z_erofs_stream_dctx *dctx,
+				void **dst, void **src, struct page **pgpl)
 {
 	struct z_erofs_decompress_req *rq = dctx->rq;
-	struct super_block *sb = rq->sb;
 	struct page **pgo, *tmppage;
 	unsigned int j;
 
 	if (!dctx->avail_out) {
-		if (++dctx->no >= rq->outpages || !rq->outputsize) {
-			erofs_err(sb, "insufficient space for decompressed data");
-			return -EFSCORRUPTED;
-		}
+		if (++dctx->no >= rq->outpages || !rq->outputsize)
+			return "insufficient space for decompressed data";
 
 		if (dctx->kout)
 			kunmap_local(dctx->kout);
@@ -365,7 +362,7 @@ int z_erofs_stream_switch_bufs(struct z_erofs_stream_dctx *dctx, void **dst,
 			*pgo = erofs_allocpage(pgpl, rq->gfp);
 			if (!*pgo) {
 				dctx->kout = NULL;
-				return -ENOMEM;
+				return ERR_PTR(-ENOMEM);
 			}
 			set_page_private(*pgo, Z_EROFS_SHORTLIVED_PAGE);
 		}
@@ -379,10 +376,8 @@ int z_erofs_stream_switch_bufs(struct z_erofs_stream_dctx *dctx, void **dst,
 	}
 
 	if (dctx->inbuf_pos == dctx->inbuf_sz && rq->inputsize) {
-		if (++dctx->ni >= rq->inpages) {
-			erofs_err(sb, "invalid compressed data");
-			return -EFSCORRUPTED;
-		}
+		if (++dctx->ni >= rq->inpages)
+			return "invalid compressed data";
 		if (dctx->kout) /* unlike kmap(), take care of the orders */
 			kunmap_local(dctx->kout);
 		kunmap_local(dctx->kin);
@@ -417,12 +412,12 @@ int z_erofs_stream_switch_bufs(struct z_erofs_stream_dctx *dctx, void **dst,
 			continue;
 		tmppage = erofs_allocpage(pgpl, rq->gfp);
 		if (!tmppage)
-			return -ENOMEM;
+			return ERR_PTR(-ENOMEM);
 		set_page_private(tmppage, Z_EROFS_SHORTLIVED_PAGE);
 		copy_highpage(tmppage, rq->in[j]);
 		rq->in[j] = tmppage;
 	}
-	return 0;
+	return NULL;
 }
 
 const struct z_erofs_decompressor *z_erofs_decomp[] = {
diff --git a/fs/erofs/decompressor_deflate.c b/fs/erofs/decompressor_deflate.c
index 46cc1fd19bce..afc73abd8db5 100644
--- a/fs/erofs/decompressor_deflate.c
+++ b/fs/erofs/decompressor_deflate.c
@@ -144,10 +144,10 @@ static const char *__z_erofs_deflate_decompress(struct z_erofs_decompress_req *r
 	while (1) {
 		dctx.avail_out = strm->z.avail_out;
 		dctx.inbuf_sz = strm->z.avail_in;
-		err = z_erofs_stream_switch_bufs(&dctx,
+		reason = z_erofs_stream_switch_bufs(&dctx,
 					(void **)&strm->z.next_out,
 					(void **)&strm->z.next_in, pgpl);
-		if (err)
+		if (reason)
 			break;
 		strm->z.avail_out = dctx.avail_out;
 		strm->z.avail_in = dctx.inbuf_sz;
diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
index 98a8c22cdbde..0161f3375efd 100644
--- a/fs/erofs/decompressor_lzma.c
+++ b/fs/erofs/decompressor_lzma.c
@@ -189,9 +189,9 @@ static const char *z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 		dctx.avail_out = buf.out_size - buf.out_pos;
 		dctx.inbuf_sz = buf.in_size;
 		dctx.inbuf_pos = buf.in_pos;
-		err = z_erofs_stream_switch_bufs(&dctx, (void **)&buf.out,
-						 (void **)&buf.in, pgpl);
-		if (err)
+		reason = z_erofs_stream_switch_bufs(&dctx, (void **)&buf.out,
+						    (void **)&buf.in, pgpl);
+		if (reason)
 			break;
 
 		if (buf.out_size == buf.out_pos) {
diff --git a/fs/erofs/decompressor_zstd.c b/fs/erofs/decompressor_zstd.c
index aff6825cacde..ae51faeb504d 100644
--- a/fs/erofs/decompressor_zstd.c
+++ b/fs/erofs/decompressor_zstd.c
@@ -175,9 +175,9 @@ static const char *z_erofs_zstd_decompress(struct z_erofs_decompress_req *rq,
 	do {
 		dctx.inbuf_sz = in_buf.size;
 		dctx.inbuf_pos = in_buf.pos;
-		err = z_erofs_stream_switch_bufs(&dctx, &out_buf.dst,
+		reason = z_erofs_stream_switch_bufs(&dctx, &out_buf.dst,
 						 (void **)&in_buf.src, pgpl);
-		if (err)
+		if (reason)
 			break;
 
 		if (out_buf.size == out_buf.pos) {
-- 
2.43.5


