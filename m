Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 329B082DC08
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Jan 2024 16:06:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TDFpB18Ppz3bhc
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jan 2024 02:06:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TDFp43vXHz2ytJ
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Jan 2024 02:06:02 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W-j7XYN_1705331151;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W-j7XYN_1705331151)
          by smtp.aliyun-inc.com;
          Mon, 15 Jan 2024 23:05:56 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: lib: use dummy_pivot to dedupe the beginnings of files
Date: Mon, 15 Jan 2024 23:05:50 +0800
Message-Id: <20240115150550.1961455-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The beginnings of files are incorrectly skipped for deduplication, which
causes unexpected image size regression. Fix it.

Reported-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Fixes: 8ead5f8bd38c ("erofs-utils: lib: generate compression indexes in memory first")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/compress.c b/lib/compress.c
index 8f61f92..22782cb 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -200,9 +200,16 @@ static bool z_erofs_need_refill(struct z_erofs_vle_compress_ctx *ctx)
 	return true;
 }
 
+static struct z_erofs_extent_item dummy_pivot = {
+	.e.length = 0
+};
+
 static void z_erofs_commit_extent(struct z_erofs_vle_compress_ctx *ctx,
 				  struct z_erofs_extent_item *ei)
 {
+	if (ei == &dummy_pivot)
+		return;
+
 	list_add_tail(&ei->list, &ctx->extents);
 	ctx->clusterofs = (ctx->clusterofs + ei->e.length) &
 			(erofs_blksiz(ctx->inode->sbi) - 1);
@@ -980,7 +987,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 	ctx.metacur = compressmeta + Z_EROFS_LEGACY_MAP_HEADER_SIZE;
 	ctx.head = ctx.tail = 0;
 	ctx.clusterofs = 0;
-	ctx.pivot = NULL;
+	ctx.pivot = &dummy_pivot;
 	init_list_head(&ctx.extents);
 	ctx.remaining = inode->i_size - inode->fragment_size;
 	ctx.fix_dedupedfrag = false;
-- 
2.39.3

