Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 126FC51DFC5
	for <lists+linux-erofs@lfdr.de>; Fri,  6 May 2022 21:46:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Kw1Kg389Dz3c9p
	for <lists+linux-erofs@lfdr.de>; Sat,  7 May 2022 05:46:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.42;
 helo=out30-42.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Kw1KW4xB6z3byY
 for <linux-erofs@lists.ozlabs.org>; Sat,  7 May 2022 05:46:39 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0VCTGrli_1651866393; 
Received: from
 e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0VCTGrli_1651866393) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 07 May 2022 03:46:34 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 3/3] erofs: refine on-disk definition comments
Date: Sat,  7 May 2022 03:46:12 +0800
Message-Id: <20220506194612.117120-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20220506194612.117120-1-hsiangkao@linux.alibaba.com>
References: <20220506194612.117120-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Fix some outdated comments and typos, hopefully helpful.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/erofs_fs.h | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 1238ca104f09..000fa2738974 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -79,15 +79,15 @@ struct erofs_super_block {
 
 /*
  * erofs inode datalayout (i_format in on-disk inode):
- * 0 - inode plain without inline data A:
+ * 0 - uncompressed flat inode without tail-packing inline data:
  * inode, [xattrs], ... | ... | no-holed data
- * 1 - inode VLE compression B (legacy):
- * inode, [xattrs], extents ... | ...
- * 2 - inode plain with inline data C:
- * inode, [xattrs], last_inline_data, ... | ... | no-holed data
- * 3 - inode compression D:
+ * 1 - compressed inode with non-compact indexes:
+ * inode, [xattrs], [map_header], extents ... | ...
+ * 2 - uncompressed flat inode with tail-packing inline data:
+ * inode, [xattrs], tailpacking data, ... | ... | no-holed data
+ * 3 - compressed inode with compact indexes:
  * inode, [xattrs], map_header, extents ... | ...
- * 4 - inode chunk-based E:
+ * 4 - chunk-based inode with (optional) multi-device support:
  * inode, [xattrs], chunk indexes ... | ...
  * 5~7 - reserved
  */
@@ -106,7 +106,7 @@ static inline bool erofs_inode_is_data_compressed(unsigned int datamode)
 		datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY;
 }
 
-/* bit definitions of inode i_advise */
+/* bit definitions of inode i_format */
 #define EROFS_I_VERSION_BITS            1
 #define EROFS_I_DATALAYOUT_BITS         3
 
@@ -140,8 +140,9 @@ struct erofs_inode_compact {
 	__le32 i_size;
 	__le32 i_reserved;
 	union {
-		/* file total compressed blocks for data mapping 1 */
+		/* total compressed blocks for compressed inodes */
 		__le32 compressed_blocks;
+		/* block address for uncompressed flat inodes */
 		__le32 raw_blkaddr;
 
 		/* for device files, used to indicate old/new device # */
@@ -156,9 +157,9 @@ struct erofs_inode_compact {
 	__le32 i_reserved2;
 };
 
-/* 32 bytes on-disk inode */
+/* 32-byte on-disk inode */
 #define EROFS_INODE_LAYOUT_COMPACT	0
-/* 64 bytes on-disk inode */
+/* 64-byte on-disk inode */
 #define EROFS_INODE_LAYOUT_EXTENDED	1
 
 /* 64-byte complete form of an ondisk inode */
@@ -171,8 +172,9 @@ struct erofs_inode_extended {
 	__le16 i_reserved;
 	__le64 i_size;
 	union {
-		/* file total compressed blocks for data mapping 1 */
+		/* total compressed blocks for compressed inodes */
 		__le32 compressed_blocks;
+		/* block address for uncompressed flat inodes */
 		__le32 raw_blkaddr;
 
 		/* for device files, used to indicate old/new device # */
@@ -365,17 +367,16 @@ enum {
 
 struct z_erofs_vle_decompressed_index {
 	__le16 di_advise;
-	/* where to decompress in the head cluster */
+	/* where to decompress in the head lcluster */
 	__le16 di_clusterofs;
 
 	union {
-		/* for the head cluster */
+		/* for the HEAD lclusters */
 		__le32 blkaddr;
 		/*
-		 * for the rest clusters
-		 * eg. for 4k page-sized cluster, maximum 4K*64k = 256M)
-		 * [0] - pointing to the head cluster
-		 * [1] - pointing to the tail cluster
+		 * for the NONHEAD lclusters
+		 * [0] - distance to its HEAD lcluster
+		 * [1] - distance to the next HEAD lcluster
 		 */
 		__le16 delta[2];
 	} di_u;
-- 
2.24.4

