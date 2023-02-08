Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B60068EDEE
	for <lists+linux-erofs@lfdr.de>; Wed,  8 Feb 2023 12:29:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PBd7X6644z3cgV
	for <lists+linux-erofs@lfdr.de>; Wed,  8 Feb 2023 22:29:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PBd7R04ZNz2xKj
	for <linux-erofs@lists.ozlabs.org>; Wed,  8 Feb 2023 22:29:22 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VbBvrhq_1675855756;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VbBvrhq_1675855756)
          by smtp.aliyun-inc.com;
          Wed, 08 Feb 2023 19:29:16 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org,
	huyue2@coolpad.com
Subject: [PATCH v2 2/2] erofs: remove unused EROFS_GET_BLOCKS_RAW flag
Date: Wed,  8 Feb 2023 19:29:15 +0800
Message-Id: <20230208112915.6543-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230208112915.6543-1-jefflexu@linux.alibaba.com>
References: <20230208112915.6543-1-jefflexu@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

For erofs_map_blocks() and erofs_map_blocks_flatmode(), the flags
argument is always EROFS_GET_BLOCKS_RAW.  Thus remove the unused flags
parameter for these two functions.

Besides EROFS_GET_BLOCKS_RAW is originally introduced for reading
compressed (raw) data for compressed files.  However it's never used
actually and let's remove it now.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/data.c     | 14 ++++++--------
 fs/erofs/fscache.c  |  2 +-
 fs/erofs/internal.h | 10 ++++------
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 2713257ee718..032e12dccb84 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -74,8 +74,7 @@ void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
 }
 
 static int erofs_map_blocks_flatmode(struct inode *inode,
-				     struct erofs_map_blocks *map,
-				     int flags)
+				     struct erofs_map_blocks *map)
 {
 	erofs_blk_t nblocks, lastblk;
 	u64 offset = map->m_la;
@@ -114,8 +113,7 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
 	return 0;
 }
 
-int erofs_map_blocks(struct inode *inode,
-		     struct erofs_map_blocks *map, int flags)
+int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
 {
 	struct super_block *sb = inode->i_sb;
 	struct erofs_inode *vi = EROFS_I(inode);
@@ -127,7 +125,7 @@ int erofs_map_blocks(struct inode *inode,
 	void *kaddr;
 	int err = 0;
 
-	trace_erofs_map_blocks_enter(inode, map, flags);
+	trace_erofs_map_blocks_enter(inode, map, 0);
 	map->m_deviceid = 0;
 	if (map->m_la >= inode->i_size) {
 		/* leave out-of-bound access unmapped */
@@ -137,7 +135,7 @@ int erofs_map_blocks(struct inode *inode,
 	}
 
 	if (vi->datalayout != EROFS_INODE_CHUNK_BASED) {
-		err = erofs_map_blocks_flatmode(inode, map, flags);
+		err = erofs_map_blocks_flatmode(inode, map);
 		goto out;
 	}
 
@@ -189,7 +187,7 @@ int erofs_map_blocks(struct inode *inode,
 out:
 	if (!err)
 		map->m_llen = map->m_plen;
-	trace_erofs_map_blocks_exit(inode, map, flags, 0);
+	trace_erofs_map_blocks_exit(inode, map, 0, err);
 	return err;
 }
 
@@ -252,7 +250,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	map.m_la = offset;
 	map.m_llen = length;
 
-	ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
+	ret = erofs_map_blocks(inode, &map);
 	if (ret < 0)
 		return ret;
 
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 03de4dc99302..9658cf8689d9 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -197,7 +197,7 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_request *primary)
 	int ret;
 
 	map.m_la = pos;
-	ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
+	ret = erofs_map_blocks(inode, &map);
 	if (ret)
 		return ret;
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 48a2f33de15a..8a6ae820cd6d 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -401,16 +401,15 @@ struct erofs_map_blocks {
 	unsigned int m_flags;
 };
 
-#define EROFS_GET_BLOCKS_RAW    0x0001
 /*
  * Used to get the exact decompressed length, e.g. fiemap (consider lookback
  * approach instead if possible since it's more metadata lightweight.)
  */
-#define EROFS_GET_BLOCKS_FIEMAP	0x0002
+#define EROFS_GET_BLOCKS_FIEMAP		0x0001
 /* Used to map the whole extent if non-negligible data is requested for LZMA */
-#define EROFS_GET_BLOCKS_READMORE	0x0004
+#define EROFS_GET_BLOCKS_READMORE	0x0002
 /* Used to map tail extent for tailpacking inline or fragment pcluster */
-#define EROFS_GET_BLOCKS_FINDTAIL	0x0008
+#define EROFS_GET_BLOCKS_FINDTAIL	0x0004
 
 enum {
 	Z_EROFS_COMPRESSION_SHIFTED = Z_EROFS_COMPRESSION_MAX,
@@ -458,8 +457,7 @@ void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
 int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *dev);
 int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		 u64 start, u64 len);
-int erofs_map_blocks(struct inode *inode,
-		     struct erofs_map_blocks *map, int flags);
+int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map);
 struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid);
 int erofs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		  struct kstat *stat, u32 request_mask,
-- 
2.19.1.6.gb485710b

