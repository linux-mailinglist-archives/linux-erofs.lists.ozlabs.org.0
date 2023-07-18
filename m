Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 51969757319
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jul 2023 07:21:22 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R4nNw20YQz30K6
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jul 2023 15:21:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R4nNl2ZXTz303d
	for <linux-erofs@lists.ozlabs.org>; Tue, 18 Jul 2023 15:21:10 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VngOrRQ_1689657663;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VngOrRQ_1689657663)
          by smtp.aliyun-inc.com;
          Tue, 18 Jul 2023 13:21:04 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/4] erofs-utils: lib: fix recursive erofs_iterate_dir()
Date: Tue, 18 Jul 2023 13:20:59 +0800
Message-Id: <20230718052101.124039-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230718052101.124039-1-jefflexu@linux.alibaba.com>
References: <20230718052101.124039-1-jefflexu@linux.alibaba.com>
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
 lib/dir.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/dir.c b/lib/dir.c
index abbf27a..6758b8d 100644
--- a/lib/dir.c
+++ b/lib/dir.c
@@ -9,6 +9,7 @@ static int traverse_dirents(struct erofs_dir_context *ctx,
 			    unsigned int next_nameoff, unsigned int maxsize,
 			    bool fsck)
 {
+	struct erofs_inode *dir = ctx->dir;
 	struct erofs_dirent *de = dentry_blk;
 	const struct erofs_dirent *end = dentry_blk + next_nameoff;
 	const char *prev_name = NULL;
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
-- 
2.19.1.6.gb485710b

