Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F076EA50B
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Apr 2023 09:39:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Q2mdB46c9z3fRQ
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Apr 2023 17:39:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Q2md64Rqzz3f6r
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Apr 2023 17:39:37 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vgc.4j7_1682062767;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vgc.4j7_1682062767)
          by smtp.aliyun-inc.com;
          Fri, 21 Apr 2023 15:39:32 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs-utils: refine blobchunk implementation
Date: Fri, 21 Apr 2023 15:39:25 +0800
Message-Id: <20230421073926.85369-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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

 - record device_id in erofs_blobchunk for later tarerofs;

 - fix up endianness conversion;

 - blob (hash) entries should be released in the blobchunk submodule.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/hashmap.h |  5 ++---
 lib/blobchunk.c         | 44 ++++++++++++++++++++++++++---------------
 lib/hashmap.c           | 32 +++++++++++++-----------------
 3 files changed, 44 insertions(+), 37 deletions(-)

diff --git a/include/erofs/hashmap.h b/include/erofs/hashmap.h
index 3d38578..d25092d 100644
--- a/include/erofs/hashmap.h
+++ b/include/erofs/hashmap.h
@@ -61,7 +61,7 @@ struct hashmap_iter {
 /* hashmap functions */
 void hashmap_init(struct hashmap *map, hashmap_cmp_fn equals_function,
 		  size_t initial_size);
-void hashmap_free(struct hashmap *map, int free_entries);
+int hashmap_free(struct hashmap *map);
 
 /* hashmap_entry functions */
 static inline void hashmap_entry_init(void *entry, unsigned int hash)
@@ -75,8 +75,7 @@ static inline void hashmap_entry_init(void *entry, unsigned int hash)
 void *hashmap_get(const struct hashmap *map, const void *key, const void *keydata);
 void *hashmap_get_next(const struct hashmap *map, const void *entry);
 void hashmap_add(struct hashmap *map, void *entry);
-void *hashmap_put(struct hashmap *map, void *entry);
-void *hashmap_remove(struct hashmap *map, const void *key, const void *keydata);
+void *hashmap_remove(struct hashmap *map, const void *key);
 
 static inline void *hashmap_get_from_hash(const struct hashmap *map,
 					  unsigned int hash,
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 8142cc3..6fbc15b 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -16,6 +16,7 @@
 struct erofs_blobchunk {
 	struct hashmap_entry ent;
 	char		sha256[32];
+	unsigned int	device_id;
 	erofs_off_t	chunksize;
 	erofs_blk_t	blkaddr;
 };
@@ -64,6 +65,7 @@ static struct erofs_blobchunk *erofs_blob_getchunk(int fd,
 	chunk->chunksize = chunksize;
 	blkpos = ftell(blobfile);
 	DBG_BUGON(erofs_blkoff(blkpos));
+	chunk->device_id = 0;
 	chunk->blkaddr = erofs_blknr(blkpos);
 	memcpy(chunk->sha256, sha256, sizeof(sha256));
 	hashmap_entry_init(&chunk->ent, hash);
@@ -75,10 +77,7 @@ static struct erofs_blobchunk *erofs_blob_getchunk(int fd,
 		ret = fwrite(zeroed, erofs_blksiz() - erofs_blkoff(chunksize),
 			     1, blobfile);
 	if (ret < 1) {
-		struct hashmap_entry key;
-
-		hashmap_entry_init(&key, hash);
-		hashmap_remove(&blob_hashmap, &key, sha256);
+		hashmap_remove(&blob_hashmap, &chunk->ent);
 		free(chunk);
 		chunk = ERR_PTR(-ENOSPC);
 		goto out;
@@ -110,14 +109,6 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 	erofs_blk_t extent_end, extents_blks;
 	unsigned int dst, src, unit;
 	bool first_extent = true;
-	erofs_blk_t base_blkaddr = 0;
-
-	if (multidev) {
-		idx.device_id = 1;
-		DBG_BUGON(!(inode->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES));
-	} else {
-		base_blkaddr = remapped_base;
-	}
 
 	if (inode->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES)
 		unit = sizeof(struct erofs_inode_chunk_index);
@@ -130,10 +121,15 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 
 		chunk = *(void **)(inode->chunkindexes + src);
 
-		if (chunk->blkaddr != EROFS_NULL_ADDR)
-			idx.blkaddr = base_blkaddr + chunk->blkaddr;
-		else
+		if (chunk->blkaddr == EROFS_NULL_ADDR) {
 			idx.blkaddr = EROFS_NULL_ADDR;
+		} else if (chunk->device_id) {
+			DBG_BUGON(!(inode->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES));
+			idx.blkaddr = chunk->blkaddr;
+			extent_start = EROFS_NULL_ADDR;
+		} else {
+			idx.blkaddr = remapped_base + chunk->blkaddr;
+		}
 
 		if (extent_start != EROFS_NULL_ADDR &&
 		    idx.blkaddr == extent_end + 1) {
@@ -149,6 +145,9 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 			extent_start = idx.blkaddr;
 			extent_end = idx.blkaddr;
 		}
+		idx.device_id = cpu_to_le16(chunk->device_id);
+		idx.blkaddr = cpu_to_le32(idx.blkaddr);
+
 		if (unit == EROFS_BLOCK_MAP_ENTRY_SIZE)
 			memcpy(inode->chunkindexes + dst, &idx.blkaddr, unit);
 		else
@@ -237,6 +236,8 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode)
 			ret = PTR_ERR(chunk);
 			goto err;
 		}
+		if (multidev)
+			chunk->device_id = 1;
 		*(void **)idx++ = chunk;
 	}
 	inode->datalayout = EROFS_INODE_CHUNK_BASED;
@@ -293,10 +294,21 @@ int erofs_blob_remap(void)
 
 void erofs_blob_exit(void)
 {
+	struct hashmap_iter iter;
+	struct hashmap_entry *e;
+
 	if (blobfile)
 		fclose(blobfile);
 
-	hashmap_free(&blob_hashmap, 1);
+	while ((e = hashmap_iter_first(&blob_hashmap, &iter))) {
+		struct erofs_blobchunk *bc =
+			container_of((struct hashmap_entry *)e,
+				     struct erofs_blobchunk, ent);
+
+		DBG_BUGON(hashmap_remove(&blob_hashmap, e) != e);
+		free(bc);
+	}
+	DBG_BUGON(hashmap_free(&blob_hashmap));
 }
 
 int erofs_blob_init(const char *blobfile_path)
diff --git a/lib/hashmap.c b/lib/hashmap.c
index e11bd8d..45916ae 100644
--- a/lib/hashmap.c
+++ b/lib/hashmap.c
@@ -149,20 +149,21 @@ void hashmap_init(struct hashmap *map, hashmap_cmp_fn equals_function,
 	alloc_table(map, size);
 }
 
-void hashmap_free(struct hashmap *map, int free_entries)
+int hashmap_free(struct hashmap *map)
 {
-	if (!map || !map->table)
-		return;
-	if (free_entries) {
+	if (map && map->table) {
 		struct hashmap_iter iter;
 		struct hashmap_entry *e;
 
 		hashmap_iter_init(map, &iter);
-		while ((e = hashmap_iter_next(&iter)))
-			free(e);
+		e = hashmap_iter_next(&iter);
+		if (e)
+			return -EBUSY;
+
+		free(map->table);
+		memset(map, 0, sizeof(*map));
 	}
-	free(map->table);
-	memset(map, 0, sizeof(*map));
+	return 0;
 }
 
 void *hashmap_get(const struct hashmap *map, const void *key, const void *keydata)
@@ -194,10 +195,13 @@ void hashmap_add(struct hashmap *map, void *entry)
 		rehash(map, map->tablesize << HASHMAP_RESIZE_BITS);
 }
 
-void *hashmap_remove(struct hashmap *map, const void *key, const void *keydata)
+void *hashmap_remove(struct hashmap *map, const void *entry)
 {
 	struct hashmap_entry *old;
-	struct hashmap_entry **e = find_entry_ptr(map, key, keydata);
+	struct hashmap_entry **e = &map->table[bucket(map, entry)];
+
+	while (*e && *e != entry)
+		e = &(*e)->next;
 
 	if (!*e)
 		return NULL;
@@ -214,14 +218,6 @@ void *hashmap_remove(struct hashmap *map, const void *key, const void *keydata)
 	return old;
 }
 
-void *hashmap_put(struct hashmap *map, void *entry)
-{
-	struct hashmap_entry *old = hashmap_remove(map, entry, NULL);
-
-	hashmap_add(map, entry);
-	return old;
-}
-
 void hashmap_iter_init(struct hashmap *map, struct hashmap_iter *iter)
 {
 	iter->map = map;
-- 
2.24.4

