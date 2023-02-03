Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB2F688E40
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Feb 2023 04:53:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4P7MFS0n0kz3f6y
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Feb 2023 14:53:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4P7MFJ6Zjqz3bT0
	for <linux-erofs@lists.ozlabs.org>; Fri,  3 Feb 2023 14:53:08 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VanENqc_1675396384;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VanENqc_1675396384)
          by smtp.aliyun-inc.com;
          Fri, 03 Feb 2023 11:53:05 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org,
	huyue2@coolpad.com
Subject: [PATCH 2/3] erofs: remove unused flags parameter of erofs_map_blocks()
Date: Fri,  3 Feb 2023 11:53:02 +0800
Message-Id: <20230203035303.35082-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230203035303.35082-1-jefflexu@linux.alibaba.com>
References: <20230203035303.35082-1-jefflexu@linux.alibaba.com>
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
argument is always EROFS_GET_BLOCKS_RAW, as the compression routine
implements its own map_blocks() variant.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/data.c     | 14 ++++++--------
 fs/erofs/fscache.c  |  4 ++--
 fs/erofs/internal.h |  5 ++---
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index f57f921683d7..32e66d29968f 100644
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
@@ -117,8 +116,7 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
 	return 0;
 }
 
-int erofs_map_blocks(struct inode *inode,
-		     struct erofs_map_blocks *map, int flags)
+int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
 {
 	struct super_block *sb = inode->i_sb;
 	struct erofs_inode *vi = EROFS_I(inode);
@@ -130,7 +128,7 @@ int erofs_map_blocks(struct inode *inode,
 	void *kaddr;
 	int err = 0;
 
-	trace_erofs_map_blocks_enter(inode, map, flags);
+	trace_erofs_map_blocks_enter(inode, map, EROFS_GET_BLOCKS_RAW);
 	map->m_deviceid = 0;
 	if (map->m_la >= inode->i_size) {
 		/* leave out-of-bound access unmapped */
@@ -140,7 +138,7 @@ int erofs_map_blocks(struct inode *inode,
 	}
 
 	if (vi->datalayout != EROFS_INODE_CHUNK_BASED) {
-		err = erofs_map_blocks_flatmode(inode, map, flags);
+		err = erofs_map_blocks_flatmode(inode, map);
 		goto out;
 	}
 
@@ -192,7 +190,7 @@ int erofs_map_blocks(struct inode *inode,
 out:
 	if (!err)
 		map->m_llen = map->m_plen;
-	trace_erofs_map_blocks_exit(inode, map, flags, 0);
+	trace_erofs_map_blocks_exit(inode, map, EROFS_GET_BLOCKS_RAW, err);
 	return err;
 }
 
@@ -255,7 +253,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	map.m_la = offset;
 	map.m_llen = length;
 
-	ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
+	ret = erofs_map_blocks(inode, &map);
 	if (ret < 0)
 		return ret;
 
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index d47b04dfdc48..7f1ef2ffc4db 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -229,7 +229,7 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_request *primary)
 	int ret;
 
 	map.m_la = pos;
-	ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
+	ret = erofs_map_blocks(inode, &map);
 	if (ret)
 		return ret;
 
@@ -377,7 +377,7 @@ static int erofs_fscache_share_file_open(struct inode *inode, struct file *filp)
 	struct file *realfile;
 	int ret;
 
-	ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
+	ret = erofs_map_blocks(inode, &map);
 	if (ret)
 		return ret;
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index a63a9e951fe0..323c2c775023 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -445,7 +445,7 @@ struct erofs_map_blocks {
 	unsigned int m_flags;
 };
 
-/* Flags used by erofs_map_blocks_flatmode() */
+/* Used to map raw data */
 #define EROFS_GET_BLOCKS_RAW    0x0001
 /*
  * Used to get the exact decompressed length, e.g. fiemap (consider lookback
@@ -502,8 +502,7 @@ void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
 int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *dev);
 int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		 u64 start, u64 len);
-int erofs_map_blocks(struct inode *inode,
-		     struct erofs_map_blocks *map, int flags);
+int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map);
 
 /* inode.c */
 static inline unsigned long erofs_inode_hash(erofs_nid_t nid)
-- 
2.19.1.6.gb485710b

