Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 879F775FCE6
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Jul 2023 19:07:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R8mmS34pjz30XP
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jul 2023 03:07:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R8mmN5SKkz2yDL
	for <linux-erofs@lists.ozlabs.org>; Tue, 25 Jul 2023 03:06:59 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vo9mmUY_1690218413;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vo9mmUY_1690218413)
          by smtp.aliyun-inc.com;
          Tue, 25 Jul 2023 01:06:55 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/3] erofs-utils: lib: tidy up erofs_blob_getchunk()
Date: Tue, 25 Jul 2023 01:06:45 +0800
Message-Id: <20230724170646.22281-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230724170646.22281-1-hsiangkao@linux.alibaba.com>
References: <20230724170646.22281-1-hsiangkao@linux.alibaba.com>
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

Mainly get rid of memory allocation on each chunk.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/blobchunk.c | 92 +++++++++++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 41 deletions(-)

diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index c0df2f7..4619057 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -51,60 +51,57 @@ struct erofs_blobchunk *erofs_get_unhashed_chunk(erofs_off_t chunksize,
 }
 
 static struct erofs_blobchunk *erofs_blob_getchunk(struct erofs_sb_info *sbi,
-		int fd, erofs_off_t chunksize)
+						u8 *buf, erofs_off_t chunksize)
 {
 	static u8 zeroed[EROFS_MAX_BLOCK_SIZE];
-	u8 *chunkdata, sha256[32];
-	int ret;
-	unsigned int hash;
-	erofs_off_t blkpos;
 	struct erofs_blobchunk *chunk;
+	unsigned int hash, padding;
+	u8 sha256[32];
+	erofs_off_t blkpos;
+	int ret;
 
-	chunkdata = malloc(chunksize);
-	if (!chunkdata)
-		return ERR_PTR(-ENOMEM);
-
-	ret = read(fd, chunkdata, chunksize);
-	if (ret < chunksize) {
-		chunk = ERR_PTR(-EIO);
-		goto out;
-	}
-	erofs_sha256(chunkdata, chunksize, sha256);
+	erofs_sha256(buf, chunksize, sha256);
 	hash = memhash(sha256, sizeof(sha256));
 	chunk = hashmap_get_from_hash(&blob_hashmap, hash, sha256);
 	if (chunk) {
 		DBG_BUGON(chunksize != chunk->chunksize);
-		goto out;
+		erofs_dbg("Found duplicated chunk at %u", chunk->blkaddr);
+		return chunk;
 	}
+
 	chunk = malloc(sizeof(struct erofs_blobchunk));
-	if (!chunk) {
-		chunk = ERR_PTR(-ENOMEM);
-		goto out;
-	}
+	if (!chunk)
+		return ERR_PTR(-ENOMEM);
 
 	chunk->chunksize = chunksize;
+	memcpy(chunk->sha256, sha256, sizeof(sha256));
 	blkpos = ftell(blobfile);
 	DBG_BUGON(erofs_blkoff(sbi, blkpos));
-	chunk->device_id = 0;
+
+	if (multidev)
+		chunk->device_id = 1;
+	else
+		chunk->device_id = 0;
 	chunk->blkaddr = erofs_blknr(sbi, blkpos);
-	memcpy(chunk->sha256, sha256, sizeof(sha256));
-	hashmap_entry_init(&chunk->ent, hash);
-	hashmap_add(&blob_hashmap, chunk);
 
 	erofs_dbg("Writing chunk (%u bytes) to %u", chunksize, chunk->blkaddr);
-	ret = fwrite(chunkdata, chunksize, 1, blobfile);
-	if (ret == 1 && erofs_blkoff(sbi, chunksize))
-		ret = fwrite(zeroed,
-			     erofs_blksiz(sbi) - erofs_blkoff(sbi, chunksize),
-			     1, blobfile);
+	ret = fwrite(buf, chunksize, 1, blobfile);
+	padding = erofs_blkoff(sbi, chunksize);
+	if (ret == 1) {
+		padding = erofs_blkoff(sbi, chunksize);
+		if (padding) {
+			padding = erofs_blksiz(sbi) - padding;
+			ret = fwrite(zeroed, padding, 1, blobfile);
+		}
+	}
+
 	if (ret < 1) {
-		hashmap_remove(&blob_hashmap, &chunk->ent);
 		free(chunk);
-		chunk = ERR_PTR(-ENOSPC);
-		goto out;
+		return ERR_PTR(-ENOSPC);
 	}
-out:
-	free(chunkdata);
+
+	hashmap_entry_init(&chunk->ent, hash);
+	hashmap_add(&blob_hashmap, chunk);
 	return chunk;
 }
 
@@ -189,6 +186,7 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd)
 	unsigned int count, unit;
 	struct erofs_inode_chunk_index *idx;
 	erofs_off_t pos, len, chunksize;
+	u8 *chunkdata;
 	int ret;
 
 #ifdef SEEK_DATA
@@ -212,11 +210,17 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd)
 	else
 		unit = EROFS_BLOCK_MAP_ENTRY_SIZE;
 
-	inode->extent_isize = count * unit;
-	idx = malloc(count * max(sizeof(*idx), sizeof(void *)));
-	if (!idx)
+	chunkdata = malloc(chunksize);
+	if (!chunkdata)
 		return -ENOMEM;
-	inode->chunkindexes = idx;
+
+	inode->extent_isize = count * unit;
+	inode->chunkindexes = malloc(count * max(sizeof(*idx), sizeof(void *)));
+	if (!inode->chunkindexes) {
+		ret = -ENOMEM;
+		goto err;
+	}
+	idx = inode->chunkindexes;
 
 	for (pos = 0; pos < inode->i_size; pos += len) {
 		struct erofs_blobchunk *chunk;
@@ -248,20 +252,26 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd)
 #endif
 
 		len = min_t(u64, inode->i_size - pos, chunksize);
-		chunk = erofs_blob_getchunk(sbi, fd, len);
+		ret = read(fd, chunkdata, len);
+		if (ret < len) {
+			ret = -EIO;
+			goto err;
+		}
+
+		chunk = erofs_blob_getchunk(sbi, chunkdata, len);
 		if (IS_ERR(chunk)) {
 			ret = PTR_ERR(chunk);
 			goto err;
 		}
-		if (multidev)
-			chunk->device_id = 1;
 		*(void **)idx++ = chunk;
 	}
 	inode->datalayout = EROFS_INODE_CHUNK_BASED;
+	free(chunkdata);
 	return 0;
 err:
 	free(inode->chunkindexes);
 	inode->chunkindexes = NULL;
+	free(chunkdata);
 	return ret;
 }
 
-- 
2.24.4

