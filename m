Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B23F75DA3D
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Jul 2023 07:40:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R7Fd23bpXz3c0n
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Jul 2023 15:40:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R7Fcx22SHz3bcD
	for <linux-erofs@lists.ozlabs.org>; Sat, 22 Jul 2023 15:40:16 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VnwjmDc_1690004409;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VnwjmDc_1690004409)
          by smtp.aliyun-inc.com;
          Sat, 22 Jul 2023 13:40:10 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: lib: fix erofs_iterate_dir() recursion
Date: Sat, 22 Jul 2023 13:40:09 +0800
Message-Id: <20230722054009.124119-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

ctx->dir may have changed when ctx is reused along erofs_iterate_dir()
recursion.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
changes since last version:
since traverse_dirents() can be called multiple times in one single
erofs_iterate_dir() call, ctx->dir may have changed at the entry of
traverse_dirents().  The previous v1 shall be deprecated.

v1: https://lore.kernel.org/all/20230718052101.124039-3-jefflexu@linux.alibaba.com/
---
 lib/dir.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/dir.c b/lib/dir.c
index abbf27a..535204b 100644
--- a/lib/dir.c
+++ b/lib/dir.c
@@ -5,6 +5,7 @@
 #include "erofs/dir.h"
 
 static int traverse_dirents(struct erofs_dir_context *ctx,
+			    struct erofs_inode *dir,
 			    void *dentry_blk, unsigned int lblk,
 			    unsigned int next_nameoff, unsigned int maxsize,
 			    bool fsck)
@@ -76,7 +77,7 @@ static int traverse_dirents(struct erofs_dir_context *ctx,
 					goto out;
 				}
 				ctx->flags |= EROFS_READDIR_DOTDOT_FOUND;
-				if (sbi.root_nid == ctx->dir->nid) {
+				if (sbi.root_nid == dir->nid) {
 					ctx->pnid = sbi.root_nid;
 					ctx->flags |= EROFS_READDIR_VALID_PNID;
 				}
@@ -95,7 +96,7 @@ static int traverse_dirents(struct erofs_dir_context *ctx,
 				}
 
 				ctx->flags |= EROFS_READDIR_DOT_FOUND;
-				if (fsck && ctx->de_nid != ctx->dir->nid) {
+				if (fsck && ctx->de_nid != dir->nid) {
 					errmsg = "corrupted `.' dirent";
 					goto out;
 				}
@@ -115,7 +116,7 @@ static int traverse_dirents(struct erofs_dir_context *ctx,
 out:
 	if (ret && !silent)
 		erofs_err("%s @ nid %llu, lblk %u, index %lu",
-			  errmsg, ctx->dir->nid | 0ULL, lblk,
+			  errmsg, dir->nid | 0ULL, lblk,
 			  (de - (struct erofs_dirent *)dentry_blk) | 0UL);
 	return ret;
 }
@@ -153,7 +154,7 @@ int erofs_iterate_dir(struct erofs_dir_context *ctx, bool fsck)
 				  nameoff, dir->nid | 0ULL, lblk);
 			return -EFSCORRUPTED;
 		}
-		err = traverse_dirents(ctx, buf, lblk, nameoff, maxsize, fsck);
+		err = traverse_dirents(ctx, dir, buf, lblk, nameoff, maxsize, fsck);
 		if (err)
 			break;
 		pos += maxsize;
-- 
1.8.3.1

