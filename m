Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B887950484
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Aug 2024 14:10:25 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=DC3WxHQ/;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wjqvx0JMyz2yNH
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Aug 2024 22:10:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=DC3WxHQ/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wjqvp0fynz2xWV
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Aug 2024 22:10:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723551006; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=59kjsjHa5oGttsbPiRfQ2/vIqYfCNokz/wou+pPm0oE=;
	b=DC3WxHQ/icCxagj49fgrMdkLOlc949fdnKu72UgyfTRigP2eYr9JcbxJKDyVZhp6xwKzRF4bNDjfnhWc4b4KU22+AiBbs94Aijs3wCqQOQjIBp8rNsTV1TaRGJJqu4ROcJ/7q0EyVuj/YuU6lQtS9jPFinos9g9wm3hCMhZZ74E=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WCoz9XY_1723551004)
          by smtp.aliyun-inc.com;
          Tue, 13 Aug 2024 20:10:05 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fix invalid argument type in erofs_err()
Date: Tue, 13 Aug 2024 20:10:03 +0800
Message-ID: <20240813121003.780870-1-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Coverity-id: 502374, 502367, 502362, 502348, 502342, 502341,
	     502340, 502358

Fix several issues found by Coverity regarding "Invalid type in argument
for printf format specifier".

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 fsck/main.c     | 2 +-
 lib/blobchunk.c | 2 +-
 lib/compress.c  | 2 +-
 lib/fragments.c | 6 +++---
 lib/super.c     | 3 ++-
 mkfs/main.c     | 2 +-
 6 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 28f1e7e..b29d907 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -807,7 +807,7 @@ static int erofsfsck_dirent_iter(struct erofs_dir_context *ctx)
 	curr_pos = prev_pos;
 
 	if (prev_pos + ctx->de_namelen >= PATH_MAX) {
-		erofs_err("unable to fsck since the path is too long (%u)",
+		erofs_err("unable to fsck since the path is too long (%lu)",
 			  curr_pos + ctx->de_namelen);
 		return -EOPNOTSUPP;
 	}
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 2835755..ef7833a 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -95,7 +95,7 @@ static struct erofs_blobchunk *erofs_blob_getchunk(struct erofs_sb_info *sbi,
 		chunk->device_id = 0;
 	chunk->blkaddr = erofs_blknr(sbi, blkpos);
 
-	erofs_dbg("Writing chunk (%u bytes) to %u", chunksize, chunk->blkaddr);
+	erofs_dbg("Writing chunk (%llu bytes) to %u", chunksize, chunk->blkaddr);
 	ret = fwrite(buf, chunksize, 1, blobfile);
 	if (ret == 1) {
 		padding = erofs_blkoff(sbi, chunksize);
diff --git a/lib/compress.c b/lib/compress.c
index 8655e78..ae81455 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -497,7 +497,7 @@ static bool z_erofs_fixup_deduped_fragment(struct z_erofs_compress_sctx *ctx,
 	inode->fragmentoff += inode->fragment_size - newsize;
 	inode->fragment_size = newsize;
 
-	erofs_dbg("Reducing fragment size to %u at %llu",
+	erofs_dbg("Reducing fragment size to %llu at %llu",
 		  inode->fragment_size, inode->fragmentoff | 0ULL);
 
 	/* it's the end */
diff --git a/lib/fragments.c b/lib/fragments.c
index 7591718..5c7d46b 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -138,7 +138,7 @@ static int z_erofs_fragments_dedupe_find(struct erofs_inode *inode, int fd,
 	inode->fragment_size = deduped;
 	inode->fragmentoff = pos;
 
-	erofs_dbg("Dedupe %u tail data at %llu", inode->fragment_size,
+	erofs_dbg("Dedupe %llu tail data at %llu", inode->fragment_size,
 		  inode->fragmentoff | 0ULL);
 out:
 	free(data);
@@ -283,7 +283,7 @@ int z_erofs_pack_file_from_fd(struct erofs_inode *inode, int fd,
 		goto out;
 	}
 
-	erofs_dbg("Recording %u fragment data at %lu", inode->fragment_size,
+	erofs_dbg("Recording %llu fragment data at %llu", inode->fragment_size,
 		  inode->fragmentoff);
 
 	if (memblock)
@@ -316,7 +316,7 @@ int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
 	if (fwrite(data, len, 1, packedfile) != 1)
 		return -EIO;
 
-	erofs_dbg("Recording %u fragment data at %lu", inode->fragment_size,
+	erofs_dbg("Recording %llu fragment data at %llu", inode->fragment_size,
 		  inode->fragmentoff);
 
 	ret = z_erofs_fragments_dedupe_insert(data, len, inode->fragmentoff,
diff --git a/lib/super.c b/lib/super.c
index 32e10cd..7c4d7f2 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -213,7 +213,8 @@ struct erofs_buffer_head *erofs_reserve_sb(struct erofs_bufmgr *bmgr)
 
 	bh = erofs_balloc(bmgr, META, 0, 0, 0);
 	if (IS_ERR(bh)) {
-		erofs_err("failed to allocate super: %s", PTR_ERR(bh));
+		erofs_err("failed to allocate super: %s",
+					erofs_strerror(PTR_ERR(bh)));
 		return bh;
 	}
 	bh->op = &erofs_skip_write_bhops;
diff --git a/mkfs/main.c b/mkfs/main.c
index b7129eb..1027fc6 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -274,7 +274,7 @@ static int erofs_mkfs_feat_set_fragments(bool en, const char *val,
 		u64 i = strtoull(val, &endptr, 0);
 
 		if (endptr - val != vallen) {
-			erofs_err("invalid pcluster size %s for the packed file %s", val);
+			erofs_err("invalid pcluster size %s for the packed file", val);
 			return -EINVAL;
 		}
 		pclustersize_packed = i;
-- 
2.43.5

