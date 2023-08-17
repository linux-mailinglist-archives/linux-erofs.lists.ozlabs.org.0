Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4758677F21C
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Aug 2023 10:28:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RRJ7R1gMcz3cN7
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Aug 2023 18:28:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RRJ744DHcz2ytV
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Aug 2023 18:28:32 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vpz9R2H_1692260907;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vpz9R2H_1692260907)
          by smtp.aliyun-inc.com;
          Thu, 17 Aug 2023 16:28:28 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 6/8] erofs: get rid of fe->backmost for cache decompression
Date: Thu, 17 Aug 2023 16:28:11 +0800
Message-Id: <20230817082813.81180-6-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
References: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
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

EROFS_MAP_FULL_MAPPED is more accurate to decide if caching the last
incomplete pcluster for later read or not.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 4009283944ca..c28945532a02 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -528,8 +528,6 @@ struct z_erofs_decompress_frontend {
 	z_erofs_next_pcluster_t owned_head;
 	enum z_erofs_pclustermode mode;
 
-	/* used for applying cache strategy on the fly */
-	bool backmost;
 	erofs_off_t headoffset;
 
 	/* a pointer used to pick up inplace I/O pages */
@@ -538,7 +536,7 @@ struct z_erofs_decompress_frontend {
 
 #define DECOMPRESS_FRONTEND_INIT(__i) { \
 	.inode = __i, .owned_head = Z_EROFS_PCLUSTER_TAIL, \
-	.mode = Z_EROFS_PCLUSTER_FOLLOWED, .backmost = true }
+	.mode = Z_EROFS_PCLUSTER_FOLLOWED }
 
 static bool z_erofs_should_alloc_cache(struct z_erofs_decompress_frontend *fe)
 {
@@ -547,7 +545,7 @@ static bool z_erofs_should_alloc_cache(struct z_erofs_decompress_frontend *fe)
 	if (cachestrategy <= EROFS_ZIP_CACHE_DISABLED)
 		return false;
 
-	if (fe->backmost)
+	if (!(fe->map.m_flags & EROFS_MAP_FULL_MAPPED))
 		return true;
 
 	if (cachestrategy >= EROFS_ZIP_CACHE_READAROUND &&
@@ -939,7 +937,6 @@ static void z_erofs_pcluster_end(struct z_erofs_decompress_frontend *fe)
 		erofs_workgroup_put(&pcl->obj);
 
 	fe->pcl = NULL;
-	fe->backmost = false;
 }
 
 static int z_erofs_read_fragment(struct super_block *sb, struct page *page,
-- 
2.24.4

