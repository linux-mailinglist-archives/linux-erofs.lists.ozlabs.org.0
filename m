Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA75E9F74F1
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Dec 2024 07:43:55 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YDLc909Sxz3bTn
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Dec 2024 17:43:53 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734590630;
	cv=none; b=cZBSZCtAa+sauiuV7ofJG3NXnx2DnlnHbbi8VSK2La+0ZcFpek7VlCJ1a8omDGVC52gA8YfwGKUXSxOgXFNOP1cSbDN3sluy4Nyr94R6WvwKlVuMD6WE5LJ6x6ZTcs4xxubIbgSz6MnqSE3WvoSfVhKANZoEvDUQd7gUN9DNg3TDuVGgT4Mt3hlfaf8Ny/G3skXFAgVkp+72BdqeHjjrkVycbK8c5jSvPRK0UT/vq5r/gkdNm9MbwV4l9v/Zz1zQsrB5OoEOFfonocKTmRo9REdCa4BiOVIGG+hajgKm6d0/688aORUfa62RRe8bPuDqt1LTQ0ME1C6+dxIR8Zz7eA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734590630; c=relaxed/relaxed;
	bh=9/ZHCQ9+wDyxlZbCoeoo9I0y1Q/0UnzPZeZBV7Ck80U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D49ZZaBSsaLFV2jgRcliLYdhM6Vr2vlE3d6nvvmjLiszV659eIEIIt/FV1fLrOYZ7sUs40feswgctS7649i0ZzOOyyKR0RtZUBeeuWx6AecLx5bPOfrjb+zK9LN+fFkOHBn1duwCppHWugREnij39kuQspPQKdr0+tfb5q32Ex9dgsdUOQeHcovQU0NHo0hvSNW/GQb/VpsSzlvJEwkcw9AY4+qBLv6qagMElNnZabRyL8mCEfMw9Mpq6m5GV+5KFUl4Ps/hMvfMFTqi7Vl5UrUM4MZ+Atwu+x7h3R27G6H5VwDA3dHRnpvXtrpZte1A8cNDG83MvEkBhKeovfFyqw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nrlNBA0n; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nrlNBA0n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YDLc41GK4z2xr4
	for <linux-erofs@lists.ozlabs.org>; Thu, 19 Dec 2024 17:43:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734590621; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=9/ZHCQ9+wDyxlZbCoeoo9I0y1Q/0UnzPZeZBV7Ck80U=;
	b=nrlNBA0nmojMjGv5SdXdkuV6rW3dpG7nHdbxIAbMx5m8uh53Gseh3ON+KNH/YekGMq96pPKO/mkfmSILpwUyZsbfdlZAkFXk/cl6irrB2avY7hAnAg9ScFliFt8KbbWMKl9mWGPsdW2D1HukzXY2zgzuOOFIfw1QCz9JK673qnc=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WLpMVHc_1734590614 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Dec 2024 14:43:39 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 1/4] erofs-utils: lib: cache: get rid of required_ext
Date: Thu, 19 Dec 2024 14:43:28 +0800
Message-ID: <20241219064331.2223001-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

It's never used and doesn't have clear meanings.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/cache.h |  1 -
 lib/blobchunk.c       |  4 ++--
 lib/cache.c           | 22 +++++++++-------------
 lib/compress.c        |  4 ++--
 lib/inode.c           | 10 +++++-----
 lib/super.c           |  2 +-
 lib/xattr.c           |  2 +-
 7 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/include/erofs/cache.h b/include/erofs/cache.h
index 5411eed..646d6de 100644
--- a/include/erofs/cache.h
+++ b/include/erofs/cache.h
@@ -120,7 +120,6 @@ int erofs_bh_balloon(struct erofs_buffer_head *bh, erofs_off_t incr);
 
 struct erofs_buffer_head *erofs_balloc(struct erofs_bufmgr *bmgr,
 				       int type, erofs_off_t size,
-				       unsigned int required_ext,
 				       unsigned int inline_ext);
 struct erofs_buffer_head *erofs_battach(struct erofs_buffer_head *bh,
 					int type, unsigned int size);
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 119dd82..8e2360f 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -525,7 +525,7 @@ int erofs_mkfs_dump_blobs(struct erofs_sb_info *sbi)
 		return 0;
 	}
 
-	bh = erofs_balloc(sbi->bmgr, DATA, datablob_size, 0, 0);
+	bh = erofs_balloc(sbi->bmgr, DATA, datablob_size, 0);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
 
