Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE5F719AEC
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Jun 2023 13:24:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QX3g62vggz3dqm
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Jun 2023 21:24:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QX3g26jRmz3bZv
	for <linux-erofs@lists.ozlabs.org>; Thu,  1 Jun 2023 21:23:57 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vk5zEu._1685618622;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vk5zEu._1685618622)
          by smtp.aliyun-inc.com;
          Thu, 01 Jun 2023 19:23:50 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: fix compact 4B support for 16k block size
Date: Thu,  1 Jun 2023 19:23:41 +0800
Message-Id: <20230601112341.56960-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In compact 4B, two adjacent lclusters are packed together as a unit to
form on-disk indexes for effective random access, as below:

(amortized = 4, vcnt = 2)
       _____________________________________________
      |___@_____ encoded bits __________|_ blkaddr _|
      0        .                                    amortized * vcnt = 8
      .             .
      .                  .              amortized * vcnt - 4 = 4
      .                        .
      .____________________________.
      |_type (2 bits)_|_clusterofs_|

Therefore, encoded bits for each pack are 32 bits (4 bytes). IOWs,
since each lcluster can get 16 bits for its type and clusterofs, the
maximum supported lclustersize for compact 4B format is 16k (14 bits).

Fix this to enable compact 4B format for 16k lclusters (blocks), which
is tested on an arm64 server with 16k page size.

Fixes: 152a333a5895 ("staging: erofs: add compacted compression indexes support")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zmap.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index d37c5c89c728..920fb4dbc731 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -129,7 +129,7 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	u8 *in, type;
 	bool big_pcluster;
 
-	if (1 << amortizedshift == 4)
+	if (1 << amortizedshift == 4 && lclusterbits <= 14)
 		vcnt = 2;
 	else if (1 << amortizedshift == 2 && lclusterbits == 12)
 		vcnt = 16;
@@ -231,7 +231,6 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 {
 	struct inode *const inode = m->inode;
 	struct erofs_inode *const vi = EROFS_I(inode);
-	const unsigned int lclusterbits = vi->z_logical_clusterbits;
 	const erofs_off_t ebase = sizeof(struct z_erofs_map_header) +
 		ALIGN(erofs_iloc(inode) + vi->inode_isize + vi->xattr_isize, 8);
 	unsigned int totalidx = erofs_iblks(inode);
@@ -239,9 +238,6 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	unsigned int amortizedshift;
 	erofs_off_t pos;
 
-	if (lclusterbits != 12)
-		return -EOPNOTSUPP;
-
 	if (lcn >= totalidx)
 		return -EINVAL;
 
-- 
2.24.4

