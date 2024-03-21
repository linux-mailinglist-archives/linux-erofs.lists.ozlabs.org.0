Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A36BB881CB5
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Mar 2024 08:03:07 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sijam-com.20230601.gappssmtp.com header.i=@sijam-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=fBp9aT/9;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V0byK08GTz3dDq
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Mar 2024 18:03:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sijam-com.20230601.gappssmtp.com header.i=@sijam-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=fBp9aT/9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=sijam.com (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=asai@sijam.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V0byD4sVzz3cGK
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 Mar 2024 18:02:59 +1100 (AEDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6e6b5432439so600139b3a.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 21 Mar 2024 00:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sijam-com.20230601.gappssmtp.com; s=20230601; t=1711004574; x=1711609374; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+s/DQ6CzQaUbwUGyTt1T8uouwfsFbqiGUtb5GIYOm4s=;
        b=fBp9aT/9owG2Vjy/MBvUM7tO5i0mSW4HR5jJr2zOHhQnKCSQWxO8YCR8oyIBGdbjwe
         +74M8hcEriqxiL2+lNXU2yN+CBgjPrtKqQxyjimhC2IO2xLzSp99l4IvDt+MmT/bFLnG
         dMni6RVG0PCA4T+rPibJBonPK3wdq+wuHeCpmHPU70fqHj9slgt2F3n7teRLRs09NlLV
         ikMft4KpUbZ8apUbAMXAXSVppxZkXb8rpbJKNWSH/enJInenI4wgN+ivmcLcRTEUedyt
         iQbk+KCvKYeRz3tDOhTlDptOsyufjAg7Zxr+BbSQ4YqZZEvt9lmQv+xPBlq8k67wvAf0
         751w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711004574; x=1711609374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+s/DQ6CzQaUbwUGyTt1T8uouwfsFbqiGUtb5GIYOm4s=;
        b=DR8atelmPoTivc8mbpFoGql7aIlXHsj7MVBlHFn1xrwEk8a+Kx6p3y1PMwwl6wGEpJ
         AQFfKkyfbH7kb3AdUkQVpVI6vmMp/7on0Jo0fXOJUrvBPtt1szvtUldk6XArgaNS9Q93
         jERnFJeR3u1c2YUiWievFk/4LFt3Z+v5Ea7yq7yoTiNwg+X200hDIHShPiVdv3R6KvN/
         TGbwyvh0a4+nxbB+Xt1ewEyG62eZp9+fGSU95SashUOiq8S9tfzWtG+uJDGwBB4M+IhC
         hL0Uf8PyElQRl7kwAWohWXbLvuTm8dDBBdFhJ5t76JQ+oXu7cH/ZgL3vqckiqKeT0ARN
         f19w==
X-Gm-Message-State: AOJu0Yxe4egr8gSKKOhETxPybmgcKMdjasxldYcohp4rz7FYb7ejdrui
	N6soNTDkgkicAxGE9DJERLDiwg1F+yJXAdyDPgQrf2r5u+S7eo1T/9rGHxo1pRk=
X-Google-Smtp-Source: AGHT+IHRBr/2qrcO/UvJNlQR9vo5LVPpGbyBDeaIXZkL+Rb+suxjE1B6GW7KyTxOjxG/hEc1kXZjAA==
X-Received: by 2002:a05:6a00:4b41:b0:6e6:270a:9303 with SMTP id kr1-20020a056a004b4100b006e6270a9303mr21008583pfb.32.1711004573490;
        Thu, 21 Mar 2024 00:02:53 -0700 (PDT)
Received: from elric.localdomain (i121-112-72-48.s41.a027.ap.plala.or.jp. [121.112.72.48])
        by smtp.gmail.com with ESMTPSA id r7-20020aa79ec7000000b006e6d0165a7bsm12546764pfq.82.2024.03.21.00.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 00:02:53 -0700 (PDT)
From: Noboru Asai <asai@sijam.com>
To: hsiangkao@linux.alibaba.com,
	zhaoyifan@sjtu.edu.cn
Subject: [PATCH] erofs-utils: move pclustersize to struct z_erofs_compress_sctx
Date: Thu, 21 Mar 2024 16:02:36 +0900
Message-ID: <20240321070236.2396573-1-asai@sijam.com>
X-Mailer: git-send-email 2.44.0
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

With -E(all-)fragments, pclustersize has a different value per segment,
so move it to struct z_erofs_compress_sctx.

Signed-off-by: Noboru Asai <asai@sijam.com>
---
 lib/compress.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 9eb40b5..0803a63 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -40,7 +40,6 @@ struct z_erofs_extent_item {
 struct z_erofs_compress_ictx {		/* inode context */
 	struct erofs_inode *inode;
 	int fd;
-	unsigned int pclustersize;
 
 	u32 tof_chksum;
 	bool fix_dedupedfrag;
@@ -64,6 +63,7 @@ struct z_erofs_compress_sctx {		/* segment context */
 
 	unsigned int head, tail;
 	erofs_off_t remaining;
+	unsigned int pclustersize;
 	erofs_blk_t blkaddr;		/* pointing to the next blkaddr */
 	u16 clusterofs;
 
@@ -479,7 +479,7 @@ static bool z_erofs_fixup_deduped_fragment(struct z_erofs_compress_sctx *ctx,
 
 	/* try to fix again if it gets larger (should be rare) */
 	if (inode->fragment_size < newsize) {
-		ictx->pclustersize = min_t(erofs_off_t,
+		ctx->pclustersize = min_t(erofs_off_t,
 				z_erofs_get_max_pclustersize(inode),
 				roundup(newsize - inode->fragment_size,
 					erofs_blksiz(sbi)));
@@ -519,12 +519,12 @@ static int __z_erofs_compress_one(struct z_erofs_compress_sctx *ctx,
 	unsigned int compressedsize;
 	int ret;
 
-	if (len <= ictx->pclustersize) {
+	if (len <= ctx->pclustersize) {
 		if (!final || !len)
 			return 1;
 		if (may_packing) {
 			if (inode->fragment_size && !ictx->fix_dedupedfrag) {
-				ictx->pclustersize = roundup(len, blksz);
+				ctx->pclustersize = roundup(len, blksz);
 				goto fix_dedupedfrag;
 			}
 			e->length = len;
@@ -536,7 +536,7 @@ static int __z_erofs_compress_one(struct z_erofs_compress_sctx *ctx,
 
 	e->length = min(len, cfg.c_max_decompressed_extent_bytes);
 	ret = erofs_compress_destsize(h, ctx->queue + ctx->head,
-				      &e->length, dst, ictx->pclustersize);
+				      &e->length, dst, ctx->pclustersize);
 	if (ret <= 0) {
 		erofs_err("failed to compress %s: %s", inode->i_srcpath,
 			  erofs_strerror(ret));
@@ -573,7 +573,7 @@ nocompression:
 		e->compressedblks = 1;
 		e->raw = true;
 	} else if (may_packing && len == e->length &&
-		   compressedsize < ictx->pclustersize &&
+		   compressedsize < ctx->pclustersize &&
 		   (!inode->fragment_size || ictx->fix_dedupedfrag)) {
 frag_packing:
 		ret = z_erofs_pack_fragments(inode, ctx->queue + ctx->head,
@@ -612,7 +612,7 @@ frag_packing:
 		if (may_packing && len == e->length &&
 		    (compressedsize & (blksz - 1)) &&
 		    ctx->tail < Z_EROFS_COMPR_QUEUE_SZ) {
-			ictx->pclustersize = roundup(compressedsize, blksz);
+			ctx->pclustersize = roundup(compressedsize, blksz);
 			goto fix_dedupedfrag;
 		}
 
@@ -1202,6 +1202,7 @@ void z_erofs_mt_workfn(struct erofs_work *work, void *tlsp)
 		goto out;
 	}
 	sctx->memoff = 0;
+	sctx->pclustersize = z_erofs_get_max_pclustersize(sctx->ictx->inode);
 
 	ret = z_erofs_compress_segment(sctx, sctx->seg_idx * cfg.c_segment_size,
 				       EROFS_NULL_ADDR);
@@ -1460,7 +1461,6 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 	}
 
 	ctx.inode = inode;
-	ctx.pclustersize = z_erofs_get_max_pclustersize(inode);
 	ctx.metacur = compressmeta + Z_EROFS_LEGACY_MAP_HEADER_SIZE;
 	init_list_head(&ctx.extents);
 	ctx.fd = fd;
@@ -1500,6 +1500,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 		sctx.seg_num = 1;
 		sctx.seg_idx = 0;
 		sctx.pivot = &dummy_pivot;
+		sctx.pclustersize = z_erofs_get_max_pclustersize(inode);
 
 		ret = z_erofs_compress_segment(&sctx, -1, blkaddr);
 		if (ret)
-- 
2.44.0

