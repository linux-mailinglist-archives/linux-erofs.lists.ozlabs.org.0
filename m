Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 106456823AF
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Jan 2023 06:15:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4P5YCK6NBCz3bmQ
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Jan 2023 16:15:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4P5YCF2F7jz3bW0
	for <linux-erofs@lists.ozlabs.org>; Tue, 31 Jan 2023 16:15:04 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VaVG31y_1675142095;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VaVG31y_1675142095)
          by smtp.aliyun-inc.com;
          Tue, 31 Jan 2023 13:14:59 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: support chunk-based sparse files
Date: Tue, 31 Jan 2023 13:14:54 +0800
Message-Id: <20230131051454.47719-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230127100811.109549-1-hsiangkao@linux.alibaba.com>
References: <20230127100811.109549-1-hsiangkao@linux.alibaba.com>
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

Scan holes for chunk-based inodes if either --chunksize=# or
-Ededupe (without compression) is specified so that sparse files
can be made, which has already been supported since Linux 5.15.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
changes since v1:
 - fix `off64_t` compile error on MacOS.

 lib/blobchunk.c | 71 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 55 insertions(+), 16 deletions(-)

diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 77b0c17..744d054 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -18,7 +18,7 @@ void erofs_sha256(const unsigned char *in, unsigned long in_size,
 struct erofs_blobchunk {
 	struct hashmap_entry ent;
 	char		sha256[32];
-	unsigned int	chunksize;
+	erofs_off_t	chunksize;
 	erofs_blk_t	blkaddr;
 };
 
@@ -27,9 +27,12 @@ static FILE *blobfile;
 static erofs_blk_t remapped_base;
 static bool multidev;
 static struct erofs_buffer_head *bh_devt;
+struct erofs_blobchunk erofs_holechunk = {
+	.blkaddr = EROFS_NULL_ADDR,
+};
 
 static struct erofs_blobchunk *erofs_blob_getchunk(int fd,
-		unsigned int chunksize)
+		erofs_off_t chunksize)
 {
 	static u8 zeroed[EROFS_BLKSIZ];
 	u8 *chunkdata, sha256[32];
@@ -129,7 +132,11 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 
 		chunk = *(void **)(inode->chunkindexes + src);
 
-		idx.blkaddr = base_blkaddr + chunk->blkaddr;
+		if (chunk->blkaddr != EROFS_NULL_ADDR)
+			idx.blkaddr = base_blkaddr + chunk->blkaddr;
+		else
+			idx.blkaddr = EROFS_NULL_ADDR;
+
 		if (extent_start != EROFS_NULL_ADDR &&
 		    idx.blkaddr == extent_end + 1) {
 			extent_end = idx.blkaddr;
@@ -163,14 +170,28 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 
 int erofs_blob_write_chunked_file(struct erofs_inode *inode)
 {
-	unsigned int chunksize = 1 << cfg.c_chunkbits;
-	unsigned int count = DIV_ROUND_UP(inode->i_size, chunksize);
+	unsigned int chunkbits = cfg.c_chunkbits;
+	unsigned int count, unit;
 	struct erofs_inode_chunk_index *idx;
-	erofs_off_t pos, len;
-	unsigned int unit;
+	erofs_off_t pos, len, chunksize;
 	int fd, ret;
 
-	inode->u.chunkformat |= inode->u.chunkbits - LOG_BLOCK_SIZE;
+	fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
+	if (fd < 0)
+		return -errno;
+#ifdef SEEK_DATA
+	/* if the file is fully sparsed, use one big chunk instead */
+	if (lseek(fd, 0, SEEK_DATA) < 0 && errno == ENXIO) {
+		chunkbits = ilog2(inode->i_size - 1) + 1;
+		if (chunkbits < LOG_BLOCK_SIZE)
+			chunkbits = LOG_BLOCK_SIZE;
+	}
+#endif
+	if (chunkbits - LOG_BLOCK_SIZE > EROFS_CHUNK_FORMAT_BLKBITS_MASK)
+		chunkbits = EROFS_CHUNK_FORMAT_BLKBITS_MASK + LOG_BLOCK_SIZE;
+	chunksize = 1ULL << chunkbits;
+	count = DIV_ROUND_UP(inode->i_size, chunksize);
+	inode->u.chunkformat |= chunkbits - LOG_BLOCK_SIZE;
 	if (multidev)
 		inode->u.chunkformat |= EROFS_CHUNK_FORMAT_INDEXES;
 
@@ -181,24 +202,41 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode)
 
 	inode->extent_isize = count * unit;
 	idx = malloc(count * max(sizeof(*idx), sizeof(void *)));
-	if (!idx)
+	if (!idx) {
+		close(fd);
 		return -ENOMEM;
-	inode->chunkindexes = idx;
-
-	fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
-	if (fd < 0) {
-		ret = -errno;
-		goto err;
 	}
+	inode->chunkindexes = idx;
 
 	for (pos = 0; pos < inode->i_size; pos += len) {
 		struct erofs_blobchunk *chunk;
+#ifdef SEEK_DATA
+		off_t offset = lseek(fd, pos, SEEK_DATA);
+
+		if (offset < 0) {
+			if (errno != ENXIO)
+				offset = pos;
+			else
+				offset = ((pos >> chunkbits) + 1) << chunkbits;
+		} else {
+			offset &= ~(chunksize - 1);
+		}
+
+		if (offset > pos) {
+			len = 0;
+			do {
+				*(void **)idx++ = &erofs_holechunk;
+				pos += chunksize;
+			} while (pos < offset);
+			DBG_BUGON(pos != offset);
+			continue;
+		}
+#endif
 
 		len = min_t(u64, inode->i_size - pos, chunksize);
 		chunk = erofs_blob_getchunk(fd, len);
 		if (IS_ERR(chunk)) {
 			ret = PTR_ERR(chunk);
-			close(fd);
 			goto err;
 		}
 		*(void **)idx++ = chunk;
@@ -207,6 +245,7 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode)
 	close(fd);
 	return 0;
 err:
+	close(fd);
 	free(inode->chunkindexes);
 	inode->chunkindexes = NULL;
 	return ret;
-- 
2.24.4

