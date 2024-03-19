Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4A787F9F7
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Mar 2024 09:32:51 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qMrA2FYE;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TzQ2n3Cfzz3w7s
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Mar 2024 19:32:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qMrA2FYE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TzPt13D6yz77BS
	for <linux-erofs@lists.ozlabs.org>; Tue, 19 Mar 2024 19:25:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710836706; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=hXwTwH9eIEKzDB8qGddatrqjsqmkRW9PIDo7p+fakLs=;
	b=qMrA2FYE+ptUc5zpuUz1KwzbAMhY/GMd+ydYr6Jt2IVmI7gEpdY1BDQv6Jc6r+tZ3TYop1Vw9956kGfzMrs3tK1CnJhKKBW2zVYQwFdTpbGtVF0vK8GxlkM9I42chY+s59/jV7wIFF5ZGpkI0J/Zfx+OwQdIcCkEZhH5lPTH2no=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W2sQfau_1710836696;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W2sQfau_1710836696)
          by smtp.aliyun-inc.com;
          Tue, 19 Mar 2024 16:25:05 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fix multi-threaded compression in tarerofs mode
Date: Tue, 19 Mar 2024 16:24:55 +0800
Message-Id: <20240319082455.4115493-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Since pread() can be used during multi-threaded compression, it's
necessary to pass `fpos` in to indicate the absolute offset.

Fixes: aec8487dce4c ("erofs-utils: mkfs: introduce inner-file multi-threaded compression")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/compress.h |  2 +-
 lib/compress.c           | 14 +++++++++-----
 lib/inode.c              |  4 ++--
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/erofs/compress.h b/include/erofs/compress.h
index 3253611..871db54 100644
--- a/include/erofs/compress.h
+++ b/include/erofs/compress.h
@@ -18,7 +18,7 @@ extern "C"
 #define Z_EROFS_COMPR_QUEUE_SZ		(EROFS_CONFIG_COMPR_MAX_SZ * 2)
 
 void z_erofs_drop_inline_pcluster(struct erofs_inode *inode);
-int erofs_write_compressed_file(struct erofs_inode *inode, int fd);
+int erofs_write_compressed_file(struct erofs_inode *inode, int fd, u64 fpos);
 
 int z_erofs_compress_init(struct erofs_sb_info *sbi,
 			  struct erofs_buffer_head *bh);
diff --git a/lib/compress.c b/lib/compress.c
index 8d88dd1..e064293 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -38,8 +38,9 @@ struct z_erofs_extent_item {
 
 struct z_erofs_compress_ictx {		/* inode context */
 	struct erofs_inode *inode;
-	int fd;
 	unsigned int pclustersize;
+	int fd;
+	u64 fpos;
 
 	u32 tof_chksum;
 	bool fix_dedupedfrag;
@@ -990,7 +991,8 @@ void z_erofs_drop_inline_pcluster(struct erofs_inode *inode)
 int z_erofs_compress_segment(struct z_erofs_compress_sctx *ctx,
 			     u64 offset, erofs_blk_t blkaddr)
 {
-	int fd = ctx->ictx->fd;
+	struct z_erofs_compress_ictx *ictx = ctx->ictx;
+	int fd = ictx->fd;
 
 	ctx->blkaddr = blkaddr;
 	while (ctx->remaining) {
@@ -1000,7 +1002,8 @@ int z_erofs_compress_segment(struct z_erofs_compress_sctx *ctx,
 
 		ret = (offset == -1 ?
 			read(fd, ctx->queue + ctx->tail, rx) :
-			pread(fd, ctx->queue + ctx->tail, rx, offset));
+			pread(fd, ctx->queue + ctx->tail, rx,
+			      ictx->fpos + offset));
 		if (ret != rx)
 			return -errno;
 
@@ -1238,7 +1241,7 @@ int z_erofs_mt_compress(struct z_erofs_compress_ictx *ictx,
 }
 #endif
 
-int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
+int erofs_write_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 {
 	static u8 g_queue[Z_EROFS_COMPR_QUEUE_SZ];
 	struct erofs_buffer_head *bh;
@@ -1313,9 +1316,10 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 	blkaddr = erofs_mapbh(bh->block);	/* start_blkaddr */
 	ctx.inode = inode;
 	ctx.pclustersize = z_erofs_get_max_pclustersize(inode);
+	ctx.fd = fd;
+	ctx.fpos = fpos;
 	ctx.metacur = compressmeta + Z_EROFS_LEGACY_MAP_HEADER_SIZE;
 	init_list_head(&ctx.extents);
-	ctx.fd = fd;
 	ctx.fix_dedupedfrag = false;
 	ctx.fragemitted = false;
 	sctx = (struct z_erofs_compress_sctx) { .ictx = &ctx, };
diff --git a/lib/inode.c b/lib/inode.c
index ac00228..4c29aa7 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -493,7 +493,7 @@ int erofs_write_file(struct erofs_inode *inode, int fd, u64 fpos)
 	}
 
 	if (cfg.c_compr_opts[0].alg && erofs_file_is_compressible(inode)) {
-		ret = erofs_write_compressed_file(inode, fd);
+		ret = erofs_write_compressed_file(inode, fd, fpos);
 		if (!ret || ret != -ENOSPC)
 			return ret;
 
@@ -1340,7 +1340,7 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name)
 		inode->nid = inode->sbi->packed_nid;
 	}
 
-	ret = erofs_write_compressed_file(inode, fd);
+	ret = erofs_write_compressed_file(inode, fd, 0);
 	if (ret == -ENOSPC) {
 		ret = lseek(fd, 0, SEEK_SET);
 		if (ret < 0)
-- 
2.39.3

