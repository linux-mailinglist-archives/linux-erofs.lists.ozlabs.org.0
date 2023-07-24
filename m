Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCC575FCE7
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Jul 2023 19:07:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R8mmW3LXYz30YV
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jul 2023 03:07:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R8mmP0Ff5z2yGT
	for <linux-erofs@lists.ozlabs.org>; Tue, 25 Jul 2023 03:07:00 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vo9mmV6_1690218415;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vo9mmV6_1690218415)
          by smtp.aliyun-inc.com;
          Tue, 25 Jul 2023 01:06:56 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 3/3] erofs-utils: merge consecutive chunks if possible
Date: Tue, 25 Jul 2023 01:06:46 +0800
Message-Id: <20230724170646.22281-3-hsiangkao@linux.alibaba.com>
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

Since EROFS chunk size can be configured on a per-file basis,
let's generate indexes with the best chunk size.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/defs.h |  5 +++++
 lib/blobchunk.c      | 53 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/include/erofs/defs.h b/include/erofs/defs.h
index 44af557..20f9741 100644
--- a/include/erofs/defs.h
+++ b/include/erofs/defs.h
@@ -286,6 +286,11 @@ static inline unsigned int fls_long(unsigned long x)
 	return x ? sizeof(x) * 8 - __builtin_clz(x) : 0;
 }
 
+static inline unsigned long lowbit(unsigned long n)
+{
+	return n & -n;
+}
+
 /**
  * __roundup_pow_of_two() - round up to nearest power of two
  * @n: value to round up
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 4619057..4e4295e 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -179,13 +179,47 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 	return dev_write(inode->sbi, inode->chunkindexes, off, inode->extent_isize);
 }
 
+int erofs_blob_mergechunks(struct erofs_inode *inode, unsigned int chunkbits,
+			   unsigned int new_chunkbits)
+{
+	struct erofs_sb_info *sbi = inode->sbi;
+	unsigned int dst, src, unit, count;
+
+	if (new_chunkbits - sbi->blkszbits > EROFS_CHUNK_FORMAT_BLKBITS_MASK)
+		new_chunkbits = EROFS_CHUNK_FORMAT_BLKBITS_MASK + sbi->blkszbits;
+	if (chunkbits >= new_chunkbits)		/* no need to merge */
+		goto out;
+
+	if (inode->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES)
+		unit = sizeof(struct erofs_inode_chunk_index);
+	else
+		unit = EROFS_BLOCK_MAP_ENTRY_SIZE;
+
+	count = round_up(inode->i_size, 1ULL << new_chunkbits) >> new_chunkbits;
+	for (dst = src = 0; dst < count; ++dst) {
+		*((void **)inode->chunkindexes + dst) =
+			*((void **)inode->chunkindexes + src);
+		src += 1U << (new_chunkbits - chunkbits);
+	}
+
+	DBG_BUGON(count * unit >= inode->extent_isize);
+	inode->extent_isize = count * unit;
+	chunkbits = new_chunkbits;
+out:
+	inode->u.chunkformat = (chunkbits - sbi->blkszbits) |
+		(inode->u.chunkformat & ~EROFS_CHUNK_FORMAT_BLKBITS_MASK);
+	return 0;
+}
+
 int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd)
 {
 	struct erofs_sb_info *sbi = inode->sbi;
 	unsigned int chunkbits = cfg.c_chunkbits;
 	unsigned int count, unit;
+	struct erofs_blobchunk *chunk, *lastch;
 	struct erofs_inode_chunk_index *idx;
 	erofs_off_t pos, len, chunksize;
+	erofs_blk_t lb, minextblks;
 	u8 *chunkdata;
 	int ret;
 
@@ -201,10 +235,9 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd)
 		chunkbits = EROFS_CHUNK_FORMAT_BLKBITS_MASK + sbi->blkszbits;
 	chunksize = 1ULL << chunkbits;
 	count = DIV_ROUND_UP(inode->i_size, chunksize);
-	inode->u.chunkformat |= chunkbits - sbi->blkszbits;
+
 	if (multidev)
 		inode->u.chunkformat |= EROFS_CHUNK_FORMAT_INDEXES;
-
 	if (inode->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES)
 		unit = sizeof(struct erofs_inode_chunk_index);
 	else
@@ -222,8 +255,9 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd)
 	}
 	idx = inode->chunkindexes;
 
+	lastch = NULL;
+	minextblks = BLK_ROUND_UP(sbi, inode->i_size);
 	for (pos = 0; pos < inode->i_size; pos += len) {
-		struct erofs_blobchunk *chunk;
 #ifdef SEEK_DATA
 		off_t offset = lseek(fd, pos, SEEK_DATA);
 
@@ -247,6 +281,7 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd)
 				pos += chunksize;
 			} while (pos < offset);
 			DBG_BUGON(pos != offset);
+			lastch = NULL;
 			continue;
 		}
 #endif
@@ -263,11 +298,21 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd)
 			ret = PTR_ERR(chunk);
 			goto err;
 		}
+
+		if (lastch && (lastch->device_id != chunk->device_id ||
+		    erofs_pos(sbi, lastch->blkaddr) + lastch->chunksize !=
+		    erofs_pos(sbi, chunk->blkaddr))) {
+			lb = lowbit(pos >> sbi->blkszbits);
+			if (lb && lb < minextblks)
+				minextblks = lb;
+		}
 		*(void **)idx++ = chunk;
+		lastch = chunk;
 	}
 	inode->datalayout = EROFS_INODE_CHUNK_BASED;
 	free(chunkdata);
-	return 0;
+	return erofs_blob_mergechunks(inode, chunkbits,
+				      ilog2(minextblks) + sbi->blkszbits);
 err:
 	free(inode->chunkindexes);
 	inode->chunkindexes = NULL;
-- 
2.24.4