@@ -647,7 +647,7 @@ int erofs_mkfs_init_devices(struct erofs_sb_info *sbi, unsigned int devices)
 		return -ENOMEM;
 
 	bh_devt = erofs_balloc(sbi->bmgr, DEVT,
-		sizeof(struct erofs_deviceslot) * devices, 0, 0);
+		sizeof(struct erofs_deviceslot) * devices, 0);
 	if (IS_ERR(bh_devt)) {
 		free(sbi->devs);
 		return PTR_ERR(bh_devt);
diff --git a/lib/cache.c b/lib/cache.c
index 3208e9f..66bbdca 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -127,7 +127,6 @@ int erofs_bh_balloon(struct erofs_buffer_head *bh, erofs_off_t incr)
 
 static int erofs_bfind_for_attach(struct erofs_bufmgr *bmgr,
 				  int type, erofs_off_t size,
-				  unsigned int required_ext,
 				  unsigned int inline_ext,
 				  unsigned int alignsize,
 				  struct erofs_buffer_block **bbp)
@@ -137,7 +136,7 @@ static int erofs_bfind_for_attach(struct erofs_bufmgr *bmgr,
 	unsigned int used0, used_before, usedmax, used;
 	int ret;
 
-	used0 = ((size + required_ext) & (blksiz - 1)) + inline_ext;
+	used0 = (size & (blksiz - 1)) + inline_ext;
 	/* inline data should be in the same fs block */
 	if (used0 > blksiz)
 		return -ENOSPC;
@@ -151,11 +150,10 @@ static int erofs_bfind_for_attach(struct erofs_bufmgr *bmgr,
 	bb = NULL;
 
 	/* try to find a most-fit mapped buffer block first */
-	if (size + required_ext + inline_ext >= blksiz)
+	if (size + inline_ext >= blksiz)
 		goto skip_mapped;
 
-	used_before = rounddown(blksiz -
-				(size + required_ext + inline_ext), alignsize);
+	used_before = rounddown(blksiz - (size + inline_ext), alignsize);
 	for (; used_before; --used_before) {
 		struct list_head *bt = bmgr->mapped_buckets[type] + used_before;
 
@@ -175,14 +173,14 @@ static int erofs_bfind_for_attach(struct erofs_bufmgr *bmgr,
 		DBG_BUGON(used_before != (cur->buffers.off & (blksiz - 1)));
 
 		ret = __erofs_battach(cur, NULL, size, alignsize,
-				      required_ext + inline_ext, true);
+				      inline_ext, true);
 		if (ret < 0) {
 			DBG_BUGON(1);
 			continue;
 		}
 
 		/* should contain all data in the current block */
-		used = ret + required_ext + inline_ext;
+		used = ret + inline_ext;
 		DBG_BUGON(used > blksiz);
 
 		bb = cur;
@@ -207,11 +205,11 @@ skip_mapped:
 			continue;
 
 		ret = __erofs_battach(cur, NULL, size, alignsize,
-				      required_ext + inline_ext, true);
+				      inline_ext, true);
 		if (ret < 0)
 			continue;
 
-		used = ((ret + required_ext) & (blksiz - 1)) + inline_ext;
+		used = (ret & (blksiz - 1)) + inline_ext;
 
 		/* should contain inline data in current block */
 		if (used > blksiz)
@@ -235,7 +233,6 @@ skip_mapped:
 
 struct erofs_buffer_head *erofs_balloc(struct erofs_bufmgr *bmgr,
 				       int type, erofs_off_t size,
-				       unsigned int required_ext,
 				       unsigned int inline_ext)
 {
 	struct erofs_buffer_block *bb;
@@ -251,7 +248,7 @@ struct erofs_buffer_head *erofs_balloc(struct erofs_bufmgr *bmgr,
 	alignsize = ret;
 
 	/* try to find if we could reuse an allocated buffer block */
-	ret = erofs_bfind_for_attach(bmgr, type, size, required_ext, inline_ext,
+	ret = erofs_bfind_for_attach(bmgr, type, size, inline_ext,
 				     alignsize, &bb);
 	if (ret)
 		return ERR_PTR(ret);
@@ -285,8 +282,7 @@ struct erofs_buffer_head *erofs_balloc(struct erofs_bufmgr *bmgr,
 		}
 	}
 
-	ret = __erofs_battach(bb, bh, size, alignsize,
-			      required_ext + inline_ext, false);
+	ret = __erofs_battach(bb, bh, size, alignsize, inline_ext, false);
 	if (ret < 0) {
 		free(bh);
 		return ERR_PTR(ret);
diff --git a/lib/compress.c b/lib/compress.c
index 65edd00..8446fe4 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1378,7 +1378,7 @@ int erofs_mt_write_compressed_file(struct z_erofs_compress_ictx *ictx)
 		pthread_cond_wait(&ictx->cond, &ictx->mutex);
 	pthread_mutex_unlock(&ictx->mutex);
 
-	bh = erofs_balloc(sbi->bmgr, DATA, 0, 0, 0);
+	bh = erofs_balloc(sbi->bmgr, DATA, 0, 0);
 	if (IS_ERR(bh)) {
 		ret = PTR_ERR(bh);
 		goto out;
@@ -1544,7 +1544,7 @@ int erofs_write_compressed_file(struct z_erofs_compress_ictx *ictx)
 #endif
 
 	/* allocate main data buffer */
-	bh = erofs_balloc(inode->sbi->bmgr, DATA, 0, 0, 0);
+	bh = erofs_balloc(inode->sbi->bmgr, DATA, 0, 0);
 	if (IS_ERR(bh)) {
 		ret = PTR_ERR(bh);
 		goto err_free_idata;
diff --git a/lib/inode.c b/lib/inode.c
index 0404a8d..de6d020 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -189,7 +189,7 @@ int erofs_allocate_inode_bh_data(struct erofs_inode *inode, erofs_blk_t nblocks)
 
 	/* allocate main data buffer */
 	type = S_ISDIR(inode->i_mode) ? DIRA : DATA;
-	bh = erofs_balloc(bmgr, type, erofs_pos(inode->sbi, nblocks), 0, 0);
+	bh = erofs_balloc(bmgr, type, erofs_pos(inode->sbi, nblocks), 0);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
 
@@ -777,7 +777,7 @@ static int erofs_prepare_inode_buffer(struct erofs_inode *inode)
 			inode->datalayout = EROFS_INODE_FLAT_PLAIN;
 	}
 
-	bh = erofs_balloc(bmgr, INODE, inodesize, 0, inode->idata_size);
+	bh = erofs_balloc(bmgr, INODE, inodesize, inode->idata_size);
 	if (bh == ERR_PTR(-ENOSPC)) {
 		int ret;
 
@@ -790,7 +790,7 @@ noinline:
 		ret = erofs_prepare_tail_block(inode);
 		if (ret)
 			return ret;
-		bh = erofs_balloc(bmgr, INODE, inodesize, 0, 0);
+		bh = erofs_balloc(bmgr, INODE, inodesize, 0);
 		if (IS_ERR(bh))
 			return PTR_ERR(bh);
 		DBG_BUGON(inode->bh_inline);
@@ -871,7 +871,7 @@ static int erofs_write_tail_end(struct erofs_inode *inode)
 
 		if (!bh) {
 			bh = erofs_balloc(sbi->bmgr, DATA,
-					  erofs_blksiz(sbi), 0, 0);
+					  erofs_blksiz(sbi), 0);
 			if (IS_ERR(bh))
 				return PTR_ERR(bh);
 			bh->op = &erofs_skip_write_bhops;
@@ -1186,7 +1186,7 @@ static int erofs_inode_reserve_data_blocks(struct erofs_inode *inode)
 	struct erofs_buffer_head *bh;
 
 	/* allocate data blocks */
-	bh = erofs_balloc(sbi->bmgr, DATA, alignedsz, 0, 0);
+	bh = erofs_balloc(sbi->bmgr, DATA, alignedsz, 0);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
 
diff --git a/lib/super.c b/lib/super.c
index d4cea50..6c8fa52 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -211,7 +211,7 @@ struct erofs_buffer_head *erofs_reserve_sb(struct erofs_bufmgr *bmgr)
 	struct erofs_buffer_head *bh;
 	int err;
 
-	bh = erofs_balloc(bmgr, META, 0, 0, 0);
+	bh = erofs_balloc(bmgr, META, 0, 0);
 	if (IS_ERR(bh)) {
 		erofs_err("failed to allocate super: %s",
 			  erofs_strerror(PTR_ERR(bh)));
diff --git a/lib/xattr.c b/lib/xattr.c
index e420775..c95928e 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -924,7 +924,7 @@ int erofs_build_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *p
 		return -ENOMEM;
 	}
 
-	bh = erofs_balloc(sbi->bmgr, XATTR, shared_xattrs_size, 0, 0);
+	bh = erofs_balloc(sbi->bmgr, XATTR, shared_xattrs_size, 0);
 	if (IS_ERR(bh)) {
 		free(sorted_n);
 		free(buf);
-- 
2.43.5

