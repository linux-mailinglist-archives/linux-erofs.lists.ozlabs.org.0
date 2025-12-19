Return-Path: <linux-erofs+bounces-1517-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8DBCCEAAA
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Dec 2025 07:43:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dXdKk0Yfqz2yFW;
	Fri, 19 Dec 2025 17:43:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766126634;
	cv=none; b=bYobkU4sYFdcHg/Sa5X6HhCjeiSEZ5uwL92hggVCLQxZn8MYmV5nUvGEnsuHW2acNWFI85oUc/rSabt/dbsXXbtQ+jI1XCnDKxi1ecouw78n3PvXLkyv/Wih+N37aOwISp4y0QxJd36jpbp4HGSj5he01hcWvlqgr/dcAEEh/Xwjb+4OZI8XBvsIJx9Y+N17plMLRqDSvf7TENrkqgf/+5tPtHEj64sagQ8bv+VBUmJFVzpC9FS74mZ2PBkGmUZo1Rr3kYCLDkfV/S0PCxAUeyQ8X+qZgmjtGOxRv61CfF1JZRPwXmzJOs2PzLVqXb8CzbKhAaABcwfgUlwpg/z/tA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766126634; c=relaxed/relaxed;
	bh=DB9DoLwj8cJ1DkyEcnLVgtFBXXvGE1oUmJ9kmFxl0lE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CIMKWjfg/W2grwAM0D96kJUm7VgmH6Mmjt0gkYPh+h8s/KcyHYKN+tReM+PauuKBAWGbptezN+miy2muEJhGYwZSXROtBiVT++1XtjDSs0XWQ359PLhjfhgKEUkuBQcITgE9lTihnnyDxLjgmlbEuGMAaM8GWATuCqyknu5dkkTJdeBBUvMy9I2CS+zJiJHcfaW47CJcdpygctYan5Thj4mrnd2GIBSxrcTJ+JLz8kSis+FgQV8rGejuYgrRweUrOlxxbH4t++5om/7avJlIjo1McqLpPCnUqL/R9LotL3JeYBHh9WA5ypUQbMVOhA+VHpbcrWiSICSJUf6VcTqmAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=miWp647h; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=miWp647h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dXdKg3Gp2z2xfK
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 Dec 2025 17:43:49 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766126622; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=DB9DoLwj8cJ1DkyEcnLVgtFBXXvGE1oUmJ9kmFxl0lE=;
	b=miWp647hzBy3vjF8CKdiOG2/tyroK8tI5koW+YFyAw248ZsVblFUvV9os5++gUMcazJ20fDQSuw1jb+i3m3xNzf7xAxOecKwDGG1zPpA8CiDkGLRh3HhruHNMyac0PH6n2zYH1xRICT+nQVEI+IPpUq6ruPPgAxqs6n4FaEMY1A=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvBkRxm_1766126617 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 19 Dec 2025 14:43:40 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: improve LZ4 error strings
Date: Fri, 19 Dec 2025 14:43:36 +0800
Message-ID: <20251219064336.684930-1-hsiangkao@linux.alibaba.com>
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

Just like what was done for other algorithms, let's propagate detailed
error reasons for LZ4 instead of just -EFSCORRUPTED to users:

 "corrupted compressed data":
    the compressed data is malformed or
      destination buffer is not large enough

 "unexpected end of stream":
    the compressed stream ends normally, but without producing enough
    decompressed data.

 "compressed data start not found":
    can be returned by z_erofs_fixup_insize().

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/decompressor.c | 42 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index d5d090276391..fcbb2502dbf0 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -195,26 +195,25 @@ const char *z_erofs_fixup_insize(struct z_erofs_decompress_req *rq,
 	return NULL;
 }
 
-static int z_erofs_lz4_decompress_mem(struct z_erofs_decompress_req *rq, u8 *dst)
+static const char *__z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq,
+					    u8 *dst)
 {
-	bool support_0padding = false, may_inplace = false;
+	bool zeropadded = erofs_sb_has_zero_padding(EROFS_SB(rq->sb));
+	bool may_inplace = false;
 	unsigned int inputmargin;
 	u8 *out, *headpage, *src;
 	const char *reason;
 	int ret, maptype;
 
-	DBG_BUGON(*rq->in == NULL);
 	headpage = kmap_local_page(*rq->in);
-
 	/* LZ4 decompression inplace is only safe if zero_padding is enabled */
-	if (erofs_sb_has_zero_padding(EROFS_SB(rq->sb))) {
-		support_0padding = true;
+	if (zeropadded) {
 		reason = z_erofs_fixup_insize(rq, headpage + rq->pageofs_in,
 				min_t(unsigned int, rq->inputsize,
 				      rq->sb->s_blocksize - rq->pageofs_in));
 		if (reason) {
 			kunmap_local(headpage);
-			return IS_ERR(reason) ? PTR_ERR(reason) : -EFSCORRUPTED;
+			return reason;
 		}
 		may_inplace = !((rq->pageofs_in + rq->inputsize) &
 				(rq->sb->s_blocksize - 1));
@@ -224,26 +223,24 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_decompress_req *rq, u8 *dst
 	src = z_erofs_lz4_handle_overlap(rq, headpage, dst, &inputmargin,
 					 &maptype, may_inplace);
 	if (IS_ERR(src))
-		return PTR_ERR(src);
+		return ERR_CAST(src);
 
 	out = dst + rq->pageofs_out;
 	/* legacy format could compress extra data in a pcluster. */
-	if (rq->partial_decoding || !support_0padding)
+	if (rq->partial_decoding || !zeropadded)
 		ret = LZ4_decompress_safe_partial(src + inputmargin, out,
 				rq->inputsize, rq->outputsize, rq->outputsize);
 	else
 		ret = LZ4_decompress_safe(src + inputmargin, out,
 					  rq->inputsize, rq->outputsize);
+	if (ret == rq->outputsize)
+		reason = NULL;
+	else if (ret < 0)
+		reason = "corrupted compressed data";
+	else
+		reason = "unexpected end of stream";
 
-	if (ret != rq->outputsize) {
-		if (ret >= 0)
-			memset(out + ret, 0, rq->outputsize - ret);
-		ret = -EFSCORRUPTED;
-	} else {
-		ret = 0;
-	}
-
-	if (maptype == 0) {
+	if (!maptype) {
 		kunmap_local(headpage);
 	} else if (maptype == 1) {
 		vm_unmap_ram(src, rq->inpages);
@@ -251,15 +248,16 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_decompress_req *rq, u8 *dst
 		z_erofs_put_gbuf(src);
 	} else if (maptype != 3) {
 		DBG_BUGON(1);
-		return -EFAULT;
+		return ERR_PTR(-EFAULT);
 	}
-	return ret;
+	return reason;
 }
 
 static const char *z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq,
 					  struct page **pagepool)
 {
 	unsigned int dst_maptype;
+	const char *reason;
 	void *dst;
 	int ret;
 
@@ -283,12 +281,12 @@ static const char *z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq,
 			dst_maptype = 2;
 		}
 	}
-	ret = z_erofs_lz4_decompress_mem(rq, dst);
+	reason = __z_erofs_lz4_decompress(rq, dst);
 	if (!dst_maptype)
 		kunmap_local(dst);
 	else if (dst_maptype == 2)
 		vm_unmap_ram(dst, rq->outpages);
-	return ERR_PTR(ret);
+	return reason;
 }
 
 static const char *z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
-- 
2.43.5


