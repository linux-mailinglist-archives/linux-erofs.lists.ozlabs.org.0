Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C9F6A5F13
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Feb 2023 19:55:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PR64k068mz3cBX
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Mar 2023 05:55:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PR64d3gS5z3c1K
	for <linux-erofs@lists.ozlabs.org>; Wed,  1 Mar 2023 05:55:12 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VckM4QW_1677610507;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VckM4QW_1677610507)
          by smtp.aliyun-inc.com;
          Wed, 01 Mar 2023 02:55:08 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/3] erofs-utils: use compressed pclusters to mark fragments
Date: Wed,  1 Mar 2023 02:54:58 +0800
Message-Id: <20230228185459.117762-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230228185459.117762-1-hsiangkao@linux.alibaba.com>
References: <20230228185459.117762-1-hsiangkao@linux.alibaba.com>
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

The decoded lengths of uncompressed pclusters should be
strictly no more than encoded lengths.

Fixes: 9fa9b017f773 ("erofs-utils: mkfs: support fragments")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 0aaec30..8169990 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -95,7 +95,7 @@ static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
 		 * A lcluster cannot have three parts with the middle one which
 		 * is well-compressed for !ztailpacking cases.
 		 */
-		DBG_BUGON(!ctx->e.raw && !cfg.c_ztailpacking);
+		DBG_BUGON(!ctx->e.raw && !cfg.c_ztailpacking && !cfg.c_fragments);
 		DBG_BUGON(ctx->e.partial);
 		type = ctx->e.raw ? Z_EROFS_VLE_CLUSTER_TYPE_PLAIN :
 			Z_EROFS_VLE_CLUSTER_TYPE_HEAD;
@@ -457,7 +457,7 @@ frag_packing:
 			if (ret < 0)
 				return ret;
 			ctx->e.compressedblks = 0; /* indicate a fragment */
-			ctx->e.raw = true;
+			ctx->e.raw = false;
 			ctx->fragemitted = true;
 			fix_dedupedfrag = false;
 		/* tailpcluster should be less than 1 block */
@@ -928,7 +928,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 		z_erofs_write_indexes(&ctx);
 		ctx.e.length = inode->fragment_size;
 		ctx.e.compressedblks = 0;
-		ctx.e.raw = true;
+		ctx.e.raw = false;
 		ctx.e.partial = false;
 		ctx.e.blkaddr = ctx.blkaddr;
 	}
-- 
2.36.1

