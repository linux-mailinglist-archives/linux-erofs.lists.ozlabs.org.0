Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C827E5A35AE
	for <lists+linux-erofs@lfdr.de>; Sat, 27 Aug 2022 09:48:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MF8305Jndz2y2B
	for <lists+linux-erofs@lfdr.de>; Sat, 27 Aug 2022 17:48:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=R0ELpqCj;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=R0ELpqCj;
	dkim-atps=neutral
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MF82s2rvrz2xHH
	for <linux-erofs@lists.ozlabs.org>; Sat, 27 Aug 2022 17:48:37 +1000 (AEST)
Received: by mail-pj1-x102d.google.com with SMTP id w88-20020a17090a6be100b001fbb0f0b013so3993932pjj.5
        for <linux-erofs@lists.ozlabs.org>; Sat, 27 Aug 2022 00:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc;
        bh=k4xOaCJXR13lMOpKa8KBEBvxrHZTljSJsyP8ZiT7jOE=;
        b=R0ELpqCjrsYaqO/7g3nQd5LYZgbXeKZI2ZSbQ5bovwxqA8ASQ4fGIe23pOappKXsW4
         BBje2Q+FRxY/u3bOF6mxm+kQrdn8bwCU0UMvYtxW5Fx/ibcRMFeqQGhiSsIyv5uuhuUn
         objrh6OJ7Pk4s2YfUWc2J4Xt79l+pMTQPiTiJeag8RnGtlX7sMFGs9L7ugHq/RczAtON
         A9YIuofw7xZKuYmXJ6Y2qnUJxFxr0VXSP73EPlp5q/huahkV5zuSn8P9uD15vCnw2Vci
         42H62nMnzl2EPd/HJGUQnI7yLpzJXXFpDL3WXR3L11vQLZ/m1kSpYaDaDoW/jRdRdRSZ
         6oqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=k4xOaCJXR13lMOpKa8KBEBvxrHZTljSJsyP8ZiT7jOE=;
        b=DpROYgpTZ5DrVAty9hL4cMIMjJXnPhCINSIJQZAtLN3Oz3dAJWSy10rXXp5O0i5IEP
         Xkh4Ge4AQpNklx4QCgxQkLgMETiJDoHCnoOzB+FOJupddRZX+Ub1p5njg/JvmDljVS+e
         gjmZRm5+QbAwwwg2ojRXK3o9moVs8fa3Pffe/FquHnrghiCtk+bU3XxbP2JzRFVPEODv
         u4J5h/r0lZMCjcGgi07JSc1HVeX1JYv9zpz8puyFcX2Zfy3Tgtn8x/lAlWTlg/egzP3Z
         ubc3RWuflMHAzOVpaLuXt7ee2UoPiNv/tYr9lnVLFql1HkuRHUz45AWzDdxjaGLGTlYQ
         zxCA==
X-Gm-Message-State: ACgBeo1czZ3fSN4pl9kM2Qlgqidip6JoaMsz1CxYH4iNPPxqZ5n0x7yz
	AGmgmkCysNjHsJwNXHMA/wg=
X-Google-Smtp-Source: AA6agR6HIkTg+FLYs2FEJWzVTEf40XbCuU/Hh6tLVt36rql5TChqT3b0a7AjnR+jCgYZgkl3AcXP/g==
X-Received: by 2002:a17:902:e80e:b0:173:23e:d5a6 with SMTP id u14-20020a170902e80e00b00173023ed5a6mr6996841plg.85.1661586514951;
        Sat, 27 Aug 2022 00:48:34 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id q4-20020a656844000000b0042aaaf6e2d9sm2632006pgt.49.2022.08.27.00.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 00:48:34 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org
Subject: [RFC PATCH v2 1/2] erofs: support interlaced uncompressed data for compressed files
Date: Sat, 27 Aug 2022 15:47:56 +0800
Message-Id: <014ae4b2548bb318a4f187c7dad59867721bf418.1661584151.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1661584151.git.huyue2@coolpad.com>
References: <cover.1661584151.git.huyue2@coolpad.com>
In-Reply-To: <cover.1661584151.git.huyue2@coolpad.com>
References: <cover.1661584151.git.huyue2@coolpad.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, shaojunjun@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

