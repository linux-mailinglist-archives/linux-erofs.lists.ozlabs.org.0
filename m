Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F0241458E
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Sep 2021 11:52:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HDtr72Pz2z2ygC
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Sep 2021 19:52:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133;
 helo=out30-133.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HDtqz0yKlz2yWG
 for <linux-erofs@lists.ozlabs.org>; Wed, 22 Sep 2021 19:52:09 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R941e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0UpDev3j_1632304305; 
Received: from
 e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UpDev3j_1632304305) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 22 Sep 2021 17:51:52 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
 Liu Bo <bo.liu@linux.alibaba.com>
Subject: [PATCH] erofs: fix misbehavior of unsupported chunk format check
Date: Wed, 22 Sep 2021 17:51:41 +0800
Message-Id: <20210922095141.233938-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Unsupported chunk format should be checked with
"if (vi->chunkformat & ~EROFS_CHUNK_FORMAT_ALL)"

Found when checking with 4k-byte blockmap (although currently mkfs
uses inode chunk indexes format by default.)

Fixes: c5aa903a59db ("erofs: support reading chunk-based uncompressed files")
Cc: Liu Bo <bo.liu@linux.alibaba.com>
Cc: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 31ac3a7..a552399 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -176,7 +176,7 @@ static struct page *erofs_read_inode(struct inode *inode,
 	}
 
 	if (vi->datalayout == EROFS_INODE_CHUNK_BASED) {
-		if (!(vi->chunkformat & EROFS_CHUNK_FORMAT_ALL)) {
+		if (vi->chunkformat & ~EROFS_CHUNK_FORMAT_ALL) {
 			erofs_err(inode->i_sb,
 				  "unsupported chunk format %x of nid %llu",
 				  vi->chunkformat, vi->nid);
-- 
1.8.3.1

