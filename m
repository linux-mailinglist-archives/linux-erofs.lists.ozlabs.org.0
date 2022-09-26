Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 079595EAADB
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Sep 2022 17:25:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MbmmM06QWz3bmC
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Sep 2022 01:25:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mbmm81jNdz3bSV
	for <linux-erofs@lists.ozlabs.org>; Tue, 27 Sep 2022 01:25:26 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VQoJOK0_1664205920;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VQoJOK0_1664205920)
          by smtp.aliyun-inc.com;
          Mon, 26 Sep 2022 23:25:21 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/8] erofs-utils: fuse: support interlaced uncompressed pcluster
Date: Mon, 26 Sep 2022 23:25:04 +0800
Message-Id: <20220926152511.94832-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20220926152511.94832-1-hsiangkao@linux.alibaba.com>
References: <20220926152511.94832-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Yue Hu <huyue2@coolpad.com>, Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

Support uncompressed data layout with on-disk interlaced offset in
compression mode for erofsfuse.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/decompress.h |  3 +++
 include/erofs/internal.h   |  1 +
 include/erofs_fs.h         |  2 ++
 lib/data.c                 |  7 ++++++-
 lib/decompress.c           | 19 ++++++++++++++++---
 lib/zmap.c                 | 12 +++++++++---
 6 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/include/erofs/decompress.h b/include/erofs/decompress.h
index 82bf7b8..a9067cb 100644
--- a/include/erofs/decompress.h
+++ b/include/erofs/decompress.h
@@ -23,6 +23,9 @@ struct z_erofs_decompress_req {
 	unsigned int decodedskip;
 	unsigned int inputsize, decodedlength;
 
+	/* cut point of interlaced uncompressed data */
+	unsigned int interlaced_offset;
+
 	/* indicate the algorithm will be used for decompression */
 	unsigned int alg;
 	bool partial_decoding;
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 2e0aae8..a4a1fe3 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -311,6 +311,7 @@ struct erofs_map_blocks {
 
 enum {
 	Z_EROFS_COMPRESSION_SHIFTED = Z_EROFS_COMPRESSION_MAX,
+	Z_EROFS_COMPRESSION_INTERLACED,
 	Z_EROFS_COMPRESSION_RUNTIME_MAX
 };
 
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 08f9761..b8a7421 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -294,11 +294,13 @@ struct z_erofs_lzma_cfgs {
  * bit 1 : HEAD1 big pcluster (0 - off; 1 - on)
  * bit 2 : HEAD2 big pcluster (0 - off; 1 - on)
  * bit 3 : tailpacking inline pcluster (0 - off; 1 - on)
+ * bit 4 : interlaced plain pcluster (0 - off; 1 - on)
  */
 #define Z_EROFS_ADVISE_COMPACTED_2B		0x0001
 #define Z_EROFS_ADVISE_BIG_PCLUSTER_1		0x0002
 #define Z_EROFS_ADVISE_BIG_PCLUSTER_2		0x0004
 #define Z_EROFS_ADVISE_INLINE_PCLUSTER		0x0008
+#define Z_EROFS_ADVISE_INTERLACED_PCLUSTER	0x0010
 
 struct z_erofs_map_header {
 	__le16	h_reserved1;
diff --git a/lib/data.c b/lib/data.c
index ad7b2cb..af52fde 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -226,7 +226,7 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 	};
 	struct erofs_map_dev mdev;
 	bool partial;
-	unsigned int bufsize = 0;
+	unsigned int bufsize = 0, interlaced_offset;
 	char *raw = NULL;
 	int ret = 0;
 
@@ -287,10 +287,15 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 		if (ret < 0)
 			break;
 
+		interlaced_offset = 0;
+		if (map.m_algorithmformat == Z_EROFS_COMPRESSION_INTERLACED)
+			interlaced_offset = erofs_blkoff(map.m_la);
+
 		ret = z_erofs_decompress(&(struct z_erofs_decompress_req) {
 					.in = raw,
 					.out = buffer + end - offset,
 					.decodedskip = skip,
+					.interlaced_offset = interlaced_offset,
 					.inputsize = map.m_plen,
 					.decodedlength = length,
 					.alg = map.m_algorithmformat,
diff --git a/lib/decompress.c b/lib/decompress.c
index 1661f91..14e91b2 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -131,13 +131,26 @@ out:
 
 int z_erofs_decompress(struct z_erofs_decompress_req *rq)
 {
-	if (rq->alg == Z_EROFS_COMPRESSION_SHIFTED) {
-		if (rq->inputsize > EROFS_BLKSIZ)
-			return -EFSCORRUPTED;
+	if (rq->alg == Z_EROFS_COMPRESSION_INTERLACED) {
+		unsigned int count, rightpart, skip;
+
+		/* XXX: should support inputsize >= EROFS_BLKSIZ later */
+                if (rq->inputsize > EROFS_BLKSIZ)
+                        return -EFSCORRUPTED;
 
 		DBG_BUGON(rq->decodedlength > EROFS_BLKSIZ);
 		DBG_BUGON(rq->decodedlength < rq->decodedskip);
+		count = rq->decodedlength - rq->decodedskip;
+		skip = erofs_blkoff(rq->interlaced_offset + rq->decodedskip);
+		rightpart = min(EROFS_BLKSIZ - skip, count);
+		memcpy(rq->out, rq->in + skip, rightpart);
+		memcpy(rq->out + rightpart, rq->in, count - rightpart);
+		return 0;
+	} else if (rq->alg == Z_EROFS_COMPRESSION_SHIFTED) {
+		if (rq->decodedlength > rq->inputsize)
+			return -EFSCORRUPTED;
 
+		DBG_BUGON(rq->decodedlength < rq->decodedskip);
 		memcpy(rq->out, rq->in + rq->decodedskip,
 		       rq->decodedlength - rq->decodedskip);
 		return 0;
diff --git a/lib/zmap.c b/lib/zmap.c
index abe0d31..806d608 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -616,10 +616,16 @@ static int z_erofs_do_map_blocks(struct erofs_inode *vi,
 			goto out;
 	}
 
-	if (m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN)
-		map->m_algorithmformat = Z_EROFS_COMPRESSION_SHIFTED;
-	else
+	if (m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN) {
+		if (vi->z_advise & Z_EROFS_ADVISE_INTERLACED_PCLUSTER)
+			map->m_algorithmformat =
+				Z_EROFS_COMPRESSION_INTERLACED;
+		else
+			map->m_algorithmformat =
+				Z_EROFS_COMPRESSION_SHIFTED;
+	} else {
 		map->m_algorithmformat = vi->z_algorithmtype[0];
+	}
 
 	if (flags & EROFS_GET_BLOCKS_FIEMAP) {
 		err = z_erofs_get_extent_decompressedlen(&m);
-- 
2.24.4