Currently, there is no start offset when writing uncompressed data to
disk blocks for compressed files. However, we are using in-place I/O
which will decrease the number of memory copies a lot if we write it
just from an offset of 'pageofs_out'. So, let's support it.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/compress.h     |  3 +++
 fs/erofs/decompressor.c | 12 +++++++-----
 fs/erofs/erofs_fs.h     |  2 ++
 fs/erofs/zdata.c        | 11 ++++++++++-
 fs/erofs/zdata.h        |  3 +++
 5 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index 26fa170090b8..cef26c63d6b1 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -15,6 +15,9 @@ struct z_erofs_decompress_req {
 	unsigned short pageofs_in, pageofs_out;
 	unsigned int inputsize, outputsize;
 
+	/* cut point of interlaced uncompressed data */
+	unsigned int interlaced_offset;
+
 	/* indicate the algorithm will be used for decompression */
 	unsigned int alg;
 	bool inplace_io, partial_decoding, fillgaps;
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 2d55569f96ac..e5dc8eb992b1 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -340,18 +340,20 @@ static int z_erofs_shifted_transform(struct z_erofs_decompress_req *rq,
 	src = kmap_atomic(*rq->in) + rq->pageofs_in;
 	if (rq->out[0]) {
 		dst = kmap_atomic(rq->out[0]);
-		memcpy(dst + rq->pageofs_out, src, righthalf);
+		memcpy(dst + rq->pageofs_out, src + rq->interlaced_offset,
+		       righthalf);
 		kunmap_atomic(dst);
 	}
 
 	if (nrpages_out == 2) {
 		DBG_BUGON(!rq->out[1]);
-		if (rq->out[1] == *rq->in) {
-			memmove(src, src + righthalf, lefthalf);
-		} else {
+		if (rq->out[1] != *rq->in) {
 			dst = kmap_atomic(rq->out[1]);
-			memcpy(dst, src + righthalf, lefthalf);
+			memcpy(dst, rq->interlaced_offset ? src :
+						(src + righthalf), lefthalf);
 			kunmap_atomic(dst);
+		} else if (!rq->interlaced_offset) {
+			memmove(src, src + righthalf, lefthalf);
 		}
 	}
 	kunmap_atomic(src);
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 2b48373f690b..5c1de6d7ad71 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -295,11 +295,13 @@ struct z_erofs_lzma_cfgs {
  * bit 1 : HEAD1 big pcluster (0 - off; 1 - on)
  * bit 2 : HEAD2 big pcluster (0 - off; 1 - on)
  * bit 3 : tailpacking inline pcluster (0 - off; 1 - on)
+ * bit 4 : interlaced plain pcluster (0 - off; 1 - on)
  */
 #define Z_EROFS_ADVISE_COMPACTED_2B		0x0001
 #define Z_EROFS_ADVISE_BIG_PCLUSTER_1		0x0002
 #define Z_EROFS_ADVISE_BIG_PCLUSTER_2		0x0004
 #define Z_EROFS_ADVISE_INLINE_PCLUSTER		0x0008
+#define Z_EROFS_ADVISE_INTERLACED_PCLUSTER	0x0010
 
 struct z_erofs_map_header {
 	__le16	h_reserved1;
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 5792ca9e0d5e..4863d9d960d5 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -481,6 +481,7 @@ static void z_erofs_try_to_claim_pcluster(struct z_erofs_decompress_frontend *f)
 
 static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 {
+	struct erofs_inode *const vi = EROFS_I(fe->inode);
 	struct erofs_map_blocks *map = &fe->map;
 	bool ztailpacking = map->m_flags & EROFS_MAP_META;
 	struct z_erofs_pcluster *pcl;
@@ -508,6 +509,11 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 	pcl->pageofs_out = map->m_la & ~PAGE_MASK;
 	fe->mode = Z_EROFS_PCLUSTER_FOLLOWED;
 
+	pcl->interlaced = false;
+	if ((vi->z_advise & Z_EROFS_ADVISE_INTERLACED_PCLUSTER) &&
+	    pcl->algorithmformat == Z_EROFS_COMPRESSION_SHIFTED)
+		pcl->interlaced = true;
+
 	/*
 	 * lock all primary followed works before visible to others
 	 * and mutex_trylock *never* fails for a new pcluster.
@@ -972,7 +978,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	struct erofs_sb_info *const sbi = EROFS_SB(be->sb);
 	struct z_erofs_pcluster *pcl = be->pcl;
 	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
-	unsigned int i, inputsize;
+	unsigned int i, inputsize, interlaced_offset;
 	int err2;
 	struct page *page;
 	bool overlapped;
@@ -1015,6 +1021,8 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	else
 		inputsize = pclusterpages * PAGE_SIZE;
 
+	interlaced_offset = pcl->interlaced ? pcl->pageofs_out : 0;
+
 	err = z_erofs_decompress(&(struct z_erofs_decompress_req) {
 					.sb = be->sb,
 					.in = be->compressed_pages,
@@ -1023,6 +1031,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 					.pageofs_out = pcl->pageofs_out,
 					.inputsize = inputsize,
 					.outputsize = pcl->length,
+					.interlaced_offset = interlaced_offset,
 					.alg = pcl->algorithmformat,
 					.inplace_io = overlapped,
 					.partial_decoding = pcl->partial,
diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index e7f04c4fbb81..75f3a52fc66f 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -87,6 +87,9 @@ struct z_erofs_pcluster {
 	/* L: indicate several pageofs_outs or not */
 	bool multibases;
 
+	/* I: whether interlaced uncompressed data or not */
+	bool interlaced;
+
 	/* A: compressed bvecs (can be cached or inplaced pages) */
 	struct z_erofs_bvec compressed_bvecs[];
 };
-- 
2.17.1

