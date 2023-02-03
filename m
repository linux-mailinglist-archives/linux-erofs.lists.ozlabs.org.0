Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A01688E42
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Feb 2023 04:53:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4P7MFW5wFPz3f5b
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Feb 2023 14:53:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4P7MFL0TQRz3f5k
	for <linux-erofs@lists.ozlabs.org>; Fri,  3 Feb 2023 14:53:09 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Van4Hcy_1675396385;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Van4Hcy_1675396385)
          by smtp.aliyun-inc.com;
          Fri, 03 Feb 2023 11:53:06 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org,
	huyue2@coolpad.com
Subject: [PATCH 3/3] erofs: call erofs_map_dev() inside erofs_map_blocks()
Date: Fri,  3 Feb 2023 11:53:03 +0800
Message-Id: <20230203035303.35082-4-jefflexu@linux.alibaba.com>
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

For now erofs_map_blocks() is always followed by erofs_map_dev().
Make erofs_map_dev() called inside erofs_map_blocks() to reduce code
duplication.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/data.c     | 21 ++++++++++-----------
 fs/erofs/fscache.c  | 20 ++------------------
 fs/erofs/internal.h |  3 ++-
 3 files changed, 14 insertions(+), 30 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 32e66d29968f..cbe7a6d6846d 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -116,7 +116,8 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
 	return 0;
 }
 
-int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
+int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map,
+		     struct erofs_map_dev *mdev)
 {
 	struct super_block *sb = inode->i_sb;
 	struct erofs_inode *vi = EROFS_I(inode);
@@ -188,8 +189,14 @@ int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
 out_unlock:
 	erofs_put_metabuf(&buf);
 out:
-	if (!err)
+	if (!err) {
 		map->m_llen = map->m_plen;
+		*mdev = (struct erofs_map_dev) {
+			.m_deviceid = map->m_deviceid,
+			.m_pa = map->m_pa,
+		};
+		err = erofs_map_dev(sb, mdev);
+	}
 	trace_erofs_map_blocks_exit(inode, map, EROFS_GET_BLOCKS_RAW, err);
 	return err;
 }
@@ -253,15 +260,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	map.m_la = offset;
 	map.m_llen = length;
 
-	ret = erofs_map_blocks(inode, &map);
-	if (ret < 0)
-		return ret;
-
-	mdev = (struct erofs_map_dev) {
-		.m_deviceid = map.m_deviceid,
-		.m_pa = map.m_pa,
-	};
-	ret = erofs_map_dev(inode->i_sb, &mdev);
+	ret = erofs_map_blocks(inode, &map, &mdev);
 	if (ret)
 		return ret;
 
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 7f1ef2ffc4db..140ccacc1043 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -229,7 +229,7 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_request *primary)
 	int ret;
 
 	map.m_la = pos;
-	ret = erofs_map_blocks(inode, &map);
+	ret = erofs_map_blocks(inode, &map, &mdev);
 	if (ret)
 		return ret;
 
@@ -270,14 +270,6 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_request *primary)
 	count = min_t(size_t, map.m_llen - (pos - map.m_la), count);
 	DBG_BUGON(!count || count % PAGE_SIZE);
 
-	mdev = (struct erofs_map_dev) {
-		.m_deviceid = map.m_deviceid,
-		.m_pa = map.m_pa,
-	};
-	ret = erofs_map_dev(sb, &mdev);
-	if (ret)
-		return ret;
-
 	req = erofs_fscache_req_chain(primary, count);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
@@ -377,15 +369,7 @@ static int erofs_fscache_share_file_open(struct inode *inode, struct file *filp)
 	struct file *realfile;
 	int ret;
 
-	ret = erofs_map_blocks(inode, &map);
-	if (ret)
-		return ret;
-
-	mdev = (struct erofs_map_dev) {
-		.m_deviceid = map.m_deviceid,
-		.m_pa = map.m_pa,
-	};
-	ret = erofs_map_dev(inode->i_sb, &mdev);
+	ret = erofs_map_blocks(inode, &map, &mdev);
 	if (ret)
 		return ret;
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 323c2c775023..c54dec32a868 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -502,7 +502,8 @@ void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
 int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *dev);
 int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		 u64 start, u64 len);
-int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map);
+int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map,
+		     struct erofs_map_dev *mdev);
 
 /* inode.c */
 static inline unsigned long erofs_inode_hash(erofs_nid_t nid)
-- 
2.19.1.6.gb485710b

